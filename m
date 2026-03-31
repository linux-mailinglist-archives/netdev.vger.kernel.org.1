Return-Path: <netdev+bounces-273625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLdbMDvGy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:03:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916F369E7E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFAA300B07B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466D3E3C4E;
	Tue, 31 Mar 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfYhvb9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BB3E3C4A
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961907; cv=none; b=n0U4JJa10y9uZ79WRmKb7QF2MjtBAdp6xc+cAVbE8TAN5JaBuMrF6emKO2uf6OhYkDp2FX6OemjQwjxTkj03L2Fhqzln7Ymq1KSxiPIBKDUlOKza/s/KjfK7Z3eg49wM8S6L5ExWY7KjJuv1kwwex9Z9hRKyFB0JclayTA7n67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961907; c=relaxed/simple;
	bh=djHK6/e1j3FccuHU3wL+GIytWjfnGOh6XecERoS/cM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bm8n2weqnKJXpifrNZllhp9kB7b4Bsq/6ESVFRLdseSY7YY6iLdPsyErjtn4shGXH6ilSLmiA2GZb9Vgi5Goj6KIrG4RGIfdVFIa6XhIxN6JnQrbxGrl7+R5Urphct2zW9p3+uwjMguxgNeXRMKZNChpNKTkgl7qAQJ67/Z3Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfYhvb9W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso52095895e9.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774961904; x=1775566704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2cLRzPgMh1jzUyXR5ubz7SX1AzTAShSPRbVtdWw9nFk=;
        b=hfYhvb9WchuQPrqngIng5KlXfNH7f/24CVSdshH7wIbPWpOSUHFw4C9qzbMIGbXGwh
         thzRryEBpaWu63vqMOx8CeROn8UQ0LyPpBc9bepSAnjV+vxhxqLRVy5Sdh8NgCIdL1vt
         OG1ay1BrA2xie8umdNpbnA9dC/M0HRZj5mSdF8RjYNVyYHiPs7WwYW7CQj5LmoTBZavg
         HNex1PZbGrJpz+nykaGNDdFfSaE2y5Y7ICor4++LQd9vGefOaTj3LXlPgePcPlmlixrR
         dvDyTpST2MLubPfGoK0WhqGkpfIfEqjYbeuu3j6HDBW9TWnU1MTnlXnFMAul6XeXjJoB
         6y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774961904; x=1775566704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cLRzPgMh1jzUyXR5ubz7SX1AzTAShSPRbVtdWw9nFk=;
        b=geh9dTrh95XpAFZnZoHxL7MzTaSuKjoM8FDBDLn1fe2UriOGcBRg04z0tNtWmcZkPM
         xudmzErCOGcitYElGyi4j4q1Cdv6InNkNS5fwnYtNSPoVNZQ/NhTCx/VSJaXfbKgbz4h
         2XAUO3J0EkY64dv6SQpiiQE86BpAo+ZfHXSBlpxv59MRs/CqUazQ3SQL6LrnbRyb4hS+
         6IWnRQNMz8CS74i2gX68bW5Pj1XyEF5fClfQpBrTW5UxbgNsgWMOrXBG4HEn4F9p6rlI
         Mjke3PfrNHeO8X4bVo2slk2765l5e5J9xsg4fTQLk0c5gjl41unOlZ0ql327yXIyELHC
         3JDw==
X-Gm-Message-State: AOJu0YxBuiAOSn0GQ4XW89flQnSRMNnl2r4jxvNwpPJBJWhOzumb96p2
	KeoiLvS/iqLEnMJau+V8YEGC3MDj3gM6eDJ8udBs9oUcdwVfIZxj2Lt9
