Return-Path: <netdev+bounces-248914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EED11383
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2296E30006C4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158013314D7;
	Mon, 12 Jan 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVyydRSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BB32936C
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206505; cv=none; b=TKFlYGsvi9ICgLEY0b39VJrPPnHkpjnwXSpPiSxEa6I6m38ezRac8Kb79FgPIut3m2scIaX3xVJy4RmY0OfOYwBZd2TBh+h00iO3cD1StYs+LXEf6sSxshV2wX7xrs1tMAUx8jAsdxIy/EmJSa7omGqVsBtlgg5S7S6E2XnQ0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206505; c=relaxed/simple;
	bh=ooZSqOSj94esrrGb8q6xVDQaPMjwp27FffzYZ7LGR10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THU7pQ8kCDYyrdpCP6DRlr/IDC0tOglSroL0SR9k/ySViFZ8O2oPhGFYXL6dWxS3p9CxK9gUIpk6uAIoLY5I4OcW33MzlvXFzL1cAyLnR0EPoMVXb4Jk/3InPfDwvaSy6OBd2jJGlALZU+VZ1M7Vku8DP1z1buiFnnn1FRlu7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVyydRSa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f39438187so692270b3a.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 00:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768206503; x=1768811303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEJAAthKMEmF9Me9rRW6UEKYauLTUXYjq5C5ENzryck=;
        b=DVyydRSar9gdAAn1LnWCFB6oddkmVTctjDO1xfLNE8Y5vBB/mHGOWdouulVhZ5adoV
         OiE+FkMGCWhsij9J5Y0UYmgzizA9/w3IeqzRNJgGnjQPN6ocGrDW/NiUZbpIA+139zdB
         Zx5Yu+5yCd99VqxCA4MAaaCjm7wac+n+IDPC7g10uG5zwPp5gLn11R+rQkDwjVzd6u1X
         qcI1wHvvhLU0JV0cUCzLWBwDFU912h6hZC2vAI2zDxHPI0nkzXimcd4NXSSOn/zUcgmc
         AfEqINv+1aH1AW3BQOjL+eQUChPYqhEH1AwjpAdk/H/9EL9PPtnI2C9q5GJV7Mz990cO
         +6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768206503; x=1768811303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEJAAthKMEmF9Me9rRW6UEKYauLTUXYjq5C5ENzryck=;
        b=hAoxsgcNe2HdwRLaSBVY+PvJQ4kIMBZyz2b+8UsK1/FHYZhyk72AA6QqO4xro/+ob3
         BOzz+B2bKfVSeLftiONpU3lEizSKz2hxrSCeTS8JI66IOwjTi5cKcPVYQnlaSGCtaQBo
         c3HhPUiPhIKfMZDglkhkIAaWSFzfKdH8gnUYo143TCAZAsiPsI7dkM77TOQG3AJ1hTOf
         18cBiisWv2lRbtrQrPgigAigskG3/QM2iiYTWRe3rz+/DVO1coE8yB3w4+tmSHtJxKL+
         upPHvM31SQ0eaz4764dm1nP6/ssM6ibkb/TYbH+f0kxVoS+Y+6qFhaO3lvkz0Ubsm2+M
         7cIA==
X-Gm-Message-State: AOJu0YyseF0soEcnP+6O9YPkhnfLWU0c4g5a0BU1SV2gHnZBD6Z8SESf
	AptYrCIzvsL/D3Nqb5+ePtl8sraK7z6HIOiNCsx5IV61KeN0m6cdbdmp
