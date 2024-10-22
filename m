Return-Path: <netdev+bounces-137896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BAD9AB0B4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1978B2313F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0291A072A;
	Tue, 22 Oct 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c4TogT6B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FA19D060
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606921; cv=none; b=WU0uBLKxlW9YFlrKpulX6Cygm5lEvW1FsnUEbKmKg29J3HMCW0ZO6GfU5uSq5B1aOggdkArHYa/GTvOsjcJYntAHOam304lPPyV059MecpEEua8I0NdlzYjXCcHKCt8zlJrSP+5CoRuBtAgsuWYCn5y61xyg9VbJKXI4If0Go4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606921; c=relaxed/simple;
	bh=GWBC6LuThuKXO7C/FoUYH7ORe0m+DdAelIXGBflxS/c=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUe9tHl2rst40tIRE16XcSqVzyDOHxM987BNsQMpmgRfA9pDFq+ThJgVpGtxvLYBgJUDR9rb5G1FytVYlY1vwmTEiLypGrvftUlZ0t9E2/BLIBF763O8NJvKj1qA5hpXCRjKXPfE8AUdaJaplfMUku/L3PflE5VxHwMfRUqGQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c4TogT6B; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729606920; x=1761142920;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=vRDqs0taNTOyWCgtDD8wgVuViY/PROuFC8vYwxJ2f7Y=;
  b=c4TogT6BvZkKobZkHeAHg4hKeU5l3sJvV7s7mA0EvQDV8k3Gv/jLW2vD
   4WZNPpMrJ/OyIWO7dAcaztHEHdtSZqrTQ1WTIh7r9ZGDKzkeq462QiK4b
   hx+HecU3I8EKLaIUjxwVRg5MpKNve4Vt+h3hkrdF+eX1YMkk9qZlUBaMw
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="241441141"
Subject: RE: [PATCH v1 net-next 0/3] PHC support in ENA driver
Thread-Topic: [PATCH v1 net-next 0/3] PHC support in ENA driver
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 14:21:53 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:19090]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.171:2525] with esmtp (Farcaster)
 id e1ea76f2-1da9-4132-9c18-f76455baa511; Tue, 22 Oct 2024 14:21:52 +0000 (UTC)
X-Farcaster-Flow-ID: e1ea76f2-1da9-4132-9c18-f76455baa511
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:21:52 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 22 Oct 2024 14:21:52 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 22 Oct 2024 14:21:52 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbI3juB2QkHj71fkKLdcQlFPb6DLKRYMkAgAFzggA=
Date: Tue, 22 Oct 2024 14:21:51 +0000
Message-ID: <5e5b4202280a4306a2d5c3847c6706bd@amazon.com>
References: <20241021052011.591-1-darinzon@amazon.com>
 <1e127d15-2826-496a-8834-cd98861eabb3@lunn.ch>
In-Reply-To: <1e127d15-2826-496a-8834-cd98861eabb3@lunn.ch>
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

> > This patchset adds the support for PHC (PTP Hardware Clock) in the ENA
> > driver. The documentation part of the patchset includes additional
> > information, including statistics, utilization and invocation examples
> > through the testptp utility.
>=20
> I _think_ you missed Cc: the PTP Maintainer, although he could be hiding
> somewhere in that long list of Amazon people. Do they all need Cc:ing?
>=20
>         Andrew

Thanks Andrew,
I will identify and add the relevant maintainers to the next patchset

