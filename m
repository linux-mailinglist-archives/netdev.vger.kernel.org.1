Return-Path: <netdev+bounces-168241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24353A3E3A7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A90420BCC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA3213E91;
	Thu, 20 Feb 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="25Xq+fyf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8081212D86;
	Thu, 20 Feb 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075437; cv=fail; b=ovx9P6/0p/9Btcgg20i28dZbjn48tSfQB2LG7nOG3fe+EUeGvWHPD+mpTlfhEDVJfGMSIKXnIranDm6zvpZiSRhgt2D6cydGgJGh51N40coqGx/ldo1C6nzFMO9x8uWlOjXUCKlm3V7w0sjRbcETwZei6XMAsc96wV3MyRH8k/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075437; c=relaxed/simple;
	bh=hM5QNnvzC6hvcyX7DkwkwBs9y+ODe+VUgeL4+ogWe2Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c94NvPwdOG/UEnIRZogE1/pufEWBpNEmejyB68wWwuIvBoxsGRGrCTc8nvE+vnncEay1hJcHH151bocJ28gjndBILRWLBsu22q2CbJpqeJuTfx/GBOjg7/LzcSbGsL2yxWtSWG0paPjH3AcTow8FLX0tkVRa8CAIxhkp8m0I4Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=25Xq+fyf; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRMvr6XwKTl7RiWwVkMtIHxYXRrAxEOLG6i0ldgQB0QUUQS30uC7Ik9Lp9oPtgegEQ97lAkxYlxxbuDF6IzspUulWu/YooGwKgq76DCLMIkiS88+e93yELopNTV2f6Z9m3nD7zKygKFjnP3GrTxW2ZcesnxWz/uQxXwylBrFJjzTAlRICKV6SSrHaLV7dx47ek1vPSleO4oQD+yNUZH/9knCH8mVrDQpNoAFfpQqOFjYy6HRdR93YUDJ2nplOUZ10P5Gwb9oItaGDBq50ShuF3nsAJuye1Sflq/xPEFFF5UlkpjFN/Pc/fjQWqoSyxQPJw3fqBeLzuW5lT4t+iCoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJmCzNy2163m4rsF5y9Y47Ek69A4L4/HAlAORhEikIs=;
 b=nsDYVvAUC/KIzNj0md6aIU1qV4RL6Yc92oLfIgZkwoGzZrW9Grmzpj5ck6+YM4BAouffIKdVA0hVfSlmYasN4mF5+jsamzlqzjh17OQYTvTbEVfgAD+9xlADzEFSG4JLHOrERTLnHJ4IfuQN7nTBv93+9aH08MUCNX65CJHsrf3hXlmALyNA7u/pyRsOhxQQ0TXJ+51YU/1MtV38m+Jjqa2vj/6GOrxYJrpSrXmaPDZVWK1cqSRRjqRUTG74WJVbZA1VG0z5KXf9Z3YIYMOCcR2dw96FAhvUtUjud2mCVGkttSyB2I1mAOXZXQyt0wG4bvRkryVwUcf664oTFnZl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJmCzNy2163m4rsF5y9Y47Ek69A4L4/HAlAORhEikIs=;
 b=25Xq+fyfVDfvbQQ+b3qM0l/i91BTGbb0IKZrH7LlKOB0B8L41gt06lR88IqX24j406SPg3tgD2OutDuK7GVKaus7q1QL1oH5k+XzPLT/6I1x9KVCgzd/xz1k6FHFOp4ZybQFAZjNJxvKXxEQrosvYm2fmdZBG3cC2we0g5xrUR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 18:17:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:17:11 +0000
