Return-Path: <netdev+bounces-222798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC32B56225
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B38A05792
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63DD1DE2B4;
	Sat, 13 Sep 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="1yaAc2hB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137301DA60D
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779443; cv=fail; b=APlG6VkjDB675SR1mSqqzFwDeV2aZkEHZG6mVRMFv+IJrMnqpCf8Dk+sN+tA6x2l703EhwreznxRW/PMNX6BTQA4sugyBhdlxW55u96e05WKQPazeeEDAKwmbqcMWG1f8HjDK5eRWN8Njh0Tr4JQGpyECaic1hOR4+tW4HAwkFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779443; c=relaxed/simple;
	bh=BneoJwGvb7bYV2Y0bWx8b5/7dQjuoUh65ow0tIwByUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FyaV1onhiarp6IjVnO85qc1BBEDPxBtOUuVLvI095Ztd0IsM86B2SCTYxhu31ukJNzTUc3Ww62aBPHJKrF163pexpF9ld9aKh6EBP7+0Zlt1LLB5Ofl9RPTEXeeoFcyPZTbGAuwDjxo/aQ21AY9jCq8gTF2BTJEPtDkpPa/IAEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=1yaAc2hB; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1757779441; x=1789315441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BneoJwGvb7bYV2Y0bWx8b5/7dQjuoUh65ow0tIwByUo=;
  b=1yaAc2hBFPPLF85jHbOrIZgJYSf6X5n1aEOXjtDaVUXqneij07W83GCw
   whxS0b7c0+iELZy255lat3QrOSBTnXKU6qk+CD+DZGAaIYUNWppkrOtIR
   4+uPDwnHE+C4bWi77DeDjlL5M+IQHYY4sysEiMZOXbmx/ilyB8y9Tl4Fg
   8=;
X-CSE-ConnectionGUID: vooL4yFGT1OJ2q0d1qj5iQ==
X-CSE-MsgGUID: vcnfpSQCR4eLiaBPO/liOA==
X-Talos-CUID: =?us-ascii?q?9a23=3Aj4h2S2prg7ZTcXmLsI5Jhx7mUd4idVmB3Vn/Hxa?=
 =?us-ascii?q?fKzxwELHMUF3N+Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:zwI8QQZ1ZTGD1eBTqTTqiilZDexSv6mKCUknqbJBv8ijHHkl
Received: from mail-canadacentralazon11021126.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.107.192.126])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 12:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn7/lgYE2OSaFPE4Ago9K7gcDyRWBUbh6KUei4SNJdDMne/iFHsnPWW17RkV8HtnO2+/5HEnWW1kLrHKGec/9f2wzO7qVi045aktLfhs8BfDaviB7Td9fDJccLRHIj5IDd68RmUKCqDgISvMrNmsraFkwVm7f+6CzTYWZ1Ca++TVhWw3FlOGpCZKkPu63QyY7Vkeig0jBq8sBtjjsmAgkSX++EEk/jTpJwWG65U4bqXqBLc9sQg89v+/xV9TJy+6NNuYQGR84/bluIGZ5PcjnImbXE6UTcj9GDb00KEA78vhUticSF7PTvUj6kddKlHkejqEEwL8izjo2bfGAXHWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2RlXIvFM3f/FYeu5l4idZCIHTBZa48PNnafm4f6dxI=;
 b=Vlz66uKvneGIOJt4JDIxTfY2cyEk9YUqxNf/wv9Wf90UhGf7tFd6qdgn784bqeX57jWvrAwk0ffQPYJPw/+iQQGlRSRW79x7YXHPXEOk3GQQ1ev5JyrzR1kIjAvIdlmQFQcmdiMY5A/zu8yHFTLDSdB61grkEhuKKcavi/SvgRKdl/XbUwoWS84bo90VMajzZo8y9QrTW6tXhiJcJa+Ynxopuxx9uOvqaOGpV7mNaNJBFosmRqqfCKJvIwMQ2760SnpyiDwr7e0RjdFUgADdTgRHmLNzM2nAjqlNydvxLDQDfrLIrBputkvWZ4KPKEb+og4afFXWHx5k27nnFQsuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB9753.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 16:03:51 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%4]) with mapi id 15.20.9115.018; Sat, 13 Sep 2025
 16:03:51 +0000
