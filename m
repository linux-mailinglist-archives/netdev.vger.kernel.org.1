Return-Path: <netdev+bounces-190098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B804CAB529F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1F37A400A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85152609FD;
	Tue, 13 May 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DLSBLpm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6F2609D0
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131505; cv=none; b=r1iY3Qm9S477PsATVoC5eHbcn6iA8i7QE7RquV8YEId32TNEXGHNM+4owD16vQFRRi9KYFnN3LO/cAk3bNhn0eO9pTjtkn4YjZB71H3dtVC8C7+nTxoHe5cERCL5CpDHDZMxw8JnRguAV04bhwDxCBJCz7MNS30EuC3LqrT/Rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131505; c=relaxed/simple;
	bh=UnFohL/jhoXIhwcN73g1S/6b8OrpaBzf7yqVaxHqaOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7Wac5C17PWBF40r6AawQyc3tsWtfd1FdBiunJkWhG1QaYkX+Hkq2DykWdDVX9gKvFAcB+kdtIbEfF4oH6p/Vf194P5dvKABF2Bq1lUboZpvj7UYggsYV+s8UoHY/hca2AtMGWGygIDKkaObzGTt2Tbr5XMzDlakHZCMNIHfoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DLSBLpm7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so11397953a12.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747131501; x=1747736301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mxezmpwdvQlOlX2DPWmgHazAevXAsYIAhjuV5eBsk4=;
        b=DLSBLpm7BAZS74hTcivui5piLd6JscHhBLjc9MOkeXCfXOxqcacXkmueTETOPV6f2D
         Iho6TLwDz/x3Yqca9Hy65lZSTVlEzmp1ROa3oHMIcGkk8XuU7LGh4weElLZ/XZZihokr
         tT9Vl6+HljrcLvyp3EGYkhpZSFEeChtTg0PxW4pj5nA/HgZjOMQzq+u7VZikmAeY8M3e
         6evGokx3o1B9eZKfcYRwH1p9hJ3bsV9Tl24lepjUOpToGlUqjul85iQX40DRm6SityvK
         b/l6GHmSXs+6gDfDxKZE9TAbwT1Xn7ljdCrAmHxawzaM5lugEDrWoiuBtrbEu6T+6DFQ
         ynPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747131501; x=1747736301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mxezmpwdvQlOlX2DPWmgHazAevXAsYIAhjuV5eBsk4=;
        b=Bn1DiHPFABGX1jgyF/NwiNSERxmbpPWDxtArdBVuMV5X6Umayxp/UDnBHsXgZLEltc
         mEvcq6sCJbw3S2fDLm45pcKgsAKHEGA62PuEaBxajktFN/KWbNRgchXUR+j3B31K83bv
         g5cLFZ8TwdvHVepYV98T0Ze9C6OfW0+vKg8CvkkPRk9J99mteyWsRwv8o8A3iQLsrcZE
         1yLl20D13lox/O084BHrSbAVV+jWY3wDO0W0+Jk25FIDNF2i4MxHYviYFGOrkFMzCSqq
         GYNh2AjWWjXU85l8dRpTfVo1sj2yEQPf6GiOkTaU/5JfkMw2lLZ81j/W2WnHPiWjzIkI
         am2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAUJlmmEWKAnyB9PB2QYHlxuftPYOnkntOqtfvfy43yYstdNKkNh01KwVZfqOgW4c7OuJEhtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBllWTAvj0ouoipgkxBsP5C6qRgiDm2lZyB09kTDKbuNL3xv4
	cP8e+4SlNkL3i82/Fo0uel7C3b+XeaJ/WwneVlcZdjZlkcFe/vx3egrqLhRpXoI=
