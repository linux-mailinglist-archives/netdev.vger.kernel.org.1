Return-Path: <netdev+bounces-222863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D76B56B66
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D3D176762
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B1283FEA;
	Sun, 14 Sep 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="voZ+ffsT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB0524F;
	Sun, 14 Sep 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876029; cv=none; b=Nku1YCETM0YFc2I3NdPUoQvvaFyLfBgWDbCXlzJ1yd+/etfy2AKLB9igjM76//Tcibo5uCgxCiBkPfPFpUK9h5Eer3+nrHK8tDjG6j83uz8fFJRkxKwIKBbQsmz+Evdxieai4VpDI3qa9W9GSetkICS0/AcX2sM6JYLtv7gaGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876029; c=relaxed/simple;
	bh=ZM9rfV1lhZVPdlYOf8r2wMvTeFq3A0esFH0l/0aQZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlOnIbV5elmpK5gd4A20DiRQ2IofO/FpIirJ0VW9JNAAg1ZpSz8m2HEsVOVHvlXMoNaQjShsqpI0WQkdZgVBVlJGqc1aiBWziWpbfuP9buKfJUhe4P1DZgS48gswsJU6kuRLEhW9MBGDz8g7Ei9gf+ukQ2EC0HiA9uWZk5Kd4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=voZ+ffsT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xH77G1ipbxiDLfJXnEoLmbKp8eLlwBc6tOlYrjVNt3M=; b=voZ+ffsTyZOaDaRExyl+9UkPBN
	PDyp9Rqiw+TcmfVDAe7EiXB/nszMrGNxeDfzU1rTWqGBv3NiGFUUNbVyOjpKqGoNrB03qV1QCMrT8
	y0RAyLsYGjOoY5KyebtQ+qCcLWsjeGrlwxdvYro9xrVj1ETcoMurncI3PLd0ArNwgvL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxrr0-008MWa-W3; Sun, 14 Sep 2025 20:53:38 +0200
Date: Sun, 14 Sep 2025 20:53:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: dlink: handle copy_thresh allocation
 failure
Message-ID: <3e889e5d-0a10-4529-a506-b26f65f4c157@lunn.ch>
References: <20250914182653.3152-2-yyyynoom@gmail.com>
 <20250914182653.3152-4-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182653.3152-4-yyyynoom@gmail.com>

> This patch adds proper error handling by falling back to the `else` clause
> when the allocation fails.

> +			if (pkt_len <= copy_thresh) {
> +				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
> +				if (!skb)
> +					goto reuse_skbuff;
> +
>  				dma_sync_single_for_cpu(&np->pdev->dev,
>  							desc_to_dma(desc),
>  							np->rx_buf_sz,
> @@ -985,6 +982,14 @@ receive_packet (struct net_device *dev)
>  							   desc_to_dma(desc),
>  							   np->rx_buf_sz,
>  							   DMA_FROM_DEVICE);
> +			} else {
> +reuse_skbuff:

To me, the name is confusing. What Ethernet drivers usually mean with
reuse of an skbuf, is that they will give it straight back to the
hardware for use. If you can successfully do copy break, this makes
sense, the frame is no longer in the skbuf, it is in a new skbuf, so
the old skbuf can be recycled.

But that is not what is going on here. Copy break fails, and you fall
back to the normal path. The data is still in the skbuf, so you cannot
reuse it.


    Andrew

---
pw-bot: cr

