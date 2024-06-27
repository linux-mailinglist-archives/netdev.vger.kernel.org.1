Return-Path: <netdev+bounces-107142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E091A161
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F622827B1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A278C9A;
	Thu, 27 Jun 2024 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWjFtOus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AE78C60
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476781; cv=none; b=g+kkAIJc35k6MHKQl0GaY9s4UEorw5qUHyfcnpoZUpPS38fto7SS7l2wO0+FdcG6zGvESu2bQYxbK3X6jrRwALSzoZeTgZKL38DFThK7rxfaJYgiHtf+ZaDB1n1HSXSnLBSLz4A7bZouWUcN0uDiyMV7aImWrX5Zzw7boAK8iFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476781; c=relaxed/simple;
	bh=vExK64+AN9tlGf4BDc9rxTS5hmi0oRL4XymZKkP0qjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUYV4O6T+NaaHrGdmuZApCLfEbWuxwc9j49mN7xLGaTDsv9WXZZoSq91FjX5cCwtU3Ydrhh2o2xmGRM90ZEoqwfSZEVmzhgI5f2XWdxJmxKSTiq0Kv3uODkxyxoJ3sAh7AVO69531OF6YscB3yU2LZnVW12YX2Gd28qAFG8V4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWjFtOus; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d55e2e032dso1340798b6e.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719476779; x=1720081579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTEutjFVnwecKottYBwqiKx6xvUXwJ8KQevwVMwojEA=;
        b=MWjFtOusyMAtx13zm6monuHaUpFBwRNexDTsl+vAErIdfeE6oA8bljoU1CO7GnVJZq
         ErpQpgOoXJozkHqfV019QiyZ+s9FQJMyIavE9AaNRRlV1DDKUCEriVJUoiMp2X/mojpb
         85RGg7EiDYGBZGwxYu2/V6P5beMzTnG6iasnL7jIxgkolnySQhG7uwfsa8fQKkfifHtH
         4+slBOgyHb4ZbYfsAhh9KdO+9frnIj+r07R8XHvjDRULJ4bNSDyQws6nK6NbK65MhhBz
         s4maOdARvAtZ6P9QGYom629j9NpMCB62UyZrsqzq3bLnTyl9s51P2xSGs97pu+IHY0Ok
         3k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476779; x=1720081579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTEutjFVnwecKottYBwqiKx6xvUXwJ8KQevwVMwojEA=;
        b=rOiIBUSSPscM9z8tFTLEFSN6eVdBbkguud7ozbkvxrEUAbhrrjbUZP9XjWqN9jJdVM
         5aculEHKQLCPlKE820TV/TYToyFGVdA5ol+s+CYMXKytxaOglyIobgJUZTwDcg2Uxa0f
         1aoUMW5UiOKqI1TbUk/dGnsu1Jne7b/+rfsnAJyD/08i9tOHCT9EFGQsWCZcBK7IR7lk
         MWRmK+KsIFMB62RvgFjopYn1GZaf4ENGdrE82/7LcnMALubEMuT+lncZzzMneVr4fVsj
         ocqTgo1/sMP9MrdmkS/HFjD/2v7nywEXVGfuF2G+vI79mN0fE5Zwie3txtXRqe9IUtS1
         9Chw==
X-Forwarded-Encrypted: i=1; AJvYcCUT8MGbQzWDoUESUMq9LQLF1SGXs5apfNMM0guRoABRFX3B8DxAGQ15yMzCjOL+aD4iqoaR09oirrCgdmmxmSHPnG6ZpgCy
X-Gm-Message-State: AOJu0YxchWyFJZZbsWEf9IdLl7wPlDNs1M6Da7NO8FK3rI+3L+IbQns/
	CKso2TIgJH9U5pdXZ54ijoXA610U4C7eta7ay++SoBf+uumt/Ph7
X-Google-Smtp-Source: AGHT+IHFa+nlcVVyqBTwiaXqr4NJ08vzmddhHtDqIn53Qm4E4zIBb2VZwOBJwLQx0ZkPmDmVi4GEgg==
X-Received: by 2002:a05:6808:3c4d:b0:3d5:55a8:3637 with SMTP id 5614622812f47-3d555a836f9mr10758904b6e.55.1719476779157;
        Thu, 27 Jun 2024 01:26:19 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b48d09fesm787903b3a.19.2024.06.27.01.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:26:18 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:26:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <Zn0iI3SPdRkmfnS1@Laptop-X1>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org>
 <1429621.1719446760@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429621.1719446760@famine>

