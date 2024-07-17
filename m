Return-Path: <netdev+bounces-111930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED19342A6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AFE1C216AC
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9D1822CD;
	Wed, 17 Jul 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9sOJwvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69035184115;
	Wed, 17 Jul 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245077; cv=none; b=RCwSKvbhiOf7D+0blrMliUWqQcxY6ar3Zq27UE/nXzATvZjrvfqsoaahyPpyV9pKNz5TEImTp73a+gSJeSkNnBgHZg4edtS9TXb4FeXVZVTjgxc2lS4yMEHt2As/TxFOOKHAmKfc2+Ii6qV3uPnbw1I+wZZCeYlylz7GXIetnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245077; c=relaxed/simple;
	bh=JzttCK6H+is1qlb5VBj+uaH8ZaPnA48Gs+yyM+Jf1LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8aGRV7NziEAPEnvzczF3W9omWSTvmw5Dfx24ZlRIkvhKJpfNBHZNJstg4uX8hhLsPFimIGIQdFqNHjQym/zgFThaEunfJMe+2QyxnfBgmEQAT2R/taCraOP0pTwfhWkDtVnhZMzX3xhIOC3HznDlQtOwe2AOGgiUpUpbEkJzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9sOJwvZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso432945e9.0;
        Wed, 17 Jul 2024 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245074; x=1721849874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2f9taHZsSGuvM/1JBxKMQL/lWfB8enQk/dfH1x62Ak=;
        b=d9sOJwvZRSlphaF+ZJpszYaFhhxnyO7lGSmAEI4Djp4FwG9JRWuLHEMcfoXOgm7Ra3
         DOZhro2fv/MY88uYAag7H43h//G10VGeqXhBv1uOQsXgxqruODp1k980oMTVAa+lD4Bk
         V4wSz9/Um8ih90VStPqWc538nKTSTTM1E6rDkqqD6C5g12QY3aeRhv9/JIqOIippJ2B/
         RjIuc5by+Xk6giPmuQIm0i4y/1gzo4AM3qZN497+M9Ufv3sky7UUtm425lpjBvMM/z0f
         dZ/242W5n5yNjSS+h+deQY6aUrayGE5YboO4wDPRjf2vG1mvfppdvJn5+tmcsE1lgilY
         QbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245074; x=1721849874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2f9taHZsSGuvM/1JBxKMQL/lWfB8enQk/dfH1x62Ak=;
        b=jeuxt4ZQ3xXJxz78Z4mn6mhrAy1taC0pxBFIsdKdf1A9Xww09n66ACJj7zhVx6B79E
         b4R/jSkcTPbZigLcdr00qt4qbKOKqIDmqfqP0SD4pDQpBj/JR6ltnrv3gFX8R8iYi3un
         t3TZ1xgQRd1z40cwscZAHt0O2zxcgP/XfgCPkztC5xMjqvP8C6VoXIgg+13x8BRvOLY9
         i1kQjioEhbGBRZ7OdRH6zU31DmtK4WrCg28aTbPzaSsdEjXAwXdPQnY5kQ52bqtbmAVe
         M2WUT7HBc89O4j7JYZnZ4qFzx4sCfpt6yzKADZzey+3RsyVsqo9673WZJkSLFMqdum1M
         fM9A==
X-Forwarded-Encrypted: i=1; AJvYcCU0RMvUC3X7oqncJDHewcjOhizv/KgCuYE9ipDKO2f3n/O+sMZyzph06C5AzvDrdEvLD5gBVoQcK9C0gK1uNSZiKHg1lueD
X-Gm-Message-State: AOJu0YysajXOonp2kQU/p2VUy2/4PPnHMxJqiaGU7WE4OYW7c6hZvUw9
	ZoB3nxodpalBuyK/nLroKjMfYf032SAK3HGD0nEbUiYp4MMFbpH8mIqu9ea+
X-Google-Smtp-Source: AGHT+IEtysbefL+fbJfBT+LYWFfEjpHq4h1WunesYdFoiKGdEmxcgnu3DW9ozGfBeG9sTQHzTKzU0w==
X-Received: by 2002:adf:fa03:0:b0:368:5d2:179 with SMTP id ffacd0b85a97d-36831755ea0mr1967973f8f.56.1721245073542;
        Wed, 17 Jul 2024 12:37:53 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::101:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm3080535a12.68.2024.07.17.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:37:53 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH 3/4] net: dsa: microchip: check erratum workaround through indirect register read
Date: Wed, 17 Jul 2024 21:37:24 +0200
Message-ID: <20240717193725.469192-4-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717193725.469192-3-vtpieter@gmail.com>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com>
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
 drivers/net/dsa/microchip/ksz8795.c     | 10 ++++++++--
 drivers/net/dsa/microchip/ksz8795_reg.h |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 49081e9a8cb0..40851174f448 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1974,6 +1974,7 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret = 0;
+	u8 data = 0xff;
 
 	/* KSZ87xx Errata DS80000687C.
 	 * Module 2: Link drops with some EEE link partners.
@@ -1981,8 +1982,13 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
 	 *   KSZ879x/KSZ877x/KSZ876x and some EEE link partners may result in
 	 *   the link dropping.
 	 */
-	if (dev->info->ksz87xx_eee_link_erratum)
-		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
+	if (dev->info->ksz87xx_eee_link_erratum) {
+		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, 0);
+		if (!ret)
+			ret = ksz8_ind_read8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, &data);
+		if (!ret && data)
+			dev_err(dev->dev, "failed to disable EEE next page exchange (erratum)\n");
+	}
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 884e899145dd..8d18507c92bf 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -767,8 +767,8 @@
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


