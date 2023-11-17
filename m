Return-Path: <netdev+bounces-48736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BFA7EF5FE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28973B209C8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F3DF4E;
	Fri, 17 Nov 2023 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PgtXcimP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266DA4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wnDjgL4d+2o/v9Sbm9sHGem19FFKBP8oU9Mh6f3EWio=; b=PgtXcimPRtifUsiJaRYRHwVMJv
	FdP029rd809cmRqmzlEN0TSZUIWHoShTISl0tSQ4hqhqPiIWRcfeezMIFYzttPFNeCDC0UuUfcaSd
	wuQ+i038/TXaTyIhgnm0Kq2luSxpw0kD5+CsTA5H0pvWqSHN6Uk3jCh0/A5qY0JqK+9YK71DGz7OT
	G0XiFe0egPAupQXd1orXQNe9TQHIq25I1hiS3jTrIELAnvJa+k6Iw2sppUz6JcLydcmT9nRgDkodw
	+CDLaKU5zuYFFtA22IJ3lz4dT8DJ5A7gXZgxW9i6QlbLHJDsC+8KH37DNBkAsO1A9HbiXV14od2XV
	tkSsRM5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34070)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r41Wz-00031T-2z;
	Fri, 17 Nov 2023 16:17:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r41X0-0000Go-PD; Fri, 17 Nov 2023 16:17:22 +0000
Date: Fri, 17 Nov 2023 16:17:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: use for_each_set_bit()
Message-ID: <ZVeSEv2nN1xioYz5@shell.armlinux.org.uk>
References: <E1r3yPo-00CnKQ-JG@rmk-PC.armlinux.org.uk>
 <84b4b1b4-83e7-477b-9316-21c7a76689aa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b4b1b4-83e7-477b-9316-21c7a76689aa@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 17, 2023 at 05:15:17PM +0100, Andrew Lunn wrote:
> > +		t = *state;
> > +		t.interface = interface;
> > +		if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
> > +			linkmode_or(all_s, all_s, s);
> > +			linkmode_or(all_adv, all_adv, t.advertising);
> >  		}
> >  	}
> >  
> > +
> >  	linkmode_copy(supported, all_s);
> 
> Adding another blank line here was probably unintentional?

Hmm, indeed, thanks for spotting. I always forget whether I'll need to
send a v2 for something this trivial or whether netdev folk will fix
it up when committing it. I'm happy to resend.

> Otherwise:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

