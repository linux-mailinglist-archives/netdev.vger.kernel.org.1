Return-Path: <netdev+bounces-114623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415D9433A1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670AC1C22472
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D01B1500;
	Wed, 31 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ma6/qjhs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611501AB52E;
	Wed, 31 Jul 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440842; cv=fail; b=jNSYXatgF2vB8/on1GCHe53NX7z0qkGkE1WFFWVtaFQdHjCRgXiva4XbOxQNKP12dvofJzniI2L9DVT/kDMWs20WPw4UMi/6IKxToI/SzyjFQLf1mETFRzque4W0iDryiE7AsSn0Sk4E7oiD8RbBfup1dPbb9lfbxKVe55mJyws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440842; c=relaxed/simple;
	bh=leMkWV8C99dpFggX/H1ZRVvhLyqsQm1on3MI3VlPkh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/SxFqlAGgy7SR1Ebkpq8Xz4mdAYpeAvfNhRO3o/xci/Ql6g9dzQeB9PAQlKsklbVEKLlnc7YsozNI/f79MGhBfsZt1kalbzGfyrgONZ4K/b+J8IlDfUPxh/oOq3FAHQJAe9W4BJj+/Dul3qbJU+tWyc5aZ116nlEljMgsGXl5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ma6/qjhs; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/Gh+kQ/9/r69Xza8lCKm1z3FYBZ3symy3HA/h1ef/FqIIC2J57Q13RQJDzh9sNnVdQXsIGMwos3dTv108EuVIvFFF8pNBNFeZOKf4n/DG69Zbw8avD22ylTSIk5+hGnj97DH6n9JuZ0SPTI4XwdN2BQeHrspKxFt440KSqkxVzI28FyBFHn+gwo2bqkyhwNSlSxnC+0z+Fgodn9JH7T/0ecpgHeL/IAhEVa8zC44CUtxn8bjUzbTcSgGhE5KveAqZlR0SK2SuqSs3lk/fqJiIvou0xi0ZxIVeqpEPGVop2OZZm+bwiNQ3BOz/PAdNZreSUQMbDjwoB8BZ008rPjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hidgHfzOagfkMWU7p9qQd/09W8sBJSpH0RBO2wg6YSA=;
 b=MUTqY0LcoGd98Ol8BiRF5Xe9FMy/GVjGg5DbXrj3lZLaek2COV8kN0m/x56XwVyGAtFIqnw8NwHYQv1cgB0wmDFbXIfQQgVB/vTXqJaya2NOTtrRSvyKyLSHiNRQwiu0GYTTSU+iQMGSfe1PDsXYldKf0wxfiWNVCpTTW6nldXWJ6ay17s6ZS6HhOXjudW3Ft0ipDEkpkglaxk0Na+BFv6wKmt8MNHc0cmMp0QWqV9jBrh/GBmOOmnAUtXXzRz8mxLM9nzweysfTBCw+SbzvjzfzhN+etTUsE8OTeyCrbS7Mlb7SSXdA+ErpgeOPbYIeJlsCXcaQ8qqI9xZwxISXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hidgHfzOagfkMWU7p9qQd/09W8sBJSpH0RBO2wg6YSA=;
 b=ma6/qjhsyXSHD6VTow8uQg5tqEv3IzBzAXUllIS0mynPAOxS/sXYO/u2OnMQyXDJmWmf+Ks1J4Vr7YgfL88gnmOSmsPeolhfqvT0h6eqKLghta9SZjd1cpfWQ9bwtLnFAT+uD6JbpC+DyP15HnC6h5WTrGH2pyn+UHsW3hzgl1s=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 15:47:17 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 15:47:17 +0000
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
Thread-Index: AQHa1ScUem7dLrFOVUC5KiTo3PoE67H0vtkAgAUGLCCAF1F6IA==
Date: Wed, 31 Jul 2024 15:47:17 +0000
Message-ID:
 <MN0PR12MB5953F9C2550317D9DF17237DB7B12@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240713131807.418723-1-suraj.gupta2@amd.com>
 <cbd29d03-c9bc-4714-b008-ceef9380c46c@lunn.ch>
 <MN0PR12MB59535D1EFDEB3C2668CA2109B7A22@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To:
 <MN0PR12MB59535D1EFDEB3C2668CA2109B7A22@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|IA1PR12MB6188:EE_
