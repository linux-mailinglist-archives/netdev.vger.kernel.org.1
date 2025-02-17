Return-Path: <netdev+bounces-166931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25044A37EF3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0880616EA94
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C121639F;
	Mon, 17 Feb 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PjTFIfjf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C463215F76
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785822; cv=fail; b=DoagsmJPIJmgxmpuxM814gSOxHxJ0wWyyyf+vyZ5gqA0d7JhUse3t0/rjt3hGBQaN3ybEpwc6Chb0sM0rrGLMkHPx4eLL3yGlvuc1PA1+Lbv2Xed/eNJgQiElsrBOSlBff0UghC28EdkqJJzjR6+8jKnA3+l7r6YexQOQS7gHEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785822; c=relaxed/simple;
	bh=Hu5sMgv3UMkah8TOi3SPcC+v9GWp/HYsb93hsyj5xcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2Gvi2LYBR4yYQ08FzgtoDRmn3/NjwzcusAHtSJmYfV7RIz8a1uNfGjDKThncuPY58lucx35d1fRjfK5Jr7nrVs/FRweqStH2/BY/jbKvh23z+n73dKGntXfGa0tLaQBYfyQHEfN6lHcRhUm60r5q1OPvYbnaqykL6ifsz/myRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PjTFIfjf; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evsaSo3ng6CjDL8GMDwtlgb97J3krnASWnK0H5IFeGFLlaevsRdmSadq0yo5ZsFDfVnQNBaD2DgHMWr8z31k224P6Icqf2yk34HXO7osrfqZq4RQiVeDU5WTbru+ENm1fmZ6wX+f7U/MbT8D4td4L0e7cJ/JjpeQZrLHLsLFKuAN6AP7/VtsmMolOQ/XUZwh4QiXOXsi+VImkQPnbo1/foqB/J6CQpESfJ9pdtM0fuzYDLN6UCe1J+seGDtFJkDRMRtAQ8sm6dlKk9SQHCgZ73rAEe9ZGsaikCrNdqs02dzTo5utf865jIGc/hmaLnlTHvjemo9gNQ+h3JGE+IUXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AcwJ4tX7zWI7r57BV2QzXWD9sTmSbwZ+tfnkihGf8U=;
 b=ywJLZZWKw+7SIhrWjpYFzSRJM1mDLlSoHPfdAf5UH5XUd3nSrvbKh6RUQXTaF0VyV8pX57v8e+KnM8djhEbv+c5qmcb5fQZaomsMXW4ysQ7G1I4vrBSzd7rFut+Ps6GNTxTtyxWsQaj0N1NeouubC4JplvyrgpAedb/iVZwVoWfqA/DCIqFOjzQpxadU/CUZVgq8vEZBqnqsy9VFyZa55Lh64NiQ71yOR0jkc6yBKBtlo6fAO49dnTpFqU0a+e+BGdVrI2DvNfCqTQpvX0mBvs/0w3ZypYB20obJ0KDFnO+2lqksjtFLRDnl0chxWibArDpaCHtAE2TC3AIRm/odKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AcwJ4tX7zWI7r57BV2QzXWD9sTmSbwZ+tfnkihGf8U=;
 b=PjTFIfjfwqJR6TqkgmqwwVtVkdlH4mBIBAEHAJR7j680JyiJpiaBEyGNm36BTJ0w6vrvCMGa7G7Qz3Xqu9vDpf2qaij5SfU3Frrbr0tf/6QEYfX2qeLMYHdfA8BB1eVvUU6yODpwXdokXzRslSoqeAK54kNw+Ex5KO62vn/TRbtYyMXl3m06wzfNIaPwVdmsMbl8dPhpwK5UqHQxO3jBEZqa2S8ACtYJhMr+PHY9sB0rHQLuLsYfy4Q1v1rrLXn+qxyLAoATQthEZhE0v7gpS+nxO4I3zP7p8L8LT/oKgzk5vg+ZxoyAQNIi5r1ryZxCuwj2jfI4AMKGVDU6Y5j6Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:50:16 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:50:16 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
