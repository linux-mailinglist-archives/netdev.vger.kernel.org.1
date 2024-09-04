Return-Path: <netdev+bounces-125301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2A96CB6E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BA8282B26
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5717C203;
	Wed,  4 Sep 2024 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vp7jx3wt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6B17BECC
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494133; cv=none; b=i+eaFgBUj/BVZqrKLFqspGwlaYvQcTJMdACnZhL2EFgqpTSf+uqhroukkwX8F13CfvVPG4m09nLt7lpgTvULgoQjQyGk5RXUz71kaFEtmnHKkaWqQRk7RUK2dNajt18h2MHAzRLz22l5oAPg4VOnQwzd/S1Dr9/GQGKDX4Gm9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494133; c=relaxed/simple;
	bh=jFZXOtYbYX9k1NJ2eVqoulFL+3oC9WhmIL0jz4mMKcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VN/37pKVmWP0Jm7L4RsMRGEIGpSnD+3VMgwbLesWgpb/Mip0EhidbjeqQRMGfOpkQejo/OKwd8kZLJ7zgQ8D8PbhM+bQr0XthD+7chDVaWwz1CqehSOwrajiAhQ7H5sOOdb09vQhUKzDpUHEZ6ccVj3BsOb0Koifn/fsRNyaDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vp7jx3wt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484LFOfk005033;
	Wed, 4 Sep 2024 23:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=68k4qQEoXrGyQZBkFjNkcJ8HHmo7tapvZuW
	iVrbuvvs=; b=Vp7jx3wtzuHOjDSd0PLoDYU/VDEbeAUfG4Pp+I7tcnjTiECC3TA
	XwulwtEYLp3c5ruWVR6mlSkJyrTgXjttSnCpYWzjPpkmWOsJApV9P9J5nn/wnBwu
	iGVmusXgF8nyobbxIXpmwmMXOMdK+p/admyNo+QmXGttTVeUoQgYxjEbAWQkDtPk
	seCTJTA+nJ9qYeV2rb/y1BR/pHKD4l1W8X5hCq2u17iYx3H2jkQhOUFvg+5rzGa/
	KV1/FcWhCL5IBOF6kmbtzkYXk3wKP2WsPKU9C50sqElKCIMJRJ/jBO8J1mZgwaTU
	REVgDwbJ+vU1ThIj8W+eehp7lYZCuzKKwHg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bvbkm3ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 23:54:58 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 484NsvAY007763;
	Wed, 4 Sep 2024 23:54:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 41ecqfsxu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 23:54:57 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 484NsvGS007756;
	Wed, 4 Sep 2024 23:54:57 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 484Nsu1E007684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 23:54:57 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id B2864229B8; Wed,  4 Sep 2024 16:54:56 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Andrew Halaney <ahalaney@redhat.com>
Cc: kernel@quicinc.com
Subject: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN packets with split header
Date: Wed,  4 Sep 2024 16:54:56 -0700
Message-Id: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UMBGnH4pK9QdSnfrwN1xWdpJAAWraeKe
X-Proofpoint-GUID: UMBGnH4pK9QdSnfrwN1xWdpJAAWraeKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_21,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040180

Currently reset state configuration of split header works fine for
non-tagged packets and we see no corruption in payload of any size

We need additional programming sequence with reset configuration to
handle VLAN tagged packets to avoid corruption in payload for packets
of size greater than 256 bytes.

Without this change ping application complains about corruption
in payload when the size of the VLAN packet exceeds 256 bytes.

With this change tagged and non-tagged packets of any size works fine
and there is no corruption seen.

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v0
- The reason for posting it on net-next is to enable this new feature.

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     |  9 +++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 93a78fd0737b..4e340937dc78 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -44,6 +44,7 @@
 #define GMAC_MDIO_DATA			0x00000204
 #define GMAC_GPIO_STATUS		0x0000020C
 #define GMAC_ARP_ADDR			0x00000210
+#define GMAC_EXT_CFG1			0x00000238
 #define GMAC_ADDR_HIGH(reg)		(0x300 + reg * 8)
 #define GMAC_ADDR_LOW(reg)		(0x304 + reg * 8)
 #define GMAC_L3L4_CTRL(reg)		(0x900 + (reg) * 0x30)
@@ -235,6 +236,14 @@ enum power_event {
 #define GMAC_CONFIG_HDSMS_SHIFT		20
 #define GMAC_CONFIG_HDSMS_256		(0x2 << GMAC_CONFIG_HDSMS_SHIFT)
 
+/* MAC extended config1 */
+#define GMAC_CONFIG1_SAVE_EN		BIT(24)
+#define GMAC_CONFIG1_SPLM		GENMASK(9, 8)
+#define GMAC_CONFIG1_SPLM_L2OFST_EN	BIT(0)
+#define GMAC_CONFIG1_SPLM_SHIFT		8
+#define GMAC_CONFIG1_SAVO		GENMASK(22, 16)
+#define GMAC_CONFIG1_SAVO_SHIFT		16
+
 /* MAC HW features0 bitmap */
 #define GMAC_HW_FEAT_SAVLANINS		BIT(27)
 #define GMAC_HW_FEAT_ADDMAC		BIT(18)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index e0165358c4ac..dbd1be4e4a92 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -526,6 +526,17 @@ static void dwmac4_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value |= GMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
 	writel(value, ioaddr + GMAC_EXT_CONFIG);
 
+	/* Additional configuration to handle VLAN tagged packets */
+	value = readl(ioaddr + GMAC_EXT_CFG1);
+	value &= ~GMAC_CONFIG1_SPLM;
+	/* Enable Split mode for header and payload at L2  */
+	value |= GMAC_CONFIG1_SPLM_L2OFST_EN << GMAC_CONFIG1_SPLM_SHIFT;
+	value &= ~GMAC_CONFIG1_SAVO;
+	/* Enables the MAC to distinguish between tagged vs untagged pkts */
+	value |= 4 << GMAC_CONFIG1_SAVO_SHIFT;
+	value |= GMAC_CONFIG1_SAVE_EN;
+	writel(value, ioaddr + GMAC_EXT_CFG1);
+
 	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
 	if (en)
 		value |= DMA_CONTROL_SPH;
-- 
2.25.1


