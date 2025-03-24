Return-Path: <netdev+bounces-177118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3279BA6DF67
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7927C3B15F8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09296262D28;
	Mon, 24 Mar 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VgsfbECn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F9262D15;
	Mon, 24 Mar 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832974; cv=fail; b=H9ZJNGMsN/l9CVPATXkPvtWATBoRWgT/2ZkVi0M+Q6rmXGpscRll28MntnTU137CSoKpsJs/keYIiWuPi5ouRSdxPkKRa/+/kZt3ElcVwIM+9z9SzrpH8pB9PeCyL/2xhryLq/A5ciNWAOjZYTPvlD4xNwlB/nvnAUtbz0kzi1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832974; c=relaxed/simple;
	bh=Q29V+v6aoCHDpLStHdhYvUJjW15agZfpE/dMtEF0c04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pKEmUMRVZOiAaxIetUAx9JHKENTLOPxNemD9bHfArW04LgqLKmb2Q54Lct+2fCHKZqbs2FFyXgA7/7gR/zQnvh++rMtdfrJES5SKn+plCWsom58ovlGZkFlBGYLFBhnt+ZR9EbALZqAZT/shm7vP6ZY8e/6wlxxtPwKpJcXEFXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VgsfbECn; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfXu0kU+oI89F/qJeDZLZr9qKfzot7R8C3KbuyO3K9iQRhpfSx0eLmYQeAY34X9JoElbOe6OQqRFAJaalp4HqNhgsfkL2z99mmMbk1K583nCjkukpTAJVJ9YFmKlXcsQ+tLGJ7QTzEVtg65CUmBn/7yAqESKWoxYcK8XjWpmwcQvULV63gRBvarkiCNAiAfyVHDqZH/u23fbctEMJ4JwiMsPLoWsw6UsMYhjfKjvPl/NV9UCscIzloWOw4DGWwjHYirD3UhrYyzyG3YGkUeOWNkWFZ+sfrB+KD4SPhY4k5AkDx/8hsgBmmZH0hEMDW88EugT5pEbnhdcY4bIRsktsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRc8SIuIYunfDP3x4f3YDsgWEkA+vnRvb8D6cpVtom8=;
 b=Kwfo3b+hl0X2ndMuOaxd0s62mULCSABkQ5P4oj13vkqAbXH2eoJUDGMTHzGrc4ypLN56LjbPEId5hIV4mIMzLPgioboYImRsj0ktlByOeXJQQgslamlMHxLsO4rTtVKPPO2aQL7BmQVkRYZkLG6XjUxOv0b+t/ValZOe+bD7OEK5Ll9Af9R0woftD1U8j36MFOnA0c06Vc4QfjsBI9T/03Bh9JhHjl3Tu3XT9x247PHLG3hzack4dGsVG1OO53m9qRt70mSgX5xPm1r4+VwLtoQAz5xieWTohhl0CQXLnSmHJzgMJPH/Cwu+3ak2eWYu/Z2UAYn4Ur3o3xmEjuZJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRc8SIuIYunfDP3x4f3YDsgWEkA+vnRvb8D6cpVtom8=;
 b=VgsfbECnlzvhRGzFARYpwn7yfezFGwu72RLVaz88Geqz6/MpePcnfNn1l7vTneLgehQxJdVERb+ib7muqb79MuslkiXNnZFO8F/yzISAcln7ORIs+e9ftlv7nLqvaa8ummuez58y7KtivSK759rn1KG0IC39V58unxhSHSJJxzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:16:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:16:10 +0000
