Return-Path: <netdev+bounces-207070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5965B0584C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0518C4A4918
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC22D878D;
	Tue, 15 Jul 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJeD3l0Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCD2741A1;
	Tue, 15 Jul 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577387; cv=none; b=jOSrq99YykbFtmFsbYGR8B8rqUCFMu8kb+WjAhyel1ao2eSrCPdBbj48PG+8XyP2gPsjM2L8ficf748002eFtU7NTL68MVNqGlMgUXK0u4bPlM5HCWO/7DF+CgvijliqFZCE1Ck+Nn1J72OCD7AxZb9a8uPllGw1X4EovbHKr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577387; c=relaxed/simple;
	bh=zdIA1OrZ3QwuE1iTyT9RAIBjGDyxK+dHldknrTLLHLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D+3Uycnz3W81eZd7kz/cdkawrOypL8GkfyjzB19OETxWdAyEb5u2sYF3HtYZlQC/r6usg4Jqv5bm2ikHuTf7wDGfDtMZBrJEOFhgbUNKExjy/yeU2cGOPogiXefxBalCXZqWqkzN3cNSmbjPu7rVen8YsEDOmeMvTa3zm3Q2Yuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJeD3l0Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8k5Qx026465;
	Tue, 15 Jul 2025 11:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UxWZKZdiJDX0DMRAQWw1ZpYiBrf/IfhPklk9LZUV/sw=; b=FJeD3l0YUwHyNyUD
	FfFiza3INiF7nBxrbrhQRzRZ0zu4ldqkfhZwNLzyNx6fMxBzWKyXRFszwZM6bR1s
	Su6tvUFU1OQcfLIT2j7JCAMuniG+o7Gv9Xm4wWoLmjacxUvVzdAl3XCD8cW+R7Ws
	rZKMVq/wox5NM/cNeUYSf+CWuxwzQDSW3P+qsT8iXyFo9JeAORiqTRPUs4SzBIes
	dbS7S5P5c8PDWGxaWhAAHMtNRcxQ4jO+RHF5BTz60Ys16CN2TEQIYFV0tGvd4iwa
	Qxmf0R+ScEuAmfYo9l/GQFqqWEGePhvLzbn5HMPpIgPIyVdFifsQSjHADO/QYjrw
	/hMqfQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrugfrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 11:02:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FB2jFV003970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 11:02:45 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 04:02:43 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 15 Jul 2025 19:02:27 +0800
Subject: [PATCH net-next v3 2/3] net: phy: qcom: qca808x: Support PHY
 counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250715-qcom_phy_counter-v3-2-8b0e460a527b@quicinc.com>
References: <20250715-qcom_phy_counter-v3-0-8b0e460a527b@quicinc.com>
In-Reply-To: <20250715-qcom_phy_counter-v3-0-8b0e460a527b@quicinc.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752577357; l=2215;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=zdIA1OrZ3QwuE1iTyT9RAIBjGDyxK+dHldknrTLLHLA=;
 b=DeLTp8f2COmpL6s89gfQrsxZPIrMHcmrPloC3dNA83DHouhd6BSuFAi03TUgQlviMM4XXx7+n
 SC62PXXjcDHC98bj62E8DwrSOj57AJlBX6whSUXsrCXJls7k+Zrv6Zs
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vAh1auAu5Mh_tbE40PM8JsAt9xxbu1DK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwMCBTYWx0ZWRfX2ZGczkuJ9RLU
 LXLGHPSYXDsdhsIPyFg969ePkFnQhs9HH1O76m36QaRvWfd/Au40Xl2uvSKFSJNUhCCb8nEQaDc
 j2jwQ5WX8Odr9afD9T5+8+WdZ7mhbUXLnDl6a+7Nz+C3iBLHy63vCOIrDzhZgGE5EHObvc/39mR
 bKtHlqtwDEELTn/5oAbtWAqVfiyNoZrxfk51BXW0dpleZQARrSjnsGMcb6HRurTJmnFmNwyXHs+
 Rg6rl0o5WHbvgV6vw87loukYPjZwaf9J8h8oXkW4h4PWwchPjhL3NIbCswfp7sK4NGOOLwkZpP7
 AQoL8BhecGkqU3w4+yz7L2dU3Cdvk4w3v2b0WpCbnbr65Bz3NgBX93nPXzjZa/EIrSn7Rag/Uy8
 5nhPb/Ul9mbDhfTcH03orloXF/AVuGkZeR/EpdRTRGvBlsQoeErSW/xsQYL+k+spnI9zpX/O
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=68763556 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=_JwSswBLOsKPZBXwtL4A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vAh1auAu5Mh_tbE40PM8JsAt9xxbu1DK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150100

Enable CRC checking for received and transmitted frames, and configure
counters to clear after being read within config_init() for accurate
counter recording. Additionally, add PHY counter operations and integrate
shared functions.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/qcom/qca808x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 6de16c0eaa08..8eb51b1a006c 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -93,6 +93,7 @@ MODULE_LICENSE("GPL");
 
 struct qca808x_priv {
 	int led_polarity_mode;
+	struct qcom_phy_hw_stats hw_stats;
 };
 
 static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
@@ -243,6 +244,10 @@ static int qca808x_config_init(struct phy_device *phydev)
 
 	qca808x_fill_possible_interfaces(phydev);
 
+	ret = qcom_phy_counter_config(phydev);
+	if (ret)
+		return ret;
+
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
 				     QCA808X_ADC_THRESHOLD_MASK,
@@ -622,6 +627,22 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
 			      active_low ? 0 : QCA808X_LED_ACTIVE_HIGH);
 }
 
+static int qca808x_update_stats(struct phy_device *phydev)
+{
+	struct qca808x_priv *priv = phydev->priv;
+
+	return qcom_phy_update_stats(phydev, &priv->hw_stats);
+}
+
+static void qca808x_get_phy_stats(struct phy_device *phydev,
+				  struct ethtool_eth_phy_stats *eth_stats,
+				  struct ethtool_phy_stats *stats)
+{
+	struct qca808x_priv *priv = phydev->priv;
+
+	qcom_phy_get_stats(stats, priv->hw_stats);
+}
+
 static struct phy_driver qca808x_driver[] = {
 {
 	/* Qualcomm QCA8081 */
@@ -651,6 +672,8 @@ static struct phy_driver qca808x_driver[] = {
 	.led_hw_control_set	= qca808x_led_hw_control_set,
 	.led_hw_control_get	= qca808x_led_hw_control_get,
 	.led_polarity_set	= qca808x_led_polarity_set,
+	.update_stats		= qca808x_update_stats,
+	.get_phy_stats		= qca808x_get_phy_stats,
 }, };
 
 module_phy_driver(qca808x_driver);

-- 
2.34.1


