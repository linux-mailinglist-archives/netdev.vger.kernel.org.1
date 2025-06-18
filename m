Return-Path: <netdev+bounces-199274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C75ADF9AF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD6F19E0129
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDB20296E;
	Wed, 18 Jun 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/qqCu24"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901D17D2;
	Wed, 18 Jun 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288528; cv=fail; b=ttxnIaz57MXYTrRBawZGY2FBHwOcay8goIR5otQ9PNy4OKW43NEwHamiJa08HpmCvwHrR6JJMdDii4hkPVW4wNgZ0FP3wjh5pSYKPrmUEuKogJ5DFwz+N5fT0qNFjjpGJ0pS3sd/nvNX/7y1ZXTyve55I2AvhZhdg5q6uyZ/1hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288528; c=relaxed/simple;
	bh=Ou8JmxeKs/zSmMyUudn5rOFS1Ds/GStcyOyJTQy6/bk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdUnylhMUezMJyApwyX0BcNWPjAKW66eq/9lgBcZqPek750w5WD4bp2dTVBcgy3TV9UAiI0Sap7BG4kOubGWJXyB6UchCLFFn6jgwp1qAlgdcay8MNafHvdVUEcAmEIGhWivJVlxjr8hpjNZK5/PtkWPCWXzeAs0kl9QlRnuz0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U/qqCu24; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/zzGJ77CqLlwXcnuOK3YScv3UswHHKXQ7R7fYX0xMfdJn7l8qdslHvE65AwYs51obekkvz5HfPSadcyQq2yywXbPGAEqWNKKjYxviqkm9ERbrYtKl/5NOUKmVZhXPQlaEAhQigmd5hdadR2fJ7a3a9vKKZKY/0X5y5SXFubabkbB0mpGNriIMqRIYCsqYHai7mFQgNOs1RRmX8vvRbB4G78kqgFfybQQZ1Z3+x53dDUXPjBIsDZwQ6f/eRa9o0de2jwCgMumUCVTNd3C/0FRxzOy50HK42tgkLYlkzjTooMMit2aXtswObttsOTILE0R9XB0cME+qyqvkD6UDfSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqNBlpNW09VMzk864AOti6LYyI0pT0WNwn2XAlRtWbw=;
 b=xZbg0Z2KygQBYo03/vCwygiKlP+9TQe84bSDXigou5SCnDCeV9WQHPWld9x5Vz4SPPVTNcypxf/ob8bp+oFJcbD1NU+s3iURdHRj+9zAGAvagoAjGlt/uuy9RfcDfC2Op3K+98MC41RQbl+ZgEiFTJb7QB2FxSzQxalg/cHm3A/G7onj29tmlPlAYW5t158hqQ507UUiPjwlPQmdLms6ypxX71DMIYkDQP1l0/nVp1OmvfgBfC9KqBoc3mVf7xA60iJM0sq9k/7mvvjrvQEbQrYf/KmLWXdpjgBOb8WjzlPtwS1DIP1zDgG/7BXsuJHelyOBjgL50b8PT+M8NB6XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqNBlpNW09VMzk864AOti6LYyI0pT0WNwn2XAlRtWbw=;
 b=U/qqCu24eUC+wDbbx0yziOCpIbB9tW5nprLL0Y1tV3sXeI8hQSTGtnran1ouS8tLrDIxAezZl/bI9LDw/MN1c0qFbJk5kMa9aCDKG3cQxGsIx05AOcj2jTJt3nX3EBdCFdsDSwE13RacqJmxiBH0VCSH8V2H3JLwALX5VBUN/Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 23:15:23 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 23:15:22 +0000
