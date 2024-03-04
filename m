Return-Path: <netdev+bounces-77258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0363870D63
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2728F0C4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01014CE0E;
	Mon,  4 Mar 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ve5vbc/1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184001F60A
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588010; cv=none; b=LofLrgGvshhTaXTzi7HaSKGQzlwICVvH3bNIbMWK0Agk8J+kVCw+U38estlTcO770r57NA8BQb/IslRJKKVhk3dXDgCDXqbDQQ+utADa6fA0fkZlGYAMhC585j6Fd/QEiABXE7igI+hfNjhPKcmmAmUXCiooorbhpAaKRkBeJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588010; c=relaxed/simple;
	bh=OJ9yKXFi4SKO8kkUsMWs6TcUz1qXAKo1IceBHO/gC60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etFX+9qbtjNzUbBX7mlVGcr20k4c+7oYR8ksLamR7so6XM+EV1p9D1Z0lc2khP/Y6aSg5hl8dfKNzK27v2K96sC9jXlD82vFFKqkKaIV+FpwSeeAFvA1MMmt0PArKtLPCTNYZ2hozW91Fjwq7uyRCgUULvhT3njvfvE92tRcCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ve5vbc/1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XbQu5dvnYHETOQFCs/f67uLfRKLV/9XhObKqAqOXx8Q=; b=ve5vbc/1kSHZ2dvhPBYoiC4Ynk
	m97Z5/CHuDmrz3jUKjGc6ZX6pvFLzVN5uf+RyTrvUDzCB1pGwwM2dlTSkwXiGroy+Dsu9fR/rIznM
	CC0RPBWO9gOUE4tFKi4IHWNgTmsMRm0aW8c/NEJFhc/3fX8Top2ueveBqUlK5LvdX0NM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhFwW-009MDl-Rw; Mon, 04 Mar 2024 22:33:52 +0100
Date: Mon, 4 Mar 2024 22:33:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-5-antonio@openvpn.net>

> +int ovpn_struct_init(struct net_device *dev)
> +{
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +	int err;
> +
> +	memset(ovpn, 0, sizeof(*ovpn));

Probably not required. When a netdev is created, it should of zeroed
the priv.

> +int ovpn_iface_create(const char *name, enum ovpn_mode mode, struct net *net)
> +{
> +	struct net_device *dev;
> +	struct ovpn_struct *ovpn;
> +	int ret;
> +
> +	dev = alloc_netdev(sizeof(struct ovpn_struct), name, NET_NAME_USER, ovpn_setup);
> +
> +	dev_net_set(dev, net);
> +
> +	ret = ovpn_struct_init(dev);
> +	if (ret < 0)
> +		goto err;
> +
> +	ovpn = netdev_priv(dev);
> +	ovpn->mode = mode;
> +
> +	rtnl_lock();
> +
> +	ret = register_netdevice(dev);
> +	if (ret < 0) {
> +		netdev_dbg(dev, "cannot register interface %s: %d\n", dev->name, ret);
> +		rtnl_unlock();
> +		goto err;
> +	}
> +	rtnl_unlock();
> +
> +	return ret;
> +
> +err:
> +	free_netdev(dev);
> +	return ret;
> +}
> +
> +void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
> +{
> +	ASSERT_RTNL();
> +
> +	netif_carrier_off(ovpn->dev);

You often see virtual devices turn their carrier off in there
probe/create function, because it is unclear what state it is in after
register_netdevice().

	Andrew

