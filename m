Return-Path: <netdev+bounces-191680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF03ABCB49
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E401B17CB63
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081821CA12;
	Mon, 19 May 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S63bToY+"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.sg3.yahoo.com (sonic314-20.consmr.mail.sg3.yahoo.com [106.10.240.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4F20E32F
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696171; cv=none; b=nZd+Hiue/PKJT7Bk/Z7JTldfG9tAbHROycrFnmVrUs1tI9BvZjVT/Fu3WITpdeqkRfTUpiuVsWzxzd3HSGPHuLZdQ9f4/T1LsCmbEmBz59BxqkQZ05fSPVhpVhiFKRsF3AgQWIBZsKPNMf17hPY08GEeDHLZbnT9cwBCWrs7v2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696171; c=relaxed/simple;
	bh=r7Bfs5oBMnF9vRonWA+aLRgo4e34zkesHi6jiTnxQdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=XIUQm5EvKySGr9B4Ie5iTS5WoLtmY1AUT2zB8pOymjLsoanBRluc43wOcvijCVQdSBQRes+BU1Rk9SpSVZJO0Ky9FDrXwzRHlj/426WTPc7q6GlUhHi+jc6BQyRkLZAtqoMPl1N5sqftjDJIVdtUTSJeot96QVkRDtpLQdpORKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=S63bToY+; arc=none smtp.client-ip=106.10.240.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747696165; bh=SA/YRjcLwEIXfA2flh80c4kG86PoJ+dvBQZXOcSn5FU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=S63bToY+cjtHc7CANsaRN7YB41qNP9NBu0n1bUFPlcMz660RkXdziR9plUOgK9RECL4R8Fh7QMXLA7/Tzc6Tok/6Vrk0J4eL4EH2qGOjdOLhhMVPyC7eSuK35yUTAAoG7h0UC6DzHyOg9o+1nlmCb/WtquXAVXrP2c+kg+p3CWy4+ttmK+YHLlraPyG57Dd1bQ84T3wVMmMsbcC0iTVpZ873apUpkKyMBUKQCu+CbDIKMvnJ9RL/cUJX29svwY6lajK6Tshkiif/CvYjBbc6koTlaPeUdrv2ZlD6A3RV3yFuMf28ctOrwNH4NqhayEZlzVwh9d4uvce74MfB5L+wxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747696165; bh=qNS5jwQZEvx7yxPmY7d36e8SlPYFpduJFLnY/2YFLuy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=byg/vuBY4Jm3L85THWyohaEfJp/bvN5smdRxXUFvBVMg5FskeUygnNm5BJbvNebdGwn5bBYctrPS27TXfvvV6u1a6A0MEJLh3k+CiR5zcp/pKuTpukkXDITG/s4LrgH4q9yqDx1l1HLy/LGkqAM0cvDy7rI0tUOxFLzhfy87sCU1xBMU6dNAYKMMjY942YgSTfAgYIE+fILuD9tk+6K/47wEEyH5X2iBrrJyJ+empFenwiwTKEe1WBCOJw2lY6XriZbSEeai/r/rAahv9FJlS6DfJC76K6CXtyTq7pXZgo/9aFxPieNMYSPXpqhEQEBJWFWm52SSimzVOAqFfVAZug==
