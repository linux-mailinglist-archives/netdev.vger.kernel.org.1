Return-Path: <netdev+bounces-97216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F68CA06F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162861F20FF0
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF55136E29;
	Mon, 20 May 2024 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EHRaYRO9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02C28E7
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221099; cv=fail; b=s1A6T2AsBI5yLZ77rYzX4QGYwplz6oSaC7iLEf+nmolH6Un/nM8WPd9kGRPnid6b/BGTHFgZs8WomvoaXCmUZUj3S6CwhTYXrBgTxx+R7JDpKtAm3QompvhEyVK8K1lJe/FBScFTC2rk/QJayjh3Y9wV42ppgiwaN6A5iPDz0BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221099; c=relaxed/simple;
	bh=EWEwZEVTmjjqTv0z+frQRHoXu0ml1hKDYNtAywScbsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l55jsQ/MfvWNMt1XTDIB+GJPaWKEfswQ7Q8SSJNfA84FKSz4G4ORHqQDiBRaJqzjbEuw6fsk8g5EN+Dtei08fCc8NdcCAmbo358Xi5m7LTQv572zqAUo8sV+i0l5bJpK1LfZOyumESUxr1v3sJLel6fcXUCh8S5XztnDRYEb6Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EHRaYRO9; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI3QN4BL93YYVGPRcKCHe/H1pm4Y5Pzzrw+cm7TysZmbPdovkTVYVeIQFXEm5mgEHsIfCsJoi3/iYY92wSFcqHOHk4EuLpoh+hfktdx0A/U8Ed8v0+GtC5AK3Pqk52Zv23Y+6zTKZWG24ZUnLMd1caYYQVKp6ep/HNOTTrr3UIg0TdlTl6divUlGWmCJpFsqYG0s2bokjLqKxhLl+ZuXbJXIf6nXFYhIaWCXu9xhs/BilcD5Sw/U6jhqv+fTIejqoXY1rHiPGTMthV+pKVLMAt2DwHzweYjtkcXPIV+4BdwP/64m97/H87MD2DEHjGyWXy1Bm42Ef3wbD5GcY+IMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=528lw7Mtj87DFDWnK+nHI/KiSJx11q2CrzfFRBeFGh4=;
 b=S2k3IHYmHMsb4L/kGPvCpZ37u1Sv4IRLs2UCkgbLMtReW9lkYauMtgeQnA3EPL/GbbjhXjulheVyFk1ZBe9kNmA1ljsVP3rzwlTSUcikaL8r5ygxjb/jbBk0NDMAODV8IRr4h6bktYzIAoITjxH881Tox1AN2LYqSiVo9dO0KOH+hD9OtlCPmZ/08aYuJ1UFsCJBRgHhpHo2xR8ytjAZ3wkmmw8/McR/9HyVyqvqENIBI6xj+UrUmQe6H2j53qReLstRq9TSWYZtTepeRKfOmOgmfn+d/JkBofU/ftQenZp+oOVtpjwdWUDmFZ2BLTaaVI1Buql8tT0CioywA7ytyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528lw7Mtj87DFDWnK+nHI/KiSJx11q2CrzfFRBeFGh4=;
 b=EHRaYRO9dee/p2Dm86kgtjzgvOPWWH7GXDkNQDrQEFiNLS0FKtbAEaB4z1e0LnmU3jpR3qCn0lyyfnPf8jPCfRB5musLilMFAxBBT3hRe35Q7VOE58onLw09RSQ1hOVVS2tliuxINWMCmSZuOqiWqMAAC4xohS7jHQ3M3ut2ajk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 16:04:53 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:04:53 +0000
Message-ID: <5f7caa24-5bec-4989-8870-052caba4f0bb@amd.com>
Date: Mon, 20 May 2024 09:04:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: implement AQ download pkg retry
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, naveenm@marvell.com,
 przemyslaw.kitszel@intel.com
