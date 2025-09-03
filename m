Return-Path: <netdev+bounces-219544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF69B41D76
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778B13B30A3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C82FF641;
	Wed,  3 Sep 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JC/pRYKb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A72FF17D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900090; cv=none; b=EO6aZMt9iZ29lE9y2XdHJZRLpKvF2GkbPsHd76xV5Hmb8OK2/w17M+mG3zw0Aq1wnczq/VtnAcLAoYUyRLtwtGpcU5FMYFQfclhptECDVxDTF+QpCg1uUwVfTN7YxZ1St1Ct/uPxBJoSDHzE2q6VvbMAiFyCRHEVTa+IlNF9MGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900090; c=relaxed/simple;
	bh=iL/XzmseyPpV8hK/O4kgQg+47B+ikK5yJ0SDgvgg8R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpjeFan/3+NQ7wSfZEUFe/5c6DeV3FGrAImNyo2WM6a4zS2B4UUScjdaX+3k28f2JCNqcOrScG3hU2qVdZ6dFZUmZtF1pJxXJdZGh4SV7tmglFbprKs4j7DKXx0/MMm6KPKa3kT8SxiIyArvnhXQ0GglXV6ScvCG4ufl0qpYuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JC/pRYKb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEwUh022954
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptzMoe5mzU7pe9gfLF0XACcwJawnpCLYmxbK3KE0HEw=; b=JC/pRYKbK3k92BXV
	5ieyjJGR9qqYiy+gkh88U9g4nNfZu7a3VAN3jfwXRwRECPXGNv7ZBqbXM/rXtxni
	XJHx06jOf79N1jS6Bd3FeJzQQ6hv0wCgx0VkCFisoZUgtpM3Y1uP1rkJRLKrwqmv
	mS+k/a5MQp1pdznDFX0B6Nn7zoBWSSFyv5oOjDYEdJ9a9acvCu1DaI1iSVYRx1CH
	hjHlh0P382tqnb+7a+kSnrwq/87v5r5XWZBabzacV4sWe6BNrKU7Fek7l8KAq9Rs
	yhoLvW0VErBp3KYDBF0SBypIMvpTZTPn3nwzkUjBsDxZFNTWFoKLF4+JV+uqVv2k
	EJLm0w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ekmkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:48:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7725b4273acso5184927b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900088; x=1757504888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptzMoe5mzU7pe9gfLF0XACcwJawnpCLYmxbK3KE0HEw=;
        b=FQH5wifWNYZvLonoqpAcb3ey6La0hKu6MnYpXT2AkknzXyz2pkWmz2Mp6slXYcvtI8
         Cs625qg7wZ33B899DqPloVueAOQBiPcFVbxd7Mta9Vn40Pwjq36rP5TSvve4K1MCUpYj
         nKUI65xmdo3bZ1LDWGZsnINIeL1I/crIkVQejcsn83kygfUDTfqJBROaWANG1kBUf9Ge
         QFYRXAiZ7+Ht0KghvLKUVjYAfYVIs3npEMsmrH/DjW3zjRov/wJRbKwx+Ix2t9U0Y9uF
         PJPwosHi78J9EMtfYF2g4FPRMN+ZifO6sOTAOH03dg1KBN1uIv/hvTU16Xu8mJeX3iNx
         x5xA==
X-Forwarded-Encrypted: i=1; AJvYcCVLQVxybZ9MyTCPVsb4ZBYxg3+z6s9TfHBPcukuoufVVIufFo7P61HD7WIv2NsZDUBRjAbDMao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOL6NfjeBGhexXu2Jou7r6KRPil29BBVuCWsl/QgPugXdD0GR1
	78/HCqPsW4u7hsi+3qAWOLoH+rLJ+GkyKbpLMHNHRYVsP7Hjrx6ZQ3croniNR22FUvX4HCxmcc7
	521vq4EMsudkENnz1FnQAW+ePWajREGx4KpyjEooylwgdRRGgxvJWDRh2MIY=
X-Gm-Gg: ASbGnctmEJ8W+PsQhpt69JJaV/zutIQBOnvcb9WOE0pfoHWcFcvWgsjHX5jy8V7I4T9
	/Gur1swCmBtCJIGohWH5I9yf+LrI3pVb+NLBHJQdRhuCTr7kt/anQkXGDv3Q3+cPFpMRFRjRUB5
	jyqhS13QUAg7pbimeo/uSH2fW+2tTGHrpj2psRPdinAGohXDq2BsGM/Pod1WLxunP5PYGiXwYHX
	2i+DPC3e/y8uXf0Nrk22UdQGzzs9mLB+C4LiXirrk6Ui850NC1Ebwfl4iTKPz04AnU/2p1BSaro
	kW9GNIKh3FLskc8yWXBTwAVgvIryFwwWqXRZKxVUnsQ1PeoWJvFzebw+CXI631yKqzzv
X-Received: by 2002:a05:6a20:2e1e:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-245fb85f22fmr6898085637.40.1756900087830;
        Wed, 03 Sep 2025 04:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESmO9fuCQGZL0dDqdivH4Yd3OgnaOimF5E4/NDsZ5Ka2qIuzRAwLWEesSF7738knmXbVKR1Q==
X-Received: by 2002:a05:6a20:2e1e:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-245fb85f22fmr6898025637.40.1756900086874;
        Wed, 03 Sep 2025 04:48:06 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:06 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:08 +0530
Subject: [PATCH v2 07/13] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-7-bfa381bf8ba2@oss.qualcomm.com>
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
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=iL/XzmseyPpV8hK/O4kgQg+47B+ikK5yJ0SDgvgg8R4=;
 b=ehU7262fiOcOFmjWpHiqhp3CyfXbLbOyDWLLhlZwJMNZYrcsDHNXGKfhHqTPFDGcrJDmqUoZ6
 mp35mSc0QhTArkAIimiorimSB98rb2w81w6HnSuE0LJQC0RT8YEwLK3
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: pPxT8QQmtGQ08rlIghT1mHVi4wXHjEGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX/WuE+h1mofFz
 ccC2dk1/OfEZWt8cN4nmHOf4e+bJDeX8fu+qr2CKl8per0p1sQq0Z4D15lqsIPVX6pBnH58LOxP
 AsLVnhiLcUpopcy/CLxbnnBhArv0tISzcU76f+3BdXJrp0BdfYMJVzfdnwP0lw9eCJEJke3P4Rl
 DAJ/hVlc9euIJIoUA7wZLc9cjkswJovm1qJXEA+H59dqhQVMNDvAHIgIagZwomYd7IL/81EoO31
 Pwlb6WGZAnqERkaCxjZj9dzMmrQCsEOO0MT4SPPXutSySuJ8t8zcWq3mQ5S5eIqPk46yeT+ESiH
 HS2sYblS8wEnmVGVOd069j9BUhwx4PbDHzFf4bYh7K7vhcPKS1kGiCeSjy5UEBvW7IhycT7vDwy
 K6IWBWC3
X-Proofpoint-ORIG-GUID: pPxT8QQmtGQ08rlIghT1mHVi4wXHjEGK
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b82af8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 7528fa1c661a..eb7682fa4057 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -425,6 +425,36 @@ &qupv3_id_2 {
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


