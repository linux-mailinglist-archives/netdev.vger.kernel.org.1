Return-Path: <netdev+bounces-238617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6A9C5C00B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 592964E5A5F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743E02FB62A;
	Fri, 14 Nov 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rUKOGdDa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459C2F6906;
	Fri, 14 Nov 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109176; cv=none; b=T9KtjzuTU2hNwQY6F5pns66hbw9iEfvDq2iC/Nx59v0vvIBtaCZNirINr7GJV5FVX+BPN+2S5Di7PUDYvG4FcnZF+JLC8O9ivi0Vu05NrOr3yYgX8YD2hfBJae1bUVHzXedKt57VjOmKjnktQz/YSSaWaqOHe6xZDtbr4ACyWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109176; c=relaxed/simple;
	bh=6HmJCtfoVtrna1grsY5FP1KeHS+m2xW7jAYyXiaGshc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGV80KaVnoCVTK6ohde+LzWdgJDpYfCT4krrDKtTlrA/YNV/dWDXaMetW8mgEenH794f0hxvEtB9O2Ejdc9Emwxv0zep4ET1mam3Zo44xgOAeGguHlALCwX0H4D9g4zIgpB0Qpi05TjLxyDeSQzqgR5YVeg4SGumUWXVO7Zejrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rUKOGdDa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8zJqMVY8MVQYh0NTjwhA0FACuisKfjySbDfOH1X4nhI=; b=rUKOGdDa9K8kEG42Nr/Bzi0MoW
	Spv3KuznWLcX2q9ASaxLgQ8fyOffDaE4pPiZdgcTM3/E887/tWbC7jZb7BOHBHL7DJM5OFxBNau0x
	SuUF+9eaxlsUI09RLW3zliFAebiPSRotnmR7G1oGdefLLAxwJ1wjW8mOg4AJs7PYdYEziFLKRYG/L
	qhb6ydtnU9sBHKIZ0og+t84DvdaOCzVZ9AoeG/DrEtCVmArh9n0yvIAIZ27r3jYOfZWngaWtwHiMn
	A1zIiQN0ZLe5f17bvlruAE0K548a4OgPQxRDvHF0OW11q5voDs5xlU+nLoVcXp2vu2lHOviBHER5J
	1JkcoHVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35020)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJpEa-000000006aC-3uZK;
	Fri, 14 Nov 2025 08:32:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJpEX-000000005hS-3PqA;
	Fri, 14 Nov 2025 08:32:41 +0000
Date: Fri, 14 Nov 2025 08:32:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <aRbpKcrzF9xMicax@shell.armlinux.org.uk>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114052808.1129942-1-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 14, 2025 at 01:28:08PM +0800, Wei Fang wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link.

What problem does this cause?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

