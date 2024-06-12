Return-Path: <netdev+bounces-102921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350D90570F
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70E7B24995
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77A6180A60;
	Wed, 12 Jun 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VekAg5nH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD01802D0
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206613; cv=fail; b=tjcDy3ZDNFP5LfkHSrw3/fDXDUHtu9GqtqcLHpdKDYkoeQIpmRNiNGC/8McMVWzIZRDW8nLsBL/VeWNmnyEfE/AwtYGpYgaI+3/WxXdPlK24rKAi9OIa/B+kusxzg6s8i70vVF1RzWeJBqFAl4Xs9TPD7wstJH+4QqC0b0GzkeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206613; c=relaxed/simple;
	bh=iiRQBh/A/WtebGEkoHlCejnPUtCJywu9ziaGuyynsGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tUJaIAPh0dcTnJYbtjONep0Fzgp2qJRk1BidfIhtXli7s+iXLfsMOQrcQBHCPy0rlm9tc55VNHCsxDZ7U2uBGvHLJd/NAlboBGdXC/WMkrQjxhREVnSuLk9LY3UrxJhAm6+qystv/R0sDR4YemZex6yeOxXRBCo+vQePntKydtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VekAg5nH; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA5zfTopF1DmHuPssDdLA10rrqWnfgIc91aUykCQhmCaHkysVmiR/mQAXmoytQ3Zd/88kC0qaYkVtWYm32MBlQZAhq3/VbYUq9XFqiSBqFcj218u7Ny+E/XG9+XKi/ps/JIU+U3P45Ghm/M5OueinZNN9+W8NUJzwL2XSme2D+U0KoFWgz8ScEaDGB1azcTp+gxfd4IfWRLdEj1+F53ZUN8Nskrxow0jOWuhl0ApI8fp/FCdZp840BzSvkNVkCLg/RsJ2f/b4xnwyMj5mm6k0e2111M+ueIjpZeiHG9a/Q+SwPuafb7o37vuNdNJisZGmP70i9d5Qt/siFnp0Qgy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXNz9t0pCKOmRe045WiVskYBc4n8JIBbS4ODZASeMtA=;
 b=Yq9g8JX9YpV2Xfac9hpJhVLZlb1CfsJLScqgugROKNVbPiHv703gbuADhiR4eWTQY3WvdKHCLCvd2K8m30/CxUwg1uTysL9kbM6GiTIUCwdm0cDWGEX77sJ8o9XpYJGIqj3Jextj1e5oIGhAKCgPo/fGZ35+h/cMEk46l30O6tVHhAaLp/D48GpDA78+Q2cpmC4SxflEuquQX/ZOm4/rG6mJWck5c3o+6aWRx5RaeV4qhxtLOdvc3DqIXenA9LNMAJcwJqQD5q/p/NIu5h2djhbQFB4Jj0M/Xl9bzZm5QQ2FiAcjm8LyO0SRHNlcHsU3YjZSiSEKBfD3TjO1tqVlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXNz9t0pCKOmRe045WiVskYBc4n8JIBbS4ODZASeMtA=;
 b=VekAg5nHVoz/9xCwjgjveBCn40Ue8a2T5Kk93zUDEFTQ04lN6wvTei+kXHBV9SEsxOQAxO/Ddtf9p7We5qe82oOm8YIXt91Iu65JjG0fnNU5dKgbizGPnuJ4QC+zFxI63gZyA8dUTV9zLaj+Rt3IWsExBWzERoA2M1mWge7DSjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 15:36:49 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 15:36:49 +0000
Message-ID: <89643ab3-1950-4493-9993-3dd3d710be45@amd.com>
Date: Wed, 12 Jun 2024 08:36:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ionic: fix use after netif_napi_del()
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, shannon.nelson@amd.com,
 brett.creeley@amd.com, drivers@pensando.io, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com
