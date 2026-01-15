Return-Path: <netdev+bounces-250126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC1D2438A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65ADA3014D19
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697F37B3F8;
	Thu, 15 Jan 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Snj4H2ke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021837997A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477240; cv=none; b=rkaYL8ekkRe9xw7RQ1+Qpt8QzGzXNeWzPjfvuOv8D+mcsz68cX2fz3rX+5cbxkex5ahU7qBHvGuwl473hRsU7sIlnEUviUN3s2KVt6OjmjZwLyNLkNfBlDF+EUivostu+uqBjkM0wIG2TxyjTiGBW4j6MWdoyTSMC6YEf5KbJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477240; c=relaxed/simple;
	bh=PXS05RerQpUx4ctPGdnS/G+foMJ48Qj8aQtOAt7OSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6AxXE+UZbEOAZFtfN+mW8gsGTY9NzqypWp7ql+8DTLNLrojd0PQvBCVQSzVkwY2qkhuoytZdpfJu93XDqCU1ij9g1Qwvh+/ukFthbCMK65dcnoCX3Ojbv4nazUCzTaubXIZxUmLdgCFlGq3rPs2Begp/CPju9oODay6ZI2I6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Snj4H2ke; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233702afd3so943707c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477238; x=1769082038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cROdaZB2e3rP7WqjBdCtWuYMmHKRB0QhTDeH6xpIT5w=;
        b=Snj4H2keuLGA7mBYNWNb7wLGKBThA06Y55uRRk5uCfCkPET0J6R0yz782x4EmHUDZU
         x1phjNTKZcf6VkYqXdpdbDi/+/EQLAOJGxCX86tTBxCZrMwDoHCzeqzvWV3N6+PYPi6U
         +cBfB2rdG5hiuqwBrwWBXXREREf4D7MgQTKd+fcBScJY+i+yhNR41iVUBtxtLu1Yr5Ra
         HjdiID4koXPiVhsLA2rKtBxnOkK7YGzga0dcDPDV5T1lBaJvysqQVkVP8PicGWFOJLkT
         XXaoeEv+/YFh4rmONO8a868tJ4eoQJVMmxgrsBMhru5hn0Mpbcj4SQWAeFdAvuHC/91g
         Y6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477238; x=1769082038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cROdaZB2e3rP7WqjBdCtWuYMmHKRB0QhTDeH6xpIT5w=;
        b=PqwOHUsNGF5BsR79tFYitREgy58uywwfPpAx9J6QgO4ER8pBhX+84RJQ5XfJHF1ijc
         UzTfu4NLLMeBut1xgj9uQPJ1f+Y9rkk8LKvKf/n/K1GJKo/Z+h5xzFykdDEQdm5gzBke
         AhzJn67RmV99U95Br1XJ6e3vXWpbZU+vVVov6q5Y0ZX7A5vRfh7a3zv++8wrfz1JQlEu
         E1vP9JWutkpzvYtPcbNhsYiJHIAMt2LyiwCj9DM+Dmuut3Mt8A0KUqki83UKYgBfFfS8
         jsFwQ8LkiHnSaAuiqaUtiSEeXTxsZ9T7zlDcvGrIEpnx44crZ4qwM9mksV1KvzCYBTwA
         F5yg==
X-Forwarded-Encrypted: i=1; AJvYcCUDrb0Paz/PVP7CvMztl5uJE7PjfEmnTbwGnKYjU9S/BbvGeolQd4zOWLLSXaOZvzX/U8YwhZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBuHBSZLCEwkDCyryNRXrPWakySomFFwHHkneQcvqXwLnKC/U
	9jbEGfaUnud5RyniTKRQ+5X9bR/tugMrk8f6WbKRlHdzgNiyTD0ja2e77RGyqahx4oQ=
