Return-Path: <netdev+bounces-261139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHT9Ef+xn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DD1A0265
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 084CE304E355
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300C3803E2;
	Thu, 26 Feb 2026 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGAIdQWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09237AA8E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073426; cv=none; b=ogpNq/l+omtI2S1VXADmeNcPljtvCaVvw9O/jxil+WLswQg22yg+A+Isp1hHfSIWDYQUGTvz79/UONLvaWW8ZxVmkgrrQAjbf8pHLppDiWNjkCk6Wk74adVml7FkWOqguguBRYp0Udv9d+EER7eB5SS9qmFimAYfJhPtvPfqcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073426; c=relaxed/simple;
	bh=hlpSktstOeW41xrgEbK+uL9ER9JUynqqfZZrg4uMin0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GiE0OCovWNXZP5N5Tovv6Lmp88+EXTFN7vxcckdI5S8Pl9+iOrLNZmMivaWENnTahMTrRt7MXromNfJutoPuIT66aPPwiOx3v6yHQyMCmHFeqpxTWfhMQ2A7VFd2jMIfbgIIbKZ1NHW9SqJD5L6OBINaNPNH+RV/ckJwwemnclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGAIdQWA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8273f4ed107so32512b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073425; x=1772678225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAwQolxfnVAZq2X52qB2srTMe0f7C7puDkbiJ3SzKVI=;
        b=TGAIdQWAoO8kwd8/7ZKwp/7LoN+m/ggn16CDrtMSy9CWFVu6EiIDW3uyClqCivnW5v
         23rUPi8s40JO7P/odGIzs03+fHXkraZYm8WfIcgn9orut3UnPKh4UgA5IjuV/hWJA8xY
         vu8D8GkrBrWJjWI/ny8wyiu61vsuMoZ/GdAl41ng9TEuq85630IO9J14wR2t+bD1Ecqz
         IOaAPky8a6WqDxDCoajW3gUAd4yhDOgJ3xn3vBHSsueQsPYUW2Dvz+ADHnyR5M+twBIR
         NFAMcuFDgN7LyE8GNmhz6bfpSCH9vB/2UEhCJO9WPFd3ZKcVNwzh5zq0fi2dnaM7IXcI
         TN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073425; x=1772678225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAwQolxfnVAZq2X52qB2srTMe0f7C7puDkbiJ3SzKVI=;
        b=UO/WX7WEJGnAMsEYIXoQ0eQMOU8t1gEQEsWmW1sCFCd7R+yQC8H780nG6ccb0UD5M3
         Q0gPwRWiKAZ0Ta/iW2r8x+rZPX2RuO/HPvaBvY+tthRB46ZiGuKRXZQhBPXj8Pjoxu2S
         q9QMW6Qtkrt4EPfi3NCA9pN+hLMaaVm3FZrt1lNLKFeUt5pJKvZw0/F7lEMBrusV69OT
         fjNF5cJEI23ryAYYy3RrqgFjaYvjx3uDeNNP7vigSJKL5JcOuML/1JC6NUn16G5xXmKO
         Awz5OPX2S3ElUZF6V5fiQR8LvGdd++oINQ7u7cH0NmUkj2BUzU7AVC/WnhMJ6TpBH/UJ
         uwfA==
X-Forwarded-Encrypted: i=1; AJvYcCXm6Ps6JDC4a+G3BTmirIGRK/tQj4qoqfIClrT6kO1a3EoMYNWTw2MduMZyo3fJvwsRu1qYESc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygIocLNAWWSA5Wu0VAaodLTU2mUScd8I+Xk0vBZ5VX5hwuwuw1
	hqKc1t64Q9ENWhvXLRZu9UagaOpTEW23ZZ8hpTNWO7//d7VgK8nNBSsLHP2WnZlfGfiANxkht/9
	nOuD7fw==
X-Received: from pgag24.prod.google.com ([2002:a05:6a02:2f18:b0:c70:e705:e5cd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd93:b0:824:15ff:d35c
 with SMTP id d2e1a72fcca58-827338c21damr2209928b3a.63.1772073424558; Wed, 25
 Feb 2026 18:37:04 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:27 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-16-kuniyu@google.com>
Subject: [PATCH v1 net-next 15/15] ipmr: Don't hold RTNL for ipmr_rtm_route().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261139-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 297DD1A0265
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
index 0dd7d088de50..4e645a87dc6c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1209,7 +1209,6 @@ static int ipmr_mfc_delete(struct mr_table *mrt, struct mfcctl *mfc, int parent)
 	struct net *net = read_pnet(&mrt->net);
 	struct mfc_cache *c;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ipmr_cache_find_parent(mrt, mfc->mfcc_origin.s_addr,
 				   mfc->mfcc_mcastgrp.s_addr, parent);
@@ -1236,7 +1235,6 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 	if (mfc->mfcc_parent >= MAXVIFS)
 		return -ENFILE;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ipmr_cache_find_parent(mrt, mfc->mfcc_origin.s_addr,
 				   mfc->mfcc_mcastgrp.s_addr, parent);
@@ -2851,10 +2849,10 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
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
@@ -2881,11 +2879,7 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
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
@@ -2901,16 +2895,30 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
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
@@ -3341,9 +3349,9 @@ static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
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
2.53.0.414.gf7e9f6c205-goog


