Return-Path: <netdev+bounces-259656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNrIN40UmGki/wIAu9opvQ
	(envelope-from <netdev+bounces-259656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:00:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C816574B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEAD23018298
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03699334C1E;
	Fri, 20 Feb 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xp5o9+qD"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58A334688;
	Fri, 20 Feb 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574410; cv=fail; b=mn0cpx+cXg4+PMBdiEamzSLeweUf12lPXgLYJ2XaU2NPMcvlla6J/hkppgUDMbL7HNx13nI1QjWg7pZ2amMearJiQ115F6T/tHLRwAYkTSu6AOi8McVFPd7xH5xTgka265xe/lUuPhy2zAC8+gI2x45JMOhqcc7UljgIzOMttwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574410; c=relaxed/simple;
	bh=xYtgQ15lT7OxHfWLQdzliFPiq5ao5gITb1LAPvS9Z/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHSkh9hssVuFEoPNmYtYtHnCbcBDxVTjOckV8UvsmXRnEEs5OGp+K/LKU9Qbf69n2ZBNgHly2tHn6g9oQn0FaWn551lR3waAspzY73fPYSZlPBKEXIFIbSRKgUfqiXibWR+E6H4vGT1ejDy6k2Qf9Uclzahs/F7RKz0Ro55i7jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xp5o9+qD; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzWG1jJHR2l0Uxd9qd0tafHnZBKWb4+H3ITgopHIAy4X0l42LuuwjnXKuGpaKEzSgdyrdaQJWCc1/0Wh75wweXT1l+7cwWIx48jbiWXZMjSjXeAI8QXv8lSZ/tMajpJI0o76DuoY2g9gXs2MCRxBR73FCZiJnubEJ+fr5hOzoUcUoO5WIuOcGfCFmhvc7sH16Uar3JSR+WO/7AAigCNolJqw6tLqeCLTG7z+RCOs8DBQUy96ku+T6VwV3O4t2nV+64mIMoKVuUrLXiXzSMV/L7M7CH8SbADxhQ6CxGwLp9LR3JHLoW5PEs2qj1PFOg6KMFQHvEHyaxLIg0er/pw5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZIJszBCRGII9bTk39PV0+SmGEH1t6/Eg3/0SGMR31A=;
 b=byyprN6H5KOTARe08Jr0s72jcX5OKspV8uJgaFtEMRnsHZHX2X64aByXb2CCjRdpYgkuqS2kpidCOixgXDYf4p6zKHk37xXvkB8o43dzbygDdXnvd+xZID6COH40xh4BEoIhNKbTRcI+LCxYBjrnCxXzE1ieXj0X04jJjvSzLRNGNOgD/QOvRYe+hDUklg8CphP5Ii1B64GYCpZ2jUJ8pzeZXdjQBnGF92194v5O48eKYn16lJaf/DH1OKar3Ez/QRAJ+LT5fQIBBWOUE2LJZwlw8bLwNm7/y+IFxxzl4fOsX4WLBIpz7YF983vTS11RHEl6t4NG0xDjYsypF0yBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZIJszBCRGII9bTk39PV0+SmGEH1t6/Eg3/0SGMR31A=;
 b=xp5o9+qD1t4+kPkEYWSdclvDVHp7J8hsxdtwcgAX/uqp7h9U6e0A259rT84yDrQkW/lPKcffr5ZHRuMT8vTwG+qGdRJVXPPiZ7vf7ql4LEf/bb0n7bB4SpdRPPjWcr78wTOX9zoOOYqbw0qdG+tm8yBLuKtCdHu9BPvcqj0l8hY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 08:00:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 08:00:04 +0000
Message-ID: <f989697a-b78a-4225-b939-14afd623a322@amd.com>
Date: Fri, 20 Feb 2026 08:00:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] sfc: create cxl region
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-22-alejandro.lucero-palau@amd.com>
 <20260213161410.2945294-2-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260213161410.2945294-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f39ff48-e862-4ba6-6f8e-08de70560e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFY2bkx3ME1ORnBIaWViaHhZQnhMam42VVVRYXczRXp1MVJLR0ZZL0xqTS9P?=
 =?utf-8?B?eDBSNFFPN2t1cVY2bzNCQzhJMWtZSmJzU05LV09McXlETml2aUFNQXdtMU1j?=
 =?utf-8?B?YStJOHZMNWZ1M21TcDlFcXl4ZjVUc0w2Tmk2TllyQUVPcGNKeUp1YzUyQXBx?=
 =?utf-8?B?M1ZsVVhuYVNINjBFdHoxekE2d1V6ZHRhTVVmNFlua015UERJSnRZU2o1N0Rl?=
 =?utf-8?B?bWFPWXRWUnJOVzJWWVFzLzU5V2wzMGxQSVFPaUxIcmNTRlV2bG5LNjNFTTFI?=
 =?utf-8?B?TjY3Ky8yczdTQkt5TEpLU1o0UzNiUUQ2cVhKNGc2Z3YwaEw1R2V4bHV1dWpD?=
 =?utf-8?B?WW5hVm55RnZpbFNxMXpkcHN0eTNWOVgxRGdXRHFyL2paZWUwM1NhTGtnbmJ5?=
 =?utf-8?B?VEcwUW54VWFHUFZ5R3VhTXlDSTZYOGVJanJyaGRGc1NVckhka2wrMDN0dmtw?=
 =?utf-8?B?Z0FTaE8xT2ZSYXZJZ0VURFZVMjQyUENtM2lrajBVbWRiZ0JiQ1pnMXNOU2dY?=
 =?utf-8?B?elZtZEptYWtKN29TMEtEUUtyRG1qd09wdVE1aUsyWkNscGJXd2h3STlvN2Fy?=
 =?utf-8?B?TFRjMU5aL0N0OG9zcWRmb0dXUmcwVDFYU0NaelJQSzlYUVlPTFlpMGtsbVln?=
 =?utf-8?B?V2xpNFkydWRKY3YwbDExMGVSeDBScXFIcm9mRE5UL1kvNzMvNjVvK0J3VzRa?=
 =?utf-8?B?c0J5eXQyWEpUclYyeVhhRFdDN2Z1dktJQm9ORVZjakxTR1ltcE4rT1FYV0RI?=
 =?utf-8?B?L2lRNTdwODY3SHMyRzB5YWVvaFpaNXZmSDhneWpyaENzWUNZMFdPZ1lBdERh?=
 =?utf-8?B?MnVUMEZDQVRNQVRXcTcvdnk1TWlBTzNOSWdQa202ZXBrQUpVUVdrOWVnRVBG?=
 =?utf-8?B?ZnVYU3hqWmZNYVV5VVJkMGZUeEpYRXRHYVRqKzh3eEkvOHN3TjBrVERFWktp?=
 =?utf-8?B?dXVBZ2taOUw3OXZkMHN3N3hyR1RRcEpQR1BWZ0NaSmpYbEdoM0hsUlF4c3N4?=
 =?utf-8?B?UURsY29DNXdmTnFKNEZSb2E5S0h1TloxUWZoZ0hycWxxODA3eEJpVk9xZ04v?=
 =?utf-8?B?M0ljR0Mxb1B1OExJVDRCMVR1SHMyeWtYYzc4bVB6U1hBU0hrbjdOTUIwbklQ?=
 =?utf-8?B?bXl5aTIzNFlGQm0xVktnYTdlenRlRWc3SU11WW1nWmFmTTBudnM3Y0ZmQkpT?=
 =?utf-8?B?aC9zWjRtU2hXMVFmK2VNSXBSS1J6cUVGYmJhQW9NcXlIUjMwYWVURDl2L1U5?=
 =?utf-8?B?MENLTUtrV2w3N3lnODJsVEU2TVQ2NHU0eTZhcFQwQng4Smdua3BhV0pYR0d1?=
 =?utf-8?B?YXkyczRKZlJYQzk4cDM4NTBUWk40c0NXMjJsM2F6THRxbUkvOCtLY2tBV0k1?=
 =?utf-8?B?ZkloN01pWXRRYjREOEFzaktMeU5BWVRUblBkcDVwZGJIQlc0T0FtSE9LTE1W?=
 =?utf-8?B?ckgvSWhmeEwzcDdiWEJDN3plbjBFVEoxYUdqZ3Vpc1NYTTFnUnpkYTF2WU1H?=
 =?utf-8?B?dDBNQ1pyMGlVZnRqdExRNFVBem1tWExGMkJTN1ZVWFZMYjRpdXZBREJRWG42?=
 =?utf-8?B?K0Q1OWRtcURLU3JoZjhvb2hRcEhrSTROUGEvbDQ0LzQweWRKNzhybnYwMTRU?=
 =?utf-8?B?bkUrQ1IrMjF4K1NBdVR6SnRuK1pOQ2dZWi9zbHZMK3l2NVlKeFdsU2dPamM4?=
 =?utf-8?B?Ry9lNkhFKzF2ekxIb2hleWJ1UUI0KzJUcjJWTXJ6aExTSTN1M3J2TkNQR0Zw?=
 =?utf-8?B?UGJQOC9WYlhtOGwyczJ6NkVoMW1SV1lOTnV1eXpYdVdFS3YrR0N2dlhHR0xr?=
 =?utf-8?B?N0c2eS9UTjI2c3ZZaTZWdlZqYlBrUlMrb3lLbmpaZzduT0pmZ25xU1g5VTVs?=
 =?utf-8?B?cnIxSUloSUxSUk1Ua05ickJMeUltWk1WTExJVGE3b3ozSkxjUzdLTnRMNVND?=
 =?utf-8?B?MkNhbHdZUHBZT1dhZnZRakloQi9QQi9rTGZqN0hSS0o0WXdKejJtQlduSloz?=
 =?utf-8?B?V0hlSExmMDR6anVYWXZtZE5KTjRsUlp5S09kRkNKZEVHOUZZanE5RWsyMERi?=
 =?utf-8?B?NE15Y1hERGRpOUJCZ1Y1REVLQTNueGQ4cE1NZDIrRWw0YjV1VnQrazQ0RXlR?=
 =?utf-8?Q?Glwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUYzRGZoZ1I4eHpWYWE0Vk5ES0cycmJDSjlTRUtrR0pScmJJa3ZDdXpVcTF0?=
 =?utf-8?B?ZkUvdHhyb1EzVFl2b0p3T2NtV1lXdUozYkJpTFZBaGFiaG9mSmxiN1NpeHV0?=
 =?utf-8?B?TTRTQVNJaDRkcHR0S0VkZGZPdGxPdzgvaTgvNmVnK1Q4cWtnWE5UQ3QrblVm?=
 =?utf-8?B?WUlyY0xpbzlIWUo5QzJ1b25tbjYyR1BiR1FsdVFCRFhibUpDSDhKRk0yL29i?=
 =?utf-8?B?ZU02K2lIa09IVjRRZkhmcEtGL1ZtR09lU1hIeDVVbWRxMEtpQlVZQ3BsQlRq?=
 =?utf-8?B?SEJUMnYrdmZNVHJpOVVEU1JYS3hUUXRSYjczeC9aNGs1bkpBWFNWNllTNTJx?=
 =?utf-8?B?MmlmNGlNRnMrQjZwRFhxNXBlNU1DU3cyVVZ3ckdKYW5ncFIvM2dlOFNQVzdk?=
 =?utf-8?B?SjdwcEpvL1pJODZqRDRWdktseGtpOTFxb1lLWnRXNXh4TTBmblZaYmJUWFFn?=
 =?utf-8?B?UytKUEV1YUtxVlJVZC9peFRJV1ZVcFhvOVhVZzVHWjBIaFpETHF3dUNZcHVS?=
 =?utf-8?B?eis5dnIxNkJFM1NCcGJaVkhUTmpoTndFR281K3pTVW0rUDBsZm5zSmhodzRS?=
 =?utf-8?B?bk1yK1BzNm8wR1dLRVcxUk8yVmxwQzliaDk1Zm93ek5MeGNGN2YzNWNZeEQx?=
 =?utf-8?B?clB6Nlhkd1ZiVktLa1NxY09yazcyNGt2cnBEbVNYKzBnYjFZd08xN1JzQmln?=
 =?utf-8?B?enkzUXE0WWFvczRTZHh6U0YzR1VKc09RZ3pMWVJWOXFHdjN2MXlXeGZMUVZB?=
 =?utf-8?B?RFpEKzhGRHJ5L1k4VmpaclBjdjFXWGZHa0xod25ubkd0QjhwT3FFbVp0cDVr?=
 =?utf-8?B?VGQ2cmtQUW9GTCtpZkJlMVBkdzRiZzBQVHJnZGR4QlNXS2s4LzVUUTdIL2R3?=
 =?utf-8?B?cGM3MHpxeGt0dlBZZ3JBb3pPT0pHMlo4QUg4WGhMck45aWtIZ2lMZVNzaUtM?=
 =?utf-8?B?dVlCQkdURjI3ZzlKKzJEVDNoekFkcUxnQVJNaHo1UHd1NDdSM3J2UWNjTWNT?=
 =?utf-8?B?SkxHdGxhNThFNTM3dDRPYThQaG8ybnBsNUJVUGp0bjdSRzk2SFIzYysrWVZq?=
 =?utf-8?B?SS9UREJZNGs3UXNraFZUYWhXTU0yTE0wY0JodlQxZFA1OHQwMnpSR2RJQ3Jt?=
 =?utf-8?B?ck5nYlB3UHBLVEpuN3loVkQyRXo0YzhmOWcvMkpFaURTU2F5YjVpWUtlTDE3?=
 =?utf-8?B?S2N4ZnovNjBzcXJCQjBFM2FyU3kyNWd1M3pDTUZZS01wOU9GU0FVWU5SZmo2?=
 =?utf-8?B?U2FvcThDb3dQbWdHOTNYNkNOTHN0NERlTEhUQWMyN25xSkVFcUlPc0FFMEJp?=
 =?utf-8?B?aDZaSTFOOXZCVDRTY1pycU1sNFFMcEFGbnBrOHhIaHZmRjlMME5saWtsK090?=
 =?utf-8?B?MG81aUVySkVHNmowaXErWFpBZE5RaGNFdnRwdUR2REpXMGl6Y05qaFViZUZ3?=
 =?utf-8?B?STZHRnNBKzN6c2FiUmxwSncwdzhnMEkwNFgxZzNZMWk0NUZUOWZwZ0RNaFJI?=
 =?utf-8?B?Y20zRDM3NkhrTldZQ29XZ2NyVXQ1RXhKb0lTTWV5NVRxMks3VTJuUkZzZ1B2?=
 =?utf-8?B?SWxFVzJzVW1qSVJETFpNN0ZxY2NnZWRMdGRGaVVoNUhrRllzUU9obk1hUWRK?=
 =?utf-8?B?blRPL252S2ZoVk5sLy9MalhjcHFFZjRtMzFiOHJ2aTlRYVZ3UEhDNXdwY28z?=
 =?utf-8?B?YUF1aE9IUFl4YlJ4WWNHSitLQ1ZsTVlWTC93Z3Jqc0VsOGFhVmlra3hxUlhh?=
 =?utf-8?B?Z0V4QTBmK29zTVlYUDZMbnY3MjFhbW9EMWdiZUREb0VLRVFITlUrQjkyUU1Q?=
 =?utf-8?B?eFI3b2RQZFFZZ3hZSWZrRDl3V2YzbldNa29NLzkrYU91U2M0TEgyOThXR1ZD?=
 =?utf-8?B?UTZQREcyVUxJSlNNUnA0VWFjd2htbmsyUVE5THMyOGRaeTdnUUp5YUVkME5G?=
 =?utf-8?B?RHJ5TzQ3QUdhWkJHQ0svSGhQRitzZXNHNWNqODMrbHV0U0ZaYzZ6RjJLTURP?=
 =?utf-8?B?M3g1SjJHbHFLL1lVOTRJSk1qNW81R1l6enVTMC84djBEY29FMEhURDJFQXRE?=
 =?utf-8?B?Z1Z5VXhqb0ZLTzQ2aExyZjBhc3gzbjQwYW85bGZEbkdQTXg4ZFZRcW5zRDNF?=
 =?utf-8?B?bGVrTmh0REdJaS84OUhtT081TTRLSFQ1VHdndi85OGNrVDR2TDlqQXZrd0dL?=
 =?utf-8?B?QWJFenNNTXJWTWtuUFFlQWZQdytXZERPZXo4bmt0SGF2eXdhSmxqTnIyOVhr?=
 =?utf-8?B?My9IUDBOaS9UNGVJeEJzQ2hubzI4SCtyazNIV25TWllOWHVQZ01kbnZqTXdz?=
 =?utf-8?B?T3FQdjFmSFJEU1g0OFFtdWRrMHdpUEVmRWNRMXRLV1EvOXJob2w0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f39ff48-e862-4ba6-6f8e-08de70560e0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 08:00:04.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDDXbjMwngenxTWMQuITREoQMToU44DFEDNboTY7UkAgYZdbIf+hX+CdPOxgD8DP2j+3pMagsntX3R8dwEnq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259656-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 587C816574B
