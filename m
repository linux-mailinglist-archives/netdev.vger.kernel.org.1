Return-Path: <netdev+bounces-167160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5240EA39076
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7445518903DF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8E1714C6;
	Tue, 18 Feb 2025 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuKLF0v1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7915F41F;
	Tue, 18 Feb 2025 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842637; cv=none; b=tnbcml/KMfW3h6K7Q3JD9SmPNwOEU9IdoM7a9omAeMFGZwyvZvd347SFoME9FIzzRnPe1/80jBvACTgAJDz7Q2rJQ36BHN1lQVK89GEF+fZEe2SZSM9A4yA2LZDJ7S9uJhTRhxTpmoD34m9GSE+tjHQNM8AQXDoQiKl2HLUDUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842637; c=relaxed/simple;
	bh=BNvtoCFbvOSthhEBlZwLGZwmOIcJiXvgZiKL1et1DmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJN/rV9SqhRH5ZJAYEw2NAhjFdVTyOalszN+ELVsw1WtI3+/ssuE7rULYO/TRJ8PMmO8+zHPZmobMYMTWsQEjPwwxHIdWVXq4EgmuN3cidJONgV1sVOVGOfTVDdEqpYxGR/Gv4oxE0piotYNCZZLvUY9g4OXZP92Tv1zJ65h8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuKLF0v1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d132f16dso70245065ad.0;
        Mon, 17 Feb 2025 17:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842635; x=1740447435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cZFYYThYbCSWxe1uEPpF69mZmJStX091Gzvd+bF5tU=;
        b=cuKLF0v1ilPta6zr4lVMNKNJ17P9FpHgJ8vfsliljBp1/2xRRhf7tQy9ksCwjfOTzC
         BzAYjKGZDxv/fLsURGfrjjmAPQPbKW0l4KLIvloxM5m/2T3nmik26zXKR/L/nYPnvEh/
         bBsfjoHytsGFzYsXChpSBVJzb57So72+g2efqyXFbDxeM0gtChcG2EZZaE60rPlsjrBa
         WZ8/ukOx+e7JPMjI9EYaDoMWrVgoWqlVBOufYrTqVJsXgeBf5iSAF5j1p9rVWjNWd4LY
         gxqBR3UDhqH0nJIdIwBL+LLj+K89pOBvtzRamdFQPjgFmEjnXYhxvsx2mo0imuSevbFT
         KaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842635; x=1740447435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZFYYThYbCSWxe1uEPpF69mZmJStX091Gzvd+bF5tU=;
        b=wsWYDaA7gpJ8/9Racew7opZwT2m4thwWYXZPxUzmPb8S4Bm/IAI0SDywxSBqwu+jr5
         AwTZExriE/Q2akCK112UlFgesy99ZO7NfxeuQv9T4MvUaefOi4ze+dShZ0b46qf6p9B0
         M1qd9w3MpLE5512VlLSLta8HVHp0q+9A1OS9twO1H935NYMSlTNyOs9oTygMPdVRKDuE
         eibf9JpUyOebiJV3mXtndm3gRnn9EEOoG2fktiK791g0yHY5eQJkOIDQeMdaw4RNnZZM
         pb4gSXNM1sRkPFJZDpYpVUtCe3sj7aNzP8vGfR1rwgoaVHpR4KxojXKJMnkWh6dVWktg
         ed/w==
X-Forwarded-Encrypted: i=1; AJvYcCUn+GX9St/MeaqK3HH6MIGfdiVd/kZyRzCoic3Jp08iPadedpdqlw/lQOWQzWnaDtK7GrpAu/pkTFxR@vger.kernel.org, AJvYcCVaiLOupqDRrksZ1fPVU2ltDQFcD+9AuHH5csLkuCrXQ/JEmvehsTS5LKUr6eQI0E91NnKbeGfT@vger.kernel.org, AJvYcCXy3l28jhcR6oJiZxVq+qXlTzTNrQ9fH54958ucYN/+x72neN8v75zQZdC/SjyoCNVWUkg1HOh2d5ahsj1F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vra8ALI1wUCrsLg/MyH0bfQggrl1++c4uQ6Eu2n5COD0q4Fy
	OT5uDHrjjXzlN7tMphqgu401LXoHF0G+eihHPaDjT17QGqVE/DTE
X-Gm-Gg: ASbGncsNQ/74Q94GuvvZdzdpTWEpJt2zCa9Ij1yNvzGlIp5C5AHQma3ZUNmhUPTeUEH
	o6z42Bf+oCCSeEsF+tJblqWpTalW672yCM58sO0JyumO6aMFnRqrxJu0RvNFfAX7JHphAiYMqSF
	90n3MQfTVp6J9fwihy5iTfpvzXZGdwl4f303WQVkQUPxmxix4ZV2QnO+GtF6uVp5dn0bShvrai/
	uqbvqjXd+dReb2/xWfIE6w9mslP5Ghe2bR6e6JLzh2BVVyJDUoA8dQc0+zHcdG0n2quQnv9p98f
	7mWm1c/X166pTGJXqj0photQ4+R6RRATtg==
X-Google-Smtp-Source: AGHT+IG9JPuT/U1bFC1fmwwceHDTI0wlTmn8l3dsKfTobsN1nPxNz+U3ryLjP/MbQzK89VAPf481+A==
X-Received: by 2002:a17:902:cec7:b0:21f:1ae1:dd26 with SMTP id d9443c01a7336-221040c0c33mr194708445ad.52.1739842635311;
        Mon, 17 Feb 2025 17:37:15 -0800 (PST)
Received: from localhost.localdomain ([64.114.251.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm76910165ad.170.2025.02.17.17.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:37:15 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: net: bcm6368-mdio-mux: add gphy-ctrl property
Date: Mon, 17 Feb 2025 17:36:42 -0800
Message-ID: <20250218013653.229234-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218013653.229234-1-kylehendrydev@gmail.com>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the brcm,gphy-ctrl phandle to the
register for controlling ghpy modes.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 .../devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml b/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml
index 9ef28c2a0afc..9630b87b0473 100644
--- a/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml
@@ -24,6 +24,11 @@ properties:
   reg:
     maxItems: 1
 
+properties:
+  brcm,gphy-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A phandle to the gphy control register
+
 required:
   - compatible
   - reg
@@ -42,6 +47,8 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         reg = <0>;
+
+        brcm,gphy-ctrl = <&gphy_ctrl>;
       };
 
       mdio_ext: mdio@1 {
-- 
2.43.0


