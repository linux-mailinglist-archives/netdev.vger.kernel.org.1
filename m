Return-Path: <netdev+bounces-122774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F1962817
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C007B285D0A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1F18784B;
	Wed, 28 Aug 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GhtlRJzp"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707801862B7
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850005; cv=none; b=J16LlfRY+LWR6ILVeHn/B3eiZ7Qzz80ZSQ2rEUqTcRIa1s931fh25gEu48VitXoaMmB2aJlSlIiZCtvBFWp4jdCQVqnVnvPHJxPs8cFYrxO8bPYWPYPxvbnlN91adc/2yJbvsBzXE7TqUtvqNPJ0FigdrQaldFs9oXvlWtVC03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850005; c=relaxed/simple;
	bh=Dx2q0/UbvUqQTVZKigs5yd+yhg8MHcUIqZl/sUK63nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8rj4FjcdI+lM+JpCssQL73lCeql10LszmprmDuV9sMl1EBmxB9QZIu+csqaIaaDS+dTj3DVltGWYV8hQ9R5bVYc4ZMXlB8QK9E50QDAZFFbgvNlCcSr7f72ryC7s4zc39vg0OD/rhmYsUCqy3s3hK0SOuZryv/xenb2j0PAZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GhtlRJzp; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724850000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zMx7Wdw/yPzXMEo65Slmqy2MsOlRJjqVB7xlz4kfVnc=;
	b=GhtlRJzpy7qMLNuXWr7w8z4AyftmeJiA2ZZhpEKnGZ87mCaYz1cEe5Ckabb12qcrIkn6Z4
	9owbauC1TahrK3dNZZUVyjC7GCp9cGqrI2o4RNrBMAxbxsbqtpkf1KryzSmFd/XWAtihoA
	IsEMp1lhGeRDB54xqd4kHiE7JgRQod8=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: phy: Modify register address from decimal to hexadecimal
Date: Wed, 28 Aug 2024 20:59:32 +0800
Message-Id: <20240828125932.3478-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Most datasheets will use hexadecimal for register address, modify it
and make it fit the datasheet better.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/uapi/linux/mdio.h | 98 +++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index c0c8ec995b06..2f6022bef535 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -32,58 +32,58 @@
 #define MDIO_STAT1		MII_BMSR
 #define MDIO_DEVID1		MII_PHYSID1
 #define MDIO_DEVID2		MII_PHYSID2
