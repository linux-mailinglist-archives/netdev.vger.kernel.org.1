Return-Path: <netdev+bounces-57605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961BC8139B1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504EF28310E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE367E9F;
	Thu, 14 Dec 2023 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OI9eWQMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF311A6
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50c0f6b1015so9874301e87.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577753; x=1703182553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33J8BP2HLxzySsghbviJPGk4M7islA6m5mnPAfoHhcc=;
        b=OI9eWQMI2wlQDaR7JVumqW6miG90baGvdMM1N5cR8FLFcezPDX9JWwNVD79xzZv74i
         pl7RnkE+FHTpOuBcuxIJt/l2vThAdcCCC4a97T4usOZ4s236gVv/lyaG2A8RuhV7Y2NU
         Y0Ndvlt0/mFTBjIwo+2O7dmk9SpLkETwOj+h6w5WW3Vv/+LK7uy/A1JbA0vz8UB1mW52
         hi/T5LngNRNF/7I7i8bjx+tF4o10YUg2hfKc8DHQJVCKBUnDTqQLA/xp7UKl1nB3i7id
         Jb3xFRIFQLD7aqBQbCOMUSkF4OgQM5mj/cRZBYiG8MQZfBadmc1U22Eiqdsw/sft+BnA
         rx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577753; x=1703182553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33J8BP2HLxzySsghbviJPGk4M7islA6m5mnPAfoHhcc=;
        b=LeJRElKE9yDDopYPb2gXEvgP+yV/LUPkoZYUawkSRBjv0ovnCUXFQS0Ry83zl0q4kz
         rxh6IfZDzi/wFGpgfFLOuG60lyTzay1VtQYloE4HkKhe2GLSUsF7lK10zGSO3RoBWvQn
         1UGNw1SirMYiAijCQLPgESQidObSKjZWYYqkbfqe2Kt2evE0nQ/IkrsTGuDTy+O3hSqF
         AvZ7f98vHPOGL0kpfohMu7gFxL/sNWKS3JFZAB09LcQeciz+RgVJrwx0kLD3xIue2xK5
         mVGNyaqM1rMJimNz+KivhnTAENUuch1FXbqMK1QC28p5x+LcrFSANQvTVtH8ZvtWv1s8
         WbgQ==
X-Gm-Message-State: AOJu0YxPKWSakL2biiPS9pBDWcZp2gylb7yLG7wqhEv5WyomUSL5XRYS
	Db4nAC6R0wgAcMAymUE3vCR8PQbLyY4W8J5P9wo=
X-Google-Smtp-Source: AGHT+IFNx1T4f34HGhXAEYUxQPrqkFA83hCi0NV3HboJqLY0/aM0Jii66h8eTiY40Wr8XnPxdlDJXA==
X-Received: by 2002:ac2:455c:0:b0:50b:f486:88b8 with SMTP id j28-20020ac2455c000000b0050bf48688b8mr4400690lfm.76.1702577752879;
        Thu, 14 Dec 2023 10:15:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm864392eda.59.2023.12.14.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:15:52 -0800 (PST)
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
Subject: [patch net-next v7 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Thu, 14 Dec 2023 19:15:41 +0100
Message-ID: <20231214181549.1270696-2-jiri@resnulli.us>
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
2.43.0


