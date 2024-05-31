Return-Path: <netdev+bounces-99874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2DC8D6CFF
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7821C22F8B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19579DC7;
	Fri, 31 May 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9+gHK5r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DB1E4AD
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199352; cv=fail; b=m4FaHw3ZGBDSgJwFcqjK/iUeu62eXaCSYGi50Pomm0d065IeoZu45Xp6sSti/71AiMJBa8yFBBtYY2Hh0zInT71d7DHrJPb/BGAYuloBkORkPMnAKeixbx4N1fIf3KQfzHKYuMfaiwvrf45mmRgAtt7CnmhpHk+LQIP2mcUB2Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199352; c=relaxed/simple;
	bh=Wk0MR3hzD3uCYUCIoJwoRIljeXn3FEL1WaR2d88dScg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TEgk+8yEfjMPewpCxIEumE2i0DavSYpdMhzGzsAVwTyp68AJsqjUnXz0TE3FDflP+qWI7bGhuJmPDVn1Jxbac9pPGHDPnJ8kFOnkuX+AUUt/oIiL17CuqVBtBKas3suPmoqUEIGwTotWpzVorMKyPsd0bW8n6JMeXvsWVMpLJug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9+gHK5r; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xos+XxYcCz2D0QbwuI9Gde/STIpARUJhOsNFtiPHePMLtQ2Lp+6RcD54+01G499acRG3UmSrO8hy+55McR+NuDfHpOwX8kQL5/SSOxaiOSyKpBvBJPZrIhN67q5zIQA7SUHKS/4lAHtsN8KwqovZqD3TBM8D2dFX+mNiirL0JGBUqWdDDJXPI1JMYqGrFM3hbCQ7Uf5pWl+qtBtiYZVTzptRFBBOEZYwFK5hNAwwAlPep6sPyHC43vuMmvHe4nZtvAJzuvfbKzIleN4NkC/BRq6dbLJfzEsRXeMYxT/gjtihTM1Di6MA52F+g6aM9JfgGYv7D9PbP5pdUFsUYxF7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oYtn3+cqQ7zunVR9kcRJvhwxvqfjTZ95mqcqljnpZQ=;
 b=cBO43fF/znoJTUN4hAzhqQI525g7Tl/pIL2YBHC/N8b1UuGdGZlKo34uHZNi9M7vQTXM4mvKFckyLHJ4SckU0F0awEl+YfcoDiK4jdJfKCj8ycyAwa+Rdx4ek10jaJ33VkhIEfiIjduz7GsgivdywPR2aR6zHjwZ7e/0fWUUzVXyEJmaAy6ylufV41jNeXF/d9Es2w3DlTf6bNVl9Zv38oOkfDphC1TAU65dfPP5ITTCnsGz1zF4MI5tTNzCyNFINz11m1GCGeJo2JGmYXCylJ4fX/fJIKmTonE59iQT1NcoNjRgYk+WU0gHi/OsgeF+ZI7JntbYcHObdJJ2ciH1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oYtn3+cqQ7zunVR9kcRJvhwxvqfjTZ95mqcqljnpZQ=;
 b=y9+gHK5rk+0Co+WMk/hnhhRD4bcOfGpTxTqwEebIGbBZaJgXxaMQbx8Q3fMborHyC5AphVvkFICQI71UpGaKCasyo5O4paioMDMMk9A59jRpKLvdUK1F93Fybmc2Oof22yBGOtVGd8Vf3kuR5YFjXsvwZEsEpwGFEHg4uLF3IxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Fri, 31 May 2024 23:49:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 23:49:04 +0000
