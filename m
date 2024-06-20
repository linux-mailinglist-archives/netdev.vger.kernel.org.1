Return-Path: <netdev+bounces-105469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1591151A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D27328131E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F2757EE;
	Thu, 20 Jun 2024 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yq4SWjMP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB959148
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920082; cv=fail; b=SGuOukCTQeB0+JNTIH8tTqNtFiUxAAzhECfSqmGdA7DGuqoImCej813WHaz6tDOaFBnegfev9PPFYtPxfBYcQ55vgEjblQyF2EfrTyImERPFZ3m1gZLvzPWPOodWmmRhdhZHX6os756ulVllGPm2NlM+0DerZMB/XJ7vHGuXIqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920082; c=relaxed/simple;
	bh=gldzcyloB4PBH3qeeV+ucuova1jpdeSXVBC1gk0indg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lpx3VkwAIUMiePzs4TiRRh2fxKJNqBrCFkIt9RWow+U29i1tC1RUBWCB2gtnJNkopike6r0lHm2unKQ8BXh6jRhVN84g8aJgli5zESQbKqUFwp+E8A8PbLWXlcAMlo4H6b2NBnh2SlEoXHaNkMrtfQdWREXCuCtXYUodspXpUHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yq4SWjMP; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/+eQYYL/nYdLNIJFiTh33fvcllbRIbGu7qsWiWPWw9/kvA5AwrYYdrE5xWG+rA0a41BKxDUTvX6lE7BGVq1UyKsGbVhAQ/9rZ7a85XmgHKAf7Iu0plg5SqfUUBiIgf0mysrjz2WfQMaXMTQK1Q11fprx3Rc2UyuiJsejubEyq7NII6haaqyafZUhXv2QcWsy7FfPoQ0+7Bw4wCGL0M1XfEu6ebw5YrnHYUiYczbdIj2GMtp0+iMeNGY391zrWGpUz+6jaF4rAl7dcCOZc2wVyS4DnhqzeFtABNfgYvXUhf3wgWm18PdljCriIg+2MI8unqANRxlX3m4vepJ3ZRL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eqdCX4FemNlx2caty7C28viosaMaPy2ke0jRqIABQ8=;
 b=ZN4zmKlSSIlMDq5mkPrHi7zrtyNU4WiF20Im7hEEzm+mQkUwDbkFYB+r/6IBqq4h7Bc4dBa7+Iy6+cY9iQKABwSD3DAwaikv4xguQyh8nOOdLvQTzvWnFGsdOr5V7sgjMjeXtiElo+VTENtsENWijQejcQsNyk4o2sfIm37HMyibICeYJGlFA8h+kyUgL1YJ/P5YNQ87KBGU9UrNnJuBFg5H+j4K6OLRaKCHM8Od+EMJ27hyQPgt7fl2Rv0Y/oK3e3Zg63t7p8DBNqEBD7dz7/66uZR8Wg4uu+GkTXrXmhtGIeJNU32wAdyuiJKhlAnDR9scuWrOYS9BkRO9dLN38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eqdCX4FemNlx2caty7C28viosaMaPy2ke0jRqIABQ8=;
 b=Yq4SWjMP/2GQB2pYMM/WTk41a3RKyvr9BZzs3d2K6QmhIHsCghdMEd1DUK4Xpop1MT0HFyrFhcjkZ0Xc/qFBj/wBRYxB3SJJM7p3OUjwqEIGGnnN8sQxIU2RHmwRlMCGCM+LSScBPqXU8UJKFSLtNwU9+jGm6HNgP0kcl5w7gQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Thu, 20 Jun
 2024 21:47:55 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 21:47:55 +0000
