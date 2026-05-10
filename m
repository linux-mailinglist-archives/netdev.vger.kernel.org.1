Return-Path: <netdev+bounces-286288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEd0OnyBAGo2JgEAu9opvQ
	(envelope-from <netdev+bounces-286288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:00:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7645043A4
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF15C3002F5F
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E23806CD;
	Sun, 10 May 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6H95FUB"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE6371D13;
	Sun, 10 May 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416735; cv=fail; b=KOCsiJabhNVzRZaL8TtF+hTv5ouXBeJSXFZU6AO0agmkVwMmaBZn3QwBLMq3RJkOvcXBW4ZJDLJbr/mRb5MaW8oX0RGYX2aUR5PIm3/sVgq0rnN5SYCv+Koi75urEJpNaReIPSFws2B0i0U0Kfiij5DnkFttZ9WqfUJz75hPkWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416735; c=relaxed/simple;
	bh=Hz3k5dvZE/7VIouVH12ai1LX2k20vAJaiq7APzJYZIA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZWUyjIY1VJEm/2rSHM0iCOdC/pmIOla/O4WLdx+IeVnhQn7ANaZS355AYSifysb710f3H5KQB+9BYzrIIN4Kge3xhXsEhRFBHnDv6EH8921sMusab+UdfALcLADDEPkBh1IimpfIdrpq4e9l/Ww3elVlmAhXa4okMZsKM6dr5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6H95FUB; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqg0oYCIAn38ib6iymO71Ppcz+eC49hLCCmbYNj83N/iez4m0V9+0vEYhN11FfbOmX0LA4nxObbTuGtRTfinACOFvk25v2rNBcP868aygBMC9a89WqU6yXdyaxjFhSsCJyyzZcDSuGAMcjGq9kcxthqDgtQ0twNeliMfzF1R8J82wqWqYo8csPucWCTbWR1yoeEbqIIbu7PsTb62eYOjJrkN4YgifG94US6VDokzGsydU8zLRS0t/Rzd5mRdgjuHA0n37F1HasYB8CXYKc4V1SMBwxbkSAea7+fRBQnnw5Taq4zsBpdroPjUqGRdtwiQXPdL2t3LejmDGMF2V1HU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lLQai0Mo5Pb4SQ663PZhi+oPHAhv7Ptwa/u9ESlCww=;
 b=q8lxby4rgyKWaTGBIaGDRuzfzX3hCROy0cEnV6acEVrkRJxJHioVUUTfDORQOPZ1+q7gC3UllVj4oC8rjxnCcxTp5u4z5/kmXtcVSRB8AW0eNlIH0X9JKT3+qWJncqVB+cNKkQMObnbkx53teSjiQSVzhSdTUXBKdPvoJvzd9xmrbUiFl0YADBk/hg8BBzIpqtLuIm99elYF00/75LKnyMDRVVKtX7zSrj9KomTISoLP0h8jcQmxzQDbyXnMBvV1R1WqWdsQA3OI63uGdJeBNRX43Ypflf8Y7FYMmIcyI7W9XzuaoucN6T+faTi26cIaAfqEcH+NH8Yhhti1DVDsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lLQai0Mo5Pb4SQ663PZhi+oPHAhv7Ptwa/u9ESlCww=;
 b=H6H95FUB0dSfCqRFQdmIJqqu95hJmdZ8CuIkA9s72jTdBTfTm2XwnfXA3XBCfgZlHRZDctjpBSDIoZHxgg7inDLBS5fsLuIYgoHDIGnVJNZz7IHjl48rfB2FlJqxr2d7bus2dAbwypV76wVD7j9RUJTa+aY62dmRVLyOMbxzUBSNpKdHKllEeaB0K5VsfAQ+BG8fUaM3FQy6APqj/lB/C2Vw0e5gWNFtEk14rQVEc2umeRk47WGjt6KQ4OCtxCoFjw+kiGmzHcBXi0vmmrS8hK5CPpk616KcJJdsNtm9YmI8ngtg/JEACB1aWaMyq2I3Orye3X/p457HA0epzFEg1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 10 May
 2026 12:38:51 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 12:38:51 +0000
Message-ID: <677976cf-d438-4997-bfc6-2691e5579d2c@nvidia.com>
Date: Sun, 10 May 2026 15:38:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming
 broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length
 adjustment with GSO_PARTIAL")
From: Gal Pressman <gal@nvidia.com>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <980382a2-3b8c-4da1-ac9b-efd8c0d2c1be@nvidia.com>
 <F03BE787-07D1-440C-81FD-F7B4D5F1E0C6@linux.dev>
 <9f601313-cade-4bd8-8e38-3777139de46d@nvidia.com>
Content-Language: en-US
In-Reply-To: <9f601313-cade-4bd8-8e38-3777139de46d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 908fb4a5-bb6f-48c1-5ef3-08deae9116b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	jPCmFqMegsXBLxXXy/lzoRIZoX5Kr94oM8ubWD3lQmg9lzneIbe2XV47m0uwFFHmycUMIaOyEkqi2yVjwCFMe2xFMXgBRUYZcj5BChydlVW9bVV8wr11vCct84FWxu54EMlwaTc8ouCkxhbx3zO09eutgewl1+iuxDIOyBmKYtjD8UzTFyaM69qWIzvyQIcUK2X6KRrOw5qazMVF/yg25MgrtIEy/ohsYTu+fJxKgcXn6cBJHr6HjGh9HnUroKzgBWZcOw+7rIc4SgW9SbpdD+sWa9kC6YswesYLE4BaoQyVUtGbxb11bz0ZY9vE0efDdg7rrsfLxAbqn/uIMNgfMkG75GLS0rKv6HhyZQT4sUhRdXS4N2Wyo1K5231Zv0CEbGDtlRUyptlWBRwWuMTQXoLNiCwHRp/AIx2Ldq2S3goE2XOkhmJGYha+gFz5zEousZHxryzkCk73DsNhK/Ex+K8zSfpGomgAhqC6rrVDhQt7fmOqwpcTPkT29GtASLErkzmK7z352h3nQbnb7dDsZYaUjgt21BoKx1+1zwzm4IfIuRse0HFUEltZwhNOxAr/3UdkBFREn7rnZ6M2jXQn+32jKmGJ21kY/OX3+9xw/eqAHBQUsJfdXAgJoYhgffXAL+NDlo9K06TbPnPUihwfJRvgqqjqLH3K38kFoWaUp3xZY8V1zampmOuoJZrvo6ymVlvLhb53FCvCD2g4eh1vHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRIVzJob1A0cjRvMjB1amJoVTROK050WTBER2FYUTU5b1I5Rk9aOWxMK1R6?=
 =?utf-8?B?aU1MWHQyci9IK2pWTGt5Y2NiMGlFbERDT2FmZFhHYWEwYjJGcjE4MDF2MTda?=
 =?utf-8?B?bjI4TVNrVmVaQ2RmNldiN1hJQVl1OEFKdkdidU9DcDJxQ2d3RTh3TzVCdUJO?=
 =?utf-8?B?OXppVjhMa0J6TjZGNy9RUGpDSk5nUzJIQzJicS9CbkQ2enhCeEVRYjlDWk05?=
 =?utf-8?B?UjY2NVZFT09VK2xVWGUrRC84bUdtb2doSDlraXZpMTFYRzZ0ZGUxOUFvZkRp?=
 =?utf-8?B?MHFzYjltM0pFWGJzeGZ3dnJWSUxUN1FUdXd5TjBreXpseUNLZFRKVDMvaUFW?=
 =?utf-8?B?MzFGOTUrTzdOTWV0OGY3K0ZqWEdQU1AxdVRWdUpydnptV1ZIcmNCQWVUd2xE?=
 =?utf-8?B?NXF0VWgzUzE5K2xzWnhvaGllQlNpaDR2cklhb1lSZlJWZkVnV21LV015VE5G?=
 =?utf-8?B?SUhHb2wrQWdOTXFEcFlLMldxVUhIZ2JHbmo4dzlSNUVWbWgzMTBKSnRZc0hJ?=
 =?utf-8?B?SkFseHRUd3VLRWwwb05FTUFLYXVqR0lBQ3BRRFBZZjNuU0wwVlhSSll1Zk84?=
 =?utf-8?B?OUw1Tzh3cURDZFMwU1ZBZGdGWTRmc1RXOXpudUd6eG1oeW5mMHExTERYcjQy?=
 =?utf-8?B?aDUxdngwTEFud2lqVnBGTFJ3dmVmZUk0OG5sRWtmdGNSc0dDdVFma0dBc1dq?=
 =?utf-8?B?VFBJQk9hZWNJRDJQb0pXSlE2bUtURmNON0podWsrTVVqdG5SNFE1MndCTHFV?=
 =?utf-8?B?TUpXeUg2UGEyRHh2VzNvWnNIV0RLR1daZ2tLZ2NyNjV0ZGFwK2tJN2d1Z2NR?=
 =?utf-8?B?cmhEcm9xQWoyVTZ6dWRYeFptZ2htbWpYdW0xRU96UDNGWmpXMTNZS2lBTnZC?=
 =?utf-8?B?Y1FONnN2QTN3TnNuZHVUaUpQR1JYTjE1NzBNQ2RSL0J1RW5mUk9ubGlNajNo?=
 =?utf-8?B?NEx1Z3ZUN2hyanZsVnVScHJXcGVhT2NQMkNCQnp0UWZBL0YxT0FZb1dzZlVV?=
 =?utf-8?B?Nmsybms5TjgzZVp0aVdBK3lmNTZDNHJ1dG1lZmI0ejRJOXp2S1B0MnpzM1hR?=
 =?utf-8?B?MWJ0dFBiYktZL2E3V25CcGErODlpWm9oS2FKOWdFdDRZQ2NxODJXRE5MbzRp?=
 =?utf-8?B?RFNvTUhyMzUrSlJxZ3B2NnZWaGdjUE81bjd5bmozNWhoblJJSDErR2VDWFVu?=
 =?utf-8?B?VURIcHNUNjRrQk95Y3NzUVJWa05iNE9yOU5XTlcvRm1vNFFML29iQnd2dlY4?=
 =?utf-8?B?STRtUkFuOUZWSEdzdlpqQmlkWTd1N3ZidlczaUFWY3djUGhoTFI4SmhpRHNU?=
 =?utf-8?B?VTVxTjRabVk0MUpxVFh5Tm1RSDJlUi9Tc0IycWpwMHdMSXREUmhQcDFXWjgr?=
 =?utf-8?B?L0ZTRnIycGVSWDhRYmYzcUZlN3ZMeks5dllhNFc2OHdLRXhrTEJxTzRTMHpi?=
 =?utf-8?B?NUd2U2FlSW83SVMxMmcweVF2YUQ2dU1kUW5YaVBVSWd4a00rc0RQaDBVSXNH?=
 =?utf-8?B?dkx2bFVGTU9iZTRnQjBxSUtnWk5VUmMyVHhxUzVBc001cmdCUENJOVd2dWlm?=
 =?utf-8?B?d3lSSi9kbHNhQjhkRFc1MWVraWZWSXJGQzBXSFpIRmUwWFkvYjY3dDRnbERN?=
 =?utf-8?B?S0VpREM1M3FMKzRXVTNoOWFJa2JjVmFOR1NKY2JpRlRUdXU1ZzBNYUM4MnJv?=
 =?utf-8?B?WUdXM3NXRTJSd29nakJPN051TnM4VFhjUE9wai9UbVU5SllXMU9SRWtKZWR1?=
 =?utf-8?B?aldNSzZTRjBQeTZ5SmRqNmIyUFREcXIwMC9DWEF4SGdyRFA2RU90a3V2dk5W?=
 =?utf-8?B?dFIzSzdIQUpPRnpMNE1Ja1hLMnJUYWJweEZheG83Q2lMcXIyOWptOTZSZjM0?=
 =?utf-8?B?ZlVHbUI5ZUVzM1FYMGl3R0UwT0s4T2h1SjBDblowNysxZkFsRFg4bGtFZm5W?=
 =?utf-8?B?MGJudnluMXpnNXIxeHJtSzl6NW8rQTFzS0J4RnBQcFNrS3JkdzNGSmF0VzJ5?=
 =?utf-8?B?VWcwMnZxbEJ0ZXR6U09YcXlmelk3ekppdkJKQ2F4TXJMU0ZJTkVBeFVaZjlQ?=
 =?utf-8?B?TFJUWFBna1VGWXF6c2ZRbEdxTnVyWmJ5c2JzQndtRXZFSkFDWElUOHhMb1ZL?=
 =?utf-8?B?TlhUQmR1NzdKWDBLQU1kMjV0enVhWGVISVE2NkFKa0ovOCtXczN1WjJPYVJw?=
 =?utf-8?B?ck9ycHFpVkU0N3VSNmZ6Z3p0U285NW9saW9wbktoVUMyVDRzaDdUQVRZdVNF?=
 =?utf-8?B?dVgwMGdzQVAyQS9SYmlCVFVibko2MFNBZU80K2Z2V2FBZ0lSK2xhRXNzWjM5?=
 =?utf-8?Q?2HA/sNchqKQI1KGv/U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908fb4a5-bb6f-48c1-5ef3-08deae9116b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 12:38:50.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgGqTQic8OJrzxYpH7ESjO5Wr0OLsvF8k4utpPqo5SkzjCr87HXVIHOnK1BC4BgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Rspamd-Queue-Id: 0D7645043A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.34 / 15.00];
	URIBL_BLACK(7.50)[lizardbyte.dev:url];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[Nvidia.com:s=selector2];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.921];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lizardbyte.dev:url,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: add header
