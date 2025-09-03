Return-Path: <netdev+bounces-219537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3FEB41D50
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37593AD34E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6C2FB991;
	Wed,  3 Sep 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e4LoB8m4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1627C17F
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900061; cv=none; b=bh1eNK1COJ2FHbnvbd6f6U+g772jJzhiJiQprJKNbgWghREFNUX2TrrGq1k87ZvZVIHly5H3eZ6T1/ZpFiM1OFeaiy+J6YKXcW6Ny6L3dC3BZ/qUO1/kQzp0xItC0PnFr6NJqu+HCoSjieCWo510H2qEi749c4TOhLN248PGsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900061; c=relaxed/simple;
	bh=Eml25tE/PMqpdUPgi2zg/p4TXqZ5GHV1QMH5uPmwQVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r2kCVyW8ILygi6EqjnLAh5zzFzOgXEZD4VRwPURrQRjOhgqbUrmc2wFQCfjtNOHNWQ7KlAoX9X/QuIS77AG6z84aOX0vCBGNwEO56z6vAUd78lY8MtHsWqaLtb18KdK2eUj76dFjuUr4Vd0BmxAuT6xEUHnmroXmdZYV2cXKchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e4LoB8m4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEqGF009331
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kaDjf5c+uhKXe5FQi7pnwu
	9nLLiN8zTh/7GMqj5X1js=; b=e4LoB8m49XOJ4Gm+5UH2m0sK3w6uBt6qWlwcKA
	U4kq+695XEwrsy+xLCCBpPHP9Vz1UPEIQ3fjZvr5cnUhHX/+izUuVyNYyKByZZAW
	mMWdqoAf+71tBVr8djyoPnI7XC4q1+mzhnzjdxJxKwj/aOhm5Rj6TqpvG7mOR4jv
	pU9eVqfahIjZt2x6i2qcMPu9CxPlEUzCPoXTu4EKmeEClnmcjvCk0JwhnFrsXB0j
	5Jebft0KXg/kK7ZXCqK8Xv4ZC29QJ7uLuxMXZc6qUz3C4Pnk63Mby59bLk7XQUhy
	sfSEa2U6J+pWLI/WYTg+gQ3AxxYZqoSXXnUN3J9Kp5U5z1hw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8uekp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:47:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4fa4be5063so673855a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900057; x=1757504857;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaDjf5c+uhKXe5FQi7pnwu9nLLiN8zTh/7GMqj5X1js=;
        b=Pv7kahYaEh9+elkfKcxegqofxWTjwVuUG8XaVw6r9haS8/KlfdvilqNvM4xFOzI7H6
         QFjMZ48wQCPgvq5dHMkPq2Jma/MV9r4smuuW4S5lBNI/brhcVlrKtfIFozzYe0tk7ddE
         hZn6xpaH1TNmueuEWziR7Su720NTpjGHxTT7KGNSVPkn3Fg898AQiiCmi4HDhW3Bcnm3
         IVvZSmlzbfy+TMa0vBW7TagIP0fx5q9N3TnEJJFgDUrSGskvgc7F+USZXR06FRm0aYLf
         TRdsjMhqHyIe4xVVomLr8b94I489VrCnMXlUGrS3cfj3k91wBSuH1pQhPrCkIvZyFFg8
         +n7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXilpGgbGoLAKUU9vEMzc+hWbAvEdJDz6Q0a7CNQuTcj59ZUih5S3kE9Gbh880Heu+i8Yecras=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqosboIjBdLrdwd0dh1Q3IookwYxxjfEDnxD8vP+dOfzIBkHl
	5aNcPct5qvAWgBFNA6fcXlbOeTrnLsVdrPa9yOX0VXsXnlfxd/6HJgObHXsgPnvIwZE/Nr2riQ+
	jzjt9AePbG/oTkFPx9rY1PBpvOyFVRUzB7cutfCYAnnBIuBM7bstEwoAQURQ=
X-Gm-Gg: ASbGncslDe3Dj+nONa8MS0ZdKUhusqXMWCCVJKSjd3hIQcVMNaz5y9E7iR0nWToJ1o4
	rHIx261fA3UP1yRYdDvkiUfR8zNY+DoGPVo20IL81kUhqOELXZrEV3Gg+Wxgu7we5IreecZmbGA
	FiDXZl2T/akoP0zCByUX7HSIFME/7vkUan5cLQ/rY+N7nVGoi+4cl4zmR79+wVrPaN0zJ3zI7y7
	Q8zd6tXOku8BpjBHK0CtZfznvbnaDS9MZUGbSm6X8tnNg6RQBsto0s+KqduzjclLVxZteEsKmQx
	vEdnV7qsjucx4gNKRESPPx0AB0vCvVgzIReWs/QBLa7aqdjj8F7jVx4Kez2m/oYIAp4T
X-Received: by 2002:a05:6a20:3d07:b0:249:467e:ba73 with SMTP id adf61e73a8af0-249467ebcafmr1232274637.55.1756900056994;
        Wed, 03 Sep 2025 04:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUeomsYGeCP7KfRGVrszEhiBsj2RPTl3kHrn6SKPUY3NNh5JI9b1gwC3PeBeEaF3a8McVeYA==
X-Received: by 2002:a05:6a20:3d07:b0:249:467e:ba73 with SMTP id adf61e73a8af0-249467ebcafmr1232230637.55.1756900056475;
        Wed, 03 Sep 2025 04:47:36 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:35 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Subject: [PATCH v2 00/13] arm64: dts: qcom: lemans-evk: Extend board
 support for additional peripherals
