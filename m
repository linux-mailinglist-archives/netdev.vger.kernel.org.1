Return-Path: <netdev+bounces-239164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD63C64C8E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10BBB367A3E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8A336EDB;
	Mon, 17 Nov 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Sg+cmApo"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FC33555B;
	Mon, 17 Nov 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391563; cv=fail; b=ttq8uRb9iTqSlJFhyJnD45ezcJOhBwy7c61wQwgZAGVZG3bn4g//XWPql72X2R9ZAAWm+E3a/WUqgTv/dN7TSFxyPE/jWHuOiGAhjE63GpV9XF20BsoFcrMLo30JTM+uwq2EzNaELT0Iq0Z+U6gVsqGnt/wTCtF0f1EJ4UZHuh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391563; c=relaxed/simple;
	bh=o37KsyjrivM88Wn2PS6ihoaVRCHVb4bFNi7SskMLLBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqvN4KpL+Fp2UtmpyLc6Attz1nDv1zu50YEmJFUSuHDpKyyv94PcT8WUqIe/R1YY9zLjRYAvpO8hChfORGIprDaOw/tUhyUXIDxadr7scUFIId7mmyfpb7tdYaqjzt3Ss8PNXnK57/zxi2n0zzzI1vbwTuS+o1d9FrDtec3m9j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Sg+cmApo; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4bX9zLMWk7ap2d6bWLSwu6kGDHtqnYhpV4FfKpZcCTuDoaKgG1Hjc0pOCwgZpzufNb/TOWDqgZsRd9ATwM0676rJbxuUNB4oLQlUdiXWuzG7F3LL8h0UhuODQZgdazyt3FL/shP9iff1brntAwZ93v2/lhaNxorvGcLnXOT6TlpP+3o1f8kjGLltm4bP5mL7KTAKSXww0JSr4HY2L9ORjDCdKaw7HiQ5+FPan6mgu8farQiQivxctCXUF9PFmCmsBY8ioRpUS3COHqoqZ4OKEHX0fRpx3RkQZnddMQxw0YUCqwQyPuFIJt1yFXyTyXHlasxzCyEmH/+8rBFLmjVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N83a4Wt9J6lebgl+//BCWb1iRMt6CsIW8yaqxsVWCuA=;
 b=m3LnIB3153ZeoQo8vMO/2nugFrtpopFTuS9LVwYaHC6wkWWvhtbH0+nuERrNuGd0c3uZJCBfXrFP1F2P6HFE89Vj9K6trifmK7MtZF5FCZIV2uDU9RHn1GoKiu+XXi0jvIVd26RuHTyVf6g++xBm6sSXAcceHW++67miZwK0t3C6fzHFkd7qN+6HOIQSAO1KYBgp0xtvDj1xpFQePHnTYR3ybKeueRJ2snk62vA+vakzOgls4jNC0sUeFUIMAdi2GuyXUhqn31KQ4wEqLeebfGHa8x1RHRd2cS56KWnjbLlqBLaGY6DA6xMAtnCuLko7iWYmONR8+F6jUAYWl4GSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N83a4Wt9J6lebgl+//BCWb1iRMt6CsIW8yaqxsVWCuA=;
 b=Sg+cmApoe7lH+H9JdzMey9pRlIbLYtH6cG3Z9Ys+Epj3W4LbG119ldJWxHqiA3N62ocRHDEMTmFBg9Ii121c+AVxqyNVTmoSHwyPkwV6/AHr96BdH4k8dj+JmXdI9nua8zzseiOtGfg2DCMdCUMw2cIZMIwFAdFBlCu6in6IaTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB7PR02MB4661.eurprd02.prod.outlook.com (2603:10a6:10:57::23)
 by VI1PR02MB6176.eurprd02.prod.outlook.com (2603:10a6:800:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 14:59:16 +0000
Received: from DB7PR02MB4661.eurprd02.prod.outlook.com
 ([fe80::e783:31c6:c373:2ec9]) by DB7PR02MB4661.eurprd02.prod.outlook.com
 ([fe80::e783:31c6:c373:2ec9%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 14:59:16 +0000
Message-ID: <5b0bd2a0-c1cb-40f0-9226-3038ea9eb294@axis.com>
Date: Mon, 17 Nov 2025 15:59:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for net-next] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org
References: <20251114135935.2710873-1-peterend@axis.com>
 <3feaff7a-fcec-49d9-a738-fa2e00439b28@lunn.ch>
 <5a7f0105-801d-41d9-850c-03783d76f3e1@axis.com>
 <7000f777-d082-4b06-88dd-67f947c85d2a@lunn.ch>
Content-Language: en-US
From: Peter Enderborg <peterend@axis.com>
In-Reply-To: <7000f777-d082-4b06-88dd-67f947c85d2a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::14) To DB7PR02MB4661.eurprd02.prod.outlook.com
 (2603:10a6:10:57::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB4661:EE_|VI1PR02MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea6cccc-f85e-47a6-158c-08de25e9e0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmFZWFNrTUtJdnZ3Z3Uzb1E2K0pVZUJ1NWZGcjZWMmxkVmtkS1Q5MWkxcG9n?=
 =?utf-8?B?UmZCOTIvRllTL08vOVVSa0N3cmRsQ2pJSUZoWW03ZTdpOEU1Q2s4KzNlekZ6?=
 =?utf-8?B?bG1WdzMvSTZ5YUxETmtTb0dzS0NJb01DVW1WZHdidFpaSkVteWE1RjlMVTVL?=
 =?utf-8?B?eFBOTWxNSCtacWgvY2wyNkFkNzNVMTJzaTdqaFQrRjE4dnJmbmJQRWZ3UFZ5?=
 =?utf-8?B?bUhVREZEekZ2ZjMvbWl3R3duMzhoQTJLVExQT1V0SmVER2V1VzFTVTE2dWhI?=
 =?utf-8?B?bDlERWRmTi9sNS9RSTdidHVLM253eHQyVWFLdWlGUEgydFlBNmJ0cFRwU3dY?=
 =?utf-8?B?aUdkaFZRZnMxZjJJNlViekZjSy9zdkppVDB0NG5aWHplRVhLdWhGVjhQdXRl?=
 =?utf-8?B?b3B1WWhVcmx2VS9PWG0wTVdDa3hmbnE0UDJyU1Z2SHVZRVM5MjRoWXI4a1p1?=
 =?utf-8?B?Mm11NWh6UytPc2NGcC9DOG9FVzZvdlQzcHFNMGJ1K1l5Y1JRNkx6NWwxbC91?=
 =?utf-8?B?TmJPbEhnWDRFOXBtL0pHQkhrK0dWOEF5SUtnaHlVTUpPWWRBaHZhVzd4b2Jl?=
 =?utf-8?B?SStQeFZodnJyVlhzR3JuNHB1aEl1ODc5UlUyODB6VFBzem5mYmtyN2FNZ2Mw?=
 =?utf-8?B?MmNFQ1cxRlk0VVZCekVQYVlaM2JoejdwZkM4eWcvbDFzNWIyelIxdE1JcEFN?=
 =?utf-8?B?LzFKZzRHc0ZLVm1HNXRKSGI1MmhwQmsvU1o2aGxzYWJUcWpoc1VmVkhndUhp?=
 =?utf-8?B?STRySTBwUEVhMFIvajUrV3VZWmxSVWczeGdJNU5VaXpybDR4ZjhvVGlhUVZS?=
 =?utf-8?B?SkdVQmVqYk8yMlltSit3SDZLdUFZVVFlRGY0eEttMnVRUHpHdUp5dndLM0F2?=
 =?utf-8?B?MnRBRlNYcnhFaVpkT0kzNXk3UXhNQkhDZlZOVFpjLys2ekR0TVFqSlhRZ0ht?=
 =?utf-8?B?YUp2VlFYcnYwT0ZNb1Z3ZDEwNG84Q1gvSTJhdkpmWWhscjlmdldUNEt1L3ov?=
 =?utf-8?B?WDljSVhVU0UyS0h6UGFUL1YzOWxiK3dtQ1BiWjlEc0c2c2dhTi9hMlJXcVpJ?=
 =?utf-8?B?b2pNS2NwMGpZSklqU1VsYjB2T0kwYUNaZ3lobk1DMmZzRCtMOXNtQVZzUkV6?=
 =?utf-8?B?ZUFrNnR2RFk4UjQ3d0NnU0tCbjJFL2ZpVDM0Z1F5UFhLYTZrU1hua2p2Rks4?=
 =?utf-8?B?K0FzVGc3YVFJb1VDUnlqSmdVclkveVJmMFYrQ0xSVmM3ekVraThTV0gyZDlL?=
 =?utf-8?B?eVR0ZnZtSExXb25SYVh0WVJndEliSUhSNEszVEI3SDVhNlJmN3RIWGt5MW5F?=
 =?utf-8?B?LzZ5c2FyTXQwUGRpV0JEY1FLcENnV0ZLQUdMeGJ4b3llMC8wRm1kTUZjaUxJ?=
 =?utf-8?B?Z2hJNFFqT3NWU21KRERTeWtRa1Axb1N6Qnk1Z29oU1ZPdkVCTE5JK3ZiOXpO?=
 =?utf-8?B?R1BhdkJIeFl6MUErS0kvVndwV0lDaWl2K2FadTNTczhkay9rNnY1d2N2YXlD?=
 =?utf-8?B?TDJJcjEycnpjVFMzSlFKbzdQWHZ0NnFpb0NFVElQVkt0YmVpZmd3czJJd3lQ?=
 =?utf-8?B?cVRFK2VFSldIem56cUpCYWNtK3E1ZFJFZ0EwYUNFNDUyNHIzMzRWMFBUQUFX?=
 =?utf-8?B?MFNVdWVqMUFFbWRPSHdvT2JNVFJMRm10OFh5eDRJeCs0b2xUMDg4WjJkTit1?=
 =?utf-8?B?M2N3NHIvbHZzZXljMjVBbmJERTJKRmR1R3puWUhLazlaYTZxTU02US9jM0p1?=
 =?utf-8?B?ZjAvdUVoSDhvd0dVZXd0Ym5ka2dVZm5TL3h5bm1MT1Iyck9CQUtRMzdoN1RV?=
 =?utf-8?B?L1BLa3o2OXFMRWNkRzVqUFBvaElGT2ZqLzhJemMyTDd5K081VmNIT0tXV3Np?=
 =?utf-8?B?SnorOThNcTVyQW0yd2Q1YmpWOXFjNi9LYmJhb0Uya1hScUxrRVhSYVowUWZK?=
 =?utf-8?Q?Pwev6XBEcOzCgsapt5Nm6TyguDftBLvM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4661.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEkxL0lzWDF3MEZ5WmR2YWFZZk4yNHhEY1dDTUFjUWNkS0NUVDd3ajhqNGlm?=
 =?utf-8?B?RWppWHEwWld6T2l6UWZPZ2ZiMGtwWTJEQ1dhSTRaZUhLWXFaQXlFZkRWbUVM?=
 =?utf-8?B?d3NyR0hsWkNmd2pXRy9MTmwyTDNsMTgwZURvRmdBTmRrZHhTQjJ6b01MUmdC?=
 =?utf-8?B?Y2VpbGtZL2tJeXQzTm5uN1FNcUVPR1VOdGhXWDNQckdINGpxbGJuaWMzTmp0?=
 =?utf-8?B?YUphTmMxVEhiak94YWFNb3pYYlgzYmRsaXhpWnZSWnUxQkFqcnJtSEIxMnEv?=
 =?utf-8?B?TmNyc1dWUmxRbUNTNkh2aDVoYjkrMGJFd0k2VkJXQzJOdmNOR0N1TXNRMW9v?=
 =?utf-8?B?ZkhUNkVqVGI0eVZJeTB0SnZ0RCtSeFdaSHJ4Y1B1Q1FQd3FxRFhkb0xrWWlM?=
 =?utf-8?B?SVVLSUdqTDlRYU1ZTHlLZnNmOFFWWmc2TVhyS1VBNDB6bW9qTWszYzhOR3J0?=
 =?utf-8?B?eVN2aVRuaEh4WUthT1BPbDh0THJBTFZEN2dJcnZZVnlOdXpIeVFTblJWTXBV?=
 =?utf-8?B?VjRIUlVNN1RYSUt2bkVUWmErek9ZYy85UGl3c0IyRWVpcFpoQlRjckN3Ymwv?=
 =?utf-8?B?Y0Z5VEcrcWFXaHpKQVhKbktMaTgyZnlIMU1pNkN6WEtpNVpsUURSZlJROUtJ?=
 =?utf-8?B?TFJYSFl1cVlVYlNpMklsL2l0cUxtYXJveVhDTHZaRDhkUHo4TXRvQnRuSDZS?=
 =?utf-8?B?UDlQVHpTWDJTOThOR1N0Nm56ZEJnemd1RHI0NE02R05MUXEvR3BtT1E3aVVE?=
 =?utf-8?B?OHpLdHVaVUtNUHF2MExYRk1FSHVnMDdVWTVWbkJHNjhSeTVRVGZpYUthUEJH?=
 =?utf-8?B?SHlnbS9BUGZ5cjZwRUVCNGZVMzdYdWlLQThYakZ5OEI4M292VXZOa2xLcDhK?=
 =?utf-8?B?R2xCcGd0cDFiK1ZrSFZwd2drWE4vSk1jU0NzMldWUWdqNGR2MGErcHJ6UTZZ?=
 =?utf-8?B?clZ3Y2NsM3BkWlFOMnVCN0RiTVlGWnpUM21EVUF1WEtObERsT3M4YUhOSlpI?=
 =?utf-8?B?YlJ0S2NvemhTZVU2bjRkdkJjaTd4dGdLWFNsOURBTVdPUktJaWtLTHZ5d2lk?=
 =?utf-8?B?Tk5rSCsrSFZtd1B5VjcvQUVUd3hiUW01UE9sRjdzdXVodXdjL2VicHpBN0xU?=
 =?utf-8?B?aVNWbU1hQmdzZUxyQXQ3Qnk5Q29xY3RTeHRQc2lCdUF5dUtKT3IxNXBLMCtY?=
 =?utf-8?B?TzFlbXhKUTg5VElKSGxzSXBLVXVqOXN1em50Z1pSQ29mQ3VNQWIwMGtVSVVZ?=
 =?utf-8?B?UzBvMDhTbmZwMWc5TXQybjNCck1aK29mQThJRjVySXZQMVlYVmlKR1JlYWl3?=
 =?utf-8?B?RGZrZVhkV0ZYOVJHUURHam9DTnMwK0Q5Tlp4aXhhZWVia1RUSGxUNThNSnYz?=
 =?utf-8?B?dGxpMkpQZmduQXUxSVJiVUxza3VrMEQzR0hCcW13ejFUSkVYYVJBUkJWeS9k?=
 =?utf-8?B?eFcrTXRwZ0ozajZwaW1IRDJwb0QzLzlic0JHYnVZMFp0cVNDTlRieFQyaU5L?=
 =?utf-8?B?aTlScWhiVGlUU0dhZUl5Yzh5WkZkWnY0NlFpelpmcjRqQTlJdUxQdkd2R3Mx?=
 =?utf-8?B?NkFaZ21UcmtsZFo1Wm1nR3hWU1Qrc0l4dlRJVEFkMkJheEdWSnNXVS9lS0x4?=
 =?utf-8?B?U2dIeEFwaUdNV2J5QzVPcXBlRjk4SDJRQWlmWC9iYUpXVmpZeVJqV3E3RVAx?=
 =?utf-8?B?OS83RmJiSDZ0RTlaV1RybVUwbmlTOFBFNDJUaXpxbG16bllPaE9IWkxWNlJP?=
 =?utf-8?B?SXZhMVNpWThGcFFycjBPbjF1eWRtRG5BTGdQeEdGK0gvRHB0bjdISVJ1TlVO?=
 =?utf-8?B?UzVhYlh5eVVzbGlac0k1bllzeFhMaHBnbGFYN3dKSHZ4Y1NDZjdiOHREMHVx?=
 =?utf-8?B?Z3BFNVJwR2NKM2gwNlo0dkdqYmNXZmFaVEk4dU1raGVwUlFDcnNaN3RRV3Vr?=
 =?utf-8?B?bG1IZStSM05zVUtpbkROUm1hU3ZHVHV6MTRTMTBnWEQ0MDIvNnFFVFRjU01M?=
 =?utf-8?B?aXdEa0tIQ0NiUUtSOWN1RTFmbzlZOTA2S1RvVUt2RVB1cjJ0UlF5c09oNWlW?=
 =?utf-8?B?MlhJTlRLZVladHM2QStrM05RaGpsRlovTm9OQThMM1JzaVB0OUd2K3lLaklr?=
 =?utf-8?Q?HaJyyMhw/454UeaxY6zazr4jQ?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea6cccc-f85e-47a6-158c-08de25e9e0ed
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4661.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:59:16.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J1l01ZTXaIkL/Dvc24k3gy0sWYsAVzr+SwOPCKA0tYK+vdljkiXGDAlIyo2rBpJQpt+1Ft8FSrxUggRhQhUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6176

You have to pay us$4000 to get a ethertype.

On 11/17/25 14:28, Andrew Lunn wrote:
> On Mon, Nov 17, 2025 at 10:02:05AM +0100, Peter Enderborg wrote:
>> (resend due to html bounce)
>> On 11/15/25 21:41, Andrew Lunn wrote:
>>> On Fri, Nov 14, 2025 at 02:59:36PM +0100, Peter Enderborg wrote:
>>>> Ref https://standards-oui.ieee.org/ethertype/eth.txt
>>>>
>>>>
>>> Is this actually registered with IANA?
>> No.
>>
>>> https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml
>>>
>>> Does not list it. Please keep the "NOT AN OFFICIALLY REGISTERED ID" if
>>> it is not.
>> IEEE is the official source to use for ethertype number assignment.
> What i want to make clear is, if IEEE officially allocate this to
> something else, this is an unofficial allocation, and the official use
> can replace it. We have a few ID like this, and never had a collision
> yet, but it could happen.

This is the public list from IEEE. It wont get more official. Yes, official
allocation can be changed in non backward compatible way. It happen
in 1983 so it can happen again. If the standard changes we need to adopt.

"NOT AN OFFICIALLY REGISTERED ID" is wrong, it is "Infineon Technologies Corporate Research ST".

> 	Andrew

