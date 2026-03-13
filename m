Return-Path: <netdev+bounces-267448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNutGHcMtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:09:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9D28375A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5027D30086B2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E36309EFB;
	Fri, 13 Mar 2026 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKcLNzX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3B2EC0AE
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407192; cv=none; b=H/8f0VCu6o+19VYfsDJ+rNTuVIMJWJADPf7EvWQjicFg/HjG2BNlfII6uK1MiXUQHKaR8DIPw0vPKkXaID9FuYn3PQPpAMMr6wzxS8EzdRATbuO2EMgnARz90GA4pBAMSrEhJ1W43/bT5zRVynoo/pvL6fE+VmK9uCFEufm72E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407192; c=relaxed/simple;
	bh=YgKNNg49/YkZTSbEdG4sVgeSeSAh0M1PjzPJ39xAwXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRssB/Sw810FLodfhmhuq/R2NTk2PyG333hO0M3ymwRlnm0ZCiIWNMJrAPYKeUwxuLt14eHPo5cbCEbbhgiyLlJ+mve/ouEEDetewrpFN6Ys3QbVdC0VzHCLyjfUqs8lUccQ1Ap76G+H+0/rxOneH0Rxdw0+nSN1WQYpLC3IUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKcLNzX9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48540355459so18935705e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773407188; x=1774011988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIMvx3G4GiLJ5SJmuQBiCjyrBNPvzb1sP/TsmepD1dY=;
        b=YKcLNzX9w3/Zdb8VF5liROzWPrSRRR130SO1jzs84JZTVvw8158+Z3S+XUGmM/mxJO
         8t4ZWMIgqc0YACPNw9ePJYm7IVaQyZBsqP0ZnNqhopZVcdXzI8VAQlVX0yde4T4HRmww
         0oW9lKX0TiMgzDIZZIVGUNWAWaloBCyQkLtPg9IHwss3jZi9wtS72NFbfnRYOwj19g5m
         ffAij1VyqnhKq1tVXrzLmDRP01lrc16QKSOMzskXtPxKh80cooe6FoPdvwJzd7/5g7mP
         SWPPpkBJYUwV6nSk/pSEu/2TI5ymKEoKf50RselSCnZ909dJBUi3+7ZoYdABqM+q9P88
         lkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773407188; x=1774011988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIMvx3G4GiLJ5SJmuQBiCjyrBNPvzb1sP/TsmepD1dY=;
        b=hp6PiYSo4OzeN3b3Ndmad7X4BhfJXGaykfROzTN+IYIrfAA4nAR2lGGmg4pyWD+Ywb
         xVToohUpOOYD8CmzXCQaDaDR09I+lZ88XhC0hm5qPtEACClbP0Y7OCDpTgf2ZbjxOmC5
         FQ7iJTIGXr91GjTunlE7SXBJbKmX1RcbfbdN8KuKRt5NU28RZVkIOYGZl+FM63rRNzOF
         OywTTYkoD9zpkwCwzZYbNvA6pGobT22L5Hi2Wby09sTKX8wFhLLVvq0AeKJ4RQekMUn8
         +BqwyNnFu+LQSDwIvvJeb1iHmR5Z6Dc/wOJmavN3cPQ8I5SQ45MqkA4R/r7S5+5sOkWe
         aesA==
X-Forwarded-Encrypted: i=1; AJvYcCWHRmbeRvr+Aq3UQxyTsjT+83FUd20k0innyhSboORcsiCFfTIReYohFTmcTaznLx6TyPRUS6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyziMFQMt/saSoUxMDNjaQN+0rxyLTYK3hcp4vB+dv+jMXBv9I+
	gvWJUj42iyzrlWnmdliaZncwZ4fR9/EH39IuTe8zbJZNqyp7KDkzlnr7
X-Gm-Gg: ATEYQzxg12DwRT48ly79Z/pPy5tY6FH8kaIv5Wd69aeBKGjlKBo4NY97/mz01TvHvBJ
	T5HMs4ozLrIcEBCVT+qG9XVsuObZVwQI4YAAQfGZ+knJ4wSpo+DFvwlJz7YqAOdTpTgkn9OWGDe
	RJQ2Tyz2Zt6Hty5zFSsAYr+xRTRHI5jLafpJuVsWKp6IcQjazXdqJSWoBS7d94hR2G4ChVbQSg6
	UAhce3qT9PyV7diBF2RgB3zwrFj3akikZEyMRQDHdJFdbs3EItBpcY/lsG/B4LUUlPjS3QotCL4
	L/nhYypbZKpVA8i3dWveO2zlaGNsz3+mDPl0O6uTdmXoxJJj2BGaMWnVwy7/8AtD/jNGcM95atG
	fhrcjQTmLnE/tlGkPrkvCHwuYZAteBcxNmtg/Pxnmx+aS55r8Vpsez/IlJ2AugKRw/JhlJR0jJX
	mEGDEmXQYrr84fR9NkS/+VgW97WVEHh3a842wW5wnqYdCOnZGR
