Return-Path: <netdev+bounces-177084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FFA6DCC4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275EF1890FEC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DC25F7BE;
	Mon, 24 Mar 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p5LtoI5q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A125DAF7
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825900; cv=none; b=tlBojHMEMPaEfzekfv27Mj+Nsx2daAiDdrMm26SD3d2Zp3N6aE1HZXOqjBkQoYzsCpgyXTcl3Wr/WCf58glxAttgxDmQlYn32Gxi7OtR5IWE1uwBdvqUdXkyjE0m6JonlKMqA6u9LAPuVZJNCi5C7BRH1okpT9i4na4x894EBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825900; c=relaxed/simple;
	bh=w7AiCJEovNS51vP+s/ylXjk8R6u4vH6S2IHQoxU+3z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6XJN2heNgSxwnMRro4yDdH5KMWn2DQ2YcdjX2rR7PagWESsCB99vyy7Vm3IUzCykuFgMvN9JpVwA6GwVDunakZwiI/se6ltA0rJAhJ1lYAPm6FeVGkBnVL5YKW1hxJSl8hXPqrqOLg4W3B9B76DX8YuM6eMgkCV6/2TYzfde+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p5LtoI5q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wr61wG5gGFMP0iMfqIz9bScXDKcyIXQbv3cGXrGFgxM=; b=p5LtoI5qvVS9dmRTJnpArEH8nU
	CXhqCkAuTGSIpAERlm40hcpR+CaemeKieTXGUnacJtZv8tWIeNCxmXVqMXxvjNqEjim1b1INlmGVN
	kptyaXF2rFACaDnnjMmJEEJyJB/aRwsatm+fn3CSYq8yiRX32nhrGU+nkl/3USCDNAeE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1twid5-006wYz-Lq; Mon, 24 Mar 2025 15:18:15 +0100
Date: Mon, 24 Mar 2025 15:18:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: Re: [PATCH net] net: page_pool: replace ASSERT_RTNL() in
 page_pool_init()
Message-ID: <85f2a226-4dd3-4ad0-afb4-351ce2487961@lunn.ch>
References: <20250324014639.4105332-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324014639.4105332-1-dw@davidwei.uk>

On Sun, Mar 23, 2025 at 06:46:39PM -0700, David Wei wrote:
> Replace a stray ASSERT_RTNL() in page_pool_init() with
> netdev_assert_locked().
> 
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f5e908c9e7ad..2f469b02ea31 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -281,7 +281,7 @@ static int page_pool_init(struct page_pool *pool,
>  		 * configuration doesn't change while we're initializing
>  		 * the page_pool.
>  		 */
> -		ASSERT_RTNL();
> +		netdev_assert_locked(params->netdev);

Adding a bit more context:

        if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
                /* We rely on rtnl_lock()ing to make sure netdev_rx_queue
                 * configuration doesn't change while we're initializing
                 * the page_pool.
                 */
                ASSERT_RTNL();

If ASSERT_RTNL() is now wrong, you also need to update the comment.

	Andrew

