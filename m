Return-Path: <netdev+bounces-113533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08493EEB4
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EA4282700
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D312D745;
	Mon, 29 Jul 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qw83JVyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9412C473
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238922; cv=none; b=b0Iu6jpzyZ4uPJIEzMC1TAqiDO6q4Qx4HYFhe9mjNtdASr0Ayauu3qCtmycZG7wNz9l2UGxD6N1m3vXi+2qOibsRS1dBDNuh8Gcm6dEV4BsqnEjBJBMbIIsrFTfn24f7227OrkcIwbOKHAiIIKJyg0Ly6V9Q2kn1vTWOm8FnVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238922; c=relaxed/simple;
	bh=kKmavRoafL7LbrI6wgzkO9etrOXpNKqKGJnQcNGpZL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJuYUoIBqFemvvFswaUsEeGSqgJXy/0B9zSJDb/vNNzRLNaK03gZRwKzXZ3Abh01PO/Po9zQIf6RyRhN097GUFZO7D/OLDQ+eFTGt3QthwwSWbXzpRN/OUj0/TgF7jTrK6rdklp73Slb6EKmc2XGUqiv1qOUtEC+Kk5WNZSFHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qw83JVyZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36865a516f1so1620833f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238918; x=1722843718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxOPhXgBGVgm459I7orAWDkAOXF8W6mRG3330dy+9Vs=;
        b=qw83JVyZ4r5Wrvz20b/MTpAujpD++eQho27lI7MZhEKvpe2Ol58hSSXsIT8ykfcH1K
         lpDXK30HD0uf8112z5YL85lcth9MiQ17/ydKhFIRMD7va/Nn5xOTLWymTS8IJut6Xwt2
         T5yzRM/QNPgITwxCvg4lpf2LkVaRXmBRG5dUqdvUuJYJxw0Spn38gPgZxpLCSY0QocM9
         Z8QF1svr++GmDNuFB7AMROusSd/aDLea1vgaIWc23F6nrh8h3QAjCdKDYtFCoSElyxcx
         4zZEtp04DbSCzMhPVPe2S++bsy4aE+JqxCxsIj3R9CzWriTfG68R965jeOGAsTFyMneh
         mcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238918; x=1722843718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxOPhXgBGVgm459I7orAWDkAOXF8W6mRG3330dy+9Vs=;
        b=Ghn8kBu/XUFRCLDOySFRAA3qxXJd5F5A67vmSoth8uSop6Q3ETSGXsbnoi9HA+wKOj
         2pkCyhpKzegCnFP321MW+BKV8TD9oIfedeg6IVBSkHqVU7bp8tBpspiwP7B/099YJLvm
         9D+WEyBhMMFXB2ipQ8U+A0n7ER6S8NLeah+XRQQ+IkuuZ5/t0R+3D5zIYSFyHZx/PzaM
         DZ/Cq+be9U6f4k1b89ENOzaUt39aKaBGVTo6sIOu75Yq152AY2hikWC1U2ENnOQYF1X1
         Qzu857rvOTqa51gbLYAMizQiQqD9xzW+HcP7Yp2WneXkdOmFMlwPl8GqCu9dCjJugyJQ
         7d5g==
X-Forwarded-Encrypted: i=1; AJvYcCUSyosD4ZbkQQsqyWX/g66Ou9E9sB7+aLHYfQmwfApWwxADnfXmWo8OgkFilzhFmbzOtc45gxwW+Pe8+sVOc6YMCweFkijF
X-Gm-Message-State: AOJu0YzJRBFuCF7inT/Rw+BzmZCjv+KYvDswsrnGMMonTE8+lK9jFxIq
	qfOu+xjd0AGoD/d7N8/98ULX79lUCVC49au7meRmHuZZvxKLqzDnrVG+izeETPw=
X-Google-Smtp-Source: AGHT+IEH1BmXykzYxHbBlIGQ39KCxXnJRNw6NqAwJ/SmSfzCEFJPCKmY2ZLDYfIMDV8hQvo+5IUQUw==
X-Received: by 2002:a5d:4210:0:b0:368:3b5c:7a5d with SMTP id ffacd0b85a97d-36b5d048bf8mr5655964f8f.20.1722238918458;
        Mon, 29 Jul 2024 00:41:58 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:41:58 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/7] dt-bindings: can: m_can: Add wakeup properties
Date: Mon, 29 Jul 2024 09:41:29 +0200
Message-ID: <20240729074135.3850634-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729074135.3850634-1-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
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

The wakeup-source property defines on which devices m_can can be used
for wakeup.

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC. This configuration is described in the wakeup
pinctrl state while the default state describes the default
configuration.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../bindings/net/can/bosch,m_can.yaml         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe..ef63f6b8455d 100644
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
@@ -122,6 +138,10 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: This device is capable to wakeup the SoC.
+
 required:
   - compatible
   - reg
-- 
2.45.2