X-Gm-Gg: ASbGncuzlPXQ845lwWhcPf+khiusB/5Y0Od0AXa2k7kP+Mo90/WjEZSpZC3CEuLC2iA
	wxzpGq+AIIeWfu3DCRGXMvWksS3Uu12uNrF4+gJjE/WP/FUylg/fsUT8u0hYC5k8QgQXJHvTbFR
	Djv4JjtX/oaJ4STAaMwRTOjuz2CHkwiHj2J8NynnmQz2fDUt6SInbk3R6aeAjJUHeLCa+SCVDKG
	e6Yq3pFDwxBn8YROWB+zVyXtY21MJxFcdAalNdZ2W9bT5d6Ks1rqJ1z/fFWA3QRfopl9wwZNpel
	VDyXDcjA89ZW/qJ1J0kZWIthS10/+0+NLEHRfQK7uCAqJqZwsWABBGQDJtnHRhFciuQRV9vmvVf
	UupsuT8s=
X-Google-Smtp-Source: AGHT+IEhXbuqv9SHfpGg4Pm1ImklBHv1IEgGVqzoQvMjjlW+T3A36SnDDgOSoKO9v4yOP7N4FG6uLA==
X-Received: by 2002:a05:6402:5187:b0:5fb:e7e1:f1c1 with SMTP id 4fb4d7f45d1cf-5fca0731385mr14175814a12.3.1747131501184;
        Tue, 13 May 2025 03:18:21 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cc26521sm7032152a12.18.2025.05.13.03.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:18:20 -0700 (PDT)
Message-ID: <f690dc4a-fde8-411d-84d8-67980555f479@blackwall.org>
Date: Tue, 13 May 2025 13:18:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
 <4270C010E5516F3B+20250513094750.23387-2-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <4270C010E5516F3B+20250513094750.23387-2-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 12:47, Tonghao Zhang wrote:
> Stacking technology is a type of technology used to expand ports on
> Ethernet switches. It is widely used as a common access method in
> large-scale Internet data center architectures. Years of practice
> have proved that stacking technology has advantages and disadvantages
> in high-reliability network architecture scenarios. For instance,
> in stacking networking arch, conventional switch system upgrades
> require multiple stacked devices to restart at the same time.
> Therefore, it is inevitable that the business will be interrupted
> for a while. It is for this reason that "no-stacking" in data centers
> has become a trend. Additionally, when the stacking link connecting
> the switches fails or is abnormal, the stack will split. Although it is
> not common, it still happens in actual operation. The problem is that
> after the split, it is equivalent to two switches with the same configuration
> appearing in the network, causing network configuration conflicts and
> ultimately interrupting the services carried by the stacking system.
> 
> To improve network stability, "non-stacking" solutions have been increasingly
> adopted, particularly by public cloud providers and tech companies
> like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing switch
> stacking that convinces a LACP peer, bonding in this case, connected to a set of
> "non-stacked" switches that all of its ports are connected to a single
> switch (i.e., LACP aggregator), as if those switches were stacked. This
> enables the LACP peer's ports to aggregate together, and requires (a)
> special switch configuration, described in the linked article, and (b)
> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
> packets across all ports of the active aggregator.
> 
>   -----------     -----------
>  |  switch1  |   |  switch2  |
>   -----------     -----------
>          ^           ^
>          |           |
>         ---------------
>        |   bond4 lacp  |
>         ---------------
>          | NIC1      | NIC2
>      ---------------------
>     |       server        |
>      ---------------------
> 
> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  Documentation/networking/bonding.rst |  6 +++++
>  drivers/net/bonding/bond_main.c      | 39 ++++++++++++++++++++++++++++
>  drivers/net/bonding/bond_options.c   | 34 ++++++++++++++++++++++++
>  drivers/net/bonding/bond_sysfs.c     | 18 +++++++++++++
>  include/net/bond_options.h           |  1 +
>  include/net/bonding.h                |  3 +++
>  6 files changed, 101 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index a4c1291d2561..14f7593d888d 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -562,6 +562,12 @@ lacp_rate
>  
>  	The default is slow.
>  
> +broadcast_neighbor
> +
> +	Option specifying whether to broadcast ARP/ND packets to all
> +	active slaves.  This option has no effect in modes other than
> +	802.3ad mode.  The default is off (0).
> +
>  max_bonds
>  
>  	Specifies the number of bonding devices to create for this
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index d05226484c64..8ee26ddddbc8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -212,6 +212,9 @@ atomic_t netpoll_block_tx = ATOMIC_INIT(0);
>  
>  unsigned int bond_net_id __read_mostly;
>  
> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
> +EXPORT_SYMBOL_GPL(bond_bcast_neigh_enabled);

