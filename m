Return-Path: <netdev+bounces-223533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B024DB596A7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0044E3354
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968D21B918;
	Tue, 16 Sep 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Uk5i0Twv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5A21B191;
	Tue, 16 Sep 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027192; cv=none; b=mP+dMOxLlsl3U8iwZYrsIglGUKydQLi803ibv3HbBphp2LYUQcQjCeL/lWgejnFO7mEyvBAjMJyZ/oUQXmZT2JPUBArTmX9ekmisk5kIH7Jy+8VgHYPL2iDvrndkQRgbTQR4IEDnzQ7AOi7oeMyyU5ItXEpEftApC+E8EmutN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027192; c=relaxed/simple;
	bh=oniK0cCAX6E5DZ2VwA/gcCxED5laAbQ7fxrrA9l4+yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYst2mCMPWCICiHMnX9UnDO10bXK9lif4nsUFumRqIatSu378ER0iuthCkpcz1xQIsCu3jaKmV69XmqvboYEegfVVymC8pxwefFcJwS33Eff1A8839zEQz27AxvmaOWidOzgYKUhbh3vhTqikv7Q8JFLCj3oiSCNJduDuCBGluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Uk5i0Twv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J4oCmuw0sq/K0niNulHuK3KOgu1SYsuejl/CWFXRiQM=; b=Uk5i0Twv3Pw/trPeTUtX65Yt8V
	7Dl1xgjlqupCehzyILxvnUldEAusW3sP50SlaRPsfwFl7C8jqhcs6m+U5weg5+WuXp6Kl0UY60+it
	boQtBldrnb0Lp34xg5VYWZLVxF5HeV08IE4YAIhCpmInAS2eZyeUjO/VVMGKbnmrz0Co=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyVB6-008Yyb-Gv; Tue, 16 Sep 2025 14:53:00 +0200
Date: Tue, 16 Sep 2025 14:53:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add Fast link failure support
 for lan8842
Message-ID: <d0839c6b-1a6a-4043-bdaf-b0f572b26792@lunn.ch>
References: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
 <698d4fbe-a84b-40cd-986f-1ebaecbf60b1@lunn.ch>
 <20250916073427.xohv2cywonkfzp5k@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916073427.xohv2cywonkfzp5k@DEN-DL-M31836.microchip.com>

On Tue, Sep 16, 2025 at 09:34:27AM +0200, Horatiu Vultur wrote:
> The 09/15/2025 14:42, Andrew Lunn wrote:
> 
> Hi Andrew,
> 
> > 
> > > +/**
> > > + * LAN8814_PAGE_PCS - Selects Extended Page 0.
> > > + *
> > > + * This page appaers to control the fast link failure and there are different

> And the reason why I say it 'appears' is because I have seen most of the
> registers are for debug and some timers.

So maybe change the comment to

	This page contains timers and debug registers...

It does not matter if the document is public or not, the description
is then correct and does not give the suggestion it is guesswork.

	Andrew

