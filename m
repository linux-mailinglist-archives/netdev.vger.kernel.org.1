Return-Path: <netdev+bounces-53105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F48014BF
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8371F21074
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364A58AA0;
	Fri,  1 Dec 2023 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OXl2Q+lW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E8F1
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:43:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ce3084c2d1so8605275ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701463431; x=1702068231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QeFqkq5Sm15ECcIa5VGRkWrRM1DnWBwp0NyD4pxGB4=;
        b=OXl2Q+lWMuOB3XyL8jkO0jsJRpB7K9m/ThDkcowFyOXB9pannVr+sujzuxFw4cQekE
         mHQNA9tj8BUg+6N8dguhm8UQ+dZ5oirCDDzNjWw9VgKCz7XHydb9sqzz6ogTBFds5OE6
         7JreCoycxg0J52JCn53G4xXPq8Qa+nC647ZrXt2n+E589ApkmZ3ZusE4+TmuyeB7Uh6y
         yAGAqi3E6aFMKYjmSS+hKyEyMnYdHteCHKHbL6j4+vnB2iKc6uQrni/M6S0uRIvgddPr
         IOGv9Em1bYmFBIYFYQPDZXURpEGdt/5Pycx55EAN5STCyrkJeMCtZKktCWXOFzDixzN9
         G+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463431; x=1702068231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QeFqkq5Sm15ECcIa5VGRkWrRM1DnWBwp0NyD4pxGB4=;
        b=dzCG5gL8H7ZTQfTQJa5fXPZ3E3ZQuRmLMM4qBEOwXBhkmGX1dwfJcx74XeaRnnGZwk
         uFUUXkHLb4qtJvVJpSm/2QJBDo4AjV1kRDd60L6xN+T76ed/qMfrVUjAfdHUW6Zj8RJq
         fJCeIIu8Ghct55P3XecSpiy3xSwtHxVvoZGUN/FTyzaTtAaZalr/0uC22BVgFDI5A3hU
         dZ9IrhxV1r71RHPPvlaG8HjJlgk64p3fGQ4iTbwmglfADBFK69UmQHCdarWN2NqWPsbg
         esHKRK6UPWp4AJ7WGa8JW5UvbSUoEjscDqTSHeRGmGG8qLUp2Jl+0KvFdlwRKd+cnHAr
         qDOQ==
X-Gm-Message-State: AOJu0Ywb5FhN1RjaRsJeKQhj59wd/McXo6AX/h5uYdl7oCuzii9iDGgz
	UGW+RyiJ8jf/0piTtafJkvPlW5ETCMh3ukav228=
X-Google-Smtp-Source: AGHT+IFMccKgHG5WESJQgWVrd2H6he8nKBnXWT5AAwThNXZM66534JfaBtCpBH6UK58eA7ylT7A9dw==
X-Received: by 2002:a17:902:f811:b0:1cf:a5a0:5f85 with SMTP id ix17-20020a170902f81100b001cfa5a05f85mr113075plb.25.1701463431601;
        Fri, 01 Dec 2023 12:43:51 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b002865683a7c8sm1933467pjb.25.2023.12.01.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:43:51 -0800 (PST)
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
Subject: [PATCH net-next 4/4] net/sched: cls_api: conditional notification of events
Date: Fri,  1 Dec 2023 17:43:14 -0300
Message-Id: <20231201204314.220543-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201204314.220543-1-pctammela@mojatatu.com>
References: <20231201204314.220543-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today tc-filter/chain events are unconditionally built and sent to
RTNLGRP_TC. As with the introduction of tc_should_notify we can check
before-hand if they are really needed. This will help to alleviate
system pressure when filters are concurrently added without the rtnl
lock as in tc-flower.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_api.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..e99df0543c91 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2053,6 +2053,9 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err = 0;
 
+	if (!unicast && !tc_should_notify(net, n->nlmsg_flags))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2082,6 +2085,9 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err;
 
+	if (!unicast && !tc_should_notify(net, n->nlmsg_flags))
+		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2906,6 +2912,9 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 	struct sk_buff *skb;
 	int err = 0;
 
+	if (!unicast && !tc_should_notify(net, flags))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2935,6 +2944,9 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 	struct net *net = block->net;
 	struct sk_buff *skb;
 
+	if (!unicast && !tc_should_notify(net, flags))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
-- 
2.40.1


