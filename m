Return-Path: <netdev+bounces-139525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCB9B2F73
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337C628221B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E001D0E38;
	Mon, 28 Oct 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YGgaz9H7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F928189B8D;
	Mon, 28 Oct 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116775; cv=fail; b=oOYdK2+NpZT435TZJP0lZEYQJW/g8RS3psmtdLe1Vx3hcUQoLN0PFHdau3sTlQQx/hig/bbnCu6nPbaH+UxkxUoriScOPnFjb4qXi2SQnKFzO/0RHa8wogM03Ex5SLOlb/IOeAjLUk7iEYwu0Mw4FS8rN8VgZaRg7nwgDbrLSAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116775; c=relaxed/simple;
	bh=nzTOZQ3gV/Rtd1sIJc2BASnlx7hLUvb/uheXm2dS/6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvxPFaF1F5Qs4oQUVNFqxMHcwllOVkDcNZfHzm84o3gIHakk3Y/eyFwFu6TzSGqPcAonNI7zh8qlKq+7aY7LiNUKDc4UdRrWstuqCf6ycwAjyQfa1ZuTyZhpEgjVEMsXMrUWE/THydYJZ3mUGg8lEyK8eXu1HETqYano194V4mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YGgaz9H7; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWIU+ocq5oErqA7XVdZUsOBlsZDvftfPQe89oOYAEYeKt8hNWRjd6V671zaPwPmBNIH5Kk5ejFyow4oIE6VKUPs/Ftb6PdnFqRFhyPOQS+9OeLsm4Tolm2hhf39DB8LJ9vBmMWA3sh7ePY/iaTUcYngUVVdpLSDFg6VKnRMWeJIRFa3+hlL5gYwiiHNXdIBGjxXq+1IWVas7VhnbmPKY51zMJBlQo2SkiBZm5lAWddKR+HHA+78V/g7HWngLiVSP65BVljUODZBKKnwqmyYAusC9w8joY88ePOWObkWkrl4lkbJekRLU9gOPV+AqcNxY5vruiqo1XvVzi6yCzeHuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5aeShbiB2H5H0CxxAaVR7o0tJdeAsIDMu001Y9SgrU=;
 b=h+7bn/Of/nb8J1PoA+IQZzQqRNyiAiOHALm/9aqKnzTrDb1juUYbd5XATgNbAj4H+JFlV7ogJhdvJSplW2A6LPRB7zkmcstG7rjyCGuB14kr+PbSWxZ2MBP9/DfUnJRcntmnmHJyD/hAbk6PSEthVLuXAQR2oMKczD9tYoreq2u41KKa8tIjEYhDduja0yffGoqqA13vE2U0iLgiTAFHFNeDWtdwaoUGBchFzAnE8hFK2lyE6VyQqZwlnucEOHZYa9DWM6PEBhytbMqAmLqE+BU7zV23r7jvJu98U5yFKjez7C5HoRUvvtIKztRym0G4+S6++H1DqDfDsGfFHAhD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5aeShbiB2H5H0CxxAaVR7o0tJdeAsIDMu001Y9SgrU=;
 b=YGgaz9H74rVCEVUapS+WSFf7VGINMT0+0ZzxoS5vySrAAdyxP1NgDBw+ziodTQlkFxetyDuvD3x65F26WlWuuxeb5DEOf/rIAUykleKV7I2qJlak2zFN4I2u/QVPmjELJmJS4NMWwCNcSDYKWKNAj0iwxp+4H0cR4VzH1a9150k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 11:59:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 11:59:27 +0000
