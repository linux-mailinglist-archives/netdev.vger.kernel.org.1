Return-Path: <netdev+bounces-261711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FdjEL0SoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:42:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519E1B2583
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D877531593D0
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54BA332EB3;
	Fri, 27 Feb 2026 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sm7RXcG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F017332EBE
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163574; cv=none; b=ijrhQ8hUM5qDPOqc/Q2OmyURMvwGo1Ep2OHUuzmDxnO5c00sWN41lNETJdRZh89DWoERQz09CXQi6r4r1siE09uoKsxtmg3tVfGjqqG8VxMmY8kNgmrazIBgkOQTKrST9DzKLPQZTkraaxYchDUjRE7nTzZmGCvFVWGUq9WCJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163574; c=relaxed/simple;
	bh=CR92IMl3iUZiE7HBrQ/JuVz927tARCQcGJJZByxZnPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aGL9ZtUbpYJYS/MWw1z23MWP/yPI+i4KOYu8yJ3dx64ZOEBICmwGZYTKIN8Pw0vSn7rWY6Ck2OpNdDeZUuoti6R84F6L6qS89gQO0tVkqHrZpZknNHRXI0ndVfIxaAACqMjC1mPaxomVu5ZzxLQx06H70nbDnOITUZJgTLikhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sm7RXcG+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aaf0dbd073so15672605ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163573; x=1772768373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YUlr/rhZta7O3sJP+HczpLHF5TLg57aKx+/633jwYI=;
        b=sm7RXcG+SQbdRL0eVk42lpyMAR3HJZw9FPgGiQ0QJd6ZpDPGg4CubIfD/FJqYdU5lR
         52UvK48TQVco4LuGO6MkOEnobvuTftqwuBL37nvFMlZ+fiG8zlumA8Z97NRrXVqurJ8d
         p1TKcmqJDqTSSBqa2UVeQmrsFjscFEyzh+4Df7pY+01RHwsBs/i+t5DSIh5fdwbEdKD2
         9mbQ0/LSj/Kk/2bY/18adUBzAaCck9OZIUZqsoID3OgESQV4Dq9f2r530kuazDY9m1kc
         BNYWVyJ7oGktR1EItJis5//xtrgg5Hm0VjpUSTlKxMbbQ+s5hc3amfK2JG5oB4sjmo4Q
         j/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163573; x=1772768373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YUlr/rhZta7O3sJP+HczpLHF5TLg57aKx+/633jwYI=;
        b=Jmeba+gbJ8ep7tnFYEUcXDlezRkfcwnN5zftehGTbdDzGF+1NrgkDGgPbH1o7Go/FT
         5a9grIETcpt+iVPASsAzh3BTIw8LcNsUtlMJzZfazKhyTjLD9T4YfDQVode8Rz0zPiQt
         T+UEdToaIMmfQGHIzbRTP0rD43fC0aZruLdoV5fMTFEeIESr52GoPbosaQY8xe1+T1pR
         BZ6kbC86iG5Kp9TepNTh/PQrcJQdmAVLy+B3moCehOEUZgWgUpvDLWxLNyPPSi9iIGeu
         AeBS2lRSFlzqN91mjThCg61ZjDwdkyuLogj1nkR030TaUwSWzSLVKbw1ggdrJw4OBjpL
         Aulg==
X-Forwarded-Encrypted: i=1; AJvYcCXj2VXQkyduzPep+FryZ6FTba1BrJP2Ap9TrEPixBv6rJM4V7IlO5AbN3piuw6lw/nirOEaH5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjHVh95mKRJxzpyxw/H/77KSSYBtv/y6PRaN0LeEL01KvaTbMo
	O0o97jMwpOEREnRLOryHoKsOzCpDFqWCzaIh9a/TF7mbcqX6YfE2AIj3yu5BmKAIat/VA1LACLM
	iIDFkag==
X-Received: from pjje7.prod.google.com ([2002:a17:90a:6307:b0:358:dfd8:3150])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244e:b0:35b:b97f:7bd2
 with SMTP id adf61e73a8af0-395c39de3b3mr1458608637.10.1772163572509; Thu, 26
 Feb 2026 19:39:32 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:38 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-16-kuniyu@google.com>
