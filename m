Return-Path: <netdev+bounces-223290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C4B5893D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CAE2A0F40
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267051E0DE8;
	Tue, 16 Sep 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG0ywjNI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8891DFDA1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982375; cv=none; b=ELW9je7cKJwuqZzRAlUNg5Nr9IxBOClh9tIIWDGWn782pK20omi5jSXBysEL1i8cLAAUEQC+I5LZheTHD0RMbQaXfUm/bS1owu8YcdYd3xhgOBKVd5lQYY5hujbYZSe6OZpfHMC6bs4bjN+L2cqcvwBzgaqo8RRMjigZlAUGXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982375; c=relaxed/simple;
	bh=kiTurHeFXoQhvrBU060XgEcZWouebGYCXVT0eL6zTdo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dlq/7NVn1GEckho9BkvQLXvcf2+YoyCmMboVvPRDRg+7OR+bezrlKZo9GYVBRXBehfX8+WShz0DQUsULP4Ue/Ha8Bx7NDSHhabKaQl4JMeHn867DWhAeYtYRPRWMnEZVgO35Nvd0y4nZEL2zwfdXm5TTWWuJEB7wTmyK6LyJrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG0ywjNI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b61161c30fso37579631cf.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757982372; x=1758587172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrQdLfepk/w2iXAJyjmjvgilXJ/wfbidNvxgQH2F0L0=;
        b=SG0ywjNIN7gysYJmprsaPaTtQCzEQfuMcE34IbVke7VthT8HdZEy9WeHS/G8q4TwtQ
         vh7Q03ftti3vXWSvMSjAjhLMfIEpazlCs7V8qNawzOEVj0bU4RaG+jJns9ilHl8ayPT5
         /cqrZ4yuPBvVMcNL4fsX0CDzmXnns3qWm46WDOVuIVnDyZxQo8LBLFXDc3311iAjXgjU
         rA3qp43IQ8M9JIOo5HWODafjRK6K+qx23XTCB9KnJB6EWsiuMpHUDJ43+8EZh6O5FoFj
         SqsHhTI61vocAnhrc/eXHFheWY05xOnIzXGmDcyjIqE3FqZtPPF6+KGVG7t40+z8oh72
         1ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982372; x=1758587172;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YrQdLfepk/w2iXAJyjmjvgilXJ/wfbidNvxgQH2F0L0=;
        b=Jmk0MvJkXNgb1wsk4LgEa5GFgRMBdMZL1DF3rx6kXEdg0G/hLXuD/OfT9nlL0T4jnq
         vA/htz2Of6+A7Z8yVWEwq1efn8WMJ3MSrRr/QffAFDnOSYC+Hc7a/1vIvaLzJKU4Vup+
         oNVI/rI5NEGYDPhTpZRGUKpvGNNfpIJd9khJSK8PdI4hycSzvXtMHDYJK3ztRFIeglbB
         Pv97OTvlkGQV1cjyfK7d2FU0yEosfV1B5huxmXITQ9e7JhkAroZ2ZU1Ykz3ryAtjwAIZ
         +Bl2zjKQ2+X8Mw5JdmH3KBbH6U3cs9pbQo6t3Jk0CRPJarotqLw4faC+63Z+kNQNxD2i
         qG/A==
X-Forwarded-Encrypted: i=1; AJvYcCVJthRj08YCAns5S4PhtlHB3FuUlAiVSLPXR7nyM33uXhM5XnA4IlDmPuEvS5K8VbAAIagQHek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Wtu7b13fZ8/jD3ZNA6PUDcGtxu2dbjvWcvpAZvu1KZghtalN
	yl8qmxyZlHWPMBHh+j2hpDHRz42LY4p+5iiGOZhYI3B9i4NXjlb/fWEM
