Return-Path: <netdev+bounces-259434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHzEBTvrlmkzrAIAu9opvQ
	(envelope-from <netdev+bounces-259434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D215DFEB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB47301D6A7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592012F2613;
	Thu, 19 Feb 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DLWpp3qs"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CD2F1FEF;
	Thu, 19 Feb 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498263; cv=fail; b=YHse1W9cjAioE+n7AJEQcqgEvwQIxhD2/h5FP16cj4Fs692ZIan9bSq0sN2dk/+panVNiP1M0gFVLKNBeXHuYqoONk1pFcTyTrZeJ924j7MF1DcY86d6YSQXZuIWB+6AVKeZQtqA5s4NIv9S/g5ALVDls1EfkBTGUGxN46STmBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498263; c=relaxed/simple;
	bh=/iy97ghVjFfFDxb3AUC6I6tclZSzh2aMWqfLAuSuaXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ShtE/4xw2/EYMnklMMr2ru5O1qsPhT9DSTisQly7OHHftYm7f4Gow1Ey18sdAjtx5ATlF+T9EtvIss3H9AozBf4ueKxOyjQ55uCQZuyL0RSDqVcP++fzxVGjDMHN6QZSKt5twQ45HuGxzri7DdClD4bYa/ZI4LchtRFvrn7ldq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DLWpp3qs; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/yksrg1VaiGW40G9lafwcCBBMz41hQvU81cCXddGKByU5m0jxhUHzBtMtSedz1vb4R11G/15N26jSYsoBQAalTYAALpn6IEeORdHEiHzmCFsToguCD1sApboWUAYIxDYtfuI0DK8b7Q3feODXe7Gnewy6u9zEZ2RiyIWwQK7fUQ0yTCnm4wnXNawkwSLcJsYATtD7By/emDOj1VRv0uoWB3Gt5cl9uPaOgJNtBiOB6ie6kupX5OHvJ8Qa8LBahcYVnpFRDyAbbkxh9FouPnuZXRRNlaOftwXE/hXarZaHZwism2Hd50zGzuwXaCpRqjywg9kKUApIcvE6HKbnEKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxWkFa1I5PphWb4hyX6SOosyWZffyiSAFd0kPYoU6M8=;
 b=ICVZC2h4s4+bkm2e83gm1HZfKGCqMqboByeNLKobFErW/9Hgv+w6HulqEiwmO+E/wGIbdWZmFhphKBpt1H6WD4KsOLy/Gy1nAsCeiyMDsO39itkEoOc6JgxDCTzWTUZgDOI9UGahVcquAeVDPU599WL6CSL/e+WGBQHi6WBX1hnp9HXRwEMRZ7qYHAGn5MeVTNNRcwhkqkIza/v6cniC85COXXuY7EpFe9S7eLa5LAw22QxXZs5j1gS8l9IDmX06jj5lanSgbw2QBpMCQ5Ghfm5iL8/j6GuiBPwKeN++v/EVL8cXULcD0ajR1fMRFpFkkQtoSsGjTEXmCFCS6zJ7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxWkFa1I5PphWb4hyX6SOosyWZffyiSAFd0kPYoU6M8=;
 b=DLWpp3qsdbBYusJi+vzfQKdd3E3XHC955wefTHIxjbuFS+Rd9LnfFuUYj9AbalSzl/PJigSGly3eZwft9s/xhUtK5tOSlEmAfAL0ZfGQVGckot3Becbti8qumMPOWQRISvolkCxZ1IAPPyHsalhu4ROYDGdq1arr9kM/uBEZizg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 10:50:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:50:57 +0000
Message-ID: <1b4dfbce-912a-4d33-b862-482341f1b9be@amd.com>
Date: Thu, 19 Feb 2026 10:50:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 20/22] cxl: Avoid dax creation for accelerators
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <daves@stgolabs.net>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-21-alejandro.lucero-palau@amd.com>
 <76556d1b-646c-477c-a315-33c3bb3cd981@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <76556d1b-646c-477c-a315-33c3bb3cd981@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: ef779cce-5346-41c7-4bc8-08de6fa4c34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3h4L2Vxa3R5UkRhNnRjdFBwVzJnRTNvRWtTakZWcFJnNU9vZWNIZGVtWTl3?=
 =?utf-8?B?Z3BuTDN2bWJ6clQ4Y25lcmxDemlyMldRV2Jpb0ZsTkVXNEwwYmZ1ZDZYclY1?=
 =?utf-8?B?K0JRZS81bXJuWHFFeG9jQXljaHlmRUFnbjhkR3VwOGRsUCtMdWV4TDVaTGZx?=
 =?utf-8?B?OU1VZ3VvbUNiMnZlR1RSeVlCSHdyVmc5akhqOHNNTmpkOXYwdVhxdFg0UnIv?=
 =?utf-8?B?cnRoNEgvZkFJK2l5TitLajVNVGVELzYwMWg2ckZURzFpQVU3WHUyOWJEWkl2?=
 =?utf-8?B?L0tnbEh0TGM4T21KMkxiYzhGeEc3Y3VHOGw1MytaUXN1amJ0S1J6b2xQSU1I?=
 =?utf-8?B?OFVqd1c1Ymk0bWg4TnRFbTM2KzkzSVdubW9GYkxuVEFPN2k4KzVxQW0zQzlG?=
 =?utf-8?B?YzFIQjB4NTF6NlNiS1FoRksweTVWaTJhUG5iS1dFYXdQSGI2RUtJTTdQZEU4?=
 =?utf-8?B?YzhjRnhUMk1aZmpkbkpVWjdzY09Xam5uOU85WVF0MmNsa3F2MXBwL1F0ZkIr?=
 =?utf-8?B?VnZvOXdWbmpMWGxhK2R5SHNEeUM2WFlIR09NVEU1U1lQeUcrZ3o2RzJETnRQ?=
 =?utf-8?B?djA3VXArSmNsU2xiaDcvKy9EMnNYWEhCU3dzd2gydW5ZdDE5L2hnYndkNmtw?=
 =?utf-8?B?aGo2OHo0YUw0UmQ2VTF1U2d0ak9pRVpqRjE5K0N1MzVZOXRLOWxYZXhFRGpU?=
 =?utf-8?B?REkxdVh4Y2VPYzU5eENxUCtoYmJHMXFoTG5ZL2VORkVBNDVHU1N5NTlQRk5X?=
 =?utf-8?B?SytYN3VSSUQyVEVOeGdWcjFwRFZHTWZNaXF0ejNlY0ZrbmZSU3JtSjdrMHNT?=
 =?utf-8?B?cERYcGZQOWY4cUtzak5GWGJiMFZZSzdrRVRDZnNJNk9DdkN0VnFvQ2ltayts?=
 =?utf-8?B?OUhkdnZxVmNlVWlSMXFGRTB2cm5PYUxHdkpWSDBxMkl1K3o1NG43V3J4RThq?=
 =?utf-8?B?RU0zMG1hbExlMitKNDR0c2x1SnBuWjkwS1JkOHpmNWZHdEMrTGZwYysyQjlJ?=
 =?utf-8?B?Sy9Rek9hbmthb0VDUHA3Uk5HR3F4ZXk4aktuTDVoNnpwTFRJYndYL2d6Ti9v?=
 =?utf-8?B?SXhTM2RTODVGT1pjUFAxS0xjWC9rcFprQUx6dHNFc05rZG0wWmlsaTF1Yzl5?=
 =?utf-8?B?K0FST0sycTZGODV6WjJ4cHV3N3hLdi81dVJweGJmOWpIRVEwR1pKbXVTUkgw?=
 =?utf-8?B?QzB1a1VlazdMVjVlU3JyVTdzS3VnUjZ3MEE4ZnhlYmNHdDREZjZJZkw3K0dB?=
 =?utf-8?B?YVFjZkRRNTRQNE5WRGpvS1NHVXhxN3JVdjIzZ21HOHh0T3p0eCtjUEZ2YitE?=
 =?utf-8?B?Y245dmZkeGo0YUtmYjRiSXU4dElqOXFZd29peWhJSFl6MUVTZ2Rjc0JzM3BQ?=
 =?utf-8?B?SlphSDVRRWJ0VitnZTZIVzZYRnE0ZWkxQ1h5TCtWeGVXU2ZwZytYUURaSHZq?=
 =?utf-8?B?bUR6c3loYjMxSzRkNE5MOXhlOUZxSFUzUkoyTHdwc0ptTk5RSERWL1lCVU53?=
 =?utf-8?B?N3NIYWZvYlZ6ZUNlcmFtNUYrWlY0UDYrY284dE1HQmRLM2tYdXBWR0FXcm1t?=
 =?utf-8?B?UGY5WVN6L2JCUTlJdnhlamZDc2JtVUExSFhka2h3WFVkdzlLZGI1M2o2MlNW?=
 =?utf-8?B?M05rSWE2VUhFaDR2aTRzNzR4VURtR1JOVXJnZ2lWV2xvMkZBWmVZekNtVWlN?=
 =?utf-8?B?TlFWc2lQRkhCbVgwb1FwenhOVE9RclpjajRsekpwYW53aVVIZ1JMVHZnZlVy?=
 =?utf-8?B?U05DSEFCQ1VnalNNQlZVaGZ0UjdZZWZrS3ZlTWd1cTNpSVplZlB4MEdzQ1p0?=
 =?utf-8?B?TmM0WE4rTXBrUDVrTUIzNjVJbFNZMjh6anRoOGNNTDNvUWZueUNRckZna3FI?=
 =?utf-8?B?eEVzaG9JUkdxcmhVZG9tQUdQakRYSVg1dlVpK3BYdHBrSXNsVmdpRFM4VFZ4?=
 =?utf-8?B?UlBnb3ZnTnJVem1SOFFYU3NOd0R1aW5jQXZha21Ya1dOcjJiZmtpTTE3WXFO?=
 =?utf-8?B?ZVBYUmVSbDd6dHppSi9UU2w4ZjZKWnljVGdxaGlMS0l3MURoNmMyTnRxTUZs?=
 =?utf-8?B?ZWtGWktrd21JWUI3VVFqTC9FcXVWZVJmSUpLK0oyN29xU2lTalE1eFQvV0JP?=
 =?utf-8?Q?dmmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R09lRjVSYml6Tm9RQjk5WkRPb0J4OGR5Q3lKSmVvdURtczArYjJGU0hibWdO?=
 =?utf-8?B?S0VpME1IL3A1ZmlNRnpYS0pHZ3ozZEpnUHZUYzZramQ4QVBnc21Tb1pVcHdp?=
 =?utf-8?B?dDNaUHFhOEtZTFo4RGlaT3AzeWVKMG93aGY2OGhERHBZVDBLNjdoMllGU24y?=
 =?utf-8?B?Q3lQQklXYnhlNTluT29GSGprMy85bUlwUFduaUtIM2l2TzNOMWVibnJ3NXI1?=
 =?utf-8?B?czhBeFhLZVcxclF0Ky9uVUZXLzZ5KzB1ZCtTV2tKSi80cUpEUk5wd1JEd1pm?=
 =?utf-8?B?Rk1mbXBOdWV1TWhuaU1lNlZHcmRSU3Q5OFpFSWhXN2xEektOSW0zbEc2OHRj?=
 =?utf-8?B?VzdzVGdWZmhuUjdRZDVKbTU3d0F2dU5GY1c0QVBJTU8yd0tsamoyTmtBQUF5?=
 =?utf-8?B?cFlPeGZDbldNWW4xQVkrVFAyWkFJcHEraUljWjByU0J1Nm5TRVpEWGRlVXEw?=
 =?utf-8?B?V1VvUStpeHpseldzVXBYZ0J4YUxDTVlXUUNGZmFXZVlyd2ZVN1F3N09IRXVq?=
 =?utf-8?B?ZmUzSHdyb3V3OUNNclh0djJvcTdlc0pNNStlN1M1NTdCNFBWL0dUSklPNHhE?=
 =?utf-8?B?U3c4UkhxSEhDNjVkZUZjaDQxSjFuK1diZ0loTGY4cGgzTTA4TGJWWXdhVlZL?=
 =?utf-8?B?S1U2TzJnWHlsS1ovK25oRS9LRHdkTitMYlRrbnpIUXl5ck0zK0tYUndzQkMy?=
 =?utf-8?B?YThzS3FHQXRjNHFudHlnUFBMSmZRQVRLZTVuTTlKZmlXeWc4K21DM1hMUGtt?=
 =?utf-8?B?QzJhR29TYkhMYUNUMFNka3BrNzUrTmJPN2Q3cjBEMHdLR3hiUlFtamVVc0dn?=
 =?utf-8?B?YWlyZWJRRHQzbFpxbXNkRkU4a1hnTTlmaXNEaXN5TWdDR2lUazlkTkJXcnRs?=
 =?utf-8?B?dUExazJxM3laNHBzMFRsSnNXMDVySnE2RWR6Yy84eUtQbjY5TDhWYVg3ZHJQ?=
 =?utf-8?B?VEFiSVFPS040dUVlU2tENjVHMHZVOTBJblJJaDdNSVRTbWV4VWhUMkl3bW5t?=
 =?utf-8?B?YTJYYVZUUk1rbGJucDA4NEtjRW5RWTB5eEtpMllOOWEvUU9xMlNEY3MyZzl5?=
 =?utf-8?B?YjFlUm8vVUZzbU1NMDZUV0Eyc0VyM0dMS1B2LzZvUUxqS2dJQ0U4aXIvd081?=
 =?utf-8?B?RHFMQi9nTHhlbEY1czhhSm1pTXhZaGxNTXlIZGFKM3d3UnhnaldVYkc3Ynlq?=
 =?utf-8?B?aFZPNURMUU5hNDlmS0xUY3dXbCtZZk4veEd5RlZWelIyUmRSMGtoc29WWlh1?=
 =?utf-8?B?UHd6RVNWVTRGNEJuM3JaT09MTU5HWUdoOVRsUzhtTDlCTzhKTlBEQXhRc2VB?=
 =?utf-8?B?SEdvUk4rVWQ5NzJOYXM1NG5jQ1N3c2pVeTZpdlZTSmN1UmFIR2RVNVVRMjZ5?=
 =?utf-8?B?WlBQUDBFOEJSNmtDL21mWmVoQnNFMHM5TGZkaldNcS9zbWNBK3FydHhRMkkv?=
 =?utf-8?B?YkM4TTVTdUgyUWRuTXFWTzZ1WWdsczhRZ2N6Zmd0SytXWXUyU0dORlFqRmdN?=
 =?utf-8?B?a2pjcmlFSG0xTlpyZEtMYWF1YVBtM3JuTjVnNzdvdWljR2wra2xZdkUyV2Mv?=
 =?utf-8?B?cDYvMzcycnZZSmVaMHZ3QTladTl5UWpqSS8zZkJJbzV3ZzJxZThzOGN1czdw?=
 =?utf-8?B?N1pnMnV4Ynh3MFlkZ3FiajA0cUJ2SG80Qys4RjhCVEJtZUJ6ZWorOStTRVNY?=
 =?utf-8?B?bHJqNWUzWUpTekdBV3BLN3pWMnVNdmhZTjlyQWx0THBTVHRKeWdzQW9wVVU1?=
 =?utf-8?B?L2hBWndsR2lyQzBEYThVUk5pTnZXbUtwOTdpd1VqRzlEMWxJTnNweHJVUW9F?=
 =?utf-8?B?aXFmM1puTkU1MzhlVTM2MjJMaU9lVmlKdzkvUTgzRnVXbVd2dXVZMGFFMnNt?=
 =?utf-8?B?bER3aG41dHk5NkJOZWxhdFhScGJvalRDZnlqQnVmaXJXQkFhcXF0MTcvYmEr?=
 =?utf-8?B?V2Q1QVFoT1hRSzJJcGlXbDBJVUpkS3NhVU5ZSFBTK2tzemREVkpUSlF3Ukg3?=
 =?utf-8?B?QldJc2YzeWMzVGNuZVZZNm0rQlhEOG96RkQ2aVNvakFLUHowaE1tNzBqaElY?=
 =?utf-8?B?VEtzaGlHYzRqZmJNbE5sVEpzc3ZPblVGTmJpMTZFekxEeXFMTExWcW1lenpH?=
 =?utf-8?B?RlQySFd5dUJaUmxMTWdVODErdU9ZMzJZeHMxVVlWenhEZkhRSzF3QTNQOUx6?=
 =?utf-8?B?U2h3WTNWNGFSTm9Oakt3dERCNXFOUWJ5V0dPWEllN1BMaUZUMzNWelQ1NFVN?=
 =?utf-8?B?VVhOVG1sMytxNXAyNHZldnFsRzVTM0ZEUGFwV0wrZm1zNXU1OCtsejMxWjFi?=
 =?utf-8?B?c3Y2S25wZFNKR2krUTJDc3VVSkpXMU5aUThoSGJYbkJHRG9PeGVkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef779cce-5346-41c7-4bc8-08de6fa4c34d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:50:57.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3C/kwSWaPuK91+QTRwB8LzvYNJVKKdP/mnKlfTPW+yXymkliVAcoIXqtor1m1GjLhM5ZrMnhkMYRhTVxbuffPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email,huawei.com:email,stgolabs.net:email]
X-Rspamd-Queue-Id: 7F4D215DFEB
X-Rspamd-Action: no action


On 2/11/26 22:10, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 293e63dfef22..12df717cc881 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4441,6 +4441,13 @@ static int cxl_region_probe(struct device *dev)
>>   	if (rc)
>>   		return rc;
>>   
>> +	/*
>> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
>> +	 * Skip device-dax registration.
>> +	 */
>> +	if (cxlr->type == CXL_DECODER_DEVMEM)
>> +		return 0;
> Minor nit: Should probably move this to be the first thing in the function. It would save
> having to acquire a lock in cxl_region_can_probe() above. Keep my reviewed-by either way,
> it's really just a minor optimization.


It makes sense. I'll do it.

Thanks


>> +
>>   	/*
>>   	 * From this point on any path that changes the region's state away from
>>   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.

