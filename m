Return-Path: <netdev+bounces-243031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5CC98734
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 18:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401493A5456
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24B336ED6;
	Mon,  1 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gJKzgrcw"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46BF336ED2
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609145; cv=fail; b=uPa87WUOXwvWby7o6IM858IfaeViduyk6JLBsv4k1F3Vb8BH/OCBjga4YVh+i0t/kZJeq7dv0eC1n2FSwevNFlqeCHQfh58LwhIdsAfFUHzJTGAqRo2C4k8iC1TEtT7COtDdgOJJI5qaq6iB+QVWTKEBMzfHg+MKQVk3zy/6/mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609145; c=relaxed/simple;
	bh=sfC48zmdoik+iTf4+rpnX9KixAYkBPRembmy7I5UEZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJ6jvk3xcLpFo/PrEwP3EvUys5IYJ/3VI2QAJOtB+m8mTcIuYRWUoEen6y6h2qOfPtpyZzFHAhjXmincYRI1wK0stdIAXALehi2hutPeQ0Plh81K9f+BV4worg3XZvvrLEeTdicTCCo4zQ7x0hmjqP6kiLQF3qb0+y9r5xerwdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gJKzgrcw; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvhoGBIElDq5DeuCXty6maIrsIXRdCY7FiKWsKMhk6HNVdFqF/w3Oc4J0HVX7Ph1m4ne9YwL3Ynhtrwlhro9LZfGNSGLkhtDj6sBCgb1f+h+jv+dIisWt1kDVeKPHerVtHZuBbBX+6VK6UePae0F133qGZfKBxW6fkXLzZnTmR2KUFm61S0etgFg4N58HhOalNtyyom1EtG2DBc9Zj1ZRYS7Z4SEFAOkfjig+XV6JtdBoq4yDsfogrPsCY/7z84u9A1CKpl2H6bMezB7/Ol1Yw0U9OpTHZ1oGdmesAQobE2pOnvKfVszD+Bq55c1May8393LuGHatefKTqhN9DRlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N23SvPBmzXMs3LRSJQjUOyug+F8Z8+S7rHe5tyE4Hg=;
 b=BzWuTiKt3Z9kEdFiOWz/iDZe2u+khXwPeHj+C9Oe1QA60xnTTLrT8G3bYfHkGeMjYtbY2g2AyfHoumsKShNjiqnYCttQwL7DZOERaWpXAF1C+/bZSkbpqlXEZ0xdHG+cQPnaU1bwjSk8INHVqbuKnEnsFwAzktt3hTPzLRid2VUvlPRqsnoT9VmB/tqgX40DAnpHWLOCM7bL9Ic07cQbkYTLA7g/DJNB3HAXDcDPiF5GKws91N7BCGCran2EhunFODC9iP4Oq4vmIkta9CL29Lj0xnapmAbkZYBUogbSlZ0npYCoOEWLJmFRAv0nSMikYrmDRaWStpEbkbmQ6l1TXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N23SvPBmzXMs3LRSJQjUOyug+F8Z8+S7rHe5tyE4Hg=;
 b=gJKzgrcwmgTvlI6RJH0mnuoH0IDAXA7qv7jl6DgtBtmaJVsOkqXRM6xp3wzJ6MGxxWUhw84MnIeN5DYngpdQzbQYknnirdBDTuyP/TwMSadUdQehPuORQO+0FW8cTz0F0s15rjeJpSp5Y469bgzE1MzodTHRXX7efv5Pki2gnwNxGq6krR6nHr2KWG33m031Cn8/BGdBZuNxtUp1TOOkx3C5Q09ZYu+ns2Bdf6JbveiYa47T0DIC+uvTIt7/wUrWhwoYYqRj2qZw/bJF2FMmSiudDgzMKC/Q9oAXs4S1S6jDa7j80UYiSJsCLwvZ32gYi2LmLykb4Yw4X5tZf1VUOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:12:19 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 17:12:16 +0000
