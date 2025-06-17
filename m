Return-Path: <netdev+bounces-198744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE846ADD6D8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DE4404358
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F2E2ED146;
	Tue, 17 Jun 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="X/EXt9e2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB672DFF16;
	Tue, 17 Jun 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177326; cv=fail; b=ifUJP7gmxmqxkcWmd7cHvGvgthneQ+LMeCzqe5Lumen78MxSElcPOv9iFsxzNMe9m1lvITu0f77Ph+yJ4eDjIHzFgxErh2QJDZSkRTsMG4uok4MkyPWcD7JXaSn2Y5AevKhkg2QtDyx7YwVVfhlLLf7mk0oDUDcHeME/A6TNqeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177326; c=relaxed/simple;
	bh=SCRL09NiloODtCePbYD4lEQ8odxxqhh/IQLb7v1VI9Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRW6iOqwnsbPMAOUV7TrnDp0VRplS0vLkW7t17IL5UlAdeLeVYYOBwI1RYsYUmquUSs4Sv2Dg4j2ObeqW7G++z/UU4ABHaWiEzT04YVPEfVHR5NwwtlGjJC6g7fheGOvFAV/F1C7V5ljYxzfqu7FJWYeoHNc9hBt41Hi0pRNCu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=X/EXt9e2; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1RudM6oriEXUugrH4+oEcHHDDvNXDXEFAiNkovlCraI4yzPAC5LnMyWAnIqJD8TKmOd0PJeZI35BjIkRDoRlSfCBh6WoAA2qO/9UZMRxCpoCyLyNJzqYv38vQYCTIhB7WWccquPlXVhIdA4TJl9YQa94EXMOyrlQW5O48GY3A5P3e9Rzi9l3X1S9hCMghl3J25o48EjtRRnFu+/GyihEBmdatuhq6Fs9V2lTr9z9CN+5FCRLFY3vdyXCuHLctelp01ouDn2trVFz9/AA+CgX5JLEb9nayyfyshEHooh5SOp4kSHSgflwUJxGNlr7FVFyY/YQ9T6+8uj+kMfD0G3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+g+tMxh/A/JIgC/5iCyRnCVLl331JpcKer5j8sKOSk=;
 b=LzBETz8UkrIdH9QwljjiCzdzTbHlMu1z3gQNIUk9XFYgVbsRh7mTrK7SRb9k0cTxDq19wu/XOOadRjVW1b3/ND4CV/gZJG9x+TZD2GuNyU3qcqKbacUxx/m7fO98IHbc6ouUElKTmKNJa4LpLnJQXAV0PL/e1I8q8YLAX8xRLOavq/mW3nG9RQF3O12K1QSn4meJDG+FnsKgZquGBA6ji6fkzkX2yZOyZ/9HTxyFt0nHVymURECFyf4tFgHIIyRyav7ntxpvONg7eWtOvtDnSVABDRldhnAr+LlrPDt6/GArc87f/2rXE8oIGBvYuWbGdaw9w8ABGQguofsG2DJGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+g+tMxh/A/JIgC/5iCyRnCVLl331JpcKer5j8sKOSk=;
 b=X/EXt9e21qtT2la2mVnRWwh33TP/0M5g+6lq8Ird54cekbZlWinXFE4P4kJQ3RcQs5ntFNIFTcJV8EaB+oCotHr+R05R/+NVnTUvetZ2wmxDnBhq4S24DunmlGyj3VItJeSFmkvCH2a0acPmTVkcWkAUdI9vq2TVDbpP7X6yUDdGEr+ACNoiDzDuNbxeFvqBaqYZVQwFdlVqyiOapySja5pTcF3483+QQdC+PZU63+PfffhFGie9lMifTzKs443dYg6BT3T1LpoqOZREWuRKkGaYxqX4QRU0dRQ6JJjJuFFXqEA8pYFKlj9PitahRL8+pYUPr0e9EVBisJfgd/kBZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS2PR03MB8158.namprd03.prod.outlook.com (2603:10b6:8:27b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 16:22:01 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8835.018; Tue, 17 Jun 2025
 16:22:01 +0000
Message-ID: <79856847-db75-4a5c-aad0-a846f7cb6db8@altera.com>
Date: Tue, 17 Jun 2025 09:21:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] clk: socfpga: agilex: add support for the Intel
 Agilex5
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 richardcochran@gmail.com, linux-clk@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250513234837.2859-1-matthew.gerlach@altera.com>
 <21b13081-b54b-4499-bf39-99ee0546369a@altera.com>
