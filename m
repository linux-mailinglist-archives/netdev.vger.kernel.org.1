Return-Path: <netdev+bounces-69628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF884BE4B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1FB1C20B3B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075F17997;
	Tue,  6 Feb 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM13XXhs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84317732;
	Tue,  6 Feb 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248884; cv=none; b=RO8jslA1xQwbpZmVAaAEjSuvPsl52yuFHSFSl5jjXUimGkUx+m/+05x40V3SqSqdXTX/o3ByJlGxgmQcIUcTUJqHfuGqeOJcBan7WK+4XAf/l6SmnNfmmCdZC+MYKjYwl0/ZGg6Z+A6mZO9BGAAnLC/2C2RzF4NOphKJzFhWo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248884; c=relaxed/simple;
	bh=x2MdhysimRENxyjPQHQdx2JbTpOa46tSc8/8WlNEpls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouF3lFUEDRoHlHV1PvFHp80ToVHjPW/PunY15qBRGnyS4Rb4ZrE946UT1bI2S3cKASnU1oBGRVV5MxGa1kwPLVudv38SOA+dGdRCh812hUyDITFmBgr+NpyM04zpI9e5Ru938n8WYmPi/H2+A4Zb2pNU4tB1rv7ZV0Bv2aJzQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM13XXhs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3850ce741bso44291366b.3;
        Tue, 06 Feb 2024 11:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707248881; x=1707853681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/DvP+G5piodo/QeKyAlZmL/zZmPWMJigSGfpjLwzmU=;
        b=QM13XXhsEx92LtNxDW0keuN7KDOUeGwPhNd+LqgA3aB6e72tcMyvRlL462AOW9gL4k
         7BbUCQD1bQ6PmdHDMbjUymzp5Kxy4ns594zWqQMweB1F7kWDJJONKlu7IoCdKHhjY1In
         Y4PWooXzqZGz3pBK3+CRWKnLjwjAcD46WtH9OU8uNr9KdFao7hbPnqGcVVFxK7DF35Z8
         co/IpNUDxZc3qqWKqm7CXuAN+a23Uw6mY+v13e1PZ7JYcoZUxlXQiX7J9VTxIRv3WOCh
         aexcbGWkwsxp+AgkvDN2RnJ4YT5MBXlzGOiLkHrUHEzr/yg0GLkVAIHfzrBjXnAmepSo
         DUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707248881; x=1707853681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/DvP+G5piodo/QeKyAlZmL/zZmPWMJigSGfpjLwzmU=;
        b=CoBvbJF8Ah1F07ltAaKmUa06Aufb085JJkXNcyB4JuX3DLjRO7M+v7H0eMi953HB6L
         hbAGjn66vgsuq5FUMk5QjyhliS9fwPBEpVRaa9PrAH+U6kGyd9Z+eP48E7i6EaF059sr
         ikMflFGWckOl0CYAijr48bqCeOlkmnlwl9nPiwoWn3VY6Sj4rmH9ZhThUwWTOlTKGJ8q
         /qRAJb1er7/YYuAsaURsOMhK6R1BPaPXyIB1anI6rMKiTeTjKDKcPwOnh4HkQxGG0Nzq
         EWcW/UJXYyuFumSX48CGvr0QaF8lDQVsso7nnITP45xySpzwPJtt72RGRelarJ6qSV2h
         NAkQ==
X-Gm-Message-State: AOJu0YzgJv9HFlo0acHJBTctl/nhXfiU4zVQVHRhOpCGSIxJeelr5Fla
	yCUtHXGVAH01hbxeKi4FYEME86ymx5FOAaXzcrGLDREuS2vYxU6QiPlvPLzCtK0=
X-Google-Smtp-Source: AGHT+IGoWnMv7SeumUMb+2VrQJkLp2YnDEEWOaoOOZ+v6qqNGg8K9Ox1suDLMmgZddT+6uNZailAPA==
X-Received: by 2002:a17:906:185:b0:a34:a6af:22f1 with SMTP id 5-20020a170906018500b00a34a6af22f1mr2353097ejb.62.1707248881010;
        Tue, 06 Feb 2024 11:48:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCR6+j//Rky8k2bai/an7iaiHTHfa4QUpK17Tx3sIU7ksl+Nb6N5kaXPmAQSbDLzwJ9CirOBpfT8pqzZdWJOPpNy/9e6/yCSsFoJUDYuN00eyRdG1KwvxgasbomLfAazfdoL0vUzfpjaMt754pI4RcC8e9K+2nzrzfqtOrrvdpjzbIlcS6y0WEkCCBruwFwHoLFzIEFvjGOBQbI5dufHZFj9tdQoj/z25VmNbXz25dfX4D+72b+d6ZsW9GpdJoB8wmP3s4wl0Iool92MpUBjPawkMpgn+CR8bo0ejHSynXEBKQyWmpIjC3Lh/42bd80TZjRFoVY/ZQBThCEm35GxKe2fWE7fHFzWWk8bl/Pu5Wip167i+3vjxapGt0f9XG7kw32b/7sWr0dudqxoKPhudu1r7l34aESsuJyeoBFgntz09/Qi0swBpkPM0QDbQKIRYhwHBTZPwJLgeoOiF4AJfm9HUCREBgBPte3P7r7ehERiOu6lYvZscvyulH8JcJEDyssaqbNNHEUPLv48b63T3GJ5y1v2V2nRPIqja7y6Xk3ZEGDy09KrzP1PYZNQia4E9gAPwG3Od09/aB+Du0Tl3Lcd9M
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a379be71a84sm1476767ejb.219.2024.02.06.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 11:48:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng  <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: airoha,en8811h: Add en8811h serdes polarity
Date: Tue,  6 Feb 2024 20:47:50 +0100
Message-ID: <20240206194751.1901802-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240206194751.1901802-1-ericwouds@gmail.com>
References: <20240206194751.1901802-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The en8811h phy can be set with serdes polarity reversed on rx and/or tx.

Changed from rfc patch:

Explicitly say what -rx and -tx means.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 .../bindings/net/airoha,en8811h.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
new file mode 100644
index 000000000000..99898e2bed64
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en8811h.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN8811H PHY
+
+maintainers:
+  - Eric Woudstra <ericwouds@gmail.com>
+
+description:
+  Bindings for Airoha EN8811H PHY
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  airoha,pnswap-rx:
+    type: boolean
+    description:
+      Reverse rx polarity of the SERDES. This is the receiving
+      side of the lines from the MAC towards the EN881H.
+
+
+  airoha,pnswap-tx:
+    type: boolean
+    description:
+      Reverse tx polarity of SERDES. This is the transmitting
+      side of the lines from EN8811H towards the MAC.
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethphy1: ethernet-phy@1 {
+                reg = <1>;
+                airoha,pnswap-rx;
+        };
+    };
-- 
2.42.1


