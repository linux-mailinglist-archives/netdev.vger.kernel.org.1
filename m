Return-Path: <netdev+bounces-133574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338EC99654C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4E281502
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF8188920;
	Wed,  9 Oct 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OJdldgua"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED163BB48
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466080; cv=none; b=pO5JEPti6POTL520knAB/ZxYgpkWH8AlKr9a9KtDpw0jf8Fxjjjb73uoNnccEppBv8mr4lERLqDCDE7kxYLp96fDS/FNLOXcXXQeb1pnXQNnVs0i7Hm2W1PNuD4XoprwFkJYWIluy9B3JosUP+Rrxw1Rz03RmzrFkM4ofg/WfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466080; c=relaxed/simple;
	bh=c73DPsb99qUCTu5mCjgZ+3ERza6JeRZ4OYVIEyyQEfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohNBoXlwpsbEc6+N46RiIZlGP0kJ/alJpn5glEmz9I/i9TE36W/yJ1k0ZOP1iD5VWUSdoOwerkPcKsZNmIQT1FCfIw31eP5UFDKVPnCQo6QJtc9lYjqDYqGZr8Gd6b5btwilShLqzOdYAN2slAdTM6Q0UnAtIj/pZu7j88CH/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OJdldgua; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9/hOAet8dyoHvwrQgFKsUrBGRXMZB9FOFRUuwdCgNxA=; b=OJdldgua3myo4n3W6ysB0O44lM
	+Y4e1m5eWFSu692CAlBJUXC5FtA10mzFXsbAugHvDvigHHjhTkhDUQsqRwPS+fDAZRc3iecd0iZZY
	eECQfjuVPAXUyfyLhhSPnRWxAnV/YT984CmMAoe3WNRqGirfNedCjbfDJ4SyTdZL+EdetjWROhcfZ
	pyxr6LVyCz8ZRhQvEyqj3sS9yVNPsR3WnuCJVsqYtbljMqjyBznXux64haA1gWC1ngLZIrO3tID76
	yAjP835qglfa0NxXuBnicUXi03kjUazFRaqUYhm5K1Mcre31nA2aCob+sCmhca0osyDF8DasurcFx
	yUJxHYhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41634)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sySym-0000Hb-2W;
	Wed, 09 Oct 2024 10:27:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sySyg-0006B1-1r;
	Wed, 09 Oct 2024 10:27:30 +0100
Date: Wed, 9 Oct 2024 10:27:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <ZwZMglQLdg-5XPwm@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
 <vjmounqvfxzqpdsvzs5tzlqv7dfb4z2nect3vmuaohtfm6cn3t@qynqp6zqcd3s>
 <rxv7tlvbl57yq62obsqtgr7r4llnb2ejjlaeausfxpdkxgxpyo@kqrgq2hdodts>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxv7tlvbl57yq62obsqtgr7r4llnb2ejjlaeausfxpdkxgxpyo@kqrgq2hdodts>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 03:02:46AM +0300, Serge Semin wrote:
> On Sat, Oct 05, 2024 at 02:40:42AM GMT, Serge Semin wrote:
> > Hi
> > 
> > On Fri, Oct 04, 2024 at 11:19:57AM GMT, Russell King (Oracle) wrote:
> > > This is the second cleanup series for XPCS.
> > > 
> > > ...
> > 
> > If you don't mind I'll test the series out on Monday or Tuesday on the
> > next week after my local-tree changes concerning the DW XPCS driver
> > are rebased onto it.
> 
> As promised just finished rebasing the series onto the kernel 6.12-rc2
> and testing it out on the next HW setup:
> 
> DW XGMAC <-(XGMII)-> DW XPCS <-(10Gbase-R)-> Marvell 88x2222
> <-(10gbase-r)->
> SFP+ DAC SFP+
> <-(10gbase-r)->
> Marvell 88x2222 <-(10gbase-r)-> DW XPCS <-(XGMII)-> DW XGMAC
> 
> No problem has been spotted.
> 
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

Thanks. However, it looks like patchwork hasn't picked up your
tested-by. Maybe it needs to be sent in reply to the cover message
and not in a sub-thread?

https://patchwork.kernel.org/project/netdevbpf/list/?series=895512

Maybe netdev folk can add it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