Message-ID: <c92d0aef-8244-4375-9f5f-174e180a5251@amd.com>
Date: Wed, 18 Jun 2025 16:15:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2] ethernet: ionic: Fix DMA mapping tests
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Taehee Yoo <ap420073@gmail.com>,
 Caleb Sander Mateos <csander@purestorage.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3b19f145-8318-4f92-aa92-3ab160667c79@amd.com>
 <20250617185949.80565-3-fourier.thomas@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250617185949.80565-3-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::11) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: c783561e-3bc5-4c9f-6d0b-08ddaebe0037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1crNGk2dk83YjV1ZmtyQXYvc1Vtcy9qN3ZCVldTQkU3SmM5cTkxcDRMNGxR?=
 =?utf-8?B?NHBRMlliSFhnNGpWcFRucGNQaUFDU1dQUldtaDFwQm5IcHFTVjZwV3A5OUZR?=
 =?utf-8?B?eWdiMjdQU00xLzRWNmdIY3RpL3g4TWNoeCs5RTg1QlpGNlp5UWFjSk00ZFZ3?=
 =?utf-8?B?SCtJWTgvMllXbklSUGNEejV2NWNiRERIZXRySElIOHlUTTloZFNGMTI5b1Bh?=
 =?utf-8?B?MjlyMXNpQU5nMEd0bGJlYjg0TmVUcWZWQjNLMjhPMFhSTUZPbDNVOHN4UGkv?=
 =?utf-8?B?YjIzbzJaWnZmd2JBcUVucW5Ed29ySFFTZTFJcU5Wai81QTZGOEZBK3lqczB5?=
 =?utf-8?B?ZE5FWEtWYlNUeWdNTjdzUGFqUUdGZ2hKK0xac2JIVWZIWDJVVTBDclAxZ3Jn?=
 =?utf-8?B?VUE1VUc2eFMycnMyTmpXREhZb3c2YW5aTXdtdlVHa3g2allaTFhpZlpyUE5v?=
 =?utf-8?B?UmRGTnJ4MzFKOCtpN1N2WkhZTGh6WnJGV3ltajdyRUd4YnA2OHBtMm5JaTBl?=
 =?utf-8?B?ZmtZV2lyTmhKTGpQSGZPWjBwdk5VKzRBY09INzczeU1BcEVUYXhhZ2QwQTlT?=
 =?utf-8?B?RkhqbEZTYWUzb01wZ2hLWnRZK0dONWhON0NzWUhMM0FtUUlNajZSR1l1bSs3?=
 =?utf-8?B?bjJnb3YxVXRPb0VWVHFlU2Iwc3hqZmRhMHhPSlRxaU0rUVBQbi9ob3ZPaHFr?=
 =?utf-8?B?QmliZnNNSmFoUGV4UDhLSmkwT040MllKM0pvckpVblZ0RVp3Yk5JMDRYZVhS?=
 =?utf-8?B?bURWUldta1dLVEtwNzhQbGFGSTFsTE9kWVhOM09rdEc2UlFRNVFiRnF3VjFz?=
 =?utf-8?B?ZHY1Z1lmTzNoNzdxbEFvbHBsd1ZuRGN6R09OOE1jS2dhekdqQ1BVK0VhYUNJ?=
 =?utf-8?B?KzhDNzNXdlZ4d2owb1J0SXBvZlhiREFuUys1U3JYOHgzVnZDVi9yMWUrcXV6?=
 =?utf-8?B?T1B0cFloWDRINmVYOThWT0VxcEpJKytqem5rQXByYnp4TFUwUlZaTXVyWDd0?=
 =?utf-8?B?Y2l0c1VFUTVyOVpyUDJWWDRYL0JEcTZaSlFhMmhMY2NNcGpLM0hHY1ZUTlJG?=
 =?utf-8?B?c01WWnRWNDNhUVFLUG0xb25xbU9pY3l5b0JMdkhsYVpkS2p6SnBpRDFZUU1I?=
 =?utf-8?B?ME5pWlZoUmcwSi9lektaSjcwbHFhOVFTM2ZtZHBNemcvUlNhSUswRUtndklr?=
 =?utf-8?B?RHA1TWZJVUp2aGo1K2NUWlA3TktCcVJEa2duckJUdVNWRjJJVVlNMllucXlP?=
 =?utf-8?B?WC9CRmpsUHZETlpIOU9KL3dmbW9QNmdjekJSRE1tY0dZRWkrTEQ4TURtem5o?=
 =?utf-8?B?c2xDU3pBcUhqRXgza3FPcUsrNmlseGI1REIvM3EyKzI0VHdZWFhWK2cydjlC?=
 =?utf-8?B?SVBHNENFaFpCWHhOaTIrK09yaTdLbzFjNzhGVjRUSG4zRzlGSDMvL3ZUSjJq?=
 =?utf-8?B?c2tmVlZob2dMR2dFL3gwUHhFS0JjYWx3NjBraDg0RGt4ZElWRVRiaTZMWVBY?=
 =?utf-8?B?ODNLMWVuSVhRVjlDU1pHMnh6UU9hY043MjZOb3RSMjJhOUhKYnlKUitRUTVX?=
 =?utf-8?B?Z0xDdUdEOGJTcFFPazRkMmNQUTkrK0ZFVzJFRVhIamJ3Vk9RQU1NZ0NpeHJK?=
 =?utf-8?B?WVowVnBzTUIwaFhVb2FoOVdZUU9JdFN1OGZVUHRXNXFPNkVBOGw4T2dsOWVE?=
 =?utf-8?B?aDROaWI2T0IyUURzVU9NOTVZamJveTZ3MC9YdEVGdWJVYml0NWpTdTFRUTBH?=
 =?utf-8?B?N2F2RVdMd3NkK2JsK28zNGdaOXRuMURKOHkxdWQzNVlmZlpTLzkxdnlKR3Fi?=
 =?utf-8?B?Y0RBOHlkcjY5UDZDaS9uZWpWaml6MTRPaVdRYWlTMmYyK21FaW10OU5WWGF6?=
 =?utf-8?B?NytCNUFQVWpESkNVNGdmUUR5TzZTNVJtM0NYS0xQRCtrREZHUlV0OGsvd3Nx?=
 =?utf-8?Q?+kw3APJCiKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhOUWZXSmh3TjNobnRHYjJqOFpYSEZjQzFONTdMWUw0MTNleDFQTUsxZHA1?=
 =?utf-8?B?dlA2b0grTXNwMnliUVcxaHNqdmR5Z0NLbE1PQ0ZCdlBMUGdOcGJSMWlQWlN4?=
 =?utf-8?B?KzZKNnhHekFqTUEyNzRUS0JwSk9kblprM0V6Mkdha042TEtxTEdkVUtLenZC?=
 =?utf-8?B?RzhmWDFvZ2JWV1NSOEpPcG5BckV2T0tZdFFKM1V0ZitpeG9zVUhkeXVjVzgr?=
 =?utf-8?B?elZabXA4Ni8yekZueDdCOUNhNzA1N2NqbkJENVl3amkrdXdPMjB6SThRRVFo?=
 =?utf-8?B?ejlVOFUxajVQeUhtalFMZDQzK1FYcEFkTmxnQWVlWFlxaGg4RHd6SENIU0Fk?=
 =?utf-8?B?blpWWVBnSjh1bCtNUlg0STNqb21kcC9LVjJwLzJQNldwK3RsN1FMblNQMzF0?=
 =?utf-8?B?SHphQy9Ebmtyei9yTTNsc0NGSEl1OTRodWcrOGNyNHdDdXZjeG1xd3UxNW9J?=
 =?utf-8?B?VUYzWGpaMGxuM0grMkFRUVMxVlNqT0tKNnJZd2daZHlMdys2L20rR3laT0pE?=
 =?utf-8?B?aFYyVG1kZFdpdnRxbnd1K2l2QUZvMzFZQ2FxaUhaaHlHTEJyays0MUp5MXJU?=
 =?utf-8?B?TVc2bnd1ZTIrTktLNnFZTDdEZ2sxbGlFcHhwMm1zM25iTDZLK2tGbWFyQkpS?=
 =?utf-8?B?VDRMdmZZc0ttMThPYm5GWHVIOEJ3U09ScjlveDlVTndyQThQS0tRTFB4U0Zh?=
 =?utf-8?B?dnpTMnNMNWI0Z28xT0tuaWl5VWFVS2tOcXgyNU4xL0NVbjc2NUxUTmFwUnVh?=
 =?utf-8?B?d09VN3NESzZnenZBYUhRWHBURE1qQ2x0TWw0TXRmRHQ2eHlkUG5hWmJMQ3JP?=
 =?utf-8?B?MjQ2eGw1SnlJSDFOZWlhTnZydmpiVUtKcWpmOU1IOW15bnlrdGdCa1JQb1Nk?=
 =?utf-8?B?N2YvK1ArYldNangzS1dZWXJMY25WMlpZL2VxT0k5cTVzdlh3VTVPdjRZMTlF?=
 =?utf-8?B?T0dFenN2L2ZwSW13bFdnU1YvNEVHb01tVTQrdEVuYTRpNUExTUcydmtHc21l?=
 =?utf-8?B?K0tUbFNyOW9FVTF5U2FJZEdJQlovZFlTNWFER2k3aS9CZ2pqZEY1KzJFdDBU?=
 =?utf-8?B?VGVUblpxZDlTWG5sZXdiZVdwMzFGdkxEL2hTRjk5T2FwSUFSazdZQ1lheEtl?=
 =?utf-8?B?UnJmSVlmVFE3T0xnaVg2REhaRTUrb1lOVEhscWFtRk41TDNYZjgyMVVPaDZm?=
 =?utf-8?B?ZUJzTUFmVndYaW1PZFJzVVhIai9RZkVId093Wk5pQm80ck93TlNrbXVINyt2?=
 =?utf-8?B?b00wcE5YaHpLbGY1c1lUNVlzck5ZYTlsMVlCUGNvMWFnRzZCWE5MbUl1bTlK?=
 =?utf-8?B?dU5jcEZnK1VYQWlxNzN0MkhkU0FjdWxMZTA2MXpnTWVBT2VaTTc2Y2ZQTVRP?=
 =?utf-8?B?WWlmZ0l2emxEZnQ5YnhGSG1zdHpyVGhiUXdsVllSQmpEakZPRlRQSTF3ODdz?=
 =?utf-8?B?WUYxdXhkQVFvZ0txSldwVktzaFhiNDUrK1VHSVYxMDdQNGxYaXdPcUtZTm5N?=
 =?utf-8?B?OVVjSXd2QjZMMmQ4S3pMVldoL2VBR3VLWXNBLzlZOW5YMGtOR2wwNUxXekFT?=
 =?utf-8?B?VnV5V0hOa0lYYjE5RXV0aE9QcXBPTEhXdGZNZGV6anRlQXlCZlJRNGpvVk94?=
 =?utf-8?B?WVJKLzI4YjZWL3BvQnBNdkViK20ycEUvemFsR096RU5MWkNxRXJCQVZPK2hU?=
 =?utf-8?B?TDN0SEcvYVlEejJSQlpMd3lDeHVaWVphaFVmYTJ5N2dCSmNEN3BEQStxd2pY?=
 =?utf-8?B?Mi8yOWttblRZRnNGYzlENERCb1pnMG1SUGJNSWpnTkxUdWR5MWNlVjBkNFcw?=
 =?utf-8?B?Q1hyRmtYaGxLbDJRSTQ1cmVhbkpiQXQzR2NueHZGdzd0NHh0Zm5VRmkyalZJ?=
 =?utf-8?B?a1M5bGdpYk15MHBCQVhFTUNXb1ljNEJweCtiWXRac1JOck9YTmFvM01Ha29B?=
 =?utf-8?B?dWEzeUpRQzdFenF1N0Fjd3RpV3ZybktTUDE1S3RUR1dCaVNhUnYyMlg4QmVa?=
 =?utf-8?B?TmZYWEJ1U3N0b294Yjd0ZEwvWkRxRkZnbUtwZVNYcWFrazBaUjhnNDBPZmxz?=
 =?utf-8?B?elU5WlJVa29tR2NROVpMUWV3Y2xJYWtxc1RjakJnMkN5WjRmWVJ6TTVuR2VG?=
 =?utf-8?Q?9BQMnEf/WU05qfqls+QEPwMlt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c783561e-3bc5-4c9f-6d0b-08ddaebe0037
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 23:15:22.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDMPV0wTR/OuCgjQY2V/mNAM9KLW1XzJ99aE3NL16rQx87fKT1ZWk8ryVj0zWphPYQJqzDlPq+xjOZKyCwsgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189


