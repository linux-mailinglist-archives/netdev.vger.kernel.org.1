Return-Path: <netdev+bounces-173332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E204BA58617
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D431188DBD5
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242A1EB5E0;
	Sun,  9 Mar 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYTZdOiv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD141805A;
	Sun,  9 Mar 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541271; cv=none; b=pfYZnoqLbLnRyY+FszDyoNaD2dQzrj9HfMAe0YL1Bphd3bV5l+JxGX3a6TZWkmHkSmowMDP/wmcfPx67x8ZeuQcViudbYWopcuoo/L3jkNvJQrco5CkegXf9JPp2yjUKd/Le0zGP5DZ0a8neuHbNlW/FNUpo2WVz44TEU+5tKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541271; c=relaxed/simple;
	bh=qg2mTYzg7HIE7lMEvfsJOl5J/DhQkXww70M2Had8BVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9CUhxwOe3Vv2xBEuEyp90w9l9HULt65c5A2FHZ9+t/E5KCmw33ek3wZtZN71STTZ4ejnrv3jZJbn51Hi2Yqvqio9oyhTo0Uo+ntP8CruLWDt3m8XY27qDCItr4x8CTi3mI7eVa3ZCgK3CkL0ppiFgeGxifQeY7FR/mRR7YdYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYTZdOiv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f403edb4eso1842804f8f.3;
        Sun, 09 Mar 2025 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541268; x=1742146068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okDifKvdAt9bOzQUyi7HcNUDD0Vs7iNNXK17iMvuX8c=;
        b=eYTZdOivPsrS7ISqd4aNyORmSvouz30rd1XZG7hXIy/U9LWuwoex5JvkW9ibeyq0jG
         VtKUmFDccwV7Koq87g41WBvhDWK+oWEvSjcgAfxKV8FCz0NzsCkU7sxk1sSnMiTt5wQ6
         wfX4l9NpSh5GShk/MF/peYBSDL+cp0H3+RHq3Zgp+p88yKgsyA9WiCgcUsEaeMgo7hOp
         9xU7kMMjrZwEmM8DuENBkSOSRuuw1lBNaAr7D8aXfXEIQbhPJVsBVTDzJ0MtGszyDJN6
         +QWv3IzAVLYNVvPxHQWSbeuCgOn5xCn0T95ZKXZnX7BFlANwtQ7nxL++hYP92APHmACo
         t0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541268; x=1742146068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okDifKvdAt9bOzQUyi7HcNUDD0Vs7iNNXK17iMvuX8c=;
        b=SRq2pUHuGqWtFf/Z21lMWiGprYc1Egfmxq6t8S1+A4AVj1BS8k0KFBZ747tNYRZaJr
         Gy48QKXN28C42dVhe5+svQoZlnpxvI85j+/5qEAB6pY0MG/4CVFAj8430rCRinxGlKbV
         AoCSxJzuXfQTbeNBfdfSmWkjSQzmDHpStDzYM6X+1UVuK9zTHPqNn5xclK+GC/TGENDM
         e7OeZA6FiL13a5tCVlXgGUM60eG0Q6UiVZsOST7/W6GllZLKQoVbMXSt4bH+fUGXJdqD
         hJEcsMa3GbxtF1xAbvLy9J+e+NG0Jqa9aEJM6uaL9Vw6AOgsduG6hy2qoDz2jwbqInUb
         OeuA==
X-Forwarded-Encrypted: i=1; AJvYcCUjS7WmSqCQDFrfTHZvXeFVEd46tT1LmzxnK5jLnqFUwQb30Pi/3A7gT7P+3hL9b4FuJkEzP71pcMBZMu7/@vger.kernel.org, AJvYcCWRg7iQBqlwmhYHNKpFy23xVlZ0jbsIVCky5Af7kAtvkEsiGMbwO413/hXs4hUTvAgrwDIAEJtPU5LH@vger.kernel.org, AJvYcCX0lkeRw1IalnUb7SjTS4ufYlp97NbZYkIs1058+rHaPhGtFAv/7rFqEY/u2314saLnONzSX10t@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6HNhR3+sIjQ5dVFuMeEDi2vEF2GhG66x4KLQOSENPiQ9TCEi
	R/tsViTTdtk5OE9Xse/ytbWShq3xMr1omyVxW/xqNQ19YGx+uF7S
X-Gm-Gg: ASbGncutEOMN3uEd02HA+mi+BCEMPwEOTKH7W8ed90YDAcJQOplETC2yNCaCpGR6Cpf
	NRSRJ3PU5BvoXWl5UUGy/G/8oR/7LgxLkE9dgu59MKPWl98IYZLbHv36lX26PdVXHG31q8cjKsW
	OPVcuZOVLxaTYP3riOYaQwktOQ7rhR9IgOAeCm3IYRaDykr1ZtvrAIbKElbnUZ77ytMeqGwdLc6
	K/2XNdSzR1Hsx7sV5ffAPYRqwR/nemlxG60s19uYq/riiHaW5JHGemLUDMnewVJMBemp+OuvQMI
	UknwfHshv7YV+8P/BqaQAcxzPXZvLvgjg10w0fK2mhvYgjBYjkNWQFCoSP8mDzuzt2gMMKftFxy
	TSIqT9MmbqoQgQg==
X-Google-Smtp-Source: AGHT+IGWlC28v+QZNJ/lgbeulo94q0WWAcwt9VPHBXhNsULzurzzBKih+g2tRLnY8qpeBrgFYYflTg==
X-Received: by 2002:a5d:6d8c:0:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-39132d16d69mr6047613f8f.5.1741541268141;
        Sun, 09 Mar 2025 10:27:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 01/13] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Sun,  9 Mar 2025 18:26:46 +0100
Message-ID: <20250309172717.9067-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
index ffbcd072fb14..576fa7eb7b55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -719,6 +719,14 @@ S:	Supported
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
2.48.1


