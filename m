Return-Path: <netdev+bounces-134591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFC299A4CF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122CD1F22A62
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669421C172;
	Fri, 11 Oct 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H87lTaPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281C21B454
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652691; cv=none; b=RYpZ+l6qjXirfc1neLPTUISZxF5GTnET+RzXUMx93Ujxz7+NDOczNNRQeESxD7qFxYAh7Ip9c/vDr6nQBK3Wuk6ArYImqWIFq88/WoEQmDFVWkcrpjZdBOjT11ovI6EUZHDEPGnaTX2366GCsHjlMbPwJR72FzV4Xx1v/QbQ8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652691; c=relaxed/simple;
	bh=L5jePk++a0uY91JQrASnpEj/bjSiMyJjUq1CjjPGGl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdSZrRlGDuwql8ICfW3WxuxlEE4ifgDtdYnPSeIpcSnlxAENjZPY1s6CxqPK7LpYTDJqtghTHecoupINpA2D6oag+mHMw1vpzEwk+HE7UcqAA4og8TnIlZ1cBs5zKolE4uaTwPBSDR0dzywokSCPmCsB5QFRIPPzQwiPt5v5jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H87lTaPY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a994cd82a3bso284361566b.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728652687; x=1729257487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81ZVnQPK5cdOXNd0U587x7C4r0h4m8ObdC4H2ODABA8=;
        b=H87lTaPY0pqpOIVw6NoS0mlPKQA9Xk7udRF+puaHWRLWaY7xRteySVTfVsy7RsJ3aT
         Lj4cP2BgrxZ3XSZmd4X7HI1AEHOZj4M2qCvHVUT0SWw7V0VEH3cdfkN9uGKgQkS/72ZE
         XkP6hAPcY9RsFK4mcqUOkjS7EJg0fBpTXk3CsTFsW8qg28arZsqAx2mSJd8M7v+PqDBO
         CPLwEDWbft2MvKd/G7TFpR0v4y2aQB5eXisMrEKGcH1q2orrM9quIkB6EqbmlS81Luxa
         GzvqDg5PczRfXVJD4V6wSJ17nmvnp0lN0r906/dFQQ8xcKCpqknFBb51PxfJL7tUFyTS
         goKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652687; x=1729257487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81ZVnQPK5cdOXNd0U587x7C4r0h4m8ObdC4H2ODABA8=;
        b=ZK5Y7DS/+vx6DnIJ+N1c4y9RUrjuHUrKmQAhHgqEQPu+V1vZqV/cHjaoYXVMS8elbZ
         rjSsbCfBD3Ov2xCvfaTnAhBDSL6WbfNMDvyl29JaosdhcZGUhfwIpFc+wTYB6dh3W55K
         zMeIO2QoQgO7w7uLdhhnkKodJmJfytjQKiY9IMQJu5uWXk4ywtmexVtPpKx7SEQGnMjj
         9uDrgZ9I1HEMe//y4uORo/HMLm4Ywsr92TsjNIfMlkpT+EBOoNMFYnlLJuuaCJisx/TT
         HPbVhxE02U8pbKY1SfzXh/sRxD+j11PUz9BvRwL/DxSX0c4IlfdtDdE4jom2BCyW7xFk
         5tsA==
X-Forwarded-Encrypted: i=1; AJvYcCWrunk7rktXPaVXOkqvys2dj1jpyVzaw21a2npnscXAQRwHKCylpcpTcEiCGWKlUIQWIM3mrHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tOJgmRRvhkpREgA66QTg7WqJXHYTeIXo/tboepf7NMmT8Is2
	yrnuzDC31SNkLRT3CshHd8PFjEsJEnzSnd8R3lIy7hNXtav6NnW/EU8YOD3+72kxX9FcHV6DbEC
	U
X-Google-Smtp-Source: AGHT+IHbDGF9CwONYy7YWYnq2FZ03Xgnf8reWi/jbzYRG3jSk4wq65+x+A4vLhSV9xJFaORvZ3Lz0Q==
X-Received: by 2002:a17:907:3e96:b0:a99:6036:90a with SMTP id a640c23a62f3a-a99b93f9128mr214915266b.14.1728652687535;
        Fri, 11 Oct 2024 06:18:07 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f2c1f4sm211948266b.87.2024.10.11.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:18:07 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 11 Oct 2024 15:16:44 +0200
Subject: [PATCH v3 7/9] arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-topic-mcan-wakeup-source-v6-12-v3-7-9752c714ad12@baylibre.com>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
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
 Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=msp@baylibre.com;
 h=from:subject:message-id; bh=L5jePk++a0uY91JQrASnpEj/bjSiMyJjUq1CjjPGGl0=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNI5VUtUg8TPHv/TlFH/510N68/nFlVOsSWXXn25E9d2X
 fTXbJ8rHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBE3pkxMuyuv/7pTk3DfCmj
 q4zRzAZbV13y8NfRFpxy1LrgT83Dr8sY/tkXhF+3trroVswxr3JqSf6DTeHxOl9ZO4xXN5Z9CM2
 dwA4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index bb43a411f59b281df476afcb1a71b988ca27f002..e22177b9dfecb541e99b0807f8b79e7b878b6514 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -160,6 +160,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -172,6 +173,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 };

-- 
2.45.2


