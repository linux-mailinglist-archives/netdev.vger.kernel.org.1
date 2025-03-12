Return-Path: <netdev+bounces-174108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89287A5D832
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF75188A308
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470722DFB5;
	Wed, 12 Mar 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D/zZNvCA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB62F44;
	Wed, 12 Mar 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768142; cv=fail; b=SDgde1AkOth8QXmcy9xuunia/OfPW9Ps8SigFwPCazXVZtLPdDNxqSPKa01Q8jRJ1mjuEwy1p0I38n9Sho/B0krydpvvysXEssH/ThZfe+mwkrnuu5WPE0tXHU1HVuSIWR1JO+wpuCIlEAWJIqif543n3sSbTQmTbr0yt1s181w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768142; c=relaxed/simple;
	bh=nq3KwEKu1FB0WM1FYTg0SaYntqTAY3tmdDn4ksSZhto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tOJzcFPYqtO7mTgm2tsCsdAqTV8Z3iQXhje2GuIjTlkKL2Xl632M+tXIe0/vYjKwjedTHuu3w0fHkHlUDFuJz1V5DJ5m842xdsP7yHB9hs/n6ky2iHiexgfnV7DAMcDG4WdRd43IoyB04PPQzm0V19xXp3+z7/niF9mFBkN4p/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D/zZNvCA; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVi8Tn4riQ3InPqquWR5WJl+tuP9xoi6hCvEwurY3CxYmluLV8rXljLzCQBN8SdO5B3q4lfr7ZN7imu9ReUY98T/kKgbn/QiFzzczWgyYZ2Ofk+P+8m4OBXgZP2K+jIniTfMHvfAsmKq9FMOGc6x3t2EsWmwtEzg04GviJMQCk+44Hf7pWw0jp6yLh0AshmTl/BPcEzdHCqSMBySngDQi/d3kKEEdys+vMG8bAXm66o/9DumM7r353bmPqDhw7DcKauGtF7c0/2P5zOev411edOjNZDT0Xeuenn996KTmTO0QeDWoMs7nCfvP77IGYIkXtJNVzC+q9+2WsbsF35tHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve2x6/SMdIgVLrGBq/2zDezG/3WQbELWq62sfH2I0zs=;
 b=akD2aMlE3lwleb+O17mYgUVx/OIHPrm9MybTWopvScSf6vtTWPC3TxLMfpAbhVMy/1bLN3vxTF8j+fmBYGySSnwYjPcFO8DecjFZo92iddE84xsGHfcfqGVIeIW2om3JNYv2OMOzW2KWuAtln5l0n0nfGlboIaa6NEk30w61SSSDqMaE1RabzdVkjCrQIRYscj3fXc31PewBxmSKdfQ3p8D8qQ60kIaX9xuCJ+3rf353dWsqaI/CKv/8pDoPw6uKucrh5BpdWBHenqJfUeowCZ0UaNeGk/ByDCA3ti/J5wAbltAvJTZ+9+7eUS7JNgb1V5sWLdsqC8ajk4kkF/aDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve2x6/SMdIgVLrGBq/2zDezG/3WQbELWq62sfH2I0zs=;
 b=D/zZNvCAvfovXLZDvA2NGcAzf7Ragm9QU4ivmvWQ2G3/LdlxW8q/4vReLc5qVKRQ1AKaflACmR3hiwLP0xcgbnevAyv60Ebgw1lKwbIr/EgVYAF3VC7KDvx5adj/eJIghZsUQFfgMPmXH14aFqaMGB3TTErYPjgnWSkCxU5ILKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:28:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:28:58 +0000
