Return-Path: <netdev+bounces-212882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 047ECB225D3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26744E2719
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB72EB5D2;
	Tue, 12 Aug 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PAi4hLhD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F923957D;
	Tue, 12 Aug 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997771; cv=none; b=b6u2TTLI+p0IZMm80JL7WrwO/03XVUcsa/37enJljQTPESj+J01oJTR7ARj7r/QUFAAyjTZ4o/bGwCYlzFJNu7BKrSUDET7BpuG8WH/JGfLt2Rif92ENf0mcFwZv3Sjyky6FnnH1ihsNdwBNfbm9cQ8/9lRIp4gP8e6PqysZ7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997771; c=relaxed/simple;
	bh=qzcMx1vzqM0C8OBAKfgbStyjDZPFSGsZtnF2h8G/hJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojMBFPw04gBujw3Qt57HZYJ+mNrj9MGMSbVpz8LKo/lP78BQ83XR8MpPXJMzFKxV1rbXpz3MZbBzjzWZBMACDs7pfZ2bXt9f+rVqr8Y+RbOOcrYDGZDBaRqzfZO65775U+E2tpPz7nv9eHdag7Xa9fNF/Wu4YH5QbYVxn3uzI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PAi4hLhD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NeiwArA8IxbBjpBiALz0RvqAbynbPbassjlsm3mLu2g=; b=PAi4hLhD8rwc5KC5v06wvImtuG
	UoTO4D7PWSAIr9HOJpkLV2KvEhVYbtzdU9+VgWtm84RAgZurfskpnN8hjEYQIpFTcONFTF3CFRpxh
	80VmsQP9GR2mbLgChuR0lOFZDX2cX3tTXU6AWO0vOMxXi7viZXZVXQC7Px1OEVciQMJNwhJTNuSRZ
	894Mr9492eFcDcnpMescuz9XjEo/3cPyfwIJFo9E7kuGqacpkvEhBMFfoOo+Ov+nbSbiFT5sDiPC6
	kB7+9YXfW9vy5WxZG9FC37BpE8ko++mRygz3EUFrKBYTSf8cm16iQQdD+rKTqFiPIukEXOZNZjcGN
	pVIoWeuA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55090)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uln5X-0004mR-2E;
	Tue, 12 Aug 2025 12:22:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uln5U-0004fp-0O;
	Tue, 12 Aug 2025 12:22:40 +0100
Date: Tue, 12 Aug 2025 12:22:39 +0100
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
Message-ID: <aJsj_zOGUinEke1o@shell.armlinux.org.uk>
References: <20250812105928.2124169-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812105928.2124169-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 12, 2025 at 01:59:28PM +0300, Vladimir Oltean wrote:
> And the other sub-case is when the MDIO-less PHY is also silent on the
> in-band autoneg front. In that case, the firmware description would look
> like this (b):
> 
> 	mac {
> 		phy-mode = "sgmii";
> 
> 		fixed-link {
> 			speed = <10000>;
> 			full-duplex;
> 		};
> 	};
> 
> (side note: phylink would probably have something to object against the
> PHY not reporting its state in any way, and would consider the setup
> invalid, even if in some cases it would work. This is because its
> configuration may not be fixed, and there would be no way to be notified
> of updates)

Both of these are fully supported by phylink, and your side note is
incorrect. Phylink provides all the functionality.

With the description in (b), if a MAC driver wishes to, it can provide
phylink_config->get_fixed_state() and override the speed, duplex and
pause in the same way that is possible with fixed PHY.

So, unless I missed something, I don't think your commit description
is correct. If it is correct, it is ambiguous.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

