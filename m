Return-Path: <netdev+bounces-78571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F49875C46
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 03:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB81C2106D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 02:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E324224CC;
	Fri,  8 Mar 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xlow8Tt6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E733DF
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864195; cv=none; b=YnOPId17fPlI9tDirRrYiAc16YVo6rrfVxYEyiCzw2EFXAFfrLf0eOcD7ybwdPGwP1EfAOdhOWR9kX/uojr0I8OSESPGJ1JfZJ5XcQYc7P/Kcrp9auMDg7YW7Y3ghP7AI2F2GZZ4/lZ41E82oGL+0F6H9BrMoo3gV/Rk5qGkKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864195; c=relaxed/simple;
	bh=R9yEiDe9casxmlq6CXeTfQSVtHY8roMkoTbiNGqearA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq89/hVkPD0MGF/Dps9zZkaAH9CCTgypluThEN58jrH87HXDVp6JBXRQeP+/j2AwLaHm5FkOqN1+nAzvUHYlkZiqmoeu4UYdrV0y0dA6QQ98qVDrqqflLqyyWHdeFWarzQU/aFVclIeJ/TeHSMl33Sxa+l1CdzJio68ynknrSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xlow8Tt6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bw1nG1iurhd2imAfNTDekTFNoynlr68JlDwWik8iYi4=; b=Xlow8Tt6kDu5c9QQGIXFrxD9qK
	SbOFCvJyAYioIux+P1wwJpx20lu6bpH+Y0ESztGZW28FRrhdZvTCv9Z3x3Y+9MK/t5PeKXLyY72+s
	qAbMTbYZsGaNyytFImDxX3+VtymdUWHPWAGWbuBh0EIvriotBO0LHAazlGHp1yglwV4U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riPnB-009ipd-Mv; Fri, 08 Mar 2024 03:17:01 +0100
Date: Fri, 8 Mar 2024 03:17:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 09/22] ovpn: implement basic RX path (UDP)
Message-ID: <0dcf1824-5819-4280-828d-46cf5bce3527@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-10-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-10-antonio@openvpn.net>

> +++ b/drivers/net/ovpn/io.c
> @@ -53,6 +53,113 @@ int ovpn_struct_init(struct net_device *dev)
>  	return 0;
>  }
>  
> +/* Called after decrypt to write IP packet to tun netdev.
> + * This method is expected to manage/free skb.

tun? 

The userspace implementation uses tun, but being in the kernel, don't
you just pass it to the stack?

> + */
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	/* packet integrity was verified on the VPN layer - no need to perform
> +	 * any additional check along the stack
> +	 */
> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	skb->csum_level = ~0;
> +
> +	/* skb hash for transport packet no longer valid after decapsulation */
> +	skb_clear_hash(skb);
> +
> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto tun
> +	 * interface, based on __skb_tunnel_rx() in dst.h
> +	 */
> +	skb->dev = peer->ovpn->dev;
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, true);
> +
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
> +	skb_probe_transport_header(skb);
> +	skb_reset_inner_headers(skb);
> +
> +	/* update per-cpu RX stats with the stored size of encrypted packet */
> +
> +	/* we are in softirq context - hence no locking nor disable preemption needed */
> +	dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
> +
> +	/* cause packet to be "received" by tun interface */
> +	napi_gro_receive(&peer->napi, skb);
> +}
> +
> +int ovpn_napi_poll(struct napi_struct *napi, int budget)
> +{
> +	struct ovpn_peer *peer = container_of(napi, struct ovpn_peer, napi);
> +	struct sk_buff *skb;
> +	int work_done = 0;
> +
> +	if (unlikely(budget <= 0))
> +		return 0;
> +	/* this function should schedule at most 'budget' number of
> +	 * packets for delivery to the tun interface.

More tun. Did you copy code from the tun driver?

     Andrew