No need to export the symbol, you can add bond helpers to inc/dec it.

> +
>  static const struct flow_dissector_key flow_keys_bonding_keys[] = {
>  	{
>  		.key_id = FLOW_DISSECTOR_KEY_CONTROL,
> @@ -4480,6 +4483,9 @@ static int bond_close(struct net_device *bond_dev)
>  		bond_alb_deinitialize(bond);
>  	bond->recv_probe = NULL;
>  
> +	if (bond->params.broadcast_neighbor)
> +		static_branch_dec(&bond_bcast_neigh_enabled);
> +

This branch doesn't get re-enabled if the bond is brought up afterwards.

>  	if (bond_uses_primary(bond)) {
>  		rcu_read_lock();
>  		slave = rcu_dereference(bond->curr_active_slave);
> @@ -5316,6 +5322,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>  	return slaves->arr[hash % count];
>  }
>  
> +static inline bool bond_should_broadcast_neighbor(struct sk_buff *skb,

don't use inline in .c files

> +						  struct net_device *dev)
> +{
> +	struct bonding *bond = netdev_priv(dev);
> +
> +	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
> +		return false;
> +
> +	if (!bond->params.broadcast_neighbor)
> +		return false;
> +
> +	if (skb->protocol == htons(ETH_P_ARP))
> +		return true;
> +
> +	if (skb->protocol == htons(ETH_P_IPV6) &&
> +	    pskb_may_pull(skb,
> +			  sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
> +		if (ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
> +			struct icmp6hdr *icmph = icmp6_hdr(skb);
> +
> +			if ((icmph->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) ||
> +			    (icmph->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  /* Use this Xmit function for 3AD as well as XOR modes. The current
>   * usable slave array is formed in the control path. The xmit function
>   * just calculates hash and sends the packet out.
> @@ -5583,6 +5618,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev
>  	case BOND_MODE_ACTIVEBACKUP:
>  		return bond_xmit_activebackup(skb, dev);
>  	case BOND_MODE_8023AD:
> +		if (bond_should_broadcast_neighbor(skb, dev))
> +			return bond_xmit_broadcast(skb, dev);
> +		fallthrough;
>  	case BOND_MODE_XOR:
>  		return bond_3ad_xor_xmit(skb, dev);
>  	case BOND_MODE_BROADCAST:
> @@ -6462,6 +6500,7 @@ static int __init bond_check_params(struct bond_params *params)
>  	eth_zero_addr(params->ad_actor_system);
>  	params->ad_user_port_key = ad_user_port_key;
>  	params->coupled_control = 1;
> +	params->broadcast_neighbor = 0;
>  	if (packets_per_slave > 0) {
>  		params->reciprocal_packets_per_slave =
>  			reciprocal_value(packets_per_slave);
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 91893c29b899..dca52d93f513 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding *bond,
>  				      const struct bond_opt_value *newval);
>  static int bond_option_coupled_control_set(struct bonding *bond,
>  					   const struct bond_opt_value *newval);
> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
> +					   const struct bond_opt_value *newval);
>  
>  static const struct bond_opt_value bond_mode_tbl[] = {
>  	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
> @@ -240,6 +242,12 @@ static const struct bond_opt_value bond_coupled_control_tbl[] = {
>  	{ NULL,  -1, 0},
>  };
>  
> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] = {
> +	{ "on",	 1, 0},
> +	{ "off", 0, BOND_VALFLAG_DEFAULT},

I know the option above is using this order, but it is a bit counter-intuitive to
have their places reversed wrt their values, could you please re-order these as
the other bond on/off options? This is a small nit, I don't have a strong preference
but it is more intuitive to have them in their value order. :)

> +	{ NULL,  -1, 0}> +};
> +
>  static const struct bond_option bond_opts[BOND_OPT_LAST] = {
>  	[BOND_OPT_MODE] = {
>  		.id = BOND_OPT_MODE,
> @@ -513,6 +521,14 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
>  		.flags = BOND_OPTFLAG_IFDOWN,
>  		.values = bond_coupled_control_tbl,
>  		.set = bond_option_coupled_control_set,
> +	},
> +	[BOND_OPT_BROADCAST_NEIGH] = {
> +		.id = BOND_OPT_BROADCAST_NEIGH,
> +		.name = "broadcast_neighbor",
> +		.desc = "Broadcast neighbor packets to all slaves",
> +		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
> +		.values = bond_broadcast_neigh_tbl,
> +		.set = bond_option_broadcast_neigh_set,
>  	}
>  };
>  
> @@ -1840,3 +1856,21 @@ static int bond_option_coupled_control_set(struct bonding *bond,
>  	bond->params.coupled_control = newval->value;
>  	return 0;
>  }
> +
> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
> +					   const struct bond_opt_value *newval)
> +{
> +	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
> +		   newval->value);
> +
> +	if (bond->params.broadcast_neighbor == newval->value)
> +		return 0;
> +
> +	bond->params.broadcast_neighbor = newval->value;
> +	if (bond->params.broadcast_neighbor)
> +		static_branch_inc(&bond_bcast_neigh_enabled);
> +	else
> +		static_branch_dec(&bond_bcast_neigh_enabled);

If the bond has been brought down then the branch has been already decremented.
You'll have to synchronize this with bond open/close or alternatively mark the option
as being able to be changed only when the bond is up (there is an option flag for that).

> +
> +	return 0;
> +}
> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
> index 1e13bb170515..4a53850b2c68 100644
> --- a/drivers/net/bonding/bond_sysfs.c
> +++ b/drivers/net/bonding/bond_sysfs.c
> @@ -752,6 +752,23 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
>  static DEVICE_ATTR(ad_user_port_key, 0644,
>  		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>  
> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct bonding *bond = to_bond(d);
> +	const struct bond_opt_value *val;
> +
> +	val = bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
> +			       bond->params.broadcast_neighbor);
> +
> +	return sysfs_emit(buf, "%s %d\n", val->string,
> +			  bond->params.broadcast_neighbor);
> +}
> +
> +static DEVICE_ATTR(broadcast_neighbor, 0644,
> +		   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
> +

sysfs options are deprecated, please don't extend sysfs
netlink is the preferred way for new options

>  static struct attribute *per_bond_attrs[] = {
>  	&dev_attr_slaves.attr,
>  	&dev_attr_mode.attr,
> @@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] = {
>  	&dev_attr_ad_actor_system.attr,
>  	&dev_attr_ad_user_port_key.attr,
>  	&dev_attr_arp_missed_max.attr,
> +	&dev_attr_broadcast_neighbor.attr,
>  	NULL,
>  };
>  
> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> index 18687ccf0638..022b122a9fb6 100644
> --- a/include/net/bond_options.h
> +++ b/include/net/bond_options.h
> @@ -77,6 +77,7 @@ enum {
>  	BOND_OPT_NS_TARGETS,
>  	BOND_OPT_PRIO,
>  	BOND_OPT_COUPLED_CONTROL,
> +	BOND_OPT_BROADCAST_NEIGH,
>  	BOND_OPT_LAST
>  };
>  
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 95f67b308c19..e06f0d63b2c1 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct net_device *dev)
>  #define is_netpoll_tx_blocked(dev) (0)
>  #endif
>  
> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
> +
>  struct bond_params {
>  	int mode;
>  	int xmit_policy;
> @@ -149,6 +151,7 @@ struct bond_params {
>  	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>  #endif
>  	int coupled_control;
> +	int broadcast_neighbor;
>  
>  	/* 2 bytes of padding : see ether_addr_equal_64bits() */
>  	u8 ad_actor_system[ETH_ALEN + 2];


