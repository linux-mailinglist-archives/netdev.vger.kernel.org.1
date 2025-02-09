Return-Path: <netdev+bounces-164394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDFBA2DB87
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 08:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1612165B80
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E221487E9;
	Sun,  9 Feb 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyL5bHZY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4D1487E1;
	Sun,  9 Feb 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739087978; cv=fail; b=PdIDktIdwRnySxQ0VbEjspVy70kFUelJCXMWZyrmEY65QXuOThRZlleQgZbItNCaodvFD/F0tPrtC6YZycbAWzUKW7WE3ZrVAfHtcwuNH3cPEvIaS1qBbCU3zam+pgl7LPlXJx3NEESqrJ1tLBXKFjlR2JVKE2bRWyQ1TGUiH5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739087978; c=relaxed/simple;
	bh=51ih5aNuVAVFhm69bi1jlAi72IXNX+H64S9OEbwsgwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fg8lZC9XsT72h3C4nYLfifWd7rqA8Yj/fqfMcbB26KjVcs9q5nN2BAnVEM123YvH5LIRr5odJ6BCRXOOyCKNk56hkD4B0f4hXJ3tBGokbGhZy3jegziARXSRounWD0VRdiJ2cFoyV9cE9QjfZ9zgrWghhKiXSDP9WqrX04Yvo5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyL5bHZY; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqlh94ZqohscKc8duz5QiDxMhYQQADGKl3yeqsfle2PlpJicrYRew0X9w6M/N3oy14vD+nGRo0rKL+HFbkWwludmcrf5+ssGom7I3SsVvms3xJ+Addg54zIfB/6AlZhWBJjY0ldnRZUaO2wEa60K+iBedYqR/kdM9BLKj24L+o5IxyLL6wdxjtBezPYf0fSgeCu5LPtp6nU7YdUX76uDQqpBOM5wwauSoCXnYdIbcdCdsaOODLoP4uyqqGF2xrEyjXXcAvrORUfPR3NKk5BlmIDSkDGoX6KctF/+ZgY2a8VTxStzbCZdwaOkWQOUViu3uYY5Gu0tZpZYEHlDxl4X3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EaF6/JhljZVvQHTGDX3plu6dHRDH0D/DIjamkCoP5s=;
 b=uuIayDsLng7KasZfYEGgNeUOzFKVh5ib1C9Mq1m3it5GktkUXm1ZhvpqiOHjr/80AXFRVP0nfKDvLorxCfPWRyG2cTzai3YEJ9DNm+gnH/mWd440nDHKiPQREWahuKBSunkJbHcZjy/RAZQW5aq9sD0S37Bq3eNM6VCLk+JY8EJ3gbZ6VuSSdp99nKKkP6pt/aE7PPTTlw3Kk30MhXhR4lOYf96uLTLg/TD6n7VJx/a/5qzTzg44R98myL8sTzWzVA0i9y94lNDqurPDwuwdgbrN6RlMr8WL024GFYUtdoQTNtEy7+fLJliFUwp0Q3YpZZhnQG9o5ys+9POoYkxdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EaF6/JhljZVvQHTGDX3plu6dHRDH0D/DIjamkCoP5s=;
 b=OyL5bHZY0ONO/Ep9sJLkXWs9qdy3uuYeF42h82vduRjfZqORb9BdsuV961yu9dtLRThqxE+4fVW6uotBjk8MwciLNsum71ev+/2/NDtXksiGGetQ1QfQ9l962wMGrYj2Xc0tpq5fe0qiCUzcX6q3ga3VUqA+UJu38cz50ESpWcX6inqnP0jCR/RESA6e8TfDm6wEtDMB9ZBOCkXALUFIc2kCapYUl/iS43P8sOEZGL9TflY/jWVpPOk54aknuqBc3cX3Nc+hvt+12t3Y4nB34r/TD1pTklz2IcOaXCdF60J7ok5kdU7+Vx1Ik3ZqDWXsiRo8SXaMyXuL35SadazBhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 07:59:35 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Sun, 9 Feb 2025
 07:59:35 +0000
