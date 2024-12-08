Return-Path: <netdev+bounces-149932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBB9E82D5
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22CA188480C
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577B208D7;
	Sun,  8 Dec 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxUUxcnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0C18035;
	Sun,  8 Dec 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617309; cv=none; b=jB8afcX3XsHrQKTHl+hpVVgw0RpQhUUOESiHhF9Z/0NoeVh8iGcfR7IxPMvt/oMYnswFJ7Fi0rpQ6B/5vj7kuzGXM3FWC36yTFS1qNSlLl8Gn/E8g/5hTUciT3sVeFTXNBEdRr0uJOsDQMCBOHZM+DR8RkKxGwQK+htfILpPQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617309; c=relaxed/simple;
	bh=AtHYKjUNCXGN4arNbRgbhdaOcvUPYDQYU+Kwb7jBhsM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhVMRdIuFAXZUueG1NStQVax9eVMdNMvY3Pq7Nw045Io18vg6B3+0a/Mijwa5kZHKLfaA3n92hr47Gs/kZA9bKMcshmnTYhVBFaNagu+LmwNAbVDz0sphseB7+/9TOgHaqqNP217qU1Ib//HpSy2xAqcXYXp7AbVyLekcmFT+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxUUxcnN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e2880606so2692644f8f.3;
        Sat, 07 Dec 2024 16:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617306; x=1734222106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyu3ehXETXIiFtVp5aryqXyxocs+xknXfqTCPmSqxIs=;
        b=DxUUxcnNnwbugTHJybXj7QxFTwp5X+vPqXH7aVn4YojDf21h4cvwyN4qofjFSIByzH
         dqb7ztgjJmZsUX5T2d63CtKhlwq4hpAdBufWCbbKj2tQzDRimrbFS9wgrxkYqNltza1R
         94ycnCjcVpPhkXYOdnfJchbvB2Wvx9aQqco5hNewYcqNLDrTYnbIjRUo/VwMXQQ9a8mq
         exEevFmdEewFTxlMOm+0GCc3YJ7jXoIy0D+AueE9EeDynkkkiov2RFSpMRssDSYuKkgr
         EuJjVne60wR5s3cSQ/C3prYfWkV373DAxBRAhuI0fBOlU5qF695rQwpQZSTAYN/Q9ye1
         /M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617306; x=1734222106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyu3ehXETXIiFtVp5aryqXyxocs+xknXfqTCPmSqxIs=;
        b=XydXn7Hw25YrHPoElHjkcUtS5XA0IvJiPWpnaP9aTz7TxXweNINJFwrqVNna8G7lUO
         qTfJcIvGCDrpmeYUH0ev8cSr5fimDZPOKbnoS9NMdY9UR3ztJ774DTHHYm8hZrMua324
         mJqaQnwgyJNiv0NoYDqF2iyETGcssmXGl9EWzNSni3rrzcCQ7utTvMQYscGJNdmB7Wg+
         i8LTC6APavtj5ZKM0WUPG+kixcNDOAZrJuzY+RaSpKIiQFTmwCxbBSeqfW4gNeC9L4XW
         9yMPH0L+2y7ZA7PdPGf0EViwCd4tfYrEeJHvbodwtE42VXRf+wszkgyvWlW+Pf3vkZz4
         o6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU4EMoJmtc97OrFilNDtIjjx2PtveKRQRXGGROg2g8SKx94nK8BYBSb7e5zj6ROAx9Ex2ipV0Kaw1ucOKt2@vger.kernel.org, AJvYcCVRr3PfQVlYEacXVmwx1P8cpSAGBoFU4YpgRyp2u3xiWIChlceR17hwGN0uKIRdL1uFAHXxKr1y24+B@vger.kernel.org, AJvYcCVit27VQuUh3CHfRqv6tUr4KLT6H39CEokfJFilcF6QjNSgduGFMuGfmImSzT/+SJtPlH+K9nXp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ePBxE0eqV8oemnOmVu8y8CjaBGgjXhcU7+Dt+iAIdYgzmkuy
	g3Injn2cpGIRWHpi1jhKKiY7uIY14BfsHhbiPxqXp+MickmZqLZh
