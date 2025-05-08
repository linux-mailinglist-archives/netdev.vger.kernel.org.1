Return-Path: <netdev+bounces-189099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C01AB05D8
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D33502474
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC5224AF9;
	Thu,  8 May 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kV9Dz2Z4"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304382163BD;
	Thu,  8 May 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742264; cv=fail; b=m6IIBf+9kDNs1DahLMdW67bBV9Mbdn/I3Rp5hlfG/tISBE6lo/waN97UVX1xUtqvVWsNF99H49vUW1a8hc9tkusecx5oRBTOPqEpaof5ncThRTztKRR+zEUEnUJcF73aIBlHIvR35Wq8ImLIx/pHVL5mu9VhhwPPEAZJYKrWeeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742264; c=relaxed/simple;
	bh=i987bSL9pFZ9BUWIZGwgN5GHmV/N8AFDp4+vTQMj6Y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JvfqwJi/y6fPqo0SCO3su6DcAmIwUkjFu1AVMiol5/4GPrRagdx3k+EINh5DOPlnQI3pTZV4oW+7aKaMSfEW9xyPjuyk72LnEsyZNrbDHZu/gWu1/KQ+WulLLIiZ4HO95bCLIUbgkxBDz0PMXK44wjT+JCO2yjlvNqZGUzHmPuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kV9Dz2Z4; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afPdyniD9BF9QgqaNny5+W1kb3zEDPt8FsiY8YfSEnosWD50Md/8WLDZvf3UoQdv5X6V+Krc40T4epjTOX/1gY24aK0pcJiAUPoQ9vXMOLDHOoqcIKPDTl3b4cY2ppGTzDKdhu9fcwBtSvJJYCir9yCKtRz1eqVsPa+0dcQVE7YEf8FCzbkNe3fbkqL9APTLaXiG9jYAzl+oKAGuxS9984Lp6u8m4wxoryk7Jdarj3EJoNeC5yEdcA5XY8qduGZMdwv8WF2XYmIUKE9XI6MkGlxq4q9vk8a4i0yGrLy0S9ZZB45UZBeLw1ctg5BvGBkLKFBskEQ7zq0jZ3+f7qC9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQMj9vmbRoV4IgOY9Afc9mLfkeAbHyR6RybWYxyTZPc=;
 b=uayZPiJYUO7BysLTKDViZ6DpN5CSQnc2xC71u5NOwGoooPdEFiOa+glSg1f7IRI0QrGuAf25XLT9xh9zRRd2d4Txv7ml2tw/YHjcmGLdV5rmTSUHTyolSaoHfVIy0cnfgC/BVuGWVDDKgMqcrbdxVWfwl7Y0TljEb9V7kvnSJIbQPM6YfBuu1SjIAYx+Aw8ZrXQgVFU24XtMGDDMEHBRjsmk6AkQoDtsSSCfbAdVs0GCB6PkY34o8qKyjEIngh4TPHVwiAwIBpjBzoSDS11eP5Mqq9s8kSAgWpYJLGjbxLcpqfGBDSalJ5kdQTo9WXxYrrbOSSBK0BjhTAf8A7kKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQMj9vmbRoV4IgOY9Afc9mLfkeAbHyR6RybWYxyTZPc=;
 b=kV9Dz2Z4Scoy0LMx6u7WHX70xd5t46Drz5jgGkjFXCJ3awgN6CARcqy75f7ZwttHMZR1Cs4vC+Q0fxI7C0qxqWp68r9crDyTnlj3qIugxq6mpG+vk72up8++yE42Ed5tz3Br+zlXtSx77j7Qs0BfOm3Y+hI4aXRixRyB1fJOetGzQLmWmAS4hANCGklLjnp32DhWTupG7SRBFkMsrB/GdULQU8FvWSRvLC9i49m2XQ6hXTISlJCTnQhbDAP8YifcrttPzuophmFc0dj1E6KafktBkfX1sLpjcPRyG1LNj+lGo4aer4zflmQEe/FIK99RJ1eSGoVPwS4otmN8p7FN+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM6PR03MB5052.namprd03.prod.outlook.com (2603:10b6:5:1f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 22:10:56 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 22:10:55 +0000
Message-ID: <efad3ebf-919f-4bc8-8e78-9ebb33efb305@altera.com>
Date: Thu, 8 May 2025 15:10:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND] clk: socfpga: agilex: add support for the Intel
 Agilex5
