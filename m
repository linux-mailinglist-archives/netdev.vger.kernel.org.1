Return-Path: <netdev+bounces-238694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA08C5DD8D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29CF63868CD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559BA23C8C7;
	Fri, 14 Nov 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WVlMdxbh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CB1DC1AB;
	Fri, 14 Nov 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132433; cv=none; b=bZeUjh1gL9Vu5D2WArok85EMy6D6lrgQeolgkck66ThY3MryKd/prAfl492dhoBUgQlyEnhbojIpECnRIPKMsz/p9/uNRmdF228kFLLUTJunOXxTZWURrgGE/2tllOWu1Bk1I+30HrfLF0XBldVZOQneRIVasgdRtaz5fCEhg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132433; c=relaxed/simple;
	bh=pKKtIaGg2mW9VoXj8geWTRoYoBB3ukU4TJvoZA7B1hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+cdBzdfJBWdegdsij7vQHbh1mBhMSOx3VcCTtdqFChfVUvmpbEO5S9+QznNvDUzJLJuyksFVHs1Z0Dkuvti+wFJlXpRcTEL6byjY7HI1sFXAfUumdKXEMsOJOUv85S4uf36ZGKlWVBmaKieuW/GNEihzLNut6s29nFxcvtgR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WVlMdxbh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k/YhTGQVFoAIQtWZiS4UvSYFaY3LakZ+rD8PriIbwvo=; b=WVlMdxbhVgDSmPBGKYYOqc0u/9
	p/5slhpEa9PNjFMhXmKXXH4ij6poGI+mYzm3UHSGoHO5Cpl4RoeEkRnuknZKH4xAP2GkWPLz40HIf
	UWnc4xM6MBZmRxuL6v7fvHFIwVGYQJz16BVo5+bAJqtFhG3+tglEYWzLCHeOVSSi0d2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJvHh-00DzOY-AE; Fri, 14 Nov 2025 16:00:21 +0100
Date: Fri, 14 Nov 2025 16:00:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/4] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
Message-ID: <f13d7a80-d7cc-46c4-99f4-ea42f419b252@lunn.ch>
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
 <20251114-ksz-fix-v3-3-acbb3b9cc32f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-ksz-fix-v3-3-acbb3b9cc32f@bootlin.com>

On Fri, Nov 14, 2025 at 08:20:22AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> Sometimes ksz_irq_free() can be called on uninitialized ksz_irq (for
> example when ksz_ptp_irq_setup() fails). It leads to freeing
> uninitialized IRQ numbers and/or domains.
> 
> Ensure that IRQ numbers or domains aren't null before freeing them.
> In our case the IRQ number of an initialized ksz_irq is never 0. Indeed,
> it's either the device's IRQ number and we enter the IRQ setup only when
> this dev->irq is strictly positive, or a virtual IRQ assigned with
> irq_create_mapping() which returns strictly positive IRQ numbers.
> 
> Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> --
> Regarding the Fixes tag here, IMO before cc13ab18b201 it was safe to
> not check the domain and the IRQ number because I don't see any path
> where ksz_irq_free() would be called on a non-initialized ksz_irq

I would say the caller is wrong, not ksz_irq_free().

Functions like this come in pairs: ksz_irq_setup() & ksz_irq_free().
_free() should not be called if _setup() was not successful.

Please take a look if you can fix the caller. If the change is big,
maybe we need this as a minimal fix for net, but make the bigger
change in net-next?

Thanks
	Andrew

