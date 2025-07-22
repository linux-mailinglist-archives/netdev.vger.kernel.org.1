Return-Path: <netdev+bounces-208839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04A0B0D5B6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26513ABD97
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE7238C21;
	Tue, 22 Jul 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OJFNeYfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597917741
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175993; cv=none; b=qDBS45GA7RyJVedO5vjfMSavZpJSYX3i44ixOfoVgEg5oW1RquabelczIjwNxQsljUhsZYM+w1WgH9BJP1OGzDvZvIxrSEetEpyms/YsZJSSpMMIb96XcwX/VYMnkjyxXj8bJP3rYEoMuHDlnavSDL6GndAdsHgb1tLjysAZQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175993; c=relaxed/simple;
	bh=TO1P6UT5t3MBJp5ANznrnFafMxZpYHQbVczkv8ALqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSBIHfrL7jOqgaXn770rGSsyUV+buFEzXVqEtVRTnlnbFIoIvJ9gJzbkCwR1WjxM1cGtZDA5jPdGuD91VrprpTDzG/rhMEdNTTlxLubkD4JEmTr1JtHAtRk8jYz1tQYjmQkCJR03yoQIvIpPTAQ4phv28tnBab5iAs77JMzjWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OJFNeYfD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so36779065e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753175989; x=1753780789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbHvHSROpYw+ztsx9uVIrc/4QkXVUTWIpFCiJ5QYzZU=;
        b=OJFNeYfDEuTg0gkPUGfa0PYn5HbfLU0FvrdhhidMXsn/cbwtJoEMZnzsJoBCaZFLbL
         SMGQEi32BAl1b1p/2SBmTshK5W532h+6QT400+Qr4F1CppCIbo7OYvuNFQPJt/INL1AL
         TDzS24IYJZvcsVtRGwdUWnLTYJo+2RioGcUO3QEcDtm8oH3XqmFDBn1ToNj2vFORPrfQ
         +1VyXbiG9oM0glLlYxYWmY0qY84YE1ajpoY7J9RnhOyQP5Z9Byx9wXcM3LV4nkQfipYz
         aVXFs7yp7QwaoVPErj3rVeMEMHia3eHgzOuAZQyeIqIlIbtJGjnksYywoiD2m53k5YOF
         j/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175989; x=1753780789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbHvHSROpYw+ztsx9uVIrc/4QkXVUTWIpFCiJ5QYzZU=;
        b=XsiKeXFYCnSCfvyv/eVe99BCiawu3JESkaVJ+SZ2pt0LLe5j7ScODE8+xWv82tBIAu
         EhGbnPKyD3ncAd0us5DoDMpDej1IbTUawWYOd8f3C4w2TfghDmWAcf24am7/YKaL4lEn
         luzAG0HkYJMUtc6eADqy8noqDKJOz2axrh4E26yEaqUfRW4RgxIgG8wCSMugL7JimCeR
         2MYmqwOvwjHodMi/Hd/ivaLdIBBfvJOf6Tux2Zk+4iJfJWM3SGBkffn98NQSWEhvKeON
         7TchC9TQz+k9c+1YLkLOMrHOEoqBD3ps7K25+OFVDA7pB1I5Jc865FuK5uapIxL0W8Pq
         bASg==
X-Gm-Message-State: AOJu0YwXWwzT085iSUIvymuF53aE1X/rSHzzbnMLHjaT3EJHm6ROBv6p
	CogytZfP/LTbLAX64SemqvvGgcMOLqvivKN1mf/O2VhizFA1RsK090DHggvT0DLETwOFWJiPfEy
	ahcRj
X-Gm-Gg: ASbGncv8xZSJjjVWGyJHu8HV3vNw+U4yyaHDZS/7sRS9+kCGyYsU/BYQJIpnmbL22Ib
	CeipPPRz/iK4gmkUWXLKypp0yzGYfz1rziHX+wOasG1dzY5LkncTa1l2NypH+UT6KnqoiZXODyL
	WICTm2FFEak8FlxpGUrFJkg8nPHNJPFcGmEHZ8YWjGtuqRW26/f2TiVFGn9YdhQJeLHCvDKfLhY
	VSW9MMM6kKwh5JJYY1PFVWQqa/WRFAFrWwmoGjPTh3p/cfs3gFNSLfzdF78IPUxiFKyAhgNT8fm
	JMVHzSDgmNjWBn9kfixir7kVuCdzmmoCW4agIUsKPcuTwi8PAXCJWwFbX1uQjfADD2LlW0s1nlb
	Rh3VI0A3SoT9+YpvhieBjPaqgVw==
