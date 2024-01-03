Return-Path: <netdev+bounces-61114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6328228B8
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 08:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741B6B20CD3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D660179B5;
	Wed,  3 Jan 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pPwL0Nn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39517998
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704265688; x=1735801688;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=yde+/HbsP5zoZpuvPvW+OPMwZiIhqUx5y58nSH1JfcU=;
  b=pPwL0Nn4YCnzWXGSkp4Lh3bxin6ETOWk4WjWlTFx/BYtEuNlaaamwkbu
   Sfj6YnCfIMfQf4kWvibdQYLcknxqgteC3gxCOPl2os9xgmbMk5DPfw3V/
   gt0M/kkWQCERddxxvV4E917ZSs0J7MucYfWmoIa7LoAIUtJZurqUvMPPe
   k=;
X-IronPort-AV: E=Sophos;i="6.04,327,1695686400"; 
   d="scan'208";a="628928861"
Subject: RE: [PATCH v2 net-next 00/11] ENA driver XDP changes
Thread-Topic: [PATCH v2 net-next 00/11] ENA driver XDP changes
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 07:08:05 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 4C74241065;
	Wed,  3 Jan 2024 07:08:04 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:11015]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.199:2525] with esmtp (Farcaster)
 id e6d1a9ea-4212-4988-9e97-df4de4ff51cf; Wed, 3 Jan 2024 07:08:03 +0000 (UTC)
X-Farcaster-Flow-ID: e6d1a9ea-4212-4988-9e97-df4de4ff51cf
Received: from EX19D038EUB001.ant.amazon.com (10.252.61.115) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 07:08:02 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D038EUB001.ant.amazon.com (10.252.61.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 07:08:02 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Wed, 3 Jan 2024 07:08:02 +0000
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
Thread-Index: AQHaPOX6kFpIl8PmHUCtjuX0rjh3ErDG03qAgADYXEA=
Date: Wed, 3 Jan 2024 07:08:02 +0000
Message-ID: <c26e254e84f044adbd3c1e5fd364501a@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
 <20240102100807.63f24fa3@kernel.org>
In-Reply-To: <20240102100807.63f24fa3@kernel.org>
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

> On Mon, 1 Jan 2024 19:08:44 +0000 darinzon@amazon.com wrote:
> > Changes in v2:
> > - Moved changes to right commits in order to avoid compilation errors
>=20
> Please read:
>=20
> https://www.kernel.org/doc/html/next/process/maintainer-
> netdev.html#tl-dr
> --
> pv-bot: 24h

Apologies, I've noticed the failures in patchwork and decided to act quickl=
y.
Thank you for the guidelines link.

Shall I resend v3 after the waiting time?


