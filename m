Return-Path: <netdev+bounces-140984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F29B8F4D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469EE1F22E72
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF919E7E3;
	Fri,  1 Nov 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K6Q434Zv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8A18FC7F;
	Fri,  1 Nov 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457318; cv=none; b=QaDx+AtC8lS9j+1wYTvr4KLhlQlXqPJzOhVFZ8APu7KQVObT7MumLfeeB06dEFxjaOvs+QShSjXnCCUtdecS6lyWekn6s2H4VFXANj6S1vny5OXIjWRLNdcgGYUgAFaCPXdbK+/+1f4Mexb9ElT/+wwamaXgAg8PafI8K4VMXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457318; c=relaxed/simple;
	bh=bebEFil+SSN5X457CqYRRNV8UXgv/s7PAdEWyzCe1Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q1nbfFbBnp7GfWIgK25PztyIzS8VlkCsgWNsZz39Ke1PkBhLkkgTzbyNYr5i3I6ieQ4pYwv2j3dcPiM+G+brj5Uny7Io9y8Zm3FfDGScj9lL4JN0gxVFuMNA52W4p6NBxy0y0wpxkoTPNPlG/hfaoJ65BCch7J7RcYOJPuoyWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K6Q434Zv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A19qCdQ006410;
	Fri, 1 Nov 2024 10:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wu+efcj0Oo6l2pkStofY5kptl2ZkwZAabmJBbkdLYIE=; b=K6Q434Zv/fN1cKIR
	TW4nfcZMtwOqq2hFN6/aHtsU1d9ZG2ubKx/DsMEQxJ9H85L0eLqmjRl7Zyl8Oc2H
	4z8kwCUmJQ7kHXa5ufXcQ0QpiOvITjx63JnIGeopGJqTHfrnrIYDnhx6pcK+yD9q
	DeMPXPGrJpluSQhAq+6CJeN5p7rz0qHD6sMAUmoiA5WJbKNIKby4donAALT30W8I
	gejRZOs1d1JYGWmHydRwQws+IuGa7h96Uk6dgXBDwmgocpzcjd3MhUa9vHM+mRej
	5E3a/fXc3x3hZjvlSHF2GSWJ4BTydp1+8a+rOSMNGGm0V4D6LV0NL0Ff73PrdPF7
	BeVF7A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ku65dnm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 10:35:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1AZ016023524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 10:35:00 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 03:34:53 -0700
From: Lei Wei <quic_leiwei@quicinc.com>
Date: Fri, 1 Nov 2024 18:32:51 +0800
Subject: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
In-Reply-To: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_luoj@quicinc.com>,
        <quic_leiwei@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730457277; l=14076;
 i=quic_leiwei@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=bebEFil+SSN5X457CqYRRNV8UXgv/s7PAdEWyzCe1Is=;
 b=1ag6jWFW8v9efEggUVKXpRkMoOajDATO6EF5HXYDlFfRTcon79UOVT+8dWQWraQBaIaLXXq+/
 QG1/zVQJo+xDFFn3E7xOfu9WIWx+IdMLAtzSh6adk7eU8fsJKxR49Dc
X-Developer-Key: i=quic_leiwei@quicinc.com; a=ed25519;
 pk=uFXBHtxtDjtIrTKpDEZlMLSn1i/sonZepYO8yioKACM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yk-gTq8CMTJE2ZZvAWuCntUEfc6vBZJO
X-Proofpoint-ORIG-GUID: Yk-gTq8CMTJE2ZZvAWuCntUEfc6vBZJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411010076

This patch adds the following PCS functionality for the PCS driver
for IPQ9574 SoC:

a.) PCS instance create and destroy APIs. The network driver calls
the PCS create API to create and associate the PCS instance with
the port MAC. The PCS MII RX and TX clocks are also enabled in the
PCS create API.
b.) PCS phylink operations for SGMII/QSGMII interface modes.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
---
 drivers/net/pcs/pcs-qcom-ipq.c   | 455 +++++++++++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-qcom-ipq.h |  16 ++
 2 files changed, 471 insertions(+)

