Return-Path: <netdev+bounces-158041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E4A1030F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F160B169726
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC29D1805A;
	Tue, 14 Jan 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aMxoym65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7422DC43
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847207; cv=none; b=X7uGOTEOikYCtaYYpCxpZsVRY9j996Usl1hcihjcXXwCk6t1j6Xj11u7Q6qgOB9uA5+K45MVFgwjpJRcIxHxgC0kkRPWVkIu/nBy+WzQhaIDSuZtfBiqBTypQ/ZmZpVmp8TgD9tH9H/n45H9zDD6tGKazNX8P90upCLTUu/QZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847207; c=relaxed/simple;
	bh=9Sn25rE5CCYqK9yBvqjMmswoTUo3uOzsLNk6iqWb2Is=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRVQdp5oV978OTxY2W+ZJFGZhQ6BIoxdSlI1Vs1BJoujJoBU2nXa4vxgUAewo1VkqtIP/VeoNW6SAnQ/q1HT0iaaQU9TBUl8FGImTXgljNwEnX2EQWZRvjYBaVkJIyXv94JBk3CufEq+hbP8g7S2rXybFz+nWqnLLXbBlOUpgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aMxoym65; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736847206; x=1768383206;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ubdHmjlTMA7gemU7T+linQAGAiPIIh5DiYAzNhXM3sg=;
  b=aMxoym65bP+LZGzegyYeydgNFaxyGB29lcA+esfZcbASDonxDUee/2on
   PrBReiJuKA57bK23zCavuJyYNfnV+vfzsG645cZezzDUL71v8xAC4/Atc
   wFeon0n0D9Yu78JIPOX75Scvb8Ql0dV9Fy4ubhqfdgmvOgoZ6UHzaiP7s
   c=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="368932483"
Subject: RE: [PATCH net-next v5 1/6] net: move ARFS rmap management to core
Thread-Topic: [PATCH net-next v5 1/6] net: move ARFS rmap management to core
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:33:23 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:50811]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.13.19:2525] with esmtp (Farcaster)
 id 73adbed7-fda2-45cb-9ba1-1951185386f9; Tue, 14 Jan 2025 09:33:22 +0000 (UTC)
