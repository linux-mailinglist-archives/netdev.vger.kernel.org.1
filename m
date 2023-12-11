Return-Path: <netdev+bounces-56112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D980DE4E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FCE1C215AA
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6BF5579D;
	Mon, 11 Dec 2023 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="R2H5icTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307EAD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:00 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf1e32571so5929972e87.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334038; x=1702938838; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6adqSsdvlFnYpSit5snuB5qA4+Arf7GB0YT9t1eyavA=;
        b=R2H5icTt1PTAhTecshw+cOQn90adEEr6Dv59a6JHOi2PozAk6Ht65Y9ZdV/2K7NROs
         1BCvs3wbIHraVt3T2vxBMgoyYvZjEjG3LNydR3+Mx7Gd9vsPt8efvNPaTsVng7WZP8mr
         fyv4vTeb6OS291Fsg32LS6+k6Ugy9IYAB74myj7zSN7cdL9vOyiwWQqrIlNCsbIAcQFm
         jYpCFHo3hkl1VCkeg+rsFztIZGCr946qf1ugVMGKvZuWw7zZ2WlS6AZ3X66F0Q9M/XZX
         ogs2QzdFgTxCvkBOKhtPleojZp3NrtG15mbZ8xM4NIl7zkQKzLDotFZz7h2R9SKUpVYU
         BrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334038; x=1702938838;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6adqSsdvlFnYpSit5snuB5qA4+Arf7GB0YT9t1eyavA=;
        b=LbEltMzNnKfuBcHxaEgypHffF1ejj7m4gF2cvbBhpnU+Dc/iJkG22LKRBQepWvLWFE
         TW1lZDUDhferUHzCLw7O3W3Ab29ws7sFB7I/umEkqqRWn00bNyxBTz9kA47zOFdevCqE
         QrkcHbuLHBvARo1WRWZceXmCri77vbQTzcHwGx/cdnY2jyy4XggE6MagtB9rMXz9yQ+U
         +03DJW9B+328dLHobSq/C6ePJTkJJJ9QGJmo9HMAU61URJqhYvfHheaEBKOO/Hv/OvMV
         elqSZpWUdi93y7KEWa1acwh4LW7dZlrnHyNy0tUzvoE5qur4JOntwGGViuP7YYEaUzWM
         nAgw==
X-Gm-Message-State: AOJu0Yw7ENvp5d3wo5lgx87zg+19YfKkXyQrKVWuUEtGmXrytwMDBwEY
	ZBXx3/ltIS3fj5C2tB4lHPqlQw==
X-Google-Smtp-Source: AGHT+IE5rSftQtxaVewCyXvPa7PWXhk/6BWyqcwtu/VNAvy5V9zngsBwA0JAa/vJ6A+Ohb2DhikUyQ==
X-Received: by 2002:a19:520b:0:b0:50b:f0a3:fb90 with SMTP id m11-20020a19520b000000b0050bf0a3fb90mr2021195lfb.35.1702334038804;
        Mon, 11 Dec 2023 14:33:58 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:33:57 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v3 net-next 1/8] net: dsa: mv88e6xxx: Push locking into stats snapshotting
Date: Mon, 11 Dec 2023 23:33:39 +0100
Message-Id: <20231211223346.2497157-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211223346.2497157-1-tobias@waldekranz.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
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


