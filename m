Return-Path: <netdev+bounces-254248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJNELTwIemn11wEAu9opvQ
	(envelope-from <netdev+bounces-254248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:59:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A73A1B5E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6896A3023369
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5135292A;
	Wed, 28 Jan 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/hxNO9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E174350A2C
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605139; cv=none; b=umXAV1BVPX7Gg9pEvUy+8cVt8afhotfoXEbi6h+ar61rsjKGAAPNmq3tD0LRIcqoDIuyW2lTEdSFnDM447TxZmFcvrjuDeu8/qUWM85/6rXiK+0AWqlZFL8feUmvJCL+kpxzzvd6dXn9xf7EPuzHphzWi8FPqiHPXBDhbLFaobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605139; c=relaxed/simple;
	bh=Ash0Tpop8Drl9CIAodpSoVI1Y7+zlfnaCRmi8fNAgWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5EPFDzN+0o5TC2buKCv7Ziy7Oec+Cuogm87H9IJZxFbpcD2h5/R7CoDhm/8w5RuJcwDN76TxHfM9H0PnXBOun0jNCM++qItpMhKe3/JqCHX2nCNPhQ4jTP61yqeDS+VYFDIbAgXrWCXtlOpcSkqCDhXivoAKcWzt+j4B0gPdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/hxNO9u; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b8707005183so1038242466b.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769605136; x=1770209936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzDhRuPZgWgWzngc97Sq+tn62O+gmDRD2phzboYIu0g=;
        b=M/hxNO9uLcwVLFm44DQUKOS1cllH8vOdw4q9KA2AL/1EWeG0D/boDy/Zq9Fp21Po8r
         Gz2pplArVmhDfVgE2c9BcsQHSfm467YhFv4jD/cRgK6WNST/7L4hH/GWnnwZ4azcAmaX
         RqSTHrsW9jrrwLbAZ2ZNsxb1K4SOJcyyJTRdVpG+FAYiY+gV9al5k9n8WlA+IU1Hq15c
         btdWHnWm5kl1raJVdfMynB8MYr8luVRaUeuN2ZD0rVKUqggp4t1TqwazBGIgysk7wUa8
         exbY11nWtR4ML9qxOzzpkq2oJgw5CvEsn+u36Rx8PbdM5q7k8kYU+ItL59f9Mq1ePSZb
         DPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769605136; x=1770209936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fzDhRuPZgWgWzngc97Sq+tn62O+gmDRD2phzboYIu0g=;
        b=kYGy895Dwi9XiScRTFl8AQKbhf/s4G6d/mYPpptxbyIUM7URtria3C/bav7WzVex0c
         Q3Iwn/pl4arTR4Sln60qGfTRaZ1l3WODK6gGTeBHIUVyQSdnuML8iYeY+gwFzaM9rV33
         +goGK7dDDa/u6OHRyLQcbsbKImLqPG9Kxt00+/jwcN/9ASoDn6/rrZNe1UENmNDI3KWr
         rds+Nn9gliEqiqYcVBFnFeLZsdQ/Ij5F5n524CjmZBy9OATkJH4cacjqAbw+6MDs9D+d
         ueVonah8vJQWg9r3H5ENtvS2vNTI+zCC1K+H4R8cutl31q8c2nB1MxYCnsRHARCznR3/
         Ad6w==
X-Forwarded-Encrypted: i=1; AJvYcCXzvIFmGcVeawaJfKXkVR/TQnJiZkWz2lxlCRZ81tlNCLZmVkU9X9XdW7JC+aFjV4zKzVExSto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpwzI5lxHRabxHouiZ3JzCGnG63AWrSpCsGcaY4j9kPWG+Gqd3
	HPG6/Z2zz9xjfS35r1zkDSAkwA7sjpYAy77ehji1STPYXSCYj3iKou+r
X-Gm-Gg: AZuq6aJHNW/K0Dc+0q5TEDmNsejVWBGHWbYraqagdSR4Wi5+Fcso2Wk/OVAhLo56E8i
	67+7+oXx81nGWmMtqD4SDPswpXjRCa8jA6ZNjzHvK71zykqhs/rIXx5iXIefdqLuht2g4toWYpw
	S7bgqJA5VxDDuwj/2gokzEdk2RloU3mCeF68yZtzpEw9aba0eUscG0og+5rFy6YUnYK7vBLBHy9
	W4ONUE1oFGpZ0NpGoAGb4+fXpZum0PgbW3OYFC+RqekCwdgWu/w3U7lFd0ViViRqNoNmwC0OsYm
	8AYOxTNdUYb1TkpRj/SkMKaVh3Yz3xnyuUKMTDKjVXuRguooPWLropClckcH84JFCwcRV+nCYBf
	GlDl3alzxDqgWhAjPsqXl3CCARR4rTukgT+91f0i1CrUEo71OKscMeO7lnMOseuRhkIvxaW+Nyn
	P+znBsNtzn8kS6IAFksk9c15qof3UZoQmMFHk=
X-Received: by 2002:a17:907:d8e:b0:b76:f090:777b with SMTP id a640c23a62f3a-b8dab2e7d35mr340318266b.22.1769605135725;
        Wed, 28 Jan 2026 04:58:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e29d:6e0e:72c1:d15d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e26sm123344966b.67.2026.01.28.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:58:55 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next 1/8] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
