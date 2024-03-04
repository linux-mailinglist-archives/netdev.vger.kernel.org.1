Return-Path: <netdev+bounces-77261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDAE870F3B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30DC1F21FF3
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167278B69;
	Mon,  4 Mar 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nSeTFV1v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0CE1C6AB
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589146; cv=none; b=F9/VbOw76H/I54qpkmNklJkg2h5/PBpiSA8B84L+9WcfxvErgctvKj+ywhuOkuivRvjajS/DwpK3CARMOt4q62PbwyKT0I4vVNTlUJ4gVd+teYaBPrCbE2ri9kmRuPYr/k8hXYMCKJoJKgoW53QDlA11RjhFYXGH9Sxp4XAALC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589146; c=relaxed/simple;
	bh=50N2QoMj8yx+KwEbaJ/lsBwDUTyWyEsmoty89rGYUwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ8rZ8jH8YXeKsz2+GyUkot+ra1icQqOUUgYzDK3oTBPCYqERyqNZk5ZKcUm7SmMSIlsUPt5ORBeG9nSTUxu40CxTjQVHx2CzkWhtq1YD5OypAWmFqCoIcUHJ3XUka5VhIx3n8PRMppx4RXh4jH2XVEa2bg776D9NiDY0qkai6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nSeTFV1v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mYzge5rMg7vg5haFxa31BhcypCdJwsBx2uHjHLnFwx8=; b=nSeTFV1vUKTJgeDmFxszfrwG1j
	aD7F0XWYjOOklm1Q5iiSr073PDz+M4K229+dZmXJTAjSdhI1BZOqzB27G7tDtZen22ZN5VRM6Rmc0
	yAXZ49hsg9aBO0cqSs/J8ZWTAKpIqboNgqt3qRIZo/zh+1VgqF1TAz99xvo75M6YREGM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhGEq-009MGD-8Q; Mon, 04 Mar 2024 22:52:48 +0100
Date: Mon, 4 Mar 2024 22:52:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Message-ID: <8ca7da9c-b8c2-4368-9413-a06e7fa6713e@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-7-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:08:57PM +0100, Antonio Quartulli wrote:
> An ovpn_peer object holds the whole status of a remote peer
> (regardless whether it is a server or a client).
> 
> This includes status for crypto, tx/rx buffers, napi, etc.
> 
> Only support for one peer is introduced (P2P mode).
> Multi peer support is introduced with a later patch.
> 
> Along with the ovpn_peer, also the ovpn_bind object is introcued

introduced

 > +/* Translate skb->protocol value to AF_INET or AF_INET6 */
> +static inline unsigned short skb_protocol_to_family(const struct sk_buff *skb)
> +{
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		return AF_INET;
> +	case htons(ETH_P_IPV6):
> +		return AF_INET6;
> +	default:
> +		return 0;

That feels like the sort of thing which should already exist
somewhere. But a quick search did not find it...

	Andrew