Message-ID: <b6c1ced9-0038-7819-8e61-7e486da8bd35@amd.com>
Date: Mon, 28 Oct 2024 11:59:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
 <20241025150314.00007122@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241025150314.00007122@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0313.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebca81d-a495-435b-4bd8-08dcf747f943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmhwYWZibnc0d0hQZVBHdGFjd0lTSUMxdklqSmZFRk5aYzBXeFkwRk1RS2Uy?=
 =?utf-8?B?TnBpK2lraml4L2dXL1Z4eE5hRU15UlYxbDhzc29FS08vTHoyTFhaaEpGOWc4?=
 =?utf-8?B?Z1BkZnhhb2c0RzM4ejJLZGNmS083dlAvSFRJVDB0MEE0dmRwWStsQ09DRVFn?=
 =?utf-8?B?UWpQUmlNcEFwb2F4MDZab2ZZRHlsQjluUndWb243bDA1eUhLa1JSTDYvV3Uw?=
 =?utf-8?B?aXZQM2RCOHhiWVU2Nk5ZUTY4MEpJVUdsRjBva1N1dFF0UnB1VCtOUlJVL3dw?=
 =?utf-8?B?S3dPblZ2aGJPR0djc3k5a01uemRmLzN3U0RPQmtuWWhMV1krSmN4bTlsS1ZB?=
 =?utf-8?B?WUNwVGFTTkNsQlFsQk1uaGRUbjZxdzNsU2RVeWRFaGxJaWJPY0pycVFFaVh4?=
 =?utf-8?B?TEdOb213aXNSZ1dSa3JvazI2bjdpQ1V5VTJ1UnU4ak41aDRYMWs2cHhzMmFv?=
 =?utf-8?B?L2FGYW9QbGRiVlIvU3RJWXhweGp1NkF2MzdNTUhvajNVaUZrS096MG0rTndE?=
 =?utf-8?B?RGhsNXR4cEJ3VW9qWklWZG5VNUl0MWNhc0I4OVRNTkF4dWgzMk84ci9xeXhw?=
 =?utf-8?B?UDFJRExTbXlJVmNuZjB3YkI0aVlyYlIrVldGRXJha0ZnK1RrMlJFUHJzek1a?=
 =?utf-8?B?VHc1ZWhGQmxwOWQ3NWJOYzBpT1NmMU9DakNBYldxNjlKMzZjR0lOTExlSE1l?=
 =?utf-8?B?VS8yNmp6MDZvWUNBcS8wWlVVMjVycFYxTVd4TkdpWDRLWU1OeURYK1RjZE8y?=
 =?utf-8?B?WXU4OFZtdWlmWDhhYk84YlJDM2VZQjcyTWl3VlNnZ1Z6Ui9OaExwbGtIc09V?=
 =?utf-8?B?TGw3RC9iVHd1bC96QlVHaTlXd0E2NHV3dnc4L1NRRjM4NGFncHN2OTBDRHVL?=
 =?utf-8?B?N0hFTDQ3aSt1VC9ZVkE2SlBPTjBPQVA2Qmk2ZGJBb2l4Q1Y3QzBvMlFwdG4z?=
 =?utf-8?B?a3hlWkFPcUhpTHBNL2lMV21QUWkyaXdVdUxSM2FzeVpnR29FM0VYZmpmRXVX?=
 =?utf-8?B?blR3MXJxby9XdHFUK2dmZUR5Z0RGbkErSnpRalJpd3M5YmpaVVpIYlNXdGFJ?=
 =?utf-8?B?LzR2M3lQQ251d2lsRS8reXpvcndWMzQ4ZFpTNVlXMkxUcHlaTE9TZ20rTWNK?=
 =?utf-8?B?N2RXT2hZaGdyaTd4NmNIeHN4cDkrVHppZXF6anU5N0RCSytsTVlUV005eGlM?=
 =?utf-8?B?QUJRYmE0VXJWTWZZNEwwWklSZXlRaFo0cE83VDk2UE9LVzVrVWdpTEovdVNJ?=
 =?utf-8?B?YU1KOURvT3pnM2JmVCtyMUhyM1ZHdXpCMG5scnAwYzcwOWxpWGpGdXE4SjNZ?=
 =?utf-8?B?Y0ZZVFFEV0xqZ1pXUFh3NG5MS2NKcmJYTFh0Tk45ZWZEVjdNOUZYTlhRMGRw?=
 =?utf-8?B?YnJpVHRCUTRybE9UOStmREdtZjFaZ1dQV25xdnRMU0lRYmhNTEg4dUxEZWlj?=
 =?utf-8?B?QlQ1bkwxbDFTT29yOW9QYjJEKzRybEZjSXlyTVJZSXV5VGd2dUxNUTkwWWp5?=
 =?utf-8?B?SGRrekNPZkxsMytsV1FPN1R6NXpqVFRXckU4SnBvSktsaitUTUlrYnk4OGxo?=
 =?utf-8?B?QXhoeC9LMkw5RTVPOEpMNUduUC9UeE1ScDZYei8xT3EzSUVRWW9CYS9LOUdW?=
 =?utf-8?B?NlR5UWsrWld6bk5WSy8yNWVDcVVJaFJoaGxkUWkxb2tLSnNHa1Q0WVozMnl0?=
 =?utf-8?B?NDV3Q3FsWWhyL1ZvYlh5QktTTjFjSXNyb1Z1c2gyN2JWaGdTZlhVcjdGdmZL?=
 =?utf-8?Q?6tWtgphnQSxfc4M8gip0bvdIdaPX4vpLVOeJeLM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkkzM1pCZnZxdGxONTVtaHY0UXVLd2NKbTFsNTlFeGI4RG1iZFZTZklxcVFB?=
 =?utf-8?B?bjRQYnRpWmFjeWZzZkNyZjg2V0g3R2xQbzF2S1hkeFp0M01CS2tIQjJlcUVH?=
 =?utf-8?B?b1VUU0FyK3NaUDZ5N3V0cmI1OCtYYmNMd1J2ZGRNaXhEVStxdER4RnU0MVFG?=
 =?utf-8?B?TURaQmNsUzFnMDVXT3JwWVI5a1Y0NXBEQnFmNTR6ajBzR3FoNll4eWdIbDlO?=
 =?utf-8?B?RVRpanpyVmJ2WFAyZWpIYnVCblFlbzRia0pwRGxvMmtKK1pUREdYbjVIL1Nu?=
 =?utf-8?B?bGFvRXA3Z1BvT0o5NDVpdGtLUmJKQklNaTFXRWR0ZHZoc0hQT2k4OTZyNll2?=
 =?utf-8?B?SHVkc3R4bXFuNFp1V2c1OTArRVhCYmllRWR3ZHBKQi9mSEVIYkRpWkN3bUo5?=
 =?utf-8?B?VlJ2Tm5mTnRLYk1OY1B5ak1WeW4vNDVuSUs2OEdjRWt1Z2hVck9vQ3lUUUdG?=
 =?utf-8?B?WkxVenl2eGUwaWV4V0JmQ21JWmtxb0FzOSs0aWY5dUFvUEJKKzVHSFd3VUVP?=
 =?utf-8?B?RFNPdUxYcW56bXdXa1YzQWtTcHBLODRpaGdVY2ZyeHBMbnlVUGZtWXJZRkNt?=
 =?utf-8?B?QXVpbGErYmtmbHp0RElud1pmdnRoV2JaeGVkSEFSclZLQ2pranRLa1M1cVB6?=
 =?utf-8?B?YzRibE1KVy85aWxQYmdZNUVrQ09Wb1Z3NFBLUmpmdjE4Vkc2OTNIZjBXMW1I?=
 =?utf-8?B?dmI5ODBCSkZrUVJ1eFBmUEFxSUVSZlNkYzRUL1hqb3lNVjIza3RQNlFHb3lt?=
 =?utf-8?B?NGFab1BrV1M2eW1qSUxPWGVrQzBDV2x6ZnJpY0dPVy93VzdKQzZTNDF3cXhp?=
 =?utf-8?B?Rm1tdFl0aG5NaW9xd0xrS1c5S3ZoeHNHVnBiZzRPeC9hU0NmSW1oMGpmY1lt?=
 =?utf-8?B?MXg2VER3eWRNY3FtWVJZVEpXd1dxK0IrWkJvbkRhTU85Ym5PS0lxY2M2UGc0?=
 =?utf-8?B?TXlyaEVVRDVwUjZtaUdZdzJNMVdOTVpGNTNrUlJtcERSOWFrUGdSTTJpdnd1?=
 =?utf-8?B?MFdQUEJXdFBTN2R0UHp3dWVQYTl3L29SaGxrSmVIMkZZUzRnT3ZlWEc5VzJJ?=
 =?utf-8?B?d0x5QjJDSEJmUWxTdzNFeWk3bHNJdHQ5Z3d0UUdsT05pNVVPdG16SWI5Yi9Y?=
 =?utf-8?B?ZlBubjVWbkZnRm5nbjlGQ3FJKzFscU9QcDl5STU2L3crMm92UFZJaG9Va1Bt?=
 =?utf-8?B?ZGV5R0pkdWlLdSt5RlBhTDFSK29nZ2pEdGpSL0E0ejVoc2xENFJVa0lmSnlZ?=
 =?utf-8?B?RVRDSFVjN2cyQmlhOTRDUlZnVHpOQ0JvOGgyYnV2cm9TdUEzWFZHVXl6Q2Z2?=
 =?utf-8?B?ZDU5b0paUnRuUkI3cnR6N0dBUEpWalAyY1czaFVielZtOFA4ejMybTBDMHV0?=
 =?utf-8?B?V0QxTm1TaWx1c1k5VlBJM21LNVhHcDIvTmRJRFdrMDBqMmVBRGFmUHM5dXk2?=
 =?utf-8?B?Qm96WU53YVNpOTBTZ1psRTFtOFpXZzRPSzBYdVVHNnVBWUFGRXpUdFdjQmNJ?=
 =?utf-8?B?WXVlbWFXVU5XSytGdTJaanFGN0xYenE5SHZKZnVHbkhYN1FTcURQSjhMVmx6?=
 =?utf-8?B?alVGSzZaNU93QXNtU0VCZjViUFF6T25sN0lUUUVpdU5zSGJhNnltRmVEM1N3?=
 =?utf-8?B?U0U0TklUb0diejBoOFVrUXlCenB1eEp6QjdpVHVQcG96NDZhc0creXBhT1ND?=
 =?utf-8?B?UHJ5STZoYy82T2x6Z1ZOY3dGc2tpVTFvdWxPbmVTMHBURDBENnlIdSt1SDRU?=
 =?utf-8?B?SXM1TVRTUms4VmVWM0t5Z0RWWnFaTkt3bWZIVWZ6VnVsYTBLbUkwbEQ0eFJX?=
 =?utf-8?B?MDByTGlRYUFvZ3ZKZmZCZW1FNTFGV1F1OUxzR0ZTYXJ0N2JVWUt3SUY2Zk9E?=
 =?utf-8?B?MTFTekFOcWlGaHlOOXdqT2JHS1hsMWlIUWRpZUdEaUNPMzg0akpxWjZPTm1u?=
 =?utf-8?B?UXhTc0gzdVB0aDFRMXdTN1FVVVRtZDltM2lWbmgxdEFjTSsyQUp0emJmOE0w?=
 =?utf-8?B?SkhGOXNYWnB2MW9oZkwrd3dJb3hpVmw0MHFEdmtDNHRWc21EZFNyMkdLN25S?=
 =?utf-8?B?REhrWEFLaGpTV3NIRlFGM1A4T2dpTmg4SldMRjRXUDhtRnJiWDlvNEdJbEg3?=
 =?utf-8?Q?oJInrhsb29q4nInRrleprkemP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebca81d-a495-435b-4bd8-08dcf747f943
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:59:27.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWs/njGzDY+IkABz4dB1Aio6wC2G4lzVvkm60W3kySU9kjRMXHaHZnSlaC4PlKy0jQfvOk6R/GlFffH/k7Tq8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449


