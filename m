Return-Path: <netdev+bounces-234753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A239C26DF5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DA73B04E9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F62DC79D;
	Fri, 31 Oct 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sQsS50To"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CC325727
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941478; cv=fail; b=VntZ9BUecxwlVF88SVh3PIG+ijY86S8o/WL9b1D2lxTG4qd09rDDL6xiIcovzfI4SJChlEKaO3gUZ0N7lShcYS5Os0oRSxeQYASydh6QCNk9TofXiZjD6/EHZZhk9nEVKl0b5F59kxWKg0uqdBCLL1Ww66E1i4EHpbZ3E7kUPbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941478; c=relaxed/simple;
	bh=SK9lONH2WIk2I38CGw9a5VdHwv7Zua4FimD8FttWoYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gzASdKnIsVGItp8YOKmhSi6RvHdv6WsvjC9/t065NHl0FqIQPX6PgHPh4+y2bz32KSvS0+BGfad2990BLS2HHor52NcyOr7D79bgOvjUfRm7dq5QhjEbAEs2HYgEzV/nP0ER9c3zt5Tk6HJm/Q/E5LQUJtoPJk4nEMjc8dcv714=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sQsS50To; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uglFn5jJlHlrylBr8BH1uV55b26x0L02DnRm7tuDxBC0q1Xep7Z5h5yT54yrED1USnXl9r6E7+sroqqY1hbKMoHGeZBNFgfmIpWxVIDCozgiR3M+ykyLU/bCecdMASQ0ewU6cNaaK6AHYvQOInqG+pRQfVY1jyMDgKe+O1fkWGuweutpyc6WWLxStARQ91ItSujg4+CcyVG5DPxCPE3KGBdoi++NiOoXM4o15UwmM3tAQXZdmF988wi+5qdaGSBEQVbf50/VAERqtvwn569Ngt9l6wzg23FimTBuV+SO25KHWCycspedM+PnXugMKHOr6d6uRJLybr+UfcUu85eL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vUAtVXlD5B9dzEI7J47CU4NjBNR1WCEDf9yMAn/0Mw=;
 b=T+kSoE8QPi43ezsd3xxJBrQ+VNCt3ZKw5ANy43G7zzTxVZsYn1q+r/B56tipPJPZU4HOQSbgIH7/Y0e3KgvJplafsuDOfd5GlCSamP/I7pj00R5UTM6osLxGfwpAIi6xcCQjxG6oqEI+NwwtlPLw/6gcKH5lm5yJbR64+d2xYNbpNIjo3LiN/OGL9JgEbIIEsq3VgCx5lGxCsr25p8ukTgn4+lLXTP351xsyJlNihjqkJbrZ9pkT0HPuQXKLY2F+9niUSGsDTLMOuCP1UAoNyEX3r78UzehFeZzwAuMncefXa6Pg5X4asrsOwOQvW7X2E2dX1NFxp7uBkweV3NQ7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vUAtVXlD5B9dzEI7J47CU4NjBNR1WCEDf9yMAn/0Mw=;
 b=sQsS50Toxh13qhEUqr6YI+rnrh2AtKuzBZKEIfJTzHDGjmn4PiymUn0lnZCEZLdUJ3WCaIvC13I4P+N0niBH9BLb0bXdS00CueQB1fz+SErXWFIqMfIdo6b0v4xmF/6xEULaOUHKr/aYpYzaUgqUE6VBvEeB1ZKnt4+Ufqihc+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 20:11:13 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:11:13 +0000
Message-ID: <594de4e3-90f5-489a-8cc8-ddc04149d1ac@amd.com>
Date: Fri, 31 Oct 2025 13:11:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ionic: map SKB after pseudo-header checksum
 prep
