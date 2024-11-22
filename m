Return-Path: <netdev+bounces-146840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04B9D6339
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4871611AF
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5114C588;
	Fri, 22 Nov 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="sTiO2AAG"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020090.outbound.protection.outlook.com [52.101.193.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB322339;
	Fri, 22 Nov 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296960; cv=fail; b=CoHbuPZT0w1wJhV+yXRbh95mt260gIqDUVVl34WGR3p9pHsjvWo7woZ3I1cHjnjcERWZ7tj5eIpy5ESQpzwuctHsGuB2biIgq1fdKa2Oo3DDTUx/5k7A519oVdiCdh3nmFRUHH9fanNFNGVyij06xOmb58HY595OJISqpDmgqE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296960; c=relaxed/simple;
	bh=eI4pe3+FUMr/k67feS+ACOBi+5hn6ndD02TjHO0/FAU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOG3FW0Tz/6q/GpffbpqVCbfnM2ZdfvAEcqdDiZNKmj0mxVIlTFJCIy1tjpInaC70zJHCXiXpcHOEeD8LKJNd0CRR3bd9JBxED+EvNYSjMpgllXJWd/OTNoyt3SAm9spfRsGQluqBHmXng/9j7nx2hVl3K8V1GEnHynHpDXncPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=sTiO2AAG reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.193.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPYCoX9PfcV3NBXWHBAv/K90QzxnpF4X1++OCBs+UuDqWQP4JzOen5GXHjxLaTDtVlWijWDmMhfWvjKWvtZyRjRcKrzMZfbGNoQhRNOPaD1sMrR+F1+SonD7C7JvVPfpbS0l+5Om8RqaH+JSXAuVtyj8MzHTmRZUTfXwfbS8IsMVNq98Cs/BgmDtC129Uq7SKEJd1Jj6XBQDLPZiQCkoClLVR4/Tj7UFWw6uat8+Vg5gBG+hTuw30fF+rZu4j8kdzh7lZqDwwPcGiCOgaOvfg6q3fAmQzRjbKl+Xbjbm0xdjvkK03ir3/Lr4ESIySzX6m8qq+1FGmA0yDrcuSEmFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ptixm298P2grvxsxJM/+JNedYsiOmFdvYm3zmE8QEk=;
 b=Y4eM6a/e5AIse1BrIYvR+4CqtokNGY5kNeG7TZ3ewxmxmWBqkQlO2plXgBGFHDAm+WaMoD1Aqslu7A+OtLsGu7ntIBcqSPhWkC88QFcotz5Fl2attKZAaBq/SlH9K25FnsJaT96xeLGIlaRlx88is2rKXRKeP58ywEpOdXTcDfrFVqfhwRlfttCm/QuJTxVaFPx9R/ZcXsQtVXhA+4EBNP2OoXCDsXbA6b7Kdw/3hLvNPpRHv0IwqFxQ3JFi7HUG48sVXJ+UDfq4c0chCVmGny8K0snPWKGZv0wPmRNeOisbJGCHJ43DDUjp65c9ySqYDtsAERk6VpLv+AQReAzw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ptixm298P2grvxsxJM/+JNedYsiOmFdvYm3zmE8QEk=;
 b=sTiO2AAG6f7iHt0DP1/7h7g0mrjt7P2YPXQ/71zxnpkSL4ugzFdqZVxTm3iGg4RIT4p+N+QBPS47xVGlaoI1MR5TLrEm1mspKTOOGGdL6PhoMUq3S0TMdf6iybnVfswK4eOcPo8ID1N1w7pdCZDaiHAjKe0jCpKg3mBo2tG8aKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 LV2PR01MB7765.prod.exchangelabs.com (2603:10b6:408:172::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.12; Fri, 22 Nov 2024 17:35:55 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 17:35:55 +0000
Message-ID: <f3767d37-237e-4706-8965-b7e3255833b6@amperemail.onmicrosoft.com>
Date: Fri, 22 Nov 2024 12:35:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Joe Damato <jdamato@fastly.com>, admiyo@os.amperecomputing.com,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
 <20241120190216.425715-3-admiyo@os.amperecomputing.com>
 <Zz-AvBwUgNzMJb7-@LQ3V64L9R2>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <Zz-AvBwUgNzMJb7-@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|LV2PR01MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 954e21a2-ea86-4d1b-aa58-08dd0b1c1e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDdKSit3dDdJWG1GbjBNS3JnTm1JTVhqUGsxaFVueUJDY0VNN3R1Q2NWam5a?=
 =?utf-8?B?NENobjY1cFlIUlVpdWJpaGNrd0ticldVRjBNSE1yQ3VYU3FOWEpDQ2gxdGdE?=
 =?utf-8?B?L3hOMzBmMFZGSkF5by9ZWXNsVkZKaldzcVQrZFVPcUxTT0Zid2ZFL3Zsa3pZ?=
 =?utf-8?B?b0JqVGhlWVNPVW5VZnYwM0w0bS85Q1hEazR5a0JtRDlJOXpLTHhrcE1oVC84?=
 =?utf-8?B?WmV6NGt0c2o2emx6MWdsRStISGFvcjk1czRiaHEyeGN4eEltQkdCcnVZVmhV?=
 =?utf-8?B?aEdTckJKS1cxQXpscXVyS3hKVGdFT0JBNjFCVHRKWEpnSDJuVXV2VlhkV3hF?=
 =?utf-8?B?SXBhTWsvNjRpQjhibUhvdkhCTWNIbUtxdFpadVMwNFJxTHZURWJwbnJIeTlC?=
 =?utf-8?B?UExLMFZIUFFvYWZGazF4L3djNEJZSEN0cEd5a0RGRkd1WE1EbGdsTCtGQUFC?=
 =?utf-8?B?NEpOZURuUzVxUzNkcWJUTEgyRDhKZ3BhUmp3ekNxcGlpL2VSMldGS3Njd2tY?=
 =?utf-8?B?R0NRdVVaMU5tbkJIb0FoT0xIU2JjYU96WmJHUDBjVDY0REpDUWluRnlZR0ty?=
 =?utf-8?B?dEJJWU5xQ05EWFR3bThzb2dUblpPdGdiZktyamZ4dHA2ci9neUk4MTBoeTd5?=
 =?utf-8?B?VGE2U0g5L1ptbmlESDBMWlQxdXVRdXdSS2xjanlWYk8ybjQxa1BuRXJQUnNu?=
 =?utf-8?B?eUZJc2pFZittUzA1YzJrZTlIRTk2M1R5VXlHOGsvcmZSNkFtekU5dmZaN1Va?=
 =?utf-8?B?NUZGWnFqcXpxejJ5ZzZzZWZIOHg4eFJweFYyT2cxZlc0ZHNCM2JJanduTE9w?=
 =?utf-8?B?YWJCZHNTdndMYkJwUE5pUThQbFBhZWRMSEJUWUlqQit1cXJjeDRPN2JFWExy?=
 =?utf-8?B?NjZnUURQQTl2dFpQbEVibE8wVWx1S1dxUW9udHI4RUV6M21ORlE4S1E3MDR4?=
 =?utf-8?B?MU96WmVJaXZISFZ4RU9BTkpIeFVsdkRSRUFHV1g1VHdERnpYRDlTelJzVEFZ?=
 =?utf-8?B?RlpwVy90MmlzYWlmS3VhOFc5NytaS0tQc0RlVmRvZU1SVHMxRHFpRjMybk1F?=
 =?utf-8?B?UlNVc3NET2E0T1o5dUNCeHpXcnQ1eUt1dXJmT1loMVNYQkpOMEV3c0JZSm9n?=
 =?utf-8?B?cU9lNjlFVkd3bm9zb08xMWEvTVZLTlBVUVEwQVY4WS9pK01pVElSRFJhZ0JF?=
 =?utf-8?B?OXpOekRzUDVWejZ2cE1ZdmYvS1JSbXcvTy9YbzF4RXltb2t6NlA0Rmc3L1Vz?=
 =?utf-8?B?UERMMDJJQ2V2a3JvUDRzNHQ1bVJzQUtPS2xGeUlBandETUpGTHg4WWdPKyt3?=
 =?utf-8?B?cWx3dTQ3cEZxVFM3bTAxSFM0NkE3dm9aN2VrbW40TEpmNGYwTHJnZ0d0bVlJ?=
 =?utf-8?B?Wm5EOGV2SGRKNDZveVA4ME5INktUMjkvZFlYVXBNUUoyV21EcFVxSmVOUXVk?=
 =?utf-8?B?ZjNFNXU4OGd2QzZLdzJZdk96N09uRnJGdXg0T0tIVWorL1ZPOThYN2NLSURK?=
 =?utf-8?B?cFFINi9hNUJFeVVzazAwbzJNNkhINEwyaTNWN2s5NlZHOWdQblF0TlFhbm9M?=
 =?utf-8?B?eFRBeVVvR3QyUHpGdEpHcHJ0WE5NNFhyVlYyOGlFbUlGdXB6WTVsR3oxMUU4?=
 =?utf-8?B?Q3R0a1BUT29tNURUSGhITlhoVXhVaVViNHA1a3dSRjJwS2NwVjljN3M2U1Ew?=
 =?utf-8?B?OTJnWmNhVUhLSXdnL0luYm5pZ3AzbUUrQ0wrd3I4U3FwUFJSNFZZVHozY1ZV?=
 =?utf-8?Q?rveKzaX9h+R62ta6qqmBquo+oXOMXt+1knc+gVg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWNlYXlyRitKSXkwUUVITnFaS3F4RHBTRTRNRURsZ1pBdnRBbjJNdmtOczdQ?=
 =?utf-8?B?ODNENFJlbzNQeGcxZkRHVHNxaUtyaVNsUWR5UXNjNjk3djFja2dVb2F4blFr?=
 =?utf-8?B?NUUzUGN0c09uZFlGZHVTZkVmL2YxYTgrVU9yckdVajNKTldaeHh3aDAzOEM3?=
 =?utf-8?B?TXl1MHV3YldBbHRmcTJYRHRkZUt4UENITHRBejNPNFFnRlJkT1J0QWpGdzRv?=
 =?utf-8?B?d0RHektuWk9PUnNaRldOcGhYVXRvQUdPUDJXZnQ2dDdpTXhGTTNmd2pFV1dw?=
 =?utf-8?B?aW9kNkpXNUxUcGs3UWM3RXZ6NE1WdmEwcGRiRlE3V0lSSEtnMFIvMkE5Q2dw?=
 =?utf-8?B?UXMxczUyYnd2QUUvZkxObGhVQzBrNFQ5RGJxbnUxOWdkelg4NTAySExRZ2dR?=
 =?utf-8?B?cThLV2VvbERjMkVSbDcxK1ZGa2xuaFBMMm9PeEVySUN0OFluSWJBbGhiMDA4?=
 =?utf-8?B?UEJpSjlPMDIvQ3BUdlZ1WkNRWGk4WkhLZ3czR2krY3VvMWVJcnFjMDZhOHFC?=
 =?utf-8?B?YlI2MzI0Q1hDemJMVHZtQzQzd2pBRUdtekpFWTlLZEtzdXdub1lZYWw3aFM1?=
 =?utf-8?B?YmtWSXAwM21Dc05OVDNMQWRFQnpEbENxcXRNVTBwd0dCVFRzcDN2Y0VmV3ZK?=
 =?utf-8?B?Y1JPd1FwZXFzUDhRcFA1TWl4eHhDeFJXUEVzMS9rRGxWcVhqdXRKcG9JaTF2?=
 =?utf-8?B?Ky9yeGpvYkd1NCtIeHowbVNUSUQyak1GZ2dqeVB2UWxlSS9HM2lacU03MW9u?=
 =?utf-8?B?aFZleHZ5RHYyeFp3a2Q0T2g3a3ZtdW1GRlpUNEc5REVETEhzZitkY1dHSUxq?=
 =?utf-8?B?b2tJUkh5TFZvMW5hMGNjbEt1bVhGYlMrVlEweXZpY1ljSFZhcGsxQ2YvdGNn?=
 =?utf-8?B?UERHak1maFVtSmE1aDNadzNzZnI5am9GSGRwTjRlZlZIamJRbFIxZXVxeVBq?=
 =?utf-8?B?d04vcXlFcC9zZlZLOFVpMUZwZG4vQkgrL0ZocHlsVVlhZ3YxZ25kaDZBUEc4?=
 =?utf-8?B?SVp5T1pZTFRSdG42OUlQdDVOTlJHYmxOb2diSEM0c2Jpbm9Qc1ArUmRzOEEr?=
 =?utf-8?B?TSs1T1doaUxQaEZKaThjaHJiYTh4ZzNTcXIyekhRV01mSUN0cVVtWWlyOFd4?=
 =?utf-8?B?UkpkdEp2ZGJUTCtMUXpNb1RzV1VLUWoveW12cTB0N0NEMGxpUE5jOHlJNC9S?=
 =?utf-8?B?dDMwS3pRMXY4WUxaN09pK2JZV1d4QkRpcUVHU0tmMDZocDZuK3NpSVdnLzIz?=
 =?utf-8?B?VFd4M0JCWEpNUGdSZThKS1V5OFIxWjhoUkVLKzJ2eG1VVHFYTitPMnFVM3Fo?=
 =?utf-8?B?enV2TURKNWhUTGNzV0d5cUI2TVAra3hTWEt2K095VENPMkZoWldVT2ZZcHRN?=
 =?utf-8?B?ZVBkMTJMOG1sbVkxR1g3STAwMElrd3loc2V4cGtOSmpkdW1CVm5tbUFYcytu?=
 =?utf-8?B?dk83UG5yK0lJYy9UQzAyQ0JmUVBjOG04LzVsWStMb0htaExwK2lCS0tsZXY3?=
 =?utf-8?B?TVR5SThlUUxGRlZhbFljUlZQL1hYS2U3eXpleXJvb2ZFbXNhTUlaemdVMlN6?=
 =?utf-8?B?eExUSisvd0svU3Flb2tRRDZjK0hDZ2F5bzFZMW9ubmRxeTY0VzI4MW1mdHJN?=
 =?utf-8?B?eEZ1aUxkL0VkODFpS29UOUpTU2NYWGdKckFnUTZUTkxvdmJrR2ZwWEdnRFdI?=
 =?utf-8?B?RHJSTnFURUNDWWtYRUtOL3Q0TGFISWIzZ3hZb0paTkdVbm5DczNybmJvYWpS?=
 =?utf-8?B?b0pSazlsVVJ1Ykc0RllhYVZTODdSaDJRcStpeTIrTzVYNloxeExNWm5jTjRQ?=
 =?utf-8?B?SFpWSG5iU0pENUxPZ2lZM0htWndXSldMT1Z0NSt4RlpaWnhpMENKTTlXanJo?=
 =?utf-8?B?R3lDSXRaeEx2S0t4L0pWcGJmQXdMWWpuSDR1UTR6NU1ublIzbGRtTno2cTB0?=
 =?utf-8?B?WXJjNTFCemE2bUhHbnFad3BiLzY4ZnIybFl6T2ZiRUJGeFlhVFBQTmtyc3Rx?=
 =?utf-8?B?MUI1M01OY2hVeG9tWC9JTnZyM3ZvdjF1MjRRZktab0Z0MlJrRzVVZTdqMVVG?=
 =?utf-8?B?NHVVNVBsL2t1bnlNUDUxTFdNL01iTjdHWDlROE1QbCtwa3NYOEZKN2hkcDhG?=
 =?utf-8?B?c3JHaFZkVkM0dHJqTUFsZElPSk41TnlQaHo4SVcrdHgvRUhxTUl4Z0ppSGpt?=
 =?utf-8?B?azRaTktCS09hdzdtOHVzUW1BbUZvRnFDOFppdTdMTS9NbmNpTUs5ekxtZ0Uz?=
 =?utf-8?Q?tKER9/ZSu5Vw35vMJpDABIJ0BwZKLz/Dx4oNhZNvoU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954e21a2-ea86-4d1b-aa58-08dd0b1c1e18
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:35:55.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/QzOeQCEo9X200n93R53m1+nBmZG9gZiLuMJGs/OVj5hDh9r2ChwXgUDkPuzSI28kmg1FcoBoCiT5pGUI6hyT5dqWxd29apXa+DRe+/aFj8KcYEALzVOtYcjH63njEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7765


On 11/21/24 13:49, Joe Damato wrote:
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_dev;
>> +	struct mctp_pcc_hdr mctp_pcc_hdr;
>> +	struct mctp_skb_cb *cb;
>> +	struct sk_buff *skb;
>> +	void *skb_buf;
>> +	u32 data_len;
>> +
>> +	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox.client);
>> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->inbox.chan->shmem,
>> +		      sizeof(struct mctp_pcc_hdr));
>> +	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
>> +
>> +	if (data_len > mctp_pcc_dev->mdev.dev->mtu) {
>> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
> I'm not an expert on rtnl stats, but maybe this should be
> accounted for as rx_length_errors ?
>
> And when rx_dropped is accounted in the stats callback it can add
> rx_length_errors in as well as setting rtnl_link_stats64's
> rx_length_errors?
>
> You've probably read this already, but just in case:
>
> https://docs.kernel.org/networking/statistics.html#struct-rtnl-link-stats64


Thanks for the review Joe.  I think this is a good question, and might 
be sufficient justification for me to get that help on the stats helper 
functions that Jeremy offered in the last version.  I suspect that I am 
doing way too much one-off work in copying the stats from the driver  
and should instead be making use of the helpers.


