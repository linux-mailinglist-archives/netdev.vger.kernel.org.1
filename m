Return-Path: <netdev+bounces-139573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1E9B3442
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981E11F22598
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B81DD54E;
	Mon, 28 Oct 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YhTB2+85"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED515E5B8;
	Mon, 28 Oct 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127770; cv=fail; b=mPl8ciraIVqf4+Alj+8TuQK2oegMnNa8XtkWVMzgzgT/4aMqnT0UdMsOYUB2YtK35W/ZjwtnVvHGHVrEF0Q+MJMIkSh6vWrFQ1DGSjWw4TW1MTNqa8kMC8no19VAZbipdjzrsudZKhoRmRX5Ksude9K6e0Q67YicAMm7gLSMlXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127770; c=relaxed/simple;
	bh=xWGcP24+JavjYYhWTP4w3CLbMBg0XsdbT2nLJ9a57BU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTfrI2Z1Dfj5yPOEPeKtn4pYx1Y6bJjLCeqKBNSC3yce/229HiCLD/JGbpP31rg9SZp/trZ1+j/5SgwGNWWIcpyaKWOQxCfn3yjRb8XuKB6qUuwTJRVsN5/llvj9nKrXJNRU4kKQL+3jrkNRWOMsMzVn73jyPkOVJc2TxpjKBd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YhTB2+85; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkJ3rjw5S/y8lujZMRh7lQRWp3ei5mWRH+IWJ9FzUTBwOwOar3fOJTVPkO9nYx0SEZ1+jU5O52gHivHg07xDSbL+OOtCkkFlrY0ZimoSRQ7IG2odVR8QiqD03wQ+4GkW/Lbzf83HERU21lTUce7wtb+DBmJ0yGaaiUPZqGcPTkYjd5osBg87/t1/XVLwkaZ1v0Gqa49WlBbnx1e06PBsGxvaDzmoifB+WkC+svRfibe87yVlXKdsi28DaZe4qNrPiuley6FHfA4ZMwgcxzjyBMsixY8B3AhRLspcyxM/iEwBqUKEcQUn0NiGEx4S7CJiBQQuwb1J4Eg7svIZ19eYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9FfRB/BQC40ZK1DpO6exywd6GUaL9P3JhOsVAig8No=;
 b=ZNC4VSVgazBngz2h2+oKm26ZrfrBWjyES9otgLw4tM+wJrFv2q1WjlKWesytcxae42WeCqwU793RxBEqbB2shUQDwe21PNYbeYH6SyFavm4tR3kt5u/UnX640ko4d3K555JzKkS9OnqxwSiXaMNVoCfVUwHhqBpzqLIBgk9OUPHHuJ+JG16G7frIDqZuX650yz0jOvinpeZimsPMCXZvidRAedsd6XT7PR6+cfIwsDDFo5aWvUBorw+l3FhqEJAhzut2/kTz+qq5QZH1NIyYdLo71E2Jp2wn7CIy0le+BcGkS7JlnFPJdwUCSz/bG+QqdarU33jeZ19O8t8+6h5ldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9FfRB/BQC40ZK1DpO6exywd6GUaL9P3JhOsVAig8No=;
 b=YhTB2+85YdjGuoy05WzJYjbLgU1k+dchHotTg3Q/7YCrY+UOKtM41wsNHRSklklQIAsH6B4yzvZVvHKrEafqKbQ3ttpYl/bxLHErkIo1jv9k6pUOdadL7sQuBfjBRIJBQP6I0xitmOgnwcJad8gNVyjRnzW6orNS1uakTdDncP4/msYPhW93MLb87eRiiBqaUvqOaHrHV8GAKfkwAZJ/9J96DKjwUm96FkngqrQluyXOnv26TeHVDb+PT+XIoTMd5o5lE/SY28/RV+tg0Au7fCgeREvri3BDUWUjBmNsD0h3GODBLn94yJxBRf5b1O1rQwrF87kDe6ujwABZdzMNrQ==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Mon, 28 Oct 2024 15:02:44 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:02:44 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Fabi.Benschuh@fau.de>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: RE: [PATCH] Add LAN78XX OTP_ACCESS flag support
