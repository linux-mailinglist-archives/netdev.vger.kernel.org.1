Return-Path: <netdev+bounces-223614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A4B59B31
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D9A462B81
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C6E34AB17;
	Tue, 16 Sep 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="foT1nTOD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49834DCCD
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034793; cv=none; b=qBTqM9FZ0L9wqdt0J5YeAgqcK4OgCr0/3XbdKKynDPu/EK9rlEpmELjubSe0h71W4plFNcESkrlI3AHSXrD5HibDZ3lt/4vKL3psfpXDf8r68I5Lh4gt11OrVUdA3OuLFUBrHyUrkVqgFkjq/5OVb2/yuqmjr9vHnkkO75WnAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034793; c=relaxed/simple;
	bh=ucCiT2duDaoIeQYERYpaS3b404ydsb4qHh+zyj5bIXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+z9xQJcF0+Ewm1GqZnQ2Sg9gGX6tNtUKDiDmf2z/CTsgP+XaIuQ12Xwb+SpyiRmc2DOHoRl11EaC1sCpeEGk+O1TL0NEiLgWbU9I4s0262mPhZ00dr17ZmhSkYSk8Y6F/ScmBORNdsH6DkXsNLedXBwhKRLljifj/ZOgSxbTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=foT1nTOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GACdw9020146
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3c861F2ui93zu/77nje/iPwaISHn2dkZfiQXCBPatc=; b=foT1nTODyAMpVdcL
	XcscrWD0iavaxaRSk8HBvD+zeWUpM1EOcguDZZ749PhbvPnNvw4M+NWjLtXg0s8t
	T7WFnCkEYfZEYSk+fu5kQdZugtuMK6BBZnTQBljBLrYlJy71OgOW4+EC9KNOK6E0
	BPw0/kMNKx7m0FckRw6bKkS0/t6YtT9mkt44OiWtcqNObwLTKCv2DZWRTTcPIHdZ
	wTE1hHy6Ttv/SIT7I7m4ycbGPS7KHVTKkcIdldW2+MG7k9xYiSDYZ/gq+DOyByqM
	7Fv+eV7OW3tiUfT8jDEEKl8fMJYf1nIcHH6sZ3khRvnuxUBNQRUptwxFFcoE/FMs
	1CfFUg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma982n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:59:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-252afdfafe1so58976685ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034789; x=1758639589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3c861F2ui93zu/77nje/iPwaISHn2dkZfiQXCBPatc=;
        b=t44lXggZhHbNbPJDfvCOuhdgM7/W7FVODVjuJcREieelsvxBD+Skf7cj0wmS5aGi2K
         wliGWofsEl+rR90czeEkXnfLCwcz/oZR9f0Fk/xDMvQJ0qDK3NitLsJESr+Ok/86mhQN
         WLXmCkUHP9WDcPxmcYVk0+4a1bSBMC0+JYAshgDJY1NHInipQO8+8qry+tRtotOiFq0b
         4Q9ZIgGw+cQ1BJFPk+DHA0vH58ccQQXMJAzwmkl4zmR9JK2+jAzfwWNR7w0L17oFcyxZ
         0pf8819G2daLwEZd/cUx1rLrhr/fPmrgpmHXQwNJrta6dK3aY0PVaQ4sEMD5UDU6oc6J
         lpig==
X-Forwarded-Encrypted: i=1; AJvYcCXiUoGQbUNGjaPYaqDERx26KzuLCCue48xm0pyM6AUbli34P6XToHnmJ2KF767v22M6nPoUx8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhD2S5X5DkkH90RcAEZGaQSdiNjJX0NavfRS78xZUeMyhQBP9w
	bEQ92YhY9m0eWIqU6Z3xf9uLFrLU1tqw47pHwn3SdIdxjH34A6P8T5IN3WMEdsalSREs9Ql5IxQ
	2N6g8e84cPCK09IQZxV7PBOQK04FaJxFgrP3HKHcQWX/UOFWWRkkRH5fm8UI=
X-Gm-Gg: ASbGncsd8K98UEgHu9cPjAqj7JrdA0R6lKf9ckDhZw9SAYQ/u5sYF42NcyHqcUrSJHI
	2XRnlcbP/44Qw+TUW4qyDKHa22KtG/dLJwauGdT5m0KJ7Z5P2WqiKOIeByA5pnwnZTwB/PWwQV2
	3b5IYWOgCYkB4r6aEQISAtgPLXvEpmO2QsbK0wdNDDI3tUXXENKTRDODBYokjwA1+Ll+VbDg0YG
	e8+M9mwBQXYbWVF188U/Gyjky/8y++34mDzT6sGYiIyv6CTqXHJlqJ9ugZlWcXz1yxaW2n2gb3z
	LL1gaut4IwcPVZcbJocRSBGCHi4Al2HfgffKd7ouwS0FJs/FHLkVez7Xr8j0LG6DzmkN
X-Received: by 2002:a17:903:144b:b0:25f:e735:e521 with SMTP id d9443c01a7336-25fe745298dmr126384195ad.51.1758034788709;
        Tue, 16 Sep 2025 07:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlG3XxJr++7YJRonIxD8YwIAP2fbDCR8SQyUNRaNhoCTyvi4e+VWNopVW3BMUU4avieMbUZQ==
X-Received: by 2002:a17:903:144b:b0:25f:e735:e521 with SMTP id d9443c01a7336-25fe745298dmr126383835ad.51.1758034788239;
        Tue, 16 Sep 2025 07:59:48 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:59:47 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:24 +0530
Subject: [PATCH v6 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=1267;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=OJ8bh3UnEFncYOpsWZZoUBMvVw4VlPpL+mr6xLJOGx8=;
 b=Ug9LZUZ9gmLC2/5dekDdCfDPxGAy+b7lG1ieijCJiCJRkmRmh74Cn5mfUItEHOO1OB/g7Mtm5
 Q4cCiRJYK1mCTm2PNKmtdYi1QjIgZij0lhxbvVlOHghJUp+U2WQjxrS
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX0VbZg7qFmWrf
 hAOqfWcoQCRTml/OVnazm7WbOd1KU9QdQRSFxzlZNYzdq/B1d72/HD5EqQ59Hk26rrq9UMWNTyU
 JfJMCiKUdNFpZd0EojFaVooVSqh1E1OMDqChlvgDThOIPgLEH0JAxWjCpdBQSbudEZcikzDGYV5
 TKsPTA2FGsE1/dT3cRiB0pyazz3Cw/ubMND8XjpyQZXq4LMBwYXD9mADYElxSyJb4nLpoQOJkXc
 zVoMm7d6juvnMhSp03G6QyolYkfW9nm/u7mQCgxxcXMzWXA+E9tbQAd6eGHhqfFfx7cz+sSx2Np
 +HRjs9i8LT9UcGp67MIWpfDVv2Vs8+H/kz8x8MHcEqO797Sk7zdAKBsLwIcNq42zciDdqCKqnkk
 2fdrO79T
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c97b67 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HCCwzLURLT_Inys_5lQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: RFe2OdabRcJU_5Zu3uwmEVDh_u2RGmWZ
X-Proofpoint-GUID: RFe2OdabRcJU_5Zu3uwmEVDh_u2RGmWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.
qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.

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


