Return-Path: <netdev+bounces-177440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BEDA70387
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22F47A3643
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CCC25A2B1;
	Tue, 25 Mar 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o8ozpPWh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A292E3382;
	Tue, 25 Mar 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912519; cv=fail; b=IfZPF8eubZWBiuKaX+a3tAwyHFT6lu/pqlLarMO9lCLYc1/Z0icpiZGYJoz14TbRzAZ8cLVLtvl2DZ/cJNc81RaRmh6aR2Jh2+W9cVFQn+2Ympd5xLBrS1XN5uUGc+TOm/5/hgpt84F2wLnzKhygrrmniIY/EtXQVegq06eOFBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912519; c=relaxed/simple;
	bh=AM+z9RVh4kZS1fqWyV1fRPc2cNBx/bvC6joylf59uJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GIQ4SciOg++u5bCeFrcyxEQnEIUifMCg4Tq+xwJMZ2RVwm3f7LOtLW4PieYcerfmolp4y7sgl3LWcm9PpKZbDU5Q9M9pcw12icEnkrmpEx2+x3xJBzBghC7yX+eXBbEcihVGmG3m29Zs+5M0wDWmSv9LpbrcqL8Te9HxUJukvuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o8ozpPWh; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpW9GKD7WVsLteolk6YPEW8l98zSkmsK3iJ9uPHEAlAOcVR+gvzUnlPSHK4xLc5phqGWESZVamf2piwO68t/F2wK/BFMjptME8en466gp7FVB3RVjP8Tk2bQIlXRyeT34iIPA5c/HSFNiXpDHyROx3K2xcelDonAqdB6TsBNZNLOJIE927jCQkxJWw1jLAC16cJ50GNx2+sq7J5Bxwf7Cp14oFDFS0dJwNLh7hncdu54wbik8StwnuBBRYuwiPZPuUvTueuIMbXxpAUAspgtj0XH9fRFNL4/a8T4YGfhDWnEV3RXNNfttsI6DQlrCZz79aLmFyy6QwCLrFMfLJGagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+K901CxckNSITUybm566o7AOUSqSRZLU7kaMN71deo=;
 b=Oh02DWEZpI6yPU8qeqavFhMprr4z04xXpbufuIWz9DrWDB4vqSjfKyjKD4B95SH85ApkpRF4XzuYz43Z2M7AkaSODLlruxa1j57TNh0XQVTtTAe7MGng5hjkBsIKTjrsbLA7bW7B6ppb+iXk6zBQQX1cb1QfQiAd4qkPT8S9FS40My3mvBjiXe0RMp46QN12KlFfi+LfaNeqzPwE9yWPldEhcgbA8Ph3cLFaz0pRqIAO6TbviN6/rXjqmvLgmu5zjL4fVoSl1WBjpy4fqrePy0z0m1Zu6O32LJAMBfU/ekRitBldll8Oicj1V/quB3/LdwqT+ISWrGF/KXb7HqKyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+K901CxckNSITUybm566o7AOUSqSRZLU7kaMN71deo=;
 b=o8ozpPWhCN8MKOzey9+zA0ezrvrGYpH75nIeOVoyN3veqLTvgROEfXt++TYttt7SOZH+SZGaUygS/6di8Fte9rr10/MdowmOX3f9zIjKClXw6jdGrBPag3a3D3SUEa6i3asFwfozfNr0MwRhwyr+vrJhZ/qQYgHmf38+TNxH/oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:21:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 14:21:54 +0000
