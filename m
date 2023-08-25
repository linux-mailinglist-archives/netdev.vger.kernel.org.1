Return-Path: <netdev+bounces-30591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA67882B1
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7B51C20FA7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FAC8C9;
	Fri, 25 Aug 2023 08:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64EC8C1
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:37 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11411BF6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c615eb6feso514428f8f.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953611; x=1693558411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk19pK8PzRc6qfuUGtnvhrC2o4zFqvct0qzn4ZXCvwc=;
        b=u06x4jruZ+3wDJUHzWTh5aUD6JQ13INSWlsLpci+O0oLfgDBQmQ+uyBb58IOTVHOJr
         DaSFKZo0Hm9BIg1GPLXmwGEh2uTtzPPNrBjNLukrFLCSzXyXpIaafx1Vr7CGYhJv07VI
         ih+OPUGjC6dIpZ8BIL+bDpeZ/kZ+fZqJzkkdKOI7gCE0eQj+F0+yDC5qvDGcc6EhAdVk
         QIUTkXdmhgdXgospufNE6DVBqDNQ1QxV69pK75LJoqhEw2FfUni6buE6YtMFUg/KYQR7
         HfOVMLCplitFenGRt30FO+V1uIVHiZMbtrvGbAmm31F2wwOG8T/dw4R/x37zpElCAWAV
         5GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953611; x=1693558411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk19pK8PzRc6qfuUGtnvhrC2o4zFqvct0qzn4ZXCvwc=;
        b=NkHUpNrayMGImck6sXPdfUjzyrohJGU9HuEvoaELnIS2sw46QH+oLWzYTCZURH4s/w
         U6tC9H9MvB6BdPUSqxy3kxi4B9jGlh2F6v0RKlXdKwLiycRxfiyzPYRVspTMlUbmooRQ
         3hffZNIIutmvJRvSu4TUYAJC6jaz966cGsolbOqGTKSk6r1W/NLwIzMZIZPqi9JdFt9A
         QNxekntR4wXjqA21Z42h+LDACG+JhmBLHeZV6jWPEoe3apjOWW6k6VUto4vkNDQ8y/2B
         rDZPPlr+ash0a5N9GCl60AOZeb1Tmip9qbDAzbiU6FWDJxhs2B71GaOehG7Kw6UBaTqt
         e+6A==
X-Gm-Message-State: AOJu0YzyGfiyM+kbOd6eN0PnvritkBULWU3UYeAl7+RwqXavfU545buq
	7JZjdfcjzvfpDrhgqGg17FxphubkgRTf24m7SVvKgm7S
X-Google-Smtp-Source: AGHT+IGrjKbE/p9aVxhks0h2yedXoqQzsYqqUj63WS8ZQyo3MFAQz22u7iYDLhCAlByVZkvp3WXPew==
X-Received: by 2002:a5d:46cd:0:b0:317:5c36:913b with SMTP id g13-20020a5d46cd000000b003175c36913bmr13252761wrs.48.1692953610833;
        Fri, 25 Aug 2023 01:53:30 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d6589000000b00317b0155502sm1606998wru.8.2023.08.25.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 04/15] devlink: move and rename devlink_dpipe_send_and_alloc_skb() helper
Date: Fri, 25 Aug 2023 10:53:10 +0200
Message-ID: <20230825085321.178134-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
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

Since both dpipe and resource code is using this helper, in preparation
for code split to separate files, move
devlink_dpipe_send_and_alloc_skb() helper into netlink.c. Rename it on
the way.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  2 ++
 net/devlink/leftover.c      | 34 +++++++++-------------------------
 net/devlink/netlink.c       | 15 +++++++++++++++
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e1a6b7a763b8..66c94957e96c 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -150,6 +150,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 	return 0;
 }
 