-#define MDIO_SPEED		4	/* Speed ability */
-#define MDIO_DEVS1		5	/* Devices in package */
-#define MDIO_DEVS2		6
-#define MDIO_CTRL2		7	/* 10G control 2 */
-#define MDIO_STAT2		8	/* 10G status 2 */
-#define MDIO_PMA_TXDIS		9	/* 10G PMA/PMD transmit disable */
-#define MDIO_PMA_RXDET		10	/* 10G PMA/PMD receive signal detect */
-#define MDIO_PMA_EXTABLE	11	/* 10G PMA/PMD extended ability */
-#define MDIO_PKGID1		14	/* Package identifier */
-#define MDIO_PKGID2		15
-#define MDIO_AN_ADVERTISE	16	/* AN advertising (base page) */
-#define MDIO_AN_LPA		19	/* AN LP abilities (base page) */
-#define MDIO_PCS_EEE_ABLE	20	/* EEE Capability register */
-#define MDIO_PCS_EEE_ABLE2	21	/* EEE Capability register 2 */
-#define MDIO_PMA_NG_EXTABLE	21	/* 2.5G/5G PMA/PMD extended ability */
-#define MDIO_PCS_EEE_WK_ERR	22	/* EEE wake error counter */
-#define MDIO_PHYXS_LNSTAT	24	/* PHY XGXS lane state */
-#define MDIO_AN_EEE_ADV		60	/* EEE advertisement */
-#define MDIO_AN_EEE_LPABLE	61	/* EEE link partner ability */
-#define MDIO_AN_EEE_ADV2	62	/* EEE advertisement 2 */
-#define MDIO_AN_EEE_LPABLE2	63	/* EEE link partner ability 2 */
-#define MDIO_AN_CTRL2		64	/* AN THP bypass request control */
+#define MDIO_SPEED		0x0004	/* Speed ability */
+#define MDIO_DEVS1		0x0005	/* Devices in package */
+#define MDIO_DEVS2		0x0006
+#define MDIO_CTRL2		0x0007	/* 10G control 2 */
+#define MDIO_STAT2		0x0008	/* 10G status 2 */
+#define MDIO_PMA_TXDIS		0x0009	/* 10G PMA/PMD transmit disable */
+#define MDIO_PMA_RXDET		0x000A	/* 10G PMA/PMD receive signal detect */
+#define MDIO_PMA_EXTABLE	0x000B	/* 10G PMA/PMD extended ability */
+#define MDIO_PKGID1		0x000E	/* Package identifier */
+#define MDIO_PKGID2		0x000F
+#define MDIO_AN_ADVERTISE	0x0010	/* AN advertising (base page) */
+#define MDIO_AN_LPA		0x0013	/* AN LP abilities (base page) */
+#define MDIO_PCS_EEE_ABLE	0x0014	/* EEE Capability register */
+#define MDIO_PCS_EEE_ABLE2	0x0015	/* EEE Capability register 2 */
+#define MDIO_PMA_NG_EXTABLE	0x0015	/* 2.5G/5G PMA/PMD extended ability */
+#define MDIO_PCS_EEE_WK_ERR	0x0016	/* EEE wake error counter */
+#define MDIO_PHYXS_LNSTAT	0x0018	/* PHY XGXS lane state */
+#define MDIO_AN_EEE_ADV		0x003C	/* EEE advertisement */
+#define MDIO_AN_EEE_LPABLE	0x003D	/* EEE link partner ability */
+#define MDIO_AN_EEE_ADV2	0x003E	/* EEE advertisement 2 */
+#define MDIO_AN_EEE_LPABLE2	0x003F	/* EEE link partner ability 2 */
+#define MDIO_AN_CTRL2		0x0040	/* AN THP bypass request control */
 
 /* Media-dependent registers. */
-#define MDIO_PMA_10GBT_SWAPPOL	130	/* 10GBASE-T pair swap & polarity */
-#define MDIO_PMA_10GBT_TXPWR	131	/* 10GBASE-T TX power control */
-#define MDIO_PMA_10GBT_SNR	133	/* 10GBASE-T SNR margin, lane A.
+#define MDIO_PMA_10GBT_SWAPPOL	0x0082	/* 10GBASE-T pair swap & polarity */
+#define MDIO_PMA_10GBT_TXPWR	0x0083	/* 10GBASE-T TX power control */
+#define MDIO_PMA_10GBT_SNR	0x0085	/* 10GBASE-T SNR margin, lane A.
 					 * Lanes B-D are numbered 134-136. */
