Return-Path: <netdev+bounces-292903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHwqEQTeGGp1oQgAu9opvQ
	(envelope-from <netdev+bounces-292903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:29:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F095FBB4B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 437D63038BB6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119530AABE;
	Fri, 29 May 2026 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3hguSom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1ED3090CD
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780014593; cv=none; b=a+B8+fatcc9VgiQSeE87gEDcMzAft96KUQeobpib4Th158LMCZ3FLuhsx/xThAQYEj9OXdbAhT82OWzWBx2x9mmXTOe5f/7s65JP9zBEXydOuie3BrF/LXlJFGhgmm/C5B208GrMykj4wSRIj8TKI0qpYlOuKi4fdzgtdnff3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780014593; c=relaxed/simple;
	bh=bczb1v6vhKAgxoGNJdoMXhlnLTsIPUxIX9Knn87jfUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r58rkKOXXUBsBeFSLfCz4IP1LRfoTXNXw4GPNtcLef307Qo19rdE+KVnwkyqdbJGz8L6QPuZuCkGUfw0zrIBHKojYFBJhSlJABrXoVHPuqTmnC3XQoOjjeS49qLnzXSjjehAKJQCOjCevI0FKgaffNaLF8Ijp9bYqmGkugynGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3hguSom; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09371F000E9;
	Fri, 29 May 2026 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780014592;
	bh=nTv6X2yPDULiJ9NdBdHlc9DxvjgnN/QordNqxA6i/Z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D3hguSomdIBwrV+2mjLfD+9hug6i9wKkfSgZ2V8vOQRnb24gyE5/4Lx3mhMLRm1X2
	 jrCxwTJyMVRSiNA9hNNgWOKH6yDfVohwCHeYzvCf50nbVYXBVJFXQPHMJqS8igGiZh
	 Ys4mqmCH2Iy5Rosan4j0iHLWXlgNbLOdERtji7vouZSMLbvLC1YtKmyM7yIuSHkngG
	 7k4ongwd28NhcKjs2wNkZ2UPuGJQ17nZ9qbQSkMzLecHnETg6jck+DGQyoMn3o16Qg
	 mjqSpn7DA0GHm5xHlygtOc3mMt4mNwee9qi4XqyeMmXemvVxKj5YpbA04IMoAmQ1+s
	 gOnGQ79RzcmlQ==
Date: Thu, 28 May 2026 17:29:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 2/3] net: add retry mechanism to
 ndo_set_rx_mode_async
Message-ID: <20260528172950.0773d48f@kernel.org>
In-Reply-To: <20260527014117.1401809-3-sdf@fomichev.me>
References: <20260527014117.1401809-1-sdf@fomichev.me>
	<20260527014117.1401809-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292903-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rx_mode_retry_work.work:url]
X-Rspamd-Queue-Id: 96F095FBB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 18:41:16 -0700 Stanislav Fomichev wrote:
> When ndo_set_rx_mode_async returns an error, schedule a retry with
> exponential backoff (1s, 2s, 4s, 8s =E2=80=94 15s total). Give up after t=
he

Em-dash detected. Issuing a brown bag and initiating shaming procedures.

> 4th retry and log an error via netdev_err().
>=20
> This moves retry logic from individual drivers into the core stack.


