Return-Path: <netdev+bounces-191745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF869ABD074
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2207189FF5F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E4721129A;
	Tue, 20 May 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oPz3t/CA"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-19.consmr.mail.sg3.yahoo.com (sonic306-19.consmr.mail.sg3.yahoo.com [106.10.241.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F67BE5E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726331; cv=none; b=aLSt3leUTMfPVHS6NH7BTjXM8GyoAuLqz0Cr74bZyXIg7Jh694E/La+dyaz0NHJAMVu8BGaXirVocG6leXYGm30cy1uHYuFdGJQt+8m3kdrJ3lDPCFV4kTAyTYXd7Y3Yvu2RIJj104119aUtWoh5UxBR1ds1YffhejLFBvIjQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726331; c=relaxed/simple;
	bh=vvWKBexwkfQZ03sAq9Ojn0Zqt5SiYG03IRVvTfvqPZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riL3rB9UJxoXIpnvrV6PcqWocqbDqwKyJJSCAmCcMLuyqzLTvz5udHrdH/jSyGCFkwyywlr140WeJqnEmK0+IVx3KJi7N4JmH2/ESRcDvdTMNM5ryq7PA6enZCPcLv0E5wt5ax/wuSSX2pnUe7c55nTkGu5ayp8Kn97+HwiYHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oPz3t/CA; arc=none smtp.client-ip=106.10.241.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747726321; bh=N8uoUa6Am0nLGOIzto6+l13jmNC8tGFsQPG+3gW2waA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oPz3t/CAz8aN8BR5PgV7LGVXY507AARSu2QGP1cxDRrN2NSHxcj7luLnN/qxp/uaTzAhJLdk0HshLmy1/kNqQV3wWl0nApmbNtDyK3WD9If6yu9/HscqDUybNnVNGhneB6qGk+LHg4Zqcyu1D6uAGMtQ3OElInI+FbFchwjDKDOXmsU4LDf9mQTSJaWPvy7ESazXUZ+9VmNmg9DEXLDwTXrFfbz/+uD3rASOgdyb3iZnV8HSvdFVpntYmAKcequvGxbiZkCDBfj/dntyiW9f5geTjjYcp+wpmXak3sQVpNIn3RWHjjWR3PhML1v3/4D6aFKiYL3IlNmD3W/I3H1qHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747726321; bh=KkhSJHzdbzqrfWE7tfa2284Zop60/IOcL2Ft78nKPy4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k71/wgix3eNFxS4EDSIFjOE+xgdGW6dAya5iRYBll/+q5AL7MUa1Uh2I2VDFFXM14PXGnSvAa3btzV24jXNaeE8CQHlMGbAY/sqQgUedtw63ri5hj8qfNF+Oeuzg18YptvgphdpM5wUN0yWewU/WgkYb6WslKpaSzixySTKARNrCTzz5t6SiOLSIu1TBK/thTGTjE5QeB/dgrZszTURi3xTIz7wuWMslxCiWH7FJlPh8ufOEINOlCiS6B4brmOxCGTg74bQbSMBHQNh/2S/DIMQ1L1KmtPm643UhyxgAv3LEkZQMbFBSD6ozNIO0i/xYOVxbowFtjrb9yLQSkeaYPA==
