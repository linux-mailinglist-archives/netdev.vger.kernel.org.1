Return-Path: <netdev+bounces-273214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON7xLgqLymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E435D02F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03503017FA3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE43A63FD;
	Mon, 30 Mar 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rNcoS1WG"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEB3A1A42;
	Mon, 30 Mar 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880825; cv=fail; b=ICP5BMU6mf/MzZbjQKO1nZe0jxYc6lpPg2Ws5bTdS3Bqmm8YjDt+lT84UTMPVwuZonfGSkK3yTLbFtPUn2I0Sv4PAn6tZdrDlNXLFjQ2gFA9a79l5bMAWrk8sZHRh9olpWIYbgarzG9QOqZ4iVDgAgevHLbFjESXGoYy+N5NH7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880825; c=relaxed/simple;
	bh=9BUkAh4wgEGRTcktG6F1OgKfKnBCby9BhFhnGMmzyuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2OhMzcOB9cW6HnFH46jRJ89KAnB35AIi4O9rPx3U57nMYMPHSI5Ccl1WxC2/alh/DrsvpFzQOoOhXIvPtnyfDCUciZbz/vDJ2lpJCoMZm0Jbz3l97BWfuCS8VZHL3qOMyxta/1CmTC/Hi8NjZXI/+mq9zXBBgEOf44FE7x0SAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rNcoS1WG; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp9zZtJMhEfHKSvceWd7JSD+dBTs/bAkQ7BbkDYQqCUIOaRchPALHEfsZH3a/lmP0BOS5+wzbw7LNXUNDjhy9lND3t1q2NDPAY2lQykgIXSLBLDiG5wZ71IsEvwpAmwtk1EwGdxqEjp7L194Aj0dd/Rva00VXXeKdPR3b2vCp1Z7Votgi+Kr8QBoBwcmqst9OV6xzWN2nRqt+uQiSWh3cCokWF/QU9XkT23/53ZaTUhMor0gzd1yzvdYZkhQuevE+Rg/OYrwX10vg5a7jDvRdlzmo5FxtutWAVRJJy3YQZ9odfDwVKL6FiuxHH1bUPRLnQNrcKXrv1tC0ha4aAlGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha2GMFALJvEN8eFo2ggyS18xUQl5bp/V4/whRaXqgzk=;
 b=o1ORqzPbl6d0zen0KXfRSNSODbu1KxXHwBSkkSChhKWWuH19kRMzKmILM7vPAvC60Kx3fFA88n6hbQdaGGsr6BOs4edrxIPOeMWhsRZBIkC/nbxlS3T8oyk6Z/MjOEWweizSDjRZYRTU1wQV2qyzrdMgHS8cvjpXnptidrkzobbnFjzgDlCu1DiUNntJwfRJ8x+32dwK+BqFizAZRUynbME7FsXOUU/lRcaFz3OzX+p1i2lDWPokKYs6ONaKdulhEilc0NQt77y6Vi7Tkwa603My5KLY65f5ZyNiz0OZY/G1j1nI3dMEr3w1Ki6BrxvubIMKaMEeIrHqLjwHNkPnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha2GMFALJvEN8eFo2ggyS18xUQl5bp/V4/whRaXqgzk=;
 b=rNcoS1WGMxWbTfCgU9s9HMtDEldJfjQSSzt/X5zj7pCKbsywSXeWhPJXwyL/yCXcL5zb5FoM/5c+NxdhiwMYLLPLNqfPRQL4u5nDbJiGxsXb8TAB3zNvulqKJXh0hHxv1b97ntOOwFkL6l4que2vyNgHmLGo099VicJnwzmN0Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:26:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:26:58 +0000