X-Gm-Gg: AY/fxX4EZ5dmZjSE/kn+x1+0K32Liha6sZsGIw7Kmdg+3NEsLjgjhA0FQupRvfHrWXA
	zSLqwmI4CPRqm7WWG7RPc7I0nHSYz9iSMRZrnkbaTELkbNuCGrOMm0j95WrDxqfGNUDBbkgYbT1
	R36ZJUU4whsCbs0AQSuyZfQcPfA3NHVlteaEjP76MCJ8TDy4XNcYzhPc8H21hIimOjMS5lz23df
	peo7zxxuz+ey5oqWPMj/bx872qMrF0akuuElda43Csrv+tEdqQCCewfOSyKbJMU+bkR+xwmHJSw
	fq+aTPCIYG2kdxLr4xvvSON6AkDFSOIFunYppqEHLgBCWs1rNxaeJ1HB/7bieN1Pf5G4u9XR/Fm
	47xkEugrETPQb5VgLCaz9zDTAJgBsEUvdcHG3Xy8WtbcmuNTB63M8r4aohjJSLWUahlJdKqNwFJ
	onTVpOHLbGZKZqK+9ncm9oxo4+Sw==
X-Google-Smtp-Source: AGHT+IHhPRfrv5cI7BcexGMpilPBdanM01rLKaX1a5tFqLu5MPYYzb2NtSxLH8EKJqF4Cgbt9fE3yQ==
X-Received: by 2002:a05:6a20:a11e:b0:366:14af:9bbd with SMTP id adf61e73a8af0-3898fa11762mr16132142637.71.1768206502720;
        Mon, 12 Jan 2026 00:28:22 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d2932bsm17486521a12.21.2026.01.12.00.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:28:21 -0800 (PST)
Date: Mon, 12 Jan 2026 08:28:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH RESEND net-next v4 1/4] net: bonding: use workqueue to
 make sure peer notify updated in lacp mode
Message-ID: <aWSwnz8XieyG7FUB@fedora>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
 <895aa5609ef5be99150b4f3579ac0aa96ed083a7.1768184929.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895aa5609ef5be99150b4f3579ac0aa96ed083a7.1768184929.git.tonghao@bamaicloud.com>

