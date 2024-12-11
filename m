Return-Path: <netdev+bounces-151249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E29EDA7F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477DB283789
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330E1F0E22;
	Wed, 11 Dec 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XlkQzWXh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021351F239F;
	Wed, 11 Dec 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957930; cv=fail; b=mG3+8nf1+SL20zMsPX4UWmk4Ymp7mB95jWXGxxwsmMJf/nCAnPNv7D0wMj8pVJ4vVjfD5fBgpol9xpm5JlDrV7nlfF8uigkLIMVA8GP51OwNUPJruznt5xpSPNPaIpUNv+EU8whkmz43fDFNV8jOhSqH+4muJxXtp5D8Z8uIGs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957930; c=relaxed/simple;
	bh=KB7u6MtbU2qQ7QQkr9gChUEl6yJsLuvxFmzajPmwU9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5Cx2CSg5A/xxodPeAUdAIjISPQeN5xsYCdo/zaLfaMpckHnb4lgsjPHxV6deEierpJGFdaM2kOHnxdYOAU5BQrMcrRykZZew6JBS+vwKhnrtQfm+0OKeXzR5+S0tRlyi14e25ShbRS3TdceYUsXFx7gINhvx0yww+jUdDKz0Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XlkQzWXh; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HScIvmTfsjm2o1cOgev7WdENYn2csObfa/XVBJz9nnpx4hpQsYWerN8y8lSbvlrZvrhW1yt2Ixd9K3PyUqhr/L09NxaLWvjcV1yznmliBhEs8AFTCt6USMun9rxLLEHzXNRH1eFZxy8ZUe5e7Ra0Xjt32Jqe9xFqBlbPJRgBrUm7mD0D7+fa+8nCk5tp332pTESFz45Upp41KAW8v2z8LD7lhCJMEPVN/LByluOZu4dMXVQIHX5Pko6RyszDulBrVHjYVDgusBB9BwIx3JmL0ikNQUAfOJMdihIz5psBu3QRztv9Tifv7p5jFi/sP7Rc+RthpXjG+IMv+SFfGKEAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHTGIa4on+mi8rYWevQmI6faMGpgVZd7a3jXACw1+VU=;
 b=e4CsmtP7/5ReInLSqRi4wuJ3CghrnAkgR4uMwY5zpDRAejB9LL0bj1N+euWuqlzAZCXq4VyQEZmPh9/VR/0BZL16GLMCuwXAkK4Ov8hbPcNRo8OvlPtXe4FjqsKD1T4IBXg7IYkZmOEB7R2bAv1+omr2bwCEDzP1ByqE/2OwHNrIXgDPQoOWy3/Fi0jsLVgzcZaAZ8DEaqeEEX7occgfmHMBzeyRuOSNNX5clbsV7KjCkm8XhA62/d4Ow5cABV1sfwipYfkl0vIffAuq0igfAG6L8KLp+AbWxLZsUgVXu+nOEzWmrtbUY+PocZ1uBrNBW0g21LbuKOREHmElaGoqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHTGIa4on+mi8rYWevQmI6faMGpgVZd7a3jXACw1+VU=;
 b=XlkQzWXhA2/sIZn22PdSM1CbD/u2f+mDT8saOGcZA/xWwQjv2ZKVqb6wmuB3jpMenbuDTeOlr+UriHOA7JV4XP5aipsMQzhJe3XywA+mt8kTrK1I2txKZ1Y8n6XaUcNlIO6vxBjtV42ZPDof/3hZiYF++FBZlGIFiQbH00fHFvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.17; Wed, 11 Dec 2024 22:58:43 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 22:58:42 +0000
