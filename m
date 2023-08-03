Return-Path: <netdev+bounces-23984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A776E692
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678D11C20355
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE981EA72;
	Thu,  3 Aug 2023 11:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622651DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:55 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CEA10D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so1050373a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061231; x=1691666031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHSlYLHKZ15lxC4IDTXfvZjFHzQNpdv05Ngn08MEn2s=;
        b=3HA8HNRylZjMqYudKXnqare+GElPAe/8I/3ETf9xQqMtHXr46M10E8Xz8tEtuKn8VW
         bT5yHHfExNQwHbpz7SlfmFHNnLHzq1/GdSIdQdjFbWq8Nni27XJlm/0INS6z4CSVYR2h
         XrkGn6P3clSvTSqjcdhV10xwYRXecTHkkzfVvKYtQQ68t4ZJ83YPT4yc3Y3SVH4veiqk
         tHQkOK6x65qsLDzFyvytmaiVZ/Z30iCuKvqYYnM1sJmu35CAIoTZ+2B8BWv82rNfINSp
         sEzsRnMnGrSVSgU7UF+EkxIWghEFHYgqsZRrWaPMwyfjN7nPev804mR5CH3EldajRces
         UfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061231; x=1691666031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHSlYLHKZ15lxC4IDTXfvZjFHzQNpdv05Ngn08MEn2s=;
        b=C/PsprVwImcpSLvXTXxlhuwXvHG1ReFYW5WRi0fvDfYI+f7lNPDgpwTaPdpuFXIRrG
         umC5ieC2bWlsArkJ/CXB8qcF/avkdvALPk74Z3MvzXptfWVC52vT+0SYn12IXg3446Xi
         VGieU3js6CAQpdRedriuM/aXJ+gJVd2FTM01YPyUy1fdkLcrrTSclm9XwOV8bfHjZDrw
         bGYZ15GsFTMedyqIpe74QHXwWjELybyoUTGL0kQVuKC6TQj+riJ381g4xVshEriKnGCE
         9PBqwsg2aHuFcvilhLPUodvaZnk+rGKQviVpqbZs5Fomsu23NAkWxRW1y+pn+7+ELbQE
         KQsA==
X-Gm-Message-State: ABy/qLaWVir5vkLjFX5u2nQYNaoNccsf7Lu+hXJT/JsYZtUzQlXrWnLH
	FvKyCf93mh7D7SDAvCCD1E2Q+DSgcewdCBWdswXHXw==
X-Google-Smtp-Source: APBJJlHnoq142SkjEWHN3drnJ52hrIBm2G83V/1eRv1KaXYjFCSIAd2qQny0ACKFEy5Srb7LRyZE+Q==
X-Received: by 2002:aa7:d311:0:b0:522:4dd0:de6e with SMTP id p17-20020aa7d311000000b005224dd0de6emr7458196edq.8.1691061231227;
        Thu, 03 Aug 2023 04:13:51 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id bf19-20020a0564021a5300b0051ded17b30bsm9998315edb.40.2023.08.03.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:50 -0700 (PDT)
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
Subject: [patch net-next v3 06/12] devlink: rename couple of doit netlink callbacks to match generated names
Date: Thu,  3 Aug 2023 13:13:34 +0200
Message-ID: <20230803111340.1074067-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
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
their names. Change names to be ready to switch to generated split ops
header.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- added temporary prototypes to devl_internal.h
- moved the patch before "devlink: add split ops generated according to
  spec" in order to fix the build breakage
---
 net/devlink/dev.c           | 4 ++--
 net/devlink/devl_internal.h | 4 ++--
 net/devlink/leftover.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index c67f074641d4..d32a32705430 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -214,11 +214,11 @@ struct devlink_rate *
 devlink_rate_node_get_from_info(struct devlink *devlink,
 				struct genl_info *info);
 /* Devlink nl cmds */
-int devlink_nl_cmd_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_info_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info);
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