X-Gm-Gg: ASbGncs8YfANyCe/LQjsCuz/FNSF5vf9IY1CFamfeWbCK4E9qfVTd/FwwOlDFJObPtA
	RJS87plvyIbjTHQMl0iOksigZXv/Hrvpx0NytIvgkEXvjyNBQSjHGAd3wc2pgm73m/tb0TEAODd
	DjmncQt1pzGyayjxfySH+w7U5TzfyyRNIx+AaE3hCoaxXq62r92GfoQTl2w7lDJaVepLZhHkn5C
	ULShr7plJrQ5wyJX/fpBNr1Jx2j7FKpELpo3o5X/Znyf4xY4TMxD89wYo7Pkunvz1VgN1QALe8w
	5OQtrcvU381dhPVpJR4=
X-Google-Smtp-Source: AGHT+IF6AJvvhgXizcyh7QS6Bt3PlWzOx0dC0lYX/21wuSbaG7h0JBOcjFmtUcYE5mCPGg4Q6lkAPg==
X-Received: by 2002:a5d:64c6:0:b0:386:3213:5ba1 with SMTP id ffacd0b85a97d-38632136075mr4118225f8f.24.1733617305885;
        Sat, 07 Dec 2024 16:21:45 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:44 -0800 (PST)
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
Subject: [net-next PATCH v10 2/9] dt-bindings: net: Document support for Airoha AN8855 Switch Virtual MDIO
Date: Sun,  8 Dec 2024 01:20:37 +0100
Message-ID: <20241208002105.18074-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208002105.18074-1-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 Virtual MDIO Passtrough. This is needed
as AN8855 require special handling as the same address on the MDIO bus is
shared for both Switch and PHY and special handling for the page
configuration is needed to switch accessing to Switch address space
or PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/airoha,an8855-mdio.yaml      | 86 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
new file mode 100644
index 000000000000..2211df3cc3b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 MDIO Passtrough
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 Virtual MDIO Passtrough. This is needed as AN8855
+  require special handling as the same address on the MDIO bus is
+  shared for both Switch and PHY and special handling for the page
+  configuration is needed to switch accessing to Switch address space
+  or PHY.
+
+$ref: /schemas/net/mdio.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-mdio
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        compatible = "airoha,an8855-mdio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        internal_phy1: phy@1 {
+            reg = <1>;
+
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                <&shift_sel_port0_tx_b>,
+                <&shift_sel_port0_tx_c>,
+                <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+
+        internal_phy2: phy@2 {
+            reg = <2>;
+
+            nvmem-cells = <&shift_sel_port1_tx_a>,
+                <&shift_sel_port1_tx_b>,
+                <&shift_sel_port1_tx_c>,
+                <&shift_sel_port1_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+
+        internal_phy3: phy@3 {
+            reg = <3>;
+
+            nvmem-cells = <&shift_sel_port2_tx_a>,
+                <&shift_sel_port2_tx_b>,
+                <&shift_sel_port2_tx_c>,
+                <&shift_sel_port2_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+
+        internal_phy4: phy@4 {
+            reg = <4>;
+
+            nvmem-cells = <&shift_sel_port3_tx_a>,
+                <&shift_sel_port3_tx_b>,
+                <&shift_sel_port3_tx_c>,
+                <&shift_sel_port3_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+
+        internal_phy5: phy@5 {
+            reg = <5>;
+
+            nvmem-cells = <&shift_sel_port4_tx_a>,
+                <&shift_sel_port4_tx_b>,
+                <&shift_sel_port4_tx_c>,
+                <&shift_sel_port4_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 53ef66eef473..e3569fe5f3de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -717,6 +717,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.45.2