X-Rspamd-Action: no action


On 2/13/26 16:14, Gregory Price wrote:
> This review was generated by kreview-0811365ff2.
>
> This is not an automated email, the reviewer though this report
> looked valid enough to consider discussion.
>
> ----
> sfc code so won't speak to the internals, but ordering question seems
> legit.


Hi Gregory,


Yes, it makes sense and pointing out to those changes introduced in v22 
and mainly in v23.

I'll fix it.


Regarding the below comment, which if I am not wrong comes from kreview, 
I think the patchset needs to support both cases and therefore the code 
needs to deal with both module exit paths.


Thank you


>
> ~Gregory
> ----
>
> On Sat, Feb 01, 2026, Alejandro Lucero wrote:
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 2cfd0a46225f..4d5f3974e51d 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> [ ... ]
>
>> @@ -147,11 +155,11 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
>>
>>   	if (probe_data->cxl->hdm_was_committed) {
>>   		iounmap(probe_data->cxl->ctpio_cxl);
>> -		cxl_unregister_region(probe_data->cxl->efx_region);
>>   	} else {
>>   		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>>   	}
>> +	cxl_unregister_region(probe_data->cxl->efx_region);
> In the non-committed path, cxl_dpa_free() is called while the
> endpoint decoder is still attached to the region.  Looking at
> cxl_dpa_free() in drivers/cxl/core/hdm.c:
>
>      if (cxled->cxld.region) {
>          dev_dbg(dev, "decoder assigned to: %s\n",
>              dev_name(&cxled->cxld.region->dev));
>          return -EBUSY;
>      }
>
> Since cxl_unregister_region() has not run yet, cxled->cxld.region
> is still set, and cxl_dpa_free() returns -EBUSY without freeing
> the DPA.  The return value is not checked.
>
> Should cxl_unregister_region() be called before cxl_dpa_free()
> and cxl_put_root_decoder() in the else branch, matching the
> reverse order of allocation in efx_cxl_init()?
>
> The cover letter notes that v23 expects committed decoders as the
> primary flow, and uncommitted decoder support is deferred to
> follow-up work, so this else branch may not be reachable in
> practice today.  Still worth fixing the ordering now so it
> doesn't bite when the uncommitted path is enabled later.
>
> This issue is not fixed by the remaining commits in the series
> (through 10fe989f9e85).

