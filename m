Return-Path: <netdev+bounces-61450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC66823C5C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 07:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC2B20EDF
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2731CFAE;
	Thu,  4 Jan 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T5LqJK+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40A1DDEE
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704350961; x=1735886961;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=9BhVNc/SvCch4IKBowo9nLxC2iIeJbChVni7GigzOS0=;
  b=T5LqJK+bpBB/PGeSfXm0Y65rIyR/RfhdGSe2S0bFeoqjbV1qZ5iDUU4e
   Ca1ln3NkPexRWWigzTH29cyIS/1o07hDUSSL3Qmq2vYELScm98d7NFj1R
   vgj4cPZQawNOi2g9CZaRq9abzgo7+Tm6tB+NjYr9519katDD8Gqp89TWR
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,330,1695686400"; 
   d="scan'208";a="387449545"
Subject: RE: [PATCH v2 net-next 07/11] net: ena: Refactor napi functions
Thread-Topic: [PATCH v2 net-next 07/11] net: ena: Refactor napi functions
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:49:15 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 2D30D80351;
	Thu,  4 Jan 2024 06:49:14 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:28127]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.236:2525] with esmtp (Farcaster)
 id 81f0a212-db59-4b68-9ed4-8ecf50a121dd; Thu, 4 Jan 2024 06:49:13 +0000 (UTC)
X-Farcaster-Flow-ID: 81f0a212-db59-4b68-9ed4-8ecf50a121dd
Received: from EX19D030EUB002.ant.amazon.com (10.252.61.16) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 06:49:12 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB002.ant.amazon.com (10.252.61.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 06:49:12 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Thu, 4 Jan 2024 06:49:12 +0000
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
Thread-Index: AQHaPOYU/IvcYi15gkuwL7YvXm/toLDI6dCAgABQKqA=
Date: Thu, 4 Jan 2024 06:49:12 +0000
Message-ID: <a512f1a513b747058ef972aef872c2b0@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
	<20240101190855.18739-8-darinzon@amazon.com>
 <20240103180035.1fc5e68a@kernel.org>
In-Reply-To: <20240103180035.1fc5e68a@kernel.org>
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
Precedence: Bulk

> On Mon, 1 Jan 2024 19:08:51 +0000 darinzon@amazon.com wrote:
> > -     xdp_work_done =3D ena_clean_xdp_irq(tx_ring, xdp_budget);
> > +     work_done =3D ena_clean_xdp_irq(tx_ring, budget);
>=20
> Not related to this series, but please make sure that if budget is
> 0 you do *no* XDP processing, Rx or Tx. XDP expects to run in softirq
> context, when budget is 0 we may be in hard IRQ.

Thank you for the feedback, Jakub, we will look into it and will make the n=
eeded changes.

