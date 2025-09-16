Return-Path: <netdev+bounces-223469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5DBB59435
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446C32A74CB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE93054CF;
	Tue, 16 Sep 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DP2PJ8G4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC13054EA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019665; cv=none; b=cHtr1/8+JivkbeGq0E4BCeBgnNNZaLk77iU+ow8qgHE18DgAsjM8gZV1f7y2LvBgs8WLXvLK3eMS2qcnZErJ/BLbdWgWJM6A7UluilgoAPolzIur+PP2qrq6TcmzxrMC32o8K12sLM6Wj3C0D742aZfWHW9Ar6irXL/w7WRcxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019665; c=relaxed/simple;
	bh=49TLFfWXO9zzGLOBCx2a3dZ/ivoyefy2RSU0Yi2uKbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pn1AZjt/8yrhSh8p3tkUwsyqt464EzxFnexZNs8i1TqT0zxZVrMlKqquon+16/bNd5PRqmN7WRjEJZ/8iAC0VZvX8Kvpy91NwvZaOdC4Ujh+KMLRaRfzJbd2WKDWpF8EF7AN+IAtm2IThej8EZbORIQWgx+TN8Mlt1Yz3BdoavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DP2PJ8G4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA37Ms014090
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G13l+nuJj9x8TNLqCD3MuqoqSxgxI9iEO1u8WoNLkxo=; b=DP2PJ8G40tTR+CQz
	2OQUl4KQYxdbG3XJJOVZQCPkAadQwWyAO+8IY/PfQ0AFolXBSUJSniB/CnP5+KZk
	0f0eOU7vQSJxNJ5NJSszRwBf1yhhyqcTMNvpl2q9+WlvnTETyjMdKD0kq25/9yEt
	ZfgCvRzmLDdQyHqcQShOUO5UG5hm6RLWW7LDpCR4JLeTKCKlzYuexYAffmQK/ehF
	maYMb7cTVTiT9WK865as39K5l8B2AKEdF1qp8U7JKfu/1+AHiiFjOQ1SihKs0+9+
	Zz3PN7Qb6CykGbbVxo+Ny87L+1lB4Xq3LA2Ytxhg+qGMhhWhhsXvS6TyaxFtKTYA
	iKh7PA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5aspn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ced7cfa07so56186125ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019661; x=1758624461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G13l+nuJj9x8TNLqCD3MuqoqSxgxI9iEO1u8WoNLkxo=;
        b=UKdb69xctiduOk+vb5QLe9WLaCmKNs7KFxGgonlucnFpBbdnMx6LuaMoef+knSb34C
         iqor6XHlyzdOvHogFg56XnVBBbOTMz686jjLjt4RfIzjnj2WCAe/o0/JJA71Pq6PSnAV
         tJPmpqAEpFc8yMdmYJE/uMHOV4Kda6u2OclL2A2aVI5MhL2ff48HAkjBxzgTzTjXozth
         MsVPEXsajBdOLbG4YxBUJg2Va0GIQryjcdlSXzTQdepI5zKHEFasErGYtoR+EY107oYq
         xm8G+EWLH2eZmvJxEn6cZ9PCtcz3F2Vmgzmal5HouNkWZLuhlP2X9nPdbMnpnf3jfHud
         jcaA==
X-Forwarded-Encrypted: i=1; AJvYcCUcel82MMnXhLflsXf97HI6B1Ag4w2df8R28E6OIlJjqduHDFn2gmili/5U3+fU+wTCCTx0Ses=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XGNu4wY9nuD78G8Xkiv18jZIH+9Ig+NjcdNuE6ghM+LCCFAH
	HJBYim2SmqeEjoLdvSSRaB1eH5rFySmvXnIof23QE5TGD1NPu7Kw1CEyz/DDQL0HsIgLitydHfA
	XF0+eA996IwGi7I7X6LCk4kAX2pqCisR2Ui/MlD2d2aDj2YCL9sRgGRvO43VFLrq8quE=
X-Gm-Gg: ASbGnctrRO/POIagI7VbiW8nqpyhMbQhYJ/N8rjj2xCSTjWOvo7Sgyctu6Lbkw87BUQ
	pUU0DVjjUwXA4w828F8kCEHeJJXadcTHFF9St36TO0TfNCSWxhSdSYwnG78SwBhN5vlgE4V3ERD
	n3adH1ugx4Ob9Ghr2CoeV0AuvmrQy86ccyCezykrW3EOL7h5eBnwaB1m+D296lCq3c1Ga/3t7/n
	DI4vcNQxPOELWckT6/h+qX+zieyBqyasIj5fc75zLtPzVNY23l2EK8AROQha2PFq1nfNsis1MZC
	28WKHtlbTeNm+gElqn88v7eC/zqWDV4GXhhfDwWqqxiiSiiX2u0RkNF6cn4WD/xCSOn2
X-Received: by 2002:a17:902:fc85:b0:263:3e96:8c1b with SMTP id d9443c01a7336-2633e968f82mr115750725ad.33.1758019660591;
        Tue, 16 Sep 2025 03:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO3NuF3KqjR3XEQ1Z2CToVDA8lnbswTSpPZ/ztELlc6EY7DU9PurAmW1/JhH3cSPT9XpLphw==
X-Received: by 2002:a17:902:fc85:b0:263:3e96:8c1b with SMTP id d9443c01a7336-2633e968f82mr115750285ad.33.1758019659837;
        Tue, 16 Sep 2025 03:47:39 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:39 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:55 +0530
Subject: [PATCH v5 07/10] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-7-53d7d206669d@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=926;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=yr92tEMIiqPdFP7MdBqOVOL3VtzELm4OVIK6CnjuCvM=;
 b=f4fd/y62zrkNfFAYTioACy6y0dLtMr/GJ/SxBY/NOqm8yZoX+663iHBh6KTLbiupWETbwY5HU
 bzsfxqOX2KQAmHl3uO3IkqVu5PnTL4yxXfgPXtFB0umKqEE5BP/R8rH
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: 4JnGXM3-Vv2aHr28TmlAvFyfWUBE2JgI
X-Proofpoint-ORIG-GUID: 4JnGXM3-Vv2aHr28TmlAvFyfWUBE2JgI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX5BXSGXTF2C6a
 qRrPVPi8/wh/q/q4OroXlczQyorJsU8tLn+q5f+YiSMcb2htrMo1iFRgvEVnX6Qg8QDjZWIH43R
 cj4pCFH0088GWO2YCrvwGJDhogNdj84cO6jAXQQlf9UR+kohop3kwTwWSHHH+6uG/rioaH9hBwx
 kFcxiwMCfgF42z5ZoT+DdCY2tgNjWLfINuUdmunuw6L1uAVIGAHnTcz0j1fxovDrNjWL/Dj02aq
 3uCOr4/wxkL8LYM3HtaDpFfMh8fZOnjc7F2CjRcteNtWVVNNajF/FUtbM4rVJ9dJ7yQs895ycbt
 E4se9S6x4hMJF3ByD/VrH82jf5qTVWFkQ6tTBSYYfXZb7b+TtWBYbXDFQxW/GiQtyb/v8u5vie/
 5tpIpvac
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c9404e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

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
index d92c089eff39..5e720074d48f 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -385,6 +385,12 @@ nvmem-layout {
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


