Return-Path: <netdev+bounces-250131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AFED2442B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0F9F302ADBE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35837E316;
	Thu, 15 Jan 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="CtS//emF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83B37F75E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477287; cv=none; b=KVN3LmjvciLitPTZ/NHA8i7N5nxseMJF6sOuKRvIC06a8WT6ubloWyOKYyty2pjPG3s1G5IWWf5p+6MG8hCCmQsDlcXTOTEV7TKniTQIpYFWhfe56mFRf7B9i21ayp6WL8cdHhUuIyOqj4rrT+30SYmZvU4GDW3Kr+D8ERel3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477287; c=relaxed/simple;
	bh=oZkxyNVxYkEwJ2vPpe6uc3+Y+pRPWdMC9g09igJuSnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO9D9rNzbJLZ9CsuXA87OWqdHcqryehjCWxT3dqwRci26L5tihGjGq5BnwDozdxrQG1chvmw4yHjm/LgCuoI9E+eaR0taOmJlNWp9VMVe1B3TRapudY1et8cDN1pcJqeuDEooVGDppBEdnW2SZlGCRlBuPz3uykBg7JFCR4zS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=CtS//emF; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233b953bebso1972037c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477278; x=1769082078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMliUwDqBaPP5ftrxzLcCvtEBpKI0UiOIsqsdzxW70g=;
        b=CtS//emF+yK1ZnuPnD/oY+JHTsYeSeCJRHslgL13DIGHhrYLJR2WCsrABgc0FDz8tN
         B2v3/aJaX0rqioEPj7o6UvPnblVbJ5BPUMXs2FXhaRbIxfK0vsBzIbFeVHwdxxFaji4E
         8mHJHdwEiS4v814l7OR4XJBze1m8pxWiBGpMmTX0hbE5Ny43XDLAq0XZ01eYty2yYqYg
         SionVUSa0Q6EdmpcsoBEeUJTyDPEqbksBJ6YtE3S4YwwYt7lrHjinWVWjcSd5Dvm+0KH
         MeOibqCGEgq2WYCsaOOHC/5sPhmbpR56RhjmRHy6KRPCGEJnYoaNT8ETSEgIZnm5Y8Qr
         HoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477278; x=1769082078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMliUwDqBaPP5ftrxzLcCvtEBpKI0UiOIsqsdzxW70g=;
        b=cgBanxsWxMu9vbFbu2nS15+G+GX7uTs6y4SGM5mPFgRfhfUdbh8E/Aj8QzoaU03Jxy
         3f1xf/iiPUXJ4dOKdCMLNcIWoVp+/ztNnSDNQItVbEpW8S8iwRgJMnNuoj+/QBT0eghE
         Wv2sOrE+HvsjptD0mHvV15VJOHzS35QN3fxFjrJySairhSsxRc9BkRZXF3iuUZhWgcP7
         0CE92vPdEq6iFWWvM9WtWb5U1IG0T0UfCGQrPZ1JqXn2Jp3kRtdcYDx4EvmgzJM3u2/I
         q27ISxvX8pnIozVvkkS7LAsCkpHIwD0eCwqYEmvoOSqQJ4+PCQ0GxQjTvY0Nky1P0XdB
         JR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpz79z/nM8f423/3vq4awBgv+KzrgtuOIHaIND4jsmVjX5CWWm95TlTQUnu6Xw4cAGGlFJJPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjK0fw6RyBSccz5Dl7yKlr0r3gvEt/drVsrjxQx/X875/Aw8u
	EwjaCFdRG6h1x5CYF/Ngc5gZ23sA/5i0yCUwFXbn/9pqEe3tj8KcqKljibbFJjLA7vU=
X-Gm-Gg: AY/fxX5l4yEsTiD6iCVZxjXGvArppwPiDCMfe+hykcoRLCIwfTRM1tKZdWbiSATQ5hP
	lVfcey0Paar3PYGhyb9UcccXZ78kVBVjCo64ecFY6CybGfAy76158ecapSB8MCu5Gah4IVbNK/L
	TA8Y02Kw0UHZq4UhKcHI4nMsX6cd3103S7A14+PtcDiHss7KSsbt2nzQKpiYWHs9fqbB8LoSlPn
	LUMY72+RQ7U7DDWoVGL2bYTWLsXfjX24lco8ffLUSWlxknPrFMwjrmHjkLs8GqQkoNP7LJq9Nhh
	tNgv/EFcvg1favzT/iKdifFtL0QBaTCHXt7TW0yGhdwm0FCnK+mFJrP7wFfpeui2H73RSjU/ONF
	wTR5wmBFamPq5BcgMaAU+9qjqVAckHSbjjRwcCWe1zXzDZmh+5IpLP627OiPiYHokzbsFJyUl9d
	GYWaXGGtubD+wJgtKK59IzsdrlfqBlXs59CRlTUZJRzwCsS/hSbFY1K2iaXZS0rRv0XQFrYy7Us
	j90bKce
X-Received: by 2002:a05:7022:c90:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-12336aa83bcmr5197544c88.48.1768477278199;
        Thu, 15 Jan 2026 03:41:18 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:17 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 05/11] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Thu, 15 Jan 2026 12:37:30 +0100
Message-ID: <20260115114021.111324-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0


