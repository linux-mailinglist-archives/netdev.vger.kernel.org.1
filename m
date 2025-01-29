Return-Path: <netdev+bounces-161532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0265A221A6
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357721684DC
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFD1DDC3B;
	Wed, 29 Jan 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BVDqLgc/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DC28EB
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167695; cv=fail; b=dbsP7WdLt+mCs8JWAshRjdSDonRUDD6a5w0V9R2VyWqQtnU6XeCdD5zeSCUek7UU4Q50mt9FR0yM63ixqYZYheliADtstPKsJ8wi8R7U/HeYlTGHmEI38xru05HkTIjWt3qobZA9/atlrN8I6oVkOKJzzHrtwBpfTal0mOALrbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167695; c=relaxed/simple;
	bh=a6fVWkRc3kqcD7s8E4BHc5XyJCfiEfTNV3b84Y53XEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cd27wwuEWoJa6rYiQFIcbPSaEZBEhGy9DPyvLA9aKbwmh5ehcQmrUQeQzr+YOeSuq21A0aEgRGHJrmqQt/5lT5ZqBEUX6idBglKB6+I++lfxX/kjGsZX0eEHiVzlC0JXQXgk1+qFwurHJUmwqRcC69oj5FJ3wzM8ujbZ/zJ8YCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BVDqLgc/; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ2J7SMPF18fuD+wJytO/y94hQFhjLi9pQB3vgrTpSuOeueYlmhiqH84IF5Jj052I8j6dHa8/7uJmoM9FMQlAbFOzqPL8OMv299FkSLZjaH+sTvF8mEYkO6NeRszP7zzU39uMwKsPbH/fXZUqxXlOcRXa+412DGpBBVKg8o7oyk/c234KjRGDEL0sBYepJ6xOCpJgaG50FUFVvvjyhrLgT1Pul1So/35WaN842K5u7x0j0dInNlihrITQFZ+0AWJgKXkdQwbw7fEkxagFfLfnPRzhREsBfZBDX4l6WsDC29gQBy1Wq3PkF0cJyVgRgVBGhJA1FXI74a2puff0W95Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKV8dFTLyD9H92ZQFih+izk/p9hG/gT0fN4o9Ea4z0o=;
 b=ih3lnNTo06gDHEnbJYh26fv8YvuBb6SVoBea2CFsabgGsbjbs3uj1hSw9DnN50E77pODkwWF5AAXynzs/rz5GMu4HYGk3eYKbWU5+t0f/7ghKHPPHJxIVAqnFE0qqoYR1PJtIUg2Gjx3Rpj+AQbI8lbXOU5RudI1zl5atUThkigYTNNk4yrhx+uLOKaHTeYFH0aMSNXcdIcwDOdYh0rfssBFgDXE/5HyMsjkFciJkravOLP6hYDBz4r7x0SdSBKu4hKMRKvWjz/nl5OMjmPPYS3RaboIrtPZ0NN8O17gkU/IOjVgeQ0FVqpjUNeP12NrbxIU/cHWA2NpzXGkinEllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKV8dFTLyD9H92ZQFih+izk/p9hG/gT0fN4o9Ea4z0o=;
 b=BVDqLgc/Ng3wmk8vG0WkaUSgrb/J0lLwu2irWvHL0N18w+CEhfWwbRWy9Bhv+A7tJlOQjDv/3FC++CpMvzqUHFI0Wys8eHSgjd/ooWbXIZguiHwTFSSxLaGxNMiceytUO+5OAb7TomZy/GmprFrzYnyuxzyQ/o9VSwFTWeOxCZF3Vms9GmaY6GhHkYKRtyTMvo71VTrAJ6XmdwIEdslZaG5Mhb/4lU2fwd9Q7KT9O/GqlRcon2AaMiRi/QQb0ngpmKQ2IW27jgTjPu03KhVZC7qveJtPFnygFJzsfpxfjxv2HQv9fRISnSzH3+FILj5lNbpL/2YtnmxLmFWWipieWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 16:21:30 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 16:21:30 +0000