Message-ID: <b706bede-3ca0-4011-8b42-a47e3d3fa418@amd.com>
Date: Wed, 11 Dec 2024 14:58:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] net: Document netmem driver support
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241211212033.1684197-1-almasrymina@google.com>
 <20241211212033.1684197-6-almasrymina@google.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20241211212033.1684197-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c7e4ff-1efb-47fa-fc9d-08dd1a375c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blRtVWFOQ2xFYTFvb2kva0VaRWFKdnFCZkhoL1R6QUl3UTlVVk0wWlFNMDda?=
 =?utf-8?B?aVlpQWR1K1AxeUsxTjhiYTduTVJCSjdhOUVRQndZWG9WTVVVODdOc1FlWUpV?=
 =?utf-8?B?K3lBY1lRRnZtZnhWYjR2YXoyREtPbFpLcVkvOWVURXl1R0JtS0laRFloUk94?=
 =?utf-8?B?Ty9qNHBjeExzQVVvMDVGYU9Wd2xLQjBIaHY5Qy80Tk1uRWpvSndqM202bVhN?=
 =?utf-8?B?Ym9oMzhSaFR3enVQM3hOSzJtb2J2WXZvMlZ3NWRydE9LS2ZEQnB3REdRSDBL?=
 =?utf-8?B?ZVhkNDJraVJMbG1JZlZXZGlkV0tGcVZBZ3U3ZGhPOVY2czJGU1cwcVVYUU9K?=
 =?utf-8?B?V3dvUjRMRHZuaXFoQk9hQzVURldjWFg1alQ1RHlzUFRkdDQwb0Ura2NVRk5E?=
 =?utf-8?B?d0xJejY4NVFUTmZ5Y3dvQjJLY0dlaXVsbGs5Zm11K1JIQm8vUnBlMVdGWnpK?=
 =?utf-8?B?MWZqbUt5aGoxSnBkR3FRSk5lc1V5ejQ3ZTZaVTJGeW9ZYkk4Z2NJcHV4bjNE?=
 =?utf-8?B?dGVpMnRBNWNZUThCelVTbXNyUnNhdE1KaklXZzd4bHh3M2J0K1FpKzZnNjVP?=
 =?utf-8?B?Y2dNcWRFWW53a2wyNS9taHllc2FkNFoxWDdsaXZPU1JpV1dXeHp1RzFFSHlJ?=
 =?utf-8?B?bFBuMnJKeHZ6amVqVWV1ZTVEMk96WWJCNHhkZUVDNnBZbnFneXk1WXdtbGN0?=
 =?utf-8?B?ZC9vMDVxeEp1VFFmOEpvQUVCaWFJV3UrZFdMYzRZZmFJcjVkS3RPWk5Neiti?=
 =?utf-8?B?SmRSOGRBM2FaelhPS1ZjRXVHOEJjYjVjZ0dMSjRKUXgyQ01oT2xJVTdtWmpy?=
 =?utf-8?B?a1pPbHREYVFzWHp5bjlESWRiWVN4N1pEVTQxaFV2S0JJT2hCejBRZ3h6SElE?=
 =?utf-8?B?R1NtTmZPZG1BZFdKQjVEeW42MkVZNjBxMXhYYWprQU5EUzRoeFhIZXVmRWU0?=
 =?utf-8?B?UTl3SnA0VEZOdjhiM0lYdzVvamhKMUZzYTRxY1M1d2MvZTB0dDNwSWdhbXNG?=
 =?utf-8?B?YW1yTWt1OWNvZnBXVGNGb0RoT0V1cUdLbGJNbVprYVZaWWU3OC9CUldhdmtP?=
 =?utf-8?B?R1JPWTRDZnJZaWZ5YmdSQ2VIUGZ2dnVnRnN4QnBqcklCZlZnSEhwWEpNNENX?=
 =?utf-8?B?a3ZWNWJ0REFBTloxb05oaXFCaWdBRVBuMDU2QVZpQ0FPcWlvNGJGa2VvSVRU?=
 =?utf-8?B?MWRiUGx4UlcyQm5wMDNreXloSXp4eCtod2FqakRkZVM1Nmg1U092elc3WEFj?=
 =?utf-8?B?U2NhUk9xanlkN2phQmljQXI4Y29zM1YrZ0Q5R0VyeUkvbnlOTnZmQU1PWlFV?=
 =?utf-8?B?ckd1UHhMSDQzc0xsTlBBUkNKYkY3RFc5blVkdFVadmcraHU2UisrOVoySXVO?=
 =?utf-8?B?WFlKUU8zQjFKdU1iVjRTUXNMSFlOZkpKQ3MvRVQ3NjAzL3h5L2VMbytUbmt3?=
 =?utf-8?B?Y0QvRW5UN0JkS0hWd1IvS2xFOFVucUVuWjhKSk0xVEs5dHY4b0U1VzdSNW4v?=
 =?utf-8?B?VzNzMmxqUVkxeUtDenlZN2RvaEdSV2tOZVV6MjEwWlBjdC9oM0lITktWdTZp?=
 =?utf-8?B?cGxZMWR5aE80eGthQkVXLytIRVJ1bUdEWDNvajJJVXY5NnJKMDJMV0Uvd0Qv?=
 =?utf-8?B?M3RpQnNuQ2FJSzZlZXRUbGZFUzRvcDYrbk5ncU9DeHhkQ3l2NEdPVEdYL0VD?=
 =?utf-8?B?VGFzVnBhcnY0K3VJdUNTb3pSejZXRlg4aThpWmNXZ2grMGhEMllsK0RyK3JH?=
 =?utf-8?B?NEcvd084MDJvZEJQREFmUkVOdmZBKzFYejF0ZmE1ZzBOd0tINjNKbC9laWNa?=
 =?utf-8?B?NEtXQm9zNnJqWHRJeDdOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDNucHNzU0p0ZWpNcmNuSWdCSHdJWnduV1MxUEdFVWZRYUZYVWNKRklJQjZS?=
 =?utf-8?B?aWVmRjNZS3BTeGEveGFId0dPcU9YNXZoN1F0dXBkTm9UbmNiZ1ZIb01KeUJS?=
 =?utf-8?B?SDQ0S1BCSzNoUjczMlQ1dEFoRGpLRERvS283WWgrWkpRQ0ZaWkZBcXBuekdx?=
 =?utf-8?B?VlJITTA1RUMxaTkyb2lhOFhORHdiRXVENmJrQ09FbEliMkpEZjZqRXpBL1Br?=
 =?utf-8?B?NnRmSHhxRitNRjlHYzdVU29sbTRCdzJiVU1zUmhCUWZ1dlZDODFQUW5FYUtC?=
 =?utf-8?B?VGZnNElWeUg5bGhqZ0FNSjI0VTdtSzRreWN6ZnBkcCs0NHFaQ21GTDZPK20v?=
 =?utf-8?B?V2VYR3hhWXVIQTAzSDdqY1dwMTQybFRUTW5wc0QzQ2h4VzZnQVI0bnIxZ0VK?=
 =?utf-8?B?SW9qbWhQZDFBOXQ1QjIwbkpSalV3K28vMDBhbVlqTURBb1BMZjdCSVhnMVNn?=
 =?utf-8?B?dnpnMVVWTURsSEJKbENweUU2UWNEMmxUZGdlWTg5UTlOVUMrTzhrNUJlc0hT?=
 =?utf-8?B?aWdraGw2ekptQ052L0M5cXpHK3ZTN0lNUjRKM01yV3FVK1FJYk12R3g4MkN4?=
 =?utf-8?B?T0JXSUVTK0hFL29xS3NDUXZUN3FRRlI3T3pvL0hRZ0gvQjBpQUoxeHlKWk1j?=
 =?utf-8?B?Z2VHN00rYkpDK016ZmFqcVBWdVk2VW8wWXJhSG5ERnM3SEltVmVhR3Foencw?=
 =?utf-8?B?T3k2ZFFOcDdjdUhrZm1ucERWU1hpc2pXZnR5UTk1SWJmd3RIT1FOTWJoNGsz?=
 =?utf-8?B?UEFONWFueVFzb2pMSkFUZ3hzTUlkaitra1ZSWWt1M2tuakpqU2U1cFlpRUpH?=
 =?utf-8?B?Ykg5L1hDOTE0d0F0dk9abktTN2RwYVV5MVNyd0JnTVhvL3hEcXhTV2pBVHBV?=
 =?utf-8?B?WHVycm5tSmwxeUkrQksydW9oTDEybGJCZmhhTFZVYnJ4RUx2SUNJejd5aDl5?=
 =?utf-8?B?VjNVODVEYkNUMFh4UFpDMi9HaEZDSm1TdlhYY1Q0Y2plSGMzeGYrWDVWcEFT?=
 =?utf-8?B?MHBSdkoxbGd2NW1QQkF0bEtFcFJrQVhwckRyNWRaYURuNThlNDN4aFN0NTJT?=
 =?utf-8?B?blVBaUM3RE9RSG83TnozZUpzTWRBSXduTFlsenRLeVVwYU5wMkRyQldmZnl2?=
 =?utf-8?B?dkp5NGhCbEN5clZoUEFoT0ZzeUIzNStJVnVQbUJoSVFDaWdOcjN3eGsyVU90?=
 =?utf-8?B?NHJkenRTWUllaGhYa3JRQk1uZ3U1UEF1WElERFk4MEoxWkJZZEhnTHlZc3Jy?=
 =?utf-8?B?ZzVpSjFVaU52UnExMmFjRk1JOUkvRVVydFBjMzlGT3pZTEpaY2d6MVJvQWxQ?=
 =?utf-8?B?N3doOGV1TWhNZm1adm54TGxHZk5SMzVaNWZqR3ZmRWg5REVXQ0V4cjZkandY?=
 =?utf-8?B?SXBERCtyelRaTmd2S2xRYXUxeHVQL2M4V29VQWM1ZWpnOG1KaTZtamRwNVJI?=
 =?utf-8?B?RlliYVRzQnAxMXdkVEp5SDR3WHo0eDVlTG1BcGhRNEhsYkdXZDg4VXgxTTJ0?=
 =?utf-8?B?S0lVd1hwNVB2YVpUZUl6UG4zekNKcVEvd0d3UUJ1b0t1NWZ4c3luWGJIU1lj?=
 =?utf-8?B?MmFobTRBM05JWm9UQUZoMVFUYkE5WG9OUHRHTXNrNEs1eW82eWNHZldObDhk?=
 =?utf-8?B?eC9QWWkrejY4SWtMTkZLWWM1T3lFUUk5QXNTdVZlOEpBTGJEckpodDdwMWp5?=
 =?utf-8?B?M09rbG45VEhmb0YxK2JxMmdZZ3hvcldGMWl5VU1aeENjYTRQZXltT0VVVGZi?=
 =?utf-8?B?OFl6S2d0b1hHM0xDc2pkZ0NWMXlXaXJxcEUwclc3cW04Z1pveEZKKzdrdC82?=
 =?utf-8?B?SUFQTWRDa1J6NDJZWHI2Z3IyRFpVQm13SDIrbWpFL1J2SU5xNllBNXJvemNI?=
 =?utf-8?B?SjJlUkNoMzIwK0cya3NVRXpweEs3TUhEWWtVQm5JdU1Lb1VVVkw0VkFEZzhB?=
 =?utf-8?B?b3hHN2E2VDI3QW9BWkR1UnRnV3RndmNIZnp6Y20xZGVQY1l6MEozek1NSzcz?=
 =?utf-8?B?eURMblFNU1JkZ3JwTkFYMjNvOUo2dkNhYzlsUzNGb3VudnJqSG9YeVBxOUVO?=
 =?utf-8?B?OXJxNDZJSVdkUFMxaUJnbk9WMWlxa2R5SmwzaHN3UXhwRHVBRUEyaTR4QVEz?=
 =?utf-8?Q?6RJodUI3LlpQpi2QB8BMaYatW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c7e4ff-1efb-47fa-fc9d-08dd1a375c10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 22:58:42.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMvLWGui5ItPXxXXd8vy5o2GPA28sl8kl9D+1WSqxQMH+r4T1lyscYbOBnAglQLvGakW7gmjc0rVj/RJNsk73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

