Return-Path: <netdev+bounces-169674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535BA45381
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7086A3A45F7
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014B21C9EE;
	Wed, 26 Feb 2025 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XRayAKKA"
X-Original-To: netdev@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34142AE7F;
	Wed, 26 Feb 2025 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538679; cv=fail; b=rS1uAMzL1hD4NBrNp8Tu/tZUijDjA0jMR91BXa1FGyJmt9yPuDnW73Rjig9eGTpf4Z/74gmQjDYeFG7k3QE3gyhJmG4y0QDoht1lCbd/3nsLHlXHQyrNBKjNI1oYxO0wGbfWRejxLrif00lTF8bfUOFUgNDrmf2KyuVIXDXBcSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538679; c=relaxed/simple;
	bh=pzrUMn3TRoA9xwg4v0C4qeZejMiVXkp8JeZg7XybeGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUAhPOAvsbkJPlh/FewU1Ha+rz900L/8xAd/Sqfgp/KezEF9EeOImebojyhivTFnGFiAN2juwDIRtC7xHEe5yM4jZQ/iOAlr+R1ElsLAdo3xgE1WPNd+OAUdjRFIxMJt237Ff5EqB4Ze89UPl1wKxbS3XnMCZquSHY3GVKIOsWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XRayAKKA; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0cyA3Nn6CGqUolsIQR9hN9ITTg45MWwpgRpzdrSLu0p1Wgq3+b051/LX1qd6T4nGVimZRJYpsMMUEWnmP3NixbzEL+GYrcuxaTH3cJj/js6HKnvHr+16QQ8ahvOPXB8fxGhO0HcuC5xZFAeDI+2yRayCI8lQ1yqYdEwuhm+cZJkj/Ga5OYRnFsTCPIRdqcn7q6c19I5OYmlPehOmfE1TbmeNnTl7O98eroRQq/UwCGCK3ZFfKkStVhs2SsxQ5e7PLOdyQltdrDjmLrP1gMieajk9jQ/4RCacJbGKaITbsEa9w1sq31h7hWz8MdxRJ5jXo8ny6pTnIv7UFhnN/dlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKFEmX0R3JdwDiiL5MB9W6vht317B3oqmcRmzL151Lk=;
 b=JzrddlLsWA9r+3hQGkEVTJM4bF5WRYZqvFBfta+WOv4l5TlDityni/NyYVK+nLbvV6zNHaZG0jalCY4BMwQlVmhiEx/EH5128V2GC9HgNdWHz6NvJhknkob7hEAFHXdtP4prtouGD59GxZZgnapPlpkBNzv9HiQajrgpnE91Rxo0ITJYht7erh6IQijajSqBUnEi6ota4kLvyARVLtUy3n3IGP0yUnaJiIKRgnpL9jKhjtoQdFIV9/bZ4on1BN1C/6jZPFWT6oANGRlkm4a/NM5cfwMkocmWES42wTB5RJubPHdLjwcx4Ipf/rAfcg0bbedQAs87vF12Ol9y34LkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKFEmX0R3JdwDiiL5MB9W6vht317B3oqmcRmzL151Lk=;
 b=XRayAKKAMf9k59nWo+M4KJ7K8f3qx1/io8qvQ8JI/t09i9h0rFq2eZgvyPOietbCEa9NXkUZ+W7yQibPf8M3uK3+IOP/vLUSqKfe8vdhguMwvkjyylsojCr9rNPSl+ODjoKxr0FWXbFhQBEEWIp+6igFSjVwum2hY2uKMH5oqZpwOX0ERC1nvWuKt96gFYurpC35xV5H2c4ftdWRDLXbabmLKBuySzS1cEX9k+j4EeqMMI7xIqylDe7EaLYyNUly3wLMjeQZ1n2ae8p529brCW/f73z5OkI10gZhJLBIP5/ixx+8+1W6JPLy1VGRTIRmZLfV/YdJ4GyH7Iaqg6hRJw==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by PNXPR01MB6962.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 02:57:50 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:57:49 +0000
