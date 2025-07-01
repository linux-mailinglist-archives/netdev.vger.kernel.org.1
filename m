Return-Path: <netdev+bounces-202949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF145AEFDFE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EFC4A276B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA45275845;
	Tue,  1 Jul 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGb4KQ4u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E62727E2;
	Tue,  1 Jul 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383427; cv=fail; b=GAWjO2Kt/qBMMXvhT90Jfp07U7LLFoDcT33qxAxH1mLO2PlmZ4Wyq8DFYj1WJO1LkhHhKAg5TMNg5mUCNXpIjhGHhQVGhq+X2D5HNz2xr4F6qML9Binr9e86i2vBZVBRDQ5ZS2DAM+yedqIX5ReF/vamGGOSJ1tITW4Ck+mL6p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383427; c=relaxed/simple;
	bh=tZnVbGNpVri9lDX5R+33XjUBhgEKE0JOxCV0HQ+9DIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IGbh48wKzSGs5fOzuE4AuH/LNAVhMdhtimJKhk2qK072ZyXlCZt+rdeNDYEZdjdOezJ3F4X4DM9A5IsBo0GvoTv8Rfz0mtte1XRWkn+cXSLqYORa06+3vRIWwCVi3oznAgHoXHK4TKGXW47du5IeH1wT4Lc/kvvTJDebNWLe9ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGb4KQ4u; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmUWltEQgeihcBC3TYPQLt6WqcU01fAjcPW6I5KWZeZlEKeXOim8uc2CD/hb73tDBy9Vo8z7xY8MFbNWASNALUFO3B7khrwFmTEBxZOOmSl5zjwLRKbesBjfmdUMZuOllk+fQZIzshsC30m3R6dHO/0anatMgKt01JdkzpakUqXYtWFXWIHm00iDzxr4Ij+/M5rglqDI0rx4yPkc8Rpfh5VXjzp7RukMCKl5cg9HwF1EWk17WlKx79cJC89LTP6acArJ1VNExDFNoR2dBMkEn6CjZkUDOC4lgsgfJAn37wmHwSlKXtjawaoe0e/LA4t67XbQAe9vydE2W0BbMF67sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W34sZAl3I5t5kcqB6Iwe4PgmYiDpjtg89RdOq1EHRIo=;
 b=cnuBllr5zKVJwyXVKWBaxqQSWdtG9H54o5OEozY9Itzlul0QHM8lnFupdyBxOT5KaPudJQzlSu1F80GnEWqv3YSEu6/yPja/CJn5pAzhnyVJUBRxzMqEzNrlRokF4U6k1xorfD7qERMygd/BsvVN+PxoHfRQidd9632wLlItnRAObXhyqzwTRtiQtNEhJD5PU5fIKaQjbsAxkXvMu+Q8Lz+GeMfPYrHKxuW0pyL4UDwqjypHBzANo6FDRb8CfcWEWNA70k1kakj2jCppLPf+udA1V/E3ydJ5zAsrVgjEqfNzEaH56KEY9FNoJQ/jUpYOwAaWy4lvk5XecdWEFPUFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W34sZAl3I5t5kcqB6Iwe4PgmYiDpjtg89RdOq1EHRIo=;
 b=JGb4KQ4uhEyAp6vI5Z5qgHn/BydxmLU25sdMlgb2wP7NqXbbw3NtF+KcvMSob20QkjGh+Mk2PJeoDkjwoZzrgiOz8QO6qsqqc9+0nL8DREDvpq+5kFkyzWJuAyyOC0Kbw0xymjZkbzbdRP5GLtXrjMEnxc6Dko5/auZwAszHZ8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Tue, 1 Jul
 2025 15:23:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 15:23:42 +0000