Message-ID: <936fe4df-4817-4bb4-a682-38e4f10257d4@nvidia.com>
Date: Mon, 1 Dec 2025 11:12:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
 <20251201102256-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251201102256-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:806:127::21) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 024a8bd2-cd0a-411c-b604-08de30fcc742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi9FdW1KT1VSVm9RcVAxeS9kK3NDUTVMeTN0SitLSTJxU1d3c2lQZWdVakhB?=
 =?utf-8?B?NUdYNjI4QUE5M1JaN0M3cEVhK1dzTGovTkYvNGhHaU5DTGZNYnM5dXZ4WnpZ?=
 =?utf-8?B?U2Q2MHF6WlB0RTR4OWJMU0gwUFpJemY4a2JvUnpvb3g3RitycFJSaUQrQ0Nz?=
 =?utf-8?B?RTladmpLZ1BocXVoRXFhbUc0WWg3eSttdnR1bi84NlNWOFdWME5qYWw3dUZx?=
 =?utf-8?B?NDdQKzdQQkY0V0UwaUdKN1RodlcxOXVjWmRqWXhITStEeEhZU28rWlplUmNq?=
 =?utf-8?B?MHI4bTI3aWdPQTZlWkFiUmphVVdyaFpCS0R4cmtuZjhNVXF2UXNoR21teE40?=
 =?utf-8?B?YnhvWm1UZUxzdzUvb05GTEI3akk5R29VR0JJRWZjOGZQa1FHeGtJVUxZWkta?=
 =?utf-8?B?Z1FiV2JtM0dpcnVVSWFMVjVIVGdpRTUzVVlpU05QYW9MV1g3NTNTY0k0azZU?=
 =?utf-8?B?VlBzRFBHbHhrQlhyZURKd0lrZmUzbG1qUHRCT1FwbmxTYm5veWNSREh3cHJM?=
 =?utf-8?B?bC9ydmhjSC9RV2ZYcWt2TW5vWGhTWW9vd3UzSEUyZHI5VDUvM25jcGFkQVoy?=
 =?utf-8?B?aDlPam4waFBkZnVXbVM5b0trYldOTlRmV1Q5R3QrN2tqbG1XS2ptZ0pDVXhP?=
 =?utf-8?B?WGI2VHdyeVVmOEpkQURTcnQydGphRUk4eTlhcTQ4b1pndVI2b3hwS2lCU2R0?=
 =?utf-8?B?NmdiNGxDQjBneTExTk5LdkZ5ZnJQdFZnWEpNSnc4NkY4MGEzcFpmWUx4RndQ?=
 =?utf-8?B?YzhyTTV6SUxTRjFyNUJmY0duZzdYTHdQYTdlZURYVmRuNmdXUFNRRUthUFdQ?=
 =?utf-8?B?dUhidE5HYUd5SWJsOXk3SlR4aytqbjVDanY2M2JXbTdMZnN1Wm4vaGpveVRV?=
 =?utf-8?B?cHhjbTAvRWNLTlFkbmdTb0dMcWU5S05tVmpka3JuQnZqWjViTkpReDBvbXZs?=
 =?utf-8?B?bFdvYXZMSTJaQWJNVy9aQWxHMWRVcjJJMmVuS0pROEZsOGRmNm1ZWlYyemRh?=
 =?utf-8?B?aE5jSlJhSGp2SSttV3A4Yit4ekovbFlqM09mU1ZoYjBLd2RMa1lTSGRNNDI0?=
 =?utf-8?B?eHZ4WWxrL1RNSmEySVd5bWRuaHMvTkZXUzVGWEFXeXQwQmVXbUY3aXRjWFR1?=
 =?utf-8?B?c0loRjVwWmFKOCsxRllHVFUxTnpycE9VRXRMY3Rsc2ZTRVhidlFQS0o5dFNN?=
 =?utf-8?B?aGU0LzE5QThJZm5pQW91VHJ3MVFnWlQ2ZmNlKzFhTzFWTjFLZndyNm1nVmVF?=
 =?utf-8?B?OGNTcTNRRGJqbHlUcHovQjBMQzdhUnVrVzBQdUhBTVMzMzlPcXkzSTNRd09o?=
 =?utf-8?B?aDZxK2FselE0SUZtcHlRTWpMS1FCRFNndEdMVE5QblhDL0VHb2daVTVjWVpN?=
 =?utf-8?B?UWJkbUpUcGhqOVZDdWQ0OWF5UFhsdE13MjErN0JlZ0NicFUrMmYyNWJiN09p?=
 =?utf-8?B?RzdERkcwS1NWTjdiVjFHWS9lMndZdzNzd3B5TTRmaVlNVUJwRmlCalBWZW9G?=
 =?utf-8?B?RGFTVGJTMlBSRXlFeFhVWTRONEU2b0krNmJ3UHhqNE02ZE1ybUJVRGVUcDRF?=
 =?utf-8?B?a0Y1TmxtZ2NodkQzQW1JYnlKZDRwYTRVRkNydjF2bnlYeTdOUHdNaTNFWjlx?=
 =?utf-8?B?ZlJDeEg1L2hsMTdBd0Nhb1JySXlKZWNHZkJHeUFONTU5OGtVdGJPQks1aXlG?=
 =?utf-8?B?ZmxCM09BTDdERklZOHljcGJPNXhEOVc0WC93RFAwWTh1ajNDY3VKU3VDeDJt?=
 =?utf-8?B?ZW5vT3ZiTHlnZ3JEcml3Qkd6RGRVK01PZlE5eU1kcit6ZEJqZU1iM2lETmRj?=
 =?utf-8?B?dHhwV3l1MlRwM3ZUTTFOV1gzMTFnZlkyQjIvWWlzN2pGV05nUXAzMS9IL2w2?=
 =?utf-8?B?VnkvZUJJUUkxOThuZ3BVa2RzNXVrSjhkWnRQYWtuYi9RbncwL0EvaEV2SlZ0?=
 =?utf-8?Q?tJJCMl4Ix9huwXa/fhEdhcAqeeLTgqJI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitLVThwd0FXbWh3WlJUVlA5ME1DdEIyTmFOSjNzbUtUNDkycTBCRXVlU2I0?=
 =?utf-8?B?QkFHRXBjTm54dzZqOWJSazFpOFFoNVNKeDJJY0dLM0NBZGd0elhHY2VSS0ZI?=
 =?utf-8?B?VndjZ0U1NDhuNURjVG9RU3N5OG5IYTZVa0hvUHpleE5qeDRTRm1EY25PZWJ6?=
 =?utf-8?B?cU5Xckw5RXh4eUJCOEZ6TmxUS0VaVkc1SGRmMXVMTTdnQm5BVllKUXFlYXRv?=
 =?utf-8?B?QmJ1RU9CcUdBc1VSeStqVCtXeGdlVEFTTnNhVHVBdWowdzRkc2w5RUZ0NFRI?=
 =?utf-8?B?b0VESXNJR0FwWmlNN2t2V3JNelJUeWtEb2xXSkI4TmcwVDV1L3RtbHhvZ3Jt?=
 =?utf-8?B?eWIwL2dLUmtGa21xSEFpbHE4cXltMVNMYVRud245d040QzV4M0tkRkJGL0Y3?=
 =?utf-8?B?WjNQcXF2TW5nY0JDTXgrMG1acU1HL0lvdTdFeU50VVFzNHIzeUpYQ1RTbWVi?=
 =?utf-8?B?aCttM2huY2lKeXVZYklOTkRJcS92bS91MTZCeVRmdFBrTnFCNktYV3N1dVZq?=
 =?utf-8?B?TFBCWmw0U2xBQTExZHhJSkIybUpXTTJDZms0L2M5QUQrY2NpdFRDTHRPcGUz?=
 =?utf-8?B?U1RDZEw1azVNcHozZWJWbm50OSsyQ3Z3RVRMdStRNERzYVhvUG0wb2VjbXZo?=
 =?utf-8?B?UUFHU0tsZEFQZTdBemMwbmFjOFF3aWlTdnkyRjVLaFBESUJUWkJzSWxlcDgy?=
 =?utf-8?B?SGVWS0NWK1pJK2haZXBYTFNKb2pFMUZwbkd1K2FvTFF3NjVpTEo2NVAyQjRC?=
 =?utf-8?B?c2lTRGRNVGxIdkdlNkVycEFab0paZmRqTkZpNTNjUXZuWHBXcTlmbjB4QldD?=
 =?utf-8?B?SE5CSnpYWjNLcVh0UDRVazZGNWk4OGk1SVZTdm5jblRkSDlGM3FlOStXdWYx?=
 =?utf-8?B?YWxQTXdIL2pycExvTFM5QzFhSjE0c3RLUEVpN0hIZDlobjdTdUNHM1owVGlj?=
 =?utf-8?B?Z0gvN09zZ29Kd2tzQkJZa0VGTTg3cVY0NFVuYm1nenhkMGFDNDlydllveVQ0?=
 =?utf-8?B?RTJxcGo5MEIySSs4NkZQTSt1akJreUh3VVBkRGFNWlVXSzJKbytjdHR5dWlh?=
 =?utf-8?B?YmlJMEdwMm5uWVNib2J4Q0dBR2hocmFTUC84bThsQVBlZXVNWVNPMlZ6QTVG?=
 =?utf-8?B?QW1aczhpckJCNVN1bFBWbnZXalNsMlZCbklzODE5MFhSSGVCMFB4Y01IOVZX?=
 =?utf-8?B?SkxvbXNmSThRVlJ6RGpUcmFGSHVEWCtPUjh4amZoR080TFhiTTlJWkhwbm9B?=
 =?utf-8?B?ckZ4QlZOM3hqVG0rTkFHTFY3RTl4elZBR3d0L1RVZjA0dkUxM3hERTJ2Qyty?=
 =?utf-8?B?Q1QvbmY2aDN4aEZJUTk5aVFTVkdtRjYrNU53VEZlWEVMZDB4QzEzZnZraFFL?=
 =?utf-8?B?NzA5eUpZMFJuU1ZDUm5keWc5S0UxTmR6L2NLZFE5SXVXdHJjbk5qMzYydlNR?=
 =?utf-8?B?Mno0TGp4MzFwQWdyN0ZNakxrTkFjaWFFcWJ4N0pWY3BzMTBWQWorbXVsRnFI?=
 =?utf-8?B?Zy93aVBoaWNHTVVDVTk2S3ZtYXFGY3pZbXhvMjVjcUNSa2VCMnJGOFVxMEhv?=
 =?utf-8?B?bGNBUkFtVVR4eC8xcVpmbFhzNWpjdzdjR2VMWGxnMEtDbmFweGs3NjZoVGFr?=
 =?utf-8?B?THVrbjJMaWZYaHQreXZqMVFETW9OZ2ZhS3MxQ2QvaEtCam03S3k4QjBZYnhy?=
 =?utf-8?B?TFpVV29vRlQwYmpEclJYMTZ4cjhoK2YvYUlndDNSZDRkRjRpRWx5eVA1RmxI?=
 =?utf-8?B?L2I1dzF0aUN5SkhuT25BaHQzQW9jaDlrVTlWTWVDQks3eHNXb2k1ZUhQVzE4?=
 =?utf-8?B?L0k3TWhUdWNYaWtNcHZwRE5IOHAvV29DQS9Da0t0ek92RWRxdjNJR254cmhp?=
 =?utf-8?B?b2lpRmk2VkpMSTBhRjJTNjFJM3lHZEJ6N2VibTZWVlBKMmFLZ0ZwelJ3bU9R?=
 =?utf-8?B?Q091NlJLSG9HYTFoMEhxbWRucE40dkFxeG12Q3VUTFR5WEV2SUZRanpqbjZU?=
 =?utf-8?B?akFQSktaUWFzNDlqOGh0cGgxSHM4OE5oZlQxMjFCNS90dkFlSUZuTG9uVEpI?=
 =?utf-8?B?NExrbjY5OG5md28wVFg5Mkx2UVFPNUdicm16SUgxQU1WNW1DTG1Pd0dma0JO?=
 =?utf-8?Q?5kTZtO/erQphzFyQXt9jAOVrK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024a8bd2-cd0a-411c-b604-08de30fcc742
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 17:12:16.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpzIMSHMv1jKN7aERJagv5GJ4C5kCZQHL1U9rWv4n3hYyv3uVz+k+z2qyKj1GKQRI9PmPmcKrIfbJIFxXgiIZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