diff --git a/drivers/net/pcs/pcs-qcom-ipq.c b/drivers/net/pcs/pcs-qcom-ipq.c
index e065bc61cd14..dd432303b549 100644
--- a/drivers/net/pcs/pcs-qcom-ipq.c
+++ b/drivers/net/pcs/pcs-qcom-ipq.c
@@ -6,12 +6,49 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pcs/pcs-qcom-ipq.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/net/pcs-qcom-ipq.h>
 
+/* Maximum number of MIIs per PCS instance. There are 5 MIIs for PSGMII. */
+#define PCS_MAX_MII_NRS			5
+
+#define PCS_CALIBRATION			0x1e0
+#define PCS_CALIBRATION_DONE		BIT(7)
+
+#define PCS_MODE_CTRL			0x46c
+#define PCS_MODE_SEL_MASK		GENMASK(12, 8)
+#define PCS_MODE_SGMII			FIELD_PREP(PCS_MODE_SEL_MASK, 0x4)
+#define PCS_MODE_QSGMII			FIELD_PREP(PCS_MODE_SEL_MASK, 0x1)
+#define PCS_MODE_AN_MODE		BIT(0)
+
+#define PCS_MII_CTRL(x)			(0x480 + 0x18 * (x))
+#define PCS_MII_ADPT_RESET		BIT(11)
+#define PCS_MII_FORCE_MODE		BIT(3)
+#define PCS_MII_SPEED_MASK		GENMASK(2, 1)
+#define PCS_MII_SPEED_1000		FIELD_PREP(PCS_MII_SPEED_MASK, 0x2)
+#define PCS_MII_SPEED_100		FIELD_PREP(PCS_MII_SPEED_MASK, 0x1)
+#define PCS_MII_SPEED_10		FIELD_PREP(PCS_MII_SPEED_MASK, 0x0)
+
+#define PCS_MII_STS(x)			(0x488 + 0x18 * (x))
+#define PCS_MII_LINK_STS		BIT(7)
+#define PCS_MII_STS_DUPLEX_FULL		BIT(6)
+#define PCS_MII_STS_SPEED_MASK		GENMASK(5, 4)
+#define PCS_MII_STS_SPEED_10		0
+#define PCS_MII_STS_SPEED_100		1
+#define PCS_MII_STS_SPEED_1000		2
+#define PCS_MII_STS_PAUSE_TX_EN		BIT(1)
+#define PCS_MII_STS_PAUSE_RX_EN		BIT(0)
+
+#define PCS_PLL_RESET			0x780
+#define PCS_ANA_SW_RESET		BIT(6)
+
 #define XPCS_INDIRECT_ADDR		0x8000
 #define XPCS_INDIRECT_AHB_ADDR		0x83fc
 #define XPCS_INDIRECT_ADDR_H		GENMASK(20, 8)
@@ -27,12 +64,428 @@ struct ipq_pcs {
 	struct regmap *regmap;
 	phy_interface_t interface;
 
+	/* Lock to protect PCS configurations shared by multiple MII ports */
+	struct mutex config_lock;
+
 	/* RX clock supplied to NSSCC */
 	struct clk_hw rx_hw;
 	/* TX clock supplied to NSSCC */
 	struct clk_hw tx_hw;
 };
 
