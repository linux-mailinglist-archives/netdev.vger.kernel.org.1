Return-Path: <netdev+bounces-101486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0678FF0BE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D192880C0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A30B198A0B;
	Thu,  6 Jun 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cNKYQSt+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB019882E;
	Thu,  6 Jun 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687933; cv=none; b=Q/m9aTIo+l1FEstVCU7irXXg/zp/rmi7WjGxnGhHOoYzQ9JKnkCf55MkuZsjT4z5/iOMpY+mQc94Ot6rGlzktwPoEB26/wN4d+UnfY3Dw84/w4wLjCVZBNRsbj16y5v5cfQAYg3A88Ooq/1e3GxpeOhyB+zlKDuwuXh+L4xin9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687933; c=relaxed/simple;
	bh=e9b7O67biSQr3Vkb+Z4FukqqPXyNhKAwN6iuh+fjvYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6yCUoRymvom4pQxobDrBszbuVrIhwcxVQFpv2ZCN+/fG/Rnw+HZ34ny2kyMXBrWZL+4Cq7rP9T1vYrNpvpqVqgTKC/V/HHtg8JWpcq0AS4hXm+fIUBcmQlOeFmwd9c+8M4kOt6IZ/0KALyTLK33ySK+uAoqKKBznIylp/eNeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cNKYQSt+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O+j1gI0/6XSijnz/g/7kQxa5ff0QAlOQAsmOEq3HvEI=; b=cNKYQSt+8OlXKFORK3erELwpqA
	zjVvdj2YP+LLiTWSwTul1o4MxZVWMHGE7pD7TYMaTQl/hycm8zwg5QBJuPFkmSUg6VVXXodwad33n
	luwekayQiun191duTaHE7sk+XiD0Pr8kIJ3eZhvTfyWfeeYM2+AfqmHXuRvSzR8K8kLXsN0ikGVMe
	cuBXRrvekw3nw/+EA82+ediN8DoAe89cHhnUKl9+ALAsSWHrorAm/9FctbiQ2DVehr/9DGUk/YbWI
	vbIX3lBXYy3UpkVxjinKT0RzJXhtnWoHc8BOUJ2upkNLHFws6vvbnwcDRLqzBdG/K4Klym8vwrtHv
	fgTuMgQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35628)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sFF5n-0006Xx-23;
	Thu, 06 Jun 2024 16:31:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sFF5o-0003JG-GD; Thu, 06 Jun 2024 16:31:56 +0100
Date: Thu, 6 Jun 2024 16:31:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: sfp: Always call `sfp_sm_mod_remove()` on remove
Message-ID: <ZmHWbBheKycKjigC@shell.armlinux.org.uk>
References: <20240605084251.63502-1-csokas.bence@prolan.hu>
 <24a48e5a-efb3-4066-af6f-69f4a254b9c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24a48e5a-efb3-4066-af6f-69f4a254b9c3@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 06, 2024 at 05:21:45PM +0200, Andrew Lunn wrote:
> On Wed, Jun 05, 2024 at 10:42:51AM +0200, Csókás, Bence wrote:
> > If the module is in SFP_MOD_ERROR, `sfp_sm_mod_remove()` will
> > not be run. As a consequence, `sfp_hwmon_remove()` is not getting
> > run either, leaving a stale `hwmon` device behind. `sfp_sm_mod_remove()`
> > itself checks `sfp->sm_mod_state` anyways, so this check was not
> > really needed in the first place.
> > 
> > Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
> 
> I was expecting Russell to review this. Maybe he missed it.

I haven't missed it, I just haven't had the time to review and respond.
Work stuff is still very busy. I know this has been going on for well
over a month, but as it's partly coming from my employer and partly due
to medical stuff taking hours out of my working week, there's nothing
much I can do about it. I'm doing the best I can, but I know that I
can't keep up with what people expect of me at the moment.

I've had to tell Kory that I won't be able to review and test his
patch series - it's just totally impossible for me to be near the
hardware I need to test with his series _and_ have the time to do so.
I feel bad about that, because it's addressing the issue I raised a
number of years ago with PTP, yet I don't have the time to be involved
in that right now.

It's frustrating for me that I'm not able to do everything that I'd like
to...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

