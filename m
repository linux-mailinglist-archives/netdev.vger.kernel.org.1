Return-Path: <netdev+bounces-77244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80612870C4B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C35EB22CF5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F81F600;
	Mon,  4 Mar 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S/aAy8nY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F17B3F3
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587217; cv=none; b=MFDsO5f4X0qfsm5sGM8pyutZdDm55+2VrYVN7koACPj1ujA6ULw5pjy7rAGlnRXGnC260Uzgt7ehQSJ22exIF+Ae73iChWkHUKX5Pd92DoX1tbhN+fB154mM0jOe13AMMO183ZRbLkBFr3EUbJjTi6r5j/m9BtvLfol8r/59akU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587217; c=relaxed/simple;
	bh=q/Te+FTC3Y3UNpLQkELOSHzO4Lz+iu4cPh7oVv2zFMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5EjXrtAdqp5cIqiNoIZdtcrodzRTRL0uYFMldTmrP0Rb6yDX1OuepCt9UOerisoEXt+xcbvE1xeZTpBqPmDyKMh2EI1DEoktXueKy9wtmyhnp9eA6VaygDdV7Gt+Lp5mG6HiqnXI3UelrpLKxm+buSAqsIf4xF2gPV38xTgJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S/aAy8nY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TZ9vBIwNgjr5KELYh34bSF9xwpi6tqmkLpjSuRtBtCM=; b=S/aAy8nYfXsR2TdymjXzt2gYSY
	W7AI79h21O4f0eDt8seRiyQe7JlpUHXe75jlL7Tw9xMUP7pHbGicMMLQ6CFgKmFJzlrknisX6L03G
	ZKjYWzkMVf16UBhvGms+HDkxYdNt12rsgTrB8KfqVd7VqaNxOPIH+Ct9GioU3CUSBQlM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhFji-009M8T-OE; Mon, 04 Mar 2024 22:20:38 +0100
Date: Mon, 4 Mar 2024 22:20:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Message-ID: <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-4-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:08:54PM +0100, Antonio Quartulli wrote:
> This commit introduces basic netlink support with
> registration/unregistration functionalities and stub pre/post-doit.
> 
> More importantly it introduces the UAPI header file that contains
> the attributes that are inteded to be used by the netlink API

intended.

> implementation.
> 
> For convience, packet.h is also added containing some macros about
> the OpenVPN packet format.
> 
> +/** KEYDIR policy. Can be used for configuring an encryption and a decryption key */
> +static const struct nla_policy ovpn_nl_policy_keydir[NUM_OVPN_A_KEYDIR] = {
> +	[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),

I don't know netlink that well. Is this saying keys are limited to 256
bytes? How future proof is that? I'm not a crypto person, but
symmetric algorithms, e.g. AES, seem to have reasonably short keys, 32
bytes, so this seems O.K, to me.

> +	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(NONCE_TAIL_SIZE),
> +};
> +
> +/** KEYCONF policy */
> +static const struct nla_policy ovpn_nl_policy_keyconf[NUM_OVPN_A_KEYCONF] = {
> +	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_RANGE(NLA_U8, __OVPN_KEY_SLOT_FIRST,
> +						 NUM_OVPN_KEY_SLOT - 1),
> +	[OVPN_A_KEYCONF_KEY_ID] = { .type = NLA_U8 },

Is that 256 keys globally, or just associated to one session?

> +	[OVPN_A_KEYCONF_CIPHER_ALG] = { .type = NLA_U16 },
> +	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_nl_policy_keydir),
> +	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_nl_policy_keydir),
> +};
> +

> +/** Generic message container policy */
> +static const struct nla_policy ovpn_nl_policy[NUM_OVPN_A] = {
> +	[OVPN_A_IFINDEX] = { .type = NLA_U32 },
> +	[OVPN_A_IFNAME] = NLA_POLICY_MAX_LEN(IFNAMSIZ),

Generally, ifnames are not passed around, only ifindex. An interface
can have multiple names:

12: enlr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq master br0 state DOWN group default qlen 1000
    link/ether 3c:ec:ef:7e:0a:90 brd ff:ff:ff:ff:ff:ff
    altname enp183s0f2
    altname eno7

It is better to let userspace figure out the name from the index,
since the name is mostly a user space concept.

> +	[OVPN_A_MODE] = NLA_POLICY_RANGE(NLA_U8, __OVPN_MODE_FIRST,
> +					 NUM_OVPN_MODE - 1),
> +	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_nl_policy_peer),
> +};

> +static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> +			 struct genl_info *info)
> +{
> +	struct net *net = genl_info_net(info);
> +	struct net_device *dev;
> +
> +	/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
> +	 * just expects an IFNAME, while all the others expect an IFINDEX
> +	 */

Could you explain that some more. In general, the name should not
matter to the kernel, udev/systemd might rename it soon after creation
etc. If it gets moved into a network namespace it might need renaming
etc.

> +enum ovpn_nl_peer_attrs {
> +	OVPN_A_PEER_UNSPEC = 0,
> +	OVPN_A_PEER_ID,
> +	OVPN_A_PEER_RX_STATS,
> +	OVPN_A_PEER_TX_STATS,

Probably answered later in the patch series: What sort of statistics
do you expect here. Don't overlap any of the normal network statistics
with this here, please use the existing kAPIs for those. Anything you
return here need to be very specific to ovpn.

> +	OVPN_A_PEER_VPN_RX_BYTES,
> +	OVPN_A_PEER_VPN_TX_BYTES,
> +	OVPN_A_PEER_VPN_RX_PACKETS,
> +	OVPN_A_PEER_VPN_TX_PACKETS,
> +	OVPN_A_PEER_LINK_RX_BYTES,
> +	OVPN_A_PEER_LINK_TX_BYTES,
> +	OVPN_A_PEER_LINK_RX_PACKETS,
> +	OVPN_A_PEER_LINK_TX_PACKETS,

How do these differ to standard network statistics? e.g. what is in
/sys/class/net/*/statistics/ ?

	Andrew

