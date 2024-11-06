Return-Path: <netdev+bounces-142320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42689BE434
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E69282AB2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48F1DDC0F;
	Wed,  6 Nov 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kJt6j3QX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65A1DC194
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888717; cv=none; b=p1beoxero2r/0O3hEb/lG5++dMKBoIGDR0S2A++7oApFNVO4eQ9tXC9jmlFa/TdeLimQFOa0gObRXjz3nn6QCd7kxp8IElKh0No7+oL3GkNKgDQPPWfkZSvDX4UsLoyNPttWW5GneOgCzvRIVd0YIJIz0D0NQiP8sHKBIQOcKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888717; c=relaxed/simple;
	bh=5HnnNqZjoSEJAQY2+ATkebNl1+NMEorVjL3dvK08LHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQyjBzjZT1RR6ydksyHIKkksu7qd3J6ShaYVqop+njPd24nyj4UVlCa2cC+yF+367E06fX9rGOp0fkIge7DsZt17w8qG9ZW+4wRiWiDHxgfzZ3+pLzTbKLrkYnnSgH3H8RIjcbp7xYywMSXuS6k1Hsv/2YPFi274bjF0/ZYrT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kJt6j3QX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5111747cso61740101fa.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730888713; x=1731493513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p9H6e0NhMpNMmgMkwFkXI6PMXLYPm3wg/AegrvOJXKQ=;
        b=kJt6j3QXTZ2eK/7eri4jVc3T8ir3aMUd5+/LOpjpPHYEi5K9uUz8GrV1X7XeNJx6Y9
         cLVSn9906tRtUpoqiOxOHGnq416kI0nti1f5OJwovZu4aer4iDGdms+jknXSInuycCDt
         XjfrDmsdOb+iuv6EIOAsCdvEWv641swuqM2TdgyEszONSlFdJL9o80zn5991N1hKX5hK
         yYzyFB2CWCJaL/8euDNgiStDeahlxs968FUMKy0ZQZ8nAyBZYo51riMHKlgjaUZE9Gw1
         Q9cWDkTK03HpuAUxTxxCo2YV22qDJSfIl2YmoeU6HOzA1AbzD2/SHl7AcFw9kvW8Vg2h
         h3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730888713; x=1731493513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9H6e0NhMpNMmgMkwFkXI6PMXLYPm3wg/AegrvOJXKQ=;
        b=qdEt2wHQoZkAh2jQL+0ESg6fn1CPBFYPMEPHmEEY0SyhhfZg/TgaC8iCKqa18Tzgel
         YAEWjqRXOAjxV77R9pZPbAio6NLx4Df+DS2BdpP6hYDc8NB3uP0iO1FeqoPKqFO1Ki2n
         SXF91CTQRKcgbhPmuI+XqXdw1qombJ47dRZA6XQfhqozU2nVpcMAEByl5mdy5Zf6C1kd
         mT9gZnVd5G01ryXeihECGeofI8HzhWX6nKnJ+JI7PuWEOigeXKPJaymgrGaxrH+FqYLe
         xFgbuBzdASBtQXOucxHKlBC8kv4TLPqYiGAqESWYjdO91VX0G2lPG3Jj8GfUmY+Sh+Xq
         Ta/A==
X-Gm-Message-State: AOJu0YwtNf3U1C1O661Mf3pv2tVhPYg2+g+K62DpNxHfqNXC0zQe60p2
	d1juDM60fLiAf30EMd2EQz/lgSaINW9NcTVRci3l/+sHXYjOr6ti5k5hjPE1wOY=
X-Google-Smtp-Source: AGHT+IGZewlRADb9VfQACb+zhgiz79AwjWpXJxvk19az1FyOaB3aPz5v9BegvRT9obfudbdrqyqR/Q==
X-Received: by 2002:a2e:be07:0:b0:2f7:58bc:f497 with SMTP id 38308e7fff4ca-2fdecbf7205mr108468391fa.28.1730888713250;
        Wed, 06 Nov 2024 02:25:13 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3b7243sm24298321fa.23.2024.11.06.02.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:25:12 -0800 (PST)
Date: Wed, 6 Nov 2024 12:25:10 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 1/2] bonding: add ns target multicast address to
 slave device
Message-ID: <ZytEBmPmqHwfCIzo@penguin>
References: <20241106051442.75177-1-liuhangbin@gmail.com>
 <20241106051442.75177-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106051442.75177-2-liuhangbin@gmail.com>