References: <20240520103700.81122-1-wojciech.drewek@intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240520103700.81122-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 706cd2b3-16f2-4a0d-9776-08dc78e695dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjlYc3c3NGNyT1FOQ1dXQW4rVXR3SUVPNlhNeTBCbkltRFlYOE14MVMrMW8x?=
 =?utf-8?B?SUxNWlBRMWpNUWlxNHZYc3VKWmdKKzZnRnZWVU9teFR4N1ZSR21sNmVlTmln?=
 =?utf-8?B?bFhxWFdkcW44dlJWajFwQjk3d2phWFA3QXEvNjFZTk05YzlocnpzWXBqbDdx?=
 =?utf-8?B?TlhMV3l5S3ROOVJmeGNUeTFyMmJvN1U0bUJwQmZYdjNtMFJvYVhNem1EN0Fv?=
 =?utf-8?B?M3p0V1FqL1l2TjhQcHpYY3Ayd2puRlF6cmFNRVJzTUFScXBHRngwTDAzR1Ra?=
 =?utf-8?B?dmxEN092bUxuWXBycUx1T2JlZmdaWWhzdkRlTnVlcmYrSmg0YnpWSHNJaTA0?=
 =?utf-8?B?MW9aRGpZSngwMVFPMUxVMk1vOXVDT1RIbkNzVnF3LzV6dUlrdXh6d0xnTVg3?=
 =?utf-8?B?a0M2REtuVWR3aG9Ca2ZRWFR0clAzc1ByNUV4L28zLzRRL1M1WURWT2lKaC91?=
 =?utf-8?B?K0JzTUplemZoaEplSFRlemtKQy84UHR1Z08yM09MK09sQUV5OXdFb3Bub05S?=
 =?utf-8?B?Y2Evb0w3QUpUUmhMTFdPdmo0Rk1KM3VuMERncDBGQ3UzWWloMDMzdGl3OXFG?=
 =?utf-8?B?cXhwVElVSk43RzFrZEVZSU0wdUhSWGljNWhTVnhhbzhLb0FLMDMza3haQWQ4?=
 =?utf-8?B?L09PaE5qWGVjbkJVKzhTa1lKaW1Eb2tDVFFWMlZDdzYxandnZUNwV3dBK1I4?=
 =?utf-8?B?YTRwSzJZNllMUWhuWE5JaTBwZS82dkd5VUJtY3VpTFFrSFhQMm9nKzM4ckRs?=
 =?utf-8?B?N2ozeTRvUFBkSElHekVnY0UzemtWc3lvT3JtMllialhDQzdUM2M0ck94VkRi?=
 =?utf-8?B?Z0l2eTZySUNLRExEZTdGT0djN2h5bjlqelc2Wkx5RXBrN01CdVB4dHR2UzV1?=
 =?utf-8?B?MkFuRFRqTGFCQkZZNVRDQ09QeFc2TkthNlR4R3E0ckV4ZEdiMS9iQjZMd3lQ?=
 =?utf-8?B?c202eUpSdlBrQ0J6RzJjRWNZbE52dXJzV1ZCaHJGcnZjMS9OTVp0MFpwNjdk?=
 =?utf-8?B?aVRKM3p1RUJKdmd5bEJ3Zk9kaDN3UVZ0MDFibUUyNG4zTFM3SDFQOEtGak5X?=
 =?utf-8?B?ZUt1aDI3OTNrSXhENklCVVdTSUtmdHZKOXNHcnprUFVibmx5MUlJRkRzRDV3?=
 =?utf-8?B?TFFSRVNyUUltRkdxby9oTkdKZCtwZkNxNXdBeTcwWmEvY2RBdVRhcWJlS29N?=
 =?utf-8?B?NXhqQ3lZSkhlSnBPYzZiRW1zL090VEpqTGdEamdrQ1NqQnRpamFuUkxsbTVw?=
 =?utf-8?B?dTVnZmJVb3lDeWE0K0lTQmliVjYvbDdKSEkxZXcyV1ZRQTdoejUyVUh0R25U?=
 =?utf-8?B?elg5L0FCa2xRWVFFMGJLMm5FVFhMUlRBbEVmSHUwZ3QxaTl0QnUwRUwrMzdI?=
 =?utf-8?B?WUhRMUIzblJFdmx6RTNqTFNsTXkxeTB1R3RjY1hhbFVBTjhYaDF2bFJvTWI0?=
 =?utf-8?B?Z0t6V05nUi8xVUIwZlVocll2NC9xaFZCSDFwNFdVN2wwNUFraHBmM2x5dFp6?=
 =?utf-8?B?SC9YRzAxelF1TVJpNlh6V0lEZDR6OHl2VWZqR0VIQWNlaVgrdnNac2dPY0hr?=
 =?utf-8?B?TWtzOEZiZ2ZxK2p3U0RWZ2VpOFk0Ny9oS3I2Ry9jVUh0V1VDa0Q2aFk4cjdF?=
 =?utf-8?B?TE5PYlhzQkswWjdqeFRmMGRWWC90ZlBBdEU5TzdyR0l1aVlBUm5sd2xtYzZJ?=
 =?utf-8?B?Y2MzWUxFeDJOQVVQVERPa0NyOWRHVFRaTytyUXROaUJBUTdhYXg4cDN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFVkMHM1Qi9HY2phbmgzLzlsTzM0WWhKR09LalNWUHJtUGhwTjFQV25qQVpm?=
 =?utf-8?B?bTNTOXhoN0ZZQ0E3MCt6dVZOSWtqSUJuWFpkK3NVWmluaUozT2VqU0JlZjJr?=
 =?utf-8?B?QWdCbDRBT1EwbXFIcXZ1Z09SKzZTOXNwc2FyR2lOWVFwbzNFY2RXeDZKbjZv?=
 =?utf-8?B?R0twTW1jYzc1T2YzNkprekZuZVFIa3FwSmYzNjhYSXNsZkFxNk8xRnluU09j?=
 =?utf-8?B?OGNLWjhLK1Z5QUNhbVRoSFp1cWdDM1psYVdJdUtha2pQZll4eHU0SjFaTlJW?=
 =?utf-8?B?QXlCT1JHTldNcFNwME51K1ZwWHdIemJQc1VXVWxOUE5sU3Joa0Nza25BZk9Y?=
 =?utf-8?B?dmFtb3lCeDZIMENzaEZsM3RUUm5KTWQzUXFuUFNURkcwYnE4aStLN25laWRt?=
 =?utf-8?B?T2RIR0t4SFVrNHZiTXJzb0VBR2V0N0ZEeHRVbDVCSzcrblVSWnI1RmVBYTgv?=
 =?utf-8?B?ZFluOGdyb2dWZjBPTWNHaVFIUU5SM0VENGFyVGx2bVpZd09Objg1azNHbFlE?=
 =?utf-8?B?VDNTL0ErOWpVZEZVdU1XeTlWTXdhRkFBSVlqNXlMaTQvTVNUckMyMmZoaXdP?=
 =?utf-8?B?Wkc5TXk4a1ovSHFkU0FwMk11YTY4T0E4dC9BN1YxU3pBdFQrYS9LcUZ6WUp4?=
 =?utf-8?B?VnZwa0p0dmhZUkIrYTR2MzkxZ3EraHBseGFqcmkvZEZZRlJodUFPWTIrbTBH?=
 =?utf-8?B?b3kwU0NHQmp0YklUM1RFS0ZLL2ordkMzUXRIelh2dW5XMmFBTjhManhSeGNi?=
 =?utf-8?B?SnRCV1JwMFNHODNwSzNWZllFaElZZnJQTmhIWXBWL0FMSHRIcUc1QmhLY1la?=
 =?utf-8?B?eHhQWVZoMERPalcwSUp2NmlwRDA1c3ZXRDVMZmhvRDNjRHQzSXZEbEEyWkZW?=
 =?utf-8?B?cStXZWFzcnk4elc5NUZWb0psVjZ0b1JOZ2xnS2VUQVhvMVRNdGhzUzVrZnZz?=
 =?utf-8?B?ZlRYNDIwZkExdGNKTVZ3bG91dUo5TTZzdlVBQkNRQU1vMUFLS2J6ZS8rUFRW?=
 =?utf-8?B?TXpoQnFWdG9KaTJaZlZoMEYrMEt6RWNSMXcwdG50SVd6aE9ma0UwMU8wS3VM?=
 =?utf-8?B?VTVtclpDZnFUaEI1UW5oeWFZS2hFZ2RoQjc3c2dSTXczYkRWWENCQnI2OWpy?=
 =?utf-8?B?dFR1QncvVC9YS2U0SzFGa2Y3SFFqMXUySmp2Y3hTSDVWN2RIakUyVnZwd2ZB?=
 =?utf-8?B?b2ZKSnRMS2JJSjk1WFp1aWF6d3ZpUWdESm1ONFcxdWtrbi9nbnRiZVJhMDJr?=
 =?utf-8?B?bnFYckxuTERYaTdSSnRvK1VBeG9WU1ZWc2MvN0o4Vlh4M0Q1R1ZTZlhYYkpJ?=
 =?utf-8?B?TVd0dzNnandDMEdQaXhsSi9DUlFyTWJnYllJZzdPelkvYTBBT2VtQUdVWnZ5?=
 =?utf-8?B?QW5hMXd1YnI2WFRXUkZ2eEsvcXVCazduNE5KQk5FeGkyYXUrOUwxaE0yUGIz?=
 =?utf-8?B?dHJXejBsNERxaThuU2FWZGUrVXA3dEIvZGZVMVk1eWY5Vy9aVVN3T1ptdnJh?=
 =?utf-8?B?WjlRSkd0c0lIam0reXBiMHJMWk0wbEg0WEtZNWE4RjlMOGVxUjFER2pkdHI3?=
 =?utf-8?B?cFlqQ1RmVHBZWVJFZkJtc0tuYTM0ZTRjMnl4R2lRSWlzRHVMR0VqZVFpdWh6?=
 =?utf-8?B?UDdRcWtNNUdJc2lNV051bUV1SFlYVkVFTEdZRVVqTWUxSlE5UVIrYlliMEF1?=
 =?utf-8?B?Nkdva1N6YVJBc05SeWlzOG42Wmp0eEpUbUFkb0tndzVWTU10b3RqbExVcjhk?=
 =?utf-8?B?aXVLanMwREc5NVJXWmNPcjB3dGtQQm16WjhWeDliUlF5OGpyWkFkVy8zaHA0?=
 =?utf-8?B?cWdiL20xend4MENhQ2JGU3AwTUZlWHNtbThDRlozTWVrU0VxTDZ3MjJPMmtC?=
 =?utf-8?B?ck1jMXZCYnZYeTZoZFkzcUFMMzlrWTFXTTBQQzFKcDlPUVlaUnl4QXJLYnMz?=
 =?utf-8?B?R3R3WlBTUjlxS0RZcUJBMkhNV0NGWjNxYXIwRGxROWZ6RHpRaWJ6eVFWSi8y?=
 =?utf-8?B?cThxWTRBS1AyUitLQTFaM1VFa203WjBQNEZtelhVQm82dDg4YTI5KzhyODRN?=
 =?utf-8?B?N0FwR1FOMWRuOXVBb2Q4VCtqSWRMUG51Vm03eUs1QTRjbEdEZjYwZGx5RUl5?=
 =?utf-8?Q?4zrWtvAMCFoEmeOcs9Yx2G5Qv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706cd2b3-16f2-4a0d-9776-08dc78e695dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:04:53.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw57Cb6ZGUDwswYt4yyoboA/5DYOQkGgVicimfwsfbqrAvChaC1NF8m/aptqkEGY8xuzFrSWgvKZzAEIxMRTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811



