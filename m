Return-Path: <netdev+bounces-151124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2769ECE88
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1031C2881CC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566F1632D3;
	Wed, 11 Dec 2024 14:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645B13B5AE
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927293; cv=none; b=hSFTTFKG3Us/4j3o0x7AzWGMf8e6rFXMkxoGv5xNSolCM+aRVSm5lJy+gLspckLMIuuFkepuL91Pz4JtBX8zN+0ISavXN/Gk3gMrtqQ1OrnCDmppk/mj20j5ixnINFmGt5tasB5zVLH2Ob+FBD6ZxO53l+8WzTQk/GKJ+Fbdn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927293; c=relaxed/simple;
	bh=vZm8wqgAUBOU98ZcY9DFM36NbQKEJJmDBbmKrsp7uP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=A+5h9uW1zjRUsueQ4uWQSPeNflvmdt33n/sPDd5LYo1CJ175kQe+GEU+p9yVA2oXmWnaOA5jqrjND8+5h1Kx2KamZlI/y0lLx6bvqDVZoIn6V2CfFqVSeZI8fRM8+KGvbIHi4AThsHqtQZB4cAiW1dmlf7kBlLiTQ1c/ZstMTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-180-kvDOsJoePeqsun-I2cNqYA-1; Wed, 11 Dec 2024 14:28:02 +0000
X-MC-Unique: kvDOsJoePeqsun-I2cNqYA-1
X-Mimecast-MFC-AGG-ID: kvDOsJoePeqsun-I2cNqYA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 11 Dec
 2024 14:27:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 11 Dec 2024 14:27:06 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@linaro.org>, Julian Anastasov <ja@ssi.bg>
CC: Simon Horman <horms@verge.net.au>, Pablo Neira Ayuso
	<pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bartosz
 Golaszewski" <brgl@bgdev.pl>
Subject: RE: [PATCH net] ipvs: Fix clamp() order in ip_vs_conn_init()
Thread-Topic: [PATCH net] ipvs: Fix clamp() order in ip_vs_conn_init()
Thread-Index: AQHbS87HyUWvGwHJmEucDmUDdXdiT7LhGMUg
Date: Wed, 11 Dec 2024 14:27:06 +0000
Message-ID: <7e01a62a5cb4435198f13be27c19de26@AcuMS.aculab.com>
References: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
In-Reply-To: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
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
X-Mimecast-MFC-PROC-ID: bqpC4toSBVx4sqDw2XTPfiLqEa4KIgR1O5yLqI5nGy0_1733927281
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Dan Carpenter
> Sent: 11 December 2024 13:17
>=20
> We recently added some build time asserts to detect incorrect calls to
> clamp and it detected this bug which breaks the build.  The variable
> in this clamp is "max_avail" and it should be the first argument.  The
> code currently is the equivalent to max =3D max(max_avail, max).

The fix is correct but the description above is wrong.
When run max_avail is always larger than min so the result is correct.
But the compiler does some constant propagation (for something that
can't happen) and wants to calculate the constant 'clamp(max, min, 0)'
Both max and min are known values so the build assert trips.

I posted the same patch (with a different message) last week.

=09David

>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes:
> https://lore.kernel.org/all/CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3=
f6ke0g@mail.gmail.com/
> Fixes: 4f325e26277b ("ipvs: dynamically limit the connection hash table")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I've been trying to add stable CC's to my commits but I'm not sure the
> netdev policy on this.  Do you prefer to add them yourself?
>=20
>  net/netfilter/ipvs/ip_vs_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_c=
onn.c
> index 98d7dbe3d787..9f75ac801301 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1495,7 +1495,7 @@ int __init ip_vs_conn_init(void)
>  =09max_avail -=3D 2;=09=09/* ~4 in hash row */
>  =09max_avail -=3D 1;=09=09/* IPVS up to 1/2 of mem */
>  =09max_avail -=3D order_base_2(sizeof(struct ip_vs_conn));
> -=09max =3D clamp(max, min, max_avail);
> +=09max =3D clamp(max_avail, min, max);
>  =09ip_vs_conn_tab_bits =3D clamp_val(ip_vs_conn_tab_bits, min, max);
>  =09ip_vs_conn_tab_size =3D 1 << ip_vs_conn_tab_bits;
>  =09ip_vs_conn_tab_mask =3D ip_vs_conn_tab_size - 1;
> --
> 2.45.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


