Return-Path: <netdev+bounces-105075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0F90F948
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA501C208C5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5015EFCD;
	Wed, 19 Jun 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I6jAH31G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556D15B126;
	Wed, 19 Jun 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836931; cv=none; b=nAxfbU5LG4TMfOVdpweWt/Ss3wgUl2IFhU1KE2nKXOMWfGQi5A/wVjP5CLn/O+5ZTjLazj9GzY9wHohv1MDd8dVv61MojRoldOdYmlJvIpYNh9jQIhHhgOsYbLsxfVOJX1H3mbhFO5bF6waTj66AjHcRdzYgyGWyLKRpca1047I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836931; c=relaxed/simple;
	bh=h+7E7tolpXVthsCVY0aRBpbmdcbkDI3jlRHQFbtzKQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JLz3Cj9tDP7Y37ICzqo4QumsMn1Hn7HWxz3vOx/pKYu/c2WwJ/ayOTDzWQIYsR91jkthdIstEe8URYqcyAD5zP+CCFN1LQOpOw87Faqx+AN7IkJcyLMaYSA93A7uHxJAq8ZvyLkCKsXLkm3zbmwqJSgOFje7zt/OxdjHOj710KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I6jAH31G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JLDtKl028107;
	Wed, 19 Jun 2024 22:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kGNbEjWmntIfDlVgJX8SixwIHR31cFihNRbVn8LQRoU=; b=I6jAH31GTkhMkKrf
	ztlH+XUwhWaju2MtVIRZ4PWcbMEaQwQuFfGnqYK2SsS5WKIIxhVXr2kt1xSEAcxY
	lfQUOg2qW8yuhW2Dda710jqd55vUyl8MzQ+uWmz2U2+cAWFcsJyBbcTyquHfwFK3
	lBnTD1dnXgb9TZxENhV03hVoRSGRo7fzZGrZQHviJ4SYxR8Ego0Waap4zJHv49+E
	/CJZkuXZZtW2wmO4tF2KTiUma/SgdbsyBBpeqT2n+mbXANLz4kH7zEYFgzk8eb5Q
	pBE0tT1Gh/UqPSUbUoPZUvDdi7XpwRExU+Ho98vaSTRd3Wh59vbF0xDLLWX88qnP
	cvD0Pg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujc4jut2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:41:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JMff4n024661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:41:41 GMT
Received: from hu-scheluve-lv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 15:41:38 -0700
From: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Date: Wed, 19 Jun 2024 15:41:30 -0700
Subject: [PATCH 2/3] net: stmmac: Bring down the clocks to lower
 frequencies when mac link goes down
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-icc_bw_voting_from_ethqos-v1-2-6112948b825e@quicinc.com>
References: <20240619-icc_bw_voting_from_ethqos-v1-0-6112948b825e@quicinc.com>
In-Reply-To: <20240619-icc_bw_voting_from_ethqos-v1-0-6112948b825e@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC: <kernel@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sagar Cheluvegowda <quic_scheluve@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rtZMbwd5GG4e4AOekBViDzMnvDFIDVi9
X-Proofpoint-GUID: rtZMbwd5GG4e4AOekBViDzMnvDFIDVi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=986 malwarescore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190171

When mac link goes down we don't need to mainitain the clocks to operate
at higher frequencies, as an optimized solution to save power when
the link goes down we are trying to bring down the clocks to the
frequencies corresponding to the lowest speed possible.

Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..bfb201a4b885 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -990,6 +990,9 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
+	if (priv->plat->fix_mac_speed)
+		priv->plat->fix_mac_speed(priv->plat->bsp_priv, SPEED_10, mode);
+
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	priv->eee_active = false;
 	priv->tx_lpi_enabled = false;

-- 
2.34.1


