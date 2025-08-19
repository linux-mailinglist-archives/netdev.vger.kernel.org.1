Return-Path: <netdev+bounces-214879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666B1B2B996
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F050B3A2745
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205126D4CF;
	Tue, 19 Aug 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZW++GaR6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97026CE22
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585405; cv=none; b=FXTGTNQ69SXTZhk/XT7Qjdaov0qHryECOxgd8pOodXnNRcJhqx/HDy9TxZe9Fqtyj69qfb5O3lqL/pFGSRay+f3xkhiWpxVcpWmC4dnyyd/YHdtuyPq7pU1ppglpd3LgvAboDg2lIR4r6ZuWSXV9Q+xQsOZNcLZLiRb/ufy6tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585405; c=relaxed/simple;
	bh=rgkE1DP1easYS6YslKYK9Bbq9OWK3nty3gdcQhkYooc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Intl1VaKdot90Jsy7BXW6PCRzIoROZ2Tp+mcXCl/Xvnn7hzwT7wbXrRjXab3zVNR0uwqAKWJS2fCxOn+qbkCKxtpI9FsA5Z+tqVQxlRl4uge6V+CZSo3N308ESecMrLKVbpkKRYwYt92l9uY7WbpfhwNAO/Jcrumd+iYNg4Gm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZW++GaR6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILfb1c025278
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWZPw+Dpps6jokruu2kK5mo0seIUmSLFHBR/QVxbsPI=; b=ZW++GaR6r2FuhTkw
	9b5wRt5o8NYv2lIEhyRloLp1OufW5ndt4sDKqW6IbiUGfuJghLP/y8yObQhdQ8BV
	JLidfzkhERA4FNb3mqGOzKEwnG2JacuY9azj6mMDlZrfyHn+5LXWcecpvhZw3CYf
	6Kejwh9NwHSRnLAcxlnFY2vedyVkCdvC4ZFkd2w+cX++mpSqJok9c0pZKqr8RKxy
	Jn6VM2NoDbkvOuHKM8hH7CAGA+QEF2AT7MKelyp8dRkZ0VYmlLcVYcKqxJgCsJVL
	ksmBWCgKDWd+uRZr75vwdgdbHX+B7i7M5oqIdALqfEZANG6g9ao/66Bal86onM5O
	DsGPYw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5h58v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458121274so59939195ad.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585402; x=1756190202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWZPw+Dpps6jokruu2kK5mo0seIUmSLFHBR/QVxbsPI=;
        b=mG55trw/S5cnE3NWZgVwPnOjrh8UasnlU9C/dA+FAyQIpT1JN1Nqx4iIBwSJo3Nv7v
         KX1XD4w8LUqMU/7uOmVMvrpMxxOuwztMD+tUEm6BF18yCPCjSqir1YgTinB6WyygGtUG
         izHRFE4Hpg08dk8fiLQDzlWMVCT13kLqsyfB+JJWSqhFMFhnBZTipwfXQeBRKGPaoInF
         VoBmetsQ9wZ23/EawaHOlSAN4GnODta5B1Av8ph1QVPJEjZcaHr/bYXNTjRa7jWE0ETK
         LSfilSo5SImu25WGi5qrGEzbSnUFoRgapMz2SfYv8kd8YAtpvuvvEdtsRAtUEGaBxf7M
         27FA==
X-Gm-Message-State: AOJu0Yx944ApuFuWciDUZB8Y5khonH2vJi2riDnKNmcnX5NYCG6zLYp+
	WRTqnxuT24ZVPr9ypB04pDIBG2M/Ewb/h/5HZstRa1cRonFeUuzLkJwuTJ8bmtnTUUK0CbJMura
	ixun9UAU/4LyOoKtubwUN5Yn2UmFjfE98fdjD5fxmUM9o+k7KHEH8zNyEjnU=
X-Gm-Gg: ASbGncuAdDSFQ1yPM9sP3AV2uZcFpW+G2ATO99389AsoBTqBs6bb6SyzGVUp5E/ClRp
	FLWoXi31p67bLcVqTQ4XtlOeBdh24bVC2qB3qcJsXBV0ZML69BODO3FSn6qT6ajvnbHWtlWnO3j
	MCzZj2O5qG7GBz4FLyNGP9oue/i4lkFINdB5zzbs43w+ugOJ6YGxNEbiMgCQlHyR7CrnuDGv440
	99SXXEhcm3+yMLxbkmdMb2gSmO5w8o2NixT37LJOv35ESZAfYsf0v7Mus7Q/l7dUf8yMhEAxdxX
	IuOR+o95AiFwNcAMZ/ghfLScjvxZo+pzVkqhXthDguDQoEkbc1EFZ3LDgIt0O/et4+8YOLbGPG5
	UpvciV95Zxzt1OjbEDaVUNNGkhDANruO7og==
