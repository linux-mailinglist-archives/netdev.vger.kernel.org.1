Return-Path: <netdev+bounces-49127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F257F0E0F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0681C2160E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1EF500;
	Mon, 20 Nov 2023 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mIHG3SUB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C219A5
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548c548c40aso946324a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470025; x=1701074825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPzmn/EmadmfWB1rVwrbIlsgYs3l2OVtocc7X4wxK5c=;
        b=mIHG3SUBqzDekmPdi+V1Z+txHGztixGplpAsa4FmMFYHqHWoqUwFH1dg7NJs4FI9n6
         tM1/5BpZ6dRAu2DZ0CNyG2WYhoXxyFsgf+8reqWL3XwQx0Etk2tzC28N9DmcAHLf1tVp
         FyVVJoNO2WXsHde1pKvYJ8kbon11yrCraFO++D5gV8Z9jV9OSKAKCEwIoJTdVQjv03qj
         LkZdiRhBO8JQEXsXSJwFLURXq5MFst6lCX8OpFFjNhHUx4VeggPt+5HvTFO4muwJkn4D
         Qt7r70csoI89gF2MfWDq+oaYtLV6ndnDFG3xKcTEPnvbFcQ5v5jTRz5ZERtchgNdO5i/
         8+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470025; x=1701074825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPzmn/EmadmfWB1rVwrbIlsgYs3l2OVtocc7X4wxK5c=;
        b=Ls91cITzrUlCoQqMF1HwCz4bub5Cg7LAxFYVW+vq/rwgjJcoUdLoZKvX4Hb35bS9me
         e4Irb3i+mWaNpn06Qr1mR+AayWMLriQZHe+i2/xOZiHXiXgoSBfbYjJbTb3AmBULVf1W
         41lG9wBjN8zQg5dVcZsA/DyNRjeZ54afKbiHLuXZia9hLDtUgegBDldPnUI5qOSx1HOp
         3tYmFRKxEGlXy66CKNNeNDgzgk8gVtXyuyPoTlE+td5i5V1csx5SOl7LytzrzRI3h/fK
         tfZOutcFrIq/SmjE6qe1Zm1aMAiZENAkvl6/9piLfDYh2cBeIdU5FsNxH142uMhPwfC6
         NCvg==
X-Gm-Message-State: AOJu0Yxk5Rl8GYV5TPYV2/DGVXlZC3fdhNkXoDvRRA7HgiAMeHqVVHF9
	gVuRV5a3BTi6xdN6fvzsHmQpP8MEACkWjafj6enhhA==
X-Google-Smtp-Source: AGHT+IGk8zNXgZY0TKD1aiuevueMHROE3wrxYIFFGL+Uu1PV7Inb+I+e9/OCULKwqUe8sKZovFvyJQ==
X-Received: by 2002:a05:6402:26cd:b0:540:16be:6562 with SMTP id x13-20020a05640226cd00b0054016be6562mr1448666edd.15.1700470025440;
        Mon, 20 Nov 2023 00:47:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402101100b0054851cd28d2sm2920257edu.79.2023.11.20.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:04 -0800 (PST)
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
Subject: [patch net-next v3 3/9] devlink: send notifications only if there are listeners
Date: Mon, 20 Nov 2023 09:46:51 +0100
Message-ID: <20231120084657.458076-4-jiri@resnulli.us>
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

Introduce devlink_nl_notify_need() helper and using it to check at the
beginning of notification functions to avoid overhead of composing
notification messages in case nobody listens.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c           | 5 ++++-
 net/devlink/devl_internal.h | 6 ++++++
 net/devlink/health.c        | 3 +++
 net/devlink/linecard.c      | 2 +-
 net/devlink/param.c         | 2 +-
 net/devlink/port.c          | 2 +-
 net/devlink/rate.c          | 2 +-
 net/devlink/region.c        | 2 +-
 net/devlink/trap.c          | 6 +++---
 9 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 4667ab3e9ff1..582b5177f403 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -203,6 +203,9 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
 	WARN_ON(!devl_is_registered(devlink));
 
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
@@ -977,7 +980,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 381b8e62d906..8b48a07eb7b7 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -172,6 +172,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype);
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
 
+static inline bool devlink_nl_notify_need(struct devlink *devlink)
+{
+	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
+				  DEVLINK_MCGRP_CONFIG);
+}
+
 /* Notify */
 void devlink_notify_register(struct devlink *devlink);
 void devlink_notify_unregister(struct devlink *devlink);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 695df61f8ac2..93eae8b5d2d3 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 	ASSERT_DEVLINK_REGISTERED(devlink);
 
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 9d080ac1734b..45b36975ee6f 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
 		cmd != DEVLINK_CMD_LINECARD_DEL);
 
-	if (!__devl_is_registered(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/param.c b/net/devlink/param.c
index d74df09311a9..6bb6aee5d937 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	 * will replay the notifications if the params are added/removed
 	 * outside of the lifetime of the instance.
 	 */
-	if (!devl_is_registered(devlink))
+	if (!devlink_nl_notify_need(devlink) || !devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index f229a8699214..32f4d0331e63 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -512,7 +512,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 
 	WARN_ON(cmd != DEVLINK_CMD_PORT_NEW && cmd != DEVLINK_CMD_PORT_DEL);
 
-	if (!__devl_is_registered(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index e2190cf22beb..0371a2dd3e0a 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -146,7 +146,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 396930324da4..f1402da66277 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -235,7 +235,7 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 
 	WARN_ON(cmd != DEVLINK_CMD_REGION_NEW && cmd != DEVLINK_CMD_REGION_DEL);
 
-	if (!__devl_is_registered(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = devlink_nl_region_notify_build(region, snapshot, cmd, 0, 0);
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 908085e2c990..3ca1ca7e2e64 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1174,7 +1174,7 @@ devlink_trap_group_notify(struct devlink *devlink,
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1236,7 +1236,7 @@ static void devlink_trap_notify(struct devlink *devlink,
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1713,7 +1713,7 @@ devlink_trap_policer_notify(struct devlink *devlink,
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.41.0