X-Gm-Gg: AY/fxX7WecUCVD66QLhJY2N5ig9YRi+3SS1+fcCj/WhihJsUK8+6Y0TriImeMHxlrJi
	U0FfjNOO7c2N9vBLEa1nWGeDC7Dcvx6LoXBba1AUY7eQF8J931pO7nC4IFSMpz4IOQQEx0nyigV
	BSDLyzBD2K4Yk51z2YX/PrDuyWRocrV149tgQYBb4DFInvBeiRMLfrAwvb9ZZm+y5s7hRl3W2V7
	PSDfDfHy8QkZ7QwLVWfLIumQzojBXjIK1zrROCzweHKHhvFqyfNehlLCuZYnSlm1K9h3TC3pXB6
	NQq4PgUpuvfv2laCaDqgihruf3TdTiKL6P6KnKK2i4CfdcW0x6wenZ9MwzruYapQuRMK0rsEJRA
	yr2B3lnpToiUAUGieuEk3OSrLyqwgaf4vPcxta4h8AEP2lEt9Htnpf8z8EUpYXrJgGdJrZpdr0l
	YycGRAqAsp5appJ3nu4CuVid49aZrd0+xEmJhpyCeRjo1st5rfApLkxEZ3VYBvd94zt0ORJq5eJ
	vBWv2Xd
X-Received: by 2002:a05:701b:2305:b0:123:2c7f:28cf with SMTP id a92af1059eb24-12336a23a4amr5794003c88.8.1768477237584;
        Thu, 15 Jan 2026 03:40:37 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:40:36 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 00/11] Add support for Microchip LAN969x
Date: Thu, 15 Jan 2026 12:37:25 +0100
Message-ID: <20260115114021.111324-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Microchip LAN969x switch SoC family.

Series is a bit long since after discussions in previous versions, it was
recommended[1][2] to add SoC specific compatibles for device nodes so it
includes the required bindings updates.

[1] https://lore.kernel.org/all/20251203-splendor-cubbyhole-eda2d6982b46@spud/
[2] https://lore.kernel.org/all/173412c8-c2fb-4c38-8de7-5b1c2eebdbf9@microchip.com/
[3] https://lore.kernel.org/all/20251203-duly-leotard-86b83bd840c6@spud/
[4] https://lore.kernel.org/all/756ead5d-8c9b-480d-8ae5-71667575ab7c@kernel.org/

Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Changes in v5:
* Picked Acked-by and Reviewed-by tags
* Change clock header license to match the DTSI one
* Alphabetize EV23X71A pin nodes
* Remove the requirment for all ethernet-port nodes to have phys property
as when RGMII is used there is no SERDES being used
* Drop phys from RGMII port on EV23X71A
* Drop USB, DMA, MIIM, SPI and I2C bindings as those were already picked

Changes in v4:
* Pick Acked-by from Andi for I2C bindings
* Move clock indexes from dt-bindings into a DTS header as suggested by
Krzysztof[4]

Changes in v3:
* Pick Acked-by from Conor
* Drop HWMON binding as it was picked into hwmon already
* Document EV23X71A into AT91 binding
* Drop SparX-5 and AT91 bindings merge
* Apply remark from Conor on DMA binding regarding merging cases

Changes in v2:
* Change LAN969x wildcards to LAN9691 in patches
* Split SoC DTSI and evaluation board patches
* Add the suggested binding changes required for SoC specific compatibles
* Merge SparX-5 and AT91 bindings as suggested[3]

Robert Marko (11):
  dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
  dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
  dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
  dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
  dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
  dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
  arm64: dts: microchip: add LAN969x clock header file
  arm64: dts: microchip: add LAN969x support
  dt-bindings: arm: AT91: document EV23X71A board
  dt-bindings: net: sparx5: do not require phys when RGMII is used
  arm64: dts: microchip: add EV23X71A board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 .../crypto/atmel,at91sam9g46-aes.yaml         |   1 +
 .../crypto/atmel,at91sam9g46-sha.yaml         |   1 +
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |   1 +
 .../bindings/net/microchip,sparx5-switch.yaml |  15 +-
 .../pinctrl/microchip,sparx5-sgpio.yaml       |  20 +-
 .../bindings/rng/atmel,at91-trng.yaml         |   1 +
 .../bindings/serial/atmel,at91-usart.yaml     |   1 +
 arch/arm64/boot/dts/microchip/Makefile        |   1 +
 arch/arm64/boot/dts/microchip/clk-lan9691.h   |  24 +
 arch/arm64/boot/dts/microchip/lan9691.dtsi    | 488 +++++++++++
 .../boot/dts/microchip/lan9696-ev23x71a.dts   | 756 ++++++++++++++++++
 12 files changed, 1309 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h
 create mode 100644 arch/arm64/boot/dts/microchip/lan9691.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts

-- 
2.52.0


