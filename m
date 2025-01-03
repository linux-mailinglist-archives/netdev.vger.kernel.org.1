Return-Path: <netdev+bounces-154937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64606A0067B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0DB7A119E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004A1CF5CE;
	Fri,  3 Jan 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aRNTr/wT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9C1C5F09;
	Fri,  3 Jan 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895357; cv=none; b=C0rcRmFH5DY8NaEr3n76ar0h4PU4ByhIMH6ZTa2ur+0JpZZOCTUY/bcsErU9BKjA6Q/VApp2cUII2JPGDxtutrcT621LBwXOG/T2IIPiqYw5cOQKwPuFWAXBvTpyzSnkYqKI8HpAi8sF7V/QLhL840B+wmmvSQPYouVkRgwjTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895357; c=relaxed/simple;
	bh=INfFyU5nKdRbFettIvyvhrAPh8m5UDTJ0K4DWxzxwE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAofNrbV85+Oz9mAWVZxJErebjey+r0UB6liswvTp3uKrkwjc80+tzlgLxJI2eWBSev+Nfy8MY/j0wd6SQJpBaGbLWO3nFDFtHsGvizW5+2MJBU8w1Vvm6yBJ0igjAenoh9Bn76P3N54x/4Vp0r56UzNQRigAwaZ0aANygYL0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aRNTr/wT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1735895355; x=1767431355;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=INfFyU5nKdRbFettIvyvhrAPh8m5UDTJ0K4DWxzxwE8=;
  b=aRNTr/wThJKbtVeWl1N/WZeJl9kEkkOpYieOn46w5xbiE/j697iAphfl
   HuYmYfWnXV8p/weA7gEsBybwMeoH1FG/CSr1Aw57LBJoePetJz596DcLf
   cgMHScO9ca0EJm6mZh/Qk5hpJOeeEBsB78JfHNRzszizY16C9+5Q9G1CQ
   aVK6lC4mzCf6SaV5YEMsD/Qnq50qaPMPAW1fuHAsvmQ/SLRCOjatwnlD2
   I4IsrVdlaSirRHzJWymTesHZAl8ruGUnz2vb1Nj/H3bzApIW6PWBpM5th
   st68aMb3baNxD6KFrskRHU+BUw5YGV41c/s4fOrO3XFhMMGLjyluVHteD
   g==;
X-CSE-ConnectionGUID: 9lugowQIRF2Bdg+6ihLSRg==
X-CSE-MsgGUID: 6wA70II8TF2HV4eNnFW3hA==
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="35788954"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2025 02:08:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 Jan 2025 02:07:35 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 3 Jan 2025 02:07:31 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 1/3] net: phy: microchip_rds_ptp: Header file library changes for PEROUT
Date: Fri, 3 Jan 2025 14:37:29 +0530
Message-ID: <20250103090731.1355-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250103090731.1355-1-divya.koppera@microchip.com>
References: <20250103090731.1355-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This ptp header file library changes will cover PEROUT
macros that are required to generate periodic output
from GPIO

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_rds_ptp.h | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.h b/drivers/net/phy/microchip_rds_ptp.h
index e95c065728b5..08058b407639 100644
--- a/drivers/net/phy/microchip_rds_ptp.h
+++ b/drivers/net/phy/microchip_rds_ptp.h
@@ -130,6 +130,41 @@
 #define MCHP_RDS_PTP_TSU_HARD_RESET		0xc1
 #define MCHP_RDS_PTP_TSU_HARDRESET		BIT(0)
 
+/* PTP GPIO Registers */
+#define MCHP_RDS_PTP_CLK_TRGT_SEC_HI_X(evt)	(evt ? 0x1f : 0x15)
+#define MCHP_RDS_PTP_CLK_TRGT_SEC_LO_X(evt)	(evt ? 0x20 : 0x16)
+#define MCHP_RDS_PTP_CLK_TRGT_NS_HI_X(evt)	(evt ? 0x21 : 0x17)
+#define MCHP_RDS_PTP_CLK_TRGT_NS_LO_X(evt)	(evt ? 0x22 : 0x18)
+
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_HI_X(evt)	(evt ? 0x23 : 0x19)
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_LO_X(evt)	(evt ? 0x24 : 0x1a)
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_HI_X(evt)	(evt ? 0x25 : 0x1b)
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_LO_X(evt)	(evt ? 0x26 : 0x1c)
+
+#define MCHP_RDS_PTP_GEN_CFG			0x01
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_X_MASK_(evt)	\
+					((evt) ? GENMASK(11, 8) : GENMASK(7, 4))
+
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_X_SET_(evt, value) \
+					(((value) & 0xF) << (4 + ((evt) << 2)))
+#define MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD_X_(evt)	((evt) ? BIT(2) : BIT(0))
+#define MCHP_RDS_PTP_GEN_CFG_POLARITY_X_(evt)	((evt) ? BIT(3) : BIT(1))
+
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_	13
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100MS_	12
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50MS_	11
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10MS_	10
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5MS_	9
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1MS_	8
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500US_	7
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100US_	6
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50US_	5
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10US_	4
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5US_	3
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1US_	2
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500NS_	1
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100NS_	0
+
 /* Represents 1ppm adjustment in 2^32 format with
  * each nsec contains 4 clock cycles in 250MHz.
  * The value is calculated as following: (1/1000000)/((2^-32)/4)
@@ -138,6 +173,13 @@
 #define MCHP_RDS_PTP_FIFO_SIZE			8
 #define MCHP_RDS_PTP_MAX_ADJ			31249999
 
+#define MCHP_RDS_PTP_EVT_A			0
+#define MCHP_RDS_PTP_EVT_B			1
+#define MCHP_RDS_PTP_BUFFER_TIME		2
+
+#define MCHP_RDS_PTP_N_GPIO			4
+#define MCHP_RDS_PTP_N_PEROUT			2
+
 #define BASE_CLK(p)				((p)->clk_base_addr)
 #define BASE_PORT(p)				((p)->port_base_addr)
 #define PTP_MMD(p)				((p)->mmd)
@@ -176,6 +218,11 @@ struct mchp_rds_ptp_clock {
 	/* Lock for phc */
 	struct mutex ptp_lock;
 	u8 mmd;
+	int mchp_rds_ptp_event_a;
+	int mchp_rds_ptp_event_b;
+	int gpio_event_a;
+	int gpio_event_b;
+	struct ptp_pin_desc *pin_config;
 };
 
 struct mchp_rds_ptp_rx_ts {
-- 
2.17.1