On 12/1/25 9:26 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
>> Implement TCP and UDP V4/V6 ethtool flow types.
>>
>> Examples:
>> $ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
>> 4321 action 20
>> Added rule with ID 4
>>
>> This example directs IPv4 UDP traffic with the specified address and
>> port to queue 20.
>>
>> $ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
>> 2001:db8::2 dst-port 4321 action 12
>> Added rule with ID 5
>>
>> This example directs IPv6 TCP traffic with the specified address and
>> port to queue 12.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4: (*num_hdrs)++ to ++(*num_hdrs)
>>
>> v12:
>>   - Refactor calculate_flow_sizes. MST
>>   - Refactor build_and_insert to remove goto validate. MST
>>   - Move parse_ip4/6 l3_mask check here. MST
>> ---
>> ---
>>  drivers/net/virtio_net.c | 229 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 215 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 28d53c8bdec6..908e903272db 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5963,6 +5963,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
>>  	return true;
>>  }
>>  
>> +static bool validate_tcp_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct tcphdr *cap, *mask;
>> +
>> +	cap = (struct tcphdr *)&sel_cap->mask;
>> +	mask = (struct tcphdr *)&sel->mask;
> 
> 
> given you are parsing tcphdr you should include uapi/linux/tcp.h 
> 
> for udp - uapi/linux/udp.h
> 

Will do.

