Return-Path: <netdev+bounces-130773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D005298B7BB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7909AB219F8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F319C565;
	Tue,  1 Oct 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UG58hpTL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977119B3F3;
	Tue,  1 Oct 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773083; cv=none; b=t4eCjOlNpK+/lUiL0Ut82ypuKAJ1DioIqargbQG/aZXzKpvqdbJYKyAalfEuu5ATRhxC1wk6zUx/L4uvz+CPWG43SueL7tnE9zXpmtAEJxAhMJOcG9tL7DeiInoB/Py2+hIy3GSvC166GTctFN/m2FqG9hhArZzvNO3Jbxtymvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773083; c=relaxed/simple;
	bh=unBcR8O9xCwZQfhMzZceVaKTlMUknqa9scrjWPuplPM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loY+sOafbRZg5kw0aMO7vb0jZ9bo4yZhEU727U0sAfsRQD95SOo7TNNn93WPV27fXuuY0qSF6bH7mYM+CZdQAB/67ckpnLPN+RU29QPOwZUQPW8fU0fwEybq+uzyJdAzCmohZq7xu8Cca6wOI0DlgutFh11BP/lkZPq2I7IWWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UG58hpTL; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727773082; x=1759309082;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=xH0q8Rr63u+qTvlzMGQE3d4NYXzn6tDLmhZWQo21cbk=;
  b=UG58hpTLgGlOGHQsJ9MLgP13PkBzxTicEAQbU0At0jjYTQIF7K/futHo
   o56aYAlA8fT+uEJVmkTtkhNeumy6oOjyYxFxxPnaNefwjegXDYsiMGpnZ
   mLAI5KIXnFfUwEkQFpc8uzE6BAmYZVTS5EjO3057HaaGP0hFn64kh1nKE
   g=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="133392118"
Subject: RE: [net-next 1/2] ena: Link IRQs to NAPI instances
Thread-Topic: [net-next 1/2] ena: Link IRQs to NAPI instances
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:57:49 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:40315]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.19:2525] with esmtp (Farcaster)
 id 0fb67708-3ad0-42e8-b49d-4556f71ec475; Tue, 1 Oct 2024 08:57:47 +0000 (UTC)
X-Farcaster-Flow-ID: 0fb67708-3ad0-42e8-b49d-4556f71ec475
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 08:57:47 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 08:57:47 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 1 Oct 2024 08:57:47 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Agroskin, Shay" <shayagr@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kamal Heib <kheib@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHbE3LywnpGjwDtR0msBN7ZVNhtiLJxk0IQ
Date: Tue, 1 Oct 2024 08:57:47 +0000
Message-ID: <a6a2c78faa8740fab0ca53295bbc57d2@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-2-jdamato@fastly.com>
In-Reply-To: <20240930195617.37369-2-jdamato@fastly.com>
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
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index c5b50cfa935a..e88de5e426ef 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1679,7 +1679,7 @@ static int ena_request_io_irq(struct ena_adapter
> *adapter)
>         u32 io_queue_count =3D adapter->num_io_queues + adapter-
> >xdp_num_queues;
>         unsigned long flags =3D 0;
>         struct ena_irq *irq;
> -       int rc =3D 0, i, k;
> +       int rc =3D 0, i, k, irq_idx;

nit: This breaks RCT guidelines, can you please move it to be below io_queu=
e_count?

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
> 2.43.0

Thank you for uploading this patch.


