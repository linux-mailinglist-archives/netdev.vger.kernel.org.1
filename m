Return-Path: <netdev+bounces-274020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAeOLj3xzGknYAYAu9opvQ
	(envelope-from <netdev+bounces-274020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:19:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9337861A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F38530038FF
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824C3E1211;
	Wed,  1 Apr 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FIOZcc3T"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86C3E1203;
	Wed,  1 Apr 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038590; cv=fail; b=Hp87lhViLK3dzoJchqw63/8BbVWQT8lwe9To0egtnPhwhJpY/Ytd2Phl1H8/orIYFUhJHlxZ7EinmYCJFkRpudSkJoHrUp+hxDqJv3CZVR5V61EzqOtJyj2l0+A0h0rSysEHDXL1SMg5JI6VzGVrPT84mHmtrVwVLxthj+Dba2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038590; c=relaxed/simple;
	bh=F6mlMLIDwwGX7XVPurwhSuWM4CiUOgftkDXwfGpCiQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OAx3T1CUEHgY/sYc3EbsavELjQ9bfCXOEenPg3xAVikkprDqzgvDcMfLOMEoHvLAmKx1oQEseq1CR5U45ps5CkoeXM/WHL4RMIx9MFcT7oPpRUEs/EZQ+cKqB+x7NCUD+zK+WnZS6t68BW67l2tXiwL+EjmaCv1samHGg/Cl+kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FIOZcc3T; arc=fail smtp.client-ip=52.101.57.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA94n+jLv6yAUY5ro3NBBhZ49eyTYHNaiTfYapxgpuG+9ZAuLkKGAjNcYMQZe5UV7aZNTKKdtw1kQ5nY7Z1nHLE/h0f5kHCMa7XQlNPSxJnU0PbrBklOtsgslS9SJh/FvHGUN+5YdnkoGTx05qFbqODEPTe1TFO34+AeapfSJtTOIbOdSUQnfa1U60/7e5crfBu9wEF7ezqzocwKNOW2HERCOcB4cTVQHZHzS7fAHo56eVPP5r9KcSKspXJYHOIRIgAB9F14ut0ZALpVXz23XczJ4tWrrtCk4J5kTvjGKSRfQx7XL27UQN4npDfkDjjWeMz+OZI3bPncvqXjz31SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvvlWybacpyjOwlAdsB+4aojSlYMeHhSMHAVx0jQjHE=;
 b=DIQ/ovOXTusulEpMlXAVnRKwnevZBAzJMHngo/csVPbUy1eMgNUVG0FtC+Xcae652NMaZuLaOeqpzVyxxnVYxrEOXu/9wH5j4BmZKyq36LrU+yzQSPeQx5bcDsnwWCCWZwxFISMXLgP6ymWeVwU42hBaLKQ3vkD8UeNcrFKtxQjujqUu1Dn2dn7jAmNx7FGPPPWovZyicmZ3yRTfepmxd7UCa1a+gXFZtiEiU9/kBB+fjF2lnch6pi1cTPk7yueoAE1pmXNr4Ea7OxBkwIl0IunYEWWeLOha+4mEXaESU9UxennNvTtTc1PmhUiV61CXCFfCNfSpMHf28H82rsw20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvvlWybacpyjOwlAdsB+4aojSlYMeHhSMHAVx0jQjHE=;
 b=FIOZcc3TNM1sioirk/7oyqSqVNUC/MT+wS6gFoW2kwBgrCnLEaqA7Yp4bMywXsQlG1V6nk8XcIfGXVPwrOWXW71z9K5IQiN3IJkOKX4mVBDVohNq53VrlJAWooiGVt8rEfJePXgA0gNBwZnycpjMZhm+jXW0g73xNo127expCM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS4PR12MB9705.namprd12.prod.outlook.com (2603:10b6:8:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 10:16:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 10:16:23 +0000
Message-ID: <f0f5a510-4073-444c-9f05-7153d0b2087b@amd.com>
Date: Wed, 1 Apr 2026 11:16:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 05/11] sfc: create type2 cxl memdev
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
 <69ccaa8448da1_1b0cc61009c@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69ccaa8448da1_1b0cc61009c@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS4PR12MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d395f82-a613-4eed-17da-08de8fd7ba25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PzA96w4R+0Rc8mfhUkQw0ebwfjLu5syUbgABNeMHVjVo1pEriKaNADbfzifth/5L5LzB1i29619J0nm5Yv2YEGOMohagWnpmgxtxWQht2slUmMrT1tUqMJlk8fPkT/1bBiAH+8I4Y9CXdX07HibK7xY0ul7MVhGKHkzT2XnB2x56J2no4Qs33GokbhaKxtEPyVjHzquLSpYXLO51TUOeO04HOGlNOxRp29NUeTGiBdsfwLOt0+njOtporNvAQLagM0vT1qFZPPoQb3oHGPbJV2rS6roPuwCjoBdjmEOL1IEDk9IRaqVa/i78QbBg/hnW0LsQAVlNClyGFziucRQ7pk/uMGzc5fH7FXXQh8adGA3bsnF2N9IhqckBkvLz/fXK4FeM62yDp4UJROHWYv1rBwertGhOhITa4V2ZiyVCsPQJ6m8SlLYYt/ActQ/K0Pfg7ZAROtQ32mdf80vg8INzfXGbAT40FTBD0HiFAyvAdOvhADNCN//dZD8cSxaaUx2Z4tIkCjsGcv6o1RC89FIfHumvts5vXRpoLGTH3xj0ZXxCQdS7YL/+43qDEIgk2tzQsOmqqFPu0eGiyANLhqEUtvaGp6hbeCxLHMy4CV9O4oN28Hp/apGrp4+TkRjDOma2tHzvbI+kky0sJo2tKfiNrM4/INd5mQ46o2f9hn4DPWX8+YMJIJKjfBT9WVgDMDtnJMf9YZSyvIt51MCPmQRLgv/9Pjz4WYSt3uTEiF8bb4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZpRDlzY05GeFNjaUl5U1ZGZ3pUSGpLUHgwUGZ1cTFXUThXVkZPa3l2Z05v?=
 =?utf-8?B?NWdyNHRlYTdacmFWTmVISVFDOHBlVmNZSmZpdkVNSDNWb2tZRXV1T0dZZ0ov?=
 =?utf-8?B?dGcwVHhXVGhVWGdhQXBPbngwS0F2bVRSTEtHa0NFNEJxT0ROeTNLaTc2aTBk?=
 =?utf-8?B?ai92TmFybzhCL2Jlc2RERk9sTXZiZGp0TFB4SzF2b0Z2aFhvNjBYU1dDV1pa?=
 =?utf-8?B?QU5KQm9Yc1hRdC9DTlpCSW9HcHA1c2l1SEV5OEdvUEZjZW9YYUNkTjVTR0li?=
 =?utf-8?B?MFc5Y3NVa09RYUpMUFNJc3dGMGhWbEZvdTRjN1daNWxwdnVheXVRdGx6OHVS?=
 =?utf-8?B?WFhmcmhZNTZoKzBibGpDWXE4MytLTm1DUnI2UWxWdFJtSVBrNzlRWmpRdUJw?=
 =?utf-8?B?RlNuR3pHZENvUVNaTjRVbmw5WGpzb1RLZkxQSWhCeFljaUE1aTJIT3ZtM3Bp?=
 =?utf-8?B?dmFEb2hLSnFaZi8vSUMwa2FwL082eUhBZVlEZU55Y2VYV1BkNXFVcDFlOEVS?=
 =?utf-8?B?UWNHQmN0S1VYYyswTkFrY0tWWC9teGZiOFd3OWZlcmUwWXlDM2RhMzBWMVVC?=
 =?utf-8?B?YktMZVo2bkt5eE5zWGl2NmQ3dExWWjhYcnN4U1RTdW9JZExXNTRSRWVXZmlv?=
 =?utf-8?B?c2ZWeTJIVmRCS1lPZnRVcTZSbkcwVjRmZ2lXSEI2MklTWTFDcmhNSmJNOSt6?=
 =?utf-8?B?aGpENFR1TDdSS0t4SnZsYXVXd0RLcVFnUDB6SkEyTkkrbTVQUFBHcTZtLzdS?=
 =?utf-8?B?K21xRWJFMWxEdXAxdmY5ZUNuM0hXelZLdTVuUUpHNWl2MGNNUUpGMHBMUWt3?=
 =?utf-8?B?RHo5NjYzd1pUTHdHZG5LK1FyYy8rbWozQklML01pM09WSnYxY2FPR0UzU0lN?=
 =?utf-8?B?aXF4cllVQnpIdU91T0g1ZlFYc1BnWVZMZzBwa0RQZ0ptejAxbEt4aFNKZmlx?=
 =?utf-8?B?cWM3R04zWnBSRjdWcHh4U0xESEJqRUdjZllMSVRLenl2bFNhQjJFRk5Fb1Zj?=
 =?utf-8?B?UTduRlF5K2xOM0lERUQ0UCt3dmdNNXV0ZVpkV2dFTFlheWI1cDdHekpRV0R1?=
 =?utf-8?B?VzQ1VXc0d3JvVXBlL1RCWHVNY282L2x6SWUzSUs2UVpHOUtOMzJaRHI3eFFo?=
 =?utf-8?B?aGlpWTJwWWRmQ0U2WkwvUis2a0hiNERhenhXeTdEUTZIZzkrVmJsdnFtMGM0?=
 =?utf-8?B?N1d2UVMrV29PR2NTZkI3ai9hUkwxa0YvdGRmbEtTY1lVdW4xZmJKdFV1Nk9o?=
 =?utf-8?B?WkJ0TVQ3Q3NDNnZTd3BuSmxnTTAxOTc1blFhSFhHa1BiM0tRUG1rQ3hQKzVJ?=
 =?utf-8?B?R2VLRllDQWUyMUsxSnJ0dHU3SHdrWlhXS2xJOFkrMGFJRzdkallaL3h5dzhu?=
 =?utf-8?B?YmIxR0lWRWtMKzJpRGt2YkxYVk96eWZoZG81U2pDRmFuZTdyYU04Rnl1TzE2?=
 =?utf-8?B?c0ViZDA4MUxGaGRGVCtSNjZwTDFrV1Ntb3BsZGtsbHBsZnlVbTN3c1d3OVg0?=
 =?utf-8?B?QytSQVN1RURHaDd3M3RmZFRiWjhQejUrRkJ6aFFQQ2F6b1oxSXlnZXl0Y08w?=
 =?utf-8?B?cUIrUHZPOEtQcjI4NFNMVERFbmhjS093OVFaenptcnRtVEdZQWZaZlF3R0I0?=
 =?utf-8?B?dHM0MW9UTUdQc2xFY0dRckpheG4razZ0TWFUckdiZFdIKzVod3VRdkk5UnF2?=
 =?utf-8?B?NlJEYjNwY3hnUFNNZWtwbHJhRk1tUU16S0dXLzloVk1EVmtKS3I3a2p5V1Iy?=
 =?utf-8?B?SjFRUGNOTTMxbTFTQ3M5UDhJUll6VlNQaFY1UVB0clBQd2hFRmxVOXVKKzhR?=
 =?utf-8?B?SU9TLzdxOFdiSXBzem9YS3pPbEkzemdIMUozaFBRTGRiNWYzQVNxOFMzWjRM?=
 =?utf-8?B?ZHdGek45MEZ0ZXMyQ1A2amNJeCtaUDcyWFlkMm1CTnRxS0xWMGxvK0Q3RUQy?=
 =?utf-8?B?QVZYQmJWNWU0aHkweFM4Nm9PeGpHeDJjdXByZEE1YUJNWEtnQ2VBWHc5bkww?=
 =?utf-8?B?dFFzV3h4OG9nZFlSTUE5RzAySFhLR3ZmWnFLSkVoV1Zpa1V3MUYrTGdZS1o4?=
 =?utf-8?B?Z1ZWWitKT1RkdFl5ekRiMnQzc1Ztdk5FVzZmTGFUR2RHQVYvSTE5SmVKZkRQ?=
 =?utf-8?B?MEpGM08rclFkTHpDS2tkdTdpbURWWWNsZmJEQSs2d0JnZSt5bjM4K1NHbWVO?=
 =?utf-8?B?alREMHA2TnBvbW5aNG5Zc1lJSzQxbnNuSmNGRkxGNElHZWsrVmVCcWtHODlh?=
 =?utf-8?B?T25WeGU0eGthaFpGMCtCblN0UkgvYm8zM1hRZEpnK1BWajRJZlNqd1pYUmIv?=
 =?utf-8?B?WWNFTUw0NGkwZldmVmRrWDdFVCtEM0ZSL3VmaVptbGhxVXJ5UldNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d395f82-a613-4eed-17da-08de8fd7ba25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:16:23.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txVt6toBskEzN4rNeA1TCE0DCWwujnqCsxnanZ8O/4LdcfbkUXClNme4iWSkfWOah7d3KF7Ff50kO/NHEKXdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274020-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 36F9337861A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/26 06:17, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl API for creating a cxl memory device using the type2
>> cxl_dev_state struct.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 6619084a77d8..63e6f277ae9f 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -75,6 +75,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return -ENODEV;
>>   	}
>>   
>> +	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
> Did this forget about:
>
> 29317f8dc6ed cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation
>
> ?


