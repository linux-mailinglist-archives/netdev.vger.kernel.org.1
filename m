Return-Path: <netdev+bounces-193666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D6AC5069
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1473A9C30
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147424290C;
	Tue, 27 May 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvL9qJXw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012B126C02
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354456; cv=none; b=ib63Hr/zo9r1LIWsEeFwmmK1TH1FqYE4BB+dxPCq+1FBS3GQDG3ABM93Z3unXkMLyWin3QBKKUWklfm3qBszD0vDR2NtZaKqzfHzb8sY+MEmLXtTdArKkuWmYagLhdLFIxWFd19jFGFonXmSvUxSPnCZ9yF2aABMCuq1ZWhWdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354456; c=relaxed/simple;
	bh=xMq6fC/xF/nSBchG4lEX+1DmxQvmghbJu6JGQW6yEBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qp+FjfFKELU8FOSFimHARrve1rQAmaqzWDk7KtskLGOU9YFzQPq+e7TOIJEfTZN2m0gxWcTxWY2Ayr0YNOfxLL6/SXE859XSwqkQnA6ZjWG3ncl/ZZQWg5aYOczmIWpwvaudyZR2SBbo1Lr4wUYe6dIYbvW3jmFMSSrUI6bc4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvL9qJXw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748354453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmWjAbWXBUf4SVOpmXQtAjEWRKjXsHdS/ogjEuqBjN4=;
	b=GvL9qJXwlr9iqyA4g416xcZkiYVSoXPEAd6WHJVRu4FU1V+c2WLckvU/i682Hq1KpXcvoh
	MXV64ZpNsvSS/vqkjlDQZWjWSq1pmyobnUN4jsRrJ2mUP2QJACgfzn1yGDAgeDdrKph1Bt
	uIrNJx19MPySXnZIoUNjrxLd5EQ3CSo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-exaHNoLjNlOPS77rxXL3Sw-1; Tue, 27 May 2025 10:00:48 -0400
X-MC-Unique: exaHNoLjNlOPS77rxXL3Sw-1
X-Mimecast-MFC-AGG-ID: exaHNoLjNlOPS77rxXL3Sw_1748354447
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3561206b3so1521608f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748354447; x=1748959247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmWjAbWXBUf4SVOpmXQtAjEWRKjXsHdS/ogjEuqBjN4=;
        b=Iccy85IZOtEU0BRnlNyNYMeznS4ccR0KtSnG0Pa1Vm2ekjr1u4cckTWuB5JrlXAVCI
         c9+RzGq6cWhdM62GCEVrCHuEVyNkthTgMPTNAjvOjHSPVhs/BdoaZTk6A/FOjuI5QB3c
         2Vq/JzE2yniwC8Kjrim1S8Rajzkx+t7tfsPQct5rbN3WvJya5L0hvVZc+Yk36mGa0EmR
         cRVLqN5LswRh4RvUu3z4avy5GEELH0/y53jJ8Ws7GU38vNQM6rP1SuN2HFO2qWQU/IcK
         LT+00DH1GB7G55EAS9ltDmxYxLO7KaZhInSJiafD8VQECioeyzl1KgbigK0Cb3QxVO05
         1VVA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7KebXTSk5bOpv0iYSnzl+RVeu08+7rIvTNmsk5oHk4Z3QnAXjNfVjCDtfuTuwrI0ju3Ys1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1M5zdQnMRM16BPc4S2oX/EIH5l6DELhcdaW15Kt/l3LcDYVoJ
	rC3V95eOgqlHGHSH0uOavq8BjzQ3HMVuZI1bEz8SvwxaYjwh9AgXlF8gpiKyZI8sl8Bi2H+JmH7
	tcTs+946tgkdY3aUFLp+dUnr3Ks1eZSk0If0EbOoUe3mnlC8Xb+IZ/aEJug==
X-Gm-Gg: ASbGncuBShwCixQB8KzgqnUQQ3oiKB6mBk2a7z7+LnlLT1f2NmM+jfvBeWnpRCAJbtD
	WeDxIZHFIa2wsCThq79b4XtvVBVDGAdSAvTC76sXUroKD2VQwBK4RKKPjbTJk46+bI11PIcMi0o
	Ac/q2x9tXr4mYY+S7AOXtGzbxRNcFnTj1sun4kz2oXGphsjChPLthKWb1CNUQGey3RAD9tPfHKl
	67iuXxk5Rn3+TsLBOaeg9pJwdVwG57K253vhDwAag3cKZy8337WrsqrLwjYapUgqSc/EQnKAjsf
	mg64Swl82wxgOxG6/xU=