Content-Language: en-US
In-Reply-To: <21b13081-b54b-4499-bf39-99ee0546369a@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS2PR03MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 3748f3f2-d5ad-4641-31e7-08ddadbb16af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWhmKzhDNWs0UWJlVnlqZGg0S1FNU3FjcU5od3piSElac0tUblJFRkNIN3Zl?=
 =?utf-8?B?dERLaEluVExKNGhCUURTNUY5YU5IeEg0STdBOUtXdjE1dmZHQ25LemxCNmpi?=
 =?utf-8?B?VkFIQzE2MzJ6S2llUHNxUjlDN2FmTEp0TEQwd0Vtb2hmcHk0ODhoQS9MbEwy?=
 =?utf-8?B?Wk51VjhscXN5aFU1NmFvS0RmNEpqbEw3VXlqZWJiNFdXV1BLWStCMDV3ejY2?=
 =?utf-8?B?M1lYNW85bEdWWm5HTTg5V0lYMGxVRDhiVmp3bk5peHZkMFdQMmViV0NNK3Ba?=
 =?utf-8?B?eG1peVcwc0FRMnNTSDBpM1gvbzZTM3pJV1c4NDNMdHhTc0pUZ0w1cmpoUnJG?=
 =?utf-8?B?dEYwTFdUamxEVE8vNWIxaWxXV2RBQkh0RTR0WHZFb0JLdXFFbnVWZHNBTGVG?=
 =?utf-8?B?WDBOQlVLVWlqTzRlemhJd0gxb3Q2U0JKaC94aWxXSUtnMzRiNzZpa01uTUZH?=
 =?utf-8?B?S3U1UFNoL3lVUU4wNWRUR0YxcjdPalVRa1haZWVUOEhyWVlQQWtQclIvakw0?=
 =?utf-8?B?eVdGVy8wNkt3U1lUcUNwSHhYVE5TMmRCMzJ4OEwvZ2haTmcwcmZ4Vm40eTl5?=
 =?utf-8?B?WmFIUThOQnN6V25SZ0NDQVhLdkFndzhPRW1GSDcvM1VhcWE2SE16MFFXKzgz?=
 =?utf-8?B?dFJ3R2dkekFNYUhuQmNCT3VybTZtMWlFblJyaE1WS2dpZkhGcFBTUFhSRyt2?=
 =?utf-8?B?aENvZHBLN0R5eXhMYjJqRWlEbmNXcUxOMmNtYjRVQUZYQ00rTTJ5VS85UFV3?=
 =?utf-8?B?NU9QMU9iSFRxVDNidjkwVzhjTTIxR0RQaU44VmlzcmNkK0NRY1h3dEFPNytN?=
 =?utf-8?B?djJwWVpydzd1TzdraGFJZGsvSm5zblI1RlZGTHV3UDU1SnB1M2d4M1BrS21l?=
 =?utf-8?B?ZDhISEdoSmVzZFljT1VmYWxnYnlPWDR4MEp3cHRsOXRZbHFrNk1zZEx0VUp4?=
 =?utf-8?B?VVJFOGUzVkFMY3J4SHhPOTh6dVhJYmVFSUVNbldIVFd3bzladzV1SG9tWWQ3?=
 =?utf-8?B?Y2xxa0FDbjl5a3FEaEFyTk11eWgzQlBrRUJTaVcxRHpJVWM4QW8zam9lQS81?=
 =?utf-8?B?cFpRUlJaTTlxdWt1QlByVEM5T01GaWJETDFQeUlpQ1NPRVJvaHRqcTQ5YXcr?=
 =?utf-8?B?Wnp4am1pUThmWW0xcXRJTXRGSzZ2VHpXSHNlbTZvNUFacExmWTd0ejdBT01k?=
 =?utf-8?B?eXpwUHlYNmdGRVBhTnFoRjRpNjJKV3JTM2d6R01yb3RsNUtmYjBYK0JJQ3RF?=
 =?utf-8?B?K3dPTlVadTI1VzFjSEFSZkVmWXFvYkYzc3ZURVltME9xclN4b0wzZThKZEVR?=
 =?utf-8?B?b2REMFY1QVpyRmxqeEl1QVJZNkZkVlBTWFJtUU5TZldEMy9seTNyVHBMbkdE?=
 =?utf-8?B?L2NFZTFXMHFNcTUwS0hzcmRIeG01V1RHbWloeTBqb1pPazdsaEcxQnZhcVc1?=
 =?utf-8?B?YUIyeHZPdXpvZnd6Vm8wK0ZZVi85Z3E3RWdEenRCWDIwMVhCektHZHh5VUtB?=
 =?utf-8?B?OE00anZIaWtrUnlxVkxPU2VIcE9CRGc4ZWdwUjJ2SWlQQVdhd3czWHkwMytu?=
 =?utf-8?B?OEwvZ1paU3VhZXFXMHorM3FybkFqNkRPUHg5aXp5MDJyaFZ0NTFpQU9QV2I3?=
 =?utf-8?B?bnlOcmNxdm5QcDF2MUMxd041NHFQMFVWeWxMdFh2TzFJSHRVTlFGc1hRWmY3?=
 =?utf-8?B?NmZLYnhyeTdMNzlZelIrdG5YK3V5Wm1EMW80OXFvczFXdDllNnFRbS9SWFh1?=
 =?utf-8?B?R2N0bWpJdnRkaW9XT2cxT2I1cWllM25NMnVKcDBSUFM3a0hPUnpqZUh6MkRB?=
 =?utf-8?B?Q2ZoM1BJVlN0REFLam5WV2RpWG5lTkx1RHN4dDhpVFQzNHBEV3Z0UmF4bVE1?=
 =?utf-8?B?cWlRZ052Zm43OVRTYk45ZmFiMytoQ2VQaFNIZjhpTEVOOTBWRFVheVJveC9B?=
 =?utf-8?Q?0erjKpvIN8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmM4ZkpMVGl0UFo3QlYwNDNrUXQ2QnlKZU00azdibG1DQ0FEbzJvckhtV2s4?=
 =?utf-8?B?M3AybzlHZi8yVi85Y3lJU3JNekJyWXkzTWRyT09zbWZaRXdHN3h6YXhmMWNK?=
 =?utf-8?B?eDVhNG0xbjhNZG9ZYnpxYkNsVy9tYVpFV1JNTm1qM2o5VEEvNG9nWDFBU0dE?=
 =?utf-8?B?OFNzRVZFSXpnZU5TNVFtWkZwQXZLUHVITjZHUVJBdi8rNjkyUnByVEtDVC9w?=
 =?utf-8?B?Nk9pREc0aldGdjZGV2tzeDFLVVZrZVpSR2krb0FnKzNBLzcwUWhUMVMrUVZV?=
 =?utf-8?B?RThCWWV6L3Y1SEhUL2RJaHFUcjVnTmgwVGJ5cmtyc2pRTTZjRWxNOFB2cm4y?=
 =?utf-8?B?M3NPaUtXWWtzYWVaQjZqTlNqZUdOakFGTDhtUWg1RkxhdU1HYXUva2FVdG9Y?=
 =?utf-8?B?MFpTUURBN2FVZGorZFFSU2FlMXRlM3lkVmpVTklQa3JRbjhKY3ZKZmZzUGVa?=
 =?utf-8?B?ODdYUWUzSGx2NHFXbXhGQWg0UHhtWE9ybVB4VEZCL0RDbHN6d0c5L0tVWDha?=
 =?utf-8?B?Ni9uRTIvN0Q5ekYvbEdzZHV2RENaaHJxT2p3SkJlTUphd1M0dTEydDJlTDNE?=
 =?utf-8?B?YnRmNUYyNm9KeThvOU9qNXJPWkpXMXp5VHFHQ0lzaTBpbm5wZDYyZzB4OGN6?=
 =?utf-8?B?QUtKd2w3K0Q0ZnppalkwckpLOVRJODZ1UExpQTNzRHZTbDlGdWJWUGh5OW5J?=
 =?utf-8?B?Sk1LNGk0MDlsWWpvYmZQbWlrNjcrMUg4RHNMeHFoUlpsUzVndjNiUWZWWjBN?=
 =?utf-8?B?ZXk2SWwzazQ0RzFQVm4wdFJZRTkvcFMybWg0Z1lGS2JuK09qZmt0NkdVTDRw?=
 =?utf-8?B?blRBZ3BGYUpuc3VvWWw2QVpQS3NZYzB6ZWw5ZzllQzdoR2dGU2VkWjhKRDBo?=
 =?utf-8?B?eHVqMWkveE5YSXFjM3RWSDYwNS9LdEZNSlVuV2h1NVBuRFZqRXZZQ3VFZEpv?=
 =?utf-8?B?Z1lYaksyNFprNzB6Z0hCWkR2VmsrMmpwa1VGc1daYVEybFBQZWxaL3ZMbFBO?=
 =?utf-8?B?NHN2V0twejlpZVBaWENqUXpVMyt0RENUZUhSTUk3MDJ3TlZvS1duRER0Q0U0?=
 =?utf-8?B?dkFQOHRYLzJHZkMyQkZVcFdEOGNMTXE3YXNRZlZ2bkd0c2RORFhhMHYzSFpu?=
 =?utf-8?B?am5DUFhhQ3RTeEk1RmZOeHoxWjhxd0REYXY0VStFdWppRzFzSjRNTEgwUHZi?=
 =?utf-8?B?TWE2dDA3VXBaOUZPdGdFbWZwbDdnbGg5ei9oV0w4U05aM2pLWmUwM0t5UTNW?=
 =?utf-8?B?MjcvREp2WHR2a3hYRi9XOXNwNTRSQ1NtQitYL2owSGpwR2tJaWZyNldFNkxF?=
 =?utf-8?B?UDV5ZXlvRnhINjVOcForbTV6VXloUlBQcUNRS21aRzlOaHVFSUJzRFpabVRr?=
 =?utf-8?B?YWVRem44amVqZUtnQStaQ0taa25qdGhEbHRtY0UydS9hcnkyaElySnVZd0Jl?=
 =?utf-8?B?aUZWRDZpT0Mwd0xZakVGQ2IwLzROeTN5NllpV3MzWFVuTFd0YWw4QitQdjFC?=
 =?utf-8?B?RmY1dEZaV1dibGtlSlZKSkhNcUtLNVBYSERiQ1dNUGg3eHhmZGd4Nm5COTV1?=
 =?utf-8?B?eDlXZXdSb2ZkUWNGSWZPTEx0dm1GRUVueWRkcGRWUXJJUzA1bFlKVmsvRE11?=
 =?utf-8?B?R3pPanlMSnNRV2d3UDdsTC9qbTZvNExJTzNLYWQvQlZUTXJzVGdHZFVPdFRu?=
 =?utf-8?B?N001UkkxYmJseEVnRnpqdlBxWWdHWVVTR1ZTODVBeVlVWkNSWWxwU0NFTGc4?=
 =?utf-8?B?UlpVTkxITnJ3MGJKRFcvZExyajBDSmVyWS9WdzlEdlNlc0JNdlU0SkR6L05N?=
 =?utf-8?B?WHBnVXFyVXI2ZEdZZDJGWEJsZS9NNUVxUnZFUWZXMFRIUjQreFpEUzdVTUpK?=
 =?utf-8?B?YzV0dmZ1N1ErVUhodGpab2g5YjZydmVjV2ZGaWJ6VEVadVZkTFNjRzJBWS9q?=
 =?utf-8?B?bENNT3o2UTNCTmloOWJyZ3lSQWR6RDdEYmRlVXZETUJYUjZsU0luZmRoeGo5?=
 =?utf-8?B?R1ZPT1pyRmVyV1NuQkFqMmRudUFhYUJLa1YrVC9LdHl1aGd3WXhzcDdJeFVl?=
 =?utf-8?B?dWVsOU1neVYwaU9vR1FiVk41dU05T3YyRFV4YURRdFh3RU5uaCt5U0Yzc0Zs?=
 =?utf-8?B?bEgwc25GM0ZySVBSQi9sdnV1cVR4K0tBT1o0R1hRY241aWdyTVZneWVrbE80?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3748f3f2-d5ad-4641-31e7-08ddadbb16af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:22:01.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOvce1xWUAIwzNs4naxoJ5s9tNknlucdNdT/uoMY5ms0qDLJzBrsc8uRgm77uUl5hFMwLNp0Nra6oRDJLQxPZRd9FBH0emlIhIuQUcFMigI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8158