X-Google-Smtp-Source: AGHT+IHWv7rKIlyHvLCbiwoFJ78h26PwQMBdsv1odnsZAnYz74FQ43tQ4WCk0JFRO1/YZV/B7zCSIQ==
X-Received: by 2002:a05:600c:1c82:b0:456:2ac6:ccc3 with SMTP id 5b1f17b1804b1-4562e28367emr166014315e9.25.1753175989084;
        Tue, 22 Jul 2025 02:19:49 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f8a9sm126760425e9.26.2025.07.22.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:19:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v3] netdevsim: add fw_update_flash_chunk_time_ms debugfs knobs
Date: Tue, 22 Jul 2025 11:19:45 +0200
Message-ID: <20250722091945.79506-1-jiri@resnulli.us>
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
For some use cases, this is too long and unnecessary. Allow user to
configure the time by exposing debugfs a knob to set chunk time.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- reduced the exposed knobs to just time_ms, redurect flash size 10
  times
v1->v2:
- added sanitiazation of the tunables before using them
---
 drivers/net/netdevsim/dev.c                              | 9 ++++++---
 drivers/net/netdevsim/netdevsim.h                        | 1 +
 tools/testing/selftests/drivers/net/netdevsim/devlink.sh | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 01c7edb28d96..2672d071b325 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -314,6 +314,8 @@ static int nsim_dev_debugfs_init(struct nsim_dev *nsim_dev)
 			    &nsim_dev->fw_update_status);
 	debugfs_create_u32("fw_update_overwrite_mask", 0600, nsim_dev->ddir,
 			    &nsim_dev->fw_update_overwrite_mask);
+	debugfs_create_u32("fw_update_flash_chunk_time_ms", 0600, nsim_dev->ddir,
+			   &nsim_dev->fw_update_flash_chunk_time_ms);
 	debugfs_create_u32("max_macs", 0600, nsim_dev->ddir,
 			   &nsim_dev->max_macs);
 	debugfs_create_bool("test1", 0600, nsim_dev->ddir,
@@ -1015,9 +1017,9 @@ static int nsim_dev_info_get(struct devlink *devlink,
 						    DEVLINK_INFO_VERSION_TYPE_COMPONENT);
 }
 
-#define NSIM_DEV_FLASH_SIZE 500000
+#define NSIM_DEV_FLASH_SIZE 50000
 #define NSIM_DEV_FLASH_CHUNK_SIZE 1000
-#define NSIM_DEV_FLASH_CHUNK_TIME_MS 10
+#define NSIM_DEV_FLASH_CHUNK_TIME_MS_DEFAULT 100
 
 static int nsim_dev_flash_update(struct devlink *devlink,
 				 struct devlink_flash_update_params *params,
@@ -1041,7 +1043,7 @@ static int nsim_dev_flash_update(struct devlink *devlink,
 							   params->component,
 							   i * NSIM_DEV_FLASH_CHUNK_SIZE,
 							   NSIM_DEV_FLASH_SIZE);
-		msleep(NSIM_DEV_FLASH_CHUNK_TIME_MS);
+		msleep(nsim_dev->fw_update_flash_chunk_time_ms ?: 1);
 	}
 
 	if (nsim_dev->fw_update_status) {
@@ -1585,6 +1587,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	INIT_LIST_HEAD(&nsim_dev->port_list);
 	nsim_dev->fw_update_status = true;
 	nsim_dev->fw_update_overwrite_mask = 0;
+	nsim_dev->fw_update_flash_chunk_time_ms = NSIM_DEV_FLASH_CHUNK_TIME_MS_DEFAULT;
 	nsim_dev->max_macs = NSIM_DEV_MAX_MACS_DEFAULT;
 	nsim_dev->test1 = NSIM_DEV_TEST1_DEFAULT;
 	spin_lock_init(&nsim_dev->fa_cookie_lock);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 8eeeb9256077..bddd24c1389d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -317,6 +317,7 @@ struct nsim_dev {
 	struct list_head port_list;
 	bool fw_update_status;
 	u32 fw_update_overwrite_mask;
+	u32 fw_update_flash_chunk_time_ms;
 	u32 max_macs;
 	bool test1;
 	bool dont_allow_reload;
diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index a102803ff74f..030762b203d7 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -40,6 +40,8 @@ fw_flash_test()
 		return
 	fi
 
+	echo "10"> $DEBUGFS_DIR/fw_update_flash_chunk_time_ms
+
 	devlink dev flash $DL_HANDLE file $DUMMYFILE
 	check_err $? "Failed to flash with status updates on"
 
-- 
2.50.1


