Return-Path: <netdev+bounces-77649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F78727B4
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D531F28578
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797D433AE;
	Tue,  5 Mar 2024 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyV9m/Er"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED618639
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667542; cv=none; b=Gn8XkZdB4nY6U6FfqG17Q3yTXQsJvZTilRvJIALe/hHV8ce96nN1uZDbpFaAHQ1q3Tjr6nKeKixFTwskO/WSGDR+1h7w0Gl5Tfvp/Pbc/LevhxY0Uoe81UpQGOQYIdabccaVsRShMYQjQliFAWPNTjBDal/ZX7gH7YqsEo2uBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667542; c=relaxed/simple;
	bh=e/68+VKLsC0teCsVtqhc3XV7JLXEbG/wcsE+JIedSR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQAmrEE5cdkVsKepNeZwIlnhSJcR4/T/aNgvNI2zJrbyVc+eXPps86tUfdtSmHboyMXZJibdkXlvgInimCVjUywg6/3wSU+gmj0b0jgBayARpVSTBTEwU1T4314RX/7X+j8+WilRRyYfowHH7iVhA2N+HhKf1bY9GEPm4FMbbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyV9m/Er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5159FC433C7;
	Tue,  5 Mar 2024 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709667541;
	bh=e/68+VKLsC0teCsVtqhc3XV7JLXEbG/wcsE+JIedSR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IyV9m/ErmM7hhKj1UQ/BTsgDvrkkHdm2HuBzykonB8gvPi3IJ+QxOpTpmWQNQ++rd
	 f0j9+tV3+fUIJn6+T/eHdisY5sr9lTNnD38DoU5c42Kw+pLYFtynQzlVgu56XRIkoT
	 NvuBdBwuryOZDD/D4ckzbDIPwl7zdBZXL6hQlfpmlfiI1GTrd0aJH2xrIvov/cJShX
	 wqaNBKuK/0xH2AdSMTGrsljcX1pAZ5H5tYIJYr/DIDcHX1QuTZNGEkw5HxtIEQS5ih
	 rbSPXQKFMuqqzrtL6rTxloGyIaLXFWQQF3SuKQIBMjPgQucCG6KGRQg5QWgZRR9h8Q
	 eVeW9a34WIOtw==
Date: Tue, 5 Mar 2024 11:39:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Sergey
 Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Message-ID: <20240305113900.5ed37041@kernel.org>
In-Reply-To: <d52c6ff5-dd0d-41d1-be6f-272d58ccf010@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-4-antonio@openvpn.net>
	<e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
	<f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>
	<d52c6ff5-dd0d-41d1-be6f-272d58ccf010@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 17:23:25 +0100 Andrew Lunn wrote:
> > > > +static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> > > > +			 struct genl_info *info)
> > > > +{
> > > > +	struct net *net = genl_info_net(info);
> > > > +	struct net_device *dev;
> > > > +
> > > > +	/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
> > > > +	 * just expects an IFNAME, while all the others expect an IFINDEX
> > > > +	 */  
> > > 
> > > Could you explain that some more. In general, the name should not
> > > matter to the kernel, udev/systemd might rename it soon after creation
> > > etc. If it gets moved into a network namespace it might need renaming
> > > etc.  
> > 
> > In a previous discussion it was agreed that we should create ovpn interfaces
> > via GENL and not via RTNL.
> > 
> > For this reason ovpn needs userspace to send the name to give the interface
> > upon creation. This name is just passed to the networking stack upon
> > creation/registration, but it is not stored anywhere else.
> > 
> > Subsequent netlink calls are then all performed by passing an ifindex.
> > 
> > Hence, OVPN_CMD_NEW_IFACE is the only GENL command that required the IFNAME
> > to be specified.  
> 
> I don't really see why GENL vs RTNL makes a difference. The reply to
> the request can contain the ifindex of the newly created interface. If
> you set the name to "ovpn%d" before calling register_netdevice() the
> kernel will find the next free unique ovpn interface name, race
> free. So you could have multiple openvpn daemon running, and not have
> to worry about races when creating interfaces.
> 
> Jakub has been raising questions about this recently for another
> patchset. He might comment on this.

FWIW using ifindex for most ops sounds like the right way to go.
Passing the name to create sounds fine, but as Andrew said, we
should default to "ovpn%d" instead of forcing the user to specify 
the name (and you can echo back the allocated name in the reply
to OVPN_CMD_NEW_IFACE).

Somewhat related - if you require an attr - GENL_REQ_ATTR_CHECK(),
it does the extact setting for you.

> > > > +	OVPN_A_PEER_VPN_RX_BYTES,
> > > > +	OVPN_A_PEER_VPN_TX_BYTES,
> > > > +	OVPN_A_PEER_VPN_RX_PACKETS,
> > > > +	OVPN_A_PEER_VPN_TX_PACKETS,
> > > > +	OVPN_A_PEER_LINK_RX_BYTES,
> > > > +	OVPN_A_PEER_LINK_TX_BYTES,
> > > > +	OVPN_A_PEER_LINK_RX_PACKETS,
> > > > +	OVPN_A_PEER_LINK_TX_PACKETS,  
> > > 
> > > How do these differ to standard network statistics? e.g. what is in
> > > /sys/class/net/*/statistics/ ?  
> > 
> > The first difference is that these stats are per-peer and not per-device.
> > Behind each device there might be multiple peers connected.
> > 
> > This way ovpn is able to tell how much data was sent/received by every
> > single connected peer.
> > 
> > LINK and VPN store different values.
> > LINK stats are recorded at the transport layer (before decapsulation or
> > after encapsulation), while VPN stats are recorded at the tunnel layer
> > (after decapsulation or before encapsulation).
> > 
> > I didn't see how to convey the same information using the standard
> > statistics.  
> 
> Right, so this in general makes sense. The only question i have now
> is, should you be using rtnl_link_stats64. That is the standard
> structure for interface statistics.
> 
> Again, Jakub likes to comment about statistics...
> 
> And in general, maybe add more comments. This is the UAPI, it needs to
> be clear and unambiguous. Documentation/networking/ethtool-netlink.rst.

Or put enough docs in the YAML spec as those comments get rendered in
the uAPI header and in HTML docs :)

