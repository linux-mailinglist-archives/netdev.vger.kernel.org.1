Return-Path: <netdev+bounces-159802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D70A16F7C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C11A3A152F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52C1E5732;
	Mon, 20 Jan 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VmQK2ErF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4221348;
	Mon, 20 Jan 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387893; cv=fail; b=Gfr/t+bhIKC955jYleRd9B1goEEGE0+M+KDwYkkEHcIME9P1wBrtxbVsBK6k2ZJvPus2uU+hWdPxRTC6vo1O2Os9R+QNIp8og6aorzCxyTptvmnfL7AaOJKG5NmrEL+9iHdIKO8CG+WFAVDbKq470JwbweHRo8APXOum8/KpiEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387893; c=relaxed/simple;
	bh=Dk3CstBK7aoxqcD/MOe+IvGcMl+6r18iLaa+KGeQ9a8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n5d+FClE+3zVCzNlR1RYHCXd02EUwl2nZMZLwnsw/M1jHz9az7sVIL0JSPvkdLO9dTXM3MfcwHnvf4WJqfGyhcEGjkyAV3PEpMbzzstsXGQBjN0jvxGfoGI5zZhEaPI5xMeu1ytR+4OyzXoZJANoWW/TYkEvqJgWg0G7XsySWcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VmQK2ErF; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNxKfXUiJxUetEAreLJODVcMd6uUxODgI3rHDAtxVrGlkd8FBvVwX2FSeGlYkBrKiVhqv3jLY9vK2RxcyeMXvTw/w/wGDDFtPwyMVmRuUpYcWu+Zot4M5+m7RnyfinzJ5ZtQtb20sLWnPyFTCZbc8AKZxCkVcSHOV+x2AJaef47VR5RpUWBndmJcuEOeg5NbJGLaUcJIkIwil/96qnuAIczN08eUGjFIHiE21yFnKJGSG4a0lKyms1a1R8g/yc4T+GtKrhFYKLZiNpfQox0+pL1+/9ug6SvYpCdQoeYmkUIp98hOTfV92xc4tY7FeiY9Og1unNNZ0NyxAtYWd8gV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml6NyhvGZxj7ITMPB98HcD+egtvNYEs4jKvE4Wjt048=;
 b=MGRVhs+/aY88TV1JXTs4xGH9ra3pkdO8K7XQT3wmePO78T7eOdel/wKUfj7AETVF7QlMwg/9g37+DaABE5jlQPtJsutwBAqyeX7TdTfoAI3a3g4YNah0n3YMtazjqIbs56SN1hYfJYizcT6Ygmj4qIp/VgguQ3cK/pw1HW1/OS23+pbebgxgdbLmoDfU49DZHCkgA/A/XZMLIkaoGuRw1rkdDHckVNtiyTxR6rlhaX/b8FYa6PDSVoegFRylwNomywo3b2Z6vT+pF2u9Jl/s7V/QXFJpWoHqiV5Wj51uljNc3GNRah6aTdeoGKjuhDEPcYpfA/Heaaq8y9ftR++PaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml6NyhvGZxj7ITMPB98HcD+egtvNYEs4jKvE4Wjt048=;
 b=VmQK2ErFdCTfhYUZRSwPY4LTD1Xhdlv/2KxkBeJVfU/dLzQjnDcjMdAHqJKX2hGnRUKRM+SqcEbZsV/xhbBKXZ0zZKcXTiJf7SkDtsNmNhqvDOOZTxztRpZJgqJL1iLMOeiYdrAzilMix8FtBFmC8ua7SCRwkZ622B+xZ4a7mIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 15:44:48 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 15:44:48 +0000
