Return-Path: <netdev+bounces-174578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13822A5F5FF
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FCA17EBAD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C241760;
	Thu, 13 Mar 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f6kUMBlq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AADDDC
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872771; cv=none; b=DQskiK4EFkWHeZJPmTIf+893PZAvEzbSiREZyS4rxqPM+0Y5Mj9XDsT9h7oBKG3SaOVzTifs7scTJUDKtgJFoN7+EidFBIKVpNtPyRIneGHIbrkphqbSNI1tUOsMyQUpHKG54QMQOnjyZDrJsXhrsXJJMNq6u61S/9hJFKKZBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872771; c=relaxed/simple;
	bh=Ah4YUGW/LN3BQy3gGVRxji4N0GE+SdjE4VYwCRvh8iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keDdIArUHEMQt+W7O6bqzf3t0lxQm69XL+dVuWmqFVJyClBnf8zoR2Ap1HwCmtXryeibprUEo3G2RiNMcp+T1AK5p+rHBaXV6xG553U1fUDQNc7+ZjXl4ALG3nniaJrw7Ojk38n8HcqAXzbmo1VJD1gFyapIpgexoiSACpAgFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f6kUMBlq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LurvroALJiFFUqQVBPfZNyUS7B5O5JecXIdBbGhWMuQ=; b=f6kUMBlq4MkGaeexc5NT0xriiQ
	4rpww/4LWQ9zSeK9gC5NNzyJhfrpLUk75OQbZ9wL1/Yoim+9fhE7LDC6F1LpU16RGniRZpDMhGuJB
	2B/X27ncZjcp99C3NML0rT8VGHfnL2xJB9Kaq4HqqdyHL5YCt/gjeCqb0UMjUS6gyXuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsifp-00505E-BD; Thu, 13 Mar 2025 14:32:33 +0100
Date: Thu, 13 Mar 2025 14:32:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joao Pinto <jpinto@synopsys.com>,
	Lars Persson <larper@axis.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: stmmac: dwc-qos-eth: use devm_kzalloc() for AXI
 data
Message-ID: <a889db9a-1aa9-4a17-9762-01c74911e39b@lunn.ch>
References: <E1tsRyv-0064nU-O9@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tsRyv-0064nU-O9@rmk-PC.armlinux.org.uk>

On Wed, Mar 12, 2025 at 07:43:09PM +0000, Russell King (Oracle) wrote:
> Everywhere else in the driver uses devm_kzalloc() when allocating the
> AXI data, so there is no kfree() of this structure. However,
> dwc-qos-eth uses kzalloc(), which leads to this memory being leaked.
> Switch to use devm_kzalloc().
> 
> Fixes: d8256121a91a ("stmmac: adding new glue driver dwmac-dwc-qos-eth")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

