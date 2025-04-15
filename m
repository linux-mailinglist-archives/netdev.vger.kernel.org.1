Return-Path: <netdev+bounces-182564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8A3A891B6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF983B6051
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727FE1FDE0E;
	Tue, 15 Apr 2025 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LEaNo9ZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4F77111;
	Tue, 15 Apr 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682342; cv=none; b=ECnT6n/GuKnW6pUEGqdj/kJRhuXuWOjIMVqr6xYX6KS71r5b26EKwD9j2yguMUE/mVTUQFt6fhVIjnOw3CLT8/iTSCfdXqiUtdXqR7HNcDaoJ6JOzq8yLlz5pQVpiOiikI4Gp8P8pYULOh19eMf132AdRqWtmn4Mh9IHehVgBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682342; c=relaxed/simple;
	bh=enSpWXpgXmbOBNZ91Tw1oD5MTIdCzO1o7htRLn9/bbE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNwH1dPhDdaa8634evulZlE17kh/jv9xTpOqKU2/S+bqRjD4qI4AAk3NxKlVmZqGU6MSc1nQfNNfD9FGoCMTdQTMrCTyMZgcGyBga/flU4QQc3kxnn3l0cGFdOYFbZ+JdPCckGuWRHznKv6qtGRvqB4uhq6ApvDamjGb+zt8osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LEaNo9ZW; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744682340; x=1776218340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=45epccg6KuO8jiaGbxXWuvirrVL8AkdtcvpZOxqNlLU=;
  b=LEaNo9ZWBrnlz/x0lS0PVDQXAylvH8ytD4upWs0T5TDuPko76ohl/WDA
   QZHooYa4rvCA0RMvEFxugxwnmlllhfonPSIXQLzyrNUeewdlqfIpodRC0
   ATgbSji8c3HE0PGljmR5mvbC1q7eYSMhu/l/BfR151VV0aZ6Hm0hV32/b
   g=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="191115359"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:58:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21958]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id e72c3ca1-ec12-4223-a2b6-4dd32b10c96d; Tue, 15 Apr 2025 01:58:56 +0000 (UTC)
X-Farcaster-Flow-ID: e72c3ca1-ec12-4223-a2b6-4dd32b10c96d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 01:58:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 01:58:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <andrew@lunn.ch>
CC: <akpm@linux-foundation.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qasdev00@gmail.com>
Subject: Re: [PATCH 4/4] net: register debugfs file for net_device refcnt tracker
Date: Mon, 14 Apr 2025 18:56:59 -0700
Message-ID: <20250415015844.7590-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <782ca402-83a0-4a7b-b29b-ac021932d081@lunn.ch>
References: <782ca402-83a0-4a7b-b29b-ac021932d081@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 15 Apr 2025 01:16:11 +0200
> On Mon, Apr 14, 2025 at 03:27:36PM -0700, Kuniyuki Iwashima wrote:
> > From: Jeff Layton <jlayton@kernel.org>
> > Date: Mon, 14 Apr 2025 10:45:49 -0400
> > > As a nearly-final step in register_netdevice(), finalize the name in the
> > > refcount tracker, and register a debugfs file for it.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  net/core/dev.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..db9cac702bb2230ca2bbc2c04ac0a77482c65fc3 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -10994,6 +10994,8 @@ int register_netdevice(struct net_device *dev)
> > >  	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
> > >  		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
> > >  
> > > +	/* Register debugfs file for the refcount tracker */
> > > +	ref_tracker_dir_debugfs(&dev->refcnt_tracker, dev->name);
> > 
> > dev->name is not unique across network namespaces, so we should specify
> > a netns-specific parent dir here.
> > 
> > For example, syzkaller creates a bunch of devices with the same name in
> > different network namespaces.
> > 
> > Then, we also need to move the file when dev is moved to another netns
> > in __dev_change_net_namespace().
> 
> The address of dev should be unique, and does not change as the netdev
> moves between network name spaces. So you could postfix it with the
> hashed version of an address, as produced by %pK. This is debugfs, it
> does not need to be too friendly.

Fair enough.

Maybe %p should be used ?  I just saw this series.
https://lore.kernel.org/netdev/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/

Also, it would be nice to update netdev_wait_allrefs_any()
so that we can query the debugfs easily once we find the
possible refcnt leak.

---8<---
diff --git a/net/core/dev.c b/net/core/dev.c
index 93f982de1da0..d129e44ef9f9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11277,8 +11279,8 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 		if (time_after(jiffies, warning_time +
 			       READ_ONCE(netdev_unregister_timeout_secs) * HZ)) {
 			list_for_each_entry(dev, list, todo_list) {
-				pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
-					 dev->name, netdev_refcnt_read(dev));
+				pr_emerg("unregister_netdevice: waiting for %s (%p) to become free. Usage count = %d\n",
+					 dev->name, dev, netdev_refcnt_read(dev));
 				ref_tracker_dir_print(&dev->refcnt_tracker, 10);
 			}
 
---8<---