I did not. The idea behind attach does not make sense for sfc, so I do 
not use that option. I did discuss this with you at LPC and based on 
previous comments which had not replies (case 1 in here):


https://lore.kernel.org/linux-cxl/836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com/


 From our conversation at LPC, there is no reason for a CXL device 
connected to the CXL Root Bridge not having its memdev properly 
initialized. I did ask you specifically about this, and you mentioned 
links on CXL switches not ready, but as I said then and repeat now, this 
is not what sfc driver expects at all. Only a port from a CXL Root 
Bridge makes sense due to the latencies involved with more complex CXL 
topologies.


So, from that list I wrote in that old thread where I tried to summarize 
the problems and clarify the confusion behind different concerns, the 
only issue is someone removing cxl_acpi. I do not think that should be 
possible at all, so something should be added for other modules 
depending on it avoiding its removal. I would say any CXL port created 
is (in X86) dependent on cxl_acpi, so something at port creation 
invoking a exported cxl_acpi function could do it, like a cxl_acpi_users 
counter. This could also help for visibility to user space about its usage.


Therefore, I do not like the changes you propose here. But, if this 
proposal is the only way this can go through in time for 7.1, I will 
resign myself to it. It is not clear I'll be working on CXL in the near 
future, so any progress even without my agreement is better than nothing.


