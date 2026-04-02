Return-Path: <netdev+bounces-274391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLtrFuMNzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:34:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45338487A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E463C304EFAE
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3B31B131;
	Thu,  2 Apr 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NrkecIwz"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D231D39A;
	Thu,  2 Apr 2026 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111452; cv=fail; b=mN7avm9DXEZ5WwAT9Sefy4wrIN8Cn307J6kCr432+/dEkYGXNhICL4v11xvU+eP3RCBJxADkcQEB80zjzCtrnrbe8ULLpBx2P4Dm0iZcofMthDCh9YZ9JI4afAtHqzQPm9zgjNqnnhw9L8m1CD2Qs+LGMzX7Vscryf5pAE+2CDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111452; c=relaxed/simple;
	bh=p8PNYnn/5d1EJPyY78scZumDKvqXetSMH/fdO2iZrZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HIrYXBAGLVCy15iwtHaQPcm1qU5KP4gcLqfVJ0RZw9f38S5A3S+9EyLkacG+66BehG0qG68VBsRhray+qYN+0dCeoe6VlFdFBZW8/gcM/ENR5CMHMpu2K9JAzNm4dt2sxGq3GgLMmKXIrf6I09WRsZ3g9NIpDVbmR1Zr/fZsNkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NrkecIwz; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqSaTw1DZqwB484ZV0TaxomnArY2jiuIel3u1MxioOEzEmeqp2UzoY+Hz/bNsJFIqwAhg/Y5P6GZ6H8IfNSeo/H2SoYQ5c+nIVJPdae4qTcsAmuz9BClTrpLhq6yukzmncjfbRdb0D7t9EEUcq846UQgqAEvKg+H5/Zi+SzMIKrHT81iZvJM2ZYQhrNgD863afFBfl8oxFKMqGEJjMTbWqrazslGPakPyc6th23bePrHz84xGpgQx/1wJp3p7j7XEFFW+C9Hgzj02Y6AtUNgyQNCPePvGejKW/VGgmMRpe0pt7a9DCduRsruTWNjVvoVV9hO1rU0XSLQGPqpIREMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+l5j7m/jxCvC4B6Huz7B7x7K+fSWppJrPzDZoDeYq0=;
 b=QAOHCF+wyV8o5WFkb1xX3ULOEyqv1QV0arjMRvU9yFT/VoJVscwNcRkN9BdMWE6fCmMmyxa/051aAku1Gtmfm0fXbxDrBkzcY0UVI3SFbPD9uw+HxFjdfNFImOjkiQrAB9BZXZtJY8Z8Dj3i4US0kkUfFsqlYIUsMj7GVSorwXu8iNyi3VDMlcjCVmg8uu5kVu3iDt8DWN6yMUUF0+HCUKUBmZSey/t/UgK62ZHMJD7fk8KzBLHpYzYFGqXFHaCLr3jkVdu1/H/+FYeB1wvibRz9Mqgd86LyN3PZZTV/B45RJfOJhCtS9aozRNfAurFWYdGzwtp4MQ83aFMgTDFtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+l5j7m/jxCvC4B6Huz7B7x7K+fSWppJrPzDZoDeYq0=;
 b=NrkecIwzuokj/p56uGiO4PmJDRDIii8H72fi0taFe8SXQ8PfIEs7k+esRegr9LkanwLJDnVydmFDoNfNLCcaeE0uc6JFXXzPGg1K6D8sCwo7eOK6OAwojlIi/P7ndG8UJScKvQQGYWZI5ScOXJcMnYtm+fRBuopOfyv0mrv/A2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 06:30:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 06:30:44 +0000
