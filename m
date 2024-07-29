Return-Path: <netdev+bounces-113806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B57940005
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0562811F6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948918C343;
	Mon, 29 Jul 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Fph79m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0415FA68;
	Mon, 29 Jul 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286962; cv=none; b=F+LiuEtXzH7Pl1an56LoK3ePq5/7p8F/RdsXVCQ2JMrYkBATw7XPFrvmgs89o/OGLUxhyCm4FC1/kWrC6jbvkc/W8EV9XGPmtD5DF9h1Bt46z3AjkifJXtnq04ENK7mn7lxSee9Ld+fQUdsnLXGdI70sWBpRl9sNQpnrAQDiGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286962; c=relaxed/simple;
	bh=GxLJg+Yc+0+/EWxjIyqzooDSQcv6ZWuyjdexitDnoik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3OPVdis5bwROygiih1qfHjvmYqMtjws6B3IkTRoQQNOZQYbBNN6JOwXw78v8lSPzUHQGr6NVBAgVBtd7efLBZwmC66veERzKUF1jfkXIWbIpRlRkM9U9ram1qRKHx+sqB4NRy60wqc5ZIm7BC1taIoYifaPoVW3n/mhPC+nWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Fph79m; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efbc57456so4158849e87.1;
        Mon, 29 Jul 2024 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722286958; x=1722891758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAvDYGFq8sK5v/DNNa7E+G0VDjJRRJ2uN34Qkw1oST4=;
        b=b4Fph79mEA2/PZ+qI/ETOtOMPtWmzmMHnWL/VqEAwYMjTgmVobimB/yjmEYW1/eq5i
         h+MyPX1GKKpiMYemQc7/vGzmGR/8FB+dBBNWxU0L6zpAZhBerOTcYoV0wveFUCQUvJsu
         keWfP8Pk6DZ2T6ktqln+2hzplt3pRcnH0lT4rh5aSsVgp8sX96PT5uRAJoOM8al51Zxn
         /vMybwC6F6HPIU5913tysMEoT5nw7JAnVKjH4HIe6c1GlQhQUsPjNPz3/qjlSoIob3iL
         TdDr/Pw5s352XIUrfFw09wONp6zAFT211c3vfVmeFwTEjh6SFsxook8mhWch2Alq/3pm
         4X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286958; x=1722891758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAvDYGFq8sK5v/DNNa7E+G0VDjJRRJ2uN34Qkw1oST4=;
        b=MtyqpLKx7YRT+qpLYyewqNU0KDumHMf/qz3A9ly2WFzxx4bcDfMKZSPCnWMp7GqbOL
         /Ewiek/pz0FUF6b5c6yTaXwFeYWoeNLanM83i4jdbMTB9hXhifrfdeHBjtoBhNAOVln1
         1qwHIDjKvKwn0iyjUyeoMdYYlUTtdWA4EQj60hzIi0UY1KQRsoH1ll5skdKH872PcXUk
         1vO0vvBmff2HI3TozWEoHyG57v3PJGw1ewKz6K/JrKzASD1aGPMyIGpXXoMArWVm1Spf
         dya6Hso0PwLJnE3cGWSDR4noaMZx0iXct/zRre587QQQmUDAX00lrU6HaImi5wRD7oyK
         d8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3mmVTzZXBMzuckpcbZr+1oDSLWEdYnD6RGqHGC+kz1gZLwooIkLYyh4RbFwsGOab5LZ9Cz1ToxEfIu71940nRE99n2TEDJw9JsW7R0Rl3nt5NIF3I2P3l1Sm/q8+e8vaQx7SG1B1J4Q==
X-Gm-Message-State: AOJu0YwLjvWAAee11w2JFFMU4geG2iEn2xXvRu2HtS+xlLM5Gl8T2g2K
	bCdMR6jLLlvu36E4XiJIBk++KVPfuoJAJoLKbZsN2AmvJYmjDyErC76DD5I/
X-Google-Smtp-Source: AGHT+IEaz7PEByH4RpmeBa4w7jMT/ZSgdsjh/YB2LeKDcFrDiGfhuLAmhMTaQ+QWT2oKVia3tzUXFw==
X-Received: by 2002:a05:6512:36cd:b0:52e:9a91:bba3 with SMTP id 2adb3069b0e04-5309b2707bbmr5171993e87.15.1722286957873;
        Mon, 29 Jul 2024 14:02:37 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c0831fsm1621050e87.174.2024.07.29.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:02:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
Date: Mon, 29 Jul 2024 23:02:01 +0200
Message-Id: <20240729210200.279798-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729210200.279798-1-paweldembicki@gmail.com>
References: <20240729210200.279798-1-paweldembicki@gmail.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
v3:
  - use 'default:' instead text in description
v2:
  - added info about default value when the rx/tx delay property
    is missing
---
 .../bindings/net/dsa/vitesse,vsc73xx.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml b/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
index b99d7a694b70..51cf574249be 100644
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
@@ -67,6 +86,15 @@ required:
   - compatible
   - reg
 
+$defs:
+  internal-delay-ps:
+    description:
+      Disable tunable delay lines using 0 ps, or enable them and select
+      the phase between 1400 ps and 2000 ps in increments of 300 ps.
+    default: 2000
+    enum:
+      [0, 1400, 1700, 2000]
+
 unevaluatedProperties: false
 
 examples:
@@ -108,6 +136,8 @@ examples:
             reg = <6>;
             ethernet = <&gmac1>;
             phy-mode = "rgmii";
+            rx-internal-delay-ps = <0>;
+            tx-internal-delay-ps = <0>;
             fixed-link {
               speed = <1000>;
               full-duplex;
@@ -150,6 +180,8 @@ examples:
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


