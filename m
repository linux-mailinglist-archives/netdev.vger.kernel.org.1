Return-Path: <netdev+bounces-132056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F059899044B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B80282086
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F421019F;
	Fri,  4 Oct 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iEtBaBjw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41D2101A6;
	Fri,  4 Oct 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048414; cv=none; b=DWn/0cO/HJoGAcg0hTkfDkRNZZ4WgBFxnPbRGl7sxnUrkKlD92Hhv4GiYkPy5+/h2ns6jMNSzpyihn2YPLXtk7Nht6s+ljNqwVinvONH2Ic6XONKtuK2F0tLmCU2zAcIXk+bVDiRL1+ie5gDho3oG3dxlzMVsqYx9XKAmFcI7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048414; c=relaxed/simple;
	bh=1qMYlcMYOPeZl8/+7khLu3IU0pxqRBqTbCIHeV11Uio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8+BCeyDwu/DQjBhTusx5f7kh7+JhhS+oN12fNixBUr/EtK8zY0lJU9gCFZIMW3XihneEyLgAR8rkAvWHYZ9sx5ob9HRnwH2kBGmXqpMqhe+1SWG6LyFn4ZxY8lZdf+LopBke3HJrq297JwIgjf85NoTywoQz9ba0ZE5EF9lOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iEtBaBjw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=C8gS7fToqe6BJ0Q1SvpFc5Yl0jX/XTl2WKyQ7F7YwtM=; b=iE
	tBaBjwl3xDN1/hqlVEmhMMlmyopzfuci33jUkjH9bjJFKsR/JKocxiFQFjdxUu7mNtkRH6lQqJNMb
	uLKZ1uAdsFuJ9xjI7+eIVzn1x670ac2dBn2iL+q9q7NE4VaKFLOuGwRNy6Hz0Ey0++5XrL526QwuW
	XwFSjR2L/rXMRdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swiKH-0092y1-CB; Fri, 04 Oct 2024 15:26:33 +0200
Date: Fri, 4 Oct 2024 15:26:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Message-ID: <927d5266-503c-499f-877c-5350108334dc@lunn.ch>
References: <20241003022512.370600-1-qingtao.cao@digi.com>
 <30f9c0d0-499c-47d6-bdf2-a86b6d300dbf@lunn.ch>
 <CAPcThSHa82QDT6sSrqcGMf7Zx4J15P7KpgfnD-LjJQi0DFh7FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcThSHa82QDT6sSrqcGMf7Zx4J15P7KpgfnD-LjJQi0DFh7FA@mail.gmail.com>

On Fri, Oct 04, 2024 at 11:35:30AM +1000, Qingtao Cao wrote:
> Hi Andrew,
> 
> Please see my inline replies.
> 
> On Fri, Oct 4, 2024 at 12:30 AM Andrew Lunn <andrew@lunn.ch> wrote:
> 
>     On Thu, Oct 03, 2024 at 12:25:12PM +1000, Qingtao Cao wrote:
>     > On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it
>     is
>     > activated, the device assumes a link-up status with existing
>     configuration
>     > in BMCR, avoid bringing down the fibre link in this case
>     >
>     > Test case:
>     > 1. Two 88E151x connected with SFP, both enable autoneg, link is up with
>     speed
>     >    1000M
>     > 2. Disable autoneg on one device and explicitly set its speed to 1000M
>     > 3. The fibre link can still up with this change, otherwise not.
> 
>     What is actually wrong here?
> 
>     If both ends are performing auto-neg, i would expect a link at the
>     highest speeds both link peers support.
> 
>     If one peer is doing autoneg, the other not, i expect link down, this
>     is not a valid configuration, since one peer is going to fail to
>     auto-neg.
> 
> 
> Well, technically speaking, thanks to the 88E151X's bypass mode, in such case
> with one end using autoneg but the other is using 1000M explicitly, the link
> could still be up, but not with the current code.

So we can make an invalid configuration work. Question is, should we?

Are we teaching users they can wrongly configure their system and
expect it to work? They then think it is actually a valid
configuration and try the same on some other board with other PHYs,
and find it does not work?

Does Marvell document why this bypass mode exists? When it should be
used? What do they see as its use cases?

	Andrew

