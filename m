Return-Path: <netdev+bounces-220542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4AB4682B
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BC5188BA50
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D41A2541;
	Sat,  6 Sep 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Lev9zI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C04145B3E;
	Sat,  6 Sep 2025 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123529; cv=none; b=FklMd3QotPx4BfGJId4/TiKapGEEjPoO+ttSgwK5ZaEWIIl927wtykRr9eFIgIsIlsMUrlp51jLj6KB6xx5z//wwA3x/x5PdrGSo3ujG6yLtmPvwXKr8EHobgdRfDT/REL22tsK4jMMsY0T2L2MANP3PVGbzjJ++BaM9ZkV+xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123529; c=relaxed/simple;
	bh=lySDGQWj6qUS+o4mHexQMNNHLkSb8cMHhkUZYO3v+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxNp2HON32jSOZ500xbyKNSBN8bY3XUeZE1PBe47deLz4tqQrDPuO3LRs3Lk+gDkC2SCJjNXY87pt5DoHYPoQRURSNHJWF5i5IghDkRAxwF+HjbM5dlQDuhEf9vDsloL9ZZoI6JYvNdE6v2EGKyWgook7HKl1Av+5eGlRbCywV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0Lev9zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98FBC4CEF1;
	Sat,  6 Sep 2025 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757123528;
	bh=lySDGQWj6qUS+o4mHexQMNNHLkSb8cMHhkUZYO3v+fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o0Lev9zI/KbNfGjVjFRnu3cANsAx7tZJ/z0jfln7Rv6San3G2/evEWlzLO6shK5rq
	 a5M6+Ci7WczpgKcCE8Pc4SDc05E+zfA2A4OHldaOfYdZIUioXw/u0HqD7Pzj6zGY1J
	 rV5XX3Dk4rpiqyuju0qUyTyyG66/CXkdHOK4s8mSIaT4To0RmM1udVGiI8tIPJvlo3
	 bm+/yl9MlxQ7QUzzYM6Hyt8C8YWyU8bXIvOLz06LC1jSSFqPTegxaFg43zsfLTyiO5
	 MiOkF6hoFLRp9aJ8IEY7Sp5w55MMLZiopXE78YooLreXnf2WxKAj58BPR8x5kjS20O
	 0cEb/LpOO/A0w==
Date: Fri, 5 Sep 2025 18:52:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 net-next 2/5] net: fec: add pagepool_order to support
 variable page size
Message-ID: <20250905185207.2285900d@kernel.org>
In-Reply-To: <20250904203502.403058-3-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
	<20250904203502.403058-3-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 15:34:59 -0500 Shenwei Wang wrote:
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 5a21000aca59..f046d32a62fb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1780,7 +1780,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	 * These get messed up if we get called due to a busy condition.
>  	 */
>  	bdp = rxq->bd.cur;
> -	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
> +	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);

please drop the unnecessary parenthesis, and 

>  	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
>  
> @@ -1850,7 +1850,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		 * include that when passing upstream as it messes up
>  		 * bridging applications.
>  		 */
> -		skb = build_skb(page_address(page), PAGE_SIZE);
> +		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));

wrap the lines at 80 chars

