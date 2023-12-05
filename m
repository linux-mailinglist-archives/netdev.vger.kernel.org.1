Return-Path: <netdev+bounces-53829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94E804C73
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A780B20955
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D118B1E;
	Tue,  5 Dec 2023 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uXYpvwKV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B26C0
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:32:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so57254105e9.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701765170; x=1702369970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzRiOpZQwoIl1wCfEDY7/CoiolCRT2Hax8xSWRGcwZc=;
        b=uXYpvwKV9aQjQfgf5y3P8zdF+HBgREn29KSRbwPwB8DsEH4pCibPerWiaqZ0g1hKf5
         znwNJlz9aZ/ayC6uOhfM+RbNd31odzvYGg24kkVE4/mQ8I+4vRsvP9GhBZRafqixL38s
         xuTmzcU46AYZjgyW7mldDw6zFiRvSItu9tzfUH1vIccGV6Q32d4+JC4ce82nXPVI48lG
         /qAqSUAxxk2izvDF/nxyn1+6PKx+vMwJHdHeWL7HNkwF0E/CNFyCVb3PxxsPyTakRqwI
         +Gumn+r2NkG7dktJm08IFuoGO5j9C5tAD2y5/eX9ttlesiJ5VrCwhnzZdUkvOD1SnmYj
         YdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765170; x=1702369970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzRiOpZQwoIl1wCfEDY7/CoiolCRT2Hax8xSWRGcwZc=;
        b=tgjMlwoGTlFUAiCyA9d4n9oSogu5LueYopS8oopct9B5OAkoxXnAla3SPeeoUJxN/3
         bG/9saeGFjaR+pJGIGlUvIuDoqsx/f3Tr0/oVaeBATic7KbImdtRptCpvPXo0BkXEjTA
         BFCMdn0sQ3qnc/FxlR4Rh9Mi3g9ZtRzT4A8u8KP3VmGX9OnLxeuZ/ep3VTIcCjyc1Wyl
         V67M9x7JKxAwKKWmpUvHsxYbEkxSlOwyyvwDi2favLAQX5vzv3sbj7bCaJk+ulbkrOKX
         pw90TihzpcDFYKkuTDJr5aFifTqBTKUYNptwVQLG8zUY7SUHifLa8Bkjdp1reVYbqQ5U
         exeQ==
X-Gm-Message-State: AOJu0Yyr+dqD1sbLY0KbEkyrdZwMzUUtgeRweyu34KDBepPVdewWAN4g
	B5u6lY09P8fYiPLD8w2DPlb3EA==
X-Google-Smtp-Source: AGHT+IGm/1aoDgNdtpx7Yl+3QHjan6M0kRpOoNQbGKzLZB0XL8Y0WS2aa3UkiO4Q2inc6BSUoLLBIA==
X-Received: by 2002:a7b:cb98:0:b0:40c:331:bd2 with SMTP id m24-20020a7bcb98000000b0040c03310bd2mr168309wmi.85.1701765170454;
        Tue, 05 Dec 2023 00:32:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d5605000000b0033341165b0csm6649694wrv.36.2023.12.05.00.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:32:49 -0800 (PST)
Date: Tue, 5 Dec 2023 09:32:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net] net: core: synchronize link-watch when carrier is
 queried
Message-ID: <ZW7gMO9YNjP7j4vj@nanopsycho>
References: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>

