Return-Path: <netdev+bounces-174682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2EA5FD8B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64A417A659
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4C6F2F2;
	Thu, 13 Mar 2025 17:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022139.outbound.protection.outlook.com [40.107.161.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619B125B9
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.161.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886316; cv=fail; b=sUZspxp/iTP8m2lZ+iRoveK6OepkHJwhQoSQWznmhQdLAUqykqDXSFRJO0HF7q50/jVsv2/gsnBqvp+CeD+ejLx1SBJ+r8kTQgLFFeXJ1EynFU918YcDDo7ybZdnHXo3DlBVedjRoqwfHamFA9DnyhCw4KU5C9Fi673XfGjcWmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886316; c=relaxed/simple;
	bh=06rA8Azvyhhs5wTCfKNSDmmIrw5yetI9ejKIynuE8xE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pFG4TgB/fPUn9/R3yCZesevV6ifocjMgUqvJR/u20/ijsLGiBRtXllQyy7Bvdtm7OYpCuDmEtb6GzsNQPBORe4NED0jVPztT5bBO0FQqNS+8GArD08/erD7fc8FWfFA6d5a9fd6igXSmKfN2L3LuxfUBOrOznS7aIRlJJQNrtpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=randorisec.fr; spf=pass smtp.mailfrom=randorisec.fr; arc=fail smtp.client-ip=40.107.161.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=randorisec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=randorisec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOfCWnnLbZYUmRYsE2Fr0fD+SDjcGaYdAM3w/7i6qEle9TD+VF5bnBYELM1vgsCOh3Xl7etcnrd+XrNpWimN9mSfYYJ2a1SXt3e6QLc9RS4B6DtY4ucuP+EPJceMnrYlIzVQldwmMac280Mht6d+kgm5RcIHq5p/ZCgLDCqqUxqkCDrJQ3dRxwlIuypWSQ82SXuA/EBGaeuJw6AkYInCv/j35dnmSaJmsEFtQl8M03vjs43o6gFSxuMEFWW34V3EI9w1L2N5bfUNQW0TXm0E0Jd5LhWHs3/mBZbWO8Y63ZBg1bTvic1EZsVyqrKYXK8e2rOMsj34wkZTry56mzVykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DioUVHJjvSGjiLPdLfhkhUPtmrbZpTJh8MfaYVMbZD8=;
 b=YoeIKwp1wtxpxdDIJnRX9c/+krs+SAmqK/cjVvNQDOxX8zvD0n8YHogFH+cuD5w6js0q47//PkL20HUd01WdH/FWyVcHyw5IL5mEvbDqy3mZwtjuf1d43KAxJzHoR5Wd7Pd1UzHlbGO4jxgunjyPiiG5YkyaWHK01X9xObcVJmFzHPTNNl1CkhwbtfNbZ0NUye+OE8293sbRo3F+fLAuC8ynpUzauqrQbWw+DRyX4ia5jqCHhJ8RfFrZULCZJcEPgnFyKLq7uhZl3gGtsbWbNIxymyFxs6FhHSUyx15q+CTvzVcYfSIQcIDXwTc8HoTEzajgzBnYiGCL8XwI2fVwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=randorisec.fr; dmarc=pass action=none
 header.from=randorisec.fr; dkim=pass header.d=randorisec.fr; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=randorisec.fr;
Received: from MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:16::23)
 by PARP264MB5644.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 17:18:31 +0000
Received: from MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d6fd:76c4:7058:d7a2]) by MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d6fd:76c4:7058:d7a2%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:18:30 +0000
Message-ID: <91657d20-3a3e-495a-a725-6724ecf6ac65@randorisec.fr>
Date: Thu, 13 Mar 2025 18:18:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: Fix data stream corruption in the address
 announcement
To: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>,
 horms@kernel.org, mptcp@lists.linux.dev, hanguelkov@randorisec.fr,
 Davy Douhine <davy@randorisec.fr>
References: <81b2a80e-2a25-4a5f-b235-07a68662aa98@randorisec.fr>
 <2f11274e-de22-4291-9172-4ad96d215a41@kernel.org>
