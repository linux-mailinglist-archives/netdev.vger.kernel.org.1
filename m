Return-Path: <netdev+bounces-223467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F33B5942A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178231BC3286
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FA2D46CC;
	Tue, 16 Sep 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTsjFy81"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FAB2D3237
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019653; cv=none; b=pQYY4TZJ+n7V56iJA/ZLbKE1pgjP9hem0U/aC2+WXNUjQpl5s07XVfprXTiUzDjfVxEupvEkKzdS9xGCxmkdy+1Xze8DLEoH5XTOlZLGbYj+iHx3618bCTEbkREd3oyHCdeLJEgZynLIuvf3JUeSrud1siysit1RGC/jXDNwxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019653; c=relaxed/simple;
	bh=mlexqF5SSClorJ9LQ+lArQE+dRzsOnHZdcxeoekZzOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkZQSrrlrJ21OBA9MNcXOAyo3d2TnpBmFIuSlqJZq6OyFIUhF96SD2iGDFBaMJMb4gZR+zhcvD6lvANxTyXgDYExiV5/0aqHa4KZbyKnXpa8frrc6wDfkkJyqM14bfZwDC+i0Mt02Hf7GuSZZNBXspHJEUkIZD7YklqabCY7xZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTsjFy81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9mlFf013874
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W5bbMVfAsGi/zGFdo/a7XkorWRKiev2Csg4UoorEa2g=; b=oTsjFy81xm+HPvNt
	w2pIvpVxiMQ+GuscYQ7vxIu5D/67hjvqM07N295JbWEDJqxsl19nVgONz+FLP/V+
	MUIXer6QxX028/vU6rxPn8va1QNycpZ95Z7rOK6yL7EE0v55WBq6IuCPszpIOrk4
	Uvh0ejxVg4z6QlOw5hwHoltsU6C2/EilPMGMWxhSwxsjvakZi9uTlKvjs7ZmwZdh
	dB2LeB7+SoDYyWXvmrs6FQxK6+hciTq/H0yRSXAzi48/7d+JsEd7b7908S+C7pH+
	JNG3yfvzVeWrtiuWhn1lpscy96QGmgEojkxiyNlHYcfVzdXLtR7erZNjZBaTUEif
	6skKbg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5aspm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54d1ae6fb3so1371250a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019650; x=1758624450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5bbMVfAsGi/zGFdo/a7XkorWRKiev2Csg4UoorEa2g=;
        b=VgbsbyHZvV9BnQAby2n2dXrJGxt02tfJRk7cOhNUHYbkPBABEEwSLBh/3pd298PB3E
         K+CAT4IGVYm7aW8UD1rECHfy0Yxn+eZxJHBpMj1Y1avyhQ7EsAg3AcXiZ0cpMh49xVbE
         UUO4yZsuP02ltxZTal+G4na3NkfTMxB6FoGlvZTbJTHy+CyT2miAKTHLNKWWiEvIG0uh
         s9cDtfFcIDZMfARQCROxOJEBn+dl7Bn1ZdTu4TpfkNe/3/c3q0xTv+O0XCQfsRukzm7x
         WsvBDFkZejIKpzj5PyohxPi4mzs8Qh/LuwuZIGQTPRwLUvyhgq8lNOIR5JtvG420V/cS
         2t4w==
X-Forwarded-Encrypted: i=1; AJvYcCXjNBZXe1iX/weMSLGMz4MvVlG11IG6M6Rs3caqM6ZpkqDpxlyL6CW1mhq6UmSi22oYTWFfeoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4dxYbISs0mLi/RmtG+f9F3yMxvRMUunjD86a3JnsgA91wK+mh
	M24IWehHdzBtQNF6pDAoI7glSPwEG5ADdviGZKzNeLXm1/MOfqb9GT9iX6cfwAjB4jRTh+siLP0
	Ue1ses/inooBRglvw45WAh7v3u2YArt0/5WSI2d9g9emfFaVWcUlMtQTJVmFLqwDmQ2A=
X-Gm-Gg: ASbGncsTRk/QTtmNdnu0L8Jh/BSP3EW7YHG2/AcXHiwON3+r15mBStWPfzW3RDTO7Fb
	GheTwE5MKsOmbhX6RzJ3lv8e0EN++74ly2uYu0jN/5iQpImayVBLbOvn1sZjrTEAd7VReROFjSz
	Wnh2mtkzgl1YpkSuI6AAXWJu7hHAS2M7JXREGAj94NosasAETNy9xrnbP/IbOB78gZoG+Vd0m90
	Lz/PeNvVdse3oC4hx/T0bc5Mpgvlc3Xu9p+W2ocNR0VY1bOz6Tz+77z2758o6/G1H00Zo4EXm4b
	Izry5nQvgHLpJEvcsNuVjqLoXdMvv8Q9HVsNXdYOJ318XIO6Q3jPO4sDU/ll3v9uO6Za
X-Received: by 2002:a17:903:246:b0:246:a543:199 with SMTP id d9443c01a7336-25d278282edmr238524975ad.54.1758019649692;
        Tue, 16 Sep 2025 03:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6jGFWjqTWuORsJ51aFQBu3B1Av+UTVa/XXCZyM6ScHFCNT1dEfSNNMB/0PbuYoQ0RIVbYKg==
X-Received: by 2002:a17:903:246:b0:246:a543:199 with SMTP id d9443c01a7336-25d278282edmr238524595ad.54.1758019649219;
        Tue, 16 Sep 2025 03:47:29 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:28 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:53 +0530
Subject: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=2441;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=1dTSMAUVpK/VA6UxCdymUCA481jMMWAbBqXExIY/bUA=;
 b=6aEz+wYvfbehYZRkVuSrVm+wQVlYKa5gmR/lChw2IGqZTd8TurAXb6u6Q5pQuxQ0yLfVHZKFI
 7WNGyaaBMLNB42PRhxPqFE89L+mNTiDa7AHV/52GdWwx8IkbUUPuyQu
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: Kpt3sC2hdEbMFOWFNH6TojNVLPGpf8wn
X-Proofpoint-ORIG-GUID: Kpt3sC2hdEbMFOWFNH6TojNVLPGpf8wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX3wsvK6ZBemfU
 pNf9V8lQ3Vxa27US+ZPwXbaLv9T5muxQ1DDfpr/cfV52P7tj2BXLWnFBnF5xNaHhXi766rPQZ8C
 AomKhufKdF2IojAcqCpJpQdZC4drPtYG7DWwfyiA7mSbyptTB0KX+ZZwFrZngU97HrRtPFiMvIF
 UkLIqtccwexIFocfFYKHeZprCs54VYkxJ3YNomGs9RipT8i68pp5sl1LRjXSdX93pI3dsvi9NgB
 Iv/WtzvUHANYFMWj3p73p5CKkEKejS90Cj/anWY+YNM/ZNOR67vy5sRDgAmAHSwg84r8nmO5q1R
 D/1RZ+CqdUunt6BnMFmf20wBfZG7B3cOFUL5s9IlQDc17TfpcJJ4Fnn+17Klby5EO7P2YauT6qJ
 OGV6BE+T
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c94043 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=y_IpLqVBJp9He2uYrA4A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 97428d9e3e41..99400ff12cfd 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -431,6 +431,40 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -447,6 +481,54 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio3";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio5";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

-- 
2.51.0


