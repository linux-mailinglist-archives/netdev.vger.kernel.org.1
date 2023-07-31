Return-Path: <netdev+bounces-22663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C837689BC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 03:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2281C209A7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 01:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A9626;
	Mon, 31 Jul 2023 01:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB7362
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:59:51 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856210C4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 18:59:45 -0700 (PDT)
X-QQ-mid:Yeas47t1690768711t187t28196
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.251.0])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7600978693373363402
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk> <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com> <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk> <03f101d9bedd$763b06d0$62b11470$@trustnetic.com> <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk> <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk> <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com> <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk>
In-Reply-To: <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Mon, 31 Jul 2023 09:58:30 +0800
Message-ID: <059201d9c352$810e4170$832ac450$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QHlV8ySAerVjK8CRWbPqwHK0atUAh0aDJIDPJCjsQIjPZH8Aekq2cAB9oGXjq5L1QeQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
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

You are right, I misunderstood it. :(