On Wed, Nov 06, 2024 at 05:14:41AM +0000, Hangbin Liu wrote:
> Commit 4598380f9c54 ("bonding: fix ns validation on backup slaves")
> tried to resolve the issue where backup slaves couldn't be brought up when
> receiving IPv6 Neighbor Solicitation (NS) messages. However, this fix only
> worked for drivers that receive all multicast messages, such as the veth
> interface.
> 
> For standard drivers, the NS multicast message is silently dropped because
> the slave device is not a member of the NS target multicast group.
> 
> To address this, we need to make the slave device join the NS target
> multicast group, ensuring it can receive these IPv6 NS messages to validate
> the slave’s status properly.
> 
> There are three policies before joining the multicast group:
> 1. All settings must be under active-backup mode (alb and tlb do not support
>    arp_validate), with backup slaves and slaves supporting multicast.
> 2. We can add or remove multicast groups when arp_validate changes.
> 3. Other operations, such as enslaving, releasing, or setting NS targets,
>    need to be guarded by arp_validate.
> 
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c    | 18 ++++++-
>  drivers/net/bonding/bond_options.c | 85 +++++++++++++++++++++++++++++-
>  include/net/bond_options.h         |  1 +
>  3 files changed, 102 insertions(+), 2 deletions(-)
> 

Hi,
A few minor comments below,

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b1bffd8e9a95..d7c1016619f9 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1008,6 +1008,9 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
>  
>  		if (bond->dev->flags & IFF_UP)
>  			bond_hw_addr_flush(bond->dev, old_active->dev);
> +
> +		/* add target NS maddrs for backup slave */

So instead of having these redundant comments, maybe add helper functions
to show better what's happening, e.g. slave_ns_maddrs_add()...

> +		slave_set_ns_maddrs(bond, old_active, true);
>  	}
>  
>  	if (new_active) {
> @@ -1024,6 +1027,9 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
>  			dev_mc_sync(new_active->dev, bond->dev);
>  			netif_addr_unlock_bh(bond->dev);
>  		}
> +
> +		/* clear target NS maddrs for active slave */
> +		slave_set_ns_maddrs(bond, new_active, false);

... same here slave_ns_maddrs_del()

These true/false arguments for add/del require the reader to go search what
they mean.

>  	}
>  }
>  
> @@ -2341,6 +2347,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	bond_compute_features(bond);
>  	bond_set_carrier(bond);
>  
> +	/* set target NS maddrs for new slave, need to be called before
> +	 * bond_select_active_slave(), which will remove the maddr if
> +	 * the slave is selected as active slave
> +	 */

"needs to be called...which will remove the maddr*s*"

