Return-Path: <netdev+bounces-97643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE7B8CC80C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE5A1C20AA7
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61F146A67;
	Wed, 22 May 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b="vpAw4/zQ"
X-Original-To: netdev@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2104.outbound.protection.outlook.com [40.107.135.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEA1422D3
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412452; cv=fail; b=eZ0eifB02BfE2eYEMFGB53a6i0VzUUCOQ/L9gbHaEfqyRgIzBS/6cKcWVcOlaC1ywvEcsRBImJxCGOXgU83yOR6Da/Ac1jMRSTYbXpWHOdrA1r2fvBrCx5x8FxwJwuJDekYzI7irqfOSaZ1WY0oPHSeDovCQ5zfJZy6cA9iZfzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412452; c=relaxed/simple;
	bh=8sqXkTiUzzyvuytnedy8xJ20TE7PCk/6iKjpOUgAvyY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r65EX6b+R/nHv651IYBAxF2V2bx++nxqm2p/MkJtwRqDGd46MKM5/sH7SBwNja5KkGfxZKdeNjoFs1ddP4Z7Mch9SI0oktgGi5BGP8EIZuab8wYSUzVxi/81cR5d8/AsGBiwIeeK4RmjFkJEkOdZCAPGcTeYXgH/Fxwpjqc5J+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de; spf=pass smtp.mailfrom=avantys.de; dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b=vpAw4/zQ; arc=fail smtp.client-ip=40.107.135.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avantys.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsGaGn83X3uHSaFMXc1lfEy82lcfej0YYvNUqEzxBV/nTJPFQ8+yyFQRXsp/the+FfEyWf+8BmUlZcO/kSUx/EFy1UFPOYRtXGdBu+5YkB9xsgfheDJ4Hkd7bDjtuazNuLKliVDdlHlDA5vPPcT7qCIlR7pTi/Sw4qaV97raFINAub/Mcqcwd71WFGIbOnUuXM/MvRkuyoEuptDxWqQIX0GsW3zOxIQbO124x0Q+VPIMakn/zCrQSVYhCcnLkb4e8viqU5lEePXvV2iUryjqDY6fgX6f5wnI880QjhkxXy6oI842n0w9xeSAhM1bF39Py8bjjGzB8CasL7eVV7rrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YcoDMMKwqzvwhUF1XwSQ56EzMKuJve3VBPtxw8+SS0=;
 b=W/gAQsqMXgy0+2wlQf9aKa/0zizFEkHe1M0ZMemSzrk2y/B7wiZyOocV4eX8bedDOojUFdq7HL7kwaK5te9/GciSiHnd68NjYsRBlewPBlL6tiHgsAIlo80YjAtDFB7WvCsHACYCXEtXiHhMarZAcIyB46ugPg/BEEBS9t9itT8fkx37BT2W04HGWF9jrxgKzCkSaOMVWgKlaYh7vaRbTVbwYkpeewIZ63GAJRlJSRTHBQWx+pTquwken91j9FFd+gr8HO2QYR6/GJQ2+lv1RguARn0Ud4KEgUewnFRK1Pavs6W6msS6/DYop90i34S8J/RkFIDO9383AEQXjIs2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avantys.de; dmarc=pass action=none header.from=avantys.de;
 dkim=pass header.d=avantys.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=avantys.onmicrosoft.com; s=selector2-avantys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YcoDMMKwqzvwhUF1XwSQ56EzMKuJve3VBPtxw8+SS0=;
 b=vpAw4/zQ1bzY4PeIvKFyoQd+cjze2AQHP8+Fuh6qdIJ3Wc3UEh1BL+cYALvVXpuJnMa3uMrGr7TScpY9S82xm1PzM5f+5neoXpO3Px45pvVa6A4HEwmiqyyoEbhY96GJ3lhErrH20d6nbF1qtsTLPdVe/czmIPkh9h6xe3q9vRc=
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:57::7) by
 BEZP281MB1944.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.18; Wed, 22 May 2024 21:14:06 +0000
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a]) by BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 21:14:06 +0000
From: Daniel Glinka <daniel.glinka@avantys.de>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working with
 mv88e6320 on Linux 5.4
