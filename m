Return-Path: <netdev+bounces-276268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPPRCDrQ1WkC+QcAu9opvQ
	(envelope-from <netdev+bounces-276268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C73B6A67
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50752300FB41
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4F2DFF04;
	Wed,  8 Apr 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq75Bk26"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0538DD3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775620150; cv=none; b=Ma2tCb/sM+h49yRF64sUI7doCII+wM6FoafyEeEb46etpZYCoX8CtjwKH8qJ5Iymlq5YquceZQKnMEZt62JmWd6e6DrZdME0AtOCUK5NLWwUM/KCZ8j4ey8mo+ZKO2Rk0so5YroQuY3fGHBWB+FPUCiFRfWvS0ez4CGUoKhXm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775620150; c=relaxed/simple;
	bh=ZCkmSDssM1hkVtLxuKsPyuG1F469nf/dSaFiLDUrhiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LzJkYEyGhbLQCZJbq4v0TOSoCZkwDp8BJSeqEUWMGUvAJcSCZZ8v32iwyNexKFXyqCjnS6t3ew52pHJJYwoIFJcn1h4L82bGTQkbvCNp185jDB6vRNH9x01OdMnrdUm5o95Xi5A6IQv5opqchLlcFe8jXUWyyMa+SeFKFQuC2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eq75Bk26; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b15a3ccfso3025178a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 20:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775620148; x=1776224948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2wX3AXlaXkxs9wOOhFIzBMPXNbMYAXWZ2lzBCTV/4M=;
        b=eq75Bk26t2RLK41z6g1Fv37JgQfpQVFaJ1loAczfnKuqDYOTlhjw2LtQPlzYmjgsTF
         KBbJnX/JXA4sYhmGChgUIbR6oqu5h+1CacH9exBdNKLmFeHyTekCdiONMG7Eom2ZppYz
         l6PGOBBuU/Ls07CF4ySuKqhLlpPdRdtX8vw8lwRACKCjgbm/No5J5e0Is/BKrCFZX5V4
         Gkt/0iXF/lhoazCAcrdsvlB4YKrsiMFP4v9A8FHiD6CxxU5x2zHwCG8s4Zr9/Jcv3R9R
         oZcDW+xH5UI6TcDIjk94sUnVPg5X8UuEi3eVmHupu1jUo7lpikywiovv+f0jEf34nVks
         lPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775620148; x=1776224948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2wX3AXlaXkxs9wOOhFIzBMPXNbMYAXWZ2lzBCTV/4M=;
        b=AWktd5CMW/likbyXkNPaBRv5IYSpBossKMowUKTZejkUkbNdTAzIpQB9GodoeJwGEL
         zOe4PBr4Y/gpgr4qFb/t/q2gjM2XeKcNfRDethYrT4m7T6vEJbx6vSC8nrK39uhdQqnD
         8PRDZOArKRrjl2A9U1MdTAigzKEdhEyVTrp1eCiH2YEf9vv0xh80P6VkidD8YDZW7R+7
         1TwgV+lQqYMUh11QLMT/gPiBtTolZuKwRg8pq4tM54bXrtzrBXLaciwX5e7ax4NBFffC
         z7PIK92IorHPqABPuYWeEpV1oj8HakQcKcpYA86V7inLlalrC0zxtLUlKb4jgb9wX1Wf
         RfGA==
X-Forwarded-Encrypted: i=1; AJvYcCVbUWVi656LmrWp4uoQ+/syu1IFCY834ereftv6Y7ehuIlHTBiBBzC1qxQSrjaU3VSpuFix8gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRVLq3383Ld8c36+137doVEvFhaIZxsmKYdsNq/HBFUs6TV2W
	Tv0X3P58aEv7TCmTNhcGeKGc4SlnudYB7f2KBZoXbkT7s4y1Ab0GZLkWymgc40jGUBiMteEFT/d
	ubfdnag==
X-Received: from pfbfb42.prod.google.com ([2002:a05:6a00:2daa:b0:82c:b5d3:9bb7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f8f:b0:82c:6f07:2d8e
 with SMTP id d2e1a72fcca58-82d0dcfdc6amr19377442b3a.54.1775620148082; Tue, 07
 Apr 2026 20:49:08 -0700 (PDT)
Date: Wed,  8 Apr 2026 03:48:17 +0000
In-Reply-To: <20260407184202.34cfe2d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407184202.34cfe2d6@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408034906.2812551-1-kuniyu@google.com>
Subject: Re: [PATCH v3 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,gmail.com,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276268-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C0C73B6A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 7 Apr 2026 18:42:02 -0700
> On Tue,  7 Apr 2026 21:19:33 +0000 Kuniyuki Iwashima wrote:
> > This series is the IPv6 version of
> > 
> >   https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google.com/
> > 
> > and removes RTNL from ip6mr rtnetlink handlers.
> 
> CI says:
> 
> [  857.648411][   T63] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
> [  857.648639][   T63] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> [  857.648765][   T63] CPU: 2 UID: 0 PID: 63 Comm: kworker/2:2 Not tainted 7.0.0-rc6-virtme #1 PREEMPT(full) 
> [  857.648903][   T63] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  857.649006][   T63] Workqueue: mld mld_ifc_work
> [  857.649090][   T63] RIP: 0010:mroute6_is_socket+0x4a/0x80

Oops, CONFIG_IP_MROUTE_MULTIPLE_TABLES=n does not check
if net->ipv6.mrt6 is NULL and always returns 0.

Unlike ipmr, ip6mr had implicit dependency on the pernet ops
order to stop mld_ifc_work before ip6mr_rules_exit().

Before converting ->exit_batch() to ->exit_rtnl(), it must
prepare for that situation and properly use RCU helpers like below.

I'll replace patch 2 with the RCU conversion patch in v2.

( I noticed I marked this v3 by reusing the previous command for
  ipv4 series, sorry for confusion. )

Thanks !

---8<---
diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 3341acca002f..ee68c05d0584 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -259,6 +259,7 @@ struct mr_table {
 	bool			mroute_do_pim;
 	bool			mroute_do_wrvifwhole;
 	int			mroute_reg_vif_num;
+	struct rcu_head		rcu;
 };
 
 static inline bool mr_can_free_table(struct net *net)
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b9c048b6f1ca..468a30c76930 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -319,7 +319,9 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
-	*mrt = net->ipv6.mrt6;
+	*mrt = rcu_dereference(net->ipv6.mrt6);
+	if (!*mrt)
+		return -EAGAIN;
 	return 0;
 }
 
@@ -338,7 +340,7 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 {
 	ASSERT_RTNL();
 	ip6mr_free_table(net->ipv6.mrt6);
-	net->ipv6.mrt6 = NULL;
+	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -412,7 +414,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
 	rhltable_destroy(&mrt->mfc_hash);
-	kfree(mrt);
+	kfree_rcu(mrt, rcu);
 }
 
 #ifdef CONFIG_PROC_FS
---8<---

