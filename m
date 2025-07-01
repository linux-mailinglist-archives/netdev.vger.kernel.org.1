Return-Path: <netdev+bounces-202759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DABAEEEA9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693061BC4B84
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1625B31D;
	Tue,  1 Jul 2025 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDujLxvz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238A2472AB
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351152; cv=fail; b=dixW7PIa8cdnFfWq0K6JfkMbcYmQ49dpCbTwIJrdtMwkzpNXseG50Nh7YRHau5e3RhsGad2pOAfk8cqiQ++uwBwNrAdtlI05B85XAJn2ljX4t7sDvKL6lj+z5OeLS3gI1AwLPlonKWD5dOhceSFuUnL6wnnOdkpqCQBCqzK/PiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351152; c=relaxed/simple;
	bh=tVRI/NRvRJen5ZEEnLzjrQrbNpHga8/yVNI/XWvt+P0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ottFh4ewIGr41cfAyZjrnXPT/cXv2XtR8zGvgHxHPx/7EbQvfGtDr+McPQk4tFJ/IjBtaZnH7eOw6HqAQh5VnVPkuqOl8a1KvZsT0psoNk+guEYRVed6Yf2zpUZu+cSnNH9bxnR4tOh2I0N7xiEu9v9bKbicQySon7gRlbSum+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDujLxvz; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPMvu3fho9Hw8VRoBD+jIDOt2tbgzXLVbQWEOMuP62zK/6OkJF9jbEn9fTfZmCgh3UGCPFMmpuUBbkr1Hhtjy52R7RIQhQwtEQ6w8wLskdZegnMrknfvw5OjWRxEpzNmAc/NtmX3hPs42OrKbipnzHNDGQ3yoJpIrFZ9nG7DGLmptDQ1mmhGoKHlLoEtiSTO7A//bsTVaY6D1pJ2e00f0t34OUZH8MZJF1RyS1HelPjIlv7ygBulevbK0qDYdPCaxWmoa+fOYDQ6B/bcuN+Mfklvyn/hHB64xbKdj09NSR155mV/plHgIpgR4k96m6T8kWCZxVpfMiJ930VT98cHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQtSmkX3QjkhfdzZ5mjPMMM5DPHJbT2n9L7RU8K1xZI=;
 b=S9pQ6xi9DvvEABcz9vTk8/tKy4AT0SKX26Y28iuUZ1O47QsWKDt0O7nGHrIVAJQ/m+iOe8wRqTzRRY+tfarmjtA3qgWqOY7tQ/GWgsQCaCBIh1VRtg6FVTmV8I/L11o8HclPsyZSUVCzgt8awYQ2TJAQLMB7krrmIrKK2h8iJyJ/xBDvCjyhqBHqmefBLpK/VnaJXM9ARQ5/tCh3b4PssvFz8NeVBc6t0hkgfFNh/W2eYo8/OfMbm87jllQGxa5Q3ojBo8FNFtvDRIKUNKywBYAlKJqBbOzxDP9u5enA2HML39JUUw4gF+Pm3Ko1f7ofcp7wlggOube+FLADN9scKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQtSmkX3QjkhfdzZ5mjPMMM5DPHJbT2n9L7RU8K1xZI=;
 b=tDujLxvzabFOkK6RsoCymfhWm3omUQ+H33CRcLbIDC7rIHKsf16O6zwprXJ4pnC8kyhu99vJGtKCkA48QIs///qoc/q9WaeRgAbABnPjanrdH+77KaEvHONr5xziDQKZptzv09Euivi617w1Z++eMNdYtOBJB6PSik6h1yrJMORMowdYjfbjVMh96X3ehxDAR6M0dp09ByQ18SUsFWtyngFZZm0HUbRGx5u6uKq0Ys7ClNtTnDekLfYB4+0km58wTtGs3Z279gRXuE7Hcoc/VCPldAZsv8miDgwQ4gi87IF+q5Ubi1M6WuAY2u5mELpu5vziR47jZ9WkjD+TZsGn3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 06:25:47 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 06:25:47 +0000
