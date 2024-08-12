Return-Path: <netdev+bounces-117613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E494E8E4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999D31C217BF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E83C16CD39;
	Mon, 12 Aug 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqFiQLgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232A14C5AA;
	Mon, 12 Aug 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452662; cv=none; b=da1COSA1wUNWiR1b7x6zJeSmhEfx4vdlW2tJnu0l/eiqMoo33O61rDWwWtZfmxzaTPgLoqTPHFYPLe/yJfY5hD8/2bYAiTMu+Qkvr9GMTqQsU7ckS+MEvIbA6/UDWvy6fq2kx334Y5k9TI7gqqnzeZnvOju9OfumO55Z5KCa9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452662; c=relaxed/simple;
	bh=MNnLV25K6YhULXYYlXhNI0BKUG+LUYqABdwm34GgDDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7QgFAk1rql0Bb89khRB2gne0dx/npuJ2s5AluMcqOCMwNuwOHUjp/hF8Un+7TxYXpCBVqQVqWjhpz0OIqw5Ao4NwND2aoP1ScLVdvb2PCI3jYvoQOlpSEAXxpbtQO+v1Kj/r4O0wBJol5pc33PpfUXMBYRPOqQAhE7NRmthbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqFiQLgO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so4689013a12.3;
        Mon, 12 Aug 2024 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452659; x=1724057459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=YqFiQLgOla/ZOeWkRIfZaxnI5Zz91yhVPWFu/DFK6NetJQbs1i813NeS00hiPb7K8d
         6TEgTbJOkdOL69OnJ8JD9nz+QpInqTSNoqYYOc/Vg4jfNpqsDsL2EAMVJ1+Pbqd022JL
         Ma5gwAaUozdz0dc7pf4Pw8YxbXu913lUMKEPOmCgtXm+G3mgEx0XG/JbLh5+RDVGQNW+
         IbwmM8jBgqO5KKjQURwTdzKvGwRuJkiVqzsw+fozaPPNNgGivag9MhqULRyCBzCZs+Zz
         p44Gn1Ki+fcvhiqt88nTdTThhYiPhSDYv0SPSQAzcO415V1qFLbArVonDmM1G9msZ9Xu
         W3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452659; x=1724057459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=EtPdhyGz0VIXK0l9iWAvALTuDPMIKSsAiFg9t9zqIzoBg36j5Ibnp1Ek3UhlV/Wbao
         FiDUA+0x1IBFm4m4XTUEBn1ulprLpezVnaIvCfFcRAx6GLuYobpsR/QThIo8wDLp6zLa
         J/YaMpZ2F8FxMkanWVR/EbC5FH+JLVNxuLCnPvI8+4YUE8e3RvZd3wUVSn+DcHfl/0fi
         suaD6lwMzkX9eG+4YN+eERfXxwgz8oIp8aOWqsdjZC7HbA0eaVlH3xszuZhqj1uwLsIr
         3a1/m0o+1tyv3dRWAMD4xFnU6UOYQUJIiMC4LCXW68Xr6N0LPRuUrFa+EwJkOi0k6Lf/
         jL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGTddkcsn5CVexk4CXSHrhMLChGC1eYVwmrGwatdTH2GPA2/bxF0IfurKc/uMBoffSwVYj4eXb2pVLF5c1V3fv4u0Y9GpJl5Q/LQKavME3Z4/QWuYix98jiIPmetmb7FERxYEMruDZQMgiM0btw4rvyAWWsyEbvRpU8ldmFbU9zg==
X-Gm-Message-State: AOJu0YwNgsQgr0rLAcEN2X7PFl3wHbn5qOU3PA6u9C5ToZlF75odKjwZ
	imHGc6wdIYQ9+YcOrbRWnGgl8W9Bder19aLl+H4puy6WGN/5Dco6
X-Google-Smtp-Source: AGHT+IHLCVOMzv0vEY/GpKmVn04Peavjh3TrqrMdmstDm6b5xf6DXYMu/Lh318dEPLgfAAsXTntZ4A==
X-Received: by 2002:a05:6402:1d52:b0:5a2:c1b1:4cc with SMTP id 4fb4d7f45d1cf-5bd0a617c06mr6709406a12.26.1723452658153;
        Mon, 12 Aug 2024 01:50:58 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f517dsm2094761a12.4.2024.08.12.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:50:57 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v4 1/5] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
Date: Mon, 12 Aug 2024 10:49:32 +0200
Message-ID: <20240812084945.578993-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812084945.578993-1-vtpieter@gmail.com>
References: <20240812084945.578993-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add microchip,pme-active-high property to set the PME (Power
Management Event) pin polarity for Wake on Lan interrupts.

Note that the polarity is active-low by default.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..c589ebc2c7be 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -51,6 +51,11 @@ properties:
       Set if the output SYNCLKO clock should be disabled. Do not mix with
       microchip,synclko-125.
 
+  microchip,pme-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if the PME pin polarity is active-high.
+
   microchip,io-drive-strength-microamp:
     description:
       IO Pad Drive Strength
-- 
2.43.0