X-Gm-Gg: ATEYQzz8vBcqwTAdcdSJ+WACIaB68USnc+7MOU+dr6vbx2zw3T2gh3m2F7D7WK91UQF
	F5Uh0cwV5LMZ9/5A8ArvCdj6P7BsiqN9zgHlI6jFJ+NJ/8PCVRRfYDYcdlBgzIS9xXyR0Y50gxX
	2ZdvaOtDQc6k0+MOQYAKsk/iomTSnlXXVDSroYWzX3BYWJubIePaEhRubRR3HdzVVgIC8Az8YLC
	bo70A8HJc9NVLjtZ+nd2RZyyB0jchU9M7xz+UXxE0JEJfNmKQq5S3bIggfBp+g30h9YOaW3kfjj
	1BlXXydnAla3lTcgfJX76NwsS2t7d1aUhQQWNX+wgCTljlkcEVZjNzd3t76sgKmZK0GJhDNQ8BV
	lCMifO4nMgKbV5HHwbX7U/uDGahTboKf6EGPAsoah0R9b7ux31nJpxr1yO5K3yIwND5lPVOXbhu
	IudydubAMU1lTB9kDAj2sjr87jfp7eVvxj3s4IzkFXLg2dCbS/jNz/Nao=
X-Received: by 2002:a05:600c:a012:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-48727ede8d3mr291577115e9.21.1774961904134;
        Tue, 31 Mar 2026 05:58:24 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93c0cfsm38946535e9.9.2026.03.31.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:58:23 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: manabian@gmail.com,
	davem@davemloft.net,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] stmmac: cleanup dead dependencies on STMMAC_PLATFORM and STMMAC_ETH in Kconfig
Date: Tue, 31 Mar 2026 13:58:17 +0100
Message-ID: <20260331125817.117091-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,st.com,foss.st.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273625-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2916F369E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are already 'if STMMAC_ETH' and 'STMMAC_PLATFORM'
conditions wrapping these config options, making the
'depends on' statements duplicate dependencies (dead code).

I propose leaving the outer 'if STMMAC_PLATFORM...endif' and
'if STMMAC_ETH...endif' conditions, and removing the
individual 'depends on' statements.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index c2cb530fd0a2..ba5473b8dae0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -20,7 +20,6 @@ if STMMAC_ETH
 config STMMAC_SELFTESTS
 	bool "Support for STMMAC Selftests"
 	depends on INET
-	depends on STMMAC_ETH
 	default n
 	help
 	  This adds support for STMMAC Selftests using ethtool. Enable this
@@ -29,7 +28,6 @@ config STMMAC_SELFTESTS
 
 config STMMAC_PLATFORM
 	tristate "STMMAC Platform bus support"
-	depends on STMMAC_ETH
 	select MFD_SYSCON
 	default y
 	help
@@ -53,7 +51,6 @@ config DWMAC_DWC_QOS_ETH
 
 config DWMAC_GENERIC
 	tristate "Generic driver for DWMAC"
-	default STMMAC_PLATFORM
 	help
 	  Generic DWMAC driver for platforms that don't require any
 	  platform specific code to function or is using platform
@@ -336,7 +333,6 @@ config DWMAC_IMX8
 config DWMAC_INTEL_PLAT
 	tristate "Intel dwmac support"
 	depends on OF && COMMON_CLK
-	depends on STMMAC_ETH
 	help
 	  Support for ethernet controllers on Intel SoCs
 
@@ -371,7 +367,7 @@ config DWMAC_VISCONTI
 	help
 	  Support for ethernet controller on Visconti SoCs.
 
-endif
+endif # STMMAC_PLATFORM
 
 config STMMAC_LIBPCI
 	tristate
@@ -381,7 +377,7 @@ config STMMAC_LIBPCI
 config DWMAC_INTEL
 	tristate "Intel GMAC support"
 	default X86
-	depends on X86 && STMMAC_ETH && PCI
+	depends on X86 && PCI
 	depends on COMMON_CLK
 	depends on ACPI
 	help
@@ -420,4 +416,4 @@ config STMMAC_PCI
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
-endif
+endif # STMMAC_ETH
-- 
2.51.2