> +	slave_set_ns_maddrs(bond, new_slave, true);
> +
>  	if (bond_uses_primary(bond)) {
>  		block_netpoll_tx();
>  		bond_select_active_slave(bond);
> @@ -2350,7 +2362,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	if (bond_mode_can_use_xmit_hash(bond))
>  		bond_update_slave_arr(bond, NULL);
>  
> -
>  	if (!slave_dev->netdev_ops->ndo_bpf ||
>  	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
>  		if (bond->xdp_prog) {
> @@ -2548,6 +2559,11 @@ static int __bond_release_one(struct net_device *bond_dev,
>  	if (oldcurrent == slave)
>  		bond_change_active_slave(bond, NULL);
>  
> +	/* clear target NS maddrs, must after bond_change_active_slave()
> +	 * as we need to clear the maddrs on backup slave
> +	 */

This should be re-worded. I think there's a word missing as well in
"...must after...".

> +	slave_set_ns_maddrs(bond, slave, false);
> +
>  	if (bond_is_lb(bond)) {
>  		/* Must be called only after the slave has been
>  		 * detached from the list and the curr_active_slave
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 95d59a18c022..60368cef2704 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -15,6 +15,7 @@
>  #include <linux/sched/signal.h>
>  
>  #include <net/bonding.h>
> +#include <net/ndisc.h>
>  
>  static int bond_option_active_slave_set(struct bonding *bond,
>  					const struct bond_opt_value *newval);
> @@ -1234,6 +1235,64 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
>  }
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> +static bool slave_can_set_ns_maddr(struct bonding *bond, struct slave *slave)

const bond/slave

> +{
> +	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> +	       !bond_is_active_slave(slave) &&
> +	       slave->dev->flags & IFF_MULTICAST;
> +}
> +
> +static void _slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)

Can we please stick to using double underscore for internal helpers?
I see there are a few other places where a single underscore is used in this
file which I've missed before, we can take care of those to make them consistent
with the rest of the bonding code.

> +{
> +	struct in6_addr *targets = bond->params.ns_targets;
> +	char slot_maddr[MAX_ADDR_LEN];
> +	int i;
> +
> +	if (!slave_can_set_ns_maddr(bond, slave))
> +		return;
> +
> +	for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
> +		if (ipv6_addr_any(&targets[i]))
> +			break;
> +
> +		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
> +			if (add)
> +				dev_mc_add(slave->dev, slot_maddr);
> +			else
> +				dev_mc_del(slave->dev, slot_maddr);
> +		}
> +	}
> +}
> +
> +void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)

Usually exported slave functions have the bond_ prefix, e.g. bond_slave...

> +{
> +	if (!bond->params.arp_validate)
> +		return;
> +
> +	_slave_set_ns_maddrs(bond, slave, add);
> +}
> +
> +static void slave_set_ns_maddr(struct bonding *bond, struct slave *slave,
> +			       struct in6_addr *target, struct in6_addr *slot)

> +{
> +	char target_maddr[MAX_ADDR_LEN], slot_maddr[MAX_ADDR_LEN];
> +
> +	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
> +		return;
> +
> +	/* remove the previous maddr on salve */

s/salve/slave/
s/on/from/

> +	if (!ipv6_addr_any(slot) &&
> +	    !ndisc_mc_map(slot, slot_maddr, slave->dev, 0)) {
> +		dev_mc_del(slave->dev, slot_maddr);
> +	}

drop unnecessary {}

> +
> +	/* add new maddr on slave if target is set */
> +	if (!ipv6_addr_any(target) &&
> +	    !ndisc_mc_map(target, target_maddr, slave->dev, 0)) {
> +		dev_mc_add(slave->dev, target_maddr);
> +	}

drop unnesecary {}

> +}
> +
>  static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
>  					    struct in6_addr *target,
>  					    unsigned long last_rx)
> @@ -1243,8 +1302,10 @@ static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
>  	struct slave *slave;
>  
>  	if (slot >= 0 && slot < BOND_MAX_NS_TARGETS) {
> -		bond_for_each_slave(bond, slave, iter)
> +		bond_for_each_slave(bond, slave, iter) {
>  			slave->target_last_arp_rx[slot] = last_rx;
> +			slave_set_ns_maddr(bond, slave, target, &targets[slot]);
> +		}
>  		targets[slot] = *target;
>  	}
>  }
> @@ -1296,15 +1357,37 @@ static int bond_option_ns_ip6_targets_set(struct bonding *bond,
>  {
>  	return -EPERM;
>  }
> +
> +static void _slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
> +{
> +}
> +
> +void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
> +{
> +}
>  #endif
>  
>  static int bond_option_arp_validate_set(struct bonding *bond,
>  					const struct bond_opt_value *newval)
>  {
> +	bool changed = (bond->params.arp_validate == 0 && newval->value != 0) ||
> +		       (bond->params.arp_validate != 0 && newval->value == 0);

!!bond->params.arp_validate != !!newval->value

> +	struct list_head *iter;
> +	struct slave *slave;
> +
>  	netdev_dbg(bond->dev, "Setting arp_validate to %s (%llu)\n",
>  		   newval->string, newval->value);
>  	bond->params.arp_validate = newval->value;
>  
> +	if (changed) {
> +		bond_for_each_slave(bond, slave, iter) {
> +			if (bond->params.arp_validate)
> +				_slave_set_ns_maddrs(bond, slave, true);
> +			else
> +				_slave_set_ns_maddrs(bond, slave, false);
> +		}
> +	}

This block can be written shortly as:
 bond_for_each_slave(bond, slave, iter)
	_slave_set_ns_maddrs(bond, slave, !!bond->params.arp_validate);

> +
>  	return 0;
>  }
>  
> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> index 473a0147769e..59a91d12cd57 100644
> --- a/include/net/bond_options.h
> +++ b/include/net/bond_options.h
> @@ -161,5 +161,6 @@ void bond_option_arp_ip_targets_clear(struct bonding *bond);
>  #if IS_ENABLED(CONFIG_IPV6)
>  void bond_option_ns_ip6_targets_clear(struct bonding *bond);
>  #endif
> +void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add);
>  
>  #endif /* _NET_BOND_OPTIONS_H */
> -- 
> 2.46.0
> 

Cheers,
 Nik

