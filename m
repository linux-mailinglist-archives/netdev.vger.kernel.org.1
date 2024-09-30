Return-Path: <netdev+bounces-130629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59798AF8B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F3FB22058
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EAA18734F;
	Mon, 30 Sep 2024 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zs6ufLq6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394C15E97;
	Mon, 30 Sep 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733736; cv=fail; b=mGJP9SGSHux6J/w86SGVi+qv4cbbqAsI03c/J23uDjRwkoljlrIWgai0rbM1VG0gIikBiyHc+6ssYG/H1/xQ+wBkQP7UPRbTKFN3I5mM0+m6CuwvyVyOSTVltiRzio9E1JhIrBS9DMGVvtBVVRI7UmznNpZUDChW6ZPbbzMveio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733736; c=relaxed/simple;
	bh=aUtFnQwblJPTm+ZMa2m3bx8FGfjWpyL7xuPIasPxq+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kr9bQD7Ug9ntXlEhwEqIQ6yjDnHgF8UmNQ2dn6uv6t5NcPSLigTVJUjupM/tSFgdo0Lgmhq8vVmDDyJkE0p6G2IdpyO6fYdecgPFytpyBQhdxz2WkTgkiv+5GD51W8torKY879cp+RnzdqqH4r8/L5EgBUMIOCa5OOh6wDQWHiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zs6ufLq6; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuqHogDSvWJEyrV/5AdlPcIO9sResIaO95uHLMw1AhFb7QUyKZZUReFTL9YML6HjMsJtHSAeO5sAlhwrC2nw6EQ2GVcHzpfO4SCxySOUe5phvs0BmuVIuNZAqugQsNh1P06V0je9L6vVCgzfC26b3GiBod/9avPVwXsohGbWMzvdUj8LV8Ewnw2YJ9DdXAEbLRa8IDNGnYXQ6DSHG//Q1xIGZEM5iFOTZofh+BHkO8sFzQCk09fX8xjp8TL9eNPfA6POm8BEQ/qtRG2srIqDItkYCdkKfKESLcmgk+qyofPP6qVVASN09QTG//AFvLCj3PLkKbAnfnx6+70FfdRAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OZUQzPsfwhgzu+LR3WQ+vLpWV+k2hCKRnjsjLNZZHQ=;
 b=k6H851/h/4nM/sjLMh0/FxvpGu/WsLQKgL6WAiFuuu67SyVoAiJOsTppC4+TWATuAG7KImObPPHG+t0Z34TLuVgvQFtgKFnmwtVF3qUvDC4gHrnaiINgZYRQTvltyw9Mw8IHOvLhJSHWZZXP86GXlPX0/2HFFmUeid0ya5RMBIe1SuNz6H0lHnc5xqgjMOPlC+ujxqupoa9/2ixWX/tul1KJ9kGFEXIQ18dFTuUvGYAlaZ0wWD6TNObDJF1pKm2ppC1fjRBDCtLQbEHxRH5++E/EWtL3q/mTRz9UR/bIjJcRLrEGPuv2Bn8pjIi5X7thURdiGX60Qf6hDKGXq6vSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OZUQzPsfwhgzu+LR3WQ+vLpWV+k2hCKRnjsjLNZZHQ=;
 b=zs6ufLq6PPaKUkH8wkdsTXeqDG04LCu0qfSSfTbbD/UAqMJjkFZc0S95dO4uT2TNxO8iqfxS8wRdRHFnLHsOaq7on2lnVpwCN7MAoRolSX0o10rkf8yfAph6FeBBf9yacwhKoeUC6OipdqsQOn0njWau+pl1JciatUJHMteg2bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 22:02:09 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 22:02:08 +0000
