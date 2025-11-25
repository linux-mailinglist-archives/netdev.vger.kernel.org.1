Return-Path: <netdev+bounces-241340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BFC82E74
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07EB534294D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B57B67E;
	Tue, 25 Nov 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NuKeFhWB"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EE1BC41
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764029135; cv=fail; b=Qqx/vG3Uepv6uanu3PqgQ3vJFgO7NMRdiNO+uMnzP+R47xgTKzhN3hQRPlk4ZZZGSVzpvBq7uLHO7ILmAFdFEA12Oc0MaQqGViGh046RL6Vfo68LaLWcnw7DvkK/dtegJXokBlcF6/IfOds1zke0R14UWafBoA+lcJnjv4bcWy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764029135; c=relaxed/simple;
	bh=1F7RmHVoUt0cFaUuSWsVQelFXOQMtQ6kiMnCls9ffRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RLNT0BIRJS24PyFbvUsX7TYc+2DxaUlnsb1t/3Uo59SBVF11VlGJ/AhKG4j24fZ6Jar26V9Ph+ISgBuQt21ykE8gEsoiJrKZurE2ZxtsogcvqEdHpu0CeTDBvclnxw53O4eCVVCWKl/QxhbXpsdUVn7lo0o98uB2uKERNCEiWkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NuKeFhWB; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiYwO20WKLW9iY0BUH74HvpFfm3yMs9HpLIavkIDrS6N6LI0WvQI7KTvryTzKWvgybP0c4qKToNnzfFyYtROZ3Rze1R8sUtBcPKyCzVWj4XvKOwdcR0q3ucfg8cJiaWB6Q6eDYg9D6ehI3nwy8ZzCidPF8mjoV7JMUWoERpEOocRDKTq58by4WUy0L7a5wUFCEqQod2xmn/jKSVmo8eDwlKmYAu/d+c/uhGk+yjc4m67QLDGOKW5iH/2t9VRzpCqXTF56YP1H9IFqrNalZPBRWjoIz7oCxKbRnBPPgm0ff4SsESTvg7A8M+5xIUaZi9OItQ/lcdigMEshuykdhPhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN932XuAlQgX90Y9pTlJanSeYIjs+R0TrU3Kke1TA/Q=;
 b=AFYIS5it86yBeg01sCc1VFBJkZ2j6HxCWTBSbcSQYVYbrWHYWaBoQiMiCAPeBG0z2eFIhxDWJot0N0VMvJ8obfgMCDhhozGXoigPRLAo1rIWmgqKqxAlbGUIf2x7qdnK3ytks39l5l1slPwkr9TOq4tily9hOiTupQRylD74u5Pdt4dxJyNT4a9e23Fa5Gc7oiMmXiC3UvNgAocoDYhhmHDLRbHEQIAIXVL2KyurwYbikAn0JRnF8iVJMCAfoi118vALTo749LC0KFuLdigg6jKocdQpBHJU54LtSeBWX8w6YZZSkZDMgjIZ2W1FIT1hvEKivGn++bpWtyyEZOnOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN932XuAlQgX90Y9pTlJanSeYIjs+R0TrU3Kke1TA/Q=;
 b=NuKeFhWBbnm8KsvwIZMmiT+JkkIRMy9SjQxOF60+RM+E7YrM1QjPbRXYge01Mb9fjCqsdW8GEx+I1xuahCWF1P3I66qeZeuiu4d1JLi8lTXy7A4ekXM/aHVa0HQ2FUgEJooPCP9IUUqGVdG4PlP+Otb6cZ3jqqFOBEZvwYgUce8IioSV09C9lPdgqjInk6jRZNzmdUg9VaDKOxwPKJeaVL2daQh5pKWYo2ycZddxukvWZMLYkkcF0GK1bPDWEzPstKM8awER2UIddsOUfoqIsraD0ekjPYl4AaIVQZpo70xA9VXAuN4BPklwVKmg2dutJnwzwI9u8VCwFsQzJnymeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 00:05:29 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 00:05:29 +0000
