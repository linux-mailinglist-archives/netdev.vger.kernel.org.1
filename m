Return-Path: <netdev+bounces-296260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rd1oO8KiJWq1JwIAu9opvQ
	(envelope-from <netdev+bounces-296260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:56:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26D651054
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:56:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sartura.hr header.s=sartura header.b=mD1I1xzQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296260-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296260-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=sartura.hr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F0F3011768
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5B30569D;
	Sun,  7 Jun 2026 16:56:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FA2EEE67
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 16:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851370; cv=none; b=vEu53cGX3Jn4F0wrY4BpW+EKRiCym+99xJGyDtJwLJwyPQrVSiFjAzlcddd5V7CEIx/afzQV5ttBlThxl1dJtGWmtuUiblDJQ1JYkaELi6HLZrgpvHwVWA7g/9ua4swctVOiRJIZ3Zk2GIzGN279UKQRu76LYJ9brDs7y/GJGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851370; c=relaxed/simple;
	bh=RmbGLXvguzzR6cADfjSa0pG1zmC1hTwnkCqAIZInmiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6C2VyD3t1cwBkmiumdjiusgDwWsJIka4Pn52JQVa2HwdBHxg9ux5wYvuyuGw1FWVGs5QVqg1qLcX4ldo2dMctEzlioFEDdKZ+cKAUR6hQw5Rv2qiktrrW9v1GEl7jLyLsL4hFfLTbbMN3vHYANWTSansOE9myT3VIj50f4eDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mD1I1xzQ; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ac10e337so31619625e9.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1780851368; x=1781456168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkIOc9hxgB6VFFpx2IKVhOdGPlSs4ufUyju4H9y6/R0=;
        b=mD1I1xzQ1laXi0bMjjuzkO9WMnM8i3PoKXnPCkWz2VCdBVf62OmATBzojKEBqND4mP
         doSj5hRVI1fY7FJOGbo0MJijGI5RyLyZHmchXy6Kc6H8uqgXe6PT8v4iYJP2CzfV3IpX
         EWl2E2Pxc42DqCKj5vwiwUCBpae0qt1bgCEkPGSgvY4hWkTIoz+/w3BIz2aD88dA4RXR
         uXXZZz6pvROgaRDLHgyQGs2h3iVOAN35/Tw4OjmyV/cUfTdLUthiVG6akJangAXJ6SYr
         BbuXnHWqTL8R+QqmAoQK+oihPUFJrEFG2/HxinzGy+XrRscqdRBwq8YqNzr8lcvv82aJ
         QWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780851368; x=1781456168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkIOc9hxgB6VFFpx2IKVhOdGPlSs4ufUyju4H9y6/R0=;
        b=lF6lc5jb63iL1DYzuXKuy+QCCU5gUcRoQTlHtWNMwEjFXjy6QcPvg1XkGGlOuXDdoP
         jx/FlxL/SPDlBVvMB1b2q22nOfjIF/3uanyl+1NZWJV93BR1n1z7qkkKPk+oLsG78NJH
         /6Ph29cqma89A/AxEsC8ANFlc4jHp6G7m8AZnp780P80ObwgW8NPOZVkVrSAcTUw4m0y
         DMEY+KZ94nG2cWliNMk4Okvn8qa0tS9gwZpHgIU0vJWiwLtI9IjC6YDS9s0RfKagQJ2T
         B3rBT2Cxm+l5yjEh/u6esM/YeJ5fyUWDgoNUshRQj/LX0Flnkw8E+lSW3HxJ6uiSu8cC
         MnWw==
X-Forwarded-Encrypted: i=1; AFNElJ9veQHcZmYhGwze2AiOHUZz4RY0bAXN2malvZTdUD0T90xCn/GcSt2YUHxrbt3kXOoZGAziUGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RpDaHqs2ay3/Z/Qc3/58Y0U5AkvftBkXlriNId2L9+4fy5Hp
	99ANzkx2MYmDuNAWwd1Cie0TBU+gFfKjRB2OD1tqCFPYhc/fteMUlrUugXlavvGj1oQ=
X-Gm-Gg: Acq92OEJc4kwqQOT/rqjCNj8uqj9y2DgQquGZFr8J7WAc5WGUGSG1WBQUAWZYSJncbH
	IuLIF0zVeddfifdCFE9ifv287XotmngF/vJIWshq10Wh69ENrXV13Xm+iQe8ymw2Gg6i4kVwK/m
	R/Eb+AUFZSCYA7dLfaISxBVQa3N/Sq1vpZ/Gfb0i4TfBzhrpBaiqhoYwABsnf8xazFgPFJAd6k3
	YtZ+TFcjk4DWF6N3hYRo5iC4ezBqC4Xjc9zfv3IzO2CUFOQLJIaDRJAU3uHBtln5/R6gkY3B16z
	gvoGr1ajdg1dq6Pxn5mKvvn6XE2UF2AxFtcRmIYAsX5EQV3QL1SRK0NcWueTpnOOXfXkKYBJaEZ
	MfB3UezcLgQvYgiuzVQfoQQzHTHCIkyfKhYprvdUB8BZRYhhF4flgKC6EOTfCaQfapBGoNCVFXU
	6GwJQkAxW9ztRdKU9hlhz4JbHY8F/dlYzZ3El+cPvzVtPh9twowGPxqjch6D96LuwPSApVvK6lc
	VY1REWeI6PrbXNWkQJPnBjZZIjgIajxt3HoC1qnZEYAoOWSeeyx8gTUis6tGtxoimu+mTbuYMuT
	sHlZkA==
X-Received: by 2002:a05:600c:4e14:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490c2600ebdmr187600905e9.22.1780851367960;
        Sun, 07 Jun 2026 09:56:07 -0700 (PDT)
Received: from threadripper-fedora-workstation (d-zg2-253.globalnet.hr. [213.149.37.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm283230325e9.4.2026.06.07.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:56:07 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: microchip,pd692x0: add port disable GPIO
Date: Sun,  7 Jun 2026 18:55:35 +0200
Message-ID: <20260607165600.1260210-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-296260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel.machon@microchip.com,m:luka.perkov@sartura.hr,m:robert.marko@sartura.hr,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sartura.hr:mid,sartura.hr:dkim,sartura.hr:from_mime,sartura.hr:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D26D651054

Microchip PSE controllers have a dedicated port disable input that like it
name suggest, will disable PoE on all ports.

So, lets document that GPIO.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Pick Acked-by from Rob

 .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
index ca61cc37a790..ca4200afa793 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -22,6 +22,10 @@ properties:
   reg:
     maxItems: 1
 
+  disable-ports-gpios:
+    description: GPIO pin to disable PoE on all ports
+    maxItems: 1
+
   vdd-supply:
     description: Regulator that provides 3.3V VDD power supply.
 
-- 
2.54.0


