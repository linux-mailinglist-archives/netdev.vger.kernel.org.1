Return-Path: <netdev+bounces-243006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA938C97FFE
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 16:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 649F9344D2E
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DA31CA7D;
	Mon,  1 Dec 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WJBD9w5e"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7E320CA4
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602112; cv=fail; b=RBG2DehfMyXctS68nyOpdI9m3LhxwMSWY3e3h4pIL/ASEUlnB1Ey4grds+vmDnfyQ60kt7mWBNkwBWHHBc4XbZmxtFOI/z62HHCrPqNiNpkRTTnKUM/5T27gNq2KmLRBTfjlF7oI+Iu+oVCwqXzP4+C/elUMKpkF79mRWNEv/uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602112; c=relaxed/simple;
	bh=mobL0J8dXOCTgdsVCZ+/WXJE3y8pORALaQX7n0FGyZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTwlaIJ2fRHOoXPttbF2TjvHv40d1mYngVDklH4z64vV3064dQGd4NIXAEl1VKI/vQKkcsUUPlsEPJ7HAiTDr24daAU9LdeuydcQiu9QmuLJDRCp31fkogXoOa+/Q53EdE+vcLto5XnNsTajaqVrQIhP4QsIymu0CA/A7v/rWmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WJBD9w5e; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+WsGEhJF2dgknEOfTkNe4rBHgr4P3RQ4tZHhRvFl+ZJiSg/egrktZr0Ql0DkK4zOb39VJRe+eySm4CWp9/zs+WVftynZcUKs7MyMvoTwnLSlhRGUlagXNNWeUmJdFMleSEGIOQDMw337325SBHCdaN7NDkuPAgSRYjelr8LfxLmrYNQeInW+7JJr/Hd1jWZDHDZJSySvE5IJ7zaTSK687kwIet0TXb2v6xjLEgBra6uKsUU+FXJ58Rwr+QErG0vSvOwHJYHTA3NKMg+fyZ5az97UYgaSdn7l/q6bUOvbO0zC/or+stlPd4HHYahTr6NPr1ig3UVmdAPfrqHpNGO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf15zEV566IiEHOUpnHqCLspYJV2CfSNkkwpqmO+3yo=;
 b=i6Vfoe15DPUdp8d/FTlnrJxlpeaGCjcfoN62B9APcjcSalq90sSpmliI6A7tGJqtW/6oFK3EcMOQeeUfJeMUv4o7mwMuKkU24VpvmAh2oCSsJvQQkJGSLZezFztu6p4F2dQWUb+vOtcfKm81UIxRpcUzuf6bGvJS368NKuPFxRlO0MBwxpRQU+HCIWrRM+abqr9lZpA8sgsz6RWmSOJr5p5IraH5FdnxH6wATVoRV4qhKNvcsJQzkQZhI0h+9I30fqIh/RXgRGBvcz0edcU60JzsREY1wXEI8Fbu1E9c+lkq+nTQLiLAFuFBexfvybj7WG3YQY/jKLc+Eto1xsQXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf15zEV566IiEHOUpnHqCLspYJV2CfSNkkwpqmO+3yo=;
 b=WJBD9w5esQy27RccF4dzsH8KbPB4ZntrNjZi6zHvvj5N3mzgky4Mxxjbth9JH4u5jtSE2z3LfXxEd40MxRrMJGHcjbOLDX3GggIzts9cQFVakHUL1PB5WuY+krbV//3T7lJNJ3RUDNlDDm2yzZ4F/ACSPkh/BZsrqE95NfZbVE7q27KMSNcoMeLDQJl1dlddJIr0CmQcV3EKvU/I6LqlMTV5xAXHHm8Xf8HEWpa6GZ2S02qfIAJa6ugxHKpd0yMR1Di3P0IY89H1PzVTn6TkC2MhZ0TgQ4mrco7DBTNU8GPiZGjlrnx0y0qunrHnxqn4Z8Qkg2QCGEHVHIQuH2GJDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:15:05 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 15:15:05 +0000
