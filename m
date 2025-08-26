Return-Path: <netdev+bounces-216792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5AB352F0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2678B174967
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599442BDC25;
	Tue, 26 Aug 2025 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT3/luQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409611CA9
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184484; cv=none; b=dz1um/bRuavlX9JIANJ7M9fmT2MS9CU7yPJgg6IDxjEWkEZ/gf7srOTyWQAGTPNIqvd3Lg1wJ67zvul072hl5pUeCHtU8UL3WnRz2k92Xv7xg/PbXHf235l0guRxJpbbMOqEQN/yRG9Pd6Jx4Zx8IntEpyaVoRP4/LqeHERjmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184484; c=relaxed/simple;
	bh=xjfE+rL+qzLmD2Uf9b4PJpvFk6FmVm1l87vyc8CT3ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbAWGZVGU+X5sbLtYOLFj7mk3glwyZydqUbytdZWrpMMzRl79OkcaPYqae9aASm7grekv+41DdpaQpRTBX9isNHSDHI/LhMJFRQf0GliYcIWzNxk0zqqF416DjXpLzyC+5p0WsFCn1bKVn+BOCJs9qJHtR4UlchrmugKiSuGAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TT3/luQz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445827be70so51043605ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756184477; x=1756789277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4BS6aS24xiyEBOhoAcftVNumFyCCPAmASf6IZ+5xlU=;
        b=TT3/luQz5mfhBsECf9xsXZClbXCKjUgzPcsFzUhqGeTS++bNkh2bH/Wa4Ga+5x9t0t
         ZP8X2DadsktQyFZLoxKDVRUij8GXVlWKz9AedsBSMMaqjh+oSUxOIV/s1VeBRIZNXyVT
         sXCouYV2Q2YxOv+s9FrmC02EkvFywp9LUfUE2NeIUBqqftE1zumPzipBPoFrcN4ZiEWD
         3T/xcABaqU1QmLOvBJb78y6QQVC26HR6pd4fJMB2VytZDubgqIFukWopDqVR2cOJPDm0
         mBmtTflUKALwsv47vLB9LzWU/gjhN+WJAdwxjGH0bjqNKQmCyw4sEW6cuCPBP3Vx/nuZ
         JUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756184477; x=1756789277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4BS6aS24xiyEBOhoAcftVNumFyCCPAmASf6IZ+5xlU=;
        b=YjdbkxwAeTSRMwU7nuDQyF8e+HFalhYNXNnAuzBlAqdmFkz8syBDAYLtaQ/4kceL0Y
         Pu9Dd8lD3v0G87FmT6Q/4rki9zWWUiPVWOWqkQ8P3mgfEH1QcSTUlaSNbq9jlZRy9qg3
         NrVPxt+WfVqvPqJCTvgFEg0tglpanwEJy3IR/3kpuLj1fl75akVj66YFTt5PqLzpXzL3
         IG9FdQabrOXVBNKMY1ntV8R7a8v+DFqZ5A0Y64JdPZtonjnz2sC42XhfL5E1QjVGG0XI
         xDi96p1+WP0H1ZUWSCJN555OVtSGaVXMyge4kkzDj19u5fg3Zx3V1z1XcUaAOH7zAvAf
         Aj2g==
X-Gm-Message-State: AOJu0YxbYcJfKTxNdxr3QlRHQSyU52BVorPMqNgOzBofp4mD2iUz6uxC
	w2ey7FQiv2KAHwVfJXI0HVfl8ndrNt9Y5AswR6iBxJwZzCKCaP8VOtow6tDxdeiO3HxJaxypVY8
	lx2vibsmVoVgl0oGqKgP/bIcd1fEoVjv/iF3VDxh7
X-Gm-Gg: ASbGncvVxBzq2c5DUhKzrfPfv4ZqILaWpyzOYh2HzQ/fN9o7yrg90bcPovc74u7UZ3s
	FsEz6QwxOdZ/S/cHfAWxXEpX27VRf5wBQqo/oQlbuUrEQ+lOaTa/OHaB//Ey1xMNCkon9W2boeK
	VOvDnHQqH85k2nuw97ZJDQQQJ5G+bVsYYba16n4lqgHDJeGUcek5J4pktTEeXjV26iSecgvaHiY
	ymZQCMYLRKGURgwps13V37j39YLVBRLWU6BHs/3eUbKXf4gAhb0o9nFL2Z0sX4GrXFhiEZ9b9pl
	7mc84OKxydKmDA==