X-Gm-Gg: ASbGncvP3UBh2oAYBxkaffxy+wZ5OqklO7w8GAJhm2j8kd5zy10ezXNoyrIMtTqMPRC
	NM8DL8Mw7ZnVLQhzWFvjeRHXRLKjZs5RCAgLQ9VyUt+w5aWRIwyZKDr1+1QATsdopAXIoG+O9Kf
	zuqdbl+h2uu9AaVo1AzdRD7KC5ZPQxjD6fWyFhPwE1QMPG9EbNQcy6LYWPXtNdgk8kQ6T9sA900
	0KJAUh4huZ84b2XE6bEMn+Z4v4YFe7HAKb8HTeJ5pliIVrCyczZQXZSURXcQatj7V1nZzOqncU/
	s+cntb0sYfo+eBPa61qgmhY8kSyeZhYqkwbXPS9nw2zwJtYZJ3cjQavHMK3bvd1aWN2pS/nP4Lp
	BKfokllb5hxQT1qBHrQKE7uez30hQ4RfoLkykPNGF+LmfA7kbPhtoEEVczznmRHhnVw6kFLadJE
	VVag==
X-Google-Smtp-Source: AGHT+IGM6iACBTW2X/lbc13C/EWnjDVmZZOUHlBx2dGDH79CKlll69VUqCR4ul8bNoq8qrxRV8T9iQ==
X-Received: by 2002:ac8:5f13:0:b0:4b0:82d9:7cb5 with SMTP id d75a77b69052e-4b77cff578fmr166033931cf.26.1757982371567;
        Mon, 15 Sep 2025 17:26:11 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7890598971bsm17415036d6.25.2025.09.15.17.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:26:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:26:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.1b773a265e8dc@gmail.com>
In-Reply-To: <20250915113933.3293-4-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 3/5] net: gso: restore ids of outer ip headers
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
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
> ---
>  .../networking/segmentation-offloads.rst      | 22 ++++++++++++-------
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++++--
>  drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++++++++----
>  include/linux/netdevice.h                     |  9 ++++++--
>  include/linux/skbuff.h                        |  9 +++++++-
>  net/core/dev.c                                |  5 ++++-
>  net/ipv4/af_inet.c                            | 13 +++++------
>  net/ipv4/tcp_offload.c                        |  5 +----
>  8 files changed, 59 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
> index 085e8fab03fd..72f69b22b28c 100644
> --- a/Documentation/networking/segmentation-offloads.rst
> +++ b/Documentation/networking/segmentation-offloads.rst
> @@ -43,10 +43,19 @@ also point to the TCP header of the packet.
>  For IPv4 segmentation we support one of two types in terms of the IP ID.
>  The default behavior is to increment the IP ID with every segment.  If the
>  GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
> -ID and all segments will use the same IP ID.  If a device has
> -NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
> -and we will either increment the IP ID for all frames, or leave it at a
> -static value based on driver preference.
> +ID and all segments will use the same IP ID.
> +
> +For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
> +SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
> +Any combination of these two GSO types is allowed.
> +
> +If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
> +performing TSO and we will either increment the IP ID for all frames, or leave
> +it at a static value based on driver preference.  For encapsulated packets,
> +NETIF_F_TSO_MANGLEID is relevant for both outer and inner headers, unless the
> +DF bit is not set on the outer header, in which case the device driver must
> +guarantee that the IP ID field is incremented in the outer header with every
> +segment.

Is this introducing a new device requirement for advertising
NETIF_F_TSO_MANGLEID that existing devices may not meet?
  
>  
>  UDP Fragmentation Offload
> @@ -124,10 +133,7 @@ Generic Receive Offload
>  Generic receive offload is the complement to GSO.  Ideally any frame
>  assembled by GRO should be segmented to create an identical sequence of
>  frames using GSO, and any sequence of frames segmented by GSO should be
> -able to be reassembled back to the original by GRO.  The only exception to
> -this is IPv4 ID in the case that the DF bit is set for a given IP header.
> -If the value of the IPv4 ID is not sequentially incrementing it will be
> -altered so that it is when a frame assembled via GRO is segmented via GSO.
> +able to be reassembled back to the original by GRO.
>  
>  
>  Partial Generic Segmentation Offload
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..505c4ce7cef8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
>  				   ipv4->daddr, 0);
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
> -	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> +	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
> +		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
> +
> +		skb_shinfo(skb)->gso_type |= encap ?
> +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID;

I think more common style is

    encap ? SKB_GSO_TCP_FIXEDID_INNER :
            SKB_GSO_TCP_FIXEDID;