Message-ID: <727f0c1f-8ffd-46ba-936b-28db32463c39@uwaterloo.ca>
Date: Sat, 13 Sep 2025 12:03:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/2] Add support to do threaded napi busy poll
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, Joe Damato <joe@dama.to>,
 netdev@vger.kernel.org
References: <20250911212901.1718508-1-skhawaja@google.com>
 <17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
 <20250912190702.3d0309a0@kernel.org>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250912190702.3d0309a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: bf805688-d4b1-4a2e-234d-08ddf2df217c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW8rWEdMVEVWaFR1VS81MXBrRlBZTS9COGxGcVFPYkJvRmhTOVQzTHNrOXZH?=
 =?utf-8?B?MnhHalRwcEt3Y1RtY2ovVjJzWUN1T1VzeTVmb3ZSSDVzOGdUcnBGdmdQMENa?=
 =?utf-8?B?Y1hPSVBEcW1PTXpWOEp4ZGRWVDROTDRWbFFXWmNoSU54bXU5L1dtQlVwTTI0?=
 =?utf-8?B?Z1Ywa0NjRk1McTU4K2lINjZFQzVmOVRZZnhIRG5IUjVSb0tlS3lMcVk5OTdl?=
 =?utf-8?B?QVl6cCtqOXZDL3gzUENNaVRsQVJRbzNNaFk5aWNBTjloeUhzMncrbjJ6U0Fy?=
 =?utf-8?B?YUpaaFJwQVpqSTlOaEdydWRUaXU3cVlCZVJrQ25sZ21LREhuMDY0cFJ6QVBk?=
 =?utf-8?B?ZWE2eSttOXpPd2Vnc1pHWTVWa2Jha2NLYmhJa1VZa3c0dnFab0cyUHdUU29h?=
 =?utf-8?B?SWpOWVpJT3B6K0ZOWjJENnhsemE4NitkMlJkeWZFSXhuSnJIM25yOTAzSHNl?=
 =?utf-8?B?cGVJL0NQYUZCVWVMNlBRQzdDZWprKzZockkxUmVObkJWaWRMN1pYbnQ4Mmdm?=
 =?utf-8?B?Z0pBbG92djkrSFN6YXpnZEFpVWh0SVhFWFdoN3hXS0xpdmt1OTlSYzRJUnhZ?=
 =?utf-8?B?S2g2OERmbXpzUldHekxsNE81Q0s1QkhKKzN3TnBKaWxzaTN6N0pnbEY2THAz?=
 =?utf-8?B?QmdyR3BYN1lQSjc0WmRYZURmblE2QXYzblhJeUk4OEtaZXkydmhURUFPYWVE?=
 =?utf-8?B?Z05QUXJVMGt4NkZDRXNseGNydVlwYjBUTjB6aGFua2NuYjhVY24xbE51alRH?=
 =?utf-8?B?OUw4c0kyNjZCSDFyaGNGc0w1NHFDVHAzcVNmYXVjNG81T3lobEJVZkVYcDBh?=
 =?utf-8?B?TmVZMC8vdllYSUpKcDhBNjJZRlBRR01lbWx5NnNZWnlCblpxcVlEMUZQRnd1?=
 =?utf-8?B?QnZ3WDVDMFdVQnVHZ0pCVnI3UmtOMWRiUzR5aHMyRGRVRG1GSXdyellaSWVT?=
 =?utf-8?B?QVkrSjQrVmNrY3IyV0NwWlNyRmE5Y2xtdDJndytHUU5ZbUhyVDZpNHpWN1kv?=
 =?utf-8?B?Z3gvTnZCbS9XTXFXQU5CYmlVR0hXdWx0aWkzaFJNbjhMWUR2ZDlaVjhQaTNY?=
 =?utf-8?B?QndPZnRuQVM2Rit2ZXRMY3JBS0E0Z0pZUWR5Y1ZWR0pFRDhQcHlaQm9LbkJr?=
 =?utf-8?B?NTR2WGxPVTErNjJzZkt1ZG9SOXNWTEZRWlhIdVNYY0VDcTM1dXg1UUh6U2VB?=
 =?utf-8?B?Z0cxenpKa3RlODdweExsYXJmRm5IL3EvRE5xdEp6N1JpMnBaZEhpUkxycE5j?=
 =?utf-8?B?VkR0N1RFaGhDQ2ZvYWt1d2x2RC9ZNXVwWnZCQTY2VzdqT1JIOFBLc3Mxcm9L?=
 =?utf-8?B?dW9kOUo5SUhQV1k4MUgzWk9IVCs2MFkxd3BmT2pMWWxXbTZhZWZFblpuMjhW?=
 =?utf-8?B?QnY0VnlySDZ6b2RWRjlUQ0R5aWdoUkZadjBRRzZUUisrMXplVER3NE1CZ0dj?=
 =?utf-8?B?RzlzYkt6am5NZDRETzZFcS9vemFydWhqTE9zSUxUUjZ0NTh2RXhGWHZZNHNW?=
 =?utf-8?B?SDIrbGZxQklMc0NpU01pbjhCMHZOVXBEZFpIRXFBc0FieGxBZXl1MWVPS1BN?=
 =?utf-8?B?UkZvTm8zSU9LYnhGSGNuQS94a1RCZjNUcTI1ZTZTZThvOUVnKzdQOVNBZzdP?=
 =?utf-8?B?SkMxUXdaYzZTSlNYNGttZGV5RTJrTEhITmo3QzBESERoaWl4cU5KZlZJUER4?=
 =?utf-8?B?RWplUkhTL3VpT0NuaVFmREhZOFZzQXFscVdMM01odEFlT1g3UDVkSVg2dXZy?=
 =?utf-8?B?U2U0YW16OWpYdk5mTGJmTkdReHdoYkZ2Wm5SYzQ5WWxTanI3SjA2SkgzZjNt?=
 =?utf-8?B?SmJ4WEpZTG5qNGNkUk1aZjlLWHZGQ1VPUUdjcSs3M2txTjRVK3BzWjJwV1Zp?=
 =?utf-8?B?T3hzOWR3S3lCYVFOMmsyWUFlVXIxcUs0L2t6VXZxNWYzNlpVaTNKQ1VSdXIy?=
 =?utf-8?Q?46J8/ysoxms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODB2aFVmMDY4Mk9nYU1EZExDU1JHaVhkb1FVWjg5MDJyU3A5VHphK3JSLzVl?=
 =?utf-8?B?Z0tNUkJNMWk1UGlTRU4wQXNQRVQ5UlJyOE03bk9wUkxTUWpHa2trTVJtUUhF?=
 =?utf-8?B?MFFadnREZUhDNTdyZ0l1Y2hCR1hPQjVDMU9YZExlTk9udHNXZUYrWXQ4TXg3?=
 =?utf-8?B?ZUN6b09OOVRKOGpUaTE0TWpaZUlMaVMzRzhrcTJFSzMrSEw5T2krLzBWcHJz?=
 =?utf-8?B?YnJqSkc1WGZxa1J1eVZKMnAzZGs4emtxb3g2SG9hRG1vUWhZeDVjd1AvdVFH?=
 =?utf-8?B?TElzSFBJQ3E0ZVU3dHZMOHZTUHFTSWdpdWl6OEtQS1pDQ01JeHhESWdhR3ZK?=
 =?utf-8?B?aWdsOS9SQkFuZkp3bTUyQVcrTjdLRUtKalhwQkRjSmNwbE5NV3hQV09LWkNS?=
 =?utf-8?B?aGFBLzd2c0NoWk1TLzcrVVEyZ3FkZmNLR0QrbTBDb2w5ZUpVWDVPQTFvRnpv?=
 =?utf-8?B?T0lCS2ZONU9LSkU0S083c2luY3lQOUpubVVwcytoRmoweWhzSDl6Ry9ZREc2?=
 =?utf-8?B?SGdnTjR4dnRxaENJMUd0ZlE4OWRrejBaaXJ6cUp6UEdPY0c0SzIzUEhQN1Np?=
 =?utf-8?B?QjZZdmJxZEFCc040WWk0VTlSTG9rM0xNV3NzcDRHSHl3NUtoaC80YWJyUXZ4?=
 =?utf-8?B?SXpjSHFmb0tqR2Q4VmwrZmo4OVJSNGVMR0NneWNiZnQwSng0amxmMHIxQlky?=
 =?utf-8?B?U1lRTFRoZFNEenY4UGZ3TE43WTNmT1Y0bk9mRTBScmQyKzJNNXBDekJIOTlF?=
 =?utf-8?B?WTdWYUdJemdFbk1oVlRhVE5ScTRpVkpZZWQ1VSt6d0Z3S3k1ZEhTelp1Y1ox?=
 =?utf-8?B?bDk2MGJuLzhIdmRjZ0M4RXd2VkhaMWRJQlVaZWc5Zmd6MHFiZjRLb3lKVEtJ?=
 =?utf-8?B?eDR0c0dlZ3NlR3JYMHB1aEtPV0FROWRZWW4zWUpIYnE4YWxYUlJYSkNSVHZJ?=
 =?utf-8?B?d3ZiNy9iSFdLYTN3RVgxeVRucEl0djQ5eGoxNExPZldVTHBWN0RUMEtVQ0pJ?=
 =?utf-8?B?YURWK3B6ZWduNU0vLytrRXNUSnMyQVowcFVLRjlIcWlNSUtyMEp6UE9oSkVY?=
 =?utf-8?B?dS9CY1BWWFVLU0FVV29NYkswUGRsdHkzUXROeklZci9FRmxuYnhLUkNpbW5B?=
 =?utf-8?B?cjZEZjFRb3gzNGJPRHR3Z1RRTjh6VlR3YkpMRGFuaDhmTnRlajJ5ajU2RENZ?=
 =?utf-8?B?V3lHcXpWdWgxTVc1L1J2MXhya0tHRG1UZ0JXZERodkdWWXhqZFIzQkdONm0z?=
 =?utf-8?B?WUl6bnFnalRiTyswd2QwdmhrK3paUVBtaG5mRVB0L29GRUhYbWdlRVZhZFYz?=
 =?utf-8?B?REUraDBVK212UVVwajN6K2k4NGJtY1FWZEZpUUJoZnVsNUkxeUZCWGNjbnps?=
 =?utf-8?B?VTJIblhXcnpjeUZpQXpYa2ZzQnJPeGZnSDk1bUQwd0tkVlI4SnZXazRJWEFU?=
 =?utf-8?B?ZmpWUCtZbDJqVUl6SjhTMU0vN1Bxbm16TVZrYnhsWWJMbXpYZUVJem9LYkVX?=
 =?utf-8?B?UEUzWGZtcEUrV3ExbjQ1bzREVUx5cmI5cTU3UDVDU3RIZUp5d3JCTnZEQ0xF?=
 =?utf-8?B?dDhkVUNxVVhLRVl2RzlQQ3oxWC95YlRJSWh6WWRpUThGeTZuUUVBN3NBaVh1?=
 =?utf-8?B?OXYyZk1qc0JEb1laeUFldFFXWTlUdkpqTXpnaFBienhPOU1SODhIbUVDaDkz?=
 =?utf-8?B?dWk3d2dMamZPZDBYVmlHZHZQN2JwTzdTR014MDcxZWJoeTF5UVBZSmxTSW8w?=
 =?utf-8?B?YS9GU3pEelFST0JkbzJDRS9zWnBiKzZhckMrRHBTNUxLSzJFc1hIWlZLcnhI?=
 =?utf-8?B?S2l4WlBaQVVOYnBXTVVkN1BNb3F3VkV4UHZhemt5bEZHeUNvV1RzRW9NZ3Nv?=
 =?utf-8?B?dTl6cWV3TU0wakx2VHByL2dwQllHWG5Fc0FDWVJzOTR4aGVscHdnSnpaemxp?=
 =?utf-8?B?UytEQzVuZWhHK1ZlTTdFZ3MzNTlRdHlNcWY5dktwckpRNk1Wb3cvZWpQVkVX?=
 =?utf-8?B?bzUyM3FqajNrdEdYaFdWTUc3a2xkMTNHMDVOV3dBNCs1c1NHN2NBbkxrTEFq?=
 =?utf-8?B?R1dnS1gvdHVmSmpsQ0pCdUpHOWFTci84VjI1eTFsem5zMDdtNnRuWlhsQUdT?=
 =?utf-8?B?ZHNHZHUrYzR0MEU0ekM2eCtUZ0QwYy9SRlAwU3ROZGhTUmlUdTd4U0JIeVJE?=
 =?utf-8?Q?nefHf0QOMCw5nzrvkbDTDbltazgQSjv6vK0wIqP6nxKj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mD/Ht1K2vaC60QqkG1pIjvuRqIE45KgiQOlMb8jGUUbW12VIGJgrLI/X6fKuRdhXe1OAOEKowVamPwaDzewZpmFTP0bZYXeUB1ivcmorzKYwySDf2DwV5JcRRB/1KMbnCxWbP+zhFsuuhZqj7nCSlRaLHr6gpp9l/Lo+FL8Gc2zhT6JFpbCM9F4of6mUXvNOS8a4Gh8t0RMNaeDVMSVrZAC7Jhg2mNFSEtPBlCKENz1/dUr9/Gb1PKfLwgfscQ425fvzt71I0E9MULUwcSdHEKhftH4qIVNsiSj4AB3jqM2Nyf5PcsScMkS8nIADruR2MrQ3K5Y9lPDYIyJlAG0qVR7oYl73wZnKTfPUhICl59MIVggA0mDflBlc8VsdZbpqlYOY3OeCjnuDN1UFeKC0uMQcJeJ49RWRsGXHalki/g1ZQVLGwQLYQJZ912270rX75JKgz7c26l5bcI9RiqmPGOIXY90BK86uOt9GDtSnN2G/0AncVdRfqxCmV8t+jbqM5MIsSu401D2d4i/i4ObnUlgk31We6HVVxZiNQt93bCHhGd9UAWI7jcTz+2AJ1/5fLL3z1zxFz2M7BBp8bPEksv1zOVxz/V7GlTgaJ0YiBFgV+qjCr6s2/DSrO0g76Fvl
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: bf805688-d4b1-4a2e-234d-08ddf2df217c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 16:03:51.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+9g83TJtyC+EJd2BveAwZ52gC0xQL+V0J/2/OLJH9uJbBhh2bD8U2U6gdzqvyNBDcVus/GykcrDQLleNhWYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9753

