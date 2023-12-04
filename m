Return-Path: <netdev+bounces-53646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272E3804037
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD1B1F21321
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5D30F8C;
	Mon,  4 Dec 2023 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="s88fGfv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5409199F
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:39:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0a7b72203so11601405ad.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701722391; x=1702327191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfPn3jUpd+FkBKVUlgJ5ullBszjYg7J/rYTarHELt38=;
        b=s88fGfv+lBUTraDN67ByI9lidHOY+BtG0FKFW9JVgOTOrcHjIRNL+4RcFTgAMMGmRm
         g6Chxy5nz1R/n8K7B36C+8ro91vxmOwbV3MXV/FYYA8HQEFjiZm16wA+A17mNBjjLWxh
         nSZtwYedvLe7T9QveokQeBHnPljYg/X2MlQ+Cowep0c1tbqIypX4du12OoQZ/MG+/3Zf
         Ku3T1qTXPEZvf4BXFF9oylEeOYN1GfMpxXE2BNlgo3AgekC+lpRujHt7MQ+Qd1YmBQSl
         ewOqrTB4XJQ12/Ttn9izH7E8bfyY7b6YVp1a2CyF+VKqMtZlIXZeEc7k1CMvvf1vvpFS
         b9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722391; x=1702327191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfPn3jUpd+FkBKVUlgJ5ullBszjYg7J/rYTarHELt38=;
        b=jGNVPYznQ0INWeoqV35JaMwL3WqWRp8SzRqUFoo9QBiFTLqER5qUeL3QMLuOjtqCvb
         +hdbzLXnJ9moKVLqMnQx9cRavMtsc7ttKhXoIBlR0rNH+Q06D1rp5Qqhopl2ryNBLPXF
         CIgruXPPDhTdAeLudSc12pg4VpbDya3l4J4yXunKbwMSM1dts66XXU3V5noccEiYpAsk
         akZtdXH8yNLfKG3fHZLJt+niG8bXS3WYzdcmz7AkJrUvT5VihIUAUyFiexmaaxYymxH2
         t2QvD8FXk02OVOcmIHfOPowJnr2v5SXc4OKjIfIZTv15CwPr7QupaJk4oOZK7z14eLgR
         Zlcg==
X-Gm-Message-State: AOJu0Yw/OOgRmO2lk8t8mn2/KxGULiF83uh+5wUQhz+aLmRpfWGZZs3W
	k0VIqY6Nl+f6R/YawqtQcJv1idTJ0Ty4Rz7P8Ek=
X-Google-Smtp-Source: AGHT+IFdoTl63x8XtkrDbFZ+oravMXurKycW6VizqKyDyPYv6sXwbwETuwerOKN4kyiE5724yDaCUg==
X-Received: by 2002:a17:902:ec8e:b0:1d0:98bf:f9ff with SMTP id x14-20020a170902ec8e00b001d098bff9ffmr3107298plg.117.1701722390850;
        Mon, 04 Dec 2023 12:39:50 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001cf83962743sm2669584plg.250.2023.12.04.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:39:50 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] net/sched: act_api: conditional notification of events
Date: Mon,  4 Dec 2023 17:39:06 -0300
Message-Id: <20231204203907.413435-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204203907.413435-1-pctammela@mojatatu.com>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today tc-action events are unconditionally built and sent to
RTNLGRP_TC. As with the introduction of tc_should_notify we can check
before-hand if they are really needed.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 105 ++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61ebb..55c62a8e8803 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1780,31 +1780,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
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
@@ -1870,25 +1884,42 @@ int tcf_action_reoffload_cb(flow_indr_block_bind_cb_t *cb,
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
@@ -1897,9 +1928,8 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return ret;
 	}
 
-	ret = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-			     n->nlmsg_flags & NLM_F_ECHO);
-	return ret;
+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
+				    n->nlmsg_flags & NLM_F_ECHO);
 }
 
 static int
@@ -1950,26 +1980,43 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
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