To: mheib@redhat.com, netdev@vger.kernel.org
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org
References: <20251031155203.203031-1-mheib@redhat.com>
 <20251031155203.203031-2-mheib@redhat.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20251031155203.203031-2-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a31ef9e-499b-43b6-72e9-08de18b9a3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHRyUnZCRnZZNXZCQUhvQjNHV3M4cUphT3RmWUx5OUtQcTRvWlNmWk5kTU1G?=
 =?utf-8?B?cWVQZDBJckZRT3NNeHdxeFFmUkpaYTdWQVZzTnNnV056NDdRV1dQcHFSZ2dP?=
 =?utf-8?B?N09ueU9FaTJHaUlqaUVaTE1IQWpGbGo1OER6UUQxSWIyeWl1RHB3clNOczls?=
 =?utf-8?B?ck5XWjdhUWpYMkhwY3pYQVB3VWhmWWk3UHgraWNiYnNxUnA5SFZBN2FLeUlT?=
 =?utf-8?B?TTd5b3ZFVk9EWm5HOFVLWU9QKzRKclY5WHFEa2N3SklUQnYxYktTTDJGcktI?=
 =?utf-8?B?RVNTM0hzeEsxNkRzbHVIUTZDM0x5d0ZmQnFhOVRhYTRFQ2s0K0p2cDU3N3hK?=
 =?utf-8?B?dXl6bUhVREZzNk5LOHNuZE1NTHp2V3lEU3crNnhzbFJNOEc4elFpbmxXUG1F?=
 =?utf-8?B?cFRHQ3JEdTRuaC9Mbk83VmU3YitEL0VLNGF4ZWpxRm56NDNNNStLWmNYa0V3?=
 =?utf-8?B?My9SODUwS1pkY0RjcThZVnd3RG1yOERUR0xXZlYrZXkwaW4yanp1NjlhbUI0?=
 =?utf-8?B?c1ZDNEFUNUxPQjBwT0p5c3BWdWZtdW12SVh2VXdacjVIVVR2L2VlSzk0b0dQ?=
 =?utf-8?B?N1hrVUVpSDFXa2pqL000ak1NZ09qM2dsN3hLOFZOR2F3ZGEvL3dsK0ZobUpH?=
 =?utf-8?B?Y1VmREZhRmFEdngxY0x2eCtMYXptc29MRHBPTHlscUJpWWZBdjdpeVRXSmpr?=
 =?utf-8?B?aVYzUEZEVnJTOEo5YWFKdE5DSVhKa09WeTcvRHdEN1BXUnVkYUVPc2Z1Yk55?=
 =?utf-8?B?VGpDMmhzQnRDbGtJdjFmT3dQUnZyM1BQNXBLOU9Oczk3ZmhsZlIxdEtxWHM4?=
 =?utf-8?B?WG1HYmh6RWhLT3BWc0Q0NlowZ3ZacmRDMnJ4cXE4TkxQZmFZanN1cE1aekJk?=
 =?utf-8?B?bHFZNEpud3B5NElscWhzNFZnL3pwMXg3RGZ5dWRxcHBNN2tmblR0c0pDMlI5?=
 =?utf-8?B?d2FnYzNLZlh5V1Zmemo0R0x1WDkvU1hsUElyamJuL0lWQ3FPVUpMRStwelIv?=
 =?utf-8?B?YVdReEUyMVdEOW50bFN2L240QThvdmlQLzdQVVFCMzJ4aVY3ZWpoNGVrcGlI?=
 =?utf-8?B?T3ZkeDBHeGNWaFV1bXdiZENuZG5uaDByVW85UWxZeUtRUU1mb25MNzYxQ0NL?=
 =?utf-8?B?UHlPdWJ3cVZiVzRpYVo5MWM2ME9CaGs1YVZYd3lNK3NWU0dlRWZVQW1rL080?=
 =?utf-8?B?Wi9iZElXVFY5bjNnQUFKdDlqdFBzOUhIc0xuZTB6enBRMFMwdlJjNzNkdmth?=
 =?utf-8?B?RDdwby84T3RMOGFjRWlMQUg1bklhOUFZSXRFYTI1UWFJeWs1RnBGWTNQVklV?=
 =?utf-8?B?RFpHM1hqazUzYnArQURwK3hiNWVkU24yWDlpbFdDVDRYQXVmWVgwQ09ISk9V?=
 =?utf-8?B?cTFVcGlWRFdsVjVmQ2wwaCs5RWVycTRGMCtRVXNMVEg1TnljZzQvc2M4SWxY?=
 =?utf-8?B?VDFCYVhuMUlEVlY1YmNYMm55RWM2NFFna3p2RmpZWlA1b2dMaUpreEFaY3lO?=
 =?utf-8?B?dVpkMEZNZFVvMFNXc0RtbUs2cmU5YURGZ3RhTjJiTytuWTREV3BvOURWdmlw?=
 =?utf-8?B?S3lkUzV0UkRHdWlYT2toSVMrcTMxbGlJRGdLRWNzd29Ud0RmTWQxQ2NIQXJj?=
 =?utf-8?B?ZU5iajB0dlYvaWxWbzRHR21vVnM0NGJSY2ROYVVMNTJvWDJXRW5iUzhML1JV?=
 =?utf-8?B?SWhIMjlZQ1VLYU1YQS9SMU9MeVVSVzQ4ZnQ0V1FtUlhTaVIrM2ZMaUF6UHMr?=
 =?utf-8?B?VEJ2emtWanBTNEtBWkRndzR6M3RoMHZWWmpkWG5GTkQxYnY1L3U2L2RtaTVv?=
 =?utf-8?B?bkhIdzdqb1BqcDVFUHlKVVpFbExsSC9WVDBROGpVYTM2QW5mWW5tOXhPN3pr?=
 =?utf-8?B?U3F3N1dLV0JDZ0JFZkZZT2ZCSm1KUGJGU2IzTW1nWDNwSHZTMnhSdWIrZVNH?=
 =?utf-8?Q?S9+WDhGlnlmLqwbAuymCVeoEl1mF8P/B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vlc4dzRPSmpIT0oxckkxYkJJQzNwTlBRM0VUWnRMbTkwU1F6eHNDb2tuQ0JY?=
 =?utf-8?B?WjM2WmVJeWVJTFcvL2RyK2RKdTZCdzVJanA3UHhWd3dVZFF3Y21WTHJqODUy?=
 =?utf-8?B?bW9naGg2c0RnYWdUcVBkKy84Q3h3UmFMUTZOT3pEcUhaYllqelFwRDZUQ0wr?=
 =?utf-8?B?aDVpR1dST2Z3Q3dyeWlzMmVLYmhMT2FSRFY2YjdPQUpVVzhDd0FiMXR5ZTNQ?=
 =?utf-8?B?cjJ0Z3FtdjRpYnkrdnoyeHZUTWgvYW8vZ2UvZUxaZlB6bHVsbEZEK3liRnk1?=
 =?utf-8?B?NU5HYU95MU1IZ05XLzNOS21SRkRQNTZWVGEvZVRvSlN0U1FVWHZwUkpyUWkw?=
 =?utf-8?B?TFl4dmludEgvSjJsWFJycGJVWEZJVlV6WURXRnBoM2h0K3hyYkdoWDlEWmly?=
 =?utf-8?B?U0U2UDlDYzFFNTNuc3pYUlYzT2VVVmwvdjBsVG41cWFYeVJ4bVRmR0ZTcG0x?=
 =?utf-8?B?WnREZ2h1bi8rODV2Ymc3VWJSU3RVQjJvOTduUVhaaVcrL29KNlc1R1JMRjBD?=
 =?utf-8?B?VFd1cDBWY2dkcG96enBCVUJjRzN3WEdmRzV2alZUSENrQ1JMK3UvNWFzOTNZ?=
 =?utf-8?B?MmtJWEIxeGlOTmVDay9ZanlxcGEvcUEzelJEbVpGVm5ZSU5DQzQ4OTNzcTc1?=
 =?utf-8?B?aGdKU2J0eHhYNkhuMGExNThRVEpBSVRobGRtKzNoMkhpdElsN2pWY1kvbkdj?=
 =?utf-8?B?RjJQQXdDY0t3NGl1a2xKUFJrS3pNODhmNWxsQjgyL01Hc0Y3d0FQZ2xlaW9Z?=
 =?utf-8?B?QnVVdFc3bDZQR3V2TmVobFYvWFZXN3pvY240MkVoaG1xdldvSUw3eUJOTDBl?=
 =?utf-8?B?MGUzeWZJSzA3RFRDaEcvS0dINHQrWVNYNTNvYkFhR0VET21leEtNTWwrWWo1?=
 =?utf-8?B?ZHdDcTdCSDRZbXBtRjNmRDR1cy92MllONXZCOEZsYTRKV1dvci9manArKzNW?=
 =?utf-8?B?SFRLM2J3bW5tQXVRNU1mQ0orK1diQTFRN2FwRmhTcUJTemFOaGEvUUYwb3Vl?=
 =?utf-8?B?dnVpcVNaSDFKaVlQbnRZWUdnRGdzbmJRMDcwWUJjR1QvUW9EZEpBR1Vpc1BI?=
 =?utf-8?B?SmhjbVRObFNWODRkekNDWG9aUEcvelpVNG1TeThqRGw1UFpYMG44eTJhY2xQ?=
 =?utf-8?B?dExIS3RCVFpBRnlYUjVRNVQrV0FnWkFuUkljdVFiZDExazVwMWVaRERlZUd4?=
 =?utf-8?B?TTV3a0d1TUxVeVJpNGVxUlozNWgvYjBVYTdhd3dKcWtwcm5nbnlRa2lyNGxN?=
 =?utf-8?B?QW5zd0E2a0VTdFhqVHRFSFpmcW9mTndFclp0cTFjOG85eUtSSGcxQTNqQVpC?=
 =?utf-8?B?Q0czWkRFaXFZUkJoMWprcGt3OHAzdGRFOHRacmdEYUlBb0NJa3pFUVpvMEsr?=
 =?utf-8?B?NmJsZ1RhUGRDTE5ydVAra3Jkd2VzbnQ1TTY3MFIvemtCdmdSRHlJTTlQRFZw?=
 =?utf-8?B?cnByNmY0YkpiTGkxbDdYRzI1emxpbHluaE03a0VaN2xQeWpBdklwZG1KVUVk?=
 =?utf-8?B?ckNIRWNoM2w5UXlFTGRYalRVRUtCZklGTHdQY2hNK0ZxMFVaODdRclVFL1hp?=
 =?utf-8?B?ek5xb3IxL2VYTzFzaWM5MHh3MFRPa0hPSFg5ZVpkcG92bkhSOFU3STI1enNh?=
 =?utf-8?B?VGpFV1hUME14U0tQcFAzaExhaW9mV0FaMGJUTVZ0c3lDSDVZWERjRGdkSEho?=
 =?utf-8?B?OCtqcTdLei9VQVFrZGIrdDM2N1RYMHdEcVZPSDFkV0Z1YkhLY1VOaldZKzhx?=
 =?utf-8?B?V01iN1JHQUwyZDJ0cGE3ZTArRzc5TStJMWdIOHVVOGZ2QXFVeWYvazFHa24y?=
 =?utf-8?B?MDRxOWxLZzVVTFF3Ym9TdzF4azBaWVI0bWNqMTNQUXZTc25kOElkbWE4SXdR?=
 =?utf-8?B?cHV3NzMraWRFOTAvR0hNNFpOR2RPaXJKTHI4MHZsayt2U21yODk4TDdML2No?=
 =?utf-8?B?eXlRQjQwaENrZmp4MHhTWm1vOEJoVkdnVmRSKzJrZURTK1BRNWxUa1QwbXNr?=
 =?utf-8?B?RStKTU5VSnJUNFNDcHoxSm1vSW5Odm80ZTlreGc1QmRGOHE5eHdscFpYN0wv?=
 =?utf-8?B?a2MxaG5IVXNydW5lMlRidllBYTdyQXYzamRrcDRNNnRzVkQ1QWlxdHBsaFp0?=
 =?utf-8?Q?nUnrI0+IkN9bcQ85/Vg0f5dr1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a31ef9e-499b-43b6-72e9-08de18b9a3fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 20:11:13.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKzAvc712+p0/u+VytXpmx6+RuxZymfxQdpuaCRhSd+e1NvOz+A7xTrHCIxxPTA1m0/BT/FWUbDdVH/ggoFWrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531



