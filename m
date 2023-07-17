Return-Path: <netdev+bounces-18321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463267566C9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8211C209AB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E0253BA;
	Mon, 17 Jul 2023 14:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B5253B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:49:41 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0331E52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=zW1zxq7H7PTPYSk+2X
	+WhQykiMPpYHiCdqmW4eDnYOQ=; b=Rey0by4gmvvcjd4VhHbQeHJ0kV9evNos2B
	j6AcX5f34ae7YUJRTa7aQVdnwG0zRkXZIi9YvspnnPWolB86O3X2k9SJyh1OPucF
	/FosgSfzaYGYwt75R9vRtJEI+v3vIJN9HC6cQrLV8wJSjr7c0kNcHV2564eMP3jn
	LImaRN2ac=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wD3XAbvVLVkwlZFAg--.29253S4;
	Mon, 17 Jul 2023 22:49:23 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] ipv4: ip_gre: fix return value check in erspan_xmit()
Date: Mon, 17 Jul 2023 22:49:18 +0800
Message-Id: <20230717144918.25961-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3XAbvVLVkwlZFAg--.29253S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurWUCw4fuF4xtFyxZrb_yoWxZFcEvw
	4xJaykGr4fJr109w4fAa1FqryFkw1FyFn5Zw1xJay5Ka4YyF95CrZ3urWkurnxGF43C345
	Jr45uF42kr4fZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKrWrPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiURWv5WDESThaTwAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

goto free_skb if an unexpected result is returned by pskb_tirm()
in erspan_xmit().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/ipv4/ip_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 81a1cce1a7d1..cb2182144dd5 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -689,7 +689,8 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto free_skb;
 		truncate = true;
 	}
 
-- 
2.17.1


