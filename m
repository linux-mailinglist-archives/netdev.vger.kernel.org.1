Return-Path: <netdev+bounces-196871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB5AD6BF0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E33B1891F88
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3B21C178;
	Thu, 12 Jun 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WGThCpO+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39772F4321;
	Thu, 12 Jun 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719749; cv=fail; b=Kyk6jkVOcN8nXsLdwMcHk2CKg+w3vu02Owm4R1GHGlLJzskJgqB1AZotFc45tHf30VYMJvok2ZucdEzTGysNjXazuieTtEE53tNtQUvWL9qDQ/Bzz1dQ4lVV0oxQKxNA30f6W7bsSyfZYbaxIqur81OrMoqP+2ttYQf7O9GjHvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719749; c=relaxed/simple;
	bh=Y4PzKIFP2GDc10lWm5cX30PGdqpgzBm4dquwTCxGnWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BsbL46xj5qc8OksUHnoWUTAE7z9QUfxXhtK2jF3UCVzdu+Lfvj+EZJCh5k/PqTADWUqCPhOjp+w3lUH2L/E5bnv1qKhl9tFPL3aol5Y3R+i5Nn+pc7lXLE8nFW0CNl+qs9PBaasqlMAyrZ1uA/+D2S+QxMxILPyt5UyqhbXXr8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WGThCpO+; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz6UtxKV5eI9LlPkft/0tJR7fX93U3QTEnHv3JqzKiW5mFJovB9dXWct+V9ErJv2EMTUQBZpnGz4vTaAzAK5mncUvc+9CQy5cMjF3PSWJ8nfAeLFigTk1mHeqDwdjPwhjPYDbhGTz/8XteZ3hiEqyNORtlO8deYh40YLi7N+j7VtIksYlwKYEUTU6Stmf5bBZKpWsJk3YbZ/WtoPYz3VTE0Vtk7Fa8zR2gAkd0akbliez4oMTeilXiOnwB1w00aqHevKVFgOzZ5YjyskJpngNiuHdqZA5HtccjOdjACTZtwenwltwrXqWVLvvVxEh8v6JMO3L3zrkbX6azA0r9Mhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL4pN8ksBa5oAq+OkkuqPgMCVgmamRXmYFJOl51w+8E=;
 b=fwmLSvfVRg1F9jZjNk40EUP8Ee4UQdrklWvRf8s1c0yXbSf1G+wiYkGn+Qp/7o210ZkmpS7PYw5qeUAAYjAetLl9ztwX4Bvur6OIYRMFtgsOVkL6Ag6xQDj0HwKD1W+xXWXU0nfw4pv2b/J/MJaWSLoKp5sKqrzyFL+XaYF7LXTXWlG49iBB1HQ5VIbkvDRBCdDelHi/6g/VO9XVk1uMab/bxNOz86oLvDv2Wt9TvOKLcTz7KUcqwGBhCi68yxgm+Rze/5g6i5e/Hjx+5c8yVjZ5/Fo/XqggDRcoJq2RXTR/USXXkera2r70WanpPNgjIm1Px6pA+iWqbR6/uxupOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL4pN8ksBa5oAq+OkkuqPgMCVgmamRXmYFJOl51w+8E=;
 b=WGThCpO+veIPSo9ZhVkcuh/aaf9JAaOxru9cyAukxeLIsDxIBcZej7SFJEZ+1L5nuIJs2Jy+qfik9o/3wBwR7TOr84MoOevyAtevgkXtnyTyChE9Zqdb9JiX0WWZDPO3fZjT9O9fWmSLBkK6Gg4kno0N0f9W49c3jWYYRWLAiSl1mdxT1jw6cFzM3ppxSwOQd/tSJR4i4MJNhXKXgPzVaAz7A8CPkHxC4fRB9YXQYXTChvq0m7GD5I9NzS1LNxqLbctlonDwRcFi3C/IsKmgMeMTmgJGK6Ep/4llmFPbYnMukT6BQtQeV2wqvwWBulAmyFVA8J8zAifgVzmSUq5kvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::994) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 12 Jun
 2025 09:15:44 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 09:15:44 +0000
