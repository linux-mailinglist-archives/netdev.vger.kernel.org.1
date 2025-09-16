Return-Path: <netdev+bounces-223554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3222B59814
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2AD7AA522
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5401FBEB9;
	Tue, 16 Sep 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyGjFUBd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC3101F2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030427; cv=none; b=K3Q9yEGt6LeXhduDXlN9u95sTWRnVy2ewedApmvqfeYE5AafxAbrD+Z516+3SVTfD/42SuhX93ZG2y7mwNzdav9SirEchYkznKq30qdyymKrYMzbM2OERmt6lSy4gom/4LcElTCQOKzbKwrnkXD1hMp319eCgBk13c0K5JntJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030427; c=relaxed/simple;
	bh=d5sEWR17U25DAQ6oehWF9Og8c/Wdt5u0yUxA1W0dQTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSJCNcWnK5LHT4tIVsZU/T6bLrkAGKeHl1WFyS2DdnYCYSPvy2SigghEVKZqf5NtJ7V7/6048DoGxa0HI6N2j9WQsvDrF5784yNczucIEx9JrlRjUygBelZZ0RxAYfBO1ZuMM7JgyHCQL/LVKxhtPmfNdctzX+xxoQXUTLN33X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyGjFUBd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so34394925e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758030424; x=1758635224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CM2qaX5pVBBNYAELqYFtRQ1NuXIiKMqwPlPQg7yz3w=;
        b=GyGjFUBdDcfTeBiNv7TfS7U4a0+zl6sze4O9vihCgrvBhCmNIt9yi9inDO+7ly+lOH
         MN/h0IN03Po6rQQltYru9tnXig5qVXpKxTE2hZEDxRQYjkzzkHuat48Qc+emUHM6yAVn
         rePoSEf49SqZcFehyTgfb2uj2IvTKAUAaqcIXH3OqZZSpALvwpSA+CswdvM95aB+oi3x
         GXBdhttpjyEp0UgG5FipHUWyzRpuhugoZEIVQI29uEf5YGnkDl91/jjwUDXFjKfZyp4y
         981+ytaJfSTDSTE7UAj10txdCH4escpxIMQwBU2YPGovnQ/mbyC8Sa3GGlkUMoGNoMi2
         K+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030424; x=1758635224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CM2qaX5pVBBNYAELqYFtRQ1NuXIiKMqwPlPQg7yz3w=;
        b=alEO75mseQx4hTRD2NKi44yatOm/pa9zqn5h0tRVt4BfMMICNGWtAD1kuUum+OcXZA
         Z16MuAFuL8St0bXV1JDMxuZ1eszMoNLmhlcvSydDVFMzDT6KihW1Zv2DPSk5aEY8ZWdm
         aDJB7RN+0QINhfVRCJcky4/3YuL5hv3tY8zxyAz1UXoBHOJHnbQ1E+DHWegOkqo/9hSw
         0W6lFtwHoWCVJjCkpyKzP0ZOfvkj+WBJS1lXEntKO+zV71uM9hvNHk+Oe7jN9MwZZauD
         0h2De+f5j3oeOvEjmV3QzWpe2mPSl53YgWIUKyOwSJoVcGa1d+4WBRA/9XtwhQWidRaV
         ZdEw==
X-Forwarded-Encrypted: i=1; AJvYcCWbrpfFItDRuMfHnGWupr7Q+1x9/nwquufoTkeRm9JJC0LEjXXtpr4Jx++HcG0nHqYF1A1coG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3LMpygvFEoin8I2eJdbWYnczC4pG4TjR4GsPw9R6iceYY+Px
	5kIUOR7YxOVzbMYhpd22hnpHzp/k7OFRSghZfE27AIJEvkyYqjt+DMWB
X-Gm-Gg: ASbGncswlfxqnEAbKvQMMqZ5JykgLoxb+++wVwGTmgLM/pvLM+GgN5f6byW0BrN26IA
	mSTBQn6w6SfwlyIyoGFGuCgHXt9XakonSObuz+YSdYgNBqXzCPVeNnCZhqhFzbeBq7+7e2yxrJW
	Ywz/BQ+ykxvs9AmYR/dMZXm82VfZKjfz6KJCYJOxXg5HTbsdLvMWiepUT1epnM4b0ZpfBXzTMH5
	hvAnB/1kciotWtyD1PRthWqtvNsLbnwwX9FgaW8uyyhxvaJr55akWEvgl9/TsU+dwsdF2ems9OD
	nD2cyhT5HyMI2kUjaLbZ6uM+IyC4nCw9U3R1xdqHlGa+cWqS7wa6MqtQXBCyp/7SVl/pZlfYvke
	5GVFwiYwoDhompxjIGJBjOb1pbwk1rRa/WQ==
