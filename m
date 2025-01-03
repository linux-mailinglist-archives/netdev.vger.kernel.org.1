Return-Path: <netdev+bounces-154915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09761A004E6
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EA2188325B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707C1C3BF9;
	Fri,  3 Jan 2025 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JoE7FPnf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8D1BD032;
	Fri,  3 Jan 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889051; cv=fail; b=h99T+/+MfmU2zFx6Jhnll2IjrpnrDczfIATxXPqkH1P0KmMZ9HIQ+NylXBoN7Tdd/ry24/dAdkzneaVk0dUVc2R8LuZE6EKe2Tu7q2uz/QuBuVUObeeCvoQVkRKDe3FZSg2Gpvt3x727HCCM4AfNSwFno2cBMua5bGEZElznmU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889051; c=relaxed/simple;
	bh=qu+I57ReZ8D44CEFgCivytsCpNI8MfORp4xAGQJ8dsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5C7pn9izaiOQg+SOVt7jjjN1an1YJAEbmlAeajlaFqaL98RtmE66k3fHv1LybDn82zgEf73BHJe4WfK3alrMArzp+gSbWhScj1k4F8XfHHwFCTQGRAsm+WxHladSbqclRUgS0gRsptQFyzjtbrmL85cgkiPFb5H/N7O+RQUtaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JoE7FPnf; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWXTxSUiX2qpzbu/CqWJNVRYmAIj1CsNvrqDi1K9VyzH8y9k8HuxRb6X9XHzvFNI+SoHNPzqtCAoCuUMyJDJjI04+ZYQW6qaEhYnLyKaJs5FthxO66kQ/4g6gFpQ4S3MgyAOS3f+tMiWZytCoxRwxXt6ixcsiAhuuDkeTxTfew6LfNHzJlH9sD+c7q6iFgWlUR2Ooul8MZfONoWtfHDvPVwz2ml4Olpv5qvYk8B38fCte7v1kHoqoGS97ul+Z+pKui6/c0+wrZfRCfC9CYvGoUA7IQBiVbSxmlbq/SXC9rYhwmI/3EDbuMpW0nhy2TL+2QRY+52CWRI4vF0HZKIKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKSJieOFZBtCPfd+w7UFK09PYpJ7XWtPusrKx5b751I=;
 b=XGavblpZgSdbwTLHHNrnjpxUMYe7yCfzUis+XdvPT/kSbo+Y1cnSZEKcF93ZbioqA54XklZLpxN8XMmI6BexyB/GGzfwt7cmcbk+aCnGYKHRU9+N68DjWBPTknwRKwsd9oBZPolyn683Zz1FLb3ZtyN00ONj9kEhhKiJgz7/VAnLXbMw7iPSouAR8qB0RpY56nGATr/TXii3SwXuDgF1Piyp/aW5mRJhhe+gdpljb00B0UBhHSm84ZmrsoXW1fvvi0rbKkA0LGNJCopiqKlI+jZzuh8Nr5Br1glQpUiJhUcI0fZ1AnOKDoynRLEHC2c9GuGwdRqbEwUf5xjZNP3v0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKSJieOFZBtCPfd+w7UFK09PYpJ7XWtPusrKx5b751I=;
 b=JoE7FPnf1cVE18fUXGIszr1yimwAMTWyOFpWfjY3iJ4VmSqSCZx0LfUMD4xs7VJT+IPjxycLkTb3b2J2phyGxNDgI527mz8teaDA94KZGhDc+9EG6CT5TEPfFb7xZgDMKsVFh61PSe28DpL3NqQ/rpdGnwZlORrWBFF50BGmPDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 07:24:03 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:24:03 +0000
