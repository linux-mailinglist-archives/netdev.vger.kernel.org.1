Return-Path: <netdev+bounces-153504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD39F8559
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470121896856
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A2202C4A;
	Thu, 19 Dec 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iXWfhIqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B51FF7D8
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638355; cv=none; b=GKg8IOEEeefWnAjp8fBvJ9a6ZheSn4fOTKurTIrRYv82fhEbXPjbcVGvahHNfRQ7pnEV7fHYexSoyJkj2W/b6ZjeTh2hy9TcMv007jCkW2Vmq8FJg38GOvIenGytorQXkYOPu29LOdBVQNjLXbvSA7ELrkjvXcelVztm3R5YFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638355; c=relaxed/simple;
	bh=gIDyCYJjlCLFkyL9Llh35tLNtJDT+5TvpttgjdY3QDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFNSGGaaqM0BgXYOQ7fG33E7bP5c5GQjRHu9DhQfpG1gpPUy07/x54tQNbuRSK64hZ9vDmKLjxEu6QLDR/bcn14eXj46worY+a6chVF/Hc2jea3506r5xyMEcDZEWZvfiuB1dqAJy6rIBfwYQMEHbV4RXX19YpQbekvXFWEvLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iXWfhIqy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so1915298a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638352; x=1735243152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH6hsp2KM99yT0BDbWTUeIR3jr/s6dYxtO7YCFid8y0=;
        b=iXWfhIqyYW2nuWWXCWCPx7nkpqAPliTEzhpRxUZFWoiWl0asvD8xf78ZQ4pn6PJEt+
         IYJUFch5eYTeukEV/XwUMlcNXB093Q2qLpYjElrPtxKJz0LFsTGuNyoy9/Yp9/KyhMh9
         Drm+aNzEth/aqaU/r5aKF9OhzkWuTk4pxcBvif6SMcTYqF6oL5wcnjdJQ3DL+ZTvn8Ms
         zRr1ioQutsyF68GXPgburpgSxdM0ZTtZdlseOdaiZ3wWH6+E9QMgOP9s4hqE9/dv8Rki
         oinW4l9XAs4en7VMpQj5XHYltd5jzPvlabuIAIdxelrxSmYZJpYNWERkwq4aSeVK1eEE
         yXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638352; x=1735243152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH6hsp2KM99yT0BDbWTUeIR3jr/s6dYxtO7YCFid8y0=;
        b=PGd6AqA5c6DsS1jnMkuYnQGumy1/3i4RKVPPSn3/o3/7UzmzDDWQLH8qc9z8n/AQh6
         H+kVqdkfTtp4B4ivbsZL4nOdzNy9Xrg1MUnhkUsClzvoAG6c0sc4njzUbpOWkTMShWle
         TgSd8WDFUY6m0LZ6NLo+g+RfY8ytbuRXKqkpPWVEXLw9YrL66AbxoCjtKCQMIElLYKhH
         3fV+bAi1nBjoXnspW1Ha3DVkWAryPvmDwLwLYpflXxrf5Y2n8D8mpWn8vambSE8lz1lq
         bE72GYHdogkBvix+w3UJMF67ELhCBpUFmcPhQoDet/1O5iUvt7brDykiacXpeg7+FiEh
         R/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXPDWWGo6waYNdtqRQiEU/3c/DxK/CB/y7e0OKPu1xFi/VLADJpBhjvBZoECJNvP+nak+RvV3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieznKatMYFv/ddnoUvXv7ffaGHA/bDvb97D+zbsfrjmc9J+ar
	b6jFOxaye4Kh0tUUrOAxbTPbwiTVVN2jpCRjqwETR893BwNXgyMbEURZI9Ue8Zg=
X-Gm-Gg: ASbGncuFpjewUzfiNc3OvqNTCZo7gWdRFMeqs/3cUnwkRH5Vl7KQeitUiolajzcvMM/
	rjJC9MBGFmiHrcx2XvtEUoD3yqCFJ9Us4a7hLnfzzT+FM4tFu75GOKDX36uBsfdBGJCg60tTI1T
	0iEGMkhD+s4J7LvjCSqiUcShRmEI6ZaL6tGhotZzvG+XDMfU3mXQv+PaAIOXzO+XKZhb1iuwcOU
	Ph2cLIZjv75oOJGie0T9fLUzszjGZCm1ftXrwfXNS3bUumyKg==
X-Google-Smtp-Source: AGHT+IGtcrLbNDzvZMlctOsefUcwsi1FQVpwzQvY/+MU9MQ42A/89PCMdpAPKvI3wEO2j49f+U5l6w==
X-Received: by 2002:a17:907:1c21:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-aac334e4c53mr4967266b.45.1734638352144;
        Thu, 19 Dec 2024 11:59:12 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f066112sm97044866b.179.2024.12.19.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:11 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:58 +0100
Subject: [PATCH v6 7/7] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-7-1356c7f7cfda@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9F9vMEKbj2mOv4/2m1bk48Pas2jClZzC2oJ41WmTRoc=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqv6vDM53mtt799LchQ9dnrOdWPhRaW/tZw/JJwmz6
 /8e3hfr1FHKwiDGwSArpshy98PCd3Vy1xdErHvkCDOHlQlkCAMXpwBMxKaQkeG5d3Feyttqw1Ub
 Pdg9FfZ56UeKdQcf2PCMl8nyqHjlX2aG/7HSKXuyoy/ytLu+i3tysyw19XrS9rqWiMOaex4Y/Zz
 VxQAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

From: Vibhore Vardhan <vibhore@ti.com>

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree. Based on the patch for AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index b33aff0d65c9def755f8dda9eb9feda7bc74e5c8..cf57f954dd3e31a8747c833bcc583dbc6ba21d03 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -173,6 +173,7 @@ mcu_mcan0: can@4e08000 {
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source = "suspend", "poweroff";
 		status = "disabled";
 	};
 
@@ -188,6 +189,7 @@ mcu_mcan1: can@4e18000 {
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source = "suspend", "poweroff";
 		status = "disabled";
 	};
 

-- 
2.45.2