X-Google-Smtp-Source: AGHT+IGxI2s6Pnc+rRv7cOZQCqPr1sXBICII5GOx3YSl66LidoUdR2spYtL1V91ORH8rZX+g67vYFG/bKIARZcrEkoM=
X-Received: by 2002:a17:902:ecc6:b0:244:5cde:d384 with SMTP id
 d9443c01a7336-2462eeb4090mr206880885ad.31.1756184476419; Mon, 25 Aug 2025
 22:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041148.426598-1-liuhangbin@gmail.com>
In-Reply-To: <20250826041148.426598-1-liuhangbin@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 22:01:05 -0700
X-Gm-Features: Ac12FXydGrV72S_gRl1fkJWTXXr4z5vmBTMnsn1AGLlgLu8SKrBd15hD5lnBJ7w
Message-ID: <CAAVpQUCiDeVxitKR6EUMv+2CmOkQiFU6RHPZ-rOQVyzbGe2LQw@mail.gmail.com>
Subject: Re: [PATCH net] hsr: add rcu lock for all hsr_for_each_port caller
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jaakko Karrenpalo <jkarrenpalo@gmail.com>, 
	Fernando Fernandez Mancera <ffmancera@riseup.net>, Murali Karicheri <m-karicheri2@ti.com>, 
	WingMan Kwok <w-kwok2@ti.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Johannes Berg <johannes.berg@intel.com>, Yu Liao <liaoyu15@huawei.com>, 
	Arvid Brodin <arvid.brodin@alten.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 9:12=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> hsr_for_each_port is called in many places without holding the RCU read
> lock, this may trigger warnings on debug kernels like:
>
>   [   40.457015] [  T201] WARNING: suspicious RCU usage
>   [   40.457020] [  T201] 6.17.0-rc2-virtme #1 Not tainted
>   [   40.457025] [  T201] -----------------------------
>   [   40.457029] [  T201] net/hsr/hsr_main.c:137 RCU-list traversed in no=
n-reader section!!
>   [   40.457036] [  T201]
>                           other info that might help us debug this:
>
>   [   40.457040] [  T201]
>                           rcu_scheduler_active =3D 2, debug_locks =3D 1
>   [   40.457045] [  T201] 2 locks held by ip/201:
>   [   40.457050] [  T201]  #0: ffffffff93040a40 (&ops->srcu){.+.+}-{0:0},=
 at: rtnl_link_ops_get+0xf2/0x280
>   [   40.457080] [  T201]  #1: ffffffff92e7f968 (rtnl_mutex){+.+.}-{4:4},=
 at: rtnl_newlink+0x5e1/0xb20
