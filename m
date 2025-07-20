Return-Path: <netdev+bounces-208540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97721B0C0D6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B604E18C0054
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7428BA92;
	Mon, 21 Jul 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yf55tk1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62618FC91
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092472; cv=none; b=lVQJzVZAgfF6P2w2QU/QYmtFoIG25qXbKTNcKksdfA5dhEHCFUa6VrKSPV88WPzOZJtmT4txKNim2arh8XMSMsVzreyq8vv9ZK/DEgBkpJHis9WkqSJzvpGy8ybdlCxvFzrxpH3v6NL+vMwBOYfMmQTzjDBMrPIpzeUSWmOEBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092472; c=relaxed/simple;
	bh=1FGBxsq44SdTzLltTrnO+dtQlXrqC+a/rAIwXdlkigA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1jfjFJ91iyWv+Rcsz7hWNz2TRdbSscHCrrzbdHKtOzLQ3+65GXFeJwqrQN/FA5LiIbzNwE0D6GwKQpevp3IsZm1w+QYEnwpKGDPs+M/Gap/Qb7HvKNC4I/lMehr0kY2LveqGS1cFrx3nWfQYJSKWiPondwrxZhtxIOfne8xA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yf55tk1E; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2399320f8f.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753092468; x=1753697268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0S+bBFMxckuEqPp10mWPmd4+x8/NMYbq/zd/l7gB/U=;
        b=yf55tk1E3JAmbO28Euu2BGSpRIDsTfkIRwrLvHuxUZI0ugA2Ty1FZU3v+RyPswnPea
         ZLTzV9xFEl3sTFrTcfmOd2AKTE98xBRr1gzut1z/hX5DnbWXKADrey1lUwKdN0nhBtyV
         wMKcfinKq8ZIaGFlCqpRPFokta1SOo+m0vu8APa2mQ9/EFvtdPVUiWOrKf5dDTHJll8e
         MifmQaUsHtQdwfZ4ZimL0mdnSUI9+63vzYPJnaOR0SYb5IwpU38vQI7cd3zSKBLUTgsp
         gCbAG0lHoIx9UhKnFu94kQg6k6xSkRuu7pYvL7XesaOlgVfhf3OlD4Ku+ZbFvpKHJjVY
         NEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092468; x=1753697268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0S+bBFMxckuEqPp10mWPmd4+x8/NMYbq/zd/l7gB/U=;
        b=crWfQBdR2ANjGcBj4J5bePTPtsjmIiC3KG6mOfo3SF6x+5rStH+XYZdm92VGQKCQcP
         sIUx4cKiVsn7NPekOaJ8bnNJmdEbSG/isBWc3RalpMtKZahyFxoa69PX0p0ZgAbf2pum
         P95aYhdeFojtWMD4P4nq/tTiu3344uflCn6Y1lt4GYDXlNfk/trNWoiHegkiD45KK7o5
         vzs57jbUcM9nKCTafFkVlOwkOO/BwN+LpbsNb8ALqbj1ybFJSfaVQpJcj8hlVRKJ9N6S
         iILTTw883pz0ge6XOu0XdrbuDzJO++KsxyMVmhjsRCScRd9eHF2198mpJFnYG1atBk4O
         2tUw==
X-Gm-Message-State: AOJu0YwaAumT/arx/g2B+vHuItos4JArQKC8PSPDuk1BeZQzBVR34kw9
	omZEPQ1vm6TiPEQiKeApOc2mhhn622aeH0aoagiQyZrBciaf6bOT6bkgcJP4EfH7xFzP6k9QriW
	kLTwf
