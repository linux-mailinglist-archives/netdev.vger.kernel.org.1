Return-Path: <netdev+bounces-214534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F2B2A0B3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BE37AF63D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8522836A6;
	Mon, 18 Aug 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/EA4wTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AE236435;
	Mon, 18 Aug 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517631; cv=none; b=giGMIpANKcpOUrfhV87zTHVJr34k0jRKtoOWTIiSYH+QuUZjW+K6Kzd0nqIXmdvd0ISm5c3LFmhUYYviPVyZCKQLfhn81fTs7u/CeDOnWtJyZ7gjzIk++HxvttH53loFBEOvZ97PUM2J3VzCKPGrt2clLt2p60vplnJsercwKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517631; c=relaxed/simple;
	bh=m3P70pIKxaAsPrV7Hlq5nkeWwR3VoCXMFFFMZbXUPjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vyf7OOtcS1QHvStDESd3IFk2AipTVpr2jWERJtTcJYXDqlnUnH1hcLSfI6jlG3GpnGqPxtdgG4pDCvtOyxW59ljR/g1TvsBCPPJSWfMJ+1J4ItFjihdbPKUZZJHCeYthry6LeX2YfpH3AZsX+EzWBHsezcUb3zdwLiyJIbgVBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/EA4wTt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9d41c1964so2802153f8f.0;
        Mon, 18 Aug 2025 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755517627; x=1756122427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ydh78Q4GIGRjGpn43gBxGso1tTe0EO22Q88Uov9H5g=;
        b=O/EA4wTt5NKjRbDTdqtdxPMm2Fn/3OP0+D5WUaBajhLQb8HNhhRNQ5Slo+FC2L1/S9
         wEytaZGhc1Vv9EwbgEI8AtWDRE1lteSbIYZglobSV4tJVUg6ufVEqQAfGsgtZ+guFXhr
         h3OSVjJLnHHVr1O4/6eWAPeq1qI5mvU0GvV1Vye1qi0rpXUS7xr5sC2IXqov+WtRXoXy
         K0wC2UjGgK24CgvlYZAvGgYDUzVp7FN/O0SGNlOKPxhy4Aqz2+RGlKGXuo1FQY2rY9Bg
         y7eFY/G4WKEIdv+K+jf4dl9VJ/gNBEPt63vmSNGgQB3axS5YTtnYCFtDaCjRJ5kFseb2
         l8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755517627; x=1756122427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ydh78Q4GIGRjGpn43gBxGso1tTe0EO22Q88Uov9H5g=;
        b=pIaySA/lxduB44TL3iwbyS6ZT6M2xG6Rff94iqQGzBaNS1KOetvGxI86Xln255mHZb
         gUbYKRTNePRKSbvqEaUAV5IgRLJ5BfE6zyq/uXox+iiFItBgtkpKtJtPmuC84A3/+7Dt
         2gxLKV6BIwqMcJA0U4F+GO+GjDeM7gOUcUHDH6x4+K/OK92HuljKnTs9pXprLkG/Dfag
         GM+OvWb6ZlYOSSizL5slE9qXVzxcmjTxpzxuBovni881Ud/3MDIrvklrNNo1gclB9DV0
         bLZcAIolpqJA55fGgukT2OXcvtkciwfry9soE70U3oL2aKWb5/8vmGTajJg3MhpFd1TD
         RJkw==
X-Forwarded-Encrypted: i=1; AJvYcCU6IFER03EFLlICIonNEK1pZBLCaKl+/MjuyrFKKxeQ33xjR2GdSEiv134/Cs+tNTRJqzvwIvTZ3kDCudA=@vger.kernel.org, AJvYcCXoUVTnaPkdm7cNw7eyAm08skxItCUa770bg0IZHkfnnDakhVkAUnBQ1WZOKwyr1lv1rdGvzS/I@vger.kernel.org
X-Gm-Message-State: AOJu0YyvH5+88XpAg8wIkJ4ONCu3RHGJBbkrWRz22TkMOOr9F5Jl1P3g
	ZVqseEmV7dJ0awcrkpciTHBNQDTiImu+k4UORvpKLdYREWkRtH9KPAao
X-Gm-Gg: ASbGnctbVDx3VsvigEl/d1KoKx5YARn2UkvZALL0RHidLzJvEoLemYsilhd3yTxZ1Aa
	qWQmgq9kcDNAYBCzCmtpvuqdmQS95Mwu+jiK18HSeIbOXIWK0dvLhFovkCe6r+J2ODH9Z5jvUGo
	NWBlschSry4LW1esEPuWQWlWJ+lui5F9oX2obRY+FURz4tb3mpaiVKcBjeVT8H504XzX7145PQ8
	EhmclWN62i+2TlXrxzwGPxFnLl6hYnjsXqwTwmxHcC6etjf/4gGWMn+sVqp1XKaXfL48oSnc6WZ
	65ty1K7FwvjFXoXgCT/vA3WNbl2SJtDaCFGTlI/QWMO3+9rqxSzsTsHt8vafmiq7idlbX/Ab2Lw
	CWa4XE7XYEyBU9RxIkGugCWXC0wXlTSgUbw==
X-Google-Smtp-Source: AGHT+IGiNOh5bat770yRTGgUSHbl4Q0nw59pDv9/clMhpRiILNdb94S22PFqJjJP1cZ3XjEdmpeFDA==
X-Received: by 2002:a05:6000:4287:b0:3b9:1636:c443 with SMTP id ffacd0b85a97d-3bb694af47cmr9344625f8f.52.1755517627083;
        Mon, 18 Aug 2025 04:47:07 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm12251918f8f.58.2025.08.18.04.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:47:06 -0700 (PDT)
