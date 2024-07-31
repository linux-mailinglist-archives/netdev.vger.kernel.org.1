Return-Path: <netdev+bounces-114502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4107942C05
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1581F2630D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93A1AC44C;
	Wed, 31 Jul 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYfjLDQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0391A8C02;
	Wed, 31 Jul 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422064; cv=none; b=M1ob4B5YnsBT95ZiBw7GqXK70NbdaV1pOnzq9RoEs6Y4i/g2BzLmII2E+oFr1m+IgOoQQ6ZI6H+WiLhk19jigpgE2hxSQPItYdR/fTTALrrjxxszdfXxI1/3JOZOGQ5RTLfgVPc1/l0zBDilC9Korv3uzPk2p0yT5SuurFdNgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422064; c=relaxed/simple;
	bh=MNnLV25K6YhULXYYlXhNI0BKUG+LUYqABdwm34GgDDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYhU5ebSFNc/TJ98UxXljC7RfMyL3EqOqAmMqbAJQwjnUDzmTzy+bCwISxKjncQMOBWI2CrKLc4CuBkgKR8t2NaUINvgEVRF2XE35Z8m2YQHRAedUhtyWkc+FDCNocS8N3QyxV3CTyca+TXnpSZ/HGThHWSHLDJW/oEw8BTI4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYfjLDQ7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9e25008aso735473466b.0;
        Wed, 31 Jul 2024 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422061; x=1723026861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=jYfjLDQ7qKOAEw4ElEf+oOMHNTqC4MfWkaCcNhsNXxEVk0qcNRy69TnA+A5fCt4gdO
         eNrtwZ9A/2XEbi7hwkRwpGV6w6i+5A+ZzP8eQpYM5TqkrNsu/ZORJpuu1mr/9WavfiGN
         XUXZGryjTxQcG/zqt8YFoAxlpaQYBgnLFxipN+Cq2aw+WCWriVxywo8GeYDu+YgWFFmr
         ejKoWM2cWDM8pY0uW3PTnHQQirBOjuHLCzy+K4xx3QbA9gL1rivaKZXSEZTzQZ97yv+3
         oDLCb32i38Xtion9gGiiEWKrc/ljbtzuSyz2RoOzh4URT1W0oX0p7uQ6TNYXFOByFN0q
         nWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422061; x=1723026861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=jkkhrTXl6k6GrweKd2CdHRyUK7K2rImh7xh6N5SvtF5YBORgp+hCjFZnooheeiaamh
         c3Xx1MX8svNCq3RYVDfC0m0w7KeNuVFmRrW1SgRLLPwbFEd/K7BnglMOW0ann1fzmrfM
         eTB0hi+KS6C8vZDMfmA0CkMnh7qXH/Z9ERnnpnH9YgnsMQwUE6P3O4GnKpUy6uZKNMiy
         /8RxPg6g6TtpG8uCJeZ92iKMQoDLJMIY+PlIkoEz5mHPeOkWhJxNJbr+Hd/a0d9MRLlH
         fSUElZYqSCpsmqQTVj5udpD9tShx8CmBpaoYb68RaLOXJBwnEuE2rR6gj3FHegQ28xmN
         cycQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbgB5PFxqN38dp8+zaXDclL3WyD7EkrhbmPmRZCGjLxk+i0dLHXQKqI5f1U7po6JDZg8fCA6h0pEraLrk78xMAtPt6ENzk
X-Gm-Message-State: AOJu0YxzaTPCshmvL77PLOlqtXpMG09DRd6un6fAn3lM2DI8l/1dqBSQ
	edACwJdbXS/qVvPTkqeBem3NOsUWGOhTjB7VqcIcGRlQ332KvAYW1zrbEr1kN50=
X-Google-Smtp-Source: AGHT+IEtZ6tfEm94p6eOzRNSJdNYUZJex2SG/sBK5ogFhgi92f77rWYUDdkelf/mNPiEkDTIfZkjLQ==
X-Received: by 2002:a17:906:dc95:b0:a7a:ae85:f245 with SMTP id a640c23a62f3a-a7d400e1eddmr989629366b.38.1722422060867;
        Wed, 31 Jul 2024 03:34:20 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm751930766b.201.2024.07.31.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:34:20 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v2 1/5] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
Date: Wed, 31 Jul 2024 12:33:59 +0200
Message-ID: <20240731103403.407818-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731103403.407818-1-vtpieter@gmail.com>
References: <20240731103403.407818-1-vtpieter@gmail.com>
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


