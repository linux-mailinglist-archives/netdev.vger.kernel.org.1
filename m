Return-Path: <netdev+bounces-224621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A283B87328
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19652A7566
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8462F3C1C;
	Thu, 18 Sep 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ieNzhyzT"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1F2288D5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233114; cv=fail; b=sDjTCszZU8L9yVtAR6Lo4JU9pcgR+WgkTh5YBAxrwV/DqqHD0EmIboYhHrmb3r3Rx8jt8dqekUs0ZF4nhBsQ+/Rx7RAvTBjGfYgDH2VwwKbhXcpeXthcholgToA3qG0bDM5up+zHgHpFj+v2w3HtCVEXExBTjW/JITKLkYCwuFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233114; c=relaxed/simple;
	bh=ePaK3p3VnSoQA3O8Lun7+XrzpBvWSPrpFM9KVQyvE38=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=XKVkBTQY5lUmI8GcZQQbCen6LtMGFejJgEUVylvsKs3E5DE1b8MgsC+TvfYkdhQK1Qe+zxURjGFKS+6Ojs3d8/HzxcOo3yMSY9DnaCC1G7UHpCKCMendbnYog5aLyz4Ld1LLAgVSRb1yNUQtp+h3Wup8xvdSM3tSmmW7l/noMu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ieNzhyzT; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHAR720F663Tqr/QRc6FiinVxQPYo2VswxXKt5wkLoqJj2NVgY3LYfVNAhW2l9ihBYjusAyVljQkskmmioNOcqZnxy5r9iiz0qc9gsM2nILAXaDD0Ec6GTz+QmdQnZzFBj3C4hmElUCdcpPGUgKIEptuaTJqN5sqYjceuzfGXrs1qbKUlGMUwMR2tpOuJ7gtBxP6T1ALcJwCFOV3Fy2GZHbPWieWJfpAHez0ad/VMqPsNc4FZyO/Xa0KzHDSVlJqjVv0Gfj/r+yqFXjRzwqJgjs5bmzOklzRMSOxcHvmhD7vQ7GpzIg08KrXUp8/hKq6LDvqEBLWbl6bqssiydHtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epKEbbZCJH9PiuYi6DldBMZIUu4d6T0DowQsaeIyUKE=;
 b=I59v9PSai9tc2m635BIzyTh5VBfZmkIcKw5gXqMvV4R2MJSWi88jIjY8f3pfEY2C3PSNwlhsFoA+0oIoA2J0x73N+rokDLcdVFnDBdWHNij++V6VediB8SSZKmZeb29zL81BC5/QAYJL8GmUOhgwTdzGozIn8FCK9M4j7EvXBdakN7rB4+syHbzcWfLew4mMXFpIPzBH8sdu99TDAhVgP2Gb/UuIzH2229PixAlXT5hPEMXvelFfp+Ry+guCLoNMF26suPRqeayM5nhYT8n5+hWhxDEpSwZyMAzpvuIBuAjyA0MlPmmU+hMsTjVi0tbc69Gu5I2FOT+XO5da0Tya2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epKEbbZCJH9PiuYi6DldBMZIUu4d6T0DowQsaeIyUKE=;
 b=ieNzhyzThunU3aOWIL1k99922cLLdKVVI10+5IteAeyse3FzqL27H330p2ZiUAYl3mx8iMGYurDYwl4XzplEEH5IUpURzKiqAOBU8Q51TVVdp3CTpeoMjQkE9kTYrlgVY+jTw9+LWHpKOaTuGZy8FWQlMb4MAeXpD2gczh18k74k7WGJctIICXves+QX54MyzMFSt1xA2f5U+xYTkL/5QpsSRABpY6C8gTydPeP+Lmf0tGbu3WKbYSghYKT+ZkB//0QHNns0XBLdgRUJNAqaj6kuZFP1hCdnrXSZOKLgSC9a+SidkSEEMoKDXKQh3RYh9+W29zlanmaf+T0/HyiAJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 22:05:09 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 22:05:09 +0000
