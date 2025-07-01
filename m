Return-Path: <netdev+bounces-202954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9CFAEFE7A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D089188E83F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7E2797AC;
	Tue,  1 Jul 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqUFvrVH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5A1DDC15;
	Tue,  1 Jul 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383864; cv=fail; b=EoQZsRTNhosSPGFyUzapjBeoh46l0cFeiUANhL/4wVbdbw7PrE6MatabzrtCrd/lLIAZ1uHt8u9FgzwEsE/rEmqHXmfwA2Ri4iOinf7Xh+vZc2V7Arg1N3LbzPgSuxZJUPxxbBM/TQ2VLUQRUlVrVMKej9j85gj1qwtMCaEOAy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383864; c=relaxed/simple;
	bh=XzDPyuFjRXuWODKUfaEj0RqoyshwrZYNL0wRkpvGDI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vup6jJcgdnsx8WwzCdfVKuHytTC6wOTfYXGJaxNxyUHvbGpD+RnuQolAR3teuUYS+fhtmhBMt08XJr1ke/P25WSTZl0aV36jNsO41ozkcQ2rCKYEm5O2LSNxhnb/5GbJsaWmS2e36T2DiN8XHW29/OEyvgU0DrSTrOhadnQRcRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqUFvrVH; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGilQo5KmnDZiZg4Pn5S5IIhs3cHISnnlY/jSUJVvvXkMNG993eQOfRJTiU2Ogj+ld3DtB7+tXEA+1t+EgeePLbJHWrChOcBnRRVvPwmw/Vsf7XyeWb9JeV8idlJQTu7ZU2Pf7s2qzmhnKw4oA/L8X+dr8uq8fIZNaVhQfLioyiDaepS3owBUzUYBM5uM4WvLD/PtvdZqqBfEJVLxITvubzYcX67xKQFO0aZPKo34y950Nmy3bCC/gQWDLNB76Cs2WSJWuI9pRaFcLMkSv1z/Wo7MOfTGtQD/07w/GvWG54WyhMNZTiotSSbKyqg2ZpIj9rEc2mP6MEDbcudHBkeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzDPyuFjRXuWODKUfaEj0RqoyshwrZYNL0wRkpvGDI8=;
 b=hfm7LLQY8e+OqkU79IhYwceZhvRN3SeaEWM4qXLtQmI1mzIJCpN53iK4jV+iG8VsPy04+kFeuIhBoLduyljn+TRFs7hSKS5G/exmcllGCFoWSvHjZ6dOg810K+L6QJcpZuxpGfq/S2V/W2+8+90l9d4cwgDfv4H3rIEdsGuGCfeCAtk4p8efVQrr6ajLavHVn0Ceool7UClRMOfmff6qRQ5vsRVXWxFuG6kgRUViXLvceAQ0ADJBgJolgV32wAYRv2wxI1P+e5jfxpgu50T+0JNfvJqFrnJVa+A63q89uTjbKdELOLPCHblDrZdrp84Sy+nH3ECYWxCR7f+fsuOywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzDPyuFjRXuWODKUfaEj0RqoyshwrZYNL0wRkpvGDI8=;
 b=uqUFvrVHOrxqHbBKM3g9fYXibv8jygmmfIKjXZP3keSznabBnrL+RB75TSvOVPZ/tzfFxmRiSJpMcKSyfcapdOKAZTVr9PJSRqx9yw3Ddl9+mlaJ7sESrRNM9ELvWTtuK2/6i2gbdn3h7oFhUw9W17xgQcL6hionDCARlVGfbZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 15:31:01 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 15:31:00 +0000
