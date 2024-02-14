Return-Path: <netdev+bounces-71619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1348543A7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 08:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2496283FAA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 07:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062B1170F;
	Wed, 14 Feb 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A1kgqvGF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F271119E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897123; cv=none; b=bxkYubBhedM6flzkPS7/qt39xgZHoNXQSpvY8cMGWdYJkqyCTdpqe0jQzbzDrTr2jDbbuE8faN4V6nK5JQHHgleVpNOoaAZffhykV6Vz+x8CTWwOf8kOyRkaI9R3j/wKW12Ko12B8h8YUQU413wtTNx4O6WICgD1a+YY9NpTdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897123; c=relaxed/simple;
	bh=xqGBoNl3I3DqSmzRKcjpZN+vdg3osNa7ZgO3nQ3XSQw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I4Lqm6XHDh6CMM8bDEwD7K4yRnOAg0HNByHPxH0mtkFaDCTBoqnCg9j/xKkdpWHC/NVdNYoW0Voa6BxN6+II46M0lh+9pu4KTo9yE/bcb4zDJnnAGGAG/rEpoZAk8CF2Al78tb7ctZ4/n2I+LX4PRwhZCsCZFsvyqfR2ATrt/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A1kgqvGF; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707897122; x=1739433122;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=3cRKFO7OP/+nmMzVI9rZPckb9qtsS9TF8i3vOjd+4bA=;
  b=A1kgqvGFgSyQwBxuZIpWbxVQIE5oi+79oHNsRT2/Juh9LpOjeHw3QQYs
   Jh5U2QYFmM82wFSBg6Rj6/n7xjD34ITWhuZKY4kxUWEadWluCln7S6uui
   S5vnUZeAzhagR2SrrGLTUdHgKcDSWHScQugiDgzeW9EnkkKR1KSp2oCe7
   E=;
X-IronPort-AV: E=Sophos;i="6.06,159,1705363200"; 
   d="scan'208";a="634125095"
Subject: RE: [PATCH net-next] net: ena: Remove unlikely() from IS_ERR() condition
Thread-Topic: [PATCH net-next] net: ena: Remove unlikely() from IS_ERR() condition
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:52:00 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:39050]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.31:2525] with esmtp (Farcaster)
 id 2ac74a54-80af-45b8-aa3f-aa49db72f7ab; Wed, 14 Feb 2024 07:51:59 +0000 (UTC)
X-Farcaster-Flow-ID: 2ac74a54-80af-45b8-aa3f-aa49db72f7ab
Received: from EX19D047EUA003.ant.amazon.com (10.252.50.160) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 07:51:58 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D047EUA003.ant.amazon.com (10.252.50.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 07:51:58 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.040; Wed, 14 Feb 2024 07:51:58 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Kamal Heib <kheib@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>
CC: "Agroskin, Shay" <shayagr@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>
Thread-Index: AQHaXpgGsVv2ybtfrECKHTF+emSQNbEJd1Fw
Date: Wed, 14 Feb 2024 07:51:46 +0000
Deferred-Delivery: Wed, 14 Feb 2024 07:51:33 +0000
Message-ID: <eeb88c77389d4c51b3b35924e3fe8e4d@amazon.com>
References: <20240213161502.2297048-1-kheib@redhat.com>
In-Reply-To: <20240213161502.2297048-1-kheib@redhat.com>
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



> -----Original Message-----
> From: Kamal Heib <kheib@redhat.com>
> Sent: Tuesday, February 13, 2024 6:15 PM
> To: netdev@vger.kernel.org; David S . Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>
> Cc: Agroskin, Shay <shayagr@amazon.com>; Arinzon, David
> <darinzon@amazon.com>; Kamal Heib <kheib@redhat.com>
> Subject: [EXTERNAL] [PATCH net-next] net: ena: Remove unlikely() from
> IS_ERR() condition
>=20
>=20
>=20
> IS_ERR() is already using unlikely internally.
>=20
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 03be2c008c4d..10e70d869cce 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -545,7 +545,7 @@ static int ena_alloc_rx_buffer(struct ena_ring
> *rx_ring,
>=20
>         /* We handle DMA here */
>         page =3D ena_alloc_map_page(rx_ring, &dma);
> -       if (unlikely(IS_ERR(page)))
> +       if (IS_ERR(page))
>                 return PTR_ERR(page);
>=20
>         netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
> --
> 2.43.0
>=20

Thanks for submitting this patch.

Acked-by: Arthur Kiyanovski <akiyano@amazon.com>

