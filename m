Return-Path: <netdev+bounces-254598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJh/Gx4Qe2nqAwIAu9opvQ
	(envelope-from <netdev+bounces-254598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:45:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87682ACE4C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9366F300469E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13637A48B;
	Thu, 29 Jan 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CflkoTLX"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E524A374186;
	Thu, 29 Jan 2026 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672727; cv=fail; b=LH8tgY61d54J+v8sGlUkkZt+LiGkM8xvbazUuryvLrLFbHZ9E9rCr7MBMJcmYT9gnCymPK1yUmfnyYYyo+WwrGi2sJUYJ0lmWpc4AHN0lzKNBi+VCUJt5tYze+Ep3yR/oPwosQdmCrxYh/n/vIsViUVuq+rcWYHRGGWlhlA2OCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672727; c=relaxed/simple;
	bh=4MBP4hWG7QPHhwzds6jYsbAJNofG0bOgAfnhwAEPPbI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=At8JBfPInzBy4XLsoyGp7qnWsx3OF24rb+hCXq9gudHUbtLMPeBtgqVCo3liEufyCSGvdV4WOMo3oegHZbhKVrBIcqmiMQJnN30p0FoqYbXN/L8M7rdov95WyDpFdqdVdRG98wNsoQ94CQdgOpY/EZFSxJZ1n5jJWETifekBcBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CflkoTLX; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy5NKRThaR+H8VZSgjwdI3sCLnsdFbtTydu/PJlCN8eDODM5sd6m/NSdB4m+ToDqOtLgT2l7lWcLWt3nNYw76Qhl0+KoDgRdu1y4E885N04FOT2CIhScLTq+XUCZwtQONds2yv1jQD7J2jS7op0lbJaqjpGpkBBVRLjsagJgUWM6eYNs3fVyjjxUrDUWbNsMgu3jXN/j/q5aOo4OclOIV6JkK3ArPZ/45u44aSuvmJPR53GFVCphPwLJrbWxSyubaSXSKq3BZxkYUan6Q90XX059tpR1VBiPIX4mpwlhPmbjsyuNZGmL6RwO1oTFwOHS/fvzWFaL5eZxuXE3J+tBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1yIJV/ZB6OMbSQWcH+8MH/ppcJwi2aRJ5c5DqwGV80=;
 b=hGPfcYzLi9MIfcu09mZXPd8TWVe6yKrKZ5bg9vkKlPF+9S0zR5galjPzO4lv2iAPIANRujqraJrr6839I2vilhLX36McmIH9LFzDzg/7mNjj604zeqHCLnwGPw3fCmDAL2l2/VnKs0+wCiCJCDDQZqa8byWldw9Gp4Bt5aubFJd3XB9xx6Z66ktfkiB4nVVgLhtsG04wOcQ9/P9RMnzs198iM+AXdlBP5j7VJ6ybmbg6n9PMcDPtUyVeclMfUcdgmJzXXYEvgKIxhjB85pfZY3NjucwvqM2R/nEYsghGDqUkebtA/9Rx/t5NdwVLury02Q+RFYSajrOpLdW8criLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1yIJV/ZB6OMbSQWcH+8MH/ppcJwi2aRJ5c5DqwGV80=;
 b=CflkoTLXyTak+gUqWqqmFJOEjkMuikcP2vPIjzVFCvhnLmBbVQunKm3keyJTv9GyP4KHTUYUKJtMjIqtdYM0WnMzey2oTcrCW4xaPZJ0xmvGI87v09W0UD82EC0XP0JXF+n95vQoDVC1EIy9VQou7Pc73SSFKRMSHaL1ldnYRG0G4p0OVV4p4GhRgs7UULQifBoJoJJllwKQIkdqxnR17IyisHcivp9O5WuRuCH7louV6/ZxTzPIxL4XXvk1KwN42sQJ0MsrAK2K338P7bD+JDZE6vOintW3Ob5ufr1WVWvy/TFVMasOEeLasChF0ViM5VMdMqpOs+Lllst07Jv9Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 07:45:18 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 07:45:18 +0000
Message-ID: <9dfdd7ce-ad1c-4845-95ee-d8ac5b5802e7@nvidia.com>
Date: Thu, 29 Jan 2026 09:45:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: don't touch dev->stats in BPF redirect paths
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com, bpf@vger.kernel.org
References: <20260128161030.39870-1-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260128161030.39870-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c0ddc7-e8bd-4c11-f768-08de5f0a5904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkJSUExhWFBHcUg2WlphaVA3c1lIVi9OeTU0b09JZ3NrTjFrYm9BUHlDZHJ1?=
 =?utf-8?B?Sm1JVlpRcHRWd3dNOHYrYXg1VC93bG1OaDMwVHp2blUvcEZldGFETEpYYjhk?=
 =?utf-8?B?S0xqakNFYnh5L0pXM0VpQU5VR1E3Rk4xcWY5N0lYT0NnZ2lkQVpZSVBaZ3pF?=
 =?utf-8?B?cU5kZmVXaEZmeDVCb3U3eWhST3ZQZXl2MHM0cnc3MVJhbEx6K2FYQ1NlZHBX?=
 =?utf-8?B?Q21KbEpmY2JodEtTUEhjWXM0bXVYczZsaDJjWVY3Vk5kT3ljVWJIcmVhYitL?=
 =?utf-8?B?ZGEvVTFabW16eVNRM0VtcTZsMFdXek8wMXlPVFpXcUcyTEtDb3N3OW5EaHhY?=
 =?utf-8?B?aTA3UG90NzgrYzlKZ0FsemlvcncyVGlVS2hzRHBpUU0vWkxhQlQ4SXh3czI5?=
 =?utf-8?B?UFdlOFVITEdReHVzRmpFWTFVQ2xNeXF2cjdDUVhaTTRzWERjU2E4OHNNb1h5?=
 =?utf-8?B?Mml0NjNmL0FsOTdOVTZwZCtLb2dIMzk5QzU1WmRzM0MyV2ljc1AvNFVTMVhi?=
 =?utf-8?B?aTE1VEFvbnh3R2hETjZBTWhHRG5wYzd2aUgzWWNRTFp4Tm5acm5BcTM1eFdM?=
 =?utf-8?B?V1ZNRXV1MisrV1lKRXg1bEovc2UrMmthNXlBRy9JelFhY2lHU2pXR0tQOEgv?=
 =?utf-8?B?T1JWYzdKOHdxbnkxQklPdytsQnNnZ0pJYW1oRmpMTjVtZ084Z2RtVTdIMGhF?=
 =?utf-8?B?UWdWeTdHRStsbjhJQnYrSk1KN3J1VGxMZWtyT3pBa1ZyUSthNEN4MkVaOXFx?=
 =?utf-8?B?ek9RNTFzcUhhbzdhSmNYbWJLMklYNE15UlBKN1FJQmdkeW5sRGIxK0hvVXd5?=
 =?utf-8?B?dlBFazVSemJBRTc0SHN3L3kvU2dVNU14WGNGUmVWWU94WTVnMDIyYUlxNHNR?=
 =?utf-8?B?eDU1b1lsSTRVY0dEYms3MCtRZkg4M2hvZmtUemJpWDVzcGl0MXNVU0pEZEMy?=
 =?utf-8?B?dlBaV2RiQmN1VVJWTmdnbzlSUXVUMWdnWEF6Q2ZzeTVrL1dGRnB0bUJlekE4?=
 =?utf-8?B?L2JvVXh3Z3JCWlREZGc5anp4bDcwQnVvVFIzT3hTK2c0cVRkWGxkWW9jRk1L?=
 =?utf-8?B?T1dZcCtZUkVkWVdtSGlEWS9oYUVRcU5wWjRCMnErZ1hRRmUyUVZBQVQ4MHMx?=
 =?utf-8?B?UVhoR3ZhQmh1cm1wMVNXV2l4cHFac1RVRFJDS05VTGdGeTRUM3FpdGI5K0x5?=
 =?utf-8?B?dG1hMmVNTlRSZW9SanhnVFk4VE9tYjlidFg0NkxyTGJPUDB5QUN3WThpR2Fq?=
 =?utf-8?B?N1dHa3M1aCtUVjZObkF3cjhBbFMrcWw2YjNWWjEvM0hiV3M3OEJ3SUIzTHNh?=
 =?utf-8?B?ZGxUSDRmekR1M012UnVONjhpMWJETS9SczZJUlBkanZhTUI2QUNtVnIrODBz?=
 =?utf-8?B?d3J6TXUxU1RlK0Rqa2lubXdaUUoyR0R0clVKRkYzb3NGRW1yVlYva3MwQzVk?=
 =?utf-8?B?bFlpM2JTMTJvcDBYNTVrQlZGVGwrbGlyMHZBMkdjM0ZjcVJwdUdlT3VkeGRI?=
 =?utf-8?B?RmNnQUpHSHArZDNsUUJwR0RpRUFreVdKSkd0N29Hb3FUeWJiNzcxSmRtbEpD?=
 =?utf-8?B?L2liQ2UzKzNPK3lSN3ZWcVNsMXNjRFY0VW9ONE12WFNHSTJtNEFPV1BCNXlk?=
 =?utf-8?B?bGxCNTRPbytFbDRwSmt5R09od2IxQkhIMnBldEZ2cllyTnFuQ1hMeE5wcjRj?=
 =?utf-8?B?TXlPZGwraGNtKzNOdHZ1Ty9GSUJZNEpNRExKRTd2UnduM3h0TzRLZ080UllE?=
 =?utf-8?B?MTFNd0d2eW9BUytxK1NqTnpwdWdsSTNZd1A0d2tnUjk4a0JWL3J1OU9aMFgz?=
 =?utf-8?B?ZHd3SXFDK2FPT3hFZFowM090S0hyNGFzd1A2UFl5eHBUajhaR09nQ1ZQV1U3?=
 =?utf-8?B?dDNaVkRESnI2WENGUEp5YlJWVHBZaGp2cWh3d0xldm9CMzlSNzVZd3JSNW51?=
 =?utf-8?B?TndCTHBCZkVYWFloQSt3WVE1T3NwSWlBWnU3bGVtUzBZUjduUXJmNWZRMWVP?=
 =?utf-8?B?YmhVdzBFSkR1Y1Fqa2tDVTZEOUp5NmtRM0NiYVU5b1BCcTdKYmRpMlFNNmhw?=
 =?utf-8?B?UlcxMGlhQVZYSW9nejVwZjEwMmtBY1d2TU5kQ01ybitLaUFLODFxYXJRL09r?=
 =?utf-8?Q?L87E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STNiUmhEdFpvMVBwZ2xjQWpnOHJpVGpFWFNsRTlJQlJwSVh0VEt5UVFMZVlh?=
 =?utf-8?B?SC9leEcyd0VIVW41Z0VuZmtTYU5DSHhWTnBaeWxJTTN5eCtNL0djTGRrbTN2?=
 =?utf-8?B?dzFtcU5PMkNoOFBHaU05QXI2TUJHVk1jZENFUUptaVl4anN1U2gydGN1MVlS?=
 =?utf-8?B?QTdGZnZoRFJZOFFlRlBnS3NNNXhzdVpab01Yc3hPaFFpZU1JTldKeDBOMkZ3?=
 =?utf-8?B?R05ibW05bHVLRXlJSlphWTNNRHVMR1pWUVA0UDREaUlpMGRwd0NXNjdjcERF?=
 =?utf-8?B?TWE0QVlWb2FhRlJKMkJZYXZWdnJmNnZIVjRGQnYzMDQyV1dXYjcvY3dONmJ0?=
 =?utf-8?B?UWVzK29hUTNvQVFDekQzQWpvUFd4RFV5enhkMW9qcDRjWlFhRHRHTVFQRmg5?=
 =?utf-8?B?MXVtcDdWWmo3UkRFTTRvbmlQZjVvcitZaUMyUkcwMm0xaHBRZmxxSVhBOUpS?=
 =?utf-8?B?bm96OG1OQkFYTFViaW9MSUY3SGtGVFZPK0JvVHdDYzJZeFJPS0VLOGE5SWFT?=
 =?utf-8?B?QnZ6amp5Znlxa2xGY01OVzFDL2R3ZUFrMG9MYVh5RUtvUUd2MFpxV25NRk5s?=
 =?utf-8?B?Sm1BSHdvRzJmZlJSK25jc25pL2dRYlRnUTVTZHdja0dyQUZCQUlIemJJTmh6?=
 =?utf-8?B?TzhSclZqYkVVQXU4Mlo3V2U0K2MvWnhRUFdHUWVIR2xWNHphRUtDUEJ0OXFz?=
 =?utf-8?B?U1NFTEFkUUUzM0g1RkF3aUdCN29aQmt0UWNMdUIrLytrTkhYdnE1SEtDczRR?=
 =?utf-8?B?N1crWXdFdXk0N3ZnZk8xOFNLYVZDR3REd3J1ZmxQNmw5ZExZYnBjcmMvMTBX?=
 =?utf-8?B?WFVsVnRJU2IvMUptSDByR0x5b2ZYeFd6aHJndVQ1ZGRNT2N2SjdFUGZUWSs3?=
 =?utf-8?B?WnZEemxvNnVNOFhTUXRuRWcyWFRESUt6aE5NOVpjeGJCb0xBRENwS2RVM2FZ?=
 =?utf-8?B?T2FEaXNJT1ZseHJ2WTJSSmtJWGpwanJNREJ4cnNXS2VkMVZKTFN1NkhlNlhj?=
 =?utf-8?B?VE1XR1JjbGRPcHVzb2NXY25tV3Qya01ZQXoyWDZVNy9zTWNSOHB3NVNNSVlL?=
 =?utf-8?B?V1BIUUZpeUsrcjhvMkRsMlpGclhIaHlzeDJsc2FMRnV0OGdYeGdXalhMbDVa?=
 =?utf-8?B?VDVkWDBHNStEVnEyY2xMY3pEd0p3elpCcC9zNyswRUpPNEZrZkJhcG1IVjVM?=
 =?utf-8?B?ZnVxbnNqYWVwQk9CeHU0NDVMeVpjYUN1K2FVYzhPZHlOZWh1WU1SU1BPY0FG?=
 =?utf-8?B?Nm83bnVrYlRlWGsxZU1LME5sV1BFRGl3c1UxVHNiRjBtcWtqNzNoUHZXRlZv?=
 =?utf-8?B?WFRFVUplY0NubGFQRHNFSmljRmVXZVQ2Rno2NUU1WUcvOGdDWnlGTHYwRVIz?=
 =?utf-8?B?NmptSktQWStrQjJKM0hsTk5TRXFVZVIvSzgzY2orSUJTUGp0d1d5REZnOElM?=
 =?utf-8?B?aTdHVG01U2g2aFVrMnJUMEI3c1UzUVVtd2lmOXMvcTlxU2pJZndPNDBEYjdM?=
 =?utf-8?B?RFdZM3QxNk4xOGlDVC9Pc2dYYWU2b1BzTEVQVGErSGJ1YWNzbDJhYjVXdzc2?=
 =?utf-8?B?dlVDa051R0d6QTdlKzVsY1U2bkZIMmN1K2pUU1FSM0daL3JpdmFUaXh0bXlQ?=
 =?utf-8?B?ZE9qRFBKSi9kMUovNHcraVRSRXpidEFKV3JaeUR6bWlNdHF4QWs1c2JZUnVW?=
 =?utf-8?B?WlcrVk1GQmxMUXppdDlBOVE4djgvRXhCc0JDbW1TamJqTzI3REV6VHB6WE5U?=
 =?utf-8?B?a2VSTndrd09vcGtJQnpSWkxYQlU2TUVjU2RTQUxRbFVDSFI2ZjJTME5ZQzlR?=
 =?utf-8?B?dDVkaDJBU0Nzb3NLZW0xeDF4Ujd5Q2JTb3ZScFlHUVNiR1hEZU51WkZZNzQ5?=
 =?utf-8?B?QVkrWDZ5dWdialBDNUgvVk01VkFCMXVPdXpvSzUzNjk5aEFzVmZxN29XcFYw?=
 =?utf-8?B?bVQreUxMN0VJZUNKUDdyVUFyT2lsY2xNbXl3Zk9PUTdidTMyK3Y1Qm42MGNi?=
 =?utf-8?B?YkZsTS85aHVOZG9CeU9OSGNzaDJFZitkQllhbXpYRXJHMFFNMjJIQk5zdWZB?=
 =?utf-8?B?KzVycXBzWU1tQVJiR3V2bHNqWk1uYXpKVDloWmthTldUMFQ5bHRiZXZ6Qklm?=
 =?utf-8?B?N3VzS09JV09hK1Fwb3dvaDVuRDh6bVpqYUFXZDVyOWlUUW82Mzk5K3lPWDls?=
 =?utf-8?B?MzhBbmdXRzgwaE94T0xoWmtFK29SNmVqZ0gzN28wcWdZYjN5YnVhYm85UWhy?=
 =?utf-8?B?RmhQUDNlaGlQRm9Gall2R204VGc3bkkzV1VUU3d3UkdOUE9CeGltZFhvWi8r?=
 =?utf-8?Q?B4hyj9TjgPIvXD68+T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c0ddc7-e8bd-4c11-f768-08de5f0a5904
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 07:45:18.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1xlX60GBSDcQjCbc8gBJOSY8mYtE0s1elR2ZV2GjVoIzjAfBH6pA6wlqKMJPCI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254598-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 87682ACE4C
X-Rspamd-Action: no action

On 28/01/2026 18:10, Jakub Kicinski wrote:
> Gal reports that BPF redirect increments dev->stats.tx_errors
> on failure. This is not correct, most modern drivers completely
> ignore dev->stats so these drops will be invisible to the user.
> Core code should use the dedicated core stats which are folded
> into device stats in dev_get_stats().
> 
> Reported-by: Gal Pressman <gal@nvidia.com>
> Link: https://lore.kernel.org/c5df3b60-246a-4030-9c9a-0a35cd1ca924@nvidia.com
> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Aha, this kinda makes my mlx5 fix redundant.
I'm debating whether I should send a revert?

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 616e0520a0bb..2c21735798a5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2289,12 +2289,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
>  
>  	err = bpf_out_neigh_v6(net, skb, dev, nh);
>  	if (unlikely(net_xmit_eval(err)))
> -		DEV_STATS_INC(dev, tx_errors);
> +		dev_core_stats_tx_dropped_inc(dev);

The commit message didn't mention anything about changing tx_errors to
tx_dropped.

