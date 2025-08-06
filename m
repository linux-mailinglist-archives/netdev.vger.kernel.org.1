Return-Path: <netdev+bounces-211883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CCB1C2B8
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540033B3B7D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0905288CAF;
	Wed,  6 Aug 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5HruQMb/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860922332E;
	Wed,  6 Aug 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471003; cv=fail; b=bIFixxSKKoxzx50co1U8nk2Nl+Hxur5o6FrS8Hh/BFdr+IjzUeRWuMf5UFrzHJ7A30kc3Oz3mO1zHHOiektO3oFpICrFaStyEph+aj+AI3swl0wb18xdfsRmGfHcSUjqsqjMs0Hn2rCPAhd2qxyhgKdPTj3BSmBSmWpoCfNtWoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471003; c=relaxed/simple;
	bh=cAVaUwcaAXaLwZYCo8utzLpNcFMm90TMsu8c29ussG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iXed7DWKTZ6elDh0ayY7S9liwuLdwhQvCXeZMsDWb3MV3sNITtP/chwbnT0JE75o+sMmmxt2PEwLewpDgC/5I4SuavFm+qVkTh8uOAVTZzqysHTdP2c9VUDVMf5/g3GTFIpF0MhlXihZEOuvPHIetYqxXsZqJlIqfKxQU4h1KtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5HruQMb/; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiCLirFQFteKo5LbZ8XD8qaVdAYOLkihibZpOfmkJIJX1bkYCDxiNJfOjAdwHSRwwKiACayesjdOR0ANVJB6Nw4yFT/rffQCOJ5+aJVQvve+poTJX8Ef9ot5w2AMPf+KtT4IeMGgaAKIPgtAZA4H522cgGB4F0BamSkPNXE85SNimSp4VeodXCzTwb2h79DfZrrjaKVn/ZGNGNJoUGQfVo4FXSOBV5QPrl/ofPFW3S7i37iZz0f+tq2JpAwwExZvcJm9xNLWd10vcIQR7GDdj5TOFdJw7QX6CmLFgtHy0uE9raifn7yHKJChrSieE9qO2ecJ0NNd/7F3tYZKNAtssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W65ibs+MH0cyH1/YSbBAQtxJ261sTAcfCYgTjlgT7k=;
 b=WzRLOkeHiiAgbqlMIn5ci0oJKJ869ovWqn+kQ9AI7urONISbtZj5fdZ8SyUAhksiP+FW+V8t6/A0Wu93HLeWusSsFEProzNiP3iaY1tu/m3KC92/Wi5cJYRGQKOAvboFjty2ZNlDOLVdAu7+l3ZIWVlBONO2SxXJ7N1/9OOfDoM3TsOviHzN6lPdZRljeB2UC1E3qxgpFjhTubiXL5n3Ufhgaf+8L3AKEoE2UJXUN+2aJdt0BoSEeRP/2ryV3SeI9gyaNrQ7wYZQNLAqXFNWelRC8vMP8QUDjPekbsBd8cSJircrMyyLna6U4M0RI4/3eLoFO3nc10nfSOreCC1guQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W65ibs+MH0cyH1/YSbBAQtxJ261sTAcfCYgTjlgT7k=;
 b=5HruQMb/nrx0OV4Qv1pDp9tYra+Xe0IIg2Lsk3tsX1wlLa+s+r2mOTF2K7i2OjPwW4iS/tX6qI2iKqBQ/KgY01DbcOaqAhJxDIAEN/5cICXcKRglmKDGVwVM0Hpq5evQgBUrN2TF1Yjoy9gtczrDVfkyikGLizlHqwkYSQVL5vI=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 09:03:16 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 09:03:16 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Topic: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Index: AQHcBj33CzCOb/lK00ituSZCoqdfS7RVVLMQ
Date: Wed, 6 Aug 2025 09:03:16 +0000
Message-ID:
 <MN0PR12MB5953E5B18BAC06C0116B0F7FB72DA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
