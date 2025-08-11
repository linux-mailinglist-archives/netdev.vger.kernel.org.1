Return-Path: <netdev+bounces-212511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30DB21125
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24696E0EE3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB19296BAE;
	Mon, 11 Aug 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZnGFaxW9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90F296BA2;
	Mon, 11 Aug 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927710; cv=fail; b=i/BScnLhEE+AHjAlCjxZ0vMCPmiWsQCy1otMbzFMf79zP/QBgDU1Iio1E5G22l5PGmX5+wbitC5HhNakSwfb1DuPwcCVUQgQyo0ES9AiQKJFMJCaZbsEHM7VmtJVduTWp/FYzLTp8J0LiuBj7krmM+KsPi40CDfi5ELJx20k1Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927710; c=relaxed/simple;
	bh=ZdZuxF3Vlk0vyHmT+efO3ckSFPk57OR7wVPzfWTk6ic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/iQTUeElE5wFi/bViL5WQuIw8Lx0gSQ8z/Af65nSwGF5z18bf0VCnTHdF/iLtSONpIJ/TKWfRfASYmTY/kUgpgsdj83HGgMP9mKhsnOf6jYeYFYJHHoYv6imoB/NEldMvCX2x4yBepoxv/jrbo2tE71NzbQhwmxVJSDCadKC5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZnGFaxW9; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn2n/TTYFPbr2YnfhpLRIt2YHi6Y22OZohhiOurW0UV2xcQfYssYVXAkudH9eBykUawdjAZ+MAP9yZ62+loVGLtIH32lC5OHnbhTLmuk6tHCdm50y2LPKgreUlhMvOY/mRxcyDDpCexUcOeRE+D1lD3DjkbgMeqBxbrBI/NZDMpPgLn6A8GQqV6X0tFmSiSORhWF2Sw52UybjFiZOAraxdHvQWy8kPw74uAq0VOoGMqzAL6R6DX8N7KnvYCzqYS6SQxUN4AHXzVVuGbIEynz8EHZEwwz60AMMkKZyMCwPQ9pvz8hN3I7ovgb7vauan1okEWRTixk7r+F7A38DA0iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdZuxF3Vlk0vyHmT+efO3ckSFPk57OR7wVPzfWTk6ic=;
 b=bdeoEIBLgrFC1SRt2u2VeCSXxToNaR1NnfObb1WAfir42aR5IuJDZ+aXrvJ9MXfnJZrlKeCHRvw+I67ewn3zxfRm8UKvjADIqMS6uBGWEp9T3jAALoUjpbtV37+LG9qhLA4tgyfk5U7Pedh0V/9ZziuAoh/ONGIeAzlyj1YNXFL69uY9RzWtNd07Sw3u+Mgy8pe73EegjND0pWU2PIOVXUHIA7IJnb75md7Sp9tJuaxDN2VOCQGJQLaUbmq22zSdHEEQQpReqO3DqupILZu5runmyo+dRJDzCaJCRnjjOiu8f7GnZbzVmwaT9hTZwHjYp0SqBZrhtF29ukYOFSpYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdZuxF3Vlk0vyHmT+efO3ckSFPk57OR7wVPzfWTk6ic=;
 b=ZnGFaxW9RkgZs9sWRJIu2S2+ss75BP7QSNBSgxzwDY+x1LoFCLkx82nJheGCVGSM3/zWcBhbQX+M6uErlF2U6POgrNpPCEEbdtAqWao9hSmts/zoGNdDnylIByPt6liUcLJeeghxGRGJ6HDXJzD6mpZ5FLlXFi2cvjiHQl3/4ZM=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:55:02 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 15:55:02 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Jakub Kicinski <kuba@kernel.org>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Topic: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Index: AQHcBj33CzCOb/lK00ituSZCoqdfS7RZIlkAgAGqYwCAAtKDAIAAAVug
