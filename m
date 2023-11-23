Return-Path: <netdev+bounces-50631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65A7F660C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009C0281AFF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532464BA9C;
	Thu, 23 Nov 2023 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="D/vDwItC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19718B
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so1544885a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763351; x=1701368151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqAP4zVW3tr3kQv/U3Y5QSJhXtJi2tdSQ5AvLLkkNsk=;
        b=D/vDwItCt7d1D+aNCm60a5jHecf7CoeKdFJL56986PwlEWG7AqvursK/QgUWFmEjtf
         zA8N/5WZpJlK8snmDJ2ESg4ij0oy6pRTJzp4KI33XhitinU8V37hynqBPeHIGxvnbnJl
         Ekxr7U6WFel9YYT3NZ5cU7ep/+DY034tn8wPsmot70P7IBdZcR6sk1s4hGTrRF4kuZkS
         GMmwEh+fGz79lJdgnH/8oQY+uR4GpWlLyFhQvYstN1HLdA5Co4cDdLSMqt9OR4v8rzfZ
         t14Nd10sZg/Fdeqsx+BTCNgNM1DEr4Pewiw2/+SlMadPewwxj7kc6zuSptvqgiUkVPRN
         BGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763351; x=1701368151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqAP4zVW3tr3kQv/U3Y5QSJhXtJi2tdSQ5AvLLkkNsk=;
        b=c9y/CgW+5jVoBgXf0qbr0NVaJH6JfIRN2LLf48f6GUMgmWXvIzUGdx7N+RXlDZQZQi
         ImyxKyiOVZahr8zrbWECpFgqIcYl5/9H0Rfy5BrijL1+HJ6XE+/MOmpXZSZYvdi5cL4y
         Z++D2D3BShcfW0robpmf10FnOVsHSx0h0taWxU3rcC8PEdV1pU1NuOrFEcQfxw/Ph+c4
         zCt9JlUzLhaNvzFz3X09K1J0T7ooP3OdWpJ5Q2uxmML0x3NtXxzJmnkr4Obc5m1oeRbw
         4dsEWMC5xBu3AmmISzeBy6InmCFjTRKgTc7N32mDzEG0To1wsgyHw/wHZ+2rhz+j4wt+
         v6KA==
X-Gm-Message-State: AOJu0YzNlJZJsZayE7uqHRfzP4XkANd14YB4D94Fy6emK38R9pr4JEa9
	ZOUT1U+/x0RUV5m1ZylV8h9L6nDD795Rw0KbCZY=
X-Google-Smtp-Source: AGHT+IFft39K42cm+cRmvoL4Q+3Ru+JmB5TgyIwpiz2EsqC/JTQryYLVQOmL+WfdTvut/foFLeAM1g==
X-Received: by 2002:a50:875e:0:b0:548:4afe:c58b with SMTP id 30-20020a50875e000000b005484afec58bmr29820edv.34.1700763350984;
        Thu, 23 Nov 2023 10:15:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q1-20020a056402040100b00536ad96f867sm900617edv.11.2023.11.23.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:50 -0800 (PST)
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
Subject: [patch net-next v4 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Thu, 23 Nov 2023 19:15:39 +0100
Message-ID: <20231123181546.521488-3-jiri@resnulli.us>
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
2.41.0


