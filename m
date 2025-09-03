Return-Path: <netdev+bounces-219546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA537B41D81
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E47B5801
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1643009C3;
	Wed,  3 Sep 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioE/qN5g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E53002AA
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900101; cv=none; b=mDgyOPgzrc4PPyl1KlQT7KgYWN44+ihLM7QMvxCvItj0rQ1XjMo1Yxx85TR7KWIRQfeN5TkKGyC+zmUi9xq6DrH+ZZId6/6mnmCGapKrWOiZPaiEzP12SNy50tpw1bQVb3JbfWEFT5fXADb9fi9o9ghEyAzsFlvATrdIFsYWccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900101; c=relaxed/simple;
	bh=OMmO2qusXp7Lt8NQ08hSTCdRjFkU8mgyUlODCMZLmPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duDpZR4tnVXoABOSKVqmAmOpAJ8WmjlrDRiwGxAFdNrrqRBXNhpELu2F1Jd1bytwj7c6REFDXSZ+Y0et9TZpVH5wxP+36fshnNuVPJXlev+RrTjgzk7QysnXLRecg+AevzIvtmbjXq67ZH4cLG9UsNFsl4LqCQ/t31TGJ7RsKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioE/qN5g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEniY013456
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HYUvyVFhjknE/WVt1KWvLE4zOZML2zuiKhdUsPmDp6A=; b=ioE/qN5g1eg8D7Xu
	7S12Iim6Si5kXMKfZovyxl9tgsw4l2Kq3HRCo7O13zZawjWASNSH1yNIK2ddOI7+
	ANrXcdHFxNPIW6i1wQqVRLh7oFC/yX+ZXogM47/aV5tAuoReNk52Ab8NvSj1giHf
	wp7RyU+nwQLJQCyNwVIvIMt0RM6vLboqJ7NnOW+Pq+eGPZDOCQ1IOys5DVZnnT5Z
	ye6cnolLNt74xSakF+EAeCipbkPmBHiaJ6d8efeLffXv+fUFLAKz05C6isKOi8BC
	0Za3/gi3JhdjY3ogEQDfQlmC4YXFxuMzpXj5iXEvAaeYo0qcaKweoBc9XVS2umeK
	vWYH6Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv3mpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:48:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e395107e2so6400274b3a.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900096; x=1757504896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYUvyVFhjknE/WVt1KWvLE4zOZML2zuiKhdUsPmDp6A=;
        b=qick/5JQ5F7yUPU+FMQhi5ucO5CVxJY3fVPNHRMp2eeouJdmArqQtZlbspZO4tjdid
         HooiSnSJdeaIG+4v/7JySnoKc8X0VN+pjKKq7J1Alx7mqq+xXA0tjZt1AWIEuDA65kgs
         McTjhhg/9/uSPbReTYfwi2cHsBNIwY+I38aICpFppuYsl/NRZ5oy7NUgrBkU33eALqLL
         USUS56DPylDG8a3nIwkeGaYTFGMGRilz9RuEcpu6MTiNxnIQdeXW2Mz+6LpcI8R0AxSZ
         9Bz27rmc9CEOTe7dCaLmlnqRkgmOYBNygsG1aiJJgMPADC/Cf9T343hn6AEuefQXUrq3
         0VrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVclPsb+n/6cMuIQaUalz7rTegfU2yf0+WaqBjYPyHGvec/RY42DJ1XpRYeTgcJIyol8e80FFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpsJK95L+Mx15pwPc4YMRtW/EjKIuAeBAJQb8OBQrNsvU8LbT
	wvBl9YD4+ImWdJzL0xighOMGXS0NuzrGIpti5HYF8ld8I/ZmyjobWBiDZVZJWlEF/oH5GBlXJoG
	WN8nt0hSQtqz8g0HRekFTx+7UZ066OKhmjeL9J3MrG1Yl3KvQGMLTuAaWmck=