Message-ID: <ac4229b6-cf98-4be2-967f-4161f9bbe0de@amd.com>
Date: Tue, 1 Jul 2025 16:23:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/22] cxl: Support dpa initialization without a
 mailbox
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
 <20250627094214.000036e6@huawei.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627094214.000036e6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0016.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: fa375d3b-64d8-4cc3-6d9f-08ddb8b34342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWwxdGFzYlJnNGNqOWpIekI3S29nTFVjNzNKQ05idmo4a0hyU0ZPTHlRTlhI?=
 =?utf-8?B?S1luRG9hYmQ1dXlmWE9VbHRFREJUT09FUXh3R3ZWN0x2OEc4cFZIdWoyN3gz?=
 =?utf-8?B?REFZWUFYOGkwNXBvbnV6VlVkL09TY2RGU3Q3U0JuaUtHV2w5OEhRMUxlTElG?=
 =?utf-8?B?U0lvbk15RzJyQ1hJazUxdXJvbVNUU0hOYVBoeDlEc1g3RXR0TXlVQytzWi9E?=
 =?utf-8?B?bVR5b2doMSsxcEdPcUpNRXYwK0pzR1ZaWFJlMVJhWjNmNXdnRmdydHZaUGlK?=
 =?utf-8?B?WFFSTjdtd091ekV3YmtBMGRlOTNtbjVjWDFRYm5UN3RTcGMvdDMzcW1aUHRw?=
 =?utf-8?B?SUNEVE9RSjlhb2lNNW5lWWtObjk5OWxlNXk4THZKQjAya0hGYjArVDRjT3JV?=
 =?utf-8?B?YXRCdDhNUEI4MTY1SjlIZUFkMnQ5TVNxbDlVY1JLNFVJaVVhTXNTYzNxWGhh?=
 =?utf-8?B?TXpOUjdRSklWU0dkNjBydmljK1B0NmJMWGRGMHpBamFsbkMzTVNpYmlSeXZx?=
 =?utf-8?B?bnJ6VFBodnlNaXZyK2dnSk5HQjUxb0R3a0VUQW9rZ2ZoNk5mVDlOUDkrQlFH?=
 =?utf-8?B?aFc5WkNYTi82M1hDZVdRSEwyN1pjZ2tmT2lBTTlmVVlXZjFGQjhPbVl4MnQ5?=
 =?utf-8?B?TXdEVE91WVQzZzllWkMzU01taFYxVlBHNnBBUHE1a2VKQ1ljTTBjcW9KYitN?=
 =?utf-8?B?dnlUMityOHV0cHc2QU5yQVBTWDE0UWxOM0xrUTFCWXBrY05RamRSTTdqNGF6?=
 =?utf-8?B?ajN1eXJOYUNxS2xTZzNGWi91N0xWWW9vUXAwSmx0SFpZMFBVWE1CaXNZYzVn?=
 =?utf-8?B?WnUxbjY2b1J1a0FlS3JJai9Hdjd6bWJ6RktJZ3ZoeUlJd1RIQTRUUGRaU3Bk?=
 =?utf-8?B?L0k1SWxzSUpWOC93eG9od0Rzb0w0bU4vWUxPaGUza0QwTGQrQkFPb3lIQkRV?=
 =?utf-8?B?WDVURmRNODM0T0dsRGZZeFdxY0pmUmJ4ZUo0dDZwcXpMU1lGeTY4QldBdzNo?=
 =?utf-8?B?SktBS3lIRlFyQmwyOXFrMkhSanQ4YTdETERpZkxMREM0SDRsb2dlaXVPQjJx?=
 =?utf-8?B?Y25xaC9XcXUwMWFjYXFHUGYrKzdlcENOVHgxendHRWVYNnpFRWNXMGVBRDUx?=
 =?utf-8?B?a21DaDF0czVvV041dTB3Z21UR0RKSWVaSEhiOFcreXlUT2cwVkdlQWZlS3l4?=
 =?utf-8?B?MDVUaG1TSnVMeDQvTUpVbHEwYWFabFVqRnB4cWJCSWVhZGxqcDJndXRyYkYw?=
 =?utf-8?B?VWdyTW52S2lXUmJva2xnamFiNUFkcVZ1NUhVc3pocmtvL2FjaVN4cmhRY29I?=
 =?utf-8?B?UVQ5ZmpDczh0UUlVS0JNVExFTXc3MnhEVjV4cHdlamRqK1dsOWdYV2tjL2cy?=
 =?utf-8?B?eEtQQko5MFh2TzZoNmkyejBPMmR1Qkl2NjE2MC81S1VJbE5DUitKYzNUT1Y5?=
 =?utf-8?B?YU9MN0N3dG0xVU9mL0ZVTFg0d2h5WlpjRC9zdDdXaVVWQUY1akp2elZnRXVK?=
 =?utf-8?B?N0xXVG1qRVZLWjN3Mk1TYmIyQ0dIb3VZL0s1Q0Qzb05sUlRNKzNTZnNtaWFl?=
 =?utf-8?B?V1FCRFpFTHpSVFFOcGgrYVcrLzVlRFBQL1JoRkxGb2FDcTdCZHJqTWVLeUY2?=
 =?utf-8?B?SjVBai9sRXd0eFJ0TUdveEJDV1RYQ2MwZHNjVWdTQXZIbnVVeTY0Wk5KbmxE?=
 =?utf-8?B?cE94Mzd2UXlVbzh6SlJ6Si9oOHdUZjQwclcxUTJPOThPc2p3SDFHeDJpU0JK?=
 =?utf-8?B?bGlRa0Z6RlU5MWNRVUNlZmJIdXJMb083ZU1oNWRMV2VDYzhTcUNjWjJVVXNi?=
 =?utf-8?B?U0EwbktySHEza3hwcWFaWnpMWStPWUxvUnN2TDNqdStQUWhReU1sMEVqaHYz?=
 =?utf-8?B?Z2VFOFgrVlh5YUFEWThMYXg4UHBkWTg4M1hIS2h5QVJWVnlnaG02UjZqcCt6?=
 =?utf-8?Q?8L316bVOmGI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lqS1JqNU0wSGFWblJPZGROQnBSMllpcFlwaWNZakpEOGlYM0o5emFldVJn?=
 =?utf-8?B?MEZTelZKdURVb0J0SDc5aWdPVzY2Q240SExJQWdhc3V3cjRjY0JnRUk3U2Jj?=
 =?utf-8?B?ODFyUzB5Y2tPdUgzOTBTTXFVVjArem40K2pyY2Z5Rkt4NFJNaWRuQTlFR3ps?=
 =?utf-8?B?VWFHVnhYRkdJRHpMUkZLRExjbWpRTjZsSERyVTVURVNBVFV1RzlCMGhsL3Bn?=
 =?utf-8?B?bWJjaC9IR2g0Q0NBdzZLWnVBejVJb3pROTk5Z2xVRjdFWHVJRWRENEcweVJQ?=
 =?utf-8?B?eFJJMFd1bElNQnVlUjZlbnpNTnB0RU1oKzRONUpQdlhTUDZSV1kvc2UwdjhU?=
 =?utf-8?B?dTQ3bXRMRXFsaHhWMEp6NmVBVVI3elZXTndBTlk5ODhjdDZ2Q1RxYVp2b3oz?=
 =?utf-8?B?V0w1WDNjN29BVWNORmhNMW9kbHloQjNmN1AvSTI3WmV3YXBLbmduK2hUQklM?=
 =?utf-8?B?bGliM1JVNklXd1M5YmVXeHRXTlFtZisxSWgycGpnUmlqL2FWb2YrQlBCdkZr?=
 =?utf-8?B?b2Y1NDVPT05lY01VNldNMk1mRnNCZzhMd1h3Rm9PeUQrNGJraytoM2M0dnNy?=
 =?utf-8?B?aWFaVDVNY25iYlo5MUtGR21XMUFzejRSUENla05NRVdaaXFKcFA4YS9wb3Vo?=
 =?utf-8?B?RXVLbmNSRncwTHZEa2lTQ3dnOE1OQ1hGWGVXK083ZEtlWUtXRVBIeWhZZEx5?=
 =?utf-8?B?eFY2YlM2ZnZjTlFvZmVqbENOa0RIR3RJMThsSmh1RVNKMWZRaDU0ZzFrTFlE?=
 =?utf-8?B?M1N4eUhjNWhDaXQwczNQdWpjKzdkYkFiZGJzbU5ReWhaNDVabEFJUGJHd1Y4?=
 =?utf-8?B?dWNiYXdybUtwbjcwQVBiV0VaN1FVd0Fnb0tTQnJyZU5Xei9xcXBoVWFVK0pa?=
 =?utf-8?B?akdEV09yWDA5NWtoWDBvNGZaSml5dHdSc0dVb3lvRENpMmlhV1JIK1NlM3NL?=
 =?utf-8?B?MGtSVlRTRnZQaDhzMm5aVG9aZTVXV1pqdVo0Y09YK2o5dkZWeTdraWZsak15?=
 =?utf-8?B?dC9lWW02cm5IS3kzZXpjSWR2eFRpN1dmL2djQXJjc2JFa2Zhak0wZmRvWXBH?=
 =?utf-8?B?VkVuQitXQkNsWXNUTHk3dXN3cDZkRjd1Z0NiMVlqMk1qZmJXcEJkb3hpZmVJ?=
 =?utf-8?B?U0xxcmo4ZTlTNHBYNFJCQXlzR3hRbXU0VHFVblRyamlLRkhYVWh6YXRCdVRG?=
 =?utf-8?B?bEI2clNQRHF3eENCRTdLZFkyTVNhdEUrWXl6bG0wNmxPcndvYm1mTS8vT0pN?=
 =?utf-8?B?R1h4aXlLNmE1bTRVRkdlRTArbFFHR2dueExXZ0ZxSHFNWERpZFdDd2R5alE4?=
 =?utf-8?B?OUVvS1RKdGI2SDJCVDBvZEhqVDhHVFRaczFTUDExLzd1VmtxamdCNkhWRkxz?=
 =?utf-8?B?V3UrZUNqUjNTMVZGQ0d0czdTNnBhL2xaUzBqbFVTMDFUeXdFbjcvZlhXNEEx?=
 =?utf-8?B?WUY0dzZXdjdGZ2NVM2xla1pJLzlsMERMbW1uUzBLS0Njc2dua1E1WVI4SXpM?=
 =?utf-8?B?TmRrcVJ6MnJ6QlhadDRnT0YxaVZhdkU3aDFHVkR2eFRwZ0RLTXkrdjBJMGlw?=
 =?utf-8?B?Rkd3ZjQwU2FEZWRLL09oQzRzUmNKbTFUNE0rL3RxeHFUcFBxZnU3dlBKOTNa?=
 =?utf-8?B?YktkOWg0NWIyM3ZBd0xEb1FsSHNibjhJbFgxRVEveFc1eEJ1Qm1BWEl2SXNx?=
 =?utf-8?B?VnRwMXdzaVRoZTVacm8xclMyamZDZWVsU1hCcmg0NEVXdk5tbXJXM3pOM3RL?=
 =?utf-8?B?U0dzM2tBRG5EK1hpMGtOZnJFWmVDa2RzdzJ1djlrblpqVlhiMm4rVVQwQWhP?=
 =?utf-8?B?ZElYRUgzMndmc3lZdTJPMWRHWVNEazJvWjZMWHVyaXBPQnY5WDhZNnVhUlRZ?=
 =?utf-8?B?QmlZYVBiM21xUS9wWFpVL2RNUXFoSnY2eThkb01GQjBPR3FKN2dDalhXU0Ux?=
 =?utf-8?B?a1AvUVVlVGRGdy9QV2JwNkxqZGs3Ulo1MnNmTEo2cEYxSXVGdVpQN0kwL2dQ?=
 =?utf-8?B?RFdHVG5hSW5XY3lpWldKbElOcGw4NDV1QjZleXQ3aWtQZWo3VHNvMmZaNjlR?=
 =?utf-8?B?VWNJN1VnYlArZHRmd2dTRGw4c0VuVy9wMnRsUEpHalM3YlU2TStZNFR0ZlFT?=
 =?utf-8?Q?cINCHFpjMB3vm50jAsPFndz9P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa375d3b-64d8-4cc3-6d9f-08ddb8b34342
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:23:42.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 539FRdBv06o8i+ROiG9ryovqQBl0MquAfVvk6Uq//PkIXPlG4U7A3VmQtxrAdb79vwS60McpZO+DQ/MsTEmq8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319


