Return-Path: <netdev+bounces-18319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4F7566C0
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28D21C20AB2
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD017253B4;
	Mon, 17 Jul 2023 14:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3074253B2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:47:59 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48920B2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=AlDY3ubaSIkjyQCRBD
	yT5wt67P9MnZ7GXTajLl47exk=; b=ZPJCM29vHpN7JsINcDXtr6PYrqXc0KlLRU
	fxD2pOwdHBNfV2V0Md+hS6XZkz6IhmuDxZyZyquF1s8tioCLzTWLfNDk17y14tor
	nzfObAh14g0zNCtOxb8Z8/tjDcVpbG4Lnu21zs7qXk7goeKItxOUeinhGfn+v+FV
	XPuo3RicA=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wC319deVLVkt246Ag--.14361S4;
	Mon, 17 Jul 2023 22:46:58 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] drivers:net: fix return value check in ocelot_fdma_receive_skb
Date: Mon, 17 Jul 2023 22:46:52 +0800
Message-Id: <20230717144652.23408-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wC319deVLVkt246Ag--.14361S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryfJw1rtr15ArWDXr4rGrg_yoWfJwb_KF
	18Zr1rJFs3Gr1jyws8GrZIv34FkF1kWF97CFn3tayYq34UCry8Ar4vkr1DJw1DuryfAFWD
	A3W3KrW2y34UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNWlk5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiASv5VaEFzdTuAAAsf
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

ocelot_fdma_receive_skb should return false if an unexpected
value is returned by pskb_trim.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/mscc/ocelot_fdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_fdma.c b/drivers/net/ethernet/mscc/ocelot_fdma.c
index 8e3894cf5f7c..83a3ce0c568e 100644
--- a/drivers/net/ethernet/mscc/ocelot_fdma.c
+++ b/drivers/net/ethernet/mscc/ocelot_fdma.c
@@ -368,7 +368,8 @@ static bool ocelot_fdma_receive_skb(struct ocelot *ocelot, struct sk_buff *skb)
 	if (unlikely(!ndev))
 		return false;
 
-	pskb_trim(skb, skb->len - ETH_FCS_LEN);
+	if (pskb_trim(skb, skb->len - ETH_FCS_LEN))
+		return false;
 
 	skb->dev = ndev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
-- 
2.17.1