Message-ID: <8b1c6606-cffe-41d5-82b2-a8fe65686e62@amd.com>
Date: Tue, 25 Mar 2025 14:21:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/23] cxl: move register/capability check to driver
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-5-alejandro.lucero-palau@amd.com>
 <8548aa3d-9904-47b8-b5e0-869785c2330d@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <8548aa3d-9904-47b8-b5e0-869785c2330d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 236aa928-921e-47c1-75e4-08dd6ba86489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFViZmJoNytycnVlZ2FLc1dWK0laYUhJS3V6bDJsKzFoZjM0dGJKUDlBU0V2?=
 =?utf-8?B?dVAwZWlpa1BZMFlEUSs2b0NITWZlQy80YjhoZENxNTY0VlJhUGlVYTZNay93?=
 =?utf-8?B?UnR6dm9aRDgrTW5RWHljZFNDdng5OEl0MzN0eitVTk9URTFIdk1kaWg5ZXVw?=
 =?utf-8?B?TEZoTmtrOUdWb01HWEhnaUZsYWlPYXRjeEY1U2tXbEdQZU9uOWlCTkhFem1a?=
 =?utf-8?B?OUVURHpJdmFCSm1Qb0dNaTJEaWo2b2dtdjlndk1kNkJhU2ZrM2plU1prYzNs?=
 =?utf-8?B?cThBTW9HdFZiQTlkdEFkNmJ3Z1dFRXFFd2JzbEg3MldkK0wvU08vVkVZTjdQ?=
 =?utf-8?B?aWp6OE9hZURVRDlBSTg3eUtCdU9VNEEwRmdKaDBOeWMzaVoweXBFZEQzYTFm?=
 =?utf-8?B?WUpKcEFMNkYrK0tEK3BqNDZ6VHJDdUQybW9sK1lUZkxhbEkvS3hKR05wZklL?=
 =?utf-8?B?ZGN6OW4xRTlaejAxWkRjbW9sdXcxVkE3M2JYTzdpMGtLU1JObDduWDRwVzJD?=
 =?utf-8?B?bmE4bGhzMUlhRysvS2kwQW1PK3NxL1lwOEt4RUhreW9NYUlQNVJMNG1pWTJy?=
 =?utf-8?B?S05hSERGT3IvaGxSU3hHVituQVFtZ1BGWlI0ZWE5L3hqRER3a0dUNVU2RkVu?=
 =?utf-8?B?RE1BSjJTLzhXUkVlNXpuOHhnR1E0NllwR3A2ZlMra21GQ3JxR1RTdGs4RXRr?=
 =?utf-8?B?aVVxTjhsZ0llckFBRzh2N0RiY1dJdUpOZ2tHMHZ1a1dCM3JKNnFnM3RXVmhX?=
 =?utf-8?B?WkhEMzBlVk1DSWkwSmVDczZwWmJNZDNjUm5nM2JVZnVhdzcwc3FiTVp3V1RZ?=
 =?utf-8?B?OGx0YWNCNkhWc1hvTjdSaW1lSmE2WCtXNWNocDYvM2lCVHNKMEEwSGpVbHhW?=
 =?utf-8?B?VThlT2lPZ3lsY1pJd3VjV0lQRFV4eThYdzB3enBSYjIvZUd6TnBFaTB2SDI1?=
 =?utf-8?B?MjR4VktMWUd1ODRBbEZSS1FqeHJSYnhtYXgvNWc4dGNhbCt5akhmZVZKa0Nv?=
 =?utf-8?B?NEJQakpUR2g0M0dXUWp6MEVWTlFveEErR3Y5aDVaaS8yUkpiSHd5SFB5T2xQ?=
 =?utf-8?B?bDhuZzlGTnJ2ckIrbnFIR1IzbEhmTld4QlV2SVFHN2dONkd6RTBoc2ZkekJZ?=
 =?utf-8?B?M2RacU1xTUdKTk5CMllhTnpQeTAzb2ovbi9iS1o5OTdUU2x3RHNENWQwci80?=
 =?utf-8?B?bXRUSFpkSlgxS1hMbWFxV0tFazF2Q2VLTDdPWmZ2WmlybVhacUxOaEp1UGs1?=
 =?utf-8?B?cmdOY3FHY1NEcUhnaUtzRTI5UXZyM2o3aWpBaWdISVBwUmdSdlJ3cW5MYzZs?=
 =?utf-8?B?cW0xc2Zqb1ZuR3JEMk1NaTJKM3NDSEcwbmhDSG1EUG9jVk1CUy9FK2haTlBZ?=
 =?utf-8?B?bGVYVExLL05sRDB6U0ZuY2xCZW5JVzdJdkhUL3JUZjl6Yy9jdUFsUCtna3Ay?=
 =?utf-8?B?U2t6Y25FR1cydXMwRjAxbzk3azQ3aWJ2RXE3d1cybUM5WjZSK0ZQZTR6NENS?=
 =?utf-8?B?Y0N4cUloZjNRcmNiT283d29kUUVwRXdUWDBXRDlJclVwWmI4U1NvSnBwU2ZX?=
 =?utf-8?B?WFlFbU5TaG1WVHViWlQ1L0ZSV0pkeGNLV1JDT25WTDk4Y0V2YlpwVmR5Ykg1?=
 =?utf-8?B?ZTdoLzJJSTRkTW1mR3pmSU44Q2M0MTF3VzFkNlJaSlBZZ1d6bzFMRnhUS2l1?=
 =?utf-8?B?aDJ4S09MU1RYU3Z3a1QxcEZHTlpQNVV4Mi9xbnlCWDg4dVVnQ25ZSXNMNWRK?=
 =?utf-8?B?alRNcnlNWGFiZGZYSVA2aGMzM3VKbkhzRTNiTWRhdG5Bc2h5ZlRVbUFQUlk5?=
 =?utf-8?B?Q3dhQUxpMCtNVXR1M2VEV1pNR29PTHBQSW9KRGl5SW9VbmNLSWZOTWoyREt1?=
 =?utf-8?Q?HuR4K1JNndraJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0VNNmxQQ3lhVmV5ZEZEOWhucVlrNlNJaWs0SGZsQ2JoV3dPSVJ0RFBNYXJ3?=
 =?utf-8?B?MUUwd05kVjhrQkZpN1JiT0R2QU9vTnNpeUMvb09KVkRXdG42c0g3OWhSTTIw?=
 =?utf-8?B?QUhzbUNUVUNrMGY0SndhTGxrTTBLUEdWbHdxWFF6eUprU1lPT3NXTTZvRndK?=
 =?utf-8?B?Q3c5OGpMMlF6dVM1T09jL2RrWWdETjEyVkxhalBZbnB6dU4xQnJsMXNVWG1H?=
 =?utf-8?B?SVQ0dXNZREdZdTFTQnV3d2NyWGU4ZWRNTFZ0SHhRRXVUeHBKRldEdmtlOFNt?=
 =?utf-8?B?Z1hSVC85NkZiN2R0aEVMRkNvWGQ1NGhUZGh2TTdtd0g1SEliN2VCRU92b1VE?=
 =?utf-8?B?emxPSHVmWkZ3YmVMZ3FhdTdiUjQxWXd0QzZ2Q1NZaTFQc2d6Z08rbTlYdXgx?=
 =?utf-8?B?dzBJZ2ZVRnVoMXBGYmhScmE5QTUxSXhwL01FZ0paYTQ1SEo4alNSOEZGc1NY?=
 =?utf-8?B?QS9STzZrYTI5TUJSVi9VaU1xSlZCS1V1WkJDNEw2ZXlzTlVBdGp5VjBKQUEz?=
 =?utf-8?B?bFF0Q1VhWkFaMDVlVVgvY2FWdDJKY3o3Q1hHUDg2RlNya2Y4OGlzeHBxYzEw?=
 =?utf-8?B?V2s4RUpwcDlIdjRiSmkrbFVGZEM0V3lVcHJQR1lnMFc4WkJWU1N3RlQ4aDAx?=
 =?utf-8?B?VGFaL3h4Sk11ZlZxaDhLUGdndlB6ZVJJRmd1VkNJN3RqZW8rWmdCY0RHZkhn?=
 =?utf-8?B?cGpMUFVjUTJHcjdHandpU1kxbzd4MEpHQkJLREQ3b3JpNDBWRDcvckpxMHd2?=
 =?utf-8?B?Nnlpa2hGNENVQzNnck4zSFhITGJSUVJNNkxmV0dGUFFsWGR0aGJWZ3JKd082?=
 =?utf-8?B?R3JqbEdTbnBiUU9pMDhITUtJYWdHcTBaY2xYVzZjZlU1UEVjOFBETGNCRFlS?=
 =?utf-8?B?NXBMTlB2b2FpRHc0alBXbnhRdG5jKytyeElnVFFhRDVzclFnUHI3N1ROQ3R1?=
 =?utf-8?B?eC9tR1puTzV1NWtubFZjR1l6bDNRSjRzTCttbXJhbW13aWNpU2ZSenEreVpB?=
 =?utf-8?B?MFpib1lhTXZOSVc3SlRZTUM1WlZnckVPTVJrWFNabXFwdnp0emtyQXZ4enl5?=
 =?utf-8?B?QnRIQVlLZmlYcTVGZ2xDS3prWjdKRnJtQ015WVpCOGMwMHlxV3FKeHJqSG9p?=
 =?utf-8?B?OTB4bi91QjNPOFl0ckhjQWI2dUFDb0xEV1lKbEh4UEFyNmRyNVZ0Mks4c1ZJ?=
 =?utf-8?B?TEVmQkdFT2w3VlN1bEFERnp2NWFpL3hIMVNSaGhYZFcxY3ppUHBiL2EwL2lR?=
 =?utf-8?B?RWU2VXZQeXA0Tkc2QmZna0lRclJoVzZMMlZaM3MxVlZQRk9qYkNYeHlSL0gw?=
 =?utf-8?B?TVArMUplSUp4RGtVelBxN1JWMExRYTVuVlFIeDRSQndxTFVvL3VWcHQrb3hj?=
 =?utf-8?B?RWxZQllzUy92VWRzdHZmR0J5Q1ZKNnBmVDFqNHVVTVdqK1oyRmhNdDJhRTZQ?=
 =?utf-8?B?M29WclIvaWpNNHkvZEJEZU53TC9LOTZxRGlIR1NjaldqT1hzRWpLd2l4c1Bw?=
 =?utf-8?B?cXFSby9kalNjd296RTFZL3E1My9rOFlQZk5TQ1hsdG81Vnp4dzcvWGs1Mkt4?=
 =?utf-8?B?cHlWWkFFYkpzak1GR2diTFlWT1Fhd1hPTEFKdzBsZW15NnpUMHIwV2w4SXBl?=
 =?utf-8?B?Q3NVWE9qemZLbnIrK29memJJWnFmN0wwcnRiVUJZZXNPVTFCL29PNFhucWRk?=
 =?utf-8?B?cndoSW5xMWhFbm4xcUo4ZG44YzExdUxXV2hUaEliSU1ldDJRRFNEMDlnZnVF?=
 =?utf-8?B?ZGRZdUpWMWRDMnU1dnErK3hvWlRKL1FsUWgvNEJ5Sk91WGVmeU1IdGNuM2VJ?=
 =?utf-8?B?VWdDWVB2NzhGREo3V0l5ODR0N2ZFYTVmaDJ4NGlIR3JOVGtDdXd6NmJTV2Za?=
 =?utf-8?B?eDZPMXFDdU9PZ3IxaC9mZDBCYk0xQVBWNmhUM01LWGNtbnNrajBlTmd6dkE0?=
 =?utf-8?B?YWU2dTlsZm9vbU11Q3ljbnIrbjJyUFUybytQeDV4ektJSG1ubmdTcUVqQ3Bq?=
 =?utf-8?B?K1F5eGdtN1hMMDJiUlRIazdreVpBMWhMM1R5anVTZmx5c1J4SGVjejB2WUVL?=
 =?utf-8?B?R2FXUUdxOGRHTElIeEFGUFVIRjFXR2hlWXQ4a0FGZmh0Tml0T2UySnI3Q1NJ?=
 =?utf-8?Q?AnEzwy/dCi2v7gG7aO+eEH9Yu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236aa928-921e-47c1-75e4-08dd6ba86489
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:21:54.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HY1HwdJO33Tp+du5BUFXmsJ7XGoGCvYh+p+oxIeUcfnu8TMrcKzOsLF9a6o5dGnqbC02cSOByGOTF2sVqQ3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108