Message-ID: <049d3a80-1b51-4796-83df-efb80f3b3107@nvidia.com>
Date: Wed, 29 Jan 2025 18:21:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in
 (un)?register_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <dc118ae9-4ec0-4180-b7aa-90eba5283010@nvidia.com>
 <20250127232634.83744-1-kuniyu@amazon.com>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250127232634.83744-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c53e9a-0da7-4bfc-32c4-08dd4080fcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXN1KytMNmFWNUZhZHdRNE1QOHdtelMzcDROMk1pNWFQRGFremJVbE1NcUZ3?=
 =?utf-8?B?WU1tM2Z3UjJvam5ya0lwQTQ3dlB6OFNOZ3Y4ek14bFJ5a2dRQ09hc1pNblFV?=
 =?utf-8?B?WGNmMXk3T1FiOVBMaW1WMERHbWJBYzNvcWVYRzNQS0hzN1F1d1pVZHp4ZDYw?=
 =?utf-8?B?czFmcm9hL3RtMXBRdVlOclF2SVl4cWZXSHRZc3lhTmJWa0xZZVRTdnhlaUM2?=
 =?utf-8?B?NHBqYm4vNEpwWHZTUTQzRTVGRU9hZ3VZdkp1WFRPNm9QT004bmhScEVoaXhp?=
 =?utf-8?B?SERTNXdMNEU5ZTZRVVA2Zm9jUGZ6U0hZUXJWWSt2UHAzQzVLL1dRQ3QzZFAr?=
 =?utf-8?B?T0FiMkdZb3RTdnpDTWYzNkozK0doVzJ3ZmFndkQ2U1hucEpxMzFSRjdlRVJZ?=
 =?utf-8?B?Vzc5QkZwNHNZRlNMaitXcmg1b0JmVEZXM3BhbENsT0tlOXo5WDZKaWd1UlRq?=
 =?utf-8?B?ZlVXRnl0YWtTOXVzSUp5QzlWeFBXcXpKbi9kMFZHSk4wNnFZSG1GWHhsZ0FL?=
 =?utf-8?B?Y2srQkw1N0hINVpHUmpudlJWTmxsRVM0YnVoYml6elYxakVhcE9Zay83bExB?=
 =?utf-8?B?ZEJBMjh5N1pDMVZMM25NMEpIY2UzNGZTTUhLWlB6b0g1dlB4cDQxTXJxQng1?=
 =?utf-8?B?czY1NjBRTDJ6c3dLN1QrcnhoNkw5S3FuQjRmcjBXekt5RXdVWVpzNnlWRkNw?=
 =?utf-8?B?N05NdVpubUppcVBlajJ0YTQ2STA0bm5MUms4OHIyRFExdnF3dXVkMExqRFBD?=
 =?utf-8?B?UEFLYzVzWG5YQ2hDekkxNEN2T1JJMjUvWlJRN2N5emlVWHRJWHdyYTl1OCth?=
 =?utf-8?B?dVY5K3JZeC9hS1A1aHVNaURmRU10YlI1UGVpTVVTTE9vTUdxT1FOMStCY0Ja?=
 =?utf-8?B?Y1MzZFRsVHZIUjNnWlRxOWhaaEFPeTNEY04rdU9VZVVsYThKSGM1eDJ6Zll0?=
 =?utf-8?B?ZEZRQVdxbnZqVTdoMERjZVZNUUhpcGF6ZWpxNnhXa1dUbUl0YXplNjR6QkZE?=
 =?utf-8?B?NXBuaHhSdjlPNEhTK2dtdUpScVpQSHZnRWh4c3F1R1VQUDlQTUhxcUFNYlF3?=
 =?utf-8?B?MkJtcjJBNTlRdnNMM1ZtaTd6UFZQWGVMQ2QvZ2pub3poMGhqRkd4enFWa2I0?=
 =?utf-8?B?YzdJNGtsZjNJdjBNdVVWSStDRDl2bk91ZU5RZ05SLzJodGdRemF1YU1VR2lI?=
 =?utf-8?B?anZHRjhtQ1crT1JxR3Q0QUM5TjhOWEErdGxEWE5nZlhZbmJxRndBNlpyclFQ?=
 =?utf-8?B?VkorUXBhZ0J2MzJaSmxUTGx6MzN4V2hmR1BNRmcxTE4wSDlqU2FmdEF1dThZ?=
 =?utf-8?B?d21vWnF3K2NoZmZ2SnB2YlJrRS9lZjZqVVZDc3RJakk3MHgyRFFadXhFVG9P?=
 =?utf-8?B?cmxjbkpEclJ6aXlwc0ljUk9KVTN0OS9ORnFxQXFPSE8zZ2g5eEhNa3NoSGEw?=
 =?utf-8?B?bjFWUlNPZGxUZGtCT3JHbWdGNmtjVGVHdTBkWXBHc1VyczJQelQyQm5OZzhC?=
 =?utf-8?B?eHgwNXU4SytBeVNtdUp5YVdwaVd4ZUttS0U3ZzZSVGE4U0tkTHhqKzIwZTZ1?=
 =?utf-8?B?VmtMQ3ZxNGQxSnplbzhFcFdIUElMUHhVVHg0S2liOVYyNGFkNndhMHNMeWpx?=
 =?utf-8?B?bXdIK1ZyVU9PWUQ1Z0pVRlJOdCtNSTUrMm9hZ2Y4NXBzVEowZVlqa0h2Q1Rs?=
 =?utf-8?B?c1pKM2k2bFZocDl3RkJNdHVsVjVPTHFkN0JjM2hMWVZEZHpUYUNKVytOYjF2?=
 =?utf-8?B?WEE3RGVxYTkyd3d5R3pEa0doZm9BUVRpOUM0NTV2c3oyb0ZZQXdJQWFJWm9Z?=
 =?utf-8?B?NUtza0sxV29VQ1R0RS9HR2Y1bmVzeEZGaGpTZThBQ21XdXRPVHNqbWluVS83?=
 =?utf-8?Q?97AGDOc2k9BbL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJHVjJpOGR5Z1RNRGY3RDVFWWpReXNNL0RVTE5iREI2Z3BoR0VlbVJDZ1U2?=
 =?utf-8?B?bmZZNHZIUWI2UmdNRkNpa2QxN0R0N2VBZUl0VE9TTysrM2VWWWFOZnlBU3ht?=
 =?utf-8?B?cU9Pajk1c0dLTlJiTXV5eUx4RWpXbXZvSm9Eb0xnOUdQKzFxdTB3ZHp1Zmp3?=
 =?utf-8?B?dU81RS9BWWtyVStMajNhaWsyVkRhYzc5YXE1QU9YTExua1FjaGc5NjZTa2xH?=
 =?utf-8?B?Rmsrc1I3bThnRzljbTFNcUdUbzhvdXJ1UG9DM1h6dzBnTWtFM1NSbEhCWElT?=
 =?utf-8?B?ZmJSYVNCUUVEc0tFUWl1bGZPVlRTQmJnU3FadEV5QzdydVJSKzVDZ2x5TUIr?=
 =?utf-8?B?SDVUbkZYejIrVXEyRDJLTGtFZ05LTzVkaG9qQ01ubWVDWU45SEpnTXREbTI1?=
 =?utf-8?B?YmxtQUw2clArS255Vkl0eWgyM0ExQWdPcUwwUjlsNE4rR1cyV09EdTY1eWVs?=
 =?utf-8?B?WEVBVCtOQnF6MmxvZ1gwMGVIZnJzT21PZzJoOGRaTkhFSVpEZXNGMWJPZnQv?=
 =?utf-8?B?azFaUXptK1FpcTVuNzdncUNFRXFEOFpYU0FUckJYYVNpVW5mSVo1dStPQ21D?=
 =?utf-8?B?a2FnOGFzc0pvcEllaUNaQ1NWcklZTHV5QmRZR0FHT2ZqSzBLU0MvTGpoNFF2?=
 =?utf-8?B?Y252amNZQTc1QkZKd00yZitTSXY4cjJUcWRFQ2NHYjV0TjRVeWYzdlBkY3FE?=
 =?utf-8?B?N2o5aS9YbXIrNUtKOVM0cHVRY3greGhZRlRUeEF3bjB1dkk1V1UyZWwxK3VX?=
 =?utf-8?B?SktSS2ZQcGNFUTAxWkNUZkhiSmt1ZUlPaDRveFEyUVFNZHZSallTNTZncTFU?=
 =?utf-8?B?N0NUWElsRzBqSG8wbFNVZGVhMmRUNS9YTmttcVFyYXFVYXpxekZtMjhkNmxx?=
 =?utf-8?B?VGNHalRScWljYkI0YkNKOHdlcFhMckhDRmRic0h4dFlmdnZtWUcvRVMybDBx?=
 =?utf-8?B?R0hoemlkaGpLa0d2KzNkWUZwb2NQWTZPR1FFSjRraDdqZE9LdDlGcld4ZWd2?=
 =?utf-8?B?bERvUW5EeEtCUTdkQTVvQ2RtRFFNRnhrcWdwN3dtUFU2azlOT2hqa2QvQzVV?=
 =?utf-8?B?Zy9qZWJISUZWQ0doL0prSGFPTHZKYk9zdjJQSUp2SjJMcjdTbUZRbUx5VFVi?=
 =?utf-8?B?KzVFV2FmWDkxMmhmRmhYOEpaeVJ0MmJ4QWFkTTRSY2RTWUhIWlRjOElzUm44?=
 =?utf-8?B?QkVXZ0UvTEdZSzROWmo1OHZ0Um4zb0h3OGpENnNVSkV5cGhjWnEra0xSbFE0?=
 =?utf-8?B?RGJaRkdwMEdVL2k0Y0t4Z29pSWFVYW8wdWkzRFRBTStQV3ZOdzZ2Wmk2LzJz?=
 =?utf-8?B?VGxYeTRNWnhFRFByTGFtVnhPRWlSNFpxajF0VTZWdWdncG1BOElRMlJpOEMz?=
 =?utf-8?B?T0FPYm9XbWN2VnlQZjJEZndvaDAxdDlkd2ZMTDNySGtGSVRCQTZBL204QVhQ?=
 =?utf-8?B?bk11TzRsZWE5YkRnNnZxRjhEUTB5MEhDSVBGeS9PRm13dGRaY21KZHZtaVBx?=
 =?utf-8?B?TDJWcHdVcTlhV2ErUWUzYXJkZXVzVG92ZnkvOG1nVW16aStpRU45Vm9lQ2M4?=
 =?utf-8?B?SWRyRDZFZlhxZkhSZHB2dU5iWmRTZFRqODI2d2ZXaFNUSXZQdjNFbXpDUXdF?=
 =?utf-8?B?SHFqZEFjelZ1MTI1ekNDdWNQNVNBZzhhR3BMb3FBMWFqNlFBajVPY0ZSUjEv?=
 =?utf-8?B?L1JBSHU3cHBLeERLVkJuSitOdXlwLzhoanAyVWd5dmpiL2tyajlheTdpK3h5?=
 =?utf-8?B?eXljSGdTT0ZGRFRaSC81bElHbWNRbDRnT3R6a21udkxmY0gzcWIvRysxN1Y1?=
 =?utf-8?B?akxXMFN4OTlNQ2tXZnhVSFl1MEp5NGpKbmxNeEtkOVB5Um5XY3c0cktnbTEx?=
 =?utf-8?B?QWdReUNRSm44NTZJbGY2MjVDVEN1MjAralpjNnpqVG9BZC9XaEFEVnpRUzJt?=
 =?utf-8?B?VmZzNVhNaEtWUHFzd0Z3RDNycTRoNm9uRFdPam5NQktWdEJMWjBsdlpSaFB2?=
 =?utf-8?B?MzVzYWN2SGZYNXQ3b1czODhIRXJEa2xFS0cxOUR3bFlXNUxCZWJiT3dGWmE5?=
 =?utf-8?B?Z251NzlxaDJZNzJmWmV3VmhjZE5kWWVtV1hKQmp6Nm1zNm9ISGIxbGFzNUxm?=
 =?utf-8?Q?jegBFKHr3vdALyTgPptF2Wt8E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c53e9a-0da7-4bfc-32c4-08dd4080fcbc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:21:29.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY36TkHfbpg7BVYHGGx7LCLzCdsYozKEijIRVPrqhTixaeEkTr+NRlGl5SxF/P403cjpPWQ+EvfMSO8CYVN7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235

