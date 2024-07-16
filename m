Return-Path: <netdev+bounces-111816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E1933251
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6251F24EBD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E262E1A0726;
	Tue, 16 Jul 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pr0O/UWV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5419E801;
	Tue, 16 Jul 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158865; cv=fail; b=iYpdgYBEmaf68dOA52q1LdcjNujGO+lxo9cn63W0+aRIJwFD6J1N2Y5qIda0vAauAbLQSsZsZTJynS+YZHssX1+/NZkW05YInuQFn1evH84mQcf8YN116yAOlNwQ4BOUZMpruy1h24Dzvh0FaYlZFYpnA1VxU/cCqF+asyg2YFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158865; c=relaxed/simple;
	bh=O5TQsVyGlso/C/7ZT0Dpi4CI4szEDnLV5fDwQS87e4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDgll6Jb0Bx0vbFPnllbEBseHww85/IMSn1eBL3R0brKRSUXPbnJIu72dgK+kPEf0LlRQkHzuHgQ03ohmxObQ0ZfgbcspnvYr+GGDQ9KN6Msmn7t0tis8sKRdRxeDT1k2t6qvS4Oms6eYfSDPbjonnZIo6MDgxfuNglsUV44DaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pr0O/UWV; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMKE2+vH6XjWW55Osh9mYsnU0qIMg6/AMMy+p1KNV5WNQ9m9PaEbD3ES5dwVakkcvXcmbL4wWvmqTWdDYO2vBqY4TI443QryxKNSfdfnfQntfvTVNLp3EHD9q0viYRGG2e3edfOevvA7FImjyNJf7u+M1h3zfWFjyQRF6wPjdojCvUzzWIjo9sDptZg7PzFeYF7wUNCHlp1PkBKr6RYgf9QK26Dd4MTRlbsJGRoKh0ta5hjEomBGnijjZDEWBzrJVp8P0Cyp5UpJis/hi1ROtwDHdBYIq7ABzlhx8NQxSTvdL1GJq+GHe7ZmVN+kt2S9CQnZ6RcndgwgJwgSLI6ndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DESRUWS4JFXULTbmQfk1aq2daEaKUIfVN7LkfBs/0JQ=;
 b=Ys4EopdNyDhG6TCLTB0Xdy6sLyJangCOACJOIteuRE1ewmdDtNUjkcw3Akp6T1NobNYTdEkJ0f2vrgaAn38HbQkPLMwXDJ514HXcsfmgaA6yukXkjmhU6ND/x/WItZkX8MoY2tS4UffxJrDaNFPnNaDagIrKwUKru38MRXpCpvXXSQRxn7XYezcCIJdA8YcI+9eOEtAvulc5IAG2l2fanf+yY1vxbVFsseYf7s5aZUQCNGUJ8gpFEJwKuk2IOhhxZk4jTs+WExkYAETfvdL8X3ZJ7IuHtcxVTR8cb5Hfd8QzTfsvBHm15H3NwgX8OU4G9JnBNoOy/J1dzd8k+brxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DESRUWS4JFXULTbmQfk1aq2daEaKUIfVN7LkfBs/0JQ=;
 b=Pr0O/UWVJtyH+xJ3WSPH1oyqoTqpaMagx9cqXu8hfy5RN2u47qZDWm/4Pd0i7HdWs5uTruO8o2Dmf86kvebfGDhaZEf+KinoIcp0pUkgPErSG44kDk+EkfITv3HCB9Qrs7qHngGyXyM/YHJGICi35C26TzoTW5ELX4xXj1pcRd4=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 19:40:58 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:40:57 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [LINUX PATCH] net: axienet: Fix axiethernet register description
