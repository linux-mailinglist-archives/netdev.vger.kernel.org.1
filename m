Return-Path: <netdev+bounces-124473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9290969990
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800D0288ACA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD031AD253;
	Tue,  3 Sep 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXm80vSC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE291AD245
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357314; cv=none; b=e4pbGt9d27qPhGzG7CCdFDODxUAN7g8Hdat5SSaIvoi1bzoO0HpkmtuENuKIgASdP+7HhxjK9J/2eFcPU+7H4uTcABB55k4bOoo8Qa725c5ZAeyg4PcQcY/bTBERT+C6KuAgxb1RHIrIRFn2aQm2NoP6lpiMQmJGCaYgrWObXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357314; c=relaxed/simple;
	bh=gumwLmVzBA7FE9rL78o6pS12HC0gVXuixmNYcaiUjMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fu0hgdvdkMN6E9DfOGb/tt9M37fl7palHdrQTb+vvHtDUEgtAVOCqnyT7WFG0o6JCvyr5IcDYYd8MxKK3+wFqFn+NuDkCj40VOTxAgyJ4cdnpzgkEtjKJrfMccKAp/GQ0wVrNzg0pPvzTccL1iFMMXhNCHcY2IkGkmnBPj4+5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXm80vSC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725357311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6cl3luTpkd8vDz6hnLpwHsFnsILNWhe0I9DX7IcglA=;
	b=WXm80vSC6YfOdf8TAHulukCb1di5OXyXgxI81raZBV7+t+d2rkwBfUZ//Ngjx+tfPAIYgl
	0fqrI+ljtqlZxb6riUE7E/hPD8ZbN4YesrlbXdAWQtcPNMgTz/NY7y3rch8XfN3U1BVanp
	5bYFlxAuBQX9UIOX6cfUyunNtDNXouY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-RKr4pPAoMI6haUFIdyHQsA-1; Tue, 03 Sep 2024 05:55:10 -0400
X-MC-Unique: RKr4pPAoMI6haUFIdyHQsA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53436749138so5569898e87.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 02:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725357309; x=1725962109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6cl3luTpkd8vDz6hnLpwHsFnsILNWhe0I9DX7IcglA=;
        b=qvb4ZQ8LwUatS9QQLtPG9fAbXf2pUxPVQvx1eD7z7X9S+zQyyCRREBirtI53WGrbro
         AlIe3vH89VdBDZTNlDf3XSP3ZcDahhu/liSStzdJKPd6kIIpAGbpkPCc0wju5oZUtmJj
         2z5XF5mYrBckPFQLMSigJqEMVSVMbcn3WgtedmhCYlITwe9eeEO9z3neGqfYWdiAxfql
         5XsQerDkFoLLD7mQvaHPbmcpwnWCBalNV2lj2gyI4QW15vtcKh2S4xE9YzQk2fBafuDO
         R16g4TpQ8sau2MW0SKjJDozlinjkodVAaCuPKqEpChjQymYGWlPN2vyndojTbQhXkpIb
         I4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ltdrPHZmO22mgHX0OTjeX8qqLiARFr0R2Ng6KpxX2/h2M+fpWR8JZivO61UPOAspdMlFeog=@vger.kernel.org
X-Gm-Message-State: AOJu0YypUEHget/gs8LAotMZiV+m8REI/DLfQKOgbrDf2+/aeyz+lnGR
	qMKL8qFQQNBuRbhehvl7iOinN7uU89gG5TC4FTBag48cNvpvoSd0mgsPUtkbM7O2DE/C8yfFUPC
	4n8drcIaB9gYONmv+/fPJ4YavxAg9/z1/PF86SY++/rA1rrKE9BrtBg==
X-Received: by 2002:a05:6512:3d0c:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-53546b05c10mr9366572e87.13.1725357309005;
        Tue, 03 Sep 2024 02:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+vEqACSPoPr/P7kUg6deSgPYKTUjYfbBUFIriRYgqxBdn/NgftHOt/9f+ooB0keSZ0MtqIA==
X-Received: by 2002:a05:6512:3d0c:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-53546b05c10mr9366525e87.13.1725357308316;
        Tue, 03 Sep 2024 02:55:08 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639687csm197786695e9.8.2024.09.03.02.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 02:55:07 -0700 (PDT)
