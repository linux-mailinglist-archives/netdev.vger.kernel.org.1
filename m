Return-Path: <netdev+bounces-214030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C5B27E25
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DAC1D03332
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC62FD1CD;
	Fri, 15 Aug 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKZ+6G2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4602F7443;
	Fri, 15 Aug 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253422; cv=none; b=IKeL707A1yP83gd/4buU8pHwvHJLD5yECL0ZkvRkL1ykQMIEHyFOlnTm4/LT9Cn7LXrZYGIDTgafntOChCjTb3+fnLSzV0WNfqwcPGjlRYqWtI0Cgm8xQmZB3xBP2ZM+QiVoR7v9GEPbNUB8YmTalXPk4gATah9xYD3Xe9Y7uPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253422; c=relaxed/simple;
	bh=7BgpJoWO5GJphkg7g0AQLMKpMw6FpQ4kd0G2lYjU/zg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YZ+496cSlTDw/0x3pxyquQ+/ffkGL1dqKsPcLmMGOJ1EDOuFD7MyMLRDCQ4qzM8YS8Wxi6RGzq4q+ZBKuqNUvPLLNL1z8thpknnrICMwAhwy9jAIoIsnryXp3/EU7OOdGyutmQLsbmqjKyAuq5tH07sSNgouF8HkT6vzJk7Tuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKZ+6G2g; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-50f88ed81c8so1233163137.1;
        Fri, 15 Aug 2025 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755253419; x=1755858219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg+iFNohp6eez8xK9tjUOP/MF0+NveyelV31/a53wis=;
        b=RKZ+6G2gjUvKig3/YKZEhLLCXaTnfmhMcpM96Xf2yzpsOjFUReswM/xhBrWcou2OQC
         KxhHIN4rKUMmDzEKN3arkm4Uy0QCXycYhtb0+4stihXqqNQ0cg/lNzAARZsm501r22ky
         aw6WA5w/lAKOjRUo/xcIC8Pz0ALDkz7TAMnSPyxBJuZDKIrVf31QMDSZnjXoltKe2ji6
         TaZpbv0McvNieiP6fXI7qDiWFr/nMnTs7UFe4aRIlyHZuYf8Abl0/JvmCZgTkeWnKSZg
         ixsWD7DhTzrX/ORzZePynNY54W8Ri64g/4++6kB2H7nOSSLMLjmRnoLWtAXMafdCBb2j
         ZL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253419; x=1755858219;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jg+iFNohp6eez8xK9tjUOP/MF0+NveyelV31/a53wis=;
        b=s0YiM5CetjNXFb0ysY/r7urt+Bw/uR8xCnZS9/HMmH5Iop0q6Zyp/XYOlSKfN+xXw6
         nbaUYFlo9DHBFwEILtAYxWBWL5Jzyqq67fKF6or9r03fpISWGFcwLidFHRgXfWKmfjxk
         mwCtEBUtGha/WVMQSbf7dfvn4WInWb094LbL70MMv1NDwjE4RLGkzGbI4PPJyVt8nlfK
         7w/A9qMIb8Rz6mgO+zsXBXD4/5zYFTwybSxBc437OOUXyFmTcZvVPKBpSkgJdxnSYSyX
         rhgH/3KRaC2N3mGeXSBX8o10XG7iL2+ThYhW+W2Zle3vg6qWQJPm/nBzXT2rjB6ssScv
         hKzw==
X-Forwarded-Encrypted: i=1; AJvYcCU5+4WZOQ3c3HNNUFiAI+BZGIpnw7M1I75B92/SNeADCyCa0JnUHkzsFA+Ra9DePaCKqowq5DRR@vger.kernel.org, AJvYcCXhKyC4dKPtIDXLq665YcCxu5kDeNItV7OdByM1pH/t4dguKqLmyJW6VkXR8YLgXAkWrgE2YQATq7OILaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1y1hzxrAHxJNX8xSODvTNcL98v2yyhUBxhKagIoYAWQaqYx9
	zIvu1L/o0aRUD30KvAfj5v6s7tTeHpWuAuRB25iV3+qE3oF2IGi8tXyg
X-Gm-Gg: ASbGncscU3YJjYpcfQNnoYlwRaAGSoVEnbJsrLCgiPKNBqU88nh5EtSjA84kfd2Qul0
	PQVZeiwEK8EGDAqCOnWNtCRjMoz7489HBopo2LZIc3WjVReSme3Zx0gzG3DvMj4if+HqKRevqAj
	blF3aO7GGMTywrwFjcC7UV2pXErPsM4WcdNcErHTfyCnkAbfmjsE/mDhcFKON0X+wBi0zGa3+vu
	wQ26140GMx/OrvvC0cqpLEZTmsU5rqMfymwSDXDdOG7HXWo9vufzwHb8XQR1b6H3XD6ybO8K3Fj
	ssSRSJpjZswZuUeESFTuPdSbVLg5arNu25EMz6qK4GJbS1zDfkkgbq7OB5fUZNLY+od58t81SFo
	YnyPMrcN5L7bt+fqYTsxx4vLMla+m93iEBHG1DER2Qe/Sj9L8CKlrLVVf1YKeKSKHStSf5w==