x-ms-office365-filtering-correlation-id: e77544a4-29d0-468a-5e4f-08dcb1780e59
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IQ3W2Pk/qGnTa1JlwrHzu7Z8EuCX7ResHmZhH6zqi76ySchFFQN+sp2nb+u4?=
 =?us-ascii?Q?4U9YuovBDm79kLlO8NzBHNhh4Yk+LL0fzAcQHCZSQdUmaKN+bWjXRDG/EzD8?=
 =?us-ascii?Q?cLvjUmWlHni8JhnkAxA2aMlhlcEEmVWZLZPr0JdpStKa+9WXnM5be4JLioNg?=
 =?us-ascii?Q?/LKH33e/H0WvDbt8Y8LhW8F9D77yhtc+RvUzKrwM7XCbhSLlZ8z93fEKXh2R?=
 =?us-ascii?Q?ksF9BJCvZ1QiXM3dBfOsiGy0mn+7A/5hK31hrTlaA+dlGDw4ejSxDgOSlGPT?=
 =?us-ascii?Q?ViPHCmmXgPKljtzr4yAfP7iDmJKuIQ/VozjTwS9yn4tNT9b9gZBxyDk1Wb/J?=
 =?us-ascii?Q?LwcinM1+lRLTqXPBBKigD4KDhRrhvHKdRVDCaTTbxo+Dea2wGaU7qZxq2XSw?=
 =?us-ascii?Q?G9LwPUS6+Fc6JPjGbepeXSAGIxeJo44TVu3RDs3oJYNVijYe1siCzmxyiR26?=
 =?us-ascii?Q?3E8oHNqwM+3aKy3X0uF1eb3aDU1EIsKoblN/ESdc4moNeJfBmq+J6B87GpRR?=
 =?us-ascii?Q?4/fvedzbbqTfRSXmv+X6yEZslY+fFIzidjv0DdN94Y117lexcMmi8wBtVfCD?=
 =?us-ascii?Q?GcKGCc2EP7x6dtGqTwfGqeelfshkq7WvMZgE8X0LUW5xW9KEBuWFngq4Np5V?=
 =?us-ascii?Q?dnjqMI0QwS5uopj2jX+pW8Q9V4GjGou8Y+AipG2OrKGS1zumhh+eEIhXTskN?=
 =?us-ascii?Q?D5Fz8Wlp5QXQaCEgNi1P9LIvo2hm7nhgP63dpUJcNnhV9Q5AQ989r/ep7TjD?=
 =?us-ascii?Q?FtWjr7KDy8y42uyafuF2/EOuPZ0lQjyo7s6kBVrfcqLPf757ael0WZERzHco?=
 =?us-ascii?Q?gCydNFgKHUGCkjTw0N+EkFbk8lPSyqbN+UJDaFM/qEsGiufRfbRd76MKSVcM?=
 =?us-ascii?Q?ItR0YCNSuTOGx8dNZ9TT1sKshKFU58k3o6HsmHlq3a5YR+BSNHdh68bDvT6u?=
 =?us-ascii?Q?UphiEqburzNXT6N9lqmKzCoTqeL+SW23wop1TAVjR0iSZTffEpF/VaBxXfvV?=
 =?us-ascii?Q?y81ntA2s1FzXBXrnks4HHlCsZKWfiK7eDKyQSshaLiFtanmBPfx8zTvJ0x+y?=
 =?us-ascii?Q?frM7aFgDfw7FUMHrqEC0lJsmWv8o0tbpEhe9k8QW6tKtYCH87aYz0PSivmix?=
 =?us-ascii?Q?XGIxcDDrPa/iNJTUN+Zu5LIwuQw7L5cVScmazPzvx7/dwV2tNC1cVPacaQvj?=
 =?us-ascii?Q?R+gw4Lh6lVktW1bgggTkPGrO2XmQJR+Nxu+uDKwqp80qsi/5papVt2RPjKIl?=
 =?us-ascii?Q?x/rKjU/n1dvt2yLv95qzi+U8rBAYSOUW3meataxP5ROh0uP3+48O/ZZXjJOr?=
 =?us-ascii?Q?ZA0pQUxaew7B9dnFDWNHRm/vU0bvhkmsPyOmoSSI3bl2gy+TOaTHrQJcKOa7?=
 =?us-ascii?Q?NerYKyF86Cv/di3NgqiASffHr0Y8XQMASbNx5PXnx9Qg81+u2Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/nP0JTxRoRLjGOZLFQKb294NbQKpqJxkDDaXEBMWa8bQFB8o2sy4QjlebCF/?=
 =?us-ascii?Q?9WZbrJuvuhnrLQ47O67UxGbjeBOAzWddHZpD1wji9HjA+GTYi7sxjGbkkEUP?=
 =?us-ascii?Q?xgJAKlfrlMyIBbjynGsBD4skt5KJ3629NaZ0ycEvGf7SdI+kOejsQeOerzth?=
 =?us-ascii?Q?hVyQQjNxzl6iOKF01C9705Fufyqt/JU+wvcZouCeQiH6jixVStmdFdS5QvwU?=
 =?us-ascii?Q?px/XFs4mR+CsxmGTJkQnUYNNFcejZqzGeijkJ8ZswjYKxXCepenxT8CL3T04?=
 =?us-ascii?Q?tTaxQj1gj3tYvmXNDZZgTQLZr8im2kTDTmk1Eo7y24jxvC5LehQdyRHblhfu?=
 =?us-ascii?Q?xDvM9wf7eDVcgZSX3eSErHuPAd19LW3IE7nv2UxD+NriLMNTHyBDhxEK4no4?=
 =?us-ascii?Q?0H7RJPwKvn6rhy6nyn+Do7JEIsEGWOAXIWqql4flx6zg9XiyDepIlVG8V+5T?=
 =?us-ascii?Q?PfiOiiO2JyHE0KmEkQzL9qt8xv6kXSu2hrnnGURhgJXbbqZjJPnTHtFygm+E?=
 =?us-ascii?Q?DZNQIOkHxbRuNkOoQWazT4+wG+zwVeEW7pN67s4JmtMqX2wJvhrFv2tGCzpp?=
 =?us-ascii?Q?qzD0268Z4NfbBkHKHQ8xqxhIiM4aRh6UJgkleqZelvvLNw6b4U61oXu8zlFb?=
 =?us-ascii?Q?+lCLFHX/uUqxyYnZZSDnuKUxdzOxmI8H9XH89uWFcvIkLxh9rq3ysqUIw+wq?=
 =?us-ascii?Q?hR4QY+gKCIiROg2R519dOJUR4PSuQDwbq3C1d9cPbuzpnanSuLTy9y4V5Kd9?=
 =?us-ascii?Q?otnU7fJkiblKoXSNIyNK0qZyn/CRWxDMiIdQ5lwvCc5vytxHaR4DG1RLye87?=
 =?us-ascii?Q?caJTGgUSTxEtuU3kbBFe47uoMN1B00Jf3HDHWMCLfHz83G4U+CbkOv847iBf?=
 =?us-ascii?Q?Nx2aWV07p6r9grf5dlSi6fiJkWIo59AYLUgxrLHHgU11G2dNACUyADsEiCJR?=
 =?us-ascii?Q?KCdgOw4pwXj4yycimUziS4m5JO+PfB1UnCrGu9fw21N2Yzvfa1A3H7fxcGK2?=
 =?us-ascii?Q?AFny6QRQSyKrtbacHYLkx5DsIzI62rJipe7Afy5+2aB2ihWRuzLEdbVHjb/k?=
 =?us-ascii?Q?lKbSZGd9b+6XEHmKqZQEuGG/Y9OWHlT+SBGKeQdQetBSIgAc9JIu3/OYOLv1?=
 =?us-ascii?Q?eZVuUq0qnNAyDxR0UYrvMLSFLpT994X5tJJNXOdja+MX5oiUCZh1DYNbOu1h?=
 =?us-ascii?Q?4vcTy35DtmztP/zqK4rc+pcWpzS3HFd8gdBayEKOGyVE/i9QAAVeMJoeZHgb?=
 =?us-ascii?Q?i/ISEtFIdUbw2cppIc01loGdlDmFQm8XCvpLkgjslQKZ0gQnI4/6fa3ZCQkn?=
 =?us-ascii?Q?97/ZsFxw2zdRvZD6gpc38Ul5d3MFV1doOdtQwTw00CqUzotU6C1FKVMtntBj?=
 =?us-ascii?Q?jk3ujllyDkAwSiKkdWa+rt+94lQZEaqnnJ6iEL1910Q/Jj4fAOykom++l9GA?=
 =?us-ascii?Q?WP1O6gKN9rWoQ3U17H4lSEK7s8uQaYx0hZ2bEIfLJK9xGQTPRWrJeNYY4W97?=
 =?us-ascii?Q?V938lxdZi4wXavFSu7tTY0vd+c2ZjhRlgO+Yg2v34MOoqeV8RGu291huBJE2?=
 =?us-ascii?Q?aQHcSxApUrMmcrMgWaA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e77544a4-29d0-468a-5e4f-08dcb1780e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 15:47:17.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpPt8R14HpFvu5Jq5QNBeg/buzp5R00VYlmu0+gzbmfBShTZQSUNcaa03wPYvx06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188

