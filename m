Return-Path: <netdev+bounces-130777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395198B7E4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F9F1F22919
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B00919B587;
	Tue,  1 Oct 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T21ZzR/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA384594C;
	Tue,  1 Oct 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773583; cv=none; b=spa2sOO4uHTkcIU7gkRCJAXSxb5mFhboxUXlIsjqd/SJvxg7oFTmkppfweaBupxVTzqMf/cPniW8HHXAW/qYBN13BGwbfowQvFuy8K3mpbHMxVRTB9JvgWGJDG3paksbOi24y90tjTNs+O9fqmSGtxph1VxAuZJqsYQML77r5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773583; c=relaxed/simple;
	bh=oPiIYp4JekqEhzJN+y9M7tkZJZObfmvAT3QnLK9Z5Lc=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIn/sJYNgKuJMTZhsEsvX0lv4b+L4F7vl/gg0NNvi9Qfo42XdzDGwIH26wz6sG/D10elplYS/CJSk3OC1fzExouIJnU4AGUNaP/ai4Z/0uqKzPv+l6/isRhflGztFh4eaxHglAmdyITxov0DIjndAGGNkTBBZ9pqAhwGL7+NAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T21ZzR/v; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727773581; x=1759309581;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=+dogXWhFxVkHe7FI5agVHowCHyKBeUqTNwxtykk12D0=;
  b=T21ZzR/vtDoUQgIcyA0RLU2QeCxXBgW6r0/3fKwRpHvAdETVh1QkOpRK
   EWHnhGAN+Aj7RqV9rTn6q/BXzYeK811Rf0o4VNElEAexpvSFZTs+EiU0o
   y10owRMEoiDQ+GzU8ZBsxG1Can1NXpm5dIvpsahSl9EqfYgc15PyZ+CXQ
   E=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="133396868"
Subject: RE: [net-next 2/2] ena: Link queues to NAPIs
Thread-Topic: [net-next 2/2] ena: Link queues to NAPIs
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:06:18 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:10479]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.93:2525] with esmtp (Farcaster)
 id a6769dc4-c9ef-4373-8346-2e39b6b9a470; Tue, 1 Oct 2024 09:06:17 +0000 (UTC)
X-Farcaster-Flow-ID: a6769dc4-c9ef-4373-8346-2e39b6b9a470
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 09:06:16 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 09:06:16 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 1 Oct 2024 09:06:16 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Agroskin, Shay" <shayagr@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kamal Heib <kheib@redhat.com>, open list
	<linux-kernel@vger.kernel.org>, "Bernstein, Amit" <amitbern@amazon.com>
Thread-Index: AQHbE3LvonMH5qZYjUqecQ4N60GeD7Jxkpvg
Date: Tue, 1 Oct 2024 09:06:16 +0000
Message-ID: <eb828dd9f65847a49eb64763740c84ff@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-3-jdamato@fastly.com>
In-Reply-To: <20240930195617.37369-3-jdamato@fastly.com>
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
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 26
> +++++++++++++++++---
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index e88de5e426ef..1c59aedaa5d5 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1821,20 +1821,38 @@ static void ena_napi_disable_in_range(struct
> ena_adapter *adapter,
>                                       int first_index,
>                                       int count)  {
> +       struct napi_struct *napi;

Is this variable necessary? It has been defined in the enable function beca=
use
it is needed in netif_queue_set_napi() API as well as in napi_enable(),
and it makes sense in order to avoid long lines
In here, the variable is only used in a call to napi_disable(), can the cod=
e
be kept as it is? don't see a need to shorten the napi_disable() call line.

>         int i;
>=20
> -       for (i =3D first_index; i < first_index + count; i++)
> -               napi_disable(&adapter->ena_napi[i].napi);
> +       for (i =3D first_index; i < first_index + count; i++) {
> +               napi =3D &adapter->ena_napi[i].napi;
> +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
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

Can you share some info on why you decided to set the queue to napi associa=
tion
only in non-xdp case?
In XDP, there's a napi poll function that's executed and it runs on the TX =
queue.
I am assuming that it's because XDP is not yet supported in the framework? =
If so,
there's a need to add an explicit comment above if (!ENA_IS_XDP_INDEX(adapt=
er, i)) {
explaining this in order to avoid confusion with the rest of the code.

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
> 2.43.0

Thank you for uploading this patch.


