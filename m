Return-Path: <netdev+bounces-26349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC8777962
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5641E282108
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95FF1FB36;
	Thu, 10 Aug 2023 13:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9B1E1C1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:54 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B310E9
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe490c05c9so11703855e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673351; x=1692278151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTTNtyVdQ54Vp2keCdE/XH3tw/qXv7u3Z2Jlwnps83E=;
        b=xdJ/tOjNS9RZ9m0xbbPvTkCLj5Pg2A+A5uN19jvkaniFo+Vqssr/xXSfBCw8DNxqvg
         d+KpyU03wFU2yH7XZpRncYIVTk1R7z9l1NXji7HZLqhaf+cLXMqgy9WyasGqWMeHBzGp
         OEqTEFtNC1mywQc+y6Y7lAaVaRSr5MW4n59/W+tFi2XFaV5Oq3h7HGp5MwQVV5ciQf8E
         YF7Fth4BP8SR8dxgTVN89sXtkF4xZN0m4okivgYQ+C5wpvQTKrBCGkFbZL4dUsSSEvlN
         1p/1QKRh7DXrugrWInjrM5HKKNMA4FissktrIHHbdWjdOvyoal3Zm5FDfd6/5yuNYBjo
         DFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673351; x=1692278151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTTNtyVdQ54Vp2keCdE/XH3tw/qXv7u3Z2Jlwnps83E=;
        b=VqNR9qo0NRVswAb1taUaqBhejy8tG/NJY+Nw5dbrL83S891umuD3UmAjBKK34MfA7S
         VtKISkhlh1nUH8ONotGNZa9XTBHiEeIVBT58S+M5hdi2AZapGZSXR45urLGRlBs8ql6V
         rbqvYJIkBh37FXhJSTYA3Y9SWaWd93umuji9hb+R32VwNPKHduhHnmsUPDx5UC1mJ5Vr
         BMbCnZn8nT8fA7OplEhMpYaskYOJMWpabRBZ/siH07JEY0Yd20y6/sViJkAW6MDa5CAr
         q5iuXJjaD04MUvZ4c0ieyxDyiJX92ka6JrtL8dT5AzFDcXYs0YMaKcGWmN6T8JO0jh9z
         nNAw==
X-Gm-Message-State: AOJu0YzivxZeEGMuArwnVM5w+WYekRhK+/8kLyLp9njfkjq3OC8fXQ7c
	DLuOfPXdwntPDmX6y5zeNcAX4K8670K2egrXdZg1yQ==
X-Google-Smtp-Source: AGHT+IFHf9wwVQbzzXB2jIPhesQ7otCSFUFn9AtpWFLvY72ZbXQ/lUQt1VP61qMzjdqMxioweokLvw==
X-Received: by 2002:adf:f384:0:b0:317:de66:259b with SMTP id m4-20020adff384000000b00317de66259bmr1791965wro.15.1691673351376;
        Thu, 10 Aug 2023 06:15:51 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fe1fe56202sm2142556wmd.33.2023.08.10.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:50 -0700 (PDT)
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
Subject: [patch net-next v3 06/13] devlink: pass flags as an arg of dump_one() callback
Date: Thu, 10 Aug 2023 15:15:32 +0200
Message-ID: <20230810131539.1602299-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810131539.1602299-1-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In order to easily set NLM_F_DUMP_FILTERED for partial dumps, pass the
flags as an arg of dump_one() callback. Currently, it is always
NLM_F_MULTI.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/dev.c           | 13 +++---
 net/devlink/devl_internal.h |  3 +-
 net/devlink/health.c        |  7 +--
 net/devlink/leftover.c      | 87 ++++++++++++++++++-------------------
 net/devlink/netlink.c       |  2 +-
 5 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 22e8ab3eaaa2..abf3393a7a17 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -218,11 +218,11 @@ int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			struct netlink_callback *cb)
+			struct netlink_callback *cb, int flags)
 {
 	return devlink_nl_fill(msg, devlink, DEVLINK_CMD_NEW,
 			       NETLINK_CB(cb->skb).portid,
-			       cb->nlh->nlmsg_seq, NLM_F_MULTI);
+			       cb->nlh->nlmsg_seq, flags);
 }
 
 int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
@@ -828,13 +828,13 @@ int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb, int flags)
 {
 	int err;
 
 	err = devlink_nl_info_fill(msg, devlink, DEVLINK_CMD_INFO_GET,
 				   NETLINK_CB(cb->skb).portid,
-				   cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				   cb->nlh->nlmsg_seq, flags,
 				   cb->extack);
 	if (err == -EOPNOTSUPP)
 		err = 0;
@@ -1231,14 +1231,15 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_selftests_get_dump_one(struct sk_buff *msg,
 					     struct devlink *devlink,
-					     struct netlink_callback *cb)
+					     struct netlink_callback *cb,
+					     int flags)
 {
 	if (!devlink->ops->selftest_check)
 		return 0;
 
 	return devlink_nl_selftests_fill(msg, devlink,
 					 NETLINK_CB(cb->skb).portid,
-					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					 cb->nlh->nlmsg_seq, flags,
 					 cb->extack);
 }
 
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 500c91c61b2d..f8af6ffdbb3a 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -115,7 +115,8 @@ struct devlink_nl_dump_state {
 
 typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       struct devlink *devlink,
-				       struct netlink_callback *cb);
+				       struct netlink_callback *cb,
+				       int flags);
 
 extern const struct genl_small_ops devlink_nl_small_ops[54];
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index dbe2d6a1df3b..b9b3e68d9043 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -386,7 +386,8 @@ int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
 
 static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 						   struct devlink *devlink,
