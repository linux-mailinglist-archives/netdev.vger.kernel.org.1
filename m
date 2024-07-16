Return-Path: <netdev+bounces-111695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1A9321A9
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FA91F224E3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83B4D8B0;
	Tue, 16 Jul 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A8hkiaX/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6A2D05E;
	Tue, 16 Jul 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117431; cv=fail; b=PqgUZReizs50ml8APYoqvONwd4PKjXW2yjOgSOQT8hdfM+zeb/8+1eXGW5gCku2Y10120I4ozttraz1XQ9zk+IT+VPcOZyFpJmFyYS5blTobMjdJ8/wKz8SyDK+Zs7JU0KKu8GuebhzNjnOwY/uwVJNNPrmMQAvzkUEr8h6Oalk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117431; c=relaxed/simple;
	bh=uYcT2X6w5mgOwINRPIVWMWNjVywqTziuZUN+J9sfrEo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zy+8BrFKMcBEBgdRrpJfKZ3neoI0LpDpQHbnVcD0zU9Jm6+VBWrUHyT7Rk2/O55BKTEroPyIeVBy2R04ceez1DYhLgjjzMcR2XsTk6Ut+ojNxFkZdLbzskaOA3KEaCiSkgPBdKIKq7MzwncKyEtvYG7EmgJSAX7qCn9GpFE5yB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A8hkiaX/; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAYdnvLBBG4YgzQQM4lypp1AHe4CxvVEHhTvIlN1ZC/gM9o0UNA3lNX0L969A+6Z8vVl3N0lx83h+FP0TGGAqGyMupkH4TCS00yv0TDU6aGd4oHwKV/7rWxmXXWsMbCQq9j4g7+sKLbah2BWsAnAtXvBUSnVxA4Jh15Scz6nDog90LIv6aiDucS3z93jHNcXtGnfW7fJRd7INyylhW+cyiryKHrEcVhRFjmoyPGgrB7tfh+mZtgoCijYMy4fe0C/pSfHa3wXBvUV8DO5ebERnr2bdcqfzrPo56vZMsNqxE21YpbeROah49uHSFFo/1ZF4ieFNrjdrQ0slX7ezQglKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IkvKQ3h+BRao8/pFW36dFPLSenVVWv4/PXRwC3xf/A=;
 b=F0VsqSt5XuiURU3deZ3WYwqMbylboqPjOvmLn/Dr4PrjmbJ+TkVgB+bkMPnMqTUjLve2skdyC1Sr86LFfryJIe6Q2MRegsVdramwNkaFEO/MP8X3C5DthajBqYPm3ej0Ms57L8LD/Dl7k35nuvbyBEewuOq4mufDoFMLWHAZ+gg+M4gwBpiidIhWSGopYFyN8BMCi9DcvinEdbxw4I/D8cnja0z+jqSr/XsJgBT2KSu73DdHul5zqgN+ImmqV6M95RKLB2Gc6givIZYNdcHy/vJ8Q5hFaZcCcURX4l/n6c9N4TJLG7akdgPSwN/hdK/DsfU9OoE5Byai5obPbqykdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IkvKQ3h+BRao8/pFW36dFPLSenVVWv4/PXRwC3xf/A=;
 b=A8hkiaX/AWxh9SQ+J8VqirdfF3mZ9mpESLDAaT6YumIdNPtTVUAr+nWeieLhuvxz21KUKC2KKEO6rZlas62LwyQXUKZlCGtRmgGxvbLOjwO6lnmPZHrXkf/y4Uj7JUny9OKIpjbQe53UlqTNblwWig7Ubi9EcnZ6n6DiCtEQlPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 08:10:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:10:26 +0000