> @@ -2327,6 +2329,8 @@ struct net_device {
>  	struct list_head	rx_mode_node;
>  	netdevice_tracker	rx_mode_tracker;
>  	struct netdev_hw_addr_list	rx_mode_addr_cache;
> +	struct delayed_work	rx_mode_retry_work;

Either replace the existing work or only add a timer?
Having two work structs feels odd.

> +	unsigned long		rx_mode_retry_delay;

int should be plenty bits for this.
Actually for clarity maybe it's better to keep a counter here?
easy enough to (base << dev->bla_retry_counter) at scheduling
time and that way we don't have to remember what the init value
should be. Retry counter resetting to 0 is quite obvious, and
so is the cap value.

>  #ifdef CONFIG_LOCKDEP
>  	unsigned char		nested_level;
>  #endif
> @@ -5150,6 +5154,7 @@ static inline void __dev_mc_unsync(struct net_devic=
e *dev,
> =20
>  /* Functions used for secondary unicast and multicast support */
>  void dev_set_rx_mode(struct net_device *dev);
> +void netif_rx_mode_schedule_retry(struct net_device *dev);
>  int netif_set_promiscuity(struct net_device *dev, int inc);
>  int dev_set_promiscuity(struct net_device *dev, int inc);
>  int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 26ac8eb9b259..751d6b5c4e23 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1775,6 +1775,8 @@ static void __dev_close_many(struct list_head *head)
>  		if (ops->ndo_stop)
>  			ops->ndo_stop(dev);
> =20
> +		netif_rx_mode_cancel_retry(dev);
> +
>  		netif_set_up(dev, false);
>  		netpoll_poll_enable(dev);
>  	}
> @@ -11720,6 +11722,8 @@ void netdev_run_todo(void)
>  			continue;
>  		}
> =20
> +		if (cancel_delayed_work_sync(&dev->rx_mode_retry_work))
> +			dev_put(dev);

trackers required these days
Perhaps you can avoid the reference if you use disable_.._sync() ?

>  		netdev_lock(dev);
>  		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
>  		netdev_unlock(dev);
> @@ -12100,8 +12104,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_pr=
iv, const char *name,
>  #endif
> =20
>  	mutex_init(&dev->lock);
> -	INIT_LIST_HEAD(&dev->rx_mode_node);
> -	__hw_addr_init(&dev->rx_mode_addr_cache);
> +	netif_rx_mode_init(dev);
> =20
>  	dev->priv_flags =3D IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
>  	setup(dev);
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 0cf24b8f5008..4352f39c8dfe 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -166,8 +166,10 @@ int dev_change_carrier(struct net_device *dev, bool =
new_carrier);
> =20
>  void __dev_set_rx_mode(struct net_device *dev);
>  int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify);
> +void netif_rx_mode_init(struct net_device *dev);
>  bool netif_rx_mode_clean(struct net_device *dev);
>  void netif_rx_mode_sync(struct net_device *dev);
> +void netif_rx_mode_cancel_retry(struct net_device *dev);
> =20
>  void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
>  			unsigned int gchanges, u32 portid,
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index d73fcb0c6785..c02aa05c9975 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -23,6 +23,24 @@ static LIST_HEAD(rx_mode_list);
>  static DEFINE_SPINLOCK(rx_mode_lock);
>  static DECLARE_WORK(rx_mode_work, netdev_rx_mode_work);
> =20
> +static void netif_rx_mode_queue(struct net_device *dev);

No fwd declarations please :/

> +static void netif_rx_mode_retry(struct work_struct *work)
> +{
> +	struct net_device *dev =3D container_of(work, struct net_device,
> +					      rx_mode_retry_work.work);
> +
> +	netif_rx_mode_queue(dev);
> +	dev_put(dev);
> +}
> +
> +void netif_rx_mode_init(struct net_device *dev)
> +{
> +	INIT_LIST_HEAD(&dev->rx_mode_node);
> +	__hw_addr_init(&dev->rx_mode_addr_cache);
> +	INIT_DELAYED_WORK(&dev->rx_mode_retry_work, netif_rx_mode_retry);
> +}
> +
>  /*
>   * General list handling functions
>   */
> @@ -1252,6 +1270,35 @@ static int netif_uc_promisc_update(struct net_devi=
ce *dev)
>  	return 0;
>  }
> =20
> +void netif_rx_mode_schedule_retry(struct net_device *dev)
> +{
> +	unsigned long delay;
> +
> +	/* Total retry budget: 1+2+4+8 =3D 15 seconds. */

What is the value of this comment..?

