Return-Path: <netdev+bounces-223617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F722B59B48
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E30C166756
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1E35335C;
	Tue, 16 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kryeaJq+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9F353351
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034814; cv=none; b=SOadSO5hGDrLvls4QxBWacp4p4Jf7jyospoxBxmq04NUi5k4Xh2ZwzExh2Wgl2kEGnOlfptZ3VF/rok1DjV06+tcpsfwZCxkg88Y+XTVEF1p8hldjZ2f7jWlq7+BYEdtI2LMHLZpnnIM1CuW8HvzGIeQJLxDOEskKloZ32ok/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034814; c=relaxed/simple;
	bh=gW0bPo3OkmUFna1ZDaJHjlE8SmA8Fb3vkmArQbP1lQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYDJCpLgad3KgrtSJ7AoRy3LZxOSIk7Vu22DLSJFKWPQS/VgvbWnNbR/Rb2AJq0vxOQVJLn9GwnXkc56mJUIR0mPigRPNf9nIj4Cpo+FmnN/2A7dAawk2QNPhjB11fTsN4fB4X1HwjqBOUx1/cgqsIHyqYABktfDct3QTrON87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kryeaJq+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA56pk005286
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfmoJCJYMW/3EkyXGndpmyfnXojx9Z+R8xHTgwqc19U=; b=kryeaJq+CAVPVeZs
	5Mnk4BSWozSGC/kzOElFYesnzCnpGRIbdLR1drPh2k8Tg9YzhMPIx5/vJaYypNsn
	weaoHcuibn/K7klHYfbPQ8WxtvBWvcvaC40J9GnL1B1Sg7rRx2PbiqaXTlseyQOx
	fDX+KXRd19i3G1SBa5IrK11qK6Vz8GnKCP/NSAilZySEcj/9yQ+EhK6/hSYW/ioX
	PXHlMW8olP2y+NtepNIJPUxVZO8CCnIZOGNk0zMPkOcgI5IRFhooXxHNvW5IXC/8
	Vg1uAfpbe/8krCOSV2d4jRrGaCt955ZEwb9iLcI0HLvJD+kQtpu5X7oOQF53vxmX
	oFphig==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4x1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ae30bd2d0so52497135ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034805; x=1758639605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfmoJCJYMW/3EkyXGndpmyfnXojx9Z+R8xHTgwqc19U=;
        b=bRG3nBqN8KnkyoTAr2h0V37/VMLKuMrPkaXvMjDmHyssvgFCmREUZecPykuewqvEY9
         jzJm/yv0Hdpda6DrC63Mx72pBi6VGrlRWTvtWeD+eqiVXJrCdewEImKVGPNdEXP0Jjq1
         nElaPAxSky4sW2+ya1xADRJ6LqLnXPFo74UavgAi7urvnaqLtNIGiDCWhLr85QLMS7mr
         3hky8ah14APEP+aVR51nUIAJaynVhgsG1DbapX3YmYhTKD6GQ3ecLEA5OxGhuepuLPSB
         2M1Pktghjkm6MoB2u2EAJyq42QdEB+NyGd2ZQYd1W1rYFxWVEQE9E3xnOhUtUKXdWP/K
         wjTA==
X-Forwarded-Encrypted: i=1; AJvYcCX3fcEezSDZiawM6ScRMeGQjKZZwSf2VQBDyKsr61xqaZ6AOiGv+d8kb2vLq/a/PnTt1wpGxJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeakcgthTxxVWg4B7T9GQR4aVfPYSTsoqXyItYECMEhgzOoi0
	w70+lH3kTqRFyxiKZ1Bgw2N4Hekzu3BmVd25cRxlTjtXEJry0qsb89YAVuBCbsvharyauuPjoUA
	RBuviQlzM8yvAN1xDI1BlsrsipzqSs/A6TuTHdz2TKmCijAK0A1vlg6zxmgM=
X-Gm-Gg: ASbGncu1bEKilMgC8i6znscrA4TgMtPONEWQAogCVr6W0sYqtL61eZFDoZnZ6o/heFr
	aVx0d1YPNvvI31xEC7rCy6FABmew4GHfDqCWtroSjkI6PyxBYRsCfAna4EdciWebu18MYOiTvN4
	xsDY5EkaPvvjiXTOZuaU50SrxwU9MZDF+X9+CZqRvJ+bd9Sm0kK6SdmVsFRBnkEzB43mKhv/kwj
	3ggj1cBJmah53xrBzM8bhAxZmiMg14v7vzkOPe1lNqEygDfWWFkKQ6bXUDLdtiIqyxVD/e7H0EG
	RWJxuPclvxpS766+gLypE3mIPIzVVrP6KF/0RrLYU9DWmit8gl9ojfMCL5nOw8WQTuM9
X-Received: by 2002:a17:903:2411:b0:267:d7f8:405d with SMTP id d9443c01a7336-267d7f84855mr29224585ad.10.1758034804859;
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5eMZ3RiMQThYk5LoeR9kX3JpRxyHtX+/pIEbsAA7FmX7mepRw7fJ9bUWKCBjk6kV7kbNZUw==
X-Received: by 2002:a17:903:2411:b0:267:d7f8:405d with SMTP id d9443c01a7336-267d7f84855mr29224045ad.10.1758034804410;
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:27 +0530
Subject: [PATCH v6 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-5-62e6a9018df4@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=2502;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=3WsuSGjjSbB/JTrN1dwDIFLbf/p0GZwKko6k8n3FmiI=;
 b=sUXfC3dIKKDaw9CiY4EJTvMsBLjNH0VUE/wTCuR3uY8De/EzQ3wzGaIcguY3uTR8iU+6KQKIg
 hA7Zcj65CgxCSmnYgSQg5Zy8MEqKbNZGHovLvxIGtEWXeSrnsvFH3ia
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: L47RQcrDglvMyciedWOMzL_pnfmSBTDc
X-Proofpoint-ORIG-GUID: L47RQcrDglvMyciedWOMzL_pnfmSBTDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX1Wnm3iLOfPFD
 W330lwiORaIDyPo9v3FWmm3fg8wQM7POuL9f355+388qoLmvMAxJWPud1QnxNYmwL6UMpX70BYi
 xkdQKfib7q0j5ofrW8Avo+zt9cZqplw4zzG3b+N9iDap4BQwd+1cMwtVV+zi/FTYP0PjtAuUW/8
 nHsaVcAFPrd/ki94Ap9wAWi+YdJRCV3WPKOalafxf9fO+U4iU87nG5sSttjtwz/Th4LXicjjelz
 d1ac0dsS/jC4Y6xRZCKRwNQ+jt2aub5Nvj9pbcSmCtc2Xc4fart7WZnzFAOJsPco+mqGrYiUypS
 nMeNG2uaV/m0M74d/n5nxFXpawy01V5PJqh4F5DQrXIYAHQ4/ZU3tqrDrOcMFpL+JhZ3a54m8tL
 MMe7TC2L
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c97b7c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=y_IpLqVBJp9He2uYrA4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


