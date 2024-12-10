Return-Path: <netdev+bounces-150632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6A9EB06A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5DE1889C78
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310611A0BC9;
	Tue, 10 Dec 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIYKa7D9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889019D899;
	Tue, 10 Dec 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832291; cv=none; b=unknrnsd/W7AVzGXUAt0bJryHN596y1LzdtctAb/pd1x7Q1XICu68CWa/6jrCOkj4UswpSQ9Tn6GBAk8TcbxU5UWyyi8LRfMKtZMC3MmqOfu/NIs14gm9S9ChB+qyY4J/GxfEZwz9xJthSqvkJ32uBpukzdznLFpP0H/wztTv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832291; c=relaxed/simple;
	bh=4Q6CsvGPnuH0ETC75y3qRAUwZ44hv95JrCnAXeuNh7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixuMDaO2wuddGpIF9bgL4XhvxWwyETvQe3zc1EN22UxiAZIDH86u/ZSDy+E9NU8Z7RBRNexXxPqj7wDl3NLeiM9VcvNUiAnA5ukKjdAM2Gz0G7QBbmUTbO4iCPQxmcpY7/T3tHYcH0mBxT7ZblFjsm3AFqDwKrYG8ij7IHv/nmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIYKa7D9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so23948565e9.3;
        Tue, 10 Dec 2024 04:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733832287; x=1734437087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgudF5Nx9tpuAdpAJYzbdPOGbyZ+TN1kZnvYR7ObIaM=;
        b=eIYKa7D9qgywAuz9eK4LqJlmDHSq3IXlYicxiZbxe6MblbSs2gSeYjI4+EzsoMv6z4
         +rZ0xoSE+UfPT8Wamv8yr/mqmB6NFB3FRDaL1SuJU4iN7RN4AOxhjLiw4Gn8zcmGT60m
         xp8mhzPgpF/AYOyDmfPR/PE8rNsWgPGL4cyMQX7zRcb0rvQNW61mkLg+83jK4ukYkrb0
         /qF9WQN69e6f9Fxk9Zq7BnJBXdYekWDPvlagg9ZKdIPy12D0uTda0+z31U9bzpLRyOeV
         ygShpQc5fkyBqGUVZVdPlcJxOoL18xeunJhq3F52e7xz0wIY7wOJLkeurV7lXmhmNcEi
         aiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832287; x=1734437087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgudF5Nx9tpuAdpAJYzbdPOGbyZ+TN1kZnvYR7ObIaM=;
        b=OkTXzqZboo9XOjxz7c3dAAUglLFF8TGcnZQ07hzMLoX2HfZB8jaBBOd0MyixORD+b/
         ouTD5kRlpGW1J0xOetxwra/70/QBsR2oXP+Gdj1RfXFrkhebhX+T0H+EP3r88yrG/+/G
         UMyIE5Klci1uKnmCbZ5f5yTJKhYdEflp9MhJY+7YfB+rWlegBn6tiT/cYmLg55DyqA+V
         6x8pvAuYwymACbnUOJgp5RLTRk6QmvwXac0saSnbBk7rzLUCtKkr9u3TAeKmv9XxIVSf
         4w90+frUjaWtMIt6IdMZtuokC6SuvQT6BvGstxoHKpmfRKvfAuhBkPWIoQzDAGb5+K0L
         72ag==
X-Gm-Message-State: AOJu0YzMwUmRuVs7mSojhO2B2ZjcIpCkEBgs8uXFwxF7Mmg7GC8SdJkG
	t/qx4tX8b7BjmMzXiK4V5FgdWMoFKa0ThvRaJUbxNnqjQ7ZZkf2HUjmRXZJxXfs=
X-Gm-Gg: ASbGncuZcttpU9Lds2Q0A75ujnHvaZ0aJUlVcjWvV4wPsW3eTVytxJZoVMBID0NTsgQ
	BOkANlplhic6K2bCzYR4AP+Y9YeT6DqvDN3QXWwjW288bPMK/qyo4elZR4zB0kSL77enYWHPrfx
	2j5T1ealChnZjGNKVQddGk+QekTh5jbMhM80J/bEpJcBA1Nhw9fGh6s/xgUNMQ1oOCeLpycfGXx
	70Hv+xmP+EqWobQHFwZu9Bt7qfP4x9N7N5UoalAZKsfD6KP3dWdbQTympCRBxjI+SF91NtlXNIw
	AEM0Bw==
X-Google-Smtp-Source: AGHT+IHWwg6YQFgOL9tD0hIZDaWPodDDLRhw7DPHwkp+hTU/M+qtNI2/McfM6WSn2Tr3AiWKBqNBBA==
X-Received: by 2002:a5d:59ae:0:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-386453da219mr4093626f8f.22.1733832287115;
        Tue, 10 Dec 2024 04:04:47 -0800 (PST)