On 6/17/2025 11:57 AM, Thomas Fourier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Removing wrappers around `dma_map_XXX()` to prevent collision between
> 0 as a valid address and 0 as an error code.
> 
> Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> Another solution is to remove the wrappers altogether so that it doesn't
> call multiple times the `dma_mapping_error()`.  This also makes the code
> more similar to other calls of the DMA mapping API (even if wrappers
> around the DMA API are quite common, checking the return code of mapping
> in the wrapper does not seem to be common).

This is one solution, but this requires adding extra goto labels and 
pulling the print(s) outside of the helper functions. It also increases 
the size of the diff from a fixes patch that could be a few lines.

I would prefer returning DMA_MAPPING_ERROR from the 
ionic_tx_map_single() and ionic_tx_map_frag() on failure and checking 
for that in the callers.

Thanks,

Brett

> 
> Thomas
> 
>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 70 ++++++-------------
>   1 file changed, 22 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2ac59564ded1..1905790d0c4d 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -12,12 +12,7 @@
>   #include "ionic_lif.h"
>   #include "ionic_txrx.h"
> 
> -static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
> -                                     void *data, size_t len);
> 
> -static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
> -                                   const skb_frag_t *frag,
> -                                   size_t offset, size_t len);
> 
>   static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
>                                       struct ionic_tx_desc_info *desc_info);
> @@ -320,9 +315,9 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>                  dma_sync_single_for_device(q->dev, dma_addr,
>                                             len, DMA_TO_DEVICE);
>          } else /* XDP_REDIRECT */ {
> -               dma_addr = ionic_tx_map_single(q, frame->data, len);
> -               if (!dma_addr)
> -                       return -EIO;
> +               dma_addr = dma_map_single(q->dev, frame->data, len, DMA_TO_DEVICE);
> +               if (dma_mapping_error(q->dev, dma_addr))
> +                       goto dma_err;
>          }
> 
>          buf_info->dma_addr = dma_addr;
> @@ -355,11 +350,12 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>                                                             skb_frag_size(frag),
>                                                             DMA_TO_DEVICE);
>                          } else {
> -                               dma_addr = ionic_tx_map_frag(q, frag, 0,
> -                                                            skb_frag_size(frag));
> +                               dma_addr = skb_frag_dma_map(q->dev, frag, 0,
> +                                                           skb_frag_size(frag),
> +                                                           DMA_TO_DEVICE);
>                                  if (dma_mapping_error(q->dev, dma_addr)) {
>                                          ionic_tx_desc_unmap_bufs(q, desc_info);
> -                                       return -EIO;
> +                                       goto dma_err;
>                                  }
>                          }
>                          bi->dma_addr = dma_addr;
> @@ -388,6 +384,12 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>          ionic_txq_post(q, ring_doorbell);
> 
>          return 0;
> +
> +dma_err:
> +       net_warn_ratelimited("%s: DMA map failed on %s!\n",
> +                            dev_name(q->dev), q->name);
> +       q_to_tx_stats(q)->dma_map_err++;
> +       return -EIO;
>   }
> 
>   int ionic_xdp_xmit(struct net_device *netdev, int n,
> @@ -1072,38 +1074,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
>          return rx_work_done;
>   }
> 
> -static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
> -                                     void *data, size_t len)
> -{
> -       struct device *dev = q->dev;
> -       dma_addr_t dma_addr;
> -
> -       dma_addr = dma_map_single(dev, data, len, DMA_TO_DEVICE);
> -       if (unlikely(dma_mapping_error(dev, dma_addr))) {
> -               net_warn_ratelimited("%s: DMA single map failed on %s!\n",
> -                                    dev_name(dev), q->name);
> -               q_to_tx_stats(q)->dma_map_err++;
> -               return 0;
> -       }
> -       return dma_addr;
> -}
> -
> -static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
> -                                   const skb_frag_t *frag,
> -                                   size_t offset, size_t len)
> -{
> -       struct device *dev = q->dev;
> -       dma_addr_t dma_addr;
> -
> -       dma_addr = skb_frag_dma_map(dev, frag, offset, len, DMA_TO_DEVICE);
> -       if (unlikely(dma_mapping_error(dev, dma_addr))) {
> -               net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
> -                                    dev_name(dev), q->name);
> -               q_to_tx_stats(q)->dma_map_err++;
> -               return 0;
> -       }
> -       return dma_addr;
> -}
> 
>   static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
>                              struct ionic_tx_desc_info *desc_info)
> @@ -1115,9 +1085,9 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
>          skb_frag_t *frag;
>          int frag_idx;
> 
> -       dma_addr = ionic_tx_map_single(q, skb->data, skb_headlen(skb));
> -       if (!dma_addr)
> -               return -EIO;
> +       dma_addr = dma_map_single(q->dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
> +       if (dma_mapping_error(q->dev, dma_addr))
> +               goto dma_early_fail;
>          buf_info->dma_addr = dma_addr;
>          buf_info->len = skb_headlen(skb);
>          buf_info++;
> @@ -1125,8 +1095,8 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
>          frag = skb_shinfo(skb)->frags;
>          nfrags = skb_shinfo(skb)->nr_frags;
>          for (frag_idx = 0; frag_idx < nfrags; frag_idx++, frag++) {
> -               dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
> -               if (!dma_addr)
> +               dma_addr = skb_frag_dma_map(q->dev, frag, 0, skb_frag_size(frag), DMA_TO_DEVICE);
> +               if (dma_mapping_error(q->dev, dma_addr))
>                          goto dma_fail;
>                  buf_info->dma_addr = dma_addr;
>                  buf_info->len = skb_frag_size(frag);
> @@ -1147,6 +1117,10 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
>          }
>          dma_unmap_single(dev, desc_info->bufs[0].dma_addr,
>                           desc_info->bufs[0].len, DMA_TO_DEVICE);
> +dma_early_fail:
> +       net_warn_ratelimited("%s: DMA map failed on %s!\n",
> +                            dev_name(dev), q->name);
> +       q_to_tx_stats(q)->dma_map_err++;
>          return -EIO;
>   }
> 
> --
> 2.43.0
> 


