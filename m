Return-Path: <netdev+bounces-267719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CJrLXNJtWk3ywAAu9opvQ
	(envelope-from <netdev+bounces-267719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:41:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D228CE19
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4864C30142A0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7E24397A;
	Sat, 14 Mar 2026 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJJe0zh7"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FE23F26A
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773488484; cv=none; b=sULb962KogrUjcbuxwMbGzrXCYRt+ZIoFedTEhC62T3lvk/rxLIgpeesFDcuVWdFqgga+Cv56VoY2G5AapOt5av5hCMrQrCtdrZV0fsY4fwL/pNVcxGtAu2zVAMf83082uPQde1nLCXmQw9UhF3oDkUaIiCLBiz0B+vPbOd+79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773488484; c=relaxed/simple;
	bh=xsDFsSAHQ71Ji5154gAQ7+eWQ7L5prTUQq0+j/Y17F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loifopY67FB7U+2rbH8iq2mjCLSbxRe4olWwd3JTchF3zV3raQ7JUIXxFl5H61uZVRUyBb61A/UJM/j8vtGs86pJ4hew5MBaUqCAu+GodSxCDXl19gd2CT3QbcWdgGKrR3e/nc+KJDD40tmEzKU2w/uC7MVKf+bYhI/St2XsovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJJe0zh7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773488470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doWcgts7DXJmT437ejQpujvBeJOlxJ/YcIZosN/C/74=;
	b=UJJe0zh7LI74b+iwIOC1Ztq5kyOJDrr+eoC7R4LGpp0Z7AVrdNGwNQjdnog+1PdGvcBHVH
	94XUPQFuwArFWOL10ffLdFW7EYXCSg1QoxM240MUWCZUJC08oDdk0VAXuZ0GgOdPk1wOpK
	zj4SqYeSNB03Q4lbTH4Sjpo4suA6mmg=
Date: Sat, 14 Mar 2026 19:41:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com,
 Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
 <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
 <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267719-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: B74D228CE19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/14/26 7:14 PM, Eric Dumazet wrote:
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 707419270ebf217a71b0593880c7a9a1481b7171..33f414d03ab913c58cf2406a4ab25e611c528159
> 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1530,9 +1530,11 @@ static int bond_header_create(struct sk_buff
> *skb, struct net_device *bond_dev,
>          return ret;
>   }
>
> -static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +static int bond_header_parse(const struct sk_buff *skb,
> +                            const struct net_device *dev,
> +                            unsigned char *haddr)
>   {
> -       struct bonding *bond = netdev_priv(skb->dev);
> +       struct bonding *bond = netdev_priv(dev);
>          const struct header_ops *slave_ops;
>          struct slave *slave;
>          int ret = 0;
> @@ -1542,7 +1544,7 @@ static int bond_header_parse(const struct
> sk_buff *skb, unsigned char *haddr)
>          if (slave) {
>                  slave_ops = READ_ONCE(slave->dev->header_ops);
>                  if (slave_ops && slave_ops->parse)
> -                       ret = slave_ops->parse(skb, haddr);
> +                       ret = slave_ops->parse(skb, slave->dev, haddr);
>          }
>          rcu_read_unlock();
>          return ret;
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 9a1eacf35d37087ba8877bf31c017445929041ed..df8f88f63a7063fbd1df5248d2fc02c859a7bc74
> 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -42,7 +42,8 @@ extern const struct header_ops eth_header_ops;
>
>   int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned
> short type,
>                 const void *daddr, const void *saddr, unsigned len);
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +                    unsigned char *haddr);
>   int eth_header_cache(const struct neighbour *neigh, struct hh_cache *hh,
>                       __be16 type);
>   void eth_header_cache_update(struct hh_cache *hh, const struct net_device *dev,
> diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
> index 61b7335aa037c7232a0caa45572043057c02dde3..ca9afa824aa4faf832658043bda6fb430633e476
> 100644
> --- a/include/linux/if_ether.h
> +++ b/include/linux/if_ether.h
> @@ -40,7 +40,8 @@ static inline struct ethhdr *inner_eth_hdr(const
> struct sk_buff *skb)
>          return (struct ethhdr *)skb_inner_mac_header(skb);
>   }
>
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +                    unsigned char *haddr);
>
>   extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d7aac6f185bcab8a93a204c349272fc7c1b15ee7..7ca01eb3f7d2b22a188502583dc95121adff7cc9
> 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -311,7 +311,9 @@ struct header_ops {
>          int     (*create) (struct sk_buff *skb, struct net_device *dev,
>                             unsigned short type, const void *daddr,
>                             const void *saddr, unsigned int len);
> -       int     (*parse)(const struct sk_buff *skb, unsigned char *haddr);
> +       int     (*parse)(const struct sk_buff *skb,
> +                        const struct net_device *dev,
> +                        unsigned char *haddr);
>          int     (*cache)(const struct neighbour *neigh, struct
> hh_cache *hh, __be16 type);
>          void    (*cache_update)(struct hh_cache *hh,
>                                  const struct net_device *dev,
> @@ -3445,7 +3447,7 @@ static inline int dev_parse_header(const struct
> sk_buff *skb,
>
>          if (!dev->header_ops || !dev->header_ops->parse)
>                  return 0;
> -       return dev->header_ops->parse(skb, haddr);
> +       return dev->header_ops->parse(skb, dev, haddr);
>   }
>
>   static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 13a63b48b7eeb896dfe98eb0070a261eed2c384b..9d159d1cc57d42747f794cdf43fe0ccaf04818b2
> 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -198,7 +198,8 @@ EXPORT_SYMBOL(eth_type_trans);
>    * @skb: packet to extract header from
>    * @haddr: destination buffer
>    */
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +                    unsigned char *haddr)
>   {
>          const struct ethhdr *eth = eth_hdr(skb);
>          memcpy(haddr, eth->h_source, ETH_ALEN);
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index e13244729ad8d5b1c2b9c483d25bff0e438134b5..35f0baa99d4092fd499a4795f7f52db33a1fe4e2
> 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -919,7 +919,8 @@ static int ipgre_header(struct sk_buff *skb,
> struct net_device *dev,
>          return -(t->hlen + sizeof(*iph));
>   }
>
> -static int ipgre_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +static int ipgre_header_parse(const struct sk_buff *skb, const struct
> net_device *dev,
> +                             unsigned char *haddr)
>   {
>          const struct iphdr *iph = (const struct iphdr *) skb_mac_header(skb);
>          memcpy(haddr, &iph->saddr, 4);



Thanks,

I reproduced the infinite recursion you described with stacked bonds
(bond1 -> bond0 -> gre0). With an AF_PACKET SOCK_DGRAM socket on bond1
and an inbound GRE packet, bond_header_parse() recurses endlessly
because skb->dev always points to bond1.

I can verify this patch, but changing the parse() signature touches
quite a few places beyond what's in the diff - net/mac802154/iface.c,
net/phonet/af_phonet.c, drivers/firewire/net.c all have their own
parse() implementations that need updating, plus eth_header_parse() is
declared in both etherdevice.h and if_ether.h.

I'm wondering if adding a separate callback (e.g. dev_parse) to
struct header_ops might be a cleaner approach - dev_parse_header()
would check for the new callback first and fall back to the existing
parse(). That way only bond (and team) need to implement it, and all
other drivers remain untouched. The tradeoff is one extra NULL check
in the receive path, which should be negligible.


