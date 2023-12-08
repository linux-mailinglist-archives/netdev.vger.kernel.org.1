Return-Path: <netdev+bounces-55261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A380A046
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F921F217FA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26E134D5;
	Fri,  8 Dec 2023 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MGe16gOs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35C171F
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:09:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so2637775a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702030181; x=1702634981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7pkfm2u846CswhZbKMy6jP8JE4kLyiGbzsR8hflSVxo=;
        b=MGe16gOs6hutySH51peqNXszP5X0aiI9zu8Txy089Q6SehfWeECb75hqICGh7CHo1Y
         mwpzH5MLePncuiyTJiBrl/HS1aJNwH2Q+c6CJRCyDedzhIMc2A/spCj5JEPZrJA/CME/
         6+gXzL72O6IWu1KLgkMIyFF5/CTxGnzHtIiAR3mrnn+wk38oSEkq6erfzG1VG3C3rzV/
         ayERl3ateZi0PLuRhq4vreZMb1j70qt13FuDbHfeYp29r3MHCQ5qoz72BT/rOpW73Ki2
         h6kImPFOqxfQM6GH64icRWsHTl75AC9h/2hBYjkpPaR3vNtquMxsKHTGwQ86aCOXerwW
         V/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030181; x=1702634981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pkfm2u846CswhZbKMy6jP8JE4kLyiGbzsR8hflSVxo=;
        b=qxHNVaw1ZaTASW2gOU20ksL632gxVROoEvgZSUDRXAmovDW6oLb5Dhsfi0kCfSjYVf
         ql+jCtkdh+5VMbDurSfDKTidy/Z3gphDzNXyIHSS7iZjXSFCBUi0equ/fXIa0vASSIVC
         TkdzwTYSJFJNCUVOEYiU97yMrm0KW4Rt8b4q1eEUsE2SvSHr45QcPajitHbzamK9e6Ha
         ReaMqNqUOvPDKWqKSCdoHCHx3N1IoMYawzY5LgEe2l51nVI9MGlMjhDzAkvEOKy+qDaH
         upHPkinSXBHmAeQ/bN+Y0NFAqCU3n1cpD9My30VQwmkLj0n8frPxpLcWrHjeRzjHYDXG
         Zu8Q==
X-Gm-Message-State: AOJu0Yx5rYbUliktMdxINcYH7LIy7Oxd/KjDHTrTzu4aT78+T+EcGoZu
	MZaz3mYqVf0V7x5s9piJdduuxg==
X-Google-Smtp-Source: AGHT+IEHO4jpVyGt5oTDarFOUH6dRO/n2X1rmPG9gcpl06OCfnFqkSfiE8AUtpMX3wGrMQl7r2Qlig==
X-Received: by 2002:a17:906:4f:b0:a1b:6fbb:d28c with SMTP id 15-20020a170906004f00b00a1b6fbbd28cmr1199505ejg.295.1702030181032;
        Fri, 08 Dec 2023 02:09:41 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a0d672bfbb0sm812648ejc.142.2023.12.08.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:09:40 -0800 (PST)
Date: Fri, 8 Dec 2023 11:09:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com
Subject: Re: [PATCH net-next v3 4/5] net/sched: act_api: conditional
 notification of events
Message-ID: <ZXLrYwK/UCkq/OiC@nanopsycho>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164416.543503-5-pctammela@mojatatu.com>

Wed, Dec 06, 2023 at 05:44:15PM CET, pctammela@mojatatu.com wrote:
>As of today tc-action events are unconditionally built and sent to
>RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
>before-hand if they are really needed.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>---
> net/sched/act_api.c | 105 ++++++++++++++++++++++++++++++++------------
> 1 file changed, 76 insertions(+), 29 deletions(-)
>
>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>index abec5c45b5a4..c15c2083ac84 100644
>--- a/net/sched/act_api.c
>+++ b/net/sched/act_api.c
>@@ -1785,31 +1785,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
> 	return 0;
> }
> 
>-static int
>-tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>+static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
>+						    struct tc_action *action)
> {
> 	size_t attr_size = tcf_action_fill_size(action);
> 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
> 		[0] = action,
> 	};
>-	const struct tc_action_ops *ops = action->ops;
> 	struct sk_buff *skb;
>-	int ret;
> 
>-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>-			GFP_KERNEL);
>+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);

I don't follow. I think you promissed to have this unrelated change as a
separate patch, right? Could you? Unrelated to this patch.


