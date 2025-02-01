Return-Path: <netdev+bounces-161883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206EA2460C
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1002F7A35FF
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2425C2C8;
	Sat,  1 Feb 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DbPu7D/k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766115AF6;
	Sat,  1 Feb 2025 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738372319; cv=fail; b=sW96grkNz28wO6jVZLV1h/aumZZionOb6rdYqGgy+OgB7XXPbpXdWTXxu97sVEP8tr8g85V2IFhY+KL+NkQcIUjQLxdlyF4W0s3JNQnSTmkjuICi7Imb22zNKB8ePJ9dPASPnBKXPHDoEtpSJBeNry9MoSbN5dEoClei2waIlgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738372319; c=relaxed/simple;
	bh=XTERANbOX+fPANV864loirTBgobOPiV+8Yne6W0j1ZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HgO8odmyF84x/GLv2ae80itMxStv3+nAOsfxIODobG3toyu+bE0BQL47d5Lp9Qk8JClpVXEKeGRocb0Plt27DQplodrsGs/Z0xyIHWCW38ruzHzkdKZKZvRKU5jIUVricGzAgHEStXuTF5yecWHOIdGWq5BE81dzT2Kua4ubMKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DbPu7D/k; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMfRGd6EmiA1+yUXPfyCGZnKX/YDgsGytVJK53zaO1kG4XHJbtvE0pg4momYEQNL3m6B9e8E7T0lXibtalDaO86SU+pJWXZYV+BdG1wHli0S1L6LaSAJmgSwk+EadnTXyeMl1jB5ETYnoxE82sWz5uG6u3TfyxJ8eB+zVNcEuQaIM336PdNVpiWLIvSbZ5wZqT/wsQkqIi0/KQ0bdy7tWhRSOtUaWCrXPr+QQYi+XBi8CVYXMUlz4ZVLDVScJ0vZ/vSaUVrNGJn/lNqAFFKguWbYFBEku3jjJ1NykU07Lqh82yqxUm42qPNktVLqUxsBm8xWRvpX1Ne4Qq2iS7aB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdTzK0HgogaeJ3dHtCey4g+/v3CaTXpj0W6O5zvF9CU=;
 b=s1qu1Cxz9JT7LIgGrGf5Qx3jiXnb6l5mGYr3XOkWVWWKhYr6tCTACU1b3cWaldVX/MBsnL+PM37m4RT1cxU1jk1gJdrf0PK0IsQ9GrItbHr2WyTQfonqg7eItTt2qGxRz60+VuhHk80b8Md5YedFnnNR+dpkWyln0J2oc5n5aWYfqy8o8DTFr8PfOKJIhccRj5zsk5STJYzkbcBdMWwEmz3EiisfsaMiJv0BKt5Xjr68X576yuLwGWVNEhf7I1yyXDpU5c3SGw5wNZZQ5zyfT1agrKI8QHWBC/WtYCgLk/jDkGt0NBhErD1M4Tm+qkDKuDflLFUJ/1NQ0T/AR5Emjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdTzK0HgogaeJ3dHtCey4g+/v3CaTXpj0W6O5zvF9CU=;
 b=DbPu7D/kf4aqrAEmmzrvDDSJp/Rpst4rjQXqybML1Eni/0YvqNNVAaYCuyOixjm+LmLJMxThH7DiRKzI7ADLQYTBmuKsMOqE0Kdo9Oliz/B39AxkYUDHATvqSmeRAeFs0M3QTnuYXYkXwwSgJalYKFHY+7wU8cu+NUdbTikTx2wcX2q4DrxxKS+cwR3uBjwbLr9nDUnygBylcqrofpRhLEoUdMMLIarJ2b/imYYaugEURlXkapKJ/iJY3E4QtrViWkQMyUE+qnGfCpG7Yiovxq7mQR/25nKwWyOkhUVlL4ui1bZ3smQNHLSB0PVEw7dFeegJaN+879RqHcISvmkXdA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Sat, 1 Feb
 2025 01:11:54 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8398.018; Sat, 1 Feb 2025
 01:11:54 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <linux@armlinux.org.uk>, <olteanv@gmail.com>, <Woojung.Huh@microchip.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAADrgAgABkpMCAAGdLgIAA/zzggADK7ICAALnaYA==