X-Gm-Gg: ASbGnctt2fOe9qrH+zyAlL2VhR3LJjkq83YAeTgRbRJ2ix93bHVojOchidOVWpC3CLb
	+NWnLpcriHFgTHSTGqragNz2u7O9uTzxCRPG6sJ/cYBR5Q9YmdFOOaxB28B2tUbJTYoDpaCrhfz
	/XqzO0Uop34thvBdcxRUB1Vr6VA7Ux6zBpIB+T8ImcF+8U20i3oC+Be6SXG4PAaccOOtt4PZPFz
	B1CS1ct4ll5R22rB90OhlI49YVvxJR3cZpW6eiFoo3F08TBlvh+4dwo/KJJCIiPWcVvWxtfpedT
	nXvU4cbCnV4Ks6YMLdlFB2InZIbUgkDspl5RBAwkTKHsyS1ZEmNbauwhcqJEHinzqrUw19xH9vF
	AWGn92VaeWmcqBHg=
X-Google-Smtp-Source: AGHT+IFGdTCnMiQ4V6nLRryg5jCWy74XnosXig0E1SjhzKHoROyIcxSOm53EslKYUh+pHjWIeBECjA==
X-Received: by 2002:a5d:5f8f:0:b0:3a5:2208:41d9 with SMTP id ffacd0b85a97d-3b61b2214a2mr9057051f8f.40.1753092467985;
        Mon, 21 Jul 2025 03:07:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm153905065e9.33.2025.07.21.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:07:47 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2] netdevsim: add couple of fw_update_flash_* debugfs knobs
Date: Sun, 20 Jul 2025 23:27:34 +0200
Message-ID: <20250720212734.25605-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Netdevsim emulates firmware update and it takes 5 seconds to complete.
For some usecases, this is too long and unnecessary. Allow user to
configure the time by exposing debugfs knobs to set flash size, chunk
size and chunk time.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added sanitiazation of the tunables before using them
---
 drivers/net/netdevsim/dev.c                   | 42 ++++++++++++++-----
 drivers/net/netdevsim/netdevsim.h             |  3 ++
 .../drivers/net/netdevsim/devlink.sh          |  4 ++
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 01c7edb28d96..c9a99eb6f5d5 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -314,6 +314,12 @@ static int nsim_dev_debugfs_init(struct nsim_dev *nsim_dev)
 			    &nsim_dev->fw_update_status);
 	debugfs_create_u32("fw_update_overwrite_mask", 0600, nsim_dev->ddir,
 			    &nsim_dev->fw_update_overwrite_mask);
+	debugfs_create_u32("fw_update_flash_size", 0600, nsim_dev->ddir,
+			   &nsim_dev->fw_update_flash_size);
+	debugfs_create_u32("fw_update_flash_chunk_size", 0600, nsim_dev->ddir,
+			   &nsim_dev->fw_update_flash_chunk_size);
+	debugfs_create_u32("fw_update_flash_chunk_time_ms", 0600, nsim_dev->ddir,
+			   &nsim_dev->fw_update_flash_chunk_time_ms);
 	debugfs_create_u32("max_macs", 0600, nsim_dev->ddir,
 			   &nsim_dev->max_macs);
 	debugfs_create_bool("test1", 0600, nsim_dev->ddir,
@@ -1015,15 +1021,14 @@ static int nsim_dev_info_get(struct devlink *devlink,
 						    DEVLINK_INFO_VERSION_TYPE_COMPONENT);
 }
 
-#define NSIM_DEV_FLASH_SIZE 500000
-#define NSIM_DEV_FLASH_CHUNK_SIZE 1000
-#define NSIM_DEV_FLASH_CHUNK_TIME_MS 10
-
 static int nsim_dev_flash_update(struct devlink *devlink,
 				 struct devlink_flash_update_params *params,
 				 struct netlink_ext_ack *extack)
 {
 	struct nsim_dev *nsim_dev = devlink_priv(devlink);
+	u32 flash_size = nsim_dev->fw_update_flash_size;
+	u32 flash_chunk_size = nsim_dev->fw_update_flash_chunk_size;
+	u32 flash_chunk_time_ms = nsim_dev->fw_update_flash_chunk_time_ms;
 	int i;
 
 	if ((params->overwrite_mask & ~nsim_dev->fw_update_overwrite_mask) != 0)
@@ -1035,20 +1040,30 @@ static int nsim_dev_flash_update(struct devlink *devlink,
 						   params->component, 0, 0);
 	}
 