On Mon, Jan 12, 2026 at 10:40:48AM +0800, Tonghao Zhang wrote:
> The rtnl lock might be locked, preventing ad_cond_set_peer_notif() from
> acquiring the lock and updating send_peer_notif. This patch addresses
> the issue by using a workqueue. Since updating send_peer_notif does
> not require high real-time performance, such delayed updates are entirely
> acceptable.
> 
> In fact, checking this value and using it in multiple places, all operations
> are protected at the same time by rtnl lock, such as
> - read send_peer_notif
> - send_peer_notif--
> - bond_should_notify_peers
> 
> By the way, rtnl lock is still required, when accessing bond.params.* for
> updating send_peer_notif. In lacp mode, resetting send_peer_notif in
> workqueue is safe, simple and effective way.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> v4:
> - keep the netdevice notifier order.
> v2/3:
> - no change
> v1:
> - This patch is actually version v3, https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/
> - add a comment why we use the trylock.
> - add this patch to series
> ---
>  drivers/net/bonding/bond_3ad.c  |  7 ++--
>  drivers/net/bonding/bond_main.c | 57 +++++++++++++++++++++++++--------
>  include/net/bonding.h           |  2 ++
>  3 files changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index 1a8de2bf8655..01ae0269a138 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1008,11 +1008,8 @@ static void ad_cond_set_peer_notif(struct port *port)
>  {
>  	struct bonding *bond = port->slave->bond;
>  
> -	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
> -		bond->send_peer_notif = bond->params.num_peer_notif *
> -			max(1, bond->params.peer_notif_delay);
> -		rtnl_unlock();
> -	}
> +	if (bond->params.broadcast_neighbor)
> +		bond_peer_notify_work_rearm(bond, 0);
>  }
>  
>  /**
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 3d56339a8a10..edf6dac8a98f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1195,6 +1195,35 @@ static bool bond_should_notify_peers(struct bonding *bond)
>  	return true;
>  }
>  
> +/* Use this to update send_peer_notif when RTNL may be held in other places. */
> +void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay)
> +{
> +	queue_delayed_work(bond->wq, &bond->peer_notify_work, delay);
> +}
> +
> +/* Peer notify update handler. Holds only RTNL */
> +static void bond_peer_notify_reset(struct bonding *bond)
> +{
> +	bond->send_peer_notif = bond->params.num_peer_notif *
> +		max(1, bond->params.peer_notif_delay);
> +}
> +
> +static void bond_peer_notify_handler(struct work_struct *work)
> +{
> +	struct bonding *bond = container_of(work, struct bonding,
> +					    peer_notify_work.work);
> +
> +	if (!rtnl_trylock()) {
> +		bond_peer_notify_work_rearm(bond, 1);
> +		return;
> +	}
> +
> +	bond_peer_notify_reset(bond);
> +
> +	rtnl_unlock();
> +	return;
> +}
> +
>  /**
>   * bond_change_active_slave - change the active slave into the specified one
>   * @bond: our bonding struct
> @@ -1270,8 +1299,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  						      BOND_SLAVE_NOTIFY_NOW);
>  
>  		if (new_active) {
> -			bool should_notify_peers = false;
> -
>  			bond_set_slave_active_flags(new_active,
>  						    BOND_SLAVE_NOTIFY_NOW);
>  
> @@ -1279,19 +1306,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  				bond_do_fail_over_mac(bond, new_active,
>  						      old_active);
>  
> +			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> +
>  			if (netif_running(bond->dev)) {
> -				bond->send_peer_notif =
> -					bond->params.num_peer_notif *
> -					max(1, bond->params.peer_notif_delay);
> -				should_notify_peers =
> -					bond_should_notify_peers(bond);
> -			}
> +				bond_peer_notify_reset(bond);
>  
> -			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> -			if (should_notify_peers) {
> -				bond->send_peer_notif--;
> -				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> -							 bond->dev);
> +				if (bond_should_notify_peers(bond)) {
> +					bond->send_peer_notif--;
> +					call_netdevice_notifiers(
> +							NETDEV_NOTIFY_PEERS,
> +							bond->dev);
> +				}
>  			}
>  		}
>  	}
> @@ -4213,6 +4238,10 @@ static u32 bond_xmit_hash_xdp(struct bonding *bond, struct xdp_buff *xdp)
>  
>  void bond_work_init_all(struct bonding *bond)
>  {
> +	/* ndo_stop, bond_close() will try to flush the work under
> +	 * the rtnl lock. The workqueue must not block on rtnl lock
> +	 * to avoid deadlock.
> +	 */
>  	INIT_DELAYED_WORK(&bond->mcast_work,
>  			  bond_resend_igmp_join_requests_delayed);
>  	INIT_DELAYED_WORK(&bond->alb_work, bond_alb_monitor);
> @@ -4220,6 +4249,7 @@ void bond_work_init_all(struct bonding *bond)
>  	INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
>  	INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
>  	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
> +	INIT_DELAYED_WORK(&bond->peer_notify_work, bond_peer_notify_handler);
>  }
>  
>  void bond_work_cancel_all(struct bonding *bond)
> @@ -4230,6 +4260,7 @@ void bond_work_cancel_all(struct bonding *bond)
>  	cancel_delayed_work_sync(&bond->ad_work);
>  	cancel_delayed_work_sync(&bond->mcast_work);
>  	cancel_delayed_work_sync(&bond->slave_arr_work);
> +	cancel_delayed_work_sync(&bond->peer_notify_work);
>  }
>  
>  static int bond_open(struct net_device *bond_dev)
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 49edc7da0586..63d08056a4a4 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -254,6 +254,7 @@ struct bonding {
>  	struct   delayed_work ad_work;
>  	struct   delayed_work mcast_work;
>  	struct   delayed_work slave_arr_work;
> +	struct   delayed_work peer_notify_work;
>  #ifdef CONFIG_DEBUG_FS
>  	/* debugging support via debugfs */
>  	struct	 dentry *debug_dir;
> @@ -709,6 +710,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
>  					      int level);
>  int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
>  void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
> +void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay);
>  void bond_work_init_all(struct bonding *bond);
>  void bond_work_cancel_all(struct bonding *bond);
>  
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