(as used in ef100_make_tso_desc below)

> +	}
>  
>  	skb->csum_start = (unsigned char *)tcp - skb->head;
>  	skb->csum_offset = offsetof(struct tcphdr, check);
> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> index e6b6be549581..03005757c060 100644
> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> @@ -189,6 +189,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  {
>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>  	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>  	unsigned int outer_ip_offset, outer_l4_offset;
>  	u16 vlan_tci = skb_vlan_tag_get(skb);
> @@ -200,8 +201,17 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  	bool outer_csum;
>  	u32 paylen;
>  
> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +	if (encap) {
> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
> +			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> +			mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +	} else {
> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> +			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +	}
> +
>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>  		vlan_enable = skb_vlan_tag_present(skb);
>  
> @@ -245,8 +255,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
>  		);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f3a3b761abfb..3d19c888b839 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5290,13 +5290,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>  
>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>  {
> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
> +	netdev_features_t feature;
> +
> +	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
> +
> +	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
>  
>  	/* check flags correspondence */
>  	BUILD_BUG_ON(SKB_GSO_TCPV4   != (NETIF_F_TSO >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_DODGY   != (NETIF_F_GSO_ROBUST >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_TCP_ECN != (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
> -	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
> +	BUILD_BUG_ON(__SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_TCPV6   != (NETIF_F_TSO6 >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_FCOE    != (NETIF_F_FSO >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_GRE     != (NETIF_F_GSO_GRE >> NETIF_F_GSO_SHIFT));
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index ca8be45dd8be..937acb1869a1 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -674,7 +674,7 @@ enum {
>  	/* This indicates the tcp segment has CWR set. */
>  	SKB_GSO_TCP_ECN = 1 << 2,
>  
> -	SKB_GSO_TCP_FIXEDID = 1 << 3,
> +	__SKB_GSO_TCP_FIXEDID = 1 << 3,
>  
>  	SKB_GSO_TCPV6 = 1 << 4,
>  
> @@ -707,6 +707,13 @@ enum {
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
> +
> +	/* These indirectly map onto the same netdev feature.
> +	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer
> +	 * IDs.

prefer to keep IDs. on the previous line even if over 80 chars.

> +	 */
> +	SKB_GSO_TCP_FIXEDID = 1 << 30,
> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>  };
>  
>  #if BITS_PER_LONG > 32
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 93a25d87b86b..17cb399cdc2a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3769,7 +3769,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  		features &= ~dev->gso_partial_features;
>  
>  	/* Make sure to clear the IPv4 ID mangling feature if the
> -	 * IPv4 header has the potential to be fragmented.
> +	 * IPv4 header has the potential to be fragmented. For
> +	 * encapsulated packets, the outer headers are guaranteed to
> +	 * have incrementing IDs if DF is not set so there is no need
> +	 * to clear the IPv4 ID mangling feature.

Why is this true. Or, why is it not also true for non-encapsulated or
inner headers?

The same preconditions (incl on DF) are now tested in inet_gro_flush

>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>  		struct iphdr *iph = skb->encapsulation ?
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 76e38092cd8a..fc7a6955fa0a 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>  
>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>  
> -	if (!skb->encapsulation || encap) {
> -		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
> -		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
> +	/* fixed ID is invalid if DF bit is not set */
> +	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
> +	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> +		goto out;
>  
> -		/* fixed ID is invalid if DF bit is not set */
> -		if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> -			goto out;
> -	}
> +	if (!skb->encapsulation || encap)
> +		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>  
>  	ops = rcu_dereference(inet_offloads[proto]);
>  	if (likely(ops && ops->callbacks.gso_segment)) {
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 1949eede9ec9..e6612bd84d09 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>  	struct tcphdr *th = tcp_hdr(skb);
> -	bool is_fixedid;
>  
>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
> @@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>  				  iph->daddr, 0);
>  
> -	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
> -
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);

ip_fixedid can now be 0, 1 (outer), 2 (inner) or 3 (inner and outer).

Not all generate a valid SKB_GSO type.
>  
>  	tcp_gro_complete(skb);
>  	return 0;
> -- 
> 2.36.1
> 



