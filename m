Return-Path: <netdev+bounces-85934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9A789CF0C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA53B24C6B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253731487C5;
	Mon,  8 Apr 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IxLk6pFn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC76146D40
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619945; cv=none; b=LoIcxGjHVgpvfeTRBBb85R46HvwW0dDHFqZbXGo9en05TAz4WBRc0gjtk2/X7zrmgQuvadUecXC0cVq0bRKwEEsJPQzia7zVsANU7ZdGPL0vuC81VGu7Smi4l3HZSuZxWEJte/ukyDk/Gve0DKS3Mz8rFVD4Q5ATGArGlW9VT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619945; c=relaxed/simple;
	bh=D8l8FGOWueD5LFvaFYdX86X6tBsOaX+ovAOGqWQJ7VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0jOVOfF8+yAKtFX5WzluuWxZnA5t/UbXcZy/WtLhQfHMpWwdatWEpsfS369d9xt3v1msSR0FNiF5wi1pSO9VlOGpAB1++OEORbkM5QzUhQ8I5laoE7qLpkOaIjTJSpSijon2a3qdo1VK1CpJqKLgINEo1PmlcR4iQ5G5iT1wzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IxLk6pFn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pxa0ssDc5EC64opouLE0vDIEoXfMcsipJRoQkkp17YY=; b=IxLk6pFnHIo+rIwlltinrmpwMS
	7MVjZJWoPysxzLXF4Y3ZUJOnFCepP3QebZsfO610P/DwPiigB5UDSv23Lvf8//nFrCMaPUblUaxB8
	HBMrCboSxzyIrBdOllYn47Iib1urFTDq2VIBK9szrkrwJqz9YgtK8XzX/5WmRkqrdxIQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtygE-00CWac-JH; Tue, 09 Apr 2024 01:45:38 +0200
Date: Tue, 9 Apr 2024 01:45:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <73f18ea6-bbaa-4125-9e58-56008d2a04c8@lunn.ch>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>

On Mon, Apr 08, 2024 at 12:19:25PM +0100, Russell King (Oracle) wrote:
> Rather than having a shim for each and every phylink MAC operation,
> allow DSA switch drivers to provide their own ops structure.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

