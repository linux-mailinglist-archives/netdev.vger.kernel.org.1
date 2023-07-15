Return-Path: <netdev+bounces-18068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D7754809
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 11:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C961C1C209ED
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED115D4;
	Sat, 15 Jul 2023 09:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5C15CD
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 09:46:53 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98BE035A9
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=bBkSZWJ9Esy84Ri1oi
	889v/SLvTLhZuk26T26LcmcEc=; b=HagJm/3QNA2m7jDl+7PuIdcAfQsLwR6tjg
	UbaLNewQUmgbIrp5f11Gb1Ob0O1tKHixbYpnQ0jAc1Xw8edOcGa4CBRZziGG8ah2
	zm1qr2YIJk12BQWWgCwnBGThf7wKW641xPYSelgRved5hJPewklFrV2AQ2NGEpt0
	NY8JgoHgs=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wBnlHnmarJksmRzAQ--.27941S4;
	Sat, 15 Jul 2023 17:46:25 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] net:ipv6: check return value of pskb_trim()
Date: Sat, 15 Jul 2023 17:46:13 +0800
Message-Id: <20230715094613.37897-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBnlHnmarJksmRzAQ--.27941S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxury7uw1UCw1xArW8JFb_yoW3Arb_Z3
	97WFyDGF48X3WUKa1fAa1YqrWFk340yF4rZFyIkFyF9345tryrArs5Cr4kCr4DGFWfCry5
	Grs8CFW5CF43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_lksDUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiBSt5VaEFxyUMgAAsr
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

goto tx_err if an unexpected result is returned by pskb_tirm()
in ip6erspan_tunnel_xmit().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/ipv6/ip6_gre.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index da80974ad23a..92220b02e99f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -955,8 +955,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		goto tx_err;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
-		truncate = true;
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto tx_err;
+		else
+			truncate = true;
 	}
 
 	nhoff = skb_network_offset(skb);
-- 
2.17.1


