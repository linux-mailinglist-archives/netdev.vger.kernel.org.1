Return-Path: <netdev+bounces-54004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4FC80596F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B319B20DAF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA263DC1;
	Tue,  5 Dec 2023 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="D4d7SnqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD0C3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso2217739e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792270; x=1702397070; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IROkBofgYBPHLL7MASRBy8ZaJAM3vCbDjnYQkR8ofoE=;
        b=D4d7SnqFflkTbRQjCnwWIj97Jn/TljQmdRbGu9KGCq7jmAZxwEBfHvTauXwLRsLxi4
         nT8dVbhUDIs+Q5flR1JJrSokOPyDK96RF2xGLFspbH9hOX6Y1s0mBKrMy+cTBeugRJG9
         veW88GY7yCyKvN88BOzW10/s2RnDaKcqYkeW1VfMepHnw4FHdn4gmKkVeQSX0lXIxY8I
         MaHFhHoDwmDuDhAojLpjAT5+MrsFpDMDyF5QEWoxDu5loTbI2KhLYMRToa4oSE1iUU1Z
         je175bhO4kowwbt/hKCaAK2BYPJxOnqNT0iAMFxi+D8FLGslgyl1Kyvm/rZ2e3csVlv4
         X3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792270; x=1702397070;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IROkBofgYBPHLL7MASRBy8ZaJAM3vCbDjnYQkR8ofoE=;
        b=IUzxto/8XtjiPYORQfgW49v6Uy77eMYFbWpwgwaSBVyn1SKxeLPvpD9L53K3bKL8Bv
         /xBJE81SPr+iKBcGjg2bnvRIUeYAftjJ7BS7Ns6KV/XTgyCJ/fz5zJr3LrcO85jcJ3rf
         MYp2Njv5SnegeyZS5qFfihxjQ99r0njx7M35+VDpqZedcdm3U13d/OtiKqTHySijq5X1
         sSfUS4bfpUUncRs5KzyJtnBjN66UVoz1/HGatd7PhsIVNeBLxVW6ab+3osOSXYY7SFKL
         QRw861g+AiunbTvDlUggDvucdvw2nxF/H5pQ0JVeja6/kKJAHL4QrVftAKOJiTWnyN/P
         BIjQ==
X-Gm-Message-State: AOJu0YwR1eGiBjbVXPTshyhIlOiMrqTZ4WBtKjBGpweIj21oZwzJZ2SE
	mn8tYDBYcbNcbhhkkyQI1ync9w==
X-Google-Smtp-Source: AGHT+IHSsk9dAW+O6PoatAyz3ImJ9nOit1tPbWKrBVR0AMm0YZSRIL6MMMDhcvydGCphvoq5ntEqLg==
X-Received: by 2002:a05:6512:3604:b0:50b:f03c:1eb2 with SMTP id f4-20020a056512360400b0050bf03c1eb2mr989747lfs.20.1701792269632;
        Tue, 05 Dec 2023 08:04:29 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:28 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 1/6] net: dsa: mv88e6xxx: Push locking into stats snapshotting
Date: Tue,  5 Dec 2023 17:04:13 +0100
Message-Id: <20231205160418.3770042-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205160418.3770042-1-tobias@waldekranz.com>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This is more consistent with the driver's general structure.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42b1acaca33a..95a9dbd60aa6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -931,10 +931,16 @@ static void mv88e6xxx_mac_link_up(struct dsa_switch *ds, int port,
 
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
@@ -1272,16 +1278,11 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
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


