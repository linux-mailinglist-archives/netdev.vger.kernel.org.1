Return-Path: <netdev+bounces-83854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2B894940
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09F81C23494
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E63DDBE;
	Tue,  2 Apr 2024 02:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAC3201
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024468; cv=none; b=oSEtefxNyV+xhe1BjsX7g+Xqnv0BB3wdtM1vdtyzdScPnnvc4ORk1DlGkKj2OaleV1TXKGtmrooywHeZM1D4Ak6ms+gPqi41Hz4ZR1FDpY1q1sVV0PK9aAqCd0ZDLTcFxSxUxIVnI2ikp/9ML5wprdXroWnUp6pFFzzJB53DTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024468; c=relaxed/simple;
	bh=bVgBnHwK6xfEJYujxh+DSusmpoayqrRDtbN6v4zz58E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYNUVu/b/pOPguwSROvPJk1n+qDPYaHSdwXfOGTQEhsB04OJgbVIeRuZ1ddxp3vCsNbsrc4bSI8MLkizlXpwWpRoRvzOHwwC5gt/TKSylZA1I5q7szZ83VM1Of3SA1K8GlznvH8ubhLmcSe53rQCBPwWxJK/FS/d13AxohCeQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp90t1712024378t826ch9x
X-QQ-Originating-IP: x7OuoggiLs3gvqrKfK+LdbFmFadNy7WnXw0A39NC284=
Received: from localhost.trustnetic.com ( [122.235.142.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 10:19:35 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: y5ttDAKJaXNHu27HOfGw8RliSUJYUyrpFyPc8gPUrH72NgD/bsGZSbuPCh7LO
	ZwxaIuKnoCLaMMBZcn4NBWRIkS1QgpdUQbaZV5IZSGVvgBAEjmuSZTzLyz0PC6HjWSxZJZF
	hPgxX0ZNP/G5QAQr6vdz1oe6siDTxNY7P1QMGRMz39Hpvudd7PyhqheDneFJdZB3wLr108a
	MVcUsQ4fVjnY//rMKrU0Fy9RCs5+Aqg55T0sD933S7iWq9Uf2zDjTMwJggEsu4JQD2ldeAc
	mXGwS+uGSdn61OXlFJSg6e6FoBs8WKOmUg3q29W3UKuYBteioSGX1yUbCSG5dkOvWCrIOUb
	8aTAaD9+LpzECudcaWDimTbeELhqkIB78W/zEvtiNNNgLKF9ZwCK/YUglitCXHSUaWrx+P4
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9296928932754756638
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	wangxiongfeng2@huawei.com,
	michal.kubiak@intel.com
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH RESEND net v5] net: txgbe: fix i2c dev name cannot match clkdev
Date: Tue,  2 Apr 2024 10:18:43 +0800
Message-Id: <20240402021843.126192-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

txgbe clkdev shortened clk_name, so i2c_dev info_name
also need to shorten. Otherwise, i2c_dev cannot initialize
clock.

Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
Change log:
v4-v5: address comments:
        Jiri Pirko:
        Well, since it is used in txgbe_phy.c, it should be probably
        rather defined locally in txgbe_phy.c.
	Florian Fainelli:
	so my suggestion to standardize the 'i2c_designware' string beyond
	your driver did not really make sense.
v3->v4: address comments:
        Jakub Kicinski:
        No empty lines between Fixes and Signed-off... please.
v2->v3: address comments:
        Jiawen Wu:
        Please add the define in txgbe_type.
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5b5d5e4310d1..2fa511227eac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,6 +20,8 @@
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
+
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
 	struct txgbe_nodes *nodes = &txgbe->nodes;
@@ -571,8 +573,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
-		 pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = "i2c_designware";
+	info.name = TXGBE_I2C_CLK_DEV_NAME;
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
-- 
2.27.0


