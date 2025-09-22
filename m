Return-Path: <netdev+bounces-225368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67680B92DE9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208D52A7671
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157F2F0C63;
	Mon, 22 Sep 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZk36YFr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867CB2F0C45
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569756; cv=none; b=jPkgtVHfUn1ZnyBzCQz1RU6tXm5f9lhcobiejW4qDOxP2r/bGnN0DQ7qZX+A+uDemDVkFz0P8s62AxBJm7j48E+M3Yk4i6S/0744vfiiXwSiuRbOEiVIdPcEjNCxit24PmPYcE3naMOxaOcA9M5RQFXDDHWEjJY7VlQj5EEaizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569756; c=relaxed/simple;
	bh=kpo5S4rKVHSWN4w2xvEc8NDeUyraDr+AI+4lG36Jvbo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RODrob83iIALf/aybqQhUD9weMaB2RHq+gH4Txvg5xtPZg4Z/4u56gtG0wuIJqUgDz7nzbiUzKm/9pNUmHITpQ7r7RwnQFgVO17kVGLGzWB8EIyFKlU3ShN8BrUwmkjt3yWsQ79aQ0r/riCfWAeswEZ0yHtyqFC6oWwoO4N/YCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZk36YFr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-828690f9128so680597485a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569753; x=1759174553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gWADNJtywhRSJllz4V97wysacoA+HT9HorPQotXTq4=;
        b=WZk36YFrYdPxMgczCe6TUTfEZH2Q0pP6O20pJP+XnKNYyHw738Q6p649KnzD0V5Qgt
         ItdaXrBqLfyEAFbHqswsa8XvZQUshsC6dV40IrNJsokJVMDY08gAV73A5DsgmttLl9ZY
         /PAtiM9O/EUN3rigrihyKves+mr0N7cSxjbV3aU6ZCwxAWSw4dgU9KL8TDChZMgLWoYj
         ZMd30SCVgKQJ4O1Fl4x3Z8nJsuYyKxt4Iok4k+pOzfzYnCsUnq9zeSUsiFpUYn9Zo7IS
         PQRW7Y3eYHm1NvBOCsAEtgb+iYrabOJ3phRIKuiDg4rb2Pygi4YUXESPxzsyY0oNeyNb
         qOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569753; x=1759174553;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gWADNJtywhRSJllz4V97wysacoA+HT9HorPQotXTq4=;
        b=lYsArSfvgaM4kifAjZE8RnypCf8Mq5R4QpBdRb0l9UvBBkR7OmHPWmNHxoCLMb4tl+
         sLy56KYMpzEYq/f/PeKf4KegbNC1DIS16jFJnF6jNMOO9FcLGJDmbHWE8Nf5kfz9u5ZZ
         Sj67pzZ7zM2MIfB98v/tGV3TFcoEqsf/P+eU42+bTyOq8ujsN2YCGzfX1NBSxuw+KHh6
         eKgV0JbzU6dFpYsvTx/PZiLAj6kYYPpDhlfxVS+ax1z/0J+RjkkJ02f/MOINZQjqkes4
         RTAn3uAPAY1o3pb0F0qUNih9+pRo57aTOa9G/cmcaQ5+Zlyx2Fhvq7ht71m1wh0mHf8Y
         gErQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuMFhEtRv0LA5BGUPdnFeBEdLssFzmjLSzDKeqeQZaq6AsCZGNeR8nTd9gVRRLqsIyhHJD/wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaiVs3xzs7ap5M7DDnc206aelym2dzi92V/Xm5z30rAa8iNiZ
	E77l29c+0e1eMt8pnHmF4a/mK6rigp4jI3NxFOfU6MQq0ixAWs6KSDMm
X-Gm-Gg: ASbGnctZAnTD5jdBhnIafOGj8F9U8NMKRWAQZmhlgcvu5N8O5mrADSYbMm64lKO87HF
	KmuKrxUAD7LXJLNPFmcMgGc6Jtb3fKRvNVB0pHzIUfNoAF45LCZKp4027kpZ0fEBylAj9Q/XifJ
	nmiHZ6q3m+y+sX4qCnO9tJL1UjgmS5yNSnRwEOEoKZXaDRzCiao8bk0sgKJduypoSbE68vfEIpn
	9NN0lNotxIxAqJU0jmmwDRgczplM/vJwsB/vLYaYjvGNMUWAzt4BfK/CsEsvhIG12sCwhOr0+Zd
	NLCEOjdFX2Rj2iK89FXap6IwKG7zfkQnvPq1sKMDkKWp9it1x731HI0tsxaQ2gQ9WVCBRUVPQwj
	Lt0A+BF3m3X8lkVV6x1zDiMtCJ3OW3lUUEO4FlCMwAR8pMBSJwrDaQtb+PXTSyNvVrwsL2A==
X-Google-Smtp-Source: AGHT+IGpTUxqcAeYpbImZgV9DXzq6cfghpWMTbZPJJpR35EdOF0MXmQNYjQh7JwJH24oZyAgdkJj/A==
X-Received: by 2002:a05:620a:4808:b0:849:525d:48c4 with SMTP id af79cd13be357-8516d81b892mr18844885a.35.1758569753016;
        Mon, 22 Sep 2025 12:35:53 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-84be9f2a56dsm183949685a.1.2025.09.22.12.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:35:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:35:51 -0400
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
Message-ID: <willemdebruijn.kernel.3a93f7f37dd52@gmail.com>
In-Reply-To: <20250916144841.4884-4-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v6 3/5] net: gso: restore ids of outer ip headers
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
>  include/linux/skbuff.h                        |  8 ++++++-
>  net/core/dev.c                                |  8 +++++--
>  net/ipv4/af_inet.c                            | 13 +++++------
>  net/ipv4/tcp_offload.c                        |  5 +----
>  8 files changed, 60 insertions(+), 30 deletions(-)
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
>  
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
> index b8c609d91d11..480f66e21132 100644
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
> +		skb_shinfo(skb)->gso_type |= encap ? SKB_GSO_TCP_FIXEDID_INNER :
> +						     SKB_GSO_TCP_FIXEDID;
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

Should this also remove the original features from the type. Given
that no NETIF_F equivalent exists for those.

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
> index ca8be45dd8be..646fb66ba948 100644
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
> @@ -707,6 +707,12 @@ enum {
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
> +
> +	/* These indirectly map onto the same netdev feature.
> +	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer IDs.
> +	 */
> +	SKB_GSO_TCP_FIXEDID = 1 << 30,
> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>  };
>  
>  #if BITS_PER_LONG > 32
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 93a25d87b86b..6b34b3e857d4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3768,8 +3768,12 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
>  		features &= ~dev->gso_partial_features;
>  
> -	/* Make sure to clear the IPv4 ID mangling feature if the
> -	 * IPv4 header has the potential to be fragmented.
> +	/* Make sure to clear the IPv4 ID mangling feature if the IPv4 header
> +	 * has the potential to be fragmented. For encapsulated packets, the ID
> +	 * mangling feature is guaranteed not to use the same ID for the outer
> +	 * IPv4 headers of the generated segments if the headers have the
> +	 * potential to be fragmented, so there is no need to clear the IPv4 ID
> +	 * mangling feature.

If respinning: same comment from v5: please convert the assertion
that ID mangling is guaranteed to not to use the same ID for !DF
to an explanation: point to or copy the statement from the GSO
partial documentation.

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
>  
>  	tcp_gro_complete(skb);
>  	return 0;
> -- 
> 2.36.1
> 



