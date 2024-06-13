Return-Path: <netdev+bounces-103391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B615907D85
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA74282CE3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4D13B5A6;
	Thu, 13 Jun 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TW8nke8q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035F13B2B4
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311116; cv=fail; b=A1Hke8j8luTTEbREcsvxTR/MDQRJZ/mjNG5kIV3sEf+pBGrtIWPQ9KnLVa0un6tI9ijgAj7IUe0W6i0HKgXfyUJXUbkbnYnyopgSU5Lcnt5ET/L/Ig3rfYNmxrUU3/l1693waOcX4/0BovnsC/no9/6rvGkLJoj/GkImaxjau7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311116; c=relaxed/simple;
	bh=U4OVGcwPkysQiM0BUK+es+YQ53zhUW0S98oP8CQqAqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSoVAN4iiiqBF2NiO+vUBSVRXrOqei33zxVUyM5vodTjwFehQ6SxmoW6TeB0jsNM1JI0zBZcRkI8SVVSYZMWikrh80bsnrLWlvdaqxPEgh15n7afFWsNWhaJ5cpAfqS7iSH0zKVFA3Qfbujunt0+h7issWIj4QkG7Xv3986c4Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TW8nke8q; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTAeEKw0Dq9yT/i5LSv5eZNGma7BKuGBCt7g5RZig0/AkX5Z8LpXKQMkaCZt0i4l7EUoQZ3UvFnga4H6cQq19jk7zS2RWHlRa9oywVuUkZlqENxRwaBbPldKKqx57LXXRnBAjhQkwjl8917s8Kg2EenAh31DFacFuTQSteKqoqbiLdWhr0SE8OVQWYtH/I5tYmg7DKvTwernuLVQolA/GGmD5FArMeaHe/gnsIm9AVTh5Nkd8Ef2bTN6gLqHNxrK05CEe/AZ7SPyOLUbWnahz/Nj1mhLfQwREw3yLh//fZ1K2Uc+y4LIZ9sGc+KkxpaKXa9FZ2LuzgJEUdgg+wDoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLOHf9xtynyW0ID3MLExcYZqiBCtqzNdQUjaI/8bjIY=;
 b=NN8T4q9h8Kw41bM3yV6P/YTZ57hZBgF2BdPZp/aEVWaUDNdLHcKrJtVgFWJS3YP1Mg2T68Km+JRpzpD3NB8WagFR9kIlVep/H04js2ih/Q0uDIN8jOQuQSAg58crxg27FnAM7f7V7XRJCmuES+YOnqajU3lC4JXGZIHzQiHENcNK3V/ly4ojlRzRvzWS5p5O+PhcAFfnNdclxFm7KhMUaoAJu2kUor19QaK2Zf14Zr3V+2pRcTBFxp9CutNqXTP9M0FbjI9wMNRcpGOkfNO3ZJd/1Zd8METay7Z65JCDl9I23rnZQ/D1Su4Kn6AnDAzEBrOPPEY5iCvniQ6H1xLR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLOHf9xtynyW0ID3MLExcYZqiBCtqzNdQUjaI/8bjIY=;
 b=TW8nke8qeea7iVpFO1ekhXb5nh+TxXbh1RjuLNcdQXLIG6OGOhy4qX2WmTBPsmb7unmh9pzK2MKu4xZkEY2ntTLHZiH4n2ryTa53Sew5RR6Ge9basjap801hTqWIZS23QY83TgheDEH2qujNhJ9mZ4JjDqpH2MLJcMF9+A/HaXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Thu, 13 Jun 2024 20:38:21 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 20:38:21 +0000
