Return-Path: <netdev+bounces-54514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12431807590
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA669B208C6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA2487BB;
	Wed,  6 Dec 2023 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RX29IpPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BD7B2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:45:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0521554ddso38044185ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 08:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701881099; x=1702485899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDVBWMk5yuVPMRwRZ/2oDezmX4qoKdeeTDdK45wJTg=;
        b=RX29IpPSrDQHHB4NdJec1i8+xhFdNnbaVZyn9QkdDLevG+pjswY49m6+ywCFfq97W1
         xM0d7jw9jjO+SIduB0ziyD6U80/j+0ionypQmj4FBLNDaxw8dw+0Jd3CjdkT3zLindd2
         gPz7/MOyVatcuPiUhPVNSnxirjg03BYtJppPwDadNmYi1b6y+ZULKE9l1CyeG/QjiLFS
         Q1LInjYR1MMR50MD9p+gM6rGm3CV/Hc9xHaOmaEXWSktrNaUKYoS1/wAxUpvZTcoRyQn
         U1LW5E2/YWv7UkW93dvLIYDmncNfdpdxZQp7iOlfZVZNJPo0d/lmM1MaJjjGIlFifwKt
         emZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881099; x=1702485899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpDVBWMk5yuVPMRwRZ/2oDezmX4qoKdeeTDdK45wJTg=;
        b=dzPHwIBrTzB570dbu41rcM9WvEeIf5zlzIcYwgvZT65tvmiHIpC4vhCFj3FTiZ8W/k
         WNjWCgqf8qZO0YpL8JAIm7kUqVATCvyVUcAd5TatgrDsswDzC4ERkh90b0QqgiZ7zN2M
         1ezcF04ZncC1EIP76tfc06rLQU9En8joOUOlR8nGsLgNQ6Hq3gsSpAZf8+DAjKctPcHj
         AZnfjRGUzwclFv00L09AY8CvZt7H3riEs6OkCCFQMoRpvQgzoofeeh/ISbYSDHMLRWP+
         2GXqd/wvsmaqYPxHB5YYFz7oXpjLS/WCS540Fx4jKS5K3QpJ1yjdLPeBqthsrGs+ot+6
         bQ5w==
X-Gm-Message-State: AOJu0YynWfrLEaKzwGVNOdIpnQBWJkIRsfda6oJftu4TJ6e4eyWEoUAd
	IcduK8RMq81zzD7ZHUbML9aWYhLQam42Q/bEHa0=
X-Google-Smtp-Source: AGHT+IFAy1DR1SGkHR327ZeNsXgIP6Cj4Nl0JI0TQQF4SHW7LFiBg49YWnIIixg+t0faqr+R8sLo0g==
X-Received: by 2002:a17:902:d4c5:b0:1d0:c5f8:22d8 with SMTP id o5-20020a170902d4c500b001d0c5f822d8mr972012plg.37.1701881099255;
        Wed, 06 Dec 2023 08:44:59 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001cfc3f73920sm36719pll.227.2023.12.06.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:44:59 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 5/5] net/sched: cls_api: conditional notification of events
Date: Wed,  6 Dec 2023 13:44:16 -0300
Message-Id: <20231206164416.543503-6-pctammela@mojatatu.com>
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

As of today tc-filter/chain events are unconditionally built and sent to
RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
before-hand if they are really needed. This will help to alleviate
system pressure when filters are concurrently added without the rtnl
lock as in tc-flower.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_api.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..123185907ebd 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2053,6 +2053,9 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err = 0;
 
+	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2082,6 +2085,9 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err;
 
+	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2906,6 +2912,9 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 	struct sk_buff *skb;
 	int err = 0;
 
+	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2935,6 +2944,9 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 	struct net *net = block->net;
 	struct sk_buff *skb;
 
+	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
-- 
2.40.1


