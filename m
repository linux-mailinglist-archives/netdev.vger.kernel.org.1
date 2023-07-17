Return-Path: <netdev+bounces-18324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48F7566CE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC01C1C20777
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F043253BD;
	Mon, 17 Jul 2023 14:50:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDB253B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:50:43 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02758E52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=UoL8DS8grtQcLwZexb
	x4yev9al5bRajKNzv+5HEjRe4=; b=njaLiN+0sJ5yAsKV0aGeYRbcQX/SNVn/8P
	KLYg+X2rOWR/Bng3VTFkQMMtW7Z4Xw0tCa63X4EmWLfpcrAsTaS8V1CKQ3vdvC4l
	NiSp8oItqKi5c8YwL1mJz8yfhPUkGdUsWuwxY3jYj8Ct0iOps8P20R7y2ETKG0FU
	pefOmOlAg=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wBXX5MMVbVk3OdBAg--.20868S4;
	Mon, 17 Jul 2023 22:49:52 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] net: ipv6: check the return value of pskb_trim()
Date: Mon, 17 Jul 2023 22:49:46 +0800
Message-Id: <20230717144946.26495-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBXX5MMVbVk3OdBAg--.20868S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurWrtFWktFyxKr47twb_yoWxZwc_Ga
	n7Xr4kWr1UWF1kA3yfZr4ayryrtrWxXFyfZr93ta4fXw17Aw1rJrs7CrZ8Z3y3GFZrCry5
	uFsxCrW8ta42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKrWrPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiBKv5VaEFzddYwAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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
 net/ipv6/esp6.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index fddd0cbdede1..81111ccadf34 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -770,7 +770,10 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


