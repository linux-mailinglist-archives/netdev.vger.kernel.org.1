Return-Path: <netdev+bounces-128567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725897A5C6
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068782815E8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746D13D62F;
	Mon, 16 Sep 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Le1pvFAI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375E17BD3;
	Mon, 16 Sep 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503223; cv=fail; b=hcP3w6tOXkZrdY7mbgU7mqiLzFtxf0HxmypvwNW4OeIAJWsdzdTCiJW4nw81heZdylO64wFka1FBAVgnVLH9auzKWeQMGcCPqbDJ0cP2XHDIcvWUrmsw0lipfxnCajHfyAePKrZQ17vj4XdvQ6EjADaYR5reHkDzM3pFA61/o70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503223; c=relaxed/simple;
	bh=5YXqLaHrc6mnNPjhELHNN8I8SQbdqj/fd1mZJjRx6go=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lL0hM+/2zrFo1J37WcLQY3+2bW0ec+AZJhxDaD2IsBYa51gNklPWPfPgU3pDUjV3gPxE4rfCXCACUyrdugO6sxTUnUTQunckadpNOTMJhYoin6npc2W2YTp0uCAI8hnaeKsgqRmgbKOLRbv7TlqPzy5t0eMQVxHDo2d76ohDZ3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Le1pvFAI; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYuYa1vX7QKd0DAl2akivMjCkPzsRTwM24oewChKJeNVVDEmi5vBFCnlcEj/shBGCnfR9j3K7Z2OYugrK0BamonD75CC/XipLha9Qts3BhJY+Pt69wmZQDTljFqw7vkPiS5dtd6LE4DL1tR/PkLBgWj/NzB3Ge873/kwEK+5W78zAhU5nXqH4+pvnNz3wolsiOXGgF68mE+HtXSMjefHimwcWjizBchgTZznYTOrAMoJUnEuBMLAUPaSwPVVYfTHI2G77YeBzM1VsG6w1Y/7d9wYTX+Ki9jyO0GaUZ4jFnMiAq9h584ab3UtmiMAK+OWVKAFvPJa1UnCBF6j3zR9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d09/S3E+pCblyigJ17hkp7Z0QJCfZP549S0IvJcTXkQ=;
 b=kwrr5NEbashZO3Pjq3tULzAHhBfm3Awp8jTqOP2YHznF+PsILBMKGu2HZAtu7hyW7YlaTCCfromcQgRyrWEqFtrILJTlVMdb0cACv0IA1+oSqnpJ398nCjmXA8pAMilDFYzcWObRN7ZKd1uFUq8xbUv+caaLiWQDLkVBN8SCz6VsLhV42hvxTx9mBJAkRCVkHJPANdU6f7zKe7GGjKoNRD3QiB90P099Pnq/QskXO+6MMC0vALiPPhFKKOdw065NTZO22duP4WZEGUzSXl53CsHLiWAlRAzElvL6iyRPOPVNnbrVdtQx7BirQQoMn9JacnR6CnWFWzB5yFT5lr6m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d09/S3E+pCblyigJ17hkp7Z0QJCfZP549S0IvJcTXkQ=;
 b=Le1pvFAI0m5BTHxCRN/rY46gUuB+t2YOYIHI41UhvkbedzB62Qk2dO/UL7FNv+H/B4QSKkL+iGuP8ZCCec4CDmY5qGQy4fd6AML38XaBmraZmE+PVf0cDXqFpVt8uqR4gipHbn4860zw1LQ/+FLgKxoVihgFuP5pTWWSu1dqER8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 16:13:38 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:13:38 +0000
