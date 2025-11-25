Return-Path: <netdev+bounces-241528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F1DC850E3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 13:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC34EA01B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5E321F48;
	Tue, 25 Nov 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIa+hEUO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvzW5J2u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C130320CC3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075508; cv=none; b=ZaUVd34j1ezawwdlnPin+M3qhwsVpq9XIATh+6yv1I2JDw4k5CfRQceXD8Nru+mgdw4HnVNZL0rm5wMpS8IphZyUmvN2+hgpL4uF630+9bdhpALzosTDfzMujf1xXzwpQPS6UrgCScmyuPvXs73n72uXGVgSwsyoD72g6ugumts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075508; c=relaxed/simple;
	bh=z6xwYMx1ZTgnAf2GsWO1M6tvpH5fITifUCOr17917eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQdHeb0X5pbr9Q0xoadue1lHuIZcOE4pkHRN5dttFXZmOvxykDXP+ZNVHoNiTw5IHrslBLFLeUfOU9mqQTWh/VAugY+b2ziKmBPNmLFkKEa4NedjLoqdaZks1lAYLlg7fxV6MbWNMzCT+j7WlMG9cVsDkBs96v38boFRgybJujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIa+hEUO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvzW5J2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764075505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZobjZoKfwXrzxmqwbkou1OOzeaNCsJasa95pMzw6YlA=;
	b=PIa+hEUOUF83izjrSrOLHpfemIWjfFTK4iXKmlTy13eXMNE4x3unsIOelqODVFy45EpJ9o
	mpPFfmC7qC+WNEvoM4baFyBWv3nRrzJXzVWBh+TtkNkQnZDAz1+GPFiLRbrzHNQgejuAI2
	tprv3qtrK29fSatk+5dS6yJSz4lbgtI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-gkRtyrnjNVC1JGxpOELHcA-1; Tue, 25 Nov 2025 07:58:24 -0500
X-MC-Unique: gkRtyrnjNVC1JGxpOELHcA-1
X-Mimecast-MFC-AGG-ID: gkRtyrnjNVC1JGxpOELHcA_1764075503
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477939321e6so31638715e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764075503; x=1764680303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZobjZoKfwXrzxmqwbkou1OOzeaNCsJasa95pMzw6YlA=;
        b=PvzW5J2u5lWOrn+uc3L+MTK5O5eqQphsR5YaS0nL+UJsI5ZJW6ElREPGGD9y0Cx21A
         aB0SW/c5Ces1hcPhbS6cdKUNT3u68VqwRuFGgnAS3Qhsms+tfazswjYtUxUJ/bVXU9HT
         qxz4DNmcHg6YxF0WBML2EVImHCKcWnSsyJJYON5/7YPVH7hxhc0z5APEWlNBJz7FG9kE
         +RriDW0QuS8Te38l8McGHT7OFc4ka+n2H7hOmuDTov/F1Ado9aFR0A0PR+glezrVvDgN
         +KD5PUnD3+8ejNGe4Adhvu/+DqQmM/eAVCrW9QToKViXYrn8z1Rg6Dhv5YocZ4v0JXyV
         o0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075503; x=1764680303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZobjZoKfwXrzxmqwbkou1OOzeaNCsJasa95pMzw6YlA=;
        b=Zf9eWqPxVDoiSVLv1lgn7nIof+fih17m3vXCnqY7HUzuHEobSOzL9xSmkTI/tjXSB3
         qSFP5oG+FTABJkUEWAAPQXjoZAZ14fq9zm6IppCMzX8xi7EhhDtq9xEVRBSxbL1+ZOtZ
         n+/Iiy7Z1AHfIFwjqb9zl1hPa9yCz/wYkiIdHjP0+Tw/77eD/xBnMdWkgWh/cBB36hEh
         xdV/uJXXlt+3WTVLnQXJVLsweq1YEgqs6HlN3QKrDER0bDcsUlKISza8VA/uZJIY/+X0
         1ALnGwg/wqPQ2Vl3DvbfPmi5dKQICd+5xZLvVP86vMYfY17J5Ralz1AXizLeyxUGx0pa
         9gAw==
