Return-Path: <netdev+bounces-234425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65DC2084A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A0D18919C2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06DA20DD75;
	Thu, 30 Oct 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSqqoIRB"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4656B81
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833309; cv=fail; b=pCnunSSOdVgPryr2UEqiq0xb/BhSYYaaSTzlC3K7RGHWBKqxxGirwaJDI4TqQLk90pc+uCgnYYQtEaqGt4/x+ZLMh+aUv5TyxYXq8MdEzf2cO8XoNv6uM9rNwP+Lxc7GWHPzNPN0f4riM213/jsKBW+QHvoexVMTNGq2UOFB5uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833309; c=relaxed/simple;
	bh=lqw2n5U67F+O7SPiPQ/mM2pmQXyCFx8Q5j77xr+Qyf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrtXUgqJmVM09g1JU696W32T2aDPelCWfhb0/ODTKSTSswlDQ+Ogd3tKKwhyRsDdb31oA8a1gq7ufkyqohXvR7vkemF6Y0wkfRAV24aoHci52fdSH01zVaytLYlutPx3YQFMOlzdhOQUepMAcCyhBOMGoS4pcfoGCAvE+RAT7c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSqqoIRB; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfnWRkI+TV52f9vFLH8vtAc3/TOjGxfVUeiGvC5T6A6A7YTzODAaZua/vcF0IBIjVTq/XrPShRI16q67cRZHbc/cqGKcgSIwaX7tYlcK/g32VDBF6NgHCFQennBAxBhxbvBW9vUb3jbheIqZG+ADD/6KjoaVPf2gBOy7WLrOgRZdXyfLHNPaJ+dLDfIlJ4NQv7mWFcWxCK2gFpI0NHi4e2LpKLWSpurLndwC13XebkqsI9hBwLN7IFGiRalBpFEJRcVZ4NE46chqCWlD3p2HV5aJJIMnMqLUc8YzHkHlE7tjmrBHhXI42rGZSgaZyrFeehwyOCnG2HrGgUPzOPnAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cQuyLlX+aCbkGNGRvDJ9ohR882KXjMceABL7mBegbE=;
 b=Nk4XWRTiFTqaZFeObcEsgpmxu17VSWTXiAHwLAvmbf/VMRJHx/cDXIO/ifg4xtJ54WYGkXYcZM38I49QG16Y3vu42rf881JwopIXfxAzsudARP7uN39pS+yTBGigp6EER2zBgEl5v3HXTd71CWFy25Q9MIHbKeN8TSK7XTUQC9yxxQ5hiI95aCuRCfxSYUpDD6rq7g1VhFARNTC/ps56M2SYlFAx2vUtlCqyKgNd3awPb88pnJydPAbmeeaIehUV5sC0KVpAhBYn59BNmY9xgzYUQr+01G3LR11IsrH+bKDF3Y2tS2nbNI7NQZbbs1b2rj29pZw8Ro+bKHpwIz4hqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cQuyLlX+aCbkGNGRvDJ9ohR882KXjMceABL7mBegbE=;
 b=GSqqoIRBppB6RyjqZ/MQHTBn/0ZqZNTVuIAio9b7iLbmuUa6GdArbObaPXCDNHxdK9+f7IGQ2ZP30Wk8o0RoxqUBiiC/hhf7Fq4DyJ64Ho2+ZDwkh/lc8eLm1EgKzjDs18HjzeEmrMrqAzoTqzPKcEFjSoXti7v+pL0uqFtBDLWpjepk9MD0haHSvJhWVDXrblrLBZvaOsNsarrfV3GuOIuskCq4/MlQi4bAo3+hALbokdFVmW9wDKfWAlyh+nZ63gHqJ8TtJhTAlesLFyuhNeeYWHowcdbhDL54zUMipU34Pm6WO8etJP4bZQouIMesB/HT8LmzYrmrFFjPF+BP3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:08:21 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 14:08:21 +0000
