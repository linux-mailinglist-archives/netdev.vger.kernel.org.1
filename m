Return-Path: <netdev+bounces-180726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C4A8247B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CA5165A14
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCE2417C3;
	Wed,  9 Apr 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wXcsvVyx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F125E815;
	Wed,  9 Apr 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200990; cv=none; b=or5zq6Q+fjAO5WJO0uD7a48fh9+YXLBJyAlcbChlPRwQOsKpGX0QRJfoySWp0zBU94VKv1/sNTk5GMDnrzOFnF6dyHU6yzcQOIxaaeJqQ8WoEYBOL1SWCM5Upp01OZSh5xQ5YQqmPIzra/+a7XEOA5XbgiFmYKlpCpfOFPNLO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200990; c=relaxed/simple;
	bh=3VK9kXxXL1AtEOIE0bOBSoH2noYy+SCsFISB2Y5a5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnIj1+OZKeTMxNp5JHLeLsCBe7jrshstobY/3W8Z/RCB/XssqshJmouFVrJuDuXbYvYiGlB/ir7WI+L7vxFZ76AT4wOo0g9Wpac6i/J7mSsp7vMT1RCle1w/wes7SeRkwyisdjYO8hPIrp+zIql1NwCbM2Gc6THqYu5/pELnMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wXcsvVyx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nDH4pXLr5tMfpXqCIsvmy68bH6ccGDCzZhZerL82B2c=; b=wXcsvVyxUQ1hGxHZMGu/J/Mspn
	w13kyD6WyGZSNyg7h4GZnIzibhHEnyhKWMdgD+28cwXJxBO2BO6YWdfYSFuQwH6DOZZxSLmFp1OsB
	SKDxuSIEwEyWLSHCtZgLnWA9V5OnukyONAO3N45NWjzSYg5CyZ1P6DHr5jAhFTEBfkAW6M2aNfG4O
	uYTz9R3iAS4Rkiqj1B44WySdrlK5JbbgYZPYvyaY5C5N35V0+Ch7rJruk7Uwe3IZAOVzE73dYRehl
	xgK+AdsI9/Wfj5hsw7b/S1LdDF2S+VBaxUo+KN9e1TLbIG/Bcjv++pD7SHI2PG9K0Wms/Tti0ggxH
	FlxdxUVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53428)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2ULo-0000SX-04;
	Wed, 09 Apr 2025 13:16:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2ULk-0002Z8-0b;
	Wed, 09 Apr 2025 13:16:12 +0100
Date: Wed, 9 Apr 2025 13:16:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
 <20250408154934.GZ395307@horms.kernel.org>
 <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
 <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409104858.2758e68e@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 10:48:58AM +0200, Kory Maincent wrote:
> On Wed, 9 Apr 2025 09:33:09 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Apr 09, 2025 at 10:18:08AM +0200, Kory Maincent wrote:
> > > On Tue, 8 Apr 2025 18:32:04 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >   
> > > > On Tue, Apr 08, 2025 at 04:49:34PM +0100, Simon Horman wrote:  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> > > > 
> > > > ... and anyway, I haven't dropped my patches, I'm waiting for the
> > > > fundamental issue with merging Marvell PHY PTP support destroying the
> > > > ability to use MVPP2 PTP support to be solved, and then I will post
> > > > my patches.
> > > > 
> > > > They aren't dead, I'm just waiting for the issues I reported years ago
> > > > with the PTP infrastructure to be resolved - and to be tested as
> > > > resolved.
> > > > 
> > > > I'm still not convinced that they have been given Kory's responses to
> > > > me (some of which I honestly don't understand), but I will get around
> > > > to doing further testing to see whether enabling Marvell PHY PTP
> > > > support results in MVPP2 support becoming unusable.
> > > > 
> > > > Kory's lack of communication with me has been rather frustrating.  
> > > 
> > > You were in CC in all the series I sent and there was not a lot of review
> > > and testing on your side. I know you seemed a lot busy at that time but I
> > > don't understand what communication is missing here?   
> > 
> > I don't spend much time at the physical location where the hardware that
> > I need to test your long awaited code is anymore. That means the
> > opportunities to test it are *rare*.
> > 
> > So far, each time I've tested your code, it's been broken. This really
> > doesn't help.
> > 
> > If you want me to do anything more in a timely manner, like test fixes,
> > you need to get them to me by the end of this week, otherwise I won't
> > again be able to test them for a while.
> 
> You could try again with Vlad patch adding support to ndo_hwtstamp_get/set to
> the mvpp2 drivers.
> https://github.com/vladimiroltean/linux/commit/5bde95816f19cf2872367ecdbef1efe476e4f833

Well, I'm not sure PTP is working correctly.

On one machine (SolidRun Hummingboard 2), I'm running ptpd v2:

2025-04-09 11:34:19.590032 ptpd2[7284].startup (info)      (___) Configuration OK
2025-04-09 11:34:19.594624 ptpd2[7284].startup (info)      (___) Successfully acquired lock on /var/run/ptpd2.lock
2025-04-09 11:34:19.596099 ptpd2[7284].startup (notice)    (___) PTPDv2 started successfully on end0 using "masteronly" preset (PID 7284)
2025-04-09 11:34:19.596347 ptpd2[7284].startup (info)      (___) TimingService.PTP0: PTP service init
# Timestamp, State, Clock ID, One Way Delay, Offset From Master, Slave to Master, Master to Slave, Observed Drift, Last packet Received, One Way Delay Mean, One Way Delay Std Dev, Offset From Master Mean, Offset From Master Std Dev, Observed Drift Mean, Observed Drift Std Dev, raw delayMS, raw delaySM
2025-04-09 11:34:19.596685, init,
2025-04-09 11:34:19.699787 ptpd2[7284].end0 (notice)    (lstn_init) Now in state: PTP_LISTENING
2025-04-09 11:34:19.699915, lstn_init,  1
2025-04-09 11:34:29.596621 ptpd2[7284].end0 (notice)    (lstn_init) TimingService.PTP0: elected best TimingService
2025-04-09 11:34:29.596758 ptpd2[7284].end0 (info)      (lstn_init) TimingService.PTP0: acquired clock control
2025-04-09 11:34:31.701104 ptpd2[7284].end0 (notice)    (mst) Now in state: PTP_MASTER, Best master: d063b4fffe0243c3(unknown)/1 (self)
2025-04-09 11:34:31.701369, mst, d063b4fffe0243c3(unknown)/1

with this configuration:

ptpengine:interface=end0
ptpengine:preset=masteronly
ptpengine:multicast_ttl=1
clock:no_adjust=y
clock:no_reset=y

On the test machine (Macchiatobin), I'm running linuxptp ptp4l:

# ./ptp4l -i eth2 -m -s -l 7
...
ptp4l[2701.638]: master offset     -30111 s2 freq  -91915 path delay     63039
ptp4l[2701.725]: port 1: delay timeout
ptp4l[2701.726]: delay   filtered      63039   raw      40846
ptp4l[2702.253]: port 1: delay timeout
ptp4l[2702.254]: delay   filtered      63039   raw      43806
ptp4l[2702.638]: master offset      29689 s2 freq  -41148 path delay     63039
ptp4l[2703.638]: master offset     -14050 s2 freq  -75981 path delay     63039
ptp4l[2703.993]: port 1: delay timeout
ptp4l[2703.993]: delay   filtered      62371   raw      48094
ptp4l[2704.255]: port 1: delay timeout
ptp4l[2704.255]: delay   filtered      61726   raw      49767
ptp4l[2704.638]: master offset      16434 s2 freq  -49712 path delay     61726
ptp4l[2705.570]: port 1: delay timeout
ptp4l[2705.571]: delay   filtered      61726   raw      68302
ptp4l[2705.638]: master offset     -33159 s2 freq  -94374 path delay     61726
ptp4l[2706.638]: master offset      28762 s2 freq  -42401 path delay     61726
ptp4l[2707.254]: port 1: delay timeout

The "delay timeout" and random master offsets doesn't look like PTP is
working correctly.

tcpdump on the Macchiatobin shows:

13:08:34.701122 d0:63:b4:02:43:c3 > 01:00:5e:00:01:81, ethertype IPv4 (0x0800), length 86: 192.168.0.240.319 > 224.0.1.129.319: PTPv2, v1 compat : no, msg type : sync msg, length : 44, domain : 0, reserved1 : 0, Flags [two step], NS correction : 0, sub NS correction : 0, reserved2 : 0, clock identity : 0xd063b4fffe0243c3, port id : 1, seq id : 5642, control : 0 (Sync), log message interval : 0, originTimeStamp : 1744200514 seconds, 700022395 nanoseconds
13:08:34.701123 d0:63:b4:02:43:c3 > 01:00:5e:00:01:81, ethertype IPv4 (0x0800), length 86: 192.168.0.240.320 > 224.0.1.129.320: PTPv2, v1 compat : no, msg type : follow up msg, length : 44, domain : 0, reserved1 : 0, Flags [none], NS correction : 0, sub NS correction : 0, reserved2 : 0, clock identity : 0xd063b4fffe0243c3, port id : 1, seq id : 5642, control : 2 (Follow_Up), log message interval : 0, preciseOriginTimeStamp : 1744200514 seconds, 700078731 nanoseconds
13:08:35.146133 00:51:82:11:33:02 > 01:00:5e:00:01:81, ethertype IPv4 (0x0800), length 86: 192.168.1.96.319 > 224.0.1.129.319: PTPv2, v1 compat : no, msg type : delay req msg, length : 44, domain : 0, reserved1 : 0, Flags [none], NS correction : 0, sub NS correction : 0, reserved2 : 0, clock identity : 0x5182fffe113302, port id : 1, seq id : 13, control : 1 (Delay_Req), log message interval : 127, originTimeStamp : 0 seconds, 0 nanoseconds
13:08:35.146529 d0:63:b4:02:43:c3 > 01:00:5e:00:01:81, ethertype IPv4 (0x0800), length 96: 192.168.0.240.320 > 224.0.1.129.320: PTPv2, v1 compat : no, msg type : delay resp msg, length : 54, domain : 0, reserved1 : 0, Flags [none], NS correction : 0, sub NS correction : 0, reserved2 : 0, clock identity : 0xd063b4fffe0243c3, port id : 1, seq id : 13, control : 3 (Delay_Resp), log message interval : 0, receiveTimeStamp : 1744200515 seconds, 145324449 nanoseconds, port identity : 0x5182fffe113302, port id : 1
13:08:35.701268 d0:63:b4:02:43:c3 > 01:00:5e:00:01:81, ethertype IPv4 (0x0800), length 106: 192.168.0.240.320 > 224.0.1.129.320: PTPv2, v1 compat : no, msg type : announce msg, length : 64, domain : 0, reserved1 : 0, Flags [none], NS correction : 0, sub NS correction : 0, reserved2 : 0, clock identity : 0xd063b4fffe0243c3, port id : 1, seq id : 2821, control : 5 (Other), log message interval : 1, originTimeStamp : 0 seconds 0 nanoseconds, origin cur utc :0, rsvd : 130, gm priority_1 : 128, gm clock class : 13, gm clock accuracy : 254, gm clock variance : 65535, gm priority_2 : 128, gm clock id : 0xd063b4fffe0243c3, steps removed : 0, time source : 0xa0
13:08:35.701268 d0:63:b4:02:43:c3 > 01:00:5e:00:01:81, ethertype IPv4 (0x0800), length 86: 192.168.0.240.319 > 224.0.1.129.319: PTPv2, v1 compat : no, msg type : sync msg, length : 44, domain : 0, reserved1 : 0, Flags [two step], NS correction : 0, sub NS correction : 0, reserved2 : 0, clock identity : 0xd063b4fffe0243c3, port id : 1, seq id : 5643, control : 0 (Sync), log message interval : 0, originTimeStamp : 1744200515 seconds, 700230163 nanoseconds

So we can see that ptpdv2 is responding to the delay requests, but it
seems that ptp4l doesn't see them, but it is seeing the other messages
from the HB2 running in master mode. I don't have time to investigate
any further until later today, and then again not until tomorrow
evening.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

