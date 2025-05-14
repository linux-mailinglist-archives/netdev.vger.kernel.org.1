Return-Path: <netdev+bounces-190341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2BAB64DC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53DA19E8F52
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF4213235;
	Wed, 14 May 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c/mm9EWy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0A2063F0;
	Wed, 14 May 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209031; cv=fail; b=acCoPEGzMlmKVV2ZusLRMByH3Jwtb2B8dXLlvThEoZsqr3B/TDzw0/xrpbTZ8N8BiYYHG0nkKa9COr7sNVKi0+lekbP8ruFlN/AzfA9WocKmj4wIXPqpFiWTf+Bda5H4EfHZ6fwrFvzzB6HQbszl/0SWiwsG7Dy0TcN4ZJay/0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209031; c=relaxed/simple;
	bh=hdl9yzBP3be+AyiMgbhQr+I7R1dPGd3zbp/bM5hVhSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rTnpcKKw7c74m7NlT5tBNiQ9fLx6v+W2JqPVVuwlYlVRFf/Qve1jm+b2EulRjoMnb967IcoWJ4g55g1E2103OUxO47GrBw6MtER1K2rgrlcSYhkA3xBL+9Uq22LkWR9VJDfoWquVXG5+Lzkk+Sh8G/aZnYk99KqYttlTrjN+rbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c/mm9EWy; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfRnsi8nve/XtgWdocYEW3jdxUalrMU1KtZnHu3H91pxai8BsOY2OHWQSc+GBHlmIZadUZAEXgo/EJBNP2FgSbIzcaJAQJbsHTKXJ1LiVe1HB3NyUHAO0Q6+ixP79p61EDtbduUlugxL3iaSdBZZJB8gaQbq/sFN3VLT4SpGijYm5heKpp+gbnNiv0AXdgka9fGSmMrckLJhZVQ8LrRN0pJiEb4cq2bPhxsE8vn/omRV+uT4N5T4NY0Wp+3sHh6XfzWZ8VDKwSBbGX/2wEUVI+eoYoLvNiDUQQxYM3gsm5pb3isgsDLuV1+iN/KFqRb3JExZk8O29S48uJyk3wrhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNLDM7obdLUJX1zYuUyr6eQNk3mGNdEhkS6EHQ/Z6DU=;
 b=oeUH9oEjJF4I0UrfkKr+LRHNnFRHy/k4VjNGXotuQW/OrZ6DR4boa7BAeVpxaSwMXI5jmA43a7Kt3tLBYYN/UdFUHJpGx7H4Awp14GZe0VnHQTDulDgpFWJlC77FnfkHQ45SGUcLOUvAEGXFo54vYgJnJ28by0FqlTtUFYCI/UaIMBszfKnWpCju3lyrir6xwHxwzLoLcXXihhrm6G1II2J2Rd45X2zD3wTiw0hMzMJ2ASIq598JabJ1HIAJWF2B2OSXcMO8ahFNbNSt5poSsdmKF227VcJm/2L5FdKpodcJ7rNlUspmrUguCWDi3YztZ9tvjb9yzyVIwMWmT9yu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNLDM7obdLUJX1zYuUyr6eQNk3mGNdEhkS6EHQ/Z6DU=;
 b=c/mm9EWyQHEj/kIsgMLyHV260ntjj9MJv/XFt2MkLigLO17UpCVMKqCBAQlVdEZI7AFqsfVkoyNgI15HY0vh+tQ5C/3gLQvmVXxnZlHhKxA0rvXYQAXfOEznLd5ulTe97DqwoFgE4q/VmX3STtQwF34eGn8B6moJQOYMQ7Zmk1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 07:50:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:50:23 +0000
Message-ID: <7c01b39c-72b4-4530-8ec2-f6e68e12c4a3@amd.com>
Date: Wed, 14 May 2025 08:50:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/22] sfc: make regs setup with checking and set
 media ready
