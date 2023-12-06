Return-Path: <netdev+bounces-54513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8180758E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2011F2164F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412E3FE3B;
	Wed,  6 Dec 2023 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WRJaLj7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684DB2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:44:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d04c097e34so192255ad.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701881095; x=1702485895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9UQsQtqVfjzD1Fk+nJ3moPqgMdm4wuaaVHtwNrfaOA=;
        b=WRJaLj7VXymbXxGiiLtlS3Vq2+8O98sIuRDV3uDhfiK0jWqo2RFTPhwjQi/nZXrPwK
         DY4BMfxo5joDiRfYKwPNI0BCjXFVJVABy8Vsy86SS2I+NaVcZHWPKaWz9v9iQANHhQWs
         Qz9GHhD9pvX+uweSgf8nGuTXK0MJqKR0BkqydfIuVMhlODQd4qLjXPYmk+ArNBxcz3WK
         evbE3fFt8JaaC5iZs02lK+tkQg4Dg93lrF1mSosFHGNf/ZJsOYLkf0PC7CuUi0G4Bfo4
         97LS8MRWbxvM8NadSkBQ+tkJtXrFg2kMFTMgfwZkU36MgyONWkynWQgG1EgiFUiuzJ23
         L5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881095; x=1702485895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9UQsQtqVfjzD1Fk+nJ3moPqgMdm4wuaaVHtwNrfaOA=;
        b=L5lUtG6zWa+qTZgtfS62rImd1hviUTJSIFU4iApXYbPw7KOi7joPe6+y2xKm06HAg2
         t+jHr44AiEipIgBIKfHtB6IHPIHEsSSskEtvUZvzNXpP1K/wGlVgxlnVKb9IUgYvmLpI
         AnDHI54c48LDR6HkSZj5qlLxejjUE8RRbqNVVd3mq/Rlff8J/rVuBZo1i22OJNhDqNWN
         K8xSFoFZHL8EIWTseeZyHg119LBXp567+RTBaM8uZ3Tr5IuRpw1fRZcmgcV/1tozbOZQ
         HwDuyjs+6XHaJE2dNG6Jbt7P08Bl2L3anSX5Wlr+SHscv5CXKkIOrvlx11wNTgNRYLdf
         0VVw==
X-Gm-Message-State: AOJu0YwvCEBXi209CZHl6QzbxI5LFW9T/M1bPTeHW22UzWtGlwgA423C
	grQV51SK6fY4w/ciAcgKQkwwB2tDvaTZfvFZ7R0=
X-Google-Smtp-Source: AGHT+IHaoMM7ydm71e3XNrRvikFKgDcIqvzNcmPAmC4YeKEqI3xZsJPCgi5M1ZecgUyXP8+6l4+ccw==
X-Received: by 2002:a17:903:200d:b0:1d0:700b:3f71 with SMTP id s13-20020a170903200d00b001d0700b3f71mr3686958pla.43.1701881094981;
        Wed, 06 Dec 2023 08:44:54 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001cfc3f73920sm36719pll.227.2023.12.06.08.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:44:54 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 4/5] net/sched: act_api: conditional notification of events
Date: Wed,  6 Dec 2023 13:44:15 -0300
Message-Id: <20231206164416.543503-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206164416.543503-1-pctammela@mojatatu.com>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today tc-action events are unconditionally built and sent to
RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
before-hand if they are really needed.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 105 ++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index abec5c45b5a4..c15c2083ac84 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1785,31 +1785,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
 	return 0;
 }
 
-static int
-tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
+static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
+						    struct tc_action *action)
 {
 	size_t attr_size = tcf_action_fill_size(action);
 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
 		[0] = action,
 	};
-	const struct tc_action_ops *ops = action->ops;
 	struct sk_buff *skb;
-	int ret;
 
-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
-			GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
 	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
 		kfree_skb(skb);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
+	return skb;
+}
+
+static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
+{
+	const struct tc_action_ops *ops = action->ops;
+	struct sk_buff *skb = NULL;
+	int ret;
+
+	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC))
+		goto skip_msg;
+
+	skb = tcf_reoffload_del_notify_msg(net, action);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+skip_msg:
 	ret = tcf_idr_release_unsafe(action);
 	if (ret == ACT_P_DELETED) {
 		module_put(ops->owner);
-		ret = rtnetlink_send(skb, net, 0, RTNLGRP_TC, 0);
+		ret = rtnetlink_maybe_send(skb, net, 0, RTNLGRP_TC, 0);
 	} else {
 		kfree_skb(skb);
 	}
@@ -1875,25 +1889,42 @@ int tcf_action_reoffload_cb(flow_indr_block_bind_cb_t *cb,
 	return 0;
 }
 
-static int
-tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
-	       u32 portid, size_t attr_size, struct netlink_ext_ack *extack)
+static struct sk_buff *tcf_del_notify_msg(struct net *net, struct nlmsghdr *n,
+					  struct tc_action *actions[],
+					  u32 portid, size_t attr_size,
+					  struct netlink_ext_ack *extack)
 {
-	int ret;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
-			GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
 			 0, 2, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
 		kfree_skb(skb);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
+	return skb;
+}
+
+static int tcf_del_notify(struct net *net, struct nlmsghdr *n,
+			  struct tc_action *actions[], u32 portid,
+			  size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb = NULL;
+	int ret;
+
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		goto skip_msg;
+
+	skb = tcf_del_notify_msg(net, n, actions, portid, attr_size, extack);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+skip_msg:
 	/* now do the delete */
 	ret = tcf_action_delete(net, actions);
 	if (ret < 0) {
@@ -1902,9 +1933,8 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return ret;
 	}
 
-	ret = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-			     n->nlmsg_flags & NLM_F_ECHO);
-	return ret;
+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
+				    n->nlmsg_flags & NLM_F_ECHO);
 }
 
 static int
@@ -1955,26 +1985,43 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 	return ret;
 }
 
-static int
-tcf_add_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
-	       u32 portid, size_t attr_size, struct netlink_ext_ack *extack)
+static struct sk_buff *tcf_add_notify_msg(struct net *net, struct nlmsghdr *n,
+					  struct tc_action *actions[],
+					  u32 portid, size_t attr_size,
+					  struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
-			GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
 			 RTM_NEWACTION, 0, 0, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-			      n->nlmsg_flags & NLM_F_ECHO);
+	return skb;
+}
+
+static int tcf_add_notify(struct net *net, struct nlmsghdr *n,
+			  struct tc_action *actions[], u32 portid,
+			  size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb = NULL;
+
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		goto skip_msg;
+
+	skb = tcf_add_notify_msg(net, n, actions, portid, attr_size, extack);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+skip_msg:
+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
+				    n->nlmsg_flags & NLM_F_ECHO);
 }
 
 static int tcf_action_add(struct net *net, struct nlattr *nla,
-- 
2.40.1


