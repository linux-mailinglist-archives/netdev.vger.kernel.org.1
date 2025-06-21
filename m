Return-Path: <netdev+bounces-199945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789BAAE27C2
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2749B16A338
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08F1D54C2;
	Sat, 21 Jun 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NnC7h+Vz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B121991CB;
	Sat, 21 Jun 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750490686; cv=none; b=Bjhlss+kDXWq5AP78DZmeSJ7HGcZ+rkHMcLEChwR/wbpFrCY112O3Yt0WAGDMmaV9RF5a1iLx+GnBk5GnWOrQQNCyPDlhdnsULrHnZG1eBGQ134ngHweEL34huYfgndY99ZYPVrrc/Wk9Hc6lbdJ2EzJlq3iM78l8T+O3sJ88wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750490686; c=relaxed/simple;
	bh=FfAQ51F+Hi6dqP25b4oDnLvzhtnbFz1p22/HIbdcM/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3bi+PKhEHJGU2NOEGKKBMPkb8RT71YJkE9r9KO1WbXt4GBPIlTtvCjcZDjPcq4HmjMHcpu1Pxg1faKc7h1918cz1uRX0t1/kcx483PavR/EFdz+Yt0tc+5Z1OAuUY+kjb2rMqOEbDCygZyr7O/5n/l790u+vI0DTNwBJTf2vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NnC7h+Vz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xsa4PmV1qVfzFyuhUlGmPWQvYGQTLXg8FbzbifE7bGk=; b=NnC7h+VzmGYHSjXjn0XSwTXPx6
	/6ODU3C3gH7RKdQcyuo5nyQayZrRZPFs/fErboxzuPlz3dnqGpyZpnWFpOalPVJiCnObD9fwuiR4+
	d6N79BoP5Va/D0e3AwAwlhJ9/F6BaKiBpO4SrJZVnfJEGdRFAQ+Q/R1M2cQM1Lu694nc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uSsaT-00GZAy-0U; Sat, 21 Jun 2025 09:24:29 +0200
Date: Sat, 21 Jun 2025 09:24:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ryan.Wanner@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Expose REFCLK for RMII and enable RMII
Message-ID: <4b1f601d-7a65-4252-8f04-62b5a952c001@lunn.ch>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750346271.git.Ryan.Wanner@microchip.com>

On Thu, Jun 19, 2025 at 10:04:12AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This set allows the REFCLK property to be exposed as a dt-property to
> properly reflect the correct RMII layout. RMII can take an external or
> internal provided REFCLK, since this is not SoC dependent but board
> dependent this must be exposed as a DT property for the macb driver.

What board is going to use this? Do you have a patch for a .dts file?

	Andrew

