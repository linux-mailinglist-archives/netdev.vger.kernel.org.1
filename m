Return-Path: <netdev+bounces-107765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FEF91C42E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9533F1F21F4D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CA1C9ED1;
	Fri, 28 Jun 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="wQKzDwH8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2130.outbound.protection.outlook.com [40.107.95.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF531C9ECC;
	Fri, 28 Jun 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593520; cv=fail; b=NCmQH5juWXwN6guRrHP1P5KMzCcwZlWziL+48y5vw1AN1Sm4g2BT4L5RVicr6Rt12mWpStW8MjcZ7AH6EAELshSYUmANcWlQ3TDBpwb+Zbp+BpokY6Eov7NdWyVEY8Oz/yKGrC0SKxXamlmN/YU9F3ARJdm8BIbqClNEMBJj+Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593520; c=relaxed/simple;
	bh=c+qttvJJ+hv9C4HPPc8wimsA/WgjwxIr2D8l+EnsXmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J63ei25YV4Go2kORMoB5Oe/jCafsOs9YLcOymwP3ZS7IHkvnzRNX/flSuOjA/TxYxLw8Q96hYQgBEU0aDRfJTDztOjdfeVUN8bSbAvFwctsSHpNAqaylbqpEvTNMkr6HcmL/RWDeFLqacdcr86PAK+g267zB9/Kd5wgWMRjRrDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=wQKzDwH8 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.95.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jermURTckU6dSAbltX7aOuCpkBEIfDz4DlRC6jS1Y/ft7GTi1DGk8uQkTYi+/NK9QPgt9yqBY3N//Pj5kSy4SDXVkO7c2eXAs0bD8ao0QwNwrbCF5bWMe7Ggq8/cVg13GZDwH04nB5XX7jq4IdjUdUo9x5vjgzdX3umgCePXU3xnQmKYX56hrAC0m+Zyls9MyhimbHkWg5jUWCH5PZfP0WN/PRRBR3cCnlxi2ihVcPpzBR5SG7QPuH55AmBP5kJbb0aFgDfGDvUZNx3qloFMzs4WYZ7N+EuAQD5LMm1VcwCtc0xhO1fvi1f3JHjX5c+wZ8q8BfW6MCngbd7jPC+/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nxthyZUAhK94HoVAI1DivQvQnEql26MZCZVdBrK5So=;
 b=E2BFHZGSIn80AZO+DEpearOjytQJhwi4mEqd7KNo7+WJPQA0Fjw/J2P2G0F9wKkAOBwLLKT2yNkSH4AosCaEg921/+p+KVVFEj4fpI+Mx9aIAA7OjiXcWagWF4MP4i79j1Rmj45otAppjJx6VRwZQC0Nl7nA6P4ZYig/VpfGV+hBq4JocKMu+ZLrqwwQw9z0u/oxHgxI5LppWdIMPL9b0Hm1Ih5xwILLdB3LJTDLCAiEhvi6hj/BwJodIAwrNjlCGYFnoUb3wKvU0jRQnDARWKgqwn+W3Awwt5DmvE2T0b8sgI3Xn/9OA+urMOa1JOhPTLzqjUarvrq7aGKLPXkmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nxthyZUAhK94HoVAI1DivQvQnEql26MZCZVdBrK5So=;
 b=wQKzDwH8JcgExhMXDTGWfxHIbwDgU8575f7RIt/32wtD5jmkK+XlxCUXxTs7EiC42nPRKeYaJSyrI/ZtWZcIk5wBu0krR6ZR0s0FpLxbeOWLFBZZ9iAfZCz+qoeaml6aqZ9VNyY5XWr5Wsa0IsO1N+KYO+eEiCeVCBilECyqt+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 LV2PR01MB7551.prod.exchangelabs.com (2603:10b6:408:17d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.35; Fri, 28 Jun 2024 16:51:53 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 16:51:53 +0000
Message-ID: <4678001d-d47c-4d27-982c-71514896377e@amperemail.onmicrosoft.com>
Date: Fri, 28 Jun 2024 12:51:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
 <20240625185333.23211-4-admiyo@os.amperecomputing.com>
 <13e122213157b0f8cae1d90de3f558279a6ca068.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <13e122213157b0f8cae1d90de3f558279a6ca068.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|LV2PR01MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9c4fb2-8b5c-40a4-a0b2-08dc97929d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCtuWnlPQlo2NENQUjdpeC9XMDVJZ2RNUHYyUmYvdU12alduM2dCSm9yTng1?=
 =?utf-8?B?TU1JRXF0b2k0OXExb0JRN1Z3WlNVVlhvZjJWcXVDNXpXdVdMbWNSQVp5NDVB?=
 =?utf-8?B?NThQWElkaUxhK2d1VEJYMGJydVo1WGlQY0FiSkZpZ3V0ZUZGdFUzekpod1RM?=
 =?utf-8?B?aDl0b216MTBzSmYxNW1WazNndlBSbE5YR1RUSVB3b09OQ3VDNkdPSWhqMUxy?=
 =?utf-8?B?Q2wvU3diOEhmcmIwM3BSL05BT1FXSDdZdVZBdm1YSEtyR1BHSGdrQ1hvUlpn?=
 =?utf-8?B?WEN6OHRraW1KZHNpRWJtRTUybTY0dTFHQUcxbVMvUkxac2drNTNXVGZJbFFF?=
 =?utf-8?B?Q3YvWVBGNTNyYmkrR3ZYUjNKTng5MXFlcTBJQ1VyWWNqL1djMWFQL3U3L1V5?=
 =?utf-8?B?eDA1K2xaaGhIZ2txL1FZand1MlUwT3BVRjZ4OXUxYVlFOWNBNGxiNUMxdld1?=
 =?utf-8?B?dThzOVp3dXVRZlg5aVorNlEwdGFTMWFSMnVzUmxjT0ZuQlFTOE4xMGxvVzRQ?=
 =?utf-8?B?Sjh5VkJBazFrbjRmTU5uR09SUkpROUZld1hUOG45SW8weWhHS3lNZjE2MzlV?=
 =?utf-8?B?bHB1OWdpUVJ2OGtMNjRvdW4xOHFjcXJIVXJ4ek1XZlZ6UHBkUzhlWExrNVNQ?=
 =?utf-8?B?L3c3YnViQjlFTnArUTlhZmJLdklrVXFKditBQUduWUVqUWJFNFhVR0tXYmhl?=
 =?utf-8?B?a24vNG5lYVN3ZkxEalc1UHM2cWRRQTdGbEk3amp2YmZEdGVNRDJSZUczRkh3?=
 =?utf-8?B?VHhRdTZ6R3U5Ry9vUnFSdVR2ZUNsRnI1SEg3TTlsNDRSdzBLTGszNm1oN01R?=
 =?utf-8?B?Y29UNkpRUzZVNzlxZ0J0ckJmL1ZkVTIxM0JPTW9GVE4zRE1aZkx1WS9vTE5H?=
 =?utf-8?B?MStLTGZaWXRZRWJCaDNhV3ZFYUlNaENwSlN4aVNGMTBwZ09VWDBNNDBZYUZy?=
 =?utf-8?B?NWhwQVByMVg0aUUrTlJYZDBrRndUeTdJaUM5cDQzOW96OFVVK1k2UUFhRHY4?=
 =?utf-8?B?bXAzUHRwbmlDeVJwRTNWQjBhMmdCS3kyM3hwaHloVVdLVkxnenFJVE9NSjVK?=
 =?utf-8?B?WGpSOHpaQ1NqSERhZ1lvTzVmSjlWRnc2OWdNeSt3d2w2SjBURm81UVhkb2RH?=
 =?utf-8?B?dncxMkpTbkVpWmllbDUxU3ZUUnFCQ2hQaXZZQkx5Ykl6QjRiS1cvSEJQcXBw?=
 =?utf-8?B?dkJJR2tjUGRZMDlmZm9XNms4R0hvLzlzbjMxNEpSbEVHQWJrK3d3eFhTVFBY?=
 =?utf-8?B?YU5ZMEVUVk9iU0FSTGRpNXphcDFOU1NCalh4MkxNMGk3ODh3UnJCdEg4U240?=
 =?utf-8?B?RGJrS2lvZUhydXlEb0llZjNqSzRhYTl2STlQckhPeGtRT0kwamJTcWxzSmZY?=
 =?utf-8?B?ZVdZUDQ3cGtJeFdUaEJaOHZYb1d4anJudURINVlzUUdsYlYySlZxTmd1NktL?=
 =?utf-8?B?bm9yenpHelFGYnpPWW5VdkNsRWdvaGE3dnZEVXErYUNoMmRBZjM2S0UybU1B?=
 =?utf-8?B?V2N6TGpHT1FVaUVla0NFWFFqeWlkNDBhcGdzUjVGbkZseGlKQWNsWTdEV3Rz?=
 =?utf-8?B?b3BLZzcySGdEMkJ2UHMyQ0JaOHIxaWRvckZvTFU3Z0hWOWQxYk52eUVid01q?=
 =?utf-8?B?OU5wU0orY3BXTzZUU3VYY2xrTTlrSHNrZkVwaW5BWTkvVW9TQ2cwYmhWVnYy?=
 =?utf-8?B?U2F0SkFKajlidm1IZnphWHE0S2dya0tMT1NINUE3Q0hjYll6eGE4cXBjQ0lF?=
 =?utf-8?B?RS8wOUk4b043VjdUaTRHclN1cVFHaGJubExoSEpHUk9tVWRBWEFHL2xqTlpo?=
 =?utf-8?B?UjhzVmNzeldZLzNuS3lTZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFdvTUVxMlllUUU0dTg5bHBRWlQ1RThQclhLMWE1bmRMdmVFWTFSUU5HWDht?=
 =?utf-8?B?R05jTEFnWHZ0QzJtb3hKdUlONWFzdUgwaWdhYVZWSy82aGZKamkvVXlpL05k?=
 =?utf-8?B?UFV4a1RnZmp2QXFUTFM0bXpHYU15TnVhcG03RFdaVDFJTFRXVXQ1ZGFUbU91?=
 =?utf-8?B?bUtqa1hycGc0UWV0Z3B5QmxaNitRZHBFdlA1a1h2MzdSZW9lYWoxbEdGTkZn?=
 =?utf-8?B?UXRBSldYWFBObm9xVjM3V1UyMWFIVmpBV1Q1eFJ3N1hiTU1aN1Vyd3U1UGgw?=
 =?utf-8?B?N3lKMHpVT2dMcEZYY1h2Q2FONE12MHZNTGl0eko5QzJjaE85K3E3M0kzMVo5?=
 =?utf-8?B?UVJPL3dJWEt3Q3p2Z3ZOS2ZkYlErVmpZZ3JTamxJYStFc1QxYllBbUdOOWx5?=
 =?utf-8?B?UDg2MjBoQXVnQmVnTkExV25UWlkwZHpCSFIzQWlOd1lQOThkaWoxNWFMaXR6?=
 =?utf-8?B?TlRSVno0L3RPMzh0azhGSVRoa0N1Z1VGY0N4V3RRTUI0QW5FeVFCbGpsZ1dI?=
 =?utf-8?B?eUxWZWlNK0RyU3d4bXdFdkkvSTRORm5PclF3SnVLWmxQRkJlMTZFakcvTjNx?=
 =?utf-8?B?dUZLWnhVVk93S3M3UzdqSmxFRTNyVkZVNW5sdVBxcWpUS2x4cU54ZFNaYWxU?=
 =?utf-8?B?dCtseWU2d3lhWGp3eUtNWWlTRnNuUWhlK0tUQTd4NUc4L3BpSVFxcXFmbzda?=
 =?utf-8?B?dDZjUjZyTXVZZW1jY2huU3ZUUWJUZDdxdmp1S2JpMmNqSk4yNXJXaU9vd1hj?=
 =?utf-8?B?NFZZNUR0UDhlRVhSRzR6QklQdTVONEN2V2VqUndHQWpud0RuUExLZzhSVnVY?=
 =?utf-8?B?elU5WWNCSjVZS0VJZG5QVkkwWWI4UXBnSHI5VWJEcjVoMUV4cDJ2RTNReUlQ?=
 =?utf-8?B?Q29MSjMydFBURVJkT1RFU2JsNUxrNVRjK0hKZWRlbm9Ta2NGTllBdmZNMlNh?=
 =?utf-8?B?cCs0UDlxaG4xV3FGbE5aMlBIcCt2WUtnVlNFbmxReEltM1JjSTdXUG44NHZi?=
 =?utf-8?B?QlVYRXNmSktlRkJNdTY1MGtMM0dGVTE3dzZScTdtdW9Ld0xqVW1vWFQyRmxF?=
 =?utf-8?B?N1ZyeFBLd3FzZDFGY3pjMndHdGMrTVFBSytOZHBib3BodE5NTGxHNUxiUDVY?=
 =?utf-8?B?cUVRb2hKdzFiV1NQK2VrWXdaOVUxai82SkRUNlhoVFp1aHNkSk9McHpQNlQ0?=
 =?utf-8?B?eWxSSEg5VUdvQndIN1gwYmQ1TnN6QXk0REdJYU9NNERidkNCSXlpRUpvOWhh?=
 =?utf-8?B?MmZCZktBL09XZkxqQUZKMUtkOXZha0JQWUJKaWxUVkJoc1h4cjAzQjJ4WWls?=
 =?utf-8?B?eE5FMjBkcnFvb0h3RFBZcDMrU3BXWXo3N29kL1RVeUdEY0hBMk5vUjZhUCt3?=
 =?utf-8?B?dDl2UGkzSFFMbjFNRWhsbytVODZ0Ymh2dEJMS0UwZE4yNEFvZUVvYnpjZi8z?=
 =?utf-8?B?MEpKZ2hCNHhaWTl6NzNMY3FBK2QrZ2JiVGRVT0VLS1g0TFYvMkRwVmVBa1NF?=
 =?utf-8?B?ZHhZQVBXUWNzKzY1a0JmTGhnUjQyS0tRbVhkV2VOcnQ5emtDcThzVnFFS0Zm?=
 =?utf-8?B?OUJFV002QmVvTit0MkpORFBrM1BPS2E0RlVpT0ZKTXBqZ0VnbE5aUFJDcUZY?=
 =?utf-8?B?K2ZrTWJCWU83ZmVRSUlnSGpJa0dnb2pwZWpMdHhpRXJTMXRSUlY3cEx0ZHhn?=
 =?utf-8?B?ZTMyVmdTb2padkhZajl0SU9tdm1NWThTbEFuekxjUFFNMnZHdzFLWkdILzZ6?=
 =?utf-8?B?Z0JHUFF0elFVakJESUs4ZE91U3JmWHFDSnIzT3NTeDNwbmRKYVBDVjYzR3dV?=
 =?utf-8?B?YnMwNjdKbnVuRFp3dEhGaEhYODhwRTg2RzZ0TjFUYTlyZ29QL0hwUnFBNmpu?=
 =?utf-8?B?MWwwa0ZBMkZmZk9sSVFhT1ZTT1l2MCt0WTFIVzNBMGdzMyt2bmhWNENRUEFy?=
 =?utf-8?B?aEdVTmJGMUlNdHlFOXAzc3RMTlZ1d0VleVl6cDFJWXJ4alQ4azhMRjRSanNC?=
 =?utf-8?B?ZmtGSXltaEI0U1FmcmZvZmxTTFNURncwL05oVURaNGhsMW8vWVBmaCsyd1By?=
 =?utf-8?B?eUpJYkhkenpISGIzYmlPcWY5Z250Y2x5QXdSWmxjN2phcldPU25CWGgydUp5?=
 =?utf-8?B?WndPdStuTDBhUzVqYWMwMi9UK2l4MW96YzZ4NVVVdmMxWXA2bGVkZDIzU3JH?=
 =?utf-8?B?U1lodG45VU5DMzJWRS9EVUpReEdlOVdqUEhuMVVITHdpYXNCVnhOYktreHBi?=
 =?utf-8?Q?0fUYT0JgQka78um4nhKIA/lHmOp6UVJoyG4yHUyvSQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9c4fb2-8b5c-40a4-a0b2-08dc97929d00
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:51:53.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS0tocVpWtvTfLLg2hoZHTv2pIOU7yxPvEYwBJhnGxUd6uflxZoN67IIeYSDyZPHfUNBRnNkir+5r4q6qseEMgnxHkuAiJixV+0qYhHdy92qU7L41LzQWjSkH0lzSjZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7551

Yep, you are right, and as I continue to mull this over, I realize I can 
make it much simpler.

Sorry about missing the changelog entry, as I had written that prior to 
realizing that all of this cleanup was a workaround for the error you 
found in the first iteration:  flipping the null meant I was leaving 
behind devices when I should have been cleaning them up.  So, yeah, I 
think the list can go now.



On 6/28/24 04:41, Jeremy Kerr wrote:
> You can save the list_entry() below by using list_for_each_entry_safe()
> here.
>
>> +               struct net_device *ndev;
>> +               struct mctp_pcc_ndev *mctp_pcc_dev;
>> +
>> +               mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
>> +               if (mctp_pcc_dev->acpi_device != adev)
>> +                       continue;
> Wait, you removed the case where you clean up the whole list if adev is
> NULL?
>
> Now this contradicts your section of the changelog:
>
> - Did not change the module init unload function to use the
>    ACPI equivalent as they do not remove all devices prior
>    to unload, leading to dangling references and seg faults.
>
> Does this mean you no longer need to free all instances on unload? In
> which case, that sounds great! that probably also means:
>
>   - all the list is doing is allowing you to find the mctp_pcc_dev from
>     the acpi_device
>
>   - but: you can turn an acpi_device into a mctp_pcc_dev from
>     adev->driver_data (which you're already setting), so you don't need
>     the list
>
>   - then, _remove just becomes something like:
>
>      static void mctp_pcc_driver_remove(struct acpi_device *adev)
>      {
>              struct mctp_pcc_dev *dev = acpi_driver_data(adev);
>
>              pcc_mbox_free_channel(dev->out_chan);
>              pcc_mbox_free_channel(dev->in_chan);
>              if (dev->mdev.dev)
>                      mctp_unregister_netdev(dev->mdev.dev);
>      }
>
>      (but I can't see how dev->mdev.dev can be null, so you may be able
>      to remove the condition too)

