Return-Path: <netdev+bounces-223466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ECEB59422
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4C07A1B1F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2F2D12EF;
	Tue, 16 Sep 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFuahuPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208A2D323F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019647; cv=none; b=gtVUgPB7IrkONn3Md5WEbbN/nM3xj9YoJoK5PcoIGyd2I8KZimN2wrc89dMsF/9Luu3Q9remUu/HIq2wgcSC7WVv3DHetYezKzJh/9lLyeADPDIwfaJ9+OSez83/i0KpOM4ko2U7k5YeACEAwxSKoiNN3fZDppuesRbGOfuj4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019647; c=relaxed/simple;
	bh=oJ1RvJCommkmu9uglugPl/o5TOg6XYqZSj96bt3gm08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dM3m8w+2VuaLSxD6bdxgS6RSITQiRkrdNJ8Esy9qH7aumj4hBPY4maKGCWn3Q3BwHYLx4oL+Jj+R2xQSlG7ec4EjDw/JxTXB8ySf14UlRs9Tv4PGI2ciywSXaieCQa/c62Cj8PYP0zjXutn5F9/adnd39lfYq2P9hL+PDc+bQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFuahuPZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAAHOu010542
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3y9/lW+dUggFVSzfvHXuYGDXV3KHAmr21I+oLDCe+i8=; b=DFuahuPZOlzqguLq
	rB1dTBnZTKYBJDgPnhrXlRXm847vSMhRqYuJ1Z0Zzg6InH3CBe9y8++C39jxixsm
	1qrxwrSJjLFaIGuRJkY4alYrfR03NPhnv79SsvTwD/CPbKx/sQZopD+3a9viyHUx
	CJKhPhWmvBpI2RIrOEchi1DUP2aj/BVO/Ob1PImSMgWDBLYJdKatsuEevh4tqqch
	SLF6+CoTYo8npElCo7BqUBuzrZ7AX4HrvvkCQPxyk7OaimRF1tyG1NEAc2a8q+yB
	ydYbWK8p2xsxP13pSrhjxdFPv+yzz5ynR0RmgSn5gv5tLTHWB294rt/4CHG7tAeB
	Woc9FA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snrc7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-265e92cc3aeso23109955ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019645; x=1758624445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y9/lW+dUggFVSzfvHXuYGDXV3KHAmr21I+oLDCe+i8=;
        b=OYFjEPorLSSmEYrzA3Ka2h3e0jjAglmnzsKAsbTIiB+bRb4mEBQNEHpnwfvS6uFXIQ
         EpaV9q71X9MC9Vc/7GkuBXH89zylL/D628j0xQqM2rhgBBWc72MzHzYYds7kKnx9aKDD
         iyGsy+jYLxP4a1BhXRPMMIrq/LNihdZBBI1UvtyAmaHnrB1Wzvjkj0QesOzpgFhTT2v/
         5Bm2nv4UeuoErRYeo9xcrZLTWVkvlTypnJl61vNFfTNDKT16xE/bjZgSxMRntVlCujyB
         dNeacF4MgcfTTYk//w1rWlFOxA5nbdEZ8UjIDG+C42V/R6LJyG/61a1M4SZSdIQmmYpm
         NL6A==
X-Forwarded-Encrypted: i=1; AJvYcCUZeP7AQ4851IVntFMseoWGXgYdKsGO/XVB4Ob0urD/P1U7VndMmPPcTDldqSlKdRLpz9gcIM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyggcl6zs/MZjDlHECHsCJzTksO6z69ZIGtbreMJRRqO1SiybDA
	b6XANeKuZo8HJst0Hrve4QsyW9VS2CFc5YbMEDuFNemrcsV4xvpV0OTyl+/1SrKqMriRq3D8SLO
	a+njJwWy/GqO5exQNvQZt6mdMqYAib4tF/lc4YonzAUZ7P6DnDuagnKciwxvPRvrFwdk=
