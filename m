Return-Path: <netdev+bounces-214611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44218B2AA36
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4332B58795C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665E32255F;
	Mon, 18 Aug 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJrU1Dno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F2321F43;
	Mon, 18 Aug 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526050; cv=none; b=GeGz5JxDNpt+t6QsnekWPBNnXqckIxE7klXIcTUF2OJ53S7SBfj+K279MjA76+bHn06cTK7Qc+h2Z6gMFMpq275asL33TKzd1Jb1szynJvuARJJw1YoU15etwkAUdfwSTkpbYa7NZmVzdVQ1ONANKN4UTPXFYYFuRKo6s6HYA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526050; c=relaxed/simple;
	bh=pXb2zlx7R4Dr2XArFNTqGHL2x7yl2LcSAOVrRtJS7GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+p4rlFzeSMFkvVmdM9I3DfCCZjUun+zYHdJzXw+ECouXL4iX+plZaOKq8upuxSF/EkJ3yCaGg4ggNCtgVyIMDtdGqEOwjJWy7AVwIJ2MRaF4Azy/ka8+I1Tb1WWCyaDUUj9v8Iz3f7hnlbYXP1OV2UOOuhawwvZANfCmA2LNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJrU1Dno; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so1994957f8f.0;
        Mon, 18 Aug 2025 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755526047; x=1756130847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gJPSsdmU5FvXviVMdeP/ttQ4aHCnDCwIi9RQdDjZ14=;
        b=cJrU1DnoZTENBPmqCxC2ONG7sugtmwNl/qgXikc/mSfQ1qe3vFg33lV0ML/dS3BNEg
         wxNaHdzKH2t+o/P/I0hVprTo4dUrGoi1c69K/G+vZh+3EdpilnA78APZ7Di0LJwFhhky
         R4gftnMz0KkYwPoWvHzhS0saX1EpehBL/YKsGGXyudWpSjjHDCewr7sXCa/L4OKhD1gg
         gb/SHdAP1bCA1RJKsTc+E8S158Dxl1ct1S47zzUR/OeMNDpsprW2SVIxijfdxJg5538F
         Ji1iP74nMqVHvLBSlmuQ44xBGalcXz/EezXjyYGsDL0jH6HFZeT54HywlQmOdiI2O8s/
         8R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526047; x=1756130847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8gJPSsdmU5FvXviVMdeP/ttQ4aHCnDCwIi9RQdDjZ14=;
        b=Kh88dg1r+FLp+4vD5hYuKTBaQH1s0SDvCuADXuZI6nIhjakRrdkolIz9cRP1Qtjv1a
         9h1o3QoedhOoGQCrNc6u3k2F5+n36blKVV9Mv4Lk9OE1YMk34MrZfEf9VDz9JD4Gequz
         UU+K0oyNf+mM1Yefv3RKg4fADHi+Mn9qGogGpiiBEq+yzjrgkVxJnvvH13c9504i+sjG
         Xhye+SbGMPN5onSvj1bH2zuSRgqtdAUHvIA87/2BNeJPHD0TGFqBNJjCoTrCpWzyhUgw
         HkMl6NiDF1Qz4GM5MKm0BRm57ZHG4hG9TAtPQGhvfEQqsoYFv2IzhRFArxXglQAA2KV/
         AaZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2+CGINEIGUyWBqDN5d/vqJDsT2mDwI2pn+3tvA7KmCq1wcNdaNGxlb75HJUlK8UxNElCAf6V@vger.kernel.org, AJvYcCUv2w8AcLLTw03PiqN5AmeYm8ZIaZIoAqrXepCgEb0efnlTyLk/MKTIdgvUiwbntwsLEgjyzVmbDmKqqq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4naLFYMQewnrGImwR+YDtZhw+F02Xl0cxBE0/qZ/Cw7L4OSzA
	Uxwd9UWIuDbF+/h6+6Pp2QkUpA1bZutabBqRII0QyjBLTznhD7gagJEd
