Return-Path: <netdev+bounces-206816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE1B04735
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FC14E02A1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F318270EBF;
	Mon, 14 Jul 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RCi/aOy/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A626FDB7;
	Mon, 14 Jul 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516581; cv=fail; b=CYRKeaghE2nmkNAyPw+Cw7jaPPTRwaPQTwunqe7FJamkEJUFTWM5JiwhxxhQviy4EWRxCYI0vCqsQAxAA2+Cx/STXqj8OC+h5LTyYbMD2B0QCaE4VVZ5KOuzLtWDG9FNuMMe2s/MHzAoGSsKraSGyos+WogZV+W6uhwIwQB8Z4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516581; c=relaxed/simple;
	bh=uOl0yZXdtVEOUi3qxZV72fxN6Mx8nhwyhXQ+u/NcbW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cSfbZqDQYq8xDwOzU6c0ECXLwpjjz+IBjQPnpSyxzLAmvCFozZLiCqxaF2Vd/FwYS9FRNbm7Cdt9Frsw1Q64ZnErtVTRzA1IlIEIRJhYlqGpA8foEworgP8h6dJgL59QpDEZGVCddJJbdX1Rg6Ao85jk2GHr61igdZI+HHFe8vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RCi/aOy/; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNTaSiwyquy0pSzvBva412O90ZezqkcApvn3TuasNZPQRQQbf8TL6krGROdI2rDB8GsDqAPpDsdwaa0VozdMe4CwWNn4IfrItsoEhFrC699/bMQuQyzTyz6VoXXfEzVrC3zW9zNpq7RKl0wS4LxWw2dY8DGqZGObKGkgtCj9L/x+RCHz/ggy0YDfgnlnkgOrAXxJ8wNWKhriO5TUJhFD693cBL2JwV/5Pc2A5lFJtTQTK6NQqj12Vgrpg+/TOaWgm1LrZPhphPVpEvV3SbLISXil23zRgptzGUvIvKt3WfZ5H/2BnRkVJj5cQ9Rgrwin+cw9NGV3mHmztbz3zggceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u22rXCMnJqLbZv6Jb4tiK+uZpfZ/89AM9jSJkhWINLI=;
 b=Xzk9MArZ2ZKI3ojPnMxdd6wQHbyKw1qyC4NUR1xZEbpb3ETbSboNPoZMIYFhSRbcc1nL/LyTShZFlx7uBiEfuxHLzLQ8J3ZcxNB8x6LXxn8kYg4Uu/5pm1Jmrq+gmpyx1dEdOtFZaxTl1deiLhzjn0Zafh3LpOpcWj7XHjEXQ6uQ/9T11GIFTcZ8N8+fHCre6AwEHSvzcr1FCqCzbMwSKIwL6NWHlyg5T0eFV6jbWYYZflypKgjhMVw5AFHSIdYKdLw+sThs1Hgu+hQ2OU3ejKoL0P4iK7fOn+/6dcNtzfqfrcdwV0KJk+Uhsfn+NSbfe9TUSZ2o+uPzR+KRLTAuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u22rXCMnJqLbZv6Jb4tiK+uZpfZ/89AM9jSJkhWINLI=;
 b=RCi/aOy/crxvhF2MQmUC06HQY6/PCGbrqv/hZE1GU/zTFuKfJ3nKzPf4qR2E6QZn9+/79T0oavBGXVApmaVVKePOa2CRpJV5QOLQ2xMOCoaqX8igJc6fCjnfoWpCJ7K4Qxu6rHMfPlF6Jydmx78nfprrINq2mytI5EiXh+UaaJK2pBhxMzxgtikeD/Pfi4XWD4R5PPmdB0RQA+Og8vJch+LTyunPcAVs0LaDrqfPM0po5B7CdmzC+dWYJws6izY4mCY3FAO6jacm4fkkx0S9mJAOY9gIjLbMmAXs986S9P15al3xBsPC/XtPoTiwI4nQ2Jvlc3/C6AMCiWjyNJ1W4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS7PR03MB5654.namprd03.prod.outlook.com (2603:10b6:5:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 18:09:35 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 18:09:35 +0000
Message-ID: <256054d7-351a-4b1c-8e1a-48628ace091d@altera.com>
Date: Mon, 14 Jul 2025 11:09:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
 Agilex5 dev kit
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, dinguyen@kernel.org,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-4-matthew.gerlach@altera.com>
 <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS7PR03MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebd96ed-088c-41d2-385c-08ddc30196dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUlmcTE1RHBjN0JuOWRiNmhoZmZ2MkJWTTNxVElIM2J4SXJjQVpTOGlFdnpm?=
 =?utf-8?B?OXd2OWVnWnJQQ0pLVEZYbkJiRWl1dG1FRng3UlFKTjVyRExzYnpnY3YxTUhY?=
 =?utf-8?B?RFFjVTJDNys5U3VQTzlQRklaaXJNclliem5ZbmVVR1RubC9LMDhRTEs3dmQ0?=
 =?utf-8?B?YkZQWk14VHJPQm1IdDBtdmZic3ZJN1dBRkV2SUFzZ2hJeGpWR1NweWh4TXBI?=
 =?utf-8?B?SENDR3R2NXI0VEF1dWVnbGV0NkJuWko3VjFVMS9BSTRVZXo3WWZmc3JaeEdY?=
 =?utf-8?B?NGppVWhKQjZIRk0rakhOYTJ1UVNVUk9jL0VKRjZhVFpKZXlvWXQ4WDliYmFj?=
 =?utf-8?B?Z2FGWWlQbWFsMVlwRm9jNTViTnZpQzBhQWw5U1k5akJTR1hEb0dvUnIzNHl6?=
 =?utf-8?B?WVpQaXZXdkx5cmY2RDVvL0s0TmpMWnNWTnV0dnZIZjBXQmtDUUFHbyszZ2kw?=
 =?utf-8?B?UnZEZXNUd01lYUIxUitJV28xSGFKOUszUm1zMUUwT2ZXSDFtYXczRFJvTllT?=
 =?utf-8?B?Z2xBdUg2Vm1lbUxBYU04VUtudGF0NFFSeENCcEZlUDI3cVVLcUEvWGhpTVNS?=
 =?utf-8?B?ZG56MzV0M2FTQitZUmc4eERCOU9ROXkxNlFCVFJBTUhnQjJBbjU4a2IxcTls?=
 =?utf-8?B?KzduOXZhRlVkeWRUMGpSWGlrSHhpTU5BL2tubDkxeDV4UVVONGFxeTl6eGMr?=
 =?utf-8?B?YjVkcTl3SnRVNHlMZ1FQMnVIeHJYSHRwRmVESFBrbklML3YrNjF1U3IwUFZ0?=
 =?utf-8?B?OUJzZVdtT2dHdG42RDJNYTJDUDVER0RFUVhWUGFibUhFQ1NoTjF5UW5udU5Y?=
 =?utf-8?B?YjBUclhhd2FpTG16Nzg3SFNaV0ZmNHdtRm1xNi9NdkgyL0xOSmlTSllkVjRZ?=
 =?utf-8?B?S204aWZsRnVVQTErSTNBOGV0NndaVUZTdFNIVFd6MENscGdWOEhHd1BnNWJV?=
 =?utf-8?B?MHV4ZkZGZ1NZV1NiVW9XSnR5VEwxMFFza01yZWFrbEZHeVJobVdUdzk5MFpH?=
 =?utf-8?B?cVcwckdVMDVERzV2cU1vcmJ2eEpyV0FoN2RGQkxrM2J5M1ozb1IyUlNxbUt0?=
 =?utf-8?B?L3JFV0xnUG1ybU9ydFEvUzZBb0xnUTJFM3M4bHV6MEdrNUNRTVh5LytXRjZo?=
 =?utf-8?B?UkxHK2VjTFJES3ZzcFhBaFF0REgvRytnd1ZxeUl0OUdBY1lQQWswODR3UHNX?=
 =?utf-8?B?cktONU5wNnNwM0lLM01ZbVZIOHV4cVFScHh0ZFNPUlM1ZFVyYjZHVFF4SlB4?=
 =?utf-8?B?QXpqSzROOTd2TklIeGVvZ1Z2UTY0czlrOTloTHB1alBLUU9UYXNNTmpnWmh3?=
 =?utf-8?B?ZXlYdkFscUhCVEFvZHpEeFo3ZHRuT3lmL3hPYndQWVR0WVhseCtvd3ZYTzN1?=
 =?utf-8?B?ck1rSXFkbEpSMzRBd2daNmVMQ1pjaEhaSGNuOTVZcWxOMzlXN1lRa0tUU055?=
 =?utf-8?B?QnlxMEJLSFFDcC9KL3VxNEV6c0RlWWFwZGdlM0RtdXR1TWZyaklYeHZaUEJQ?=
 =?utf-8?B?M256Tlh1bFlmSHZVVkh5ZXZnLy9STjVFSGxjTzU0OXpzSjR3bTd2YTFBaFBC?=
 =?utf-8?B?cFNxdzFLb0NQMXZoQVcrakwyYUIzdHVxMlBCZGF1V2gwSm5UMWN6ZG45ODNH?=
 =?utf-8?B?Y054RFdZL2t1clZvbTNpSjdNNlBBRjYvUUk1Z1dsUXp2UGptUXF1UVdteG1R?=
 =?utf-8?B?dnkzVjgxTlZZZi9HNWtMc2VxWFo1bkdnWGJEZlp5eFBtRWFLdGVZQ1ZQeUNt?=
 =?utf-8?B?QmQyOE5CbjBjcmZiMHVQSXNKRXowVDc2ZFphdk5iWnZWcG9LQldBRE5FRjNI?=
 =?utf-8?B?a2VZVkpRR1VabWgvRFJ2NHk4S3RmdGN1MDhLNzBHUEEwbFRZay9ORlRIQlhO?=
 =?utf-8?B?MlhBclhZeTdiQWtUL25yT01uZzBwM3NnYW9CeEp1eVdqSGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZ6cW5aS2tFOFoyRytHQ0tZT2ZYQmFnM2wyTEhJWDV4UUlXQzJqSVloalBv?=
 =?utf-8?B?bUl1TUk3WDlCZ242ZTY0UG5kLzYvUDlwd0oyTFFUQjBLMEJNVDM2dHRTV28z?=
 =?utf-8?B?N1hTZEtaR2Q5WCtXSWZnRUFYc0IzL0M2S2MvS3hjT2M5dm5uUlJQQzNsZmdO?=
 =?utf-8?B?QVhrWHpwNlI4WjZVNU13RXRFVVN4djRoaXJNREd5Q0RQVDEvY3ZIcGF4MnlJ?=
 =?utf-8?B?N1BNS3dodkRQWjdGSUxsSXZwYVI4aW8va01yaXl1SjJGaXZ1MkhJSEZTMUVw?=
 =?utf-8?B?ZWNBeTBoczBwRSszMGtLNS9TTXJ5QmJQMktQdytQRjA2MnI4U1FzaGt3RURZ?=
 =?utf-8?B?WFAycUJXQmZlM1Q2NVg3d29PRit0Qko4NmU1aTI1ekErUms1NlB1TVJzYjRu?=
 =?utf-8?B?UFdjMzdHOHJVdHpmc0U3VElEK0VSN0ZyQW5CaS8xR1ExdUYyZlBQd3NMMFB2?=
 =?utf-8?B?ZFJXMFBiVXNPODIxb2R4SnMwY1hqdDJqUnlNSVN0bFh0Y3dNUGpqQU0vamZj?=
 =?utf-8?B?MzEzY3g1bXdybSttYzVWT01WTCs3NVd3QXViQ0FoTytOQkU3aWhxaU9TZHVr?=
 =?utf-8?B?d3BXbmtycDR2bkZoWkpRaGlpY0RwNXh3ais3S2l5Zk84TkE1cDlpQzBiTm4r?=
 =?utf-8?B?ZGVBYTQ1QXd2RlZoRlJMalpjeS9XL0NObVRpZUNYZkE2U0ptMlpqSmhFMHJK?=
 =?utf-8?B?ZlA5Q2htYW9FWUt4WEptNld1YWxhUmJBSjhCMTc5MHZ4SkUvYTdzdUhEb2ta?=
 =?utf-8?B?MWkwR2orbGU1WFRCRW5NbDhUQnhlUFZPcGRzbm1PKzNOcVE0NlVUTkJSL0kv?=
 =?utf-8?B?YmZ4dlg2SEo0dFdRN21Qd2RpcnVyWE5DQkt3VWpORzQ2aDdRUzYraGlzNm5H?=
 =?utf-8?B?cUc3Z3NOU2tkdEZocmtoSGlmUEJmM0x6UzU3QjFoQTgwN0lGdlczVU9WQUk3?=
 =?utf-8?B?dlJqcG03dlVzcktVc2NsMFFwUVFrR25OSEpSN25vdlRYQWQ0SHhsMlRlR2cz?=
 =?utf-8?B?SSs2Q2JhdEp2MERZTmd5bmJMNS9Wanp1TTRWMTdwbmpXWUlYL25FblRRMUpJ?=
 =?utf-8?B?NWVZVFBnVnpuMENmdEtidFFKZVdWeHRDMkdCNVpLWThzdi9IZG90YlJCMDlq?=
 =?utf-8?B?K28yVDVTSnJHNldKSGFpMGJRRUsxYVF2SE80Nzg3QlBQQm1GNXlaVFpkV3B1?=
 =?utf-8?B?R3kvaGduTk42NEJEcFdnbW9ldWZPcUZPeHU0QVN2YjFoOXRaUDFLOGVCMElB?=
 =?utf-8?B?cjRzYVh2OHhrMEMxRVUvbXFpSmVqYWM4WkRPYXhtZFV6ODBZWkhHbjlJZzZh?=
 =?utf-8?B?S3ExRDBDeDJGT2RjS3FRaVZHWWlpczdMc2wzSWEzUjJ3cy9saGR6REl2b1hD?=
 =?utf-8?B?ZjlMRHdzRWNUYk5xd1ZpVzh3RFR2MG4vMkhpLzR0K1BtOWE2djQ1L0pDdStJ?=
 =?utf-8?B?WDRyUXE5M1kxUk5JWU4rVnhvYmJyWExkY24zSVQ1RWhyV0tldTNTZTNwWE5W?=
 =?utf-8?B?THZOaDNKaDEzVlk1N3o4NUVzWnRaaWk4UzVCREZmeWg4YlpFamVEZ3FYWE9N?=
 =?utf-8?B?VkRad0NoRFE0UEd1MmRtYlZIeEdybDFNdTZBM2czK2s2S1pXa05Uazl3RkhD?=
 =?utf-8?B?eVN1UnFEa0R6NFp4RVk5SEs5WjV0WDhhSldDRDRXVXhLcjFVVjhoY2ZNZ3Fx?=
 =?utf-8?B?eklOMUovVEtpRHdtbG1HSElHdzl2ZElLTWN6amlqWGhvRHpRSkF2bmd5VkVk?=
 =?utf-8?B?K1FOSmxaTGpUeHB3ak16TDk0N2ZTNS9wUEp3cHByUURocWpzbytKTXdZQ01l?=
 =?utf-8?B?aEJJTW5QaG1QUVFiWGVXdDZEVCt1Slgxa21vVlBFeU9EZWJhYllYVUpSOVBz?=
 =?utf-8?B?TlVxcnozT2pWZThLRXc5Z0VyUXo1RzNXUW5UeXJjVkFIcVN0SnJGTVA5TWlj?=
 =?utf-8?B?cHBUb1JXMDkrbFgyMUlyQXB1Y1dESWZWUWQvUFRyY0hjVE5DaFJYeEE5ZCts?=
 =?utf-8?B?MkFyNWNkTEpCUlMrWnc3YWV6T20vNjBoS3dMbGw5OU5ia0lYZTltcng3MEFR?=
 =?utf-8?B?WGRjNmFEdTlCNVFEZHY0a2FhSlcyOWUremNqQWxRUStvaExZVkRLNDFGbzlD?=
 =?utf-8?B?anBWRGpJbDY3WE9vbDNoQ1FxdTNmUGNOR0RHVzZxRHllNC9KK3FzNzJvOU9k?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebd96ed-088c-41d2-385c-08ddc30196dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 18:09:35.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr0/v3+Nh+wQODKj5HvqrqFW9deiv0vCSojE1xHycqx5+/tKf0VsNVTRKl+slWDxVFUwkTTVkKg6vbJ2VgKOsI70Hn/d5lvi07TXr43d7ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5654



On 7/14/25 10:25 AM, Andrew Lunn wrote:
> > +&gmac2 {
> > +	status = "okay";
> > +	phy-mode = "rgmii";	/* Delays implemented by the IO ring of the Agilex5 SOCFPGA. */
>
> Please could you explain in more details what this means.
>
> The normal meaning for 'rgmii' is that the PCB implements the delay. I
> just want to fully understand what this IO ring is, and if it is part
> of the PCB.

The IO ring is the logic in the Agilex5 that controls the pins on the 
chip. It is this logic that sits between the MAC IP in the Agilex5 and 
the pins connected to the PCB that is inserting the necessary delays. 
Technically the PCB is not implementing the delays, but the "wires" 
between the MAC and the external pins of the Agilex5 are implementing 
the delay. It seems to me that "rgmii" is a more accurate description of 
the hardware than "rgmii-id" in this case.

>
> > +	phy-handle = <&emac2_phy0>;
> > +	max-frame-size = <9000>;
> > +	mdio0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "snps,dwmac-mdio";
> > +		emac2_phy0: ethernet-phy@0 {
> > +			reg = <0>;
> > +		};
>
> Please add a newline in here to separate the inner node from the
> rest.
>
>      Andrew

I will add a newline before the emac2_phy0 node as suggested in v2.

Thanks for the feedback,
Matthew Gerlach
>
> ---
> pw-bot: cr


