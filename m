Return-Path: <netdev+bounces-48437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F57EE572
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BC1B20C8A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A73C48A;
	Thu, 16 Nov 2023 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fWfZ+JCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB05D49
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9f27af23443so148070666b.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153305; x=1700758105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZA5Ca1hKuCyZmXptnnWStM0rrf33hfZQmGrv/TQuI4=;
        b=fWfZ+JCHHkLHW0oaAnwVAO7IdbXU3WApwkYvVJSgkyCc5vUtOt3hGg1oC5lX9viU0g
         DyItBDtcMPmDxUKWSwApDJ3e7VGKtA1auBuGqkUJc3C/jHtsIqMlEJi3rCBqVRVRUAI3
         gO1E4Kddvk7iJEeDt4PcmGLm8ATZBRs1oPhHVBzfY/s52qvoawf81xmf2QwPsVGWLnuu
         vKbj6HVzLmBGJ8Xl+q2LYjBGwu5XQ7JohfITrYyZv7IL4gJBLWpTHeoJjgtvZsoqCPuW
         ERz+lgeqpAfK8CYswQtXXCFlWS8T7o2qSZ6BAXxbWi4F5CJsygyAImlgrRvXrH4hLacR
         SSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153305; x=1700758105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZA5Ca1hKuCyZmXptnnWStM0rrf33hfZQmGrv/TQuI4=;
        b=xNqPQzvA8MDGoWRBZa/RlL5xkyiOvla7plspopXuhKvG80Tf/Hemoe4LG2mz59Z2BV
         R1hUzQ6fO/idzRVuvKK01bAl09AX29lrzJuAdCTWbX7N8B1YZTS31uCNluJgnqnTjj0u
         oHt1VgMgInyacPizqcHIcm1fvnXkC/hC31yHVYOjzKhD1QGIj49Lpl/KPZ7G/Y63LM/w
         hUbVhbVQVd5JnBmgyoxfq7ud/R7D+rAvNg/Wtrj64Y3a5UlA20JUycNDESgN0O1dYKvf
         pZ35Z1ai4HYXclS8uMDbvhMcacwYNDbIkzfJb0PYD3vfDGCzdB3goQ1vFWruCOY1SAbZ
         cx+A==
X-Gm-Message-State: AOJu0Yx0HrMUn8fsBFq92pE369I3hQAmP2oXp0B9uOf1qYaoQnLZ7evd
	BbUYrEJ6d0FduSFcsZRzPKrojOC8t1wWsh4FqBw=
X-Google-Smtp-Source: AGHT+IH6kNtubFTE24toyGrcgtyc1EmjfPjgCwypMOo2k7GDIJjSzTUW54xi007oJ1M7uj7hhbEfzQ==
X-Received: by 2002:a17:906:7b82:b0:9c3:cd12:1927 with SMTP id s2-20020a1709067b8200b009c3cd121927mr11973356ejo.5.1700153305109;
        Thu, 16 Nov 2023 08:48:25 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o23-20020a17090611d700b009829d2e892csm8793850eja.15.2023.11.16.08.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:24 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next v2 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Thu, 16 Nov 2023 17:48:13 +0100
Message-ID: <20231116164822.427485-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116164822.427485-1-jiri@resnulli.us>
References: <20231116164822.427485-1-jiri@resnulli.us>
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


