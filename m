Return-Path: <netdev+bounces-105085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3CB90FA22
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27ECBB228B1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FE18E;
	Thu, 20 Jun 2024 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MeSzCNNI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C71FC4
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842276; cv=fail; b=IZAr9yXnKmRIiepXIeXY+5FpLUqNiLtc+STarjUsUYQFqz59Gzfkj6p+LqfyMz7M2aSafhXzm51evL1zeLcbSa5wQTP69tLxwKyLbsrMx0/7sHIwAoYbm98n1pbD04HnqcE2O+O7LHiwne3hnvLVbvTtdcC7RXbXEzLCn9SaWRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842276; c=relaxed/simple;
	bh=T8rne6oHADsNOPv3ZghdlWZdiL96AmpPhZrbGAI8YHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3z5dv9j3IH17v840+oTTwrXPEJp0c+AtGhTSf++wWMZYOwEvXfb74r5nMBS0XIG3qZSqDs0k1IVtF29XZ5RxjJ/s9F7scSzbRJcxItYjErBHHBvAwRrsi4AfZLKt3MVKT5iIEAuZXgBz7qYmKgZSUqJt/tNl73HjpuNnLfWE8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MeSzCNNI; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aixKsFKL1GohYZP9lx8jjqo+Di8LgYuCUGnByRr6VRfnq6s3xM41Yuuxt/bnrxtijfKKZdZSZuJJfCa68QNNOSR2p2Mj3tItMs1l8Fj/HJtpVy4OOCmAt2XPJX8Fdw3xgzsdRueczArIvpzWUYQm3AFgN5iC8b4dzxmFNy2/MuN4z3xfGNs+kUjrd9rZC0h/7XriqXeWdZwwMBQSEshkJLnqq4cBLyu18oBVdvi5WpJcZzGzyrdH+IKFqc0TzGulAznF4LEd2QJoGDRVmmISpCAfFl6ibGP2Sf9DmAuRUcAWqNcAHhvKczX4GRRfXRySXDbcVPQG+I4/KIPB/Ha+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcFLsykifz65e+4VmlQeeRuttxhMSJdmR/hnhjr3GoA=;
 b=MB1Hxbm+cpt5HSQ+GEeC3eAeUZLwLyQvXCvdryPdHUL982XLX2s4eP8g3Fr0jC47Uhr/QZtacl5hCwfNjIQdMO3yj1fj5iBI3n8cN03DK9G3HxzFtddfU8CXqo2AGIq9foRyTUbCACAfiWvuznjtp8S+2/dYAV79jKuCRL+Ltbgoc2zR2qYZo2o8tQ3yt1YHuqrbN+yXDNvGGG0Nz61BsZOVzPmWAjPtr4ynL+41eFRSy7BXSei44mhgZAXeqbnD4kOMWgY/N1h51a78E6la0XcGVmElG3mBTIaIE6nEmRA8cRrV/7FS+TSaYLA0Q/Cg44z//JvOPtCmeh7Z3MRaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcFLsykifz65e+4VmlQeeRuttxhMSJdmR/hnhjr3GoA=;
 b=MeSzCNNIMmLTYTQ2AA0Ytvt3xcXf/vsYgiEha/8EMEWrH5XlrPy3ZMKvDxRK97YxAXJuLIi4eQafl2OFFURokT6BTdI5o0C0SmOKBZbfcYo0sphE5wG6mETOVezqrDQUt3UxWqyCcbpn4aZ5lZ0v+1ALGkopG+gbtegKcLExUtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 00:11:11 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 00:11:10 +0000
