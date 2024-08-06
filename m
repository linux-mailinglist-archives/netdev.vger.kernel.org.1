Return-Path: <netdev+bounces-116096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD894916B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E4D1C23A7A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EA1D2F4E;
	Tue,  6 Aug 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlQcBWCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D61D1F4E;
	Tue,  6 Aug 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950911; cv=none; b=mXDJMTORwOAwiK/jSfdD7jvLDxye5kHlt0kPZ7pIVhZ2tIiSAwi/6EiT+ynQWen8b+M1ggjGp2sUARg17TGuTsj8CwGIBthhpJwcmG8yj//VvvMupNASDzog4mDyC0iSpnlgnWG/92/eFFc27Lqh74iAVUtinqzA9sDHre4Z0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950911; c=relaxed/simple;
	bh=MNnLV25K6YhULXYYlXhNI0BKUG+LUYqABdwm34GgDDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEAe1iSHf+kprRrgQWp8Qs45jT8e0VGE7DdXE9pT8p/KDdw4tX1AXVbVyKlmvW+Vjt7993l+ku3dpCDLprpEyR6wTYE1GmplFc/cDVkno4zj1YrELQgFCCI7L6jGHGtfc69bQX41AHPErcdQwf/KATtVLP/+AHcShVGVHAcQwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlQcBWCV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso312501a12.1;
        Tue, 06 Aug 2024 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950908; x=1723555708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=WlQcBWCVLG5gb+cTZ4+XDR00I9JrxHrTpIPL1Xs3CPrDreFcvziEBBnKGnyJ8RFqay
         KICOGOvuPVnRYfu1asUOG4Tk0y3Ks+IwlUH8OpbPLy1HKP49b48MnA6B/vc948MqXLBo
         WSQZ2iRfGQPC8RGJDcwcQQei2BHj2US379PpRu97f7ILdeT7PZPWwGvk7uw9ORUrb6ux
         nPdLFxPO6Px3+HOMfmjY1pW/ROhK4P63YrQYiPv1klcfdb9EvkbQzPttI0UgEoc2SZce
         xS3w0sqbIkCkbgnKdRUqz0RrHCrpz30Ee08jg94VQyyMBNy4+e+NhNQL49zEhilVWA2G
         nvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950908; x=1723555708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=Ndd25x2ktqdw16ZSapjh+949yuTLY9QfgRtz9nkg0AZuk3PamQ6OxQEBr/4FpVCrCK
         N9Jpi8N375esF8+292Qn6GwqTjmTDk9l1Y2Wyvce2imv7dLaw/jK4REHyCrvG8GQWjNt
         jj1jmDPYzro9o7HUuoMIxsJUDnDZJovE0TegzJ4faYmli0XGW9+0qv2/VIlSvkGHvh18
         5Aci+sH0O7Uh0Qb7hncb5YDB3O8qIqtmS8vX49WyazMic+Zbaoya/mjbDUJdxqFglquu
         LHRsrInTZj125PrIjAxiH2olbmhHttCSlc0Hb2CuleA8Hmi97txR1CqXsaskgGn3UgXZ
         fepw==
X-Forwarded-Encrypted: i=1; AJvYcCU6oSaB3MU4NhWABKj/Kx0QgrswtqXQlOm/wjz4sCEa9Aer5XWHTxaqHzNQFYvp0qHqcrZomlAgtUdu@vger.kernel.org, AJvYcCUQXcPwnmmxL+S0+YL6QnRMQi1N7/FmM2mbACe6VlWSL+m7uybZ+5Ww4yavkLIK8rwFVunKb51m/XZlh5qF@vger.kernel.org, AJvYcCVhyCAedyXIhdD/gKx5dQfY2eDW/GYW542zExejAYqFufFzv/VrcU5wR5iHviReOVgocPvkwvWP@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAB2taL8BpP7KgySvwhAJSbgKnp5tjdliULNQgMnqAkYcBW7U
	oIfIivdYkxDuhIrRwg61aboc9avHYR2k3gU1GQ5aerXeBBsD5oKe
X-Google-Smtp-Source: AGHT+IFoADXb3aIb0ygPnlnU2NZzG/iHbz8BzpZLTJYMTElblwboYJGK63zl4KoMM/0u6YlD487YkQ==
X-Received: by 2002:aa7:cc81:0:b0:5a7:464a:abf with SMTP id 4fb4d7f45d1cf-5b7f521e6a4mr13748702a12.24.1722950908185;
        Tue, 06 Aug 2024 06:28:28 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::102:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f77sm5910172a12.53.2024.08.06.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:28:27 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/5] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
Date: Tue,  6 Aug 2024 15:25:53 +0200
Message-ID: <20240806132606.1438953-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806132606.1438953-1-vtpieter@gmail.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
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


