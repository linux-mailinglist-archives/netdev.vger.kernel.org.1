Return-Path: <netdev+bounces-97903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B248CDCEA
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 00:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4D7285AC7
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304B82897;
	Thu, 23 May 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b="K7Yrqfa0"
X-Original-To: netdev@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2094.outbound.protection.outlook.com [40.107.135.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70A84E05
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503922; cv=fail; b=tLukSpg3XI55N3Bza5ymMuHiiHILoFO0Ej17j9PJdTDsn0ue2MWOLweFwWAYtiDeWwkEA+0opSBQGcUThQvh2KTuJG4aPNsvQtMH74byJ8OIPqdkKWfcX1aQ6A31g1mABiZm4Dw4fHV1ghEwDH74syBmDSAjAw/VBCQZsiaqi/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503922; c=relaxed/simple;
	bh=h4ccVk+Akzls7+ScjCto1WJoVFX83ZneLJ6yGXQIe+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dAkiuYUltIazshwPTdCM2vw1o2hz21wA39R9aoMjPd7EdRptQN5qq4CUc8oXQ96gYiZeytkyxLX/de0MyB+dRioNlVkms0wO8X9Ns6i6qo6ECosXHgLG90OTrMeeIV6hiAnaTvWTc42ruEQFj/3IYROW9p4T0vKO2uky9PJYKbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de; spf=pass smtp.mailfrom=avantys.de; dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b=K7Yrqfa0; arc=fail smtp.client-ip=40.107.135.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avantys.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pnkv6hatmuczaw/dCe3wFV80CJXJNKJfzhLaamH4X5mFi1cIzk9sOillPMZ17iGBzwKHiYqgwzwuEfE1D92AWGLzfAsxLuu6oH1w77JlSbqEVjdHTdm6h6kPo1bwq/XgA0f+LfBOUw0Mcc58kp+iHI6pAG8EWxAnidaMlYNM0CbG2o9C6CxqKxFIhNrYhL+Hf3aGOjqKrNlhJRAWhy8FpKi/T+Biks/p6/WQjJGewV8jaPU1TT1rvMD/urfklrT0ZTk2RW4hNYMFKm9HskmE51gGDa9EmEy27meIH1aXCBVKM77WrNTEXtTCM1b3CyLTGOj3n96vUp6O3CdTW68VUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9lkqxkHXQs2LEgylzNclai5nhqoCvfXVgvOUzWKHEU=;
 b=CjwARYlrr+A+xL8m+CIsAj980vl9k6kD0w5jR8wmI0Da4jfrqv3YpeTlVOjJvUS+RNx/oST7OHzf6zhipj1Rh9z97LAnjqucKqLhcPRZsoLWl+Uts2PNHm51IEu0Iad/wRzOe0fLtg4YXM4PP1iABDTV+XESVaKfvkI5YXJW/g3v2A3MfwXKAFWfFjsxuKrJWXduIMHfPygK42YKUXjQGsBIaQF7iTBcnZAnlHiyQct6n6kUfteAOrSf/vpdpmK1JwGAXB8/iOtD/p4o1XULJIZToV9CXjzK5WmliZse65XYrC9KrZhbMpP3IU0PnZgB9lrr4adNpnOAO9q22mrVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avantys.de; dmarc=pass action=none header.from=avantys.de;
 dkim=pass header.d=avantys.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=avantys.onmicrosoft.com; s=selector2-avantys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9lkqxkHXQs2LEgylzNclai5nhqoCvfXVgvOUzWKHEU=;
 b=K7Yrqfa01CGB4/jw3RHZi01VDfXpUZo64gFOOT8q8UZeFUVZWvXKu9Xu15YBlaCKX+8JwuaxXgNvX+FOzauHwiLliCyxhig8v6CCo7WMyBNGDyOWojKROLYNR+UunyfAqB/+oDDcakcWAVubj1GhDXemJ/Z+2jq6VK1D72UdGzE=
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:57::7) by
 FR4P281MB4120.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:fb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.17; Thu, 23 May 2024 22:38:36 +0000
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a]) by BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a%5]) with mapi id 15.20.7633.001; Thu, 23 May 2024
 22:38:36 +0000
