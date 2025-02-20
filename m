Return-Path: <netdev+bounces-168066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F6A3D417
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FED5179317
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199191EEA4B;
	Thu, 20 Feb 2025 09:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAE1EDA32
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042134; cv=none; b=crwBPkivEs/Y7s0Wo7vXPsskAbR8Agk1wnoy0akzKDvD+UphaewPTILqW8JEgrV+AC+44UNXG5xdLAJoPYMd0QCyz9YZNyiZvNLVlHcuPtHwN0T1/riHcR1r3VfpbqyfnK4/TaU9LgYTti/89pb7gzdy2c7/Wj3Ku/2kChl3xWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042134; c=relaxed/simple;
	bh=FN9d7ZQRCPA5l44MFwW68/Op3X6Ji02BGuP0fsYD/gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAt8c6oybyYO+UB9QddnAglLSbgf1f9vaLdlfiKWh1VdbfpWne4JKYoOIJCaUj9vNOwF7sWpjXxlaEYJ5AF54zgID6OuoOWmz3bWgiyuxQPwW5h5SJ0NWo4jGcqs0RaTZiwWlPxUhBIhMxJ4Umizcl5kcJbT2CBftxso4hEerjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl2RR-0007Bq-7K; Thu, 20 Feb 2025 10:01:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl2RQ-001uIG-0M;
	Thu, 20 Feb 2025 10:01:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl2RQ-00CKDX-04;
	Thu, 20 Feb 2025 10:01:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 1/3] dt-bindings: sound: convert ICS-43432 binding to YAML
Date: Thu, 20 Feb 2025 10:01:53 +0100
Message-Id: <20250220090155.2937620-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220090155.2937620-1-o.rempel@pengutronix.de>
References: <20250220090155.2937620-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Convert the ICS-43432 MEMS microphone device tree binding from text format
to YAML.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- add maintainer
- remove '|' after 'description:'
changes v2:
- use "enum" instead "oneOf + const"
---
 .../devicetree/bindings/sound/ics43432.txt    | 19 -------
 .../bindings/sound/invensense,ics43432.yaml   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
 create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml

diff --git a/Documentation/devicetree/bindings/sound/ics43432.txt b/Documentation/devicetree/bindings/sound/ics43432.txt
deleted file mode 100644
index e6f05f2f6c4e..000000000000
--- a/Documentation/devicetree/bindings/sound/ics43432.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Invensense ICS-43432-compatible MEMS microphone with I2S output.
-
-There are no software configuration options for this device, indeed, the only
-host connection is the I2S interface. Apart from requirements on clock
-frequency (460 kHz to 3.379 MHz according to the data sheet) there must be
-64 clock cycles in each stereo output frame; 24 of the 32 available bits
-contain audio data. A hardware pin determines if the device outputs data
-on the left or right channel of the I2S frame.
-
-Required properties:
-  - compatible: should be one of the following.
-     "invensense,ics43432": For the Invensense ICS43432
-     "cui,cmm-4030d-261": For the CUI CMM-4030D-261-I2S-TR
-
-Example:
-
-	ics43432: ics43432 {
-		compatible = "invensense,ics43432";
-	};
diff --git a/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml b/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
new file mode 100644
index 000000000000..7bd984817aa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/invensense,ics43432.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Invensense ICS-43432-compatible MEMS Microphone with I2S Output
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description:
+  The ICS-43432 and compatible MEMS microphones output audio over an I2S
+  interface and require no software configuration. The only host connection
+  is the I2S bus. The microphone requires an I2S clock frequency between
+  460 kHz and 3.379 MHz and 64 clock cycles per stereo frame. Each frame
+  contains 32-bit slots per channel, with 24 bits carrying audio data.
+  A hardware pin determines whether the microphone outputs audio on the
+  left or right channel of the I2S frame.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - invensense,ics43432
+      - cui,cmm-4030d-261
+
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ics43432: ics43432 {
+        compatible = "invensense,ics43432";
+
+        port {
+          endpoint {
+            remote-endpoint = <&i2s1_endpoint>;
+            dai-format = "i2s";
+          };
+        };
+
+    };
--
2.39.5


