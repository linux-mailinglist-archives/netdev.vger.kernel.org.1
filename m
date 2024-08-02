Return-Path: <netdev+bounces-115390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE194629E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D85128667E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68784165F00;
	Fri,  2 Aug 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLbefwM4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AD1AE02B
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620293; cv=fail; b=HkXI4W88GdZxxKHo3NFrZsRgCQuZY7l4LY6ZLsylNp0lnrFR4+/FUuugALpuC+I0+i+zp1yn46rpwDJfkk8QZaeO8by76LQRtPEPPJ7IDimWRsHwscVwzkF1FRGp04cm5xTKYuUwmSu9Zz9NNOLawPFi4hqDxihoVMUp8Z3Kjng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620293; c=relaxed/simple;
	bh=Ijeh3qs/Dx6h7VRY/k9UzN1W7iTsz5ruH3aZj9tm3TM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1J51/ezqEzkZdsfpA3ZGbNwJxn0+JgLugcPTEe8gnGz0LhHqejmkyJ1wrPgH3rTcZCWpAz4lPbVc2vXiA71bQ1rIacWNpdTrLon785VPLaPWm42cvHIpNW1ZcTQWieYp1U5EkbEe/fmBYiSBEoiUixEiVRk/vtAobpkDmPZoGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLbefwM4; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caoKyjiu8kIaFTwTBuLQwCbG7a7xX8G/i+rw/v0jcsuFRtO/n91QglOBy5N3m2ZYpt3RCmtXiOg6L98TjBOuOr+ojiFHFi9IMqQBh0FDvVK/gk8jadv3OPevEqbpC7HEFiAwgAzJTv8eJ2pcrevOrWw98xfcbJJ6p7KT4NO6OcrEb36ziFd1CO4A3w772MqCpYR55jOrni4LOsesoSdPLudYEIJSpG2LEMVHSqB7k7HAjsT7s5xDeWOW+SpmsLgkKryRrXxFrwVx2y3BaU9E617YS4kvEPzMfxsWO+x8nEOrgTbwaIdA41gglP/kPJqKvxG+aIxnrfdbwhXr65f6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T47L81yj4LvLP3Ix+AvQui5Myfw0SAnY7M86gAj87mk=;
 b=D/92iZSGiGOi8DoVZShF33imEgknOELuHDhF6luuNMBam10mDHzCKGiqGUG/93CiVN7j76Fxv7i6MrnTNlSsO3v+IPPu2M+PXDGP6wocdgdVEZ72OWifVJD3bKwqGfAVgW47WprdQiC9L2scBceqPJOfNTNUF8MBD94+FsbpzTjqU42rTTE62VTOz/707VBhiOO5T2qmDGf5AbB+qIRKML7Je3aKr/crWwv2Un4633BM8e+ed1uA6UGsa4Qim/S+CqOV+MpJ0RqTmMduqe8dXXlujBhnTZE1gMhdJXQbfGjNmteL0eJSfLO7lL6V4tWuT/By/YAiNk2yeVNwKkjkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T47L81yj4LvLP3Ix+AvQui5Myfw0SAnY7M86gAj87mk=;
 b=eLbefwM4svy1MtDcwLRyakYZuv+GHvHVX5jdQmSM+I4Y6nCSRihRvHKkivbYIUIE70mlB/5MRsm/o6wqKeit5SU9ehY9nVF14/GHeSg0AbxEIKmQ7fuC2vjcbP8qHvXiuVLXUJ0RhuVJfRzILr3eOjKygH+gL1MkEnh52k+j0lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 17:38:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7807.009; Fri, 2 Aug 2024
 17:38:06 +0000
Message-ID: <a49585d2-484d-4b1d-8f6b-197cd05fa1ce@amd.com>
Date: Fri, 2 Aug 2024 10:38:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ibmveth: Recycle buffers during replenish
 phase
