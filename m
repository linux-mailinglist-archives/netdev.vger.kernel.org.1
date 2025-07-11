Return-Path: <netdev+bounces-206033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA36B01165
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5DB546864
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F57190477;
	Fri, 11 Jul 2025 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7kfqM86"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C210E9;
	Fri, 11 Jul 2025 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202350; cv=fail; b=G9KxDCQfyf3vnJ1fcieK3lqnOipNojoCjqK/rrQDdGwLjTGjmQXcvIuv5m+CREXrz0PfAkOHkyOAHKXyjtZZqylvP7tAMiiwc5Fbqno42FbBr1/o98Uco6CTl7DNJY0P6rvqHDMjrfhsD+ShAgykcVKe2g9Wu2AUmO37tvs+DvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202350; c=relaxed/simple;
	bh=xywExsV49/eJUKc3TJCdfjBzN0lTiFbpy1TOpea5qQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P6e0xLmjYs4cXQh+oZS8ZoktH8A3o3Cq/K5MFDx0oY1nCJgLDD6NlOAfjbBsnZ6URa9Ao2MyMR3tyYbSwrSONKwTvvod7re4BImZcxVMH6WJzoVsgbG7eqsDOKX2JFvnImEQei2FK4vjPn0yXPWs3C9WquL3meJqbOdeMey0b7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7kfqM86; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzXF+1ZGVrlAmp7bT8/tA67nU3OHK/yy7jdWyAToLElm88hltmbl7PJd3Zkf0/wbp86h+Q64x+4625rCTREK12UAYKNYliKPTrORkGDyAB3WCyLqBfpiNSnSqQchAQ1cqRLl3MVlQK9au1D22GY/oMCXJMZsJriyanXXyFhKL8fimsIbag8j9CVOPKOLzJh7cCT7Q+a+sXwce9OD/GI1orERY4O09S+2hwPbEwqKElPJ63r6SVtB4ARjQUu83F7VJ4wLaHE8NB+TdW8qz8x6V4BYhUZ8VXKlexqazA5PgGKxWSBZ8s7fP09upft9wTvP+v7Bz0HD8K4X9Ryn4p3eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xywExsV49/eJUKc3TJCdfjBzN0lTiFbpy1TOpea5qQc=;
 b=XFhmKuVewIwJpq3XkSDmVQwJBeLa/SS1WYk+KVPpNPYrmW33SUgSsWRP2AlHADtPjT7aHPvvnLgUfTqxG/7kn5SeSLYAaitNwJOmvr0yTlAU7ywbaPSxChhh1U4/BjYC2znzBmFz1DWixhftbMdOnGmf10GpAefuDp266pNj89LdRjQgKvu6MTA97nDVSyJ0+bXkxczPSvahRn3y+r5DNUc58r+nIAJ+JG6Dh8kq2/eXSa3lhuBBagEJ0Z52XS9pk7v3ZEcIetM4Puje9R7y9Idaf77lvV9RFWNwWN767iNhBMNx31votVAr4ClvybfravdOpsA1WB3u72xCmiYjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xywExsV49/eJUKc3TJCdfjBzN0lTiFbpy1TOpea5qQc=;
 b=O7kfqM86SzoYZK9U+sLDBZ3IovxcF5Ugqat44ovlminaPDWyBVrNujpHX19e/FK6vQX7rqZALX9ja89fQPim3purIVB4J+xZQb2X896Xx6pA9QET6AfW44fNLNxyIiWNl6d9RstEu0qigJxdjLXy8G22CbXsB/I6xIN3hO8Ytrp3Ki8pXbwdklHDomM86j416Q1Nil1xO2dedrMYfHzz/21mVv2Lv6IaakJEzxIbFiVWzXzYbM6xSB0aU1hMgPBDbE+WJxcWajenN8za3mtyx3S/KrqIClb/YDNhO1PYCjFg8stfLupEjuOPcVvLWnHq8gFJ2SU2ZKsxUHcX2/KHLA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 02:52:24 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Fri, 11 Jul 2025
 02:52:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, "almasrymina@google.com"
	<almasrymina@google.com>, "asml.silence@gmail.com" <asml.silence@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Thread-Topic: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Thread-Index:
 AQHb63aYJqQBPRpj30ykrq2XrPwwyrQfKE4AgAAZDgCAAA5wgIAA8qiAgAvTyYCAAC9MoA==
