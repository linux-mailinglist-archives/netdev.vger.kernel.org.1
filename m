Return-Path: <netdev+bounces-176696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E7A6B642
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3003B10D6
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F341EFF99;
	Fri, 21 Mar 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oxm2CTL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A51E7C10
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546843; cv=none; b=tM/kj1igtulnKcIJieXV+QxrgFW1iipviNGS3c9m9TX+5dv69imx/ON15nPmX/hZjeFBRMhdRPO79199oj14C0eGkmHWY7hfW/j7Pec8nq/zsIo5lCwUmxVwIoaI+OGzTeBGXANEiCob2bIfcVuL1N0GkohfbQhP22MCpP1AuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546843; c=relaxed/simple;
	bh=SyuNoFb2i/s9V1tVbJyyxSOL1djkJ6ircSUIO1b2fYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzdGcfzKEukoLG1+PePisAgTlw17Byu1xjgu18+SpoxueymY2kOQlK5w6bXlZO9wNx2Vmg1mwW3PYCtb26x1bR1wRpRYLjrloBcV6IxzagTL0pKocSxWtebRgwnPetV2rAeYZ+qhpnL46ljm/Aas+pPiMuzBPUpVD/F7Sm6ak3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oxm2CTL2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so11025945e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742546839; x=1743151639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/u53XnjG5rISjfTaIEry56PJmuKkgU982r6mTPnK8U=;
        b=oxm2CTL2ZoPe+9+fF2vVHuMxFIn3GXo8F0Y4C1ksQZLSZYg1SYRsMTS4Or5+D0dWoL
         7C7f0+MUm7I3Uh/n9oTYKi8cbeMDAquc5Stpf/vlp2UMN8gAv+9z9A3mtVHk9jFb9ryX
         2Ht5esyaLUGrsSg/TGi3+Zvgfdklr9FTciJoeLfx93Yyo6kKj/0J9WjnrR6gSFnPNInC
         0JGJO7QxGhZ1cYAjddk1Rt+g76r3AbpsBG7J/mqUQhviZ4kJyB/i7GtrVAKGvt+/zffY
         aTx2t+xBOVz3LH0ARDDKJ0dj7+o0KpqNRGafBh+MzyfRyKFs9H/bvkyZ6PziGRKvPMr9
         Ri+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546839; x=1743151639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/u53XnjG5rISjfTaIEry56PJmuKkgU982r6mTPnK8U=;
        b=dkyzIxCRTJF5qCuaI+H8DkG7r497gq5SdvhoqV+254zrhx0/hBo41b3gG32nUjHL1J
         BKSHBBUgcWs3cToKEKt+R8o8n/ZH1vQknmoqpZmc9gZ/Ndq30TvQfp/rkPLLBs1Fiq8A
         aKYEzLgFV+GyNu8wFskzEF+nOCOPwnqAHtN/q9VFiifQpYECk5jl+HohoMFreVaEclY+
         uhajKdiwHtb/WiDPWD8hmS8aO32gkTTfasS2IFyEFt/0KZkTajB0a492X3JMKmV6CSt+
         8AxhfdGh6ZLA2yv1sBDkLZWQJXs6NMLINH0LwzkdXpKPDo0O+FAX77caDlFX/WajYobd
         UtSw==
X-Forwarded-Encrypted: i=1; AJvYcCXAJSQzVMnstlN5AC/aPyUFhST6zmfQgESeGB8bXPq2MPY3tQ+QtphUnN+gHkl3vRqkF5uQSsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MGey7ylgX31I8U7mhhB0JmJ+va7/8/bu1/Gv4G9DRVc+d4bg
	Y9wtUT4KJo6N9iRxLnVStnPE4v/t1jnukSGy/sPNuKux/Cq3tMPy2Yq1etn5D8s=
X-Gm-Gg: ASbGncv5breBGr8lZE1HzKG/AA3qYKwC+jk55AhU3PMuf/MXEMyTrSqhsuYx7hnWgwB
	O5HBMuUREbqySG2apRx70EcFRhM3at6ZPPZZphXOsIKuUIF0lgCYgcwAVS0ATRtjHJYoGcFyPCb
	/7OC91RH+jhqTuxfRrb+GDTDttXMWKJ+gcDn8dCVDl76kfxjegWc7gE8Rp2y2VVv91iP8pIVsz9
	WLUiYOnkI+MhpxJOg7KqQFEeeHrLIyol+TvbrEIQjQDMA/x0n3RpmO1T3NsYir0OWsTxiWNJt+7
	5+Wo0XY3nEgZI1rtMQTJwKpDDjRy8RpWMvQv6JpspyYjUOFJ5+/gdw6+lMeShZeYTKb081hwcIF
	jSnz1ft7KtPQ=
