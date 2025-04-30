Return-Path: <netdev+bounces-187039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC0AA4913
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CA217DE42
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A979238C1B;
	Wed, 30 Apr 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxEx+Oe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5A2B9A9;
	Wed, 30 Apr 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009817; cv=none; b=EtbwnbXdyxXueVV+qAKRecgx7v+c2Wa5v/Q5ryvMWug2nUzDCA6xAM6BBYZr4af2/T0VyxJltD8v92vHxYqjRGBeo3b1esyVRbFU9hHKU8D4424OdxIWRuVGofcdSKzsXr/wWCHbcb1sIHFfJtWDSvDXqHnwF5ZqaMvgYe064Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009817; c=relaxed/simple;
	bh=NAKlta3XWitRCQ9CR0OeceOIu9uDJz/mQLmJc953vZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hJfVA96XM/3iLoliU9kVAvgWv1L8CAg2CGKAi8Vp7nHmkGJo42yYPhw1yih++f6mfM2eL8z6vPJjAEIlMDRrn0H3Ov4ku7PbzvJ/jEp1bp0AtxgFJECKG+UbawFmR0e+KgaeGTYfSqW8CvjOwD18375j6PfF4V53466Bb/h6Kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxEx+Oe8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224341bbc1dso77049735ad.3;
        Wed, 30 Apr 2025 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746009815; x=1746614615; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzZQqAJR+WqTIKqQI8DYjkIpauNuciSLhlQufPfaICY=;
        b=DxEx+Oe8wmQoZUSyzAqUQGUAWQUKcHAMYIHZFU+Dg0kxYdHSbpBrvgUCx5vGPmU495
         Abhq3lmdjK+L7VkkMpJRiBiJH+gmMbv18c3yBodRI93ouNM4PmooSHNt1HH7lK4GG8dw
         9ReUlPS1SOzeb3ZCZsIZIlhR1ZFnHDz/DSdl7N/i4P/ryRFdsZcDlbqRgmdaHg2jYdNX
         zgcyJbcPOnyfrk+Ua3FyhvMsHrXfDX671vdBjqBioycwnXHq1OjvaVMxVXpa4VjHSE9T
         8V2CgIYTESqY9+Wd4CEAVCkIuU1tI4zFzuHcGbMwUPF9vw5O3VffVGnDlyyN0qYbZPKm
         D2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009815; x=1746614615;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzZQqAJR+WqTIKqQI8DYjkIpauNuciSLhlQufPfaICY=;
        b=dtXeNxfrFjNZErBLwS+KCMDOTnIlPxvYDd6pHzwvc1XnPK6+JGq5nd3pf151o/wWj3
         3h9v7L/i0eHqLVll9TyG1Wxe9edlJ5DrfTxbMCVYLl0WAjfGdt8UoEvyxmoIMA+scmUk
         CQRZaJr9vN/G8T/+qKAxYvI0NUIy5689JaDoYiuSvIfwIH3VmdNMLhJxfyr1ap9zsS1n
         JSBdnokDMS+6rlX/t+HMBBHmx2D0n8KZUPor287QyBWq3fdAKDCY9yvzjgNCYbJo35DZ
         0Kn4tbGnFFmJzyOXMFMW1UwR7NstV6kTguPaCn83JywxGARlAXHUb6kkzsZEuW/kVNti
         Puig==
X-Forwarded-Encrypted: i=1; AJvYcCVAX56PNcgWtdzIx9JmMdrzJvzqzBwXIg/Lnbfu/HA8s79utAG6/s2dRYBB195DO5ES1aev//y5gtIi@vger.kernel.org, AJvYcCX1D0DHNAtAhQOvDcT/43E0ZZGHWrDkoDYFt/iAN8idjUe8ws0NqT/SNlaaVgkX1YC4HzFq9oHlE1FKa4Ue@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAqGS4hc7XntEoCw6EVe4G67linvTxlA9fX7PSHmiqaIqbcvn
	0BaBi9Vkrv1J3dOY35MDMTX5AwQnWGJy82UZ0M8ScfNl+9/lBdDq