X-Received: by 2002:a17:903:234c:b0:234:cf24:3be8 with SMTP id d9443c01a7336-245e0541d6dmr14369095ad.28.1755585402152;
        Mon, 18 Aug 2025 23:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/lNABQK/kpg0X2OhEKp4HNBmGeNVvVA1WkA/paFD5ccWwopJ2tFxVPde1x3VdbYJUHJCYg==
X-Received: by 2002:a17:903:234c:b0:234:cf24:3be8 with SMTP id d9443c01a7336-245e0541d6dmr14368825ad.28.1755585401656;
        Mon, 18 Aug 2025 23:36:41 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:36:41 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:35:56 +0800
Subject: [PATCH v4 1/6] net: stmmac: Add support for 10 Mbps and 100 Mbps
 Ethernet speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-1-5050ed3402cb@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
In-Reply-To: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585388; l=1721;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=rgkE1DP1easYS6YslKYK9Bbq9OWK3nty3gdcQhkYooc=;
 b=lAzLbqBZgwScoYObFRiDqWfMrCAW8S5NgGjq7r08AjwHO1jUwef1A+841LP3ckCJ1R1EY5YEH
 4cuvivCRLNeDSw954otmMxHK0W9KcjsGR/NaRz4uxt+wTDkP5NVaIVl
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a41b7b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VHUZ9mhHZOqmV8q2ncwA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: T4mvnuYHvGQiHdxE-zeU57GNdpIqCABo
X-Proofpoint-GUID: T4mvnuYHvGQiHdxE-zeU57GNdpIqCABo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX9Ms6JLPIGAMz
 Gtod6VapibPKLqJcaVfraiqrHjtWRr6dkPdrjsUGIstr5J777WdPZt+HNVlZKC69udYyuP7gMb/
 wXsCcAZ63NICfH469qJrGy5evT3iX2aW8QZ2Rj9GioURAWF9dFve64NLWehZdKtjXAadQKqdSJY
 SLjiOXnkmU4rIddiHZLlu78S3rlcykUm0A4nfQI49eHacQIQrz4ys09PM0rvS+eqL5OYM1D0JEF
 s1izywIdvgzhWh/OtFyTeRXFn+dutML2BNyF8XKTtSBobkYD2TJyYYFafmFxDxIRNAN+EEGbjZ2
 f/ooOPWVJbOK+TaWWismxCTDbPk2OFaOhmEKLuT558DJqpbzpiPmNdv/xLNAd4W60rMugs7E24r
 gSXAhkGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

The DLL is a Qualcomm-specific hardware component integrated within the
MAC and should be configured in bypass mode for 10 Mbps and 100 Mbps
speeds. If not bypassed, the timing delay will be incorrectly applied,
which will disrupt signal sampling.

Fixes: a7c30e62d4b8 ("net: stmmac: Add driver for Qualcomm ethqos")
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d8fd4d8f6ced..a4ea72f86ca8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -64,6 +64,9 @@
 #define SDCC_DLL_CONFIG2_DDR_TRAFFIC_INIT_SW	BIT(1)
 #define SDCC_DLL_CONFIG2_DDR_CAL_EN		BIT(0)
 
+/* SDCC_USR_CTL fields */
+#define SDCC_USR_CTL_DLL_BYPASS			BIT(30)
+
 /* SDC4_STATUS bits */
 #define SDC4_STATUS_DLL_LOCK			BIT(7)
 
@@ -609,6 +612,17 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
 	if (speed == SPEED_1000)
 		ethqos_dll_configure(ethqos);
 
+	/* The DLL (Delay Locked Loop) aligns the clock and samples data
+	 * in RGMII interfaces. It should be bypassed for 10 Mbps and
+	 * 100 Mbps speeds.
+	 */
+	if (speed == SPEED_10 || speed == SPEED_100) {
+		rgmii_updatel(ethqos, SDCC_DLL_CONFIG_PDN, SDCC_DLL_CONFIG_PDN,
+			      SDCC_HC_REG_DLL_CONFIG);
+		rgmii_updatel(ethqos, SDCC_USR_CTL_DLL_BYPASS,
+			      SDCC_USR_CTL_DLL_BYPASS, SDCC_USR_CTL);
+	}
+
 	ethqos_rgmii_macro_init(ethqos, speed);
 
 	return 0;

-- 
2.34.1


