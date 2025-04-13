Return-Path: <netdev+bounces-181984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D9A873F6
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784327A48E2
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD51E5711;
	Sun, 13 Apr 2025 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XxvNdeTv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094C2629D
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744578526; cv=none; b=cCZak2ON97qCsuXS+lyTd1Zl0/t/dl53OpI8RxI2F95kEDqN/jLHQOPSbHb4eKs7dCvNipc7B0POWb/9QmaJuNYgVU8g0XJQMjk7GktdwjiabPhb347rCGvzBg2RpbzZpLyn0tXvbygxqXM6fW1KnDmQh5nVj45avQxScbOV4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744578526; c=relaxed/simple;
	bh=UwcCzTZYeYtBSgzDF05O+kHKklzMPlgXGxXChxcjOgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8eD9YcDgk/s9E5qKiMAzvvuhI28G3e3jLHAve/o8nTj0USQBPy4QkiXgO6E50cNg0vqIp7KyL1hHmmucuyOVXyNpQSzmfLoFw90FVhJfuT8WADjT3AXccqOyC2gzkkHq0aCdkguxXN0VhlAG93IkfwYInv2NXPQGfYExuCUZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XxvNdeTv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NUe/akxxdd5c7PreeaH46gc38+PUPMPsy9pqhCZI6so=; b=XxvNdeTv0zle75/6+fVO5MC2AX
	+LnDFJJ19t83kFQgIb3uubrraNDj4uRjPP/Q3ay62kUaZiiwwnHe9Uk50IP9Pa2j5C07dtuuwgH6p
	b+h8ClD2GXRAEXGMG+pwNigS77R8KcJjqUEBWvr9xrX+932WKFypTgZaWmqArXa2Sjes=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u44ZB-0096Kj-0r; Sun, 13 Apr 2025 23:08:37 +0200
Date: Sun, 13 Apr 2025 23:08:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/4] net: stmmac: anarion: clean up
 anarion_config_dt() error handling
Message-ID: <ad4d5a18-c89f-408b-b668-82fd83098c6b@lunn.ch>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
 <E1u3bfF-000Eli-C5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u3bfF-000Eli-C5@rmk-PC.armlinux.org.uk>

On Sat, Apr 12, 2025 at 03:16:57PM +0100, Russell King (Oracle) wrote:
> When enabled, print a user friendly description of the error when
> failing to ioremap() the control resource, and use ERR_CAST() when
> propagating the error. This allows us to get rid of the "err" local
> variable in anarion_config_dt().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