From: Daniel Glinka <daniel.glinka@avantys.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working with
 mv88e6320 on Linux 5.4
Thread-Topic: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Thread-Index: AQHarIzbCS7l1FmJmEuVD1CPnXQSHbGjzOgAgAAn/fGAABmkAIAAqa5m
Date: Thu, 23 May 2024 22:38:36 +0000
Message-ID:
 <BEZP281MB27767E9FDEBECA454A503C4090F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
 <BEZP281MB277651F9154F2814398038C790F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <6d0f1043-cf3a-4364-84e0-8dec32f8b838@lunn.ch>
In-Reply-To: <6d0f1043-cf3a-4364-84e0-8dec32f8b838@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=avantys.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2776:EE_|FR4P281MB4120:EE_
x-ms-office365-filtering-correlation-id: 38c1df2b-9946-498e-8edb-08dc7b79156c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IhWB2hgUzqNPVeRmmwPBsvm5AP0FkQVppxxzUEC9nI324eDaijLLZGeCQ7?=
 =?iso-8859-1?Q?OO2Rixrj3bDW609YAuGoh0iECukdXjB3QNIQV5ZC84zf7Ocg9GWPXxHJP4?=
 =?iso-8859-1?Q?RC492zQNXAuEhY8ykfpY5U9zWvySMP6oSTgEsNzl6bDoYZdUnCg6E7d8tA?=
 =?iso-8859-1?Q?0T9LlZ5ED4oph36LCWZ2IipziiMgLfI+V10iQ45tAxYK8qPfaRNo0IySuK?=
 =?iso-8859-1?Q?16yr7j9itqve88FhZR2b+OmHgD/slMfKyaVE9kWieck9ti1Cln0mdI5AS9?=
 =?iso-8859-1?Q?yCTq5oSX2gd+R0lGHtsLyTQHmfHwLd8mSaVU4sNhmVwtrjNqIvYzi9GUtY?=
 =?iso-8859-1?Q?2T/Tv4WZCKYjIrsQtylujZbEfe6DBTeoO+ZKnjdT+6ymC3jbNVniX34sgc?=
 =?iso-8859-1?Q?/1ob0ZtV781mTg/BkAC+iu+gL/v92RLHizhILlAy+VYZqC6QkaXP4MHqwR?=
 =?iso-8859-1?Q?a/SQcFe085oFftse46ouYGTHdMCPr4MiPYSP9OhkhXHj4NMxUpHyK2QXkb?=
 =?iso-8859-1?Q?a1m6/JBPLS7exwU49JR/GUyHOxYwWtwCV9pXfUDrXIWOOAbQjxRqBOti3L?=
 =?iso-8859-1?Q?4gCxmlHyPXaHK5H/wXzEU4KbJmEPaut3uyox1Cpv634ePJUMGX2ed5er9P?=
 =?iso-8859-1?Q?wN3LAXa2xDd3zCNwmdeRmk4WfW8ajsqtm2qUEdLMXZmAQbwq68FStPEA9v?=
 =?iso-8859-1?Q?mUo2N13hSg0aff93yzKPVyLvmfXpL06L5D0ZfhicyJZmTYluujhWiSk1v0?=
 =?iso-8859-1?Q?9YQweO/P5pQ8ehSrSIsFo81suc4HmPV0EIJefoB3nxlc6s1b1Lqy2Uy6o3?=
 =?iso-8859-1?Q?dFNpx2wmrZX0I3AVpbB2u4cF9bGBq6kdtZxQJKPKXW6Am2sm+Dn/AiL9Ga?=
 =?iso-8859-1?Q?eI3jPZJevulxKEGROXjIt31DYMZXXqM1EYmqnwyYLm41YEe/uauvm2p7Zm?=
 =?iso-8859-1?Q?7BaW/b5jwu6Ex3ACRyxnpgsfpaBQB/SnRmom03ewHpfIAqEa7kmlV81n9d?=
 =?iso-8859-1?Q?BZBt+hyO/sAF0q0g5FbxHDpL8WycWCzG1QBc3kZDOuDKYP5hjz3dSWQlO8?=
 =?iso-8859-1?Q?gxcj9+1S7NGsh2cPqL3vt2AZB4g1Fiu7EIRZXcs/REst7cbMhjkS7W9k0N?=
 =?iso-8859-1?Q?wVsw2bZPwyF8RFLu1QJ321S3rtjxbBu2BMQK/NKc6sisrwo1g415/dpJzZ?=
 =?iso-8859-1?Q?xOk/KYW4fX0H9lkdw1LvVWvNxLldEAM0uhSzj9SmAkBsF0ihZCCkCBIvpB?=
 =?iso-8859-1?Q?+jwu0jV92u5xhq3uCByNGBS4zMqC7jOqxqmuuFPQPcjUaJ9UzqunMA+5Qf?=
 =?iso-8859-1?Q?iQIW7FjSWdoIIZA4HlxGEWo0Og=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0dVPZe0EUrsR/P8hsehp2G8SIyoHuL7yDtjQdsgHyhp4Vj7CbA6Ruv/P6O?=
 =?iso-8859-1?Q?nYCI1B+6UTTmzagZPNS5DPQ9Lt/b1khLS3MLh+aQkLdgqhRCP1wbN3VsrC?=
 =?iso-8859-1?Q?LkwG0t8Q7H3b6msDHIndGVuSM0Qq5c4UsVM2RDPDfNRVUaSy/T1GMLjyqa?=
 =?iso-8859-1?Q?fHfulxHxiW1HtxtLWMriX9TXFS9KjeFR6JkbL9mSCf2zcGVXLDiey7c0No?=
 =?iso-8859-1?Q?HBepwCAc7qIiEyrU46u6mm0zrzfKqiFv/R5WnCTmZ7WgRPJlhgdtYR6qzm?=
 =?iso-8859-1?Q?LRxFvtBIRPFdcQj/6tp777W1ds97LhbDI00GOilapXnkxOD/1WlTuNaUfi?=
 =?iso-8859-1?Q?Y3anyYZGcuMUFl8URO8kjzNtRpbF/SNOm4vXcejBrHP6lcu+RNdGeJ2eg4?=
 =?iso-8859-1?Q?SP2a6dCH2D1YFif1FQTlqtrMrtqNLPPRN6+CPQAdM6i0vvqP0mEg9CwzbS?=
 =?iso-8859-1?Q?fZYRWQtRJAg1nYFFmzBedSio4B7ouWheLBmhTtOW/0Z/UABL8+qvmJcpAf?=
 =?iso-8859-1?Q?zgSOeBmlTVYilsIaDJ/4RJoQQPGd4TTKclMGAkCaemR9eUGpqvjdcERFcf?=
 =?iso-8859-1?Q?KRuwBfitzXQTHyHqBl8+AAFzUBmmcZmDm5ZFTT/cIqbXUD4GwCHL+aNwJP?=
 =?iso-8859-1?Q?n9EP17chbu2WESY6HI2rLIKdf72Pgu8EQf//vkca4FgbB48w1oEIDdnxiw?=
 =?iso-8859-1?Q?uhGBC+EA98PhJVqrp8k9zf3f/ZMrK9fo1oI42/5+G6QgVxHif0eqxZE3PJ?=
 =?iso-8859-1?Q?K1fpbB+lkgAIUmb20zeOEH8uUgbnyIDIYa+LVNnb9VUIf1eD6cWBDYWpZ5?=
 =?iso-8859-1?Q?coA8tgWz57+UbvcOq+760g9UNRGGfZLeMObE/dtbocjoRkTQCIeWImhyE2?=
 =?iso-8859-1?Q?/cGO4/CKQgflbJ1zT17P7LuP4sR5oB3cj7pMmLgRFTMrXhaiDAM54vGaxz?=
 =?iso-8859-1?Q?YSBjOpMojj1OfS+VkswVd8rNahrYI6bsDluWNvWXDOyfABlshCVPzgqsNw?=
 =?iso-8859-1?Q?zwOlndOvEEKjTxrvi0QLryTwqVb72UKXi7t404MkgEGbUKT4QbMedZ2T8z?=
 =?iso-8859-1?Q?PJ4f9JMYo7azed/foL0sXgzlos1v6KLfZzSpWo1AF3Y41qTUFXPvPGrrlQ?=
 =?iso-8859-1?Q?57bi9AWZu2wz4Vo1ux1qpKPclRseLcRzRz+PJsynPbLwuc+rGWjqpNVC53?=
 =?iso-8859-1?Q?SKK6IsAzcNE76qMWgNlCPXDrH8dtA8WSQf+VcKG6dKZV3Ww0zZjOgIrQui?=
 =?iso-8859-1?Q?TidVVLeeLgyRQHqcFOHeAzCPCqvKFDzaSndmurJFvNXYJ2nWWRDlhMBUgH?=
 =?iso-8859-1?Q?d8uUqIv4soIrRPmAU2gvm2RqTDTgJ8xRNUut9xRIYoV+5SN/lD284+tBF7?=
 =?iso-8859-1?Q?bcsh3UyS/+qFZDlIUjhcSy2JMIF8BP0E6DisGczeHLzLZ5siUvEfXm+PGL?=
 =?iso-8859-1?Q?cp5B7x80LovsV/E1sPRglS/uacXn5wYgIFkkCh3/SqDHWf1O1xpOgrFnjf?=
 =?iso-8859-1?Q?EGMBAqkAQUlcD2ZPYlUNSjGuQJLDKV5HjYHIxA/z0EHCms8zxbYYbkNvD5?=
 =?iso-8859-1?Q?o2nSOWYzZA2/Ui0aHGC4bYT2qywle4Lt+LpLfHiXhfjjvWjJ7GldUvx/qh?=
 =?iso-8859-1?Q?SCp9eHIpX9Qqdeg0UCQnGSCmJtVU7V0avB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c1df2b-9946-498e-8edb-08dc7b79156c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 22:38:36.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d7bbaf1-8dfe-40cf-ac5e-41227cb807ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsEM/OLdoHnXEw+51KVeMXGE0ZffD7wUy6fAhGECRbWr6P4EUlbtGeyzvT37bJ0FgEoxJeDTik/koLNk8f3aEeL9A4mntaQlBOTilM/EmD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4120

