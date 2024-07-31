Return-Path: <netdev+bounces-114506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCF942C0F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77F61C23099
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB011AD9E9;
	Wed, 31 Jul 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4zgWYS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843531AC45D;
	Wed, 31 Jul 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422067; cv=none; b=KC7Xhrsh6c6URr1PFbkl7vrnqdQ9ucgDxfXTxIi+vx/Jm4uZFLoL9LI0Y1zWEB6hySl0lIntDgeiZI5r2oQ6dxoAfMYpW34Wf2MEPOaDZPOERmFR1OCNg3j2KpeV622mOmrwdUxHlVcl38ue7Vi9KRgD3Y6yD0szhQehLipmd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422067; c=relaxed/simple;
	bh=5Sey1WJ5331kZ/cuoYVNbnE0u0kbTfsMiS5RuMAl0Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1TB7rUUeuc09PkKbnGMn4h1njAhww3Hzj5vA2A66vSU6mBS5b/hkBEGwz21n7xj+ZwXkCznetogkT0EVDObXaqTn9Oyg7jCGFWnFcVh1rhff9V7yCkg3Aef2h8gYAse5awIkuch96PFHisZ7ZT057tFydoyScpf5Tpc9iz+ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4zgWYS0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a94478a4eso151773666b.1;
        Wed, 31 Jul 2024 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422064; x=1723026864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQCKyqTCal9KZI20i//lzBe86huK8vRGAy9oESd4Jd8=;
        b=i4zgWYS0/pXTUr7r+siR2CkMoslGA0VIfSb0m8Ea243mOaQNaCPtyMmxuI8HyP9uik
         a26dEep/GqiZ6TvM6Z981eC3YR2CrgXmQhe3PHQEQrYXRlg/aD/w68uf/g5i7X7ZQf1D
         oZqPqCxvrFsKiecsxzrQBDLF8suRzMNkty34Uv8qJPWgD5ANKPDjsA53f5ze5m6BjMXq
         K7277Pq6IXfFMkZ/aenL7w61k4jEosaXvgCqO/pHyVml2mvOWRnsMUTEobTyv0FbPUDA
         TG7tJvJWdzFRwtZJwDuVR13DQfuJG+q7+7bz9YsMFVxfT+5qJ8bTc+8liiEseBnLKzbj
         8mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422064; x=1723026864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQCKyqTCal9KZI20i//lzBe86huK8vRGAy9oESd4Jd8=;
        b=dC9R4g2oK+FhzWtkRqFwz4YhyhAhS/OA2mMzVYgz099PWk8+eyU3c+ADqZCu4AtWnP
         O/FNFjV2/m9J8VQV+c+VzfVUdOtHU/+mgfZHG/K0RjByhI+XqlfymUaBdjtQV+NM8WYI
         WUGASP8XO/drOJ9/sUc70LBZcKodK1p365M1cBuwi4d+QU0AweA9kkUrfVyDdOf2k2Oj
         myXbmWrymcNmR2qAthaS2b7cxI52cIFc1Mvn0MCEVQcXbCStk9m2kz6aTFpWDUbP4SdN
         hUhynC0In3qmi4xTnjs/IBLL4O94I6c0JZYp9NFrad4+FYsGZ+pd9VxJ9OpB6/E5UKJa
         3Sdw==
X-Forwarded-Encrypted: i=1; AJvYcCU0aDSCWL3YjZ2B/j142u0GXetQ0G1RX6Jl5j7fdNSyJnzY3tfpLwcpypVvE8SgS7Wfyl0fYoeGs+xZkV/0ZapNUcEgdeGN
X-Gm-Message-State: AOJu0YxydrDlHsv3Uj/JtzuwrGdY7L6wYDBqea0snLAowfVRKQSwU3K+
	+vI0TydlxyBg1idCACdEQrJKYtTyV6PJyslUeIabMghPnt4cLSXflGvWrzvPVUY=
X-Google-Smtp-Source: AGHT+IG9/DYN3ZNTEtYoo6FQiWuOpopKp1+FN2RYfpMC1UxIUPmjb+EIxfbD23l/kL5wgIJ4EoQkbQ==
X-Received: by 2002:a17:907:1c19:b0:a7a:b561:356d with SMTP id a640c23a62f3a-a7d85a62d9cmr474210566b.26.1722422063829;
        Wed, 31 Jul 2024 03:34:23 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm751930766b.201.2024.07.31.03.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:34:23 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 5/5] net: dsa: microchip: check erratum workaround through indirect register read
Date: Wed, 31 Jul 2024 12:34:03 +0200
Message-ID: <20240731103403.407818-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731103403.407818-1-vtpieter@gmail.com>
References: <20240731103403.407818-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Check the erratum workaround application which ensures in addition
that indirect register write and read work as expected.

Commit b7fb7729c94f ("net: dsa: microchip: fix register write order in
ksz8_ind_write8()") would have been found faster like this.

Also fix the register naming as in the datasheet.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8795.c     | 13 +++++++++++--
 drivers/net/dsa/microchip/ksz8795_reg.h |  4 ++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 8fe423044109..187301fe94c9 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1834,6 +1834,7 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
 static int ksz8_handle_global_errata(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	u8 data = 0xff;
 	int ret = 0;
 
 	/* KSZ87xx Errata DS80000687C.
@@ -1842,8 +1843,16 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
 	 *   KSZ879x/KSZ877x/KSZ876x and some EEE link partners may result in
 	 *   the link dropping.
 	 */
-	if (dev->info->ksz87xx_eee_link_erratum)
-		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
+	if (dev->info->ksz87xx_eee_link_erratum) {
+		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, 0);
+		if (!ret)
+			ret = ksz8_ind_read8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, &data);
+	}
+
+	if (!ret && data) {
+		dev_err(dev->dev, "failed to disable EEE next page exchange (erratum)\n");
+		return -EIO;
+	}
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 69566a5d9cda..cc6cac97c369 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -764,8 +764,8 @@
 #define IND_ACC_TABLE(table)		((table) << 8)
 
 /* */
-#define REG_IND_EEE_GLOB2_LO		0x34
-#define REG_IND_EEE_GLOB2_HI		0x35
+#define REG_IND_EEE_GLOB2_HI		0x34
+#define REG_IND_EEE_GLOB2_LO		0x35
 
 /**
  * MIB_COUNTER_VALUE			00-00000000-3FFFFFFF
-- 
2.43.0