On 12/11/2024 1:20 PM, Mina Almasry wrote:
> 
> Document expectations from drivers looking to add support for device
> memory tcp or other netmem based features.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Hi Mina,

Just a couple thoughts as this passed by me.  These can be saved for a 
later update if the rest of this patchset is ready to go.

> 
> ---
> 
> v4:
> - Address comments from Randy.
> - Change docs to netmem focus (Jakub).
> - Address comments from Jakub.
> 
> ---
>   Documentation/networking/index.rst  |  1 +
>   Documentation/networking/netmem.rst | 62 +++++++++++++++++++++++++++++
>   2 files changed, 63 insertions(+)
>   create mode 100644 Documentation/networking/netmem.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 46c178e564b3..058193ed2eeb 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -86,6 +86,7 @@ Contents:
>      netdevices
>      netfilter-sysctl
>      netif-msg
> +   netmem
>      nexthop-group-resilient
>      nf_conntrack-sysctl
>      nf_flowtable
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> new file mode 100644
> index 000000000000..f9f03189c53c
> --- /dev/null
> +++ b/Documentation/networking/netmem.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +Netmem
> +================
> +
> +
> +Introduction
> +============
> +
> +Device memory TCP, and likely more upcoming features, are reliant on netmem

Device memory TCP is singular, so s/are/is/