On 5/20/2024 3:37 AM, Wojciech Drewek wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> to FW issue. Fix this by retrying five times before moving to
> Safe Mode.
> 
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: remove "failure" from log message
> ---
>   drivers/net/ethernet/intel/ice/ice_ddp.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)

LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index ce5034ed2b24..77b81e5a5a44 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
> 
>          for (i = 0; i < count; i++) {
>                  bool last = false;
> +               int try_cnt = 0;
>                  int status;
> 
>                  bh = (struct ice_buf_hdr *)(bufs + start + i);
> @@ -1346,8 +1347,22 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>                  if (indicate_last)
>                          last = ice_is_last_download_buffer(bh, i, count);
> 
> -               status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
> -                                            &offset, &info, NULL);
> +               while (try_cnt < 5) {
> +                       status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
> +                                                    last, &offset, &info,
> +                                                    NULL);
> +                       if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
> +                           hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
> +                               break;
> +
> +                       try_cnt++;
> +                       msleep(20);
> +               }
> +
> +               if (try_cnt)
> +                       dev_dbg(ice_hw_to_dev(hw),
> +                               "ice_aq_download_pkg number of retries: %d\n",
> +                               try_cnt);
> 
>                  /* Save AQ status from download package */
>                  if (status) {
> --
> 2.40.1
> 

