Return-Path: <netdev+bounces-291289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHImNc0lFGrfKAcAu9opvQ
	(envelope-from <netdev+bounces-291289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B67A5C9479
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C4630158AF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDD34F24A;
	Mon, 25 May 2026 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3j31XeD"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC33537ED;
	Mon, 25 May 2026 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705283; cv=fail; b=aPb22SMKnDMkJgDfFCoGCD2JsDdsF3yxXDmMHfn16gdZpVTPvW2K0ilKQcn06q92RnQZvAYZSoHJOcGz6daCyBWbA1ly/eE49cilbWlqKljxbXYDetRefWKtgx5neHWULfONDdEoLoM7HkmERBTup+e8g3UnCQUyLslgfWyKCKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705283; c=relaxed/simple;
	bh=oeVfMPXRcKZkAl2A2oz0YPdfyZloDJ/tQlM0V4MGqFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oeSWn/9YNgJiNHIcu2nId7Ygd4+Z64afaLkm0q6R3X0Z/XgMzHcb+2A+DpurvzgtdeM5Wx3uYU/bFW4qjBxOkzWnOiMAwedhMXGF161tnEOLdNH8LVOCQyL8g7gNguzuoQvmsWp2HACOL63OtcpONR4+FVhL+MnIYHdhkCJaz88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3j31XeD; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fF0HPtkwk41qcC2c7oiysVi4YrZ/JWUID6dk9bAxU+VuhiG8MD1BF0r9XkqPJXIlmEm4zneZjiXMYWpFZlUGjMHPwbeBvXgWH6VgrT3uCN+ax2mlMwjBuG3O1AvhbG3gfusIG6daneccVgu/3ZdE8q/dWgBMhfxu/HULm/i3azgSJuaJwrla7jdUEb08cexEczgQD9IqkAV/Vek9w0VfSQh2/R3etFxQ9n18Af8CoAKs2BcEYT6gxkGEE6fghCS5gV4ElYm3qXvH2I0R30Q+0rHnRuMptIxOd/jbSndo7FXcyRzLn8yWpjsgeV+MNRyqI3ZxpAqAvS8twYi4y2al1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+gIyZbVy1XbiAnqsCyo9dx6ILxQ4OxOw5w4D7s/WRA=;
 b=lwKFVJlIdUBhtj6NmvpcLn0/+EODxgsQZLdot8wh1d0MnmX/iAukiPF7qQnSjyuxPQfn2/LDRsB/W3wJcTufVcezQ6vlJJn1XJgpAD2TLrsebDLlbHgcxy9AEsQM8BsacK/wsg0EH4d1HJH8+k6tE4rrIJnAkdTfpY6bD1WI7oPTvtA7JkCJ1S7TiVWLuNl9IN0fy6XGBPo4eS3MdzLg805DkCn0PkV6QsHn4pn7EPt9SDBw4hDAaS181t/4f2FrDanUmucCNZIIKHXNEEp8NDET1XfzpuZyrrZiX4kaN8RtPy8tpw450xR2kFdVDiP0fV4F28FbxsEm4GoC1OohqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+gIyZbVy1XbiAnqsCyo9dx6ILxQ4OxOw5w4D7s/WRA=;
 b=q3j31XeDu1sShy4eEbbLxmOs0jGqGN3K3SW9kqQ13uAh4yBBcCeC+wVT5W/j1V8ct83oo1+WL/Rp7xOdp4rvEJTabADSBpPvhEJjpPi8dTQCo/A7HJbnqcZfBYvg9nZn/qAbnBbbgIqCgWPpbpWDZXMCHNT3hKZki4tsyqUIEdVkdUw7xR7K0q9bKvLMInA3rqSDyYPNvAtXPEOaV0Fdo8DzUmnc2n2OyCceWUkk3UagOOJafooyQrvq66NF1OaNJXsCfghbCVzinx+/o3HJrHl+dvxarv2VNaUzjUy8Ao1N3xz7s2usHGv11v74b+2qponlTpcz81QuTYlXU8LJXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 10:34:37 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 10:34:36 +0000
Message-ID: <433cd37c-bdf8-4739-a85d-7f47e36a9d0d@nvidia.com>
Date: Mon, 25 May 2026 13:34:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: HWS: Reject unsupported remove-header
 action
To: Yevgeny Kliteynik <kliteyn@nvidia.com>,
 Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
 <20260509132508.GR15617@horms.kernel.org>
 <744adbc1-ba3d-47c6-9129-439a59636f14@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <744adbc1-ba3d-47c6-9129-439a59636f14@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: e797ae03-5350-4c52-48b3-08deba4937a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	T0lmGBZ23WGsGZ7hVPz/o/5O7aPDbGlBBJnK1KkjcOuzRDdFJ7mDghFkMKY75bKTAftWSnRwBICthRPXbYpDO7JH4oBQJoxEyrqSCGgt2E/WrhE9BDehaYqxHfRdkfQ8cqOAIkOnVUp7Y18hXf8q07EhpURVMmPp48KvYDQFonpkoYFY170t86+fD+T3KHef/FleEvyxOeOKcXqZDTkZGBhjjovLBLydEX7pBBByqj4/b772ncs5S2tXOV5rJsJWkN0ee7uOmBZgkkipluti+NXsDfg+AmvB18854Sr+pj8H7tmsZUFtkWD7UUH/XFkw3sN0UVggm4eYN914NYRTp1IDp94d0NsoZcvI+KmLYuLHQR09GV3+P7dxMrbByDBKgVUdrmD7jfhEM7nPBF0TVmIVvEz27RsM+B0WnDHYWe9jddSERr0c4Ru9RA+V+m/H2bo7AS0A8Rp+NzqnbeqIM3A3muFg66R6GTujodVZspY8Bwb9Oh7r7PXFQT3JZfOV/WG+wAiKAFWcJPqkYjxXb5PUqtbKJLGK41NNMQ4zvHwJXfiZ04T3uP+3IWT0MbIDrJy0W4IivQRqRcjyjsyPIfR+PZzZ0lfmxHKfm9NzWnKVJ2UnydkUKOc8UukoecqLdx3ShdQsLZ1TwXGR5sX1SU+fYdlI+iB9wNhb5AiN+2br7Oy1EzaqTLNS0mtw5SuL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q213LzBnZzJqYTdSeGxLamJjU2ppekQzSk82dnpndFdPWis3Z0lMZ3Y0OHB0?=
 =?utf-8?B?azVNVkgrU3FXMjdLb3pEbUpSVEhrR2VOSE5velRxWDd1YjNUV0hua2V5UnIw?=
 =?utf-8?B?NFVLWngwaFJZNFRZai8vZjJGOHJPemJaNzJ6dGVRUFdKVkNFVHFQR2kreGNX?=
 =?utf-8?B?b2pXaWQ0Sm9zMk1TNUdEeUlQWERzK3dXQlAzcnVWQTliQ0hMQUJaYUoxeUV5?=
 =?utf-8?B?YVlhUFFoaWE5YWI5TFlHUkRkTFZ2dk50dGdXajljWDBxMHNMWFhESWY2ZHR5?=
 =?utf-8?B?ZUVzRTF0eWJuQmNkVjdGMXdEZnpINlZrR2V5RFhnVVhOSlhvK2N2NXord1pL?=
 =?utf-8?B?b1ZzY0ZHK0tzbURjTEN6S2FPMnVUYUduQjFhbTlyb05kRjI2ajhNa3V2VU9K?=
 =?utf-8?B?dE1WeDhsRWZUOTZHTTdSRlFJK0JuWUU3UldMY3E3ZHBSQmMwbEtDeHlLd3d2?=
 =?utf-8?B?TmdaVEhpOWxYalE3ZG9FQlp5cURkS0ZaVVJKeFExUEMvRTdSRzNHSnRvRlVp?=
 =?utf-8?B?eFFFNHAxQytWb3Fya2FhS2Q2VTN6NFhIQURGRkp1RTZqajlvZXQwNHMraG5U?=
 =?utf-8?B?ZTBNMm96UjBscmhlU0dMRkQzWDJOTlAyMVZPRWRWWllhMi9uV1FNbFdrT3RB?=
 =?utf-8?B?ZGw4RWZ1SmlNZkFkbEZHTkR4a3BQTHIwYlRUcGg4c2QrYlJwUTZEYm0xWllW?=
 =?utf-8?B?M3NXTnd3YlMyZXpBbEpXZ1NYZDJZWmNJaE1KNUFrYWFNQ2FsSitIbWx3Mlgx?=
 =?utf-8?B?aGRmeUVKam12K29GY0ZlSHZqVVJIbWc0NE1OMzArN1dIMTZwcWN5ZDU5T2Ev?=
 =?utf-8?B?aXVSZjIyQ1ZEeUozZGxwMmc5aUw2YzgyS01zRG9BY3RzZGlmMEMxd09ocnl0?=
 =?utf-8?B?SU44aldJL3d4dGRLbmtsN2dTMXJTMDU4RSs2VEx0RWd3VFNETTBQQ1BlU2c5?=
 =?utf-8?B?K1ZNdlMxN2xCQ2M4SDNUa1c1ZWxQcFBNejdNS3Q3WTBKVkJ4UWNUZm9lRFBm?=
 =?utf-8?B?cUdNYWFzclo3UjBEYUt5ZHRoUmd4T3ZPQ1lHcThnZTBoZGdPZ1BBR3NvSHM1?=
 =?utf-8?B?M0h1VTdnMFhxRU43bWJlOVgvWVdJMUhyeTNFbUZxZEVBaHlDZkpscENpS0VK?=
 =?utf-8?B?ZzRpU2FRUHgyS0hVTGVCOTZQcm0rVVU0cVNsQzZyb1RqenVZWU1aYit1ektD?=
 =?utf-8?B?K0d3L1lNMHlJdWU1ZHc0ZDhmaWNCM0FjZVYvMmZaTEVaTWFnZWFmSWpPZHY5?=
 =?utf-8?B?bEpZT2FKdFNlNEhyWm1YRTg0NEYycVF6Q2YzZjRvR0NsWm5pcXY5S2wvYlNC?=
 =?utf-8?B?MHpRUjFoNVNhNC9ITU9ZY3JXTjFaeGdWYWkzcFVKamFEWmFRU2txZUJKTnBi?=
 =?utf-8?B?c2h5R1JlVzRHR1RaVXhLajlMR1p4RG5wc1UzdEFBeEUzT0lpWkpvQkVRQ1RV?=
 =?utf-8?B?QVpwOUJjZHNTNDkvcmhYSWJmclZnWDMrNlB2S0ViSm5XbFdUUEgzbGRQa2Q4?=
 =?utf-8?B?bHJSb2FYNG9IL2Nva3FlWkxDN01mdXhwM2IzdlV4YUxMTElFMkptVlNXQlZE?=
 =?utf-8?B?N0xWcEMwVnNvcjRFdi82b3FSVjc5SUt1QnBvUFRjWHJnQUZyQlVhemZBamdm?=
 =?utf-8?B?bWdLS0FCQXpzZWNNV2trYU9HclFXOG9pSFJKVndZL3Evc2Vhd3Q3M1IrcVJh?=
 =?utf-8?B?emZYMzJKUEZZYkpGZWkwbHZPajEvK3N4VG9RREtSdHNiN1VocXYvOXdIczJR?=
 =?utf-8?B?NWdURnJsZnAyd2UyUXVrenZSNGhjcWxaTFNKZ2JKak9ybzlxYmMzenJTNFVH?=
 =?utf-8?B?VzJUMUxWUDZ6VFMvdXNHV1NMZUZhU0VhWEZ5Rmljc2RiZGV4Um5nVDlMSUQw?=
 =?utf-8?B?RnA2OU1vL0tzalB0TENkWkMwTjgwWkhxdXl5TmQ3RkJFTDBVbHZxWFRna0FW?=
 =?utf-8?B?aVR3OTk4bWlVcjl0aXhncTF4VksvVkJNVmtwb3UrYkZVQWpVY3I0aFRveG1y?=
 =?utf-8?B?R2R5TWhjZHl0UUpjR0IrSXdSVVoxTUt6UmZGb05HWDEzNWpneWxsdk0xQktw?=
 =?utf-8?B?TThkSWNwNWszNnkrTEEyaFlQQzFLVEEyZm9HdGlPVlcxR1duRG5hbzhvdmlx?=
 =?utf-8?B?Z09raVV3eVVIRisvUTBFdGNNWXRjK21aOVk2MTFzQWl2N0NRdU1oa3NUKzVr?=
 =?utf-8?B?T1d5M3BMTEZSQVcwWkw3djY1T1dHUGVMNnRHRGdNc2xHdVd1bGEyTEM4cEJC?=
 =?utf-8?B?aUY3SmZ0bm1xT2ZRZ0xzcFpZbjF4b04vUkxGYmNrN3Y3SENzeHRSZWhQQmlX?=
 =?utf-8?Q?MaO0lXJ8W5Iug8c4Jx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e797ae03-5350-4c52-48b3-08deba4937a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 10:34:36.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nklg0OGR3g3aQeRfk7Lt275584P5Ycqj8NY+nWFKZwQXCYFV9Xn3asTt06afPuBYBrQ6eKvPsd61LfyJKrjE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291289-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B67A5C9479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 10/05/2026 11:10, Yevgeny Kliteynik wrote:
> On 09-May-26 16:25, Simon Horman wrote:
>> On Wed, May 06, 2026 at 01:00:31AM +0100, Prathamesh Deshpande wrote:
>>> mlx5_cmd_hws_packet_reformat_alloc() handles
>>> MLX5_REFORMAT_TYPE_REMOVE_HDR by looking up a matching HWS remove-header
>>> action.
>>>
>>> If mlx5_fs_get_action_remove_header_vlan() returns NULL, the code only
>>> logs an error and continues. The function then returns success with a 
>>> NULL
>>> HWS action stored in the packet-reformat object.
>>>
>>> Return an error when no matching remove-header action is available.
>>>
>>> Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API 
>>> function")
>>> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> 
> 

I guess this is still pending my ack after Yevgeny's review?

Here:
Acked-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

