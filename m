Return-Path: <netdev+bounces-259424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEfnJeTelml9qAIAu9opvQ
	(envelope-from <netdev+bounces-259424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:59:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6467B15D96E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D78C3011155
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D930FC0A;
	Thu, 19 Feb 2026 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GBZerPde"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AF31AF2D;
	Thu, 19 Feb 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771495137; cv=fail; b=Ul1b1BtsTjFEsYQYyGom2HUhBVe+AuaktJ3Ja5E+zyF4veJUpvzd6jbPRXkClD6h6+YwY27mmDvXBSscDe3H6+TjqrBCuW1rhL3rnoEXphMH5xytSJt/HyIdX2skrK5cLmsCCB0jU3jNAigdW3KM/OqUbRAxNHxzNVLRjgrr6Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771495137; c=relaxed/simple;
	bh=ZTPxRmu+2qkrwwMbJJ954WZVs1EVnrBResYh3v6d78w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLo47rJ0As1LHmWecZjnFfP3xhAFq74b/lBgdgh7Vkyh2vFrbhhgXwMLMmWtg3YoGAhPBWF86qJVkYuJ1SV+1cpY2lDml49fHQ5VPlYhbcZp0Xl13dCbkKtvYqksA6Oa/wpthwp9jYhGpbmG9wNunCCt8jARIsVcpnHhTgWQMQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GBZerPde; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOxGp47nINbPKUs/tRpT7Z35c4107LtE6Uq/Y4hbYYNDMR6HzL7d9i/qCvt2OWE0JzeXh/0bcHawYleZbeQLtMme9m/0ELBIx3ewL/vHk91LFAQA8bTo1f8oYF3hfe1PcVCPSAdZc8XhfcUZ1KFlwZHXy2GcfsDGavK/+5kJ/EAVo8JGZP5Nprw4l34Ovy3H6r0R3owTb6t+Wss+5zH2NmaWsM6MVIquS5gpL5COtFqxEh32v2pFKf3S+LUeo6QArrPvBunLfVcEpTLnVYWw+w9C3faDDvk7YZ9OTw+SO0+QCoMx9sA6Fr1UyzPtsG1U4fodM2nhs1KeMa9uVqBTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDuqoXJ9gdAXxEovP4LQx8GOYveSbQk4XsMRqnNBU6s=;
 b=UJHngLH16a55b07ZAbFJLxyCppwRjd4KAxaSG7MmLRAjF6paI2Y58AI69UiSFPcFvwJEXJCYC5+ybC8FyAR0C9nUf36DoCV2swcb78pX9DPehgQG8j0MNS3VnOEmCYwuGtnt/9/9TjpC7Gbf4Yex6OqLFM1Il2MoXE1m+/M1wdkRRmVP8pQBLiq3pK98jwQpHsJZamaAHCGCpgpjBgI7wEPid+ozYwZ9Xthkp6fvW3cde5fgdPv6NdBLwSWY/A2u9qvxN+zsQGPDY+RUQeE/m5nIKLekTvidMn+zgc8Hmwp/jm00gh/JGcVEHHkYh+MqR7ZxCCg1HTaQcu/hIydnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDuqoXJ9gdAXxEovP4LQx8GOYveSbQk4XsMRqnNBU6s=;
 b=GBZerPdedzsfKKsa+7b96UcPLnM/loP4nO73bwrCi7HVunc7bCUTlH92qoJp5g1ho5POVt7hocExoE0tRrH4rYUwEqqkp3fyQtzHtXY40R/q9Cza+IKM3ymrXF0r0NqZitU9mx0zbcMw+qyVI7k6IDHbg5nvt+rq85Bjd2KYofY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:58:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 09:58:53 +0000
Message-ID: <10e631df-6a2c-45ff-aa90-71d2ad073e76@amd.com>
Date: Thu, 19 Feb 2026 09:58:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 12/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
 <ea32b5ee-52f8-4d8c-9d82-903d21dc1335@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ea32b5ee-52f8-4d8c-9d82-903d21dc1335@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: d38cd491-e1c6-460a-7b81-08de6f9d7cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUN0WUJsaytERHZoN2x2aFNxOTgvNzhTZjM2NlJoVTJHR3dUS3pMbUJDMFhr?=
 =?utf-8?B?R3JOdFp2Rk42WWptRWZibFdVVnBEZGl4WGJjVFNJRFk3QXphUGgzYmJmUy9L?=
 =?utf-8?B?ZFE2NVhkRXpnanhaRnRQd3Y1UmRCSEdPUlB4cG9TWWJTUm1SY2F1YjVCWWhY?=
 =?utf-8?B?VGRjT2d6dE1ocmxWWk5McW5hRUI4Q2hKb2p5OXRWbk05VkY5T3lJREN1OGxq?=
 =?utf-8?B?S0hNeGNOUlhpM0FvcDNmRkh2d0VkQ3dzMlJSTENIWmNKU011dE9LYkVOamQ2?=
 =?utf-8?B?L083VEFtWDlPOXllaXN5YmxVbjFsRWFYNXlvYVQ1ZHdzcmwxWDg0THpxY1NQ?=
 =?utf-8?B?K2NHVlU4OTRQMUk0aHd6NnJtMjZjOVY4S0lYN3NmdUw1RitQMkVSQkYrNEdk?=
 =?utf-8?B?RHJRLzlFSDZIRzlIejB2ZDZRcTdBb2xINTZQSXBQYlp4QTNDOGR2SmtmbFUz?=
 =?utf-8?B?Q3k5Rm9zcWs1KzR2bGVMQ25iNG83Y2xQdzZvcGp0L2Z5ME1Ia1ZUM2hqdmox?=
 =?utf-8?B?aFluVXk0Mkl2emozSTZwdU0xak0yYlFIbVQxMW1qdlJUOWtqT09tTFlrTUVk?=
 =?utf-8?B?eENGYjdIN3RXRW9sZzJxeEJBZ2Z6bFRpZVFyanQ3UDM0TmxjbjZMTjQrRmY0?=
 =?utf-8?B?RG1pMnJOb3NaL2luZ3hjQ0dkZ3NaeWkzTGVndkw1M1pabkEwNWZJbVk4bE5l?=
 =?utf-8?B?c1NaR0ZWNStYbkVNaVJ0eis3TUx4OStUcEw3NjZ5UGV6Y3U1aER1c05qTmgr?=
 =?utf-8?B?VngwazJ6MzR5MmE2dWRUK3ExN25TT1FuOWdCZXcvU3QxMEZDekJsUkpDZFBF?=
 =?utf-8?B?bXltdVJDYVd5TjZkV0VVdk1sWW1CeFhwMXliZEpvWWtadTZDbjQ4emNZcGlT?=
 =?utf-8?B?MG9JMHk4UDRzbmhySys3clBnR3JncjR1OGd3a3BOMVJMRjFrbUNHMHFKUFdC?=
 =?utf-8?B?WGJ6K1JZQzFDSlloR2R2SHg2MVkwZHR3SFdpa2s4NnpDZWhZYTcvQ00yT1Z3?=
 =?utf-8?B?a0dQc1BGZ0c0Z2d6TXR1Z0tjUTFlOXZsZVArVVFyQlBuWDA5ck1yWFVQUWFL?=
 =?utf-8?B?OFQzcWhETlZXRDVUOFRSZXNnVnk1U2tHYUtLcmNzWlN0VHdMNmw1TzFzR0Jy?=
 =?utf-8?B?Q1J5ZnFCWGZFeU5jUW11bGQrU1Avb3V3UjJqUFZmMnJ2bzlzemNxc0hlc1ZD?=
 =?utf-8?B?UTlHU1hHNnpsYWlaRHVXNXQrOXFxRGNrWHBLT3hCZkFkazV3L1RrYjl4OEpz?=
 =?utf-8?B?d21ialBiSE9RKzY3Z1djNm5OWXc2MUZDeHZKVXBSSlRwaVMyVmNTRXVML2JT?=
 =?utf-8?B?c2t3M2MyNDloZm1SR210bDlmYlJsSWxBakVQeVMwUTU2WXhPWENjNmRMRGdC?=
 =?utf-8?B?NUV5bGNJakJNK3hjakVTZXQ4ZWZ1V29UcWc3WW96WmZCbThWOC9vZlpGa0pY?=
 =?utf-8?B?dHFJd0dpdTBJM1lGdTVqSkVpdS9QY3dqOHI4LzJyMU55cHpNcFduUkIwbXFj?=
 =?utf-8?B?NmFCWmpPeit0Lzc0VkdvY0FKUXYzdHpvR2lhWUxJZ3dJcUFOVkU1Ky9PRGVC?=
 =?utf-8?B?MDZHVlJUZWducFM5clpwa2Vvb1d0UXAvN04rSnBnUjRVSjdFYUFsV0kyTTA2?=
 =?utf-8?B?M0F0UFVqN2FUd2FaYVFJOHIxZEtwV0NQeWFYM3h4SUdqdTVwVndwRXQ3UGh1?=
 =?utf-8?B?L0RMbC9pMS9PU3k4bkNvSHhkSUVpakx1eEpydnVkQjlHa2NBeExmRkdvREYr?=
 =?utf-8?B?SjVCb01DV25ZcVgyK0FDU1VDZ0JlUktMbndTdU5nRThFamg4Q3V4eVh4c295?=
 =?utf-8?B?cnNXN0JjdkZKRmd0TUpBTGRzajRIckdRWnhXdzRtVzNPa29IN3FlOGRlTkU3?=
 =?utf-8?B?Zmx6UnQ3UWlZbzk0TmlxdWswbHlIZkpWeVF6RTc1S0d0RVh6QTQzMDkvVnNZ?=
 =?utf-8?B?Q2N2ZG9xU085UWlOb1UwMzM2NmdpVFlseTZQcVVCOUxNQzVpTTRWb0Z0Qit2?=
 =?utf-8?B?QkdQOHdHNDZPeis3ckk5TGhPT0IyMXlBYWg1ZXZxTDlOaDd3YjNYa0NTM0c2?=
 =?utf-8?B?aW04ZjVYRFpmd1RUY1FKdHhnV1RPS2EwaEJUd0pzUGFTbGZoMHBUdlo0aVl0?=
 =?utf-8?Q?lFtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkhESTNBQWtzS3llNzBScjRJS0pvd1oyNHBpSHVVL0krSG5zcXZ0MGR0ZEtT?=
 =?utf-8?B?dlRyR0NJM1VIR0g5L0dsVGhDSTF0NjNmNXZ2bjJSSFFrb1czdzltalpQdlVy?=
 =?utf-8?B?UzdWUENYWkxVcjNkTVl3T2pJUUlnSHBXT1JCYlRqR0ZMZWJqQ0U4UFZ2OU5L?=
 =?utf-8?B?L1k5elZ1MGN4cWliWU9Nb3l6Z01OV3lrMWlRaXZvcVpIeVF3TmZRRUk3WnRz?=
 =?utf-8?B?SkQxM0t2VzdzeWRQQjBzOFB4dWtCZTBCMDBFN0ZsWkJETzRQd3FFaCtLVmtD?=
 =?utf-8?B?RzhGMUhVL0VNY1BEN3J2Z1Y3Qm1sbTRrSkRUcWNTSE9mblA1aGlFZnlUSzYr?=
 =?utf-8?B?R3RTQzB0T0ZKNmhJN2FoSVpEZE9vVldpeU5GemcyeU1GVWZTUlFXQ3hVR2ls?=
 =?utf-8?B?aThBNDV5S1V6LzNzcVVJNGlDZFllRE1iQVpRNGt3VDJCS2pBcHJBWDEvOUVZ?=
 =?utf-8?B?dDJFcldaRWhpUnEyV0UrL2twd0ZWSm1VaHpWOHJ4dnBmVDFqR0ZqSkIxZGM1?=
 =?utf-8?B?dlVSb0tnNTJvVUk4cHFybGZrK1g2UG4rVG84aFhTRFljczBqeTRMUmJpcExh?=
 =?utf-8?B?OTNaK1Fpdlg1SHNRenczS3BBZmt4djhjVXZZQjdIaEJvV0ZGZTU3dmdKK1pX?=
 =?utf-8?B?TldhdkdjVXh5S1VyRDFGVEhzMkUybHNPSDRGaDJ0NUkzdjBGbFJzTWhPYmZ2?=
 =?utf-8?B?Y08zUTdMdE80L0NXSWxBV3RoOTFyeTh2RWhWMmJmSHJFY3dJalMzNTRKWTRD?=
 =?utf-8?B?YkNvemhFVlNZWWZ2bGVMNWNoWTRFb0d3VGZsWVVMdmJDbUFHdExIbjkxalJ4?=
 =?utf-8?B?ZmFjenJ3M3BkNTlGY0V4VGlod2djemxXRUVBRjFiTHA2NjVBcW5BQ1p5OFFW?=
 =?utf-8?B?MUFxSFRiVURzN015ZVlzSTRaS01Fa0swYTFra1RSMWtCWEhPOW1hL0dNN2tV?=
 =?utf-8?B?eFRHK0cwMWt2S1U1NEo3dVp6d3RpeHFBdkR3WHFtRkFoQ1VkbkdiZ3B4dDNW?=
 =?utf-8?B?TUEzdlRpVElqRGR4bzF6N0tNT0ZYVFh4ejlCM3ROck5HM0FobHMyU3p4bDhv?=
 =?utf-8?B?VGt5WVkrcFphblE1RXJWNWg5TEJKUXBWd3E4L0g3aC95UWxjMXJZVVdsVmRu?=
 =?utf-8?B?cUNYK0tWcVlFaGhwQlJncktFckRGYTBuMlRnSkVVRzYzT3VUMVZ6SlB2Mkhu?=
 =?utf-8?B?d0dUZERaZ0Q5NWFGa3dWSC9IbGJHc29uV1Y5RXZIcFNJTDRnSnkyUHpzejZr?=
 =?utf-8?B?S0lOcUhGZFJ6bm5PODU3NFV6b05zUEJUL0lIbnA5OXB6eW1CTHM2Q2h2b21y?=
 =?utf-8?B?eXY1L3l4Um5rbmtrdmFkTmkzdjM3ZU1mZFYwL1Z3b0hrNmlXVUFkSkR3dWdN?=
 =?utf-8?B?Qm9CalZyVGE4bXVZdFBzMDVDdlBmMmY4NXJMQnQzNFQrQlFJOGg2L3ZOSzFW?=
 =?utf-8?B?Y2tPd1pENnlYTVc0b0hQNGlYa0R2N0lHV0ZNTC9hc2phUHI2MjJ4UndZMmti?=
 =?utf-8?B?V1J3NlF4clR3WExZR1gvRys4Y2FZUTlPUnQwekpUQkF5STlrczU5cTh2K0pP?=
 =?utf-8?B?YzNqTmJuMjlwVEQ3K0FpWDBvM1BET0dOakFyT3VZWXcyenRaUktjL3RUNDhF?=
 =?utf-8?B?Qmp5Qy8wNTlsbVhMMDl4YTVaZWRRUnB1U1hKMVVzYmVJRVVMejhTZnFzVGZJ?=
 =?utf-8?B?eXpZbTJxamRrdUkzT3lJbTFGQkVQSnlTaUFQZ3hDS3NnZUhRd1NDdVM2Mk1r?=
 =?utf-8?B?bUx3QVE2Z3JiSEFrNEdadkZVZG9yQktNaXo1OU94aVRFaGFYc1Q3NEJDckFS?=
 =?utf-8?B?bTllakZVdWtWL3BzNWFDRm5HV0hpS09HRWg0NG9uMk04YmlLL3pWcko0cWE3?=
 =?utf-8?B?MHZMaDc2ekRXVDFBNk9EbXRkVS9oWDh4ZGU3Q3dJS1hlc1ZNUlRhYm9oMHM3?=
 =?utf-8?B?RFlXVVk0bjdmMEZSZGY5SmNhb3BHVlhhSnBTOGh1bTdLTUlnUTVSYStkbGp6?=
 =?utf-8?B?Qk9SZC95RnROSVRTTFRjczM0eVlRMG1tRVdHVXBKY3d4S1Q2b0djd2JyS3Va?=
 =?utf-8?B?WFBVSUdwZHZPS05ENHpvczdLcFpiSlR4V3F5a2xLK1pQUm1wVW16K2Q5WHF0?=
 =?utf-8?B?a2QvdEhEbVNPWWM5ZFI1L0JXNnNJVG5qSmpCSUVSZHE4NlJmUTVsTXRiTDFn?=
 =?utf-8?B?N0prclJKeHlRMndQVlZGNjJqVnhHaGRNZnpEUGRtb1dXY1JwS0dGenh5TFJw?=
 =?utf-8?B?ei9oazd3SVl2aU8yVVJqU3F4ZStBL2VZSDFtNUl2ei8rb1ZQanoxWHBnQXFn?=
 =?utf-8?B?SzFVNjJXWnFNUm9mYUFwUnhnV3BZY3pQdm83RGpEOVEwUWlFTEpEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38cd491-e1c6-460a-7b81-08de6f9d7cc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:58:52.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQQAjiQwz/z/CScW4mxC4N1TWEciHLgU+kBFh/fCavvONWk0gS8ERhjl5klgD0Yz2umA49P/bFiHvp7Kzeh0XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 6467B15D96E
X-Rspamd-Action: no action


On 2/11/26 22:10, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from Device Physical
>> Address (DPA) and assigning it to decode a given Host Physical Address
>> (HPA). Before determining how much DPA to allocate the amount of available
>> HPA must be determined. Also, not all HPA is created equal, some HPA
>> targets RAM, some targets PMEM, some is prepared for device-memory flows
>> like HDM-D and HDM-DB, and some is HDM-H (host-only).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   6 ++
>>   3 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 954b8fcdbac6..bdefd088f5f1 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -705,6 +705,170 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t free = 0;
>> +	resource_size_t max;
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++) {
>> +		for (int j = 0; j < ctx->interleave_ways; j++) {
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +		}
>> +	}
> This may be over complicated. I'm not quite sure how it works (I'm just slow today I guess), but I understand
> what the intention is based on the debug print below. My issue is that ctx->host_bridges is only set to 1 host
> bridge (endpoint->host_bridge) in cxl_get_hpa_freespace(), which is the only caller of this function. At that
> point, why have the outer loop at all? At that point, you could also simplify ctx->host_bridges to only
> be a struct device * const.
>
> Maybe this gets called elsewhere later on in the series? I haven't looked at the rest yet. If I'm wrong, then
> I'd probably add a comment saying what the cxlsd->target[] entries are supposed to be pointing at.


