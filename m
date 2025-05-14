Return-Path: <netdev+bounces-190336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4525AB64C7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444FF19E1EC4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B4200B8B;
	Wed, 14 May 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MWemQr4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425451805B
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208699; cv=none; b=NsARy0QpxtEDLQghmY4aD8tShB8nrVOWMcd/omYrDB3UxlV5gtCelKCfmH8RnJrgOJkTyYec7ZXg8UR8bErLRt/m5sGzLyoh2Y4YCAk4AjXyLf/9pqciZ2l6Q3Ynt/8QF8Iq2pVo4y3lNFC+3+5or9zG2JOsmjEVqQkqxtQ7Xb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208699; c=relaxed/simple;
	bh=DYz9tHI8gPlO03N3KPJvwkppbRqenLsi5af1lCCQlg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am5+8aMi0iWVqhxDwET1tooYrdWezJqgtJ7w6QCN9dOmmQLyglRz+aTB1KSCGLMG5xLk5hND/Kvd+xdYFDTZvEhiRyuZf997uzxKW+qDeMAyaIPdRhOqgtLGQjBhxDMLXPBaOeod4z7HWVcelDUTsMHvznAhhEjbpYzyUXYuN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MWemQr4B; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ea95f738so14786595e9.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747208695; x=1747813495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+ImlgM0GqxDxF9cp+1QAwsAwCgIU4DJsD3NdBlFy4Y=;
        b=MWemQr4BXKglqqCZzPfAgAsajQPhrfEQZ7bzsGCIcLBuFTgWqXXvO/OWFycsremwG4
         NBjRtXqvU0cxbWnykfCMhfYr60yHGaETTYm7oOvmDiIA0LIXV3E2UsnhTAwu2kNvTgdE
         LHeM7OpbuLesHB9lbxFpz9nMiJKBjzJ3mHu1yZZkI2Ws1Oc2pNNSPmcRr1SL+cLVhTRi
         e1ZZTIvkZCGvE9c9OvY9P4+sQSwYXPQXCAlp5sBzXlYk5ODY8T4yG2izvsAm6Hu6CGfz
         OkCAS7UStRZy97/Sl1V18QYzT1VOtDIVhfxDba2QCaYtaJuoPATwT4XmIz8NjYc7N/Wa
         63TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747208695; x=1747813495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+ImlgM0GqxDxF9cp+1QAwsAwCgIU4DJsD3NdBlFy4Y=;
        b=YhlyOmrQgVQLPA25NB6ZwwabXYSigOMPuyYpOpj5LPPQJ1Ybyb2IT9CP0P0P1NKaKX
         CzsitpOND65T3wzzfe3Nn38qNsFSfF5Otoyv95sI3hh356thjeHUTRa5TtDnPDS1qjHT
         /nGFqn8hUb9pG3QMJ69OHYUGWD49Panvsjwa4k6Zq8iQhS6u16rFLppIbWnzYEAuVZQW
         XuTF0F2zwcTlYfM3wjtfnhGbdGwWNIctsK55YqkpeahlhY8mSuJiut7Txn0XPyf526Sm
         Jcuo3lAdX02OTKMF0/3TXNrxmnL/mrKKhfeSlPMKob5UFMcvJPmJm5UGx2CzTOKwkFG8
         SzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSSRI8XbVQpFLYT5HQmqrdWLYC7ZTn/T/KyR5OkBxdk6bwz5QmJAytNvU/lSh0UoopSjOBieg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JuY2xFbhcDjO1ZwMyo4Y1inWcWrg6nZ5sA/L+LzEdo2ciTyp
	t1aOIIuI7aAwUcw1BmFzfgJqiFD0ZMAttL6q4sfXMZ67B1Ma6y9fxiKKODWl530HYlwAWYWc91z
	0
X-Gm-Gg: ASbGncvgRlVX5d35v1ykdsJ1ZWZOSnhnQtbTWYgCS9SRTrxvQF8tO6X1da3I5RQsE+y
	AeAg3DU87va9P/rXEnUucwy1OUz+BV2lPAwucqb52BnfaMr5EsmFoWSPY7gx4qhhdj+Mr0/h+zA
	BmR8QeQDmoBp3eOYbDH1gbyGUOi3mPyK0Yq1FCu1d+rQT/2LCQ/pNQVW0wYJD48VKSDlGPUWeZV
	rjXadvaIEfgLEBuMMJFLZQjmJzhWwWpYv5Me3e9OVF4ImNOz9KguKv11u9RozN6L2xh93T09TuK
	5hvo5W/gIbc4CdZ+53WWRrdzpT/37B+hH+4CVgHdh+COKmp0v2eTuCVmR0/mRy8HEwNOLkxGxfY
	tG1C7TA+UZ7+zjEozvg==
