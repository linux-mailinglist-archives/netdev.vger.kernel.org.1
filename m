Return-Path: <netdev+bounces-274592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JLXL2qEzmm4oAYAu9opvQ
	(envelope-from <netdev+bounces-274592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9D38AE64
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73146300AD7A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B43C5553;
	Thu,  2 Apr 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYMibeP3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4E2E2852
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141949; cv=none; b=UXGmhSrMLH39r+bdhQ/4cmCbdCx5nQh4c0c7AZJHAqFgJw4/OrWYpw+Y0SQYOCl55boORZi7ay+FQLsvYI1eK+pq3elw20Bd3j4SetL7d5kXA97eIclZhXzaq/vUpznXdMkjwkI38XxDc5ojRJyOeUvnKLtQ82cQty3Ye1/A14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141949; c=relaxed/simple;
	bh=GSszmDH6Vo50hjibqcYhbF6G50fPYsyJXrh74DRg6GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLf8Mu8y8NE6fVRqZExWzPcsl1M0JTPBT7uaP2fg45KnHFhHlWNtbLpFnxvkOqz1XYfFNb+/cn9IY+feCDD215BeoUzzUULr1nkv1GAx6+TZIvizwH8CYR6wHzZADEcd6scyXfvP/bsj9sFxgWJAde0wWUIF0nke5F9R5GAy3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYMibeP3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso9357885e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141946; x=1775746746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3bPD24HOXZN3kgTTA30LveYpkBvROd5J3kwaxcJHYOQ=;
        b=cYMibeP3qrMPnFTNhYyIyYAqwd44vFnFXDHKLqTrFS7mZNNpkHFCzcvCtNCKJZFPV2
         y17IeKdSff1UGu4S9IvlqaIv3VubCyNAwDdZ+Biqw6uV5Uferot2RyP+rks34+BDT3aj
         s03mlo9IFCsVrMBJpOeO7IDHJ69xnlsVf7KcyqVrajtcLiI4nM4w0vG3JPezdmIn1dyZ
         2v1aVh2jYYuOEj45GbuBTYLIs77OSVbjPiqR/d1CMsY2ZdC6MUsVzh79t9NbTQMsGgEu
         261nvnPpNiiUgEPiiDc41zF0Tkg5BFm/3sYDOPo5+rZ/Q5ad8h24D1VNTh7mld3Q0ng1
         k6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141946; x=1775746746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bPD24HOXZN3kgTTA30LveYpkBvROd5J3kwaxcJHYOQ=;
        b=hLnQHvdJsIJQPhSfEvWfmz+PeNHYK1JLfhDP6zGStlNabZ135LM6UsUgHcm9M9G5Mk
         3CBvmUPSPjAoJMSOsseICCya5wJQHmMx1r1nrk68mWgYf2TZu1q9ObN2HJqOkh3GX+aV
         onN3jWts2FeMaeMYTkcH7BBhTMD0FU4snWtpQE1LwEG+gI0bt/ojSGb6BCwqoqf99RxN
         YCPWAyvKZXflEtMHhayRgEGOPWIVBMIoBwRNLM/UnNJ9qHHX2gag9UbB721mv1mPDjmT
         0HywaDW1PVkVgL1c0pu/FcU45zkUOCr6WMjvlS4Ej2sKziAi2AB2qETucTAK8AGGoCpL
         Latg==
X-Gm-Message-State: AOJu0YzYVVTdlexRZBoZ6xXDNihDys/zaxRWe/YvnoHjPvw4aO9ijHqM
	cMVyBsiyaUevfHHKJMxduVfcmsCO5m0t69LK33ue7Felb8mFSs7eORHx
X-Gm-Gg: ATEYQzzFhX75rndtC93cfRFwbrbktzbOo7eGtZB8kl28ouYVpMzsb9ObzOuB2v3Epm+
	4b12DHFa22TzkcT4TtcEeKFkL1JFQB8EBzlikLiTTLIyMN/pRTigHKHeSknzOBDlpqIS2L/8rwu
	d03A2WzRH4LjSUjL1wZH0BbAimxoHC6tvlX90MhBHGnDLYZMFgf+V1kC/9Mhc+4bMDrZeYYCOOI
	3xdwimr2xeXLfV20a8OvHc5C7gmwkAfVHYJyEMFaY7K03rNyAPj5s2z2+CshtZGM5o1y3mtk6ie
	QimZEJzmy5X5ddQ2Pwy1V9TabKoBEz/rOyuaQvfpVNqHsDw/NzvlZXYoyfkAfe4d/vV4KN3Xwa2
	9YiukQcosWJpbZjJZ335c450rfyYsE5AH1zA4nJdWn1Gb6ivRQh9/Tl0SD8nFzFMrpL90gkmzxM
	QHqX/pGw9K2gJ4C8l61LvH8kJL0MFFBsdGJMVHxBZVDUZJ/ulfr6jski+cDmwJcsetZQ==
X-Received: by 2002:a05:600c:3516:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-48883597ccdmr119887005e9.14.1775141946108;
        Thu, 02 Apr 2026 07:59:06 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c769841sm93671845e9.7.2026.04.02.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:59:05 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: davem@davemloft.net,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	mcoquelin.stm32@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM and STMMAC_ETH in Kconfig
Date: Thu,  2 Apr 2026 15:58:58 +0100
Message-ID: <20260402145858.240231-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,st.com,foss.st.com,gmail.com,armlinux.org.uk,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274592-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFB9D38AE64
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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: add back default STMMAC_PLATFORM for DWMAC_GENERIC
Link to v1: https://lore.kernel.org/all/20260331125817.117091-1-julianbraha@gmail.com/
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index c2cb530fd0a2..e3dd5adda5ac 100644
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
@@ -336,7 +334,6 @@ config DWMAC_IMX8
 config DWMAC_INTEL_PLAT
 	tristate "Intel dwmac support"
 	depends on OF && COMMON_CLK
-	depends on STMMAC_ETH
 	help
 	  Support for ethernet controllers on Intel SoCs
 
@@ -371,7 +368,7 @@ config DWMAC_VISCONTI
 	help
 	  Support for ethernet controller on Visconti SoCs.
 
-endif
+endif # STMMAC_PLATFORM
 
 config STMMAC_LIBPCI
 	tristate
@@ -381,7 +378,7 @@ config STMMAC_LIBPCI
 config DWMAC_INTEL
 	tristate "Intel GMAC support"
 	default X86
-	depends on X86 && STMMAC_ETH && PCI
+	depends on X86 && PCI
 	depends on COMMON_CLK
 	depends on ACPI
 	help
@@ -420,4 +417,4 @@ config STMMAC_PCI
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
-endif
+endif # STMMAC_ETH
-- 
2.53.0


