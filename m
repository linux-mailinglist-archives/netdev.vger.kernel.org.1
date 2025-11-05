Return-Path: <netdev+bounces-235827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CFC362E6
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373A6428714
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E322258C;
	Wed,  5 Nov 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SD8AtOpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E923A9B3
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354000; cv=none; b=HQQWU6wtwg+6nbMB06tg8jDroM7xJ3A33uijVdXDKI1EIfhjh3WkvSZB7wt2s3ALrIwoex7FjsBmAN6CcnPReMcGdyBULILYDe0mXz1HcDm/8whpjPtuioiDa6E9Us80LENqK7p/q7Q0O60ONtMdbPSy9S8o2Svm8IpD7RVUb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354000; c=relaxed/simple;
	bh=2Tqjo6tPJ3bnTbDNERgrNCMZzYpINhxZgiXxehKno5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9YDkvt10BWSdkDCIh44gDWB4u2YBrowITU1KTlzZzQKkTQSqoiqtz9mNjUV0fFZat3W4D7QRnxpUa8TU0B8SJVihAlkUGlZfQGiooRUS8ZeO3jkItVsqpjsHH9CvDHhHKelS7Za6mcHsQCCgeswIrl0ONIMxBpk4qh+usFXtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SD8AtOpQ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b71397df721so566204966b.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762353996; x=1762958796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYU54pVHgt9qUY7dxhWeWsjfef8BqZGVuBv23xZnwLk=;
        b=SD8AtOpQ0/QvBXf8Y7256uieK91fDdQBMDccyq75+CuyGeR8nY1A08ZCoQWo2GyGYg
         FFRzs2V5XCg5RPRiFEBCvu+K5/ViAmxP6rjxe7CaN5FUKeyXq8pgVCIzXb6EudRBDj53
         hH8QYhkjHtkcR/+Z5Z3KzSuGTjUYxJTc8gMb+s4HAorbzWtDdz28ob6shHnt6pC7stoY
         SIA7q6Op8fRxwXQ6urJRkKuUEoNRDA38gIcJEZwvACvLJTaga5l5b2Y4zJfBEDuDK7ZD
         BXb2EISDKcgWyngrtKI6fODBcNORYAbC88zDh08K1O7Q3If2TORSKs7UNp6YonScriyA
         K/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353996; x=1762958796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYU54pVHgt9qUY7dxhWeWsjfef8BqZGVuBv23xZnwLk=;
        b=VctXO9ffdwCy7g0hg4WrfIxesuXJ0A5JtkUfBEdtEw8JX8Iyt8ei/wweeplWxAQGMc
         MH0B5R3/MYiQZZZvm3rI6S8xMBOlSbLS9WVrb4ur4J+yfFipLLXTX5RjrB070XMnf8kJ
         HXwFMa6jf20r3/+qtpei1U9mES7Zn3npX7rDkLJ9xOv1DALtAWUAzG8p2PGKhwaSJCkK
         l/R5Gl/wZdlhrd5jagsvK2NvW41z6YFKXUw1aT8iaOEpi64wjMq+jAPyfLOEKJWMfeWC
         MvnKAGgoYUlYGKUo7zV/j3hODOs2iePlECn6b3OcL3pD+E8Gtli7QK1gmr1yxOWLd6rB
         Bkxg==
X-Forwarded-Encrypted: i=1; AJvYcCUWULSF3v5vhLfsU1sqkTUDHepr7wHs652qvtwkfjYwS9L+nttpOeocqvpX/k/9KdahVq3R6WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjs/bqG/cJW4pREEsqfvEJlVZnRfUHJS4KjCZV0b3sQ2qJseEe
	qEE5eJmH3XXNLC6OyfUJjYgac6aHcxv/M9UNTgawgS6GQHlbzI06gYMZR/efc7ab9J0PpDSCCI1
	sUNGz0RwhnQ==