-						   struct netlink_callback *cb)
+						   struct netlink_callback *cb,
+						   int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
@@ -404,7 +405,7 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 						      DEVLINK_CMD_HEALTH_REPORTER_GET,
 						      NETLINK_CB(cb->skb).portid,
 						      cb->nlh->nlmsg_seq,
-						      NLM_F_MULTI);
+						      flags);
 		if (err) {
 			state->idx = idx;
 			return err;
@@ -421,7 +422,7 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 							      DEVLINK_CMD_HEALTH_REPORTER_GET,
 							      NETLINK_CB(cb->skb).portid,
 							      cb->nlh->nlmsg_seq,
-							      NLM_F_MULTI);
+							      flags);
 			if (err) {
 				state->idx = idx;
 				return err;
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 21f1058ef14d..883c65545d26 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1006,7 +1006,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 static int
 devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_rate *devlink_rate;
@@ -1022,8 +1022,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			continue;
 		}
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
-					   cb->nlh->nlmsg_seq,
-					   NLM_F_MULTI, NULL);
+					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -1100,7 +1099,7 @@ int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_port *devlink_port;
@@ -1111,8 +1110,8 @@ devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		err = devlink_nl_port_fill(msg, devlink_port,
 					   DEVLINK_CMD_NEW,
 					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq,
-					   NLM_F_MULTI, cb->extack);
+					   cb->nlh->nlmsg_seq, flags,
+					   cb->extack);
 		if (err) {
 			state->idx = port_index;
 			break;
@@ -1856,7 +1855,8 @@ int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
 					    struct devlink *devlink,
-					    struct netlink_callback *cb)
+					    struct netlink_callback *cb,
+					    int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_linecard *linecard;
@@ -1872,8 +1872,7 @@ static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_linecard_fill(msg, devlink, linecard,
 					       DEVLINK_CMD_LINECARD_NEW,
 					       NETLINK_CB(cb->skb).portid,
-					       cb->nlh->nlmsg_seq,
-					       NLM_F_MULTI,
+					       cb->nlh->nlmsg_seq, flags,
 					       cb->extack);
 		mutex_unlock(&linecard->state_lock);
 		if (err) {
@@ -2120,7 +2119,7 @@ int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			   struct netlink_callback *cb)
+			   struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2135,8 +2134,7 @@ devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		err = devlink_nl_sb_fill(msg, devlink, devlink_sb,
 					 DEVLINK_CMD_SB_NEW,
 					 NETLINK_CB(cb->skb).portid,
-					 cb->nlh->nlmsg_seq,
-					 NLM_F_MULTI);
+					 cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -2233,7 +2231,7 @@ int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 				struct devlink *devlink,
 				struct devlink_sb *devlink_sb,
-				u32 portid, u32 seq)
+				u32 portid, u32 seq, int flags)
 {
 	u16 pool_count = devlink_sb_pool_count(devlink_sb);
 	u16 pool_index;
@@ -2248,7 +2246,7 @@ static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 					      devlink_sb,
 					      pool_index,
 					      DEVLINK_CMD_SB_POOL_NEW,
-					      portid, seq, NLM_F_MULTI);
+					      portid, seq, flags);
 		if (err)
 			return err;
 		(*p_idx)++;
@@ -2258,7 +2256,7 @@ static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 
 static int
 devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				struct netlink_callback *cb)
+				struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2272,7 +2270,7 @@ devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		err = __sb_pool_get_dumpit(msg, state->idx, &idx,
 					   devlink, devlink_sb,
 					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq);
+					   cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -2436,7 +2434,7 @@ int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
 static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 				     struct devlink *devlink,
 				     struct devlink_sb *devlink_sb,
-				     u32 portid, u32 seq)
+				     u32 portid, u32 seq, int flags)
 {
 	struct devlink_port *devlink_port;
 	u16 pool_count = devlink_sb_pool_count(devlink_sb);
@@ -2455,8 +2453,7 @@ static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 							   devlink_sb,
 							   pool_index,
 							   DEVLINK_CMD_SB_PORT_POOL_NEW,
-							   portid, seq,
-							   NLM_F_MULTI);
+							   portid, seq, flags);
 			if (err)
 				return err;
 			(*p_idx)++;
@@ -2468,7 +2465,7 @@ static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 static int
 devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
 				     struct devlink *devlink,
-				     struct netlink_callback *cb)
+				     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2482,7 +2479,7 @@ devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
 		err = __sb_port_pool_get_dumpit(msg, state->idx, &idx,
 						devlink, devlink_sb,
 						NETLINK_CB(cb->skb).portid,
-						cb->nlh->nlmsg_seq);
+						cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -2654,7 +2651,7 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 					int start, int *p_idx,
 					struct devlink *devlink,
 					struct devlink_sb *devlink_sb,