>   [   40.457102] [  T201]
>                           stack backtrace:
>   [   40.457108] [  T201] CPU: 2 UID: 0 PID: 201 Comm: ip Not tainted 6.1=
7.0-rc2-virtme #1 PREEMPT(full)
>   [   40.457114] [  T201] Hardware name: Bochs Bochs, BIOS Bochs 01/01/20=
11
>   [   40.457117] [  T201] Call Trace:
>   [   40.457120] [  T201]  <TASK>
>   [   40.457126] [  T201]  dump_stack_lvl+0x6f/0xb0
>   [   40.457136] [  T201]  lockdep_rcu_suspicious.cold+0x4f/0xb1
>   [   40.457148] [  T201]  hsr_port_get_hsr+0xfe/0x140
>   [   40.457158] [  T201]  hsr_add_port+0x192/0x940
>   [   40.457167] [  T201]  ? __pfx_hsr_add_port+0x10/0x10
>   [   40.457176] [  T201]  ? lockdep_init_map_type+0x5c/0x270
>   [   40.457189] [  T201]  hsr_dev_finalize+0x4bc/0xbf0
>   [   40.457204] [  T201]  hsr_newlink+0x3c3/0x8f0
>   [   40.457212] [  T201]  ? __pfx_hsr_newlink+0x10/0x10
>   [   40.457222] [  T201]  ? rtnl_create_link+0x173/0xe40
>   [   40.457233] [  T201]  rtnl_newlink_create+0x2cf/0x750
>   [   40.457243] [  T201]  ? __pfx_rtnl_newlink_create+0x10/0x10
>   [   40.457247] [  T201]  ? __dev_get_by_name+0x12/0x50
>   [   40.457252] [  T201]  ? rtnl_dev_get+0xac/0x140
>   [   40.457259] [  T201]  ? __pfx_rtnl_dev_get+0x10/0x10
>   [   40.457285] [  T201]  __rtnl_newlink+0x22c/0xa50
>   [   40.457305] [  T201]  rtnl_newlink+0x637/0xb20
>
> Fix it by wrapping the call with rcu_read_lock()/rcu_read_unlock().
>
> Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array f=
or slave devices.")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/hsr/hsr_device.c  | 37 ++++++++++++++++++++++++++++++++-----
>  net/hsr/hsr_main.c    | 12 ++++++++++--
>  net/hsr/hsr_netlink.c |  4 ----
>  3 files changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 88657255fec1..67955b21b4a4 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -49,12 +49,15 @@ static bool hsr_check_carrier(struct hsr_port *master=
)
>
>         ASSERT_RTNL();
>
> +       rcu_read_lock();
>         hsr_for_each_port(master->hsr, port) {

Why not use the 4th arg of list_for_each_entry_rcu() ?

Adding random rcu_read_lock() looks confusing.


>                 if (port->type !=3D HSR_PT_MASTER && is_slave_up(port->de=
v)) {
> +                       rcu_read_unlock();
>                         netif_carrier_on(master->dev);
>                         return true;
>                 }
>         }
> +       rcu_read_unlock();
>
>         netif_carrier_off(master->dev);
>
> @@ -105,9 +108,12 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
>         struct hsr_port *port;
>
>         mtu_max =3D ETH_DATA_LEN;
> +
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port)
>                 if (port->type !=3D HSR_PT_MASTER)
>                         mtu_max =3D min(port->dev->mtu, mtu_max);
> +       rcu_read_unlock();
>
>         if (mtu_max < HSR_HLEN)
>                 return 0;
> @@ -139,6 +145,7 @@ static int hsr_dev_open(struct net_device *dev)
>
>         hsr =3D netdev_priv(dev);
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port) {
>                 if (port->type =3D=3D HSR_PT_MASTER)
>                         continue;
> @@ -159,6 +166,7 @@ static int hsr_dev_open(struct net_device *dev)
>                         netdev_warn(dev, "%s (%s) is not up; please bring=
 it up to get a fully working HSR network\n",
>                                     designation, port->dev->name);
>         }
> +       rcu_read_unlock();
>
>         if (!designation)
>                 netdev_warn(dev, "No slave devices configured\n");
> @@ -172,6 +180,8 @@ static int hsr_dev_close(struct net_device *dev)
>         struct hsr_priv *hsr;
>
>         hsr =3D netdev_priv(dev);
> +
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port) {
>                 if (port->type =3D=3D HSR_PT_MASTER)
>                         continue;
> @@ -185,6 +195,7 @@ static int hsr_dev_close(struct net_device *dev)
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>
>         return 0;
>  }
> @@ -205,10 +216,13 @@ static netdev_features_t hsr_features_recompute(str=
uct hsr_priv *hsr,
>          * may become enabled.
>          */
>         features &=3D ~NETIF_F_ONE_FOR_ALL;
> +
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port)
>                 features =3D netdev_increment_features(features,
>                                                      port->dev->features,
>                                                      mask);
> +       rcu_read_unlock();
>
>         return features;
>  }
> @@ -410,14 +424,11 @@ static void hsr_announce(struct timer_list *t)
>
>         hsr =3D timer_container_of(hsr, t, announce_timer);
>
> -       rcu_read_lock();
>         master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>         hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev=
_addr);

hsr_announce() is a timer func, and what protects master after
rcu_read_unlock() in hsr_port_get_hsr() ?


