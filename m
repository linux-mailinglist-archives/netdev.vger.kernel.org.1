Return-Path: <netdev+bounces-37963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E47B80A7
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 81CAA281325
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801114290;
	Wed,  4 Oct 2023 13:19:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEE1400D;
	Wed,  4 Oct 2023 13:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39850C433C7;
	Wed,  4 Oct 2023 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696425584;
	bh=bhclEsddtPiCxtYvFgBUs63/P/GoHLqamR5MHHrkOGs=;
	h=Date:From:To:Cc:Subject:From;
	b=eVTuL3hok71ptrABuk/GXY5dSnBMUIKIyxTpnstpH8KlEo3/1n+GA9pCZ+P8NioaB
	 psPOxIbZ4ATGY7Rje6IKtCBcGebBP9mM1GJVfeEgXh2L3epgTG+wZAa5HF14Wh4VZV
	 HMriNU1ynrdrLKC6RMJY8C3llX6ylefeuA0w03lNzJtERXE87MbWAz4NPMlrOURBqP
	 64Cu/tLWsjFM+6kC2Nber7j6EwoCpYrYdqCYTYp5cmWJSpn+fAi6vZT8KCxfGDD+gG
	 PMH0Lkdi59RLj9f8MAJ9hx2l919azOpWDb4JNwBZ+WyVLihiNDpEWosfqgkY6f7SVd
	 k0m7kvHd+8zLw==
Date: Wed, 4 Oct 2023 15:19:37 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] net: sched: cls_u32: Fix allocation size in u32_init()
Message-ID: <ZR1maZoAh2W/0Vw6@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

commit d61491a51f7e ("net/sched: cls_u32: Replace one-element array
with flexible-array member") incorrecly replaced an instance of
`sizeof(*tp_c)` with `struct_size(tp_c, hlist->ht, 1)`. This results
in a an over-allocation of 8 bytes.

This change is wrong because `hlist` in `struct tc_u_common` is a
pointer:

net/sched/cls_u32.c:
struct tc_u_common {
        struct tc_u_hnode __rcu *hlist;
        void                    *ptr;
        int                     refcnt;
        struct idr              handle_idr;
        struct hlist_node       hnode;
        long                    knodes;
};

So, the use of `struct_size()` makes no sense: we don't need to allocate
any extra space for a flexible-array member. `sizeof(*tp_c)` is just fine.

So, `struct_size(tp_c, hlist->ht, 1)` translates to:

sizeof(*tp_c) + sizeof(tp_c->hlist->ht) ==
sizeof(struct tc_u_common) + sizeof(struct tc_u_knode *) ==
						144 + 8  == 0x98 (byes)
						     ^^^
						      |
						unnecessary extra
						allocation size

$ pahole -C tc_u_common net/sched/cls_u32.o
struct tc_u_common {
	struct tc_u_hnode *        hlist;                /*     0     8 */
	void *                     ptr;                  /*     8     8 */
	int                        refcnt;               /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	struct idr                 handle_idr;           /*    24    96 */
	/* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
	struct hlist_node          hnode;                /*   120    16 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	long int                   knodes;               /*   136     8 */

	/* size: 144, cachelines: 3, members: 6 */
	/* sum members: 140, holes: 1, sum holes: 4 */
	/* last cacheline: 16 bytes */
};

And with `sizeof(*tp_c)`, we have:

	sizeof(*tp_c) == sizeof(struct tc_u_common) == 144 == 0x90 (bytes)

which is the correct and original allocation size.

Fix this issue by replacing `struct_size(tp_c, hlist->ht, 1)` with
`sizeof(*tp_c)`, and avoid allocating 8 too many bytes.

The following difference in binary output is expected and reflects the
desired change:

| net/sched/cls_u32.o
| @@ -6148,7 +6148,7 @@
| include/linux/slab.h:599
|     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
|                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
|-    2cfc:      mov    $0x98,%edx
|+    2cfc:      mov    $0x90,%edx

Reported-by: Alejandro Colomar <alx@kernel.org>
Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update subject line.
 - Update changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZN5DvRyq6JNz20l1@work/

 net/sched/cls_u32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index da4c179a4d41..6663e971a13e 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -366,7 +366,7 @@ static int u32_init(struct tcf_proto *tp)
 	idr_init(&root_ht->handle_idr);
 
 	if (tp_c == NULL) {
-		tp_c = kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KERNEL);
+		tp_c = kzalloc(sizeof(*tp_c), GFP_KERNEL);
 		if (tp_c == NULL) {
 			kfree(root_ht);
 			return -ENOBUFS;
-- 
2.34.1


