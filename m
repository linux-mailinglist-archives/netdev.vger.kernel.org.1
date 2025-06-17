Return-Path: <netdev+bounces-198784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFCADDCF9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7325E3BBB1B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929482EFD8F;
	Tue, 17 Jun 2025 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FTuaRWzW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92A2EFD8D;
	Tue, 17 Jun 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190866; cv=fail; b=e4de138DWupwYFhrRlQ1zo5YMuTki9M3gqlLEyCMTIKapbsMjbUqCwANNqfe6hdn7aZkWBrs0s0qfIRHOrcVP5LtZGjSHXdJLbDVA6EGfZx0OQXxKlvqZD1mLb1+74kQifB3HKUlYiLoE2qClSkfIleWRq2YZXqCvRZ/6GqpWYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190866; c=relaxed/simple;
	bh=JmknJOj0/awRX6AspOaVOV87DVQszxfqu5G38paMRoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cdsl8QzFbXT4N6w9ti5BU4QDqkRcCXklc7dTFBKtQswHi3U4oaWudo+Q9/z9XRu5P5E56Rbs4eSUYiiO+IlBwSdZKxBHkuwE8DOE4tGXDTISp6pggKr6DhFN/AgxZM3YlkF0cwq4Fl7feBscnjPpcDu9mNMoM0ab9va5vtIXQvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FTuaRWzW; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZSOqt9cpdXbtvWc4imE/ujukuObVCooQuKcRtQhCJjBYojv3bZUZM433iU0zv37p+OGQm3Rv2304fIUdSyaoYLBm2O8+nJb/IfzDgimDmySdljONrciI5IVBllr2EsbTGVvLQPVajgt+e8NpnclYqEPFQXJ7oNHrGorDL0yYB6aSYTNa0Mxje3gj6Hr502XuToCZ/UASP9wp4YODQ6R8AqUiXN27faK1cWdakEFAq4tQgIpPmkzbakHKbCUiB61wzC5f8Ujk7f5El5YRsb/8WULNP4K7kV25rsDlLF6ttYhPAwQAX98qAPpn3q2sOq83VLntKvQ6anKrco5+8tKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIMx8493WWcxnpIDgqMWV9os9QrNOYLGslYi580AH3I=;
 b=Z5M0sY+9gJqShJHTjIJ72GO0IMfjbWGatsDvMhvocX2RKfLEq0XT4OpTz7ZGkq6mDkpSj9TyHaiMaHvl04kCf4SeDJmSvw2OHooxhuM56IIW/6g+qyr/OUIjetkvTjHYutW60TAbgzQDrjhJRpWY8Xm2MphCxCnTCnUHPf6BpnBLW8WAy3Qi/FHeeiDJwS61rFtYTZijuGwMaRJzlPUkBWOFQC0gXjVHZOsBz7veflG3pmoDHASXQf1tQAHiEyDKA9Nj81UnLdKFGov3to6ZIHR1eu8B9ft/pNixyDsuTv2TTP1xTgnjSllqwRm5E1XmSa0Gv8DmdpO7kSbASze5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIMx8493WWcxnpIDgqMWV9os9QrNOYLGslYi580AH3I=;
 b=FTuaRWzWGRHLBzVDRUi1DjIZSfceZr3iJ1zWV4RxZsAA7BjzoOedpTcEC6IJSKpEVobFoor/DLetoMI4Cgntd26WXc7XR6dZCjQt5b710CQh/AqddPLlPNssYolVNvjl90T+ccVot1F7wQYDXA8WTtUcyEG+2Dbf63wrQlZU5v3dg6PhchCISV+RvOpmnT3ur1WJo2CH0DAENV1Nx026+yBbCyCzVqSnSTh1qEUd1CLh3qEVycwQ6tbAtOVQF+hJRuTGZnMqw/n01X6JhZBTGe8DTvTUIpgOusZiuCJWadDykWCq0g01CQ8Lo8AVcEI89qQ2LWhqtrfqWec//VQbBA==
