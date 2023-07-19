Return-Path: <netdev+bounces-18829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F23758C42
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36931C20F09
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E363D87;
	Wed, 19 Jul 2023 03:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0A17F9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:55:39 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F72A4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:55:34 -0700 (PDT)
X-QQ-mid:Yeas3t1689738813t070t56102
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.243.13])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1871001362217384513
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
References: <ZK/V57+pl36NhknG@corigine.com> <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk> <043401d9b57d$66441e60$32cc5b20$@trustnetic.com> <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk> <043501d9b580$31798870$946c9950$@trustnetic.com> <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com> <ZLUymspsQlJL1k8n@shell.armlinux.org.uk> <013701d9b957$fc66f740$f534e5c0$@trustnetic.com> <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk> <013e01d9b95e$66c10350$344309f0$@trustnetic.com> <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk> <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
In-Reply-To: <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
Subject: RE: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Date: Wed, 19 Jul 2023 11:53:31 +0800
Message-ID: <019101d9b9f4$95cae080$c160a180$@trustnetic.com>
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
Thread-Index: AQHxijPTuEE90Wk3AsfAJFZNC2gr6QHGL87AAtcZi7oCGUwJkAFMOiuVAWOFiqoCmQLVbwIZRKUEAb/X+t0DCQBzhQIcViy5AnT8Gs2u1TzugA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Okay, so how about this for an alternative theory.
> >
> > The PHY is being probed, which places the PHY in power down mode.
> > Then your network driver (which?) gets probed, connects immediately
> > to the PHY, which attempts to power up the PHY - but maybe the PHY
> > hasn't finished powering down yet, and thus delays the powering up.
> >
> > However, according to the functional spec, placing the device in
> > power-down mode as we do is immediate.
> >
> > Please can you try experimenting with a delay in mv3310_config_init()
> > before the call to mv3310_power_up() to see whether that has any
> > beneficial effect?
> 
> I experimented with delays of 100ms to 1s, all reset timed out. Unfortunately,
> the theory doesn't seem to be true. :(

And I tried to add 100ms delay after mv3310_power_up() and before chip->get_mactype(phydev),
it showed that power down bit cleared while reading the reg in mv3310_get_mactype().
Then the reset executed successfully.


