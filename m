Return-Path: <netdev+bounces-172647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ACCA559D0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF3177D1C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8902780E3;
	Thu,  6 Mar 2025 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZYMKLgn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A81311AC
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300366; cv=fail; b=D+TGfY+Qd2h8d72Jo9dIR6+u5xJZWQduAZU9AesISMVrJp17k/Ai6Q3Xb8YH8uCTm9lGegG5EENikxBi2mrCMJJR76t4MqBoX1aEJH6fVLMfozP+1DwsmwVC1AF3dUl7cYrfO37+WMcVoZXYQefC/X9vNL70eZfpztD6iKYCBe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300366; c=relaxed/simple;
	bh=gUjjmN1I9p8hiMcGSC/Mcibp0pK/oDf0xA1S4HO4ovg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qZCfCdTn2YRWAT8a5loR6ZYSHPSZCAMtPWjkGaCB92e0cS0Zo9bUIepFlYSDvmC5pw8LyWfPN6ypwdo/qiDeyw6zQrkjJrBKzkWV1MTOhel6sGXZng4oOuRPaHjHog954MYDEM5jieYkVqFnDn2r106xpXriBKbenVan/AaPLeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZYMKLgn; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6nu5O0uqab+FpQuAnsamow/X8bodzDPtrDDeAx5nbS4a5wxVjnWtV7EGk+0WTEAWxRGo0uzAdPLNPaAJ3l6eQmVJkFMM56M7VNq1Xy27sc2PLQ/hEb+iS7BrDbpM4m/e8Tnbj97xTFEGqsDHoWeqGqC/M7gv2jvlsn0WOGaUbAnynErjDeNH2GNFaHwFCr0qnR6jBQVeh0ytyx36+1votLqgDbLGQG85oHO16LRb3pEwB14nBrWKBjhl/uVIEDBQW/LxBj5pnFpj2e3dSUj6XiiJ1Gg0mrNazXnWUv/G0Cp6JW0TgYh5xO+hbEA0ULzDo9Mlga60tQD0R0w/Nth/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHrHj05EM4+rkQ36Q+u8fn3WUTl6f7V3SHa7mTHpb3o=;
 b=xZ4sT/Ub4RXHJEO9qmnhbyF9pALLi7UxidRaFrYgwdVSeB1DKxGJCzn6PaUJv/f/Q1+z3v+q8dEi6kVN+G5e5xiQnXYqV/2zcjrXQBAd6Wkh1BAMMxhDUgP0x47h2lHP6Sfa3eFe+nzQnh3gyW/CDiJC6YLX4h60s+rDNECZeUygoH9jSdvSEiMs4skIdIn60lR450c/xJY20R22QYNJ6MQohTDFcCHQtV25+DQ7e4IdGQX7hdH2UjQNjTjWvetkYqx0OOerrGhQmMx3+KswfaXsBnrMYaWFbNZvNiDnsSAH9IzgsvftOiT5NPD2wAkOH5aQn0l8BxxlGXW4RcpGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHrHj05EM4+rkQ36Q+u8fn3WUTl6f7V3SHa7mTHpb3o=;
 b=QZYMKLgn8dqQIXbMJOp7JcxURXa8xOaXBlpcO3d6NoVMpKhbt6kTsCZrlJI5OSRbQBy8Fk7Mhv+ZQwBikdAvKmoCEBv/vji6Cj6Iv7IXr0NURC0sglWaHOh0EmOhouFtnewGraMuyJ+L/XP3Ud84SMeWRRgFq2aeJQqsclA85ZLGoCznJPAmu25eXFmiOYgXEGVsarMQQld9Yato2rC7yBZSy6x8vfs4kO4+nwcdE1ZW4x42euzXI9giX5UpkC+nEqcYQbYXoRnZG7C53zIEVLGV0x5OzCSIxI0mfrdOZ1JCYMH/pqVRw+582dz15QxrYu8WJ8vYfRXOrnVPwCa7+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 22:32:41 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:32:40 +0000
