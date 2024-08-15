Return-Path: <netdev+bounces-118685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE7895275A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD761C2146F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A018D654;
	Thu, 15 Aug 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFANumML"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90515D1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683604; cv=fail; b=fjk3cNZ0SuvXVYGfdskq3kh8RRhbLx065En0ytT/kVEJsxGbdK4TWRIoeYmDhGF1dzAtBBgE2DvyS90jFWH9RWC2unJHTiY4Woz3CYkzxFNXyjOupQ3mh/nDdDjuxs5CG2iDqvXdun2T4RYRaoD8ZHxGkR//9RjbwTHkTOLWOTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683604; c=relaxed/simple;
	bh=TJFyHr+h7orL65IJ1LNs0FzoSrgnknOtkptO0XxaRvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AdmibqyzPzcubZf5EgoxKzdggS+l8gmyqMsfk8PZHF6bpkd2rR51/9kEw6pDsUEg3XBSoYQlx0yXQrb07vvKwhBHNHsJK/zCBSOTZRnz1z5h4vc/iNJ1p6N9uYygGy60MSGmun1wHbBz2uukRlLJn1gCacfaqeKFlI3KSZbUNRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFANumML; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ2giIdE+lqSbBJ57epumRtU5jLviGq6OMCDzhCT72so0DDAj30vQawwfjdNqld52baeK53MN/1mOEf9+GySM2Nl5YBWhsw4NqLOShwXT/0U8DZPzBZ4OvfBRPHEuYN9j2L8MF3F3PSZ3G1ofi9F3x5PUlMpODvFfPlghUGfwUab8s0tKoOzPU4r/IYMuMs8D4Dum3XN05N5/nfAoUS1cK5ppS8hzFUTexWwQBTndOGVpPNuAp+mu5976BkqtQdFlDubm+iI62wCaWYuBFZdRiSuOQYCXvqETmbzBmOA8tu3BpYc1DZWBnfr+x2SO+6jBiqSjGrg6Irz0nx72mlbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3cCXjyuZFIxdd0Ek50QeFwXlAC9TCz74N2Zsyc18ho=;
 b=fbXbDvdW6PAnKnQU0bVtsN3DMcUGqw0thHk89CJQd6NIU6KsYpfLzreh5dc48w2pghuwrF/0sdF20jdihSamMJcAXgFjzVeptwDsY4EmURdeWMiMW+6jQysvbCs88sffhsGodxd+zcziHVLrMV/96PGf15ZXu9mPBvwfc3A6wQ1LvR9PuPzmwO1yR54LdbYYZ+YBLZ/EXGiLjzBvP6oZrUMQjHXLjxrhf+XHqp1LLO0Tk/cSUthQqvQd0GstmRTYSujWBTZPzTzFu+yNdqs/llecmkj8QCevyZnNj4o+k5Ca6E5vRPU+ErHT7p0k4LamJOjApZ6HwfjdoU01xYQCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3cCXjyuZFIxdd0Ek50QeFwXlAC9TCz74N2Zsyc18ho=;
 b=VFANumMLlM1La46FqSbb5fy4MLdy3072RkiQdP8FzSptfqv8+6KNqTLWNZddH5DlmeifR3Bgl22sl9n/kAQ7GsScJQTdxqK4UoYegUSxexVX2fcuK8Ixiv7TTOqIbuHLeGby3QNUdSXeEHv3NgWGoZO8usSRY97us6Wc+iq9GNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 00:59:56 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%6]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 00:59:56 +0000