> +support in the driver. This outlines what drivers need to do to support netmem.

Can we get a summary of what netmem itself is and what it is for?  There 
is a bit of explanation buried below in (3), but it would be good to 
have something here at the top.

> +
> +
> +Driver support
> +==============
> +
> +1. The driver must support page_pool. The driver must not do its own recycling
> +   on top of page_pool.
> +
> +2. The driver must support the tcp-data-split ethtool option.
> +
> +3. The driver must use the page_pool netmem APIs. The netmem APIs are
> +   currently 1-to-1 correspond with page APIs. Conversion to netmem should be
> +   achievable by switching the page APIs to netmem APIs and tracking memory via
> +   netmem_refs in the driver rather than struct page * :
> +
> +   - page_pool_alloc -> page_pool_alloc_netmem
> +   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
> +   - page_pool_put_page -> page_pool_put_netmem
> +
> +   Not all page APIs have netmem equivalents at the moment. If your driver
> +   relies on a missing netmem API, feel free to add and propose to netdev@ or
> +   reach out to almasrymina@google.com for help adding the netmem API.

You may want to replace your name with "the maintainers" and let the 
MAINTAINERS file keep track of who currently takes care of netmem 
things, rather than risk this email getting stale and forgotten.


> +
> +4. The driver must use the following PP_FLAGS:
> +
> +   - PP_FLAG_DMA_MAP: netmem is not dma-mappable by the driver. The driver
> +     must delegate the dma mapping to the page_pool.