Message-ID: <6fb11f9c-1cd3-4a07-a687-96f0c5f146e5@amd.com>
Date: Wed, 19 Jun 2024 17:11:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: use dev_consume_skb_any outside of napi
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20240619212022.30700-1-shannon.nelson@amd.com>
 <20240619164434.46acb9fb@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240619164434.46acb9fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc38278-809e-46d9-d8d9-08dc90bd7d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTFFamtIZC9iZ3R3azJkQ1FwYnhTTUduaW5HaHZERVZLSUhTeHJWc3pUZ1ZK?=
 =?utf-8?B?YUx1ZmtDUXdTcE9sc3M1c2VPOU9tZXhIY2pVMW5ETTVQK3pLQ3hPS0FJbWNo?=
 =?utf-8?B?dlJOS2xrcFp3OEZGNnl3cnkvYW5PNDZoUGFsQjdaUStEZDZQczVOZjRnOUt1?=
 =?utf-8?B?UExrdWJTWTJUZFBaT2s3WFZVeVBRbUZkVmtIMGZKU3AzOG9kZFlSNXVIbjJG?=
 =?utf-8?B?TzRxVFJqNzNLSHpIZjhaU0dFcVlZcWdWOUVkbmVST2VYTStFK0RkdHdGVkVG?=
 =?utf-8?B?SXVwTndEU0JDeTA5c0ppWjIyRlByNkZKd0xOWGZXTmFEYVhJL3YxZktlZDZx?=
 =?utf-8?B?V1doanpJTFIyQVdJUHcvWkxoS1JYMktNYng4b25qenR0Q3Ywek1wZXNDdy94?=
 =?utf-8?B?REVTSERkQk9VelVZbU9iL2tUUFc2OGE4bnNDb2RXMmhUVkVTaHdSWmhHSTM0?=
 =?utf-8?B?b0ovcHN6cG5VWDNNQ0dGM0t3clV6MDlqR2JURGRDQS8zL1VVTEs0QXEwVExG?=
 =?utf-8?B?RDhhZ2xrY2tMRk55Ty9iWXJYdExmckxURFZMRFZ5NlJPVGc5K09XVXptdGU5?=
 =?utf-8?B?cnFmUEhYSmRuS3ZCQm41dDc3VWZkNGpXT3dOYm5hVGRMVVByaWlDMTdmYndl?=
 =?utf-8?B?aHo2dnVRcHZZVVFaRm8vYTZVK0QrdVZWa2JVT09Jd1RtNFJZdXFCbCtuM0F4?=
 =?utf-8?B?QUtyb3doaWx6c0h5NG4yNHpVa2FHazFwV09XWVF6N2tjOHBNVmhFRDdwWnRV?=
 =?utf-8?B?SzdFdnN2NFNTWFBKWng3M0hhRDk2SDhNNW14Y2Z0SmJWMDc3OFl2WFROMVdV?=
 =?utf-8?B?aW1ST1BjY0VuMlFoY0VNSmFsdHZyeTBxSXhsS0FLWVIwWFBocDkwWFdKTGxI?=
 =?utf-8?B?SW1qemlTRVdhME1ubnppVlZjWkZKRU9GWHZ5SisvZWVVbldrNzBWQktzR1Yw?=
 =?utf-8?B?YUJCcE96K0JEY2VuLzN3d2E2NGZwaFl2OGVVejUxbGp6dEk3cDNMN0ZnL2xm?=
 =?utf-8?B?TFJNQTd2S3RXb0JhVXZFTmx1UE1NS0xyZ3M5UGgvZ1A3d0IxYmo5ek45Tzhz?=
 =?utf-8?B?REU1UjQxV1VGcGVRM1lWbU1rTDJOaXRGRTNDdzdaZ3hwMENNaHFPK1FXanFm?=
 =?utf-8?B?RHpCemRBemFldzJWVlIrRHl3aVZ0NjROQVNwa3pyeG5FWTNvOW5iNlFBOTMz?=
 =?utf-8?B?bVRxSWVYalpFRHFvbklLZkJ2ZlU2d0RNc0YrQk5oQ0ZMVmhOVXBUM1I2Nlp1?=
 =?utf-8?B?QmpMdmt6Vm1GaUt2dHA1dHp4VTRJdU1TdXJ6c0Z2MmM3SU5HVlYwT2trTTJt?=
 =?utf-8?B?VXVoMmt2UDZRaC95bVE5aDJFckNGWkNIaWljdlFEQnF1Q1k1ZUR6dWd5OFkx?=
 =?utf-8?B?b1lSUmFLMWtWMXM2ZFgxSEhlRDUreGVxVWVoRGVyWVpUb2huWHpZd1JyTXBU?=
 =?utf-8?B?YkllbVFuRjZUcHlOSCtGbXFubjVMaUVQSWRzTUQraVR0Z2dBSWtZNVFjTUVh?=
 =?utf-8?B?MitzRXM3dFJMSXVZZ3FiOW5BTW1YY084M0c0SVFoZVlBSDFvOXo3Q2g0MGZ4?=
 =?utf-8?B?UXl4MUQvOCs3SEVrZS9qaXo2d1NiQ3JIVldEcnVteTBXUVVBK2QxZFNndjl5?=
 =?utf-8?B?TjVVdmljaEVmM0YwSG5ZdFVvWWVCa0dZQ3lEU000cDEzTUJIR2p2MU9XUUd1?=
 =?utf-8?B?dElrRVNuRDd0YzcvN3NVQ0o5aERvdW5VR1drMjltMC94UG9aNlBlNDJFaFJq?=
 =?utf-8?Q?DNH9VFaanhxClllcqTc98OMddrmBWR1/jv3m0ek?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a21QdHRnNmFwQVU5Q3ZDd3daZ1FIVTZRdVdOTWthT1dQakxBemxDVkhYampL?=
 =?utf-8?B?S2lrOUhnaHZqWm9laVVRRTR2RXRUNVJVdzI4YWFVZjR0SDNuRFFKZXNKOTNo?=
 =?utf-8?B?VHlOVVRmQ3NSNTJBNXc0VmxiQ3BYa0h0NEk0aldOb0ZCRmdVM0hYOFRGOCsy?=
 =?utf-8?B?M25vRWNqZjN4MU5UTmd0NEdlTERCMkp6bW41RWprV25Oc0NnZmM2azNYQVVz?=
 =?utf-8?B?b0JaMjlPdkx4V09IQ21TQ0k4Q080ZzkybjRIcldiQlByb1cvVkk0V1RsL1NG?=
 =?utf-8?B?dFZFMzErOUJtS2krOTFzSEt4SkxtVnRCeTFjdFhaQUhMdzcwZGVyZnpuQW5U?=
 =?utf-8?B?Z1FkYnBOU0gzc0grTnJCSVVHMXF1ODJyb2gvV1cxdm02WTlyY0p6NDlvdXBV?=
 =?utf-8?B?ellRUFl6c0g2WDdwbWN0MVp5SE5vOXFGU1JEZzFYQnp2TUZWTjJvbm9MVS9i?=
 =?utf-8?B?M0Z2aXZaanpzVTRwTzlXMUEvT1BrWEhPWTV0SVdYc1hVaTkzYkZYSUI2b3VT?=
 =?utf-8?B?VGFRT016cXBtc0c4QWE1VE9lK21DdkRNVUw1c2RZam1xcGtXY0gvVmUybHUz?=
 =?utf-8?B?VzRPbnVnWkhKZEZZWXJsYXhZMk1URmhjaTdUbHhwN1M5N2JkSkYvUThWRGRr?=
 =?utf-8?B?R1dFaGVQU3hKdnQ2ekk3NFNKa3VKdkplVnB5enZxL1FQS3FUdzE0MFFMc3BI?=
 =?utf-8?B?TG5XVUlPRDhueHVNSzd6N0tnWHdES0FnR29ZT0RKK1hVSVplRXlhNXRoQWpX?=
 =?utf-8?B?azdqT0JGMnVPS3pKaEdWYmQySU9RUFI0c0hobzFuZTk2VzFqSTAyeS8vcm9a?=
 =?utf-8?B?ZFhyOVBsMW4rMlFYcndWR25CQnNrcFc3eVNoVUZiUkNhb0ZHeXp6TDB3VWo2?=
 =?utf-8?B?SzFzdDhsSXlRSWs2bzltcjBKSWVucmUrZUFkMU9jY0lCSDNGbHpTYnFHNkdz?=
 =?utf-8?B?cjh3MjhFb0puNlFsdG0yNGtEWVJPQmNWbTRXVi9SemF3dkg2ZkVJTEhkaXB5?=
 =?utf-8?B?NkNwWjJDcFIySko2RFdyTExFa2NhdEVmcmU1Qm9zTlVCUjBqZm9MM3hqSmVN?=
 =?utf-8?B?aXRabTllTnZlRnA2RHhaNk0vaWQ4UmllM3M0enNQUElkdVVsRGdoWGw3cUc1?=
 =?utf-8?B?M2JzOER0T3ROa2dLNzgxYVVwUE5SUzVvYWtYNHJiaUhyNU1ubVczaU1ncXNz?=
 =?utf-8?B?U1Z3bXJBY1U5NG9DSW92ekczcXJST1ZFSlA4b0hHWEhNaFJjem9IamJwd2p2?=
 =?utf-8?B?Lzh1Sko3RGRaQksxd2lERE1DT21vN2N4bjFOQUovL01CdENuT0dwRGMwWjhu?=
 =?utf-8?B?L2czTTJEWlFmNWFOL3hNa0dkNkpmN2tZYlRaYWZrMVRUWHRualJoNnJhZXhv?=
 =?utf-8?B?UlF2S0hNY0k1R1BKOFBpQ3F6eWNmNzlxVmxWb3J1ZTFLalFTcHRZc2pFdGhT?=
 =?utf-8?B?bEpFdHd6Zjh0VUhYLzhuNk9QK2hPa2tZODdGbEthY0pIS1YxZ2ZxTXRFdHFm?=
 =?utf-8?B?cXltekJIanFYTzU2QWQrNURDSm1iSW80Y2tBOEpZRXJOK29sWWdKdk9DbDlV?=
 =?utf-8?B?OWgrM1Mwemd0NHZUNjRLRVY4YVc5Z0VBYzJ0d0JVbm54QzlMbUV3SExMdTdT?=
 =?utf-8?B?TUdyVWxKc3RoVERlNGNNMWlMNTdOdU5CbWtpbVNtT1E3bHVIVWVwZS9LMHdk?=
 =?utf-8?B?QlZyalNJRU1XS3E1STJqd25XeEJ1TVR5TndLSGMwRFVXbit1aWY4dExFNDJT?=
 =?utf-8?B?aVRIWWYvQXdsK0tLRWpjK0V3RXEzOG1zQzloNTQ1MU90eE1Bd0dEcjNFbFNR?=
 =?utf-8?B?YkJydEZaRFc1RG1lSkgzRGx2RUR3ZVRSbEZIdTlkcW0vaHRGVWRpY05Gc0Ry?=
 =?utf-8?B?ZUF2VXRyM1pya3RnYmV2bnp3TVlWdTBOMXMzK2xnVlorNloxUXpXN053bFdR?=
 =?utf-8?B?RlBrVmVXOHZKVU9VaEVJNnl2MEs0bjlNK0NxZE84dCtDeEQ3K2QwT1FPb0Z3?=
 =?utf-8?B?OVhzOWd5SEd3L3BXWHRzTkJmQzJmdWRyWFZmUkNMNlRTQUR0TmFCQk4rcm9D?=
 =?utf-8?B?VlEwbjh0TWVlODV4ajhDbkxPclFqejcyWE5JR3NsKzU3QkY4STRUakF0NkF6?=
 =?utf-8?Q?pinHzZPfr/q/Rhqwi6MBbY6Qi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc38278-809e-46d9-d8d9-08dc90bd7d5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 00:11:10.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0C+By5vL+AISEMZly57FVxOqhlD7bebVkjP2t4Q25uPNt6TVzNfqbBpnVLbigkgvV2Ei6NqLY5mubW3pp+A8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

On 6/19/2024 4:44 PM, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 14:20:22 -0700 Shannon Nelson wrote:
>> I found that ionic_tx_clean() calls napi_consume_skb() which calls
>> napi_skb_cache_put(), but before that last call is the note
>>      /* Zero budget indicate non-NAPI context called us, like netpoll */
>> and
>>      DEBUG_NET_WARN_ON_ONCE(!in_softirq());
>>
>> Those are pretty big hints that we're doing it wrong.  So, let's pass a 0
>> when we know we're not in a napi context.
> 
> Just pass the NAPI budget in, and if not in NAPI pass 0.
> A bit more plumbing thru, but a lot less thinking required during
> review..
> --
> pw-bot: cr

I had a plumb-it-through solution at one point, but this is so much 
cleaner with a simple one line fix, so much less to go wrong...

Thanks, I'll look at it again tomorrow.
sln