Content-Language: en-US
From: Arthur Mongodin <amongodin@randorisec.fr>
In-Reply-To: <2f11274e-de22-4291-9172-4ad96d215a41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0288.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::14) To MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:16::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRXP264MB0246:EE_|PARP264MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc22a1a-6105-47e5-b31f-08dd6253138e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3YzK2tPMmNOWlJtVkRIb2dtSHlhY1JnYndkaDhNZzY0UHl1S2VJcFRRRlc0?=
 =?utf-8?B?cFR1TkdSakxQRzhBMlNNQ000Q0hOcVczMGwxbDlnQzd4bGJXbEdEbDE5N1Fn?=
 =?utf-8?B?K2w2b1ZtbDR4ZEZZVngwaEtKWFJuWXM2Wmt1T3B1S1BockxiUjc2U3Y4UzRF?=
 =?utf-8?B?KzhpaWN5LzJKV2VJZlpuMzVYLzg2SlV2MEZUaFFjb3B1eVY1QXhqRFp5WDZt?=
 =?utf-8?B?T0VXMytxYWdVWktrd0lIcVR6OStMbWxoSS9JOC9aTlFEdGp3UU9ZQWpKcS84?=
 =?utf-8?B?VWtlYXlKeDNWU0R3bEQ4bWdCOGk2N25sUUE0TXdPdXlpR05ZOHhRMXlHZ0ZW?=
 =?utf-8?B?U0p5cHhDMzNDa2Y4T2QyMmFyRWV6YUJiWEZra0tybDRXeG0xTklFY1l6am9Y?=
 =?utf-8?B?RlVyY1lOUnN2VnF6clhJSm4xTUlDWEQ3NGVqNTdDanZGdzR0eE9DM3pTM1ZN?=
 =?utf-8?B?ejJZdnlZdVNYaGpRM2p4L0lWdkdpbkFBOFFaMmRzVVpXbDZHc3FIdklRZGxp?=
 =?utf-8?B?T0RsT1lyWU44cUxUOVhPazBzS0dXVFlCREpXMmpWN3JteSs5ZmdFbU9IR0VS?=
 =?utf-8?B?UnZGR0NXQzdnVkU5aXpOUW55VURKV0p4QUlhRXUzYnlKaDk0NW5JOTVydE1R?=
 =?utf-8?B?c3RuZklBc0xZSHpZcElqYytIUHlRbXR6SWJGNlRhRTBjenlyeHdiRjd3MnIz?=
 =?utf-8?B?SVVBeGNMOTB0bmxXQ3h6OXphNTZoZVN4cUxsenlybmtoTzlncDRROGFlSXd6?=
 =?utf-8?B?MHZLRml0SXFCK3dEQ2dQRGJXczFENWs3b2JmeE9lYmFRVEo4TVVqaXVFd0JM?=
 =?utf-8?B?TE9yb0YvRSt3Y1I0WnRqWlFaQ2hIT05vMFVDMlM5blZqV2RXYU8rd3E4UEVM?=
 =?utf-8?B?c0RYM2VhVmI2UERaMUZ1Z1IwWXloRFBnaWppc0RaMGdMaFY4S2tkZGExRTNS?=
 =?utf-8?B?WVZrQkdmT0pIcXJtb2Zra1dJMFFVTVhOMllDRDNTWnk4bmhOYlZxN2M5ZndT?=
 =?utf-8?B?QVhDNE5pdXpaS1JMYXI5L0hpVnpoT25EZlRVMmFRQWVZMlU1dUZaODFjME5T?=
 =?utf-8?B?ZTEwUjhiU2d2c0NDRWhZeExJWlZSUHBBVnk4UEZjYUN3UGF0VDVObGR0RWxU?=
 =?utf-8?B?M1RsRTNPYnpjNmFpeklFTU9GR25XazF0aXErMUFMWGs4TDczUjcxenhHS1dq?=
 =?utf-8?B?NG5SaXJZdmFCM1VXdkdCR0NzTGNXZDIreUxLY24vNjA3Y2wxdFh6UGlpNkhP?=
 =?utf-8?B?c0VmaUsrZW1nUWRTdmRYS25ScmhhcW43c0lIcmpvak44Ungxb05MY2lrS2Jk?=
 =?utf-8?B?SnM4T3dRSHFOVllmaTVSUHdJajlNOXVueDdST3NSZ1hOTUFDUk5mVElqU3RC?=
 =?utf-8?B?UnJBTFpYY2xHdHhIUkg4clhiN0xhR0dDSWEzQ2wrZjJiNjl1WUpQZ2xleWs3?=
 =?utf-8?B?WURsMGhqTS9jR2FtNW9pQkRURXdDakRwR2lZZ08ramlKclRUK3hBOEd6b0tG?=
 =?utf-8?B?OGlYejlZUUd4eXNKNjNuUmZCUi9ZUERVOVhpTW14QS9jb21ZQkx6V3lqRmV4?=
 =?utf-8?B?ZkFKNHcxQ0UzVW1vdlV5cGIvWUV2bTBWblRiQjV1YSt5NVFjNXg5RUFDS1Ev?=
 =?utf-8?B?NmNUWWkvd1VVTUtHUmxCbm82VjF3czJsVityb1c2ckJPTU1uSTRPajJKTElY?=
 =?utf-8?B?Y25hVVgvRTlZUGJSSWFpNUJoZ0RlOXdabWVEMGZqdWxueVFMOXYxenAwV0lz?=
 =?utf-8?B?NnlDTXl3RTRaditXcTVxNTZXUFM0NFJyWWRoQ3NTME9mUEdqSkFXNUxxTVY4?=
 =?utf-8?B?cW9GY28xWVRENklVRzcvR1lGR2hzUVIrK0Y5eTJaU2lLbEhVSnRZVzRIY2Y1?=
 =?utf-8?Q?sLjTW4vknGX/+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFRML2w4YzBKYmdDcHFLa2FZNnJIV3pESXNPdEJUZGd6aUV4cmdMbWdLNTdl?=
 =?utf-8?B?ZXNBRjB0aTlyV0xqdzFicHF4RXFxQXpubnlJbnpZODdoSFRpaktmeVBZUHFk?=
 =?utf-8?B?aHFoTTZMUWY1bVpYdERYaGVFMXJkd05MVUxiMDZKNXhvOUZQNDZYQlgvYXF2?=
 =?utf-8?B?Q2ZYRWoyQUNKYVc3S3pMYUNyNHlUQ2pLOXBRUnUyaXNJZmo0aXgwYWd1cjhS?=
 =?utf-8?B?cEtYWHpNNUxYZ3JiclhVd3Q3TXNnVmpnQS9qTG9aK0lpV2VpUGUxa0ltTm9W?=
 =?utf-8?B?dmZLSWtqVmNYTzh6Qmh4WVdhaGpVMjBJMkRFYWtHZkdZNEF5eGRha1NEallH?=
 =?utf-8?B?UjhrUC9tRDA0S0wzUWV0RFFVeUxhNk5qb214UUlVOXlKeXBiYmV2VllFTmMx?=
 =?utf-8?B?SElBZllRbVJsbnIwRGRoUjlLT1pNNzZTRThVWXJTaGhoalNCOGk5RW1zeXUr?=
 =?utf-8?B?Um02akw0R2dmUFBBVXRub2p1dW01enNqNE9Hcmh3WkpEa0lJYUZxeEtxMjdQ?=
 =?utf-8?B?RGpKVHRxTVgvQnJnSkZTZTVtRVpKajhyTWdQb0ZtZGNseEo4em9mNml0YllL?=
 =?utf-8?B?bGVXSENhVjlFTmJQRzdOZVgxWm1uNmFacll0UUhnNW5UV1U4djl5OTkzanY4?=
 =?utf-8?B?NnllKzUzRWJZQmU0bjVyTzdWOXgrNndrUzRNekdwck4ySGMzQU9qZlJQZU03?=
 =?utf-8?B?WEdoODFoV21vWFp6bTN4QzlmVmNkSXZqZnF5N1IvaGtFcDRjTjJvaFdoYzZW?=
 =?utf-8?B?L2FGVDErTnFudldkZXNzWEx5Vkk5ejlSdU9xc0ZkMWw2MDQ4Z1cvRzJmcUJ2?=
 =?utf-8?B?U0hHRytRcHVoZ1MwVHdoc0xuVkk0c0d0cWd2WHVyTTZqem1PbklFVmhBYVJ4?=
 =?utf-8?B?NDBMR2dFY09hTmxCeWRHYnhjV05CK1AxMFY3cjZBRitBSER2bUp0STYxczcz?=
 =?utf-8?B?aHgrMFYrMVZQallYcG9SUGVEekZiZk5oN0FSZ1poVkFQTTkvUVFZeXozWDE2?=
 =?utf-8?B?SnBEektKd015SlpBTzZDMVE1dkFtV1Fid01sMGl1UjM1N1d2amk4SmlCWVYx?=
 =?utf-8?B?aUh6TEhFRG9pK285SmZJVkdVTnFkYW51clJLeGhpUGNLR05JaloxZC90a0Yr?=
 =?utf-8?B?dFFGS1ZhbkVCNmhSZDlidVlIeWlhc0NxR0lsd01pTjRzOTZISEppaTRudkJ4?=
 =?utf-8?B?bEdsVUpDVlJoSnhTWGpmd3dFUS8vdG5COXpHWWdYaUtweU5wUEdIckhUTDB5?=
 =?utf-8?B?a3dXQm11M2phUmlQdmsxdjRkVXNFNlUzQStVdmNHLzkwa2t6eXRObE5Edm1r?=
 =?utf-8?B?WDhFcDA5Ny9hTVNnT3R4Y25tcHREekhVdm9oR2JOeHo5VDNWYWJJL01ac0hl?=
 =?utf-8?B?R2lFYW9CazU3ME1Wc2VKam1tRVo1YVpvc0NOVlBUbVhQaDVncExWM0xxb3Z1?=
 =?utf-8?B?UDNqcGcxaXk4dHp4THg3RzMwcE5DcGNPcHFqejdMWnVHbHpvSHQ5VlRrMUZ2?=
 =?utf-8?B?NWluNjloVE5xbGZqRHhUd1lmbDRvdW13dEh3SDI2RndCem53TzVlMVVIV3BZ?=
 =?utf-8?B?Z1RHMGFYbWh6VWlFU04vek9aLzIwb09paDAwRCtPUU1qeXVpZHgxQzh4Y1I1?=
 =?utf-8?B?UHBqOTVRTlFGelg4amQ0N2k5STFXMmJFQnRsNVdobmYxQWJCUzA1L3NtS1Ex?=
 =?utf-8?B?a09NZzBzYnVFM1lkVmowSW9vNzM0ZHRtUXlZaTdpOXo2Q3pUdW9rYlliRkxK?=
 =?utf-8?B?cVo4bnZCL2tXWlNMQTE0d2RheW9tUUZRbmphRnhRdWxlMWY2VU10cU9yeSti?=
 =?utf-8?B?VmhmZ252RUVaVHRBcE1mYjBPWlg4N0pDZENQWU1tdHpjZFo3OVRYZFVZQ2FT?=
 =?utf-8?B?M0VHSjJXOWk1Wk5DRHdwbENDL3JFQVBndXA1bG5kb1ZUeVZpT0cwNmxGVm5W?=
 =?utf-8?B?QW1EcmoxejFZdHV6Wjd2eXM5eTJxMTJpRVp5VDJlNTU1djMxOVFzWitDb3p1?=
 =?utf-8?B?eDVZQXpFRVJYbDVOUmNlT1UzRFpldnhkbFl5SjVOYm5aTE1Qb3lrTlZOdGs3?=
 =?utf-8?B?dGgyL293cmI5M3NSNUxYYUdBRHRkMjdpTHZvMXlmdjZ2a2FCRVUxTTVvQVl6?=
 =?utf-8?Q?ryexgvrqneQLja0OmcPxGHK4a?=