X-Gm-Gg: ASbGnctJvJaRipOwZQIX8Sc54LELIGLClwejir3r8/B/NnxBUrbFpiC8OmD16GS6XFw
	+jTSTFm4fLzYNGWGrbZn7w3lCAzECG88BjzeeNFr7LHZG5/FcnK4vdcvN2f1RVTr169mwmubYYX
	HrJ0T+8q2jeHZgDWTtOYYyGqId0aWlzdjVpTNRt0iak0ZV1w+Bm5lU2rh0ksk3hQsq4URAN4cvX
	00bX3yF2hU6emfvhMVu3eYQvT8J5y2/hBJBH6k8JYp+VVKY3IyyWvBf6WhH1r9j6PGbuIBZiPMv
	fdewlZcwFZA6ZgsyI6lfa/FcCyfmJZIM8AQtLorz0YXB9paAPOi12C07BrxSdG4R90zw
X-Received: by 2002:a05:6a20:a10d:b0:248:86a1:a25f with SMTP id adf61e73a8af0-24886a1a5f2mr2868637637.24.1756900096008;
        Wed, 03 Sep 2025 04:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVF0YOtRnZh6lzIY4bOOxsucOqwE7IEqnFh1IXBtFdue3ljMah6LLr0S8VJ+jEOBFs+TNvxA==
X-Received: by 2002:a05:6a20:a10d:b0:248:86a1:a25f with SMTP id adf61e73a8af0-24886a1a5f2mr2868592637.24.1756900095515;
        Wed, 03 Sep 2025 04:48:15 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:15 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:10 +0530
Subject: [PATCH v2 09/13] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-9-bfa381bf8ba2@oss.qualcomm.com>
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
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2112;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wbi0daESjbNaIOArppgBBTQqid9X23CoN+c1pFU2aSo=;
 b=oRJD5bisNnpttQ3ShOqU4O6Fi5tTtdoR8thW7WDzmP550KyX6RXVCczUsU48CPWFCTuk14V9X
 NXYk6OUNXoMCcaUpcreCPEpn4SKKXbJz6dUaLyuOh9QtmZOKBj7JsLb
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX2J+UVIPH+mmA
 ZPIvVo4KZPMWjOLssIj3UR2CSSlh7lC7/BL7IDqgYajWyywoN6PFnL0bL0xmmXVp5oO+ynm8ZPg
 EeqE6gap6Vmdu8iWLjGpWZP0Il7b30J92U5A10NL7pHjS+1rRPa5WoRykXuY3z5cI0jcMaOJEGd
 b2GeFBrax4ogpTQfS7gUolraBRS6E/l4iB0nqQyvOF+PYIb6rOngW5nlKKy+4uM7MB7lf1S6bLU
 oSlpJTBz74Ui6nnnydc6cbNJ5upSmWYJOUSJp+N43OXR+9WAm5Rpm/hXvcUtHk0DWMbUXdftmd7
 QhRQTNSVMvWtzxiqkcW3nPVqg75RhbXiXs7FOLljaByIdQTJ7iMVBHfRfOmdjdXcKy2Jxtkb9Rv
 eLWPGjr4
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b82b01 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: fJ8Gk-BnodRzd76u9dCyqAy7KdWCx9CK
X-Proofpoint-GUID: fJ8Gk-BnodRzd76u9dCyqAy7KdWCx9CK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Enable the first USB controller in device mode on the Lemans EVK
board and configure the associated LDO regulators to power
the PHYs accordingly.

The USB port is a Type-C port controlled by HD3SS3320 port controller.
The role switch notifications would need to be routed to glue driver by
adding an appropriate usb-c-connector node in DT. However in the design,
the vbus supply that is to be provided to connected peripherals when
port is configured as an DFP, is controlled by a GPIO.

There is also one ID line going from Port controller chip to GPIO-50 of
the SoC. As per the datasheet of HD3SS3320:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
pin low. This is done to enforce Type-C requirement that VBUS must be
at VSafe0V before re-enabling VBUS."

The current HD3SS3220 driver doesn't have this functionality present. So,
putting the first USB controller in device mode for now. Once the vbus
control based on ID pin is implemented in hd3ss3220.c, the
usb-c-connector will be implemented and dr mode would be made OTG.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d85686d55994..b67b909fb97f 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -538,6 +538,29 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };

-- 
2.51.0