References: <20240612060446.1754392-1-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240612060446.1754392-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baef0e6-a0dc-4043-a2d8-08dc8af57987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K29BcHN6OGY4Q1VBeXoza3kwVCs3TWxGdVNjdS9aRVNNOXZMMFZ2Q3pxUmNw?=
 =?utf-8?B?SkV2MzlONTBaa0dQL3BhbFdwUzBaQUt2WW5WTzl4OTdjdFEzRzRhRk10OVh6?=
 =?utf-8?B?bEVMREQ1VXNhOW93UERmYVlhaVBuNmU1U1d5c2s4RCtTWjEyZEhyMDlGRG93?=
 =?utf-8?B?QUZ4cWVtc0tybXkvVEQzUy9DMHpCSGphNWRwdmJmVXdlWXpleFpZNE9neUwz?=
 =?utf-8?B?dkFTeHA5LytRRUloVHNFS2pJaHQ3NXlRRE1ROHBEVkFNSmt5OTRRdnM0dzRl?=
 =?utf-8?B?N3RndmFtdHZHVHROUW9mbytPcjdYWHZxcCtYTkdWSUNPMjhBR3R3bktMTVpF?=
 =?utf-8?B?SFp4VFk2dys1OEVNYjMyeHB3YS9DQVRFVkxrL2tFMnZHNkVuRElRTERlT1JX?=
 =?utf-8?B?OTlmTGVyanViMG1hQUdRSlBnVDZTeUlaVzJxRFVWeTFxcnF2QmdmV0FJcXVZ?=
 =?utf-8?B?ZFVrc1AxN280SWJvSVpWK2tSZ1c4dFlBamNFdjZkditxSUpGdnJPSUtmeDRT?=
 =?utf-8?B?cmpUOFZhcXQ0UEJVWU9UZU5uSXk1NTgvR09sV1NLUCtKTWNaSTkreVR5UUZU?=
 =?utf-8?B?NG05bWpjMG4xd2wvODN0SUROWXhEbSs0bnpUTXdvZ09VTVNXV0xTcWErYXhX?=
 =?utf-8?B?TWVFUC81TVJhRFcrckVybkVaQzd4a1BoTDBkZmphWmU2WHFyQVY3L3VlOWlE?=
 =?utf-8?B?TkI3SXcrazZwV1dxMXpsbUpHdnNVQXZFNkhCRUduRHdkZU9wUWdOMkNGOCs3?=
 =?utf-8?B?VER5eUl5cy9kdDY4WkNQeHE3YXN2b2hBMGxXd2Z6bUhnVkpoQnNYLzlEQjVh?=
 =?utf-8?B?MnE2SndEejhvUjNQd2lHMkZhb0JST3E2NkRwZ2FYZkl4ZUNlZHNVRjJTUUdv?=
 =?utf-8?B?TTRBSnU1Y2J0MmduRWFCMXUzMWpESlhpOXpGVjcxclVaT2pxRHY3YVNvR08x?=
 =?utf-8?B?aS9Ya3ZPb0lUQVo4QTh4SHphOS9oNUxXSHhJV2ZSemk0UXBTUWQ0d1Qxb3Bi?=
 =?utf-8?B?SlowMUJPbFFoKzE4a2FheXJmclAwUDRKRW9hSUNHc2NkQ3pOdXg0djZ0Y2FY?=
 =?utf-8?B?ZkxhWXIySnlST05BREdoK3NwVlZzQjJnUWl4NVdkVEpxVURwYmhVWkZaZ1pV?=
 =?utf-8?B?QVNmdFcwTlRRL25GcVk4YXRzdTJwNWVKRTc0RWJ0Qks5c0RuV01lNlV6U3ov?=
 =?utf-8?B?b2NTM2hNTExOYkdIcEIwU1FYc28wVVN4dE9KMkZOUENibzFQUEsxL0xKTUtF?=
 =?utf-8?B?dUZsSVlSUktQanp0R0t4T3MrS3FQSmZ0WUkrREovdEhOWmM5eWJtdUgySnFo?=
 =?utf-8?B?OXVXdVB5d2JWdTdUL3ZQazNncjZDRHNBMDk2WC9KV0dmSERRT2VGKzh4WGZZ?=
 =?utf-8?B?Q1VrR0NjUVRtYXpNSWZ5WWdFTzhkQjlsRVJ5TnAwL1JNRFIydFVSbWo5dVY1?=
 =?utf-8?B?ZDE2cXFaU1FwR1J5Q0l5LzFRbi8rSkh1bFROZHNCTFYzVWE2eGkya0lWa3Jh?=
 =?utf-8?B?UFcwMmFvWHYzeDB2ZlFQNGdudlh4Y1hHYzZBd2xwQSs3SkVHRVVmSXozaUlQ?=
 =?utf-8?B?Z3BqVmM2b25mWmtucWs3NDlNeHg3UFkvbnZRQVUzaExIWllQQmpXREI1Q29U?=
 =?utf-8?B?VUJUTE10TUJHSTJ0MFFnMFdVWTJqYXUvaG8wOVE0WXJJeEM2Y0dIL1hYZ0p4?=
 =?utf-8?B?TXFPRmZwVnBVR1BmZC9iWFFPUVBNYWVvOFl2S0J2OFpLNjZwcXBwZTg1STJC?=
 =?utf-8?Q?wkidJ5EGGNhlQQc/hvgwQIdoYS8Fd2kFUvEfiPS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldYdzh0dFFsZkNBSVlGeVBVY3QvTThkd0pzV1dDdjQ4ZUZ4dU5keEZScW9w?=
 =?utf-8?B?Qkppb1lXdmRGTjdWS3pjUGZZNWM3ZXU3R2VzbGhFbVRNMys5NVFsMjBWS0hH?=
 =?utf-8?B?cFA1Z2J2OGhuNlMwVTdkTEZma0EvalZ3OHBRK1owYVhITEVGcWQxdFZiUkda?=
 =?utf-8?B?cEx1aUNha1Y3Vko5NnVvWkpEUlZKMno0Y1Myc2JaajgxUzljRkJla2hmM3ha?=
 =?utf-8?B?KzF3cnZ6MWRFSEFwSlQ5WGtmdkg5VjV4SEFSSm9MNE9XVjIvNnhFZWJrd0pk?=
 =?utf-8?B?Zm82cGNwKzVsOFI1dEY2bVBIUTY2djRmQmhBQitjMTFseVcvZzBINUh2VVZj?=
 =?utf-8?B?QXB3NkFnUjhLbEI4OXhZNGh5N3kxTktwanA0am8wcnVpd1g2T1BIMms2U0pV?=
 =?utf-8?B?YlFHVXVFVC92bkRtNllHblQybUJveExMejY1YXZpOTRPTWdPVmQ0cXlsWmF2?=
 =?utf-8?B?bWRnL01aZ0xxb2lSSkRraC9SMGNBWit2SUdXMzhnc29NNDlhK2VqVzd0MWhz?=
 =?utf-8?B?MzhCREJiTVUyMjI2YmRZUUkyVVdDQ0FaeTZoN2FEVGRUWmZKb2Vobm84RlM0?=
 =?utf-8?B?OXpZUm5BbFNiQkNveDJUd2FhbWZrRWdtVzc4MFd1SHIydFMrQnh5WHdTdEpz?=
 =?utf-8?B?ajBXeU1qMWI2MXk0WGVKaTBXS04zUU1PaGtvb1BRRWNzUWZWeEFFbUUwK2JB?=
 =?utf-8?B?R3E3UkZIc0lhUXZ4cyszL0E4N3FyM0UzZDQwd2lvc3BSQkU5c1MzSHpSYjJ1?=
 =?utf-8?B?NmNLa3VHWkZNSkRra2dwSXVNN3IzVFI5NEE1RGw2RDJERkRNUFZQbjR1aTkr?=
 =?utf-8?B?ZnF6Z3NteHhTRmIxUVBEZmVjbE1RaCt3QVF6Y0w2TEQrNmpIMGVwZTdHK0pE?=
 =?utf-8?B?a0luUWN1cnJIUTVIU2g1bmlDL1c4amp3c3lodmYyZGFBL250UXhuOG9aSVJz?=
 =?utf-8?B?RXlWb1dlWG1uWTlEbEJBMHROU2Q2d2duZW4yRGxMQ3NHTDFFbDJER201N0R0?=
 =?utf-8?B?dXl0WkR2MmMwbStMK2ZJY2Y3TUNqbkxHSmtVNWZiU0dsUFZ0cHFBeElpQ0pD?=
 =?utf-8?B?TDBPVnV2cG8xYnlhcmo5RzFJaFcyZy9lR3E4KzZwdFBydHpNbUx6Zm02S0VY?=
 =?utf-8?B?SmFmRzM4UzVsU3Jud0ZPUmlEOEdvMGNYMHF4UURNSlZVUUNTckJHN1NTUmdp?=
 =?utf-8?B?UVk3TlZmSGtrSkJsUzltYTk0cTgyM2tKTzlwOXR5TWtXY0lxNGxaYmhhUGk3?=
 =?utf-8?B?UlNsVDhRQlQ2SWYxSUpQWUdqblVrWGNlRTRxMytHQjJzR1E1aWtFczhWOGNn?=
 =?utf-8?B?TVVTRHFVWGg1VjgzOHhjYmY2Q2g4UDRackVPV3pweWdYdTZnSTF2TnJsdWwx?=
 =?utf-8?B?cWhoMnhhcEkyb21TSXh0QjdtUjI1STI5WXlMeTM3SlZ2bjJQdEtQR0RNd2Jx?=
 =?utf-8?B?Q0Z6cklZRzZtVnFUZk9VQURBeVRWQ0puOHFOajd2UDk1YkkxNUk3cjdnTENS?=
 =?utf-8?B?N1FvNWRueVA0UXFnbVBTNnJrRkR6ZnFLTnErRVR0eDVCd1B0a0hqaFM0OWtF?=
 =?utf-8?B?eVQ2OE53cWFoWFQxc0EvUjB0NHBkSEU1c1hPYm5HdG9WOWt5K0RVeDVNNkRq?=
 =?utf-8?B?cmlYcTI2bmlPbWRXRWdSUDZLZnY2Rk93dEFWN1pVRnFLNGFMb0tISWhrVzR4?=
 =?utf-8?B?SDk1TUZTL0lwU3pSNDdUS2wzZmZsTTBTNG04d25Nc3l1akU1ZitGb1hPTDJL?=
 =?utf-8?B?MDN2M1I0QmY0RGROaWNYZFVsamg5cTlmV2xZaVRjcEErSWNsUWI4aFZubHNN?=
 =?utf-8?B?YUFMcjBpRm04TTFNSmMyYXJBSG9rdVNxQ2pweEJUcEpjY3g2NFBJbzQ4TTRm?=
 =?utf-8?B?a0hqOUtXK0FqczY1V0NxWDR5U3U2RGpsRGJRUDc3RkZLbjFSYmI0ZmJZT0VX?=
 =?utf-8?B?MW80WUlqZVdFa0dvbVIxelBTYWQyOXIvQVl5WlgzeDJPQ2tYd0dsUTN0ZEhE?=
 =?utf-8?B?akEvbm1OU1hYTy83Q1o4bGNidXZ1QkFEbVBzUElwdjhrQWRRcS9idmphczVU?=
 =?utf-8?B?UE1wNXBtekIrT1I3bGFmMWwxMXRqNnh4bm1GR2hCaG91OS9nTWdFcEJLaHUr?=
 =?utf-8?Q?rE4SeD6BDXHJdsRmCjaghwsBR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baef0e6-a0dc-4043-a2d8-08dc8af57987
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:36:49.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emY/mOlUhYIlp5HmTXC3DypISHA+YnaJiBMXb1fEHeukcLLgPLWsqjMakSYUPFj0YMBI35HRwW0JJkpllDsBFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136



