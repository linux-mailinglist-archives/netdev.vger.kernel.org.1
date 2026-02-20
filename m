Return-Path: <netdev+bounces-259658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMB8AWEWmGki/wIAu9opvQ
	(envelope-from <netdev+bounces-259658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:08:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F8165857
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC293043BC4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650A335074;
	Fri, 20 Feb 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EcOcYLYG"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722121B9F6;
	Fri, 20 Feb 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574687; cv=fail; b=EhU4z3BQ1jSUAne1iXKKfQOJVdj78P6C3TS4FntJCYeSjAQP13vzoyueLjL4cX0IpcmGvfv8hmqGvjik7g1mLclu+IICXkt6kuk0lh+yt8J1pmtsMIw6A/AelnTaa1n3LNTIYKQOipQV6g/IOHeTFdftIkySugNZclpFF1H5Tm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574687; c=relaxed/simple;
	bh=pEUvgfCjLEXL6IbMnDk97u9PRDGysQ37cFVs8iacM3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iSAFqIZ1JPag5kLPfqfV57gv+AoRuYg90u/dImHdHPQsE49rnefWiGfLimWc15VW6XpdzdWImczZVEUwuM469FSjUiYVBEdN61HLii1UR7uqRIb4vD19ej5QyB7mvefBSXZZJ8TM6G0a3ktQwFrT36370LLpK0jVFOXyBXK0Mks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EcOcYLYG; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMcWpOBqF/UgOt4VjUqcJyCCr9Wtq5HYvLNK9nrRKWPDt3Tcz6IIPqZE38SBl474ZGF9qRjtTwCbaQZvfDz9fTMmwDOsK6EoqRyEYZPE80ZK7FFwosBVjW+6qCBwZ70SnCohvM0v/j8qUDK+yc9ztnjdqPSQofEGhRqscZW4jOwOgt6bF5yNcfORZFFjq3Vkf6n50+bbuxUHGvafx7PBRn+9JDitMFSqnVEg44+q5pu79O6EmYUbWvwnOlRYe76titlam6a9QIeCjMXxUmwM9UQ37y9w3jBJOPs85ib65fVG6QU7QWgamTBUYe9tuoq8Y54A7t0e51t0mi4deJgCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkNzppkagpY5ljaoS8uZ6M4PYhvlfe75seCjP2Ks2sA=;
 b=sjhxzaXfAa99XpvJ1VojR8h+JpXyUWTPVzF0IIWtJMYDXmrkMB5wT/PpT8Up3hvnJAOWWUKsQSLdCCV0McV+XVr0GreN/r+1tb14b+EilS2XJX5kijXfWXlzS7DUvH8TbgQ4m8zRu7hFkOy2Ur/aVwt6/+15s3aruD2U2fCORlhLqM/gldPr1mrLGVNkMM/PIwYeBq3gn3Fufa5vsZrnovQLgpuDPaofZwbgHxHutTOT5j7G7o+NVAJ8genkqgteP7VRjuDrJVd28wgpS+324WDQiBKwDXaq+opWM81Q2NdIMhTuHdJIhrasaloZVcn1Yhs2s5z77PZ6W/EacNhj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkNzppkagpY5ljaoS8uZ6M4PYhvlfe75seCjP2Ks2sA=;
 b=EcOcYLYGA7Q5J4ZUSTu2YNxveuMezjy8ivoEdItJQwn+jme5yiAsMzFmxZvrAqr1v3XA51rqnbo6V6ffxPfj0G6TFFsk2GJEHgTSSm+rhSvkO93XH8Z3c9i1EpXCZaaH2aiuEErimebw+w47E+d1svPyoIn+Zb4H0qJEikv7qJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 08:04:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 08:04:42 +0000
Message-ID: <b1c31603-b94b-4863-9e01-10e0c1df9b67@amd.com>
Date: Fri, 20 Feb 2026 08:04:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-23-alejandro.lucero-palau@amd.com>
 <20260213161410.2945294-3-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260213161410.2945294-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: b9acba5f-8b4f-41fe-f360-08de7056b41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWpUZXh3ejU1aTRJbkhNSUdBZlFTMzI4SUpSU0dDanhKenFRZmxCbzQxRFZv?=
 =?utf-8?B?STVrek0vdUtGelZOVjJORmhGTXJZUmNwL2FacGxJcnVzS1ZHOWx0cGQ1cEVj?=
 =?utf-8?B?VFFaZStVZWVwZ0Yyc0J5NVFXbndFZkx4KzEvTWZtK3BJcENQSEdmZHFMQzNq?=
 =?utf-8?B?RnplSzA2VnNoNWVlWGEzVGZoQURGa2hzSWFuWGdxZG1YVGthSjk3bXBjQitk?=
 =?utf-8?B?Wk5HL1NaeEVXY3RGK0JKWnpnUFpmWXptRktmdHNWNy9qOTF2WGRMZXJ5UlNU?=
 =?utf-8?B?S3BKOGRLWmRTQzIxSm9VTzA4RndQRVQ1bHlJS1lhb2hLYk1XWkZhQmpNWWZK?=
 =?utf-8?B?blc1SlV5cVlzSFNiQUI3ZVdmQXpGdFZuSWc1ak0rem5SWGR5ZjR2Q1BqWWJo?=
 =?utf-8?B?NHFlSlQzVFlKTHZwalNpb09qQnpCb0JsSjQxd1c4Rlc1bFlHcHVPa29YaGlP?=
 =?utf-8?B?SFp4YlQvS2pNRklHMjNEbG80MFRycmo5bXBFMm1janJtaExQMzFSVWc3bUpW?=
 =?utf-8?B?YzlQd1JFQXRRb0VCYXlZOGlBZEFuRVZZUkVYYi9NYjMvOWljbzJqRkFjQlBE?=
 =?utf-8?B?QmhSMm52MllyMDdpa2lUSFlhSTVCQmVZTzdBVCtXYkJYOXozZVF4V0VvNjNG?=
 =?utf-8?B?ZTFGci9VT2pWTzN5STV3YjVNY0NuN1RJVUpxY3E2VEZieVhtaC9tUXNhbW5I?=
 =?utf-8?B?bkY3NWZaTkdBd1F1N3Fjbkdqa0lING1QbDc2bXpZZHJIalY1RFQ3NUpYOWs0?=
 =?utf-8?B?UHBBNFdNbFBKMzFsQ2Z6aTF5ak80TlFzQ0l1V0JoRFJpeGxsL0ZVeTlBYmIr?=
 =?utf-8?B?RlJRbDdYMmhzTytsZnEyQ09VMEJZZHMxYkc2SXJzSHV6UmZQdTgvcStORkw2?=
 =?utf-8?B?UnJuNjBVUzRqM2haN3JZMFF0ajh5VlhLNkxpQmwxYUsvMklhOTlXZk1nYUxS?=
 =?utf-8?B?YWl1UEIvT290M3FsYjZxTFJCbTQvbGlVbk1KL1JCOUZ5LzM1VWZQSVpQNkVH?=
 =?utf-8?B?OVdTRzVkUDBOSWRadTgxcUhicjhCNlE3TVNFUEJPeEd1cS9WbG5reC8yZlh6?=
 =?utf-8?B?VVNnSHRwaSsvRktuaFpsdDc4cHhaVlMvdWFHcHhxeUd0MXJXVUt0cDZrL2Zh?=
 =?utf-8?B?dUpoS2FDbHhRUENWMi83NzFnWWIyQmZXK3d5QmVNR1pIWTdRVjBWZFlhN0NB?=
 =?utf-8?B?cS9ucWEyeXNSTndaR0RBTXpoRHBqZ2ErWHFLbEN2ZnhFbzlMa04wWVErbXNI?=
 =?utf-8?B?MlhHa3JQME5rTDFVWGJmZGgwNkNlSVI0aFpQZkdaRk9TNlZmTXY4QTBjNGpv?=
 =?utf-8?B?UjFrZ1RQMVlCQ0RWL2VGSkRkM2hSVzFvVUVTanR4aXpHVFVDaHFUOEFpMm1S?=
 =?utf-8?B?U0pydXdMdW5JUGtTQm4vUVkzSm1CTTFpVmZKUzU5NTNMaFpCVFlxMm1Xa1pM?=
 =?utf-8?B?Tm5hVUovdWEvSU9OeGpoSkhIZWNNMVpwME5wRzJZUlhuRHNUSEF2NjRxZm5l?=
 =?utf-8?B?WFhFdmpuU0o2dWlYOVNNQmhhRjFpd3NVUjZMWEw5V0NFNWx4OXRTbytVK2VJ?=
 =?utf-8?B?djlueVQ3Nk9PSUdOTmN3ekZ1TnlXb2UxdlpKdE5qd2xNL0laRnBJOHBRdDZG?=
 =?utf-8?B?N1JsVkdkdjRjTzVrSmVzYU9UNlRlZXZYNmRXUHlMSzFvTGc0S3VseU5yaWVS?=
 =?utf-8?B?Q1BTYlBmdExodkpDZUQyYjlCTjVmYVE3UDdPRzFwSFpjd0NqSGEzQmpZMkNI?=
 =?utf-8?B?WHlWMzlnVzJsNzIrT2puVUxrS0VLU2xBQ1pWVit2QUhUN2RNdk5Mc3F2KzRW?=
 =?utf-8?B?UnNQT0xLbzI0V3VPeHdkQmlRNy9yS2JTRXF1OW5Oa0JRRS83SXFQYkhWVVlm?=
 =?utf-8?B?RnYyS2E4a2NxQTQwam1IeW9jbk5VWFpEMTUxazNFSDhqaTdWT3VEdDdnektR?=
 =?utf-8?B?QXdOdlZHMG5CRFNDaHVsbjdQU3hOS3F6MUQvZGtqc0lqcXo0Uk90RnoyMXlm?=
 =?utf-8?B?eXVsOTdpeWVDVUVOYXlYbm53aHBpVUhJTzJQWGxPVHZyaWJsa0w1cFJKNkd1?=
 =?utf-8?B?UWVmTDBORGhxUDRlYnhwTkNaalVwSmlnTjhmbWJ2UUJjU3VxZ1BJVzZ1cXBW?=
 =?utf-8?Q?t70o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytCZVN5MENLdG9yS1Brei9DK1RjV2xocEFaY2lGMTZUNjJIZWcxMGorTFk0?=
 =?utf-8?B?aWhKZTN4T1ZkRFhveUJTTlpmNTZrc2N2NElaRnFUNVBKS1FRajV3S1JJQXli?=
 =?utf-8?B?VnJuNEErVkRDN0IyOEM0MmhTSFpYYzQ0RWdHbGxSSVZOYnRSbm00dTdlUC92?=
 =?utf-8?B?Vlo5QU94VXFwTG1qLzIybWFzQTZJYjZtRE01TU05aCtheEJkaDBLS1BkbVhY?=
 =?utf-8?B?ZGgzdmM3RkhQazlmQ3doaFVDWW1tZ3p0YldCV3dQNnY5czBMRXJ2eXRwUlln?=
 =?utf-8?B?U3FLa0hMWUJmMVpxOUY3MHA1M1NQRGlmV0FmS0hpWXRYcGlFU2xXRlpuNXdM?=
 =?utf-8?B?VmE3eXZEVm9za2w3QzJDMU5pRGhhUlBrL3NocnMraXMwdjVZMGpmbDBwV3lI?=
 =?utf-8?B?c0VHU3liRXNMbHEwblNLSFdQbVJmMkdZUzJlcDNoRFAxSUxWZXVYS1kyNytS?=
 =?utf-8?B?bVQ5RExKbExtQmljTGxPVWFNcVV4VVl6NGxWNGdkbUIwY0NPbVovMHFLTFlw?=
 =?utf-8?B?a1FjaFFZS1A0d08zR0FnOWtLVXVyUVZ1SnRGb1dTSDF5SSt6UmhBQmY3NmJZ?=
 =?utf-8?B?VzlyM2R0VXU2enJheW5SZ1ZZWHZHbzE1c3lvZnJSWXVycHlVM0FONnV0blA1?=
 =?utf-8?B?aEQ3UGVQeXBZdHhlVFo4aTlpdDRTcXFwR0pIMVJGRnYzbXpXRnFDaWgzVTNj?=
 =?utf-8?B?S0RWWjFKUGFxQXZyZWZkNWlOS2w2ellITDlXL3QwVDB4Nnl3d1JPTSttRTQ0?=
 =?utf-8?B?SnI2ZHhjV3p1L1BTL0xuamZQWGJZa1Q3a2Z5UmtmeGEvWG5lK2FwR0NvVXNG?=
 =?utf-8?B?SWxTUnVacUt2WmwwVjR5dytMeVNYMEVreEpzdSsrOEpZenRueXNBQkdHcUhl?=
 =?utf-8?B?dG9BV0dGNXZwemhEM1JxUUhZbTVUOUxjeUs3K3IyZzRqMWRmR09BQ0cyS1JC?=
 =?utf-8?B?K3N3blJPT1lROWxPWlV5ZC8zd3doR3dQVjc1cXRhazlrclpWbVd1QmZNNE5q?=
 =?utf-8?B?WmdEd2ZSN0JaaHI3TzZuV3pxYVd5ZERYZEZJREo1QStqUnE1TVRjQkFEOEMr?=
 =?utf-8?B?T3NxLzZlWkRPVm4rdktIZGF1N2RGNW15YSt3dy9kK0hXSFZXbHhmV1NJUTR6?=
 =?utf-8?B?NC9BbUxvZ0FOOGw5OExRYlptY0w1b09LK0lkdW01ZzRWcyt4R1VWSXhNc0Rh?=
 =?utf-8?B?a2txSFI1dU91STIvcUZXc3FSb2NaWmpxTWVUZ1RGZFVQOG5jMzdQSWg4N3dl?=
 =?utf-8?B?YkVGd2lmT2pDcWx4allObHNXYlJiMUFMdENSc2I4MjhwcWUxNXFCekQ0M2dV?=
 =?utf-8?B?MDNkNEZGekRqQXQxRWdqUHY4MTNUODNoYkhVNlhSclBydHBJQ01PS0dQb1J0?=
 =?utf-8?B?Y2N1STg0OE1mQmtlSC9NS0R6RVN5dVA5dXM2d1pHS1B5T3ExOEltbGtucFlM?=
 =?utf-8?B?alBEcElBaEhyaG9uRjVscHRjbVJqaEhnNUlPTmcyYkJVUU5Sbnlkd0syT0JO?=
 =?utf-8?B?VUg3SGR4UjdkWHJ0NWdtN2VZVk1xMlAzci82ank2ODJFdm42UEVSVmllcTEw?=
 =?utf-8?B?Y1gyQUtPZ1VoNDRPaU9hRnRqRXFURHhGeEx2ZWNUQ1VnUDYrckR6bGhEQlZD?=
 =?utf-8?B?aGNGd2pDNkNlbGFXMXA1OWNiT2ZMdnBHNGF6SWVrbnhjbGpzVHVXbXNnK1hr?=
 =?utf-8?B?REJDR09GYmVnUFdoczY0TjBHblR2c2xtNzFpRkVVYjZxOStGdmdCMEU1NHY2?=
 =?utf-8?B?QmlDU1A4R2k2WUdVSXM1M0g4bDA1aldFYlh3blVFMXdmWW9NTjJ6MlZSUEFa?=
 =?utf-8?B?SUVHaExqSmoxNVpMZ2lVblByMldSWlVxSjZsSzI3UGNSaVZtcHJaT1JpYWgy?=
 =?utf-8?B?ejZxMEN2ZTVKZitQeE9CSytGNkNiYXgycDNTMitZZU52NklhWnRXaWo0Vm81?=
 =?utf-8?B?UGF6djBiRHptWjFXR0hPemxCaEhpTS84T0tiaVZ6VGhZbWRQR0tvOVQ0SUYr?=
 =?utf-8?B?Mmc0UFNWSVlaWCtnckdkaDN4QmJCcVk1NHVUYzMwYis5aDZHM1FyVlFwLzc2?=
 =?utf-8?B?SWpYNCtMTzdTaXlJQTNBRi9lWTFJbGphTGpnN2ZFbG81OUxqNzNySDN1SE4x?=
 =?utf-8?B?dTlveHNaOTNRTmlnNDY4UVJ6c1RQTDlocEY5bm9VeTJUOWwzLzVHUTFuV3Vh?=
 =?utf-8?B?Y1hTUEpYQnYzQ2RyREJoTmg0ZVQ3NHFDclpiUWdyYWJvekhDRmtIbHNiVkhj?=
 =?utf-8?B?UlVIMDdaTkJkOTVVVisvNlNhakxDK1BKY0RFenptRW95dzl2M2pEckd0SzdF?=
 =?utf-8?B?NGN5RU11a0pYRWdndjgxSUNNL2lEYWdOcGdQOC9UNlY1Mk1jUG9MUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9acba5f-8b4f-41fe-f360-08de7056b41e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 08:04:42.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D70O6a94jtevayORCyxsuSffGmHdKb3yroGzHsu0YzdvvZQj1OXTE6QwuXVIIFxxM53ddSveSPI3xt9UdDSzUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-259658-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 492F8165857
X-Rspamd-Action: no action


On 2/13/26 16:14, Gregory Price wrote:
> This review was generated by kreview-0811365ff2.
>
> This is not an automated email, the reviewer though this report
> looked valid enough to consider discussion.
>
> ----
> I am completely unfamiliar with this code, but the question it poses
> at least seems reasonable.


Yes, and again, it makes sense. We have only tried with one VI, so that 
explains why we have not suffered the issue. But it needs to be fixed.


Thanks!


> ~Gregory
> ----
>
> On Sat, Feb 01, 2026, Alejandro Lucero wrote:
>
>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>> index fcec81f862ec..2bb6d3136c7c 100644
>> --- a/drivers/net/ethernet/sfc/ef10.c
>> +++ b/drivers/net/ethernet/sfc/ef10.c
> [ ... ]
>
>> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   	iounmap(efx->membase);
>>   	efx->membase = membase;
>>
>> -	/* Set up the WC mapping if needed */
>> -	if (wc_mem_map_size) {
>> +	if (!wc_mem_map_size)
>> +		goto skip_pio;
>> +
>> +	/* Set up the WC mapping */
>> +
>> +#ifdef CONFIG_SFC_CXL
>> +	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	if ((nic_data->datapath_caps3 &
>> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
>> +	    probe_data->cxl_pio_initialised) {
>> +		/* Using PIO through CXL mapping? */
>> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
>> +					   (pio_write_vi_base * efx->vi_stride +
>> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
>> +		probe_data->cxl_pio_in_use = true;
>> +	} else
>> +#endif
>> +	{
>> +		/* Using legacy PIO BAR mapping */
>>   		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>>   						  uc_mem_map_size,
>>   						  wc_mem_map_size);
>> @@ -1279,12 +1314,13 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   			nic_data->wc_membase +
>>   			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>>   			 uc_mem_map_size);
>> -
>> -		rc = efx_ef10_link_piobufs(efx);
>> -		if (rc)
>> -			efx_ef10_free_piobufs(efx);
>>   	}
> The CXL path sets nic_data->pio_write_base but does not set
> nic_data->pio_write_vi_base, while the legacy path does:
>
>      nic_data->pio_write_vi_base = pio_write_vi_base;
>
> Since nic_data is kzalloc'd, pio_write_vi_base stays at 0 in the CXL
> path.  efx_ef10_link_piobufs() then uses nic_data->pio_write_vi_base
> to issue MC_CMD_LINK_PIOBUF commands:
>
>      MCDI_SET_DWORD(inbuf, LINK_PIOBUF_IN_TXQ_INSTANCE,
>                     nic_data->pio_write_vi_base + index);
>
> and also for the special-case check:
>
>      if (tx_queue->queue == nic_data->pio_write_vi_base) {
>
> Wouldn't this link PIO buffers to incorrect VI instances when using
> CXL, since the local variable pio_write_vi_base has the correct
> non-zero value but the struct field was never updated?

