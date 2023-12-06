Return-Path: <netdev+bounces-54564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56361807776
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD42820F1
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737576EB57;
	Wed,  6 Dec 2023 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OkKblQml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2F139
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so3106166b.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886884; x=1702491684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLuPH9knSzWO+PbfNJ8XFJ7ffEL7k13puMEmm91Trcs=;
        b=OkKblQmlyo3W10P7picsFdwLh9NWhlnd9KKvdZZnr3JSVmgEDB9GORGdRxBUenukWr
         2Lb9UZyOj82SNwlOKC9HOtX7NQYH0KfnRsIlnc1r/JmDUZUQgIVpeA0qyVS6vCJkj5jB
         cpYJelAq8zy/GqkU9NlIT/Gz2DAYrkiS+AJ3Z9tKlR0jckaWgjVeDkkFb0mHC3CkZ9/J
         nwQ33n5YmpCNUsf5RybVIOYqfvLj3bYFYigBuxTIMY9Mqu8ry58J+vt+LId5lwP3u0da
         6NMMp2SQdeaxDCOJxI0ai0Jb82nbV+Dv5+ISKCLr0XlnsJ6L7BoaOyRwCIviv91U3bev
         dxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886884; x=1702491684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLuPH9knSzWO+PbfNJ8XFJ7ffEL7k13puMEmm91Trcs=;
        b=I3AbG/gRSb2HdqwVrQIAlQ+tr2/QuygC2rjDCbsUJIeqcpWc+G8QGn13gD938Fbu+O
         qJaIbwrARfftsdwL/tT2qTcKVFkVD/8trd0aNqzAgFSM/tBa5QgNgHKSNy4NN1GA3g95
         STK4wMQtQB65W2YagpZ6wLA/b+VFkE5LGifiAv5KVqfmBdvuV2BQaUzyrGQyQe1xeedp
         WxjzYcKR7vvSXz5wCExsywLODABezszAiTvjMqg6NuaFtihIeRTZAUh8ae7TQFdQMQGn
         MVKlnz8+4Pl31NdKGZb8Se7w8Dydw8OjK8l6GKphInMlsl6i3Wnqd33cXjcMu1OOjrhu
         kuYg==
X-Gm-Message-State: AOJu0YwOsMz0dPPixFv9YQift6TWV7WqMaw2zouCmTo62mT67uSHfQSi
	HXK+VLZdKYpXXduvQZNlc77CAORPfHpC+19smMI=
X-Google-Smtp-Source: AGHT+IGBr5IbfhiRMfXjoytuaTIuhUGHHgwDzLVRKkxP5ZS80nIXRabxIR+4rut4OuYNxJi10kDIxw==
X-Received: by 2002:a17:906:11d8:b0:a19:a19b:420d with SMTP id o24-20020a17090611d800b00a19a19b420dmr578428eja.120.1701886884460;
        Wed, 06 Dec 2023 10:21:24 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906564600b00a1dbda310f4sm249912ejr.158.2023.12.06.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:23 -0800 (PST)
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
Subject: [patch net-next v5 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Wed,  6 Dec 2023 19:21:12 +0100
Message-ID: <20231206182120.957225-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206182120.957225-1-jiri@resnulli.us>
References: <20231206182120.957225-1-jiri@resnulli.us>
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
index 918a0395b03e..3fe93c8a9fe2 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -202,7 +202,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	WARN_ON(!devl_is_registered(devlink));
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -999,7 +999,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
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