Message-ID: <9be872a7-1523-48ef-86a4-dad899fc0a03@gmail.com>
Date: Mon, 18 Aug 2025 13:46:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.26e28ce8a7fe@gmail.com>
 <willemdebruijn.kernel.2963bd70f4104@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2963bd70f4104@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> Richard Gobert wrote:
>>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
>>> be mangled. Outer IDs can always be mangled.
>>>
>>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
>>> both inner and outer IDs to be mangled. In the future, we could add
>>> NETIF_F_TSO_MANGLEID_{INNER,OUTER} to provide more granular control to
>>> drivers.
>>>
>>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
>>>
>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>>> ---
>>>  Documentation/networking/segmentation-offloads.rst |  4 ++--
>>>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++++++--
>>>  drivers/net/ethernet/sfc/ef100_tx.c                | 14 ++++++++------
>>>  include/linux/netdevice.h                          |  9 +++++++--
>>>  include/linux/skbuff.h                             |  6 +++++-
>>>  net/core/dev.c                                     |  7 +++----
>>>  net/ipv4/af_inet.c                                 | 13 ++++++-------
>>>  net/ipv4/tcp_offload.c                             |  4 +---
>>>  9 files changed, 39 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
>>> index 085e8fab03fd..21c759b81f4e 100644
>>> --- a/Documentation/networking/segmentation-offloads.rst
>>> +++ b/Documentation/networking/segmentation-offloads.rst
>>> @@ -42,8 +42,8 @@ also point to the TCP header of the packet.
>>>  
>>>  For IPv4 segmentation we support one of two types in terms of the IP ID.
>>>  The default behavior is to increment the IP ID with every segment.  If the
>>> -GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
>>> -ID and all segments will use the same IP ID.  If a device has
>>> +GSO type SKB_GSO_TCP_FIXEDID_{OUTER,INNER} is specified then we will not
>>> +increment the IP ID and all segments will use the same IP ID.  If a device has
>>>  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>>>  and we will either increment the IP ID for all frames, or leave it at a
>>>  static value based on driver preference.
>>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> index bfa5568baa92..b28f890b0af5 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> @@ -3868,7 +3868,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>>  
>>>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
>>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
>>>  
>>>  	skb->csum_start = (unsigned char *)th - skb->head;
>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> index b8c609d91d11..78df60c62225 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> @@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>>  	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
>>>  				   ipv4->daddr, 0);
>>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
>>> -	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
>>> +	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
>>> +		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
>>> +
>>> +		skb_shinfo(skb)->gso_type |= encap ?
>>> +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID_OUTER;
>>> +	}
>>>  
>>>  	skb->csum_start = (unsigned char *)tcp - skb->head;
>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
>>> index e6b6be549581..aab2425e62bb 100644
>>> --- a/drivers/net/ethernet/sfc/ef100_tx.c
>>> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
>>> @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>>  {
>>>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>>>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
>>> -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>> +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>>  	unsigned int outer_ip_offset, outer_l4_offset;
>>>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>>>  	u32 mss = skb_shinfo(skb)->gso_size;
>>> @@ -200,8 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>>  	bool outer_csum;
>>>  	u32 paylen;
>>>  
>>> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
>>> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER)
>>> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
>>> +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>>>  		vlan_enable = skb_vlan_tag_present(skb);
>>>  
>>> @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>>  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
>>>  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
>>>  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
>>> -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
>>> +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
>>>  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
>>>  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
>>>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
>>>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
>>>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
>>> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
>>> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
>>> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
>>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
>>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
>>>  		);
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 5e5de4b0a433..e55ba6918b0a 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>>>  
>>>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>>>  {
>>> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
>>> +	netdev_features_t feature;
>>> +
>>> +	if (gso_type & (SKB_GSO_TCP_FIXEDID_OUTER | SKB_GSO_TCP_FIXEDID_INNER))
>>> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
>>
>> This is quite peculiar.
>>
>> Is there a real use case for specifying FIXEDID separately for outer
>> and inner? Can the existing single bit govern both together instead?
>> That would be a lot simpler.
> 
> I guess not, as with GRO this is under control of the sender, and
> possibly a separate middlebox in control of encapsulation.
> 
> Still, possible to preserve existing FIXEDID for the unencapsulated
> or inner, and add only one extra FIXEDID for outer? Or is there value
> in having three bits?

The ideal solution would be to split NETIF_F_TSO_MANGLEID into
NETIF_F_TSO_MANGLEID_OUTER and NETIF_F_TSO_MANGLEID_INNER.
 
As I noted, we can add this in the future, then each SKB_GSO_FIXEDID
bit will have a corresponding NETIF_F_TSO_MANGLEID bit. This would
be a much bigger change, as it requires modifying all of the
drivers that use NETIF_F_TSO_MANGLEID. My proposed solution is
somewhat of a middle-ground, as it preserves the current behavior of
NETIF_F_TSO_MANGLEID.
 
Preserving the existing FIXEDID for unencapsulated or inner headers
seems confusing to me, and just moves the ugly code elsewhere. We also
still need to compare both SKB_GSO_FIXEDID bits against NETIF_F_TSO_MANGLEID.