To: Stephen Boyd <sboyd@kernel.org>, dinguyen@kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, netdev@vger.kernel.org, richardcochran@gmail.com
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250417145238.31657-1-matthew.gerlach@altera.com>
 <1f9856930efce8b52f3abbc17fb4d3ca@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <1f9856930efce8b52f3abbc17fb4d3ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM6PR03MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 48319d7c-8295-4629-8501-08dd8e7d3462
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmxoUm91NFV2VGs1ajBKcDBrdG5UOWpQYjFnQy82TlNXUmxkR3NZWi9NVDRy?=
 =?utf-8?B?eWxJSGIwS2RzdGlEeWY4MmI1cFg3c0p2bW1CcXVkSDB2ZmxVWnZPb3NXTEV0?=
 =?utf-8?B?ZHFHaEdOcXk0ZUh6QnNVUDRFVmUxQU1pdy9CNi9Zdm5qYWNtb0lNQ2U1UGUr?=
 =?utf-8?B?OEp0bWE4MkY1b1Y2dlAxTm10RXJoZXMwUnpzZHJScThGNWFuUDZ4a1VkNlNY?=
 =?utf-8?B?VnFXR2cySkVsVWZxUzR1UVZqS1JGOEp0Q0pTZkpveXg3bTI0NG1xdU91STNN?=
 =?utf-8?B?U0hib0VnaU0rN2RnenNKL3V1WDRhN0JXZWVJb3BRZ3FudnlMMHlJNEllWmFG?=
 =?utf-8?B?RUVZTE90MU9DSG5UUVRBKzRxeUNFZUtCcEd4dVllbFE1dDNKbHNtUDdNYllM?=
 =?utf-8?B?MVFmcmpxRzdYN1lwNHRiSEwvYytrK250blZvTEVvdVhvUmo5VlZhUTFSdFpk?=
 =?utf-8?B?UFV1YXMzb1RQSmU3S2x5cWZxdlNZaUtkNUt5RTRQV2EzZS9RQmN2cWg5bkhL?=
 =?utf-8?B?emxIcnN5c1hhRXpRelVCbk5jam5DWEpGc2RGVVNWaTB5TFFrQVhyekdWdDhJ?=
 =?utf-8?B?SjU5dmdGV3lMYmhXa3dzVWlhSDNYM0NGNllsY09nNU13N1NnbjZXSTBqb3hK?=
 =?utf-8?B?QkUzRlJTRnMxVFdKcFlsYXd5K1FuRENlY3hZbUdWRkwrc0RUMlg2Zjd4bmpl?=
 =?utf-8?B?V2t1NlNFc25vQjFsM2ZZdEJaTFJNY2JQTGNlQlk3elhwU0E3RzNCd3NCYW1Z?=
 =?utf-8?B?bWhqNmVFRi9JZXFLVVYwak5oNExxWnZRVFJxS0RLNWlsOFlqYitVMDBNeGlu?=
 =?utf-8?B?MDZmSTA5ODRMcmVKVEdjUmFqL1hxUm9FeXhJT29BRHRkbXpYWFV4bVZwZ1pv?=
 =?utf-8?B?eW54cy8wME9UZ0dGd0h6eHprZmFackhpWHEreGZBRGh5R0RHWkM3R0t4SU9B?=
 =?utf-8?B?V3VxcDhJbVBES2tJdjhSSVdFOHVYZnJROUV2WllwTDJIdmxTdTJ2ajV1SU9O?=
 =?utf-8?B?STZWQnh5SmRMUVVmazZjZ0NScGxOdU54UDArRTk1VUtLSldoVWtRUWdYeFJN?=
 =?utf-8?B?T2JrQUZkVnFWZ3JucGFUSTJZcFh3dFZscldNZW5mVk1zVHFsME1qNGF2Rmoy?=
 =?utf-8?B?WnEyQjh2WUJvZlBWbW9Ha2dpMHNvZktiZXJENGpoT1d3TDNBTzZYZUxkekth?=
 =?utf-8?B?c2pjWU90VUVKTUtyOUtjeCsrNTkzV2NWa2xMamJEMnBOWEZmNitkVUlSR2ZE?=
 =?utf-8?B?MTBMSEhSY3JCVXJWQ29EMHBTUkZ0TnZLMVVtVG9MSXVxblMrcndLaUNGUGFn?=
 =?utf-8?B?Nzg0RUJJY0tuVVRRQXN5RUo2S2wwVzR5bmw1Qk5SS1NUanJCazNDR2VqcmVR?=
 =?utf-8?B?S0lseDhvVXNiTnNDR3hsRTdCTDc3ZERzUTJpSkExWFgyWHc5Yk5aK1BvZGdX?=
 =?utf-8?B?L082NHVxajBhd2FDLzI1SnNnbkFTWjh1NjV6MDQyMVRaalMxckVzeE0xeUds?=
 =?utf-8?B?TEFOQVg4elh1bnRFKzZxcXl5VFRUWmlBSHp4T2hDb0ZzYVBGU2M1a1B2NHRl?=
 =?utf-8?B?b3FuS2NEeUlLbnp4K3RyQkZabEw1ampPSmpNT0hOTVZybW1BQkN6NHF6WkNz?=
 =?utf-8?B?OU91U096cmJmV0t2M1BWMVJiRWpzYmsvNHhWQW15dVZTQ2V6UEhUbkRnTmFq?=
 =?utf-8?B?aXdZYTI0eWIvbDlYZlRyNFUyciswLzdKMkFCT0xtazFkZE45dVVGeEdTL1VI?=
 =?utf-8?B?VklzdWlsRzFlamVpZmN5a3pHeTRsTUJGc1l4L0pUMXR0V1hrK09NaWNNc2VW?=
 =?utf-8?B?L0x0bUdoTFB3bTRrbFNFbHltU2VRWDBHeDRjV0xLcWNZeWFRV0Npb0hWVmZj?=
 =?utf-8?B?bkt0R0wzNnlGMDVhK3praTROZ1p1aHpQeGRET3hQcnpoT2tuSzdNNG5jT3Rq?=
 =?utf-8?Q?29VQfo8Nij0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG0rR01lakMwd0E3bU5WYlNmZm1DaS9TNWtjeUhJOXdwaEl3SGEvNzhiNjB6?=
 =?utf-8?B?VHloZHdEOTZoRWExMDlUUUVzSjN0WUpqYkRvdlVxVHNWUjR4ay85UTZVUURh?=
 =?utf-8?B?cFdUazQ5ejZvQmIxNU9aS0F3Wk0zd2VabmtsM21NQ0kzMzBzc0xXM1h1L1Nn?=
 =?utf-8?B?UjkyTzNBUjFubUdSNXVQQTZsZUVWcitLQU8ybzVUamFDOGhhcWtLb0J0cDJG?=
 =?utf-8?B?dTJWT2NGR3FqekpUTVZlTXRqbldyNkxIdC80QXhrc2dvaWpyNndJdElmcnds?=
 =?utf-8?B?R0U0WEFPdFR1ODhDcVVzbWxwWm1VRU5sM2p2T2RqZVFzYm1yTEw4MVBneFc3?=
 =?utf-8?B?alhFaGkyM1BvM2I4UGlYcnY1dzRTZC9XMSs4YVVUcysraFBjSjJyc216NlpR?=
 =?utf-8?B?TWgwalI4UFB1Uy9McDhlVnc4Vll6NVVENlJRcm51RkdWY2JQdzhoUzVBRXNp?=
 =?utf-8?B?THRjZVRWR256UXpwK2pZU3Q0NkdDV3hNVHY2VGlBWUgzb1duaGpxQk02MjlK?=
 =?utf-8?B?VFBlU1lpNXdiWWw2U1h4RmZka3JjZDBsc1lVanI0NHU3WjlHdTRmcjlEcERl?=
 =?utf-8?B?LzQvcG5rSk1BSGRTZjdwYzRqN3RsQjg3RkZKbC84RjRRejBPK3NxMndVbStj?=
 =?utf-8?B?MVEvWHBmSFc3d3A2QnNiRWs3Yk96OE9oNFFkS2Q4aXZjZytGT29vdGdQSnlU?=
 =?utf-8?B?R29qYmRTRnZtNCtLYlplMm9TOVdESlV1UW55UjJnc3F3b1hnSHpXbkErcjcv?=
 =?utf-8?B?ZmM3dkFRYUJ0NUpmZkVKd2I1TkJkdXJnbEdtZ2piWXJYcjFwVXRlT2x4M2x5?=
 =?utf-8?B?dWJrQlZLeEtkSjdJYnhqNHR3a282QjNseHh0ejVEdjhDeUxoVGpnbG1lekgr?=
 =?utf-8?B?cGwvWVVIcVk5SG5yKzBHRjBBaDhaRHg1aEVRYTQ0ZHJlUlBJNnNNWEhXd2Ns?=
 =?utf-8?B?bUhkdXNvVkZyVGxLdFM5dldydDR1a2lOWjJMeEhOVm8yNHJ0Nkd6MUxuMVZ3?=
 =?utf-8?B?OXg1b3Ryd25nMnJOcUR0d21lZURHdEcwTjNmZzhDQzIxcE9zZDFBZVErWllN?=
 =?utf-8?B?MDl4c0VBck1jbnhNMERGVUJrZzFWSXVHb0VCNU1mcVFxYnRkOWRnUUMxMXdt?=
 =?utf-8?B?ZlpNV2pHOXJPTFZrM1RQRnlUTHdxK1hTTVQyR2lOMXIvaXo1dHNEQjhBZkpC?=
 =?utf-8?B?UFp1ckxNdTY0bUxISUhxUmdaVkJMQXlJOFJHZVpmNCs5UUIraVZJYUdMNThT?=
 =?utf-8?B?NHJ0RXk5Tm5kZDFxWXBFVjUyc1FiQkdGRUlaampRQTlxTnlWUzUvazRtQXVo?=
 =?utf-8?B?UERXa2h4MGVRNEFCRnRnK3h6cFNPcnJ5L2JKZS9YS1EzSkkrREM1UjdFTFpx?=
 =?utf-8?B?elNZcWcyc1FqNmJKbXQxMUh3WXc4Nk8xUXljV2JzT0VLTFFXb2ZoVWZBVzZz?=
 =?utf-8?B?dGNrOUhJNVVLREhDRkp3MFgva2w4Y01LaE43ZllvNWFrQ1hzNm44VGVPN1lS?=
 =?utf-8?B?UnNUa3hNV2E3ZzI1Y1RDcWxxMmluZ0J5RHVsQ1VjMU0yRVgvZDArTm1nZk55?=
 =?utf-8?B?WkNqRWlyQ0tRaWlzdXBaS1FKakgzbUpxWkFWVEpXRERYbFpoS1oraGlqVXJQ?=
 =?utf-8?B?akJNNmxsYVc2SXNyTlEwdHIybm5NTE1QM0s2cjRUNkRqb1d3aG96R1A5R1ZI?=
 =?utf-8?B?bEhHUFZrMFlmZCtpMlI4TEZZWEJXY2g1c1JqOXJKdW9tbzltK2VYQnV2Qkdv?=
 =?utf-8?B?NkNnZGVHcmVva1RNR2prRFk1L2I2M1o2K3FVR2dxOVJ2RXArckxSMWNwK1N0?=
 =?utf-8?B?NWxQTG9vNk5jNFFBUE5Yb2owbUROZCtqQVBqK0V0UWt5RUd6VThtdkVVWngx?=
 =?utf-8?B?UG1teEJ5b25ETklwY1NYb0IzdjZNN0NINy9XaHJRNVBpc1luTUQ2cnFMdmxY?=
 =?utf-8?B?M2FjUmJZekJuVk4rUFhYQlRNcDA4cXEwdkh4aGdua1RsMDFIMU85RGJUOG80?=
 =?utf-8?B?NHlPM1NXM0xZVEpuWnZyc0tuVjlqbXg2ZGdEMm9SMzRTVjAxUkVaSEJIZEs3?=
 =?utf-8?B?ekhnUTVlS3dRd29sVmg1VWJBOGd0YmRDRXJYOHV0Y00vN0VWWmVrS3BzQ0xt?=
 =?utf-8?B?TkQ1Ym54UVFCTk8xenRXV0tWU3hvN2FhUi9OT3RKRHpLQmY3NzZwcUN0MEdE?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48319d7c-8295-4629-8501-08dd8e7d3462
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 22:10:55.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJY2HKnajbk8a6IaRJst1XBBZzxdSjzeaZID40aEwDtEmAeqHT6+52rx4VHf7wgTINWHYqRtD3RARQnJj/2PX8NK7Ks4vi9hFhny7DPNfBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5052