Message-ID: <a6142a60-1948-439a-b0ae-ff1df26a37f8@nvidia.com>
Date: Thu, 18 Sep 2025 15:05:07 -0700
User-Agent: Mozilla Thunderbird
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Remove dead code from total_vfs setter
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Kamal Heib <kheib@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f19a1e-c453-4eb0-479a-08ddf6ff6eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhyNVVadnB6UHJ3MDM1dWJ1cDNiWmNSN2RZTHo1cmxoc0JKUS9TSWd0YnhJ?=
 =?utf-8?B?WXdYRjFlNWNuWmxZQVpWT2Z3aVFCelcwMi8xQTNaSTgyaU9hTHdrKy9NVEdw?=
 =?utf-8?B?T0RCNHBzZ1ZLQVpIeW5FdDNSQ3djOCtZaVpSa2x0elByS2cydHVndklYdEhO?=
 =?utf-8?B?T3EyNmgrNnBwcEhrVnpOTENQWW1oamM3TDdHeGRvbUpiTkNYckVydW1ER21Y?=
 =?utf-8?B?L0llZkgxSWV3cFB6VGQrOXBERzFIZ3hFM0NZanJ5ckp5cVRweERGNjE3c2NL?=
 =?utf-8?B?S2Rya0pCbnkzellvZ1FIQ2FYdUhrWndkVXEzMUhIWHFFSTBiVGJzRmNrUmIr?=
 =?utf-8?B?VTZJa1JuZHoxY0tudi8xM0hzSTV6N1VBNytYM00wbGphaFFEaFZLeGtyU1NX?=
 =?utf-8?B?RTNkOUtDQ0JkRVVmc2FYcjhTZzFzTG5IcW9lKzVvNDhBVitpYkNEcC9PbE91?=
 =?utf-8?B?dHQvaDNsNm1ILzVBdi9tUWtPRjJoalZ5THhKZUd5eWlCU3Nlb1M5d3hBMHVm?=
 =?utf-8?B?UTRzSURWc1dWNG9udXJyb3dMbVg0OS9WVmRTZUNieFU4U1dnNnJEM2RacHFR?=
 =?utf-8?B?V3BUWjU2L0NUWU5VV2pGVCsvd0x5bGJLNHZqaW0zNmZDbFlrdGhURFdueWsx?=
 =?utf-8?B?UVQ5YUZWUTNjUTY1ZUZZak1vQmtPajEveEtQY05Pa0hZQ0d2T1U3ZGlxOU5q?=
 =?utf-8?B?OEV5QkpYeXg0VCtQcjlnMmNBc0M4V0lhS1UxWWg0NFFVMTlrQkJZZVJhbVdL?=
 =?utf-8?B?RCtDalk3UlZRdTQxNDRCS3IyZy9MWXhwcUtmdHBUaXo2b3pEaG9WQ1dOcE4y?=
 =?utf-8?B?WHdPRHlsQmh0K1B5SFM1cE5PRFFOV1RvZGJIQ1BodFg4b1cyN3hPYjk2WWZC?=
 =?utf-8?B?RU5FYlFteVpWQXgrbVdVWkw4dEhsYWMxU0R0M0JDaEszbWlNbkU2QWJlczJh?=
 =?utf-8?B?eEwrdG1HZVRPdi9zc00vREhVcHNIbk51cTdhcTY5cDAyMThEYnBCQU1rRkZ4?=
 =?utf-8?B?cGd4VXJXcDhKL0pCVWdkQUFHTURWN3RyNStZbUpDekhxdHIrUVkyU1g5WHpw?=
 =?utf-8?B?d3Vpb2NCVWVTMldRVXhCVWh3eTdJRTdWdmpjaW5HQVhxTFFxWVFLZlM4MUFE?=
 =?utf-8?B?dFdRWEZWMVlNcnNCdDdWbWJFemN0VE02bWhZMytFdXh6dXBacDdJR0s3bTRT?=
 =?utf-8?B?ZXdoeXdQRmdTOVlSR2pndnE3TStFZHBFMkJzRzdQdUViUXhEZGFIMGpTYVlI?=
 =?utf-8?B?RXdEdURnNWRyNTlGQnJKK2pFUjVjckRRcUZQbXBFbE9yQ25pN3lFWGVMdWVa?=
 =?utf-8?B?ZmMvR1BydjNvUmVzSW9tQ0taWkdQcGQ3c0Nua1NEK2xRR0JKZ29tNVNGNnZX?=
 =?utf-8?B?M01ZMGFRWXNKcW44YmZpdUdiQ1dONjlHYStBRk5tSi9FaExsMWdLRDhUekM3?=
 =?utf-8?B?Q0RVTUpmR2hvN29WbjlsdTUyMlFHQ3UwWEdmcElUL0Y0bWFtRXRpc2FUL2Va?=
 =?utf-8?B?RHhaVW5QelhUWTY3Y09SMWtlQnJEcGZGVHN1TnIrcVkrU1BFZTJwbW1Ybk1I?=
 =?utf-8?B?OFNzWFA3R0VyeVZ2dnRlMElIUFhZYmt0dWZJd2xPTldjU002OTY2anNIUG1W?=
 =?utf-8?B?a3JmN0c1N2U4T0cvcDdsUzNZaFEzRlB0bC9rV1BJNmYyTUlNK2xpSndULytN?=
 =?utf-8?B?SE12dzFpY1ZWb0htRmt3TEtLRTJaN1M4WUQyQzl4RzNhamNEOUt1QmxKZHJx?=
 =?utf-8?B?bERYdzl6WE02RTd0VUlmY2tCazdqVFpoT1dVMDNJY2d1bEFSZm5PTEVZYjRa?=
 =?utf-8?B?ZEFtc2Nqd0xsZHg2VHhSRndZaTRHVFNwU1dIRENtOElldUFpY2ZTR0FrL0VB?=
 =?utf-8?B?L3UvNnZicU9odE5yZnkxWVRSSzZ2SCt4Tk5RTTlPK25MWm92cUZkN0FQRUY1?=
 =?utf-8?Q?3DefbAnc+fM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGU2eGJPaXVSYWd1eTg5eXBRZlpRTW5IRFl1RmhNU0RNZkh6R1dpblVodzdS?=
 =?utf-8?B?d254YnhyM1dhdGcrMERCYWU0TENsV1VvT3lBeiswc3UxbU5rcHJHenhIL1ZQ?=
 =?utf-8?B?V0xHdldzUFNreXpJd29ZWEVEblM1eXJFUS9Ba1FKMFY4YU1UbmlHYVpKQU96?=
 =?utf-8?B?ZXFjakhtOWxnYmVnbFl6dkZRcEx3TTZXMWxPUmkvRU9QaDYxa01BeW5qZ2dO?=
 =?utf-8?B?anRvdVhPa1BvdzFVaG5UQXlhcFExaW9HUUVnZzI0dW9MNEJMMXRVWkVZejl3?=
 =?utf-8?B?a0RKd2VVaEI2L1RhbWozZDhDUTcrSVZMbGhXbGpmNXdPL1EyQk1lbkdRejhj?=
 =?utf-8?B?akFBSEFPR0VlZmw4ZllzTEdwemdEdXJtWk9xeHNrNk1NQXVrSFVNRGdhZGlo?=
 =?utf-8?B?bGZ1cUxDc1RacWNZK29qK2ZkZzczcXdtQ1ErdGE4UW01eUNHd1cxamZXVTly?=
 =?utf-8?B?SXg2bTV4Y3liQW9Oa09JQlU5L1JIUFdNNndZNHB0SWljeCt4ajhWK1hvcFZE?=
 =?utf-8?B?Q0hKSlo4YnNENS9BYW9qMloxemhQMkhYLzBYYnpJSkcyOEMvY1VxdUdqdndF?=
 =?utf-8?B?RWx0d2Y4NXAyaHArUUJYaEdIYkpwWDg4aDJYRUZoM2VZTDE5ZTVYZ2VTSFEx?=
 =?utf-8?B?U0FMMTBpUTJlR1dwWVU1SzBPakxIT3RvdFFGUHpFb2p1ait1SDl2dEJWRElk?=
 =?utf-8?B?VldrUmVsVWNDNHB4RGtOVno5ZVBaRjB2ZlVzelExQ2hXSzIweUd1YUo2Sk1P?=
 =?utf-8?B?cWJiN2xrVHBHcjlxWkRjcmN1M0ZidlM0eWZQT0k3NjlpckVpU2t4M3gxQU92?=
 =?utf-8?B?YU9iNTlKYytzUFBTcHFWM29oRkRhR1k1R2lBc1h1T0pJZzQ1ckhIOFQ3SFlG?=
 =?utf-8?B?Z29PK1hGNml3MDEwWDhXemVVc2xjRTZGNmorOUl3ejc3QnlXRzljYVg0ME91?=
 =?utf-8?B?c1BtMVRuV0F1enFOaytreDN5ZWJzLy85REMySE81NlZVR3FjM2RhK29tR2VL?=
 =?utf-8?B?SjRkNnB6ajFrY0VwQVV1WjgvRjQ5MFh0QWdLT1h5Z1puNkF3OEJTUGdocG1r?=
 =?utf-8?B?b1haeVhmQk80VGxLY083TXBiNnpWcFc2WFM4eDJHV1MxTHJrMnh4dzhzcERm?=
 =?utf-8?B?bVd4eWNUUnJ4dkNOSndkbG50dlVES21QUFBuWW04ZjBGdjJydFJzWGNncGlv?=
 =?utf-8?B?TkMybzl5ZTd2NXVCYm9Rd1RLQ21oMmxaeVI4UWd6MUkra2YzQTlmMWdVY1BC?=
 =?utf-8?B?dmMzL1NxYnl0YkhyY0w0RjJIWndjZFBVeGJPaVMyOWx6YWdDZHNncFBUcTda?=
 =?utf-8?B?NVpDdHpONFRTY0FtaVc0aVBtbW1IbllxWEhmRGRFdjZCSlZVa1Bid0U5bXJN?=
 =?utf-8?B?WCtTbVVSM011K1NPNTRvUldCQUEyVnNxZ055OTlxV0pjakQ5Z015YWg0dE5V?=
 =?utf-8?B?cWxxUVhrYld4cm0rbzFzZVZBdnROK3dPYmVNSEhaYm1GaE1DajVGc1hDWmJG?=
 =?utf-8?B?Skp0ZFBPNUtBa1ArRGgrTmhOTE02bWZwL2ltZWQxaEo4R3VWTytOVFp4MDEr?=
 =?utf-8?B?WDJpVUhNR1JkdmU4akE3d0RpVzJDcTdnbnV3OGJYTDEydmk2bXNrVmhXUnZB?=
 =?utf-8?B?UHlYdHFOMVR2dExwcDV3MkZFcXM2RXJYdi9yUldiNHoxN0svTVlHZUM2QVg4?=
 =?utf-8?B?V3J2TGg2ME5FNGY3QS9qdGd6enFuVkhZbWVUZ0pucGJISGg1U0R6Q2JkYUdK?=
 =?utf-8?B?ZVZjN1Q3eDR4bmxJVnNXUnhRUHQ0OC94QVNKa2czM3RSN1Y4dnV3N2NFL0F2?=
 =?utf-8?B?VytWU3dXZWJUazlicmtXdzFROWl5ZnNiRDM5VFAvTW5iLzZGRXh3RUtXK3M1?=
 =?utf-8?B?bEIwRUdlNnNwTlF3U3M3Ykl0N1NvL2xhUGVzOVNWTzRiaUp6UEUraitpcmZa?=
 =?utf-8?B?MWNBUWFTbVFOc3drZzZubVVZNDk2QUZvRjlDK3BZNnN2d1VOTGhMVFRiTEtM?=
 =?utf-8?B?N2dPZUd4Q25OUEpBNnJBWXM2SnFHcVFWTFJBZ1RoZGhmNHcvbXdwcWhXeTJV?=
 =?utf-8?B?Qmh3WHlod0gxOEdWQ2ovSnlVRk5pRS9HSmJnandyM0t2eU9MWjdYbXRQbkJk?=
 =?utf-8?B?V3JWOHpoM3g5WGtKdE1pM0lEQ2lwWFRFMEFydkFUcmJXNGcveE1hYTJjcGky?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f19a1e-c453-4eb0-479a-08ddf6ff6eda
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 22:05:09.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJjoNmmPpt5XXH2VLmt3fkWUz1s33P12MSIdFyZwNuwdGkicRqhoOGMRqTAPYFV34LPFxJE38Rz5FoKdsHrISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904

