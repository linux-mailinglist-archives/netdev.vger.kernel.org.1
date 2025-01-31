Return-Path: <netdev+bounces-161721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D71A238FE
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE401168E44
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1A45038;
	Fri, 31 Jan 2025 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NegLQpzc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE5819;
	Fri, 31 Jan 2025 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738290955; cv=fail; b=bT+bMzuLuUGrVyvyMAz/OTGS/YPbi8AuDppLUkn0OKTBfuBB7DrbK07z44Hcpm3U2v3o30T6mXqPpjTWVngXASI2lMw9bENmG8AlKLsyC+U7odGq17z5X2APYTrY2v/PiaMJsTfT3UkbqMmapxWNeGSJWkfRtMSJaKuhi9+vOzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738290955; c=relaxed/simple;
	bh=IU5L2tpP31F8FamLgUsCy2kKJ2qqdXid+5vj9e5egP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVbl1E3ZRhG36rJc2o8U/YXGkFBk9o79IYQYbcT9kFmoRT7T1nk0bVjbthMOFpIKw8O53CpSvTy6PspkDL6OqdFQLWxxSp8m5euoHzO3w17TL63IMZ0VaSfEMC9LALMYDojGJOvMEIjAFntfU0USQnfJ0MfQMMYXzoGr9NUmbhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NegLQpzc; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqDv/bsjcE+cG4I/MvQhps/z+Wf5CLolqTBT2jT9J0fsThivOx3QSThiHnKURUu0a5yYfKmLnAkxlSLq1p2mpg5GyoAz9wa3NJPL6TQVlwqPCG5E+gzufx/nR1UU0jdrIDZh1XujrhQQTuI52XiTY+6Ij5K5SOLkaPaR2tbB9R+PbbHQswcKFytNcL1CpDses5rrfweKq3/M1G6Q8HjrjSQtXjRclSW2RBOrbfy1D0tVtsxo46oOdAHJ8wYFMjNuBNxqbXGIGWggfkJp/Lxm8k2xflV1VNlnwGKttrTrIneQsLYNa23T7rfXw39xHxLmdJOx/9l5Wo68HX3JT0xd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlGnzji8TPDALXWA76CixCWceEvTib+oLBVmNyZ6y2U=;
 b=sQ6rZpS4/eemK07TIxfzh6NZu24PnSKVhI+76ONrE8db1j2GYj8ADApAJej4cQWDxeVKtJzD3Kidvkijm80fWupll8nvLQF5pThV4oW6Vk6HWDxXoANEVs+Ke17FnOIdW3Zz+NHsCvBwtj/ktgKj4/OEyG7sT+kofGQ2XH6aKBW8OA+6Vvum40bipF/iWzK85ApUGfiArIDz5kUP4VO6kj1p5BMUQXl1vUj9JF5GmfdrZsC/P7YuKeOWneNuoZZwN1FOCeEQXXEO1Mrbs3WmYCiMDNufJlUvWEBPk/TDxWiHLbnV551FqMbRVtm8llE+jB+GZ8mbPNgkNWqPXF0Z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlGnzji8TPDALXWA76CixCWceEvTib+oLBVmNyZ6y2U=;
 b=NegLQpzcKBYWIaRZ7SpivBpoEiozgvfcyJBhpi88aElDkGiUODTks1iulzN9TTF7vtNWQp2DA+Z955Alm3cIbQRhtLRWNd8Rfb5gOv66NZkmDsaPUOziS8FhMBy/leMPanxNCco6u2JJ4ZB9X3+fdrw6lxi+cOl8G/fi7i/oFawJnQeidSEGVhR59K4MAX6oFYTQlE6Q63ILgewT/mjPmY/o2anY65MkL5h5s+EUYw2w4IN1qNh7a7GX+VEyk9eEQOifKfXSeuHinq5LxPBKB0881DPvGJ3nJk7CJTwY9xQfTBqQy8oBXZinQ3LSOCKk/i+tq4g9xOdqSED3UfzkRw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Fri, 31 Jan 2025 02:35:51 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 02:35:51 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAADrgAgABkpMCAAGO4gIABCA7Q
