Return-Path: <netdev+bounces-88433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBB8A72EB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC221F22638
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7AE134436;
	Tue, 16 Apr 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rxRLrQvD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FD134425
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291377; cv=none; b=H/haV50NVhWdp0+UuOkOTmPaLkY3ASF94o2hbkAOuKSP/vFbDzaWQwMkkD4GvcRf7jhOaS7hC2SIZD3UYM4fUDK3JlDr0jiafbmoL8pOD5YXlm5nwxqXtlYAJKPsPgoJyJeivhdNbvnYeuPl/5+8RcE7Ng7Z4iD9JBJRllOEzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291377; c=relaxed/simple;
	bh=OoQ0a1Cn7FaCeJPx4DN3Lc0ZOMegJDCoEylRT8HpdgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuoKeAtIwpWdnh7vLBBOmloBDddg/5vwvJ7QVkOITJQz5+htHkYdp2E6jbatp+VogJ9dT/lrEqF0LBuOUzIuRJgLaCsi/VViCPClR1Q4BA/8SWNGDjE3ZxEO8QhRENK+8qhk6276Jn9IWTygIwyHMsWyGTQBqcfKotKpMx2tjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rxRLrQvD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dTKECMt9cHk1i0+6TIRQlYGHzql3YOg032n4aglyiC4=; b=rxRLrQvDjxoJ8RswJJ1YbqdZ4A
	RMDjU9+aSJbvMQx00JQscybSO4QWX6VT2mPhVGaZbhMMnlLv60StW0EJwJE4McrglTjsU8MsHV5WH
	CtqU0lYq8enT6ZD8aFgslncnpQkF3yLPDO+8mcViz9temN6XJGlBHJSQBhHRHY4uCaQl7qdI4xXeq
	0bUpZVB4gwO0i/poDxcfuhBwTmDMT+40hg6vmjRd5WHskJzFJVo+38LLAvACfKRtVfyGdIO2QUhaR
	7hAyd8OmNL7LOJ8zhRR7AfqWQ40t0Bu444uttd5MQhvzDBh9iaBoEVyiNKdxD+/qmDJqlYngG5x/t
	jpBehNGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53118)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwnLk-0000pB-0Z;
	Tue, 16 Apr 2024 19:16:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwnLk-00053F-Ef; Tue, 16 Apr 2024 19:16:08 +0100
Date: Tue, 16 Apr 2024 19:16:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: bcm_sf2: provide own phylink MAC
 operations
Message-ID: <Zh7AaJd4jno/NQDR@shell.armlinux.org.uk>
References: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
 <3b57b26c-3f1e-4db6-a584-59c84f16dcae@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b57b26c-3f1e-4db6-a584-59c84f16dcae@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 10:44:38AM -0700, Florian Fainelli wrote:
> On 4/16/24 03:19, Russell King (Oracle) wrote:
> > Convert bcm_sf2 to provide its own phylink MAC operations, thus
> > avoiding the shim layer in DSA's port.c
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Great, thanks for testing.

(Unrelated to this patch... so please don't delay applying based on
ongoing discussion!)

The other Broadcom driver, b53, isn't going to be as simple - I believe
it uses a mixture of the .adjust_link method for shared ports, and
.phylink_mac_* for user ports. That makes it very awkward now, given
the check that was added (and suggested by Vladimir) to check for the
legacy methods if dsa_switch's .phylink_mac_ops is populated.

Is there any scope for converting b53 to use only phylink methods for
everything, thus eliminating the .adjust_link callback?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

