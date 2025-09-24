Return-Path: <netdev+bounces-226015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2894B9AD1E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC523A5EA6
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3153E30C0E7;
	Wed, 24 Sep 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mKW/+EhR"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5304A1E;
	Wed, 24 Sep 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730305; cv=fail; b=jq2lALJ7RYhDCSKPfZl9Vy31wuVtwnvHleUa3IXExyMOc+BSyypW9vnd9nxA+HvZ2Po/1WfYdUHqzVCkA+z7XrcGUpTc1/EadtbflogVouHOBYS0REYLV4KgUPAm4rEGd3FA7yGmeD+D72dQNM/NA1Us1eDUPSPwXWsk1Ha9OPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730305; c=relaxed/simple;
	bh=XpfMUWutAl9XAI6JBiVHd3cP3OXf9DDngvbJFcfUvxY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gB8t6e+vocyMIJf0reXFET5oJqOaBIRcbXIQxsRKlxWhfSCmec/iGlfNKv2bjRkWTkg2keEhfB+s3j1zTUTLK5bsQu0mmL7r6LNMRzWu+EOuN8czFolFVgI6AMxzdpn25YCj7mjafuLnHFXOymntwIRXx07oSlokhrAe9PPCY0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mKW/+EhR; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy9iNfUSlFdEIKGRocCMCVfR822lun5R4EJPdG5hRZ0L32qQTFnQS88ywONh6PTQeFCVQGhK9yFWiHh/NTwCsNeYkN6Lc7h+fChi130ZMUrQ5ayShEd09LBFu+We3uIyvJ7GA03uXMwe4BRLhgFqb4I01Yq3mHDx8SKSLNt35cEC2Imwm5xojVgHwHwc+DfcMXs91xFB2DRFgkXov+j/kByNCAT7hoJzk7GDTjYBZttFRO403ELdpe9QihUkzZNf5TV78vhb9BxMB6+FfEPI2eh6JoK2zyKKHnqN3To9ihSvHAnW6TFemTj3lSLlIIhg2sq1HRm0YkZymhKAiGeeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1ir5OipwqQB4Mol3I4eEd6vSmg1EU5UyDupT6r9/uI=;
 b=trM6DCGu3+wKsGm4gKTXHwS8yhV0lo89bhVM6JlKCv08uXGCYEehNx/vTi+CjSn6GOMwnYGXR7AkpcEL2WjXFuROtcElz4/7MWg6G7xViXuw95crFx7dMTYRLt7cziYyIBL+bJ4N5jcGSBBQ0CiI7UWuKStFowM792Uhl8KrnSMPhytYSX1kpJSYuJZdKAOHF1uTdxlfW/m8tKxqUS3PhPOwwQvG3B3wCxgxuk4qqofdgZQTPFnlu8EkBWhbumrrTq1Zat/HZo1Boa+ZyWJDdIrylOgxWEKeN2bRc22KnieDlrP7w0kLYxc6Ph+7RA20ICDQ5rrW9ikCIgBH1KJhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1ir5OipwqQB4Mol3I4eEd6vSmg1EU5UyDupT6r9/uI=;
 b=mKW/+EhR/qqoGa6qsBh/XofZVsP3hTgORc3zlCfp/Gu8EFJIOte90SYWxEtD712ScCjLXyiuh6u2gCbRtULhFNMoVragG2SDTilcfYSSabuOUt7u2gDATxrQQiKs4nqCGrx9qC0yT4i8S34fAW4h/UCoyb2fJwe42GIX2+xyjBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:11:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 16:11:37 +0000