On 5/6/25 1:52 PM, Stephen Boyd wrote:
> Quoting Matthew Gerlach (2025-04-17 07:52:38)
> > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> >
> > Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> > driver for the Agilex5 is very similar to the Agilex platform, so
> > it is reusing most of the Agilex clock driver code.
> >
> > Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> > Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > Changes in v4:
> > - Add .index to clk_parent_data.
>
> It's useful to link to the previous round with lore links. Please do it
> next time.

Thanks for the useful recommendation. I will be sure to add such links.

So I should have added something like the following:

      - Link to v3: 
https://lore.kernel.org/linux-clk/20231003120402.4186270-1-niravkumar.l.rabara@intel.com/

>
> >
> > Changes in v3:
> > - Used different name for stratix10_clock_data pointer.
> > - Used a single function call, devm_platform_ioremap_resource().
> > - Used only .name in clk_parent_data.
> >
> > Stephen suggested to use .fw_name or .index, But since the changes are on top
> > of existing driver and current driver code is not using clk_hw and removing
> > .name and using .fw_name and/or .index resulting in parent clock_rate &
> > recalc_rate to 0.
> >
> > diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> > index 8dd94f64756b..a5ed2a22426e 100644
> > --- a/drivers/clk/socfpga/clk-agilex.c
> > +++ b/drivers/clk/socfpga/clk-agilex.c
> > @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
> >           10, 0, 0, 0, 0, 0, 4},
> >  };
> >
> > +static const struct clk_parent_data agilex5_pll_mux[] = {
> > +       { .name = "osc1", .index = AGILEX5_OSC1, },
> > +       { .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> > +       { .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_boot_mux[] = {
> > +       { .name = "osc1", .index = AGILEX5_OSC1, },
> > +       { .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core0_free_mux[] = {
> > +       { .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> > +       { .name = "peri_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
>
> The index doesn't work this way. The number indicates which index in the
> DT node's 'clocks' property to use as the parent. It doesn't indicate
> which index in this clk provider to use. I don't see any 'clocks'
> property in the binding for this compatible "intel,agilex5-clkmgr", so
> this doesn't make any sense either.
Thanks for the explanation. I misunderstood how .index works.
>
> If you can't use clk_hw pointers then just stick to the old way of doing
> it with string names and no struct clk_parent_data usage.

Continuing to do the old way with string names does maximizes code 
reuse. I will remove the .index in v5.

Thanks for the review,

Matthew Gerlach

>
> > +       { .name = "osc1", .index = AGILEX5_OSC1, },
> > +       { .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> > +       { .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> > +};
> > +