The mlx5_devlink_total_vfs_set function branches based on per_pf_support
twice. Remove the second branch as the first one exits the function when
per_pf_support is false.

Accidentally added as part of commit a4c49611cf4f ("net/mlx5: Implement
devlink total_vfs parameter").

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-rdma/aMQWenzpdjhAX4fm@stanley.mountain/
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.c  | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 383d8cfe4c0a..459a0b4d08e6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -458,7 +458,6 @@ static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)];
-	bool per_pf_support;
 	void *data;
 	int err;
 
@@ -474,9 +473,7 @@ static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
 		return -EOPNOTSUPP;
 	}
 
-	per_pf_support = MLX5_GET(nv_global_pci_cap, data,
-				  per_pf_total_vf_supported);
-	if (!per_pf_support) {
+	if (!MLX5_GET(nv_global_pci_cap, data, per_pf_total_vf_supported)) {
 		/* We don't allow global SRIOV setting on per PF devlink */
 		NL_SET_ERR_MSG_MOD(extack,
 				   "SRIOV is not per PF on this device");
@@ -489,14 +486,8 @@ static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
 		return err;
 
 	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
-	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
-
-	if (!per_pf_support) {
-		MLX5_SET(nv_global_pci_conf, data, total_vfs, ctx->val.vu32);
-		return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
-	}
+	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, 1);
 
-	/* SRIOV is per PF */
 	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
 	if (err)
 		return err;
-- 
2.49.0

