Return-Path: <netdev+bounces-88471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1B8A759D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232D22816D6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3899B17736;
	Tue, 16 Apr 2024 20:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DF1C10
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299447; cv=none; b=l0Unu3J9WMRmIEtjYKGU7ynC30F5AomJznEw3zpA0O+hsDpuA4RYM9CUkvkeoMBjk5pktbANicnL8AFpob7/30EmVYVGTJLigz8N3D32ruCde0jhRVmmwHzHyLUdGxa+UVSY8ah3NddzBYnxZogCl1XaoPuZ79GNucOa3pdxoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299447; c=relaxed/simple;
	bh=h/n4eJPOVICv/hY2u08FJM37LeU7IIAeDUAWVXwM9e8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MwEv0VM1l/O67sY8aSxnWbWHKH9vqlCWbB0wTMab10tuAWT4APp6TlyVqUQets8ni7JHJ3ELlLmcA8dbjqZeMaHXWhxOjTI/m6ZpZ0kR1ygVNZlqMuEqQPsr0DoG3ZRU8bo2RuCDvmFnJu7eJOA1qxprLySkj1TXd4/el8kpgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-283-8fUyrjDEOg2_iWv6kXj3eA-1; Tue, 16 Apr 2024 21:30:38 +0100
X-MC-Unique: 8fUyrjDEOg2_iWv6kXj3eA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Apr
 2024 21:30:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Apr 2024 21:30:09 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Aurelien Aptel' <aaptel@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de"
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com"
	<axboe@fb.com>, "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, "smalin@nvidia.com"
	<smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
	"ogerlitz@nvidia.com" <ogerlitz@nvidia.com>, "yorayz@nvidia.com"
	<yorayz@nvidia.com>, "borisp@nvidia.com" <borisp@nvidia.com>,
	"galshalom@nvidia.com" <galshalom@nvidia.com>, "mgurtovoy@nvidia.com"
	<mgurtovoy@nvidia.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct
 data placement
Thread-Topic: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct
 data placement
Thread-Index: AQHaho0hnJcov98wd0yhfxeOP2ZlzrFra/Yw
Date: Tue, 16 Apr 2024 20:30:09 +0000
Message-ID: <a779982fc59f4b9b94d619d0bb111738@AcuMS.aculab.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-4-aaptel@nvidia.com>
In-Reply-To: <20240404123717.11857-4-aaptel@nvidia.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Aurelien Aptel
> Sent: 04 April 2024 13:37
>=20
> From: Ben Ben-Ishay <benishay@nvidia.com>
>=20
> When using direct data placement (DDP) the NIC could write the payload
> directly into the destination buffer and constructs SKBs such that
> they point to this data. To skip copies when SKB data already resides
> in the destination buffer we check if (src =3D=3D dst), and skip the copy
> when it's true.
...
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 4a6a9f419bd7..a85125485174 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -62,7 +62,14 @@ static __always_inline
>  size_t memcpy_to_iter(void *iter_to, size_t progress,
>  =09=09      size_t len, void *from, void *priv2)
>  {
> -=09memcpy(iter_to, from + progress, len);
> +=09/*
> +=09 * When using direct data placement (DDP) the hardware writes
> +=09 * data directly to the destination buffer, and constructs
> +=09 * IOVs such that they point to this data.
> +=09 * Thus, when the src =3D=3D dst we skip the memcpy.
> +=09 */
> +=09if (iter_to !=3D from + progress)
> +=09=09memcpy(iter_to, from + progress, len);

How must does this conditional cost for the normal case
when it is true?
I suspect it is mispredicted 50% of the time.
So, while it may speed up your test, the overall system
impact will be negative.

=09David

>  =09return 0;
>  }
>=20
> --
> 2.34.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


