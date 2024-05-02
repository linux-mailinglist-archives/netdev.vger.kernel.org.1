Return-Path: <netdev+bounces-93012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3F8B9A23
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 13:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038001F21D10
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB36CDCC;
	Thu,  2 May 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfVoda4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F06664DD
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649876; cv=none; b=ElZiyoXt38T/ykDvO5fYUJR5ZDBK9VuYSIyuj2ngecxqj7eSlDXpLlUhq1w3OBz65K0Ot/DH0MOpoCZt84l224qrxofTom8i6RBv+scoVKGR1jD/0EnjOIBw54NzXAwjv99ICsD1iqkkL26OU7UPRzZDkeCZtJWP60AgQ4uxUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649876; c=relaxed/simple;
	bh=jpUaNxwwT/shZg223A0GbgbWTEn+c7tYxFcKwYZ5BCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDPxEo2Upc0QmwCQtc61/gx7dxjNTwdvP1auns/gEmOCnqyI8k+4Z9GpJGn6c2a8NC7M4VPmmTXCpkuRs8APAibHvTk4UUWFO/zaUoRAIJdacP1trC/pJ+fu3xpZOY8nU1Cp3fI7JTCHt4K1Lsm44YRPXBYKB4NYYH64pt4/XKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfVoda4M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0c1f7169so9207387b3.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714649873; x=1715254673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOWS65CjuyWfP5oa7h+vEdFZ/FCeN21iOlDI8UKu3VE=;
        b=hfVoda4M0TOBKrICMXCOZ0pseoUYc2jQSk8kFz3j8xDjtYtnB1K7Y9MQIsNxTMD4X9
         hMA6XyZZponHuvT9sjUJdWI96hgHxdic+ihRqdwCJMdzQlTWGC4xhpOwZmN/NKXLbajD
         iJ+274ooRw/LIjlDrcdecq1FJ1i8oewQG2i3fQVZ0a/xO2rfUCINrlLBY5CFw4vVYKqN
         N6bnxbmpD1mq3I29AGVzIWcvMteICeR916zBMdFmiZGGJ+9vKpPWL/FV8niQ9TtmJhzD
         EHAXrmXuh42bE7oSm2QVwB/VjivSltWliMOmW0DtHMQeIXenq4dw0G3RvtD8ZCM9fgPD
         JJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649873; x=1715254673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOWS65CjuyWfP5oa7h+vEdFZ/FCeN21iOlDI8UKu3VE=;
        b=Cudq8SuxOxmS4AMhupwKIPIgDA8Rdqkwbz+7l++vABZgbuCmcSr+O6Iyo3yF3qXENO
         eTbf/5YTj+eQM4eRDULc4WbPW5+kbVphbCkSlaX+3mIRHyL42yGPKqXImHk4e92p0AH2
         TQFfCpF5v4+Z5h5IOYsEmjRNIKjv7OerGSX1ODs/VW1HuE3jO6CJ1T5X9DrkuYmYl8Sx
         zKAT9f+tS4FDXdmRUmpfnMLvl3gCnLRqMzvrhj09a11lGKxZrkCzs5py0k03m9rSO5Qc
         /TeP2LFDDAcazxwWBhAQqvHbg6n57ErP07hlWouSf5nuVTUdNnSs3GmpPhnAX206Wkvd
         eORA==
X-Gm-Message-State: AOJu0YzcU2YVoMutWu30kA//3gMNWhvTP8iW8LVCdkmKw0dLIBy2/RJF
	qyWJStNEQmywY6O2HLLScPJHPHnlVZ8dk8XBG3KY3916i+G5BfsaO9141GWP24hA5udni3A98OP
	ZaOpirSog5A==
X-Google-Smtp-Source: AGHT+IHIGtazm4EeudWZbLFK5YfvR5rKZJ3XKUm8YCJzxVyufTl5+1BGki9Oild36G2qQgsrISJLFe7R28rijg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6642:0:b0:de5:dcb8:5c8a with SMTP id
 z2-20020a256642000000b00de5dcb85c8amr569454ybm.2.1714649873612; Thu, 02 May
 2024 04:37:53 -0700 (PDT)
Date: Thu,  2 May 2024 11:37:48 +0000
In-Reply-To: <20240502113748.1622637-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502113748.1622637-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240502113748.1622637-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] rtnetlink: use for_each_netdev_dump() in rtnl_stats_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Switch rtnl_stats_dump() to use for_each_netdev_dump()
instead of net->dev_index_head[] hash table.

This makes the code much easier to read, and fixes
scalability issues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 59 +++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 88980c8bcf334079e2d19cbcfb3f10fc05e3c19b..28050e53ecb025f8d207f4b38805fb108799ca65 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5961,19 +5961,17 @@ static int rtnl_stats_get(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_stats_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct netlink_ext_ack *extack = cb->extack;
-	int h, s_h, err, s_idx, s_idxattr, s_prividx;
 	struct rtnl_stats_dump_filters filters;
 	struct net *net = sock_net(skb->sk);
 	unsigned int flags = NLM_F_MULTI;
 	struct if_stats_msg *ifsm;
-	struct hlist_head *head;
+	struct {
+		unsigned long ifindex;
+		int idxattr;
+		int prividx;
+	} *ctx = (void *)cb->ctx;
 	struct net_device *dev;
-	int idx = 0;
-
-	s_h = cb->args[0];
-	s_idx = cb->args[1];
-	s_idxattr = cb->args[2];
-	s_prividx = cb->args[3];
+	int err;
 
 	cb->seq = net->dev_base_seq;
 
@@ -5992,37 +5990,24 @@ static int rtnl_stats_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	if (err)
 		return err;
 
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[h];
-		hlist_for_each_entry(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			err = rtnl_fill_statsinfo(skb, dev, RTM_NEWSTATS,
-						  NETLINK_CB(cb->skb).portid,
-						  cb->nlh->nlmsg_seq, 0,
-						  flags, &filters,
-						  &s_idxattr, &s_prividx,
-						  extack);
-			/* If we ran out of room on the first message,
-			 * we're in trouble
-			 */
-			WARN_ON((err == -EMSGSIZE) && (skb->len == 0));
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		err = rtnl_fill_statsinfo(skb, dev, RTM_NEWSTATS,
+					  NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq, 0,
+					  flags, &filters,
+					  &ctx->idxattr, &ctx->prividx,
+					  extack);
+		/* If we ran out of room on the first message,
+		 * we're in trouble.
+		 */
+		WARN_ON((err == -EMSGSIZE) && (skb->len == 0));
 
-			if (err < 0)
-				goto out;
-			s_prividx = 0;
-			s_idxattr = 0;
-			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
-cont:
-			idx++;
-		}
+		if (err < 0)
+			break;
+		ctx->prividx = 0;
+		ctx->idxattr = 0;
+		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	}
-out:
-	cb->args[3] = s_prividx;
-	cb->args[2] = s_idxattr;
-	cb->args[1] = idx;
-	cb->args[0] = h;
 
 	return err;
 }
-- 
2.45.0.rc0.197.gbae5840b3b-goog


