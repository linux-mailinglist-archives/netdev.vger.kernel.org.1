Return-Path: <netdev+bounces-100314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF98D8837
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E741F21D67
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3228137924;
	Mon,  3 Jun 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="beEn81V5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464420317;
	Mon,  3 Jun 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437217; cv=fail; b=XkV0nyN6qNqOOYoqYHNOUlJd1J0Ny2mMA2eyfWXm8mUY74lGUPvs52kXlBXEjhgNd42Wo0K38Bwq9MepKrsRFAbjvFUDkLpoZZ4L8bjyPZYoMdyV4d6+AI7xAiDRPvoRNDc0wAy3Y/f0qIFfPvlie+wLJOlbcnWxT6LlATxQqb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437217; c=relaxed/simple;
	bh=4gMDzO1CK9LDm9El8tLLRrDDT3IICi9P+MnQWJQYUS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=plS3vg/sq6dVn+PLVbh3oA/FbfJ6rI0zevjgvXk+2C15pXLAmRh7IXWwVLWMQl2lDHHbd+b+PI9aFA+IvwmzIdX/UQWpYG27v85C/2hw/quOWzS8vOi/4KorHGnfYrzqUy2zLZBzVx0T3ft/RkAoemJY1JOxE4Q1h5eA7dPWyL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=beEn81V5 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.237.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evUudp6SZEHJrwF1PCqhYdoHlDBXgBzHZvGtvBu/OtoRJl37Vfl3FTVVCKapMsp5g2b+1oaSfKTypUKqn+GuPHsJ9q+aD+IgV8aYfQytH9xsg4EJiftIK5YkjYKAJKChYvOAdq6EPvdj9EIo22z+5gYOtWEXp7PcY5nUoQhUbMn6N2cEauxJoKWv+7UZL1kBfbi436kIiq3+P6r+87lXOqcEwr3y72QtYqykzO3yE1UoSyAn31yaRQJezmpAlZOlIDHqLzgKnJN7AfuIKcpZ2qwl4rcKgRQ1bbtVoPy/Zkg8QgKhPX1yaHGmrqhCosec7y0BjmaodwhyNzFIxdjQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmNGMD0Z2EqUHUkXNsv9+8hzOjbPO4plKDaDFkqxctI=;
 b=kVu4n5w1jS2JBmY03LtPwZpDkzRTRVRqCNTDYoVYsnEj8qpaMjxUM8XZMEZuVcN/xlS9FcYmBZ7YuQPXPqjwwbO5uY9ZnRILTc1krIpJxGnVcbZSHi4V7TMk4mVsmG/IZbnvFf+BRZa/El7Un3GA1QgnIJ+82KarMUc3iuwfzmoO/gQrws9YFK0F7fZX7k+3kAfNNyBV6il48zoQ1rtgeOfkXfqrWuhqGXN0uQfWIQmXQ4b8mNMMPei2+VW09ftlErcSejsyd47ErogXIiNbuyDMqtNliYhr6Xf7hh/IYlDVXGAOMbuYzYp3XbOucMw3t5uB61RDwc4VmugYj9qkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmNGMD0Z2EqUHUkXNsv9+8hzOjbPO4plKDaDFkqxctI=;
 b=beEn81V51LTswUELUUdZ2juXK7hCumMEWp+uGxlUcGGQy+FeQs/j8256Muq2jsng4PthR4jsEkdzMFZtSaDcsLgOgt7kHQeWr77TNLs4u1xYXkNC2hmwH0u2FtFU0zmGvGVS5IfsBAZRqprbrOpUh+cedy5rboyoF/98cRD1OeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BL3PR01MB7180.prod.exchangelabs.com (2603:10b6:208:347::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Mon, 3 Jun 2024 17:53:32 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:53:32 +0000
Message-ID: <1a38b394-30ae-42c6-b363-9f3a00166259@amperemail.onmicrosoft.com>
Date: Mon, 3 Jun 2024 13:53:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-4-admiyo@os.amperecomputing.com>
 <6a01ffb4ef800f381d3e494bf1862f6e4468eb7d.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <6a01ffb4ef800f381d3e494bf1862f6e4468eb7d.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BL3PR01MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f1d3cf-670a-409d-8edb-08dc83f6152d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkdkMzRnQis2NjhNMzZXbi85TmErbDdXMExoT0ZYQkM4a2FoRUpiSDZOYUs0?=
 =?utf-8?B?M1RDTHA5bnVaRVZXY3pCejZqQmE4cURsandGa0FUVzlSUGpwVHhJNFl5WlVm?=
 =?utf-8?B?U2QxRm5ob2kwU0Evd04waWhRZE5paVJLZkNVUms3VkFSc0lnRFUwVUFYSnNj?=
 =?utf-8?B?L01XZlZIamRCUi9DTzR2QmQ0MEJzclRjT0tGS25pcW5MaThER2JzcXlOR2dh?=
 =?utf-8?B?U0lGaVpRaGlxT2FBY2MzMlUwOVdVQzlXMU1obHVCMjFNdkNqSXBDTU9yNEdU?=
 =?utf-8?B?UGFnMGVIK0lFNFdRK1pqRjZ3NTN0ZG4yV2M0UXFGUUMzSWJtNVJRcDJRTHlL?=
 =?utf-8?B?YVRnSWhEQUFGWEhVMGEvOVJyZ0V3c2g1NjNmelRzOVRDYlZPdy9oWWZyTnVF?=
 =?utf-8?B?VmdVcCtHZlNBcjFRZytwTEhqbFBWSGxtRlpYLzZQRVVpZGdCMHZhalVrRjV5?=
 =?utf-8?B?bzQwU2tPNkVJelEzODV3Tnl6Sk1HWTc3SCtxdTYyaGZweEl1anp5bjBIT2xN?=
 =?utf-8?B?OW50c0RQOTd4d3NxVGNIUzNFbDJyTmZLVElaTEpDN1hQVU5NTkhTRzdWNFhU?=
 =?utf-8?B?UHhoOUZYM1laREFLSnQxWlVZQm80eEI0NU5teXExRUlQd0xrK0JYdlZ1NDBF?=
 =?utf-8?B?a215dW14SGlmQVhmL3ZpaUM3cEl0RDR1S1VpdTdXdXc3QVZkRFh4SGpEMmRa?=
 =?utf-8?B?TGhudE9rTXEzZE9GcWl2STN2c256MlQzMGNJMmlwWEJkUmJvaFMrcFVBZmNn?=
 =?utf-8?B?RDZmMlhYdVlsSDdsRG9hbUdrOGpDWGJ6aEZiUnAxYlFZOStBaXhpVEJZeXM1?=
 =?utf-8?B?eFhXZ0xERHphb2ZsczYrdXFLcC9Oem5Qb3R1bWlFd1hYUUNwUlNNcHF0eXhR?=
 =?utf-8?B?TDFKV0pvaGNqWEpEbnYyT3dMQTIrbVhJcU5aSk1jdjVrUnNJNFlUVTJ2UUJr?=
 =?utf-8?B?dkxvdnQwM2JBQ3pyZXdEanNBanZWUEtzUXEzVDg0MU5nODBlQ3M3YUh4ZzEx?=
 =?utf-8?B?RTlSQ3lzR3h6cFVFNlJLWmxlZFk2QVpleHNuQ0ZRdUoxTmpOVWt1ME9lb002?=
 =?utf-8?B?R0QyUHFBOVBSd1hOTjUyckdWd3VyaXNLb2NvYU5OZE1CemloZFJuR25IaGdM?=
 =?utf-8?B?OW9hMTlNN0VlRlpBTGZXTHJVVnJzNENMNWY4QmVIZFJldUpLM0NzSUhYN3VQ?=
 =?utf-8?B?S1NPcFM2Q3hlOE1aam5zRHBnRSt3cEQ4YlVTd2szZzQyM2xIem8vUmpuNEZz?=
 =?utf-8?B?UytLU2lGZHo3ZUkvVGQyOWMvNUtzQzNNWlo1WXdhSU1Gc3RCWndzd2JZRkhk?=
 =?utf-8?B?RXI1NmYyaHUvZk9PUDdoYUpWNDYzMkNzRnhzb042SmtyY1VDTmNpbkRiSElY?=
 =?utf-8?B?SThtOVFLWWtrTTZuaEE2K2hjS0x1V1dKOVhuWUJobW4yWUNsRDZqRkdSZ1dn?=
 =?utf-8?B?SkNLbGZ6S2REUHNFNklFaGJaNkU4L1g1dXFYNE00aW5oeVRYMkJKN2grV1o5?=
 =?utf-8?B?OVQ0NHBQUWQzWkU5dFRnZExKd1FKVk1GVGJmNVVMM0lkQndhTm5SV0NWN25L?=
 =?utf-8?B?VERJZzVmeGlwUHFLd3JHSFBETkd1dUVJaDFzY0JSQXl0Q2NaL0FyMXVVdEFs?=
 =?utf-8?B?VFFhckR6SUcxYmFmTU5ZbEhCTEVraUJNMzM4MlljUUtSUUNKVGlZajZUYnhJ?=
 =?utf-8?B?N0xZeFVFc0Q1R3FhWFMrM0pJS3ByRTBoMzdSc2c0bE5TTjIrcDBQNCtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0VCRGFDV2dKeHM3TU4rZ211K2c0KzZEVWJvWHNFU3FlamlxNDBLWVhjbkJk?=
 =?utf-8?B?VlZTVzhhbVgyZWIxcyt0dk10V2ZZdVFrcnllZkpBT0VHRFUvVk5yQm9pZjRq?=
 =?utf-8?B?N3pvY2JvN3ZoUTk3Unc1dnB2TVpiNjlsWVpxRmpPcFNhTzcrZS9BUlhvcGIv?=
 =?utf-8?B?TlBINDZ1K29Xd0xyT2pVcHFnc0I0RitZeXhVL1ladHlBM01oMGRNNVpHQ1or?=
 =?utf-8?B?TG1HNEQxMTJaeDM5eXNGZEswc2xQa2Y5cFFiMGQzWkthRENrdHdJL1hjM0ZB?=
 =?utf-8?B?SUxlSXVyOEcrbitYaWFrTTJXY0h4U3FjNHlsVzNObEJ2a29KUzA3eWp5eGdq?=
 =?utf-8?B?UE5kdEdHY1YzMXVxeis2TTdWRElld1JTU1NUTlJLY01BbitGaFMyM2pweDda?=
 =?utf-8?B?NnQrTW1VaDFOSmhQcDZrcFFlM0dPV21JbU9URVZHN3poTnhGc0ZmMUR6RGcw?=
 =?utf-8?B?d1VqQnkrNWpWVDRySzJacnBSRkRRWEIyTE95M3lYQ1ZUclFkWnZ3aVRhRVpU?=
 =?utf-8?B?ZDg5Y0h6Wm5EZ2t2Ly9pRjNPL0JraWFRWmxDNFFMOHFoTkZBSjB3TkJVUU51?=
 =?utf-8?B?YXhibHlvOXJ1OFppeitrRUJONXVGaTJhQnJsMTZtZXV6TUhlS1krMGM4WFhn?=
 =?utf-8?B?VFNVVlFrdzBQZ2lNcC84alFtcmtNUmxxcWYxYjJUREgyRHdRTlpXTGUvTVBQ?=
 =?utf-8?B?eTN4OHlYaXNKZ1dOM25ySC9sOC82SFoxZDlITWgxdWpSZmxVdkFNdWhJRFBq?=
 =?utf-8?B?T2kvRWRYT3pXYWZTcWJITVl0Rlo4OVI1YUdCSDl0VUwwYVhaVHloSzdtNmZG?=
 =?utf-8?B?MGhhaUZKZWIyNzFaaDJlbmhLMnJGQWcwaWJ3bUtJWkVBZWxDN1l6VWhIbzl4?=
 =?utf-8?B?a1U4c0cyY2lHNEF2UDdRRll0WXQ2ZFNqekptZzhWYkppL3c1QkxhYW44ZzJw?=
 =?utf-8?B?OFR1UTZsU3lveEx1MG1rMHpES1pZdStyT0lIU2JVUzNoSDlSQ3lIbFdRZXZD?=
 =?utf-8?B?UE5wd1VRT1MvekJEYjBFQmM3RC9jcDEwNUhkaUhhb0pNUG4wVjdmazBUMGJi?=
 =?utf-8?B?b3FubTVuanZFYWlmR3UwL0dPUjVBUzNUYVp1aW9Lek9rU1phL1hlSDRYcU1y?=
 =?utf-8?B?d0FITHA2RzM1NThEK0hiNzBXSVNPN3g5UXN2SkwxbFpIbGVFRFExK2JaU0ds?=
 =?utf-8?B?NnNjOTZFenhKMG0rZDZYOHNmRW1ZL1phd1RsS2djWEFzVEpWZlZqM2Q0Z2RB?=
 =?utf-8?B?OEtqM3ZQRm5XV0xFcUwyamxpU1VZU2lGbjFGKzlCd3I5K3FQNDQ0dHpMTGN4?=
 =?utf-8?B?byt6RmxGQTdlSWNnZnZ6NmtnanByRFpXYmE0UW1jcXI5empzTXR2TUU2cXBM?=
 =?utf-8?B?emE4R050QkJld2l1VmxkbktVQzlLNUs2QjFVRCtXTVczZDJEY0ZhNXRCdWpR?=
 =?utf-8?B?UE5KZklpVTJkQVhKSnYzc0w0NFE4aGR2MFZrbWdCVllwMlhSM3Q1S01SbktK?=
 =?utf-8?B?cW1KTHZWdU5zWnh2a1UyaXZLRkEzUWhyN291NDFNNGdmWDcxVFFTSkVOWkhT?=
 =?utf-8?B?bW05N2g5cnJBdGRidW1hNmhjQjQ2ZUpBK3E4TnJIQ1V2aHZhSm9PNGVsOTBk?=
 =?utf-8?B?N2FDK0Nrb1dsN1drd2IwK0VxK2R3UjNtYUFOOFNnSnpUL3RnM1dPSk1NemJH?=
 =?utf-8?B?RjMzNE1LU0ZXN05rb2FZeGI4MVBiOElDZndmY0FFSGV4Wmw0M0k2QlFUOTR4?=
 =?utf-8?B?VVFTdUZmL1ZocTZpYk9Xb0VtVDU5ZVFFMzR0eE9wVHQ3b1d4RWYvdlQ4S1Bk?=
 =?utf-8?B?WXMxRVlIQWQzMEs3b2I3dnlrbnYrOHU1NnFrYkFsT2dHS3kvQ0lNc1hocklr?=
 =?utf-8?B?WXhuL1JsUFVHNTkxNEtNTTQ3NHJPOGlKZnRZTkowU0x2RTk3ZXgyeXFha2wr?=
 =?utf-8?B?UDBZS2ppeVpZY0M2RWJiMHo4cnl3QWNvNGtweTN3eFA1NjhBamtTTlh2WlJN?=
 =?utf-8?B?bHV0VENVOG1sV3ZpSUFkN1VRbmwxWXdrV1ZUdU1Fa3dCNVRQbElLcWJCbjBP?=
 =?utf-8?B?U09UK0ZkSUtwZGw2SHl2OTl2ZGlRRU1CeTAvN1p3TFlWc3pMR08za1g4OSti?=
 =?utf-8?B?ODNYeW5na2FpZG1VeUpzS1k4SmhUL0o0Sk1PeUs4L09INS9mbEw3R1NpTFVK?=
 =?utf-8?B?ME9oOVgvMzJxUzRyTXh0SUxDdDFwUCtrUzJPWlVETnFaaFp4Rnl0aDFqK2ht?=
 =?utf-8?Q?7S16FNhwK3hf+KMpWXpQwolisH/zaU3O1qjA95EAso=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f1d3cf-670a-409d-8edb-08dc83f6152d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 17:53:32.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jIZTnE2uOc2tck3j7fmBuq2cyOPrWeh5Qn4GoXL5Q/qTdsMBR0G+EX06HdjbJCS19UnLj2rEx5Xx/qhKAwBLVXK87lmm+VnKJ5a55iEpJxqXAj7WVPxWx2yUEMTUqiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7180

Pretty sure I have all these corrections in the next one.  Some inline 
comments.



On 5/28/24 23:02, Jeremy Kerr wrote:
> Hi Adam,
>
> Thanks for the v2! Progress looks good, this seems simpler now too. Some
> comments inline.
>
>> From: Adam Young <admiyo@amperecomputing.com>
>>
>> Implementation of DMTF DSP:0292
>> Management Control Transport Protocol(MCTP)  over
>> Platform Communication Channel(PCC)
>>
>> MCTP devices are specified by entries in DSDT/SDST and
>> reference channels specified in the PCCT.
>>
>> Communication with other devices use the PCC based
>> doorbell mechanism.
> Signed-off-by?
>
> And can you include a brief summary of changes since the prior version
> you have sent? (see
> https://lore.kernel.org/netdev/20240220081053.1439104-1-jk@codeconstruct.com.au/
> for an example, the marker lines means that the changes don't get
> included in the commit log; Jakub may also have other preferences around
> this...)

They are all in the header patch.

>
>> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
>> index ce9d2d2ccf3b..ff4effd8e99c 100644
>> --- a/drivers/net/mctp/Kconfig
>> +++ b/drivers/net/mctp/Kconfig
>> @@ -42,6 +42,19 @@ config MCTP_TRANSPORT_I3C
>>            A MCTP protocol network device is created for each I3C bus
>>            having a "mctp-controller" devicetree property.
>>   
>> +config MCTP_TRANSPORT_PCC
>> +       tristate "MCTP  PCC transport"
> Super minor: you have two spaces between "MCTP" and "PCC"
>
>> +       select ACPI
>> +       help
>> +         Provides a driver to access MCTP devices over PCC transport,
>> +         A MCTP protocol network device is created via ACPI for each
>> +         entry in the DST/SDST that matches the identifier. The Platform
>> +         commuinucation channels are selected from the corresponding
>> +         entries in the PCCT.
>> +
>> +         Say y here if you need to connect to MCTP endpoints over PCC. To
>> +         compile as a module, use m; the module will be called mctp-pcc.
>> +
>>   endmenu
>>   
>>   endif
>> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
>> index e1cb99ced54a..492a9e47638f 100644
>> --- a/drivers/net/mctp/Makefile
>> +++ b/drivers/net/mctp/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..d97f40789fd8
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,361 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024, Ampere Computing LLC
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/string.h>
>> +
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <acpi/acrestyp.h>
>> +#include <acpi/actbl.h>
>> +#include <net/mctp.h>
>> +#include <net/mctpdevice.h>
>> +#include <acpi/pcc.h>
>> +#include <net/pkt_sched.h>
>> +
>> +#define SPDM_VERSION_OFFSET 1
>> +#define SPDM_REQ_RESP_OFFSET 2
>> +#define MCTP_PAYLOAD_LENGTH 256
>> +#define MCTP_CMD_LENGTH 4
>> +#define MCTP_PCC_VERSION     0x1 /* DSP0253 defines a single version: 1 */
>> +#define MCTP_SIGNATURE "MCTP"
>> +#define SIGNATURE_LENGTH 4
>> +#define MCTP_HEADER_LENGTH 12
>> +#define MCTP_MIN_MTU 68
>> +#define PCC_MAGIC 0x50434300
>> +#define PCC_DWORD_TYPE 0x0c
>> +
>> +struct mctp_pcc_hdr {
>> +       u32 signature;
>> +       u32 flags;
>> +       u32 length;
>> +       char mctp_signature[4];
>> +};
> The usage of this struct isn't really consistent; you'll at least want
> endian annotations on these members. More on that below though.




>
>> +
>> +struct mctp_pcc_hw_addr {
>> +       u32 inbox_index;
>> +       u32 outbox_index;
>> +};
>> +
>> +/* The netdev structure. One of these per PCC adapter. */
>> +struct mctp_pcc_ndev {
>> +       struct list_head next;
>> +       /* spinlock to serialize access to pcc buffer and registers*/
>> +       spinlock_t lock;
>> +       struct mctp_dev mdev;
>> +       struct acpi_device *acpi_device;
>> +       struct pcc_mbox_chan *in_chan;
>> +       struct pcc_mbox_chan *out_chan;
>> +       struct mbox_client outbox_client;
>> +       struct mbox_client inbox_client;
>> +       void __iomem *pcc_comm_inbox_addr;
>> +       void __iomem *pcc_comm_outbox_addr;
>> +       struct mctp_pcc_hw_addr hw_addr;
>> +       void (*cleanup_channel)(struct pcc_mbox_chan *in_chan);
> Why this as a callback? There's only one possible function it can be.

Vestige of code designed to work with multiple mailbox implementations. 
Will remove.


>
>> +};
>> +
>> +static struct list_head mctp_pcc_ndevs;
> I'm not clear on what this list is doing; it seems to be for freeing
> devices on module unload (or device remove).
>
> However, the module will be refcounted while there are devices bound, so
> module unload shouldn't be possible in that state. So the only time
> you'll be iterating this list to free everything will be when it's
> empty.
>
> You could replace this with the mctp_pcc_driver_remove() just removing the
> device passed in the argument, rather than doing any list iteration.
>
> ... unless I've missed something?

There is no requirement that all the devices  be unloaded in order for 
the module to get unloaded.

It someone wants to disable the MCTP devices, they can unload the 
module, and it gets cleaned up.

With ACPI, the devices never go away, they are defined in a table read 
at start up and stay there.  So without this change there is no way to 
unload the module.  Maybe it is just a convenience for development, but 
I think most modules behave this way.


>
>
>> +
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_dev;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       u32 length_offset;
>> +       u32 flags_offset;
>> +       void *skb_buf;
>> +       u32 data_len;
>> +       u32 flags;
>> +
>> +       mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
>> +       length_offset = offsetof(struct mctp_pcc_hdr, length);
>> +       data_len = readl(mctp_pcc_dev->pcc_comm_inbox_addr + length_offset) +
>> +                  MCTP_HEADER_LENGTH;
> Doing this using offsetof with separate readl()s is a bit clunky. Can
> you memcpy_fromio the whole header, and use the appropriate endian
> accessors?
I was overthinking this.  You are right.
>
> (this would match the behaviour in the tx path)
>
> Also, maybe check that data_len is sensible before allocating.
Good idea
>
>> +
>> +       skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
>> +       if (!skb) {
>> +               mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
>> +               return;
>> +       }
>> +       mctp_pcc_dev->mdev.dev->stats.rx_packets++;
>> +       mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
>> +       skb->protocol = htons(ETH_P_MCTP);
>> +       skb_buf = skb_put(skb, data_len);
>> +       memcpy_fromio(skb_buf, mctp_pcc_dev->pcc_comm_inbox_addr, data_len);
>> +       skb_reset_mac_header(skb);
>> +       skb_pull(skb, sizeof(struct mctp_pcc_hdr));
> Any benefit in including the pcc_hdr in the skb?
>
> (not necessarily an issue, just asking...)
It shows up in  tracing of the packet.  Useful for debugging.
>
>> +       skb_reset_network_header(skb);
>> +       cb = __mctp_cb(skb);
>> +       cb->halen = 0;
>> +       skb->dev =  mctp_pcc_dev->mdev.dev;
>> +       netif_rx(skb);
>> +
>> +       flags_offset = offsetof(struct mctp_pcc_hdr, flags);
>> +       flags = readl(mctp_pcc_dev->pcc_comm_inbox_addr + flags_offset);
>> +       mctp_pcc_dev->in_chan->ack_rx = (flags & 1) > 0;
> Might be best to define what the flags bits mean, rather than
> magic-numbering this.
I'll make a constant for the mask.
>
> Does anything need to tell the mailbox driver to do that ack after
> setting ack_rx?

Yes.  It is in the previous patch, in the pcc_mailbox code.  I 
originally had it as a follow on, but reordered to make it a pre-req.  
That allows me to inline this logic, making the driver easier to review 
(I hope).

>
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_hdr pcc_header;
>> +       struct mctp_pcc_ndev *mpnd;
>> +       void __iomem *buffer;
>> +       unsigned long flags;
>> +       int rc;
>> +
>> +       netif_stop_queue(ndev);
> Do you need to stop and restart the queue? Your handling is atomic.
I guess not.  This was just from following the examples of others. Will 
remove.
>
>> +       ndev->stats.tx_bytes += skb->len;
>> +       ndev->stats.tx_packets++;
>> +       mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
> no need for this cast, netdev_priv() returns void *
>
>> +
>> +       spin_lock_irqsave(&mpnd->lock, flags);
>> +       buffer = mpnd->pcc_comm_outbox_addr;
>> +       pcc_header.signature = PCC_MAGIC;
>> +       pcc_header.flags = 0x1;
> Magic numbers for flags here too
>
>> +       memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
>> +       pcc_header.length = skb->len + SIGNATURE_LENGTH;
>> +       memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
>> +       memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
>> +       rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
>> +                                                        NULL);
>> +       spin_unlock_irqrestore(&mpnd->lock, flags);
>> +
>> +       dev_consume_skb_any(skb);
>> +       netif_start_queue(ndev);
>> +       if (!rc)
>> +               return NETDEV_TX_OK;
>> +       return NETDEV_TX_BUSY;
> I think you want to return NETDEV_TX_OK unconditionally here, or at
> least you need to change the queue handling; see the comment for the
> ndo_start_xmit callback.
Will Do. Thanks for pointing out that comment, would never have seen it.
>
>> +}
>> +
>> +static const struct net_device_ops mctp_pcc_netdev_ops = {
>> +       .ndo_start_xmit = mctp_pcc_tx,
>> +       .ndo_uninit = NULL
> No need for this assignment.
>
>> +};
>> +
>> +static void  mctp_pcc_setup(struct net_device *ndev)
>> +{
>> +       ndev->type = ARPHRD_MCTP;
>> +       ndev->hard_header_len = 0;
>> +       ndev->addr_len = 0;
>> +       ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
>> +       ndev->flags = IFF_NOARP;
>> +       ndev->netdev_ops = &mctp_pcc_netdev_ops;
>> +       ndev->needs_free_netdev = true;
>> +}
>> +
>> +static int create_mctp_pcc_netdev(struct acpi_device *acpi_dev,
>> +                                 struct device *dev, int inbox_index,
>> +                                 int outbox_index)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_dev;
>> +       struct net_device *ndev;
>> +       int mctp_pcc_mtu;
>> +       char name[32];
>> +       int rc;
>> +
>> +       snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
>> +       ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
>> +                           mctp_pcc_setup);
>> +       if (!ndev)
>> +               return -ENOMEM;
>> +       mctp_pcc_dev = (struct mctp_pcc_ndev *)netdev_priv(ndev);
>> +       INIT_LIST_HEAD(&mctp_pcc_dev->next);
>> +       spin_lock_init(&mctp_pcc_dev->lock);
>> +
>> +       mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
>> +       mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
>> +       mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
>> +       mctp_pcc_dev->cleanup_channel = pcc_mbox_free_channel;
>> +       mctp_pcc_dev->out_chan =
>> +               pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
>> +                                        outbox_index);
>> +       if (IS_ERR(mctp_pcc_dev->out_chan)) {
>> +               rc = PTR_ERR(mctp_pcc_dev->out_chan);
>> +               goto free_netdev;
>> +       }
>> +       mctp_pcc_dev->in_chan =
>> +               pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
>> +                                        inbox_index);
>> +       if (IS_ERR(mctp_pcc_dev->in_chan)) {
>> +               rc = PTR_ERR(mctp_pcc_dev->in_chan);
>> +               goto cleanup_out_channel;
>> +       }
>> +       mctp_pcc_dev->pcc_comm_inbox_addr =
>> +               devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
>> +                            mctp_pcc_dev->in_chan->shmem_size);
>> +       if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
>> +               rc = -EINVAL;
>> +               goto cleanup_in_channel;
>> +       }
>> +       mctp_pcc_dev->pcc_comm_outbox_addr =
>> +               devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
>> +                            mctp_pcc_dev->out_chan->shmem_size);
>> +       if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
>> +               rc = -EINVAL;
>> +               goto cleanup_in_channel;
>> +       }
>> +       mctp_pcc_dev->acpi_device = acpi_dev;
> You probably want the link back too:
>
>            acpi_dev->driver_data = mctp_pcc_dev;
>
>
>> +       mctp_pcc_dev->inbox_client.dev = dev;
>> +       mctp_pcc_dev->outbox_client.dev = dev;
>> +       mctp_pcc_dev->mdev.dev = ndev;
>> +
>> +/* There is no clean way to pass the MTU to the callback function
>> + * used for registration, so set the values ahead of time.
>> + */
> Super minor, but keep this aligned with the code indent.
>
>> +       mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
>> +               sizeof(struct mctp_pcc_hdr);
>> +       ndev->mtu = mctp_pcc_mtu;
>> +       ndev->max_mtu = mctp_pcc_mtu;
>> +       ndev->min_mtu = MCTP_MIN_MTU;
> Same as last review: I'd recommend setting the MTU to the minimum, and
> leaving it up to userspace to do a `mctp link mctppcc0 mtu <whatever>`.
> This means you don't break things if/when you ever encounter remote
> endpoints that don't support the max mtu.
>
> If the driver could reliably detect the remote max MTU, then what you
> have is fine (and the driver would then set the appropriate MTU
> here).
>
> However, if that probing *cannot* be done at the driver level, or needs
> any userspace interaction to do so (say, a higher level protocol), then
> you've set a MTU that could be unusable in this initial state. In that
> case, setting it low to start with means that the link is usable by
> default.
>
> Userspace can then hard-code a higher MTU if you like, and that can be
> adjusted later as appropriate.
>
> (this is a lesson learnt from the i2c transport...)