Message-ID: <f618e6df-d296-23e4-8fd1-94256afd4612@amd.com>
Date: Tue, 16 Jul 2024 09:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
 <b2a99894-9c20-49e2-8c76-6e53aa390d9f@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <b2a99894-9c20-49e2-8c76-6e53aa390d9f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: dfccb142-6cbd-4a1e-0422-08dca56ebfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wnh3ZGNMRHRzSkhRUXhwY1FXVitCMTI3cmNHTWkrNDdNbVJZWkJpaHBmbnlz?=
 =?utf-8?B?QkgxemhpWUVxcnkzRUZ0Q3lBcDdYUEx0SzV0Y1dOZ1NscGl5UE5hbndvMUR3?=
 =?utf-8?B?d0RJdjNrb2xKL2doYjNHTC9SNEZBdG1XMVl5enR2UER6a1EvdHVZY1NSOUpQ?=
 =?utf-8?B?UVBCVVlZYTlReXVVREEvaWxQcXJQaTF5NVdQRTh6T0lwM01hYi9yRzFnazNT?=
 =?utf-8?B?andWdjJWOW0vd1FEbTd4L1ArZ1dweC9KQW5OcnltWHBVRzZRaWcwaVVhUFR4?=
 =?utf-8?B?aE1Zcmwxd1h6Y2lWUkgrNXpONnMvMzRjU281QlBCOEFzZmJQUjk4N2t2N1lY?=
 =?utf-8?B?d1dYUHcyWSt5Zk5VUlUxbEdsYnVMZkhXcjBEbnZNR2ZuZm1QWFBPd3dKNFBI?=
 =?utf-8?B?QThlcm1xUXN3TWVFWlNCa2RiV2tlL05DejFUT1hPRHczWkNNajhLcG9rNGYy?=
 =?utf-8?B?ekl3bUxSN0NOWXFYdWI3SENEby9XR0dBY0pxWndQQUQzbWtLSmpRMUh4L0gx?=
 =?utf-8?B?dHB0NHRyR2kyZ0FUT1VpdERGaXJ4ZGQ5SkN2MSs3cWwwK2U4Zi9SZFZObmo4?=
 =?utf-8?B?SENPemZnQ1hGbjArM0s0WUlLanN6aklOTWhrc2hNd2gzR1o3RHhHZ2t3MitU?=
 =?utf-8?B?Wmcwa1Q5Zzd6bzZDa2QzeEEwSWo3Zyt2R0grRjdVQ3BqWVgzWG9nbmFFcFg5?=
 =?utf-8?B?MnoxLzZmSSttYUxWeTRmVmFpcEQzQW1QWm5IOS8xVXl6czdKQ3FINmdMU3NP?=
 =?utf-8?B?dm1VL0hSUERZd3pYS3JsRUVWOXBDWmlua2k3NXQvV1daQWFaYkJjWmlMTkZl?=
 =?utf-8?B?S2N6eGZDd3ZkVUpjdjZsckVmdjFYS0cyOUkwYVhZdnMrb2tBeE9JLzZXOUZs?=
 =?utf-8?B?NklFSDF4ODcwZ1JuZDFXaTUwNnZzdnF0b3Urc3p1QXdiT3krbXJGNnJERElK?=
 =?utf-8?B?UG1lV3dCSFV2WTB0amdOZHd6R2NaWlhCMUZ2Q3krSGZkTTZxdi9CNk9xNnZw?=
 =?utf-8?B?QVBJRVJ1R1R1dzNVMkZtZHp5NGFyZ1M2VUYxaE9SWmNjZjI2dEtQNTJNKzZB?=
 =?utf-8?B?emJVSXBCaXVVaW5GZEZUUitvZzVqU3AxNHo5SXZDM1k3WHZNWlJ3U21xWEw1?=
 =?utf-8?B?WGRUdGZtQ2NkV0NHVEpSUUFyQnh5QUhiNzR5VGVDK05UMGJhY25YRzFsSE5l?=
 =?utf-8?B?VVdqbXJXUVBwbDZBL0pmWWhjekN6c0pRMkJzK1NweXNVTmd4cVVNUkFJb1c2?=
 =?utf-8?B?dWZBQTF3SVdYeGN6dE5aT2M5cXQ1MGk4MlV0U2tYSnJFc0VrMjJwVVNuUXpS?=
 =?utf-8?B?UmpEUk05T1hESnQ3VmwyNlQ1M2tza2hwWjEyRUR4TU9ZUGkvWFNqclR1cVdE?=
 =?utf-8?B?QnJRVHMwUGNFNHI5REw3aEovYTBqOU11MFp0UTlzSkIvUkF6YnJZL1N2NmM3?=
 =?utf-8?B?elk4WFltNHlCa0VlSmo3RE1kejBYRGQvMm1vd2VYWmFzOTZ0M2JQYVJuMHZ2?=
 =?utf-8?B?VVcwZVYydy9wblNrbnhGN3J4THFQMHNwUmVaemF6VkhzeGNoaGdoRmM3dzU2?=
 =?utf-8?B?ckhCY2N5V2J5bHN5MWoxaGI2blJYYURuMWRlM0tLdXNHU0lCVkUwL1hQYTY3?=
 =?utf-8?B?WFZreURHdEJhZHF4SFNYc3FRc2N5dSs2UUJmK29jMldLZXA2UzlVT3dEUk1y?=
 =?utf-8?B?MmxKZW4yKzkvRUI5aDd0UHhCZzZlY1RBelZUbmdIMkFtTkxOak53TG5JdHhj?=
 =?utf-8?B?MmJDVnhCUHhaZ0hTOVFkSS9ZTEJtWU5XODliNDBlbFRrNUpZQkVWRkVMcFhq?=
 =?utf-8?B?R2I3YzlDMzBrREJJUmlXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGNXMThTZGxVRklzS0MrbGZJbDIyWC9FVVlVWTF0UGgzS1g2K2x3WjNMaTA3?=
 =?utf-8?B?K3NjTUUvbnNZSUo2bExrVUgzaTBqcnBUQzA3ejc4VmZxaWZ3ZkdaeWc4L2lK?=
 =?utf-8?B?NFRxMk04M0ZzTzlXMmdyaE16RFlzMEpoOFVrWUlEOStVMExMMUQ3TXdlNlhD?=
 =?utf-8?B?c3ZrOEhOWmZQcThaWGxaRTZpSHVVTXRYU1ZZY09JRTNwSm8wRnZCaDhiLzBR?=
 =?utf-8?B?SGxGcDREaEdYWHk2STNNOFBqTUNmSlRVZXhPcXBDUUQ2L3FPYk9pWUcyNElM?=
 =?utf-8?B?aW1xMWxvMmNMTHo5VXdqUkJhTHRnYTMvd0RzY2Y4VzJNT2dadkxER0hQOHZU?=
 =?utf-8?B?WGtnMi91RzV3NUlEUVA1WGRWQWlMUTZrSjU3Ymk3TlBYWmxNQVpCUjhjY3dQ?=
 =?utf-8?B?a2c3Zjg2Z3Y2RktmK3IzeXFYQVRLRXd2eXFmSlhMQUhpQ09WcG9GMUlTRDhW?=
 =?utf-8?B?TTlpZnZoWlRINFdSSUtRQ0ROSCsrZ1o3WmlTdjBIN01yclFqUWJOMVpSekR5?=
 =?utf-8?B?RFBDRGhBM294cXBaUUxOUW9VRUpuQXY2STRuVDFOVUhPcVZHbHhaZFdLb2Nh?=
 =?utf-8?B?WHRManV1d29OUmU1WmRJZ2FyU2t4MEFqYXFURGk5VXgyMnFLd3ZJMHQ0RWRq?=
 =?utf-8?B?d2xVTVlPRWZNWWM5RGh5MVdaMXErWE16ZERRaDd3TlR5VVdRTnVZM1c3MkdV?=
 =?utf-8?B?L1N2cGpxVkJjWG4rcURORDdHVmxTK0RqQVlrSCtyRjUyTzNSaVUrc3ViOXYv?=
 =?utf-8?B?Y0V5ZFBrMjZYV21mSHFjM21QKzZBMWVnU29LL2tlQTZJUm0vd1YybjlHdElo?=
 =?utf-8?B?RytvRjk2azA4THpBVUlmRVFQSnZxclB0bmFuUGZ5aER2enc4VmMzSFFRL21P?=
 =?utf-8?B?UC9pdldVdjM3R3NsNTV4NmxMR1g1TGpIMCtvOGpkbVZmMlp4VTFKK1F1N2lC?=
 =?utf-8?B?TkRxOS9JSVJaOUlaam9ZUWtETEJJUHE1UHdwT2JGamhLbVVOWWRnU1VaRWp4?=
 =?utf-8?B?a24rd1BMd1M4K2lGNEFVRk1yQ3g1bW5xdzBKVHkvTUdiekdycWM4NVk2K1JB?=
 =?utf-8?B?Q3BOZkpXOTRxb0NkcGU0eDVIejVDRk5FcFpGeXBheHI4TEZNdnFDWS9mWDUx?=
 =?utf-8?B?T0FRRFhpS2NjU2Y0YWxJY1FuMU1vK0orT015Qmxldm9LdyszaWtWeTlaU3Zi?=
 =?utf-8?B?bXZhVWFPUlNDTXVveUhjTUIySEs4RGZmWXRENXdiMGV6R2VabWE5M3JOb09y?=
 =?utf-8?B?WlBHQk1iZ01KdFdhUjZxMzNyM3ozcmdtMzVwRElsdmVUM2ZCcmp3Mzh3YUsz?=
 =?utf-8?B?eTF4UXFTQTljYVBJdkZjcnB3UDhUUFdQMnN6dEtOTVR0aUZUR0cvTUFSRkxG?=
 =?utf-8?B?Yy94a1ZLOUUrQU1BV21XdjRTTFlEQTJycGhGcXhqb3JYdDE0UzdDV1I4cE1Y?=
 =?utf-8?B?aXMwTUxpeU5NczlyMU1pbHVMRTU0WW0za3JYRlNxM1pYOVRlTVFmY29jQ3E4?=
 =?utf-8?B?R0Y3ZTlMUEdleGNGKytQa1R0NmdNb0NxVHVvSmNuTnRDdHlrK3JmYVBZSnQ4?=
 =?utf-8?B?NEZPSDV5R3prT3NkNEg0SS9SNW1mMER5Uno0K2w5a1d1alkrcXlBYUQvY04v?=
 =?utf-8?B?R0lNaUJzbjUxdEVBUVBlWGdUcVpBTGcrcjdOMzdyMzJQZ280aHdhVnpIbWJt?=
 =?utf-8?B?QkV2d2I3UnJ1ZGRwcUNZekhBODN2QzRkS3h4NU1WZ3pFN00zR1UzNGtTOUZN?=
 =?utf-8?B?VzdEYUYrWnhvdGE4anhpOU9EK3QvOW1mV1pmMm1RdjZsR3h2YW12YnFCYkV5?=
 =?utf-8?B?MFE5blIvTE5HSmMvRmhKTlh4T1V3bWtRcFRodnlDZ2JzSU1lS3Z2NURLUjgy?=
 =?utf-8?B?Q1RhaStkMjRnR1EvNVBIOG5VbXNoRzlUWlJ1SW9mSXJjd3l4cjU1WWEydENP?=
 =?utf-8?B?MmhNQjNOUWNKVlQya1N3Znc3b3ArdXpOdmJlNVQ4d2oyWDhHVzY2TmVtT3pl?=
 =?utf-8?B?ZzZHM2hIdFVoL1hJeThmODAyTmtsZFp1cXJ0OTQ5bGFncDZXRlRJc0NKb3FO?=
 =?utf-8?B?a3R5cWZvSGNsdUV5aTZMUXh1YkJGN2Nvak9RRnFVT0ZJM0RzQ3hMMTRWYjAr?=
 =?utf-8?Q?eBaMC8wE7Y0r+3SfsxlBTd6zU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfccb142-6cbd-4a1e-0422-08dca56ebfb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:10:26.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMhNNpz61T/M+tQuJxuulMAck5jb/u8kjHEAffzzG7gfTqkkI3diAQdvN9l13Hr2oL13WBcANErkUcVAnTh/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417


