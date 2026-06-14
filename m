Return-Path: <netdev+bounces-299133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +m54BtQnLmrPqAQAu9opvQ
	(envelope-from <netdev+bounces-299133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:02:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB0680525
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:02:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IJJqyZsJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299133-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299133-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD47303A90B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5B248893;
	Sun, 14 Jun 2026 04:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93D1E9B37
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:01:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409669; cv=none; b=iIh3izMqgv7qvvo0HHyMbACtOwTq13BywOtXuM9UWDhCMgo+XgMVO7d1MwDpFv9nALCNluRe/6fURMuaCe31fkY3nMjy5T76AwV9UWFOdvG+CY2ohdiG8cH986orG6EKkmmVw57qf7tjHocg+YgkypIx5lQQR0yKA4fK3wp4qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409669; c=relaxed/simple;
	bh=YqZgooixA/CJnBKTcYQgsktFkPYzsrtkk+x91gr+1OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4pjKHaq9u768amayxDvV7oNftU1aP1eUaLPxmd7xJw7N13lRrIHuEE4dTuHbHoSYv1bPXISsgNLPdcbxbkDNwWEijB3OfS7inKWyZOxmkAg5CP+Y1syFoECxL/TRDVGuMcrR4sn/9lheZPSVAeQ3+QoYgBjdSl5xuY8ZXCuC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJJqyZsJ; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8585cd8400so628607a12.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781409668; x=1782014468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOnY6yEezyUxI5CBehQcqD9t37X66JniIBbQ/HB7HUs=;
        b=IJJqyZsJ5cahcfrFYbsa0P/v3Ypl/QOGkkAERh3hSEPWHf4ldxpP1/UscgwcRbyfQs
         9f49Qa9OW9+QULfr1f1/Gom0kUdbT4UCKNxVtorwJlBbJWc0d6Z3edjn5QcJ8xIA7aAY
         EvoIC5jJpQH+6SwoanSb67TIUeH+EULvAk64XnbrhUQ28dKvAD3vfEOxKDqy9IRf3MEX
         t1SzczKBJnidozYuqPn8ofF1e5W9jo5IWqG/tjLDWKxYVG014aKkWbBX4K34g8RkOElF
         KjgARFpRskiFhuChJy4ZnWtWyWe6KczhPzWkjz2vhpoRBhAwYXZ83X4GqkcYE5+MkB5k
         nLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409668; x=1782014468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOnY6yEezyUxI5CBehQcqD9t37X66JniIBbQ/HB7HUs=;
        b=OGvN19hQ1x2+9/KABz9BjyecPDUkiFcf/uvZdEh640jeX/cXL+hVLjKMvcrcXBcJnI
         muCaf4NVt3+ex6/YZNsvNDA4drEvawN6/ifbBxgUlaPYkW9W4bFFWZi5eZVlE+XI3uMp
         91VTs5DJR8vLFkmECjJmigoymvxRGf/pO+xqTzlKFfmyH/1vD22heb8pgEUYVrRtZlaN
         M95q0cFXg1j1fk4TBxDtp4sByPdWj2o5L28PoZk4BYtKQAbns+fHb8wh59sMUix/8GTk
         orqZPCCfOAOdY9xBF864TcYiuoyZOEFtBTw4rCPIdxNLLzEIYBknlbJRiYVsNDpT8klA
         PLYQ==
X-Gm-Message-State: AOJu0YymrP7J6Z/Tse5ejLE/GUvaWbPCjjaT6Zi0vkOvhwTZ7WnlcrNB
	mi8CVJzjkcMQmJepTx2CaTFH1si8sTGTHHShSRW4IaicHErmijJJMcUPjUsWwP61
X-Gm-Gg: Acq92OHGR5of8MDxOMrcSAXufuGI8x9oqFotwN8nxq88i/re5iaKotJbp1eZvmeIvu4
	JIJOonZ/dPoZGl4ug/4u51ypQ/VzyYL3J0e6r9XQxKCTVQ6P4DQ3/V5rcb8A1VQ2w8i50SYjmQW
	GxixChoK1D8/vb2zxuZL3kCkTUoqqhphHYTDYn30u+3nBMg98c7NAw1hJtEn0ghOqFUghTSVth0
	D2zxRDeZi4JdloCVvNPQ7Vrq7ZyeuMKWMolFeyoXSAZD1muFjnKbjFsDBw1HZ3jmM2nepPc7SIy
	SxGikiBdUkqgz9hllCWX3JcM0yfhL6wiy5Ue0ApIPOJ9CZXbSUiLfIrvYjNRGE/viCOC9HnA+AB
	rBJUzUVKBw8+5t7rKPzYyaNmfWzBbINoSJmTAdroZIo6utsL3j1ISvSC8mqYvc60Xcy526VQetU
	zf79iDDhbXgs1BpoVIAA5Pb/cm5Xv3CQ==
X-Received: by 2002:a05:6a20:728d:b0:398:b178:a53f with SMTP id adf61e73a8af0-3b784021a1amr10268367637.40.1781409667707;
        Sat, 13 Jun 2026 21:01:07 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm5676983a12.0.2026.06.13.21.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:01:07 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [RFC PATCH net-next 2/7] dt-bindings: net: airoha: add EN7581 SOE
Date: Sun, 14 Jun 2026 13:00:27 +0900
Message-ID: <20260614040032.1567994-3-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614040032.1567994-1-hurryman2212@gmail.com>
References: <20260614040032.1567994-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299133-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:hurryman2212@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FDB0680525

Document the EN7581 Secure Offload Engine register window used by the Ethernet driver for ESP packet offload, and add the new binding to the Airoha Ethernet MAINTAINERS entry.

Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 .../bindings/net/airoha,en7581-soe.yaml       | 48 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml
new file mode 100644
index 000000000000..24aecafecc70
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en7581-soe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Secure Offload Engine
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The Secure Offload Engine provides inline ESP packet offload resources used
+  by the Airoha Ethernet controller.
+
+properties:
+  compatible:
+    const: airoha,en7581-soe
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      soe@1fbfa000 {
+        compatible = "airoha,en7581-soe";
+        reg = <0 0x1fbfa000 0 0x268>;
+        interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cc1dde0c9067..7c338e670572 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -757,6 +757,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+F:	Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml
 F:	drivers/net/ethernet/airoha/
 
 AIROHA PCIE PHY DRIVER
-- 
2.53.0


