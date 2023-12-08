Return-Path: <netdev+bounces-55417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D980AD04
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319221C20D4B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2EB4CB4E;
	Fri,  8 Dec 2023 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mB+PFcnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277281712
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c664652339so1903452a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063764; x=1702668564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HmpdmpOzS9YE2nfKm05Yn+Grb6i0nlVwnqk8LBWeCw=;
        b=mB+PFcnD01cT9Sha0No5EI+6fKL9jtRH/2v8H0DW7zPJK0Xkto/vC8JTZmKKBXVKBp
         VxT5hZBvywZdU0WCJiPVDgwr5gJslJnjrBzZD5k50AU9+bpaxLb0456fj8Kj7tCORCgs
         HKbBfkkn8kfpAw6Z9B2CZpeTp+X2hWc/MOw43zWp/R3aT+IH/85M9iJjbGhyUzyXs24I
         0Zw8hCCDW7tgOrb4pys2yhxOoXQX0l1rX+K32LkhqBw/IC5e6LAapc8t6LKbEJJlxPdl
         zFx7qu45jh/VF7yW4MMoZmJ6bafKJL7sJPr7aQsGrklJZClhh14YI2wK3RfCGWndlhyN
         Ro6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063764; x=1702668564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HmpdmpOzS9YE2nfKm05Yn+Grb6i0nlVwnqk8LBWeCw=;
        b=FadwEjEvPPqxqdgQC2cEPEr7xV8hcEjjDCMAi8gpgCHQtOnqVvp1L3I8IfUxkuE981
         MlwCtAX+UKxucU0Oee+SF0mYsuJpyQfv44KgO5rFKuNaC0oIuCxohY6jt0FH8JWHmk/d
         kcohq0O3ccItsz/1Ra7GEvtL7cxJV3fOcaJVoK1Zyt3zrMiHWoGFeYrE5D0atood2Kza
         h47O5zlaFtcKuksi1Pmo+LVs5TL3Je/wYxE7ohO9cmUmZEz7digKqV8IgNbbmeEWD00o
         DoJiDt28K51nYGbvRv+pmk1Zlsj4JjibrinuOJV9S1eKkEsN7/SVqJqXDFk+os2uhMwH
         DfpQ==
X-Gm-Message-State: AOJu0YwrAJ0rO2qFCq66C6U3TBBStVYW6u3k42RAqhwiQRxkFmibmnmU
	1ATWUkKgpA88bWz+Qb6O3msDkWu9VPgd1LG7HEs=
X-Google-Smtp-Source: AGHT+IH8c+2DK8mCydUTNL01Qgv7kDVtX6L1i4+gB1C1GRtq048wwwrG7R460Foe1umsMX7FA8pR1w==
X-Received: by 2002:a05:6a20:748f:b0:18f:ea5b:6830 with SMTP id p15-20020a056a20748f00b0018fea5b6830mr624110pzd.40.1702063764532;
        Fri, 08 Dec 2023 11:29:24 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:24 -0800 (PST)
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
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v4 5/7] net/sched: act_api: conditional notification of events
Date: Fri,  8 Dec 2023 16:28:45 -0300
Message-Id: <20231208192847.714940-6-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208192847.714940-1-pctammela@mojatatu.com>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
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
 net/sched/act_api.c | 98 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 4f295ae4e152..6611f292b6cb 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1785,30 +1785,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
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
 
 	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
 	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
 		kfree_skb(skb);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+	}
+
+	return skb;
+}
+
+static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
+{
+	const struct tc_action_ops *ops = action->ops;
+	struct sk_buff *skb;
+	int ret;
+
+	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
+		skb = NULL;
+	} else {
+		skb = tcf_reoffload_del_notify_msg(net, action);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
 	}
 
 	ret = tcf_idr_release_unsafe(action);
 	if (ret == ACT_P_DELETED) {
 		module_put(ops->owner);
-		ret = rtnetlink_send(skb, net, 0, RTNLGRP_TC, 0);
+		ret = rtnetlink_maybe_send(skb, net, 0, RTNLGRP_TC, 0);
 	} else {
 		kfree_skb(skb);
 	}
@@ -1874,22 +1889,41 @@ int tcf_action_reoffload_cb(flow_indr_block_bind_cb_t *cb,
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
 
 	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
 			 0, 2, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
 		kfree_skb(skb);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+	}
+
+	return skb;
+}
+
+static int tcf_del_notify(struct net *net, struct nlmsghdr *n,
+			  struct tc_action *actions[], u32 portid,
+			  size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+	int ret;
+
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC)) {
+		skb = NULL;
+	} else {
+		skb = tcf_del_notify_msg(net, n, actions, portid, attr_size,
+					 extack);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
 	}
 
 	/* now do the delete */
@@ -1900,9 +1934,8 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return ret;
 	}
 
-	ret = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-			     n->nlmsg_flags & NLM_F_ECHO);
-	return ret;
+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
+				    n->nlmsg_flags & NLM_F_ECHO);
 }
 
 static int
@@ -1953,25 +1986,44 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
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
 
 	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
 			 RTM_NEWACTION, 0, 0, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+	}
+
+	return skb;
+}
+
+static int tcf_add_notify(struct net *net, struct nlmsghdr *n,
+			  struct tc_action *actions[], u32 portid,
+			  size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC)) {
+		skb = NULL;
+	} else {
+		skb = tcf_add_notify_msg(net, n, actions, portid, attr_size,
+					 extack);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
 	}
 
-	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-			      n->nlmsg_flags & NLM_F_ECHO);
+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
+				    n->nlmsg_flags & NLM_F_ECHO);
 }
 
 static int tcf_action_add(struct net *net, struct nlattr *nla,
-- 
2.40.1


