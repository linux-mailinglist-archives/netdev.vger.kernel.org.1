Return-Path: <netdev+bounces-286664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdZM4HjAWoEmAEAu9opvQ
	(envelope-from <netdev+bounces-286664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:11:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D661950FCD1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6E42305EA99
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCC3FBEC6;
	Mon, 11 May 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9/+y0hs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F223FB072
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507859; cv=none; b=UZs1tZMIlOwKA/QknBiqzK2MxMotvmpVHY1Kk95Bkf/lp3yeeNtldbKK12gmVlfFQFnow92m/En/GQh3IY9jx2s5WV+TE4fKhhWilMhIZ9KAabiB0GVC97Kdgv5zGSD4WH9JM6t08TvgtYCuntMwoM6iDgi4/RXyG5zjWWOdYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507859; c=relaxed/simple;
	bh=UGnwnynsk6MCY6H8VDntAGqr8yOAgR5+RJ5mxZdLHZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo2dTFWoqfMwNN1hFFDDS0NGz66IISLWWrjBpch8uldeY/ED9265Qatz9Sg1KFqvmLm/NWvFROrslDRIBbEp0dnkaK1pksTUSbXXaHco6guLMUKpLq88NSTqulOnQOOOV42nECm19Oe/KnRUsF0QVlDjSuq1rpernqU7oieI4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9/+y0hs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so8987050a12.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507849; x=1779112649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdX1Hn1whpHFxpnqtCP4cLwf/y3NxkK7GqmkakB9h2s=;
        b=R9/+y0hsEtFzQUpXgRzvAmmYxgz7ExkZm8O+9rT+NpyAQ+/o3KRP0XrYpX2R1BaRiD
         dCsIcCGAD2D5hCQtE8KM9A/7Gt+9IGEXFkHeOUdWfAEYp/pQR4+rSDaaE4FUMuFxQ+8h
         J600jYbyV3MjK/A5N53AEdRGi78N+3Z/KdK05SqBtl0gEnxxeVEQb7vX1y+9qI8w705L
         j+333xmAqAkVuIziNy4BOtLC+ykB50F9jwqVWcuxUa6Ua/HUBKL4yygjUJPUekW5esJS
         3haLAUCso3T0lB21StROK8z7cdSHI1Fd+lGnLQXbuA3RuBXWggRxuaSz3K7cCz7V5lFh
         SoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507849; x=1779112649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdX1Hn1whpHFxpnqtCP4cLwf/y3NxkK7GqmkakB9h2s=;
        b=GgzbDN5G153ZJjDbfndp/b3zbv9wW9A6KM/AO31FWhczbxdB75ZVOhLgPcbnRar5QY
         W4VapMPBx+wg/av0otCL4yZmoYqE9Xj2vYUEK13FwGzx1zoTWs2n8U/qyJjd9t+dQlqD
         oLvLrozfdzr+uOtGVfbtX34CiI7rDHS8xo9zfX/H8Kb8osdhZT3IsUsSlKKh7SChapHO
         5UP0TnF875EnNO4A48dC+IJgBgnteWhd/vv3j/rEiPaibTV3x8HOQDnttW71DEmt/cYK
         GKPG26+sP1QS+Pqh+2vw9fPr7ehfbjWYeuR+GsDet8L4AwpljgM2Mke71RjFtlDInqi2
         UbQw==
X-Gm-Message-State: AOJu0Yy5xck8QUZM+c1CsBNI1ywzptPqGhfcRDkbaeo9ZLs3Vod+Q6ek
	GY/i/EbUV14gYSKN6Q1omi/HrDDwXO+CY1y4y92TO48kBvfOv497kimq
X-Gm-Gg: Acq92OHpHye0AL9vNqYpdQq6dsryWo6vWmoGZvsrU2dF+RM8TeGe6fpsreoa2bRoqNp
	r00Idgth638AnzwRNf4boB5iJqR33omqoC7HAHBvmPavrL6xvkNab24MtO6xiG2c+2uiiT9xWzi
	ZJeObGNlZwfEsxU4IQWjcIg7FhWOFGng4XAtRjrR9FHBYQYgnVHDzNMSnQEJs494l01db0xLiCs
	Y+DqRHbTzQA9mNww8nn/IMklvHxRLA9OW2iEbBXauLAFLJY5iZncj0Z8niA/IcdpycCsvfNE/ye
	kQ4OJXGcvlCBzBZu7U87NtHe1cHX581OKD0fsL+pLBiVh5RYVc6CSiaUTRmNRSaeXJOkFI22Vv1
	Mwx2xL1jb4LbnVcdjTQjkmJ/MAKfhbspq+Iag0Efmk0BIdirc9f6B0uFfk5hqdmfoWvFQsvfd/w
	wuSU4qvUQwRUf9gjxifzJcDOM=
X-Received: by 2002:a05:6402:4506:b0:670:d548:62a1 with SMTP id 4fb4d7f45d1cf-67e0ddef87amr8352750a12.3.1778507849153;
        Mon, 11 May 2026 06:57:29 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3b904sm3685357a12.1.2026.05.11.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:57:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 3/6] dt-bindings: net: Document Infineon/Intel XMM6260 modem
Date: Mon, 11 May 2026 16:56:58 +0300
Message-ID: <20260511135703.62470-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511135703.62470-1-clamor95@gmail.com>
References: <20260511135703.62470-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D661950FCD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,nvidia.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.964];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Describe the Infineon/Intel XMM6260, a 3G-focused, slim modem platform
designed for smartphones, data cards, and Machine-to-Machine (M2M)
applications.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/net/infineon,xmm6260.yaml        | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/infineon,xmm6260.yaml

diff --git a/Documentation/devicetree/bindings/net/infineon,xmm6260.yaml b/Documentation/devicetree/bindings/net/infineon,xmm6260.yaml
new file mode 100644
index 000000000000..d34d7125274f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/infineon,xmm6260.yaml
@@ -0,0 +1,72 @@
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
+  in HSIC mode; however, to work properly, the modem must control this line
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
+  phys:
+    maxItems: 1
+
+  vbat-supply:
+    description: Supply connected to the VBAT lines.
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
+        phys = <&xmm6260_phy>;
+        vbat-supply = <&vdd_3v3_vbat>;
+    };
-- 
2.51.0


