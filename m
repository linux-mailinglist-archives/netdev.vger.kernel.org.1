Return-Path: <netdev+bounces-109571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E8928E3D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 22:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED46286A83
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011F17C7AD;
	Fri,  5 Jul 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kqhNYSGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AD17B42F
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211237; cv=none; b=Yo0L2Hl/CO2TncTmxXGtkROJFRtk2gpqVa86PoEiqRPYWIUgrjgJtDI5W2kNiCLg4FOkPiO4Kj5FZw5IwVvShlnHsd3Obp3X7ASi4TQvTNfrQGSgAdcp2L5dC4VY6imaKgH6+By22Ilho9S31ojK9LfbzmrO06eCMlUjCnghcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211237; c=relaxed/simple;
	bh=x+REoia1SPVixROvzFdazwCRh5mhW9XzZbQzMlPar2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwEAEN+kniLy+8vT5LSj7CVdFOCcvC9HDct/QC6PDbXDa/XvQh1GjYwLoooxiZzaCWOamPzweIoa7aI2tXJNCJUabqRig7gf1I7Yj5qXbCa7oDhSn94wXhF5uoKKe/PlyINbsQ77g9bDafB3sJD9Qex7URurMjBOBQ9U4tOXgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kqhNYSGu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-426526d31a3so5572175e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720211234; x=1720816034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xo8BvOJHNg5KkElAnqbJxKoNs4vF5XqhPo69/tFmIJc=;
        b=kqhNYSGu6VaYR1mjSrfrMzijCLnGY2zRDZeZ1Ou0s5wrwyX97PAr8ANVsCUP0d3hbh
         abf9pxBH3fDbinDMG9nLyJ80e8qXjXfbbBSwyL84yVJqu9Ql5AAiz4GgGOthaFHYlxIK
         j8L5XkrjM2t+OeGiZKASTZ9I37T3SdpBuf3NlVrxpMn3y3gj1U4I/Ff2CnHBPCJ0UucC
         NIoulD+QBaMhuGMNfJFlAhZ/pSJyz0/gFN6sxUMQJw/Pl371y1p04A2iQV+Mg3atFxz8
         dPQLvqiECX0qj8jbTYNH69jwPmqc5X2QtUa3Cop9y6T7xZuZUfXU4qLloxIYmfbycqrQ
         oFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720211234; x=1720816034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xo8BvOJHNg5KkElAnqbJxKoNs4vF5XqhPo69/tFmIJc=;
        b=jijFf/zXhH1h+SoGqnalnfTaAko45yBUlNx9+TZlELwnjIdVwJAckkvTZE9QSr7jNe
         JJBn7YI/XmoKeXClvelWQviWtwTbWTvwNyRxKxGLIoH4XDNCwqSKlKWtqE6q2N4ZyAYO
         7DwhO/JN+W2NEMFrLpJmSJcUz54cvCJbyuo/vlUIcodQiedZ+h/Ol1zrIsnImfg+DA69
         wXUJVK28fo5rji+L4LwhcVZk1xtbSktM2cvMH+v4AVXvfCf0+8LFgAcx2BX9JKKjqRZJ
         0aMNkc/wgAWB9rlC0yrmmkHdf3rjNOBpVzlOPu6F4d8aMxPh9QmoG05EdaY/Vpl6MLIS
         Zj1A==
X-Forwarded-Encrypted: i=1; AJvYcCXcPxdXnTvOImQaPn/nzYaT0uNHijMtuAVS6WodMgfVdgDuQYw478YjXAkivd2ixq3RwcJtUgG5vhnd2BUy89OaPGUj55Sb
X-Gm-Message-State: AOJu0YzktNVG68cyu1J9ouJ+xRuJnw5XTxCtk8Auq8PGPtDW/QSoZp9E
	q6XCPDCc2Iq3LYvisIk0txyEvBWdpNdKezZuS0N17iHMUWkDebY3VQ81D/u0pbM=
