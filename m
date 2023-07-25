Return-Path: <netdev+bounces-20692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD3760A6E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7261C20D82
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581263D7C;
	Tue, 25 Jul 2023 06:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EA538A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:41:51 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C79116
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=kxUZOzGlamBPaZ3wzT
	WgolIMEEuXlS++yri1Hx17W3c=; b=mbCBzRLjR20BcwBZ00+ZrECi2OvqVEV51z
	vxu9Uk5KeKreB3kZ2ZamP6GTz6FH1qki2+GjKlN06rDKKG+PoVsy7dsas7xQ5C4E
	gDaw2FIat8zVei1M5bpOq7p4pJ5xcVPk2lllTbBEVuzSN7svp+NjqQgnKlT19q62
	CiR4m1jHg=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wCHy6R2br9kAjb7BA--.27380S4;
	Tue, 25 Jul 2023 14:41:03 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: dsahern@kernel.org
Cc: herbert@gondor.apana.org.au,
	netdev@vger.kernel.org,
	ruc_gongyuanjun@163.com,
	steffen.klassert@secunet.com
Subject: [PATCH v2 1/1] net: ipv4: fix return value check in esp_remove_trailer()
Date: Tue, 25 Jul 2023 14:40:31 +0800
Message-Id: <20230725064031.4472-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f6831ace-df6c-f0bd-188e-a2b23a75c1a8@kernel.org>
References: <f6831ace-df6c-f0bd-188e-a2b23a75c1a8@kernel.org>
X-CM-TRANSID:_____wCHy6R2br9kAjb7BA--.27380S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurWrtw4xCw45KrWkCrg_yoWxZrb_Ga
	97Xr4kWr15uFn7ZF4fZr4ayFyrtw48XFyFvr1ftayavw15J3WrJrZ7CrZ5u345GFWkCrnx
	AFsxurWjya4SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNF4iUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQK35WDESabcMAAAsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
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
 net/ipv4/esp4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index ba06ed42e428..b435e3fe4dc6 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -732,7 +732,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (ret)
+		goto out;
 
 	ret = nexthdr[1];
 
-- 
2.17.1


