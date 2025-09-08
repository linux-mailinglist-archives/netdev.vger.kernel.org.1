Return-Path: <netdev+bounces-220741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B9B486C0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2407175137
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704662F8BF3;
	Mon,  8 Sep 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2jwmYEW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C62F83C5
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319658; cv=none; b=QkBJt573TW/iwx1LA8nPI/RpLg86EPEyBrdycHL44TSpLCv38YJTMLvsdXD6xM0ugUe9U3LAHeAXJ2ojnRWKNwTsRhU8FYJ40tU9mlZobFDxUUXTG2jNkjwrg4eySWlqVXI3VkORfQpyAdR4kp/S7kBI5owqFswSQ7PZvwb6b08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319658; c=relaxed/simple;
	bh=cotqZe/TypYCRpLbOPE/9IjMIc2Y2Wh9oNHbNZUjKPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/A6ybkLYX5AH5eTLtKTLKNXrFHcu12hJOPnT6+EjRGSp7/I7OKKMpCBiV3PJ1Iv4a5yRlokKhkML3U9V5xtWaUdiNPcQahWwswK7v7mMsFcHRuh7f+cPCRXmXNReBsNNQmmR16ZnMQdKqQRFXA9zGIYUW6sR3izUaGR16qXeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H2jwmYEW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MGASN025960
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O4bmDMlAr83kjarbdQPNXRMSEkAQzuB9YOir31juD80=; b=H2jwmYEW+6r92U+c
	GmPIboeDPPjxrUppFgloJAfbhyVZPseVy8v4n1DCdAVUpIg9f/9DDA9+VPyns2Ze
	WEsBsvYViq4rE5Y94rdN0lcFaT7RDt532FaVds55186NQSRityBvQsMGsSofxxE7
	hb9yxAql7OsfAg/6AGeabhwUhS76weTuqVS6ibLA7xIC9HCsx7Vs2Jv3ANveh62+
	hMr+/MKHuko4Vhb8Ymw78JivIMkJe1AinqgiE1YyCDiXd4Coq2w0eU3r+Aj6Hojq
	zpyZhGTyr4tss9hLA+8zp9jBrR0cL9CYASrhTkHdXfPNLk4cBvLoeBdGICbV6xFR
	e+w6ww==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kuptr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:20:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c9304b7bcso44770695ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319655; x=1757924455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4bmDMlAr83kjarbdQPNXRMSEkAQzuB9YOir31juD80=;
        b=Ht5ZSy2THzYx207VFw8dsm19ssFsraauSJKPsbdO/uaSnK+Eq17lX+kvIlMuLVbYIc
         rARl7Wmmle/vGfL1AC5R1XbJolqu88+rQC/GP9b4sP73NlSqqRd/jKa/xg1KlDOuB+JG
         qhBMxp1ZUqKn2DRmSHCQa01ca82XAsKY8SJLN1n48fUNPpShJF/QqqUUdGMNPZdTDG+Z
         gu0SA2qMXwkwtonpzH1/temW35KVFGmsB63yAVjf5ZmuUgQrAiGMo40sG91nYx3efR4v
         qmo9UcO5OY0zn4BgiQfy4rr90hTZQ8TIA0xM6xWhnBrdobnyJfoRrPYCx2HmbTN2t/wP
         OxVg==
X-Forwarded-Encrypted: i=1; AJvYcCUYf0MsZU/dT7jXT6Np/JnkuschRKlAB23GdYE+jQxDy8i7K89Hn750+MQ+4THNxBMQImbV2RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkMWjQSI65aN+HPdjoJ6x5y1BMQqLMy/ztwU/O/Tf43CG9nv4
	wS50QrexAisOFHN+FktZzjb8euI9t6v0DrQr/Ceg8DPZOL3Y19H4lCMISwzKRs862/tqO/Ces6g
	h3GNiZtBkiD79Bfw9qaJtohZujUWrnepwPKg5vU+WdtbgiU4yIu1htigh9h8=
X-Gm-Gg: ASbGncsj0ALitzRuF6rPw3OxvQK1dF8HFPdGSeBg+TCd2Lt176zLEuU4E84Es426HTD
	MmzFDN1mgO/U1jteodsJ97SCIMAGLLrIL8CJZdMFAM8pRJgkRj3siMo6kHiYOf5V182U2zh8JAG
	zvCrYthJY6MA5HPWPDPXA/xdVo0Rb8Km07Wm20K1HImV//YC6Iylz4nuyrbQl4jSCEojH3hNaTe
	H/7qzp2Nt66WlanF0n1HIZfQbz0XvePM5W/iR5aQJnESp7xABAnCddx9w+BmU2QCq5dzDJDxt5n
	aTYxxMMpN4EZUi+zmKqSAAA5qGyzVegd4nUWr8fSG8qREUnHySXrbbCXzRydc+v1mVSc
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115481705ad.11.1757319654848;
        Mon, 08 Sep 2025 01:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyKAv1bm1x/8ViIApnewyx6A0HUi/joPZbuM8m6VoLS1sL3/lRwAVXdrizwiz8S6y8u+V/jA==
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115481485ad.11.1757319654435;
        Mon, 08 Sep 2025 01:20:54 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:54 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:59 +0530
Subject: [PATCH v4 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-9-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=926;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=enf8ibRVGnvRD27V5ouRqt4BCtLlEPGBzdF16+U0RIU=;
 b=siHIL7dGkdoLax4tSZ1agBwc5p8Bm6n1mgWA8Fz6wVawE1GVJ/QdPpLOpJ3pOZ8rv8wJrb+DV
 Dn0nCGS0NTQAO5Y3DF8sc22/5YO/7sMSWAgbZM8dKx2sO+6KSU1sPxV
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX6EBNK359CvTj
 lKX8CkHvwXsXg6JJvMgcMP2l/e/Stq5FN1xuTuoa5kov75w6eLHBTDo6tZ0jFNCpgblxSK2XynV
 uMoJW1q+8aZYcDUxO5pYMq3hIObzJSrvTmALgPdLjgwOtA0I608nL66WPaYW1W1Dk8Q/hawZcL6
 W3fuYZ+5rm1kL7ILVuLG6ATyQpISKk6VksgRIuNAKx1PJ+ja/AT2QfAEySPxaVrzg+iiMzcM+e/
 KyiQIVjFUBCqEcr8g/EgVwGzPZefyRepknF99/WHVvdBY1EKvJg5WvbFezwrsU1oJiuU2wofw4D
 8hBnuqDws1XVGS4z3PWv9aZOfyXBDCsvClvLyNoiFLufyCS/Xhx2ewQtJ5s5wgWbAkbShgMfsuL
 huQE1Ew1
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68be91e7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: np0XvIu0z-nEn_xzezmFO9A2vKfi2Clu
X-Proofpoint-ORIG-GUID: np0XvIu0z-nEn_xzezmFO9A2vKfi2Clu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 1ae3a2a0f6d9..d065528404c0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -333,6 +333,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


