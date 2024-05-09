Return-Path: <netdev+bounces-94811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57D8C0BF2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5298CB22583
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1113D270;
	Thu,  9 May 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oZFh6O7g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A986130AC3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715239561; cv=none; b=BdaOjnwVERY7A3cChD+wq+2i8FqytUa0g0x0SCvho8P28/NWYfnNxdOoDtyT7jkZAZwwH+NzWBv5UpKNYVCPNdfHMuXe8KjGF0EmdsVYHdGg4UE+OsV43bowgXCv0Gx05Y28MxB5eEGOF839kW0OrYu150jKxMtAzUyGCQNaHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715239561; c=relaxed/simple;
	bh=m3fAo1uBn3mEgniN3bkNH8aHV9C9poagXCBmnFK0ycg=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZd6p2KEF0UUVHn9A0zDjIN5xqKH0AJt9CblpQ0fZ1QLug/ecxi7IU6vRXGWxiRYyZjkRX3cIn7x6OamRal5Bxn0f4GQoa9gJIJJAD1wKgSLiCjzGAfVOOqsEYmFKsdH4tQE0cAzWMzGw8Urw2GI12683+beklG8nXUT2gZCHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oZFh6O7g; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715239561; x=1746775561;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=m3fAo1uBn3mEgniN3bkNH8aHV9C9poagXCBmnFK0ycg=;
  b=oZFh6O7gHmrKuPlnXjcLwvwQletnAshZHly3CXs4u5f2DEsXsSotcqAj
   KF0p4RKWBy+qGHrrI8hFR6zY7pGcaFPu3t2IfDxotrD1mQemjPSklN6Br
   svY91AfIysa8aeCboX/yt5uxNBoAsYM7AX9OUIGP7lLClnxzUnnNvqxj+
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,147,1712620800"; 
   d="scan'208";a="417921565"
Subject: RE: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt
 moderation update action
Thread-Topic: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt moderation
 update action
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 07:25:56 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:11420]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.3.195:2525] with esmtp (Farcaster)
 id 86c56f8f-428f-4c0c-970d-a23672c022a6; Thu, 9 May 2024 07:25:53 +0000 (UTC)
X-Farcaster-Flow-ID: 86c56f8f-428f-4c0c-970d-a23672c022a6
Received: from EX19D030EUB001.ant.amazon.com (10.252.61.82) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 9 May 2024 07:25:53 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB001.ant.amazon.com (10.252.61.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 9 May 2024 07:25:53 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.028; Thu, 9 May 2024 07:25:53 +0000
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
Thread-Index: AQHaoO/Zr9oRuuhlBkmrtZyc51nFsLGM0/hQgACkQICAAQm/4A==
Date: Thu, 9 May 2024 07:25:52 +0000
Message-ID: <7ac46cf3f626478d894da6b633f844b9@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
	<20240506070453.17054-7-darinzon@amazon.com>
	<20240507193111.5d24343c@kernel.org>
	<6f5415915976495f8252411c317aedbb@amazon.com>
 <20240508083317.62897ef1@kernel.org>
In-Reply-To: <20240508083317.62897ef1@kernel.org>
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

> > This is a true/false indicator, it doesn't require history/previous val=
ue to be considered.
> > Therefore, not sure I see the how |=3D can help us in the logic here.
> > The flag is set here to true if during the interrupt moderation
> > update, which is, in this flow, triggered by an ethtool operation, the
> > moderation value has changed from the currently configurated one.
>=20
> I couldn't locate an immediate application of the new value in the ethtoo=
l
> flow. So the question is whether the user can call update back to back, w=
ith
> the same settings. First time flag would be set and second time cleared.
>=20
> Also the whole thing appears to be devoid of locking or any consideration=
 of
> concurrency.

Hi Jakub,

I agree with your points, thank you for identifying them.
Will send a revised version of the logic in v2.