Message-ID: <311bcb0d-0ba2-46d0-acc3-87c119cd9e54@amd.com>
Date: Wed, 12 Mar 2025 08:28:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/23] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-19-alejandro.lucero-palau@amd.com>
 <c5067d20-1804-4c14-b0cc-3e27b119f67a@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c5067d20-1804-4c14-b0cc-3e27b119f67a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: aaed5a0b-7a0e-4a32-d5ef-08dd613fef5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0lWU0dxYjdZK2loMW1TTHVNQmtBREM1YWl5YmR4Z3YrYnhEWDNqMENHa1Jm?=
 =?utf-8?B?aUhjZ29jK2UvVG9VQ28vTVlHTm5ZakoyeHZjazlEVUJBRHhkcGRDSGk4V0FK?=
 =?utf-8?B?T1Y4aGgyM210VFJ3N0dWeWh4elBnYkRrRnhjRTI4NGNGK0VwUzA2VEZXa0dT?=
 =?utf-8?B?NVQyTXlSN09INkEvYXhia2FjZGhvcCtnWmRZOXN6ZmE2MHM5d0NqZ0hTNGho?=
 =?utf-8?B?QjNYejRHcWlHNVEwcnhjb3hkR3JxWEZobjFmZWwxTEVWc1BhTkpxcVZ4L0pk?=
 =?utf-8?B?SWlkK0xqM1lqYjdSNklwb09ST2NsSHVPREozRisyWXluOG95UFpUTU1GZzNs?=
 =?utf-8?B?OFpNQ3kzSkRFcFhwOFNjNC9uazRDU1lZcTdxSjY5ZWp1UldQVURjS0hGcTM2?=
 =?utf-8?B?QXpPVlZBZ2lWWWxJNVlucTZjdW9RUTN1YW80WENBNFp1RHdwNVNXbmdVcVAw?=
 =?utf-8?B?d3FKS2xnaVF3dDdjdytPaDE4WEVLWktYZWtQYWRGSHljbVc5dTgveFYyU1l3?=
 =?utf-8?B?WXd2Tk56ZGI5cG5JbGpyaVRzWnpYb2J3U2FaN0tqMG1YUlY2UHpRMFNGeXhF?=
 =?utf-8?B?VUN5R0l0NU9VekJjaW1iUW03SFZVMld2MXpLcEpERkJjai9WMlNzeVZ6QUxJ?=
 =?utf-8?B?NTRKcnkyQnJCQ0Q3OUY4RXBVck9YTG9BQXZIWHd5VDZySDJTblNlWE1XTHFQ?=
 =?utf-8?B?d1doeUdwc0dncXQ3TlZBZ0JPanQ2QVZGRVlQZlVhSXNFb2FSZEUwQndmZ3Vr?=
 =?utf-8?B?eG5XeXk1M29TeFlZM2x1dXkrejVWVUF1cDZPdlA2V21zQWVoUHJRRFZXOEpU?=
 =?utf-8?B?TElodUJyZlNXb3lFRm54TlRLeERpYktXbHVPQk9xNmZKZldFZ3lCZ0pneG11?=
 =?utf-8?B?U1UzN1IyMkZxdnN3eTVCOWtmSnZ2WDBuTXZuNnVlbGRBRXUvN3FtbnBWVHlZ?=
 =?utf-8?B?YTQvQXcza3NxM1laOEJyY1g0aXBQRG5OZjFKL3MwdTlDTXRCSGttTlBhNUJP?=
 =?utf-8?B?dDFMRzQzejdmV29naGhqRWJVSWlhTmFpN3J2T0VBV0NlalNRRW0xVlJjWExO?=
 =?utf-8?B?TUxNZFd5YU1qUW40aFJYNHdzMjhZL1VNNUpublFKMlBsOEpRTEE3dGtITUc3?=
 =?utf-8?B?Y1dNdWttVEZzV1g5Znh5c3hHSFllb0t5cm96UkNsaU5ReEpXUThYK2pMcTZI?=
 =?utf-8?B?Q3hJM2RxbU5kUThhZmJwbVp5NzBqNiswemZsd3dLZzEvRXlnaUxUbHdkMjlO?=
 =?utf-8?B?MS9ySWxrQ05BZnA1N2p4UG9KNjhSc1ZqUjVGYXFlMjJCb0ZmL1dwbVVxemRD?=
 =?utf-8?B?WHZOR0UzS3ZWbnlsTEF0a0laQ0pyMlVSd3I4VVNiWWQ5aWpoQnpqQnhqRnRm?=
 =?utf-8?B?T3lOOTcwZy9MbEhxQUhUUnljZG1XbGtraWk3VStxR1U0ZCtJMXVFTU9XdnN1?=
 =?utf-8?B?WExVZHQ1WmxZbU1OTENzUnY0Q1V5MmVRbDBDZmpNU3N1aWtEc1dIZWM4RGJW?=
 =?utf-8?B?eWx6VUJnWVloM1FiTWhoTWFUb1B6ajNwdlUvYzdxc3I2TnpCUmFITWxMVWR4?=
 =?utf-8?B?NmVocmpnTUh1N1l0b3BSWlJnQ3Q5MGE2WXlHcEFyaHBqL2h0dnhBUGZBZDZi?=
 =?utf-8?B?bzdmOTAyZFc3YlpNMEtVMnpocUJkWmN5cDdBRFAwdUNOclJGdnVTMHRoeEFa?=
 =?utf-8?B?WWVTVFU1RnZUMVVMOXZHSjJPZ1VKQnFIOXoxQ29DYkF2eTVGTytKLzUvN2Jl?=
 =?utf-8?B?MEpkM2d3bjRZcE5VeUhPbm51clFxTXZHamdhUllGY0cyVmlUTk9NcVpwNkNm?=
 =?utf-8?B?QXQ5eTlaU3BBbGRLNkp0STdtT1B1MmsvZ1dURWk3V3Y0ZUxsT2ZhbHdLMTFQ?=
 =?utf-8?Q?vNwqsGM+NeGvs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enVDS3RndjV5d1JWQk9GUktaYUtPRVBrMVEyRnh0SmlDbVJvdWxuT0xxOHhy?=
 =?utf-8?B?WmVVQ2JwUlQrSTNydXpmeHh2bUJwVjM3RXc3a3VTYk84VmI4SkdqdUtwc1RP?=
 =?utf-8?B?aTBJTktxNzU1REUvMXNlSXdmdENiTHZKWWluZWRoR0RpOUZ3bGhUblZ1Mmx4?=
 =?utf-8?B?SHhyalJlYk5ucmFOUVZ1MnMwVE0weStTOVdVc2I5RVAyUkRwam5ndTFPSVVs?=
 =?utf-8?B?amVMUkFLdVZoelVEZ3R4N1lpUElLWnlldnoyWDNjMnl5ZnQ2Uk5Eenp5MnhK?=
 =?utf-8?B?dm5ZcjZJanZGQUZRNldTd1hLdUZMWkIwUFFGb3Z0Yll3RWtubG5DRlQxb2Jp?=
 =?utf-8?B?NWE1NUxJRU56Z0hxb0ZjNHZEYTJzc0ZrL0xQeDdHR1JRMnBBRlcxWURpYklC?=
 =?utf-8?B?RGpYRlFYL1YxSmxObFZBNE9NREZOZklzZWkydDZPRzdKd3lJSkpkNGZnT09G?=
 =?utf-8?B?elp5eXBSOS9nUmNvWVJrWHY0bGVNTTRnYml6QWNzTFlucXpuRGFMeXg1SEF2?=
 =?utf-8?B?OXBvUXVKNmRLQUp6MmtpT1UzR0lyaDRheXZlNi9LNG84M0xFYkcyempCbDlY?=
 =?utf-8?B?SXV5Z3Y2R24xUDh4RTdtRVNpUHFFWmlrSmJVLy9mUE9tZTg3TGM0RmdRZHNW?=
 =?utf-8?B?S3hrbmQvUWhreExJQXh2UW0zWndyMWFnTnltOHFOQ0J3WUVOVGREczVsT3pH?=
 =?utf-8?B?RVZIOGVqbW1ZaUl2V2ZQZU1EY3VoNXYxdlZsRzEySkVaT2tFUFNlU3ovVmIx?=
 =?utf-8?B?YXN0YW5hQkZIbVBXSGhaNWQ4TS9tYXluYlg1UEhGME9XVERGMHc4aHJlM1BF?=
 =?utf-8?B?MU93UTNLSjA2NVdDTC9FYVNWYWpmRzFiajZTUGNlWEQ4bXpQbURsWHRUbnVj?=
 =?utf-8?B?U2xaM2Z5ZHNBSFhDQzBLZVpSOEZBSVQrMHRMY0p5SGxvaUpKbXdPTmgrcXI3?=
 =?utf-8?B?dS9FM0ZCMFVxWVd2MlEwSWVSNVpTOEJzYnNoTmFVN2dxbmVMNGxhNUdUMDBK?=
 =?utf-8?B?ci9EdkhVU2VaSUkzNmRBdFBoNFZLTnFTL3R0THRoWk9tSkpmeWZ1V0ZQSXZS?=
 =?utf-8?B?blFJcmhlZ2czMkVtVCsvS2szU0xueG51ZHAzTmxHdVNhd2tXb1BUMXJwMGhN?=
 =?utf-8?B?WGh1NS81WGVORGpmT1FMcC8xendTY1pKdlRiNHNGT0hIN04zUGJvcnBLTXFz?=
 =?utf-8?B?dTY4c2NIWk1nK05ZNnNUM1VWZTRwZWZqYkcxNkRudkFQNXVFVm1tczJvaEpG?=
 =?utf-8?B?eUM4LzEyRzdpY1BRMGdudDJXZXhKc1A0anZUSEUwTkNOWk0xaWh6aTAvTlhX?=
 =?utf-8?B?K2NBMVdyZFYxVXpTZ0QyQXdDVWJ3QngyTHRtOVlLYkV1UUs1Q0V5NmVjREdw?=
 =?utf-8?B?YlZDbUN3QTk2K01Gb3VNeWNwWjNrbGlSUDR2RVd2dXRUQitNdFY1SXE3YWtK?=
 =?utf-8?B?TWREVW1UajZWWUxnZnJJdEhEdWlVaXNyWm1adGJPWXhTWUVKNUI0VlRiM2k0?=
 =?utf-8?B?NFBYbER3NVIyTml6aXNvL1RIUkhhWUZlam1uSGg1eGNRemJlaWZGWXNnN3hl?=
 =?utf-8?B?Wi9JYmdmdHFoYXEvNlhjSGVuQk5RTjhVUFhiRXoybERDMithNmoxNDE0bFNt?=
 =?utf-8?B?cHZFbW13Wm1yTEtCTTR4TXp2bXBzZW5HYytKQk5SVUZuQnd0S0Q5SVg3L3Fo?=
 =?utf-8?B?MTIxSHBNQ2Z0UXY4ckhEN1pucHFmT1YxUEE4eFdpanpHVlplbnNhbVZDUjZ1?=
 =?utf-8?B?bGN3K3k0U1cvTE1Ia0phcWQ4VUUvMFAxclZHVHNzRXlDL2tzb2tvbjBOT1F6?=
 =?utf-8?B?YWhqVWFCZVVJK1JuNVhYRXBKNDNiMzdodmdHc3F6T1liQUZJRFE1TUI3RmNJ?=
 =?utf-8?B?aHZzd3h5eTVUeGdvTnd0K1JqaVdTWWtqcURPYVZLcUs4cCtaSzBEZTlDaitC?=
 =?utf-8?B?WGFLVThHSnNGWjNCc0VkSjBObkhwQ0U5WGZLQk9qbEovOTdNNUx3K0RQaGd6?=
 =?utf-8?B?djVDanJIUEozYUp0a2VRWlBHeWcwV0s3VHdtVi9OdUppWjhkRU9DZFBGWnY3?=
 =?utf-8?B?M0NXamV1WkxockEyTmNadE1tSTVaUGJObEdxZFB0Tkd3N2tYSXZnOXkySTd0?=
 =?utf-8?Q?Idzb5dUuUBHkXbyvC9eIrEgEc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaed5a0b-7a0e-4a32-d5ef-08dd613fef5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:28:58.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCdYeRoPovCSD9RETM/lQamoW9ZQwO53qT8jDszZ5k+p8xcKg7UIzD2Xhj6o4n+BDtqhjJwWqv9+53rURhbc0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663


On 3/11/25 20:06, Ben Cheatham wrote:
> On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 133 +++++++++++++++++++++++++++++++++++---
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |   4 ++
>>   3 files changed, 133 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e24666a419cd..e6fbe00d0623 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   	return rc;
>>   }
>>   
>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	int rc;
>> +
>> +	guard(rwsem_write)(&cxl_region_rwsem);
>> +	cxled->part = -1;
>> +	rc = cxl_region_detach(cxled);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
>> +
>>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	down_write(&cxl_region_rwsem);
>> @@ -2816,6 +2827,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>   	return to_cxl_region(region_dev);
>>   }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +}
>> +
> Nit: There are a couple of spots in this file that call the above devm_release_action,
> I think it would be good to replace those with a call to this function. You
> could also get rid of drop_region() and use devm_release_action() instead.


I'll take a look.


>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
> [snip]
>
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoder with reserved DPA capacity
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder *cxled, int ways)
> Sorry if I'm behind the times, but is it no longer a requirement for accelerator drivers
> to have interleaving disabled (i.e. interleave_ways = 1)?


It is unlikely but there is no restriction by the specs and Dan 
suggested supporting this situation was not complicated, so better to do 
it from the start.