On 2025-09-12 22:07, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 04:08:21 -0400 Martin Karsten wrote:
>> The xsk_rr tool represents a specific (niche) case that is likely
>> relevant, but a comprehensive evaluation would also include mainstream
>> communication patterns using an existing benchmarking tool. While
>> resource usage is claimed to not be a concern in this particular use
>> case, it might be quite relevant in other use cases and as such, should
>> be documented.
> 
> Thanks a lot for working on this.
> 
> Were you able to replicate the results? Would you be willing to perhaps
> sketch out a summary of your findings that we could use as the cover
> letter / addition to the docs?
> 
> I agree with you that the use cases for this will be very narrow (as
> are the use cases for threaded NAPI in the first place, don't get me
> started). For forwarding use cases, however, this may be the only
> option for busy polling, unfortunately :(

Yes, to the extent possible (different, old hardware) I am seeing 
similar results for similar test cases.

In terms of summary, I would like to see a qualifying statement added 
prominently to the cover letter, such as:

Note well that threaded napi busy-polling has not been shown to yield 
efficiency or throughput benefits. In contrast, dedicating an entire 
core to busy-polling one NAPI (NIC queue) is rather inefficient. 
However, in certain specific use cases, this mechanism results in lower 
packet processing latency. The experimental testing reported here only 
covers those use cases and does not present a comprehensive evaluation 
of threaded napi busy-polling.

Thanks,
Martin


