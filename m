Return-Path: <netdev+bounces-208328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED85B0B02F
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 15:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A53174096
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39BC1CAA6D;
	Sat, 19 Jul 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pOB/7KmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906CDDC1
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752930804; cv=none; b=qV2r3KLvd/1i9niCn7MOMpW1jDIfMZUFlcbA57i8nlRV2CHix6FSJmk8ef9jd0mcrd2GUPUKR+YxK13XuKbTfkZ0dhZnxDMalqjNecnGYfZDYLFCYHSrwKBcLoPHdNXMNfLohLAHkH7WJJhoIHbFwAmJ6q4dx/vzlhRnIyZ5aAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752930804; c=relaxed/simple;
	bh=6CbBzjMceiMY88kzwiUExps8t9oKfxO6A8kFy3sjiRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVFYJ6Sat/aWoAlukX0vaJZUCnELjJVWP7GDa9JS+tnkIiueayEHiEKK3Pnk3Ta1LWidcq6Eo8Iw+L3IIeXc6GJ5b7CcEaZpIVkESouP7Zn4P/GaXnncmfqnMriDlicx3o8vh0jdfZnznwK652GiMadFY+CBco+8srFCkfSQ+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pOB/7KmK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54690d369so2421628f8f.3
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1752930800; x=1753535600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjrT7fBM1CejmVuXSiK1DKP0OJHqogK/eV94u8ISPy4=;
        b=pOB/7KmKZJmOJnYNH0dKfmT7k2Z/J9isi0cWnV8MFiozUBY4yT++MYCV3lSu/WSCZ3
         +TGyInL0hqz34ySzO8+qms1XooTEtFioIQHk50QJ0SySjb09HRLa+AJ6cmGKs2eWuNy1
         sZ446kdoBvBjwxw2Te/9SFAhId4ohWvtjBzAJqteBhwRV56HhX6yDBfhiSTYxP3R7B0M
         HyH7+xoAu7Mr0/bOOnnm0VhY6frpapH30an17pkTwpkKOBikTkYB9ko60t20Jk+5VYfg
         su7sDjYTZl0vGhuSqDPvX+zjZkrh18uqSf4qMS/rj+IkOQ+PLt8Y2ntIOnftHkYy0ueK
         d4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752930800; x=1753535600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjrT7fBM1CejmVuXSiK1DKP0OJHqogK/eV94u8ISPy4=;
        b=SPWzLBa0qwA9wrGe8IALW2AhDr+sqeXU74d+UeumOIYk0eG3CatnQoyC5hXgQq3+Gw
         m7Crp/wncwfVn9DPijc1cjfLjzv811+6Pxif5GIPJAcmXD1fzAaNBBa9VNIAduvqV4Gr
         XsiuyySXN5IrxbdW9meMq2B7Rr/8xpYyplkipO6gQl3ZAHUC0/jAIOxRPE4qManouhPS
         aFNJSA4A1rySk0439FPd9lgi/NBw0vQ/Cb2GWOnv6vYRlFVE/Hxqzat1W+a/vaUYRqYi
         wiABDcY55FmMMAD1lN24t7zTLc9AS8VDRr7gnru7PFqAFZ4sDuRpN5p+FqqDwoRcI2uU
         3Xhw==
X-Gm-Message-State: AOJu0YzoSsiFGDwTn1ppG7KRCedWc3oX2YXhJeV2KKgmdXQmG/UZN3tX
	AoW7+87Zbb04rKWR1TNcY+LvAbyJ+wO+HeYs0A2gTuUe6wfnl/U3AbwK0vgq2pbgjSWk1X5d/YY
	Xpln8
X-Gm-Gg: ASbGncvPUkzXuDw0Fa2hw6ouWZTRONAk/v//GXov05C70fvZ8e6agezsTstHnvWf/W0
	a4HBZcw+otEOYg1iDhxgPhjSVx+ODjDZt1ragKJpmuAa9nIHelCc1cGogGLKOhTTOP/YTA1nsRU
	P10EKusPpRBHev4MxUIEUnfy8w0HGER85o2WhdSX+YnJ9jkGxHpjjcvW41FrqmGb8v+p8TJpKh4
	qi56pE0gScPrw4tPBb+Bnn4laVxyJOK62J/XRIyWd87iBLdrIxCH03UJ/qJQyz3Kpzwrbv/iE/e
	EXiQRneObSMojuPBLDX3PidziW3wKWnEzVc1IkHwrqAml7BD1sfL96OfxM13E0Z9geDh+PUO9zF
	8gSe9oVWrGZ5pylw=
X-Google-Smtp-Source: AGHT+IHXHdGw7jdaPQF/MVxxheB34JPp92Jbr436cnby8v7OJ15RMjuI2cDy6038ZesGerDMjnbkpA==
X-Received: by 2002:a05:6000:2c08:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b60e517ff8mr11374881f8f.50.1752930799284;
        Sat, 19 Jul 2025 06:13:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e81ccb4sm107032515e9.17.2025.07.19.06.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 06:13:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: [PATCH net-next] netdevsim: add couple of fw_update_flash_* debugfs knobs
Date: Sat, 19 Jul 2025 15:13:15 +0200
Message-ID: <20250719131315.353975-1-jiri@resnulli.us>
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
 drivers/net/netdevsim/dev.c                   | 32 +++++++++++++------
 drivers/net/netdevsim/netdevsim.h             |  3 ++
 .../drivers/net/netdevsim/devlink.sh          |  4 +++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 01c7edb28d96..e0cb09193c72 100644
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
@@ -1035,20 +1040,20 @@ static int nsim_dev_flash_update(struct devlink *devlink,
 						   params->component, 0, 0);
 	}
 
-	for (i = 0; i < NSIM_DEV_FLASH_SIZE / NSIM_DEV_FLASH_CHUNK_SIZE; i++) {
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
@@ -1567,6 +1572,10 @@ static int nsim_dev_reload_create(struct nsim_dev *nsim_dev,
 	return err;
 }
 
+#define NSIM_DEV_FLASH_SIZE_DEFAULT 500000
+#define NSIM_DEV_FLASH_CHUNK_SIZE_DEFAULT 1000
+#define NSIM_DEV_FLASH_CHUNK_TIME_MS_DEFAULT 10
+
 int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 {
 	struct nsim_dev *nsim_dev;
@@ -1585,6 +1594,9 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
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


