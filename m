Return-Path: <netdev+bounces-291068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPRyDy9pEWrKlgYAu9opvQ
	(envelope-from <netdev+bounces-291068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:45:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E55BDFB2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E753026ABA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B877376A0C;
	Sat, 23 May 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAwhHM5J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E596374E67
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525869; cv=none; b=ZZHfxAyaW7g/8EZ2kl2isGrvqwR5r6LeA0K4dHrQJ3n9F4thlrGz5FbKgrXlOlvNPuGxj264K6pcBQa5Bp3NT0+i6eO2PQ8Z/vC1SsA7d7j0vTDJJDhESUdmegNpxVcqP61SK+It3mu24gN9x64XyNh1/I/FTorIRK5YCMPw360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525869; c=relaxed/simple;
	bh=aCRvYddBbXrODXAsigivXkpsnAI8V+yb5mlCXcskyT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqDbicXZzMiQv3Y8iX8mCmEAiK67z6Rrrt6qcYLVp9vrK/msm6qDIFNcy08lBMp/n5fqf/SEk5hH0HCdyF0YoZKB5gKlSZjJlvUY3OazJ5s0ocsDvtJ6qqLQ4OI7ySBIXHjFDTzHltXG++U7dtIh1RhHotxRtbX0hjEK55a3JXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAwhHM5J; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso782343a12.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525866; x=1780130666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qhj6rHOiahWvbVZuWT+FMPoy+y8UQ9yLqxFehsJ6oo=;
        b=OAwhHM5JqncDKe3JqEBG7ormYizSPXPfTRN/XxD0Wb1zPwzmhsedfWfsUSZ0Dgj7aL
         m3J3NFciv3Hj69N9HGgbmOkF6MA32KdzaEPMSY4mFDY6cyCVvDDuxaelUzM99TA2RmhS
         y3ompCB63rhwCR4EO257saawhyedKo3QZ8NaiPTmyFA9J5A8tzuqqXWLm8O3jg1TySFP
         ZIhSqUsVnFVmq+gYxDrlviTnxpAiWJNemtkKZKPvs1njM7ZB9Zlg+uPoSBk/2ynz45Wc
         SFRNiNgKyUiB6Sf7dDoyI+N/wp5vjHbzjslCONm5q7lgDj1Txd9tfpE+2oyYLWWbTR9B
         yOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525866; x=1780130666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Qhj6rHOiahWvbVZuWT+FMPoy+y8UQ9yLqxFehsJ6oo=;
        b=mPTJ7X52NAikF5tHcskVCwl/Vhrh0brFBYGBB0++O0pOuG/n/flQdWP2vKPeoGQyxG
         LWrv7PECQ7c1cCugL0s6CGEjA0ExMGY0mOSr30Y5LTwKqmhkka5rtaMvML2VX9Jft/Vq
         Gk/lcCIaxX4hMyiz1cnxBZVzSGzT9qFhKHcD2ik7zaf3LE15xRwAQW4apNq7YuJLW4Oa
         jYI4AZD8u34JrzJ9FHWFzqlAzzXv9d6NR6SeUpWfE6jjC+GY6nAtWujqFqvJqkQval8G
         0RSOQWJ5JUdxG7AZXDtxuFYh4xJGz88NMJwmZHH34KgS7622XIr/8eVBnyDQxDcLFAAg
         NO3w==
X-Gm-Message-State: AOJu0YzUtejAS6zfoVIj7PDFl/sdCxQVF/NaqJXXQrtKHn2S9bwkw2Ym
	0EwTcKCI4GIaei4p8e/TUqhWzW22WqxYDBKsavLX0KsVop6GdJrt1Hh3
X-Gm-Gg: Acq92OEMqVLywcnSPq9oJP236eZJGD929lxez5X2ecB5gxBopVy2gdHO1Y/ckXugYzR
	a0EwuPHI9pp5GCFJiOpBCX/8wQJb6kVxj4TZupzeB0mRv6MYBWyOs7dkHQIwmM4JTAerGgF+gsi
	2sNR2MbJGxOG1QJQfXspkkw8N9Ptv7GFSxrv0Zorudp/gb8caJFuqrxBfPuToH7grhfF1F7yaGU
	oq/X0yCcFgqRIbJxqMkFsn0H8uDYzaK3DjZ+U7H+d5AsHEJE17YxseXxz62AGbOXgc0Z6+XtyLo
	3HKTr/3aMQTgjbE+QB67ZmZIy0vIj8V4rhSJO8FLSM203SoWVP6+u2X/M6jVYPTxz69k9nC2elK
	/UFaII1gdzrm5E5bqOOTgth80djh+jZoQgWVHAR4/9BXTzWfBkvNnOhRXy2AhbcXI1GRmtEKRK4
	1JpNeIip/avv1B
X-Received: by 2002:a17:906:4594:b0:b9d:e301:20db with SMTP id a640c23a62f3a-bdd274c9a91mr321047766b.25.1779525865586;
        Sat, 23 May 2026 01:44:25 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc62d70a5sm154042966b.48.2026.05.23.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:44:25 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: net: Document Infineon/Intel XMM6260 modem
Date: Sat, 23 May 2026 11:44:06 +0300
Message-ID: <20260523084408.50346-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260523084408.50346-1-clamor95@gmail.com>
References: <20260523084408.50346-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 927E55BDFB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Describe the Infineon/Intel XMM6260, a 3G-focused, slim modem platform
designed for smartphones, data cards, and Machine-to-Machine (M2M)
applications.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/infineon,xmm6260.yaml        | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/infineon,xmm6260.yaml

diff --git a/Documentation/devicetree/bindings/net/infineon,xmm6260.yaml b/Documentation/devicetree/bindings/net/infineon,xmm6260.yaml
new file mode 100644
index 000000000000..ffff58e479ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/infineon,xmm6260.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/infineon,xmm6260.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon/Intel XMM6260 embedded USB modem
+
+description:
+  The Infineon/Intel XMM6260 is a 3G-focused, slim modem platform designed
+  for smartphones, data cards, and Machine-to-Machine (M2M) applications.
+  The modem is usually connected via the application processor's USB line
+  in HSIC mode; however, to work properly, the modem must control this line.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: infineon,xmm6260
+
+  interrupts:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to the ON1 pin
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO connected to the RESET_PWRDWN_N pin
+    maxItems: 1
+
+  ap-wake-gpios:
+    description: GPIO connected to the EINT3 pin
+    maxItems: 1
+
+  cp-wake-gpios:
+    description: GPIO connected to the EINT2 pin
+    maxItems: 1
+
+  vbat-supply:
+    description: Supply connected to the VBAT lines.
+
+  infineon,modem-pwrseq:
+    description:
+      Contains phandle pointing to the modem's power sequence.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    modem {
+        compatible = "infineon,xmm6260";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <168 IRQ_TYPE_EDGE_BOTH>;
+
+        enable-gpios = <&gpio 112 GPIO_ACTIVE_HIGH>;
+        reset-gpios = <&gpio 169 GPIO_ACTIVE_LOW>;
+
+        cp-wake-gpios = <&gpio 151 GPIO_ACTIVE_HIGH>;
+        ap-wake-gpios = <&gpio 168 GPIO_ACTIVE_HIGH>;
+
+        infineon,modem-pwrseq = <&xmm6260_modem_pwrseq>;
+        vbat-supply = <&vdd_3v3_vbat>;
+    };
-- 
2.51.0


