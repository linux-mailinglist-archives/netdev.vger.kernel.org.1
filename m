Return-Path: <netdev+bounces-157304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A83A09E46
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901EB18899B0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54A21B199;
	Fri, 10 Jan 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DgGQYVuu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7421C9FA;
	Fri, 10 Jan 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549137; cv=fail; b=szTAAdmv/eBwVTF4TB6TTFIwLfvfgYsd20Qg7+MdLmZnQZ0lYWjqjL2a+ZKN+YELiA/6quxjNtynpkebreIIB03LqAxdjXYiHRI2Iw66Vx1iZtOg//1S3IV6wzlEckg2JY5Mmmyjdu6M6Mvkf/FNvoumjzmc9MMP6fVixZ9ccKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549137; c=relaxed/simple;
	bh=1t/BZcH8dy15KipaZYZRzhIIbHBgHTLXKSzEtQwdKZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E2XXIlh4lMK+iGQDr5C89ZfALgN57D1XEFUv38O86oKvcTQLsf5Sm8IaSuuOFr1jvOf4sma3l1dqsa458sSsrWKWaSPOwJsjl2AsgRrxdGlLRL6ufeVtNoch6Muj+Z8am/rG830xdmQgUlnz0iYI7LReIZkpRwSIJY8KIRUN+TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DgGQYVuu; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3rtalK3KXGZQv4dbNx40tpofsyc+KjUZk9nsHyjmHdm5OSxUWM3fYFm7MJRs10OuzGm2HIs54AD8uAG6GX7NDZryALOTDMjp4KJknzHjcfKRYLMeKH4o2c969Ru9KVqLw2ewlDmHtKaL3DMg0fjN1wTy6LDify47O7/g+p0hhuLe2rQGp06Dn5qXhGVKGjKonxT4jQcK2aGFeHE+vv5z6Hq4Jdx32UEobAQDX13YsVJj7itespJBN361SypcLcHk3a5JmhoKClY0clZ9DNmM7veFbxnBUkOnBuufRl2YVkKGQZgYTmpnKn2NqqJQ+9mCTABAbzVvgpRm2zvWCbxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu1lsSgH2bLSpBuL3kZL+kvcVdtHxDBkIApP1DZkvpg=;
 b=Jg+Dd1VfDmaFg5MzCS6sowpdpRQYod2DOMrqt92ATrfDTfyAStgogfPhOOC/7rgU2MSSg5ULOKXfFbXHpKLIYohO0WaTnBGkjfvtBwr69f7LLU1y1KTqzRTlKVZ0vwQXFUpKoRvu9JeejkbBVzeomUcRh0/YmEuSdRTleORwvuGkw1NUAxbLCV5hr7l/fDRZ/QIiHtrFCRTWFJ9GQWlHkl0NuStDcs1XnqTggqsc0laAeS14eqrxkvgJsZWa8AqBn6tF4t/x0MfbNv3wuXXodvu5OdCVbIEcss8Tlg0wSbWzFvdPKCWmvMdUkyRvroAdiKrU6aphLVMRSvuJAMG1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu1lsSgH2bLSpBuL3kZL+kvcVdtHxDBkIApP1DZkvpg=;
 b=DgGQYVuuJr5NipYW0wKUXnVaMZpgHDHzdCEkzoApiy8t835wxgumdXmS3Co6Y/S4r/r9nhMxYHcwAxdP3c68O0Yc7dysU9BOTy+vcyJkhCaRl6KzRHjOxoDk+Ngr0pct7IpOLBldGIED7+K2w1K08XIVsS7Vr7vVF4VewmaTCiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Fri, 10 Jan 2025 22:45:32 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 22:45:31 +0000
Message-ID: <f15e24bd-8e1e-4496-9066-e00d5f586880@amd.com>
Date: Fri, 10 Jan 2025 14:45:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: xilinx: axienet: Support adjusting
 coalesce settings while running
