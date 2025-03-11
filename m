Return-Path: <netdev+bounces-173895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA683A5C293
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3213AE469
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1A1B6CF1;
	Tue, 11 Mar 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRimmDZC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C15680;
	Tue, 11 Mar 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699571; cv=fail; b=pmxKauyBw1Im7bTxd6U+SZ+0l3+1rnwx+dZQRfiYwQS9aaQ9+a2zA/AiYj4PVtvtBAnH7r+fxx10x9N8afCWElzIiHkdCmNVkuWzkfuVKVM95RCzm8CBxRfR9v5tIZU2RsMTPttfVduJz4/X6RwES8rVwvMmfKhM+CSTd4wvhQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699571; c=relaxed/simple;
	bh=YDxDvpXQcpO07SLwfRB2btFyo5xlUneFty/leQxvHXM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYnO/f2WvXBuqbxc1GvgbVAYxjWpmIvxAbyWXjJ4ICldOdfi6YNZrxX0g+TIOyWo6JOZT8C6GCRtphZ9pyu4lLG234UWZURlcyc6RnFdmSIh1wTTAsL8pN0TE0xDR+THMV8IiS6lTy0I7Ui37eWF1ZXpv2fIDsggDAnkAMhkXPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRimmDZC; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuMqPNWlclU3KpYqQ26YI6buxG7AQpmWvxxvJQpNWlBGPKORp6nQ3/+xDrVyl/S8Q9TodAz05bfMNRnBirj715KGNgd3WQDxFTHLmHWCIqldO/XEzM/dePZq5Sh//5UQsTo1t48MyvA7rruzbBhAo6YV4FJMOA/0TWf/VhN+nf1r6sVsQILLAH9rrtxTwXewR+WlsGjFrS7GI5jD+TPiCA+oqlgBezADp+MHvgMuySktTQwynnLulJH9wyCv6DEMs69Z2UK0FE6kxQARApc9N5Gn7+KsTJ9etnxZIbsZexNgTeo5AmdZmUMcykDIbKvVDR+CdUB1mFXWc6jsst3eZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ3sxiaX/9U227oPXYMwNsZ7HiuBH9lzrVdXjDpD9Ak=;
 b=qXTBYtI1/6HjvZM4vvccfU9hiT8Xb4It3dHDLdwSBb/a84MBhOemVHtEO77e3gI0nBnQtz0VI7qF9mVisxwaMLAmEBHmGgLkvPllkpPhAM69Yxf52cNXSTB+gCeSEtUlvf1uz8urgpAS7f1svRKUctN7UPjV6AuUf6whnpJ/kKJUpRGCyHRh947JyZ73Cr8+khi6RyILchm+2McBsesV51e02KGgMG+VE42Q3Q+LiJ3dVA9wcjl+e9HNsAHRn6ywqbSf2QJaVAcJmwnNJG+ydQBnMmQQAbXLWj3Op1oOb7x3DB+5tsmtALucgABPqNhtOqqCVOEeSFNPvFhqJsye2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ3sxiaX/9U227oPXYMwNsZ7HiuBH9lzrVdXjDpD9Ak=;
 b=kRimmDZCGTalrMBoVNQMNGolc43DRcuVexL9zetFwUST0SsoMSvayo2MmDZY7Xreml0rJ82ePT7OqNi8hTURu6UiG2umD9aKKwnrJcV1tXzFjVKQZLXdS5SQ9XVB2mgrNK3z1V0RH2xJrDpqVCgBy2+SU5ynnqGNgYw7G8Awstw7Fmzl0BpKnxM7+fGMUmb3mO6UXMon/bCpdsgUb/y8RK1VKOoX78RPK3GIGNSSQHsae5FRUbCMpBNbe0H/HaGRd5kk1+YHMOhBtkKWt8UBV2AUwopIp3dO7GKF5a09CDj9WPKT3IJ344OFad+gHE8vxFgBX7iVUO4LW4Yp0/h43A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:26:05 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 13:26:04 +0000
Message-ID: <4fe02d97-2c38-4d40-b17d-5f8174d2f7cc@nvidia.com>
Date: Tue, 11 Mar 2025 13:25:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 0/3] net: stmmac: approach 2 to solve EEE
 LPI reset issues
From: Jon Hunter <jonathanh@nvidia.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thierry Reding <treding@nvidia.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
 <29bc7abd-b5cc-4359-8aa6-dbf66e8b70e4@nvidia.com>
 <Z8sn7b_ra_QnWUjw@shell.armlinux.org.uk>
 <673e453b-798f-4fc1-8ed1-3cf597e926b4@nvidia.com>