Message-ID: <14654215-aa09-48c5-a12d-9fa99bb9e2cc@nvidia.com>
Date: Tue, 1 Jul 2025 09:25:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] eth: mlx5: migrate to the *_rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
References: <20250630160953.1093267-1-kuba@kernel.org>
 <20250630160953.1093267-4-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250630160953.1093267-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 4496a5c9-955b-4bee-8ca4-08ddb8681dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjdnTENsNUNBUlUzd0R5cCt2ZWQxSVpHc1k4Z3dhREx3UTA1Rm5nM2dtNUhZ?=
 =?utf-8?B?Mkw5Y01aSGFEUy9LVXpyN1JKN2NZV2dOSnFXelBOcGV0cWZNV1VncWZTRW9L?=
 =?utf-8?B?ZDM1UXIxYWxnZUlrOS9KUXVqcDFDa0VHL05MeklKcFlVc210M01ZazRndXBQ?=
 =?utf-8?B?RHkrcmYraWRxUnQyRVNJSlVkemlrU2c5WjNqNHRNK2UvQXhXY0NHaUh1NnlS?=
 =?utf-8?B?aVMxeENHZ1M5ZE5CMVQ5aHd5bFZVTFpWaC9oZEl3U1B6NTF6RTV6d1JZc09P?=
 =?utf-8?B?ci9tTGVXTTBKcnc2NFlOdk5xVjJLaGlKT01QeVVjWE5wMDF1a2VUUjNVT1Rx?=
 =?utf-8?B?ZGljZHlqanB4RXBhd3RQRjNhTFRUSTJCczdvcis4N0M0QVpiYUxEdEpOK2t4?=
 =?utf-8?B?Q1ZMQms4ODNyNko2T2QvOWs4K1UwdURRRFFacGpHVmpqWXFoTXU4TndtOVh1?=
 =?utf-8?B?dFJHNkQrTVlBUWdEemdlMm5JTTJ4aTBxRDBLMStFTy9tV1U3ZWpzOXl0MEFU?=
 =?utf-8?B?a3pKZGp3Y05helJDVVVJaSsyUm8wZzJxd0JnMVNGZ3pkTGlmSzJZSmZuTTY0?=
 =?utf-8?B?QkxQRlQrazRZbzRDdEVMSmNOdlZhNnV0YytmNXZxR3NDVmdVdDFDa0s3K1RP?=
 =?utf-8?B?c3U2TVhmZStGNXlicTNyOGRXN2o5K1JMTWlNbUVHbDM3NkRPcWE1MksyaWNv?=
 =?utf-8?B?RU1LbUZ2OHdHaHFBR21Rd29DU2hNMFNNWTY5Q2d6aWJwV1EwQkpDUk9QQmRN?=
 =?utf-8?B?QlJVV3dIK1ByUGs1OG16a29PT3hFcDh4aGRtQUZ6V2RidHVxMjdIVTNvNzFH?=
 =?utf-8?B?bzEyaWV4c09TeTBSSHJkNnpmWHd3UTJuZDg4U05iSUlWYmF0RDlUUHg3STF1?=
 =?utf-8?B?Tng4VW14MHJKOFVoaXZncjJUL0JjUXdkNW9BSFNVTEpqNUVLYXNYMVdoQnF0?=
 =?utf-8?B?Skh3VDZqYU1SQWpZRy9TTDNJb2hiSEFaS3JvNnFpUERVcGhPZjRDVTYyVkRI?=
 =?utf-8?B?ckZQRkdZcGFNSFJONFE2L3FLWjl6Q0d4ZGF4UDkyeUxhbXpETW0yUkg0U0ZF?=
 =?utf-8?B?azZiMi9tMk9CUVduYzYrOEN4YWE5ckZhL0RKVFZ2eStkV1hXdFVsSlRlbXNP?=
 =?utf-8?B?V2hFbDlBRUh6dlYrVEZWSGI4Z1JZb0xaaUsxenNjdGdYVFFWREN4T2psWTdx?=
 =?utf-8?B?WFpqVUJjeTc3L004Qkg3N2R1Qm51SkxFV1ErYWlCbGxGK0J1QWdydFZHdTJv?=
 =?utf-8?B?THp6U0d1cFVRb0RtUDk5OHdMZ3VoZ3ZPNkIrSDdKSlhEWUNnbEFJY2tCdzN4?=
 =?utf-8?B?NlZ6K1hTdjVLaFJuOUQreDN6VzZ5NFdEeDUwMWZrcjVnWWVsQktqQXcvNDRr?=
 =?utf-8?B?MDJjc1M4cGpGUGI3MGExWlR2N2w1VTlUUUlzRnQ0cXJ3dGRJSDEwSHRmWkpI?=
 =?utf-8?B?MUFDQkFOUkkwMDJDSmQrQkZCeUJUTHlKcDFPVTEzbTZTRXVkRk4vTUFtZFA5?=
 =?utf-8?B?OWRwUE5ERDRlVGVCWFhPbHNDRTdyV21WYTFKVVpDc29vNG5uQ3JpN1VkSEQz?=
 =?utf-8?B?VllBQjVIekpaUFcyV3kwSlRwcGxxTjk1ZDBTNHVVSVZYM2dyWGlwTFBRWU9z?=
 =?utf-8?B?dC9lcWNhb25WWStnODlSUGJpWEF4cmVxdWtVY3BQVTBmQm5xZUR5cUVSdEp2?=
 =?utf-8?B?QzByemFKTnhoNjZqb2paL0FxMThBMUt4WGR6NVYzTmdtK292SllydUJJYmxz?=
 =?utf-8?B?SkxMZ0p3TkttTkYzbEpQM0hwc2d6RmJ5ZUxhQUtsbURPcDJnbUVKTURsT2J2?=
 =?utf-8?B?dTd1WCtsc2VhendSaWVFUGVCV3JJRnQ3K0hxY3pzemdpZzJ5eWllb1FkNFZT?=
 =?utf-8?B?MWtMRldOb3Y3b1F3ODN3b0tsWnFvaWFvVUlUc1RncG56TjRySDFNSGluTUk3?=
 =?utf-8?Q?rM01VehZooY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2JaWWZZam4xaExkRnRZWEYrNU1sS2Jwb3BOcElmZ1F6RXRlcGtwOFFKNXpa?=
 =?utf-8?B?NWRKaUlHQjhWTU9KdGh5bW90MFJyWmptSzIrU20yY1J1b2FZejE1aXhqeE1X?=
 =?utf-8?B?Y0V5Ky9ad0dtb2tZemZkUWo5TC9oTjdmOGg2YTRBdnpDU3Y2YUIwR01FRDVt?=
 =?utf-8?B?ME9NUXB4NVpTRm9pcXJKVDR6dDBEdlNwSnVJQUFLTXVkQm9wTVNEYXlMWW5X?=
 =?utf-8?B?emhJWFFCR2Uya0NPM25XeXJzRUJJSE1zVTZCL0F2Rk9EMFFLdXZiZmNTQzQ3?=
 =?utf-8?B?WHpyR05aNm11V1pTRDc3OXA4NHRIekQ2ZzdhaWNVRUZRcm1mdmNCZEdhVkkv?=
 =?utf-8?B?cndlWjBFcjNPTVVjWFZUSzV1RGVweVVoaFVTZmN1eHBPakQ0bUY0MVdNZFg1?=
 =?utf-8?B?a2h0NUpDT08wbXpvcUFUbGRDSEpFNVRrcFJYdWE0K0svT1lqd3BSdGJJYnJI?=
 =?utf-8?B?TmdXdzIxcVZqQUtNNkJUcmQvZ2xkb3RzS3BPRkZLRURwOFppNXZlQlVLTDh0?=
 =?utf-8?B?bUNhMzBxVFVFUWJFTmlqY2ZRNU8wYnhvMC9zTkJhRWJaUUMzYWtJWnR3RzRk?=
 =?utf-8?B?ZGx5dlBNcDB6a2VZSGRuNThRTkF6SEVncm52OVM5d1VpRUtvcVF6SEJodzZh?=
 =?utf-8?B?SHJ0a3cvV0J0T3BObzE0ZnpCelVEb3Bhc2xzMFNJcHVvaGRCdWZZeklqUHJ2?=
 =?utf-8?B?WGFtSWhCcEpoaDZJRWNGY1lZeTVpRVMzT2N3R1NBTUFKWXFNMUVlQkhqc09v?=
 =?utf-8?B?TVlKaXUvYUlqNFo4aHQ0VWZpN2t6NnlFMFNianF4M2YvK2RBZWxCWFAvZEJR?=
 =?utf-8?B?Smp0eHIyM0FTeWZQUEVvSGZtV1JqU0t0bEg4bytXQnV1Z2xqT0tEbmRoVFlr?=
 =?utf-8?B?ZGlnQmtaOWNVd21pRDlnbVBlQVdmNVdvdlhLbjZoK0w5d0RjYkNMMjl3cGVh?=
 =?utf-8?B?Q2hIeTFuZS9VSUwwTmhnM25NdDFXMDRhbEVhQXVCOUxQanNWUDI3YUJ3S3Mv?=
 =?utf-8?B?VFp6OHpKQytlNXdIaEU1dmcwb1kwbzhQdFMyNnc1VUxxRFBCTHNyOG5zNmxx?=
 =?utf-8?B?Sm9VYm9QQ01FOGhpOCtKcC94OTUrdFFoVml5RnE5b01WUjVZTnBQUzNxcWZj?=
 =?utf-8?B?b1AxSk5MSGxIR2pOMnoxeWRzbWxvU25xRlBXaTZ4bkY4ZnNwUE9EaFBwVEhN?=
 =?utf-8?B?MFh0L21neXk0aXIvR2YvcS9YU3lPeC82ZWFkT3p6NUhVYitQZTREeTMyY1NH?=
 =?utf-8?B?bnFDVWtWUnJFTXZvUXR6a1ZKcEMzMXJyK0JjU1VsYzVjVmQ0Y25FYXllQlVp?=
 =?utf-8?B?RDZsaGhmc3hpVVE0WVF0ZW0rN2NvN24zbUdxeE9aYWx1SHptM0RJM2R3dDk2?=
 =?utf-8?B?NjhUNjJCMCt3U1BvRkNwSElnRm1RK0owWGVBcnZkR1I1VlpVWG4wY2xYQStI?=
 =?utf-8?B?U1djQlpNZmlLUGY0WldhdEEzbld0V0hmV2VMSlRmeFNUemNra3ZGZW9SbWsr?=
 =?utf-8?B?dENQeE90b1pwWEhUVXpLN2l1SVV4ak9wU2hHelZuN1FoT3QvdTcvelU0bVpS?=
 =?utf-8?B?V3o1eW9YNVQwSDNDZjEvajFyTDNMNlpQS3hZNUtrNHhKa2ZMTDdxWnp6WUVl?=
 =?utf-8?B?NVB4TlJENFFkQUFIRzFDdGNBc2FYVUxyemdDaFRDUGFHamluUzJrN0hNanBv?=
 =?utf-8?B?Z1Vtc1BBK3diRUZ2TldhWXluWnhBVHY3cmlJckcvMW1leDczem0vMjlFckNw?=
 =?utf-8?B?T1VrTGxmQk5kQTVZUmNpRE9OMFYxeG43b0ZhY29XelFhb3g5WGF3ZEs3MWpl?=
 =?utf-8?B?L3NZQUpVVU1nSll0emFOWFNIQW5OTW01OW5jVHlKWHQ0Y3QrV1hGSCtwQlhj?=
 =?utf-8?B?N1N1RnNJU1V0QzNTR3VmcEErTysxcEtFa28vWTRFUmdqNkFNWlRudWxWWFlW?=
 =?utf-8?B?L0VZMUpteTk2M29uSFlDTWJaYkxGWUhIbGFjaDhuMVVrQ3BoVGtVZHFYeDhw?=
 =?utf-8?B?dGtmeWFWN0krVTE5VXFZSzkrc1UyTklOYklwNE5UV0NkTGxadUZQNE5uc1pO?=
 =?utf-8?B?ZStXSE5GdU01VC9IaGVuc2VxOUdhQ2tocHJqV3RDSjJpd2dmUzdvcW9WWmFT?=
 =?utf-8?Q?kdh1/rgwA8ILEpdh18JgVnyKI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4496a5c9-955b-4bee-8ca4-08ddb8681dda
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:25:47.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7TWNuFFNukMNY8wuA3X2zNX7VoXT8pweSoZEK6JGiO8goZcmbSIEovVnOdbBU3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