Thread-Topic: [LINUX PATCH] net: axienet: Fix axiethernet register description
Thread-Index: AQHa1ScUem7dLrFOVUC5KiTo3PoE67H0vtkAgAUGLCA=
Date: Tue, 16 Jul 2024 19:40:57 +0000
Message-ID:
 <MN0PR12MB59535D1EFDEB3C2668CA2109B7A22@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240713131807.418723-1-suraj.gupta2@amd.com>
 <cbd29d03-c9bc-4714-b008-ceef9380c46c@lunn.ch>
In-Reply-To: <cbd29d03-c9bc-4714-b008-ceef9380c46c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH3PR12MB8901:EE_
x-ms-office365-filtering-correlation-id: b663d7e6-bc7b-47c4-a2f1-08dca5cf3700
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5GV+HCNcnpzg+U94+l2TO+15SQAY3i40GIxQKlBQT0CThcP90t35qESnlEpr?=
 =?us-ascii?Q?5DGG5ipvHhs27zarmT6FfK3Rk8raXcbvW260XAdBcLeUp56PrZH7IiIYs65U?=
 =?us-ascii?Q?iyLmFYlwlmByg8ANKuzTx+vPXlpqhB+qKeG4lbqPgxeZAbrdM+Mmcl87fIIP?=
 =?us-ascii?Q?YpitebG8EYshaHgVPzRSs21YlcPqJq+NarivYK5KhmeatMDN+wszKZg8clXJ?=
 =?us-ascii?Q?uYD9eaE73nFRa6mYyWb+kG+e7W7vFj7PxAG90S4QB0nuLXH0jiLnip8bSTmf?=
 =?us-ascii?Q?CWO9TnWgC9XW0cyTXRv0sDn+/IpS1swoJyURGBqd8SOeDM/vHRhW4Sqxow2p?=
 =?us-ascii?Q?spRFC7JWKFsnj2i432YmQkVIR4v8d1zI4fVjAG14Z8BGXrbL8AdEjImGVfL6?=
 =?us-ascii?Q?Rezxm9hn0DJf6nHWfE330PEDVuFnoGhYBjK2zAmYMkRRGDTOTV/R7o6NKaKz?=
 =?us-ascii?Q?iD9Slr2sgf5nzf82I4oqlukKOc4lC2qkyoOhyKxa00j+9oiaP/j3Y643t6RQ?=
 =?us-ascii?Q?8j/qFbHWutzwLuZM4Z4bkJROTjUGsPLJTmrZE6SWQhZPhli3cx+OSaBN+6LV?=
 =?us-ascii?Q?UbMAtoq/TDfFwtaZl4timnDGWmquv00x4qfIhex+/Z6C4gNluN0Kd8utaq5D?=
 =?us-ascii?Q?m6EO3HFWuIsESgq2C3hhphYJROHy8089UVDmphlL+/wLuKSypq2B/vqC2Lls?=
 =?us-ascii?Q?u3J4NG70sxCnzMcFDXK3Xb96CwuOXwMVeCbMEKSJDVuOi6Fk6OyzZYRZ4mtJ?=
 =?us-ascii?Q?3SqbS5/Vs2yIU5CirAkaqX3iof2H/EkZJgQlvkr3VG8G6xI8G6HCgUNjJCrh?=
 =?us-ascii?Q?c+5AzQgiydQMde0a4JRUHTg0SQ/IFa7gUOeU6MXAFAELsnl+mbJvTB/tOOBK?=
 =?us-ascii?Q?erT+feh5X7b74kcjUW7/uPcbodf6BqSqHtf7H0BLCR2ozh2XQQNffijy4xGa?=
 =?us-ascii?Q?oeZgDTfQRKkYYrPGED5S/tFsVxKQ+zn5ScFAzm3mX4EF1KrDM9cHJfOJkZMo?=
 =?us-ascii?Q?wZAe0Cd9/QU6njSxamLGL4InuN1d2dXn8lWn7CGDavnrPZj2ek7Mlyg+MxFi?=
 =?us-ascii?Q?ujTFJua7MWB38VxQDJ4GHyFH30WHFOgKZaO3SXokthmApcOnBuW9J5YpgndF?=
 =?us-ascii?Q?/GgUlwsDTmhpdeLqcVB+rV2x2w9O98VP8qGKI4s7xQxrsXJXkHSdC0JFlXBa?=
 =?us-ascii?Q?l7XoNZeiv1UFA9U75wr0f2Cv6k55Ew7xEjVZMvIJDy2Ju4wG7ctW8D5utsGK?=
 =?us-ascii?Q?zU3t4qna7B8Y4kHzmBewzVD4AtIeeRwJqQb5yU8gkrZktMgV8/LiTKGPl80t?=
 =?us-ascii?Q?gVenD1eKJ32qGt+xgzLn6v2hbMZSQOWlLGzRvioscGDwIgB3+RNJnETBoTCQ?=
 =?us-ascii?Q?D1L7WsFbChU8WqtdWU42PbRdoHGYR8fj4/BMfiQC7QR3xycPGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GoAeGeYy+cH6LCNpEFFxC/b+ipibmeUFZ445X8pMDFEwzA2oH9RgrEzafoy6?=
 =?us-ascii?Q?entOrin3u2jn7bUtBh/wVbqHZ1oBYaBQCGPAL5gaSjce2U+P45JNnCG2e2T+?=
 =?us-ascii?Q?YcIrBcJBYaJCW4vg80muqWcnGv1IM6L34NfeCRz7uvXVIXdldjw1B6xitP2z?=
 =?us-ascii?Q?kWaqWqq4jbZIoMpHvSxUIuLkBaE2nqbKRgqzkXw5/vJw2Bl5Vd7exK+/WiZ8?=
 =?us-ascii?Q?LXlES9XJz6M4F0CJaKirbncKW2BcwZmm2DAFxM7ffQYCH7JVgmfguhTTkDax?=
 =?us-ascii?Q?nMSQ8DQXHNkRLz9TRuZcXv/1HOZjUtVUz7xidg/BNqxGN2mK4PY5bY8hi4xI?=
 =?us-ascii?Q?iBB/obX1jfi2ML5virab0HchqKiTZTouVl7vNjZNtwnNRChUKockKKD6URfY?=
 =?us-ascii?Q?MuBPRRmKh8DEIf0lJV6C7hJOXD1nAXjWz5wNp6GGf+CbqmgdGgXk8rMu7iZK?=
 =?us-ascii?Q?wEk6QoQofS1rRhpD23SRmfvKzPOansSuCwJDky7yZBW1SxL1qxaVy22LQ8hs?=
 =?us-ascii?Q?8d5OSDvYsE48ynu18kK6yPosBx48bLPocPADgvapCB2Lhdq9tI08ys51qJNN?=
 =?us-ascii?Q?dB1v/yb+dybhhM1JN2X7QOxSrDPtyWFwMOLdPSqbhEQ41nQ3JH6WL9NEMXs4?=
 =?us-ascii?Q?2AdBOxAxVqXFYfc98N0Uhf7VvjVJasPmG8zVGqS1t8TUf5ZtWf/NBEceWpw9?=
 =?us-ascii?Q?6aOfn2POC9rMPRyCTHYR9SIxYLDllS3GS1EK7cpj5JIzEqWYAfRRZitICzLO?=
 =?us-ascii?Q?vK6j3p5t1NWxgxyGJ2aujK1OrBmQaZoVT+XafgFiHEs+fKE1SLQ9rCpAe8tR?=
 =?us-ascii?Q?HJsknMxfoqOoRQenHXhsZKnNt9ijr4UnruQn1rEBDyR2o/+M/w/Kz91MKph0?=
 =?us-ascii?Q?jMxZG1Rb+6erM0P++Nu2It7Nelr1uvlCJECqzha31n3scEwdM6UcfaQxv7YY?=
 =?us-ascii?Q?pk+qOKo3C1M16++jGNIgD4V0C6RquLkcSeW6MDzny3B0yqMHoOBMlvf6gmdZ?=
 =?us-ascii?Q?+eiMn9zkaG6/CBXEmpUYPpMkHkAeEKSGC9UmlLgiE1uot9wd3vBndb3YtPeC?=
 =?us-ascii?Q?JIpOV8K1b+eJI8kyo6Un5VXfSp7vK3g47ua/1tZzMhJdfjAYtlrSZfyT0GTg?=
 =?us-ascii?Q?r3J6Bw1GKDcMJcSqco7N+jTGibnOh3eGTUwyOC1sbKbj4p/XUeYQG+g3gF7H?=
 =?us-ascii?Q?pvL5x5z6gd+rTEc0e+aPJUDc1GLogJrBlohIu11iNGcx1f6tEisF71WeTog5?=
 =?us-ascii?Q?OFa9H25BtIOwYIKpUubAUY5dPVnmeAvjMReys4XkBKrWzTLeUb8gtXAeo17F?=
 =?us-ascii?Q?yg4Op9j/0Jxu4MRcfPHe6nKYC0IpQtxG/CVDN6OTNtv1fHHie8HLGJqQTIU9?=
 =?us-ascii?Q?5a78lAAg1+DNTHs5UYy4hyQoL8bnsTTauAxxCohIYjKFhnf8pFuSLNgNpel7?=
 =?us-ascii?Q?coROyVZltw+4ubdElP7ZMTw8q8yiGvDBbuWBC9uLGq7aKNE4xIcVJfkTHWz9?=
 =?us-ascii?Q?v/kqPuFaf/HqZXzr6K1IJ1cfXYvfwDqeK/Dhx4Tq+BEgx4WPNHHwf/vlRRRb?=
 =?us-ascii?Q?iVAaHYM86H8N0wvqAvM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b663d7e6-bc7b-47c4-a2f1-08dca5cf3700
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 19:40:57.9349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LSvPj6o3J0vGJqRNrDkGqemVtEYXz9XeupnkpjGCR2EfAjU8FzhRzJ+ZrjVqirH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, July 13, 2024 8:25 PM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: Re: [LINUX PATCH] net: axienet: Fix axiethernet register descrip=
tion
>=20
> On Sat, Jul 13, 2024 at 06:48:07PM +0530, Suraj Gupta wrote:
> > Rename axiethernet register description to be inline with product guide
> > register names. It also removes obsolete registers and bitmasks. There =
is
> > no functional impact since the modified offsets are only renamed.
> >
> > Rename XAE_PHYC_OFFSET->XAE_RMFC_OFFSET (Only used in ethtool
> get_regs)
> > XAE_MDIO_* : update documentation comment.
> > Remove unused Bit masks for Axi Ethernet PHYC register.
> > Remove bit masks for MDIO interface MIS, MIP, MIE, MIC registers.
> > Rename XAE_FMI -> XAE_FMC.
>=20
> Might be too way out there, but why not modify the documentation to
> fit Linux? This driver is likely to get bug fixes, and renames like

The problem is documentation is common for other software stacks as well
like baremetal/RTOS.

Considering this i feel better to correct the names and align with IP regis=
ter=20
description else someone reading code may think this reg is related to=20
some other configurations.

Example: XAE_PHYC_OFFSET is corrected/renamed to XAE_RMFC_OFFSET.
RX Max Frame Configuration 0x00000414 R/W
XAE_RMFC_OFFSET is only used in ethtool get_regs.=20

Other changes are removing unused bits masks (Remove unused Bit masks for=20
Axi Ethernet PHYC register,  Remove bit masks for MDIO interface MIS, MIP,=
=20
MIE, MIC registers) so should be fine to remove the dead code.

Thanks.
> this make it harder to backport those fixes. Documentation on the
> other hand just tends to get erratas, either in a separate document,
> or appended to the beginning/end. There is no applying patches to
> documentation.
>=20
> 	Andrew

