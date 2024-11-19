Return-Path: <netdev+bounces-146199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14E9D2395
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF7F280988
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEA1BE87C;
	Tue, 19 Nov 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMcKf6op"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AE13E8AE;
	Tue, 19 Nov 2024 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012137; cv=fail; b=fCRkduytkPGFeGra/qElUQ7xVMaJqNYrj8ilgU2xbCRydY3TLepIwrGyNQ8borEjYFIjltjv3sfy8qHD2Vz9HGvgWCa8AOLGvCE9pLNUls7GeKG8iPJIhSnjs17Vnpw2NE5l84Oi4xkSOeCwcg/soym7QoF66zkzsUXo7P6bqUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012137; c=relaxed/simple;
	bh=IDFngzmyme49hIG3yDRLC2DvAj9I/vuJo9Fahmi5meU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPl/03uYnUbaBQHMuZdp1BEo0Fp8d+SliR24IDulKxmabnq0NvdiWrwQ8GNJ70NS9z202MkrjQIan5lLwVtpGZzQ4LdxfMoWiHxPb55ONJQ1ESoE+iyWJ1VoHh6zTy8+dtVlSTKFIN6x0dg4W3FfhI+UhTejcAOGmMuNeWWY4SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMcKf6op; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0xjVhDFUedB6UH/VVlHE40zDNE1StxZW6BpetK3TYIb1LNg17VszhmQlKMa/70c/zSK8FHSO1lqVGNPJ+9RMY15OkE/Fh/Bh2VWqjlcuc/LzwS4B0s5ns9iUgCDtp+aaon1nkhpUk8Znroqmmio/SdRlq1njCZegXUYhw8smzKLX/5VIwnc2TN46HU40k/oSsE97wYDzq/UGiuvjBWLKjiSttUJKdMogVpUVd1Wb991xQVZSTJ7JQ2JBsZsOLtHFXRDfB23q67OGAg9Q6PtnL++eAEh1RajRFPaMrQComV8TTdPK+EoA/aOBA90sqkz4mK6D/1MtlOAbwWE81bC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BggdQOSekUIBIjAdQGRr1aYLYgr7T5ZPx5X8SEl/Spk=;
 b=XI7D+UvcLTuNpSh/eApwqm1UwXxm/NNfRj+QHfGSPflxevqT0VwrQvG+1WnhN/1khbn6LAPyhhuQIqnJP50ATBbuHaTGdLyvQboLssSq/UEVWXS5/+jzxQ4icEvPEyO2hhaeox/ohsjxjelQKNoTqsu4R/gJTpowkwkex+3hqF2yBP2S196cGubAEHLAb0NHIM9vcpKUUR6y2DDl79Hn+DIYGowUyIqypl+WX/Fyz3CgmHicR9Kp/MZvWtLqR0iiDsRTcJWHJBnh57xkqCQzirvtesZhjzQljN3PyM1mnZHxPS+WSy3QVwhgdi/qd9QI7XUuwlR/33/v28p2mK+YJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BggdQOSekUIBIjAdQGRr1aYLYgr7T5ZPx5X8SEl/Spk=;
 b=mMcKf6ophYFAgqImCYZRDIkaEOpflH9GpLs0hMg1sw0SjOB1mjbH5pzqneRh+N04gDp6GdGcYVgaR0RprqN8t4YtMHIUAowFlaDnQSjmt7/b8dYeWVCBrJF9QnGsVVB0bzMkEymdlPtVEBBhUrJK+6XOK0kQLsP0l6PxSXSxKvQ=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 10:28:48 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 10:28:48 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Russell King <linux@armlinux.org.uk>, Sean Anderson
	<sean.anderson@linux.dev>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Thread-Topic: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Thread-Index: AQHbOZPrN4QoHKQMl0i3DrWTLLaCrLK9McgAgAABAgCAAAJjgIABMZUw
Date: Tue, 19 Nov 2024 10:28:48 +0000
Message-ID:
 <BL3PR12MB65716077E66F2141CC618DD9C9202@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <Zztml-Te38P3M7cM@shell.armlinux.org.uk>