Message-ID: <8737035f-07e9-4c14-93a9-bb542197d7f7@amd.com>
Date: Mon, 30 Mar 2026 15:26:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 10/11] cxl: Avoid dax creation for accelerators
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <daves@stgolabs.net>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-11-alejandro.lucero-palau@amd.com>
 <acNPnzDryNIQlTFS@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <acNPnzDryNIQlTFS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0128.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:d0::10)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a982f8-756f-4653-8679-08de8e686698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rKnMrSc5/egiF5nzl/Ce33g4HNlt9fHeUIvpahPoIZFm+CuJe1ExTnsqIJDV1yMdPfwyYYIzvRnLPzirZvakbUEm/dJKLYw22A+kfsRdijkiwZ2eujzzxfCe9/SYy31m4BPymjUTIHjsLYAwRN0TZ7x6ZwY5xC9L8XSXVgdTrVamyf/MRlqdD2139E1O1kjYoeg+mcrWCmzpDEviG0F1i5m4j0px6pz1jZOs/Ks7Z04S3nwyoMwKjycP3FhZ2095mPbzmHSz8UtjqMzZ8HPUWiljSJ57Xq54OXybu6GOK1SC3tm34ITXEkjxKBp+oAH3pKZsKC6OBCdae0otp6McCfvNhxWxfhPbSZfhj45Rh+1bC1bHvTNoBKZQLTDLf+x8XOaBZBm/qkFNSgJsGB8PbRlBRIKPstNP7r9uvTvv/tWQiL5bLxJqmVZg2nTgjKyrPaQYNTP7QjPFFWFtVPWVmeu5FLjixJM1YKOii9lZ733VahwJ9B89bik/W9hl8NyKRAhBVPTySzKrYE50ZzHLdD6Mn/16V6SPrvJ6KLUTcYa6IUSaJnFHvZOZTWhkOiDoBFlymybdc8C5ddxifWaIBLzUVWoLYmuGuafwAAfggSlU78povRuvrUJ2MVnaaZ0iGS5ZHNKYK7/rrsAppStjS1IX3mEuiWH5KjBeVWRVDBdqxs9eC9D4SjejldFrJNgZkdKnQQnJbRCxoyQii2iev7iHZOAc138jY9BuN3f7Wek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0MxNTJHLy91eWRTblIrOWRRa3B1Yytac1NkcUd4WUNBanExQ3hHRk1IVG9G?=
 =?utf-8?B?NVZ3akU5UVZMUmZBY040QWk4UEZTY2ZaZTJOZ25KKzVuNGVRNzFBTlVZVXNK?=
 =?utf-8?B?aFZPMVp6VjkzaDZ0TXp4MVFUUDhIYnFqVzNOZGtmTkg3WEVkb0J0dEpDeG5H?=
 =?utf-8?B?bVBueldLa2dMNXBsODZXb0JBdXN4RDVQUTRzTys2TUZUSHVSU3A2OVYwaVNl?=
 =?utf-8?B?TTlLbDl2OWkvVjZRYjI1UmtpRUNMQ091Wi8wTWtXbzZLU0RXdkZPb1NobVFQ?=
 =?utf-8?B?TlNLZDFDTkdENjd5TVJWb2FJaWM0WmNpWkVvY0NqY1U0OGhIdDhiMzNIRkY0?=
 =?utf-8?B?VHBEN05DMDlqQWVnK1RhSkNocXNSQnZuZXlLNFRPMzBiQm1WUks1cFJEbmRW?=
 =?utf-8?B?YjlzcWliaFFGQ3ZpVEJxTytKSUc3Y1lPb1JPUjdLZDdPQzNjcDNQbDhkMllQ?=
 =?utf-8?B?M0pBTGpGRlRKaGRFSDhzWVFSUlZGdFZXR0padmU2VHdZcjgwdGNCWUNMRjUr?=
 =?utf-8?B?T3FPQ2NXMjJFVkp4NmEyR1J4aGREa0haYmlMNFllOWRKWHc0cnplWDBVSkQy?=
 =?utf-8?B?RWl2SENzMXFweGNOSy9qSFVzMDlXTjI2TjkybU1MWTl5TWc5L2NIbkkwclBv?=
 =?utf-8?B?bEEvcVRXQlRwdFp0bGkrUlRSUVIra2xtc1dpUG4wT01FdC9HNWJ0V1V2OG5m?=
 =?utf-8?B?dk91RVVzMDFXbmZGQUlzb3BIQlhYZ1dEV0trK3p3MU9Mb0Q0U0c0dVlVVHJp?=
 =?utf-8?B?SnYxZ042VGtlazR4Z1Exd1J6VnhML1VMMEdHVHFPSFZpWEZSOTZBQkMrcGM5?=
 =?utf-8?B?Q2JLd1l4TVhVUDNTVVVwL1NGOUdGR0VmVTJmQmdTMDBSa2UyMGdqSmFNbVhM?=
 =?utf-8?B?bGpBMG44bVJZeHp4SnYybzN3bmhwOGozOUVFMWZZallRdGpVUjZjY3dFNGI5?=
 =?utf-8?B?Yy9RNEpNNWNJUjlBb1BxUGVESUx3bGxPNUw5aHVYN2h6bkZsMFowRWdPZmY1?=
 =?utf-8?B?STAzY2tlV2ZCc2RFdjB5dDRoa3BibDNOd1FIZXlFdzgrY245a0lGbGxZRUNV?=
 =?utf-8?B?bnVYNDJiL05ZZy8zMEpRQlVobHRNSVIzMzZtbWJ6UTdaYVBrb0xHelFmK1NM?=
 =?utf-8?B?RHhKMGNaTkdqNjN2bzgreUNXeDY2T2hhL0VLOEhQWlN2WDdwOWd0MXg5VFRY?=
 =?utf-8?B?cm9nSG9NTjVNTThlWXcyWHJJQ1A1ZndqTUtZVFI4VjB4ang2NkF0Mm0rY1Mx?=
 =?utf-8?B?aHAxREVhdXgvWlQ1THV3MkM2MzRZZ1JGbU05RUc4WlJ5Z2NOS3VBRlRmL2p5?=
 =?utf-8?B?Q1Z6SmJNcXlPc0NCM0FKVTZPTlJDZGVwcVZpcHlUYmpSZ2pTaVI0RWNpcm9U?=
 =?utf-8?B?MWE0cVQxQWhqd1FEMTFWWWtaa1hDMjhmZkJ0RktZRXJROWpQblJmVUZBTFh5?=
 =?utf-8?B?blFWbk1Mdmw4bTFtMHE4dld6YThiTDE2M0U0dnQzbUZoa2FlU2pVY2J2bVFs?=
 =?utf-8?B?M09IR3llMWJ4VCtxeDEyOFZheU03WTFvU2FzdjFpakYvbEFnZGtzMVMxaXM4?=
 =?utf-8?B?Zzg2UjM0c2E3SmttcU9BWGdQNGpUMzdaK0VBNlVMcm53R1UwOHRQUjlBL09q?=
 =?utf-8?B?cjBqWnR0RDhzdUJ1VWRRb3VYYXZjN3hzVm1iQ2JEUkJBV2tpYU9id0lxSCt1?=
 =?utf-8?B?M0l6c1hwTnA3Q3kvYk5vcVFSS2ZDS1RPS0c4VjU5Um13enN2cU51YWRod1pl?=
 =?utf-8?B?b1l5ek1vdkZVTlRQMHViZXVrb2FwTHVhay9tVmFPYktXc2dZOThweWtHUE5x?=
 =?utf-8?B?WHJzb3llTmNYRytjQ1hvTFhIRTRVM0pRRjEyN0h0dVZ5YkdlQUNGbytldC9m?=
 =?utf-8?B?cU0wZUdjUFMydVNEMitIcmNSWnQ1TnJ5Vll3Wmg0aDdlWWxXd3VxSzhOWnhR?=
 =?utf-8?B?VXl6SHRtaG9ocllGV2JlUU5rWFZrM2NJdmhmUVczb1h4SVZjV0g1M0NPbnFj?=
 =?utf-8?B?eDRvOTZJNml4ZFVoQVVUOGd1YkdKaXNaMUQ1SExsMndtcVF6RlhTcjRBQ3di?=
 =?utf-8?B?TWpXWThBRWlhbEN2ODJKa1NXZFlIOEZMTnJCWExZcjU2eE15bE1WM0RXbmxq?=
 =?utf-8?B?bjlRR0s2ejVlKzlxWGdVOC8yZU9XVzhwcTBWSnorTE5UZTNCYXdHY2dkVVNu?=
 =?utf-8?B?c2dsZ0JYODlwRnZzcTU0NmpGRUVCeEY1ZkN0LzlNT3RpTEJJVGlDQ3czb1dH?=
 =?utf-8?B?N0pSZnBTUFpDVzVnazUvbGJ0cExHSXR6NFlvblF4bTNJNnVXOFpDRlpKcFZ5?=
 =?utf-8?B?QW5MSitoaUFyR1RwZUQwMWZTOWZsUk5ZNFI4UnZiLytwdWNYUEZVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a982f8-756f-4653-8679-08de8e686698
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:26:58.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUnbn3YD7fGbqpqWtk8WQM1W7RNrvRpDvFRcUqhNrR37YvVSd4TaaOZC9XHXwb8QnS4iVh6nElYnTzGSi9RSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 4B7E435D02F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/25/26 02:59, Alison Schofield wrote:
> On Mon, Mar 23, 2026 at 11:31:16AM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses.
> Hi Alejandro,
>
> I'm wondering if we're skipping too much, or perhaps just needs
> a clarifying comment?
>
> Commit message says 'Avoid dax creation...', that's specific.
>
> Commit log says 'should not be available to other uses', that's less specific


Hi Allison,


Would you prefer something like "should not be available to other uses 
like DAX".?


> follow me ...
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 8bb53a095290..2f9bdb4f1f4f 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4263,6 +4263,13 @@ static int cxl_region_probe(struct device *dev)
>>   	if (rc)
>>   		return rc;
>>   
>> +	/*
>> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
>> +	 * Skip device-dax registration.
>> +	 */
>> +	if (cxlr->type == CXL_DECODER_DEVMEM)
>> +		return 0;
>> +
> And above says 'Skip device-dax' specific again, and is indeed skipped.
>
> This escape is not surgically placed at the point where dax is added.
> We are skipping a few other things before dax registration actually
> happens. Why skip memory notifiers, shutdown_notifiers, poison setup?


posion setup crashes with a type2 and I'm not sure if the memory 
notifiers make sense for Type2.


If it is really needed, I would prefer to support it as a follow up.


Thank you


>
>>   	/*
>>   	 * From this point on any path that changes the region's state away from
>>   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>> -- 
>> 2.34.1
>>
>>

