Return-Path: <netdev+bounces-22233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136DF7669F0
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC742281DE2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D611C88;
	Fri, 28 Jul 2023 10:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001A1118B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:13:11 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A752D64
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:13:08 -0700 (PDT)
X-QQ-mid:Yeas50t1690539112t877t45594
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.251.0])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17717964583804871686
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk> <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com> <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk> <03f101d9bedd$763b06d0$62b11470$@trustnetic.com> <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk> <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
In-Reply-To: <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Fri, 28 Jul 2023 18:11:51 +0800
Message-ID: <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QHlV8ySAerVjK8CRWbPqwHK0atUAh0aDJIDPJCjsQIjPZH8rmaiBnA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
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

There is a question about I2C MII read ops. I see that PHY in SFP-RJ45 module
is read by i2c_mii_read_default_c22(), but it limits the msgs[0].len=1.

A description in  the SFP-RJ45 datasheet shows:
The registers are accessible through the 2-wire serial CMOS EEPROM protocol
of the ATMEL AT24C01A or equivalent. The address of the PHY is 1010110x,
where x is the R/W bit. Each register's address is 000yyyyy, where yyyyy is the
binary equivalent of the register number. Write and read operations must send
or receive 16 bits of data, so the "multi-page" access protocol must be used.

So the PHY register address should be written twice: first high 8 bits, second low
8 bits. to read the register value.

Is there a problem with which driver?


