Return-Path: <netdev+bounces-181336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD1A84846
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02EC4E1D76
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875C1EB1B9;
	Thu, 10 Apr 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KLjPic/a"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62D1EB19E;
	Thu, 10 Apr 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299696; cv=none; b=Qt1eB0JY3E1zu1cLPL/J5hNvKqB8d0Qgd8eIFy4rpWP0Pubkuqg69gtZsMf3QLHNmcCv+itLdnFpxOr6kFU7KCrErp3RaIyXF4A/g3iONjNBCNKoMOOs8jP668sY97S8dT7PCkNZM5fA3gDtaPD2Z9rDpM1ZY7gLty5wZbHfLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299696; c=relaxed/simple;
	bh=viJoT16Dko4EM6ZifhTxYMhd/X3njgMqptfmCNC1EO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf1xkYEaEBABWJD6speJ/TcW2t75KMzWmtG2CIMcyvo54aARryBurjb1yTi1RQ5XeeNtTZDucKz5pn6Wlh+JH23h7ghHkh/wRCEnk8BaakxrHViTeXH2Tt1o1WDjvq0OO6Pm/8wPRjjEAnhupmsgb3yu10i04W6FZlmEkKwcDnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KLjPic/a; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UAZhoCAjR8q9qo0ALdUNXnxEL8nlEi/xKakRLeZ+VoY=; b=KLjPic/avaWPJ8zDZ/exaor3WB
	QrtO6wEGe/nEVwLRV+ZwkNLueO/kaFTqg0Q9I2YaDbCETXAL2cdHbszXtJk9qqS7utSa29HC/LYFE
	wqliuc0HpGTancZGs3LZh11JZAukxIAXjR5UiHvRdNQOZez1+hd+aWfE84yYiykXA8oJELFw8A3B2
	yk/4QlKwcsPn8EPK6Avw2FQ1Ka4M95KLw6aecu132tMY4wD9ECh0X8Dn8XN43S8hhCeLZ1Sk1r1oA
	gaL3VF7sfQ8w+LF2ooyUe2yqvo7JGAwWHBawx9+crwtKhtJvAylwfO0X1i5+3huuZBWVlGerNHxPF
	BLlTFhWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48002)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2u1e-00026l-15;
	Thu, 10 Apr 2025 16:41:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2u1a-0003hD-1i;
	Thu, 10 Apr 2025 16:41:06 +0100
Date: Thu, 10 Apr 2025 16:41:06 +0100
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
Message-ID: <Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
References: <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
 <20250410111754.136a5ad1@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410111754.136a5ad1@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 10, 2025 at 11:17:54AM +0200, Kory Maincent wrote:
> On Wed, 9 Apr 2025 23:38:00 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > On Wed, Apr 09, 2025 at 06:34:35PM +0100, Russell King (Oracle) wrote:
> > > On Wed, Apr 09, 2025 at 06:04:14PM +0200, Kory Maincent wrote:  
> > > > On Wed, 9 Apr 2025 14:35:17 +0100
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > >   
> >  [...]  
> >  [...]  
> >  [...]  
> > > > 
> > > > So you are only testing the mvpp2 PTP. It seems there is something broken
> > > > with it. I don't think it is related to my work.  
> > > 
> > > Yes, and it has worked - but probably was never tested with PTPDv2 but
> > > with linuxptp. As it was more than five years ago when I worked on this
> > > stuff, I just can't remember the full details of the test setup I used.
> > > 
> > > I think the reason I gave up running PTP on my network is the problems
> > > that having the NIC bound into a Linux bridge essentially means that
> > > you can't participate in PTP on that machine. That basically means a
> > > VM host machine using a bridge device for the guests can't use PTP
> > > to time sync itself.
> > > 
> > > Well, it looks like the PHY based timestamping also isn't working -
> > > ptp4l says its failing to timestamp transmitted packets, but having
> > > added debug, the driver _is_ timestamping them, so the timestamps
> > > are getting lost somewhere in the networking layer, or are too late
> > > for ptp4l, which only waits 1ms, and the schedule_delayed_work(, 2) 
> > > will be about 20ms at HZ=100. Increasing the wait in ptp4l to 100ms
> > > still doesn't appear to get a timestamp. According to the timestamps
> > > on the debug messages, it's only taking 10ms to return the timestamp.
> > > 
> > > So, at the moment, ptp looks entirely non-functional. Or the userspace
> > > tools are broken.  
> > 
> > Right, got to the bottom of it at last. I hate linuxptp / ptp4l. The
> > idea that one looks at the source, sees this:
> > 
> >                 res = poll(&pfd, 1, sk_tx_timeout);
> >                 if (res < 1) {
> >                         pr_err(res ? "poll for tx timestamp failed: %m" :
> >                                      "timed out while polling for tx
> > timestamp"); pr_err("increasing tx_timestamp_timeout may correct "
> >                                "this issue, but it is likely caused by a
> > driver bug");
> > 
> > finds this in the same file:
> > 
> > int sk_tx_timeout = 1;
> > 
> > So it seemed obvious and logical that increasing that initialiser would
> > increase the _default_ timeout... but no, that's not the case, because,
> > ptp4l.c does:
> > 
> >         sk_tx_timeout = config_get_int(cfg, NULL, "tx_timestamp_timeout");
> > 
> > unconditionally, and config.c has a table of config options along with
> > their defaults... meaning that initialiser above for sk_tx_timeout
> > means absolutely nothing, and one _has_ to use a config file.
> > 
> > With that fixed, ptp4l's output looks very similar to that with mvpp2 -
> > which doesn't inspire much confidence that the ptp stack is operating
> > properly with the offset and frequency varying all over the place, and
> > the "delay timeout" messages spamming frequently. I'm also getting
> > ptp4l going into fault mode - so PHY PTP is proving to be way more
> > unreliable than mvpp2 PTP. :(
> 
> That's really weird. On my board the Marvell PHY PTP is more reliable than MACB.
> Even by disabling the interrupt.
> What is the state of the driver you are using? 

Right, it seems that some of the problems were using linuxptp v3.0
rather than v4.4, which seems to work better (in that it doesn't
seem to time out and drop into fault mode.)

With v4.4, if I try:

# ./ptp4l -i eth2 -m -s -2
ptp4l[322.396]: selected /dev/ptp0 as PTP clock
ptp4l[322.453]: port 1 (eth2): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[322.454]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[322.455]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[328.797]: selected local clock 005182.fffe.113302 as best master

that's all I see. If I drop the -2, then:

# ./ptp4l -i eth2 -m -s
ptp4l[405.516]: selected /dev/ptp0 as PTP clock
ptp4l[405.521]: port 1 (eth2): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[405.522]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPL
ETE
ptp4l[405.523]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[405.833]: port 1 (eth2): new foreign master d063b4.fffe.0243c3-1
Marvell 88E1510 f212a200.mdio-mii:00: rx timestamp overrun (q=0 stat=0x5 seq=227)
ptp4l[405.884]: port 1 (eth2): received SYNC without timestamp
ptp4l[409.833]: selected best master clock d063b4.fffe.0243c3
ptp4l[409.834]: foreign master not using PTP timescale
ptp4l[409.834]: running in a temporal vortex
ptp4l[409.834]: port 1 (eth2): LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[410.840]: master offset   -5184050 s0 freq  +10360 path delay     55766
ptp4l[411.841]: master offset   -5255393 s1 freq  -60982 path delay     55766
ptp4l[412.840]: master offset      61793 s2 freq    +811 path delay     55766
ptp4l[412.841]: port 1 (eth2): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
ptp4l[413.840]: master offset     -56367 s2 freq  -98811 path delay     73450
ptp4l[414.840]: master offset      62566 s2 freq   +3212 path delay     73450
ptp4l[415.840]: master offset     -18947 s2 freq  -59531 path delay     68353
ptp4l[416.840]: master offset      18277 s2 freq  -27991 path delay     62059
ptp4l[417.840]: master offset      -8628 s2 freq  -49413 path delay     62059
ptp4l[418.840]: master offset      44759 s2 freq   +1385 path delay     55766
ptp4l[419.840]: master offset     -40592 s2 freq  -70538 path delay     55766
ptp4l[420.840]: master offset      44689 s2 freq   +2565 path delay     42890
ptp4l[421.840]: master offset     -41672 s2 freq  -70389 path delay     42890
...
ptp4l[485.840]: master offset     -32192 s2 freq  -72387 path delay     47615
ptp4l[486.840]: master offset      58486 s2 freq   +8633 path delay     47615
ptp4l[487.840]: master offset     -57279 s2 freq  -89586 path delay     53535
ptp4l[488.840]: master offset      49431 s2 freq     -60 path delay     53535
ptp4l[489.840]: master offset     -55336 s2 freq  -89997 path delay     58247
ptp4l[490.840]: master offset      52156 s2 freq    +894 path delay     58247
ptp4l[491.840]: master offset     -56897 s2 freq  -92512 path delay     65986
ptp4l[492.840]: master offset      53392 s2 freq    +707 path delay     65986
ptp4l[493.840]: master offset     -35477 s2 freq  -72144 path delay     71031
ptp4l[494.840]: master offset      10634 s2 freq  -36676 path delay     71031
ptp4l[495.840]: master offset     -17451 s2 freq  -61571 path delay     71031
ptp4l[496.840]: master offset      52024 s2 freq   +2669 path delay     71031
ptp4l[497.840]: master offset     -36239 s2 freq  -69987 path delay     71031
ptp4l[498.840]: master offset      10968 s2 freq  -33652 path delay     71031
ptp4l[499.840]: master offset     -21116 s2 freq  -62445 path delay     61292
ptp4l[500.840]: master offset      56971 s2 freq   +9307 path delay     39904
ptp4l[501.840]: master offset     -29442 s2 freq  -60015 path delay     39904
ptp4l[502.840]: master offset      49644 s2 freq  +10239 path delay     37320
ptp4l[503.912]: master offset     -30912 s2 freq  -55424 path delay     37934
ptp4l[504.840]: master offset     -20782 s2 freq  -54568 path delay     41265

and from that you can see that the offset and frequency are very much
all over the place, not what you would expect from something that is
supposed to be _hardware_ timestamped - which is why I say that NTP
seems to be superior to PTP at least here.

With mvpp2, it's a very similar story:

ptp4l[628.834]: master offset      38211 s2 freq  -29874 path delay     62949
ptp4l[629.834]: master offset     -41111 s2 freq  -97733 path delay     66289
ptp4l[630.834]: master offset      33131 s2 freq  -35824 path delay     63864
ptp4l[631.834]: master offset     -55578 s2 freq -114594 path delay     63864
ptp4l[632.833]: master offset      34110 s2 freq  -41579 path delay     57582
ptp4l[633.834]: master offset     -13137 s2 freq  -78593 path delay     60047
ptp4l[634.834]: master offset      55063 s2 freq  -14334 path delay     49425
ptp4l[635.834]: master offset     -41302 s2 freq  -94180 path delay     49425
ptp4l[636.833]: master offset      11798 s2 freq  -53471 path delay     42796
ptp4l[637.834]: master offset     -31575 s2 freq  -93304 path delay     42796
ptp4l[638.833]: master offset      24722 s2 freq  -46480 path delay     46230
ptp4l[639.834]: master offset     -35568 s2 freq  -99353 path delay     52896
ptp4l[640.834]: master offset      56812 s2 freq  -17644 path delay     52896
ptp4l[641.834]: master offset     -63429 s2 freq -120841 path delay     66734
ptp4l[642.834]: master offset      56669 s2 freq  -19772 path delay     62778
ptp4l[643.834]: master offset     -31006 s2 freq  -90446 path delay     62778
ptp4l[644.834]: master offset      40576 s2 freq  -28166 path delay     54047
ptp4l[645.834]: master offset     -33082 s2 freq  -89651 path delay     54047
ptp4l[646.833]: master offset       7230 s2 freq  -59264 path delay     50476
ptp4l[647.834]: master offset     -19581 s2 freq  -83906 path delay     50476
ptp4l[648.833]: master offset      17652 s2 freq  -52547 path delay     50476
ptp4l[649.834]: master offset     -13170 s2 freq  -78073 path delay     50476
ptp4l[650.833]: master offset      18712 s2 freq  -50142 path delay     47967

Again, offset all over the place, frequency also showing that it doesn't
stabilise.

This _could_ be because of the master clock being random - but then it's
using the FEC PTP implementation with PTPD v2 - maybe either the FEC
implementation is buggy or maybe it's PTPD v2 causing this. I have no
idea how I can debug this - and I'm not going to invest in a "grand
master" PTP clock on a whim just to find out that isn't the problem.

I thought... maybe I can use the PTP implementation in a Marvell
switch as the network master, but the 88E6176 doesn't support PTP.

Maybe I can use an x86 platform... nope:

# ethtool -T enp0s25
Time stamping parameters for enp0s25:
Capabilities:
        software-transmit
        software-receive
        software-system-clock
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes: none
Hardware Receive Filter Modes: none

Anyway, let's try taking a tcpdump on the x86 machine of the sync
packets and compare the deviation of the software timestamp to that
of the hardware timestamp (all deviations relative to the first
packet part seconds):

16:30:30.577298 - originTimeStamp : 1744299061 seconds, 762464622 nanoseconds
16:30:31.577270 - originTimeStamp : 1744299062 seconds, 762363987 nanoseconds
   -28us						-100.635us
16:30:32.577303 - originTimeStamp : 1744299063 seconds, 762429696 nanoseconds
   +85us						-34.926us
16:30:33.577236 - originTimeStamp : 1744299064 seconds, 762328728 nanoseconds
   -62us						-135.894us
16:30:34.577280 - originTimeStamp : 1744299065 seconds, 762398770 nanoseconds
   -18us						-65.852us

We can see here that the timestamp from the software receive is far
more regular than the origin timestamp in the packets, which, in
combination with the randomness of both mvpp2 and the 88e151x PTP
trying to sync with it, makes me question whether there is something
fundamentally wrong with the FEC PTP implementation / PTPDv2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

