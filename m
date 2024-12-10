Return-Path: <netdev+bounces-150533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB69EA8D5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8849F282C58
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE222CBCB;
	Tue, 10 Dec 2024 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0Bo6t55k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898E228393;
	Tue, 10 Dec 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812760; cv=fail; b=HMpo6G3TRQmWSGYZX6qIk2pOQtDkYebcIvfk79cAMF+fMiEoapcZRfO/IwNT7g66TB3hsEK/3VpB28w2H9z35KzdTL22sKLHQ4f+f9+ovGfm57q8J01p8nEOrtJf8m5ny9O5cb/gHHgL9XHloELvN/aoQwiPVjyZLAWb7JM+ShY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812760; c=relaxed/simple;
	bh=ft/thcly2abOdczD6WcqDe76XGWUY9olSMbAy+qsRL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRGCU6ScxTHIFxnpYZ1hp0FMI41uuASbIcezf0ziOLXIF+bxSuKjX4/kIp8wkWxI42GCM0yG1Cl/ldkVfIr9zzVNbJP02Wgh6X6pkjULIvSzzed6RrOPtWaldtZEoKalJxmxUwUsxdzzU7wzEMtNz3oYnqjDSoIswXDvR6TNugI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0Bo6t55k; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XL4wP61SDPwER95VentA5LzOOiy+jl4/zhhtf+nrQgYLaj9KvHhRgN8aU5HP8H0NQLshclgDI2EKrkZ2JtFXmh55IEhpQn7/+gcmLwnQTmF5dNNXzGy1bUaD4wruoGdISd/+QhAF+5msCXyvVJGGHuVdn/STh9fmNTItpqfGTdnU4PUUtUWc1f0DwUCd4rpAn/pPrlFVOO08PsRpxXWYxGp6SfkD/72GR6ZXFPA6a2L/e77sZCyP3lXwfUxf/xCpyOQOF52xCbdFi1CpgtJQp4NcHPolvrEQ3yLkK+yRhYKU+1F+6rB05pLJJrZGznEQ+ZLIFgIwloBlUO+CFPUSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFXlZBFp5QIqWntMkC2pKjT15xXzoiybUYLihpjR/Qc=;
 b=OFh1oeGcomp6zimPTogwQhwPU8jW+o1RQM53uN+N5CY1hiiaEhdC7KRmWxLANQhgZQIsqoWS7xJBqG3MwTaeqTrnLFzDlgHLB9odzf25t4CJ2ydtmmVLLAm7uwWEHW2nXOpsWUVUrcY9jZl4+1U/lEMJPVx3t2uhCEUx7i/vxxq4XbGCYXZU0oB1l769kWk0KWuVMpA/UInzcMU2WlDxluyqyn0RE1pUnoBij4eE0t9GAuocAzAK9s1rRAEMIDMcX0KzAxALYmkLoeMyX4hUivuMflre5qKgZbm3o1PrIYzzZfqdBMrp/frKBfnLSMnOhNOnouTJkWiSsrw4qtl6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFXlZBFp5QIqWntMkC2pKjT15xXzoiybUYLihpjR/Qc=;
 b=0Bo6t55knTRQZkdROEYoTytJ1QDctwHKNKITkOPgPeEcRXl/yPt7j0n+H6ZAo4umT+Dp63Rlu7r4pwbiekaB9scATX2v1bZ6thIieP/12R81NhEqPaoZib033/ARE8CCMYol+k7ikyQcnbofo21AJsxNoMwBV+yR5c1PA49JjSjK5pdPr8jCfG776MlxQSzwUg4cuSayNuI59xmpUeaaHG/qc80pk//TX9K40Cpms6xBeidTCy16/VhKBi5YeJEXX0iWaIr5uSd+vqz05u57jVe3T0kHnPsucMM6UKR6dRq5Yk4INh28nCer17+gPkMBn7VODcBVHvkCawrd2A0CsA==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 06:39:10 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 06:39:10 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/2] net: phy: phy-c45: Auto-negotiaion changes
 for T1 phy in phy library
Thread-Topic: [PATCH net-next 1/2] net: phy: phy-c45: Auto-negotiaion changes
 for T1 phy in phy library
Thread-Index: AQHbSlZK6In5W480tkK7L3kbMd1ofLLeIUUAgADlRtA=
Date: Tue, 10 Dec 2024 06:39:10 +0000
Message-ID:
 <DM4PR11MB6239E2433E6802AE9EC6E6B08B3D2@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-2-Tarun.Alle@microchip.com>
 <ad3f19b8-20fc-41c9-bfd0-e5f9996da578@lunn.ch>