> tl;dr: see the replacement patch below for this and the next several
> patches. Untested! I will write a cxl_test for it tomorrow. For now,
> take it as a "something like this".
>
> ---
> ...longer story.
>
> The difference between general memory expansion and other CXL memory is
> that the driver has a use case for the memory. For general memory
> expansion the memdev *is* the use case. A NULL attach parameter means
> there is value in continuing if the memdev is not attached to the CXL
> domain or not mapped in any region.
>
> A non-NULL @attach addresses all the caller's requirements at attach
> time. It also arranges by default to trigger ->remove() if anything in
> the CXL topology is disturbed while the region is in use. Anything from
> hotplug, to modprobe -r cxl_acpi, or cxl disable-port.
>
> For efx a finer grained failure mode can be built on top of this by
> adding a remove action that something like efx_tx_may_pio() could use to
> dynamically fallback away from CXL if something goes wrong.
>
> Until then though the CXL subsystem, because CXL allows for dynamic
> memory reassignment, goes to great lengths to ensure that it can all be
> dynamically torn down. So consumers that register relative to a cxl_port
> topology need to be prepared for that port hierarchy to be torn down and
> evacuate their usage of any regions.
>
> The rest of the patches in this set are racy because none of the results
> are stable (locks dropped on return) and any teardown is silent (no
> notification of teardown).
>
> All of this wants to stay local to the cxl_core and should not be
> anything that accelerator drivers need to worry about. Accelerator
> drivers just register, get a physical address range to map, and off they
> go.
>
> The meat of this patch is cxl_memdev_attach_region(). The rest of is
> protection against userspace messing up the region configuration.
>
> ---
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> index 961639cef692..bfd8633a1e01 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.h
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -24,10 +24,7 @@ struct efx_probe_data;
>   struct efx_cxl {
>   	struct cxl_dev_state cxlds;
>   	struct cxl_memdev *cxlmd;
> -	struct cxl_root_decoder *cxlrd;
> -	struct cxl_port *endpoint;
> -	struct cxl_endpoint_decoder *cxled;
> -	struct cxl_region *efx_region;
> +	struct cxl_attach_region attach;
>   	void __iomem *ctpio_cxl;
>   };
>   
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 10a9b8fa2f6b..1698d15ec1ca 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -153,6 +153,22 @@ struct cxl_memdev_attach {
>   	int (*probe)(struct cxl_memdev *cxlmd);
>   };
>   
> +/**
> + * struct cxl_attach_region - coordinate mapping a region at memdev registration
> + * @attach: common core attachment descriptor
> + * @region: physical address range of the region
> + *
> + * For the common simple case of a CXL device with private (non-general purpose
> + * / "accelerator") memory, enumerate firmware instantiated region, or
> + * instantiate a region for the device's capacity. Destroy the region on detach.
> + */
> +struct cxl_attach_region {
> +	struct cxl_memdev_attach attach;
> +	struct range region;
> +};
> +
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3edb5703d6de..5d60e6c0a89e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -406,6 +406,40 @@ static int __commit(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +/*
> + * When a region's memdevs specify an @attach method the attach provider is
> + * responsible for dispositioning the region for both probe and userspace
> + * management
> + */
> +static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		if (cxlmd->attach)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int check_region_mutable(struct cxl_region *cxlr)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return rc;
> +
> +	if (cxl_region_has_memdev_attach(cxlr))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
>   static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t len)
>   {
> @@ -418,6 +452,10 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   	if (rc)
>   		return rc;
>   
> +	rc = check_region_mutable(cxlr);
> +	if (rc)
> +		return rc;
> +
>   	if (commit) {
>   		rc = __commit(cxlr);
>   		if (rc)
> @@ -2768,17 +2806,23 @@ static ssize_t delete_region_store(struct device *dev,
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>   	struct cxl_port *port = to_cxl_port(dev->parent);
> -	struct cxl_region *cxlr;
> +	int rc;
>   
> -	cxlr = cxl_find_region_by_name(cxlrd, buf);
> +	struct cxl_region *cxlr __free(put_cxl_region) =
> +		cxl_find_region_by_name(cxlrd, buf);
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
>   
> +	rc = check_region_mutable(cxlr);
> +	if (rc)
> +		return rc;
> +
>   	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	put_device(&cxlr->dev);
>   
>   	return len;
>   }
> +
> +
>   DEVICE_ATTR_WO(delete_region);
>   
>   static void cxl_pmem_region_release(struct device *dev)
> @@ -4223,6 +4267,88 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +static int first_mapped_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.region)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * As this is running in endpoint port remove context it does not race cxl_root
> + * destruction since port topologies are always removed depth first.
> + */
> +static void cxl_endpoint_region_autoremove(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
> +/*
> + * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> + * simple case of single mapped decoder per memdev.
> + */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		return -ENXIO;
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	/*
> +	 * TODO auto-instantiate a region, for now assume this will find an
> +	 * auto-region
> +	 */
> +	struct device *dev __free(put_device) =
> +		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +
> +	if (!dev) {
> +		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> +			dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      cxl_endpoint_region_autoremove, cxlr);
> +	if (rc)
> +		return rc;
> +
> +	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"region %s not committed for memdev %s\n",
> +			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	attach->region = (struct range) {
> +		.start = cxlr->params.res->start,
> +		.end = cxlr->params.res->end,
> +	};
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
> +
>   static int cxl_region_probe(struct device *dev)
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -4254,6 +4380,9 @@ static int cxl_region_probe(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> +	if (cxl_region_has_memdev_attach(cxlr))
> +		return 0;
> +
>   	switch (cxlr->mode) {
>   	case CXL_PARTMODE_PMEM:
>   		rc = devm_cxl_region_edac_register(cxlr);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 6619084a77d8..a388f3120dd4 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -75,6 +75,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>   		return -ENODEV;
>   	}
>   
> +	cxl->attach = (struct cxl_attach_region) {
> +		.attach = {
> +			.probe = cxl_memdev_attach_region,
> +		},
> +	};
> +	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, &cxl->attach.attach);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(cxl->attach.region.start,
> +				 range_len(&cxl->attach.region));
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +		return -ENOMEM;
> +	}
> +
> +
>   	probe_data->cxl = cxl;
>   
>   	return 0;
> @@ -82,6 +101,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>   
>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>   {
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
>   }
>   
>   MODULE_IMPORT_NS("CXL");