Message-ID: <e21a3087-0c2f-4087-bb77-ed9cff2d5ebb@amd.com>
Date: Thu, 20 Jun 2024 14:47:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ionic: fix kernel panic due to multi-buffer
 handling
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com
References: <20240620105808.3496993-1-ap420073@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240620105808.3496993-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5be840-eb5e-479c-6a4a-08dc9172a463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3NyQ2pDZFI5Q2ZxaHJRVDk5cGQ0MWtST0swVGlvaVlpakREUnh3SlJxdGti?=
 =?utf-8?B?Ry9yQ05uR0wvV1FpM01KK3dvWlVuSlhTaCsxY0tqMWowSlFOZkRFbXlwbnlW?=
 =?utf-8?B?a3RUa2hUM3gzemsraHFhVlVTb1Z2ZUd2SG1FNG9kRFhSOWl1Q0dLWjJWZVpI?=
 =?utf-8?B?N0d6ZGhYZFZVcmRYVlFlYS9Kb0ZmQVVOVGZsT0xBNWpES2RGclpJYWllUkpJ?=
 =?utf-8?B?YUxPR3FBVTRPeDBLVnZxZXlKNzh2UHNTS1ZFMk5vRE5zYjB5dkdlbjV5ejR4?=
 =?utf-8?B?Y3Rmd1lST1ZFTEhOK1BCQmRCc3YxRFpBUnJ2RE4vWVp1emRiQ0F3QnZ1eGpR?=
 =?utf-8?B?KzNtNVd3bUNEellmVFRtQzA0K0thZ2FxcjNsT1NZZm5HbEgzN2NyZFU5NFp1?=
 =?utf-8?B?dnVXNDBPSGRQa3Y3SXVEalIrd0Q3c01LY215MmFjSmMvdldhbFlZaElkYkpB?=
 =?utf-8?B?U0Iwcmcybzl0M3dDcGZVSU9FVmV4dFV6NkRsMExrbWtmaU14ekFyVEhXYjV1?=
 =?utf-8?B?UEViTVpJTEtFMkVKdGhHWlVzbmxneHdTZWNNK3RBK1NWdkQrYTNmeHVlYloz?=
 =?utf-8?B?a1BLTjk3d3JrWEYyemhnb1AvM3FNSkFWcWdhcFhDZU16UkNEb09PNDdRMXBT?=
 =?utf-8?B?eElSUmR1MnEzRXcvMERlcEZEdTE2S0w5bHd3RWo2Rk1udUt2OWtCUnRqV3Fz?=
 =?utf-8?B?WUNGMWxJYTdmeGZwN2YxQzlFSWo1alZyejdHcUk5N05VZXUrMmE2YTdRbUMz?=
 =?utf-8?B?NmtTdm1PMy96MjJGZTRkamtUU3dOKzlSNGQzWjh0V0k3ZWhLRVV1aTZCcVNq?=
 =?utf-8?B?SE1GMklDTUdKRW9hMUowYzJIZTR3MkhPbkN0dFRNTUpadzVvcnBtN3ZFaVZT?=
 =?utf-8?B?bVIyZHplWi91M1ppSmF6WU5vcUNiT1Y3WGhPYXNycUszUndKVmJhSDJFUkw1?=
 =?utf-8?B?UFNrNlNPdy9ZWS9xRXlUTFo2ZWx6QjRwKy9pU2NzcG1KSlU4eERHc0krKyts?=
 =?utf-8?B?NXphZVlqRk43eVlFaWtYNXNkNm9ONk03Q2UxMVVDcHdTMktqK1J1bmpSa0ly?=
 =?utf-8?B?czdFVElVTFBzbVdNWTRWNVZHWkVzbzJqSkFWT1B4cU9NVGM2WThjaDYrM28z?=
 =?utf-8?B?ZWc5WUVTUnlVR1dNbGJGOXZ1V0xpSGplZjQ5aEhsN1VuQmhpaEZ5VWRYclVa?=
 =?utf-8?B?VEc4Rld0cmd2ZGVSeXlvczBBRmk2SDJHWkhYZ3lETDI3WS9xWnlxWmU2ejhC?=
 =?utf-8?B?d1RyamY2b0lLWHcvRS9YUkJuRmZrSjZCSXBmbzZ0YU96SjFtL0VKSlB3VnZI?=
 =?utf-8?B?ZUNXWmtONVEyWkVXMDdQd0d3U0w5WC9zZStkMnFpUjZiRW8xL2hhaU1LdjUy?=
 =?utf-8?B?ZEJBNGk1Nm5KU2pRT1ZLbTBOMThRM3lUM2l3M09ENmtCVkJ2K2Q2NVVIOVB1?=
 =?utf-8?B?aVZtMkJCalZsSTl2K3lMMzhxSFN3a01mNSs5dEZad3Z1RWc4a1p6WCs5L3lH?=
 =?utf-8?B?YjhhQWhEdHFDTGxNSnNQN3FiSmVQUzlsRXdBOGo5Z0xrNzd0WjJBaStZOTdQ?=
 =?utf-8?B?VUFBTmJVeXRwWlA5cDVqZmhrWWV5OVBIeGdhWDVYZWx0VmhzSEd1NGpydFpw?=
 =?utf-8?B?QUNxRHUwNEZiNmdweUkrNkV0bCtqZGc5N2c1UmNYV3ZveUtMTGdlSE5rMHd6?=
 =?utf-8?B?aEU1YkVNdjFIL3ZIRjVwYXN0d0VnN3MzbGNacEIwUDhraWVCazYwR0pCZkRN?=
 =?utf-8?Q?eB9oJ4mqFi+M8XBuGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWcwaHdxRi9qQTFlc0VPdWRjcE41Rjk0UFY0VTlpWGFoM01hdGt2NEF2eXJN?=
 =?utf-8?B?SWtnWjc2Rm1OQ2QyUXNhVXllekRMWld6em16MnJDaHBOT3NJaU10VndYUUxl?=
 =?utf-8?B?aElJRERwOWFkazExZm9RcERIbmlKb2RkS0M2cVhVdHdRTW9xOGFTVGd2ZHBh?=
 =?utf-8?B?aXIxQzBZYk9ub0Z0WTFFSzMvSS9ySzhPUWVSUHQ3ck1WUkhQNDhXcVNCSVEy?=
 =?utf-8?B?Z09XeWg1N3dtbmcxdm5lTnNvQi85RjJJcDgvRjI0RGo5RUN6NXVJRmplU0Mz?=
 =?utf-8?B?a3hkOXBaNVdLa1pRNlNkemlLM3pCa1BlbkxwV0w5RjViSkJtVDlvSzNpQ2Nk?=
 =?utf-8?B?L3hPTm5lSmtESVdQdzBXckEzdzI1MTV1NENRL2pjNmJucVR4Ull3bmlhVFZN?=
 =?utf-8?B?YmpmRlRlclJwYkxENW0zSnNTYlBrTWx3bTJ0R1N1TU5RcGpMSEZaSTJteWli?=
 =?utf-8?B?QkZub0NUQ04vSURDQStYZHRtOHFBVEV1c3ZvTFRNRU1EK3BCamx2UUVEdngy?=
 =?utf-8?B?QlZlbjRQYTFEUGxSdTBZM0lzUGJUUC9kT0NhY3M1Tmo5Q1ljMTdqZ1hnS2Ju?=
 =?utf-8?B?WW9KL21tRkJHNEZYMGZjazlPNndXU3ZZU2MwWGNWQVBLTlVjVEx3Vk54WWFC?=
 =?utf-8?B?b0Fodm4yeGxMUXBCRFpoSTdGY1Z5QzZPN0F0S0tVYVA1aUN0QXErZkwrZ3U5?=
 =?utf-8?B?eDRIdDBiNG80RVNDa3hpL2tOVlZGR0R6Y2V2V082ZTNLSVhNNzFpZGNiK3VU?=
 =?utf-8?B?azlNMmY0ejdkUit6Vi9rYUcxMnB1bnlEZktJL2JjdG03aG8wbEdpbjNFTDQv?=
 =?utf-8?B?K09TZ3ZFV3ZtbW0wTERsK2ZZeW1ETDJYNEplTTM3dmkwT1lhWG9qdVRGQVZ3?=
 =?utf-8?B?bDBtbmI2WU1BUmlJL29sKy9ibVJOaThCWWMxeG5HbHdDbm04UVNpVmRkek1X?=
 =?utf-8?B?YWhvWVA3RHl0S0VDOHV5U1IycGhaN2R3amtvTTFuYnprVnpMOU1iNXp2ZExB?=
 =?utf-8?B?ZnlHdkxOakpBc2JMekNIaHYyTjBoZWVhSmZwTWpKN1RxcE8vZXhwd0Q0OGh6?=
 =?utf-8?B?WkdWYmJQZTFXU0dtcExtc2dicFNLMjRYYTBzKzk3V1l0d3J4MWM2ZnB1SFU5?=
 =?utf-8?B?QlY3dWxCR0MzSkwydkc0L2c2MWo3dEMyQzIyOXVySGlpeXVNZXp4d2h0QmRN?=
 =?utf-8?B?OXJtK3BPRUMvMjdvd0pQT1lmWDFIZUJ0R05pZjJkaHlKSHdRQjlUOWVNeThL?=
 =?utf-8?B?UlRMM2UyRTYwcmg5cVdlbFRuMFhmdWNEbnBYZ0RydFdvRytNNmprbkNBa0ds?=
 =?utf-8?B?MDc2dWVwRmd5V0M3K0JoY1R4ZE1LeUJMSXd3YWRja2ZKeXc2cFBlYUNZSnVM?=
 =?utf-8?B?cGMxejI2SjJWMTFlUE04QzBUbHpVbUJvRDJPQU52RDJNcnNTbGFJcUFvVUtt?=
 =?utf-8?B?TG1tN0xXM3NwN2F6VG02RE1QU2g0YUhLWERBaXp2RGRlTEhSR2xUNU9EQjM5?=
 =?utf-8?B?OXl1NDhyTUd2ZUdQQVluajlseDd3VldIeWFiWko4QTV5Z1VLY2I5QVpyK1Zk?=
 =?utf-8?B?VEMrOFl5RDVvNzU4MnNCNCsrOUl3b0RFeFg0M29MUlR3UzFtbUVQcFVaSU90?=
 =?utf-8?B?emFRaFFvRVcrQ2hPSTZaUVdoaTdyTXFSamxqdjVZdUZuaXpNU0x1MTVVZzZ6?=
 =?utf-8?B?Q2hwYWJ1WFVaUG5yUUNNdHpHSjhGVVJRMVpORVB1QmJUQmhNakR1MzlHSUNl?=
 =?utf-8?B?NTVCMG9jVVVPc3ZlYzhWVm9MWkFpVVk2bUppZnc2ancxY1ZURjIzMTlhVldE?=
 =?utf-8?B?R0d2REgrRyt2blBONXVhckJEdlZpOHpVaEEyOHhESmxYRUR0S2ROMzZiSEV4?=
 =?utf-8?B?MENHK0V5cjlUMmIyV0F4K3FIb205eHZsOVFBWVRWNWo0ZmVVRkY4dnUyMUNU?=
 =?utf-8?B?YUo1dDZDQkVQT0lCNmIvcDVyM2psTjdMeXY4STBjbCtwWXcvUytNVXVkVXJt?=
 =?utf-8?B?NWZCUDVsUFRqUk9Yay9OVG1QU1RjYlNZaXhGNVJvcFNtYXlaL0Z2Qk5mWW9i?=
 =?utf-8?B?cGFqdUFDUFRYSFo0WlZWRHlndStwMzVhYnd6RUgyR0JLZU9tUWNCNnJ6aFBX?=
 =?utf-8?Q?lCud1dcyPdeDnw39BRlj9evD3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5be840-eb5e-479c-6a4a-08dc9172a463
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 21:47:55.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSyUU9bSuyG0Lh5r9n5y5KB+Gr0WX5TncAJfOKC3AHKxY6hwmOjS969rIqw0sGCs8Ls4jlSz+wn66BmKa8+9XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960



