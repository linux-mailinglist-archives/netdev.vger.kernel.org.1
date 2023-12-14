Return-Path: <netdev+bounces-57606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C88139B2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A61AB20978
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAB68B74;
	Thu, 14 Dec 2023 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kgQusn5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3810F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1815969a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577755; x=1703182555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPya/tj37w3+Pavkqq2uQ8tsfkZUvXPv2JD2RPZVhGQ=;
        b=kgQusn5F/BEqvYJFTn6uokl7UzHsKIW1AmJTlg5oWeWrQc7OUOSKWWFkyLsTYmfWxo
         MKRgx9xZY6RpZ/gt/X9VcFyQ7SOkAohorPUzM0J/lHdNdliVWGGZtvrijKB+bja7YcsN
         EpzlPvx7xZjJS/KY4VrlnJ8kmQ6kcCPj2VA98qWVHggjPTBrEZE9qrzuQSUT4wlQb2wd
         +rkc7Y6K1Nrir95GI5j692hblOtslrJnZoXstOr1sTnn2U31AlbSgH0Q6aMou7B/pd1n
         51azRimyIt4c89EB2UEYOF1F8/q2Jmh0xfW+v1Zi+c8RS1G3Frw09wyMj/ny1mtCEZ7h
         r//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577755; x=1703182555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPya/tj37w3+Pavkqq2uQ8tsfkZUvXPv2JD2RPZVhGQ=;
        b=U8AFv8rUfPnMBzCOmiFjLNPZj/GTtzp8+030Vs1MZvw1AoHJK1+3coqyXdyRF37FEd
         kWzYakU3P3pee4oT81pY4p+N7UFDZCTON37nkRYRBak2GFMoOLOiKo5ND8YOD4pm2rLM
         C6CZ6/U91cYTqzvC+X96FQkCoNFMaIdzIehutEm0EQ10y0XB9tSLGWk1yp2U2gDOuRIh
         5NqfkwPCfAA6HFwGLG8/k2O0xfEbM7X1zJZtIshT6eS0C+jUQJ0v8CepVlvIIDrfzrf3
         f1CYWHrTrWCOe/lG7DUnCY5kO+uqPTUh/mEP3544mTU4haWFep5tSuftWmG/tORa5HZ7
         gsNQ==
X-Gm-Message-State: AOJu0Yx5x+BcUqDDNi9oroFvKhfDP8n/FEJDvgWOh4Vy8zjluoB1GEgn
	IIBJ+7QBEmS8D/aIhnkRz3NatV1CU0MNvMKpmdU=
X-Google-Smtp-Source: AGHT+IEWPtUbWATzbImk4E6zT0Qlp7rGo+uuIrDll+llU08We0dL3OK/jeQ0Y6Xp+wSL4SDDm8PkAQ==
X-Received: by 2002:a17:907:2cd4:b0:9fa:7c87:b10a with SMTP id hg20-20020a1709072cd400b009fa7c87b10amr11798162ejc.10.1702577754668;
        Thu, 14 Dec 2023 10:15:54 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00a1ca020cdfasm9697560ejc.161.2023.12.14.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:15:54 -0800 (PST)
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
Subject: [patch net-next v7 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Thu, 14 Dec 2023 19:15:42 +0100
Message-ID: <20231214181549.1270696-3-jiri@resnulli.us>
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


