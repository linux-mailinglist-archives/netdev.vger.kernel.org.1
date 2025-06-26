Return-Path: <netdev+bounces-201683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF3BAEA8C0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82867B3338
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66170273805;
	Thu, 26 Jun 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVwb4/8E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA25264FBB;
	Thu, 26 Jun 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973043; cv=none; b=BJn/0wNCjl/2lFMKvjwMFHFHJkx20/4tt49AtH4BhbVVZfRhwSpd7H1WaHOStwYPDb0B/qs0IPJlSwdZZUEH6X3aDz1hgOqlMmkV2ocFkJ19fP27o40Zi3JRb3SPB6XIEC+16P0XPiRCXE+Vdh0pzAWlfJ/sg8WgmyvANLak5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973043; c=relaxed/simple;
	bh=KBBfT0IDiw8oE0igR/jcFd9xnP51A70PMzQ4/5lb2bc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoiEuOkOep3bDGYJsrZ67gw1FVG+aEqVJ07WxPnBZ0U39dIqpMrXa2HcvMb8xnNEGeWOIQPl4gDjX+9o1n9CotyV3odqBZwtbVklye9gppH9Vwp6lurcFbVYiiVAquEX1xihiyw67QqgGf+uVZm70MBICMxQQhrkOPEkln/+D2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVwb4/8E; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so10629965e9.1;
        Thu, 26 Jun 2025 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973039; x=1751577839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExLehqKRvcjfnLv7M/oInDmYXs2lxlBzas9u/z/Ge4c=;
        b=VVwb4/8E6C7U6sjKszKp3naCr/L3COkwDQX0Rq2oJik5x2Njl7AkPXjK3o58vG2CJZ
         MENEgnuVhzvMoOVHols1ILfn6CfVHoNSwR9+/lrXz8ob471JgEW1AVHSC6UsFu8eIaHL
         YsTtX7RTQC2PH1wbFlBMS4HMqWOtyMsPDd2VHvcdhSAjoSftKXm7M3swxdplMqgBTpl5
         I6RJAuVvju8IrR0PJJsmFis29aK1lUFMkgOfVlRlNw2HChu5g6CX0Js/FpEYLW91dqFc
         BUjNGdLDBUmKljQzRKXHg5oHNe/yBRoYT6hx/edGOidXuKNfbNiHTmmiP94DjEUiS8dF
         1OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973039; x=1751577839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExLehqKRvcjfnLv7M/oInDmYXs2lxlBzas9u/z/Ge4c=;
        b=uy9RR2jvK49IqtK3evJLe2K5YEdQexGEbJW7HvODzBfRzRrovqxhOZ5XXhmBx1N4Rx
         ZJsMUjeu6V9P1csfxfXo68Sf/ZPW6TpnWHOJerNBD1xZExHjTClPX3rEf9shEPJEqbc6
         HjjBEoOplcwIdlB2eo75cRqMLQ/2xGmKq9sn3HE38KtZkD9UF+FkA35z77uKI2SHReit
         Wq9n7Rrdjqfxu/rMiIt/CBZc/KVsjdcrsM3rpscPAkAvVISxsxplL9bZgvV98DQwiRTq
         lAceq00o3MYTfHNSIxbRZvHlc7yfxxkf5GDVRKpvg7Y1X6HshhLt9nuprDlBRJOZsIZN
         KGfw==
X-Forwarded-Encrypted: i=1; AJvYcCUi/Cblfar4UdyQpxMQQ8K7VyHJs2TI/DV+DECyfZgDziOy4ovOMec8eeoAnN7IZjiqkwmFZssTSSa1@vger.kernel.org, AJvYcCVyFjNID9fkwUrTCIJU0LEr+fT++iJRzpzvlupmPibJhXD/LanmyyhLVoEJ/++J+TxMsPflsPD9@vger.kernel.org, AJvYcCWCbXNs5M8y1tu4H8vBcYS4fOyOMHWNb930kUT8eNUcizryetAD7xOKg6jv6/2UPa7bfrQrnoLSXoxJQTrC@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPh0GQPyhH2wqztXDURMPO71Bmju4QdEHhpixp2S7nkF/Q+C4
	OfgRFtnC183pnfZ7/k0Z65w5T/PZp1rtDBZ3Zu8T/VxGFzJi3ceI23hw