Date: Fri, 31 Jan 2025 02:35:51 +0000
Message-ID:
 <DM3PR11MB87365F7DC7EBCA276BFD1D62ECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250130100227.isffoveezoqk5jpw@skbuf>
In-Reply-To: <20250130100227.isffoveezoqk5jpw@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY5PR11MB6163:EE_
x-ms-office365-filtering-correlation-id: 83f743c5-2b04-4fb3-5290-08dd419ffa85
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?K+D2b3mJSznpKZTeCPy8boEi2LW+qEGOSAx/cEUeMckIJK9a91iIJNfK1K65?=
 =?us-ascii?Q?4j9CVSCbTI+GX48ESUx8XRSbILivwSAdDxfr/3uFL/NMfWAbuIZ3X5sjeM5I?=
 =?us-ascii?Q?7eYKazGUqVBUiHFO06+lBpNbfS+nhHtl17FOG0RVoLXKYKfEhb6Du/UWc5Vu?=
 =?us-ascii?Q?0yI79HmKg0D5d9LOsX8/G8Luh4kP4hoxneCMdZyGcPvtKneHewjPonfGjPxL?=
 =?us-ascii?Q?AVuZM9cKAiZKtmX6CJW3xQ/Ksx9UOuDCPCgnkv2JJ8Fo1rlYC77lm+x+BjuW?=
 =?us-ascii?Q?lkB1yOQuRq1WBYABnXNm6pNCPf6+K4T2oF9tYFYz2JLup4CnnnL9dBaBduiv?=
 =?us-ascii?Q?4RJ/14dHZcEYqA2AllVvNArTx7lKdHxO0+0Q6UsKpCnpqM4cOPpCGS3GxynP?=
 =?us-ascii?Q?a14+VxZ+X2vJFheINvYPikemT0XGcd/bqJibP0GdoqidMfZXuuKWK73aGOQV?=
 =?us-ascii?Q?jI4RZf/GZ6NAL4NVeskGbh0SW5nbPJV3LlraqOYZYqDsgY5LNSLOjkAFyZzZ?=
 =?us-ascii?Q?ZZx6yGc0tSuuVgg0ZBUPOBRfTmrTA7blOEhk/m3hDyXm+LbJGvOsaLirjNKf?=
 =?us-ascii?Q?IYQdA4n17iifZSSc9M82WUbZ7PGTTeCSgGEsclyZSo/RPlVcStzzZyd8716T?=
 =?us-ascii?Q?oJUyXYzTCA1SADgutaKHn8WWkuB/p5CuZb05yg6Y6ErdQBGIzz2vGqhpC1wH?=
 =?us-ascii?Q?cLOkYhGFCThvvPZM7hSDSoDvd2U9Kzj7zScCZ+Rg7zHW7a3Si/4kouTaPD0t?=
 =?us-ascii?Q?2/G3z6zJ6cbqJR3nx9rdS8bTNgBItQwWHPkJCLNcZbGhG09qxCghg4jn0q0T?=
 =?us-ascii?Q?ZE1GTAmdlYNDhSe+Gb3SB46HFu5cO0Stto0UxKPDjxL33WTUqzMkSGYg4+mq?=
 =?us-ascii?Q?F4yjUKjhCUzOh4oHHkrnICAhXHA5M89vYNxHr3uJFxEmPStBvq1W9S4hb7DZ?=
 =?us-ascii?Q?NJCXEV//Gq93i6sYXZgupuGZZ7K4jfK0xGteWQZ2OBr7f5XoUki6yxh90oSj?=
 =?us-ascii?Q?/Vfa0vcn7z3MEHnW3C7bCsex8UVWbYBgO4/4aNUPRpovrPyUkkjm9fG+Vh5K?=
 =?us-ascii?Q?/MTXnTsPtmCVC4osW6zqE5FBbHMsE4vHDJX1y/2+VfaAjU5FI2wxjLn/rCPP?=
 =?us-ascii?Q?WjdqL9hPMe/+W2EIDnub5V3Wz7NkgaKT64k9sN2fgLYYw7WJknemLURWD3g7?=
 =?us-ascii?Q?Y+KjkEQUjB+b9jWamO8wobb0gDGJd0XkNZeY4M6IPulvn7/tDZ5WTR6pEbfw?=
 =?us-ascii?Q?idXm3kPcgKmf2ucU374MX3X9WS8YETB2swMlsM6j0EtBdjd9QHLvMAj1xHZc?=
 =?us-ascii?Q?wpA4y9+zfzVciqEy+Jv5p99SAJDdp2Upe4bz/JkQ90ioQcNNa3Ssafas3keW?=
 =?us-ascii?Q?hPRsgwG8VLG/5/TJmAdr0pgKTBGkxWYm0JVYHDFRBRX61FUR2we3ph+MCKzb?=
 =?us-ascii?Q?Ebae9HAYqDydMaBEWNxfLaxw3Zctjxrz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hMjEsI0FLeJ+F7fRjFgv5pD+4oogL/G49UHFD2irCBewWq386tG/H5LYK9Ww?=
 =?us-ascii?Q?WVQzIfynEy1nCgGU2Yl+P4OFXRfEJdvZOVI3WQy6jgqGI3DKIu2q+jA6jLzq?=
 =?us-ascii?Q?8E5i89HQfCcyakjGWUxaVy+utufh4LenzhP9ujbQeayqcmyRAZ4J7gVfTNfb?=
 =?us-ascii?Q?GHp0DdIW0nSTFAWQEBAp8b9U61wOMwEQUglWTLJgycTtHlxrIHuJgMDzYX5m?=
 =?us-ascii?Q?7WD3rMvWsvfQHkILY3M8NoKTOQY5sd6krnxedKQ6ie/2eUAV+yy271YvHrYx?=
 =?us-ascii?Q?t4BLMZISF+/8ONMuzckNCkIiiJ+crQO27eSEyV6E5awYF8Nu7qR0HLFLv7eC?=
 =?us-ascii?Q?rQmASUc+2jHzg05UYbbDVus1Gp7tJSkK14S7UZVdIMqaumV5bqYtI2j7jHiV?=
 =?us-ascii?Q?/sYO7VK9rN36SWVbAMG7IRrigAnebaMzw2uiKwwKHT0sYozcMYBLzrSuKjw4?=
 =?us-ascii?Q?INu5U7Lu7VgyWDG6ekt1Z6XooCOHhzEufKEu6B3qUs3GysdEgWhNUejK9V9s?=
 =?us-ascii?Q?bh5Jf9fDOdlQzLQznQLJCO2Q/3f4fuMdmYbJpR/7y9aOHl4doWDukZj1gF3O?=
 =?us-ascii?Q?uUFp+bHsoBXVub284Htmn30toYuLb5R+kYwwSWYH1XWWzRdRGU+siFhgNYUy?=
 =?us-ascii?Q?fQsq7Kx8JRd8u5toAqpU5DdHTEpsFgR7zRwuESsa8Ha5pQt9jRLkJ4cSmuCa?=
 =?us-ascii?Q?Dm3+o2Ef2EUSW7sTw0+InvQ7oafOj/TRubZMVRSQ/hQ8O3xEhChxQEVFGpWQ?=
 =?us-ascii?Q?xcJjHgoj6qNCsE0D0QGy5aWLBcQFTs5W3SLBH17cbMh335ex2uKH8ouS4h02?=
 =?us-ascii?Q?BzHnwwa6RvY5ijP7d+mihBlSv9VkUpCJWSNZ3/vTuXuENkDFS6Bs9bwuKknw?=
 =?us-ascii?Q?CbPMyZW0/bJa2TaHoOB2Kd6xN4d4yZhNK3GpqtO7gklNfSqiVvr6hD7kxRw/?=
 =?us-ascii?Q?2pPPzYK9/4d7lnYVZ7Y6FxkZHXbGjp26TLuugVqigwHTdMvqSVSZfOVfsy9W?=
 =?us-ascii?Q?fVsWPWA8zPdxzhoyKifa5xuYyVWEKJ8janodtWqbiN2Jir7scH+L80rOE9kt?=
 =?us-ascii?Q?6Fjr+YaLWlXcUloNX0aPkiGmhY6G6LK0T618mPrO2dOnanccr31g0HthZmj9?=
 =?us-ascii?Q?yDOPmY9ur5bHyJXa5obXIV599bDr1+Xb8kZqz+Msl3PtvXei+4fSBU55ys98?=
 =?us-ascii?Q?dk688jZe/f2M8nqh4iLQ2LNUnGqzK2XbKVfEvAIFPi22+aBLp81AcOvC+7fh?=
 =?us-ascii?Q?toh1QF3rEpNBZHW+RRut00NNqZJt7d1hRWo7QIecDe6OtuH8FtxhYpuUWqyK?=
 =?us-ascii?Q?nesNtvKIH4oN2vbXJGoHfoKElti63Cxke4owfHOH8pe81cN6Tvm+ImfIIa+r?=
 =?us-ascii?Q?Cnt9asxkms6PO1t1AVL3KjSS7wIsKQA/8T10UW6LERLdIPAF3lwV7R79xzby?=
 =?us-ascii?Q?Xv/erQ9mvd96dlj0PVpPBep0U6ucG2vJ/7eoZWpT1Oj9V4khwsV8Z676MGVK?=
 =?us-ascii?Q?U6kmyA2aza2sd04eO6Xj7MmqGZp2YWkHE5OF9xi+sEljfN3G245SILyC/18Z?=
 =?us-ascii?Q?GIQLTmu/N87iAjalEzAWx7kWhNHL2afcQKXYTrne?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f743c5-2b04-4fb3-5290-08dd419ffa85
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 02:35:51.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2YNTUftMJryyhVjzQn2KeMEhdIAkoPUH5AlSVVoioxHVLK0Eykr/TnN0pi1XwyfMCcdYrj22Oh/n45fRW5cYcXf0sygJH1lFc/Eh6M7hvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163

