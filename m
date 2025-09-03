Return-Path: <netdev+bounces-219540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E59B41D5C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD393AB985
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484322FD1B1;
	Wed,  3 Sep 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fehguLeU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C52FCC1A
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900073; cv=none; b=S2zu8+wCqAshbuWx/B577V0u0ryRT+2p87di0yc3WVl/dvV6jiaVyHpW1ykWdO4cE+WDIuPxwtA9XyRSYNH8dr+Q2bAJs6Obra1MEMtx5NnWhHFpSLXAngNEmdQZXwdI/du8mJouP73xXk22hxMiK7rWIOZKDrpTwS92QhtX/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900073; c=relaxed/simple;
	bh=OnktyLXlAvw79LU30W2286PIYUB0ZIxd6VhBwuBv3ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bF9FHJhK0qvnLnivrajamt53fqS0Hoog35q3AmQG34PCGYE4n+PCTXs+LXTDXxk7KooVhwbNDvcCKjTHfJbBXfh3AarwQdY/Kbe+83RxGZ+zGeYmZObN7cEoWQDDGYTuAVpyXUO7v9AiLrTMp783weSkRqI54Iuu56pSU9tYMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fehguLeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFF0p023480
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXZGpMX3yOrOQ/k31nwEuT7jwrMYrLpKw0F69FmVEdo=; b=fehguLeU8nl85U4j
	rhXTLdC9xdLtUq8Hg07zOGaP3Ad9x/JL4mbtOcnaFcYxeKRCQMSUIzEzsLpZWGPE
	GoBkvDYOv3kMkp2X5ix42AsoCGdAQgtdxb4QNfwmcDIZPo+yqs2mJO8u+1UoXl3A
	iw20o0Tr8f09+6k2YsCNuAzqfV3+rlLNTj86Dj7lQD5LLkhTz8EpWU+A4KP2QX6S
	2yMn4pAbBXaX4qmkoR8neOp6d+5Y6j2e96SnbcKFPZ4RZd2hdEI7+iu0bO4goShF
	g7V9a3xQNSMoNCF98k0cR9smmH29TzZ9waGzpYwcMLJpj3DY/R8VGADSqj3Saba/
	WPcBdg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ekmk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:47:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so2008212a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900070; x=1757504870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXZGpMX3yOrOQ/k31nwEuT7jwrMYrLpKw0F69FmVEdo=;
        b=lR1iaG3uaEsEhpL7SioaX0ZvT6LZzMCBQP/gWwxutpdqHO1uBJSwL8Q8gFAi0QNOts
         NIc/Qg8X+ohi4fWzTMI92gc61rW47VhmYVpTm5v9Ko/OdYQOkZPEGuxd45xio1vebkFM
         /HunUaub9mWVxU40Cr0+JSySGFtAOxPFybiM02l6j+eKQa4FvXUVaN2tKw26BBRsYJaS
         +UO1iwOO7r2JfMxSBNHDGsLhj3SUAa10gwuvj0j3vrj8pt/tsqWMFScXE3OWduRQzYjp
         LGiyqSjaOXB4dJwaknQ0p1zti3viurYYyP8rt1Uu9ihRz+uexOcBUJNRm1cpP/vxVW/+
         bzdw==
X-Forwarded-Encrypted: i=1; AJvYcCWCGr7wsVew1EukR7h4ccNOlAt4WN057I4+MymSpf+jFZJRZEVLCxFqDoThwLtCHNNwT4ZsgoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJb9avIyfqe8oGTiaUR8IpGXnlFiw2KR81d4Zu2xqlIt8vutNk
	5JvX0Z/GakQBP7IFaFq2wpOkbDay50jGiLYUp9WXFtL8Obw9LXedjiAXKtBpJGB8/ZLeIqD500g
	UaRMhjjCWu9QVD/mPezbJYyUAq/Q70wC/7tFzjjN6zGKEnLpEBnYYE3XG8IY=
X-Gm-Gg: ASbGncsYOwjHuvRq3/6DUmg75gsOAPgTuToxkvfoU+BindTUtnHGlI2px5rJc3IrpJD
	H7QDfneIpYElK/1ed+pK3h3B3qnExmOstBth7vGUOG4V2Nw28j0w4FUBG/D82HuEpB4aUQ/BQNi
	2+HUhJv22wbqkz7hzdEQIROMZTHr29gGKhAsa7h/6d0/AT5T13U+8G8QexDAzsaGDsSJ+HrfVOg
	tXX7iQEdByXtzbGJSReXOxvVEt14PhWnuE7qJ6hOU0i8zPBWJXerATcZXEsyArZ5epZyzC0+JWz
	jhut4TF53x/Pxz6CSvQWMrC/pyTa1pFyekC2IJD7TqDM7DZWk/b1akoqSuY+vlLOGEI9
X-Received: by 2002:a05:6a20:7fa8:b0:243:a91c:6564 with SMTP id adf61e73a8af0-243d6f431a3mr19272863637.50.1756900070431;
        Wed, 03 Sep 2025 04:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE+Q7esFWKub9PAlvBnehvvfXsc6KCukl6SiDDF6aya8S/1QEYowQVoz4bs50W6LD49Jov4w==
X-Received: by 2002:a05:6a20:7fa8:b0:243:a91c:6564 with SMTP id adf61e73a8af0-243d6f431a3mr19272834637.50.1756900069926;
        Wed, 03 Sep 2025 04:47:49 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:49 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:04 +0530
Subject: [PATCH v2 03/13] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-3-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1237;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wNPfzyJsHuof8OoLd/8jyZfN9jNfvGHQW02eb1RzEjE=;
 b=0b/LYijs/sr4es5fM86gI5QstjtnDPg6dCaC3GynfKhA8oLib+VAZsHsOmZBI2gUq5fzF3dL0
 K0ocgFnwazdD47ESQZRaghlLahaQT5VBA+vJ72LdfZ4XLgPnl8cC3aE
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: oliYrtPogSO_KBH-RNb-o7hxW52p-HyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX8lU/E0ihF7H3
 qS5P/sJVCR1A7QWHVeZEUFVlH++G9IZaBogOMztCob/vo9DAF9Fw25GhhFXpvcqyqFfkE0RtQpK
 7KqLkSth55LEW10nt2U3F0JnqTMnhpuAnMOH7vZv7klbZ0QR4rEKd96VAjrKSe7kVrjnMkp7z2O
 E0y86wNoOWAJhm26wUt7UFArClNainvvdQ855laAL2o/wxg7OCLAbpeGdBMw1J/nk+ctdjkYKiv
 lCTeOnvJ3zyudPBeWjZdmE6WC1xleRWqNeVLv0HyNtvJ5RvS78I0dk8B9M2DgYFAtE+Bso6XuPp
 AtFowASRjpSdoNwmaQqjzTJxBVIkrGqaGQlQSnKiSr+it48GjwlqZaDQeZ68iuEVRH7HVcC5Bdj
 ULdyy+tI
X-Proofpoint-ORIG-GUID: oliYrtPogSO_KBH-RNb-o7hxW52p-HyV
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b82ae7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=_e_tMwhLnjs0gR3cx5AA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9e415012140b..753c5afc3342 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,38 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&i2c18 {
+	status = "okay";
+
+	expander0: gpio@38 {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x38>;
+	};
+
+	expander1: gpio@39 {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x39>;
+	};
+
+	expander2: gpio@3a {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3a>;
+	};
+
+	expander3: gpio@3b {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3b>;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


