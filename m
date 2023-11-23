Return-Path: <netdev+bounces-50630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BAB7F660B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96A5B20E99
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459314B5D9;
	Thu, 23 Nov 2023 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E2K7V/Rt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C841A4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ffef4b2741so152824766b.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763349; x=1701368149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeAdk1AG9hSINhpR6YsiiDYoZ7W2jtuFfmUK14lu3AU=;
        b=E2K7V/RtxFuJeLOxnamJQxH4PVuAfgo0Ex2v5iIY0DSP3Mt+Dla/r7N2OOlatrYBaY
         eRdrsLRrzEUyCNQabCoCCQpGk5y7lZZausvxUfga28yo4KB81PmdPMNoa813KcvF+kGV
         9SNojmFmifZcV+WVRKQfsBqsOv9EVWwUGnSex4Bkj3C2zXUYY+HzIW4JBCRlNo/hEnA8
         dSao08iwOAcp6rPvm1raaKaMUgHlAXC2hnzPh3HZVfIcDwWJi4HAoJmfZfcYbTZYQr2d
         ssiyBuDHncfX1wkM8+36EO8Ms8I7drQkbzj8OO8X0MG/acEk3m47I3uSFaHSgxiRzzCa
         4RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763349; x=1701368149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeAdk1AG9hSINhpR6YsiiDYoZ7W2jtuFfmUK14lu3AU=;
        b=QxqiSpguefsZTuVW4am2fMxkUOPO7a3HNivhH2zEsfkzOv1BldLkm63cNsUC1ASQyA
         wXyK3Ss1eqjqMcrbizsJumICbbKMovrQ7zTlYFRW169ZZmv3PjRh8JGWUwB6Z1BiqoKA
         WlCmKDXrcrrHSLDkkJiqsEqiNoe/MwmNQSmEOy2EL3/bbziiwsOMy8Dso20jyWaWByWR
         DJrM+/2wffhMeAUxXSka2bb0X45IA3MowjVPThqnc4uVZ3VTg4fTowX5nk0UL90SsSCF
         X2qxA9aNaL4rY3ov1g7zwq7xBp55aECu6WAqFgltW2Kpx0XW/J4158ZWU9nr0p+MiNFa
         rpHg==
X-Gm-Message-State: AOJu0Yw5tFUBWg+2HscGMgpAryThkNodvJ2wCPZ2LTuPc4T+wJynsSxr
	n4XE7RNW5a0A3+ESNQ5NmcYMLszkSi1nDx4Y1+Y=
X-Google-Smtp-Source: AGHT+IEYTMO/88m1Ov7YlTUTEeGbA/dEMTVK+wSYb+COjO2jhVgA7NPBKXifPMNQrmieHAPDcnMQtw==
X-Received: by 2002:a17:906:6809:b0:9fe:42aa:425d with SMTP id k9-20020a170906680900b009fe42aa425dmr68598ejr.76.1700763349377;
        Thu, 23 Nov 2023 10:15:49 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b009de11bcbbcasm1068704ejb.175.2023.11.23.10.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:48 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org
Subject: [patch net-next v4 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Thu, 23 Nov 2023 19:15:38 +0100
Message-ID: <20231123181546.521488-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123181546.521488-1-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of checking the xarray mark directly using xa_get_mark() helper
use devl_is_registered() helper which wraps it up. Note that there are
couple more users of xa_get_mark() left which are going to be handled
by the next patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c  | 4 ++--
 net/devlink/rate.c | 2 +-
 net/devlink/trap.c | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index ea6a92f2e6a2..7c7517e26862 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -202,7 +202,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	WARN_ON(!devl_is_registered(devlink));
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -985,7 +985,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 94b289b93ff2..e2190cf22beb 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -146,7 +146,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index c26313e7ca08..908085e2c990 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1173,7 +1173,8 @@ devlink_trap_group_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1234,7 +1235,8 @@ static void devlink_trap_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1710,7 +1712,8 @@ devlink_trap_policer_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.41.0


