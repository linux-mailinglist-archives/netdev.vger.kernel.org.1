Return-Path: <netdev+bounces-49126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511307F0E0E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0892B1F22BCB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9CF9E4;
	Mon, 20 Nov 2023 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vdIZsCTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686010D1
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so527990a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470021; x=1701074821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZA5Ca1hKuCyZmXptnnWStM0rrf33hfZQmGrv/TQuI4=;
        b=vdIZsCTp417fBeZ0sEBqhb3r/5wjmldssC9tny1tKlsEdZ1+7ZhssEgs4sd7SqOOOl
         19gMOSxP5zFb+Pyvrj2/GNUoM6bOCjYSIoO26SPFHhIh2RaaTB5E8GmDWybD1UqDHAwh
         zD3o6NYYcXHTUb+LgQXhtfHxZMMa9VvK+/tbyZeJRAr/VXxAGetJM7Py2JcaLP/iy6iP
         7WAOukCgYDT0nEqLuKmlhmkRR7qZ+FpfMNvVYLOZU8Kd3jgzpQqc1V+fkIkC2eFLkVCq
         1FnznJmXT+2W7RqGU3oJKz5ydzfzkNkMVtCuHRMlBljf/UcQkXGe62AYnW5OdiEk71ZU
         jXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470021; x=1701074821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZA5Ca1hKuCyZmXptnnWStM0rrf33hfZQmGrv/TQuI4=;
        b=ikFK4WXXI8N7+SiS2pr0Q1wYyX2rVBxnb8Pjod2Ru6HEPE+ihM6DQW7PlhIoDGlIgK
         cjP7QIgB/kNjfqKEziJg/B1eY3yYb19t3dEMmE5Wmk4w/8ehzFvekfnPhFVLL69tD9uQ
         92LJzv//l2VyAjCGRvlbMXi5b7tiB0ffZAVSQAIEcEvNHHGbZMpVHS3OoTCJlZCSfdeq
         Pc6gKAVuYu8FMcbPxgunA6be+l3X/RLn9glZ/fr6t4kL1mAJjywRaO3y7E/WLkA4OUfT
         +Hs7zMFVreA4byJ53+OwrDj1F8IQs0er5TXBVmFPHckKvzR/QU5fnWOz48cN/Lda0XHr
         +alQ==
X-Gm-Message-State: AOJu0Yx3ssEt5aAIOWGVcYa47wDtTtgFPK6zJdxfsFca1hoSnjRJcRW3
	EPcYZAf1q7S5Rsz5cGirksIJ3dhvU1aselGliBOzPw==
X-Google-Smtp-Source: AGHT+IFBSkFVOrRzM7oLSQRTcdAprqNTgILpiwnaugOknpLb2PHfEfBIFgHrcwqPeWykoOCi66vKlg==
X-Received: by 2002:a17:906:73d0:b0:9c7:5a01:ffe7 with SMTP id n16-20020a17090673d000b009c75a01ffe7mr4540506ejl.12.1700470021589;
        Mon, 20 Nov 2023 00:47:01 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906a01400b009adc77fe164sm3650433ejy.66.2023.11.20.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:01 -0800 (PST)
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
Subject: [patch net-next v3 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Mon, 20 Nov 2023 09:46:49 +0100
Message-ID: <20231120084657.458076-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120084657.458076-1-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
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
index 4fc7adb32663..4667ab3e9ff1 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -201,7 +201,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	WARN_ON(!devl_is_registered(devlink));
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -977,7 +977,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
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