Content-Language: en-US
To: "Cheatham, Benjamin" <bcheatha@amd.com>, alejandro.lucero-palau@amd.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Ben Cheatham <Benjamin.Cheatham@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
 <20250512161055.4100442-7-alejandro.lucero-palau@amd.com>
 <7a951b14-c1df-488e-b63b-cdcb4a854b5c@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <7a951b14-c1df-488e-b63b-cdcb4a854b5c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 44418d21-a3f3-414c-a017-08dd92bbfb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3k2eGZrRis5MEF1Zk95QzNRODVUdmJLaStYNlZwRDFXSWZ2dzk5dEpYdUgr?=
 =?utf-8?B?VW12ZzNRdTMzK0s0WDM5ejllc2xsbVE4OU5oeVZGTFI2dU5IRWE0cHhDNm91?=
 =?utf-8?B?UkhxN25Celg2UVJzbXFKRWRvRVpobC81Z2wzNVhjeFVabTVuTVZKUVNXakFt?=
 =?utf-8?B?b2JOVUE5Q205OGM2dHJidEQ1ZllySC9sQ0liUk1TZldmMzdsRTB4bnN2QkdO?=
 =?utf-8?B?ZEEveFBtQXRrZllzYndnaWJRMFQ3aWU5dlNZYVJscGViVGFCU085ZC9leDQx?=
 =?utf-8?B?L2FxbE4xZmN4OXBiVUh0cldQR2ROeTd4dTZvMjZudVhxT0xuZ3RGUXFCTnl4?=
 =?utf-8?B?cEV5dWltN1pLM3NTcktpa3JHZm5aaEplTTRtaUJpd2ljY0taVkNXNmFKOCs5?=
 =?utf-8?B?amJ2b3d6NFRFdVZUSDA3TkMwZ1A1a1RVWTY2a1YzZGRNYlRYTW5QMHdMRWh0?=
 =?utf-8?B?SXFLZm02UzBwVENWZU5Ma0pyTDExNGp2UURqbFJJOTJtOU5SV3NhVWpmR1NK?=
 =?utf-8?B?NjFCRnhiRXdDWFZQRW1INjlvNWcrWWF0amwySnhUZzl2dXhLdmdZalVDaHJu?=
 =?utf-8?B?ZDZucEdYV0U1ZHRQSmllYkF5SWc4RlNzZWFVeGFjL0xGd3FveC9MWTFrWm9F?=
 =?utf-8?B?SWZVbTM5ZXpNWDNtOEhTSmZEZC81R21hbXJET2FmUTZNR2NnT1NORWJPNjI3?=
 =?utf-8?B?a0lrS05xa0xpaWMrZ0djTTBSbExZUThMZ0VPakFDSXVBRVI0RzdMSGpNMUlE?=
 =?utf-8?B?bi82Mmo3M1Y3NVlydVNVa3RWSkdMQUZ1M2tSS2ZFVHRGR2tBSkhXTW5xenI2?=
 =?utf-8?B?dWpxSGFYV2FCQ01xQWlIcmRvT25sVlFNZDVXTElQMElxNFVLc1BzNzU0NGRn?=
 =?utf-8?B?WGovNHpjVU1LK1JUbG5RV0pNS3FDNjZ6RzZxMmxCVHhDdUVzVTBqbnZTT1NW?=
 =?utf-8?B?c1A1U2wyRVZTRWdjSGc1cGtDYTJvNTk2K1RZN2JZNjF6emhreUowREEzYTdi?=
 =?utf-8?B?YmFrYnBqV0pCZXIwZHdXaEZiU0ZiRy8wMEtyNEtsZlYxSzdoZHZaSDBmeWJF?=
 =?utf-8?B?eWxMN1dWQnNMMm8vRFVEeW5DU0kzOVAwdDJxM0NzSUxYdXBmQXUrUEZjL1Rm?=
 =?utf-8?B?a2dscVhnSGw4WUd2NGlZQ0NGVVhENEhGK205aHlWZCtOdU1nZERLcEUwZHhq?=
 =?utf-8?B?WG84MGxxWW1YT1prR2xIVXI3WHlsenJ2TTYrUUxKbTBhOWROdW10S2NKMjcx?=
 =?utf-8?B?ekRodmd0cE1sb1NLNmJNdWJ5U3BPMk0ybjFqRnNOYk02cEI0OUlibXV6ZWdR?=
 =?utf-8?B?N245RUtwQWVpU2puUXRFMHAvbzE5WHZjN2R4b0VHcG1vTHN1RFpod2VyY0ZK?=
 =?utf-8?B?enVDUEphNWtMQThISGE4L0swZjA5aUczSk9tWGN3OUdnbnJ3Tm51dzFYS2U2?=
 =?utf-8?B?eEh4YjZqeHkzN2hmL0dyS1NKcUZ3ZGFrcmM1Q2JxV3pKUkMyVE05ZzJGYUI4?=
 =?utf-8?B?NzhhdUVuUnNkeEpmQ0E4U05YcWM1M1pKZkUreXk5Y3B2cmFYdzlEbXNHSmVT?=
 =?utf-8?B?aE5IbTZ3QVVSeWc5dFY3UHY4RHp0N25ndVFoSjNFUHdvaGk2bkM0eUVCV3NG?=
 =?utf-8?B?NlJSQnYyNTAzSFVya2kwdjZFUkZPWTZueHFjZzlGMWoyRDgzcWlqTEZVU3FK?=
 =?utf-8?B?Tnc1Z3Z0dmpFMW02VjQ5WDMzWDAvazIwaG5JeWNPdnoxeWJTWFV1N092NjQy?=
 =?utf-8?B?WDFTK2xKZGJJbTAxY0pRUXhWYk9sK0RkQUQ3cmduZWNKQW1Ra3hXNjFhSFVo?=
 =?utf-8?B?SmlkRjVFcHVOeTJMa1kwWDdkanJqTnFBTXI1RytrTHlER2FDRVRkTkd3ZXJS?=
 =?utf-8?B?K3M4TFNPT3NUZDI1b1o5cmk0cEtIQXVqdlZtSFNuOUQ4cmw2UEV1K1RoeHdC?=
 =?utf-8?Q?aTvK52+uiuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGNJQVlWS0F6U1N1WkVZVmRKdThwVUtXNkw3QkFlQnV2TUNGZWd4Zk9WS0Fp?=
 =?utf-8?B?U3c3Vmp0MStzQTNxK1JoSFZ0ZnliOTR5cUs0cEwvaWNBbVg5b1dLQVYrVkl0?=
 =?utf-8?B?Y2M5Q2pHYlZRK21MbkpvOUwwNG9lSkJPSTRoSXpHdnQxaFI1eHpzR0k4NjBi?=
 =?utf-8?B?VFBoUnhXWGkvQy9sNzkvU0RJTkJReWhkdVJpcnE2WWVFWmJXYTF3SU5LS3VT?=
 =?utf-8?B?ZXF5dlFXNjJXaWY1dS9qZkNBQXdkWVNGa0d0VktQTnh0RVJGd0xkOEh3NjJ2?=
 =?utf-8?B?RkxxeXcxa0F6T21FUWg1TGg5RDlPbnNGLy9vZTRRT2lqSFlkSEs4S3U3Tnpt?=
 =?utf-8?B?WVhSUnlwRFBlTmVaMTI2em9vMGh0bk9VYkkySEFEWWJjTmxjc3lNMzZuZjZW?=
 =?utf-8?B?REF0UC9RZVh6aFQ4RmJFUXJoNkhUazBpamxTWDB4UzVhanhwZEtsRk14UGdM?=
 =?utf-8?B?cm51UzQwbnRmNGhvZDdLWWtGbDBjRkhqZkl3REN6N3BqcjlGVmJzbTdQKzEv?=
 =?utf-8?B?Ylp4SWhtblprdVlUbEdwOVEwOGFXNkNMZzZGKzdDWTU3NHg0NEVJa0taaHZP?=
 =?utf-8?B?MTdldFQzeVRORHZUTy9mNWt4eVVZdHRiM1VINEdBZkJ6ako1djA4NE04R3R2?=
 =?utf-8?B?Q3BVelZVa0xuUmVpcEt5S3plN1IrSUQ4akVFTnZ5YTZuT01xR0lJUkJaSCta?=
 =?utf-8?B?c0ZNUmxvSzZjMmQyNDk5dVVmMnlMMEJSTW5FamdlM0JJRTB6cXRLNlBBa0tQ?=
 =?utf-8?B?Q2w2MGxXWTRXeldWOFZkK3d0ZmFNYmtkell1UVFtbytCcnpydzUzditzU2Vq?=
 =?utf-8?B?dkF6aEpwV245cmlXdW5wcGwwRnR1Mm1VMW9HRXFiQjlaWi8zblh5L3c0Ykox?=
 =?utf-8?B?emdrcXRCQ1NDM1Y2SmRMb0NndnVkN2RiK3EwcU9FdGNXWTNBaFBiQ0lTWUlR?=
 =?utf-8?B?cDR4SnlZczJTYy91NGhNeXUxbTZvUWdCSVhoNnIyVjdlMGRVVENyY3RpcG5q?=
 =?utf-8?B?d2h2VE9yMlNkamJ0Yk51K3NZckRDcTdjeTJjQjlyN0gzZ2NBU3ZaRmw5c0cy?=
 =?utf-8?B?T3E0RmdvY0hlZEx2T2xlV1I5NjV0UHVUSTlXVCtia3pPQ2I1V2V5SHBXYlRX?=
 =?utf-8?B?VjdrcmRFcnJLK2VOdWpsYVJ2bTJLVjlYL0xQRWhwWFFQRERmOVpWa1p3dVBI?=
 =?utf-8?B?VldXb2ZEdkdwUitZRER3clNWOGZwa3NDbFJZdHphQ0tLejNnZ3NFNEE4ci9S?=
 =?utf-8?B?S1NscGFWbjlET2VWQ0JxaUlGM1BpMUpPbmZ6aXpNaXhHc3Rya0ZqOEtuR0hF?=
 =?utf-8?B?TXhOWTVhZGt6Q2F3eTdOa0tlRkxwQXFNQTdSUW9mMUZWWS9IODZvTHZvL1Zi?=
 =?utf-8?B?K1dHTmhpdjUxMlByMUV3TUlUc3RBek1KWDcxZ1Y4ZzJOMWJsZXdISjBTMmJY?=
 =?utf-8?B?K2JDT09lKy81WmtJVDl6L2doc3ZpVEtZMEluZ2MrU3FvVTc1dVJsbnlxTXI5?=
 =?utf-8?B?eld2RlRqQ3ZzRkRVWFhFV2oyN3hKQlI5a28yZU9RMmFhYXBnTlNnK2RCaElJ?=
 =?utf-8?B?eXJJK0xEdFVlN3RuMlNwUVpoK0RUV1dLMm13dnREVkNlRkVTOWZxQ3pwUGU0?=
 =?utf-8?B?SFVvV3JRMHZGYkY0VUlocUNJMVo1RUU5UWw3bE91VFNHZGNjdnlRVmVIK245?=
 =?utf-8?B?b2ZUTzVkYm1TZUdIcXlubUhuTXYrZStWcitOd3REQUttZVNTdklrczY3ejBn?=
 =?utf-8?B?WWVnVzVlNzk4MnloUFlyNnRjeDJPMFR5dzZ6M2RHNG8vTHlTc3FPdGJxNmFX?=
 =?utf-8?B?S0hqTmtQOUhjRjBhbGRuWVQzLzMzTkpUSmRiZDhQTFM5SytIVFBua2Vhbi9B?=
 =?utf-8?B?WEN6ZFRkT1Nzb2F6MTVIWDFiRXE3bk42RTZqajJCRUw3WlBKUE04R21DMzNE?=
 =?utf-8?B?OS8rZHFnN0JaQ3BwcUFod2ZJbnVPK2hzM0Foa2RoYmdUL1BkZGVFYXAxZG9D?=
 =?utf-8?B?UGI1cmZZbkFGem9vM1g2dktLdENCOG9LVHF5OXJzMVRvUDFWR2VOT2RWeHZo?=
 =?utf-8?B?UDRKZFQybFZGTFp0TE10bTMxdnkrdWpzUHc2WWVVN250SXo5eE40VUk4aDlH?=
 =?utf-8?Q?6RFsoSTe2QVgGzPWotlxkdGTc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44418d21-a3f3-414c-a017-08dd92bbfb71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:50:23.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sak5E5lvdMeru9+s7ti5ws25AtMcBzxxy0C3VNd5g9jO1aRFAfJ+PfqpajQ88jx7CXIsGw3qUBfJEc04loo7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359


On 5/13/25 19:27, Cheatham, Benjamin wrote:
> On 5/12/2025 11:10 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Set media ready explicitly as there is no means for doing so without
>> a mailbox and without the related cxl register, not mandatory for type2.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 753d5b7d49b6..79427a85a1b7 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,10 +19,13 @@
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -43,6 +46,30 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
> You have duplicate lines here. I think I pointed this out a couple of
> revisions ago, but it probably got missed.
>
> Thanks,
> Ben
>

Hi Ben,


Yes, apologies. I missed this one.


I'll definitely fix it in v16 later today.


Thank you!