Date: Mon, 11 Aug 2025 15:55:02 +0000
Message-ID:
 <MN0PR12MB5953EF5C6557457C1C893668B728A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
	<20250808120534.0414ffd0@kernel.org>
	<BL3PR12MB65712291B55DD8D535BAE667C92EA@BL3PR12MB6571.namprd12.prod.outlook.com>
 <20250811083738.04bf1e31@kernel.org>
In-Reply-To: <20250811083738.04bf1e31@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-11T15:42:28.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH2PR12MB4054:EE_
x-ms-office365-filtering-correlation-id: 61896f31-e084-4f91-499f-08ddd8ef6ec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JuId/TqpGx2MNgLSiNq8BqyhJoauYBaCBAfbcO/gT7kx863nba8TPmK+UPeg?=
 =?us-ascii?Q?0g2zDl1l+HzGrRiRrmObsW+SjmDsdZm3ktMzpASlsncnw6xnhlhKJWEWe/oq?=
 =?us-ascii?Q?S8xC3rKeCvGEJSzY/PicyZlSEYABmHnyID9C+VmkEJYlUcbKY8Cg01EKM8SE?=
 =?us-ascii?Q?EPgxIkZyc/7ieehYLm+dBGS6UdnTucO0HxcyRlxYwgg+2CxZ39zXf/M9wwNn?=
 =?us-ascii?Q?jCBz7ktx0YXloQoqZTTYeN+TEMb1pnWiYVrItWTokUCs4uGxoeFFsSDH6rX5?=
 =?us-ascii?Q?ohF89I34+SRSuLoU0vb2MmBtwOtLfYuCuOqq/DhvX0o+2JqDmPM2lLH8YUU7?=
 =?us-ascii?Q?1RA/LEffHL63DhV0sS3wQTkffaD5WUyXPsOkFqBKv96i/XOZ1qHgqgIXENsI?=
 =?us-ascii?Q?J63sou1QsmGHMQLkrpRVzK+n43UDMJ68PkrU28mE9JMprmPP3w7yOu2qk8xB?=
 =?us-ascii?Q?EvRefnEbdzXQkmtvXe2mCqKVqzYD4v4Xaw4NsoZUlGA/aDtwEU7Dmlq6I95H?=
 =?us-ascii?Q?NVlYMG7L0GlrSGzywu8ojg8q+BMtUP78nFcDs/noSL4jS9u/rsCQ9MqV8OgX?=
 =?us-ascii?Q?YMIbNctpBpzqZfU0rwUw9fUdcqvUqHQ3hLiZUZXZjz5uzVs/nlu67sDCd4p4?=
 =?us-ascii?Q?bvuI63BVTlH7Qr3Od9dBCx5giKZKRI9tdkrfGS3sbPobXGU7mWKgDdy/iu9k?=
 =?us-ascii?Q?Zcr49xDGsY1RN5AhohrPq8y2o7JmpO+2Zeb1TdTnc8DfOsx6p3vFf0aKac+W?=
 =?us-ascii?Q?PxninSRF+97s5g2iXhY9h0a0dRT97Y1N+6mydXKULxJnxHY3wJpB9If9BZAG?=
 =?us-ascii?Q?EB1j3gF9on3H0HgnNJS8oP+ZY6rh/shsQutpA+slynz9lFUyyy5j7ay/mRXf?=
 =?us-ascii?Q?usi8baQV+AXkdLZk2dTBwu+vwONvab6EXY54sGf6Ztq7m03sEEWKsu2Uo8Sp?=
 =?us-ascii?Q?MAKynbGnTFUrwzc7PWFmKGnLkAvk9gY0UPnaYLa2Q/kr5wYmXqOrVokpevFZ?=
 =?us-ascii?Q?lRBjpSWdgl6JZr6DAZNxt6EcNFDI7V6T+LmQqo3i/zZ2d17KT0ifzf8INfPp?=
 =?us-ascii?Q?pA7nEwjsvTT07n48SvHaeTLz4Y11Cxdh62CPjj2lobFo5Q8GWDrRyMssHP14?=
 =?us-ascii?Q?JPLs0CwWN+k3sjLqRu8/yTEZmcUbWAvFYtmeftol9dkZ5E1anG55EczMz/nM?=
 =?us-ascii?Q?Dn46sbGkgoJk0INyQtZBuyX3IQkWyE6kTOPYCLry1coYi4g483LHcEcazSzk?=
 =?us-ascii?Q?DyIBPUCltBSBqH3DSV8xXukUGFwfCQ8FO9CuxKZxphoImJdrGdxlY9MKF3cR?=
 =?us-ascii?Q?XqexCuffgpc9ZzXaKltQcz/rFMzlCMptx0CBpjOWjNzxBfIAtDpDGO6Gp0vK?=
 =?us-ascii?Q?z+uyvh34wmHsAnOg+dHH2ae2HSoY2kImxLFgudwkbQpKst58yJTj7FMqD0jO?=
 =?us-ascii?Q?kYv5KXEudWjFAQlt3Mf3o72nVfkHHh2iG5Wc4zs38Quu1blsBjQe7b/tseIf?=
 =?us-ascii?Q?eH5vf4/eXClTy2Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QMWi24WpkPHK0/+6LN78RYAOSHJDb3fy82QtV2G789NYX4VOYaasAlmnn0Y4?=
 =?us-ascii?Q?F4H+BDBP+vjfXSA9i05bnc8dAaPncVtT0atF2aeigghbCcbHPnj/DVZjVSoh?=
 =?us-ascii?Q?gpv3HcafMfyItrHTLlxAGGzKEzLHF0T9BTIsnegMGTIefVbmV/YcBr9mnyQG?=
 =?us-ascii?Q?73oESG0VV2q37NolUDcmyFcrZBAnh9kkJG0lAAFseteXjWP5wfJzATPC1ulQ?=
 =?us-ascii?Q?xxeH8mStK2zBIkwbwbKHIZ7ZUIRVYiGcLVU5aUtl2PFAJNKb+fDjE1/JoT8+?=
 =?us-ascii?Q?HP8fKdjXSFOlHOT3HgeciqC64dfVbwtc7PjLN5dAj+i97nGVZ2nJBtPyYENe?=
 =?us-ascii?Q?vLdiu7cWqmYL32f860yGpzVaBLx23xJqPDE9uw1Y5tlxIJvmdoPy5w+UcS8t?=
 =?us-ascii?Q?OLEdQ0Pld2lzbHPRUHxarfV2pTDGFV0xShXl0WfF0PlPJZ1hInUM1tsDMEOJ?=
 =?us-ascii?Q?0Gzaam0SXTOWWAwH181Ytp/e0p0Ar3UtMceC4nzxn5itBfJG9pXrjWDBVKgh?=
 =?us-ascii?Q?MFho1fz+VaEOlhw0Un+kCMZinWGj+ElwQ9TnTLCnHshO2YuDqIDOSGkgmWmD?=
 =?us-ascii?Q?HVKtdVcqLxu+uR1+UnXK7y2msPi976/z+d0KrLR9ZeXcVIYfpWcrOTgD9JbH?=
 =?us-ascii?Q?cQFTUGlH6OGUXkFINb1zsK9lpU0rkvNyF+PQyDXGE3fS+QOGFovcdqDEUOWi?=
 =?us-ascii?Q?zs03+QBYFk0YHgWFuWFP/9zoG/NwFQ32ZQDFDBh/vs3pboAsfE1lYTIUQefD?=
 =?us-ascii?Q?/YofGFNMrMaTnbVLDYfihoUPmDhQfSRDxM+laRlLtjx6e0WIIWksHZgQD2sO?=
 =?us-ascii?Q?VafM1ea8ou2YQzhTW7r/Tr4togF9+pnzrnFLzO71DGvPhUzrsXCJUYvqdQwx?=
 =?us-ascii?Q?ekMYKlZMXTXsH7RDe2EIvJbHxVGMkpT1DVZPJ2k7ICxR1c2d6tKvGEkZPiEN?=
 =?us-ascii?Q?eB2sy9pwCC9RIVq5ksWLS/yKyXl4SCne2g1wex/i04tMQHQ1x2qUAYank5YK?=
 =?us-ascii?Q?KpjThY1e0fFTjMdTyC7TAXd3diRSs/Dxr+O4aNVpGpy8hxGKcr1BwplLMqdP?=
 =?us-ascii?Q?XsR5jtxB6+7ANPUdVTsxiBavJT48yX7HozmII4RGwy9KLcDhOEQb97bTwroM?=
 =?us-ascii?Q?DKihi1OkcWbUmgKeWcFx67nOdWPMnKSVGz266XvjGMg0L8Hhin72UUO6Gd61?=
 =?us-ascii?Q?YvoK6Tn7lZPv2frYkgOLWgXME6mVKSA4bPLBVMhtVNvvDBu5kBtz/E15dDw0?=
 =?us-ascii?Q?eJsNcRU9jBU7FF9fo/31PRHniGtegKiqOullRuOqjMU6Ba76+fNelT2Mhz1Q?=
 =?us-ascii?Q?bI3gXJIif6ZnQop3a0YWSlHBlR4IA/4qLwtzL1Q3e5zI87IIBgbDzeTV+sqN?=
 =?us-ascii?Q?LXBUfdK98IXSbHlU+bNAW7GLkmVIkJEYjEyzvtHIz13/mgo4oOQY0wWNOIb0?=
 =?us-ascii?Q?EDbNimoKdKkT7HwZsc96Sfcp/P8T9hYpUCBZHmYn2rDRaO4rvSs17qWs9dQs?=
 =?us-ascii?Q?0hj9YQSQvikDI/EgoIqJtTT+ohfwHRdI0M4cjhaJmdgoMSBbZY2oHepIfyfd?=
 =?us-ascii?Q?8npIKupkIb5zXTJ660s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61896f31-e084-4f91-499f-08ddd8ef6ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 15:55:02.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2A3vVKFi4HiImfDpujsseb1HFX5s/y/xzKMb1VA54iupi2B/3CIm/l995hemCxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, August 11, 2025 9:08 PM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> sean.anderson@linux.dev; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; horms@kernel.org; netdev@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Katak=
