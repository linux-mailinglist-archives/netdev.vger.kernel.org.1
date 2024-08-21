Return-Path: <netdev+bounces-120699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBD95A457
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A20F28348A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE211B2ED6;
	Wed, 21 Aug 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZRWY20wJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0361B2EC8
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263417; cv=none; b=DZXjvSc1p4CAjYw1+9nhUxAqa1CEYZJ9ZH5wEhexur4LFZsJcEdGp0ItGefRuv/JyFAnA+6kS6vwQS8FrLmYI4R3GiQufUCfIGTd2vN0pXnanmUvMPNVaksOu1VjOpAVQSssBe84j5Q7DBYFnnDSakZtGvwW89YPGlWqKyjOSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263417; c=relaxed/simple;
	bh=BDfRHq7rDy7s2TYl7OFK0DCOVkCIMnB7hMpGCZ1d0H0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGT0q35D7Ii4uo7XyyIjdHaK4nzf8fCFJlTZS1UvLcLKBR19Z1TlxGI2o94+9r4wOPPLDD8yK7BKd2paJ+7E3x26jF+78FaAqE/IrPALNRmbpTuCeWvw61lUBAoXzIlhkiNMpm7xLT8enK1jccQvgrXcD3BP9P/7kgi3Dnya90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZRWY20wJ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724263416; x=1755799416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BDfRHq7rDy7s2TYl7OFK0DCOVkCIMnB7hMpGCZ1d0H0=;
  b=ZRWY20wJypgaiev3O9O76plViSddpGZrDW7Raw2GAWXyIBnAGw1ZoStR
   O4OOXMZwiVAgKzEQixvrHweTpHZnb9LfLoTdYLgz/EK2nuWk2xsofprp8
   DYCo1LuSQ7mSJv0i4uovPneElqnu4SeOz25Fk7hqQTu02NAzDazhc32wQ
   M=;
X-IronPort-AV: E=Sophos;i="6.10,164,1719878400"; 
   d="scan'208";a="20402654"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:03:31 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:33412]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.60:2525] with esmtp (Farcaster)
 id 97ba5892-f684-44d8-a4d5-22a51ac8898e; Wed, 21 Aug 2024 18:03:28 +0000 (UTC)
X-Farcaster-Flow-ID: 97ba5892-f684-44d8-a4d5-22a51ac8898e
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 21 Aug 2024 18:03:28 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 21 Aug 2024 18:03:27 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.034; Wed, 21 Aug 2024 18:03:27 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "Arinzon, David" <darinzon@amazon.com>, Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi,
 Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Beider, Ron"
	<rbeider@amazon.com>, "Chauskin, Igor" <igorch@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, Parav Pandit <parav@nvidia.com>, Cornelia Huck
	<cohuck@redhat.com>
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Thread-Index: AQHa8/RshWVir0gVjEGCWM9asSmDOA==
Date: Wed, 21 Aug 2024 18:03:27 +0000
Message-ID: <460b64a1f3e8405fb553fbc04cef2db3@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
	<20240814121145.37202722@kernel.org>
	<6236150118de4e499304ba9d0a426663@amazon.com>
 <20240816190148.7e915604@kernel.org>
 <0b222f4ddde14f9093d037db1a68d76a@amazon.com>
In-Reply-To: <0b222f4ddde14f9093d037db1a68d76a@amazon.com>
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

> > > > Xuan, Michael, the virtio spec calls out drops due to b/w limit
> > > > being exceeded, but AWS people say their NICs also count packets
> > > > buffered but not dropped towards a similar metric.
> > > >
> > > > I presume the virtio spec is supposed to cover the same use cases.
> > > > Have the stats been approved? Is it reasonable to extend the
> > > > definition of the "exceeded" stats in the virtio spec to cover
> > > > what AWS
> > specifies?
> > > > Looks like PR is still open:
> > > > https://github.com/oasis-tcs/virtio-spec/issues/180
> > >
> > > How do we move forward with this patchset?
> > > Regarding the counter itself, even though we don't support this at
> > > the moment, I would recommend to keep the queued and dropped as
> > > split
> > (for
> > > example, add tx/rx-hw-queued-ratelimits, or something similar, if
> > > that makes sense).
> >
> > Could you share some background for your recommendation?
> > As you say, the advice contradicts your own code :S Let's iron this
> > out for virtio's benefit.
> >
>=20
> The links I've shared before are of public AWS documentation, therefore,
> this is what AWS currently supports.
> When looking at the definition of what queued and what dropped means,
> having such a separation will benefit customers better as it will provide=
 them
> more detailed information about the limits that they're about to exceed o=
r
> are already exceeding. A queued packet will be received with a delay, whi=
le a
> dropped packet wouldn't arrive to the destination.
> In both cases, customers need to look into their applications and network
> loads and see what should be changed, but when I'm looking at a case wher=
e
> packets are dropped, it is more dire (in some use-cases) that when packet=
s
> are being delayed, which is possibly more transparent to some network loa=
ds
> that are not looking for cases like low latency.
>=20
> Even though the ENA driver can't support it at the moment, given that the
> stats interface is aiming for other drivers to implement (based on their =
level
> of support), the level of granularity and separation will be more generic=
 and
> more beneficial to customers. In my opinion, the suggestion to virtio is =
more
> posing a limitation based on what AWS currently supports than creating
> something generic that other drivers will hopefully implement based on th=
eir
> NICs.
>=20
> > You can resend the first patch separately in the meantime.
>=20
> I prefer them to be picked up together.
>=20

I see that there's no feedback from Xuan or Michael.

Jakub, what are your thoughts about my suggestion?

