Return-Path: <netdev+bounces-97786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F288CD319
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C828509D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD814A4C1;
	Thu, 23 May 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QbP0Y189"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6413B7BC;
	Thu, 23 May 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469328; cv=none; b=XIIOugmZyiVVEKqNuWWpdyB05D5b7NWF5kh0Ee8poKvgbzgzt1CXo54lbV2tU6ycQSGczB2Rj80ncbO180qBrkhzQKfegExllsa8kCo0vTaMBBGMaqwJiCX5TMLBnCS/rSUfp+Bc965URKH5Nwok5Q6ushOE7i2ErvvQ6Lty6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469328; c=relaxed/simple;
	bh=xyTHuhkTsGkxCewXIYtJbN5u25VhvmjpyGsoQHV0W9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utA1UPnvQMkjVEvg0rRPtM/UpTz4P2nzCrZCAuQGjaCWu3pBd27OeYqkwJI0MWy5PkgmDzt1ljR6hJB5nPjq0HE+yv/vQLSR73kQpCjTAnavSzrcvh4w/ntai4dQxLT/CM4FJd2ShUnbg7Micrboy6bbmgUH+wdqvxdWrLyo05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QbP0Y189; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UTBLLIVYfkg4QE6/jefBW6vdILy6/+yw6lYO8WeGjC0=; b=QbP0Y189CLpNctPQTudUmRk1Hp
	CnoFA3HBpff5S8O7cAr0W5DFAGb9qCv4zmMenPG2OPe0x4VxqZCTxIY4K7LCo/SjXD5tDAL9HwW6G
	+pkUcOHCK5khO6K64DMxwScxrxlM3e0S+CnEouAx/DgecW8LdkiTLRR2cv8BXLo5CjZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sA84x-00FtRZ-90; Thu, 23 May 2024 15:01:55 +0200
Date: Thu, 23 May 2024 15:01:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] net: fec: free fec queue when fec_probe() fails or
 fec_drv_remove()
Message-ID: <ca1c4de5-537a-4aa9-851d-d37ce800fdac@lunn.ch>
References: <20240523062920.2472432-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523062920.2472432-1-xiaolei.wang@windriver.com>

On Thu, May 23, 2024 at 02:29:20PM +0800, Xiaolei Wang wrote:
> commit 59d0f7465644 ("net: fec: init multi queue date structure")
> allocates multiple queues, which should be cleaned up when fec_probe()
> fails or fec_drv_remove(), otherwise a memory leak will occur.
> 
> unreferenced object 0xffffff8010350000 (size 8192):
>   comm "kworker/u8:3", pid 39, jiffies 4294893562
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 00 50 06 8a c0 ff ff ff  .........P......
>     e0 6f 06 8a c0 ff ff ff 00 50 06 8a c0 ff ff ff  .o.......P......
>   backtrace (crc f1b8b79f):
>     [<0000000057d2c6ae>] kmemleak_alloc+0x34/0x40
>     [<000000003c413e60>] kmalloc_trace+0x2f8/0x460
>     [<00000000663f64e6>] fec_probe+0x1364/0x3a04
>     [<0000000024d7e427>] platform_probe+0xc4/0x198
>     [<00000000293aa124>] really_probe+0x17c/0x4f0
>     [<00000000dfd1e0f3>] __driver_probe_device+0x158/0x2c4
> 
> Fixes: 59d0f7465644 ("net: fec: init multi queue date structure")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Please read what i suggested. It is good to have code which is
symmetric. probe() and remove() should be opposites of each other.
probe() calls fec_enet_init(). So it would be good to have remove()
call fec_enet_deinit() which does the opposite. We then have symmetry.

Is there anything else in fec_enet_init() which needs undoing? A rule
of thumb: If you find a bug, look around, there might be others
nearby. Maybe leaking the queues is not the only problem?

	Andrew

