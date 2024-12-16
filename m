Return-Path: <netdev+bounces-152411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB39F3D7E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FED0169155
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9391D63E8;
	Mon, 16 Dec 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="MoOfHjrD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC91D517E;
	Mon, 16 Dec 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734388164; cv=fail; b=SpwBudaI7yOtDithP7Y2qOl0r8e+FtKvBMk2aIsw93VMlKt6pyXo2BKBstNGHM4WbuMdJpH4etMwPtFFRxyAGu/k+fAW/64NhOAqnJ8P7uJZfsbJx8RvgjfweufScnoMhp9C9Ci8l8ydXns08neE4q85yHmDRTwyrhC9FmI773o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734388164; c=relaxed/simple;
	bh=ErUnk6ew1A+IB0je4y1q+zVD6h7fmHapgdD6S37hk9Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VB1Bw/NryP+PZmZolCwWc/6J+oI9TEQuNx8zu6NuRb5Lsy3h7x/8cn4WGY0z3qDofP/wieMuHMlNfj+d3m8RpFHhvya5fOqbgSwzGIx9P3w7T6VSnEY8BPV2m/9SXgXIlMkJLtG5lQ3xn6zgcsuBfUTLpRPrTQrS2CL+eZwlkjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=MoOfHjrD reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynr6Ah5cvkWmNrrr2/lwseVLoy33F1SSdpj6VjZHn6WbeusYbsZ4DihvpkmM+hP+p4bG9/sV4EAdF2ESqV3EUSWEgYWIayFenW8nu5WGuisF2CvxG85f4FLluQAh25Td8IZ3d8VdvSFUMiRyokfhxyOw5NlbyWrZBNIYQxHMykx0nWDRRKHFQLLhzZ2uU2e4Xv5txpbeTPfYlO8oCCYLVjqwICM4b970421KFnrVZFyWg8JWneCKm/ILRdAZkz8P+bl6gIdOsE2zBUNwYJibT5Af97zNiX3fsrOH0XLc+F7sDSZipGNAB+YoeCejHzhmWSZ2dG43u5Yqw3DaY+zxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6CAgh03vxllXbjkZxTrKRaEq4Y1OO8OaRV9vR+AbRw=;
 b=hV0SMQzhdQORXZ+MxVtLAAv/KRW1MzsfGDiiiq/cPwyjrF3M5xH4TDdo24HEi7EGt3wlG978rzWAZbfDba/qrhH0mkB7pLjQ0QTGX4FKr0hTem7DRJSwz/+Mm8mMUce0sXHSeiZzGn59ky0gSzWplgB1m5HeveRFbQTLB+ullK8ryyOb+RneB8VoJVjBFfV+KVzgWJYip7hEdDdY1nTvY4Y9dW8yNI9RJjexxYrwpi4RfxopmeOdiFYm/LFNaWod9bbdCVyv3v7JOEK5dnH5m5oQ8Cf/Ftbxn0M0ve+hZz1wYirXVJjni64Mlj7Mfb1w1K4/Pdlj2SruaA2nSB42Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6CAgh03vxllXbjkZxTrKRaEq4Y1OO8OaRV9vR+AbRw=;
 b=MoOfHjrDyPOinh+yRDYKkHMlv2/UIi2ww268kThhDYeuq+b50+Jd9RukFHqD6gunqhUMCCc6Qm8AGnCTtOPztVbq9emxKwynxjYzK5UUrY0NR2JPQMRnYwDVax5dB7BFVm3tmdxYAkDlrLFUXueMejJbdQ+a2a5uU5lZg1D+tHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from MW4PR01MB6163.prod.exchangelabs.com (2603:10b6:303:71::9) by
 SA6PR01MB8976.prod.exchangelabs.com (2603:10b6:806:42a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Mon, 16 Dec 2024 22:29:18 +0000
Received: from MW4PR01MB6163.prod.exchangelabs.com
 ([fe80::c474:10df:672a:55d7]) by MW4PR01MB6163.prod.exchangelabs.com
 ([fe80::c474:10df:672a:55d7%6]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 22:29:18 +0000
Message-ID: <1e7bacaf-3dee-4c95-9618-07b1dd253509@amperemail.onmicrosoft.com>
Date: Mon, 16 Dec 2024 17:29:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Joe Damato <jdamato@fastly.com>, admiyo@os.amperecomputing.com,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
 <20241120190216.425715-3-admiyo@os.amperecomputing.com>
 <Zz-AvBwUgNzMJb7-@LQ3V64L9R2>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <Zz-AvBwUgNzMJb7-@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To MW4PR01MB6163.prod.exchangelabs.com (2603:10b6:303:71::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6163:EE_|SA6PR01MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 23637a4e-3f89-4ff4-1bd0-08dd1e21143f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWVoaC9kUkNDZ29vdzh0SS84NDNqS1YvUU9OY0I0NHQ3aWp2MTMzTzcxdmk0?=
 =?utf-8?B?M1RqWlJlaUxLamJmNzlvaGpLcTFQK2JzRTJUMXhtVCs0T1ZadXNlV2MxTjN6?=
 =?utf-8?B?RWxwbER2TmdqdnZZc1d6T3RzYmxrMjBLYnFFRmFkOG45MHM0VHhRWnZCQ1Bk?=
 =?utf-8?B?Q3RYSXdWSWVUbW9MWXRsNFBBSHFaV0pmUDkvSm9ISXJxbmxoSy91cUwzcVFh?=
 =?utf-8?B?Um9UeENydGF1ekdIb1BJWE9RVEl2YndBVHQrUVMxRmJCZXRkZGI4YXRuVW10?=
 =?utf-8?B?WW9Ud3dRREFxN0hUaTM2cWJ5bnJPUEVmTTJZUTJuY3p0eXlheUZUcFpjMzVa?=
 =?utf-8?B?cnlZc1RZdHp0QkZZcXRBMlRyT3lSRWF4UnpOcFBVdFpwRXNwaW8rc2pYSndR?=
 =?utf-8?B?MDl0V1VHQUpUUFB3eXNBWkJReFpISnJnZTM2cXdpNGJmYkxnRVpOMXJNcGZK?=
 =?utf-8?B?TC9jY2lFZWpaSEpBTk5vL1FJQS84NWFiV3JGWjhEZWdXdUhGTXRLNWhveTBh?=
 =?utf-8?B?Z09vQnhNZTNzVFlDK2RPcmQ3MUd5UFRKaEJoL0pOTzJpRzFuS2Uxa21JdzBW?=
 =?utf-8?B?RElLOVI1bnIyMW9zWXkwcFpoaG9FTTBmNmxPQkh4Y3FxMExGREtrdEdNclVs?=
 =?utf-8?B?b1dSdjNjSk5rSTdQdjZOOTNGbm1td3J3QmRXa24vL094alZJOTVSMDRjUGps?=
 =?utf-8?B?Um5kU2FUTU9Hc0hscWo1aTZ5TXJic1BKRGdmQlZMcnRkN2YvalV2OWJkcDNL?=
 =?utf-8?B?STRDUWcyV1Jick4xdFh0NG10UlVmdlRFU3pSQ003WHo4Rm5MeC85c3hrL2pl?=
 =?utf-8?B?dmVvOFI1L2RRbSswQXAxdld4ekRNM0R0dWlGT2liY293LzEyNTRIcFh3QkVY?=
 =?utf-8?B?cXBZWTdrWHFuMS9HQVlyZ2VHaFVvbUNVVitPTXdiL2dMeTJtVUV2WGZ1QjJ6?=
 =?utf-8?B?VjBYWmJCZms2blhVM0hqRXBTSDNFYWtraUREbmlLdXh5R01qdUhUdlYxaEZK?=
 =?utf-8?B?L0pQWmdlR09VeWRRS21NcDRuTlZ4U3R2dk1FYkJodVdGRlFOdjZ6cEFLTXl2?=
 =?utf-8?B?MXNTZjdRMmJoNzA0N1RlYmRid21GSDhZVG9ITjFyWmczbDRobWJWenhBekx0?=
 =?utf-8?B?Ly9HMTVlb2xrQTA2cUR3RGxoK0t4eWpneExDSlJjaTkwU1ZZZWxEeXVOb3N6?=
 =?utf-8?B?NHVEZG8vbWo5ZmYrRTA5QmdVVHFQMjhad3UwMU1uM0syckZSSFgrcmxidUVP?=
 =?utf-8?B?K1pXZHp6YXNhcmdhVExTb1JKTkk0SDBSeUZxS01FWi91NEFNWmdUR1J4ZFor?=
 =?utf-8?B?eVFkQWJ5TGlOL21KNjBNZ2hNbGo1WnNLY2FRU05kbWttNGxyUVRabDVELzEv?=
 =?utf-8?B?VTRZT0hzdWxQZ2h5L1J4VHE4aG5HRmZLRDViT2h3SklQaDk5UkFpYmpSOXRR?=
 =?utf-8?B?ckVRa2RSVVNvTDM1OEZzQjZpMENuRzYxOFlXVVhEaXBZSHNFbkE2R3ZQVzI4?=
 =?utf-8?B?Q3lQbHJtR0pabXVoMVVNUW5iRWJ0TFEreDM2cXRzcWVRM3VKVHl0ZjhUMG1m?=
 =?utf-8?B?ck84d0xQZzVTcmFFSHZXRkt0U0ViMDdKdHZKQ05iS2tqRzFVWGRGU1NsS0VD?=
 =?utf-8?B?Y2d6TVY1WXE5NmExeXNlejJhQVNaQTI1NzVKUlBvRnZCZ0k1S0tuUTA3dlAx?=
 =?utf-8?B?VU5LSlkzY1VJWmxoQzl6blFSSElHcHR5emxOMnBYbVlxSlMvbFAzU2dIbG8w?=
 =?utf-8?B?OUJKUWgzQWR5VDVjUkxnZlFQWE5JK3NwOEdmUUl4V2luTC9weHl0L2Q2OW1l?=
 =?utf-8?B?RW1aenNpMlByU2FOKytQeHRPK0RlSU1TaXpDWmY0SWJvOTFJeVFJSFFLYzNC?=
 =?utf-8?Q?6QEmxcQ1cpxhu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6163.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MllqNWxFVUsvK3RnOGpob0xQK2FoeWJTVlFsZHlja1dMbmNTRXJrbTBsb1BE?=
 =?utf-8?B?NFY5RVZoTTZIdk94d3llL0x2RWZTdUcrUHVkTEtYU2s1WllPYXlHUXNTNUZ2?=
 =?utf-8?B?VXd5OUMxdFBHY0JNcVB5cHZSbTZobjUzaWFkOExyWEF3MjlKUG1uSUIyd2Fj?=
 =?utf-8?B?NkFLMmJlZUYzekxPd2ZVRUpCUGI2ODhZbEtmNVk3Nk02YktCZkVzeVV3WGNt?=
 =?utf-8?B?VUNCV0UrMW1XdmlCTkwzZDJuM3RqbjBuNVpCNnRFelhtUUJudjVBZGlsRXh4?=
 =?utf-8?B?R1RVN1RCb3hCSEtkV0VXQnl6YzRmbmU5RUFFcWtKT3BDOFF6K3hNUUFwcFpx?=
 =?utf-8?B?c1JnTDA1eU1JQWpaZjBQWHphZU9OOFN4bS8zVzFPb3RHODBOYnBQTWgwYXIx?=
 =?utf-8?B?NUtoM1BVWklHMjRkY2IxcEN0cTBnSXFnaGJyRStpcDgzOGxhMEJtWXVDQTZT?=
 =?utf-8?B?MHkvWGZIalJFSm1ROUtMUUhzZnBxS0prVE5sZXdQemJFS0I4YitVQ1lLVUJ0?=
 =?utf-8?B?cTUxMC80Qi8yalZCbG1WeDJLLzBzU3FsTnI0bERFM0x6YTlrd00vTjdPQTBQ?=
 =?utf-8?B?aWZ4MnNJNW5LM2dvOWJYS2ozUlhGVlFLQVFPQnlPUjQ2TEtOdmxaY3BiNmRt?=
 =?utf-8?B?Vy93eTVwK1R0ZTE1NndJNHdtNjA1QWVnUjZCSGNheC9pVjduV21HY1ZEclJm?=
 =?utf-8?B?aDAwaENYTG9tUnNUZG9ZNVBtc0RTT0RKcGlISEo4Zk94eUFaN05RUENGVUlV?=
 =?utf-8?B?STh2MW5SQ0xuTXQ1U2x0UTJpNkVaMytteks3Q3BUSG5qbStvMjJZMjNCWnhs?=
 =?utf-8?B?SnQ5OFJSVFZ2LzlwTStVTmVlN2luVEdvOFV0MDQvNTdRSTZYQVhmMEN1U3dO?=
 =?utf-8?B?eGRrZmRPZGR0YnFyVzNZc3FkYThlMG5kUWhCcVZyNjk2ZGlqT0dWSzNsME8r?=
 =?utf-8?B?T2dVdjlEQVN6UWRLTWUrQjVvOFZTRGxQUFYyNGtqREUwK3RrTTB4Y2hvUXlB?=
 =?utf-8?B?Y3p5SzVqSkxQc1V2c0p4M3VYWnZMZ0xCc0NvZDRyNGpyek9PY2cwUE4yV0w2?=
 =?utf-8?B?WC9RZUpGMnV2YjA1Z3lvcktCbjFacUYrYmJYa3orc0hTZ0VCdlFRWEZZVm9R?=
 =?utf-8?B?Q3MwOG1Fb09FNlNSQ2taWXVNY2V5QmZMTXJueFNNUDVUaTJGNi9pV0pLMjdS?=
 =?utf-8?B?TWFIZGxmSCtHbmF3VGhmc0I3K2lKbHRVdVBhcXNtL2p2Zm1NMEw0cGJiZXJr?=
 =?utf-8?B?bW1IR2hhMnZSUTlNMDNSMmlNaU9lMTdaZWdxV0M0aEljV3hvTFluMm4rdEFm?=
 =?utf-8?B?N2Z0WE9CZE9yS3doUXJNYTJyTnJYalM3cjlsaW0vSmE3TEk5Q1VGOW5DZWdk?=
 =?utf-8?B?WnkyVHBuektkSWxhV1RBaVFKSmYzOUJzTEx6MHFvQ2FLZ2lFNmpQT2w0S2Ri?=
 =?utf-8?B?UW45dzhtZktrYUhmdEZ6blJjM3JtVldoZUhUYkRrUHNRRDFrNDNTUVJFUmxZ?=
 =?utf-8?B?ZGUxWUN6MWhDQjA3UzY0dGZ3MUpnNjIrREVIMW9uMFU5cWdxbm0zK1FVOUtL?=
 =?utf-8?B?aStwbzVqdVgwNG14UnBWS0REMHgwZU5JazlvWWt2V2JpZUNheGNOMDhmUW16?=
 =?utf-8?B?Y1YwUmF4OEREWFZYZW96MnBkNmF0Q1RIaHoxK3pXeEhZTENBK0Q0VnNINDBx?=
 =?utf-8?B?aWF4UVNyamJrcno1OVJrd0hnQjI3MGtHaFlzVkVSZThva3Avd1FNVmZxU1pD?=
 =?utf-8?B?cEZvcjdsRVZyVUVGUVoycDhUdmZjZHdnR21nY2FBbzNJbG5tTWlQSTVMRjU4?=
 =?utf-8?B?VWNsVUwwWVF0R1JwOVd2U09qYXhRUWNrQjg1alpsdlBTb2J3c2R4UTkwalJY?=
 =?utf-8?B?SjhpZVgxMzh0RWoxN2taSzJXaDFTaW9Jd0VGVURHelFpOXBWdlBPVGlvbFcr?=
 =?utf-8?B?Sk5lKzdmWDd0eDhqMzFURVk0VDNaMFVTaU1kZDVCRXpyTXc1NmpHZU1qcXJH?=
 =?utf-8?B?Y0Q0bWJ1ZkZXalE3bUpaSkNLTS9MTHhvVGxLd1BlYWUyazdTTkhoMnhtQWNB?=
 =?utf-8?B?dEd2ajE0WndHTkNnUE1oc1RpYXo3UWNmWDVRazRIVlFxWWxOeFd0SVZZTWs4?=
 =?utf-8?B?dDNoZituYkNlVEZKS1JCaFB5U2Y4Rk9TSmJBK1o0NEdwb25ueHlvR1ZaaHpT?=
 =?utf-8?B?czEzeGN0TjBEdEo5c1pFN1drOXF0d0p3N1FzVlFNbW5xZTdHb1AxWWJPd1ky?=
 =?utf-8?Q?NDmMD3l940OdqrHTa2uXdOc8ZpuyJ2HTpa1U6yi7Zw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23637a4e-3f89-4ff4-1bd0-08dd1e21143f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6163.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 22:29:18.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCwf2C8uhAePR/LNkgt/YkyW1kXh4yogo96mTWD5jzKAlcrJ6Ec+etIb0ngYdhjg7mBIylcXs2ur5v0Lt4OW7viX4EcgwqLK86aqrXFWN0YcSr2vY4NHedSTlfT9EoTd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8976

After looking in to the helper functions that Jeremy suggested, I cannot 
say for certain if there is a way to record the length errors using 
those function.

On 11/21/24 13:49, Joe Damato wrote:
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_dev;
>> +	struct mctp_pcc_hdr mctp_pcc_hdr;
>> +	struct mctp_skb_cb *cb;
>> +	struct sk_buff *skb;
>> +	void *skb_buf;
>> +	u32 data_len;
>> +
>> +	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox.client);
>> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->inbox.chan->shmem,
>> +		      sizeof(struct mctp_pcc_hdr));
>> +	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
>> +
>> +	if (data_len > mctp_pcc_dev->mdev.dev->mtu) {
>> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
> I'm not an expert on rtnl stats, but maybe this should be
> accounted for as rx_length_errors ?
>
> And when rx_dropped is accounted in the stats callback it can add
> rx_length_errors in as well as setting rtnl_link_stats64's
> rx_length_errors?
>
> You've probably read this already, but just in case:
>
> https://docs.kernel.org/networking/statistics.html#struct-rtnl-link-stats64

The code will end up looking like this instead:

         dstats = this_cpu_ptr(mctp_pcc_ndev->mdev.dev->dstats);
         u64_stats_update_begin(&dstats->syncp);
         if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
                 u64_stats_inc(&dstats->rx_drops);
                 u64_stats_inc(&dstats->rx_drops);
                 u64_stats_update_end(&dstats->syncp);
                 return;
         }
         if (!skb) {
                 u64_stats_inc(&dstats->rx_drops);
                 u64_stats_update_end(&dstats->syncp);
                 return;
         }
         u64_stats_inc(&dstats->rx_packets);
         u64_stats_add(&dstats->rx_bytes, data_len);
         u64_stats_update_end(&dstats->syncp);

And the stats function gets dropped from

static const struct net_device_ops mctp_pcc_netdev_ops = {
         .ndo_start_xmit = mctp_pcc_tx,
};

So I think it is either/or using the heplers or setting the length 
error.  I am leaning toward using the helper functions.