X-Gm-Gg: ASbGncvo8FjMZc9Vf1wTwTvUWmrRB8+GxZnBqXonDy0o9SSpnUZM4RqqUsjl8nCWtvJ
	43kwmedMkKLeARELQbHI69EHJ79czv1D3j4LO+L/fKE3bpEJxM1ETG/zDIWfY0d1mps0yRRErZ5
	Fut9j5awM9JXcywhuURZ8cKALSwrkyXSTBmrpicL2yq92qTU17h8jZvvCC31EbMq93canuSamBZ
	lH+O8SdlpwYuOPqHuzNiUcIEEfe0wxLxX6rHIwC7hhgEK2tbO8fmyI2Oo9H+xeT3P9n31PxP1wD
	zUu4csKbz0CeqzufGkbKAaB4MWs/8ZPY+2uk/l/Kjr3hdEY+vBFL9KK545t6Bn03lsk4ThWyFBA
	wWmqlp91pUs//lc28MvH8ph6mFq+sBik85n/w8BrpHYvGzppKtnoNrscaifd+YCeTDPBQvq37K0
	PfaWygx2gxlfnBvnpw66qqlW+dIUOQYQxDMfxWKv3sLeU=
X-Google-Smtp-Source: AGHT+IHXvCNjw5wkjwUOOlzqSkkaUW6zZQ8HcngE3x7IOidXPHs5fM9NqVHPnCmB7jCORkGZcHSgWA==
X-Received: by 2002:a17:907:1c0a:b0:b70:b077:b957 with SMTP id a640c23a62f3a-b726529e8a2mr328714466b.15.1762353995832;
        Wed, 05 Nov 2025 06:46:35 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm508268866b.54.2025.11.05.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 06:46:35 -0800 (PST)
