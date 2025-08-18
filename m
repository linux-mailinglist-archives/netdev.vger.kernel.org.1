Return-Path: <netdev+bounces-214538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F0B2A100
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40DF162D99
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9765261B92;
	Mon, 18 Aug 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD6p8c5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC823C38C;
	Mon, 18 Aug 2025 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518287; cv=none; b=ZfgQpBwg5rO6Fhd4FbJyzIUW5KblT5GmBVs9XQdymjRVADCHSxefeQcdkroAs+Mv3fE9hc0gJaxuFbUh7MZgGei2FFSx1Et1EYGrGcaI0zK4UgKdczsFEolNDDa2ihL4kCXJQ+GQCoXPOAnm2aUfFX/QbyO0mc2GpCg4gGj+f2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518287; c=relaxed/simple;
	bh=0auSW5vJxopsycxV9N9Pw6iyytMEwDeZ+ZGHBA8xtEk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z8DqYYDRqp0v0iPGGjQuZfNYgQo2ZAhpf1n10OS+qnYQyyQfN7dCxYmuAr4DLhF09rR1HbyQNpCnugSO/41RgMW7I1U156IXkXPRZQv7TznnAeZYA+PtyVEaaE4+11Py3WQkEcXXsRF74EGsAvVlZyZCuJdF3JLIgZpg4Pqpf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD6p8c5F; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e87061d120so410378285a.2;
        Mon, 18 Aug 2025 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755518285; x=1756123085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DySjixOZmDG1zxGPAN3vyCflQ83OteviIDFUIh593Mk=;
        b=HD6p8c5F//mtPSMc7Mbv+BJW43S4JLqQUkMrnQUduwGr0Tg/dyblZEAC/5nEASuqTg
         A7Ly7xby2B/GEuEvkpAs9KKlHrHYsELLVUjKOTCvpiDrRl8xtZHnYFGpxdvqVBYWPSeE
         XE4mKQ/k+FhBc4P/RB8Q9TC10kktIIzULsK8pkY4i0iEAV+YH/o3JWtBRnE3Uee1ytQx
         s7kTJcY1nor+YyigdXB02wWRWtxVupMqabSrjPSJ/6R6GoFHXXi4fkPsIVTBCfXNEwYh
         zOl4a2xlaVBa07/CfxYJX3weGYEgEWznpcMymsNsS15tcEIfQdSQOEwl2N+o0C8EsDy0
         Ft7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518285; x=1756123085;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DySjixOZmDG1zxGPAN3vyCflQ83OteviIDFUIh593Mk=;
        b=uwPvbBlG2c1qkuzWm1f6CPOxgcVoj+1GCrOCg/oK2bz+x/P9FaEa+DxZINxsXEpoxA
         AUt+71Paovf9kL1h97lFM42caarC6gdd7n5ON3DboOy/hRyh7KKs92+yV0OpJkxPmUuO
         9dRIiCNl8QUHBwqTdJnyKzopsC94XVF3EznXApS8i9yD38hOuG6Z535wqNHk0pgLnL/C
         Kd/268UY5QwLDzBb0gQNOmzcSYrX52VGTLBJjwZWDtRxSa1FZFZAfEBUZxaEItxGrVgv
         NGUXy1e5R35UGbVKrZl9gpL5SqDYjH/bdJuRebOPtAJZ8bhSM72o+5tuh7Z44w3lQg7Y
         hVSw==
X-Forwarded-Encrypted: i=1; AJvYcCUvRSXTcptWPKqs/q2iDHItOU5BKdj5J1KqVQq9kZYLfUHonnJc3mwuDFSleVslI9wLAK67qQkwV5ATuU0=@vger.kernel.org, AJvYcCVno4sm+YlViQ0vSpe1q8rXWekx6s7h/aPBg/6/mb99NgIuX2Aun16FjgqBiIljM47fL5cZcZwb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00VVZowLw9xHHtUk7YbYgsO513spNLakDGWwZ2t1BBwtl4uOy
	tndtOCLHUQw2IG6Cfi5IoGzEYsm8sJRUR640qYY5B2zzNwSVcFTXAnAY
