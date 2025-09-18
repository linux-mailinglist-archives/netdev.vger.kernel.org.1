Return-Path: <netdev+bounces-223464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CFB59413
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4165F1B25BE0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C632D0267;
	Tue, 16 Sep 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILXFi8ai"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6792C3259
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019637; cv=none; b=HxkGY+PINopyLGRdmCJo3FARFGMhJ0XqoLe32+kHrP6uHiektkbyj2Q1A8R60d6iEo80zBIPRJxpzXjgqg/CycAYj6mXQcr6D2XPyIo3uffMpAOeGgKLOvzltEisEzSfBIOWbbr2qYHv3wUkBqoAq9ztbgKam/kiWcz067/5zVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019637; c=relaxed/simple;
	bh=fa+ov2f/0xh12Rc546amD99lGVlgadBm8+mcInocPig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TrK1870gg0TVgfmOOnjg0kdei7yU2yGsUpOH13055FUl4/SnGjUEm6rEUfos1rwy81NWllpjHFxWpjRI8hoY8Lf4aBmrmbLOQnVZrVqbzkuNJfCWAE2ejDapP3OzNWwz0j0TqfMmOTocJk15s+hkro8mQz1iwRg0e2iG38Q9E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILXFi8ai; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA9LSi012285
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ajsFvmL99uD4xdhW1XhZvWHm7Pqfov1TAZi2gC2+njc=; b=ILXFi8aipRGdTx6E
	GAkQSO8okHQyzkoiUP8UACtxOHp5QmmkLIm6AI1jRwywh54UPWwxqCTze6Lh0CHV
	yXgwg3Rge8fWmNImdnc5YYyQUVxYmZIfgUIimIZ5UfJ9aPwFsRJBdydpNBUwPTka
	3KvTCuICqK0iDa2Klw8cVgTykEESa2hYVlgwUQY8GmjIJt/SzCzhBUjeWekXCj4N
	X9srRLJH5no/3bcRmxpiSengFO683jxbC3m/lQiB6EUGbKWarYOh20XYCWpvF4MS
	Nd22xmjgXaIlL6nMqSfGmfdFnHg9sqYmiRqRDuQrwQ2WZJs+KgXiEDyZ/8GaoxU0
	IZNrLg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12m7ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24456ebed7bso71260405ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019634; x=1758624434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajsFvmL99uD4xdhW1XhZvWHm7Pqfov1TAZi2gC2+njc=;
        b=HtFTBUl1PBQAfONFaughkCmpB5kDBBaVXV2gdw3izKRl3Q/QPKKPvw5mHQwBM5kr1s
         gHAi0xDth7QVg3oLrYSfMl+qHudZ9KxfegCf8ol7pVLl7YgQCSPNyPDNHw6OsBUuaob5
         wMU79GcnsEzHI3jvRBYw0PyfNUc3ssDis76RcizLz8j9BdclEUeKRP7JuJLoeLtPS0kE
         CmI0vWvfroAmiVynE2yNmeEU9ETi+CJFMd94xe52Lvm8xkARrxzr+BipSpN8SUajIG0K
         0F3ccHeQJMR15PklGXNzOLaPcRjO80wMJcxuPhJfbL8Y6w/9jEJyHrhM80fypCOfyYTp
         Ti7w==
X-Forwarded-Encrypted: i=1; AJvYcCU5MUjAkxfSgdPN7BFtN+BKr+X10XzhpvnrJWevP0VymqvpeVpfEo0Vig5azev9M5xXVJJTVIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqNHcups7SvBo49CF6wtj4IVoonEFa/3Zttpl3wNrk4mcAGkK
	uuWGNyozMCWjvIF4O+4F6pF+5/qgthIfJaJ5p+ia4B40IS1Nq2GxGu4AhYqBfJLHs5ubBlQaVqP
	1reYf/fFT39gwVA8TfxEf/ZOt771bPlB52ZDVxltlZ1GYcgKTny+i67JCznUG87zgEpw=
X-Gm-Gg: ASbGncuis2oHBVQsfeA+CVOAp3AulOR5UvKnkhSdnZUMXbYBHnWgpBVOpVCKRjPRl9v
	wr1weHjzyRykOBteFgxy3PARuj8T6P9Vz9PVyZQPbBJWYbivINV5FgJGF/IpZGRO0UiFv2nxIkz
	taymxASyAnIyFCO0CngXawUQnFssiYUxD111Nh3h56hu7YKg1bzLA1HjglNDXtiQiD/uTAKD/NJ
	c3+p1F3Iem76ysMAAUxpVjF/Fqz4ZtMd5NjgmLQ5FVT/hmJ1lCfsQVW19mT/ctIoJGubxpXwrgf
	Q3dBIwR9SY1MT4gdiQ3a2wcj8zW7JupNuj5/PXGYgrk1EhmiO16lUTJgVkCYj8mcEfUV
X-Received: by 2002:a17:902:e885:b0:264:f533:75d6 with SMTP id d9443c01a7336-267d15655e9mr28942355ad.11.1758019633678;
        Tue, 16 Sep 2025 03:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/4CUe719nQ683Yr0dKDLjFmhdTjEL3p/FkdG21uCVslhSoP3TomxcadrneCbSYPW5Fj6HVg==
X-Received: by 2002:a17:902:e885:b0:264:f533:75d6 with SMTP id d9443c01a7336-267d15655e9mr28941955ad.11.1758019633197;
        Tue, 16 Sep 2025 03:47:13 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:12 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:50 +0530
Subject: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=1269;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=T1vtGZ+9t7qs4O9VgCmpcKFucROH+/+ubYN4R4HcRDI=;
 b=dBFSA5n41tUMXPtLGrYRzeqkG8NtFDvYbBF8HxzlbuGwFV0TvPYcv5/JfVBRB0hhAOfXvsW0F
 KBKUx2dl/A1D63z8c741ZhAJCqd0uAni0v7SBBBjz6GK30FL+2MRqnk
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: LS9FgrSHM2h0uSY38jbZ1H4fGKQWpyiz
X-Proofpoint-GUID: LS9FgrSHM2h0uSY38jbZ1H4fGKQWpyiz
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c94032 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hGGMonP7TOO80wKNN9QA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX47EZBzDLd184
 zcSWYyTHt5I2iWGT3KlzlVvTkKL/pr+i+3ZcGGw1pgZ1fe+9O/q3yY0QXkVGqGNgqwjqeeK3jmg
 e7G5yh64qIPGvhmCdtaoht09ezNnCZpXwRKnc8aUxqwGybam5fGE2KjI/lqZUulJCKx//Zv0ukE
 Vms2i03zjlOvp3wAaz/qx9arAYEWxNenI6CIW6/fWm/chPCfp1TfZZHahdnjmf6uv6r4AnL1LP1
 p+XpyJ2R4h+2KwyC2uYOH4RLYKBYvLBuEnxlGV6dr2YkawaAjyfNqVKNfI0IjnnSD5sGqPSL3em
 aC61RabM1I5ayZCqunBN6tlRt6+5Ii4xaRVUOVw2+VFFZM0h7c+lFHyWREfEtjvk4j/4tkm3evm
 tNVfiPAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

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
index f79e826bd5d4..4da2c5a12c1f 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -329,6 +329,18 @@ vreg_l8e: ldo8 {
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
@@ -375,10 +387,18 @@ &mdss0_dp1_phy {
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


