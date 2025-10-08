Return-Path: <netdev+bounces-228205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD39BC48E1
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 13:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 248784F11C0
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7D2F746D;
	Wed,  8 Oct 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2oT6Y34"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BF2F549C
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922786; cv=fail; b=Cu0g8Uj/GZH+0rMPupEs+TRgBdMnGQED+cqUf3WJWVodwgvSm9Xmeh8QW2h8LNGTRQuHZCHuuZrdCDJpj9GJIXVyEeZ+sCOqCsGv+351eCplh62OkuFR8aqzZgTxaEEjQ3ONZuIyU6YCKfSTuFcrbxGI386kbxOWrM2G/eJDGco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922786; c=relaxed/simple;
	bh=6nc6CoNrqIHm0wRE0d0VssL/eeRya6fi2NWQsNO3mKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aI9HUdIyC2LiKGtsR3d71oaYg312SMF9QaNARYbWKjhHDDMEfzdI9A5g4mBPkjk8gOXFnBRyiKFqN2ykn7bIhCdLlKpnOZPhjyJXFqzcf7hi9SSG/rvAfxVgRJij+9HAzpTUistBMPNuGDKNh6CPrigwKMtS20zABuSXn8+rx0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R2oT6Y34; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+dLXyFuExeJMFbq3Vl3uKwasNOiIuWawrsCQ/TXZKLr9HwP6OVz7jHkHoVViftYh+sPrLGcIeGbUyghOV9s/gjOzJhsQlDPKGu2f/LmXPw+Fliop1YME0y2tUP5pLAitz/tKlwvevqVbQNzCG4VXMuzSpl7aHJq7kBC/3jmNI9Yku29UbQfeGNbTFLc4sZvVgK3J/wotOHsvpOgy4DsVuZBV02zgo5AIok3Z9zgo9ujCCE20TyIL5TjFIaCBZjTMAdZLzvJpWXpd4c4F39U+s1RQVHXDgr9sBQB1Lyjf3pMkh4Of8kE97sVpvUY8Yuvm0Lf1rXU0DN2YPcHdlgSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nc6CoNrqIHm0wRE0d0VssL/eeRya6fi2NWQsNO3mKE=;
 b=n/jUYbj0Awg6E2sQr052VTeFOMRGkiAEtmJXMnJ0LDkhB1cF9agi8S3KuEwugHGo/NnmbwEw+JoIsMi6QqpkWliF0CarFI5XOHGklUxIQ3Fv+kAQKNkmwgMzleyaL8Htz8vQ/9iZYmV1enkIcPMY4HL6ECgjr1fUR92TeyIYWs3p5bzXICs85x17jevylQIMAA7c34fZvmSFRibCrZUJnJJ2J0DYlj0Vc/USksfKPH3l9aOA2T7sKtAeEUU5UnmiVt2/W6eZi17lFJHbySuLVXpqG7m1h7mD56CliK4/8NysbVWn4O2vWkk9jHSuVh5IicCeAH8XYKI2MW/5ntUU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nc6CoNrqIHm0wRE0d0VssL/eeRya6fi2NWQsNO3mKE=;
 b=R2oT6Y34Tw6GJyFe/ayv2eZazgXIp3HlgiUYg6X/y7+Jupm1PZygVwBQhe8gxqwLXFr2saFZCRiZT6CDft8jbrzwm0EmuRDfpxnidL3+zqHhZJQSZNDyn+m9RBIf02DCyLiZ8spgwvJEz44+2r1y7IMoaoozOFAH8ybuj4ViSbyz0n5luVICQsmGUAtIyp6x45TWkOkpp/F/k6PQSFvIafUXeD3DQvBBPeynjXetTzFN+XW5fJoLfksZ/0y6WtmjsXANtD5jYlM1JqeaRB0LdSLHthMmtekOqVz/Q9PZtTxiXU0PAHJSIcxlADYcALSzD8RyJh6l59/d4seFGNqyFg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 11:26:17 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 11:26:17 +0000
From: Parav Pandit <parav@nvidia.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jerinj@marvell.com" <jerinj@marvell.com>, "ndabilpuram@marvell.com"
	<ndabilpuram@marvell.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"schalla@marvell.com" <schalla@marvell.com>
Subject: RE: [PATCH v2 net-next  0/3]  virtio_net: Implement
 VIRTIO_NET_F_OUT_NET_HEADER from virtio spec 1.4
Thread-Topic: [PATCH v2 net-next  0/3]  virtio_net: Implement
 VIRTIO_NET_F_OUT_NET_HEADER from virtio spec 1.4
Thread-Index: AQHcOELAoUKqZadrIkuzzEQnAVSDLLS4G9xQ
Date: Wed, 8 Oct 2025 11:26:17 +0000
Message-ID:
 <CY8PR12MB71952DFF0D99EF78B8C69886DCE1A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251008110004.2933101-1-kshankar@marvell.com>
