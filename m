Return-Path: <netdev+bounces-151034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E689EC8A5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79549165256
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBF20967A;
	Wed, 11 Dec 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="byyiCmLD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FF208995;
	Wed, 11 Dec 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908546; cv=fail; b=TEujbevZXTdy3CNuHFzsb1FK9JUXyAERynV6cafWKZLb2ifsocCbPN3TXFxeHDCZjYeTqy74SIyQYfnQYkRb/FfmzBH56BRowcGegYC1afdpvue+5VWIb/Z95H3B8TO4ECYKWAHizw2zzKb35CFKCg4v0mjfVfX6ik70ff+1AjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908546; c=relaxed/simple;
	bh=KK+Ih4U4prZ2exfT1JXNtwRQptVVp5+tXRAoXPZFnk0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnUtbMJdLgT1A6hwQWrNJypYrWaabnzMcveaSMVbcunvXKPRrsfBGLNL9kKBQ91l1kMwn9JzLcYpbAXy38NcAU4Hd3wcMN21VjVXIPuOLIpcMEh/DAprJRBUwMWevjxCBi2Kl9zwW36IlJpP4nYPg7r0SdfW1DI0dDzOVCtdgBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=byyiCmLD; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj6JHseV1dYf18anFQq/NYJMI6GbwmIzrWCZ8WYdHfLnSZapH2y9WV0KBYrse2zK1vWo/vy0ORA2CH982Y7Y/Cg4C3BLlJal4NmKWIsd8k+hPzOMivK6mpOMDfMrKJcX2zOnBPdYpusOiSt0X0m9ow5KGIJggieZXIfne4/AW1UunrXPHgXF9KklyOJcsDeVY8D1eX9AJXtVYYcqVD8kn8VIqShzXDWJsrP2ZHx5jwRDpFzhhPftJn9xmTSlZUH4QWfuKcn2smQ/o1892CMNi6ycjF5I+GdtAjOpQne5P+/Yek1Bhb/boEM2Ttpjq6tK6+Vuf08JZUTvlP5vphtpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqM4225XYMzXfI482i8NU40JZryw14l5x8JE0itMmJ8=;
 b=SOxNlzhAHik0kX4NHzM0yxCp12LzZixutMVrRPtb3pQtMN8MBvc/DphRSz8I95adIpXLhxFuKijTdjSE+/pVtRZirKCvHTNwFJw4XcgTHy3tfN6JLqj6ui2wQNH/C3v83dz/w6NV+vKERhvCjc/QXlRf/NmRKNJ0sUjoSkWGzVuqrH+mUD8VGTKW3elI+VaZva9kFU26vfOeaMvGUha196FRBC48m9AzD9geEDwlZCW70oJrApvu2QsMHvFjKxz76PTJx6fITued6hzM3QUeg0ZidIYD848a4tUAcmu3O6eb/7AGCilcvVk4lygp6oIIIcyHTbSXV8HQ9YQARGGGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqM4225XYMzXfI482i8NU40JZryw14l5x8JE0itMmJ8=;
 b=byyiCmLDWVdWfWacglE90AhYxzkE3t8iM5MkB7klne6CiOK7d6WpEijgguKoiiKYXoNQayNsiLy+2icwBtEL1c6D9kJ42MkAnNiw5hRmzY1C7eoZ55uXiHhfd2ta3lOCmjN4ckNwFp6Uty2Osd2qYYK/Mb5Fm2v/E/0GFgJzUt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:15:42 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 09:15:42 +0000
