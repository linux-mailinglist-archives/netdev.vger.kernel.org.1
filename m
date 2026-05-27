Return-Path: <netdev+bounces-292090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZTqeLyx9FmqPmwcAu9opvQ
	(envelope-from <netdev+bounces-292090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:12:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154985DF585
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A73F302BE8E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D4F2ECE93;
	Wed, 27 May 2026 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSF7x+4Y"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6E283FDD;
	Wed, 27 May 2026 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779858729; cv=fail; b=MZLB86WKjDsQJh2NiD1X1xQycyKYFr/WMOb/FBVD+Y9i1HGheMbcGBaI+Eq/BoeGg3uRdwuzsRYCc3FwdfBH2pNLnABylad7TooC6Xt26B5a4zyvgIvDq65YvqaHMfsnoIiLOGhyoROnO8NrqU5DhfbK2pEcpW3AgajBkSOkQVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779858729; c=relaxed/simple;
	bh=lvdxhM/Qm5acva0inmo60X8qhFHeY8NcyyBnn42v+yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QD0LLhQ6DYk99DQfVq3J+8YadAsqeUveOe12CavBpaNYAvGjj5QGj3ogZzCmKWi5mMJVCSID0mQCuC/d/+ZTFn0SKnDOMga5/OiAUJxKpo1NTSSSIb2cFiusHKUbIBMf/pySQlbB8LBqZafV8+vx4fE3hf0c4XW5RPLXR98ruxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSF7x+4Y; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBjDI0T76mO1tTYSPhTAjh6pQ8Kb2SvEv2evkHb6u+kdfi0OYc3jwBagH6nt6hmq5Sq2ofRONzXOZNbIr4NisCEGF2Pf6ylMFh1jR4qGLGRlhYbnZUlOfzPEv9gQGBEZht5HfsXLsn+to6zDeOl5ZsY4mQz8CX3JBthJJfL7UBNN+HCRLDg0IQHiV4pyBEOAgpx+QQf5ZnG9K7jHtt6KzkOAGwFmHbZ/5GlKBJ1xmd4ctsQSy0fIFJJQJn/wymwhFGGQZRjVG2ws/lHo71lpBxuN8hi/6rdq28NVqQwHtF43hvIdaej3jdpXrnE6S8y3q9HV1AmGvEvViAd/5t9qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9XboF4s4YJdvXlcm9Ivy0Bydl8hFr6DAcZsdAKbyDk=;
 b=nBJ3MUZPpm0BnejNZC2aQf1/PqkEonfIcwtI/5qeorzjnzOnImKHsuK0V+vygP8h9ukBHpihh6jzXWtkFaWpw6559NslSBr9Ppvx0m5QDmQXuCCLl7Gta0I/H183ANceJA2RSDoImLalNPjea7Jo9TkYqTcmPW+mYrpYDytVXwiCqdewU1j+Xfqrte1CflfmCCdP7hYTMxXrMnM+Yfi/i2NbILkUR0QH7EJbKx6vr5HEhmVnHqx9U3H6pDX2+QsHP4PULqa+3mXFYwUNM595MLqU6YvpoibTF0gc72uoHCu+2S9qoyIcX8JGHG7yGm7K6OpFm2gi2n90986/MGel+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9XboF4s4YJdvXlcm9Ivy0Bydl8hFr6DAcZsdAKbyDk=;
 b=mSF7x+4YaIOf+IydApGGsNLzh/yHTDoNKVLJcI6b8/+gRdEwhwVNONqu7kBB/VoZf0+eC+wfMP7cTOPx/cykqnDUvirEMqoeSWMgSEIBKWbKT+DC++lmcqWEMQHNlcG0VI4AW8CoKhzCUh2oDRD1Z6gTDRnOJjm+TTayRvEjXa5E/B/gfv2bAhblhcKuLvx7i3dsv2Svb1SNQShnLJr74jSM9pq4mUJ6naGzUnidFbs/8v51Zn3izYfJbw/wMe41yfnp1b2Umyn5ujRR7lJmANaawpjgfqd3YBrK3YUGB1hQn42EkJUXGgTvxW02sS1xcDdvK1JKDjZIFbwSPU5q8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 05:12:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 05:12:03 +0000
Message-ID: <7784f296-f1e4-4478-ba01-53d3e1184a8f@nvidia.com>
Date: Wed, 27 May 2026 08:11:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] docs: page_pool: tweaks and updates
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, tariqt@nvidia.com,
 dtatulea@nvidia.com, linux-doc@vger.kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org
