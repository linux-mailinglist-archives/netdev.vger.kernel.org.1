Return-Path: <netdev+bounces-171348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12085A4C985
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153D41888564
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E95253B75;
	Mon,  3 Mar 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WUIvJ4Hh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3888253B4E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021920; cv=none; b=N/Py2cG+H7aCYwVbhsFdaYPSS+eQFjvA/3OnRA1mw6RtFVwFCaf5SZ1QSnX2Wf/RjFZQktBk3nfiRIn3NtWG3pqO9z8Gv80C9cr6yZUNV/4W9/NuzTrKYcIl9MKzzrhHgaCYKlRPsHrq4CX7qhg1UFNRmULIDMWQ66TSA4Bm5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021920; c=relaxed/simple;
	bh=Le2FilUYAoivg17ksBrA7JuN+V2uxDsE6wrS06Qc4MY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vABVKh6tR7TI6yG0/Z4zxbjrpnbi6i6iBVFceZBOMeBJ2NN4Xqeo/OhPvo9tkABGNiUnt41PJJ99/dpQltQ8RodDAA50Ibb13bTBKFGpfPPFnFiC3h9OBVmqx7rrwezYh5KvYftusRXKnLHqDQKqdzSd8j15zUSqD7Odub6P/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WUIvJ4Hh; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741021919; x=1772557919;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=PeB2N+RN9P0VVtOYAgEPkMdfNHEVSn5URx03BPTkwS0=;
  b=WUIvJ4HhNPTzEAl5LDlGMDNKgYK2mYvorBbxCgtPfcgTFmeVaKrinwVC
   ai964LCHPQu3Ha5aQSbofO1CrQ7WGsrHF/lvvNCrmCA7qWMAXY3MuyQxx
   imx5mEshKRhP6Amuu3rbmJXrIFCIsvng5fn03BMV1UDlfYbYpaeopo/S/
   U=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="471586205"
Subject: RE: [PATCH net-next v9 2/6] net: ena: use napi's aRFS rmap notifers
Thread-Topic: [PATCH net-next v9 2/6] net: ena: use napi's aRFS rmap notifers
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 17:11:55 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:25226]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.85:2525] with esmtp (Farcaster)
 id 36a646d8-0587-4d59-bad6-0468689d3928; Mon, 3 Mar 2025 17:11:54 +0000 (UTC)
X-Farcaster-Flow-ID: 36a646d8-0587-4d59-bad6-0468689d3928
Received: from EX19D028EUB002.ant.amazon.com (10.252.61.43) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 17:11:53 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D028EUB002.ant.amazon.com (10.252.61.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 17:11:53 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Mon, 3 Mar 2025 17:11:53 +0000
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
	<akpm@linux-foundation.org>, "Allen, Neil" <shayagr@amazon.com>
Thread-Index: AQHbhxMLfDMZMH1s/06uqJOU3cFvgbNhrjKw
Date: Mon, 3 Mar 2025 17:11:53 +0000
Message-ID: <c531f3a202e746e39faf27211b80aa69@amazon.com>
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
 <20250224232228.990783-3-ahmed.zaki@intel.com>
In-Reply-To: <20250224232228.990783-3-ahmed.zaki@intel.com>
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

> Use the core's rmap notifiers and delete our own.
>=20
> Acked-by: David Arinzon <darinzon@amazon.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 43 +-------------------
>  1 file changed, 1 insertion(+), 42 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index c1295dfad0d0..6aab85a7c60a 100644
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
> @@ -162,30 +159,6 @@ int ena_xmit_common(struct ena_adapter
> *adapter,
>         return 0;
>  }
>=20
> -static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter) -{ -#ifdef
> CONFIG_RFS_ACCEL
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
> -       return 0;
> -}
> -
>  static void ena_init_io_rings_common(struct ena_adapter *adapter,
>                                      struct ena_ring *ring, u16 qid)  { @=
@ -1596,7 +1569,7 @@
> static int ena_enable_msix(struct ena_adapter *adapter)
>                 adapter->num_io_queues =3D irq_cnt - ENA_ADMIN_MSIX_VEC;
>         }
>=20
> -       if (ena_init_rx_cpu_rmap(adapter))
> +       if (netif_enable_cpu_rmap(adapter->netdev,
> + adapter->num_io_queues))
>                 netif_warn(adapter, probe, adapter->netdev,
>                            "Failed to map IRQs to CPUs\n");
>=20
> @@ -1742,13 +1715,6 @@ static void ena_free_io_irq(struct ena_adapter
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
>                 irq_set_affinity_hint(irq->vector, NULL); @@ -4131,13 +40=
97,6 @@
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
> --
> 2.43.0

Hi Ahmed,

After the merging of this patch, I see the below stack trace when the IRQs =
are freed.
It can be reproduced by unloading and loading the driver using `modprobe -r=
 ena; modprobe ena` (happens during unload)

Based on the patchset and the changes to other drivers, I think there's a m=
issing call to the function
that releases the affinity notifier (The warn is in https://web.git.kernel.=
org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/kernel/irq/manage.c#n=
2031)

I saw in the intel code in the patchset that ` netif_napi_set_irq(<napi>, -=
1);` is added?

After adding the code snippet I don't see this anymore, but I want to under=
stand whether it's the right call by design.

@@ -1716,8 +1716,11 @@ static void ena_free_io_irq(struct ena_adapter *adap=
ter)
        int i;

        for (i =3D ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_coun=
t); i++) {
+               struct ena_napi *ena_napi;
+
                irq =3D &adapter->irq_tbl[i];
                irq_set_affinity_hint(irq->vector, NULL);
+               ena_napi =3D (struct ena_napi *)irq->data;
+               netif_napi_set_irq(&ena_napi->napi, -1);
                free_irq(irq->vector, irq->data);
        }
 }

[  484.544586]  ? __warn+0x84/0x130
[  484.544843]  ? free_irq+0x5c/0x70
[  484.545105]  ? report_bug+0x18a/0x1a0
[  484.545390]  ? handle_bug+0x53/0x90
[  484.545664]  ? exc_invalid_op+0x14/0x70
[  484.545959]  ? asm_exc_invalid_op+0x16/0x20
[  484.546279]  ? free_irq+0x5c/0x70
[  484.546545]  ? free_irq+0x10/0x70
[  484.546807]  ena_free_io_irq+0x5f/0x70 [ena]
[  484.547138]  ena_down+0x250/0x3e0 [ena]
[  484.547435]  ena_destroy_device+0x118/0x150 [ena]
[  484.547796]  __ena_shutoff+0x5a/0xe0 [ena]
[  484.548110]  pci_device_remove+0x3b/0xb0
[  484.548412]  device_release_driver_internal+0x193/0x200
[  484.548804]  driver_detach+0x44/0x90
[  484.549084]  bus_remove_driver+0x69/0xf0
[  484.549386]  pci_unregister_driver+0x2a/0xb0
[  484.549717]  ena_cleanup+0xc/0x130 [ena]
[  484.550021]  __do_sys_delete_module.constprop.0+0x176/0x310
[  484.550438]  ? syscall_trace_enter+0xfb/0x1c0
[  484.550782]  do_syscall_64+0x5b/0x170
[  484.551067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Thanks,
David

