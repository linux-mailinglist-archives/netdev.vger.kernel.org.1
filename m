Return-Path: <netdev+bounces-50632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424EA7F660D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED617281B6A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B94C3A4;
	Thu, 23 Nov 2023 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="C7n/o6kt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36535D41
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a29c7eefso1426813e87.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763352; x=1701368152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qZQpcrwaO0fKr36nlIRFsQdhK07pBunnGGo+UTRz3Q=;
        b=C7n/o6kteYaLDftMzdwhu1dGTRbkVrgUF1LeyA+QMODb3MwIn+0dxyOsrUadIQ+xzH
         HRWZq4T6hsNcpypnHa3pjy+r+kVgpYiHn+yxHT/ZFbnQRY250noVuqiAkrh6KhCoGlJj
         l/PPVqiL3QUFrJmQNM/vDEs3v0b77IXhVxiEb4nsJob6JpK+CYSHW12N2JWHHd5yjN8U
         vgdPRoOqQc0QtW5uZ3nVFYwIAE8/Ba8TMSqoSo4VpIxoYqaXJybw7y4txkOyiEfPzPtb
         Prp60+tbV2kjKdWWcx5zJbgkRmEk5A+1hEyt7YKndAaBGbvqXydu0z4xb4NCSEoEs6iV
         oQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763352; x=1701368152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qZQpcrwaO0fKr36nlIRFsQdhK07pBunnGGo+UTRz3Q=;
        b=WwPf6FzyZz+e0UrlF5VZ+nGQQdexyZBnavXKbJEZnEuLtwp3rPQkC7oEJ8ijSOC2m3
         1k6m/HX15yvxoO53reBqAUfe4LEhiWnh04tV5JG0AZlOKPuua7xVsSO47qrnalPCamMI
         qWlfKGgOdQtHheb8WFJDZkf5Gk7VQxBApL10Pv+XErW74PxBRpEoxMa8LpyMEv5Hdq/Z
         brRCdODsTB9bI1qGco62ldQ5bJjpOJHkEWALFWYYPLzvtUATuNb+UNCyF3ITv7aHOb1m
         CovIh+qHhYypx4zdlfZkRkpBYnk5SlX0ZqegjE9zB333HxRFTgQPCZY5ZN4QL/Q/HzbJ
         k/BA==
X-Gm-Message-State: AOJu0Yw+7SHx3tne0alB49dibGsJO1B8e4H874c3EnNpanLQQq/pmOxS
	YlxaSpYfayXtgz5+7SEMXGINpLGR3ov4hKU9grs=
X-Google-Smtp-Source: AGHT+IE/6DsKlXI5Q/tlPKYMuET+1Ern0s/LzpWNBHDV9sEolM7W1Ib5r3OE3eejEXnwbZyzminfng==
X-Received: by 2002:a05:6512:3605:b0:503:343a:829f with SMTP id f5-20020a056512360500b00503343a829fmr44593lfs.23.1700763352564;
        Thu, 23 Nov 2023 10:15:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709064a5500b009eff65e6942sm1064929ejv.197.2023.11.23.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:52 -0800 (PST)
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
Subject: [patch net-next v4 3/9] devlink: send notifications only if there are listeners
Date: Thu, 23 Nov 2023 19:15:40 +0100
Message-ID: <20231123181546.521488-4-jiri@resnulli.us>
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
index 7c7517e26862..46407689ef70 100644
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
@@ -985,7 +988,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
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
2.41.0