Message-ID: <5b440934-8e92-45df-8d35-41b639966966@nvidia.com>
Date: Mon, 24 Nov 2025 18:05:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-6-danielj@nvidia.com>
 <20251124155823-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124155823-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 02066759-9d2b-4260-fda9-08de2bb657e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzBoVTBMSGl6WEtWY0ZCQlpuVXRNMWRSZk53dDlEeHVpYzZ6TzhGQ2MwdW9m?=
 =?utf-8?B?NHRPeXFaQTVoNGxlSGZkekFWMU9yYkNScFQrS29yazdZc2J4RUpXMWZmTDJs?=
 =?utf-8?B?a3dIa2R5NHIwWUM4T0lwQUFXbmpxM0VXY0pXMUxVbzJZeEZKVlhUWG8rUHkw?=
 =?utf-8?B?aFE1c3lVaGJpMzBTMlBKaHFYNENydEQ4ekR1YmcwMHozSlZhUksxai9YSVBC?=
 =?utf-8?B?OTArajhNMmJPNXV0NGZxaERYZTRjeEg4SHcxMUhpWENJWnVvc1dQQVVjRUlv?=
 =?utf-8?B?RUdacjhKVDdFUlR6NHQ0QnZkSTFVaGNLY1FwdnliTllVaU9tazRnSnVJU1JJ?=
 =?utf-8?B?OHhIcWUwcjZuV1Q3cDZlaU82VTlsV3c0Y3VCVW1OVHlhU1RVRVpvTmlPazlJ?=
 =?utf-8?B?VzNTZ1hUTzBvMVJhUXRMOURoekhKVnV5VnVUb3FMeWxnV1dVdk9SczJxOVAw?=
 =?utf-8?B?c3J2SG5wM2NEZHV1THFlNUhvVUM1ek9TTVRHUkhBNVBRbWphL0ZhT2dITHYr?=
 =?utf-8?B?UHZ1RlNvWlVvQzVsKzF5bHhhalJRNUNCc1JqUTN5TTljM2ovaTUxT29mMk1i?=
 =?utf-8?B?ay90UlcrMVltUUJRUXUzc0RXRTdrb01DVm9NRDRmanhWaFdwL0tDR0ppa0k3?=
 =?utf-8?B?UjhJTUtYTmlOc1RQdzNpdE1qS3NOa3p4cHFoSFhJUjZYV2RuTk9sQmJiNTI1?=
 =?utf-8?B?WndIMDZJQ2JoUFhvZ0tIZjI3UTcvMmh5LzRCaW5qbUVpQ25oSlVHbkkvNHVl?=
 =?utf-8?B?RFg4QzZWeHZCVjlNenJkY3hwdGkrQUJIM3kxQ29sZFBId2tkOUtZMjN1SHVx?=
 =?utf-8?B?ZUFiMytuNmloZUp2MlJQV2xSYWRGUzdCNjAvcXRuVEtmejdicVcrSTU3ZlBp?=
 =?utf-8?B?czNCT3hyTDRUaTNlT0tJbmw2TVliMGh2N3FHMTE1alhpaFNLcEkwNkw5RGli?=
 =?utf-8?B?Sk50M2NyMnhrSVN1QVh0a24xcHFCb0JjczRXWEYxbHhWcnpZS3BwcFNCTjNu?=
 =?utf-8?B?aE1ad3BhMU51VUJ3ZFBTSGI1ZXlmRlJoSGVQUUt5TThUOVNuNjJFaWowRU5k?=
 =?utf-8?B?R2t3eGptalVCQ3ZrU3dnV2ZCclhGZzg2MmY4WEsyY3dtMHZJZWpXVGdyU3ll?=
 =?utf-8?B?RjRvYnRPOHJCZmJKOWFEaVd6bCtPZnhkRXBXNk9wVFlXVHFBU2Y4b0ZTN2lG?=
 =?utf-8?B?MjhiNjFGb2FCdDFOWGcxRWRyWFFLUEY5MEN2NGtmL0xTeEZVaVdobTVjSXpM?=
 =?utf-8?B?ZXpyYVJ0eENZaEFvendlZkJxaHRwQzRaV3g1b0FScCs4Tlk5TWtudjNGZEhD?=
 =?utf-8?B?S3QrSVU4Y00wSHJiYk0zdHk3V2xRWTlaV0t0ZHhNVE1qTFBXeE9SLzhhM1Bz?=
 =?utf-8?B?U3FMbENYVjNXclozM0lFL011RkJpRFRsK0JiYmJ3ZTlDalpKQ3lKRktsUThi?=
 =?utf-8?B?VXU1N2I5MTkwQmVQR3FDVm9NeDBySHNWUE0rQ0Y4ekRPRSs4VVVVYkMwaE1K?=
 =?utf-8?B?TVlPM0RZeXJ5YVJtUTdSS21zNGFQU1Q1aUoxM0tkNDhNNGJPU2psTnU4TytN?=
 =?utf-8?B?d2pJc285V3o0WGtVWklmbEdQSUFFYXhzRmZoM0VUSjhjLzRNV3RCSDhlQzZB?=
 =?utf-8?B?ZndtNklvUGt4YVJvRktiRzM1bFdEN1Z3TEg3WEYrVTBJMTQ0eXFhU0NmNnYv?=
 =?utf-8?B?TEhmOTFGN2pGblQyQ013NTFSQml1cGJRZzhKZmJ5alpxZVN6a2ROMjEzR3ZH?=
 =?utf-8?B?N3RjWWV3b0djK3FvaHNwQ2RaOU1nMGQ3eW4wVkE2TVp6ODg4MzQraEZRUk83?=
 =?utf-8?B?eWt0VGVURi9IamdhS3BFdm82WFovNmRtU0ZGQXRkM25xWFFDZGJlcVJiNmN2?=
 =?utf-8?B?dmJ0ZFVXWDZEYlVDSTh5Qnc0UG1XMVJXeWxvQ2ZHZHFwNDVaVlhRd1ZHbGhS?=
 =?utf-8?Q?idKXlZ/YN1Y+wDEFx70UxXKGrXOr0ghd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ni9GOXF5a0dhc0VrTjdic2owajRjdStUR1A2dDdwY1kvMEY0ZGlFU3RJMk5t?=
 =?utf-8?B?UW9BNFZ2c0RlU3FJYk15Qk5VaitJN0ZoVzBpbk5pS1NsMDJrZlZycXJQMlVY?=
 =?utf-8?B?V3kwN0ViamVaeC9LN3gzcDkyblp0bWpBdTFhcnlTMUl4dU1oRCtFVzVGWUIx?=
 =?utf-8?B?OUJQSHhtMkl2ZmxxWCs0OWZ0VnFKYVVqNFU3MnlXcmRLUVluYm0xampISHRp?=
 =?utf-8?B?UDJuRlc5d1pxajJadDdJcWw0SDN0NXlPdENmaVgyS0pZNFl2S1VkRFhMak1U?=
 =?utf-8?B?R3NkTWNNTEVQZXVCa3NXOXdlckRMcmF2TWFMeVNQd3E2TnNRbExrSURFUERK?=
 =?utf-8?B?cUtlRnE0R2tiNE82K0F4K3pmQ3BJSzU5VWN2akI1akJlNU04eUY5eER5VEVG?=
 =?utf-8?B?ZGxUZWxSZEZlTVVmRTdCMmJxdnVVT1hCelZkNTZUZHluUzBOdEtvUHVVenJp?=
 =?utf-8?B?Y0V6MVJrZXJJZzVpNHk4RERodjBrUXpjcEFCZ21sMFpGVHhlL1BLMytHYko5?=
 =?utf-8?B?cWhGR3NjYVBkU01sS1c0b3Ftc0RZNEw4elZMaVhrZlBQdjRHYkJCWmo1VjJK?=
 =?utf-8?B?ekRtRy94aVRvMlZFcElWdXB5dDB0NkJVSStVS21oWG9TYkJEeVl6V1BhQXZz?=
 =?utf-8?B?WkxJYnZWU0xIYk0wRWpFMkwzbnNHbkxTK0RmcGpBR1E1QUdXd0o3WkE0TStL?=
 =?utf-8?B?bkFVd2QvM2ZYaDNhdWEvdXZFZC8wM2MxYThBYnVUbkZoRE9RajkrNVl2RXZF?=
 =?utf-8?B?bXpkWW5MWDFYZjRHR25adzFycWVUeldwWGFTaEpiT3pyMUlPRy9GUGQ1U09M?=
 =?utf-8?B?aVBFaFhEN2RDYnl4NnRNT2RZSy9HeXREc3lSZCsrUHNlNllFUWNQQTdXQ2M5?=
 =?utf-8?B?V1VvcXN1Mi9UYlREbUZNWG1URHRtTTB5cWp6ekpvRTB3bzVTejJBU3F2U2Uz?=
 =?utf-8?B?YThCRElKTFovVnpjMGsydUFhYU1LQ3dxeG9SVUxnRTVQTkJFaDBValh0VVJH?=
 =?utf-8?B?bnZyOUdDampVMkc1a3cvSTc2djI3TCtXQTV0L09UaFUzZ2dJUUpSS0dkdlEv?=
 =?utf-8?B?NVExRy9Nd0xNWDFhU2pUam15bEcwUFBadG1KR0ZkNFFha2lMZHVOT291SlZC?=
 =?utf-8?B?cms0WTNIOERZY3FiYjQ0WHBKWHlvNC9MMTNVS2RFNUVZcTZtdDJKalB0cGdJ?=
 =?utf-8?B?NmtET2hLb3NTUzZ4M3NJN1FhZUFwTm1abFByQm9jNUU3V3ZzdWUyZDEzbkpW?=
 =?utf-8?B?YW9yNWJsUXpsUy9CVHg0bCt0d1Nsd04wQW44YllSYWEvYzB4RjkxYzJHTjJQ?=
 =?utf-8?B?RVVMMzdIQ1JsbGhVd1I0ODNpamFhb0RBcGgyMlJGZXBqWktzaWFsR1BoVExk?=
 =?utf-8?B?cTlTNC92L0RMZzRBM3dVYmhmK2l0cW1kQ3BORlNyZHhUOTVBdlVGZFd4Z3V3?=
 =?utf-8?B?RlVpdWM5a2w3MmNFTkgzVlpnVXlWdXNjQ0ViTDh5SHZiQlgwZExyK082TDZh?=
 =?utf-8?B?UnduaFRwaDdSWUZZZVYwbXY2a09oSnhQZWJtOWtHQzQzRFY5ZkRUUTVXajFS?=
 =?utf-8?B?M0xKZVUvd2VWZm03eitHVnpkOGYwK29uZWNDMk1rbmlGbGJTc2UzWWlZb0or?=
 =?utf-8?B?ZUZQSUsyY2wzanRvb2VFZHlOTU13Q3N3OGw5OTF3MHlwaFJNTVQ3KytHWkdy?=
 =?utf-8?B?bThZUklzWWR1TkMzRFpQNk5iQ1JMRlIzeTBXQURhalVpWXBmSGprcFRhazN4?=
 =?utf-8?B?aVIwWGxmSlltN1owQVZLWldGWTBDYmdxeGdGU0VVNitac1IvT0p2WEJoY29x?=
 =?utf-8?B?ZjI3MVBReXhUM1BzVjhmQmwzNlZ5S2hKZ1plemJsVnJDVHBBTURUcUszYTFH?=
 =?utf-8?B?L1dEdXN3SXBONWVEdTEvMHBNRlVpSnNSVFNaTDRscTd1V2o1ei9JS0RnR25h?=
 =?utf-8?B?aXlxN2tLMGN3Z3BlUWtReVpKSVY0UDJzQlNHR1o1Yis3NGdJbXVrVmFPczRw?=
 =?utf-8?B?eWlNRUt6MnZMbFBlUzZoc0s0clpxUTdZQlVSRVhicjFYcFpYelc1WnQvRFVB?=
 =?utf-8?B?c1NjNldlL3hjVVNMaFRKMmQ3RE9iM3lxT0ZDSHBVeXQwbHFQQ1krUHpIZTNs?=
 =?utf-8?Q?ut+XrWmlxr3WGwbpKSTJ31WM2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02066759-9d2b-4260-fda9-08de2bb657e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 00:05:29.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/TJZ6TX3VcJJ1jA1rTi7F2IqL7mF5nia5WYuFX5xcohbHgRyNx0dE6UOgH3cYCek1ABlsiuUbjng1tH2ig2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

On 11/24/25 3:01 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:16PM -0600, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter

>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		if (sel->length > MAX_SEL_LEN) {
>> +			WARN_ON_ONCE(true);
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		if (real_ff_mask_size > ff_mask_size) {
>> +			WARN_ON_ONCE(true);
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
>> +	}
> 
> 
> I am trying to figure out whether this is safe with
> a buggy/malicious device which passes count > VIRTIO_NET_FF_MASK_TYPE_MAX

It should be safe. The count is u8, so it's bounded at a low number of
iterations. We shouldn't overrun the allocated memory with the existing
checks.

> 
> 
> In fact, what if a future device supports more types?
> There does not need to be a negotiation about what driver
> needs, right?
> 

I think I should a check of the type, check that each type is only set
once. And break if I hit a type >= VIRTIO_NET_FF_MASK_TYPE.

I think that should be sufficient. If the spec is ever expanded to
include more selector types it would have to insist they come after the
existing ones. The MAX_SEL_LEN check will come after the break on unkown
type.

Then it should be able to maintain compatibility with newer controllers.


> 
>> +