Message-ID: <2e6e24ed-d0aa-f4a1-5215-32053c7b45d0@amd.com>
Date: Wed, 11 Dec 2024 09:15:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 18/28] sfc: get endpoint decoder
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-19-alejandro.lucero-palau@amd.com>
 <d3646edc-281a-1e43-4db3-dd4b29e4ef3f@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <d3646edc-281a-1e43-4db3-dd4b29e4ef3f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed42ff2-a88e-44d4-6676-08dd19c462f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmliT2NteHFtYlVTY2ZNUlRRTmpkbTJ6TjBXMWFrMW1kSi96RUdqcDRUaGRR?=
 =?utf-8?B?dzlWQzdDQXo2bnFSOTAvd20ySmhTdjhBYVVOL0M0ZEd2aGhpVDI0ZW15NWRr?=
 =?utf-8?B?TXJGMDJFRm9Cc3NCQ0xtUnpVV1kzL2V3YlozWXNhL0Q4TXRUcCtJY04zYWt6?=
 =?utf-8?B?cTRRQ01FR1BnYk9tTjhIenhDR1JmK0ZqR3N5dUhjY1JaUkNVTkNkejN6Y0RQ?=
 =?utf-8?B?elpIZlowdGVxRFczaGZnVTczcUV1d20rRHk1ZkRjalhsOUlBeVU0M2ZFUDF4?=
 =?utf-8?B?cEprQmNzUGRUQU1RVUV5U2M1NWY0bXNwbW1jRDJyYTIxcGUzY0ZCejFPd2Ux?=
 =?utf-8?B?TFJNdlBSUFo0RThlUmhERzBVRDRrR2RhMkhIYnMvQ1lyWm5nZ1huSTlObDl6?=
 =?utf-8?B?WVF4R08xdDkxYW9mYU4zZVZPaU9QV2g4YzJXN292Sm9mQ0pmN0lxTEU5dmoy?=
 =?utf-8?B?TEowc1pSeDlUR3lwc3U0Mm9uTUp5TGtrMWpnQ1FtVmRNTUNlWExjWm9UdzJI?=
 =?utf-8?B?RGt2ZUEwS3hpb2YzcXFyWFFQcmhrWnpFZkpYOENEcFRRSlpkOElWQlgrZkVi?=
 =?utf-8?B?MHZUeTdhd1hvREd6YUFBMnlGYmw4QzFMNTRydWFranJ5T0lJbTlLMHozeGJC?=
 =?utf-8?B?Z2xiUGFybzVOZFcxN25nVmFucVljMkFoc2FCdU4zWTdGMnViRVJUMEdjcDlF?=
 =?utf-8?B?VnFVNWZ0bDU1VXc4K3Q3ZDR3ajFKWmdyWUsyNW5qdGtndXZMR3dpL3NILzJj?=
 =?utf-8?B?QVNLZ3lMc0M2dVA2em5JWDlhN0NocnpOYXFOS09GZS84aUZGQjNlMG5tOXRo?=
 =?utf-8?B?aTViRDBGZllSbVVGRmFERUdpb1FTM1Jpd0MzQmlCVFl2ejhCdVM5ZWdhZlBo?=
 =?utf-8?B?cml2VnpXZFZtYkwxSDZLMmJyZzgyZGh3Y0NEMlZvUUpXRmg1amt1UnArRW0x?=
 =?utf-8?B?cXNxY01LNHprTjdPdGRVS3JuNU9DR0JVRUhWcWw2Q2J4WFZKRTQzZS9VbFB0?=
 =?utf-8?B?T0EybUJJOFhBT1RmVC9TMnQ0dnE2T3lWQUdORVpMam1PdFo0N0U3TEVYRk9O?=
 =?utf-8?B?c3hqd0VhNzZxLzUvRDJHTFZBZ3V4N0cybVFZd3BBRnJYdTVpdWVxNm8wTUZ6?=
 =?utf-8?B?RHY1bThCTmc0ZjNTcWNOTHRQd2FyZFNUVjN4aGdrK0M5SXdBbVFIbGw1L2hm?=
 =?utf-8?B?QnJPMzZTZWplNzhEcktsQndXenIrR0YwOU9id3UxVnJvRmFYOVdJY3AwZlVj?=
 =?utf-8?B?OTFHaFd3c0RQL29zMm14S0YvM2NmdE1SQVZoRmJobFFvODBUdnd1OUNLOFkz?=
 =?utf-8?B?cGxtb2VkM3BKOVBibm1idSt6dVpKUC9zejBrNnVyN3AvcXBxaXhUeGV1b0Nm?=
 =?utf-8?B?bDZOeW1nV0ZwaGQvS0VYdVN2UXFaSnpTcHNOZkNEdHI5L2ozdlRGRUpXWWNJ?=
 =?utf-8?B?NUFqaVJ3blJnT1I5M3RuSEZlVEVpN0g0dW9WSEVhTS92UEZGQnRPSE9TalB0?=
 =?utf-8?B?TlVsUGdBVVVIS0JIMzZkeGY3TVlKcDRJLzZWeEVGZUxNbjNMZm1rbU9xNDRX?=
 =?utf-8?B?cFlBTDVCVHZvMDRNdnRyQVNJMVkrWUREMDRUTzUyTy8zN3FkY1hkZkdrQ0N5?=
 =?utf-8?B?M3IvTXNnWjBZVEllditwbjQ1ZUVlNm9hMEZ0dW10OTRwLzF0aHkzL0VTODZC?=
 =?utf-8?B?cS94RHMrSVRxQ2FYYlp0dzlBNHdhdmlPQWlqTXpLT3ZXQmNWOHV2L3Zab2dY?=
 =?utf-8?B?R3hWd0I0Z01mOC8vQXYycXNUejI5SDZVcFZBNld5ZkZzMks4ZDVWcnNlTXNw?=
 =?utf-8?B?V3N2akdOTklHZlRSRDE0VGFBdUxYdm9oTkpNWHVHbjFQdEhycnM1WkltSFQ0?=
 =?utf-8?B?NUVWVzlKY2RCQk5xY2FVb3ZrVFpyM1h6bGc2K0xNVXBLUkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3NmMUdWT05aN1pCMDlYVUFHSXpVRUF2QUJyNlBYK2ZrYkNEYmJaTVo1QUZs?=
 =?utf-8?B?M1ZrV0hJbS9ab0UzNWtjM2FueVlqOXVVcllXL0ZVcGNMSXFQNFVpYU4yZzJs?=
 =?utf-8?B?TVVWY1U1a3NMbjBxbmlpcjg5aWFzUmRmdklJTmdjMndNU0Fnc2t2dUhoU1JO?=
 =?utf-8?B?UkY0VkNXeTdUaENIUWZMRWVLTXRGelU0ZldhUVlTMXIrLzAwUDc3dlREM3Vt?=
 =?utf-8?B?ak9KclVXUkNsTklBQkNpdElnT2ZEbGZJSEFuSTB4OGV5elA2MHVESlhtNU1D?=
 =?utf-8?B?RlVLcFlTdGJlQkF2NFNjWnI5cHpUNUZZWFF2WVMrYU9oVklvNWs2c0cyb0Fu?=
 =?utf-8?B?UG1oSStkY2ttZnYwWENCcW04Q1UxNVhTaVVrMjY1L0g4TDVOaGc5S0NZUmNI?=
 =?utf-8?B?eWV1eE9DV2lOOG9HUVVBOXhBeWsxOVFDSURZTWJHbnovZldaMFdZV0Rtbkt4?=
 =?utf-8?B?N1JENC9ZLzRwZkhwQ1o2Q3A3akZtV09IeUdPMWJNN1JEeEJYcGNYWWc5MnBM?=
 =?utf-8?B?YVJPUmNETkxzNWw1U0hTaERTUThoeVBNTkVhRFp3VkVuMUFvdDdUQWFNNkZx?=
 =?utf-8?B?TngzNW9wVEh0QTNiT25zUmJ6cnZlaDhvalUwdkl2QnZLRmI0QWFkQ1plL0dy?=
 =?utf-8?B?Y1NPVHNDMnBoR1FHcnpiSmIxTG02VVdZS24rd3ZleUdHVE02dWNtSjFkcUxZ?=
 =?utf-8?B?aDJ0Yld4MVd1cjhJYWZyYTl3U0M5LzNCdWdFbzZmYXhqdmV1QW9ISXdONXJz?=
 =?utf-8?B?dEV3SUROaFNOMnFuMXhsdXR2bmFNSy9Cc3huN0FhalFXeloyd2xuMFBVV2ZG?=
 =?utf-8?B?d2tJRmFWNXpCUjVzcllaL2ZmbjRIeFltSWxJVWpCc0VYNndpanhGRHR5K2VB?=
 =?utf-8?B?L0t5ZjVtN2ptMDVFNHNPeTNhalloS2txVG0yc0pMWC9tOUtnSWt3SW9LVWQw?=
 =?utf-8?B?akdITi9UNTVmNTJ5MkdieVpLTlZ1QUVtRzI5bG15OVJ4LzJiODFHK08rZ0tQ?=
 =?utf-8?B?TFd4MUxMVXREZEVocnFOZkdnSDZISFUvTEM0ZURUeSttUnZoQ0NtTDBFZG9H?=
 =?utf-8?B?amNub3FiMHRLMldtRHhTRHZvMVV1Y1dEdXJGVDQvTjdTUTV0UjNMekdYMVZV?=
 =?utf-8?B?cHdXZ0JYNG91ZjdlNmI5ZGJuQUNMNG9GZEo2MU1XT3ZpQzRiQUZsYkpoRUJh?=
 =?utf-8?B?ODdqTFFaQitNL1FodHBtcDRQRnRNbVBPNWRTekdRTGx3OC9YUXkvTkpVY1VL?=
 =?utf-8?B?cDBVWWkrcyt6QVpTSVJlRGl2eWoxRm1vbHA1YTJlMUJkTFpEMlhNdSt6SHhD?=
 =?utf-8?B?UVNNemJ5bW9pMEp3b0Z0S1ZVc3hkNllOejh5Y3hOSllpWThxbDEwcVZLQnIy?=
 =?utf-8?B?Wlg0V3I2L3hjY3d4aXQ4Y01RQUtyTXBVeDB1cld4c2lxdDduZmhoWVVvQkIr?=
 =?utf-8?B?akF0NFkwbTNKaUV3UFZIOGNBTGRpM0hNcE1WVjZpYjJPTGNtcWcwS2tGUFNC?=
 =?utf-8?B?cHc3dFc4RXZSZVVCNGZxallCRGpWNEx6TDdZcTd4S1pLR0p0NnhxOE50aU9l?=
 =?utf-8?B?dVk4RjU5VDJXZGd0dW9ncUh0aFNYdmdJeFFxWk5aVGdaQitpQ0UrWm9TalpJ?=
 =?utf-8?B?WG9wcngzbUxRQlc3Y0krTVV4ZjdVanIyZThaeE9XMWhqMnAxRnhud0tQRXVl?=
 =?utf-8?B?YUFmOE1UY2dCOHFqL1NOUVcvdFBQWlR2V3pycGtqa2I1VS9KdG5zRGFXenVr?=
 =?utf-8?B?RGZ5MUxPdFN0dmljbFcyVWcxQXlrWGQyYXJvNWRoUUpzUkRCVTlwdVNNZjBB?=
 =?utf-8?B?bDBJVFJMaUVieEFBMFFnU0RxM2tqWnpNNWVrWFQxcVdCTDVvK0hNYmI5Undm?=
 =?utf-8?B?UlE5LzZ0TWN5NXVSTlpJMHBnaEl5ZDlMc2FjMSt4MmtNVE5PdXNZU3NsekdE?=
 =?utf-8?B?cU1ETUtCUUN6Z2pENGRXSkdoWGU0TGIvZVY3Q0M0cVVUTkN6WE00bXRPNzZF?=
 =?utf-8?B?eldlT3dxdDNxelNxSE51Wm1meElydXBoVnVlWkx3Tmg3TWZyV1NKSXhZdmJi?=
 =?utf-8?B?OXRCeXE2Q3BUL2tZSUFIY2VsZElEdVM4OHpSR0lRTmtDSXZJQlBUZkQ4eUtU?=
 =?utf-8?Q?nOcsn3Ro7xIymB1Ps5XAUjByE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed42ff2-a88e-44d4-6676-08dd19c462f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:15:42.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMyZ979XcNv07wW2SmO0wKFO3yV/L3KaC0U6qYlqnPhOfk2ZDIsnAZOflZqw86NZNXExQHrrAGqIZPw0IKqlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246


On 12/11/24 00:25, Edward Cree wrote:
> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>


Thanks

>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
>> +				     EFX_CTPIO_BUFFER_SIZE);
> Just for my education, could you explain what's the difference between
>   cxl_dpa_alloc(..., size) and cxl_request_dpa(..., size, size)?  Since
>   you're not really making use of the min/max flexibility here, I assume
>   there's some other reason for using the latter.  Is it just that it's
>   a convenience wrapper that saves open-coding some of the boilerplate?


A device advertises CXL memory but the Host being able to map it depends 
on the current state of CXL configuration regarding CXL decoders in the 
path to the device and the request itself.


Our case is simple since we rely on having all that memory mapped or not 
having it at all. And we count on our device being directly connected to 
the CXL Root Complex or to one of the CXL Root Complex available, but 
CXL switches and things like memory interleaving can make things far 
more complex.


About min and max, the former specifies the minimal driver requirements 
for mapping CXL memory, and the latter tells about the maximal size the 
driver could be interested in. I think this is more a legacy of how 
Type3 devices are managed and arguably not so important for 
accelerators, and for some as ours, not needed.



