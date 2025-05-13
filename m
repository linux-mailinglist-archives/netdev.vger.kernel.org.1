Return-Path: <netdev+bounces-189972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79157AB4A5F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012AF461F3C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E67DDAD;
	Tue, 13 May 2025 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX+yloyC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B3EC5
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747109725; cv=none; b=HoVUOU5VBpV9JTTX73kHhq2M8NJVDQDnAduXsna14IeNvWIhzq8+aDZ0ClWd1X3GCFpu8U21teQJhwyHlJSiHasN2cogcvENW3FPHaW8X8bROeUkc8jmFovn9ax4quxQ+4jfny1GS2xPcXWBDas57r/iGNhGcSjIpD1kd5bm9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747109725; c=relaxed/simple;
	bh=zmgjxPO0U+klayQ0Qw2R1khqOTy3NbhliE6DAjnif/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnYeJNWof6kGIFlOpM5zT6rJHrDr52mLlZ1uXpGn3mksGwdOXWMC33RBHoM5IDeGDQCC5SuPlP9n3XsC5iEQW8dxNpyHcseLaLsVDjlBhVuzojI1lx1H/kaJXWA25CNI41PTWYwJYG69VCCmXwGDuCAX1xBgel5ngi4/oS/mc90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX+yloyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275FFC4CEE4;
	Tue, 13 May 2025 04:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747109725;
	bh=zmgjxPO0U+klayQ0Qw2R1khqOTy3NbhliE6DAjnif/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=QX+yloyCgLfkrB/JxBPn1IeBRYy+SEvobD2xWrPKSDOzKeBFh3tRfPpLKNLXvhdrL
	 n2VbO/Zz+VXgvK1mQYiPc3YEIY1Qf1/BhyPzLtnr4HrIDHybCWZENRRqsj9R6LuS9e
	 1AewejkWA3jfezavIcvHCAwnkyCPfDxuETPx8H4zcJK2boaKaaNp5hh3okbn1+fuwC
	 pCEDatVAl4a5mzlcXTDM1WGQ+7E73fgUIDGgfBuxjK3qbBeqPEPyeZbCBdzC+jK77A
	 ypJta35238s2vYbqm7oLiAksmyZuxbOhNm3Hwl3AWQkH8ROmeghEQxqXk6D0VqkyE5
	 yZUhrpNgu4Raw==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>
Subject: [PATCH net-next] net/tg3: use crc32() instead of hand-rolled equivalent
Date: Mon, 12 May 2025 21:14:02 -0700
Message-ID: <20250513041402.541527-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The calculation done by calc_crc() is equivalent to
~crc32(~0, buf, len), so just use that instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/net/ethernet/broadcom/Kconfig |  1 +
 drivers/net/ethernet/broadcom/tg3.c   | 23 ++---------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 1bd4313215d7..636520bb4b8c 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -121,10 +121,11 @@ config SB1250_MAC
 
 config TIGON3
 	tristate "Broadcom Tigon3 support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select CRC32
 	select PHYLIB
 	help
 	  This driver supports Broadcom Tigon3 based gigabit Ethernet cards.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d1f541af4e3b..ff47e96b9124 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -52,11 +52,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/ssb/ssb_driver_gige.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include <linux/crc32poly.h>
+#include <linux/crc32.h>
 #include <linux/dmi.h>
 
 #include <net/checksum.h>
 #include <net/gso.h>
 #include <net/ip.h>
@@ -9807,30 +9807,11 @@ static void tg3_setup_rxbd_thresholds(struct tg3 *tp)
 		tw32(JMB_REPLENISH_LWM, bdcache_maxcnt);
 }
 
 static inline u32 calc_crc(unsigned char *buf, int len)
 {
-	u32 reg;
-	u32 tmp;
-	int j, k;
-
-	reg = 0xffffffff;
-
-	for (j = 0; j < len; j++) {
-		reg ^= buf[j];
-
-		for (k = 0; k < 8; k++) {
-			tmp = reg & 0x01;
-
-			reg >>= 1;
-
-			if (tmp)
-				reg ^= CRC32_POLY_LE;
-		}
-	}
-
-	return ~reg;
+	return ~crc32(~0, buf, len);
 }
 
 static void tg3_set_multi(struct tg3 *tp, unsigned int accept_all)
 {
 	/* accept or reject all multicast frames */

base-commit: e39d14a760c039af0653e3df967e7525413924a0
-- 
2.49.0


