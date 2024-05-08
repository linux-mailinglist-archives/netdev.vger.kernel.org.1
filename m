Return-Path: <netdev+bounces-94408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B748BF5C9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A19DB2112A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE4175BF;
	Wed,  8 May 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VV8mUXz1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79947171B0
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147760; cv=none; b=rKRhYSDox26XSjrkAViSU3fMjyMifbveOGJ+KPhbiz+pc7JeeZ8aaWHGDEhIbEqdQ5hUQGZCImNe651G7P7YGqFOEsOeYboOYVtUAcDHnpUcnbYzRzqhH+ePpoEOrIucBsCP7PtLZ03uy2SmW7l8acyD4f+LEdIGocSYpdooV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147760; c=relaxed/simple;
	bh=g2PxSHTb3JKE6V8smJCtD1imGJ8A+DqnPVSzm0KMlco=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OxLSR/yMDyG5puTJZ1kDKJ8mq9d5jrRW894/6sLbw4Sz4Q/nuv5ErWkFmnNGGjpxtupfBzA9QbSTFSKnnmSwanoLrtDusuUUAZli6ONxIFgFFh005gIZnxDvElaE+sI/m4Jw5YcOeu0B8xZgzkbqOna8+wSKvdEQykZGqtlksZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VV8mUXz1; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715147760; x=1746683760;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=wXR03Uort5hzK5VWpzbSFVh8QordBRfgIJ5ULjSP4OI=;
  b=VV8mUXz11rjeA7e474WDXllDD1d+tSpPAZ05cFd+sqNaCFkNs8X/3q8C
   6Be+MRD34GkurGeCzX7I8AoN+Qi1vsNj5e21ahnxgVAkhSf4Sta0yLCtR
   Qyas3IrD1JzTVWeEeib+O6Rh2C7bbs8nFib0nIPqQvMNvy1FoOnrQYSZR
   k=;
X-IronPort-AV: E=Sophos;i="6.08,144,1712620800"; 
   d="scan'208";a="343335370"
Subject: RE: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt
 moderation update action
Thread-Topic: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt moderation
 update action
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 05:55:52 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:53405]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.207:2525] with esmtp (Farcaster)
 id dd2ef620-a41a-4ac5-93d8-7e41dff22fc8; Wed, 8 May 2024 05:55:51 +0000 (UTC)
X-Farcaster-Flow-ID: dd2ef620-a41a-4ac5-93d8-7e41dff22fc8
Received: from EX19D028EUB004.ant.amazon.com (10.252.61.32) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 05:55:50 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB004.ant.amazon.com (10.252.61.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 05:55:50 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.028; Wed, 8 May 2024 05:55:50 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>
Thread-Index: AQHaoO/Zr9oRuuhlBkmrtZyc51nFsLGM0/hQ
Date: Wed, 8 May 2024 05:55:50 +0000
Message-ID: <6f5415915976495f8252411c317aedbb@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
	<20240506070453.17054-7-darinzon@amazon.com>
 <20240507193111.5d24343c@kernel.org>
In-Reply-To: <20240507193111.5d24343c@kernel.org>
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

> On Mon, 6 May 2024 07:04:53 +0000 darinzon@amazon.com wrote:
> > +     for (i =3D 0; i < adapter->num_io_queues; i++) {
> > +             adapter->rx_ring[i].interrupt_interval_changed =3D
>=20
> Shouldn't this be |=3D ?
>=20

Hi Jakub,

Thank you for reviewing the patch.

This is a true/false indicator, it doesn't require history/previous value t=
o be considered.
Therefore, not sure I see the how |=3D can help us in the logic here.
The flag is set here to true if during the interrupt moderation update, whi=
ch is, in this flow,
triggered by an ethtool operation, the moderation value has changed from th=
e currently
configurated one.

> > +                     adapter->rx_ring[i].interrupt_interval !=3D val;
> > +             adapter->rx_ring[i].interrupt_interval =3D val;
> > +     }

