Return-Path: <netdev+bounces-124459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B669698DF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5243B28CFB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902A1A4E80;
	Tue,  3 Sep 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOfu9l53"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9D1A3A9F
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355484; cv=none; b=AbYp3sngvVWrcIHjW5Sg1tCaPNIGoSFVIT8I1yPKyN1ifcFSyvT6Cpp0wUoH2aAmqseSHE1gdOl6hfoHD+y7D47s08FzJ6zlOtQnijIL6ClFYVLTLEpVw7lyKj+xMINPkOMUZCLL+hTAteGuYlbelralGfgs51SrCRalyFc1b2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355484; c=relaxed/simple;
	bh=C88QgseTf5svIX72vF9YjAawJ/OqfVeT+abNQqK5gxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QL5z6+qJsUeJPoa1CIT/qMxLuvGF98LnEnE2fntrt7+96NYNiTtTZp3nT5aMGi3LGGEr01fNGJLg+cOZJZVeX7FdaRVYWdbKvIi2RE5GdEAo8eTqPeLhZgLfjSin6H8/XFxfW3ZCHfhp67QhBpk0ImkzrVbAnNILRcJlp1BnKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOfu9l53; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725355481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t06Usb+7GCh8eRzIVQtpE7SH1xzcDEf04HaEyeOIHw4=;
	b=YOfu9l53T5VPQetgBxSF1FlOVww9mERj+AlIAoaw0sD5Yh42KiV4OmEJSMyo8FdhrHojVP
	UU4QZndQWp4STe9LMYfJgGLcWsgabZ7xfWHodI1baHmoPsVa4081DU7z4cDVBa8T2r3EIP
	+baznVwQLMlv+imUwpxHmbMyFgTjo1M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-YI_NdEkRMHqjVdOthwh8Sg-1; Tue, 03 Sep 2024 05:24:40 -0400
X-MC-Unique: YI_NdEkRMHqjVdOthwh8Sg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334af2a84fso5443686e87.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355479; x=1725960279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t06Usb+7GCh8eRzIVQtpE7SH1xzcDEf04HaEyeOIHw4=;
        b=S6sWxBa3jxDXk8sSJ493Cu6a+1OkUdZDqdxBoZMbmADh8YX6mVYvTNRnWzs+ohbdzh
         hDpF8UYvBXFdsG9r2vGxXCDd56VrxV0VBbLJ2vB+9vIJchVYJaZQ0RAdc3P29XUBBHRe
         k2xK1jLyrU0GNqzUhaf7bMfSCwCtEhyCWfVAJW2lSd8AYhuTu4nxLFd+XCQ0QakAUa2m
         DBzKIjU8W/o4oXdmcqGu0pS2F+c8GVf8Bhdhdon9Qusvn85qGOCSr4662DhNJu5RPZgr
         EvHXlWBXWQeFvd7bIcOp33B0lJTfnxlHTOArgv76sSh8YbTXXD1ibGq24Glb1nehiodH
         I90g==
X-Forwarded-Encrypted: i=1; AJvYcCUX33WFMbZHjqa1KNRv2yhro30A/Qcdr1NKN5GR0Qa7LvpyRMTEsn+aD4DE/xD0DViu1ix12lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/PDrp8RJP+UbTRD7I+M1Dr/e2E1/OLEEgFJtGoAQ2s8WXrYJ
	0k04rUy018G6Wj8F2e+yEzh9HF7KvN5R6lffhub31f/yBAkgc8xfICR/C9FG1o+r1xheX+Hav5x
	6FZI2P3zhZT7/Tho8XEzisaGqaWSVGi3JP6u3jAVjeE7sQ7zVGWrnuA==
X-Received: by 2002:a05:6512:1282:b0:52e:91ff:4709 with SMTP id 2adb3069b0e04-53546b2574fmr9284204e87.21.1725355478923;
        Tue, 03 Sep 2024 02:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQAT4XToSYikFbG/yyzMEKVCK+e/XPhr/IBFLWLbzHtUpo5lYIXPVLJHzU5gy7Jzkm4eB7/Q==
X-Received: by 2002:a05:6512:1282:b0:52e:91ff:4709 with SMTP id 2adb3069b0e04-53546b2574fmr9284174e87.21.1725355478288;
        Tue, 03 Sep 2024 02:24:38 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d83sm164911255e9.44.2024.09.03.02.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 02:24:37 -0700 (PDT)
