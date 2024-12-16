Return-Path: <netdev+bounces-152130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3A9F2CCA
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA876168627
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E611FFC6E;
	Mon, 16 Dec 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EZLce8JO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2901B87C4;
	Mon, 16 Dec 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340882; cv=none; b=OkIss+VZc6gGjoFsCGcuSG3JfJDVuNEiY3B5Avd9Kr2q7PFRUW4ciV+2RDQIjYBtQ6yY4iKxZcra8zCOaZR6lyCMbYZ9izS0jI/OAqAORPOn2kV/jblzD49qOmln/7DZomRh/cy2EzkfG72PBxJwB3DdXs68HycxNN7t8dFqfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340882; c=relaxed/simple;
	bh=yRGmXTBFVWHYbCsitTNjNMFS+ou4oZ9TyVh4Ku2xXUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPJCkeJjuEPcHESL8Y63LMaaziUTVfxBtMVc/nN0lu8ePYQRb4Z0EzYQU1mbhyqmkdvVjg22tyLG4oxqQeyrgqCVhZjKIkqsrXSBb5hy4WrPB0UlA1ITBa72W4ctlB1/44Ox/KP5WjxnVNKlJ3GFX2eWsngYJYuI7HH1Rz9rnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EZLce8JO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zBrPx7vCumTQ0Yh6YQVHpRo26AjmieEIpTHXpOhrnJg=; b=EZLce8JO2cULM/LItEkxmEbKDc
	ZxsxwSr3SKLhn6eEiEYqeVCvQ5R6mSLR3vi4Zp0fiwRg4dlkVhsKeEGLfQ6KUiJR7A+h6k2HHJ/jB
	Z7YFSqkhPTiNAzsWLyxaGP2JmKhPB3Ey607vpUsmb6JtaqCQAVUf6DxCykQUXBXknces=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tN7Hs-000ZW7-Dp; Mon, 16 Dec 2024 10:21:12 +0100
Date: Mon, 16 Dec 2024 10:21:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: Fix inconsistent use of
 jiffies vs milliseconds
Message-ID: <87195b12-6dfa-4778-b0c0-39f3a64a399e@lunn.ch>
References: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
 <20241215231334.imva5oorpyq7lavl@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215231334.imva5oorpyq7lavl@skbuf>

On Mon, Dec 16, 2024 at 01:13:34AM +0200, Vladimir Oltean wrote:
> On Sun, Dec 15, 2024 at 05:43:55PM +0000, Andrew Lunn wrote:
> > wait_for_complete_timeout() expects a timeout in jiffies. With the
> > driver, some call sites converted QCA8K_ETHERNET_TIMEOUT to jiffies,
> > others did not. Make the code consistent by changes the #define to
> > include a call to msecs_to_jiffies, and remove all other calls to
> > msecs_to_jiffies.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> 
> If my calculations are correct, for CONFIG_HZ=100, 5 jiffies last 50 ms.
> So, assuming that configuration, the patch would be _decreasing_ the timeout
> from 50 ms to 5 ms. The change should be tested to confirm it's enough.
> Christian, could you do that?

I've have an qca8k system now, and have tested this patch. However, a
Tested-by: from Christian would be very welcome.

	Andrew