X-Google-Smtp-Source: AGHT+IE8LFIG/Qtb3OnOZFz3Hw5O/xAyEj5D1Z1h9iIdKAXnfjsvYhvJwHWGKVW6X9GspdfeVjRY6A==
X-Received: by 2002:a05:600c:1989:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-43d50a21402mr14264985e9.21.1742546839220;
        Fri, 21 Mar 2025 01:47:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm20273495e9.24.2025.03.21.01.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:47:18 -0700 (PDT)
Message-ID: <d9a8d030-7cac-4f5f-b422-1bae7f08c74f@blackwall.org>
Date: Fri, 21 Mar 2025 10:47:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 2/3] net: bridge: mcast: Notify on offload flag
 change
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Notify user space on offload flag(s) change.
> 
> This behavior is controlled by the new knob mdb_notify_on_flag_change:
> 
> 0 - the bridge will not notify user space about MDB flag change
> 1 - the bridge will notify user space about flag change if either
>     MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 2 - the bridge will notify user space about flag change only if
>     MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 
> The default value is 0.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_mdb.c       | 28 +++++++++++++++++++++++-----
>  net/bridge/br_multicast.c | 25 +++++++++++++++++++++++++
>  net/bridge/br_private.h   | 15 +++++++++++++++
>  net/bridge/br_switchdev.c | 25 +++++++++++++++++++++++--
>  4 files changed, 86 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 0639691cd19b..d206b5a160f3 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -519,16 +519,17 @@ static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
>  	       rtnl_mdb_nlmsg_pg_size(pg);
>  }
>  
> -void br_mdb_notify(struct net_device *dev,
> -		   struct net_bridge_mdb_entry *mp,
> -		   struct net_bridge_port_group *pg,
> -		   int type)
> +static void _br_mdb_notify(struct net_device *dev,
> +			   struct net_bridge_mdb_entry *mp,
> +			   struct net_bridge_port_group *pg,
> +			   int type, bool notify_switchdev)

please use double underscore "__"