Date: Fri, 11 Jul 2025 02:52:23 +0000
Message-ID:
 <CY8PR12MB71956FF1D74C1EAE3401891CDC4BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
	<20250702172433.1738947-2-dtatulea@nvidia.com>
	<20250702113208.5adafe79@kernel.org>
	<c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
	<20250702135329.76dbd878@kernel.org>
	<CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250710165851.7c86ba84@kernel.org>
In-Reply-To: <20250710165851.7c86ba84@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB7455:EE_
x-ms-office365-filtering-correlation-id: fc9175d3-0d25-4bcf-9f5e-08ddc025f67e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fdxskxT3LalwhHFoYp2DakcTTp6TBK+W6ymNpnihh/VID148CTdBlk6XjUtU?=
 =?us-ascii?Q?6DV0mXo9oU6toNhLitxx1Ze4aw9s3byc02UwSkM8OKTUZPyNlGxLPnlwCp22?=
 =?us-ascii?Q?Dx8ce0k1/i+ubIUQ6cEmQ3rxC2/vn5hI8J8jB+YtUEwo3BDxjTt2pG/JMO4H?=
 =?us-ascii?Q?hkiV3/BFsdcmu+NWxtLTUK0R687oETkTaRKiFjuAEYeArJmGN3HMQdeA9s9Z?=
 =?us-ascii?Q?cVEk0J5hh1ur90GCcW8PmGRyuQVtPdyDOp0oU09YyK9zIetobVWBLdKUjxZY?=
 =?us-ascii?Q?zwZgA4mjgVZ7w2DmEcaQW3yhdUMKeX9yGhax4jq796/rDPiZQmt7cYWEb+XJ?=
 =?us-ascii?Q?S/3XEUNk6MNN3CI9E2v+cgrdKR8xpTuJ4A924SkpbdtXxW00uuExTcAHoLiX?=
 =?us-ascii?Q?eQenBBx9ig0LOYCVwlfoG1kznduB2eWxkP7ofu7iLvloaAH65k/oKGhPW/UF?=
 =?us-ascii?Q?gA7du++KWmqpWiV8F3zgDpw1+nw7Uf7JWi3eKnvz8q+4l3EX1Gf73HQAV2X0?=
 =?us-ascii?Q?KDqhMQZgmrpRl0wJCrYwG3z9WK0IW1h2mqZzEg6TrpFIYrDJyW8l6m6pQ8nG?=
 =?us-ascii?Q?KgodEPr/4GcpNwfSbwviCkaTzRkYRkXHfMz8//rmn+PuZhCHlSZkoESHobJf?=
 =?us-ascii?Q?W+LsmrR6xp7tD49A3X8w2wq7gG0hRjNlQk+TkNMAXhlxv/bzYmWJNhbYT1iw?=
 =?us-ascii?Q?eDljTc06ybodUa56l6Ii8h4UIoJSlDIwvoQ7SZ8eAMK4Cdfx4G6Hh7lONESW?=
 =?us-ascii?Q?Qr66oQw/kjuHH7xMeSK5a1wE6yvYvLpEBitbMxqKWt8AzQMhjxq1wHhwH+Pg?=
 =?us-ascii?Q?3RVAJo4/WDas2RE+PH4yACWyUtg3Xet2zUBub80GaUc1QTpT4veerKaOzYJe?=
 =?us-ascii?Q?Tk1IUgJOHQeCpXjhcVx0/V+GHRC06XEHVF7dQpaDhgCtvRRvAc6LP43pE9QB?=
 =?us-ascii?Q?UUQl/ny1maV8VlgtSAkXXkf9ZscKMtkOFL24MwEXQc72GQ9EGkTJ8DTY2LAP?=
 =?us-ascii?Q?6KeZHU8TVt4bXvj/VaOYw3/VyX1RwUsY1UfVZFzyCJUURroGnYa84H3C/9zB?=
 =?us-ascii?Q?pWtW3WY9frLZWJi9RusUCAiPM168U3QrX4+MD7zmy7HvnhQzlLLjl8oRu0vB?=
 =?us-ascii?Q?t1/dDShU3+9bbo3ImpKWqCYGmAdYGm+0vU4yYxQiTPV6fj4nc0xyfPKH2AV4?=
 =?us-ascii?Q?0E1PjQ5O1sgxoKHPSao9nfhVSNHU0yklOJTHmkOXqliRaDvFMc+Lz9hokUf8?=
 =?us-ascii?Q?vIs/Ru9UYEXB50IrW+S7qoA2EFHyjy8J+CJ+GKZ5XakjjCOlE7h/IJuY7lda?=
 =?us-ascii?Q?WMe7ASZ/Jkte2Alhw1cQlsQX9L7eQ4AOAG+tn14LOxAOBbLEtY20WRuPisF2?=
 =?us-ascii?Q?dTTH9rnHa5gWXNI9teS1oMr9pUfAP6YL0U3puEtSh5fxxJHPnbcmiW08ktQN?=
 =?us-ascii?Q?n3d5Gc6xd8ij//4DPe7QA9j6OCymQsf3D/tlV+eCT0eJNqMvFARXOm6GOD+9?=
 =?us-ascii?Q?nOtF4MIDxe4Kpw0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NBI+JbDu0eKCLj6BTVlFIfTebnMpiAvdqtRVS3xHPZqeQWXZIUzrmVlxEJWO?=
 =?us-ascii?Q?dVHxVSPcmjYT7PqNiYhz5OTdJHMMHCR11cT5EY8xilB8q1w8j2ARagtQillX?=
 =?us-ascii?Q?1eOdUXCzryYcLRgWpYe5WyoA3Qp6WmYasgBwxCqGNzA3BznkiS/cLv3EukAm?=
 =?us-ascii?Q?otyQRd4yrgChXe+onC6n19dR5RpUX3trU6hqXG2TUGCFQHYiWOVuLmVXKvFm?=
 =?us-ascii?Q?ArCOh97IUttkBo0XNBzvQJ4otvnTJ72NM3SInFTTWjicOFE4hfXF6hb290E5?=
 =?us-ascii?Q?HQWASfVM9fMywANc2I+2YrfP2+vXo5pJ538mhPJyEZZf1QYAexVFCg6NVkmo?=
 =?us-ascii?Q?/yKMsQCYcH8gFbLs42pmObDg8LVgn3Bkhx6W5DxAJz7f96YulSsvyBrnYrYv?=
 =?us-ascii?Q?xyCJ0AYlDYUWtQH2TIDhwdq/wVAyJ6VX8lTeRSwLYOgA8sTjHdJ0uYNis2bi?=
 =?us-ascii?Q?E0ntSdX+T/ufKfWcHDD1zL2r7bYPmOUmxLCdoNCiWJmrOdP+L0ZfEr0uD2ce?=
 =?us-ascii?Q?fXwa147xhVzwEMoc6d4euXipKOdaD1UnztaPnPBANtYAgFSD7365aEPB9y2z?=
 =?us-ascii?Q?jpluU7CTxF8AQsEpAZrkZVLPQV84TmQsOocnxapt5EkqWs2FKmwHXVjhA30o?=
 =?us-ascii?Q?zlkILETJqxqDcIXQ6QaQmaTGTSpt5GCob/iHKsMBTs+DKW7G79PI5o5m9Pul?=
 =?us-ascii?Q?HIJH0F4ajXMlWyfoZS9ybfiF3PV6ONlhQ3LYTrGub+2edZOpPDUHlulGTYZ9?=
 =?us-ascii?Q?wm1aplv/3parRi4+rMKLNyxMP+heaBl44k+ts0y7WCcsYT/XInyuJSlpFHWy?=
 =?us-ascii?Q?Kuin3Zrsf9Bqr0K8eGoytF0xIcT7MpRGodrdGT8mwsIDmzXu4lbhqbz+gFCW?=
 =?us-ascii?Q?P7ycLSNK5m1cGE2zlZ2EnK3QLNdJLR6NdqFZSy/McHfFSQuseiskk1JCfOxl?=
 =?us-ascii?Q?PGLAS79OR5z7l0vMU3fd/ObUe8mysnB+RFBtlTM5FBuCYSwSzAGqkXTEcD7S?=
 =?us-ascii?Q?kI9UKq6r97P3+WAavl1Vd0xtvqfsdGMG6OrGpsvs9ZnngiZP39WAS8948TmN?=
 =?us-ascii?Q?mMQdijKn5uljIDJcGGbPac4hBaK90Gpzzex92tnTMOcam3CGH0gZvc34/x0M?=
 =?us-ascii?Q?AO47frMw/N6fNsW5MtOIHQr5B1TQpnY5EWCfxlfTTcXTbbHKPcU6hX+Obqfs?=
 =?us-ascii?Q?0wkh6wK3JKqn4BsQ8+bQE9hHswQ3eOp9Hwju3JSxG2AAVAsGrqycEiT7u1nu?=
 =?us-ascii?Q?e9A/mnZWBzsTLbPsobkSZZ8a+EcltmfISHeynxbMg/c4/dvhFRbEkTCJMPXn?=
 =?us-ascii?Q?Fcy6gh5x7jCLzpdpHbPj3lmNCUYYtp4A97QjGgpX5gh96KpOVClcwJ+UQiyg?=
 =?us-ascii?Q?VHGOuf3BRhryRaRlYLU/m8q5/nswq9ZM/3lSKkXULSLq1k1DON3AoEZmDDI+?=
 =?us-ascii?Q?Dnvp2RV/2KJEw1E1fXSmvez+fyKk7pvsuTm9RCQ48sKRi7IvmJuZqN21BxbR?=
 =?us-ascii?Q?HJL482dqeN5pvOm5G0LrOsKta4K5EKAHbbODsRH4mpGPme1DTRtgy1GWvqMN?=
 =?us-ascii?Q?IJ3h8m5GdoYOXosjkmM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9175d3-0d25-4bcf-9f5e-08ddc025f67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 02:52:23.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bu0jHJAEiits8gv+B9GNs6PHXUzkqY+T/fQiMO+O2gzKmzWhWZ+nr3LYp/fgI/4KAMTIgj7KybHS25iJ/6D50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 11 July 2025 05:29 AM
> Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used =
for ZC
> DMA
>=20
> On Thu, 3 Jul 2025 11:58:50 +0000 Parav Pandit wrote:
> > > In my head subfunctions are a way of configuring a PCIe PASID ergo
> > > they _only_ make sense in context of DMA.
> > SF DMA is on the parent PCI device.
> >
> > SIOV_R2 will have its own PCI RID which is ratified or getting ratified=
.
> > When its done, SF (as SIOV_R2 device) instantiation can be extended
> > with its own PCI RID. At that point they can be mapped to a VM.
>=20
> AFAIU every PCIe transaction for a queue with a PASID assigned should hav=
e a
> PASID prefix. Why is a different RID necessary?
> CPUs can't select IOMMU context based on RID+PASID?
It can, however,
PASID is meant to be used for process isolation and not expected to be abus=
ed for identify the device.
Doing so, would also prohibits using PASID inside the VM. It requires anoth=
er complex vPASID to pPASID translation.

Tagging MSI-X interrupts with PASID is another challenge.
For CC defining isolation boundary with RID+PASID was yet another hack.

There were other issues in splitting PASID for device scaling vs process sc=
aling for dual use.

So it was concluded to opt to avoid that abuse and use the standard RID con=
struct for device identification.


