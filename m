Return-Path: <netdev+bounces-119793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C7956F6C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665D01C22AF5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0822113A3F4;
	Mon, 19 Aug 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvnBHvvF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596213698F;
	Mon, 19 Aug 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083119; cv=fail; b=r13QVlo1UOmBqhOqI59AMV7uRLSq+qpPyk1Qmv6Sc9bFcxitE54dK5dDBCs8D4JFZLFaJAdmb1q32tlej5NFCnCWes3EF4qBJrpvWc4elLHX6Y+1UnG43jHbypxy6hOc20q8J5J2BtepPEOmnma95bmTsA1R3TN7kLIyfifEOsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083119; c=relaxed/simple;
	bh=9hRmtlCz99INlPcYorY4GxtqAMPD9gaF6N4gC6xW7sY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qq3Q0Quu8ZrGGfV5yUe42rBO+oH1QC/XxB40GbrJ8XIR6iLq1x+YakEKjT/OEVhsE6qmpH/3B8bFW/5UogwDIAifPL/JiEkRSP9jQBke8PFCZ8iKUr7OT5WY06mj1pGyA+3YEgJuz1MixzS7DTjxMBcf8IAW/nbkTM2m4h17f9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvnBHvvF; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkL3HxEhPYUV5WJzMvSYpKptqWKK09B+J8opPXxwlzNUihp7Sx4Q3T38Q1ScdGIxcIdPYQWGMhWm/wBFxEhU9aDMXl2F04khfCRawFkjjYkzZ9ZKQuc63VtK68NawSsHeKEx20QALCYsA6XSOiueeB54eSzMQw19Lmj2kH2vI9fdCHwMmNdFNTDVfhCQd9D1SgYly6Vb575brEqPn5IhYbKDz69zDybY3aSqrBdRJKDj7ADMDkwbomtTDguAP0cVzyLg8wA7fFeKhGfTcF2c13P/K4lLnoRoWxx/K1k9q04sVo8h3Aflw/qq7aycO7vYt/uBCvs3zIIscBXeSffOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wy40lwCf680Pi+2RBp0EuZuaoW+GWnfOepFQPmTvUw=;
 b=CErABK4phT0XPqumEKRcoE3l7KSr35kCfXaR0oa5SxO3zw2q9S7GGErXRD2YHkASqk1H9ixxBjNvDXjTFECXUCal65JhPw69EbTrhMhBdNplSuUAWaDPWSloEwaTlFocLhf2PKzcWfve6SZ2/Alnm2XEGl1+2YER4pnC99gmbMf/V/BSdWlMewI6FxlNFk+U90qs+zd/RDFh4bhWfnWNC6xgYNT2zm4/G101Vme91XhHMhtBFrD3+eVVejez0JaZAHWXHsRR/VAfMls0E18c+qyIFccNHLll4ulq5TIfeBYi+Nn87kSgB9mNRYZXQDPVsXbOIH29Xw5s/Jqvcms03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wy40lwCf680Pi+2RBp0EuZuaoW+GWnfOepFQPmTvUw=;
 b=kvnBHvvFvl8rOaZHcWJ0JXAKozl8LJUJUpTFW6zcMvA+3Ggql8z7LfqtkytACRoxjKsM+4wGlJWGQRf894g3zpQJN9tRPR8JluYmLnDeJqPeWtoMRIvZG5lro3qvv1AXNWpd5xFEsq6TEa0yrD1O7O8XcjUoZW9D+79/MZa+f3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:58:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:58:34 +0000