Message-ID: <54c39843-b81b-4692-a22e-d2c51e617219@amd.com>
Date: Thu, 13 Jun 2024 13:38:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] ionic: add private workqueue per-device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-4-shannon.nelson@amd.com>
 <20240612180831.4b22d81b@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240612180831.4b22d81b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b235656-e13c-4140-6eae-08dc8be8c380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGc4Q2tsUHJGcUlBeEs5SWR1WnZvdUVhSGQ5bWxNcW8vRVpZTEs2UHp3aW5N?=
 =?utf-8?B?bkt6QXZTZjdCYURSZ0V3MWJWc3FVYm5QTVJPWHM1VHBhV0lncGZLUEZQazd4?=
 =?utf-8?B?aGxXZDNBa0YxVHJtc0FFM3RRWExIL1NvQlJrVTFKL2xlZ2pyaEEwcXRTbEtt?=
 =?utf-8?B?ZGxOZC9zMy9WYWpJSHRGYm5IZUQzeGgwbWhvcHBYNGlDVUluRlNSV1pkNktx?=
 =?utf-8?B?YnNGNHhrWFNDYU1TTzNDcjVJSFNCTXhZQktReGVqSU9WNFc3U2FZaitqTWp4?=
 =?utf-8?B?WmVFcVc2N3B1SkI1aXI2YVF5Y3greVdud2dBY2dJZXh6M2N3M1Bkb3Z3cTdY?=
 =?utf-8?B?S3Z0T1haZjFHVzA3cmJCRVBwcm9uNE41aUlRZ3pWTGd0bk5FVTliVmMzWndz?=
 =?utf-8?B?ODNtZ0pMN2VYRmQrU1p6c1k2dXlCa3JiTUF0OEMzd3VEYnc3MTRITXlUaTRU?=
 =?utf-8?B?dUxqRjQvN2xqNGp0Mmk0K0p6dFQ2V0tJUjVwL0pDYVhCWTRYV3d5Ly9QTVhY?=
 =?utf-8?B?SVBLd2dhVE4vNlltcEFNUzR3WGh2T2swSWJDcmYyZ0xsSDl3ZzlmS3psUjA4?=
 =?utf-8?B?MnlEajhNcDIxa0xXdHVQVXFaR2JtNjk5ZEkxQXNTYWxTenpTbzJDOU5ZZDZN?=
 =?utf-8?B?YXJNUHF3SXp1Q0lhcXRJYk9FV0JjZzErekxHdXBNYXNOS2JMS1MwMDlhWVBN?=
 =?utf-8?B?RGtMQ2tDOWZnbm1uUDhEL3p4RHVEb3UrN2dGUVlKckJQS2ZKeW1xa2R0eXUr?=
 =?utf-8?B?M1lVZmNMVDhQVjI2ZmVHazg0UCtDRktrUTlEWWwvdkZNRUxEZU5vTjIvOERj?=
 =?utf-8?B?M1kyRHROYjJDSUtXUENia0hPTnh6UTc0K1dOdGlFb2JuWUFOeitsV2lUVGRO?=
 =?utf-8?B?amxjTE1iYjcvTER3S21sdEN1NnZyTlF5dXBXRVpnUlgwc1lBTXg1MENvVE9U?=
 =?utf-8?B?b0M4Ui93cm1nRkFFS2VOUUZFUUc5UFJzQ1Vsd2JFMnV1UWtrZ1BSRkZvcDZN?=
 =?utf-8?B?SzZPd3BuNTFiT2E5SzhLNjQya3crVHpZSEVBaXdJblZrU054RURkZjJya1c0?=
 =?utf-8?B?WE5ma0N2K0xQMDNFWVliZ05NYXluUHdOWWJCeVV3QTh6UStpOGdRejBleFAr?=
 =?utf-8?B?VUl4UWVCdUNNdjNTSnZ0Y2w3SDJmamZpWDJScE1UMklyZzdjRFl6Q09MdXlH?=
 =?utf-8?B?R2VlWUxoVGtnakU3TWdpS0dHb2RXMjQ3dkwvcWg1cW4rOGlTbCtWdFBoWWJK?=
 =?utf-8?B?TjFDa0I0bWwxKzFydFdWVHI4amxnVnFPR3h4czRzc2lrNFhjMnBWakpwNFEx?=
 =?utf-8?B?QVpmKzFVTXVhNnc3RllDaUVodjN0UmorN21IYkl5YkFVVGtyeVFDTWZLakNp?=
 =?utf-8?B?S0dGZjNQeHQyQUNFV0R4aER3NUZocElQWTlyYkZHcXlmMTdpQ0N2SW9EQ2pk?=
 =?utf-8?B?NW1QV2JNaStYNXByamZ3bHRocWpiZW16RGx2UXlHci9hRi9TbCs0cmxYdUhw?=
 =?utf-8?B?WnFtZkZJcU9TSzdyOHJ6Q1JITlN6L1M4bHBvQTBXM0ovZzZXdW1EeE9YR20v?=
 =?utf-8?B?cURsekhLTGF0UEhFMnR1R1VOc0hkdTA2Nmo2NGdZT1FyMVNpeFI3TkpITm1z?=
 =?utf-8?B?cHJNT1h4ZjhXT3VONlpVa3pVVWYxbGdKcjlWWTI3eUZsR3NLemQ4OGw0ZzR2?=
 =?utf-8?B?QnVhR3B6TzBnVkk5NnhkdHVoRmtwSGZoZ2FJK21YamRIRjJhOGRPZVpWOTFr?=
 =?utf-8?Q?M4WESrS/aOSgRJtNdzk8Aage9jK9asAC5Q3jOzj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2lweis0Y3BrMEM5MEtodXFJZ2JPamo1VEpmZ05yZ25vaFZTY012NGdQZVFZ?=
 =?utf-8?B?UTZQZzU3UUdtVlVYdEE2VDdKcnV6OGQxeUIvb3lLNURmTEtFbEVTV1NtWjgr?=
 =?utf-8?B?eSt2enVhNFcrWVhIUWEzK2JNdWtIelBJejNqbDNxMUZWWlkvNDF0MWRPZlRH?=
 =?utf-8?B?YnowNWZrTnkvajNFMysrVisxQ2puWUFBbFZLZE1wZllTLytycEV0QWtKemF1?=
 =?utf-8?B?YWxibzZLTG8rQ0tDaTZMWi9UMi9XUW8wZ3JBZkl4RHd0VXJydTZiMkk2ajNq?=
 =?utf-8?B?a2FoWEQrTzZjdGJrcm0rYXgwQ011bVVSNmVibk5HOFJjd2NVV3N4TUQ2TDFB?=
 =?utf-8?B?M3dKcDdobzNKSEo1TS80ODlmUzk0d24zTUtkeGhiTG5RSnRJMTYveFJXZWZx?=
 =?utf-8?B?YjB2bEVTSnVYcUxWS3lYOTBrK201a3RGQmpJMk9kM3MvM1VLZ2RuNm1LcXpk?=
 =?utf-8?B?Sy9qRWZUU0lhazRMbG5KU0k0dzRWZkc2ZklnSXFKRjhsODZ1Q0VEU2NhVGg3?=
 =?utf-8?B?MFQwOUhYa2x0enN4cTNvYnVKVjhCc0hoQjY4R01YVmJQVDQwODRocGNSWkd2?=
 =?utf-8?B?MitWUXJjSW1uUU5tbE1FNllrWGE0cEFjR1FTTS9xdytDZ0xQelhxaHNCNExo?=
 =?utf-8?B?MGovaFBoVDlzdVp2TStpMjdtWGxsWURmVnc1VkdpV2lCUnFzRzBoZFNLanNo?=
 =?utf-8?B?RnlIWjJ3Wlh5V3haMlQyYWFHMTJuN1lUb1ZYWHFDbWIreW9CdTdncFNPdEVL?=
 =?utf-8?B?NHV5eEJTVUc3cDQvUTdWbUpRRktGcHd0czlxUHpsS3NNNTNUZTdzTmZMV1BW?=
 =?utf-8?B?MzY1SHBkeTZ6OUpoMlpTdkhRRUJ2NHBseWpnMklwbk5jY0RnaURrVmVNUTIv?=
 =?utf-8?B?a3YrNVh5eXJDY244d2VnNUM5aS9DQ0Vnb3J6Qkd2TDduQmdDZjRTTEcyQlhJ?=
 =?utf-8?B?WkhpZXRSc1dsQWVHZC9mdnBGNXA0L1ZjL3d1U3AzNVBkWVduZUJxL3ZNa0Qz?=
 =?utf-8?B?c0VtSythMzlrSm45RFZEYmNrME1CL2Q1VHdrUFVud21jWkN6ZGZITUg3WHlz?=
 =?utf-8?B?VDZvd3pPdkpLV1B0N01sZWNhZnpsRk1aaFRNNUpqTmkrNENSMXJFYmplSHlj?=
 =?utf-8?B?UWtYbS9TQ1dGVUxtamZZd0h1UDdqOGo0dEZoajhrUnN1SzdmaWs3RE9WZDhv?=
 =?utf-8?B?S29rc09INitidTJrQ0hpeUd6ZVdHeGNhbnphaEdRRG5qSFF6OE5HS2JZRWpL?=
 =?utf-8?B?djhvTnJYa1BaUlU5ODNEQVpoZVRYRmxMWXR3MjU5Y0tNblZYNXRGVjJFRVNE?=
 =?utf-8?B?RnBDbmFjVTNteklVRzF1MTRWdG9YYnN4VUpWWnVTYnBYNlU5VEgxenVtWHpD?=
 =?utf-8?B?ckRhZFd2WGhIVWMzdkRYMGJYVnpzcVQwK01iT0VybjloUWdrRVdVQnpOT2U1?=
 =?utf-8?B?SGkwa0ZsQjBkR0ZYZjdBRXJKR010RnFTcTlSQ2JiK3hIWHIwYnlqbkVmOEdP?=
 =?utf-8?B?SWxQN0FZMmszQklmck12M2tJek5uOWYzUHpoNzROYk1QbkNtOTNjcDY3RDAx?=
 =?utf-8?B?MkpieC9Gd3QySDNPdmhPZ1Z3cGVwZkE1QWhSc0lmVW9JTlFyTW5MbDh4NHIz?=
 =?utf-8?B?NFdQQzU1OTZMbWN1S0ZDcThlb1pSRjFHTWFHS01INzRxMXJFUmlQS0JiWFVx?=
 =?utf-8?B?VXp1ZDFuYTYyazZ3MUU5WWx1ckxtV0pUamFrM3pRSkF1U1k1RVZIQkZ6cDBh?=
 =?utf-8?B?M0NiVk44NUtobGlMUTBKcVhndDFSYWxRT3U0VlBHZmdxeEdTT2luaXdHY21S?=
 =?utf-8?B?RXBXcFRFaGVNamhkUFNTZVpKZSswMmZqN2M1VTVzYW5teWtzdVVSd0k1QkRX?=
 =?utf-8?B?MXFGM0xoVEk0SU02UHM4OGp3czJVSmFFek9ia2RFY3QwcE4wbmdxM2VWRjAw?=
 =?utf-8?B?U2dPbDFpQy9qR21DQndLWnoxaElzUGY2ZlpkaGgzUzNHa2xETkVpcUlPeHhM?=
 =?utf-8?B?K2RsZmJLSVJ6TmpNU0QrVS9jQUJIaGlEQzNUMnJ0TnpkVmpQOWlMWXB4K3d5?=
 =?utf-8?B?QURwcDl5eEpzRWdSemdiU050UVdvWnYvWTJXeUxxUDZiMTd5akcrZFJnMlhW?=
 =?utf-8?Q?vnOS+AWkkKbmUQpDG3jVxnJb0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b235656-e13c-4140-6eae-08dc8be8c380
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 20:38:20.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmK2sGYyvOUv6cFq95ZMVm4ac56dtHjPiYlrBN8SgKbifqIyn2K0aRwD3VU1lT6VkDcW7J/Fj1k9WSe1hotmJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

On 6/12/2024 6:08 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> On Mon, 10 Jun 2024 16:07:01 -0700 Shannon Nelson wrote:
>> Instead of using the system's default workqueue,
>> add a private workqueue for the device to use for
>> its little jobs.
> 
> little jobs little point of having your own wq, no?
> At this point of reading the series its a bit unclear why
> the wq separation is needed.

Yes, when using only a single PF or two this doesn't look so bad to be 
left on the system workqueue.  But we have a couple customers that want 
to scale out to lots of VFs with multiple queues per VF, which 
multiplies out 100's of queues getting workitems.  We thought that 
instead of firebombing the system workqueue with a lot of little jobs, 
we would give the scheduler a chance to work with our stuff separately, 
and setting it up by device seemed like an easy enough way to partition 
the work.  Other options might be one ionic wq used by all devices, or 
maybe a wq per PF family?  Do you have a preference, or do you still 
think that the system wq is enough?

Thanks,
sln

