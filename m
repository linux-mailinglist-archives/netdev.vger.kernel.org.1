Return-Path: <netdev+bounces-118364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7795162C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2251F240D7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC14D8B8;
	Wed, 14 Aug 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sp956Qxu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD213D531;
	Wed, 14 Aug 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622939; cv=fail; b=c5ksRkxz5b1aaJG8oQcCdtmpDvis50J+hwD5Fl8m0+ERByQb17tETzM+rKzD4QBzeo389RHbNiNy707Wjy+eBgXQaotdx0q4FaPkmorlZRJvVYLwHq/2bDyrThJYYjvS40fwz4YsJH6V2kUS5na2tX7h194sG8xolsH0dpJWuZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622939; c=relaxed/simple;
	bh=nqsEEsExIWMu1aNe06R6JGvWD8b55Jc40rXyGMF7WN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWQ2Nx9wVjIaymoXlQoG+7zBtYrvi3+RsJmGP7kGpzN8M92rCH0TGQU/pFeYuNnrNg6FFL97DDxVH/DDiMsj/YxBrA2uHvbzd7dznLBFAYTuEF7apQjzdILDi9IR4iDPHDuP84WEB1DEcNUefuAvaxEto3k2NXD9JUCAK0QW/Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sp956Qxu; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK/XfORQcIqGkR56RbTvrWtCXwPNX5wJgTX9KkG9YI9NhX6K/q8Ja7bE/aKubA6waaRDQj/W6znCgKGuq0EAIm3I7nISMjmxnLzCCk0xJo+9b7d9+tMJSESf3t6J4RgQqCaw8sqn844ywL7/UxYt+LhZyxe5hWRnDD1U4C/NJr9+uDpdVtmZH/KPZcG6UDczAUzxcQsQ5ZzlS/6jHPokUdkr4pGyIcA04hqzpqBSacssJ89gXHGWg0RXVolwjgZsg6TcvFOTV4LUpqYleVQdXMZU8K90OshtwwP7wfb/A5pydf9CvpU8qMW9DeQKWCJ5aEeXGlgih1UXc1SdVUYs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYsrma2Cjz7TlZxKXsoibXF2PH9kvNDk3S+Yzh9JxGY=;
 b=KlUULTTzvPmSkjBYb78I01wpR3Oisva6DTS8LG8MdRwq28hgSNYnVf9Y3kwGW4sMqm5It87oIuxyvnMsdKGzjLn7IwmhF8fZN/gzX500WzAnJbjRkmHADNmBInfmq/3wjiJET6FB6/YnDgMW3fQ4qEGkbv/iFvkiXzqaIo9BKiswJiCBli0ruCm2cyb/R87ymjqvsaIVnvWQ0Q9saNI1NedV5++Ssrd/oaUGjaXhz2DPGK9gIwYeRh1/UgIciCXhM57ofV/Lb90Q0pYoYTgtUlkXRatdoBfHfJCeqYQ3AOQdBCw26cmhgtLKjtWAS04Nkte+kaWzC2BiO5dWbK4WHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYsrma2Cjz7TlZxKXsoibXF2PH9kvNDk3S+Yzh9JxGY=;
 b=sp956Qxu3Q/tg9LevszeE02JSgBtJ9u9w31v5fVnbQVAku+cCLusPXZNBvhD9KAl+cYmnDHIhQbg+ozX7sAO1cqqMTM3+C1SaP2gdkCqrKHtm04M3AkIkjLm0BzIv5SD/NHsjGgEBG+L7iVBJKa71W5qgtPdM9nY57tPlWf4ULM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 08:08:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 08:08:54 +0000
