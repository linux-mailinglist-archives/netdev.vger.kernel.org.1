Return-Path: <netdev+bounces-131124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC698CD26
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411191F24AD0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B3413D886;
	Wed,  2 Oct 2024 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i7euPOG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C4132121;
	Wed,  2 Oct 2024 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850533; cv=none; b=GEOP6I98r3rSRjGm3W0yHZNqpslk/FCEZibIdT5omThy13flj5nEI3m2kbh6ocXOm5CwBTHvdk2tJXMR6QoJKgWgMlhxZNHTOfojXPs79BN7LnoNEA3iZgB0i+rp9BcNDfp9yrRyWoZqraSeJn7FSJs3fFAP9E0Ue3wUpl0G8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850533; c=relaxed/simple;
	bh=6PsboZH4jrExvAYOWUCWkhTrtjl3MUH1RgwITbEi87A=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNRCLXpnGEdsLVxatMliNcXVWip+qDw29Gasod1DFQn6x4jjL7enAHnLIHqtjIRFRs1S6TZRK6iIgJO9OfPReNoj7uuVLKA7GJ+9G3zK4C+RX73StRr/Th43mb+qmVVe6RHv93jTa5OxOo3a4Njji2sA90rB9p/RmWJxWBwDkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i7euPOG7; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727850532; x=1759386532;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=DHZZdTDuJaMBsZPiUY2eCanX8xuPCC1Ze2nBIGSUn4g=;
  b=i7euPOG7S/XN/hDYQfoOJ7CAhStxjRSnVXcK6OBlTs17RCzSzOhbCAdT
   TukQN9KaCXHye8Ej2iOx+EwhXVa8aWTbZN+1qa2X3Ah+7h0hQlXRQsGEW
   zxWu1tZAnbIalc29UTMzuJcZA4j1RDvau6lqVEU0miOBZWkVyd9DqUDha
   g=;
X-IronPort-AV: E=Sophos;i="6.11,170,1725321600"; 
   d="scan'208";a="338458485"
Subject: RE: [net-next v2 0/2] ena: Link IRQs, queues, and NAPI instances
Thread-Topic: [net-next v2 0/2] ena: Link IRQs, queues, and NAPI instances
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 06:28:50 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:55017]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.19:2525] with esmtp (Farcaster)
 id 9fdce243-32b5-4caa-b3c7-e58e62986ac4; Wed, 2 Oct 2024 06:28:49 +0000 (UTC)
X-Farcaster-Flow-ID: 9fdce243-32b5-4caa-b3c7-e58e62986ac4
Received: from EX19D017EUA001.ant.amazon.com (10.252.50.71) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 06:28:49 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D017EUA001.ant.amazon.com (10.252.50.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 06:28:48 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Wed, 2 Oct 2024 06:28:48 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kiyanovski, Arthur" <akiyano@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Kamal Heib <kheib@redhat.com>, open list
	<linux-kernel@vger.kernel.org>, "Dagan, Noam" <ndagan@amazon.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>
Thread-Index: AQHbFGLmz3MLE84IBkmgoCIKYGfJLbJy/8ig
Date: Wed, 2 Oct 2024 06:28:48 +0000
Message-ID: <3ca2ee862356426e84b840db94496581@amazon.com>
References: <20241002001331.65444-1-jdamato@fastly.com>
In-Reply-To: <20241002001331.65444-1-jdamato@fastly.com>
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


> Greetings:
>=20
> Welcome to v2. This includes only cosmetic changes, see changelog below
> and in each patch.
>=20
> This series uses the netdev-genl API to link IRQs and queues to NAPI IDs =
so
> that this information is queryable by user apps. This is particularly use=
ful for
> epoll-based busy polling apps which rely on having access to the NAPI ID.
>=20
> I've tested these commits on an EC2 instance with an ENA NIC configured
> and have included test output in the commit messages for each patch
> showing how to query the information.
>=20
> I noted in the implementation that the driver requests an IRQ for
> management purposes which does not have an associated NAPI. I tried to
> take this into account in patch 1, but would appreciate if ENA maintainer=
s can
> verify I did this correctly.
>=20
> Thanks,
> Joe
>=20
> v2:
>   - Preserve reverse christmas tree ordering in patch 1
>   - Add comment that the API is for non-XDP queues only to patch 2
>=20
> v1:
>   - https://lore.kernel.org/all/20240930195617.37369-1-jdamato@fastly.com=
/
>=20
> Joe Damato (2):
>   ena: Link IRQs to NAPI instances
>   ena: Link queues to NAPIs
>=20
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 40
> +++++++++++++++++---
>  1 file changed, 35 insertions(+), 5 deletions(-)
>=20
> --
> 2.25.1

Thanks!

Reviewed-by: David Arinzon <darinzon@amazon.com>

