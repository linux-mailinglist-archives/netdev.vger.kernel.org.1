Return-Path: <netdev+bounces-213016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93332B22D69
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFB5188BE7D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517752F90E0;
	Tue, 12 Aug 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CC1u8Gbh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CF2F90D8
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015699; cv=fail; b=n7p2dp27wykLhBjxviMjR1h4kW6tiG4bH6otc3Uz1CiQaxMGxnA+px5LbA2BPr6BSP5c44MJCXAJnZcLiYNg2iK4BfuSLzeQGwSOSSL9+i5gH3zbsmt5XOl8Grb6zEKbnm8UQ4rUFkmfalO/wubYkFDrO1AGzH9gnPPTKWyg3lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015699; c=relaxed/simple;
	bh=A0PQG3gcDiY7xM95UVmlsDPoYs+UmWoN7ToocmKYOas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsO+HgexzEeZc8bcQChD3yxh5rKeK/npue6J7W4Mq+XOCuqWkCZL2s/YumaEmx8sFroZE47mbaks0aBCJa0WBnfg0W8LPXahbMHe5/AUQmsnncUbFpICUvwTb4Zi271zz38ojYMpKI4yxRFbEBRTDKZZmt9V7rudXKoL5iu6TBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CC1u8Gbh; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fheLIwO/FyiRYdxzovN+dSL0IaI6dGABz4OHYloCvY35debKnKqa2VLp+iaEMJmAIU257mWw3cYzBzakRlGj77FVpBH8H8Cg5jP1RZHP5KmUXGuWPfEQfgc1/CQALO5cw0zfu0s/W2F/LkSiw9MYPUaCKcoFSUS1hsS8XGULE6lJHlewU4rCCC2FJL92FDVPytQCnYii/l+a9Tx7PUlpu4HrwiS4xAlFiyvwX32U2MgUmv7BgEX8acnRlzW2oWs5UVpyYC1j/uDr8h9yVBQHAXdiTxPhXgJ2OIrdvrITbdxvULLsPMlRuf+Jl+2H5HGBN8POH7WVpDkX4siJL5OIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0PQG3gcDiY7xM95UVmlsDPoYs+UmWoN7ToocmKYOas=;
 b=dttETBftpIGkfL+EqkqPSIxTsdxaMVjNd+0RtWAc+TwaH45IVjeymYURUvmkecRLxmRvsI5qj2XTp5Tb5NsDBJMvAbol0HumT0HHpn9TAn2Cdyz7VPrBvyDbjT6WV8l9ubPuaVm6sZ4XerSHuSLH4lolld9ZG7mjNxsB7hNlifN0/JBEy9/MGUojuIHP1ldP2dcDV9DPREelgOyMV/pqN3S9vg3Ef3LgpeGVS/xFnfP1OGrs2JILozVl79wuN/GHcKOBKo2fxXTNf9z6rZSL5MfAZ1FB7PdqjMXJRSrVLOzHOFCEgp68eJBB8KvfgtPM/5lXssmB/j4sAWHPhP0e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0PQG3gcDiY7xM95UVmlsDPoYs+UmWoN7ToocmKYOas=;
 b=CC1u8GbhnCUgIkz6monmVUt+PlYXgB3uV5uQwWIkLGNHiqK1nwVGFJXvCVJ9sWv0q//gcFhvReyNjBVbpCOGNyUxWqZoKzB8t3Quv0zt2HsoRt41cuHDqag8wE13HM6hhCOqs/jTu5mAc3+Wz9ZB6dvFlzImS22qU4tH8CmnEjgRQP2CMdwt8YE+BbH4rpuaQ4zNxUKdZaf0VsKgk9CuLwaTL185oDqGEDPN/VlOJ7NzUrvMRuK3lwp33RW8EoSGZnz4+6P7/N0f4xevbj94Z04Hb+jtx1d/EQv6D1LT8cte/7VSF7vRkkIzX/1fap4RFENJwD2B9F/0uDvp/ZHD7w==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 16:21:32 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 16:21:32 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next 2/2] devlink/port: Simplify return checks
Thread-Topic: [PATCH net-next 2/2] devlink/port: Simplify return checks
Thread-Index: AQHcCzyPHvjqE6MBfUC/ejXt7sctwbRe+3cAgAAMQBCAABHgAIAAGgoQ
Date: Tue, 12 Aug 2025 16:21:32 +0000
Message-ID:
 <CY8PR12MB7195DD5A5016A7F401467132DC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250812035106.134529-1-parav@nvidia.com>
	<20250812035106.134529-3-parav@nvidia.com>
	<a3f91ab5-d9da-4ef8-aecc-8d1264b8bf6a@linux.dev>
	<CY8PR12MB7195C1ACF298C258BB37E759DC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250812074732.1f76ade4@kernel.org>