Received: from MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 20:07:39 +0000
Received: from MN0PR12MB5907.namprd12.prod.outlook.com
 ([fe80::e53b:7416:2158:6950]) by MN0PR12MB5907.namprd12.prod.outlook.com
 ([fe80::e53b:7416:2158:6950%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 20:07:38 +0000
From: David Thompson <davthompson@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Asmaa Mnebhi
	<asmaa@nvidia.com>
Subject: RE: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not
 available
Thread-Topic: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not
 available
Thread-Index: AQHb3JQ+yoBgbtPSAki9kwha4ypgD7QFv8sAgAINa4A=
Date: Tue, 17 Jun 2025 20:07:37 +0000
Message-ID:
 <MN0PR12MB5907DC095A95A1BA1F2472FDC773A@MN0PR12MB5907.namprd12.prod.outlook.com>
References: <20250613185129.1998882-1-davthompson@nvidia.com>
 <20250616124502.GA4750@horms.kernel.org>
In-Reply-To: <20250616124502.GA4750@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5907:EE_|CH2PR12MB4117:EE_
x-ms-office365-filtering-correlation-id: a62da135-b36b-4e49-717e-08ddadda9b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ukltuWrybfA41qIo3P1HJgZK30Mdve/WmJt+U1gJfaycOaaFFkQT2C/1vpYl?=
 =?us-ascii?Q?iOSyYu/WtqDQJFsLnwhCiiRyzEJ00eBKd6/HU6+HzdRKQMAlvl799x1P+Wkh?=
 =?us-ascii?Q?bk9zk9xQ3h1Ps2nq55VxbdMp+dR68fFgBCQu67/7Te3yxBR950dFolRiC0BK?=
 =?us-ascii?Q?2ScPaHoYV5idQRW2lBNCqOPmSR3INTsXeQR/c9UazDBMcf6WCpYUwF+vg3FO?=
 =?us-ascii?Q?1n9q2ie+CcfRQTcWhXcErK8vSJgwEkAEqbKlWqphgQrDW8klHmRS9/mm8YKm?=
 =?us-ascii?Q?OCcRQADuaQrIhJgdfeSXlmGaYWjPVBG5qzPKMUBZpau1OJww6U9cbxo8dlsh?=
 =?us-ascii?Q?SRe5qF31zzQe3k0V6UIWJez0xlUjmCzNI31G9NxYb7PTs4ACRPA4gu3IK4Vi?=
 =?us-ascii?Q?jx40Y5bElOnkPoRK8ewK8o3ziotE429HdRm+RURziRRkW/x3nCOGPJJ7S+gA?=
 =?us-ascii?Q?B4mISEGwa/QPMWZx52gSGmJ9Ip67TdWLZh87FirGTlrjWuXXlMIFnMjzzdNe?=
 =?us-ascii?Q?5EESy/9ktKauT9a1T0HhVOU8v64DzvP/RcwYrsWUFeVhJnu7rMfpmBbJSvkh?=
 =?us-ascii?Q?hoJI9vQ2KZ9bAYVUqcq+RKwz87GkxtvCZVK5IgJ7zT8bwEg0F0deNySeF+qV?=
 =?us-ascii?Q?YN/HjJD3kSY+zili6FbvRElOqyILp5SQdIRTIibUwjXH7BrOPMOlhlnOBPjS?=
 =?us-ascii?Q?t2wTDwv5XGshZ7J0HPhHULCCt6BH5vJgij0OTwlLtnpyPyOlCKkV8+LSwYRo?=
 =?us-ascii?Q?5KYdUwxVh9FuRgauoQxL1vCEnC9vVK0Rk+SJTEialxsbIke9XkKXT8eYVJHg?=
 =?us-ascii?Q?1SH2JomTQZBzdseUDt/UqkvtjQ22NsY6rGsJNSJ8tkwQqu4NMqrfyZi5+Afx?=
 =?us-ascii?Q?wG6B7m5TzfR9xVdKSHCDuZDF7CPOJog/9hSJ0NvR3wFo4iR34KlqNFV6IPu8?=
 =?us-ascii?Q?WXzaR5O7mg9UWLWzypY/I6kZBzXTpaGtg0zvKfl2OclulDK6GfTfm4rqP2f7?=
 =?us-ascii?Q?Ex7gx2EWmLtDb/HzK+p+0oLurkf0WDYqwV589ZmyjMfxFyTofoqG+lWvITjh?=
 =?us-ascii?Q?vnzSjW+tdRk5tvw7bkOOPE9P6kxCNYuq7GAadYykEOWQwLf6JM8ye0H65d50?=
 =?us-ascii?Q?tDmexqjNsJkCuyNxrgdLWBFNNRCELP9Zj3cv1WUHVWILPZw/KMGrqX39xSuD?=
 =?us-ascii?Q?NaOdrI+PumATsrKGm0b1f31VATkUidTBMYdDkI7kzzFx/VxxFX3H7xBr3Ea0?=
 =?us-ascii?Q?Es2NBR/5bFy3j+FzYJAH+o246SxXeNU7o/v6OT2Wv9ZDIma0a0bC0fDS7gkK?=
 =?us-ascii?Q?SreqVXdFM+UuxaBdzeokz4RLRmXr3wgQA17HCQmXaduroYQtQZ9oNmQ97EYn?=
 =?us-ascii?Q?6VTewxk1fnUoPAxdHqshf57A2hSnuJmTkOZCCIagotSaR9JdLXuEWfm8MZ0d?=
 =?us-ascii?Q?bOU3zIe2WcKACqlxoxEnkoshzSZhlE+XYumA02d9JXT5AJ2LPttttA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5907.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cadr5Q03ruqT415ho6Ru/xXbZ0SPumoGROERijqjk3RYqVXgwTI4sBoeVZkA?=
 =?us-ascii?Q?hmJoGAvxnFtek118ifYPmwy4kBAlOiiQJzG1voKRtIyuHYIIC+CceUspGr76?=
 =?us-ascii?Q?YTVkWw/spvV2+G5/svYFLJrY6spN8+He9gehotgihV7YGD+9nH4Aaj5eaNfr?=
 =?us-ascii?Q?hw9vmpJw6b9gEwcJyEGA61tkXubOxfzh9tldgEZ1KriJjealVRIjXpMjnrRg?=
 =?us-ascii?Q?wg6wScKB4q5XoCC8eYbyFt74IBlqfocmvRTTN+iXiV5mgfgsQJW6gk128Fwk?=
 =?us-ascii?Q?J/tPNaAsORgNCYe20V37O7H78oYYs3mO9twWXwtNY+UMDbmx/46D5zLzfwGh?=
 =?us-ascii?Q?DkX8blAV5wqfCufG5Gs9WkDhKpeyhlEOsYUlbFD90MrNhmxE+HmCS3EPH/qt?=
 =?us-ascii?Q?1lsp604xjmZftY9+2nZRZSWC+Dshr2EHge3aCVbipcWm0YvySBs44q+ensNf?=
 =?us-ascii?Q?2BrNHn4NIxcy8o6a9naGMSeh9JxIA9MQxZc7kx4D99sJgewcdh6dcqbLxq+h?=
 =?us-ascii?Q?QA2kl13BMgNkcXf4GRFRyBlS1ZvdEUr6aHy9dDr3bLp+ypmouNc711juMUYS?=
 =?us-ascii?Q?WTBlGy6xKtBJkFfGQz8lFxhrDixJzuK00GZuw643jbqETS+XP8MtaCOMmH7c?=
 =?us-ascii?Q?KCtaNpm+vVN24ucHYedrRGWbMK8zTD8dm9mka27K5DNapriSgnkKlopCSmlv?=
 =?us-ascii?Q?nlbSNlypaGx8pTvZ/vlUkng0w0409yqbyuhxqtDas/lASqcPp+ZJT8JwiRB5?=
 =?us-ascii?Q?Q7Kc1r6uumPzECBqVAV2fTzI++a8TRgGm3DaD2e+2vSRTUgr6/tfFstY1o62?=
 =?us-ascii?Q?EY5y3VOhC3as8Xusod9U1+BJNAGquxHQKJVPLZP6bwd7kDeThF3cX2Mc25FR?=
 =?us-ascii?Q?1A14Q6Em416l3HCv9XIl75eGAUlIKhnkx+4MLBA5+boTSL/wJmDganIDdIbt?=
 =?us-ascii?Q?BYuY0oE/Er/j1wgjijC9EJDK8LBqVxsoSHaRmQoZNpWSyp0QlcwC75Ryr02f?=
 =?us-ascii?Q?/uzo2RVj9efptWMog9xaKXv2SqjsSGxIpc8whigbKAaIjCr1CBBdG3B3gutZ?=
 =?us-ascii?Q?qeJmb6IhyOtyiKxJs5qiXMSzcjBHm0Od9mhBZmf0BBA12PZxjl7VVURatd+X?=
 =?us-ascii?Q?ioTkXtedDKanK/6h37SHabEXBiVNs6h95eq3QeqYtdGVNJHqFKSeGyeUbXT2?=
 =?us-ascii?Q?eKllXEhIoygbYKishQ0RKGxaQpFhLcNs6ILiiT6Hb4lzXOnEayaHnTJpqSkB?=
 =?us-ascii?Q?+dV4Dme8C4tK1US3h6Ia78rj6i3ge81gs/e5HTBydb995TU9nSlLzIvii08d?=
 =?us-ascii?Q?UeSvbKswKUShNNwy7o57F12daD35ycc5QbbaXZYg5TCIxaLK6CfSNxbTOB9s?=
 =?us-ascii?Q?a+cfOCrBXJpnYXUmJZeY42h9wJGAZmQjmxUSfxft6+dJ2vlWTHIRQNBN7Yxm?=
 =?us-ascii?Q?Tv/EWWMZh0dcN1EocVerYINPPIu9A3K3p64JTYlKL8zM92G0AleKExEWwTnk?=
 =?us-ascii?Q?ta0W2XOQ+Oqr2V2hJT2M5m8IHenyg9KhteaotYxBNo6xr9TLu32bFnOLoOxe?=
 =?us-ascii?Q?d+Dbs+jcH147OI7LS+G9fSR2xWQ5A0wQst8Kdl8b?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5907.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62da135-b36b-4e49-717e-08ddadda9b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 20:07:37.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpLEWdPp/5U8K7THdL+VCMpevOFs1bgQp1eLRq2scRY2bsrVCFLNqcEMjGFMhm1FBtgnZDsmWedRRj0nLTQJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, June 16, 2025 8:45 AM
> To: David Thompson <davthompson@nvidia.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; u.kleine-koenig@baylibre.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Asmaa Mnebhi
> <asmaa@nvidia.com>
> Subject: Re: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is=
 not
> available
>=20
> On Fri, Jun 13, 2025 at 06:51:29PM +0000, David Thompson wrote:
> > The message "Error getting PHY irq. Use polling instead"
> > is emitted when the mlxbf_gige driver is loaded by the kernel before
> > the associated gpio-mlxbf driver, and thus the call to get the PHY IRQ
> > fails since it is not yet available. The driver probe() must return
> > -EPROBE_DEFER if acpi_dev_gpio_irq_get_by() returns the same.
> >
> > Signed-off-by: David Thompson <davthompson@nvidia.com>
> > Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
>=20
> Thanks David,
>=20
> I as a bug fix this needs a Fixes tag, which you can add by simply replyi=
ng to this
> email.
>=20
> Else we can treat it as an enhancement for net-next.

Yes, good point Simon.

This patch is a fix, so should have the following Fixes tag:
	Fixes: 6c2a6ddca763 ("net: mellanox: mlxbf_gige: Replace non-standard inte=
rrupt handling")

Regards, Dave



