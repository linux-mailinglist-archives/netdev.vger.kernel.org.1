Return-Path: <netdev+bounces-191335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B29ABAEE1
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0411899C5B
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448E4CB5B;
	Sun, 18 May 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j+pesCFO"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-19.consmr.mail.sg3.yahoo.com (sonic306-19.consmr.mail.sg3.yahoo.com [106.10.241.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A34C76
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747559285; cv=none; b=AoY7bJJ8lh5TKQG5BJjRvECW/iqE4CqyGGTeaU7yvAVwXLpGCeC52n8QpiFVWs9FULPVXJt/Vd1mwaPA059AzyGrGB6hscKRg/kJII/KkIWvY6SVecga4GjRMQAXCHchWeTwOpr9yZOFqx3FTODmptCttKsjbLc96QuQ8wPb/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747559285; c=relaxed/simple;
	bh=fky4oxVp7ZQrbZeAxLyt1Js4cZxonBMuwsJ54JpWJ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ5fq0OpOXbTYiGfHkdN0fx8nPw82Njdhuf98rz+4rbBGM4GhZVDZsoy8v6bl30OiR/hQ5C6Xj50/Scdip1g6Fzwu1DFkyWouoSVkn5+kXNV145HFVVH+yCfEe4Y9gsHRl+3bQD2ykR6iI41sQi11ZMggJqCiM1OkfnbdCnPtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=j+pesCFO; arc=none smtp.client-ip=106.10.241.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747559281; bh=e9h6nOFHAE0chzGn54RdVO0l+Fxy5HcBHZzQdjHLK9c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j+pesCFOcHFxd1Z4ofbhq1rNIuRqKZXSj9zy5pS+6hEN6/sfGRzrAFOBdYxafy+u3IEPCuKbkNZUwHICjAlCKzk2WVuyFRQUVCvZNAVU7gU6KsyCQmzSIAgG0gI8aVIxGNmzaVeloI6i6PFjL3pUQKieiylwcXRedBrzzzd/cZskYge+QQmeM9lTj4fxg4i6e5WdakFrvcZnDwYr7n7Imy+/CKoCALXMZBn5tkGyZmGHocdjskpDGP7Kn3TQCpRiBrItBPk6ZuVrTAOUA43EkuP7UFKBfcnwKvc8N83LNmrVk4HjaZXQz+FKOYcVhqciy665jH7hErESvaRgjG9OKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747559281; bh=qNf8+OeDupEsAbC02g7X9/c9tyY9JnMSdue2OlFQSnj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aKDBGzdWDMp3hdnE0dTSWvw039Q8aZsrbWaX+4oYRVlCPGOs9UXMOfwwQ7zzlLaldAEk+1K6+5nNYfQ2tx3+RbZuZNPynuJJswv0Xxiu9ckxklBqR1pB5imrLY2hfGyZri6o87KiwGgAqRdgpsOdj5sye7IOp2Xk9bbQI/6onXIC0fPnMOSZRv4XsZb7YfCKKnYOr03Iu2i6GhZ1eE0ZWI7GOeSt1rv4aIoHAEpdVx60JUnWd+fn98BsxZzOPemvsroJFQEHQuvb9tT0SNE6mB5shSPhGPSIN7MhM+GxFLJNVBuVrtGUaKbTKaAlOLp7u8P/wqEgTmYPjAD50P0l1g==
