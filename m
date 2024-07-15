Return-Path: <netdev+bounces-111597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2335931B23
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 21:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81185B22354
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62789139D19;
	Mon, 15 Jul 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b="u4Q6oS1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8779136E1D
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072448; cv=none; b=pzLriHZON/3JIvlKzmIDed43WUI7ujF4/J/E4rmAStXkNfNBjBvwc7rgbVgHtAR2FJyHgcJX0CrP7H1k1OePXR92EUOey87MM27bFzkHnLGsHPq8C8cKSYMvdg0flr6+3dOZ6q1MJm00NvT9e8N3Z4LCWAdH2cDWwIkqzjhP6tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072448; c=relaxed/simple;
	bh=sbRViy5ykjGgKnUq4j3VvRTeZAYlWQyPTNp4p8FLHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHfgGy9QrBODJI+wBKDzsiffTu5OlOO2logAJCNI8oLdZtH1hzmKfiEF/szAyolxAdGwBC8onuWPClq3sSpuV6nrFL7+/SvFabELSWoXLUXM1F8eAolqSKS++pOd5mDmwHSvOGwHyPlqknwGfqWKZe5JS4LqfM1LT42b+vuRw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se; spf=pass smtp.mailfrom=blueri.se; dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b=u4Q6oS1T; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueri.se
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4279ca8af51so27737355e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=patrick-wildt-de.20230601.gappssmtp.com; s=20230601; t=1721072445; x=1721677245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WC0w3uJ35BJMQPZT5UQFIOkEjF8xfPSTQQ0MU3kBU0=;
        b=u4Q6oS1Tm7HDnl3xaqZ6TQQps3RJs6bZ8w3AOW2wM31f1DpzMCil7bdrnhGkiaGeVr
         +L+SvtLU+eQcsdSzwXNHQml3Pi09r+TTP9JnguK6Yd8Q2WEKgpP8Kg5ArZlwrHVdhNNp
         vKqQ9GOgl3N26kyHcwKaCvXRrrlcWEJW9zE87f6FLhkqIzOqjIIXd42ZV4Xxh7huVC5g
         PRnxIAYjPvpm1QO5ZAqDjnghrX02J6U7GA0TQHl7dXeu8yQtjk1UjXSzqCv7YabDcvY+
         TT7UdZ5rcuzrp26SI9rRTBjmy2016+cyqDRJegHF94vx+uc/W9m7+cV9MLGcCUdILl/b
         XjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072445; x=1721677245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WC0w3uJ35BJMQPZT5UQFIOkEjF8xfPSTQQ0MU3kBU0=;
        b=vWzedTQivyMarBV2R5LEpNr3t48bm3EYcZhrODTGBFFTtH0gEnFNof+AiMRPlGerGD
         +PAp9BSEen8s7aj4eTt8YhK5VoIHGpE6U8T3MecA9IfWEzVRi/2L2yWhE9ZI4YZSBCG8
         MPNKKvspxEMBAxzh7PwtMVwLt5t0DbVjUiCc6VDsdc4C37Ax+o4ZtbzhDYn/Lv7qrasC
         NRQG+Kk531bh3zR+7zgoMiDaAj/+PoscVMSEOGaNwW/o/eWRGCVn7RC/sujVN40Kh/Xw
         qCHZ0LEBv0/VezpqMd+MyJE66qpK8M4ilM/sKdtiLmtxoeIedj2LEbeHV1p681JSR9/Z
         xIDA==
X-Forwarded-Encrypted: i=1; AJvYcCV5GG4g/SfBUJ369q834GmfWOcy330hAAII/GHu4csvRZMq+Y5bTv/TsOcZEOplLkUyiTvv5XIivLYsMouTq7XXSLrYyS0D
X-Gm-Message-State: AOJu0YyFSFzzGOEF9ZPRJhV9eVX1J/MMQ2yGs4BPiXE7L21AyTC6SNjR
	zFFDqrfakRBPdGG0kl0E2peUXxTck+agR6j37eZNTKtVfUXZ5lADlNqUeiNPB80QeUwcr+2DLXh
	AmpmC8Nr90qSqyX4KUDaNg8CdfbJIbTwz
X-Google-Smtp-Source: AGHT+IHYO9brQgD8jRZ+FVHI8vi7M0jjEb5Rm3a/xbi7wAtWHpnQrPsVjRB8ZE5/LyluQM6Hzqs2kSSCTHe/
X-Received: by 2002:a05:600c:698e:b0:426:591d:adb6 with SMTP id 5b1f17b1804b1-427b88ce8e1mr3798075e9.35.1721072444845;
        Mon, 15 Jul 2024 12:40:44 -0700 (PDT)
Received: from windev.fritz.box (p5b0ac4d1.dip0.t-ipconnect.de. [91.10.196.209])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-427ac069f43sm1763625e9.12.2024.07.15.12.40.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jul 2024 12:40:44 -0700 (PDT)
X-Relaying-Domain: blueri.se
Date: Mon, 15 Jul 2024 21:40:41 +0200
From: Patrick Wildt <patrick@blueri.se>
To: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Patrick Wildt <patrick@blueri.se>
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration
 variant
Message-ID: <ZpV7OeGNIGGpqNC0@windev.fritz.box>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpV6o8JUJWg9lZFE@windev.fritz.box>

Describe the bus topology for PCIe domain 4 and add the ath12k
calibration variant so that the board file (calibration data) can be
loaded.

Signed-off-by: Patrick Wildt <patrick@blueri.se>
---
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts      |  9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                 | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index fbff558f5b07..f569f0fbd1fc 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -635,6 +635,15 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&pcie4_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		qcom,ath12k-calibration-variant = "LES790";
+	};
+};
+
 &pcie6a {
 	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 7bca5fcd7d52..70eeacd4f9ad 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3085,6 +3085,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie4_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie4_phy: phy@1c0e000 {
-- 
2.45.2


