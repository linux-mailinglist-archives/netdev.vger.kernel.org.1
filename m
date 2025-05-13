Return-Path: <netdev+bounces-190145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9BBAB5497
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BD617E385
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA124C67B;
	Tue, 13 May 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Gll+7dKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373323D29F
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138806; cv=none; b=Wjrso/aVgZxAqsnKzyMPCPQ/8NwpOhE0REVFCN4ndXjuUYWMUjsrGkC1s23dYSQKMH4YwklmsRVQHC13HVsY9tpMABLclCSohCtldAsHWKa1NIUpbtzGbiXhIn9pqts1lx0QiRX9acKjwjWWCrhHHK7RHzDn9L2YyEmL6wmjBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138806; c=relaxed/simple;
	bh=O30ZQHOHBbEIxdljymkcy+PqjcrjgalkBS40RvHfqu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=japDEeMbv54Hz3+HMz/uiMRnC15u40cpyQ866ghCQduGGR7T+m2InIBaBuuBey4AiSCo1L0d1CNmsvVcUwRFbIL66IuXzATM6zoSDldEnbqwxjuonsuq5MMoqLPmGOi47hEzNemSzfw4UP5IIv4tdDJR1oaMwfh3iJxlKd2svzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Gll+7dKc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac34257295dso932499166b.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747138803; x=1747743603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JENIiCCXi6g9a6IrBUusC56Ztxszu8UrXW5C+zl3dg8=;
        b=Gll+7dKc4UMNLclyWLmU9cSNcTWgDIrv66noC4D2QGZJPZzuA8pzEDPEcpkyN6CBYL
         CBcGudE4m2eN/ouqSO9Tp/B3TjzcEFEs72YGReIgS0+a3Fwbk9WFcY4FAZxK0BDjQqpV
         Zmg64h23MlU4VFlS67jaI+YsTa5yuzyDYA0J6pdNR1O1VCUemADpyyx6havLUPGjjJmV
         e7Yl6Hou/meJY3oOjy/jfRsVIrLImGC6B8BXDwnZEfihtnw+nnJarQJOilbCJ6Ykz12A
         V4Xn0PyrA8/c+z+9l8pOGAi+y0Pd9h5ElOgDrRstZxEj154fw+8jZJiUw9p93oU5YUcu
         /cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747138803; x=1747743603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JENIiCCXi6g9a6IrBUusC56Ztxszu8UrXW5C+zl3dg8=;
        b=ut5SXCYbk+4kGEQk8KCQfVGmM9gqm1I3A6UMy/UI/OQ0qwYYNRzYdRe/83Iz/BGFrT
         F9JX7M1zzPKjlNkmuEvuQMrn2BU5QGYbsubr1iZOLgZzINQe9uSU+17WjtHt3bI4WxyT
         l83uLl95bfEiUR5fr0k/AoV6fUFcGc9v+FS4iTLthL9hDipFDymOjKob/RiYMzE4IRvD
         AgeWpoyzD1rUWf4jzIIYrhD2lPrTh7Mg8SbdJv9WDI8BCRjYXzayNtLIg07tFvIBjzzR
         pg6dXNnYBB0ppPTJcg/fzZGPxLHMbGM3tPk4oKovtoGVAZFbnjnix7J1DobmgfP7K9DZ
         3W8w==
X-Gm-Message-State: AOJu0Yy+1vpcWuxYihG/Qdym0luwYIZo3t9OEjev5Op+LZW6eLH+xnOH
	ioFN6lRKviE7b3K6m1LV5fHZLem5iSc9BpG+Qjf4DQa2dgTZXGsVzXfu3GkvyiM=
X-Gm-Gg: ASbGncudw4UM1n4NUgmXZj7rruK72FrdGy3QoSeUc6Bo/9mfsgViXx6T69tEI4/H0mS
	LY8U/k3TEXx00hgTUFpvy1fMmRYAYlep0JQvJ2+SY9YIzhnuJegRDOF4FqVKWk/7TlnOVGfwFKZ
	fdfLC+bCweb8peVOO63NBTZZINZ0WT1dg+lKtBBDTCatoUuiCBTvxD14euwUV90xzAi1NZ73lJT
	JPoWQ8AmvPpfoZphwvmdQ+dkou8m/b3MYJaxQHv0dFqpiUlsS0VP8hUSBdJvb0VH/kTMHGUdD9O
	cdgQTWoUy7QhVDQybqxVIw9Jb2C0jdauv3z4M0ZIKwJgUhhQz5rryROVhpnGXWSCsaWlTZCaGSe
	4bwpL2S8=
