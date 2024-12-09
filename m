Return-Path: <netdev+bounces-150206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A79E9797
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B72C28264E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87331A23AC;
	Mon,  9 Dec 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HogcORhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720C233159;
	Mon,  9 Dec 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751944; cv=none; b=QPwDUjdJhsMbRsL2kK1nt+hHLZ8oNsztsXecS2haFU/StdfXG3RvqMEMROjscVkrsvdQ3UJkq7LktBpkpypXza6i9voI0WKGZpwHbYHYJaBKIUxTQn5R6tmbOEbZcfNVpnzAGl8ZbTjSMv2Fp1U2nI+0tdyusNRBjhr6dssCmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751944; c=relaxed/simple;
	bh=ufjuYZgodWyMgL8tPolzg4NHI/MynPCKZW/D/mNtnNo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQzdpW6Q/KtVhhIOxbMU9LiHBrCxH4WLPL9HFm89UdsaGKX6T4K3JRvRkF3POZxvWFHVaHqDolbFSL1mxHKkbhd43xphqdbPBiCd+0Y/G16vCdE/36ja+2DKqtioxVXWvU0XvJNqJ4Vy0RK6b61/7shJSB9JT5qsCiwQl6hJHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HogcORhf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso42681855e9.2;
        Mon, 09 Dec 2024 05:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751941; x=1734356741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijn5hxrkaTVmMCGK2s49Fof0nRp2zbU7nwPzckeCES8=;
        b=HogcORhfEoR0uJ5npcRoEipR1VAjez0eg/4SFIzoxr5yEbjHnFWG+K5MPIMHCMEmkx
         VguN0HxbQOqlxv2OlONVYiX9HkhGUqouaKQ/CDpBROiDQ162WETV2G1DGsy9ve6Ok4Qc
         lHbDBkZNb0XrNBud59mtpsMkVgZVgqEZH4JK2t1ecDKO92wO0jp4bT1HWJhOd3y58x+7
         j28Y4FiNKQwHLR7cSOCWvTDXFK4BcSRHt+Nvfg3JeBBCsNnFEIDoVWug0FySznrMcrdJ
         ZblIMa23eqwYvuXtwtCp1cVCjiDSyupZRMkyaFt0fLsSVOOOhO+v37nEw+x+7g3aYrMB
         rkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751941; x=1734356741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijn5hxrkaTVmMCGK2s49Fof0nRp2zbU7nwPzckeCES8=;
        b=Fnf3dJiOB0nhgK7RNJlQdmPnAi4ms26f0gzLApqWNSZ6wB1NpL/3afITLW9VzEKQSC
         1JzTNgzwIqnDFhZNqWLMtgLD+2awt56VY17odo5kiudr4n00FHh/kCamqtd+bgZ5jipY
         oAy5CTtOeOisGbeJuxRkPCVy0itP00WwGSL8VJt8T5zR+RwIhnGU1EQtaAdhyODT/tQ1
         2dq8XavAjjQIg1c1woHyiwfAX1SVjz9bu0V50LbV2gSkQMCWjdeSZROQZz41tEP+zuET
         MRJQKBWgFH8omr6baG12Cj6tUo+/HTdE0Vzn8jcgxNuoSGh+f9kSghyP2rBJVrmq/fuu
         7rTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJeDoUZWdXjO+/eqNd9xN5rDq7adqKHIJxaml7X2wMqZsNR/KKqURizUY9eV/0wvPc1c76nPc22VI1@vger.kernel.org, AJvYcCXVDzC2X0u3bCPEZawPSb0DDspF4Z/ma112ATXzmmccAE/0a47U+30Hrb9VHMGxmN9UnPK7bam/@vger.kernel.org, AJvYcCXq6MnzRWwFJBz5pK3pC3phinuVn1MKwL2HP+/WQ1+ubKZ4rp0pUBBj5F/cP7frT3y3pYR+K69j45Re5CqP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8o/btd2zrfuMd95ihUZuAq7EwI3kW6S7zBpCFp+Rr6gibdJPs
	ff+oS+PZYWqpTx7QkPRnT4IdIDSW62FUulBAQgpFQfh1kvaUZxUr
