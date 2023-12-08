Return-Path: <netdev+bounces-55418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9D80AD05
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB077281B95
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972864CB5A;
	Fri,  8 Dec 2023 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hTrU6uID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E621706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cdea2f5918so1707343b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063768; x=1702668568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZK7Q8Zc8sne+UmGV8dWYwVR9BA2654LY3Kv0f39VPw=;
        b=hTrU6uIDKbSMOAqNH6QoZuVWKYoSXhX03P3ZWzxZKSOSzQhzNwbnoGpkASD844fadr
         R9YLO+p9pz+0D3ZCodwGSJiwfxuhY/h82Y3RdBenX1VNnz9Q7KKJdrNUhdyP3ZnNFgIq
         9DZr24w/ATtP20iLTuc/U8tRLBLPvgHNwxSF+Sb+B3FEJ9CV9h9hgUHVFmWtORP1IqSl
         IEehyvZdWV7W+/WAw7GKo6JyPy6D1uVHcb74LbmH2QWak8Vgd9ahj215hC0E4u8p3DXw
         V6R4xaVIUUksmDUhLtXz9t0MxmkwLkyHYStAZmuRUvHSSuUBDbm7wj4WLt30Unz5gSPA
         jyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063768; x=1702668568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZK7Q8Zc8sne+UmGV8dWYwVR9BA2654LY3Kv0f39VPw=;
        b=PzIWgRSG+ZB9iqxA/P+vdMT/bA71iDtOkPX2BKKUTp0FLZiXFFyOqCss4PHgO6VZd1
         ue1VnwGkGGW+0DUbOZuXEAb7sOulu7rgk4E4WBwXcaGHJOmvs1i9SZfhRTOGbc9uMCuC
         p+FF7X1xKKzQ1WkECycthmhNGXSAdHBEb4S/U89dsqksRnignQsV1W/dkM7oWmHD8B3y
         zSvXBqG5n8g0v3hPucP8VC/1VJuA+gAPqRCyyh0xGvJFx210f4yXt5wLqMqW40SD6uTX
         oxhZERP43AfQgytoKQyYhIDialFhOnzzgpWYJ8+zLDzp1qz/rfg4DM+MELfTuky0ZcAu
         myxQ==
X-Gm-Message-State: AOJu0YyHJ3hKHE6qPJDS21saaPkEVFmDOVJSYwXILndqob2VP8wbpmIY
	4V2ClmyEKNfyb4L1izNB5xTLf82qowSeXcXhEj4=
X-Google-Smtp-Source: AGHT+IFqTk8I3Hhg6UeW32Y56R+0E1hK4O0Evf130wfUGnqBL1DWDC5Hl0aMvnMMVWiba41fhakGtg==
X-Received: by 2002:a05:6a00:1143:b0:6ce:2d6d:24a6 with SMTP id b3-20020a056a00114300b006ce2d6d24a6mr516115pfm.19.1702063767971;
        Fri, 08 Dec 2023 11:29:27 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:27 -0800 (PST)
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
Subject: [PATCH net-next v4 6/7] net/sched: cls_api: remove 'unicast' argument from delete notification
Date: Fri,  8 Dec 2023 16:28:46 -0300
Message-Id: <20231208192847.714940-7-pctammela@mojatatu.com>
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

This argument is never called while set to true, so remove it as there's
no need for it.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_api.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..4050215a532d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -650,7 +650,7 @@ static void tc_chain_tmplt_del(const struct tcf_proto_ops *tmplt_ops,
 static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 				  void *tmplt_priv, u32 chain_index,
 				  struct tcf_block *block, struct sk_buff *oskb,
-				  u32 seq, u16 flags, bool unicast);
+				  u32 seq, u16 flags);
 
 static void __tcf_chain_put(struct tcf_chain *chain, bool by_act,
 			    bool explicitly_created)
@@ -685,8 +685,7 @@ static void __tcf_chain_put(struct tcf_chain *chain, bool by_act,
 	if (non_act_refcnt == chain->explicitly_created && !by_act) {
 		if (non_act_refcnt == 0)
 			tc_chain_notify_delete(tmplt_ops, tmplt_priv,
-					       chain->index, block, NULL, 0, 0,
-					       false);
+					       chain->index, block, NULL, 0, 0);
 		/* Last reference to chain, no need to lock. */
 		chain->flushing = false;
 	}
@@ -2075,8 +2074,8 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 			      struct nlmsghdr *n, struct tcf_proto *tp,
 			      struct tcf_block *block, struct Qdisc *q,
-			      u32 parent, void *fh, bool unicast, bool *last,
-			      bool rtnl_held, struct netlink_ext_ack *extack)
+			      u32 parent, void *fh, bool *last, bool rtnl_held,
+			      struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -2100,11 +2099,8 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 		return err;
 	}
 
-	if (unicast)
-		err = rtnl_unicast(skb, net, portid);
-	else
-		err = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-				     n->nlmsg_flags & NLM_F_ECHO);
+	err = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
+			     n->nlmsg_flags & NLM_F_ECHO);
 	if (err < 0)
 		NL_SET_ERR_MSG(extack, "Failed to send filter delete notification");
 
@@ -2499,9 +2495,8 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	} else {
 		bool last;
 
-		err = tfilter_del_notify(net, skb, n, tp, block,
-					 q, parent, fh, false, &last,
-					 rtnl_held, extack);
+		err = tfilter_del_notify(net, skb, n, tp, block, q, parent, fh,
+					 &last, rtnl_held, extack);
 
 		if (err)
 			goto errout;
@@ -2929,7 +2924,7 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 				  void *tmplt_priv, u32 chain_index,
 				  struct tcf_block *block, struct sk_buff *oskb,
-				  u32 seq, u16 flags, bool unicast)
+				  u32 seq, u16 flags)
 {
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	struct net *net = block->net;
@@ -2945,9 +2940,6 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 		return -EINVAL;
 	}
 
-	if (unicast)
-		return rtnl_unicast(skb, net, portid);
-
 	return rtnetlink_send(skb, net, portid, RTNLGRP_TC, flags & NLM_F_ECHO);
 }
 
-- 
2.40.1


