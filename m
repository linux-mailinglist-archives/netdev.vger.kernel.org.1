Return-Path: <netdev+bounces-277586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL+PHXhp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A653DCD51
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF0ED3048F37
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25F3B27F5;
	Fri, 10 Apr 2026 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/tJpoi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929583B2FFB
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855871; cv=none; b=ZrUHk5QBYAReYy7qR58aOVDuUfj3f6niKy5i/T6Q8CxM/weP7gFQgVsvoMDMQI5s1IPIKj+pXQkbZFjbeuuDosWuxx/zMl1RrrJDBhzHFP2EKzQo1lyR3q58t13N+gXOzSrsooMvAHBh/svh6a7ReaphMILj1SwfiyAFiGUt9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855871; c=relaxed/simple;
	bh=6CyjTXelBUygSdqDnzVLDk5+a+EoUy6EHUOpGJqlC14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lxHldhiWShCHpfQC2WbjKZFRFEDWj2mE3MqEmLT7gLr2EQZkNBBAu10CdEOsiV/spkHM8malDImC9lM+DD6kSpDjTdhvsCMYvANKW4FLEAeVksKjgGhPBJIIIbJkVGwqUn/6mhOwdXS9QXlr7S+6s+HQOqVp0SQ4GTmHi+ODsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/tJpoi/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cd9fa608bso3456809b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855869; x=1776460669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ndrM9eetdNAl9Cc2xe1zmMhRtomojfV6wzQKd8EII=;
        b=m/tJpoi/iBAG16q5JEjcQtOnzd8Vhxu+hG/b6bAenHgsOe/y0UHx7f3/FlA8cbYTCn
         1t5Oq+br7mPfFznlSBDi3eJ63HlpZcCACMnzibBp56wOtxmgcP50GmzLxyAlfZux9tB6
         PlvRd/WrohYWtml8HT44JCCfWIlfG6ZBh38l0oOB+vcE/97Xn2vUtMXrynxuQqJuOOVU
         NNRagBZrkR6CHZtA5Vu7oefgcJ1XSu1KjAcSMzMnYEf/Q6nI9YvsHLJFgq+JqDD6F0Pz
         JfeTPU74H+HsdLh1bsWadt0Z2AvcbjHcjKSIIxnfT2Qzxe+d6TIXxn+oOGtmaj39hmoE
         KMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855869; x=1776460669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ndrM9eetdNAl9Cc2xe1zmMhRtomojfV6wzQKd8EII=;
        b=jZXqE2s4UHN+jq0Yiw0y2SyG1/LbDyycKcqLftztJ99Ns6n28LlgcA7sIs1oBXYJw1
         s7XH5k5epZcx4JhnTfF2ASYSXSg6QbvYm55CtwaN76B29B13tWeVRq9T45CxUoZy+bcT
         p/QxfNySz7F63wUbbRgaEZZwyDMsmkrNrpDzMdAOGjcCMFy6N0sghsSQy1CXV1lAVMDe
         /gxKE40Rtm1jx8Q2WQp1kQKluo0lXVjs9jQ+M/efLYzxKxpgbHsym4daqJJWlki+f9d2
         lsP/a/Sd08Kwp/Z/E5DxSqLM46s4S3YomL/n5qQRKWOacVKXrYoQ9qsusGoeZsndjuwh
         uQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQOLs3+v8BkE+3Rndo0nh+c4uX0BWoY/to3cGaUXoNWp4SlDrHDXWVfdv9DYw8QLPG2koKwOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2uAUAx8d1AUyclsTLuQZlt7VUop5M/QQbvJDVhcl4Fb4N02Sp
	JUo7+KIv7/z8HoYllJ+XKT+O3HbaVgwk0T7u60TKLgdxvDoXuMfaBTnZ5hE+kJStJYSoN/PJ5l2
	hdaWQWw==
X-Received: from pfqy15.prod.google.com ([2002:aa7:9e0f:0:b0:824:9ab3:ebe8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:951a:b0:81a:b183:44fc
 with SMTP id d2e1a72fcca58-82f0c29f639mr5353588b3a.23.1775855868828; Fri, 10
 Apr 2026 14:17:48 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:06 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/15] ip6mr: Move unregister_netdevice_many() out
 of mroute_clean_tables().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277586-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4A653DCD51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a prep commit to convert ip6mr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in mroute_clean_tables()
to its callers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index fdec7a541cf6..dd72eb346eb1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -99,7 +99,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			      struct netlink_ext_ack *extack);
 static int ip6mr_rtm_dumproute(struct sk_buff *skb,
 			       struct netlink_callback *cb);
-static void mroute_clean_tables(struct mr_table *mrt, int flags);
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list);
 static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
@@ -412,12 +413,15 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
-				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
+			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
+			    &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree_rcu(mrt, rcu);
 }
@@ -1541,10 +1545,10 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
  *	Close the multicast socket, and clear the vif tables etc
  */
 
-static void mroute_clean_tables(struct mr_table *mrt, int flags)
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list)
 {
 	struct mr_mfc *c, *tmp;
-	LIST_HEAD(list);
 	int i;
 
 	/* Shut down all active vif entries */
@@ -1554,9 +1558,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 			     !(flags & MRT6_FLUSH_MIFS_STATIC)) ||
 			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT6_FLUSH_MIFS)))
 				continue;
-			mif6_delete(mrt, i, 0, &list);
+			mif6_delete(mrt, i, 0, dev_kill_list);
 		}
-		unregister_netdevice_many(&list);
 	}
 
 	/* Wipe the cache */
@@ -1619,6 +1622,7 @@ int ip6mr_sk_done(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 	struct ipv6_devconf *devconf;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err = -EACCES;
 
@@ -1646,11 +1650,13 @@ int ip6mr_sk_done(struct sock *sk)
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
 
-			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC);
+			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC,
+					    &dev_kill_list);
 			err = 0;
 			break;
 		}
 	}
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
 	return err;
@@ -1765,14 +1771,17 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	case MRT6_FLUSH:
 	{
+		LIST_HEAD(dev_kill_list);
 		int flags;
 
 		if (optlen != sizeof(flags))
 			return -EINVAL;
 		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
 			return -EFAULT;
+
 		rtnl_lock();
-		mroute_clean_tables(mrt, flags);
+		mroute_clean_tables(mrt, flags, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
 		rtnl_unlock();
 		return 0;
 	}
-- 
2.53.0.1213.gd9a14994de-goog


