Return-Path: <netdev+bounces-53647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43180403A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058E2B203D5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9C2E620;
	Mon,  4 Dec 2023 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XBdvXy+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F39198C
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:39:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d04d286bc0so19199995ad.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701722394; x=1702327194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMo/Bue1/I17ArEtSrp6d+C4Ij0UdWh9rH9ZmG0aZbE=;
        b=XBdvXy+Ate0uAaGCNeYKtxHNCdy79ia8JpfSVFnBAb0I0Z6Iz1tbNrUM1/Z7d+mn8n
         xqdbsyJ/rFVynlzA+ptzBEYEsK1Bfvxn/zeOhNyUDgBZHpWsJdifvtguy/RUgKYXle+s
         dpLSPyNmTLspMH933dGZzJbQB24V6OhI0wnW3RslZooDR8Uwg1kvVZw5M+nKP5vC31qE
         MHnmubS3Vd52gaXId23Zh++lAwkKFuS7rSIcDRkmVS1SL71CrYlnBo/ALr6lJKMUpPz2
         RGs49VcZD7AiNLP+oTMZFimaHpO8FJDmr3o6B/xXLBlgDJ1UzxoZgbkU1+C1ZKGq3VJy
         XBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722394; x=1702327194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMo/Bue1/I17ArEtSrp6d+C4Ij0UdWh9rH9ZmG0aZbE=;
        b=XhRf2Xk30wu5cab2RGu12ypPrao5XRPpqq09rmC2x98wj0m2QUfGyYtl1lOp7I77SH
         JrqA6+ldQK3sIWsO8Cn+08q9+Ao6mFlxIKwYjcIN5Hv7Ihcm9/QrhzER/o6yFStWJq92
         1ISn0OOIKa3bwcYO9qT2fWHzjnZxaup2Zvgq/cGvQyxMJTbKpmQR0S8W/pqMscTxXFcg
         FcvUONK9yeYHT73U5zceXPAyrgxNtrgapG3E2SUDVYG/Zfcrwp6eTYIipEX4V8+G631R
         /pqRU2/QlZQb4BsriTw2RdWiEo0FyiYIErxgCWxKoSaZGB0lQB3MXkrV0xN1dVy4UhPa
         SHGg==
X-Gm-Message-State: AOJu0YzI7bBtIIRMuNscoszLVEPtmegAfwZhj77K1KgwmyV+150IsOsf
	vKwBe4sAypNEwBz+BEUWQD26P3pakUyakc1bcy0=
X-Google-Smtp-Source: AGHT+IFMMLYdT+Twoq0avmbhpQ7U7RsbLhS54sdn1+LHeoSELg7X+q/ecZCyKuSvjXHJKS0oTpsAeA==
X-Received: by 2002:a17:902:ec87:b0:1d0:bcb2:b90f with SMTP id x7-20020a170902ec8700b001d0bcb2b90fmr979390plg.83.1701722394210;
        Mon, 04 Dec 2023 12:39:54 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001cf83962743sm2669584plg.250.2023.12.04.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:39:53 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] net/sched: cls_api: conditional notification of events
Date: Mon,  4 Dec 2023 17:39:07 -0300
Message-Id: <20231204203907.413435-6-pctammela@mojatatu.com>
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