X-Gm-Gg: ASbGncvcYysGdlm6qo54DrYThkzAMuGfv4gnMZs0t6/5WGpfeCMtnnfx9Fu2qeiqOCv
	L/izY3nzEku/dIp5SBq83p/tIYxC1kK7LOI7K5svHiZbGAS2nABabUV35irwm8lulUu4wBt3dc6
	g5xZChGjFmjLR6jQXnPcZ0gHAtvHyFOSPrV7+PUnw4kYneUIVNlPtDwebjeRNMRk1qRjuaEGnLb
	LvrCNGcJJ31aGUnCPxXOdeMcP+jIO7s/ulywJxNS018tbu0hfwRM34Rk7NFUDoYeMj57NsvLaqC
	/1RsZEbMcPufoj/go1nBFSo7uAYjKIsu7p5yRO4xoeZKhX9F6wUe3lO48H0afc85WyC4P70tIk0
	my7zCjzJO2HUGNldxXnE1NKJMAFoUNA4=
X-Google-Smtp-Source: AGHT+IHT3XTc8/cQh1sfuiiz5HzOadFkcJ1uLdBn7TWZuheeMenxiZSw/KTPt6TYLMZ2C4ahDtTORg==
X-Received: by 2002:a05:600c:8883:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-453888abb62mr41014635e9.0.1750973039396;
        Thu, 26 Jun 2025 14:23:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:23:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v15 05/12] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Thu, 26 Jun 2025 23:23:04 +0200
Message-ID: <20250626212321.28114-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 Switch SoC. This SoC expose various
peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.

It does also support i2c and timers but those are not currently
supported/used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..a683db4f41d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch SoC
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 Switch is a SoC that expose various peripherals like an
+  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
+
+  It does also support i2c and timers but those are not currently
+  supported/used.
+
+properties:
+  compatible:
+    const: airoha,an8855
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+
+  efuse:
+    type: object
+    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
+    description: EFUSE exposed by the Airoha AN8855 SoC
+
+  ethernet-switch:
+    type: object
+    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
+    description: Switch exposed by the Airoha AN8855 SoC
+
+  mdio:
+    type: object
+    $ref: /schemas/net/airoha,an8855-mdio.yaml
+    description: MDIO exposed by the Airoha AN8855 SoC
+
+required:
+  - compatible
+  - reg
+  - mdio
+  - ethernet-switch
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        soc@1 {
+            compatible = "airoha,an8855";
+            reg = <1>;
+
+            reset-gpios = <&pio 39 0>;
+
+            efuse {
+                compatible = "airoha,an8855-efuse";
+
+                #nvmem-cell-cells = <0>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+                       reg = <0xc 0x4>;
+                    };
+
+                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                        reg = <0x10 0x4>;
+                    };
+
+                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                        reg = <0x14 0x4>;
+                    };
+
+                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+                       reg = <0x18 0x4>;
+                    };
+
+                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+                        reg = <0x1c 0x4>;
+                    };
+
+                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+                        reg = <0x20 0x4>;
+                    };
+
+                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+                       reg = <0x24 0x4>;
+                    };
+
+                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+                        reg = <0x28 0x4>;
+                    };
+                };
+            };
+
+            ethernet-switch {
+                compatible = "airoha,an8855-switch";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        label = "lan1";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy1>;
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        label = "lan2";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy2>;
+                    };
+
+                    port@5 {
+                        reg = <5>;
+                        label = "cpu";
+                        ethernet = <&gmac0>;
+                        phy-mode = "2500base-x";
+
+                        fixed-link {
+                            speed = <2500>;
+                            full-duplex;
+                            pause;
+                        };
+                    };
+                };
+            };
+
+            mdio {
+                compatible = "airoha,an8855-mdio";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy1: ethernet-phy@1 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <1>;
+
+                  nvmem-cells = <&shift_sel_port0_tx_a>,
+                      <&shift_sel_port0_tx_b>,
+                      <&shift_sel_port0_tx_c>,
+                      <&shift_sel_port0_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: ethernet-phy@2 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <2>;
+
+                  nvmem-cells = <&shift_sel_port1_tx_a>,
+                      <&shift_sel_port1_tx_b>,
+                      <&shift_sel_port1_tx_c>,
+                      <&shift_sel_port1_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+            };
+        };
+    };
-- 
2.48.1


