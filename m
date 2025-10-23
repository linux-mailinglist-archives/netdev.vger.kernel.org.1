Return-Path: <netdev+bounces-232234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EA0C030D0
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 203334E397B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C0D33DEF3;
	Thu, 23 Oct 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l0QietyS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040F3019C7
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245108; cv=none; b=C5TURzJBeOEI8PQpLJ8ZEPdj2n+PmdvyluFKpXtuhwQXtxA3/7fP6m1Kv6fWp94x8puTgnwC9X8tlPqAKn9vv2oF8h23R+FPqUH7pJhnLgmYojckwql/nruLnfFVd1TjAEfgUEyfH3HSNbpkRTHcRVclcnnqRmgD+DN4W/yW5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245108; c=relaxed/simple;
	bh=o5L36dMCg/9r+cXqnKm7aRzReVZRKAFd4xxEhr6w8rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThoJwzuoMr8Rw4u+2sfEYPMgtTs9TIO4dYdRv0YXaUStjt51tzy7Te3kC0Na30S/DU+kJU5csLgMAChKQfqZNYvCSaAF4fJtEsTtVmJEYlM6uR2yLM1ACbXbMx9do2OvO5HcK/Q44knXZOFSiC20r58WdCR2WcjfrxcohlGXv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l0QietyS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OgaCyEM7L/8mt3oUm8lfVeAvLdE1lAEXA9Vr4r1Qdh4=; b=l0QietyS4aPXhRXiAtpuxntQKC
	+XmNwjnh+r73qlDSI9EUWHZt9PAjzN8SQdrz7qcKVl04utM8tEpGonhF1e44G6CYcy4MOxkwlBASa
	g8EN7Hl7+NVUTYGLA9QtFg+geW6vOljuZc1vyhUWb2bddevMOAKcEg8DQ7rktCYMjH8U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0Ix-00BuWG-O0; Thu, 23 Oct 2025 20:44:55 +0200
Date: Thu, 23 Oct 2025 20:44:55 +0200
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
Subject: Re: [PATCH net-next 1/8] net: stmmac: move version handling into own
 function
Message-ID: <01330327-7a9d-48c8-a99f-a5ac064e0ced@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrl6-0000000BMPl-18ag@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrl6-0000000BMPl-18ag@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:24AM +0100, Russell King (Oracle) wrote:
> Move the version handling out of stmmac_hwif_init() and into its own
> function, returning the version information through a structure.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