On 6/11/2024 11:04 PM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> When queues are started, netif_napi_add() and napi_enable() are called.
> If there are 4 queues and only 3 queues are used for the current
> configuration, only 3 queues' napi should be registered and enabled.
> The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
> enabling only the using queue' napi. Unused queues' napi will not be
> registered by netif_napi_add(), so the .poll pointer indicates NULL.
> But it couldn't distinguish whether the napi was unregistered or not
> because netif_napi_del() doesn't reset the .poll pointer to NULL.
> So, ionic_qcq_enable() calls napi_enable() for the queue, which was
> unregistered by netif_napi_del().
> 
> Reproducer:
>     ethtool -L <interface name> rx 1 tx 1 combined 0
>     ethtool -L <interface name> rx 0 tx 0 combined 1
>     ethtool -L <interface name> rx 0 tx 0 combined 4
> 
> Splat looks like:
> kernel BUG at net/core/dev.c:6666!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 1057 Comm: kworker/3:3 Not tainted 6.10.0-rc2+ #16
> Workqueue: events ionic_lif_deferred_work [ionic]
> RIP: 0010:napi_enable+0x3b/0x40
> Code: 48 89 c2 48 83 e2 f6 80 b9 61 09 00 00 00 74 0d 48 83 bf 60 01 00 00 00 74 03 80 ce 01 f0 4f
> RSP: 0018:ffffb6ed83227d48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff97560cda0828 RCX: 0000000000000029
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff97560cda0a28
> RBP: ffffb6ed83227d50 R08: 0000000000000400 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff97560ce3c1a0 R14: 0000000000000000 R15: ffff975613ba0a20
> FS:  0000000000000000(0000) GS:ffff975d5f780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8f734ee200 CR3: 0000000103e50000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? die+0x33/0x90
>   ? do_trap+0xd9/0x100
>   ? napi_enable+0x3b/0x40
>   ? do_error_trap+0x83/0xb0
>   ? napi_enable+0x3b/0x40
>   ? napi_enable+0x3b/0x40
>   ? exc_invalid_op+0x4e/0x70
>   ? napi_enable+0x3b/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? napi_enable+0x3b/0x40
>   ionic_qcq_enable+0xb7/0x180 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   ionic_start_queues+0xc4/0x290 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   ionic_link_status_check+0x11c/0x170 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   ionic_lif_deferred_work+0x129/0x280 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   process_one_work+0x145/0x360
>   worker_thread+0x2bb/0x3d0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xcc/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2d/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>   v2:
>    - Use ionic flag instead of napi flag.
> 
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 24870da3f484..1934e9d6d9e4 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -304,10 +304,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
>          if (ret)
>                  return ret;
> 
> -       if (qcq->napi.poll)
> -               napi_enable(&qcq->napi);
> -
>          if (qcq->flags & IONIC_QCQ_F_INTR) {
> +               napi_enable(&qcq->napi);

LGTM. Thanks for finding/fixing this!

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

>                  irq_set_affinity_hint(qcq->intr.vector,
>                                        &qcq->intr.affinity_mask);
>                  ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
> --
> 2.34.1
> 

