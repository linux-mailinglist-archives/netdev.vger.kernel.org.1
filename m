Return-Path: <netdev+bounces-214059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE7B2803B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A1EAA86FC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ACE2C15BD;
	Fri, 15 Aug 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVLHzfBg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F1DDAB;
	Fri, 15 Aug 2025 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262830; cv=none; b=Y/6RWmchP+a/P4a5vy8NpAPFxEReEuGzMAtHSEIlV9EsBQvsSrC03kVBsUHV0MemlHPxhNIW7H4utwT42WjT8I4+VzKTuClsl+5nb8vMUCYLksaDHfNwMEwHy6h+K+hBEFb26itQi3F2p/5xs7JQ2Vf7+9sQgFp8lbLBscg2VoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262830; c=relaxed/simple;
	bh=jReMtyMVfaI38x7AYvgkNr9/WU9IXn6oDlYM0EaPSXY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dbHdbXQ2E69nFrcv5LDoVX4AISWvB5lWvs6Q7RRmCdJf5L6eFGMidELp4SUXEMnPomeUlEB31OirkOaBEFUpObuaZHBwz4yKdG/TEytSKsSmv9yttlRww0nypoRgE5DSqKV41BLm0IBmrcGjYB6nA/xzECBBdQ7qAAQaw/ELWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVLHzfBg; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b174dbfceso636205e0c.2;
        Fri, 15 Aug 2025 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755262827; x=1755867627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlWAc4SyHnomjFqQrOTece0HB5MxvoeqYGHxin+mq0w=;
        b=LVLHzfBgRtn4eUQuKmObytgoJxP75/9hV+Y26lCLUwHAAaRZcUReON2q92Jd0jndWz
         hYGSg8xw5gvMmKMH8Lba89ehOqmap3X+OSjZDEZk+1e871N7JAY6iHlXdaXfQTBLkx0R
         VRnkBwdS3eWISHZlQrN6+rPhDR5p9nSs4+85dYO2LvNR0fe5kocVkP1LcvkEaOShpSiF
         /UhkRoSh2aGmOPfDWuoGNszWjHJRLFcbRjCEgNtNFTXXnxjXZdEcxPW5/Xju3Db5MeRr
         74GLDIfzggpaWXjCh5GeBQ3G1XP2p4d3zyJCre58jo/UfW64QV/UNEjBWAxAxy+Sq8vz
         osLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755262827; x=1755867627;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GlWAc4SyHnomjFqQrOTece0HB5MxvoeqYGHxin+mq0w=;
        b=tJP3glrYpstY1s2WM9SxJfCIBD4jpo+b1OxuHCag0hvDcDPZu+6ko27zh75u0Mcq2q
         2MQHJvlzpY2knVJXqo+DHxwDp/Rk0NQMk4cFidKP+9rq05u9r2ZU9XTWUtlqQY2imK7b
         HgbAs2Gaoox0hytq06RNS6U5Su5hgrQ7WXDO3pyovdPwH7XSKwUroZChCihlqB2ooPUz
         QzAsze+Sd6lZNEf84SE0B2pPprWXs/2qr37uEKQ1+wckMkgp3bhwWGxsdjkQOpkq8Ovb
         9Zx3/lEXHu7HV6prs2KHzNzFR/E1YD6ERfDFY2d5oUIyG9xNuW45n3Oz3VgWGwpqRFTq
         bz4w==
X-Forwarded-Encrypted: i=1; AJvYcCUdx4PZBzz1iUINIvoXPa9B44W9ttc0xvkwNIbTo/lhe/HeKBtEBnqN8DlPNNPR9+7ZFfZP5pxWjyaCLY4=@vger.kernel.org, AJvYcCWTTEayZ33H12utg6bMzE6OF37VynXFLe1a8pMASHobKy58RLuXkVUhOfKbq+Xth1Vz+wJVfWCC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfq+VPnFBnnKYL+RtEqVmerfC5GyFeu54+AOPHEV74ZS0wELZq
	wiLB2dR1auiu8yDs0jfbpcBMKdJ20FsSwTxmy8FG+lY6FvmMLLKGFXhY
X-Gm-Gg: ASbGncvgNS7mNbIvJWGfFIp0VGlRZ28//zXVbr+JmjV5or3QRHDf3Fc8KkAwLmTGozL
	aiyHnfBtFyHFexjsm12+Vy1whgisgV4toDH+0gpGxpd46HU1ausEe2/GgeA0R4b7RzOP3vWtZEt
	8OX2LBW6CGFZMonU68QDh2YQQIceB82xhJHB/bWr6SQkReYRIfHvduy0Ib81XkHihY/ulBCLwB/
	ozeMODlEAwxBrQp5NsBWwEJG5DTG+czT/sOYc43d5lrW0jZw5ZetjGoKHBk/wZUQWbCWUCLVatS
	aLvg0AM0T0c10IhI62LMb9+v78gE57sg7jdwJXlE1VCYEyzFlS4VPwuGaaUui6PbixXDUapRNhr
	jyJ71I2JBZZxf7xdHuBzKSTXCq7xOQEGaQTU5b3AJEbm6dmQWLQcR+mouxHh7flrq7Qf1hg==