On 6/9/25 9:53 AM, Matthew Gerlach wrote:
> On 5/13/25 4:48 PM, Matthew Gerlach wrote:
> > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> >
> > Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> > driver for the Agilex5 is very similar to the Agilex platform, so
> > it is reusing most of the Agilex clock driver code.
>
>
> Any feedback on this revision?
>
> Thanks,
>
> Matthew Gerlach

Checking in again and hoping for feedback on this revision.

Thanks,
Matthew Gerlach

>
> >
> > Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> > Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > Changes in v5:
> > - Remove incorrect usage of .index and continue with the old way
> >    of using string names.
> > - Add lore links to revision history.
> > - Link to v4: https://lore.kernel.org/lkml/20250417145238.31657-1-matthew.gerlach@altera.com/T/#u
> >
> > Changes in v4:
> > - Add .index to clk_parent_data.
> > - Link to v3: https://lore.kernel.org/linux-clk/20231003120402.4186270-1-niravkumar.l.rabara@intel.com/
> >
> > Changes in v3:
> > - Used different name for stratix10_clock_data pointer.
> > - Used a single function call, devm_platform_ioremap_resource().
> > - Used only .name in clk_parent_data.
> > - Link to v2: https://lore.kernel.org/linux-clk/20230801010234.792557-1-niravkumar.l.rabara@intel.com/
> >
> > Stephen suggested to use .fw_name or .index, But since the changes are on top
> > of existing driver and current driver code is not using clk_hw and removing
> > .name and using .fw_name and/or .index resulting in parent clock_rate &
> > recalc_rate to 0.
> >
> > In order to use .index, I would need to refactor the common code that is shared
> > by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .name for
> > this patch is acceptable then I will upgrade clk-agilex.c in future submission.
> >
> > Changes in v2:
> > - Instead of creating separate clock manager driver, re-use agilex clock
> >    manager driver and modified it for agilex5 changes to avoid code
> >    duplicate.
> > - Link to v1: https://lore.kernel.org/linux-clk/20230618132235.728641-4-niravkumar.l.rabara@intel.com/
> > ---
> >   drivers/clk/socfpga/clk-agilex.c | 413 ++++++++++++++++++++++++++++++-
> >   1 file changed, 412 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> > index 8dd94f64756b..43c1e4e26cf0 100644
> > --- a/drivers/clk/socfpga/clk-agilex.c
> > +++ b/drivers/clk/socfpga/clk-agilex.c
> > @@ -1,6 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /*
> > - * Copyright (C) 2019, Intel Corporation
> > + * Copyright (C) 2019-2024, Intel Corporation
> > + * Copyright (C) 2025, Altera Corporation
> >    */
> >   #include <linux/slab.h>
> >   #include <linux/clk-provider.h>
> > @@ -8,6 +9,7 @@
> >   #include <linux/platform_device.h>
> >   
> >   #include <dt-bindings/clock/agilex-clock.h>
> > +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
> >   
> >   #include "stratix10-clk.h"
> >   
> > @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
> >   	  10, 0, 0, 0, 0, 0, 4},
> >   };
> >   
> > +static const struct clk_parent_data agilex5_pll_mux[] = {
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_boot_mux[] = {
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core0_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c0", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core1_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c0", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core2_free_mux[] = {
> > +	{ .name = "main_pll_c0", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core3_free_mux[] = {
> > +	{ .name = "main_pll_c0", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_dsu_free_mux[] = {
> > +	{ .name = "main_pll_c2", },
> > +	{ .name = "peri_pll_c0", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_noc_free_mux[] = {
> > +	{ .name = "main_pll_c3", },
> > +	{ .name = "peri_pll_c1", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_emaca_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c3", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_emacb_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c3", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
> > +	{ .name = "main_pll_c3", },
> > +	{ .name = "peri_pll_c3", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
> > +	{ .name = "main_pll_c3", },
> > +	{ .name = "peri_pll_c1", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c3", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_usb31_free_mux[] = {
> > +	{ .name = "main_pll_c3", },
> > +	{ .name = "peri_pll_c2", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c3", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
> > +	{ .name = "main_pll_c1", },
> > +	{ .name = "peri_pll_c3", },
> > +	{ .name = "osc1", },
> > +	{ .name = "cb-intosc-hs-div2-clk", },
> > +	{ .name = "f2s-free-clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core0_mux[] = {
> > +	{ .name = "core0_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core1_mux[] = {
> > +	{ .name = "core1_free_clk", .index = AGILEX5_CORE1_FREE_CLK },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core2_mux[] = {
> > +	{ .name = "core2_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_core3_mux[] = {
> > +	{ .name = "core3_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_dsu_mux[] = {
> > +	{ .name = "dsu_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_emac_mux[] = {
> > +	{ .name = "emaca_free_clk", },
> > +	{ .name = "emacb_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_noc_mux[] = {
> > +	{ .name = "noc_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_s2f_user0_mux[] = {
> > +	{ .name = "s2f_user0_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_s2f_user1_mux[] = {
> > +	{ .name = "s2f_user1_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_psi_mux[] = {
> > +	{ .name = "psi_ref_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_gpio_db_mux[] = {
> > +	{ .name = "gpio_db_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_emac_ptp_mux[] = {
> > +	{ .name = "emac_ptp_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +static const struct clk_parent_data agilex5_usb31_mux[] = {
> > +	{ .name = "usb31_free_clk", },
> > +	{ .name = "boot_clk", },
> > +};
> > +
> > +/*
> > + * clocks in AO (always on) controller
> > + */
> > +static const struct stratix10_pll_clock agilex5_pll_clks[] = {
> > +	{ AGILEX5_BOOT_CLK, "boot_clk", agilex5_boot_mux, ARRAY_SIZE(agilex5_boot_mux), 0,
> > +	  0x0 },
> > +	{ AGILEX5_MAIN_PLL_CLK, "main_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
> > +	  0x48 },
> > +	{ AGILEX5_PERIPH_PLL_CLK, "periph_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
> > +	  0x9C },
> > +};
> > +
> > +static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
> > +	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
> > +	  0x5C },
> > +	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
> > +	  0x60 },
> > +	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
> > +	  0x64 },
> > +	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
> > +	  0x68 },
> > +	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
> > +	  0xB0 },
> > +	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
> > +	  0xB4 },
> > +	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
> > +	  0xB8 },
> > +	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
> > +	  0xBC },
> > +};
> > +
> > +/* Non-SW clock-gated enabled clocks */
> > +static const struct stratix10_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
> > +	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", NULL, agilex5_core0_free_mux,
> > +	ARRAY_SIZE(agilex5_core0_free_mux), 0, 0x0104, 0, 0, 0},
> > +	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", NULL, agilex5_core1_free_mux,
> > +	ARRAY_SIZE(agilex5_core1_free_mux), 0, 0x0104, 0, 0, 0},
> > +	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", NULL, agilex5_core2_free_mux,
> > +	ARRAY_SIZE(agilex5_core2_free_mux), 0, 0x010C, 0, 0, 0},
> > +	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", NULL, agilex5_core3_free_mux,
> > +	ARRAY_SIZE(agilex5_core3_free_mux), 0, 0x0110, 0, 0, 0},
> > +	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", NULL, agilex5_dsu_free_mux,
> > +	ARRAY_SIZE(agilex5_dsu_free_mux), 0, 0x0100, 0, 0, 0},
> > +	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", NULL, agilex5_noc_free_mux,
> > +	  ARRAY_SIZE(agilex5_noc_free_mux), 0, 0x40, 0, 0, 0 },
> > +	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, agilex5_emaca_free_mux,
> > +	  ARRAY_SIZE(agilex5_emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
> > +	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, agilex5_emacb_free_mux,
> > +	  ARRAY_SIZE(agilex5_emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
> > +	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL,
> > +	  agilex5_emac_ptp_free_mux, ARRAY_SIZE(agilex5_emac_ptp_free_mux), 0, 0xDC, 0, 0x88,
> > +	  2 },
> > +	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, agilex5_gpio_db_free_mux,
> > +	  ARRAY_SIZE(agilex5_gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
> > +	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL,
> > +	  agilex5_s2f_usr0_free_mux, ARRAY_SIZE(agilex5_s2f_usr0_free_mux), 0, 0xE8, 0, 0x30,
> > +	  2 },
> > +	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL,
> > +	  agilex5_s2f_usr1_free_mux, ARRAY_SIZE(agilex5_s2f_usr1_free_mux), 0, 0xEC, 0, 0x88,
> > +	  5 },
> > +	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, agilex5_psi_ref_free_mux,
> > +	  ARRAY_SIZE(agilex5_psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
> > +	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", NULL, agilex5_usb31_free_mux,
> > +	  ARRAY_SIZE(agilex5_usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
> > +};
> > +
> > +/* SW Clock gate enabled clocks */
> > +static const struct stratix10_gate_clock agilex5_gate_clks[] = {
> > +	/* Main PLL0 Begin */
> > +	/* MPU clocks */
> > +	{ AGILEX5_CORE0_CLK, "core0_clk", NULL, agilex5_core0_mux,
> > +	  ARRAY_SIZE(agilex5_core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
> > +	{ AGILEX5_CORE1_CLK, "core1_clk", NULL, agilex5_core1_mux,
> > +	  ARRAY_SIZE(agilex5_core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
> > +	{ AGILEX5_CORE2_CLK, "core2_clk", NULL, agilex5_core2_mux,
> > +	  ARRAY_SIZE(agilex5_core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
> > +	{ AGILEX5_CORE3_CLK, "core3_clk", NULL, agilex5_core3_mux,
> > +	  ARRAY_SIZE(agilex5_core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
> > +	{ AGILEX5_MPU_CLK, "dsu_clk", NULL, agilex5_dsu_mux, ARRAY_SIZE(agilex5_dsu_mux), 0, 0,
> > +	  0, 0, 0, 0, 0x34, 4, 0 },
> > +	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", NULL, agilex5_dsu_mux,
> > +	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
> > +	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", NULL, agilex5_dsu_mux,
> > +	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
> > +	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", NULL, agilex5_noc_mux,
> > +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 1, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
> > +	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
> > +	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, agilex5_noc_mux,
> > +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
> > +	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux),
> > +	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
> > +
> > +	/* Core sight clocks*/
> > +	{ AGILEX5_CS_AT_CLK, "cs_at_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
> > +	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
> > +	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", NULL, agilex5_noc_mux,
> > +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
> > +	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24, 4,
> > +	  0x44, 28, 1, 0, 0, 0 },
> > +	/* Main PLL0 End */
> > +
> > +	/* Main Peripheral PLL1 Begin */
> > +	{ AGILEX5_EMAC0_CLK, "emac0_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> > +	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
> > +	{ AGILEX5_EMAC1_CLK, "emac1_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> > +	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
> > +	{ AGILEX5_EMAC2_CLK, "emac2_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> > +	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
> > +	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", NULL, agilex5_emac_ptp_mux,
> > +	  ARRAY_SIZE(agilex5_emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
> > +	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", NULL, agilex5_gpio_db_mux,
> > +	  ARRAY_SIZE(agilex5_gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
> > +	  /* Main Peripheral PLL1 End */
> > +
> > +	  /* Peripheral clocks  */
> > +	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", NULL, agilex5_s2f_user0_mux,
> > +	  ARRAY_SIZE(agilex5_s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
> > +	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", NULL, agilex5_s2f_user1_mux,
> > +	  ARRAY_SIZE(agilex5_s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
> > +	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", NULL, agilex5_psi_mux,
> > +	  ARRAY_SIZE(agilex5_psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
> > +	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", NULL, agilex5_usb31_mux,
> > +	  ARRAY_SIZE(agilex5_usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
> > +	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", "l4_main_clk",
> > +	  NULL, 1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> > +	  8, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 9,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 11,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 12,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 13,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> > +	  14, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 14,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", "l4_mp_clk", NULL, 1, 0,
> > +	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", "l4_mp_clk", NULL, 1, 0,
> > +	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 15,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 16,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", "l4_sp_clk", NULL, 1, 0,
> > +	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", "l4_sp_clk", NULL, 1, 0,
> > +	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", "l4_sp_clk", NULL, 1, 0,
> > +	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 20,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 21,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", "l4_sp_clk", NULL, 1, 0,
> > +	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", "l4_sp_clk", NULL, 1, 0,
> > +	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
> > +
> > +	/*NAND, SD/MMC and SoftPHY overall clocking*/
> > +	{ AGILEX5_DFI_CLK, "dfi_clk", "l4_mp_clk", NULL, 1, 0, 0, 0, 0x44, 16,
> > +	  2, 0, 0, 0 },
> > +	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", "dfi_clk", NULL, 1, 0, 0x7C, 10,
> > +	  0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> > +	  10, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", "l4_mp_clk", NULL,
> > +	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SDMCLK, "sdmclk", "dfi_clk", NULL, 1, 0, 0x7C, 5, 0, 0, 0, 0,
> > +	  0, 0 },
> > +	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", "l4_mp_clk", NULL, 1, 0,
> > +	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
> > +	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", "l4_mp_clk", NULL, 1, 0,
> > +	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
> > +	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", "dfi_clk", NULL, 1, 0,
> > +	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
> > +};
> > +
> >   static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
> >   				       int nums, struct stratix10_clock_data *data)
> >   {
> > @@ -542,11 +913,51 @@ static int agilex_clkmgr_probe(struct platform_device *pdev)
> >   	return	probe_func(pdev);
> >   }
> >   
> > +static int agilex5_clkmgr_init(struct platform_device *pdev)
> > +{
> > +	struct stratix10_clock_data *stratix_data;
> > +	struct device *dev = &pdev->dev;
> > +	void __iomem *base;
> > +	int i, num_clks;
> > +
> > +	base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	num_clks = AGILEX5_NUM_CLKS;
> > +
> > +	stratix_data = devm_kzalloc(dev,
> > +				    struct_size(stratix_data, clk_data.hws, num_clks), GFP_KERNEL);
> > +	if (!stratix_data)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < num_clks; i++)
> > +		stratix_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
> > +
> > +	stratix_data->base = base;
> > +	stratix_data->clk_data.num = num_clks;
> > +
> > +	agilex_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
> > +				stratix_data);
> > +
> > +	agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
> > +				    ARRAY_SIZE(agilex5_main_perip_c_clks), stratix_data);
> > +
> > +	agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
> > +				      ARRAY_SIZE(agilex5_main_perip_cnt_clks), stratix_data);
> > +
> > +	agilex_clk_register_gate(agilex5_gate_clks,
> > +				 ARRAY_SIZE(agilex5_gate_clks), stratix_data);
> > +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &stratix_data->clk_data);
> > +}
> > +
> >   static const struct of_device_id agilex_clkmgr_match_table[] = {
> >   	{ .compatible = "intel,agilex-clkmgr",
> >   	  .data = agilex_clkmgr_init },
> >   	{ .compatible = "intel,easic-n5x-clkmgr",
> >   	  .data = n5x_clkmgr_init },
> > +	{ .compatible = "intel,agilex5-clkmgr",
> > +	  .data = agilex5_clkmgr_init },
> >   	{ }
> >   };
> >   


