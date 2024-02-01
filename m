Return-Path: <netdev+bounces-67971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A684583E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81561F24368
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944086655;
	Thu,  1 Feb 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QjdQGNNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CC86652
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792035; cv=none; b=orGNQRVYo3mYzOQwFTfveII+tSVcg2JVHFmBK8gaNrtoIGR53OdhjdZvUVlQ4wmuVhElGHe4l7FW9ln6FwkzgxbKYDpcmgyXMxMFgmBsm3JW6TEcaSuE9Fdp/9EikNdEMUgFJyzfv4ND2gmY0pf0uIk6983uE3oz6qcHsLIlm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792035; c=relaxed/simple;
	bh=lJk6F40EX2QvvQTcQsBR0VRbP4//OAtTCAz2dIZTgmI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1exly6OodMFa5qXU82AY/28wCLoUHxDy3v1fLEUt/OaDXSA8j+G4nt999EafZErM78P53rkWhLU5Nr0wStOMd2CnMzxmtiyzzjU+IwwzkceVuNUh5F21wYVgZ0Hlg4N29f68Q23b3dhJVTH/2GqfRDmdfLQmrjKgI+36//dDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QjdQGNNl; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706792034; x=1738328034;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=QjN2J+bsA1uZ4pEXSkoeY/TGuLjdtGbS5fl2KxppPWA=;
  b=QjdQGNNlHRQXChuShTz7NJYhZ1rsT7wBw3r9NjfhUmZjjKKRGRGb83R0
   YPMdhUbLffC/njs/uLZnmVAmMp7snmstKCvqfFInBiry14t8wBUK1Rlda
   0eW+GEquBfiURs1msjJax+agDvSvd7x6mLnXczhEP2l84lbUui9BsJHzf
   U=;
X-IronPort-AV: E=Sophos;i="6.05,234,1701129600"; 
   d="scan'208";a="270278186"
Subject: RE: [PATCH v2 net-next 07/11] net: ena: Add more information on TX timeouts
Thread-Topic: [PATCH v2 net-next 07/11] net: ena: Add more information on TX timeouts
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 12:53:52 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:65445]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.233:2525] with esmtp (Farcaster)
 id 83f805a2-81a6-4a72-9a18-c0e5edf660fd; Thu, 1 Feb 2024 12:53:50 +0000 (UTC)
X-Farcaster-Flow-ID: 83f805a2-81a6-4a72-9a18-c0e5edf660fd
Received: from EX19D028EUB001.ant.amazon.com (10.252.61.99) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 12:53:42 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB001.ant.amazon.com (10.252.61.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 12:53:41 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 12:53:41 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi,
 Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkoler@amazon.com>
Thread-Index: AQHaVQn3hfQLMBh6a0WU5j7lr2v9nrD1bpIQ
Date: Thu, 1 Feb 2024 12:53:41 +0000
Message-ID: <903a717258b548e19314b35e1ff9b638@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
 <20240130095353.2881-8-darinzon@amazon.com>
 <20240201122705.GA530335@kernel.org>
In-Reply-To: <20240201122705.GA530335@kernel.org>
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

> On Tue, Jan 30, 2024 at 09:53:49AM +0000, darinzon@amazon.com wrote:
> > From: David Arinzon <darinzon@amazon.com>
> >
> > The function responsible for polling TX completions might not receive
> > the CPU resources it needs due to higher priority tasks running on the
> > requested core.
> >
> > The driver might not be able to recognize such cases, but it can use
> > its state to suspect that they happened. If both conditions are met:
> >
> > - napi hasn't been executed more than the TX completion timeout value
> > - napi is scheduled (meaning that we've received an interrupt)
> >
> > Then it's more likely that the napi handler isn't scheduled because of
> > an overloaded CPU.
> > It was decided that for this case, the driver would wait twice as long
> > as the regular timeout before scheduling a reset.
> > The driver uses ENA_REGS_RESET_SUSPECTED_POLL_STARVATION reset
> reason
> > to indicate this case to the device.
> >
> > This patch also adds more information to the ena_tx_timeout() callback.
> > This function is called by the kernel when it detects that a specific
> > TX queue has been closed for too long.
> >
> > Signed-off-by: Shay Agroskin <shayagr@amazon.com>
> > Signed-off-by: David Arinzon <darinzon@amazon.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c  | 77
> +++++++++++++++----
> >  .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
> >  2 files changed, 64 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index 18acb76..ae9291b 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -47,19 +47,44 @@ static int ena_restore_device(struct ena_adapter
> > *adapter);
> >
> >  static void ena_tx_timeout(struct net_device *dev, unsigned int
> > txqueue)  {
> > +     enum ena_regs_reset_reason_types reset_reason =3D
> > + ENA_REGS_RESET_OS_NETDEV_WD;
> >       struct ena_adapter *adapter =3D netdev_priv(dev);
> > +     unsigned int time_since_last_napi, threshold;
> > +     struct ena_ring *tx_ring;
> > +     int napi_scheduled;
> > +
> > +     if (txqueue >=3D adapter->num_io_queues) {
> > +             netdev_err(dev, "TX timeout on invalid queue %u\n", txque=
ue);
> > +             goto schedule_reset;
> > +     }
> > +
> > +     threshold =3D jiffies_to_usecs(dev->watchdog_timeo);
> > +     tx_ring =3D &adapter->tx_ring[txqueue];
> > +
> > +     time_since_last_napi =3D jiffies_to_usecs(jiffies - tx_ring-
> >tx_stats.last_napi_jiffies);
> > +     napi_scheduled =3D !!(tx_ring->napi->state & NAPIF_STATE_SCHED);
> >
> > +     netdev_err(dev,
> > +                "TX q %d is paused for too long (threshold %u). Time s=
ince last
> napi %u usec. napi scheduled: %d\n",
> > +                txqueue,
> > +                threshold,
> > +                time_since_last_napi,
> > +                napi_scheduled);
> > +
> > +     if (threshold < time_since_last_napi && napi_scheduled) {
> > +             netdev_err(dev,
> > +                        "napi handler hasn't been called for a long ti=
me but is
> scheduled\n");
> > +                        reset_reason =3D
> > + ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;
>=20
> Hi David,
>=20
> a nit from my side: the line above is indented one tab-stop too many.
> No need to respin just for this AFAIC.
>=20

Hi Simon,

Thanks for pointing it out. Seems like I got carried away a bit with the
Indentation due to the print above it.

Thanks,
David

> > +     }
> > +schedule_reset:
> >       /* Change the state of the device to trigger reset
> >        * Check that we are not in the middle or a trigger already
> >        */
> > -
> >       if (test_and_set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))
> >               return;
> >
> > -     ena_reset_device(adapter, ENA_REGS_RESET_OS_NETDEV_WD);
> > +     ena_reset_device(adapter, reset_reason);
> >       ena_increase_stat(&adapter->dev_stats.tx_timeout, 1,
> > &adapter->syncp);
> > -
> > -     netif_err(adapter, tx_err, dev, "Transmit time out\n");
> >  }
> >
>=20
> ...

