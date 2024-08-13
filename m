Return-Path: <netdev+bounces-118001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89E950399
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982F61F23E72
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E451198A2F;
	Tue, 13 Aug 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bnpUmSwQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514D190470
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548594; cv=none; b=IyiOD9PBhfHhmyofEww/xSk3uZ8r10QR+9dZGpuZ3wNlwil8qsOM2l8O+lM7VTWyloGotAU5zrIw8tBCjNHhXZKHiHbEpIJXqp+BoId51aVF2TUeJlvV4m8jbLF92GCdySplX0Ypx3aLzZLcSeI6aZGv4tFjEyh6USfhKh8WhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548594; c=relaxed/simple;
	bh=/O1FKAxLPEu2VcuB5Q2wa3MfhJjlJHZshjL+zaIPa2k=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5EwzcUQk6J7Um8KGS2xz2jzxqVQr32TQ3mdVxXwyV9xkwLaLhw0JNpVuR8HKk0Q8bAapCEaLeqoGTqufQc/OowgIMYhGMrpS9GNIb6c6Xn1l9mrVAAkAh9OAuVsHLdv/yeXHxszQEZFRs/2667BtPtkmybfrwVnWtVJv2JNnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bnpUmSwQ; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723548592; x=1755084592;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=E4KIIi9Stwl0jGLhkEbRA8d9Vd6GglhBSz3KhqMuwjw=;
  b=bnpUmSwQyqxVgkvtxSwY+QXN3GP7IiFT2G9pDbrfvx+LMtuCuQXB1v1V
   vSuetVnWcMLI097epTYFj2mCYKgLJiCywmAvkLbOxEgPpX0hjKXvpDsGH
   4Duh33ZmAgxIBY0Qe87cuCyWI5CvaB5Rle8oAI/Q3wsTigOThSGAv1Kyd
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,285,1716249600"; 
   d="scan'208";a="115031054"
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting
 support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 11:29:52 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:42726]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.28:2525] with esmtp (Farcaster)
 id 3d6e314f-8471-4d7c-8998-42af7b169ac6; Tue, 13 Aug 2024 11:29:51 +0000 (UTC)
X-Farcaster-Flow-ID: 3d6e314f-8471-4d7c-8998-42af7b169ac6
Received: from EX19D028EUB002.ant.amazon.com (10.252.61.43) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 11:29:50 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB002.ant.amazon.com (10.252.61.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 11:29:50 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.034; Tue, 13 Aug 2024 11:29:50 +0000
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
Thread-Index: AQHa7SRj5VISt7WkiEq52al7KaOO2rIlC6Fw
Date: Tue, 13 Aug 2024 11:29:50 +0000
Message-ID: <9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
 <20240812185852.46940666@kernel.org>
In-Reply-To: <20240812185852.46940666@kernel.org>
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

> On Sun, 11 Aug 2024 13:07:11 +0300 David Arinzon wrote:
> > +     ENA_ADMIN_BW_IN_ALLOWANCE_EXCEEDED         =3D 0,
> > +     ENA_ADMIN_BW_OUT_ALLOWANCE_EXCEEDED        =3D 1,
> > +     ENA_ADMIN_PPS_ALLOWANCE_EXCEEDED           =3D 2,
> > +     ENA_ADMIN_CONNTRACK_ALLOWANCE_EXCEEDED     =3D 3,
> > +     ENA_ADMIN_LINKLOCAL_ALLOWANCE_EXCEEDED     =3D 4,
> > +     ENA_ADMIN_CONNTRACK_ALLOWANCE_AVAILABLE    =3D 5,
>=20
> We have similar stats in the standard "queue-capable" stats:
>=20
> https://docs.kernel.org/next/networking/netlink_spec/netdev.html#rx-hw-
> drop-ratelimits-uint
> https://docs.kernel.org/next/networking/netlink_spec/netdev.html#tx-hw-
> drop-ratelimits-uint
>=20
> they were added based on the virtio stats spec. They appear to map very
> neatly to the first stats you have. Drivers must report the stats via a c=
ommon
> API if one exists.
> --
> pw-bot: cr

Thank you for bringing this to our attention, Jakub.

I will note that this patch modifies the infrastructure/logic in which thes=
e stats are retrieved to allow expandability and flexibility of the interfa=
ce between the driver and the device (written in the commit message).
The top five (0 - 4) are already part of the upstream code and the last one=
 (5) is added in this patch.

The statistics discussed here and are exposed by ENA are not on a queue lev=
el but on an interface level, therefore, I am not sure that the ones pointe=
d out by you would be a good fit for us.

But in any case, would it be possible from your point of view to progress i=
n two paths, one would be this patchset with the addition of the new metric=
 and another would be to explore whether there are such stats on an interfa=
ce level that can be exposed?

Thanks,
David