Message-ID: <e2005b62-82d6-47b0-bd09-b9ee0c16070a@amd.com>
Date: Wed, 14 Aug 2024 17:59:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ionic: Fix napi case where budget == 0
To: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shannon.nelson@amd.com
References: <20240813234122.53083-1-brett.creeley@amd.com>
 <20240813234122.53083-2-brett.creeley@amd.com>
 <20240814172748.594a33c8@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240814172748.594a33c8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8816eb36-3587-44ef-b7ac-08dcbcc5946f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTFvdVZQTGd4V0FCNGxhcUIwZldRbDEvZnRtU2l1SndwNHhmYkZXQUovU2E1?=
 =?utf-8?B?cmd2QUVhS0pWN1ZQenNkS2l5WE5KUDhnTVBwR00rOUFmblRPdEgyTGRzNjly?=
 =?utf-8?B?eHM4am8weDI3eHA4S1ZQRTVaNTUyaXQ3eUR1NGhkQXE2aGNwcTE1bUNXSVk0?=
 =?utf-8?B?Tld4VTFWczRITi9tOXlvMnIvMGRPZXNMcUpzcVFIdUNtWUZPVUpQamdmbWh4?=
 =?utf-8?B?djE0RTVYc0ZvaCsyQ1NuQjlKbUhteU9aTmRPS29wb3l0L0diZ29GUlRjK1Bn?=
 =?utf-8?B?dTRpMnF0b0U5NlNUZFFvYkpDYXV1Z1pDNHV1QVR1N1F3VG1BWGhlVC9rRWhE?=
 =?utf-8?B?cnVvU1czRG9xYTcrUUxYS1NQU3JHVDJSTDhFYlBYcWhtZlYzR0FLQnZDRUdT?=
 =?utf-8?B?a0lJcXNnVGxlbjFYSEdXZVVrcjJQaWlsY2Z0ZzQ0a0QyUzVBSjBXT2d0OHph?=
 =?utf-8?B?QW5YWVZPVXhEYnFLOUx3ZjFWdm1iOUFGWWZKZ1ZWV2hPaXNaUlY2S1FNb1dD?=
 =?utf-8?B?VUsrTDNXaSs5alpzbkk5eFRwM2dqNXVmT2EwUTE4NUFDeXQ1WnNFMFJyd2Ex?=
 =?utf-8?B?S3V4M2pzcDU5V2g5RTVSV2hrWVkxK1liWjExUVhxRFdOMG5xQ2NyVklHWVJF?=
 =?utf-8?B?TVdkUGtITjJoaWVFOHlwQVU2V0NxSWg5MmdQdWRTa3JkZGlCMjU4RmZ1UlZ3?=
 =?utf-8?B?ZTAwUWF2Y3N6QlNKVlNHTkRHeG1PUGZkdUZWYlBjck5LOUpoQ1RMajQ4R3ZN?=
 =?utf-8?B?M2Z4cTZSUmFmMGs3M0o3RFp0dTdoYlVmZUp1djRDM0RPUDBMbHc3cjIyd25v?=
 =?utf-8?B?ck9TRUhyMXZteHFLTXgwZ1hOMnhONUlwTGF1eFRRdytHaUxFc0Y1VU9pMHhm?=
 =?utf-8?B?SFdac2NEM2NWZnQ4TnQzUG9zMlcwc1FFVFhEcStRSWRmeEk1QzhDSm5MNlly?=
 =?utf-8?B?TlVZL001ZzYrVnpYS2NPay8zWXNZLzJVTUZGK0tvSXllSmxod2Q5Z3B4czRL?=
 =?utf-8?B?cmRRcFpXUDBBRUZPVmFtZTNVMHVxTnhERzdyN1NxQnc0MDNZUHRHNi9EaGJO?=
 =?utf-8?B?dkdFK0czT3Z6cnRuNE1kUkNqdWpwNHhRNlVETTVhbSs4ZDhDeWVLQ0ZkOFUv?=
 =?utf-8?B?REQ2SW1KWWFZSWViQ2pKakIxd2k1UVNMeU5CcW5UdHVmenY3bEZCYVlvTmJh?=
 =?utf-8?B?OEU0cEFJcE40N3hpZ2NmdFNyUUIvU3JnWEpVNmo0MUozQnZjKzZKYkRWcU03?=
 =?utf-8?B?enpjSWdXUkJwVjhlUTd2cjFjaXhJNXUxWTJGTlpOMUl4Tm5GMWhXMklvWndv?=
 =?utf-8?B?RmZIOUNGL204dXJkR2J3RzJLNHZpdGJVRDNKaEJjc3lKYXd6bXhnaUdNVUVn?=
 =?utf-8?B?VkpUZXJYdWdTTnFCVDFuY0tLbW15d0tSVU03eTlZUU1zTlNtTkFCWEk2S0Qw?=
 =?utf-8?B?bFhrQ3k4eXFtNjMzQ0NuVUd6dW1na2crRTZkMmI5b2hlNkpBNUlxTkt2em02?=
 =?utf-8?B?d2hXdFdZa3U0ZUNXRjZyaDBlaWhjRkZSaUx2amZkZUoxQjg4aXZYdW96RE4r?=
 =?utf-8?B?MEtHSU9HdmZad3o5RHg0SE5yOFp3NHltdHRjTU1oem03ckM2NktMZmQydm92?=
 =?utf-8?B?QzRCak83dUtJWlhCZG9lamlxeFRkYlRDSkpFQmVQTjV4WGpQL01QdkNDNkZ5?=
 =?utf-8?B?bGdhdUJ5NUlCWjY4OEpvd2gzOXdOTHdlaDN5eE5GUG84cVNJeHZxVkI0S2Vw?=
 =?utf-8?B?WkhEOEZhek1XVm1OM21DeGRvM0JKUlZ3cnl5S0l3am05YzlTZjljc21Tdnhp?=
 =?utf-8?B?NGpGamdxbVhJczZPcFhyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nzc1a0xzSGlkd0ZGRFhUVUtoRVNob3R2WWd5clRaN2dHRjF0MXR6anlkUWJo?=
 =?utf-8?B?eDMwSCtMMGdSMlRDbWNCdU43SFBpUjFJSzluWXZyV1cybnlIRDRBV2MxdXEz?=
 =?utf-8?B?djJYTmxRZ3hvNXFON3B1elZGMThZMW0rRlVnbmVjSkUrbHplUk45U3NIVmdD?=
 =?utf-8?B?em96Um5MYjQzU1NoSEx6b1lEQlRTSEpmd0FrS1VKbURCdGpXZHVGZEUrUnFz?=
 =?utf-8?B?Ti9pNmdEeWRrZUdkRXUzU0daYnQzUmZrdWhwRlNjM3gxYjJTZkpMYVc5S21n?=
 =?utf-8?B?L3k2WDZ4TmZqa1pDRkNJMVVheWdkNTFyemp2VVlXRmVNTWtyTkRaWGRsWkFM?=
 =?utf-8?B?VWxJaldTelNDSFMxUjFweHY5dHgvUGxIUUxvcFJUNTBHcmdacnhLYUlqb1N5?=
 =?utf-8?B?dkZRcldSVFZpM1FHWWR1cHd1R3BUTnFrVHFRMnB2R1RibS9mOFlYRStlZHdy?=
 =?utf-8?B?UjA1NXdxL1NiMDZhZjZ6TUlTRWM2OCtwbmlQK090SmdaRVhQdUNtYnA5L2dT?=
 =?utf-8?B?Y0g2UmFRcGsyWGVVRTJUakE3VWYxNEVXbWV2VkJVK1RKTUxFZi9ZcmFadjlw?=
 =?utf-8?B?Mno3OEtCdXhzZmkwdTFyeWZMZ0hSY3UwenhhaVp6MW14UkdYQU9tK3loVXdu?=
 =?utf-8?B?UjM2T3ZXMkEra1hKNkFPWGNteEEwbk1TZjRHdGZJb09hem43QmY1a09SMzF5?=
 =?utf-8?B?Umk5NWpiWVNSSUtQbzZNRkhoY2ZiRitjYWlpOUZOVU5ZdEVZQmx6bWduSE5P?=
 =?utf-8?B?c3ZyamZpV1BDTkNid1J4V0FCQk9MaG1ueFJlRmxlZ0dCUHY1cHRjbXpOR2FS?=
 =?utf-8?B?SExmQ3A4R2hiamcyamJEd3ZlM0gwckMvd1FIMHYvRG9ldThOTnUvWURrcXpB?=
 =?utf-8?B?YndWMlVOOUp1cWY5OFRTOHVMSUh4UjlINzVDVzBpUlJqKzZyRFFpNXlNeFln?=
 =?utf-8?B?b2EvRjM2VGh5VmhwYzZJQ2VSa2tWRHNZYmxyTlY3endRUGNqVnJmOGI3aFV0?=
 =?utf-8?B?UTNRTzRFblpFZjh1UHNxYk5tTld4SU14MW83cWw4ZVIxM0ZUeFJqYjBXRUI3?=
 =?utf-8?B?dEEyRkhaaUIrdjBFR2VBSXJxVXRLdVo5cXdQdXVkMWhmN1JVdnNuNW14Nzlz?=
 =?utf-8?B?ekppd0t1T3c4eUdjMGY4Vk9iNXIxNTI0N3E0U2V4UXpDclp1WSt3Ykc4Z25L?=
 =?utf-8?B?YUUrNDJyZ3BzallXSG44Wkg2MDVhK1N2WVlqQnhRRzJKL2hGemt0T0cwS2Rr?=
 =?utf-8?B?M1lhSXlnTEVBMHFKR0J3RmNUeUlydXlqenZBTFRNOEZBSCtZalRvdmU4eUtG?=
 =?utf-8?B?RkdCT2NQQi9sWTFWbjEycE1TeXZTK1hEVWp2Qi9nQVlyYWdGWGF6dkpKOEp5?=
 =?utf-8?B?dlhlc0J0cEdYbFV6QWRmRVcwYk9sLzhLRGZGeEphNmQwdlJjaTYxUUVURk5q?=
 =?utf-8?B?dGp3OVJoUHBPYm9qUkhjYmMzbjlud3o5eWxyMmh6VEprcENScExxWG5HcnVS?=
 =?utf-8?B?OFYzUzdzZktJZm1TdWlseXNmTWtJa1RNZThpVmdVN0Q2S1hEekxyeUF2WCtp?=
 =?utf-8?B?SWt4bStENDFpTEpxMXljdFYyL2JoZG83dG1BWmNMUFJmdzBOVWtueWk3dWdS?=
 =?utf-8?B?a3pObW92RFJWQllHeXZIT3h0emw4ekRTblVwbU9BSTJWK2I0alRadndJNHVn?=
 =?utf-8?B?UTc1WFE4ZjdRY2R5Mm52VFErRzBXbzN3RVJqK1I1bnVSeVpZbTVCVTVZU0VR?=
 =?utf-8?B?MjVBeERQVWJZcWhiMEJSWFhBNnJIL3Y2UW9pdGlXOExCblZHRFNqNkZkTlVy?=
 =?utf-8?B?bEN3Y3ZqQnlzZk5idnpIYkNDVXl5cTdsWk80V1hUeVdNajlpQWszcUtDSldh?=
 =?utf-8?B?SENDYVhVWG1vazFWanlOVmxWcU9BczhJRUpDYUZQSEpOa0NLSEQvNjJWODh6?=
 =?utf-8?B?MjNveU1OLzZGemhNSnVTUzE2SFJTbkptNFdDUXlHbnRiNy9DS1JXR05JUjN4?=
 =?utf-8?B?OFVraXFHM3hFM3haSGlwMVpyUE1oU1hlTzNRYlZoZ0hmUnAyN0ZKMzVwZkcz?=
 =?utf-8?B?YVU0UUZyUlFIK0RwNnVUOGVPbkJSSHhWaUlWV3NXVnFaWGo1aUFDUXVaYmh2?=
 =?utf-8?Q?0g1VEZLtAy4cZg++W4dYs/8ed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8816eb36-3587-44ef-b7ac-08dcbcc5946f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:59:56.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03e7lk3NCkKyi/Akls9vyzDFkbLjzjukD0F9g9EiNSzAeE90XjEnBR9JoRcXHxE9LC59cz8X0Y5O+9Ao5rwU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557



On 8/14/2024 5:27 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 13 Aug 2024 16:41:21 -0700 Brett Creeley wrote:
>> The change in the fixes allowed the ionic_tx_cq_service() function
>> to be called when budget == 0, but no packet completions will
>> actually be serviced since it returns immediately when budget is
>> passed in as 0. Fix this by not checking budget before entering
>> the completion servicing while loop. This will allow a single
>> cq entry to be processed since ++work_done will always be greater
>> than work_to_do.
>>
>> With this change a simple netconsole test as described in
>> Documentation/networking/netconsole.txt works as expected.
> 
> I think I see a call to XDP cleanup as part of Tx processing.
> XDP can't be handled with budget of 0 :(

Well that's unfortunate to say the least. I will look at how to fix this 
as well and send a v2.

Thanks,

Brett
> --
> pw-bot: cr

