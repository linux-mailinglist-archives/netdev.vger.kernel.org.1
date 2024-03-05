Return-Path: <netdev+bounces-77599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E087241E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170BEB25DE4
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25BF12D758;
	Tue,  5 Mar 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n0RHE65A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CA12A140
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655782; cv=none; b=GkbFw3ijocKkgiN9qhOf2ZMi6A2c9n40KjqwUTY5gENiPmIRWgQphqdOQlLddToHmQKLRVqxiQ6fWnZLvWox8yd8vxZjHKOS+rApwLkYHgAdHZD4s45KXLtJg6HCPgqQt5lpC/Ij2V6gQ3QxcflAa1badX5cHBCX0SuknU0iwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655782; c=relaxed/simple;
	bh=pPuH4uex5aNY0TXahhSE0hSg4u3A++vY/b3ay8bg4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMvK6+aT3WqrPCe2ILNu+YoRfkx2MBFQNUUEB0XnC9/4eox6BKSOSkjNKiAdpkQmyZCCCX9ckdTmxYuJb0iRcS2qlcwuPaC/frGin4Lhud5jMDQw/wNgAkqvKuJhSYvXCcH9NCkqudh/E7tl102N44c8Koi/v7ftWrMCgCUYp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n0RHE65A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bguJDtcgitMAw0EmGBdQp0trb2IiQ0ZR/fHQIpx+V90=; b=n0RHE65Aa7B/X69wfHjd4HxK6V
	52JkLc3INk8in5VsOsF/wVG9BQI505523LVwsuFTV4iOj96teJPmjX9E4jjgTH/VbtRpV1F34EXuq
	rFsC2FK0MStAGo2pZJJi/C75XEf+imHhTLy1NCmJcjYG8kgyYl3t0r0TdWamMJDbI1BA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhXZd-009Rgj-EO; Tue, 05 Mar 2024 17:23:25 +0100
Date: Tue, 5 Mar 2024 17:23:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Message-ID: <d52c6ff5-dd0d-41d1-be6f-272d58ccf010@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net>
 <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
 <f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>

> > 12: enlr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq master br0 state DOWN group default qlen 1000
> >      link/ether 3c:ec:ef:7e:0a:90 brd ff:ff:ff:ff:ff:ff
> >      altname enp183s0f2
> >      altname eno7
> > 
> > It is better to let userspace figure out the name from the index,
> > since the name is mostly a user space concept.
> 
> This is strictly related to your next question.
> Please see my answer below.
> 
> > 
> > > +	[OVPN_A_MODE] = NLA_POLICY_RANGE(NLA_U8, __OVPN_MODE_FIRST,
> > > +					 NUM_OVPN_MODE - 1),
> > > +	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_nl_policy_peer),
> > > +};
> > 
> > > +static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> > > +			 struct genl_info *info)
> > > +{
> > > +	struct net *net = genl_info_net(info);
> > > +	struct net_device *dev;
> > > +
> > > +	/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
> > > +	 * just expects an IFNAME, while all the others expect an IFINDEX
> > > +	 */
> > 
> > Could you explain that some more. In general, the name should not
> > matter to the kernel, udev/systemd might rename it soon after creation
> > etc. If it gets moved into a network namespace it might need renaming
> > etc.
> 
> In a previous discussion it was agreed that we should create ovpn interfaces
> via GENL and not via RTNL.
> 
> For this reason ovpn needs userspace to send the name to give the interface
> upon creation. This name is just passed to the networking stack upon
> creation/registration, but it is not stored anywhere else.
> 
> Subsequent netlink calls are then all performed by passing an ifindex.
> 
> Hence, OVPN_CMD_NEW_IFACE is the only GENL command that required the IFNAME
> to be specified.

I don't really see why GENL vs RTNL makes a difference. The reply to
the request can contain the ifindex of the newly created interface. If
you set the name to "ovpn%d" before calling register_netdevice() the
kernel will find the next free unique ovpn interface name, race
free. So you could have multiple openvpn daemon running, and not have
to worry about races when creating interfaces.

Jakub has been raising questions about this recently for another
patchset. He might comment on this.

> > > +	OVPN_A_PEER_VPN_RX_BYTES,
> > > +	OVPN_A_PEER_VPN_TX_BYTES,
> > > +	OVPN_A_PEER_VPN_RX_PACKETS,
> > > +	OVPN_A_PEER_VPN_TX_PACKETS,
> > > +	OVPN_A_PEER_LINK_RX_BYTES,
> > > +	OVPN_A_PEER_LINK_TX_BYTES,
> > > +	OVPN_A_PEER_LINK_RX_PACKETS,
> > > +	OVPN_A_PEER_LINK_TX_PACKETS,
> > 
> > How do these differ to standard network statistics? e.g. what is in
> > /sys/class/net/*/statistics/ ?
> 
> The first difference is that these stats are per-peer and not per-device.
> Behind each device there might be multiple peers connected.
> 
> This way ovpn is able to tell how much data was sent/received by every
> single connected peer.
> 
> LINK and VPN store different values.
> LINK stats are recorded at the transport layer (before decapsulation or
> after encapsulation), while VPN stats are recorded at the tunnel layer
> (after decapsulation or before encapsulation).
> 
> I didn't see how to convey the same information using the standard
> statistics.

Right, so this in general makes sense. The only question i have now
is, should you be using rtnl_link_stats64. That is the standard
structure for interface statistics.

Again, Jakub likes to comment about statistics...

And in general, maybe add more comments. This is the UAPI, it needs to
be clear and unambiguous. Documentation/networking/ethtool-netlink.rst.

       Andrew