Received: from KJKCLT3928.esterline.net ([144.178.111.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862a9705dfsm13446132f8f.4.2024.12.10.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:04:46 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Improve example to a working one
Date: Tue, 10 Dec 2024 13:04:43 +0100
Message-Id: <20241210120443.1813-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the example will not work when implemented as-is as there are
some properties and nodes missing.
- Define two eth ports, one for each switch for clarity.
- Add mandatory dsa,member properties as it's a dual switch setup example.
- Add the mdio node for each switch and define the PHYs under it.
- Add a phy-mode and phy-handle to each port otherwise they won't come up.
- Add a mac-address property, without this the port does not come up, in
the example all 0 is used so the port replicates MAC from the CPU port

Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
 .../bindings/net/dsa/microchip,ksz.yaml       | 89 +++++++++++++++++--
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 62ca63e8a26f..a08ec0fd01fa 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -145,13 +145,19 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
-    // Ethernet switch connected via SPI to the host, CPU port wired to eth0:
+    // Ethernet switches connected via SPI to the host, CPU ports wired to eth0 and eth1:
     eth0 {
         fixed-link {
             speed = <1000>;
             full-duplex;
         };
     };
+    eth1 {
+        fixed-link {
+            speed = <1000>;
+            full-duplex;
+        };
+    };
 
     spi {
         #address-cells = <1>;
@@ -167,28 +173,46 @@ examples:
 
             spi-max-frequency = <44000000>;
 
+            dsa,member = <0 0>;
+
             ethernet-ports {
                 #address-cells = <1>;
                 #size-cells = <0>;
                 port@0 {
                     reg = <0>;
                     label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&switch0_phy0>;
+                    // The MAC is duplicated from the CPU port when all 0
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@1 {
                     reg = <1>;
                     label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&switch0_phy1>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@2 {
                     reg = <2>;
                     label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&switch0_phy2>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@3 {
                     reg = <3>;
                     label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&switch0_phy3>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@4 {
                     reg = <4>;
                     label = "lan5";
+                    phy-mode = "internal";
+                    phy-handle = <&switch0_phy4>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@5 {
                     reg = <5>;
@@ -201,6 +225,27 @@ examples:
                     };
                 };
             };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switch0_phy0: ethernet-phy@0 {
+                    reg = <0>;
+                };
+                switch0_phy1: ethernet-phy@1 {
+                  reg = <1>;
+                };
+                switch0_phy2: ethernet-phy@2 {
+                  reg = <2>;
+                };
+                switch0_phy3: ethernet-phy@3 {
+                  reg = <3>;
+                };
+                switch0_phy4: ethernet-phy@4 {
+                  reg = <4>;
+                };
+            };
         };
 
         ksz8565: switch@1 {
@@ -209,28 +254,42 @@ examples:
 
             spi-max-frequency = <44000000>;
 
+            dsa,member = <1 0>;
+
             ethernet-ports {
                 #address-cells = <1>;
                 #size-cells = <0>;
                 port@0 {
                     reg = <0>;
-                    label = "lan1";
+                    label = "lan6";
+                    phy-mode = "internal";
+                    phy-handle = <&switch1_phy0>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@1 {
                     reg = <1>;
-                    label = "lan2";
+                    label = "lan7";
+                    phy-mode = "internal";
+                    phy-handle = <&switch1_phy1>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@2 {
                     reg = <2>;
-                    label = "lan3";
+                    label = "lan8";
+                    phy-mode = "internal";
+                    phy-handle = <&switch1_phy2>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@3 {
                     reg = <3>;
-                    label = "lan4";
+                    label = "lan9";
+                    phy-mode = "internal";
+                    phy-handle = <&switch1_phy3>;
+                    mac-address = [00 00 00 00 00 00];
                 };
                 port@6 {
                     reg = <6>;
-                    ethernet = <&eth0>;
+                    ethernet = <&eth1>;
                     phy-mode = "rgmii";
 
                     fixed-link {
@@ -239,6 +298,24 @@ examples:
                     };
                 };
             };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switch1_phy0: ethernet-phy@0 {
+                    reg = <0>;
+                };
+                switch1_phy1: ethernet-phy@1 {
+                  reg = <1>;
+                };
+                switch1_phy2: ethernet-phy@2 {
+                  reg = <2>;
+                };
+                switch1_phy3: ethernet-phy@3 {
+                  reg = <3>;
+                };
+            };
         };
     };
 ...
-- 
2.34.1


