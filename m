Return-Path: <netdev+bounces-104232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804DA90BA60
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831DCB2227B
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB4198E7B;
	Mon, 17 Jun 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL4J825S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C1198A3F;
	Mon, 17 Jun 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650802; cv=none; b=c6M5MRVVOXdqjYZ9c0M1xCDpSsFXCI/WunpqutLj5pXqoB/XmAE5ywXWpwS2Q1xXwAdanky7dfXYjR76gAC8s1S3pwVhuR1DrP1Ny+azt000G5nTiJ9fR3rkReCLVVJIM30Vq5BJubLRNMGzwkFDcWJhLN4YCziAp5X9FV/lrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650802; c=relaxed/simple;
	bh=wT9BPonRUprBvoz3eNT8uSo6S1S7xbXs4eDNIhRtW1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig3PhQ24Cw5uIOMuEgrJLt2QN9v1zSY0ke8G2/l2R2yduN3RHUrpmgCn+eVMbPpAtOhXSLtFWwtaamjl2gi8vJgkOob4KV0TppEFoblVPSlnnNkhobJcZXcuslcEeNdj9XsleEtBbP8huumAnR1NP3YZiZyVKEsA7WhtIxfJDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL4J825S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE606C2BD10;
	Mon, 17 Jun 2024 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650801;
	bh=wT9BPonRUprBvoz3eNT8uSo6S1S7xbXs4eDNIhRtW1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL4J825SQs4sQ5JQLeT+hwYLNuJsIbHWRnUh7UHjBV4AYtMcv523wjJEosW1SUTvk
	 DRyegFxbFjid93iNf7b12Ak3nTIMcBTm7597/plxF9z+GolqlYjA2oIY3E9TpqcsHf
	 OxW5yheQtSn7ZNaU9ujJMu1XTDciGMoAL9ejLjONIk5p24LgkaRvkyHgw7EQIIDfBX
	 0axMnLIpsTa0FJbRae6p7rpAbT7EpUnlPnYhv4rBuzVk1MzcYYidR7c+LH1EVRgBEm
	 dt90hsojKkPdbKurDZMmA2QGXl9mh0ZgJRWARcBqp4oTCWJmaLfOVUus/s9lOo/8Dk
	 HO3AbQZS9D97Q==
Date: Mon, 17 Jun 2024 19:59:56 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jiri Pirko <jiri@resnulli.us>, Larry Chiu <larry.chiu@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [v20 02/13] rtase: Implement the .ndo_open function
Message-ID: <20240617185956.GY8447@kernel.org>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
 <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
 <0c57021d0bfc444ebe640aa4c5845496@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c57021d0bfc444ebe640aa4c5845496@realtek.com>

On Mon, Jun 17, 2024 at 01:28:51PM +0000, Justin Lai wrote:
> 
> > >> How do you think about to increase the application of scope-based resource
> > management?
> > >> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/clean
> > >> up.h#L8
> > >
> > > Due to our tx and rx each having multiple queues that need to allocate
> > > descriptors, if any one of the queues fails to allocate,
> > > rtase_alloc_desc() will return an error. Therefore, using 'goto'
> > > here rather than directly returning seems to be reasonable.
> > 
> > Some goto chains can be replaced by further usage of advanced cleanup
> > techniques, can't they?
> > 
> > Regards,
> > Markus
> 
> rtase_alloc_desc() is used to allocate DMA memory. 
> I'd like to ask if it's better to keep our current method?

Hi Justin,

It may be the case that the techniques recently added by cleanup.h could be
used here. But, OTOH, it is the case that using goto for unwinding errors
is in keeping with current Networking driver best practices.

Regardless of the above, I would suggest that if an error occurs in
rtase_alloc_desc() then it release any resources it has allocated. Assuming
the elements of tp->tx_ring and tp->rx_ring are initialised to NULL when
rtase_alloc_desc is called, it looks like that can be achieved by
rtase_alloc_desc() calling rtase_free_desc().

Something like the following (completely untested!).
Please also note that there is probably no need to call netdev_err on
error, as the memory core should already log on error.

static int rtase_alloc_desc(struct rtase_private *tp)
{
	struct pci_dev *pdev = tp->pdev;
	u32 i;

	/* rx and tx descriptors needs 256 bytes alignment.
	 * dma_alloc_coherent provides more.
	 */
	for (i = 0; i < tp->func_tx_queue_num; i++) {
		tp->tx_ring[i].desc =
				dma_alloc_coherent(&pdev->dev,
						   RTASE_TX_RING_DESC_SIZE,
						   &tp->tx_ring[i].phy_addr,
						   GFP_KERNEL);
		if (!tp->tx_ring[i].desc)
			goto err;
	}

	for (i = 0; i < tp->func_rx_queue_num; i++) {
		tp->rx_ring[i].desc =
				dma_alloc_coherent(&pdev->dev,
						   RTASE_RX_RING_DESC_SIZE,
						   &tp->rx_ring[i].phy_addr,
						   GFP_KERNEL);
		if (!tp->rx_ring[i].desc)
			goto err;
		}
	}

	return 0;

err:
	rtase_free_desc(tp)
	return -ENOMEM;
}

And then rtase_alloc_desc can be called like this in rtase_open():

static int rtase_open(struct net_device *dev)
{
	struct rtase_private *tp = netdev_priv(dev);
	const struct pci_dev *pdev = tp->pdev;
	struct rtase_int_vector *ivec;
	u16 i = 0, j;
	int ret;

	ivec = &tp->int_vector[0];
	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;

	ret = rtase_alloc_desc(tp);
	if (ret)
		return ret;

	ret = rtase_init_ring(dev);
	if (ret)
		goto err_free_all_allocated_mem;

...

err_free_all_allocated_mem:
	rtase_free_desc(tp);

	return ret;
}

This is would be in keeping with my understanding of best practices for
Networking drivers: that callers don't have to worry about cleaning up
resources allocated by functions that return an error.


I would also suggest reading Markus's advice with due care,
as it is not always aligned with best practice for Networking code.

