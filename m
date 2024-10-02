Return-Path: <netdev+bounces-131122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A9198CD20
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436961F22A2E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFBF8289E;
	Wed,  2 Oct 2024 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hekt9xv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B72C6A3;
	Wed,  2 Oct 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850446; cv=none; b=T2ne1SBlookXpG7uZj8n42OT3bwDEx35WkB90Eoj9v7O4O/W0RnxZUIhM8lz15M8jtST+gNEUM8+MGyunluS6w8WZBZN+feWFZp9CcW1AqjhMNXptJDz16FoOzXsOQqMWXie9tEgHBC3idGwrlsH42RPrcWQZVJq8aF56x9vmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850446; c=relaxed/simple;
	bh=cdeNZSlaf4wgajM+wtV5oD8xqOm7kYppKWnwnzsrpl4=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRl27LXJqO2nkcxY/yxzEXG0cgwk4HN21k7zQDrMChRfampiggH9Bk33c23qITkGcy6npRWGqb/+2Y4WbeJ98cN+C+N1Q3MfuWOnHo8rryKWuv80hSFhAMjIWZKslxLMD9wZ/ZHr0gyh7k7t1GHixuMVE+Y86q0g8AsRfSEmvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hekt9xv8; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727850446; x=1759386446;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ZjfL4LhqHtNtAkk6mrWHDJeGzAPrJvnjoOFbpLwD/MM=;
  b=hekt9xv8yQL5flwTP2Zv2vTjFxHjthqo7yqrQd2Ui5/XIfQWh1VTLHwn
   MMgeN+4obHD1eW6s0DapIjdMKBuMIr0tMo3k+SI9KKm9ATf3zjWsmJ84w
   hpBElAS6Erd1PT8S2Cz5oSa8vvYW76XVDQbhE7IRZI+WpagOiac+ezgBG
   0=;
X-IronPort-AV: E=Sophos;i="6.11,170,1725321600"; 
   d="scan'208";a="437602994"
Subject: RE: [net-next v2 1/2] ena: Link IRQs to NAPI instances
Thread-Topic: [net-next v2 1/2] ena: Link IRQs to NAPI instances
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 06:27:23 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:22670]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.171:2525] with esmtp (Farcaster)
 id 583c4745-b839-4366-b802-54632c3d9f4e; Wed, 2 Oct 2024 06:27:21 +0000 (UTC)
X-Farcaster-Flow-ID: 583c4745-b839-4366-b802-54632c3d9f4e
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 06:27:21 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 06:27:21 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Wed, 2 Oct 2024 06:27:21 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Agroskin, Shay" <shayagr@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kamal Heib <kheib@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHbFGLnoHgh9RqFZkiXjxqVx29jBbJy/1bQ
Date: Wed, 2 Oct 2024 06:27:21 +0000
Message-ID: <f8d5eb4f7f55418982677c0f247e46ed@amazon.com>
References: <20241002001331.65444-1-jdamato@fastly.com>
 <20241002001331.65444-2-jdamato@fastly.com>
In-Reply-To: <20241002001331.65444-2-jdamato@fastly.com>
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

> Link IRQs to NAPI instances with netif_napi_set_irq. This information can=
 be
> queried with the netdev-genl API. Note that the ENA device appears to
> allocate an IRQ for management purposes which does not have a NAPI
> associated with it; this commit takes this into consideration to accurate=
ly
> construct a map between IRQs and NAPI instances.
>=20
> Compare the output of /proc/interrupts for my ena device with the output
> of netdev-genl after applying this patch:
>=20
> $ cat /proc/interrupts | grep enp55s0 | cut -f1 --delimiter=3D':'
>  94
>  95
>  96
>  97
>  98
>  99
> 100
> 101
>=20
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json=3D'{"ifindex": 2}'
>=20
> [{'id': 8208, 'ifindex': 2, 'irq': 101},
>  {'id': 8207, 'ifindex': 2, 'irq': 100},
>  {'id': 8206, 'ifindex': 2, 'irq': 99},
>  {'id': 8205, 'ifindex': 2, 'irq': 98},
>  {'id': 8204, 'ifindex': 2, 'irq': 97},
>  {'id': 8203, 'ifindex': 2, 'irq': 96},
>  {'id': 8202, 'ifindex': 2, 'irq': 95},
>  {'id': 8201, 'ifindex': 2, 'irq': 94}]
>=20
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Preserve reverse christmas tree order in ena_request_io_irq
>    - No functional changes
>=20
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index c5b50cfa935a..74ce9fa45cf8 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1677,9 +1677,9 @@ static int ena_request_mgmnt_irq(struct
> ena_adapter *adapter)  static int ena_request_io_irq(struct ena_adapter
> *adapter)  {
>         u32 io_queue_count =3D adapter->num_io_queues + adapter-
> >xdp_num_queues;
> +       int rc =3D 0, i, k, irq_idx;
>         unsigned long flags =3D 0;
>         struct ena_irq *irq;
> -       int rc =3D 0, i, k;
>=20
>         if (!test_bit(ENA_FLAG_MSIX_ENABLED, &adapter->flags)) {
>                 netif_err(adapter, ifup, adapter->netdev, @@ -1705,6 +170=
5,16 @@
> static int ena_request_io_irq(struct ena_adapter *adapter)
>                 irq_set_affinity_hint(irq->vector, &irq->affinity_hint_ma=
sk);
>         }
>=20
> +       /* Now that IO IRQs have been successfully allocated map them to =
the
> +        * corresponding IO NAPI instance. Note that the mgmnt IRQ does n=
ot
> +        * have a NAPI, so care must be taken to correctly map IRQs to NA=
PIs.
> +        */
> +       for (i =3D 0; i < io_queue_count; i++) {
> +               irq_idx =3D ENA_IO_IRQ_IDX(i);
> +               irq =3D &adapter->irq_tbl[irq_idx];
> +               netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vecto=
r);
> +       }
> +
>         return rc;
>=20
>  err:
> --
> 2.25.1

LGTM.

Reviewed-by: David Arinzon <darinzon@amazon.com>