X-OriginatorOrg: randorisec.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc22a1a-6105-47e5-b31f-08dd6253138e
X-MS-Exchange-CrossTenant-AuthSource: MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:18:30.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c1031ca0-4b69-4e1b-9ecb-9b3dcf99bc61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLlANx2lSEfN2/0MBjcN+IeE5NAUndTxiB1tDt2GSqcQNGh8/SUa/EW1Wqik34Qj1q7IBFDNA/tCyKHKfcAu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5644

Hi Matthieu,

On 3/13/25 18:10, Matthieu Baerts wrote:
> On 13/03/2025 17:26, Arthur Mongodin wrote:
>> The DSS and ADD_ADDR options should be exclusive and not send together.
>> The call to the mptcp_pm_add_addr_signal() function in the
>> mptcp_established_options_add_addr() function could modify opts->addr, thus also opts->ext_copy as they belong to distinguish entries of the same union field in mptcp_out_options. If the DSS option should not be dropped, the check if the DSS option has been previously established and thus if we should not establish the ADD_ADDR option is done after opts->addr (thus opts->ext_copy) has been modified.
> 
> It looks like you forgot to wrap this long line. I guess checkpatch.pl
> should have complained. (Tip: 'b4' is a good handy tool to send patches)

Sorry, I did a last minute change and I forgot to rerun
checkpatch.pl.

> Also, it is a bit difficult to understand this line. If that's OK, I can
> update this when applying this patch to our MPTCP tree first. I will
> send it back to netdev later on.

It's OK with me.

Regards,

Arthur Mongodin
Security researcher at Randorisec

