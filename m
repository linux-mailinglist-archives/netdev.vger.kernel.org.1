Return-Path: <netdev+bounces-99424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8E8D4D6C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772B2284471
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838D186E48;
	Thu, 30 May 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cofttuqi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A85186E3F;
	Thu, 30 May 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077900; cv=none; b=ot4vzJKP1rBCwNXCRrQ3T45Ik4TbPeIRdqeSViIkEjIzaBGEwepayGda1vQ/i4q2YcPa1+ej9ElDjIRmIEZe5t3GI2iJ/L16m6PTFo2iInfTEuL0Jz0FF6tcWc1hE4cUtHPtf58SFZ6tuVSaTYA9ld0BI6w17AjdlbB9idIB6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077900; c=relaxed/simple;
	bh=pkETTqo1L5i6dCsPGWBv/kZtFquPctFL/nrgQUNQSpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrDfj9ayhW/+p3iwHZ1OdCl5fAHrusSZT3wnD/ShoGJZMn/AcsWY8bZHOLUAA7pPmZRsSJWcsBYu0xaYEVLSdkhy8k9bNPILAhIW2fW1SGpUN5O9Cbvq0LSwt6w+ZpB3bS+CMzor3wLSDyjjGL5S7mi/O5YLc9H0rgW2kxrYQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cofttuqi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YExquJyePSJqGdpvuFBG7W8z98CXju9/UOTlH9NVOl8=; b=cofttuqiyGIhomNYnWGBSr8MmL
	6mIBkRfYIdUFvXTqWwoX/drO71MRJc83E1wB85RV/he+IGneNJXatZV/KrGzA5SFVZoButqjbUoBI
	XA3cmjY9gKKwl3U30gWj/pIj641RzXMK1WM8xJ46Q/bu1zItiyBmg5M7csBgiETK/J//0UPTxVdSH
	LiEMd/ZdwcXn6A2+/6G5m1GluM0H1bExOvVRlYAPeCzV3slsJWB2y24VUWCVTvxkabfaMzCH99F7d
	LmPE9kIzWqnNRiJaN00kQfTWXxYLR5B4PMCxX2ylqRzUaQNHoMxguxBLViAlwUX6rnH0+x+zHiEv/
	zbS9eOww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49300)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCgOh-0007Sx-1f;
	Thu, 30 May 2024 15:04:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCgOj-0005C4-5L; Thu, 30 May 2024 15:04:53 +0100
Date: Thu, 30 May 2024 15:04:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, johanneswueller@gmail.com
Subject: Re: 6.9.3 Hung tasks
Message-ID: <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
 <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 09:36:45AM -0400, Genes Lists wrote:
> On Thu, 2024-05-30 at 08:53 -0400, Genes Lists wrote:
> > 
> > 
> This report for 6.9.1 could well be the same issue:
> 
> https://lore.kernel.org/lkml/e441605c-eaf2-4c2d-872b-d8e541f4cf60@gmail.com/

The reg_check_chans_work() thing in pid 285 is likely stuck on the
rtnl lock. The same is true of pid 287.

That will be because of the thread (pid 663) that's stuck in
__dev_open()...led_trigger_register(), where the rtnl lock will have
been taken in that path. It looks to me like led_trigger_register()
is stuck waiting for read access with the leds_list_lock rwsem.

There are only two places that take that rwsem in write mode, which
are led_classdev_register_ext() and led_classdev_unregister(). None
of these paths are blocking in v6.9.

Pid 641 doesn't look significant (its probably waiting for either
pid 285 or 287 to complete its work.)

Pid 666 looks like it is blocked waiting for exclusive write-access
on the leds_list_lock - but it isn't holding that lock. This means
there must already be some other reader or writer holding this lock.

Pid 722 doesn't look sigificant (same as pid 641).

Pid 760 is also waiting for the rtnl lock.

Pid 854, 855 also doesn't look sigificant (as pid 641).

And then we get to pid 858. This is in set_device_name(), which
was called from led_trigger_set() and led_trigger_register().
We know from pid 663 that led_trigger_register() can take a read
on leds_list_lock, and indeed it does and then calls
led_match_default_trigger(), which then goes on to call
led_trigger_set(). Bingo, this is why pid 666 is blocked, which
then blocks pid 663. pid 663 takes the rtnl lock, which blocks
everything else _and_ also blocks pid 858 in set_device_name().

Lockdep would've found this... this is a classic AB-BA deadlock
between the leds_list_lock rwsem and the rtnl mutex.

I haven't checked to see how that deadlock got introduced, that's
for someone else to do.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

