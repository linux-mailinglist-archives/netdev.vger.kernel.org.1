Return-Path: <netdev+bounces-223462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD1B59407
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5203AD625
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E92C031B;
	Tue, 16 Sep 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q9XWoNn2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071E28689A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019628; cv=none; b=DNy0Bs7TQ5dRmIMeIE2vaKPDsyeX9DRi2j68oGU2lnUAh8TeASzxbsjILyDpnNbcUfd3myGinLS/Rzy83Rw0R/xhbhhv9rQbyeYGNw9Vv996BKd1dgztdFljaQOAXOYbXWseHQD5N7Ce8Fp/Kl9FmPP3qQzvmp8WGTFMZ8B9ARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019628; c=relaxed/simple;
	bh=1mI9ppTa+alHrPD8MYXRGEIzIpbRXrOmPpVue9Aa508=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KkQ09t3FRSQCaW4QdFdgv/9Xc0MNlRTXvM+G38n5D142mHv1RIO/Xoisw5ohjRbeUp0ybHnw5tcFTHmGT9qebeLA3On4cQhPwkModmfw+mkcvUvYNxY+2SzBBJi64FSmn1lL0woQUxSllhopiCblkI7l8gSubT/NxU20klbBmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q9XWoNn2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAWFc1019586
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k+LD0lfDicHs3z0SKSGb6Y
	rFHfIbrIvaBcdAM/oP0EE=; b=Q9XWoNn2Clg1BECWteCsjA9Fo6+cLaOJ67qqzR
	dV/Yw2dxtMC4WS37OIp/bCig7378ag75I/0iBrvsI6f2Jl/YVzOCod5pGWazCfJ6
	DvUnvWg+cm0dAg+KAiFk3xnPpDjwZTf3KrzbEhhguXi1vXRrJSc2Fv2sUMq2qu4C
	NV6s4oqrdYK5RlWoKpLBEjvmINgw0TbkEWU4aJPQCDwUcM2LjqfRWKb3Rl0GsXYC
	EVTaFMkF+/Zl0KR9+lQFR1Vkt76c5OVNdPRQJ/sAHnUjWIh9BjGpKlih/kHAlnUJ
	Hy6CvpMgFoq9H4EeJNfSq6QEM4Xnd4MqKRT/9oV75FLfunUA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma8j3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54ac2658acso3209342a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019624; x=1758624424;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+LD0lfDicHs3z0SKSGb6YrFHfIbrIvaBcdAM/oP0EE=;
        b=JbZaz2WFtOTP1GeFu7sVy2zmSiRy92gED7/4ZV1n0SwRf1i5ws8Y5MttUASIAV8yY3
         7987Cllkmn6hEI+lpXmYyYgeyUMsE5RpCP7DsbxjAHJEqn3ORHJwCTXUuYD/X4q+UKan
         dcj3oESybGRx6oh689kKdCTJjb7C6zomCAmqUcdHkGyiJcb4asXTknvBFhd8b5lJExcy
         VOqNA6w6qECXs+8wkyL7jGEUKHDLAWC4WIhXZy2T2Po5BK2Bj4kAM3BnZqhbyV17fmV0
         6Nm3HdofUAoc//7nogFaTpQfM5n2Y5CUuofcKb7dWeixNKlLEV3blq6wFE+kq6wMqvOe
         +d7A==
X-Forwarded-Encrypted: i=1; AJvYcCVouXj4SvdLMa7vBG4J+CgB7b2FQP349o7WLeKLEIae8StsbPfjL5PWBio9/Wz427EW3aGsUxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAs9aqSclb39ReWoKDf9XNgvIx2leoYLi2pUhbFMznvVShvseO
	MhZQj0JlK+KavhDENE5qhTlvWX0+Oq6050Nc/LxyZsTwULdZthX67UTLK0KzJjWlIqa2PXWNpMP
	YZfBoR6PD6tZPh3dh8hfTfqglRahjlLHYZR5n2rGhFvddfZqku9QZzXatpb4f+vIcD8g=
X-Gm-Gg: ASbGncvMjbUDYff2gSN64/Z3xDCblOaNc04DRjrdqABpvNnHuXW0Yr4PCLRHaqzKBNz
	yjNR02QPyvWM4zO9+RJ5KXssPSC3qznbC8k+Qgt7Jv20/aT565L0ZKc8TGpRjtPZRu0WeQ0TY34
	mZEDWEwPDi52cfMRpjYVX/1Am+ID8F7BkBg6La2LsRkbrOsWugeTLrYTAh2aheawqVYvkuwdhz4
	FzYdiXDBRh2XuI3rBnchObknMsC76Ck29cOzbvvfZW/i6Mw1cVG3pqEadJLWTW+Gb9u5tuFlcoz
	ibVByBizwCE66/xkQ1AT6HjUYqS8xcT5r2BGdHxFSU25KOHLn9klTTi7JPE6wpSdDg7e
X-Received: by 2002:a17:902:cf10:b0:266:f01a:98d5 with SMTP id d9443c01a7336-266f01a9b37mr87189865ad.57.1758019623763;
        Tue, 16 Sep 2025 03:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd/ah4dRhxyJBnbbxfbJnqOEDhCK+vtcEnddej+JXs/E1YTJglxqY6A1uv8NoQtF7AGesKgw==
X-Received: by 2002:a17:902:cf10:b0:266:f01a:98d5 with SMTP id d9443c01a7336-266f01a9b37mr87189535ad.57.1758019623269;
        Tue, 16 Sep 2025 03:47:03 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:02 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Subject: [PATCH v5 00/10] arm64: dts: qcom: lemans-evk: Extend board
 support for additional peripherals
