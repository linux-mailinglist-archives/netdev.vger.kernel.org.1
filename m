Return-Path: <netdev+bounces-232961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68DC0A602
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 11:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D95E1895233
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C359199E94;
	Sun, 26 Oct 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nn/AIRt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25D6FC3
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473870; cv=none; b=NJU/JOISEHFOiMLm/H9usLeo1agGmAp43pUXXMb908ornXbbawpy6GaG4ebwDCda5ufAMvUP+cmBNYD8iF4x2yXMRQT8a9svdGFkSqQRhVzFEFa1WnX/dtgD8FpxIjTYW+UIvBlaEOyuzlVOaPDPi8yZuAi1oz/edANfcaleHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473870; c=relaxed/simple;
	bh=4eLCy6jFlv6ArS0sNZED+k9sPfJdSXkKtHIG4LleXkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfLIXaQgmqvQVw6l23W5HnO47V/E9dg9lJr8NDUc+bRukHlB16ZIMiVcPcJ3vXBiDuEy9XjBYrqG6emV/MflzX3zA90s79/d9KqiRQx1FwHKoGpwRy9dlaEpI8dWh0C8ZlwHDRSxqvnyEZG2vsXko8uhJ+rbUTt75jZLkp1og4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nn/AIRt/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270900c887so496732f8f.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761473867; x=1762078667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZq/s0DjJJahu5RTJBwLJxq2XEK/C2uaMOs7qh3NCts=;
        b=nn/AIRt/HzybdUwLneYA3E0SbMyk3OQ2GdNs7s7OdHrp3gjg/wahGNS0nRNqdFyn4k
         7qZ5JJDVO8PskDV2YMYe9PNmw01dZrgY3l0fSDxodWtxDatYLKk7mUlmEzzv89uiYrhR
         JxZ4maY41/mYwsIZ3mfbHoyicBOldP2RmB7IA2YWF8IWZDHvwO4+SDLEiF0oYpMK1KAE
         9GvzhKVsXuqAW0QkX720CYPBaQPK051MtaE5E4CNvI65tEJpOnNLHyHY4kBitLb9t+uL
         K/TjRW8rA+usIqNiLj8hvUiYcJYg8E2aGmzrLPtuHpBR0Zeya7PbOgQ3ctAmtXmLB2tR
         0/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473867; x=1762078667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZq/s0DjJJahu5RTJBwLJxq2XEK/C2uaMOs7qh3NCts=;
        b=V/SKjQJmORGcUsbmKyVJ19YBCyzo8ns+m4O2+dsh2eaT+2GrRiYlDfTePvjBtkulaK
         iWN5sswExyZdDBRVGvaDOo+2hL/N1VcLc9jfR3u8JoWP73NNVaZu/WHtwKOY5dCqW2Jw
         5/zRZSG6vcAXvQiZYfYp/0/kEdH5vFQhhu9yjV1Cfy2loi/CtRjLhHLzMZavAkwC2hu5
         2UmkXLB+60wxA3qpdWQL4Co+0ZW+aUdPPA0FOuCX+K+mcGDUNjI30Cb5UzwsUXBWnyUO
         SzIWAGWGtmI9PMElDzcWxoXHBDgJvwoUYN4mwxQPh2PqHQBFyEV/V9vt8UNF/VdW002K
         rfiA==
X-Forwarded-Encrypted: i=1; AJvYcCU/eX6nk3vmvKk/OLJ9PynhP9nf4/WSkkUMEIkGYq7bPr6KaltPLkmtmiwn7BDQuzgJ3s1gM5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bYUBYMeuPfGCDQwOp4ElfW7a5oTsozYO4w9vOCZaK6BD+iMQ
	3g+WsG0LMPp30PvMlkFdwHqiEyxcRGVZf9I5U1xNTFm3vSSVbhx79VSsSzqAhtElZrU=
X-Gm-Gg: ASbGncsbWMUJ7sN6cFbLPrRrVpMTRfoO0oOgU6o3JtrKSSwCQ4uZn+WHKEfkr0PqZ9d
	Tt5m5GSUJusJBxCQdFdHTabwMucbv5E9gCEH1is4k1x93dPwbsMOSFPszgW3fhNilp2TShU86uP
	H0uNXy/n2hK/ZCUvGj3F5xXZ5KZJoMwuT5p/88uCDAWVzq761WnQXAj4lwR1nJRLDSv05DZPDDk
	hs0rnL8bjSG3a01JdL+z90g5YjgBOP8O3QyGkhkFW8UefUvzyRjDD8HLWp8TzNbgwJ8jp/I5QNT
	r5jwLOGZdngnnzTMt6h2iemOB5ZM2j+i5Np7Yfngxsf1PIesieoPLK/W6C4Aq7dPpng1LYfn+yT
	K3qSe/Ww99DErGoirdyPQsPJQziL9Z8Ys118eaOKjTbzk6XKRGrFLotHkePL0T/LdLBI1Knr4SP
	6cMQl8clZZNYU=
X-Google-Smtp-Source: AGHT+IFLV+eNu2OSqeI3IjKQUumE2rjQrLB05yL6GBy5AvpUTXb5dLnZv8q1GKaxjIshEGpVcuT/KQ==
X-Received: by 2002:a05:6000:220b:b0:429:8d46:fc5e with SMTP id ffacd0b85a97d-4298d46fdffmr4538761f8f.4.1761473866761;
        Sun, 26 Oct 2025 03:17:46 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9d1sm7966166f8f.35.2025.10.26.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:17:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net v2] dt-bindings: net: sparx5: Narrow properly LAN969x register space windows
Date: Sun, 26 Oct 2025 11:17:42 +0100
Message-ID: <20251026101741.20507-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
space windows") said that LAN969x has exactly two address spaces ("reg"
property) but implemented it as 2 or more.  Narrow the constraint to
properly express that only two items are allowed, which also matches
Linux driver.

Fixes: 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register space windows")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

No in-kernel DTS using it.

Changes in v2:
1. Fix typo in commit msg.
---
 .../devicetree/bindings/net/microchip,sparx5-switch.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5caa3779660d..5491d0775ede 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -180,9 +180,9 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 2
+          maxItems: 2
         reg-names:
-          minItems: 2
+          maxItems: 2
     else:
       properties:
         reg:
-- 
2.48.1


