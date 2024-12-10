Return-Path: <netdev+bounces-150466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD29EA50E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE66163AB3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECE5D477;
	Tue, 10 Dec 2024 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e8SRStAx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF2233159
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797301; cv=none; b=XrvP48s4zHho1XyY985Yu5N1xrmYlPlVTqfZHVjkc0Jaa1AbFkJe1j4NuV9CemsOgktPo54V+d51zNZPGed5NN5ElSLSB6rK9Fz5xRl/4aYwfPtdAmvPDqlzDUjC3PsDY7HgukyhJuxx4VONc8DOWU1vyUfmt2Pqml8Sskqp1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797301; c=relaxed/simple;
	bh=ab4Xv2Q5lAH9rSwe8kc44crXqEv2FL6fybKfNQ4jqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKrzNvaH/8AgoX9MXjMai+1RC0tZqrLsWHVBPjspTF5fqNW/d/NyRlg+VhmI7lkTsScJWgCnEvu0cd+/QmUxoLlQBZW06QlKcJ1xD26tpFflQkACSGub/IUuphhS+y8ls4WD2df1jXTObPr0MKv94++rjy6frZFthM/6wKIcyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e8SRStAx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1SSUHRpua8j/4jo4NsmtD/fH79qFx4AWh8Bx/q9luUY=; b=e8SRStAx/wH7j1I/LHjqKgE755
	c8kIQbX1itXfHYfDA8rhwDhP0T89gKQkbsNTfzycKiqTupwg1kB5awhfZfi/RCZ56wFqgAlaZ2kgd
	omycpnwQQPb72cU+1nk+R9YianZPoSsYZiz58cmhnz8z+R1Zhj9shHynP4GDhzTlIW4o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpsS-00FkEv-KX; Tue, 10 Dec 2024 03:21:32 +0100
Date: Tue, 10 Dec 2024 03:21:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 01/10] net: mdio: add definition for clock stop
 capable bit
Message-ID: <c374f53b-dbfd-4751-bdf4-3c21fffb762d@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefO-006SMM-3S@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefO-006SMM-3S@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:18PM +0000, Russell King (Oracle) wrote:
> Add a definition for the clock stop capable bit in the PCS MMD. This
> bit indicates whether the MAC is able to stop the transmit xMII clock
> while it is signalling LPI.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