Thread-Topic: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Thread-Index: AQHarIzbCS7l1FmJmEuVD1CPnXQSHQ==
Date: Wed, 22 May 2024 21:14:06 +0000
Message-ID:
 <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=avantys.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2776:EE_|BEZP281MB1944:EE_
x-ms-office365-filtering-correlation-id: 76b1ff22-27bd-4372-f43c-08dc7aa41d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mWzFinbirlErrAOe07AIYGVyXjRzWsToysfWwCyKlCK3YcoOozHIs2W0TA?=
 =?iso-8859-1?Q?N4NjtRaOpb5AqZyjBTbMEjMS3FldDnZ9Mi0LPpP8pCZUNOeNIs8H6a3/Xa?=
 =?iso-8859-1?Q?Qvn400LGZgwz99FkMN82wwX3P9oEqK+i7ERFZPZ8Dqs8JA2fwf/3hngHVp?=
 =?iso-8859-1?Q?IHvkAb1MQIcJ/OQDTMXSUM4DH+OG5d0wZ9z1uOBX+i3fcFKwoXC7QtxiK6?=
 =?iso-8859-1?Q?BH4TYZ+9RlMfq3MSwM5IFxVvBcC+M36voQS6JU41HmWZUAgYnC72DLtyWv?=
 =?iso-8859-1?Q?zy/2Ad+OWhjtldZHvWn6LSmgR/Hu49hqjKvYcbDFVHW6rGWLjgoZgU4YZh?=
 =?iso-8859-1?Q?KpZ3DAxigoQNP1rQjj4ZvXg/6jDn1plrZkH0O+Q2QUjGVHLz/nKgO8pGwE?=
 =?iso-8859-1?Q?utBdnG4t15rOV7+Jd/wNFRvoaySGmJebzKfycdlQYvDA3tIP6TAzPEvnlU?=
 =?iso-8859-1?Q?WwSoOsC+5BuLpYmaLx9Wi8A3DLNqwK3V/BzyM793H/n7JhXlJqENVr2AfX?=
 =?iso-8859-1?Q?OU3PYJknmEV/PqP4hzVTKUxZws3aXQlQyYkXSLuClWYH69pfey28qAXNZ6?=
 =?iso-8859-1?Q?Tfc8AWnElHT1fdm2+s4SvWOpnqn+aW1nzlCeBcuKi9ffIDSVpOKlS9cGXq?=
 =?iso-8859-1?Q?TggV/j2ykmVcBJvqWAImE/QXgxUU9iOcvzaL9G6reua93GhycEIVipNxxt?=
 =?iso-8859-1?Q?i7j/NzqLXkOfugeV5chyoCeTMIi3/Uc5ZPs6yBlXSIvqkBm6+YZ1POIE4f?=
 =?iso-8859-1?Q?/gXO0y64ho8Po3ar5p3htkB+4vBwp9fo8Lu5xhzd6baIFeAzM3mbRDah6n?=
 =?iso-8859-1?Q?R6ySoTNHrqFbptn7i3m3uB/dPTZMJxJHSo1DhKSmrh18fbzZKLUMHh32r+?=
 =?iso-8859-1?Q?8Z9be3nc0UUELqwMGKuK59lP9nKQBP95EQ/Jg1EDIbeXtpanbFT9pQ1PLd?=
 =?iso-8859-1?Q?qbrevsGFSBdxWzXBwLKStSqXe5wMJ73o0YG/yx4MlXH8mPKOE/kp5yIYL+?=
 =?iso-8859-1?Q?c7wOxg994XzYXLs3/P3hQIe+/rhIXcC4y8sEz1ToWFxgeGQg5nprD3nvgP?=
 =?iso-8859-1?Q?gPQEVwrnAN9w8v9T6bhaRU9moydHxZ47qCIISN/1XH6OX4tkBjzyGEeEs2?=
 =?iso-8859-1?Q?BwElGFNKdAgWpYXkt14kwbQ9AqEYgQa2arCZm0SOnv715ngtMCn2QcXxlH?=
 =?iso-8859-1?Q?cu+NofdG6HqNH7DmXKJi4yDJTdSOTfzYpiKgl0zDtIYc/8oj5mRtuusIJ3?=
 =?iso-8859-1?Q?NjFYb5W3M43Z6UMN/POf1RVBTHdjSiiOl26w+qJjhzGdlQEMpSLAKLewQv?=
 =?iso-8859-1?Q?yUr4LbLOT3FFKwvwj2z++zCQOASW0zs0IT+Q5gTZZpvRsBB8moDBtS1Thm?=
 =?iso-8859-1?Q?edn7w6U5D4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4Z3DBU1ZOU+4dzfpPrhmjadtqILtPCawgWEceapldAWi2XaOqB4nBg4f/t?=
 =?iso-8859-1?Q?f6ITMYySIjXxRQC/+21wc8ONuxrPBFIAE8FmFOxBlQlw+NeLmVSihcARX2?=
 =?iso-8859-1?Q?hiWafZEmIApesgMslcjnAhsGk2fiJD0GJtyMSbJJ8AtIqaOEgsEIIUkZ36?=
 =?iso-8859-1?Q?8iFwEE7ypM1EIsBYaEtIuEgBGFb3fbN18i0AOsm8923yNJfGoBjM5R9WWY?=
 =?iso-8859-1?Q?B04wnukvK7vwlHlVKyt/CdQ7Kfe++U4wA8HN7eHpWh+t+vgV5EELwAnP+s?=
 =?iso-8859-1?Q?9e8Sb/xrJbgSvZ/LbKASoORWr3yKr4GNd4HTXFUQb4XL0LgYiMotdTKZHG?=
 =?iso-8859-1?Q?1rEC+RD/GUIbvQyqLeQDmrLSW89EldXF+Uymf5sMAQCKszPJF1pkTULbKx?=
 =?iso-8859-1?Q?yqBCV6oUaN0vpMkV4KBoOmX1pG04Ckygf6RBwTloFwclwLtJcBy/3bsL+G?=
 =?iso-8859-1?Q?cQLU+d8482XUj3hB4hhmZ0p6NNY58ZnwjjlKBK1AtgWJ61FBxd9OuEBwLF?=
 =?iso-8859-1?Q?Q2Np0kNm+lFoFvOnBl1r7ttvOUaec9A1RtgVKgBy43soM+OOc0MZAq9KBL?=
 =?iso-8859-1?Q?dU90K+SdOoa5eIhY4qVbWppMUqQ1V/s4DPiN0FXguWMdHMt9AsT/rTJmOo?=
 =?iso-8859-1?Q?Y0BBaomewyAl0gBYRp5x5+7uvYxf7uAcjJPRUlyy5c0c+SIWSQaPoqoEQB?=
 =?iso-8859-1?Q?sRbeoK12SlsPuzUqFop9+Cl+cGAGnPW0fA99KoJK9IKg60LS5D6h+F7D5o?=
 =?iso-8859-1?Q?HZcCgUTAPtR3JvW7a6rDTnk+QHz3HhAklha7wWoCEegG6fXrIe19+7s3nC?=
 =?iso-8859-1?Q?u1HBLewNf4OJhCR6QB44Qi9XBXwBlIqdWeJci2ZHqmH32hf97iUNStuVc+?=
 =?iso-8859-1?Q?E46vSjYsrBxsBsLXOSoo7uMUs9FmEE7OYBtaLEFlXPW4Kk5cM+h1Cb9BeM?=
 =?iso-8859-1?Q?iN2aWHdhnCts3bGIwgsI9JR1t6SJ3vH8LFzOq+EAxRJpSvbicZw0MUb6Cg?=
 =?iso-8859-1?Q?gPwHr1S2X6LWFZnSHCLkRKby0ariqsQaWWxA7hkR3/2C1dt1XhXrxgt+94?=
 =?iso-8859-1?Q?VNPRKMtRWB3g7VZJzusOONDtECSrf6ktJe0X3UdVXVr2Z3YeSt2KJ3aH8G?=
 =?iso-8859-1?Q?l4pvJoIC9zj2ridNuNYwghfu5PnB8wB0x/o/bsImEypV8ItXYmHZUVvmgi?=
 =?iso-8859-1?Q?GMCCxqeLmo2vZZlTl4HwssVBrmN8JiMRC42bPX+oibf92HIfd/fUd1reUU?=
 =?iso-8859-1?Q?0bkyx5gFYRYRbu6F0Xyt+DBrUR7ff/rhjKzyr9QTydYKSm/9c8X/RDJhrt?=
 =?iso-8859-1?Q?rrTMYBE3lm1Zg75jRFcEdvVQwc6LgyjmRPZSw4L4kbjvskU1sOa73asAEi?=
 =?iso-8859-1?Q?DWymo2Swn+BmRxcc+SsvsBz6q5aRbjk490S2ypaqXUCZgQd14HH/IFhQPT?=
 =?iso-8859-1?Q?GmKSE0hUHSs4uY5pnEZs1Ok0RM/xmBS/GmV+4EW3a7MaqYx4ffQwK2Ys4l?=
 =?iso-8859-1?Q?NXXo8wq3aVWIJNWWxlzjoljzWpVdN5YMJLNHPn+zQUoA5LkWHU23hohEkc?=
 =?iso-8859-1?Q?NdV8v6gwtxaaIZSDxwhQsntHXphYwejbzgSISLgrXRfaFCcw5OHhKf8oJ0?=
 =?iso-8859-1?Q?0OtVsQAzgI4uXOKgjdJfdt1Ah+jc3GtVeM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: avantys.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b1ff22-27bd-4372-f43c-08dc7aa41d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 21:14:06.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d7bbaf1-8dfe-40cf-ac5e-41227cb807ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Xe9oTBaUCrvvAfE7R8EQ3QuDx2mJuUJ+7eayGwnDpNc6PBHFHBrMNOHCQuXlA0qLJfl0o5Sifj9j0I/v8PPB1CQ0EUepWvfB8Y0B5iyWDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1944

