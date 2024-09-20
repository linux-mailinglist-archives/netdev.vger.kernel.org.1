Return-Path: <netdev+bounces-129118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBE97D8E6
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 19:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6DB285639
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75B183098;
	Fri, 20 Sep 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ITtb7ckc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F518308A
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852460; cv=fail; b=lq0k0msG9CgAfRWVlWXangMSYagLRyEHGl3om0ESES3Fi+VIoEOh0o0WRgTwuJXKcvJiD2+xY9WP1yihIC6ahwR8F6Up9Jx9G1UJ0R6hLBHnmjSFMuv3N/maFr6cIfk7r2R+PtsjF6wjLJnHp3jBRINlWvYpLAO5M/wamqBp71c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852460; c=relaxed/simple;
	bh=k3ZZw7cti80ZJRe+EkOKKH34GjtNzIUmZWmn6KvT0QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZylLYz7ijwOt4XXSSmIs0gHa1X3/HRTCFdmc5icXVUSKRDq2pRdVAsjMLkyEHgvys+f8p/eQjpF4+aBRtR61HeDwbFO2g8xmR2VNFJPQkfIegX7T3yLtgHbaSYLPkWEcuIfqEgjASx7aZC8SgMu8JwnkBVm+8Nu3gZytruQ+cl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ITtb7ckc; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO2sbK4G/7T1PRe9kqzBw4Ses7LrZAr6pi8uwXkOULds1bfc8G7u31Vs85PDjqPcd3ozqv5eet4U0iG1l33h3miIy8dO94NVvELH4WcyfA2qDZ/7m93A3QLcvOiF4fOVWcI6Tx2DG3Dbu8UNWZR4068XyxOH/eGEWhcsx9KirX3j/L8V2aaxRnnyvbKpeRFvc9UYWFJkBadMo+h95PUUcWfjcnlhRfrakaFPvgNFLRfMJvyPkCJdhn+HQy7kB8orQ+AC1lZhwvwhxo9274kIRwDKdvVjrMZt8noyKyu43dd6Azneuki7J6g/b+cU9SxrnVGQC7hZfAH5Ap3UXptWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/5exH1MHs73Fu3zHpPhy+dC48eSrPFo2VqY9LzrPMw=;
 b=CEcxRXFxYMS85Y08v3ekBAYW/V+B2Csj6EdsyMP4F2KI3h71mKD7s13IfwMoFd4+Z3hGoxRfEkfi1izCN0FyaOmeyJcSVavHZsvc8tVbNCAX5KwYC19zkTgoLBd7NxEn2HTss3hLEnqCLIfhObtojqlT3KOZLKADMJTR+Yc9D6AQznOBcfa9BkD7D4hkIsC691Wq/Tav20jMGcdu0Oupz8/4nw69OOjeGUU4u6bwIZfEybAGO0FX1w4q0rF5DRlClC3fNEX006QWTGNxMrzeRQso8UayZe6YdWoRXO0+9P8aXbHQ/gtkEp8X+P0LEdSS1+HkJM+puR+Id4gmhiLeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/5exH1MHs73Fu3zHpPhy+dC48eSrPFo2VqY9LzrPMw=;
 b=ITtb7ckcLL1qLdRM3ngbTlBGlQUplCUOh5nvgVn2FdqgTNTylxsFD+MyjkL1s49FJVcHMzpqXQpXoxCZ9FCvuO9e5CoBeF0OE1EgJSL2C+4y3C3pZviNEaGV/Ct7OvEAVSksG4kA8rmWhf/Bj5Z606x5nWQNAx//o1Zj3Y/9E4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 17:14:15 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 17:14:15 +0000
