Return-Path: <netdev+bounces-57607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB48139B3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B6C1F21EB5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2D68B84;
	Thu, 14 Dec 2023 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X4cOFt+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDCCF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so974591366b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577756; x=1703182556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbWsBPpBXJN/mSeDiH7uhOyWgGTchnVsa58K3LTnlgY=;
        b=X4cOFt+sX5LQcx2T9P27qGQROsKkUHSUYj1b7HBipop0FAWthSJvSaVRXeFFW9woXt
         vT9YkQwBPMp6/jFosqk02fqd7jPzm4WsZRw3hLwOw4yKQ59JswCziF1pWIfisSVJ3Vmt
         +zZuhqzSEnHHZ2i42iWWbjh60HF3p33gjzG6kcD0FiDCJBGXxZnbZhCbz0YSzmGLG+9p
         7oEkfI70pagA6CU3r9UKVSMs5iVf1NJm53XtCH6Foi1Kf30f97w2kxXp93Ky292eBiyE
         1HO7WcnDTI4TQuJtJPCqNlNNt+ewQY3uIExAwg6hn5x3bpD38qllNK2VoSvH/Ro9r20S
         28CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577756; x=1703182556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbWsBPpBXJN/mSeDiH7uhOyWgGTchnVsa58K3LTnlgY=;
        b=fVhtbLoZ8IZFOaa/ELq6ReFe2sGTULPHsJ4mGqiBzEtaPWZfiu+PFtDcMJzq2giMpU
         8loApK3E/wZrwk/Du6z4+Ves7F7OTP9WLeH2arYHRtih+3nwKA0GEW79YSsuNARnJfHP
         ZJY/wfKAjo5ZQxUJZOoom71z+dFdmYvxp+I8PUpr2LMUdRU0xSm2/Ne8i2UTV3tD2ZVQ
         skYe5/prVLSCRPmGAN25tJ3124ELoaY7ykWCIVXl1a2N+vHcgTL2MZIYc35s5OCrGAlx
         q+S4O3ktWXBsCdlZLldWl+o89JFYvqid2L9dFgGAcMxw98eLR1xeXUvF+HzSQvNIY6ew
         Cgsw==
X-Gm-Message-State: AOJu0Yx6cpsersDfpG65fjGrlb0GHBaMtk8lkgzmIlmSiqXBmopEJ336
	ENTzfo+9RfG+cVaOOBuSeUOspZF0Krj9I53emlE=
X-Google-Smtp-Source: AGHT+IGtkDaylfvbpbtA1UMkh5oveZY0TaPv16d0uk3TGfkNclceZxuXAXzyZNlKOS48hdgUL4loiA==
X-Received: by 2002:a17:907:7d86:b0:a1d:530c:af04 with SMTP id oz6-20020a1709077d8600b00a1d530caf04mr6575318ejc.74.1702577756568;
        Thu, 14 Dec 2023 10:15:56 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b00a1dc4307ed5sm9651025ejc.195.2023.12.14.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:15:55 -0800 (PST)
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
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v7 3/9] devlink: send notifications only if there are listeners
Date: Thu, 14 Dec 2023 19:15:43 +0100
Message-ID: <20231214181549.1270696-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214181549.1270696-1-jiri@resnulli.us>
References: <20231214181549.1270696-1-jiri@resnulli.us>
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
v4->v5:
- swapped order in test in param.c
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
index 3fe93c8a9fe2..63fe3e02c928 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -204,6 +204,9 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
 	WARN_ON(!devl_is_registered(devlink));
 
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
@@ -999,7 +1002,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 59ae4761d10a..510990de094e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -185,6 +185,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
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
index 71ae121dc739..0795dcf22ca8 100644
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
index d74df09311a9..7516b524ffb7 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	 * will replay the notifications if the params are added/removed
 	 * outside of the lifetime of the instance.
 	 */
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
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
index b65181aa269a..bf61312f64bd 100644
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
2.43.0


