Return-Path: <netdev+bounces-18536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B19A7578B9
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FC52812A6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F343F9FA;
	Tue, 18 Jul 2023 10:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B5A941
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:01:08 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36FAC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:00:59 -0700 (PDT)
X-QQ-mid:Yeas50t1689674309t583t29858
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.243.13])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10721024056483986855
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
References: <ZK/RYFBjI5OypfTB@corigine.com> <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk> <ZK/V57+pl36NhknG@corigine.com> <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk> <043401d9b57d$66441e60$32cc5b20$@trustnetic.com> <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk> <043501d9b580$31798870$946c9950$@trustnetic.com> <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com> <ZLUymspsQlJL1k8n@shell.armlinux.org.uk> <013701d9b957$fc66f740$f534e5c0$@trustnetic.com> <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk>
In-Reply-To: <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Tue, 18 Jul 2023 17:58:28 +0800
Message-ID: <013e01d9b95e$66c10350$344309f0$@trustnetic.com>
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
Thread-Index: AQJ8wJH4xT8YA9GxR1NNeOaW9y9H2QG8NQP0AfGKM9MBxi/OwALXGYu6AhlMCZABTDorlQFjhYqqApkC1W8CGUSlBAG/1/rdrd0IQOA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, July 18, 2023 5:49 PM, Russell King (Oracle) wrote:
> On Tue, Jul 18, 2023 at 05:12:33PM +0800, Jiawen Wu wrote:
> > On Monday, July 17, 2023 8:23 PM, Russell King (Oracle) wrote:
> > > On Mon, Jul 17, 2023 at 06:51:38PM +0800, Jiawen Wu wrote:
> > > > > > > > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > > > > > > > and mv3310_set_edpd(). One of them is in the probe function, after we
> > > > > > > > have powered up the PHY.
> > > > > > > >
> > > > > > > > I think we need much more information from the reporter before we can
> > > > > > > > guess which commit is a problem, if any.
> > > > > > > >
> > > > > > > > When does the reset time out?
> > > > > > > > What is the code path that we see mv3310_reset() timing out?
> > > > > > > > Does the problem happen while resuming or probing?
> > > > > > > > How soon after clearing the power down bit is mv3310_reset() called?
> > > > > > >
> > > > > > > I need to test it more times for more information.
> > > > > > >
> > > > > > > As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> > > > > > > in mv3310_config_init().
> > > > > > >
> > > > > > > Now what I'm confused about is, sometimes there was weird values while probing, just
> > > > > > > to read out a weird firmware version, that caused the test to fail.
> > > > > > >
> > > > > > > And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> > > > > > > Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> > > > > > > the bit takes about 1ms.
> > > > > >
> > > > > > So, reading the bit before the first delay period results in the bit not
> > > > > > clearing, despite having written it to be zero?
> > > > >
> > > > > Yes. So in the original code, there is no delay to read the register again for
> > > > > setting software reset bit. I think the power down bit is not actually cleared
> > > > > in my test.
> > > >
> > > > Hi Russell,
> > > >
> > > > I confirmed last week that this change is valid to make mv3310_reset() success.
> > > > But now reset fails again, only on port 0. Reset timeout still appears in
> > > > mv3310_config_init() -> mv3310_set_edpd() -> mv3310_reset(). I deleted this
> > > > change to test again, and the result shows that this change is valid for port 1.
> > > >
> > > > So I'm a little confused. Since I don't have programming guidelines for this PHY,
> > > > but only a datasheet. Could you please help to check for any possible problems
> > > > with it?
> > >
> > > I think the question that's missing is... why do other 88x3310 users not
> > > see this problem - what is special about your port 0?
> > >
> > > Maybe there's a clue with the hardware schematics? Do you have access to
> > > those?
> >
> > This problem never happened again after I poweroff and restart the machine.
> > However, this patch is still required to successfully probe the PHY.
> >
> > One thing I've noticed is that there is restriction in mv3310_power_up(), software
> > reset not performed when priv->firmware_ver < 0x00030000. And my 88x3310's
> > firmware version happens to 0x20200. Will this restriction cause subsequent reset
> > timeout(without this patch)?
> 
> We (Matteo and I) discovered the need for software reset by
> experimentation on his Macchiatobin and trying different firmware
> versions. Essentially, I had 0.2.1.0 which didn't need the software
> reset, Matteo had 0.3.3.0 which did seem to need it.
> 
> I also upgraded my firmware to 0.3.3.0 and even 0.3.10.0 and confirmed
> that the software reset works on the two PHYs on my boards.
> 
> What I don't understand is "this patch is still required to successfully
> probe the PHY". The power-up path is not called during probe - nor is
> the EDPD path. By "probe" I'm assuming we're talking about the driver
> probe, in other words, mv3310_probe(), not the config_init - it may be
> that you're terminology is not matching phylib's terminology. Please
> can you clarify.

I'm sorry for the mistake in my description. I mean MAC driver probe, in fact
it is in phy_connect_direct(), to call mv3310_config_init().


