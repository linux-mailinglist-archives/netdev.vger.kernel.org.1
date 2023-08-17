Return-Path: <netdev+bounces-28524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76477FB51
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315672820D5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8915ADC;
	Thu, 17 Aug 2023 15:57:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0B1549E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378FFC433C8;
	Thu, 17 Aug 2023 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692287873;
	bh=T9o5S2GdvkG2Pkc/OLCddeweqtUCQ0WPfudrDdceg1s=;
	h=Date:From:To:Cc:Subject:From;
	b=Gt5eHu+Ndh/lS1IVgtLL91xVN7xhH/tg7qHdYI6uQkE1IxtHDI1scE4YIHcVmGOYz
	 o2YaERDl6Eh66CquI4XgLi9PJI586oHgtxe7ZyPU2/pBH52DBqcoTQWgnDXIcuqBM8
	 n6kAM/JwNOXSppcFrxZ29W2DAnQAmGhgLxxD7I5f69WrMryWEHVjWwIKxFb8QP1Xmw
	 /fqWupE9fp2DvqRcIOqus7Vx41GMUtAJ0mY8U03wjm4faO+BP6ENY6P+OgoxUqOGOL
	 vgySyObxhwDV1uPQ8nDVkLElPUNfNe4cdYQLH5wmDj/0QRLNT0XBAXHbi0JY4u9n6E
	 3DZbICpoYfGwg==
Date: Thu, 17 Aug 2023 09:58:53 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <ZN5DvRyq6JNz20l1@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace struct_size() with sizeof(), and avoid allocating 8 too many
bytes.

The following difference in binary output is expected and reflects the
desired change:

| net/sched/cls_u32.o
| @@ -6148,7 +6148,7 @@
| include/linux/slab.h:599
|     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
|                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
|-    2cfc:      mov    $0x98,%edx
|+    2cfc:      mov    $0x90,%edx

Fixes: d61491a51f7e ("net/sched: cls_u32: Replace one-element array with flexible-array member")
Reported-by: Alejandro Colomar <alx@kernel.org>
Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
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


