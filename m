Return-Path: <netdev+bounces-155256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E091A01879
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 09:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812091883981
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F0136671;
	Sun,  5 Jan 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZPZfdAGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E384D0F
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736064016; cv=none; b=XTeD+X32mWdkZ/XeJ6X/6JCyTv9bfmrhk7y4po3T1Fnx4PatCJkdh9JQCp9v+DgK8XYocfKUfdUP6k77v/+UpFYK6zmqQ9Y6HEmoVz19XfLrkfpV+yny3s3ShYSA12wP2qewdiZCGj3qAYx7iytPxq/B7ux1IzKDgQHxVOXTY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736064016; c=relaxed/simple;
	bh=hyE8jc/4G8kc/cA9MfG3XKEYmYpIk35PXf/LjdKnZh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejK5IGignMQal5biRBfYobut2EZOSAid9111X5/SBiKjc9oi+Bv1EI945NV2eTxxKglxdYwl6QwMqymIlh/q9/nEWCtIZ3eDGUcA/u7rS78II6T1J23ODtyZWPD2At9VgbINXtTJJUgDJMSeQPEjhRoVoPhlZIRRXaw1PDCNz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZPZfdAGT; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736064014; x=1767600014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MQoA/q7Jf5xZzyIhT+CQyWeAtrqla6jgniUPKlg+o6s=;
  b=ZPZfdAGTbK6+WcSQvRbIiGElcnw9qP0bdsY6ofDRRijiUPfEx/3XTXNs
   N7T7xnw3a+DiOxuE3tUdQIiM98/rPfwGkCzRJBhg5UTsQcXFRXIq3FXIk
   QUj2/7O8fSKr+DqzTVaIpA+ntIvdRyyHWJL6PCDSBg+NM/2mdQ0X9iZoe
   M=;
X-IronPort-AV: E=Sophos;i="6.12,290,1728950400"; 
   d="scan'208";a="686934481"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 08:00:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:4911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.219:2525] with esmtp (Farcaster)
 id 3394782f-51e6-4e4d-901e-ac1f7ab550b1; Sun, 5 Jan 2025 08:00:10 +0000 (UTC)
X-Farcaster-Flow-ID: 3394782f-51e6-4e4d-901e-ac1f7ab550b1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 5 Jan 2025 08:00:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.186) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 5 Jan 2025 08:00:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 0/4] net: Hold per-netns RTNL during netdev notifier registration.
Date: Sun, 5 Jan 2025 16:59:57 +0900
Message-ID: <20250105075957.67334-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250104073740.597af5c0@kernel.org>
References: <20250104073740.597af5c0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 4 Jan 2025 07:37:40 -0800
> On Sat, 4 Jan 2025 15:37:31 +0900 Kuniyuki Iwashima wrote:
> > Patch 1 converts the global netdev notifier to blocking_notifier,
> > which will be called under per-netns RTNL without RTNL, then we
> > need to protect the ongoing netdev_chain users from unregistration.
> > 
> > Patch 2 ~ 4 adds per-netns RTNL for registration of the global
> > and per-netns netdev notifiers.
> 
> Lockdep is not happy:
> 
> [  249.261403][   T11] ============================================ 
> [  249.261592][   T11] WARNING: possible recursive locking detected
> [  249.261769][   T11] 6.13.0-rc5-virtme #1 Not tainted
> [  249.261920][   T11] --------------------------------------------
> [  249.262094][   T11] kworker/u16:0/11 is trying to acquire lock:
> [  249.262293][   T11] ffffffff8a7f6a70 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x50/0x90
> [  249.262591][   T11] 
> [  249.262591][   T11] but task is already holding lock:
> [  249.262810][   T11] ffffffff8a7f6a70 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x50/0x90
> [  249.263100][   T11] 
> [  249.263100][   T11] other info that might help us debug this:
> [  249.263310][   T11]  Possible unsafe locking scenario:
> [  249.263310][   T11] 
> [  249.263522][   T11]        CPU0
> [  249.263624][   T11]        ----
> [  249.263728][   T11]   lock((netdev_chain).rwsem);
> [  249.263875][   T11]   lock((netdev_chain).rwsem);

Ah, lockdep annotaion was needed for the nested notifier calls.

But this will not be a meaningful annotation and needs to be changed
once rtnl_setlink/dellink supports per-netns RTNL.

I'll drop patch 1 and just leave a comment around RTNL in
register_netdevice_notifier() in patch 2.

Another option would be clone each netdev notifier during registration
and unshare(2)/clone(2) and force notifiers to be namespacified ?

---8<---
diff --git a/net/core/dev.c b/net/core/dev.c
index a0dd34463901..8bf8d565f42d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -446,6 +446,17 @@ static void unlist_netdevice(struct net_device *dev)
 
 static BLOCKING_NOTIFIER_HEAD(netdev_chain);
 
+#ifdef CONFIG_PROVE_LOCKING
+static int netdev_chain_lock_cmp_fn(const struct lockdep_map *a,
+				    const struct lockdep_map *b)
+{
+	if (rtnl_is_locked())
+		return -1;
+
+	return 1;
+}
+#endif
+
 /*
  *	Device drivers call our routines to queue packets here. We empty the
  *	queue in the local softnet handler.
@@ -12229,6 +12240,8 @@ static int __init net_dev_init(void)
 
 	net_dev_struct_check();
 
+	lock_set_cmp_fn(&netdev_chain.rwsem, netdev_chain_lock_cmp_fn, NULL);
+
 	if (dev_proc_init())
 		goto out;
 
---8<---

