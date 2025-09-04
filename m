Return-Path: <netdev+bounces-220016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBFFB44336
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910C2A41455
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647543126C5;
	Thu,  4 Sep 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XKG6ow57"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51B313E1F
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003993; cv=none; b=Unk4jOw2OLsAztfPo9DZ6oCt0CjDzaHwxkaaW/sBX2lYHxVBx3QuYle8OdOmcOellilCB0yQtxNDvfmGnw0CRuHADA73x2rTq+YLmm0+WKLJVAooqNllaEhE7PI3PNAzx5pQ7OceQyNMfZNim3Ywx77nXY4Y4Imawlg5whkZro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003993; c=relaxed/simple;
	bh=smFcX8ezCgxfaauQ11dA4JFPET3ZGgByEqRN3eXWKdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+b0t0b+uFuNYKTP5J/xbf2cpXFZTEOdvrMFdDPMh1FBa0L2P8qwLg/+T/lFVjA8K2uSCBT8RdLDHxSJT/j1owQ2yOyz4rmTONNcsLb7yMvPROJRuSMmREFg964SOz80AIKEPCh7Ibx+carHVdtmOQh8XU/3HGze8BLFf321s0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XKG6ow57; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XIVS012235
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbq+DXdSP7cwBiqe8xvfggttCay/BKrNEnQjjAGNbvU=; b=XKG6ow57Au3OTTNb
	fNt5VvZsxQgDbMqrvnLKz1HdO8W7RUsKIU1mqQYe+7DoN3XmOL9NcAOOSvDcwb2j
	aJbQkluaShj25UAK8LaIcfLrqDNte1STSVf7MYWVIlE5TavBKtDgCAySIv130xiE
	iEdUAEpKqZ5zWJ9KmRvlg8F49nNd8GlHR2UK/YfXZ0pEPpdHW95Nv8Cl0+J8YMuH
	BCSr4ZwQ0hOYooHYiV2iIxKiRBzkBX6QO7wf3xvyTSWNZe6DmuIDDWp2MGLDvLFW
	67ldR8J42/K5DPsyMHy5sLgkrIs83ePZ9szy4CadIUOMazs9qHYatmjU9j7++sX5
	nqVL5A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj4nss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:39:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so1451687a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003990; x=1757608790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbq+DXdSP7cwBiqe8xvfggttCay/BKrNEnQjjAGNbvU=;
        b=HcUw+4+4wN2rbublMugVa7j5VbMGJoDt0CSfl+Y7j9AcCJFhor4FimnlFXrL589GX2
         aTOG/N0hF3jwg7APhwxHAey1vFJXqx+AVxHycRfoFhHROsO79IoX8BNYPcROrOZIAdFJ
         knLZB866WD2nr9rgLGBIzBh+ArSzIbO+Rt2i+NwzWS2yFkIisDKr4jX/KDFyrFl5vH4U
         TmBaEJMy9Xo1NaMN22VfZgyT0t5Vhdg7IIRv+faEw0D7wtAteB2RJSVIMBAH8H3wo3XX
         KU1BKHrLfd9p4GVsXW1qVy/5zLaSPTGM1/5BQyy2MBFYpwC4WsS0Z2jq+m1kLV0jByDu
         DUWA==
X-Forwarded-Encrypted: i=1; AJvYcCXhL9ef5P/uWI7g5ZiBfdLgEXm79kjtUr/ZC9olpOcSiWe2D8T9+dNPjr7b5mQeRZdlG5nHQss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnjSgR9fgDrgh2tPrIpH/37IGedAzatZwHE4rNOs8+C+ebPLE
	WI0q2fmEhJpx8cnR4n8AaollLKW1hrY9xatRFu4VdOkh11b0PirPSX299TfEW28fD4CQLx+KQP4
	4dXn6p4Lze7mtBf+vgR9yqnY3n4DpqEUDyffsmGLYoWBa0RX/Abt3Cm3JvV4=