Message-ID: <73263547-f3a2-4156-bca9-45b647e67830@nvidia.com>
Date: Fri, 7 Mar 2025 00:32:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306113914.036e75ea@kernel.org>
 <3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
 <20250306123448.189615da@kernel.org>
 <6ae56b95-8736-405b-b090-2ecd2e247988@gmail.com>
 <20250306134638.3b4f234e@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250306134638.3b4f234e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b8d775-8375-4481-e2bc-08dd5cfecdfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHErbGJld2p6NHY5ang4R3FnZXVIRndVVXdPcFQxN2l2TkFzUjZaOENxOFNM?=
 =?utf-8?B?eUJnLzJPRVlEcHFEcnZxTU9haDNPcFdHcWdnZmU2TjhicitpRHI0c0NiU1FN?=
 =?utf-8?B?SHhOeWZiWVlzWjM5aG96RFZRaEZ6dXBJUmxHVnhwM2NJdUhDeFlLTTFDNCtt?=
 =?utf-8?B?SEJSNG1DaytBSzJEdlBtbDVlN3ZSYXpRTGJ2bHN2REJ2V3J4Q2xUWDJrdlhq?=
 =?utf-8?B?RDRIQTBzVldGMzd4cGJXSkFrQjJNalVmbEF6SGVrMGN5YmhhTFJud3IrY3Ez?=
 =?utf-8?B?TmhIUitWTXZLSlZHbE1jM2JiUTlLSnJTaDNPVUdaMXRYVUgxS2Frc1dLVDlW?=
 =?utf-8?B?NXhiTURWZTVjZmM1TGpTT2FhVWlUN2JpQWpIeEFrd1NjcVJJQzEwS0l3VjQy?=
 =?utf-8?B?djJzMWhGNHNiSXQ2RHhlTzJFU285SGRtS1NyaVVBM1MxRENWa2pGK0ozcm1W?=
 =?utf-8?B?MGJWWDBNVy9GOXlNY1lsdXBOeERnanJmU0IxN3ZGVDVXUzlYZHd1T0Z3WXNj?=
 =?utf-8?B?NzJPckNSUDZoMXdzRkR1NjhUeDhUY0p6bURiTkJNSDduaHBMQk5xa0xxYkdD?=
 =?utf-8?B?TnpIa2crclgrbGJrZS81d3o1S05GY01nS1BGMzNhT0JuTnRIazEvSklOUFJK?=
 =?utf-8?B?TDF1enhLZEtjWDlCWVY3TDkzaXNhRWxEdlRjM0x5cGZmVXRvV2xneDR0OEdl?=
 =?utf-8?B?VjdXZlA0eEU1VXBaMHpjY3h4b2xIMzBYSWt3bnBLWDBoVGRFeHJsdHh3V3p3?=
 =?utf-8?B?alNmaDZ1UDd3Nm9XT2krRUU3ZTFHaW1xSEc3MVExOERHUS8xUTU5WE5wUER6?=
 =?utf-8?B?bDIrb3pYZC9xTDNaTXp6ZkRqTXVLOFAzR3lHQTFEczYxSmVLYlZJUUEwQjJU?=
 =?utf-8?B?Nmo3dW81WUVWQTlaUDNJb0QwT0ttNS80U0krWXdBK2Y5RHdyUHNCTXEvSEVW?=
 =?utf-8?B?RHpybEQ1WjdRVkN1T1ZxeElGRHAvdnRKMEpVUGF0VzI0WW0wdDJXcng2djR1?=
 =?utf-8?B?YWlENkVJQm9heDJjWCttOFYvUTF2TDArd1NxdjUwV3NDVlV1N2psZ3JGOHd3?=
 =?utf-8?B?NTQycjZKbUI5LzhZOGdSMHRPYVp0cXN2V0FTcmhHc3ZuYWQwSXRTZTBkZUkz?=
 =?utf-8?B?SHp6c3VHMmUvVDJnRzRpYUlNSWlxUldLcG9lRmMzem9nbndaZTIwaUtoZGVv?=
 =?utf-8?B?Z21wT2dES0dlSTd3TDhJcUNKUUFnd3BtaWZhRC80c25XbWt3MnRUN0o0eHNh?=
 =?utf-8?B?a1lmUUJvMjVhL3NFNGs2QzZ5ZVdYOVNOOThaMmNGWWx0dlNNNXVQbU9DeHFJ?=
 =?utf-8?B?WEx2WkZ0YzFZSHArekxza3Z4SDN1Wmk4SGcyZkpQK1lJYnQxSk54OVlwNy9W?=
 =?utf-8?B?OFJaT3ZFQzU1cVVkM3lJMUFERzl5aGpLaEFzcmY4Q2RFWTN2cXE4U1JhSHlq?=
 =?utf-8?B?bDY0cFNsdk1LRE1HNTQ2WC9nU1ZsY2dCbmppb3Rhd2VBZk11WVIxZitnOWRl?=
 =?utf-8?B?Z1p6ek1qaDgvSEZoMzMzakQ4OWNBNDgyQXpud2ZyamRYbTVKNjMzNVRlOXJM?=
 =?utf-8?B?WkZ4MzBnS2dFcWhxeGVMOUdNaDNpeG9xT3p1TGJGZEt1ZDZ4UXR0TU85NHZm?=
 =?utf-8?B?YU9DRytLS2pjdnl5cHdUSVRMYUNta0pXQ3dKamdwVzNFTnVqRWl5WWFLYzNn?=
 =?utf-8?B?YkRhblM1TVYwT3hFazlhL3Y5L3VuRzhUWklBaHBLSDg0QW9LdVd4YSszVFRX?=
 =?utf-8?B?TEhiVS9IaWcwTDJrZVYxTVMvMjQvN21rbmtZS09Wcm14T1ZodW1SVmhpRTcz?=
 =?utf-8?B?U0llalB2ZzhXMEZ0QzRYNEtabmRnQTVKUUtLQ3JLRWc4Mi9Wd00yVEVudWhZ?=
 =?utf-8?Q?NJ9EPHsgoZM+w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm44dmZBNFRJOXFvZjBJd0taT0dCUklnazdKekN0TEhRT0NJdVREVUJwM21I?=
 =?utf-8?B?NHNUMnoxQi9DOTIrbmoyQVIyVkVFd29FNGlpNnhlejVNWnEvRE53a3FZNzJ3?=
 =?utf-8?B?clZkdFNUVDExREV6UDFFdkFyS0szTUt3a0MvaWtJOGdiazA0LzhUTXBmbDV0?=
 =?utf-8?B?b1VudDlxd0tDSWZRRDl4NUxlMXNZRm5BYUE0cXh3MVJ6TmUzYnZJMXViaDlw?=
 =?utf-8?B?aEQwT3d1ajJDMHZOTGpkbHhUNWN3Y3FicTUyVFhTak1GZUJJZVNtaUprcCt0?=
 =?utf-8?B?SUE2aE1QbjI3VzJvd2hiN1pPNEw4bkNUNnJhU3B6MU9hMHVZaTZIRG5TTjJo?=
 =?utf-8?B?bTF6dkEzU3VQcU9YZW9IRU9FengrbDBGNHNrNHdZdWZwZWV5RDlycEVCTW81?=
 =?utf-8?B?UXoxcGF6N3VJRU5jeWMxU3FOMUtocjM4Wld2Zy9TOUpBYnlTNzBGQU03Q0Qw?=
 =?utf-8?B?SDNsd3NCL0wzcEdpYkhIN0Y2MkE4QllhaUNhRUpPM3puNDQ2N1o0eFBLcHNR?=
 =?utf-8?B?blJ6TjlMOGZrQXZCcGZiUnhiSWNDa0drS2dKUzczZCtmSUR6R09oT2FQVnFn?=
 =?utf-8?B?SW9CU0p4cjViUEJlU0x0MXZmTlFqT1pGaFVPZm45VUxVNlhqeS9tbjBLcnRo?=
 =?utf-8?B?bWZlRzU0ZUdOQW5RMndtR3l4Wm5kT0NLM2NkNUJFNFNUWUxwaHNidVNCU2o1?=
 =?utf-8?B?dnZmMEFtUmdRVVRxYVFwOVpPcEl4elpzOC9TMTRNVTRTMm9RUTRLREZEUUQ2?=
 =?utf-8?B?dG0yZ2t2NnpzS1k0cFBVd2gxVEQrWXpmT2MyYnY0clA1WFNDNGs1aG92U0tI?=
 =?utf-8?B?bXR6SW55MlY1Vk1ybTNqcHNIWFJ5eEgxUmxrdDJGRnBxVk5rR2k4NFJCSk40?=
 =?utf-8?B?VnU4cTZxR21VaEJxVkVkUXZQY1AxUk1UcFU2VW9reERDOXNGZzRpNVByOXJR?=
 =?utf-8?B?ejZqM3RsRlExaU1XaFpKcmFoZG13MjlxSkxvUFo4aldIekExaWZNZ3AzcHBm?=
 =?utf-8?B?K2FVQTQ0eEptRGlEYVRrVWJLUzQ3c1c1ZXBHeC9XMEpiOGVEU3RzZWFCTFJk?=
 =?utf-8?B?Yk9tVU9EUkxIU1Q3bW5TNi9HckZ5cGJkVVR4TGMzaUtYKzMyMFJSWDMwemU5?=
 =?utf-8?B?YndmclFUcmdNemRmZGR2UkZrekppMkNJMXFnMzlKdVU5cFl2OGN0dVRIOTMx?=
 =?utf-8?B?UXNQd1lUQ1AvRUJhZitJMlFQRWxrbW9lRDkwMlRrNXN2Y2hHQUk1VDQ5NGow?=
 =?utf-8?B?U2laU2JUVFJkODdOSlhlSENycEZKQXpFd2VjaC9hekpMZmNwdzQwdGd2bHNS?=
 =?utf-8?B?N2thUCtxN21KUWlSay9TMkhQamNkMzFrZktvZGJrb1ZOZXRhMU5lcHJWRE4z?=
 =?utf-8?B?cllpa0hwMVUzcGFEMGc0cVBGRGtRUXF2VXBsY0xaQmlEL3Z5TFV1Nm9iZ0lp?=
 =?utf-8?B?OUxjYnFpY3lMMmRwT1FLUTl0VUhTL2wzWjBTekhiakN0NlR1VnBuMzdncm9y?=
 =?utf-8?B?SmlhK3hwUFdmTTVQUFVhdjRQUW9URCtYT0dyWGFQN3RsODFwU3FZNXlLOEM4?=
 =?utf-8?B?TG0zWTJoeHlTR2J3T3oweGdRT1puZE05NGdBckg5clZlZjJNK0tERkxzRW1E?=
 =?utf-8?B?UWRBQUNqbFQwUURDOUFPWng1cjFWQVlqc2dzUzBNaGdESDFqUWV4blFjK0Nr?=
 =?utf-8?B?RmVEN21MV29VVWQ3MGZvMDBybi9nMGo1ajRJRmFHWXdNaHYvZ0sxTXJKczho?=
 =?utf-8?B?QlVyTEhXb0VlRHdMVkVjSDJLUnE3WEJ3a0JteGthV3hSYzJURW9jR2YycEJL?=
 =?utf-8?B?SEg3cFJPNk5vODBFTlVsVGZua1AxTTNkM3NEUEJrNmZiMElaUHFPWktMRXkw?=
 =?utf-8?B?dTVETk5RcWFJTVloWE9SKytHbHR3cWJ0K2llMjBzSGtFdHdvWWpkdVd6ejNC?=
 =?utf-8?B?aEo5alIxRXd1T1BUT0hDczYxZGZOR25YS3FVZWd5ZjVQK3dNckF5dkhROXhN?=
 =?utf-8?B?NWV2YUU5MWxDK1hSdGNhMzNLcmNUSXZWYkdQbjBJbHVnK2M1a3ZXaWVWd0NI?=
 =?utf-8?B?MUtSSEhZbmQwcjFRU0VzZ25LdTFHaFFWdTdXYWFQWEdUNXQyNDBuYWVoTVJE?=
 =?utf-8?Q?ANgYDE6FMMvi6exyozA7i5Vn3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b8d775-8375-4481-e2bc-08dd5cfecdfe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:32:40.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Zxij0yZcf6O8j8YhfiIy3KRsgS0s1X3d6rav7Al21YQZPCs/92cLm4oKqDkLZpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

On 06/03/2025 23:46, Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 23:13:33 +0200 Tariq Toukan wrote:
>>>> So no less than two working days for any subsystem.
>>>> Okay, now this makes more sense.  
>>>
>>> Could you explain to me why this is a problem for you?  
>>
>> Nothing special about "me" here.
>>
>> I thought it's obvious. As patches are coming asynchronously, it is not 
>> rare to won't be able to respond within a single working day.
>>
>> This becomes significantly rarer with two consecutive working days.
> 
> On one thread Saeed is claiming that nVidia is a major netdev
> contributor, and pillar of the community.

Do you not agree?

> 
> On another thread it's too hard for the main mlx5 maintainer
> to open their inbox once a day to look at patches for their
> own driver, that they were CCed on.

Is this new rule mlx5 specific? How come the driver maintainers are not
aware of it?

