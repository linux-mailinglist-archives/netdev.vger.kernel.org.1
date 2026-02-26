Return-Path: <netdev+bounces-261404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD7VLhtuoGkHjwQAu9opvQ
	(envelope-from <netdev+bounces-261404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:00:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2312F1A960B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68FF631927E4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D8240F8FC;
	Thu, 26 Feb 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BiLLAmd7"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C83A7F6C;
	Thu, 26 Feb 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120367; cv=fail; b=mwyNaOQLahD7L9Bmr3wWN53c854IncMiVjcbMXtuGTcScDfNzcno2x7KT/+4FyBYogucTs3j8gaalyiAkrgbu5tcVuSALWy7hTS0nNPRZjXUVl3xfp2eM30/WHd0GHaBRyikb2Gk5mTOVfrh6kXilUNncXJXgfhknNUTI9A5u4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120367; c=relaxed/simple;
	bh=ew4/kSqxBXivsRZzPn6WM9G3uaEinpljvA49XY/5J7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ShQY+FBYNuj14Lc8Oa4yrdH3ng4KJEh8aRvWOzcx9EP+qBfGxek/oP08Ursp415bEcverbWEdJ7+5R+umWxvjAMEfpgpx6/MCAmHBz+9wmjYT/TUhjo0/mJLB6KdEa3TaPClv/MHgrjuR6lJiQjg9lbqq6LrPUNQsF3WjN19omA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BiLLAmd7; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXluZsNzk9XJecosIpwcoCqes6A3mGFT+tD7eBVMdA4b4WSf/0rWQiQ2reZlbVPtmN5lWBxoxtlz8hVd4xE5tdQ85QubqWlV7ptcz8O+SxNvyjGGUQLlUzuV0KW03o078c8Oa52u+TklxyW0yIFZu7CuLfQdatml5AUZP6Q1/W6HhlVEepbvkNQd4SkGvXKymoD6v2M5R9WZaianNHHbGHfsRcPGhUDqRqtAAQzxSn8fk5PVSYtqyqzA3HLhiXiuWJa5J6UJ6N+Y9TXtJKYXHZRMt64bZlmNi35tO1kdpLEeh2/2S2y9lGTXsejrNJWbdQfmLOHUAk5EB5dNGqRTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kIX733LRwT4fF86a4uD9gF7Y2ltmdEOtRxoTycnLCc=;
 b=T2d4wjz9vYxwse7QtC1G4hnmqK+U6vrTwh50xvHoVupXzom9mcWPl9BTh6/mFBZ3lM609qMKdGcqaYkQKDRisMxHxeMCscNE/Mc4bq+y7hb318neqAKgOq8nmsLKAoa3/MC/Bc4E7nwwf5aM87GvW5ckONrd7YVHFHULKMOHRIWKi8aa2udHY46+1aw8cbefKbN6aPiYUvjUxUZ17QiCJNAww8MfbTzZlo7v4kyKB9rccyj9q5WAWAPsslHo5H0k8cP3hFkOMi53eG231VNHF2CD/j7Uq07QLLIVvGwkEqolWBAchW0M/y7Fd3en3FojGnc9ig2virS23tLlxF98AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kIX733LRwT4fF86a4uD9gF7Y2ltmdEOtRxoTycnLCc=;
 b=BiLLAmd7GZ8lcDwpnnJfYUelRKpPNWV4dB5MXtU1YGyTHod9SLqQxFkCDRjBwjK+4qIaOuRJiQfjr/1np6M8xec4x3GmWIKCRC5J+5DzY/YEkozj7nWQ7f29UKUsiJbfAa0wbgRoBQaeJY1do2J8ibaIjc9OqdvNagoCf4uSqBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 15:39:23 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::5a2c:3b6:82df:208c]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::5a2c:3b6:82df:208c%6]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:39:23 +0000
