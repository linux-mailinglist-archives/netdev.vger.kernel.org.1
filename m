Return-Path: <netdev+bounces-203510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3CCAF6399
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC26520D9C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56452D77F3;
	Wed,  2 Jul 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hcgjhTQV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BF2D6415;
	Wed,  2 Jul 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489795; cv=fail; b=FrVcLF4+41XcBzCk1WOJWofNGIqnhW7CkIBnNfgMpZEf3Kyv6Ravj/DfBAl/JyopmJYyh6WZj29Mg8yxED4Kk8cfVcXwAQY5ilyviP08Nszqt46eVyymrTeWlK8T9+h0I7B9NlojQAmWo9N3Tb+3U8wlvRX189t/VXPOAS4yPh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489795; c=relaxed/simple;
	bh=qViJt+/tQ9MozjifwGEO4f74aTISEeLHe3mcRDihTv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iygVjT4/IqqxR+zPRrUW6TW5sTMLruUuRRRXJ9jOzSbZR6rdMlyOmqSTonAzUz5iLXLJ7q9HgudDzwj6OXPLNBD2bayb8whMFTzi6SvkO6yAQpHtwkXlBqIosM6Ne7nbk3FiPZjdJPRaWzzu8RSNVjoN8VxDRNuLRPpSfqJux2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hcgjhTQV; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo71WYEzCfe7qD2ufNlvRnwjBTikcH8XkIkyDBeGvc6im4QbgO5pJMinu1PEWesZQodTPvtqoSGixbPuQy4DgNbBe3oqv+WfLJN8bS/94oP2nJOsocwcFtxBMxT26s5FPMuDQEmk770cOUUIaqtbaGS2Xx2EvHIpdQJGuxwOV0SNWQy7nqSoNFeM4unRR4CD3bV292sA5bv8VV2D8tkyPJvHQp32jQtIUU0SCvRqjUiwKrYlZox4Is+ol212znXuYqH9sYX65nuSGYXdnG5dmyLxVadnyU+kV/2MpccL1eWxoMgmSDIOCzMRDrtOv667ZOhmZgLNI1x90mor5CB6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2HAbMgAqyBPq+Mu0F+upLYxR/t1repXC5UKlPyNAns=;
 b=kaWS8eIocRUlyGD+EAMJ5waP3dNeOWcGC3yGW9DYFJ8hKPsWrMQLKzOtGbILEmR9gWU/lO+0iMhajDIQEPu2uynyuCIFNiAj3oI6OdF+4/h6zgA0f1etSRAVyDP9nh1yA+sZLPPLi8YyFmg2RD2ZGTAH7ZZYjlKWNcXkWHVAFAtLgC3vE2sRIBukHPbZez7EVdf/HAIUvoF1euI+n+yUPnEoiwKKEVnIZv2EH2tqHFebabHoyLuCoDYD+i+5wQauvasOqJURjvYnMGlMyBfjCaCZgxCEeX7u6kYeJnkPEZOs+v+UaPP09oXAtpVEjzuX2VJYXb/7NULXJB9jNT1A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2HAbMgAqyBPq+Mu0F+upLYxR/t1repXC5UKlPyNAns=;
 b=hcgjhTQVJaYbR84GSGwHCsDzH1au7GOaQ+YwBMfv7zn1zlszX5kGdx7Y/btO8Vsvv4vnuXb4nCqw534NhFQFpMRr7rlQSRsWyAYbox4Ky/0mQwC+XYoDWrfQXp0CEVqZIdhygwTJTbLCQpz4eJwkE8dOYNeVRKN/TN/S9CAvEup4wh6B9sUmXMy3CXyOtk3ArhR4r6g2Hn2mK9g6QGO07KdKG5GVrk8k4xLTpu2dGmscql4odEzcSswIeg2IwdBr3AoyjjH6bYbWrxw00UdCKK9nBkStSHCltnUyDfomSCLvr10aodRS3GNmsOiPDPeSlCijAnq4fNTzaSGVQ7LUqg==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 20:56:30 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%3]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 20:56:30 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Topic: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Index:
 AQHbPTCwkw/5mDAiDkuucKlF479Xq7LJ1/+AgP/0uKCAAAhugIAAAetQgE7YCVCAAOb/AIAG7chA
Date: Wed, 2 Jul 2025 20:56:30 +0000
Message-ID:
 <CH3PR12MB7738E1776CD326A2566254D5D740A@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>
 <668cd20c-3863-4d16-ab05-30399e4449f6@lunn.ch>
