Return-Path: <netdev+bounces-23262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632976B73A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405C6280DD6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB8253C5;
	Tue,  1 Aug 2023 14:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1622EF9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:22 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED3170D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so560005766b.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899559; x=1691504359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aG2vhvT3L7ndx5Y3qElr7N1jus2m24HM/CUdo9QK2c=;
        b=EengHauidvQL65E2niauUWcYD/3aQivBAIUyUt/QQDnT/2lgxn2parPJ339G60LY/z
         1PF1c9Z7/E66iUn5JjFkEgLsciApmix0YlrxPj87uGW4ZYvapQE4oWJTFdWGtHkZtlJ6
         bNz1ILei8Ub5qKkZubie9uhSAHqa5SxBppAm1f7cHxl/gWIVhMgqJa3fCVjwSvp8ASmK
         qCZK9SoTU89MbUdVgBMsAR3VeQ09RMgz9JyGwalT7rvu7ZrSZCRLkC75QkuZHiuSfO5g
         73qBk3fzF9or/0iv+U8A9LWLHk1T6IULr+gW445zbniw0uYF5bRhrBG1m2s5R3zY4x/a
         x55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899559; x=1691504359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aG2vhvT3L7ndx5Y3qElr7N1jus2m24HM/CUdo9QK2c=;
        b=PfUuwrkRVUtxqGBFcq/zFh1Xp3AygQ+3fyvZLk+hWULm4JiOUkAzdu1gdfmknHK+4H
         fCjPCwY3c0ERaup+kZBPmL2IkOQIhONzglxUbLRxttQlDpisv4Bpz+b8Y0Pga8sspBS6
         L4VE0bwEmVm0tvmCRo6EFJvMSEnryQu0ZVOtO+XMgTqAXJPmMVaLQUWwve+7LBGsk6/G
         18T+p4TNY81kloG+X0D4oMqJYcu2N1CjvOQtSF41Ve/nwEvQ9K1YBtkedffaTIEssfGf
         V++oqhhklgHdPytMZyvL9cRi3qRGlscJ5rccUFx/1k1oyyMArSK2QPRPI5JMyt0mNptP
         epMQ==
X-Gm-Message-State: ABy/qLZPehPPsi+IV+RbTJ5M/EP3oCQSL47HJ9CLG3vFwBCgfe7ZbjjD
	GS2vbF4iGN8A/3dXaBEiwA7tBFLM5x/cZog2nE0Jmw==
X-Google-Smtp-Source: APBJJlExEXqLa8UEpWrQYHCqv/gzNXRHBxOQ8U9xtaltnB0eJW5sPhS4xtJfP9wHxd67ryeGaTchXQ==
X-Received: by 2002:a17:907:b0c:b0:997:d627:263a with SMTP id h12-20020a1709070b0c00b00997d627263amr2370075ejl.67.1690899559071;
        Tue, 01 Aug 2023 07:19:19 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b009937dbabbdasm7690064ejs.217.2023.08.01.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:18 -0700 (PDT)
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
Subject: [patch net-next 6/8] devlink: rename couple of doit netlink callbacks to match generated names
Date: Tue,  1 Aug 2023 16:19:05 +0200
Message-ID: <20230801141907.816280-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
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


