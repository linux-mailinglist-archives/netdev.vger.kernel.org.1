Return-Path: <netdev+bounces-225516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A409DB94FE1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262527A15A3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75031C573;
	Tue, 23 Sep 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDWsCOLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE363AC15
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616168; cv=none; b=flKbpYpubfJ0OeyisVlKW7OhdcPmReDDNO61hL0TCK5nhvlNN6NE9WLmrlIRoPL87suRaPMESOwXWaxTw2HSzCfpiWSEmoBIF3y06a1PBWvdHHx7Qq9zeYDKQw1YKz0/hDt6J1WiNueIFPnLdcB6I9cVyIO6GaAW/E03aTAvmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616168; c=relaxed/simple;
	bh=ySySnXQZnNZy4AMb6OoD4akqBLygOlmG167yhtGZoMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUT6ltFQ20O7X+JR9BtC/odBp3CPYsWO2ssPOpG3cax1rN66ri8aF9Q+BxEXHa/54jydxLcIFny1jMXfuw6tElu65Aw7KCBoJltbQ+Ndd/VIET6zqE/AZjfjV/cNlYuWgUdm/h0LQyWUbwm3B+zxpPkE+UJH29uEYqXxeRu6qtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDWsCOLj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46dfd711172so13820415e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758616165; x=1759220965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si2WPyKxfdmZD5NTFZltXg+LBjqt/u1Qa5Ll8mK4V7M=;
        b=NDWsCOLjfpPfJToR/jpBHn6lkqAeoVrpNihcNxrmc3Nfp216teWE4Es29mHpY4pKYN
         hWaITlZkhVHVFYZ8LPeW8WHzYrZWn0t2JRrXGKXQCHqOKL2dQQ9dAOeBO4Zj/9ld8HRt
         OXkXROaFWm+VF+Ik/0BjB7mLpXnWmD1+Nvf/Ebm9z0ORxoobPS0Mh0Vjc4VFW6dmI6fi
         fQdTBL8uDUT1PJCktOd6uW3Out773WdZTxVpKZ31OiOL/eImF6T0HbJdW040K32hfmet
         4DN5i6hZQ7Gs3IYNFOUvhOO/9kJvrHlpK89vAdzHzDcziLj18GLm/4ATrQ7/fQ/xwBMJ
         7wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616165; x=1759220965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=si2WPyKxfdmZD5NTFZltXg+LBjqt/u1Qa5Ll8mK4V7M=;
        b=JnVmLgYQv8DQ8cRUJiQA2VErCZ93ef+Fvrsvj3g8RhU6mvbZTKUmOvR2ik8n0NhaRi
         uTU2NK6uoI8a8Ti2OF6abDhoTpikK2TTYCWTnOBWyLNeV2MaTEPJ1F8Tkv4GkYz2uGtu
         +95eq8zi5BC6I85RBep7UnEUPtK9KESUVzEfa7etmUGb4XA66xWnEsGLAvW/QLkc/xy+
         B+A14BAQbKXSW9OV3j5dnGEEeTyZim+FDE8xVCqJjsO1F2Fjxmvmyic4oqCW/cdt4QSD
         w+buuLULP0y+xapyyCdqSXxDBq+yxwgI+ncIbzYXBs2t2S/1TnZmUlEX4xTbfoh8M8/c
         MXgw==
X-Forwarded-Encrypted: i=1; AJvYcCUNio5wrtpM5Oa60bNxTCpUG+4wSn1AYZ/lDrz3qpFG/36He1kDAicmSE1stntMe0zTQVwn/m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg42fAlN/WST9lBwe/912HPc8mlii0yZvozTVHUZ/BsFZSVAzw
	m4Xl1sJ+GYC2KBi7At+TE6IkqzlJWXdJZGJRzRixie60Pe2u8WNT7B/I
