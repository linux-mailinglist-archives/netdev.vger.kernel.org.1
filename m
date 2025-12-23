Return-Path: <netdev+bounces-245900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DB3CDAA1F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3800303D6CA
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87134CFD7;
	Tue, 23 Dec 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WPMJMxT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B934D939
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521227; cv=none; b=frvSojhKwoAG/iy03TIE4wI5832yNrVPqkPwriVWqGz52ODpsmTDeArLnjZqgFEfgoDkca5Ypo0Nzy5qHYJta4BRtm/4N0SFWzFdUXHrcnwYzkoPxFPiBxo8Nlnlcwvc62h4cPxyeJ2vf+3DZjlzZSOxjO5f16CRYTuLr50U84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521227; c=relaxed/simple;
	bh=HaP35Mv3tJhzA+ZM5JG9j+YNJFp/ZeK++35o7px2hP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMqjaE7Mn1ZNGg2blB/sKbV/XLWH/SIX/v72YR0aldfYz+9vIFysL3KHk2T3lUWpnbHvcvD012sYSGuXOySROEwBmhdE2NEeDbXHa8UBo4ibHCUE2y05FiWcdzuMVXfYYgiGwz/2bTc1XguOUqfRkcN1Y6QnBq5wOowydAdCJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WPMJMxT2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso6122707b3a.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521224; x=1767126024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=WPMJMxT2Z86tRUSGNKn0CYAH7lwYVAgIaWB3yVBHo64gd/T2s91doAUDCV8wqm3d1k
         DqXXsn9br1YlTxfvMupgH3TmIT1S0x0xNftveqUk5jLtfQ1ixzf9b3ZSBozDvQE2pyQj
         hhOrWomNhyMz/EC5b18RIvwIaScGg1TC0qvDuhlBcWJ6GfC1lTqE2K73G9hASX2Oxm6M
         /UgVfZTNLJNSpUC4EIkLNjKwAmUHnH4XO05eDMmPyIj+hi6/jvMdE4U0XPk1o+gmoLW5
         VBVI94hQaZ0XoDa6zJ3zoBMsb5xR+5HTpnU/B/bPo4koRUuMa3SXd6NekJ9GtM3jn5gy
         M6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521224; x=1767126024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=TaUgIE9Or8i+GGaqunaZfeI5u760jmPpAj5cs8MgPeIopU9tilGcwf9IyS1hgTJ4Ga
         R0amS8VO+GgDndiBRIrvQqGDJmRf0ems3NQP7Nav1qBIEJNyyvxGD9wlRe+X3VLZAPyH
         oWFOk+vqEa0j+RWm9es9q+XG5Imsnf9uEdjSXorU90MdcmuWNn3touUQ/hWOSY+dRZF1
         A4Xc70O+AT+e/10ZwyuBlIYd5T8SecbfFVOZp4tbARqve6dsCsAzYRHvJCPvSE9qbgrR
         QZc+l0Xv+sthjGNy6JzuOwYfORu8gfbus8rhDVRyyFIUWdyO5z7R6OuGMG5s3x7hxEUG
         jvZg==
X-Forwarded-Encrypted: i=1; AJvYcCUnl+QuIIDzj6tY1AUiKUvA9HmTvV4JYV30RLHuTQ/1nKVHtFIvaODjh152tJnQhYjPa4AJ4WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuFdSKO/GB4oVF39dchVcwOSiscrU35LVx9GHow8QqCeO1+FR
	SbCzTtEEnhHPnPrnWvAnJDKTFY5ic6BGWuOAbnZnN8fKfi6U9ISPYL7mMxelmXQOnb0=
X-Gm-Gg: AY/fxX50pnyF47INs6Af0+TOOukf348ajv4GB/+XrjLu5IPZs5Ws9SqpOcp6i4JrH1a
	4ntb2GWB8q9wYbsGxInfpQRk/mZM6Qu+MNrjLr4Ifbtft/gIz5Is2oea7NXFDLB7HD0iyH1uYZm
	6Uj0z3cMkEYuWwOdhIZFXEqmkfsJlN+gmrC24hg/6k52k/e/x512msquOczl/LVfAGLXQkwtchv
	LNFhGmNH9iBAsa8fozlVVPPKfURZHdYi8uVcVIS2cEpQVux93HBAcgXQDQ5K72UkJyQyQMy4UXe
	PtOaDyAf23qN01tpcrg7anfoirKRl5u9x/6UsbrezeTEGICXFHS7NYJUsenWuE7cljnb5h6FMb6
	iYN52rNgr2RI7os8PxruTmUmGhfIxLxkUsgHtgKUye7yJgEy7pMZtHcol7cMIjyxOfWX36HT6mi
	DzAEO8i7fLvVMeZqF/s1xLvTlVjIJVTGVjLIt9eWeQTUMrX5/s66/o0SCStuMwpp50LwBQBNYgN
	Sg0QrR9
X-Google-Smtp-Source: AGHT+IHEkRqkF3+ulFb7YQxPiXmGF+AIEzrSLTHIV/1Chrc5EC4Qv4EqGmxiVXP6kKzXYBSaNsC5Ow==
X-Received: by 2002:a05:6a20:3ca2:b0:344:a607:5548 with SMTP id adf61e73a8af0-376aa8f3946mr15876623637.58.1766521223699;
        Tue, 23 Dec 2025 12:20:23 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:23 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 05/15] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Tue, 23 Dec 2025 21:16:16 +0100
Message-ID: <20251223201921.1332786-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 11885d0cc209..a8539b68a2f3 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -19,6 +19,7 @@ properties:
       - const: atmel,at91rm9200-spi
       - items:
           - enum:
+              - microchip,lan9691-spi
               - microchip,sam9x60-spi
               - microchip,sam9x7-spi
               - microchip,sama7d65-spi
-- 
2.52.0