Hi Ben,


I forgot to reply to this one. Apologies.


My comments below.


On 3/11/25 20:05, Ben Cheatham wrote:
> On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 has some mandatory capabilities which are optional for Type2.
>>
>> In order to support same register/capability discovery code for both
>> types, avoid any assumption about what capabilities should be there, and
>> export the capabilities found for the caller doing the capabilities
>> check based on the expected ones.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  |  4 ++--
>>   drivers/cxl/core/port.c |  8 ++++----
>>   drivers/cxl/core/regs.c | 37 +++++++++++++++++++++----------------
>>   drivers/cxl/cxl.h       |  6 +++---
>>   drivers/cxl/cxlpci.h    |  2 +-
>>   drivers/cxl/pci.c       | 31 ++++++++++++++++++++++++++++---
>>   include/cxl/cxl.h       | 20 ++++++++++++++++++++
>>   7 files changed, 79 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0b8dc34b8300..05399292209a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1061,7 +1061,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>   }
>>   
>>   int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -		       struct cxl_register_map *map)
>> +		       struct cxl_register_map *map, unsigned long *caps)
>>   {
>>   	int rc;
>>   
>> @@ -1091,7 +1091,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   		return rc;
>>   	}
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 6a44b6dad3c7..ede36f7168ed 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -755,7 +755,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>   }
>>   
>>   static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>> -			       resource_size_t component_reg_phys)
>> +			       resource_size_t component_reg_phys, unsigned long *caps)
>>   {
>>   	*map = (struct cxl_register_map) {
>>   		.host = host,
>> @@ -769,7 +769,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>   	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>   	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   
>>   static int cxl_port_setup_regs(struct cxl_port *port,
>> @@ -778,7 +778,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>   	if (dev_is_platform(port->uport_dev))
>>   		return 0;
>>   	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>> -				   component_reg_phys);
>> +				   component_reg_phys, NULL);
>>   }
>>   
>>   static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>> @@ -795,7 +795,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>   	 * NULL.
>>   	 */
>>   	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
>> -				 component_reg_phys);
>> +				 component_reg_phys, NULL);
> Nit here, but if you just pass in a unsigned long here, and in cxl_port_setup_regs() above, instead of NULL
> you can get rid of the null pointer checks in the register probe functions.
>

Not sure this kind of tricks are usual, but I do not like it. It avoids 
the check, but it can confuse the reader, and the checks are not so many.


<snip>

>>   
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected mandatory capabilities not found: (%pb - %pb)\n",
> I think this will just print the bitmaps, so it would probably be good to highlight which is
> the mandatory capabilites map and which is the found. Maybe something like:
>
> "Found capabilities (%pb) are missing mandatory capabilities (%pb)\n"
>

I can do that.


>> +			expected, found);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_pci_type3_init_mailbox(cxlds);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 5c6481136f93..02b73c82e5d8 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -25,6 +25,26 @@ enum cxl_devtype {
>>   
>>   struct device;
>>   
>> +
>> +/* Capabilities as defined for:
>> + *
>> + *	Component Registers (Table 8-22 CXL 3.1 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> Update to 3.2 spec?


Sure.


Thanks!