Message-ID: <1d9abc6a-9032-4e0f-b7d8-1bdbdfa0d615@amd.com>
Date: Thu, 2 Apr 2026 07:30:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 05/11] sfc: create type2 cxl memdev
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
 <69ccaa8448da1_1b0cc61009c@dwillia2-mobl4.notmuch>
 <f0f5a510-4073-444c-9f05-7153d0b2087b@amd.com>
 <69cd93e334c11_1b0cc6100fc@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69cd93e334c11_1b0cc6100fc@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0193.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: f59cfe3d-6c9d-4b7f-b838-08de90815e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4RHSU6j/lKYz18RbWxBS5Oewxa8/Ek08GENplOa54RNYGl0Q3xlev3Hx8sv+AmTcEIysM7LGhfT8YpRcBTGo3te6DxBR+ZLgc46wzl2/HRyM2jNWwennrgSfhjVMx0L8k4aSqj/K0ad9363sXqKDW0OTLfHtECVWPLA/4Cf4SgjyxB5FzMtDcAefgLcK430b4yFj1hARGnk55hmlrUXj7rXPyfyDOJf/njTpj33flcHPLWQZmjT4i3sIdTMNHeTOGn+c59CrYCuZMcG8LVHZ2hY6EJfBwlFeQotwY3hn3Dl/Ahl21rtHwQEvLQlzULosx/PZnLyFAtZE9IOwZpyrWfjZ/tw5pDWFL9WmKN3AqNqrvMQh/IFZiSe+7s6TQB3VFsdcwtM60L4pzpKqZjhqsb0zWJZ00I8aiGAjKhGQpvu0Sk/IJ8/OUL+ACgaBeJ/k7jutGkKDa4C1PEU+Pv+G5TLoFI+p2bjviUSN5M6bEEMKE7YAhWg5s+OA5wmfhfMepzP1gel33E7owlK+chMh+X82k1crp0iUorarLWHU0T0DAyz8q6Ay4G3NN3OXUDdLod9vaRIiT6LCxnV0nq7iuMzOUjamiKldmamxrGV6JHzrB5Om3rcK1+yC/VxNdh7BrPAbHWzzPpZM2o4oCssPiVbuDh0YRr7iDDIzjX3wtfHr2hDVFkKd/tPef5l+EVrKh4a5SrRVHBVuSlNgsuFbL8hB6MUgukRXi7xmcD3FqyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHU5WEVscFZkSFVzS0pQNmFTNVRiam12TC9NYVp0N0kxZmhwUjJFMS8vWFMr?=
 =?utf-8?B?enE0aW5CRjRINklXYnlLcmdBQlN1UTZHTlZjVXFGS3crSzBwbVFCZXEvN2xH?=
 =?utf-8?B?b1FKeE1rNHpwQmtDek9TMkxJVnRDS1lDdjdmaXZITlB1WklEejJjMEhEeWgz?=
 =?utf-8?B?UmFHVFl2U1hXR3MzRlJScVFFN3IrWDlDZVVrcWFZQkdSRlFsK3paZ0xUSXRU?=
 =?utf-8?B?a01DZzBPNzc5dWo3Mmo3K0NaMU9nUHpOOXhXQ3l1Qkw2MkxYc2xKM2pIN2RW?=
 =?utf-8?B?dWQ0UGRiMVYwOEkwTlZZeHFxQm1yUVpCZTVSV2xpbi96dmVvV28yb2pyMU9l?=
 =?utf-8?B?RituZGVaZjZKNU1BYVBmWTNteFpZdzFVajBNWE9nUVRFVVdGajB3OHdTdlZD?=
 =?utf-8?B?cldJaEorUDkvK2dYSC9ub2p1Q0JxcERORmhObi8ydCtvcDNUcUhvM2t6WDA3?=
 =?utf-8?B?Y1NnK09sc2QwemZFOU8yZ3VkbTd5bnF6aW44OVVjdmZqajl5VUt0Y0l0ZDdB?=
 =?utf-8?B?cStwVUhRSFZTT1FweG52eDgrVzVVR2Z5WE9BeFU0T2xlY2RvWTlySDJYV2wx?=
 =?utf-8?B?SVdVZWFweWZDYVB2dnlsWGg0MFRrTk9qRDJIRDgrNFpOalpPZENPdW5YeEtR?=
 =?utf-8?B?NWIrTzVBbUV2NTZTekVoTTFXR00rN3dRWm8vZ0xWbmFXOEw1SmRSaStkRUxu?=
 =?utf-8?B?NnM2bUdlSzJBZHp1b1dCYlhyNHJUQUZzOGpsTE1kb0FVMjZpdlA1ZnhNRWdE?=
 =?utf-8?B?aE1TRWJ2OWVCa0plMHFkajZRSW9SWGpJUzR4bXg1dHZYWGdBdkQ1K2h2anNq?=
 =?utf-8?B?NHR6YkpzSkpGOHorWEl6UkxYV2toSSs4Q05Uckl3TkJpOEZLdllLUHMzL25M?=
 =?utf-8?B?UC9najZoendTb1BhaFQ1NzJKdmloWWlkR29sZy82MkpUNFEyVDVwSUZUUXlv?=
 =?utf-8?B?cHh4bVpQQUY4QUIwVXA5RFlYUmlkS1pkd3kvRkRCOGdOd2FZb0JpeHBVaTVG?=
 =?utf-8?B?Tlg0dEc4elJ0Qm9Ud1I2OWt5YXVxNEE0czVsQ2owOGkydGpzUGY5dW80MTcw?=
 =?utf-8?B?cXpYY01ueGgrOVlTbVUxRDU5SVY1UHBoVmtOeHFPUGlIcjZKcXNQR29UWVhy?=
 =?utf-8?B?YkRRcjcwc1R5ZXUwei9haXdtbllpZk5kN3J2R1ljeklUNWc4RlEwL25ZSlQ4?=
 =?utf-8?B?UXYrVFlUR2RmUXYyL05ydFdSb3NrYkMyMlB0V0RWY0U0bXFSZ2VXek52LzZm?=
 =?utf-8?B?RVd6aHVSUkZnbzNmMGU0SlZmNVl3VlBibFZ4cUIvZDQ2NzhGZGNabG4rSmtw?=
 =?utf-8?B?cjBVaC9LaWlkMXNjZGNPdFdaeTN3MDVaajRzeTMzV2M1MFVGOGdRb3FQNzJk?=
 =?utf-8?B?NldEK245SytZcDFsTE9vQXlNMVNuSHZuaC9NOXdIWW9QRWdRZktMblM4YmVr?=
 =?utf-8?B?SUQrQVE4VlNKcktsVUlreks4Wi85bW5Zb3owd0lFSEdWQTlVbENVaUdocStB?=
 =?utf-8?B?UVQ2TEUwbC81bElKWWdxaGU4Y0JYcVZmRjZOL2tDQU1hSWh5VEV6MlQvSDRK?=
 =?utf-8?B?azcrRC9PM2RJTkxYUWlZOXVoK3UvWUovVDZBRzNKQk4xeHptWkNvUEIvL3Nn?=
 =?utf-8?B?SWJnUXJHNVdQYXpJOFpNa3NMMmRaT3NWdlIvd2N3TGxZanErRXFBOXlLRHV6?=
 =?utf-8?B?YWNrRGpjRnYwMkVJcWk5djVUM2QvWG1jMlUzSm0zOTM5TFlXeFhDakp6eG5Z?=
 =?utf-8?B?K29lelJvQ2ZXb0lpQjFwaWp0TnNkeUpBbFdvMGg3UzR0Mm1GWEM3KzdxTDZC?=
 =?utf-8?B?T1pUNW8wa1JjdWRISTg1dyswSDloNS9xcGh5eldqK3pyaDJVQjA5N2JnZjVD?=
 =?utf-8?B?SFhscVdYaEVtYm9pV09IWHJCZ216Tk9MbGpMZk1UbjJYRVd6Q1J4ZG41bEE2?=
 =?utf-8?B?NHFnanVXWWFqaDBMbzZIYlhaY1owaXZEVUd4Y1ZXKzlNOGdYbkdVQkFwRFMv?=
 =?utf-8?B?QUhvTEEwSmE2Nk8xdXJXV1BEK282c3lnQW9rVzJPWTZ2VFNzQWRWSHlvNFZL?=
 =?utf-8?B?SEhYamp0OUN4UW0yUWRvRFZ5R3dscDdjb0pleER4ZysvaVhDVW0wVjBFb3hO?=
 =?utf-8?B?WGt2NjFvU05PU1g5NzRQVTVuQ0crRXdnOTZQckkzeWNFTlJ3SW40cG8yaDVW?=
 =?utf-8?B?QmFMUHBvVnRNQnU3SnF1S29OME8vWVFqdTk0aEh4Y2Qxa3F5WHJobWVWVnZ0?=
 =?utf-8?B?ekRHcFN2SUp3eVZKbW1HcWxabnhOZ0UycDRtQnhVUjZldjlpSkFHUG5TZ3lr?=
 =?utf-8?B?d0FiR2Izdi91OExqNW9zY3NnRjV3akdYVXpFQWI1cDR4V1hON052Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59cfe3d-6c9d-4b7f-b838-08de90815e48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 06:30:44.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7I9oQvP1H1BQ6JVDMdELykIdPioHlW8wrPjkfktqqMXl946YgZbt2EUdQ3Lb5UKjwTVCqScqgF8d0RuTEiVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274391-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 2B45338487A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/26 22:53, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 4/1/26 06:17, Dan Williams wrote:
>>> alejandro.lucero-palau@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Use cxl API for creating a cxl memory device using the type2
>>>> cxl_dev_state struct.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>>>> index 6619084a77d8..63e6f277ae9f 100644
>>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>>> @@ -75,6 +75,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>>    		return -ENODEV;
>>>>    	}
>>>>    
>>>> +	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
>>> Did this forget about:
>>>
>>> 29317f8dc6ed cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation
>>>
>>> ?
>>
>> I did not. The idea behind attach does not make sense for sfc, so I do
>> not use that option. I did discuss this with you at LPC and based on
>> previous comments which had not replies (case 1 in here):
>>
>>
>> https://lore.kernel.org/linux-cxl/836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com/
>>
>>
>>   From our conversation at LPC, there is no reason for a CXL device
>> connected to the CXL Root Bridge not having its memdev properly
>> initialized.
> The cxl_core can not make assumptions about attachment topology. It has
> always been the case that the cxl_core needs to be prepared to handle
> everything that the firmware did not.


This is too much generic as an argument. If you want to convince me, I 
would need a real case where this can be a problem.

The current assumption and the only option supported with this last 
version is the BIOS *is* configuring the device HDM and there should be 
nothing to do from the cxl core in that regard:


1) BIOS configured and committed the device HDM: CXL.mem is used.