X-Gm-Gg: ASbGncvBGS5cJHNFec7Ix7bCYdAhb5OEGeZVauz3U9H0RWWL2SreeBMcBQWNNKX2vAO
	KDMT0oB6cegh2/Ai8olf8HLMSrTvjc4R3y28xinU3gAGYq4CVJTC86+iGnJNlA9oBDX8nSdcswF
	tuBYP3zZaXQUDH1NbUIVyw8V+RB//Q+la85AVKv5ytGm13pe44QUU7bnqEmVM3SXKPT8hunpCPU
	fJ1GUt56+kHF8vzBfH1qZmPde5Kc2+XDcaTegjvvH+/9igwks6UKuf7+j+IoTDhepwLxmpucSYv
	inqAxlvuoZyHt/f8ERsf935P0oEzY/P1uy9qrGc/UFd7aoRh7CgSsBQtYEhVzsM/pF+TO5z+zGE
	k3GEmxeT9l0gFu8ZPIZ9JbTs=
X-Google-Smtp-Source: AGHT+IFijWmOoH7wwCrk71TaNwGUJyuRsdXNh4J2dN2XeVeI31LCHuVVqHQ0Pr9EJrwHZHGcVn1j5g==
X-Received: by 2002:a05:600c:6288:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-46e1d978e28mr15024455e9.4.1758616164592;
        Tue, 23 Sep 2025 01:29:24 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461383b7b9csm276770655e9.2.2025.09.23.01.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:29:24 -0700 (PDT)
Message-ID: <ee6230f2-6dbb-48c0-9784-e507f2fb4b2a@gmail.com>
Date: Tue, 23 Sep 2025 10:29:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 3/5] net: gso: restore ids of outer ip headers
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
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.3a93f7f37dd52@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3a93f7f37dd52@gmail.com>
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
>>  include/linux/skbuff.h                        |  8 ++++++-
>>  net/core/dev.c                                |  8 +++++--
>>  net/ipv4/af_inet.c                            | 13 +++++------
>>  net/ipv4/tcp_offload.c                        |  5 +----
>>  8 files changed, 60 insertions(+), 30 deletions(-)
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
>>  
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
>> index b8c609d91d11..480f66e21132 100644
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
>> +		skb_shinfo(skb)->gso_type |= encap ? SKB_GSO_TCP_FIXEDID_INNER :
>> +						     SKB_GSO_TCP_FIXEDID;
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
> 
> Should this also remove the original features from the type. Given
> that no NETIF_F equivalent exists for those.
> 

This is already done with NETIF_F_GSO_MASK in the line below.

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
>> index ca8be45dd8be..646fb66ba948 100644
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
>> @@ -707,6 +707,12 @@ enum {
>>  	SKB_GSO_FRAGLIST = 1 << 18,
>>  
>>  	SKB_GSO_TCP_ACCECN = 1 << 19,
>> +
>> +	/* These indirectly map onto the same netdev feature.
>> +	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer IDs.
>> +	 */
>> +	SKB_GSO_TCP_FIXEDID = 1 << 30,
>> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>>  };
>>  
>>  #if BITS_PER_LONG > 32
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 93a25d87b86b..6b34b3e857d4 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3768,8 +3768,12 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>  	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
>>  		features &= ~dev->gso_partial_features;
>>  
>> -	/* Make sure to clear the IPv4 ID mangling feature if the
>> -	 * IPv4 header has the potential to be fragmented.
>> +	/* Make sure to clear the IPv4 ID mangling feature if the IPv4 header
>> +	 * has the potential to be fragmented. For encapsulated packets, the ID
>> +	 * mangling feature is guaranteed not to use the same ID for the outer
>> +	 * IPv4 headers of the generated segments if the headers have the
>> +	 * potential to be fragmented, so there is no need to clear the IPv4 ID
>> +	 * mangling feature.
> 
> If respinning: same comment from v5: please convert the assertion
> that ID mangling is guaranteed to not to use the same ID for !DF
> to an explanation: point to or copy the statement from the GSO
> partial documentation.
> 

I'll add a direct reference to the documentation and send v8 shortly.

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
>>  
>>  	tcp_gro_complete(skb);
>>  	return 0;
>> -- 
>> 2.36.1
>>
> 
> 


