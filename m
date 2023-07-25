Return-Path: <netdev+bounces-20810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B69761125
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B98F281805
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B314270;
	Tue, 25 Jul 2023 10:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A089447
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:46:23 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F4410CC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:46:17 -0700 (PDT)
X-QQ-mid:Yeas49t1690281905t157t45884
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.134.159])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14067757563934950869
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk> <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com> <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk> <03f101d9bedd$763b06d0$62b11470$@trustnetic.com> <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk> <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
In-Reply-To: <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Tue, 25 Jul 2023 18:45:04 +0800
Message-ID: <03f501d9bee5$11fc0ea0$35f42be0$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QHlV8ySAerVjK8CRWbPqwHK0atUAh0aDJIDPJCjsQIjPZH8rmHvzIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, July 25, 2023 6:08 PM, Russell King (Oracle) wrote:
> On Tue, Jul 25, 2023 at 10:58:25AM +0100, Russell King (Oracle) wrote:
> > > The information obtained from the IC designer is that "PHY/MAC side SGMII"
> > > is configured by experimentation. For these different kinds of NICs:
> > > 1) fiber + SFP-RJ45 module: PHY side SGMII
> > > 2) copper (pcs + external PHY): MAC side SGMII
> >
> > This makes no sense. a PHY on a RJ45 SFP module is just the same as a
> > PHY integrated into a board with the MAC.
> 
> 
> MAC ---- PCS <----- sgmii -----> PHY (whether on a board or SFP)
> 
> Control word flow:
>              <------------------ link, speed, duplex
> 	     ------------------> acknowledge (value = 0x4001)
> 
> Sometimes, it's possible to connect two MACs/PCSs together:
> 
> MAC ---- PCS <----- sgmii -----> PCS ---- MAC
> 
> and in this case, one PCS would need to be configured in "MAC" mode
> and the other would need to be configured in "PHY" mode because SGMII
> is fundamentally asymmetric.
> 
> Here is the definition of the control word sent by either end:
> 
> Bit	MAC->PHY	PHY->MAC
> 15	0: Reserved	Link status, 1 = link up
> 14	1: Acknowledge	Reserved for AN acknowledge
> 13	0: Reserved	0: Reserved
> 12	0: Reserved	Duplex mode 1 = full, 0 = half
> 11:10	0: Reserved	Speed 11 = Reserved 10=1G, 01=100M, 00=10M
> 9:1	0: Reserved	0: Reserved
> 0	1		1
> 
> So my guess would be that "PHY side SGMII" means the device generates
> the "PHY->MAC" format word whereas "MAC side SGMII" generates the
> "MAC->PHY" format word - and it's the latter that you want to be using
> both for Copper SFPs, which are no different from PHYs integrated onto
> the board connected with SGMII.

Thanks for the detailed explanation, I can understand it.

So I need to find out why config it in MAC mode doesn't work. When I config
it in MAC mode, PHY would not change state to callback the xpcs_get_state().
I dump the PCS register through the tool at this time, VR_MII_AN_INTR_STS
is not always the same value, sometimes AN complete, sometimes not.

I'm not sure if this is related to the anomaly, log often shows:
"i2c_designware i2c_designware.1024: timeout in disabling adapter"