X-Google-Smtp-Source: AGHT+IGjdPrOfsWm6qQKWwFB22Zd18SoOTWeGXeoE4cD+21p4eXdAAbE8ClQzPlwm0DENB+vkjTkvQ==
X-Received: by 2002:a05:6122:3186:b0:53b:1998:dbf5 with SMTP id 71dfb90a1353d-53b2b7a2eb5mr483921e0c.1.1755262826994;
        Fri, 15 Aug 2025 06:00:26 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bd552c1sm202133e0c.3.2025.08.15.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:00:26 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:00:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Richard Gobert <richardbgobert@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.2963bd70f4104@gmail.com>
In-Reply-To: <willemdebruijn.kernel.26e28ce8a7fe@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.26e28ce8a7fe@gmail.com>
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

Willem de Bruijn wrote:
> Richard Gobert wrote:
> > Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> > be mangled. Outer IDs can always be mangled.
> > 
> > Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> > both inner and outer IDs to be mangled. In the future, we could add
> > NETIF_F_TSO_MANGLEID_{INNER,OUTER} to provide more granular control to
> > drivers.
> > 
> > This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> > 
> > Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> > ---
> >  Documentation/networking/segmentation-offloads.rst |  4 ++--
> >  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++++++--
> >  drivers/net/ethernet/sfc/ef100_tx.c                | 14 ++++++++------
> >  include/linux/netdevice.h                          |  9 +++++++--
> >  include/linux/skbuff.h                             |  6 +++++-
> >  net/core/dev.c                                     |  7 +++----
> >  net/ipv4/af_inet.c                                 | 13 ++++++-------
> >  net/ipv4/tcp_offload.c                             |  4 +---
> >  9 files changed, 39 insertions(+), 28 deletions(-)
> > 
> > diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
> > index 085e8fab03fd..21c759b81f4e 100644
> > --- a/Documentation/networking/segmentation-offloads.rst
> > +++ b/Documentation/networking/segmentation-offloads.rst
> > @@ -42,8 +42,8 @@ also point to the TCP header of the packet.
> >  
> >  For IPv4 segmentation we support one of two types in terms of the IP ID.
> >  The default behavior is to increment the IP ID with every segment.  If the
> > -GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
> > -ID and all segments will use the same IP ID.  If a device has
> > +GSO type SKB_GSO_TCP_FIXEDID_{OUTER,INNER} is specified then we will not
> > +increment the IP ID and all segments will use the same IP ID.  If a device has
> >  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
> >  and we will either increment the IP ID for all frames, or leave it at a
> >  static value based on driver preference.
> > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > index bfa5568baa92..b28f890b0af5 100644
> > --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > @@ -3868,7 +3868,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
> >  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> >  
> >  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
> > -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> > +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
> >  
> >  	skb->csum_start = (unsigned char *)th - skb->head;
> >  	skb->csum_offset = offsetof(struct tcphdr, check);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > index b8c609d91d11..78df60c62225 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
> >  	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
> >  				   ipv4->daddr, 0);
> >  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
> > -	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
> > -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> > +	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
> > +		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
> > +
> > +		skb_shinfo(skb)->gso_type |= encap ?
> > +					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID_OUTER;
> > +	}
> >  
> >  	skb->csum_start = (unsigned char *)tcp - skb->head;
> >  	skb->csum_offset = offsetof(struct tcphdr, check);
> > diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> > index e6b6be549581..aab2425e62bb 100644
> > --- a/drivers/net/ethernet/sfc/ef100_tx.c
> > +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> > @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
> >  {
> >  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
> >  	unsigned int len, ip_offset, tcp_offset, payload_segs;
> > -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> > +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> > +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> >  	unsigned int outer_ip_offset, outer_l4_offset;
> >  	u16 vlan_tci = skb_vlan_tag_get(skb);
> >  	u32 mss = skb_shinfo(skb)->gso_size;
> > @@ -200,8 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
> >  	bool outer_csum;
> >  	u32 paylen;
> >  
> > -	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> > -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> > +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER)
> > +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> > +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
> > +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> >  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
> >  		vlan_enable = skb_vlan_tag_present(skb);
> >  
> > @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
> >  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
> >  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
> >  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
> > -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
> > +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
> >  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
> >  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
> >  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
> >  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
> >  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
> > -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
> > -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
> > +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
> >  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
> >  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
> >  		);
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 5e5de4b0a433..e55ba6918b0a 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
> >  
> >  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
> >  {
> > -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
> > +	netdev_features_t feature;
> > +
> > +	if (gso_type & (SKB_GSO_TCP_FIXEDID_OUTER | SKB_GSO_TCP_FIXEDID_INNER))
> > +		gso_type |= __SKB_GSO_TCP_FIXEDID;
> 
> This is quite peculiar.
> 
> Is there a real use case for specifying FIXEDID separately for outer
> and inner? Can the existing single bit govern both together instead?
> That would be a lot simpler.

I guess not, as with GRO this is under control of the sender, and
possibly a separate middlebox in control of encapsulation.

Still, possible to preserve existing FIXEDID for the unencapsulated
or inner, and add only one extra FIXEDID for outer? Or is there value
in having three bits?

