Return-Path: <netdev+bounces-18253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5377560F1
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262822813BB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB4946C;
	Mon, 17 Jul 2023 10:53:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511698498
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:53:43 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C368E52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:53:40 -0700 (PDT)
X-QQ-mid:Yeas51t1689591099t401t06304
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.243.13])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15622078884436950337
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
References: <20230712062634.21288-1-jiawenwu@trustnetic.com> <ZK/RYFBjI5OypfTB@corigine.com> <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk> <ZK/V57+pl36NhknG@corigine.com> <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk> <043401d9b57d$66441e60$32cc5b20$@trustnetic.com> <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk> <043501d9b580$31798870$946c9950$@trustnetic.com>
In-Reply-To: <043501d9b580$31798870$946c9950$@trustnetic.com>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Mon, 17 Jul 2023 18:51:38 +0800
Message-ID: <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com>
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
Thread-Index: AQDv4UssXc2PC2x1JpG280o39ls3NAJ8wJH4Abw1A/QB8Yoz0wHGL87AAtcZi7oCGUwJkAFMOiuVsSAC4gA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > > > and mv3310_set_edpd(). One of them is in the probe function, after we
> > > > have powered up the PHY.
> > > >
> > > > I think we need much more information from the reporter before we can
> > > > guess which commit is a problem, if any.
> > > >
> > > > When does the reset time out?
> > > > What is the code path that we see mv3310_reset() timing out?
> > > > Does the problem happen while resuming or probing?
> > > > How soon after clearing the power down bit is mv3310_reset() called?
> > >
> > > I need to test it more times for more information.
> > >
> > > As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> > > in mv3310_config_init().
> > >
> > > Now what I'm confused about is, sometimes there was weird values while probing, just
> > > to read out a weird firmware version, that caused the test to fail.
> > >
> > > And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> > > Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> > > the bit takes about 1ms.
> >
> > So, reading the bit before the first delay period results in the bit not
> > clearing, despite having written it to be zero?
> 
> Yes. So in the original code, there is no delay to read the register again for
> setting software reset bit. I think the power down bit is not actually cleared
> in my test.

Hi Russell,

I confirmed last week that this change is valid to make mv3310_reset() success.
But now reset fails again, only on port 0. Reset timeout still appears in
mv3310_config_init() -> mv3310_set_edpd() -> mv3310_reset(). I deleted this
change to test again, and the result shows that this change is valid for port 1.

So I'm a little confused. Since I don't have programming guidelines for this PHY,
but only a datasheet. Could you please help to check for any possible problems
with it?

Thanks.