X-Gm-Gg: ASbGnctjFu5Y8hXzliW+p0mzWy5MSp8b8TZsqnPFJHmSW9YxDvmOFxU4oQbUjP15Mdi
	emYNW8Ott7g8I/E6riDNW0zUdMlDwOCtV5UojuXCxV3h2FZ8bGH1e9iMYfKWgu8g1N5fz3dLRJ+
	pAn+iw9J5pVEso+314wYANxRqDsRgq4TlqQ8DPPF9yxtqlKyS9Fwni2G7V/AYDS+rbneZZNk9MA
	c+m09920xDzUE/8KleEk2Fdj4FWHFJsMB0/Krps/AmuN4Vqfm3KwtgNwqb/1ejzKl4FRRNO6x1w
	ctkkDcG3jsbrC6NgwrU=
X-Google-Smtp-Source: AGHT+IGWqj5/Oh5M7zFpGJF+yqoShftiCGH6zZImg0D9CX8FZjiXi5JfZ9Wc/Ter+fABZOmFM5Yrlw==
X-Received: by 2002:a05:600c:b94:b0:434:f753:600f with SMTP id 5b1f17b1804b1-434fff502fcmr5087855e9.19.1733751940844;
        Mon, 09 Dec 2024 05:45:40 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:40 -0800 (PST)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v11 1/9] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Mon,  9 Dec 2024 14:44:18 +0100
Message-ID: <20241209134459.27110-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 Switch EFUSE used to calibrate
internal PHYs and store additional configuration info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/nvmem/airoha,an8855-efuse.yaml   | 123 ++++++++++++++++++
 MAINTAINERS                                   |   8 ++
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml b/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
new file mode 100644
index 000000000000..9802d9ea2176
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch EFUSE
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 EFUSE used to calibrate internal PHYs and store additional
+  configuration info.
+
+$ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-efuse
+
+  '#nvmem-cell-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#nvmem-cell-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse {
+        compatible = "airoha,an8855-efuse";
+
+        #nvmem-cell-cells = <0>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+               reg = <0xc 0x4>;
+            };
+
+            shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                reg = <0x10 0x4>;
+            };
+
+            shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                reg = <0x14 0x4>;
+            };
+
+            shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+               reg = <0x18 0x4>;
+            };
+
+            shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+               reg = <0x1c 0x4>;
+            };
+
+            shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+               reg = <0x20 0x4>;
+            };
+
+            shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+               reg = <0x24 0x4>;
+            };
+
+            shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+               reg = <0x28 0x4>;
+            };
+
+            shift_sel_port2_tx_a: shift-sel-port2-tx-a@2c {
+                reg = <0x2c 0x4>;
+            };
+
+            shift_sel_port2_tx_b: shift-sel-port2-tx-b@30 {
+                reg = <0x30 0x4>;
+            };
+
+            shift_sel_port2_tx_c: shift-sel-port2-tx-c@34 {
+                reg = <0x34 0x4>;
+            };
+
+            shift_sel_port2_tx_d: shift-sel-port2-tx-d@38 {
+                reg = <0x38 0x4>;
+            };
+
+            shift_sel_port3_tx_a: shift-sel-port3-tx-a@4c {
+                reg = <0x4c 0x4>;
+            };
+
+            shift_sel_port3_tx_b: shift-sel-port3-tx-b@50 {
+                reg = <0x50 0x4>;
+            };
+
+            shift_sel_port3_tx_c: shift-sel-port3-tx-c@54 {
+               reg = <0x54 0x4>;
+            };
+
+            shift_sel_port3_tx_d: shift-sel-port3-tx-d@58 {
+               reg = <0x58 0x4>;
+            };
+
+            shift_sel_port4_tx_a: shift-sel-port4-tx-a@5c {
+                reg = <0x5c 0x4>;
+            };
+
+            shift_sel_port4_tx_b: shift-sel-port4-tx-b@60 {
+                reg = <0x60 0x4>;
+            };
+
+            shift_sel_port4_tx_c: shift-sel-port4-tx-c@64 {
+                reg = <0x64 0x4>;
+            };
+
+            shift_sel_port4_tx_d: shift-sel-port4-tx-d@68 {
+                reg = <0x68 0x4>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 79756f2100e0..53ef66eef473 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -711,6 +711,14 @@ S:	Supported
 F:	fs/aio.c
 F:	include/linux/*aio*.h
 
+AIROHA DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.45.2


