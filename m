Return-Path: <netdev+bounces-275298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOw0KCFW0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:06:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA839932F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003EB306777E
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD8883F;
	Sat,  4 Apr 2026 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2u176yn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB8256D
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261166; cv=none; b=BITvprNRwQfAptZUcl3OTR6KgfGXTZSKyh5viKxzLLt+6U0NVBQ0aEukdNg1tO0LYG9GhdLprP79VK4IlUdNTRnEUjW8C1Hm6wc0aSK41KiXD0g7fGuec7oPtQhdsIyUG/iQPLib1zXuCsefas4OOiY5nj0g/qKL8QdeqRY3cj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261166; c=relaxed/simple;
	bh=bxelPIZ8UlPj42apf8jGh6TgMpyzpGJkj+dQBBRV3tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZscReXw/rxtB2jTEcS4QJCEx8kolm3RDljIZWQA1Qv0eZfEfanDnQrzkys3wLskFdKHjnEX2StDQP8TPihaXpx1aLS28/awB70HJziHPRKTk6PbLrbbVyA5JFcrY3Ohj265vH1YP7Oo2FVS9tFdXgz8rAg5nzWN1urOBIPaJ/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2u176yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9106C19424;
	Sat,  4 Apr 2026 00:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261166;
	bh=bxelPIZ8UlPj42apf8jGh6TgMpyzpGJkj+dQBBRV3tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2u176ynbwUyTv1kmnxXJ4XVbQmF+QQTyd+Q+UgllK9tEUZ2ZFvQdSetncMLcxwHe
	 UwxDCW5jFYmu3O3jXmd6WCj/+Ulj/CeA4ScnaXOzLrg+WVPO6g2I8RMAriqUsCADOD
	 6z6+rRk7g2rBO4V5ktSA/+CoaUzf5vJuib19x2TsNGeOzj3f4mejF3U57sirAED4wr
	 fNnvQMjdmNKz59OePCXf/LSUs4j8D1M19Cxrpon8UeJIUpb6G2gfni44CKIWHEM++Y
	 qhmTug5mJ8xE8xfThslF6fEi4OlVli2NQfQzYAzx34ofDwwZ+9vGlDPk7JYhl3kSOd
	 IBB62yn2zS9FQ==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 02/14] net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
Date: Fri,  3 Apr 2026 17:06:04 -0700
Message-ID: <20260404000604.2413879-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-3-sdf@fomichev.me>
References: <20260402225535.4124525-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275298-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AEA839932F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work

This commit introduces an async variant of ndo_set_rx_mode that runs from a
workqueue, allowing drivers to sleep during RX mode changes. It also adds
netif_rx_mode_sync() to opportunistically flush pending updates before
returning to userspace.

> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -12217,6 +12178,9 @@ void free_netdev(struct net_device *dev)
>  
>  	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
>  
> +	if (netif_rx_mode_clean(dev))
> +		dev_put(dev);
> +
>  	/* Flush device addresses */
>  	dev_addr_flush(dev);

Is this cleanup reachable during normal shutdown?

When a device is queued to rx_mode_list, netif_rx_mode_queue() elevates its
reference count via dev_hold(). During unregistration, netdev_wait_allrefs()
blocks the system until all references are dropped.

Because of this wait, the system shouldn't be able to reach free_netdev()
until the worker thread has already dequeued the device and called
dev_put(). It seems the device is guaranteed to not be on the list by the
time this code executes.

> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
[ ... ]
> +static void netdev_rx_mode_work(struct work_struct *work)
> +{
> +	struct net_device *dev;
> +
> +	rtnl_lock();
> +
> +	while (true) {
> +		spin_lock_bh(&rx_mode_lock);
> +		if (list_empty(&rx_mode_list)) {
> +			spin_unlock_bh(&rx_mode_lock);
> +			break;
> +		}
> +		dev = list_first_entry(&rx_mode_list, struct net_device,
> +				       rx_mode_node);
> +		list_del_init(&dev->rx_mode_node);
> +		spin_unlock_bh(&rx_mode_lock);
> +
> +		netdev_lock_ops(dev);

Can this while loop starve the system of the rtnl lock?

Since userspace can trigger RX mode updates via ioctls like SIOCADDMULTI
while holding only netdev_lock_ops() and not the rtnl lock, a continuous
stream of these operations could repeatedly add devices to rx_mode_list.

Because the loop releases rx_mode_lock while processing but retains the rtnl
lock, could it run indefinitely if the list is continually replenished?

Additionally, does the order of list_del_init() and netdev_lock_ops() create
a race condition with netif_rx_mode_sync()?

If the worker thread dequeues the device and drops the spinlock, it might
then block waiting for netdev_lock_ops(). Meanwhile, an ioctl thread
holding netdev_lock_ops() might call netif_rx_mode_sync().

The ioctl thread would call netif_rx_mode_clean(), which checks
list_empty(). Since the worker already removed the device from the list,
clean returns false. This causes netif_rx_mode_sync() to act as a no-op,
allowing the ioctl to return to userspace before the hardware update
actually completes.

> --- a/net/core/dev_api.c
> +++ b/net/core/dev_api.c
[ ... ]
> @@ -311,6 +313,7 @@ int dev_set_allmulti(struct net_device *dev, int inc)
>  
>  	netdev_lock_ops(dev);
>  	ret = netif_set_allmulti(dev, inc, true);
> +	netif_rx_mode_sync(dev);
>  	netdev_unlock_ops(dev);
>  
>  	return ret;

Does this correctly handle cascaded updates for stacked devices?

When operating on a stacked device like a VLAN, the RX mode update cascades
to the underlying physical device, queuing the physical device to the
rx_mode_list via __dev_set_rx_mode().

Since netif_rx_mode_sync() is only called on the stacked device here, and
the stacked device itself is not on the rx_mode_list, will the physical
device's update be left on the workqueue? This seems to bypass the
synchronous update guarantee.