X-Gm-Gg: ASbGncsC45CcSSULnkwNwWAEVESrsc8G9PRGLsN/snNuwuHthCMQ8J6fAS2gKFRw/Su
	Dj3dj871KLEGNMm+gu/WccHHauTUeADfcZ5TVpXGMpmZGcjVh4txbXlje7kLBa7XH4AcqW8CIDY
	jWld9hYWpDQ/x0v8ifQrG45H5VEO+alXdHgvRiP9eeLlTXm5FVP9DIncUVKIk9jZbXb8NClvCfz
	S36bxkUQAsVSmG2vsD3bku3oRXMhSibwRqZBA0tcRiycPkVIkLiQ8NzggC54i0aaKMRu2bwCY2B
	8wNAU9+ZiLf5ZgkK8ycLB4DQfQZOF6oKfwaN7efuBAUc1aetwy4c
X-Google-Smtp-Source: AGHT+IHrvYxDI1wKN1rkMDQ7eeuHkLXsOmiBRAnjf4RJ0ayJhK3kCarMO3qNBqmI7N4UpeLNLKZkEA==
X-Received: by 2002:a17:903:198d:b0:227:e980:919d with SMTP id d9443c01a7336-22df35bf45amr39338245ad.47.1746009814978;
        Wed, 30 Apr 2025 03:43:34 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a8dsm118992715ad.136.2025.04.30.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:43:34 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 30 Apr 2025 14:42:45 +0400
Subject: [PATCH v2] dt-bindings: net: via-rhine: Convert to YAML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-rhine-binding-v2-1-4290156c0f57@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKT+EWgC/x3MQQqAIBBA0avIrBNME6yrRAvLSWczhUIE4t2Tl
 m/xf4WCmbDAIipkfKjQxR16EHAkzxElhW7QSls1GSVzIka5EwfiKBGNd86p2dgRenNnPOn9f+v
 W2gejrjv0XwAAAA==
X-Change-ID: 20250430-rhine-binding-ee3a88809351
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746009806; l=3022;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=NAKlta3XWitRCQ9CR0OeceOIu9uDJz/mQLmJc953vZc=;
 b=VQRHu3ZlD50RosJpgOF+6PVZZ5Cv2oP5/FHjW6pS9bL99am6fO+PKopyogJ245JBslAgUHZu1
 8oE61AMGgvOAujPa/xQbcZB8SPRwiahTx1WvHo98EBRm7BWCEIzdXPT
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Rewrite the textual description for the VIA Rhine platform Ethernet
controller as YAML schema, and switch the filename to follow the
compatible string. These are used in several VIA/WonderMedia SoCs

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v2:
- Dropped the update to MAINTAINERS for now to reduce merge conflicts
  across different trees
- Split out the Rhine binding separately from the big series affecting
  multiple subsystems unnecessarily (thanks Rob)
- Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-4-f9af689cdfc2@gmail.com/
---
 .../devicetree/bindings/net/via,vt8500-rhine.yaml  | 41 ++++++++++++++++++++++
 .../devicetree/bindings/net/via-rhine.txt          | 17 ---------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/via,vt8500-rhine.yaml b/Documentation/devicetree/bindings/net/via,vt8500-rhine.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e663d5a2f014788481dfa0c612c261eb6adb6423
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/via,vt8500-rhine.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/via,vt8500-rhine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA Rhine 10/100 Network Controller
+
+description:
+  VIA's Ethernet controller integrated into VIA VT8500,
+  WonderMedia WM8950 and related SoCs
+
+maintainers:
+  - Alexey Charkov <alchark@gmail.com>
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    const: via,vt8500-rhine
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@d8004000 {
+        compatible = "via,vt8500-rhine";
+        reg = <0xd8004000 0x100>;
+        interrupts = <10>;
+    };
diff --git a/Documentation/devicetree/bindings/net/via-rhine.txt b/Documentation/devicetree/bindings/net/via-rhine.txt
deleted file mode 100644
index 334eca2bf937cc4a383be87f952ed7b5acbbeb59..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/net/via-rhine.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* VIA Rhine 10/100 Network Controller
-
-Required properties:
-- compatible : Should be "via,vt8500-rhine" for integrated
-	Rhine controllers found in VIA VT8500, WonderMedia WM8950
-	and similar. These are listed as 1106:3106 rev. 0x84 on the
-	virtual PCI bus under vendor-provided kernels
-- reg : Address and length of the io space
-- interrupts : Should contain the controller interrupt line
-
-Examples:
-
-ethernet@d8004000 {
-	compatible = "via,vt8500-rhine";
-	reg = <0xd8004000 0x100>;
-	interrupts = <10>;
-};

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250430-rhine-binding-ee3a88809351

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


