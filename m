Return-Path: <netdev+bounces-220013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA56B44327
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7963D3B59B3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380A30DEB9;
	Thu,  4 Sep 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wb8Y91Wz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BF30CDB7
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003978; cv=none; b=f4GtFTTeisEQZpmU6qrQKziLEA8U1N6xADDW3vAf3ySvIl6k56XntYa5a58l6erMMDKdvXLiA5LWjk6DcX6cTR095LdXJNpko1YoBKLXveIrJ1damy1d1ApuwA3Nfy+RZtfXivc7oxSNyxz+9WtzjpzX6yvJhL5cGiextfaajWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003978; c=relaxed/simple;
	bh=gBYL50YC1XDuPqvactY/HGpJkmgy7jZJJarlpKpBrwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPRewP1XjcfRhWxDkGgQ97ZoC2asEvYNNGTTaMj9LdhkWIsQIPDyLR939C9yzuMSWbAhvYqPgtOEwCfGgtjUGsNQoDx4uk6mhoXCtOBn3iMiq82jcCi4n4hSaZFYEQ0Eb2iwaLcG6zDctTBUpMQ8ZNHSAkepuf+bndDVjQDImZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wb8Y91Wz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XBQN004215
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=; b=Wb8Y91Wz94F4B2Zp
	pzL+R7MzK4O+WyNMjkd0Iq8BrlPc43xcrjGpakz8ULnOpxsW11Xnn8+fL4o2bZum
	+oAbiSeNx9ZdYLSErohC8p4rS1zBmUOW50rqnqN2ljwMbYuLMRQauUv4sOCbr7lo
	Ck1S9ksmYtfd+xe7QE2xrua+xEDLB4YuQChScON1Rt0loZEhKA3HNP6RB4cFmVv2
	oi/JDm2CxpAirEeSnzTfyrX1wr5VxithPduSxRxTneLe52SCpVO4bWFur5jNnBJU
	deCaQck/c1puOkpeePgCbcm7OakVDn5q9Yai6SVdea0ynrgaG0LslpsT7XnStjYj
	T0RtFw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s88g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:39:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329e3db861eso1172143a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003976; x=1757608776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=;
        b=dTFd71KLaMNFZgMz8NL/qAHuxhdXluMBwIA+78VjrIAgceX+1Su65Z9vt7ZFXg5lC4
         kDTX5JpCcqcN7wHgZ6JE2sU0YE2VwUt7eZdPMXP8vX8grx905h4uo3+JpFVWcK5VI2un
         dxdBbijE47B2f7R+e+oJBiGBjQ7IjXzoKWZR21UPXZ12R8uvGdyXbdaLH1g30Gt+Xttl
         y06lO53QkpPVv+ycSJrn8Ds4pVqumWwvtSRD3zH4QbgLA067VzUkIKdF35BNYN7Riger
         b+RGgVIr0jRMdEJsZTbK1Lnsm/1x66cO8C/QRl9AkFb8Mu/NW2a4Yalsccx1PwV08vxp
         gHfA==
X-Forwarded-Encrypted: i=1; AJvYcCWqNeScnYDQ8ZVCo/PVlvgk5Z07vosgSQv1sSxIeQPgsslKDeLBSxHeCSUyViSrPAdT7REcZVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/sKGA2CzENGShwZMtd9P72xmujvd3yxtZNrpIQDWulMlOR98
	SyvR7hBPFU3CKU0ciogi2nhbwiICEqaevOQKUhCVdOIoJ4A2qxfCgVyf4O9Li8TqBJdlmEsgc9n
	arjjo3O1EqmpjT5YqwV3w4M8Gg4YNr2Ztv9XK4N+NszJrtY9hrDDpDHBY+mI=
X-Gm-Gg: ASbGnctfCwjD6eOosg8zkbqezNUj+FnDKjWIC76aGxP14GE9efzReIjOwfyfnXJjpDX
	yHXj0UzjnbTt11yqU9jm4+zJLILf7Jw60K4RZ6cZrNmY49BUbTWdWi9Mc2s7z1CRzkC9P0+Jvb1
	JO5vRxDV3IXmOO4gf/7w0bM+FqocHOj+GdLZ/2O3B1/pa/73cxWXf/TiUIAyGDu1RLLHlCLVePG
	rZMufBGfrl0bUmpGCSWsgZim8fYccngY8YYecig98mNEXksWsKQ7FaU1r2G5bfpfYeopdUbAPZW
	kCSdbzd4cNZ132j7KOSDjMbYixzCZTwDmj+vy44XLu/DIH4TZwHlUoyvJFc3YjSf24QP
X-Received: by 2002:a17:90b:4a91:b0:32b:6ac0:863f with SMTP id 98e67ed59e1d1-32b6ac08933mr8239241a91.18.1757003975491;
        Thu, 04 Sep 2025 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE7nofFV+wfimTfWOGY7Z6T0ProffuK3bldt1eocUGgRt88vfTcLxAfprbv1of4R3zm4TMTg==
X-Received: by 2002:a17:90b:4a91:b0:32b:6ac0:863f with SMTP id 98e67ed59e1d1-32b6ac08933mr8239202a91.18.1757003975016;
        Thu, 04 Sep 2025 09:39:35 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:34 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:08:59 +0530
Subject: [PATCH v3 03/14] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-3-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1269;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=X+CejMSc/iURyNBdtIHd2b0fknWkLUOZo2knn9rM+7I=;
 b=B0ZC3gu+mtOedmT0tGm0gYiwIQI00Jep2hD+NjWSt7AaI3xEHGf7l6shbcaOVXZE5sHn6N6JY
 d0/KRtj88nOCc9VKZN67PTINy3iNSYFysTRiSSUhvbVD0jX0zygqbBM
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX7aMJ71UHqw1w
 uid+9jjFjKrBoZKBoaPpAWJgI85dBQtzO22r4ALHdxS5XCRbBUXXEQThXvPj8DeTwogvRm0SMnY
 dtphjOZCJiYS+wkgO9OR/pTm9PndmLSy3xAM/XiU7MlH47pyuBRZ9sxl/5tXkTZBxcHtLUqiqWn
 OSLWCatt/NfTmL+J5o/9DL8HR/13BxvI3ORPp+++S5c8bqhf/jvP7dAw+zBX6IkMAtenfYiO7UT
 uflowH/KMgZoOm8rPOnG46wj1diWz8R5TwbapV1QsKN0ExZTegi4bO+BM9Yxo9TfETyM7IL7Y1A
 UCXO/DAkxo/H60Z6IT2Fj1OSCgWAXcnruFGIF56L17P05G7X1/q/w++iPBmSQipBULGgen7BxqR
 a7Jm2Mbr
X-Proofpoint-GUID: 2iwUIwwT2L5u-ApDCgEEXcgx3TI-rB1J
X-Proofpoint-ORIG-GUID: 2iwUIwwT2L5u-ApDCgEEXcgx3TI-rB1J
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b9c0c8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hGGMonP7TOO80wKNN9QA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

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