On Wed, Jun 26, 2024 at 05:06:00PM -0700, Jay Vosburgh wrote:
> >Hits:
> >
> >RTNL: assertion failed at net/core/rtnetlink.c (1823)

Thanks for this hits...

> >
> >On two selftests. Please run the selftests on a debug kernel..

OK, I will try run my tests on debug kernel in future.

> 
> 	Oh, I forgot about needing RTNL.
> 
> 	We cannot simply acquire RTNL in ad_mux_machine(), as the
> bond->mode_lock is already held, and the lock ordering must be RTNL
> first, then mode_lock, lest we deadlock.
> 
> 	Hangbin, I'd suggest you look at how bond_netdev_notify_work()
> complies with the lock ordering (basically, doing the actual work out of
> line in a workqueue event), or how the "should_notify" flag is used in
> bond_3ad_state_machine_handler().  The first is more complicated, but
> won't skip events; the second may miss intermediate state transitions if
> it cannot acquire RTNL and has to delay the notification.

I think the administer doesn't want to loose the state change info. So how
about something like:

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..046f11c5c47a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 		default:
 			break;
 		}
+
+		port->slave->should_notify_lacp = 1;
 	}
 }
 
@@ -2527,6 +2529,9 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 		bond_slave_state_notify(bond);
 		rtnl_unlock();
 	}
+
+	/* Notify the mux state changes */
+	bond_slave_link_notify(bond);
 	queue_delayed_work(bond->wq, &bond->ad_work, ad_delta_in_ticks);
 }
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3c3fcce4acd4..db8f2fb613df 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1748,11 +1748,19 @@ static void bond_netdev_notify_work(struct work_struct *_work)
 					   notify_work.work);
 
 	if (rtnl_trylock()) {
-		struct netdev_bonding_info binfo;
+		if (slave->should_notify_link) {
+			struct netdev_bonding_info binfo;
+			bond_fill_ifslave(slave, &binfo.slave);
+			bond_fill_ifbond(slave->bond, &binfo.master);
+			netdev_bonding_info_change(slave->dev, &binfo);
+			slave->should_notify_link = 0;
+		}
+
+		if (slave->should_notify_lacp) {
+			rtmsg_ifinfo(RTM_NEWLINK, slave->dev, 0, GFP_KERNEL, 0, NULL);
+			slave->should_notify_lacp = 0;
+		}
 
-		bond_fill_ifslave(slave, &binfo.slave);
-		bond_fill_ifbond(slave->bond, &binfo.master);
-		netdev_bonding_info_change(slave->dev, &binfo);
 		rtnl_unlock();
 	} else {
 		queue_delayed_work(slave->bond->wq, &slave->notify_work, 1);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index b61fb1aa3a56..38d37ea2382c 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -170,7 +170,8 @@ struct slave {
 	       inactive:1, /* indicates inactive slave */
 	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
 	       should_notify:1, /* indicates whether the state changed */
-	       should_notify_link:1; /* indicates whether the link changed */
+	       should_notify_link:1, /* indicates whether the link changed */
+	       should_notify_lacp:1; /* indicates whether the lacp state changed */
 	u8     duplex;
 	u32    original_mtu;
 	u32    link_failure_count;
@@ -641,11 +642,10 @@ static inline void bond_slave_link_notify(struct bonding *bond)
 	struct slave *tmp;
 
 	bond_for_each_slave(bond, tmp, iter) {
-		if (tmp->should_notify_link) {
+		if (tmp->should_notify_link || tmp->should_notify_lacp)
 			bond_queue_slave_event(tmp);
+		if (tmp->should_notify_link)
 			bond_lower_state_changed(tmp);
-			tmp->should_notify_link = 0;
-		}
 	}
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e..4507bb8d5264 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4116,6 +4116,7 @@ void rtmsg_ifinfo(int type, struct net_device *dev, unsigned int change,
 	rtmsg_ifinfo_event(type, dev, change, rtnl_get_event(0), flags,
 			   NULL, 0, portid, nlh);
 }
+EXPORT_SYMBOL(rtmsg_ifinfo);
 
 void rtmsg_ifinfo_newnet(int type, struct net_device *dev, unsigned int change,
 			 gfp_t flags, int *new_nsid, int new_ifindex)
-- 
2.45.0

Thanks
Hangbin