Message-ID: <d4c6eae3-8dce-4418-a5c6-da5904f580cd@redhat.com>
Date: Tue, 3 Sep 2024 11:24:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/5] netdev_features: start cleaning
 netdev_features_t up
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240829123340.789395-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829123340.789395-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 14:33, Alexander Lobakin wrote:
> NETDEV_FEATURE_COUNT is currently 64, which means we can't add any new
> features as netdev_features_t is u64.
> As per several discussions, instead of converting netdev_features_t to
> a bitmap, which would mean A LOT of changes, we can try cleaning up
> netdev feature bits.
> There's a bunch of bits which don't really mean features, rather device
> attributes/properties that can't be changed via Ethtool in any of the
> drivers. Such attributes can be moved to netdev private flags without
> losing any functionality.
> 
> Start converting some read-only netdev features to private flags from
> the ones that are most obvious, like lockless Tx, inability to change
> network namespace etc. I was able to reduce NETDEV_FEATURE_COUNT from
> 64 to 60, which mean 4 free slots for new features. There are obviously
> more read-only features to convert, such as highDMA, "challenged VLAN",
> HSR (4 bits) - this will be done in subsequent series.
> 
> Please note that currently netdev features are not uAPI/ABI by any means.
> Ethtool passes their names and bits to the userspace separately and there
> are no hardcoded names/bits in the userspace, so that new Ethtool could
> work on older kernels and vice versa.
> This, however, isn't true for Ethtools < 3.4. I haven't changed the bit
> positions of the already existing features and instead replaced the freed
> bits with stubs. But it's anyway theoretically possible that Ethtools
> older than 2011 will break. I hope no currently supported distros supply
> such an ancient version.
> Shell scripts also most likely won't break since the removed bits were
> always read-only, meaning nobody would try touching them from a script.
> 
> Alexander Lobakin (5):
>    netdevice: convert private flags > BIT(31) to bitfields
>    netdev_features: convert NETIF_F_LLTX to dev->lltx
>    netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local
>    netdev_features: convert NETIF_F_FCOE_MTU to dev->fcoe_mtu
>    netdev_features: remove NETIF_F_ALL_FCOE
> 
>   .../networking/net_cachelines/net_device.rst  |  7 +++-
>   Documentation/networking/netdev-features.rst  | 15 -------
>   Documentation/networking/netdevices.rst       |  4 +-
>   Documentation/networking/switchdev.rst        |  4 +-
>   drivers/net/ethernet/tehuti/tehuti.h          |  2 +-
>   include/linux/netdev_features.h               | 16 ++-----
>   include/linux/netdevice.h                     | 42 +++++++++++++------
>   drivers/net/amt.c                             |  4 +-
>   drivers/net/bareudp.c                         |  2 +-
>   drivers/net/bonding/bond_main.c               |  8 ++--
>   drivers/net/dummy.c                           |  3 +-
>   drivers/net/ethernet/adi/adin1110.c           |  2 +-
>   drivers/net/ethernet/chelsio/cxgb/cxgb2.c     |  3 +-
>   .../net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c   |  6 +--
>   .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  3 +-
>   .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  3 +-
>   .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  4 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 ++---
>   .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  4 +-
>   .../ethernet/marvell/prestera/prestera_main.c |  3 +-
>   .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +-
>   .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  3 +-
>   .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++-
>   .../ethernet/microchip/lan966x/lan966x_main.c |  2 +-
>   .../net/ethernet/netronome/nfp/nfp_net_repr.c |  3 +-
>   drivers/net/ethernet/pasemi/pasemi_mac.c      |  5 ++-
>   .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  2 +-
>   drivers/net/ethernet/rocker/rocker_main.c     |  3 +-
>   drivers/net/ethernet/sfc/ef100_rep.c          |  4 +-
>   drivers/net/ethernet/tehuti/tehuti.c          |  4 +-
>   drivers/net/ethernet/ti/cpsw_new.c            |  3 +-
>   drivers/net/ethernet/toshiba/spider_net.c     |  3 +-
>   drivers/net/geneve.c                          |  2 +-
>   drivers/net/gtp.c                             |  2 +-
>   drivers/net/hamradio/bpqether.c               |  2 +-
>   drivers/net/ipvlan/ipvlan_main.c              |  3 +-
>   drivers/net/loopback.c                        |  4 +-
>   drivers/net/macsec.c                          |  4 +-
>   drivers/net/macvlan.c                         |  6 ++-
>   drivers/net/net_failover.c                    |  4 +-
>   drivers/net/netkit.c                          |  3 +-
>   drivers/net/nlmon.c                           |  4 +-
>   drivers/net/ppp/ppp_generic.c                 |  2 +-
>   drivers/net/rionet.c                          |  2 +-
>   drivers/net/team/team_core.c                  |  8 ++--
>   drivers/net/tun.c                             |  5 ++-
>   drivers/net/veth.c                            |  2 +-
>   drivers/net/vrf.c                             |  4 +-
>   drivers/net/vsockmon.c                        |  4 +-
>   drivers/net/vxlan/vxlan_core.c                |  5 ++-
>   drivers/net/wireguard/device.c                |  2 +-
>   drivers/scsi/fcoe/fcoe.c                      |  4 +-
>   drivers/staging/octeon/ethernet.c             |  2 +-
>   lib/test_bpf.c                                |  3 +-
>   net/8021q/vlan_dev.c                          | 10 +++--
>   net/8021q/vlanproc.c                          |  4 +-
>   net/batman-adv/soft-interface.c               |  5 ++-
>   net/bridge/br_device.c                        |  6 ++-
>   net/core/dev.c                                |  8 ++--
>   net/core/dev_ioctl.c                          |  9 ++--
>   net/core/net-sysfs.c                          |  3 +-
>   net/core/rtnetlink.c                          |  2 +-
>   net/dsa/user.c                                |  3 +-
>   net/ethtool/common.c                          |  3 --
>   net/hsr/hsr_device.c                          | 12 +++---
>   net/ieee802154/6lowpan/core.c                 |  2 +-
>   net/ieee802154/core.c                         | 10 ++---
>   net/ipv4/ip_gre.c                             |  4 +-
>   net/ipv4/ip_tunnel.c                          |  2 +-
>   net/ipv4/ip_vti.c                             |  2 +-
>   net/ipv4/ipip.c                               |  2 +-
>   net/ipv4/ipmr.c                               |  2 +-
>   net/ipv6/ip6_gre.c                            |  7 ++--
>   net/ipv6/ip6_tunnel.c                         |  4 +-
>   net/ipv6/ip6mr.c                              |  2 +-
>   net/ipv6/sit.c                                |  4 +-
>   net/l2tp/l2tp_eth.c                           |  2 +-
>   net/openvswitch/vport-internal_dev.c          | 11 ++---
>   net/wireless/core.c                           | 10 ++---
>   net/xfrm/xfrm_interface_core.c                |  2 +-
>   tools/testing/selftests/net/forwarding/README |  2 +-
>   83 files changed, 208 insertions(+), 194 deletions(-)
> 
> ---
>  From v4[0]:
> * don't remove the freed feature bits completely and replace them with
>    stubs to keep the original bit positions of the already present
>    features (Jakub);
> * mention potential Ethtool < 3.4 breakage (Eric).
> 
>  From v3[1]:
> * 0001: fix kdoc for priv_flags_fast (it doesn't support describing
>    struct_groups()s yet) (Jakub);
> * 0006: fix subject prefix (make it consistent with the rest).
> 
>  From v2[2]:
> * rebase on top of the latest net-next;
> * 0003: don't remove the paragraph saying "LLTX is deprecated for real
>    HW drivers" (Willem);
> * 0006: new, remove %NETIF_F_ALL_FCOE used only 2 times in 1 file
>    (Jakub);
> * no functional changes.
> 
>  From v1[3]:
> * split bitfield priv flags into "hot" and "cold", leave the first
>    placed where the old ::priv_flags is and move the rest down next
>    to ::threaded (Jakub);
> * document all the changes in Documentation/networking/net_cachelines/
>    net_device.rst;
> * #3: remove the "-1 cacheline on Tx" paragraph, not really true (Eric).
> 
>  From RFC[4]:
> * drop:
>    * IFF_LOGICAL (as (LLTX | IFF_NO_QUEUE)) - will be discussed later;
>    * NETIF_F_HIGHDMA conversion - requires priv flags inheriting etc.,
>      maybe later;
>    * NETIF_F_VLAN_CHALLENGED conversion - same as above;
> * convert existing priv_flags > BIT(31) to bitfield booleans and define
>    new flags the same way (Jakub);
> * mention a couple times that netdev features are not uAPI/ABI by any
>    means (Andrew).
> 
> [0] https://lore.kernel.org/netdev/20240821150700.1760518-1-aleksander.lobakin@intel.com
> [1] https://lore.kernel.org/netdev/20240808152757.2016725-1-aleksander.lobakin@intel.com
> [2] https://lore.kernel.org/netdev/20240703150342.1435976-1-aleksander.lobakin@intel.com
> [3] https://lore.kernel.org/netdev/20240625114432.1398320-1-aleksander.lobakin@intel.com
> [4] https://lore.kernel.org/netdev/20240405133731.1010128-1-aleksander.lobakin@intel.com

I think we are better off merging this series not too far into the 
release cycle. My understanding is that the points raised on the 
previous revisions have been addressed so I'll go over this a last time 
and eventually merge it soon.

Thanks,

Paolo


