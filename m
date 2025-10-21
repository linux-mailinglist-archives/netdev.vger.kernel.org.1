Return-Path: <netdev+bounces-231133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61EEBF599E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF11980B0E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBFB32B9B7;
	Tue, 21 Oct 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY1jsVhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938732B9AD
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039961; cv=none; b=ilqS1LV84DmzmNTefCvzunViYlKzljHCWSgRqNi51IiTODaUs8M3nwytO3O8afTp5kiVr+TpLrCxmeKd17e2FW3ZzPZM4rY7VCpENTss1vTw+RME8Ipx4oosFmTqFBNg11IVYnAQkIf0ej1Xq73fPTfUZbgJGc8aMJrZj7aW1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039961; c=relaxed/simple;
	bh=C10WxW7/AbLOp4zp5DbAKNupE50VkLXOUwPIe3yt9SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkasc9bE86WoB0W8O7vJhZSofSNS+hKN6WmPG7QtXJuRGduD+PaH8tTPokjG9C9LKYWmLbYJBjTNIQIXcCf8/tEswIp3we9qxjzbKXVAhaSBtiepbC+d/8ja2qDAosFJqqytk7gLRgEcMxC53JhN5KEd5v6k1uJhqRz5KmsjEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY1jsVhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD63C116C6;
	Tue, 21 Oct 2025 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761039960;
	bh=C10WxW7/AbLOp4zp5DbAKNupE50VkLXOUwPIe3yt9SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rY1jsVheJ296MCsuiKzKJQy9WiNiMhMvHDb+iPPLYnId3KqK5MhNy+2Vq/1LF9RSa
	 kMI8GMnqcKX55qzf6uPnEggb2hDJC+5tEvneXjBfbUgg6Yy3PzUtc2iSKgRGfi+Z/l
	 +yrLSLbCnp3Vc2xe0fV3sWznCvnar0vO1dAhjCLLrIHOIhwWPwB0uccusVwOHnAc0d
	 oP2/RX/W475Ro0WBLh9Ja9fKywv5h3twLunXdFMVtB6o5xU/xwGv8awkeN6or84KCo
	 G7mj/GFjQbOFBa9nxEUpN1KMgFo/1V5YsrifTMQyREebaEVRMDpUt0l5iv+3QOKEL+
	 HoMSKgOtWJAqw==
Date: Tue, 21 Oct 2025 10:45:56 +0100
From: Simon Horman <horms@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next] tsnep: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <aPdWVMFUzoSIAEHb@horms.kernel.org>
References: <20251017203430.64321-1-gerhard@engleder-embedded.com>
 <aPYKDkBaoWuxuNBl@horms.kernel.org>
 <b55a017f-ab51-48f9-a852-c0c4ff37cb7f@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b55a017f-ab51-48f9-a852-c0c4ff37cb7f@engleder-embedded.com>

On Mon, Oct 20, 2025 at 07:59:22PM +0200, Gerhard Engleder wrote:
> On 20.10.25 12:08, Simon Horman wrote:
> > + Vadim
> > 
> > On Fri, Oct 17, 2025 at 10:34:30PM +0200, Gerhard Engleder wrote:
> > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > 
> > > I took over this patch from Vladimir Oltean. The only change from my
> > > side is the adaption of the commit message. I hope I mentioned his work
> > > correctly in the tags.
> > > 
> > > New timestamping API was introduced in commit 66f7223039c0 ("net: add
> > > NDOs for configuring hardware timestamping") from kernel v6.6.
> > > 
> > > It is time to convert the tsnep driver to the new API, so that
> > > timestamping configuration can be removed from the ndo_eth_ioctl()
> > > path completely.
> > > 
> > > The driver does not need the interface to be down in order for
> > > timestamping to be changed. Thus, the netif_running() restriction in
> > > tsnep_netdev_ioctl() is not migrated to the new API. There is no
> > > interaction with hardware registers for either operation, just a
> > > concurrency with the data path which is fine.
> > > 
> > > After removing the PHY timestamping logic from tsnep_netdev_ioctl(),
> > > the rest is almost equivalent to phy_do_ioctl_running(), except for the
> > > return code on the !netif_running() condition: -EINVAL vs -ENODEV.
> > > Let's make the conversion to phy_do_ioctl_running() anyway, on the
> > > premise that a return code standardized tree-wide is less complex.
> > > 
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > 
> > Hi Gerhard, Vladimir, Vadim, all,
> > 
> > Recently Vadim has been working on converting a number of drivers to
> > use ndo_hwtstamp_get() and ndo_hwtstamp_set(). And this includes a
> > patch, rather similar to this one, for the tsnep [1].
> > 
> > I think it would be good to agree on the way forward here.
> > 
> > [1] https://lore.kernel.org/all/20251016152515.3510991-7-vadim.fedorenko@linux.dev/
> 
> I already replied to Vadim, but on the first patch version, not on V3.
> 
> @Vadim: I reviewed your V3. Thanks for your work!
> 
> So this patch can be stopped.

Thanks for the clarification, much appreciated.