Message-ID: <3af51327-7745-4b18-a478-f47c57683576@amd.com>
Date: Mon, 24 Mar 2025 16:16:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/23] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
 <20250320161847.GA892515@horms.kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250320161847.GA892515@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5f6b96-413f-4d71-848b-08dd6aef30d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cytjMWlLa3VxeW56aFU2RTVqYTR6UXoxM1FOWFNWZ0xtUUxPd1p3UkdYdlNZ?=
 =?utf-8?B?OXprTVNWRGxHV1BIMFlSQ2JlOFVYa3N5Tktna2pqQnF6ZXlnYS9BWHpzY2ZP?=
 =?utf-8?B?aDZNT25pZXQzRU5sckZPc3oxUGxKSmhscXc0MXBKTG80MnpjeW9hazlBNXhN?=
 =?utf-8?B?dEhBamszeTNhS1BKSjJXTThoaDVEYlYzZnhWNjB6L3JrVHdQejN3WndLYm00?=
 =?utf-8?B?SzJyZng5QXA2MUdkN1hmTDBwM3M1U2ZnSXNpZ1V2V0xNeVhob0RDT3VmNjFS?=
 =?utf-8?B?VXAxcnFGTDlLZ2k1MDFPdVRzR1B3NzM1NFZpaU00R2J3K1FqMWUyYk1saEdq?=
 =?utf-8?B?YVM4SndvRVQzL2FxSDcvRGdlQktEbHlMS05FbVhtMDIyR0dSdXJxcmNJQ1Br?=
 =?utf-8?B?aGpWZVdyRkgyYUt5bkRMMEFJU1NQZWNJdFJJc0lDME5mNk4xVWxFZUpPczNN?=
 =?utf-8?B?NG5mczU0MCsvRTBLMGlScnM5bTRFQzlvRGVITEFHMUZ2VU9lbVNjWjBxaVdu?=
 =?utf-8?B?WFNvYndRdUlTOUJ2RkovS2x6U3I3Y2ZjNVFKdDltVDh3MENYYklIWmc0aUdH?=
 =?utf-8?B?N1FpTDBCUTNFN05ScTlMOGxXbXdnZGZmdm1mQXUxNEJRbnpBTENZU0grMEdq?=
 =?utf-8?B?TWRtUDcveGtXT3RDSWtoQldrSmFNNW9ZWXR5Y3A1cTQ1T2dDZVEzU0pIdndy?=
 =?utf-8?B?VE5ObnZNOTMwNjIrSUx5TEpQRU5NcHVPSis0S0NQZFRnc0YrTHNWamRVQXk1?=
 =?utf-8?B?bU1XamF2Nlp1ZEpMZmw1eGVPODNLYXcwbkNvUk96UFJieVJad2xZYUlibU4y?=
 =?utf-8?B?cWNNcjNMQzNFNytzbjZLSE5aaWFKb3FiUEYySFYvL0tZK0MwUkV3cTcwUFMx?=
 =?utf-8?B?VDZQMGRNZkgxN2NDQUEvODRwcENRME1NZWRnV0p0ZHdZbWJ3UjhVVkd3UHJJ?=
 =?utf-8?B?d0d4OFpuK2tyOUJyWUwyMnRIR2laOUJSUEpuWXNubnJmRGx4bjNjOHhjMnky?=
 =?utf-8?B?dndva2VXUU9DNmp4WmJZVzFVRkpRamVkNXZBRmhJVEhFU2x0V3FrNUJVWDZz?=
 =?utf-8?B?Y2VIQWN1QmNFR2xTSEg1Mk0vOHhNY3FXUDJXTEdJYWxzcDlzQ0hsSDRzN1FO?=
 =?utf-8?B?QzA4YStYVTRZT0cwUHd0eTdqRWk2MS80RWFhRjJibFBoMzJ6dkZuaXYwb3hi?=
 =?utf-8?B?eFUrNWNMbU54WEtaMWpJalo3U2tZTVlVeW00dnRFY3RucEpOK1J0NmNQSXNS?=
 =?utf-8?B?Y3NEbEZzU2ZyNmZSVHgzRG9pVUlTd2ZhT2JYakZQTXF4SUFqTFV2ZHlwOHhx?=
 =?utf-8?B?NXYrOUIyTndnSHNrdzBBNDc3Z04ya1pYYUEvdUl4bzN1VUYzclQweEJxdWU5?=
 =?utf-8?B?QTlabko3OXFKR0U0QjRYcDhTVEFDZW8xRWVmRktLaXM2L0g2cnQyZnI4TTJV?=
 =?utf-8?B?aTJCUHdaWlk5Y20yZnh5SEg1cFFlOHM4QzZyTklPUHFuWjN2VnlwWS9ncXMx?=
 =?utf-8?B?bFZOMWZmWWpMeS9pdkZjKzl6MzZ1N1RFQ2E1cXc0QWNhR2NWU0J1MW51T0RX?=
 =?utf-8?B?ZnJiLzVSZGpBT0JqZXk0a3JQbkJVRG8ybTFzV3UrMnZ1LytGY3lXelB0ODEy?=
 =?utf-8?B?ek81QzVmWXg4eDBERnZjaHBVb3U1UVRDTnUyTERWTXFjZW5MVzIxRldsbTBu?=
 =?utf-8?B?MTl4SG1tNlJPUGhvY0lCdTRQaVNCKzlYNjNObDVNbUR5LzVtN05rbkVSZFQy?=
 =?utf-8?B?VG84QkZxYzhVRHV0R25RUm1sc2JhaGt6NFpVMnFLN2VKR3BCNHRGMU9tVVpV?=
 =?utf-8?B?NXJMN21EOVdyUXV3S0tTdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUxQc2hUdmdhRUVLN0xGWmhXNzBBZG1DMk9obTQ4eUFjcVBqSCsrTUlpL0xh?=
 =?utf-8?B?L0VVV25DU2Z0V3Y3ODgyakRzOU5wTmd5TjFkVjhoQldtQVA0SFdZT0c5cTF2?=
 =?utf-8?B?RWZLM0xyR2NkcG1GM2Y0YjhyTVE4TEtqRlRIMHBxZlV5NUJmN3Y3T1J1U2Vn?=
 =?utf-8?B?alR6QVFxVklhZ05Uc0xnRENiTVR5M3ZjOElOZXpmeHRibHYwSE5MeWdWekJ5?=
 =?utf-8?B?Vi84ZDZrRlcwcWpsVFBVbkF4b2NyMUhIZ29PazlNMDIxTmRrNndha21jYnpn?=
 =?utf-8?B?b1piWVZWK2syZ1FTbllvNHF1RHpzYTNweEx5ZkdHZklXSk8vZzllaFFjTVhW?=
 =?utf-8?B?TXUxZDBzOWxLNTcrYnNxTDA5WStwem9jWlcyVDJJSHRaamcwNjVYWTAvRkl0?=
 =?utf-8?B?bVBDejRWY3NiQUo5QUw4TW5zOVFibGx3NkVlSHY5T1dvSjBWaFVEMUxCaDFQ?=
 =?utf-8?B?WndKZXphd045MW9BZmN5dG52K1BNWGd6VlNKWGVhZ0hwUDFRdkRmbVdZQldp?=
 =?utf-8?B?L1NZREFWQW02aUZpd0hPRzh6cytTd0NkU1J1K1kwY0tQQ2liNkd4T25CcUEv?=
 =?utf-8?B?Mk5kaFlYSkRNcnZQeVNYN005Mm5PSUJRVkZLbWlMRHFlNVNLckZYT09JZ0xW?=
 =?utf-8?B?TDFGdUcrRVU1OHkvcDc3N3dUNnNWS3Uwd3JENUo2T2QxbnVlV25reVFBdW9P?=
 =?utf-8?B?TWtYMzN6UDZjS2xrTHd2MlRlNWRtN2R5b2JuQ2x2bHZLNVFmS0tmOTkxdDhY?=
 =?utf-8?B?T1BBSW4wL2g1dTZOcHlhYXJ0U3drZmtpSXZTVjY1Y2ZhT0ExWVB2dkJiYWhk?=
 =?utf-8?B?TlVnWWE2OW5yMXkzRUtvUkxROEY1MmdheHJ2SkhJejE3N0N5NkNHVmJhd2Vn?=
 =?utf-8?B?dlplYkp6d0w3SVllaVZ5UXorUElsKzE2K0dpbUQxR3JlTE54U2xVRU90SmR1?=
 =?utf-8?B?SUxiTi8wdWpGNHVDVTM4NGpBcFhsSVVFWnFzUUNDNGNWVzIrWGFiNTJpMlhz?=
 =?utf-8?B?c3g5VWlCUXpNZ1pCTzNBcHVGSklwTTQxaWZaZEtDNElsWWh1d2RpU2tYeUsz?=
 =?utf-8?B?QjB0bk5Da2xpU2QySkY3bjdWUnZBRXRQeHByTE10S1ZYa1RyazJSTTdpejV4?=
 =?utf-8?B?SCtJZHVSVjlxREpiU3hodXJ0RytKalF2SENZdEEwU2xqN0RWU0g0WWNLbUpQ?=
 =?utf-8?B?RDEySFBCa3FQS2JoRVVsMFQ5UE91M0x3SFlVYWpKa01DYlhwWTdMWGcwalg3?=
 =?utf-8?B?SVZSTTlKVnV0b0J1MndvM0dOeWNFTERzMlFDZERYNERHdXpUSHdCZ2hXeWR6?=
 =?utf-8?B?RitCNTFqODRVVlBsRDFndENjYmpPYUhoMTJzNXRhNHFIQ2FxaUhtVU9oRFhi?=
 =?utf-8?B?SGlzdlZaVGZGWWZ4azNzckc2RWNSeWFPcUVua1lkUDF3VG9BUU1Ya0pZUWFS?=
 =?utf-8?B?R1l2NlArMnJ3enl6VGRUSlhVeHNjNUZwRHNpOVNvQXdpdWZwWDZPNXJiN2V4?=
 =?utf-8?B?eDcxV2pnMGxtd3JEQXZoMlg4UW00bnFuUTRGUEpVTHgwZnVWaWtKZmZ5dW03?=
 =?utf-8?B?SnhtR3h1eXNVdjBuNnVaTHp4b3ZmTUhnZnVZQWExYSsvMjJhTlRLbGNwdkhB?=
 =?utf-8?B?eUFzSGd3bFBVRVl5aGxvSENVUU1vdWpLTFFwMGl4eWFkUUI3dnBKK095UVdo?=
 =?utf-8?B?emF1emJuNGlKV1BNQTE1anBsL3J6UzZLbXdGYWhvMWMvaWtMbnBKZThtOFk3?=
 =?utf-8?B?RHFFNlBaSkJjU3pwRmRDRSswanQ3Y2dWWVJISFd6aVd6Ty9JWFA1MnhnODhw?=
 =?utf-8?B?NnY1ajgwUm9xeWtSMGhCalVzczBSN1NTNVFyOWxXQmkrQXVTdFZhRHNYL2k5?=
 =?utf-8?B?dTlyT1loK3k0U1ZDbTAySEk1MUhHK2JXell6T2JwN0NNUjlUSjJwR2FiTGY3?=
 =?utf-8?B?MVE0eERkQ0NPTWlZaC81OEgwOU9rbys4bWRzSS9vRmJoNDhGWE1XVjRKamJQ?=
 =?utf-8?B?Y24zSTdjNjVGckg5cEZPUWhGUHdKVXJ1NGxjZGF3QmlxdEtIekx6Q0lRVmlF?=
 =?utf-8?B?L1ZnY09wZEFZcDl6NHZtK3g1UDcxU2J3UW5pUStsbEtMQ3kwa3JiK3J1M3FU?=
 =?utf-8?Q?kLYt3+M2o9m581tRwtVcpSIVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5f6b96-413f-4d71-848b-08dd6aef30d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:16:10.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtSIAqxi580FD8A4cfa3s3TBN9L9a04h29uBfokAjsy8HivOdGvLy7G0hriNSmE35IPUKuHB1jQ78RIOWRbiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078


