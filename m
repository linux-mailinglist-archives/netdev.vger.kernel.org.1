Return-Path: <netdev+bounces-23986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBE76E694
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60CB2810FF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE11ED44;
	Thu,  3 Aug 2023 11:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9E1DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:56 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86E10E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso112960466b.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061234; x=1691666034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDifvWqsoPhrv8/SIuKiKT64B/wL4sV2rAC12AosVps=;
        b=JaXENHHI3DaVE61M7jXtZ8AcMaUuqDB3F76Y3HH6+RO7Ele+0sSJl8sColGFKypMjo
         NQMDM/5JViGSoJAWKpQPCYO5MwQAceUZ9ljWKQ/JFL1dUcCLcuOVUd14xh3z59W1bDTG
         DIkXNfdQdCcTGyKJyaZIZnAesfyztblFY2DsbBgRf4kCYzLnApORCBPqTwqNKPYTiD1p
         4xnmuPz4Sprfid4hsmrAi2QGYGg9/pWnWXGevAs8PHnDcfvVuKd+GT3vpIdygN7k5Wye
         uoAS2B/ygxG42fQIXT9IJx/H1jzaT7/zYc+ETz4e5a7s3t+YcEplDF0qOM4R1oHbdzjN
         8nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061234; x=1691666034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDifvWqsoPhrv8/SIuKiKT64B/wL4sV2rAC12AosVps=;
        b=boGDETOr6vim/QZBch/Ln3tla0pt7v2UIQ5XXlqPSc1bBLYcpN3TMFaQO1jD0QgZyM
         E7X3NAsxDlUJ8jONVxKg6xCVKyYE6Myjp9CcxGo49SuyO/X1xTX4A+vOglgDXEZkEejt
         ZoFMMd8ci6gZAweA9qmfEYdXlrUkqZy1kvhC5YqDcCVGDpXEeXAEA0PQKy2zN0LrysyB
         UUx2z8QOWi0nzEzO+/0Y3o/wEfVmwEe2Q5KgupomlIigh7e77rEn7OY17nnpPSDmi9Go
         /R7b+6XZ2bmGbbqZg0/596eJ7I3ENC5UXWlicgyW/hEZqvPDW4Gvtz2f6cknKtIxGUaY
         6RcA==
X-Gm-Message-State: ABy/qLZETTDEZKInRoMRGvI7djgukXAi3CEvOURIn8xvoQDuY09jhql7
	6ltOAOMZ1j21iATTgXUIIRNCxUikTkH7EPYVEipcxQ==
X-Google-Smtp-Source: APBJJlF9MYgYhIoDkb+uV5COebkBbNjtWQLBkRa5lXyRch4iwBiTt+0L69wRSv1B4fcRaOL3MvFG6A==
X-Received: by 2002:a17:906:3005:b0:993:dcca:9607 with SMTP id 5-20020a170906300500b00993dcca9607mr7296921ejz.2.1691061234148;
        Thu, 03 Aug 2023 04:13:54 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090607ca00b009931a3adf64sm10587342ejc.17.2023.08.03.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:53 -0700 (PDT)
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
Subject: [patch net-next v3 08/12] devlink: un-static devlink_nl_pre/post_doit()
Date: Thu,  3 Aug 2023 13:13:36 +0200
Message-ID: <20230803111340.1074067-9-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

To be prepared for the follow-up generated split ops addition,
make the functions devlink_nl_pre_doit() and devlink_nl_post_doit()
usable outside of netlink.c. Introduce temporary prototypes which are
going to be removed once the generated header will be included.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch, split from "devlink: include the generated netlink header"
---
 net/devlink/devl_internal.h | 4 ++++
 net/devlink/netlink.c       | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7d0a9dd1aceb..0befa1869fde 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -216,6 +216,10 @@ struct devlink_rate *
 devlink_rate_node_get_from_info(struct devlink *devlink,
 				struct genl_info *info);
 /* Devlink nl cmds */
+int devlink_nl_pre_doit(const struct genl_split_ops *ops,
+			struct sk_buff *skb, struct genl_info *info);
+void devlink_nl_post_doit(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 624d0db7e229..98d5c6b0acd8 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -109,8 +109,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	return ERR_PTR(-ENODEV);
 }
 
-static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
-			       struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_pre_doit(const struct genl_split_ops *ops,
+			struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_linecard *linecard;
 	struct devlink_port *devlink_port;
@@ -167,8 +167,8 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 	return err;
 }
 
-static void devlink_nl_post_doit(const struct genl_split_ops *ops,
-				 struct sk_buff *skb, struct genl_info *info)
+void devlink_nl_post_doit(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink;
 
-- 
2.41.0


