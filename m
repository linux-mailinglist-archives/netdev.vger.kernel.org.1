Return-Path: <netdev+bounces-278994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJxAOxm84GlYlQAAu9opvQ
	(envelope-from <netdev+bounces-278994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:38:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A640CFF7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23CDD303CD13
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337623A4F59;
	Thu, 16 Apr 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="30HfBRMN"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D923A5E78;
	Thu, 16 Apr 2026 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335869; cv=fail; b=SGwtUaTMLWzSCHfQXHRt7zhKzgRlVPV5ZDNIympvTY1XupoOJFNfeNEYnIf/HuEEAcxkX19trJoKTKUcH1lsJgqZ1wa8xRSaU8BPDuHBqX5GNjiVr6XywY+8cCAYzEJmJuR26lx7uvylVQeC1MD2kpNqP4soDiyLw9gcESqEDb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335869; c=relaxed/simple;
	bh=BxGSC0iUE1TGZcFWMxq5hOtPbO8IJ98UL+uzvvOQaLw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLTT6y+6F33uHRDcY/KKgniSWgdxQTf6QeOkyLQ4bVA3rUP7HjNotqNJGuFDA7eMFuIqUWl4m31CRZGxcoDgx7d0cI1Tq9U/AC0Ba3IFGtmF2ng2OM45Eex8IxBGh+SfEB4dJJ465rwwjliUaZRWCUuvH024TZzSX/73/IoYAxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=30HfBRMN; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM3Eo0czXLV09gJuJrSasQ+6Tic4wgKOzcc6G8zDJUtI2ItTef4VaedaMwOdpsz5EaIE+XH80oibKehkVmTabXTu738PHx88Rhi5H0is13afcKudhyP7clkiMnfuVkKI9PTvdokpTM30LNjMi6hgMHgp42DoL82ZrhFDm7GAg19iNHNILrCdefreyb3tkMD9wVSJFtqHlyrJ1YKaud9D83KIv7e98FSsFy5TvpcoBkFI4p/XGXXnP3BP9QDBWEVTTI3pvbFlTsdLr26TZSQQfNCVJ7ynNdNeoH1B4yTlTCvP4Mb1ek3skx7XbC3jMy8jYV0uzIy2Flsfx0NoZqeOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OhTv71dYDcYkooCp2lZLP8auD6Mzt7+J8w9zuAgWWE=;
 b=SCXxMdE3QRhdeFjJW7z5UtCTsZKbvhkLR7YY8ZMaZaOv0bFmC2XHZTGOS3nGyfiD4q8uQGReGylhkOrFR02UX27s2WvmtrpZS5bSWkwkeslAoDMNglCZhRRqjHKHxp+Sfzqv4FGKq5VD4VI/E2jX2a/GxGHpX8cx9Qd7k5ujl3a7rKUMqgYwT2niQ8dxgQZtiRfGKEPhGUzWrvrFXzzj1+c3vxLt50VsY71JHeIPFByYzJ8VpspLxyjS5MCnwr1FBtLJRdUarxKtGQxCWTPrZTVL8PKv6pkfBxGrgU35561K+gPWrpN/aU6FIe/d/JNUCwluJfta7Zj3o5xjBdw/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OhTv71dYDcYkooCp2lZLP8auD6Mzt7+J8w9zuAgWWE=;
 b=30HfBRMNJfdpWjQnzHz6e+qBQ5uD/buu1OWgBhB5I7B3pGH2ELpyxAIIIGGCxCXUFq4BwBDEOZEgn5hVFZrAXO0Ht/LP9iZ5S1ndUxhENVDJ0kswoyJ+fR/60g0qsNJtLrwywwi3WfaBnEN9quYxBbrWfs3DDh43PEY5qMiVV+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 10:37:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 10:37:43 +0000
Message-ID: <12594667-5b3b-402a-b94a-54104892b0a2@amd.com>
Date: Thu, 16 Apr 2026 11:37:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 06/11] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-7-alejandro.lucero-palau@amd.com>
 <69ccaabf8d9cc_1b0cc6100fd@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69ccaabf8d9cc_1b0cc6100fd@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 625085b0-75b4-4f4e-53a3-08de9ba430b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jgbPdWCaMNuvzM7odsjiG1/ChChdmIk1pbFD4sY2eoOSXSQXpi4Bfkut9HzBFpOlkpdZdSuD6AFoqG6XH8qo8fZqvsBhvSxR7eNmxoapFrTe2cN3dRXopgmgamBJcsNtUNXdwNk7iicZTIy7stKw3EBmTBDICw/NV91WEUibhFOX21PgbrlmlO9GqB7KlEcJ6AaRf6Jd4IechKgP/3zS0933II7Vr8jsLS9Cl4X4r6zCcn7Vlx0VZUxrxxmcz2yJO/RT9hzeQjMNjog44s73suCEEnslJ3juAjakk92CRdeV7JyMdpCkYCoc9NbmpB7n8ymS/SAaYnB9OVVrxu4+mR/FI128JG/jw3H1JC3nh+iauUzVjdiywDgvkvk/HqJypFjUz/6Gi+5PD7xfUwioPq22MLV1pILg7MUg4cSLUi8zKOC7zelQ78zwAeVP6M7iqlzEzRvEuSrDxpqxL1jov/ybaHwxvTEE7ESwtQckRMi02p7CkSgfPxDi2bmZz26vp8DUyUApJ/KXiv7IYE0PJLIpwlJ2gso4vs4OFWl3uCKEMqa+2GVHd0yy2OCgHG/vAcMGqBQvodJuPCaUZgqJ6k+2zxGnYilqOfKQwvx4ODTkHNoQjS4V++w4+nxqOwBoSpwpXpSymiJyu6ObEdmaUGpzlbQULHABY6MxqNFx93zLxrXw6x6OJ2V3rqjxO65pciVe1nfDXdEGf4zcjh5xDtTbf008FjuCESa4wxFQbvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzFzalozOGFqM2lXRk5XQmZranhpWDdWNTYrSk1obzJlSVpXWEZibEdkendV?=
 =?utf-8?B?b1BnTk5qYXNzRUxRNGhLK09EOG5OamZTYWhvOG9sL1h0OUw4dWQySWxqcEt1?=
 =?utf-8?B?eVJwdTNic2lmUEtPYzFUVGN4TFdpS1ZlMFZScHFrc3VKV2FVcHR0VVppa3Uw?=
 =?utf-8?B?SGRrQmdNbndtWTZIblMrT0QwVUpXMzY5R1lYLzdSSTQ0dlpTWjBqYUMzcVVE?=
 =?utf-8?B?WDFmYXhZazd1bk1vbjlMaUdtWkpMS0hGNkEzdUpiYWJNbzk1VnlRTzZJY1JI?=
 =?utf-8?B?KzI3cjlpTWZMU0k1Tm50NEJ6b09JN2FkM0c2VnkyQmRuWmZZdk5LNkFIUWc1?=
 =?utf-8?B?bmdDejd4ekFNZ0FmOGdlMnNUSGk2ckFkRWd0akZENEowbVFLNVF0N1JYQU0y?=
 =?utf-8?B?OWR5d2paOU5FQVAxYnZDam1BSXV5cHBuMGpOL3JuZW9wbXVpb3FzQ3B0Zms5?=
 =?utf-8?B?WmlReWxhTzdacmg1MC9WSW9FRFdSbkp6K2RzbFJxZ0ZabVZsUHJvQXVKTWV2?=
 =?utf-8?B?aUxNUFRoNjhGa0pPOXVpbmVHVlIxK0hLcWFkY3dtL050OHFiallRaVp2NzhE?=
 =?utf-8?B?VXJOMmF3MUQ4enk1S1VOclBObzhrTDk2WkVCK3JDa0tEc3VkbjFNQUFYNVZ1?=
 =?utf-8?B?OGtZSytLdDI1OVVGU1FjWlNza1M1dGlHMzV2cDdwcSt1N29BeHhpNmNhUUM0?=
 =?utf-8?B?UVBpZVFZSE1MUVpqeGtYTVVSSW9zK0RKNmlISGpOd2gvRWdNazNCOHkybFo0?=
 =?utf-8?B?OVEvSXJXQTZsUkNVRis3SjZwOGFwUmVnRmtoemVVQ3k1MmdoY3k5d2VEMUJU?=
 =?utf-8?B?dVJHMEVaOUVqMm9oQ3kzTXM1RlpzZzhFbk0yR0hZZmxhVVhRZ0hxWmF2WDBG?=
 =?utf-8?B?KzU4U09MUjJYQWx5cFF0MVdqNnk1cjU0SkhaZ1NZaFp5dHNOQ3JOa3JHNjlt?=
 =?utf-8?B?V1Z2UEdFS2Jsekl0SmZ1by95YVZHSW11YWRMQ1BzZlcxNVBFalJteTB0QmZJ?=
 =?utf-8?B?M3l2cnc5ZzUrRFIrTW1jNXdkNktJT1M1R2EyeFhxQzJIQzBOZEJpSmZHTnI1?=
 =?utf-8?B?N3lEME53RlJSTUo2T0QvRHlrcmo1MEM2akllQ0RFYmpwOVBrZWNSejRVMmV5?=
 =?utf-8?B?Y2xsYVE1N1BzaEpUckJzMTN2K3Rwc3RySEZtRWVJN21rY2NxRjJUWm5IZXQz?=
 =?utf-8?B?QmNUUXQyRUJZRnpqT2RhL1JaOTBMQnlDRHlTSkpFUmV2c2dhejZHT2hUUlF2?=
 =?utf-8?B?UWIzSElKSmhYVTkxSlUxMHk1N2UrMGtoNEZOajArVzRLT0J3TUt3WWw0KzJP?=
 =?utf-8?B?YU9lMHN0eDhQM05memI5eVdrWURXcjV0alRJbWFNcUlJdFhJZGFwSzhjSE5t?=
 =?utf-8?B?U0hOZzRRdDB3bmtadklwdmVhVFp2Ym1tMzZIdXFONVZQT052NFFzOWlZd1ph?=
 =?utf-8?B?WkRJSWxiQXdjd3MxTjBJYkI5MzVUSmljZW92VVk0Z3NKTGxSendDOSt2c3l4?=
 =?utf-8?B?YW5IZ1JLZC9vN2dDNEFuZ0pIRS8yaFNya0NRZ0tHMXk0dk5UcGMxOTJmNUVl?=
 =?utf-8?B?cWpCVzdTQ1RTTjhaVHNzTkw3RGdiaFdHY01Za2ZzNUF2VWdDazl6dDJYd3Nt?=
 =?utf-8?B?dWRKVldleUZlNnptRjM5ai8zTWNpZ0ZEMXlGcUF3eCtmVFJ0Wld2bkVlNGhD?=
 =?utf-8?B?VWVUakRBMlFzWk83SlpDRlVzS0xyMjlFK05LMTJURmlQc0phUXAwZ0IxREsz?=
 =?utf-8?B?WWJXZ1lqQkFKOU12ZnYzV2k0TE15UmZVQ1ZzU1B0QXJyc2Z3QTVOUXgzK0Nw?=
 =?utf-8?B?SXc4Q2s4TE13NDFEVW91SElkTGdMOUpzdTExMnZUYkt6QjEweVpDK1hwUDBm?=
 =?utf-8?B?eXV2M3EwdGN0SnFSWUREOFdsVlh0ajRLTUgxMFFjdkdoUlk5MzgyVnNGZkk3?=
 =?utf-8?B?QW8wWi9hc2lXcWdQTG10T3g5bUt1SDNwaWxGM2ZkMVJjTWEzOENIU0VIV0Va?=
 =?utf-8?B?TDBOQWxsK2dnL1pjYkpZcnd4aUNYZUVNZ2VLS0RGdmdZbDVPWmF6dGNpZy9G?=
 =?utf-8?B?dWpTc0o3RHBUVmRsSDM5dloxeUpUVXpxRE9rc0hweDlIeGFUM0lDcEUrVSt4?=
 =?utf-8?B?VElxNlRhY1FnSjcybmN4V2lZUXZUY0ZxSXl3MHZJeFBERnZIbUJqUXJMNjJ4?=
 =?utf-8?B?M3FmaFNZYWxCMUgyQnNLT2E1OE5mczM3OHoxUnY1ckRQc0RLeVNEM2t4aUVQ?=
 =?utf-8?B?K2pjWkdLWnRJQ05CeFZQRndBOHlQVUhiREhYSVZrT3lGWHkzV25MMm9EWG0z?=
 =?utf-8?B?RUdtYk9oY1dUN0NQZWZRWi8xRE9JNmJoSDhreGtNV1NiNmNDWFBLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625085b0-75b4-4f4e-53a3-08de9ba430b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 10:37:43.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZwzdH54UXq+gcBoaHGysYu6jKffeSqBpJ1hRbJT+8/j29NRrMz7r93wYSPNZijtq54c1dLy86T29uOL66enXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278994-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 436A640CFF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/26 06:18, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type2 device configured by the BIOS can have its HDM committed and