Mon, Dec 04, 2023 at 09:47:07PM CET, johannes@sipsolutions.net wrote:
>From: Johannes Berg <johannes.berg@intel.com>
>
>There are multiple ways to query for the carrier state: through
>rtnetlink, sysfs, and (possibly) ethtool. Synchronize linkwatch
>work before these operations so that we don't have a situation
>where userspace queries the carrier state between the driver's
>carrier off->on transition and linkwatch running and expects it
>to work, when really (at least) TX cannot work until linkwatch
>has run.
>
>I previously posted a longer explanation of how this applies to
>wireless [1] but with this wireless can simply query the state
>before sending data, to ensure the kernel is ready for it.
>
>[1] https://lore.kernel.org/all/346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net/
>
>Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>---
> include/linux/netdevice.h | 9 +++++++++
> net/core/dev.c            | 2 +-
> net/core/dev.h            | 1 -
> net/core/link_watch.c     | 2 +-
> net/core/net-sysfs.c      | 8 +++++++-
> net/core/rtnetlink.c      | 8 ++++++++
> net/ethtool/ioctl.c       | 3 +++
> 7 files changed, 29 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index 2564e209465e..17dbaf379c69 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -4195,6 +4195,15 @@ static inline void netdev_ref_replace(struct net_device *odev,
>  */
> void linkwatch_fire_event(struct net_device *dev);
> 
>+/**
>+ * linkwatch_sync_dev - sync linkwatch for the given device
>+ * @dev: network device to sync linkwatch for
>+ *
>+ * Sync linkwatch for the given device, removing it from the
>+ * pending work list (if queued).
>+ */
>+void linkwatch_sync_dev(struct net_device *dev);
>+
> /**
>  *	netif_carrier_ok - test if carrier present
>  *	@dev: network device
>diff --git a/net/core/dev.c b/net/core/dev.c
>index c879246be48d..188799b2c6a5 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -10511,7 +10511,7 @@ void netdev_run_todo(void)
> 		write_lock(&dev_base_lock);
> 		dev->reg_state = NETREG_UNREGISTERED;
> 		write_unlock(&dev_base_lock);
>-		linkwatch_forget_dev(dev);
>+		linkwatch_sync_dev(dev);
> 	}
> 
> 	while (!list_empty(&list)) {
>diff --git a/net/core/dev.h b/net/core/dev.h
>index 5aa45f0fd4ae..cb06fe5e38ea 100644
>--- a/net/core/dev.h
>+++ b/net/core/dev.h
>@@ -30,7 +30,6 @@ int __init dev_proc_init(void);
> #endif
> 
> void linkwatch_init_dev(struct net_device *dev);
>-void linkwatch_forget_dev(struct net_device *dev);
> void linkwatch_run_queue(void);
> 
> void dev_addr_flush(struct net_device *dev);
>diff --git a/net/core/link_watch.c b/net/core/link_watch.c
>index ed3e5391fa79..7be5b3ab32bd 100644
>--- a/net/core/link_watch.c
>+++ b/net/core/link_watch.c
>@@ -240,7 +240,7 @@ static void __linkwatch_run_queue(int urgent_only)
> 	spin_unlock_irq(&lweventlist_lock);
> }
> 
>-void linkwatch_forget_dev(struct net_device *dev)
>+void linkwatch_sync_dev(struct net_device *dev)
> {
> 	unsigned long flags;
> 	int clean = 0;
>diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>index fccaa5bac0ed..d9b33e923b18 100644
>--- a/net/core/net-sysfs.c
>+++ b/net/core/net-sysfs.c
>@@ -194,8 +194,14 @@ static ssize_t carrier_show(struct device *dev,
> {
> 	struct net_device *netdev = to_net_dev(dev);
> 
>-	if (netif_running(netdev))
>+	if (netif_running(netdev)) {
>+		/* Synchronize carrier state with link watch,
>+		 * see also rtnl_getlink().
>+		 */
>+		linkwatch_sync_dev(netdev);
>+
> 		return sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(netdev));
>+	}
> 
> 	return -EINVAL;
> }
>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index e8431c6c8490..613268d7c491 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -3853,6 +3853,14 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> 	if (nskb == NULL)
> 		goto out;
> 
>+	/* Synchronize the carrier state so we don't report a state
>+	 * that we're not actually going to honour immediately; if
>+	 * the driver just did a carrier off->on transition, we can
>+	 * only TX if link watch work has run, but without this we'd
>+	 * already report carrier on, even if it doesn't work yet.
>+	 */

This comment is a bit harder to understand for me, but I eventually did
get it :)

Patch looks fine to me.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>



>+	linkwatch_sync_dev(dev);
>+
> 	err = rtnl_fill_ifinfo(nskb, dev, net,
> 			       RTM_NEWLINK, NETLINK_CB(skb).portid,
> 			       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
>diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>index 0b0ce4f81c01..a977f8903467 100644
>--- a/net/ethtool/ioctl.c
>+++ b/net/ethtool/ioctl.c
>@@ -58,6 +58,9 @@ static struct devlink *netdev_to_devlink_get(struct net_device *dev)
> 
> u32 ethtool_op_get_link(struct net_device *dev)
> {
>+	/* Synchronize carrier state with link watch, see also rtnl_getlink() */
>+	linkwatch_sync_dev(dev);
>+
> 	return netif_carrier_ok(dev) ? 1 : 0;
> }
> EXPORT_SYMBOL(ethtool_op_get_link);
>-- 
>2.43.0
>
>

