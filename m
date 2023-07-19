Return-Path: <netdev+bounces-18898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D3759076
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52452281583
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CBD300;
	Wed, 19 Jul 2023 08:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA53BE40
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 08:40:16 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7510E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:40:12 -0700 (PDT)
X-QQ-mid:Yeas48t1689755917t735t43708
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.243.13])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3527007509173599446
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
References: <043501d9b580$31798870$946c9950$@trustnetic.com> <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com> <ZLUymspsQlJL1k8n@shell.armlinux.org.uk> <013701d9b957$fc66f740$f534e5c0$@trustnetic.com> <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk> <013e01d9b95e$66c10350$344309f0$@trustnetic.com> <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk> <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com> <ZLeHyzsRqxAj4ZGO@shell.armlinux.org.uk> <01b401d9ba16$aacf75f0$006e61d0$@trustnetic.com> <ZLeeZMU4HeiHthQ2@shell.armlinux.org.uk>
In-Reply-To: <ZLeeZMU4HeiHthQ2@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Wed, 19 Jul 2023 16:38:36 +0800
Message-ID: <01b701d9ba1c$691d9fa0$3b58dee0$@trustnetic.com>
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
Thread-Index: AQFMOiuVG72ejxJpQ9dFJOgJWFa94gFjhYqqApkC1W8CGUSlBAG/1/rdAwkAc4UCHFYsuQJ0/BrNAYfQyTgDYvYnlAM9fevwsB8AUxA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, July 19, 2023 4:27 PM, Russell King (Oracle) wrote:
> On Wed, Jul 19, 2023 at 03:57:30PM +0800, Jiawen Wu wrote:
> > > According to this read though (which is in get_mactype), the write
> > > didn't take effect.
> > >
> > > If you place a delay of 1ms after phy_clear_bits_mmd() in
> > > mv3310_power_up(), does it then work?
> >
> > Yes, I just experimented, it works well.
> 
> Please send a patch adding it, with a comment along the lines of:
> 
> 	/* Sometimes, the power down bit doesn't clear immediately, and
> 	 * a read of this register causes the bit not to clear. Delay
> 	 * 1ms to allow the PHY to come out of power down mode before
> 	 * the next access.
> 	 */

After multiple experiments, I determined that the minimum delay it required
is 55us. Does the delay need to be reduced? But I'm not sure whether it is
related to the system. I use udelay(55) in the test.



