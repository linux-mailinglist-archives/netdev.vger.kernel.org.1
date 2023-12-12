Return-Path: <netdev+bounces-56387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC280EB0F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971B2281FAD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB05DF29;
	Tue, 12 Dec 2023 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaS8gfBg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC80AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702382301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI9ICHOGY11vqPJdF5T2PzwLO8YL0SXAzD/IQ5S+Vgw=;
	b=AaS8gfBgXTgJv0BRWfQ8GNitdYj7Y261/di4KWdHhj22V8M3Q6yLyHTc8ulJ1XVNI5vLhP
	8WI/g3r93NCA/sEzpHXOni8NY3j/i4sVucrxSTgNxyusgw+gSqnGFoVr99aw/Qpm2omDVd
	AvqWv3n3y2EaPaJAO6+D8ORpNkfHlb4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-qbbY-CHBOECif2EdXh73XA-1; Tue, 12 Dec 2023 06:58:20 -0500
X-MC-Unique: qbbY-CHBOECif2EdXh73XA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9f166590aso10327411fa.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702382298; x=1702987098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FI9ICHOGY11vqPJdF5T2PzwLO8YL0SXAzD/IQ5S+Vgw=;
        b=j31OzrQyI9apTebtgY6DuG0JB0zJq+w8QkcMpIRqlWvmZ6Ek/Fd3L82o4vPp8nllMF
         hqLQJfv5b2Ad+DtkW1iUfoAlTHjhkABoNEp1mW+8hzQKmhl38k052RNhIF2v/R8ITZ4K
         dpTpGFiS4CLjuB+HHcgr1c+K3sFR7l0TWJ7swMoP5hRl/cRMMiDaQPqOYUNBtmdFclkn
         PwKCU+RtLsollBb+d1vSU3GR8Hbsl8pkjEpSPvYVKZQraP4Aantf/Hil6R/DS8LHfGVX
         yAG76RYEXiyeENjUIjLZkY2ru9W/CQbKXF6Q39ipDWPM1ZrW9tTzm27/vj3UTXDllRgd
         x7RA==
X-Gm-Message-State: AOJu0Yy/5rwdcyUhsroZIaYx/DJjry4v/V/zOsFxqm9ydM2urceTI3LN
	GO/SlWIukdigJyMQk+4EZe1PJ67TGsuSfldSJpxK9Y2Ybz1SC9LnDJyuBXTWXTkLe9elMbmXL8H
	pjFrjHLuM+ZEBBNtk
X-Received: by 2002:a2e:bc21:0:b0:2c9:d0d0:6b1d with SMTP id b33-20020a2ebc21000000b002c9d0d06b1dmr6582975ljf.2.1702382298532;
        Tue, 12 Dec 2023 03:58:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv+vVjFiV8lsukH+byaMhqPZ2hbM0PzQUmHbC/h+NiLbLyj8p28bhpWLnMUYxjg8DytyBysA==
X-Received: by 2002:a2e:bc21:0:b0:2c9:d0d0:6b1d with SMTP id b33-20020a2ebc21000000b002c9d0d06b1dmr6582954ljf.2.1702382298154;
        Tue, 12 Dec 2023 03:58:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id h28-20020a056402095c00b0054c21d1fda7sm4658085edz.1.2023.12.12.03.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:58:17 -0800 (PST)
Message-ID: <6772e7d91e5ecfe12922eb6ed9a5b4c8773a5adb.camel@redhat.com>
Subject: Re: [PATCH next] net: update the vlan filter info synchronously
 when modifying the features of netdev
From: Paolo Abeni <pabeni@redhat.com>
To: Liu Jian <liujian56@huawei.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, jiri@resnulli.us,
 vladimir.oltean@nxp.com, andrew@lunn.ch,  d-tatianin@yandex-team.ru,
 justin.chen@broadcom.com, rkannoth@marvell.com,  idosch@nvidia.com,
 jdamato@fastly.com, netdev@vger.kernel.org
Date: Tue, 12 Dec 2023 12:58:16 +0100
In-Reply-To: <20231209092921.1454609-1-liujian56@huawei.com>
References: <20231209092921.1454609-1-liujian56@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-09 at 17:29 +0800, Liu Jian wrote:
> I got the bleow warning trace:

