Return-Path: <netdev+bounces-212883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05246B225ED
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2EF162F63
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF462E3B17;
	Tue, 12 Aug 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bJVy1O5g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B22C21D7;
	Tue, 12 Aug 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998425; cv=none; b=nmq1Wyd2bXpDuUfOOrhanDIMS3QNpvLefTTC8TzgEwElfAZedx4n/kvOI8vKug7ZPUWup+z2NljxEmNMN0dHQpcBYJ2tz1HIdmlSJe+i7oQNbexk30l21qnfcGoH781mA1oSj8VGnbO7d7xXMeMjqDe90JxzOmt6gGJM99sHmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998425; c=relaxed/simple;
	bh=h4oj1WhuRrapx4GHo/FKB4PFUHJ4LkPlpbn6wddZnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC1WYnMS09h4llLDEGqVSobaOHs68EcUU8Cf2pS/YSC1ksOccT/S+qG0KXMaTDrps9Z+5VaUdeqWhIFStKoVN+me72sW7gyVVFvC+BBUB4ZrjKoHj5nsRcgdqrbq20KM7r1yu4zVbHjmW41Knbg8nF4Z9toVqqnmhAaArC4DmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bJVy1O5g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MEBD3TpHaW1vadsSPwAt2sDJfbcaDwirw+PcwQCV5WA=; b=bJVy1O5gm96Ty50ADEC4XgIS1S
	s9G1Jjwl8igaIouXLNAfTS+tnqAA6eos7KqAZNzhzjrlY6mf8G71g58Kj7T4/UCGZ3hM3urSJRMlD
	jx37taTb7Cskg139OOo3QJ6VPd0gbDwuS3Vr5zXOa4G40MMFaMinMwLFz0b548gfOyd38irvF0r54
	ZfcHxdZiZFPKty6DM79qEB5GIWbpmUbLM3novZ7Dx0Q0xh92qgp9vxiy6DNPOsv7oUGMGDNQ8we4r
	ngt59GJ3yFN8iohk6q6HigcHW02Lmt7CgNkdHxoVOMC52dZLGTmtZKRDGH8hDawjZxkxk0Y8DqnDT
	lYmRzTKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50720)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ulnG7-0004n4-0w;
	Tue, 12 Aug 2025 12:33:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ulnG4-0004gB-1T;
	Tue, 12 Aug 2025 12:33:36 +0100
Date: Tue, 12 Aug 2025 12:33:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stas Sergeev <stsp@list.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: explicitly check in of_phy_is_fixed_link() for
 managed = "in-band-status"
Message-ID: <aJsmkAiV7tvFEeyA@shell.armlinux.org.uk>
References: <20250812105928.2124169-1-vladimir.oltean@nxp.com>
 <aJsj_zOGUinEke1o@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJsj_zOGUinEke1o@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 12, 2025 at 12:22:40PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 12, 2025 at 01:59:28PM +0300, Vladimir Oltean wrote:
> > And the other sub-case is when the MDIO-less PHY is also silent on the
> > in-band autoneg front. In that case, the firmware description would look
> > like this (b):
> > 
> > 	mac {
> > 		phy-mode = "sgmii";
> > 
> > 		fixed-link {
> > 			speed = <10000>;
> > 			full-duplex;
> > 		};
> > 	};
> > 
> > (side note: phylink would probably have something to object against the
> > PHY not reporting its state in any way, and would consider the setup
> > invalid, even if in some cases it would work. This is because its
> > configuration may not be fixed, and there would be no way to be notified
> > of updates)
> 
> Both of these are fully supported by phylink, and your side note is
> incorrect. Phylink provides all the functionality.
> 
> With the description in (b), if a MAC driver wishes to, it can provide
> phylink_config->get_fixed_state() and override the speed, duplex and
> pause in the same way that is possible with fixed PHY.
> 
> So, unless I missed something, I don't think your commit description
> is correct. If it is correct, it is ambiguous.

As an additional point, I'm not sure what has broken that justifies
this change for the net tree. You mention at one point in the commit
description about wanting to use "c73" as a string for "managed",
which suggests new development, and thus shouldn't this be targetting
net-next?

Note that at present, all dts files in the kernel either omit the
managed property, or have it present with value "in-band-status".

Thus, I think the commit makes sense for net-next.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