This is a bit confusing... if not dma-mappable, then why use 
PP_FLAG_DMA_MAP to ask page_pool to do it?  A little more info might be 
useful such as,
" ... must delegate the dma mapping to the page_pool which knows when 
dma-mapping is or is not appropriate".

Thanks,
sln


> +   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
> +     by the driver. The driver must delegate the dma syncing to the page_pool.
> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
> +     tcp-data-split is enabled.
> +
> +5. The driver must not assume the netmem is readable and/or backed by pages.
> +   The netmem returned by the page_pool may be unreadable, in which case
> +   netmem_address() will return NULL. The driver must correctly handle
> +   unreadable netmem, i.e. don't attempt to handle its contents when
> +   netmem_address() is NULL.
> +
> +   Ideally, drivers should not have to check the underlying netmem type via
> +   helpers like netmem_is_net_iov() or convert the netmem to any of its
> +   underlying types via netmem_to_page() or netmem_to_net_iov(). In most cases,
> +   netmem or page_pool helpers that abstract this complexity are provided
> +   (and more can be added).
> +
> +6. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
> +   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
> +   CPU will be done by the page_pool, for others (particularly dmabuf memory
> +   provider), dma syncing for CPU is the responsibility of the userspace using
> +   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
> +   the page_pool which will do it correctly.
> --
> 2.47.0.338.g60cca15819-goog
> 
> 