Hi Ben,


I do remember this one.


Dan's original patches had this support for interleaving, then I removed 
it as the case for Type2 and interleaving is quite unlikely, at least 
right now and likely in the near future. But I was told why do not 
support it as it was trivial to do so. FWIW, If I think only about the 
use case coming with the patchset, I agree with you, but because those 
previous discussions, I think I have to leave it.


Thank you


>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev,
>> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_rwsem.region to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_rwsem.region);
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		if (!prev && res->start == cxlrd->res->start &&
>> +		    res->end == cxlrd->res->end) {
>> +			max = resource_size(cxlrd->res);
>> +			break;
>> +		}
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
>> +		free = cxlrd->res->end + 1 - prev->end + 1;
>> +		max = max(free, max);
>> +	}
>> +
>> +	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(cxlrd_dev(ctx->cxlrd));
>> +		get_device(cxlrd_dev(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the mem device requiring the HPA
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * Returns a pointer to a struct cxl_root_decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this decoder and its capacity is reduced then caller needs
>> + * to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxlrd_max_context ctx = {
>> +		.flags = flags,
>> +		.interleave_ways = interleave_ways,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_port *endpoint;
>> +
>> +	endpoint = cxlmd->endpoint;
>> +	if (!endpoint) {
>> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	ctx.host_bridges = &endpoint->host_bridge;
> Mentioned earlier, interleave_ways is effectively hardcoded to 1 (unless I'm misunderstanding
> something). I think what you want here is to go to the CXL root and pass in the children (i.e. host bridges)?
> I'm not sure of what the fix is to get the intended behavior.
>
> It may be worth getting rid of the interleave_ways portion of this function and
> add it later when someone needs it. You could also explain it's hard coded to 1/unused
> in the doc comment if you know of an immediate need for it.
>
>> +
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> Can just use a guard() here.
>
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(cxlrd_dev(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 944c5d1ccceb..c7d9b2c2908f 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -706,6 +706,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>> +
>> +#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> +
>>   bool is_switch_decoder(struct device *dev);
>>   bool is_endpoint_decoder(struct device *dev);
>>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 92880c26b2d5..834dc7e78934 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -255,4 +255,10 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>>   struct range;
>>   int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>   void cxl_unregister_region(struct cxl_region *cxlr);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>>   #endif /* __CXL_CXL_H__ */