+/* PCS MII clock ID */
+enum {
+	PCS_MII_RX_CLK,
+	PCS_MII_TX_CLK,
+	PCS_MII_CLK_MAX
+};
+
+/* PCS MII clock name */
+static const char *const pcs_mii_clk_name[PCS_MII_CLK_MAX] = {
+	"mii_rx",
+	"mii_tx",
+};
+
+/* Per PCS MII private data */
+struct ipq_pcs_mii {
+	struct ipq_pcs *qpcs;
+	struct phylink_pcs pcs;
+	int index;
+
+	/* Rx/Tx clocks from NSSCC to PCS MII */
+	struct clk *clk[PCS_MII_CLK_MAX];
+};
+
+#define phylink_pcs_to_qpcs_mii(_pcs)	\
+	container_of(_pcs, struct ipq_pcs_mii, pcs)
+
+static void ipq_pcs_get_state_sgmii(struct ipq_pcs *qpcs,
+				    int index,
+				    struct phylink_link_state *state)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(qpcs->regmap, PCS_MII_STS(index), &val);
+	if (ret) {
+		state->link = 0;
+		return;
+	}
+
+	state->link = !!(val & PCS_MII_LINK_STS);
+
+	if (!state->link)
+		return;
+
+	switch (FIELD_GET(PCS_MII_STS_SPEED_MASK, val)) {
+	case PCS_MII_STS_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	case PCS_MII_STS_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case PCS_MII_STS_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	default:
+		state->link = false;
+		return;
+	}
+
+	if (val & PCS_MII_STS_DUPLEX_FULL)
+		state->duplex = DUPLEX_FULL;
+	else
+		state->duplex = DUPLEX_HALF;
+
+	if (val & PCS_MII_STS_PAUSE_TX_EN)
+		state->pause |= MLO_PAUSE_TX;
+
+	if (val & PCS_MII_STS_PAUSE_RX_EN)
+		state->pause |= MLO_PAUSE_RX;
+}
+
+static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
+			       phy_interface_t interface)
+{
+	unsigned int val;
+	int ret;
+
+	/* Configure PCS interface mode */
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		/* Select Qualcomm SGMII AN mode */
+		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
+					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
+					 PCS_MODE_SGMII);
+		if (ret)
+			return ret;
+		break;
+	case PHY_INTERFACE_MODE_QSGMII:
+		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
+					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
+					 PCS_MODE_QSGMII);
+		if (ret)
+			return ret;
+		break;
+	default:
+		dev_err(qpcs->dev,
+			"Unsupported interface %s\n", phy_modes(interface));
+		return -EOPNOTSUPP;
+	}
+
+	/* PCS PLL reset */
+	ret = regmap_update_bits(qpcs->regmap, PCS_PLL_RESET,
+				 PCS_ANA_SW_RESET, 0);
+	if (ret)
+		return ret;
+
+	fsleep(1000);
+	ret = regmap_update_bits(qpcs->regmap, PCS_PLL_RESET,
+				 PCS_ANA_SW_RESET, PCS_ANA_SW_RESET);
+	if (ret)
+		return ret;
+
+	/* Wait for calibration completion */
+	ret = regmap_read_poll_timeout(qpcs->regmap, PCS_CALIBRATION,
+				       val, val & PCS_CALIBRATION_DONE,
+				       1000, 100000);
+	if (ret) {
+		dev_err(qpcs->dev, "PCS calibration timed-out\n");
+		return ret;
+	}
+
+	qpcs->interface = interface;
+
+	return 0;
+}
+
+static int ipq_pcs_config_sgmii(struct ipq_pcs *qpcs,
+				int index,
+				unsigned int neg_mode,
+				phy_interface_t interface)
+{
+	int ret;
+
+	/* Access to PCS registers such as PCS_MODE_CTRL which are
+	 * common to all MIIs, is lock protected and configured
+	 * only once. This is required only for interface modes
+	 * such as QSGMII.
+	 */
+	if (interface == PHY_INTERFACE_MODE_QSGMII)
+		mutex_lock(&qpcs->config_lock);
+
+	if (qpcs->interface != interface) {
+		ret = ipq_pcs_config_mode(qpcs, interface);
+		if (ret)
+			goto err;
+	}
+
+	if (interface == PHY_INTERFACE_MODE_QSGMII)
+		mutex_unlock(&qpcs->config_lock);
+
+	/* Nothing to do here as in-band autoneg mode is enabled
+	 * by default for each PCS MII port.
+	 */
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		return 0;
+
+	/* Set force speed mode */
+	return regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
+				  PCS_MII_FORCE_MODE, PCS_MII_FORCE_MODE);
+
+err:
+	if (interface == PHY_INTERFACE_MODE_QSGMII)
+		mutex_unlock(&qpcs->config_lock);
+
+	return ret;
+}
+
+static int ipq_pcs_link_up_config_sgmii(struct ipq_pcs *qpcs,
+					int index,
+					unsigned int neg_mode,
+					int speed)
+{
+	int ret;
+
+	/* PCS speed need not be configured if in-band autoneg is enabled */
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		goto pcs_adapter_reset;
+
+	/* PCS speed set for force mode */
+	switch (speed) {
+	case SPEED_1000:
+		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
+					 PCS_MII_SPEED_MASK,
+					 PCS_MII_SPEED_1000);
+		if (ret)
+			return ret;
+		break;
+	case SPEED_100:
+		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
+					 PCS_MII_SPEED_MASK, PCS_MII_SPEED_100);
+		if (ret)
+			return ret;
+		break;
+	case SPEED_10:
+		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
+					 PCS_MII_SPEED_MASK, PCS_MII_SPEED_10);
+		if (ret)
+			return ret;
+		break;
+	default:
+		dev_err(qpcs->dev, "Invalid SGMII speed %d\n", speed);
+		return -EINVAL;
+	}
+
+pcs_adapter_reset:
+	/* PCS adapter reset */
+	ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
+				 PCS_MII_ADPT_RESET, 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
+				  PCS_MII_ADPT_RESET, PCS_MII_ADPT_RESET);
+}
+
+static void ipq_pcs_get_state(struct phylink_pcs *pcs,
+			      struct phylink_link_state *state)
+{
+	struct ipq_pcs_mii *qpcs_mii = phylink_pcs_to_qpcs_mii(pcs);
+	struct ipq_pcs *qpcs = qpcs_mii->qpcs;
+	int index = qpcs_mii->index;
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		ipq_pcs_get_state_sgmii(qpcs, index, state);
+		break;
+	default:
+		break;
+	}
+
+	dev_dbg(qpcs->dev,
+		"mode=%s/%s/%s link=%u\n",
+		phy_modes(state->interface),
+		phy_speed_to_str(state->speed),
+		phy_duplex_to_str(state->duplex),
+		state->link);
+}
+
+static int ipq_pcs_config(struct phylink_pcs *pcs,
+			  unsigned int neg_mode,
+			  phy_interface_t interface,
+			  const unsigned long *advertising,
+			  bool permit)
+{
+	struct ipq_pcs_mii *qpcs_mii = phylink_pcs_to_qpcs_mii(pcs);
+	struct ipq_pcs *qpcs = qpcs_mii->qpcs;
+	int index = qpcs_mii->index;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		return ipq_pcs_config_sgmii(qpcs, index, neg_mode, interface);
+	default:
+		dev_err(qpcs->dev,
+			"Unsupported interface %s\n", phy_modes(interface));
+		return -EOPNOTSUPP;
+	};
+}
+
+static void ipq_pcs_link_up(struct phylink_pcs *pcs,
+			    unsigned int neg_mode,
+			    phy_interface_t interface,
+			    int speed, int duplex)
+{
+	struct ipq_pcs_mii *qpcs_mii = phylink_pcs_to_qpcs_mii(pcs);
+	struct ipq_pcs *qpcs = qpcs_mii->qpcs;
+	int index = qpcs_mii->index;
+	int ret;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		ret = ipq_pcs_link_up_config_sgmii(qpcs, index,
+						   neg_mode, speed);
+		break;
+	default:
+		dev_err(qpcs->dev,
+			"Unsupported interface %s\n", phy_modes(interface));
+		return;
+	}
+
+	if (ret)
+		dev_err(qpcs->dev, "PCS link up fail for interface %s\n",
+			phy_modes(interface));
+}
+
+static const struct phylink_pcs_ops ipq_pcs_phylink_ops = {
+	.pcs_get_state = ipq_pcs_get_state,
+	.pcs_config = ipq_pcs_config,
+	.pcs_link_up = ipq_pcs_link_up,
+};
+
+/**
+ * ipq_pcs_create() - Create an IPQ PCS MII instance
+ * @np: Device tree node to the PCS MII
+ *
+ * Description: Create a phylink PCS instance for the given PCS MII node @np
+ * and enable the MII clocks. This instance is associated with the specific
+ * MII of the PCS and the corresponding Ethernet netdevice.
+ *
+ * Return: A pointer to the phylink PCS instance or an error-pointer value.
+ */
+struct phylink_pcs *ipq_pcs_create(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct ipq_pcs_mii *qpcs_mii;
+	struct device_node *pcs_np;
+	struct ipq_pcs *qpcs;
+	int i, ret;
+	u32 index;
+
+	if (!of_device_is_available(np))
+		return ERR_PTR(-ENODEV);
+
+	if (of_property_read_u32(np, "reg", &index))
+		return ERR_PTR(-EINVAL);
+
+	if (index >= PCS_MAX_MII_NRS)
+		return ERR_PTR(-EINVAL);
+
+	pcs_np = of_get_parent(np);
+	if (!pcs_np)
+		return ERR_PTR(-ENODEV);
+
+	if (!of_device_is_available(pcs_np)) {
+		of_node_put(pcs_np);
+		return ERR_PTR(-ENODEV);
+	}
+
+	pdev = of_find_device_by_node(pcs_np);
+	of_node_put(pcs_np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	qpcs = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
+
+	/* If probe is not yet completed, return DEFER to
+	 * the dependent driver.
+	 */
+	if (!qpcs)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	qpcs_mii = kzalloc(sizeof(*qpcs_mii), GFP_KERNEL);
+	if (!qpcs_mii)
+		return ERR_PTR(-ENOMEM);
+
+	qpcs_mii->qpcs = qpcs;
+	qpcs_mii->index = index;
+	qpcs_mii->pcs.ops = &ipq_pcs_phylink_ops;
+	qpcs_mii->pcs.neg_mode = true;
+	qpcs_mii->pcs.poll = true;
+
+	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
+		qpcs_mii->clk[i] = of_clk_get_by_name(np, pcs_mii_clk_name[i]);
+		if (IS_ERR(qpcs_mii->clk[i])) {
+			dev_err(qpcs->dev,
+				"Failed to get MII %d interface clock %s\n",
+				index, pcs_mii_clk_name[i]);
+			goto err_clk_get;
+		}
+
+		ret = clk_prepare_enable(qpcs_mii->clk[i]);
+		if (ret) {
+			dev_err(qpcs->dev,
+				"Failed to enable MII %d interface clock %s\n",
+				index, pcs_mii_clk_name[i]);
+			goto err_clk_en;
+		}
+	}
+
+	return &qpcs_mii->pcs;
+
+err_clk_en:
+	clk_put(qpcs_mii->clk[i]);
+err_clk_get:
+	while (i) {
+		i--;
+		clk_disable_unprepare(qpcs_mii->clk[i]);
+		clk_put(qpcs_mii->clk[i]);
+	}
+
+	kfree(qpcs_mii);
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL(ipq_pcs_create);
+
+/**
+ * ipq_pcs_destroy() - Destroy the IPQ PCS MII instance
+ * @pcs: PCS instance
+ *
+ * Description: Destroy a phylink PCS instance.
+ */
+void ipq_pcs_destroy(struct phylink_pcs *pcs)
+{
+	struct ipq_pcs_mii *qpcs_mii;
+	int i;
+
+	if (!pcs)
+		return;
+
+	qpcs_mii = phylink_pcs_to_qpcs_mii(pcs);
+
+	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
+		clk_disable_unprepare(qpcs_mii->clk[i]);
+		clk_put(qpcs_mii->clk[i]);
+	}
+
+	kfree(qpcs_mii);
+}
+EXPORT_SYMBOL(ipq_pcs_destroy);
+
 static unsigned long ipq_pcs_clk_rate_get(struct ipq_pcs *qpcs)
 {
 	switch (qpcs->interface) {
@@ -219,6 +672,8 @@ static int ipq_pcs_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mutex_init(&qpcs->config_lock);
+
 	platform_set_drvdata(pdev, qpcs);
 
 	return 0;
diff --git a/include/linux/pcs/pcs-qcom-ipq.h b/include/linux/pcs/pcs-qcom-ipq.h
new file mode 100644
index 000000000000..f72a895afaba
--- /dev/null
+++ b/include/linux/pcs/pcs-qcom-ipq.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#ifndef __LINUX_PCS_QCOM_IPQ_H
+#define __LINUX_PCS_QCOM_IPQ_H
+
+struct device_node;
+struct phylink_pcs;
+
+struct phylink_pcs *ipq_pcs_create(struct device_node *np);
+void ipq_pcs_destroy(struct phylink_pcs *pcs);
+
+#endif /* __LINUX_PCS_QCOM_IPQ_H */

-- 
2.34.1