Date: Tue, 16 Sep 2025 16:16:48 +0530
Message-Id: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhAyWgC/3XPSwrCMBCA4atI1qbk0dTUlfcQF0k6tcE+tLFBK
 b270yIoRTcD/8B8MCMJ0HsIZL8ZSQ/RB9+1GGq7Ia4y7RmoL7CJYEIxzVNaQ2PaQCFeqB0oOMa
 Vg5RpBgRvrj2U/rF4xxN25cO9658LH/m8fUsiW0mRU0aR4RmwQjpQhy6E5DaY2nVNk+AgMxjFB
 8mZXCMCEVsaqbkttTXiDyK/kfVPUSKirTXG8VIo0H+Q9BvRayRFRDnJc5flmdkVP5Bpml71hwn
 ggAEAAA==
X-Change-ID: 20250814-lemans-evk-bu-ec015ce4080e
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=4914;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=1mI9ppTa+alHrPD8MYXRGEIzIpbRXrOmPpVue9Aa508=;
 b=SaRI+OQmMd3thxlP9vYKNdZw7W7qiuyLpzxw8uSxYM/n491tcIj81KrlCFhIdxQqKhVMpBj+B
 MGqY8U+u50TDJrTRb5ojGS5VnOZH4v+dYHOxfAiP0bl1knzVoFTmFXY
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX4N08rOM+k+yT
 liQTKK6/IYspRfbzzwTgoCo4k2O2umBQW0uNdzMtCz15vKugUgaLu8eQNntFLPRJcmJbTvvhSSz
 YT2l2du7S3+9Y/3tMZh7uHeCVRQDIf9EzdXw4GVoVvU58RgXkcoUtrxLXZtqUWKJIsfXJdQCutf
 KleBQ2HuoDLsLoeOoiMoz895No79QTwaV0jmPvaaZTIXTv1Qv7HBHFIDsi8EUZKCuoAJhKpAmKg
 9JntyJ9ykIdrQYK7QBW87GSb+x/mgxY5ikLcNm/GKAa0hbn9chMBTrmAxf3Nu2K0nciC+diqr6m
 t2yaJ/+zyvRqLPN965CboTlKJIKFmcPo0YP6/R+fD34458NM0DU/HoADCXXfT7m6GdzZqo3Qr+T
 7GplBeSR
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c94029 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UzDb-niT3-dnCAiDllkA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: -kScxYHP0B6NlRConWbVMhhlp8UXS1EJ
X-Proofpoint-GUID: -kScxYHP0B6NlRConWbVMhhlp8UXS1EJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

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

Dependency:
  - The ethernet PHY QCA8081 depends on CONFIG_QCA808X_PHY, without
    which ethernet will not work.

---
Changes in v5:
- Dropping these changes from the series, as they are already part of
  linux-next:
  - Audio change [1]
  - MMC dt-bindings change 01/14 (v4)
  - EEPROM dt-bindings change 05/14 (v4)
- Change bias to 'pull-up' for PCIe 'perst-pins' - Konrad.
- Link to v4: [2]

[1] https://lore.kernel.org/linux-arm-msm/20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com/
[2] https://lore.kernel.org/r/20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com

Changes in v4:
- Move 'bus-width' property of SDHC to Board DT and also keep the width
  to 4 bits - Dmitry/Konrad.
- Update commit text of eeprom bindings to describe the reason for the
  change 05/14 (v3) - Dmitry.
- Bring all tags from v3.
- Link to v3: https://lore.kernel.org/r/20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com

Changes in v3:
- Re-order QUP patch 05/13 (v2) to not break i2c node enablement in patch
  03/13 (v2) - Dmitry.
- Update commit text for QUP patch to highlight which all clients each
  QUP is accessing.
- Add dedicated compatible for Giantec EEPROM, because usage of generic
  compatible "atmel,24c256" alone is not advised.
- Update commit text for EEPROM patch 04/13 (v2) to emphasize on EEPROM
  enablement - Konrad.
- Put 'reg' property after 'compatible' in Expander - Konrad.
- Put 'pinctrl-names' after 'pinctrl-n' in PCIe - Konrad.
- SDHC:
    - Update interconnect nodes with ICC_TAG macro - Konrad.
    - Put new lines for each entry in interrupt-names, clock-names,
      interconnect-names - Konrad.
    - Put bias properties below drive-strength for consistency in
      sdc-default-state - Konrad.
    - Move 'bus-width' property to SOC DT - Konrad.
    - Move 'no-mmc' and 'no-sdio' properties to board DT - Dmitry/Konrad.
- Add 'Reviewed-by' tag from Konrad [3] on Audio patch 13/13 (v2),
  although the commit text is changed now.
- Link to v2: [4]

[3] https://lore.kernel.org/linux-arm-msm/b4b6678b-46dd-4f57-9c26-ff0e4108bf79@oss.qualcomm.com/
[4] https://lore.kernel.org/r/20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com

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

Mohd Ayaan Anwar (1):
      arm64: dts: qcom: lemans-evk: Enable 2.5G Ethernet interface

Monish Chunara (3):
      arm64: dts: qcom: lemans: Add SDHC controller and SDC pin configuration
      arm64: dts: qcom: lemans-evk: Add EEPROM and nvmem layout
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

 arch/arm64/boot/dts/qcom/lemans-evk.dts | 365 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    |  92 ++++++++
 2 files changed, 457 insertions(+)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250814-lemans-evk-bu-ec015ce4080e

Best regards,
--  
Wasim Nazir <wasim.nazir@oss.qualcomm.com>


