Return-Path: <netdev+bounces-71673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE1854ACC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6061286D43
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D354BD8;
	Wed, 14 Feb 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYLoW+hH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144C29437
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918921; cv=none; b=qPRsqBDvtzySbnMcZ/ADRwnpxUVt8Y1DMiK/uoHt0TEx0YEv2OFPEDRlLPPQyBuwIRjUfnzEFU8ChZCPU97CLrmlS+5jeU8r/E946AMznMhEZt/D2UylSP2z4Bsm+XmhKCJZ8IvnIv/Fn0TZrJrFBt3rQ3fFCzPhzB1nVQbE/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918921; c=relaxed/simple;
	bh=YRFhsfU3XbxA+dSm9S9w6YlWJuCy7pb8ayj8O3Fjzgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJDkSGSDHV2hTZ3UGs+Ud5QtypbA7M1zUsGC82w7IqcXwAL4gDGAVPWbdI0vZ1kX0B171riPGBesz1NfyhOkLBBDxaxw9DMCg8i6L35DQAZJgENn8xtkSdRbXEE8XeyOFbGoROtr5smYMW9jgUq/HC5JfX9kA8mbi5GwvfAb+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYLoW+hH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd3aea2621so16096241fa.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707918917; x=1708523717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bge3woz9reZZ7j90P54P6Avl+VVgU9e4T+NCf8bDjoE=;
        b=aYLoW+hHTH7ghlLVq8KwRd4WpRQEfSqOMb/Rmj4l0/BKTuAurUJtMTyQLcFuzk5z+K
         2KBClekOJqM9yebdj/wlfoI1tp51o40RAn0vpGBHlrRxhgEks03/X8PIEGE7ZSybANWi
         ngnpK5RS77ZXgF+92LIT0oacBZX2QvZtNCakb7WIETl88vnkg2oyQt5GR4ZmNqhXg0Jk
         yCPNGeDrtoeYMAfQs2EAAQeKgTrcnMKhiO8QyipkLSrF/bDTnSMy6t4+oGdtPWspTp90
         ZPBuXAmDHHBVRwdIx8nLeO66h+yCma6VQZXqLKaO3bhzw7iyR9o4eZ1tczC2NxnPLFDV
         kx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707918917; x=1708523717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bge3woz9reZZ7j90P54P6Avl+VVgU9e4T+NCf8bDjoE=;
        b=vehgug3HmihoaNV2ALXqW24my1IwizZyhZ1qLf3K8rn+iNHHf0xRCqHk7N/U1Vyxdy
         71A+Fh35cH/yjFQoz69cQZZFzL1jLOJXf9HWhevYeLKP6SMGqlspXBmNpnb3J0XATR0c
         h7kPDwZYMRuUeUdZ1ztPs7WkAb287wK9CueisIWYC6FfjBXg2Hb2Sy6T7Ns/UWTpc9A0
         +4HscmiV8TdqU5r2CgtqoRDEX+IU/aqMEC81kzqJHCW23V/ZVlCV7YM3VZXseNO60Ep9
         /u3/HhgcWdkI0ZbN0C62eqzNrhWm7/AnRrPTQuoWYmypWY2uiVidX4+pAo1Y/iKQiL7u
         EQCA==
X-Gm-Message-State: AOJu0YzylS3k6XvsLucQmTudwpfpeZlpknvpEKmbR3kwdeTuo3O52itc
	rpemzUI5ftUi3gs18TbwT37YCe6W90AUmSb0WUrUkOkFDhm82o3J
X-Google-Smtp-Source: AGHT+IHlG9KTmAr53Ip3QKrXoWBlmDiScgWPn2cSFm02s8GYldzy4HX9aMuLKHqVZHAh52REH2SOKg==
X-Received: by 2002:a05:6512:3d02:b0:511:63ce:c3ee with SMTP id d2-20020a0565123d0200b0051163cec3eemr2241450lfv.6.1707918917331;
        Wed, 14 Feb 2024 05:55:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYy672eNpiGzhMP+pdTNMyCr0/s5rbXALVtoPNtWEnAL07dvCt7+GzGHjaVa0GS3knZ8nTKWKs9ciXt+bW4eKROw==
Received: from localhost.localdomain ([83.217.200.232])
        by smtp.gmail.com with ESMTPSA id u1-20020a056512128100b005117583a519sm1683621lfs.180.2024.02.14.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:55:16 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH ethtool] ethtool: put driver specific code into drivers dir