On 28/01/2025 1:26, Kuniyuki Iwashima wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> Date: Mon, 20 Jan 2025 20:55:07 +0200
>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>>> index f6c6559e2548..a0dd34463901 100644
>>>>> --- a/net/core/dev.c
>>>>> +++ b/net/core/dev.c
>>>>> @@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
>>>>>     					struct notifier_block *nb,
>>>>>     					struct netdev_net_notifier *nn)
>>>>>     {
>>>>> +	struct net *net = dev_net(dev);
>>>>
>>>> it seems to happen since the net pointer is acquired here without a lock.
>>>> Note that KASAN issue is not triggered when executing with rtnl_lock()
>>>> taken before this line. and our kernel .config expands
>>>> rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not set).
>>>
>>> It sounds like the device was being moved to another netns while
>>> unregister_netdevice_notifier_dev_net() was called.
>>>
>>> Could you check if dev_net() is changed before/after rtnl_lock() in
>>>
>>>     * register_netdevice_notifier_dev_net()
>>>     * unregister_netdevice_notifier_dev_net()
>>>
>>> ?
>>
>> When checking dev_net before and after taking the lock the issue won’t
>> reproduce.
>> note that when issue reproduce we arrive to
>> unregister_netdevice_notifier_dev_net with an invalid net pointer
>> (verified it with prints of its value, and it's not the same consistent
>> value as is throughout rest of the test).
> 
> Does an invalid net pointer means a dead netns pointer ?
> dev_net() and dev_net_set() use rcu_dereference() and rcu_assign_pointer(),
> so I guess it should not be an invalid address at least.
> 
I logged several values at the entrance of 
unregister_netdevice_notifier_dev_net when issue reproduced:
1) fields of net->ns (struct ns_common):
count: the namespace refcount is 0 (i.e. net->ns.count, used 
refcount_read to read it).

