Return-Path: <netdev+bounces-57463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CA1813223
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D6E1C21A3A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3D4F216;
	Thu, 14 Dec 2023 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="eAbUIwQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07408123
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2cc43f9e744so7964461fa.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561847; x=1703166647; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NMKtUlflU+y7YGh25EmQnQya00sERw4Blzh3x2gkMRY=;
        b=eAbUIwQ07+Og9C6ubniAQO5gghDM6Xx9ywOM04ArrAeH4Y/KiveA9+jmggqeyosoTH
         8QVNE6w10V2fKZe8343DgJuQo+/R3frrQ1rzlcrR6S8//zPCMGdJW08XZMB/zAyRWy7y
         UHsEFtYd52TsugnFVyyk364B7OSVLgvsaOIQkshmnYetk6BXVaJzzPR87hvQZczZAzua
         qr709Hy4G0L4Z34wkSOAm6RqksTziFq8eelFoM4U+q1qbXbCGt/t36NoBbkoRo6cBlMp
         kiXJNdJTkCufdB36PWdOSK7gRwObfZmGOdN6axvX2dmsVtUiNw5RT/r+Q62IsxPFlMIL
         bLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561847; x=1703166647;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMKtUlflU+y7YGh25EmQnQya00sERw4Blzh3x2gkMRY=;
        b=xE7kDmeizxKXotxcQ+p/PpzpL/p4kG0aktqNMlreKjYhnJsWnCiZMSpn6o7wj5AD0N
         MWHZ3sfXAt8s1K/vv6muPUU1R53bB5jWZXWJBOOf4LdY3B45sRNKAZugdT/kYWJcrS2d
         ZaVtA33Q89NgVvNfmOyglyBYJwWaIYo7VcVy1JVKhkqsfh8mkpYgbt/8Nx6SrpA7enIh
         0QQSvpiwdutiTSkEfMZQyhZ/P42ZNt/YboAEdtv/YLSkc3LDzWI5e3zVvib0NgYaxB5/
         OF/L/tLm6eECad+CZ9For53bdUfxHQv0+2o8bxTPoJ/pT/6nA7sYn9kk8h8FOIbeHIB9
         s2iw==
X-Gm-Message-State: AOJu0YyX5ABgpY0lFYrtWAsZhmgWmD9PHmqi6tsSYoGktpH9yWvDQNIn
	n1qoJlzWG+9kMvCXMSjCI7uhAB+2dg08sPxxHBg=
X-Google-Smtp-Source: AGHT+IHDqJn7oY4PNvwwN9NR9vyxPBc3+Zrui007YMSrOFCOj1MZWOsZDzQD2nzJ+1di+xmyus/XbQ==
X-Received: by 2002:a05:651c:24a:b0:2cc:1eb0:7141 with SMTP id x10-20020a05651c024a00b002cc1eb07141mr4768142ljn.51.1702561847191;
        Thu, 14 Dec 2023 05:50:47 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:46 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 net-next 1/8] net: dsa: mv88e6xxx: Push locking into stats snapshotting
Date: Thu, 14 Dec 2023 14:50:22 +0100
Message-Id: <20231214135029.383595-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
References: <20231214135029.383595-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This is more consistent with the driver's general structure.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 07a22c74fe81..4bd3ceffde17 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -943,10 +943,16 @@ static void mv88e6xxx_mac_link_up(struct dsa_switch *ds, int port,
 
 static int mv88e6xxx_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
 {
+	int err;
+
 	if (!chip->info->ops->stats_snapshot)
 		return -EOPNOTSUPP;
 
-	return chip->info->ops->stats_snapshot(chip, port);
+	mv88e6xxx_reg_lock(chip);
+	err = chip->info->ops->stats_snapshot(chip, port);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
 }
 
 static struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
@@ -1284,16 +1290,11 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int ret;
 
-	mv88e6xxx_reg_lock(chip);
-
 	ret = mv88e6xxx_stats_snapshot(chip, port);
-	mv88e6xxx_reg_unlock(chip);
-
 	if (ret < 0)
 		return;
 
 	mv88e6xxx_get_stats(chip, port, data);
-
 }
 
 static int mv88e6xxx_get_regs_len(struct dsa_switch *ds, int port)
-- 
2.34.1


