Return-Path: <netdev+bounces-233783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE32C18433
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 05:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4FE14E45CE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B12ECD28;
	Wed, 29 Oct 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eCZ4oO/v"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0912857CA
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713715; cv=fail; b=gTTfyCkkw1kHAlg9zFSS1Li/IcFuTg04DVC2x1kC9jBb2cR1PMUEdJedmFTajbfx0RFvSh0iDWexl5TxFGaeiK5azMVdzDnkXdd82eT0hzVfxA5x2FgB0zbv2FJPG99QIddTPz/qWHsdKbCgY6eyoORoCispmg6PJHpZhYvq0vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713715; c=relaxed/simple;
	bh=7OMmRwDXfNOCB8CQFbFYeghz+Eb/HExQkGtjmBHEksE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xtaj7L4lvnmyCjTTy8ZknuZ/LXd4Y7oy6la8GbCAtAjfJP/T13PMXuFmXjOWiptc8wAaEC52L2ENwNCt4DzyBn7L6MIpkDsIVz+D9qbI+h6EKRcApuyqfv6tNhRmBW0O4dHw+G2EgyaGE9KL686qHkVSLzC1gLkxnPrQkLTRxNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eCZ4oO/v; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSkJv07R/8t6ubju9AubicLH78Fj54IxjaFnholazDtbwTjwDdAb5LTjSd21Ofo4cMMNYe3qQBQDOtdeM2RIciXmD66ATaTPP2Z5PDqVBHBaMlv3mMOmE3OeGdID09OfGmhA3sUMIW6o1THTDaK0tYGeDTUsqfydIpZbqWupdO7Z4pGYIRy4At42oSnEwHvKM/Hsg8VALNmyA5/F3lKFv/kjmlgqaMxGgEqy80svEHmiqkAnJJYdRNqsp/D4CwMEODCRHxF5saTZ0kTif85o4DlJP7yhVjasHLbWnCIYMEKLk0DDvSDpfOuM2Nn8CVBkfPbmTtfknauqi6VHIPaalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHD+m1/DVlQxJJHhuyZwnBsOjKuy+OjrIxTZ/T0h15Y=;
 b=ql2QszU/6E2u67XtA9XTGLL97lz5Bkoz+7AbDwMVZBlWv0xp7gUeMc7eB4NZJV9m+zjyHvph127TIMaiexHVpPzg6nh00UjZKRFkOoZfm+lm1DnfTATMPaeA0hGYTwvMfwDv0+XQ3kCGzHUJNFA3eYiRCxn14G/CeQn+TWrUpUkrUBHs+8VJ5i+GD85AP7G1RS+gOuTPr74Qt+32AYpyKEDLBwXsMtz/T0fB6Rx5ADMQRPQYbxQ5l95VDzrpTilw0JYACZD/+4lDN1ii/YVx1q7Hpac4yKuHjmVrWGo1U7QRD2bbL6hmPFDfbKy+E7xnnw9NR9WRey7got01WWQiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHD+m1/DVlQxJJHhuyZwnBsOjKuy+OjrIxTZ/T0h15Y=;
 b=eCZ4oO/vcGqlO4bsQxagpiXx1eAv2sDKE07TkS29/jQHkHlkTibeajT0I0fgPWqu0tO60Rp0Rz2SMeCxEFN/UtUkk8vn5F3bLQqJRG0KSZW7fVMNeDt0MsZvo5T3+dlP1f0j8RR8WEl/c8Q09ax5Hn5yD+SPkRmPd5ekYYtEmdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 04:55:11 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 04:55:10 +0000