Content-Language: en-US
In-Reply-To: <673e453b-798f-4fc1-8ed1-3cf597e926b4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: fffeb3ca-8700-4cb1-392f-08dd60a045fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkxGTFFTQlk0RHRFUTlySVpxSHRtdDFDcU5FQjVnWDY4cmFocGdQZU1XVFU3?=
 =?utf-8?B?WG5mRFp4UDJ3K1ZPcmFDMzR6VzFxTUozRXF5Q3psMVdmVmFENkFFa0x2Nkp4?=
 =?utf-8?B?bERKZk9hYll5aExtTmtDTWkxT0NTQWVtR1A4blA5YTNESk1tNjJGY1lOaTdw?=
 =?utf-8?B?Z2k4MVhJd09tTnY3c2RDck5XNnBTUjR2MDhia1JqNmpqMnQ4bHYrSlU1SjJl?=
 =?utf-8?B?YitOVHRnVVNzQjlwSmt1Q1BaNG5mc2V1azFDSDdVN3JCOGNSTHhOaHU4QVNi?=
 =?utf-8?B?bGlORkR0Y1NFQnZuM1VEenFsRWZ3dzE4VjRTc1JrcjZXQWxRWGpQQUJRNklz?=
 =?utf-8?B?Q0VwN1dzemRIY1czTTd4R0lmYXcvWHI4bmVRTlJMQVhsZGt0Wm83N0dVRXZs?=
 =?utf-8?B?aGtYTDYxTHNVd29MZjJrS003T3RFSlk3S2lyT1lYQ2FuZVBFM21wdHJMUXRm?=
 =?utf-8?B?VytOdmRrOUhydGJUeDZYWVJSL3laRlF5SW9ManZ2M2t2L0xkT3oxaWpwWXNQ?=
 =?utf-8?B?RXk4MDkvWDRpTkVWZU82NzJtci9sK3g1LzJDempzZGtCZ0IvalFEYVFjTjVp?=
 =?utf-8?B?RDNYdzhQVEVYYjg1SDBSMmtONGFtZmhLczVCNEJ1UmN0NTlCZVRjckFiMDho?=
 =?utf-8?B?V2xOalRYcDFHSS9nUzB6eHlVeWdkdGMwb25SKzlqd1F2R29aUTcvVjBXbjBG?=
 =?utf-8?B?VWhTdGUxb2NtODFvWHRSYjJWWUErb1ZjZmgzU2kycGs2UTE5aUg5ZUZmOG55?=
 =?utf-8?B?bmoyL3Rxc0ZtMitaRFNHQVBqVWhDVnA5b2t2QlVxQ1NIbHpsdFdNMW9oeWdE?=
 =?utf-8?B?SXN1T3hTcG96cG5kNmlDTyt1M09pZGtjZGExNE1ySFluMU1Ea0Fma3VLWi9u?=
 =?utf-8?B?QjRweHk5Nk9GdHJ3U296VmtWc0t1VExXcTNMUldYcDAzSTZLY0pMVExPMnVn?=
 =?utf-8?B?cTBRQk5EMzl1UVFHVnZTeGxBWVJ1Z20yeDdDQ0lYTzZENFdKeFdvekJzUTYr?=
 =?utf-8?B?bjBBMzN4ZE9GUmZUb0NTK0xZcVY0ZWFNdWZxRFFyUTdZcFkvaUN1bVhSbEda?=
 =?utf-8?B?ZjhLUTZ2RzhWNzk2UG96aFJLNytRWHVreWhxSWovck5EUEhVSmJ3ZHBaSXFT?=
 =?utf-8?B?cXpwaklPNy9ydmFyR1lVUG9jaEhhUjAyemdtNFBkelN0V0F2T212U01uMWxz?=
 =?utf-8?B?QksyUTE2NDJaZGJXa1Z0b1lpS3Mwd1diUG5SbVYrZnVEVkdjSGZpRktCci9i?=
 =?utf-8?B?QkdmVHRIN1FCV1BVYUlFVkNXMXNqWnF0V3pnSjFxbnpsTExDT0JGdlduMXlP?=
 =?utf-8?B?MDNzbGJBbjh2bVcwTkpxZjFVVjMxYlo1SUxPTlBZNGNOdk5Yb2pCeUZTMGpo?=
 =?utf-8?B?QUxiYUZDRDZwVVJmR0Z1ZUJCdHVBK05kUE9LbnNHYzZTK2IwalV3QW9sYjZB?=
 =?utf-8?B?NUFJY0JxUHBsaU8xUGZZZ2t6cVMrSzVLYnA2WEltcTR0VVlsVzhGRFd5eElZ?=
 =?utf-8?B?Z3hwdERPenlOOURQRkk3bWlrT2F5dlhlSGFLTEorS28wTXNTS3JseE8rWEpy?=
 =?utf-8?B?eHlMditHQWQvL2hGSFNzc1gzZWc4R2hJVnNBSEx0dU1wditpMW9CdnhhdFBO?=
 =?utf-8?B?Uy93eXA4c1AzQndBUW91SU4yUHRhZElYbVlIN0N1blVZYWRJNDF2cFI3U1VK?=
 =?utf-8?B?cGVzck00S09mWXIxQ0g1QXV5d0o2c3BQUG10dG9oR25YUlZFRjluUU1mMmNx?=
 =?utf-8?B?eUJsSkhuZWRDbGpkeWxIQ0ZJOGpkZzJKZWlzWVJybmJnNlRjSUNQTVBQdm5n?=
 =?utf-8?B?WlcxSVRDL29LRE5uRWtlM0FBZFEwMU9vMDBab2lOM2J4YUl4Ull1bUFMc0lV?=
 =?utf-8?Q?pr2pZW9a8SENX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHg1aXA1UTd3emRXZXRZVVpRc3hqRHExVjcwYUFydnQ2S3JBUHNBVE9SYzZy?=
 =?utf-8?B?K24xbWp1c3d1Y3dYUVlacTJIVjNlSWlCTy9vKzhSRU1iL1VEalNQQUtJR05j?=
 =?utf-8?B?UW4zMXJEVk90Z1lMMjRUWWZ6Z1BjVDRnNmtkcENUS0ViMzNVMWR1a1E2VHky?=
 =?utf-8?B?ZXd2bElqTUQramZyMVNFVGkxVXRncW0veDIxaFhRVFp2QTYxVnB5QkI4U3pX?=
 =?utf-8?B?cFJ0OWlKRjdlY0oxRng2ZkJLQ0NtdnV5TXo0eWpOY2Zib0NQR3pORFcwSWZO?=
 =?utf-8?B?ZWcrNC9Ha0Q3cldMZU5DUndVcnBTQlE1LzE4NVROWVBjT25KMGdsZXB3QVV6?=
 =?utf-8?B?Q1FFSi9uWjlIRmdPZk5YZjF1WUFUd3ZnM0kzOTJXREZBWlJKdCt1bm8rb1FK?=
 =?utf-8?B?SmdDR3JmSDlBMEhwWC9pT2JuV3Y3QTdGVmxnTWNiM0FoYkc2aU9SNUlMeHJi?=
 =?utf-8?B?RnUzbjFPcElFdkpLNjBtVHVoL1J4T0tRZE5KY1FJQitrOHZwUnNjUjNvVEJQ?=
 =?utf-8?B?dG8wRW1tdDIwRmJtcVd2TnplaS8ybk44aW0rYUE1dmdsaURreTlYS29IU25r?=
 =?utf-8?B?VU5RaUp5cStYeWJPRzVTOXRjYWtLVUpvdWxza0hjbExYbWJxVmlZOHNvR1hI?=
 =?utf-8?B?YTB0b3VZMk1wM0tIL01wSkZ4dGZsYis1d2ZlOFJLMWNmZTNFMDNvRGtLVUNx?=
 =?utf-8?B?MjdFZUQzUmJHblRzNll6cnhiYXdDb3BLM3NKZU5VVnVDYjZGRE9yQ0txZmgz?=
 =?utf-8?B?SnNMcmEwUk83d3h3WFFRWkhsK0ZKTGxDYzd1VnJNR0drUDN4elBCdzk2TUpp?=
 =?utf-8?B?THhLUzhublhJTEpTS3JuTkluMGZtUmdEUlUzZzc1b0RtV0RXTmhjVHVvTUx2?=
 =?utf-8?B?MFpkL05Cblg0MjladHdZWk1lMDh0R0lKUXpQUnhYNGVIYkhkYWFLakxKenFy?=
 =?utf-8?B?MzAxWHJ2dUpML0FreGNWSkkrR21oL25rZzlPS09YcTdLQTlHanAzTG5mMlAy?=
 =?utf-8?B?dzZ4VFF2QlVyYTZpVUExSUpTSU9uMStYNTJBV2dUVTFmR3pzMzl0bFpWUHRz?=
 =?utf-8?B?TVFpbkpKSnlhOE5LMWY0RndWaTdnblQvc011WmdyZ3ZpUHVnRkNDTVFVN1Ri?=
 =?utf-8?B?cHVERDB3K0Y3dXZwR3cvVXdmallqRFhWMW5kbWs4NmZoR1hkaXJVenhtOERk?=
 =?utf-8?B?cW8rRXJYcnBaYWRDbUQ5Mk5SWlYwb1h1OGF0aWNUWjQ4eUcyY1pBeUo2Yk9Q?=
 =?utf-8?B?UUtUUG8rdXpSUmc3blJEc08wWmRhNExneVBKWGtlRlNEZ1drUWJhSUpRU2Zy?=
 =?utf-8?B?aDNKb09JV0xFM3lma0xkdEpSSDVoWnZGclVuRWs1RnU5TEg1THBTeHBSODdV?=
 =?utf-8?B?dFhDeFg4UkxJTy9ZOXd1bDJkZzVzdDdLWHloVHJZaGhWZ3ZQQ3cvelVQMUYr?=
 =?utf-8?B?bjVuN05GRGowckM2UGM5TWZmRWZJa2UxMm1DbVJTZ2kwRHoyV050Mmx4YjdJ?=
 =?utf-8?B?UmRFa3Q5UDdLZjRXMTVLanZaL1BJa1A5WkpCRE9jODFJOFYvTG5ua2NBRWhz?=
 =?utf-8?B?UkdJOHFlUHU4SEhFQU1Qc21qS0NsWksvTU15cXZEV1prRWxPQTV5ejRVU2tk?=
 =?utf-8?B?aFdIMlZTVWtwL3dIU3ZhRkR4dTZPSk9tMld1cVNRWXRUbGFnQ0pJTHJLT2d6?=
 =?utf-8?B?N0Q0ZGQxZ3NZZnc0b3hucUZsK0h5YWQzanlvdkFVS1BtNnFkbGhObkkwT0Y4?=
 =?utf-8?B?eUFtQnVmQlg0aHp3Ym1UQnpFTHFkRlFseU5YZ24yYzczVXl2Vk5nR3ZWWU9j?=
 =?utf-8?B?UCsveXAvK3ZUTStkSXI2SG1rSjAyMkNEUkhwaGZkaWF1cmxmcHVIWkllTmoz?=
 =?utf-8?B?eTJCYkJJVkJwSVlTWXJMR1dyck1sSm9WZFR0Vll0T2Zaa014Ukc3cmxpZElx?=
 =?utf-8?B?RCtzeHFaY3RWc3p6bTk4b1N0bWwxVUV6NTV2RXFVU1g4aEVZUGtRc1pBYjZv?=
 =?utf-8?B?YmphRVFSeW1wQnA5dE9odGxTSkJQZDBCeHlabGNSdXVZOEJtUEJtWWV2N1Bm?=
 =?utf-8?B?TTM0OXd2SGN6c2UrK0V6cmNBYzhTa0l6UlliM1ZMZ21yV0VkOTVybXBqSFN6?=
 =?utf-8?Q?xNH5KPRBSFu2DzE04PKRqEz5o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffeb3ca-8700-4cb1-392f-08dd60a045fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:26:04.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxdjzavaO6CKVxiPRiSYUsS2Bb5vK7SRrC8RXDLs0oaD4+dfgg5cgwoq43X9kSsVpCvshYWiyXEpJG/CQ+OCpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349


