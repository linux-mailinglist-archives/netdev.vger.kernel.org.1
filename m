Return-Path: <netdev+bounces-135859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D499F713
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2A2281949
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68371FF03D;
	Tue, 15 Oct 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oqyNBxUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D481FC7E6
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019842; cv=none; b=bkhiRhKERXgVLPNAn0km93dYR2T8xyf8d7H87Gwhi7KGoGxJt1PR2lXAkxLZ+NwdiP5QG79z7sU97awoPuJTfILv3Lbd1S6ELzyqVx8DM4gm8RqLkc4jrlzghNjBp7IORyn6AreHNKpLUwpcYJ5207n16vvAo9g5tS9zoXGQFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019842; c=relaxed/simple;
	bh=lb40xLu/VXrpPNedn2QOJM+HYtvP+0chbzXXKOqoOlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rn3buzFh4jwJHCN6errOxC0uoXyyT8ACVVRRZaily8mQGfig5ZKQk/59YbPkZUifhYrKcCYLjb10mnggpV6r4KWbp6OROVZJGNm+P45WAlhyyCf3t29c3A+Mkp+K27RKkTpMrJY2JIn7O6Nz3ODGL9m7on3L1uHCvbZPrxCb5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oqyNBxUJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99ffeea60bso437017366b.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019839; x=1729624639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p570CyCpET4jQOMvqTRvBlj0hjjJLO72psUJRNLRpe8=;
        b=oqyNBxUJiVwQVjhd2+Ch3d+xtbIXFW/osPtkqkGtccsOjMtB3yJA0MzSknL9xwKVMf
         CCRhA6Y0hUIB9JxVKZtbmeTQBgG21/p6tzhB58S9jyNOhgxnguBVjdOtfq49DrL1Hgy6
         pClpuZuFV/COeU8vsjBcJRHUV2gTAVzib7A4v/xvpFIiLtYoN3BGo6rE7OM1sM4DPjbs
         kONz9mJ9kzeBbC3ogBERG0hw2VZCt48kpWKLK7WXLVQi6gmHOZgsS5fYz5dkgwl8Xfpy
         bqEjWiSfU9IaI4ND03tsh97hTb1WZVTxILXx6sJAsxXQ3B+m0/I9DdKaPMnQpDk/7owg
         gv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019839; x=1729624639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p570CyCpET4jQOMvqTRvBlj0hjjJLO72psUJRNLRpe8=;
        b=vXipTTN+xdcKSa4haxWqvSgidQ1aNGsLgoEIE01Y+ijAFOP9uxDjpWosaPyIqJJxAx
         pXL5oDg6uMWpfRik1SgCskbhnyDV39SE819f5XuFDAtMkYX74/oREnneAsWLmtL+9ZAy
         4QaInwMlWATxxc9Gx/7JSas7mCslfq9o3mBeS68iPjP6n+lF8C8zE9pC3/XmzCSClJXs
         0/dlTw3Blq2ZBcCApfGECcxedTF6MQIK0gSiTxIyTJfaC5czVTg/dyxlYFTcnIVDhink
         536w5K6E6uqLHatbK8PypleJQ9P4GfhXiR5Afi3rS/QMfPi8aBlqWFX3fIL9IhF8J7eO
         ZQXg==
X-Forwarded-Encrypted: i=1; AJvYcCXpcKS4j6Phnh5geCKxoR1a8ChiFVqA35vPftWaGx6IuijSKB1NLIMrwsMFkxzeh1mHOZZ/T2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRKs5rTyhzKlyp6hqo4AXznERcwPaFXLPx+xd7KKeu+Ify0kA
	lyo31l91TGni4246yU+WSaX91MPD+lo0/ePg5rxqVw63qkUsWQUc47lBbIYYTPo=
X-Google-Smtp-Source: AGHT+IFeN2E97a+E3jhI8sBljZvv6XC7mfzgwimmU3ry+3H1MazUngu2M9qkKbFXzssYTp7lbfxmBA==
X-Received: by 2002:a17:907:9709:b0:a9a:4d1:460 with SMTP id a640c23a62f3a-a9a04d10662mr844482266b.63.1729019839017;
        Tue, 15 Oct 2024 12:17:19 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816bf8sm100951666b.101.2024.10.15.12.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:18 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:16:02 +0200
Subject: [PATCH v4 8/9] arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-8-fdac1d1e7aa6@baylibre.com>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=msp@baylibre.com;
 h=from:subject:message-id; bh=lb40xLu/VXrpPNedn2QOJM+HYtvP+0chbzXXKOqoOlE=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59q94MX33ke3S9c4mE9jWHv1mP//Od4Gayds38yydZ
 v7npB6zXEcpC4MYB4OsmCLL3Q8L39XJXV8Qse6RI8wcViaQIQxcnAIwEZ6/jAzn9mxmt1lycNe9
 2dWNL/cnhb/10NRZMPF0+CKGhFVXS82/MfyVreBkqimdrOu19NX5C99vFH+21DlW5Wcf7ew0qWJ
 RjDYzAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 0469c766b769e46068f23e0073f951aa094c456f..06361cfd7a8ee6f2acf2d15e8106087dd0f38008 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -161,6 +161,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -173,6 +174,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 };

-- 
2.45.2


