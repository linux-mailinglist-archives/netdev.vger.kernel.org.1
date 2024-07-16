Return-Path: <netdev+bounces-111811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2000933098
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4E41F21433
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6241A38FA;
	Tue, 16 Jul 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyuJSLS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0C1A0723;
	Tue, 16 Jul 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155098; cv=none; b=N3Mn/H7p7DxRsEbUjw/WT8lQcWTe0y7fUqtBwKOE5wpdjYws6lV+JAEVo8AidBd2Oww3ahfKH4tQFuc1HI3IoTY3HNpwdKIrThvdZbFgxSB4Xssgk6QbXPY3r8V31a9vgp8vnh8/GsIwXRNkEQ+rK2Bu3GVB8iAtdhXKa6+YdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155098; c=relaxed/simple;
	bh=qn9kHVW1OzJtikyFcO2q7jFY1NsKEwFVI6LTAGD6xnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grkrlJnJY2fpZgEub4exuoeC+8rqQfEwTewUGORCZSwj9PoYACf+YjsHsIDRQZdxtWMFMuaOrnr6wpAQx3V+qaQjak+xqu/0WiULXXmkssMack/MN9Kc04lb0rf6/rvYQ1lDwZf5JEY9m4VRqvFMEXQ661sDID7z3N9xvLV3wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyuJSLS0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso6648751a12.3;
        Tue, 16 Jul 2024 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721155095; x=1721759895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlJmJ78XAskSwGh3WsL7y33RtbTE4NmXymqpFlK54ts=;
        b=lyuJSLS0Qlg7pERNBTF80HCpTYFM3VQrN9Dr3LI7j0fyv7MXemC5Et1O92s5thStwd
         vdfeHyY2JTWkBT6v19lLSVe0Fa5fWIBWzNh/2RgKdNvPwMnnhs+et/m8Z8qfLZCx+U2w
         ybUUQ+FYzgLHmm6u48kJTf4XXhyzMJeciCOrgdMKkStZg/KpoVpZJzo6N26RtzMbHLtj
         5RLXsGi2FIWj+mkXBRa1bWu88TK3EjHTcscS73k8QEQxzCNIhJGIEOycke1XWdTsJ6b9
         64I9phYxfUNV2d6hS8b6GSHzMbOR3jXnksJECzEFZarimsRxUxtF6WUIWT15h50xnfKv
         HtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155095; x=1721759895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlJmJ78XAskSwGh3WsL7y33RtbTE4NmXymqpFlK54ts=;
        b=eeEskKHBZSpVzFwIrewr3EcEh2RTiZCUD8nkP4PKh3NydpJDDSaF/D0KO/QPpNyhI7
         OVukCyJCB41UFfYFRmf7aSfQk10cX/4es33rFb/JpNG2tULqihTWj5jX5yIzpgOht236
         qwn51KzMEX94PCjlbodsBfXdu7oiy7Ab22ihuD5RPKCWcD6FTMeWyIf+WddFs62CBLQ0
         x6NRKbKa+Ai6vW5GuLK0xupPJWuqHAQO1Yn5xBHL0qUkSGQsa2CxltVDqeIFNLGSt4so
         bTOhFnTsPxwCu7HYbSF8L3zBQwOKICZl33Ei3Pimu2SJ1zZTW6lb6biiF6kryAS5h4op
         7m9g==
X-Forwarded-Encrypted: i=1; AJvYcCXv1pzS9EuWMvJzPUTDowtLmHP3R5Frcvc/+T9j8q/9hrOGI6K7uguuu2n5KVtMVzILFfisCWjftZUbEIYNCOG7YWvkB+WvwoJcdBMPBXEK+6zgxEbp1/mMf8/8GCKQ01D1jHczkxMHKg==
X-Gm-Message-State: AOJu0YzMLgw5p3uIAebQBfQCW4HRTHj68mDK+aWI+GCZB9eitjKtRQrk
	cTcDlEoDeoN8Vljbzr1JPJnDcDz2so3lmMMjY+FrF6ceTeaJasOWWF2Pr06Z
X-Google-Smtp-Source: AGHT+IEDWRigWcf2uMuJzT5AZqhjIH9Dq+g7rHkhQ8vC9ZJJssxZ8d/Z4Ule0uxigZLhHUPgXrqZoA==
X-Received: by 2002:a17:906:1292:b0:a6f:f7c:5c7a with SMTP id a640c23a62f3a-a79eaa61812mr213097066b.67.1721155094718;
        Tue, 16 Jul 2024 11:38:14 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820eb3sm341852366b.207.2024.07.16.11.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:38:14 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
Date: Tue, 16 Jul 2024 20:37:35 +0200
Message-Id: <20240716183735.1169323-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716183735.1169323-1-paweldembicki@gmail.com>
References: <20240716183735.1169323-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a schema validator to vitesse,vsc73xx.yaml for MAC-level RGMII delays
in the CPU port. Additionally, valid values for VSC73XX were defined,
and a common definition for the RX and TX valid range was created.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 .../bindings/net/dsa/vitesse,vsc73xx.yaml     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml b/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
index b99d7a694b70..f0fb31ad5d60 100644
--- a/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
@@ -52,6 +52,25 @@ properties:
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
 
+patternProperties:
+  "^(ethernet-)?ports$":
+    additionalProperties: true
+    patternProperties:
+      "^(ethernet-)?port@6$":
+        allOf:
+          - if:
+              properties:
+                phy-mode:
+                  contains:
+                    enum:
+                      - rgmii
+            then:
+              properties:
+                rx-internal-delay-ps:
+                  $ref: "#/$defs/internal-delay-ps"
+                tx-internal-delay-ps:
+                  $ref: "#/$defs/internal-delay-ps"
+
 # This checks if reg is a chipselect so the device is on an SPI
 # bus, the if-clause will fail if reg is a tuple such as for a
 # platform device.
@@ -67,6 +86,14 @@ required:
   - compatible
   - reg
 
+$defs:
+  internal-delay-ps:
+    description:
+      Disable tunable delay lines using 0 ps, or enable them and select
+      the phase between 1400 ps and 2000 ps in increments of 300 ps.
+    enum:
+      [0, 1400, 1700, 2000]
+
 unevaluatedProperties: false
 
 examples:
@@ -108,6 +135,8 @@ examples:
             reg = <6>;
             ethernet = <&gmac1>;
             phy-mode = "rgmii";
+            rx-internal-delay-ps = <0>;
+            tx-internal-delay-ps = <0>;
             fixed-link {
               speed = <1000>;
               full-duplex;
@@ -150,6 +179,8 @@ examples:
           ethernet-port@6 {
             reg = <6>;
             ethernet = <&enet0>;
+            rx-internal-delay-ps = <0>;
+            tx-internal-delay-ps = <0>;
             phy-mode = "rgmii";
             fixed-link {
               speed = <1000>;
-- 
2.34.1


