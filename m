Return-Path: <netdev+bounces-302258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZF74ER7YPmofMQkAu9opvQ
	(envelope-from <netdev+bounces-302258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB36CFEB9
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rc+mKVoV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58BA93015D6B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B073BAD9F;
	Fri, 26 Jun 2026 19:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA62EA47C;
	Fri, 26 Jun 2026 19:50:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503449; cv=fail; b=flXFSpYoss8IfOYZvA76+ZMJAtZ6Zmp3FJ1wIqBlxNXtrDsStpjpoidDv2h19szUSwzsWylTAShFM8ptP4kpsbTHTGYGD60DbEqdicN8WggaBSIAGK0hCDkNIWn27zwxk+HaK0Uq6E0+SuY88RFjIALZVpEpH1cBAH/GOHyYSmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503449; c=relaxed/simple;
	bh=B2+O27xUcrMmBgzYrGw8qIpLXSqpzxtoOyCtmqbQDS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPctm6lgwt+jYdrDMB+EzSf4QCJUebH19sCcrHCfMIUvuaM+R6UnG8f5UQoVkBIXRB5oX+IY8Z7O1hN/DE3aDrvhF3wxB7p4omQZCm6YsvG+6wfpvvMAkQc1dgpdzKhWiw3wTQkwQQlFFKmVCYnHNzIbnM+Pd3tL3YKcPVYXVTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rc+mKVoV; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq5V6UdBA7OJjmj2+t8+Py25oYQP0+MJ5r5P29XVc14d6ECaAvR4eiSJRtTRPVIikBQTJQjICTR/84XuzSHuPb2Pqb+AyFGSwW8ZMKaJWwWQ6eRDdGT4PiIPrFZChFSNRcMok9d8wOrTtE7vH5Kq5/hjRYuqCUlRZgQtFs2bcMM0+XEmkZG8Ac4Q4gk5kubU43qmQ5L0O0pXiVdHF4KgRCi2NGyo0nTd7zUY0hXgRtN6rAokhabpLA6n3VMgGiBzNGiothV++aqrj1VCrNN6ByDJtuQYP8dkUH9QUJivXDqPtyecuHpRvcJq3laBnh8+zNmuSfdRfATD9DDMMDAIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKZVfJXtqGTiTtYJ+wC5H2YQORO0ufJTFtnNNaEdJ/8=;
 b=hQmBbFraLmZARXCja50zrRETppn7MNVyI0ICpII8/L3Ot+jxXfETCeEXpNV9ic5CGOxzqGf9o6Pv1uF6izuXM0WYVZ97NZtjVcBfM2862awyLcODWCpbYoVKtr//yucJ5lmmcGKg+fEr7vz4BMnLLsFwo2QZO9Aaryr+c4bgGkEnVLldmPP6muzLRWxzSPbC6GXURXFMjCLHUQFujhf3AIW0VRRzy0ggja7Uhu3xSmjAg2D/mSV7C0QlMZCO+UbKJg3InHyC/fLAS2O+bwu8pKhE4f3L6bP8m7aMzWQzVmjko5jDKjV5GYlKtNhHo0dK4j82FmdjbhHfe7dH1b2oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKZVfJXtqGTiTtYJ+wC5H2YQORO0ufJTFtnNNaEdJ/8=;
 b=rc+mKVoVuSi34N1yuyZFxHh4UTeDAUCI+MUDSPfMeVHw02zQGCoCYdUv7w1+h/JtqcyKBweiOwZ8+6jqTWUpl7G9nByu8DuLxYbtYfqL1mt31kNrrGauwS4dtPlSrP6CGItTktqNfZ1P29SS3H9m5nb4hAIPD61U+4BrziIjoY8PPt9u+sij1xvLIqZRhpBeASiSboXAuO/KWAjpg5EGgdP1gOfZEva3IdVS9T7IMk+IuklJ1rfuf04+8h9q6jtunhz3hfKi2EKMNXDcTRd0OxxHYCFRtnu5vjWRB1uXrdnCu19X6RYpjNxgaWC2BCX+egK5SXw7ieAmEi5DYj7Elg==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 19:50:43 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 19:50:43 +0000
From: David Thompson <davthompson@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>, Bryan Whitehead
	<bryan.whitehead@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Raju Lakkaraju
	<Raju.Lakkaraju@microchip.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
Thread-Topic: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
Thread-Index: AQHdBYlmPVguby1zX0aKlR4mPUIO37ZRPsFw
Date: Fri, 26 Jun 2026 19:50:43 +0000
Message-ID:
 <SJ0PR12MB8113F67510A03A9486C8EB26C7EB2@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260626163218.3591486-1-arighi@nvidia.com>
In-Reply-To: <20260626163218.3591486-1-arighi@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|CH8PR12MB9838:EE_
x-ms-office365-filtering-correlation-id: 823094e4-51cd-4610-e9b3-08ded3bc3555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 QyZ5MuMIwF4/mqio3yJmkskurrOb1QLOhevqD1vQfmgFqpLgUUXQZHX7KwriW5dhrnV9K6Tf++d9TAtv2mkmSU70+nHXpP/YxhCeo4+mmIeBjbf6/9/lkRzXpf7Fl5/XW9yvVNPjnqwBJNI+dPClBP/QFwS2SDEaHPYzl21eMKYJuKsi6TI9a+ukj3Gjdd4oMmNFaCdQRUNMLRzAWjh3sxbf9R5W/DPKFfj+Ea4NNnmxGVhbIyOn+EAgS/pYrOOt7usA3gM2E4v1xZ+2ME39te2eMXyAYtzQOKrAJLG1jaJqU6L4zmdycCuYNPX4lL0NAQVngYH6Zs0ZzLpV1/Xt8LvJ1adGJX7ho5eLyzGeI3PAHwoJeLngrRmXsygPFfjPC1Zbsqq/Yeew62tuGhOBzRzBcJyzWoqVOrmW1ewEV9BAMchWUtM8r/Wm8xikGCvHeHDUjQlpLK8YyrBs28gbqb1Khbn6ppWtCV3seVk5Xp/0YwuozW5yC6EKyri8UeoISWKo6t+0Huwo/21wU29kixDwxAi/7iLLKrHALRDR/7SXhQ5av6LmDDNGxH2cq5CNs1ogavJdI1tQlNSmCFWhiueh52+CiWCtJqXcZN7BxhiBYR6w9ygUVLlPDxX04rlPXdEY5F6JeTC4tqpZXp5ziPbwgYU3C9UQYBW+P9GxwyP+6K1q4PSqx+Mbw5Kj0jkybM3pVBEhmwLlrhFE63drrdJ6rPVzAKE2l5TaproNacw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3H5OmXbZHMLhAT+fQ7F2Zj2GoO/Yi6c8f8ePMDOQMj/4ncKRBWQ3Z9WEPzaj?=
 =?us-ascii?Q?i80oAy+a8rjppvNhLjTncCf3oUPGXDJyUu1E/Ax8Lj8VnozJ6wicTi79DtOe?=
 =?us-ascii?Q?AoTJcgkOK1zvCKZSDfIz7MsQBeoxeWGo0VrLiaS9SchHsE0dH3uAXWG/ArPB?=
 =?us-ascii?Q?2i7UFW83MymKLVgSFtztIYHrrrh80NivI+dniGy+pj9uasFK/0tqpqaab5W/?=
 =?us-ascii?Q?b2Az+fsTt/DwLTvh3wzOoUIJOfZo6Y4n5/H6PA5GfIKeVUW+OE6zSh5FwXy6?=
 =?us-ascii?Q?jy5Qz/PKLv7kF8RDwm8oxJgnAXn3qMY86xAoUnHC9PGKP2kNm1iuf5BoIchr?=
 =?us-ascii?Q?GSKuSXCrklGZwC2mrORp8v4vYgGB+PQdukiCLafWvAN6yDbSFPjpOZQPB75K?=
 =?us-ascii?Q?FlgqiSNDsHHI1enTXVfuG7/WMkmMAXXp9/T9gfjJiHIczX7lm/Id0WuGrAQB?=
 =?us-ascii?Q?PfzykCwY2grZ4482hoaGRgoIWTG3ReSucW9uOUSx77iPaoOCQkoxBUwBLEkV?=
 =?us-ascii?Q?TgJiiMspQt9Vgx33/MWv5bGqty2s2o0ViABsvUAPOx/lrGbGXSuzyewHPXku?=
 =?us-ascii?Q?biEkSvlUGuOF5k9MouvEcnEifb6weF4tfdQXt8APOGMa0j6lMIz6CzknWL/f?=
 =?us-ascii?Q?o/EB66ei1XlKoE2G39UGmObHFbuzquEIOH2+YmMUHZY91RPqpeJEhu0IfZK3?=
 =?us-ascii?Q?iIjNiyJgo3Dt2BpqBHOBtFXyZfa1yiMxLptEGjmH4U1XPMGlfHw95otzbZ1y?=
 =?us-ascii?Q?7l5iEfVDTUD5Y43LPKJ/urtIq0Osmq1SqH8wI0lRdyPo8bRZDMJSE6afokkF?=
 =?us-ascii?Q?/lKCfR3ihoGzR9B7bWA2lMGtKI/FBEarEjTcPLMOMHSCWqwDJwQbf/CmAcrw?=
 =?us-ascii?Q?7XAA8uDR3tz8mK/kpUAEVojeS2V0iHAgjEhRrwloPpHhFit/n9Ppm0g41/ey?=
 =?us-ascii?Q?LLO8QXZp2+lnNVI00Qaj4Evx9cGGad2wV+Enq+lJ9WmY7kfOHOzMOmkFuf9W?=
 =?us-ascii?Q?j9Nym9SKWZVFOtRSiJLtbxODz1jHkTMwRqKZKZJBjjqWnHkWsIjBix9Rh0l8?=
 =?us-ascii?Q?rFxPFOJLML7NHiBGTkCla/tsHAj7RPIx9cj6+gFyxMU7KeaLKVdugOLJMP9i?=
 =?us-ascii?Q?R8klFzayQ1/e99+Y4PrsWBDZIA/onsvadc035Cv44RC7NCz99DYSO3Q+vsYJ?=
 =?us-ascii?Q?FNRPKk8ANwCqEH1kBDvj2adFgyB4N9pNO6OR6oMf4w0PB9U2WQE6XcTZmL1g?=
 =?us-ascii?Q?pldu63Al3ewIzvDrGlPDdGmbSnWTUKkt1+733tM7C5ySskZLf74+bEHMAb5e?=
 =?us-ascii?Q?d7qukkW9WvV72ySuqYEj0r8oTo77BSMG3m1txiANF9KzdHprDMdQ/dQ6s0cU?=
 =?us-ascii?Q?aMfaAKR8KQSepA6N+Wxg5Wlo0MOCrIyiLWr/KkcI0qzwy01lN3Wm82IqKPhP?=
 =?us-ascii?Q?F83WDqUBTrVLi1ZPVyC8H4GYw1SBDiURVlvmglfZSJ1kQvgnADp0hofVlkKR?=
 =?us-ascii?Q?TiNLZzTTSALDryDH0oVkxv5bX//6HoN1pculO6wXhTEhhm9cjzsVzWzGNa1q?=
 =?us-ascii?Q?ccolWL5OcUz5omHWYnf+dskeRR+phdjTS1pUIhfIG5BPLnEVTPoH7kwt+Onv?=
 =?us-ascii?Q?xVG9M/KDcN1vwSO3mA9ZcxnIT0ELz5fN+/m4Cf0THfv/6LOIkoohGlb/13dn?=
 =?us-ascii?Q?AygolQM+iGVb5v9LgLsfjUtmBR7vf7hjHjiud7U2QrXzRvl3tfgXSdObW7UK?=
 =?us-ascii?Q?Y8KbkDUbCA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823094e4-51cd-4610-e9b3-08ded3bc3555
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 19:50:43.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozCtdefExaIIzp/s9YqRwI9O39wvCBQfBh/UV5kFKFAcDrCFLuCgrexfwFr7PstebunIHdpvtWaW2lssYGVFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302258-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arighi@nvidia.com,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Raju.Lakkaraju@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:email,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37AB36CFEB9

> -----Original Message-----
> From: Andrea Righi <arighi@nvidia.com>
> Sent: Friday, June 26, 2026 12:32 PM
> To: Bryan Whitehead <bryan.whitehead@microchip.com>;
> UNGLinuxDriver@microchip.com
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Raju
> Lakkaraju <Raju.Lakkaraju@microchip.com>; David Thompson
> <davthompson@nvidia.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
>=20
> lan743x_hardware_init() calls pci11x1x_strap_get_status() during the PCI1=
1x1x
> probe sequence. That helper acquires the Ethernet subsystem hardware lock
> via lan743x_hs_syslock_acquire(), which relies on
> adapter->eth_syslock_spinlock to serialize access.
>=20
> The spinlock is currently initialized only after the strap status is read=
. With
> CONFIG_DEBUG_SPINLOCK enabled, taking the zeroed initialized spinlock can
> trip the spinlock debug check.
>=20
> Fix by initializing adapter->eth_syslock_spinlock before reading the stra=
p status
> so the probe path never attempts to lock an uninitialized spinlock.
>=20
> Fixes: 46b777ad9a8c ("net: lan743x: Add support to SGMII 1G and 2.5G")
> Cc: stable@vger.kernel.org # v6.0+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 1cdce35e14239..e759171bfd766 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3541,8 +3541,8 @@ static int lan743x_hardware_init(struct
> lan743x_adapter *adapter,
>  		adapter->max_tx_channels =3D PCI11X1X_MAX_TX_CHANNELS;
>  		adapter->used_tx_channels =3D PCI11X1X_USED_TX_CHANNELS;
>  		adapter->max_vector_count =3D
> PCI11X1X_MAX_VECTOR_COUNT;
> -		pci11x1x_strap_get_status(adapter);
>  		spin_lock_init(&adapter->eth_syslock_spinlock);
> +		pci11x1x_strap_get_status(adapter);
>  		mutex_init(&adapter->sgmii_rw_lock);
>  		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
>  		sgmii_ctl =3D lan743x_csr_read(adapter, SGMII_CTL);
> --
> 2.54.0

Reviewed-by: David Thompson <davthompson@nvidia.com>