On 10/25/24 15:03, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 17:52:01 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependable on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  1 +
>>   drivers/net/ethernet/sfc/Makefile     |  2 +-
>>   drivers/net/ethernet/sfc/efx.c        | 16 +++++
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 92 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
>>   drivers/net/ethernet/sfc/net_driver.h |  6 ++
>>   6 files changed, 145 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 3eb55dcfa8a6..b308a6f674b2 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -20,6 +20,7 @@ config SFC
>>   	tristate "Solarflare SFC9100/EF100-family support"
>>   	depends on PCI
>>   	depends on PTP_1588_CLOCK_OPTIONAL
>> +	depends on CXL_BUS && CXL_BUS=m && m
>   Do some makefile magic and stubs to only support efx_cxl.c
> being built at all if necessary conditions met.
> Doesn't necessarily need a visible control.


Yes, I have already change this after Ben Cheatham's comments.


> config SFC9100_CXL
> 	boolean
>
> then here have
> select SFC9100_CXL if CXL_BUS
>
>
>>   	select MDIO
>>   	select CRC32
>>   	select NET_DEVLINK
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..fb3eef339b34
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <linux/cxl/cxl.h>
>> +#include <linux/cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_nic *efx)
>> +{
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
> If it can't do anything useful, make the build depend on this
> and provide stubs for when it isn't enabled.
>
> I'd not expect to see any ifdef stuff for basic CXL in this file
> as it should build unless they are all configured.


Right. I got rid of them after the changes commented above.


>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +	int rc;
>> +
>> +	efx->efx_cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
> __free magic here.
> Assuming later changes don't make that a bad idea - I've not
> read the whole set for a while.


Remember we are in netdev territory and those free magic things are not 
liked ...


>
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> Stash this in a local cxl_dev_state for now and use __free() for that.
>
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_err(pci_dev, "CXL accel device state failed");
>> +		rc = -ENOMEM;
>> +		goto err1;
>> +	}
>> +
>> +	cxl_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
>> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
> 	cxl->cxlds = no_free_ptr(cxlds);
> 	efx->cxl = no_free_ptr(cxl);
>
>> +	efx->cxl = cxl;
>> +#endif
>> +
>> +	return 0;
>> +
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
> With __free changes suggest above, no need to do anything here
> and can return directly from the error checks above.
>
>> +err2:
>> +	kfree(cxl->cxlds);
>> +err1:
>> +	kfree(cxl);
>> +	return rc;
>> +
>> +#endif
>> +}
>> +
>> +void efx_cxl_exit(struct efx_nic *efx)
>> +{
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
> IS_REACHABLE() maybe, so if this driver is built in but CXL_BUS
> is not then this will go away.
>
>> +	if (efx->cxl) {
>> +		kfree(efx->cxl->cxlds);
>> +		kfree(efx->cxl);
>> +	}
>> +#endif
>> +}
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..f57fb2afd124
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +struct efx_nic;
>> +struct cxl_dev_state;
> struct cxl_memdev;
> struct cxl_root_decoder;
> struct cxl_port;
> ...
>