In-Reply-To: <668cd20c-3863-4d16-ab05-30399e4449f6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|CYXPR12MB9442:EE_
x-ms-office365-filtering-correlation-id: 461a803b-b07c-4155-8e23-08ddb9aaeba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6pvtMi6fcXvs2cnBX3ztA1GCJQMtJSalCV2c/zr2lkoWSvpkeAhm+d1Axlfu?=
 =?us-ascii?Q?lyEhWQ3J77FOCmBVdOXFAY2VMPtgdBx0owjh8+EDvmjEoj5eyu4jXpPzBs9y?=
 =?us-ascii?Q?XWtp4Qxk/gUXmM/ckQhC9pUdDAk827RB+PeynOvTLy15KK4XyDpZL0R3S8ng?=
 =?us-ascii?Q?AigfIcBr5V8RBzIeGbOd0RhCExV0kqYcjwfNa3IjYvcSjCrYkvmDlzbVKycc?=
 =?us-ascii?Q?5WoS2P+TAIoSSdYebuKwCe2EDGjpOsdfd1wQuQsxQMS28mJ/pytcL5TE87je?=
 =?us-ascii?Q?+9w44IlP116Me/Py/1XeEA0hRIQYFz6O8FRH4SNLNAF+ULSjd5NBQvkArE80?=
 =?us-ascii?Q?uUj5KwpC7CZkDkaLKXxLhRrJLES3r7TJl8KYgDZYbxlGxlLB+OLhvrD1onV5?=
 =?us-ascii?Q?KrFIsMxtvnUxncw6jvASqx8cIZTauNH58fZXer+DE7C1b7PZ5hCNyvy3bOTP?=
 =?us-ascii?Q?iRrLkmOwC1QnjQWWbQdbYIRLHjHgWjOMP5WcGdmAokycPzgHHRRYJEs7MYJ7?=
 =?us-ascii?Q?b0kWh1tITXVZKdmkb0W3lu94StcSdB3eHRgNtVB8jGgidUqn+A0xuAnWgaop?=
 =?us-ascii?Q?hSK1R8RsvVgLNKhnIzqluLmwkkY+Dgvp8pPiDx1olSwK0jaN9W7oDOwEmRk3?=
 =?us-ascii?Q?tDHk4uS+kOdWCarOVpPWup94/qiCQPfhuR4F3rIsHXdqtnLrCt/u6iPom90r?=
 =?us-ascii?Q?zBmqeK32pdCRsNs5jKfqke36nJmLYQRkQ8jYJgnIAVLHICqp/KpqwZrEpRn/?=
 =?us-ascii?Q?SOG2aGV4fRIZgpbmov2vaKIFTRHvoXvbkLuGTinTBM2NlN/sijmK2rfEAAZi?=
 =?us-ascii?Q?xnA/hCbrgBjO0fQ2X0/VIey00puRRIXzbZxvDIJdabgcvxX115QuELPkRvKQ?=
 =?us-ascii?Q?3KnGo042NZISmeqTUJobLV636vyVzBUoUZEUTi03mFzYiQ/gopNJ4HOOpS56?=
 =?us-ascii?Q?RvdQNV8IR/ZYJA7rqlXODomx8Y1FG/+eBsIrzW4nneOCTK4zQPs/9dRRQ810?=
 =?us-ascii?Q?fnrZiZ2iEzyPQr7xzjtdswt6vcH5cSc+Vptf26i6htzVtZGH20ppje6L2Z5m?=
 =?us-ascii?Q?KDOw2JosIH4F/RyN9R1H6G+wTkxLZoYC7AK8J9DOVfRhZwgpkd+0Ls6I0+tM?=
 =?us-ascii?Q?FMFQvH4I+Pq0Pf1UPuyzAj2aUKwotJFf36mII93ySe5lzH/bX/q2zuxtXp4C?=
 =?us-ascii?Q?an9YPKpXuh/K1k/tCVUz3Xue7RlzXkeBbYfNud4i1F3L5Ep6dhFIV35nB546?=
 =?us-ascii?Q?VYd3u+AFo/sroa6fjDIj+6+0e/522MH8eIw+IfkqtjrPrDXZmHGDhRX4SQHf?=
 =?us-ascii?Q?weX3Y93lSbFNQb+burPoJRkGxcvbytxeGi7tUitkyWJyqXJ1lXE3juIF+YEL?=
 =?us-ascii?Q?ne6HQ8yVvAqvqCRRBIpx8upl07IfLiKQUJnyOggIGZXFZqnaamO0jIuF3eaj?=
 =?us-ascii?Q?/Yd1qJSk8JAWRodFEgAFlD1Qd7Ou3fNrvQ/iSrmFLRqq/b/GTsgAYnUdRo9t?=
 =?us-ascii?Q?hwkCsXi88KReOUM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nZmzT8nIIuq3xnNSIKk0JpJvUiP3hvdtSZIfdZDzjC8XVdw2MipLdYceOyRL?=
 =?us-ascii?Q?MhhjFaVBuiziPToTosp5Ryz7l4ymhq6bfojaeVTb2zVpXAtUWg1v9GZeb/F6?=
 =?us-ascii?Q?yR9GF47ENEJi4kck0vRabo/aoM9ME3vyqF1zn9AKxy0YngH3tqztLsa4k9xU?=
 =?us-ascii?Q?vy6ILaGn4uVbciqB0VYoJV1079LkkhtHK+Sij7Xtcc/3CAcR0t7+/f6QKGU8?=
 =?us-ascii?Q?466IaIdJRSRGgnZO20/1bjb1fxtqrcw2Pd25Wu9sqycuVTibMP1xbhZ4hGnh?=
 =?us-ascii?Q?8jQMU6pDt0zjXY30F5uplA/z1unLVOXUQ6gSzxb53U4t+bCuvzOAfiA360mi?=
 =?us-ascii?Q?QsDkRbg8OFwzxQ2Vr11EhfHGr6jvbq0OAM3/VbO04FTeW3+M1hEjW/vgdIPJ?=
 =?us-ascii?Q?BZUGGb39L/125m34FEZXkpylB4I0ldnTYys9pQkSiIahZ4/5L4XwlHLsNpeY?=
 =?us-ascii?Q?DDIR1XqxG5ZcOx8FWmvGfuPtBejjwHSv8newSRr39ysJw9tCZi0z40V2HPJM?=
 =?us-ascii?Q?PbuLRmNW5JC1JtV0XkoEai6acv6DNLtIbpEQc4SLSwmt56pkrwR+EMBVqGH5?=
 =?us-ascii?Q?DlCPYkRNW0kDCXCM8moBqG3Kys50F9uEpL8zOgb+6Nor1+3kRtybLoeOkruV?=
 =?us-ascii?Q?QxRI2OFQkowAgxL4J8/I+tURBoKgEpQCC6gL11ZZdbi0RQLm4ouYR9PPNV+F?=
 =?us-ascii?Q?YJHwSk2IUqUCHH+Dvr37PNOhNnCBV7DfdTJzlgheS/JK6KRbncr+o6T6wm63?=
 =?us-ascii?Q?ZpdYE8BCYMj509o+rGDBUwoUGx8hOTUNQHdrQWagYwfbeWG4+veQdMvwYzuM?=
 =?us-ascii?Q?hI8I8N543/EYFFNvmZhyayKeZ01xwlHpfABc3asf8HKyrC5ltW0F4A5SFFjC?=
 =?us-ascii?Q?jjZT0NHG5XuV5ZLUOcYsXe+eouIk1Ut7O76GLcuhcYZvmnR0TVmIZ2HowbeB?=
 =?us-ascii?Q?+5bish4RFxz2j0nZbulG1olVn/tANNweMUiEmOGmSceCVTxc9h4RwxnuXWjN?=
 =?us-ascii?Q?M/2mHkO6XOpxKMyacXZxuXBbLA1gJT/N+fpjb3QWQ42SBczgAaYqTZHUjY9A?=
 =?us-ascii?Q?wchC6AMSm/oYnE91yGNd6BZJfb8utwR5Hkj9laO+mPFA2UvDCbW4eITbXD7I?=
 =?us-ascii?Q?HwLqIlF+T2PH5Ibp74U1MMNTSgyhd2IdfkDFGlMeLF8xbOiy8ZnsDzK2O5En?=
 =?us-ascii?Q?OOi/z5UcsNCUtjVa3qDIHEMUtlejPYFOSlyoYRFK3xQo6fhiRyoyDcaJHIQB?=
 =?us-ascii?Q?YuOa4Wq5xIYCSZuTbSgJzLcNvMwCV/SGKjnPSXoEbSlDbqQmSgpon3EvXrA5?=
 =?us-ascii?Q?kdXJL8bJpLoYkTNMzqsCgC5KR0Vs2waYi4quVyqtVkFwFyb1+TDrySKieR6l?=
 =?us-ascii?Q?0rVcXY52I35pReFq7bsK3urSdKHtDLkwcJWjMT3ro5coy74EIrJn5KTUd3++?=
 =?us-ascii?Q?Kak4cWEsABsyf9iWuBlQNM2y1Oxory5kg55SBjUvBT6BIfJWQOQqNRpl4hnR?=
 =?us-ascii?Q?PeXye7X8Q20Etnb2PI7P8vtEUUsu/aEzJM5/NKrFJ5YiUVE6VAVlsGrws4FC?=
 =?us-ascii?Q?HU0XuaCs/gmvhRvBLM4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461a803b-b07c-4155-8e23-08ddb9aaeba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 20:56:30.5008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMZ/Ai3ZHbbylJmtPC0VMypWlzaeADE7VluALzPekgCmcOE5KLxhHJOth/AnRreo/3sKG8Mm3SGjQZOMW0cdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