> On Thu, Jan 30, 2025 at 04:50:18AM +0000, Tristram.Ha@microchip.com wrote=
:
> > I explained in the other email that this SGMII_LINK_STS |
> > TX_CONFIG_PHY_SIDE_SGMII setting is only required for 1000BASEX where
> > C37_1000BASEX is used instead of C37_SGMII and auto-negotiation is
> > enabled.
> >
> > This behavior only occurs in KSZ9477 with old IP and so may not reflect
> > in current specs.  If neg_mode can be set in certain way that disables
> > auto-negotiation in 1000BASEX mode but enables auto-negotiation in SGMI=
I
> > mode then this setting is not required.
>=20
> I see that the KSZ9477 documentation specifies that these bits "must be
> set to 1 when operating in SerDes mode", but gives no explanation whatsoe=
ver,
> and gives the description of the bits that matches what I see in the
> XPCS data book (which suggests they would not be needed for 1000Base-X,
> just for SGMII PHY role).
>=20
> There must exist a block guide of the Designware PCS that was integrated
> in KSZ9477 in the entire Microchip company. Or at least, the hardware
> architects must know what is going on. Can you help reconcile the XPCS
> specification with the KSZ9477 implementation? "The bits must be set" is
> not satisfactory when we are considering a common PCS driver. Were these
> bits overloaded by Microchip for 1000Base-X mode for KSZ9477?
>=20
> At the very least, it sounds like it is improper to name these fields by
> their documented role for SGMII PHY mode, when clearly it is a different
> and undocumented role here.

Using this SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII combination does not
have any side effect on the new IP even though it is no longer required
for 1000BASEX mode.

Note SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII | C37_SGMII setting even
works for SGMII mode.  It seems this combination SGMII_LINK_STS |
TX_CONFIG_PHY_SIDE_SGMII reverts the effect of setting
TX_CONFIG_PHY_SIDE_SGMII so the SGMII module still acts as a MAC.

I will try to get the information from hardware designers.


