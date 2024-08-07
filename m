Return-Path: <netdev+bounces-116411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF294A580
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD20280ED1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3181D1735;
	Wed,  7 Aug 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fuF9fhSa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBE1D3641
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026673; cv=fail; b=HQvECceZbM0PahetQgDBHZRw7owjwypwHXKxoIraxEROrCLbMlRGbXM7+eRY+rGflm/dg6sYGHX2+GdftZeeN30OBrI29hsUxFsigNZPquuAXm3bDLYrrTTE30/u/EYdZw/H7JMBt7gW20Ge3MHaapyfdZ2pPVpjHH5tATp1p9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026673; c=relaxed/simple;
	bh=JnBDXq7g8uQ3/zUwUbX8UsOoUur3TBnmFqQrej7udhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=je14cRfWLyhMAB2AYTTx8rsKMVWr9AsUNi+C+ZE1QQ5U0LdT2OOTJ6v8yhbyou2TZjyOef0WzVMBnvg9XyeL0ld6k/pZg7lkrifrA7khzOLGO+FPqwt3veKZdsBXAwYsmdpJ4qmXjRlwqdO+jfNYMfKd3+dITECxkorGrTm5SZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fuF9fhSa; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwRuJ0CPJzhXLKR+6tKC2fRq8qtifkwYgGhnVtYG18v44G9hRa1MuiHQTXRJ9yyhWcZgG20ADrgV4nWJo3L7K5sgaEXC8G0tQiuCUexw0MLUKyLfsEFmvC7cIvS9wmzOIzHQIHnrieeZI7gmQ6Z+hfcbPLLuuM4vszttaXA8mFJ6JxF8KT4iyVtCx/uBJ9GL0wSc0t4rek+oLeTDnM1K647L+Uw1MaxhgIT2EFzwWexIt5oIdxPL9KX0LVwWMyK5GwyeUOP8Z5u3ONNn8kWh/6w3UVAVJLFW+5P2GsFpgVMublggC0vT/I4d33YjfTZAGszoN6RY7WL6r7IrfGKTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrceoXGVEDrNfvi2DZJAa0ahKQ/VhM79wWRw+7dbeRI=;
 b=Jhm6f6GafBrX3nC3w5BMEMPV0WZSdlVFE9CWQEnarc7hCmohojiji4IgxEUsk9TsmaV8OcN5HDINbmcdBPUaB/diQuIm3Z5ld7zew3dRK6lQZZMo3xrA9bMWGPL22k2mexrQ7dxogz91Hj1+Tgh2v2rlLm3rgSRvMQWsX2yWgtSZW+PowC/8PSNMCbf3CXYRiK3eqoeYsdYsPoM+6WOdk2LdYQdg47tji24gQg07LUTJXuz6RBLtanTe2ysu/CyQEupg+lyexAirLqONtZ0Y8wLEo7Mpmj0fciNrNcxpIgOYaqdtPq6ayHcAL6n5KwfxyGkhUTmCufp21hDc94iFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrceoXGVEDrNfvi2DZJAa0ahKQ/VhM79wWRw+7dbeRI=;
 b=fuF9fhSavqAdZtNm82mZpk8/aQx2zq4YwPsSIZPsxViKBL6kjKf9vCWObQGOTTpXJsakWKveb3fYamBuUDx9gSjbJhA3L+iY1Taltt1qe+xpk1ZgMb5ZzZD1aRAGwJzS5X5SsxEBmCLjXvMi6X90duwTvzSvEU5eyP5uHML6bAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 7 Aug
 2024 10:31:03 +0000
Received: from DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::6392:e010:ed54:1606]) by DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::6392:e010:ed54:1606%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 10:31:03 +0000
Message-ID: <e6cebcb7-a3e0-076f-e099-420a143cbaaf@amd.com>
Date: Wed, 7 Aug 2024 11:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net] net: ethtool: fix off-by-one error in max RSS context
 IDs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
References: <20240806160126.551306-1-edward.cree@amd.com>
 <20240806095426.6c4bcd2a@kernel.org>
