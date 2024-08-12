Return-Path: <netdev+bounces-117676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5F94EBE2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436E41C213BD
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2846175D2B;
	Mon, 12 Aug 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FqiTfTG2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60616FF45;
	Mon, 12 Aug 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462522; cv=fail; b=l8CnJuGeuDO7/CpqmImEvYw+nHapILd/GEPwA4yOhtqJ8TH1048/uX6L3Gr/aUydz9HZrMOXzGFlLDSnlNOB5qwZycYzfcU8F7Q+pR94JZt+D7ToLNHhm8+kUXM3svZAytJ2b+fMRatYv2Yiw8ZhCZ5wdfxMv7uGw5YZUmHhtXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462522; c=relaxed/simple;
	bh=HVDhb4cVB8eJOFVSheUM65H/GXnCSGJ0NHx2KudNfpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZ1+bV7mwvKecQ0V3O7dNrOSszZZdOp7H1rJL4fbpYiRZglu3u2wCifwd4+wlxZBlLtPo8XR1iTXYZ3e+rbUVF3brx7U/HS3U283a+5h9XdTi4gFqZE8sO/HRDbxpM3P59VDSzqr+b0+moQnDnHzXEdnHfykLyMQAX5WRdU3Qcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FqiTfTG2; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFbCYGUhjw7PP4ArCz1K8eEhoo8zcWvtWdoCJ1vu+UdWa4HK5KB61WJoG1qPP+BB0vEEr3uoyYPx4XbDfcakHllY+socX/uyrsXZBeUhZaxOPrwhznsDUwpCohW9MY9WG7ZQl5BLs/Y3pdmt5TskLaPQWIL2WcUd6el1lVao9+Fsky6xiKnvFUQ1dt2XNlmv1RkU7b9JNzJwSMJKXzUYz8v7PZeKCbSBksnkdGd0aSYkjhH2QEHSRs4UMF0Fg/u/mW0qg8HYGaq/Pmfl2snHcPG9cjwvOG6tstajUPizqe7cuaYRq6l4GdNpg2VEM3vfGGXG1pj2MiaZ/ZDQaax1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai6aHEh3basw1YzmGMWEt/UHrrKdmhbzoLied5U5q3A=;
 b=Fna01iGxj2dVNCClZ98ks79jICGs1Dfy1bUKbd2TzYcrwGpN8x6S5FnEi3elAz4SJS5D69LY/CE9yhzR+slq+R3OF9D4Jn4FLcrNF23etZXETQ1+pZoA4VOXeK7XymOvgYmpc6xf3ijeL4xo5CZws4Lkxicoi1gWDCpDgEcsYM1lIdTbzf9uTvxG+VzkChIKXOrB/IRESA/yMpW44vDB04ty4FjRvIhdTyh87Tp++D5YiqswSfA/eZuSuCBx5GuFzl2KRbz92Vu4pl0Do8IL6VQN/+wNKZmBFcTCBLmsDNgS8fHANMPd2tAsx4F+UAjNtp9qd3lgWMUwmrrAg1An8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai6aHEh3basw1YzmGMWEt/UHrrKdmhbzoLied5U5q3A=;
 b=FqiTfTG2kV0Uv1fhtq+bNFWWKKGFwV08E0wjVq4YML++06MxSEnzdVDqGg4hhzfJiDXd893G4QHYEwuv1EUX5xXhrdxdTlZeESiY2J5ElGgQ9ULt6Vu6xoHto8nzWoct8NDasO3vGtueBxuOwpljiG3VoTq+85+xd9zVMP7GZ9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 11:35:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:35:17 +0000
