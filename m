Return-Path: <netdev+bounces-21388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E196763796
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3817A281EEA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6DC2DC;
	Wed, 26 Jul 2023 13:30:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A546C141
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:30:45 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADA7FBC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=UzedVzlTPugKIi7yUj
	DBwd/JHG3+tRrpUhFRnCHdDnA=; b=pueHs0apaf7YqajYsoYGNgwrLLQ81HLRqr
	9wc/+NdKRzsRs/ZiGhZUYBO1CtfgZz/1kcqYtsSSJXcaGrsbdNdfq5cuTcB0e01r
	Po8j35zol9LFqlvQmIXWOuFdRy32eFLRk3CSR2WqWtEvdbpJKuxGjeWj2GxmajyV
	JAQVPN3bs=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wAHdzPJH8Fk67VHBQ--.55025S4;
	Wed, 26 Jul 2023 21:29:51 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] net: korina: fix value check in korina_probe()
Date: Wed, 26 Jul 2023 21:29:43 +0800
Message-Id: <20230726132943.20318-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAHdzPJH8Fk67VHBQ--.55025S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tF47Kr4fGrg_yoWftFcE93
	yxZr93Gr4agr1Yywn5GrZ8Ar9Fk3Z2vF1F93WxK3y5try7Gr17Zr1kX39rAws3Ww4jkF9r
	KF17A3y7Cw13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNrcTJUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiURG45WDESbveuAAAst
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in korina_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Fixes: e4cd854ec487 ("net: korina: Get mdio input clock via common clock framework")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/korina.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 2b9335cb4bb3..e18062007ae3 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1306,7 +1306,9 @@ static int korina_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	if (clk) {
-		clk_prepare_enable(clk);
+		rc = clk_prepare_enable(clk);
+		if (rc)
+			return rc;
 		lp->mii_clock_freq = clk_get_rate(clk);
 	} else {
 		lp->mii_clock_freq = 200000000; /* max possible input clk */
-- 
2.17.1


