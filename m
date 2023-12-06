Return-Path: <netdev+bounces-54568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D693280777A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688EAB20EC4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A286F633;
	Wed,  6 Dec 2023 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FZoZl3PJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A06D122
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00cbb83c80so4278566b.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886890; x=1702491690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsnq/J25xaBJGwu2WyLBaKp4IolP8KT1wW4jT6E/oeI=;
        b=FZoZl3PJdPs2RBVVr7snIEt5Wr9UR6T2DvEBPl2mWxKssgOluE6iAQdRLgdoOjGrl8
         lBj0jspV0bdSRDfrEI0sLfGfVWJDllvm1t8kA1Karj/ynPQatFXth7v7anraQ3VM30JK
         i9fj/+dPy7AOsHyvt0B9jF6cPNidJTSe9TUueIzx4Azav/3p88qD+aRkmNkXS3bDQdB/
         ppE3CMIW/6vR5QdlW+F0ZTTcgLfrYVUlakPTWT9a2lll0w65ag1HY7SuxI/POa1Q9oVR
         H6N4L3mBpIdJYi4Yg2gCVNK5pgIhntNuleUbGK5X8AWemexIXj5rxBPc0jpJ6hxCoA3l
         UFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886890; x=1702491690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsnq/J25xaBJGwu2WyLBaKp4IolP8KT1wW4jT6E/oeI=;
        b=hmH+7y9fa8XgQNG7q9BxjlSrHBo0EY4IdstPnNmbQK+CcAIjNxcaOKk7zT4+SqWoMp
         21l2NNqL2xnjo3/bE7H22sofaOfwirEtPhoa9P5Vk0F14CYi7Lto9r1rqcKyI8gOG5mQ
         94aSbjI8rJlHVKf41KLzqDMZNi7ONsQc+6DKm8qoLYlhOUoewQpt8vLH5c37MCl3oRAV
         TtjQYBWO/j2ToXO5uy8a7B53gIcnlXnLRb97kfsywA9ColYwFD/cqShWOqeEN9GUgzRN
         L91mvwktXpGPWW1LmVpa2xn1tK5TtmdtdGYVrsb7GNFkhKf+4TyOe96A+/Th/OjvfETY
         h5nA==
X-Gm-Message-State: AOJu0YwgxahkRGzeIzo3yjp9n+DNKfdo8IwrpOQQrgsiBWYxn7Y69tVu
	M3JgGnFmSpSrpixf/4CyMd+dyk0Qt2BlH5hvjvc=
X-Google-Smtp-Source: AGHT+IHUgreVyigo76btJ9f5DnqgRY01XG+8ls19/kWRL1i/PIZOn5EcDVNnMIH2T0eglGljIdaUKw==
X-Received: by 2002:a17:906:7c4c:b0:a19:a19a:eab7 with SMTP id g12-20020a1709067c4c00b00a19a19aeab7mr846727ejp.112.1701886889941;
        Wed, 06 Dec 2023 10:21:29 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906341100b00a1e1a1dd318sm251476ejb.137.2023.12.06.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:28 -0800 (PST)
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
Subject: [patch net-next v5 4/9] devlink: introduce a helper for netlink multicast send
Date: Wed,  6 Dec 2023 19:21:15 +0100
Message-ID: <20231206182120.957225-5-jiri@resnulli.us>
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
2.41.0


