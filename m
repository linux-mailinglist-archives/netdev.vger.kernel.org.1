Return-Path: <netdev+bounces-277580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP2cOilp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 672973DCD16
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 533703036E93
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6B3AF657;
	Fri, 10 Apr 2026 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4hX1uZp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F33B19A6
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855860; cv=none; b=uRboJ5kfdHQXUMQp8tvgjZSxy7N5g5B0ETP/3DYJJIaNzfPgpYYyAEpmeDZ6gtYHXMXU6rcmPlewhab6jQY+0UVjkLkovXSvS0JuyRodsTOf77MU8Jhz3IMnzK339KPj+Pa8GSPy/3eZlvcPt/SXT03RbDmtEvdRzjsa75yWywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855860; c=relaxed/simple;
	bh=4QTFVGeCTrXNfihG8CnNVKynS8FF8MnMnCooRm6gu6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWf1v484w2BrnKCUdsPkk8Ke6vptfEsh9MyukS/0U7Qcj7I1SuVy87+WFAq4d8tPMBUhEjSz+mKs57uHS8fRqz3och26Wn6LK0eriO2t9YAqz7yYsk78hB9NOwAXBJXseZ6yXH0EdCyjh28IgTMenASez1ITT5cTUp5OiReoNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4hX1uZp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3509434a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855859; x=1776460659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6sDgRmr82Xd6JZz7y8jW96iKR70ZTdZ5A3cEgjOUxg=;
        b=S4hX1uZp8DTyYUHDRR8GFOz2pAWjCIQYGYPJt/9p5ZOGsehHXRAgisUBM8JiOmBcHx
         X5M11rBH2vPBq9GHHUlL6N4EkZtJhe/7/P9uE5aT2VaJ11oiSnHii6AKLQE90+cUENIt
         cemUgKjJbpswMByP5UE88WQPZQNBx1DhdQH8tckoTxftpK44osgaSNxOAUC3yFAZx66J
         xANAY1f2S4JpCfHNE+9nfRBKBHqnFqeNWeAcc0LImF+rXzLh5PIOkhZcZJr1QBnClstY
         kF3AwaSoFH7JF1IJjwmsqFLByHof152vib7/IKn8kpJdH80UcNquHgkEBhVqvYgJUVpo
         xBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855859; x=1776460659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6sDgRmr82Xd6JZz7y8jW96iKR70ZTdZ5A3cEgjOUxg=;
        b=r657bNNLLlcicr8+2uBlnz3dUZJoeTw/CWAN4f9LdK3gCjqg7XuiaQ8sAqBuEoqO7e
         9CmDBpfMvBwvut+/9NEM/bTQpxM4yRQw9nAj9BFnDAUjuvrnUsgMj5pitKqZIr/IjXih
         XOjuoR9XlLVVfzVh0DlRry7G5KoNzmLaFw/TTbWf0r4LHaK/pm7t2EPnTssOcdLNTLuv
         4DQrj0pl0orRlQzJSwRC/9Kq3D5aF8R0SUJYQVdKNCpuv/LkklsYpHvvHF2dDCg5wnpW
         NsolxkC24TzHthWwNB0d5BiduA4EQxqkDRKW1sLd8mwERpfG0czMwF4rNEY1oUsaRjCL
         y/DA==
X-Forwarded-Encrypted: i=1; AJvYcCWv5nLiVLBzngFfMHfN0H9BNEkXyOXIyDBUNt5VgY6aefyRT2EjAD5C8opKGgIUiCIbBSaV2Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemXNp0VsGrpbt7KcX46gpv7xMDb6K616DEmYpyZKs0dF3n5HQ
	l4i1UMXj7ZuIoeHf4khkuBvcZ+9JhtpLe/GKgxwAL2wCkwEXo4Yv0y2kOqmBIk4NxCpar4f0ilG
	Xp8BEqA==
X-Received: from pgar16.prod.google.com ([2002:a05:6a02:2e90:b0:c74:1130:c2e5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9389:b0:398:7a23:2779
 with SMTP id adf61e73a8af0-39fe408bfa5mr5549049637.52.1775855858954; Fri, 10
 Apr 2026 14:17:38 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:00 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/15] ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277580-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 672973DCD16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will convert ip6mr_rtm_getroute() to RCU in the following patch,
where __ip6mr_get_table() will be called under RCU.

nlmsg_new() uses GFP_KERNEL and needs to be called before holding
rcu_read_lock().

As a prep, let's move nlmsg_new() before __ip6mr_get_table().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 7ea572db9075..5356957bfe94 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2702,6 +2702,10 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	if (tb[RTA_SRC])
 		src = nla_get_in6_addr(tb[RTA_SRC]);
 	if (tb[RTA_DST])
@@ -2711,7 +2715,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err;
 	}
 
 	/* entries are added/deleted only under RTNL */
@@ -2720,21 +2725,20 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	rcu_read_unlock();
 	if (!cache) {
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err;
 	}
 
-	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
 	err = ip6mr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 				nlh->nlmsg_seq, cache, RTM_NEWROUTE, 0);
-	if (err < 0) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (err < 0)
+		goto err;
 
 	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+
+err:
+	kfree_skb(skb);
+	return err;
 }
 
 static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.53.0.1213.gd9a14994de-goog