On 30/06/2025 19:09, Jakub Kicinski wrote:
> Convert mlx5 to dedicated RXFH ops. This is a fairly shallow
> conversion, TBH, most of the driver code stays as is, but we
> let the core allocate the context ID for the driver.
> 
> Tested with drivers/net/hw/rss_ctx.py on MCX6.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> +static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
> +				  const struct ethtool_rxfh_param *rxfh)
>  {
> -	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
> -	struct mlx5e_priv *priv = netdev_priv(dev);
> -	u32 *rss_context = &rxfh->rss_context;
>  	u8 hfunc = rxfh->hfunc;

This variable is kinda redundant now.

>  	unsigned int count;
> -	int err;
> -
> -	mutex_lock(&priv->state_lock);
>  
>  	count = priv->channels.params.num_channels;
>  
> +static int mlx5e_create_rxfh_context(struct net_device *dev,
> +				     struct ethtool_rxfh_context *ctx,
> +				     const struct ethtool_rxfh_param *rxfh,
> +				     struct netlink_ext_ack *extack)
> +{
> +	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	u8 hfunc = rxfh->hfunc;
> +	int err;
> +
> +	mutex_lock(&priv->state_lock);
> +
> +	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
> +	if (err)
> +		goto unlock;
> +
> +	err = mlx5e_rx_res_rss_init(priv->rx_res, rxfh->rss_context,
> +				    priv->channels.params.num_channels);
> +	if (err)
> +		goto unlock;
> +
> +	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, rxfh->rss_context,
> +					rxfh->indir, rxfh->key,
> +					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
> +					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
> +	if (err)
> +		goto unlock;
> +
> +	mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rxfh->rss_context,
> +				  ethtool_rxfh_context_indir(ctx),
> +				  ethtool_rxfh_context_key(ctx),
> +				  &ctx->hfunc, &symmetric);

We don't expect it to fail so no return value check here, but maybe a
WARN_ON_ONCE() should be added?

> +	if (symmetric)
> +		ctx->input_xfrm = RXH_XFRM_SYM_OR_XOR;
> +
> +unlock:
> +	mutex_unlock(&priv->state_lock);
> +	return err;
> +}

Thanks Jakub!
Reviewed-by: Gal Pressman <gal@nvidia.com>

