Return-Path: <netdev+bounces-49125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC27F0E0D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F228207C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02BFF4FA;
	Mon, 20 Nov 2023 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sqyCVOAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A98D10CB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c2a0725825so558426366b.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470023; x=1701074823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPea8PV/Lzln8WWqnBMyajL3ID7zpvNDOa2t9VBeu3s=;
        b=sqyCVOAxeVKJKWVZKwTp92+XAez9SanbIa1Y8pU8/3leP2F156GNApGA8Ea68mRzZl
         uuBZxw5RqLU69XayjC/sNc04OK2KU2AYg56IZFErwgikZpYrvLitQqfxtz6ZxtjyCjI7
         9Ab+UGiQwooRG1RK8P0kkOl/jh2iYM+s8A9v5LLFw91tsP19y51pYiPU7uqt4T2UOMVm
         bKWaa9BRlIAPAFWs6GQS9HWD9HLYTlbyEIYcGo0ysIIqd4dp52XkJJTEraiwTwKcPJyQ
         C8+9A4nm6RlvZic5GhgSXR0vXAaQ8zkEY0UHajQlUpVQ//mj7L92zwxhLjlBTVt1/wWJ
         aJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470023; x=1701074823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPea8PV/Lzln8WWqnBMyajL3ID7zpvNDOa2t9VBeu3s=;
        b=HAIEwHlv4RKz1dKKKHujnkOKEzb23yoGWCneQOzHv+/yOzG/0EDKDKYtxguYfjfFe6
         eOiTL2UBGkxNE2z6qCsddVq4Tgp0TjfbyxtvEzG7VfPpa6KohOZ7jiF0fs6h37D36yQv
         TCB52nN+NdXvXCtb4ptk8Rv2lbOdFREWzjHEr5GL9D4EqehUitEOwUA9IONPcgSO+Sly
         W7vJrMlXY7kaou5PM8hZL18piX92pg2EfJdg02Nb7ZpTdKVvGbkeL0CGIYjlnIBnzHMa
         zzt/62G5xaeq6MZ+qUo1mN9QG7cJRr0K4q6IYm9h1lWgWB8/aqqXEWTbYIWXZh8qEAi4
         xnxQ==
X-Gm-Message-State: AOJu0YybxDot7mF6zagdD4FpRdvXPCuH1W8QaKBI8otFapjeLe61ofCl
	H9uXYhP62FmuL5CyJPzrtedvDW8Pqfffa0OUb4j8og==
X-Google-Smtp-Source: AGHT+IEXYiPYdzMvEREnqUJ0VNlXxPocRnItFqbwdeBXpgufJdIisth1SYVH7XHI4CH+1AOxNS2YkQ==
X-Received: by 2002:a17:906:c115:b0:9de:32bb:fa94 with SMTP id do21-20020a170906c11500b009de32bbfa94mr5176921ejc.64.1700470023630;
        Mon, 20 Nov 2023 00:47:03 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e4-20020a1709067e0400b009ffe3e82bbasm253439ejr.136.2023.11.20.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:03 -0800 (PST)
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
Subject: [patch net-next v3 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Mon, 20 Nov 2023 09:46:50 +0100
Message-ID: <20231120084657.458076-3-jiri@resnulli.us>
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


