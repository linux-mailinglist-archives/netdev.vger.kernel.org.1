Return-Path: <netdev+bounces-48438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707207EE574
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03927B20D9A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565BB3D3A3;
	Thu, 16 Nov 2023 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CVultNAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C2D56
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso149505966b.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153307; x=1700758107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPea8PV/Lzln8WWqnBMyajL3ID7zpvNDOa2t9VBeu3s=;
        b=CVultNAjogLhfexuZ8wCILXNI95kYltvWqAN+CKzUTlBuApF/YX1WkTH945bUM6WLh
         tZs+RnzEebGk97eec+BU4SS4+Wxjvk3Avbkd/YTo9a73K/fqTySQGhLdw92AJF5LzXhr
         75tVCNnEOQZ6OhhLvWfVKYK33VljZS2vUE+S1zL1pGM936ZiBCheJdtBPn9dIxlp9AoZ
         DxKyaFIlZ576LOVn9eqSLweCbmvls1z+qgCIiBKzjr9rXcIbEYAPMv+0tprLvYktxzHY
         pE9stilsIo7vLVoYGlzMrP+iGTcW9y9+QSOr7XZJvTQ4xnaySA6+aXLWy2ty/diA75ml
         7diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153307; x=1700758107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPea8PV/Lzln8WWqnBMyajL3ID7zpvNDOa2t9VBeu3s=;
        b=mmKYP+gKoqF+OCxuBJOPZCvEN1I/xrQZRK6FoQNGEBxDMaJlKBcquf7zU0HJuMOxYF
         /5EEnrxD+bdX0PYgeYwooPgVJZZLUdhqOmAMMxEFCB7s7bwVen1/hCrlY9t007MrJvRH
         Cda+0lT43OGMPiOP81X7hfG65ciEfCwMAysS11tdrImqfOAKLGcCn0kMqextrZ2Bxjl5
         X9aL7Qb9dTy1XGUN4UTp5bKROVyfPiEqrIOMrGviP8p7hGQrk3hWMvUPJZeEE4RJNeEO
         UlG8jIklnKcneBBq/LjzunH5AjkkZ7rhMpkG80Xfvv579LiZhsJMeFQX6dB0p0UFOcUV
         dg5g==
X-Gm-Message-State: AOJu0YzEYMjMbOIYQQedb8kxfydYHLQi3uqmM91HxK8/LFsjYWfbcbIO
	OzxD8282S3oLetPfA5uz4lXHWePKTjpmmxlHgi4=
X-Google-Smtp-Source: AGHT+IHlaQ6vB9PyBu7+4NG/IHODgpexkzNVsEoZEYnCKDFZphhYgoDVcy8U8rJHvt0gFUJeXvk79A==
X-Received: by 2002:a17:906:7d0:b0:9e4:6b2b:35f7 with SMTP id m16-20020a17090607d000b009e46b2b35f7mr11030378ejc.41.1700153306673;
        Thu, 16 Nov 2023 08:48:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906080a00b009a193a5acffsm8645296ejd.121.2023.11.16.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:26 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next v2 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Thu, 16 Nov 2023 17:48:14 +0100
Message-ID: <20231116164822.427485-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116164822.427485-1-jiri@resnulli.us>
References: <20231116164822.427485-1-jiri@resnulli.us>
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
index 183dbe3807ab..381b8e62d906 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -90,10 +90,15 @@ extern struct genl_family devlink_nl_family;
 
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
 
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
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
index 0aab7b82d678..396930324da4 100644
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


