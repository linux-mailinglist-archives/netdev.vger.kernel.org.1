Return-Path: <netdev+bounces-131732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74298F5E0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F97B21133
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363D1AAE3A;
	Thu,  3 Oct 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jCgpdeuf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C719F418;
	Thu,  3 Oct 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979192; cv=fail; b=TnabnSNiUhY4gQcSSZQlBmmW/F+S2nnXG1LudYZTKeapDlnOMcYS/y783Ls1OGFtzVWQyOxFtRki1n6Kv/sQNwL6avEBr941KRmhfZ1rOnMZFzGupu2x+VNcanquveLEPL4XJY7rZx3nfSgkGRqHooxfWdzdkMSB/2x/w2xcGy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979192; c=relaxed/simple;
	bh=dlALyL4qZ+7NH+sp2wutX5HE1kk0uaWYY0+RVWCNi7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKQLVxxWKG3IdimA/QcaDa8Y5x+yLblCrZbRrsKD8U6qOja/m6C1m4T7NbPHVah3AMXCHZkqfBMsMx5BGySmc/ypip2LhBe/Sve3i0ZYs04z4MWJFp7fx6P6KM9eiA1T0yMr9F8BjiozlqJR3MMBVwU72KUkW89X4WSvVrXx6Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jCgpdeuf; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OF3TVmdh7JlOV2ackhUaaii7Hm1Gj2dQVXXQxuyi4VIE0+eDRuH6+zFFUob3o2L31XOdkCwL+Zvqo8C4IIALfdk3c+fFtjr+j1N25GngPiXV91rd5GGhqdRA0cqgFGtUQnv0k/d2dWp1A3YFexsrOz2avlHliiYBOcCFm++pJ+2kPEQke+pnr96+Lrpttjev2J+66Fy2jVQ1QJUc/sTZF6mWDbdCRjU/7UgWjFvnKgBLcD5CQQGZZ3thfZkiYTjtsqD0quEC1TCE1XDO/bA5eE1O+H/PlNPd7fEM+9xTuepvmhaWM43uFDp4g5Ki7jjMeqpuWofHhbr2BLZCforuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yloF0qR7HVGJ7MRDRBm+MJ2eTBc0kPLblqZD4JXuoVI=;
 b=oKKmYYvtOxK3kD2xKluOfvgcmhQpG39I+k06oCsbOTVk81d1J+FIVNRPn9SBPeDzAc5osqKzXDJxDMkV1m0LEuKtxd2CZJaNoSRAMSBRPsAiyRDAwiGf9T6bgT1K/OZJ3AFe0owTjpOHBd5XO38ZCpjd0/xZ7fyaQy4nOCXVCeDJMRNA6vR9t3i+DW1m1n4F9YUv7lWhT3b3T1pdLTsSEYQ9fO/PxyA1F678MLCJYywTWWAz7Y+VQdavfPOrcLpqov77+sNSYWLSgPkykvB/r0L+x6wTyu8Hvz/zlw3uM8J8I4Yu43MfEKipgKB4QhXVqouGB11H9daEqVCUY1Mn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yloF0qR7HVGJ7MRDRBm+MJ2eTBc0kPLblqZD4JXuoVI=;
 b=jCgpdeufpTvsV8tR1rdpNF/CFnp6JkAf6VCdj8EToKGv7fQvuQrwlj1Q43/fBNifoGu6pp5pD6lG65YJ5pGMYDGaH/63hBON5DXdZQKjgW6lbkSVhwJ9bDcfNhnOGwZL37aCySD1CmGozGKgJXnM5r8+sbSt70sL2P4jNssJtQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 18:13:05 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:13:05 +0000