X-Google-Smtp-Source: AGHT+IE0g2tbTZD+K6JDDeehba442dHQbFSeZqIVWreC4t3gDG74nWQXd5+aAaYR+7bLotRLNjtV3A==
X-Received: by 2002:a05:6000:40c9:b0:3c7:df1d:3d9 with SMTP id ffacd0b85a97d-3e7659c4ba9mr12829580f8f.39.1758030423185;
        Tue, 16 Sep 2025 06:47:03 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8e7692c9asm13485412f8f.30.2025.09.16.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:47:02 -0700 (PDT)
Message-ID: <dca173e6-f23d-4f54-8ace-74329439c7da@gmail.com>
Date: Tue, 16 Sep 2025 15:46:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, ecree.xilinx@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.1b773a265e8dc@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1b773a265e8dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
>> be mangled. Outer IDs can always be mangled.
>>
>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
>> both inner and outer IDs to be mangled.
>>
>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
>> ---
>>  .../networking/segmentation-offloads.rst      | 22 ++++++++++++-------
>>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++++--
>>  drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++++++++----
>>  include/linux/netdevice.h                     |  9 ++++++--
>>  include/linux/skbuff.h                        |  9 +++++++-
>>  net/core/dev.c                                |  5 ++++-
>>  net/ipv4/af_inet.c                            | 13 +++++------
>>  net/ipv4/tcp_offload.c                        |  5 +----
>>  8 files changed, 59 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
>> index 085e8fab03fd..72f69b22b28c 100644
>> --- a/Documentation/networking/segmentation-offloads.rst
>> +++ b/Documentation/networking/segmentation-offloads.rst
>> @@ -43,10 +43,19 @@ also point to the TCP header of the packet.
>>  For IPv4 segmentation we support one of two types in terms of the IP ID.
>>  The default behavior is to increment the IP ID with every segment.  If the
>>  GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
>> -ID and all segments will use the same IP ID.  If a device has
>> -NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>> -and we will either increment the IP ID for all frames, or leave it at a
>> -static value based on driver preference.
>> +ID and all segments will use the same IP ID.
>> +
>> +For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
>> +SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
>> +Any combination of these two GSO types is allowed.
>> +
>> +If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
>> +performing TSO and we will either increment the IP ID for all frames, or leave
>> +it at a static value based on driver preference.  For encapsulated packets,
>> +NETIF_F_TSO_MANGLEID is relevant for both outer and inner headers, unless the
>> +DF bit is not set on the outer header, in which case the device driver must
>> +guarantee that the IP ID field is incremented in the outer header with every
>> +segment.
> 
> Is this introducing a new device requirement for advertising
> NETIF_F_TSO_MANGLEID that existing devices may not meet?
>   

No. As I discussed previously with Paolo, existing devices already increment outer
IDs. It is even a requirement for GSO partial, as already stated in the documentation.
This preserves the current behavior. It just makes it explicit. Actually, we are
now even explicitly allowing the mangling of outer IDs if the DF-bit is set.

