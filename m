Return-Path: <netdev+bounces-153503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFE9F8558
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02EB1893FF3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA820013D;
	Thu, 19 Dec 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SnLw+Tf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA321FF60A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638355; cv=none; b=Rma5UYwyr930UCFV2FK8lcPmh8KsmngO58rXzB5PRSkRZRoY4UkrSKR9XHSLGsnUOLIGfoxqjmevbrPKCR7+D/tUf3M3n8PAe6ti12Xc6QBxcO5TWYQw9+PP5rHxzPFupb7uNbE7b63UGPwUlws2Dy4grm5Rhbhb82MqIz1Tib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638355; c=relaxed/simple;
	bh=QvPC9XT2nTzuBVKU8Y0OkYtXeaFjH0JRpNZRrR05gzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0Gd6NlYhvnQ5DEmIiX97u6aQm7g3NVza/TOzMVGIaRNOte747h60GLnAlej61lkhWpfwSvo5qQG0EHiQpVv155fG6I5h8MDYlwB5JFRzsbhAZAAyaqzo35FZLrNM5l1Toek79ff/n0xd18mBBkAlmfXC6kcCVIF4tm1wmQ+b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SnLw+Tf2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6a618981eso205173366b.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638351; x=1735243151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z+OFIo6oYvRs30dPwtO+gLECAhFDSFhyF+Jm1Y9wnQ=;
        b=SnLw+Tf2rZViKlc+V7t1D8e3z3fpd1uD5s+SJUFoXd0UkHTZTNaoeIl/79r/YbVXep
         aIPDHNvrTkifvkVIVMTvKSKjd5jFvigE9sqPq441WgLbFPJjfJuisotqxVqjxKBSHA+a
         dUBnNpadWjhUEz/yhs+tNl7bkNmohauxrYMJla5JawiRNEgS3Ee+loZPREnPWD5lNmaW
         TGe6EaEnm7loaINWiu/j0vl0Na2OmvC7wxpnT6GU6CHNSUoFYFMRXOPa0rOVDbFWMeqP
         SqKulM/EUmeUxZHk8WLcE26QrI94V43tje7BfPu4AMHhaOX3HT6vx4qoWPI+3anQrThm
         H6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638351; x=1735243151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z+OFIo6oYvRs30dPwtO+gLECAhFDSFhyF+Jm1Y9wnQ=;
        b=C/efaRkER4eWoHRHWSE+tFJdr67HUEbBBB83FeMfagNnAnhofY+mjUNSKy+17FIIv8
         vLj4jL3PP6T3GriqjEGUnlN0xEpNgeqbc6ZH5hVhkTa3AxXDyDpD74fi+4TP6zNV81y4
         IiC55W/Rkru6pgDF0Z1+4/2LleIbkQyt5JrsZzxi/optNt9d2enrCBdqYeQD/BgFT92k
         lgSuqJ9VkxkZ1JO1ARhhqKmc+WStnSIl5zWuch911juhic05qKmAFEz5IwxCPD/QVJG+
         naNzZBIP3yABNJuEaZxAul/jIPsskoHd9Ul1J2EQ+feeipSryyZB4B0//bUcaFT60bJS
         gx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2e/ovb53LA9IMnfpbKPNzQ+sqA1Vaurn6Pdj531GSL0jt7XusCbRqMRz5pQW9mB36ypCBhfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpBvL99fKm4DCv+KIaA9xWff30E+yyGm4uKhswCm6JmHrcIKA
	x6vsZbpGqlaOD98TseQFIaJ24c0RPDUjxmtDbExoWVR02zB6Jj8t+D1qeXfiVEo=
X-Gm-Gg: ASbGncutxieytLlXe5EF0PEeUQtAxfAQ66bOG/jFM1Ci+ZsUCwGl/vDM1RbxctkWeUx
	G5aWx7LWLoYTNXRIzWsUG2zjtwcWmn0b9osD0VBAsVvEPDrLmx4nyLlpakbos+DZJv8Qb2KHwYC
	wE9FR7IIdIuKdtIRDHboqxIqVEwHIXwFfGKW+R1xd7oJqCr/giICbJtYtK2Q/j0RGNSZEtpEDnM
	oFiPIt1YbEOF0TS7jix4SKgJBFU2qwX15U8uF23hP5QVFbDeQ==
X-Google-Smtp-Source: AGHT+IF4QehdfOuEvDMqzB9MY4lPolUTGRMgbZDTTZ30MZlE7/TjNW2+5MWxblm0XOXTHJASMqJcPw==
X-Received: by 2002:a17:907:6d17:b0:aa6:8211:ff85 with SMTP id a640c23a62f3a-aac2d479750mr6446266b.35.1734638350970;
        Thu, 19 Dec 2024 11:59:10 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e894781sm97668366b.44.2024.12.19.11.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:10 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:57 +0100
Subject: [PATCH v6 6/7] arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-6-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=msp@baylibre.com;
 h=from:subject:message-id; bh=QvPC9XT2nTzuBVKU8Y0OkYtXeaFjH0JRpNZRrR05gzg=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqn6Hqj1OYj4hs2fjkpBZl9sNVrwPbMm60vH0xXVTv
 onsrKedO0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJFB5k+B/sFhC+ul/0kEPe
 742zNtvt/yYQbtX24KrUqrP8c+1bpTYzMrQeOJiUdmw+t6m6tPe1CfzCWh8FzRY9ySycxqF5sCf
 0Ci8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 0469c766b769e46068f23e0073f951aa094c456f..7f88f284ea5daeba189976d03dbd048626104b77 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -161,6 +161,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source = "suspend", "poweroff";
 		status = "disabled";
 	};
 
@@ -173,6 +174,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source = "suspend", "poweroff";
 		status = "disabled";
 	};
 };

-- 
2.45.2


