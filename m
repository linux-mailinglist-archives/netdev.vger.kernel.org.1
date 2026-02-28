Return-Path: <netdev+bounces-262248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMk9JLpqo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:22:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA6A1C9792
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE4330F6F50
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74B3D6470;
	Sat, 28 Feb 2026 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBP1WAkF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C73D5257
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317110; cv=none; b=J577dg0XW3J375IQphr6AQEw/NoMW+2WEDUy+MPi0cQ7qqKBCc8y+vhB4gufzL9Kw0GMUHRmQbNPudQj2BJIZTkjmVVkUDSDC1LI2z1qAXer8fmoTvpsqQBp7jOkFpF9X3caUURJcwfIL3B88IMlWgG4m9ok5CmCV9ABsNkPZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317110; c=relaxed/simple;
	bh=gIrAGuubnIlstbGb18zhtdA9MVOnWUcSYTMYhAK8wHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCGWZNsLoZ4J0uUGMGcj8YX6nePngCuW+M3/AjN1QaOfeMPCll5Hz9lvY+niYiAmvuminKLwMOLEi6q6cEuhF9KqufL2JFKLesHq0CGnN0VFkUSFKzJzvoG5J2T4cNJ4CvZlATF33C8BT9UDITymbIPUX2/x4dUX2bwVZP1GWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBP1WAkF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3594620fe97so18159374a91.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317108; x=1772921908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rL2dW4AILYfNoY1N9DyXr4RceX26D4Hv/gPDZPbyaKA=;
        b=hBP1WAkFyA6+V8BYth9O6bJBFGwAkIVRjCHZ3oI9+w+9p+iAWSIxoPUwJ15N/gopPX
         +ngB0e5XzkoFsPumMjcDwk0fQveaP0n9JUpZeeLAv+sMQuiIuFmDYuNDjvpn8McA9u8x
         rT2M2A57xugo1h8RknuH0bRWaU3NSvLD+ReQ32wDuMGmR9u/4ihSu482zTmhgmTvvrDg
         ofrGcqRRkoxVbnJWHBG3acLjP8t7Pq92IYPm5F9IcyH4AcHJPUavsUBkIEaETgBARSwa
         K8PoBj/9iX7nFVIDzEkpI92t5dF5c25zkBsevPkF5fR6ihL0Pe4eNLqh7b+5czAX8VNn
         x9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317108; x=1772921908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL2dW4AILYfNoY1N9DyXr4RceX26D4Hv/gPDZPbyaKA=;
        b=TR80eUo5e+qD2FVT62o4Un0j/n/UJDKZVJOWvmPkGxOjFXAgi2i6RoQXNcCKrKb2zf
         k8jeW109mEr5QQABaMl8h9+kBYxug4gccbENx032+I1hS3LGgS38D7BBcS/0lH8VEp9J
         IOKiRTNWHuuIa99ng5+AxQh6OunC1RrFt/wW0L8uu/o4VRXMJmhPkcrwv50kKYrgLSu0
         mJ2gD5XpmSY8pKVkR+LPrDqdReba2S9Jqep4BmLMcmjLk85FFFBSqPAZqNnuz8QeLD4q
         oTRk+XPKchIONGctTKTJasX6y+p96HRMas9FVvq8L26QY2WWLXYbI9/zZ/uBY19HtbKG
         X6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP3n7G5KeIebaAhJgB1+qM/uDaMoyMVenjyKqAXxnZgKIA9uFBSivKwFkCHRJU7SvMMpvVgo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoPM+dmJNTdeA06lL5d/iiEQ/7MMZ8rMZfj3twjPEp1QYXHuG
	8NejEqtubxvKldg8Ydo1/3O5iK8NmLr80LQQh8nROQv0ObhpXZD+K/UOxd95YyeHtcllxBOfG2B
	npgN9Dw==
X-Received: from pjiz1.prod.google.com ([2002:a17:90a:6081:b0:359:7f9:79b1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134c:b0:349:2154:eef4
 with SMTP id 98e67ed59e1d1-35965c1177cmr5894701a91.5.1772317108017; Sat, 28
 Feb 2026 14:18:28 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:33 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-16-kuniyu@google.com>
Subject: [PATCH v3 net-next 15/15] ipmr: Don't hold RTNL for ipmr_rtm_route().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262248-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBA6A1C9792
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index d4983d8a9b2a..8a08d09b4c30 100644
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