Message-ID: <8498f6bd-7ad0-5f24-826c-50956f4d9769@amd.com>
Date: Mon, 12 Aug 2024 12:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240809113428.00003f58.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240809113428.00003f58.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0245.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 98de69d1-413d-48d0-0ae6-08dcbac2d6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NitDMENYYittU2hib1hpWTlkZHBuQ0tHOEsxbElCay83dDlTMjRwRjI3TWsx?=
 =?utf-8?B?L0pPR3hVV21DQkxSeFZhTWFsSkdyNmJGSE8yakV4YXBPTG9McXNZd1U0TUdO?=
 =?utf-8?B?V3hGTlNMeWo0amZva1RQSDV3TURvQkFVcmdaalhOV01rWXRWQTJvMU9kdHBS?=
 =?utf-8?B?SUxiWW9YV21FSkZwMlJxMXdvT3hMeUtITGpvSXlaWjdtcEZjS2xHdzA2Vll2?=
 =?utf-8?B?UGdPZ0xqN2Zpc3NpYXl1ZXdISGFvRUlCRWc3bEcvNERObGc3YjFqcFpzU1c3?=
 =?utf-8?B?MEp4RDgzRVA4RVlPOW9NRFY3YURnSmtzd0cxa3lFc2JIMnpNQ204NCttYm1M?=
 =?utf-8?B?MmFKa3ZpT0N3NWdjSHEwZGtROHkvWFBMamp0M3lQdEE2M1oyQldQUFNTdnlp?=
 =?utf-8?B?ZGprYTllTy8wSHl6ODEySFdUWXVqdjVjR013cUsxQTMxRHVYMWxEUUJ5M0xS?=
 =?utf-8?B?ZGNrMSt6N25HRWlwM2c2YVo4RkhCaU96cWd3bkRsTmYra0xyakpSU0NGWnUz?=
 =?utf-8?B?di9sUXdzdzhDNUdUSGppZSt4bnZiZEhuUThWay96WmtlVWdGUFp1TG8reFpz?=
 =?utf-8?B?ZXBTNHRWbnR0OWdHM1dmd1d2Ukl2akp0TzBxaW03aW9BdmVsUVBUWDNYNlNW?=
 =?utf-8?B?SjJSdmpsS1VxWjR1Q01SY3JrcGZ0RDFFajMwb1ZwOGJDdndPRzNEbXkvalB4?=
 =?utf-8?B?dEI4RDdHZFdhcnZjbm9sYVY0ejVFd1lvaUZMWTJ6VlduWXNyRjg2SGx2ZWF3?=
 =?utf-8?B?MFFYZ0ozOVBCMGRKS04zUU9vTFZRMStYV1pseHdEMFBCVS9PMEM3Vm8rTHAw?=
 =?utf-8?B?N1ltY1lueTNrbmFxOXpkVzVtd25qZ3p1U1J1UUd1TkgxZHNuSW13a211SHhO?=
 =?utf-8?B?elpJMVp1eWtRb2FpQXA4WTJ0L1l4UFVkVFJ6dW1oRUdxSVJKTmh1SFh4MUo4?=
 =?utf-8?B?UEFseHZTUFp4bjhsTHlvbS91R2J5cnU2WldTeGUrU3FzSEM2YjNzMDhPLzV2?=
 =?utf-8?B?QzJBTzl5cHpPeFpDUC9ZR1lLZWsyQnBjWi95cSt3dXVxWnJjSElqREF4alAx?=
 =?utf-8?B?UzJQbUhZa1VRNVk4VEtwa2NIOHdpQS9ycW56SVQzZURCWVBOR0F2bzY3LzZo?=
 =?utf-8?B?bTJuSUxxN0hncVVWMVV1Y2ZLdkJtdkpDaW9FZnUyOXVyaEI3K3dOZ2hzRWZR?=
 =?utf-8?B?dFBPMDNjMkowSTBnR0hUd2ZqelNHVjRpVmtjaTZrcmdPM1dFMjJHMlU4V1RQ?=
 =?utf-8?B?encvajd4SDY1OUNsUFIxU2FRSVNmQkUvYkdLSEJJaXlQdXlJQ3FRV3E0cUZn?=
 =?utf-8?B?SFRUY3ZhbGVGQWt3V1Q2SlNnc0pqVGtCa3g1VURpOHYyOGw0ZlYxTG9yWWR6?=
 =?utf-8?B?bzVvVE95QjZCVEM1Tk1scFdKWmVUcTBnR3JudzlDOTlVWDlJYSt4NTg1OTM1?=
 =?utf-8?B?aldPTENLZHF0akhpdVZvb24yVUxYZ201dWFaZnpEM2VMU2h6TThGWnp6bXRL?=
 =?utf-8?B?UkpaTEU0NU9kUmdKMFNId2xiNlljRXVTNkJWbWFKRzZlamFFbHZUODVGWk1m?=
 =?utf-8?B?MHJiNFZ3NFZqVTFLSVRnRFNPbzk1R0tOZlpqaDZMMXgzb3B0MEs5WHo0NElV?=
 =?utf-8?B?SXF0MXZsbFdrUFhuNEtsaExiYTRlWCsvZGxWTXFpdG5zeFBIQUllaFJ5a3h3?=
 =?utf-8?B?b2p1THAwWVQ0MTFETUxUVGJmOW5PRXBmSUxDb0QzVGkzWHNHbUlQRnptejhK?=
 =?utf-8?Q?thPlw7ldYEP65lAnyuHu2QAgtRNV5NQ0A4BxdWu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3k4QzkrcUVOaXNIdU5PWk4rYW5TdnZrdDcvaWR4T2F1NkkwT3NZRnUxdmhJ?=
 =?utf-8?B?MUtzaFFZZTBpb1dtMVViWVM1M2xpQ1ZNK040dTVkbHdhb3VZUXhBNE1RbWNr?=
 =?utf-8?B?TDJjWWRXVjFNdjlVanpYNTgwTEVDYUE5SWI0M1BhVGxmMnRrQjdKa2k0Lzhq?=
 =?utf-8?B?Qjd6c1VyZXM3Y2cxOEdiY2I5UXdkNVZPaDFKOTFQUitWZ0pxQU85ajlpYWoy?=
 =?utf-8?B?QnRkd2ZPZkpHKzhMbU0wMnF1MGpqanE0Q0pjSFBFU2o0a0pPQm1QcXRZVmJV?=
 =?utf-8?B?dkNlRE1ONkxqY3JPYTJVelNIWUVKVFRxSk5UdVlaR1dZWTNIaDR4Y3h4dUs5?=
 =?utf-8?B?dHZOc1A4K3Bkc0Q4dlRwSmFQS2o2MklTU0ZLRmZMYk54MUlLa1RjbUVZb0Qv?=
 =?utf-8?B?M0diOEFSSkF6UUJad05PK1dBRzlkeG5sUmc3M2VTSDVqdmpGcXNiSjQ1Z0dB?=
 =?utf-8?B?YXkvSnJRbjFKNis5TTBTU0s3TFYxUWY4b3RFZnJ2MnFoUWhGVmtBN0NCMU81?=
 =?utf-8?B?UFBnVE52ZitSM1hmSjZVUVptbEp3eGJyOG0ydVJsanpqZ0RrY0thMytMRkYz?=
 =?utf-8?B?cW1XUUFJUEZ5YzUzbWdvWGkvTU5pUnBVZGdKYUxibDZaYkYvNitaemoya1hN?=
 =?utf-8?B?SmpPN1Jqa1g4bXlXcjZwRk0wU3pwSFZvR1MxS1pWMVZ2b3ZQdzlHY2ZhcjVZ?=
 =?utf-8?B?d1RPOW1mS3dJNTVaWlBQNFdQaW1QYTEySVVRejMxWWlJL0ZCbVY2eDBjRmFB?=
 =?utf-8?B?UXJMbk5JbUlKK28zNHNyblNTdmUyQkVnY3dBaStTSnZDWCtJT1lDY1V6VTM2?=
 =?utf-8?B?aWplRWZ1a0lhUk5kd3o2Ymc1L0VBcHJ5dEJ3WGxISzVMR0lFTUcrUlZOR1FD?=
 =?utf-8?B?NlRkMkNlS3dGMUc5akNNcjgxMGozamlOLzVUSm5CNnhUV0pyalRBMXVYU01Z?=
 =?utf-8?B?NnM0S3FGY1BpS2VNaEFPQXk1N1V5djB3RW5SOWJhWS9Pck9NdnVYMGM2ZVN6?=
 =?utf-8?B?eG5ieUEwMTJydzMyMGJQc2tSMklsTkM0aFM0N2dHVXd3TWlTalVoNE1rdlJM?=
 =?utf-8?B?QXB4YlljbjBaSzZvTXRwc2djbWMyR1F4RjMxRW9QY1MwS0xBZ2ovTjU4b2F2?=
 =?utf-8?B?RytNQW05aEMvdmJCa3g2bytCNnJDVGwyU3lhR2YxVGFBTy9zanNZUnh5RG15?=
 =?utf-8?B?dEtJRU0xWTFPM1VGUTd5NUF0ay82c2M1QWhLOFE2c0xiR3VKb294VDlMSmkr?=
 =?utf-8?B?eEZuWmVaOVNiY1hGNWZjUmFOWWk1dzhkUGRGZ2J1RlZCVnZsSnArRlZDY3Iw?=
 =?utf-8?B?cDRSVzZEeXJlQk5BNjd3SVMvU2JNUSs3YU9IbGY2YUlZSUF5Z01Bby9ZZ2RM?=
 =?utf-8?B?RU95QlhiRzlzSjhoMTA4amJqY3VZemplclNidzExRmpjRGxQUkI5d2RjNzBX?=
 =?utf-8?B?NkxVZlhpM3BuSDFZekZyMmNyUkZQVWpsWVMwWFY3dkxKRkJxTlpPNElsOXg0?=
 =?utf-8?B?MHg4UGhOS1ptUUZTb3NiUDlGL1FZSkhlTFJTaDJ5YVFwU3N1Q0w3Kzg4bFZm?=
 =?utf-8?B?V0oxN3d0TE9lLzcxTVRWVXhFb2hnRUhsUjVpd1Y3WVVTQmsxMnJiU1dVcFh4?=
 =?utf-8?B?N2tWT1FldnQzNlZ0RkNiWi9kSVBqekpvTjJ3ZXhKalhsMnZiR05Sd2pQWkUy?=
 =?utf-8?B?ZDNEQTNjdVREbEFmdDdqQjFxRVlYMWZTOHZ2MmNiYUQ2YWpTeE1GSWxySVNy?=
 =?utf-8?B?b2ozWDRIWGE2M2o0ck5IRm1SajhQcVlwbld2ZWlBQkFtN2k4MzRxVUlUSExQ?=
 =?utf-8?B?ZndVeVBGK3FFZGxYQ1J5MG9UL1hHY3FLcnZXQmVUbHgzY3dSMTJjbFVPMGRn?=
 =?utf-8?B?dFZqaS9HY3hGRTUycHNhRmJoRGd3NGJhR3Zqa2ZGWmgrTGUydW1TeW9Vcy9N?=
 =?utf-8?B?djB6VlllNVkyZ1pEc0UyRTFGRk9VSjZ3S2dIall4WjZQejIvdTJVYlErUTNE?=
 =?utf-8?B?bnpsQXV3UWN0NkthNWtxcFMwN1k3Vng3Q1hhT0o1K3hEVDJRNVVsWXUwWVc5?=
 =?utf-8?B?OXRIZ2hVRWU0OUpyUzVnd2lSWENzVktwei9Dd3Y5Z0cvb2lKOStaazFVaTR4?=
 =?utf-8?Q?1g8leHxw9AHVKbpOutsifcMWn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98de69d1-413d-48d0-0ae6-08dcbac2d6ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:35:17.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbOJctqn2FJ88UabnMMGo98rvf7j7vBobKFaC5umbQrSvBE6/eMafoolChP+7bdslAyq7TY2ukpEsbfrCAe2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652