From: Edward Cree <ecree@amd.com>
In-Reply-To: <20240806095426.6c4bcd2a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0329.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::28) To DM4PR12MB6207.namprd12.prod.outlook.com
 (2603:10b6:8:a6::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6207:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: a03a3953-b77e-4e00-633a-08dcb6cc09dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0cxWjllaVQzdmRueDBIRnE5OUlPbHF2bER5Rmt3cmxYOG92Ums4aHRSd2kz?=
 =?utf-8?B?UzA2dTNRRE85NitLV1hvZzd4bWFFWU0ybDZ4bUhDeDdFL1Y3Q2JKdnBVR3VO?=
 =?utf-8?B?NW40S2RhbXJmOFB4WjVoZ0Vob2djWEhIYjYwV3ZRZGNBUEZ6Vld6Y0tpWlQx?=
 =?utf-8?B?V1BuVHV0NkJMY0ROSWxyeG1CYlp2c01kaXVDNXlha0E4L2tOOU9aTTR2dkd6?=
 =?utf-8?B?SmtHNzBoRVp0VnUxZVM4a0E1RXZNTlQzVWo2S3JtUHJpSkdVRE1VZTZDWWx0?=
 =?utf-8?B?d3RiMEppa3hlbDY1UjFkVnUwMmpmNFF6TzUzdk9PdmdnODdoTXZIS0hIK0gw?=
 =?utf-8?B?VEdXREtFVGhRdWE0YUZxMGlBOUhzYXpVdk1TUUpJU0FGdDN3REw4S1J2NUph?=
 =?utf-8?B?eng4QlZrU1dKRHliOHJ1Z3FaaXgwSVZDcE50SUprclJ5cENkK1N0aEdib3dn?=
 =?utf-8?B?QnVDemp5ZUVzUEdxVHhtQXhJY1NNTUl6MDBNcmlCbmtKQ0ovQStoeEZQQW5o?=
 =?utf-8?B?eCs2ajF1RzVGVnJCb1NVMGZHM0tCaGc3cDQ2OVhJeDFZcHVWZFJCajh3UnBC?=
 =?utf-8?B?bHNaQndLcVY3c2R3engzL3p1WDZmTUIwbzJGU252MUxqVVhnNHhFdThHa3c3?=
 =?utf-8?B?K0hXQXF1UEZOT2ZjdTZpTEtvQ3g2Z0RNMndJS1p4a1JNNDdUOTJtN0NkR3Iz?=
 =?utf-8?B?UStoeGVmVVY4Y3A2VkcrOXY2SXo5cUdlVUY2NGE4bmx5TkU1cm5YeTloMGlp?=
 =?utf-8?B?R2FZN0RnaUczNXJSaHdDMkRBRnhSM2tIOTIyUURkL2pkV0RSV3ZpOGRqSDBj?=
 =?utf-8?B?a0QvdFNOanpBV1FzWndaejlKNXdyOURBWEFuQ0VEcUEwVjl3bkMxZnVVQUp4?=
 =?utf-8?B?SUViU3Q5UGlvMnF0cE9jcndCV3pzNGtidUpyVWxydTZndnlLZ2ZJUTRhbUFm?=
 =?utf-8?B?NzhGWWtNSlJvWTI2QnpIbEFFZDE5TVUxbklsTGtPYTVTTTZkRjhIa2JuRDZl?=
 =?utf-8?B?Zk5vZDV3cS9OQWVGdDRXMlUxb1VOczF5ekZLTVpuWHgvNGdEVS90b3ZSSFZL?=
 =?utf-8?B?QzJmeHlla2lkcW1JRWlkdCtWOXpyM21ubUEyanFCaFBwYnI1N1dESmN1Ny9W?=
 =?utf-8?B?NEFFVUliZHlhYVRQQ3BjTWd5UmZKNHNiQUF0UjlOVXhyVC9ZTkQxOGdURFBT?=
 =?utf-8?B?VlhWVmxsbVdtY2NrS0NseEMxTjcvUkhGMm10UVE5SkVQeXFDUXp4NW1mOThz?=
 =?utf-8?B?eXNtc2x1RHBKR2RPWHozWVM2TFRqNEYzL1JPRUVkNlduRnZWQnBLSjltVXV3?=
 =?utf-8?B?MzkxVW1sREthemtNY215d0hway9YTjZUUU1oWk9jeGxwWDJRd1dtUlFxTGVi?=
 =?utf-8?B?cVFzM3Vad2xWbGpSTkNrWTZmMzFmYkszWDA5YkdHbmlWdTBYamRRVEh0ZHE2?=
 =?utf-8?B?WHZsTzhmYkpJaFBiOStKVk1tZlp3akFOc0dOYUJlQ1VHaUNwam9EbGgwZFZJ?=
 =?utf-8?B?QktIdFhMd2VGTEN3WWRNQ3d5ZTlRbStZU2VGYjdZY1dkK0labnRWMStlUlUz?=
 =?utf-8?B?aVZkS0RodklESGlNUVpNYjdjR01GWW9EVU5lMGpyWkVhWEhLY0JvSWQxSXVl?=
 =?utf-8?B?cDc0Y2tpcGN5dmw4WEVEMmRvZDh0RnEwMnFXTmd2K1BDM1YyTlhqdUFMbWZz?=
 =?utf-8?B?ZEFsQ2J6N3QrbkljOVNVbjFEcVo5RllITTQzeFNkQzN4cDNmVTlPa0pmOVB5?=
 =?utf-8?Q?yq/SzaWan2I+qHbeUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHZxQmhtUGs2NitmTExCaS9mb0N0SXZQR0lDdHVqcEI2dVFUNE81d25qWmpP?=
 =?utf-8?B?RW9neGdiU2NORGdQSnNYRllhckxiRFBvNWdlbTlsS2l1UkN4S3BMTlVHODJl?=
 =?utf-8?B?Z2xBUHVHa2VVNklVR1FRZ0NjUHRBSjcyWW9aUXBFUndQSkZKbXkzUVU3YkFt?=
 =?utf-8?B?QjMvTjVXUEpPT2oycUhycE5mamNEUmUxNlhmY0dIY01RanI4T3dIWStzRFFK?=
 =?utf-8?B?NitJenNxUmZnQUIrTTNyT0poZmVhTWwzRFVtWWdHMDBLYVB0KzJNWmgzRkJz?=
 =?utf-8?B?M2FVWXE5ZHJ5YjA5eU1OUm9jNG9nVnhNUUlTUlZPdzR4dXptYk5sZHE3MjVk?=
 =?utf-8?B?TXlyVlN4WTlJckJXK0t3REQvZ3lvdUs5VHJqb1czZUV5SjVVTTJyQlFQUXVF?=
 =?utf-8?B?eXNiNzRqQi9QbGpxcGxsb09yUXphWk0xVEVnelhzOStYcUd4UTBJUEJHTDdo?=
 =?utf-8?B?Z09uai9IMi9QQm0vOWJaTzgwY0ZlT3NTN0hySGhXd3lkd3ZHWU9WYTNrVXkw?=
 =?utf-8?B?a2Rkckk2TERXWDc0K0piMWpqYmNzdGJycDJnejF3d0tCSEI3a1hteTdQYUYy?=
 =?utf-8?B?QWtIVWJmOGZCL1VLUldwTzB2eWNGZDZMV1U5Z2o2VFpnTWRwQ2VmL2NhMzRY?=
 =?utf-8?B?NkF6aStyNkNNY3VLUmJMOVJqaE4xUE5GaHA1VmpSZm9VTWFXaEdmNTh2MFVJ?=
 =?utf-8?B?b0t5dXdLMVkyamhibTllNmtYdUwwZ1oyUndTeTFnQlpnQkIvdUZQSlpsRWs4?=
 =?utf-8?B?VU9IekNxSlRnelIrckt6TlpQSlZSTk8rZFpKbVdVbmJWZm4yZE1GWjIvZURD?=
 =?utf-8?B?TWEza3JZUmdObSs4dGNlaE11QjlIeE9GK2dtZVpuNkpLSGlwc0NoMitxZFRu?=
 =?utf-8?B?SzFzalY3Z3NSc3NVZTY4a28weGZrY0U4ekJaTjRteTByVnlyZW9hKzFsMmZS?=
 =?utf-8?B?L2FEL2Y5bm1taVJaOXgyMWhYRFhNVnpiaTU2UHJVcTUzL0xGVGF0TG5HYmhn?=
 =?utf-8?B?L2I4dzMzcGZIRzRYZldvSGRQd0tIc1NDNk9nakFSc2ZjeGVvTEJvWG5qTkRZ?=
 =?utf-8?B?OXd6YXNoUDBwdVdldGcxeStCSWR2TEVSbG9zckRRRnNRa1RZM3p0U0pIQmxH?=
 =?utf-8?B?a0lGODJTQStlZXNoUEZObHVadTJVR25DTU1aVmNqbDNORFBpYkpBMlFvSWtm?=
 =?utf-8?B?a3lWSytqQ21SVGtFaHcxblNDMWIvaVQ4VUdYczA1WGNETW5YMkhVMG54QytQ?=
 =?utf-8?B?ZmhTcFZvb01QSWRGTWMrN0lzTTNzWkZlblhPK3FocC9FOXVFTHdCZk1qRG5C?=
 =?utf-8?B?V3pURU1tYVBBdjFBYlQ1SGpDL1U0MmIzMmlTVFhQejJiRnhnK0ppWGFPTXp3?=
 =?utf-8?B?QTUzamd3enBPRW1UTytoUW9PZGRKZk9UUnh0c3ZLUjZaTERiWkRteTVuOXE4?=
 =?utf-8?B?c1FmdlU1dHEvd1AyUDQ5bXIvcmNSakNTREVHdUZuRENpMmhGdXdDV0ptZkxD?=
 =?utf-8?B?RkpHbTA3eGdwKzZpOXM1Y2tsTkttbklhVkNZUElyNTJKdnozbnlZVUI2TzZl?=
 =?utf-8?B?ZTdBa3JLdFRObUZRRnR0WHN1ZDdNcHZucFpTSVV6dzFvT1RUZzAvbjdlZW5l?=
 =?utf-8?B?SVdsdDM3Z1ExbC9IanpkQ1d6eDUycXNMVXFmYVgyQnFkV1lJQmUzV2hCOWZ0?=
 =?utf-8?B?aGovMzExdXNDc1RwK0lENW1tN0hPdk9SYXJFQUZ2OFpPOFY5S0YvQjNWc1p3?=
 =?utf-8?B?YUgvVGxvLysxRFdzMWpFVU5manIrL252TUs3U0VyMjlvTHFwSXpia3lTTUQ4?=
 =?utf-8?B?N3VpVW51SWNDWHowY1QvSEtkeS80YkM0SFhoWDRRNVliMmhkTjNjaVFGUDV2?=
 =?utf-8?B?SEYrTE5tdkVpSGtmcHdLU3VNeTFFV09IVVpqcDZyV1JhUTRiRmRKTEJmZVlB?=
 =?utf-8?B?eEZMU2ZBa1VkZGRZRlhyeGQ0SEJLODNZUXUrdUs4YXhyRFNXM0RxZ2dyNEtn?=
 =?utf-8?B?azNiblMxZVhTVWFJOHFNa3JwTVJPT2llL2d5ck0zelpYMytGNFBEK3hRaFRM?=
 =?utf-8?B?RUlFYzZqdnlMUTh0UlBKeTkyYnVHSTQwSFZhZ2dvNnVmQ1phbG14bENiakpx?=
 =?utf-8?Q?yhSE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03a3953-b77e-4e00-633a-08dcb6cc09dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:31:03.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4d/KnzcxEjnMRuo1d6LxYr2/uh5jfOFR6WviK/ehJ059Ob4gNaR3T5anEshMw8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

On 8/6/24 17:54, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 6 Aug 2024 17:01:26 +0100 edward.cree@amd.com wrote:
>> Subtract one from 'limit' to produce an inclusive maximum, and pass
>>  that to xa_alloc().  Special-case limit==0 to avoid overflow.
> 
> It can't be zero
> 
>         u32 limit = ops->rxfh_max_context_id ?: U32_MAX - 1;

You're right, -ENOCAFFEINE.

> also1 if we want to switch to exclusive I maintain we should rename the
> field

Okay, will do.  I misunderstood your "if we change the definition
 of the field" remark, because in my head I'm not changing the
 definition ;)
How about rxfh_max_num_contexts?

> also2 check that it's not 1 during registration, that'd be nonsense

Fair enough.

> also3 you're breaking bnxt, it _wants_ 32 to be a valid ID, with max 32

Fwiw the limit in bnxt existed purely for the sake of the bitmap[1]
 which you removed when you converted it to the new API.
My reading of the bnxt code is that context allocation happens via
 a firmware RPC.  Pavan, if the firmware can be trusted to reject
 this RPC when it has no contexts left to give, then you shouldn't
 need an rxfh_max_context_id in the driver at all and you can
 remove it from ethtool_ops for net-next.
To avoid a regression in net I'll change it to 33 in my patch.

(Typically rxfh_max_context_id is only needed if either driver or
 firmware is using the context ID as an index into a fixed-size
 array.  This is why I consider an exclusive limit -- which would
 be set to an ARRAY_SIZE() -- more appropriate.)

-ed

[1]: https://lore.kernel.org/netdev/CALs4sv2dyy3uy+Xznm41M3uOkv1TSoGMwVBL5Cwzv=_E=+L_4A@mail.gmail.com/

