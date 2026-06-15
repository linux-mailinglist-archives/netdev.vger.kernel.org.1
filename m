Return-Path: <netdev+bounces-299490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WIs/CJIQMGoDMwUAu9opvQ
	(envelope-from <netdev+bounces-299490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2D687547
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=mqk71ZP7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299490-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299490-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16900305EA8B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE73FC5A3;
	Mon, 15 Jun 2026 14:47:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763F3F39C5;
	Mon, 15 Jun 2026 14:47:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534833; cv=fail; b=fSg8BzoLnZXOq3Ht6vO3hteuV4nFnd60yv8Qt8gU77Aq1bW9G08LQRUjRtrEZIVPjeqmjISfXNFp/+j8x5/OimTe247ZQ9N39XpEJXuye+s4ZL3x7J0KuuDWA2Oatvpvi0nKnxjigqyA/+avTl7khWYCVPbVayp1atPiSkV2fps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534833; c=relaxed/simple;
	bh=sl6C//3rvKTf0YYNgDrZoFjFJVIek3PlLHeaOvG0PhU=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qXn95LTueH8X6TTdENco02I13DqeLWeDGZZ9CVQd4/n2ZTX34+iOPq6SSDgoeUzg6iuxzM7OxL+podJW09ix+aD1rw9DS7LUOCzloh41yGRJl7gLhgJyOKr1icCS5hBZEKbxTe+27MpZl1fW2ZvJWYp0kgR8JJIdZN/ujPmjCPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mqk71ZP7; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u18W30bcjX5WKw4tmpt3u5xPbHdwlC5eUjYnZXAPUw2KLB/X/DsIwiZhyq28gCKi47ZM7J/rLyYwI9BebvUmo/XxGKodtCx+WwixK5oXlJ+1aeeWaRDJj5YS3lmI3CsQcr014YIra7SWjFD23kJN/foqhyzVc+7cGixX5T1tjKHM0PZug2U1GLn76FShNRVvMDMrmkaAgJfyaPL1RfQlpZhjiSFy/W0lqMpFRZtekxz0AH50l9FwEAJPn918Ox4jbHwb7D89HkRIF4d4oHFHrBNjMxYKO3kMoWvSGqS5gkNuIxJkK1K/OScRRNWurDrZoelp35FS5pnA8OBn7QaK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH6qDligeCpC3ae8Bh+RVor4nKDmW60ekcpA/KxJLBs=;
 b=LNQZRpC+F+S9oDGw1Hp3r69dGCGzHhJGnXT47ALDocG2YT2yUWYAYnWBaImp+Jq1WMhGmN8Li/zsIG3nZsLRmwRELeTbJpleo1hKBOjj4H/rFEypoRT9OJqBz4QbpbTzGK2C67npF/Lb6bEqQ3iqX3L+9rdsHRUpGImlVSGLVDygIx9qaer1mb4CuxCiyGLNEk20tivAKCZGs9X8bbn2oP/45882cKq2kb1ahCBZMRXtXW7rQSqkMu4jwi+053hWy+8brlxvBsQ5LqgXMwY7FlXyTJ2lltM4xFNaPiSJKmmVWQfE36FETej6IGjfy04W6zc6adn/3pIlOp1V4ATpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH6qDligeCpC3ae8Bh+RVor4nKDmW60ekcpA/KxJLBs=;
 b=mqk71ZP7NNvlAqYh7fdWbBA10FUmSuClKpclLbOYkTN9T7LuG9yaBwOE6lAtckckFTcdROPmZXYUAi6zZIcCfKBK8hUNkV6UKGNoLwTJrI1wPNTGhLEmh0X9CgpdwRmC95uIFC4tg2QRClDQTVu+3BGDhMg75WqxYNMGYL9ZUa8=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:47:06 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:47:06 +0000
Message-ID: <50d8e423-8248-4e26-901b-010d14d22e67@amd.com>
Date: Mon, 15 Jun 2026 15:47:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
 <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
 <dcc502fa-1a06-465a-abab-9b039b9c2672@amd.com>
In-Reply-To: <dcc502fa-1a06-465a-abab-9b039b9c2672@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0246.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::13) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9198ba5f-5904-4f9f-95da-08decaecf895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|921020|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	62K4+6gQpGq5ccm2rENbzV/Ro+hNpxvPH+yIbgyeCu9kAU4inh1etGf3Ai4LsaQmLUK6/xTbDp18Y1NsszoGcDN301BsRdhlwKqVL3tkkOEwo+9oC6kL4RPWyHA8ZSmYvZ4vu628scRr9kEwWAr9DFwrlJzM5OnETWhiO+fqDnAf/bar+vlvYXmSuT0cx8N0pRJdkoP0s/fKH3KIQrx8yFfxPeInp2DSjntzlNsL+DSYFCXsYLg1vlbpKAklHCSglCgJ7BcA0V3M2ywlA3iHUSORhiF4f/7GwUoj2EWlK7F/63fDWKjbVNmi1NA+hiDJFQRfxSiEGytV0DB641hKUCXk9FITnUABaXk2xslDs4avxFxAQdJ+r0lYNs+y2LD3dvwMSM7vFg++fiFWZ+0C62c6aOEzWHcM1rDhjhEMnyWh+BCL8CMW/RQpADE2xdAZi8Vio7WA4p+aYdUL4Od2fX8Y5OrT1CLM91zbRWJIKoXSvdZtK0uIWdC7WtcXXGL/19ju0X2x/cABP7LsGS4XVeqDVH+qRT9PlQfDP5sACCoWkAp6PB5XT3tAKMgd9y6k6jeZvK90x+R27aMVfkXCPcV5ztJAsENqlqsLCuIT2OnlJz3/XEAQc/a+wlmgROV2cWfTj8HNke7wKIy0LFK8MlJy0OgwkvzNuKNljXkYCwQ3gqvLvds1AF+66isciubor3q3lFkKPFhYPqLhNJstdkeGm+EEbshmkbH5ahmerD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(921020)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R000bjlkaHlEWDNXYjJRaXBkWWVqSXBsY2NLTVBBWWxKUEd3WU5IdktSZDBM?=
 =?utf-8?B?azRZTG56R3BORjlCYlZ6UDhwa1BpZ29Ia0FsYkpJY0lHVElCc3M1NzZ4aStn?=
 =?utf-8?B?Tm9DNFJzQ2prMVJPTzNiSzJFRDNZWWlWbUdvNjRCRC9sTkgwM3hiVGNvWmxR?=
 =?utf-8?B?SDZFRkZ1ZVA0QlFpRkl6NUVmVWtHeWFMVXZKdkRrbGlKRDlzM05QQ3pHSmFE?=
 =?utf-8?B?OWtPWTlJQUU3MmkzNm9nOS9Mekl1eDdvbzZ1a2o5ZlFvdEdsZGtTWkFodlBI?=
 =?utf-8?B?eFk1SXFkampkbFo4YlVraXhXSExiSFVxWkg5MjR1eDZQNGFvYmo3TDFIcWJ4?=
 =?utf-8?B?MFk5cHdGVitTQW5aY3NzYW0rMGNIb0xESnZud2tTNTFxMlNtWVpzUnNhSWlU?=
 =?utf-8?B?ZDk2ZFVlTitsVEJxUGQ2Z0d5N2tmc05BMTVXL1FUUzVPMHM0b2lScUw1OFhU?=
 =?utf-8?B?U2Q0cGZUaWxDb2ZuNytkN0hNNmZYakVmV2VzS294MDNtTGI2VmFEUnd4aFRz?=
 =?utf-8?B?Z1l4cVVCZ1dkb1J1V3dkaUpBcUJOL29kd3Y2V3Yrbm5iSW9qNXJKQ2JySFA2?=
 =?utf-8?B?Q3hMQlhySXZvQzZxa2ZTazFRSG1kYU9tOTI1MEtWUUFpWjEvMGhwNWtjaWZx?=
 =?utf-8?B?YnRENVRXaTF0Zy9nejBHUnJ5OXRvYTJJSGpsSkUyaVV6R0E3N245L3JqS2Vz?=
 =?utf-8?B?TDJJWVFlUVlEMkZocWxDZWd6Uzg4YU14M2taOFpXL3l5eUJNcm9YWVF1TmhV?=
 =?utf-8?B?ZTRKTVdETG0vUHRKcUVRaE5iV21aZDZ5NzBzMDhaZU5vcVl3UHg3TmR3cVZw?=
 =?utf-8?B?YWVUQlVDdlpwbDVxZHQ4NUNYc3VJMHRxd0pDQ3pMblpFdGRUVnpGRjh5REdR?=
 =?utf-8?B?WW0vQkJGakFreE1RVnFNcktLNzROeUZzSlB0Tk9aM0llZjFsekZYMHl2L2dD?=
 =?utf-8?B?eHlJZjBjNkFCWlYvK2pmR1U5aHkwV2FBRklCZHJpdjFoTXBPb1BJaWFYN0N4?=
 =?utf-8?B?SnZEUS90SngwdkR5WkI5cXZRMmNPUURtTGIvNG9VVDh6R0o2OEp1c1hybzRD?=
 =?utf-8?B?MHNxZEtJQkd4b2pYMHQ2Uk9wYWhVQnorcHFPb1RhUUFvcmJKZ3RXNi9RcC9K?=
 =?utf-8?B?ZmllQVRSaE45cnU4SUF1b2RTU1ErSjZEdldPL3J6ZUJOSk84TWc2SjBxeVU3?=
 =?utf-8?B?WklVWnVYYnJKT3RTSVFuS1o2WEpMckxXbzZSWTJxQ2paY2ZLb0VGSVNIWmtl?=
 =?utf-8?B?TlZhUGdJWnVnWUNvNTJzZW9MdUE0b1F5bGxma2QrNTloaWRuSlVRZUMxVVZv?=
 =?utf-8?B?ZmJsTTUyUEtZYWlFRUp1ME9IL2xnWDB5d1dCQ1N2bjJBK05WUklkeXkvOW1O?=
 =?utf-8?B?NEJsRTcyUTRha2VkTjVVMW96T0xBaGdjYmMyNjVwVXdZeTMyZEUraXFpTUU3?=
 =?utf-8?B?OUVNbGJaMlpxeWRaNWVzK09QTEMxNEU4WDRaMk9WNlovT21TcnBXVVZlYjdz?=
 =?utf-8?B?NmppRG5td2lWWkQvVkwyajV3M2Y4YSt3WWROWGNJKytKRkdMZFFrZ0IzMnRO?=
 =?utf-8?B?UEI1ZnU0aFplbi90cC9KWVNVT2dXNHdrTExmMGpWb0xBYmM5NkdJUXBFaG5V?=
 =?utf-8?B?WEprZU1nd1l2dmRYVW9sQkw4dDFvaFcrVmFRcUU1ZmFMZHc2QUs5NVJmdUFL?=
 =?utf-8?B?djM4QlVQeExQMm5QVHhKeTFiV3U3b0RLUEUvQVpKUkp5WnM4eGt1bUdybW1X?=
 =?utf-8?B?bGszejVPbm9ONXJ6Y21IUE9zK21CaWRSeWhIMnovaTNvM3IzOU1Gdko3eG1F?=
 =?utf-8?B?dy9ValF1dE1uWXJkdHduVGV3Y1pvMDdIVEJUQkdxR0JBS0dVMGVST1Z5QmVR?=
 =?utf-8?B?QVlTR2VwR1FFVzI3L0JtZlk1VkRiMjhwamtjRFpKSnF5S3RlQ05BaDI4WTJU?=
 =?utf-8?B?SnVTZC9EWW1VU2djS0tiZm50V0padDdKeEFkVzdIc09RUldsQnFSSDZkanFp?=
 =?utf-8?B?RXF4NzJyc01XSDlzWVpxY2NYamU0ZUk1TzdsektXTVY4M2swZ05vQzYyZHZS?=
 =?utf-8?B?YlRwaUZqQ2IxNTJwcG9FK2NFWDN6bUk4WFAxT0JIOFBMczE5UWkxdTBnaG4z?=
 =?utf-8?B?YlcwMndlU2tsUFc1alJCdGxxYzBucllFTzZkZU5UeURZa3k3M3JkL2pLRHo1?=
 =?utf-8?B?SmdRZUh0eERKUW1VeTg4Z0hhS0NFZXp5SDhFa1ZyNG1yZXJRQzZmWkRINmFI?=
 =?utf-8?B?UGsyMWpjd3NxNm1oTzh6cmNHLytQd0crYmJFdmw1Y2hvVGF2NjNZSXRSTnJ5?=
 =?utf-8?B?Q0t5TGhEclFGVnRLaGF3R2xPMWljQ25LOWROK1NnTzFWdEhLbUI1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9198ba5f-5904-4f9f-95da-08decaecf895
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:47:06.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLp+hPHpD9GIjupeJhw/32ONUIkzMjVbFXGK/wwNE1Giu0NcB8PbSHpeNNzzmIbflrFwDyQCd0MPTKuBqICO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299490-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88B2D687547


