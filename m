Return-Path: <netdev+bounces-58220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AA8158FA
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05E51C21750
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B692C6B1;
	Sat, 16 Dec 2023 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sDUadLNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B2250E9
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553046ea641so294075a12.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729806; x=1703334606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPya/tj37w3+Pavkqq2uQ8tsfkZUvXPv2JD2RPZVhGQ=;
        b=sDUadLNB+yPUqCinMzdrT5D3Ex9qO5dOFZNj7Lcic/1pp+3SJZy3HzHeVmTtQGLpMp
         aXAGwjF0uC2tLQ2Y0jcV4CNNMseNeoS2e4m5ixasHy1MoP3XS8R2520a762OBil7b0Wi
         Gi6jfgq9kp7l0NJtRcauhlEfi+XcV1jnaYn8xlLsh9204d53M8tQPVjf6noV183q9jbU
         ApPS4YfhJxCsKiQETkS0m3o6olUCYVnaXTckWwBJ8XvBNgD5HBkEbLm75jl46CPY2UnX
         Cp+A7rkXVKBqxKMHS4+XTQdOiVLW6HM/nCknrysxr1i6XHICw4XYGO4iSqr3/23+GSid
         RKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729806; x=1703334606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPya/tj37w3+Pavkqq2uQ8tsfkZUvXPv2JD2RPZVhGQ=;
        b=xDb0uuq05pIyFoB6a2wTyc3PiDrAob5CN0gxM0lFuTCCEIxEfIiE82+/vDTo5sS6Le
         yXMkYNXIZ1kc4epiEMI0dqwFtGXlzYFCxnoA3LALFDhFv9RIwT1cYbBtqPMBT7lV+kmJ
         wGiLR9qKn95QSo0e/sEF7WCjONwjYoTdUZbW/NvBGwz/aANql5ER7/SXeqjTIUQP3qWF
         wsAQ9jlQZx2cW5FA9OssTqxrDJmhR4ap0r6Or5YlX+B1Tz363wuVvdb0pzxAcjORyyCO
         Q77Po3mFsFVeobbmNOctTlR32gTsBbL7BGofQ6/Z5kcOLHUUQVljmAKYyy6D+KY2UKTa
         zs4w==
X-Gm-Message-State: AOJu0YyEd/zUoCR7BNqQxwvpUxXlL8MXi7CUvsCn2JbPD0127wydKrBO
	OaLGkkGGkIaYXEyIQCSnuBR9ooCPajLtYE/yJCg=
X-Google-Smtp-Source: AGHT+IGO166Cj5w1r5+pdkWUTLPhlX1dfV8wXqdMruuoMn8uqddiEwY8w7IlVkqddgtVLvpWYOVJRA==
X-Received: by 2002:a50:8a91:0:b0:553:fec:6d6c with SMTP id j17-20020a508a91000000b005530fec6d6cmr183932edj.79.1702729805960;
        Sat, 16 Dec 2023 04:30:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b0055315b9e7dbsm70480edq.74.2023.12.16.04.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:05 -0800 (PST)
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
Subject: [patch net-next v8 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Sat, 16 Dec 2023 13:29:54 +0100
Message-ID: <20231216123001.1293639-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce __devl_is_registered() which does not assert on devlink
instance lock and use it in notifications which may be called
without devlink instance lock held.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h | 7 ++++++-
 net/devlink/linecard.c      | 2 +-
 net/devlink/port.c          | 2 +-
 net/devlink/region.c        | 3 ++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 5ea2e2012e93..59ae4761d10a 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -91,10 +91,15 @@ extern struct genl_family devlink_nl_family;
 
 struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp);
 
+static inline bool __devl_is_registered(struct devlink *devlink)
+{
+	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
+}
+
 static inline bool devl_is_registered(struct devlink *devlink)
 {
 	devl_assert_locked(devlink);
-	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
+	return __devl_is_registered(devlink);
 }
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 2f1c317b64cd..9d080ac1734b 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
 		cmd != DEVLINK_CMD_LINECARD_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!__devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 7634f187fa50..f229a8699214 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -512,7 +512,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 
 	WARN_ON(cmd != DEVLINK_CMD_PORT_NEW && cmd != DEVLINK_CMD_PORT_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!__devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/region.c b/net/devlink/region.c
index e3bab458db94..b65181aa269a 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -234,7 +234,8 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 	struct sk_buff *msg;
 
 	WARN_ON(cmd != DEVLINK_CMD_REGION_NEW && cmd != DEVLINK_CMD_REGION_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!__devl_is_registered(devlink))
 		return;
 
 	msg = devlink_nl_region_notify_build(region, snapshot, cmd, 0, 0);
-- 
2.43.0