X-Forwarded-Encrypted: i=1; AJvYcCWlKRHL51INZSzZUP/NXhO20OYIKH3gvw4Jg1srWZETvqug5v6DI5P609F9kOXIJgv/uNiavek=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJ+ydZ8UHA5QNbRdQn84CE14PVcRDn3KYSboQf8OBETlNRc7R
	EXH51pIjU4X/c+Uc369yRZprBR//EcgX1Gn38Cw9fM/cld0DrNXKStqnjTjOhBYqMbODMb420an
	HKCHuoF1E49PhzmRm5btdJMyPkSLYMp6RmgFkZECeFEzjgIlKbZZ9AF2b4w==
X-Gm-Gg: ASbGncvaDaz7VJud0kWW99rFb0y/7PIW7QK/YTBlBVFwbJOHLTxVgIvMfHJpWGDEFub
	YzVRDFjRSaJpm9vXK84H6Ow/dGv+tKrVH6GB5Cn2y7wRtN/TZCQGMwax+hv9J9JL3kgb3FcaKAg
	O3MsM9TCo2ei4sIc4JdrOT3bSQGZFt38m5LZCdbJEc2kYNOziDCeVa2LApF8JHv7uhShM3A4zNB
	YvwC7M4ySmW/O2e9pE4RMPHLuuWgGeRZBqMlKreqgYUorKNl7hChK7zJSazNKpG6Ei8Lv5txdoR
	g1TPU6mAut5yRYvH2NWTPbHAOS7Gt5Dy6kEffHG0CuG0xj6M4UIa/ZGrduBApgO3kmUGkoXBeZG
	/S4Vo8Kmw8lb9/w==
X-Received: by 2002:a05:600c:8b37:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-47904b1ad25mr23227345e9.21.1764075502511;
        Tue, 25 Nov 2025 04:58:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFWqCm2Z2ZZtdnoQR4DjLUuZTf/8khC3tfCapXFMn8mAe2zhFE5g4zopGYaMg2S7GVJmkt2w==
X-Received: by 2002:a05:600c:8b37:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-47904b1ad25mr23226945e9.21.1764075501929;
        Tue, 25 Nov 2025 04:58:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477c0d85360sm246238125e9.15.2025.11.25.04.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 04:58:20 -0800 (PST)
Message-ID: <3d5ef6e5-cfcc-4994-a8d2-857821b79ed8@redhat.com>
Date: Tue, 25 Nov 2025 13:58:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] ipvlan: Support MACNAT mode
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xiao Liang <shaw.leon@gmail.com>,
 Guillaume Nault <gnault@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Julian Vetter <julian@outer-limits.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Etienne Champetier <champetier.etienne@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, "David S. Miller" <davem@davemloft.net>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-2-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-2-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> @@ -90,6 +90,26 @@ works in this mode and hence it is L3-symmetric (L3s). This will have slightly l
>  performance but that shouldn't matter since you are choosing this mode over plain-L3
>  mode to make conn-tracking work.
>  
> +4.4 L2_MACNAT mode:
> +-------------------
> +
> +This mode extends the L2 mode and is primarily designed for desktop virtual
> +machines that need to bridge to wireless interfaces. In standard L2 mode,
> +you must configure IP addresses on slave interfaces to enable frame
> +multiplexing between slaves and the master.

We should avoid adding more divisive language to the kernel. Here there
are no uAPI constraints, please use inclusive synonyms.

Also since you are touching this, please consider an additional patch to
update the existing ipvlan.rst accordingly.