Message-ID: <8c933691-a31b-42ba-b1ed-9bbd20491963@amd.com>
Date: Fri, 31 May 2024 16:49:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iwl-net 3/8] ice: replace synchronize_rcu with
 synchronize_net
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 magnus.karlsson@intel.com, michal.kubiak@intel.com, larysa.zaremba@intel.com
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
 <20240529112337.3639084-4-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240529112337.3639084-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: c7998f33-743b-4fbe-9c3e-08dc81cc40b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWNlUi9QejlRakRlajd3QzZxaU1ER0R3RjhKY3pKMEpBZlVxVmJJTVRKSFVw?=
 =?utf-8?B?N3RjWktrSDk4b1R0Zyt5dkd1WjVONzBJQnlTR0tDZUpQTFp1SitYcUgya09N?=
 =?utf-8?B?WUVtaEJzU015Rnd1VndyU2xMTVY4cG93ZUVDMUVBRThYOUJwUTlrVkhXRnhT?=
 =?utf-8?B?RGdBakY1Ny81YlBBYVFPQmFwUndWUmZyaUxkcWFoNTlhZ2huZXBmM2VsQ3h0?=
 =?utf-8?B?R0ZZRFRGTjcwVXVMclFOU3RiaEYzZXhBaG9KYUNBTDEzVm81NXRFNE5GL2gz?=
 =?utf-8?B?aTJ0aEFiSEN4UnZXU1VMaW5lZ2FqWW1ybkxWaERtZE5yUVloUm9LRHhyWkxH?=
 =?utf-8?B?VkFIckg2aFBmbmdpUmZsamU4eGZCMzFNNzI0TStiTk5YTVlRcHM4by9UbDN5?=
 =?utf-8?B?WFRMZTUxeTI4Z1ptK3ZvamxDVkRvVVczZm8xR0FIMDFNQ1JGUW5MSVUvcG1V?=
 =?utf-8?B?NkJNeHFXOWh5ZzlaUTFrNCtteG1ORG1SK3RRVGdpZlpMRHlkeVBueXZXQmxH?=
 =?utf-8?B?dEd4enVKUUoxZlIzaUEyQ0JCNWh1NXR3bFZNRWdnZXFOSUw2TmJ1QUlrWUtk?=
 =?utf-8?B?eTJFSTBEcGxpb2VFWklDdXZWMUZxQk1sSDN4eEZEYXVaMTBQWERUU29YSVR3?=
 =?utf-8?B?d3dPOEUxNTlHYXduY0RrRVFwM1UyYzdzZndkTXh3ODFzczk3NWd2NzBKM1hv?=
 =?utf-8?B?Rml3NE9MMmNYVzBnR05tejhDUlROSDkvd1gzQ0NjQXIwd2ZMdGFkQnA1dVM5?=
 =?utf-8?B?TGROeS9FQVNYUUV3cGhjKzBCOG5kNC9YTlZOOUlGOTNCSzdTdDAvYllrTnlQ?=
 =?utf-8?B?bVQxWVZES1hLY2p6RFU2WURqTmpNUGI2VXNoOTlDbnZTK29LT2ZDV1NiWEpz?=
 =?utf-8?B?MHNTbld3SzNScTNNbXlrTWFqS25TTDJ5djJ5ZDErL1IxdDF0Qnp5bDJEN0J3?=
 =?utf-8?B?aEh3WjVJcWJVRGszL1hzaUZQNGJibWowQXE3emRoOHRjSVhEUGZHWGxIZWI3?=
 =?utf-8?B?aUlyYUVkV1g3MTB5cXBYUjlLU1VLSWxvZFgzUXlvTnZ1Y2E5d0hPMG5jaDZx?=
 =?utf-8?B?Z3YrSlc5OGxoOWtFcVpzNTkzcmdBZkpZcDFBeFpyUGd2RUVEekZBVFo2TzJw?=
 =?utf-8?B?Qjk4MUhiVmlOZndWVkxoVjFBR0J3dS83dWhvU1J5OEZXejg0WHJRMDkzMkJi?=
 =?utf-8?B?LzVnWDJTWXpLM24rQjZReVRNU3h4WnFzOVhuekZiSElxK0NYc0RpYWU5UWtj?=
 =?utf-8?B?ZGtMbG4vdk5PQmsvVlJOS0krRW5zWDZ2NkRMeHZxQWFlUHhQdmprbXU2ZmdX?=
 =?utf-8?B?NWJ2Y1k1b21MRFhIQm1yTSs1L3o2M0tUb1FqbXZrS0JUbTU4cU50TE9OVnda?=
 =?utf-8?B?UXcrQWdFUFdPQmllaUhRYjUvdnBaYTB5Q1I5M0svTnhoczR2ZzBSZGp3eHI1?=
 =?utf-8?B?QmRnbjF3NzJaOGFualRkNHF2d0t4WU1WZXcvbXd2MVc2RkNseUJnTzMycEd3?=
 =?utf-8?B?RUVnc2wxZEhRc0tobGJrMGxGbFNUYllpT3U3ZmJ0Sy9KL0tqQ2ZnZk0xaFha?=
 =?utf-8?B?NmQvdXhSSGRjVkxRYjlmRUVzbi83SkQ0d3N4cUp0cVl2bTNobnBYWEF4a2cy?=
 =?utf-8?B?SDd1anFVeEhwc2txWnE3ckt0REQvcVdwVGVaeStySnNzODh3Lzk4cGYxWGdG?=
 =?utf-8?B?Y0dyYW5mNzdnNDFwcEFlSjM4MUdLU1pSS1ZTTHNwZkZPLzMvbUpZbGxBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldnLzRkSEtrdUFaQmVhYThOY2F0ZEJDeU0xcEd0azVJVm5tQmdwU2dVUmdU?=
 =?utf-8?B?cFFPaHpyY2paTzJ0LzRQRlhFczNhQUMyQ0JDSTFERkhEeGNaVmE0M05Hd1JY?=
 =?utf-8?B?S1lCZ1pBT1lqVisxWFlEUEs2OTNmQi9yWitYQWVnVW5sSEpqM3A3WUtEbWM4?=
 =?utf-8?B?ZUhEY25EbFJXRFJIeVZkT0ZiU0pDQjJVbzhUNHZxRXI4b295bGZsL3JIYkFv?=
 =?utf-8?B?MjE1WEY2WkRUMm9YWXBYMHJCQnFmL015QzRpdWQ4OGdEdUpYdm1GZFdTMFl1?=
 =?utf-8?B?a05qb1NXTThJeXZ5UU5ObVZJTmJYM0duQ09NRlRpUXhQdkt2TFpqSGNpME5N?=
 =?utf-8?B?UUFFbUZhamsvdVF1cjFVank4cjcyZ3R6a3NEdzhyb3QzVjcyV2RQaGlaRURX?=
 =?utf-8?B?dDZJSSs4UzhpTlZ3NVI4SjdrZkx1WUpzSzNGZ2ExYkwxalJTcE9ienZKRlNS?=
 =?utf-8?B?TUpZQmgxSVZhUGt4Njc5aEVuSXZhNUxkUG0yTTNZTDlvSC8xMzNtbHdIL0pa?=
 =?utf-8?B?cVFBZGhUajlhMVlYdGIwK2o0QnVYbTNVbmsxRUNqZUFpbGlaUlVHT2tlbUpn?=
 =?utf-8?B?bi9wYW1meklEaGhqRFU4ekhVQ1VrS1IvL3htMFdHbjBjK0VhcTQrZ2phd0JG?=
 =?utf-8?B?MVBKVGxka1pzbms4SGlXUXU0VDZpMkpyWk5xbGNzS3IzSWdySFI5TS80b2tx?=
 =?utf-8?B?dGhFVzUrNFNDdDlNUE56NzdsZ2lsS3ZaOVpXd0MwNUFVa2g1SXM0eXZ1LzhI?=
 =?utf-8?B?NTdZODU5SGZLMUFqMU5WSW1icEpoYVh2Rnk2QzFKdnVIQzFBbDlTVWZFS0lZ?=
 =?utf-8?B?UlZjK1FkQmpycUxUTVNyVVFGcS9oOGV2aXdwVGZzblZWMWNtNWtRMkU0d0NE?=
 =?utf-8?B?S2JOb21WOGRFM1g2cHRIWS9vVkhyT1l3dlg3ZnY1WElvcFZtTFlzM1dEaVgr?=
 =?utf-8?B?M2xMeFhEaEtoMDFRcmFucjMrUWFGVUp2ai9hWmRuTGdrUzBNRXNxTURwVGtM?=
 =?utf-8?B?SmNCeE9XdGs4ODdHYW5jNFFOME9GcktkZm5jVDllUU0yNGVGOGlmY05XN2E1?=
 =?utf-8?B?RzZvRjZWU3NiUDFQMVpnREdnbVFrOVJDUlBaUnA5NzV1TlJ4R1luSThQdzd3?=
 =?utf-8?B?MlRjQXVTa25qc282STcvUkhKcVRJNi9ueTJSOEJKaFluOE5IL3ZyWjkvMWRN?=
 =?utf-8?B?ZzdBVnIzSHVBcnRXR0c1ZmtYaGV1Vmh6bzhOQUtlNFRwVlh1OVlqb0VmUGZt?=
 =?utf-8?B?L3pwOGtSV3pjVk5VTDRReUJCT0JOajF5NDkwVzFqaytXd1Qyb3RKemJ3UWVu?=
 =?utf-8?B?eTFKSC9yWkRVUHFsNlpVWU9lT3ExN0xyQ0JtaUN4amFNU3hqb0ttUHQyemNx?=
 =?utf-8?B?OEVoL0hsYjdVN3F1cS9DM0hhRnRNK1Mxb3J3d3RVbWVFZUc3QytLRWN0RWxM?=
 =?utf-8?B?bFg3MXJKbVVPVjI2VGlUM3VwbkIxNHAxVGhrcVJqZ0hTeXNNNkN5RjNqaWxv?=
 =?utf-8?B?V3pLOVBhYzZWUm9jbWZNZk0vbUpJNDROSWJaK2pUUFpLWHlrMUZyWStOL2ov?=
 =?utf-8?B?WDRzRDJrMytmQnAwWHhwak1ocFV1b0dSWW53eXl5WGhWQ21ySExYdGo3RnZM?=
 =?utf-8?B?eVdnZnFYMVcyTENLMWk2cnc2S2I3K3RYd1NlTDB3QUN4cFpORWZpNCtoNDNP?=
 =?utf-8?B?T0ZLTDNpTTE2MG53VkJVWGpLSlM2YTkrMFlLR0xTSkUyOVpCLzRab242NGdl?=
 =?utf-8?B?ZlU1VktVZHRidEcxRnVxTE0zOW5IQjRPcTNxY21uc0FVUjVvUC81Nnk4TjRl?=
 =?utf-8?B?L3dNTERuaXI3OUxlbXQyM0NoSUJOQzNTSFVnZlNaL0M4Q05TNlY4ZTVualFl?=
 =?utf-8?B?YlNNM2NqY0RUUDB6b3hnSkd6UUdXZ0VrNmFWa3VBV3hxVHVkTGVUL3RuTGN6?=
 =?utf-8?B?blRlYlFXNzZlVmttcjlrY1krN2wyTi9TVlZBcGNhRzNneUpLQnliTHNJR2kx?=
 =?utf-8?B?RGpMTmMwWUdWb0YvWnNYNnllMTBJRFR5UUNnSHo0MGx5Ujc2OGp6OVpRVWU4?=
 =?utf-8?B?MHhKcVV6YVR5dG0rdXQzcGJMOEdFak5tZnAyVm9oOFdnSThHZHRicGorRnc3?=
 =?utf-8?Q?L4FLor883dK5NDBoTL6VRehRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7998f33-743b-4fbe-9c3e-08dc81cc40b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 23:49:04.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A882ajVfNIn0oyXy2UGbXibVaZMQpNoktPQYU4Mkdwtd7odUChSq2snaT/upuaIN+R77vUmMAnNPTu+uEyHt1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

On 5/29/2024 4:23 AM, Maciej Fijalkowski wrote:
> 
> Given that ice_qp_dis() is called under rtnl_lock, synchronize_net() can
> be called instead of synchronize_rcu() so that XDP rings can finish its
> job in a faster way. Also let us do this as earlier in XSK queue disable
> flow.
> 
> Additionally, turn off regular Tx queue before disabling irqs and NAPI.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 4f606a1055b0..e93cb0ca4106 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -53,7 +53,6 @@ static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
>   {
>          ice_clean_tx_ring(vsi->tx_rings[q_idx]);
>          if (ice_is_xdp_ena_vsi(vsi)) {
> -               synchronize_rcu();
>                  ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
>          }

With only one statement left in the block you'll probably want to remove 
the {}'s

sln


>          ice_clean_rx_ring(vsi->rx_rings[q_idx]);
> @@ -180,11 +179,12 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>                  usleep_range(1000, 2000);
>          }
> 
> +       synchronize_net();
> +       netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> +
>          ice_qvec_dis_irq(vsi, rx_ring, q_vector);
>          ice_qvec_toggle_napi(vsi, q_vector, false);
> 
> -       netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> -
>          ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
>          err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
>          if (err)
> --
> 2.34.1
> 
> 

