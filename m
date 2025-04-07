Return-Path: <netdev+bounces-179661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCCA7E07E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C75517CD39
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48FC1C5D75;
	Mon,  7 Apr 2025 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nlaUjo2H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501771B2182;
	Mon,  7 Apr 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034469; cv=fail; b=p+UvcQsIEGsEvSR53bw86LtHjMbIlzsyzYHs1S2lbdYYReZEkJjXgFc8MnDjGXJR/yG9wkd+N24fJiUv/aHHIw4nINlkxnYEpSZTDq2VIEnvEcmC/vc3Xo7NVBY0oLHuJGIewYjeQBtziakGpV0g5reiJyXw9xweoh7HJtl7C94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034469; c=relaxed/simple;
	bh=qF5uW4IK0jRXShI2H+odbTEZaXHMRsOXMNiWkYvwRtA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4F5cLDpOS2MnYenLati8x0biOmUoeXv+mDUpuLasXmP/9ytvUuHP5OkQIUpkyhvQI4tFA186lw3VMUzjr6f+eKhYjM1Me5qQ871EaNZDWAs82+1a4YLQapSibJ3yg6HDUc8vBk6RGbaQynmwyIIx0A98chqL4x0Cxl+mTD1ygM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nlaUjo2H; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKU2NJhL4MgH8pRSADmyscFQFnsbKp4Kvw+EnMdqUNhzm4+3xPbR3aX8SO1cVgE6N11DRyBkEsc+DgX44aAEBEjL1vophcsdwf411HW3oBR3liKvM4sDOryHW3pjMLlRRKZUaqTiZghfUISEd5ldEcmLTx/dfaJJa5hn47j6xaxwGRnt/FNZk/idNuDu8c5lTfiAxAJ2bxV5XSaxWojwfrHcbnoIY4UKCTHjJ4T66liRLaAQmYkBt+jyf7BdrL1OfHPNxAk2liFBOtXRYZOnChAnBdka7rwrn7XlrRaqo56qkqqSAiUhvNNduew93g7/ggpB2vy6JcekwSZfpiaKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQrzPVoLLSL/4yrDwHhB78Kqf3DKXpiS+CFx8Is6b9w=;
 b=M3Dvf1CB6mAYSn0TWKzKmKDYa19RuZKddbxIsDXYntcPAUE1jXN0k5PvsXVr2h5uRMABP4DPer+8DNZMgA3pbMhLHqwFIqhEsO5CR3WDmP8u6lZ0B4QfGdNrq/hV0WyFpaHIv97I02a57dXp6OzKQaxVBWxQ0pDe/NQbjxBX6G12exY/G1CK8ROZCNI1ROuq5xpxM2JhTrw9RwHkcXmKDhzwQHJGeq+upwnjn8xAhAWBXfoX4Q3nVwKLex8Y5frRqH5FkaBJLs1pEt7skUiMyXfm14qyuFK0Y2EGQ0JFSTI9SxigG+d1aqZ57FqXQ+Di4gY4zO8Ad937wpcP4I5QuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQrzPVoLLSL/4yrDwHhB78Kqf3DKXpiS+CFx8Is6b9w=;
 b=nlaUjo2Hsx7GqSwtXeFKGB8vNtL+bKGM8wpJ0LCl4dEL62lWWC4VHEZjpsDN26qc5W4NW3CdehYFCoIskl9SW8kDSDjBWSr/eg1ijHzfXc/NbHfT1LmO6vIlqzDO/e8Ph+5gBQfLqc/YLNBvbNHze995idUrMQimbClKwo84RRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 14:01:05 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 14:01:03 +0000
