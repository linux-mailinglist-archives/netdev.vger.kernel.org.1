Return-Path: <netdev+bounces-223618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3089DB59B4C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608D81674FF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824235337D;
	Tue, 16 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrxxxJtX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48108353355
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034814; cv=none; b=vFi+45Lj4iFfgpoHb4fEFLzgirWyjuGiaCbsD/pPUkHvSt2SP3Oykd0m5hc5a4D1SWKXTR+lnpTcHUnNN7ULICe4vcu3x9+YfXMglm/aWG3Iek9PO8wDD+1S21o6+yojHGrCyH3YLUBugMYc55997d6uOni3Ckzr0fPZxPXP/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034814; c=relaxed/simple;
	bh=AeQJ+Mvvn8Zchtp2KXj5ziKvJddoHzFNlKss5ip7LDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/49Lxy0O9Gb/tnyzUkD79GxUww1mRNnGnACEiIPRrgrYoSbaUJiz6cemBZp//aoV1zxaJV2m1eVIRA0pUE2DmdnFSCM/dWEWZJYdFvoNGAGslk8jYEtcTLNuTujp5Q24fWoBcsa+mO0Ff5IjABNh/IO11J6h3qkZcvfMMcxveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrxxxJtX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAQTLv005222
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V05d+jNh/czCFv+YIOyVmfzj3aJzSMxM9iGXDQbdqsg=; b=VrxxxJtX3wb6uvTI
	RlmtyTUDMW4FctOt7ox81ZwBZgb8+PR9ljugdi/ATbfkr6eT6qL5v9EnVXs082wB
	G66UZbbh3CBNyee0ApvAJ6T8/oHweTFibb9GIV4rcr9gqGY+542egPuihmTPk9fm
	PdlZUtnMOIbnWHJzhUKP6GeQz+TRfIkueKzEwVTPtOJo0GdAWpJfZMaS+Ak7goWW
	LvLNTYpdiEQGR4noHOvPgjQAAXBeP53A9ym2FeQw/UrIq1xQE4CuR59456oDlqvl
	fbdI17TjfXspVlMmdi2JH1TFlHf3O/fWFYdBmmzFAsjtSv2/nybOT5cmpZUx2R8w
	LJ31Jw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u5969h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2641084fb5aso28880415ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034810; x=1758639610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V05d+jNh/czCFv+YIOyVmfzj3aJzSMxM9iGXDQbdqsg=;
        b=fRS+tvl6yxAYro+eoLTocOjJLTzCb6a7Pb0wuKIBs6fcAqfD9OrPtQ1YHN9qyKxq25
         UYqz3ZFvVIWdJwcIP+FZ+kjN7MMlSMy+b0PUQsVB71pbhSOqL2t+z2zeS5ruFiNV1p8s
         IYn3v6RaOwpilDyjvkiVZy7V9u509HB3W5fZHY0JLlST1oFIxwbq8BjQmiKZCDAKXq7l
         3UtPjQvDR0fOLVFzsInLqcn7g/GYs1cmlhVTy2t66S6Xi8aqbgYK5eMnCtK2sk8Z8n9j
         PZJhD0JKrT9PhsOcD0QyqoL7KhQbwdntjRC+aBQWoVESMpTZMn19fNOLGPavHFods/HF
         hDOA==
X-Forwarded-Encrypted: i=1; AJvYcCVlefwutX8tdbvSEwKSC8uOwH3V8iNsESc1LC2EcwL6ebNXHAgSee54VLJh1ewuqRrh7xTRhHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/folZidBRnf7TCIrwu9AHup2eUFgjCMKxJgUZTLtfbGnB4+F
	/hXhgppJSjCNuBrL5+OzUqTgCmActuBeVhvqvtgxm0gbCPMeZRNKgg8J9LArorX46KE+f6/HJF2
	b9OIRwPFe1RSkQhejdYfFymwQ1HxFVAjhwXGn5c39NTRvHiB/TKvb5TPKjJs=
X-Gm-Gg: ASbGnctFL/eqjtEZgCFNyFZmSn+Utjhxi6MoAjjBND6mZkCOI4qbBghxbkbOD7rLA9v
	OUa5J9IWFaDaLUjrHBnX2+Lj4IyNm78+yT6HbcDrqJoz53LGhM7oz4BOkc/rnOlAuMVM+vaUeiS
	8zShfS5cnxJrJW5nrYWS1OB5AmifphKxTJMyNxFTi4IUdaHnNJGjaOU9frbHHpKrjH/eyVLwxbq
	Tvbm6uc0bB+gyk6NblD/1sP7qV5lYBF8SAJsNqU+hLAiGgzwLcUH9Kro+z0QDgNr91PCrLsnxD2
	H3SwuL3HowXxl1mQ8w05zW2oyWUN9DxI8hrRTPH+xn57jpEw+b8cEXQE9ljaNKkyJYbc
X-Received: by 2002:a17:903:4405:b0:267:b1d6:9605 with SMTP id d9443c01a7336-267b1d6a44emr61499145ad.10.1758034810058;
        Tue, 16 Sep 2025 08:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXtzp40M+OnwRPHaBfUHcZY3UBeT0scukJXr7R5AGOJ3BP+3MpI6Pr++mKWkPkvNyQtbiOg==
X-Received: by 2002:a17:903:4405:b0:267:b1d6:9605 with SMTP id d9443c01a7336-267b1d6a44emr61498535ad.10.1758034809413;
        Tue, 16 Sep 2025 08:00:09 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:09 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:28 +0530
Subject: [PATCH v6 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-6-62e6a9018df4@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=1248;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=AeQJ+Mvvn8Zchtp2KXj5ziKvJddoHzFNlKss5ip7LDQ=;
 b=51Y+c1piLmdWjG+Oa/4O7vIYN1Ktuey9O6ZUx4ctB1uZetUtQKP/MyuV/a+F5d1pJO7w7XhXd
 +nqfT84i1GJAgBIWfF5jT6Royc2uMgA2cLMeKWtsu+5T7rzVdnXu+ke
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: wD819uevabjtdy-vscPPsVTW32EYJNPS
X-Proofpoint-ORIG-GUID: wD819uevabjtdy-vscPPsVTW32EYJNPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX8p8FNxa1Q4hG
 sMJEIzXjQTAIF0JYLHbLi5FRtvBUNaNUTcv0nizlJFFXFJfpmIBUTmX7J6mitnPxqe3dAvHTqYH
 G5mfSdKHwISbkiFl5vez05X6MqFBweljPidgX46GNZz7r21bGoWOcHV37t20PtAhGtqUhEKCbll
 yPx5SDCjoYKAUvGUTm+3MYAnPF2zxpVXzRQVmZoKCzoFVxAAqUMHjTym7fs+//zf307ac6I0wRd
 sT3fuDy8i4jnK6c4MdjQWTxyg707IJq0cB7aRSQuIoTiYfGFowOS3dU0P+xq4j/iv1qM3D46B3K
 acd+R5FEEudZsEAnIqJl7h73cvR/GGuA5XWBSVVt/qf0BSfb2Rq+9nk5qIoV3NP0q3As52mX+kc
 BfEDi2uK
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c97b7c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uxRHuE6yrSyVtnA-QqAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 99400ff12cfd..d92c089eff39 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -477,6 +477,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