On 8/9/24 09:34, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:21 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create opaque struct to be used by accelerators relying on new access
>> functions in following patches.
>>
>> Add SFC ethernet network driver as the client.
>>
>> Based on
>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c             | 52 ++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/Makefile     |  2 +-
>>   drivers/net/ethernet/sfc/efx.c        |  4 ++
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 53
>> +++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.h    |
>> 29 +++++++++++++++ drivers/net/ethernet/sfc/net_driver.h |  4 ++
>>   include/linux/cxl_accel_mem.h         | 22 +++++++++++
>>   include/linux/cxl_accel_pci.h         | 23 ++++++++++++
>>   8 files changed, 188 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>   create mode 100644 include/linux/cxl_accel_mem.h
>>   create mode 100644 include/linux/cxl_accel_pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0277726afd04..61b5d35b49e7 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>>   #include <cxlmem.h>
>> +#include <linux/cxl_accel_mem.h>
> Let's keep the header inclusion in an alphabetical order. The same in
> efx_cxl.c


The headers seem to follow a reverse Christmas tree order here rather 
than an alphabetical one.

Should I rearrange them all?


>>   #include "trace.h"
>>   #include "core.h"
>>   
>> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct
>> *work)
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state
>> *cxlds, const struct file_operations *fops)
>>   {
>> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode,
>> struct file *file) return 0;
>>   }
>>
>> +
>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
>> +
>> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial= serial;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
>> +
> It would be nice to explain about how the cxl core is using these in
> the patch comments, as we just saw the stuff got promoted into the core.