minor nit:  ^^^^^ below
>=20
> WARNING: CPU: 4 PID: 4056 at net/core/dev.c:11066 unregister_netdevice_ma=
ny_notify
> CPU: 4 PID: 4056 Comm: ip Not tainted 6.7.0-rc4+ #15
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2=
014
> RIP: 0010:unregister_netdevice_many_notify+0x9a4/0x9b0
> Call Trace:
>  rtnl_dellink
>  rtnetlink_rcv_msg
>  netlink_rcv_skb
>  netlink_unicast
>  netlink_sendmsg
>  __sock_sendmsg
>  ____sys_sendmsg
>  ___sys_sendmsg
>  __sys_sendmsg
>  do_syscall_64
>  entry_SYSCALL_64_after_hwframe
>=20
> It can be repoduced via:
>=20
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode 0
>     ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
>     ip netns exec ns1 ip link set bond_slave_1 master bond0
> [1] ip netns exec ns1 ethtool -K bond0 rx-vlan-filter off
> [2] ip netns exec ns1 ip link add link bond_slave_1 name bond_slave_1.0 t=
ype vlan id 0
> [3] ip netns exec ns1 ip link add link bond0 name bond0.0 type vlan id 0
> [4] ip netns exec ns1 ip link set bond_slave_1 nomaster
> [5] ip netns exec ns1 ip link del veth2
>     ip netns del ns1
>=20
> This is all caused by command [1] turning off the rx-vlan-filter function
> of bond0. The reason is the same as commit 01f4fd270870 ("bonding: Fix
> incorrect deletion of ETH_P_8021AD protocol vid from slaves"). Commands
> [2] [3] add the same vid to slave and master respectively, causing
> command [4] to empty slave->vlan_info. The following command [5] triggers
> this problem.
>=20
> To fix the problem, we could update the vlan filter information
> synchronously when modifying the features of netdev.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

it looks like the above reproducer triggers only after 01f4fd270870
("bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from
slaves")???

Also, why targeting net-next? this looks like a 'net' patch

> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  net/8021q/vlan_core.c  | 21 ++++++++++++++++++++-
>  net/ethtool/features.c | 19 ++++++++++++++++++-
>  net/ethtool/ioctl.c    | 18 +++++++++++++++++-
>  3 files changed, 55 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index 0beb44f2fe1f..e94b509386bb 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -407,6 +407,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
>  		return 0;
> =20
>  	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +		    vid_info->proto =3D=3D htons(ETH_P_8021Q))
> +			continue;
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
> +		    vid_info->proto =3D=3D htons(ETH_P_8021AD))
> +			continue;
>  		err =3D vlan_vid_add(dev, vid_info->proto, vid_info->vid);
>  		if (err)
>  			goto unwind;
> @@ -417,6 +423,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
>  	list_for_each_entry_continue_reverse(vid_info,
>  					     &vlan_info->vid_list,
>  					     list) {
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +		    vid_info->proto =3D=3D htons(ETH_P_8021Q))
> +			continue;
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
> +		    vid_info->proto =3D=3D htons(ETH_P_8021AD))
> +			continue;
>  		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
>  	}
> =20
> @@ -436,8 +448,15 @@ void vlan_vids_del_by_dev(struct net_device *dev,
>  	if (!vlan_info)
>  		return;
> =20
> -	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
> +	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +		    vid_info->proto =3D=3D htons(ETH_P_8021Q))
> +			continue;
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
> +		    vid_info->proto =3D=3D htons(ETH_P_8021AD))
> +			continue;
>  		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
> +	}
>  }
>  EXPORT_SYMBOL(vlan_vids_del_by_dev);
> =20
> diff --git a/net/ethtool/features.c b/net/ethtool/features.c
> index a79af8c25a07..dee6d17c5b50 100644
> --- a/net/ethtool/features.c
> +++ b/net/ethtool/features.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> =20
> +#include <linux/if_vlan.h>
>  #include "netlink.h"
>  #include "common.h"
>  #include "bitset.h"
> @@ -278,8 +279,24 @@ int ethnl_set_features(struct sk_buff *skb, struct g=
enl_info *info)
>  					  wanted_diff_mask, new_active,
>  					  active_diff_mask, compact);
>  	}
> -	if (mod)
> +	if (mod) {
> +		bitmap_xor(active_diff_mask, old_active, new_active,
> +			   NETDEV_FEATURE_COUNT);
> +		if (test_bit(NETIF_F_HW_VLAN_CTAG_FILTER_BIT, active_diff_mask)) {
> +			if (test_bit(NETIF_F_HW_VLAN_CTAG_FILTER_BIT, new_active))
> +				vlan_get_rx_ctag_filter_info(dev);
> +			else
> +				vlan_drop_rx_ctag_filter_info(dev);
> +		}
> +		if (test_bit(NETIF_F_HW_VLAN_STAG_FILTER_BIT, active_diff_mask)) {
> +			if (test_bit(NETIF_F_HW_VLAN_STAG_FILTER_BIT, new_active))
> +				vlan_get_rx_stag_filter_info(dev);
> +			else
> +				vlan_drop_rx_stag_filter_info(dev);
> +		}

__netdev_update_features() invoked a little bit above does the same
thing, why it's not enough?!?

> +
>  		netdev_features_change(dev);
> +	}
> =20
>  out_rtnl:
>  	rtnl_unlock();
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 0b0ce4f81c01..df7f65ca10b2 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -3055,8 +3055,24 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, =
void __user *useraddr,
>  	if (dev->ethtool_ops->complete)
>  		dev->ethtool_ops->complete(dev);
> =20
> -	if (old_features !=3D dev->features)
> +	if (old_features !=3D dev->features) {
> +		netdev_features_t diff =3D old_features ^ dev->features;
> +
> +		if (diff & NETIF_F_HW_VLAN_CTAG_FILTER) {
> +			if (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +				vlan_get_rx_ctag_filter_info(dev);
> +			else
> +				vlan_drop_rx_ctag_filter_info(dev);
> +		}
> +		if (diff & NETIF_F_HW_VLAN_STAG_FILTER) {
> +			if (dev->features & NETIF_F_HW_VLAN_STAG_FILTER)
> +				vlan_get_rx_stag_filter_info(dev);
> +			else
> +				vlan_drop_rx_stag_filter_info(dev);
> +		}
> +

The same here, via ethtool_set_features()


Cheers,

Paolo


