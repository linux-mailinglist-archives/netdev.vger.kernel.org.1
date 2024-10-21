Return-Path: <netdev+bounces-137504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314B9A6B62
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD6F1F22455
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70131F9AB9;
	Mon, 21 Oct 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c3SH5BR+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B81E7C09;
	Mon, 21 Oct 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519217; cv=none; b=rM8CjgD/MG4gI2IkYzAfWv3s49Zks9xinUtVGAAq+pllqvPk9WSy0YkZE4x7n2J8aPKKkj4ohUipoG4a9J6wvnYMFT4/hI/8PIxLME1FGuJjhBL/mY2Z7tpfNlH72Gt63ably2b4ilnSOZic7petExdTzr1Fer72wriZQCKQVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519217; c=relaxed/simple;
	bh=MGtHqjnJHsWdHgeNRtIE41YoumSd7sY+lNNdVHYmShs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LAty3esh9NrkNPFhdISRk+o1bmZi9wuiccCghglNNIGpe0/f5CwGimLtuHV2XPJUixgkvm8QJOaGRLIE1k7uHY/fbh2QPd9uXTAcdKsoq+0zzz/yR4yxbFYYLiOUatjZ69VLBpuhJpoGL05T6vevvkwSjSUOMMRYctV+L5BzYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c3SH5BR+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519216; x=1761055216;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MGtHqjnJHsWdHgeNRtIE41YoumSd7sY+lNNdVHYmShs=;
  b=c3SH5BR+TunEQXAzwIK4hDeeqrQnZAKRo3iUEhIAYs8QqLH9IicbPY33
   3wBRlSZxRBaWOn/zrMk/g0WEmoMX55X0bdt3Yj9rCBijhFb2DYODN2hi+
   TZLKr61E4svQH2tRCVHaE4Kfj4el0b23IQ7uz9Ib0T6oMGOfNad1CjVfC
   X3ND91yfIwaNf6Vl1ik8Rkez54muCnoJNNHl+j9pLSGLMXcgYuxBqSO/7
   7FLULzqFNvYKmDzS5F9dzQwgjBZ09w1PwJwHdsduwH/LHfWJJ3DXNYw7/
   g0iqe7vlf1n82qSNMUWOnEHnUvxFAk2LEEO3Kmeja31Y4gzG67FJ/uHW0
   g==;
X-CSE-ConnectionGUID: wjlJ/ymcRaqntxTcHXMHhA==
X-CSE-MsgGUID: I0v9UrQkSW+g6ZlCutcotw==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="33285734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:00:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:56 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:52 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:52 +0200
Subject: [PATCH net-next 15/15] net: sparx5: add feature support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-15-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Lan969x supports a number of different features, depending on the SKU
(Stock Keeping Unit, see [1] for details). Add new field
sparx5->features and initialize the features based on the target. Also
add the function sparx5_has_feature() and use it throughout. For now, we
only need to handle features: PSFP and PTP - more will come in the
future.

[1] https://www.microchip.com/en-us/product/lan9698

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 40 +++++++++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  7 ++++
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |  5 +++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index edbe639d98c5..ecec93625d37 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -267,6 +267,40 @@ static int sparx5_set_target_dt(struct sparx5 *sparx5)
 	return 0;
 }
 
+static void sparx5_init_features(struct sparx5 *sparx5)
+{
+	switch (sparx5->target_dt) {
+	case SPX5_TARGET_CT_7546:
+	case SPX5_TARGET_CT_7549:
+	case SPX5_TARGET_CT_7552:
+	case SPX5_TARGET_CT_7556:
+	case SPX5_TARGET_CT_7558:
+	case SPX5_TARGET_CT_7546TSN:
+	case SPX5_TARGET_CT_7549TSN:
+	case SPX5_TARGET_CT_7552TSN:
+	case SPX5_TARGET_CT_7556TSN:
+	case SPX5_TARGET_CT_7558TSN:
+	case SPX5_TARGET_CT_LAN9691VAO:
+	case SPX5_TARGET_CT_LAN9694TSN:
+	case SPX5_TARGET_CT_LAN9694RED:
+	case SPX5_TARGET_CT_LAN9692VAO:
+	case SPX5_TARGET_CT_LAN9696TSN:
+	case SPX5_TARGET_CT_LAN9696RED:
+	case SPX5_TARGET_CT_LAN9693VAO:
+	case SPX5_TARGET_CT_LAN9698TSN:
+	case SPX5_TARGET_CT_LAN9698RED:
+		sparx5->features = (SPX5_FEATURE_PSFP | SPX5_FEATURE_PTP);
+		break;
+	default:
+		break;
+	}
+}
+
+bool sparx5_has_feature(struct sparx5 *sparx5, enum sparx5_feature feature)
+{
+	return sparx5->features & feature;
+}
+
 /* Compare the devicetree target with the chip target.
  * Make sure the chip target supports the features and bandwidth requested
  * from the devicetree target.
@@ -934,7 +968,8 @@ static int sparx5_start(struct sparx5 *sparx5)
 		sparx5->xtr_irq = -ENXIO;
 	}
 
-	if (sparx5->ptp_irq >= 0) {
+	if (sparx5->ptp_irq >= 0 &&
+	    sparx5_has_feature(sparx5, SPX5_FEATURE_PTP)) {
 		err = devm_request_threaded_irq(sparx5->dev, sparx5->ptp_irq,
 						NULL, ops->ptp_irq_handler,
 						IRQF_ONESHOT, "sparx5-ptp",
@@ -1088,6 +1123,9 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	if (err)
 		goto cleanup_config;
 
+	/* Initialize the features based on the devicetree target */
+	sparx5_init_features(sparx5);
+
 	/* Initialize Switchcore and internal RAMs */
 	err = sparx5_init_switchcore(sparx5);
 	if (err) {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8a2b74d0bd35..5163e26a28b4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -75,6 +75,11 @@ enum sparx5_cal_bw {
 	SPX5_CAL_SPEED_12G5 = 7
 };
 
+enum sparx5_feature {
+	SPX5_FEATURE_PSFP = BIT(0),
+	SPX5_FEATURE_PTP  = BIT(1),
+};
+
 #define SPX5_PORTS             65
 #define SPX5_PORTS_ALL         70 /* Total number of ports */
 
@@ -338,6 +343,7 @@ struct sparx5 {
 	u32 chip_id;
 	enum spx5_target_chiptype target_ct;
 	enum spx5_target_chiptype target_dt; /* target from devicetree */
+	u32 features;
 	void __iomem *regs[NUM_TARGETS];
 	int port_count;
 	struct mutex lock; /* MAC reg lock */
@@ -405,6 +411,7 @@ struct sparx5 {
 
 /* sparx5_main.c */
 bool is_sparx5(struct sparx5 *sparx5);
+bool sparx5_has_feature(struct sparx5 *sparx5, enum sparx5_feature feature);
 
 /* sparx5_switchdev.c */
 int sparx5_register_notifier_blocks(struct sparx5 *sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index c3bbed140554..4dc1ebd5d510 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -1284,6 +1284,11 @@ static int sparx5_tc_flower_replace(struct net_device *ndev,
 
 	/* Setup PSFP */
 	if (tc_sg_idx >= 0 || tc_pol_idx >= 0) {
+		if (!sparx5_has_feature(sparx5, SPX5_FEATURE_PSFP)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
 		err = sparx5_tc_flower_psfp_setup(sparx5, vrule, tc_sg_idx,
 						  tc_pol_idx, &sg, &fm, &sf);
 		if (err)

-- 
2.34.1