X-YMail-OSG: F0kIVJ4VM1mxblUPxlR0WQxazYHWfzVBulO691e21.PJyUF9e8jhuXunOp7Hxtc
 YlYrjLg_vcxbPGtjrfYRpumf_x50QA_ss1uQkDWt3kFLXnREevE5g7.CdnflsFFh4foULc4T1J.M
 lx.K6qHO6G.HkwL6OtQL..fkuK4tE8vX3tZfuAV5wbg4rrdzMtuPYFdCjY.w_.hxmSCw2U_m0I9c
 9rDGY83txT3fGFItLaL31nlyOcblCo6I9OD5qDl714juXh0KX.NNEkQOqVxSzg0ij16ONEvJW417
 YqRykPgRExySCYjdoCZLdOhC8aCtBeaWAYaoCp2ZCSSv_rUy58yMP_ydsuoDf47ctXWuiNzQlqwP
 GgtgdnV4W.SB2I8qVtkZgEMJtmqWeg9FTOyKOPlt7nmL8tpA573.4y3M1M1uIrX75KwuOXbWRF_t
 eUVRCnpcOibGLAzPcTulsbqajrBA8o9RXPli4sqRflY99Z1ei63T9ri06WsVSHe.QgsmJN5ZCS7U
 zEiD0M_qtSo_r9OLzk66eeWZc1b__f4PMC8ciRwFBNZgIqasdYOnsJUXY_J3PpyhYXLm6RKNQPhO
 imHBZ_Mk_NT8q4o1ly1ZUETwrpX22HwGd0PRBL5dciWrLxlDsePNzS4zAhYa.fLiIBajSl8AElTl
 r_ji_8LiISAyhSOBRirGwgimWyqnwqDHF01S0vHWFhSW4Zy4utgHNRDTzyOJJ8oy8v5..M7jnG3g
 Dh0hM_4SAgkAxft4BdKJ1RSXJMfm7yKFzX1xNhFF7UdGkJcvTEYE900RhT86oDpF0G9IjNdttHTP
 IU2tJjoLStWYdTMcAM.kdOdPtCn82gln_xVhjx1gtuYX6KM7DBQFQvr9_roVUAoUdTgwkj0yB_gS
 7JLTfNRYL88nj1BwwPm7EAgh.w29EtVqbbS1I_KIyFiRu_kK57UBINQsXILchplSR63YyUiKfjuT
 9SgO6YKnGIsmyIGiw471DnB8Unv70N5Yn4E.d7t.gWPNxz6C2v.L0e30any5Dgk1GyGIwLa3jR2a
 MSiXNcsacXhPe3Fl5cpYxCiUF_W52edaTDN7SBbim.GnG5eZUnnLo61x06U2y5VrvW0p1R9euQNA
 BZ3xq27lml9sVq_daQ.8O5YkWzBoje7fG1m9I5jdNR.dqkUElKwVM3a0RRwg0ioiwu1BUpyKuCWu
 87Tfjw6SjrpgyRz5.GCeBG7SOf4.khrdqIxHEZ0lbqrQ.m5AQJ2D3vdMOtPKp5TZc1kzFoKuubj9
 lcI4UvotLbBWzddSj5m4LxOKv4l4.noTzrnmfnM850TB2qlJvdEO0kBz1hLA7yI_V72oegkkV.AA
 74N1mGmgjnRRPwekDKGWKYWyFh6zadms3CznVCbatf6NKHH8N2.w3Gl0dDaGxmACK3gJCaXPdVCn
 2dgri.N9GAVXutRWTCkHXrmbK1zp0eXft4.1nS2A2RQu2I6FORh_IBKltuHOt839UGEV.0i31ggc
 eNkXaw34DxuQU._48p0cqRmK2BMqZuvdez_iUx8gFGj6PI_khK7ZzMDGKC_ExQlwq.Lj_.0Iz40u
 xTFi.eH2mW9daTJQbbvYNQo1eRRxSdvxLFaYYH22qEha7sonzRhcB1ALgeEiYyRMytVi0Y6SAG1X
 TBMaziEfjpGqRXT2TzB2zORXRS9REoQlaNZVQIccQpgKxXizo0E0poS5t.KK1I5ft2oAnCc6Ug9x
 kVoTjHix2Ula772z7DewBPPefWKb.Yqy8FMHhz0YtexPUp8xAlYB0a0UTkL0Kw_ndRRvhdymU2NC
 WT9815LXqv_0mZ5HC.abAJiM0lrAUwXyq9HvTMGhJk4cQogykRR82S1DekWa33BSepzDqRw5xRTH
 vX6NMPHLr20W8a9vc4U60fjhpSic5dd1mhT.qQASCrP0VP1F9E2vU_oACH.36JJRR93VUVrXdGRZ
 J.dasXFgJH5ZtDP59lvazVGtAgPSJBXFqwkEflmKvIysgQGYPxbzqgtWEz7FGsDu991ZSj1uclvT
 8rzeWgsizJbhGfnpzp8ZG9gNaqJpIQzcj5ymXXTFf5nziEnn0u5uYq0f71pEmH5.kMpcmmE03wrV
 2vJVgjjycztS_dc8rwvrKIAWmSB.tSmMm.7ealvhlJHLd8A4IkH0_XCiO5jYNQ7LL8g7njal4EB.
 bp1h5X7vv9slCEeRc2tHme23IU4oPBUtp87f22laX0lHzJKexqg4BQ3BAmnMR7Zj3tWh00xZaOiK
 k5OpFsIzoVc46tqx2wPx85wIFOR8nCtv2WSeo6vGl8.wNUj8Uh5AjhiH_hW.oaDGucxJMHlKDhXQ
 ga7Z3dZLCQwiU8cyI8d8nQvQ6sa3oGrUvu2n6ovqnUZPGUw--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: f6d1a411-3d65-4dad-a036-97dea6a76f45
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Mon, 19 May 2025 23:09:25 +0000
Received: by hermes--production-gq1-74d64bb7d7-nrjbm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 27bf425ff843813cc0a59ad0e6e03019;
          Mon, 19 May 2025 23:09:19 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: krzk@kernel.org,
	bongsu.jeon@samsung.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: Correct Samsung "Electronics" spelling in copyright headers
Date: Mon, 19 May 2025 16:09:13 -0700
Message-ID: <20250519230915.150675-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250519230915.150675-1-sumanth.gavini.ref@yahoo.com>

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


