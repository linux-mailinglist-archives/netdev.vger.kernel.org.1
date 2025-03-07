Return-Path: <netdev+bounces-172953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D2CA56A02
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E403A21B6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657421ABCA;
	Fri,  7 Mar 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ctpK6XhV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28621A44F
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356496; cv=none; b=VfxW944j/8F9y3ZL4VE3jym2mNST5/WB0e7jz+Fq+i3AQkrOF4StcDS4ydBHcDdPsggrLY/CmexiR76GxDg8jIUrPiQdsHvTcc49+46NAUoCT7DI49/NDkGE2qtUpgThDLqmVPscTX76M+y/m2B2qxGBdEzMhBmZz46V0yNeWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356496; c=relaxed/simple;
	bh=Gwrk4ShS14rGl0IDquHggcOfE56FBhXobVQzeIk6fZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/V40WoH/1AURYSdux88WCVZe6e/nWwPlH4tuJnPrEOdi/kiDqhx4RihkDd9SNiVJMIc7KWo+1GC27NfLo+XADgGkAKSS8pVsLclXVTCVIfgWL24p1h4bR9kDOSjyz9jWitEL5jFBiOFaGksD8VB12xbYkCGCFZbavJfQsguCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ctpK6XhV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FwP3iiHUdo3WYIE4U/rmzHQQI8mgTeHIwy9gC0VsJR8=; b=ctpK6XhV3YMg2AEEUobFxoscTG
	YP19Rj4sKMPdFZfgy8tpLZu1OL44A4HNGkT5Vm9gZ0BrSkz8Yz7YKtnCGoSImfRhgbBI/uo8EKfC3
	FMMnUw4vDkJMpi1ATncwZI7z94sAFsR4Ga21vb52k9IrFdmJKHrOOCLy89O6Xfq5ogTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqYMu-0039mE-Io; Fri, 07 Mar 2025 15:08:04 +0100
Date: Fri, 7 Mar 2025 15:08:04 +0100
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
Subject: Re: [PATCH net-next] net: stmmac: remove write-only priv->speed
Message-ID: <eef38dd5-63f6-4771-bf43-a55ba3ce98e0@lunn.ch>
References: <E1tqLJJ-005aQm-Mv@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tqLJJ-005aQm-Mv@rmk-PC.armlinux.org.uk>

On Fri, Mar 07, 2025 at 12:11:29AM +0000, Russell King (Oracle) wrote:
> priv->speed is only ever written to in two locations, but never
> read. Therefore, it serves no useful purpose. Remove this unnecessary
> struct member.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