Message-ID: <836ae91e-d79f-56ba-2e4c-17ffa78899fb@amd.com>
Date: Mon, 16 Sep 2024 17:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 20/20] efx: support pio mapping based on cxl
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
 <08b7b4f8-01d6-20d0-10a7-ade4ed69ebcc@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <08b7b4f8-01d6-20d0-10a7-ade4ed69ebcc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dab4ef-fcbf-4915-0a2a-08dcd66a85d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzNabVM0WU0rS2hnMndhNW8xc0ErUUtYa3hwbzNrcUptbVVwdDZzYXNoM1pO?=
 =?utf-8?B?eEhITE5tS3NpaDJ6Uk8wbXhWZldUbGphQksrVTdSNUxMdmwvd3Q2d201OTVs?=
 =?utf-8?B?bktqR0hxZHAxb2V1SWFKUEFuUjMzVXZQYUdjVFp6TFpPMkxyVFRkRUlyN3Zq?=
 =?utf-8?B?R21aUGczSVEvMFFrK1JqYVVSU1BSK05xVnY0RVUzYXc5RU02RW80ajRtTzRO?=
 =?utf-8?B?aUZqQkVyTWd5NXhBNzY2eTR1TTBmMmdLY2RDRmFtVThzZGRNZ01TTTNBcVk2?=
 =?utf-8?B?RHhmUWpsMXhna0p1SkRLZEx6Ym1xVmMrREY0bkFpejFlVnBvQmFmQ0pFbVVm?=
 =?utf-8?B?NlU4TjBpdzRQTklocEV0bFFiYWtTUEZFZ1dhR2tSN3ZXQXBRcnRwak80WjFl?=
 =?utf-8?B?N1VJZ1FDQmYwU0l5MjBzR0orclNnNFhjU0I4NmZmV3JQbDMxTENGQmtBc1BU?=
 =?utf-8?B?bDArNERzNlZGMG9VQXhqaU1rdU1iWTEyNkFCdmh2V3JkU2doR1cyUVBNSmRR?=
 =?utf-8?B?MXl1anM4YktzdzRrRFZobEZ0MytHYUxpalhRS0tzNEoyQ0ZTeWJzaVlKd1J3?=
 =?utf-8?B?QjdjMTdUM1JRbmlHaGlFdmgrRCt4cDVOVnFHZ1hwalQ5ZUJ1RnE0S0dGbFFD?=
 =?utf-8?B?bjU2VDJPQ25YUnJIYzVReisva0VDMXN1TUtYL2xVRGltcXlQdWljd1Naemoz?=
 =?utf-8?B?bzlDaGlzcEhHMFU1blkvVmtnUFByTGVJcU1odU5NeGNSbEdMWUhtaEZROU96?=
 =?utf-8?B?YWFvQml2WVJrWm9JZDFtSzJUaTQxUERXK2g2Vi9GUjlOa1lWSVlVVTJrUTJL?=
 =?utf-8?B?OFRYcElBNzltRFJDUlNHUlZsbjgwZFFnZ0NpYXdBUmN1RDN1N21BcW5sVlVF?=
 =?utf-8?B?Vm9KU3NvODA3RDlneGllM1UwM0dWakMrbHRDS2dTeVhmbkZSL2RoVzNabW1w?=
 =?utf-8?B?SWFlakgrR2taaWV6T0o5dHVoVXNYVzYrb0hJWGJtMXcraVpBMnZBRVhBTnVH?=
 =?utf-8?B?dGhSNVhTWFNxdW9YbTRqUXl6WmtsZm0xc0YyWU5DTXZySVo3UVZ5SHFiWElB?=
 =?utf-8?B?VWNSVWp5QWFqQTNXSmhnUkM0WlBHOTNVOWN0dmRhbm5XdGJLS0VyY0J5RlA2?=
 =?utf-8?B?RVdRZGp4VzBWWU1UWkZZQjNxd0M4VjgyQkpZeTBWUFJBWHJVUVZORXVLeTcr?=
 =?utf-8?B?RWo0SmJMc29PdEg4L2VOU3U3S2I2ZWl1STNnRjRkUGNCZ09rbk9rc2JUUVNM?=
 =?utf-8?B?V3ZFQkJmakxWRWE3NisyR3hvcDFGZWl1MFRoOWxDNkhJekhrR3FhbitBVkM1?=
 =?utf-8?B?bUxySktteElNWVZIR0NyK1VWbGpGVkFLYkdYREw2emNlby9PSkdVR1RWeHVl?=
 =?utf-8?B?OEsrRFNDZUswS3RmSEwwNEVncW4vckgyL0o4TTcxbGZEMnVKNHVTK1UzbHQ2?=
 =?utf-8?B?ZDhlLy9pbTRod3lMMGdLOW5ZeS9uSC9xMW9FRG5IbW1Qc1REdlhsRzdPaCtG?=
 =?utf-8?B?NklKT1k1MDhKa1dCb0ZnY0lkcU5PRDJrYlFyc2g3V01rcnBSeHI2Ry9NWGVG?=
 =?utf-8?B?TVNDRDVBM0hMTnN5REJtVWF6NUNtbmVXT2lGNHhnRjdZbXRsM1NUWU9FS0Ja?=
 =?utf-8?B?cFJRREpMaU1jbzA5WnZUc0kwNlpxK25HWGxPUWJtWm9BekpnaXF0cHVRdUds?=
 =?utf-8?B?KzRCQWRMNERGUGRoTkNlSEJuYjI4andYd1paK0RESi85SjZTTlFCNC9Ya3lZ?=
 =?utf-8?B?VkRNdUJyazVoWUIwMDd5eTRnZWhIV0FoRVJuRHlTRnArcm1yb0lpd1hsbDkw?=
 =?utf-8?B?YkZQa3c2bUFHeW04MCtWbklPSGVubTN4SloxcUJoMi9TNUZoMHp6R2c4VXlI?=
 =?utf-8?Q?tOeafWjej1JhS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkV3UjBLRDRmS3ZxR0czakIycU9FUkhBV21TcVZyOE1UM0VSVU8xeUErdXZF?=
 =?utf-8?B?RXF2dnIvOWRWVVhPVzNjM2o1SUxnUnBWZ2Y0UmloL2pwNUNvQTdVWUJjRHJx?=
 =?utf-8?B?dGNxeG95L2RHZ0dFdmxCQmN5Wks4ZG9pU0RmYVp6ZU5IdDZJQ0c5ZEhmcEZk?=
 =?utf-8?B?dnprLytwT2VsWEVCZWJzdFVzNGdtYUQrd2dxajQ4UTRtaWx1ZVEyMFRHUFRP?=
 =?utf-8?B?QmZOK3pUeUNlM3Mrb2RJL0tsNDJsME1jRjZSL3ZWTEYvc2liZkh6QjBXVktY?=
 =?utf-8?B?Zlg1QWE5MjlVVW5tYnlvQkxkcXVxdk1SVHJHcE40TEhGMXYva2xtVjdEQ3Nh?=
 =?utf-8?B?ajZzYXo3c2swZjJqS2lDd0M4dW5XTHEyMUxaVWNieUk4UFVnYm9QQjhqTG1X?=
 =?utf-8?B?WEJYckczSnFhZHFRQnJwQ2NHWkFySzlSNVEvdWJnSk1yY0F5TVVFa0JWU3VR?=
 =?utf-8?B?NHN5QWRVak5Objk5WjRvdEhzeHA3L1pNV2JIS0Q4VWlMcnBpcnhxNlBHZjUv?=
 =?utf-8?B?VXBiSEsrM1RjRFdaZ1dUL2Q5SlZCZkhOdTFhWUtHMG5DRVZyQTcrTUFNSkUy?=
 =?utf-8?B?VUdDTXdsNDdjcnA1b3ZZSmx6MVE0SnBCVzhwRjRzM3pCSm9Fa0RYNHpVWXky?=
 =?utf-8?B?OTBnNW5sNDZQanVZNHdTZUZHVU1QdkhhUm5CSXNYa1h5ZHkvK0hTU1B6M3VF?=
 =?utf-8?B?ZC9vdDZUdk5zN243RnM2b3FRNFJMN0FPU1Azb1Y5aFYrcG5LaHVINkZKNnYv?=
 =?utf-8?B?bVZkQWtabU01MlBDc0hWWUJUOHZjcmJFQnJ0NVdJK2xsM3lWd3BrT2pNc0tJ?=
 =?utf-8?B?MXQ4bFVSYjc2OGR5S3JhTjZTR29hUTF4b2N0ZzB3TDMrRFhjbEtmV1VJOVlS?=
 =?utf-8?B?QTZ6TEFGRmxITDkrVVd6aE9tcmpzRGgxWHBDbWdpL2hESW5rUXRzL1lzajRK?=
 =?utf-8?B?M1Y3STI3QXBKcGY2TnNBMzQxWUZRcEtaVnRkSU53Nk1RWEViNTRsTFNJY1Bn?=
 =?utf-8?B?ZXNlSTQ0UXB1cWp2YVVmQlJOT3pnWDNhOVViT3VkVnRpQWMyV3JyUmFCNkZS?=
 =?utf-8?B?QzdEUzR3VGNVZ2cyNmhOMllDV0YxZHZLejFRdWZRdUlpYW5tb3lpUmVNd0xC?=
 =?utf-8?B?bG05TU1Vakg1UUFYR0k0Wlo1YTdjOWd5VXBjRzkxOWw2TjF1cWJDZEpGVXI5?=
 =?utf-8?B?ckFYNlB3MnlJTmwwdUE0KzJLMlBTaWhMVHNwZlcwejdtOEpJUXcvY1BNaVBH?=
 =?utf-8?B?cHAxK3BLRDdnRlZ0alNLc2VLemMvK0htREUxYnNkdFVUbHExWU5oNXVKU0Yw?=
 =?utf-8?B?VTFnSDl1M0FiOGZtRnVTU2dUa2Eva25ydUlTT2FzZG9ERktkNVlKTE5IZkNG?=
 =?utf-8?B?MCtKMVBSS0tsNjc3eENJaWdpU2tBRzcrWTdybUVObmdaQ3duL2srVlUvaEl0?=
 =?utf-8?B?SzN6Qzg3YndncngyUzlOTmhHU25ONzhsSElUa2NKU09qSC9tZUdpVjlCYkR1?=
 =?utf-8?B?anAycXlEdkJqTml5SlRGQ3YzL0laR0dPK0JaVnZ0SGxrTVpHM1U2SkZrMnE1?=
 =?utf-8?B?Z043YnJhUGFXY3lvSU80RWtzVWJXZjBvdkdkSDkwYTBZazAxcnhUS3h1Rmxp?=
 =?utf-8?B?M2oybWJFKzJlT0NoTEdBNnBZU3VhM1RvVjZtVVRsT2Z5NUNrb0lTanN0Zk5I?=
 =?utf-8?B?Y1d5bDNTREQ1NHBjY2x5TC8rekdGUTNDZXAzL0NpYWVMNTBkbldlOUJzV1FR?=
 =?utf-8?B?UVhwZ0txMy9lVldydXRiRDNXdTBydG16cVAxRFFuME00a1B2TGtrMml0RllS?=
 =?utf-8?B?MStxRzd0MEhKMU9oM3JnaFpnRkxlMWpIMjl2SnRnTzEzbW5COFJCbEhKVXlC?=
 =?utf-8?B?M0sxSkxwaUdKV1Qvd0VsSG9WZVVkZEhLOWlmemY1OTJTbXZrVWhKTFo2SjRZ?=
 =?utf-8?B?S2hvbS9RUThUNHZSTldhQ0ZNdGFhR1BhQ0ZLRVlQanM5SldHdjhnYVJpa2hs?=
 =?utf-8?B?S0VDYms1cEtRKy9YQ2NkdUtlNVdiS3Z5VXNPNjh3YW8xbG5JU2EvZjYyeUMw?=
 =?utf-8?B?Y2h0c3JKWU9WaHFBNFlNalg0TmdXMEVvY3BMM21MQzdYMm1TQ2RJdjJGOGt3?=
 =?utf-8?Q?O99P6yKX7VSPFkxN/eNHhOkTl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dab4ef-fcbf-4915-0a2a-08dcd66a85d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:13:38.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhV/a+C9cFVhO2vqOGGje/mgr5WJhhNXAr8nQtut8SgXOmQ6Yl0irGx7TZb4zgeQMPCZ/NlNMMC6Ljz7+DPxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100