On 6/20/2024 3:58 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Currently, the ionic_run_xdp() doesn't handle multi-buffer packets
> properly for XDP_TX and XDP_REDIRECT.
> When a jumbo frame is received, the ionic_run_xdp() first makes xdp
> frame with all necessary pages in the rx descriptor.
> And if the action is either XDP_TX or XDP_REDIRECT, it should unmap
> dma-mapping and reset page pointer to NULL for all pages, not only the
> first page.
> But it doesn't for SG pages. So, SG pages unexpectedly will be reused.
> It eventually causes kernel panic.
> 
> Oops: general protection fault, probably for non-canonical address 0x504f4e4dbebc64ff: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.10.0-rc3+ #25
> RIP: 0010:xdp_return_frame+0x42/0x90
> Code: 01 75 12 5b 4c 89 e6 5d 31 c9 41 5c 31 d2 41 5d e9 73 fd ff ff 44 8b 6b 20 0f b7 43 0a 49 81 ed 68 01 00 00 49 29 c5 49 01 fd <41> 80 7d0
> RSP: 0018:ffff99d00122ce08 EFLAGS: 00010202
> RAX: 0000000000005453 RBX: ffff8d325f904000 RCX: 0000000000000001
> RDX: 00000000670e1000 RSI: 000000011f90d000 RDI: 504f4e4d4c4b4a49
> RBP: ffff99d003907740 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000011f90d000 R11: 0000000000000000 R12: ffff8d325f904010
> R13: 504f4e4dbebc64fd R14: ffff8d3242b070c8 R15: ffff99d0039077c0
> FS:  0000000000000000(0000) GS:ffff8d399f780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f41f6c85e38 CR3: 000000037ac30000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
>   <IRQ>
>   ? die_addr+0x33/0x90
>   ? exc_general_protection+0x251/0x2f0
>   ? asm_exc_general_protection+0x22/0x30
>   ? xdp_return_frame+0x42/0x90
>   ionic_tx_clean+0x211/0x280 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
>   ionic_tx_cq_service+0xd3/0x210 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
>   ionic_txrx_napi+0x41/0x1b0 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
>   __napi_poll.constprop.0+0x29/0x1b0
>   net_rx_action+0x2c4/0x350
>   handle_softirqs+0xf4/0x320
>   irq_exit_rcu+0x78/0xa0
>   common_interrupt+0x77/0x90
> 
> Fixes: 5377805dc1c0 ("ionic: implement xdp frags support")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>   - Use ionic_xdp_rx_put_bufs() instead of open code.
> 
>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 ++++++++++++-------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2427610f4306..aed7d9cbce03 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -480,6 +480,20 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
>          return nxmit;
>   }
> 
> +static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
> +                                 struct ionic_buf_info *buf_info,
> +                                 int nbufs)
> +{
> +       int i;
> +
> +       for (i = 0; i < nbufs; i++) {
> +               dma_unmap_page(q->dev, buf_info->dma_addr,
> +                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> +               buf_info->page = NULL;
> +               buf_info++;
> +       }
> +}
> +
>   static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                            struct net_device *netdev,
>                            struct bpf_prog *xdp_prog,
> @@ -493,6 +507,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>          struct netdev_queue *nq;
>          struct xdp_frame *xdpf;
>          int remain_len;
> +       int nbufs = 1;
>          int frag_len;
>          int err = 0;
> 
> @@ -542,6 +557,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          if (page_is_pfmemalloc(bi->page))
>                                  xdp_buff_set_frag_pfmemalloc(&xdp_buf);
>                  } while (remain_len > 0);
> +               nbufs += sinfo->nr_frags;
>          }
> 
>          xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
> @@ -574,9 +590,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          goto out_xdp_abort;
>                  }
> 
> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -
>                  err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
>                                             buf_info->page,
>                                             buf_info->page_offset,
> @@ -586,23 +599,19 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
>                          goto out_xdp_abort;
>                  }
> -               buf_info->page = NULL;
> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
>                  stats->xdp_tx++;
> 
>                  /* the Tx completion will free the buffers */
>                  break;
> 
>          case XDP_REDIRECT:
> -               /* unmap the pages before handing them to a different device */
> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -
>                  err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
>                  if (err) {
>                          netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
>                          goto out_xdp_abort;
>                  }
> -               buf_info->page = NULL;
> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
>                  rxq->xdp_flush = true;
>                  stats->xdp_redirect++;
>                  break;

I think we can live with that.  Thanks  -sln

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>



> --
> 2.34.1
> 

