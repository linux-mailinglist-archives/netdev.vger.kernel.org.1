Return-Path: <netdev+bounces-56343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41780E8E9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4391F21A70
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9E5C074;
	Tue, 12 Dec 2023 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hRvc9Loz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5F92
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54da61eb366so7269214a12.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376264; x=1702981064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHh3MZJVlWMre4LtMHfrndshjQd5a9TSrM1m3pB1Etc=;
        b=hRvc9LozXJk/NQe4yClQTK09EQ2DFvYPzPrhna9G0x6D2wQztPMM0Dnej1NvM2qCaY
         Q729u7jTLQF/EOK+tx+uPdD2bzVEkx65jjvpZ1YL7DLVPXlANrxd5Y/Dm5NRdeti2zJd
         4h+FbRJdMwklgesyq4mmB4KVdhaky9NQjCFrsgZoZZ1PcEtZ8hizGiHhahKl56El567P
         I/ULYN75Ez/ROMRdBmoS1vLpOCF3mtr2QV96nYE1J8Xe6LA3PDeU/5clhp76vTmnSn8X
         uCP9K+1CcuhQL8lfRXmguIdavcrOdHjS8fB7qWnSpNFxv8QfAriNoSdkJAsXd+Em7kH4
         Ylbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376264; x=1702981064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHh3MZJVlWMre4LtMHfrndshjQd5a9TSrM1m3pB1Etc=;
        b=PSWVEPG9uOCubFZLtP3QgzdH09MbM/oTMUWn9TQ1yKaxKh6w+YyC1nF+kjXXEHU3Kt
         P3/Tti3OkYOkApF0pz7JBWVbZ8k0V0roQ3NRQVziUgfICCPBK5aPIGnnlRJs425E/UCo
         pftbGTHzu1LJJr9DsPGmSzrzDavNREBq5Ea/VAqSfX9SibuYinK+/Vvzg9t67+Fcvg8m
         MBK4pzGipFuYVmGA4va/BBzVUEDpLB3pbFB5Qr4CC4eEF40WVZmbGu9rNkUppDxPbPqj
         xlTGU/xQjwfkVuUMX6Sd5AM2oWPR65IRjU9/VCMLKyXk9VO8ptC+umCMwcTtstfPqoj6
         9xGw==
X-Gm-Message-State: AOJu0Yzc9ePlcqQf8lUrmBG06gP52iXhf8cXO/Cbd8aRR7TWhvmXRE+6
	ztRNugyDq9puWTtHCB8EK5CVmsSC6cyktfrpJPc=
X-Google-Smtp-Source: AGHT+IHBlOKVZl4sAakvl/di+IFtvDxd52wM5kV9Oh0v3CLUbbW03krdIJwQob8pvMdaX4/Y9SMLXA==
X-Received: by 2002:a50:c057:0:b0:54b:27e7:f965 with SMTP id u23-20020a50c057000000b0054b27e7f965mr3877363edd.19.1702376264677;
        Tue, 12 Dec 2023 02:17:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f27-20020a50d55b000000b00551bef45cb0sm150938edj.24.2023.12.12.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:44 -0800 (PST)
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
Subject: [patch net-next v6 4/9] devlink: introduce a helper for netlink multicast send
Date: Tue, 12 Dec 2023 11:17:31 +0100
Message-ID: <20231212101736.1112671-5-jiri@resnulli.us>
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


