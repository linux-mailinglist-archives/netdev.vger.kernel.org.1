Return-Path: <netdev+bounces-76843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C886F1E4
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 19:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A354DB23840
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5D37144;
	Sat,  2 Mar 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpT/7thF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82A2C695;
	Sat,  2 Mar 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404729; cv=none; b=sf6RTnM6WF4SvqtqsuoFomBZfosNrOmXPBt7Ca1wf2ulBB1/RnxBKrwOqewgEFVsvLJi2lM4kaBCwbznSQ4cLMUfLWG72p8ZUHDKo9XeLenl8uDGGvw2vd1JX6/iIOtDL0vEMkV5G/hdWkv+A3TX1oVOEPp0bwq+qCT8m4ukD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404729; c=relaxed/simple;
	bh=iPOtwCgQENo5R6dSb6I691mI3RiGq3IBiaR5DR9Uvq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRdr+PPlOiALMtUcQp7iRKTrKzCc/hsOcjn8We+jaC+SUtpP4HneO2YXCVKfuDlMP5FweiYGtbDzryPb9QjEqL9FeROvOLvfEtQ2w4jwEUtX0UJOszq9i0VEI5GHmDFro3J9jfsyI8flOfOTGW1fLHPlW9L49bt0Zo4QElW01Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpT/7thF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so5047760a12.0;
        Sat, 02 Mar 2024 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709404726; x=1710009526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1r9GtXpp87nA055yl7m2jzg8nZcGgHakpWwhF5+6+w=;
        b=LpT/7thFOPIGxMpiJIWsPMEmRuS2YPvfy0aUNtTyy4xnCwLs4bKwb61xLl3RQXg8eU
         Pt0ZSsjHgEL8HhAQtiLHQ9rMuyUV8CSqH99cbaHCdRlOV9HJDHmH3fMLl/3m+J+kAxxH
         O+s2Id+gtfZhPhkW10IbgbCrymyHQ66bXAdLjScKozJtJ4a/iu8Jh+wdInXyqvEco4WO
         CcEENQ1/ChUO7mgxSLHRgAsab5RbwbuvAv8w3+bQI/R1OQ+8SXRfw9S5hvkzC8RciMMM
         4uUEYOU2y+H+ZYZrKkWheAvXS0UPcPWnZ8gGe0MCJEUQGZ/2Td5hlBWyYolMajcIgl/w
         +T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709404726; x=1710009526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1r9GtXpp87nA055yl7m2jzg8nZcGgHakpWwhF5+6+w=;
        b=Scdr9Um7cjIauU1ifxCakkRmBKCGTdLTHwCqUqoF4lwWlBonakW+bYo6Zh53SD/EXC
         MhWKEju5ugqc1tbq67hdjfGpXWLD3Uzmyz9t/RTrkjaQQqRi0m3ZBs47HqN3mlDFul7g
         +kdmJ0/sNF0UaliCWzHqWNdH6uStKwqOAT9LFpOj1dXMvPaOcheuoBK0ObpzfWuKdpcW
         zWc+kGast/7IlqlHsDTPFmo8mXrWE55hFJG5V6VV0lBVFX4+6S/uKshKiDW5JtA8owSC
         Iac/rntauwiw1NHCya21kcvYAlF7JhlDM1NtG/7L4wh2vSZSbkN1wGU+9JcbeMLsOHQj
         YB1w==
X-Forwarded-Encrypted: i=1; AJvYcCW/knTz4Bq+MUh6gspl6gFEUmroviba1Zr0zFF1qtB+9aGO+ovR6a6IJF52Fy92wj9guvGl8B3IHkNFexA+lITMbuk1/lu1WyLkuw==
X-Gm-Message-State: AOJu0YyaUcDDLs59inqtfagksXJ4fuXGEwKLGjOuLWCNMWsQm1sCE2RK
	NNV7nlFafW9aaWECiQ4zz3i2Twz7XUooOclpsphilArL6/ZxOW3U
X-Google-Smtp-Source: AGHT+IEkYMGBBhhxBPOYEBqNtbMDgMBxv6eXWpRhqTi4pAQCp7Zs0GyauUYk10LO60UMb4c1qVjGtQ==
X-Received: by 2002:a05:6402:176b:b0:566:9437:c89c with SMTP id da11-20020a056402176b00b005669437c89cmr3714144edb.22.1709404726237;
        Sat, 02 Mar 2024 10:38:46 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056402530c00b0056452477a5esm2796676edb.24.2024.03.02.10.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 10:38:45 -0800 (PST)
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
Subject: [PATCH v2 net-next 1/2] dt-bindings: net: airoha,en8811h: Add en8811h
Date: Sat,  2 Mar 2024 19:38:34 +0100
Message-ID: <20240302183835.136036-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240302183835.136036-1-ericwouds@gmail.com>
References: <20240302183835.136036-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Airoha EN8811H 2.5 Gigabit PHY.

The en8811h phy can be set with serdes polarity reversed on rx and/or tx.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 .../bindings/net/airoha,en8811h.yaml          | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
new file mode 100644
index 000000000000..ecb5149ec6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
@@ -0,0 +1,56 @@
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
+  The Airoha EN8811H PHY has the ability to reverse polarity
+  on the lines to and/or from the MAC. It is reversed by
+  the booleans in the devicetree node of the phy.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id03a2.a411
+
+  reg:
+    maxItems: 1
+
+  airoha,pnswap-rx:
+    type: boolean
+    description:
+      Reverse rx polarity of the SERDES. This is the receiving
+      side of the lines from the MAC towards the EN881H.
+
+  airoha,pnswap-tx:
+    type: boolean
+    description:
+      Reverse tx polarity of SERDES. This is the transmitting
+      side of the lines from EN8811H towards the MAC.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id03a2.a411";
+            reg = <1>;
+            airoha,pnswap-rx;
+        };
+    };
-- 
2.42.1