> > However, we have another issue. I noticed that even if
> > mdio_read/write() functions are not being called,
> > runtime_resume/suspend() are still called regularly. After
> > investigation, I found out that this is due to ethtool being called
> > regularly. Ethtool automatically triggers the resume/suspend even if
> > we do no MDIO access. A different team wrote a script which monitors
> > "ethtool -S eth0" every 60 seconds. So every minute, we are running
> > resume/suspend and enabling/disabling the MDIO clock. Seems counter
> > productive. That team said that it is a requirement that they
> > collect these statistics about the mlxbf_gige interface.
>=20
> > Is there any way to prevent ethtool from calling resume/suspend
> > without changing core kernel code?
> >=20
> You need to put the MDIO bus device into its own pm_domain. Try
> calling dev_pm_domain_set() to separate the MDIO bus from the MAC
> driver in terms of power domains. ethtool will then power on/off the
> MAC but leave the MDIO bus alone.
>=20
Using dev_pm_domain_set() has the same effect as SET_RUNTIME_PM_OPS. The de=
v struct is shared so ethtool is still calling the suspend/resume.

int mlxbf_gige_mdio_probe(struct platform_device *pdev, struct mlxbf_gige *=
priv)
 {
        struct device *dev =3D &pdev->dev;
@@ -390,14 +418,27 @@ int mlxbf_gige_mdio_probe(struct platform_device *pde=
v, struct mlxbf_gige *priv)
        snprintf(priv->mdiobus->id, MII_BUS_ID_SIZE, "%s",
                 dev_name(dev));

+       pm_runtime_set_autosuspend_delay(priv->mdiobus->parent, 100);
+       pm_runtime_use_autosuspend(priv->mdiobus->parent);
+       pm_runtime_set_active(priv->mdiobus->parent);
+       pm_runtime_enable(priv->mdiobus->parent);
+       dev_pm_domain_set(priv->mdiobus->parent, &mlxbf_gige_pm_domain);
+
        ret =3D mdiobus_register(priv->mdiobus);
-       if (ret)
+       if (ret) {
+               pm_runtime_disable(priv->mdiobus->parent);
+               pm_runtime_set_suspended(priv->mdiobus->parent);
+               pm_runtime_dont_use_autosuspend(priv->mdiobus->parent);
                dev_err(dev, "Failed to register MDIO bus\n");
+       }

        return ret;
 }