>>  
>>  UDP Fragmentation Offload
>> @@ -124,10 +133,7 @@ Generic Receive Offload
>>  Generic receive offload is the complement to GSO.  Ideally any frame
>>  assembled by GRO should be segmented to create an identical sequence of
>>  frames using GSO, and any sequence of frames segmented by GSO should be
>> -able to be reassembled back to the original by GRO.  The only exception to
>> -this is IPv4 ID in the case that the DF bit is set for a given IP header.
>> -If the value of the IPv4 ID is not sequentially incrementing it will be
>> -altered so that it is when a frame assembled via GRO is segmented via GSO.
>> +able to be reassembled back to the original by GRO.
>>  
>>  
>>  Partial Generic Segmentation Offload
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> index b8c609d91d11..505c4ce7cef8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> @@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>  	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
>>  				   ipv4->daddr, 0);
>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
>> -	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
>> +	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
>> +		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
>> +
>> +		skb_shinfo(skb)->gso_type |= encap ?
>> +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID;
> 
> I think more common style is
> 
>     encap ? SKB_GSO_TCP_FIXEDID_INNER :
>             SKB_GSO_TCP_FIXEDID;
> 
> (as used in ef100_make_tso_desc below)
> 
>> +	}
>>  
>>  	skb->csum_start = (unsigned char *)tcp - skb->head;
>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
>> index e6b6be549581..03005757c060 100644
>> --- a/drivers/net/ethernet/sfc/ef100_tx.c
>> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
>> @@ -189,6 +189,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>  {
>>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
>> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>  	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>  	unsigned int outer_ip_offset, outer_l4_offset;
>>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>> @@ -200,8 +201,17 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>  	bool outer_csum;
>>  	u32 paylen;
>>  
>> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
>> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +	if (encap) {
>> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
>> +			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
>> +			mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +	} else {
>> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
>> +			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +	}
>> +
>>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>>  		vlan_enable = skb_vlan_tag_present(skb);
>>  
>> @@ -245,8 +255,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
>>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
>>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
>> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
>> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
>> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
>>  		);
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index f3a3b761abfb..3d19c888b839 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -5290,13 +5290,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>>  
>>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>>  {
>> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
>> +	netdev_features_t feature;
>> +
>> +	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
>> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
>> +
>> +	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
>>  
>>  	/* check flags correspondence */
>>  	BUILD_BUG_ON(SKB_GSO_TCPV4   != (NETIF_F_TSO >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_DODGY   != (NETIF_F_GSO_ROBUST >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_TCP_ECN != (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
>> -	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
>> +	BUILD_BUG_ON(__SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_TCPV6   != (NETIF_F_TSO6 >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_FCOE    != (NETIF_F_FSO >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_GRE     != (NETIF_F_GSO_GRE >> NETIF_F_GSO_SHIFT));
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index ca8be45dd8be..937acb1869a1 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -674,7 +674,7 @@ enum {
>>  	/* This indicates the tcp segment has CWR set. */
>>  	SKB_GSO_TCP_ECN = 1 << 2,
>>  
>> -	SKB_GSO_TCP_FIXEDID = 1 << 3,
>> +	__SKB_GSO_TCP_FIXEDID = 1 << 3,
>>  
>>  	SKB_GSO_TCPV6 = 1 << 4,
>>  
>> @@ -707,6 +707,13 @@ enum {
>>  	SKB_GSO_FRAGLIST = 1 << 18,
>>  
>>  	SKB_GSO_TCP_ACCECN = 1 << 19,
>> +
>> +	/* These indirectly map onto the same netdev feature.
>> +	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer
>> +	 * IDs.
> 
> prefer to keep IDs. on the previous line even if over 80 chars.
> 
>> +	 */
>> +	SKB_GSO_TCP_FIXEDID = 1 << 30,
>> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>>  };
>>  
>>  #if BITS_PER_LONG > 32
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 93a25d87b86b..17cb399cdc2a 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3769,7 +3769,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>  		features &= ~dev->gso_partial_features;
>>  
>>  	/* Make sure to clear the IPv4 ID mangling feature if the
>> -	 * IPv4 header has the potential to be fragmented.
>> +	 * IPv4 header has the potential to be fragmented. For
>> +	 * encapsulated packets, the outer headers are guaranteed to
>> +	 * have incrementing IDs if DF is not set so there is no need
>> +	 * to clear the IPv4 ID mangling feature.
> 
> Why is this true. Or, why is it not also true for non-encapsulated or
> inner headers?
> 
> The same preconditions (incl on DF) are now tested in inet_gro_flush
> 

This comment is about the IDs that TSO generates, not the IDs that GRO accepts.
I'll rewrite the comment to make it clearer.

This statement is true because of the requirement specified above, that device
drivers must increment the outer IDs if the DF-bit is not set. This means that
MANGLEID cannot turn incrementing IDs into fixed IDs in the outer header if the
DF-bit is not set (unless the IDs were already fixed, after the next patch) so
there is no need to clear NETIF_F_TSO_MANGLEID.

This isn't true for non-encapsulated or inner headers because nothing guarantees
that MANGLEID won't mangle incrementing IDs into fixed IDs.

>>  	 */
>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>>  		struct iphdr *iph = skb->encapsulation ?
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index 76e38092cd8a..fc7a6955fa0a 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>>  
>>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>>  
>> -	if (!skb->encapsulation || encap) {
>> -		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>> -		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
>> +	/* fixed ID is invalid if DF bit is not set */
>> +	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
>> +	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
>> +		goto out;
>>  
>> -		/* fixed ID is invalid if DF bit is not set */
>> -		if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
>> -			goto out;
>> -	}
>> +	if (!skb->encapsulation || encap)
>> +		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>>  
>>  	ops = rcu_dereference(inet_offloads[proto]);
>>  	if (likely(ops && ops->callbacks.gso_segment)) {
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index 1949eede9ec9..e6612bd84d09 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>  	struct tcphdr *th = tcp_hdr(skb);
>> -	bool is_fixedid;
>>  
>>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
>> @@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>>  				  iph->daddr, 0);
>>  
>> -	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
>> -
>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
>> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
>> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
> 
> ip_fixedid can now be 0, 1 (outer), 2 (inner) or 3 (inner and outer).
> 
> Not all generate a valid SKB_GSO type.

Since SKB_GSO_TCP_FIXEDID_INNER == SKB_GSO_TCP_FIXEDID << 1, all the values
listed above generate the correct set of SKB_GSO types. This fact is also
used in inet_gso_segment (SKB_GSO_TCP_FIXEDID << encap).

>>  
>>  	tcp_gro_complete(skb);
>>  	return 0;
>> -- 
>> 2.36.1
>>
> 
> 