Message-ID: <69ba5cf8-4d8d-4476-8171-48f91b4b9dff@amd.com>
Date: Mon, 7 Apr 2025 15:01:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/23] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-10-alejandro.lucero-palau@amd.com>
 <20250331183444.GG185681@horms.kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250331183444.GG185681@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c875ff3-fb8a-4303-56e4-08dd75dca25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJxTCtvYjNmZHhoUWFLWjhITXhmc1RJV3gwOFYvL0t3cTBORzZZWFVZVktD?=
 =?utf-8?B?V0NFTE4ybGpOR0xsT01IbE5xemw3THlTOWVubWp1VDQzNy9iN09KeWpyajdI?=
 =?utf-8?B?ZllyUEpuWHRUV2hnWGpGSzB1dkNweWs0MWYzaFErOVExdWJGTEdpNjZHUTdW?=
 =?utf-8?B?UGxnbVhsbFEvaDNqZ0VzckF5UnR4YkhiRnVxZkNLTU44K3R4bFVodiswbnY5?=
 =?utf-8?B?TzNIS295YjZ5cFNrR2lmVjhLMFROL21aaTZFMHhZMUR0TTVteTFHQW54VmNU?=
 =?utf-8?B?MmpHcDRqazVCNjNLSWhDSVZaTEE0Z3d2c2lVeEgxV3YzYnEvbHVRVTkybTdv?=
 =?utf-8?B?VFBTekxndlBKZWNBajYzeVVqekdmUUV4ZDdoV1JQSGcxVysvQzdVMy9MckFT?=
 =?utf-8?B?UXVncTJjNWFoSXVsTktuMStaNnZ3dnJRVDBpd2craDNnOTlIbFNPMmx6b01z?=
 =?utf-8?B?VnF4RHhCYVhnRnRMQmZ5WUdpNlhwUmwyNTlkM3djazNnTGU0cktOOXdJa3RD?=
 =?utf-8?B?b2p0RGEyTW9LZ0RXaGZZU2ZZSmhxNUZoeUFtendPSVVLUWhxcnpSOFRtbkdM?=
 =?utf-8?B?WTVSdFUzUWdnVVYrSFp2WlBOcHhERldxMytVYWtDcmI3bWpId1RHQkhhbXJ5?=
 =?utf-8?B?cy9nNW50ODB5S3VEdkU2d3YrN2ZNVmtELzhXRC95VUx5WWpFeVVFbnMrczBB?=
 =?utf-8?B?b2Q4WU10d05qazFyUnM3L0Q0dHRTYzdXM0lzZTVGL0l1bkpTK0ZjeGxBcEhX?=
 =?utf-8?B?UStJZjR1OExDUGNnSjA0Z1Nkci8rNlFFSVQ1eWpzcXpsb3lLMVlrN3NvKytZ?=
 =?utf-8?B?eVp0RGx4V2VJdmp6OHM3TmdFU3EyS0QrT2liZ2plSnVZTjlibnpqMHBGUVA4?=
 =?utf-8?B?ZG1IS0dLZ1BHYUgxaVZoY2Iwb0dqN2lBUzBZNTg2b0dSWXV5UnVPeUpBc3NU?=
 =?utf-8?B?Zk8xcVFtaGg0NjRjTVloVDcxOXdmTS9rQTFLL3pxYjlQbXNHdmlRTkhXdVhU?=
 =?utf-8?B?TzJ1WXduNFluTW96ODlHQXg3cGExL3BpUVc5bDdWcUZPQkN6UzZ3TFNJWEQr?=
 =?utf-8?B?RERFWUZJNTRybUFhV1hkVFJrQW94TzRZOUwybUxjRngyeEEzeWZlUjFyMUlL?=
 =?utf-8?B?SHNrK3R3RUpXTDJyR3VXMXpRMmZPQlZJanNmbHExRDRrSnRmNU1yWjA2MzFq?=
 =?utf-8?B?MlZQZ1ViYTJHaERYU2JieVFHOE83U3czWTRIRjhzVnpJeTMvbEdqdUxlVkhv?=
 =?utf-8?B?cEd2cG5QdGhNT2UyZzR5MytUQzg5dGVtRXNXUXV6L2JoUzdMemdOQzZlR2JP?=
 =?utf-8?B?bHlGWW9FVUhEYjJzd0ZqQlhHOVBIN1UxK2NIdUdiblVoaC9sL1JNWlAxOTlJ?=
 =?utf-8?B?ZzV1WXJGYTdVcWRTNHVMOHMxUjc4ZWhoVlpTVHBScWJKMTN4OStTbVQySlpw?=
 =?utf-8?B?LzVEckhaU3RaWGR4NE11ZTROSTdJT3A4WDMzVU40ajBnR25pajZpSnNXZ2ZQ?=
 =?utf-8?B?d3Viamt5bEk0b2ZHZ0wwNVpVL3B3MStBcFBVNWZuSjFvMC9kYnVKMStlSEkw?=
 =?utf-8?B?SEZYYkI5MFJqYzArYVltRVBDd1BCQ2tLK0gwYVZQMHdzQjVvSDhVTEdYcm9v?=
 =?utf-8?B?TVJBbE5TS2NwSC9PMnZCNTIrQnpvNFRlZEVDbDlYUEVmbnNUZGxsV2dIYWZE?=
 =?utf-8?B?aCtmUk5SWTFQNFN1OFVhdjBFQ0dIR3l3R1JxYUk5ZlBjZVltSFdhaWpZbC93?=
 =?utf-8?B?TWFxdFJVc3dDU2F6WlF6LzNpODZsVnc1dGVzb09udmZ5MWxRdURZbVFaeU1m?=
 =?utf-8?B?WkR5RzlMRUpIVnUwRldNY2VPVDRmbm9kRWxMSVVPRXI4cEphdEk5emxaNzVM?=
 =?utf-8?Q?nWugVRjv4RB1S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNYdEgreTNEcjIyRmE2M2hsQVJVWVlnY2N6RnRHU3ZrSThUcDVxNDBrc1hM?=
 =?utf-8?B?eVNPRXV5SmYzRXJKS2FXMng4OFA0Ykg4QzFndEFodE8razlGYzRPdmRKTk1v?=
 =?utf-8?B?dm9PYXQ2bG5XTFdQTlFxWTFjQU9yMjBucGpjSjBCWGZIc0hhd0NPRy9sY3o3?=
 =?utf-8?B?c0NjdTBFUlloYTVqdkdHVEkwNGFyQ0ZkTFRLSUxRZ0xyZGdoT2ZxZHlxK0Z6?=
 =?utf-8?B?NUt6WmZuaDhsdmVVZHRCK3V4a0ZnMmJkbzJZUTBESFpHbmw3ZEN2eVRBWFln?=
 =?utf-8?B?U0FTOTk1QWlRMVVicEsrb1ZsNkgxdFJlOGh0WE5FRHczb25EcVByRGdQQk5E?=
 =?utf-8?B?WlJHS0lGV1UvQkNseGsyZVJRUVExeWJETm53Q3dad1BSdSsxK2p0K0h3Ulps?=
 =?utf-8?B?YzR6M2lsNkJBSmhvNE1iT0FHeDhZWHFXdU9sQzR2anAyd09XbHMxU1hoOGVj?=
 =?utf-8?B?aXJ5MFhRNUZMNHRIckFNbitkSVkvSnhPeDc0ZUVUa3J2ZzB1cmZRQkthZGd4?=
 =?utf-8?B?Znl0WXJubjYwYnEvUjBhK080dGRTOHh4Y1lLRmJLSDg1Z2c5YlRwVXh2MWxR?=
 =?utf-8?B?NkI3bnowa2NGQzZrQUlWeVF0VGtBdTEwemo2VUl0dUpUSVNob1duWXRGalJj?=
 =?utf-8?B?VWhrT2ZpUW05V2FWejdUZzFZM3VMWkRHNFhtbE9nb2tTWksySHBsYjRjbmk1?=
 =?utf-8?B?R1dPY0tEdlpXNDhOWFlFNUt4YzBWTXdBS2M5RUs1TWgwQzNiVlNLQ0t6YlRM?=
 =?utf-8?B?c0N2dGEwcDhjRU5uRHJzWU9yZWRBNGlpTmp1bUhwN3piYWpDNitGQlJNQmJu?=
 =?utf-8?B?Wm9pNnZSV09oS3k3R2J2bk1KQmlkellUdEVSWFEyZEpQVDlsQlY5OFA1aXBr?=
 =?utf-8?B?YVVDeU9RYlBXMEpncFFYOXI1dXJqakVLUWFadnI1ZXlGb0tQODB4RFJnSDBp?=
 =?utf-8?B?UXQ1NWlnak94b3NKWTlJbTFQb2VhcllIbVNrakR3aGZ1WWlKeWV0Slc4bHc2?=
 =?utf-8?B?cmlhZUU1djhkRVpwcEpVYWk2bUdxSEZNWjBQZ3BTd0NMRzcrS1Rvc3E3R1NL?=
 =?utf-8?B?d0FWdTdJYlNGRzREMGVtTnNoYVA0RnQ4YmY4cERUd2xTMkl3cVVRT2VyTERZ?=
 =?utf-8?B?OG9hK21ZZy9KWEFjQUljQU9DM3l1RTAwTWZCOFBzakpPdkpNUkJTeUVMS0pw?=
 =?utf-8?B?VVgvNnZnUWRrY2wzUW9JUFNMV2M4N2NoOW1LQWh6bDBlb0lKSDBBcUNKNDl5?=
 =?utf-8?B?YnF4R2oyaDZIS0tnN1ptS0pyYmloNDNrV0I4SFhQK0tIQ25IT3lxTTlRZTVa?=
 =?utf-8?B?RUdHL3NWM1owWDdQUVFIVEJxRFFUOFEzL2g1Rit6aDB6THgyaFdIeExnZmhP?=
 =?utf-8?B?ZjJyWkhDRmtiZCtFRzRNZ2w0RlZydUpDS1BGaC9rSzI3VlFBWi9UeWtRWmJs?=
 =?utf-8?B?enc0SjNqY1A4SWxMUkZqMzdQemtpNEJ0NlJoSnhiRFpYTTVjVENsM2xmRWJ4?=
 =?utf-8?B?NEtWdGpWK3hNZ3pSVE5WVFpLcDFPcDNINGJOczhmaUJXMlZJOCt6UjFDdW1s?=
 =?utf-8?B?K0g1N3ZhcmNPV0hWdThWNFVZNEh4U0NEWUIxVERzd2l2bElVTkdYQTVDRlNL?=
 =?utf-8?B?eXRham4zbXc5a1ZUZld3T3EzMktmUmt1d010a2ZmSEV3SHdFTzhoOVE3TXhS?=
 =?utf-8?B?cWg3MWRDdWJTVWQra2tSNHNNWExmK1FrYWtLVXQ4T0dpZC9PZDk1ampnbVp4?=
 =?utf-8?B?ZlJIZTYyVVlsSGRLRVd6YXR4QlZCYmNjSVZIaG9wbHRleE1iN0Nwc29PL0RX?=
 =?utf-8?B?L2lJY1YzNzVzODVjc3F0WlhEWmhqSWJQRjFtSzg5VGZvaFo4eEEvYm1XMXNy?=
 =?utf-8?B?Y1ZTZnNaZGttcFBZQm53VlJoMXNTMWQrS0k2VnQ4cEplQVViWEFTVzUrd3Ux?=
 =?utf-8?B?aGFHOWcyTWdSSmhyTC9TckxNUUZUa1BvQStLZXYyNTA3V0RtOURPTUEyU214?=
 =?utf-8?B?QVdCRi9DN3h2UUJVczF0NWszY2E5bWhneWR3ajRTVzZ3WndGM05Xd3F2a24x?=
 =?utf-8?B?RFBhYjRxZ0RzeFhtMVVUQ1V0Q3ptTnZEWXpmeE5ZREZxYldMK3V3bUZMMFB0?=
 =?utf-8?Q?YarmEvochfFw+qsRnLo60QbfO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c875ff3-fb8a-4303-56e4-08dd75dca25d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:01:03.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLOolgcK/qBkZr7Uvo4uD9z/FiY/nyvFmoFgH1WMA+B7TjgEflUno8nwaDcTMsXHp1UiyRc+JLFXIEM51niK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658


On 3/31/25 19:34, Simon Horman wrote:
> On Mon, Mar 31, 2025 at 03:45:41PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type.
>>
>> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
>> support.
>>
>> Make devm_cxl_add_memdev accesible from a accel driver.
> nit: accessible
>
>       checkpatch.pl --codespell is your friend :)
>
> ...


Thanks.


I'll remember it.