Message-ID: <0913d63c-1df5-407a-a7c0-d5bef0210e8e@amd.com>
Date: Thu, 3 Oct 2024 11:13:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/7] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, almasrymina@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-5-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20241003160620.1521626-5-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::19) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df44b6b-9430-45c7-a177-08dce3d706da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDhVTkJTYTl6SW1yVGUzcHBoMTgydDBFTVM3MG03MlNvL1UvODNEZDFJSUtO?=
 =?utf-8?B?TmtueUpTdkwvbVJiYStnWWlzdXJDSEpFN1Y1aWxNZVVzZ0xOVERJNjZxdURk?=
 =?utf-8?B?RDNXd05pNFpPUUVZTlRMNmdIN09Dek5RZkxCMjY1NUUwOW1Vd2Z4WG9TdWJO?=
 =?utf-8?B?bzVOQ3JxV1Q4dE5CbEhRakRTZlp4dVIzdjNBbDZwNDdCUHFJMGJDZHFBT2tK?=
 =?utf-8?B?bFAyL0ljOTZDQjNoVjlBNmNacW9NL2h2Nm9xYkF4VVdrOWVGeGU0NlhQcENN?=
 =?utf-8?B?aGZod3JhN255WGZ2VWZXR0NOd1V4bFhlM2x5Y1dSdG94YjlvRmx6ODhYa3lH?=
 =?utf-8?B?ZmlWNDVHMFAyek9nTHF4RFpDQmpUQ1NOc0VFbHhpUDZaSC8vd2JSMk9qWDRt?=
 =?utf-8?B?Z3cvQ3JrWi9acTlTQXlPQlNzS29KUHROUUovWUFweFZiOWtyWloyZElCRnUx?=
 =?utf-8?B?d0tGd2crR2IrWldiRTFmbDdxOGRRaWJVRS9MUVhDSytnZWY5QTczemZVbzAr?=
 =?utf-8?B?cHJIL2MwQkxVYVNSK0V6WjFhdkRHREloTW1yU2lFSHJINFlQcXM3aGpHMzlm?=
 =?utf-8?B?N3FxSkwzRlNXUm5LaTh1VTZaV1djck5tRllpd2p6NW1YM3FnSkovTlplcktO?=
 =?utf-8?B?VXFOQXFVbmwxKzdtc1UwOVNNRmhOR2RzWE0vM1FZN0pJSzR2THBaSnFOSjF2?=
 =?utf-8?B?S0tSR0M1MmdOSEFodk1KU2NGd0d5VnhOakViMkc4NEduVXd0RHlCWG9tb0hD?=
 =?utf-8?B?OUVhV3U3Wi9nTWJZcTRLekZyWEd0Umcxazk2VlRCQjY2ZmtqZ1ZtSng1VDAz?=
 =?utf-8?B?TnNqQ1FOSWJoNDZKbHB1c2V5RVFTMWxDekVQakVDTnNTWGF0QWJmNm1FL0VL?=
 =?utf-8?B?V1FlckV1YjBJeFR4MFlSV1luMTRkKzFzY0pQeFd2Z1JVVnd2bnFjbG0yL1U3?=
 =?utf-8?B?YngrSlVRYUtlbFpXZ2I4bTdVNk5kZk1ycUc5cG5ybzJpU2Z2WjhxNTE4NG9Z?=
 =?utf-8?B?akZXZnJCZEE4OW5OcEFOYUpnYmNrakxianQ3M2FPbzJpUDhBSWZDRG9rZ2sr?=
 =?utf-8?B?WUxld3Q0ODM3QlE3bmVOdEZDbVRMdzQ5aVVVWndFNm9hbmthbjdHUXZCSm01?=
 =?utf-8?B?aUhXSTI2QjhUWmtpUkFjY0ZBYVZsZitrdm5QOHVIeDR0YlZIV2FFU1NGMWhK?=
 =?utf-8?B?ME15VE1MUHJBWEhkSkZLRW4wRkJDY2xmNVV1YmlrUWZWTERMUWJHTkg1Y0Jy?=
 =?utf-8?B?Mi9OM0dKekczb3BMNElEY3RPMEc4eFl0L2EzNHJOZUdVTytYaTRNZmZ1QjZQ?=
 =?utf-8?B?Um5XSXR5V1VxbmNPTDNBTytkWklkcUlEQ1JXNkJCSjBUUWswWTNoNkpaaC80?=
 =?utf-8?B?QzZEbFh2VVBkQk42U0pDOWlxaFY5elNFU0o1cUF5dHg3Rm1reW1uMThOODYy?=
 =?utf-8?B?Z3RFQjcxbkM0TTRHSmd1RlZLZW13c0hVajNoWmFWbjQ0a21qMmE0Nld2Znhu?=
 =?utf-8?B?M0VYZWgzQ0Z0YkZCQytZRWpjMmlwZWlBMWIzVkkrTjE3cURUazNaeEFSU0p6?=
 =?utf-8?B?MlNCMDhZL3VrdGZPNVlVdUxsTTlVSWxVSmdoVGQ2d0I0SnlMMmJzbndBVTBO?=
 =?utf-8?B?czFTMjdTUTJiR0VVVVY1M1RWZWNPMi82eG8yTmFGalcwRU9BajBXaHQwTWRT?=
 =?utf-8?B?Vk5Id2gxRWpBMFlrVXNWWUEzYmRKdWpKdmtBcWJQRTkweFBKYllPVzZrVnEy?=
 =?utf-8?Q?3KjZlgOv8HhtB9oNkGV63AYegym104USpZAcQ4Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW5STVY2bWRVSHptY2ZvOTRHTm1QOHlWcjNrdW43bHFwSDJJNDZvYkM1aW53?=
 =?utf-8?B?KytrSGh6MGJRSnNHTk9adEJSVnBVRkQ2c05Ta2lTUWRPZndmMW82YjZEdmcy?=
 =?utf-8?B?SkpGZWkveEU2N0k2WjBZLzFsaGl4aGtJdldSUldZNFJERXh5OEY0dWxZa2pF?=
 =?utf-8?B?WnBaak1ubzRPT2JPcmplQzRVYXZCSmpDYmNvU2FNbmJyYzZVWGtrT0JGKzRZ?=
 =?utf-8?B?bzNFTlBWOTQzT09FR3NPMmVvd3NITndGMXIxbllXVkxkUVJVdlBycGt5MHk0?=
 =?utf-8?B?UUFvWmRSNjlhc09FS3RlTzlTNU1RcktZUWJlVjZCQnV2dmZ6UmFVcXRjeUd4?=
 =?utf-8?B?TmdtNExjaUo4ZCtlWThZYTRXUUEva0xDc09yN1Fmd2hvMkVhUlhLTVNMUmJZ?=
 =?utf-8?B?Q0RNWWZDc2tIbVhLU1VvelNHZ1hmTTBjcG0wZEl1NmJiMkdESmloV0xGWWls?=
 =?utf-8?B?WTZFcHdqR1k5KzNwQ3dLNmJhZ2R1SlFUTlYzU2ovaGZoTDhPbWluOXNZQm5u?=
 =?utf-8?B?aDdsdHFwNXl6TUtYSzI4K1dTT1VoOUFyNy82dFNYc1lQYm9NVElzdkk1cW0z?=
 =?utf-8?B?OEZJaFVuM0FOU0xkU1BmTkhyZHc0VzI0dVpsVzR0d0M4VzRkRWFEK2hXQkIz?=
 =?utf-8?B?WmJFZUpCRjBkSkpXWDBJa0VSUlNnRXFkR0txbk1GRnZibXJNekY0WEFQWlUy?=
 =?utf-8?B?Z04xcElnQm9ZRC9GZkllTVljcTUrdkF2SWJNWjdsLytIb1M5N0JRYndsOVJZ?=
 =?utf-8?B?b29IWDVSRzJoN0kwOCtlcXlUUEZsdXFCSW44enRUNFBnZFF2L1BLNjZZK2c3?=
 =?utf-8?B?ck1nUEpXQm9pTXNRVXV6V3FyM3JmQ3lMejdMcWlrUFdrSmdCSzVBZnMwSndt?=
 =?utf-8?B?RTZMaStvM1Z1RWpCOFp2L3NERzYwblFVOW1WQjgwVjk1dDlmTHJFRmlRWjlS?=
 =?utf-8?B?bUp5UzVycU9LQlpHTlQ1WHFCZ2t3UEZNTDBxaVhMNjF4ZU92eTFOM05yMXZ4?=
 =?utf-8?B?UmdHZWFyT2VqOWIwdnUrKzNjTkl6NkpFQVNNc3lwZmZYOW14ODlnMnZQY2lW?=
 =?utf-8?B?Wm9wYjAyaU9YT2pSaGJHYkFmRnVSYnhwYldxOGJHUzhFN3ZaMWNENTJ2MmRE?=
 =?utf-8?B?dU8yMnFzZzZQTGZtcFE3NDlzdVRCSHQrcXphSm5UdndXMDNiM2xEMm0vOUE0?=
 =?utf-8?B?bFNzZ2paYm0wQUtsejJYQXk2dGNCc0x2ZUlvN1Y1ZktpbWN4RTNCWE1qMmdO?=
 =?utf-8?B?ckpGN1U4cDR3Uk5wRnVNd3JiR2JBWnJscVhZeEhqaXpJYUlFd3R3SENUa2Q4?=
 =?utf-8?B?ZG9oRkRMV2R2VG1Wa0xtbXhzeHYxaUZ6UXVpK0ZwaGpqa1BONkptWjlHT0w2?=
 =?utf-8?B?RlliOUI0QnJtNWJXd2lRd0tLODYvUXdFV3NWVFV5RjRCMHFYL0xybjdaUERn?=
 =?utf-8?B?NituaEwxZ0RselNrTDRsOS83c0RBZDdXUmJNYXN3OWFIT0pyY0RhS3EwZTlH?=
 =?utf-8?B?YTBIaE82NXJJb2d0SFVtcXMrU3RDakdaLzZEZytDbXpUM2hUdmQrNUNpTG9t?=
 =?utf-8?B?aUh1TUNYbjhvS1pRRUl5MXpvQkdqLzVZTWUybDNqQmJWYUF4Q25TQjFpWTBR?=
 =?utf-8?B?MlBYR2Fvb3kybzlyU3pxUUxsTDk4cVMvb3p4ZUVYUWF1azR4ekYvZXQycGNz?=
 =?utf-8?B?aVpWSTZYL1N3NWNzaEZOQk80OFJqczU1VHZndVI1WGI0WGhkV1FyQW95YWhR?=
 =?utf-8?B?WFB1K3pMZ3g0ZG1nVk1rSWdMa0RSSzNYcEsvbkVMNUQzR3pDbzdjNEJYa0FN?=
 =?utf-8?B?bE5Vdm9jOWZyZG0rZG1iRG1qUG5HZXBmaVFwS081NGsvQTI1VUVzdVI1a1Fq?=
 =?utf-8?B?cGlGQXBvcldadDRuTWVPVzFXVHlGS2IxRm8vNFhqaHFUL2U1b2Uxcys2bDVt?=
 =?utf-8?B?SWQvV2NFWGYwUHRLOHlaaGRzUUdjamd1cEV0RStRWkdtYmprYWJ3TzhVejhR?=
 =?utf-8?B?bVA5YkVuRkZ1eE1ZN29VNWFicWYxekV6eDhBaGNFUE84WnZaZFFZZjhpOTE5?=
 =?utf-8?B?dlN4dmZqUVd4eHpYUFAwUFIzeUZKbzBpeUxRVlZJRXdBMkM1U2RPOHRvdXFr?=
 =?utf-8?Q?z35iVJTOoLE+Yd5KvpaMSR1ex?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df44b6b-9430-45c7-a177-08dce3d706da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:13:05.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV5JojMS/qKYzfzLZFhEwdzJTIbMH27R64sbH/Sw4+O1FnsRwbtGsOMNbv2tGp1P7rMhOnl/SYRPXbu/cvsnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199



