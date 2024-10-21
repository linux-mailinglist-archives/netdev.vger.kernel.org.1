Return-Path: <netdev+bounces-137634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1CA9A90B1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57131C21859
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C11EBA05;
	Mon, 21 Oct 2024 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WbGovaSh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7421E0B86;
	Mon, 21 Oct 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541534; cv=none; b=TYnD7ti+jOQbj8xWRA9XlgzkGwUA2M7JvH7au0J0YcmOhAAhnDXu1p8Obw5g2PFQSHYKiJMaYFTvHpxK+rPMUYL7jlFeGLc7mjrEnHfGFTtQxDhJrdgQwVJleMQra7rhhVTZqKspr7pxRp5yXxJv7gIHb+e1yHxKZDpQNXzoIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541534; c=relaxed/simple;
	bh=AYKAy8kRv/KlBYsd4552FKww1jl+KPz+UHnCXuIjWvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/HmNkMPJ22bYEpkPIiw2nGvcuWFOmD/EM0yVcNoRr21opUkOGBgc8n+MOIW4dGQa4i0anM2eHGVlp5t8ne8DsqmnRtacdF6pz4a9Bns3YkxgUZVLlociqCSRw5uW7SX7R6H2StdNmQYpcnQvm81/pQkK8WZTG16IYcL/NRDC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WbGovaSh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JiAR7jPGZVyniVYgsyzhTrVFkBxrsyzn+u1ozZll4gs=; b=WbGovaSh2+kETD4rZMBu4yuvou
	kbrUuxWHfUIzYyQIoQjny4pF+wRtx9TQHjw3tOwM3FjgEs5Q29XT/+qt/AnMfA1+uIhDVU+zbeQ8a
	8cKV5LL3HQ9fPRsmnvlJ/+dvafxINaVFDfonQeDQNZJZ2OV+l+kFDXT5/TiAtAifP3qQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2yko-00AlWw-5x; Mon, 21 Oct 2024 22:11:50 +0200
Date: Mon, 21 Oct 2024 22:11:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] UAPI: ethtool: Use __struct_group() in struct
 ethtool_link_settings
Message-ID: <53721db6-f4b1-4394-ab2a-045f214bd2fa@lunn.ch>
References: <cover.1729536776.git.gustavoars@kernel.org>
 <e9ccb0cd7e490bfa270a7c20979e16ff84ac91e2.1729536776.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ccb0cd7e490bfa270a7c20979e16ff84ac91e2.1729536776.git.gustavoars@kernel.org>

>  struct ethtool_link_settings {
> -	__u32	cmd;
> -	__u32	speed;
> -	__u8	duplex;
> -	__u8	port;
> -	__u8	phy_address;
> -	__u8	autoneg;
> -	__u8	mdio_support;
> -	__u8	eth_tp_mdix;
> -	__u8	eth_tp_mdix_ctrl;
> -	__s8	link_mode_masks_nwords;
> -	__u8	transceiver;
> -	__u8	master_slave_cfg;
> -	__u8	master_slave_state;
> -	__u8	rate_matching;
> -	__u32	reserved[7];
> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
> +		__u32	cmd;
> +		__u32	speed;
> +		__u8	duplex;
> +		__u8	port;
> +		__u8	phy_address;
> +		__u8	autoneg;
> +		__u8	mdio_support;
> +		__u8	eth_tp_mdix;
> +		__u8	eth_tp_mdix_ctrl;
> +		__s8	link_mode_masks_nwords;
> +		__u8	transceiver;
> +		__u8	master_slave_cfg;
> +		__u8	master_slave_state;
> +		__u8	rate_matching;
> +		__u32	reserved[7];
> +	);
>  	__u32	link_mode_masks[];

Dumb C question. What are the padding rules for a union, compared to
base types? Do we know for sure the compiler is not going pad this
structure differently because of the union?

It is however nicely constructed. The 12 __u8 making 3 32bit words, so
we have a total of 12 32bit words, or 6 64bit words, before the
link_mode_masks[], so i don't think padding is technically an issue,
but it would be nice to know the C standard guarantees this.

	Andrew

