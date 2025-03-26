Return-Path: <netdev+bounces-177845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D450A720B5
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE917996C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70C25F780;
	Wed, 26 Mar 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="wt+UCwlU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D2253B67
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024141; cv=fail; b=nxcO2+7HyhiJAod60XE6X1FU02PN6is8NqFRSHJbM0Nv5My5ufhuCQwSdvzwxlJ5rHp/zKWz6+PoEuU8ODWhm+d/5qa3cFSFdSuEkEKBFIHIWdqu7oGFbUN9f6gYJeKYmSBlX4xzjeEUGl+Ssv27DJJca+O1a9Sdf0ur/MDi4ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024141; c=relaxed/simple;
	bh=LrnzQ/mWeV01lp4t/goDt0BukyN4IQslzPIkZalporY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B1PrQBIIFhe9E5Ek6UtH1xyXqH9evzV5H6nCYYToo8wGfZjDRkahyT1EuhvigZ8PK/FoThDcsv0DjU8nD1MSLzCXoOJ85hFuhB5hy+ybPcrnJjpRRDgCAPC6B8uPBnkg0Ns33sE6vNdd9WiZEkGvRyH3rRkmNFkRmidbQMhXZDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=wt+UCwlU; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1743024139; x=1774560139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LrnzQ/mWeV01lp4t/goDt0BukyN4IQslzPIkZalporY=;
  b=wt+UCwlUJGKg5JaSYuVGEM6rJK9IwwScuzDqOuWovu3r7u7GahgIgllo
   XgZiwxSqxmtKiEYRaa+bK2QrmtmvIUmgosl8Wa1brU6lEtC5eJ2lYeC1X
   NOu/1xHikMT1Kn0c4DJjWCM0YxGy/7jVizPE5gnLN7mSbplmPy555B4Gz
   k=;
X-CSE-ConnectionGUID: o8ac+of2TMaeZAwwUuLj8Q==
X-CSE-MsgGUID: np4X3k7NSA2fsyYLFKBNWw==
X-Talos-CUID: 9a23:aC6JemG38brNF17eqmJgpEcfWccrKEH4xXriClCnNHtNSu2sHAo=
X-Talos-MUID: 9a23:zW48DgkOcosw4tgW6kYCdnpkLJtYuKfxLnsky5sdqvigGw9aHQiC2WE=
Received: from mail-canadaeastazlp17010002.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.2])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 17:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJjVKZrZyWFp7uGccWY993yrCPReV8ZiDwlphpgfC6tpNDBrmi21eLb/GZabUiXtpHPr0T58zTh7QT3l3KDFWJQ9odUSmbm2sA3CqVv3kaw+z1xKScdXPay9czzWiCuYDxIIKlbE+K6COHUFAlP+tMQkCMLiG2QQY14DwRULMCLDfRDOEsN5yAo5qiOKNnKs6GzQX++cA1b/Ev3g+rHFHDT2/2GMv95vOOq4TNiOOr/oFOyFoGqHXJLiDEestpqDkqyqfbwNnIgoqeRis+07pwBM+XUYgQk1U4wF4pWpiTuPLqMfJ9WalpNIASls/TksVJjefM0DnDP343Poo5BJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag1MusEQCgFTBxl4f/hOYEnbR5j96yADzbs+iX8eYUg=;
 b=hAZAKR27T6xhooVb3GQnEpPaqwvJj+hx9s7jg+p+N9P6YvRvZleNFF2BnOKx36M6vbwTXqHo8m7LJU9/vim4+3IYI1mHZw5rISbLQDYqzEZ0lcLGT7UAjz8wUDVaVqqLjKdOXP1hx4fHCKrAAQijm5iXJgQbDq7yrEOYSUyDbXrrUxs4Tr0n3jNNIMz8m+Azc6AGppXeN/dlBt0ZKJTI4YtJcvEQ8xpVUBoguz6xW7kmHd2wZkb1SHeqZ1fg1Nwh6gjArgI1lbDnCxVuqlHq3QVXSdDdOEkhs4ztboIF/ECtcrvfsa9TLLlWuKdRIMn4W75z+hquyDcfwsHw2yaFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB8824.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 21:22:08 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 21:22:08 +0000
