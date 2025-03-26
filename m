Return-Path: <netdev+bounces-177739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008BA717EA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B748B16BAC3
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7DF1EEA59;
	Wed, 26 Mar 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kJQt+gNS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A291E5B96;
	Wed, 26 Mar 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997440; cv=none; b=Ll9LCJJeebrCjDNAkV/jWdg6ZRI6HbDall8itX/Ym8iZOanaxqNutvWMXO2x45tO+PY/LMjgKpWMgYkE9ZEl56JFEFsToqFMNFqvtcNNWgW8lwfOmDCL3YssZVEiaWELX3ojZ1dicRN/Yx1gH28r3jdAcJjSjIGtcEfutbnb3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997440; c=relaxed/simple;
	bh=1p8KjiTqjNAHl4UGFhuzwCzlkKafEDA6cKN4ir3X2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbeSFryY9wYuhtGWvHelIjWQhXZvgroMAZG5+mRDldxKqn2tp9qPdlf0oE7sX5hEiCE9UWNI+BEXm2gpp79HCvQpsaVMytfzwJbNcebQHn5/ctrjnDWyq6zE735wNqpeaXIH0kWh0rN4kS7I7BsV6AgoXgoMKHZvFeSHtDXRhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kJQt+gNS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PxyiAcHHfe3kkyC2cZnuyzpI8SDABEjryx8RiO625Lc=; b=kJQt+gNSFtCd/oNrhiZZ2hpcOb
	t4VyIM94+SHLec7RDb2jBJd9rCb0kHKQHRbWB2ohbWP700fgMlR0F/2ExQSGYlHTuYDZ6izm+Ymqm
	o656XlXUeDxfkL334ZSG3AwTrU/zBw7zI7b+FyQC40GX1i1Az4WskKqbfNzVo1yWck30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txRFl-007Ath-Bg; Wed, 26 Mar 2025 14:57:09 +0100
Date: Wed, 26 Mar 2025 14:57:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <a3cddcf4-bdcc-49f4-9d72-309854895c7c@lunn.ch>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>

> In summary, I really don't like this approach - it feels too much of a
> hack, _and_ introduces the potential for drivers that makes use of this
> to get stuff really very wrong. In my opinion that's not a model that
> we should add to the kernel.

I agree.

> 
> I'll say again - why can't the PHY firmware be loaded by board firmware.
> You've been silent on my feedback on this point. Given that you're
> ignoring me... for this patch series...

And i still think using the match op is something that should be
investigated, alongside the bootloader loading firmware.

	Andrew