Message-ID: <5cda9974-6c19-4216-9139-0ac83c95303c@amd.com>
Date: Fri, 20 Sep 2024 10:14:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: Fix entering Safe Mode
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, mateusz.polchlopek@intel.com,
 maciej.fijalkowski@intel.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240920165916.9592-3-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240920165916.9592-3-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0847.namprd03.prod.outlook.com
 (2603:10b6:408:13d::12) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2688dc-0a91-4b83-3f15-08dcd997a758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFNXdjFyVTlaZjR3SWtKV2ltOEpPUU1HTHJyMmJramUvNCtPU1NHNHl0Tnp6?=
 =?utf-8?B?YUZqZjFYeFFhSG1CWHZTSSs4UWg3U2daVWU2a1BxM05TMVZVQUVJSVJXL2E2?=
 =?utf-8?B?VUt3STR6S3FsNXNNUHhSTzg3eFo4QU01TVlKR2lBQTdDL0VVaER6TThEbndH?=
 =?utf-8?B?bmtQNElmZTJ1bVZpQWtiS0s2T3pkM0pPUStyQnAyRkZVdmRPc3NYT2x3VnVv?=
 =?utf-8?B?Y2FYK3hUT1lyS1kyRzl6b0txOWptV0svQ1FubWMwQ1dXQ2NpZjBkY3NNbzQv?=
 =?utf-8?B?QkJnTkJrNlNaUUdSVk45WmJteVBSMGdnTlIvUXJLcjVTN1ozV1U0bVZQN3B6?=
 =?utf-8?B?dEhBOUw3clMzUERqajVsME5zc01HVmdvb0l1ODBmZ3cza1ZIVGVPT0VaNU1E?=
 =?utf-8?B?a0JjOFBQT242S3RGTE9BMnNQVmpVK0ZlVU5YRW1LWWtGY2hVVStYdDRMTDdK?=
 =?utf-8?B?M3ZTdUFRYis1YTZrd0lTZVhJZkYvay9DSFBJUzE5L3lwdDR3VUcyelJ3a2tG?=
 =?utf-8?B?aTM5V05YK21xaWNma0Ura2ZidE56SDVodzRvbmtkMzh2L1hSOGYzdXExK1ll?=
 =?utf-8?B?elNWZ0Y4ZFJQcE15cVVLOWpZWXFnVkh6K1hNVFkzc2FOaW40KzdxOWFTdDJi?=
 =?utf-8?B?dEJJNmdSMlVZNW9CeU9Bb2tTdFB5UGVzOS83bkhORUdkWFFjcUdYNDJDMVF1?=
 =?utf-8?B?MThPQU4vYWc4NGdJOUsvM21Kai93UHhuUno3RDYvTXU3cVlGclF5LzdlTDIz?=
 =?utf-8?B?UHhjRkl4a1gxWEh5OFo4cUtqRXNMSjZhUUtuRjJtUFNLbzI0TEFLRmlqMGVr?=
 =?utf-8?B?UCtvek1vUCtVUEd3TjhwVFo3S0VJTll1aXhEVDdNQVVKUnJRWHgxcWdxVlJC?=
 =?utf-8?B?UkFFYmF4dFg0OXlTbTlveDlNOHM2cjU2bXluR0pqOTh1UjN0czlVcEo3UEFW?=
 =?utf-8?B?Z1RsbFBDQXpqWGNJVWpYY0xqMWI2RmlqMkFRUWJjbHZLN1VZZmZiMEt5QnNT?=
 =?utf-8?B?WTVXRDYyaU8vZ3E1R25NRk5BM2M5OXUrcmZJK2l0eDlLb3Vja3M5ck9vUVFv?=
 =?utf-8?B?bHVLeTlFK3JaR0JvdVNTVlIvaVFjb3RwMWZmSHR5TUs4b0RHM3hZKzRjU2xB?=
 =?utf-8?B?aXRiMUZ6WFB3SzFtL0dHby9WdFhnSEY1Z3JWcXpkU1IrWVBtTFBrNW52VnVN?=
 =?utf-8?B?UHFudU44L3ZPY0E1RC9NcmR2QXFmTFJGZVZXdDF0bmJDL1NxWHhHS1N3RFpC?=
 =?utf-8?B?aDdZL3NMejB6SWZTVitVbXQvSWdtWGFOVmh2aHdwVGt1Z0V5RC9BcDJGMVNj?=
 =?utf-8?B?ZENGbjdoM2pRZ2d1NENDOWFJaERUbFNxUlhTVW0rTFVmRmM3R3F1UVhiOHc5?=
 =?utf-8?B?d3V6L3lqd1k3U1diWkpZandLaG1UUDAyTFU4ZmRsSU84Sm54ZlkvT29ZazZJ?=
 =?utf-8?B?VjZKZ2pwVCtJclhYNTFMMERSN0tqR2VMWHRZUVQvOGtJclQyL0FUK1FhTU9z?=
 =?utf-8?B?b1hZbVdHTjBMSUFvYjJHcXRrcU10U1laQzRTV1lNb09zUG9jSjVONDBTTm5t?=
 =?utf-8?B?RGpmT0FiM0dzTmhiYnlEd0grUHdyN1gycVQ3TDZydnFZaGYvN1I3QlcreHdI?=
 =?utf-8?B?aDV5YVJjUXVkWWoxbkRjMEFOVm00SkNvS0krK2FVZnl5VlFWYUZyRjFHTTJ0?=
 =?utf-8?B?MnNjc2dsbkZiejNzSDBTRFJFeDJNTmxWT0VDcFI3Zm84V3EvcHArcVlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXNSL202alVtSXllVHkwNEdDT1loTSttOEk4bWw1NklGMHRSdFp6aHRINjNW?=
 =?utf-8?B?NzNQN3Y1UmUwUWVqR1pBT21HY2E3WGd4cEtxL0U4bVVJUncrdnFwYitiN3Fr?=
 =?utf-8?B?UFVPRDAydVdCUkRMa1FwMEJUMjdnODRnMVVURk9JeGZaL1VzejZkSjJuWU54?=
 =?utf-8?B?RkwyU0xPVWZITS9McVoxVVZoMkhhWjg0R2VUelIwR3E2aEtpNmNnODlGRERR?=
 =?utf-8?B?c3hlQW9TbnpMOGVQbnlGMktoVnVWMGtxZHZHU0Z3Z1Z5M0hYd3Z2SS9LR2J4?=
 =?utf-8?B?bHBwaFkyOUV6UzRwVTZhQjhHYjdSZDZISGhGNng2U1pEaFU4ZTh0bjdhQkJa?=
 =?utf-8?B?TDdSUElqZExGYnErRm8xVmV0N0RlcE54K1ZZbm9HUUF0N1JpQU9zNjBxckhW?=
 =?utf-8?B?UFVMQmRTV3NzaFBJSGNZekgzSENGdldZb1E0QTRCaEFvTTFVMGJoaWZUS1pt?=
 =?utf-8?B?S1p6WlVMRWZ4WnBrcmZKVWhZSG15dUIxczZmZW1kS0hGOVpZQ1FlV093bzEx?=
 =?utf-8?B?L1FQREJ3NVJmMUQ2dnI4emlCdnhxdmZzalBvUXV2N2hKZE9MTmtzR0VyTjJW?=
 =?utf-8?B?SkNrRE1nTzMwcXdHQmVuMXhBWU16VzV6Q29uOHc4WERCUHFqZ2RQS0cxV0wz?=
 =?utf-8?B?OEdYQVhSaVJEMi9iUmtiQjZqbG40NE9FSU41b2R3aks4QU1EM1B4cDdUcE9C?=
 =?utf-8?B?dWVPQjNoY3haZFN5Z2pFT2RsNGVNWkJJalpnSktQSVFZOTdVNnB0bVlyNTV1?=
 =?utf-8?B?ZCtmVEkrMC95ZVZVWXo3RWh2L1ppQWFwclE1dzk1SEFhSk4xOFFERW4vMjQ3?=
 =?utf-8?B?QWJWOFZqYXdEbkpveUtHSENGMktjYWV2YVVqY05nYkpIbmlVZVdaSGYzZm9W?=
 =?utf-8?B?eGI3VStZcEhzamRpU0o2NUpiRWtXM1IxcjJaQUs4cFg1T1pDcTBqSURQQm50?=
 =?utf-8?B?M0JmMElnVXlJTmZ2WDU0QUxEcHFyWjgvdmZWd2RING12U0ZUZXR2MzB5Y1M3?=
 =?utf-8?B?SlVuODZNWnBQYzBWZVNPbDFKNjZWT0xrUFlnNXZLWHZ3RGYvSFR0cWl1TnU4?=
 =?utf-8?B?RlIwaXMycVVZMFdERHVVcTd1eHdZb3ZGUVhVTjdSUzZnUnovYyt5enNocENv?=
 =?utf-8?B?dXhrOUJlNi9PWjB6bVBIc1hlYnVueDRmYVdBTHZlU05sdXZhbmQ5VnV0VTEv?=
 =?utf-8?B?d2RaQW92K3g3Y1FYZ3lrRjFUNHA1ODM2ajdRcWNxMGNCZy9pdkNxelJMenM2?=
 =?utf-8?B?Y3dUenloU3d6SGpCeGxFRzArU3pmMXpCQTlPMi9vYnVNWHhQNHdxMkR1d2VJ?=
 =?utf-8?B?K2lsZDZ0OFUzTU5Hbk9abTJNeVhqL0VMTnIzb0Q3bGxqSVBZbEpaNW5YZmJ0?=
 =?utf-8?B?bVpWUFJLYngyUFRYYlR5djVBNG5xNEJOU2ZlaW9SdzliWmVSdkE5RXZSZFV3?=
 =?utf-8?B?N3YveWZnWlY3SlgvRGhCOGZscUZsUjA0UFpvaG9VT2hybXNlNkpiV3BLVVRH?=
 =?utf-8?B?UFVrYU5PVEtpV2hINGlnVFBqWDNKS3VkeFRwc3BiSTdHZUZSQmJieVRXa3Jo?=
 =?utf-8?B?RUJWUWM0YmJHTzdmS0s2UXZKVHl4RHZkSTFwR3lSb2I5SkpTOUkyOVNia0ta?=
 =?utf-8?B?MG9CUnQ2RlFVMUR1TmVRSkR1NFhGNmdZYythS2EvMHdVNVY3dWRCWU41SGJn?=
 =?utf-8?B?Tm95VXlGRGdVb081R0JUMzFmRjZXMWdlYXB3aVkzYTltaUNSNDZ6dXBHa2pq?=
 =?utf-8?B?U09JWkFBVnZXZ2ZIZjIwbFFIQzdrS0FPbzBIYndueVI1K1BHNDZaUzhBakdh?=
 =?utf-8?B?c294WEJUczliTUhLL3hSMS9hOG81aGxUNUhwdzBmd2d1RDBScjI5eHRtd1c2?=
 =?utf-8?B?UFcrd3hpSURLVDV1MHoyZmZNa3NvUmJ1a2J1Q05KN0RreG83VnVQR2Ivd1l3?=
 =?utf-8?B?MjBvNFlLekgyNGRDOEF5OWJuYUNNSHMzSnV4dDMycHBYWlZMSm1tWGM1aGVD?=
 =?utf-8?B?bDdjSFNGS0VmTjZwYkw2OEFMbVlKb0JocnFEMXJVVlgwK3l1b3o5K0g0M1hN?=
 =?utf-8?B?ODJjTjgyeGlqQkF2OXZPS0xZNGhBODJQbnNROGFUWncxRlhrS2FoNERkdTVv?=
 =?utf-8?Q?tpq1iToSmjxvPziD1E4KjRHDM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2688dc-0a91-4b83-3f15-08dcd997a758
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 17:14:15.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc03R2NfXKm1xzrCzrzsi8H0m8DUBAEKbHovKTgKQHYjOqyaHTJFt8rikjW6dLKwiEer5IHuMINa8+UrJLN2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591



