Return-Path: <netdev+bounces-208609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6ACB0C506
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C403A39E4
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DC2D6634;
	Mon, 21 Jul 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nrdI+M3a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89769288506;
	Mon, 21 Jul 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103913; cv=none; b=GI0KeGzla3VIgP/f68IEWW7kDt2StLz09G4eOLbR1KthGOdmdXCUxeyOtn6bG80e/94W5D92kX2h6c2ocx27vRNfuK7tIVHENLlS2LFIKxZY6ru0j1gtgRYpS7WP9BzvEROuT3jumTVNWUh5QpPMcpvH1EGbCHBrCj1nokttHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103913; c=relaxed/simple;
	bh=ze69DfQtUTiUtl9qXqdrt6eq8Ky5a+bDcxDuBqK96iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMlA0RONWM8Yt7p884qGzzR0Dl7j161OcS7fq3bcfCXgysurrWXiZB3K3BiSVvvCga80fykfqQI6OOU1Awra6Lo8lsloo+xizA14kbimlY9pr1j957utaumb0bP/u4jZudgVm3RRCkRLxWFIYbWfWylfvkvfEwr1P3EDJMiQ29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nrdI+M3a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Iu0MZizAD+mX37RbvQ2AbUD5OXOvKekOBhPm5ibu4+A=; b=nrdI+M3aQ0sLQJfdpr69XSIBWD
	hNljtDEm6EPT99GX7RmDm3zSlfR4wecZ0JMyDVhN+w7YICvUdQwd9lL6Y8j27Mp2db5FIyTRf0lE4
	86PFmxDKMDn9j+/26bSHkQNE8VCK223nPbCJLnK2AW2U50SOD8EgjR7M26tXt8XyffXE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udqPI-002MGi-2j; Mon, 21 Jul 2025 15:18:16 +0200
Date: Mon, 21 Jul 2025 15:18:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>

On Mon, Jul 21, 2025 at 02:10:48PM +0200, Gatien CHEVALLIER wrote:
> Hello Krzysztof,
> 
> On 7/21/25 13:30, Krzysztof Kozlowski wrote:
> > On 21/07/2025 13:14, Gatien Chevallier wrote:
> > > The "st,phy-wol" property can be set to use the wakeup capability of
> > > the PHY instead of the MAC.
> > 
> > 
> > And why would that be property of a SoC or board? Word "can" suggests
> > you are documenting something which exists, but this does not exist.
> Can you elaborate a bit more on the "not existing" part please?
> 
> For the WoL from PHY to be supported, the PHY line that is raised
> (On nPME pin for this case) when receiving a wake up event has to be
> wired to a wakeup event input of the Extended interrupt and event
> controller(EXTI), and that's implementation dependent.

How does this differ from normal interrupts from the PHY? Isn't the
presence of an interrupt in DT sufficient to indicate the PHY can wake
the system?

	Andrew