> -----Original Message-----
> From: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Sent: Wednesday, July 17, 2024 1:11 AM
> To: Andrew Lunn <andrew@lunn.ch>; Gupta, Suraj
> <Suraj.Gupta2@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: RE: [LINUX PATCH] net: axienet: Fix axiethernet register descrip=
tion
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Saturday, July 13, 2024 8:25 PM
> > To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> > Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> > netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > <harini.katakam@amd.com>
> > Subject: Re: [LINUX PATCH] net: axienet: Fix axiethernet register descr=
iption
> >
> > On Sat, Jul 13, 2024 at 06:48:07PM +0530, Suraj Gupta wrote:
> > > Rename axiethernet register description to be inline with product gui=
de
> > > register names. It also removes obsolete registers and bitmasks. Ther=
e is
> > > no functional impact since the modified offsets are only renamed.
> > >
> > > Rename XAE_PHYC_OFFSET->XAE_RMFC_OFFSET (Only used in ethtool
> > get_regs)
> > > XAE_MDIO_* : update documentation comment.
> > > Remove unused Bit masks for Axi Ethernet PHYC register.
> > > Remove bit masks for MDIO interface MIS, MIP, MIE, MIC registers.
> > > Rename XAE_FMI -> XAE_FMC.
> >
> > Might be too way out there, but why not modify the documentation to
> > fit Linux? This driver is likely to get bug fixes, and renames like
>=20
> The problem is documentation is common for other software stacks as well
> like baremetal/RTOS.
>=20
> Considering this i feel better to correct the names and align with IP reg=
ister
> description else someone reading code may think this reg is related to
> some other configurations.
>=20
> Example: XAE_PHYC_OFFSET is corrected/renamed to XAE_RMFC_OFFSET.
> RX Max Frame Configuration 0x00000414 R/W
> XAE_RMFC_OFFSET is only used in ethtool get_regs.
>=20

Andrew: I am thinking to split this patch into two and send out v2.
1) Fix axiethernet register description (XAE_PHYC_OFFSET->XAE_RMFC_OFFSET,
XAE_FMI -> XAE_FMC)

2) Remove unused bitmasks , register offsets.

Please let me know if you have any other thoughts.

> Other changes are removing unused bits masks (Remove unused Bit masks
> for
> Axi Ethernet PHYC register,  Remove bit masks for MDIO interface MIS, MIP=
,
> MIE, MIC registers) so should be fine to remove the dead code.
>=20
> Thanks.
> > this make it harder to backport those fixes. Documentation on the
> > other hand just tends to get erratas, either in a separate document,
> > or appended to the beginning/end. There is no applying patches to
> > documentation.
> >
> > 	Andrew