+int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
+
 /* Notify */
 void devlink_notify(struct devlink *devlink, enum devlink_command cmd);
 void devlink_ports_notify_register(struct devlink *devlink);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 795bfdd41103..1bcd4192099e 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1277,22 +1277,6 @@ static int devlink_dpipe_table_put(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int devlink_dpipe_send_and_alloc_skb(struct sk_buff **pskb,
-					    struct genl_info *info)
-{
-	int err;
-
-	if (*pskb) {
-		err = genlmsg_reply(*pskb, info);
-		if (err)
-			return err;
-	}
-	*pskb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!*pskb)
-		return -ENOMEM;
-	return 0;
-}
-
 static int devlink_dpipe_tables_fill(struct genl_info *info,
 				     enum devlink_command cmd, int flags,
 				     struct list_head *dpipe_tables,
@@ -1311,7 +1295,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 	table = list_first_entry(dpipe_tables,
 				 struct devlink_dpipe_table, list);
 start_again:
-	err = devlink_dpipe_send_and_alloc_skb(&skb, info);
+	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
 		return err;
 
@@ -1358,7 +1342,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 	nlh = nlmsg_put(skb, info->snd_portid, info->snd_seq,
 			NLMSG_DONE, 0, flags | NLM_F_MULTI);
 	if (!nlh) {
-		err = devlink_dpipe_send_and_alloc_skb(&skb, info);
+		err = devlink_nl_msg_reply_and_new(&skb, info);
 		if (err)
 			return err;
 		goto send_done;
@@ -1551,8 +1535,8 @@ int devlink_dpipe_entry_ctx_prepare(struct devlink_dpipe_dump_ctx *dump_ctx)
 	struct devlink *devlink;
 	int err;
 
-	err = devlink_dpipe_send_and_alloc_skb(&dump_ctx->skb,
-					       dump_ctx->info);
+	err = devlink_nl_msg_reply_and_new(&dump_ctx->skb,
+					   dump_ctx->info);
 	if (err)
 		return err;
 
@@ -1638,7 +1622,7 @@ static int devlink_dpipe_entries_fill(struct genl_info *info,
 	nlh = nlmsg_put(dump_ctx.skb, info->snd_portid, info->snd_seq,
 			NLMSG_DONE, 0, flags | NLM_F_MULTI);
 	if (!nlh) {
-		err = devlink_dpipe_send_and_alloc_skb(&dump_ctx.skb, info);
+		err = devlink_nl_msg_reply_and_new(&dump_ctx.skb, info);
 		if (err)
 			return err;
 		goto send_done;
@@ -1746,7 +1730,7 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 
 	i = 0;
 start_again:
-	err = devlink_dpipe_send_and_alloc_skb(&skb, info);
+	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
 		return err;
 
@@ -1782,7 +1766,7 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 	nlh = nlmsg_put(skb, info->snd_portid, info->snd_seq,
 			NLMSG_DONE, 0, flags | NLM_F_MULTI);
 	if (!nlh) {
-		err = devlink_dpipe_send_and_alloc_skb(&skb, info);
+		err = devlink_nl_msg_reply_and_new(&skb, info);
 		if (err)
 			return err;
 		goto send_done;
@@ -2047,7 +2031,7 @@ static int devlink_resource_fill(struct genl_info *info,
 	resource = list_first_entry(&devlink->resource_list,
 				    struct devlink_resource, list);
 start_again:
-	err = devlink_dpipe_send_and_alloc_skb(&skb, info);
+	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
 		return err;
 
@@ -2086,7 +2070,7 @@ static int devlink_resource_fill(struct genl_info *info,
 	nlh = nlmsg_put(skb, info->snd_portid, info->snd_seq,
 			NLMSG_DONE, 0, flags | NLM_F_MULTI);
 	if (!nlh) {
-		err = devlink_dpipe_send_and_alloc_skb(&skb, info);
+		err = devlink_nl_msg_reply_and_new(&skb, info);
 		if (err)
 			return err;
 		goto send_done;
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 72a5005a64cd..5f57afd31dea 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -82,6 +82,21 @@ static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_REGION_DIRECT] = { .type = NLA_FLAG },
 };
 
+int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
+{
+	int err;
+
+	if (*msg) {
+		err = genlmsg_reply(*msg, info);
+		if (err)
+			return err;
+	}
+	*msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!*msg)
+		return -ENOMEM;
+	return 0;
+}
+
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 {
-- 
2.41.0