I removed the pm related apis and just added disabling/reenabling the clock=
 directly in the mdio read/write and it works (see code snippet below). It =
might be slower and not as efficient as the pm runtime infrastructure since=
 we don't have autosuspend.

@@ -224,6 +243,10 @@ static int mlxbf_gige_mdio_read(struct mii_bus *bus, i=
nt phy_add, int phy_reg)
        if (phy_reg & MII_ADDR_C45)
                return -EOPNOTSUPP;

+       spin_lock_irqsave(&priv->lock, flag);
+
+       mlxbf_gige_mdio_enable(priv);
+
        /* Send mdio read request */
        cmd =3D mlxbf_gige_mdio_create_cmd(priv->mdio_gw, 0, phy_add, phy_r=
eg,
                                         MLXBF_GIGE_MDIO_CL22_READ);
@@ -236,6 +259,8 @@ static int mlxbf_gige_mdio_read(struct mii_bus *bus, in=
t phy_add, int phy_reg)

        if (ret) {
                writel(0, priv->mdio_io + priv->mdio_gw->gw_address);
+               mlxbf_gige_mdio_disable(priv);
+               spin_unlock_irqrestore(&priv->lock, flag);
                return ret;
        }

@@ -246,6 +271,9 @@ static int mlxbf_gige_mdio_read(struct mii_bus *bus, in=
t phy_add, int phy_reg)
        /* The MDIO lock is set on read. To release it, clear gw register *=
/
        writel(0, priv->mdio_io + priv->mdio_gw->gw_address);

+       mlxbf_gige_mdio_disable(priv);
+       spin_unlock_irqrestore(&priv->lock, flag);
+
        return ret;
 }