Subject: [PATCH v2 net-next 15/15] ipmr: Don't hold RTNL for ipmr_rtm_route().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261711-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9519E1B2583
X-Rspamd-Action: no action

ipmr_mfc_add() and ipmr_mfc_delete() are already protected
by a dedicated mutex.

rtm_to_ipmr_mfcc() calls __ipmr_get_table(), __dev_get_by_index(),
amd ipmr_find_vif().

Once __dev_get_by_index() is converted to dev_get_by_index_rcu(),
we can move the other two functions under that same RCU section
and drop RTNL for ipmr_rtm_route().

Let's do that conversion and drop ASSERT_RTNL() in
mr_call_mfc_notifiers().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h |  1 -
 net/ipv4/ipmr.c             | 34 +++++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 0baa6f994da9..cf3374580f74 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -208,7 +208,6 @@ static inline int mr_call_mfc_notifiers(struct net *net,
 		.tb_id = tb_id
 	};
 
-	ASSERT_RTNL();
 	atomic_inc(ipmr_seq);
 	return call_fib_notifiers(net, event_type, &info.info);
 }
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9afaa5a3761f..b9280a8880dd 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1211,7 +1211,6 @@ static int ipmr_mfc_delete(struct mr_table *mrt, struct mfcctl *mfc, int parent)
 	struct net *net = read_pnet(&mrt->net);
 	struct mfc_cache *c;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ipmr_cache_find_parent(mrt, mfc->mfcc_origin.s_addr,
 				   mfc->mfcc_mcastgrp.s_addr, parent);
@@ -1238,7 +1237,6 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 	if (mfc->mfcc_parent >= MAXVIFS)
 		return -ENFILE;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ipmr_cache_find_parent(mrt, mfc->mfcc_origin.s_addr,
 				   mfc->mfcc_mcastgrp.s_addr, parent);
@@ -2853,10 +2851,10 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
 {
 	struct net_device *dev = NULL;
 	u32 tblid = RT_TABLE_DEFAULT;
+	int ret, rem, iif = 0;
 	struct mr_table *mrt;
 	struct nlattr *attr;
 	struct rtmsg *rtm;
-	int ret, rem;
 
 	ret = nlmsg_validate_deprecated(nlh, sizeof(*rtm), RTA_MAX,
 					rtm_ipmr_policy, extack);
@@ -2883,11 +2881,7 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
 			mfcc->mfcc_mcastgrp.s_addr = nla_get_be32(attr);
 			break;
 		case RTA_IIF:
-			dev = __dev_get_by_index(net, nla_get_u32(attr));
-			if (!dev) {
-				ret = -ENODEV;
-				goto out;
-			}
+			iif = nla_get_u32(attr);
 			break;
 		case RTA_MULTIPATH:
 			if (ipmr_nla_get_ttls(attr, mfcc) < 0) {
@@ -2903,16 +2897,30 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
 			break;
 		}
 	}
+
+	rcu_read_lock();
+
 	mrt = __ipmr_get_table(net, tblid);
 	if (!mrt) {
 		ret = -ENOENT;
-		goto out;
+		goto unlock;
 	}
+
+	if (iif) {
+		dev = dev_get_by_index_rcu(net, iif);
+		if (!dev) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+
+		mfcc->mfcc_parent = ipmr_find_vif(mrt, dev);
+	}
+
 	*mrtret = mrt;
 	*mrtsock = rtm->rtm_protocol == RTPROT_MROUTED ? 1 : 0;
-	if (dev)
-		mfcc->mfcc_parent = ipmr_find_vif(mrt, dev);
 
+unlock:
+	rcu_read_unlock();
 out:
 	return ret;
 }
@@ -3343,9 +3351,9 @@ static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETLINK,
 	 .dumpit = ipmr_rtm_dumplink, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_NEWROUTE,
-	 .doit = ipmr_rtm_route},
+	 .doit = ipmr_rtm_route, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_DELROUTE,
-	 .doit = ipmr_rtm_route},
+	 .doit = ipmr_rtm_route, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETROUTE,
 	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute,
 	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.53.0.473.g4a7958ca14-goog