To: Sean Anderson <sean.anderson@linux.dev>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
 <20250110192616.2075055-5-sean.anderson@linux.dev>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250110192616.2075055-5-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 6529580a-8b14-45ae-2420-08dd31c87d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU52aXhkdTBMUVQ4blBqUHJuUzVWVEVYdWduVmUvNm1pNUk1cGMxcEJBeWJk?=
 =?utf-8?B?eWVFdVpKWVhWaCtpUlZKYjIrMDZIbU9JS3FkY2V6TVhKL1JKUHNFRmRkTDl4?=
 =?utf-8?B?dU9pbk9YdCtXWHBVK2pySzhDeC9CN2JCbytzTUJKR0t5T0FKOHR5RlQ0Z1By?=
 =?utf-8?B?NEs5VVMxcW82Z2hsZXE2Ync2YUpSZEZJU3c5ck9HV2V2cm9ZcmtaaWNPb2RB?=
 =?utf-8?B?OTc1VGwybjJBQmxDb0tpQy9zck1zSEFDRGpod3pFc2VmaDJwaUdTRDExb3F5?=
 =?utf-8?B?Y3RNZFhtT2V1K1d2MWc2dVFkNDJDbjVzdkFodmJNNnVQeEZWb280M2t4UStK?=
 =?utf-8?B?aFN5Z2dMaStVTWp0cWJISGtvaHo3Vm5QRUlaRVRSUWxldDdkOTZtL2ZBZVRa?=
 =?utf-8?B?Q3NoNHJiQXA3dVBUNnJ5b0h4ZjJQdFg3TnFOeWdQdUZ2bzNGdjVISm9URlhR?=
 =?utf-8?B?WTVnb01jUWFkWnEwK1hOelhmbmZaUTBRd1FXTWtaQ2Z1N2QwdEpidzdaUUQ3?=
 =?utf-8?B?eEw5VHpFSGtzRjc3czNiRG9YR0s1Z240SXdNeTN1UWw0bzZNaS9JYlFVTzEz?=
 =?utf-8?B?Vk4rdzFuUlMyclBEejVENXljaGh1Ryt1UGxqU05YeFp5OVFxTks3Y1FlendU?=
 =?utf-8?B?TFVycEJMY202U0xkTDA3N05Oek5qT1drTnZ3Q3FheG0xVHlKM0NpdmZyaGgw?=
 =?utf-8?B?cXYrZUpKdXRRNlhYc3Jwdmtmc1hkME1SdnljYk16OE8wTHRYWFZXSG5ob0Jn?=
 =?utf-8?B?YWUxM2l1WXgrdzhGc1lpamVjR3cxVUM3ZjFXOE0xT3VEVXU3YTBUZ29nUjlE?=
 =?utf-8?B?UCt3T3BtR1RlMlN2dVFjQ0xjY1hXR3hSdllVRENYRHNwWUkwSENNdytISEdQ?=
 =?utf-8?B?eHNOekJIcVd2U1pPTXBZNXhrZWdhcVU2akwyeTl1NkFVK21iczM4NzJBeUgx?=
 =?utf-8?B?N1Z2TXhoVWJtRTd5bk10a1M5MU50azU1aGwweTF5dElRZjJyRUdEWk5uQk5q?=
 =?utf-8?B?RnNpR1I3SS9OMU5Ha01YeGg5ZzZJRHFYcXRFR1IwT1hITTRQcnUyL1EvbjVZ?=
 =?utf-8?B?RDBjcmtYbklnM2toQ1dFL2RmRzlZemRPVndrU1RvajdkZjVZRkNleHM2NWY2?=
 =?utf-8?B?TDJGZlRWSjBKWnlzTlNBRDZiRnhRRU1rNWxQaFlnMFVEYkFWQnkwMU1EaXFt?=
 =?utf-8?B?QUpJNldjcE5BWHhIZlZYTFFWRGtYTmc3c1pCRXcvZWhJbXNmTjF5UEZsd2p3?=
 =?utf-8?B?UFdtbHlRT3FQemtSY0lTSnJzL2M0TTBPd29ybEgrcVdHTjMwSHFZUkphQjht?=
 =?utf-8?B?bkZnZzgwR1dxcWYwL0wxdGFPK3lGUUl3eWExNGJyUVhjMXYyY0FGdkZUUFda?=
 =?utf-8?B?ZlArc1Bld2NzcWVaOS94NzhqK1NJbEdDaE9zK21iL293SjFndGxacGdPbXQ2?=
 =?utf-8?B?WkgxNEtidXVMK0ZvTnBEY0s3VnZvN1pSOFhpUWhvak1IRGQvYUp3SktYWnN5?=
 =?utf-8?B?Z29EUnlNemp5VE5uNTQ4ZTZOcUVDcU83MmRZWCtBbkNTWWxDUHVZYTBqUkdP?=
 =?utf-8?B?UXVyZ041QnRzZmIxeWsvNitFTklGK2ZkZGV1cGQraGl1OG1vN2lxMm1ha3dM?=
 =?utf-8?B?L1F2cndDSnhVSmZiRmtsV1lLaU9IbkY3WmFEL1VCVHdPS0JNSlY5SHNweE04?=
 =?utf-8?B?RnlOVy9qVXNHd3BLNzJ2Rk00ZkhyZWQ2V3VRemc0bWRMQWI0blM4WCtLSGFF?=
 =?utf-8?B?NnRZbjZVaTRGZ0lyMzU0OVYweUdBQTY4RnFXYU1WTzgxOUd3SnVFVFdUNVB3?=
 =?utf-8?B?UjBUbzRhbVJ2VmJYb1M3VW95bWJnbDU4bFFRZ0cyS1I5SlZNQkNJUVVVdTlp?=
 =?utf-8?Q?q15FFNOUgFsGe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldjTVV2QWpGL0hoeDRHS09MM1NXNGh2VktwOGRhYUZVUHVNcUFqK2FtcHJF?=
 =?utf-8?B?eVI0YzhYSmIrNDJjOUxBdldrU2tWbEdNcDMwSlB2cFRiOTZXV3JjeWpkeDQ0?=
 =?utf-8?B?ZElRa092OWw4Ukt0SUc1Ti96azhuTUhnK2pvK3djMnRGVzRjdFphMnJpQWVG?=
 =?utf-8?B?UHpFUjJ4amQ1dmkxZzA3WFlWSEorQUU3bXQ0dGtNOHRpT1hrKzJ5WjZtalRh?=
 =?utf-8?B?RmlHK1VEcmh4WGN5OCtHSU1pa0svVkpWRkRnM2F4TFFSQmtKU0lHdng0aE84?=
 =?utf-8?B?S0RiY1Y5cTIwcXdCMkY3NUFsRjVCNFFYTjNtaHRRbFhGRVduNm1lVXcwczR5?=
 =?utf-8?B?a2R5NTE2aE8ydmJuTmViY2NJMHZHTWdtcHJyMllKaGJZajFmSzZqRlBNNnVv?=
 =?utf-8?B?UDdPeEFpdlFZU0ZRVTNLRkJhK1A3NjdSR1dxZTZaaWthOTNEQ3hiVUFBVW1E?=
 =?utf-8?B?RFM0bEV1eWRacFg2QUlEY1FYWnVZV3dxOHB4Y2d0QmIzRk1ZUzBhZDZTdlkx?=
 =?utf-8?B?ZHpCdzNNWlY0bTlJWGdVU0MvczMzRFF6ejBCMnJNMlFyQnppNHoxT3hpTjE5?=
 =?utf-8?B?V0UyaHFmTDhqeml3T0RpOVh5KzdEa1Q3M0dmMEJhV1FpNW1QYUh0Z2hsL2FI?=
 =?utf-8?B?R2VkZ08wUGRmZ2p3ODI5dGNvcno4TE5lbkdWYjdjcEhDNTJTdlZiOWxGbEFT?=
 =?utf-8?B?eDlBZEVraHUrL0luYUNWT1VjRHhRQitPQVo1WWVvWGMxSTJOTlQ1MWE2L2pZ?=
 =?utf-8?B?eFlWN1FISkx0clJ6blc1dEZFdkYzMWFCamIzcVZaZnBneHBWc09VVVlDSjJw?=
 =?utf-8?B?OWg1RDl6RjlNRkpYNDlFeUtOSTNkQnQ5WDRjdmY5U0ErSVZNSTN4RDg5UDNs?=
 =?utf-8?B?ajErS2lVNE1iRWQzVGpwaUlUdVZuR3RraloxMlJ2eEdTRFNiVnhMTzlJZXdY?=
 =?utf-8?B?Qk03aUhFS0lBUndNUmoyZjNXN0R1RnErSStWQS8zTVYyTHlIMnliOGJ4cmVH?=
 =?utf-8?B?RDd5TldBb3dpbnZTejlwSEZMNzVXY1ZyeC9LTDJXeUxENVc1ZUUyQkwxSHFx?=
 =?utf-8?B?RHZ2cUdvQk9pSTZtWk55VnFmZW80ZmNwTTBDV0c1ZzlHTnBCSTVhSU9OdExP?=
 =?utf-8?B?R0dqdS8vTnh3N2ovaXNYMGRDMzlCNHBsVDZGN0J4VXd6d2lEa2wwMkg3NVNy?=
 =?utf-8?B?ZisrVGQxT040WGpvZFRpdDdJZTMrb0FBYWlORWNoQ3VEUEVuNU5yRG9kc3ZL?=
 =?utf-8?B?amxSR0M3OEIyOHB4SDdKYWtzd0ZsdkJjSDN6NWVxWS9LWVhUSmxvN1VuRlZT?=
 =?utf-8?B?R2t1aWNIbE84djlLTi9rTHpZZFpzd2g5YWszN3YyejB2NDM0M1V5MzNSK3NY?=
 =?utf-8?B?ZTZpZ1JFVVNYblRuVllkYWFvRmVHZU0wUU11ZitkbWxTNlFWR2JHWjJYTTBv?=
 =?utf-8?B?SFhlOHJVdmxTQkJNTUxFelFockVSL2dUZGcyY1RZeitNSjZFS2p5UXZScEU2?=
 =?utf-8?B?Y1dhOEx4V3UxWE9UVGNrWXdDcVFHSk5POWRDN2pLWitrZnZtVEhvcml2TWcw?=
 =?utf-8?B?bmYrSE5CVDRsQ3BFTjZXMzF0T1lYQ3JiWUQwcmV4ZmdHUmJyZXlkZXdtbndP?=
 =?utf-8?B?enlTUGZqanRSV1I3R3Z2WVdqb1hNS1YxbWw2aVJCNEdZeXRQelBBS0VyM3RL?=
 =?utf-8?B?ckdzODhvMDE2eUM5TStRRHhVc2Fad2VTL3oyYVczRWUzdjJ2U2ZvWHlZc0lk?=
 =?utf-8?B?K0ZlME84ZzZqUHA4dlNCdDhuaERrSlNLbkZ6QXc4NXJGN1ord0ErZEp4K0or?=
 =?utf-8?B?ZHplbHVhMzN0MGtNdnAwZ2JkZENZbGQvNE53L2I2UHdzLzhiRW94NUg2bnpz?=
 =?utf-8?B?cDgzQlZueXJHZ21paE9yamdocENUZzhxbEgrN1VlS2ZtVFR5aEFXQk44cUdX?=
 =?utf-8?B?VSt2SzNDRzEzem9BZlAyc0pGZ0ZuL3J1Tmx2aWZpSzc5Ri9Cb1kyNHBsTmQ0?=
 =?utf-8?B?SDdSVjFsYTlHd1pzd2MzK05MYTRVVXF5S2psaVhqUXJ6ODJEUGFmYWpVQWF2?=
 =?utf-8?B?YVhHVnYyaEIwNG8rSzZWb3l2Y2dsZk9wVVJBUXZ0SDUrT0NUMnlrYzJ5UVVE?=
 =?utf-8?Q?nzoYugtKlezWbjSY5wivVQUj5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6529580a-8b14-45ae-2420-08dd31c87d0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 22:45:31.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN5/kdC+c7Bsg8uHWDsVt+R8N7tvv8KfVrIEaWXpsuqpx+vPBAznM4MA4PnkbNpT+Rcw8WLYPjoWg8c4/oTtZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477