Date: Wed, 14 Feb 2024 08:55:05 -0500
Message-Id: <20240214135505.7721-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the patch moves the driver specific code in drivers
directory

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 Makefile.am                              | 18 +++++++++++-------
 amd8111e.c => drivers/amd8111e.c         |  0
 at76c50x-usb.c => drivers/at76c50x-usb.c |  0
 bnxt.c => drivers/bnxt.c                 |  0
 cmis.c => drivers/cmis.c                 |  0
 cmis.h => drivers/cmis.h                 |  0
 cpsw.c => drivers/cpsw.c                 |  0
 de2104x.c => drivers/de2104x.c           |  0
 dsa.c => drivers/dsa.c                   |  0
 e100.c => drivers/e100.c                 |  0
 e1000.c => drivers/e1000.c               |  0
 et131x.c => drivers/et131x.c             |  0
 fec.c => drivers/fec.c                   |  0
 fec_8xx.c => drivers/fec_8xx.c           |  0
 fjes.c => drivers/fjes.c                 |  0
 fsl_enetc.c => drivers/fsl_enetc.c       |  0
 hns3.c => drivers/hns3.c                 |  0
 ibm_emac.c => drivers/ibm_emac.c         |  0
 igb.c => drivers/igb.c                   |  0
 igc.c => drivers/igc.c                   |  0
 ixgb.c => drivers/ixgb.c                 |  0
 ixgbe.c => drivers/ixgbe.c               |  0
 ixgbevf.c => drivers/ixgbevf.c           |  0
 lan743x.c => drivers/lan743x.c           |  0
 lan78xx.c => drivers/lan78xx.c           |  0
 marvell.c => drivers/marvell.c           |  0
 natsemi.c => drivers/natsemi.c           |  0
 pcnet32.c => drivers/pcnet32.c           |  0
 qsfp.c => drivers/qsfp.c                 |  0
 qsfp.h => drivers/qsfp.h                 |  0
 realtek.c => drivers/realtek.c           |  0
 sfc.c => drivers/sfc.c                   |  0
 sff-common.c => drivers/sff-common.c     |  0
 sff-common.h => drivers/sff-common.h     |  0
 sfpdiag.c => drivers/sfpdiag.c           |  0
 sfpid.c => drivers/sfpid.c               |  0
 smsc911x.c => drivers/smsc911x.c         |  0
 stmmac.c => drivers/stmmac.c             |  0
 tg3.c => drivers/tg3.c                   |  0
 tse.c => drivers/tse.c                   |  0
 vioc.c => drivers/vioc.c                 |  0
 vmxnet3.c => drivers/vmxnet3.c           |  0
 netlink/module-eeprom.c                  |  6 +++---
 43 files changed, 14 insertions(+), 10 deletions(-)
 rename amd8111e.c => drivers/amd8111e.c (100%)
 rename at76c50x-usb.c => drivers/at76c50x-usb.c (100%)
 rename bnxt.c => drivers/bnxt.c (100%)
 rename cmis.c => drivers/cmis.c (100%)
 rename cmis.h => drivers/cmis.h (100%)
 rename cpsw.c => drivers/cpsw.c (100%)
 rename de2104x.c => drivers/de2104x.c (100%)
 rename dsa.c => drivers/dsa.c (100%)
 rename e100.c => drivers/e100.c (100%)
 rename e1000.c => drivers/e1000.c (100%)
 rename et131x.c => drivers/et131x.c (100%)
 rename fec.c => drivers/fec.c (100%)
 rename fec_8xx.c => drivers/fec_8xx.c (100%)
 rename fjes.c => drivers/fjes.c (100%)
 rename fsl_enetc.c => drivers/fsl_enetc.c (100%)
 rename hns3.c => drivers/hns3.c (100%)
 rename ibm_emac.c => drivers/ibm_emac.c (100%)
 rename igb.c => drivers/igb.c (100%)
 rename igc.c => drivers/igc.c (100%)
 rename ixgb.c => drivers/ixgb.c (100%)
 rename ixgbe.c => drivers/ixgbe.c (100%)
 rename ixgbevf.c => drivers/ixgbevf.c (100%)
 rename lan743x.c => drivers/lan743x.c (100%)
 rename lan78xx.c => drivers/lan78xx.c (100%)
 rename marvell.c => drivers/marvell.c (100%)
 rename natsemi.c => drivers/natsemi.c (100%)
 rename pcnet32.c => drivers/pcnet32.c (100%)
 rename qsfp.c => drivers/qsfp.c (100%)
 rename qsfp.h => drivers/qsfp.h (100%)
 rename realtek.c => drivers/realtek.c (100%)
 rename sfc.c => drivers/sfc.c (100%)
 rename sff-common.c => drivers/sff-common.c (100%)
 rename sff-common.h => drivers/sff-common.h (100%)
 rename sfpdiag.c => drivers/sfpdiag.c (100%)
 rename sfpid.c => drivers/sfpid.c (100%)
 rename smsc911x.c => drivers/smsc911x.c (100%)
 rename stmmac.c => drivers/stmmac.c (100%)
 rename tg3.c => drivers/tg3.c (100%)
 rename tse.c => drivers/tse.c (100%)
 rename vioc.c => drivers/vioc.c (100%)
 rename vmxnet3.c => drivers/vmxnet3.c (100%)