> @@ -78,11 +80,13 @@ struct ipvl_addr {
>  		struct in6_addr	ip6;	 /* IPv6 address on logical interface */
>  		struct in_addr	ip4;	 /* IPv4 address on logical interface */
>  	} ipu;
> +	u8			hwaddr[ETH_ALEN];
>  #define ip6addr	ipu.ip6
>  #define ip4addr ipu.ip4
>  	struct hlist_node	hlnode;  /* Hash-table linkage */
>  	struct list_head	anode;   /* logical-interface linkage */
>  	ipvl_hdr_type		atype;
> +	u64			tstamp;
>  	struct rcu_head		rcu;
>  };
>  
> @@ -91,6 +95,7 @@ struct ipvl_port {
>  	possible_net_t		pnet;
>  	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
>  	struct list_head	ipvlans;
> +	struct packet_type	ipvl_ptype;
>  	u16			mode;
>  	u16			flags;
>  	u16			dev_id_start;
> @@ -103,6 +108,7 @@ struct ipvl_port {
>  
>  struct ipvl_skb_cb {
>  	bool tx_pkt;
> +	void *mark;
>  };
>  #define IPVL_SKB_CB(_skb) ((struct ipvl_skb_cb *)&((_skb)->cb[0]))
>  
> @@ -151,12 +157,34 @@ static inline void ipvlan_clear_vepa(struct ipvl_port *port)
>  	port->flags &= ~IPVLAN_F_VEPA;
>  }
>  
> +static inline bool ipvlan_is_macnat(struct ipvl_port *port)
> +{
> +	return port->mode == IPVLAN_MODE_L2_MACNAT;
> +}
> +
> +static inline void ipvlan_mark_skb(struct sk_buff *skb, struct net_device *dev)
> +{
> +	IPVL_SKB_CB(skb)->mark = dev;

Quite unintuitive name to store a device ptr;

> +}
> +
> +static inline bool ipvlan_is_skb_marked(struct sk_buff *skb,
> +					struct net_device *dev)
> +{
> +	return (IPVL_SKB_CB(skb)->mark == dev);
> +}
> +
>  void ipvlan_init_secret(void);
>  unsigned int ipvlan_mac_hash(const unsigned char *addr);
>  rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb);
> +void ipvlan_skb_crossing_ns(struct sk_buff *skb, struct net_device *dev);
>  void ipvlan_process_multicast(struct work_struct *work);
> +void ipvlan_multicast_enqueue(struct ipvl_port *port,
> +			      struct sk_buff *skb, bool tx_pkt);
>  int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
>  void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
> +int ipvlan_add_addr(struct ipvl_dev *ipvlan,
> +		    void *iaddr, bool is_v6, const u8 *hwaddr);
> +void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
>  struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
>  				   const void *iaddr, bool is_v6);
>  bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6);
> diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
> index dea411e132db..5127f4832a8c 100644
> --- a/drivers/net/ipvlan/ipvlan_core.c
> +++ b/drivers/net/ipvlan/ipvlan_core.c
> @@ -225,6 +225,42 @@ unsigned int ipvlan_mac_hash(const unsigned char *addr)
>  	return hash & IPVLAN_MAC_FILTER_MASK;
>  }
>  
> +static int ipvlan_macnat_xmit_phydev(struct ipvl_port *port,
> +				     struct sk_buff *skb,
> +				     bool lyr3h_valid,
> +				     void *lyr3h, int addr_type)

Possibly using l3hdr_valid, l3hdr instead of the above will make the
following more readable.