>
>         if (is_admin_up(master->dev))
>                 mod_timer(&hsr->announce_timer, jiffies + interval);
> -
> -       rcu_read_unlock();
>  }
>
>  /* Announce (supervision frame) timer function for RedBox
> @@ -430,7 +441,6 @@ static void hsr_proxy_announce(struct timer_list *t)
>         unsigned long interval =3D 0;
>         struct hsr_node *node;
>
> -       rcu_read_lock();
>         /* RedBOX sends supervisory frames to HSR network with MAC addres=
ses
>          * of SAN nodes stored in ProxyNodeTable.
>          */
> @@ -438,6 +448,7 @@ static void hsr_proxy_announce(struct timer_list *t)
>         if (!interlink)
>                 goto done;
>
> +       rcu_read_lock();
>         list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
>                 if (hsr_addr_is_redbox(hsr, node->macaddress_A))
>                         continue;
> @@ -484,6 +495,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
>
>         hsr =3D netdev_priv(dev);
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port) {
>                 if (port->type =3D=3D HSR_PT_MASTER)
>                         continue;
> @@ -497,6 +509,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>  }
>
>  static void hsr_change_rx_flags(struct net_device *dev, int change)
> @@ -506,6 +519,7 @@ static void hsr_change_rx_flags(struct net_device *de=
v, int change)
>
>         hsr =3D netdev_priv(dev);
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port) {
>                 if (port->type =3D=3D HSR_PT_MASTER)
>                         continue;
> @@ -521,6 +535,7 @@ static void hsr_change_rx_flags(struct net_device *de=
v, int change)
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>  }
>
>  static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
> @@ -534,6 +549,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device =
*dev,
>
>         hsr =3D netdev_priv(dev);
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port) {
>                 if (port->type =3D=3D HSR_PT_MASTER ||
>                     port->type =3D=3D HSR_PT_INTERLINK)
> @@ -547,6 +563,8 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device =
*dev,
>                                 netdev_err(dev, "add vid failed for Slave=
-A\n");
>                                 if (is_slave_b_added)
>                                         vlan_vid_del(port->dev, proto, vi=
d);
> +
> +                               rcu_read_unlock();
>                                 return ret;
>                         }
>
> @@ -559,6 +577,8 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device =
*dev,
>                                 netdev_err(dev, "add vid failed for Slave=
-B\n");
>                                 if (is_slave_a_added)
>                                         vlan_vid_del(port->dev, proto, vi=
d);
> +
> +                               rcu_read_unlock();
>                                 return ret;
>                         }
>
> @@ -568,6 +588,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device =
*dev,
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>
>         return 0;
>  }
> @@ -580,6 +601,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device=
 *dev,
>
>         hsr =3D netdev_priv(dev);
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port) {
>                 switch (port->type) {
>                 case HSR_PT_SLAVE_A:
> @@ -590,6 +612,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device=
 *dev,
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>
>         return 0;
>  }
> @@ -672,9 +695,13 @@ struct net_device *hsr_get_port_ndev(struct net_devi=
ce *ndev,
>         struct hsr_priv *hsr =3D netdev_priv(ndev);
>         struct hsr_port *port;
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port)
> -               if (port->type =3D=3D pt)
> +               if (port->type =3D=3D pt) {
> +                       rcu_read_unlock();
>                         return port->dev;
> +               }
> +       rcu_read_unlock();
>         return NULL;
>  }
>  EXPORT_SYMBOL(hsr_get_port_ndev);
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index 192893c3f2ec..eec6e20a8494 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -22,9 +22,13 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
>  {
>         struct hsr_port *port;
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port)
> -               if (port->type !=3D HSR_PT_MASTER)
> +               if (port->type !=3D HSR_PT_MASTER) {
> +                       rcu_read_unlock();
>                         return false;
> +               }
> +       rcu_read_unlock();
>         return true;
>  }
>
> @@ -134,9 +138,13 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *h=
sr, enum hsr_port_type pt)
>  {
>         struct hsr_port *port;
>
> +       rcu_read_lock();
>         hsr_for_each_port(hsr, port)
> -               if (port->type =3D=3D pt)
> +               if (port->type =3D=3D pt) {
> +                       rcu_read_unlock();
>                         return port;
> +               }
> +       rcu_read_unlock();
>         return NULL;
>  }
>
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index b120470246cc..f57c289e2322 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -241,10 +241,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned=
 char addr[ETH_ALEN],
>         kfree_skb(skb);
>
>  fail:
> -       rcu_read_lock();
>         master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>         netdev_warn(master->dev, "Could not send HSR ring error message\n=
");
> -       rcu_read_unlock();
>  }
>
>  /* This is called when we haven't heard from the node with MAC address a=
ddr for
> @@ -278,10 +276,8 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned =
char addr[ETH_ALEN])
>         kfree_skb(skb);
>
>  fail:
> -       rcu_read_lock();
>         master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>         netdev_warn(master->dev, "Could not send HSR node down\n");
> -       rcu_read_unlock();
>  }
>
>  /* HSR_C_GET_NODE_STATUS lets userspace query the internal HSR node tabl=
e
> --
> 2.50.1
>

