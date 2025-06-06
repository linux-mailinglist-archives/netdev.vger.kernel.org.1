Return-Path: <netdev+bounces-195500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639CAD0966
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 23:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF933AE6C1
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 21:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1F230BF1;
	Fri,  6 Jun 2025 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BtXSTc54"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E384039
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244908; cv=none; b=cwGbVuCuDRQ+asSx68iKoioAI/RUWpRtVVHhFDnXRi/dowwQ1gXzOImoN4KfUUV2WjTUbRUA696kcgNxz5DgoM/oqcvfUPbvVRLMY2CXXxx33pQLakc0utoHfZSwIxCiGNygivozHKU+y3uJ7gPhrk6L55V1TJotJ9cMlEzz1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244908; c=relaxed/simple;
	bh=N0FDbV/IqGRqdLY6zSdIrMUln/GD3327Fchr4xJWw8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnA9mJWaQ/5NOpvz9BNvDSZUHoD0IWOQZilaMP5Sdvtj1wToB5RIYFH4cIQZKWdZ/ZZI2cAHNPoZj5h1hSdS/K7a9ziZ2f12Zny9O3/ofiJO6JJc5TurULaKkZiUI7jsr3QlMNtnWzQtOlCtsnIA9JwrlCH/oUim3hbLe9zJVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BtXSTc54; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+8i0qq5I394n5FTg/ubH+sy9iFc+cmepNaqLACN6CVE=; b=BtXSTc54QMV6d1f1FWxu9nUIqi
	xQNV5iWUismWQ4Fx0K+QEnNT3QngaM1/eS/Lntbj7C9w5on/z+4yLxYwNC47ZrTfJN0XAKzr2uCDt
	/zBJLavTjXnIEfjbbEQzslmagdBOjEOXhxaKBzEZ2H79E2ih+2c9TcxdWybqwULgqnrLJ6JNay2Ao
	wAkg7zEg1iX9DbmVgCas5bEL/A+IpFlFRWsUJDlxC3TBwEDdIQ65L9kJ66QleR3ai9edyqZU+DYqw
	O+hbQRCZC4btoaCoFBPSJZRBWxaTWE04koXjNhCgIsSwTJOrkOAXHOIyAmplA7UwYaGdD2lJJvNaY
	ILY3K3Og==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34438)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNeVQ-0001Cl-2U;
	Fri, 06 Jun 2025 22:21:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNeVO-0003Yk-0J;
	Fri, 06 Jun 2025 22:21:38 +0100
Date: Fri, 6 Jun 2025 22:21:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Morgan <macroalpha82@gmail.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aENb4YX4mkAUgfi2@shell.armlinux.org.uk>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
 <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 06, 2025 at 01:54:27PM -0500, Chris Morgan wrote:
> 	Option values					: 0x00 0x00

This suggests that LOS is not supported, nor any of the other hardware
signals. However, because early revisions of the SFP MSA didn't have
an option byte, and thus was zero, but did have the hardware signals,
we can't simply take this to mean the signals aren't implemented,
except for RX_LOS.

> I'll send the bin dump in another message (privately). Since the OUI
> is 00:00:00 and the serial number appears to be a datestamp, I'm not
> seeing anything on here that's sensitive.

I have augmented tools which can parse the binary dump, so I get a
bit more decode:

        Enhanced Options                          : soft TX_DISABLE
        Enhanced Options                          : soft TX_FAULT
        Enhanced Options                          : soft RX_LOS

So, this tells sfp.c that the status bits in the diagnostics address
offset 110 (SFP_STATUS) are supported.

Digging into your binary dump, SFP_STATUS has the value 0x02, which
indicates RX_LOS is set (signal lost), but TX_FAULT is clear (no
transmit fault.)

I'm guessing the SFP didn't have link at the time you took this
dump given that SFP_STATUS indicates RX_LOS was set?

Now, the problem with clearing bits in ->state_hw_mask is that
leads the SFP code to think "this hardware signal isn't implemented,
so I'll use the software specified signal instead where the module
indicates support via the enhanced options."

Setting bits in ->state_ignore_mask means that *both* the hardware
and software signals will be ignored, and if RX_LOS is ignored,
then the "Options" word needs to be updated to ensure that neither
inverted or normal LOS is reported there to avoid the state machines
waiting indefinitely for LOS to change. That is handled by
sfp_fixup_ignore_los().

If the soft bits in SFP_STATUS is reliable, then clearing the
appropriate flags in ->state_hw_mask for the hardware signals is
fine.

However, we have seen modules where this is not the case, and the
software bits seem to follow the wiggling of the hardware lines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