As far as I can see, it is for info/debugging purposes. I will add such 
explanation in next version.


>
>> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct
>> resource res,
>> +			    enum accel_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return;
>> +	case CXL_ACCEL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return;
>> +	default:
>> +		dev_err(cxlds->dev, "unkown resource type (%u)\n",
>> type);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>> +
> I wonder in which situation this error can be triggered.
> One can be a newer out-of-tree type-2 driver tries to work on an older
> kernel. Other situations should be the coding problem of an in-tree
> driver.


I guess that would point to an extension not updating this function.


> I prefer to WARN_ONCE() here.


I agree after your previous concern.


>
>>   
>> diff --git a/include/linux/cxl_accel_mem.h
>> b/include/linux/cxl_accel_mem.h new file mode 100644
>> index 000000000000..daf46d41f59c
>> --- /dev/null
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#include <linux/cdev.h>
>> +
>> +#ifndef __CXL_ACCEL_MEM_H
>> +#define __CXL_ACCEL_MEM_H
>> +
>> +enum accel_resource{
>> +	CXL_ACCEL_RES_DPA,
>> +	CXL_ACCEL_RES_RAM,
>> +	CXL_ACCEL_RES_PMEM,
>> +};
>> +
>> +typedef struct cxl_dev_state cxl_accel_state;
> The case of using typedef in kernel coding is very rare (quite many
> of them are still there due to history reason, you can also spot that
> there is only one typedef in driver/cxl). Be sure to double check the
> coding style bible [1] when deciding to use one. :)
>
> [1] https://www.kernel.org/doc/html/v4.14/process/coding-style.html


Right.

I think there is an agreement now in not using typedef but struct 
cxl_dev_state so problem solved.


Thanks!



