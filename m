Return-Path: <netdev+bounces-231960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFBBFF026
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFF6D35259F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9DE289376;
	Thu, 23 Oct 2025 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vM1trSYF"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6E2877E5;
	Thu, 23 Oct 2025 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190295; cv=fail; b=bWbMv2dYsYUVQguRcr3cDP1AxPftydzMZguh4uin2y9CgSIWrpJsnrMBXv6fA3cbDzTFOZEdL9dS++sHMEHPMC4/qORncieMmAkbu4VkTDCw5DNHUaqkKKSOLd9fPVNpNAVSMzy1pBn0Dd///IrmDWnUce59V1ggfth7B8l7ne4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190295; c=relaxed/simple;
	bh=6C9pyzj8UmP2V9O0BfXCYbn9+7nzzMgHrclAsjJXy0I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b07IWNavocxaLek7JyKau7IK25b/iRyQBOBMfv+CUTRyiHVKiNzHyRFxxEcXHt5twgPpUvKcsiQjCbb6H43y3bUQH7m+4tx1rlNGllAwzb76S7t295vkvW5CESsjA9Q0fpjlHUTIAiZ0osF6y7DE531IQaIsxIF+EX4ezfDVXOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vM1trSYF; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqKPi7X+wmq1gA3Y3WDAY3k+XGIaBNedg1AhGanN71WgIKiMw9srhwUH6jMEED/vf8oLHGjlmyfZ77HnNTo+DoKFn/DYoaOjIXlqKTfS9X4JIoVL1KeZbci39u1QD9VFRiincvzD/BEaeacH+5mkjHpqwJUTVgWB9OVfdgnPsuHaDl44r6PvVj7M2v98nqns6m3CC01skF8Gg9c2pvXM9n9FZL9NgFaMB8cIT3VTDpC9x1+YEi9jSIUN+OGu0WTcpnoLP2eSfgx3a6coOUcnnhbLEi2jACEgzJQ9gQz9jdcB3UdNBaDTnPlCQib0K6vMmY3jfgGpvTaw0dvmqOAtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCugp7k54e6K/4m2bHsd2jUY0f/rei0AMeohtcq527s=;
 b=EK17JHf41KjF5QeLlSgPgnUC7qk7UnFuEOOVixNHtmAtimPwCItBxdA5novYr23kfSkCVLig0m7zsospIVjFP3/kbLWH/HgRqyHNgDxYz/xea94ewKfv50YnNIgkf74BIv7eaRQ2ygQxTAAlI6oNF1Uc3zZq4xpoEOrxA8IK/vqepFSI+idkAy/Rj5PGjytDfGzWbE3oiNX1t+Efp05yDIbtS5vC0/iwy68qAx4jZ5icwoVDbXUyjjslkrcNpaUi3IZt/trOpWZCmHJgX3Cl7jZz8Uq4bRV5yupWcIK1P9mxWulkaQdDMY+YsmEI0/PTo83r9v2yqRc4j9UsAVy4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCugp7k54e6K/4m2bHsd2jUY0f/rei0AMeohtcq527s=;
 b=vM1trSYFKCZiHDImPaAswTO7o9SfxutpcVL/MjlYaONbmCs8VVBhqi/l0dJ/Nzd6ZckeOsLu7J+Dp0J5dmXu7BkpF4Fdn+iez7cIlLXJS6gS94RltE44c8lJLEUEdEYWBE1Zwu5GjnrKuFUyM+LhWOEOnsWsu2WsNX2ba0x6HEvHpqoL/jXNSxcQ3ccRklZG3DL4/VQDyOjVZsrwU2hz2uAKZroFYmbLVGq4yw2eZYYN5/lArdHSp+isKRWj2iPUxrlL/JtItM4OGDWnba4YrVqqD7bnNM2gGPjGD6Z0tDvR0dKkn4mdvSppkYyT1fjeADg4QGqcaLc5vO4qCyYdmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by CH2PR03MB5320.namprd03.prod.outlook.com (2603:10b6:610:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 03:31:30 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9228.014; Thu, 23 Oct 2025
 03:31:30 +0000
Message-ID: <1abbcd93-6144-440c-90d9-439d0f18383b@altera.com>
Date: Thu, 23 Oct 2025 09:01:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: vlan: Disable 802.1AD tag
 insertion offload
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-1-d3a42e32646a@altera.com>
 <aPI5pBXnh5X7OXtG@shell.armlinux.org.uk>
 <e45a8124-ace8-40bf-b55f-56dc8fbe6987@altera.com>
Content-Language: en-US
In-Reply-To: <e45a8124-ace8-40bf-b55f-56dc8fbe6987@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0215.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::8) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|CH2PR03MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 46510bcf-1cb1-49d7-22fc-08de11e4a7e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUYrL0R4R0RtcUd6dkVIeEFVRVNtZTA0V1daaHovanlQR0FaUVJHbndOZFpG?=
 =?utf-8?B?YmJPVzFFaVc4TVlPWi9BcXdZNi9XRGF5OEVjNlFzZmFmVzZxMjhVWFZVa1Vy?=
 =?utf-8?B?U29VK25xdExCWis3N2V6enFzV3E1Q1FLL3VsaVRwRlJNZVI2WVJrcS9UT3ZN?=
 =?utf-8?B?eGEyeVcrczVsdE1FckpvUVV1b2dTUTZ3VGUvUUY5NGQrMjI0MlJTUjAvRkVV?=
 =?utf-8?B?WkU4Q29EckdWNVk1K0N3TUFINE4ydGEvaXMxdE5MSnJaWExvejFxV1R6VUgz?=
 =?utf-8?B?VCs5RGpGZ2xVcGhLd3pUdkV0ajJQaGxnU2RUMkhIekRLK21BM3hpNHNQZE9J?=
 =?utf-8?B?cTFCdkJOYVBob2E5RXNGQlpsTEl3Y0xqc205amI0Sk1CVW5OR3QxQ0lCWEtE?=
 =?utf-8?B?K3VxejFhdU1CS29ZQ0Y5UmtFYi9GTUZsK3BaQ0NYMU9vcGRvYUJlZTcvdEJx?=
 =?utf-8?B?bU91RE9TaHZDS1FNeTdUZW94Zm1xMjQzaVl2dFdIbE81cENPc3UxQkpWWjdl?=
 =?utf-8?B?N3BlclBGSzFZUzJHd29WZUxuaW1ydEk3R3pCR3Z0cUQzMzNDaGVVVE44UjRL?=
 =?utf-8?B?RFQwRktMcUhYZk9jUGR1WXliV0kwNXErbHpXdFZ6L1VYS01rMDZ4aWhna2ZD?=
 =?utf-8?B?cTRLZ1pWZUJIRVFEU1R1OEJqVjhMMFJYZG5peGo4WDRXUkpqa2Fuc05Uc0tQ?=
 =?utf-8?B?WGp0aDNWMG1XUUdlSTNaWHBHcjJIdzMxcUVnRTVEbEtjUjJuYm12TDRKWHVw?=
 =?utf-8?B?YXFHeVBvaGdLMGtDUlNpR2tOa1lPbmJNdzZualAvN00xMU85bnFEUkI0RTR2?=
 =?utf-8?B?MUtkV2h3YXgrdk96dmY5YlFJS05tQnVQeXRjY09oTCtZbkZUQ2VPcE9tVGxH?=
 =?utf-8?B?Yy91dXdneDhMTlIyS0dTWm9Nd2JPVmN2TkUvOWhNdXVhaVZsVUVRNXh0M3VJ?=
 =?utf-8?B?VWduZUNtUVdMUXhaZGcrcHA2aUI2VHFoTEI0a3Z0V0tFWi9ESUhQcmI2UzNP?=
 =?utf-8?B?bHc1UGJDMzNlekdEZ0RvcE1qQjJaeCs2S1JVREdqS1RvZUV5UGRTRmlwUVFY?=
 =?utf-8?B?V01xUmwzRndrOFRURXRxb0FJSUxHNEYzRG15aVdPMllJMzE3NTBVVEdmV2ta?=
 =?utf-8?B?RWtWKzM5UnRvQkZJSnRBSGk3ODg0N2NLY0doRGswR2dQK1pyUW1mUG5hN3Ux?=
 =?utf-8?B?eEp6aG5lRVRrWEZtbFo1L3JJcjdWcE4xaUNhaS9LSkp6MHFxOGcxN2duK3JV?=
 =?utf-8?B?dUloTW50ME5MZ1pxTlVYZ1BlbVFFRlBWenBud05qZWJpblNodGtnazNGZXR0?=
 =?utf-8?B?anltSWNVN29sZVF4QnczTkk3UEhZVFV0SndvQlFtQ01UZ3ZRTnpLVnk5M3RI?=
 =?utf-8?B?bXBKakZZd3hVNXBtWVhKdzBOclpBeHF6THQ3WmxjOTNGcjkrOUwydUNlR2pX?=
 =?utf-8?B?VVhjZDZDL2E1dituWjNIcEpiTDVlZWc2czBzbkNnczVVYVhrWWlVYVdtRlJH?=
 =?utf-8?B?Mnlhb3VuZUltZVRsaE5TMUFDYUpjVUFHQjlpb0pPOWNGZzRCVmdlTUZjWXl1?=
 =?utf-8?B?alJkaXE0L1pFUUdwMCtVRmtvZitwcCtuOGVCQWh0NHczb3pqZ3h1S0ZEQUJP?=
 =?utf-8?B?aFBLMWE2N0M2MUhvNjhWa2t6d2lYVGlRc0dwU210SXVBTFduU1VCQ29FZDJ0?=
 =?utf-8?B?K09QazFXeXFhMXB3RVJJaVNkNmhiaEJzb2pCQjE5M28zbTR6enNkQi8zVjZE?=
 =?utf-8?B?KzN4NzBNclowb3hES2t5dTR3cURiYVZTYXA5VjQ0eDRPN0YveE55OFRBcEJX?=
 =?utf-8?B?c3JiNFpCZlAyZGtMMjhiQmh4azFzNFM5L3B1dWllUEJYZVRua0RpL1NlY1Vi?=
 =?utf-8?B?ZHM2cmtlSjFnMW13MHFlVTlXaktsaVFEQnBDSmZDRTRBUU1YT0dmN1NsV0Uz?=
 =?utf-8?Q?EYzK22oc6stb+vyH56uctXWiNq/NnRd4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZGVTloeUMrZVo4TnVsNkpIdnE3K1Z4UGhzbE5BUk8rNENDbDdMdDBCUmth?=
 =?utf-8?B?R3ZVcE81cVN5WGVyczlITnhZSk5aRTFDWWtNU2hYZEJocko0THFZbVFDcmox?=
 =?utf-8?B?V1FycklHV2VSYlRlZXBQbmxIanJLR21zeHVveHR2cFVKMEtuSmJhRXlNQkgx?=
 =?utf-8?B?STIyYmRPT0dzUjVnT2tZSk1ZOEJQUzlIU0xOZGVEZ0ZVU1NucWg0cUltOUlX?=
 =?utf-8?B?TWFybncwekpsajN0UTUzMWQvNDlQU2VNK3ZhMDgybGhYWUpGWkY5WW4zQUxO?=
 =?utf-8?B?VnN4Z1o4eUR4Q3NKSFVIdHFxaXZFd0ZTQjdWL0ZZeUNZb1JUYzZUaUFDSWRG?=
 =?utf-8?B?TWtDOHM3VlRXVW1CREllSXNnWTIrNDdsZTJ4U0llalRTYlIyT0xhZWxGdWV0?=
 =?utf-8?B?M1hST1drS3ludE5jOWJVSDVEMGwrSmJwMjkyYkhBY1dndjNpQ1B2b2JvR0VZ?=
 =?utf-8?B?Y2tDa1A3Q0lja0lQWjlhemk5ZG0vN3RhS0ltY2FGd2hmTG54U2pHUytpaHRj?=
 =?utf-8?B?TmF0RE0wRGVsUFFsdkJJWlZjaDA2QUpxZ05MbmtWMzdSUHhmOTFZMHE0SFNr?=
 =?utf-8?B?TzJ2emtDNmhtc0ZaM3NPd0VaclRKR0ZUZXc3UVFyUnJ5SW9GeFV3aFYrWVl1?=
 =?utf-8?B?Qy9CMFlhWFkrejdGL2prSFVyQWxWK0pBM0dQNlpLcW10RitaYWJMd3ZCZHJj?=
 =?utf-8?B?TE54YWZqMUtFdmUyZ3BnWmVHcHE1N1QyT2ZQWm4rZmd2anlzTFRiWVZVbDhE?=
 =?utf-8?B?RlhRbkhwWlFTYXRiWjEzYk1teFM2T0JsQVZRS0NvVlFFNE00S1JVTGcyQ1ZX?=
 =?utf-8?B?M0pJbkNZbnZFRmYyUUVWMGFJQTdETHM3OWZpbDRRcHVBZVJxQkpsb1dzdjlh?=
 =?utf-8?B?Wkc1bUFWUUtnVGlUOWVXVEFycEpTbWhUL0Y5akowdGYrejM3V24zOWQzWXc2?=
 =?utf-8?B?cUZZczRTS2ZYaDNKOHp3UzVOVkxtT3NYZXNwMmpqYnFmOWUvV2hVMVZTaEVX?=
 =?utf-8?B?TWRXOFowUUNyUUdTNmhSdDZlb05EL2paRVZkL1dHcktqenYwS0xzQzIzT29n?=
 =?utf-8?B?WXBTeUEzVUxLVGJjdU5MK2Vta0p4ZUVUeEw2T0ZjK2ZKdTk3UTRJT05WM2FV?=
 =?utf-8?B?Tk14ZHFSeU1kcWEyU01UekxVL0JPdFgraHB1Q3lIUVN3SE53Y2kvVjdMcGU4?=
 =?utf-8?B?S1VnVVVpb0E3OXlYZ0tDMW9JV3I0eWROWDNUdFB3NWtSdURwRDh2SHlpWEZs?=
 =?utf-8?B?YmpHRXJVR1YwbHRGeXU0VmhzaXpjbVh3a3hhZ3NxV2UrSHlkckt0OHhoTm5i?=
 =?utf-8?B?YStnbkcrVGIyaDcwNFVnTGIzN1lQV3ZhWml6VThNL1VwWjZhVW1BUS9TMUh2?=
 =?utf-8?B?dUJsMzU2OTRwQUpVRTZBRUFnU1RwV20wSElhQzBtbWQvQUNPV21UVkhzTzRF?=
 =?utf-8?B?V3pSa2pOQ1ZGaXJKdkc4b3BINVVlcWE0RUhsNTFhVllwRDQrVGU2QTEwM2xv?=
 =?utf-8?B?eHVScldmZmZGSlY3eUE1akV6Q1NDRFdOTko1NXhER2luNEl3NXNLYlY4WFEz?=
 =?utf-8?B?WFZLalMwOGRCei9rOFFVZHF1L3lYcU9CSXJhR2JaSUx2RzNvVXBXUnlTeVRm?=
 =?utf-8?B?VWJ1R3Z4TTExTTNVRFhGSmo1TWdyaERxVGVHUUdUd3J2bTdDMkYzaTNqQmZ1?=
 =?utf-8?B?UFh6aUFIM2hFVms1ZGpRS0ltUlltTlQ1ZGFmQ0s1WUJtRnYzMWZNcXc5clNW?=
 =?utf-8?B?TW5uTFpZeUVZZXJQSDJ5a2RBbG5ZcXNUNTBTdUNXL1lhU0lBajdLRDdhKzdJ?=
 =?utf-8?B?MkM3QUJOTTBSZlNTTlk2TDJlVjF2KzlUQmhSTTROaXU1Tm4wOXRGR091NHdp?=
 =?utf-8?B?VmpWMjNTS0EvVzB6WG42R0NManVUekdiZG1scTNqcmRuMk53bXBEeXlvaFhG?=
 =?utf-8?B?YlJ5Q0d5RDdGNGNHWmZmbklKempMd3pJcUlKVkIwSFNNY2VZSlRyZGpLNk1W?=
 =?utf-8?B?cEdOSUhQbHRFSDR5Z1NkeFphRTlmdGxpNHJEa0xmdjdGc3g0aXZMNWhoNVUz?=
 =?utf-8?B?VFJHTlB2a2xyMXFuVG9jZE45Sm0xdDJzUmJ4VCs2a2hyS01hM3Z2TU8wL1Er?=
 =?utf-8?B?Q3pXRkl1UlQ1aE5OLzJpVWtUYU5mSjQxdlMvUnJsM0R3Rk4yUk01MTZwK2JL?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46510bcf-1cb1-49d7-22fc-08de11e4a7e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 03:31:30.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SejHTIFWpu2E6vasuYgc0rwQZr3MkCrcXflN37KcjKON8JOj739ED76Nv4bQrcX7Qk8ZpZBFtn+tgpfWEJ0PTLpnIVa7mGnPXrk59d5RCg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5320