X-Google-Smtp-Source: AGHT+IEsZhlHqJxUB/Nia8f0oBQ5OJ9HXZmL24zW3zkmqeRlAXlghohjOHskvaWy4lrdvoQ0d2c0kA==
X-Received: by 2002:a05:600c:1383:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-442f217773amr19154475e9.30.1747208695168;
        Wed, 14 May 2025 00:44:55 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368d1csm18816585e9.8.2025.05.14.00.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 00:44:54 -0700 (PDT)
Message-ID: <e1bfca22-0489-48a3-8927-c57c23d8f15c@blackwall.org>
Date: Wed, 14 May 2025 10:44:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
 <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 10:13, Tonghao Zhang wrote:
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
>        -----------------
>       |   bond4 lacp    |
>        -----------------
>          |           |
>          | NIC1      | NIC2
>        -----------------
>       |     server      |
>        -----------------
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
>  Documentation/networking/bonding.rst |  6 ++++
>  drivers/net/bonding/bond_main.c      | 41 ++++++++++++++++++++++++++++
>  drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++
>  include/net/bond_options.h           |  1 +
>  include/net/bonding.h                |  3 ++
>  5 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst> index a4c1291d2561..14f7593d888d 100644
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
> index d05226484c64..db6a9c8db47c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -212,6 +212,8 @@ atomic_t netpoll_block_tx = ATOMIC_INIT(0);
>  
>  unsigned int bond_net_id __read_mostly;
>  
> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
> +
>  static const struct flow_dissector_key flow_keys_bonding_keys[] = {
>  	{
>  		.key_id = FLOW_DISSECTOR_KEY_CONTROL,
> @@ -4461,6 +4463,9 @@ static int bond_open(struct net_device *bond_dev)
>  
>  		bond_for_each_slave(bond, slave, iter)
>  			dev_mc_add(slave->dev, lacpdu_mcast_addr);
> +
> +		if (bond->params.broadcast_neighbor)
> +			static_branch_inc(&bond_bcast_neigh_enabled);

So this gets increased only when the mode is 802.3ad, good, but...

>  	}
>  
>  	if (bond_mode_can_use_xmit_hash(bond))
> @@ -4480,6 +4485,9 @@ static int bond_close(struct net_device *bond_dev)
>  		bond_alb_deinitialize(bond);
>  	bond->recv_probe = NULL;
>  
> +	if (bond->params.broadcast_neighbor)
> +		static_branch_dec(&bond_bcast_neigh_enabled);
> +

... this gets decreased for every mode. That can result in an imbalance because you
can set broadcast_neighbor in 3ad and later change the mode, then cycling the bond
up/down would cause only the _dec to be called.

>  	if (bond_uses_primary(bond)) {
>  		rcu_read_lock();
>  		slave = rcu_dereference(bond->curr_active_slave);
> @@ -5316,6 +5324,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>  	return slaves->arr[hash % count];
>  }
>  
> +static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
> +					   struct net_device *dev)
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
> @@ -5583,6 +5620,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev
>  	case BOND_MODE_ACTIVEBACKUP:
>  		return bond_xmit_activebackup(skb, dev);
>  	case BOND_MODE_8023AD:
> +		if (bond_should_broadcast_neighbor(skb, dev))
> +			return bond_xmit_broadcast(skb, dev);
> +		fallthrough;
>  	case BOND_MODE_XOR:
>  		return bond_3ad_xor_xmit(skb, dev);
>  	case BOND_MODE_BROADCAST:
> @@ -6462,6 +6502,7 @@ static int __init bond_check_params(struct bond_params *params)
>  	eth_zero_addr(params->ad_actor_system);
>  	params->ad_user_port_key = ad_user_port_key;
>  	params->coupled_control = 1;
> +	params->broadcast_neighbor = 0;
>  	if (packets_per_slave > 0) {
>  		params->reciprocal_packets_per_slave =
>  			reciprocal_value(packets_per_slave);
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 91893c29b899..7f0939337231 100644
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
> +	{ "off", 0, BOND_VALFLAG_DEFAULT},
> +	{ "on",	 1, 0},
> +	{ NULL,  -1, 0}
> +};
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
> @@ -1840,3 +1856,22 @@ static int bond_option_coupled_control_set(struct bonding *bond,
>  	bond->params.coupled_control = newval->value;
>  	return 0;
>  }
> +
> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
> +					   const struct bond_opt_value *newval)
> +{
> +	if (bond->params.broadcast_neighbor == newval->value)
> +		return 0;
> +
> +	bond->params.broadcast_neighbor = newval->value;
> +	if (bond->dev->flags & IFF_UP) {
> +		if (bond->params.broadcast_neighbor)
> +			static_branch_inc(&bond_bcast_neigh_enabled);
> +		else
> +			static_branch_dec(&bond_bcast_neigh_enabled);
> +	}
> +
> +	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %s (%llu)\n",
> +		   newval->string, newval->value);
> +	return 0;
> +}
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