Message-ID: <9f3678e8-8e7f-479f-a367-868f634adec8@amd.com>
Date: Wed, 24 Sep 2025 17:11:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 08/20] cx/memdev: Indicate probe deferral
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-9-alejandro.lucero-palau@amd.com>
 <c3c29108-d8a8-459b-bcc1-d33f148f6dce@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c3c29108-d8a8-459b-bcc1-d33f148f6dce@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 49be13bb-79cc-4a82-5335-08ddfb8509a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0RDWlpaN2cyV0ZYQWpqQXMwSXFoYW1uOUdYRHdBU2dxWmsxZTczVEZtQmdx?=
 =?utf-8?B?UGdBQ2FOazZTMm5iYmRFVlF0Q1BpTGNSdEQ0dE5LZEVYcndEbjRRSVFlMkpm?=
 =?utf-8?B?cW1nU2NCYzU1ZE9BN0lUdzErWlgvYWZPOXdzdWwwdno4azJCaG9uYzY4cWVh?=
 =?utf-8?B?dzkySGF2QU5BbVg4dlJxTm9VTjMxNDUwWTVpQlFnM0ZwR081azArSWx1THBZ?=
 =?utf-8?B?RUlMU20yNThmMG1LaHlWeW5tMHJWeC95SURDWWVwRGZLOW9yTlV3aE5WZ29S?=
 =?utf-8?B?dHRPL0xVT0lBNzlPZFFwamxiT0E4b2d2L0lBS2VNTVJLQS9ZNXhwR1ZUMVgy?=
 =?utf-8?B?U0I0bGZya0xiZ25CaFF5eFRaSlF2TjAzNHRiTmUwSUZEVFpCVWdYT2lMcWlL?=
 =?utf-8?B?czRSMldNemJxVzY2MlRzRGl4a3AzNXdYc2pMR1g2UGRSRDJqcFNKMkk2a1VL?=
 =?utf-8?B?N2J0SGdzRnlUbzlSRW5GQ0FLdUtKcElvdFRZUDhZYm9pc00vY2kySTZQQ0hv?=
 =?utf-8?B?OEplZ0gzLzVMbFJJNWRDenV4Tit0dUN4NDI4ZHVaS0ZqV2ZZVm5pUmI3bEpJ?=
 =?utf-8?B?L1R6dVJzZklqMzZ3Q1hXTlFVZXdieE5vQWhoenhwaHpwMUlKZXZ3Rm82U1Bu?=
 =?utf-8?B?MG1sMXFvS01TbjdoRkhmcEcxNXhKZU1pWUd2SEVPZkFnODVMTThqcnlLVXIr?=
 =?utf-8?B?T2VGNTFmVSt3UElMMmZCdmgxVVk3bytmWFRCYTZSNi84WitLK0k2aHNrTEtX?=
 =?utf-8?B?d3NyT25Zd0xUZ1c1YnpKZzVlampuWmJuOHRNNmlwcEVuSmdZdklnd3RLdzNC?=
 =?utf-8?B?VURXcmk4LzF4TWsydkhxSE1tNm5hSjhjVGNzSFZ1b3lGL3R6Y2xwcEFvNEtp?=
 =?utf-8?B?MkltQy9pR3dOZTl5c1BDNlRxcENFclVQZ3NNS3UzUGxRUnhHd1J1dE9NQ05E?=
 =?utf-8?B?UkN4TGN1dGRtVnNHRldzcGFVSTBZU29JbzIrck96RzEybHFsejVBcmJyb2Nq?=
 =?utf-8?B?Tk1qSFhwUGRJVmNqd1J4cVB1VDFpZnFoOVJjRFNBZmRqTnFmWVpTYWZxcU9i?=
 =?utf-8?B?TnhLbjFCZ2UrbDdBZnYva0JyZnhyc1FWakdjVW5lU2pXcDhIcTdoc2xadlBk?=
 =?utf-8?B?cHorUkJWckZnTkh4SS8ydWU0U0dEMkxhVTNER2JFSzU3L0VCNHorWGlRb0Mx?=
 =?utf-8?B?c1EzVko4TlpMa1MzQytrUzFPNWtXelNiMG9TRXB1WUExcGpZaVNINmwyY21y?=
 =?utf-8?B?N3BERmtKZTgzakwzTEw5Y0VVdVNOM3daSUpGS1lqKzljY2lEM1F0K015eXBR?=
 =?utf-8?B?cW1SVmw5T3ZYZ3J0eW1CT1lYUWJCSUJEeHh6bDRWdEdZdEVPbmN5KzhxTlZq?=
 =?utf-8?B?Uk5ZdTAvbFNZWEJIcXVtR1h1bC96cEx2SlZlTWJCMXNodEVUVUJzdFJzaDhW?=
 =?utf-8?B?SHgvOThyMjFOVGdhTzIwVER0VFBpbDh3ckJhNnNXWDI3ang2Q2lMR3MzNm81?=
 =?utf-8?B?T2l6TDhWdHIxOTFkUmNlR3U2TTYrZUNlM1hQZ1hDVVdJTWhjQVYwUWNrdUtk?=
 =?utf-8?B?N1pxM1lBaEkxNzVCUHd6T2RYS2R3aUFPUjVEWDRQSWNGQ3dCZ2FvTUtIUFZR?=
 =?utf-8?B?ZVlZN0Q4Y0kzdzlNdjFRdS9uRThybGFvQlNmR1lndjFOWmo2aFY4VFJZbWN6?=
 =?utf-8?B?TE5ZNXc4K3p4MzVSQlNMNGtHVGQzSDBvS2N2WFNtNGdoazlZSE0wNHFrbXor?=
 =?utf-8?B?ZU5FSFFIQ0QrQ3dkbmRrZllhckxyWGR1OFFJdmhQeVZoMlhDK2QvTEQxb1hq?=
 =?utf-8?B?ZXBYYS93YmJBL0pUU3VDU3pCL3RHUmV3S1VYS2hjNlBwQkRPbnBudXZ6NW44?=
 =?utf-8?B?dHpleXlPbXVCWkNrcjhGczFiSVNkNVVjUjM3ZkVhVnd1ZHMyT2xtVjE5ckJV?=
 =?utf-8?B?TCtCODROZHQ2OUxYbW9Vc3NJNW0rSlA2bnZBQ2xnUDZRWGNDOW1HTjA0QTl3?=
 =?utf-8?B?N0tPWFFmNEZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERKR0ZseGpEcUhVdk1KdGlFa2RGK3pRL01wLytJRHVWWmw4UDE2Zk4vZWZz?=
 =?utf-8?B?VS8rcVdoc3ZzWng0YWhub0c0bXZoVlB1Mmt6UDZ6OEY0R3A5SFFrNnk2ZmZG?=
 =?utf-8?B?dlgyN2pLYlRIbS9xNjZDN3FyWEV0OXJrSXA2NzFDQlhoaE5kWUh3SVNlKzY4?=
 =?utf-8?B?MzZ4bWJkNkpXOEo1MnRGazlnang4dTFMU2JZdFlvTU8zNUtqTW4vUHFMWDNQ?=
 =?utf-8?B?eGRtMC84eEN6QkZKQzFJUkJVY0MwTmh3T0xzY1hlR3ZXczhobEcwSjhkTVlD?=
 =?utf-8?B?NFljN1lUY2lFelI2ajVNMkYxbUdKQXlLWVRGb2J4TVhjanF6RU1UNmxKWUNX?=
 =?utf-8?B?bitpQWg5byt5MkxEeWFCZElRNXJGRjYyb3JqcXVJbHpQaHpqYWZTUzZVNmpp?=
 =?utf-8?B?K0gvWjFqdENURE5nTU5XWW5Fc1czQVhSSzkwbTE3dThHZ1VxRGFtbkhTa1Iw?=
 =?utf-8?B?QVhYWlRBejZNUGhuT0YzZVBVY2NybW83aXZGV1B0TlhDd0ZCRW41UXNWNHFQ?=
 =?utf-8?B?MVhoZ1phQXpmQjJRM0pvOGV2d0VmTy9zYy9YWGFjclUwNndrZ01lMlBwWmxh?=
 =?utf-8?B?WVc0RFR0MUg5V3llT1JoUjFKNGhiSG1nQkNyeUFoR3QvUTM4SWhwQlBCWVpx?=
 =?utf-8?B?cTkwMFpIYkdGZEM3WGdQWXY0UEExaUxqWE9JVFdSU3RmK1NBZ1Z3d3hvVWRL?=
 =?utf-8?B?ODJHbVBRc0hiaCtJRklWS0Iwa0pMNkRTelBndGdsV3RZemRJcEplWUhmQnBt?=
 =?utf-8?B?cnRYTVFNbWVQTm9HSlFxUmswTTVpUmcwdS9LZkJJeEFtclEydW5NRlBpRGg3?=
 =?utf-8?B?eUpzeXE5L0FBaXV3c3gyaUJYcEdsSHNSMU1rZUYzOVJFQ2crT1NpemFNL21i?=
 =?utf-8?B?Q01Wcm5FR1RrY3o2RFZWeVJJSnQ4U2ZjdDRXWTd0andydHVXSTR4ZkNUU2s4?=
 =?utf-8?B?M2VtZmJaaHlxcXpjanRJK05nS053eTlhMWphOTJFbWxpMjBQY1hhRyt5TXhF?=
 =?utf-8?B?RkZ5NENKdHMwcFV2STRwWTVnYkJjcjl3TXlLc2FyQXc2anoxZ1M1VmVSRlNN?=
 =?utf-8?B?clFOQzBrSFlHRndudnVIU2lObFZFaEVjV1R5QWhZazBXd0JOTXZOL1AzTlVa?=
 =?utf-8?B?bWIrRFJZeGd4S3o4bjJUaTVYYUxRcnpSSHBGUk03L2hCWmRhZDNBaktZa3Vo?=
 =?utf-8?B?TTB6eFpEczhpZ0NSY1FYUDhsd3JiYlN6a1lmSTVyU2VnNGZiMnhVT2hnMGxw?=
 =?utf-8?B?SGFUQkhoK21GaFQ3OEdMMkdxNTBJdFp0WkxJekNzRjQ3VlBreFFpWThIV09K?=
 =?utf-8?B?cEdDMjdUdS9TSEV0bFNQNHR5NGVDMFVHbFN3T0thb2N3YzF5WEtqT1F5Qjk3?=
 =?utf-8?B?RCszSlM2WDVaRVo5YlRyajVKL3owTzhjb2VYSmpCL0h0SjF1OEdQd0xOSW9Z?=
 =?utf-8?B?QmJybkk5Q3dKSlR0bVhRdXh6YUNaZTNlUWtKWFRNVFJwVFVtaXowN2VpYkQ5?=
 =?utf-8?B?aTBsVG1BRlFSRW5vVTM1UzA5d2RGZytFb2ZiUWNvdUxNNlR6RnRwRFZiZG1Z?=
 =?utf-8?B?SEZGaUxIVW51b3Y3VDdJN2IvZk5tWmNOcGxPTlJrSUdCV0dqR2ZoYVhtMWRi?=
 =?utf-8?B?UE1ROWdxNlVvVGJxR3ZDVi9HUnhGMXBSZnlFKy9YNXJoR2VzVkxucFFza2dm?=
 =?utf-8?B?YitxdkJIbTRlaGRpNkx2ZHhHcFlPd093cUd0RGxMdHZqVFBiRVdJZGtCZzlq?=
 =?utf-8?B?Yk5LcnpURnA3V3NnVEVRc0dZTEh3djJJdjdsUW9PbjZITnN3R3FWZHhwd3F4?=
 =?utf-8?B?ZUMwc3dTais3Wlo4MmVIMUhlSHRLbGNvRDFyZG1SRlA1RXErcHpZMkpuWWNB?=
 =?utf-8?B?VmFkaHJxaEU1dEpkWkVZSk5kem5tSWtaMnlnT0JFLytid0NlWXhUNG1BWGpT?=
 =?utf-8?B?Rk5HYXZveXppbUxwK2wrRThlMkVyMkRzdU5SZHNRWFR1d3dUVXo2K0F6MlBk?=
 =?utf-8?B?clR1RVVVSTBXazBMYTFHNHRVVHdaNHJ3Z2ZtejE1QVlyeUpmc0tVOVpvaTNP?=
 =?utf-8?B?ZlNZYTVkVFY2NHYxVzd5cjREcWozdjBVVWtIUi9NVTM0c05sdm5UYlVLRG9a?=
 =?utf-8?Q?q93LLeABNGDKhtORWcjZ1F3Ih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49be13bb-79cc-4a82-5335-08ddfb8509a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:11:37.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxVFmeSkVqWgtW1Ym2BCTsCRELqIzH5DkpqOrcqPaCghF0W0ukGMqmykUWLsbXtObwbzl7bM3vn322acrkcmRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726