>  {
>  	struct net *net = dev_net(dev);
>  	struct sk_buff *skb;
>  	int err = -ENOBUFS;
>  
> -	br_switchdev_mdb_notify(dev, mp, pg, type);
> +	if (notify_switchdev)
> +		br_switchdev_mdb_notify(dev, mp, pg, type);
>  
>  	skb = nlmsg_new(rtnl_mdb_nlmsg_size(pg), GFP_ATOMIC);
>  	if (!skb)
> @@ -546,6 +547,23 @@ void br_mdb_notify(struct net_device *dev,
>  	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
>  }
>  
> +void br_mdb_notify(struct net_device *dev,
> +		   struct net_bridge_mdb_entry *mp,
> +		   struct net_bridge_port_group *pg,
> +		   int type)
> +{
> +	_br_mdb_notify(dev, mp, pg, type, true);
> +}
> +
> +#ifdef CONFIG_NET_SWITCHDEV
> +void br_mdb_flag_change_notify(struct net_device *dev,
> +			       struct net_bridge_mdb_entry *mp,
> +			       struct net_bridge_port_group *pg)
> +{
> +	_br_mdb_notify(dev, mp, pg, RTM_NEWMDB, false);
> +}
> +#endif
> +
>  static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
>  				   struct net_device *dev,
>  				   int ifindex, u16 vid, u32 pid,
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b2ae0d2434d2..8d583caecd40 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4051,6 +4051,10 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	brmctx->ip6_querier.port_ifidx = 0;
>  	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
> +#ifdef CONFIG_NET_SWITCHDEV
> +	brmctx->multicast_mdb_notify_on_flag_change =
> +		MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE;
> +#endif
>  
>  	timer_setup(&brmctx->ip4_mc_router_timer,
>  		    br_ip4_multicast_local_router_expired, 0);
> @@ -4708,6 +4712,27 @@ int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
>  }
>  #endif
>  
> +#ifdef CONFIG_NET_SWITCHDEV
> +int br_multicast_set_mdb_notify_on_flag_change(struct net_bridge_mcast *brmctx,
> +					       u8 val)
> +{
> +	switch (val) {
> +	case MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE:
> +	case MDB_NOTIFY_ON_FLAG_CHANGE_BOTH:
> +	case MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Please use NLA_POLICY_MAX() instead.

> +
> +	spin_lock_bh(&brmctx->br->multicast_lock);
> +	brmctx->multicast_mdb_notify_on_flag_change = val;
> +	spin_unlock_bh(&brmctx->br->multicast_lock);
> +
> +	return 0;
> +}
> +#endif
> +
>  void br_multicast_set_query_intvl(struct net_bridge_mcast *brmctx,
>  				  unsigned long val)
>  {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index cd6b4e91e7d6..8e8de5d54ae3 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -132,6 +132,10 @@ struct net_bridge_mcast_port {
>  #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
>  };
>  
> +#define MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE	0
> +#define MDB_NOTIFY_ON_FLAG_CHANGE_BOTH		1
> +#define MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY	2

This should be an enum and it is also uAPI, you should move it to 
include/uapi/linux/if_bridge.h

> +
>  /* net_bridge_mcast must be always defined due to forwarding stubs */
>  struct net_bridge_mcast {
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> @@ -146,6 +150,9 @@ struct net_bridge_mcast {
>  	u8				multicast_router;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	u8				multicast_mld_version;
> +#endif
> +#ifdef CONFIG_NET_SWITCHDEV
> +	u8				multicast_mdb_notify_on_flag_change;
>  #endif
>  	unsigned long			multicast_last_member_interval;
>  	unsigned long			multicast_membership_interval;
> @@ -988,6 +995,10 @@ int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
>  int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
>  				 unsigned long val);
>  #endif
> +#ifdef CONFIG_NET_SWITCHDEV
> +int br_multicast_set_mdb_notify_on_flag_change(struct net_bridge_mcast *brmctx,
> +					       u8 val);
> +#endif
>  struct net_bridge_mdb_entry *
>  br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
>  struct net_bridge_mdb_entry *
> @@ -1004,6 +1015,10 @@ int br_mdb_hash_init(struct net_bridge *br);
>  void br_mdb_hash_fini(struct net_bridge *br);
>  void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
>  		   struct net_bridge_port_group *pg, int type);
> +#ifdef CONFIG_NET_SWITCHDEV
> +void br_mdb_flag_change_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
> +			       struct net_bridge_port_group *pg);
> +#endif
>  void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
>  		   int type);
>  void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 68dccc2ff7b1..5b09cfcdf3f3 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -504,20 +504,41 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	struct net_bridge_mdb_entry *mp;
>  	struct net_bridge_port *port = data->port;
>  	struct net_bridge *br = port->br;
> +	bool offload_changed = false;
> +	bool failed_changed = false;
> +	u8 notify;
>  
>  	spin_lock_bh(&br->multicast_lock);
>  	mp = br_mdb_ip_get(br, &data->ip);
>  	if (!mp)
>  		goto out;
> +
> +	notify = br->multicast_ctx.multicast_mdb_notify_on_flag_change;

let's not waste cycles if there was an error and notify == 0, please keep the original
code path and avoid walking over the group ports.

> +
>  	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
>  	     pp = &p->next) {
>  		if (p->key.port != port)
>  			continue;
>  
> -		if (err)
> +		if (err) {
> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD_FAILED))
> +				failed_changed = true;
>  			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
> -		else
> +		} else {
> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD))
> +				offload_changed = true;
>  			p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +		}
> +
> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE ||
> +		    (!offload_changed && !failed_changed))
> +			continue;
> +
> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY &&
> +		    !failed_changed)
> +			continue;
> +
> +		br_mdb_flag_change_notify(br->dev, mp, p);

This looks like a mess.. First you need to manage these flags properly as I wrote in my
other reply, they must be mutually exclusive and you can do this in a helper. Also
please read the old flags in the beginning, then check what flags changed, make a mask
what flags are for notifications (again can come from a helper, it can be generated when
the option changes so you don't compute it every time) and decide what to do if any of
those flags changed.
Note you have to keep proper flags state regardless of the notify option.

>  	}
>  out:
>  	spin_unlock_bh(&br->multicast_lock);