Yes. I'll do it.


>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_nic *efx);
>> +void efx_cxl_exit(struct efx_nic *efx);
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index b85c51cbe7f9..77261de65e63 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
>>   
>>   struct efx_mae;
>>   
>> +struct efx_cxl;
>> +
>>   /**
>>    * struct efx_nic - an Efx NIC
>>    * @name: Device name (net device name or bus id before net device registered)
>> @@ -963,6 +965,8 @@ struct efx_mae;
>>    * @tc: state for TC offload (EF100).
>>    * @devlink: reference to devlink structure owned by this device
>>    * @dl_port: devlink port associated with the PF
>> + * @cxl: details of related cxl objects
>> + * @efx_cxl_pio_initialised: clx initialization outcome.
> cxl


Well spotted. I'll fix it.


> Also, it's in a struct called efx_nic, so is the efx_ prefix
> useful?


I do not like to have the name as the struct ...

Anyways, thanks for the review.


>>    * @mem_bar: The BAR that is mapped into membase.
>>    * @reg_base: Offset from the start of the bar to the function control window.
>>    * @monitor_work: Hardware monitor workitem
>> @@ -1148,6 +1152,8 @@ struct efx_nic {
>>   
>>   	struct devlink *devlink;
>>   	struct devlink_port *dl_port;
>> +	struct efx_cxl *cxl;
>> +	bool efx_cxl_pio_initialised;
>>   	unsigned int mem_bar;
>>   	u32 reg_base;
>>   