Content-Language: en-US
To: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
 <20240801211215.128101-3-nnac123@linux.ibm.com>
 <e7878a08-440c-4ca7-a982-1b9a71ea9072@amd.com>
 <aac40c02-3783-44f9-a8c8-97467570d4d5@linux.ibm.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <aac40c02-3783-44f9-a8c8-97467570d4d5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 5520e704-e2f3-4f86-f8ec-08dcb319de06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWs5VkxlNmVyYnI3NFNHNm9jSjljbVZxOXBVR0pXL1FhNjVjQXVoajJ2d0R4?=
 =?utf-8?B?b2JtR0xtbTdYV3IxS1huaG9zMjI0a2E5YytEZ1o2dTZlV3FRMVQrVTZnYXcx?=
 =?utf-8?B?OHUrL3c2eUFkVndVK2xEREFPSUN2dysxWnc3M2xKVVQ1Y3hINXA2K2RMeEZ5?=
 =?utf-8?B?b2xYT0FGUUVsbnhycTVnOVJJZi9GK0dyS1czN3c4RVc3UlpSdTVmSzQ2Y0dF?=
 =?utf-8?B?cFFoM3RiYmNKUkxTbUV5TzVIZk9TM2FoNHQwbkh2WE45TzFvdGorc0k4d1Z0?=
 =?utf-8?B?Z0RBanE1anRDcVZpZy9rbDc1dVBDdzBKYlVsN3U1VXYvZG4zNlZTMEdhRERj?=
 =?utf-8?B?UGowbmR1NFhZMmNhN0NJSDVtb0M4SkM4R3JiV09qMDNzTldOemtCbkFnR2d1?=
 =?utf-8?B?V0JOZkt1eFdDNEk1VUZuWWJ3QkNZNlJHdmFkc3Q3MFV5QnlsVVQ0a0drdDlL?=
 =?utf-8?B?SEZjcHBUOXMvYzFTdEMvUFYwOHdNN2lpQnRLRHhKWmtEbmMwN2pyUGNFUG9t?=
 =?utf-8?B?NnFydy9FcXRxZVpGNU1TV2hndEZnK211eUFRY2g2TXd3YXpxczRWT2ltNGJY?=
 =?utf-8?B?V1N2WGEwS0JleXhodXFnbHdLRk9QbHl2SlF4MVN6N2d3ZnZVQnZOQ3FhOWpz?=
 =?utf-8?B?a0czdjlFY3RpeXA4cnozWFpVSzhEd1Z3dURJaGlUc2ZSbzVCaWpWUWZVWmFJ?=
 =?utf-8?B?UmlKamMxM0Z3L25OTG5XNitWbjRtRHRoMG5IZlZPMjk1SG5MeHplNjdBUjR6?=
 =?utf-8?B?Q3VEWGUrTk5ELzgrM2UvS3JPZFJxMm16bTE5Nmx5cUpqWWpMSlRSKzY4UXox?=
 =?utf-8?B?Wk54NWtRSDF6TS81TnZsTk43SG9UNmNTcWhncFBOQXFBemp1OGdpTVBzZnVx?=
 =?utf-8?B?Vm15Q0ptVWdDK0o2aTNXZm0xWmhUbTA4ZDhvS3o4akhCUVRDdEhPbDFWdjZ5?=
 =?utf-8?B?V0g5MTVOSklNZWpCM3NmekxNeWh1M1cwTDNYUTNOZUt1cklDYWxpVkdKeFJk?=
 =?utf-8?B?dWppRW9SUEtqZWdMWDd2aWcrdThBRlpmNVFpRjZWNnlMemFMbi9DSWlUT0NL?=
 =?utf-8?B?Rnl1Z09RTGw1dk9QeGRnemZ4cnIwVU5tT1A5NTVvd0lja0FPUVhHeUcrZkxx?=
 =?utf-8?B?a1ZicUNKK3U4NEs3N1hWbzRVZ2VVaHQ4d0dvdGZsbmx2K3RTbE1RNytGd1dP?=
 =?utf-8?B?T21xV3YvaVJzUjV5YXhMaXZKY1VTdHhBbDhYYkdieXAvRWNJQVZHYnMwSHgz?=
 =?utf-8?B?SG5EUTZaSEJGdTB5TzZSVmkyVTRMT01WUHE5SVhScVcwc2hsRHhrVmZBay9X?=
 =?utf-8?B?aGUrelUvREYraytRbVhvRmw0YmJDa29USWFrNHZJV3RMZ3o5eWZNVlBTRmt1?=
 =?utf-8?B?RGRFYXdFUmFyMS9lMWVYZ2tjUHhwMXpGYnpxQWVVd3hsSWluMUlQY1pPMWwv?=
 =?utf-8?B?OWtDZ1hNcmgxbjFHWjZIamtjR3hwWUR6WGNmS0d6ZzFoT2p4aWJLOFR2U0RZ?=
 =?utf-8?B?Z0d3SDBVbHJFQ0FOMndGT3B0bjZtTXR3TkI5eHFhUGNSZ2ZIRGpOaWdtZzdh?=
 =?utf-8?B?SG12dzliSVIxTnVUcHg1MTNQY1NoSFRDcnowUVFUOHcxdGwrbERSNUF3QUtK?=
 =?utf-8?B?dktPdm53U1FFaXF4bG5mVzJYQlpuRnZKaUpuQjlITnVhNHRVeDd6c3YwbFNZ?=
 =?utf-8?B?cUFYRWNOVDY4UEFSNTU0NUFUZnhaeFB5L1hWVzFPL3lUNG5qQ0cvQ2MyUElm?=
 =?utf-8?B?NDVnSThiaHpxbUN0ZUdHWEdlVFZmYjNBcGlVWnpGSWtiU3VPZHdMTXZJQ2hy?=
 =?utf-8?B?Q05sdnVpdm1pUDRWRmx5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJQQjVnMXJrMktlUTlKWkFBY2duV3JMMEJGWFBwZS9Gc2hYQy9BOTYxSVBs?=
 =?utf-8?B?RmVVeTZ3bTYzN1ZBQ0EwcTN2SGFCMGVKTWg2SFlIQ21tSllLWXY1bHdiVFRr?=
 =?utf-8?B?WE1SY2xFL1d3YnBNWGxPL3RWaWJqSzdpd3FPbllheEdsUWo5eXNSbmRJZ3Jm?=
 =?utf-8?B?REIrVmdhTUxHaU9JVm9mTDBFNElUa3VEWEVvdC9TNCsza3IrVnh2cVJWa3pY?=
 =?utf-8?B?bXNUcU9xVTdQd2MyNUFUSjVxS3p3SGhVQkV4REdTcnBrVW5XUnpqNyttV2h5?=
 =?utf-8?B?SFkyb0pMRXVoUDlXUjd4cGRTTHhsV3NNUFBLZ0xMeUNJci9PdGRNYzk0dHAy?=
 =?utf-8?B?OUpJKzZyNGJ4WEVYdnNwWmk3bW9yYi8yWHFKVzgxLzRES0JCaEJDSUdIUTBQ?=
 =?utf-8?B?enNsUVM5M1JyRE1Odnc4UHNjR2ZidUN0Q09MZHRXSG5NczVvenI3M1JDSlN3?=
 =?utf-8?B?bGFjYVRZZytEUDQ4alJpcUU5YTVYZFQ4UHV3NXc5UHgrOGRGaHFGZjFlWjJ3?=
 =?utf-8?B?MmgvZFNQS2RGVkptSUVOKzNxN2Jxbys2UkZ1a1NNRWhHeUZiVkI5V3oxSzVO?=
 =?utf-8?B?d2UvMzJUU3hOemJzazBhSGRKUnE1YThna0NPbldBNWdnalJ3aktkU2xXQmcz?=
 =?utf-8?B?NHlmZ1RlTy9kSGgveVgwWEtrQ29peW1rWFlqdm5zekExeEdVN29NS3NwREdL?=
 =?utf-8?B?UGxsZG9hRGp6aHRGZ1BBREdPUFFWSFh3OXpJdGJxR0FKa2xpQm51TUVDQTBO?=
 =?utf-8?B?UTZMa1JpYVpjclRCcE1mUW9yN1F3YUZsM3FKdENSK2FuZG11c3F5VjYyRUFY?=
 =?utf-8?B?YjJzclU2YS9LSkUyZG5mL0UrRzFCWDArYkJsakxoSklDWXhOZVNCb290cHc1?=
 =?utf-8?B?Mk5XenAwUmtBemZZemtKa240MTA5MXBkZEp6cy9JaU9NYWlhWGVvZnlpeG9h?=
 =?utf-8?B?d0habDgzSFo0TlB0V0hNTC9WK2Y2RVJKMHJxN0NlcXpaS1dHOXRLTkl0OUtQ?=
 =?utf-8?B?WXN2ZEl6ZzVVWGRJanowNXE2N2hoUUticlFEbkFLTnBjYjFibytmeHAxamFp?=
 =?utf-8?B?WlMvd0hxK2xScURzdElVWGFaUXl6TGlXaWhlaCtaMkhzMmVGaUVQU0FTcDha?=
 =?utf-8?B?djRVRVNUVWxzRm55R01UN2pKMENjTTY3MjlkcGFGOVlKdFpvT2pKYjN4alZr?=
 =?utf-8?B?Z0I5N29YdXlQTWUrOEpaVDlTSHFXVXN6cWRUSXBzZk16dkovcENRcXorK2s0?=
 =?utf-8?B?azQxbjVqWDFsQXdVUEJYOFpGK1F6dTVuZWpja1JGVU8vMFZlbmNOSTZuaXQz?=
 =?utf-8?B?Y1p2OEpud3FFTmF1YXFBN3EzbWRidVhkalpaUEd4Rkw4dGZZUFpMR0Q3NXRD?=
 =?utf-8?B?MXYwNHh1ay94c2QyME5OT2xUUFJ6bjJOZTFMeUxjWWNJMVMyQ3JJeVVEWkpl?=
 =?utf-8?B?eHZoTTFpME1oa0xmZm1vQkpwVUFzNXFhd2EzNmRqMnlzMUErbnU0MmVPNWt5?=
 =?utf-8?B?R1JTSEh3d3Y4YWh1QWxTRUpPMHhZSHduVGlJMjRyekRBbThCNGlZMDl1ekhD?=
 =?utf-8?B?MmhNWksxTEtIYk1BTEh3NjBaLzZTVnI1WUdMeTgrQTU2Y3oxckxhN3drRFdt?=
 =?utf-8?B?M05Ja3VyTWlNblV4ZXhDd3o0MWlhZlVWcW9WVldqTHl3c2VlYWNSQXZlYTB0?=
 =?utf-8?B?aHRHQWljTy96TDhjUllhSnpyWXcrT2xzWjR5QTZ2Q3podlkxcFdMR05vK0J6?=
 =?utf-8?B?UGZJMVRuRjJNanZ4SVl4TmMybGRPZ1ZCdCtHeDRpa3ZxRk9SOWcvM0xrQkdl?=
 =?utf-8?B?WnduWVZZdExYR0VCSlVqL3VreHhvSEdRMFRhVG93YnBlYW84NnBjTUlOYzdu?=
 =?utf-8?B?ZEY3aWg5TTNFMlBxbWplR2N5K0pzckVBVDRPV1ZWTXdocy8zeFJ2OFZqQWJG?=
 =?utf-8?B?Vkh5TTRHaHkwUHgwb1gwb09qR1J3MnhYbzVKTVlGeU5VMk96NW5ZZVdKOGNj?=
 =?utf-8?B?UzJUZ0l2VlV4cXpKbWlmWThQeXBVZmN4M1dLQldtQ0Yrc0srYWs2eE40dXVD?=
 =?utf-8?B?RzdlRDZFaG81ZE5DMG83RHRSSGJ2VVlUOVNXbFo2LzdFWXhqL2pLVFlFN3Jo?=
 =?utf-8?Q?CYv4rHgMgFjfos12GELBFaeFv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5520e704-e2f3-4f86-f8ec-08dcb319de06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 17:38:06.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnuPEulU8FiLMGorgPGDoK37DTjzWCUORr5xtOIrNsNI+djTcp+mACpEDEyWpaEk0bJf2HgipbGVASbs8StPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273