>> So, assuming you can use 6.9...=0A=
>=0A=
>> mv88e6320_ops does not have a .pcs_ops member. So the SERDES is not=0A=
>> getting configured. Taking a quick look at the datasheet, the SERDES=0A=
>> appears to be similar to the 6352 SERDES. However, the 6532 only has a=
=0A=
>> single SERDES, where as the 6320 has two of them. And they are at a=0A=
>> different address, 0xC and 0xD, where as the 6532 uses 0xF.=0A=
=0A=
>> You can probably use pcs-6352.c as a template in order to produce=0A=
>> pcs-6320.c. Actually, you might be able to extend it, adding just=0A=
>> 6320 specific versions of:=0A=
>> =0A=
>> const struct mv88e6xxx_pcs_ops mv88e6352_pcs_ops =3D {=0A=
>>        .pcs_init =3D mv88e6352_pcs_init,=0A=
>>        .pcs_teardown =3D mv88e6352_pcs_teardown,=0A=
>>        .pcs_select =3D mv88e6352_pcs_select,=0A=
>>};=0A=
>> =0A=
>> to the end.=0A=
>>=0A=
>>        Andrew=0A=
>Thanks for the suggestion! I will try this.=0A=
>=0A=
>Daniel=0A=
=0A=
I had a look at the implementation. But switching to the fiber/serdes page =
does not work. I did some debugging and it seems the page is not properly s=
et in the  mv88e6xxx_phy_page_get call. The function returns 0, but if I wa=
nt to read the value back I get 0xFFFF. I also tried to write to the regist=
er using the mdio-tools (https://github.com/wkz/mdio-tools) with the same b=
ehavior.  But this is only on the SERDES ports. Therefore I would assume md=
io works fine.=0A=
I thought it was because we have no phy (cmode is 0x9). Could this be a dif=
ferent issue?=0A=
=0A=
Daniel=0A=