Message-ID: <60e0e9f8-36e6-4605-a5a6-a8e6fb2e8cfb@nvidia.com>
Date: Thu, 12 Jun 2025 12:15:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ptp: extend offset ioctls to expose raw free-running
 cycles
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Bar Shapira <bshapira@nvidia.com>, Maciek Machnikowski <maciejm@nvidia.com>,
 Wojtek Wasko <wwasko@nvidia.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Mahesh Bandewar <maheshb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610171905.4042496-1-cjubran@nvidia.com>
 <aEj4Fp05_lTdMgu3@hoboy.vegasvil.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <aEj4Fp05_lTdMgu3@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd377ed-4d17-4496-59f7-08dda991b596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUsxeUFqU1lrZUZKdmpKS0gvUml1cVJpZm1ZanZFT3hUWFNuNXN2S0VWNHB2?=
 =?utf-8?B?YnFlVURrWVM5N1RLcGM5L2RLcHRWcFV2OGkzWTJkYzh3TTZiamd0MlQvMVlM?=
 =?utf-8?B?VEJVNE1ka3NCc2hzVkljWi9hdkFxRVlKUFIxSFdZQ1hyUnQvbFdGcjFNdkNE?=
 =?utf-8?B?Y3E3OTk0VHpVaW4vYVpDVERWZXhTUG8rWjBvbGNVaUI1cW9WUENRZHFaV1p0?=
 =?utf-8?B?ZkdRLzFTbmt4UVg5RTRyaXkwV1ZsWjVMTnFjQ0dqVlZQT0tvNzg3eWlZbWlR?=
 =?utf-8?B?Q0F1Rlhya2R6WWFBYmsyaEExSmJvWTNFRC90VERiN1JoQVNta1VFYlFoRm5P?=
 =?utf-8?B?OVFwY00veVFFbjdOdW5aak8wZnEybkxsWWV2Q1JJZ3lIV3orNm1laUoxd2Zp?=
 =?utf-8?B?UitYanVVZUFmeHQ4Z3RuVVEzRDNiclp2alpHVWREeC9nRXpGSmlRODJ6bmxM?=
 =?utf-8?B?azdheERHRWNSZnlnc1VhUzdvcEd2dkRuK3pza01nWjRaODM2K0dRTktSRVVh?=
 =?utf-8?B?T0xmOG5lVXpsemk0REY1MVdIWFJoY0daRHUwK2ZxS0RQMUFkWnk3ais3TDRF?=
 =?utf-8?B?d1dXOTUrNzNTZEd3VHBaYXBxRFFiN3ppSlRlcUM2a0VCdFdma1BocUtORlhq?=
 =?utf-8?B?M0FmMGkySElyWHBXM096aVJuZVRRamtoOEZLUnlWU2RBbCt5QU1MakdCMGIz?=
 =?utf-8?B?OWlDc3p6WmNPT1lWK2FZUzFDeTBkQVRsWGFGR1g3WkRBWjhzUlAzUm5rejNN?=
 =?utf-8?B?cnJ1M05weDlsMFBjOGwzWUlOMGtJZWtvQ0dCOEQyTi9IMkl5aFBZS3RndVpy?=
 =?utf-8?B?cE9kMjdsWVlmY1c4TG9IeUZZT3Jjc1JHWWI1NE5zWmZjNlVxYkRqeE9ubUkr?=
 =?utf-8?B?ZTZSK1ZmeXFLZGJsazU5WlMrV05DT3JTNUtKRzhTbERNajVsWXYydkJuMFN3?=
 =?utf-8?B?Q0F1QnNqNFNzaXNLVmo3Nk5VdEtONllUK0N0Wklja2ZsdnlEc2JsWWVmMThE?=
 =?utf-8?B?aWZ1UDBQWFkxdXBWNmtydVFNb2pRWkRVeUpkZm5DRWliOHdRT3hSZTQxQS9y?=
 =?utf-8?B?QmRMY3FnK1JlcFpTQWxMaWpwUUFkZjdnMWdVMlZqSEJuT3hoMFJOMm15Q0sz?=
 =?utf-8?B?YmNsRG9sZmw2Q3IvRTdWaDNVd0l6RUdoZkdKbzNPNmxDVWhVem96bzBGdTg2?=
 =?utf-8?B?T09nZTI5YUNoOVI2MUdtWk04VFFZdWtuV2ZPQ1VhWFM1Z3ZycHJ6Um95dTZC?=
 =?utf-8?B?dGJYa3hWbFRLYUMvSVJubmc3NE83dENEZklxeWk4RHZIdHQyRVp5NHIzZVNS?=
 =?utf-8?B?eTVXVzl2cGtLWEs0K2JHTHF2dXpOVXRGVG82Q2xQSFVha3NqbDFoMGJFMHVV?=
 =?utf-8?B?dUFteURmdnBrZEQ4ZFoxYnd5TUlwUGFCOUJZWTZiclVJNG92aVJyZGY5SENJ?=
 =?utf-8?B?SmE3cUUvOUJ6TVFDZFoxUW9uR1FYdVV6Rk9iTG9tcGw4NEMyaDQ1YWV2TzNR?=
 =?utf-8?B?ellZVm91d3cxQzlwNUtISE9YSk54YlhtZTFuMEtEK2ptUkRVNjJ1N0Z5RVhN?=
 =?utf-8?B?NDlQdmsrUDJIeDVocGJoaTRSczhwRDlPQVUrUDhERy9BamErbTZDR25ieGxl?=
 =?utf-8?B?T2lCV2UvaUQ5eTYyZlJJZkk0NmVYdmFjUTI0Z3JsdExSamRrNlVCV21VTmNR?=
 =?utf-8?B?R2ZOUzZuWVY0elJKMFFXTUF3Tmpwbzk5Nk5UbXZNT2RtT3FpenJ2dVM1Q25N?=
 =?utf-8?B?QzR4NzRPYWNyV3NUbVZqZk4rZjVnbUwzbDZyWllyYnJ2WDhsZldwMW1vam5j?=
 =?utf-8?B?Z1E5ZW5XbmtXRDZzcWt5VmtGcVFyd1dHeldIWkxnU2RqUlhwK29tTXRvV1U4?=
 =?utf-8?B?RnBtVTh6aEdmdzJ0WVIySkRPcVp2RnNNUEtkUS9HUks1M1h3K3dQaXdlQjRo?=
 =?utf-8?Q?h0O06Kg9Z8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1lQQnJUc0pJUGJZWmtzTFZ6RW9OTmxvMlB0TjlZYjBPdmpnMzNoM2xHUFNi?=
 =?utf-8?B?RUMrMldraDkxbzcwT0pJMWFHeGE5dDZPUkNDemQyazlKVXZlYXFzZFBNVlN4?=
 =?utf-8?B?VHpyZmdyL1hlTkNaQ3k2cmJ1R1ZCSDFqZVdYTHZEL2JkdGg5b3FPajUvY1p2?=
 =?utf-8?B?RXJSRzMxRDI2NExUcnd1c3o5bU1qVGdaOFg0SEI5bms5dXVKRnZJMkdRN2V2?=
 =?utf-8?B?Z0pwWHlhcHAweGJIN09TYUtyWnM4NDRzQlRBazVEeDJ5dFRObUY5LzV2RjAw?=
 =?utf-8?B?NEN3ZTA0MEFPcFF1dDVVS1l0ZGlqWmZzU1VtVUUwTDhOSzBickh4aklQY0o4?=
 =?utf-8?B?cWhlUk5DVzBIM3hOcXRaWU05cjVtbEJpRXpMbi9zZUJZQkw4N2x3MTJ2OHZ2?=
 =?utf-8?B?L2xQbkJuVzkrM3czYmpWNW1kYmV6NG51dThzd1BzZkd1TmkwNU9yNFllYTkr?=
 =?utf-8?B?TTBqa0dtMmJiWTdvSWFpYTVWUUF6amptZHFtOU4rZlNCZHFWZldmOXhBOXIr?=
 =?utf-8?B?TnQ0L2lCNkM1NHRmSEFJL3dlblRRYlltZnRFZkpNN05hSzdXNTV4aFVaM0x2?=
 =?utf-8?B?ME9pdG9xV0t1TDVsNGNnT1YyVjE2QmFVMXZtcXRTMEhuRlVRblNrajdOaUFs?=
 =?utf-8?B?cmtZYTdXYTkyMm00WE0vaGsveUM0TUZmNzhoZUdISVEyenNNd2ptTFdWQTF2?=
 =?utf-8?B?bktINzdlRUNlU3ZPYW1jb2gveG9QV2c0NUw1TDFVQy81SFVyR0tkL2ovcW5Y?=
 =?utf-8?B?YmpYV1ZRWVJMcmpsYWZyZ0Y2dy8yQnlqQjJZdWtSM2pCYUZmanJ4QkpNZUY1?=
 =?utf-8?B?VFVNNXAvRnhoNDF6ckcvVFN2V1hyVmFZRjM2MzhXVWNNM1NEZTVmNldCbTZB?=
 =?utf-8?B?clk5ZFZPby9LUHl2VUhTaG9Ib1VKWWlxVEtZR29Cc0lNMWY0NXNLdUlTMm1s?=
 =?utf-8?B?dFZRd0lpcS9rRzd3c0daKzMxZHRGRUNFUU93b243cVJUZ08rNVp1c0QwNFlN?=
 =?utf-8?B?aURoS0tlWnFMbHJnblNkNVlmdEo4NC90OW11bnl0YjZpaHp5TDNKY0N3TGx0?=
 =?utf-8?B?dUpoVlcveUw4VWVpK0tybFZaYS80aHBRUjNHNldKa3NPT3lLd0ozdG0wbDBJ?=
 =?utf-8?B?U1lUeDFVeDNkdTQ0bDV5N3kvVUJ4QmJRem1qVC9rUWtXbm9uam9Lb2ZmVnI3?=
 =?utf-8?B?cGtpN3YxanI3NUgvcXhzSjNoSkxETkdBRkhaM284MDVyVUlneGNEZysrMHYy?=
 =?utf-8?B?SUY1LzEwR3RNdVBuK2gvbWQ3dnlvZjM0Zk5KbHk2Y3hxY2JkZnBWR2psZmhG?=
 =?utf-8?B?bXlzaUJWUktnWDZObWx1UUNqMDl6T1FES0hSVWx1NlY2VDhmNjhTT2RzSy93?=
 =?utf-8?B?bTZaVDdyK09DNGNzWWdKejUycXFLdy81c1R6bExyZlI5cllBOWdBMDlzRU5p?=
 =?utf-8?B?cmx1T3dhdDcrTVc0dGhLRTRiUUU4NWI0WDJjQXBROEtaNG4wVkJySmVEOVpr?=
 =?utf-8?B?bkpwWWRDb1pBL1I1bTFCUWJpV3hjUUNtOTlmaFhlekRFQjJ1ZzJRNXZKUlhB?=
 =?utf-8?B?Z0hHc3R4VXBaYTNQWXRqa3l6WnJTVEM0eWVqajJMMS9FLzFqWW1GbEY3MjVW?=
 =?utf-8?B?aGhWUDlhSUc2OWtPd2krYlovUXFVVmdoQ0lsVnpTNGRHdHpwMDVLbitTUnJs?=
 =?utf-8?B?THJ1OXVpWElZcS9RYm5CcUFRQllTSmtOVjVZcUt6ZFNjR2ZQeG5PV294Rkxo?=
 =?utf-8?B?d2xvMnpMdVRWdmxWTzFEa01HOTgwN2dzZkZ0SWtNcFpuZHN3TXFvbERUUkda?=
 =?utf-8?B?d3VnMW5rZUhBbG9PUEdSRW14eFp6bzdaVTlBdWxpbkROSFF2Z0QxUzlxUzg5?=
 =?utf-8?B?K1FKNEpWSFBFdWR0SDI0ZC9HRnVDK2ZBeHYvenRVMlRUcFk1bDRUMzduRTls?=
 =?utf-8?B?RUxmRjh0VlhpVWtGVmFrVGQ2aGVmQXJBam9JMVh5eXVhcHd3Qlc3ZTZGV2dP?=
 =?utf-8?B?amhIdjhVb3dhVFB0RVNRYXVJeFNWdEZySVljU01QeGpqK1ZYNGJvVFBNU2tu?=
 =?utf-8?B?dS9yZ0hteDF2RUVyV1JoeE9UOVhqVkVoK0YyaHpaMElRRWhRK08zdy9CSFpw?=
 =?utf-8?Q?puPCmyyyaX299jpipDOs/1Oln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd377ed-4d17-4496-59f7-08dda991b596
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 09:15:44.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx6khbGK2nmIbhg/LLMcdgsVt6rFz/AiNuz/1Pr517J4QJnnMOrbS3NFcvvAg2De38Er5vZnD8ostZOGtIAoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D



