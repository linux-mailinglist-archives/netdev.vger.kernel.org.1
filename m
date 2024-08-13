Return-Path: <netdev+bounces-118000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876195037C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875F12846C4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEC190470;
	Tue, 13 Aug 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="py/XrDEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090B2233A
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548076; cv=none; b=cARNxupglKaht89yLQZRyXRCnKUkxB3gpODmWy3b6Egn87p4lScwoNl18TSoo6CxVhVn/ehVn+H91E5v5Tf1jbCVzRoyg5qFTBRb4RDnVoK48Z2hiKvjkPkOiSwDH7H+6jc7VOlis3itLEmhNLt1jgYvISlVJIAlbEUA2PytIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548076; c=relaxed/simple;
	bh=ukTpxMOc/qpq3KyH0evtOpUGdKKj4AUCLw3QMe473zE=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKFGwetivEpm4IGMp2W8/hkghHBCkHryh69vIWeTaLcG2jM1vbwtVgTVYxPUgAXNuqQLqcG2fiqS1OvQZfQVp8QrXVCoE26VW5GJwFUw95CtjqyGZUKBevdgL58ePZUvuSYBeVJHw49lKtfjTsaKys6nCS4GGf1dbk6qL82vJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=py/XrDEt; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723548074; x=1755084074;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ukTpxMOc/qpq3KyH0evtOpUGdKKj4AUCLw3QMe473zE=;
  b=py/XrDEt+pNgvLst1VqTEOikqHPUi5YbrM6O6CE5xkwcXem7fg3P5ZJv
   1k4syH3jANk3rCAm2F758QtcTnFRrg0FIjXFNETGScMGiDUKYaM0TyGkW
   ENFd+5gj2nI2ZeX6FUsKi51UYw3xriSGujwYbPv9s94gc/asssd7wfiDN
   E=;
X-IronPort-AV: E=Sophos;i="6.09,285,1716249600"; 
   d="scan'208";a="115029084"
Subject: RE: [PATCH v1 net-next 1/2] net: ena: Add ENA Express metrics support
Thread-Topic: [PATCH v1 net-next 1/2] net: ena: Add ENA Express metrics support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 11:21:13 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:53930]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.140:2525] with esmtp (Farcaster)
 id 51a6cdb4-ccf6-4a5e-a89d-9dc8c093ceed; Tue, 13 Aug 2024 11:21:12 +0000 (UTC)
X-Farcaster-Flow-ID: 51a6cdb4-ccf6-4a5e-a89d-9dc8c093ceed
Received: from EX19D030EUB001.ant.amazon.com (10.252.61.82) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 11:21:09 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB001.ant.amazon.com (10.252.61.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 11:21:09 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.034; Tue, 13 Aug 2024 11:21:08 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
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
 Igor" <igorch@amazon.com>
Thread-Index: AQHa7SPkbM7pl6vCCUq0KIo2LR3YcLIlCi4g
Date: Tue, 13 Aug 2024 11:21:08 +0000
Message-ID: <d836aae49be1446abad6c00b38e5d2a0@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-2-darinzon@amazon.com>
 <20240812185448.791af6bb@kernel.org>
In-Reply-To: <20240812185448.791af6bb@kernel.org>
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

> On Sun, 11 Aug 2024 13:07:10 +0300 David Arinzon wrote:
> > +On supported instance types, the statistics will also include the ENA
> > +Express data (fields prefixed with `ena_srd`). For a complete
> > +documentation of ENA Express data refer to
> > +https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ena-
> express.html#
> > +ena-express-monitor
>=20
> On a quick scan I don't see anything about statistics in this link.
> One can probably guess the meaning of most of them from the names.

Hi Jakub,

Thanks for looking into this.
There's actually wording about this in the link (in "how ENA Express works"=
, below the note), quoting:

After you've enabled ENA Express for the network interface attachments on b=
oth the sending instance and the receiving instance, you can use ENA Expres=
s metrics to help ensure that your instances take full advantage of the per=
formance improvements that SRD technology provides. For more information ab=
out ENA Express metrics, see Metrics for ENA Express.

There's also a link in "see metrics for ENA Express" for further informatio=
n and examples about the statistics themselves,

Thanks,
David


