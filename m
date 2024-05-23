Return-Path: <netdev+bounces-97714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D78CCD5E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAFB1C21A5F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EED13CFA9;
	Thu, 23 May 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mrZu8ncX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEA13CAA2
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450868; cv=none; b=K7Ct2yWit1QTsSaeCj+eGFW+5jM/CapVKYoiqbpzYGNtRkinTs34jlFjetWKv3w/Ot1jbQUs5zvNVjVTZbLUNUm7qdWGD7CowJv2RcJUIRypmWzZ6cWQcEVpVIsOMBo5lzhPq7kqViR6AC7nyNj9+lptZ9gXlbFP1G54JH9Occg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450868; c=relaxed/simple;
	bh=kJoDq+1PGhj178GDLSihIlH/mdh71gAOr67LZsxDh7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbgLpr20uMDS9s+LQFeP6XyU50YRfl87z0kBXvmcOx8SoySsH630JhBXjYTIrn2iSr+SS+Ks0YgZc8YCPWV4luML+NxJtQtqZ1lRY094rq/KINjTBy/8ZaT1zqapzl4ngaYUcw6NpU93tfzZJAdCiOx/Vkr1nDH/q582OppYFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mrZu8ncX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so699426f8f.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450864; x=1717055664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFKoRI+8ogEC3xai0mED7XOpWxyQTS94NP18L7SjeH4=;
        b=mrZu8ncXZLIrEKHKsaYPk3Fw7xH9BJGqpvBc36rTv7vy/ZA8iVXSmkNiPLrdQCwDv+
         kUGVQ4lOj6FUtFEzlDy1jFFtC6Uf+WgZDFXYCvmvksGt6Oxp6Lmsyo/7KqU3KTv8Bp5A
         +n+62gOS9L/D6F+F+ocGYeEwlCSN0+9v30+jbTJuI38hiSAYtRnBjnchgvA0wbANgq1t
         4sPltO1VCowNbwJYw/qdyzEsDdZ1ku0JYQCq7clKDtC+tuipJ88KqnMO9/DKGIllHwJC
         jrGNUeam4hvCIMEriDOsSZUGHfoZ1FlkdS2dxKlcU4GKoEUMLRIT7XBokDDnZ+mEcWI1
         1GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450864; x=1717055664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFKoRI+8ogEC3xai0mED7XOpWxyQTS94NP18L7SjeH4=;
        b=QBxLm9/Jwo600opvf5uAmzNGI+eLmmFY7b19rW7qSHq7HC6eLsLZXMpSjqJNOESBFR
         IXtSr58ATwRbw/O8rKCz5OJlieULDLCURDoOEH0rJ906K9qrrSLBaIbQytwGiH2CGoSk
         y5lXQcuOrXymdOXn/13sNzEmGiqo0LydmTDQtEcbbeJMF6g6mydQVr0ABf8Da8mMSGme
         gYYBgPp4DTWFkXksjVNxLUlcBzDl8fGJXZaVaJ5W5JMrWmVtahsxca3rg10PINiH5hmW
         gE6TaK9hC5ffLdekyBejEZXV2KqfzKXljTefrGVDXbLh+OkMia0Fofy2GXLyH34qDLRt
         aHBA==
X-Forwarded-Encrypted: i=1; AJvYcCXjTTGcVtp2bPxyM/arf1qaXmsVzK/VY4gFteyDz5cU3cfwqldiy9oxJZ27Wp08PBFJO9y63S8W9QozuRJlWP9qja6VcyRk
X-Gm-Message-State: AOJu0YyiRhw1yW7E9dAj/mH9qktWPzge4Jju4NzJhkntnmZ8wXUHVCJ+
	ZcqbtqZVTLnRYPjetrufULHVbHkR49W53Itv1j20KWQf9mOMeP1BU+Sx6YUzAwU=
X-Google-Smtp-Source: AGHT+IGDzErplwCICU1ko5jWwuhNNvWBqpXdU1AVQfAdkYAqsILeEMKquVqY/w/WRkxQ5BGXYhUTkQ==
X-Received: by 2002:a05:6000:795:b0:354:db63:9de5 with SMTP id ffacd0b85a97d-354db639e56mr4759952f8f.39.1716450864009;
        Thu, 23 May 2024 00:54:24 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:23 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 1/7] dt-bindings: can: m_can: Add wakeup-source property
Date: Thu, 23 May 2024 09:53:41 +0200
Message-ID: <20240523075347.1282395-2-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075347.1282395-1-msp@baylibre.com>
References: <20240523075347.1282395-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_can can be a wakeup source on some devices. Especially on some of the
am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
the SoC.

This property defines on which devices m_can can be used for wakeup.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index f9ffb963d6b1..33f1688ca208 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -118,6 +118,10 @@ properties:
   phys:
     maxItems: 1
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: This device is capable to wakeup the SoC.
+
 required:
   - compatible
   - reg
-- 
2.43.0