On 10/31/2025 8:52 AM, mheib@redhat.com wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Mohammad Heib <mheib@redhat.com>
> 
> The TSO path called ionic_tx_map_skb() before preparing the TCP pseudo
> checksum (ionic_tx_tcp_[inner_]pseudo_csum()), which may perform
> skb_cow_head() and might modifies bytes in the linear header area.
> 
> Mapping first and then mutating the header risks:
>    - Using a stale DMA address if skb_cow_head() relocates the head, and/or
>    - Device reading stale header bytes on weakly-ordered systems
>      (CPU writes after mapping are not guaranteed visible without an
>      explicit dma_sync_single_for_device()).
> 
> Reorder the TX path to perform all header mutations (including
> skb_cow_head()) *before* DMA mapping. Mapping is now done only after the
> skb layout and header contents are final. This removes the need for any
> post-mapping dma_sync and prevents on-wire corruption observed under
> VLAN+TSO load after repeated runs.
> 
> This change is purely an ordering fix; no functional behavior change
> otherwise.
> 
> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 30 ++++++++-----------
>   1 file changed, 13 insertions(+), 17 deletions(-)

Thanks for the fix! LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2e571d0a0d8a..301ebee2fdc5 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -1448,19 +1448,6 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
>          bool encap;
>          int err;
> 
> -       desc_info = &q->tx_info[q->head_idx];
> -
> -       if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
> -               return -EIO;
> -
> -       len = skb->len;
> -       mss = skb_shinfo(skb)->gso_size;
> -       outer_csum = (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
> -                                                  SKB_GSO_GRE_CSUM |
> -                                                  SKB_GSO_IPXIP4 |
> -                                                  SKB_GSO_IPXIP6 |
> -                                                  SKB_GSO_UDP_TUNNEL |
> -                                                  SKB_GSO_UDP_TUNNEL_CSUM));
>          has_vlan = !!skb_vlan_tag_present(skb);
>          vlan_tci = skb_vlan_tag_get(skb);
>          encap = skb->encapsulation;
> @@ -1474,12 +1461,21 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
>                  err = ionic_tx_tcp_inner_pseudo_csum(skb);
>          else
>                  err = ionic_tx_tcp_pseudo_csum(skb);
> -       if (unlikely(err)) {
> -               /* clean up mapping from ionic_tx_map_skb */
> -               ionic_tx_desc_unmap_bufs(q, desc_info);
> +       if (unlikely(err))
>                  return err;
> -       }
> 
> +       desc_info = &q->tx_info[q->head_idx];
> +       if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
> +               return -EIO;
> +
> +       len = skb->len;
> +       mss = skb_shinfo(skb)->gso_size;
> +       outer_csum = (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
> +                                                  SKB_GSO_GRE_CSUM |
> +                                                  SKB_GSO_IPXIP4 |
> +                                                  SKB_GSO_IPXIP6 |
> +                                                  SKB_GSO_UDP_TUNNEL |
> +                                                  SKB_GSO_UDP_TUNNEL_CSUM));
>          if (encap)
>                  hdrlen = skb_inner_tcp_all_headers(skb);
>          else
> --
> 2.50.1
> 

