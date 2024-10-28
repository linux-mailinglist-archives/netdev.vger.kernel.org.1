Return-Path: <netdev+bounces-139603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43B9B3803
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905721C22134
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E61EE01C;
	Mon, 28 Oct 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T5bLXICu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3E1E0DCB
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137233; cv=none; b=YIYs4c3mDsy2QIdwdH7iij66MJHoy7OrBwZWBscHfsnBOX/V//Glx+RyTpKkP9XIVY+V42wfdz0JBmKA8LwQPnyZG9UXwMhmsSdDCrSrKQtRxGg8DA8FkRI/noRb45qmV0vY8JpzGnt0OXrEFtuphXi6WX30FnYkAOK1gjlqsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137233; c=relaxed/simple;
	bh=lb40xLu/VXrpPNedn2QOJM+HYtvP+0chbzXXKOqoOlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JefacTPLoim7jpspQ4PIbLmN7AO+1wF7de4eOleJ2Mcwszh2n48k5lxBfuof9eOrL03kx8aTZbUufeKbLoAcimgworRodnv+X+HQBCHHg+4EYglplVs4byXdySVa7LaRLT/lv4a0PUZPWFkfJcNuxhXnWuh4LxNWGkIprRNzEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T5bLXICu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d8901cb98so3837276f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137229; x=1730742029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p570CyCpET4jQOMvqTRvBlj0hjjJLO72psUJRNLRpe8=;
        b=T5bLXICuY0CiKG/92kgQm1dM5ZWngXuf51K8kBFLaOPP2jqs9JOkafaJSfqLMEo7hR
         +HEGG3ahdsKCUygQIrRezl3TrsbC7Eol0v8JcaIHsvUcZLfneUDu+7Dic9J/8jAZDAUN
         NdlqgwS4QnUcABzZ5HzOGMPcxSDsTreTez7qx5CX7jLoyTdXsVV4rbj7osv6jSwbB+aj
         jrZn07W99eUkguqIVu2L38+qfwODeKgH9Ceoo6fE5tNetRC6nMcwQ/UL//Jztetl3C52
         yAeein/iUjJ9kR5SKrdYngq9crhXjMbrzTAr9f0e2XHmx31o66hFpJNWT2tUNceDjDwj
         O73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137229; x=1730742029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p570CyCpET4jQOMvqTRvBlj0hjjJLO72psUJRNLRpe8=;
        b=uWDjjUKNIJT32zBZgf2VujTRcxnh3hBM46HFUbWfZMTtJfvKp5SzuZuVtEW5LreNnB
         UD+aGJzdhL1cZRaAhkWbNNZgmiqZ3FZV08Q84k1uKARTVM5TbwhpHEDT6J7C/QJT2b+T
         +Y00f7rlxW92CE2h83K5n2gHdejx6pKTlhnVmZap9XSs233yOT5OkPoEsBD1eurSxQMd
         1jOSTyyXS5r2gQqH6W4cj39d0Zdh2JxoZdx8SDtqM2Cty/OutAsJjyb9nSCGBgPqDlav
         TcwDQ8j2zJ02mH29PRzlcJce2LSnLEFpuD7jK9tXmO+9rJufUuQPi2uH1DISLX6oYWHi
         gVww==
X-Forwarded-Encrypted: i=1; AJvYcCXmDDM53wwhtPd0EnJ2znQTi7RoaIP6ZqBfo3CP7QWGObVi1GUF4FVE08korywE2gAFbcSlyPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLsHnK7s1/7R/k362NfVnNt0c2kSfoQUuH7FNLHTqAiU/Lyf1
	Mfp/5C/G75X1jCUJq5v00QDQ9iEl6Hc6GgFAhvhERViib3krjaFhJW5g3oRznv8=
X-Google-Smtp-Source: AGHT+IHJoT1Kru8t2gTjCW87GFlKfRhV5K1JOlejOdWGN1XWolqFZDApbwBdxFRY5yWNwO7g4PRChA==
X-Received: by 2002:adf:f84b:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-380813c9f8dmr327949f8f.11.1730137229455;
        Mon, 28 Oct 2024 10:40:29 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360c10asm116567725e9.43.2024.10.28.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:29 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:14 +0100
Subject: [PATCH v5 8/9] arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-8-33edc0aba629@baylibre.com>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
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
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz5RsODMjKeDO7+xNd8/K/zh6sOuF8nNxG6+uE2UJE
 w6vDmXh7ChlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmkjiL4X/djwWuh178yZz3
 8avSzEPBl7SzZy/b0Xxo/oX5rNv2eHAlM/zTiZgXyNKl9DBf4bGY4gabxKBnTDWH61TWhOXLt2W
 7b+MAAA==
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