Message-ID: <c193cbf3-58e5-41bd-855d-07a9c08e283d@redhat.com>
Date: Tue, 3 Sep 2024 11:55:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] netdev_features: convert NETIF_F_FCOE_MTU
 to dev->fcoe_mtu
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
References: <20240829123340.789395-1-aleksander.lobakin@intel.com>
 <20240829123340.789395-5-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829123340.789395-5-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CC: Martin and Hannes, to raise awareness that the core networking 
changes in here will introduce a small delta in the scsi subsystem, too.

On 8/29/24 14:33, Alexander Lobakin wrote:
> Ability to handle maximum FCoE frames of 2158 bytes can never be changed
> and thus more of an attribute, not a toggleable feature.
> Move it from netdev_features_t to "cold" priv flags (bitfield bool) and
> free yet another feature bit.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   .../networking/net_cachelines/net_device.rst          |  1 +
>   include/linux/netdev_features.h                       |  6 ++----
>   include/linux/netdevice.h                             |  2 ++
>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c       |  6 ++----
>   drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c       |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c         |  4 ++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c          |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c         | 11 ++++-------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c        |  4 ++--
>   drivers/scsi/fcoe/fcoe.c                              |  4 ++--
>   net/8021q/vlan_dev.c                                  |  1 +
>   net/ethtool/common.c                                  |  1 -
>   12 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index e65ffdfc9e0a..c3bbf101a887 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -167,6 +167,7 @@ unsigned:1                          threaded                -
>   unsigned_long:1                     see_all_hwtstamp_requests
>   unsigned_long:1                     change_proto_down
>   unsigned_long:1                     netns_local
> +unsigned_long:1                     fcoe_mtu
>   struct_list_head                    net_notifier_list
>   struct_macsec_ops*                  macsec_ops
>   struct_udp_tunnel_nic_info*         udp_tunnel_nic_info
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index d5a3836f4793..37af2c6e7caf 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -58,7 +58,7 @@ enum {
>   
>   	NETIF_F_FCOE_CRC_BIT,		/* FCoE CRC32 */
>   	NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
> -	NETIF_F_FCOE_MTU_BIT,		/* Supports max FCoE MTU, 2158 bytes*/
> +	__UNUSED_NETIF_F_37,
>   	NETIF_F_NTUPLE_BIT,		/* N-tuple filters supported */
>   	NETIF_F_RXHASH_BIT,		/* Receive hashing offload */
>   	NETIF_F_RXCSUM_BIT,		/* Receive checksumming offload */
> @@ -105,7 +105,6 @@ enum {
>   #define __NETIF_F(name)		__NETIF_F_BIT(NETIF_F_##name##_BIT)
>   
>   #define NETIF_F_FCOE_CRC	__NETIF_F(FCOE_CRC)
> -#define NETIF_F_FCOE_MTU	__NETIF_F(FCOE_MTU)
>   #define NETIF_F_FRAGLIST	__NETIF_F(FRAGLIST)
>   #define NETIF_F_FSO		__NETIF_F(FSO)
>   #define NETIF_F_GRO		__NETIF_F(GRO)
> @@ -210,8 +209,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
>   #define NETIF_F_ALL_TSO 	(NETIF_F_TSO | NETIF_F_TSO6 | \
>   				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
>   
> -#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FCOE_MTU | \
> -				 NETIF_F_FSO)
> +#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FSO)
>   
>   /* List of features with software fallbacks. */
>   #define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index a698e2402420..ca5f0dda733b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1969,6 +1969,7 @@ enum netdev_reg_state {
>    *			HWTSTAMP_SOURCE_NETDEV
>    *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
>    *	@netns_local: interface can't change network namespaces
> + *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
>    *
>    *	@net_notifier_list:	List of per-net netdev notifier block
>    *				that follow this device when it is moved
> @@ -2363,6 +2364,7 @@ struct net_device {
>   	unsigned long		see_all_hwtstamp_requests:1;
>   	unsigned long		change_proto_down:1;
>   	unsigned long		netns_local:1;
> +	unsigned long		fcoe_mtu:1;
>   
>   	struct list_head	net_notifier_list;
>   
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
> index 33b2c0c45509..f6f745f5c022 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
> @@ -81,8 +81,7 @@ int cxgb_fcoe_enable(struct net_device *netdev)
>   
>   	netdev->features |= NETIF_F_FCOE_CRC;
>   	netdev->vlan_features |= NETIF_F_FCOE_CRC;
> -	netdev->features |= NETIF_F_FCOE_MTU;
> -	netdev->vlan_features |= NETIF_F_FCOE_MTU;
> +	netdev->fcoe_mtu = true;
>   
>   	netdev_features_change(netdev);
>   
> @@ -112,8 +111,7 @@ int cxgb_fcoe_disable(struct net_device *netdev)
>   
>   	netdev->features &= ~NETIF_F_FCOE_CRC;
>   	netdev->vlan_features &= ~NETIF_F_FCOE_CRC;
> -	netdev->features &= ~NETIF_F_FCOE_MTU;
> -	netdev->vlan_features &= ~NETIF_F_FCOE_MTU;
> +	netdev->fcoe_mtu = false;
>   
>   	netdev_features_change(netdev);
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
> index e85f7d2e8810..f2709b10c2e5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
> @@ -317,7 +317,7 @@ static u8 ixgbe_dcbnl_set_all(struct net_device *netdev)
>   		int max_frame = adapter->netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
>   
>   #ifdef IXGBE_FCOE
> -		if (adapter->netdev->features & NETIF_F_FCOE_MTU)
> +		if (adapter->netdev->fcoe_mtu)
>   			max_frame = max(max_frame, IXGBE_FCOE_JUMBO_FRAME_SIZE);
>   #endif
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 18d63c8c2ff4..955dced844a9 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -858,7 +858,7 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>   
>   	/* enable FCoE and notify stack */
>   	adapter->flags |= IXGBE_FLAG_FCOE_ENABLED;
> -	netdev->features |= NETIF_F_FCOE_MTU;
> +	netdev->fcoe_mtu = true;
>   	netdev_features_change(netdev);
>   
>   	/* release existing queues and reallocate them */
> @@ -898,7 +898,7 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
>   
>   	/* disable FCoE and notify stack */
>   	adapter->flags &= ~IXGBE_FLAG_FCOE_ENABLED;
> -	netdev->features &= ~NETIF_F_FCOE_MTU;
> +	netdev->fcoe_mtu = false;
>   
>   	netdev_features_change(netdev);
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index 0ee943db3dc9..16fa621ce0ff 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -981,7 +981,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>   			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, &ring->state);
>   
>   #ifdef IXGBE_FCOE
> -		if (adapter->netdev->features & NETIF_F_FCOE_MTU) {
> +		if (adapter->netdev->fcoe_mtu) {
>   			struct ixgbe_ring_feature *f;
>   			f = &adapter->ring_feature[RING_F_FCOE];
>   			if ((rxr_idx >= f->offset) &&
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8057cef61f39..8b8404d8c946 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -5079,7 +5079,7 @@ static void ixgbe_configure_dcb(struct ixgbe_adapter *adapter)
>   		netif_set_tso_max_size(adapter->netdev, 32768);
>   
>   #ifdef IXGBE_FCOE
> -	if (adapter->netdev->features & NETIF_F_FCOE_MTU)
> +	if (adapter->netdev->fcoe_mtu)
>   		max_frame = max(max_frame, IXGBE_FCOE_JUMBO_FRAME_SIZE);
>   #endif
>   
> @@ -5136,8 +5136,7 @@ static int ixgbe_hpbthresh(struct ixgbe_adapter *adapter, int pb)
>   
>   #ifdef IXGBE_FCOE
>   	/* FCoE traffic class uses FCOE jumbo frames */
> -	if ((dev->features & NETIF_F_FCOE_MTU) &&
> -	    (tc < IXGBE_FCOE_JUMBO_FRAME_SIZE) &&
> +	if (dev->fcoe_mtu && tc < IXGBE_FCOE_JUMBO_FRAME_SIZE &&
>   	    (pb == ixgbe_fcoe_get_tc(adapter)))
>   		tc = IXGBE_FCOE_JUMBO_FRAME_SIZE;
>   #endif
> @@ -5197,8 +5196,7 @@ static int ixgbe_lpbthresh(struct ixgbe_adapter *adapter, int pb)
>   
>   #ifdef IXGBE_FCOE
>   	/* FCoE traffic class uses FCOE jumbo frames */
> -	if ((dev->features & NETIF_F_FCOE_MTU) &&
> -	    (tc < IXGBE_FCOE_JUMBO_FRAME_SIZE) &&
> +	if (dev->fcoe_mtu && tc < IXGBE_FCOE_JUMBO_FRAME_SIZE &&
>   	    (pb == netdev_get_prio_tc_map(dev, adapter->fcoe.up)))
>   		tc = IXGBE_FCOE_JUMBO_FRAME_SIZE;
>   #endif
> @@ -11096,8 +11094,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   				    NETIF_F_FCOE_CRC;
>   
>   		netdev->vlan_features |= NETIF_F_FSO |
> -					 NETIF_F_FCOE_CRC |
> -					 NETIF_F_FCOE_MTU;
> +					 NETIF_F_FCOE_CRC;
>   	}
>   #endif /* IXGBE_FCOE */
>   	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index fcfd0a075eee..e71715f5da22 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -495,7 +495,7 @@ static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 max_frame, u32 vf
>   		int err = 0;
>   
>   #ifdef CONFIG_FCOE
> -		if (dev->features & NETIF_F_FCOE_MTU)
> +		if (dev->fcoe_mtu)
>   			pf_max_frame = max_t(int, pf_max_frame,
>   					     IXGBE_FCOE_JUMBO_FRAME_SIZE);
>   
> @@ -857,7 +857,7 @@ static void ixgbe_set_vf_rx_tx(struct ixgbe_adapter *adapter, int vf)
>   		int pf_max_frame = dev->mtu + ETH_HLEN;
>   
>   #if IS_ENABLED(CONFIG_FCOE)
> -		if (dev->features & NETIF_F_FCOE_MTU)
> +		if (dev->fcoe_mtu)
>   			pf_max_frame = max_t(int, pf_max_frame,
>   					     IXGBE_FCOE_JUMBO_FRAME_SIZE);
>   #endif /* CONFIG_FCOE */
> diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
> index f1429f270170..39aec710660c 100644
> --- a/drivers/scsi/fcoe/fcoe.c
> +++ b/drivers/scsi/fcoe/fcoe.c
> @@ -722,7 +722,7 @@ static int fcoe_netdev_config(struct fc_lport *lport, struct net_device *netdev)
>   	 * will return 0, so do this first.
>   	 */
>   	mfs = netdev->mtu;
> -	if (netdev->features & NETIF_F_FCOE_MTU) {
> +	if (netdev->fcoe_mtu) {
>   		mfs = FCOE_MTU;
>   		FCOE_NETDEV_DBG(netdev, "Supports FCOE_MTU of %d bytes\n", mfs);
>   	}
> @@ -1863,7 +1863,7 @@ static int fcoe_device_notification(struct notifier_block *notifier,
>   	case NETDEV_CHANGE:
>   		break;
>   	case NETDEV_CHANGEMTU:
> -		if (netdev->features & NETIF_F_FCOE_MTU)
> +		if (netdev->fcoe_mtu)
>   			break;
>   		mfs = netdev->mtu - (sizeof(struct fcoe_hdr) +
>   				     sizeof(struct fcoe_crc_eof));
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index 3ca485537d77..09b46b057ab2 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -571,6 +571,7 @@ static int vlan_dev_init(struct net_device *dev)
>   
>   	dev->features |= dev->hw_features;
>   	dev->lltx = true;
> +	dev->fcoe_mtu = true;
>   	netif_inherit_tso_max(dev, real_dev);
>   	if (dev->features & NETIF_F_VLAN_FEATURES)
>   		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index ca8e64162104..00f93c58b319 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -50,7 +50,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>   
>   	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
>   	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
> -	[NETIF_F_FCOE_MTU_BIT] =         "fcoe-mtu",
>   	[NETIF_F_NTUPLE_BIT] =           "rx-ntuple-filter",
>   	[NETIF_F_RXHASH_BIT] =           "rx-hashing",
>   	[NETIF_F_RXCSUM_BIT] =           "rx-checksum",


