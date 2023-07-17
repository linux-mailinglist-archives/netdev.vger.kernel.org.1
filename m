Return-Path: <netdev+bounces-18320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC617566C8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806F31C209AB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B42253B6;
	Mon, 17 Jul 2023 14:49:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC9253B0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:49:24 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66C4AE45
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=rsx79IQz+RAPMXWbXN
	mTfr0EjpZdMq82NhE8O33eaig=; b=leRJoWANbn5rDQgaDlVpgxxGIXvJNrr1BD
	91RzvVfW5xKoqYp8IDJIB/WUX3ccKc0Wcf2M6OvQFF8FlW1TrU1bJTIEqMUeZDoR
	8LmXkgk2E2Vt6p5vbhIEmTq7+nYLiDx/UPU0U6LDf16b/ETNcL5XAVc14YV5i4go
	wGfNWTXL0=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wAnrlngVLVkss4kAg--.57706S4;
	Mon, 17 Jul 2023 22:49:08 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] ipv4: ip_gre: fix return value check in erspan_fb_xmit()
Date: Mon, 17 Jul 2023 22:49:02 +0800
Message-Id: <20230717144902.25695-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAnrlngVLVkss4kAg--.57706S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurWrKF45Jw4DWr18AFb_yoWxKFXEyw
	4xAayDGr47tr1j93yfZF4YqryFkw1vyFn5Zr1xJFW5Ga4qya4fCrZagrykurnxGFW3Ca17
	JFW5uFWjkw4rujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKrWrPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQWv5VaEH4VFyQAAsC
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

goto err_free_skb if an unexpected result is returned by pskb_tirm()
in erspan_fb_xmit().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/ipv4/ip_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 81a1cce1a7d1..914cc941af55 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -548,7 +548,8 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto err_free_skb;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto err_free_skb;
 		truncate = true;
 	}
 
-- 
2.17.1


