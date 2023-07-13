Return-Path: <netdev+bounces-17565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B75752069
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEF81C21333
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4776125A0;
	Thu, 13 Jul 2023 11:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7011CAA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:51:56 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1B1993
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:51:53 -0700 (PDT)
X-QQ-mid:Yeas49t1689249018t278t31009
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.254.133])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2930020661834336758
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
References: <20230712062634.21288-1-jiawenwu@trustnetic.com> <ZK/RYFBjI5OypfTB@corigine.com> <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk> <ZK/V57+pl36NhknG@corigine.com> <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk> <043401d9b57d$66441e60$32cc5b20$@trustnetic.com> <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk>
In-Reply-To: <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Thu, 13 Jul 2023 19:50:17 +0800
Message-ID: <043501d9b580$31798870$946c9950$@trustnetic.com>
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
Thread-Index: AQDv4UssXc2PC2x1JpG280o39ls3NAJ8wJH4Abw1A/QB8Yoz0wHGL87AAtcZi7oCGUwJkLEkM3ig
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, July 13, 2023 7:41 PM, Russell King (Oracle) wrote:
> On Thu, Jul 13, 2023 at 07:30:17PM +0800, Jiawen Wu wrote:
> > On Thursday, July 13, 2023 6:54 PM, Russell King (Oracle) wrote:
> > > On Thu, Jul 13, 2023 at 11:45:59AM +0100, Simon Horman wrote:
> > > > On Thu, Jul 13, 2023 at 11:35:05AM +0100, Russell King (Oracle) wrote:
> > > > > On Thu, Jul 13, 2023 at 11:26:40AM +0100, Simon Horman wrote:
> > > > > > On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> > > > > > > Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> > > > > > > it sometimes does not take effect immediately. This will cause
> > > > > > > mv3310_reset() to time out, which will fail the config initialization.
> > > > > > > So add to poll PHY power up.
> > > > > > >
> > > > > > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > > > >
> > > > > > Hi Jiawen Wu,
> > > > > >
> > > > > > should this have the following?
> > > > > >
> > > > > > Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")
> > > > >
> > > > > What is that commit? It doesn't appear to be in Linus' tree, it doesn't
> > > > > appear to be in the net tree, nor the net-next tree.
> > > >
> > > > Hi Russell,
> > > >
> > > > Sorry, it is bogus. Some sort of cut and paste error on my side
> > > > that pulled in the local commit of an unrelated patch.
> > > >
> > > > What I should have said is:
> > > >
> > > > Fixes: 8f48c2ac85ed ("net: marvell10g: soft-reset the PHY when coming out of low power")
> > >
> > > Thanks, but I don't think that's appropriate either.
> > >
> > > The commit adds a software reset after clearing the power down bit, but
> > > that doesn't have anything to do with mv3310_reset().
> > >
> > > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > > and mv3310_set_edpd(). One of them is in the probe function, after we
> > > have powered up the PHY.
> > >
> > > I think we need much more information from the reporter before we can
> > > guess which commit is a problem, if any.
> > >
> > > When does the reset time out?
> > > What is the code path that we see mv3310_reset() timing out?
> > > Does the problem happen while resuming or probing?
> > > How soon after clearing the power down bit is mv3310_reset() called?
> >
> > I need to test it more times for more information.
> >
> > As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> > in mv3310_config_init().
> >
> > Now what I'm confused about is, sometimes there was weird values while probing, just
> > to read out a weird firmware version, that caused the test to fail.
> >
> > And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> > Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> > the bit takes about 1ms.
> 
> So, reading the bit before the first delay period results in the bit not
> clearing, despite having written it to be zero?

Yes. So in the original code, there is no delay to read the register again for
setting software reset bit. I think the power down bit is not actually cleared
in my test.


