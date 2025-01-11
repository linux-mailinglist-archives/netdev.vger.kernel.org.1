Return-Path: <netdev+bounces-157431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC6A0A45E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE0C16A5FA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7401AF0B0;
	Sat, 11 Jan 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X5FQIHuM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8A18FC75
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736608411; cv=none; b=XA9jfLFSC01AAnkOaeavzIcz+H/OJtvbxyS8Z6NuTJM+tjkyJlpyyhZerNvzvKIP2WC/P5zEZdwwAAUJ3XnTMjye0TPdUmBHGqbpzUtCCRb9XCR9zbHMjwHGd6EaM7ggAGer+DcIYltcNNPW3nT7Wxwo/RA90XIogM7zsu4v3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736608411; c=relaxed/simple;
	bh=SQaaZGu3fFm8UmB7hakkKZuYJEe5ay2d1n7LpIa+xSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1IMsYTzd54+q8U3LiyMEVuwyK4F2XtpNJQNAWqU2X6f3KJOCGP+9T7Z+jNmoi6d7sUM+iHuX5oaBmpDlUAaS3BsxmeATc24DKwykWRBilRW7ZSCDRkoeija6n/V55UTg6W8TdjUrpAaAh+U08lwL237IeJ8v66C4ItfqceUyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X5FQIHuM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dFOV8G4SpGX2j9k3t3M6DAQvImlJuV1uLhKVrPWt5qQ=; b=X5FQIHuM/faA002i/neeuui8z5
	Wc2VuZmCcNqR3x4jsGu8ul7CzGMBKszp13exB5wcSlcnPzz9WSWb5Znj2QalfYYmPaDdnaht3wCAd
	+7XSrIX1UrcswyZcMGMLxtCklIZlqM+zL+5dcuDH9FMfZEdA3loIC3tUw/CALbF/RM/TcemY8E8Xa
	gxqirqjDz6kIJOlv3nJm+I99XlzDICMyK4aH2ojAAtj7YoI7mmPC0x9ov3s5BY4H5Tczgn1OgnxvA
	fTd4etd4lEUz3WdRDFdnrSVRWMyZyvVf3ykzvm+ZzwI6Po6OJQ01QFG6OGnubF2kBwHFF/C9GzfGc
	FI6fJqxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37826)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tWdAs-0004fl-2n;
	Sat, 11 Jan 2025 15:13:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tWdAp-00010W-3B;
	Sat, 11 Jan 2025 15:13:16 +0000
Date: Sat, 11 Jan 2025 15:13:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
Message-ID: <Z4KKi2WxSrben9-Z@shell.armlinux.org.uk>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
 <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
 <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
 <0212f9e8-8f60-461b-a7fe-bd4054f3689b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0212f9e8-8f60-461b-a7fe-bd4054f3689b@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 11, 2025 at 02:19:04PM +0100, Heiner Kallweit wrote:
> On 11.01.2025 11:01, Russell King (Oracle) wrote:
> > On Sat, Jan 11, 2025 at 10:44:25AM +0100, Heiner Kallweit wrote:
> >> On 11.01.2025 10:21, Russell King (Oracle) wrote:
> >>> On Sat, Jan 11, 2025 at 10:06:02AM +0100, Heiner Kallweit wrote:
> >>>> Link modes in phydev->eee_disabled_modes are filtered out by
> >>>> genphy_c45_write_eee_adv() and won't be advertised. Therefore
> >>>> don't accept such modes from userspace.
> >>>
> >>> Why do we need this? Surely if the MAC doesn't support modes, then they
> >>> should be filtered out of phydev->supported_eee so that userspace knows
> >>> that the mode is not supported by the network interface as a whole, just
> >>> like we do for phydev->supported.
> >>>
> >>> That would give us the checking here.
> >>>
> >> Removing EEE modes to be disabled from supported_eee is problematic
> >> because of how genphy_c45_write_eee_adv() works.
> >>
> >> Let's say we have a 2.5Gbps PHY and want to disable EEE at 2.5Gbps. If we
> >> remove 2.5Gbps from supported_eee, then the following check is false:
> >> if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES))
> >> What would result in the 2.5Gbps mode not getting disabled.
> > 
> > Ok. Do we at least remove the broken modes from the supported mask
> > reported to userspace?
> > 
> I think that's something we could do in addition, to provide a hint to the
> user about unavailable modes. It wouldn't remove the need for the check here.
> ethtool doesn't check the advertisement against the supported modes.
> And even if it would, we must not rely on input from user space being sane.

I disagree with some of this. Userspace should expect:

- read current settings
- copy supported modes to advertised modes
- write current settings

to work. If it fails, then how does ethtool, or even the user, work out
which link modes are actually supported or not.

If we're introducing a failure on the "disabled" modes, then that is
a user-breaking change, and we need to avoid that. The current code
silently ignored the broken modes, your new code would error out on
the above action - and that's a bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

