Return-Path: <netdev+bounces-69890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6626D84CEB4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035861F28248
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA98060E;
	Wed,  7 Feb 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FLKvS12u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249020DCF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322483; cv=none; b=CgYOR2qvxRR0XDRrD6YT7cHfxfYJCaXK+cwSuPtkCJbJWgBSkQiqJmkR2w99QeGIzQwVtQNkfciSArSmQv7f3GBApcWedADrwmHoXN+hYY9SEYLqTp46riN/JRvwBTqE6gKd82BBnIeKfG6V4JmOTV3frMOpf4SVk/FHw1LowsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322483; c=relaxed/simple;
	bh=6vEhRaMZalIVplBDmcr2WR2nxcZk76/9Eq0dy5jY5sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv0O3B9TSqrYCw6LZp8TBIsZNpprSkHRuZzVeY+cNrRrFJ0dD/7sdkP+BZ0faquv86hbljpuYA5/9KD4ZizjLLwgXuA/fYR6yH1bwateJP78pA5GEhaf/+ze/4b1NoF7jfCBblhaBS2tASzg3E3uN8hQt+6yaJ4/UqK2mKf7yEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FLKvS12u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bip1UTDx5KuvZif9ify8FWQX/djbb3/ZjQmnCvYXEAs=; b=FLKvS12uaDmVJgP7DblFo4Hr7J
	nkAMISOovdeN2WEYKj9kXlRgV07DgyqrngCCmX1tSARXdNxgvOeSeRcRn5hFCFKPKzG1sI3n5JNs7
	9V9Fd/qkHGsocnj5pHuC1AwlBw9i2DPxB6kX2JEQ97KGgcbcn0TZjgKRh1d5dqFC4IBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXkZ8-007Eat-AZ; Wed, 07 Feb 2024 17:14:26 +0100
Date: Wed, 7 Feb 2024 17:14:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Igor Russkikh <irusskikh@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: atlantic: convert EEE handling to use
 linkmode bitmaps
Message-ID: <ba71c38d-23ad-4e78-bb34-ea383ba8d13e@lunn.ch>
References: <7d34ec3f-a2b7-41f5-8f4b-46ee78a76267@gmail.com>
 <c7979b55-142b-469b-8da3-2662f0fe826e@lunn.ch>
 <2046e53a-6de4-41e0-b816-3e7926ad489b@gmail.com>
 <20240207075314.5458bd68@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207075314.5458bd68@kernel.org>

On Wed, Feb 07, 2024 at 07:53:14AM -0800, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 07:52:49 +0100 Heiner Kallweit wrote:
> > > This is again a correct translation. But the underlying implementation
> > > seems wrong. aq_ethtool_set_eee() does not appear to allow the
> > > advertisement to be changed, so advertised does equal
> > > supported. However aq_ethtool_set_eee() does not validate that the
> > > user is not changing what is advertised and returning an error. Lets
> > > leave it broken, and see if Aquantia/Marvell care.
> > > 
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > This patch was by mistake set to "Changes requested".
> 
> It's because of the comment about zeroing, not the latter one.
> 
> Sorry, it's impossible for me to guess whether he meant the tag
> for v2 or he's fine with the patch as is. Andrew has the powers
> to change pw state, I'm leaving this to him.

Hi Heiner

Sorry, i was not explicitly. The linkmode_zero() is not needed, so it
would be good to remove it. Then feel free to add my Reviewed-by:

      Andrew