Date: Sat, 1 Feb 2025 01:11:54 +0000
Message-ID:
 <DM3PR11MB87369544966F3D2BD4584D38ECEB2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <Z5tRM5TYuMeCPXb-@shell.armlinux.org.uk>
 <DM3PR11MB8736A58E065BF24C2CEA5808ECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
 <8866e9ba-642c-4b09-a6da-e352936956c5@lunn.ch>
In-Reply-To: <8866e9ba-642c-4b09-a6da-e352936956c5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA0PR11MB7911:EE_
x-ms-office365-filtering-correlation-id: b9974b6f-29d1-4384-95f9-08dd425d6a8a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LgYX7wQ7IFUawmF/I5vcak5HoqDekB8j/dAcy+1pEofU6LdZqWb+KhKOwQyM?=
 =?us-ascii?Q?cZqa7I4ml74kQICOOIeEOfLNBbnswOxkqilefozsbLOnYNXPuzhrHUSDxQF4?=
 =?us-ascii?Q?seorUt9rswKPBHjsqYq1FLRhhVTfGXNcHITHrBARkCMEG5okzk4NutMbf8XQ?=
 =?us-ascii?Q?OwnBgaA4GhsGpASmulsQtA1QqX1mwdw0B5fmILIx6oEHMjbKX7CpdXaBMKZ7?=
 =?us-ascii?Q?e7Fhj+A3T5xTjnqj6aY9uwF23fC/C96iBuPs0ev1+uAL1XgW88Gvdk1iXOZz?=
 =?us-ascii?Q?oXodignurbZygR/gLWuWN4bCs8PknMWQcTmS9l2t6P+u+m7+H4KirsygfaxI?=
 =?us-ascii?Q?JxCcrgW3a1/KrrXC0ONnYpNIB42G814ZLP0kzf5kMrNwr69buPqEMTBue7VG?=
 =?us-ascii?Q?F4ayxsJhyJQLKjfKNbhG+fj+Ba8YcQxgjYLsgiKzodytS9Go2IlKIEoTBI5o?=
 =?us-ascii?Q?3gqnkzT8o6ylmGmqT3eqdEl6tJ7bD2+OOUwguo7cFj77q2Sv3H5sMgfKwXIW?=
 =?us-ascii?Q?rXFL838eAQTCUeDx1tfLL19pzmGhyTR0Um+7jbBdrpItIp+SUJ8/EWHM3/be?=
 =?us-ascii?Q?mC/fXlov+bNaogn8Ifc7OeMebhQlTfS8ABdtYhJRYGANyCbvHfTRe8roIFYw?=
 =?us-ascii?Q?p8JB4n5RJCOukWpt3PcOHaMCvbt9i+lgZgdi8UcceRzL4CPeEXYiyUau8cle?=
 =?us-ascii?Q?K8pbOV76F6zT+OSDY8Qj1QHfgwy2K5R+I9kq4ZKM8plBsUsk+OIJehnvibw3?=
 =?us-ascii?Q?VwPmeG67AzPUO0r+ydReFcqIBN22uA6ypJSK10UI+2dcJ88avAzvx559ef6X?=
 =?us-ascii?Q?K12EtoCwUdrMVGHIL8XMjPChWDzYmwMTq7PF+1KzB2XsMPUphznS39KxYgeT?=
 =?us-ascii?Q?K9yHb/X8Slb36fIFyfQde1TATiMwgg5aiJAyQPBJHhomzI6nlMIkX7haYK+M?=
 =?us-ascii?Q?qYIwfXpI3xx54p8rTyrEdefY7oMjLU1B/efrrTYhPwojCl7BJcuKXIRgPErY?=
 =?us-ascii?Q?B9VYw4Y9GkKYZXIMjrRjXoMct/9eljkzBNxRRUnQj+YPiEmkfIn7fE5EWKCA?=
 =?us-ascii?Q?mc6hvc2qpHjwCwlcK6lhzvKb68ZfcmWbK7pD5ZHCZrrwwpwCDV0yJ+YBUu5m?=
 =?us-ascii?Q?/5VksDpz/N50g4xjJT2gCIZVjgkSTsqLoiRixApJRwBzDVcIDCyxhkcrXjHu?=
 =?us-ascii?Q?mJrQxcyXNJBcP2g9fwXetS5figI8LAJqqiKf2wW2PZ6TaCMSb7dzaJpVzslh?=
 =?us-ascii?Q?HM8FOAh0pXxu+d+hb1sI3p6OMoHZM+AaNu4ZrIuaBjNNpOoAyKyInsvDU9ir?=
 =?us-ascii?Q?mUTJIZb1UksQY69ZWoIIJr6RmEy6aHakzaQpUh+jE/UALvKi5rOCM6zEg0+q?=
 =?us-ascii?Q?Ne8IkSAhewiWY1CRkh38+/lsrkGYfUXL7v4JL8wRPsJa6KXzXebhJDC96qnB?=
 =?us-ascii?Q?jiSq+ykVXikZODDL+LAQ+h6RoypIY148?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IGpDH6BhHAwJZqrnOy5pLePa5DZS9c26sVuhfopVFUsLpUqoH2qEUoCSXDju?=
 =?us-ascii?Q?Yic7yHL2rryDjzLF0ggw5EPp/2p7v/V0nFplYajwAB+FPsHMNYPPT2EioRbt?=
 =?us-ascii?Q?p67S2lW7+5sELVD1PocIk5swpGGn9QgyXjxKqs/GC6+6qPGO31iJ6gpmYjSF?=
 =?us-ascii?Q?WeTgU81/1wpB8Ag0224r3iI0gOB2O32LNcsu2e5rtKRITai/Onjw+me7a8E5?=
 =?us-ascii?Q?A5mEgEbv0u/NQIYSHDOnf5x9WtG9Dggc9+ufYLwVvjplH18fKupmvg7gJ0jt?=
 =?us-ascii?Q?+eKwAcplvJQZShx9j+e6NSsnZ8aHokAc8oRCz5Ida0t6bBh12GOGsuwflHb7?=
 =?us-ascii?Q?yrQP1j+dAo3TgD809S3ksUW8VeVZk+z0Q/r+9WG7i1ROcyQ1NGXIyVEwAbG0?=
 =?us-ascii?Q?iqnM2PGqfh9ehMc27zEmKAseDjRPhHvy+4lVGJjnGXuQB+O/h+fYLrNELIpD?=
 =?us-ascii?Q?j3sSxSDhG+CT/Ycqu1uG/gPj3mXEm6WzkTDR1bfojBbNNOvvSlpolxVt2KrF?=
 =?us-ascii?Q?KYa1azVw0vBbLQsHF6U6H/cLbpmxT+Q5CRT5VzmMoVi6i6ZoFlth17xeTXBZ?=
 =?us-ascii?Q?rxp+e6J5cHsBwpG7rf3rmKnY6d08Axf8aJZCq8Zp172EO0QkZrtweu8gNQ9w?=
 =?us-ascii?Q?YUAjyhx086PbDBMYsaj0kbCmNoaCTeqp5HQzUn55g/UG62JLfuOSeUv0h2iu?=
 =?us-ascii?Q?r6FsUHMlVvReKKJyi4jCJ06JdlkzpXaKxl5vabYeowohlSFN9BalVye+zTC5?=
 =?us-ascii?Q?rlLiOFB2CWMWfatj1yLK61/8XDwC6rc84TF1BHEymfeATD4WjMeBvVbtCcEA?=
 =?us-ascii?Q?a3Y50dBsBoV2luQAAmGB0T9QTM0WQbNFJH0DL8OB5Kwuf/A9I765zlED0VvS?=
 =?us-ascii?Q?67Q3SN6ulWRx3de3b75gRdy4Tph0ocQORQvA4E67RDPccuZz18G6AT1bDX84?=
 =?us-ascii?Q?pJJl52/6L5lb2snTv7OuTAHF2jObJhC6Gb3ZxLCKOq8jrFSZfNSbKfhpDmLy?=
 =?us-ascii?Q?PZJvA7XXAwcjO8CcvlTypimx/BBFB2habpaw6zadtIVuEctYlpBsQy8FAhc5?=
 =?us-ascii?Q?2OmdscG8NvmiGWZxSWnycFAc1NHdf/8M2jSOY3FHXWiK1YhCBUR26j27ancx?=
 =?us-ascii?Q?RAek/JrIjRxrKHGKBjkwXpq8ECw45MdLbM+GuS8KXC2EA0ktL66iq9BL/hpW?=
 =?us-ascii?Q?ka207j5RUzIihcmTJqdgcU7/2xf+fCL4JzlqJRP9MwQs39J2n/wxGoyEn9ST?=
 =?us-ascii?Q?01WzxlRDuo5jUWE7xiM+bR0XJqPriJNzkbCUMPT2yQ01+Sf+A/QQuMuN/YIJ?=
 =?us-ascii?Q?mcA/NDkKntsEdtVImfrLl7MgAnM85Dl30B7NRRi+JOweG4Sryzpg851Ub3Yb?=
 =?us-ascii?Q?cCMy/slz5ypVi/cTxgudM0Z6skeCg3UNhEvWqTexRc6WyxX8ar7ZN+WIK3AT?=
 =?us-ascii?Q?DNBXnTnsIvMJa9ussQPQfs1HoFknXdcAoVbrgJiU5kszrYi4OgDKfNpImoqH?=
 =?us-ascii?Q?lRuZgogPNN9YFzOIPzNgkqWgsD6+5Xv1Sh4TyAM7Ypuqv4wYKHx4HjRZ+ZIW?=
 =?us-ascii?Q?+9R9n41Lj0B7gc7FbdMemkp0vkNcyIQ15l253B9l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9974b6f-29d1-4384-95f9-08dd425d6a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 01:11:54.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7qqBIcRSH5hHc+xKArnouYe+jjoar3iqUb99HJA0bvVVSRS49X30AHk0ralY2P2cnvXZUHd2ybKJYS6cm0ov6zwhJUSqvOInsVz6IaqztQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911