Date: Wed, 28 Jan 2026 12:58:38 +0000
Message-ID: <20260128125850.425264-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
References: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[bp.renesas.com,foss.st.com,st.com,synopsys.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 61A73A1B5E
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Add device tree binding support for the Gigabit Ethernet (GBETH) IP on
Renesas RZ/G3L SoC. This SoC uses different Synopsys DesignWare MAC
version 5.30 compared to RZ/G3E.

RZ/G3L requires an extra clock compared to RZ/G3E and has pps interrupts.

Add a new compatible string "renesas,r9a08g046-gbeth" for RZ/G3L SoC and
update the schema to handle hardware differences between SoC variants.

Extend the base snps,dwmac.yaml schema to accommodate the PPS interrupts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 77 ++++++++++++++++---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index bd53ab300f50..21ac3c20bb61 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -26,6 +26,9 @@ select:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: renesas,r9a08g046-gbeth # RZ/G3L
+          - const: snps,dwmac-5.30a
       - items:
           - enum:
               - renesas,r9a09g047-gbeth # RZ/G3E
@@ -47,13 +50,17 @@ properties:
   clocks:
     oneOf:
       - items:
-          - description: CSR clock
-          - description: AXI system clock
+          - description: CSR/Register access clock
+          - description: AXI system/Main clock
           - description: PTP clock
           - description: TX clock
           - description: RX clock
           - description: TX clock phase-shifted by 180 degrees
           - description: RX clock phase-shifted by 180 degrees
+          - description: RMII clock
+
+        minItems: 7
+
       - items:
           - description: CSR clock
           - description: AXI system clock
@@ -69,6 +76,10 @@ properties:
           - const: rx
           - const: tx-180
           - const: rx-180
+          - const: rmii
+
+        minItems: 7
+
       - items:
           - const: stmmaceth
           - const: pclk
@@ -88,6 +99,22 @@ properties:
           - const: tx-queue-1
           - const: tx-queue-2
           - const: tx-queue-3
+      - items:
+          - const: macirq
+          - const: eth_wake_irq
+          - const: eth_lpi
+          - const: rx-queue-0
+          - const: rx-queue-1
+          - const: rx-queue-2
+          - const: rx-queue-3
+          - const: tx-queue-0
+          - const: tx-queue-1
+          - const: tx-queue-2
+          - const: tx-queue-3
+          - const: ppt-pps-0
+          - const: ppt-pps-1
+          - const: ppt-pps-2
+          - const: ppt-pps-3
       - items:
           - const: macirq
           - const: eth_wake_irq
@@ -135,6 +162,27 @@ required:
 allOf:
   - $ref: snps,dwmac.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-gbeth
+    then:
+      properties:
+        clocks:
+          minItems: 8
+
+        clock-names:
+          minItems: 8
+
+        interrupts:
+          minItems: 15
+          maxItems: 15
+
+        interrupt-names:
+          minItems: 15
+          maxItems: 15
+
   - if:
       properties:
         compatible:
@@ -163,12 +211,26 @@ allOf:
       required:
         - reset-names
     else:
+      properties:
+        resets:
+          maxItems: 1
+
+        pcs-handle: false
+
+        reset-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzv2h-gbeth
+    then:
       properties:
         clocks:
-          minItems: 7
+          maxItems: 7
 
         clock-names:
-          minItems: 7
+          maxItems: 7
 
         interrupts:
           minItems: 11
@@ -178,13 +240,6 @@ allOf:
           minItems: 11
           maxItems: 11
 
-        resets:
-          maxItems: 1
-
-        pcs-handle: false
-
-        reset-names: false
-
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index dd3c72e8363e..38bc34dc4f09 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -75,6 +75,7 @@ properties:
         - qcom,sc8280xp-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
+        - renesas,r9a08g046-gbeth
         - renesas,r9a09g077-gbeth
         - renesas,rzn1-gmac
         - renesas,rzv2h-gbeth
@@ -142,6 +143,8 @@ properties:
           pattern: '^rx-queue-[0-7]$'
         - description: Per channel transmit completion interrupt
           pattern: '^tx-queue-[0-7]$'
+        - description: PPS interrupt
+          pattern: '^ptp-pps-[0-3]$'
 
   clocks:
     minItems: 1
-- 
2.43.0


