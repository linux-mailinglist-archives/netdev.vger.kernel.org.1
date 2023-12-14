Return-Path: <netdev+bounces-57608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C48139B6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85238282F7F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C768B7B;
	Thu, 14 Dec 2023 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2q31YpY+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51098A6
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso11657522a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577759; x=1703182559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHh3MZJVlWMre4LtMHfrndshjQd5a9TSrM1m3pB1Etc=;
        b=2q31YpY+1w4JpM8jz9vklZonRubfbFt/lgs0n9yKY3MRysey2KL+hEMOKFWjfA2S4A
         rmNz4lAzd/tiHLbfle6Ol56zWbJc9uB7DX93zYNMidEt0th1gWBTP58SLaTzTjoiNfzK
         jq148l3d5eX3q/OrlKdZZbheXiaEZnQUZeGR+LOqmlutEGvD0gFNOpH8nFGJqgLFeey8
         MfPyGz006vG3CfB8QKzLajHBb/Y9sVan3oidg3aKxMFhItrFGfCEjTDuKhTJ+Ebe/GET
         94r/MvUo7+xsaHxci+UwsQfQjO66Hu5EtzvhvpYR5mpCUNPfuVfGrPeNSIsrLV8vxfK7
         J/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577759; x=1703182559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHh3MZJVlWMre4LtMHfrndshjQd5a9TSrM1m3pB1Etc=;
        b=ujGLm1nDvfniozbieHs5t61MjtAAApSn2G56tSOEJxBzOWkWZ/3f2uOn2IXto8o64+
         7uQ7PBX9yKuJULhsm2qA9GgX0v8usm4RsvDhnLFGLuzJWtTlNckP7xWBBE4jhLcAkAk0
         Xb0amS8wY4w2aksrdNTHYpHkTvI5DAc8gKhxnm6bgMdbRWkdGHFsMDll9RNo47kckGJQ
         GRtAzLoumORWfrCBLKOabURovs18OK4h168oquo1Sk4cT9f7ajV3leWtEJTbRQPRR1ed
         FGG34p2Gn4oRWbxWhgccLsAETHa61p1pwvOIyg/14sfp2bkXmZkEDuMffft0IKZtO5U+
         P0pw==
X-Gm-Message-State: AOJu0Yzro7EcwifINRa55gjjbL+r5iu2qbU8jA4pKDXYxiSFFtnlBfw4
	VqPOaLjsKmnMv1zhbm8MI8w+0AHGeeODetIeTYs=
X-Google-Smtp-Source: AGHT+IHoqoyJbWEgRW+bbtcZd6boJdTHzdhDbtbuMQrlo3mHFvy8Txm8BordgiU76Dlmz7esUTswTA==
X-Received: by 2002:a17:906:10b:b0:a22:fb36:d7c2 with SMTP id 11-20020a170906010b00b00a22fb36d7c2mr1615421eje.139.1702577758704;
        Thu, 14 Dec 2023 10:15:58 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rf22-20020a1709076a1600b00a1d0b15f634sm9651831ejc.76.2023.12.14.10.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:15:57 -0800 (PST)
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
Subject: [patch net-next v7 4/9] devlink: introduce a helper for netlink multicast send
Date: Thu, 14 Dec 2023 19:15:44 +0100
Message-ID: <20231214181549.1270696-5-jiri@resnulli.us>
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

Introduce a helper devlink_nl_notify_send() so each object notification
function does not have to call genlmsg_multicast_netns() with the same
arguments.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c           | 6 ++----
 net/devlink/devl_internal.h | 7 +++++++
 net/devlink/health.c        | 3 +--
 net/devlink/linecard.c      | 3 +--
 net/devlink/param.c         | 3 +--
 net/devlink/port.c          | 3 +--
 net/devlink/rate.c          | 3 +--
 net/devlink/region.c        | 3 +--
 net/devlink/trap.c          | 9 +++------
 9 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 63fe3e02c928..19dbf540748a 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -217,8 +217,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1013,8 +1012,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 	if (err)
 		goto out_free_msg;
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 	return;
 
 out_free_msg:
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 510990de094e..84dc9628d3f2 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -191,6 +191,13 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
 				  DEVLINK_MCGRP_CONFIG);
 }
 
+static inline void devlink_nl_notify_send(struct devlink *devlink,
+					  struct sk_buff *msg)
+{
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
 /* Notify */
 void devlink_notify_register(struct devlink *devlink);
 void devlink_notify_unregister(struct devlink *devlink);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 0795dcf22ca8..1d59ec0202f6 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -509,8 +509,7 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 45b36975ee6f..67f70a621d27 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -150,8 +150,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_linecards_notify_register(struct devlink *devlink)
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 7516b524ffb7..22bc3b500518 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -356,8 +356,7 @@ static void devlink_param_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 static void devlink_params_notify(struct devlink *devlink,
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 32f4d0331e63..758df3000a1b 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -525,8 +525,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 static void devlink_ports_notify(struct devlink *devlink,
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 0371a2dd3e0a..7139e67e93ae 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -159,8 +159,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_rates_notify_register(struct devlink *devlink)
diff --git a/net/devlink/region.c b/net/devlink/region.c
index bf61312f64bd..7319127c5913 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -242,8 +242,7 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 	if (IS_ERR(msg))
 		return;
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_regions_notify_register(struct devlink *devlink)
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 3ca1ca7e2e64..5d18c7424df1 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1188,8 +1188,7 @@ devlink_trap_group_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_trap_groups_notify_register(struct devlink *devlink)
@@ -1249,8 +1248,7 @@ static void devlink_trap_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_traps_notify_register(struct devlink *devlink)
@@ -1727,8 +1725,7 @@ devlink_trap_policer_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_trap_policers_notify_register(struct devlink *devlink)
-- 
2.43.0


