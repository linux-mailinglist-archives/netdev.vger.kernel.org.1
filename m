Return-Path: <netdev+bounces-171496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95BA4D316
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 06:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA231894002
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 05:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA391F427D;
	Tue,  4 Mar 2025 05:40:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DD1F4720
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066840; cv=none; b=WWmi6IxcVIMG2t/m69YG9RhQBhZzxWPRmSXQwAB3DySAkOzJARc1HK2oa39G7Tuqj60h/fLF8o20aHcBiLqOj59nTTRceyWedL0MYc/FAGrwonxAFFN5D14Ur5fPOsHNsR9ncLm1OeSENTtMys9qXCUSEYV/xjIXgamG9OqIfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066840; c=relaxed/simple;
	bh=RzWWlN24um2t0bNwaHA7G4LpVlumrLRY5pALD22MJlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li8Vh0wv9gB6L5V2FBL+0MorJhGiWcuh7LbtRikDbCAy0FyQfOp9fQz5IcchdjxepFPP8CobeMWLdteZkLjR/l2Nas9m+GNA20Y6/B8YR7SftNyZiALqRguER6zMAHlvz6l4OVuUkolHcAVUfUusMslWv2gf1hzeCjJjJz2tpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tpL0x-0008Q4-46; Tue, 04 Mar 2025 06:40:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpL0v-003vB4-24;
	Tue, 04 Mar 2025 06:40:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpL0v-00CTZn-1c;
	Tue, 04 Mar 2025 06:40:21 +0100
Date: Tue, 4 Mar 2025 06:40:21 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v2 06/10] net: usb: lan78xx: Improve error
 handling in EEPROM and OTP operations
Message-ID: <Z8aSRbyOwRv8FS9Z@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
 <20241204084142.1152696-7-o.rempel@pengutronix.de>
 <ac965de8-f320-430f-80f6-b16f4e1ba06d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac965de8-f320-430f-80f6-b16f4e1ba06d@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Mar 03, 2025 at 06:02:23PM +0000, Mark Brown wrote:
> On Wed, Dec 04, 2024 at 09:41:38AM +0100, Oleksij Rempel wrote:
> > Refine error handling in EEPROM and OTP read/write functions by:
> > - Return error values immediately upon detection.
> > - Avoid overwriting correct error codes with `-EIO`.
> > - Preserve initial error codes as they were appropriate for specific
> >   failures.
> > - Use `-ETIMEDOUT` for timeout conditions instead of `-EIO`.
> 
> This patch (which is in Linus' tree) appears to break booting with a NFS
> root filesystem on Raspberry Pi 3B+.  There appears to be at least no
> incoming traffic seen on the device, I've not checked if there's
> anything outgoing:
> 
> [   19.234086] usb 1-1.1.1: new high-speed USB device number 6 using dwc2
> [   19.394134] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
> [   19.710839] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: renamed from eth0
> Device /sys/class/net/enxb827ebea22ac found
> done.
> Begin: Waiting up to 180 secs for any network device to become available ... done.
> IP-Config: enxb827ebea22ac hardware address b8:27:eb:ea:22:ac mt[   20.663606] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: Link is Down
> u 1500 DHCP
> [   22.708103] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: Link is Up - 1Gbps/Full - flow control off
> IP-Config: no response after 2 secs - giving up
> 
> The link did look like it was up on the switch.  Full log:
> 
>    https://lava.sirena.org.uk/scheduler/job/1158809#L965

Thank you! I'm investigating it.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