-#define MDIO_PMA_10GBR_FSRT_CSR	147	/* 10GBASE-R fast retrain status and control */
-#define MDIO_PMA_10GBR_FECABLE	170	/* 10GBASE-R FEC ability */
-#define MDIO_PCS_10GBX_STAT1	24	/* 10GBASE-X PCS status 1 */
-#define MDIO_PCS_10GBRT_STAT1	32	/* 10GBASE-R/-T PCS status 1 */
-#define MDIO_PCS_10GBRT_STAT2	33	/* 10GBASE-R/-T PCS status 2 */
-#define MDIO_AN_10GBT_CTRL	32	/* 10GBASE-T auto-negotiation control */
-#define MDIO_AN_10GBT_STAT	33	/* 10GBASE-T auto-negotiation status */
-#define MDIO_B10L_PMA_CTRL	2294	/* 10BASE-T1L PMA control */
-#define MDIO_PMA_10T1L_STAT	2295	/* 10BASE-T1L PMA status */
-#define MDIO_PCS_10T1L_CTRL	2278	/* 10BASE-T1L PCS control */
-#define MDIO_PMA_PMD_BT1	18	/* BASE-T1 PMA/PMD extended ability */
-#define MDIO_AN_T1_CTRL		512	/* BASE-T1 AN control */
-#define MDIO_AN_T1_STAT		513	/* BASE-T1 AN status */
-#define MDIO_AN_T1_ADV_L	514	/* BASE-T1 AN advertisement register [15:0] */
-#define MDIO_AN_T1_ADV_M	515	/* BASE-T1 AN advertisement register [31:16] */
-#define MDIO_AN_T1_ADV_H	516	/* BASE-T1 AN advertisement register [47:32] */
-#define MDIO_AN_T1_LP_L		517	/* BASE-T1 AN LP Base Page ability register [15:0] */
-#define MDIO_AN_T1_LP_M		518	/* BASE-T1 AN LP Base Page ability register [31:16] */
-#define MDIO_AN_T1_LP_H		519	/* BASE-T1 AN LP Base Page ability register [47:32] */
-#define MDIO_AN_10BT1_AN_CTRL	526	/* 10BASE-T1 AN control register */
-#define MDIO_AN_10BT1_AN_STAT	527	/* 10BASE-T1 AN status register */
-#define MDIO_PMA_PMD_BT1_CTRL	2100	/* BASE-T1 PMA/PMD control register */
-#define MDIO_PCS_1000BT1_CTRL	2304	/* 1000BASE-T1 PCS control register */
-#define MDIO_PCS_1000BT1_STAT	2305	/* 1000BASE-T1 PCS status register */
+#define MDIO_PMA_10GBR_FSRT_CSR	0x0093	/* 10GBASE-R fast retrain status and control */
+#define MDIO_PMA_10GBR_FECABLE	0x00AA	/* 10GBASE-R FEC ability */
+#define MDIO_PCS_10GBX_STAT1	0x0018	/* 10GBASE-X PCS status 1 */
+#define MDIO_PCS_10GBRT_STAT1	0x0020	/* 10GBASE-R/-T PCS status 1 */
+#define MDIO_PCS_10GBRT_STAT2	0x0021	/* 10GBASE-R/-T PCS status 2 */
+#define MDIO_AN_10GBT_CTRL	0x0020	/* 10GBASE-T auto-negotiation control */
+#define MDIO_AN_10GBT_STAT	0x0021	/* 10GBASE-T auto-negotiation status */
+#define MDIO_B10L_PMA_CTRL	0x08F6	/* 10BASE-T1L PMA control */
+#define MDIO_PMA_10T1L_STAT	0x08F7	/* 10BASE-T1L PMA status */
+#define MDIO_PCS_10T1L_CTRL	0x08E6	/* 10BASE-T1L PCS control */
+#define MDIO_PMA_PMD_BT1	0x0012	/* BASE-T1 PMA/PMD extended ability */
+#define MDIO_AN_T1_CTRL		0x0200	/* BASE-T1 AN control */
+#define MDIO_AN_T1_STAT		0x0201	/* BASE-T1 AN status */
+#define MDIO_AN_T1_ADV_L	0x0202	/* BASE-T1 AN advertisement register [15:0] */
+#define MDIO_AN_T1_ADV_M	0x0203	/* BASE-T1 AN advertisement register [31:16] */
+#define MDIO_AN_T1_ADV_H	0x0204	/* BASE-T1 AN advertisement register [47:32] */
+#define MDIO_AN_T1_LP_L		0x0205	/* BASE-T1 AN LP Base Page ability register [15:0] */
+#define MDIO_AN_T1_LP_M		0x0206	/* BASE-T1 AN LP Base Page ability register [31:16] */
+#define MDIO_AN_T1_LP_H		0x0207	/* BASE-T1 AN LP Base Page ability register [47:32] */
+#define MDIO_AN_10BT1_AN_CTRL	0x020E	/* 10BASE-T1 AN control register */
+#define MDIO_AN_10BT1_AN_STAT	0x020F	/* 10BASE-T1 AN status register */
+#define MDIO_PMA_PMD_BT1_CTRL	0x0834	/* BASE-T1 PMA/PMD control register */
+#define MDIO_PCS_1000BT1_CTRL	0x0900	/* 1000BASE-T1 PCS control register */
+#define MDIO_PCS_1000BT1_STAT	0x0901	/* 1000BASE-T1 PCS status register */
 
 /* LASI (Link Alarm Status Interrupt) registers, defined by XENPAK MSA. */
 #define MDIO_PMA_LASI_RXCTRL	0x9000	/* RX_ALARM control */
-- 
2.25.1