In-Reply-To: <Zztml-Te38P3M7cM@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|CH3PR12MB9249:EE_
x-ms-office365-filtering-correlation-id: 27082154-5d69-493c-e3bb-08dd0884f47b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9w/DFOT64tfbUruCiA94n7gSCkZfheT+8vSqwQGliVPvD4/lxrx+dOr9Ze/O?=
 =?us-ascii?Q?LvZePVPyVBIY83JWcqhpYzCwrWGBqOGku6nfXlEPIHtfYnIw3joNeVu0rK1p?=
 =?us-ascii?Q?zJ9xR0O+QWXU6zwDW77gNxGa2TomUKbSdpOsGqeyqfcUuvvMKRCvssF2ZTfO?=
 =?us-ascii?Q?FNo8LUM/bxSpMT6ET5HBOs7+hnzqgz7Uiu+hoNf6bqYGafCXQI850pt00JHY?=
 =?us-ascii?Q?I6M4xFHbJ85+hQczeqPFX+GcucNxhne7gV5LdkvvPgUZ96+rivXFQrRgAm+w?=
 =?us-ascii?Q?+DvqXwvojWKPqnnhZPptl9jae1bVKX/g4xxuQpMfHtAWIsTNOF5TXazVS+Z/?=
 =?us-ascii?Q?GRcyegdjw0e0hUGj0qLg2Gp2UxgzoUwkDr8LmvfkAEMJ2puH0R+QjrD5Dz3G?=
 =?us-ascii?Q?qT4Kp+WzwdLkGJuysJBxmOB05/J24Ud+kPicEsXFTCuwAkid0f1Y42VTq3qD?=
 =?us-ascii?Q?a0GZCc0VZqKisnpTMAT+xiLDjXvwsaknnJGV81+LDi7clrUK8XO6GKAmI+6Y?=
 =?us-ascii?Q?mvn3CT7nceXkNoKOulmxBxk5KN6+VqJV2tgc2YAnx/EJPH5uZmpFJoq9PziK?=
 =?us-ascii?Q?Dfp7ntmjIKGtlPyaYxNVdLczmhCfR7wPMIxBU8VMUQUslUJvWkj7venOmm5Q?=
 =?us-ascii?Q?qEfuQl0R8YFhNgs3BgUQaCA31mgYim/zTBgMTkOsSPsV9FnZ25sayaSlhu66?=
 =?us-ascii?Q?dKEa4sQn/QpJkKGxwrk6TGVY0MMpEQDnJTtBRLtRtpQiNasZsUckOFdBPwna?=
 =?us-ascii?Q?GZwik/fRYr74Uijo8TOEGEt6y7gJsEcM0uLAwnL7HBXFbpZG/0gLf3fYFPUv?=
 =?us-ascii?Q?qq3krEZllWlA83vSQCKrXSovXpkEzQ1KPCkyVXuXAUx/C+/00RbVtMQva3Dk?=
 =?us-ascii?Q?XUIhfJnbAGinGRhmKG/nKSHMQbe6/cJNA/DuEegoD/jmZ7/AErP8v7Uj2/Jn?=
 =?us-ascii?Q?VwtqNhW5QjGaUSNma5oVfE4d1e1UbicAhQNHUObXt5MyMFzP/zVRUL8UtU2p?=
 =?us-ascii?Q?k40shLqQr52VyDOhxcPJdaLZ+0xwSYRqsGU51JEJ2KP7YoMYT5JufCihqTgE?=
 =?us-ascii?Q?j6EWwpxS3BeNO0h1M9hmqVoqxYBILkflATYE8y3M2hs9O32PwPcCOdc9SuCL?=
 =?us-ascii?Q?LE08gDxv2DvGH8FR8i0zp03F2VhRieS+ddyx5ErS2y11XqNKuzQZh6SqcOne?=
 =?us-ascii?Q?ePHN/VMoa4PSDA9vWt7gGkdgec3k12kl97DqvqjpYeStDP8MCQM+ulHENphV?=
 =?us-ascii?Q?MEIfBebV1QIsIqUL2tibjjbHWvuPpcIk4ULQ7390egVYbcqTr0WwUPhQ31zM?=
 =?us-ascii?Q?Fm7ePyF/1qKOy9cK36f1ZN3j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1WJPYaaMuGkzLmiC9kggDLCWiXvqmD1ZKrzlXfKc9SSCKqmGb+iFtnxut/ZJ?=
 =?us-ascii?Q?SEvuo2wySvJ9c53O2raZ/gX0GATKtnfQPVNJknlGioGi+W6uA3H9+JLsFPBn?=
 =?us-ascii?Q?k6I8JCZWl86VEjFk3iAaya/bBf1C645v0QNqG/ctJsgSjzlGtItygDcu1I6i?=
 =?us-ascii?Q?og7YpN3yJwvCUkU8IzybyWosBoMmJn2sYy4U8x314gwrlQL8eim8rEJ1hEds?=
 =?us-ascii?Q?BUoWVyrDyVcDUoBmnA0i3H1IfQ6e9vA4BMpHStFAChR7zVQ+3hMXaMDOwgGY?=
 =?us-ascii?Q?0+TWEPZcFp6nUUId1yY3dUrvPDFWviuDQThfFw1xFhCky9dwktmHRipKNrzS?=
 =?us-ascii?Q?wW4nzKZr7aH0eelHAsTRgBWzmAoL/uE41oJ+kdkICjN0OMSLh5WcGjho60gk?=
 =?us-ascii?Q?uP+krWc8+w4YZvTEN+IxIfWMaDkICTffrabLH8GJJ/jMG98ubP/Xdnbvi7Ki?=
 =?us-ascii?Q?mtK55oYauLEbKhofvF4f0jF04/RZPf4BtBcawyIGWnBLZNA9GffqnmbY9Fgh?=
 =?us-ascii?Q?UxbIzvzl7KxVO+A7SZ0OPVX/4sFiRIbzWuknlJk2MBwcvwcyOYQxhogNh35r?=
 =?us-ascii?Q?5fdlj99RhzMjzlFIXeVbM5xgWGnQ85wuUSe9btQrRG/Jc0KGc8Wt/oxWewHp?=
 =?us-ascii?Q?ExBtGfBLAwBRcCXDYQePyhzMhd3rmPeCtjsUeMjaj/OztqE7NxRqsTfG970i?=
 =?us-ascii?Q?EtTAQo3EPhD5kZUYMhbq3HHHPRsD94X4wnAcY5CaEpp7SwmzUXDQRv37sN3G?=
 =?us-ascii?Q?8IatrNNcAsMipOsHNM+gTUVIX2vyoB3IKmH1gj+p3Vs6xyAH3qOmHLe9Zwl+?=
 =?us-ascii?Q?nUgJ2SwWaDlnHNKBxfcccJZ1bT92xa7YcSv1bQmmcmpg1nc2b3kdwxUml22Y?=
 =?us-ascii?Q?8tPHxPlT9/I84NSuLQQHXvEcFzRhWv0oArT3M3W3o71hmYIRGy0atzpqAEJe?=
 =?us-ascii?Q?+KVaAylP3UaIGI4U1emyXaU0P2EdxItkEk/oiOPRHWQZylo5ucJHoeYHZ7ws?=
 =?us-ascii?Q?KmJngDZ00nT0Fjr4n7ODsGKRKRPL+ps+IQVAxBMSSmjDt/XLS/WDg7lE2BTn?=
 =?us-ascii?Q?MdHOWqvvSribgeCWj1EVOEHhlUBe+HDvFM2TTvQkQtheO0wJ76sNvokLTuGU?=
 =?us-ascii?Q?dwaFZrK9QyUgt6T4Oz/MpskXG0fbB6O6TC8rYWO8gO6Ij9NWxjPsIy+tljRH?=
 =?us-ascii?Q?znxRHIwuePIayhvg7b/CKr5qmILw7xV5qIisXgoQ1H3KZsPddZ9RznJ8nk/8?=
 =?us-ascii?Q?zaQPzWPK6P4TfwpyA1HvrUVv66yuHYXcd+lTb+RoTVqYKeAkwN36p37HJh/z?=
 =?us-ascii?Q?29OBGLRY7vF1CHDF8WXS6YS9v09fthWI0Z19yzf5FsaBke/swKCjbEchv6FT?=
 =?us-ascii?Q?o1T9ZWmd/TVHEs8oZEBhKHAgLcXIIKVur1hzuJ6J+Et/yrpumR/QgLgWbuMb?=
 =?us-ascii?Q?k9HCzexPNYnT11ZTReh8Ie3hIgr1tvB9sBlj+WfCQQLImhsDhczDcr3dUa+n?=
 =?us-ascii?Q?zupu1qHQ3T3bop6Ru6H1RD+v8tBSM0KMMgbuNFDEFUbNpCrDiDjAuYCY9RiT?=
 =?us-ascii?Q?RpurPjvTi57MmYUQZpw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27082154-5d69-493c-e3bb-08dd0884f47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 10:28:48.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsNJHNgNAKjqrGBf/eC/Rep4+yzi/KCBmJCH7qq6RrfIzN1kBr7FZn21HJ+NtKdk4UfhO1ofkT4Gz/DFf429TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Monday, November 18, 2024 9:39 PM