References: <20260526155722.2790742-1-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260526155722.2790742-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cf933a-d783-4f83-d941-08debbae7d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7PtVdjnzsHaIDiV0D9BwjoG1EdipjEy+OB3jI+LcKoF0XTFMvKbXkYml/4vMyWE5GyeaTi7pg2aLENUDkYe8t406+RNLZAUwJafC8GIzePbG/nF9ZWwYvwhTsbGaMWJznxR7SRt++5jv/OI7qbZPR4PrxV7rcQ/SOn5Jw6zEkhkwsYV5wAdJIoOAbQb227bBFtwtyV+NOzYwLIZ5qKSR+MCKEU+KENkQVaBZ4hrLroUqdsH2HOHPxF7K1IGMEcimPk3cq6S60IpLaO/i+T1ZOkFcjo4hlsHLmiQYTGozKfnNyRjiRDCr6+zEUE9l01e4OINqVO2DUS+l8AfyrDflu10V3QGPPkE2W5+HwALm7dq305Btqpgq0cqg9kYG3bBVU6E+PHvzcDLk4whQZoyfUdQUFmqjxzK6N5Jx9koHA0nLOc63nSr09wTXzcootb9UnYOiCK7jHehYDAkrX89GvbA+Cv7UNGJwQXH6xcNUQW6BiTJmNfabQa0yHs86neegmPsqQsbezbYSB4h6rKr1oIQxM4wjbIF+bWFC0g+f1svRBPicgQ48jVcMKjSi6s8cpd/E4Y2b1IX5HguOl1So39M8Zc2mnYS4is/kNShLGcNhtA8kQb4cPJqEy17LJabv0xmGIsbJaEYu3j23Xg7fCXH+S36DBwyZ3/Nf8Cq3twBQkm2SfJbdfV+uiJuD3dxk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bldmaktCSGt6UitiVEt6WGZva3ZsYXhYV3NkVHZQZVpJZTJMdjkzRG1jNFow?=
 =?utf-8?B?TkErdmpReTlqNDczMzl5aGp3NjRrb3Byait6MFB3ckJUM2RzeDdQQ2NMOHB1?=
 =?utf-8?B?UHdabDFXVGpDaStXMHQ3NVFQVTdqS0FOVjFqQ2U0QTk4a29qelZQSHZKdW1i?=
 =?utf-8?B?NVRBTG1ZR3B3T2VjOTZCU3FGU1k2cXNCSUYwR05uN29IZWk5aHpBeGsxWHdG?=
 =?utf-8?B?Skd5Mjg0d0FHYkJjZFFsMm1mR1ovSHNtbVk4RXR0TmxrbGNBZGd0SFg1ODhZ?=
 =?utf-8?B?YjRibzU4Q2t5OHRSZlFoQ3pFZDZaZ3Nyd09HaGFMZ0NyY2k3eE1DTkZSVUdV?=
 =?utf-8?B?VFF6eTdqZnV1U1dwVnZnUTJLanpvbGg1T2w5cmw3ZDV4c3FacFRDT0xqanFz?=
 =?utf-8?B?aTdjSjNSZnBKaFNzaVBEOGZiRjdIdjhucGJPQzl6aytRVVZHbE5Kd3V4aVN4?=
 =?utf-8?B?dW16Z0hrdVRqU3lPazQ3ZWZFdnQzanlJU2piQmFVa0I2ZW0vT0dIZFJsWWw1?=
 =?utf-8?B?VDFJaXhJTm1HNUNXZSs1QXZmWSsvVWc5aEtHdlFaZzRKbmZxanNmTzJycFda?=
 =?utf-8?B?c3lSNDhwaUM0eHZ4YjF2UGdmd0ovb0MzMUQycGp0NWhRSnlpR0J5Skx3KzYz?=
 =?utf-8?B?alhRVVhma2hoS25GUk5TcXI0RnVBR1BpL1dOME93ODcvQTdFdlJSUXg1MUhG?=
 =?utf-8?B?ZFRSMkpLYjRHa04vRWNGRUlIUnVocTdsb1RhaCs0ZG0rbVZ4V0c1YzE5RzdS?=
 =?utf-8?B?OUtUbEZsSFROV2x5dUNJWWhBVjFCWjduMGlZczdPZ2R3THo0Y3RmSzFnQllr?=
 =?utf-8?B?V0ZQMVVXVzJxdis0M092SHhPbjhON2hkZmE4SWIvWjJjS2ZrOVgvc3hqVThw?=
 =?utf-8?B?cmZNcUZIeWV2WFlBS0FWS1JtajFFK0lFd3E5czJxampUUjVuSUZGOWtPNnpt?=
 =?utf-8?B?ZDRObnRLWWE0cjRVdUZWSThkNVo3cjZNSmtzMVlocEJySG4yR1I0SW5qYldi?=
 =?utf-8?B?Y1FubDQrTkZmeU5tQ3ZrRmJqRElvQzFlYXdaRllaYTRib3JaOGFkZUxQRGFW?=
 =?utf-8?B?QWZnbDB1R3R4U1lhK0E4YzF5c1graXN5eUo2SjJxUmZvRldzeDloWkpERWNr?=
 =?utf-8?B?UzBVVTdGaENUYVRyc05sQ1R1VEU1VTNXbzA1a2FTbStWV1ZadnJZQWtQV1FX?=
 =?utf-8?B?R2J3dnNWN3dTVzNGRzlYRzNINEw1YVBKUmVMVG02YWEzZy84NE5wdkdzdnBa?=
 =?utf-8?B?djhhU1Z5WXpZVGxieU1iS1lFZVphZlFhLzRtdFhYZ3pMR3JPdkRqQWVYeXhQ?=
 =?utf-8?B?TWRFT0piS2lva3B0R0h1YXNLWUV0eDM4cEZrUTAxLzNhMFZHUnJZMmdGNTE3?=
 =?utf-8?B?MlFnOXBqbkhEV0l2YVp4RjJ1WExudnp6c2RrUEJDcUpWVmhmNjZCTDE4M2VW?=
 =?utf-8?B?TEYyd0ZDV0NTUU5id0hTbkMzdzBtU1U1RmRmb2g3UFRGU1BTdVJsYUNCZGpS?=
 =?utf-8?B?anM3MGo5RmQ3WVB3YXFXN2JVc1lnYjZDbUJTOWNBSDhSWGdvbFhVdnZFdWJn?=
 =?utf-8?B?andoZlNsbHQrTDNmWExZSGdjOEg2S1MrVEJPOERURkhiKzd0NGw3U1RHQTZl?=
 =?utf-8?B?RCtMNEdsQ083VzQxdmdBYmNIRTdlMS8wTmYwRUl1cG1OTlMzTVpLWlhWdWZI?=
 =?utf-8?B?YVJhekhWU00yMHVBOWVsbEh3NnpXZ3dNMHlyV0tMSDhRTENWMVVkOTlRdzd6?=
 =?utf-8?B?c01JeDl5cENYN3FBbzZVMTgwYTExbm1YV0hWRCtpb2JNb1hnN3drdTd0OXdW?=
 =?utf-8?B?TW1wemJOSEpGSzJvbWtqdmNWdGVtdzJFdUoxdmd5eEZrVHhPK1RrNkVBQ3U2?=
 =?utf-8?B?UEpXSFZnZW1iQ1BaYkpUd0paVEFYTTdNS3dicUVMQnN3Zzh4TWk5YzRDTkVQ?=
 =?utf-8?B?RGtwaTZKM0VRT2J0QjhtdHFjb094WHl4Njc3NUs3VzR2N2tLQld1c0pPRnAw?=
 =?utf-8?B?Y3BYM0Z5dTRjK29zZXVaN3MxYURNZ00yaG5iN0ppVWgrRDZDS0FuTi9SYWxO?=
 =?utf-8?B?N0p4bE9qOGNYNEZ4d21ESDhrZGNyN1V0Rk5HTytDRWtVYVZxMXdOUTlxMERj?=
 =?utf-8?B?d0x2SnZMNU8yQjZibzVQNEFzTmZrQ0FhNmJBc3ppYUV5Z0hKQTZ6MDI3QlVI?=
 =?utf-8?B?dHVZMlZ0cGRVNktXNTR3MEFtOTRJeWlyZThHa2pWS3JMNGh0TXMvS0pkMXIz?=
 =?utf-8?B?NndsZFFMREt4cGhwakNJVStEQkZxcXk4MXhJRCt1R3RleVVCekNvM05sVnpB?=
 =?utf-8?Q?c38v2TSOhwK8zO4NlL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cf933a-d783-4f83-d941-08debbae7d16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 05:12:03.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He/C012+aXvnQ2Y2vpxprdSOEn5JErkWDojZyslfW1SfFRFr5154CvAescKRorPabSZQiE8ENignDCHB3aKw3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292090-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 154985DF585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 18:57, Jakub Kicinski wrote:
> I'm hoping to start feeding our docs into the AI review tools, instead
> of maintaining a separate repo with review prompts. To experiment with
> that we have to refresh the docs a little bit.
> 
> This set exclusively focuses on the page pool API. First patch is
> a straightforward fix for information which is now out of date.
> Second one attempts to clarify the NAPI linking requirements.
> Third drops the dedicated section about the stats; the document
> is primarily developer-facing and the stats should require no
> development effort in most cases. Last but not least minor
> API cleanup.
> 
> Jakub Kicinski (4):
>    docs: net: page_pool: drop reference to removed PP_FLAG_PAGE_FRAG
>    docs: clarify page pool NAPI consumer requirement
>    docs: page_pool: drop the mention of the legacy stats API
>    net: make page_pool_get_stats() void
> 
>   Documentation/networking/page_pool.rst        | 60 +++++++------------
>   include/net/page_pool/helpers.h               |  2 +-
>   .../ethernet/mellanox/mlx5/core/en_stats.c    |  3 +-
>   net/core/page_pool.c                          | 10 ++--
>   net/core/page_pool_user.c                     |  3 +-
>   5 files changed, 28 insertions(+), 50 deletions(-)
> 

For the series:
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