Thread-Topic: [PATCH] Add LAN78XX OTP_ACCESS flag support
Thread-Index: AQHbJzJ+R5s7yeWnsEOPGdRw8jsjK7KcHiGAgAAlo8A=
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Mon, 28 Oct 2024 15:02:44 +0000
Message-ID:
 <PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
 <c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
In-Reply-To: <c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DM4PR11MB6552:EE_
x-ms-office365-filtering-correlation-id: c5734949-e940-46a2-2cf4-08dcf76193de
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6DWQFnOGCK7MJIlTPOz3V+ZDNkSYO+8tN5XzBVzcbeN/we5jFyAfnvAXZTs9?=
 =?us-ascii?Q?MnMF4ZSNXqvBcdMfNhPplyO+sX1EWjbQH3FgIIj3osOflevTFieYDfLa+5XK?=
 =?us-ascii?Q?sGsep1mw3i05r8JE4ft/lwKNHvjNEkqruoLgbi0GEsJCqipr/hhodckptqSN?=
 =?us-ascii?Q?Yjf27f6sebldwkBslbWtVeJcx7jd6V5QIht+3W5yHDbMboPSNiJdBrEvO8MM?=
 =?us-ascii?Q?vN5dnXRjSXszx7JPtwgcAyaIiIZFeaZmKAzLaDsVDNRtSJn8QcrdFB5lS+2f?=
 =?us-ascii?Q?2rTnL3SG+2t2ZXkNoMWT9VtINDAOtSpF4W4+rz+v9WpWsfmLnu3TvPFSjUfF?=
 =?us-ascii?Q?CaBf+krJf1VY2IEKlNGwpbzZCT0J7WxuKRYkjKB6znI9VAwFBr42AGAk/Qo2?=
 =?us-ascii?Q?RXyrDsKAptJEDhdiOLWHiIaKOcBtrSnVz0LMFt3k+HyFrrql9ooTOShPuj4f?=
 =?us-ascii?Q?C7c0j4BxRIpAvCIoY+gylWI2BsqpJp1XQKAmyxv1H6PPDwWk9bLCtWVU0Olv?=
 =?us-ascii?Q?t3ZRh8xNewxkhDJe7gSyApRyTGMXvHXi6k4bqdwleCyKf1+9t1bfmRlKgIdn?=
 =?us-ascii?Q?FM89LwdBLj3GXSz405fVFbbeqTH/7c2qNtOjmdXvjBPS0Cni1CqI+cCs1Pyx?=
 =?us-ascii?Q?r9eJ9v59YVU+U1jw1+/g5/awBAIKwZyYLeC/4TAUo+u8QBLey2KWkS/ODhNX?=
 =?us-ascii?Q?Zt9yF1VWvMX7oHwktfa1lFbwU0ZCvuyrNFYyc1Z+tfynztamVNgUo2gMBHoq?=
 =?us-ascii?Q?QvBmksRUD3IMQiJ4kKNhhZR9jdvuNePG00R789P2x/Yhw29zFfhMr5t4hhg8?=
 =?us-ascii?Q?l+M9LR8fhjkncMKlJs7YzVWDy/ejxaQtdS6myIcXMq2/s+l+KqcSjTR5kSGI?=
 =?us-ascii?Q?B7jbaP4AIax4ghLsU8lffs9LixMHj5PNRooUbgLKq9Z1ocK/5Am5Io6/HXzs?=
 =?us-ascii?Q?7rwmoQW3wg3GsPZa1a0YoWJrHWJiWHYFYPFfS9IAbTXXsxtyGKtwJYrUi/9u?=
 =?us-ascii?Q?OB+qqg9mJ5Uv7BfUUqx27d20x2OfpoJq8GMnR4Z8Uv7erd6270bnT0qchPVa?=
 =?us-ascii?Q?DKkEE7wJVtRH6HE7GoNagmFu+a1lPx/KTJHH72s4HClVjCnzpOk/LrhDHIoH?=
 =?us-ascii?Q?3CuBviFZzWstxWghUFsXhjFvgGVLp2Rr+SNA4wBc3lR1mZ+qgSyRG2HN7M1B?=
 =?us-ascii?Q?AgUn/efH89UBKJUP3L6BZ4IsNcidOhvhKVwEYdsOB3SXr5DKxEzk46MC4IUK?=
 =?us-ascii?Q?1aD5F76e4tq0JLS7uFQljmklWp1GNylJKEnPve4ZBYvsCWJVra3qaXoFmgC9?=
 =?us-ascii?Q?P77kRZJoJYMDW8/V18Cqikf2akYa4ZP+H446E+Akl0TEYLFTpY1jSv9nBkiQ?=
 =?us-ascii?Q?UcgXjfE7a0LDYyucpOZR0wxtEqif?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CrP6xclDGKix2MrmRNKLtX7kIg7L6qm4EzFvt1avNO84mGNkUacedt839h8G?=
 =?us-ascii?Q?04cpGraqUrrIRjvh6Ilj7dpSMYMhD4X6FIndw3JBKdNN/klwr4Ic7AdSv13U?=
 =?us-ascii?Q?mGvh40qg3q0NFiv5rgbUqi4ZqGTy+go43ck7dXvifowqz1LFz6xpNwwZJLHT?=
 =?us-ascii?Q?WCnfbr3OE+jOdvpsYB/XlZZBXMNVgxB0jvurRy2Z9Skc0peOFNU+kdC3O24a?=
 =?us-ascii?Q?LHo1DiwfFAYfkmL89fO+0Ti0oy+vj6xA/6dDaFRt+vcoVWFFrWP/ftmcsb1F?=
 =?us-ascii?Q?zDe0Hae2ekCTJf/vRuf+pRM+dHHw5niVa05y5VtdCZj6DpdNtb4XHAylv17u?=
 =?us-ascii?Q?4YR/gvsziQrzzRSTsxhuiFxZyocw9SeVdE2tJkgjlVXN2VZN0nJufVVA5s+g?=
 =?us-ascii?Q?bn+fD70VNhpQI6Ctmn0BCiZXeSghPzWz1zbkBVsq5szUWNkwyHb+HracuVAm?=
 =?us-ascii?Q?PY5arXAoknEXQujG329IFjvCxXrQux/x7aPAgpmk0o2hvlcWriPz+2d5u5fU?=
 =?us-ascii?Q?Vk1B1xvXDvQs1/e5n0PZh8RRXNtsm91xMbPaVrvhiYduZgm1gMs2GTZ8d7mL?=
 =?us-ascii?Q?GLTVDplTKzQcNGKMRkZYPMF/9YMIC6v7Np3MBRpVnebsguXSRYDF4ckVHtgo?=
 =?us-ascii?Q?XUtl9htAWTsZ/WfJ0nL7EZF9yexidw6QRG9c/Nrgwuqrmfa849P/ctFattbX?=
 =?us-ascii?Q?tRjbtpMHHw2lh3R7BD6Yo9K6epB9l+RXnB6EApASDnQyMozjSmWTPvo/Ns++?=
 =?us-ascii?Q?ycbSjKGG+eRUp4z03JBjZvtnr1Sr5T2SKVWBD/ydQMRUuL1Qr0a3EvoLGLcK?=
 =?us-ascii?Q?aLqIZ5LYzYJ65BAVVtBJRmARGQ94qEdhro5s3xZfbB1cl6uhvShBNcvqGlh/?=
 =?us-ascii?Q?zZugXMTZC3qUgjOZi4SQRAYcwBXf4krH3c9WDYz1fxu1UHKQaQiq5zpVfhY5?=
 =?us-ascii?Q?KdpgIazMkVamgR4jlhwxBqqP39qo76LZcsi/xE17emt6+pQ+g+UAoKuzBlYK?=
 =?us-ascii?Q?/KlO1USqAfrkJJ/wdSvJg/fp/e6W1T6H5B6U5VkS0W74UVkQy2kO0k8J///s?=
 =?us-ascii?Q?WwHyUvQvz1b5kiCa3LzNeYFIsdcHwZ7SOObb1Gn1u1jaVId55q/mF9Lg656t?=
 =?us-ascii?Q?dulHAY1ocJOPid/u5VWQKzdJMboOOoBgjAZ754aFX7IreenVdNm3rvArgz/h?=
 =?us-ascii?Q?DK+UlehrrSCWwzn2GMIHK++0baneDZXfH/wq2BQpwOJzBIDnT/HNgn9NQKFd?=
 =?us-ascii?Q?jh4L+Ao9JC450w92gdpBA5UqPmJlck0aFKnBLlNCi/nNoETFWs4ULgvm8Ym3?=
 =?us-ascii?Q?vWk7lihW5p1lRZ2cQBypYwTOZ5UDRirw5zha3rVA7pIDaDfgEcObQINr77Pd?=
 =?us-ascii?Q?pYhMnq7Vd2hnrbeTL1rTcJcxYJwvq7AIOk8WaRJBYQOhqLKZB+wwSSTdPtof?=
 =?us-ascii?Q?xYWm/zPCcTWq9iK1vHt59XZS1CwArJwQNn1PtkQU/H/Ts+hXkpH44t4YjYiz?=
 =?us-ascii?Q?4VstSOJ6Vc3Re04H1SFf4MmDtWimfRUa/aVP6ntnfBkom+fCoQJ0NERm/81d?=
 =?us-ascii?Q?gUn0hRP7TD1oNhfXMCe02JBLnn/Zq5VFcFf45Z5o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5734949-e940-46a2-2cf4-08dcf76193de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:02:44.4266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s77GhSU1Olx/R4DsAhWKetvYR7SmPbL0WaUD2HODOriv/RsfPvDOut+ThNMKpNDNT1PkAB9tRxovItWhEc7bKHddLI4X1v8AgRPhxCkObdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552

> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, October 28, 2024 8:38 AM
>=20
> On Sat, Oct 26, 2024 at 01:05:46AM +0200, Fabian Benschuh wrote:
> > With this flag we can now use ethtool to access the OTP:
> > ethtool --set-priv-flags eth0 OTP_ACCESS on ethtool -e eth0  # this
> > will read OTP if OTP_ACCESS is on, else EEPROM
> >
> > When writing to OTP we need to set OTP_ACCESS on and write with the
> > correct magic 0x7873 for OTP
>=20
> Please can you tell us more about OTP vs EEPROM? Is the OTP internal whil=
e the EEPROM is external?
> What is contained in each? How does the device decide which to use when i=
t finds it has both?
>=20
>         Andrew

This is pretty much the same implementation that is already in place for th=
e Linux driver of the LAN743x PCIe device.

OTP (one time programmable) is a configuration memory internal to the devic=
e. EEPROM is external.
The internal OTP memory always exists but it may not be programmed. The EEP=
ROM is optional, and if present can also be programmed or not.
A signature byte at offset 0 indicates whether the OTP or EEPROM device is =
programmed.=20
If present, EEPROM has higher priority.
More info @ Chapter 10 here;
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocum=
ents/DataSheets/LAN7800-Data-Sheet-DS00001992H.pdf

> I'm just wondering if we even need a private flag, if the hardware will u=
se one or the other exclusively?
>
Yes, both can be present/used, so we need the flag so we can tell the desti=
nation of a write or source of a read.

Ronnie