X-YMail-OSG: Yf8XIygVM1mZIwIWnBhae6KBjpQFTFlIjQhSE2barQYYJ3JepOX.Xycl3S3k2GT
 UlZja4VPuUOo1fdpBWyA_wZz5jB3eZPu_E0maM2ocn1csFKP1BlfMEO2R_8ntP3TufWevFoNaZNj
 e72L.2TUVT0_aQtDptUUqpY9s1sglyExItx0Ez3VU1k91o8RisvIhuNvUqF5uX2UKyOTY_mwFzse
 poOIRcHOQb9BITRb_BAQi2bAnZaTLj5n.0H6bSm_Ppz7FJjHcq2QLP9eAx3NNh_z_F36R81n2q6z
 jC67TEmu1qMmgif2gZDkeSQNAHpEeLSCA7VlUgAcUGfu4dmt.Hjt54Igc6QTtbOHLAGiRcy1FYVH
 MQ5QC34asS9hdqduEVSjCzHEklN74zpbO3GN4MJ9gB_4rAgEXpAma5Rfic6BJcCzKOw22H3E.SmD
 tMOb9YpryD3mxkvAOCBTfsXwTeLeEkqTJ4UXsVcZsAtr5GLolq7pOXY9u8WzJh0cLZUN0.98whCj
 rxoLZ4TL5AUWhCGsBEXQmpOaK1izXccm9xXDcYktLBT.3Rn5Gdad.xk.Gl8KCMmvG_ynQWhysti2
 zIm.chY96DzoIwYaEDT_p1.ZOmagCKsPyFDIuBn_Z3ZE9WoNdxYuCg5HzaPS1nW_a.KnZ6Z7ek6g
 71D_upAmOjB49FyC0JulpnAaMfua1En_4nncD4hK1HqrH4p.dOt3hIG9hqHW3mknfeKVkXqvm9.j
 qgt_IwPgyGATNtXe3hKMukN9FucUYKs467uIi9P5MHI8e_uWcoURcU1s81Smkfc8Qq96zCGsJ7gK
 rQnxp5vc.xJduVhtXT3VKHx..1qOUOrBp7aHqBx2i_iABJP9SmmBOaUGVeSE1KC6UNV_9LAqZC76
 bYKTwDKsoxQjG.7kR_yvvjfKTqdmSFcgLl5_3iYWlob_lJTH0Zy8colj2TMVgLkoIXkuqXUn6_5i
 Axuow97r_fgGmQZV5bBcb8OCb1_UbgVwlo9YEubLejos4.9OPbejt9Ao.umKchAYMTJoAbrKkzyp
 HIBk6jVBUrCp3_1NZ8hcxw0rUEsG2aMWDycLuI2CRlcGByu1.x9PNEyNCJ510Y3YpOGCVDOavqvZ
 _Y172j9Bm0eG..Drs6saGBEjvKiTr850KDzJT6pl7XgkZOfn30oLKPHsnXKrvX0daPcGCE7fjJqI
 hywwdpmHJxpZH3JI54u42.a0NoTBdDre_TIpMZMoynU6eA6F7LWBAWbsgQip2vY_YD96tB0ev2Zm
 OOmaYJmaHbDtpHaUjavp.rxciNfO3aAAbmrPeO7Nm5FXumAfIQGIvrXXiFns4sIc2qAJCu75cc3v
 L9N_D6_YCF1mG2xkjBSxS2LmUy1uTdAQQYLAQb9MvFZtDHLlnjQJxlr48aBsQuBkzB8oGiMpMviJ
 JYJFKZMVK6HFUIJKf1r_90PM_kKetXwA8_sTf4IRzm65BZFQrKDCdSvU3eJtbpCTPftnlFAI4Ze2
 biYnFwWmtq8FTYZRqQqu1dnGM8DcTNAdZKxcufLy_UzF9TsqOdWq4aINUa.dTnMSWYJNNZlPYK1.
 W49GE5KJMfNwZ3x2kU_ExFYQXVC0iNvpaoUnBakOJRXr5LSLrCsp2PmyZazs3ovh6g2O8ce_8Y_2
 EX.uibvTVxUxo8hsKLUJEjSGymN.tH07WzDQTG8TgA5Hu1lHMBwhTAkjmxM8l72VpApr8lAk0Cdm
 vNARm_eFXbQXK3IPG6aBMDyImvFbPDJl3g4sSCc05OnaqDw70bs9ud49jxK5Q6ocSoVLmT9GrU_J
 1lCZl7Nz.CQ5Hyos5XK9ZGeIVlmxT6GQTOukjacdrm3lxi0LCL0gds8IHmIh122lE2565XxCwmE3
 SE9tYofmWroazf5qAi_lCNE9wsDYw6ippSBi8EXCamD6jd3A4ScOUumemvlYaiC2K9AGAkx.0tEr
 j.HVfuK5XUSu9Rz1txRPjlbrqi_ulzGG_NkeULVoqfjxE36SrsAHChBc2cI0at7ZYgvLFz3GckPH
 VeXIpY.NAOdJ6fxg8MNU9EdLNw1D_BhmdpV37.X4Ty.vYILyBVrVdk4Cu2E3QXkklFMfnhuuUrnk
 qrPLlZojz7R6WobYqHxZIVwW_Ko59QOlqhM8i2I82ew_RErOw1Q_HtthwgPwUxEzgc1tcy1uHef5
 Ou2iAoERyuzgt5uhoDAXVmh5b73LT7FabTEb280fJ5h1pcFF4AGVMRf66ObADT83WQzsBDOwiiOh
 eT1qeUj_YPHF89fyN5NyKLbWbhUqCbaJYiJko2GRItyZtCKhyazD9.Gsi2c6tggxAfE3voo0zvfl
 xy0ucJoUn0V3i0eFNsnbenM3.bH3rRn62j4.g5oRATAqgHw--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 7788ade7-b3a9-48ef-a725-1ab67cdd9fe1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Tue, 20 May 2025 07:32:01 +0000
Received: by hermes--production-gq1-74d64bb7d7-5wzx5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1965de6dd6214c4a76ef4d067160fdf;
          Tue, 20 May 2025 07:21:51 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: krzk@kernel.org,
	bongsu.jeon@samsung.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] nfc: Correct Samsung "Electronics" spelling in copyright headers
Date: Tue, 20 May 2025 00:21:19 -0700
Message-ID: <20250520072119.176018-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <906c36f9-f8af-49a3-a2d7-b146a793f1bc@kernel.org>
References: <906c36f9-f8af-49a3-a2d7-b146a793f1bc@kernel.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
 - Missed to add changelog
 - Link to v1: https://lore.kernel.org/lkml/e414c1ca-6e56-4088-b974-3a45eab682c1@kernel.org/

v3:
 - Added changelog for v2 updates
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


