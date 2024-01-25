Return-Path: <netdev+bounces-65825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157283BDF9
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB89B1F30797
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DAA1BF2F;
	Thu, 25 Jan 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xcld3nvy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA981CA83
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176378; cv=none; b=pGw52TrBsggCnvZ0KDBfHP60cX76IK2J6PkHEqjGUD1mSa6ArvsNpcPaWRJ/fcFKzar4cdqRihYPzn9j1Sz8+fswNVwR1PG8Rim8CBxoO53K0WdN9VjG9Tfm6FmlUVn1w82ZSKAWKyI/koo2vWKsk+qcg+lFUpblP7D8nfSY/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176378; c=relaxed/simple;
	bh=PefNmkCfcSVC4S0CUVrYlmPMrAYPLQBq6k2kvGzezPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBkwH/EChgobI3zF+bChHor8zWS4sQlVmwo0Yj3FqQKdeKvb0kwSAIpUyYdUvBQ7Izcro8ExipaUJQh6Hnw8+SWnxbQfrLljAjbWtmhp3u06BvDeT9q5HKWUPUvsNE61wR0HtSliXK7NOHlwdubDpgqA/9roqsXpVVrdz37A2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xcld3nvy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so888448b3a.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176376; x=1706781176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7JPZ3FlmXtrPMvqbv7p+KV2yBKsdrHhwCB9rIMVdmU=;
        b=Xcld3nvy05xIEOxmLcZwG44XywG9RpZIZslznb+iXcOevlHPHtEi0E7WJ/LOdUET5v
         LdjD5j2iaXLb4YwQG8bEad3h3pqvzkbExz3lo41ewIM5d6fkE70LotfKLhJcJM1dnLFS
         5MLmD03kRt6jRX9xrHnUHpjBn26f+rahYwG8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176376; x=1706781176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7JPZ3FlmXtrPMvqbv7p+KV2yBKsdrHhwCB9rIMVdmU=;
        b=ZSpAyN4Gjzhbg7YipbJNgS5L8zk9rhyLDoSeETcY3TrotvEbYdGtY2cMwGi86jZU5g
         Ma1iFYAp+6hwtDilqouNPcy59mo+Ulprmif/OSiWsb15Aeg0Bh+cFAadUFnMPyxWapvn
         9WBTnWN09UORyr61/vr8sCK2orY/o6Mu3D+fu5ecJzAt7qYFoMFjUaSRtqUB1M8Q3uIM
         SeFvnqpE0Sir5kruEobrhXy006dcAtw7DCwev3p9gMI3uRFUcYFwzw2T3rcR8dWStseW
         LSSHcS7vD/840XyN2PdlQOVP9B5JoDQzZ34Udy1Cqc+JWAhBtYqK6keBlThg1GqOyiqT
         BghQ==
X-Gm-Message-State: AOJu0Yym0YTJBXnQHql0jjBbvSvydThsTLFefl4p4xloGVZUkdVdEbkU
	xaDrXGGOEvdVYLQ/dKPSw8v1k7H+DmGiX5MPUrj9jZj0EOmZuwhQkH6TG0bE6w==
X-Google-Smtp-Source: AGHT+IEetX9gohXpDSKXt8dCp+m9IbL4e2u1dfNizaAo86YunKve6EwV6wkGQJbqZzkz7JS3K+JigQ==
X-Received: by 2002:a62:c702:0:b0:6db:d17a:e3ca with SMTP id w2-20020a62c702000000b006dbd17ae3camr283889pfg.63.1706176376292;
        Thu, 25 Jan 2024 01:52:56 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:55 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
Date: Thu, 25 Jan 2024 17:52:37 +0800
Message-ID: <20240125095240.2308340-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125095240.2308340-1-wenst@chromium.org>
References: <20240125095240.2308340-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
SDIO. While the Bluetooth function is fully discoverable, the chip
has a pin that can reset just the Bluetooth side, as opposed to the
full chip. This needs to be described in the device tree.

Add a device tree binding for MT7921S Bluetooth over SDIO specifically
ot document the reset line.

Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
new file mode 100644
index 000000000000..bbe240e7cc40
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7921S Bluetooth
+
+description:
+  This binding describes the Bluetooth side of the SDIO-attached MT7921S
+  WiFi+Bluetooth combo chips. These chips are dual-radio chips supporting
+  WiFi and Bluetooth. Bluetooth works over SDIO just like WiFi. Bluetooth
+  has its own reset line, separate from WiFi, which can be used to reset
+  the Bluetooth core.
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7921s-bluetooth
+  reg:
+    const: 2
+
+  reset-gpios:
+    maxItems: 1
+    description: A GPIO line connected to the Bluetooth subsystem reset line.
+      Typically the W_DISABLE2# pin on M.2 E-key modules. If present this
+      shall be flagged as active low.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bluetooth@2 {
+            compatible = "mediatek,mt7921s-bluetooth";
+            reg = <2>;
+            reset-gpios = <&pio 8 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b64a64ca7916..662957146852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13657,6 +13657,7 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-bluetooth@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
 F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 F:	drivers/bluetooth/btmtkuart.c
 
-- 
2.43.0.429.g432eaa2c6b-goog


