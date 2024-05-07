Return-Path: <netdev+bounces-93983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565AC8BDD18
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0001F24019
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1BD13C909;
	Tue,  7 May 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uFrcjpQY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD513C8FE;
	Tue,  7 May 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070313; cv=none; b=ufEQSr23KvLo1HJwx57O90S5hje+GqzXcn0JYndxqGYZ+Rwj2gI5d3t2yL/L5N97ec6YMrjjtKEt7E4LsRCR4xJ6HLzyTB16KemLZU8XKr3TjTmWNj0iAR/cjD226DLuPyakYeHspNzquwuOiOKSy+d0SAPQU3tZjsVqHBkCaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070313; c=relaxed/simple;
	bh=aO/h+F2//p2M80GykcrtBjuSGZbnrmUKjiredPkuMzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHapn0aaeds8r7TajkI0ta6tQJg8k7zPwd7CV7XBlysyVeaXLbiIa5xciKViLuug/M3OtnGyAT2deqRJMopxqXhiA4eOfYo6UOItTTM1j0vhdPX/ghTiouZfIEjlknk4suA9vo2ZSXM3ABekJsG2W6ZuJuxXLFP0+W0q+S0IyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uFrcjpQY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F5DZY8gU0+Joi+JnnaHOWLrQHFkVrDgQianYT2ENUU8=; b=uFrcjpQYVjV7Qo7+4gBRP9/uln
	tRp2hHvTWZq3OjM10nvDmB0FX2qA23iNLxx/dk1VWPNglPXHV8ooivvU9olm9f1NzS79jp7x2Ql03
	0cWYggr9wCynIE3GSjn54yklLtQuPJ1GGh20wwxoUikGR588wNN/JCG4i7hnIGQwJ2NFAZsZLeOk2
	cZNFp8o9XxMkG0rJb/Oxpfw/vXVWT6DM7f22KLh/bMADx0SouTSAR6UsN+6GpcfacDtdko4NG17Jk
	ZOKY8OGW+QFsVN7mJOIXUBUU3dKll5r76pbhrcy9epbFXWxq7NoGouX+wiwAPJRXcFcHirUa94cxw
	umUkP4lA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50346)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4G8G-0003RS-0R;
	Tue, 07 May 2024 09:25:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4G8F-0000BQ-M4; Tue, 07 May 2024 09:25:03 +0100
Date: Tue, 7 May 2024 09:25:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjnlX9/lm6OK39zl@shell.armlinux.org.uk>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjSwXghk/lsT6Ndo@HYD-DK-UNGSW21.microchip.com>
 <4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 06, 2024 at 03:28:33AM +0200, Andrew Lunn wrote:
> You should first answer Russell question. It could be a totally
> different scheme might come of of the discussion with Russell.

Yes please. We definitely need to get to the bottom of what is going
on here _before_ we come up with a solution.

If we don't understand the problem, whatever fix gets proposed is
probably going to be nothing more than a bodge job - and then someone
else is going to have a problem and propose another bodge job and so
we'll end up with bodge job on top of more bodge jobs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

