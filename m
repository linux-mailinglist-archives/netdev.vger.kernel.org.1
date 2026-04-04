Return-Path: <netdev+bounces-275299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDA7BfdV0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:06:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFE839930F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7724F300C037
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B726433B3;
	Sat,  4 Apr 2026 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmCjtYsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F617BA2
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261167; cv=none; b=Gqpags6hD/wKPUyi4zN328M7sBktpbftDT58XICDl5TgCYKsRRlb9CgKt1i85lPB7NKzlEP0spNjL86o/hTtFCf8Dn8nqgcneo3c+dKuCXyN8Ku4taha7+FKqYhvMKy9bFKUIeWfHVhcnTbNE9B8DuFPcL4dfLvW7tIZgn/hSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261167; c=relaxed/simple;
	bh=tPzGmmgl6CpXSsxzQzv0fjvDzFDFCpGXYw2PpDa9CpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWWoNbnNEEz/PAELBEJS7KWDcVnHkxI2x4gsMsksg15dvtWbSmYtuSmsErrIp3rQ6YR5H1C4AARXhHb8w2GQoKBwGx1CyZtuTK9LWj4qj7Ucv22WHHF1+ndY2fDhvLFkXM2kDGxkEUMn4us3tzemlzpS3AJ8XjasbwhtOObPNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmCjtYsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E120C4CEF7;
	Sat,  4 Apr 2026 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261167;
	bh=tPzGmmgl6CpXSsxzQzv0fjvDzFDFCpGXYw2PpDa9CpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmCjtYsFwLiQTrq+acnmtyZVe1im1mtQzcuBA3DbPhWOqvKZ7DHg56gYkRyN2Sg9+
	 401ZxQLQ4S/x4eVHaaxgVcE71WdLtUh8caOvkmxTYnRp+d6X4CukRjqLbtmlIPgNq9
	 E/4pQs9REdecVceK5Jy+nbsTgVQrOOdXg/2Lr7XG9Ela4SEEV3C9FABavAN1PQwDa7
	 dMe1qlyix6LBbBJcYbb8k38gbEXWpQO93LrFgv+ixWzX9reChEDVfJR5w1yS/y1mHs
	 RUvVh9c6mPRbQ2leG+srGkDTRZBk5MGNK5mdxTxAGIwcYEXjgxlxM3g8+e3SUSDBLa
	 I+ELBQNxHB9MA==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 03/14] net: move promiscuity handling into netdev_rx_mode_work
Date: Fri,  3 Apr 2026 17:06:06 -0700
Message-ID: <20260404000606.2413916-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-4-sdf@fomichev.me>
References: <20260402225535.4124525-4-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275299-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAFE839930F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: move promiscuity handling into netdev_rx_mode_work

This commit moves unicast promiscuity tracking into netdev_rx_mode_work so
it runs under netdev_ops_lock instead of the addr_lock spinlock. It also
changes ASSERT_RTNL() to netdev_ops_assert_locked() in several functions
called from the work queue.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0efac0c730077..08dac9c759996 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9586,7 +9586,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
>  	kuid_t uid;
>  	kgid_t gid;
>  
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);

Can this cause a lockdep assertion failure for unconverted ops-locked devices
using the legacy RX mode path?

Replacing ASSERT_RTNL() with netdev_ops_assert_locked(dev) asserts that
dev->lock is held for devices where netdev_need_ops_lock(dev) is true.

[ ... ]

> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index a05db3ac43ea9..61589537b2d3d 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
[ ... ]
> @@ -1295,20 +1337,16 @@ void __dev_set_rx_mode(struct net_device *dev)
>  	if (!netif_device_present(dev))
>  		return;
>  
> -	if (ops->ndo_set_rx_mode_async) {
> +	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
>  		netif_rx_mode_queue(dev);
>  		return;
>  	}
>  
> -	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
> -		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
> -			__dev_set_promiscuity(dev, 1, false);
> -			dev->uc_promisc = true;
> -		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
> -			__dev_set_promiscuity(dev, -1, false);
> -			dev->uc_promisc = false;
> -		}
> -	}
> +	/* Legacy path for non-ops-locked HW devices. */
> +
> +	promisc_inc = netif_uc_promisc_update(dev);
> +	if (promisc_inc)
> +		__dev_set_promiscuity(dev, promisc_inc, false);

If an ops-locked device has not yet been converted to implement the new
ndo_set_rx_mode_async or ndo_change_rx_flags callbacks, this legacy path
will be executed.

When a secondary unicast address is added to such a device (e.g., by
bringing up a macvlan interface over it) and the device lacks
IFF_UNICAST_FLT, netif_uc_promisc_update() returns 1. This triggers a
synchronous inline call to __dev_set_promiscuity(dev, 1, false).

Since __dev_set_rx_mode() is invoked from address list helpers like
dev_uc_add() which only hold rtnl_lock() and netif_addr_lock_bh(dev),
dev->lock is not held, which would trigger the new assertion in
__dev_set_promiscuity().