Message-ID: <ba684c79-d073-40f2-979e-4535db3ab8b9@amd.com>
Date: Tue, 1 Jul 2025 16:30:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <20250627104233.00005c5e@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627104233.00005c5e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: a68fdc8a-5175-4ce4-e8b6-08ddb8b447f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhYOXNZc2M3MFZKZTBvMForTm9ublljTld3NnFMK0ZzV05xemtISStoaEcy?=
 =?utf-8?B?Q3FUQnNycHNlS1NKZEx6ZVhCM0w5dlY4S1JiUWdnemJCRVlqOXFuTGZwbUVs?=
 =?utf-8?B?OVZ1enJjUzRDTXp6Y0xTeS9tOHZmenBMVGxiWG5iOFMrdDRSVE5FQlJ1Q0la?=
 =?utf-8?B?YjlsQ0ZWbEtaUkp1SnhpMUx3VFNkT0FnZjVWUG05eURWeS9tOHNwSk55aW1R?=
 =?utf-8?B?VjdyRzFGSjR3Rzg0dkFRTzA1REJGalNXbGI3eWMxdmJDaTYzcEY3dkI0YXFv?=
 =?utf-8?B?YXRCT2Z0NFpTTlQ3NlZ3R25MU0l0a1dkdzVwUHRXRUl5dFJrc3Fvc0k4RnZY?=
 =?utf-8?B?SkptTm9EZkpLbXVLYXFvVWdlK0lJZVlIdmRLYWNPbUNLWEZlQXZrbXRiUTc1?=
 =?utf-8?B?b25xVlkvejBDeTZHYkJ1VERzdU9zUDZ4VTN3c0RrcnMvaDlzaW1EZGdoaWtp?=
 =?utf-8?B?cXhsZDFLc01DQVBzcGNsN21FSHQwYzF1QjRQbU85UFNyV01rN3FiZFNPbWV0?=
 =?utf-8?B?Vm5uNkFMeFRjWjRSM1N0UVBzaGFvcVZLWFRPZlVVM1kyTXFSR00xL3BCMnB3?=
 =?utf-8?B?ZTVWdS83RXcwdm8yZWNhWnBKaHRnbzVyajVOUmV3YkxOUG95dFY2M2JqK2Jv?=
 =?utf-8?B?d1k3T1pPbTVzU3dIeHk2QTJVTEVRdjdZRVVWSkpVV2ZUaVZqMTFxM1VBMGdw?=
 =?utf-8?B?UXN0bGZVSzlEYW01ekdxRjdndEtud0dHNElMKzhMTTM3V21obVkxSCt1Tzkz?=
 =?utf-8?B?bkg0Qm5YczUwYVBOemVMa0RWQy9RSmZCTW51cit1ZTg5Ums4V0lvYkV2VVZr?=
 =?utf-8?B?SmptSUxDNlRiSFNiMmMwSjJ0SGR6bmZYUjNONWM3MG9jbzlKQU96OVU5dFFQ?=
 =?utf-8?B?MzIwbTJPU3d4YTliL2J1b3ZicXh2TncvUUIvc2U2em54Q1Y1b2luRkwvU05Y?=
 =?utf-8?B?RjlhcEVWOWNOVjJ5UllPUS9hRjVSemU2Y2tramRIMXkyZHltbTBxb1pkNjRO?=
 =?utf-8?B?Y0hFVUNneTVPdlViSEJycHRvOUZOQmRMTW5uWFV4QUV0MGJVcDVtZ0ptT1ZK?=
 =?utf-8?B?amtWc1F5NzVRaWtYbTh3cThrenEyN05aQXQ3Q2YrTVFkclpqSFhCM3VlcHVG?=
 =?utf-8?B?c09JWkNzM0VCV3RQVGZTL3pidUNhZWMxK2duV2J0d1laVDRBMjNUa1FEZ2E2?=
 =?utf-8?B?aUNHK2crRTJFWlY4eG9oZ21NZ1N5eUo2U2NiQkR3VmJDMm4rZ0FZTkhBTTM3?=
 =?utf-8?B?MTBESmQva0pMQ3FTWjhLSkZzVW1mTWs1R1ZUTjcwY21hTmcxbTZmM25iTVFw?=
 =?utf-8?B?d3ltUmg1S2NhdFM5RGx0NlVLekszN1hhbEtqNWxmRXgrYTNlVmRzVWlHdUtj?=
 =?utf-8?B?ZTlsQVNGSE5sK0VON2ticHh3dXhjZ1JzTml0aEZHRXhERlV4MWI0ZW9NVEtW?=
 =?utf-8?B?TW9XcHhYNE9xMmNQN1F6elorV0txMkN4S3phQ2RsUzU2WnA4dTNUTVRQNytl?=
 =?utf-8?B?SWRuS01XbFRnbmM3NWhJMkQ3dHZFcmNRNDU5YzlHMFArQU9FZHJRVWxiNitG?=
 =?utf-8?B?SW1WUmh0NHNJUEF3OUVwQVNwY0doZzM4bVNxOUpYSDlCYlZsUFFmQjVRMHY3?=
 =?utf-8?B?NVhBK3ZteVk2UVNjdzNmb0F6NndLQVFnZldjOW9Sa2txU0VaanFBODBQczFJ?=
 =?utf-8?B?YW40SDliTThnVXFLTXpydFJOTDhnM2hycEhhbXhnQkNXS2JDZUpQNUpRNHla?=
 =?utf-8?B?TXdZNnVqd2lsc3l6UktGMW9sZDhyRVY2cjRFaklaalFlQWJvNmxFR3d2a1RD?=
 =?utf-8?B?MlRLdGFKdkY5UFVmZWFrSnd1YkIvbTB3Zlp6STc1ZklJRjFFd0s5clR6aThJ?=
 =?utf-8?B?N3l5Mmp1bUFDenU2b1d0QlBnOWhiUXlYNEtQdFZrNWdYdmtjTEFuUFFlbExZ?=
 =?utf-8?Q?7Hw7iB3eeVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHU1aGRIa2pqRGZtWVhvd1k1UFlzUTdqNVFHU1JCRHBRSUNlWHJLdnI1RkVm?=
 =?utf-8?B?Wmg1VGJTWWlDdDMwcTBXbjhVKzMxSzRzWEt4U1VhamFjOFZOVmJyeWZ3Q3dS?=
 =?utf-8?B?WUhHZFBBU0JpZFcxSUdPWFZaUTdUNHhWSWwwUnFidjhZblNpeEc0S2JMTHF6?=
 =?utf-8?B?bnlvUXg0UDJpMzJlWmJLTjFzOXpSd2M4T1MxSW9RR2x0SVl6Q1J4YWZFWmRt?=
 =?utf-8?B?VFlEKzkzaldINUpHajF2VUQycTJ5WGFyK2pqTHFhV2Zvcll5clZRMWhXQ2NW?=
 =?utf-8?B?elJVVVQyOGtiSCtTeHJOUm5kQU9IRVAycXI0Q1N1UFBDVEltbjZaZURid0RH?=
 =?utf-8?B?VDBLNW5VK3RRTzNkSEo0QktnQi9LNnhub241aG96NHo5WTRsS28zTkR5dVUr?=
 =?utf-8?B?VExxMythSVkxNU91bWRyMVNTbTBPalFxWnp2U0pneHVZUDdKOGVZMTlqS1N2?=
 =?utf-8?B?ZU9jeUJod05xQUxOWmpJem1vcEtIWVhyM0JVTXg0TW1ET2JvZ2Z3a2YxSmF3?=
 =?utf-8?B?aGVpckF0S0dKNmdzb0lnR2VDNGE0ZTNYLzhEWjhjVmFKOWgrWFJQUXpSeU4y?=
 =?utf-8?B?U1gvT0lTeTlIS3kxSDd2ZElML1RsYlI4cDJtZEpvbkdid0V3VnlIL1hPUlh1?=
 =?utf-8?B?MTkwaWRGV2ZqRnpNRUQ1QWtYcVFIczJ6N3B5ZnM1Y1QxRGlVOVU0eEs5TVFL?=
 =?utf-8?B?ZTBwYURhQ0krZCtBdU8xbUlVTEJ2cGVVRkZDZENpTy9DV1I1OUZ3NGJtVUg5?=
 =?utf-8?B?VVEwM0NrdWJKNGdGcFdmYmNxaTZQZmVwOVN0RUJxcGhkOXZPeFNEOFptYXNY?=
 =?utf-8?B?S01vS1pod2RKRS9XVVhxWUc2aUJtazNYZ0hRc0g4V1h4Qnprd1pnVmd2U29q?=
 =?utf-8?B?ZGozdkhIUW5TWmx4RW9RVWVtcnRKOXZVSGtpVnU4Z3JaRUNncXJNZkRDbCt0?=
 =?utf-8?B?VGpKOHVJM3lNVVVtSS81ckIraTl0RHBsTnU4S0lFWStkOHF1V3hMcEhaeFdK?=
 =?utf-8?B?WnhYbFNHbkVleFhnL3pwaHM0VUhXNGl6NXVOVjFZamxRUldzdWpzalk2a3Y1?=
 =?utf-8?B?cmxHTmszQitKWVEyRVZWSDdRVDNTV2ZTUnRwOExSQ09NQWdrVUV3alNLckd4?=
 =?utf-8?B?ZktGWVNQRTllejVRV2h0WVdvYlcvRHBtNTRGQUdpd3NYMEZxRVZiRCsxUXlv?=
 =?utf-8?B?RFJzcGs3MmZoZU4zYTVvMVhoL0l1akV1TE1rT0FodVl1SkljeXFiNHZES0xn?=
 =?utf-8?B?V1ozVzF2M2h1cDhIMDIydTV3MGtCZXdNZGFpSGw4cDFtZ3VubkN4ZXo3c0Vw?=
 =?utf-8?B?cVdFbUQ1cGYvV1FEVjVsYnJDLzhreWV6LzZIZU5VRlVZbkhNbU5xSjc0c0E3?=
 =?utf-8?B?aTl5OXozK2JZN0hZcStNUHVLdG1MVGc3b003WmFpeUFSVWFMZitXN3FqN0tj?=
 =?utf-8?B?dHJsS2o0OW5WRk1BLzhNd1huVU9aclEvVHFPK3duSXorb1JKaTlmekRRU0JZ?=
 =?utf-8?B?MmpESzY5SkRON20yd2dTd0JGeG5BTENtVzlteHkxbVorMmxiU0d5S3hYVjlh?=
 =?utf-8?B?OVJodWswYTgycWZzNVQ3cE96RTlRUytBa1dwT2ZrbXd2RGRxZVJMdjNJTDkw?=
 =?utf-8?B?YUFJOVFSVE5DQnk5elZaMFhjNDVEY1U0d2RFay9UNm5zUHB1WEV0YjNReTY0?=
 =?utf-8?B?MUxKRlpzV0Z2S1djcmNpYXFZSFJkcExVTUVTWCt0SDFETHd6VC9BbTR3STI4?=
 =?utf-8?B?TW1tSjU3cUNJUVF3OWlhajNqUHB2SlEyTTFoNnBOODNWQUcxSzRGY1ZHVWV3?=
 =?utf-8?B?L2pLelJrNVMxcEkwYlk2bW1PK3RXVk9uWXhhTW15YStsTWtrWXRTcjlLb0Z2?=
 =?utf-8?B?K1NFdi9LQWhYMEl2TEJmenp2UTI5L1lzWUI5bHp2bUxuTDNSWVEzdGdqWjhO?=
 =?utf-8?B?aVJ4cVRQSncrMFU3UldzcmhrT1dwaFArRUh3MzR6VjBSamk1ZnlDSSszVjZS?=
 =?utf-8?B?V3RoRGpMdFVQVVoyWkYyQW4zaUloMEs2Yjh4ejd1QkxDYmZLR1c0d3QwWGNu?=
 =?utf-8?B?SVVXc3hRYUduMlNoTmpXT0dxLy93YWJFQlRCdnBjb0dmSTcvSzFSbk1ZWU4w?=
 =?utf-8?Q?05koE3nAuQGTIhLn+QOA3d+2j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68fdc8a-5175-4ce4-e8b6-08ddb8b447f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:31:00.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGWWMGlZW6h69WDbmQYicCRh/ALUf7fj3JcDfZOf8hU0V/Cf0bb1FeJVsqR9BI2cYfVzaeKdofzIBROhPD/TPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294


On 6/27/25 10:42, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:43 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> Typo in patch title.


Upps. I'll fix it.

Thanks


