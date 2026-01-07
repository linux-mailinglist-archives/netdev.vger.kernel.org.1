Return-Path: <netdev+bounces-247888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D004D00334
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B9230334C2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9763346A5;
	Wed,  7 Jan 2026 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Ya1QXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010923D7F5;
	Wed,  7 Jan 2026 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821870; cv=none; b=qoUbqKdrH4cveESZ5sHlq3qXe7FtXJsXr77F4VWxI4Zw1r4rFxrM/XiNv9Xqr/kv5BdXFlaFNT2Vnyyozp/IKSghux8s6Pbms+9IRf8haJOkPEL92xIDYqSnyRFWSDaLPV4MpSd8isGoWKsBQB8iIXPL29Y/49kJWXsMzS0nhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821870; c=relaxed/simple;
	bh=eW8QlCnKijLeajenot+m4qNSxAfj9t/rpWE2bThsc5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWAYov7CSyXRzhKBZ2Ts8QUWVtmZ+Ssr3ZG2NP/g6Ydoa6ipQ8jdgKsDU21AE3oHBhJjqXL0aLKleAkzD7WvJNOxcK6Za6Y2SuTqA3Ih7vVpSpS4OUgSVZ9rdI4kHCXydfHjcJ4i4UgttnL2FZhCaPxsrqfFIB1PDQl/+cPk52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Ya1QXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BECC4CEF1;
	Wed,  7 Jan 2026 21:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767821868;
	bh=eW8QlCnKijLeajenot+m4qNSxAfj9t/rpWE2bThsc5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+Ya1QXynSok5pMDhES2RIjpQBviUYKSLYUmKi6bMhvFwEQtZwvZ28q92Z2kwEhin
	 6mi/ppexQQ0HmklBmnH8VmP8SFu5P3mWqKIpj/DoT0ANajXxYAZSCNaYNWgTF4hB7C
	 ICzZGtK3CXZDb55e32H8Vt+9rn4kI9YBWTUDjF5JX3sbhblBm05QVY41krHVIY/s4U
	 0ugOh5gfxLAUA2DufWkw7l6ymR2SHhchBcvygfr7lPf7OZxRZV3SYXdh314W67uohv
	 7+EN+VB94vGGR5rMIjFiFGXcQiaZz86KMjo88Q3z3ctR7Me+HhkyNIKgRfnjGtFyAJ
	 Au/9FkoKE67lA==
Date: Wed, 7 Jan 2026 13:37:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <pabeni@redhat.com>, <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>
Subject: Re: [PATCH net-next v15 05/12] virtio_net: Query and set flow
 filter caps
Message-ID: <20260107133747.2ae75f3d@kernel.org>
In-Reply-To: <20260107170422.407591-6-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
	<20260107170422.407591-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:04:15 -0600 Daniel Jurgens wrote:
> +	if (err && err != -EOPNOTSUPP) {
> +		if (netif_running(vi->dev))
> +			virtnet_close(vi->dev);
> +
> +		/* disable_rx_mmode_work takes the rtnl_lock, so just set the
> +		 * flag here while holding the lock.
> +		 *
> +		 * remove_vq_common resets the device and frees the vqs.
> +		 */
> +		vi->rx_mode_work_enabled = false;
> +		disable_delayed_refill(vi);
> +		rtnl_unlock();
> +		remove_vq_common(vi);
> +		return err;

disable_delayed_refill() is going away in net 

https://lore.kernel.org/all/20260106150438.7425-1-minhquangbui99@gmail.com/

You'll have to wait for that change to propagate to net-next to avoid
a transient build issue:

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-01-07--21-00&pw-n=0&pass=0
-- 
pw-bot: cr