Hi Russell,

On 10/18/2025 7:26 AM, G Thomas, Rohan wrote:
> Hi Russell,
> 
> On 10/17/2025 6:12 PM, Russell King (Oracle) wrote:
>> On Fri, Oct 17, 2025 at 02:11:19PM +0800, Rohan G Thomas via B4 Relay wrote:
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 650d75b73e0b0ecd02d35dd5d6a8742d45188c47..dedaaef3208bfadc105961029f79d0d26c3289d8 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -4089,18 +4089,11 @@ static int stmmac_release(struct net_device *dev)
>>>    static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
>>>    			       struct stmmac_tx_queue *tx_q)
>>>    {
>>> -	u16 tag = 0x0, inner_tag = 0x0;
>>> -	u32 inner_type = 0x0;
>>> +	u16 tag = 0x0;
>>>    	struct dma_desc *p;
>>
>> #include <stdnetdevcodeformat.h> - Please maintain reverse christmas-
>> tree order.
> 
> Thanks for pointing this out. I'll fix the declaration order in the next
> revision.
> 
>>
>> I haven't yet referred to the databook, so there may be more comments
>> coming next week.
>>
> 
> Sure! Will wait for your feedback before sending the next revision.

Just checking in — have you had a chance to review the patch further? Or
would it be okay for me to go ahead and send the next revision for
review?

> 
> Best Regards,
> Rohan

Best Regards,
Rohan

