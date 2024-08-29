Return-Path: <netdev+bounces-123288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D007964626
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900A6B2104A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5861AD3F1;
	Thu, 29 Aug 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FsuDMFNl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFA1A3BDC
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937375; cv=none; b=neSfCJKvyjgmZlKGrDWaEa96MSaCzXuYTpv5KMFNaInL02RtuUbmSq0KNYSxe+EqZMByoKoGGelpLjHakHpvrUZ3fshrU043sd0lnK5SL2TbVPkBEIV+rQOyyXgA6/835x1ZJOX0YrFkzlM3/0OIiMRqWsh5E2ttDwmFV+hOCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937375; c=relaxed/simple;
	bh=5JATlgRN7VJYG8kLdPZeG6TRdD+4mOdYAsrmMpjPq8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3E4JZ4i8F78IpoIIAwRHrmPrndwJ4Xxp692HklsOs5P0SRrSfCxF2sGWdg9byr1cl0R3KHfF6ZBa1DaTseZcUQSGDEENEwi78cPDH22lJjeSm0mNS47mz6hUiT3xUon6+HY+TcGUccMk3lNie+PRgN9T10jOZ0Anu4CPCBjdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FsuDMFNl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f3WfsJc2npdMj0KqN/DmDSz7jIH8KI1FL8OzmEN05rc=; b=FsuDMFNlxSMBQs2dOR4jLQg2xu
	Cr36mg4DXQDvDBaE1zFcKyfhJVPZPJ5sDVl0TKiXmEaT9Luvnpm/vQzw9xuVtzByUZ35YRFgv08aB
	cIwWc4Lc/UrzorEyLT+cUzayA8CrrEokVxeSHx+f9OZfPOQTcOFAEqvF83hr1Vz5mPXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjf0V-0062Rg-CB; Thu, 29 Aug 2024 15:16:11 +0200
Date: Thu, 29 Aug 2024 15:16:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <7822930d-1331-4631-9d7e-bd37a40f44bd@lunn.ch>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-7-shaojijie@huawei.com>
 <20240828184120.07102a2f@kernel.org>
 <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
 <83dce3bb-28c6-4021-a343-cff2410a463f@lunn.ch>
 <f64c04a6-8c3d-46f5-a2dd-a9864de12169@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64c04a6-8c3d-46f5-a2dd-a9864de12169@huawei.com>

On Thu, Aug 29, 2024 at 08:55:35PM +0800, Jijie Shao wrote:
> 
> on 2024/8/29 11:02, Andrew Lunn wrote:
> > On Thu, Aug 29, 2024 at 10:32:33AM +0800, Jijie Shao wrote:
> > > on 2024/8/29 9:41, Jakub Kicinski wrote:
> > > > On Tue, 27 Aug 2024 21:14:50 +0800 Jijie Shao wrote:
> > > > > @@ -111,6 +135,14 @@ static int hbg_init(struct hbg_priv *priv)
> > > > >    	if (ret)
> > > > >    		return ret;
> > > > > +	ret = hbg_txrx_init(priv);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > You allocate buffers on the probe path?
> > > > The queues and all the memory will be sitting allocated but unused if
> > > > admin does ip link set dev $eth0 down?
> > > The network port has only one queue and
> > > the TX queue depth is 64, RX queue depth is 127.
> > > so it doesn't take up much memory.
> > > 
> > > Also, I plan to add the self_test feature in a future patch.
> > > If I don't allocate buffers on the probe path,
> > > I won't be able to do a loopback test if the network port goes down unexpectedly.
> > When you come to implement ethtool --set-ring, you will need to
> > allocate and free the ring buffers outside of probe.
> > 
> > 	Andrew
> 
> We discussed this internally, and now we have a problem that we can't solve:
> 
> After allocate ring buffers, the driver will writes the address to the hardware FIFO
> for receiving packets.
> 
> However, FIFO does not have a separate interface to clear ring buffers address.
> 
> If ring buffers can be allocated and released on other paths,
> the driver buffer address is inconsistent with the hardware buffer address.
> As a result, packet receiving is abnormal. The fault is rectified only
> after the buffers of a queue depth are used up and new buffers are allocated for.

If the hardware is designed correctly, there should be away to tell
the hardware to stop receiving packets. Often there is then a way to
know it has actually stopped, and all in flight DMA transfers are
complete. Otherwise, you can make a guess at how long the worse case
DMA transfer takes, maybe a jumbo packet at 10Mbps, and simply sleep
that long. It is then safe to allocate new ring buffers, swap the
pointer, and then free the old.

You probably even have this code already in u-boot. You cannot jump
into the kernel without first ensuring the device has stopped DMAing
packets.

> Actually, the buffer will be released during FLR reset and are allocated again after reset.
> In this case, the FIFO are cleared. Therefore, driver writes the ring buffer address
> to the hardware again to ensure that the driver address is the same as the hardware address.
> 
> If we do an FLR every time we allocate ring buffers on other path, It is expensive.

It does not matter if it is expensive. This is not hot path. ethtool
--set-ring is only going to be called once, maybe twice before the
machine is shut down. So we generally don't care about the cost.

	Andrew

