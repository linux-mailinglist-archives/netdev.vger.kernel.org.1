Return-Path: <netdev+bounces-119262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32B955006
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D041F23FBB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE622E636;
	Fri, 16 Aug 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RLFIc+PS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7728FF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829587; cv=none; b=sMsO2j+/R5iZkF28pyg0oUlADO62m2TqUxvcrNd9Rs4nPvMLhJeD1S/Qe/kt5MWgt9oQNphCuQTJJKwt2GO7Y3oiEjp56H9EXvdghnKUWVm9cdevJqR9jdfqY6Jm1gnXYr1QNM5hjWWgAtxs0315RyTK3Vxl3k7fZiRhilq42Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829587; c=relaxed/simple;
	bh=X6eZrp9K193ViZvQXdQBdu726D8gpPnHWzwO+aspjdQ=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EfU04hR3YJ9qK2oUPD48qoiT0ggp38sBPaQPnNtXXe38o8dN0lcRaoXihO8eh5i+73lr9KbgIZxNhWZ1Ama/AuToePy2yJDj0epFiJcO8LAqTEoEy+gPSXpmMSSxJZGiYX+6A/rPwy8+zr3IyFEBl4XKFRUmddHvVOCjmTnpgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RLFIc+PS; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723829587; x=1755365587;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=X6eZrp9K193ViZvQXdQBdu726D8gpPnHWzwO+aspjdQ=;
  b=RLFIc+PSe/qALwtZgaLUKrE9wK+my1WxZSI7bSFgA6ys1dUu8VxdWqU5
   UWrL0SX/6x011pQg04Qv7c5rpCSSIua/Gwno+In8FZbczBNyP0452INnZ
   nbnzykBu2QIbnDVvrP24neqE1XuBPREwFy6IcPqa726eLBz/ZGWTak1ff
   4=;
X-IronPort-AV: E=Sophos;i="6.10,152,1719878400"; 
   d="scan'208";a="750768862"
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting
 support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 17:33:00 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:7251]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.3.85:2525] with esmtp (Farcaster)
 id 4375fe12-e36f-4fa9-9d32-b6797f31624a; Fri, 16 Aug 2024 17:32:58 +0000 (UTC)
X-Farcaster-Flow-ID: 4375fe12-e36f-4fa9-9d32-b6797f31624a
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 17:32:57 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 17:32:56 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.034; Fri, 16 Aug 2024 17:32:56 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
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
 Igor" <igorch@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Parav
 Pandit" <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Index: AQHa7SRj5VISt7WkiEq52al7KaOO2rIlC6FwgAA/3QCAAZZYsIAAP3yAgAMGr1A=
Date: Fri, 16 Aug 2024 17:32:56 +0000
Message-ID: <6236150118de4e499304ba9d0a426663@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
 <20240814121145.37202722@kernel.org>
In-Reply-To: <20240814121145.37202722@kernel.org>
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

> > I've looked into the definition of the metrics under question
> >
> > Based on AWS documentation
> > (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-
> networ
> > k-performance-ena.html)
> >
> > bw_in_allowance_exceeded: The number of packets queued or dropped
> because the inbound aggregate bandwidth exceeded the maximum for the
> instance.
> > bw_out_allowance_exceeded: The number of packets queued or dropped
> because the outbound aggregate bandwidth exceeded the maximum for the
> instance.
> >
> > Based on the netlink spec
> > (https://docs.kernel.org/next/networking/netlink_spec/netdev.html)
> >
> > rx-hw-drop-ratelimits (uint)
> > doc: Number of the packets dropped by the device due to the received
> packets bitrate exceeding the device rate limit.
> > tx-hw-drop-ratelimits (uint)
> > doc: Number of the packets dropped by the device due to the transmit
> packets bitrate exceeding the device rate limit.
> >
> > The AWS metrics are counting for packets dropped or queued (delayed,
> but are sent/received with a delay), a change in these metrics is an indi=
cation
> to customers to check their applications and workloads due to risk of
> exceeding limits.
> > There's no distinction between dropped and queued in these metrics,
> therefore, they do not match the ratelimits in the netlink spec.
> > In case there will be a separation of these metrics in the future to dr=
opped
> and queued, we'll be able to add the support for hw-drop-ratelimits.
>=20
> Xuan, Michael, the virtio spec calls out drops due to b/w limit being
> exceeded, but AWS people say their NICs also count packets buffered but
> not dropped towards a similar metric.
>=20
> I presume the virtio spec is supposed to cover the same use cases.
> Have the stats been approved? Is it reasonable to extend the definition o=
f
> the "exceeded" stats in the virtio spec to cover what AWS specifies?
> Looks like PR is still open:
> https://github.com/oasis-tcs/virtio-spec/issues/180

How do we move forward with this patchset?
Regarding the counter itself, even though we don't support this at the mome=
nt, I would recommend to keep the queued and dropped
as split (for example, add tx/rx-hw-queued-ratelimits, or something similar=
, if that makes sense).=20

Thanks
David