Message-ID: <b473a2c1-6bc7-4830-bb0b-85ec7315f7a7@nvidia.com>
Date: Thu, 30 Oct 2025 09:08:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] virtio_net: Use existing classifier if
 possible
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, alex.williamson@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-9-danielj@nvidia.com>
 <9d469be5-e2f3-427d-9e6b-5d9c239fcb79@redhat.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <9d469be5-e2f3-427d-9e6b-5d9c239fcb79@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d7fffe-3ed7-41e9-4040-08de17bdc826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T21DQlhsTGo0bUhaNXBjVmg0RnFLdWlSYmJrRWk1MEcwWkphM1pKMUt1OFR2?=
 =?utf-8?B?QmhUemZQdXVCbkdjM2MxTE5BT2JXZUs0TEZsRUZwRFdqRno5N0F0eEJWdXk4?=
 =?utf-8?B?MUhEYk9XNk9mc3d6SWZFaGxDVXpKa2VZdHZXVWpFd3FNcE9XVC9wTlVObUpw?=
 =?utf-8?B?UE1TNjc1aGFySFMwNkM0WGlCZEE0N2pIaHhqODAwdWY5TXlubExja0hQSXB6?=
 =?utf-8?B?RXBoVkZmcXlrditPTmlOeGc1aC9vVU1kQWZrM2pTMFhCSjdRTHBpWUFxY1l4?=
 =?utf-8?B?R3VGN2YwU3BDaXlKTk5ITFBDZkExNUFsQXpISlhERWVLYVlDc3FMTDIxL25j?=
 =?utf-8?B?RTluSUk3K3BOc3RYSWJKcEdqWlZ6bXlianNCUWNqUU1sSWVpaDIyWXQ2YnEz?=
 =?utf-8?B?eWZqYzN3SGg3SEJWbkRJQUNjYU5QN2NBbnBsQnhuSTNMd2FKR0J6VGF6QXlB?=
 =?utf-8?B?c2xreVhRTm5EM1hZc1dwbDN5eDRtTExxWHZnZDNNdVBTK1BCQ01FTVRpclhF?=
 =?utf-8?B?Q2psc0JqRWpxM1UvWS96eC9tSzJZcm41S053ZFpZZU5oaWlvOGl6NnU4V01w?=
 =?utf-8?B?YlVlN3hnVGpscTBuVTBTWCtYR0w0ZXB1bkVGY2t4U2JvdUFySmhVd2pYcmFs?=
 =?utf-8?B?bGE5emNySUNxYklHQjgwUjRxNCtMcUF6QnhoVzMzQzEzUjhlZ1FXNThIRkRS?=
 =?utf-8?B?WHlQeERkYlFoVnM2VDRIOVFMVDUyekY5K1JHSFpSZDk2a0JrM3VPVnBkRlcv?=
 =?utf-8?B?TlFVc1NjQUozUmpXZHBpdVpTS0VqUmI2RDc2K3ROQUN4RGlTaVdodDBSMGlN?=
 =?utf-8?B?cENNOUtsUnBGL0NuVm53MXVrM2lma09zd1NHR25PMFJtbU9FTVJ3cGs3Uk9o?=
 =?utf-8?B?Qmc4OGlVa3Q2b01xMURkNEZRd3JJYTl6c0cwOUJQR1FPZFljUlltRmppMlkz?=
 =?utf-8?B?cDhQS1VpbmVkb0ppWHFqaVlCemMyUUs3VlE0YUJjYktWN1RpaEZqbkJvVHVt?=
 =?utf-8?B?KzVIWVpSMk0wTnd2dTJnS0xrZG1XMGJic2VmMXlGcUVkYU5HWU9paUVxUHR6?=
 =?utf-8?B?d2xqNzZ3UTFEQ3BaaWdSNXdUZXJvc1hkamlZMUtIYjB5NVV5dk8zWXVENjkx?=
 =?utf-8?B?bXQvM3pTTHBuZWpDcXd0b0dneGFMeTJyZUpUTjlTTG8ramE1MTJ2d3V1NkE2?=
 =?utf-8?B?NU5mWlF3MFRqbHRLeHR1V3Zsb0hzWmcxVGhhYXVtU1Q2eFBYOGNOcGdrQjAy?=
 =?utf-8?B?VElWejN2WkIyejJpVmM2eHFqdjNNR2lLdldrUEdpMDlHakw3OXN2MmNpOVMw?=
 =?utf-8?B?bWhlSlcrSW9FSWpSekU3TTNVT3JBdU1OaUV2emFaRDNjdzUwMC9VU1dpM2R2?=
 =?utf-8?B?YW9RZlV6Qm1sZTRPMFNrSkNTa3NDTmFsTG5ZRDVmQk9zb1ZqcUJNQWVRTXA2?=
 =?utf-8?B?OXFJU1FvL0NKZmt5dzNaK1IyRkJVbXNoMUhZRDBPY0RKdlFiZGd4M0NXUFcw?=
 =?utf-8?B?R1ZmZ1poYWhHQTNQZmJjaTE4aDkxYzFQSXlXT3M4OWxFWE1icHNmZ1VFeXB0?=
 =?utf-8?B?K0FiZHVGSzAxNE9va1NqR0hkblNoUDEveUc2SmJ1dlczaDVIUWczdVUyT0c5?=
 =?utf-8?B?dkR6dXlINis5SXJQVnhHejRZR0x4Mk01MzZrZlczZ29PMmF6UlFvS09RczZL?=
 =?utf-8?B?Nng5SmZvRlRWUm82TWN2WUh4bTM5QVdFaVpHUEZJbTZrNCt5R0hPQld2UkJI?=
 =?utf-8?B?ZWdjZWpBQW5tNUs0LzFEMXdNcUZscDU3T2hxTUpFWXdsRlJwcDNoaWJGVTFD?=
 =?utf-8?B?cmVBOEgxekFOdzAxNEtNL28ycXlJZkY4WkJjMmVqaCtPVWhxdEw3UHcwNTI2?=
 =?utf-8?B?MXpEcjA4NDBuRWwwdzhWY2o2R3NNMVB3RXFpZHYwRUxvNWNOMWtqTjlwUlk2?=
 =?utf-8?Q?1F59gOZhnEUGuRx17Axh3OsygpS5eBvw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c29lTzc2UWhqT3RMN0JTMFJqTG94RUQwT2tlTUVORW9rdGtmcFpIOTA2Q05D?=
 =?utf-8?B?STZ0Y2J4Mm9KN1RsbW9yZjZSQXQ5TklGQTJQQ1V1Y1BMU3lNWXZXSE1zZHRn?=
 =?utf-8?B?Tis5LzVHWk9XL0o5OStaem1zKzVpQ3hHdWVqb2l1ZnppMERCVDJEQlUvQzVE?=
 =?utf-8?B?UHFvOHUvOUpTcGo0b2Z6b0tLYjZNS2pSU21MK1ZjNUpwWUE5SDdXVEVXYVBF?=
 =?utf-8?B?Tmg1WmF1VGZ3TERqMjNTbzc4bkpLMXdVYjdTZ3RqTUlkSnIzQjRRSytIVlRO?=
 =?utf-8?B?UzA0TkVPemFDN3k2L1UrRmpZcGFNNXpNMjBZeTY1QjlyUDdBeVVQaStpUVRq?=
 =?utf-8?B?OGFLTEJ0d3RPdTJoY3A3eVk5WVB2ckhVZVl5ZHE2a21IY280bVlVRGgyWkR0?=
 =?utf-8?B?VWJpN09IUENQZDNzaVc4VzFlNHdET0tYWWZzdTR5dU8ydXE3Vll2SFM4M3Zw?=
 =?utf-8?B?Y2JUUTYxdTRyNW9qa0lmbmJNN1Rzd3piOGRpZG1IWnN4K0QyMFNkdlV2eVpz?=
 =?utf-8?B?bXRIRGNObXdrcWFuNzlqRytBOFk3K2kzQkZ0c0ZzWElBV2RlNVdNU3NERUVD?=
 =?utf-8?B?OGpVQmJrY3pBZ1RvVG5UQm16eXIzU2x3TUZEWHZMc2hzUlQ1dGVseHJzSmI4?=
 =?utf-8?B?QnVteEl6V1Ixdnc3bU5hOGpyNFNYQ2pHNkszdWpPcmZ0ekNEQVhKZUZCRmlh?=
 =?utf-8?B?ZmRjSkNFcXUvL0xObXBDZlFpYjI1Z0tRY1kwanZZNVBwRHVjKzZRejgyUXlv?=
 =?utf-8?B?MTJwd01WM0JlOUJnM1gxYUxQWnJUcHJjanRISzRkR20zNWZLbDhKS0t1MklQ?=
 =?utf-8?B?cm9oQnc3SHg2Uzg5cXJzeFR0ZTdoSUpDUUNIYWo3U2RJQjZzTnRZbXhGdVhy?=
 =?utf-8?B?cmh1engxWTExTkpENmhLaG9YWlRVbmp0N2ZTU04ranhzR3h6cUYwWDRRbHdw?=
 =?utf-8?B?M1BMeTFJbWYzaWp0bG1GMHdjQm52eWxGSlJkV1M5VnVFYXY4cXIzNHBQdnNK?=
 =?utf-8?B?RmVOWVE1b0M1NTNTTWh4aTBqZGFFeGtsM2NhVSt0cmt5UlFFczFuYnRyd00v?=
 =?utf-8?B?OEpjTXZtT1crZStiQWQ1K1BaSkowc2pCdFdRT0dxL28zeWF4TVJyTVpDbHg0?=
 =?utf-8?B?V0VvRjVBc0FjR2hKeDUyanV6QjN1a1NuQmpDNkJoWkZyemMrMXYwTlpMK1l3?=
 =?utf-8?B?aHNPeHFEYi84czFqZzBnWCtkR0sxNUJEbGtud3lOcTRSU2Z1cTUxU25oNHJ2?=
 =?utf-8?B?dGtpUlE3cVFVQXBkSVpxRzRiNmEzY09YaTVvZGRPMzRuM042NGNiVUc5bUFj?=
 =?utf-8?B?dVBwMDFLZC85RUZqR3pKQlE5bFVjRFA0ZVRGOFoyaFdnQkEyMGEyM3pqWFBz?=
 =?utf-8?B?QW0wZ21XZnZxRkFkMVBvQ1pad2VuNmxRL2Q5UVo2d2tCUEoxZG9UbDVEWUkz?=
 =?utf-8?B?WGZQUERIa2REajJvazQ4Y1QzM0Y3RnNnMERvajkrVWFHbUtWdXJiSndqMk1i?=
 =?utf-8?B?cERjTzBWOG1GbS81aDE3dlZoREVZR1UzZmo2Y3FMc2QyZVJCTG51SkFUTmpF?=
 =?utf-8?B?ZjYzSGlIOXp3Nm5MOXk1TWNHVGxDcUovZnBMeHdmYWsySHRJTTcrMC9ReEdj?=
 =?utf-8?B?NEplNHRSNWtaT2pVUnlxRVVySjIwM3ZUVGd2cVJNS2RVTVV1UFp3d1hWSmE4?=
 =?utf-8?B?eU0wV29jQ3NuOXloZ1NUNC9ldnVFeDlmdkJ6S3pzY2FyOURIUXFjSlBIdDBk?=
 =?utf-8?B?UVNIWGR4aWFwbGxmS3FjcDQxWnRBQXk5OTMvS0EwYUJzaklhSVcvTUxQbVJU?=
 =?utf-8?B?aFJJNnRvUXJxNlBFNVBIZjJGVHNYM0xVbXJidnhaSE5uQ2phU21RbVREeFlI?=
 =?utf-8?B?VWFpSUxLblNVZy82c0dCNTJRRllUckQ4SDBaMmJyOWF3Uy9TRTV0bEpGOXRw?=
 =?utf-8?B?VE91RWoxa0JGWGNENWw3cm4yMytmelIySWx3VnBIVTBGWHV5cSsrTVhRbVIw?=
 =?utf-8?B?cjBIRGNrNjdsbVZxY1YwNVdLL2VOVlN0TGJ2Q0c5TlJCTUpiWDljMDNVZDh0?=
 =?utf-8?B?ZE1HNStPS1QzcUovMlhpMGdpemNSaWlBdXlPN1h1TEh3OHZ1eXhrVDVaTGc1?=
 =?utf-8?Q?m5biiz0jKLq3+rch0HISheulR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d7fffe-3ed7-41e9-4040-08de17bdc826
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:08:20.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GF8HMj3UKeaASyNP9xMy1uCWoS/WgFSL3ouz4LbWXmpMpaRFDKlL6rdoz2gK9x9Nj0TwsnK9CQv1naPt9u9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On 10/30/25 6:31 AM, Paolo Abeni wrote:
> On 10/27/25 6:39 PM, Daniel Jurgens wrote:
>> @@ -7082,8 +7097,9 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>>  			      int num_hdrs)
>>  {
>>  	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
>> +	int i;
>>  
>> -	for (int i = 0; i < num_hdrs; i++) {
>> +	for (i = 0; i < num_hdrs; i++) {
>>  		if (!validate_mask(ff, selector))
>>  			return -EINVAL;
> 
> Minor nit: this chunk possibly belongs to in patch 6/12.
> 
> /P
> 
Yes, you're right. Thanks