In-Reply-To: <20251008110004.2933101-1-kshankar@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB9255:EE_
x-ms-office365-filtering-correlation-id: 6970e1fe-7cbc-429a-fc01-08de065d7f9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XEwVKMhZORGLWfYPnuYl3FE02aChxe7IqKC3x/Sw4hFZ2zoI4WAa6rEvFYPL?=
 =?us-ascii?Q?ayxnjbQwIvhyWnxQWq08bMIr5fBtsDk2sgecG3qI4D179DaRepakl8oS/A+1?=
 =?us-ascii?Q?ORAtKv7njFxpdG9g2xhac+/7PDhSx5p1B8bsSpH9gfPud5eT2ekQtCsthpC9?=
 =?us-ascii?Q?BvWKeJ1umHHaqOC7XyznEzH526weiYSa4Vd5ZmprHN8E+QLX/AO3JATdwI3c?=
 =?us-ascii?Q?pMAW9QUW0d3B5ylJkK3sfTTGXAtGXYu73H9A6jztoaLBLwL4TX8+ZkTXHPTE?=
 =?us-ascii?Q?n9EdHtx8re2fb3CcMnExqQK20b42mYS8zqvHkSNxsZv0Vbb9ujVmycw7Nkz6?=
 =?us-ascii?Q?lNwGoO8brw17yJFSeZ2oSHFKy3Ae4jv0VQbRMvO7UUNPqKSBSZ6Uhlk5VKq8?=
 =?us-ascii?Q?OYVyqJlCZCuGkP3brp31/YTEAuIARmtSFGETLyavKUvxF+2dAhoDwV3K4Jja?=
 =?us-ascii?Q?a00SZKpeOIHuX4lgn2/R1WYKylRPHUriNRto4GYh1XQcdpOOEGVWO35Za+CQ?=
 =?us-ascii?Q?IfzYZEXAzsR/iRvwtRfX72lirjv5tM6UUgC4RlP6WDZ3KHKtFdvCHmE2CUYZ?=
 =?us-ascii?Q?CSXd/yIjhZvcN5+vNd7UEQS82CNttlk3ECeLFXY33WrTqR+bfRfTPk1mqSzD?=
 =?us-ascii?Q?zsBHZIuFITiiuqWvqxidOualIV/92I5EAlrHOQjvUvRxXsnZfxkbhBnVlBtL?=
 =?us-ascii?Q?rETFazcLuFUtk9kpSvzdQz2aZiGphCBGRFpLD4e6GH8ffkDiopC9TsIA26zN?=
 =?us-ascii?Q?+g+GYZNMg143z1xD9lAkKo3WMuJxmH2qUpkn3YIxgKMBNl+Zyv7BbNj+e4gn?=
 =?us-ascii?Q?ydWwDOvVAgIFst8GTf1xstc/+siBhOIoVtjScnzz96MUz1jcVc/CZzt9LMhx?=
 =?us-ascii?Q?HIpd9DfBD+QISWrRQR7fO1rUiB9lH7zyV52k4g16PEllMhoT6iA7ITGyho99?=
 =?us-ascii?Q?9sDoIsvhLZGhCvKnetysLA5iOs3mO5jVpXIPso+8ZygireTcpuF4XFFo6Mk8?=
 =?us-ascii?Q?zFCQMKmvNixXL3JJy64AHzCYCT+l9VL1/HBClI7VCpJ7QxuSLCtzZVIl+HFB?=
 =?us-ascii?Q?T10O3kR/A9/HPooo8Wq6bBXyhYvsgsvv06pqpmURL9KSvBaVI5rD8nxzynbF?=
 =?us-ascii?Q?fLc8CdSXiNvqREoKgz62k/2+Iqw6bznsGDahUa0guJ7a1EVXPg4sd2squIL4?=
 =?us-ascii?Q?vQA8GAKUlnHYQ28/Cpp/6JBnXBFjvSqbHEcp2ckCvsQVfyzELX620DNWvYJu?=
 =?us-ascii?Q?j/pc/qol/23HOAVaAddhx0XE+IvoEOqw4LWHwvoovBh69iAobDX0iQtMAyCx?=
 =?us-ascii?Q?xAuSp0iZILsGAeojbm+IrrguQND+Hgi16Jmwv9fSmEkW6t4m+D4XOd+1Bn6v?=
 =?us-ascii?Q?IjQF/S4+9LiEWmC6n3LgbaNcW3MNUJBad/5MNLbEULy0RmGijhKpDyQj0DEk?=
 =?us-ascii?Q?C/MqBUBl0AOBq40ivjK0tSBuiFUcUSrN4Cxt6fgvQnl53ApQyvyopV/Z+DdS?=
 =?us-ascii?Q?3S8UwJ8wnWpDhYZQOmh0F846G1W1sm2g7cjZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BF8jEjIL2U+2t9cXhdwoL4uftj9OVDHtFCAg1VMxliZwMvQZOxpOdG4l4xmI?=
 =?us-ascii?Q?JYF4TTFOCOxrc7mKOJbdQYO6hhAMxL0DSAdTp/Uj2/5+q4MdTdWyQYrBSx8y?=
 =?us-ascii?Q?6i6EmtvZR7xqg+Cup/61orLDdPa+b+YzDaxDOSWh7zRUYjsoKkwb7WaixT1/?=
 =?us-ascii?Q?JfSwfm9OZ37utCLYsDf5zzPXEeYcJXhajCOfQBkQtJEpYxb3ZSyWqBlZ/Hed?=
 =?us-ascii?Q?sGDJRvkLapUZZYUarnhMpFTdCu7wjqKmyqqBfgiVP0koPN/s8LUO6KEQgrh1?=
 =?us-ascii?Q?SScYvqSfoL/XnsEI5f6tRki5x0Hh72Rfpg1yuLVNfGQ9PS2g7jW01uDusFf2?=
 =?us-ascii?Q?bpFA8M0RrJ8u5Uy8uuFktn0OYKNTrbuzEHWabR5kah1S6fN2yqybbWY+YznR?=
 =?us-ascii?Q?SSGq95mxbxOboX+qEK3Y3dmb0s1gkcMS6k36iLW4e2LjDgdU1PWcokSIKWbZ?=
 =?us-ascii?Q?Rs7/25zpB4EcenFVGigNb9MPwPqUAZJFCWhluLTKbRFvSdRiFoAxR1+SDNbu?=
 =?us-ascii?Q?SrwFtr/KzdFv2j4o/K55tuGZKZxQ3yJIXZ1gOdN1B3Q6IoRyRi+jnuv3f7yM?=
 =?us-ascii?Q?AMDHkruJHF8n7mp8FCpOU20gvY1SW4iPAPMzb4TwztD6P+w6xXEuXYdy50aw?=
 =?us-ascii?Q?JLz2oIw+uUHa8YCSPPbbR4k1NaLtbocee9/AtBZGta1OCqCF+FWpUD7c/gpk?=
 =?us-ascii?Q?7hx9FAwptjD7ETC/6aVQcDLQrlFuxe8TMOeF80uG8dGzDQGhoWDyy7Ogt9Ab?=
 =?us-ascii?Q?Z25tPFwCNyJOO3K4WNRRJ1AQqpvP7/8TYA5NPv7JAY+0Mdz+OZfgi6cc50WJ?=
 =?us-ascii?Q?XZDJLTA3xWWOXGa71DMM8/JFywrcsI5dDEGZmRcZoMf1Y/G7W7+UyEBu9c7o?=
 =?us-ascii?Q?T3/4qvkEhiVrBdVRWoipRWktHij9aOI+m3RZJjCpbV3+bq2Duxp4Izg4OeUr?=
 =?us-ascii?Q?IJXLQU/8qofMs1luP18v+1siGq52n6Dr1A2mM6lg30J337BjklPogNEFrEbX?=
 =?us-ascii?Q?AhQ70LNlEUQAq1qjuuFbFvqAEYahEH64bHd6MxFTCUOYW1YVOtdv4/qtn/Qp?=
 =?us-ascii?Q?vILPO1LmQbNnSAi1/76f4gx8Wjs0dHPEVDySxrfyT/nnTesS4kzQMi3UPA5t?=
 =?us-ascii?Q?7SMvDdH1XjWP1Yh0F8Sz1u6v9APy8Eb/CedUXqlmcIys31iZ+K5pWyQolcW4?=
 =?us-ascii?Q?H60VJaCGdLSbZaHeTJovyDh6BjQBwZjpWOgCP8E/JBnS5dPKB2cRGME0fWKk?=
 =?us-ascii?Q?AwrPb3ulX3tA+dglvalA3UNahzPdRVKDqADRdCj5nPbnfrSLhCqGeHvyhY3e?=
 =?us-ascii?Q?cw3OxOs4bysMB8FO1eBP4HD7nbqCrFK2WuYsL2Knv1kuhq+Ts7N8PN7Eqy54?=
 =?us-ascii?Q?oq482e05K1/KJJI7ykjm6Ze6sgpnMBiGvWdk/yl2kqy8F/DPqypj3af14uLL?=
 =?us-ascii?Q?QJZNXlv0LrfCxHhqHBsdBLhq2wwiDScEi+t1vuee6lIBYt+W0KjlzRwa9IjC?=
 =?us-ascii?Q?h/eZfn0PJxebxWlXmSSaj5Iw3r4sOqxPY4Qq4J67dwoDqXGGA0OrDCKw/BnR?=
 =?us-ascii?Q?OEpGmCK3jnreioIzfxNXBXtd8rRJ3XyJrs2i+LpBoOtFBF7l521arOAnJ4Rh?=
 =?us-ascii?Q?lcongfDjkP2HfG8NnUwv4Glzrq3xznmFAVRelfTvoHr6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6970e1fe-7cbc-429a-fc01-08de065d7f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 11:26:17.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ko2rJSwfOKkw0hXykwYwoj++EQmBQnxw4EUn7P8JUpMP439QeJJnzHcqj0MaKE7XFM4wxGpvKM3LffTOXk2Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255



> From: Kommula Shiva Shankar <kshankar@marvell.com>
> Sent: 08 October 2025 04:30 PM
> To: netdev@vger.kernel.org; mst@redhat.com;=20

Net-next is closed for submissions.
Expected to open on 13th Oct as listed at [1].
Please repost the net-next patches after that.
https://patchwork.hopto.org/net-next.html

