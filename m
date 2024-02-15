Return-Path: <netdev+bounces-72077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A83856890
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3871F214F1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26012DD9A;
	Thu, 15 Feb 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jJVYV1VB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D158AAC
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012442; cv=none; b=m9uIlrg8UUubUA22LAeVtP1AiqrBQTYJj0F7pKz4S7G4WJMFTDG21mzS95cOLVdw/NjZfy/+s0CQ8OO53Vmpi14O6gDxR+qYSCiZAJkzfH3sLHvhZi+QtrbB5kbzvbU6YKHARez9rCzCh2HDWnfPA+CMFAc3AOKCzKN1MbS2QtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012442; c=relaxed/simple;
	bh=Oc5+lPpSUiakDbqIfYv/gZBIsjCwGULH0qG6WAJ8Ruc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFROaZhtTWE11l//j+L072RF5v5L9sawep8uOEbaLI/xTtXF6f4lFM2KJBLkO9EIOSlSHtHP/QlNQ5nIiNGvjZtOPM4Oc0eu5CKLp8ge4906NW38VlSUf6ld4bdI5Mw8GTaaxdwdi5R0GBRpvpO6kn4MCeRTl8KOqqhMFdZnjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jJVYV1VB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0W+CbKKFQDzrq2lDw5NSSaJufxovEZSoYHS/h4el85o=; b=jJVYV1VBiRSHGuQdBS88qg3PNo
	z4e+eWAkuK0Fv86/Jv+w6EJpGP+PbQIadr5Fm0Mur/RWbaIkMXdVhUD1bo+iCkERslMZCrirxR8PD
	scl1jyu2eCHdOswX9TJmZ1h1brPZlg4tnlSdisxer0y9QzZgId6yJIo4H9VhRlv7rhan8CzjQ1x7v
	vTWhHgvW3KTZL7mcU5GIAw/9GLHP0uXdy0zvT/R+MddCOEAsNwhEUwqEGyCQETWG+krXLZmpdZ1Vk
	fqxyH49Wax5yLzMFhhAVC8O38sFFTdqKmvXdVc4Bpl0GkIfPUWMQNGxRmbhN3IBPlF4DINoUCSuOU
	4v2td/5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rae3S-0004NU-1z;
	Thu, 15 Feb 2024 15:53:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rae3Q-0004oX-AK; Thu, 15 Feb 2024 15:53:40 +0000
Date: Thu, 15 Feb 2024 15:53:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ethtool: check for unsupported modes in EEE
 advertisement
Message-ID: <Zc4zhPSceYVlYnWc@shell.armlinux.org.uk>
References: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 15, 2024 at 02:05:54PM +0100, Heiner Kallweit wrote:
> Let the core check whether userspace returned unsupported modes in the
> EEE advertisement bitmap. This allows to remove these checks from
> drivers.

Why is this a good thing to implement?

Concerns:
1) This is a change of behaviour for those drivers that do not
implement this behaviour.

2) This behaviour is different from ksettings_set() which silently
trims the advertisement down to the modes that are supported

3) This check is broken. Userspace is at liberty to pass in ~0 for
the supported mask and the advertising mask which subverts this
check.

So... I think overall, it's a NAK to this from me - I don't think
it's something that anyone should implement. Restricting the
advertisement to the modes that are supported (where the supported
mask is pulled from the network driver and not userspace) would
be acceptable, but is that actually necessary?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

