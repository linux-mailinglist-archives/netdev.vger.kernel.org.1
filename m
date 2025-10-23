Return-Path: <netdev+bounces-232238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0602C03106
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0F54E2A50
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DD280A51;
	Thu, 23 Oct 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IqyaRhf4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99435B120
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245378; cv=none; b=WUOTJ0OREvN+Pn3oTF/Q2S+6nvmDnL7OSsUqPI7UVppuWGgXhm3c1N0oLy+59GIU8nJdVcK8qyKnGf2oV08Hw/c9F1vPi0znqALtruuGn6ZhLlYJgQcdOxmew0iQ5LnvsCB7U6OGUTR0EOXeef/7NCh4kB8hdDKC0zv5/NgpxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245378; c=relaxed/simple;
	bh=Kz4YzGNTGMJk8NffBloQRXxg0QY0fMoi/94S0gL7MMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwaQsM+mrW8BueOQQ543H2zP33oY9N5Ae7Yck61+yD+83whtH94C1g3iHnMEGnU5HZimzgIXigjeQYkeTy43re+8ZscmGFqSTsnX2riYb6sIExL6TJw1Th8C0aGgLYZi9c/Yhliyfm0Y8tuixZVgrPm+JdZwSpv8AUdWBRTmQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IqyaRhf4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VIaigQ7/6IfjT7bJlbrU2VAYexO5JtBnAJREaaV5jvY=; b=IqyaRhf4cmIszxYOyM9yBtN85u
	LDFxbvGes0XBqmkA63lubojhq8MLB0zEAj74C9k5/NM2+ZbZoyatl6vcxTS8ATEFhEjRGkOeZGIrI
	ApYNQuRpHTw2uuccyBDZe48SZNqtdOSYuTLxxsYxlli+dv+nWbydDchDBMgCZZv87Ysc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0NM-00Bubj-W5; Thu, 23 Oct 2025 20:49:28 +0200
Date: Thu, 23 Oct 2025 20:49:28 +0200
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 5/8] net: stmmac: use FIELD_GET() for version
 register
Message-ID: <c0874124-1526-46fe-a480-caf7f80aa7e9@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlQ-0000000BMQA-33N7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrlQ-0000000BMQA-33N7@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:44AM +0100, Russell King (Oracle) wrote:
> Provide field definitions in common.h, and use these with FIELD_GET()
> to extract the fields from the version register.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