Date: Mon, 17 Feb 2025 11:50:04 +0200
Message-ID: <20250217095005.1453413-3-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250217095005.1453413-1-wwasko@nvidia.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f2be40-7666-4c77-f71f-08dd4f387b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dCtsSmtWQ0JFTWZmSFplS2hRWFpGWkJleXZEZ3V0V3dOOXBJV05LcGhxdHln?=
 =?utf-8?B?cVFjbjNnd2pWdDRJWUZWak5hNU95azRsSkRQZ3dlaTAxd0QxTnJSV3NtYnMw?=
 =?utf-8?B?dmlabG9BTkZKQkI1Y2dSMytXU2ljQ0lkd2JRWlFOOHpsUWxDR0RyMi9FVHBL?=
 =?utf-8?B?UGl4M2lhZEZpVnB5aEtzRnhObWxXencyYW5DWHJncjQ1RzlkV1JLSlRSSHVr?=
 =?utf-8?B?T1VMVVhZblV4VlYwT1hmYjluaWxhejdMeUF2LzVOanVIclAwNUtwYnFOamo1?=
 =?utf-8?B?ZnpXMG9nVnRPeVpEbWNvN3RKNjhubTQ1WXRrVk1iOU9tRUhSSDRGZGtvYzl2?=
 =?utf-8?B?c2VJZjNzSCtRSEdKa2xYTGU4MjF6NVpxT3ZMSTVnYTk3T09wa2xocEpEdEJZ?=
 =?utf-8?B?VW93ZGZINFFFVWpWSXVYUTBIZURWekZQTzJYWXc3TmNJeEdZbHlET2V0OFFp?=
 =?utf-8?B?bFZQQld2Zm9QbFIxY2JjdU5meUtubWtmb1FqRWU4WUoydmNKeDhjNXczWEhR?=
 =?utf-8?B?QjNodk9EY0U0SWlQaWp1N0NCMFlhaVhKUmVTd2dFOTdMS2xIVlhYbDV4YnZM?=
 =?utf-8?B?NThyWTFSeUs4REkxUUJEMDZ3UkxsV3FxcmczY3Z5K3hmNWJJQ0M1K08wbml6?=
 =?utf-8?B?SGcwYXdLSGt6eWxmSFZKcS85NTNZS0VEZWxhN2RTbFVERXl3UG42UExmamJx?=
 =?utf-8?B?VERiaEMvSldlNWhUMG1tQjdFZFYzeGIzQjVtZlZTK1FTSVd0NGQxNThRWUFw?=
 =?utf-8?B?cjU5aWtvWkU5cXdvZzdUajdRWFBpMVVxdy8rOWNlU1RQWUJXaUxvTUc1Yzgr?=
 =?utf-8?B?ZkJ3b2U5YjZnMk4yUlFTVW04SjU2WTZVczIrYUcvTDJoQjhjVm1aYVlWRisx?=
 =?utf-8?B?ZXhnYW9YWjRoWWNrZU9PQnZjd3AxSGVHVllHZGk5R1ZsR2svQ0h6OWlORkI4?=
 =?utf-8?B?SkkySmtPc2JwamVHVU9HTVJNbzhJTzQ1Wkx3cGpORHh5YUZRM1hkYTdoZXM3?=
 =?utf-8?B?VnFTbWowZkZYaXRPMERjaGtuclIwQ2F1Vk5DL1NJbm5qMllCbEgxSFRGY084?=
 =?utf-8?B?b1k0MmxyNzFTK0MxQ2ZsTkc2aXJMSnNxMmlLRHNtWmpEV3dmRUpYRFRzYkNZ?=
 =?utf-8?B?SzNjUStUeUE4aUlrK2FONG1CaHpCSGcrUmZ2ZW5GZFBIOUtlN0FUeE5wTm1R?=
 =?utf-8?B?c3o3MkovN0xaTlZpSjMzcUZ6TUJLL01ZOWFFZnh6TEdzZS9PdVRVY1FURnRm?=
 =?utf-8?B?S3haeG9jajBRSFVuYzV6UzdRNGpzUGN3RVBzWDNjUHJSRER6SFdGd3d5RVBu?=
 =?utf-8?B?WCtzcEFLdERxV1RmRUJlc3FNUGtEbUUzN0daaVZLeHpFcGZlUEVYbVpxTEIv?=
 =?utf-8?B?Vzh3SUdzbnNuQTdYYkZnTGNwQ0kyaEkvNTdOcDBwTHRGTUxQdm1SbldXbksz?=
 =?utf-8?B?c1JWblZqSHBERE1PMmNINDd5eDlrMTFqUngwMHdVZEIrSUc5bTBLYSs4Nnk0?=
 =?utf-8?B?Z3Q0M0VtZ2VpNE4xdVZKeGNVbkVnWml6OVpQU1EzWFRXMlNXSGxnYUxwaVVs?=
 =?utf-8?B?clVGeUw0U0NVMkpkU1VuR1ozQk9ZNWJBcngrT0w3ckRlVEJ0N2F2MThQU3NY?=
 =?utf-8?B?bzhoaFg0TWJRZ3doWXhXWkozakt4aGdOSnBwak91VVd1MjNRZ05RRGZTaVkv?=
 =?utf-8?B?SGRIa0tQd3R4Y09XRHphYWdxZ2toOUQwL1QyMC9LRW9rNUVveWhFQlUvcEYw?=
 =?utf-8?B?TjduNG9OUWJtYjQ3RW5TU0czaEl4c0xQNDI3SFRFK1VVbnJCNlp3VHJ2b1F3?=
 =?utf-8?B?ZmFqTHFBdFl0bmFJbjN0eUFLVS83VVlnRkNibmc1c2xUcEkxS2dqRXl5RWFr?=
 =?utf-8?Q?ULxpT8Az2SakC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFVhNnlqSHk3N050VzRsUi9wMTFIaWJGcTF5NEZFQUJURDVLSGxWODRJUDlD?=
 =?utf-8?B?eUgxZ2MzMWo0UElNSHd2ZWgzaHVpQUpQQVc3UHVwcE9YekttK1FHcmNWMjRK?=
 =?utf-8?B?bEhhbnpvM2NXTDNROEFkNWJPVnIyaGNiZFVMcjJPc2F2aTlJRkpDdTloYkQ5?=
 =?utf-8?B?YzliUzh0M0xneHZwVXk1VG5FSktMdHpsYmh6Vm1QOVBhN2wzVlN1cktJbk1j?=
 =?utf-8?B?Vlo1UW51M1VCYlpKWEY5akpUaUwwSHp0aHAyU2hJV2lURSsyd2tvdlpqRzFN?=
 =?utf-8?B?MldwTVpFSEhpM0VIVGY1eU1Gb3BvWDE0VEF3S2ptbGJlZktqQU9xMkIyemFk?=
 =?utf-8?B?dmMyN2RDaWlmcGQwdFhuQU1HOTEzSjRtdi80U09NZ3BVVVQ5NzR1Vk1CT1gr?=
 =?utf-8?B?L1NCS2pVcFovSGhWbkpnTGNzU0xDUEcwUjIxZjJTTThDSGJKZnF1SUc1K09W?=
 =?utf-8?B?MHM0L0s1R1BjNE1UdWxnTjQ1bFc5cUFIdUtXL0haKzFUMm5iRHZlbnRnQ2Nw?=
 =?utf-8?B?dGcxaFpaMVp6M2hrSlpzMmZETHYyVnBrMnFYVHRDRXJnVjBwWGVQREJ5bEdo?=
 =?utf-8?B?ejZPZVppWXRiN2lVQ05rN1dsaWZPbHp3VTlZNkNHTGtuY2xmUDByUXFTblRS?=
 =?utf-8?B?V2c5MFZMcGQ3djJicC9KeVJsdzcrakZyRkl2bEp0enVSaHR6NWN5WG5adkp2?=
 =?utf-8?B?NmY4emVRTWpzZ0RhWEdnaElGTnpWakVIL01VS0NQODJabk1qanRHQzBaYVJ3?=
 =?utf-8?B?aHVsSDhwNVhleS9qTS9vQ0h0VFVqaVkyR3F3ai82emZ2L25tUFpvbjVpWU5o?=
 =?utf-8?B?VmQ5R3QybWNpeldVRkdhTFpzSlZPNG9mNEEzOEI2c285T29JQ2lVUjc2dmcx?=
 =?utf-8?B?eFlxZU5ubFloODFTNkdFb2ZMRmxSMnZ2dHFqZHZ2MlVxK2pPbFBwVEZZeTFK?=
 =?utf-8?B?ZS9zQzQ2WVB0Ui9ldzN6dGxSWnZIRE9KVGRkVjlQM1ZUS20reUxTQmlpUWlO?=
 =?utf-8?B?aDZmcGVzV2Vwc1pUenIvZEs5bHFIUWx6K1F2SXgreWxiY1hraWFEVjliZkUv?=
 =?utf-8?B?LzdzYjdyK280ck9lVG5ZaWlnUmxSLzdzbVNRMEZlNkVVbjc3S1pjUGhVcWR1?=
 =?utf-8?B?aUJLTi9kcWVLaTV3T2diQmc2WHpDb1J2M0REakpWaVVkb1BlVmF2Wk1BMGlP?=
 =?utf-8?B?Y3lFZFV3d05ZV2VEazJBeHJTUko2TUN2TTMrejh6RDlGNkpoK21Ca0RwZVZL?=
 =?utf-8?B?NjYvcXNrTFM1ZnVycDVYSVEzRzdzWE1MRm9mRU1oRUNmZWVmQWxNaGdJWTNq?=
 =?utf-8?B?ZDhZTVFNRHNocDNRQURIVGhwQUR0ME1IVGhjejhBcFdZek0vdjNlN0xoVDFl?=
 =?utf-8?B?TzkvU3JBaTBqcUVlSHEzbTZMaGNDMnVTK0c5czE1TnNrUFFWdVZkSGFsNS92?=
 =?utf-8?B?bTYrR0N3NFZCUmhSSCs1UEFqNTVSRUlSTUp3S1VaR2t4ajk4bDJTRjZIR29X?=
 =?utf-8?B?a0o1NUxZNWQ1VFk2RmRORWN2SHZHd1lZLzZ3N2ZRN2R1b29tdWQvOW5JM0d3?=
 =?utf-8?B?clBKaTBoSHYvVEFyM0RKQ1Vybk9rUGRrRzMwK212QUVOVVJqRFV3eEdyT3Ji?=
 =?utf-8?B?RUhVWkl3U1M4MUNVUGwvQ0dJZUhPYWRSTUhjSmVUc0lqQ3dUU2preVU0U2Ev?=
 =?utf-8?B?UUZPcWFYOFVxUS9TUUNSMW1DVEFKRmx1MGd6ZzZkWnBhTDUvS2Jtb3l5Nnd4?=
 =?utf-8?B?SVQwRWU2VXRJNnoyVEtCWWx5NElLZjdMb1pEWjUwRlZNZnNZL0s5RXllREZD?=
 =?utf-8?B?b3lJL2dLaHRvV2dmZitySStxTzNJenlJZ1lKUjBtc1NORzAwNFprZmdzK1JO?=
 =?utf-8?B?QXQrZ3JaNFRJMjdkK3pGTzV1SExsVmxLK3lRMnZzS2x0OTVWN2xjVXdFajYr?=
 =?utf-8?B?WmprelY4UzFxbzVqL1JJQTN0cXVHRDE0OGNYZ052MHUva0g5L3BIUEtqYm15?=
 =?utf-8?B?Ykwvd3hobmlrcDZWdDJZUEE2NktnYUdhMm5kQm5JSktCaU1zWUhMSDhERUtJ?=
 =?utf-8?B?UnBlK0ZNdWlQUll5cTBiQUhvbWJuK2t6V2o3YXBOc2F5aG1oOFJ5ejJveStP?=
 =?utf-8?Q?0cBUlMs5gzvYmtAW6HvN3ZlNF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f2be40-7666-4c77-f71f-08dd4f387b4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:50:16.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZBlTnkKcDY+eiF2j9eh3FgNpW+mSy2cUUP9EqWaWnKPUhBC+I9dwpz/9IvEY/Y6RlF44F4aqZLwsDUCmQsnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961

