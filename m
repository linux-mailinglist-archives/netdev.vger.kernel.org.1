Return-Path: <netdev+bounces-119370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC11955569
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360DB1F22B46
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919155769;
	Sat, 17 Aug 2024 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wz25Y1sE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A95256E
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723869770; cv=none; b=Uvs4is6Ipk/pEgnDoEgq1zjVWCk2NRbeHqylstv+0nOA+p1mMlXuUnnMKladcin5IeaVeFZzRidvuDSvSSQKg2XqiA1NOwiLwZ6bSr5/6/D5z01mhFgFmVvhL7t6EtCjkMXXyFvIhj3aK8Na2XnE/LuZ+YN/E4xkY1GkyyAMw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723869770; c=relaxed/simple;
	bh=Wt2hvS3OanSLj/KM7stSn+rzqiWimQsPiJVG3C3yoGs=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kzZ86dbTTC3mrrQdFc65a29odVF76SekUMZjzH+TMTehvX8N+uhNJtZFMWK2z7NmZDrNr0JGl16vtiVjtEVrOpDxDbZSygKZJ7RnEmFJjUrupuJTJN+uGSmsiSXY3laBDP82zE2A2cgICx9LztdkLWUhsQ2qzdOVEQOJhTzzh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wz25Y1sE; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723869769; x=1755405769;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Wt2hvS3OanSLj/KM7stSn+rzqiWimQsPiJVG3C3yoGs=;
  b=Wz25Y1sEyPJviOtynRg5KKiRawWoLzquSNvJhY3MSIWew1v8VqOjpc5m
   AjMCt/r4+NpZSKXYgJ/4L1MFVrYJHy0E8w6TIn5TQuUgcOqMSsQ5d7DrI
   8/qz1Usnvm1GndNkUf7xb9vHyfx7/bj94pNW2rIuyW+t8PVWb/5oT/jQB
   M=;
X-IronPort-AV: E=Sophos;i="6.10,153,1719878400"; 
   d="scan'208";a="417739487"
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting
 support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting support
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:42:45 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:22242]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.3.85:2525] with esmtp (Farcaster)
 id f70c818c-b36b-4a65-86ff-663781859823; Sat, 17 Aug 2024 04:42:44 +0000 (UTC)
X-Farcaster-Flow-ID: f70c818c-b36b-4a65-86ff-663781859823
Received: from EX19D010EUA002.ant.amazon.com (10.252.50.108) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 17 Aug 2024 04:42:43 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D010EUA002.ant.amazon.com (10.252.50.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 17 Aug 2024 04:42:43 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.034; Sat, 17 Aug 2024 04:42:43 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
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
Thread-Index: AQHa7SRj5VISt7WkiEq52al7KaOO2rIlC6FwgAA/3QCAAZZYsIAAP3yAgAMGr1CAAJCMAIAAKKdg
Date: Sat, 17 Aug 2024 04:42:43 +0000
Message-ID: <0b222f4ddde14f9093d037db1a68d76a@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
	<20240814121145.37202722@kernel.org>
	<6236150118de4e499304ba9d0a426663@amazon.com>
 <20240816190148.7e915604@kernel.org>
In-Reply-To: <20240816190148.7e915604@kernel.org>
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

> > > Xuan, Michael, the virtio spec calls out drops due to b/w limit
> > > being exceeded, but AWS people say their NICs also count packets
> > > buffered but not dropped towards a similar metric.
> > >
> > > I presume the virtio spec is supposed to cover the same use cases.
> > > Have the stats been approved? Is it reasonable to extend the
> > > definition of the "exceeded" stats in the virtio spec to cover what A=
WS
> specifies?
> > > Looks like PR is still open:
> > > https://github.com/oasis-tcs/virtio-spec/issues/180
> >
> > How do we move forward with this patchset?
> > Regarding the counter itself, even though we don't support this at the
> > moment, I would recommend to keep the queued and dropped as split
> (for
> > example, add tx/rx-hw-queued-ratelimits, or something similar, if that
> > makes sense).
>=20
> Could you share some background for your recommendation?
> As you say, the advice contradicts your own code :S Let's iron this out f=
or
> virtio's benefit.
>=20

The links I've shared before are of public AWS documentation, therefore, th=
is is what AWS currently supports.
When looking at the definition of what queued and what dropped means, havin=
g such a separation
will benefit customers better as it will provide them more detailed informa=
tion about the limits
that they're about to exceed or are already exceeding. A queued packet will=
 be received with a
delay, while a dropped packet wouldn't arrive to the destination.
In both cases, customers need to look into their applications and network l=
oads and see what should
be changed, but when I'm looking at a case where packets are dropped, it is=
 more dire (in some use-cases)
that when packets are being delayed, which is possibly more transparent to =
some network loads that are
not looking for cases like low latency.

Even though the ENA driver can't support it at the moment, given that the s=
tats interface is
aiming for other drivers to implement (based on their level of support), th=
e level of granularity and separation
will be more generic and more beneficial to customers. In my opinion, the s=
uggestion to virtio is more
posing a limitation based on what AWS currently supports than creating some=
thing
generic that other drivers will hopefully implement based on their NICs.

> You can resend the first patch separately in the meantime.

I prefer them to be picked up together.