X-Received: by 2002:a05:600c:3b14:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-485566d94afmr45564705e9.13.1773407187407;
        Fri, 13 Mar 2026 06:06:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6418:ccf7:57f1:473f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm559497155e9.2.2026.03.13.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:06:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Barker <paul@pbarker.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next] dt-bindings: net: Remove redundant ethernet-phy-ieee802.3-c22 fallback
Date: Fri, 13 Mar 2026 13:06:21 +0000
Message-ID: <20260313130623.297712-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267448-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,armlinux.org.uk,pbarker.dev,linaro.org,gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,ragnatech.se,glider.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,0.0.0.1:email,bp.renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.8:email]
X-Rspamd-Queue-Id: 66A9D28375A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop the ethernet-phy-ieee802.3-c22 compatible string from ethernet PHY
bindings and their examples. The c22 fallback is implicitly assumed for
PHY ID-based compatible strings and does not need to be stated explicitly,
unlike c45 which requires opt-in.

Remove the c22 pattern from the ethernet-phy.yaml schema and update
examples in amlogic,g12a-mdio-mux, mscc-phy-vsc8531, renesas,ether,
and renesas,etheravb bindings accordingly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml         | 3 +--
 Documentation/devicetree/bindings/net/ethernet-phy.yaml        | 3 ---
 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml    | 3 +--
 Documentation/devicetree/bindings/net/renesas,ether.yaml       | 3 +--
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml    | 3 +--
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml b/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml
index ec5c038ce6a0..e9e575fab62c 100644
--- a/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml
@@ -69,8 +69,7 @@ examples:
             #size-cells = <0>;
 
             ethernet-phy@8 {
-                compatible = "ethernet-phy-id0180.3301",
-                             "ethernet-phy-ieee802.3-c22";
+                compatible = "ethernet-phy-id0180.3301";
                 interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
                 reg = <8>;
                 max-speed = <100>;
diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 58634fee9fc4..d622e73a89ff 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -47,9 +47,6 @@ properties:
           second group of digits is the Phy Identifier 2 register,
           this is the chip vendor OUI bits 19:24, followed by 10
           bits of a vendor specific ID.
-      - items:
-          - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
-          - const: ethernet-phy-ieee802.3-c22
       - items:
           - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
           - const: ethernet-phy-ieee802.3-c45
diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
index 0afbd0ff126f..5e5dea7987e7 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
@@ -32,7 +32,6 @@ properties:
       - enum:
           - ethernet-phy-id0007.0570 # VSC8531
           - ethernet-phy-id0007.0772 # VSC8541
-      - const: ethernet-phy-ieee802.3-c22
 
   vsc8531,vddmac:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -120,7 +119,7 @@ examples:
         #size-cells = <0>;
 
         ethernet-phy@0 {
-            compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
+            compatible = "ethernet-phy-id0007.0772";
             reg = <0>;
             vsc8531,vddmac = <3300>;
             vsc8531,edge-slowdown = <7>;
diff --git a/Documentation/devicetree/bindings/net/renesas,ether.yaml b/Documentation/devicetree/bindings/net/renesas,ether.yaml
index f0a52f47f95a..dd7187f12a67 100644
--- a/Documentation/devicetree/bindings/net/renesas,ether.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,ether.yaml
@@ -121,8 +121,7 @@ examples:
         #size-cells = <0>;
 
         phy1: ethernet-phy@1 {
-            compatible = "ethernet-phy-id0022.1537",
-                         "ethernet-phy-ieee802.3-c22";
+            compatible = "ethernet-phy-id0022.1537";
             reg = <1>;
             interrupt-parent = <&irqc0>;
             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 1e00ef5b3acd..6aea1acaaa59 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -364,8 +364,7 @@ examples:
             #size-cells = <0>;
 
             phy0: ethernet-phy@0 {
-                    compatible = "ethernet-phy-id0022.1622",
-                                 "ethernet-phy-ieee802.3-c22";
+                    compatible = "ethernet-phy-id0022.1622";
                     rxc-skew-ps = <1500>;
                     reg = <0>;
                     interrupt-parent = <&gpio2>;
-- 
2.43.0