X-Farcaster-Flow-ID: 73adbed7-fda2-45cb-9ba1-1951185386f9
Received: from EX19D028EUC003.ant.amazon.com (10.252.61.136) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 09:33:22 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D028EUC003.ant.amazon.com (10.252.61.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 09:33:21 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.039; Tue, 14 Jan 2025 09:33:21 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "jdamato@fastly.com" <jdamato@fastly.com>,
	"shayd@nvidia.com" <shayd@nvidia.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Agroskin, Shay" <shayagr@amazon.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>
Thread-Index: AQHbZd4/z0c/TL/GXUmOE9xtvJmvD7MWApuw
Date: Tue, 14 Jan 2025 09:33:21 +0000
Message-ID: <4517d3801ecb465785f7c883554c9d7f@amazon.com>
References: <20250113171042.158123-1-ahmed.zaki@intel.com>
 <20250113171042.158123-2-ahmed.zaki@intel.com>
In-Reply-To: <20250113171042.158123-2-ahmed.zaki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Add a new netdev flag "rx_cpu_rmap_auto". Drivers supporting ARFS should
> set the flag via netif_enable_cpu_rmap() and core will allocate and manag=
e
> the ARFS rmap. Freeing the rmap is also done by core when the netdev is
> freed.
>=20
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 38 ++---------------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c    | 27 ++----------
>  drivers/net/ethernet/intel/ice/ice_arfs.c    | 17 +-------
>  include/linux/netdevice.h                    | 15 +++++--
>  net/core/dev.c                               | 44 ++++++++++++++++++++
>  5 files changed, 63 insertions(+), 78 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index c1295dfad0d0..a3fceaa83cd5 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -5,9 +5,6 @@
>=20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> -#ifdef CONFIG_RFS_ACCEL
> -#include <linux/cpu_rmap.h>
> -#endif /* CONFIG_RFS_ACCEL */
>  #include <linux/ethtool.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -165,25 +162,10 @@ int ena_xmit_common(struct ena_adapter
> *adapter,  static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)  =
{
> #ifdef CONFIG_RFS_ACCEL
> -       u32 i;
> -       int rc;
> -
> -       adapter->netdev->rx_cpu_rmap =3D alloc_irq_cpu_rmap(adapter-
> >num_io_queues);
> -       if (!adapter->netdev->rx_cpu_rmap)
> -               return -ENOMEM;
> -       for (i =3D 0; i < adapter->num_io_queues; i++) {
> -               int irq_idx =3D ENA_IO_IRQ_IDX(i);
> -
> -               rc =3D irq_cpu_rmap_add(adapter->netdev->rx_cpu_rmap,
> -                                     pci_irq_vector(adapter->pdev, irq_i=
dx));
> -               if (rc) {
> -                       free_irq_cpu_rmap(adapter->netdev->rx_cpu_rmap);
> -                       adapter->netdev->rx_cpu_rmap =3D NULL;
> -                       return rc;
> -               }
> -       }
> -#endif /* CONFIG_RFS_ACCEL */
> +       return netif_enable_cpu_rmap(adapter->netdev,
> +adapter->num_io_queues); #else
>         return 0;
> +#endif /* CONFIG_RFS_ACCEL */
>  }
>=20
>  static void ena_init_io_rings_common(struct ena_adapter *adapter, @@ -
> 1742,13 +1724,6 @@ static void ena_free_io_irq(struct ena_adapter
> *adapter)
>         struct ena_irq *irq;
>         int i;
>=20
> -#ifdef CONFIG_RFS_ACCEL
> -       if (adapter->msix_vecs >=3D 1) {
> -               free_irq_cpu_rmap(adapter->netdev->rx_cpu_rmap);
> -               adapter->netdev->rx_cpu_rmap =3D NULL;
> -       }
> -#endif /* CONFIG_RFS_ACCEL */
> -
>         for (i =3D ENA_IO_IRQ_FIRST_IDX; i <
> ENA_MAX_MSIX_VEC(io_queue_count); i++) {
>                 irq =3D &adapter->irq_tbl[i];
>                 irq_set_affinity_hint(irq->vector, NULL); @@ -4131,13 +41=
06,6 @@
> static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
>         ena_dev =3D adapter->ena_dev;
>         netdev =3D adapter->netdev;
>=20
> -#ifdef CONFIG_RFS_ACCEL
> -       if ((adapter->msix_vecs >=3D 1) && (netdev->rx_cpu_rmap)) {
> -               free_irq_cpu_rmap(netdev->rx_cpu_rmap);
> -               netdev->rx_cpu_rmap =3D NULL;
> -       }
> -
> -#endif /* CONFIG_RFS_ACCEL */
>         /* Make sure timer and reset routine won't be called after
>          * freeing device resources.
>          */
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 884d42db5554..1f50bc715038 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -49,7 +49,6 @@
>  #include <linux/cache.h>
>  #include <linux/log2.h>
>  #include <linux/bitmap.h>
> -#include <linux/cpu_rmap.h>
>  #include <linux/cpumask.h>
>  #include <net/pkt_cls.h>
>  #include <net/page_pool/helpers.h>
> @@ -10861,7 +10860,7 @@ static int bnxt_set_real_num_queues(struct bnxt
> *bp)
>=20
>  #ifdef CONFIG_RFS_ACCEL
>         if (bp->flags & BNXT_FLAG_RFS)
> -               dev->rx_cpu_rmap =3D alloc_irq_cpu_rmap(bp->rx_nr_rings);
> +               return netif_enable_cpu_rmap(dev, bp->rx_nr_rings);
>  #endif
>=20
>         return rc;
> @@ -11215,10 +11214,6 @@ static void bnxt_free_irq(struct bnxt *bp)
>         struct bnxt_irq *irq;
>         int i;
>=20
> -#ifdef CONFIG_RFS_ACCEL
> -       free_irq_cpu_rmap(bp->dev->rx_cpu_rmap);
> -       bp->dev->rx_cpu_rmap =3D NULL;
> -#endif
>         if (!bp->irq_tbl || !bp->bnapi)
>                 return;
>=20
> @@ -11241,11 +11236,8 @@ static void bnxt_free_irq(struct bnxt *bp)
>=20
>  static int bnxt_request_irq(struct bnxt *bp)  {
> -       int i, j, rc =3D 0;
> +       int i, rc =3D 0;
>         unsigned long flags =3D 0;
> -#ifdef CONFIG_RFS_ACCEL
> -       struct cpu_rmap *rmap;
> -#endif
>=20
>         rc =3D bnxt_setup_int_mode(bp);
>         if (rc) {
> @@ -11253,22 +11245,11 @@ static int bnxt_request_irq(struct bnxt *bp)
>                            rc);
>                 return rc;
>         }
> -#ifdef CONFIG_RFS_ACCEL
> -       rmap =3D bp->dev->rx_cpu_rmap;
> -#endif
> -       for (i =3D 0, j =3D 0; i < bp->cp_nr_rings; i++) {
> +
> +       for (i =3D 0; i < bp->cp_nr_rings; i++) {
>                 int map_idx =3D bnxt_cp_num_to_irq_num(bp, i);
>                 struct bnxt_irq *irq =3D &bp->irq_tbl[map_idx];
>=20
> -#ifdef CONFIG_RFS_ACCEL
> -               if (rmap && bp->bnapi[i]->rx_ring) {
> -                       rc =3D irq_cpu_rmap_add(rmap, irq->vector);
> -                       if (rc)
> -                               netdev_warn(bp->dev, "failed adding irq r=
map for ring
> %d\n",
> -                                           j);
> -                       j++;
> -               }
> -#endif
>                 rc =3D request_irq(irq->vector, irq->handler, flags, irq-=
>name,
>                                  bp->bnapi[i]);
>                 if (rc)
> diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c
> b/drivers/net/ethernet/intel/ice/ice_arfs.c
> index 7cee365cc7d1..3b1b892e6958 100644
> --- a/drivers/net/ethernet/intel/ice/ice_arfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
> @@ -584,9 +584,6 @@ void ice_free_cpu_rx_rmap(struct ice_vsi *vsi)
>         netdev =3D vsi->netdev;
>         if (!netdev || !netdev->rx_cpu_rmap)
>                 return;
> -
> -       free_irq_cpu_rmap(netdev->rx_cpu_rmap);
> -       netdev->rx_cpu_rmap =3D NULL;
>  }
>=20
>  /**
> @@ -597,7 +594,6 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)  {
>         struct net_device *netdev;
>         struct ice_pf *pf;
> -       int i;
>=20
>         if (!vsi || vsi->type !=3D ICE_VSI_PF)
>                 return 0;
> @@ -610,18 +606,7 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
>         netdev_dbg(netdev, "Setup CPU RMAP: vsi type 0x%x, ifname %s,
> q_vectors %d\n",
>                    vsi->type, netdev->name, vsi->num_q_vectors);
>=20
> -       netdev->rx_cpu_rmap =3D alloc_irq_cpu_rmap(vsi->num_q_vectors);
> -       if (unlikely(!netdev->rx_cpu_rmap))
> -               return -EINVAL;
> -
> -       ice_for_each_q_vector(vsi, i)
> -               if (irq_cpu_rmap_add(netdev->rx_cpu_rmap,
> -                                    vsi->q_vectors[i]->irq.virq)) {
> -                       ice_free_cpu_rx_rmap(vsi);
> -                       return -EINVAL;
> -               }
> -
> -       return 0;
> +       return netif_enable_cpu_rmap(netdev, vsi->num_q_vectors);
>  }
>=20
>  /**
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h index
> aeb4a6cff171..7e95e9ee36dd 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1991,6 +1991,9 @@ enum netdev_reg_state {
>   *
>   *     @threaded:      napi threaded mode is enabled
>   *
> + *     @rx_cpu_rmap_auto: driver wants the core to manage the ARFS rmap.
> + *                        Set by calling netif_enable_cpu_rmap().
> + *
>   *     @see_all_hwtstamp_requests: device wants to see calls to
>   *                     ndo_hwtstamp_set() for all timestamp requests
>   *                     regardless of source, even if those aren't
> @@ -2398,6 +2401,9 @@ struct net_device {
>         struct lock_class_key   *qdisc_tx_busylock;
>         bool                    proto_down;
>         bool                    threaded;
> +#ifdef CONFIG_RFS_ACCEL
> +       bool                    rx_cpu_rmap_auto;
> +#endif
>=20
>         /* priv_flags_slow, ungrouped to save space */
>         unsigned long           see_all_hwtstamp_requests:1;
> @@ -2671,10 +2677,7 @@ void netif_queue_set_napi(struct net_device
> *dev, unsigned int queue_index,
>                           enum netdev_queue_type type,
>                           struct napi_struct *napi);
>=20
> -static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)=
 -{
> -       napi->irq =3D irq;
> -}
> +void netif_napi_set_irq(struct napi_struct *napi, int irq);
>=20
>  /* Default NAPI poll() weight
>   * Device drivers are strongly advised to not use bigger value @@ -2765,=
6
> +2768,10 @@ static inline void netif_napi_del(struct napi_struct *napi)
>         synchronize_net();
>  }
>=20
> +#ifdef CONFIG_RFS_ACCEL
> +int netif_enable_cpu_rmap(struct net_device *dev, unsigned int
> +num_irqs);
> +
> +#endif
>  struct packet_type {
>         __be16                  type;   /* This is really htons(ether_typ=
e). */
>         bool                    ignore_outgoing;
> diff --git a/net/core/dev.c b/net/core/dev.c index
> 1a90ed8cc6cc..3ee7a514dca8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6745,6 +6745,46 @@ void netif_queue_set_napi(struct net_device
> *dev, unsigned int queue_index,  }
> EXPORT_SYMBOL(netif_queue_set_napi);
>=20
> +#ifdef CONFIG_RFS_ACCEL
> +static void netif_disable_cpu_rmap(struct net_device *dev) {
> +       free_irq_cpu_rmap(dev->rx_cpu_rmap);
> +       dev->rx_cpu_rmap =3D NULL;
> +       dev->rx_cpu_rmap_auto =3D false;
> +}
> +
> +int netif_enable_cpu_rmap(struct net_device *dev, unsigned int
> +num_irqs) {
> +       dev->rx_cpu_rmap =3D alloc_irq_cpu_rmap(num_irqs);
> +       if (!dev->rx_cpu_rmap)
> +               return -ENOMEM;
> +
> +       dev->rx_cpu_rmap_auto =3D true;
> +       return 0;
> +}
> +EXPORT_SYMBOL(netif_enable_cpu_rmap);
> +#endif
> +
> +void netif_napi_set_irq(struct napi_struct *napi, int irq) { #ifdef
> +CONFIG_RFS_ACCEL
> +       int rc;
> +#endif
> +       napi->irq =3D irq;
> +
> +#ifdef CONFIG_RFS_ACCEL
> +       if (napi->dev->rx_cpu_rmap && napi->dev->rx_cpu_rmap_auto) {
> +               rc =3D irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
> +               if (rc) {
> +                       netdev_warn(napi->dev, "Unable to update ARFS map=
 (%d)\n",
> +                                   rc);
> +                       netif_disable_cpu_rmap(napi->dev);
> +               }
> +       }
> +#endif
> +}
> +EXPORT_SYMBOL(netif_napi_set_irq);
> +
>  static void napi_restore_config(struct napi_struct *n)  {
>         n->defer_hard_irqs =3D n->config->defer_hard_irqs; @@ -11421,6
> +11461,10 @@ void free_netdev(struct net_device *dev)
>         /* Flush device addresses */
>         dev_addr_flush(dev);
>=20
> +#ifdef CONFIG_RFS_ACCEL
> +       if (dev->rx_cpu_rmap && dev->rx_cpu_rmap_auto)
> +               netif_disable_cpu_rmap(dev); #endif
>         list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
>                 netif_napi_del(p);
>=20
> --
> 2.43.0

Thanks for making the change in the ENA driver.

Acked-by: David Arinzon <darinzon@amazon.com>