X-Google-Smtp-Source: AGHT+IHa9S3LoV5boeFT+o6ZxDrOQ7YIevRRlgATPTe2caxoEWsI6bV1Jxokwlve5/fvY4TrfFy+IQ==
X-Received: by 2002:a05:6102:5807:b0:4fa:55e:681f with SMTP id ada2fe7eead31-5126d30d976mr369796137.24.1755253418929;
        Fri, 15 Aug 2025 03:23:38 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-8902790acdesm164768241.22.2025.08.15.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:23:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:23:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
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
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.26e28ce8a7fe@gmail.com>
In-Reply-To: <20250814114030.7683-4-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-4-richardbgobert@gmail.com>
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
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled. In the future, we could add
> NETIF_F_TSO_MANGLEID_{INNER,OUTER} to provide more granular control to
> drivers.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  Documentation/networking/segmentation-offloads.rst |  4 ++--
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++++++--
>  drivers/net/ethernet/sfc/ef100_tx.c                | 14 ++++++++------
>  include/linux/netdevice.h                          |  9 +++++++--
>  include/linux/skbuff.h                             |  6 +++++-
>  net/core/dev.c                                     |  7 +++----
>  net/ipv4/af_inet.c                                 | 13 ++++++-------
>  net/ipv4/tcp_offload.c                             |  4 +---
>  9 files changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
> index 085e8fab03fd..21c759b81f4e 100644
> --- a/Documentation/networking/segmentation-offloads.rst
> +++ b/Documentation/networking/segmentation-offloads.rst
> @@ -42,8 +42,8 @@ also point to the TCP header of the packet.
>  
>  For IPv4 segmentation we support one of two types in terms of the IP ID.
>  The default behavior is to increment the IP ID with every segment.  If the
> -GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
> -ID and all segments will use the same IP ID.  If a device has
> +GSO type SKB_GSO_TCP_FIXEDID_{OUTER,INNER} is specified then we will not
> +increment the IP ID and all segments will use the same IP ID.  If a device has
>  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>  and we will either increment the IP ID for all frames, or leave it at a
>  static value based on driver preference.
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index bfa5568baa92..b28f890b0af5 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -3868,7 +3868,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>  
>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
>  
>  	skb->csum_start = (unsigned char *)th - skb->head;
>  	skb->csum_offset = offsetof(struct tcphdr, check);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..78df60c62225 100644
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
> +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID_OUTER;
> +	}
>  
>  	skb->csum_start = (unsigned char *)tcp - skb->head;
>  	skb->csum_offset = offsetof(struct tcphdr, check);
> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> index e6b6be549581..aab2425e62bb 100644
> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  {
>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
> -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>  	unsigned int outer_ip_offset, outer_l4_offset;
>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>  	u32 mss = skb_shinfo(skb)->gso_size;
> @@ -200,8 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  	bool outer_csum;
>  	u32 paylen;
>  
> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER)
> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
> +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>  		vlan_enable = skb_vlan_tag_present(skb);
>  
> @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
>  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
>  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
> -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
> +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
>  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
>  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
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
> index 5e5de4b0a433..e55ba6918b0a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>  
>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>  {
> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
> +	netdev_features_t feature;
> +
> +	if (gso_type & (SKB_GSO_TCP_FIXEDID_OUTER | SKB_GSO_TCP_FIXEDID_INNER))
> +		gso_type |= __SKB_GSO_TCP_FIXEDID;

This is quite peculiar.

Is there a real use case for specifying FIXEDID separately for outer
and inner? Can the existing single bit govern both together instead?
That would be a lot simpler.

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
> index 14b923ddb6df..5cfbf6e8c7ea 100644
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
> @@ -707,6 +707,10 @@ enum {
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
> +
> +	/* These don't correspond with netdev features. */
> +	SKB_GSO_TCP_FIXEDID_OUTER = 1 << 30,
> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>  };
>  
>  #if BITS_PER_LONG > 32
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 68dc47d7e700..9941c39b5970 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * IPv4 header has the potential to be fragmented.
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> -
> -		if (!(iph->frag_off & htons(IP_DF)))
> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
> +		    (skb->encapsulation &&
> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>  			features &= ~NETIF_F_TSO_MANGLEID;
>  	}
>  
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 76e38092cd8a..7f29b485009d 100644
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
> +	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID_OUTER << encap));
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
> index 74f46663eeae..83fa6b2aecf4 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -485,10 +485,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>  				  iph->daddr, 0);
>  
> -	bool is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
> -
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID_OUTER);
>  
>  	tcp_gro_complete(skb);
>  	return 0;
> -- 
> 2.36.1
> 