> +{
> +	struct sk_buff *orig_skb = skb;
> +
> +	skb = skb_unshare(skb, GFP_ATOMIC);
> +	if (!skb)
> +		return NET_XMIT_DROP;
> +
> +	/* Use eth-addr of main as source. */
> +	skb_reset_mac_header(skb);
> +	ether_addr_copy(skb_eth_hdr(skb)->h_source, port->dev->dev_addr);
> +
> +	if (!lyr3h_valid) {
> +		lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
> +		orig_skb = skb; /* no need to reparse */
> +	}
> +
> +	/* ToDo: Handle ICMPv6 for neighbours discovery.*/

I think we need this feature in the initial submission.

> +	if (lyr3h && addr_type == IPVL_ARP) {
> +		if (skb != orig_skb)
> +			lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
> +
> +		if (lyr3h) {
> +			struct arphdr *arph = (struct arphdr *)lyr3h;
> +
> +			ether_addr_copy((u8 *)(arph + 1), port->dev->dev_addr);
> +		}
> +	}
> +
> +	skb->dev = port->dev;
> +	return dev_queue_xmit(skb);
> +}
> +
>  void ipvlan_process_multicast(struct work_struct *work)
>  {
>  	struct ipvl_port *port = container_of(work, struct ipvl_port, wq);
> @@ -285,9 +321,25 @@ void ipvlan_process_multicast(struct work_struct *work)
>  
>  		if (tx_pkt) {
>  			/* If the packet originated here, send it out. */
> -			skb->dev = port->dev;
> -			skb->pkt_type = pkt_type;
> -			dev_queue_xmit(skb);
> +			if (ipvlan_is_macnat(port)) {
> +				/* Inject as rx-packet to main dev. */
> +				nskb = skb_clone(skb, GFP_ATOMIC);
> +				if (nskb) {

The more idiomatic form would be:

				if (!nskb)
					// error handling

> +					consumed = true;
> +					local_bh_disable();
> +					nskb->pkt_type = pkt_type;
> +					nskb->dev = port->dev;
> +					dev_forward_skb(port->dev, nskb);
> +					local_bh_enable();
> +				}
> +				/* Send out */

Too mant level of indentation, please move to a separate helper.

> +				ipvlan_macnat_xmit_phydev(port, skb, false,
> +							  NULL, -1);

You should likely drop the packet if clone fails

> +			} else {
> +				skb->dev = port->dev;
> +				skb->pkt_type = pkt_type;
> +				dev_queue_xmit(skb);
> +			}
>  		} else {
>  			if (consumed)
>  				consume_skb(skb);

[...]> @@ -661,6 +860,61 @@ static int ipvlan_xmit_mode_l2(struct
sk_buff *skb, struct net_device *dev)
>  	return dev_queue_xmit(skb);
>  }
>  
> +static int ipvlan_xmit_mode_macnat(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct ipvl_dev *ipvlan = netdev_priv(dev);
> +	struct ethhdr *eth = skb_eth_hdr(skb);
> +	struct ipvl_addr *addr;
> +	int addr_type;
> +	void *lyr3h;
> +
> +	/* Ignore tx-packets from host and don't allow to use main addr. */
> +	if (ether_addr_equal(eth->h_source, dev->dev_addr) ||
> +	    ether_addr_equal(eth->h_source, ipvlan->phy_dev->dev_addr))
> +		goto out_drop;
> +
> +	/* Mark SKB in advance */
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		return NET_XMIT_DROP;
> +	ipvlan_mark_skb(skb, ipvlan->phy_dev);
This is the xmit path ...

> +
> +	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
> +	if (lyr3h)
> +		ipvlan_macnat_addr_learn(ipvlan, lyr3h, addr_type,
> +					 eth->h_source);
> +
> +	if (is_multicast_ether_addr(eth->h_dest)) {
> +		skb_reset_mac_header(skb);
> +		ipvlan_skb_crossing_ns(skb, NULL);
> +		ipvlan_multicast_enqueue(ipvlan->port, skb, true);
> +		return NET_XMIT_SUCCESS;
> +	} else if (ether_addr_equal(eth->h_dest, ipvlan->phy_dev->dev_addr)) {
> +		/* It is a packet from child with destination to main port.
> +		 * Pass it to main.
> +		 */
> +		skb->pkt_type = PACKET_HOST;
> +		skb->dev = ipvlan->phy_dev;
> +		dev_forward_skb(ipvlan->phy_dev, skb);
> +		return NET_XMIT_SUCCESS;
> +	} else if (lyr3h) {
> +		addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
> +		if (addr) {
> +			if (ipvlan_is_private(ipvlan->port))
> +				goto out_drop;
> +
> +			ipvlan_rcv_frame(addr, addr_type, &skb, true);
> +			return NET_XMIT_SUCCESS;
> +		}
> +	}
> +
> +	return ipvlan_macnat_xmit_phydev(ipvlan->port, skb, true, lyr3h,
> +					 addr_type);
> +out_drop:
> +	consume_skb(skb);
> +	return NET_XMIT_DROP;
> +}
> +
>  int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct ipvl_dev *ipvlan = netdev_priv(dev);
> @@ -675,6 +929,8 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
>  	switch(port->mode) {
>  	case IPVLAN_MODE_L2:
>  		return ipvlan_xmit_mode_l2(skb, dev);
> +	case IPVLAN_MODE_L2_MACNAT:
> +		return ipvlan_xmit_mode_macnat(skb, dev);
>  	case IPVLAN_MODE_L3:
>  #ifdef CONFIG_IPVLAN_L3S
>  	case IPVLAN_MODE_L3S:
> @@ -724,8 +980,7 @@ static rx_handler_result_t ipvlan_handle_mode_l3(struct sk_buff **pskb,
>  
>  	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
>  	if (addr)
> -		ret = ipvlan_rcv_frame(addr, pskb, false);
> -
> +		ret = ipvlan_rcv_frame(addr, addr_type, pskb, false);
>  out:
>  	return ret;
>  }
> @@ -737,17 +992,23 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
>  	struct ethhdr *eth = eth_hdr(skb);
>  	rx_handler_result_t ret = RX_HANDLER_PASS;
>  
> -	if (is_multicast_ether_addr(eth->h_dest)) {
> -		if (ipvlan_external_frame(skb, port)) {
> -			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
> +	/* Ignore already seen packets. */
> +	if (ipvlan_is_skb_marked(skb, port->dev))

... and this is the receiver path. Nothing guaratees the CB is preserved
in between and that random data in there will not confuse the above
check. Also I'm not sure what you are trying to filter out here.

> +		return RX_HANDLER_PASS;
>  
> +	if (is_multicast_ether_addr(eth->h_dest)) {
> +		if (ipvlan_external_frame(skb, port) ||
> +		    ipvlan_is_macnat(port)) {
>  			/* External frames are queued for device local
>  			 * distribution, but a copy is given to master
>  			 * straight away to avoid sending duplicates later
>  			 * when work-queue processes this frame. This is
>  			 * achieved by returning RX_HANDLER_PASS.
>  			 */
> +			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
> +
>  			if (nskb) {
> +				ipvlan_mark_skb(skb, port->dev);
>  				ipvlan_skb_crossing_ns(nskb, NULL);
>  				ipvlan_multicast_enqueue(port, nskb, false);
>  			}
> @@ -770,6 +1031,7 @@ rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb)
>  
>  	switch (port->mode) {
>  	case IPVLAN_MODE_L2:
> +	case IPVLAN_MODE_L2_MACNAT:
>  		return ipvlan_handle_mode_l2(pskb, port);
>  	case IPVLAN_MODE_L3:
>  		return ipvlan_handle_mode_l3(pskb, port);
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index 660f3db11766..f27af7709a5b 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -16,6 +16,15 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
>  
>  	ASSERT_RTNL();
>  	if (port->mode != nval) {
> +		/* Don't allow switch off the learnable bridge mode.
> +		 * Flags also must be set from the first port-link setup.
> +		 */
> +		if (port->mode == IPVLAN_MODE_L2_MACNAT ||
> +		    (nval == IPVLAN_MODE_L2_MACNAT && port->count > 1)) {
> +			netdev_err(port->dev, "MACNAT mode cannot be changed.\n");
> +			return -EINVAL;
> +		}
> +
>  		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
>  			flags = ipvlan->dev->flags;
>  			if (nval == IPVLAN_MODE_L3 || nval == IPVLAN_MODE_L3S) {
> @@ -40,7 +49,10 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
>  			ipvlan_l3s_unregister(port);
>  		}
>  		port->mode = nval;
> +		if (port->mode == IPVLAN_MODE_L2_MACNAT)
> +			dev_add_pack(&port->ipvl_ptype);
>  	}
> +
>  	return 0;
>  
>  fail:
> @@ -59,6 +71,67 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
>  	return err;
>  }
>  
> +static int ipvlan_macnat_port_rcv(struct sk_buff *skb, struct net_device *wdev,
> +				  struct packet_type *pt,
> +				  struct net_device *orig_wdev)
> +{
> +	struct ipvl_port *port;
> +	struct ipvl_addr *addr;
> +	struct ethhdr *eth;
> +	int addr_type;
> +	void *lyr3h;
> +
> +	port = container_of(pt, struct ipvl_port, ipvl_ptype);
> +	/* We are interested only in outgoing packets.
> +	 * rx-path is handled in rx_handler().
> +	 */
> +	if (skb->pkt_type != PACKET_OUTGOING ||
> +	    ipvlan_is_skb_marked(skb, port->dev))
> +		goto out;
> +
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		goto no_mem;
> +
> +	/* data should point to eth-header */
> +	skb_push(skb, skb->data - skb_mac_header(skb));
> +	skb->dev = port->dev;
> +	eth = eth_hdr(skb);
> +
> +	if (is_multicast_ether_addr(eth->h_dest)) {
> +		ipvlan_skb_crossing_ns(skb, NULL);
> +		skb->protocol = eth_type_trans(skb, skb->dev);
> +		skb->pkt_type = PACKET_HOST;
> +		ipvlan_mark_skb(skb, port->dev);
> +		ipvlan_multicast_enqueue(port, skb, false);
> +		return NET_RX_SUCCESS;
> +	}
> +
> +	lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
> +	if (!lyr3h)
> +		goto out;
> +
> +	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
> +	if (addr) {

The `if` condition is supposed to catch the exceptional condition/error
path, nor the other way around.

> +		struct ipvl_dev *ipvlan = addr->master;
> +		int ret, len;
> +
> +		ipvlan_skb_crossing_ns(skb, ipvlan->dev);
> +		skb->protocol = eth_type_trans(skb, skb->dev);
> +		skb->pkt_type = PACKET_HOST;
> +		ipvlan_mark_skb(skb, port->dev);
> +		len = skb->len + ETH_HLEN;
> +		ret = netif_rx(skb);
> +		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
> +		return NET_RX_SUCCESS;
> +	}
> +
> +out:
> +	dev_kfree_skb(skb);
> +no_mem:
> +	return NET_RX_DROP;
> +}
> +
>  static int ipvlan_port_create(struct net_device *dev)
>  {
>  	struct ipvl_port *port;
> @@ -84,6 +157,11 @@ static int ipvlan_port_create(struct net_device *dev)
>  	if (err)
>  		goto err;
>  
> +	port->ipvl_ptype.func = ipvlan_macnat_port_rcv;
> +	port->ipvl_ptype.type = htons(ETH_P_ALL);
> +	port->ipvl_ptype.dev = dev;
> +	port->ipvl_ptype.list.prev = LIST_POISON2;

LIST_HEAD_INIT()

> +
>  	netdev_hold(dev, &port->dev_tracker, GFP_KERNEL);
>  	return 0;
>  
> @@ -100,6 +178,8 @@ static void ipvlan_port_destroy(struct net_device *dev)
>  	netdev_put(dev, &port->dev_tracker);
>  	if (port->mode == IPVLAN_MODE_L3S)
>  		ipvlan_l3s_unregister(port);
> +	if (port->ipvl_ptype.list.prev != LIST_POISON2)

!list_empty()

> +		dev_remove_pack(&port->ipvl_ptype);
>  	netdev_rx_handler_unregister(dev);
>  	cancel_work_sync(&port->wq);
>  	while ((skb = __skb_dequeue(&port->backlog)) != NULL) {
> @@ -189,10 +269,13 @@ static int ipvlan_open(struct net_device *dev)
>  	else
>  		dev->flags &= ~IFF_NOARP;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
> -		ipvlan_ht_addr_add(ipvlan, addr);
> -	rcu_read_unlock();
> +	/* for learnable, addresses will be obtained from tx-packets. */
> +	if (!ipvlan_is_macnat(ipvlan->port)) {
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
> +			ipvlan_ht_addr_add(ipvlan, addr);
> +		rcu_read_unlock();
> +	}
>  
>  	return 0;
>  }
> @@ -581,11 +664,21 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>  	INIT_LIST_HEAD(&ipvlan->addrs);
>  	spin_lock_init(&ipvlan->addrs_lock);
>  
> -	/* TODO Probably put random address here to be presented to the
> -	 * world but keep using the physical-dev address for the outgoing
> -	 * packets.
> +	/* Flags are per port and latest update overrides. User has
> +	 * to be consistent in setting it just like the mode attribute.
>  	 */
> -	eth_hw_addr_set(dev, phy_dev->dev_addr);
> +	if (data && data[IFLA_IPVLAN_MODE])
> +		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
> +
> +	if (mode != IPVLAN_MODE_L2_MACNAT) {
> +		/* TODO Probably put random address here to be presented to the
> +		 * world but keep using the physical-dev addr for the outgoing
> +		 * packets.

Not sure why you trimmed the existing comment

> +		 */
> +		eth_hw_addr_set(dev, phy_dev->dev_addr);
> +	} else {
> +		eth_hw_addr_random(dev);
> +	}
>  
>  	dev->priv_flags |= IFF_NO_RX_HANDLER;
>  
> @@ -597,6 +690,9 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>  	port = ipvlan_port_get_rtnl(phy_dev);
>  	ipvlan->port = port;
>  
> +	if (data && data[IFLA_IPVLAN_FLAGS])
> +		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);

This looks like a change of behavior that could potentially break the
user-space.

> +
>  	/* If the port-id base is at the MAX value, then wrap it around and
>  	 * begin from 0x1 again. This may be due to a busy system where lots
>  	 * of slaves are getting created and deleted.
> @@ -625,19 +721,13 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>  	if (err)
>  		goto remove_ida;
>  
> -	/* Flags are per port and latest update overrides. User has
> -	 * to be consistent in setting it just like the mode attribute.
> -	 */
> -	if (data && data[IFLA_IPVLAN_FLAGS])
> -		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
> -
> -	if (data && data[IFLA_IPVLAN_MODE])
> -		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
> -
>  	err = ipvlan_set_port_mode(port, mode, extack);
>  	if (err)
>  		goto unlink_netdev;
>  
> +	if (ipvlan_is_macnat(port))
> +		dev_set_allmulti(dev, 1);
> +
>  	list_add_tail_rcu(&ipvlan->pnode, &port->ipvlans);
>  	netif_stacked_transfer_operstate(phy_dev, dev);
>  	return 0;
> @@ -657,6 +747,9 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
>  	struct ipvl_dev *ipvlan = netdev_priv(dev);
>  	struct ipvl_addr *addr, *next;
>  
> +	if (ipvlan_is_macnat(ipvlan->port))
> +		dev_set_allmulti(dev, -1);
> +
>  	spin_lock_bh(&ipvlan->addrs_lock);
>  	list_for_each_entry_safe(addr, next, &ipvlan->addrs, anode) {
>  		ipvlan_ht_addr_del(addr);
> @@ -793,6 +886,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
>  		break;
>  
>  	case NETDEV_CHANGEADDR:
> +		if (ipvlan_is_macnat(port))
> +			break;
> +
>  		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
>  			eth_hw_addr_set(ipvlan->dev, dev->dev_addr);
>  			call_netdevice_notifiers(NETDEV_CHANGEADDR, ipvlan->dev);
> @@ -813,7 +909,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
>  }
>  
>  /* the caller must held the addrs lock */
> -static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
> +int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
> +		    const u8 *hwaddr)

I guess that using a separate new helper with the new argument will make
the diff smaller and easier to read.

/P


