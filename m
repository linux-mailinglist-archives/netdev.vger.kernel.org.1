Return-Path: <netdev+bounces-218334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47579B3C017
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A20B7A7F95
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C02322A1A;
	Fri, 29 Aug 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="rXquhoAm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2092.outbound.protection.outlook.com [40.107.95.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139A192D8A;
	Fri, 29 Aug 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483159; cv=fail; b=YvijkR/vcbP8uI6ebpGt5MqQPH/PZWUBIYOCUdDTnjVSdhLw56xpxRjr/9dQJ2QpuOCNWvpERtpZi3dPbRDHtLvkEYfcwCoIazsNwEmfOhPbyWFUPRoz3oRQhRs66jWG7xTZ8188Yo6BT4QiMz3SpU9sqQ6rpbiUcV8Ch8yoMHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483159; c=relaxed/simple;
	bh=Db1XY6f0tQfompzBvLZnoqAI8LHlCt6Wj2HWlVsHVQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JAx5QQ3TCiQi3hVLoAKgXIJhF1rFsM1WOZdC/1OCewmASfeYAIQyn/pJ55F5FufXj0HasdEVuQ1iEMFChWbp7K04i3BiZ3U5C6LPcfThECQef+RJBR/rxGTIvN5nWNk9rGwLarTeioOOlO+HivxyvRpmd7HJbvi6ufflONi0gJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=rXquhoAm reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.95.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD0UE1fAQyWaTRxcQWylLd84+C8Z3dkpH5ph7S6Hku5vL/+QS9de7r4/xh7lMz/qHeILRpqunw65/pn712xi/CWR97qntfMj7z2J9L7LbCgYbBOG5xPMK5QiHk3UfqPebfWNYwBoflZosqqzSywttzkkp04KvCDfbZWju2anLP86hzbLJRNILzGTOB+Rbe2NCg50RVat+TwMGD92aKSA58xV8CQzyyCERGXkNmZQ9/iPL9YVcctzaDUsDor7cdaA1SEuICxiJ+4Z6qt5J2WOFW5g+ARF9xrChnMEc3iuDhCKaeMvlePzvGopo8pVr96R7hCPNXPNT8HbzAgLR5NrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma+O7TODjXU//NeA2Cwuo/Clx3Y4qpfpcurHiJcVPPY=;
 b=vDHDwr1ZgQIgd5VE1mCKSSNQ33voaUxPyiNBhdWHFyy8D1Ej9RMEuYr8F2fYNuL4cSGrdqcwTqLrds/pAS1W2lv1xWe+GEJoFqLSsKcL6pK2uHRAUZYJqklXCvSyhOpt3QmDGEplo6VqwOhd1UHzpTmJu2MW9hkJDdL1rmSOYXulQ+J7ZJCPxHmAyRs3M3Ak2sYt5xgqbPZbZqCYSMXb1U8wX+Q9JHUs2VFVTPP9wMhVsfCLU7/yameoOrFtpIPfBAu3FxlV5Trngi3hwTvTbk8o9RiJ428NK1Y7+O8GAmPYOnrFr0HHDR76On+3kDTKuYbxyXmt/w7tz2sw1BJXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma+O7TODjXU//NeA2Cwuo/Clx3Y4qpfpcurHiJcVPPY=;
 b=rXquhoAmKv+7izLfOBJI+Y1VnaLMAlzjBUlskR6QLdeHYjnRNPbXNBOSDIVuKcIhUpeCVb5OEd9dFTY4co8O1a6fR8dHP+bcVVbLb42lrKTGoDxgZMKBF+hM9CxArzyGWh5P+zVQo52cROlQNj6NoA+sYeyDaxD2XoNweA28/hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BN5PR01MB9153.prod.exchangelabs.com (2603:10b6:408:2a8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Fri, 29 Aug 2025 15:59:10 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 15:59:09 +0000
Message-ID: <e28eeb4f-98a4-4db6-af96-c576019d3af1@amperemail.onmicrosoft.com>
Date: Fri, 29 Aug 2025 11:59:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v27 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
 <20250828043331.247636-2-admiyo@os.amperecomputing.com>
 <eb156195ce9a0f9c0f2c6bc46c7dcdaf6e83c96d.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <eb156195ce9a0f9c0f2c6bc46c7dcdaf6e83c96d.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0094.namprd19.prod.outlook.com
 (2603:10b6:930:83::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BN5PR01MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: f511ee24-1785-4d8f-6bdb-08dde714fda6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkJJc3ZBUlZ0OTBRVmcxWWNrQUtmcmd1amlXdkI5NVdQV0xZck8zWE9VUnZw?=
 =?utf-8?B?eFdjckNGazR1QjFweHhSSDFvV2xNUnQ0MEo4T0ViMEJNaXJXcFN5WjRVUEI5?=
 =?utf-8?B?Qmp1Kzl0QmpKaHVWcU1SMzdMb1JvdlVmNmpHbTBsRTJrSWRzTHVUMi9IS0l4?=
 =?utf-8?B?VEhxdkNZNWl5NEFEU1V1UXgvR0pSeWE3am0ralNuQlpwRUxEU29zYkFCdW8z?=
 =?utf-8?B?MVNOUmhLb3ljMXd4WVBTMEhBSEt1cDRELzJxZ0lDTkVNSzRCK25OUUF0V3NX?=
 =?utf-8?B?S3ZuT3JJeWloVEtrZjBMYU9hS05tNjhZc2NzTzhjTzdWY21JaDFSSnQrYlJ4?=
 =?utf-8?B?Wm1ma0xBdlVwTG5FdFdwVm9GVFhIdzFBQ2lCWkt2MU42Z0pVZkRGYm13a1cz?=
 =?utf-8?B?bGJacStHdTYyMnByTEZjUGZ3VkJhWkRzSUVHdjlST3hqRlhkUC9Mb3BjMk9D?=
 =?utf-8?B?VnhRWDBEeVJCUHBkNEYwaGZLdU5OWmZJalgxTm53VERwdzVUa0h3WjNjR3lj?=
 =?utf-8?B?WUwvajZtanZkZC9NSFN2eXNRTFZGbThaNzN1K1hlTFRSM09LVjN4L29vVjYx?=
 =?utf-8?B?UkhnSlJNaXpMd1BkVklYbnIrcUc2bEZ5cHk3YTlTa0NoejF0QTY2T2ZSZzFp?=
 =?utf-8?B?RDNRRHB4Tjl2RTFSdnhFeFRwSGx5Z2lDUHBHdElwK2lDcVlPTFlZYmdaV2ZI?=
 =?utf-8?B?dTFWWmYxQVNwTnl4aXhiaWMwZDZkVmVOZmd0WnVoL2E1QnZQdVZOWE4vbkhX?=
 =?utf-8?B?MjFnVFV0TWtiTjNFRHFoM2FsMERxVWJueng4YWptSzhKWVREMlNleGdweTdV?=
 =?utf-8?B?M0dJWE54NnNYYmJyRVhabERpTE1iU2dmYS9rR1IyT1FlNWZ1TDRJUEVOelBG?=
 =?utf-8?B?a20ySFhaVUkvWlhzeWtxVUtpL1l0anljL2cxb3Q3Q3VtRmh1Yng1NkJuTE1p?=
 =?utf-8?B?NXVSRVJ3bi8yZ3lYc21qby9GQmdjVlRqZkNmblcwMUlqN2M1M0NDdGZvMDlO?=
 =?utf-8?B?V1FNTEhaTTY4LzN3a0Zub1N0MXQrTFErb1NCd3IwM0FoRzBSOGcyOE1rNy93?=
 =?utf-8?B?WTFEdm9QV3hOeHowNkk4dVYrU0NuOVc0L29pb1pTY0tsVlRSWkNGSWR3WGtU?=
 =?utf-8?B?d1FIY2xOcjZHWmZ2dExCVWJ0SkpPWXV4NkZubkloZ2NIVS9VRlVsbzY4ZDZY?=
 =?utf-8?B?MGdJb1E1MGRSV29NT21PcGYzaFhHYzhFbll3V1I1SW5MNUpRaDVQS0FBV2ww?=
 =?utf-8?B?VnZOQmJ6WHgzTmFlR2lWMzkzT1grMkI4VUpmUEpBOVNVYU1tZ1EyRTVIZVJI?=
 =?utf-8?B?eDZlMDFNVXptNmtqbVpWV1VMZnBiYjBzYXhDcjNuOE5KUFdnMW0vYXV4ZDI3?=
 =?utf-8?B?RzZySVhQeEs4K29JcVJDR09aQjlwNlBxcUp3VmRTWTdrUUp4SldpTFFNUFhQ?=
 =?utf-8?B?R2lpaDM4ZEtjbkFRZkF5Yi9veC9JWnEwRHdRanlVQUhSejFWYTJxdWp3dm9T?=
 =?utf-8?B?Zm5PTkpsSDRtSFRhZzArQUYwWkY3VEorUVl3K0NIcnpqZE1tcTFHb1lZbHhY?=
 =?utf-8?B?QU0wVDJ6WUpxRmlFSzROandnVHE5b1FVQnFyV215RWRFK2w5V2xsUjd6NVJ0?=
 =?utf-8?B?YUZ5aTVVd3c1OXNwZi96TVhkQlRTSFEzMWU5MEVyZmtGRll3RmIzWHVEaUcz?=
 =?utf-8?B?QmxvLytxMGNuMElpcUcyUUM4Y2VaM3hDTU9LczhML0p2WG5JVE51RVRja3Fn?=
 =?utf-8?B?ZlVNUlk4eWw1ZitHZmhQV1RBbkJiYlBIOEtLL3JXQ0E0bGtJZnFld2pIMHZW?=
 =?utf-8?B?WEY4M2FPSVcvRm1BeCt6bDk4SEZFTkNxQzlZMCs3empQTi9pbEJ0ZG41Zmti?=
 =?utf-8?B?cVVZKy9XbFFiTWtXYVB3cXZuMjhoNHo1STB2K0l6NytMY0xaVjR6bGI5T09l?=
 =?utf-8?Q?6R+5aWqyZys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERMblFhRmNaWHZhNm9ER2plNW14K2hSblBGYWxvYk1pSmNiV3VLRllCVFl5?=
 =?utf-8?B?b3ZZd2p4blpNRzZsQWtGMzJyQjQzcUlGMThNOTZzdmVKOFpEeC8xWEVjMlBP?=
 =?utf-8?B?UmlHcDlvZGlQa2hWUElhNm9NZGRabTYrdlljUnAycGZyb2JCZndHRTAwTFdo?=
 =?utf-8?B?dEh4QXVZMW93SGw0aUN5WUtXcHloMm9GOGN4OFFwZ3FGUGE0NU42di9oVW1o?=
 =?utf-8?B?T2hYTWtUcHlibkJOdEJSeGFLRElpYitydUZDRXBCWVA4MUtFODBXSm5qd1lL?=
 =?utf-8?B?MzNuUkdUZzFEMVJXaWpmTW9XQzRTT2VtRDNMYXcrWVI1eDNRVzNLWnNjM3Zo?=
 =?utf-8?B?dVBPaGFoeHNETitmU1Rrdy9DZnFManlwSENncHIxcFk2d3dUU1NIaFZMamxR?=
 =?utf-8?B?ZlhVSmROT0FydGRFWTFxd1hxTEtXRDlpMUlpaGl0b2gwdFlobHJDcWtOOExQ?=
 =?utf-8?B?RDkvNGtnaEw2Y1R5OXNJZzJycVVBbm8wUmdZdHd3bVNycGdib2gveWlWSEZP?=
 =?utf-8?B?VGhraEIybmkzR1ZmY1NjUlVMb2hwcTBIWk1SWCtCMytqMEptTzVQL0hGeTlC?=
 =?utf-8?B?SVJLSG5zL2ZjbmtiTlZacmRKdHdzbWxhMkpsOXBEbTlCVVZvVFN4OHZwYTBG?=
 =?utf-8?B?Y1BRUVh2Q3F3eTZEMldTZU9pbkFGcVVadkdQN0dZS0RrdUNzck9SMHRkS0NX?=
 =?utf-8?B?eWtON1l4L0tMUmV2ZWp4V05vTStzQ3J6UFhLd1Fncjh1dERXOFJTTUY3TFhM?=
 =?utf-8?B?Wk5ITUlJN1N5bUpWbXpZQTE0enR6R1VWVzB5MUU3R1AxM1g1RXNzcWZlUlNN?=
 =?utf-8?B?Ykt5eUIvZWYzT1diblY3K3FYek44eXBjL0hxcFVqekZJOHFZdzhxci9Vb0x5?=
 =?utf-8?B?U1ZNTmw0ZjJPS0xuMXJDWUZjMkN6RENoQ0s0RU5QVnAxMERJcy9rVkhVS21m?=
 =?utf-8?B?Uno1M1h1d3VhaFZHbG01L3poeEMxbTVwdDFtd3VvVXFaLytTK2ppd0wzbjFW?=
 =?utf-8?B?UTN2TDhPeUR0eHB3a05qZTM4eDJwdEFKOXBZdEU1ODkycVRsWTY0M1J3Smd4?=
 =?utf-8?B?ZXYyZ1k5NE5tR2pwUkZCdXNzWHp2VnZ0Q1BBOThvNTl3cEhJWlRUOWlWVlZ2?=
 =?utf-8?B?eUgrdlh5ck03aEIrT09vSjEyMTh0TERrais5NzFxdnhLRWtGL2M4MXlYanIv?=
 =?utf-8?B?UFd1V1g1UnlLaDViYzY1bm9FL29xZ3lTYnRpcDNOOFd2OUZVNVNrMjErTU95?=
 =?utf-8?B?RWl2MHMwNXlZOFd5bTNBZG1hakFYbGxkZ290QjBXWWE4SU51WkVEMGlod3Nm?=
 =?utf-8?B?a3hsdndQV1ZaQmxGUzJQUWdvWkRUT2VyYTRTcmd4Qkw0cnBaM0x0S3J6UXZz?=
 =?utf-8?B?dGpLTFpGU3RZSU5ORlI0V3h6c0ZmS0QvU0tuYnlnemYyY0VBZ0g3ZW5LVXVj?=
 =?utf-8?B?RjQ5ZHJQQ3dkV0JNMCtiTUlLZWcvdy9PYTRwUFIxOXZ0NEd2TWdmQVhCbjR5?=
 =?utf-8?B?ZzVRSDA4WjRyRzc1aUtsdUVkUVhDc1phc2M1c0RBcVlxTGJnYnFVNUUvbHN1?=
 =?utf-8?B?azVocmZkeDJRdU1JaEdRMW9WYlFKeTYycTZnK2UyTUd5aGFFdVdnaVdlSDNT?=
 =?utf-8?B?M0MvVUN1K3FRNUtFdUFhZ0dqa29TSTdnZlRuMWx5c0tFV2RMQnJWV1lLSngv?=
 =?utf-8?B?OXNDcE9iN3UvNGJYV0NyS2lSY3QxMG5NODRsSXhwTTJuT0VDaHYzU0V4c0Fx?=
 =?utf-8?B?eXRncWhXeGNQMVhmOUdzQzdmdXlPQlpDUEsva3NoYnIxR1Z1NWpwZG9uN2xi?=
 =?utf-8?B?bTA1L0FQOWlqQ3dwTWxVMnhrczdrRDZEL0s4SGcwbmovK0I1WWNhRXVXRkw4?=
 =?utf-8?B?OVJhZmV2U2ExbkhENmZXMzJDN3RiUEJNRHN2UStEZkgrZWZKWVlUUk1Fc3Fn?=
 =?utf-8?B?OG5UMm90bTlWdE9KaFhHU0UyZmdpb2gyRkY5Q2JNQWI3RGY5OTcrdXNpWjFv?=
 =?utf-8?B?WXZuK2lMcFQ3N3Jpc1JhaVJyMEt4WE45RWNva2EyRVlXYlpadklIbHNTOVo1?=
 =?utf-8?B?NCtQNXdBMnFhdmNKejVmaGczUXJMS21NSHRGSjJsUEFVRXFUSGRidDUzVTln?=
 =?utf-8?B?OXZuZzNWV0cxci9uNXBDdVdIK1ZqNUdhSkNoOWt1TEdrcG1oSkF0OU42cVlE?=
 =?utf-8?B?aFIyUWxydVBVQkFReGk5NDhZV0Y0MlI2b01ubHNNMmVtMTAvVWhScERRKzQv?=
 =?utf-8?Q?3LHJ1Pd4+Etal8gHr1mPbyy2j1gHOU+tek2fMIaIsA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f511ee24-1785-4d8f-6bdb-08dde714fda6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 15:59:09.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42MflJ3LBWfuTNnSJLJi1XzODe9KUF/zspd/lprNwVUYPCOKei7Dglly/BTpUTl1sQvpRh0vsO9d8p099vZCKDZGVwQesI+LjHUZNnffslB3GgiOvdirpd95MQMoV6eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR01MB9153


On 8/29/25 05:16, Jeremy Kerr wrote:
> Hi Adam,
>
> Still some issues with skb management / synchronisation in the cleanup
> path; comments inline (as well as some minor things, but mostly optional
> on addressing those).
>
> You seem to be sending follow-up patches fairly quickly, rather than
> responding to queries about the code, or discussing the approach. If you
> have no points to discuss, that's fine, but please do feel free to chat
> about options, or ask for clarifications, before jumping into the next
> patch revision. Even letting us know why you may have rejected a
> suggestion is helpful for me in the review process too.

I thought I was  addressing all issues.  Perhaps I do need to slow 
down....different work styles: I am used to responding to code reviews 
as quickly as possible.

more comments in-line.



>
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *outbox;
>> +       struct sk_buff *skb = NULL;
>> +       struct sk_buff *curr_skb;
>> +
>> +       mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
>> +       outbox = container_of(c, struct mctp_pcc_mailbox, client);
>> +       spin_lock(&outbox->packets.lock);
>> +       skb_queue_walk(&outbox->packets, curr_skb) {
>> +               if (curr_skb->data == mssg) {
>> +                       skb = curr_skb;
>> +                       __skb_unlink(skb, &outbox->packets);
>> +                       break;
>> +               }
>> +       }
>> +       spin_unlock(&outbox->packets.lock);
>> +       if (skb)
>> +               dev_consume_skb_any(skb);
>> +       netif_wake_queue(mctp_pcc_ndev->ndev);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +       struct pcc_header *pcc_header;
>> +       int len = skb->len;
>> +       int rc;
>> +
>> +       rc = skb_cow_head(skb, sizeof(*pcc_header));
>> +       if (rc) {
>> +               dev_dstats_tx_dropped(ndev);
>> +               kfree_skb(skb);
>> +               return NETDEV_TX_OK;
>> +       }
>> +
>> +       pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +       pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +       pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +       memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>> +       pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +
>> +       skb_queue_head(&mpnd->outbox.packets, skb);
>> +
>> +       rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
>> +
>> +       if (rc < 0) {
>> +               netif_stop_queue(ndev);
> Nice!

Yeah.  Had a bit of an internal discussion about this one. Ideally, we 
would stop the queue one packet earlier, and not drop anything.  The 
mbox_send_message only returns the index of the next slot in the ring 
buffer and since it is circular, that does not give us a sense  of the 
space left.



>
>> +               skb_unlink(skb, &mpnd->outbox.packets);
>> +               return NETDEV_TX_BUSY;
>> +       }
>> +
>> +       dev_dstats_tx_add(ndev, len);
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static void drain_packets(struct sk_buff_head *list)
>> +{
>> +       struct sk_buff *skb;
>> +
>> +       while (!skb_queue_empty(list)) {
>> +               skb = skb_dequeue(list);
>> +               dev_consume_skb_any(skb);
>> +       }
>> +}
>> +
>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev =
>> +           netdev_priv(ndev);
> Minor: Unneeded wrapping here, and it seems to be suppressing the
> warning about a blank line after declarations.

The Reverse XMasstree format checker I am using seems overly strict.  I 
will try to unwrap all of these.  Is it better to do a separate variable 
initialization?  Seems a bad coding practice for just a format decision 
that is purely aesthetic. But this one is simple to fix.


>
>> +       drain_packets(&mctp_pcc_ndev->outbox.packets);
>> +       drain_packets(&mctp_pcc_ndev->inbox.packets);
> Now that you're no longer doing the pcc_mbox_free_channel() in ndo_stop,
> nothing has quiesced the pcc channels at this point, right? In which
> case you now have a race between the channels' accesses to skb->data and
> freeing the skbs here.

(I have written and rewritten this section multiple times, so apoliges 
if soemthing is unclear or awkward...it might reflect and earlier 
thought...)

OK, I think I do need to call pcc_mbox_free_channel here, which means I 
need to allocate them in the pairing function. The ring buffer will 
still have pointers to the sk_buffs, but they will never be looked at 
again: the ring buffer will ger reinitialized if another client binds to 
it. Which means that I need the .start function to create the client 
again, and all the other changes that come along with that. The removal 
was to deal with the setting of the MTU, which requires a channel to 
read the size of the shared buffer.

        mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
                sizeof(struct pcc_header);

I could create a channel, read  the value, and release it.  The Value I 
need is in the ACPI PCC-table but I don't have direct access to it. 
Perhaps it would be better to initialize the value to -1 and use that to 
optionally reset it to the max value on ndo open.


Check  me here: The channel has a value ring msg_count that keeps track 
of the number of entires in the ring buffer.  This needs to be set to0 
in order for it to think the buffer is empty.  It is initialized in  
__mbox_bind_client, called from mbox_bind_client which is in turn called 
from mbox_request_channel

The networking infra calls stop_ndo, so it must stop sending packets to 
it first.  I can netif_stop_queue(ndev) of course, but that seems 
counterintuitive? Assume i don't need to do that, but can't find the 
calling code.


>
> Is there a mbox facility to (synchronously) stop processing the inbound
> channel, and completing the outbound channel?

There is mbox_free_channel which calls shutdown, and that removed the 
IRQ handler, so no more  messages will be processed.  That should be 
sufficient.

>
>> +       return 0;
>> +}
>> +
>> +static const struct net_device_ops mctp_pcc_netdev_ops = {
>> +       .ndo_stop = mctp_pcc_ndo_stop,
>> +       .ndo_start_xmit = mctp_pcc_tx,
>> +};
>> +
>> +static void mctp_pcc_setup(struct net_device *ndev)
>> +{
>> +       ndev->type = ARPHRD_MCTP;
>> +       ndev->hard_header_len = 0;
>> +       ndev->tx_queue_len = 0;
>> +       ndev->flags = IFF_NOARP;
>> +       ndev->netdev_ops = &mctp_pcc_netdev_ops;
>> +       ndev->needs_free_netdev = true;
>> +       ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
>> +}
>> +
>> +struct mctp_pcc_lookup_context {
>> +       int index;
>> +       u32 inbox_index;
>> +       u32 outbox_index;
>> +};
>> +
>> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
>> +                                      void *context)
>> +{
>> +       struct mctp_pcc_lookup_context *luc = context;
>> +       struct acpi_resource_address32 *addr;
>> +
>> +       if (ares->type != PCC_DWORD_TYPE)
>> +               return AE_OK;
>> +
>> +       addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
>> +       switch (luc->index) {
>> +       case 0:
>> +               luc->outbox_index = addr[0].address.minimum;
>> +               break;
>> +       case 1:
>> +               luc->inbox_index = addr[0].address.minimum;
>> +               break;
>> +       }
>> +       luc->index++;
>> +       return AE_OK;
>> +}
>> +
>> +static void mctp_cleanup_channel(void *data)
>> +{
>> +       struct pcc_mbox_chan *chan = data;
>> +
>> +       pcc_mbox_free_channel(chan);
>> +}
>> +
>> +static int mctp_pcc_initialize_mailbox(struct device *dev,
>> +                                      struct mctp_pcc_mailbox *box, u32 index)
>> +{
>> +       box->index = index;
>> +       skb_queue_head_init(&box->packets);
>> +       box->client.dev = dev;
>> +       box->chan = pcc_mbox_request_channel(&box->client, index);
>> +       if (IS_ERR(box->chan))
>> +               return PTR_ERR(box->chan);
>> +       return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
>> +}
>> +
>> +static void mctp_cleanup_netdev(void *data)
>> +{
>> +       struct net_device *ndev = data;
>> +
>> +       mctp_unregister_netdev(ndev);
>> +}
>> +
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
>> +       struct mctp_pcc_lookup_context context = {0};
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct device *dev = &acpi_dev->dev;
>> +       struct net_device *ndev;
>> +       acpi_handle dev_handle;
>> +       acpi_status status;
>> +       int mctp_pcc_mtu;
>> +       char name[32];
>> +       int rc;
>> +
>> +       dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
>> +               acpi_device_hid(acpi_dev));
>> +       dev_handle = acpi_device_handle(acpi_dev);
>> +       status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
>> +                                    &context);
>> +       if (!ACPI_SUCCESS(status)) {
>> +               dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
>> +       ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
>> +                           mctp_pcc_setup);
>> +       if (!ndev)
>> +               return -ENOMEM;
>> +
>> +       mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +       /* inbox initialization */
>> +       rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>> +                                        context.inbox_index);
>> +       if (rc)
>> +               goto free_netdev;
>> +
>> +       mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
>> +       mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
>> +
>> +       /* outbox initialization */
>> +       rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
>> +                                        context.outbox_index);
>> +       if (rc)
>> +               goto free_netdev;
>> +
>> +       mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
>> +       mctp_pcc_ndev->acpi_device = acpi_dev;
>> +       mctp_pcc_ndev->ndev = ndev;
>> +       acpi_dev->driver_data = mctp_pcc_ndev;
>> +
>> +       mctp_pcc_ndev->outbox.chan->manage_writes = true;
>> +
>> +       /* initialize MTU values */
>> +       mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size
>> +               - sizeof(struct pcc_header);
> Minor: no need for this temporary var.
>
> (Or the comment really - we can see this is initialising MTU values from
> the fact that it's initialising values with mtu in their name :) )

I think I am going to set this to -1 here, and then initialize in ndo 
open if it is still -1.


>
>> +       ndev->mtu = MCTP_MIN_MTU;
>> +       ndev->max_mtu = mctp_pcc_mtu;
>> +       ndev->min_mtu = MCTP_MIN_MTU;
>> +
>> +       rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
>> +       if (rc)
>> +               goto free_netdev;
>> +
>> +       return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> As has been mentioned elsewhere, using the devm cleanup mechanism is a
> bit unconventional here. You have the device remove callback available,
> which lets you do the same, and that way you can demonstrate symmetry
> between the add and remove implementations.

This has gone through a few  iterations and I thought I had it clear.

I was trying  to make use of automated cleanup as much as possible.


>
> I'm okay with the approach, but you may want to consider the remove
> callback if that gives you an implementation that reads more clearly.
>
> Are you doing much testing here? I'd recommend running with KASAN and
> device removal & link status change under active transfers.
Will do.  I have not done that yet. I was unaware it existed.
>
> Cheers,

THanks so much for the detailed review and explanations.


>
>
> Jeremy

