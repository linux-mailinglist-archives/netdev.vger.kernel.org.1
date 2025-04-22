Return-Path: <netdev+bounces-184912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A7A97B10
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516C7189BFB2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5859184F;
	Tue, 22 Apr 2025 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kvh/P7gD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA922144DF
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365013; cv=none; b=slbzdPCrZShuzn0jRLEIe4V1sFsIktTq302CtAweUQSxcy41QJe9/PRUbqR17d+gPJ6KCd3F5TBWt5XyAbx9Da+zzDt33IKcznlAa+DmpNt70yIUmM04ITM8Cw6rtl4kMiWeAMhH3BAnLXG8DrFHNK/GMB1R+DdK3dZo2/B9kYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365013; c=relaxed/simple;
	bh=HhZVXlp4anu4BaMWenmN+yN1wsAgJVOqi4SZDzKsT50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXy9D1ySdcd6TZ4eFWvCOwPs2JGAKbAZoM+ZTG/erFCWLTLW7RjyQHSNzQP7HHuHM5Q0OwmH7H24+6w1l/Y4CTXWfaT4U7odhpd6nNY9UmiItENzzayEyS4Gt0g7jfTVm5h9ZGd7TlMzMVTsrLXNhBvPSdPB94U2JU+M6ZEYF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kvh/P7gD; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fec2899574so3502289b6e.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365011; x=1745969811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22UXaD7BcOLnc8Na5HsfVqWP1onqjcXFImJhn+WbMT8=;
        b=Kvh/P7gDf1PAU1us3xGrYT0m+W4JWQRWrIEwevrpAi6DtCFPaiGXh7HT7bhRpG3XLc
         QQLwEl4E5c4Hm5qffByZmAUclK1HthuUbD0khLLxVEej/f+xczhuClVM1Lo8RH4ryEyQ
         /U6lrOBgIu88RGg6vFefNaOo4dK1KdEeENEik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365011; x=1745969811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22UXaD7BcOLnc8Na5HsfVqWP1onqjcXFImJhn+WbMT8=;
        b=kmMDEKOtQXNkS/Oy20x8ydQRKYQLoWrm1nFk5JPgYsuyfTOINcnUM//ffA9I3QTfVV
         /RhE0LVjFQH5kFuUWxux7QeBIFH6T4fKC2oO/3x3xR1N+i8itPnTqfupbQcLNMxrNBCk
         q7R+crX5mJl+tNERgUYXtBqPaPgvuFQlX0/ZD/zuLP2nq+mWlv8nZ0IKk5MmpNCqmtHm
         nxs9cd3aZ8C+Sq6CZQr15qy9N08xBM2GGygzFkHICmOIX9VQYpk8cvt1jq7nIYS9WHAj
         9dsyeZOXjH0dAyIzP8tO3bAC8cPR+oLKEG6tWdgLjoDsmWD8YCRBBeImiHVA+Ht4Q6/0
         3uZw==
X-Forwarded-Encrypted: i=1; AJvYcCWk/zRlmSo/ObDEpdMZvAUOPjmH5PA12CPrTng61/ajxraQz18Pew/YHd0a2znzc5ApQa0+vsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkRdS7gXyvYcQ+Lb6dSEmBy1CdjigKg/kBSxwh4oBPdKWyCaD
	HP7wmb9Q+xMiHxI4lL+vFOAUyMmswofkMnSvexpR74p3hzXXX2dtubHPQm74uw==
X-Gm-Gg: ASbGnctY+BxGO95TLP3EvePVk8Fu20+sYbGbszvo1b6dHmjslf2rxHSDG+VXAMQiSnB
	R+FoP9BptCGUSL/OIHXVwb2+0Tvst6IBCxRth8vTJjUauu+bPPU9vfgn8TSk7UTzJMyAT97Y3TG
	wEN/YorwNJNmBQkNpHpGQJiNQqXUSfAzLs1xff8Cf5yxNWWThYfVQAShR7pEqrZ2aXkRrrFoCNi
	e4NMLNmnMC+T4US4ZZ/C08B6T0SUEYyMqwp52p6/oGrGUO/muXuvfLZk+TDd8/tE+LDPT2nPGcz
	ekoLotkYd5xXIEU3pfed7bFmyCC04ZUsmBQXT7Heu8LniuFBcf2+QrS+UY5wllZpmOV6tRgunQz
	vvbZnYBvRMsGJ8xraBw==
X-Google-Smtp-Source: AGHT+IFjst6DWiZDz3No5QlgZYdYD39iuS9d0jhgSC++1rLsSWQvzNJrU0aMgA58842RpjLOXvmlRg==
X-Received: by 2002:a05:6808:3996:b0:3fa:7328:b9a8 with SMTP id 5614622812f47-401c0ac7c30mr10521757b6e.18.1745365011046;
        Tue, 22 Apr 2025 16:36:51 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:50 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 1/8] dt-bindings: net: brcm,asp-v2.0: Remove asp-v2.0
Date: Tue, 22 Apr 2025 16:36:38 -0700
Message-Id: <20250422233645.1931036-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove asp-v2.0 which was only supported on one SoC that never
saw the light of day.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Split out asp-v3.0 support into a separate commit

 .../bindings/net/brcm,asp-v2.0.yaml           | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
index 660e2ca42daf..1efbee2c4efd 100644
--- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/brcm,asp-v2.0.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom ASP 2.0 Ethernet controller
+title: Broadcom ASP Ethernet controller
 
 maintainers:
   - Justin Chen <justin.chen@broadcom.com>
@@ -23,10 +23,6 @@ properties:
           - enum:
               - brcm,bcm74165-asp
           - const: brcm,asp-v2.1
-      - items:
-          - enum:
-              - brcm,bcm72165-asp
-          - const: brcm,asp-v2.0
 
   "#address-cells":
     const: 1
@@ -39,11 +35,9 @@ properties:
   ranges: true
 
   interrupts:
-    minItems: 1
     items:
       - description: RX/TX interrupt
-      - description: Port 0 Wake-on-LAN
-      - description: Port 1 Wake-on-LAN
+      - description: Wake-on-LAN interrupt
 
   clocks:
     maxItems: 1
@@ -106,16 +100,17 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     ethernet@9c00000 {
-        compatible = "brcm,bcm72165-asp", "brcm,asp-v2.0";
+        compatible = "brcm,bcm74165-asp", "brcm,asp-v2.1";
         reg = <0x9c00000 0x1fff14>;
-        interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts-extended = <&intc GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+                              <&aon_pm_l2_intc 14>;
         ranges = <0x0 0x9c00000 0x1fff14>;
         clocks = <&scmi 14>;
         #address-cells = <1>;
         #size-cells = <1>;
 
         mdio@c614 {
-            compatible = "brcm,asp-v2.0-mdio";
+            compatible = "brcm,asp-v2.1-mdio";
             reg = <0xc614 0x8>;
             reg-names = "mdio";
             #address-cells = <1>;
@@ -127,7 +122,7 @@ examples:
        };
 
         mdio@ce14 {
-            compatible = "brcm,asp-v2.0-mdio";
+            compatible = "brcm,asp-v2.1-mdio";
             reg = <0xce14 0x8>;
             reg-names = "mdio";
             #address-cells = <1>;
-- 
2.34.1