X-Gm-Gg: ASbGnctIY9zvsV8rfn04/thuMpd55fHPg8/KMFcg2S3tB00SM3Zf7/116qvMKwijwDV
	2GSdZo27pZaAqrpy9VEmR1f0TJINgp02NUqrCshh+DZvNYdU0AYOnV9F61XmhhLl4QsnGRTDtyp
	hgWRwOlnboHEqs1NB5bpbtyxObwywgrPiNJu1ZMcvuiDtcFHQzNWE/bPWfSTRxuIklh6FGFItw4
	gpFXP7mlm3zrnkWu2sY5ZAXAX4nIOmT6pd9gMyMWePt70HKYv4hSTJhAFIMuvTtK0Dr8nY6v6Fk
	4mLTGiFlfMedRGhn4sq/MoA2XMMowL87Xn2bHeh2FhhJjSisdOKY8j3dc7DmgMOFiqbA+bpmqup
	tG3ZJS18PG4/cFmnEmmKGOMokI2e4rch9Zw==
X-Google-Smtp-Source: AGHT+IGR8cqHW8hnYVWDdKS72RlL4t9RClBECmBxm6JheoalRqO0sNBC0agJEeF7VuRgL6sY4Zl75Q==
X-Received: by 2002:a05:6000:2309:b0:3b9:1108:e6f with SMTP id ffacd0b85a97d-3bb676ca7e3mr9011651f8f.25.1755526046699;
        Mon, 18 Aug 2025 07:07:26 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a771ecsm1797925e9.9.2025.08.18.07.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:07:26 -0700 (PDT)
Message-ID: <af4938f9-424d-460b-90b7-487ab9237a4d@gmail.com>
Date: Mon, 18 Aug 2025 16:07:10 +0200
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
 pabeni@redhat.com, horms@kernel.org, alexander.duyck@gmail.com,
 corbet@lwn.net, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.26e28ce8a7fe@gmail.com>
 <willemdebruijn.kernel.2963bd70f4104@gmail.com>
 <9be872a7-1523-48ef-86a4-dad899fc0a03@gmail.com>
 <willemdebruijn.kernel.ee1a9b43eb45@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.ee1a9b43eb45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Willem de Bruijn wrote:
>>> Willem de Bruijn wrote:
>>>> Richard Gobert wrote:
>>>>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
>>>>> be mangled. Outer IDs can always be mangled.
>>>>>
>>>>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
>>>>> both inner and outer IDs to be mangled. In the future, we could add
>>>>> NETIF_F_TSO_MANGLEID_{INNER,OUTER} to provide more granular control to
>>>>> drivers.
>>>>>
>>>>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
>>>>>
>>>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>>>>> ---
>>>>>  Documentation/networking/segmentation-offloads.rst |  4 ++--
>>>>>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
>>>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++++++--
>>>>>  drivers/net/ethernet/sfc/ef100_tx.c                | 14 ++++++++------
>>>>>  include/linux/netdevice.h                          |  9 +++++++--
>>>>>  include/linux/skbuff.h                             |  6 +++++-
>>>>>  net/core/dev.c                                     |  7 +++----
>>>>>  net/ipv4/af_inet.c                                 | 13 ++++++-------
>>>>>  net/ipv4/tcp_offload.c                             |  4 +---
>>>>>  9 files changed, 39 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
>>>>> index 085e8fab03fd..21c759b81f4e 100644
>>>>> --- a/Documentation/networking/segmentation-offloads.rst
>>>>> +++ b/Documentation/networking/segmentation-offloads.rst
>>>>> @@ -42,8 +42,8 @@ also point to the TCP header of the packet.
>>>>>  
>>>>>  For IPv4 segmentation we support one of two types in terms of the IP ID.
>>>>>  The default behavior is to increment the IP ID with every segment.  If the
>>>>> -GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
>>>>> -ID and all segments will use the same IP ID.  If a device has
>>>>> +GSO type SKB_GSO_TCP_FIXEDID_{OUTER,INNER} is specified then we will not
>>>>> +increment the IP ID and all segments will use the same IP ID.  If a device has
>>>>>  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>>>>>  and we will either increment the IP ID for all frames, or leave it at a
>>>>>  static value based on driver preference.
>>>>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>>>> index bfa5568baa92..b28f890b0af5 100644
>>>>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>>>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>>>> @@ -3868,7 +3868,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>>>>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>>>>  
>>>>>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>>>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
>>>>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
>>>>>  
>>>>>  	skb->csum_start = (unsigned char *)th - skb->head;
>>>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>> index b8c609d91d11..78df60c62225 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>> @@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>>>>  	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
>>>>>  				   ipv4->daddr, 0);
>>>>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
>>>>> -	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
>>>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
>>>>> +	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
>>>>> +		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
>>>>> +
>>>>> +		skb_shinfo(skb)->gso_type |= encap ?
>>>>> +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID_OUTER;
>>>>> +	}
>>>>>  
>>>>>  	skb->csum_start = (unsigned char *)tcp - skb->head;
>>>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>>>> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
>>>>> index e6b6be549581..aab2425e62bb 100644
>>>>> --- a/drivers/net/ethernet/sfc/ef100_tx.c
>>>>> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
>>>>> @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>>>>  {
>>>>>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>>>>>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
>>>>> -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>>>> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>>>> +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>>>>  	unsigned int outer_ip_offset, outer_l4_offset;
>>>>>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>>>>>  	u32 mss = skb_shinfo(skb)->gso_size;
>>>>> @@ -200,8 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>>>>  	bool outer_csum;
>>>>>  	u32 paylen;
>>>>>  
>>>>> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
>>>>> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>>>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER)
>>>>> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>>>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
>>>>> +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>>>>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>>>>>  		vlan_enable = skb_vlan_tag_present(skb);
>>>>>  
>>>>> @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>>>>  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
>>>>>  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
>>>>>  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
>>>>> -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
>>>>> +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
>>>>>  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
>>>>>  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
>>>>>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
>>>>>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
>>>>>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
>>>>> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
>>>>> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
>>>>> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
>>>>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
>>>>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
>>>>>  		);
>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>> index 5e5de4b0a433..e55ba6918b0a 100644
>>>>> --- a/include/linux/netdevice.h
>>>>> +++ b/include/linux/netdevice.h
>>>>> @@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>>>>>  
>>>>>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>>>>>  {
>>>>> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
>>>>> +	netdev_features_t feature;
>>>>> +
>>>>> +	if (gso_type & (SKB_GSO_TCP_FIXEDID_OUTER | SKB_GSO_TCP_FIXEDID_INNER))
>>>>> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
>>>>
>>>> This is quite peculiar.
>>>>
>>>> Is there a real use case for specifying FIXEDID separately for outer
>>>> and inner? Can the existing single bit govern both together instead?
>>>> That would be a lot simpler.
>>>
>>> I guess not, as with GRO this is under control of the sender, and
>>> possibly a separate middlebox in control of encapsulation.
>>>
>>> Still, possible to preserve existing FIXEDID for the unencapsulated
>>> or inner, and add only one extra FIXEDID for outer? Or is there value
>>> in having three bits?
>>
>> The ideal solution would be to split NETIF_F_TSO_MANGLEID into
>> NETIF_F_TSO_MANGLEID_OUTER and NETIF_F_TSO_MANGLEID_INNER.
>>  
>> As I noted, we can add this in the future, then each SKB_GSO_FIXEDID
>> bit will have a corresponding NETIF_F_TSO_MANGLEID bit. This would
>> be a much bigger change, as it requires modifying all of the
>> drivers that use NETIF_F_TSO_MANGLEID. My proposed solution is
>> somewhat of a middle-ground, as it preserves the current behavior of
>> NETIF_F_TSO_MANGLEID.
>>  
>> Preserving the existing FIXEDID for unencapsulated or inner headers
>> seems confusing to me, and just moves the ugly code elsewhere. We also
>> still need to compare both SKB_GSO_FIXEDID bits against NETIF_F_TSO_MANGLEID.
> 
> Is it not simpler to keep NETIF_F_TSO_MANGLEID and SKB_GSO_FIXEDID as
> meaning unencapsulated, and add an ENCAP variant for outer headers of
> encapsulated packets. Similar to separate UDP_TUNNEL bits.
> 
> No device currently advertises support for outer FIXEDID. We don't
> intend to add this as an ethtool configurable feature. It is only used
> for GRO packets to maintain GRO+GSO semanticss when forwarding. So no
> matching NETIF_F flag is probably okay. 
> 
> 

I dabbled with your suggestion for a bit. I think GRO/GSO code is clearer
with separate OUTER and INNER variants.
 
Your suggestion lets us remove __SKB_GSO_TCP_FIXEDID, but keeping it has the
advantage of allowing SKB_GSO_TCP_FIXEDID_INNER == SKB_GSO_TCP_FIXED_ID_OUTER << 1
which simplifies (and slightly optimizes) other areas of the code. It's also
simpler to check whether the header is outer or inner than it is
to check whether it is the "inner-most" or "outer in the case of encapsulation".