> To: Sean Anderson <sean.anderson@linux.dev>
> Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>; Pandey, Radhey
> Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G =
MAC
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
> > On 11/18/24 10:56, Russell King (Oracle) wrote:
> > > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> > >> Add AXI 2.5G MAC support, which is an incremental speed upgrade of
> > >> AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property is
> > >> used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> > >> If max-speed property is missing, 1G is assumed to support backward
> > >> compatibility.
> > >>
> > >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> > >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> > >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > >> ---
> > >
> > > ...
> > >
> > >> -  lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE |
> MAC_ASYM_PAUSE |
> > >> -          MAC_10FD | MAC_100FD | MAC_1000FD;
> > >> +  lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE |
> > >> + MAC_ASYM_PAUSE;
> > >> +
> > >> +  /* Set MAC capabilities based on MAC type */  if (lp->max_speed
> > >> + =3D=3D SPEED_1000)
> > >> +          lp->phylink_config.mac_capabilities |=3D MAC_10FD |
> > >> + MAC_100FD | MAC_1000FD;  else
> > >> +          lp->phylink_config.mac_capabilities |=3D MAC_2500FD;
> > >
> > > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
> >
> > It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
> > (2500Base-X). The MAC itself doesn't have this limitation AFAIK.
>=20
> That means the patch is definitely wrong, and the proposed DT change is a=
lso
> wrong.
>=20
> If it's a limitation of the PCS, that limitation should be applied via th=
e PCS's
> .pcs_validate() method, not at the MAC level.
>=20
As mentioned in IP PG (https://docs.amd.com/r/en-US/pg051-tri-mode-eth-mac/=
Ethernet-Overview#:~:text=3DTypical%20Ethernet%20Architecture-,MAC,-For%201=
0/100), it's limitation in MAC also.

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

