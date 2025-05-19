Return-Path: <netdev+bounces-191669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038EABCA66
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95731176F0B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86621CA03;
	Mon, 19 May 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fB74Desr"
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-21.consmr.mail.sg3.yahoo.com (sonic305-21.consmr.mail.sg3.yahoo.com [106.10.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5F21C185
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691713; cv=none; b=KDC+bKmXge1nbOGPCI7Ap/IQM205a529QWyqkoLU3s0zKdPvMCTRtsmBm+RK0+HRZLcKi9ZrlDctqWP/2Y4WWfi0CidDRKp1CVvN8TjEcyancN3J8ylPcJzzRZhEN6QizbtG3+0f0+5VqAFDhr5scpkwWk1kbCan89xpHVxAjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691713; c=relaxed/simple;
	bh=r7Bfs5oBMnF9vRonWA+aLRgo4e34zkesHi6jiTnxQdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzNJ0IHmE9ZzF9jMzrUKpgDZu5wHDA0HxTgaG3kWUzfgtGFNnz9KJ1Ih9bKkw3K7qMz0XxjE3BxG9qrTwWTdhmBvYXAcy+pN++DmjtQ2y1poeLlkRfZbjx1t+a+zqMXFOD1EK5U7U7w0G4u80kSjqlIbtVizGgnyG84AgBS9Gfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fB74Desr; arc=none smtp.client-ip=106.10.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747691703; bh=SA/YRjcLwEIXfA2flh80c4kG86PoJ+dvBQZXOcSn5FU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fB74Desr3PaNRjDJfuXiQi+qBUD9mC4K6f/t6WwYRqlglRE3+sH+RTEHPh2boJIRH7TVj060aySjrkDMBqGXxa6nV0kBcHnPM/YsRpJ1PxQwAEfjbHw83Ib0aAdq3bnTX9pLEvYW0n0tM0JeJOZdr+gRQE4Ar3J4LP7P+j+ijJ1rYBV7Caco+nvQkiKoOsF2x+Tv4LVVKQFFE05BNVh7QgQDgGAKhqkVWccL+zbW1skgyH86Byo/nVMA2mwYw3HHZMnLC7kMfhnCWOPGvIxgnkbmCLhJfDFHaHyZNdAfEyKe3MqIXj3NaBNZY9PlcRX/ywWYteLyE2NcaP+dViOY0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747691703; bh=fHlL5lUDs8Dwbmw0oBam54gg0ysFnu2YHE/2rW0Y+4B=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CSBcH4qmBAQJDywCzLf9Ae2gc3hq4xD4GoubIiLkEDKWM3ZW9zO5A6Woc996z3ZVFDK7TajxEDKkVaPfh7l+wGi80Ves9Aonree3Eylv8vglO0/MIX5mZiIpWX/3aJKoJHJtiKAsSdLsrN0iRZLDWHSqCcwjBPvULqS40X/bQ5bMh4YMGEpSQlqaVGyJlZ1L+YvG3bFY+WmGv73cxMQ/M/LLFDjE40acHJfjd0m0KiELccgEFfaY4yM0ktlKNr6w40cPVNLLOPu6LAFlbVJGhL5ixRbNLSEMlx3dp0GB99bWREf31EzKNWhppQ+K1YXIAFFqOwijwY57/HjIkqebtA==
X-YMail-OSG: 2v.MLIYVM1n_qjIqg6LKvc4rLooQLlUQ6PBMUtvKvkwjt2EXqYp.no32B_E6Vgu
 mfxMoCNO64Y63AaskEgzDH8RCxlaR8AdhVc3cx86Egool8GLxzI63SRZ7DSR9EEA.fadc1CRoMYt
 tc.o42Dq16HgFIsoNyw6FVWAjOihYBh_nqVqfFPbqEKigbCeUFH6Q9NMf_k84eSc7rvrxo.IJsIk
 6GvdPnXM21wULVz9n7MYXMU4QbTXpdR7oGHV3b4qPQvOnr7t_Ey0WLfwFZpR8utaQd1xTRyKEKkb
 VTqKnnh6lrXb0Xe4DUt.X0OC7kOJ0iSbP.d1IitDzAGSWXavz2.2NAgX9iUdP4JZEEdnLynBXrSx
 ikym_kJYqT7ET.XblVSFqJ4NJ3Toi81ObLZ9y6UUfjuu.Bo.og.eg9RNlcOmGWl2E4GZRUMkIbRz
 ozN.ijpvfZxksl_BQWl_WroXJqROvjmoLvELeohFMb6bs7iRIztyueVsZ0JHmsixuFFV84e8FqZ_
 i1nwFoGfuBLWoWQr0ZqOK2a8MuW7_poqRxmyjdj2odZK.Ho4lHPN7y8m9CrSUmGY808wrtoPsoLf
 X2TG4pyylD0GdgQayHCRL4Yd6ibJE3YDdAw2E9N7c9_gG9huF.HGJ8TZKiPoEHldz95NHhP2BInD
 RZyebjXluRKLnXibEzEp3XqGWZOax63w2f8cpLeyScK8_Dq4FrmZ0iNSSdyZIS62fr1nGbXgbQeM
 UTFxI_jaTjkQRAs7LBHkjgvO6s6NmrIp5bjcHPOS9CmCM628oR5FcN5TgbSKMxJMuMfDyPKYf7qS
 YHviuwd7eaOzUg_dRU_ge74PNLs8ihrz88YLAynxI4JvWOcigRBL7o6OpY6OGV0O07FtS4FKqAeO
 HAEhhx3prKq7dzQ3RnzJkXuKwLBkCW8wpykjIe4Uvq9Rc1_V_8BZDCZ0EQxueaMdkoHY7WqiDGNk
 xfaLPezMJZ0n_XRpD9Bah8KIA9mgNcbSmoz0.KCt0ASUTHWQyRcbTVq9TJ8gUkeu89TC7X8g65_f
 vqftUJwnyWJRC7wjnxj.CnlKSzqE1gDyxKh27N38Yq9q7.mvTMHhhvzjZ0OlkzWemzMF9z8A9tdQ
 wbG5kneWXw4hLa3ChfKJYgbcorxUoMhW9zUBF4yOK1sjUUv9q76LdDw0DtreJmUCOJYcNcY5bNx7
 hVmSGRrALw.Fkl3QKUU5hdQYyO.TgE_0pRDjtVzgY4oCrYzXqO9tpbKSWb469RiKK_OqU.AULPEi
 neeonX.O2_N.oZ3xE5pUT6dW_.44aXHgwfN9EzJVIP_189yMKhOI_vWCe.jI4anKYmvsYOWhoLId
 ESDSesbZyIE8.K9HbuipLVdcBTLye2WH3CXCigPF0UDM.i.IRBcWnoajI4nErpvdTZRYF8TG7vvO
 D69._fmReq7gaobJS7Xsfdz9Ow3y4ZGSmpifjb1uIckX6LJk8vxzj6Atz_lPyiiLLLMJQTqi4kdq
 uhJ0aQGcem516LrhX5koTy.vMMr9j7xINdxGDWgXQGiojgEzYtHzAMeeMTEesq65YjjnM5K2JqAD
 BwzFZwgUhwInRG0_NWK1qS05FdPSSflHcbP.W6FKCSEHoUC60wx0f6_RHzjadEWHRhUi53GI46yI
 orCNphD7N3GmTMinrMvq4DSoGMvM053aylCIzHWYpSm2aIkzTLHfz0X78cKAHkmndkNzmUY9JCPd
 2Wd9H0ygHPm1K9E.jTrDcKgcncCqBYfMpiFiui8uiL2siEtgRS5EcqCwOq5AQKumidsH.oln1oOx
 oW9cK_NJXriUPjtjBjZpoCu.hb9rGp66rHIGD44twV._fFin2BD7V6rMcm4..UCYr1I3Mj.ikoGt
 X_Q41_G1dWwnYrOB6l0uSjMQh_LdSbh89aUu53woN1nvCmA28RUaqAmIp74OspZuPD7wO0NnaznD
 tK.esH7VQUVLa5qY.NnLnr1bgV9Gs89Wc1S1I.HEWLTaNo.0Ua2m5G5wPcV0b_y_plHHtzTysNvI
 oU2oBGzPuSafbjRZ9aoGAbKjO0.DfZ64OA3cNlXvFMi0gvJWeorNnn5CNsLU.P3BKhvpZf3_hVBO
 IXyDPMAAHLvCKHQiPIqylPShwQ_DG3oIJ0HTDuNMwtpeep6TcSq_778zjNHaXwkmIQ95EPbMnp7E
 cw052AyQJ8zyVv4NwTcG_XmnNh6iQIrr_SKQTs2uuvMncYVjtdiFPsyppcezfSjWuqp14WCcaOMV
 m8Be26Bu7rDzt2SmHKp3B8X2eFvrfX6PCuMYgjuv.4WgQKEzp0knbkA1TndYU39OXk_MbAatv220
 L8frRQOhQYqddB2NLBtfohgTht44f3eionelPK4.qyYQ-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 51dec9bf-1fcd-4583-9005-10453c239b49
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Mon, 19 May 2025 21:55:03 +0000
Received: by hermes--production-gq1-74d64bb7d7-rstz2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d5fa22a8ec8900100267a57050f58b0c;
          Mon, 19 May 2025 21:54:58 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: krzk@kernel.org,
	bongsu.jeon@samsung.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] nfc: Correct Samsung "Electronics" spelling in copyright headers
Date: Mon, 19 May 2025 14:54:41 -0700
Message-ID: <20250519215452.138389-2-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519215452.138389-1-sumanth.gavini@yahoo.com>
References: <20250519215452.138389-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the misspelling of "Electronics" in copyright headers across:
- s3fwrn5 driver
- virtual_ncidev driver

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 drivers/nfc/s3fwrn5/core.c       | 2 +-
 drivers/nfc/s3fwrn5/firmware.c   | 2 +-
 drivers/nfc/s3fwrn5/firmware.h   | 2 +-
 drivers/nfc/s3fwrn5/i2c.c        | 2 +-
 drivers/nfc/s3fwrn5/nci.c        | 2 +-
 drivers/nfc/s3fwrn5/nci.h        | 2 +-
 drivers/nfc/s3fwrn5/phy_common.c | 4 ++--
 drivers/nfc/s3fwrn5/phy_common.h | 4 ++--
 drivers/nfc/s3fwrn5/s3fwrn5.h    | 2 +-
 drivers/nfc/virtual_ncidev.c     | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/core.c b/drivers/nfc/s3fwrn5/core.c
index aec356880adf..af0fa8bd970b 100644
--- a/drivers/nfc/s3fwrn5/core.c
+++ b/drivers/nfc/s3fwrn5/core.c
@@ -2,7 +2,7 @@
 /*
  * NCI based driver for Samsung S3FWRN5 NFC chip
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index c20fdbac51c5..781cdbcac104 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -2,7 +2,7 @@
 /*
  * NCI based driver for Samsung S3FWRN5 NFC chip
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/firmware.h b/drivers/nfc/s3fwrn5/firmware.h
index 3a82ce5837fb..19f479aa6920 100644
--- a/drivers/nfc/s3fwrn5/firmware.h
+++ b/drivers/nfc/s3fwrn5/firmware.h
@@ -2,7 +2,7 @@
 /*
  * NCI based driver for Samsung S3FWRN5 NFC chip
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 536c566e3f59..110d086cfe5b 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -2,7 +2,7 @@
 /*
  * I2C Link Layer for Samsung S3FWRN5 NCI based Driver
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/nci.c b/drivers/nfc/s3fwrn5/nci.c
index ca6828f55ba0..5a9de11bbece 100644
--- a/drivers/nfc/s3fwrn5/nci.c
+++ b/drivers/nfc/s3fwrn5/nci.c
@@ -2,7 +2,7 @@
 /*
  * NCI based driver for Samsung S3FWRN5 NFC chip
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/nci.h b/drivers/nfc/s3fwrn5/nci.h
index c2d906591e9e..bc4bce2bbc4d 100644
--- a/drivers/nfc/s3fwrn5/nci.h
+++ b/drivers/nfc/s3fwrn5/nci.h
@@ -2,7 +2,7 @@
 /*
  * NCI based driver for Samsung S3FWRN5 NFC chip
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/phy_common.c b/drivers/nfc/s3fwrn5/phy_common.c
index 81318478d5fd..deb2c039f0fd 100644
--- a/drivers/nfc/s3fwrn5/phy_common.c
+++ b/drivers/nfc/s3fwrn5/phy_common.c
@@ -2,9 +2,9 @@
 /*
  * Link Layer for Samsung S3FWRN5 NCI based Driver
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
- * Copyright (C) 2020 Samsung Electrnoics
+ * Copyright (C) 2020 Samsung Electronics
  * Bongsu Jeon <bongsu.jeon@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/phy_common.h b/drivers/nfc/s3fwrn5/phy_common.h
index 99749c9294d1..9cef25436bf9 100644
--- a/drivers/nfc/s3fwrn5/phy_common.h
+++ b/drivers/nfc/s3fwrn5/phy_common.h
@@ -2,9 +2,9 @@
  *
  * Link Layer for Samsung S3FWRN5 NCI based Driver
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
- * Copyright (C) 2020 Samsung Electrnoics
+ * Copyright (C) 2020 Samsung Electronics
  * Bongsu Jeon <bongsu.jeon@samsung.com>
  */
 
diff --git a/drivers/nfc/s3fwrn5/s3fwrn5.h b/drivers/nfc/s3fwrn5/s3fwrn5.h
index bb8f936d13a2..2b492236090b 100644
--- a/drivers/nfc/s3fwrn5/s3fwrn5.h
+++ b/drivers/nfc/s3fwrn5/s3fwrn5.h
@@ -2,7 +2,7 @@
 /*
  * NCI based driver for Samsung S3FWRN5 NFC chip
  *
- * Copyright (C) 2015 Samsung Electrnoics
+ * Copyright (C) 2015 Samsung Electronics
  * Robert Baldyga <r.baldyga@samsung.com>
  */
 
diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 6b89d596ba9a..9ef8ef2d4363 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -2,7 +2,7 @@
 /*
  * Virtual NCI device simulation driver
  *
- * Copyright (C) 2020 Samsung Electrnoics
+ * Copyright (C) 2020 Samsung Electronics
  * Bongsu Jeon <bongsu.jeon@samsung.com>
  */
 
-- 
2.43.0