X-Spam: Yes

On 06/05/2026 17:20, Gal Pressman wrote:
> On 06/05/2026 10:49, Matthew Schwartz wrote:
>>
>>
>>> On May 5, 2026, at 8:05 AM, Gal Pressman <gal@nvidia.com> wrote:
>>>
>>> ﻿On 27/04/2026 21:26, Matthew Schwartz wrote:
>>>>> On 4/27/26 11:09 AM, Gal Pressman wrote:
>>>>> Hello Matthew,
>>>>>
>>>>> On 27/04/2026 2:20, Matthew Schwartz wrote:
>>>>>> Hello,
>>>>>>
>>>>>> When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.
>>>>>>
>>>>>> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.
>>>>>>
>>>>>> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.
>>>>>>
>>>>>> Please let me know if there's any additional info I can provide.
>>>>>>
>>>>>> Thanks,
>>>>>> Matt
>>>>>>
>>>>>> #regzbot introduced: 5b4015ad833c
>>>>>
>>>>> Thank you for the report and the bisect!
>>>>>
>>>>> I will take a look and try to figure out what's wrong (though I don't
>>>>> have real hardware to test on).
>>>>> Is the userspace app open source? can I see its code and try to run it
>>>>> myself?
>>>>
>>>> Thanks for the reply. The code for Sunshine is available here: https://github.com/LizardByte/Sunshine and the code for Moonlight is here: https://github.com/moonlight-stream/moonlight-qt.
>>>>
>>>> I have been using the Arch Linux Sunshine package which I installed by following the Linux instructions here: https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2getting__started.html, but there are also binaries for other distros or it's buildable from source. For Moonlight, I have been using the Flatpak distributed on Flathub because the client device runs an atomic rootfs, but you can also use any other device that Moonlight supports.
>>>>
>>>>>
>>>>> I will be OOO for the rest of the week, hope to have some meaningful
>>>>> reply by the end of next week.
>>>>
>>>
>>> I think I see the issue, do you mind testing the following diff?
>>
>> Sorry for the delay. I applied this diff and I’m able to stream from my host to clients again without any issues.
>>
>> If you send this version upstream, feel free to add my Tested-by to it.
> 
> Thanks for verifying!
> 
> I will finalize this and submit a proper patch soon.

Hey Matthew,

I made a small change to the patch, can you please verify it still fixes
the issue?

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a0813d425b71..71df45f9488a 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		       seg->data_len);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);

-	uh->len = newlen;
+	uh->len = skb_is_gso(seg) ? msslen : newlen;
 	uh->check = check;

 	if (seg->ip_summed == CHECKSUM_PARTIAL)