On 6/10/26 14:56, Alejandro Lucero Palau wrote:
>
> On 6/10/26 07:10, Alejandro Lucero Palau wrote:
>>
>> On 6/10/26 00:30, Dan Williams (nvidia) wrote:
>>> alejandro.lucero-palau@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Use core API for safely obtain the CXL range linked to an HDM 
>>>> committed
>>>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>>>
>>>> A potential user space action through sysfs unbinding or core cxl
>>>> modules remove will trigger sfc driver device detachment, with that 
>>>> case
>>>> not racing with this mapping as this is done during driver probe and
>>>> therefore protected with device lock against those user space actions.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>   drivers/net/ethernet/sfc/efx.c     |  1 +
>>>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>>>   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>>>   3 files changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/sfc/efx.c 
>>>> b/drivers/net/ethernet/sfc/efx.c
>>>> index 90ccbe310386..578054c21e79 100644
>>>> --- a/drivers/net/ethernet/sfc/efx.c
>>>> +++ b/drivers/net/ethernet/sfc/efx.c
>>>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev 
>>>> *pci_dev)
>>>>       efx_fini_io(efx);
>>>>         probe_data = container_of(efx, struct efx_probe_data, efx);
>>>> +    efx_cxl_exit(probe_data);
>>>>         pci_dbg(efx->pci_dev, "shutdown successful\n");
>>>>   diff --git a/drivers/net/ethernet/sfc/efx_cxl.c 
>>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>>> index 4d55c08cf2a1..d5766a40e2cf 100644
>>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>>   {
>>>>       struct efx_nic *efx = &probe_data->efx;
>>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>>> +    struct range cxl_pio_range;
>>>>       struct efx_cxl *cxl;
>>>>       u16 dvsec;
>>>>       int rc;
>>>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>>           return -ENODEV;
>>>>       }
>>>>   +    cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>>>> +    if (IS_ERR(cxl->cxlmd)) {
>>>> +        pci_err(pci_dev, "CXL accel memdev creation failed\n");
>>>> +        return PTR_ERR(cxl->cxlmd);
>>>> +    }
>>>> +
>>>> +    cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>>>> +                    range_len(&cxl_pio_range));
>>>> +    if (!cxl->ctpio_cxl) {
>>>> +        pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>>>> +            &cxl_pio_range);
>>>> +        return -ENOMEM;
>>> Dave caught the iounmap leak, but another concern is since you want to
>>> continue operation if efx_cxl_init() fails then you probably also want
>>> to release the successful attachment to the CXL domain if this happens.
>>
>>
>> I will do that.
>>
>
> Looking at this issue, I think an error when creating the memdev or 
> during the region attach triggers the memdev removal, but ...
>
>
>>
>>> Minor since something else is likely to fail if ioremap is not 
>>> reliable.
>
>
> .. if we want to specifically do that with an unlikely (but possible) 
> ioremap error something else needs to be exported like 
> cxl_memdev_unregister(). Are you happy with that approach?
>

I have just tested with this:

+void cxl_memdev_remove(void *_cxlmd)
+{
+       struct cxl_memdev *cxlmd = _cxlmd;
+       struct device *dev = &cxlmd->dev;
+
+       devm_remove_action_nowarn(cxlmd->cxlds->dev, cxl_memdev_unregister,
+                                 cxlmd);
+
+       cdev_device_del(&cxlmd->cdev, dev);
+       cxl_memdev_shutdown(dev);
+       put_device(dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_remove, "CXL");


only called if the ioremap fails.


Please, let me know if you like this approach before sending another 
version.


Thank you


>
>>>
>>> Otherwise this looks good and with those fixed up the Reviewed-by still
>>> stands.
>>
>>
>> No Reviewed-by yet ... this is a new patch after your series removing 
>> previous functionality.
>>
>>
>> Thanks
>>