Message-ID: <f561c01f-501a-dc00-55e8-eaae0a4305be@amd.com>
Date: Wed, 14 Aug 2024 09:08:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Dave Jiang <dave.jiang@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
 <abff9def-a878-47e9-b9c8-27cf3c008c29@intel.com>
 <20240804181654.00007279@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804181654.00007279@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: ce93b9f3-afad-45d5-d06f-08dcbc3856ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmZHd0ZBd0t5dEljcG9zL2N6VWQxcDk0K1hUeEg3UGhheThJOXMva0NBbkpa?=
 =?utf-8?B?ZE9COUlYVXVvME9rdEp0T3NCbG1lUmpUbzVhZHMzYU51OUUyU1dRaGIrMzJC?=
 =?utf-8?B?c3pQTTlEcVVyMVJ6Zm82Skx3M2sydjNCTGJicHE1ZHRJZGxBalBNcGZiMlJU?=
 =?utf-8?B?YkNqQjl2Wmpxc05jNGNXdDZDMDh3M3JKbG95VmZhSHhOUlN1UkEwNXZ5Vkpq?=
 =?utf-8?B?T3VMTU9DSkQ5am8zdWdNaEdYNzlSeit0K2lRMkFSbFJndW9UOEhmbGU4NFhh?=
 =?utf-8?B?SFViOHhFbDNnTHNXUDJmdE5lYUNTc01WTmRyQmNxWTNyelIrMzZCVnZKVXNp?=
 =?utf-8?B?WTRFRGZFdWYwZmgwcGk2WExsQzN1cU0rZkYxbEZVVE5xdWpmNjVVOWdWWVJ1?=
 =?utf-8?B?N2c4U1R6ZTZJaHo3dXNoZUVORDFlOEo3d2xrSUtEa2dpZ3V6Y0EwalZ0RkV1?=
 =?utf-8?B?czlNV0R1bnJRMStDck1aWEFxeS9ybzFZeHRFalNBYjlsYmdtcDZCZmpIbExI?=
 =?utf-8?B?LzJaTElyKzdJcUkzY1hUMzlqNXhxWnFYWmlNTzJVaHVtQStiNjE2ZHNwSU1Q?=
 =?utf-8?B?K1dMYWFDTmkvazFPYTFVSjdzS0M0M1RkMUN1RURTWEw5TUpSc05MbFAraHgw?=
 =?utf-8?B?ZThPRGJVL1NhdHJtSkQ4SERRMTYxZ3owQXNBeHZBSnpDUHhRNTBmYTFGeERj?=
 =?utf-8?B?QzRCZ0tQQTVqS0cyNitRaTNwRXhKOGErRHcyM3N1dDljYllVMFROTWtKRUF6?=
 =?utf-8?B?Y1JDN0dLYnZ2QktMNEVoSU4xaVRCYmUzd0xzL2VnZXhDb2lVVXpQSEJDbkNC?=
 =?utf-8?B?cTdLeDBCSUtaVm5XNitpcDVIRlJWYURPclI5VEdJR3oyVUVwOUVyN1NGdDdj?=
 =?utf-8?B?ek1qdVdJL1ozRUEza01ZUm5NaGl2QTQ4djFpRlA2T0o5M0RELzhSVHVVSzVO?=
 =?utf-8?B?emVkRVBlVis1ZVlMSWE3Zkk2TEFHUVlkR2t1T2hMaXN5WEJlbFB4VUg1RmU4?=
 =?utf-8?B?MEFLeVFFWVJFbThOQVZYLzI5SVJETFBkSVg2NnI2d3o2RXJyWTNEaEM3MGpp?=
 =?utf-8?B?akFMVWNZUHl3UnZSMzVyaGZ5dmIwbW4rOFBzSUFVdm03d042ZW5QbGEzVmMy?=
 =?utf-8?B?TmJzK3JwWGhMWlMyZFpyclF1dkFBR1VwRFdyMEJ4dVZsUFVTZ05YK3dQcFNn?=
 =?utf-8?B?cE45WkduQkVxSWkvbWZTUmlRemZFdUFhekJBNGJjT3BXaTRUNFRTVWw4MjRO?=
 =?utf-8?B?SWcyL2hOTXpxRWZramY4OXNuK0J0MGR5dVBhMmM3VEphdEp0M2pDUUpXOG93?=
 =?utf-8?B?a0dwZEVzT0VSc3dWVWp6cjkvZG1MWWZwaTNiMDVxcC85T3NRSXRmbGlwM2gr?=
 =?utf-8?B?Rm9RU1RIWmxHUkFTMzZ5UDJWN0tRZFdKZFdMc2trU0ZEcFRLTHRJaFNseUZC?=
 =?utf-8?B?dFZhdXQ1RVBVcmVpblUySUtvaGpnd2xsZ2RzUkhwN0xyc0l1N3hqZjd1UDZT?=
 =?utf-8?B?SnA4OTlEQW1wWE5jbHdqT0xqU1N4a0hRSDB5ZXFVTDI5OE05eDJSZVdwcGc1?=
 =?utf-8?B?TlJNTHM4Rkd5OTVQbEh4WUd4aWFZcCtneDV5QlZ1di9GNnc4OTFSYit4aXhi?=
 =?utf-8?B?QTBZYmtjMjFPcW5XWURmU2JFMVZkejhHbTN5bHE1L0o3QkxyVC85YjVrdEp5?=
 =?utf-8?B?WC85QXh4ZUhwdy9ndUVQTGdvVUsrcnFwcEtlcmN1cnJUVUxWcTVnRm90OUtF?=
 =?utf-8?B?dVdQV09DOVBYVHppSFNlYmx6c0h2eHc5S1h2RmlQWnJFRThmeVoxQnovcXJ3?=
 =?utf-8?B?UUhXdGVkc3E5bUd3ZjhMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTlPQ3Zvd3dEeHcyanA4ckw5WngzM2VtdW9tTnV2VW12aTJSVU5KS1Jjd2Fi?=
 =?utf-8?B?ZGF5RTFZQjVqd3c4cHlzVXROOTAzcHQrbWlYaTFwVDFWdkdic0l5VWpNRDVp?=
 =?utf-8?B?a1c2YUsvcTBldXRjMStpeXNpQ00xWldacG1yc3hoWmttbWIwbmlwMkQvZ1lE?=
 =?utf-8?B?STJreGNjRGxoV3FxMXRMbDVIbmtqV2xsQ0xrbHEyOVVOVjMvREZuQ1hiRnhq?=
 =?utf-8?B?Y1Z6bEgxcmdZZ3oyUElwdGpUVnBIL3FKTXBaVzAwYkd3NmRYWFIwV3JJdmNJ?=
 =?utf-8?B?UkhGVG10L043TXpmTG1UUVF4R0lFeHl1aEplRXpUbWI1MEdFMFdDNTFVMkU3?=
 =?utf-8?B?eTlnNWY0RWFrY0JDNjZlWlQ1b3l1Q0FMQlVkdnAvOVhoSEEyOUpnS0Z5ZTZG?=
 =?utf-8?B?Y1lKbzlMWkhOaXFCclJCOFNQZythS3hQR2J5SkpZVG1oWURtK2UvYXBsUjVP?=
 =?utf-8?B?eUhyeTk5dzBwTk8xaExObDlDbjNabVJXVjlHeFZlUTk1bGczc0VQRTlaTzBC?=
 =?utf-8?B?Ym9KbENHUW9EVThWSG1PcmhQTWZFanJpZDJ1VHdJeG82ek1pd2FscThlMjQr?=
 =?utf-8?B?UGMwRVpoVVhhYWJjWE5HR3JVcWVaUHArampQR3JpeUVQMm9KcmJINGNUaWJH?=
 =?utf-8?B?cTdNMW9jYjFscktRNWVsaDlaenNGNlFkWGJLdkh0djhFV05TcW10U2tBQWU0?=
 =?utf-8?B?UUhUQUdLWDY2eDVHKy93a3FvOTI4Q1hMUStHcmNJdHdGQ1JKUUh5V3JZbVZ4?=
 =?utf-8?B?OFAxbjVXK0tZYThRVlVNZjJoRlRSSmJEVklpcVdOWlF5ZmtwT2Q2MXorUCtQ?=
 =?utf-8?B?bGZzd0JRbWhPck9paVREWFllRzVHdU9tZlBwMGc4a3FZSDMxUFdVMngzS1I0?=
 =?utf-8?B?MWd2VjZFbVdCM2x4N3F6dk5hemh4OUxFd200MHpxZnBMaUt2Nk5Za1NsY1Uw?=
 =?utf-8?B?LyttSm1LaFJPaG5DYURoV0hrSjdCeG44Z3hCbUxlb2VhVjVDZWlqc1lZVHhk?=
 =?utf-8?B?TTVhOExUWVZQZkpQemZTdTUxSjdOSURtR3lmcFo1Q084b3NFeUV6c2R0ejVn?=
 =?utf-8?B?cTlnL0Zkd0wrZmZZdVVsNC83empwQ3cvVjdXZ0IrVUo4UDVJNjNpYVl1VVRz?=
 =?utf-8?B?d3EyV1JCUEFXU2VHWnRGRWhBVUpLWVM4S0JNKzNjYzVmWksvazNsWXMycXJz?=
 =?utf-8?B?Znc2QnlvZmtqOS9KeGhiTWRnbzRlbTh4MnU4WE5TMnZLWTlKenkvQkMyaUZR?=
 =?utf-8?B?Ym5McU9hcjFNM0xQeTN5cHdFeEVCZGRvVlVnNC9FRFR0V2Y2NEdlTzhqR1p1?=
 =?utf-8?B?emVEUS9pQUlxOGQwWEZlN0ZvM1RyemZCdU0wbElseGlFeHh0MmJTejI4dE9V?=
 =?utf-8?B?aGVSZ3B6cW5JL0ZjZldTSjBpUi9rc2FCNitSMWJaRW1ZbE45WmcyWXBSYWxh?=
 =?utf-8?B?Nm5ZNFJONHlsVjBDNlhzUzQxYXlPQWhsbDRTcE9FeDFWU29qZWJEQ1NkeVk2?=
 =?utf-8?B?YjNjYndmWWZsYXV4S2tGZDFSbnppTFVSYmdXVE1IOG9oaE9NZXZQS3lITUND?=
 =?utf-8?B?NFMzT3BnUmtwU0dRa1JIWGZGQmpEcXV3R0crcDl5QzcvVlNnUVVkMW5aR0Ux?=
 =?utf-8?B?NkFRd3ZhcnRLSFYzS3o0enppWGU2dk5ZVjRpb3NQN3FhR29TYW8vVlpSbmdC?=
 =?utf-8?B?bzdERTZFMDlMTVE3aUZvcm1YZ0N0dUpjWmRsdjZZMk5vNEJvRmczeXBKN2E4?=
 =?utf-8?B?Njk0Q09HbjJPWDlhTDA0bXUzeUlGWC9mdmgvV3o5RHRVMTNUSms3WkZ4OXBo?=
 =?utf-8?B?djMzUUFsYmwvQVl5Zit5MEVaT0lKdzJ4SW5GK0tUUTNMalhFUitkVmNvR0lD?=
 =?utf-8?B?RXlUemZwK0VWaGpYS3VMSUVmeHhuWjdXbWhyRWwyeWpQdm0zWU8wZGVDeUx0?=
 =?utf-8?B?YW5Ba1FUNytNSVVUOFRkZlNYK3dCTVlpU2tIMFFzR2ZST3JJRU81QnBoSUpz?=
 =?utf-8?B?eG43VXVURUNvMU1XOHJDZ0VEeDhGWnh0SFNHc2FLRnRQZm1uWm1tWUpkdXUx?=
 =?utf-8?B?TmpCQ1Z2b25sYTU0KzNBRjMvckttQXEwVDg2blVZZWd3emljVEJFVmdtKzN2?=
 =?utf-8?Q?Bi8w/7ChUomQTHIHfJk+KhL2s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce93b9f3-afad-45d5-d06f-08dcbc3856ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 08:08:54.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCSZ/4jVJqE+wC0MF51/K5eUSOdLcGSdk9jtMcqXBla9D0bcttfUvGomAsc67IhAEbmtdZwdOGzcUF8HK6pEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612


