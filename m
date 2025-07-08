Return-Path: <netdev+bounces-205121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF0AFD742
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A959E1702ED
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A663222599;
	Tue,  8 Jul 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kxT+3aTk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23B1DDA24;
	Tue,  8 Jul 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003711; cv=fail; b=QBjNTgIFPa4FeRpCwG88dxV3k5lS79Iga+xaTvcciHL8ULaqx509Ck3KN92s46Jq2xR6dcy0vIU8tK/7+pobNaOs/N6xA9SVnkun511W/EqT75sQ2p5bP9PM2mCmdslAOBtzDpVshEYdki7bVl/OS4LcL4zmMgLcDRXa13yAshk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003711; c=relaxed/simple;
	bh=s2bXWUVSxKyiHXkseqzWGaVr1bQQvaGTTI/AXRuEr18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNJBply6Y84sYWJrWUT+U+Cuhj84SR162R+olzhiM7zlYemRlECWWEmqzeh3kH2olPFn5TrQtgarJTuAfF/+oKKR7qesfsetZTH3icbmQZd2yVE4pHWhxZ5MsQiCOjyJ/SA1YAPPoe0DW54hIwiQprWrlqFovYXHYBlObW6jrfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kxT+3aTk; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwZ7KUxA4vZJf2c0/E85fo6GcsZaFiQg4ChWuU3eUClVsF5ykDlyO+/xEfJRPE1XWjri30qymgpOHyDPup+db6Jc2NYd+cmr4JkNGL1Hltji3h6I1wb1UadhIvzStcXo8jhwAa7TvHnNoom/YG6A27zsl/62mbB9ayBUwAEDeNJyTETkzeHw12cNoE0YwlMiR+xxga2TCpydKhBNSalcn0OXZgVDZjWW8MQ0tTS2PLNvKVH1b+SP3EicOK2v0AE+OjFVeDgbaVAjrWvREy+mfG3Y9JSs952Gdb3JaDlTnvk/CnrZDG9YGQo+0WU7NpvKG/O0nrRWqYxNtibQIw4qGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I97mhFhrYNLFMiTu023R1TimrRf6x5LUajm9a84cNk=;
 b=gu6+vcxcpBu5DOhzo1gO1vFH6dRiQV/Wf6j2INuag4c4l3GLpNqVcVhjkFv3nRzYKCqp+Me06zUIt+NPMb0VLbj6RFeu6yFVQZn77tzTvn3dfYHlxoMroxMPYeROYfcEy3RyKKnG4sBLDg61W574NW91wxPSz0uYaYvLiYqRnMe6KHutVtiMmlvBZHV6OxzAxFg2Am2vTAUwgMQSPqHSN0D980500RlW6YtpH8z2MPA7yYrlDcyqtver1Nw4xQ+bFW9PlG6LRsUcU1lCCSPE9uyLU8soitjnlvq5HY1gvA/611etouKN5rLzfFX6QO/BptQ/dmbHVjP5q11Rw6Z60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I97mhFhrYNLFMiTu023R1TimrRf6x5LUajm9a84cNk=;
 b=kxT+3aTkf5aG6KlKvXl/9UTJBta/42yE6VlotMkLyexyivwhp04oyUrbR6wja6SXuoo0+4LOFS6it5D1qvgCFwSYHAAUZsnfdDfKwhWuOEAVyOjmqnLrLKsNa+8DxOPBEXgRGgKMph5TManS9OllkeR0Fkbv6uaIVEQj3y4ed83eDZwcRkTv1lmJcCChT58REnIKvEfe2NHABD9lq4/cdfvt9TctmqMb7WAkXPM2Q8Vmc3aimv8Sf5euk1orTN8BwbdoFSuW3eCpdz0tbWzJSgF1gjKt5WcLtWfD0Mr9R36uRKRzU+ehe80UC/Lwch+eH50LcQL+of1wx3pulRq1zw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 19:41:46 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8857.036; Tue, 8 Jul 2025
 19:41:45 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <olteanv@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Thread-Topic: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Thread-Index: AQHb77bM67Dkv0j6akiDuvLgerj6T7QoSAkAgABY8BA=
Date: Tue, 8 Jul 2025 19:41:45 +0000
Message-ID:
 <DM3PR11MB8736EEBC7BC57DA69DA56218EC4EA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
 <20250708031648.6703-7-Tristram.Ha@microchip.com>
 <1c688ae1-5625-4598-a162-302e38dbe50e@lunn.ch>
