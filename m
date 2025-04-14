Return-Path: <netdev+bounces-182145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B9A88043
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97547188C9DD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE429AB18;
	Mon, 14 Apr 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFI69vqN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325B27703C;
	Mon, 14 Apr 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633210; cv=fail; b=jU8F3QfShQKW+glt8a4xeUUNyOOYzwauDUJG4qytZ5PUksHbo2JUwPXOa1u9uPuYHyHDB9I8UoSavwemb7AKgDJRYczxt0jFVcmAWZ3lkZA30QrCqdBzPWSzLyDCKJNvvctwbPidhSe+pfZ6L2vaqUXMKWKrRzeqFUnvFj2GNAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633210; c=relaxed/simple;
	bh=mhW/r7e9J1q5uCC1/oWocL9ObNs0dKC0kWWALFiLNTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLXEy3O6ozG3PYZ0oFbqL+RJirdQbMm3XQ/c285cNYuKYdt5xt4i8cAEBW8AiyKIDYmd4bkIQG1r2FdUvkCR6TEqSnoUrVwYhre6e4h7NVNM8FbUIu0hZ5ulG213/28O1i3hltOyMmWG3Xl0sg0RX58Ujobv5+bhMZDlfmpoKGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFI69vqN; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAB2kJQVvqGxQA/MVKvmRvA3jazoPkTA1JARluHFrvlH3jaibHrr3yOkWzghPFZsYTc696avXXKMGuBz7W4BMT2wx+LEJllNAGRb2qFcOCZM35eHXugpE+3cooUuFBwuQl6uQ6oo3elX9oH5+K1RNz4nOiiWB+CTturypKQPucPX7E8WBw1c2ZhbxCxVxpVizcP0vwjWN1b+XzICA2oOud/8Ypro7ko1lpof2KVY2LyxVhJsn0NbsOwyXmxCgjMDcg0CNPF8vVn5GOsqZiD0xUiRWMBKbyKUb4CL/b4sT+nQSgvlIufF7btnJaQHfYJL0YlyIcDKL5dfDM79h06uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfyYlssVT9MtJkYzBrDfZpfU5eNypQGL6sEzqNa9shg=;
 b=DwtMWQYs5A/6Cpqa2CXMrh3x4crzQ4L1AqNMKBd2WEv1Wi8Z3AubAMkQmcrZPbJPMMInyTaq5IpBGfvPJ4HqgK0l50j/+WGSwNhKehYTTKF/ZhNZ0bQZRrCK2ryaP2tyON5zyO3rXdkHJic0yEbwYhFgES77EgvxDoc7rSNnPfTJt1OUEbkztSZEfj9CK8z5mEUVRAdsCHcNHep0mIzAfCqPfD7VbJ2b5ITwOnmdDfJ/RA+QYR6DGcsIY0zh50G9H1j0ns0PR0xtfjb6VlteaK+0dvdyU2JZ2VBrkAUO1vYxFtadB5surag5Vsqe/FJRTtxSMS+pIMivvuDvyyXKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfyYlssVT9MtJkYzBrDfZpfU5eNypQGL6sEzqNa9shg=;
 b=VFI69vqNU6emIHjT0xsL/nbMGXJZ40ql7UeK63p7ap8JKUAKnOqXNFEBj1uS5KkhjkiZbd2Rcv8Jk54Bwvv3M70JBxdFUgsU9vxT7clMltozobFpXbR/moWFNZiWpEyncHxPxJEMknppkCSJpN7pL/c2WkjY72EOFnD1y1T6uUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 12:20:06 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 12:20:06 +0000