X-Gm-Gg: ASbGncs6JI0sUB/jnRhUyFVP/dn6sR8BW73Oaonj89J5PC6XFq4SkJCS2zYG4S6bdkr
	HlY7tC5GqL3rFKy+0gYLwXWnaXTA/cNCswV0EApZK5OWDWbgPb4pkJusV3W7PLN1aTANiHA9Xat
	rHyIep5p5PDgyEGZptDitIzmbSo3910kkjy5b2jiMf+JrEMlCsu7yWSFf3RWGA+ktdcpFZ+7OPC
	nIr8IN6NsDdLjt0jrzhw1PDnzTGQidAIf0KlBrY5rQB+02nWzA91v19zxZgRRmRED4UEu/g/QuW
	sbSJrIxAusIuG98zFHlda6xVYA+Vdjhp0NA1WE4JYUWeY2b1uN4YB9GWfrgOzDeVM5Ui
X-Received: by 2002:a17:902:e80c:b0:264:ee2:c3f5 with SMTP id d9443c01a7336-2640ee2d03bmr123766575ad.19.1758019644597;
        Tue, 16 Sep 2025 03:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+5F4/ks5izFz/8ODx4Z6ZKWI7DiUymBaWyZbEu0DAAKCuw77f/zPp2LE9+eLdaj0Pke9OtA==
X-Received: by 2002:a17:902:e80c:b0:264:ee2:c3f5 with SMTP id d9443c01a7336-2640ee2d03bmr123766035ad.19.1758019644063;
        Tue, 16 Sep 2025 03:47:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:23 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:52 +0530
Subject: [PATCH v5 04/10] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-4-53d7d206669d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=1222;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=hgxN5DeUETfnMsGGyj/LuHtMQXwKu4mfjF7UJJuk/14=;
 b=dQl/fiduzG8G/4yyKev6vXBvIOcR2ykJUvYmQQ0qmkB0fpgcHyAlEjDXY3/8Q8+qGCeY3Fwuu
 o1MbY6LFCHtCgVcECnIjtg0xmKRTHCrNvp2Iy6Sq7zgG4gPoJBhjgu6
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c9403d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=cq19zQBcvAJi0RM8MkQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RmKDCMAErwL3SFCaq4DYsLlqw_vdLfMf
X-Proofpoint-GUID: RmKDCMAErwL3SFCaq4DYsLlqw_vdLfMf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfXwuEOyLsealCG
 OXbLvY5VYbM5vZ98mCSK8jt1GLbZqjsVKmj6BHWE3gnAYtOQZgsZDkg2QKY28mpW2a7JvSgNvrM
 Z2omnTvh+qEb4zOjjkz7p7FHPjPwKdEIp+SIhutVq2FFZmypq3JUdRpmhSu2MNEqzu2VmWFR+Di
 XGcfSKXS037NgmtYA/ovwwNLGRujCMRG02LKussOFbWfbxzDbpyDfc4Ilw7Lw21kh9A9a5byvmM
 LQaV0mtDvyc2DZXH3mShQqV61vZC/4l5FoWn9E3+u9l79ThP40Q7SRC5+vuI7hTxxPwfdYM2TsZ
 ALJfvYjDd2jeKtgOHPa5ln9ABltu9ElqLUHWbrRfJzMnXGCOYXHjTaG/ZKitFc4DDWXYmjo0vGh
 mMGNHwjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

From: Monish Chunara <quic_mchunara@quicinc.com>

Integrate the GT24C256C EEPROM via I2C to enable access to
board-specific non-volatile data.

Also, define an nvmem-layout to expose structured regions within the
EEPROM, allowing consumers to retrieve configuration data such as
Ethernet MAC addresses via the nvmem subsystem.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d1118818e2fd..97428d9e3e41 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -371,6 +371,18 @@ expander3: gpio@3b {
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
+
+	eeprom@50 {
+		compatible = "giantec,gt24c256c", "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0


