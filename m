Return-Path: <netdev+bounces-97515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F38CBD24
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AFE1C20AAB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F57E57F;
	Wed, 22 May 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5Afhm5l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10017D096
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367248; cv=fail; b=M0gvbdiugwxkB2oppqxnC/MK2wPBNlRy1LM5wK6W40BF4nxjtFwEvEPuYOISV1FIxnUn/ifbfvAM8j9pjoa1KnGTge1cq4Fx1TDXc9dpZvNyM3vX6W1nUcXxGIeGARfM9sII1d0stp+XIWhTmhyhsHYRCGVx3DsrLuVbLrE7GPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367248; c=relaxed/simple;
	bh=VM4kFiOhsjv3X0Y7M6sh9v44xB+sUCci1sBKyXbdIKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RlwNqQFFhrJXl75ZFd2u0vJ/IWgMbK3+0BA2LY9eOEem2NZsdyX2baTL1SLVtXjZwzlIS62O+AyHO/C87ImF7gtt+w3VWKoBFcgshyZnysJEPANwC2FF056ljPosMjHXaw2AevkIbBlNtMOz6D1sD3IKSOHX2yyd8qgAS0wjDro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5Afhm5l; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrJNMKWZoUP7L3W8/KcbcfLoy2vOnYrl1/9ShJVv1Aj8CwlbSC/eCedh5iMv3xlZD0kxj2fOu1Vdv7/h7RUIB5TApsZ68BDc/AsXYPiv/K8LzjGGLfFnajjwafzFtTKq9Eu3t0/dljGnaJQtW0ry43S8s9QlDo5ggTP87xG2nECI8tn6M4zFkRmGViJ4zXePWVjPUb+zyHqJqHZsqZPRcMk1JsAM6RZoFuX8hcOm1+LYVqmHLh4i5yp3WL/5Cr/iZekTPOzdIXCqu3u2bw5RB0V9PCqNiymew2WB16vmmm8om2tw+9ULyN560UkTRIT6A527YeB9RGq2V9H4xQStLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un6YysUMqOpZJbkSAZIzMJ5F/W2pMWHAAZ4GIMz5TvI=;
 b=JtjobOFQifrAcpw38cTdh2BNd89/6MwmOh5xtC8fPhchnMwqpqGrrTS/PNuATZooBuioKiL+7Ve+g18HsVZz1h7VgS/sBsJL1Aj+XdRoCph/EmEOcUgd4hFbx+NeiSthmzQ6uVl1TEbsfYcRm3t51gJRQHLoZIHMftWNGcHMSGvpXUlsxsshqVT12mMYkA4y3BtqKD3L38r8QoxfprFnlpYaGI7WGoqi2H56byeR2A6GfQV+qpRDTFLxcCH2oBAKUn637ltS685GO3Z4uplUttwF0zGXjvxxlJajKh/T7+Dpsjk6RqOwz7Rezf9oJ7d6U6ZbUjXP96Q0xFX1H0HgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un6YysUMqOpZJbkSAZIzMJ5F/W2pMWHAAZ4GIMz5TvI=;
 b=J5Afhm5l6/YtzeWh3Mpee0CwjROtPMOkUFl8hMLUo6osoOzq4Lk9VHFiGypnvMxqG/BW8j5K2B8UMZxqwQn3fv+FEdmpbrqS0iHitFQFarvN9OXaoiKzOpixueIqdf9K/4s3Q2zEKyCSuLmlHAb1Ow39HWRwPH7E90MwV8Nx4XerTutv6N6bjMdEciUxxT/JquF1zWqnfT/sDTnxBJPDBR0FibB3mlKuJfOrxnJ1A3bta51ekWit8ObOuBWt5Hl/Qq2O8fAxTJjnQnoCER/hWKX4vmF0hfIqI0vED2XF2Y48n1vtCyjX/jQ7lmH6LfDLORgF07rBqzEWZrvcIoPODw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 08:40:41 +0000
