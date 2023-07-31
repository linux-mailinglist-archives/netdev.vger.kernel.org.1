Return-Path: <netdev+bounces-22751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA112769114
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B531C2091C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687F14F86;
	Mon, 31 Jul 2023 09:06:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6E81B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:06:33 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FF2BE9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=HKLAeQRB/Ec2QFPy5+
	iHXyg7ax3/7rAwaaA9udBEyyw=; b=Dg1wyNNG/o0UWvdCKe5bs1LASYeNyVJU06
	FzmTq8msLiRUSW5XylCt3HY1HbbzCgPnpLBnDlPtFlTd0jY0h2ui3/Ugr6dRYk5E
	2hBylB5q2HUr6fCG4GjI6ESMviePc46LchPWPEri3szGZDG/8ZaSjhmX05QhgS+w
	PULe2AhgA=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wD3CkRhecdkAsMnBw--.21953S4;
	Mon, 31 Jul 2023 17:05:46 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH v2 1/1] net: korina: handle clk prepare error in korina_probe()
Date: Mon, 31 Jul 2023 17:05:35 +0800
Message-Id: <20230731090535.21416-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230728162639.1c08f645@kernel.org>
References: <20230728162639.1c08f645@kernel.org>
X-CM-TRANSID:_____wD3CkRhecdkAsMnBw--.21953S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF48JF17uw43Ww1UXF4fXwb_yoW8Jr1Dpa
	ykCa4F9r48A34UWw4UXr10qF9Ykan7KayUG3y8G395uw15Ar45ArykKF1rCF1v9rykJa1a
	yr47Z3ZrAF4DCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piy89_UUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQy95VaEIEqtaQAAsh
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in korina_probe(), the return value of clk_prepare_enable()
should be checked since it might fail. we can use
devm_clk_get_optional_enabled() instead of devm_clk_get_optional()
and clk_prepare_enable() to automatically handle the error.

Fixes: e4cd854ec487 ("net: korina: Get mdio input clock via common clock framework")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/korina.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 2b9335cb4bb3..8537578e1cf1 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1302,11 +1302,10 @@ static int korina_probe(struct platform_device *pdev)
 	else if (of_get_ethdev_address(pdev->dev.of_node, dev) < 0)
 		eth_hw_addr_random(dev);
 
-	clk = devm_clk_get_optional(&pdev->dev, "mdioclk");
+	clk = devm_clk_get_optional_enabled(&pdev->dev, "mdioclk");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	if (clk) {
-		clk_prepare_enable(clk);
 		lp->mii_clock_freq = clk_get_rate(clk);
 	} else {
 		lp->mii_clock_freq = 200000000; /* max possible input clk */
-- 
2.17.1


