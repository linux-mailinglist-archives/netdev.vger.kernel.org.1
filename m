Return-Path: <netdev+bounces-18809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FE758B5D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986641C20F29
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE118E;
	Wed, 19 Jul 2023 02:31:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B4125B3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:31:24 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB71BC3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:31:20 -0700 (PDT)
X-QQ-mid:Yeas54t1689733779t804t50769
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.243.13])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13635437705656717840
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: "'Simon Horman'" <simon.horman@corigine.com>,
	<kabel@kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <ZK/V57+pl36NhknG@corigine.com> <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk> <043401d9b57d$66441e60$32cc5b20$@trustnetic.com> <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk> <043501d9b580$31798870$946c9950$@trustnetic.com> <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com> <ZLUymspsQlJL1k8n@shell.armlinux.org.uk> <013701d9b957$fc66f740$f534e5c0$@trustnetic.com> <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk> <013e01d9b95e$66c10350$344309f0$@trustnetic.com> <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk>
In-Reply-To: <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Wed, 19 Jul 2023 10:29:38 +0800
Message-ID: <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxijPTuEE90Wk3AsfAJFZNC2gr6QHGL87AAtcZi7oCGUwJkAFMOiuVAWOFiqoCmQLVbwIZRKUEAb/X+t0DCQBzhQIcViy5rujFQDA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, July 18, 2023 7:47 PM, Russell King (Oracle) wrote:
> On Tue, Jul 18, 2023 at 05:58:28PM +0800, Jiawen Wu wrote:
> > On Tuesday, July 18, 2023 5:49 PM, Russell King (Oracle) wrote:
> > > On Tue, Jul 18, 2023 at 05:12:33PM +0800, Jiawen Wu wrote:
> > > > On Monday, July 17, 2023 8:23 PM, Russell King (Oracle) wrote:
> > > > > On Mon, Jul 17, 2023 at 06:51:38PM +0800, Jiawen Wu wrote:
> > > > > > > > > > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > > > > > > > > > and mv3310_set_edpd(). One of them is in the probe function, after we
> > > > > > > > > > have powered up the PHY.
> > > > > > > > > >
> > > > > > > > > > I think we need much more information from the reporter before we can
> > > > > > > > > > guess which commit is a problem, if any.
> > > > > > > > > >
> > > > > > > > > > When does the reset time out?
> > > > > > > > > > What is the code path that we see mv3310_reset() timing out?
> > > > > > > > > > Does the problem happen while resuming or probing?
> > > > > > > > > > How soon after clearing the power down bit is mv3310_reset() called?
> > > > > > > > >
> > > > > > > > > I need to test it more times for more information.
> > > > > > > > >
> > > > > > > > > As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> > > > > > > > > in mv3310_config_init().
> > > > > > > > >
> > > > > > > > > Now what I'm confused about is, sometimes there was weird values while probing, just
> > > > > > > > > to read out a weird firmware version, that caused the test to fail.
> > > > > > > > >
> > > > > > > > > And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> > > > > > > > > Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> > > > > > > > > the bit takes about 1ms.
> > > > > > > >
> > > > > > > > So, reading the bit before the first delay period results in the bit not
> > > > > > > > clearing, despite having written it to be zero?
> > > > > > >
> > > > > > > Yes. So in the original code, there is no delay to read the register again for
> > > > > > > setting software reset bit. I think the power down bit is not actually cleared
> > > > > > > in my test.
> > > > > >
> > > > > > Hi Russell,
> > > > > >
> > > > > > I confirmed last week that this change is valid to make mv3310_reset() success.
> > > > > > But now reset fails again, only on port 0. Reset timeout still appears in
> > > > > > mv3310_config_init() -> mv3310_set_edpd() -> mv3310_reset(). I deleted this
> > > > > > change to test again, and the result shows that this change is valid for port 1.
> > > > > >
> > > > > > So I'm a little confused. Since I don't have programming guidelines for this PHY,
> > > > > > but only a datasheet. Could you please help to check for any possible problems
> > > > > > with it?
> > > > >
> > > > > I think the question that's missing is... why do other 88x3310 users not
> > > > > see this problem - what is special about your port 0?
> > > > >
> > > > > Maybe there's a clue with the hardware schematics? Do you have access to
> > > > > those?
> > > >
> > > > This problem never happened again after I poweroff and restart the machine.
> > > > However, this patch is still required to successfully probe the PHY.
> > > >
> > > > One thing I've noticed is that there is restriction in mv3310_power_up(), software
> > > > reset not performed when priv->firmware_ver < 0x00030000. And my 88x3310's
> > > > firmware version happens to 0x20200. Will this restriction cause subsequent reset
> > > > timeout(without this patch)?
> > >
> > > We (Matteo and I) discovered the need for software reset by
> > > experimentation on his Macchiatobin and trying different firmware
> > > versions. Essentially, I had 0.2.1.0 which didn't need the software
> > > reset, Matteo had 0.3.3.0 which did seem to need it.
> > >
> > > I also upgraded my firmware to 0.3.3.0 and even 0.3.10.0 and confirmed
> > > that the software reset works on the two PHYs on my boards.
> > >
> > > What I don't understand is "this patch is still required to successfully
> > > probe the PHY". The power-up path is not called during probe - nor is
> > > the EDPD path. By "probe" I'm assuming we're talking about the driver
> > > probe, in other words, mv3310_probe(), not the config_init - it may be
> > > that you're terminology is not matching phylib's terminology. Please
> > > can you clarify.
> >
> > I'm sorry for the mistake in my description. I mean MAC driver probe, in fact
> > it is in phy_connect_direct(), to call mv3310_config_init().
> 
> Okay, so how about this for an alternative theory.
> 
> The PHY is being probed, which places the PHY in power down mode.
> Then your network driver (which?) gets probed, connects immediately
> to the PHY, which attempts to power up the PHY - but maybe the PHY
> hasn't finished powering down yet, and thus delays the powering up.
> 
> However, according to the functional spec, placing the device in
> power-down mode as we do is immediate.
> 
> Please can you try experimenting with a delay in mv3310_config_init()
> before the call to mv3310_power_up() to see whether that has any
> beneficial effect?