X-Received: by 2002:a5d:5f81:0:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a4dc931f93mr5710067f8f.1.1748354447030;
        Tue, 27 May 2025 07:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS9+5C1LiSYxqGNKnFb8QYBrePRf1K41z+cCX6Xc7nZl/SVzVEwwgNaEpEigoZYBLN3qS6dw==
X-Received: by 2002:a5d:5f81:0:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a4dc931f93mr5710009f8f.1.1748354446417;
        Tue, 27 May 2025 07:00:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db4e6f15sm5241081f8f.81.2025.05.27.07.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 07:00:45 -0700 (PDT)
Message-ID: <e999e9a0-19d3-4519-8094-268a67f5da63@redhat.com>
Date: Tue, 27 May 2025 16:00:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 1/4] net: bonding: add
 broadcast_neighbor option for 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-2-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250522085516.16355-2-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 10:55 AM, Tonghao Zhang wrote:
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
> after the split, it is equivalent to two switches with the same
> configuration appearing in the network, causing network configuration
> conflicts and ultimately interrupting the services carried by the
> stacking system.
> 
> To improve network stability, "non-stacking" solutions have been
> increasingly adopted, particularly by public cloud providers and
> tech companies like Alibaba, Tencent, and Didi. "non-stacking" is
> a method of mimicing switch stacking that convinces a LACP peer,
> bonding in this case, connected to a set of "non-stacked" switches
> that all of its ports are connected to a single switch
> (i.e., LACP aggregator), as if those switches were stacked. This
> enables the LACP peer's ports to aggregate together, and requires
> (a) special switch configuration, described in the linked article,
> and (b) modifications to the bonding 802.3ad (LACP) mode to send
> all ARP/ND packets across all ports of the active aggregator.
> 
> Note that, with multiple aggregators, the current broadcast mode
> logic will send only packets to the selected aggregator(s).
> 
>  +-----------+   +-----------+
>  |  switch1  |   |  switch2  |
>  +-----------+   +-----------+
>          ^           ^
>          |           |
>       +-----------------+
>       |   bond4 lacp    |
>       +-----------------+
>          |           |
>          | NIC1      | NIC2
>       +-----------------+
>       |     server      |
>       +-----------------+


IHMO all the above wording should be placed in the cover letter. This
commit message should instead be more related to the actual code.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index d05226484c64..b5c34d7f126c 100644
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
>  	}
>  
>  	if (bond_mode_can_use_xmit_hash(bond))
> @@ -4480,6 +4485,10 @@ static int bond_close(struct net_device *bond_dev)
>  		bond_alb_deinitialize(bond);
>  	bond->recv_probe = NULL;
>  
> +	if (BOND_MODE(bond) == BOND_MODE_8023AD &&
> +	    bond->params.broadcast_neighbor)
> +		static_branch_dec(&bond_bcast_neigh_enabled);

What if the user enables BOND_OPT_BROADCAST_NEIGH and later switch the
bond mode? it looks like there will be bad accounting for static branch.

> +
>  	if (bond_uses_primary(bond)) {
>  		rcu_read_lock();
>  		slave = rcu_dereference(bond->curr_active_slave);
> @@ -5316,6 +5325,37 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>  	return slaves->arr[hash % count];
>  }
>  
> +static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
> +					   struct net_device *dev)
> +{
> +	struct bonding *bond = netdev_priv(dev);
> +	struct {
> +		struct ipv6hdr ip6;
> +		struct icmp6hdr icmp6;
> +	} *combined, _combined;
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
> +	if (skb->protocol == htons(ETH_P_IPV6)) {
> +		combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> +					      sizeof(_combined),
> +					      &_combined);
> +		if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
> +		    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> +		     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Use this Xmit function for 3AD as well as XOR modes. The current
>   * usable slave array is formed in the control path. The xmit function
>   * just calculates hash and sends the packet out.
> @@ -5337,15 +5377,25 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>  
>  /* in broadcast mode, we send everything to all usable interfaces. */
>  static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
> -				       struct net_device *bond_dev)
> +				       struct net_device *bond_dev,
> +				       bool all_slaves)
>  {
>  	struct bonding *bond = netdev_priv(bond_dev);
> -	struct slave *slave = NULL;
> -	struct list_head *iter;
> +	struct bond_up_slave *slaves;
>  	bool xmit_suc = false;
>  	bool skb_used = false;
> +	int slaves_count, i;
>  
> -	bond_for_each_slave_rcu(bond, slave, iter) {
> +	rcu_read_lock();

Why this the RCU lock is now needed? AFAICS the caller scope does not
change. This is either not needed, or deserves a separate patch, with a
suitable fixes tag.

/P