Message-ID: <9f029694-7645-404b-8cd8-00837df64669@amd.com>
Date: Mon, 14 Apr 2025 17:49:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] amd-xgbe: reorganize the code of XPCS access
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-2-Raju.Rangoju@amd.com>
 <Z_jT6M_GYhMlxZE1@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <Z_jT6M_GYhMlxZE1@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 24116492-ec2e-4518-301d-08dd7b4eb083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHhXTURXbU9wTVpXSlQwNVpMOE5uQVI4L3lDbVBqNkhhMUgwWFh2VWFUeXRP?=
 =?utf-8?B?S0pRWitTekh1Q0lYcWJFc2s4enBzSEJjQkVFbEhSSm5IQ1B6UFZ0VTFDb1p2?=
 =?utf-8?B?MGcwQVFKRzBpOEg3ZjVGNzNabFJETUxNT2ExaW12dmxJSjJpK0xTZStHck5m?=
 =?utf-8?B?SGhsaGlTd0NicSs2V3pSTERkYzVEMEFLU0RHSGdYNTQ4bHlXUkwzQmRvaFJi?=
 =?utf-8?B?TmU4TlcxWGRscTByOU5yWUZTaDVFRy9IOGcrbnlUNUZlS3VTUnNvWkU0WGlM?=
 =?utf-8?B?Vm44bE1qUXlJV004elBab1pEUkhzN2I2YUtzRnl1SjJNWHU0eUUrQ0xuWVNa?=
 =?utf-8?B?dEtKOFRiazA1UjVNMmI3K0tMOTExZlhyMkJ1bUFaNHM5cFNyOEI4WVJPYkto?=
 =?utf-8?B?eE40RGp3UjVFeTRvQlowWEY1RWw0QWFsRGdRVVQ0UTJocFNVSGtjY3VGdno2?=
 =?utf-8?B?YS9kNVZ6aHpPZE9sOERTbXVLSFlKN2JrMjFYTnpISWpaNWdxdXlZR1A4d0Rz?=
 =?utf-8?B?eGlsNmJlb29pQ3VGTUpMRlpYdVE0b2RHN0JQL0pXYWJjZXA3SUpRMHpQdHE5?=
 =?utf-8?B?N21mNHcrNktVUWxkT3FnbXJ0RXN1eHE4Zm9tNE85S2phMVVqN0JJS1g2ZkRV?=
 =?utf-8?B?RWN4SmlXSnhWTHZGRFdRQm01elU5ZFpEQUhWdXF2SUFhdjVDbVg0eUVKNmpp?=
 =?utf-8?B?MjNnNFdqekpHWkVkVVE5QTN6SURHL1FVQ1ZGU2lmc0NyYTlNbThhT3lRU2ZF?=
 =?utf-8?B?RHdGdGJPd1EwWnpyS3dOUjVobHdveXozaUlsanRUbEM4M0pEbzdYVmFrYk56?=
 =?utf-8?B?VXFIY2ZhWER1RW5DNW1EQjUzbmFMaGJsSDlycVg3eXROeExpcjJ2c2Q3bEpL?=
 =?utf-8?B?UHZKRmVJNHc3QkZTcm96Yks5cVAwZUxzSDYzdm9UQzQyRVpiUU5KYlozMGoy?=
 =?utf-8?B?REh4dFNjbitjU21XVFE1U0N0cVhud2JNaDhrRkQzMHJ1TkdRRG9CaGl6Wkpu?=
 =?utf-8?B?Wlo4UDMzNkF4VVNWcGdzbU81SnVPUFFxYXova1luVEE0M3JkRm9GeWdUeGxN?=
 =?utf-8?B?Q3FhY2ZUQ2ptajFUUHJMU3JOK2NzUTBCN2diK3NDSVJFWUNxdldZUkZrOGdF?=
 =?utf-8?B?cjhQaloyVExyeGpDVE5UVnhUUmh1MW1rdzcvMklKdGFSL1BSRUlraUJPRzQr?=
 =?utf-8?B?UWQzNFBpd1p1V2s5R2pkUTAyeVJMbGdXYmRnUGJnWnI0TWpMZVNwRStNVlYx?=
 =?utf-8?B?NkxyaE5taEJTMmtHZ3VqcXRjakJZOUNkUEwwTXJOdzJ1UjhBbjR0TEZRbGp3?=
 =?utf-8?B?bTJ6d2dTQ1lkWUZydGVMbEwvZGwzMTA3TVpSeFZzMGFHYWM1ZG1kMTdVT2JE?=
 =?utf-8?B?OFVCSktQUmR3ZWtNQStkS3NNN09NUE04Nzg0cUErU25NZXQ1S3JodUdhdm5E?=
 =?utf-8?B?NDFEc0h5RHNMTmtyTzdacW1wUmdKZGpCNVVFYlg0dm5oYW92N2VEZzR0YU5V?=
 =?utf-8?B?VFlybHJXd0dBaS92S0ZDYlk2YlZxaklaM1FURXlJdVhpWnQwYi9NMG5pdlNY?=
 =?utf-8?B?K2k4Zlc1V0cyYndXd2tiRHpkVzdlcUJBcDBNMzFGdmgvNzdObmt5TTRZbS8r?=
 =?utf-8?B?bzladWVVQ1h4cVhLcFlBeExqcDJRWnpUSm9KNmlIeWxiU0VmMmFWbXFmcDQw?=
 =?utf-8?B?Uks3b0hlM2pxeWRySVpsZGZJRHkwY0FCOEQ3OExhZVZiWDZONkNBUHdBNmdF?=
 =?utf-8?B?azNiRmwrRTE2ZEx5S3hnSmVkNkJERk1TcG04MjgzcDFWWERCQ0M2dmtGY2RW?=
 =?utf-8?B?ZlZXY3FPc2VsVG40ditLbjkySnJLQzZReFk5NjIvSXllazNQMnA2dW41aDc4?=
 =?utf-8?B?R3FBZEFoMXY5Yko4bUlHYUtJNU10NVUwT3FsTkhYaVVKVHJiOUdYcnVwdGZ2?=
 =?utf-8?Q?K8M8Kxkxulg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjE5REdXaU5QelU4KzZzd200V0RLYTdEY2tQWkdObm9UTDVtUTZoSHR0cEVI?=
 =?utf-8?B?dnpSVDY2Y2laUjQ1aGMzRHBUZnloUTZ3SkRvQ28zSDBmcm9xVW40NWowYW95?=
 =?utf-8?B?UUE4YXlhQ1hkZmxHcDNjaHg2ZzhTdGIxOFdCdzZJMnh5VDBmL09PNmU4dmc3?=
 =?utf-8?B?NUFPbk1TeG4xK3NiV1ljcHFsRHVuTnRzdmlsSGRLalVLZ1g1aDJKSzdoZWxL?=
 =?utf-8?B?eGxBY1VKOUtvaGgxV3hkYXhRS2JKS3JpdlF1Y2dRZ3gwYTB4d1lZTEptY2xm?=
 =?utf-8?B?Q3NCblp2UE9FT3ZSN1V5am52YStJVnNPbVFrRlFkSnY1aHFHNG9pN1M3K2hH?=
 =?utf-8?B?L2JEY2lyd211TXNQbWg1SnUybGcrSitsODlCWTJRdmt1a0prbVpLZTkvN2tt?=
 =?utf-8?B?WHJ3aXdjcHI4QnlFOC9OT0xVWW9YYTYrSnRmdFRsdzVRTzJUL3FaSmxEMDdz?=
 =?utf-8?B?Q2kzWkcrb3dJU1hXZlhxdkU1Q1NRWmF0TDRGU29JMnRLMTV5TXFSZEY5Z1B2?=
 =?utf-8?B?S2xONm15S3BOcjZsM05Hc1Z2U0FTU0t1Q1dIZXMxS0xIcFZOQ055MVZLQzkw?=
 =?utf-8?B?RjF5UUlXM2gwanBoOWlXMGJiZUNBRUdkak5OVDJPekdyT3N6UTRxR1ZqNU1r?=
 =?utf-8?B?Q241WjQrRFplSThzTnQwdzZOd1ZzNEg3Sys3cFdBZFFJVEdQOFhtRjFib0Fa?=
 =?utf-8?B?U0NwbmFHR0tEQVhLK2lwQWgwTzFwMklqcTZiRVUvODdRYzlkbHRDSjNDQjBi?=
 =?utf-8?B?L25hV1dOT3BFeHBmckhVNTFOSTVJT3RlbnNaTEM4UDJ6Q0wweW9XMVJaZWVn?=
 =?utf-8?B?UHo5eHkyUytBV25HY3ZVRk5LT3FkSTc4NDgweDJQbFlQT0R6SUhIM3FuYVJ3?=
 =?utf-8?B?VGl2S3NlZzJTVDYrZ2pNYkQ4dDF0NWpZOVo3UEF1RXBBWWNMbGM3TmNEQ3lP?=
 =?utf-8?B?N0RrdFRhRWQyYk5PUmdYMUJWWTExeWNKUmJJaGtUZUtNL0g4WCtQcDdacElG?=
 =?utf-8?B?NnE0M2doL2hnaytOaVlpcUZJblhCN29IOUZJcUpFbDN1M0lOUzlBSG8yUWxV?=
 =?utf-8?B?TWRPajdvM1EveEpCdDVRTU51VndLOFFkVFNFRnB2VFpJMlU5YUxBTHRxQnY2?=
 =?utf-8?B?K3FhdGZpUHlNTmNiUVdFK01iRFdaV0VxcFQrNmhDejVsSFRBV1VoWE1QcFV2?=
 =?utf-8?B?WWQwVmNXMzlhT2FzV1lWTHpIK1NLSmtid1NVN2V5MnFlRkhJVzZFMkRuK0tS?=
 =?utf-8?B?SzdITEhBZEpyZzZNaHptWHU2Y3JUSVRTaE5QTERzZTVWc1NLNWhsU3hxZ3dW?=
 =?utf-8?B?aHdIS2tROURtemNpT0xTYVhWNmNuWXVnby9lR0hOajBFSE4rN2tndzl5bjls?=
 =?utf-8?B?K01ET2JHRnp4MDcxSGtOTXdhZFZ5VExHZ0cyNGdidC8xa2tkZGduTkY2QU0z?=
 =?utf-8?B?VTI3Uk02WFlZZ3ZsWGVxQk1zNHdyU0lDVzEyKzNmbkl6VXdUU1lucEpxWW8r?=
 =?utf-8?B?TUxZUmZVZWxHa1NWcTFrR3piczcxKzAvNGhyeW8ycVRja1Jxb05YaVp6ajlh?=
 =?utf-8?B?MlNZbFhoVUVmNmdrYTYyT2hGRERxeVFhOGZJa0lUQzZvdllhUVZwZS9hc0Fr?=
 =?utf-8?B?VDlVNW81S2ZnRGZUcFNva2d6TDEvaFNGYWE1NHhNbTBrK1dicXBJTjREeGxO?=
 =?utf-8?B?MWdRTmZ5bUVqSkYvajh5OHNPc29hejg4V0wxYnYwVU5sak9lVTJVZjdZWTJY?=
 =?utf-8?B?U2xCUS9YNi8ybUdJd0tPVjgyMUtUNFo3Q1Yvc3FoZkdmNzNMY1A5a1JraWhx?=
 =?utf-8?B?OW9BOE5CVUdNc2MxeHpWbnlsalE0c3BML1FRcGt5TU81SkxEeW81bEdNeG9a?=
 =?utf-8?B?V0k5bDUxVEpteUpTZFVoUGRmcTduMjhzZ2picjhwK0V5RjFiZkMxYnhtS0No?=
 =?utf-8?B?dkovSnE4SHVKTUQzSTJqQXk2ZDNoaGE4YTJjNmVkVVQ0b0x5Qk15dFB4Y1N0?=
 =?utf-8?B?dG9aVVFyTUtiSTF2OEtMV2xEREljSW9BRUxwV1BDSDNqOUYyRVVzY2s4Mkg0?=
 =?utf-8?B?UlgzQ1J6TDJuVFpLYlNRaVBROFFqNEQ3TDFMYmlENUVYQVhlOG5VbTNLSnBv?=
 =?utf-8?Q?MhtDzH1cw0KJCFlAzJb/aMnRH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24116492-ec2e-4518-301d-08dd7b4eb083
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:20:05.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXasjtGNqWDUwcqxtFvHlS+/FML1FuA5SHYWVPGCeYDpU5ebpDNtUzT8YXO/fv0XJdu57SoLBBuzLKCmpEzWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435