X-Gm-Gg: ASbGncvG4rbb0t43z7LaVbCNpMsa0bJHk1abPJo+x081Vmqg+pVjvCoipZYJuuK3GA0
	OiHjWZrbqpzLl5WpxQjibu+Nj5janiBJSFo+sgXasGJhsI3t1+ap8WjcEZ/2rFweG3Wx+8fLWkl
	oNzQp60CgjhsRh9b9DeIwAuvOK+lFwTo20q5YR9puQfyUYdL1acrkRor0Gy6dhLwlbpdEJ9IDgG
	OY4LET7vT+Mtlueonx0BBRU2rSm0LRraL1a/iI9DoGQPMzBYbvbT9dGECbuJStqnSYTta8VV9oF
	fskKursNYNd2m0vSNY8AUbdYTZgBpyow+e732cdJUUve30f0L8DoJd0QEqeitXIjVQiu
X-Received: by 2002:a05:6a20:918c:b0:243:c9e0:8b06 with SMTP id adf61e73a8af0-243d6dc8090mr27501099637.5.1757003990215;
        Thu, 04 Sep 2025 09:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzD1cTEmn46NSwuPKASFsNepjo9nil4ymDu/y3d+JRFqWGfDQaJarZ32y2Y0+rG6IDPPIl4g==
X-Received: by 2002:a05:6a20:918c:b0:243:c9e0:8b06 with SMTP id adf61e73a8af0-243d6dc8090mr27501054637.5.1757003989802;
        Thu, 04 Sep 2025 09:39:49 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:49 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:02 +0530
Subject: [PATCH v3 06/14] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-6-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1094;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=knYck7yyW6VH/Q+lPTq9YrCWE79eVzE8DYwVhqZMEi4=;
 b=KiUQmzDNRdHpUoNNOOZwRETiT45RXOL7r1Avo9JLIX/1LpA5Sp/Jj+CgPqyqoaxYKbexO/E08
 DO7S+I1Z0LEBfPOruprdSDNbvw4+O9N5yOMAIHLSc7r9qgpqb2rb0sj
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX+5UIxosfSQeI
 3dy+arBvXwUFwhNpsEG21EJiSkRYwWsxZrWOjM2W0SLNYz0Uq74sW1S5bbBz2S3Qam6nTkzt+ko
 00DvPGFnUKwKh8pTzCOtEHukPle06y2MJvGlMIC17wMvVrOCNCBVGS+WTwU2BgNFCS11lrMDej+
 8I8JMPneWBc4HXWGkHTpdMhqGDSlPXQXF7uo4uuuRo+yLOlkP7/HEzDB5Vzq//L7Esu1XlPjJw5
 Ay1rqqZLSQEMw9M4Qw+6+3hjOMH5DHtIO4PDlvrlOrcq88wlqiFyllwxll0aNiWHYVJZ5072Sl+
 9DrCmSht2yJFYgVes5vYo2IxRCcOP402InuxnxxV1UClvwJcfOVVknoUHZcoYS/oAL+ww6LkHKZ
 jJWBGbHl
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b9c0d7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=cq19zQBcvAJi0RM8MkQA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: C_cIiGUSAHMrl_KO0RqqO_-r_ZVm7SFU
X-Proofpoint-ORIG-GUID: C_cIiGUSAHMrl_KO0RqqO_-r_ZVm7SFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

From: Monish Chunara <quic_mchunara@quicinc.com>

Integrate the GT24C256C EEPROM via I2C to enable access to
board-specific non-volatile data.

Also, define an nvmem-layout to expose structured regions within the
EEPROM, allowing consumers to retrieve configuration data such as
Ethernet MAC addresses via the nvmem subsystem.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c48cb4267b72..30c3e5bead07 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -319,6 +319,18 @@ expander3: gpio@3b {
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
+
+	eeprom@50 {
+		compatible = "giantec,gt24c256c", "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0


