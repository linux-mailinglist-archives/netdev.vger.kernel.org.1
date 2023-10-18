Return-Path: <netdev+bounces-42261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19C7CDE86
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334CDB20D5F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750A37171;
	Wed, 18 Oct 2023 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz7ibN8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AD36B1A
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE0FC433CC;
	Wed, 18 Oct 2023 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638346;
	bh=DpBF6ZbRwFLOmgLcUNEs8T24t3r9g/7TPEYW9l39YVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dz7ibN8vD+Cq8G49IWI6ydnOxtV0e5f8K3CHVyJHm7A0gIGMcNeYWr9oIRgBAoX60
	 FywNVoQAXhuaExydzbn7brd9w3xnwyL2/fy1ejD+Dqqp79fX6dQgY/LAitsqi6rkmM
	 Hh9reWMsTYG8LUSH4TrbD7PmGS5o/bN0lLymTWsXBnVAqx2QqgtoIRvSRzgiha/loo
	 H/Lj8Lp0UnLW63GM2AfKYGR2eXcETpedWt2S9jPNfshgQpsYJmJz6ZcrdrIsdy8pLp
	 gf5edkG5pLx8WYJ/gf/dpO6QnD7A2F8rqUltGgMdkQeC3JQ6/wf4utnx1hrO7aW+N/
	 7D7xinGvyhx8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 14/31] net: sched: cls_u32: Fix allocation size in u32_init()
Date: Wed, 18 Oct 2023 10:11:31 -0400
Message-Id: <20231018141151.1334501-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit c4d49196ceec80e30e8d981410d73331b49b7850 ]

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
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_u32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index da4c179a4d418..6663e971a13e7 100644
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
2.40.1