Hi,=0A=
=0A=
I've been trying to get the SERDES ports of a Marvell 88E6320 on a custom b=
oard working without success. The SERDES ports are connected to SFPs. On th=
e board I have connected a network interface (eth2) to switch port 2 via RG=
MII. The DSA switch is configured to forward the packages to port 0 which i=
s connected to an SFP. The forwarding of the DSA switch seems to be fine. I=
've tested this with forwarding to port 3, which is connected to a RJ45. Th=
is works fine. I can also see that the tx_packet counter on port 0 is incre=
ased, when running e.g. ping. Therefore it seems that the DSA configuration=
 works correctly.=0A=
=0A=
The SFPs seem to be initialized correctly as well. The link is reported to =
be up and I get a link change when disconnecting the cable.=0A=
=0A=
[  247.782415] sfp sfp0: SM: exit present:up:link_up=0A=
=0A=
The SERDES connection is configured to 1000BASE-X. The link is reported as =
down but is directly wired to the SFP which reports the link is up. Therefo=
re I forced the link up in the port control register.=0A=
I know this behavior could be due to a hardware issue but I am fairly new t=
o this topic and I want to rule out all misconfigurations before getting ba=
ck to the hardware guys.=0A=
=0A=
Below are the switch port registers, statistics and the device tree nodes o=
f port2 and port0. The c_mode of the port is configured to 1000BASE-X witho=
ut PHY detect. In the mv88e6xxx driver I did not find anything SERDES relat=
ed for the mv88e6320 chip. Is this even supported? The SERDES related funct=
ions in the driver do not seem to apply to our setup because we have no PHY=
 and cannot set any register values (switching to the fiber/SERDES page in =
register 22 does not work).=0A=
=0A=
If it is a general misdesign of our setup, please let me know.=0A=
=0A=
We are using the 5.4 kernel and currently have no option to upgrade to a la=
ter version.=0A=
=0A=
This is the register dump:=0A=
88E6320  Switch Port Registers=0A=
------------------------------=0A=
00:                                        0x0e09=0A=
01:                                        0x003e=0A=
02:                                        0x0000=0A=
03:                                        0x1152=0A=
04:                                        0x043f=0A=
05:                                        0x0000=0A=
06:                                        0x0024=0A=
07:                                        0x0000=0A=
08:                                        0x2080=0A=
09:                                        0x0001=0A=
10:                                        0x0000=0A=
11:                                        0x0001=0A=
12:                                        0x0000=0A=
13:                                        0x0000=0A=
14:                                        0x0000=0A=
15:                                        0x9100=0A=
16:                                        0x0000=0A=
17:                                        0x0000=0A=
18:                                        0x0000=0A=
19:                                        0x0000=0A=
20:                                        0x0000=0A=
21:                                        0x0000=0A=
22:                                        0x0000=0A=
23:                                        0x0001=0A=
24:                                        0x3210=0A=
25:                                        0x7654=0A=
26:                                        0x0000=0A=
27:                                        0x8000=0A=
28:                                        0x0000=0A=
29:                                        0x0000=0A=
30:                                        0x0000=0A=
31:                                        0xf000=0A=
=0A=
And this is reported by ethtool:=0A=
NIC statistics:=0A=
     tx_packets: 77=0A=
     tx_bytes: 10288=0A=
     rx_packets: 0=0A=
     rx_bytes: 0=0A=
     in_good_octets: 0=0A=
     in_bad_octets: 0=0A=
     in_unicast: 0=0A=
     in_broadcasts: 0=0A=
     in_multicasts: 0=0A=
     in_pause: 0=0A=
     in_undersize: 0=0A=
     in_fragments: 0=0A=
     in_oversize: 0=0A=
     in_jabber: 0=0A=
     in_rx_error: 0=0A=
     in_fcs_error: 0=0A=
     out_octets: 6830=0A=
     out_unicast: 0=0A=
     out_broadcasts: 18=0A=
     out_multicasts: 27=0A=
     out_pause: 0=0A=
     excessive: 0=0A=
     collisions: 0=0A=
     deferred: 0=0A=
     single: 0=0A=
     multiple: 0=0A=
     out_fcs_error: 0=0A=
     late: 0=0A=
     hist_64bytes: 6=0A=
     hist_65_127bytes: 27=0A=
     hist_128_255bytes: 0=0A=
     hist_256_511bytes: 12=0A=
     hist_512_1023bytes: 0=0A=
     hist_1024_max_bytes: 0=0A=
     in_discards: 0=0A=
     in_filtered: 0=0A=
     in_accepted: 0=0A=
     in_bad_accepted: 0=0A=
     in_good_avb_class_a: 0=0A=
     in_good_avb_class_b: 0=0A=
     in_bad_avb_class_a: 0=0A=
     in_bad_avb_class_b: 0=0A=
     tcam_counter_0: 0=0A=
     tcam_counter_1: 0=0A=
     tcam_counter_2: 0=0A=
     tcam_counter_3: 0=0A=
     in_da_unknown: 0=0A=
     in_management: 0=0A=
     out_queue_0: 39=0A=
     out_queue_1: 6=0A=
     out_queue_2: 0=0A=
     out_queue_3: 0=0A=
     out_queue_4: 0=0A=
     out_queue_5: 0=0A=
     out_queue_6: 0=0A=
     out_queue_7: 0=0A=
     out_cut_through: 0=0A=
     out_octets_a: 0=0A=
     out_octets_b: 0=0A=
     out_management: 16=0A=
     atu_member_violation: 0=0A=
     atu_miss_violation: 0=0A=
     atu_full_violation: 0=0A=
     vtu_member_violation: 0=0A=
     vtu_miss_violation: 0=0A=
=0A=
Device Tree config:=0A=
port@0 {=0A=
    reg =3D <0>;=0A=
    label =3D "port0";=0A=
    phy-mode =3D "1000base-x";=0A=
    sfp =3D <&sfp0>;=0A=
};=0A=
port@2 {=0A=
     reg =3D <2>;=0A=
     label =3D "port2";=0A=
     phy-mode =3D "rgmii-id";=0A=
     fixed-link {=0A=
         speed =3D <1000>;=0A=
         full-duplex;=0A=
     };=0A=
};=0A=
=0A=
During testing I also configured the fixed-link full duplex for port0, with=
out success.=0A=
=0A=
I'm not sure what else I can do to debug this issue further or if I overloo=
ked something. I would appreciate any pointers to make sure the issue is no=
t software related.=0A=
=0A=
Best Regards,=0A=
Daniel Glinka=