In-Reply-To: <1c688ae1-5625-4598-a162-302e38dbe50e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: ccac8d01-3840-451e-5bb6-08ddbe577908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5Yk0FtC/B+2bqyb688Y+vHg9UHTZwFBcB+YU76smm4c+2x0UZ9rcoSU5oz7H?=
 =?us-ascii?Q?ufKN05jPZH8NAGbrfL5BhyD1alWtLNghLuSos7oEzpExZl7QnHRemV//nXf+?=
 =?us-ascii?Q?9akpnqCxdOYm7igmHmzQVoVz54usBxAs/+qUDQ+qvF7VqSvM+q7pX1P2I/lR?=
 =?us-ascii?Q?5VMKTTqgFRzfmyP9PLZtfzKsQpV0UKwQdO20kOfDZRvUeL+dp93MTj6iIvl1?=
 =?us-ascii?Q?durobucd+6J1ODH+0D4ZkK66wre3dL/TQI9lThEHPzN65PF9186nSgo6XSr2?=
 =?us-ascii?Q?22zZVrApbOfdn22zPlv9rM2eh08HsX8v//oChqnEzAsoNtDOwinMmlwPwdDo?=
 =?us-ascii?Q?J764nwkuoO81Zc1MZms0BDW7TQKxGmkuUPQhayCpsHifoKUjs8r6W08XETiC?=
 =?us-ascii?Q?qXLZgwcSF8yGJpsF8uzh8yCjjWIOY0SJhSUFKlNo0Xem999+BEbgP0LONJPT?=
 =?us-ascii?Q?CF1ZzxvI7+JHSxXVBQs33HOU4rctgyV4JB0Lr0/rQ7WGOoNOJhNKyxFcp1AS?=
 =?us-ascii?Q?qH/0icgs1sp18Q9i91Uonn47yqq6RHWkin8dVuJH6h7D6A6VObEtM3bdMY8a?=
 =?us-ascii?Q?9vg6MtG+Y26mq99y4++moltXA3C2ISOORl7L3oTReLrrn6RSHsoy4XfvQvxy?=
 =?us-ascii?Q?hlpNBCzGHxPdHEKD3UUtxLTTbshTKJSGL3ifDaZevT9b2nk0oJeeIpddOBs5?=
 =?us-ascii?Q?koKzL5T/uvoM6vfW4mkb8mTQ1pi56w08Wq+z8gkHac+pceCDhWPEECBmSHcX?=
 =?us-ascii?Q?1MT+t58wrYb76u4F9kvKuCw09cpl4NkYiIPpR+5IiohzAyCyYyGdc6F+udwT?=
 =?us-ascii?Q?dWU4m5x3bp69RK9UeQTWKbyh8xXoxhF7fj6sdfDKm1cJjGWNnQbVnGb643xd?=
 =?us-ascii?Q?aBTMe/Cf9k6N2AgLbEBFNX+Szk6ADTQE/iKhtGt53aU/bacBi+Nl0O10UbbP?=
 =?us-ascii?Q?Lklzh4j+ZNqBoQaxvH/ReMg1qownJdLN9Lpz/eZvDnlJ1eJo8PDP5Zhtfzyz?=
 =?us-ascii?Q?VksXksVZGBNsyZauvR14Iz6ZX7G1kWg2VpJ0GUFre2E89ar1fAbmyS5ZA49Q?=
 =?us-ascii?Q?3B78iPZSfc1uGPwsKo+0dksc5fZbRAh0QklK3kQWoMV6vQ/4ukKPw2KNqC9x?=
 =?us-ascii?Q?97YgxKtYzbxTTlqv+NdqwOL/+2bV3hnWpRI2rb1SaDWOkehXE5ykgmj6sjbJ?=
 =?us-ascii?Q?ENx2/9oJdSBp/9TieKh2usN6G47KEIXtExmTrpjI1nDC98WZCTUVZRa21MhJ?=
 =?us-ascii?Q?Q71duk55fKvSbCpFNZ/yk0ZZdBQbWCiWNIaSmFEqo9aghrWy8iGd1R1ixeNv?=
 =?us-ascii?Q?FegO57ETMsAuoJ5pHX2B/kAiHtDi819yyLrZJQwAOX9dWPc+fisqQDHnlWk2?=
 =?us-ascii?Q?1zxJxlCoHN7fZ5KuR7E+54tNdnXJB4oQPYNAeJYpHuVVohGVnYfcRBxExBm3?=
 =?us-ascii?Q?FvSaix2hATnyHnhFyC7hHL+NCY70W2x/4UR0KdEhTAWQ2hJCQtF4CQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Btpt+mSbxjdtRhPgHPHlPFZl2VvAqaqZ4GGf4f2JMPVqwV8bjjdAbu1e84ig?=
 =?us-ascii?Q?A+pq3N2LDNDZDNwXaz67OS4YEdjs40fK+EVwhq7vQlJhtMF5L4pYMyQwpmsm?=
 =?us-ascii?Q?NL+9YdxK4BdHp68FwQWzdTtzoe1P/KKdK174xNS5jjIslSoq2+yOIueG/ODt?=
 =?us-ascii?Q?0oYqU2sve62P39ywax5F9Zj/w2Q1b92kuI6x5ksXT2sgFRnZ/ki456l+XtkK?=
 =?us-ascii?Q?qxHI2UccutF2uQR7XyWdcf3DPbSbIm8G+rIIj4nrziMJ8WC1o34flEoPIMnY?=
 =?us-ascii?Q?2Ah5DE18zdP7frezILRLeHd8+qkNBYrpHJvnXvVME0y161YF0OZGpd98TjDS?=
 =?us-ascii?Q?0zfRzxS90ECk8U3Zb71ku9U4WDGFhVpNgbtSUrRyoUlKpyCt9qzQ8NxuW1TA?=
 =?us-ascii?Q?o40NEOEfVtHICqmcxzXzj4uO7CFId2zqLXBCUgrgeCVGZ+tKR02NWFJDg9OA?=
 =?us-ascii?Q?+MxYFik7NXku6t7APCFh46ynw1nM+XNzWypzE7PfGY4exy/8gRk/9Jha4KMw?=
 =?us-ascii?Q?6ArTP/rw4PIA8vUOAIIuCTppcA2T63F/DK7lY57Edl4YBM3EQqEAbeB2SVIg?=
 =?us-ascii?Q?DmReHelgA7qohnUHYtMXqRMlTBZO2iklRU/8ZqUrBk5POZbMIypZAyDrSG3P?=
 =?us-ascii?Q?PMu8aeey8e2IRYulvv8OpFtmgD5sTg0/25OB2d1RZWYmhjwxvm5t2/x+zgyB?=
 =?us-ascii?Q?jlKNb27HFkKdRzc3/p7bab3LIuPVEOVZI3IAGd9St7b6ag1MNIq4kJnoj+HC?=
 =?us-ascii?Q?z1oc/JtrNo83AZmeEbcAqZ6MghuMapmVntXSD5s1Enn2+frSKsaCQYw9OoVk?=
 =?us-ascii?Q?23h0UE83tUZDluNh2VM2tmGRmwRwv4Cva0o5MOWGy6/2ZDfW8iuLUhz40vxd?=
 =?us-ascii?Q?gHSmXssax+AQhgoGQnxboh29qlYJ1A3lIHuxJ4rzlFqGC4idqFOGGzmu9+3S?=
 =?us-ascii?Q?Zf7UaYcd2Fu6VfHgykL9I0KN+bumNqV75XktMkIJY5/RKAweT5aNzBM/Ui+4?=
 =?us-ascii?Q?+Hr2RxeUigslktXe7E+18VJkFKsUCoDpvz4/c1JnXh83ArVT9tczs9k2Nvnq?=
 =?us-ascii?Q?gT9nNooGrWexG284nPVoRuNAfGn/lajjsU0ofiMBSFHwLRKWza4onbkdcdrF?=
 =?us-ascii?Q?MBUZkEtGqonmP7Z1WFZpzcG/g1nkIta5L6NZ9uum8pT0TTiiZrogPXNTxnbr?=
 =?us-ascii?Q?sn+sCLdxAgRHTLQ/obpzAYJuX8vCOOkT/kV4JCCL1Zb+CmESVVCoxtwKn08J?=
 =?us-ascii?Q?IYY8+Qr72bQl0ZKpCx5RTEhHZf93e2e7pxp0B5got3HuJabYW5wQZbOrS/Ya?=
 =?us-ascii?Q?ey9eJoaxcpXgvv2C+ugu9IffLtgm3JTR0YLdoVB5RHKazUz5pMdCrJpXCUiq?=
 =?us-ascii?Q?1DjceWPJxrPss/LD7QWRztoDdZNFyr7MhyWZ9sPd9oMmoqIviznapUswEUdZ?=
 =?us-ascii?Q?5VBfS8huMloxxQX/OrqBE2K24RrKEYBbjPF61VuwxuQNSZtWwlzFSqoZItjg?=
 =?us-ascii?Q?E/HOMZxhD9eb1zjmeYvYI9952G8IpfFcDv+C4IDq4ueynyNlaK75yhhQxiB2?=
 =?us-ascii?Q?lJryi12ajfNH/dIcMftrrNOyOSPMCEnYVkCyCtMf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccac8d01-3840-451e-5bb6-08ddbe577908
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 19:41:45.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQU1X2VlvTG+/ga2udzF9rtEka+WI0CUEpvTlMCvcuV9MKr3SAJwFgxyPTV+sNCstwK+ixelZzmZOYoS7QlK01wFcJLipO3Ab3kWk/QFJgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807

> > The fiber ports in KSZ8463 cannot be detected internally, so it require=
s
> > specifying that condition in the device tree.  Like the one used in
> > Micrel PHY the port link can only be read and there is no write to the
> > PHY.  The driver programs registers to operate fiber ports correctly.
> >
> > The PTP function of the switch is also turned off as it may interfere t=
he
> > normal operation of the MAC.
>=20
> Is this PTP problem anything to do with fibre?
>=20
> It seems like this should be a patch of its own, unless it does have
> something to do with fibre.

This is kind of the initial setup operation for KSZ8463.  I can break it
up into 2 patches.