On 7/16/24 06:52, Li, Ming4 wrote:
> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first stop for a CXL accelerator driver that wants to establish new
>> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>> topology up to the root.
>>
>> If the root driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci_driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead defer
>> probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>> accelerator driver probing should be defferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> The first consumer of this API is a test driver that excercises the CXL
>> Type-2 flow.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 41 ++++++++++++++++++++++++++++++
>>   drivers/cxl/core/port.c            |  2 +-
>>   drivers/cxl/mem.c                  |  7 +++--
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>>   include/linux/cxl_accel_mem.h      |  3 +++
>>   5 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b902948b121f..d51c8bfb32e3 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver
>> +*/
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	int rc = -ENXIO;
>> +
>> +	device_lock(&cxlmd->dev);
>> +	endpoint = cxlmd->endpoint;
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>> +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index d66c6349ed2d..3c6b896c5f65 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>   		 */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	parent_port = find_cxl_port(dparent, &parent_dport);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index f76af75a87b7..383a6f4829d3 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>>   		dev_err(dev, "CXL port topology not found\n");
>> -		return -ENXIO;
>> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 0abe66490ef5..2cf4837ddfc1 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -65,8 +65,16 @@ void efx_cxl_init(struct efx_nic *efx)
>>   	}
>>   
>>   	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
>> -	if (IS_ERR(cxl->cxlmd))
>> +	if (IS_ERR(cxl->cxlmd)) {
>>   		pci_info(pci_dev, "CXL accel memdev creation failed");
>> +		return;
>> +	}
>> +
>> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
>> +	if (IS_ERR(cxl->endpoint))
>> +		pci_info(pci_dev, "CXL accel acquire endpoint failed");
>> +
>> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> there is no need to invoke cxl_release_endpoint() if cxl_acquire_endpoint() failed. right?
>
>

Right. BTW,  I do that in a following patch.

I should just add the functions to the CXL core here, and to use them in 
a subsequent patch where it makes sense.

Thanks


>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index 442ed9862292..701910021df8 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -29,4 +29,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>   
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>   #endif
>