-	for (i = 0; i < NSIM_DEV_FLASH_SIZE / NSIM_DEV_FLASH_CHUNK_SIZE; i++) {
+	/* Sanitize flash sizes and time. */
+	if (!flash_chunk_size)
+		flash_chunk_size = 1;
+	if (flash_chunk_size > flash_size)
+		flash_chunk_size = flash_size;
+	else if (flash_size % flash_chunk_size)
+		flash_size = flash_size / flash_chunk_size * flash_chunk_size;
+	if (!flash_chunk_time_ms)
+		flash_chunk_time_ms = 1;
+
+	for (i = 0; i < flash_size / flash_chunk_size; i++) {
 		if (nsim_dev->fw_update_status)
 			devlink_flash_update_status_notify(devlink, "Flashing",
 							   params->component,
-							   i * NSIM_DEV_FLASH_CHUNK_SIZE,
-							   NSIM_DEV_FLASH_SIZE);
-		msleep(NSIM_DEV_FLASH_CHUNK_TIME_MS);
+							   i * flash_chunk_size,
+							   flash_size);
+		msleep(flash_chunk_time_ms);
 	}
 
 	if (nsim_dev->fw_update_status) {
 		devlink_flash_update_status_notify(devlink, "Flashing",
 						   params->component,
-						   NSIM_DEV_FLASH_SIZE,
-						   NSIM_DEV_FLASH_SIZE);
+						   flash_size,
+						   flash_size);
 		devlink_flash_update_timeout_notify(devlink, "Flash select",
 						    params->component, 81);
 		devlink_flash_update_status_notify(devlink, "Flashing done",
@@ -1567,6 +1582,10 @@ static int nsim_dev_reload_create(struct nsim_dev *nsim_dev,
 	return err;
 }
 
+#define NSIM_DEV_FLASH_SIZE_DEFAULT 500000
+#define NSIM_DEV_FLASH_CHUNK_SIZE_DEFAULT 1000
+#define NSIM_DEV_FLASH_CHUNK_TIME_MS_DEFAULT 10
+
 int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 {
 	struct nsim_dev *nsim_dev;
@@ -1585,6 +1604,9 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	INIT_LIST_HEAD(&nsim_dev->port_list);
 	nsim_dev->fw_update_status = true;
 	nsim_dev->fw_update_overwrite_mask = 0;
+	nsim_dev->fw_update_flash_size = NSIM_DEV_FLASH_SIZE_DEFAULT;
+	nsim_dev->fw_update_flash_chunk_size = NSIM_DEV_FLASH_CHUNK_SIZE_DEFAULT;
+	nsim_dev->fw_update_flash_chunk_time_ms = NSIM_DEV_FLASH_CHUNK_TIME_MS_DEFAULT;
 	nsim_dev->max_macs = NSIM_DEV_MAX_MACS_DEFAULT;
 	nsim_dev->test1 = NSIM_DEV_TEST1_DEFAULT;
 	spin_lock_init(&nsim_dev->fa_cookie_lock);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 8eeeb9256077..78a0f07e4088 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -317,6 +317,9 @@ struct nsim_dev {
 	struct list_head port_list;
 	bool fw_update_status;
 	u32 fw_update_overwrite_mask;
+	u32 fw_update_flash_size;
+	u32 fw_update_flash_chunk_size;
+	u32 fw_update_flash_chunk_time_ms;
 	u32 max_macs;
 	bool test1;
 	bool dont_allow_reload;
diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index a102803ff74f..92cc5cbb7d83 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -40,6 +40,10 @@ fw_flash_test()
 		return
 	fi
 
+	echo "1024"> $DEBUGFS_DIR/fw_update_flash_size
+	echo "128"> $DEBUGFS_DIR/fw_update_flash_chunk_size
+	echo "10"> $DEBUGFS_DIR/fw_update_flash_chunk_time_ms
+
 	devlink dev flash $DL_HANDLE file $DUMMYFILE
 	check_err $? "Failed to flash with status updates on"
 
-- 
2.50.1