Message-ID: <02473860-3fee-00f5-1c86-1242c0bf42e8@amd.com>
Date: Mon, 20 Jan 2025 15:44:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 07/27] sfc: use cxl api for regs setup and checking
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-8-alejandro.lucero-palau@amd.com>
 <678b0997a360c_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b0997a360c_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0202.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: a79470e1-873e-46da-8ce4-08dd39695ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHhYa1Fxd01YSGNacEhlVWVuRnB2SWR6RUh0TnJnYzVvTWQwUFJWSUs3MEhi?=
 =?utf-8?B?eFh0VVVYTDM3NVlvYldnRjUxUFg1ZXdrTEpzbkJXNXVZak4zTWtwbHhteVJL?=
 =?utf-8?B?cXhUR3BCeHdBVVhxRlZLcDRBZ0pzMEI2V1RYdUo3bm9USU0xdHdRT2FkbTFp?=
 =?utf-8?B?cVcxMTZZTEd0UVJaMFV3YkZEUzRJRkxCc0RTZTJFR216QWM5UEtvYnRSVUI3?=
 =?utf-8?B?LytqYnpjLzM4cHNEbnpOR25mSFZkWmxKR0cycnFDOFlodnRoRFo4eXJnSjl0?=
 =?utf-8?B?V0ZGWGF2VUFzdE10NlhFQUFQeUxMbjNKUDhlWG55bEFkQnFKb1pOQnpsVkNR?=
 =?utf-8?B?UEtROExyVkNQUFRCL3l5Q3FiRTdnUHFTd1lKUVQxMnUwcUw0UFVESFBiU3hm?=
 =?utf-8?B?a3hRNUttNndZSnV3enRyR3ZlSmp3RmtlQnpvVzU1aWgvU1pwZFRvRmxKZWVo?=
 =?utf-8?B?c0R5Z0J0WVkydkI3dXZjdmFoKzI2TmRuYnZFVm95dmYzbXJHamxZcTI3U1Y0?=
 =?utf-8?B?SER2Mlc4Z0s0c3p5RTE0ZDRCSjY2ZjJ2Ylg4NTZzT0VpMkdiWEt5UlkzSWh1?=
 =?utf-8?B?VHFmRDFUUjdqaXpUa2gyUnZEcEhPay9WVVFxdkgxY1lpSDYxTGZGVlRvZElk?=
 =?utf-8?B?T3o0aHBjZE54OFUxYUZLWEtvTDBoVVZMNU5VK2NRMktnZWZ4NUJSRjR4eWpw?=
 =?utf-8?B?WHE4R0g1Tm5YdnhFcTVEaU1neEdOUk1kbVFBdFVTZVdnZ0lxcVNRaVRORHda?=
 =?utf-8?B?bnE4eWtuVStEOC9lOUFyTGkyVnBDKzYrUXcxZjlhaVZyRU1JbXRhWmh1bDhO?=
 =?utf-8?B?NE5CcVdkZUx4TU1SZjBOM3NDaElHSVdocFJMUmpFNmp1R3h3OVVPMEdaeUpX?=
 =?utf-8?B?NDFXN29GaE9FVVdKNTRENldkRnV2aFNnajQzT3NTK1BwRk4wNk8vYlJMZ3Iw?=
 =?utf-8?B?emo4ZXRIRGxWcEZKTnU4dmUra25XdzFUMVVqckF5Y3Q5M3R4UVYyYXM3eDNS?=
 =?utf-8?B?SzRuY2xqYmZkeHJscjI2SDQwSHFSVXBNeTkrWWtrT0owTFFnRklzdEJaa2R0?=
 =?utf-8?B?TlZ5VGMzZ25VU1kxN3VaTkprY0NDMllZRWNYMzBmUEFJRFNrZ1o4WkMyVXRt?=
 =?utf-8?B?RHZjOWdwaGFYQUJ0VFRMWWkwb2F6dmU0WjYrL0U5TGtjU3pYcUtFdnpYb1ZU?=
 =?utf-8?B?b01zQjhmTTV5Qjh6cDBsbmIyQ0ZEUlhVTjg3RE95clhpY1NJOUNZY1R3Q25p?=
 =?utf-8?B?UWxyajdDdERZSkRPeWl3Q1JXM21vMCttSTNtRkZ3amRSYTdiT0tMSXFrUk5T?=
 =?utf-8?B?Q2VReSs1ZSt5SnhyU3pwalVsZFNOcWsySXd2SVY3cHNtb3pTRzBSZE4yR25C?=
 =?utf-8?B?LzJ1eHMyeDg5MHQ4N0tQS2YvS3VIODRMMUtuR1ZDeDhPcGNBdjQwekdYUzg3?=
 =?utf-8?B?UnFLNGwyUWVFc0tydEpQanNqbG9yNXM4dGRoY0NuUVpxQXYwOFRXdFFSMmcw?=
 =?utf-8?B?dFRISXRoNXo3clRXSTIraEhscEpwaW15OUdPMm9KR0FRUjV2czVITUpxaVFL?=
 =?utf-8?B?cGp3Q1VERUZFTEphSzdoK3p5UE5uUC9oSUlvUXg0YVZLT3Z5RGhGRlJKckVY?=
 =?utf-8?B?d0lFRVRIVFhIL25tWjQ1UnBtbEF4QjlNRmpxem1KbG5YSkRkTDFNMUVrNGdl?=
 =?utf-8?B?MFEwdnFJR3cvRDhYSjMzeTdOc2w3TFFnS3hWbjRzNFY0aFN4dGh2NFFrWGFU?=
 =?utf-8?B?OFFXV2lmcGhDMklTZ3ZXa1NSVmhCcEc1cEZZQ0FqNm1tRFZrbWdhZnBqeHVL?=
 =?utf-8?B?dlpPZWdJZmxCakM1SjlyWUc3QXkrb0tNdjl0SHY4UFB4bCt3b1BYRVlzSVl0?=
 =?utf-8?B?V3RhMUdTTXZoaHNSaW01Ymo2TVNXVGt4eDBjczNQNUl1ajNMS3NGRFBNUUNm?=
 =?utf-8?Q?nQEzxp80NC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTIzajdWbGpXSytQblZLOFNNbFlGYUc4ZWlZS3NEZkhrQ3g2Zk5kZlFFN3o2?=
 =?utf-8?B?bEpMYzFseHNmZVRKU0N1ZnRuaVZMK1lSS200d1k4Q2Y4MmdWcVExWEVxUHJS?=
 =?utf-8?B?Y3Z2TzhlYnZPS1htK0tzb3N1dEE4K25sZFNTeitWbzVMQnJTSXlOZFV3cTNm?=
 =?utf-8?B?dUJkUlRENlNsaWgydDdMcktRYzZ5SmlaYUR3dTQxU3o4enc0SkhTbnNNVlZz?=
 =?utf-8?B?aXdTZzdQTWtubms0TGxuVk9BNnRERmQvdk82S01mWlFBYzNSNGZKYjNmelh3?=
 =?utf-8?B?TkhLU1hjRGlUL3hYYjFqNmxvcUJ2M3lHYmcrZzhKQmNVcjdmbDh4ejhnT3Ry?=
 =?utf-8?B?YkVieFNmVXd2ODJSblY4YjdkazRLb3RoUEIzbjZxOWE5cHNDMjJkL1pFcFpo?=
 =?utf-8?B?QnRHc1p4OURFajRDRUs0RnFoNUJSSWtPeUNjVVVWdzJQUm5BakNKUkx2TnV6?=
 =?utf-8?B?Z0JZYUNVYjBwMzJ3Z1dZMXYwSWV3RklvY3NnN0hpbEZkcmk2U09YcjVTSHN6?=
 =?utf-8?B?ZUhNL0QvUWZJZkJOYlkxTnJ5WGxjcTc4akdVTWZEUzdiNzBUZVZVTHlrdnQ1?=
 =?utf-8?B?L0VRZ29XZjJYSGczU1lNVFhDTmRhVkNjOTRwZGxqK1ozUjZZQ1JncVVuMHBG?=
 =?utf-8?B?NFd3cHJvcy9JYUp2NEVCZWhza2RUNlIvYUxaMUlLbXpzUDFQeUlOZTV1UlNU?=
 =?utf-8?B?K1k2R2NydnZwK2tOWDJwUWVTdTZyYWF2NjZMSi96blhqelFMSmliOHhsYk5N?=
 =?utf-8?B?c0trZHJCYmVXMm40eUlCNlQySyt5K0Z0QmZOcDQxaTgrbklscS9FYWtscU54?=
 =?utf-8?B?QnJyQndGN0hhUUIxbkFKUjhkWUxobS9EcEpDakF2aHFldVJEckxnU2dKcExo?=
 =?utf-8?B?eEc4cEZkK3FybXFrTUZaNm9md3FBeVBvRE4yTVZzRVFpSjdoT0lXd2QxRCsw?=
 =?utf-8?B?RUlxdUUyak8yTGJqRVZTOXBPNVFjVVQxYm1Yc2s4K3RlTi92eDkzeXViUlhK?=
 =?utf-8?B?cWtyUGROak9sd20wU01jWmpkcGUvMWszb3NCUW9scUkxSXV1RDNRdURwWkI3?=
 =?utf-8?B?c0t2UVg5MEpBK0k3bDNPNlMzRWFaOUIwWndSU1FtNkZHd0NiOENZWWxlSXhu?=
 =?utf-8?B?MERFMEp4NU1KUFhNanhhV0ZGclptODg0MEp3Rnd1RDZMSUUrZVprN0RHTnNs?=
 =?utf-8?B?NWlPKzdRdkNibTlxUUQzUkZDV3RKM29sWGJCdnB6YWlIZ1dsVHpFK0hvWjB5?=
 =?utf-8?B?Y2lXRmNVZVMxMmg5SUZJVElSYTB2aTh0bmFEUVowcnlCZmJXK3B1YVYreml1?=
 =?utf-8?B?d2g2cUdtejBNN3FyV01aS1JuVzJsb1dhTUtMbDhtTk55V3QzV2VkeDJOclRk?=
 =?utf-8?B?L2pmNjROK2pQb20rMUY0cS9ORitZbS9uZ3FJbis2cEx1VEd1QmJ2SWtQbEt3?=
 =?utf-8?B?WmQ3MThDd1JPQTc1WGxtdDJ2dkJwY1pXSjFqOHVYSnV3UTcwR3JWZThEcmtw?=
 =?utf-8?B?TTQyZnZhVkRydElJcUNQRU4rZGZXbVVoNnliZkQvUUpLM3JEeE04dXFXelNw?=
 =?utf-8?B?amx1bDY5dy8zMVVKSDlZREdhWlBNRDZhSTFLQUdXQlFvVmFkNDVsVFdQZkoz?=
 =?utf-8?B?U1hlQWhXU0psb1JocDd5Z2xwMHNNZWFuV0E3YkdlQTdPM2EwK3JITmZZek9L?=
 =?utf-8?B?NkhPVmUrQVV4SDJlbDVrbFhRMHQvN1RQU29VZWE1cm4vaDErR3RmTFI2MWw2?=
 =?utf-8?B?U2l5MGtzaENqU1JXelllNVZiNXI1SENvV25ENndMSFJSYVV6QlpTYWpqcWRM?=
 =?utf-8?B?bmpDMEcrMTRwcUllRVpxY2x1TXNqLzBwMm51cnk0ckJqNnNIQXlPNGtXT2J1?=
 =?utf-8?B?YldSd0ZOL09YTTkvOXQvNGtMZ1RiKzlXMmdOU2FSKzhoMlhHZ3hXZFd2TXpx?=
 =?utf-8?B?QVlEQkVWd0RFblVZeStMWmFpQlNnd3BCQzRJSFFwUHJreit5ZXdaWFpCOFVW?=
 =?utf-8?B?YnYrQ2NkQ2U1dEUvL1BLTU9kYzlIWW9nbmhvN0VPUUp3dVl4OFJGQi9HOWtZ?=
 =?utf-8?B?V2V6VHRDMm55T0NscXR0c2I1T1M2K2h6Ni8vblB3ZnN6S2pyOTVZY2Zmejh4?=
 =?utf-8?Q?btd5zTFW5DzqaMxtY41bzLgG0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79470e1-873e-46da-8ce4-08dd39695ea3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:44:48.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04EczQtMddfBq583WWMSvzon2gXbSwtMHIls7UsDcLzHVwi4ZoUiMnB8PWP6PKnIwuTHDrR/XmyqS7ND0wAwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758


On 1/18/25 01:53, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 12c9d50cbb26..29368d010adc 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -22,6 +22,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>>   	u16 dvsec;
>> @@ -64,6 +66,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_resource_set;
>>   	}
>>   
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		goto err_resource_set;
>> +	}
>> +
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_RAS, expected);
>> +
>> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
>> +		pci_err(pci_dev,
>> +			"CXL device capabilities found(%pb) not as expected(%pb)",
>> +			found, expected);
>> +		rc = -EIO;
>> +		goto err_resource_set;
>> +	}
>> +
> Walk the existing valid bits in the reg maps. If you want to do this
> with bitmaps you can convert reg_map valid bits into a bitmap locally,
> but that redundant infrastructure can be left out of the core.


This is the accel driver. Some way for doing this needs to be 
implemented, and although I'm not against solving the duplication 
between the reg_map valid bit and the new capability bitmap, an accel 
driver will need this piece of code or something equivalent.