On 9/20/2024 9:59 AM, Marcin Szycik wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> If DDP package is missing or corrupted, the driver should enter Safe Mode.
> Instead, an error is returned and probe fails.
> 
> Don't check return value of ice_init_ddp_config() to fix this.
> 
> Change ice_init_ddp_config() type to void, as now its return is never
> checked.
> 
> Repro:
> * Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
> * Load ice
> 
> Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2: Change ice_init_ddp_config() type to void
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 0f5c9d347806..aeebf4ae25ae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4548,34 +4548,27 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
>    *
>    * This function loads DDP file from the disk, then initializes Tx
>    * topology. At the end DDP package is loaded on the card.
> - *
> - * Return: zero when init was successful, negative values otherwise.
>    */
> -static int ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
> +static void ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
>   {
>          struct device *dev = ice_pf_to_dev(pf);
>          const struct firmware *firmware = NULL;
>          int err;
> 
>          err = ice_request_fw(pf, &firmware);
> -       if (err) {
> +       if (err)
>                  dev_err(dev, "Fail during requesting FW: %d\n", err);
> -               return err;
> -       }
> 
>          err = ice_init_tx_topology(hw, firmware);
>          if (err) {
>                  dev_err(dev, "Fail during initialization of Tx topology: %d\n",
>                          err);
>                  release_firmware(firmware);
> -               return err;
>          }
> 
>          /* Download firmware to device */
>          ice_load_pkg(firmware, pf);
>          release_firmware(firmware);
> -
> -       return 0;
>   }
> 
>   /**
> @@ -4748,9 +4741,7 @@ int ice_init_dev(struct ice_pf *pf)
> 
>          ice_init_feature_support(pf);
> 
> -       err = ice_init_ddp_config(hw, pf);
> -       if (err)
> -               return err;
> +       ice_init_ddp_config(hw, pf);

I just commented this on v1 as I didn't expect it to be resent. I'm also 
okay with Maciej's suggestion, but I wanted to offer an alternative option.

As an alternative solution you could potentially do the following, which
would make the flow more readable:

err = ice_init_ddp_config(hw, pf);
if (err || ice_is_safe_mode(pf))
        ice_set_safe_mode_caps(hw);

Also, should there be some sort of messaging if the device goes into
safe mode? I wonder if a dev_dbg() would be better than nothing. If 
ice_init_ddp_config() fails, then it will print an error message, so 
maybe a dev_warn/info() is warranted if (err)? Of course this would 
depend on ice_init_ddp_config() to return a non-void value.

Thanks,

Brett

> 
>          /* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
>           * set in pf->state, which will cause ice_is_safe_mode to return
> --
> 2.45.0
> 
> 

