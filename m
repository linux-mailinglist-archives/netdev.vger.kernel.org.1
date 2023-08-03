Return-Path: <netdev+bounces-23857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B569B76DDF9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA39281F20
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB895243;
	Thu,  3 Aug 2023 02:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB937F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:21:50 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536AA1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:21:46 -0700 (PDT)
X-QQ-mid:Yeas51t1691029222t948t26360
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.251.0])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7078561624223745112
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk> <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com> <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk> <03f101d9bedd$763b06d0$62b11470$@trustnetic.com> <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk> <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk> <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com> <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk>
In-Reply-To: <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Thu, 3 Aug 2023 10:20:22 +0800
Message-ID: <068501d9c5b1$0e263ad0$2a72b070$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QHlV8ySAerVjK8CRWbPqwHK0atUAh0aDJIDPJCjsQIjPZH8Aekq2cAB9oGXjq5QjaBw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> No there isn't, and it conforms with the above.
>=20
> A read looks like this:
>=20
>       Address  Data                   Address  Data     Data
> Start 10101100 000yyyyy RepeatedStart 10101101 DDDDDDDD DDDDDDDD Stop
>                       or Stop followed
> 		          by Start
>=20
> The terms "Address" and "Data" here are as per the I=B2C =
specification.
> You will notice that the first part has one byte of address and *one*
> byte of data to convey the register address. This is what the "1" you
> are referring to above is for.
>=20
> For completness, a write looks like this:
>=20
>       Address  Data     Data     Data
> Start 10101100 000yyyyy DDDDDDDD DDDDDDDD Stop
>=20
> Essentially, in all cases, when 0x56 is addressed with the data
> direction in write mode, the very first byte is _always_ the register
> address and the remainder contain the data. When the data direction is
> in read mode, the bytes are always data.
>=20
> The description you quote above is poor because it doesn't make it
> clear whether "read" and "write" apply to the bus transactions or to
> the device operations. However, I can assure you that what is
> implemented is correct, since this is the standard small 24xx memory
> device protocol, and I've been programming that on various
> microcontrollers and such like for the last 30 years.
>=20
> Are you seeing a problem with the data read or written to the PHY?

Hi Russell,

I really don't know how to deal with "MAC side SGMII", could you please
help me?

From the test results, when I config PCS in "PHY side SGMII", the link =
status
of PHY in copper SFP is read by I2C after AN complete. Then PHY's link =
up
status is informed to PHYLINK, then PCS will check its status. But when =
I just
change PCS to "MAC side SGMII", I2C will keep reading timeouts since AN
complete. I checked the register of PCS to confirm AN complete, but =
PHY's
link status would never be updated in PHYLINK.

It's kind of weird to me, how does the configuration of PCS relate to =
I2C?

Thanks!


