Return-Path: <netdev+bounces-18322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA497566CC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE522812D0
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C53B253BB;
	Mon, 17 Jul 2023 14:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90037253A0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:50:29 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E0EFE45
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=56g+oOnCmcubKeh54e
	IxaUv2x8AafWK5JQ6c6vAntv0=; b=ppnnCPgT5PXtq1rx//AYDGNc/+yJjF/krd
	79PiBIKF6QAYfFI9uq+oMhXydTVHcsyXYDhiBv72mn7IqTSzV5/wuSVH0CPXMgPn
	Eft27Be3rr1HfoCrM+SoXgys7TV7HfRQVk18lYqKv2F5gSW5YpUsP2exjmEhgiUV
	HNeg5aTwA=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wB3FMH8VLVkZ8UtAg--.4558S4;
	Mon, 17 Jul 2023 22:49:35 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] net: ipv4: fix return value check in esp_remove_trailer()
Date: Mon, 17 Jul 2023 22:49:30 +0800
Message-Id: <20230717144930.26197-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wB3FMH8VLVkZ8UtAg--.4558S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurWrtw4fKry5Ar43ZFb_yoWxZwcEga
	97Xr4kWr1rWF97ZF4fZr4jyFyrt3y8XFyrZr1fta4ag3WUAw1rArs7CrZ5u343WFWkCrnr
	AFsxCrW8Aa4ayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKrWrPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiACv5VaEFzdcXgAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

return an error number if an unexpected result is returned by
pskb_tirm() in esp_remove_trailer().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/ipv4/esp4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index ba06ed42e428..0660bf2bdbae 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -732,7 +732,10 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	if (pskb_trim(skb, skb->len - trimlen)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = nexthdr[1];
 
-- 
2.17.1


