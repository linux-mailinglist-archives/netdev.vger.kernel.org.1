Return-Path: <netdev+bounces-220735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A60B4868C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AA47A9CE8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BCB2ECE91;
	Mon,  8 Sep 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dp2bUuWz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9842ECD1C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319628; cv=none; b=Iern80RGmlzXUxCAKAM10IbSLAaSd3NlsM/5s1UfQge2qQkTNu/HHG/hkH36/As0T07Xg2LQdpYjDXU+Fu9uzwTxH+H0BK8UYCcm9PvpyFx3AQ+Rfn90K+ZWu54qy8JJOKhrFsIUbblBoJqwTuO24c5ahZ5RVbNG8WoJsTUXB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319628; c=relaxed/simple;
	bh=gBYL50YC1XDuPqvactY/HGpJkmgy7jZJJarlpKpBrwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezctrC5GIi9YZgLJsgmBUNIFc5VnXHk6gjwVROlcKYVrWb6DVp19hBA5btysjSDm6WIVO61NLc6Rgimwom6uXQU1c7iW8a6o46G4qLc04xtVIVz7wia4u9ccQfveEp88qGhkIFJeIS4QYXSam76tIvxUDJ5mC4wJpilsgux/0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dp2bUuWz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880IP2O028868
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=; b=dp2bUuWzeLYrMdh3
	xBGmajAhoW0wE4g8Na55zjrnR0MxuhNvRtVBKb7HT60GyeWypyzIXqWzCETHwNJP
	LQTrd+8rpAXv0xWsVDtj9rHhGtrkjObQ+nXR68gRQkPCqtW7imJJZm2wH7/ZYZfH
	ZLJWoBW5UH6vsMawubGjxvbWrP9Y0zflvY4zcM+LPldfP4hxm7pQweAfJAkhZ7dp
	UYv+ixev0xAf+gkgdSiVy5HtxYh2/HOwfmLVk8qgahhPqwteYy9vZXNGzOlHcTBJ
	WVIkS4xFy3mBQ3klei3zIhNDK061p2RPCjoPgfJq3QS+hmrYBEx1hsq3ew02rcld
	1dftYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapc14n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:20:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24b2336e513so64540255ad.0
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319625; x=1757924425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=;
        b=j1wylXZ9yjN+0qZEJZxfv83t5MBNy79xVbbxnEUX4t8ERmiOgyJLnPHSoGM2zykwz5
         CRBX9YauFQC1bACfdDKLdi3+6jC46AffHhrqVjOe9CztKMtamMCH5M6j3SWcxD3hs14W
         6o05R5bwEHaXakV4ohCYjIGB+gaGYlIRyjxok5IT9l0ad0TW7f3smoXcs/OFZt4lV11z
         ePjLEXY83kkt5wW1Ar+UJld2f2JgxZQ2XoKh7XPfzlkOklJb+LjSje1oSUaFfe249xkm
         a0iL4KnuOQ3Pa16jRFOrOOlsOuRA+Fws15SgFD22EPVBD1TYcV8QoptffQ1DrH9PjpIW
         yR5A==
X-Forwarded-Encrypted: i=1; AJvYcCUoVbumBEkR7ka7x4ukQNT+VeoO1Pei7jvZhuEsgy1S/5IAxmjE5NHKdxNDemRrL5qQ67cOuTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69pVtkR4vfP+7dG1e8dBXi6h2AvPXkWVz/PlT2IMq//7jCoCW
	7mGtfU49MV+reiIbPCe/I2qcWxLnyJBz8EK9zpH0+nW4mfmECWDVaXWnoSg5S0Wy37dWBaGmf90
	0Tyun2t8dNmH1LpNqQkhe4Pw5QkxgdAxJltocG0ArjO5iKaHiM9+Y3z0ARn8=
X-Gm-Gg: ASbGncuTd8/dFHPD6QXrLvIL5vGF29HSQml7XfHzo52Jcg9XlANpTu7xRRjpe5WFw7v
	bQ1s+8yUjKM9zRj+fGiQgIRSsrXf8fONeNFC7kMsxOklqCQ82jVRcT/pxLKen59AvFaaykcBMcl
	QPDzhS2M+uXvdCSADVVSBJ3eBQjjdQZkd3C3Cyhub/UeEMMlr/wCZs0AWzg2/Ru2a1pW2a6OJSu
	Q/1DpBzMd0rmcB4IxK7C9942rFCFMBOjvBzXNB0qx1cMUx5OLPemEP1N4KJfpJNH/0CvU38FvIH
	3+bSQaz8gkM+j9+6Jr7yGkl1r6vLf0OGimw0BV9XghcE2/clcU8EhlRhwPsVtdLxk38f
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115464885ad.11.1757319625018;
        Mon, 08 Sep 2025 01:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4jVT7W/OifKwAmzHX3E8eS5lp8cqvuFI63Bk1zsxQR6CJi6eIpk7aZvqHkSYv1XuC0Cg1Gg==
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115464595ad.11.1757319624524;
        Mon, 08 Sep 2025 01:20:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:24 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:53 +0530
Subject: [PATCH v4 03/14] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-3-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1269;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=X+CejMSc/iURyNBdtIHd2b0fknWkLUOZo2knn9rM+7I=;
 b=69UvAQaEZdQB4XITcnpWuh+ii9MjUlEFC6sUkQg/714wq+9n+m5oVmf3MHBWmDuQcPwQo4Fth
 if7W+CtGUV3ARrm2yusKZrv0XAub0o85QCtRf1dtyki0QStCLYQAh07
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68be91ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hGGMonP7TOO80wKNN9QA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: PDd3ZqzcjTrOhm173I_qqcKcFSUCBN0-
X-Proofpoint-ORIG-GUID: PDd3ZqzcjTrOhm173I_qqcKcFSUCBN0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX/4h2N9dbT5TK
 zAZWjFaIsKSiyKEhmn3uuRdDOejEmUpgZL/OZds9AnhAU8fseZPDyfAERtQb3HScJnEqFOkZPrO
 7aGt3Omq6C1SL0t45FwwJnLu+UIE9WQBOQSgF0Owe74t3PzlMVu+uLs83noNeNh4FP8bJgsePhw
 4lNPH5yI3gXw0XCn2YBEMQZ++pAfzM9FX8AvT1/le59jP9dCMynlVXAsbMttBtI40/Dj/xIVOzN
 fg7ckKOjjhMvNJiFxZN85+FE/CDO+ABIUPo1KGX8LLh2wyGA/Zthr7nIzdGKr1KpHnykur6i6Bu
 9jDlmr2mMWWwGMPZ6DO5GYbLdNPQSCG2XCfiBmox18Q2wU5zl/KafHQeO6RKXRVdythcufK0dcP
 5m/b2NSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.
qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9e415012140b..56aaad39bb59 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -323,10 +335,18 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