diff --git a/Makefile.am b/Makefile.am
index b9e06ad..8859168 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,13 +17,17 @@ ethtool_SOURCES = ethtool.c uapi/linux/const.h uapi/linux/ethtool.h internal.h \
 		  list.h
 if ETHTOOL_ENABLE_PRETTY_DUMP
 ethtool_SOURCES += \
-		  amd8111e.c de2104x.c dsa.c e100.c e1000.c et131x.c igb.c	\
-		  fec.c fec_8xx.c fsl_enetc.c ibm_emac.c ixgb.c ixgbe.c \
-		  natsemi.c pcnet32.c realtek.c tg3.c marvell.c vioc.c \
-		  smsc911x.c at76c50x-usb.c sfc.c stmmac.c	\
-		  sff-common.c sff-common.h sfpid.c sfpdiag.c	\
-		  ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h fjes.c lan78xx.c \
-		  igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c hns3.c
+		  drivers/amd8111e.c drivers/de2104x.c drivers/dsa.c drivers/e100.c \
+		  drivers/e1000.c drivers/et131x.c drivers/igb.c drivers/fec.c \
+		  drivers/fec_8xx.c drivers/fsl_enetc.c drivers/ibm_emac.c drivers/ixgb.c \
+		  drivers/ixgbe.c drivers/natsemi.c drivers/pcnet32.c drivers/realtek.c \
+		  drivers/tg3.c drivers/marvell.c drivers/vioc.c drivers/smsc911x.c \
+		  drivers/at76c50x-usb.c drivers/sfc.c drivers/stmmac.c	\
+		  drivers/sff-common.c drivers/sff-common.h drivers/sfpid.c drivers/sfpdiag.c \
+		  drivers/ixgbevf.c drivers/tse.c drivers/vmxnet3.c drivers/qsfp.c \
+		  drivers/qsfp.h drivers/fjes.c drivers/lan78xx.c drivers/igc.c \
+		  drivers/cmis.c drivers/cmis.h drivers/bnxt.c drivers/cpsw.c \
+		  drivers/lan743x.c drivers/hns3.c
 endif
 
 if ENABLE_BASH_COMPLETION
