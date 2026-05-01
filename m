Return-Path: <netdev+bounces-283286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +jhzDQIH9WkrHgIAu9opvQ
	(envelope-from <netdev+bounces-283286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:03:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D064AF5F7
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D2A300695A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144F3D88E4;
	Fri,  1 May 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PVv1h5QW"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDD31F994;
	Fri,  1 May 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665790; cv=fail; b=pbncvllABC7bbaFx0lFdbx2VgeCObPC0aB1zSoD4DXHM19d3nFHtC9bAfPR05MBIyzsmYP6Z+X6YL/J9w24NSebAm7yPinKbDWGH8VxeITq/Jg9qQygyMxhmHvfPWlXzGhhmTpHtR2iAqVEJVSd6UzXDTnU/E+A8SXPhzAFYmGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665790; c=relaxed/simple;
	bh=GQ5pjv4ZUbeuy2tjDbBfIMpWJRVB6YsY5M23srQyx58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5HoC1YWIxRTrT97WEBnITOBtgi6TlpJFhQy7Px7cqf5XCpwFfvZmulx61y6zw1EbIaTChdkj9sz9pbMKFVlE/Gv0pwSR4YV0iWqf5W9jQXSJBDkNdVTs8W5ewFUP6yCcLLXrToy1z51eYJ1jBciaL922v/LOkzDk2ezwhVYsE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PVv1h5QW; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6G+12vpmXXl3fUgWmwZzmr3Fs1pkvJI/4N/jq6sAaMbV3C5NeiUqCsZZrSI9kCDX4RdDefcUmnB5XVrcSmLXFDmA9LxpPHRnCAktrzn/h5SXqIhCCz+fDWkHdkyt1uXZl2fn7FDmRyNkaWS2Ntm05ghShV8xAp7wouOHzDV/skbtbu/WOxJKfVZYBldRWW63WUI9T2rgQCuH1yZZyBGm0hgpuKCEMwH0v5zy8FiFxPFdhH17xLFsnv8Ft90n9qL29K7oMngyG7g0sOHn99XKvWWKolPiODlh+tv4fYr0mUFNa8KFGbQ5GP58nTpme31im9+8P6h+C9T9k4Dz8I9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5QqI+UnmdA+eZ9HUSnN0UhFYCMxnUjAz6wo0QuF76A=;
 b=TeDVbTR4Q/zcKdV4iyOMvs7jeiR6WYmBMfiE2np3BBPL38sd1fMuXAhYuB25G/Q2onwaYgOAII4pfIahV6uff7rJcg16/aJM7Lw5ue/wygZ88Dgo2vyhZQtJrlZq8NKSwVUOfmeovlFgFWK2cDlJutupjavwr/0dGQYajqJgCDwBle/crO4i0oSwg97xeDWV/8oL2bOx/R1JSzc1EA1VyubBBqivahWgZF2r5HrxCrlL0GeD7J2/PnHvFL3uS4jodPUUyPIW84hz/X8ETBE4mHWBfeoRNzCLOL/wI+q+DISrGM1nAOxajYvajf1bAwZwkVL58BZY04JRVWsJroe/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5QqI+UnmdA+eZ9HUSnN0UhFYCMxnUjAz6wo0QuF76A=;
 b=PVv1h5QWlIgiNyZNQHuWYSVg5sU2+U1P0Wshbu/GEmOnAWJg6qYsRdRyxVc/viiFV5+UEd3bQAJWGUKllduQIbS4K9FwKgfkdUMAho+ZB3xjhbPIz3GLQIZ0hgqKrmO1aMP3jrnSNcsqhrhP/gdChMuh4c/yNMxw1sZzyIEy64c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2SPR01MB0088.namprd12.prod.outlook.com
 (2603:10b6:208:16c::31) by CH2PR12MB4135.namprd12.prod.outlook.com
 (2603:10b6:610:7c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:03:05 +0000
Received: from MN2SPR01MB0088.namprd12.prod.outlook.com
 ([fe80::6278:fbab:13f1:cd4a]) by MN2SPR01MB0088.namprd12.prod.outlook.com
 ([fe80::6278:fbab:13f1:cd4a%6]) with mapi id 15.20.9870.020; Fri, 1 May 2026
 20:03:05 +0000
Message-ID: <f0ce259f-1a58-46d7-a875-b69c1fdec479@amd.com>
Date: Fri, 1 May 2026 13:03:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] pds_core: add PLDM firmware update support
 via devlink flash
To: Jakub Kicinski <kuba@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, eric.joyner@amd.com
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
 <20260429-b4-pldm-b4-v1-3-394fafba526f@amd.com>
 <20260430180521.6457e61f@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260430180521.6457e61f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To MN2SPR01MB0088.namprd12.prod.outlook.com
 (2603:10b6:208:16c::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2SPR01MB0088:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: a41a9a80-4a71-4872-144b-08dea7bca7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fVQ0AyCTnKUamwSZXrBACQdf3vIyFXHP4VFH1miiYZ+CxGeZyD6vuonMXYoa3L0AG68txR5qO8iXoxK9EkVpwH8MsJfKW7fisC0eJL3Ithbmb25Jzajr/iGUPtCjHOSaHTvMDIMFD3CIhOCFff0jrK0o6jwxhdQu30daRC5G7PX9ts+jWIAAf+p38/+APLRxeGBzlcwLw2AJD6HUxBlF2hBL7QOs38HS9XEJI0NaJcE6t6TAF5xzPoSdix/ht7hGZTbcxO4aRclaXWnAxzkE7T5MfZC7GIbjrKAc/WMgf5LiF6uQ6BWY1iq3Up6je8xbLm/aWyb4O+r+p52WgD+FP7oY4ffYgXc/3+v0VwzVzPR3hcv9JlIHNbqBsvzKxrbpk6Y/boLDO7EZ96kJ2r6WVAwAM2c7h0MUTnOo+6qW4fPSG6EVfo1CTVGom6YeyxifO9RF2kK/Db7UBb30wO7ta5wjltVCr48wv4ldvabu2yjOX4JE4bysGqjM3utH4XctlZgJzDC+z67+2UEMXGkhYfEjvD4EQJz6EDnkswsZF5U63o7wPCJgPpVA57IATOa+0r4GvW6PdHk+nblCxv9m43TMQfmQG4jirP2kthOl8oTy5e9RHN37+i0lqq+tY6m2ADjnvbAUY1CzqX4Xrm/FNXQ9aFFpRlzcDmBqU0du3H+rWT3YEENnnS/tV9hRlozv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2SPR01MB0088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWtLSGRmcjhkclppN1BIWWtNVlprVFYvcnFMNlVaRTBWc0xiUjF4RE9EbEp6?=
 =?utf-8?B?cThKUExhWG1GOHExRFdlTjNCbHErajBvNk8xOHdpWGdLYll4TXNZZitYbGdl?=
 =?utf-8?B?VWJUOERvVHZhV3pHOUpzSE1KV2k1Z1NtVFBxTlhucXVmUzBsdjBKbHFXck9U?=
 =?utf-8?B?LzVGK2NSK2ZDc2NHcmpMSGwvTlZHSHYxU1lWejRPNyswam5OZnNZRy9NTW4z?=
 =?utf-8?B?QTh4NGdhcThqL0xwN0NqUUIxM3lNQzArbnRuREhGMTFwMDlGcFdMd3o1UDdI?=
 =?utf-8?B?N2g4VHB3Z1UwcDZjRGZlYjAvNjVBLzRTR1RYWVJrSGxZWDEwZEx5SnlaYW9T?=
 =?utf-8?B?S0U2bktxa0JpSTRhd0hoQU9QUzRzdi9uYmR1UGtUSHVmYnFLQUdSR0F5OHdS?=
 =?utf-8?B?N1VVMWRNQjVBeHRCc3htSGthQytNK1pZelpocTlaLzhKZm9QUnkxMlVGdEND?=
 =?utf-8?B?RmdpdHVocmhzVmFSNVlnUzNBc3BTdmszNGZxRDEzWVZPY0lJYmU5V3RjLzU5?=
 =?utf-8?B?eE9BREZVN2xYbzlSNFhaVlY5RVFsTjF2UXBLMy9qekNzTXJtamdHenN4eG4v?=
 =?utf-8?B?TTErbVM4Ky9La3pSWmtFWEVUU0EwbGs0b0dJY25od0dCcjJZc09RUXNuQTR2?=
 =?utf-8?B?OUNiVHkvekpKRFhKNTZEOHA1NzRJLzVnWmVGUXdwRU1WSDdoZ2dzK0lLOXNx?=
 =?utf-8?B?TE94WGpVbzJydHJSOHJNblhUdUdCR2dPMTdoYThGWG1tUmJjNUQ3SktpeXRT?=
 =?utf-8?B?czN6c2VXai93cFd6cldRdGRhNzJ1alkwVlJ1WE44djZMRVhpa0lSTzhRejlN?=
 =?utf-8?B?Q2M2RGkvYVp6cHJRd2lwM3pySi9YZjRxWXFMT0xON1VxUG5xTjk0V1RkV0NK?=
 =?utf-8?B?TGRKNlBMcUIzY3dQZVN2TEFMaGdNV050TW1lWWRYZ2VSYXFiakZjMElmanRR?=
 =?utf-8?B?dzFjSjV5ajBucVNwUFEwblZ3ckg1UXdxVWZSdFpHYTdhSC92TlIyeG8vNWlL?=
 =?utf-8?B?Y1lLd3lqQmRSdEljRjhHc1FSMDh0cXlKSWpJVGVQdE92N3ZNdHRjelZjTGcv?=
 =?utf-8?B?SzY4dE1NZnZ4RHIvamN4UlJvckVaYVV1QkhBc0lYUHRLV2tPUlMwNC85UW5K?=
 =?utf-8?B?aTI1UUVPZEtzREtSUTNjOTBvNXR4REt1c1JtWEVPcFpqS1JrUlgzU0JvMlpa?=
 =?utf-8?B?UmlLdExsZ0VaaG9vL3FoRWJ2ckhEbGk3UUcrdFBWRWxtd1VVNnJnYUpYMU9k?=
 =?utf-8?B?Z3V2Rm5XQitVWjFiaFRKME1aMkJUcGFrTEZaOGl2dHZmV1JRY0xCU21NNFRE?=
 =?utf-8?B?dVZ1YjY0R0I0QTNVc2xYRU1nN3BELzZKcFU1bDErYnUxVzU4VSt2ZFdBdHdv?=
 =?utf-8?B?TC9JTWFSbE04OCtwS2lnWXNxbEZZZjlucFhwNzRUNzBsYTVRNkp4andZMUlt?=
 =?utf-8?B?NUI1M1RJT0ZMTUVaM2hoM1lzL3lIa3ltamdsd3ZiSjNmaERhNTdmU2E1VERh?=
 =?utf-8?B?bXVNT0N0dXQ4azIrMkdNV3l2QkxiYWdkN0F5TEJmb0JON2tBUDNlaFR0Tmp4?=
 =?utf-8?B?QTVqOHcvaXVzWFFDRkRqZjVOWXJacndiYjNTMGNULzhueFRoT3NaTFJJeENL?=
 =?utf-8?B?dmdYRml4aWpkZXlSQ3hwS1dDVmpaRGVBR2ZEMHFIVERXbTRSeHJKOG9SWHJH?=
 =?utf-8?B?VmlGL0VWUWthWHRweDJMWHI1bDcvUXZzenBSMG1DMzVnQ3ZTazdXdGJyemVH?=
 =?utf-8?B?b1Z6NlhUS29KcUk2TEtTN1NRb0hCWm8xVUxSOUlPOE8yditEekpiMXNMOU52?=
 =?utf-8?B?QTF6UjY1dWtuWDhvZDNoT0N6QmN4c0tMM2owSXFsYkRlSERSOE04MUR1Z1lF?=
 =?utf-8?B?Q013YktVdk5pTTN3T0RMZzFCUlhWZHVxV3pWWHg0THBqODBKR3duRHUyVGJy?=
 =?utf-8?B?WTE3RW9mRmxTNEdWNC9lVlo4eFk3YXZBejNoanVOWjdTT3lFd0tSZlozbGhC?=
 =?utf-8?B?ZDU0V2FLWkxIdUJNajczd3VKUFlHbU1EYXhFamtsMHJ1bmpCMGNwMmFkUmJR?=
 =?utf-8?B?VzJwakFwdzM2bTJkeXdnYnhaVG9nYUtYOUx6RlY3V21USjZrdmhSRW16TUFN?=
 =?utf-8?B?YSt1SHU2Skk4NHJzRFZQZ2tGSW92ZEYxdEF1UEdqNUZ4dW93VHg2RTFGV0s5?=
 =?utf-8?B?bGN6Zkl4aU5BWlJqdm1SSkQwdVBSeXlmbXJDSnE0bTVjTDJKNjdYZHJsR1Bl?=
 =?utf-8?B?QTBteVpJdWJkcERsRWhEK1dnUjFjR1VyNDM2QXl5MmpZSjREUE4zTiswYlUw?=
 =?utf-8?B?SnpyckVyelgyaWhaUzljanRNeGYzcGt3TmxyZ2hMNFpHNTI1WG56Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41a9a80-4a71-4872-144b-08dea7bca7d9
X-MS-Exchange-CrossTenant-AuthSource: MN2SPR01MB0088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:03:05.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF3xgJS76CbwViCbstmMT3XLHqqwLMHm/B/wC2qccDqrzb/DJh2Iy2+68eawTJgM+LucZwcy3pJH7a1/XN9fwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-Rspamd-Queue-Id: 82D064AF5F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-283286-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 4/30/2026 6:05 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, 29 Apr 2026 08:28:19 +0000 Nikhil P. Rao wrote:
>> +#define PDS_CORE_FW_COMPONENT_LIST_LEN       ((PDS_PAGE_SIZE - \
>> +             sizeof(struct pds_core_component_list_info)) / \
>> +             sizeof(struct pds_core_fw_component_info))
>> +
>> +#if defined(__has_attribute) && !__has_attribute(__counted_by__)
>> +#define __counted_by(member)
>> +#endif
> 
> Please don't redefined kernel-level primitives.
> It's a huge pain in the rear to deal with when indexing the code.
> 
> This patch also adds a bunch of kdoc warnings.
> 
> Last but not least Sashiko points out a number of bugs

Thanks for the review.

We will fix the issues above in v2 and also use Sashiko to review v2 and 
future patches before submission.

Nikhil