Message-ID: <23558074-ee4c-49ec-80fb-4be7f4adf825@nvidia.com>
Date: Mon, 1 Dec 2025 09:15:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-6-danielj@nvidia.com>
 <20251126182919-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251126182919-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:806:126::18) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2716b5-e72d-42fa-d02e-08de30ec6814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkR6OUFhQjQ3MmVySkRqcHI1QzNaNnlVUW81eTIyQnNhTGExeWVQKzhtWFVR?=
 =?utf-8?B?cmh5OE11cHdWQVNBM2t6SllDbmVBd0RMcGFsT2ZTZGhBVFdQekN5Snl2dkhQ?=
 =?utf-8?B?dzAwdEs2N3pWK3hmMWhFS0JIRFcxWGszdUZzNWw3T1pBb0lSR2UwWE9WaEV4?=
 =?utf-8?B?Y2pUYXFQM1VqR1F1aTBhaEV1d0lUN2VVMmUycSthSS9MSElhdzIzR082d3A4?=
 =?utf-8?B?M0dlUFZFWWRDK1hUYUQ3Z3l3MTJXb3pFZEFhWkx0QTRyY2p4cDJWN1JXb0Z2?=
 =?utf-8?B?bHEyaDhnMmlCVnU4ZnlCSHRrdzJGeitBYWJ0b2pFUjlFMTYvNmU5d1VjV2cz?=
 =?utf-8?B?RFU3MUdDL0RvOWRyRVpZa2NZMWlmNXVwZ2grMDBBUm5aU29laVFlUjEzMGJv?=
 =?utf-8?B?QVBKbW55cXcrdEtjdDJXa2Y2K0o1c00zMFRFdVE5cjJCL01JWVBkaVdqM3Fn?=
 =?utf-8?B?REJoYlZha29tOFVmNno4RW1CRk4wR1VyTUdQeUtUZjgzeVJRNkVZMHBmK1Q4?=
 =?utf-8?B?c1E3WGg1eVlINXpybGdkTUpDeGZPRjNOdnZwVjkwaHpmc0R2Umo4UC9ONHlF?=
 =?utf-8?B?Q3lySXlicStDSnN4MTdMMnZKK3B4M0FxZ2VMU1lhSkhieDVhNUhHZTZDK2kv?=
 =?utf-8?B?UGwwZWdqbkNTYW5KR01TeWdZVXV6enY0RktRS0FWUkFzTGhTNmxQcHk2dmsr?=
 =?utf-8?B?b1Z2OGVOUUllVUh0R3J2N0E1a2prNXFGV1pVc2VRM0ZxRVNsQi9VdFYyM21I?=
 =?utf-8?B?Z21SU0M0ZnE3NUFUcXN2VDJyam1DcGpKcFJhaUZ3S0hYU2FDb2hiSDBxeEoy?=
 =?utf-8?B?dE9XTXNmQWNFeEFsRW93QnVCZ0xGQmJhQU5GVEUza3RzYTkweXdEM0lyNEkw?=
 =?utf-8?B?cndZN2hxN3hiaEIxV3RPQkV2VlVTVFpQbUZnQjQ2bWw3VDJuM3FnT0NzaFls?=
 =?utf-8?B?QUIzdUxOM2o0cU8xT1hBVE5kbEpPUGQ2UXBlOE5xRFNRZFBlZmU1aTdPc21s?=
 =?utf-8?B?c25TQkoyWGpnM0c2eS8wRFczVVdPVnZBajZCYUxxYktjWUdiamNtWFp5NW1I?=
 =?utf-8?B?VGlEdXdXQXBMaVZxOVl3QzgwaUtlNlVkRGt5TnhDUEdoeXFFd2p6ZWxRVDI5?=
 =?utf-8?B?WTJlZUJLYWZUQ0tLNlladmU4NWlQVFVUR05mUjJMWWdmOXRoTytYbFR0YXIz?=
 =?utf-8?B?VlVaUk9Fb3NtTFRhWEIyY285Q1cxVThsY2FUNnExS3JUVFVldysvYjJ4MC9k?=
 =?utf-8?B?dVl3OWpLVGNOcnRva0wrakkvdC9mMXlLVERoTnlhcEhaQ3NJSFpYQjBnYTJZ?=
 =?utf-8?B?Y3BRdm9STnozdHc3NURVcVVXczZsdDB3T0xzejA5ZTgxNzhGVExSN0Z6RnFU?=
 =?utf-8?B?QzhkR0lQZDZyK2o0a1VLKzNTeUsrMmQwV28xdGFoRldYeWdlVEkyUXQvQ0hx?=
 =?utf-8?B?NUN0TWdTUGw4ZXlSMGtBZys2ZzlaNXEySE52ZjdvSGJMNEJNUkNEQmJ2RStM?=
 =?utf-8?B?dFgwSDBKVG1EWmRlTmZ1Mk91UnZ6Q3NDcHBmY0ZHNFNtNWVoazVpZXZSSmNO?=
 =?utf-8?B?UVdkRzgvQjBUWUl1eC82RUdDalpNQWtld21mKy9INmUrVDMvNHhlblVFL3VS?=
 =?utf-8?B?LzFSL3NDM2tYNDl1Vko1SmVQMkErUnBwQnRnQTBsWUJpU3VPL0NUWEdkbWFT?=
 =?utf-8?B?U0ZNS0o1NjZ0TWdSenFOaW1Ma0dsUzcwSzZaN04xSklYNkg1MkdheXBWQ0d4?=
 =?utf-8?B?OXNTTWJhTHpOS0VMSE1oKzBCZnl6ZHZYdGZmNmNhV1diRVNMY2w4cURUOUt5?=
 =?utf-8?B?dlgzK2pYYysrMWZnU1Q1czI1ZFNJL1JhWkl3MUE5WUFGakNxVkJQUjdDd2xi?=
 =?utf-8?B?eTlrZXhZRnNMS290czgzZy9mdlNPeUNsMTdXd3phV0JQNHpDaDdyYlJYUGcv?=
 =?utf-8?Q?7djEysmO8S7NxRazWMFM3tk7rGiNAzSj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1VGYjMrNU5qSjUrTGtEbm4rRTJYYzJVRVA0Tm1PMEpLSWdRa0lWMFZrbjJx?=
 =?utf-8?B?NWpMUU8xL3pqdlNybzlsZXNlR2RmRzIyd2trMnpTd3VHUm9WMXhpUkFJVGdB?=
 =?utf-8?B?TkNTUVRpbWRpbEl6anJPSTNBY0R5M1pnNldmcXMwRDZzRzV0WVFHcVd5Yzlv?=
 =?utf-8?B?d2lFeXUxWjR5QUwzdjF5eTkwNzl5RU9TMWd3RHlnQXczT1pMODVCME01dmFx?=
 =?utf-8?B?THJUSHY0RHNOam01UFFmNHdnSm1zVm0wdWpKejd3ZmtJQ0xtcFkzekcraHhI?=
 =?utf-8?B?MExQeTF4MHJxQnU0RFpKT0Ftc3dyQkd3dlZldXZ4aStRbENhcDZVTXV5UVY4?=
 =?utf-8?B?d29QUmlYSXM2VWJvRUljWlpjQnRKQkpQejhNU2FJam9lelhBQWIrZGp3K09Z?=
 =?utf-8?B?TnBITURxWDBIUzZ5TEZrWXdXbkMwbkZzeTFYdTh2eE1iUFNhaXVnamhEdjBQ?=
 =?utf-8?B?UWV4WHV5NkNqOWllcmpnOTFwb1RicjVhZHBNS1dFQmUwdFdNVnFnQkV6dWg3?=
 =?utf-8?B?N1ZuODlEajlsMGdRYm1TNVZRWVBrbyt6dUNoTFpvaXBuaHcybHR0MHpYSHBO?=
 =?utf-8?B?OTFZbWJaTUNuWkFvVnNqa0JjM2xhbENXUFRnUmFRT0ZHdG1heXBOMHBSMlRI?=
 =?utf-8?B?TFRUR0hNNzEvTGREcG5qMkxWQnRtKzJraXRGVnRZSHEyczhoeENPY1ptY1Bo?=
 =?utf-8?B?eW12VW4yb1VhOWxJUmlUeU5EZ2NBNk5rWkM0eEFEM3JWSWVUU0ZyZ25BRUdN?=
 =?utf-8?B?RzFWVDM1WU9ZVEZ4ZCsyL0VUTjZHL3ZFNi9BTFJZbVRucFFiOWsxWTVPYmEw?=
 =?utf-8?B?Y2FydWVSckVkSmRDdXZxQVhDdkhlN09tZmRvOUo3U0tqd040RjdSQkhrUHo2?=
 =?utf-8?B?Y24vdDdtREljRTA1NUF4bDM3ejlFazM1Vkp1L2ZYOFA4eStjaUtJVjlhcHRW?=
 =?utf-8?B?VE9zUXZtZXVQY2RRYkhmRVA2WDdLWkliMDlFTll2V05QbUNFN2tVeDE3Ry9C?=
 =?utf-8?B?Uy9GOUpFSkFhV3lRWDhkNUJiV1JjQWNZUUM2K1FTYkcyeGpiZnpoYU40R3hB?=
 =?utf-8?B?eS84enlyMUo1Q2gvSVFydHluWXVmMGhCTEdhckM4TkJQL1dWeWRkUGppTTZG?=
 =?utf-8?B?SUZLU1hySWtBdFNURXUzaDFoTnZua3lSeHYzMHpWNnhwL2w4Z01XTjFodXBz?=
 =?utf-8?B?dlJSOEpOUEI1SkNGNjFmK3RyUjlENGZXSTArOHBDVlM2R041bjRYcEVqZlQv?=
 =?utf-8?B?a1o0eVlSa2FZckl5UEl1TTBGVWk0eGlBck91Zmo4bFY3MGZITUozcFZSNW9T?=
 =?utf-8?B?SERKajFZamR1TjF0MTlQOWQxTVlzcVBLdUt0NXB0OEkxaDdBOWZHUHBxeGFH?=
 =?utf-8?B?Tm1SLzF2dnZMd0Q0T0ZMWWtzWVlVcEt4c1kybHpsVUhBQ2ZQT1IySXJFaFhq?=
 =?utf-8?B?OFA3U2Qwb0lwTDdSM1AzS081YS9sdlN5V0hQN21GQkt6WHdLVVduSCtReWUv?=
 =?utf-8?B?NUVnaHRkbTRFQ2N6a2p2ZDNVZ3JDYXJtS2ZhQXpMT0NsN09ubmxUMDFGL1J3?=
 =?utf-8?B?SGdrT2tDTHl2ZVZnQ3lhQ0IvWmI2eE1nMnRZejBnbkZtVjVjNFQ4NVBpWmxw?=
 =?utf-8?B?T0NZNE5iWEZDcURXakR6VGtEdXZ1aVE4SE1lS29JdEdnRVhIajI1RmtNZ2Iz?=
 =?utf-8?B?dXB2VkdHeVdhb3BDbVY0MmxtRUM2TnkxMXIxbHVzcENoQ1VEVXRleENxWWpV?=
 =?utf-8?B?TndxYTJoQVNZbzZOeHhmb2xyc1dFYjNlZkhORUhzT09aSWxHekpXZE14MHAx?=
 =?utf-8?B?ZVFlZTQ3K1lXNmVBRUsyZGZPV0NRRDNlWTFXRWtNcmI5bUZGL3NHYkhOZk9W?=
 =?utf-8?B?RWtib3hiTmhPUUJpbXN4a0p3VkozbUpRMkdKMk02cVFnT05RdkZlMHJPUXRz?=
 =?utf-8?B?MHg3L0djb1o3NEZ2aDNtNkJES2RLQjdrRkROd1UwUTF1Q3VPSTBaM2tBNEJQ?=
 =?utf-8?B?a3VGVXcvcElBMkpRMm1hRVNwdU05elg5cFRNM3d6T0hjTVBSdDVlZmdQYjlj?=
 =?utf-8?B?WU9hdFVSblNSZ1BxQVhhMkRQQXplRmEzbXFOaG91QWNnMlZmK2hQVXlobm5S?=
 =?utf-8?Q?ty5sfCeUSB/3Hu2xvWNdE/o3N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2716b5-e72d-42fa-d02e-08de30ec6814
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:15:05.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pzZJc1dfoeIPtox6eyMQIChytdFt2K1iFgN5BrFw+yPkC4I6j6zQPdznDUKVgZRYC8hwannwz70mBZ+7IvpGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

On 11/26/25 5:31 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 26, 2025 at 01:35:32PM -0600, Daniel Jurgens wrote:
>> @@ -5812,6 +6019,17 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>  			return err;
>>  	}
>>  
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	rtnl_lock();
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		return err;
> 
> does not look like this rolls back previous
> initialization on error (probe does).
> 

Thanks, I'll address it.

Have you reviewed the others? I'll wait until Wednesday morning to
resend, unless you confirm that's the only comment.


