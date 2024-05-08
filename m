Return-Path: <netdev+bounces-94409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CFF8BF5DD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FA61F21ECB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077871773A;
	Wed,  8 May 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WzQupljn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F128F6C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148100; cv=none; b=k1r7nC6W4fwXr/V6YE4uLPlhGtyK+5Ou6yRDWr/KLZrKj87AY3mL90F0NIfMHLPzoS+Ksgi2/9+yvTfHHbP1UgtUtt/mBz8wO1KYD4cbaoouAwHzVfgEvqiUt/8Qm+6DPeeWyZeKS73wBS+u2y1kdenyIRkvlQO6/9lbs8nUBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148100; c=relaxed/simple;
	bh=jDPLRJI6FIIExH2Gof+vrgREL1/Oa/ZoeTWlWXMXU/U=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dC3VtHj86XHmXmFqaH+I3Nkv1IlB9vaS5p5lQOEAyWdE6TUmJIj5pP02iWnOKe9Hzzyi2BP+Exg8rT1un1JD5Owflb6p3tHVDxi8uUeyL5D23Qt/J2xmovsehyDvk5Ea8nkjoKkZJuB30f2k/nZ1npULuClZmUoGcfGympMrp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WzQupljn; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715148100; x=1746684100;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=PHk1zCWK1eHCtLq2gwK3TMa/JBIUlQXwXi46x0Ie1h4=;
  b=WzQupljnf5PygypUQtj9k+W2F9UHkkyNflTNnZYSb6KWqfLSLvVqW/AM
   QoSmzFO5ULUNnhXXaL0W0BrQ3DP0tph5iM4VVuDqJQFtntA3WuTx0gK73
   5tYCAmRsaL/uYJqRKHOvVYvi7LVAVWtIh+sUoH4Ul8GIcW4mmEn4IZ5qe
   M=;
X-IronPort-AV: E=Sophos;i="6.08,144,1712620800"; 
   d="scan'208";a="631594434"
Subject: RE: [PATCH v1 net-next 3/6] net: ena: Add validation for completion
 descriptors consistency
Thread-Topic: [PATCH v1 net-next 3/6] net: ena: Add validation for completion descriptors
 consistency
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:01:38 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:30382]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.67:2525] with esmtp (Farcaster)
 id 411a6b10-33ac-44ba-b3f3-27faa425a763; Wed, 8 May 2024 06:01:35 +0000 (UTC)
X-Farcaster-Flow-ID: 411a6b10-33ac-44ba-b3f3-27faa425a763
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 06:01:34 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 06:01:33 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.028; Wed, 8 May 2024 06:01:33 +0000
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
Thread-Index: AQHaoPAh1qNtWQdCzEC+RorS3ptvYrGM1uQA
Date: Wed, 8 May 2024 06:01:33 +0000
Message-ID: <486d3c51e2014d0ebae36b25be276bf9@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
	<20240506070453.17054-4-darinzon@amazon.com>
 <20240507193302.440feb6e@kernel.org>
In-Reply-To: <20240507193302.440feb6e@kernel.org>
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

> > +             if (unlikely((status & ENA_ETH_IO_RX_CDESC_BASE_FIRST_MAS=
K)
> >>
> > +                 ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT && count !=3D 0)=
) {
> > +                     struct ena_com_dev *dev =3D
> > + ena_com_io_cq_to_ena_dev(io_cq);
> > +
> > +                     netdev_err(dev->net_device,
> > +                                "First bit is on in descriptor #%d on =
q_id: %d, req_id:
> %u\n",
> > +                                count, io_cq->qid, cdesc->req_id);
> > +                     return -EFAULT;
>=20
> This is really asking to be a devlink health reporter.
> You can dump the information to the user and get the event counter for
> free.
>=20
> But if you don't want to use that - please at least rate limit the messag=
e.

Hi Jakub,

Thank you for reviewing the patch.

We have an action item to review the devlink health mechanism to see how it=
 can benefit
our solution. Thank you for raising this point.

Regarding this print, I don't expect it to be printed more than once,
as a failure here returns -EFAULT which triggers an error flow and an ENA r=
eset sequence,
which will also stop the TX and RX queues as part of it, and no further des=
criptors will
be processed until the reset sequence is complete.

Please let us know if you still have concerns regarding this print.