In-Reply-To: <20250805191958.412220-1-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T09:00:44.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DS7PR12MB5789:EE_
x-ms-office365-filtering-correlation-id: 9308ff71-7eb1-43d1-7c4d-08ddd4c814e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|7053199007|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vsgmTmbsF9obHKfsb6Kwp5348k60POvnfKDtZK3nfOEX/kXGtwDQ/euRINkY?=
 =?us-ascii?Q?7dzLnMIwRqACZiP8BmEXsl5tkENMBVVHDD9zlx7JHuokx0WuyfL2eesDnZvL?=
 =?us-ascii?Q?47mQ0WWqcnxqm7L9frDER5BP+nC58UjmrZ5KmD3LNlAmxN/JbF2OwrctNwkq?=
 =?us-ascii?Q?dpN/vIsWP+lXuj/iyhb6Xb+3v4P/UR/ld7rKIo+9xMEejPR4wQDFX/h9PQWY?=
 =?us-ascii?Q?zOlXb0jqwVCawg0Mz+bKom3F671/OVefD5VFXTdcKe7wbZirx8zBuxVr0KTP?=
 =?us-ascii?Q?yKHB3fNMmK7KpVWzvUudmLiVdmdaZdJGCE4xx9V+S9+5gAPFTw01ndOf/U4Y?=
 =?us-ascii?Q?z4Q0Pgr+KwK0ZKlq5nM58TJmnTCHgh3oS/RSvFAG7zOHx8Xmf342OpjzHyni?=
 =?us-ascii?Q?mXwc6SDo1yp0dwDdYBG0eRDYB6iFp33mKkxc5IT5kWBnmyl0LfP1FHGik+s/?=
 =?us-ascii?Q?LJSxYUaSaPShyEVKwEdoHEsfcDVJnIpvooidbIdVnK1tz/g9L2AZtgnYSXEl?=
 =?us-ascii?Q?n2ojD4Hb9z66UxK7FA/mL7BUssGs7JgAlgLA/YVAVZu0p+CJp3u0LShbnUco?=
 =?us-ascii?Q?HdYWfqN0DZwSS31fw8aR7DKi09XjC7h2HSHeBFeuFBdhnKlwPFLMBGGjduOK?=
 =?us-ascii?Q?o4Vm91sPFENc8bCp/vLObF3UHw0iZFqDvhFBhe/yC2qDpQT5v4cPUoxR2U9s?=
 =?us-ascii?Q?OpVXwjn7/EmLIrFHf/c0Pt8VhEzDfth5M8MwGiempWVGhDsOWLyTpqlKw7vi?=
 =?us-ascii?Q?CqR0KwXltNF2f3rJeUUwnIO3dKhLVj+WDaOoN8QjRGGNakAZRjChsUukjfyQ?=
 =?us-ascii?Q?in6stuYOKcG/zQetBV6IXbCkgHocytE5p6GYg6vL9gCs9Q98fj9izRGRzPkG?=
 =?us-ascii?Q?iU661fv6jUCO7JPiY528+C6XIZO09eO+DGUrY3+ERe2MnmKgZgJOk/wBmoe3?=
 =?us-ascii?Q?mEPW+eGSZDkG521yTn7selzFgmHy40cUQue3redsKucAone2F3NejnL9LrFw?=
 =?us-ascii?Q?qvv2HqefWDsIKc+gNj1RGpE0YpZdZ1p54PtSx0ctbbmR0kTEOGj14lDkSXly?=
 =?us-ascii?Q?EsbJo2xek/x2Aa9jqMWJDEVp94M6JmienQ6UFS19heJMLtKE+7zbSTbpHBGI?=
 =?us-ascii?Q?plqFOJEs9suCUC7MeihXkQW3OQveHh7hsJXomJPhVjEYFbMvzQOFjtAripDv?=
 =?us-ascii?Q?RRD1bMRRRGUHjvJKlG3iQjCPMGurDKAnw/TmFCd04z61A/iuWMFBKtrUTfUs?=
 =?us-ascii?Q?F5qHGV6yYgExHN5u9sqz+PcsjpLLXWFoK+OHVjqMtsa0bgGiF1P6iyky5Rs4?=
 =?us-ascii?Q?8A+Mc+10A9z5T7pJAW63IH8K6pkARTEfp7fjoGBVhn9cHvrGlRifH8CLklZp?=
 =?us-ascii?Q?mU0wwlyDyAaVq3PRr5qbNv+XM6Xqy0WnJ1ybbDvSXA0M4url7YNnX2agiXzc?=
 =?us-ascii?Q?GtVrlQKlyPN1V/g7eO00Zs9O8/gK5fP5NG5zE89bSNZWEGD/wi1FPgPloUyn?=
 =?us-ascii?Q?InTVN11XaG/M3r0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(7053199007)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FpiR49+/sIbtUARYLYZd904PLo0j4/NZAC3ajFai1ssuQ7Jhm6vhQWhKIBv3?=
 =?us-ascii?Q?bOFA5VZibxBc6HBbh6QnVULY985jFBmVn78+QeI7WuSJFicxWqduahEH3fQ6?=
 =?us-ascii?Q?vTxw9g6tLaEMz8TtE9YRmDkLwYRSxEfiyr3VBEnP/by1s1dHhsahOCv3MLLb?=
 =?us-ascii?Q?mPRS0G75tJrigiq7m5BX+tcUbQMFm/6PEDUGxn9lij+/WVlzmtenxamP73mF?=
 =?us-ascii?Q?YFIF5glXNn+z5BNm8d4kn1jlKP3uL/3OPzPQ3uQWA+YGh8thx4EPSA3tcEgs?=
 =?us-ascii?Q?Buce5VqiAIdKdZ0M/zxEw9v2TRVQqgLVLIKIB6elNvX7n/5CM7oIZcj2Ubn7?=
 =?us-ascii?Q?lfUHd/PY/LgFPwjbfG7hSlFXIcs5Y2V4hYq62ZrUmW0e4iu+GsR96GFh1wmz?=
 =?us-ascii?Q?ZQmARoGaiLWANGK+6/Dwp0UhRmyrYTpMFQ/0krR39kucPLF/qPMP9FoqgX52?=
 =?us-ascii?Q?KOeV7sQFcnWVMgxqk++PaqxIIs/4xo9UfYtc4bqJ76Pi3texAJ5Y4eCnOQfp?=
 =?us-ascii?Q?ecemgdqaODUNyjZdePtHIOhlJ6p2OURim9Jp2Sc+2W1yfwrSwGWl7iUCiNEI?=
 =?us-ascii?Q?C1kiZ173ABXEm7iYo/bcB5tFHOI+170mOlwoHAIIJdCsjBxWk9COJzitrqjJ?=
 =?us-ascii?Q?/XQsPSuhTrpB70zb7DGwacGHWiKXkgYNgmOFwhkluC38gOuIMW+6+X2iPT34?=
 =?us-ascii?Q?SjhbOm8s1vThDyH0Q+FOSZU/HnVoEzuqHmIVXyWUKgBW03RlCH9MJCTsf1Xe?=
 =?us-ascii?Q?0wkubvOSNtrPVvp5o+cEFhHOOWUy3pAPeg226jOwOEM+wIy5wEBpvppz+nKD?=
 =?us-ascii?Q?vVIsnWeWZ5pSFkj7g1l5DKOdIARyVszhLBdV8HmDY5OrnmRhQ8PpVGzAiiKv?=
 =?us-ascii?Q?2WLTceyKRbAVnsj7eAe3xds5zCKGRpJPOxyQ1Fc7y1cua6vqTDpCZ1Bsyyec?=
 =?us-ascii?Q?mYwz7+kiyaRUk1dJ4AUhhCmZj16zKgYphH0O3+bnNF+bX9Uc78q0iqa44m/n?=
 =?us-ascii?Q?xAI7aLDriL3IT7NpuUdcF1Y1KLXg6VuVabXF5gk+QNUtgNlxaQFXOh0UVb66?=
 =?us-ascii?Q?qiDps5jR6yuZzlXSWJNbv6VILJUMr0s5L6Ldt9TdNFYoZIxDMoWK2WqUPNL4?=
 =?us-ascii?Q?ZtaxUqWUGhjdewbE6bu+2qRHXXgFFrSlflsLP6A1XgjD6ehU5ka5bjM84kRN?=
 =?us-ascii?Q?IYDkUDNhr4DUeM9Z1RMs7eaKBafn2cOMDszm/2e9IMxta+EnaBaXiTra93Pa?=
 =?us-ascii?Q?hhDEqayU/99nFFIFRtsw0yti6oOXnDdSztGVRL3P8pBBqYjT5+/45An02lsh?=
 =?us-ascii?Q?hA5csr0U34Az3ZzdIbEx7z9HJ2m+qqgdsE4R5pXXberMrqjdRlUFu8Daovgi?=
 =?us-ascii?Q?bTiVH7V1y1Wx+AksLEaE+M/pV/WpWiS1ck+H2zLhqVhp8I573WCJUpZ0/G8S?=
 =?us-ascii?Q?ZqXbcEzxjzMsffzU0StNlQ081XgnCjeuTVcOEe8HgqhVGCs+nw9o6SW1fleC?=
 =?us-ascii?Q?2Zj9sR+AvZNWdDJ+M0jeWUvOkKytS/bkeS0g2nvbZ6WZxJEBdTkfkR++NEoK?=
 =?us-ascii?Q?70sSs2cDqbwPghvjbgo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9308ff71-7eb1-43d1-7c4d-08ddd4c814e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 09:03:16.5117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWbJpkx0UBG0nMcC1B2G5b8o9mWgXxPF4nNMtLwqfoNZ/PzQrs2Y1kwiLBd66vxq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Wednesday, August 6, 2025 12:50 AM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> sean.anderson@linux.dev; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; horms@kernel.org
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
> Subject: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head poi=
nter after
> BD is successfully allocated in dmaengine flow
>
> In DMAengine flow, AXI DMA driver invokes callback before freeing BD in
> irq handling path.
> In Rx callback (axienet_dma_rx_cb()), axienet driver tries to allocate
> new BD after processing skb.
> This will be problematic if both AXI-DMA and AXI ethernet have same
> BD count as all Rx BDs will be allocated initially and it won't be
> able to allocate new one after Rx irq. Incrementing head pointer w/o
> checking for BD allocation will result in garbage values in skb BD and
> cause the below kernel crash:
>
> Unable to handle kernel paging request at virtual address fffffffffffffff=
a
> <snip>
> Internal error: Oops: 0000000096000006 [#1]  SMP
> pc : axienet_dma_rx_cb+0x78/0x150
> lr : axienet_dma_rx_cb+0x78/0x150
>  Call trace:
>   axienet_dma_rx_cb+0x78/0x150 (P)
>   xilinx_dma_do_tasklet+0xdc/0x290
>   tasklet_action_common+0x12c/0x178
>   tasklet_action+0x30/0x3c
>   handle_softirqs+0xf8/0x230
> <snip>
>
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 6011d7eae0c7..acd5be60afec 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1457,7 +1457,6 @@ static void axienet_rx_submit_desc(struct net_devic=
e
> *ndev)
>       if (!skbuf_dma)
>               return;
>
> -     lp->rx_ring_head++;
>       skb =3D netdev_alloc_skb(ndev, lp->max_frm_size);
>       if (!skb)
>               return;
> @@ -1482,6 +1481,7 @@ static void axienet_rx_submit_desc(struct net_devic=
e
> *ndev)
>       skbuf_dma->desc =3D dma_rx_desc;
>       dma_rx_desc->callback_param =3D lp;
>       dma_rx_desc->callback_result =3D axienet_dma_rx_cb;
> +     lp->rx_ring_head++;
>       dmaengine_submit(dma_rx_desc);
>
>       return;
> --
> 2.25.1