Message-ID: <56a8ffbf-7e4a-46fd-9c7a-ad3c32c5eb0a@amd.com>
Date: Wed, 29 Oct 2025 10:25:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] amd-xgbe: add ethtool jumbo frame
 selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, maxime.chevallier@bootlin.com,
 Shyam-sundar.S-k@amd.com
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
 <20251028084923.1047010-4-Raju.Rangoju@amd.com>
 <20251028191416.78de3614@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20251028191416.78de3614@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce7716c-42aa-4e26-b1ea-08de16a75692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk9YQTArdnpsZUUzekUzZStRbnRnemlYd2txREhvNVU1TURtTVpabXhPMHFJ?=
 =?utf-8?B?S1grWUlKdldrUk9tZVhoSG9XYmJjVS85Vlg3b1NnZjBtMFY2SEtkY3hocVk4?=
 =?utf-8?B?L3I0SUpycllTZG5ZRUhtMUtuOWlXTE5takpZNlo3blpyN1Zpb052OU8yZ2lK?=
 =?utf-8?B?cjYrMUdBN2VFa0dHNFl6TllRZ2RzR0JUS3c3Z3NCdHpzOUlLWEZvMms5NFQy?=
 =?utf-8?B?MVhGVWJwdXp4WFZBdC96a0YvN0hMd2luWDF0SEtlMnpqeFB0RGJjQzRqdTY2?=
 =?utf-8?B?cEI5bW53VDYwR2lBRk8xMDkvaWdsTnJwa0hYaTZ1Njdrc3V1a3BncHVHRG9H?=
 =?utf-8?B?cGw1aWxaYUNzbytyRXlBSTFJbU95ZlMvOXhaSjB6WFlFMWlBblBMcHdnVXo3?=
 =?utf-8?B?dGw1b0gwWEZBSnFXNVFOcTVwcVhIZGQvY1labnd6N2EvT3dWRE1WTTFoY3Rs?=
 =?utf-8?B?cTVtZU0rUWk2UmNaajRveTFLaC92eTFGM1FJMkt3QW4wYlNnSVk1dXZDNHdv?=
 =?utf-8?B?cytFbjZlVUN0aGhEZFM4MFJYcmN2V0NKOVh0M00rWitRZ0FubHlEMzNzZUJN?=
 =?utf-8?B?R1BOMjlLaFk0ZUZXVXRmc25EQlNTKzFWYkt2YUhPcFhpTmhRcFNLeDVxQkY0?=
 =?utf-8?B?TldFWHlpQUFSZk5ONVFxd3FxVE1TYTk3bnYvTXpWRW5hbCtqQklGM1hoMzlI?=
 =?utf-8?B?dUdpR1h1MHRReHdnMnJza1pJSnA3NlNxdkVUVzN3SlBzTWk4Z3hEdjBFWDht?=
 =?utf-8?B?Vm8wNmMzS2VQK29FNW9NZ3h1bXUyejF2cHNiZ1BCOVp4Q2t2cTF2eXhsWHhs?=
 =?utf-8?B?Mk51K0kzakp4ckJ4cUJKS01zSU1NVlUvWEJ4Sm81UGZLR0Vlbzc4WTlIQ1Fa?=
 =?utf-8?B?NXp5b2lGUXQvMnIxWXNkVkE3WThsdnpkUjhuTVRGT3NWUFZxMThjRDhFSm01?=
 =?utf-8?B?REUvL1hBOUp1N0tqdS9FbW1PelcxbHFqU1F3V3dwNkN4QnJzWTlmVitFbHMz?=
 =?utf-8?B?SGlURUJ1REhDVHhuZ0JYMnZVajlSNjdQa0Q5WWQvQWI5SzBlM2VwVFR5U3hp?=
 =?utf-8?B?aTFaK2wvTUZXOTJXbU1PYnJmVzlSTFFSb1E3OXY1aU5Hd3hpNTZ0UWN1RFBU?=
 =?utf-8?B?MUw4cWkxdjBkVkNuS3JmMllyQmMvZCt0azY5cmpGeFZjVi9yM0NWRXFtUkkz?=
 =?utf-8?B?K2xRMUpQZkh0NVUxdXpVZzY4d3NsdUpoOVJpZlpjSStMZkpIWStBT1FUc3Jo?=
 =?utf-8?B?QVhMZ0FtdlkzRVVlSCtmUHNXbml2MHBGYnFYcjFhUTJZWHZXZEk4Z1lxYUNQ?=
 =?utf-8?B?KzBjWkdqdkZsNVhJTVMwQ2dDRW9kNFRxODB1VFFZbzdmQVlSMDRZWmppbFVG?=
 =?utf-8?B?VVdTZVFzWmFMbHd5dlRZU3BnWGhDa2cvbUVqOU9zOUhTNCtrTzJKZEhXZGJs?=
 =?utf-8?B?Z2tlSFptbU8zamd6NitpTXZiQ3hDaU9OUS9zMm9aRDZCbXZUa3pYcXRKajF3?=
 =?utf-8?B?SUpkZlhsdkFzTzNjV2lQdVlXTEExUVRrYk5HNXdOb2FzYWdjeDJHb1pKZ01m?=
 =?utf-8?B?N2k4YmdUK3Flelo5dTdQd3ZoY1c2Z0JKczJNUUVYdVNXeXY5VFhONk9CL1FS?=
 =?utf-8?B?eEh5SHlGbklJZ3ZLSjBuT1R5SkQ0U2E0NnhDZmlxckE2S1o2QlMzSmlKMUZq?=
 =?utf-8?B?SVEwako3NUU0cFJGbCsxS2tyM1JYcXVaSXpreXEralhSUnBjQy9hdzRZaGw0?=
 =?utf-8?B?OFdYczY4b290bXpVMGFpVnl0c0w0WWU0TmxpS0phQVY4TkdQU1dybDhZdmpm?=
 =?utf-8?B?M1VSTDFqTk15NzdlbjlSdVlkMXFoTUgvdjdBN1diM2M3QjFYYzk4aGg4UnhI?=
 =?utf-8?B?TzZNcjgwTWxJZXdDL2NpaW4yM0I2RUw3WHNsN09YOGNWY1NpaEdYZzR5RG9l?=
 =?utf-8?Q?uBXWdCxQhl9TODav2Wy+FQYDQjtD3Smz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzRyRERBTEdUelBGaXdVOVVnV3hBNnNTVk5jRU9RUWt5YzZLRm5OMjg4ejUr?=
 =?utf-8?B?NkdTdVc1MTVYSHNldFNPVDN1eWFkbHlFSlpXM0FkY2F1S0pUdjVSZmJqTXpN?=
 =?utf-8?B?SWdTT1JRaGMxYXFDVWk3a1FqVnBCTGhLeDdCc1c4aE1uVllma3FtNG5XanI5?=
 =?utf-8?B?VkFYYUtFZDcvc1JWT0ZVaVlLOVY2SDBuMWJTU3RqbWlMUEVxNGdDSGl3VG1a?=
 =?utf-8?B?RGN3TE1nVlZWWDB1WUd4Rkk4cU1NcnB1Y0U1azNhK2JZc1dkM0VpempqOVFD?=
 =?utf-8?B?dC9lUEpLdUdaWW52WDBWWElGUDcvc0NaWVZBRER2UGoxdVVmbnhPbDdETzJY?=
 =?utf-8?B?b1lSQ2MzandZeWxBS0JTaFFLc0hTWS9ILzRuTXAxM3NyZTBSSjlaMTlIa1Nj?=
 =?utf-8?B?VzNhZnphS3VKZ012azFicy9VZHIvd08vVFNoRmhzeHdxTlVuaEVCSDlrdDBB?=
 =?utf-8?B?cTdHejl4WTFENVJwdE9SazhVaVpQK0p3QWcySXlWbkV6RGZtZlI3cjdHUHk3?=
 =?utf-8?B?SzdjNXhRZkcxOVZDQmZFQjUrVWsrUDFhYmExWmZVNG1JNUMzcjd2UzNuS2ZP?=
 =?utf-8?B?TlFEQXVmTGp1UXczUWdCS2JJWWxyYzk2UDFnUUVReFpuTnpxU0ZBWnJsR25y?=
 =?utf-8?B?NE1YV0FEeE1iU0JzcjNPdTM1a1Z3V2l5NXM5TDJ1SitlUWQ1STMrTk9MRkVo?=
 =?utf-8?B?dml5alp1SDdDWHBGckNBNCtuWStLbDkvTG5vcnFSTEkvd0NscndpY3Qrek5i?=
 =?utf-8?B?L2hjY1pldGNDWTZNZFFBWkJrQzQ4WDNPRGVRWWw2ZDNKUURINzhnc2QxaERT?=
 =?utf-8?B?TUNsRmtsOWlCc1kyTTk1K3NEVzV5aVZJVFV5S0t4ZUdJUXBlUWg0SEUvUGZ5?=
 =?utf-8?B?K0kxZW5jT2tnekhrbStqYzdzZjVYdzNLNmd0Wi9ObVFwZjlwQjFSMDRGTGdI?=
 =?utf-8?B?SEg1M0M1L2k0cGJHSlRjSlBVcWlBMncxUkt4bVFtVGNMeUJ6ZUUzNXZvUnAy?=
 =?utf-8?B?aTlLdlBBQ3NuRG9KWVgvdTRYVVFxcjI5bVFqRC9DUjlmRFBzUkRPVUVtMVJB?=
 =?utf-8?B?S2V4bmYxRTFKdkhYSEhSZW1JNm9rUHlEZWVsQjhCMEVxQ1Izc2liLzVSdTVT?=
 =?utf-8?B?OHVwQStXREptZ3JtSTgwa2Z6TGZBaXJGZlpYYktZaExIVGJ0amc4SEdnaXVr?=
 =?utf-8?B?a0Y2aWJ0N2NlWkZ4b3JSakpjT05ZM3B1S3BFTUtYVlV4WjlEcllUZE5RMm1Q?=
 =?utf-8?B?TjhPRlFGWmU4QU9WbHk0cnFiOGNjOGhIdDZJeHIvMXY0MXhwRWEvNHh0N2Zh?=
 =?utf-8?B?RGNnTzhTOU9rdnllaFR4UEdXTFlMZkhHN25RTUVPVTJvK1krQUo3M0ROVUhF?=
 =?utf-8?B?VmhLNEh3L3dsWE4zMjdDeWgvZGhWTC9DZ2t5SEtHYnBqbkpIYlBoZnhEN2Fu?=
 =?utf-8?B?dVVHSlAwTlZwaUw2dkZlWkFTdVU1V0VkeUx4ZE5MN283Sy8zbkgxY1lhejNm?=
 =?utf-8?B?NnVqSzIvb2UvM1FBVlFsMWQ4RjYwR2Zxb25sVVg5akowN2VPcVpmNGVSRDU4?=
 =?utf-8?B?MURhOUhybDhlUmEyQktyQURaM2QwQnBmQ0tpSU1zdEs1YklTKy8yUzJhSENk?=
 =?utf-8?B?YmJQbDVxSzdrRUhlRVdmUUw3V0NkWUI2VmdSUkRoV2ZQL2NXZ3BMK211eGNE?=
 =?utf-8?B?ZlZhdFY2YXhzaUNrUDk5VmxmcTJ3V3NUMGpjaUNCMVMzQjF6RjBJL0o4eVlk?=
 =?utf-8?B?YVRPUVJUUU5LK003eEFrUG5qUkFHZW5Yd3hQUTZYN2VLU2l1SjkxWjl0ZVlh?=
 =?utf-8?B?cmFoS09HbTRuVlFjbWdqNXM5eXhYY0pmT3lLc1ZMaHpVV0U3eVRSNUVoZXQw?=
 =?utf-8?B?MDN1U0RjYVd3REEzT0UvWUhydUVibnVmaGhoODJYRFBOMFU3SUVON015ZEl4?=
 =?utf-8?B?VjFYcktIL2t1OVVMWXExd2hKNmZsYUQ0RGR3Q0J1eDR5dDh1RXJwY1J4ZzQ2?=
 =?utf-8?B?TUNlcDZ6RWhxVmVaZ2VOS2ZONzArQm0ySzh5OWRsSk1DNlJZQkZsMUJXcTM4?=
 =?utf-8?B?YjJhZ21CV0pkN0pDZDlHVm56Yi9GUko1SGRTNWt6dlJmUmlkNWlxYVVwWkh1?=
 =?utf-8?Q?xwvU5sGw4Xld9qXojAsEl90ut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce7716c-42aa-4e26-b1ea-08de16a75692
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:55:10.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WFvyezOZeJj8NfVGwXeJsHapz56QFdVQzA3SMD6KDYtCQyOxdrVt7YDPS6HBMnGwezMh53+ugEP8cITYBeRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446



On 10/29/2025 7:44 AM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 28 Oct 2025 14:19:23 +0530 Raju Rangoju wrote:
>>        skb = skb_unshare(skb, GFP_ATOMIC);
>>        if (!skb)
>> -             goto out;
>> +             goto out;;
> 
> double semicolon

Thanks Jakub, Please let me know if re-spinning the series is needed.

> --
> pw-bot: cr