On 9/13/24 18:45, Edward Cree wrote:
> On 07/09/2024 09:18, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> <snip>> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
>> index cd297e19cddc..c158a1e8d01b 100644
>> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
>> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
>> @@ -16799,6 +16799,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   
>>   /* MC_CMD_GET_CAPABILITIES_V8_OUT msgresponse */
>>   #define    MC_CMD_GET_CAPABILITIES_V8_OUT_LEN 160
>> @@ -17303,6 +17306,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   /* These bits are reserved for communicating test-specific capabilities to
>>    * host-side test software. All production drivers should treat this field as
>>    * opaque.
>> @@ -17821,6 +17827,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   /* These bits are reserved for communicating test-specific capabilities to
>>    * host-side test software. All production drivers should treat this field as
>>    * opaque.
>> @@ -18374,6 +18383,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   /* These bits are reserved for communicating test-specific capabilities to
>>    * host-side test software. All production drivers should treat this field as
>>    * opaque.


Hi Ed,

It is really kind of you to comment here, specifically this kind of comment.


> Please, do not make targeted edits to mcdi_pcol.h.  Our standard
>   process for this file is to regenerate the whole thing from
>   smartnic_registry whenever we want to pick up new additions;
>   this helps us have certainty and traceability that the driver
>   and firmware-side definitions of the MCDI protocol are consistent
>   and limit the risk of copy/paste errors etc. introducing
>   differences that could cause backwards-compatibility headaches
>   later.  Ideally the MCDI update should also be a separate commit.


Thank you for telling me ... I already knew it.

FWIW, I have followed the process. I guess you did not see it in our 
internal driver repo, but it is in the firmware repo which is the one 
that matters here.

You know there are some mcdi_pcol.h definitions not upstreamed, and 
therefore it is not possible to just submit the new generated file 
upstream but only those bits needed in a patch. I wonder how copy & 
paste can be avoided here. Is there a tool we have unbeknownst to me?


BTW, it is almost an standard process those daily team meetings you have 
been missing "lately" ... we could have avoided this public exchange ...


> See previous commits to this file, such as
>      1f17708b47a9 ("sfc: update MCDI protocol headers")
>   for examples of how this should look.
>
> -ed

