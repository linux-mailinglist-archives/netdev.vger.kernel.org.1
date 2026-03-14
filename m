Return-Path: <netdev+bounces-267728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cw3MxZPtWm8zAAAu9opvQ
	(envelope-from <netdev+bounces-267728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:05:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518828CFD0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C885302529C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC672BEC5F;
	Sat, 14 Mar 2026 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FpR8xluT"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9D218845
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489924; cv=none; b=ofTqpy8A7EGfaIxz4+BAs8YfiFnOYC39N/r9hdV+pI8xNURxwdeUOtWLEXPQgnIzhleEzLWbPhRFXQgdJsbkc16BWbQAcfrAx76leZRsV/av+uf2xlfcn7Xs2GGw7rHbIxrNmYwSxQwyxpf9DgRepeD87WLqMPajC6CSH1fqKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489924; c=relaxed/simple;
	bh=qLmcIw+Hj4TApV0WtGh0y0Stdq1Gy5XVj7W4sk7bnbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9wDX9DJ0hOUkU4QH8lfkl1D3dgDia/2mMdyiqMxHTZA5YoRKXZCRBjc4V50BbPM9L6B5lhIGVOuNx4hgnvWM1IlP2dPMo2yi2GTY6RBvLaUF0+Hr0METW2qtYqM9+r3+QncIVvqR8PNuehJHCNGcrFycMfewCkUt6lxnfhtG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FpR8xluT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=I/SPfk7cM5JyMT6wL0mBGNiv6YjXXe0SS159ngKbMhY=;
	b=FpR8xluTUv/vgdWpBQZ2ZzJ+PND2NZnLOz0uOf6/LSAisTK2m5n2jS9IwgdGDj
	cXUtk4gcLoPJIQTShphJHSUB9FXRefYvD+xjLKCkhqhsHkfR7ZghH6F+T8L6Li5z
	K45nlAzD4zGQ/seOIMvpac/RLy4HyHlPXJRE/TMwv+53I=
Received: from [10.54.29.130] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAX8OqWTrVppYNaSg--.208S2;
	Sat, 14 Mar 2026 20:03:37 +0800 (CST)
Message-ID: <03134b09-5bcd-4898-bb2d-d866e1acd97a@163.com>
Date: Sat, 14 Mar 2026 20:03:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: prevent potential infinite loop in
 bond_header_parse()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260314115650.3646361-1-edumazet@google.com>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260314115650.3646361-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgAX8OqWTrVppYNaSg--.208S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWkWw4fKw4rWr17Wr1fXrb_yoWfJr17pa
	1DCa4xJr4xtr4Fg34Dur4Uur1Yv34UGa4a9F4Iq3sIgFnIqF95WFy8KFy7Cr13XrW8WF13
	Xr4a9rs5Gan7XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQ6pPUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbCwxmBKWm1TpkfDQAA3r
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,shopee.com,jvosburgh.net,lunn.ch];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,shopee.com:email,jvosburgh.net:email]
X-Rspamd-Queue-Id: 3518828CFD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/14/26 7:56 PM, Eric Dumazet wrote:
> bond_header_parse() can loop if a stack of two bonding devices is setup,
> because skb->dev always points to the hierarchy top.
>
> Add new "const struct net_device *dev" parameter to
> (struct header_ops)->parse() method to make sure the recursion
> is bounded, and that the final leaf parse method is called.
>
> Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jiayuan Chen <jiayuan.chen@shopee.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> ---
>   drivers/firewire/net.c          | 5 +++--
>   drivers/net/bonding/bond_main.c | 8 +++++---
>   include/linux/etherdevice.h     | 3 ++-
>   include/linux/if_ether.h        | 3 ++-
>   include/linux/netdevice.h       | 6 ++++--
>   net/ethernet/eth.c              | 3 ++-
>   net/ipv4/ip_gre.c               | 3 ++-
>   net/mac802154/iface.c           | 4 +++-
>   net/phonet/af_phonet.c          | 5 ++++-
>   9 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
> index f1a2bee39bf113fe78f4640ba92a7b4e602c213a..82b3b6d9ed2df6423d5cb7a35282d01775e6cee5 100644
> --- a/drivers/firewire/net.c
> +++ b/drivers/firewire/net.c
> @@ -257,9 +257,10 @@ static void fwnet_header_cache_update(struct hh_cache *hh,
>   	memcpy((u8 *)hh->hh_data + HH_DATA_OFF(FWNET_HLEN), haddr, net->addr_len);
>   }
>   
> -static int fwnet_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +static int fwnet_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +			      unsigned char *haddr)
>   {
> -	memcpy(haddr, skb->dev->dev_addr, FWNET_ALEN);
> +	memcpy(haddr, dev->dev_addr, FWNET_ALEN);
>   
>   	return FWNET_ALEN;
>   }
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 707419270ebf217a71b0593880c7a9a1481b7171..33f414d03ab913c58cf2406a4ab25e611c528159 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1530,9 +1530,11 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
>   	return ret;
>   }
>   
> -static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +static int bond_header_parse(const struct sk_buff *skb,
> +			     const struct net_device *dev,
> +			     unsigned char *haddr)
>   {
> -	struct bonding *bond = netdev_priv(skb->dev);
> +	struct bonding *bond = netdev_priv(dev);
>   	const struct header_ops *slave_ops;
>   	struct slave *slave;
>   	int ret = 0;
> @@ -1542,7 +1544,7 @@ static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
>   	if (slave) {
>   		slave_ops = READ_ONCE(slave->dev->header_ops);
>   		if (slave_ops && slave_ops->parse)
> -			ret = slave_ops->parse(skb, haddr);
> +			ret = slave_ops->parse(skb, slave->dev, haddr);
>   	}
>   	rcu_read_unlock();
>   	return ret;
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 9a1eacf35d37087ba8877bf31c017445929041ed..df8f88f63a7063fbd1df5248d2fc02c859a7bc74 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -42,7 +42,8 @@ extern const struct header_ops eth_header_ops;
>   
>   int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
>   	       const void *daddr, const void *saddr, unsigned len);
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +		     unsigned char *haddr);
>   int eth_header_cache(const struct neighbour *neigh, struct hh_cache *hh,
>   		     __be16 type);
>   void eth_header_cache_update(struct hh_cache *hh, const struct net_device *dev,
> diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
> index 61b7335aa037c7232a0caa45572043057c02dde3..ca9afa824aa4faf832658043bda6fb430633e476 100644
> --- a/include/linux/if_ether.h
> +++ b/include/linux/if_ether.h
> @@ -40,7 +40,8 @@ static inline struct ethhdr *inner_eth_hdr(const struct sk_buff *skb)
>   	return (struct ethhdr *)skb_inner_mac_header(skb);
>   }
>   
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +		     unsigned char *haddr);
>   
>   extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);
>   
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d7aac6f185bcab8a93a204c349272fc7c1b15ee7..7ca01eb3f7d2b22a188502583dc95121adff7cc9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -311,7 +311,9 @@ struct header_ops {
>   	int	(*create) (struct sk_buff *skb, struct net_device *dev,
>   			   unsigned short type, const void *daddr,
>   			   const void *saddr, unsigned int len);
> -	int	(*parse)(const struct sk_buff *skb, unsigned char *haddr);
> +	int	(*parse)(const struct sk_buff *skb,
> +			 const struct net_device *dev,
> +			 unsigned char *haddr);
>   	int	(*cache)(const struct neighbour *neigh, struct hh_cache *hh, __be16 type);
>   	void	(*cache_update)(struct hh_cache *hh,
>   				const struct net_device *dev,
> @@ -3445,7 +3447,7 @@ static inline int dev_parse_header(const struct sk_buff *skb,
>   
>   	if (!dev->header_ops || !dev->header_ops->parse)
>   		return 0;
> -	return dev->header_ops->parse(skb, haddr);
> +	return dev->header_ops->parse(skb, dev, haddr);
>   }
>   
>   static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 13a63b48b7eeb896dfe98eb0070a261eed2c384b..9d159d1cc57d42747f794cdf43fe0ccaf04818b2 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -198,7 +198,8 @@ EXPORT_SYMBOL(eth_type_trans);
>    * @skb: packet to extract header from
>    * @haddr: destination buffer
>    */
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +		     unsigned char *haddr)
>   {
>   	const struct ethhdr *eth = eth_hdr(skb);
>   	memcpy(haddr, eth->h_source, ETH_ALEN);
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index e13244729ad8d5b1c2b9c483d25bff0e438134b5..35f0baa99d4092fd499a4795f7f52db33a1fe4e2 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -919,7 +919,8 @@ static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
>   	return -(t->hlen + sizeof(*iph));
>   }
>   
> -static int ipgre_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +static int ipgre_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +			      unsigned char *haddr)
>   {
>   	const struct iphdr *iph = (const struct iphdr *) skb_mac_header(skb);
>   	memcpy(haddr, &iph->saddr, 4);
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 9e4631fade90c980887803f313727e9ff943bc73..000be60d9580343e40f33ff872ec0aff7daa41d0 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -469,7 +469,9 @@ static int mac802154_header_create(struct sk_buff *skb,
>   }
>   
>   static int
> -mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +mac802154_header_parse(const struct sk_buff *skb,
> +		       const struct net_device *dev,
> +		       unsigned char *haddr)
>   {
>   	struct ieee802154_hdr hdr;
>   
> diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
> index 238a9638d2b0f6a23070b0871515302d8cba864f..d89225d6bfd3bf7668edf3d0fe563f7bbc97de2c 100644
> --- a/net/phonet/af_phonet.c
> +++ b/net/phonet/af_phonet.c
> @@ -129,9 +129,12 @@ static int pn_header_create(struct sk_buff *skb, struct net_device *dev,
>   	return 1;
>   }
>   
> -static int pn_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +static int pn_header_parse(const struct sk_buff *skb,
> +			   const struct net_device *dev,
> +			   unsigned char *haddr)
>   {
>   	const u8 *media = skb_mac_header(skb);
> +
>   	*haddr = *media;
>   	return 1;
>   }


My bad, I missed the recursion issue with stacked bonds.

I reproduced it and verified the fix works correctly.
And I will add a test to tools/testing/selftests.

Reviewed-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Tested-by: Jiayuan Chen <jiayuan.chen@shopee.com>