2) BIOS did not configure the HDM: CXL.mem is not used.


Any problem with the memdev initialization *requiring* your attach 
option is helpless ... if there exists a reason for it being helpful 
because the memdev initialization triggering the port and hdm 
initilization was not completely done, please explain why that could 
happen in the scenario I am presenting with an accelerator connected to 
a CXL Host Bridge port and the BIOS configuring the HDM based on the CFMWS.


> Error handling and kexec also lead to
> situations where the boot configuration gets invalidated and needs
> recovery.


Error handling based on RAS is a follow-up work. CXL reset is not 
supported ... and AFAIK, it is not supported by Type3 either or it has 
not been for a good bunch of time. If so, I do not understand why this 
should stop this patchset.


About kexec, it happens without a shutdown ... so if the system does it 
without proper handling, nothing we can do. If it is properly handled, 
the cxl core initilaization will happen ... is it handling the case of 
finding HDMs already configured (kexec will leave them untouched, won't 
it?)? From a type2 point of view and using this patchset, if kexec was 
executed after removing first the sfc driver, there should not be any 
problem. If I am missing something about this, please explain it in 
detail or give any reference I can look at. FWIW, I did use kexec a lot 
in embedded systems and had to deal with some hardware needing special 
treatment before triggering it, so happy to learn more about the 
implications with CXL.


>
>> I did ask you specifically about this, and you mentioned links on CXL
>> switches not ready, but as I said then and repeat now, this is not
>> what sfc driver expects at all. Only a port from a CXL Root Bridge
>> makes sense due to the latencies involved with more complex CXL
>> topologies.
>>
>>
>> So, from that list I wrote in that old thread where I tried to summarize
>> the problems and clarify the confusion behind different concerns, the
>> only issue is someone removing cxl_acpi. I do not think that should be
>> possible at all,
> ...but it *is* possible to remove cxl_acpi, it *is* possible to invoke
> 'cxl disable-port'. The fact that it is possible contributes to
> complexity, but it also supports flexibility and is a building block for
> error handling / recovery.


It is possible but, should it? When should it be allowed with drivers 
relying on its functionality?


>> so something should be added for other modules depending on it
>> avoiding its removal. I would say any CXL port created is (in X86)
>> dependent on cxl_acpi, so something at port creation invoking a
>> exported cxl_acpi function could do it, like a cxl_acpi_users counter.
>> This could also help for visibility to user space about its usage.
> There are two choices, fail removal or handle removal. There are some
> degrees of freedom that can be pared back, but outright blocking removal
> is not one of them.


Why not?


>> Therefore, I do not like the changes you propose here. But, if this
>> proposal is the only way
> It is not a matter of like or dislike, it is a matter of functional
> correctness relative to the state of the subsystem today. Simply put,
> one proposal handles the locking and lifetime concerns, the other does
> not.