In-Reply-To: <20250812074732.1f76ade4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH1PR12MB9621:EE_
x-ms-office365-filtering-correlation-id: 61c7698e-0182-4c54-2f0a-08ddd9bc4cc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c5s3woCgnU4XMwhLROOL5ikOGv+rMMGsMHX4ZF6C2NvgU8Aezyk2XHBuEjcm?=
 =?us-ascii?Q?ZjU27rH5wXXx2cUok2W6ttyDgLoF/Ls1EgA2z0qP2H7cOp06+4HS28v3AN+O?=
 =?us-ascii?Q?kTdtQIR5xYnGy9ICMKgoG9qi7Hru/8ZgrRoE1JRDqZ6D9J39XfCpmmwdBfnK?=
 =?us-ascii?Q?unoxciTXT2hAekR81UtZhDeKbMPm6E+WvM1L97Bh6lRKhbhmmrrPqheSxB+s?=
 =?us-ascii?Q?gxqOaWM7tXZRxtjPZlV/+dIszDp76xs9zA90X32TQ6/vxZ7qOhch2gE8eat0?=
 =?us-ascii?Q?NyRkTdGMQbH2XJO2bbnAJJgWGL3z0DzvFok3BCjN3UZcOPQG4g40vp3scF0Z?=
 =?us-ascii?Q?+pLvE16weTwalmTOTPdZoqwbFjXxV65ubZ3gzeNM+Um4h2D309mfHtcVRC5Q?=
 =?us-ascii?Q?VDj/CS3RFr1UtEC7pJh250C0gcTNG5cC/XaB+XDkOI17Mb/xBKRTUSMJCiDu?=
 =?us-ascii?Q?83DGXQ/Gl/uxc/CVtA7U6axnQKiYeeTBdb+niCwv/oJmHzepn5DhI5DSjzYz?=
 =?us-ascii?Q?tSkBf6cDbTfIUwPSTmztpMjFAQjMiQXX66OhFObnGdyaHpgETd/Ji0zkcBHD?=
 =?us-ascii?Q?OuMNTxkwm8Yd9q0DoUx+Zr1sgng+UxxifU+Nxk4NOHGRrRDE4qA8jjrqX5PA?=
 =?us-ascii?Q?uPZxqdus6VSs9qgn849eAZEW7TEY55g3FE0AL0Q1G/vNN5e0IiA0Z4nKdz9C?=
 =?us-ascii?Q?cR2RNTlpO9jo/9oiOGdu9uvtOFeLS/xjp5WJ2Sp0MDVK2zc4OBjZAksul0mZ?=
 =?us-ascii?Q?FOBojWrQdvFLw1xt5lNn+B71IjY6/pREM9hmXivFDP+zXqCAKcQoO1PPeWXU?=
 =?us-ascii?Q?0HN9u59WVcrOlHUp/H6Ir0VM/3XqryAqhUEiP9JC3QJbq87M88L+PGUTIjsh?=
 =?us-ascii?Q?m7lG26NRsqiF9x6hLLlOvtCuGsOK0dtv7U82lhTO2GLhbqdMYYrGqb30iUz4?=
 =?us-ascii?Q?MXjtMReUDXmGzwVW3X3SpfaG/e7pynYUYY6oXKfa38fnX5lXfMxXBE3c3D/l?=
 =?us-ascii?Q?hIJ986v2Gx3G294FcW4xW0bA78rVWauBUVqkWq/ygwn7+bZKWTQtmCpfdLv8?=
 =?us-ascii?Q?OqnycksRAmomJeUdjSQIGUogvJbkAu4Bho5hsNt63yjhyh2Kr8f2N3/AUJo/?=
 =?us-ascii?Q?dv1jEv7Tsa1aNorLXCSSfPUAdZ+h+p47AIV8fEtWjguk6RGtmDL89qFEiAl5?=
 =?us-ascii?Q?u/Mi8wLPOXnjY0NtGsObaWICsgoFLfV050XvgGIcZc9ObdkKECXj546p5zAj?=
 =?us-ascii?Q?NZX/MO5+WiuFdKo/hQFO7PaF4x0UTdcPTgq//kkVayjqbwTLhMz8bx0/+EBP?=
 =?us-ascii?Q?0mYate78t2Gj1V+XkuTnl46b/NWoq8XC0LadjLpZ8I9vhClb7usbsQmhk0yL?=
 =?us-ascii?Q?kRFjnpYC3ddWr0m6KvMBJsE4HdkysCYDc7NQpUpdARJ5s2jTj5gspgxdRBh/?=
 =?us-ascii?Q?rEGWHZzMAXSMI7jnd+bxU5/ThOFN4gSoF9x13EsaWcwnFpRRYa38vwQhO6kC?=
 =?us-ascii?Q?1eyQHLhN59kk0+g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DvK2HGwMM1i5b150LRlqP7jxOLBJCUAcRpXKndlYLJKZsLQGvuKxDLVR/mTj?=
 =?us-ascii?Q?AVTAfheryTGb+x/DXNg6RSTJd5jJJ7IMnnsUG6tfrumR8/aDo1hs0hoeIqvI?=
 =?us-ascii?Q?USzz5wzrVaIPKS5pTyY335vgLYgfa7y0GqqsGb/yYR0rM6fSZdF7Klu+kW1D?=
 =?us-ascii?Q?fkrn/r5JfljO5u3MIszy/+tOMRB0z16iaUR8V9u4PVsscAHVkrNu8pYSOWLP?=
 =?us-ascii?Q?jsoEO5PhQandsVwDifMNC0p1pQ0pzbKaiWirNVu4a5luNXVh6r8yEInP8G4g?=
 =?us-ascii?Q?9ibfL94/W415UcK97mCiyOm6yGdkim//YZRMwdSXeCYLKVerAOp5qz6PaTzp?=
 =?us-ascii?Q?MKlSiC5zuSeT/3tJHplXM2vQdwzxTrFlZeS7LnIEb7BK2n98YAgx8B/O+Bmj?=
 =?us-ascii?Q?gpsfTqqZofWy7/9XjKC2YZSm3ZWT57A3KYJgtoBXe45I113ZHiwT/ZsTm0Dg?=
 =?us-ascii?Q?HtNBpvAevgaDh6I0ExNvs6trLWzH3pVfJOiMi0dVC9xNtCUWs0Tw6BFLX8ue?=
 =?us-ascii?Q?fZx9aXINg/J1p5w1e4Cxg/FovxWC3Ylly3opgf5/KLaja5hMSB555X9Qf0nh?=
 =?us-ascii?Q?rEjpP61fsJOa4n9eVG8hBl3pxhAsdwQbB1EieB5hakmZKvAaL/hA+ZucJypX?=
 =?us-ascii?Q?/Gmtjn+cOOgm9w0mqsLvwVrHg79llioArSKZWOnJLTGNgBfOpi6mj5Es4G06?=
 =?us-ascii?Q?o1mLXtD887fA9TrlWNRWctHHqrchn2CniSXZg48rdxpk3vlfSOubXBw2ybKb?=
 =?us-ascii?Q?D6OjPlq2FK3A9jsdHCu5jAyrPaCu5QBu+vBBWFxHHqXGK14gilDfwNQeHa0y?=
 =?us-ascii?Q?5gil7125iNM/xCtG+TsKYv6Vy6cSzEygQmu4vnbZadk4Osj4V1YwP5s2MsAQ?=
 =?us-ascii?Q?06+KDdBJs3MHzO5CwHjnso4zc21yZEQfyHQR34nvCRfmqB5WQLXhJVpcipZx?=
 =?us-ascii?Q?A0Q2eguzgZAkXR07QXeMrJenAYw4Qh7vEDN3HUwM+S4Bys3Gcl9RpyNyQxaQ?=
 =?us-ascii?Q?HeetYSBYSIFZJawtTSWGmhwX/6xojP8KrXEhWZ7ypaCItjfEolYnBjUdJbgU?=
 =?us-ascii?Q?NFXHp9P7PHMWIo14j5tV/ekk0hBytYl2nYz/6S+naZfE3zkt+1o/otalsDp/?=
 =?us-ascii?Q?6Z/dac5CAeE+DSRQtY3wZy03prUayDYb6gYrK9kpO06QAI97W27KnkuhB4ht?=
 =?us-ascii?Q?YAGc/qthwboihF/RnPk/XmznrvxXGOzS6C0R2nBM7KPx9hGIQ9BVkv4YGuO2?=
 =?us-ascii?Q?S0g0T5ehflQbHxQfYKlK+btfIy+GWT6EByEW+jboNB6iRntLD/yF/f2BfE2G?=
 =?us-ascii?Q?vlYr7ZbenslxQxtH3ZVI9f8DfIiUeWrj8h+i/2lVjs6LTa53VTAxlqEpNDWQ?=
 =?us-ascii?Q?9OA3tT5thndHAJSgj6ptNB3i16gZkqAVwoLcdb8H1wOBXfg8rbVV5lWtAMYp?=
 =?us-ascii?Q?FqZluiZz9vsohw/bEcPC/B2ICUZoTsG18PtppvqPhtZrF6lIw2UI2YFtNKt9?=
 =?us-ascii?Q?x7YvzVokwXMhijqRVxx3AIUbyqoAI13+EutfHCv6b4d5UGtqRY922zqx6lKf?=
 =?us-ascii?Q?7P7L/4buy7IsgwdcEp0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c7698e-0182-4c54-2f0a-08ddd9bc4cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 16:21:32.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyrJ1WJWSy/cOlpA6AzTR1xNuracZM+uP99N7W/u5subuws2sAEaxJnuj9ZUfYHQJc7TU8gTCpcxACNigduhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 12 August 2025 08:18 PM
>=20
> On Tue, 12 Aug 2025 13:45:09 +0000 Parav Pandit wrote:
> > The general guidance was to not do multiple different types of changes =
in
> single patch.
> > No strong preference to me.
>=20
> It would probably make more sense if the order of the patches was inverte=
d.

Right. Will send v2 with reverse order and addressing other comment.
Thanks.