On 8/2/2024 10:36 AM, Nick Child wrote:
> 
> On 8/1/24 18:07, Nelson, Shannon wrote:
>> On 8/1/2024 2:12 PM, Nick Child wrote:
>>>
>>> When the length of a packet is under the rx_copybreak threshold, the
>>> buffer is copied into a new skb and sent up the stack. This allows the
>>> dma mapped memory to be recycled back to FW.
>>>
>>> Previously, the reuse of the DMA space was handled immediately.
>>> This means that further packet processing has to wait until
>>> h_add_logical_lan finishes for this packet.
>>>
>>> Therefore, when reusing a packet, offload the hcall to the replenish
>>> function. As a result, much of the shared logic between the recycle and
>>> replenish functions can be removed.
>>>
>>> This change increases TCP_RR packet rate by another 15% (370k to 430k
>>> txns). We can see the ftrace data supports this:
>>> PREV: ibmveth_poll = 8078553.0 us / 190999.0 hits = AVG 42.3 us
>>> NEW:  ibmveth_poll = 7632787.0 us / 224060.0 hits = AVG 34.07 us
>>>
>>> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
>>> ---
>>>   drivers/net/ethernet/ibm/ibmveth.c | 144 ++++++++++++-----------------
>>>   1 file changed, 60 insertions(+), 84 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c
>>> b/drivers/net/ethernet/ibm/ibmveth.c
>>> index e6eb594f0751..b619a3ec245b 100644
>>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>>> @@ -39,7 +39,8 @@
>>>   #include "ibmveth.h"
>>>
>>>   static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance);
>>> -static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter 
>>> *adapter);
>>> +static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>>> +                                      bool reuse);
>>>   static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
>>>
>>>   static struct kobj_type ktype_veth_pool;
>>> @@ -226,6 +227,16 @@ static void ibmveth_replenish_buffer_pool(struct
>>> ibmveth_adapter *adapter,
>>>          for (i = 0; i < count; ++i) {
>>>                  union ibmveth_buf_desc desc;
>>>
>>> +               free_index = pool->consumer_index;
>>> +               index = pool->free_map[free_index];
>>> +               skb = NULL;
>>> +
>>> +               BUG_ON(index == IBM_VETH_INVALID_MAP);
>>
>> Maybe can replace with a WARN_ON with a break out of the loop?
>>
>> Otherwise this looks reasonable.
>>
>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>>
> 
> Hi Shannon,
> Thanks for reviewing. Addressing your comment on both
> patches here as they are related. I agree we should
> replace the BUG_ON's but there are 6 other BUG_ON's in
> the driver that I would like to address as well. I am
> thinking I will send a different patch which removes
> all BUG_ON's in the driver (outside of this patchset).
> 
> Since this patchset only rearranges existing BUG_ONs, I
> will hold off on sending a v2 unless other feedback comes
> in. Thanks again.
> 

No problem - this is what I expected.
sln