inum: the value doesn't appear to be garbage but differ from its 
constant value throughout the test.

2) net pointer (struct net): value differ from its constant value 
observed during the rest of the test.

hope this helps and please let me know if more info is needed.

> 
>> we suspect the issue related to the async ns deletion.
> 
> I think async netns change would trigger the issue too.
> 
> Could you try this patch ?
> 

I tested your patch and issue won't reproduce with it 
(CONFIG_DEBUG_NET_SMALL_RTNL is not set in my config).

Tested-by: Yael Chemla <ychemla@nvidia.com>

Thanks a lot!

> ---8<---
> diff --git a/net/core/dev.c b/net/core/dev.c
> index afa2282f2604..f4438ec24683 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2070,20 +2070,50 @@ static void __move_netdevice_notifier_net(struct net *src_net,
>   	__register_netdevice_notifier_net(dst_net, nb, true);
>   }
>   
> +static void rtnl_net_dev_lock(struct net_device *dev)
> +{
> +	struct net *net;
> +
> +again:
> +	/* netns might be being dismantled. */
> +	net = maybe_get_net(dev_net(dev));
> +	if (!net) {
> +		cond_resched();
> +		goto again;
> +	}
> +
> +	rtnl_net_lock(net);
> +
> +	/* dev might be moved to another netns. */
> +	if (!net_eq(net, dev_net(dev))) {
> +		rtnl_net_unlock(net);
> +		put_net(net);
> +		cond_resched();
> +		goto again;
> +	}
> +}
> +
> +static void rtnl_net_dev_unlock(struct net_device *dev)
> +{
> +	struct net *net = dev_net(dev);
> +
> +	rtnl_net_unlock(net);
> +	put_net(net);
> +}
> +
>   int register_netdevice_notifier_dev_net(struct net_device *dev,
>   					struct notifier_block *nb,
>   					struct netdev_net_notifier *nn)
>   {
> -	struct net *net = dev_net(dev);
>   	int err;
>   
> -	rtnl_net_lock(net);
> -	err = __register_netdevice_notifier_net(net, nb, false);
> +	rtnl_net_dev_lock(dev);
> +	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
>   	if (!err) {
>   		nn->nb = nb;
>   		list_add(&nn->list, &dev->net_notifier_list);
>   	}
> -	rtnl_net_unlock(net);
> +	rtnl_net_dev_unlock(dev);
>   
>   	return err;
>   }
> @@ -2093,13 +2123,12 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
>   					  struct notifier_block *nb,
>   					  struct netdev_net_notifier *nn)
>   {
> -	struct net *net = dev_net(dev);
>   	int err;
>   
> -	rtnl_net_lock(net);
> +	rtnl_net_dev_lock(dev);
>   	list_del(&nn->list);
> -	err = __unregister_netdevice_notifier_net(net, nb);
> -	rtnl_net_unlock(net);
> +	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
> +	rtnl_net_dev_unlock(dev);
>   
>   	return err;
>   }
> ---8<---