Message-ID: <5cf6b8cd-bba6-4a68-a0b2-58c584d90886@uwaterloo.ca>
Date: Wed, 26 Mar 2025 17:22:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 jdamato@fastly.com, netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
 <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
 <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
 <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca>
 <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0430.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::13) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b451db7-bd2e-46f2-9d4f-08dd6cac4377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEs0d2NsOGhwU1JyK245VkQ2M2NjRlNwM2xueUxONGxXS3RHZHlBNk5NMVlE?=
 =?utf-8?B?NGlXejAzMm9DeUw0WGVnaWsxQXJPV0R2RWdSUnZxaU5sNU8zWUpjOHAvUFR1?=
 =?utf-8?B?K3RjcGtIU1ZlZ2NGbVZGKzlITlVQSldMQjZ3UlNLbVQ5QmN0ejB1dGgvMGo1?=
 =?utf-8?B?SnRyRTdHSlBjK1VwaU5sNWxPbWI3eUgxcXJ5WjZ4c3lNTmM1TnRYbjhnODhQ?=
 =?utf-8?B?Zlc5TzkwRGpNYlBPZWtGSFI2Z1BTVURmdzAySWxWR1ExVmU0TVNIRE1yODJ1?=
 =?utf-8?B?NjkyK1pWdVNxWDhqWFBZMDN1SXcyUjhZRWVPQm1nUWx4cXpwN2VJUmUwWXp0?=
 =?utf-8?B?NGFpRnE4d2trakc0anIwL3JCbGVHVXZSbW45YVYzZE9tVXJjNWZLUFRIV1E5?=
 =?utf-8?B?VTdiTVFYblp1YmF3QkdXejBKbWE0bE4yTERGUHBCS2VqVmtIeVUyRjcxN1JY?=
 =?utf-8?B?WUhrMlBHQ3NlanpPNkgrdTJkZU5sQjFTeG5iNXFaVlZxc1RuTUQwVW9EY05i?=
 =?utf-8?B?Mm5wMEVkOVNoSC95UlRsemR0RmcvZ1M5TG9pYXl5Yi9OZFhYR0ZrMmh1aDl3?=
 =?utf-8?B?bjlWTnNpTWlnOHRnbjRMNEdoeHdwMUVESTdsK3VHTFc5ZmhFeW0wWUwvVkNj?=
 =?utf-8?B?MDhQYmwvRCs4K0s4OGNDbkloZjM2R0lyd2k3amhPV1VTMnYyeCtXeXUxNHdG?=
 =?utf-8?B?THBxdy9SVXFBdWZqTjRPWmc3QTJtMHVXQVV4ekFRaGJ3VGczRCtYVkN5MFhx?=
 =?utf-8?B?dm9UMWlXWFU1bndXUnQ0UWRnRGVrdU9raWVwcjVhS08wVTc3clMwMjN4dk42?=
 =?utf-8?B?VWIwcjMxRGFjVmZzUFIzSCtReUhKWTIwTk9GS0lEVUQ0cDBpWUwybFFpZFJ3?=
 =?utf-8?B?ckhYY1h6Vnd6Y25zK2NZVUhta2E0aXp6M0lHZldTM1NYNW5sZFJlY3BsSFBB?=
 =?utf-8?B?TXg0TkNVVGtnM1FmTm1VV1Z3dmxSeG9iaHNzN1FWWDdQV2JXU3ZrYlpMMXdi?=
 =?utf-8?B?Rzk4dHQxN2VCcXNjaFBNSkNKc0VhdWY0ZlNHYjY5cnZJbEJYTUpTbkF0czda?=
 =?utf-8?B?UVl5RHRrUk5GakZmWFk5bXhNYVo1dDRXMjEvZlJkdFRUNHF1c2FQMlgrV1pa?=
 =?utf-8?B?YzVKTlRBNjB0c0FNOU8yanJPNU8yL3dBWHV2US9EVVdxT3YzRWRXalBqY2p6?=
 =?utf-8?B?YW9mYm1nM0R3K2Mrc2JBYmkwcTZLVVJOaUdndVh2SHdORXJvTzlPaHJMWVgz?=
 =?utf-8?B?cWpLSW94Q0MwZkxvaExSZi9GTFhSUGV0Y3UycENEQjE1SjhSNVJYSXI1QVBq?=
 =?utf-8?B?SUdSZG1kSTdNejZZWWVjT0wzVDdFaStSeEFEbVNXSFBMNkU3MjJUUnE4S1Ns?=
 =?utf-8?B?WmVhZkhnZVB0bXhVOWh5ZnN2cXhtblNOQ1lVSEhHWnB4d2sxWTBpMzhIMDd0?=
 =?utf-8?B?cUVWcmIrQmhxV0ROOHd6dGQ3SHJXNm1WMC9mMmxRMG1QUkVvcUZiR0R1ZHF4?=
 =?utf-8?B?UzJNSFVrcFdwclYxUUE5NnRhUnRlQU1EWGhQNUllYnhQVVhpWFhIYk9kUUpQ?=
 =?utf-8?B?UjdVLzA5WjVINFJRVXRobjliclVRb29OSGZUTVlTMkMrWmZ4bXkvV3RmQUwv?=
 =?utf-8?B?aFFwWjRiRVhzb2sxRERVd2RSZFc4WUZESHFibW5PVWVTWEFKK1ErZzBpTFc2?=
 =?utf-8?B?SkxaaitjaUJqaVE0ZXlZcGNjU3JidERQZWoyamdhNDFuUlZyeGRCSEt2SjlT?=
 =?utf-8?B?MWtXNlRPQnBZaDFUY0Uyb0RzYXlxazdBbExEb243TE80ZmNTb0d1UFZQaXBa?=
 =?utf-8?B?R3g4eURRN0xSNW9MUjJSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tnp0NVBaRzVJTHhLVm9KOC8vTjk0Zm5JNExrdnk1aFhQK25OREJMa2Y1VVlo?=
 =?utf-8?B?ZHluY2xkSnhadmdYK2FYczRNWGVadTV2Rmt0V000d1J4cHhLVDhqL2FrTWtj?=
 =?utf-8?B?VE5XMGxrQkgwNUZRSVlxdTdESWRtWmNPdkFnY1U4Mk9rcGpaOTRpWVgyTnJZ?=
 =?utf-8?B?dUFOSDFzV0ZTaTRSYXpBY0xmU0EwYVQ2eld2cnh3WkdpNlJBL3hpU1hXbDkr?=
 =?utf-8?B?WDM0VUJyL0ZLcGdXMytSTjM5NjMvUzBmOHVnUHhSeng1N1BJTnhYM2tJdmw5?=
 =?utf-8?B?ZVdwb0RWL1dZRWVybWJzMlEvQ0NZWXZLQUtNUzhjaThzdHdyZGpyUFQvRjVh?=
 =?utf-8?B?U1VLdTZlM09tYjQ2UlNVNTVHWHJ4aUxiemtPckR2SkhFVXFkUEJObUhXWkNS?=
 =?utf-8?B?NjJFaWpJNEVTUkcrOFlMRFJxcGwvQVVGblhrd1ZId2lmekw3VDFYencxL3RC?=
 =?utf-8?B?WkRDQkNTalM0RWhVek5aeDlKempHZEFmT2lyVWdJUTRwODhJL3FPRU8xYjgr?=
 =?utf-8?B?U1ZibEtDVHQ4Y1duMmdIRFNvY2l2VkxmaXYxeG5vSDFzeFpGVmE5YXZLVWJq?=
 =?utf-8?B?R3dIRmNvSjhHalJDbTU2T2VXRnQ2ZngzTUEreXB4eDJzV29aVVZCSE9kKzZq?=
 =?utf-8?B?UVcxanAyWXM0V1VyMDExSm1vTkUySk9FZFNjZGJOWDVpcW0xcXpMMDJwbHJS?=
 =?utf-8?B?U0NhSkIxQTI4SGYwSS9xUmkwR0ZTK1hJTUwyYyt5emlDYTNtbTQ1OFRJZ2U1?=
 =?utf-8?B?R0xPZGlBRTVFZWtrTWlnbnEyRDJWemFya2FGYVZpOGRTQWxpV3dzOHVVeVMr?=
 =?utf-8?B?V3JNc0p2SEtGbDVzZ29JeTZSbmc1RG12bGRCWE9SK1BLUUVhdzdIMlRVd1VN?=
 =?utf-8?B?Y2cyZ0VDZHRtNjJrVjFMVHNJcktTdW9vT290aDJQK0RheGRZMjBoeWRYOUlW?=
 =?utf-8?B?NkZhTlpiSTA0WWhjbWdLMDZPTzNUTWRQaFVLK2VGRG13V0VwczE1SGVnNXBK?=
 =?utf-8?B?ZTF5QTJTMDZiaW45TEM3OEtFZkl2dWptanlXZ1hNbUlnWkVQc1ZYNXQ3UEpG?=
 =?utf-8?B?L1Nkd2JHekVyREdDK3k4WXlCMEJZNkZNdWNBZ0s1dy9FK1pmbmZqQ2NsNExZ?=
 =?utf-8?B?OVpRdm1iUXJrdWJzU0syMFZ5T0F5d242a00zcW1oVncyekdEb1owcjI0WVRF?=
 =?utf-8?B?dFlwUnAwa0Z3ejFiWTFRQW9xeEdBWWZlMDdVRWZMS3YyTW1rUUtGaEtMdHdG?=
 =?utf-8?B?L0ZVSTg5ZGdVNWpFblZyaWZ6c201WlZlYWtNckJsM082UVFNajQ4eHdUWVgx?=
 =?utf-8?B?RTF3QXViQmdQWlJJUS84NWptdkZ5OWpTbGZpbG9Vdm9kUk1pU2NPQm8xUHA5?=
 =?utf-8?B?c3NkZktKbnpNRG1FQmhnOU1HQVpBU3g2ZHptZW1HZmFlaFoyQVBxMVEwUito?=
 =?utf-8?B?aVVMUEJxUWlhVTVLUmJXNmg0eVA3MHpVN3FocnpDWFVXMEtpaGJVTlZxVzJ4?=
 =?utf-8?B?NHM1VGhTOFk5bGFGMlUzZjdDRHZmdmg3VktYSWZ6b0prUXVxZnlWSlNLblpp?=
 =?utf-8?B?VnRuTUo2Q0VtM0YyTjR1c1VIWVVDRmU0bTZodGVhQ3MzY2U1c2lES1BHeWcx?=
 =?utf-8?B?dUF3OWlzdlNYMXZJM0E1N201ZDhXaGR6WG8rQ2VpMVZmaWxsUXZFTndna01Q?=
 =?utf-8?B?THZ2QURyZ2RxMDZpb1gyUWQvcENDM0o2Q28wTGZNK25CNjBwOEJpSm5OMTNw?=
 =?utf-8?B?SVkxRHE3UjJ2WkprZ2NGR21xUEJVdHBOTHorUXNqL0FYbUxEbU95ZllLVXEv?=
 =?utf-8?B?VHphUFVQVjRkcG5kdk9ka1RqZncrZnNZbzF0c1BQd2VQUVRsWHpGZkhnUW9s?=
 =?utf-8?B?MUZSMWZEeGJjRUZWK2hGODNtKytuM2xLK1crcmdqSXIwNTFYMzlzVHNKK29T?=
 =?utf-8?B?MUVCT1h3NWhGWkxzamk2VVVBY1hVa01aR0tCREs1YTJ4QlFyL2pZNS9qcDRt?=
 =?utf-8?B?b1VoR2dzUkNLNGlrbWsvR0piNHpkWTc5REtpSTJQQUcwSTNHeUhod1BhZGkw?=
 =?utf-8?B?R0h2ZlpaMmNWa3hrdUVISEo2aDlTc2Jaalo2VVV3YXBRdEwyRzQ1eWlrYTNm?=
 =?utf-8?Q?KSuxb+/P4w/x9oDLrlQ48HCeW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ecWSEsfozk8lnWUSHsVO9Tpd3yqB7nHbkf/qb02gWoiqk/qICuomhTuQ8K3JsJeqhS/dyphYaU1+b3vaRgwUADqwzeAp83wI0N6LhCAs+wlccwG8M/PuKE5IvNN2DMNZ/IRFwffl8RZLXPcRrlzg7w98OJZwuwXd5f3Z6kJaob7Ce1NCL7FOKkpulgLAKhIw7rOtEWdyunDSWQ2LV77EX+2EjjJ6+EBiQMFDRKwFbbas5cT9010NiCH/Yit5q6mVXO8CyhfoxWv5RFu5BbbgZaSZVk9i0jq1ZlWLAtu3gVDUkCny1Vpf+O6NfaCQ4qY/gjGHYPVW5fT0lvWtyctO2x+f5QiN+Ez86gb81RC3DUaaHwlEfm2mRTqlwZ02PFWYXZUFTgDfs1CeREoCWQdCqjAR+ECMatN0EfDq6OjPxq06krVKvx56Hi+eHADm5RtB3tb/66i02JzX8bREx5iLDdJa3UcmQDxoOQFsPn3wTtV1inSCFW91eW/br/cjiMhbB9U4VazD5691/t+8CmdxMPIaEsADJl1hwN5/0bUsZNq3vPpgtXHKguonf/OthhACxJ1t49aQDc42zPCHwUSVK1K2dynH5NmsfETPuU1SEKNM4+5mWVnZ2vzPKW2KUsuM
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b451db7-bd2e-46f2-9d4f-08dd6cac4377
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 21:22:08.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/2XnhGn/pHXFyimthCum1JoidZAsVPSf2FnTYt2mX3/WC0ImZAqZ7LyMKyaRCo6uuZ9SBBgTFvx2IoC2TAmmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8824