On 10/3/2024 9:06 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The bnxt_en driver has configured the hds_threshold value automatically
> when TPA is enabled based on the rx-copybreak default value.
> Now the tcp-data-split-thresh ethtool command is added, so it adds an
> implementation of tcp-data-split-thresh option.
> 
> Configuration of the tcp-data-split-thresh is allowed only when
> the tcp-data-split is enabled. The default value of
> tcp-data-split-thresh is 256, which is the default value of rx-copybreak,
> which used to be the hds_thresh value.
> 
>     # Example:
>     # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>     # ethtool -g enp14s0f0np0
>     Ring parameters for enp14s0f0np0:
>     Pre-set maximums:
>     ...
>     TCP data split thresh:  256
>     Current hardware settings:
>     ...
>     TCP data split:         on
>     TCP data split thresh:  256
> 
> It enables tcp-data-split and sets tcp-data-split-thresh value to 256.
> 
>     # ethtool -G enp14s0f0np0 tcp-data-split off
>     # ethtool -g enp14s0f0np0
>     Ring parameters for enp14s0f0np0:
>     Pre-set maximums:
>     ...
>     TCP data split thresh:  256
>     Current hardware settings:
>     ...
>     TCP data split:         off
>     TCP data split thresh:  n/a
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v3:
>   - Drop validation logic tcp-data-split and tcp-data-split-thresh.
> 
> v2:
>   - Patch added.
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index f046478dfd2a..872b15842b11 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4455,6 +4455,7 @@ static void bnxt_init_ring_params(struct bnxt *bp)
>   {
>          bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
>          bp->flags |= BNXT_FLAG_HDS;
> +       bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
>   }
> 
>   /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
> @@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>                                            VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>                  req->enables |=
>                          cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> -               req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
> +               req->hds_threshold = cpu_to_le16(bp->hds_threshold);
>          }
>          req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>          return hwrm_req_send(bp, req);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 35601c71dfe9..48f390519c35 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2311,6 +2311,8 @@ struct bnxt {
>          int                     rx_agg_nr_pages;
>          int                     rx_nr_rings;
>          int                     rsscos_nr_ctxs;
> +#define BNXT_HDS_THRESHOLD_MAX 256
> +       u16                     hds_threshold;

Putting this here creates a 2 byte hole right after hds_threshold and 
also puts a 4 byte hole after cp_nr_rings.

Since hds_threshold doesn't seem to be used in the hotpath maybe it 
would be best to fill a pre-existing hole in struct bnxt to put it?

Thanks,

Brett

> 
>          u32                     tx_ring_size;
>          u32                     tx_ring_mask;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index e9ef65dd2e7b..af6ed492f688 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -839,6 +839,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
>          else
>                  kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
> 
> +       kernel_ering->tcp_data_split_thresh = bp->hds_threshold;
> +       kernel_ering->tcp_data_split_thresh_max = BNXT_HDS_THRESHOLD_MAX;
> +
>          ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
> 
>          ering->rx_pending = bp->rx_ring_size;
> @@ -871,6 +874,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>          case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
>          case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
>                  bp->flags |= BNXT_FLAG_HDS;
> +               bp->hds_threshold = (u16)kernel_ering->tcp_data_split_thresh;
>                  break;
>          case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
>                  bp->flags &= ~BNXT_FLAG_HDS;
> --
> 2.34.1
> 