On 4/11/2025 2:03 PM, Larysa Zaremba wrote:
> On Tue, Apr 08, 2025 at 11:49:57PM +0530, Raju Rangoju wrote:
>> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
>> be moved to helper functions. Add new helper functions to calculate the
>> mmd_address for v1/v2 of xpcs access.
>>
> 
> Overall seems reasonable, but the new functions are missing the xgbe_ prefix,
> contrary to other in this file.

Thank you for your observation. We have additional patches in 
development that follow this path, and I'll take care of this in the 
future patches that follow.

> 
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 63 ++++++++++--------------
>>   1 file changed, 27 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index b51a3666dddb..ae82dc3ac460 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -1041,18 +1041,17 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
>>   	return 0;
>>   }
>>   
>> -static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>> -				 int mmd_reg)
>> +static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
>>   {
>> -	unsigned long flags;
>> -	unsigned int mmd_address, index, offset;
>> -	int mmd_data;
>> -
>> -	if (mmd_reg & XGBE_ADDR_C45)
>> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -	else
>> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +	return (mmd_reg & XGBE_ADDR_C45) ?
>> +		mmd_reg & ~XGBE_ADDR_C45 :
>> +		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +}
>>   
>> +static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>> +				     unsigned int mmd_address,
>> +				     unsigned int *index, unsigned int *offset)
>> +{
>>   	/* The PCS registers are accessed using mmio. The underlying
>>   	 * management interface uses indirect addressing to access the MMD
>>   	 * register sets. This requires accessing of the PCS register in two
>> @@ -1063,8 +1062,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>>   	 * offset 1 bit and reading 16 bits of data.
>>   	 */
>>   	mmd_address <<= 1;
>> -	index = mmd_address & ~pdata->xpcs_window_mask;
>> -	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>> +	*index = mmd_address & ~pdata->xpcs_window_mask;
>> +	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>> +}
>> +
>> +static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>> +				 int mmd_reg)
>> +{
>> +	unsigned long flags;
>> +	unsigned int mmd_address, index, offset;
>> +	int mmd_data;
>> +
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>>   
>>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>   	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
>> @@ -1080,23 +1091,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>>   	unsigned long flags;
>>   	unsigned int mmd_address, index, offset;
>>   
>> -	if (mmd_reg & XGBE_ADDR_C45)
>> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -	else
>> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>>   
>> -	/* The PCS registers are accessed using mmio. The underlying
>> -	 * management interface uses indirect addressing to access the MMD
>> -	 * register sets. This requires accessing of the PCS register in two
>> -	 * phases, an address phase and a data phase.
>> -	 *
>> -	 * The mmio interface is based on 16-bit offsets and values. All
>> -	 * register offsets must therefore be adjusted by left shifting the
>> -	 * offset 1 bit and writing 16 bits of data.
>> -	 */
>> -	mmd_address <<= 1;
>> -	index = mmd_address & ~pdata->xpcs_window_mask;
>> -	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>>   
>>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>   	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
>> @@ -1111,10 +1108,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
>>   	unsigned int mmd_address;
>>   	int mmd_data;
>>   
>> -	if (mmd_reg & XGBE_ADDR_C45)
>> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -	else
>> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>>   
>>   	/* The PCS registers are accessed using mmio. The underlying APB3
>>   	 * management interface uses indirect addressing to access the MMD
>> @@ -1139,10 +1133,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
>>   	unsigned int mmd_address;
>>   	unsigned long flags;
>>   
>> -	if (mmd_reg & XGBE_ADDR_C45)
>> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -	else
>> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>>   
>>   	/* The PCS registers are accessed using mmio. The underlying APB3
>>   	 * management interface uses indirect addressing to access the MMD
>> -- 
>> 2.34.1
>>
>>


