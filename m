Return-Path: <netdev+bounces-142443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88F9BF265
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BB283146
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECA9204F62;
	Wed,  6 Nov 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="RLC4zcdf"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022075.outbound.protection.outlook.com [40.93.200.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633520651E;
	Wed,  6 Nov 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908752; cv=fail; b=rM1dfvFWvCSzhCbnZhOXlwHb0OaOko3CqEcmnt9fFen+XkIhkBWI9e6goy0KeA2FzM3ZPz1vP7OeDL02x/GGEgpWEHMRwchdGCGPdEApGqGnLn0dMRjDeQ2SwUwFjAO3XQO94WlB9/B0ZN8ZUSMMMIg0xJJqfc8lXS1OCv5abME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908752; c=relaxed/simple;
	bh=SFIvH2KB8CRV11NzvWFje7NUKVV6eiH9b2tmOammCrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HuASI+BIaNppTFxVncCHi+RFjGnnzWaQG9XFWwygMyQ24oH6+ckcIxXWO41eOFk5M75lOZp8fBw0xxl8EDkoIkwtmAoyMBjj/fKzTMWRYl14al7SP86b8mmFzj6wfCs7of4H4S46ppRnIvemJwY3x1z/2mpB6Vb5RqMuDOFrfJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=RLC4zcdf reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.200.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4W+dHRI6QOYWug20F+GpCujv3gr7VgRX99F38owucphCD2KgKWeADHbZVXKhVRQ8U1xcAgeIQyta32fDqdzEE8JXTxh9a8iZwsOUykpk4jKRfKW1A/S+9toC0wkiDfxqe0xQiUgBd1ULi95V+H4hXX0SGEPq7hUu4LpZjaw7Yt529zCfI+aRb98L/NwYStENbRCNpPoceh0NKFvixincIoLIo18h8AFmPNYI9J1NdFmRC0hDZHBS8za4NWEz9ioTO7xKzDDE3Ei5kK8A1tOizg5nvNV0qEzPmeso2qEG0lI7OfBfqM1VjsxQlokjNGaXNj0xUaGxOAaLaeDL5S0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKSCyw2KlVrZTwfeTTtnbcbkSTzCzJJRTKjDFp2WjdQ=;
 b=SZqTMFb0yctrjUMIUjjRZN7HV8OitzOGbFKcev4Chz+d1i+gS96Nqg8A1zTysLHqlaUJu92T2XkyhFmj/EROGj4eemqNKLJUNhbsH1WwtkiC+XzG681KHIziKu12qI1OzZ0sBBEc8FImyZz+/xAWSWYm3YSzb3Jn+g99pwoB19OXti36X3FlvPcEPmUXz59ec8s7AFJ36oM+bsYFwluWmiool2P9LsCCnwwEUPKiEHHcpVnOvZu339rqZNOTVmU04TTi7T5thp7YDf43suJ5643I5+qYwFp7ndWh6QdJdQhiA1nRc5vtV9cLtw32+l5705fmuDORk24Vf0Z9HUFi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKSCyw2KlVrZTwfeTTtnbcbkSTzCzJJRTKjDFp2WjdQ=;
 b=RLC4zcdfT73ywS1BTlEFegQZ3u1q0nhsQWx3x2bplBTEpAOOOaXjPmtO8CNflfucIjcVeScErqIZGwjq5krCZ3APX94apFqZy0AbVBtc92LafCz4mlBhNEay0NMpl24XxbIFFznsdodv77i5c15gxPvxIgiq2duYmVqNz5al9UY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SA1PR01MB8302.prod.exchangelabs.com (2603:10b6:806:385::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 15:59:06 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 15:59:06 +0000
Message-ID: <3224c94c-e4c0-43f0-9d1f-c68d98594932@amperemail.onmicrosoft.com>
Date: Wed, 6 Nov 2024 10:59:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
 <c69f83fa-a4e2-48fc-8c1a-553724828d70@amperemail.onmicrosoft.com>
 <f4e3ff994fe28bb2645b5fddf1850f8fcc5d1f89.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <f4e3ff994fe28bb2645b5fddf1850f8fcc5d1f89.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SA1PR01MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 76049867-131f-4084-9d8f-08dcfe7bf122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mnc2STV0WmRlOFBRa2Uwd3FlWUVqY0Y0bVpaTEtnQll4aWdLSFpjWmJIekZh?=
 =?utf-8?B?d1pOSlVpTDlwTmVzcFJwcWRUMHlncVhydWorL1lvS1dtYytkRExCcnJXQVF5?=
 =?utf-8?B?SitlcTZ0RVR3aHJneWZvajZISGlhVm5qYVZNUUg5QkQ2akNOeWtUTVdYdXBh?=
 =?utf-8?B?QWRhYitzaUx2Uk41WWs5TkZ3TUY2bFNmYUFNd1pIUlpCYWVYS0ZiN3JwYXNN?=
 =?utf-8?B?T2tobzkybEdxa2xyVkVqNDJUOURMNDlzRXRBR1QyNHRpdVEwK0pVaWZNM3Vl?=
 =?utf-8?B?M0RONzNDRXVkalpiSlAydDBRVGxhcFFsUk8xeWJkdWdGL2ZUMXc5OUQ5SlFy?=
 =?utf-8?B?RG1EZjBZeGgwOXA0SE85ZjZwdmVCNHlGR3dTdzI4QWJEMVRjR1lVTWFXR3Fa?=
 =?utf-8?B?Y2ttbk9KcTlDbHU2Z0RrbWtkWjQ4Y2VTUWljODJOd2cwaGxWd2pMbDV3dWVT?=
 =?utf-8?B?UWhSSHhjdlZWd0RmTFRWdzhSREFiS1NLSGZWQ3VXdGkwQk9rSjE5WGx3T2FP?=
 =?utf-8?B?ZTlLb1A0VldoTDlrMEIvbmVIbGFZQUZTMkYxTlBGVEx0eG9lT3l4cE11eEpy?=
 =?utf-8?B?MkEzOUs1b1c1QUkreSt5N3ZsSzYvYlRHM1JIU2xDUkFPb0Izb3dzb01Dd1pv?=
 =?utf-8?B?R2ZzNit3d2kvSlBSUjdQZGp2TDhtVGtzZnN0Y244RVpRY09Dc3hWeTdsMnZV?=
 =?utf-8?B?N0QyV1lNdERmL3ptVjJ3anBIZW1CTkhqUGpXUVZQUlJVTUVRaWVUbFRGd285?=
 =?utf-8?B?bW8rL0lnR3ZtYUQ3TTZnSjVQc2U4bnJvRTM0ekNiR3pwMVdrZlZCSFhlZHIy?=
 =?utf-8?B?OXh5MjRub2VTbGV6OHluSHNsN2xOemRKTU5oL1Y4UlFHTm1XeEZ2R1JIQjRm?=
 =?utf-8?B?bGIyUGx5TC9kc2MrZGNvVEpiYUh3K2liK3pVMlZzWFpSbHdsZ0RLOUYxMEg5?=
 =?utf-8?B?Q2orWnU5WWloTWRDVWQvdnNtaWt0T3g0bm1ySjh4S20vRU1SWTdHVWY1b2pM?=
 =?utf-8?B?RGg1Q1k5cjRlWDlWZk1JVWhWZmZScjM4aTJCbTNMTWYwMHVOdjBabGNNL3dP?=
 =?utf-8?B?VkIzWDVHZXlkQ3h1RzZ5WXJYTytwYlM3SVhOVWFoZ2s0SlpyT1V4ZGtGRHNT?=
 =?utf-8?B?cHBpdXptcElRZStmMjI2c05DbmNWOEdoazNPcmxRMS8wN2dnOS9OTGpYZ2gv?=
 =?utf-8?B?T1BMdmhqcXdBOUIyZnhZeUVOQUxFRzI2a2czdXRxZURteEp0RkZhaVMyb1BV?=
 =?utf-8?B?MkNTZ3BWYU9RWXhubXh4THJTeVBMalBNditRWjEvWnFYYkthM3luV2JFN0tR?=
 =?utf-8?B?cUNwRkpNMVpLQ2UzMHVGQXFKTHhRK3V6YkdzblFIdnBmNzUvU040a2tPWUZE?=
 =?utf-8?B?Zm5qMEFGZnVERWFGMnY1TVEwTHVLTkhkTVZhUDYxNDhDY2xac2RWVlJUN3U3?=
 =?utf-8?B?cTlzTHdWUVBWMFVxWFJ2aS94VHQ4eFl0eEdNWjN6WXc3VGNKTHdNRWhyUXNn?=
 =?utf-8?B?TFBGZjFseE5iZHpKcW5WVE04M013djU2ZEhkd0ZEazNZdWpDS2xTMXdtdTZH?=
 =?utf-8?B?a09aZS94Q0FqS0ZoWVpQazZMNE1HNkV2UUZLV29sNTI3cUVoRGprZS83SG9z?=
 =?utf-8?B?U2dOTnhMRU5Qdldld2p3T1ZBakRlM3VkNmZ0cWtLWm9KZ2J6TnJMSEwwN1JM?=
 =?utf-8?B?NVUrb2RodlgxRXhPOWNMYy9DYXpQTE9KdjBGYXNteHE1eFZFNjhDVzQrbldy?=
 =?utf-8?Q?iUjKaIDlYC8DHqEzGtyLYDqemUOgmTUQ4ZWOqk1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjc2T1FhclBHMHdwd3JuUEFKeGtydkRFL1psbC95RVR6VWZiaXkzQ1dUSnJP?=
 =?utf-8?B?ZlhFWFdiL0FoTjVEK0VZV1lZRjdNN1ZwVkZJTzZjUkZyWDUzWk16ZnpPSThC?=
 =?utf-8?B?dEp2VTlLanE3bjZGVFhJZFJjWjNobXlua0p6b2VHT0l3UGllb2ZuNzdjN3JS?=
 =?utf-8?B?eEpXU21hN2ZWcGZCUHlVSGJZMHdDQTVkSG9TS2E3Z2NrZDFlcVNGUVRkOW1K?=
 =?utf-8?B?N2xsK2czMDJ1ZkFJRUp3ckpFTy9KTkNQMXovcXBiS1dwa05MY3RoL3N6d1hO?=
 =?utf-8?B?Q0Q3TkhoNlk1dm1BWERnVnJSV0hGV2lYN0hVejlpVWthT1NEZ1ZJbndJZ3hP?=
 =?utf-8?B?MUNSZ0l5bmE4Y2xtMmhHUjFTYjNFeFM3bWhxb3JFb0FTWlRhWkNNSGx1L0RH?=
 =?utf-8?B?WXh3VEo0Vm1tbGFORk1rNm5BZ04vNE5ZREpPUDFmQnhkVVBSb0RzL091ZHBP?=
 =?utf-8?B?WE1ZRDNiWEl4TXNyU1ErTm5QNVFXLytwQWxuc2VsalF0QjJoUklTL21teHlK?=
 =?utf-8?B?dklIeFZZa1pqV3BYSFJOWFJyK0ZhbWlYYXAxbWJQQzZjc0xCWkkrNmZZMDlC?=
 =?utf-8?B?K1NsRS9LdzlaQ01qaUkwajZ2YjRHUnNTZGlyL0lWOFk2ZDdSWTliUVNjS0tu?=
 =?utf-8?B?WVAyclJRelRrUzBEWkxMMzh6YzZCUkFiM0M3NmxzakpxVmtwVlB0SmdTY0Nt?=
 =?utf-8?B?ZVViQXo5R1VqQ0dLZjNDRk0zeG0vTzNZdnJhL2NuZUNHWDBrNWVxeHc1RlR4?=
 =?utf-8?B?L1k5N0prM1BYd2UxOURIL3hIYkVEQUhVSkdYL3ZNUFpqUHhaVGFwOGFUZENO?=
 =?utf-8?B?bUVXa2JUNSt6TDV3dUJtSFg1YVZ4VGVQN2xUQjNtZEF2M1dzcy9IYUsrRlpR?=
 =?utf-8?B?MXgxUnNCSU5teStOc2RpSi8zczZ5d3VEV0R2anlmUENPV01KVlZhWGs3TG1H?=
 =?utf-8?B?VnlRVzIrZHNtMEMvTWNJcW92MnVBUzczMWNVcjFRbUtBZTVYQk00ZUR5REkr?=
 =?utf-8?B?dTRreXkyWkZ1MFRQdGRORktkSWJGNkNNcXcyN3VSOUEwYU9BR2VEcUw4cXlC?=
 =?utf-8?B?SDc5RTB2K2NMU3dKY0N6OElESTBwWjEvU25tT2lDdGJiR2lJTlYzbXYxeTN0?=
 =?utf-8?B?eWdPYTRlY0d4NzhjUXF5czNoU09BVUxaRElQU2VqSXRuY1VZdFN6cXVLZGtP?=
 =?utf-8?B?RzRKbE8vTFdNbkwwYVdhMFJVTDNFdXRqMllkck5xRTA2Wm8zVGZtdEJuSHRa?=
 =?utf-8?B?ci90eHIzN01pVWVRS1NHWnBkUHZFRnpKNlEwbmlLTWNPdy9wUUFYLzJsODU1?=
 =?utf-8?B?WDlYQ1pRTVdZUGlsaEZIQUhsWWxtTHIreEw5WC9ZcFI4cWxOWUJwMzdkdS8y?=
 =?utf-8?B?MlFnakZsdWNpQS9ybVRZN0UrclZsWG9XZlJnRjAxaFBPaEU5UkNFSWZsK01H?=
 =?utf-8?B?bFNlYVNhbFRFWDRCam5NUTEyTUIyeDFkUG9CV3FZb2dUYzBCRzBvcFlIbGZ2?=
 =?utf-8?B?T00ySGVERWhYd3Rwb2xIaG1aZ2llWFlHNmwzVEJIcDl2Mk1NTG9IbWdmMTNT?=
 =?utf-8?B?OUI0SHI0UmpJSVpWcjJEbEl3ZjlMRDh6c2UwZHlJZGtJd3hDbDVrREJMUXUy?=
 =?utf-8?B?UzdUdGg2TEQ2cVVzWkdMUHErem8ybzlPOHFwMU1VY1g0eWx1NUdIYjdiL05Q?=
 =?utf-8?B?TDVBbXgrZGwzY09Xb2JoTXJlMjlaYWwyaVFVZk5SbC82RHY0N0dUc01jWWww?=
 =?utf-8?B?YXNIYU42RldGeFQxd20wOXUrV2dONk1yenpQK21OcHlwUkg4SUNpVWdNWEVp?=
 =?utf-8?B?UXRnc0h5TzNLbnd5VHNOUWFoV1g3M3pOcVdsQ0N0SXNLcFhSeU14cmRNRk1U?=
 =?utf-8?B?RmtoS0pZTk9KNG83OGthR0hCTUJESFArTzJUVi9nd3pmR3JTTkpQY25JaXZG?=
 =?utf-8?B?VFVrbUdEZ0ZYdmY0WkFDQWhnbnpQSEdEUlB3cmZ5U3hCMitvSWNabVdlbVdu?=
 =?utf-8?B?RkFjZnloUFJMaUxzVSthZ0tWTlJxa0pBUittTFlFVlZhVXdqd3ZDMkxUN1d3?=
 =?utf-8?B?UHRyL3ZnTkhjVFJxcm9ZZjJmb0k0dlRTK3kzUzdxWlg3QmxlMW1tMWNGZmNs?=
 =?utf-8?B?MnFDN3huUVN1U2JhWDZXeFliNElEaGFoTTN3RlZiWG5aeHNJTDdNa1ZmTGJl?=
 =?utf-8?B?bFNrVEtxYXdvTUtqVTdpSzFPN09OSTFsdnNBOW90eFNzRlNVNDNHbVVBZ0l0?=
 =?utf-8?Q?w/VPtx5HkadfHQ5u/BorsgB6rB4+2xnEOfhn4MOZfo=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76049867-131f-4084-9d8f-08dcfe7bf122
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:59:06.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s4JEJEvEanaAJWOIivTATVg7jr55xVO9F5ri24N3Z8XJzw9NsnVzwbioUJH3Wo55e0FwFOtQJ/jZcGklmrAYHfJfNZP/K68pBwnvuIFc59mdOB+XYtcI84OPb6TYDWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8302


On 11/5/24 09:09, Jeremy Kerr wrote:
> ok! so there is some form of addressing on the packet. Can we use this
> subspace ID as a form of lladdr? Could this be interpreted as the
> "destination" of a packet?
>
> You do mention that it may not be suitable though:


In the header of the packet is a signature:

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#generic-communications-channel-shared-memory-region

"The PCC signature. The signature of a subspace is computed by a 
bitwise-or of the value 0x50434300 with the subspace ID. For example, 
subspace 3 has the signature 0x50434303."


This could be used, but the inclusion of the "PCC" is unnecessary, as it 
is on every packet.  Thus only the subspace ID is relevant. This is the 
index of the  entry in the PCCT, and is what I have been calling the 
outbox ID.  Thus it is half of the address that I am proposing.

Two way communication in MCTP over PCC requires two subspaces. The 
return packet would have a different subspace ID.  Thus, the format for 
the physical address is combination of the two subspace IDs.

Say the PCCT has two entries for MCTP:  0x12 and 0x13.  12 is the 
outgoing for the OS and incoming for the platform.  13 is outgoing for 
the platform and incoming for the OS.  The signatures on the packets 
would be 0x50434312 and 0x50434313, with the last two digits being the 
only ones that would ever change.  These two channels are Type3 and 
Type4 by the PCC spec, and are thus paired. So the physical addressing 
scheme for MCTP-PCC instead uses both of these address, and uses  the 
order to distinguish which is which:  for the OS endpoint, the hw 
address would be 0x00001312.  For the platform, the HW address would be 
0x00001213.


