Return-Path: <netdev+bounces-55419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0780AD06
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F9D1C20D28
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33734CB5F;
	Fri,  8 Dec 2023 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="B4LUPAgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE01706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso1743995a12.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063771; x=1702668571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m2C8F8TxO/qe6PLr2tyxnYNhWwE8d63+ZuL37T31g8=;
        b=B4LUPAgzpadDOccMVo9dlPODHpAEl0jbMZbYuAvk3adaj8Di6rR177ieqiPIGU4vz0
         lkMKSMrqjVAGF3TFr6H5k30xZWRTRIlYjEgk7y9tLTpgTcB6fGHSQIQb+VLYu+bcg3E5
         yJ2gQ+qCab/qqHh1gW7pok+0tvAtBXKnRSDH/QfLy6dGEIobG/h0sAWTb0lnuDatfFjY
         817hcg+MdOe00JMPIT1AygZwWN39m87VREzTZWFeQT9tUcO1jsncibxTrt7wq8X77Uqz
         W0bxP+tVZOlfVjQuuxGa2oSdVaPybCfFSvjpb2HIKYCoLH2YlfnTTL/SwwF2ddLcUTEr
         5J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063771; x=1702668571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m2C8F8TxO/qe6PLr2tyxnYNhWwE8d63+ZuL37T31g8=;
        b=KuS6xpQPNia7/T93/S5+KWVo2rfLzqLMmwok7FJhzZQuNRRBPCvxQHAXgboD5qxJKJ
         30C3AShEaXLuxIOHtqDJy2HFyrJYGChU7m2wQPGVHmBNzrdTGKdwhVs17lhGBD4W8ehc
         2uBDS+HRtrnXx+M/RuGLLolC2zEDPprNlDkKn3ECTSmrBH89mAoxVQVRJWOHDpUhhdZ/
         KU0BJzl0UhmBXETSfbHh69wmZwSOdpRx/Bjs9h/iSGI9EDLfJIPYX5E4tN6JN9ckrXfk
         /+4xII8KUk3/uKStyoc6b0ZiL4OUz/lZ0AE7Q7JBDpDVi/lTQd4OhK46XhP4LovgFQ0b
         ikeg==
X-Gm-Message-State: AOJu0YwLAt2+QoTrTXFTcDwz7w1DeIrXXenJ8R/NqTwo/39X7exNhado
	dXN4r8fYF4Y1/cdfIlQyEKj9m/evyQH1jvcQxDQ=
X-Google-Smtp-Source: AGHT+IE1gJtgHkokh8y5ROrGapv/jMhiwOAzg0JQz7o/qOmy2yUa4ByOCAxi290PjjwHocyG1ygP5A==
X-Received: by 2002:a05:6a20:8f09:b0:18c:8d0f:a7b7 with SMTP id b9-20020a056a208f0900b0018c8d0fa7b7mr632884pzk.22.1702063771585;
        Fri, 08 Dec 2023 11:29:31 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:31 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v4 7/7] net/sched: cls_api: conditional notification of events
Date: Fri,  8 Dec 2023 16:28:47 -0300
Message-Id: <20231208192847.714940-8-pctammela@mojatatu.com>
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

As of today tc-filter/chain events are unconditionally built and sent to
RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
before-hand if they are really needed. This will help to alleviate
system pressure when filters are concurrently added without the rtnl
lock as in tc-flower.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_api.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4050215a532d..437daebc1fc4 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2052,6 +2052,9 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err = 0;
 
+	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2081,6 +2084,9 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err;
 
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2901,6 +2907,9 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 	struct sk_buff *skb;
 	int err = 0;
 
+	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2930,6 +2939,9 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 	struct net *net = block->net;
 	struct sk_buff *skb;
 
+	if (!rtnl_notify_needed(net, flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
-- 
2.40.1