Date: Wed, 03 Sep 2025 17:17:01 +0530
Message-Id: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUquGgC/13MwQ6CMAzG8VchPVvSTUaIJ9/DcMBRZZExXWXRE
 N7dSTx5afJv8v0WEI6OBQ7FApGTExemHHpXgB266cro+tygSRtqVIUj+24S5HTD84xsSRnLFTX
 EkDf3yBf32rxTm3tw8gzxvfFJfb8/Sdd/UlJImBlVM/V7y+YYRMrH3I02eF/mA+26rh/0Wy7gs
 QAAAA==
X-Change-ID: 20250814-lemans-evk-bu-ec015ce4080e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=3236;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Eml25tE/PMqpdUPgi2zg/p4TXqZ5GHV1QMH5uPmwQVA=;
 b=6qFPTr/qAm5IVCQLj8xxXnPbgmbpvwGKPIbHSO2uQpqkshKKC57fbWAjBBimbLvC7GMAvT7rG
 93jP1aegPVbBkUMjB8fmVgvCdLkF14d43P+wcROKSBw6mCU5cQs6yWz
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: pcDcVW6odlmQNBpMF2DSIVPuSMdACN0K
X-Proofpoint-GUID: pcDcVW6odlmQNBpMF2DSIVPuSMdACN0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX1iqg7umRffoR
 0X9MCcK/986tKJffn4E4WThU8Ok4HFUZ5gRlJTyj2biX3eE46D2NAGh6RI+aS8IJ7qfiZ4g5AJE
 zMulFcDhI6w8ThPd0abb0+B6ApM4CVD76Yb/H01tJ6hU9ItVgHfHKXtjwId0XRYYEnZrkOmUUNi
 5p2ClRutsOjp7P6nfLfz2xhACpIt/wyj8rUFTiCr9HyfFtv3haYXV8mYbLFitZ4DgJtQPgwSOf7
 k1gOIvrx+iino7J3pvHIgzI8UKaasO/hpdKyi1tE2WKpI7m7bFL9j1PHFx0exaBaFFQdiNacvk3
 EVlseRzNUAyJm7cPqa+XnNfEvTOjhyPSr9M9NCxRVi9L+tMMXje971/Fv33YCrzrZ22dvLaIFqx
 XPZ04Djb
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b82ada cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Uq9QPCSC01VCjGS5urQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

This series extend support for additional peripherals on the Qualcomm
Lemans EVK board to enhance overall hardware functionality.

It includes:
  - New peripherals like:
    - I2C based devices like GPIO I/O expander and EEPROM.
    - GPI (Generic Peripheral Interface) DMA controllers and QUPv3 controllers
      for peripheral communication.
    - PCIe HW with required regulators and PHYs.
    - Remoteproc subsystems for supported DSPs.
    - Iris video codec.
    - First USB controller in device mode.
    - SD card support on SDHC v5.
    - Qca8081 2.5G Ethernet PHY.
  - Audio change [1] to support capture and playback on I2S.

Dependency:
  - The ethernet PHY QCA8081 depends on CONFIG_QCA808X_PHY, without
    which ethernet will not work.

[1] https://lore.kernel.org/linux-arm-msm/20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com/

---
Changes in v2:
- Split the patch 3/5 in v1 into separate patch per author - Bjorn.
- Use generic node names for expander - Krzysztof.
- Change video firmware to 16MB comapatible - Dmitry.
- SDHC:
    - Arrange SDHCI-compatible alphanumerically - Dmitry.
    - Move OPP table and power-domains to lemans.dtsi as these are
      part of SoC.
    - Move bus-width to board file - Dmitry.
    - Change 'states' property to array in vreg_sdc and also re-arrange
      the other properties.
- Remove the redundant snps,ps-speed property from the ethernet node as
  the MAC is actually relying on PCS auto-negotiation to set its speed
  (via ethqos_configure_sgmii called as part of mac_link_up).
- Refine commit text for audio patch - Bjorn.
- Link to v1: https://lore.kernel.org/r/20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com

---
Krishna Kurapati (1):
      arm64: dts: qcom: lemans-evk: Enable first USB controller in device mode

Mohammad Rafi Shaik (2):
      arm64: dts: qcom: lemans: Add gpr node
      arm64: dts: qcom: lemans-evk: Add sound card

Mohd Ayaan Anwar (1):
      arm64: dts: qcom: lemans-evk: Enable 2.5G Ethernet interface

Monish Chunara (4):
      dt-bindings: mmc: sdhci-msm: Document the Lemans compatible
      arm64: dts: qcom: lemans: Add SDHC controller and SDC pin configuration
      arm64: dts: qcom: lemans-evk: Add nvmem-layout for EEPROM
      arm64: dts: qcom: lemans-evk: Enable SDHCI for SD Card

Nirmesh Kumar Singh (1):
      arm64: dts: qcom: lemans-evk: Add TCA9534 I/O expander

Sushrut Shree Trivedi (1):
      arm64: dts: qcom: lemans-evk: Enable PCIe support

Vikash Garodia (1):
      arm64: dts: qcom: lemans-evk: Enable Iris video codec support

Viken Dadhaniya (1):
      arm64: dts: qcom: lemans-evk: Enable GPI DMA and QUPv3 controllers

Wasim Nazir (1):
      arm64: dts: qcom: lemans-evk: Enable remoteproc subsystems

 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   1 +
 arch/arm64/boot/dts/qcom/lemans-evk.dts            | 415 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 145 +++++++
 3 files changed, 561 insertions(+)
---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250814-lemans-evk-bu-ec015ce4080e

Best regards,
--  
Wasim Nazir <wasim.nazir@oss.qualcomm.com>


