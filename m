Return-Path: <netdev+bounces-124389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C399692E6
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40C3282FEF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB411CB535;
	Tue,  3 Sep 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JqVi/DYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3121CDFAC
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725337763; cv=none; b=QdunEyxF/wpYc/LhTP9wXPIo6pzDi/5p2vepyylgyysQcmV8lOGpo6J5CowebjCf4f/6BWXTD7Bxox20nJDIdnnlwXypPNGY1KgZwoPWlwvQptXZ1ObEezrWOdHP0rEVv/aMcdmRQThm04IhWkLxwXRS8TUMPxszFQATITr5COE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725337763; c=relaxed/simple;
	bh=uH7Gn3d41cpuwRq799H0mwL8fYyKUrYGCCV035KdmTo=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmdfcDYalQ42baKgN0EvUPYy9JnnSe5rk8ympruXyTxd95CaUCPJtIDyCInJlol98a4L5gQ7pyvESItANvJCJe0rKlb4E+SCESGpn1np5rRwfInHBvF/hxmhTI8oet6icGLvOUEYKs9hk8rVYIT0U9fTvCv7/eX8Rvv1gPLAquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JqVi/DYe; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725337763; x=1756873763;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=uH7Gn3d41cpuwRq799H0mwL8fYyKUrYGCCV035KdmTo=;
  b=JqVi/DYeTMT529l4E1HqyHUyCxxkpvMN7FfsjlYFxWvfidIYABvUvGXG
   0HqYsJK/AsL8mgq4u6DMo7Fcq8//+EVrJIVn3e4DYuZOU/K5Y+T5AZtyG
   g7wVMxDrhdSHFKG6voPZcQri5bD1XlQjRxg2fOSYvBQSiBiLfI/zYZX13
   k=;
X-IronPort-AV: E=Sophos;i="6.10,197,1719878400"; 
   d="scan'208";a="430785666"
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting
 support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 04:29:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:31765]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.97:2525] with esmtp (Farcaster)
 id bfbc5d68-0272-4b25-abd5-8fdf8f634ccc; Tue, 3 Sep 2024 04:29:18 +0000 (UTC)
X-Farcaster-Flow-ID: bfbc5d68-0272-4b25-abd5-8fdf8f634ccc
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 3 Sep 2024 04:29:18 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 3 Sep 2024 04:29:18 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 3 Sep 2024 04:29:18 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "Xuan
 Zhuo" <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>, "Chauskin,
 Igor" <igorch@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Cornelia
 Huck" <cohuck@redhat.com>
Thread-Index: AQHa7SRj5VISt7WkiEq52al7KaOO2rIkcQQAgACfhwCAAD2PAIABmGGAgAA9c4CAFP5L8IAJdm9g
Date: Tue, 3 Sep 2024 04:29:18 +0000
Message-ID: <686a380af2774aa9ade5a9baa1f9e49a@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
 <20240814121145.37202722@kernel.org>
 <IA0PR12MB87130D5D31AEFDBEDBF690ADDC952@IA0PR12MB8713.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB87130D5D31AEFDBEDBF690ADDC952@IA0PR12MB8713.namprd12.prod.outlook.com>
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

> > > I've looked into the definition of the metrics under question
> > >
> > > Based on AWS documentation
> > > (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-
> > networ
> > > k-performance-ena.html)
> > >
> > > bw_in_allowance_exceeded: The number of packets queued or dropped
> > because the inbound aggregate bandwidth exceeded the maximum for the
> > instance.
> > > bw_out_allowance_exceeded: The number of packets queued or
> dropped
> > because the outbound aggregate bandwidth exceeded the maximum for
> the
> > instance.
> > >
> > > Based on the netlink spec
> > > (https://docs.kernel.org/next/networking/netlink_spec/netdev.html)
> > >
> > > rx-hw-drop-ratelimits (uint)
> > > doc: Number of the packets dropped by the device due to the received
> > packets bitrate exceeding the device rate limit.
> > > tx-hw-drop-ratelimits (uint)
> > > doc: Number of the packets dropped by the device due to the transmit
> > packets bitrate exceeding the device rate limit.
> > >
> > > The AWS metrics are counting for packets dropped or queued (delayed,
> > > but
> > are sent/received with a delay), a change in these metrics is an
> > indication to customers to check their applications and workloads due
> > to risk of exceeding limits.
> > > There's no distinction between dropped and queued in these metrics,
> > therefore, they do not match the ratelimits in the netlink spec.
> > > In case there will be a separation of these metrics in the future to
> > > dropped
> > and queued, we'll be able to add the support for hw-drop-ratelimits.
> >
> > Xuan, Michael, the virtio spec calls out drops due to b/w limit being
> > exceeded, but AWS people say their NICs also count packets buffered
> > but not dropped towards a similar metric.
> >
> > I presume the virtio spec is supposed to cover the same use cases.
> On tx side, number of packets may not be queued, but may not be even
> DMAed if the rate has exceeded.
> This is hw nic implementation detail and a choice with trade-offs.
>=20
> Similarly on rx, one may implement drop or queue or both (queue upto some
> limit, and drop beyond it).
>=20
> > Have the stats been approved?
> Yes. it is approved last year; I have also reviewed it; It is part of the=
 spec
> nearly 10 months ago at [1].
> GH PR is merged but GH is not updated yet.
>=20
> [1] https://github.com/oasis-tcs/virtio-
> spec/commit/42f389989823039724f95bbbd243291ab0064f82
>=20
> > Is it reasonable to extend the definition of the "exceeded" stats in
> > the virtio spec to cover what AWS specifies?
> Virtio may add new stats for exceeded stats in future.
> But I do not understand how AWS ENA nic is related to virtio PCI HW nic.
>=20
> Should virtio implement it? may be yes. Looks useful to me.
> Should it be now in virtio spec, not sure, this depends on virtio communi=
ty
> and actual hw/sw supporting it.
>=20
> > Looks like PR is still open:
> > https://github.com/oasis-tcs/virtio-spec/issues/180
> Spec already has it at [1] for drops. GH PR is not upto date.

Thank you for the reply, Parav.
I've raised the query and the summary of this discussion in the above menti=
oned github ticket.