On 11/06/2025 6:29, Richard Cochran wrote:
> On Tue, Jun 10, 2025 at 08:19:05PM +0300, Carolina Jubran wrote:
> 
>> @@ -398,8 +423,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>>   			break;
>>   		}
>>   		sts.clockid = extoff->clockid;
>> +		cycles = !!(extoff->rsv[0] & PTP_OFFSET_CYCLES);
>>   		for (i = 0; i < extoff->n_samples; i++) {
>> -			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
>> +			if (cycles)
>> +				err = ptp->info->getcyclesx64(ptp->info, &ts,
>> +							      &sts);
>> +			else
>> +				err = ptp->info->gettimex64(ptp->info, &ts,
>> +							    &sts);
> 
> ugh...
> 
>> @@ -86,9 +111,15 @@
>>    *
>>    */
>>   struct ptp_clock_time {
>> -	__s64 sec;  /* seconds */
>> -	__u32 nsec; /* nanoseconds */
>> -	__u32 reserved;
>> +	union {
>> +		struct {
>> +			__s64 sec;  /* seconds */
>> +			__u32 nsec; /* nanoseconds */
>> +			__u32 reserved;
>> +		};
>> +		__u64 cycles;
>> +	};
>> +
>>   };
> 
> This overloading of an ioctl with even more flags goes too far.
> Why not just add a new ioctl in a clean way?
> 
> Thanks,
> Richard

Hi Richard,

Thanks for the feedback. I will add new ioctls and resend.

Carolina