am, Harini
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head=
 pointer
> after BD is successfully allocated in dmaengine flow
>
> On Sat, 9 Aug 2025 20:31:40 +0000 Gupta, Suraj wrote:
> > > The fix itself seems incomplete. Even if we correctly skip the
> > > increment we will never try to catch up with the allocations, the
> > > ring will have fewer outstanding Rx skbs until reset, right? Worst
> > > case we drop all the skbs and the ring will be empty, no Rx will happ=
en until
> reset.
> > > The shutdown path seems to be checking for skb =3D NULL so I guess
> > > it's correct but good to double check..
> >
> > I agree that Rx ring will have fewer outstanding skbs. But I think
> > that difference won't exceed one anytime as descriptors submission
> > will fail only once due to insufficient space in AXIDMA BD ring. Rest
> > of the time we already will have an extra entry in AXIDMA BD ring.
> > Also, invoking callback (where Rx skb ring hp is filled in axienet)and
> > freeing AXIDMA BD are part of same tasklet in AXIDMA driver so next
> > callback will only be called after freeing a BD. I tested running
> > stress tests (Both UPD and TCP netperf). Please let me know your
> > thoughts if I'm missing something.
>
> That wasn't my reading, maybe I misinterpreted the code.
>
> From what I could tell the driver tries to give one new buffer for each b=
uffer
> completed. So it never tries to "catch up" on previously missed allocatio=
ns. IOW say
> we have a queue with 16 indexes, after 16 failures (which may be spread o=
ut over
> time) the ring will be empty.

Yes, IIRC there is 1:1 mapping for RX DMA callback and
axienet_rx_submit_desc(). In case there are failure in
axienet_rx_submit_desc() it is not able to reattempt
in current implementation. Theoretically there could
be other error in rx_submit_desc() (like dma_mapping/netdev
allocation)

One thought is to have some flag/index to tell that it should
be reattempted in subsequent axienet_rx_submit_desc() ?

Thanks,
Radhey