> > > So I'm going to say it clearly: never operate the link with dis-simil=
ar
> > > negotiation protocols. Don't operate the link with 1000base-X at one =
end
> > > and Cisco SGMII at the other end. It's wrong. It's incorrect. The
> > > configuration words are different formats. The interpretation of the
> > > configuration words are different. Don't do it. Am I clear?
> >
> > I do not quite follow this.  The link partner is out of control.  The
> > cable is a regular Ethernet cable.  It can be plugged into another PHY,=
 a
> > 100Mbit switch, and so on.  Currently using 1000Base-T SFP running in
> > 1000BASEX mode and 10/100/1000Base-T SFP running in Cisco SGMII mode
> > works in establishing network communication.
>=20
> Russell is talking about PCS to PHY, the signalling over the SERDES
> bus. You are talking PHY-to-PHY signalling over the media, 4 pairs of
> copper. These are different signalling protocols, code words in the
> in-band signalling of the SERDES data stream, and pulses on the
> copper.
>=20
> Russell is saying you should not mix a Cisco SGMII and 1000Base-X
> between the PCS and the PHY. The code words are different format,
> which might appear to work in some conditions, but in general is
> broken. This is why phylink will try to talk to the PHY within the
> SFP, and set is host side interface to Cisco SGMII, and configure the
> PCS to Cisco SGMII.
>=20
> > > If it's still that 1000base-X mode to another 1000base-X partner does=
n't
> > > generate a link-down interrupt, then you will have no option but to u=
se
> > > phylink's polling mode for all protocols with this version of XPCS.
> >
> > It is always that case when running in 1000BASEX mode using fiber SFP o=
r
> > 1000Base-T copper SFP.
>=20
> So in general, you would not use 1000BaseX between the PCS and the PHY
> in the SFP. It gets tricky doing 10/100Mbps. Since 1000BaseX is hard
> coded to 1G, there is no in-band signalling to say to the MAC to only
> send at 10/100. So the PHY generally has back to back MACs, the host
> side running at 1000, and the line side at 10/100, with a packet
> buffer in the middle. As the buffer fills up, the host side MAC
> generates pause frames to slow down the MAC to stop the buffer
> overflowing.
=20
I suspected that was the case.  But setting C37_SGMII for 1000BASEX SFP
or C37_1000BASEX for SGMII SFP will never work, so there is no situation
to mix them up.  The only concern is using SGMII_LINK_STS and
TX_CONFIG_PHY_SIDE_SGMII in 1000BASEX mode, and from the IP document
indeed it does not make sense.


