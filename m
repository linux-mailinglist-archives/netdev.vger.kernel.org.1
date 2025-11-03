Return-Path: <netdev+bounces-235113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB12C2C3D2
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E8664F20DF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01330B51D;
	Mon,  3 Nov 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5dJvQh3n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3369287505;
	Mon,  3 Nov 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177365; cv=none; b=M1/GHarI4jO8mS8Yz/xWg58o9z+7IuOgZJ+R+kakeWnK2GIt07JS7OixtVMpT4WZf/HBKgoVLqYmbZUr5Wynpt1dW99eVs/MTRJ2NpzgKynAsmc/9Mz4s6oRgeDAIYbjPWp6hSqXvZrLG+GKpqEtg+NKdBJbLveqs7iFDd1alZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177365; c=relaxed/simple;
	bh=SN78tTprEyPJh30MAa+FGKZYyVae+7d3WI68t9RQsRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ9Tnommchau4CD9HdkKhjXOs4yg6BsJPuuJQYiapntWFVK6xyDabZBH9qjqHvMUkpqnxQtRWi/gDwCONtlJZOC1H2uxcKmYLVO41Z35jfHWr95xh6ZXZwWieiBVLGDiOSTpmifu8NEyC16rWdcZTuoNObQ5kSwQEPJw8iq4auI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5dJvQh3n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vTeelEGQAyHJj0V/pXZ4TfRy6Rmpt2ra9UbEea3FvGM=; b=5dJvQh3nkBSumMNUbicC64Sw0N
	6OC48RINmck6vt7BNz/aKLyobhC2TcNH8WG3frAiJ69uMTIheZcu6fjfLvQjNpjcV6lHLJURXY2Ur
	itstKLi1BInug605I2wLRu/m5BaLHEcL0YTo9VUF3qQuBwV+3Ld6ORNiEKJ86dzdvu4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFupI-00CmeX-PU; Mon, 03 Nov 2025 14:42:28 +0100
Date: Mon, 3 Nov 2025 14:42:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: altera-tse: Warn on bad revision at
 probe time
Message-ID: <db7e920d-a03e-40fd-9b37-71e836f0faf8@lunn.ch>
References: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
 <20251103104928.58461-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103104928.58461-3-maxime.chevallier@bootlin.com>

On Mon, Nov 03, 2025 at 11:49:25AM +0100, Maxime Chevallier wrote:
> Instead of reading the core revision at probe time, and print a warning
> for an unexecpected version at .ndo_open() time, let's print that
> warning directly in .probe().
> 
> This allows getting rid of the "revision" private field, and also
> prevent a potential race between reading the revision in .probe() after
> netdev registration, and accessing that revision in .ndo_open().
> 
> By printing the warning after register_netdev(), we are sure that we
> have a netdev name, and that we try to print the revision after having
> read it from the internal registers.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

