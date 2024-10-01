Return-Path: <netdev+bounces-130937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C513F98C209
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC9F285511
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C21C9ED6;
	Tue,  1 Oct 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jiSI3g6Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5D1C8FCE;
	Tue,  1 Oct 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797891; cv=none; b=LgwgqIJEOr/+ye3va6i/qNJw0R/yGpv96l4g8Q/rlzxvZ4GEi/3lM5uvRnPQhV5JnVl60nWekhVtfihrrrCarMSSG3V/5w2mnla3TwLFOaCIaNgdxz6NJaw5wGU5oAUGSOdNN/Ht3CkYdGlhjRc95TByiHPzz+rsnLLxyhb8AlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797891; c=relaxed/simple;
	bh=ly6KJzZt+dDWtNumDIkheZpJjvtCauXr6XMlbKzH5R8=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMK07UAtUNbWwtkUd1xu597ri8qwKFxWkNasfHA2VjsdLnZUnMsoCtp3bDhDpDVixXV/k/8JOygu7pcBUMExv0uR3epsXqW5/2IxlLEyCZLAnBx4zgMCsiftfdXLz6Yma8TNszB7RuuRxrXUcTw+PkIjCdUMCmYxDBaufZNQkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jiSI3g6Q; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727797890; x=1759333890;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=VAtge26Bh/EfVdiVj6CNvp5Mqp5EqlbS+wH7+7c3Or8=;
  b=jiSI3g6QijRwjnvVoi56u+yrJFCDestBnoFIBjleIifwVw0Gm9l/G8+n
   0Gjdg/wkMGOZhxFwEj1KZi4pq003RdbhsBrJqBYbqYYupVloXE9m4OLXN
   cOtK9i5ppZvcNLEDypqt+T+crz611bf8HbkUZYSy7KSELs9kuREzEhU0v
   M=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="338104738"
Subject: RE: [net-next 2/2] ena: Link queues to NAPIs
Thread-Topic: [net-next 2/2] ena: Link queues to NAPIs
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 15:50:27 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:46486]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.202:2525] with esmtp (Farcaster)
 id db4cda57-91b6-4495-9d5b-aacc4c561e59; Tue, 1 Oct 2024 15:50:25 +0000 (UTC)
X-Farcaster-Flow-ID: db4cda57-91b6-4495-9d5b-aacc4c561e59
Received: from EX19D017EUA001.ant.amazon.com (10.252.50.71) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 15:50:25 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D017EUA001.ant.amazon.com (10.252.50.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 15:50:25 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 1 Oct 2024 15:50:24 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan,
 Noam" <ndagan@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kamal Heib
	<kheib@redhat.com>, open list <linux-kernel@vger.kernel.org>, "Bernstein,
 Amit" <amitbern@amazon.com>
Thread-Index: AQHbE3LvonMH5qZYjUqecQ4N60GeD7JxkpvggABi2oCAABVxAA==
Date: Tue, 1 Oct 2024 15:50:24 +0000
Message-ID: <26bda21325814a8cb11f997b80bf5262@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-3-jdamato@fastly.com>
 <eb828dd9f65847a49eb64763740c84ff@amazon.com> <ZvwHC6VLihXevnPo@LQ3V64L9R2>
In-Reply-To: <ZvwHC6VLihXevnPo@LQ3V64L9R2>
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

> > > Link queues to NAPIs using the netdev-genl API so this information
> > > is queryable.
> > >
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.ya=
ml
> \
> > >                          --dump queue-get --json=3D'{"ifindex": 2}'
> > >
> > > [{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> > >  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'rx'},
> > >  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'rx'},
> > >  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'rx'},
> > >  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'rx'},
> > >  {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'},
> > >  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'tx'},
> > >  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'tx'},
> > >  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'tx'},
> > >  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'tx'}]
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/ethernet/amazon/ena/ena_netdev.c | 26
> > > +++++++++++++++++---
> > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > index e88de5e426ef..1c59aedaa5d5 100644
> > > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > @@ -1821,20 +1821,38 @@ static void ena_napi_disable_in_range(struct
> > > ena_adapter *adapter,
> > >                                       int first_index,
> > >                                       int count)  {
> > > +       struct napi_struct *napi;
> >
> > Is this variable necessary? It has been defined in the enable function
> > because it is needed in netif_queue_set_napi() API as well as in
> > napi_enable(), and it makes sense in order to avoid long lines In
> > here, the variable is only used in a call to napi_disable(), can the
> > code be kept as it is? don't see a need to shorten the napi_disable() c=
all
> line.
>=20
> It is true that its only used to call napi_disable so if you prefer to ha=
ve it
> removed let me know?
>=20
> I think it looks nicer with the variable, but it's your driver.
>=20
> > >         int i;
> > >
> > > -       for (i =3D first_index; i < first_index + count; i++)
> > > -               napi_disable(&adapter->ena_napi[i].napi);
> > > +       for (i =3D first_index; i < first_index + count; i++) {
> > > +               napi =3D &adapter->ena_napi[i].napi;
> > > +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> > > +                       netif_queue_set_napi(adapter->netdev, i,
> > > +                                            NETDEV_QUEUE_TYPE_TX, NU=
LL);
> > > +                       netif_queue_set_napi(adapter->netdev, i,
> > > +                                            NETDEV_QUEUE_TYPE_RX, NU=
LL);
> > > +               }
> > > +               napi_disable(napi);
> > > +       }
> > >  }
> > >
> > >  static void ena_napi_enable_in_range(struct ena_adapter *adapter,
> > >                                      int first_index,
> > >                                      int count)  {
> > > +       struct napi_struct *napi;
> > >         int i;
> > >
> > > -       for (i =3D first_index; i < first_index + count; i++)
> > > -               napi_enable(&adapter->ena_napi[i].napi);
> > > +       for (i =3D first_index; i < first_index + count; i++) {
> > > +               napi =3D &adapter->ena_napi[i].napi;
> > > +               napi_enable(napi);
> > > +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> >
> > Can you share some info on why you decided to set the queue to napi
> > association only in non-xdp case?
> > In XDP, there's a napi poll function that's executed and it runs on the=
 TX
> queue.
> > I am assuming that it's because XDP is not yet supported in the
> > framework? If so, there's a need to add an explicit comment above if
> > (!ENA_IS_XDP_INDEX(adapter, i)) { explaining this in order to avoid
> confusion with the rest of the code.
>=20
> Yes; it is skipped for XDP queues, but they could be supported in the fut=
ure.
>=20
> Other drivers that support this API work similarly (see also: bnxt, ice, =
mlx4,
> etc).
>=20
> > > +                       netif_queue_set_napi(adapter->netdev, i,
> > > +                                            NETDEV_QUEUE_TYPE_RX, na=
pi);
> > > +                       netif_queue_set_napi(adapter->netdev, i,
> > > +                                            NETDEV_QUEUE_TYPE_TX, na=
pi);
> > > +               }
> > > +       }
> > >  }
> > >
> > >  /* Configure the Rx forwarding */
> > > --
> > > 2.43.0
> >
> > Thank you for uploading this patch.
>=20
> Can you please let me know (explicitly) if you want me to send a second
> revision (when net-next allows for it) to remove the 'struct napi_struct'=
 and
> add a comment as described above?

Yes, I would appreciate that.
I guess the `struct napi_struct` is OK, this way both functions will look t=
he same.
Regarding the comment, yes please, something like /* This API is supported =
for non-XDP queues only */ in both places.
I also added a small request to preserve reverse christmas tree order on pa=
tch 1/2 in the series.

Thank you again for the patches in the driver.

