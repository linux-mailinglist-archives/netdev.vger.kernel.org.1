Return-Path: <netdev+bounces-47118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF37E7D50
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F205281330
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77651C6A4;
	Fri, 10 Nov 2023 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SrPd3KlF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F51C68E
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 15:13:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DA3A22E;
	Fri, 10 Nov 2023 07:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xdX945D2Jx/pGt01LPI1xFPqlA8WOj4k1izJoiFM9eQ=; b=SrPd3KlFmcQMHkuhaKnxKIFvww
	Q3H3bJ0H1V/+MoOzVUmokQ1jhSH84NPi7y1x58BJWzXlnTmv5pZHPAMDfi6cuWzu3CGf3AoFxK36H
	JUfW4O63U86dKzxelg3FnDtdz3E8W4FbGqf52q1lonSPyiMMGQ4h+XMdEiR4E+yLyd8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1TCM-001Iqx-Ry; Fri, 10 Nov 2023 16:13:30 +0100
Date: Fri, 10 Nov 2023 16:13:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: alexey.pakhunov@spacex.com
Cc: mchan@broadcom.com, vincent.wong2@spacex.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, siva.kallam@broadcom.com,
	prashant@broadcom.com
Subject: Re: [PATCH v2 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Message-ID: <7f1604fd-4bd6-4f16-8aed-2586afac7d15@lunn.ch>
References: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>

> @@ -11895,6 +11903,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
>  {
>  	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
>  	struct tg3_hw_stats *hw_stats = tp->hw_stats;
> +	unsigned long rx_dropped;
> +	unsigned long tx_dropped;
> +	int i;
>  
>  	stats->rx_packets = old_stats->rx_packets +
>  		get_stat64(&hw_stats->rx_ucast_packets) +
> @@ -11941,8 +11952,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
>  	stats->rx_missed_errors = old_stats->rx_missed_errors +
>  		get_stat64(&hw_stats->rx_discards);
>  
> -	stats->rx_dropped = tp->rx_dropped;
> -	stats->tx_dropped = tp->tx_dropped;
> +	/* Aggregate per-queue counters. The per-queue counters are updated
> +	 * by a single writer, race-free. The result computed by this loop
> +	 * might not be 100% accurate (counters can be updated in the middle of
> +	 * the loop) but the next tg3_get_nstats() will recompute the current
> +	 * value so it is acceptable.
> +	 *
> +	 * Note that these counters wrap around at 4G on 32bit machines.
> +	 */
> +	rx_dropped = (unsigned long)(old_stats->rx_dropped);
> +	tx_dropped = (unsigned long)(old_stats->tx_dropped);

Isn't this wrapping artificial? old_stats is of type
rtnl_link_stats64, so the counters are 64 bit.

> +
> +	for (i = 0; i < tp->irq_cnt; i++) {
> +		struct tg3_napi *tnapi = &tp->napi[i];
> +
> +		rx_dropped += tnapi->rx_dropped;
> +		tx_dropped += tnapi->tx_dropped;
> +	}
> +
> +	stats->rx_dropped = rx_dropped;
> +	stats->tx_dropped = tx_dropped;

state is also rtnl_link_stats64 so has 64 bit counters. So this code
is throwing away the upper 32 bits.

Why not use include/linux/u64_stats_sync.h, which should cost you
nothing on 64 bit machines, and do the right thing on 32 bit machines.

	Andrew