I experimented with delays of 100ms to 1s, all reset timed out. Unfortunately,
the theory doesn't seem to be true. :(

There is a log dump while I tried in 200ms.

[59697.591809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=6, val=c000
[59697.592811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=5, val=9a
[59697.593814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=2, val=2b
[59697.594817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=3, val=9ab
[59697.595811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=2, val=2b
[59697.596811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=3, val=9ab
[59697.597811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=4, regnum=2, val=141
[59697.598809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=4, regnum=3, val=dab
[59697.599809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=2, val=2b
[59697.600810] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=3, val=9ab
[59697.601815] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1e, regnum=8, val=0
[59697.602930] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=8, val=fffe
[59697.608811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=d00d, val=680b
[59697.609823] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c050, val=7e
[59697.610814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c011, val=2
[59697.611817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c012, val=200
[59697.611820] mv88x3310 txgbe-400:00: Firmware version 0.2.2.0
[59697.612817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
[59697.612820] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f08c, val=9600
[59697.613819] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f08a, val=cd9a
[59697.613822] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f08a, val=d9a
[59697.614818] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=1, val=9ab
[59697.615816] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=8, val=9701
[59697.616817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=b, val=1a4
[59697.617814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=14, val=e
[59697.618809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=15, val=3
[59697.619811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=3c, val=0
[59697.619831] mv88x3310 txgbe-400:00: attached PHY driver (mii_bus:phy_addr=txgbe-400:00, irq=POLL)
[59697.830169] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
[59697.830179] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f001, val=3
[59697.830926] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
[59697.831926] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=8000, val=60
[59697.831932] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=3, regnum=8000, val=360
[59697.832926] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.838922] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.844815] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.850812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.856813] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.862812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.868812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.874812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.880812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.886812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.892812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.898812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.904812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.910812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.916812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.922812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.928812] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.934813] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.935813] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=0, val=a040
[59697.935815] mv88x3310 txgbe-400:00: mv3310_reset failed: -110


