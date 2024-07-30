Return-Path: <netdev+bounces-113893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0594044D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A45B21EE5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080B7A724;
	Tue, 30 Jul 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8K1+UIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED96EB5B;
	Tue, 30 Jul 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305666; cv=none; b=Y0QAI65UhCYIJH+XmezAILmmYtHjQMqMKpmT10O+QdtvV04Ih6KxLlNZ0bmINsRMwRtl88kNEJGi6603BdrSNFmwox2C/0MNJDxvaUccut6+oE++5xO52+To+h6uBF4W2ggnLS4uM/y2OdnR/AYExfMLKcrU9wMixGGjMMOyXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305666; c=relaxed/simple;
	bh=6VsNtwEmU1n+fdu3tre+ZKEavnYoe4Z6AidMLVTGwPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSBHhu0ZAoElBy3DiHemghAqkWPnO6BDwAg5fS+qXcTZQb442kmebIQYQ8oHCF3Tmr+ICAyrhDMoYano5APu0CeMHC678/GUmCjQqbWr3XVDGAf7Fdvyr+gEsFe0BI9rUT14bPo6OPcX4kw2ut5ZNKqBNbGIw9HiNlASCGI09u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8K1+UIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D54CC4AF0A;
	Tue, 30 Jul 2024 02:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305665;
	bh=6VsNtwEmU1n+fdu3tre+ZKEavnYoe4Z6AidMLVTGwPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n8K1+UIN3ssOFF5uPELcx06esiHHjYJfV7DgCtD3rglqccMMMJ3l27PpIGdSCIrnD
	 9A9TTMfWSq0sFNp1zFEp8Bm1qI6AwXNLmmqgKBVG7F5Gy9RZcimYJZlcvgn2yLq5wS
	 djc9ZWMCX9H6KLbpowp7Nfm2HJfp16ER32ukh97rIXsC4HMs7xgpnx5SuiM9ml4PQl
	 LuzEtaIbYR7KFuukqV4Ps8i6OzoT+Idaz3GaxTUmG4039xa09ekei46p2ZgfgX6TAE
	 xviHmxqCWSUlXyd/zwy1vsGTWjfXYFIOhCSpzujhJfg2+FGScpYGTQzCTUhXKd6XyH
	 mQ0z3YmBfSmag==
Date: Mon, 29 Jul 2024 19:14:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v25 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20240729191424.589aff98@kernel.org>
In-Reply-To: <20240729062121.335080-7-justinlai0215@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
	<20240729062121.335080-7-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 14:21:14 +0800 Justin Lai wrote:
> +	stop_queue = !netif_subqueue_maybe_stop(dev, ring->index,
> +						rtase_tx_avail(ring),
> +						RTASE_TX_STOP_THRS,
> +						RTASE_TX_START_THRS);
> +
> +	if (door_bell || stop_queue)
> +		rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> +
> +	return NETDEV_TX_OK;
> +
> +err_dma_1:
> +	ring->skbuff[entry] = NULL;
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> +
> +err_dma_0:
> +	tp->stats.tx_dropped++;
> +	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +
> +err_stop:
> +	netif_stop_queue(dev);
> +	tp->stats.tx_dropped++;
> +	return NETDEV_TX_BUSY;

If you're dropping a packet you should somehow check that the previous
xmit didn't enqueue a packet to the ring and skip the doorbell because
door_bell was false. If that's the case you have to ring the doorbell now.

Also you shouldn't increment dropped if you return TX_BUSY.

Please fix these issues in the driver you're copying from, too.