On 10/03/2025 14:20, Jon Hunter wrote:
> 
> On 07/03/2025 17:07, Russell King (Oracle) wrote:
>> On Fri, Mar 07, 2025 at 04:11:19PM +0000, Jon Hunter wrote:
>>> Hi Russell,
>>>
>>> On 06/03/2025 15:23, Russell King (Oracle) wrote:
>>>> Hi,
>>>>
>>>> This is a second approach to solving the STMMAC reset issues caused by
>>>> the lack of receive clock from the PHY where the media is in low power
>>>> mode with a PHY that supports receive clock-stop.
>>>>
>>>> The first approach centred around only addressing the issue in the
>>>> resume path, but it seems to also happen when the platform glue module
>>>> is removed and re-inserted (Jon - can you check whether that's also
>>>> the case for you please?)
>>>>
>>>> As this is more targetted, I've dropped the patches from this series
>>>> which move the call to phylink_resume(), so the link may still come
>>>> up too early on resume - but that's something I also intend to fix.
>>>>
>>>> This is experimental - so I value test reports for this change.
>>>
>>>
>>> The subject indicates 3 patches, but I only see 2 patches? Can you 
>>> confirm
>>> if there are 2 or 3?
>>
>> Yes, 2 patches is correct.
>>
>>> So far I have only tested to resume case with the 2 patches to make that
>>> that is working but on Tegra186, which has been the most problematic, 
>>> it is
>>> not working reliably on top of next-20250305.
>>
>> To confirm, you're seeing stmmac_reset() sporadically timing out on
>> resume even with these patches appled? That's rather disappointing.
> 
> So I am no longer seeing the reset fail, from what I can see, but now
> NFS is not responding after resume ...
> 
> [   49.825094] Enabling non-boot CPUs ...
> [   49.829760] Detected PIPT I-cache on CPU1
> [   49.832694] CPU features: SANITY CHECK: Unexpected variation in 
> SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU1: 0x0000009444c004
> [   49.844120] CPU features: SANITY CHECK: Unexpected variation in 
> SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU1: 0x00000010305116
> [   49.856231] CPU features: SANITY CHECK: Unexpected variation in 
> SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU1: 0x00000003001066
> [   49.868081] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
> [   49.875389] CPU1 is up
> [   49.877187] Detected PIPT I-cache on CPU2
> [   49.880824] CPU features: SANITY CHECK: Unexpected variation in 
> SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
> [   49.892266] CPU features: SANITY CHECK: Unexpected variation in 
> SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
> [   49.904467] CPU features: SANITY CHECK: Unexpected variation in 
> SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
> [   49.916257] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
> [   49.923610] CPU2 is up
> [   49.925194] Detected PIPT I-cache on CPU3
> [   49.929010] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
> [   49.935866] CPU3 is up
> [   49.937983] Detected PIPT I-cache on CPU4
> [   49.941824] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
> [   49.948593] CPU4 is up
> [   49.950810] Detected PIPT I-cache on CPU5
> [   49.954651] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
> [   49.961431] CPU5 is up
> [   50.069784] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/ 
> rgmii link mode
> [   50.077634] dwmac4: Master AXI performs any burst length
> [   50.080718] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features 
> support found
> [   50.088172] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 
> Advanced Timestamp supported
> [   50.096851] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/ 
> Full - flow control rx/tx
> [   50.110897] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: 
> repeated role: device
> [   50.113922] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 
> 13:39:28 UTC
> [   50.147552] OOM killer enabled.
> [   50.148441] Restarting tasks ... done.
> [   50.152552] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   50.154761] random: crng reseeded on system resumption
> [   50.162912] PM: suspend exit
> [   50.212215] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   50.271578] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   50.338597] VDDIO_SDMMC3_AP: voltage operation not allowed
> [  234.474848] nfs: server 10.26.51.252 not responding, still trying
> [  234.538769] nfs: server 10.26.51.252 not responding, still trying
> [  237.546922] nfs: server 10.26.51.252 not responding, still trying
> [  254.762753] nfs: server 10.26.51.252 not responding, timed out
> [  254.762771] nfs: server 10.26.51.252 not responding, timed out
> [  254.766376] nfs: server 10.26.51.252 not responding, timed out
> [  254.766392] nfs: server 10.26.51.252 not responding, timed out
> [  254.783778] nfs: server 10.26.51.252 not responding, timed out
> [  254.789582] nfs: server 10.26.51.252 not responding, timed out
> [  254.795421] nfs: server 10.26.51.252 not responding, timed out
> [  254.801193] nfs: server 10.26.51.252 not responding, timed out
> 
>> Do either of the two attached diffs make any difference?
> 
> I will try these next.


