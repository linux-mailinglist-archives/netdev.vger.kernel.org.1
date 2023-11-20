Return-Path: <netdev+bounces-49128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA87F0E10
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28672282084
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E09910790;
	Mon, 20 Nov 2023 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="02SWU+pD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A66110F7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ffb5a4f622so35565266b.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470027; x=1701074827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDezKWz0doJAOlG7AP9dGlF4Zqe7hOwSp2BSLUMy+RQ=;
        b=02SWU+pDgxjU5+BlGW/9x8TMozlBSquuuWtf+1StqZu8NggbA5e0CzCwuPyrasMRO0
         y8YoGNRdxg3VxVQsw41yNQ+bccMh7+jLeQQgqT134IDFuRk/0d0cOi9B88+PHJIzhdxO
         YU6l6upIGAt7F9VN98S1CPY7gPPVahtI4B/VzWYwBtdORlQM/pvNkfp/NnPKpcrNHTD9
         eIpoHsIF4a+Fdh7uAf0ERKeIf0gbHbraBq0LCEDj9owQhDQVanGW7yhBNjePoTIxR7s5
         GjfIibA6aQmDTsu48rIEt/yW+4a+NsAL+qnGOGYKlQ1j+Anwyv0b+aBQI33O64tIp73w
         N6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470027; x=1701074827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDezKWz0doJAOlG7AP9dGlF4Zqe7hOwSp2BSLUMy+RQ=;
        b=jbiQi+XuyYx6s0i4mCjtBX2gy4EVesHjCNzhr2XQ15SJfHvgRW9WNNwhyshLKp3EpX
         NtrPfe1nYwuctmyeQZ41j1JeHU2CZkho0YSCs3jOIYbjKBtmu+EhPOcETrqyyS7ArofP
         01dUvDyQiCxNQUSfWpminPgPyJPd90KYsbB7T185r2vWGHcYUhc3tMgHoG1hAlN9uPw4
         THovqg/KOYZZoCHmqtCBb7G+/vD6bItFpH3sU69jchGlFqhK19if3tubC2rRaM9ehwmM
         OuDMs4wUDkTGNcAmYG/RvpYK3e59pjOG+px3lbLFCSFpmJq1LBeayV20kyTSI6iq82Lk
         YBDg==
X-Gm-Message-State: AOJu0Yz0cO7e4R7zUmWDJHz2i3E72v0WuRUYQwKvXZQDIwlTP41ceHzf
	7zs2HQjVgoZHq/hc2Pr+eHjdQv3pn0JN2pFkQE+piQ==
X-Google-Smtp-Source: AGHT+IF4HdB+Othm2BjxAsjUfYFWs44rbT1opU27zhrwsMn1vPBCArcgWfuztiPFiPAdSvWMEu+mOg==
X-Received: by 2002:a17:906:2d2:b0:a00:76fe:9016 with SMTP id 18-20020a17090602d200b00a0076fe9016mr31624ejk.21.1700470027273;
        Mon, 20 Nov 2023 00:47:07 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906709300b009e5eaf7a9b6sm3673222ejk.139.2023.11.20.00.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:06 -0800 (PST)
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
Subject: [patch net-next v3 4/9] devlink: introduce a helper for netlink multicast send
Date: Mon, 20 Nov 2023 09:46:52 +0100
Message-ID: <20231120084657.458076-5-jiri@resnulli.us>
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
index 582b5177f403..ecbc6d51b624 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -216,8 +216,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
@@ -991,8 +990,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 	if (err)
 		goto out_free_msg;
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 	return;
 
 out_free_msg:
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 8b48a07eb7b7..e19e8dd47092 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,13 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
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
index 93eae8b5d2d3..2f06e4ddbf3b 100644
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
index 6bb6aee5d937..854a3af65db9 100644
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
index f1402da66277..fd6bfabc0c33 100644
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