Ah...makes sense.  I was not sure if our impl,enetation could handle 
that yet, but it appears to,

If it can't, it is a bug we have to fix.


>
>> +/* pass in adev=NULL to remove all devices
>> + */
>> +static void mctp_pcc_driver_remove(struct acpi_device *adev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
>> +       struct list_head *ptr;
>> +       struct list_head *tmp;
>> +
>> +       list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
>> +               struct net_device *ndev;
>> +
>> +               mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
>> +               if (adev && mctp_pcc_dev->acpi_device == adev)
>> +                       continue;
>> +
>> +               mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
>> +               mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
>> +               ndev = mctp_pcc_dev->mdev.dev;
>> +               if (ndev)
>> +                       mctp_unregister_netdev(ndev);
>> +               list_del(ptr);
>> +               if (adev)
>> +                       break;
>> +       }
>> +};
> Assuming we don't need the free-everything case, how about something
> like:
>
>      static void mctp_pcc_driver_remove(struct acpi_device *adev)
>      {
>            struct mctp_pcc_ndev *mctp_pcc_dev = acpi_driver_data(adev);
>
>            mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
>            mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
>            mctp_unregister_netdev(mctp_pcc_dev->mdev.dev);
>       }
>
> If you do need the list iteration: you're currently doing the cleanup on
> every adev *except* the one you want:
>
>> +               if (adev && mctp_pcc_dev->acpi_device == adev)
>> +                       continue;
> I think you meant '!=' instead of '=='?
Yes.  Yes I did.  This is code that has to be there for completeness, 
but I don't really have a way to test, except for the "delete all" case.
>
>> +
>> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
>> +       { "DMT0001", 0},
>> +       { "", 0},
>> +};
>> +
>> +static struct acpi_driver mctp_pcc_driver = {
>> +       .name = "mctp_pcc",
>> +       .class = "Unknown",
>> +       .ids = mctp_pcc_device_ids,
>> +       .ops = {
>> +               .add = mctp_pcc_driver_add,
>> +               .remove = mctp_pcc_driver_remove,
>> +               .notify = NULL,
> Minor: don't need the zero assignment here.
>
>> +       },
>> +       .owner = THIS_MODULE,
>> +
>> +};
>> +
> [...]
>
>> +static int __init mctp_pcc_mod_init(void)
>> +{
>> +       int rc;
>> +
>> +       pr_debug("Initializing MCTP over PCC transport driver\n");
>> +       INIT_LIST_HEAD(&mctp_pcc_ndevs);
>> +       rc = acpi_bus_register_driver(&mctp_pcc_driver);
>> +       if (rc < 0)
>> +               ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
>> +       return rc;
>> +}
>> +
>> +static __exit void mctp_pcc_mod_exit(void)
>> +{
>> +       pr_debug("Removing MCTP over PCC transport driver\n");
>> +       mctp_pcc_driver_remove(NULL);
>> +       acpi_bus_unregister_driver(&mctp_pcc_driver);
>> +}
>> +
>> +module_init(mctp_pcc_mod_init);
>> +module_exit(mctp_pcc_mod_exit);
> If you end up removing the mctp_pcc_ndevs list, these can all be
> replaced with module_acpi_driver(mctp_pcc_driver);

Yeah, I can't get away with that.  The ACPI devices may still be there 
when some one calls rmmod, and so we need to clean up the ndevs.  It is 
the only case  where the module will be removed, as the ACPI devices 
never go away.


>
> Cheers,
>
>
> Jeremy

