Return-Path: <netdev+bounces-222357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67957B53F69
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5661CC0499
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09422F56;
	Fri, 12 Sep 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdzM3Uj8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E628FD;
	Fri, 12 Sep 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635697; cv=none; b=WEqSEEVbquMUFRtiWl3+Mg8RJ/M0yosIT8d0ETiq51sj7ytulWJobIZ1ETehNQ9wQJ/FB5Zt3vum/AjrowhV59XibaBdBd6XyXAKF23IInm/JFMmvPw/4B6olCxqtAen9lWqLAtNeKCGV7FZmueIW6mUJwn2jX49MQBkcifQb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635697; c=relaxed/simple;
	bh=eUOaiPDTUW/I66NUIlaJw0tipGEEnNadqFZWZAPJ/BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qECgK+OzHfO63Xp758WQZpDpXPNcH0NSdNz0Xc5m4P2j2Ko3z9c65ved9iO8LlXvG7sl/Ouw5XyVhYqMxXiJQ/nv4XUr34V6/65U6KT/I6zh0oE6MVKCY6frqZpLOiLoUfTKbQj/g8qkWBRJULN3uMGimFBJbEjk3rhVeKAjSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdzM3Uj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF226C4CEF0;
	Fri, 12 Sep 2025 00:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757635697;
	bh=eUOaiPDTUW/I66NUIlaJw0tipGEEnNadqFZWZAPJ/BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdzM3Uj82zSkHDH04VYoPsJosCFAlfTt3PLCiDQIizKM10wo0/h92Z2Mayxcn4yhJ
	 jZZM1TwTKSxxV9qv7fbAXnimVRDSJX10gUKRvVQ8wa2F+hkD2j79kagZyF2AtfDZr9
	 R48snxTtnRHigJq6w5RkkbrRukI/Tgbp1TiqWaciaqE3xvkskkklOkm3xf5Ou3GOas
	 O6p9u0kiwxhLArgKTGTv/nlm8TkXBdZsHkFMktWxqr3dipm2U5k4A1f5bdOIRIlTPZ
	 icp8P9CVHAgqIROreoG+liwnrmaPEI5LiSTdVTagYBN9STaFvRl0jgvIV5QmoiXNtr
	 0jXPa0f/deu9A==
Date: Thu, 11 Sep 2025 17:08:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Message-ID: <20250911170815.006b3a31@kernel.org>
In-Reply-To: <20250910054836.6599-2-yyyynoom@gmail.com>
References: <20250910054836.6599-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 14:48:37 +0900 Yeounsu Moon wrote:
> Track dropped packet statistics when skb allocation fails
> in the receive path.

I'm not sure that failing to allocate a buffer results in dropping
one packet in this driver. The statistics have specific meaning, if
you're just trying to use dropped to mean "buffer allocation failures"
that's not allowed. If I'm misreading the code please explain in more
detail in the commit message and repost.

> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> index 6bbf6e5584e5..47d9eef2e725 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -1009,6 +1009,7 @@ receive_packet (struct net_device *dev)
>  			skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
>  			if (skb == NULL) {
>  				np->rx_ring[entry].fraginfo = 0;
> +				dev->stats.rx_dropped++;
>  				printk (KERN_INFO
>  					"%s: receive_packet: "
>  					"Unable to re-allocate Rx skbuff.#%d\n",