> 	if (!skb)
>-		return -ENOBUFS;
>+		return ERR_PTR(-ENOBUFS);
> 
> 	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
> 		kfree_skb(skb);
>-		return -EINVAL;
>+		return ERR_PTR(-EINVAL);
> 	}
> 
>+	return skb;
>+}
>+
>+static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>+{
>+	const struct tc_action_ops *ops = action->ops;
>+	struct sk_buff *skb = NULL;
>+	int ret;
>+
>+	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC))
>+		goto skip_msg;
>+
>+	skb = tcf_reoffload_del_notify_msg(net, action);
>+	if (IS_ERR(skb))
>+		return PTR_ERR(skb);
>+
>+skip_msg:
> 	ret = tcf_idr_release_unsafe(action);
> 	if (ret == ACT_P_DELETED) {
> 		module_put(ops->owner);
>-		ret = rtnetlink_send(skb, net, 0, RTNLGRP_TC, 0);
>+		ret = rtnetlink_maybe_send(skb, net, 0, RTNLGRP_TC, 0);
> 	} else {
> 		kfree_skb(skb);
> 	}
>@@ -1875,25 +1889,42 @@ int tcf_action_reoffload_cb(flow_indr_block_bind_cb_t *cb,
> 	return 0;
> }
> 
>-static int
>-tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
>-	       u32 portid, size_t attr_size, struct netlink_ext_ack *extack)
>+static struct sk_buff *tcf_del_notify_msg(struct net *net, struct nlmsghdr *n,
>+					  struct tc_action *actions[],
>+					  u32 portid, size_t attr_size,
>+					  struct netlink_ext_ack *extack)
> {
>-	int ret;
> 	struct sk_buff *skb;
> 
>-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>-			GFP_KERNEL);
>+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
> 	if (!skb)
>-		return -ENOBUFS;
>+		return ERR_PTR(-ENOBUFS);
> 
> 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
> 			 0, 2, extack) <= 0) {
> 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
> 		kfree_skb(skb);
>-		return -EINVAL;
>+		return ERR_PTR(-EINVAL);
> 	}
> 
>+	return skb;
>+}
>+
>+static int tcf_del_notify(struct net *net, struct nlmsghdr *n,
>+			  struct tc_action *actions[], u32 portid,
>+			  size_t attr_size, struct netlink_ext_ack *extack)
>+{
>+	struct sk_buff *skb = NULL;
>+	int ret;
>+
>+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
>+		goto skip_msg;
>+
>+	skb = tcf_del_notify_msg(net, n, actions, portid, attr_size, extack);
>+	if (IS_ERR(skb))
>+		return PTR_ERR(skb);
>+
>+skip_msg:
> 	/* now do the delete */
> 	ret = tcf_action_delete(net, actions);
> 	if (ret < 0) {
>@@ -1902,9 +1933,8 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
> 		return ret;
> 	}
> 
>-	ret = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
>-			     n->nlmsg_flags & NLM_F_ECHO);
>-	return ret;
>+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
>+				    n->nlmsg_flags & NLM_F_ECHO);
> }
> 
> static int
>@@ -1955,26 +1985,43 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
> 	return ret;
> }
> 
>-static int
>-tcf_add_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
>-	       u32 portid, size_t attr_size, struct netlink_ext_ack *extack)
>+static struct sk_buff *tcf_add_notify_msg(struct net *net, struct nlmsghdr *n,
>+					  struct tc_action *actions[],
>+					  u32 portid, size_t attr_size,
>+					  struct netlink_ext_ack *extack)
> {
> 	struct sk_buff *skb;
> 
>-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>-			GFP_KERNEL);
>+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
> 	if (!skb)
>-		return -ENOBUFS;
>+		return ERR_PTR(-ENOBUFS);
> 
> 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
> 			 RTM_NEWACTION, 0, 0, extack) <= 0) {
> 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
> 		kfree_skb(skb);
>-		return -EINVAL;
>+		return ERR_PTR(-EINVAL);
> 	}
> 
>-	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
>-			      n->nlmsg_flags & NLM_F_ECHO);
>+	return skb;
>+}
>+
>+static int tcf_add_notify(struct net *net, struct nlmsghdr *n,
>+			  struct tc_action *actions[], u32 portid,
>+			  size_t attr_size, struct netlink_ext_ack *extack)
>+{
>+	struct sk_buff *skb = NULL;
>+
>+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
>+		goto skip_msg;
>+
>+	skb = tcf_add_notify_msg(net, n, actions, portid, attr_size, extack);
>+	if (IS_ERR(skb))
>+		return PTR_ERR(skb);
>+
>+skip_msg:
>+	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
>+				    n->nlmsg_flags & NLM_F_ECHO);
> }
> 
> static int tcf_action_add(struct net *net, struct nlattr *nla,
>-- 
>2.40.1
>