In-Reply-To: <ad3f19b8-20fc-41c9-bfd0-e5f9996da578@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|CO1PR11MB5201:EE_
x-ms-office365-filtering-correlation-id: 2979fb0b-a72d-4ed9-403a-08dd18e55a92
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pW/sjjr/e1/EthMxj0RVXybBEULHuJQTZLqh5Vo/HcMzO6aETZK+Zcd30egY?=
 =?us-ascii?Q?RqEoZl0rgUgK2q8Qe1bV07UIvB0W85uaybxVOaTBT7GyiYZB8rbZrpXS2YJd?=
 =?us-ascii?Q?9ToP97mpruFpMlXn/tPKgx1xLUC6eQ2CpJahBmfXfd8WlwzIsoluaufGSKXR?=
 =?us-ascii?Q?sM5gB11MH95ZoWqlJ4SSnyLCAX6XwPfVCmxp4EawaEgGb13ZEXKfkIFr9XsV?=
 =?us-ascii?Q?PXoNbJspZcUp7hI90FQw0xtaJRGNAwtvfjogqE5A3r0SXeyZzR0QaDHcZQcr?=
 =?us-ascii?Q?x4SWWXGLihJiheS4/S3jg9GfBL+ADIuBsCaKJK/X5iiKRi7hivZpOh8GjuS8?=
 =?us-ascii?Q?LyfnZL3TxYNzHqlKizqBI0xOv2kcKz7mYqqtMd32K9aVzGVQuMSJB6J6h2xE?=
 =?us-ascii?Q?UXhgKXleMlspZTOAMO+WC9Rh2JAoaTM+nsMZwZKRBxta1E4q7kRtAiB0e4qI?=
 =?us-ascii?Q?gp0IzZ6NGMwm2F+H21xgSpVWshu4V/Qz1OHya4cRCCLsfVxVFd/YTYlKjyMV?=
 =?us-ascii?Q?zd2sGYNqXVvBU5hEI0LfuIikMfR01M3zvO4XSvRfW4P0PzPDhTvJWFT0Fosu?=
 =?us-ascii?Q?8+lI88tU2Xjzg2eH7NNe2Z2LcLXh+hzOzzV3mim4I8++n8chu/z/JToCfGtA?=
 =?us-ascii?Q?Ax8qWIY90VfA8biRJeycsNGZSjqbprGgHUjjno8b6Kwf7Ds5h4htdJUIudbT?=
 =?us-ascii?Q?1JvvHjn4RQqkwhVXetts0c/QB2/Te2GNCgsxejrq1RDc0X25mJ7r6G368LWS?=
 =?us-ascii?Q?XA8XOwD8wV8KgdjehB8NhurDvbPaRIaRIr03BDb/aEDGTe6uP6FOOlK5ylGM?=
 =?us-ascii?Q?R9XQLslzyiXcACEaDlv+BWq3mM0iag9Sy/KVyF+mrD3drwj+oGhEO+KBYelK?=
 =?us-ascii?Q?NmqbYvmJnb0EdFP7n1qEt4ZGqKbXBlWkV6KHPhCbPX1DQK36r0koE8xaFnFq?=
 =?us-ascii?Q?UXr396pxngNXKmyEnj062wUiJBz7ZEn8UWa4/90B3/fNLZowpvPHtFNiA+8V?=
 =?us-ascii?Q?9UsQoG//1RIngPHDNi88lg/QEblWo61buNToKJnNmhdjO17zzPzwZnMimy9B?=
 =?us-ascii?Q?83nJ/s9Ne2/N2DlwSjBVuMbJ95gFbEr89e02IqRvyvQ5Ekp/tK7RuebCnfCX?=
 =?us-ascii?Q?Npg+u0O2nQFSKIRDQ2c6RD2XWW0RQvAGBSfwshnqzKPGxNQ24VAiljL9DLG+?=
 =?us-ascii?Q?50E9UwKWRpPRTOzF6/ggP8KvA83CCl71dD3124y3a40kAqKUbmDJz30u0Bk+?=
 =?us-ascii?Q?aZ1346//GibFyizMARUBsheg88obo7SC4/eng0pICEvg8pmci2vwgFwN3Nda?=
 =?us-ascii?Q?56MyTul9L+y0pDpr991nPbvaj6w3eUq39ypHkWIB9rjSY4ATrnkFGRlKRm5r?=
 =?us-ascii?Q?4EdOl9NCzpm8ukYJt+HYELcBxAbzaToAhXXOwGUAfCPgW1aGQw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9uhSV52MxaR9r6ZHpia2JHzFy3aZsN44wSmcsFvuz/IUPQjobQWi4j4nRgAu?=
 =?us-ascii?Q?ySIe9w21rNJNvNHzVA6Mo9BlFypohhOhX90GVg72SRx4W/Z1NTvFTIYQ3wg1?=
 =?us-ascii?Q?t7mWSKg4kqEX1nVAPhrsMVkgFLTYWM2CReqvudBtzPGpW8/clX+Flwgv+dNp?=
 =?us-ascii?Q?zcZIWUxKOSzjljagYaiKJxVUtIuDIECeuNFR3l75RYTNWGvOrsAac61C4x4S?=
 =?us-ascii?Q?NyO/9VBb/IMqPgl6fMFcPiRqZI6fpzS+ODgaKrKv8NMgmkAiKgNoGs1bX3JE?=
 =?us-ascii?Q?Kf6EaWHr01FmVGlMMdZqd6YSc4RR50ovAcnfUQGFthoGjj9JXdpNdIAM7+FD?=
 =?us-ascii?Q?4Mn2ssJBlctZohbR4XvLBo5uJMqgxUkrKDxoSOb6r2OywklKYElbZCdcpj67?=
 =?us-ascii?Q?R5ODaBwVqUpYa7UhgOig8gOFTj7LWh0lDT/fYqfaASOfJi6HIYotkhXpkRWp?=
 =?us-ascii?Q?Ay87mebaZfY65rsSiQhLG052W2ULz2BG9SHb57Fdka9sSM9nEfup5jyR8MLm?=
 =?us-ascii?Q?EL2xYdY3RIu1VM0PxMy1K/mguzR6KLbhNPyd6aNYI+TakVzAMx2BrAcxGVY2?=
 =?us-ascii?Q?PiGTSMJmlmKqAjNas7Vq6ztU3qTOzG8CMLeRaRc/g1t6j4/L3i65RnD4ZE2F?=
 =?us-ascii?Q?r/jbHym6c32XsynnXHn33mZupJoNAzH6EFJ7cVffFXxTRzz891rb3OVBS09N?=
 =?us-ascii?Q?7OSkUan8sR6BS5TXnR2vBbLpO2/gJ0PHq4Vl/XfOVjfbMV27hgj/HnX6n3o5?=
 =?us-ascii?Q?yTqld6kilvXuzdrVGwQ9NSlwsmIJIgM4Q7WzKuqE+NZi+6ofYmIvvGlhkmwJ?=
 =?us-ascii?Q?VarNKdzxpcfewvDUwvvMYdFrfQPCw+Y7DtmIrCjmynr1ndIaZrIOWUD8sse9?=
 =?us-ascii?Q?CqbbEWZgCvJbHxy6szPCdtjkQk6Ijm83PWqnCCB6D87Qel6fbFki3KbJKc/H?=
 =?us-ascii?Q?5Dn8uerv+x9ThoihOoQU0meZAy/ZF2gzIjR4MhhSNhH7/PY6lPbNdbaahsQ+?=
 =?us-ascii?Q?Httk8y8VGYaC9Lz8islMLCwIUB/2RJHVvNuBb3BY1MLQSdBHP6R/Pq7lPEGY?=
 =?us-ascii?Q?UUezB9yx0HyKxyl6jKXT+WAdupMzVNYOioQ3hChNfcdTgj+EwMWOiNq4aisw?=
 =?us-ascii?Q?RtRzZQ5F0qzYG98WD4OMwBazHD8/BcovYQKwKrVzbRFRs2vcOzVoC7Zzv8a9?=
 =?us-ascii?Q?Dqi3l2O6YOCrDVje+yOwBrYclg7edqsx5zgIPQzDYJ+d4VhuDwGWClF1plxK?=
 =?us-ascii?Q?nBmyuOVsYltxMQBQvbxHjyYsXqDfHFxsNf4iTX5Dkz/XMAYQJ1ZZqlY6xZRx?=
 =?us-ascii?Q?uVcIUH+poSu1S4Bos+gWLazY+55ucLYhUKBqJa9IXkm6MZ61nn98sP33XEyP?=
 =?us-ascii?Q?mr2nnDAEXQMs/WjigTx4XxOeYfyV73mkzOMihh7mzcu5nBkmFH/DnhNuHBwT?=
 =?us-ascii?Q?rzuKi7IxleRYK7LjqK09GDcBRswjx8masnIyC2gTcaNWoZ1qUXolQKTZ1R4P?=
 =?us-ascii?Q?6hzx/jxjyRLFgYUnD8vsrLV047kUm3/Zj2ZY+9U9ruLkgALPILvVPr1MqgjD?=
 =?us-ascii?Q?spKKDVWiJ/lk4vpIpdLAXL09j2CEZ+HmKssdoZeV?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2979fb0b-a72d-4ed9-403a-08dd18e55a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 06:39:10.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/IHO1cBnLOYhD77EJZycSu7v0BXrbzJKVALT8Tr6KknpBBXUgLUAFIGS/XVTTP666agAwvCMlA7TfjECbb19wTzMp8V4mAo2d1Lg94O4mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201

Hi Andrew,

Thanks for your review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, December 9, 2024 10:24 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> hkallweit1@gmail.com; linux@armlinux.org.uk; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: Auto-negotiaion
> changes for T1 phy in phy library
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> On Mon, Dec 09, 2024 at 09:44:26PM +0530, Tarun Alle wrote:
> > Below auto-negotiation library changes required for T1 phys:
> > - Lower byte advertisement register need to read after higher byte as
> >   per 802.3-2022 : Section 45.2.7.22.
>=20
> Is this a fix? Does Linux have any T1 PHYs which already support auto-neg=
?
> Either add a comment this is not a fix because...., or please pull this o=
ut into
> a patch for net, with a Fixes: tag.
>=20

There are few implementations for T1 PHY auto-neg. I will pull this out as =
a fix.

>         Andrew

Thanks,
Tarun Alle.