Message-ID: <975f3126-482a-4963-a125-d51732ddcdac@blackwall.org>
Date: Wed, 5 Nov 2025 16:46:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: bonding: use atomic instead of
 rtnl_mutex, to make sure peer notify updated
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Hangbin Liu <liuhangbin@gmail.com>
References: <20251105142739.41833-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251105142739.41833-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 16:27, Tonghao Zhang wrote:
> Using atomic to protect the send_peer_notif instead of rtnl_mutex.
> This approach allows safe updates in both interrupt and process
> contexts, while avoiding code complexity.
> 
> In lacp mode, the rtnl might be locked, preventing ad_cond_set_peer_notif()
> from acquiring the lock and updating send_peer_notif. This patch addresses
> the issue by using a atomic. Since updating send_peer_notif does not
> require high real-time performance, such atomic updates are acceptable.
> 
> After coverting the rtnl lock for send_peer_notif to atomic, in bond_mii_monitor(),
> we should check the should_notify_peers (rtnllock required) instead of
> send_peer_notif. By the way, to avoid peer notify event loss, we check
> again whether to send peer notify, such as active-backup mode failover.
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
> Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> v3:
> - add the comment, *_dec_if_positive is safe.
> v2:
> - refine the codes
> - check bond_should_notify_peers again in bond_mii_monitor(), to avoid event loss.
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-1-tonghao@bamaicloud.com/
> ---
>  drivers/net/bonding/bond_3ad.c  |  7 ++---
>  drivers/net/bonding/bond_main.c | 47 ++++++++++++++++-----------------
>  include/net/bonding.h           |  9 ++++++-
>  3 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index 49717b7b82a2..05c573e45450 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -999,11 +999,8 @@ static void ad_cond_set_peer_notif(struct port *port)
>  {
>  	struct bonding *bond = port->slave->bond;
>  
> -	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
> -		bond->send_peer_notif = bond->params.num_peer_notif *
> -			max(1, bond->params.peer_notif_delay);
> -		rtnl_unlock();
> -	}
> +	if (bond->params.broadcast_neighbor)
> +		bond_peer_notify_reset(bond);
>  }
>  
>  /**
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 8e592f37c28b..4da92f3b129c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1167,10 +1167,11 @@ static bool bond_should_notify_peers(struct bonding *bond)
>  {
>  	struct bond_up_slave *usable;
>  	struct slave *slave = NULL;
> +	int send_peer_notif;
>  
> -	if (!bond->send_peer_notif ||
> -	    bond->send_peer_notif %
> -	    max(1, bond->params.peer_notif_delay) != 0 ||
> +	send_peer_notif = atomic_read(&bond->send_peer_notif);
> +	if (!send_peer_notif ||
> +	    send_peer_notif % max(1, bond->params.peer_notif_delay) != 0 ||
>  	    !netif_carrier_ok(bond->dev))
>  		return false;
>  
> @@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  						      BOND_SLAVE_NOTIFY_NOW);
>  
>  		if (new_active) {
> -			bool should_notify_peers = false;
> -
>  			bond_set_slave_active_flags(new_active,
>  						    BOND_SLAVE_NOTIFY_NOW);
>  
> @@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  						      old_active);
>  
>  			if (netif_running(bond->dev)) {
> -				bond->send_peer_notif =
> -					bond->params.num_peer_notif *
> -					max(1, bond->params.peer_notif_delay);
> -				should_notify_peers =
> -					bond_should_notify_peers(bond);
> +				bond_peer_notify_reset(bond);
> +
> +				if (bond_should_notify_peers(bond)) {
> +					atomic_dec(&bond->send_peer_notif);
> +					call_netdevice_notifiers(
> +							NETDEV_NOTIFY_PEERS,
> +							bond->dev);
> +				}
>  			}
>  
>  			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> -			if (should_notify_peers) {
> -				bond->send_peer_notif--;
> -				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> -							 bond->dev);
> -			}
>  		}
>  	}
>  
> @@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct work_struct *work)
>  
>  	rcu_read_unlock();
>  
> -	if (commit || bond->send_peer_notif) {
> +	if (commit || should_notify_peers) {
>  		/* Race avoidance with bond_close cancel of workqueue */
>  		if (!rtnl_trylock()) {
>  			delay = 1;
> @@ -2816,16 +2813,16 @@ static void bond_mii_monitor(struct work_struct *work)
>  			bond_miimon_commit(bond);
>  		}
>  
> -		if (bond->send_peer_notif) {
> -			bond->send_peer_notif--;
> -			if (should_notify_peers)
> -				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> -							 bond->dev);
> -		}
> +		/* check again to avoid send_peer_notif has been changed. */
> +		if (bond_should_notify_peers(bond))
> +			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>  
>  		rtnl_unlock();	/* might sleep, hold no other locks */
>  	}
>  
> +	/* this's safe to *_dec_if_positive, even when peer notify disabled. */
> +	atomic_dec_if_positive(&bond->send_peer_notif);
> +
>  re_arm:
>  	if (bond->params.miimon)
>  		queue_delayed_work(bond->wq, &bond->mii_work, delay);
> @@ -3773,7 +3770,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  			return;
>  
>  		if (should_notify_peers) {
> -			bond->send_peer_notif--;
> +			atomic_dec(&bond->send_peer_notif);

this can run in parallel with the active slave change and they both can
read the same send_peer_notif count and do an unconditional decrement
even though only one of them should, should_notify_peers is read outside
of the lock and can race with active slave change

>  			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>  						 bond->dev);
>  		}
> @@ -4267,6 +4264,8 @@ static int bond_open(struct net_device *bond_dev)
>  			queue_delayed_work(bond->wq, &bond->alb_work, 0);
>  	}
>  
> +	atomic_set(&bond->send_peer_notif, 0);
> +
>  	if (bond->params.miimon)  /* link check interval, in milliseconds. */
>  		queue_delayed_work(bond->wq, &bond->mii_work, 0);
>  
> @@ -4300,7 +4299,7 @@ static int bond_close(struct net_device *bond_dev)
>  	struct slave *slave;
>  
>  	bond_work_cancel_all(bond);
> -	bond->send_peer_notif = 0;
> +	atomic_set(&bond->send_peer_notif, 0);
>  	if (bond_is_lb(bond))
>  		bond_alb_deinitialize(bond);
>  	bond->recv_probe = NULL;
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 49edc7da0586..afdfcb5bfaf0 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -236,7 +236,7 @@ struct bonding {
>  	 */
>  	spinlock_t mode_lock;
>  	spinlock_t stats_lock;
> -	u32	 send_peer_notif;
> +	atomic_t send_peer_notif;
>  	u8       igmp_retrans;
>  #ifdef CONFIG_PROC_FS
>  	struct   proc_dir_entry *proc_entry;
> @@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
>  	return NET_XMIT_DROP;
>  }
>  
> +static inline void bond_peer_notify_reset(struct bonding *bond)
> +{
> +	atomic_set(&bond->send_peer_notif,
> +		bond->params.num_peer_notif *
> +		max(1, bond->params.peer_notif_delay));
> +}
> +
>  #endif /* _NET_BONDING_H */


