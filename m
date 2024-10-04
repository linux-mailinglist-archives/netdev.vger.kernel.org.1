Return-Path: <netdev+bounces-132237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580AD991109
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C16F1C23087
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12781ADFF0;
	Fri,  4 Oct 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tixl3HK8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7013D24E;
	Fri,  4 Oct 2024 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075600; cv=none; b=sqlCPPx9891qvyk3Ytk7Fqc0z0/zfx4RWNpmmoKhw0WEC0pvGQRgBiinnuYqfVhBQO4wfF7QObTJLKMKie53r+9eWcUrkRt5P0i6GsaM9Ddh9KuXk1hl9lum8ndqb1oTro1nupv9bM/PNq2k13ndmSk6y99ZQFrpqh3ksVryrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075600; c=relaxed/simple;
	bh=dUi6zBa7KQgcGPfXHpqwpRrYp3tvxSq8ybo4PWAAPns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaGe5WTPRS2KbNIjWICieJW2xHbNMxXlQRhSBVm4QtPa3YmKuOjLtIWuHcE56nmtAM0PnUBeDhDp0QucHqFPUtQ82Rv1ArJxJT87eUF272idyskrkr5xMMWshT+m7fy62WWfyTsrLSHkTxdzc/P/BFwnwgfwE6mAPTdtWnleD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tixl3HK8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GoG3mIuOyJseRPw9mMfR8nv4ktbc7UQHNgzab70N2cY=; b=Tixl3HK84UAu+elY4pn/Gorgjk
	QEQTguLf0b0Ws5A4trSKmUKWcBJf1UTvCaPjUO+3e4HzPvCXYBhWspfck6jzgLlQUbCD2AQhL9tMc
	kRT4DZBR6qmyYZ/pMkwTsnvbDIIgBQG+EuebCb7QFFp/hjcW2kmyQ8Q1OuhdpiKvPGpM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swpOr-0095oD-LG; Fri, 04 Oct 2024 22:59:45 +0200
Date: Fri, 4 Oct 2024 22:59:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: always set polarity_modes if op
 is supported
Message-ID: <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>
References: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>

On Fri, Oct 04, 2024 at 04:46:33PM +0100, Daniel Golle wrote:
> Some PHYs drive LEDs active-low by default and polarity needs to be
> configured in case the 'active-low' property is NOT set.
> One way to achieve this without introducing an additional 'active-high'
> property would be to always call the led_polarity_set operation if it
> is supported by the phy driver.

It is a good idea to state why it is RFC. What comments do you want?

So this potentially causes regressions/change in behaviour. Strapping
or the bootloader could set the polarity, and Linux leaves it alone up
until this patch.

The device tree binding says:

  active-low:
    type: boolean
    description:
      Makes LED active low. To turn the LED ON, line needs to be
      set to low voltage instead of high.

There is no mention that the absence of this property means it is
active-high.

In effect, i think we have a tristate, active-low, active-high, don't
touch.

I think adding an active-high property is probably the safest bet,
even if it is more work.

	Andrew