On 2025-03-26 16:34, Samiullah Khawaja wrote:
> On Tue, Mar 25, 2025 at 10:47 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-03-25 12:40, Samiullah Khawaja wrote:
>>> On Sun, Mar 23, 2025 at 7:38 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>
>>>> On 2025-03-20 22:15, Samiullah Khawaja wrote:
>>>>> Extend the already existing support of threaded napi poll to do continuous
>>>>> busy polling.
>>>>>
>>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>>> dedicated napis for low latency applications.
>>>>>
>>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>>> and set affinity, priority and scheduler for it depending on the
>>>>> low-latency requirements.
>>>>>
>>>>> Currently threaded napi is only enabled at device level using sysfs. Add
>>>>> support to enable/disable threaded mode for a napi individually. This
>>>>> can be done using the netlink interface. Extend `napi-set` op in netlink
>>>>> spec that allows setting the `threaded` attribute of a napi.
>>>>>
>>>>> Extend the threaded attribute in napi struct to add an option to enable
>>>>> continuous busy polling. Extend the netlink and sysfs interface to allow
>>>>> enabling/disabling threaded busypolling at device or individual napi
>>>>> level.
>>>>>
>>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>>> level latency requirement. For our usecase we want low jitter and stable
>>>>> latency at P99.
>>>>>
>>>>> Following is an analysis and comparison of available (and compatible)
>>>>> busy poll interfaces for a low latency usecase with stable P99. Please
>>>>> note that the throughput and cpu efficiency is a non-goal.
>>>>>
>>>>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
>>>>> description of the tool and how it tries to simulate the real workload
>>>>> is following,
>>>>>
>>>>> - It sends UDP packets between 2 machines.
>>>>> - The client machine sends packets at a fixed frequency. To maintain the
>>>>>      frequency of the packet being sent, we use open-loop sampling. That is
>>>>>      the packets are sent in a separate thread.
>>>>> - The server replies to the packet inline by reading the pkt from the
>>>>>      recv ring and replies using the tx ring.
>>>>> - To simulate the application processing time, we use a configurable
>>>>>      delay in usecs on the client side after a reply is received from the
>>>>>      server.
>>>>>
>>>>> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
>>>>
>>>> Thanks very much for sending the benchmark program and these specific
>>>> experiments. I am able to build the tool and run the experiments in
>>>> principle. While I don't have a complete picture yet, one observation
>>>> seems already clear, so I want to report back on it.
>>> Thanks for reproducing this Martin. Really appreciate you reviewing
>>> this and your interest in this.
>>>>
>>>>> We use this tool with following napi polling configurations,
>>>>>
>>>>> - Interrupts only
>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>>      packet).
>>>>> - SO_BUSYPOLL (separate thread and separate core)
>>>>> - Threaded NAPI busypoll
>>>>
>>>> The configurations that you describe as SO_BUSYPOLL here are not using
>>>> the best busy-polling configuration. The best busy-polling strictly
>>>> alternates between application processing and network polling. No
>>>> asynchronous processing due to hardware irq delivery or softirq
>>>> processing should happen.
>>>>
>>>> A high-level check is making sure that no softirq processing is reported
>>>> for the relevant cores (see, e.g., "%soft" in sar -P <cores> -u ALL 1).
>>>> In addition, interrupts can be counted in /proc/stat or /proc/interrupts.
>>>>
>>>> Unfortunately it is not always straightforward to enter this pattern. In
>>>> this particular case, it seems that two pieces are missing:
>>>>
>>>> 1) Because the XPD socket is created with XDP_COPY, it is never marked
>>>> with its corresponding napi_id. Without the socket being marked with a
>>>> valid napi_id, sk_busy_loop (called from __xsk_recvmsg) never invokes
>>>> napi_busy_loop. Instead the gro_flush_timeout/napi_defer_hard_irqs
>>>> softirq loop controls packet delivery.
>>> Nice catch. It seems a recent change broke the busy polling for AF_XDP
>>> and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remained
>>> broken and seems in my experiments I didn't pick that up. During my
>>> experimentation I confirmed that all experiment modes are invoking the
>>> busypoll and not going through softirqs. I confirmed this through perf
>>> traces. I sent out a fix for XDP_COPY busy polling here in the link
>>> below. I will resent this for the net since the original commit has
>>> already landed in 6.13.
>>> https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=oxa164_vTfk+3P43H60qwQ@mail.gmail.com/T/#t
>>>>
>>>> I found code at the end of xsk_bind in xsk.c that is conditional on xs->zc:
>>>>
>>>>           if (xs->zc && qid < dev->real_num_rx_queues) {
>>>>                   struct netdev_rx_queue *rxq;
>>>>
>>>>                   rxq = __netif_get_rx_queue(dev, qid);
>>>>                   if (rxq->napi)
>>>>                           __sk_mark_napi_id_once(sk, rxq->napi->napi_id);
>>>>           }
>>>>
>>>> I am not an expert on XDP sockets, so I don't know why that is or what
>>>> would be an acceptable workaround/fix, but when I simply remove the
>>>> check for xs->zc, the socket is being marked and napi_busy_loop is being
>>>> called. But maybe there's a better way to accomplish this.
>>> +1
>>>>
>>>> 2) SO_PREFER_BUSY_POLL needs to be set on the XDP socket to make sure
>>>> that busy polling stays in control after napi_busy_loop, regardless of
>>>> how many packets were found. Without this setting, the gro_flush_timeout
>>>> timer is not extended in busy_poll_stop.
>>>>
>>>> With these two changes, both SO_BUSYPOLL alternatives perform noticeably
>>>> better in my experiments and come closer to Threaded NAPI busypoll, so I
>>>> was wondering if you could try that in your environment? While this
>>>> might not change the big picture, I think it's important to fully
>>>> understand and document the trade-offs.
>>> I agree. In my experiments the SO_BUSYPOLL works properly, please see
>>> the commit I mentioned above. But I will experiment with
>>> SO_PREFER_BUSY_POLL to see whether it makes any significant change.
>>
>> I'd like to clarify: Your original experiments cannot have used
>> busypoll, because it was broken for XDP_COPY. Did you rerun the
> On my idpf test platform the AF_XDP support is broken with the latest
> kernel, so I didn't have the original commit that broke AF_XDP
> busypoll for zerocopy and copy mode. So in the experiments that I
> shared XDP_COPY busy poll has been working. Please see the traces
> below. Sorry for the confusion.

