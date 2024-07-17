Return-Path: <netdev+bounces-111951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD89343E6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 23:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F07CB245E1
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206C187327;
	Wed, 17 Jul 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4cFos4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC69185E60;
	Wed, 17 Jul 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251743; cv=none; b=KTPbW7p13X6wTSpOaChLSh/fcNaHytyIMfs2dl3LjUVFz7yvF77MaOlcKelGHOT1LkuChRM2rWxVt/ugUr1GIrfzMb7NdU57GtuhKKr1VYURWSwHuzGMiQfpjUoaJZlXpsXnoWh8Oxz/SYIjBbAGCgSR3+pIVa6h0A6zD/g3QFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251743; c=relaxed/simple;
	bh=tZdbzZAllKFHS+uGPe7keBWufqKl9nQ0WYp7kK5MWzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHO1HYX3TEhNQnRqKqWn+r/prSR4qriATk/x3vWh3nIzoPAdFadmGtlRixIAxBXNMjM+Q3naWAJ2T5rfRmVEyLujbKlhZqn1HI8WodfmKZgn/STcs6ziGk+puYOB/Vr6neU0TRVytSS9aypbqicXAWLw83qJ2QnGq0wD4qBBbSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4cFos4V; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso2221651fa.1;
        Wed, 17 Jul 2024 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251739; x=1721856539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc29YR0MLavAb8gDvKJJKOxIauGbyGNvRrfyjZ4hmXI=;
        b=Y4cFos4V1OEf7p47eztrqcAXeC3WcXk+ffCbyae5slIkDH09ynuadCvH89cyLmnU1h
         YWHYyjFWB8dNC4peUATnQmv9HPeiAlIqqSZNWv7vuVRP748TYn0Gr8cOe025xQ8ScvGj
         98hJqc5M6/rMh/rPtw+bZQgOIgcgLK6qIW84bXBkZNMp+2SMUUrdmt+PgGY8I/WDkBo9
         xxueJQ6x0+4AzF1IFb7ElCPuFN+wbI3852BaK4jhHgQN4YH+JwESalLrY61OH1uxxhNc
         xWBoaK/b689qHaHoz2ZXZdW6gW0JamcRAJTz2IYFNxjz5CDoO27jRfvryWRW/3+IAedR
         hMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251739; x=1721856539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc29YR0MLavAb8gDvKJJKOxIauGbyGNvRrfyjZ4hmXI=;
        b=HqDsjbhetw5q/yBSu+N57pwbpOkFHsAEiLFcB0WWyC+Tc7cJ/sqANsNSKJ8WqMwCpo
         I9yOYQZy2eDyhr5HZB0Rs1QNIQTuh70CFcuGw3dmH209/xelS6N9QLxjyXDknUyMR0tE
         70VzIeFjWGP05XzdWLzOAODf5ZAXdhjYb7ETbNsT1hRcjpaiwiPKxDI+329zY3x4w9bV
         fKDL746JTvE1Qnb0A1JZim0c8c532CmJS8IkyWYVWPisVrcLTPvga5pzowCbv4y0HJBH
         /6liT/z84vH76tAMo6r+7r5aPxPiowwC6VNCzR15mdF4lpOhC7UB1990lKOnrjAA4UYD
         nFaA==
X-Forwarded-Encrypted: i=1; AJvYcCX+YJh1vfqOTXbEIukx2JyrdL5JKgg/GSDZn71Sx1SrSw56mH3JSOcqWWh/ds7+guiIVabVw0fzVK+OyLHJL9yaOv8naSl6vb2Za2Ps4z488u2xSu9uscTQn87fZb85GAvL/9cBk28obw==
X-Gm-Message-State: AOJu0YwC9/0yZfdGkAW2gmeofN2U8kGwj76fR2BPH4u89iTtZw3t/Sw1
	vHLcHjPivcBbPf5H8RWoAwFi6ujLXPN+bFvGMdHDZvLs5hdoBuLf2L3qWJPe
X-Google-Smtp-Source: AGHT+IEWeL4oJBrjTRu/BEp4+ibBQJr6iOFZvDrpOaq/euB6dt6YEBehpmxyuVTdEK3rW4H8dBU3UA==
X-Received: by 2002:a2e:9dc3:0:b0:2ee:8db7:47b7 with SMTP id 38308e7fff4ca-2ef05c990admr3884601fa.26.1721251738708;
        Wed, 17 Jul 2024 14:28:58 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76f02sm7529198a12.2.2024.07.17.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:28:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
Date: Wed, 17 Jul 2024 23:27:33 +0200
Message-Id: <20240717212732.1775267-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717212732.1775267-1-paweldembicki@gmail.com>
References: <20240717212732.1775267-1-paweldembicki@gmail.com>
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
v2:
  - added info about default value when the rx/tx delay property
    is missing
---
 .../bindings/net/dsa/vitesse,vsc73xx.yaml     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml b/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
index b99d7a694b70..7022a6afde5c 100644
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
@@ -67,6 +86,16 @@ required:
   - compatible
   - reg
 
+$defs:
+  internal-delay-ps:
+    description:
+      Disable tunable delay lines using 0 ps, or enable them and select
+      the phase between 1400 ps and 2000 ps in increments of 300 ps.
+      When the property is missing, the delay value is set to 2000 ps
+      by default.
+    enum:
+      [0, 1400, 1700, 2000]
+
 unevaluatedProperties: false
 
 examples:
@@ -108,6 +137,8 @@ examples:
             reg = <6>;
             ethernet = <&gmac1>;
             phy-mode = "rgmii";
+            rx-internal-delay-ps = <0>;
+            tx-internal-delay-ps = <0>;
             fixed-link {
               speed = <1000>;
               full-duplex;
@@ -150,6 +181,8 @@ examples:
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