X-Gm-Gg: ASbGncvMCmCtwqk1ZyxLVkwzEZra90oPu+FVkGeShZGY8btlTw8X48ygBuDlTfyxzTb
	I5M6zYL9X/xfymgeX78mrtIaavYbjGqhcosDzVuD+RTNvrhACJ1R6nkIb/3NZL8XMXIFfq8+YFP
	ITZ12FHrwictmAY+53kcyLWRWGb7MXsYNj3dY2xIwEO2PVzhoLzFIcfk6nMMysCIfr7sYN7wKEW
	UmbWFiZ4YYipZHYrmBk0CgyAI1a7fXUENtEKV5zucRvaEGkBd0GeOsYIqVJIGcx3NQShmdZRm75
	rHgL1LL1+lm9Ju9xbPIe9XQdq8hWeMdfikbx1DzusTgAmcvSml2fwbXbQE+HGp0BRxEO+V4ZwIk
	/XXBak+XBqkImF1mq+wrqyqK96cObXWKyl6UUKA+B7FFc6xvV6bondpVjKA67MKRd1NKcnQ==
X-Google-Smtp-Source: AGHT+IGGhOp8B+kplNRoYjGullJk6WNyVuzVI3ZyHvZN2lgnZPmkwC7OyobQlqFtgTG89CJLk+LZeg==
X-Received: by 2002:a05:620a:2844:b0:7e8:4014:dbf2 with SMTP id af79cd13be357-7e87e0c744dmr1402704085a.56.1755518284702;
        Mon, 18 Aug 2025 04:58:04 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ba902f4edsm51413646d6.14.2025.08.18.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:58:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 07:58:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 alexander.duyck@gmail.com, 
 corbet@lwn.net, 
 shenjian15@huawei.com, 
 salil.mehta@huawei.com, 
 shaojijie@huawei.com, 
 andrew+netdev@lunn.ch, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com
Message-ID: <willemdebruijn.kernel.ee1a9b43eb45@gmail.com>
In-Reply-To: <9be872a7-1523-48ef-86a4-dad899fc0a03@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.26e28ce8a7fe@gmail.com>
 <willemdebruijn.kernel.2963bd70f4104@gmail.com>
 <9be872a7-1523-48ef-86a4-dad899fc0a03@gmail.com>
Subject: Re: [PATCH net-next 3/5] net: gso: restore ids of outer ip headers
 correctly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> >> Richard Gobert wrote:
> >>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> >>> be mangled. Outer IDs can always be mangled.
> >>>
> >>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> >>> both inner and outer IDs to be mangled. In the future, we could add
> >>> NETIF_F_TSO_MANGLEID_{INNER,OUTER} to provide more granular control to
> >>> drivers.
> >>>
> >>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> >>>
> >>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >>> ---
> >>>  Documentation/networking/segmentation-offloads.rst |  4 ++--
> >>>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
> >>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++++++--
> >>>  drivers/net/ethernet/sfc/ef100_tx.c                | 14 ++++++++------
> >>>  include/linux/netdevice.h                          |  9 +++++++--
> >>>  include/linux/skbuff.h                             |  6 +++++-
> >>>  net/core/dev.c                                     |  7 +++----
> >>>  net/ipv4/af_inet.c                                 | 13 ++++++-------
> >>>  net/ipv4/tcp_offload.c                             |  4 +---
> >>>  9 files changed, 39 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
> >>> index 085e8fab03fd..21c759b81f4e 100644
> >>> --- a/Documentation/networking/segmentation-offloads.rst
> >>> +++ b/Documentation/networking/segmentation-offloads.rst
> >>> @@ -42,8 +42,8 @@ also point to the TCP header of the packet.
> >>>  
> >>>  For IPv4 segmentation we support one of two types in terms of the IP ID.
> >>>  The default behavior is to increment the IP ID with every segment.  If the
> >>> -GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
> >>> -ID and all segments will use the same IP ID.  If a device has
> >>> +GSO type SKB_GSO_TCP_FIXEDID_{OUTER,INNER} is specified then we will not
> >>> +increment the IP ID and all segments will use the same IP ID.  If a device has
> >>>  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
> >>>  and we will either increment the IP ID for all frames, or leave it at a
> >>>  static value based on driver preference.
> >>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> >>> index bfa5568baa92..b28f890b0af5 100644
> >>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> >>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> >>> @@ -3868,7 +3868,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
> >>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> >>>  
> >>>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
> >>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> >>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
> >>>  
> >>>  	skb->csum_start = (unsigned char *)th - skb->head;
> >>>  	skb->csum_offset = offsetof(struct tcphdr, check);
> >>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> >>> index b8c609d91d11..78df60c62225 100644
> >>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> >>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> >>> @@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
> >>>  	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
> >>>  				   ipv4->daddr, 0);
> >>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
> >>> -	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
> >>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> >>> +	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
> >>> +		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
> >>> +
> >>> +		skb_shinfo(skb)->gso_type |= encap ?
> >>> +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID_OUTER;
> >>> +	}
> >>>  
> >>>  	skb->csum_start = (unsigned char *)tcp - skb->head;
> >>>  	skb->csum_offset = offsetof(struct tcphdr, check);
> >>> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> >>> index e6b6be549581..aab2425e62bb 100644
> >>> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> >>> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> >>> @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
> >>>  {
> >>>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
> >>>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
> >>> -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> >>> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> >>> +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> >>>  	unsigned int outer_ip_offset, outer_l4_offset;
> >>>  	u16 vlan_tci = skb_vlan_tag_get(skb);
> >>>  	u32 mss = skb_shinfo(skb)->gso_size;
> >>> @@ -200,8 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
> >>>  	bool outer_csum;
> >>>  	u32 paylen;
> >>>  
> >>> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> >>> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> >>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER)
> >>> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> >>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
> >>> +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> >>>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
> >>>  		vlan_enable = skb_vlan_tag_present(skb);
> >>>  
> >>> @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
> >>>  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
> >>>  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
> >>>  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
> >>> -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
> >>> +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
> >>>  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
> >>>  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
> >>>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
> >>>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
> >>>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
> >>> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
> >>> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
> >>> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
> >>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
> >>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
> >>>  		);
> >>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>> index 5e5de4b0a433..e55ba6918b0a 100644
> >>> --- a/include/linux/netdevice.h
> >>> +++ b/include/linux/netdevice.h
> >>> @@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
> >>>  
> >>>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
> >>>  {
> >>> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
> >>> +	netdev_features_t feature;
> >>> +
> >>> +	if (gso_type & (SKB_GSO_TCP_FIXEDID_OUTER | SKB_GSO_TCP_FIXEDID_INNER))
> >>> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
> >>
> >> This is quite peculiar.
> >>
> >> Is there a real use case for specifying FIXEDID separately for outer
> >> and inner? Can the existing single bit govern both together instead?
> >> That would be a lot simpler.
> > 
> > I guess not, as with GRO this is under control of the sender, and
> > possibly a separate middlebox in control of encapsulation.
> > 
> > Still, possible to preserve existing FIXEDID for the unencapsulated
> > or inner, and add only one extra FIXEDID for outer? Or is there value
> > in having three bits?
> 
> The ideal solution would be to split NETIF_F_TSO_MANGLEID into
> NETIF_F_TSO_MANGLEID_OUTER and NETIF_F_TSO_MANGLEID_INNER.
>  
> As I noted, we can add this in the future, then each SKB_GSO_FIXEDID
> bit will have a corresponding NETIF_F_TSO_MANGLEID bit. This would
> be a much bigger change, as it requires modifying all of the
> drivers that use NETIF_F_TSO_MANGLEID. My proposed solution is
> somewhat of a middle-ground, as it preserves the current behavior of
> NETIF_F_TSO_MANGLEID.
>  
> Preserving the existing FIXEDID for unencapsulated or inner headers
> seems confusing to me, and just moves the ugly code elsewhere. We also
> still need to compare both SKB_GSO_FIXEDID bits against NETIF_F_TSO_MANGLEID.

Is it not simpler to keep NETIF_F_TSO_MANGLEID and SKB_GSO_FIXEDID as
meaning unencapsulated, and add an ENCAP variant for outer headers of
encapsulated packets. Similar to separate UDP_TUNNEL bits.

No device currently advertises support for outer FIXEDID. We don't
intend to add this as an ethtool configurable feature. It is only used
for GRO packets to maintain GRO+GSO semanticss when forwarding. So no
matching NETIF_F flag is probably okay. 