Received: from IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded]) by IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded%5]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 08:40:41 +0000
Date: Wed, 22 May 2024 11:40:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <Zk2vfmI7qnBMxABo@shredder>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
X-ClientProxiedBy: LO4P123CA0622.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::7) To DS7PR12MB6168.namprd12.prod.outlook.com
 (2603:10b6:8:97::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6163:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c8774e-b35a-4765-e9a1-08dc7a3adc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUFRSlIyZTdWVU9tK0p0RGZRUEZKbUE3a21pSFRYYWJFbFRzQXdQRDZqdnNs?=
 =?utf-8?B?dVYvU1pRbUwyWHRlc3Nvd2hFOENDQW84VXY5SnhMU2ZiVjEvWVlXNjhrQjhi?=
 =?utf-8?B?S1dydGRhbzFhbFZIeDFhRzhkRHA1RXg4dG9lY1NrT2RRTHV3MGtNQ0Q2YkhT?=
 =?utf-8?B?SFE2R2lFS1dWaElqb3RhdFFhVCtFbnREU0V0NGVFeG9Fc0NaNHV3K0Q4dUZn?=
 =?utf-8?B?clQ0ODNuZzE4YWRnUGlIVWcvU2k1MnNUeWFRem1Kb1dqVGl1ZGV5ek45aVRu?=
 =?utf-8?B?Vk40d2p5eXFtZWFGYzJmV25lenRVZVFLQ1RuVXdIQXd6eDZab1hWVHZPY3lp?=
 =?utf-8?B?NFdEMG9OdEhxNStRNVYxLytUS2hEdk14M0RTdndZK1VHWnRRaHVZZ0ZRN3lR?=
 =?utf-8?B?NnZGTHNuemo1ZEI1c1V4L1EwWHlSbHlFOTVtWWRFN3o0SWJBc3VuRWpOWEk1?=
 =?utf-8?B?bm56OTJFN1dLcXdPc2ozdVNtVWdsZUlzSVVzRkQ2bmRoUFoyNEVUc3lCRHNj?=
 =?utf-8?B?Ti9VL09SYVRQY3ZJRWJmb1MwakZ0Zk9oc3ZSaHZJSjlrREZnTmVBTXJWQUJk?=
 =?utf-8?B?b3RyUGxyTmxseGlKYUZhYmYrZExhQUhURFBjVHlVSzBBdGRvNHFRWUhyNXVy?=
 =?utf-8?B?Si9QSU83bGEvcndwaW5pVGNTL1pKZnRUWlFNaVpQWUkyWVpXbnRJLy9ybkFE?=
 =?utf-8?B?UUw1Y1pNNCtLaFVFajgxQ2dVMmNWU081V2pQMEVFbmdMQktxSFl2TFdQR0tU?=
 =?utf-8?B?S2hNSFVyOC9kbXVpOTRTbklSZ21CbDBsK1JRc1c5U0M0L0xvMmt1UjlCZHIy?=
 =?utf-8?B?YVpKRTRZZkVkdWtEWHZESkxSa2JZUi9LWHJDRnpGckpzeG4wQkk5WlpocXdN?=
 =?utf-8?B?Z09sa2xla0lnVmdKYzU1dDRCb2ExYTVyMUJiMTZJamRyMTFXWGR5Nll4SkNL?=
 =?utf-8?B?TnR4MnAxR0hQQUNkMVlsN1ZOa202YlczVXN4UEUzclFaOG10alFqODdLVFdC?=
 =?utf-8?B?V2dpS3o2Zkk3em9uYzFuS0VDS3RUdms4OU5FLzQ2MHB5VFZoWEhpVU9Vblcw?=
 =?utf-8?B?bEtIK052VXpSSHBBeURuSTlNRXR1Tm9PZmZYRWJQbUhnb25WaDd0c25PWWl5?=
 =?utf-8?B?RUxjaU5meFR3TEtYZlhSWVNRR241bXdLMVl0NFlaZ2hISkk0R1o4aitkMmJq?=
 =?utf-8?B?U3hYRjlqMWZBdFlxWTZjWGRWTTBvKzZRYkJsRGxxYitBSGVibVBoS1ZoK3lF?=
 =?utf-8?B?bVVwVFB2YUpCTWpvY0JBYUNOLy8yQmlpell0WmlBbmVRQ2dIMlFmenhwOWlB?=
 =?utf-8?B?WlVubG96OGt6RHJjRHRsOW9KRkRLMjkreWZNbVg1SjY0MWVOS0lJQ0txdGhY?=
 =?utf-8?B?UW15L3Q3bEJoUjlxa2Y2aWNzdXZHVVNYV2JhcmtnUlo3NjFmd1RhMklCQ09F?=
 =?utf-8?B?WEdQVXB4clRBMitFSnRKZVg5VnZtMk1lck1TcFRDZ1BPM0VvY3kxQWtRdmY3?=
 =?utf-8?B?RDFuajhiblNmN2M4UkM0WHJNR1Z0akFoTzFFWGVVNTFpVXhsQW0xNTJZa2RS?=
 =?utf-8?B?RWk2SFJLNWJ0YWoya1RyUEtnOGp3SU9sVnI0TlNha1FvQ2xad0hCL3RSWkgr?=
 =?utf-8?B?UEVNdE12b2dUM2NoU2VnNDhaeUVIR2tOb3NDdnVObHk1U1loUmU1SFFQUDBL?=
 =?utf-8?B?Unh1RTVZckoxaHFiaU9MdzgyS2NoZW4rMkZMUWxDdWVCeUFYWE84NGhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1KRHBCa01YY2pzUm9CVVM4UGdaL1RFRWlQOUV3UUtxbjV2UXRMMnhEUnVz?=
 =?utf-8?B?SXc5c0Q0K3U5Vmx3a2NtYUFMRDV2WElLbytOZU9Kd0dabFVSNm9JMUJ3M0x2?=
 =?utf-8?B?TDJ2Q2RWMXRMdUN5ZmQwUytkRXRxaHdnUnpyTlJWcEtTbDRTU1Fhd0NTTnJX?=
 =?utf-8?B?TGlkWW1qK29YSVZKYW8xSDMrbmo2M2J3NVJ2WnMvUlY0emtPVlRLS2ZoNmww?=
 =?utf-8?B?eGd1aVRFbFVUaEVzRFR6Ny9NaDRoQWpuR3dIL3dZajdzUTFaTS9aVHozMFc1?=
 =?utf-8?B?L0NmcjEwN1RLTDFhYU9ZbXd4K2pzYzZBeVEvUXZxNW9WbUJFK0xvMFVXR3RN?=
 =?utf-8?B?UE5DYkkrYlRBNEx6cFVqcVBzNXU1cTVVaDhwNTVkdlZma3hxNU8xTFF4NUpD?=
 =?utf-8?B?UUcyanl1Y2J4aVEybUVXTVpSalA1UVEvYWJKOUovLzFaaVhrR3RXQWNHWisr?=
 =?utf-8?B?VDhKYTA5ZEFES3ByY1E2VzYrY3JkT1hBZWhaY21JQXlPNjNQT1pyZUNpTGdo?=
 =?utf-8?B?UmZBKzk4bERRTnBoTlZxNFNXbFl2Y0VuVWo3OWlZZlhGOFJRcFgyK1pvLzhO?=
 =?utf-8?B?eDhxMGFrRUM3aEFudlFidUFaQmZObEhYcmVpMzZ4VEtIRDJSWWRsNW1tZ3Jn?=
 =?utf-8?B?bFdVNStxRERvN1JGMWg5eEdsUFZzK1d5UEhueWZzei9hOHFiWXcwd0VjamlB?=
 =?utf-8?B?VmREbzJSdmlhNVhPQkRaWGk2NFNuQTRxVTFib2MvejRpNVBMb1dETWowbERX?=
 =?utf-8?B?akFsSGJubklzOXROL0w3TVhadXJKUFVxS1NJUzgvNFduSHFGOGM3Wll2TnVN?=
 =?utf-8?B?KzJsajhIclV4aCt0Qm90QzhGeklRT1I4Zm9VVllIeVJWdmtZQ3hSYTRaVkd5?=
 =?utf-8?B?TEN6N2llV21yRTdoUDRwS0tGTnpXVVlTeW5NZTRyblcrWmJVVVlrM3R2TXNw?=
 =?utf-8?B?UTFpQXZKMk1yNUVLaWFPR2ZyblA3NjNpdWwxVFJsVktvQnhJakhaNU9mbmNI?=
 =?utf-8?B?V2tacElYdDdVdnh5UVZZQ0tkWCswVGJ1MXN5NGQ0aWlxWE45bkQ5dFZyQ09J?=
 =?utf-8?B?aUhuTmN4eTV2UU5UU25qM25oRDNvWG4xVlp2ZHJOa3hwUHlCNmNEcEpnTzdq?=
 =?utf-8?B?cG5Dck9MaTRBUTNRSzRtK1RuVWM1NDhlTmpjN1VhNjZZL1daeGdyTGZPMEpD?=
 =?utf-8?B?QmFtb0J1RXhwbWV5Kzd1YmIxVzRvb1d1cUZQQUx5Mmt6dWM0NTBPY0h2bzNV?=
 =?utf-8?B?OS80Z3JwRDFHM21uM1hoMGsyTnpYdHBzajYzUXRCeU9oMDU1em1KbEpDYTBq?=
 =?utf-8?B?RGNQdUlQL2UwVjJOSWdlVW52Y1ZUT2FlWW9hUWFoV2JFRHVzeGlWc2VOMzVp?=
 =?utf-8?B?dkoxQ2ZMcm5qU1ZFMGQyRU44ckdPME1nYkJSUys1QWpTdzErN0hTSmJpV2R5?=
 =?utf-8?B?NFplTHZqMG90YjRNamtnNHk0cldNZEZkM05HZlcyMDkzVGV5THRySVY4Uy9M?=
 =?utf-8?B?Z0t0TmpYKzZuZkFDTWxKN1lwRXhheFRWWWRLYnhReVFtUVZMZkUxZVVudlVi?=
 =?utf-8?B?dW9YMXRseGVlczE4QkcrQW9iWHZTZlRMajRqTnRJTWZPT0RmVmh2OFFmYlhB?=
 =?utf-8?B?Qmt5RFYzbWZ4ek1hc0hRRVFJcTR5V0FJdnEvZ1lPWUJEV1E3YXZSRVFNcUFX?=
 =?utf-8?B?T2xPVzMvTHprTTFKWG1XaTBXcFgvd0E5MHE0aEFMWm9SdDU0V0pXbTVBYVZ6?=
 =?utf-8?B?Y3FNMzlKWHdJZnFPd0V2a0RvRUIzMzBYYmZYenRtTXozSmhpVHpJY2Zndk9w?=
 =?utf-8?B?Wkd5eTFMbktURUYzOGdlVGdlRmw4aFJmVjBoVitiMHRnQW1YeElURWs3N1Vu?=
 =?utf-8?B?TlVHeHBwSWF1WUFLeTNaQzJRd25sem5rWitYaCtCN0J5aFRGdGliUEp3NmpD?=
 =?utf-8?B?UEhicTRiMXFHclphWkhpenY2cjNvRURBNVNQQzJDbGsxMFp2U2ROWEhYTlB0?=
 =?utf-8?B?WXpONlp0QlNXY3Y3UndEbnpSMDFwaEdibEN6eVdhcjhGMXI0MnNqMUdHd25o?=
 =?utf-8?B?bFlrZEtVdHM0VmlmSUsrbTJpVS9NYlc4ZThUN0l6MktXc1FmaU1SNnc3TmhW?=
 =?utf-8?Q?8PrpfDau5MPfwsyD0wLTePAh7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8774e-b35a-4765-e9a1-08dc7a3adc57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 08:40:41.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTwlUGeCLdJbIh8LxLf8QANyGG0W2of9TZcNHp9jHx3D4AkwGegrXL2LUVA4ZDviU50LEUZRBa5RPlSTreNv8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

On Tue, May 21, 2024 at 09:54:48PM -0700, Krzysztof Olędzki wrote:
> Hi,
> 
> On 21.05.2024 at 13:21, Andrew Lunn wrote:
> >> sending genetlink packet (76 bytes):
> >>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
> >>     ETHTOOL_MSG_MODULE_EEPROM_GET
> >>         ETHTOOL_A_MODULE_EEPROM_HEADER
> >>             ETHTOOL_A_HEADER_DEV_NAME = "eth3"
> >>         ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
> >>         ETHTOOL_A_MODULE_EEPROM_OFFSET = 128
> >>         ETHTOOL_A_MODULE_EEPROM_PAGE = 3
> >>         ETHTOOL_A_MODULE_EEPROM_BANK = 0
> >>         ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80
> >> received genetlink packet (96 bytes):
> >>     msg length 96 error errno=-22
> > 
> > This is a mellanox card right?
> 
> Yes, sorry. This is indeed Mellanox (now Nvidia) CX3 / CX3Pro, using the drivers/net/ethernet/mellanox/mlx4 driver.
> 
> > mlx4_en_get_module_info() and mlx4_en_get_module_eeprom() implement
> > the old API for reading data from an SFP module. So the ethtool core
> > will be mapping the new API to the old API. The interesting function
> > is probably fallback_set_params():
> > 
> > https://elixir.bootlin.com/linux/latest/source/net/ethtool/eeprom.c#L29
> > 
> > and my guess is, you are hitting:
> > 
> > 	if (offset >= modinfo->eeprom_len)
> > 		return -EINVAL;
> > 
> > offset is 3 * 128 + 128 = 512.
> > 
> > mlx4_en_get_module_info() is probably returning eeprom_len of 256?
> > 
> > Could you verify this?
> 
> Ah, excellent catch Andrew!

Yes, I believe Andrew's analysis is correct.

> 
> # egrep -R 'ETH_MODULE_SFF_[0-9]+_LEN' include/uapi/linux/ethtool.h
> #define ETH_MODULE_SFF_8079_LEN         256
> #define ETH_MODULE_SFF_8472_LEN         512
> #define ETH_MODULE_SFF_8636_LEN         256
> #define ETH_MODULE_SFF_8436_LEN         256
> 
> The code in mlx4_en_get_module_info (with length annotation):
> 
>         switch (data[0] /* identifier */) {
>         case MLX4_MODULE_ID_QSFP:
>                 modinfo->type = ETH_MODULE_SFF_8436;
>                 modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;		// 256
>                 break;
>         case MLX4_MODULE_ID_QSFP_PLUS:
>                 if (data[1] >= 0x3) { /* revision id */
>                         modinfo->type = ETH_MODULE_SFF_8636;
>                         modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;	// 256
>                 } else {
>                         modinfo->type = ETH_MODULE_SFF_8436;
>                         modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;	// 256
>                 }
>                 break;
>         case MLX4_MODULE_ID_QSFP28:
>                 modinfo->type = ETH_MODULE_SFF_8636;
>                 modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;		// 256
>                 break;
>         case MLX4_MODULE_ID_SFP:
>                 modinfo->type = ETH_MODULE_SFF_8472;
>                 modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;		// 512
>                 break;
>         default:
>                 return -EINVAL;
>         }
> 
> So right, the function returns 512 for SFP and 256 for everything else, which explains why SFP does work but QSFP - not.

Since you already did all the work and you are able to test patches, do
you want to fix it yourself and submit or report to the mlx4 maintainer
(copied)? Fix should be similar to mlx5 commit a708fb7b1f8d ("net/mlx5e:
ethtool, Add support for EEPROM high pages query").

> 
> Following your advice, I added some debug printks to net/ethtool/eeprom.c:
> 
> @@ -33,16 +33,24 @@
>         u32 offset = request->offset;
>         u32 length = request->length;
> 
> +       printk("A: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
> +
>         if (request->page)
>                 offset = request->page * ETH_MODULE_EEPROM_PAGE_LEN + offset;
> 
> +       printk("B: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
> +
>         if (modinfo->type == ETH_MODULE_SFF_8472 &&
>             request->i2c_address == 0x51)
>                 offset += ETH_MODULE_EEPROM_PAGE_LEN * 2;
> 
> +       printk("C: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
> +
>         if (offset >= modinfo->eeprom_len)
>                 return -EINVAL;
> 
> +       printk("D: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
> +
>         eeprom->cmd = ETHTOOL_GMODULEEEPROM;
>         eeprom->len = length;
>         eeprom->offset = offset;
> 
> Here is the result:
> 
> SFP:
> A: offset=0, modinfo->eeprom_len=512
> B: offset=0, modinfo->eeprom_len=512
> C: offset=0, modinfo->eeprom_len=512
> D: offset=0, modinfo->eeprom_len=512
> A: offset=0, modinfo->eeprom_len=512
> B: offset=0, modinfo->eeprom_len=512
> C: offset=0, modinfo->eeprom_len=512
> D: offset=0, modinfo->eeprom_len=512
> 
> QSFP:
> A: offset=0, modinfo->eeprom_len=256
> B: offset=0, modinfo->eeprom_len=256
> C: offset=0, modinfo->eeprom_len=256
> D: offset=0, modinfo->eeprom_len=256
> 
> A: offset=0, modinfo->eeprom_len=256
> B: offset=0, modinfo->eeprom_len=256
> C: offset=0, modinfo->eeprom_len=256
> D: offset=0, modinfo->eeprom_len=256
> 
> A: offset=128, modinfo->eeprom_len=256
> B: offset=128, modinfo->eeprom_len=256
> C: offset=128, modinfo->eeprom_len=256
> D: offset=128, modinfo->eeprom_len=256
> 
> A: offset=128, modinfo->eeprom_len=256
> B: offset=512, modinfo->eeprom_len=256
> C: offset=512, modinfo->eeprom_len=256
> Note - no "D" as -EINVAL is returned exactly as you predicted.
> 
> BTW: there is another suspicious looking thing in this code:
>  - "u32 length = request->length;" is set early in the function
>  - length is never updated
>  - at the end, we have "eeprom->len = length"
> 
> In this case, the existence of length seems at least seems redundant, unless I missed something?

Looks like it

> 
> For the reference, the function was added in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96d971e307cc0e434f96329b42bbd98cfbca07d2
> Later https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3bb7b63813f674fb62bac321cdd897cc62de094 changed ETH_MODULE_SFF_8079 to ETH_MODULE_SFF_8472.
> 
> Thanks,
>  Krzysztof