Message-ID: <9fadf151-0abc-427f-8e99-292652eba9af@amd.com>
Date: Mon, 30 Sep 2024 15:02:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: lantiq_etop: some cleanups
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, olek2@wp.pl
References: <20240930202434.296960-1-rosenp@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 24610f5b-a0ce-4b5a-9cfa-08dce19b8740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WCtqZ1pHTnE2VUhKSDd2Y0JQaFBBZ1VaeTMxZmkvZWFBVE1yTEFzeHdCUmJ6?=
 =?utf-8?B?cVd3UWNUWnRsL2I4eTZlckhweUs4L1BOWklmMjZLYXY2UU5OUG9BbXNsSFA3?=
 =?utf-8?B?cndqaHNZWk5RRHhMMXVhRVhyRnV0dXdrLzRvZk9vOTJYZTBIallWb05VUUhP?=
 =?utf-8?B?K0k2SWN4R2JFQ3hjajBRR1dZOEppR1c2Rk4zMmQwbmNjQkRtZGVqRnJHV2NB?=
 =?utf-8?B?dittR1pqVi9jN1A4RjhPUytvenY3VkN6VXBNWWEvTlY1N2hOU1pHZ2w2aXRy?=
 =?utf-8?B?VU0vL1ZPWXhQUG9JMFZIck9FdDh0aUg1ZjhGWUlzV1R4VDRyNG13T3FmanIy?=
 =?utf-8?B?Mk1UbHk3L0dZRTIxbHZKTGZ4emlJdGhHWDFYYVJSd1RpL3A3aWV6L2tlZE9I?=
 =?utf-8?B?RFZ5SG5YVTYzZ09KMnl1S2FVNGtwTzMxaXFDU0lRU0ZZTEtTUksrNUJQZzcz?=
 =?utf-8?B?YnorZEpEZVRLNTBDT2Nlb3BPWThUY0VQQ0ZmbU9EM3V1U0N2amNTTFdRMkgy?=
 =?utf-8?B?MjNEQ3JScXdHT2lpNG0xTEM5cmVZaFJJZkFDSTluRVMzdHMyaVJCdVdaa1NM?=
 =?utf-8?B?eHoyOVpCeHAxVVRva3lsRVhEbFRkTlZna3NrNEtVWnprdGphcmhVRlZrV250?=
 =?utf-8?B?YWRlQmlRN2dYSVpsTnNNbUF5bjM3V3ljazFtSWx1UVRJNmtwcVhmOHFILzNT?=
 =?utf-8?B?OTE1N09rSGovakFEN282bEpueStWUi80WDZ0Vm1kWHdXelFKcTFVSWlWYlc3?=
 =?utf-8?B?b2o4cW5vczhwOXJXVnJMNXZOa3d1b1FlWGtOL0E4cWI4RXVuTTBubis2SDA4?=
 =?utf-8?B?V2RkSkZ1SDM1RFlxTDRIS2UyRTVmNkx0MUJrYkVzdTJ1bFBTb3pxR1FpNUR6?=
 =?utf-8?B?NXVqYndjYzBzd3BFUk5ueXpCZHl6bEVTdXNhVjhnbTk0Yk84KytZRlNpRFdx?=
 =?utf-8?B?d0tJK1NCNWVYOGhOZ09nNzFNUWV4YUZsL1cyNE9HeC9mUStsRW9NZkJEQ1Fr?=
 =?utf-8?B?Qm1QSE8xRW5jbHg3elArYzlmVUM1YlRVMmFYOEQyaHVwTDBBKzM4eFlXRGtk?=
 =?utf-8?B?d1M2eTQwVmJSbHNrL3lOU1NTcytiN1hpbGRFanBwVlhCcjhBVkhDSkhYcXJS?=
 =?utf-8?B?VC9XK0YrY3Rha1NzellCazRielVjZkI2VE1raHJJcExwZ0hUa2RabW1lbC9x?=
 =?utf-8?B?S1B0YnpmVlhiZE5Od2dmUUJHcDA2VWxiR3ZEN0lpYWpvaVRvRitFdEI4UWY4?=
 =?utf-8?B?MzU0Y2dBUmo1YWcxeERpdWJBcmhKY3RqbmIrQWJtdk1VSG80MVhzVldoVnRZ?=
 =?utf-8?B?Z1ViMG5KZkZmUHpxK3VYZnJXOUEwbTdmZ0NOcDdlVEw5a3NJWHloM3hPOGRB?=
 =?utf-8?B?bDJFc2hzQVc0QmZBM0haSGpxMEVNNU1SRUNEaVVSNEcxUjlub3NOeE5aNmRq?=
 =?utf-8?B?YnFjTVBoOHNJOG4vY3l6bTJIS3Z0M3o5ZklEQVFYbTViSmVDWGQ3NnRoU0U1?=
 =?utf-8?B?d0VDY0tnVml5NUZBZUVTYmFORnFkSi9Udk1SeUowUDRxdXE4U2xQVUxEaTZr?=
 =?utf-8?B?bWpOSUhHTXBSaGFnN0txQ25jT2svOXg0VDE4SzhXUGNEUVpWWGhENGhvL1hu?=
 =?utf-8?B?Si9kckNMMFpQWSszaVhWYUZZL0JsREYyYnNGVFVWNnlQYnVSdnlBR0p1LzRh?=
 =?utf-8?B?eUl5cXNidzVaZ2FSVmh2bnVmblNDU1BQUkVkNkllU2srYlo1cHJvZk5XNFZR?=
 =?utf-8?B?bjVxNEVGaThOUE1KU1I4S2pRbUNQUGNiM05OamJzdFZBUWI5b1lzWDgzZm81?=
 =?utf-8?B?bVJKcTZSQkloNzV2VUo4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmQ1Tk4rSlA3RGpnYzYxZ0lWRFdDcURGUEZjSDdFK0RhZTBHK09tQUdVeXZS?=
 =?utf-8?B?cEhQS0JyNzBwV24xVEJleTFyRWozNU5xUHoxMmpHcXp5ck5tSndidTljTlo2?=
 =?utf-8?B?Mm1QbEc0MUtDVVRqaEMxYlRCT3diQWNaWTI0ZEhvTklGUjVJNWo5SW1zNUVn?=
 =?utf-8?B?eG53UVJZYXhqNCtRTE5EZm40MVRtaWc1K1hhYTNyUjIzT3ZOQ1ZJYVZwTGF6?=
 =?utf-8?B?ZXRibFVKWGpaWTRIZlBwWW5scE8wQ0FxUHJDYjR5SW54VDMxb1BBZVBGbXlr?=
 =?utf-8?B?QlZPRDdJRGh4TTRKdUJKY0tacTBnYVNuSFBFUlBBcEpUN1g1d2dFMkFEc0dp?=
 =?utf-8?B?SGQ5eFFWN3N6K3dzNWFEN09QVThsSXJjUmFpc0xhb1cyUlA3dS9JMGx3VGtw?=
 =?utf-8?B?N0xnWjM5a1BIc2UwK1JzdGJFczMyYnRTUFFoZTJ0WjU2QWxxOHBxSHZMd1R3?=
 =?utf-8?B?akM0NVNlbjkxakRkRzlyWHJQaUxOSDZGYnpSQjJOWnliK3VaRGtNZU5jMWFp?=
 =?utf-8?B?L1FFQWR3aTZhdUdibDAzKzJQc2NUVzBWVmlPQjFRcmgwbFdmQVpUKzNZaWRJ?=
 =?utf-8?B?cmxnbk9yek02Y3lQeXZCc1c2NHUvWVFqNDZXQ2paL2R6WERreTJzWWhySDFa?=
 =?utf-8?B?YVJmeFZWanNFM2tRRmk4NnhZdGJhZ3BPVFdHcDlBQWx3QXpyRHRRbW5NY3RZ?=
 =?utf-8?B?cWtqTHdMbWQ3cTczd1NiaWp3MFl6S1FLYW01RXl6Y252dlUyeTVUaE01emNQ?=
 =?utf-8?B?cnFLRHV2eTFidEpsRGs4b2FwMExjRjIrMXRiNFdMOXRqUnp5NElHQ3VRcG5i?=
 =?utf-8?B?dzl3eUpvaStEZW5DT0k0YkZoN01VK3VkQmpnKzBiSWJOdU1ja1Jnb0pQWEV2?=
 =?utf-8?B?eFJWc1JyM0NiN2NCQjJWdHRPT3Z2azBncys5VitGRi9NWERSZUdZVWZNRG5O?=
 =?utf-8?B?ekczdzB4UjNpbzBQQTNkYWE0VDdhUjJiVUhKOExjQjlyd01mOXo3S0dzYlZX?=
 =?utf-8?B?aEdlbFUxUjlvNUFtK3M4YWVlSmJlWVFvdU5MdmxWaVBJVjZNN1ZCdkQrUnlP?=
 =?utf-8?B?WWdvM2xyb2VxOEpMRkc0anY2bTY2WExiYjQvWS9VMDdiVmYzODZtaXk4TWRB?=
 =?utf-8?B?Q2FPR3l5UEFzbzdDbXgwNzhVVDR6bjFaeVhrVDBscmRaM0dsNHVjbjdpemhM?=
 =?utf-8?B?VWovdzQ1TzZHSDFqN2d5N1RHYjFjZkVGUzVpWU1hQUR1TG1qNnNRaFhwdG9Y?=
 =?utf-8?B?T3BENVBwVzM2MWhoZzF3RFBadFZka3FuMXMra05CWE9Ia052cGJpVndvZHlD?=
 =?utf-8?B?WkF2allUTlFPRzRWTGI5cjlQbFBETGc0SEU2azVsVzRTMWFXbVdtRjhxSDB5?=
 =?utf-8?B?b3lMcTBxSlJYaG9wZkJZcWJUblh4VVlOL0ZYTUJaNlIzWUhJeEt0OUJBWmlt?=
 =?utf-8?B?T1NtSFZxclAreCt0Nlp4NzdzaWJneEt5bUdLYWljcVlpRU9kN25RL0lTdnRj?=
 =?utf-8?B?WHZidDNBVy9pa0djOE1HaDBBZUdwL0Z6ZlRJODBXbW1zbkY2NmkyYzd2ajZP?=
 =?utf-8?B?NVNCSTloeStTK05NVXlmdC9wRWI5THp6bTA0aFhUTFlIb1lmUzBCK0x2VGRp?=
 =?utf-8?B?M3B6aDlrYXIrV0NVU2dJTG5IdlZ1QUNoTk4yM3NoTS9MOENSeHBkUlB3YnRn?=
 =?utf-8?B?aGdtc1VxaGFGQW9LT0RJVXNmSFZqN2dTU1VBbDZWc1FqN1NsTHNoQk1vZG8w?=
 =?utf-8?B?RFd6Y2tOOGJrK3ZJSW5MaVIwaGJmaGdDMnhwZFJicFowOXo1a1kvRUdxZWNx?=
 =?utf-8?B?RWt3OGJjWnBvdGZ0U09qbkFGMmRFWGNla0JIckloTTRmOXRyd3BiYlFqNW1P?=
 =?utf-8?B?SmJLNXB2MjJwVzFOTGg5NmxhMWxFcFY5TlZqZU1aOHBEU2l4MjQrNXVqUFNp?=
 =?utf-8?B?R0xCL2RHS2ZWamE0NUlqMW54cmc5aWpoaVFvY2p5RjczbmRMMC9JSWhjTTNU?=
 =?utf-8?B?RG11WVRJWlZCblh2bUJtVjBHTE1FTjIyd2IvR0JScnluajdGZUl6NG5YL3lF?=
 =?utf-8?B?ZTNzcXk2MEJubm9ZS3hVc1MvMlN1RjJ0UUMzdmwvdTFGV0w2RlhYR05tTE1i?=
 =?utf-8?Q?oXFFBlr13izbGgNF/UMJHhL51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24610f5b-a0ce-4b5a-9cfa-08dce19b8740
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 22:02:08.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wPCLys0lQ5yiK6GJSNP3aGtp4pO87REAg5q/Oh4Xfi7sUKtPN4QSPUG4bh/brfEIaq2EmaHKh3ZjlaNBZt6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035

On 9/30/2024 1:24 PM, Rosen Penev wrote:
> 
> Some basic cleanups to increase devm usage.
> 
> Rosen Penev (9):
>    net: lantiq_etop: use netif_receive_skb_list
>    net: lantiq_etop: use devm_alloc_etherdev_mqs
>    net: lantiq_etop: use devm for register_netdev
>    net: lantiq_etop: use devm for mdiobus
>    net: lantiq_etop: move phy_disconnect to stop
>    net: lantiq_etop: use devm_err_probe
>    net: lantiq_etop: remove struct resource
>    net: lantiq_etop: use module_platform_driver_probe
>    net: lantiq_etop: no queue stop in remove
> 
>   drivers/net/ethernet/lantiq_etop.c | 141 +++++++----------------------
>   1 file changed, 35 insertions(+), 106 deletions(-)
> 
> --
> 2.46.2
> 

These all seem to be reasonable cleanups - thanks.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


