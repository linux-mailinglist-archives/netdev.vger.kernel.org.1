Return-Path: <netdev+bounces-56341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E689780E8E7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918E428183C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9755B5C2;
	Tue, 12 Dec 2023 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QqRTRfQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713A9C
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so7638802a12.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376261; x=1702981061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPya/tj37w3+Pavkqq2uQ8tsfkZUvXPv2JD2RPZVhGQ=;
        b=QqRTRfQxRMjw3XMKqbTXmC5XaU6C6JoCsUa6x8mM6Aa8W+CSDyky2aQkAGraEFx04F
         q7Hkp10cQ0siCpurg21kHiwuVCPNrXNlgX1ivcivtREYugyMQ1ljyFaAT6oBmXcncAM4
         28y5VxcC3GVcB+Gu6bpGCuoS3Oj1l915fOak4uq6alHtO0i7cEKEMckQnIHsse2ztSQy
         Ks1ZnJgPkw35j9nIajwDUCQp2S5GJvyHsaEBT9QoDWRxlQhCSuera0F/n3jxFtnOB9oj
         /SKZjT5dsvSRMqv0njt/I31LHmyNN/y56pFpKPQ9lh+JhLX5g5cO5NVG0LarHkzv9hzr
         fYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376261; x=1702981061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPya/tj37w3+Pavkqq2uQ8tsfkZUvXPv2JD2RPZVhGQ=;
        b=wyplI9dPa6TUg7Tg8Q7DUk8HHz4VFcQ3U/l74Csi8CFd9Et4VPjvgHB3shQ4ivXNKa
         TqHUcvkq0ng+nKrOpgCVF8fC7dlFYdCdywDiK8iiyxJ0GP6jB1CVjhXilpN5kOTHnvh8
         miSSA4QWB7l1bp43HUpF44K5/F0578RXEbpu/LWasmkcU06SOJV4vIYcVhjt/HYQTWqc
         z+b4s+vOnRRRi7SStdLw7GfIWj3zSzYmoys9f2s50cAahSA8MRD+aO47Y9LN39Ca+Cq5
         foeHt5Rl5YfBvP0+LAHQTVgULxYF4Za4kWm7ORdG8bC7+2dZB5ADV2TFWGTijk43/5an
         Dd0A==
X-Gm-Message-State: AOJu0YzcGmTARPOhKAzJhetr7JNVttLgCoMaqBPkdTg/+n7Blku4SNWf
	S9nWErnvis8x9R8PKQmxbmR1npi++QLF9B4lQgk=
X-Google-Smtp-Source: AGHT+IF63VD2bnYi8sMWPaOdqBrn2k/UHFLcq2LN+BlOdid8DEUi+hR5PUwN8wJ7R2AT0Th4yMUD0A==
X-Received: by 2002:a50:ba86:0:b0:550:5182:8075 with SMTP id x6-20020a50ba86000000b0055051828075mr3053479ede.27.1702376261130;
        Tue, 12 Dec 2023 02:17:41 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k13-20020a50cb8d000000b0054cc7a4dc4csm4447793edi.13.2023.12.12.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:40 -0800 (PST)
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
Subject: [patch net-next v6 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Tue, 12 Dec 2023 11:17:29 +0100
Message-ID: <20231212101736.1112671-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212101736.1112671-1-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
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