X-YMail-OSG: 5GB64wcVM1kgBBJ5JGrLTNATZBW8D4mqv3eeF.ahYaO1w5ZsWNtdU6OR6VN4gWy
 QBhJLPu_UXpCCPWxPokW3U1YV82dUY._At2ohcwGuV9MUq4ZQFA0MdpQO_TpVUQesr04TL4jQpFH
 KypbVev8RCMEkXlmk4p2j7XJB1jGCdiDDwtNYRz_1AS5vYzr2OiaQW.LDp6D1kEjJntq0OCgWxia
 _mNYr91EQrvrnbkKEX15FWh5GdCFOOfIWOewIOosh2afS0ZI28Ey1fvNKYH3njMOLyE3hndR216e
 LIg1Dehg2fSYD_lJCYXOviWQ7YyigRkQN7CaHwpZZcfFkZtvrbcEJP9obL.Tk81vqpw6uqHv74xP
 fVjfFKlSXZp1kHt7wRG.73o7fRzNHENgObreJDIdE3fTAzOyKRYx3HQRmEdIOzsKuQXZ93Cvf7Et
 tn2taWsZtDIts8n5Cpr4vB50V_LTW6UpMnohJZsn46UwS0xb_aAd6yBtON7.J7y7zAzghelseFVr
 EekG9oWEh2jBsxu375ZaZ8pXUTkwC9FjGY4BzWE2aw.boH_0peRDhtSd6JruzJWkF4wzLyTl4jqU
 5vqxOcGb7NVb1vQtIc.gZCbD.fk5F.CWFwYG_q9QTdlx96VGZGuvmRhfBNphdMwzAc4NWsiOd2IQ
 ALG4U0CTvppoz00mi6JDyxdAlopnzb5w47HAfDzmHuBGfxT3V3dxGAN_wgA1gqzkGYYgeEBgXLWi
 _vECSOW9HbpcDH1wo_0pLRQh2pCiMOwocH3Wo95NhYctT7yvWs_749hXk3lcm3Rwv_z3dpAq1waw
 YqV5ak6_p3pTdn5j_hoF.Kc6ZLfxwa9MV4ModCmQAOMZ8Ic4Gc05I1ey0aY72LnMMuuhDC0YDDqX
 uzBA4rLW.JmlA510Zb96Ui70.CpfcpVAOKGCNAXZwGd0au6D5C5XPRoWKol5FpY11wzz7bDQC5wJ
 .hcHWFwe3YHHv836F8b0MecLcabxlslENtSiH1rymOJ1qz0UvT7Nns2KoCAmjgs7NTkin2Sqc76w
 XIPAJr_Y1bDGS.01Bh7n40hGVsQhshamcyskQom7B6344PwYYKONY24FqDTaHGo2WaN_bxaNvc9Q
 Z4249OKVwQwftsB6SXJnlUAfEQoCXWqD7IfnBb14koGRTiD8dKditUHrdoFk6rpdoso6utHDCflZ
 bM8zK.atbVFZSdph5hEn9K7Rf_lM_a13rq0aD5chNRqktNrmFU8f6pRSYMAi5_e5fYmRJoHLp7mG
 u8vi7af_DjEz.TNFa8IWb2dgOZudw5o2MRw1scrWVsJySHczP62CSGkCzn7th_NFAY1ciuKEPXj8
 nv7FM.N6lVB7hORxMRJhlzk_jvsHDArasPgvJ0Xt3rGaFxaxoC21AOVN3SxxKUiFI9Sb9uplV.HL
 jVkVWfoU7eQB4Fpp_Z2Eit0GbMnBAcrvwL.EmZc853BGPzxOFUJZjSJhlT1x6yFPlvmSe8UWQlJW
 xIDKvZVlY0ZsNNl7UikdWqLPeiNNk2k41.gBZNpbu.xuP2Dge6ZMZYQgandRwmLV0DNfpIByOtdt
 Q2pX8in2M1sLewONi9Lswzamuz2mK2VUk72VZVdatAB3ZFnL9CznNeKw8pMtX0rumwbATulFFkKz
 1xt_POPekoSiOTZVVrDinYpPVkf5pZVvKzL5aGsgQkf4ksSLH457Bxku3Qqn6SUZ178paoF_vwPr
 SRJacLHWQVTEqHky3tfBWPE7az1Ya2wwqpiVKCYTffBt83hKJkt4fK6VgVZMQKwotrHhZVVEJySu
 Ij0wHPi2rBmTsWHDy9PPj9jXVZ2Q54PT2H.pMJk.vCZTcYmLBk4GjvaiiWHl5C_SEf3oiAgM_KXN
 P5TGqFrY062xzqxWNO7mXBz5yDNTkN2uhn3dl_qRHQ5zFFSbYQqugsIatMssgZnIO0I3vY7C6ACc
 ut8Ulwdb5Rh7JTSCABgNbN8dkYTNDwbdPXtSFqv_c0oUkKcIddSclBW9uZ1zZrSWazuR_RPrjAW0
 EtEk6T03KhHjbeIa.wKRehgJG8DSFWZnlNO.2fVaTeaB38.Ov2PRHPh7E2J5paDH.xEubD5upSil
 QrwjD9YPBnB96Pkah7L8.5TP1HOKAHzVnOZdDo36CTfl9ay9POsakr0JwwhqUOwzjL6IOdtYc5s_
 UPbCxR9CFiUT0nNaoY5S2eMtnc.aEv1v.LIJuLrUHaEJSEptgnn3g0aVIGKkMTGvtoPI1h4P3
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: aafb6f75-6179-404a-8eca-4c8e50d37cec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Sun, 18 May 2025 09:08:01 +0000
Received: by hermes--production-gq1-74d64bb7d7-k2g2q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c07c4a4ea2b90ef9265870a2a8be7fd4;
          Sun, 18 May 2025 08:57:47 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: krzk@kernel.org
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] nfc: s3fwrn5: Correct Samsung "Electronics" spelling in copyright headers
Date: Sun, 18 May 2025 01:57:27 -0700
Message-ID: <20250518085734.88890-2-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
References: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the misspelling in NFC-related drivers.

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
 9 files changed, 11 insertions(+), 11 deletions(-)

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
 
-- 
2.43.0