X-Google-Smtp-Source: AGHT+IGJrz0GT8cAflERN4xAyl8FdLKXk/2phIcdTRDOae55yRq2NQx9U2bElmMFsU+2T6HL5BMiCw==
X-Received: by 2002:a17:907:3f1b:b0:ad2:51d8:791b with SMTP id a640c23a62f3a-ad251d87a39mr819253566b.19.1747138802292;
        Tue, 13 May 2025 05:20:02 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22af68929sm652519266b.16.2025.05.13.05.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 05:20:01 -0700 (PDT)
Message-ID: <d0e0379e-79fb-4a95-b160-6c1ca4276081@blackwall.org>
Date: Tue, 13 May 2025 15:20:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, jv@jvosburgh.net
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
 <4270C010E5516F3B+20250513094750.23387-2-tonghao@bamaicloud.com>
 <f690dc4a-fde8-411d-84d8-67980555f479@blackwall.org>
 <191F1618-E561-4B82-84E3-1E19E22197F3@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <191F1618-E561-4B82-84E3-1E19E22197F3@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/13/25 15:13, Tonghao Zhang wrote:
> 
> 
>> 2025年5月13日 18:18，Nikolay Aleksandrov <razor@blackwall.org> 写道：
>>
>> On 5/13/25 12:47, Tonghao Zhang wrote:
>>> Stacking technology is a type of technology used to expand ports on
>>> Ethernet switches. It is widely used as a common access method in
>>> large-scale Internet data center architectures. Years of practice
>>> have proved that stacking technology has advantages and disadvantages
>>> in high-reliability network architecture scenarios. For instance,
>>> in stacking networking arch, conventional switch system upgrades
>>> require multiple stacked devices to restart at the same time.
>>> Therefore, it is inevitable that the business will be interrupted
>>> for a while. It is for this reason that "no-stacking" in data centers
>>> has become a trend. Additionally, when the stacking link connecting
>>> the switches fails or is abnormal, the stack will split. Although it is
>>> not common, it still happens in actual operation. The problem is that
>>> after the split, it is equivalent to two switches with the same configuration
>>> appearing in the network, causing network configuration conflicts and
>>> ultimately interrupting the services carried by the stacking system.
>>>
>>> To improve network stability, "non-stacking" solutions have been increasingly
>>> adopted, particularly by public cloud providers and tech companies
>>> like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing switch
>>> stacking that convinces a LACP peer, bonding in this case, connected to a set of
>>> "non-stacked" switches that all of its ports are connected to a single
>>> switch (i.e., LACP aggregator), as if those switches were stacked. This
>>> enables the LACP peer's ports to aggregate together, and requires (a)
>>> special switch configuration, described in the linked article, and (b)
>>> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
>>> packets across all ports of the active aggregator.
>>>
>>>  -----------     -----------
>>> |  switch1  |   |  switch2  |
>>>  -----------     -----------
>>>         ^           ^
>>>         |           |
>>>        ---------------
>>>       |   bond4 lacp  |
>>>        ---------------
>>>         | NIC1      | NIC2
>>>     ---------------------
>>>    |       server        |
>>>     ---------------------
>>>
>>> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/
>>>
>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Simon Horman <horms@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>> ---
>>> Documentation/networking/bonding.rst |  6 +++++
>>> drivers/net/bonding/bond_main.c      | 39 ++++++++++++++++++++++++++++
>>> drivers/net/bonding/bond_options.c   | 34 ++++++++++++++++++++++++
>>> drivers/net/bonding/bond_sysfs.c     | 18 +++++++++++++
>>> include/net/bond_options.h           |  1 +
>>> include/net/bonding.h                |  3 +++
>>> 6 files changed, 101 insertions(+)
>>>
>>> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
>>> index a4c1291d2561..14f7593d888d 100644
>>> --- a/Documentation/networking/bonding.rst
>>> +++ b/Documentation/networking/bonding.rst
>>> @@ -562,6 +562,12 @@ lacp_rate
>>>
>>> The default is slow.
>>>
>>> +broadcast_neighbor
>>> +
>>> + Option specifying whether to broadcast ARP/ND packets to all
>>> + active slaves.  This option has no effect in modes other than
>>> + 802.3ad mode.  The default is off (0).
>>> +
>>> max_bonds
>>>
>>> Specifies the number of bonding devices to create for this
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index d05226484c64..8ee26ddddbc8 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -212,6 +212,9 @@ atomic_t netpoll_block_tx = ATOMIC_INIT(0);
>>>
>>> unsigned int bond_net_id __read_mostly;
>>>
>>> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>> +EXPORT_SYMBOL_GPL(bond_bcast_neigh_enabled);
>>
>> No need to export the symbol, you can add bond helpers to inc/dec it.
>>
>>> +
>>> static const struct flow_dissector_key flow_keys_bonding_keys[] = {
>>> {
>>> .key_id = FLOW_DISSECTOR_KEY_CONTROL,
>>> @@ -4480,6 +4483,9 @@ static int bond_close(struct net_device *bond_dev)
>>> bond_alb_deinitialize(bond);
>>> bond->recv_probe = NULL;
>>>
>>> + if (bond->params.broadcast_neighbor)
>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>> +
>>
>> This branch doesn't get re-enabled if the bond is brought up afterwards.
> This is not right place to dec bond_bcast_neigh_enabled, I should dec this value in bond_uninit(). Because we can destroy a bond net device which broadcast_neighbor enabled.
> If we don’t check broadcast_neighbor in destroy path. bond_bcast_neigh_enabled always is enabled. For example:
> ip link add bondx type bond mode 802.3ad ... broadcast_neighbor on
> ip link add bondy type bond mode 802.3ad ... broadcast_neighbor off
> 
> ip li del dev bondx
> In this case, bond_bcast_neigh_enabled is enabled for bondy while broadcast_neighbor is off.
> 
>>>>> if (bond_uses_primary(bond)) {
>>> rcu_read_lock();
>>> slave = rcu_dereference(bond->curr_active_slave);
>>> @@ -5316,6 +5322,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>>> return slaves->arr[hash % count];
>>> }
>>>
>>> +static inline bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>>
>> don't use inline in .c files
> As suggested by Jay, inline the codes for performance. I think it is better to keep inline. By the way, there are many inline function in bond_main.c and other *.c

This is a general rule, the compiler knows what to do. The inlines in bond_main are old
and can be removed. Do not add new ones.

>>> +  struct net_device *dev)
>>> +{
>>> + struct bonding *bond = netdev_priv(dev);
>>> +
>>> + if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>>> + return false;
>>> +
>>> + if (!bond->params.broadcast_neighbor)
>>> + return false;
>>> +
>>> + if (skb->protocol == htons(ETH_P_ARP))
>>> + return true;
>>> +
>>> + if (skb->protocol == htons(ETH_P_IPV6) &&
>>> +    pskb_may_pull(skb,
>>> +  sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
>>> + if (ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
>>> + struct icmp6hdr *icmph = icmp6_hdr(skb);
>>> +
>>> + if ((icmph->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) ||
>>> +    (icmph->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
>>> + return true;
>>> + }
>>> + }
>>> +
>>> + return false;
>>> +}
>>> +
>>> /* Use this Xmit function for 3AD as well as XOR modes. The current
>>>  * usable slave array is formed in the control path. The xmit function
>>>  * just calculates hash and sends the packet out.
>>> @@ -5583,6 +5618,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev
>>> case BOND_MODE_ACTIVEBACKUP:
>>> return bond_xmit_activebackup(skb, dev);
>>> case BOND_MODE_8023AD:
>>> + if (bond_should_broadcast_neighbor(skb, dev))
>>> + return bond_xmit_broadcast(skb, dev);
>>> + fallthrough;
>>> case BOND_MODE_XOR:
>>> return bond_3ad_xor_xmit(skb, dev);
>>> case BOND_MODE_BROADCAST:
>>> @@ -6462,6 +6500,7 @@ static int __init bond_check_params(struct bond_params *params)
>>> eth_zero_addr(params->ad_actor_system);
>>> params->ad_user_port_key = ad_user_port_key;
>>> params->coupled_control = 1;
>>> + params->broadcast_neighbor = 0;
>>> if (packets_per_slave > 0) {
>>> params->reciprocal_packets_per_slave =
>>> reciprocal_value(packets_per_slave);
>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>>> index 91893c29b899..dca52d93f513 100644
>>> --- a/drivers/net/bonding/bond_options.c
>>> +++ b/drivers/net/bonding/bond_options.c
>>> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding *bond,
>>>      const struct bond_opt_value *newval);
>>> static int bond_option_coupled_control_set(struct bonding *bond,
>>>   const struct bond_opt_value *newval);
>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>> +   const struct bond_opt_value *newval);
>>>
>>> static const struct bond_opt_value bond_mode_tbl[] = {
>>> { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>>> @@ -240,6 +242,12 @@ static const struct bond_opt_value bond_coupled_control_tbl[] = {
>>> { NULL,  -1, 0},
>>> };
>>>
>>> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] = {
>>> + { "on", 1, 0},
>>> + { "off", 0, BOND_VALFLAG_DEFAULT},
>>
>> I know the option above is using this order, but it is a bit counter-intuitive to
>> have their places reversed wrt their values, could you please re-order these as
>> the other bond on/off options? This is a small nit, I don't have a strong preference
>> but it is more intuitive to have them in their value order. :)
> Ok
>>
>>> + { NULL,  -1, 0}> +};
>>> +
>>> static const struct bond_option bond_opts[BOND_OPT_LAST] = {
>>> [BOND_OPT_MODE] = {
>>> .id = BOND_OPT_MODE,
>>> @@ -513,6 +521,14 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
>>> .flags = BOND_OPTFLAG_IFDOWN,
>>> .values = bond_coupled_control_tbl,
>>> .set = bond_option_coupled_control_set,
>>> + },
>>> + [BOND_OPT_BROADCAST_NEIGH] = {
>>> + .id = BOND_OPT_BROADCAST_NEIGH,
>>> + .name = "broadcast_neighbor",
>>> + .desc = "Broadcast neighbor packets to all slaves",
>>> + .unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>>> + .values = bond_broadcast_neigh_tbl,
>>> + .set = bond_option_broadcast_neigh_set,
>>> }
>>> };
>>>
>>> @@ -1840,3 +1856,21 @@ static int bond_option_coupled_control_set(struct bonding *bond,
>>> bond->params.coupled_control = newval->value;
>>> return 0;
>>> }
>>> +
>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>> +   const struct bond_opt_value *newval)
>>> +{
>>> + netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
>>> +   newval->value);
>>> +
>>> + if (bond->params.broadcast_neighbor == newval->value)
>>> + return 0;
>>> +
>>> + bond->params.broadcast_neighbor = newval->value;
>>> + if (bond->params.broadcast_neighbor)
>>> + static_branch_inc(&bond_bcast_neigh_enabled);
>>> + else
>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>
>> If the bond has been brought down then the branch has been already decremented.
>> You'll have to synchronize this with bond open/close or alternatively mark the option
>> as being able to be changed only when the bond is up (there is an option flag for that).
> I will check bond_bcast_neigh_enabled in bond_unint() instead of in bond_close().
>>>>
>>> +
>>> + return 0;
>>> +}
>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
>>> index 1e13bb170515..4a53850b2c68 100644
>>> --- a/drivers/net/bonding/bond_sysfs.c
>>> +++ b/drivers/net/bonding/bond_sysfs.c
>>> @@ -752,6 +752,23 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
>>> static DEVICE_ATTR(ad_user_port_key, 0644,
>>>   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>>>
>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>>> +       struct device_attribute *attr,
>>> +       char *buf)
>>> +{
>>> + struct bonding *bond = to_bond(d);
>>> + const struct bond_opt_value *val;
>>> +
>>> + val = bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
>>> +       bond->params.broadcast_neighbor);
>>> +
>>> + return sysfs_emit(buf, "%s %d\n", val->string,
>>> +  bond->params.broadcast_neighbor);
>>> +}
>>> +
>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>>> +   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>>> +
>>
>> sysfs options are deprecated, please don't extend sysfs
>> netlink is the preferred way for new options
> I think it is still useful to config option via sysfs, and I find other new option still use the sysfs.

This is wrong, there are no new options that have been added to sysfs recently,
the latest option being "coupled_control". As I already said - sysfs has been deprecated
for quite some time, don't add new options to it.

>>
>>> static struct attribute *per_bond_attrs[] = {
>>> &dev_attr_slaves.attr,
>>> &dev_attr_mode.attr,
>>> @@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] = {
>>> &dev_attr_ad_actor_system.attr,
>>> &dev_attr_ad_user_port_key.attr,
>>> &dev_attr_arp_missed_max.attr,
>>> + &dev_attr_broadcast_neighbor.attr,
>>> NULL,
>>> };
>>>
>>> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>>> index 18687ccf0638..022b122a9fb6 100644
>>> --- a/include/net/bond_options.h
>>> +++ b/include/net/bond_options.h
>>> @@ -77,6 +77,7 @@ enum {
>>> BOND_OPT_NS_TARGETS,
>>> BOND_OPT_PRIO,
>>> BOND_OPT_COUPLED_CONTROL,
>>> + BOND_OPT_BROADCAST_NEIGH,
>>> BOND_OPT_LAST
>>> };
>>>
>>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>>> index 95f67b308c19..e06f0d63b2c1 100644
>>> --- a/include/net/bonding.h
>>> +++ b/include/net/bonding.h
>>> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct net_device *dev)
>>> #define is_netpoll_tx_blocked(dev) (0)
>>> #endif
>>>
>>> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>> +
>>> struct bond_params {
>>> int mode;
>>> int xmit_policy;
>>> @@ -149,6 +151,7 @@ struct bond_params {
>>> struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>>> #endif
>>> int coupled_control;
>>> + int broadcast_neighbor;
>>>
>>> /* 2 bytes of padding : see ether_addr_equal_64bits() */
>>> u8 ad_actor_system[ETH_ALEN + 2];
>>
>>
>>
> 


