Return-Path: <netdev+bounces-281510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCi9IqXZ72mvGwEAu9opvQ
	(envelope-from <netdev+bounces-281510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:48:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0608B47AE7F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5A133034A15
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35E384231;
	Mon, 27 Apr 2026 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SDav9MwK"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435923505E;
	Mon, 27 Apr 2026 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326317; cv=fail; b=KxXhT1Fxc7YSDc1+lBjbs19A8EUaTNLpkqklHrvKheJom7AAivkFYCYvVYAl0TRz5lz9GcBe/lyhZQqHMGmKgxhDhrE+v1ntd2OoYxcsey2Bgwv4hcAQ4jL0wOgFxbsELFFF/m1XwIr3RFtUQsNerO28LsTzfRL85n0u6PjjxLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326317; c=relaxed/simple;
	bh=vfI6c/0WDVc/tXuhRWMKoUHtKl4fBULr1xFmXsoA+Kc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OYJHi0Li/6B5Z39jA/W9ebfWT+7TrvML9XsFQz6Rd+zH6NM8hoUGwmmbQ86MNS0wiCrHFj0se+2kYsnjOyES2990ixcU02tRZTRRdlNt1vz8YCFpXZfH+FT/wU62LwZWwB9sQOnNq34etYC8rvSSBcrXRNUcQfU5NAsIofSbetE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SDav9MwK; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg7glZQrvUuOcV3hMItQfvajmN7hQLHHMCguD8Lpe5dFkzj5qY4OfYy4JaWmceH15IaI++ZZzlqXaurcENhgbCQeWrg4DTuHRhQsk9BJxPfV0+NdY5kFI4NvLvBcrloarAyDxqBOpImNw3MhYBdOMEjE/C/urBNDn1pkka1LLRW8uLq/L8Wd2XHXalROO6G2rMWZpEz1MXC3ZBFIezC8AzOu+xOPuaiiMNMAzqBdJeELzT1YlW9+tHM9cIOrZA0NZoKHBO6yZ54/AsV3VNZh4y1kQzRdFftdYcL6y0mzX30bz7OnTpLVV0xEKQ7DgS7Bqa971fg1Tkpuu1eUjkJlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGiGIurov9YS281jrTNw6WkQehGXqW9IxQbsFlzZCBg=;
 b=wGwrcbrJ3BVQcoveHIET7jVy4RTqndkjp/eAl6SNF8auR8a33wAHEszAWgmOfyG8dJgi9h++5Ec/GADYL7obD/SkS/LJivFPb/6ycxlJNZsj3zLnfuRJmizZC2sHmtARG5F8g3Gq1c/8KEC4Aj6pWLKSFdGWG6S+rGMSkJe0dGEaCH6HFUdBniFGreaWr5giUtmZxGeXE0IX4ur+8bIaH3vzEmrY/B6v0WnsInRkN5n+l07N/u3Oqule2/GK+BCDI4Ylq8uAdsu0Coy2BafUYGjjxDdDRpJNCKZSk7Lu/cmM8PqRBYSyLTCRieSXHNNEXVLV5mqepriCdr5fpaLHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGiGIurov9YS281jrTNw6WkQehGXqW9IxQbsFlzZCBg=;
 b=SDav9MwKJChg1fEBDsJOdPhf2P4cWcPs2Nq9sRwWaEXnOCMSdnuOqa/89ZQExACh8yETsKgUkPrXLmjMr46PUCmu5LqGLqBjlJczTN24/6sTkAz4fgnR4YpowFIBHQXYiYFDDFS4SmcYUlBkfgEqTOSO/QCQTPGPUmxU9MR3CSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:45:11 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:45:11 +0000
Message-ID: <005e4fb2-c108-42c0-b560-a40cb259864a@amd.com>
Date: Mon, 27 Apr 2026 14:45:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: expose software counters through
 netdev qstats
To: Gustavo Arantes <dev.gustavoa@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Javen Xu <javen_xu@realsil.com.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427205931.5884-1-dev.gustavoa@gmail.com>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260427205931.5884-1-dev.gustavoa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:610:38::31) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 608bd3b7-bc24-4c0e-4419-08dea4a641cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n9OPGrE7midCzRzA9Vn30gisEYKjRacR+LutdE1gvBfoIeVF7GBExBB5FuJ5ZYwa4mnMWq4csBBS/GaU2q3K2UCl0ZOeUP7Y3gae+t8YYkeEGUgWtItdGotH3wq+K8yQ9/ryMlXI7k2LyJO2SdY8EtxrDNie/farwJxEtiTQwvbR7cg7XDMwS2H4xtxGHWRVoAxgwxauwhaqNvxhk7ZcG9SaG0veGVRz0+h0S6HNTKakFUurRWgtLmQ2aYqsCl2zEyO5GaUbGQ4bx6GXa/Kbl/UiepeBBsCgkcCWXCpUGzJdzXccS/Y/srjcU1aoqwGXr00KvnB0BJM5nvGqsiSjrZWtgUgXw7eR0b9NwP+oXiNxerAFvRnLn4F/sHbCrFP6Wz5XhsSyJlQQOGSb48G6cCCXm4t0H9ogsAmwgRQL/3GEkjHkIz4jPcLprRm6nO6oCa2U0YfnWiiUGulBzroaK0cHHNdNRt5ROw4OReDfhPvgYnsgUID2LatRnXrT3O0OSDQpnbZ5B0t7qSvGnnUgISSh+yw2ARMMMRyheUsfqmCB7TbIthsuTKDM83xlZ/dlKPFwet/nS5egsI6/SF/Lio+s5yLos6ydZoijClARcdp/kX5CEB4C1dMkG5Rckl6FRsVDCLZjKi68iHg3OvB5ObbrQAbx1d06ZfKvpNShrSVANl88ywP96fDR/P/jXphQPY+59EcAvlgrp+cudawrhXwSV3U2AcHSlwdFt2b56D4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZS8rLytEWldqaEduZGlKOGxPN0ppMDkrQkN3VHJ6OFR5a1FGRHdpNlFLR1Vl?=
 =?utf-8?B?dkZscU1mclowLzBpdHJLTnJhd1ZrYyt5T2c0UFV0RE9rYUg4MUk2ODVDRDhK?=
 =?utf-8?B?WWNYNGNCV1JZQWI5S0RWc045V3BLTS8yYitZaVpnMGdCR0Z6czlhUllZWEFB?=
 =?utf-8?B?STdXZER5dldCVGpEaCtMOUw2KzM4NDZ3WVQyNzlrV2hsSmkrTnpOTTA3bGlO?=
 =?utf-8?B?OFoyUzVUVTdwSVVwZ3UyVU8yT3hTdzBKbTU4YXRoaTlhRVdUc2t1R3k1UlA3?=
 =?utf-8?B?bG5OMUhxQmRrSFFlbDB3cVJZTFNlZmhxR2VweE9SaUZrYWhKQTE0ZUVOKzFJ?=
 =?utf-8?B?REc4RWo3bHVRcGlvWGE2ZXdVZUxucUp2VVo5ZTZGWVRKRGdtYTlyUUprdDlL?=
 =?utf-8?B?eERUT1ZqWk5PL2EvcmU4Ry84OVJhelFnTGY2UkNqT080RG9meVNiNlh6d2lY?=
 =?utf-8?B?VG9aaVcybnZjY2hLd09aOE9VZUNTUy9iRzR4VnNScm9IQnVlSzlWM2g2YVlZ?=
 =?utf-8?B?UDNPNDVhWEF1MFBTcnBlODFkZTJldHluVlM5SmdzQ1draU96cGFXSm5PMk9l?=
 =?utf-8?B?YWFmU29JRkwweTV6cFVQa1NtTFlPZ3I4bDJGQzYxYjVGUWcwMytBZEVMYkdW?=
 =?utf-8?B?R2gzRGRTVnExcDh6SjZ2VHNqN2ovZFkxckxsV0ZsM1R2MWZRWU9adnF2QzBw?=
 =?utf-8?B?Wi81S2ZCaEhVQkM2OE1aQUtkaEVNNHRNMFczSDVaWkZKWTFCaE1lRy9ZQncw?=
 =?utf-8?B?UXYxRStJdFlXNFpZbU9sUldzVHAzeGxSenc2dExqajJnczA3dkVYYXcxMlgw?=
 =?utf-8?B?SE9GWlRlTUZQMFpOMTdoNW1PMTFEQUZPRmNrdWZ2R2tvOVRvSWFmaEhSTEQ1?=
 =?utf-8?B?WkllWVZ0YUhrTmY0V3g1TElWUW5LSTlQdUZINVJlek5GZnZZeVV4dHY3MnVH?=
 =?utf-8?B?UHVOR3FUa3FJanM2N1J3dEVpNE9CaUlVTzFNdmw2RlRIby83aHE3QzhzYi9M?=
 =?utf-8?B?OW8vT0hWeEt2dmVadDM5VGVYelJrQkhtcUtKSWkyUjlwTGxYQjRTYWFJTW16?=
 =?utf-8?B?VDQ0dTVuSDBHTHdIRUp6T1IxaUlwUDRDUW1MS3V0YWhzTzBjTUpGSGxtcVZw?=
 =?utf-8?B?V1VUT1RoRXl4a0tyazVpdUVudlZUNTF3cVNDa2lzc0E3NVRyTnBveFpDcUpT?=
 =?utf-8?B?WUkwZStJZVI5RFUvOW4xNFJoUzA3bnoxSWxFNHBzbTFWZVE3TEUvUGlSRkNI?=
 =?utf-8?B?NVJWOGI0MTNIYTk1bVhQNnNUeFhNcWNKQ0JLNXloRm1PNkwwdGIzbU1sUjdQ?=
 =?utf-8?B?WEE3aXhrRDQwTmNxbnFKb202NnZUY3pVM2JRekxiK1BoeWgrUE5pVUw0ZG1V?=
 =?utf-8?B?bGNScTh1TnhQWFV4Y2x6TitkTENwTVFZUHVlNFR6aWw2MXF5Z1R0QThqcm5w?=
 =?utf-8?B?UVNWZ3FJb3BualZGVURMZEk0L1dVSFhQOE1xekNsdHhrVE9UK1NhNm1QRFBM?=
 =?utf-8?B?ZDdGT3hra3hhVUNhR1pJZmdWRnlVSU4zU2w0S2pSaXU5VGZ5UXJISTlOUWY2?=
 =?utf-8?B?d0ZMNzRybit3RkE0Tk81WC9oM09sSUl0MVR0VTIvdUpSVTFXVEJ2czJ4Q0dy?=
 =?utf-8?B?cnpUeldqSUFFUGxBVU5BanJtZ2lmMmpHS3VCdjdpcGkxcENLWDRFcnpDSWxU?=
 =?utf-8?B?bnlPSGtJVEJwMWh1YXU5RlpTN2NjeFRGdk1QZTFUVTFULzgxMGJIV1dPR1JX?=
 =?utf-8?B?UUZodFZZcGQ0MmhmYXFKdW83azlFWDl0d2JPUWgxZFVEbXVOMEtwOEtUdi9B?=
 =?utf-8?B?KzdhWmV6Q0t1eEtkdUU2c1R1RnVKK1RMNFE0eU8zdHZSZTR3ZW1CTGEvRWFu?=
 =?utf-8?B?cDA3RTNOMm9hQjV0NmxEdXBjZk1qQ1VEMnljQmVrTy9oYTJCckdIUTYweHZM?=
 =?utf-8?B?MjZQTUxvdWEzOTBoVEc0Z2VwNVFUYVFTTDVPRXNTU3NSZllvU3VRS1pwNmdP?=
 =?utf-8?B?TDVaUHZ5bjd2L2FXNDZhcGFnQ3RsOFY2V1FLVmttQmJzSVNmV0U1SDJNTTU4?=
 =?utf-8?B?d1A3ODJMNGp1amRXVitKSEZ2cThDYkFQS1B5ODlLQTlOb3dNUEtrZmI2RCtp?=
 =?utf-8?B?WExxditqYmJ6eWVQS2ZVQTRQTmtVby9iZDFqSTB2dzlZRGJVVHRiaGRRandx?=
 =?utf-8?B?d2hwbk1NUG5lRGUzOG1qLzA5c3plSHVPSnc2WmhSNThOOVFnbyt0Y2ZHczdv?=
 =?utf-8?B?TVd6a2pUdmgyUjJzU1lqUXExQm9ZSXFpOGtLaVI3N0p4bjh6OGlyQ0p1eVND?=
 =?utf-8?Q?UlmzFNjXoAFDNoq3TJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608bd3b7-bc24-4c0e-4419-08dea4a641cd
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:45:10.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aesV6GDxTiYpwAPrU59gajVvAZMsD9+gGLlpKaswHSAKZ9DPilGTUSEOzyArxgXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Rspamd-Queue-Id: 0608B47AE7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 4/27/2026 1:59 PM, Gustavo Arantes wrote:
> r8169 maintains synchronized per-CPU software counters for packet and
> byte accounting and exposes them through ndo_get_stats64(), but
> userspace using the structured netdev qstats API cannot retrieve them from
> this driver.
> 
> Expose the same counters through netdev_stat_ops. r8169 has a single Rx
> and Tx queue, so report the accumulated counters on queue 0. Use zero
> base stats so device-scope qstats are derived from the queue counters
> and match the packet and byte values reported through RTNL.
> 
> This does not add new accounting and does not touch the data path. It
> only makes the existing counters available through the common qstats
> interface, which lets generic userspace tooling query r8169 the same way
> it queries other drivers with qstats support.
> 
> Signed-off-by: Gustavo Arantes <dev.gustavoa@gmail.com>
> ---
> v2:
>   - Submit again now that net-next has reopened.
>   - Expand commit message to explain the qstats userspace benefit.
> 
> Tested on a Realtek RTL8111/8168/8211/8411 PCIe Gigabit Ethernet
> controller using the r8169 driver.
> 
> v1: https://lore.kernel.org/netdev/20260418021232.5425-1-dev.gustavoa@gmail.com/
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 70 +++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..9d833b446383 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5175,6 +5175,75 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  	pm_runtime_put_noidle(&pdev->dev);
>  }
> 
> +static void rtl8169_fetch_sw_stats(struct net_device *dev,
> +				   struct netdev_queue_stats_rx *rx,
> +				   struct netdev_queue_stats_tx *tx)
> +{
> +	const struct pcpu_sw_netstats *stats;
> +	unsigned int start;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
> +
> +		stats = per_cpu_ptr(dev->tstats, cpu);
> +		do {
> +			start = u64_stats_fetch_begin(&stats->syncp);
> +			rx_packets = u64_stats_read(&stats->rx_packets);
> +			rx_bytes = u64_stats_read(&stats->rx_bytes);
> +			tx_packets = u64_stats_read(&stats->tx_packets);
> +			tx_bytes = u64_stats_read(&stats->tx_bytes);
> +		} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +		rx->packets += rx_packets;
> +		rx->bytes += rx_bytes;
> +		tx->packets += tx_packets;
> +		tx->bytes += tx_bytes;
> +	}
> +}
> +
> +static void rtl8169_get_queue_stats_rx(struct net_device *dev, int idx,
> +				       struct netdev_queue_stats_rx *rx)
> +{
> +	struct netdev_queue_stats_tx tx = {};
> +
> +	if (idx)
> +		return;
> +
> +	rx->packets = 0;
> +	rx->bytes = 0;
> +	rtl8169_fetch_sw_stats(dev, rx, &tx);
> +}
> +
> +static void rtl8169_get_queue_stats_tx(struct net_device *dev, int idx,
> +				       struct netdev_queue_stats_tx *tx)
> +{
> +	struct netdev_queue_stats_rx rx = {};
> +
> +	if (idx)
> +		return;
> +
> +	tx->packets = 0;
> +	tx->bytes = 0;
> +	rtl8169_fetch_sw_stats(dev, &rx, tx);
> +}
> +
> +static void rtl8169_get_base_stats(struct net_device *dev,
> +				   struct netdev_queue_stats_rx *rx,
> +				   struct netdev_queue_stats_tx *tx)
> +{
> +	rx->packets = 0;
> +	rx->bytes = 0;
> +	tx->packets = 0;
> +	tx->bytes = 0;
> +}
> +
> +static const struct netdev_stat_ops rtl8169_stat_ops = {
> +	.get_queue_stats_rx	= rtl8169_get_queue_stats_rx,
> +	.get_queue_stats_tx	= rtl8169_get_queue_stats_tx,
> +	.get_base_stats		= rtl8169_get_base_stats,
> +};
> +
>  static void rtl8169_net_suspend(struct rtl8169_private *tp)
>  {
>  	netif_device_detach(tp->dev);
> @@ -5615,6 +5684,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  	dev->netdev_ops = &rtl_netdev_ops;
> +	dev->stat_ops = &rtl8169_stat_ops;
>  	tp = netdev_priv(dev);
>  	tp->dev = dev;
>  	tp->pci_dev = pdev;
> --
> 2.54.0
> 

The comment for struct netdev_stat_ops says:

> * Device drivers are encouraged to reset the per-queue statistics when
> * number of queues change. This is because the primary use case for
> * per-queue statistics is currently to detect traffic imbalance.

But the commit message says there's only one Tx/Rx queue. Then that makes
this patch nonsensical? What is this actually for?

- Eric