On 6/27/25 09:42, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:39 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for DPA initialization.
>>
>> Allow a Type2 driver to initialize DPA simply by giving the size of its
>> volatile hardware partition.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> º
> ?  Looks like an accidental degree symbol.


Yes.


>> ---
>>   drivers/cxl/core/mbox.c | 17 +++++++++++++++++
> Location make sense?   I'd like some reasoning text for that in the patch
> description.  After all whole point is this isn't a mailbox thing!
>
> Maybe moving add_part and this to somewhere more general makes sense?


As David suggests, I'll move it to memdev.c


Thanks


>>   include/cxl/cxl.h       |  1 +
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d78f6039f997..d3b4ba5214d5 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1284,6 +1284,23 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>   	info->nr_partitions++;
>>   }
>>   
>> +/**
>> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
>> + *
>> + * @cxlds: pointer to cxl_dev_state
>> + * @capacity: device volatile memory size
>> + */
>> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>> +{
>> +	struct cxl_dpa_info range_info = {
>> +		.size = capacity,
>> +	};
>> +
>> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
>> +	cxl_dpa_setup(cxlds, &range_info);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
>> +
>>   int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>   {
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 0810c18d7aef..4975ead488b4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -231,4 +231,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>   			   struct cxl_component_regs *regs,
>>   			   unsigned long map_mask);
>> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   #endif /* __CXL_CXL_H__ */