Message-ID: <29abf6ba-9fda-4b41-834b-120b9cfc482f@nvidia.com>
Date: Sun, 9 Feb 2025 09:59:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] ethtool: Symmetric OR-XOR RSS hash
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-doc@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
 <20250205135341.542720-2-gal@nvidia.com> <20250206173142.79a9ef3c@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250206173142.79a9ef3c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: ee457019-61bd-488d-1cde-08dd48dfb173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3JyWTRXYmJzM2o2eGpIMElIZUpUYWpPL0Zaa3BNek4rUzRtNmVoR25BUGZG?=
 =?utf-8?B?a2xveC9HMzUxdXFvZUFEQ0Y3YTFackpSRDNHeVRIUy8xZk5HYlU5d21tbDFH?=
 =?utf-8?B?L1JCSUZmUWJzT0o1ZDlIT0ptTXpVaytmMGtVLzQ2cjcxbCsyRGJQTS91MEVK?=
 =?utf-8?B?MUpFZzNHNVcwWkNjWnhrZnY1TmRoWFhQcTVXQXcrTlhLZTFjdlFuS0V1eEt3?=
 =?utf-8?B?RC9kODZySFlZajlicnhtVCt3ZGNvMFlOajRoU3lqZFo1QkFjK0prNFhzMTBB?=
 =?utf-8?B?cVU4R1VYUlk4TW5pOWVSak9oQWxUbjB6bCtTTitPUXM5cUJ2NVhwY1IzMTVV?=
 =?utf-8?B?Rjc3cS8rZmUweHlWeEp4bGF5VWpCK0pNSS9QUS91dk5ELzB1UDhGQnVMRHNG?=
 =?utf-8?B?eEEyZmVyK1dTUnJkb2M0dnlJMXpONUN0N25ybWRUckpkOFQ4NmQ0VmxzcFB6?=
 =?utf-8?B?SEN4NFFCS0dTZ1BaYnZNbUhWaXRoM2RRTUJTUkhwdGVZNWVhb1liMG9SVW9k?=
 =?utf-8?B?bUVpSkdOV1JjTlNlK1Z3MzZ5QmphSllMamtmWDJuNWVnM0RqQytDZ1c5cDZB?=
 =?utf-8?B?Ulhxc1BvTHZaTTVKaVdqbWNXZnhlVDBHbXM4VmhiYUwrRXhaMFFFdzgyZGRx?=
 =?utf-8?B?RDRDOFptRUlKNjhyNzlrU0VVQnZpQzNJWnNBSEpiS1luR3NDK1F6QWcveEdN?=
 =?utf-8?B?bUdCVkkxcE94SzVSUUNzU1NnMmlPVDlqbFBVNVVwOXV5QXl3UnBaT1h2citr?=
 =?utf-8?B?Nmt1RWtHWlduMGZIeWNoV3ZmSkR5ZFJQYVNrVmpIVEFVdlBWOWdGQlFYTHRv?=
 =?utf-8?B?RkhjNjFkLzFhaGdXL01KdVVnMThUS3hDQUgraXF0amRKVGhmL3gvVlA0Q2tW?=
 =?utf-8?B?L2Y0U0s3eE9JSDVXMnNYaExEOEJRMjhRWkVlN3h0RXQ0VzVoSkNDejYzd0JH?=
 =?utf-8?B?S2Z0UG9EdS9kQVA4bTF5VFFoTWZIVHJVMDd1YlU5bE4yakMycDg2bjZPRmtp?=
 =?utf-8?B?elZEM0gxTlZkVzEyWVZpQ1FIU2tKNEFGUEFWbHVoUlBrb1FNT3I3d013bi9j?=
 =?utf-8?B?dURiaVg4NG5QdHNpVFVySm4xa1dVb1ltTUtiZHJ6NVN1NzVWNE9ZcE44Rkgw?=
 =?utf-8?B?RXlRTHlhYTZobGVyVFFEOERMcGE4VjVhNDI1QnRzcGpBL2xubHRodC9rOGhY?=
 =?utf-8?B?Rk96TEtFMEI4OUZPR3RGbzJ0Z0wvc3NEZGlKMVNMSHh0RDJna1FvL24reThv?=
 =?utf-8?B?VTJURkJHaFV1Ry9nRTJMdXd0UUdaVG5FTktOUkxSejU1YTFaWWdqVEl3MWRo?=
 =?utf-8?B?czFiSE9vSzNGZ2JIazYxQWRHd2FSNUpwa0xPblRUNnduTStUc21sZkRUUWpJ?=
 =?utf-8?B?ZjFHckRWVEpVaGRvL3IyeDZiTmI0UzRlWS9xaTk5a0tHczlzTVVPM1QvSHh4?=
 =?utf-8?B?VnJOV3VwSVp6T2ZxYTBsd0diRXp3WEpmcUN4TkdtaW4xZjk5d3NuUGVFMkVD?=
 =?utf-8?B?QXN0bUNKTVV5QUx6VkF2NSs4bFJuZnR6b0k0akxRMkk2NCtKTkhCVFdSNTRv?=
 =?utf-8?B?bnBJVzhoNFBZd2ljb25ZMHVmRWRpNFpSQkVSVjZYemQyaUhlbzBNdzB4WC9a?=
 =?utf-8?B?cTRxS1BhR3JjTUhSeEVBZStya2JLZFBYaWdqTWo5NkJYSi9OdmtQamdxYzNI?=
 =?utf-8?B?d1ppWmJVckkxNVhhSHlhWUpLa2dDaGQzNUZjM0dLejBqWVJTV1FRb3dKTmxr?=
 =?utf-8?B?VWdoOVIwQlJYaENqcUpPbElrL0REWklxa3pqcisvZDNoVmNYcWQvaUhSaVdJ?=
 =?utf-8?B?TGxpYVIrNEo4cEgwQjI2TTFKVzhick93bXNmbThZbHpSTTBhdTc5ZFNzV3Fy?=
 =?utf-8?Q?pB11/eQ7XwT0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2FCSE9vTVFxZkJYOTFrR2FkL05XNjFHWkFIUmR2aHNudzk0U3FHZmFFdy9p?=
 =?utf-8?B?RW0wV2dKS25DVllRY1hDZURaZld3dlVkV0VPMWFBeXN3NlBxc1RVRU5nOFc1?=
 =?utf-8?B?ZU8wOGs3d1IzcTcwUm5GSDZpTWhRc2VURHBoUVMwOEtRSFRvSGVsWS9kMzh6?=
 =?utf-8?B?NE4rKysxMFJlYnhjdHdtZzJpdnVFeUdPNEorWlJ1emIvaU42UFpuTmJPeUVh?=
 =?utf-8?B?eXkyQ3NvZm5rZWdrM2hQUUhRMUFVMXU2bzhFbXRIMnN5NzExNEE3QWlzV3Fx?=
 =?utf-8?B?RFUwNTFBV3UxN05mYW9kcW9GN1ZtQVgyL0NjOGE0WjhwZ2sxZEhyc0wyWTJI?=
 =?utf-8?B?eVhlK0hTc1JDNHhXUXFSSXZiYW9PeWlKUjBhYlQ3R3YrcG5UQkdhYStuRHFI?=
 =?utf-8?B?VlRyb0NUZGlXeFdKRDhLY3VkWmVhaWoxeUNoaTBJdm9IQ3kvNW1ZRkp3WmpQ?=
 =?utf-8?B?Yktsc21mZGVDaG5ndzZzSC9JbnJmQ0pScCttc2NRTlh0anFibERZVUQxZnNT?=
 =?utf-8?B?Q2dCdzZHWTY2ZXUzTUFWQjN0MFp4Z2IySFNJalFOZ2RjYkZmQkd4dXRUYSs0?=
 =?utf-8?B?UDBUaGJyNTI1a0w4dnVncGtoNGhVak1OV2tPdEg0dVdGZEdqZ0M3OFdHOGZo?=
 =?utf-8?B?WVhBaXkwczl3dktzMkpDUVZESCtYckQ0V2wraXdYVWZ5b0xhMGxqZlhnSHFV?=
 =?utf-8?B?Sk9GdE54TkpxQmZLYUw2aFBVNWlvSFFkbjhDS2Rhdy8yWUxzcGdVOFZoNVNx?=
 =?utf-8?B?YW84S3ZJZ3dFeHBUOEpRNTcwbnBKTnpmNnZVTnNhRlMwcVY2aUdIYWZPZ09i?=
 =?utf-8?B?WDlHTmtlUGtmWDNGNDU3TVV2ZHdCYVJuRXpLQ21ybEhEVi9wTTcvQ2JWa3M4?=
 =?utf-8?B?TGRMcDI4ZFU5VFFRZDdmUlZKKzlkcit4bWVFOFJmRnphbHRORmUvcGsyVzhN?=
 =?utf-8?B?YlQ1djFHQTRaSzJNOWM2WHJLaXFxS01Vem51NmJnTjJvRWJGRXBGZlM2Mndq?=
 =?utf-8?B?YTdZVk9NeWpIMEhiVWJKNVFnNFdHS1RjNU83RzJvUFdYOVVScTd2QzJHaEFB?=
 =?utf-8?B?ZXNockNYdlZsQ0lTSkV3SWtMMjllVFZ2S1hTRVk1dndpbFB3ZG9xam1peFho?=
 =?utf-8?B?bkZnZnlBWkM5d1lNcWJXMVZ5d09Mc3lZamZjOHBlM2xoSU5kTE5XZDcyOGMz?=
 =?utf-8?B?VjR6bit4VEpyQ3dzN3FzMk92ejVCTUxVT00zYlZJVkpvdS9QYTNtMUdvSU9i?=
 =?utf-8?B?dy9JSjZadmRqbFBFV2JMVEZ2R1F0OXJNMVpCVlp3MjdwaUVLRmNTK2hiLytN?=
 =?utf-8?B?OFFOVmQwTUNYbmRxRTdSUWZSTW9vVHpLUlo2WFJabjc1TkJ1T3NOWmgySklw?=
 =?utf-8?B?cDBVMmRxK0J1TEMzL21Zd3hxWmdway9LZ01XUTNXcFR1ZVcvRU13TEZFZjNL?=
 =?utf-8?B?NE43OHhwcE81dUtpcGdtTHdwM2RkMStrT1RnYVEyRHZwK0h6aTFmaC9aVGdt?=
 =?utf-8?B?d25jMEhoLzhEZGRmWjhCV1Y0SUZ0a1llVkQzU21XOTRwTkg2OXh1Mi9wZjRm?=
 =?utf-8?B?WnM3Z2R1Yk4wNTd0Q1ZRMUszY3Bra21pbnVETHZFNTNoem9yaWFNekw5VTJv?=
 =?utf-8?B?b1BaQkdaVU45L3RRSjBIcWRDUGd3SlhmVTdDZG0reUlvUzJRSDNJVldtci81?=
 =?utf-8?B?bTZSMVJIeUUzclBXNFhtTDhncnk1RC9KNkdUMWJFOHEzaXdVbkR1bEtPODRM?=
 =?utf-8?B?L2dqeWIrV25EZUMxNkVldUZqME5Vd3k3NlJ3YU95eHc4SEZwK2k3VENuQksw?=
 =?utf-8?B?MEM3OTZvR0Q4NUN1eWw2dmRqRVM0NG5LR3p1MzBqdTFoTFJOMUZQOWJVNGpw?=
 =?utf-8?B?NU1hczFPcXltYTVIRW0vbWVVQzk2U01RNHVFd0VsU3dUNjFJVTJCWnJFYkJB?=
 =?utf-8?B?L1FXOGg3cC9JOXhvdDd5eU41dG8yK0pSbkxWVksvNVJaOVFkQ3l2QWJrMXdL?=
 =?utf-8?B?TCtSbnZpNCtwOVlnY0ZReGlNZGRvWHovZTh3SVRKaUlzaWZMUHdua2cvSTMx?=
 =?utf-8?B?UEIrQnFiVG1zNXNvRVdkUnk4OXllelRacjFhT2E4c2xPdWtoSTIzMktSd3Uz?=
 =?utf-8?Q?LZ6uluM1QRJSPQmoZMRZ2yYAZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee457019-61bd-488d-1cde-08dd48dfb173
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 07:59:35.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rFtxRYiCgLAI58+At1cS3WtQ3c0C49bxYJdCIYaIbOlpDxModg6K/X0mvvziMBb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

On 07/02/2025 3:31, Jakub Kicinski wrote:
> On Wed, 5 Feb 2025 15:53:40 +0200 Gal Pressman wrote:
>> @@ -997,7 +996,7 @@ struct kernel_ethtool_ts_info {
>>  struct ethtool_ops {
>>  	u32     cap_link_lanes_supported:1;
>>  	u32     cap_rss_ctx_supported:1;
>> -	u32	cap_rss_sym_xor_supported:1;
>> +	u32	supported_input_xfrm:8;
>>  	u32	rxfh_per_ctx_key:1;
>>  	u32	cap_rss_rxnfc_adds:1;
>>  	u32	rxfh_indir_space;
> 
> reorder the fields, please, so the 8b one is aligned to a byte

Will do, thanks!

