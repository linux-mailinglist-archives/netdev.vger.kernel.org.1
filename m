Return-Path: <netdev+bounces-71801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271948551AA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6693298614
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481812D766;
	Wed, 14 Feb 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hhy+CkfP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53D1292DB;
	Wed, 14 Feb 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933884; cv=none; b=aT4Nfp5sU8I1IcKjGnusvEsHSjHfnQSP8RM4MxBR4lWb/lcSTVT3IshemNOP8/jCoa+SNYzPXFtKaW01xB4NanChnqKxvo9QqWlALxxtIoOGC4ERw8Na7fLLCxLyPt4vsJ4aK6JSKjF5PwFZW9ckyLT5+tlpn9FgSu+UZu8qc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933884; c=relaxed/simple;
	bh=tp9WBVv4tk8bpCmaDHshpr73lQEddgNoO5Q4jQr2A9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZxxOfDvzRkciUt9m38PGzDbmKyaB6O826/pn9f+OBMaAALGPUb/3V6dkU6np7kd+JSR7gVA2W4NkoWpjjFH5UQvKqPvsmYHl/1xx0DbD8c8fUIQ9qCm3T1ROy+1wcx3/Um7Ooy971JYdh8/D3KIgQRo2UF8ldE+HsdmOSEgWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hhy+CkfP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=asjQTJ1uTvWYrDDXb91A7DvAB5RkaQAzani0ICferZo=; b=Hhy+CkfP9/tE8VikwnH77iK+Od
	+5MVECwCQMsHwEWGCRWu/299CEaWjr16LDuw/KnLeRUSmNu6SUsCnPp6XVaCbere563/JkYRO0Jjg
	EUpGxqzTLuGpioOJ6izUSlMEXZFvj7iXwYUy/MxRJ6V1D7CkUg1Iy2xoOFWpbBoHsoWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJck-007oXp-BD; Wed, 14 Feb 2024 19:04:46 +0100
Date: Wed, 14 Feb 2024 19:04:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
Message-ID: <e1b02bfc-0e84-4b4d-804a-3db2ce546e3a@lunn.ch>
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213133558.1836-1-ansuelsmth@gmail.com>

On Tue, Feb 13, 2024 at 02:35:51PM +0100, Christian Marangi wrote:
> Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
> but actually supports up to 5G speed, hence some manual fixup is needed.
> 
> The Aquantia AQR111B0 PHY is just a variant of the AQR111 with smaller
> chip size.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

The discussion around provisioning should not prevent this being
merged.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