Message-ID: <390c6b69-bbf4-47cb-95d9-215a92ee3cbf@amd.com>
Date: Thu, 20 Feb 2025 18:17:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <33aceef3-9e01-4b28-bc3e-7dc11b59a1f6@amd.com>
 <67b5421cd91d2_2d2c294ad@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67b5421cd91d2_2d2c294ad@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0293.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6ed26d-7fdd-4dfe-33fa-08dd51dacb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUs3alJJb3BrclVldVZpbnFXREZxQzlnNExxQnRmSHVlQ1R6Qzc3M01RQjRr?=
 =?utf-8?B?TUFGY3pLLzNFZ0lVY1FHb0ZHaTdUUGZtdVFYdHlZZWxPSHBIWUlQNnZPdHRS?=
 =?utf-8?B?SWdvYXRFcmxkKy9HTGJWaFZYOURlVEhJeDNSTks1TzBCc0E5OXNMSjFyQnAw?=
 =?utf-8?B?dGFQZXdNOVVZdmpMMlAvb0YwOXlZVFQyczJSMGVnQXZKKzBsYnpqcVk3SlZQ?=
 =?utf-8?B?VzlSVFQvbXVLZlFjN2c4SzRyODEyYmFCc2pidEllYnhxdVVUdHN6MTBPQzVq?=
 =?utf-8?B?SDN6RGNWZU56TEZnb3h0M3AzUklQSkFkdUNhSmszWE5uZ2liYVBweE0zVzEz?=
 =?utf-8?B?ME82RXZCUzErRVdaMGRRcWUyak02WjFma2xuem00V1ZoaXdEZmkrYWFhaWRY?=
 =?utf-8?B?VlczREI0Z1hjQ3c0RDJwa0todkdqRklsb0tjZlJ5eklVN3Q0L3hkTXVUaENL?=
 =?utf-8?B?c25LZ09NODkrZE9xNWEzVVNtb05kNFQ0bmRtUXc5Y2FxK0t5aC9sanZZU3FK?=
 =?utf-8?B?TGNpZ3ZuMFFpU2JTY0hLS2VLRmt6SC9yYjcwTFFlRHc5TTNGQTJjYWwrL2lN?=
 =?utf-8?B?WHdWNXlFQmdSZzZ4bFhIcUMrVXNEOHlUK3FtY3VWYzFyeE5HejZQbWFSUFpy?=
 =?utf-8?B?SEtpeGZkSTBERlVTUWErYkdJRlZueUlRQnM3U1lUQllpeW5JM01WRGxYS0lU?=
 =?utf-8?B?c1FZSGs5T002UEtvdTRNMVoya003WE1ucHVrQlFvNnE4dG1LSGhvKzVsRTVy?=
 =?utf-8?B?a1ZRdDEzb2lUQnUyT2plY3RpdU5NbkVlK1RNbzZ5NUpaNWxVUCtqdGZiaUFH?=
 =?utf-8?B?UklPS0FmUmxnTWNrTFptbnJnQ1JjUUtwaHhqY2hCVEtlQ2VqKzRtaytjZE9G?=
 =?utf-8?B?WlRhaVlpR213aWdpMmZHZ2szanVKQVl2Q0NrYUE3ZUR6OTlDb09tN0RwTlhJ?=
 =?utf-8?B?THNSTzhheWQxWFZ1STVwVHp5NGpYejk2dU5Dc0tSTm0zQ2Eza2xFT0syMjhs?=
 =?utf-8?B?YkNVNnh3bkVOeVpEZTJWN1IvUW44aFlEREdPWWNZYnJKNnBmeEdUT2F1YVZY?=
 =?utf-8?B?MFZFWDFJZEtRMXplWmRRbS95MkxIMEhRbC9XQjN6NmRCVjlBTnE4ZHRQMXdN?=
 =?utf-8?B?WFNnMXcyNENoOEZ6YmdyMmhtQ1pjbVJEVTN4cWg4TjJkZnU2ZlNLQVAzZkhN?=
 =?utf-8?B?eGdVOFhqb1AyNElLSFlJR0hEVGo2Y1kva0J3WmJ6QW81T1M1bTZhdDhsNm9K?=
 =?utf-8?B?UWhuYzF4QzBsNzZqRmhPNmx0Y2JoMjhPOHBqVDRjSDNzQWZJK3JiQnp1VU1O?=
 =?utf-8?B?ZC9vR1BXNUFvVURNS2cvS28zQzN5L2dyWG90Qlo1RUY0ZlN2MmF3eUh5RlRt?=
 =?utf-8?B?eW8yNks3dTEyQ1ZRYy9mdnNzaGhwdDlHL1NKenRndm52SkEzaEJOaE03RUZE?=
 =?utf-8?B?YzZ5dExFZ0t4cCtwem1SV1U0VDJRRXdBQVVKNDY2cG41aFc2QzlNejNJNmtF?=
 =?utf-8?B?eFM3MUFLMnV6aEl4K2t6R2VjWGpEb05EWkE2V2laZEdTRzR2MHF6cDJqcFZL?=
 =?utf-8?B?QWxpS1dlanNKUy9pd1FOZWIyT3ZYYXRTL3RpbmhJY0JjRmc4VnlQVVlvemRw?=
 =?utf-8?B?S1ZEMW9Uc0YwYm9ReHJhdEJrbVM2RW1kK3ZOVnk2SnArMFJDeDJ2OWZIYmFz?=
 =?utf-8?B?cUViL2w0dXBUdG9tRDFobEFLZ3VDSnFtREpkYk1WNWM3eFFURFYzaHIvYWdh?=
 =?utf-8?B?MUtwSk1ESVFucW84YmlFenVGR3pUTE5sbFJhQ0xwQlVpS3VHS24xQTFjd1Uz?=
 =?utf-8?B?K1drK1QwaVhMcUROeHpwMjAvK0hqb2dBS2EzM0xkYUprMk4xaEtTTHZGQ0Fl?=
 =?utf-8?Q?j2nG92QXLpyqy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXpqWkdYeGRmbDQ1aE1TT0NXbUtXRW5GaFFjcTJnMDJ2ZnlzMXVWMVBMTGFl?=
 =?utf-8?B?dEc4OXlxVkJ5NTRxak9kczdrS1N0U1pVenFNaE9vcVpUMjlwM3JSaG9YYS96?=
 =?utf-8?B?VVFwRWd4RndiYjlCNDEvVlZLOEpQV212VlZKdGFHb2pDU242bWM0Z2JMZnVl?=
 =?utf-8?B?QktNaUVIMHdoN3JsVnA2aWdtdFd4aC96Yk9LRWFFWkdXR3VOeTBidndkWGxY?=
 =?utf-8?B?Uk5iQ3NSbEFTZ2FiQko0ejJxWUpPK2RleG1hdXFrdnNPdG5BWE5STlE2ZVQz?=
 =?utf-8?B?R0h3bElySmtLTllibVhGclU3NVErN29ONW1YWWJhSVFSYmNWcTc0N25XN1hG?=
 =?utf-8?B?RnQ2TzhDVitUU3g3VDFmdStqd1hFZHRwOHB2c01tZndDY3BiSTJEVk9EVzk4?=
 =?utf-8?B?eUZrQkxiNjE0UkF0Ylh6bVFrVVhOQXQvZGNZUmg1ekhIUE9nNkhsaFhFVWM4?=
 =?utf-8?B?YmpSSnVFcXpldHlFZWorZWtzNEJvWTJhMjR3TEZzaU5PTHFJWVUxUG02cllW?=
 =?utf-8?B?eXlEck83Uld6ek1PQ0dBQzY5V01CMFdZZ3pHVWZuWWsvZkFzVGNQR0VoN0Zm?=
 =?utf-8?B?SVZDbm5CQ2VGaUFaOTlXdGpJNGZ6SW1KSnl2TDhqcEYwU3JtN0p1eUloVkZl?=
 =?utf-8?B?WmdGQWNLSC9LMThKbndLSC9CenBhZUF0Q1hQLyt6dDU4RHlXWkJMRXQzZGRv?=
 =?utf-8?B?ZVRMVFdhSE9HMHR0YnRVSGdJWE41RWx0eEU3OEkxZW1sYzRFNTErRDVWT09H?=
 =?utf-8?B?R0x6VjNxbXp1eVBtOHpzdVBDYTJEZUlmOGNaTmN4UVNVejhodkZpOE1kTEhG?=
 =?utf-8?B?Kzcwd1lNakdmeXVVZGp6dHY4RVRnSFpnQ1M5d3d2SlBodVp4dDdjbWRWRXpL?=
 =?utf-8?B?N016NzEweTlXOTFsbXp3U3R6RnFNS2hQMEhCUEhCV0pKZ29lMlNRMFNRT3Vi?=
 =?utf-8?B?TXFFRnE5bGRNSzN6RnN1R2tpUTMydWdRRVJuUnZ4MUcrLzhEajFrTGliN1dw?=
 =?utf-8?B?aGg3V1puNk5LY3dmbThYQnhmMjRVY2FJeGcvMWY2UStZbmN1b3E1ZUx2LzNl?=
 =?utf-8?B?YytMVU1JRjV3cm8rU3lIcWJCZmFCQUorblNoTWJHdzlxUG5OeS9MMzg3QjZo?=
 =?utf-8?B?M2pzMFdUNzFsRXNrMG9jV3h6R2NNY1lqaFJzK01wWkg0VkhBU0Y3YmRMZzY4?=
 =?utf-8?B?ZkJNNjdEc1JpMGRQeWpiRzVCZTM1VG1uUTJINUtNalM3bnA4Z1FwTjE3K0w0?=
 =?utf-8?B?NDNiMERqaWlxK0JVdStpWmIrUSt2ZmphYW1haEF2cDh0bUpJY2Q1aWl1MS90?=
 =?utf-8?B?SWhoZVpvcVorNkZ6Yzc4cHpFeElwR1QrQlBVL1ZKcXJzcjloTmQyZ282U3p0?=
 =?utf-8?B?b01udks2Wk5YM293OVp6SDIrQ3NGSHQ5OFRaOGE0MEppWjVFSkNWNGJsRnJl?=
 =?utf-8?B?QmJEejZXc1Y4QnRPQ25zNHlnUDRjcUdiUW1xempkRGYwUG0zVXcyanl1aEp1?=
 =?utf-8?B?OC9sR0ZIZENDM2RkR2RiRkpudWdyQUg0aHhZMGg2UWkraksyN3ZtblUxTmtt?=
 =?utf-8?B?YW9jVnVTeTgwSDQ3L1pUbTFQL2lDcmg5ZkhJY0pmVHlxeUtSakh6YjhIS1Ri?=
 =?utf-8?B?cjdrbDIwSld4UVRmbllpMmdHTjlNYzFOSkdPUllkaDlkdFg5UGFseEgzQk1p?=
 =?utf-8?B?Zm1SK21WNkIzTXVOQ0FCSGo4L0pieGNCOGIvbjBTVkdBOUFUaUJ6S2dyYmNi?=
 =?utf-8?B?R056R0lOZFdtVzZnOEcxdjFCVG1uOFhMYnU5VEZzYitTZXFSRFltd3psaWJt?=
 =?utf-8?B?MndJRElpRG0xaEgvTzBXakFjNlJJVyt1anhGZDBudnlTZlFYWW5ERkZUTzl4?=
 =?utf-8?B?bG92WHFMTnpCdGpHdzEvMkgrRVFsTHpXSHdPczdzT0o0Vnc4VXg0QlhGanRL?=
 =?utf-8?B?VC9Na3lSLzIrdUVPT0hwV3U3Mks3RlZPN045dlJzcExYK2J4QUQ5akxnczUr?=
 =?utf-8?B?MkhXWjlaMGFwRFBXNmJCKzhZNVR2N0tNYUpMV01YMWw4Rm43Q2tMdDBBcXB2?=
 =?utf-8?B?aHFmM1JyVjZSc3YrWHN2SU1aL3RUNUhjRHgzaVhrbVZpWHc1amY0L21FS3px?=
 =?utf-8?Q?yywAUftjAaTKo6F9cMAk8YTiA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6ed26d-7fdd-4dfe-33fa-08dd51dacb96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:17:11.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx5rsJFeaGRRx5jk3kC26DrtonQR84GUU3W3BGlqhFW8QauMJYv63OoXLTOV/RQnIC/UfLdVxAuIVkevpGyt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524