On 1/10/2025 11:26 AM, Sean Anderson wrote:
> 
> In preparation for adaptive IRQ coalescing, we first need to support
> adjusting the settings at runtime. The existing code doesn't require any
> locking because
> 
> - dma_start is the only function that modifies rx/tx_dma_cr. It is
>    always called with IRQs and NAPI disabled, so nothing else is touching
>    the hardware.
> - The IRQs don't race with poll, since the latter is a softirq.
> - The IRQs don't race with dma_stop since they both just clear the
>    control registers.
> - dma_stop doesn't race with poll since the former is called with NAPI
>    disabled.
> 
> However, once we introduce another function that modifies rx/tx_dma_cr,
> we need to have some locking to prevent races. Introduce two locks to
> protect these variables and their registers.
> 
> The control register values are now generated where the coalescing
> settings are set. Converting coalescing settings to control register
> values may require sleeping because of clk_get_rate. However, the
> read/modify/write of the control registers themselves can't sleep
> because it needs to happen in IRQ context. By pre-calculating the
> control register values, we avoid introducing an additional mutex.
> 
> Since axienet_dma_start writes the control settings when it runs, we
> don't bother updating the CR registers when rx/tx_dma_started is false.
> This prevents any issues from writing to the control registers in the
> middle of a reset sequence.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
> 
> Changes in v3:
> - Move spin (un)locking in IRQs inside the if condition of
>    napi_schedule_prep. This lets us hold the lock just for the rmw.
> - Fix function name in doc comments for axienet_update_coalesce_rx/tx
> 
> Changes in v2:
> - Don't use spin_lock_irqsave when we know the context
> - Split the CR calculation refactor from runtime coalesce settings
>    adjustment support for easier review.
> - Have axienet_update_coalesce_rx/tx take the cr value/mask instead of
>    calculating it with axienet_calc_cr. This will make it easier to add
>    partial updates in the next few commits.
> - Split off CR calculation merging into another patch
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet.h  |   8 ++
>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 134 +++++++++++++++---
>   2 files changed, 119 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 8fd3b45ef6aa..6b8e550c2155 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -484,7 +484,9 @@ struct skbuf_dma_descriptor {
>    * @regs:      Base address for the axienet_local device address space
>    * @dma_regs:  Base address for the axidma device address space
>    * @napi_rx:   NAPI RX control structure
> + * @rx_cr_lock: Lock protecting @rx_dma_cr, its register, and @rx_dma_started
>    * @rx_dma_cr:  Nominal content of RX DMA control register
> + * @rx_dma_started: Set when RX DMA is started
>    * @rx_bd_v:   Virtual address of the RX buffer descriptor ring
>    * @rx_bd_p:   Physical address(start address) of the RX buffer descr. ring
>    * @rx_bd_num: Size of RX buffer descriptor ring
> @@ -494,7 +496,9 @@ struct skbuf_dma_descriptor {
>    * @rx_bytes:  RX byte count for statistics
>    * @rx_stat_sync: Synchronization object for RX stats
>    * @napi_tx:   NAPI TX control structure
> + * @tx_cr_lock: Lock protecting @tx_dma_cr, its register, and @tx_dma_started
>    * @tx_dma_cr:  Nominal content of TX DMA control register
> + * @tx_dma_started: Set when TX DMA is started
>    * @tx_bd_v:   Virtual address of the TX buffer descriptor ring
>    * @tx_bd_p:   Physical address(start address) of the TX buffer descr. ring
>    * @tx_bd_num: Size of TX buffer descriptor ring
> @@ -566,7 +570,9 @@ struct axienet_local {
>          void __iomem *dma_regs;
> 
>          struct napi_struct napi_rx;
> +       spinlock_t rx_cr_lock;
>          u32 rx_dma_cr;
> +       bool rx_dma_started;
>          struct axidma_bd *rx_bd_v;
>          dma_addr_t rx_bd_p;
>          u32 rx_bd_num;
> @@ -576,7 +582,9 @@ struct axienet_local {
>          struct u64_stats_sync rx_stat_sync;
> 
>          struct napi_struct napi_tx;
> +       spinlock_t tx_cr_lock;
>          u32 tx_dma_cr;
> +       bool tx_dma_started;
>          struct axidma_bd *tx_bd_v;
>          dma_addr_t tx_bd_p;
>          u32 tx_bd_num;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 961c9c9e5e18..e00759012894 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -266,16 +266,12 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
>    */
>   static void axienet_dma_start(struct axienet_local *lp)
>   {
> +       spin_lock_irq(&lp->rx_cr_lock);
> +
>          /* Start updating the Rx channel control register */
> -       lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
> -                                       lp->coalesce_usec_rx);
> +       lp->rx_dma_cr &= ~XAXIDMA_CR_RUNSTOP_MASK;
>          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
> 
> -       /* Start updating the Tx channel control register */
> -       lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
> -                                       lp->coalesce_usec_tx);
> -       axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
> -
>          /* Populate the tail pointer and bring the Rx Axi DMA engine out of
>           * halted state. This will make the Rx side ready for reception.
>           */
> @@ -284,6 +280,14 @@ static void axienet_dma_start(struct axienet_local *lp)
>          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>          axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
>                               (sizeof(*lp->rx_bd_v) * (lp->rx_bd_num - 1)));
> +       lp->rx_dma_started = true;
> +
> +       spin_unlock_irq(&lp->rx_cr_lock);
> +       spin_lock_irq(&lp->tx_cr_lock);
> +
> +       /* Start updating the Tx channel control register */
> +       lp->tx_dma_cr &= ~XAXIDMA_CR_RUNSTOP_MASK;
> +       axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
> 
>          /* Write to the RS (Run-stop) bit in the Tx channel control register.
>           * Tx channel is now ready to run. But only after we write to the
> @@ -292,6 +296,9 @@ static void axienet_dma_start(struct axienet_local *lp)
>          axienet_dma_out_addr(lp, XAXIDMA_TX_CDESC_OFFSET, lp->tx_bd_p);
>          lp->tx_dma_cr |= XAXIDMA_CR_RUNSTOP_MASK;
>          axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
> +       lp->tx_dma_started = true;
> +
> +       spin_unlock_irq(&lp->tx_cr_lock);
>   }
> 
>   /**
> @@ -627,14 +634,22 @@ static void axienet_dma_stop(struct axienet_local *lp)
>          int count;
>          u32 cr, sr;
> 
> -       cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
> -       cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
> +       spin_lock_irq(&lp->rx_cr_lock);
> +
> +       cr = lp->rx_dma_cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
>          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
> +       lp->rx_dma_started = false;
> +
> +       spin_unlock_irq(&lp->rx_cr_lock);
>          synchronize_irq(lp->rx_irq);
> 
> -       cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
> -       cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
> +       spin_lock_irq(&lp->tx_cr_lock);
> +
> +       cr = lp->tx_dma_cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
>          axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
> +       lp->tx_dma_started = false;
> +
> +       spin_unlock_irq(&lp->tx_cr_lock);
>          synchronize_irq(lp->tx_irq);
> 
>          /* Give DMAs a chance to halt gracefully */
> @@ -983,7 +998,9 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>                   * cause an immediate interrupt if any TX packets are
>                   * already pending.
>                   */
> +               spin_lock_irq(&lp->tx_cr_lock);
>                  axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
> +               spin_unlock_irq(&lp->tx_cr_lock);
>          }
>          return packets;
>   }
> @@ -1249,7 +1266,9 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
>                   * cause an immediate interrupt if any RX packets are
>                   * already pending.
>                   */
> +               spin_lock_irq(&lp->rx_cr_lock);
>                  axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
> +               spin_unlock_irq(&lp->rx_cr_lock);
>          }
>          return packets;
>   }
> @@ -1287,11 +1306,14 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
>                  /* Disable further TX completion interrupts and schedule
>                   * NAPI to handle the completions.
>                   */
> -               u32 cr = lp->tx_dma_cr;
> -
> -               cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
>                  if (napi_schedule_prep(&lp->napi_tx)) {
> +                       u32 cr;
> +
> +                       spin_lock(&lp->tx_cr_lock);
> +                       cr = lp->tx_dma_cr;
> +                       cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
>                          axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
> +                       spin_unlock(&lp->tx_cr_lock);
>                          __napi_schedule(&lp->napi_tx);
>                  }
>          }
> @@ -1332,11 +1354,15 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
>                  /* Disable further RX completion interrupts and schedule
>                   * NAPI receive.
>                   */
> -               u32 cr = lp->rx_dma_cr;
> -
> -               cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
>                  if (napi_schedule_prep(&lp->napi_rx)) {
> +                       u32 cr;
> +
> +                       spin_lock(&lp->rx_cr_lock);
> +                       cr = lp->rx_dma_cr;
> +                       cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
>                          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
> +                       spin_unlock(&lp->rx_cr_lock);
> +
>                          __napi_schedule(&lp->napi_rx);
>                  }
>          }
> @@ -2002,6 +2028,62 @@ axienet_ethtools_set_pauseparam(struct net_device *ndev,
>          return phylink_ethtool_set_pauseparam(lp->phylink, epauseparm);
>   }
> 
> +/**
> + * axienet_update_coalesce_rx() - Set RX CR
> + * @lp: Device private data
> + * @cr: Value to write to the RX CR
> + * @mask: Bits to set from @cr
> + */
> +static void axienet_update_coalesce_rx(struct axienet_local *lp, u32 cr,
> +                                      u32 mask)
> +{
> +       spin_lock_irq(&lp->rx_cr_lock);
> +       lp->rx_dma_cr &= ~mask;
> +       lp->rx_dma_cr |= cr;
> +       /* If DMA isn't started, then the settings will be applied the next
> +        * time dma_start() is called.
> +        */
> +       if (lp->rx_dma_started) {
> +               u32 reg = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
> +
> +               /* Don't enable IRQs if they are disabled by NAPI */
> +               if (reg & XAXIDMA_IRQ_ALL_MASK)
> +                       cr = lp->rx_dma_cr;
> +               else
> +                       cr = lp->rx_dma_cr & ~XAXIDMA_IRQ_ALL_MASK;
> +               axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
> +       }
> +       spin_unlock_irq(&lp->rx_cr_lock);
> +}
> +
> +/**
> + * axienet_update_coalesce_tx() - Set TX CR
> + * @lp: Device private data
> + * @cr: Value to write to the TX CR
> + * @mask: Bits to set from @cr
> + */
> +static void axienet_update_coalesce_tx(struct axienet_local *lp, u32 cr,
> +                                      u32 mask)
> +{
> +       spin_lock_irq(&lp->tx_cr_lock);
> +       lp->tx_dma_cr &= ~mask;
> +       lp->tx_dma_cr |= cr;
> +       /* If DMA isn't started, then the settings will be applied the next
> +        * time dma_start() is called.
> +        */
> +       if (lp->tx_dma_started) {
> +               u32 reg = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
> +
> +               /* Don't enable IRQs if they are disabled by NAPI */
> +               if (reg & XAXIDMA_IRQ_ALL_MASK)
> +                       cr = lp->tx_dma_cr;
> +               else
> +                       cr = lp->tx_dma_cr & ~XAXIDMA_IRQ_ALL_MASK;
> +               axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
> +       }
> +       spin_unlock_irq(&lp->tx_cr_lock);
> +}
> +
>   /**
>    * axienet_ethtools_get_coalesce - Get DMA interrupt coalescing count.
>    * @ndev:      Pointer to net_device structure
> @@ -2050,12 +2132,7 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>                                struct netlink_ext_ack *extack)
>   {
>          struct axienet_local *lp = netdev_priv(ndev);
> -
> -       if (netif_running(ndev)) {
> -               NL_SET_ERR_MSG(extack,
> -                              "Please stop netif before applying configuration");
> -               return -EBUSY;
> -       }
> +       u32 cr;
> 
>          if (ecoalesce->rx_max_coalesced_frames > 255 ||
>              ecoalesce->tx_max_coalesced_frames > 255) {
> @@ -2083,6 +2160,11 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>          lp->coalesce_count_tx = ecoalesce->tx_max_coalesced_frames;
>          lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
> 
> +       cr = axienet_calc_cr(lp, lp->coalesce_count_rx, lp->coalesce_usec_rx);
> +       axienet_update_coalesce_rx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
> +
> +       cr = axienet_calc_cr(lp, lp->coalesce_count_tx, lp->coalesce_usec_tx);
> +       axienet_update_coalesce_tx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
>          return 0;
>   }
> 
> @@ -2861,10 +2943,16 @@ static int axienet_probe(struct platform_device *pdev)
>                  axienet_set_mac_address(ndev, NULL);
>          }
> 
> +       spin_lock_init(&lp->rx_cr_lock);
> +       spin_lock_init(&lp->tx_cr_lock);
>          lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
>          lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
>          lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
>          lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
> +       lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
> +                                       lp->coalesce_usec_rx);
> +       lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
> +                                       lp->coalesce_usec_tx);
> 
>          ret = axienet_mdio_setup(lp);
>          if (ret)
> --
> 2.35.1.1320.gc452695387.dirty
> 