Message-ID: <693d8650-8286-42d4-ace7-9cdfcc3ba80e@amd.com>
Date: Thu, 26 Feb 2026 21:09:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] amd-xgbe: fix sleep while atomic on
 suspend/resume
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
 <20260225110001.1000014-2-Raju.Rangoju@amd.com>
 <aaA_WJaNG03dcAPB@horms.kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <aaA_WJaNG03dcAPB@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0110.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::11) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5c8e6f-4d40-4cc2-7021-08de754d376b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	MOsfW8ce5lc4UmMsLC9+VnPiO4Q0UJU+mRahyjMehK9q6Ot2/7sFblEwVfOzdpNa+z6LBvP4MpxnI0W8b3mlobt736tA81sVvooYFW/cW4eoIhYynJVDnLkADXUpa7AFJXlnWHMnqUcby8QzUH2bmw2BiGSV73Ur4dwbG1y3kv8ozlj+SwcUtIsDsSyLStOWWzlfHNw3XV2TqReV88ikMS393nLS/FXrVm5lCVJZnndpY9lQo2hTJQ3BwMCCYrqA4yNcuwuCqbxNYEkTPbhI/8soFdZX5GtrYsmf1unIxzyxU8wlRdJXxOvkJ3sdeUIbtZBGUiSv39z4T1qV/MC6rNFUK/xR86GXh+mOVWF/ObT1BHJzTNI94+PbZB8pP+Mi6GrfgBtY5golzVwMzANdNmes+br+19nNhlA7h6J4g8H6KpeixYWAQkuNmR57kGrX32XFUWRi/V6GGReOmCgj5KmX7lZzJ7pW5w+xcBKC3YKS3oE/Zp1s4zK1e3y8wqu2M57/1W5UtjccX0mP+59E04PTWu2N87fWGIkinG36q8fH3iPc65xxq9f6raEQfXSj+RGbPCyzejqtynhFCfMoN+GB6FWrqOTUtjgoh3V/butX3gonAXq/vxVn5qvaxXI/6cpUip8Dp5SQEwxBkofkhQ6wbjhr1iAFp4SKmvVZrbSmhSTIaJt9c2LOBKoRSkLT/7hiimueOs+c6jKSEGOa7bqX5/iuMRWdXBRVyler6Sw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB5544.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU5ZditCNWtUT3ZoYVlOR2tDcElpYkl1dlFjc0tBL3hMbHYreUk5dFh2YW95?=
 =?utf-8?B?Q0ZWaWxHWmR6VXE2Q1k1QlFBYzlna2FRYnREOWU4WHlmdE1XeFFvQ1B3Y0JB?=
 =?utf-8?B?d2gzMmdkNDZLK0FqeHRSYnpuWW1uTkJjK0pNREY5RVJiaDF3M0djZXhFRUoy?=
 =?utf-8?B?aWhrODJacWloN2xiMjdsdHdLRVlFdS9FenY4QTVsbzkzUVN5ZkkrdElVd2NB?=
 =?utf-8?B?K1g3d0NYOUUybTNCUlVtNUQrWmdoUWg1Z3M3dmkwRkh1a2xFalZKVTk1TzIw?=
 =?utf-8?B?UlJQZjJTNGJGZ0Z0SFVKb0xJWS9reXp6d0ljVW91MzlzaFpnSE9tbWxQNkYr?=
 =?utf-8?B?NXdISTRlRFk0b3FFWmJKbjRTTmRNTFJ5YlNES3E4WkZYK09sRHAyODlOZzBi?=
 =?utf-8?B?SzlYeFhBSGU0NitOY1N2TVFGeXBTSS9xeEQ2WnR5RlVCV1AwVUc4UE94VFJQ?=
 =?utf-8?B?akc1TmdYMGVaNmVnMjhtYUkwUk51bVpIWmZRcjY2UEhZVHExOUw2OXJCMjY0?=
 =?utf-8?B?RDMrcHErcVdPVDBPQVNFeTlZOHhyTUZCckFFZDZlNGNidlR1dWpQcGdvN2d6?=
 =?utf-8?B?eXZvVzdtTDdDS3ZIZmg1QVROWGpGUHljSWlKMFNldUJ2emFWekJSUjl1R0x3?=
 =?utf-8?B?Y3luREhzME1WaWhyajhwTmZsMzdieXQva1NuK3ZIVm5xMm5SYld5SjFZSEJL?=
 =?utf-8?B?TUprYS85a1RJSHIzbm92a3loN0R3U0RTaU9vWTAveXBxeXVjQXFNM0oyd3Y3?=
 =?utf-8?B?SEZ6TWlLUlhSYkF3WlFpTXRhVzB2eEs4MEt3MjByQnB4SWs2VUptR3hWc2xC?=
 =?utf-8?B?NHpSamtVRVlMTUlKWWY2WVdvUjQ1Vkc5bTNRT3BDWlZRNlhycTNFb3hmeEhD?=
 =?utf-8?B?M3RnUm96MUc4Sm9Qa0E0VlV4Ump5NXZ0OTN5bmMyMzk3WXVHR2M1M3FLSUtQ?=
 =?utf-8?B?N0JWYS8rS0hOc1VpM3A4VnNPaWsvZDVYZk9RbW11c0tHMjRvSzM2WE1kSEh6?=
 =?utf-8?B?S05xMjF1VzdOb0xzTWdyT29zU2lueTVsRkRDVDVnSFdtaGsyZTVLbjJjYjVx?=
 =?utf-8?B?d3UzZC9jcFdrS1Y2UkdhL3J6RmxTQk1VMjFPWlBhN3dMRWY4bjRIc09TMjhG?=
 =?utf-8?B?cVNVRWpTRjZPQkdJV0RBdnh6b2drY2ZtcDJTTUVXbDcvNUE3SE1YMVlYa3o5?=
 =?utf-8?B?eTd1ZlhQbWZkbnhHSk1aa21RdUJOa0RTcG9RbCtWaHluelI0V1RDN1B6b3J3?=
 =?utf-8?B?SWx0aHVDelBVbDRwZjNvNGt6azZNZ0VmVklBNjM2UDlXTlpzOG9NY1gwbmQ5?=
 =?utf-8?B?TWxNZGt3YThZT2dyS0ZqbW1rS29MUVJTUnhPUHhIMzZ1RzR1OXhLSG1aSWRR?=
 =?utf-8?B?QVZpM0szWXQrV0sySmgzZWMrVk5XL3BaTzR1b3oxdzBKTnM4Mkl4cW1QRUZu?=
 =?utf-8?B?ZllIY1dRZEQ1R05aOExpZThnRy82Vi81VitHeDkzbHBxUUFwYXlITldqcjVY?=
 =?utf-8?B?NmdNcXkzcm5UVlNISERpSFNFWGgzbTl1V1IzcEZCSHhRWElsZ1lqNXdSTmh5?=
 =?utf-8?B?VFlld2VJbWtVc05SeWpnZDdLVmt4M0t4VW9nVnFPaEhiV3M2SWJSWFRnNW5v?=
 =?utf-8?B?NlVYK3NMRjJaVmhkMFpFZ3B4dWJnVDlmUUJubjlRaXYzMU1VSUxXQThzZlRq?=
 =?utf-8?B?bnpmd3AveGFvZWdIWFlDcktWR1VGTzdJeEt2Q2M2Mm9rK09DMm5zaGJmQjly?=
 =?utf-8?B?R2Z6VGxZdGEreEtyeU42QXZnU1pMK0ZPM1l6OFE3UFYyN2NmbHp4cHZIQXk5?=
 =?utf-8?B?OE9RMUJxWUoyYTcrNno5YkpxVkZCYWlGTDc4Q1creWFPVmVoc2RHY0lDazBn?=
 =?utf-8?B?NmgrMlRGT21IM2IzZ3d1aFVsV2tGNGRwcWxWZHM3Snh3V3lDVlJOamUrbjJ1?=
 =?utf-8?B?alhVeTlvM2c3MjZFaGY2L1R4Ym9lVVQ3cENBcEh5N25iMWJsL1FYeTNaVmhp?=
 =?utf-8?B?blI0aXF5U1JLR1J3UVhpMjRpUTlrOHRrbmJXTCtpbzI3cUNJbEVnaGlQS1VI?=
 =?utf-8?B?enlLaERNeUEzTGRTOHFGNFpkNko0UUlNRUJZSVdXMVhMd042YlRFb1JUVVFY?=
 =?utf-8?B?R2lrVDZETDU3ODBRNDYzSVp1T1IvZURJNmxGT2I2OG5aTWx6cE9rQmVsUlhE?=
 =?utf-8?B?bTJNZkdCb3h3b2hhdVgwbFJYOWo1UWU1R0RUYWJDZzNiQUFkWmlzTVJ5RnY4?=
 =?utf-8?B?c2hJaTBmUWozYzZ2NTl0N3VrL0xUY3BNd3I2Y2dtYkloNzZiTWE3REx5b0JK?=
 =?utf-8?B?RzJ1T2s0cXZYVVFOOW9rZXBORXV0MjBFZVRBdGg2b3Nremp5UFVJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c8e6f-4d40-4cc2-7021-08de754d376b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:39:23.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJw56M7xA7Vy/77pOR2nZafg7gyGp55dtLdujLVhpDMZ9nmueTE9/E9Vycany8AATraVAZkD/9pjWeF3uhuHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261404-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raju.rangoju@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 2312F1A960B
X-Rspamd-Action: no action



On 2/26/2026 6:10 PM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Feb 25, 2026 at 04:30:00PM +0530, Raju Rangoju wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> 
> ...
> 
>> @@ -453,7 +453,7 @@ static const struct pci_device_id xgbe_pci_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(pci, xgbe_pci_table);
>>
>> -static SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);
>> +DEFINE_SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);
> 
> Sorry for not noticing this before sending my previous email.
> 
> Sparse flags that xgbe_pci_pm_ops should (still) be static.

Noted. Thank you. Will fix it in the clean-up part.

> 
>>
>>   static struct pci_driver xgbe_driver = {
>>        .name = XGBE_DRV_NAME,
> 
> ...