Message-ID: <c246e0ff-f0d7-2cbc-0ae3-9ec6bdb41cba@amd.com>
Date: Fri, 3 Jan 2025 07:23:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
 <20250102145354.00007ae3@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102145354.00007ae3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0244.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::22) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbfa623-6423-44c5-0f7e-08dd2bc799c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHZ1T1NSRW1zdHB5M1R3RlRsc0dudGYvWkJydW5WVlM3WitnVkNCU253MkQy?=
 =?utf-8?B?UG5jQ2hUUVVBd1g0NTJQdGFmQmNQOUozaUhIY0pNdDExTW5kUDN0Y3ZmRHAv?=
 =?utf-8?B?WU9wYjF3MFB0Wk5MOHVlMy81T0dyZHZkRm1hRk1HZHFkZkI5Y0R2N1NPWkh2?=
 =?utf-8?B?WTMxaVBiaGZ0MkxRODZHTTJXdC9VTVNaVmFsd0NYYktjVWQ0VkFERkFQNHJq?=
 =?utf-8?B?YXhHVTZvMWd3bS83YXdodkFaams4eWFGNTNjYUdCTEg4N1FpbUZIZUwrMWdH?=
 =?utf-8?B?aWVxT0dxSmovVlF2TUJ2WDA3cENRaXc4YjJwdTVJaDVNZU43U2RWYmE4ck5v?=
 =?utf-8?B?d2l3eVlTdnBvWnhEKzR4M0l1cjRGSG5CQTBkaUtFQVFobWJYdDIyYStnUzJy?=
 =?utf-8?B?ditYYXE1c1A3MEQrQ204WTRFMURqRnhaQ3FvVlFmYmRJRDRpRStKQ1A1bU1V?=
 =?utf-8?B?RkJsTDBrT1hDNXRqNW9JTEdURWtyNVNCaU5wYTFCSVljZkxYNUhzVW80aW1S?=
 =?utf-8?B?b08wbEM1bDRxYXBISGVObGRNeXVSWWV4ZzNyTnBBUkoycTBBSnkxNUVvZXlk?=
 =?utf-8?B?Wm5zeUZodVRLTldQQ3BQbjBKVnRjNDNaZktzVHhoMFhvM2IrR2dQSXZqUlN3?=
 =?utf-8?B?eGRCM1ROYiszRmlMS0FsUnZYRVNPdjhYVkdKc3dxOTJXTlFvU2d4bnUxNG53?=
 =?utf-8?B?N1l6ZUY2dzM3SHdFLzQyQWxKeS9qK0tLR1NFYW9RYUE3NXdoR29mZmQzeWY3?=
 =?utf-8?B?eWtkbWZtY3BVejR4U09EanRrZjE5VGJiUUxNMFlCQXpoWlQxamJ2RTJUdTRB?=
 =?utf-8?B?bkZyVTloeHdxdy9SNU8zbjQrU3lzRHpVVndxZjRKR2loSTVSMWxMRHkwQmJL?=
 =?utf-8?B?STRGZittLy8ybWlOZEtDQzNFaWs3ZFZYSzA0Z3dIQ1JyTlJGVFRjcFREY2xZ?=
 =?utf-8?B?K0FZN3lvZ2R1eFJqUFZCTEl5Yk9qejczNFdRQlhTd2dISVIwTWZ6TGtjcmRR?=
 =?utf-8?B?dmVXeUNzU3Bhd21UUHdpNjZ2ZFFYSlFWcW9BaGJCWlBodGcyUFlOWjd5aVJS?=
 =?utf-8?B?N3lKNFo2QW5xL28yWUk0TkFERGtLZDl1QjJ0bWxqQjE2T21wTmZqRWUvUFRD?=
 =?utf-8?B?Y29XaFZQMjZ0NDRCS1JKWjRqQnpBLzF0MVM3WEpUbGtXN3gxYW5YQ2VTNWZY?=
 =?utf-8?B?UVoxTHBKMERWY1lvdmQrUjg4dE54MGp0Q3F3aFZwWjkwdG5tY0Y3OGZjZXI1?=
 =?utf-8?B?SUFWLzhaTU4wKy9Va0tieGZ2dkZ5cHluSGN1ZGZTcnpvd0haM0hVRkRHUmpM?=
 =?utf-8?B?TmNOQjViQlhPZjRNNEZTWCt0L2k3R0VkejIxNHF0YVcycUNBUGpYNERVOERk?=
 =?utf-8?B?QzJTemVSQkFKQ1U4OFkvcFRkT1lZYXpDVTZIY3NtNDJRMC9XeUFMMEJxa0Zv?=
 =?utf-8?B?d0hYYjRqeEQreXJqcnV3R2dFVjN2NG9laUZ6d3RmQXYySXdVT3Bwd3Y2R0Vi?=
 =?utf-8?B?UkExTkJxOHJwenNiMUcvQXN0bEpNeDVVNFJ0T09ZZVNlb09XTDV1eUhmY2VC?=
 =?utf-8?B?Z2l2STdvUmhrUWRsRkZZOWlsYjc0MGUrWUZQZHFlcVNLN2pydWYwQTV1eFg2?=
 =?utf-8?B?eGRPcXRna2gyd2VrUDJlTDNWTnJPcW1OZGVwWGlxaFlzUTdJWktNeFh3dDNV?=
 =?utf-8?B?alBxOS9SU2tqVUlibjAyMDBxTndTODN1YURlZGQybmoyQUJYVURtNmF0RWpx?=
 =?utf-8?B?bTBEeXE2QmQzajkzelVoZzEwUVd3bk0rZUVpRGVJWEpIbnFQZ2t5QVpFajlQ?=
 =?utf-8?B?cWpoSkdlQ3MzZWx5am84c21GY1VvTWVJbnFTUlNYOG1wYXZNUFRpbW9PWHU2?=
 =?utf-8?Q?OXezw68dyGwH1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azdpdVVBeitLcjk3alNldUZ0ampiNGNMOUk2Y0NXeXcydXdXZkJNZUdqYTh6?=
 =?utf-8?B?UUtER2pqcFJxMUNXNDJyVnUxWE5Ca012cy9qeDBGcUc2ZDlQUFZhYytPSFho?=
 =?utf-8?B?MCtCNW5qV1FtR1N1QVNNZjZESTVsUlFyNXdIY1c5eitIbGE1WlpVdnhrSFVE?=
 =?utf-8?B?djZXd2hPQUF0UHNUbjN1RUE4Tk1HZTcrNWpCdlk1M3JNT3R5RjUvNm94VzE3?=
 =?utf-8?B?UUVGc0xtMlkvSmZ5Ny9OSXhoYktPNzQ2bWRwd2VHR3EwTFpWZ1cwbkZ4cm92?=
 =?utf-8?B?QzMrMzF4eU15d0JKSSt1ZEF3cFNBV1dLcU5MUWtiZnptV1Q1a1NaVVIyYldD?=
 =?utf-8?B?cWNrOFdxbGNhRUU4c0YrTGZJdjlnY0RhN1phU1BBK1VCNmRHaU9IUjhnanpq?=
 =?utf-8?B?RXFyeTlmTFN5TGU3SDIveE5rRjVpckRlZlpHQytaYnljbGovYVNESkxHemlX?=
 =?utf-8?B?YTMybU9BeW10Qm4zRlhiYTZwMnl5YmU3NCtVV3lhRm9lL001WHZXRnlHVWcw?=
 =?utf-8?B?cGgzY2RCZExNR1FvVzBPbjdXWCtNakdJMS9RMHpHRjlnSExDR3k5VFZWRldz?=
 =?utf-8?B?bHV5V1hvTEZIRmtDM0ZJMVIyc2ovN3lGZ0xVUnFKMFB6MjV4V1lTUkVzcWd5?=
 =?utf-8?B?MlhIQkZlOEZTN2NZajBhOTg2UGFtUTlCd1h4bDF6TWJVcHphL0ExNnZQaHUy?=
 =?utf-8?B?Q0UwN2hDWGFUSmJkb21vVVJXeWxxNS9sdFBkVktuZ1hma2gvdDVoRERVWDV6?=
 =?utf-8?B?RmdlWkwrZGhBaUNSYlNBbmU2OEtkVFVKZjJQbG8wektnaVh0aTlEZjdwelA3?=
 =?utf-8?B?d0FZamJxR0FvVUtpK3VaZ05VSVdtcDZpdUxnUzZOejNWTEhBLzRlbVB5V2M5?=
 =?utf-8?B?LzRjZStXVVQ1MW5kWFhzemJFalAyWkRvdy9DMEU3MnlrdDlFU3cyQUJDTGs4?=
 =?utf-8?B?a3J5SDh5VDI2M1ErZ3hJRmZTazdWSTFlUTFCZ2xBT3A5K0Z0akRQQUpRNVVl?=
 =?utf-8?B?eXhxNnF4ckhjYlJ1eXNwRXQxU2hrYzQzbkxvRENSR1VJcFlNZFFxREtYT2hQ?=
 =?utf-8?B?U1p4NHNUQm90eTZMMm5MVWY4OGg0Ym0xRFNiQmlXdlBnM28yalZnaGV6VTBF?=
 =?utf-8?B?MTQ0cnBRc1hVb2YvaUxrL24xc05JWXBHUGQ5WDVqQk1uUDBVSlpVWkZMaCti?=
 =?utf-8?B?OWM1MFhMcVdMWVIzMzVTL0dmcG5Lc20xRFF6QnN3T0g5d09RNWtiTjhQNVZF?=
 =?utf-8?B?OG5ydG9mbmNvZ3ZYdU05ZFN4YkJKL2NtZGVQSmZCRTFoQ1hrUFIzTUxaNUYx?=
 =?utf-8?B?UE5CNWxaeUQ0VVhLUVcxNmJGUEg5N2ZYMDNaZzgrcUpvQU1qNzFqOC80REVV?=
 =?utf-8?B?R29uMFRHV2NHbTRMYXZQeWZFN2M2c0hwMjhIR0U3L1RpWkJpMURObUNOdFhh?=
 =?utf-8?B?eVZmQWVFS0ErdFdSL2h4cmI3UmdsbWNnNGljeVY4dHNRMkgveFF0dFE0b0l5?=
 =?utf-8?B?bDJBRi8wNWpQK0pEZGdCeGl1TDBQeFRqS2ZIUURYb01aNlVIZ2R5ZU41NUZD?=
 =?utf-8?B?TEIxeDliQWhsQk1sOGFwTWc2QmVHYzNxQlUxQVJaRFhVcC9oWU5HZkZIYUx0?=
 =?utf-8?B?MGl5N3pvUW9aZ1pXeUZMMDRPYy9YM2k1ZkxXc01RWjBWdTk0Mk5VRzFienVa?=
 =?utf-8?B?UFNpN0IyNzRpTkJYaFJSTEROQlVRQ1RweFE2UzJsdkVuUkFkc1JLbWNNWWd2?=
 =?utf-8?B?L1JCcVpPY3NsL0EwdFdOQmtYSWdwQlNjUXppODlpdTJTMW1OVHFTV1N5YUwr?=
 =?utf-8?B?VHo1T21vUS9TTGh1QmdGWW5vY3EreE1KVTBUM0IvUlRtNDJGcUdZUjc4dURX?=
 =?utf-8?B?aGxJaTc1NEc2U1hLNHpGTE1PcU1pMUxJTGdtc3RJMldENTNiK2p6c1JTVWp0?=
 =?utf-8?B?S0IzMEtDaDdoU2VEcjNtdmtRdVBTNkVQWVFqSmZLWjZyaWVPNjZFMzgrVThQ?=
 =?utf-8?B?LzVsYlI2TWdocHVMLzExQkk0c1VXMEdKMzNxT0JMNHhEK1h6U09pMHZBa2FD?=
 =?utf-8?B?YldBQXdnSGwxdVRyN09POEZnZnJFenl2Z3NiS3dQaHdHS1FMUS8wL2tzZFZu?=
 =?utf-8?Q?1CQDeHgHzaGi/Q49JdKMkPLYA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbfa623-6423-44c5-0f7e-08dd2bc799c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:24:03.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRxQ89P5TaXEONbmiz47vYmpMLMO6bz+YgUpICHRTTcPKKKI34dd+Rk8PuW/uXJLBxJlJ08U+rTYZPtGGgDpzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333


On 1/2/25 14:53, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:24 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Hi Alejandro
>
> I think there was one additional change you were going to make based
> on v8 feedback.


Oh, I just commented there agreeing with that (and the other one) but 
forgot this one.

I'll do it in v10.

Thanks


> See inline. With that add
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/cxl/core/pci.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  2 ++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5821d582c520..493ab33fe771 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1107,6 +1107,57 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>> +				     struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				cxlds->capabilities);
>> +	/*
>> +	 * This call can return -ENODEV if regs not found. This is not an error
>> +	 * for Type2 since these regs are not mandatory. If they do exist then
>> +	 * mapping them should not fail. If they should exist, it is with driver
>> +	 * calling cxl_pci_check_caps where the problem should be found.
>> +	 */
>> +	if (rc == -ENODEV)
>> +		return 0;
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +}
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, cxlds->capabilities);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
>> +		return rc;
> return 0;
>
> will make it clear what intent is here.
>
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map,
>> +				    &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");