Message-ID: <0d9f54ee-5a9f-8f47-4911-204c42b33cba@amd.com>
Date: Mon, 19 Aug 2024 16:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/15] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-11-alejandro.lucero-palau@amd.com>
 <ZrJecn2KNn_5_Xef@fan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ZrJecn2KNn_5_Xef@fan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 19264a5b-9bbf-4bb6-57a8-08dcc067c786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEtMYmpPM2Y0QmhHMGVEZ0d6OG1NZVpQVGVMUUZ0clh1eWh2QkluWncrY0ts?=
 =?utf-8?B?U01CT3pkY2l5V3dnTm1zYkoyWFFKd01hQytheDBSSHRieTZTbkFweDh3cXZz?=
 =?utf-8?B?UmNHcEFXMnVFc29rNmVEbzQvaktxaUtwNUMyYm1CbjA4ZE5CMzRMRi9zYXdQ?=
 =?utf-8?B?NzNsZGJCVCtVRzB5bEdScGNJbnJrb2ZUK2FqQm0vREJmTlJCaDRUMUUxU0V3?=
 =?utf-8?B?RERsWFVOMWxvTkQ1cVFSc3NnOTN2N3p2MDRXY0E2M3FhM25EQ0w5UzZ2QTU0?=
 =?utf-8?B?NTUrekVEaGJOT0xSUjFRemdkNWJZYjdqd3lvc25FQlFmakphcDZMbFh6TFlw?=
 =?utf-8?B?b1ZsMGZTK092S2JYYVJISjFaVmRqZGJ0K2k2REdWVGRvWUZvQ3gxZVh3R2pG?=
 =?utf-8?B?Y0xuVi93dTBHNlZLWDdRVVI5VkNpWTc2UytKeVMxM0tGRW44dFhmcU1wR3o0?=
 =?utf-8?B?TUI4eTU4anQ4VUhmQ1RPLzBpdTU0Rzd1dDk5UWYrZmptcDM1QnFERmlmMm80?=
 =?utf-8?B?dW1FdEFJNmpOZkVDSVdXM0pJbWdGQTBpTm1SS1JMaUt0cEwxZGl1ZDZ3aldN?=
 =?utf-8?B?dHc5alVoSlYvbC8xV3IzUXVBMEF0NzNKYkszcDZzOUNEWWFwQjVQaTVISElO?=
 =?utf-8?B?eCtPMW1UMGFBOG9MOFU4QnlyQXN2YmYrUXd4SnhBVVkrVnp2bEdHSWNkV0ps?=
 =?utf-8?B?bUNuYW43eitZUEhCRmJHdWV2VXRpcTdDcGxsODZlSG0waHlNZ2M0VzRkUVE2?=
 =?utf-8?B?UnF5ZkVCaUlJQ0p1SkQ4MVlYTDB4Z1RYZ0dNUjlOT2pBNFZTcDdtVXVJTjJk?=
 =?utf-8?B?UXdVbTdGS3h4NU12bFR5VXY5MVlodkhPWFZhZVYxNS9hdkRid0N1S2EwUWRt?=
 =?utf-8?B?SlhLVkZMME83aU1PNjZEQjh5R001UTg4WEhoR0dwbmNRa1dzTXFXUy9TeE53?=
 =?utf-8?B?YlFyWHgrWFA3Y3pFY3RxMko2eFlVYTlVNSt4QUlNb2lrc1dNRzNuQTNsQk5C?=
 =?utf-8?B?RmtYUXhxbkY1Q0x2RTkzZXNXRzhaMlFEUkR1Q2tERWNaNHBUa20yKzZtZlo1?=
 =?utf-8?B?L21JYXYrUkV3aXpiMlV3MUR0UnVtV0R1TGUvQmNZdk4yMFNiTDZJNHZEUUox?=
 =?utf-8?B?c05vVXk1aWhTNStLaFUrRlB5TjB2THdKTnk5eEplQVMzeEZTanhKd2ZsYUxn?=
 =?utf-8?B?UTZ5T1ptYVJMbWZWcDZtRHNBM2VHT1NqbC9HT3N2ckZ2VWFyV3lhd2MwNVRG?=
 =?utf-8?B?V0k2VUtvTUpaelFqbXlxTnVMMnZLVEp4eHRLSzhNTlFDZ0ZGL0tKRy9wWWNo?=
 =?utf-8?B?VU1ndkZ6T3N0Z0UzemRGaTB5VkhGTVF0MlYxaUlsNnVIQ0JMRTRzTUdiLzIz?=
 =?utf-8?B?MHlPMkJmUmF1L3EzRU5JMmJ4elNjRFExMFRaNFZFdmlLY0lHRkFwcW4rU2ZF?=
 =?utf-8?B?c0E3RnptMi90akxSbkxWdFd5ZFdJanBXZ004cTJ5MzJPb01qSHdpUnJaMlZB?=
 =?utf-8?B?dTFQbDZROFI2OG5xTGNVMkdFUEh1VnpSKzFwVDEwQmJVdFFwWkMyZzRTWGlZ?=
 =?utf-8?B?VFBuMGhnaE5rOGdWZDZueENGdDRPZ25BbTBKRmQ1TXR5UnZHc2JVK3pWZ21p?=
 =?utf-8?B?aGw0QWVTdE8vSVlFSmwvN1NPampnZE9kdUQ5RDVHTXlSNjZxV1B6UWR4ZmRs?=
 =?utf-8?B?MzVtTHRhSWFlT2xKWE5tVml5dDMyY1RnVnlBaWw0M1hXOUNXOGRYS2tUWlNU?=
 =?utf-8?Q?At2z5EkgfQxGKl5Rb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZ1eVdrRHhjQjVTN2J1WER3TDloR0Y0WGV3RThvRGtmWTJmeDAyMXNhL2hT?=
 =?utf-8?B?NWk4cjdnOElDTjRJRGVscGNzOWUvZDZLRjlZNDl4bkl1SS9FNGVPL0FLWlpI?=
 =?utf-8?B?VWVvSDI4dDk5bjdrZnBjUFNYTjRnbHVYOEFXMEZuaDNWbDdnbU1nZjhuaW5s?=
 =?utf-8?B?ZGNwQmNqZWtvVVFEbWh0b1BqeGJaT1huNGNDamtqM2QvNHltREJLZjlFUlRM?=
 =?utf-8?B?V2ZmdlR3Yko2b0JuOC9CUFRuQjMweVJQYXpkU2Y2dFVBNlVwUGZHblVDQWYy?=
 =?utf-8?B?SCt6Mm9GeG1EWlVBUDZEeVIyUnNXZG03NnczS0lWTDcxempNaC9HVmk3WFd2?=
 =?utf-8?B?RC9zcGpiUGR0NUxRTTdWYThwRkF5eVU0bEZRdXpVQWI0alR3MzFHZHB2Nmlo?=
 =?utf-8?B?WTJRa3R0QXd6QXBEckVPL1NCRHNKWW00UnVnSDJZOHFvckdmcVNUNzlxU3Ji?=
 =?utf-8?B?MXhRTHJydzFIYU5TbGlTV3FvK2Q4YUp2TXBUaS9oWjI5QzBoelQ0L0tEbmE4?=
 =?utf-8?B?ZWx6dkViK3F4Z3JHdnh6YVBiVnczaFY5WGRoNDlqbjFCdlhtWHU0ZFJ5Wmpx?=
 =?utf-8?B?QUMzMitXNlZRVnBwRVdtMnlUckNsdlQxdTVtcnFwTHc3Zk1QTFhvREIxMmx3?=
 =?utf-8?B?QlU0ZEF6ZEhOUnJJL2JOOUlGRi9UV1lwS1JmZW82UlZIOWpqb1VGY3BUbFZG?=
 =?utf-8?B?Y1RwdnQ5V2Z5aU91TWlneDkwY21YSDErRmhwTWVETjNCdjZjemFyMEpyTnhq?=
 =?utf-8?B?OWxpRzNIS0hhQkI3b01FOHRob2tDeXgvbWJ4TEJDdTRpbytma3Q0b0ZJZ3NN?=
 =?utf-8?B?Q3JOOEV0dDU2UE5MSkEvSzMvdzdlaTBuREVLZXpGMGtSRkp1b2gzRTRZdHJZ?=
 =?utf-8?B?d2lCdndYMHdIUEs4bk5JNTdJTlFhODZ2Umd3ZHZjeGpvV2k4KzV1aUtrTUhu?=
 =?utf-8?B?U01ZS2o5RmI1djAwVTFMbmljcXpkczAxVmMwT1p5cVRFbi9HMklPNGV3eE1V?=
 =?utf-8?B?RFhTU1FwbUFlcG4xaWlod0FCcXBrTmdnUUhndVU3RDhlWmVTbXRyNnA3MGt1?=
 =?utf-8?B?cS9yNXJCY3VaOFR3VGNBR1VSS0F3UDVqSWJTTkwvQVNSWjNhRUtzamg3UWVY?=
 =?utf-8?B?L05aMGtMTmtRM3pKcmtPQ3RUSmEwNjVIZ0F1UlgrVHNrekZycjhpNmtYNWJF?=
 =?utf-8?B?N3N6dTJYalFQMGg4NUNRMzFZODRUdkhwbGRSUE8zaGJKUDRFL3JMVXpWUzdj?=
 =?utf-8?B?TStTSzRBQVNLb25hUlpyTEhQMXRRbTNFN1ZVaEZJd3ZYQ09SdVBCeTRpWjQy?=
 =?utf-8?B?WFZnRTFGeFQ0UjFuMzRicHpnZnV5VHJHUjg3dEdYbEJkTDVxS3R1dHErM28z?=
 =?utf-8?B?cWxmWlR6cnUyQ0EzNlhNSHhvVTc2empaZkRhVnYvaGtpU3lQWHZndmtySXM4?=
 =?utf-8?B?SDNBYkRxUHhWZjhONGRaNnU2RG1FWi9BcitHYWNKL3haYzBpQUs1VFZxNjJH?=
 =?utf-8?B?LzN6UU82RGhVSDFJbTV5ZlMrN2tQL1pFSVh5U3RmcmZvSXdFcVFlMWxUQ3J2?=
 =?utf-8?B?RzRKV0wzUFlWS2V5Nmw2MzJVQ1NWK0Y0b1J1T25pam9YS0hiVW4xTmw3SVd5?=
 =?utf-8?B?STAzYjh0bUhTb3k5NmlRQ1hvcDYzNFpCNFZpWVkyVURMWnMyOXEvd2tBMjVh?=
 =?utf-8?B?RTFhVE9ENnZXTEUvTHl4ck5xay9wQXRxTGQ0VDVGNXhtZklrZ0pwQlNTSENy?=
 =?utf-8?B?dEs2U0N1VnRicjBVYUU1ejFIL2NMNTZRWnlZQlY1bSt1TENBNW5lM1p1TSty?=
 =?utf-8?B?akVHem5MZFErdlBoSUZuRjNIK3pyalpma2d1d3V1T2pMWEtBNTloaVdqNllp?=
 =?utf-8?B?cGFEVEY0VVcyc2pGTFlqOWJOTXhSNXlhajVYMmpjYjFQemRWSHU2OUM3cWtK?=
 =?utf-8?B?am9zNGlTcnBNaWhZc2tYcGZxUFNEMlVISm9RaHFIVUY2N0paUHJkZXNGdSts?=
 =?utf-8?B?ODBUTU92QndxbnFONDIrUTdpL3N3N1FONTNaclpsaHJ1aWRSS09lbVlmT0FW?=
 =?utf-8?B?eDFkSllCbXdRRVZ5YXhza1F2MjBBOXdlanNJenNDQTRiZ2xXTU90K1hHOEpG?=
 =?utf-8?Q?mYYFzadiJVoL91n1IcDRiNWdc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19264a5b-9bbf-4bb6-57a8-08dcc067c786
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:58:34.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHWGXMJ6XWIn71xtBcPFbhf0HylpVDIn4NTkVFK0wjD5TgGPM+0rp9qizzUYeqXMSnrljhxUZv9vU9gBCCet5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765


