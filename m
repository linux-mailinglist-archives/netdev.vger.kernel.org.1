Return-Path: <netdev+bounces-97715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B901A8CCD5F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C9282E8E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783113CFB6;
	Thu, 23 May 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfl6VszG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401E13BAC6
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450868; cv=none; b=kyOmSjSo9DSQfbKG2gqpqo7F3bw4prqBlERPA/52RDUy8R/jovr9r6qnLWM69Jxg/vsmNdhg73OgRphIzOYWs2+vqaZJQFN4mKx6uj+NvYeGdu9m+wQMkA/CnLvSWK6ZKKOuGnUYOOfPH64DxxyPj+33gXAS+PkPeiq+4qRQG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450868; c=relaxed/simple;
	bh=IXICyk/2YP4eDexMcGBpEOku8KMw3RDWVpsaEO4xej4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdAQenjDGt5mHlL5ObvvRcn0lfz4Iv6bd6Ad8vJO8iPLs9nNpu8zm8Lj9/RgDm0fs7aoSMEuZlrhNOKoDRo/P97HMqXG7PaYyJ12OQxirGyWuAZl4jcfk9PclspxR1Xw3xo1IVVTiS1fj131dGhxrI0DO2mw9ZDPS9qFim2KAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nfl6VszG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so699453f8f.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450865; x=1717055665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfktdx7avVVxO+VgbPGQcts/32B65YHqwd/3ELI4ILs=;
        b=nfl6VszGSwZVqB6kGkSVxFW4b4wZmTNTR5Phncuf7zqUOkk0rUWADvxYoV/UjnODvj
         iW7AC7sMt64uIApFG11rLRiY1JLJIksqSxtKSRyhkEJNSW3qm+s7QawoRO9HIdO5kPGi
         CJ/5/Rct1Lw4XpREAA3nQ8py/CWEP8e+Y0gwiTaMJ33XQpp684eTpU7wFEt4QjUtpgp+
         Wj/Saabi8dmTd6Y/8e1nVPdJm6+kkkob3FURI5+aGRRmejk0Vef2MC9jbDeViyUKdK1l
         1b6GENCnfl/FR7Z2Gyb70/Qd3vVAqUmBlsybiS6xTcgsovkUD96987bC/iizE1RLXxUX
         snIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450865; x=1717055665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dfktdx7avVVxO+VgbPGQcts/32B65YHqwd/3ELI4ILs=;
        b=cw5An+++XuGdCJMvAHtKYhLbT49JX2eE9S/EegqdJvbMK9H1RRkI3E7jU8OyZVeEHr
         ZigfGSbWzUhx4wG9ZAcQ5qoEh8Pebh3lrTL53WqgcZteMcdiZgqhwwU7fFJSuMlhZbqo
         BZuUuF4+IfFlHjlqzo+D/RXjyPb8+AdLGLddyrJTeXXVdDOqt413blRd3G3F51m1AxpE
         ozPAW6Vx94QrcLLScTADK+2qN9Y371jdP7UJ/57SeBPktHPPi3EwxSlr9Nxku0eu/LmM
         e5wy+0RMZ7aDKNcr3D3PBxfmifvFI69fFrzrKVdkBFjlGefvQv6/Yr+ISdDKjl4oab7R
         nzkw==
X-Forwarded-Encrypted: i=1; AJvYcCV6P4fsKHGZSQCnI1FZdQa3MKaczLSQ8w9C+qEFQp8QTJZxKT0bR9qxKQl5avrO4+p3tgyHNMv3lXiqbXw9H7WePBIQDHJY
X-Gm-Message-State: AOJu0YxLcAw/RWqHTUkHHSoTeN2fJWIdTIUAMcPpGq9LKCai7zpCVkWQ
	DQutsRzKGeTTLquvo+DdBCvBOHhya3U7k5O7OE2ARovUk56g70qPxQ72lo3FrLM=
X-Google-Smtp-Source: AGHT+IF/pK55XVk6BU5rXK9slQYy/4lO8VwqixmRJMIscsNGljlUqfko0F+oxxn3ecB3ekIdd2xgtA==
X-Received: by 2002:a5d:564b:0:b0:354:fd72:8791 with SMTP id ffacd0b85a97d-354fd7288b8mr235826f8f.43.1716450865365;
        Thu, 23 May 2024 00:54:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:24 -0700 (PDT)
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
Subject: [PATCH 2/7] dt-bindings: can: m_can: Add wakeup pinctrl state
Date: Thu, 23 May 2024 09:53:42 +0200
Message-ID: <20240523075347.1282395-3-msp@baylibre.com>
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

Pins associated with m_can can be the source of a wakeup in deep sleep
states. To be able to wakeup these pins have to be configured in a
special way. To support this configuration add the default and wakeup
pinctrl states.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 33f1688ca208..7c6fa7367c37 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,22 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
-- 
2.43.0