-					u32 portid, u32 seq)
+					u32 portid, u32 seq, int flags)
 {
 	struct devlink_port *devlink_port;
 	unsigned long port_index;
@@ -2675,7 +2672,7 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 							      DEVLINK_SB_POOL_TYPE_INGRESS,
 							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
 							      portid, seq,
-							      NLM_F_MULTI);
+							      flags);
 			if (err)
 				return err;
 			(*p_idx)++;
@@ -2693,7 +2690,7 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 							      DEVLINK_SB_POOL_TYPE_EGRESS,
 							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
 							      portid, seq,
-							      NLM_F_MULTI);
+							      flags);
 			if (err)
 				return err;
 			(*p_idx)++;
@@ -2704,7 +2701,8 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 
 static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
 						   struct devlink *devlink,
-						   struct netlink_callback *cb)
+						   struct netlink_callback *cb,
+						   int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2718,7 +2716,7 @@ static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
 		err = __sb_tc_pool_bind_get_dumpit(msg, state->idx, &idx,
 						   devlink, devlink_sb,
 						   NETLINK_CB(cb->skb).portid,
-						   cb->nlh->nlmsg_seq);
+						   cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -4185,7 +4183,8 @@ static void devlink_param_notify(struct devlink *devlink,
 
 static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 					 struct devlink *devlink,
-					 struct netlink_callback *cb)
+					 struct netlink_callback *cb,
+					 int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_param_item *param_item;
@@ -4196,8 +4195,7 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq,
-					    NLM_F_MULTI);
+					    cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -4848,8 +4846,7 @@ int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info)
 static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 						 struct netlink_callback *cb,
 						 struct devlink_port *port,
-						 int *idx,
-						 int start)
+						 int *idx, int start, int flags)
 {
 	struct devlink_region *region;
 	int err = 0;
@@ -4863,7 +4860,7 @@ static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 					     DEVLINK_CMD_REGION_GET,
 					     NETLINK_CB(cb->skb).portid,
 					     cb->nlh->nlmsg_seq,
-					     NLM_F_MULTI, region);
+					     flags, region);
 		if (err)
 			goto out;
 		(*idx)++;
@@ -4875,7 +4872,8 @@ static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 
 static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
 					  struct devlink *devlink,
-					  struct netlink_callback *cb)
+					  struct netlink_callback *cb,
+					  int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_region *region;
@@ -4892,8 +4890,8 @@ static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_region_fill(msg, devlink,
 					     DEVLINK_CMD_REGION_GET,
 					     NETLINK_CB(cb->skb).portid,
-					     cb->nlh->nlmsg_seq,
-					     NLM_F_MULTI, region);
+					     cb->nlh->nlmsg_seq, flags,
+					     region);
 		if (err) {
 			state->idx = idx;
 			return err;
@@ -4903,7 +4901,7 @@ static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
 
 	xa_for_each(&devlink->ports, port_index, port) {
 		err = devlink_nl_cmd_region_get_port_dumpit(msg, cb, port, &idx,
-							    state->idx);
+							    state->idx, flags);
 		if (err) {
 			state->idx = idx;
 			return err;
@@ -5699,7 +5697,7 @@ int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
 					struct devlink *devlink,
-					struct netlink_callback *cb)
+					struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_item *trap_item;
@@ -5714,8 +5712,7 @@ static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_trap_fill(msg, devlink, trap_item,
 					   DEVLINK_CMD_TRAP_NEW,
 					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq,
-					   NLM_F_MULTI);
+					   cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -5910,7 +5907,8 @@ int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
 					      struct devlink *devlink,
-					      struct netlink_callback *cb)
+					      struct netlink_callback *cb,
+					      int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_group_item *group_item;
@@ -5926,8 +5924,7 @@ static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_trap_group_fill(msg, devlink, group_item,
 						 DEVLINK_CMD_TRAP_GROUP_NEW,
 						 NETLINK_CB(cb->skb).portid,
-						 cb->nlh->nlmsg_seq,
-						 NLM_F_MULTI);
+						 cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -6205,7 +6202,8 @@ int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
 
 static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
 						struct devlink *devlink,
-						struct netlink_callback *cb)
+						struct netlink_callback *cb,
+						int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_policer_item *policer_item;
@@ -6220,8 +6218,7 @@ static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_trap_policer_fill(msg, devlink, policer_item,
 						   DEVLINK_CMD_TRAP_POLICER_NEW,
 						   NETLINK_CB(cb->skb).portid,
-						   cb->nlh->nlmsg_seq,
-						   NLM_F_MULTI);
+						   cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 13388665f319..47e44fb45815 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -182,7 +182,7 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		devl_lock(devlink);
 
 		if (devl_is_registered(devlink))
-			err = dump_one(msg, devlink, cb);
+			err = dump_one(msg, devlink, cb, NLM_F_MULTI);
 		else
 			err = 0;
 
-- 
2.41.0