Ok, that explains it.

>> experiments with the XDP_COPY fix but without SO_PREFER_BUSY_POLL and
> I tried with SO_PREFER_BUSY_POLL as you suggested, I see results
> matching the previous observation:
> 
> 12Kpkts/sec with 78usecs delay:
> 
> INLINE:
> p5: 16700
> p50: 17100
> p95: 17200
> p99: 17200

This comment applies to the experiments overall: I believe these 
carefully crafted period/delay configurations that just straddle the 
capacity limit do not show any additional benefits over and above what 
the basic experiments (without application delay) already show.

If you want to illustrate the fact that the slightly faster mechanism 
reaches capacity a little later, I would find experiments with a fixed 
period and varying the delay from 0 to overload more illustrative.

>> see the same latency numbers as before? Also, can you provide more
>> details about the perf tracing that you used to see that busypoll is
>> invoked, but softirq is not?
> I used the following command to record the call graph and could see
> the calls to napi_busy_loop going from xsk_rcvmsg. Confirmed with
> SO_PREFER_BUSY_POLL also below,
> ```
> perf record -o prefer.perf -a -e cycles -g sleep 10
> perf report --stdio -i prefer.perf
> ```
> 
> ```
>   --1.35%--entry_SYSCALL_64
>              |
>               --1.31%--do_syscall_64
>                         __x64_sys_recvfrom
>                         __sys_recvfrom
>                         sock_recvmsg
>                         xsk_recvmsg
>                         __xsk_recvmsg.constprop.0.isra.0
>                         napi_busy_loop
>                         __napi_busy_loop
> ```
> 
> I do see softirq getting triggered occasionally, when inline the
> busy_poll thread is not able to pick up the packets. I used following
> command to find number of samples for each in the trace,
> 
> ```
> perf report -g -n -i prefer.perf
> ```
> 
> Filtered the results to include only the interesting symbols
> ```
> <
> Children      Self       Samples  Command          Shared Object
>            Symbol
> +    1.48%     0.06%            46  xsk_rr           [idpf]
>              [k] idpf_vport_splitq_napi_poll
> 
> +    1.28%     0.11%            86  xsk_rr           [kernel.kallsyms]
>              [k] __napi_busy_loop
> 
> +    0.71%     0.02%            17  xsk_rr           [kernel.kallsyms]
>              [k] net_rx_action
> 
> +    0.69%     0.01%             6  xsk_rr           [kernel.kallsyms]
>              [k] __napi_poll
> ```

Thanks, this makes me realize that I forgot to mention something as well:

SO_PREFER_BUSY_POLL should eliminate the remaining softirq invocations, 
but only if gro_flush_timeout is big enough. In fact, in a full busypoll 
configuration, the value of gro_flush_timeout should not matter at all 
as long as its sufficiently higher than the application period. I have 
set it to 1000000 for these experiments as another litmus test that 
busypoll is actually working.

Last not least, I found that co-locating the single-threaded 
busy-polling application with the irq core improved the outcome. I.e., 
in your experiment setup you would taskset the application to Core 2. 
Not sure I have a rock-solid explanation, but it did make a difference.

Since net-next patch submission is closed, I thought I provide this 
feedback now, so you can decide whether to take it into account for the 
next go-around.

Best,
Martin