X-Google-Smtp-Source: AGHT+IHk45VodLs4hfZ4bMqYhA8JhJaClHg8mzt3znbrPWdgMMhSoHE2jkLb2VW+d//JgbWdYJaYpA==
X-Received: by 2002:a05:600c:4993:b0:426:54c9:dfe5 with SMTP id 5b1f17b1804b1-42654c9e20emr18480915e9.10.1720211234305;
        Fri, 05 Jul 2024 13:27:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c688:2842:8675:211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm74397625e9.10.2024.07.05.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:27:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 05 Jul 2024 22:26:40 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: sm8650-qrd: use the PMU to power up
 bluetooth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-hci_qca_refactor-v1-6-e2442121c13e@linaro.org>
References: <20240705-hci_qca_refactor-v1-0-e2442121c13e@linaro.org>
In-Reply-To: <20240705-hci_qca_refactor-v1-0-e2442121c13e@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=kdQldVCRGhnIPxVPu3DpUjVdb4CujtCOUfjhf5GMlEY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmiFcaeCfsaInBBJIIlhG+1f/h4DrpvPHua2tpg
 s7T2ZuAaUqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZohXGgAKCRARpy6gFHHX
 cvPIEACF7n3xgUaa9Am60rAm+YiQrXmvaiDReuJWuKZ2mJCC0pglCJK5K9XEpSalxPOhUGbaIpH
 nu93vvC0ZL9kH1Ow8Oxpi8Cd0sqjcKWgLQHVfuXw3fTPO+vX7OC+wTN9OoyTtc68Gp08HUV402W
 ZA64XN/frf4gLo8MynFzddhlYz+oScisQx1zlRYkgY0m4HCdoRK22ATDh4fvaVESUIqDyoWkHJ8
 4HzwpZvKHop1HGHRk+3uaC+uxhaXUAITTZ14vD5X9h7QZYSD0pMELSgTEWH9LMGmX8z81KHjhF0
 np9v5kI8M7IRISCndFEThWWnIkC/HjJW+tnTwIRQad9FmhempXux2cxDNkF8lq91sHJl38y3mN8
 SNwRhM5gGTu8/2HLyX6+eER3PEy8/fp47TtRz3uU9DXwJ6AGnjK+YyEtpHRpvxkjDR6xl0Dyn9t
 nQjczoH92VdohNbX48KtbynSTQ97wfspJG3WNF3fY5imsJDz+HBTCBXZq08BnWFrsZnqu2C/EVJ
 Fev/KcrZP+j4qa+UtjdWs9JEHBzmGjibFQSMwoDMRh00jnrafkD2NeCPBjL+iWYEFBzneAWTW7/
 LFy+wz6TZA8iQ2bJHJTA0/vtIp2+ZKpPjGGCKSGfpkRU5NiKkgS26M+YSlyCrMokhlIOwKmiGYd
 c40Ymd6+uyULcrQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Change the HW model in sm8650-qrd.dts to a one closer to reality - where
the WLAN and Bluetooth modules of the WCN7850 are powered by the PMU
inside the package.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index b0d7927b708f..8ca0d28eba9b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -208,13 +208,10 @@ wcn7850-pmu {
 		compatible = "qcom,wcn7850-pmu";
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&wlan_en>;
+		pinctrl-0 = <&wlan_en>, <&bt_default>;
 
 		wlan-enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
-		/*
-		 * TODO Add bt-enable-gpios once the Bluetooth driver is
-		 * converted to using the power sequencer.
-		 */
+		bt-enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
 
 		vdd-supply = <&vreg_s4i_0p85>;
 		vddio-supply = <&vreg_l15b_1p8>;
@@ -1255,22 +1252,15 @@ &uart14 {
 	bluetooth {
 		compatible = "qcom,wcn7850-bt";
 
-		clocks = <&rpmhcc RPMH_RF_CLK1>;
-
-		vddio-supply = <&vreg_l3c_1p2>;
-		vddaon-supply = <&vreg_l15b_1p8>;
-		vdddig-supply = <&vreg_s3c_0p9>;
-		vddrfa0p8-supply = <&vreg_s3c_0p9>;
-		vddrfa1p2-supply = <&vreg_s1c_1p2>;
-		vddrfa1p9-supply = <&vreg_s6c_1p8>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
 
 		max-speed = <3200000>;
-
-		enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
-		swctrl-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
-
-		pinctrl-0 = <&bt_default>;
-		pinctrl-names = "default";
 	};
 };
 

-- 
2.43.0


