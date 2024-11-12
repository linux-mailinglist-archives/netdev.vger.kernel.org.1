Return-Path: <netdev+bounces-144242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5499C642D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C451F2659B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734A2185B9;
	Tue, 12 Nov 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMtjvmdN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843521531C4;
	Tue, 12 Nov 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450016; cv=none; b=RZI3WdgAaGY8VYNNY4jSqLa4fw+0U/XL9c/FAHwO/4bIkUlESDdrgypvMWU2fQMz3eOGaWf7g9ouR+F1v7OKJDN4c6syO2h8ubH6swlqGuPeABPN7fg4SEmhMptXUATClXfJ7ouIehk6J80nCAnuuSJSqTWJeibGrP4T1L/Q+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450016; c=relaxed/simple;
	bh=klX9tSm44oZ4Uwy+ZftuZnphfa1B39CET5lUR+vLvSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgoma1MNJ0Ny0cWcIwh5vtqYHnsWx5IvKVkeZQrk4/2djDtndAlBR4BGdALZodjFQUJEOLObmHu1bGaTA55SbT+XU3Gh8jRAXjOir0dnCU9/NW8kmCCNk02BqBvxkTE6lBo89z16ukZIFxDbzywJzq/ecq39NsTR9jf2xdQ/F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMtjvmdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EC0C4CECD;
	Tue, 12 Nov 2024 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731450016;
	bh=klX9tSm44oZ4Uwy+ZftuZnphfa1B39CET5lUR+vLvSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMtjvmdNsOXuPlf727jQvSl9Xp+aLwblSURYuN8i5sKBwR7VxwLXsWtyHkkSFi52K
	 DiiVHJtGi9gE2JAzt6u7zxU/OuRlDce/ahXrfYq0t34t6gZwOAW2B9FF/zT3LKhNqb
	 dBuVPaDzU4+rU9gyHBSjqP4fh/UwG3aMdaRZjinXvancr6WgehCLuuHfZ3KkupM3/0
	 xzbASAHi//b03JkcB+63BreX8wy0OGA2y9lxsKAkJG+okVvrOOxKh4fJj8wxYn9HXd
	 rymkTSFSP2tyAwPkQ5clFzhB8XeujRYJBeXOEUQ2fDI3POKsbEWijKBamHB++W8M28
	 5JBfFfatnW0Vg==
Date: Tue, 12 Nov 2024 14:20:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v3 2/5] net: phy: microchip_ptp : Add ptp
 library for Microchip phys
Message-ID: <20241112142014.044ec21c@kernel.org>
In-Reply-To: <20241112133724.16057-3-divya.koppera@microchip.com>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
	<20241112133724.16057-3-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 19:07:21 +0530 Divya Koppera wrote:
> +	/* Iterate over all RX timestamps and match it with the received skbs */
> +	spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
> +	list_for_each_entry_safe(rx_ts, tmp, &ptp_clock->rx_ts_list, list) {
> +		/* Check if we found the signature we were looking for. */
> +		if (skb_sig != rx_ts->seq_id)
> +			continue;
> +
> +		match = true;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);
> +
> +	if (match) {
> +		shhwtstamps = skb_hwtstamps(skb);
> +		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
> +		netif_rx(skb);
> +
> +		list_del(&rx_ts->list);
> +		kfree(rx_ts);
> +	} else {
> +		skb_queue_tail(&ptp_clock->rx_queue, skb);
> +	}

coccicheck complains that you are using rx_ts after the loop, 
even though it's a loop iterator. Instead of using bool match
make that variable a pointer, set it to NULL and act on it only 
if set. That will make the code easier for static checkers.

Coincidentally, I haven't looked closely, but you seem to have
a spin lock protecting the list, and yet you list_del() without
holding that spin lock? Sus.
-- 
pw-bot: cr

