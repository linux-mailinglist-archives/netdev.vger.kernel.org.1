Return-Path: <netdev+bounces-180337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CCA80FF2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434581883B33
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23921227E98;
	Tue,  8 Apr 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ojAjtyYn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A3185935;
	Tue,  8 Apr 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125805; cv=none; b=F0857Rl8l5h7b+scglR7Zhdfw6SZqGQvXX3NQEjxrd2M4wqb+PKF9PQA0dxpTw6OCa21Saav2fZLhHIjxoL+7gUv+xqNP8M+aBwszZufBih8mVHPapqKdenYHWYYtqUnMotBX0JC/LCS2+ksw4PkoJxMB83Qr0Y+rtEYGRt7Mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125805; c=relaxed/simple;
	bh=FKQ8UxKLLhE8D7Xw7HVrJwJgjOHHrWPXyNKRQl0mb3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGBIcpQYbJ/8gafctESIscFF5DfHFUQXiEOSbrMFn1gmuqVQqTDlrP7K9lSleq+g/VrAPL/K3zsLo8ka0HQlDOJcTGF1Dyo0hGUcJQE1AXs7jTS9I05hNJ+UUBcEPTq+P/pSXqJgh9n/d424XD6uLINMMBa/mt6U31MPb5btuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ojAjtyYn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=57GOkhRAEmABzLV8CjqEEgiNHZ46CcdaW9aZ9L3Mwv0=; b=ojAjtyYnPweJhd8q7Rd6rDR5SW
	viR2eHTLEQwbrcJqk9r9NmU8uxwmxlVhwwAYZWogQoOczHyHMpCaEt7zH4RybJeUuhkQgAKHHUwpC
	JPoljrBv2pdIDGNZkitahaFQpGOiA8M4+BupqPh8Qw1IFRRPRVcAN5O3oF6D+5GD+ZyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2AnC-008PkL-2g; Tue, 08 Apr 2025 17:23:14 +0200
Date: Tue, 8 Apr 2025 17:23:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Pazdan <mpazdan@arista.com>
Cc: aleksander.lobakin@intel.com, almasrymina@google.com,
	andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com, davem@davemloft.net, ecree.xilinx@gmail.com,
	edumazet@google.com, gal@nvidia.com, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, jianbol@nvidia.com,
	kory.maincent@bootlin.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com, willemb@google.com
Subject: Re: [Intel-wired-lan] [PATCH 2/2] ice: add qsfp transceiver reset
 and presence pin control
Message-ID: <d55a3455-defd-4b23-9e0f-42d87e25f72d@lunn.ch>
References: <6ad4b88c-4d08-4a77-baac-fdc0e2564d5b@lunn.ch>
 <20250408151439.29489-1-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408151439.29489-1-mpazdan@arista.com>

On Tue, Apr 08, 2025 at 02:22:43PM +0000, Marek Pazdan wrote:
> On Mon, 7 Apr 2025 22:30:54 +0200 Andrew Lunn wrote:
> 
> > As the name get/set-phy-tunable suggests, these are for PHY
> > properties, like downshift, fast link down, energy detected power
> > down.
> > 
> > What PHY are you using here?
> 
> Thanks for review.
> It's PHY E810-C in this case. According to spreadsheet: E810_Datasheet_Rev2.4.pdf
> (Chapter 17.3.3 E810 SDP[0:7] (GPIO) Connection), it's SDP0 and SDP2 GPIOs 
> are being connected to QSFP Reset and Presence pins correspondingly.
> I assume you may suggest this use case is not directly PHY related. In first approach
> I tried to use reset operation which has following flag in enum ethtool_reset_flags:
> ETH_RESET_PHY           = 1 << 6,       /* Transceiver/PHY */
> but this doesn't allow for reset asserting and later deasserting so I took 'get/set-phy-tunable'.

This does look like an abuse of the phy tunables. Lets get the big
picture, and then we can maybe suggest a better API.

Please consider my previous questions, how do you tell the kernel not
to use the SFP?  How do you ensure you don't reset the SFP in the
middle of the kernel performing a firmware upgrade of the SFP, etc.

	Andrew