Many devices implement highly accurate clocks, which the kernel manages
as PTP Hardware Clocks (PHCs). Userspace applications rely on these
clocks to timestamp events, trace workload execution, correlate
timescales across devices, and keep various clocks in sync.

The kernel’s current implementation of PTP clocks does not enforce file
permissions checks for most device operations except for POSIX clock
operations, where file mode is verified in the POSIX layer before
forwarding the call to the PTP subsystem. Consequently, it is common
practice to not give unprivileged userspace applications any access to
PTP clocks whatsoever by giving the PTP chardevs 600 permissions. An
example of users running into this limitation is documented in [1].

Add permission checks for functions that modify the state of a PTP
device. Continue enforcing permission checks for POSIX clock operations
(settime, adjtime) in the POSIX layer. One limitation remains: querying
the adjusted frequency of a PTP device (using adjtime() with an empty
modes field) is not supported for chardevs opened without WRITE
permissions, as the POSIX layer mandates WRITE access for any adjtime
operation.

[1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 drivers/ptp/ptp_chardev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index bf6468c56419..4380e6ddb849 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -205,6 +205,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.extts, (void __user *)arg,
@@ -246,6 +250,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PEROUT_REQUEST:
 	case PTP_PEROUT_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.perout, (void __user *)arg,
@@ -314,6 +322,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_ENABLE_PPS:
 	case PTP_ENABLE_PPS2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (!capable(CAP_SYS_TIME))
@@ -456,6 +468,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PIN_SETFUNC:
 	case PTP_PIN_SETFUNC2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
 			err = -EFAULT;
 			break;
-- 
2.39.3