I tried both of the diffs, but both had the same problem as above and
I see these nfs timeouts after resuming. What works the best is the
original change you proposed (this is based upon the latest two
patches) ...

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e2146d3aee74..48a646b76a29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3109,10 +3109,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
         if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
                 priv->plat->dma_cfg->atds = 1;
  
-       /* Note that the PHY clock must be running for reset to complete. */
-       phylink_rx_clk_stop_block(priv->phylink);
         ret = stmmac_reset(priv, priv->ioaddr);
-       phylink_rx_clk_stop_unblock(priv->phylink);
         if (ret) {
                 netdev_err(priv->dev, "Failed to reset the dma\n");
                 return ret;
@@ -7951,6 +7948,8 @@ int stmmac_resume(struct device *dev)
         rtnl_lock();
         mutex_lock(&priv->lock);
  
+       /* Note that the PHY clock must be running for reset to complete. */
+       phylink_rx_clk_stop_block(priv->phylink);
         stmmac_reset_queues_param(priv);
  
         stmmac_free_tx_skbufs(priv);
@@ -7961,6 +7960,7 @@ int stmmac_resume(struct device *dev)
         stmmac_set_rx_mode(ndev);
  
         stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
+       phylink_rx_clk_stop_unblock(priv->phylink);
  
         stmmac_enable_all_queues(priv);
         stmmac_enable_all_dma_irq(priv);

-- 
nvpublic