diff --git a/amd8111e.c b/drivers/amd8111e.c
similarity index 100%
rename from amd8111e.c
rename to drivers/amd8111e.c
diff --git a/at76c50x-usb.c b/drivers/at76c50x-usb.c
similarity index 100%
rename from at76c50x-usb.c
rename to drivers/at76c50x-usb.c
diff --git a/bnxt.c b/drivers/bnxt.c
similarity index 100%
rename from bnxt.c
rename to drivers/bnxt.c
diff --git a/cmis.c b/drivers/cmis.c
similarity index 100%
rename from cmis.c
rename to drivers/cmis.c
diff --git a/cmis.h b/drivers/cmis.h
similarity index 100%
rename from cmis.h
rename to drivers/cmis.h
diff --git a/cpsw.c b/drivers/cpsw.c
similarity index 100%
rename from cpsw.c
rename to drivers/cpsw.c
diff --git a/de2104x.c b/drivers/de2104x.c
similarity index 100%
rename from de2104x.c
rename to drivers/de2104x.c
diff --git a/dsa.c b/drivers/dsa.c
similarity index 100%
rename from dsa.c
rename to drivers/dsa.c
diff --git a/e100.c b/drivers/e100.c
similarity index 100%
rename from e100.c
rename to drivers/e100.c
diff --git a/e1000.c b/drivers/e1000.c
similarity index 100%
rename from e1000.c
rename to drivers/e1000.c
diff --git a/et131x.c b/drivers/et131x.c
similarity index 100%
rename from et131x.c
rename to drivers/et131x.c
diff --git a/fec.c b/drivers/fec.c
similarity index 100%
rename from fec.c
rename to drivers/fec.c
diff --git a/fec_8xx.c b/drivers/fec_8xx.c
similarity index 100%
rename from fec_8xx.c
rename to drivers/fec_8xx.c
diff --git a/fjes.c b/drivers/fjes.c
similarity index 100%
rename from fjes.c
rename to drivers/fjes.c
diff --git a/fsl_enetc.c b/drivers/fsl_enetc.c
similarity index 100%
rename from fsl_enetc.c
rename to drivers/fsl_enetc.c
diff --git a/hns3.c b/drivers/hns3.c
similarity index 100%
rename from hns3.c
rename to drivers/hns3.c
diff --git a/ibm_emac.c b/drivers/ibm_emac.c
similarity index 100%
rename from ibm_emac.c
rename to drivers/ibm_emac.c
diff --git a/igb.c b/drivers/igb.c
similarity index 100%
rename from igb.c
rename to drivers/igb.c
diff --git a/igc.c b/drivers/igc.c
similarity index 100%
rename from igc.c
rename to drivers/igc.c
diff --git a/ixgb.c b/drivers/ixgb.c
similarity index 100%
rename from ixgb.c
rename to drivers/ixgb.c
diff --git a/ixgbe.c b/drivers/ixgbe.c
similarity index 100%
rename from ixgbe.c
rename to drivers/ixgbe.c
diff --git a/ixgbevf.c b/drivers/ixgbevf.c
similarity index 100%
rename from ixgbevf.c
rename to drivers/ixgbevf.c
diff --git a/lan743x.c b/drivers/lan743x.c
similarity index 100%
rename from lan743x.c
rename to drivers/lan743x.c
diff --git a/lan78xx.c b/drivers/lan78xx.c
similarity index 100%
rename from lan78xx.c
rename to drivers/lan78xx.c
diff --git a/marvell.c b/drivers/marvell.c
similarity index 100%
rename from marvell.c
rename to drivers/marvell.c
diff --git a/natsemi.c b/drivers/natsemi.c
similarity index 100%
rename from natsemi.c
rename to drivers/natsemi.c
diff --git a/pcnet32.c b/drivers/pcnet32.c
similarity index 100%
rename from pcnet32.c
rename to drivers/pcnet32.c
diff --git a/qsfp.c b/drivers/qsfp.c
similarity index 100%
rename from qsfp.c
rename to drivers/qsfp.c
diff --git a/qsfp.h b/drivers/qsfp.h
similarity index 100%
rename from qsfp.h
rename to drivers/qsfp.h
diff --git a/realtek.c b/drivers/realtek.c
similarity index 100%
rename from realtek.c
rename to drivers/realtek.c
diff --git a/sfc.c b/drivers/sfc.c
similarity index 100%
rename from sfc.c
rename to drivers/sfc.c
diff --git a/sff-common.c b/drivers/sff-common.c
similarity index 100%
rename from sff-common.c
rename to drivers/sff-common.c
diff --git a/sff-common.h b/drivers/sff-common.h
similarity index 100%
rename from sff-common.h
rename to drivers/sff-common.h
diff --git a/sfpdiag.c b/drivers/sfpdiag.c
similarity index 100%
rename from sfpdiag.c
rename to drivers/sfpdiag.c
diff --git a/sfpid.c b/drivers/sfpid.c
similarity index 100%
rename from sfpid.c
rename to drivers/sfpid.c
diff --git a/smsc911x.c b/drivers/smsc911x.c
similarity index 100%
rename from smsc911x.c
rename to drivers/smsc911x.c
diff --git a/stmmac.c b/drivers/stmmac.c
similarity index 100%
rename from stmmac.c
rename to drivers/stmmac.c
diff --git a/tg3.c b/drivers/tg3.c
similarity index 100%
rename from tg3.c
rename to drivers/tg3.c
diff --git a/tse.c b/drivers/tse.c
similarity index 100%
rename from tse.c
rename to drivers/tse.c
diff --git a/vioc.c b/drivers/vioc.c
similarity index 100%
rename from vioc.c
rename to drivers/vioc.c
diff --git a/vmxnet3.c b/drivers/vmxnet3.c
similarity index 100%
rename from vmxnet3.c
rename to drivers/vmxnet3.c
diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index fe02c5a..05104b0 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -9,9 +9,9 @@
 #include <stdio.h>
 #include <stddef.h>
 
-#include "../sff-common.h"
-#include "../qsfp.h"
-#include "../cmis.h"
+#include "../drivers/sff-common.h"
+#include "../drivers/qsfp.h"
+#include "../drivers/cmis.h"
 #include "../internal.h"
 #include "../common.h"
 #include "../list.h"
-- 
2.30.2


