Return-Path: <netdev+bounces-232062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA38C00705
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41F84E48BB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031B3009E1;
	Thu, 23 Oct 2025 10:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950372F616A;
	Thu, 23 Oct 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214886; cv=none; b=KwtFTj8wK8AXSRKcrgm19wLq+rOLu6jVsNb+NCKKM1cMDB1EJDz6JqQB8DX5zqKs2D7T6cW2V+3SaNypijhbMIwMAS1TV+f8F1IpCWmxQ9yK134dvYlHBVIJjnBiOY3/flcwIVPJnTV1CO1pTblaDEEtvDhV13DalZmpIukYRuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214886; c=relaxed/simple;
	bh=R3QwOkS821VUkwPcZU9o5USpIzukaU7IMUQXZZZ/dh4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=VIMSK+FfGltXQbUVKDIhzvrfl/D/ntOgwiF3c1fEx/G43euZb1Qp70jpf2qU/LWDi7H4rog+RLpc8H+jkcBfg6HUeaEZq9xf92UxPzhATSMxRtWngDBjf2rJEUEq17vI5zogkKQ251KvUhvMvPxz+QwFp3uWCgv/mGQ3XoCTlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cshmg52Tyz6J79X;
	Thu, 23 Oct 2025 18:17:39 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 181F214025A;
	Thu, 23 Oct 2025 18:21:21 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 13:21:20 +0300
Message-ID: <58174e6d-f473-4e95-b78e-7a4a9711174e@huawei.com>
Date: Thu, 23 Oct 2025 13:21:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: Re: [PATCH net-next 1/8] ipvlan: Implement learnable L2-bridge
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrey.bokhanko@huawei.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
 <20251021144410.257905-2-skorodumov.dmitry@huawei.com>
 <aPjo76T8c8SbOB04@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <aPjo76T8c8SbOB04@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 22.10.2025 17:23, Simon Horman wrote:
> On Tue, Oct 21, 2025 at 05:44:03PM +0300, Dmitry Skorodumov wrote:
>> Now it is possible to create link in L2E mode: learnable
>> bridge. The IPs will be learned from TX-packets of child interfaces.
> Is there a standard for this approach - where does the L2E name come from?

Actually, I meant "E" here as "Extended". But more or less standard naming - is "MAC NAT" - "Mac network address translation". I discussed a bit naming with LLM, and it suggested name "macsnat".. looks like  it is a better name. Hope it is ok, but I don't mind to rename if anyone has better idea

> ...
>
> It is still preferred in networking code to linewrap lines
> so that they are not wider than 80 columns, where than can be done without
> reducing readability. Which appears to be the case here.
>
> Flagged by checkpatch.pl --max-line-length=80
...
> Please don't use the inline keyword in .c files

Thank you, this will be fixed

>> +static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
>> +			      int addr_type)
>> +{
>> +	void *addr = NULL;
>> +	bool is_v6;
>> +
>> +	switch (addr_type) {
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	/* No need to handle IPVL_ICMPV6, since it never has valid src-address */
>> +	case IPVL_IPV6: {
>> +		struct ipv6hdr *ip6h;
>> +
>> +		ip6h = (struct ipv6hdr *)lyr3h;
>> +		if (!is_ipv6_usable(&ip6h->saddr))
> It is preferred to avoid #if / #ifdef in order to improve compile coverage
> (and, I would argue, readability).
..
> In this case I think that can be achieved by changing the line above to:
>
> 		if (!IS_ENABLED(CONFIG_IPV6) || !is_ipv6_usable(&ip6h->saddr))
>
> I think it would be interesting to see if a similar approach can be used
> to remove other #if CONFIG_IPV6 conditions in this file, and if successful
> provide that as a clean-up as the opening patch in this series.
>
> However, without that, I can see how one could argue for the approach
> you have taken here on the basis of consistency.
>

Hmmmm.... this raises a complicated for me questions of testing this refactoring: 

- whether IPv6 specific functions (like csum_ipv6_magic(), register_inet6addr_notifier()) are available if kernel is compiled without CONFIG_IPV6

- ideally the code should be retested with kernel without CONFIG_IPV6

This looks like a separate work that requires more or less additional efforts...

> static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
>>  {
>> -	const struct ipvl_dev *ipvlan = netdev_priv(dev);
>> -	struct ethhdr *eth = skb_eth_hdr(skb);
>> -	struct ipvl_addr *addr;
>>  	void *lyr3h;
>> +	struct ipvl_addr *addr;
>>  	int addr_type;
>> +	bool same_mac_addr;
>> +	struct ipvl_dev *ipvlan = netdev_priv(dev);
>> +	struct ethhdr *eth = skb_eth_hdr(skb);
> I realise that the convention is not followed in the existing code,
> but please prefer to arrange local variables in reverse xmas tree order -
> longest line to shortest.
I fixed all my changes to follow this style, except one - where it seems a bit unnatural to to declare dependent variable before "parent" variable. Hope it is ok.
>> +	    ether_addr_equal(eth->h_source, dev->dev_addr)) {
>> +		/* ignore tx-packets from host */
>> +		goto out_drop;
>> +	}
>> +
>> +	same_mac_addr = ether_addr_equal(eth->h_dest, eth->h_source);
>> +
>> +	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
>>  
>> -	if (!ipvlan_is_vepa(ipvlan->port) &&
>> -	    ether_addr_equal(eth->h_dest, eth->h_source)) {
>> -		lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
>> +	if (ipvlan_is_learnable(ipvlan->port)) {
>> +		if (lyr3h)
>> +			ipvlan_addr_learn(ipvlan, lyr3h, addr_type);
>> +		/* Mark SKB in advance */
>> +		skb = skb_share_check(skb, GFP_ATOMIC);
>> +		if (!skb)
>> +			return NET_XMIT_DROP;
> I think that when you drop packets a counter should be incremented.
> Likewise elsewhere in this function.
The counter appears to be handled in parent function - in ipvlan_start_xmit()
>> +	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
>> +	if (addr) {
>> +		int ret, len;
>> +
>> +		ipvlan_skb_crossing_ns(skb, addr->master->dev);
>> +		skb->protocol = eth_type_trans(skb, skb->dev);
>> +		skb->pkt_type = PACKET_HOST;
>> +		ipvlan_mark_skb(skb, port->dev);
>> +		len = skb->len + ETH_HLEN;
>> +		ret = netif_rx(skb);
>> +		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
>>
>> This fails to build because ipvlan is not declared in this scope.
>> Perhaps something got missed due to an edit?
Oops, really. Compilation was fixed in later patches.
>> +
>> +out:
>> +	dev_kfree_skb(skb);
>> +no_mem:
>> +	return 0; // actually, ret value is ignored
> Maybe, but it seems to me that the return values
> should follow that of netif_receive_skb_core().
Agree.. will be fixed.

Dmitru