On 2/19/25 02:29, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 2/6/25 19:37, Dan Williams wrote:
>>>
>>> I was envisioning that accelerators only consider 'struct cxl_dev_state'
>>> and that 'struct cxl_memdev_state' is exclusively for
>>> CXL_DEVTYPE_CLASSMEM memory expander use case.
>>
>> That was the original idea and what I have followed since the RFC, but
>> since the patchset has gone through some assumptions which turned wrong,
>> I seized the "revolution" for changing this as well.
>>
>>
>> A type2 is a memdev, and what makes it different is the exposure, so I
>> can not see why an accel driver, at least a Type2, should not use a
>> cxl_memdev_state struct. This simplifies the type2 support and after
>> all, a Type2 could require the exact same things like a type3, like
>> mbox, perf, poison, ... .
> I disagree, I think it avoids the discipline of maintaining Accelerator
> CXL.mem infrastructure alongside the sometimes super-set sometimes
> disjoint-set of generic CXL memory expander support.
>
> Specifically, the reason I think the implementation is worse off reusing
> cxl_memdev_state for accelerators is because accelerators are not
> subject to the same requirements as "memory device" expanders that emit
> the class code from CXL 3.1 8.1.12.1 "PCI Header - Class Code Register
> (Offset 09h)".
>
> The whole point of the CXL_DEVTYPE_CLASSMEM vs CXL_DEVTYPE_DEVMEM
> distinction was for cases where accelerators are not mandated to support
> the same functionality as a generic expander.
>
> It is not until patch12 that this set notices that to_cxl_memdev_state()
> has been returning NULL for accelerator created 'cxl_memdev_state'
> instances. However, patch12 is confused because to_cxl_memdev_state()
> has no reason to exist if it can be assumed that 'struct
> cxl_memdev_state' always wraps 'struct cxl_dev_state'.
>
> The fact that it requires thought and care to decide how accelerators
> can share code paths with the generic memory class device case is a
> *feature*.
>
> So either 'enum cxl_devtype' needs to be removed altogether (would need
> a strong argument that is currently absent from this set), or we need to
> carefully think about the optional functionality that an accelerator may
> want to reuse from expanders. As it stands, most of cxl_memdev_state
> makes little sense for an accelerator:


OK. I'll go back to using cxl_dev_state. More about this below.

>>>    Something roughly like
>>> the below. Note, this borrows from the fwctl_alloc_device() example
>>> which captures the spirit of registering a c4ore object wrapped by an end
>>> driver provided structure).
>>>
>>> #define cxl_dev_state_create(parent, serial, dvsec, type, drv_struct, member)  \
>>>           ({                                                                     \
>>>                   static_assert(__same_type(struct cxl_dev_state,                \
>>>                                             ((drv_struct *)NULL)->member));      \
>>>                   static_assert(offsetof(drv_struct, member) == 0);              \
>>>                   (drv_struct *)_cxl_dev_state_create(parent, serial, dvsec,     \
>>>                                                       type, sizeof(drv_struct)); \
>>>           })
>>
>> If you prefer the accel driver keeping a struct embedding the core cxl
>> object, that is fine. I can not see a reason for not doing it, although
>> I can not see a reason either for imposing this.
> The cxl_pci driver would use it to align on a single way to wrap its class device
> driver context around 'struct cxl_dev_state'. So it is more about
> setting common expectations across cxl_pci and accelerator drivers for
> how they wrap 'struct cxl_dev_state'.
>
> [..]


I have tried this but it is not so simple as with the fwctl case where 
the embedded struct is simpler.

As a result, a good bunch of until now internal CXL structs need to go 
to include/cxl/cxl.h, otherwise the size for the whole accel driver 
struct embedding cxl_dev_state can not be known.

That makes those struct visible to accel drivers which we tried to 
avoid, but I guess this is fine and we should ensure accel drivers do 
not use those structs freely, whatever the reason.


I will post a RFC just with that change, so only first two patches of 
the whole type2 support patchset. Let's be sure we agree on how the 
accel driver does this first initialization before I send the whole 
patchset again.