On 9/19/25 18:53, Dave Jiang wrote:
>
> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first step for a CXL accelerator driver that wants to establish new
>> CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>> topology up to the root.
>>
>> If the port driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead defer
>> probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when a
>> accelerator driver probing should be deferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
> So the -EPROBE_DEFER actually goes to the caller (accelerator driver) in this instance right? In the situation where the CXL resources never show up, does this particular accelerator driver never completes probe successfully or does it just punt CXL and completes probe without CXL support? This question is just for my understanding.


As I said in previous version, I kept this as a protection against cxl 
modules removal while initialization. I think after Dan's patches the 
problem is now reduced to cxl_acpi, so I am tempted to remove this from 
next v19 which I want to send asap including those Dan patches.


In any case, the original goal is not there anymore, or maybe it is but 
it requires to describe it properly. I did cover all this problematic 
with in the cover letter.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/port.c   |  2 +-
>>   drivers/cxl/mem.c         |  7 +++++--
>>   include/cxl/cxl.h         |  2 ++
>>   4 files changed, 50 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 3228287bf3f0..10d21996598a 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1164,6 +1164,48 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver.
>> + */
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	int rc = -ENXIO;
>> +
>> +	device_lock(&cxlmd->dev);
>> +
>> +	endpoint = cxlmd->endpoint;
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>> +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");
> We may want to annotate the locking to help out lockdep debug
>
> static struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>          __acquires(&cxlmd->dev.mutex)
>          __acquires(&cxlmd->endpoint->dev.mutex)
> {
> 	...
> }
>
> static void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>          __releases(&endpoint->dev.mutex)
>          __releases(&cxlmd->dev.mutex)
> {
> 	...
> }
>
> DJ
>
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 240c3c5bcdc8..4c3fecd4c8ea 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1557,7 +1557,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>   		 */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	struct cxl_port *parent_port __free(put_cxl_port) =
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 9ffee09fcb50..f103e2003add 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -122,14 +122,17 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	struct cxl_port *parent_port __free(put_cxl_port) =
>>   		cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>>   		dev_err(dev, "CXL port topology not found\n");
>> -		return -ENXIO;
>> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 401a59185608..64946e698f5f 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -251,4 +251,6 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_ops *ops);
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>   #endif /* __CXL_CXL_H__ */

