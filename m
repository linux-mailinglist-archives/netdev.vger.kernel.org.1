Return-Path: <netdev+bounces-243863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60446CA8B4F
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7834300C0F0
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5102FF656;
	Fri,  5 Dec 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UaczHTgE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5542EFD91;
	Fri,  5 Dec 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957055; cv=none; b=lfyGK45C03Gpocs0LKgVW6Vhl4UKkrj20h76PaCzcjKzo5EmZHJduamxSdJpBcqKpoAstz2C22IOJG+XlGaLII4Y6uElPiob7sMH1nzR67A1HaEGp85VtVwPLbLyeM8HsAycYY0R1ko9NjM56DZfV2x7dASXA9IHAAqmwwTTSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957055; c=relaxed/simple;
	bh=G/i8x+2YdM0OZZ6L46Ly2GysVZdFJPleHoSQxr8pW7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmV8mr92nc3d1uCdgu0QGnIpTOmFmCkZ9Vu9wa7V1sD6tkcvrC6OCOK7KCbYzjIDXZBFf8d0jZbEXdWBC+dh6y/fOtQcI0TvBMoI67Jx61P8QQB31i+LiDyCgcWDD9G2AfGnDCFHF1jH882QXSbtIcAAPE3m7A7cvVMLPyOdxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UaczHTgE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MQ8dIiuQ1RvZuq3a+6+laYHtH9uSksOb5IgdNEId5a8=; b=UaczHTgEvBqI3zGutLf3vi8pOs
	7PRxwedzvPMC4H+Zl5aDoyIPFnmA3LBVi+mB7wKtWDxUUyidjoeXQ3n7SdCxX2HqZaAHIe62bUmOX
	qYQKxwbiCvK29+lIALcWUGlU3wYw3AQrhEQXL8zW5boPXRZgIfekXTQSp5xXQ6y0YO3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRZwx-00G7Pi-MM; Fri, 05 Dec 2025 18:50:35 +0100
Date: Fri, 5 Dec 2025 18:50:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC] powerpc: switch two fixed phy links to full duplex
Message-ID: <5d302153-c7f6-48dc-95cc-0dc4f25045c6@lunn.ch>
References: <64533952-1299-4ae2-860d-b34b97a24d98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64533952-1299-4ae2-860d-b34b97a24d98@gmail.com>

On Fri, Dec 05, 2025 at 06:21:50PM +0100, Heiner Kallweit wrote:
> These two fixed links are the only ones in-kernel specifying half duplex.
> If these could be switched to full duplex, then half duplex handling
> could be removed from phylib fixed phy, phylink, swphy.
> 
> The SoC MAC's are capable of full duplex, fs_enet MAC driver is as well.
> Anything that would keep us from switching to full duplex?

What do we know about the device on the other end of the link? Maybe
that is what is limiting it to 10Half?

	Andrew