>> a cxl region linked by auto discovery when the device memdev is created.
>>
>> Add a function for a Type2 driver to obtain such a region.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> [..]
>> +/**
>> + * cxl_get_region_from_committed_decoder - obtain a pointer to a region
>> + * @cxlmd: CXL memdev from an endpoint device
>> + *
>> + * An accelerator decoder can be set up by the firmware/BIOS and the auto
>> + * discovery region creation triggered by the memdev object initialization.
>> + * Using this function the related driver can obtain such a region.
>> + *
>> + * Only one committed HDM is expected, returning the first one found.
>> + *
>> + * Return pointer to a region or NULL
>> + */
>> +struct cxl_region *cxl_get_region_from_committed_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +
>> +	if (!endpoint)
>> +		return NULL;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	struct device *cxled_dev __free(put_device) =
>> +		device_find_child(&endpoint->dev, NULL,
>> +				  find_committed_endpoint_decoder);
>> +
>> +	if (!cxled_dev)
>> +		return NULL;
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +
>> +	return cxled->cxld.region;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_from_committed_decoder, "CXL");
> As soon as this function returns there is no guarantee that the region
> is still valid.


 From my comment on your patch trying to solve this problem:


https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m467dc88199645865a05b5fef858a67f3a608895b


I think the protection for getting the region needs to cover the use 
from the type2 driver, what is likely the ioremapping and some internal 
updates based on the success of these "atomic" actions. If the region 
disappears after that point, the same type2 driver should get an event 
for stopping that usage, what can be implemented as a callback/action 
for the cxl region device removal as done in v17.


If we agree on this, the main issue is how to implement it. I do not 
think adding specific functions or params covering the different 
possibilities (ioremap, ioremap_wc, ...) is desirable, and it will lack 
the flexibility needs for syncing things internally by the type2 driver 
against the region removal race. I wonder if we could have something 
like this:


cxl_get_locked_region_from_committed_decoder()   --> implying locking on 
cxlrd->dev, if regions does exist


cxl_release_region_lock  --> implying unlocking cxlrd->dev


  to be used by the type2 driver allowing the safe ioremap and any 
internal variable updates between them.