On 8/6/24 18:33, Fan Ni wrote:
> On Mon, Jul 15, 2024 at 06:28:30PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Given the HPA
>> capacity constraint, define an API, cxl_request_dpa(), that has the
>> flexibility to  map the minimum amount of memory the driver needs to
>> operate vs the total possible that can be mapped given HPA availability.
>>
>> Factor out the core of cxl_dpa_alloc, that does free space scanning,
>> into a cxl_dpa_freespace() helper, and use that to balance the capacity
>> available to map vs the @min and @max arguments to cxl_request_dpa.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m4271ee49a91615c8af54e3ab20679f8be3099393
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/core.h            |   1 +
>>   drivers/cxl/core/hdm.c             | 153 +++++++++++++++++++++++++----
>>   drivers/net/ethernet/sfc/efx.c     |   2 +
>>   drivers/net/ethernet/sfc/efx_cxl.c |  18 +++-
>>   drivers/net/ethernet/sfc/efx_cxl.h |   1 +
>>   include/linux/cxl_accel_mem.h      |   7 ++
>>   6 files changed, 161 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 625394486459..a243ff12c0f4 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -76,6 +76,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_decoder_mode mode);
>>   int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> Function declared twice here.


I'll fixed.

Thanks!


> Fan
>>   resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>>   resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
>>   
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 4af9225d4b59..3e53ae222d40 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <linux/cxl_accel_mem.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -420,6 +421,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   	up_write(&cxl_dpa_rwsem);
>>   	return rc;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
>>   
>>   int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_decoder_mode mode)
>> @@ -467,30 +469,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>>   	return rc;
>>   }
>>   
>> -int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>> +static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>> +					 resource_size_t *start_out,
>> +					 resource_size_t *skip_out)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>   	resource_size_t free_ram_start, free_pmem_start;
>> -	struct cxl_port *port = cxled_to_port(cxled);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	struct device *dev = &cxled->cxld.dev;
>>   	resource_size_t start, avail, skip;
>>   	struct resource *p, *last;
>> -	int rc;
>> -
>> -	down_write(&cxl_dpa_rwsem);
>> -	if (cxled->cxld.region) {
>> -		dev_dbg(dev, "decoder attached to %s\n",
>> -			dev_name(&cxled->cxld.region->dev));
>> -		rc = -EBUSY;
>> -		goto out;
>> -	}
>>   
>> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>> -		dev_dbg(dev, "decoder enabled\n");
>> -		rc = -EBUSY;
>> -		goto out;
>> -	}
>> +	lockdep_assert_held(&cxl_dpa_rwsem);
>>   
>>   	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
>>   		last = p;
>> @@ -528,14 +517,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   			skip_end = start - 1;
>>   		skip = skip_end - skip_start + 1;
>>   	} else {
>> -		dev_dbg(dev, "mode not set\n");
>> -		rc = -EINVAL;
>> +		avail = 0;
>> +	}
>> +
>> +	if (!avail)
>> +		return 0;
>> +	if (start_out)
>> +		*start_out = start;
>> +	if (skip_out)
>> +		*skip_out = skip;
>> +	return avail;
>> +}
>> +
>> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>> +{
>> +	struct cxl_port *port = cxled_to_port(cxled);
>> +	struct device *dev = &cxled->cxld.dev;
>> +	resource_size_t start, avail, skip;
>> +	int rc;
>> +
>> +	down_write(&cxl_dpa_rwsem);
>> +	if (cxled->cxld.region) {
>> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
>> +			     dev_name(&cxled->cxld.region->dev));
>> +		rc = -EBUSY;
>>   		goto out;
>>   	}
>>   
>> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
>> +		rc = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
>> +
>>   	if (size > avail) {
>>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>> -			cxl_decoder_mode_name(cxled->mode), &avail);
>> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
>> +			     &avail);
>>   		rc = -ENOSPC;
>>   		goto out;
>>   	}
>> @@ -550,6 +570,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	if (cxled->cxld.id != port->hdm_end + 1) {
>> +		return 0;
>> +	}
>> +	return 1;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @endpoint: an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
>> + * @max: extra capacity to allocate after min is satisfied
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. So, the expectation is that @min is a driver known
>> + * value for how much capacity is needed, and @max is based the limit of
>> + * how much HPA space is available for a new region.
>> + *
>> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
>> +					     bool is_ram,
>> +					     resource_size_t min,
>> +					     resource_size_t max)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	enum cxl_decoder_mode mode;
>> +	struct device *cxled_dev;
>> +	resource_size_t alloc;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(min | max, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
>> +	if (!cxled_dev)
>> +		cxled = ERR_PTR(-ENXIO);
>> +	else
>> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (IS_ERR(cxled))
>> +		return cxled;
>> +
>> +	if (is_ram)
>> +		mode = CXL_DECODER_RAM;
>> +	else
>> +		mode = CXL_DECODER_PMEM;
>> +
>> +	rc = cxl_dpa_set_mode(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (max)
>> +		alloc = min(max, alloc);
>> +	if (alloc < min) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return cxled;
>> +err:
>> +	put_device(cxled_dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
>> +
>>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>   {
>>   	u16 eig;
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index cb3f74d30852..9cfe29002d98 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -901,6 +901,8 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   
>>   	efx_fini_io(efx);
>>   
>> +	efx_cxl_exit(efx);
>> +
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 6d49571ccff7..b5626d724b52 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -84,12 +84,28 @@ void efx_cxl_init(struct efx_nic *efx)
>>   		goto out;
>>   	}
>>   
>> -	if (max < EFX_CTPIO_BUFFER_SIZE)
>> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
>>   		pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
>>   				  max, EFX_CTPIO_BUFFER_SIZE);
>> +		goto out;
>> +	}
>> +
>> +	cxl->cxled = cxl_request_dpa(cxl->endpoint, true, EFX_CTPIO_BUFFER_SIZE,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (IS_ERR(cxl->cxled))
>> +		pci_info(pci_dev, "CXL accel request DPA failed");
>>   out:
>>   	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   }
>>   
>> +void efx_cxl_exit(struct efx_nic *efx)
>> +{
>> +	struct efx_cxl *cxl = efx->cxl;
>> +
>> +	if (cxl->cxled)
>> +		cxl_dpa_free(cxl->cxled);
>> +
>> + 	return;
>> + }
>>   
>>   MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> index 76c6794c20d8..59d5217a684c 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.h
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -26,4 +26,5 @@ struct efx_cxl {
>>   };
>>   
>>   void efx_cxl_init(struct efx_nic *efx);
>> +void efx_cxl_exit(struct efx_nic *efx);
>>   #endif
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index f3e77688ffe0..d4ecb5bb4fc8 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -2,6 +2,7 @@
>>   /* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>>   
>>   #include <linux/cdev.h>
>> +#include <linux/pci.h>
>>   
>>   #ifndef __CXL_ACCEL_MEM_H
>>   #define __CXL_ACCEL_MEM_H
>> @@ -41,4 +42,10 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>>   					       int interleave_ways,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>> +
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
>> +					     bool is_ram,
>> +					     resource_size_t min,
>> +					     resource_size_t max);
>> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   #endif
>> -- 
>> 2.17.1
>>