On 3/20/25 16:18, Simon Horman wrote:
> On Mon, Mar 10, 2025 at 09:03:30PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Define an API,
>> cxl_request_dpa(), that tries to allocate the DPA memory the driver
>> requires to operate. The memory requested should not be bigger than the
>> max available HPA obtained previously with cxl_get_hpa_freespace.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Hi Alejandro,


Hi Simon,


>
> As reported by the Kernel Test Robot, in some circumstances this
> patch fails to build.
>
> I did not see this with x86_64 or arm64 allmodconfig.
> But I did see the problem on ARM and was able to reproduce it (quickly)
> like this using the toolchain here [*].
>
> $ PATH=.../gcc-12.3.0-nolibc/arm-linux-gnueabi/bin:$PATH
>
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make allmodconfig
> $ echo CONFIG_GCC_PLUGINS=n >> .config
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make oldconfig
>
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make drivers/cxl/core/hdm.o
> ...
>    CC [M]  drivers/cxl/core/hdm.o
> In file included from drivers/cxl/core/hdm.c:6:
> ./include/cxl/cxl.h:150:22: error: field 'dpa_range' has incomplete type
>    150 |         struct range dpa_range;
>        |                      ^~~~~~~~~
> ./include/cxl/cxl.h:221:30: error: field 'range' has incomplete type
>    221 |                 struct range range;
>        |
>
> [*] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/
>
> ...


Thanks for the references. I'll try it and figure out what is required.


>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> ...
>
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @is_ram: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
> nit: @alloc should be documented instead of @min
>

I'll fix it.

Thanks!


