Return-Path: <netdev+bounces-23684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23476D1C7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707651C2131F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D6DF51;
	Wed,  2 Aug 2023 15:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03203DF4C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:27 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81024EFD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3177f520802so709607f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989641; x=1691594441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aG2vhvT3L7ndx5Y3qElr7N1jus2m24HM/CUdo9QK2c=;
        b=smqkfGP7Pxz0yjF+bxDknWR5pRm9BESMeXK+Qz9iuVQKdoxWRpgIXALhn3Ojw3nndh
         8vvnj7ZU1ecvqVciWkLF5gJUhpk3QGOnqiLrDLjBZFbadnn4UU0uqDv02XAjlxdNbvOx
         U524HOjvZwyxmy31y3TWrqU0J/TEezNXx7NslPvIAuPwQOkWxGZOXyACYaEvbOVgSNFC
         sls20X6Gjtgar7Ukix2mLFiqsSSXIkkxtY/AKobfIE2YOumXXOH0QkLGg6F3mrjiN57+
         d6zNaQZ4VNd4uUmIcDw7aMU+nt2hRUaQy416lrjMTt73ZKi0W0DHoYH1oUQzZFN0kLpe
         E6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989641; x=1691594441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aG2vhvT3L7ndx5Y3qElr7N1jus2m24HM/CUdo9QK2c=;
        b=UgOXvodZ9a1zYMZ49gZV6ILNsRu+xAUsZx9Sl/zG2uBwujrwS+xJjCg9mnApQywqlO
         JBsEWpVb4y6BX/93BlTu/mH4oFp8OTX7DIUVpH8SjVCijd+2phd0TREnhpxKF+VMk79x
         Bql3mq5JmcoWOTq9/j4Ql6tp6R3ODldL8FIk4P38YXUEpP77cNL8LrGhTsd6FYYhGzGz
         R/5xuqod9bgE2/BMYYQ9Imb7msEUFz9SUvPiwctszOvC/frEf+5NVdYrIxVuxQD4bvYr
         VRjyUoy/hxIIePEGnThYXgOgJB+M0BFaAgVhCCQnYZmvC3kPmGC35eKzIKcIGIKRb8YJ
         hYYQ==
X-Gm-Message-State: ABy/qLaUgxAuHFHgtXANTDGttDrrqe4itjPMPoTpQwlVc5efhjySlqfk
	AA39Dgx5xuDAUT2HqBavvLyeMg1q2mdirykHe1M7fQ==
X-Google-Smtp-Source: APBJJlFHz0TyLR18anVrsH0huKv+DLXJ3b5uXdmxVAwayL8vWc7KhdMWDmAKqAhjL+nCtnO4HIOYHQ==
X-Received: by 2002:a5d:65cc:0:b0:314:3c72:d1ba with SMTP id e12-20020a5d65cc000000b003143c72d1bamr5248711wrw.20.1690989640855;
        Wed, 02 Aug 2023 08:20:40 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s21-20020a7bc395000000b003fe2ebf479fsm1881830wmj.36.2023.08.02.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 09/11] devlink: rename couple of doit netlink callbacks to match generated names
Date: Wed,  2 Aug 2023 17:20:21 +0200
Message-ID: <20230802152023.941837-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

The generated names of the doit netlink callback are missing "cmd" in
their names. Fix the names and remove the original prototypes.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c           | 4 ++--
 net/devlink/devl_internal.h | 2 --
 net/devlink/leftover.c      | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index bf1d6f1bcfc7..2e120b3da220 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -196,7 +196,7 @@ void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
-int devlink_nl_cmd_get_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct sk_buff *msg;
@@ -804,7 +804,7 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-int devlink_nl_cmd_info_get_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct sk_buff *msg;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f5ad66d5773c..419bc92da503 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -216,11 +216,9 @@ struct devlink_rate *
 devlink_rate_node_get_from_info(struct devlink *devlink,
 				struct genl_info *info);
 /* Devlink nl cmds */
-int devlink_nl_cmd_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_info_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 8f42f1f45705..094cd0e8224e 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6282,7 +6282,7 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 	{
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_get_doit,
+		.doit = devlink_nl_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6536,7 +6536,7 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 	{
 		.cmd = DEVLINK_CMD_INFO_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_info_get_doit,
+		.doit = devlink_nl_info_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
-- 
2.41.0