Message-ID:
 <PN0PR01MB9166482E059F3C4FC7A6134DFEC22@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 26 Feb 2025 10:57:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: sophgo: Add clock controller support for
 SG2044 SoC
To: Inochi Amaoto <inochiama@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20250204084439.1602440-1-inochiama@gmail.com>
 <20250204084439.1602440-3-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250204084439.1602440-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <f5165728-5830-44c6-bcdb-6eee73db57d2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|PNXPR01MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f235f5f-c4dd-4cef-0b36-08dd56115aed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799003|7092599003|15080799006|8060799006|461199028|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXlHZ1JGZGVqcGhCUW9LVS9oS1VWdkh1OHZCR2tjYkpTaFpXMGs2a2thMS9P?=
 =?utf-8?B?VWNINld4TEpsa2VwTG5udVgrSHhnQXlNa0xSV3Z2Mlp3b0c5RUdzektBZGY2?=
 =?utf-8?B?Qm16c0U0aXZXVmdVdm8weTByK3RnWnhRaFBLM2Z5NER0QU56cVJTU1F4Q0xl?=
 =?utf-8?B?OEhRc0owMDJpN3hNTzRtc084YzZiVUtlbkxCd04raS9HcWNVWmtiSldraUZm?=
 =?utf-8?B?aTVWR09qTUlpMThkYW1qaHFvNE5ZNENNTytVSVhXQzlnUlpaTzM4TURMaDZ4?=
 =?utf-8?B?WGtNZkhxcEhrODRYWDdldUhzLy9DMmlnWEZFWUk1T2g0RTlMN3hTQ3RmVVpK?=
 =?utf-8?B?VEVtWGU3M0JVQ21FNG9qck9FeDN0WWtRMEFLV21LMUR1Szh4UVQwdW9jVGli?=
 =?utf-8?B?eVM0Vk1HcVhlaHhMSUZBTzZDL21XNnNHK1ZWQ3ZKUUxXWllJbzFJSDdQeUJX?=
 =?utf-8?B?WGV5dzVuYlQ2aEZCSkZMdmJ0aEJGbllwTlYyWHN3ZXM0UUxrUE9LNjZCTVFP?=
 =?utf-8?B?OUhJY2NWQ3R5ZmtjbmVkeklaZllyUkkwUm9OVjRuZU5GL0trRUxzNklpMUV4?=
 =?utf-8?B?RlVZNTNJU1JBcUZtdzJ4UEVteE82VlRJMkV6RHdGT0hQM3ZObzM5T3c3Q1Y5?=
 =?utf-8?B?OW5KeXM0UkxCbXdIYmt2Um1OZ0xJdFZiYWYyRW52Q3RLRDRzSFVPZ3lNWGcz?=
 =?utf-8?B?RENTRGpZZUV2b2IvVUhMaGZRc0wydCs0YWswLzM0NEY2QlNDT1R1OUMwUFEz?=
 =?utf-8?B?MTRFM213SUVMdmhQT3NqZHRYeWJwdnVxOC9rMFhqVUhmY0NFMjNuMVJiSG80?=
 =?utf-8?B?cHZ0KzQ2TkgvRWRSc1RCUVhBSG5kVmk3QWpPWWN0N09BbEEwYmduWXBwODRM?=
 =?utf-8?B?NTUxRDF2c0NLaEdGT3FEdmVLT1l3eVN4N1A3WVBYbjFIVkFnYnRmSnFoMnVE?=
 =?utf-8?B?RTZmMXRicWtzWGppWnJhdFl2bll0VTJjdHA4NWh1djU5Sm5Jc1pMOEZpaVU4?=
 =?utf-8?B?QVB3MjRRVEJGVWpNc09STGhEbHJXNnQrTEsvRUVzOXVubXZJNDFqM2Q2b0tF?=
 =?utf-8?B?dWg2QUg1RTNzVVlOZWU2aVQvdFZYNXhNUUovbFlXRGx1T1pISlphN3hpR09h?=
 =?utf-8?B?NnQ4UTNoRGFWbW5wVVFwZVNrdXpsa3ZuTHliMlVxaGF5OU9HUzhWME9nT2sx?=
 =?utf-8?B?SXRRalhhRzNFdGhRNkdQVzJnMlFHNzVzWXgrdGtxNm9iRlByTms1WTVsZXdJ?=
 =?utf-8?B?eVk5ejhocThpWEE2NmkzNVpxcWtXaGVQMG0vVEdoQ2JtRFVDOWppS3dIdFVC?=
 =?utf-8?B?OWI2V2pkK0d6VExvZnZnNjFVOTlrUnkwZG1IWENWTEZtQXp4YkxiNXVmTWN0?=
 =?utf-8?B?QzBaZDdnQUhPK3UvQUdyS0FUN0s1WW16MjdVSkdSSVJkbkdiNDhwSmN5NWlh?=
 =?utf-8?B?bUw3RE1JblFQSlBjVWlUMmd3ZnhqU3M5U0lVRDlnZ3hUT29QY2ZFcTArVC9x?=
 =?utf-8?Q?iOGe9YHFOM7tn7DyhW2fJj4PLyC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUx2a3FXQ2Rid2FtN1pKeWd6Zy9BMDJVYUcvTGlKSnJVVlFGdmJ3YmVZWVhq?=
 =?utf-8?B?cUhPUVI0TUcyeDRCbEhnYlFVb1hmNnVBc0xFYkR2L0dsNzh5czVycGhnU0p4?=
 =?utf-8?B?NnYwN1RVNnRBZC81VGZGMlJSVDlwSWFZbVJzdURqREk3a0NXQjdyTmtaSVV6?=
 =?utf-8?B?TUJXT2FVNWJDeWN6dTBFNXprTHU1ODJFM0RTWDZjUE9LdEt3b0ozSnBPSXBV?=
 =?utf-8?B?L0JFUDNvR2VuSjFoUnVBaXF0YTJJWFN0WTRscmtFdk02ZFQ4ZGtvSzhwRlgz?=
 =?utf-8?B?OEZZTWxoVTNEMi93cFRsc0NnWjBtbU1LY2xZN3dJWjR6aWlRWGpHdUJHWnBk?=
 =?utf-8?B?ZTR1aHkxYTF4UDNNOHA5R05aWTZkOThFbGZYR1g4aEQ5Y1Rra3cwbUs2eVRk?=
 =?utf-8?B?WVExQzlkcHEyWnh2NC9ZYUFER1c5VHg0eGxDUzk5a2ZCN3NlSjNuaENQMWZX?=
 =?utf-8?B?K2wvajRIWVVYQ092ZWVtRzhYNzV6akJoZEdCNE1EVkVhY1FmTkc0aHFSS1RY?=
 =?utf-8?B?aExScVpZWmFzMGFMR2pkdGJVT0pGcTE3RHNER3RndUxaS0ZhSnBvQlJBTXdZ?=
 =?utf-8?B?NU40T1NFVUpLelgyYng2Z2g2UGFHOGVPR2hSUHh4VDU4YU1WOFhLc1E4ZmJR?=
 =?utf-8?B?aVN0UXd2SUdEeWdveCtIa0VSSVBvR2hUVVlIMlZFZE9zb1E4QmZuS1Y2dFcz?=
 =?utf-8?B?bk1uUXRVeE9mL0FKZ0oxTVBodktxTCsxSjgySkxiRGhEZ1h2c3Y4NkV5Yjlu?=
 =?utf-8?B?VkdBQW91ZHdFZzIySXB0WEJuL3R0OUpzVzFUVXgwTnV5Z0Rzdk9oaGxSamF2?=
 =?utf-8?B?SG1zdjUzL2RDMDlNYjNmZ0pURDhpZ2JtWWNSZG5sSFVsdU5VNjMrWkE1L2J1?=
 =?utf-8?B?QXRSNXliMURLVU5jaGdkazVWbVlHVWx2YVc0c256eFRGSytnRFBLTDNUenRh?=
 =?utf-8?B?bjFENEFDWjJJc2JZVFUxNGdGZFFhM1hlc2d4S1Fud01wZHExUU54czduemRs?=
 =?utf-8?B?cWlJejlNZDJIZnlCOVEzZGZ6aFZtUWFFc1gycjYvYkx1OURUUDZTbXE2RHh5?=
 =?utf-8?B?eHExTVVJdHVVOFlEbDllOXMxc1VrRC9wK2d1R1cwVzhCWXcxcEpzN3kzeS9O?=
 =?utf-8?B?LzRUZXBORGQyWWs4R3VFZVpCemMxYlZmek5ueDgyaVVLQWZVTndlYzMvODdo?=
 =?utf-8?B?M21Sc1pmV3c3SE5PVy9NUEc1MDJOeXN5NTFoWDNSN3BxMFhaSy8yR3dGYXg0?=
 =?utf-8?B?OGY0cU1IdGkxWkdRd2VCTEVGUEVScWF3UWh0djlhMWhuMUF5ejZvT24vc1hG?=
 =?utf-8?B?amJIakh0YzZuYldieit2TWM1UU94c0k1OXhvRFRGMG9OWVFhOHZGSnNVZkxO?=
 =?utf-8?B?KzVqU1U3NjBJajM0ZUZ2QTBLMVhsSEZRRXgxUnlBc1NPUHhxendXYjdRSDdT?=
 =?utf-8?B?eUh0bFZ5TzBnR2lxazRQc2l2Z3A0aVFmazVtNEhPZVY4TXNxVCsxNGM5WHMv?=
 =?utf-8?B?NWpQc09aQ1J4OXY5WmxZS3ZzR1VId2ttL1RsZTVkQzdrTXE4VmJPNTVUQTRF?=
 =?utf-8?B?SXRWZGs2M2Jhblhnd0lnWi80cVFWYldncXQvcGJKaWZMVWlJQWcxVmduMVRG?=
 =?utf-8?B?U3RLWllacG9oTGg0RlZMUHBQTU9KMzBqRzlDK1B1SUFOODNOSlVPc2o2Zmdn?=
 =?utf-8?B?RkFEMFhraFNMVHRHd2J5cDVVbEhDTUJ1c283TVZQbFRVQmxZaWVORU1xa3hr?=
 =?utf-8?Q?h+5gSGDyA/31YdQsgqlEnamPahTRViJu1EQDHqi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f235f5f-c4dd-4cef-0b36-08dd56115aed
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:57:49.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6962


On 2025/2/4 16:44, Inochi Amaoto wrote:
[......]
> diff --git a/drivers/clk/sophgo/clk-sg2044.c b/drivers/clk/sophgo/clk-sg2044.c
> new file mode 100644
> index 000000000000..7185c11ea2a5
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sg2044.c
> @@ -0,0 +1,2271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 clock controller Driver
> + *
> + * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>

I'm afraid you may need to use your new gmail emailbox address.

[......]

> +static int sg2044_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sg2044_clk_ctrl *ctrl;
> +	const struct sg2044_clk_desc_data *desc;
> +	void __iomem *reg;
> +	struct regmap *regmap;
> +	u32 num_clks;
> +
> +	reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	regmap = syscon_regmap_lookup_by_compatible("sophgo,sg2044-top-syscon");

What's this? Do you miss some descritpion about dependency (in 
cover-letter?)

Others LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Regards,

Chen

[......]