On 8/4/24 18:16, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 16:36:00 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Create a new function for a type2 device requesting a resource
>>> passing the opaque struct to work with.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/memdev.c          | 13 +++++++++++++
>>>   drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
>>>   include/linux/cxl_accel_mem.h      |  1 +
>>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 61b5d35b49e7..04c3a0f8bc2e 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>>>   
>>> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
>> Maybe declare a common enum like cxl_resource_type instead of 'enum accel_resource' and use here instead of bool?
>>
>>> +{
>>> +	int rc;
>>> +
>>> +	if (is_ram)
>>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>>> +	else
>>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
>>> +
>>> +	return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
>>> +
>>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>>   {
>>>   	struct cxl_memdev *cxlmd =
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 10c4fb915278..9cefcaf3caca 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
>>>   	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>>>   	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>>>   
>>> -	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
>>> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
>>>   		pci_info(pci_dev, "CXL accel setup regs failed");
>>> +		return;
>>> +	}
>>> +
>>> +	if (cxl_accel_request_resource(cxl->cxlds, true))
>>> +		pci_info(pci_dev, "CXL accel resource request failed");
>> pci_warn()? also emitting the errno would be nice.
> Don't hide it at all.  Fail if this doesn't succeed and let the caller
> know. Not to mention, tear down any other state already set up.
>   


It is obvious I have problems with the way errors are reported, 
specifically about what should be considered a serious problem not 
expected at all.

I think we can expect some unexpected situations with the novelty behind 
CXL and, indeed, Type2 support. I guess a good approach could be to be 
chatty at this point and refine the way these errors are reported later 
when the maturity of the support and our experience give us the knowledge.


>>>   }
>>>   
>>>   
>>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>>> index ca7af4a9cefc..c7b254edc096 100644
>>> --- a/include/linux/cxl_accel_mem.h
>>> +++ b/include/linux/cxl_accel_mem.h
>>> @@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>>>   void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>   			    enum accel_resource);
>>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
>>>   #endif

