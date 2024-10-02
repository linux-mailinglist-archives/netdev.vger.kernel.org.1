Return-Path: <netdev+bounces-131123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D083C98CD22
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116DFB22901
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6984D0E;
	Wed,  2 Oct 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GtQL/Y6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17682C6A3;
	Wed,  2 Oct 2024 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850505; cv=none; b=czTPBeG9T6kFMquME4NwPXbn9g5TrHphj5L/TPC0RdL/yaquxdNRaGEz4DavW32lnWPk5T8HiumZiWiQqzBl4CUL3vYhK+tQLy6kqLKu2EIe1L2/iogUDp31yfHaZacd1VD0Frr+7gGn/ZQNkmQ9Pk+EXmcixXNok5I0GLkTLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850505; c=relaxed/simple;
	bh=kUvpKH/3pkDYrcbqehTtg7/VCDaQLbuunBCPnBBxNyQ=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqtfOB+GBU5fx/3bjTIelNshsmCQ3ymPe+QGsF9dbJe59IBCW/dCi3sAt5rlTk7VP4NZgInkudzQYHb7MRVh9nxnIoit74Bd/X/YRz30APUnq8m4iX3BXZrUmSoEIgX+pS/r7754GTOybvZgdlULU23R6FDvaKyNreq1rcT1Flg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GtQL/Y6b; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727850504; x=1759386504;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Nlqt4WLzmSJ1dcgCFyoLYomtBOQiyIeTiQiPTe1ttys=;
  b=GtQL/Y6bGRomZUVvgWtQ4aE6emSHe1hChQlKqPRKJBqZrEbU0ssKXZ2a
   /Y312OPDv063cJhE46I6AqgpiF/CwOWhrlB3yHyzZi6ueYevqRORp6J62
   0oWCpcjXWh3B4y1KZZjbCbCH2i3wEKfe9Un3EJEBgHO0KORXOT6aeBLlx
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,170,1725321600"; 
   d="scan'208";a="431892595"
Subject: RE: [net-next v2 2/2] ena: Link queues to NAPIs
Thread-Topic: [net-next v2 2/2] ena: Link queues to NAPIs
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 06:28:20 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:2370]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.81:2525] with esmtp (Farcaster)
 id aff0c92e-f9b7-47be-9589-488fae609935; Wed, 2 Oct 2024 06:28:18 +0000 (UTC)
X-Farcaster-Flow-ID: aff0c92e-f9b7-47be-9589-488fae609935
Received: from EX19D022EUA001.ant.amazon.com (10.252.50.125) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 06:28:18 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA001.ant.amazon.com (10.252.50.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 06:28:18 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Wed, 2 Oct 2024 06:28:18 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Agroskin, Shay" <shayagr@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kamal Heib <kheib@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHbFGLmbl7D4Bh7KUyry3U7daZxcrJy/6oQ
Date: Wed, 2 Oct 2024 06:28:18 +0000
Message-ID: <10bc83e9df17408a9f0dd7a56abc9dc1@amazon.com>
References: <20241002001331.65444-1-jdamato@fastly.com>
 <20241002001331.65444-3-jdamato@fastly.com>
In-Reply-To: <20241002001331.65444-3-jdamato@fastly.com>
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

> Link queues to NAPIs using the netdev-genl API so this information is
> queryable.
>=20
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
>=20
> [{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'rx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'rx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'rx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'tx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'tx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'tx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'tx'}]
>=20
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Comments added to ena_napi_disable_in_range and
>      ena_napi_enable_in_range
>    - No functional changes
>=20
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 28
> +++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 74ce9fa45cf8..96df20854eb9 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1821,20 +1821,40 @@ static void ena_napi_disable_in_range(struct
> ena_adapter *adapter,
>                                       int first_index,
>                                       int count)  {
> +       struct napi_struct *napi;
>         int i;
>=20
> -       for (i =3D first_index; i < first_index + count; i++)
> -               napi_disable(&adapter->ena_napi[i].napi);
> +       for (i =3D first_index; i < first_index + count; i++) {
> +               napi =3D &adapter->ena_napi[i].napi;
> +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> +                       /* This API is supported for non-XDP queues only =
*/
> +                       netif_queue_set_napi(adapter->netdev, i,
> +                                            NETDEV_QUEUE_TYPE_TX, NULL);
> +                       netif_queue_set_napi(adapter->netdev, i,
> +                                            NETDEV_QUEUE_TYPE_RX, NULL);
> +               }
> +               napi_disable(napi);
> +       }
>  }
>=20
>  static void ena_napi_enable_in_range(struct ena_adapter *adapter,
>                                      int first_index,
>                                      int count)  {
> +       struct napi_struct *napi;
>         int i;
>=20
> -       for (i =3D first_index; i < first_index + count; i++)
> -               napi_enable(&adapter->ena_napi[i].napi);
> +       for (i =3D first_index; i < first_index + count; i++) {
> +               napi =3D &adapter->ena_napi[i].napi;
> +               napi_enable(napi);
> +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> +                       /* This API is supported for non-XDP queues only =
*/
> +                       netif_queue_set_napi(adapter->netdev, i,
> +                                            NETDEV_QUEUE_TYPE_RX, napi);
> +                       netif_queue_set_napi(adapter->netdev, i,
> +                                            NETDEV_QUEUE_TYPE_TX, napi);
> +               }
> +       }
>  }
>=20
>  /* Configure the Rx forwarding */
> --
> 2.25.1

LGTM

Reviewed-by: David Arinzon <darinzon@amazon.com>

