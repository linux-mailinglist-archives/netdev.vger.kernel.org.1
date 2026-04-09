Return-Path: <netdev+bounces-276937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULv7B/2E12mwPAgAu9opvQ
	(envelope-from <netdev+bounces-276937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA53C94AE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8059F301D681
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FB3BED0D;
	Thu,  9 Apr 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQUm/J80"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBF3B6371
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731945; cv=fail; b=TfDsStC3Gr9lrHjKaKJ8IBa9nob2iUL8tJr9sIHCowiR41dPyhDbD/t1daNY8gm/+Gg+452UcWZTc6aBuY19Gwaxg37vCmssHMXlUfoD18I4SBvnNn+AA5JegwnkTup0ghDcALSLR2GzKQuSH2WlPpjfVSYHMEx98gQJhMUnowY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731945; c=relaxed/simple;
	bh=hNJLaU6eSEkghujCaNrbUZr1HYBbPuSNfqs8ffIs7E8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHr0gEijR+Bp4FgjfoIm8N79sJMb0X/SCIQG0T2PrAtfZ5rp+URtUsLoBcRS6gWaX6wzQZ5EAbypkDuEiHNaqSklZRatiwDnHPzZLPwKWHSiIU/9+/kDGb41GBwR5s1acu6ieuZWAYPupZOFfhJX+u+R3wa+JjjQ++PSWLLvYW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQUm/J80; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8SYzxjWHRT9LdC+rLv2sdtydpAtzI8t7Orroe4uyYCk9EA617pG9jJxKnpHA4u9bPcN+Wuy9UHKrz18Aj1qXrarzogDp7IFQGKiVTvq2RO2I0q6YanAn+xVb1vLwqEIPjuxXo1+UwHTUVEbRjz+di59THILFLzEStsTEYDa11reRmKH+f9NVMneIpXm+uVsxKiVcWuzhChxoJR780iop6wyURN4aUWggTL9+bnB7pojk1/QTbrvO/JAHkb4cstLLfXijdpJaAFs9ueKTWHjaYpolzj2/wmbcIQQTeMOZkFJ/byGT8rsLKb37TYcuqjajMt3n1qwB27cz87gOgbddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kveNxWWiUNzK6rzu3W2DMKoMyBTV3tbrlqZikZutcA=;
 b=WIc8wRExU715upPM3hz9kZLRCLaaETlZUZclwLi9tOjI2421f2edGUtlG3VvoHw9l4bEM64kFpts0c38VyTJITiA414jE1huDF/qsTbgKozEz8ay294aLlNU0q9dpQg5rBwoF0NOEP4D0klBd9AkHfcswjaFoKjD7FH0kEzqUzb4qAxmZxsmE/j89K2I/xs2wxJAbUg3LWD7RnZ2h37y4uJzklkSA9SfEZjV48UaGAScyeaO04EpUI2gLXYIkRhmMmX7sznaJM1NtJBU0ePT2qJUbxhd9iq0wulwx8/frsqvOO6cL8EgRESEiKbtXEAZPW1/P1QhRmph0HrgRLriMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kveNxWWiUNzK6rzu3W2DMKoMyBTV3tbrlqZikZutcA=;
 b=AQUm/J80SsHBHUHKMTNaY791bFE3VpzO3MiUGeHC1Q3RiiDMTUfFhWM63EFjNd98wioalWko8l0TLXaiA4DBuelGSINJprCfJLsLwlUp8JBKf8m6ly+ybJ6z84T0JrIxDn2CvTWvnmygsVZQ4HgZlRw8jhvyBeUjvRK+eQ/PcUNaK4KHY5TYINrkTwtLy1F0BJgi6uUCq0xlm711SkLXS0GbhpTtWqeBd4jMDn1ksQvwp+grTKaSWhji2YwMtuJ3JMVm7TNMGvZ+mW9VXXbVbF96K/62HUlLrXtf8OYJlb6eeG5p48gD7hTyqP8Wg8cUqNLc6O2AxxO5ug4fmtyd8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:52:20 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 10:52:20 +0000
Message-ID: <2fced6d4-f243-4434-b122-c97db422e531@nvidia.com>
Date: Thu, 9 Apr 2026 13:52:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] gre: Count GRE packet drops
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>
References: <20260409090945.1542440-1-gal@nvidia.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260409090945.1542440-1-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: de294719-5363-450c-b769-08de962612a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LDty0Zjk+jXA0ktcWP3roJGeMlZu/zbwVkaCaR3bcHX/7TZJGFgx/++2liVn/MYUj/o68RIB/XjzKhm77MebMmIzH6aq5GauLKqcQ+Y9i1/roxwwpSmjvSP+4qY+rxTFQIBN/2q48YXHlfMGj9VwyRzNNLla8JtSwtsJT8tCL+jpZHUFw91KJG+BGlk3ScsPjF2GVxlWYgVMgMpxdOqVo6epiA1Ce/b24a43dVjUasSdbA4Ujy0VB2UUuQxD2+c4UfrevrM0fckaBBKkUM1RYekYoX5lV9fDwZIOUn+hn2MIKngaQP7dmAlH9IsrQLmtZGYjWpX34fAsEPqf9sHRZZBPQwU5G/lMkRBvePPrSyGM+0p//dNl8VtcRL5M9oRzRwUr3tS5z2538wokW/NYzTwvQ1BXzpxu05ozeR05wVvfaa3TTEDdizDmyyow7Hz1/aURB3gwEunSSER1g2SggjLkwRueuU2tA7nOxk7O0ZMNDcJ9zxgi1J9ljCzzurpXwbRFMQKqPbml2ZoDC+JPMqMskvpxw9pD8ZWJkSMp8lyFRM+R0hPQVezrbgMbvRSBkb1j49l5Kea4maRNwm2OgWxw654bB/Iy+Kl4hCENISFx+ifUK2840wALZj8VaYcLlZ0FwwgU+LyQPrV5ojs5fB+ogWzqnqcoq962VGsWM2iAzK3Cu7QiR1g3YhstgxiondZdaYuB/WM8w0nuN2TESnsQamiwOPWoJUosJNwlGw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTR4SmxLN1FJak45K2ZGQlBQWGRmeVFjRFl5U3YxcHNTalpMZlh3TlIzUGtK?=
 =?utf-8?B?M0JMNTIyL0FQeFVFWUpISkFFWTViQmNVMzUwcEtMam1vbkwzbEIyWG15NjNq?=
 =?utf-8?B?NHkxL3MyeENzVjEvaDlZZ2h3RkZ0M3R5b1JhTElQd2x0WXdtTUE1Ny9sNWtp?=
 =?utf-8?B?VXhMRTVGakZFMlIvbWR6eHNIWkVyUlBxSExLUVdyN1E3aUV6VGpqQ0MxK0Fi?=
 =?utf-8?B?NkRLZ2JleDNTdFpEd2cvdmx4QmZIeWw3cTVZblBzYnNxR0VnT2lHU1lSSHJo?=
 =?utf-8?B?NjFYQlh1eHFhblJZUStXdE9hbW1BK0JGenVWQ2xOMnRFbXcySmJiY28zTkwz?=
 =?utf-8?B?dk5ieC9UWXArWEZEYzdpekVsTHlNK25WWm5GcFVvSjQxWTg0UHNIcXRzSEZK?=
 =?utf-8?B?eFdaRmM4VDAzU1J6TEtqWGMwdDM1SE5NNEZsNkxmd2V4cGJzRVhtUzJkb2xu?=
 =?utf-8?B?ZEJCSUJIK2lzcmZQNGJYZWNMcUtPMkVHWHhwS1ViZzFLRzVnV2dONjhTa2dv?=
 =?utf-8?B?L3lHeGIxeWZMTnFiOTlmUk9kRFhLcml1Y1lHWFZEOGNlY1BmdDkvNTV2Mk9i?=
 =?utf-8?B?aG8wbWJzMTZYTTc5dDN2aFEyUU9HdFJGL0YyL0E2QmNUNnNxakRMQjJkS2xp?=
 =?utf-8?B?ZVlhUnRQUnRoN0gxa0wwTXRTSVVLZlhkNzFLYUZtNEtRVU1sQWpLb2gxckgz?=
 =?utf-8?B?Y3dxbkVZOFZLakJHMnRMdWRNSUhVU2hVY0s4VjZsU2RuMzN2ZFlXdGd4U2dO?=
 =?utf-8?B?S3hQOHZUMklTVncrY0JvRklEcnZBWWFtZ3FuWk5yaE5ra3hydmJVVGlIeHJ0?=
 =?utf-8?B?aHR4b0xBVHBvelZFb3lEWlhaT3VWaG5HTzVjMnIwQWJIdDdWdmZlcWwzdFZ5?=
 =?utf-8?B?WE9rd2ZreEdsdnVldy9KelNBMVg4eno4eGlMZlZ6dURNZTF4NWRscUN2QzBh?=
 =?utf-8?B?OHh5eERnK0RhaW5KdDFVY0ora0pYTlJCa2hYNk9CVUVmQzF2YmxLbEFzYzZE?=
 =?utf-8?B?WlBCWnJ5N1NWNnpIRmFqSG9tc1hwaUEvTkJXc0lvZE1BSS82OU1FUGpHdGln?=
 =?utf-8?B?a0lCZmlKaG5QWFRhVTRVZUdVa2dXL3lOejFOYUNRZGFRQXJtNlEzRVJTN00v?=
 =?utf-8?B?eHBEVFJ2ckQxZzlDOWNOYW45QkFNMTFKanhXaE9qQUtCSnJka3hmTmFMOU5K?=
 =?utf-8?B?eW8ySDlhWUhGQm9TWmNOdlIzOVh0OUJYZkQ3WWRVRHZKbUFCOEJHbXFHNFFv?=
 =?utf-8?B?TU5GTUdYb0E3aXF6MWNJMDBETTB2Sm4vTS9GakZLb2grMFVROC9tT05UVkNr?=
 =?utf-8?B?QmlVbllzaWdGMGZ0eGcyVTBsNFpTUGJYbGxNZ08xU3JZUUN4VUxqZEdwRHQ5?=
 =?utf-8?B?Sjd6RUdtVXB4L0h3NjFwOTI2dE4vdmttYytYZndodkppK3A0K0UvUmp4cytM?=
 =?utf-8?B?NWl6QmNXNXRPWHNkUnNuOGhWdG9QVldRVGF2RVl6Ulk4MG5HVnltVmtVaHpD?=
 =?utf-8?B?NTI3N3RLWWxzY1ByeC9HM2FNTG9KSlVWVnh4aDk5eWFOdlQ2S0tDWXZ3bmpv?=
 =?utf-8?B?SHNpY2dZUGJjdTlvNDNhb0diN05VOGJOOS9HWEVzN2hKOWRlZm9hTUdzajJB?=
 =?utf-8?B?N1lIa1pId0lhSjZSckhiRzRPUm51ZXJyT2V5ZFVUOTVWRDMwRUUrNDlwREZ6?=
 =?utf-8?B?ZWszamtWbnQ1OHpjSGE0RXJWSlJlL0RGb1VvSGIvc0I1aWRwb0pKMTdMUERG?=
 =?utf-8?B?ekpCWWF4ZEVDVkhRelZSMzBzYkk2SUNJVTVqZU9QRU8wUjdST01VVG5LalZ4?=
 =?utf-8?B?aEhlY29GWGhTTHFiV3lESkhUMTJWQWJnR3lNTTFTTng5SFdMZXlYNEg0OVd1?=
 =?utf-8?B?OXc4c3Z5UnNjMlc4UDJKODFPSGUxRUM2Tk5Zc2xXZnF4bFVYZEkzY3hMQll1?=
 =?utf-8?B?VStIMEVjZ3ZyeVp6M3lNQmw3aFg1SWVPRUhSVXhNbktiTVkxZFJrUURyMWZH?=
 =?utf-8?B?WGVxU2pKRys0dmdQYWFFZkJlUFhKUkQ4RmZ6VTZOUDBzUTJ0K2lUb3B5S3FY?=
 =?utf-8?B?ZnZlRkJzWSswRGg4S0RSNmE3UDlkN0pjbE1wZVhEMGVUdXY3NGp2L3FkU3h3?=
 =?utf-8?B?Wk8yY3lQeEV1aGpDV1hBTlZpWkZRRGFHck1pSmdueHVqMFBzVjZKWGk3c2Zk?=
 =?utf-8?B?TzNYVStKUmw4OWJiSVpabVJ6aFpJSWJNc2k2dWdsRTVCdmNBRTBTaGhTTzBt?=
 =?utf-8?B?Zlo5dWhOWW96QWsyNlJqNkVtV0Jna0htc2MzYVNFZFNRUnhtZXg3TXRMZ3Jw?=
 =?utf-8?Q?1keVu0K0ACEKs9tK9K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de294719-5363-450c-b769-08de962612a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:52:20.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLnfYfP8qh4h2gkRWGuwuLIS0TIA6Ochg5TM47sKqqidXjubJuuxxwOSRQfJm+Bt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276937-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 80DA53C94AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Addressing Sashiko's comments:
https://sashiko.dev/#/patchset/20260409090945.1542440-1-gal@nvidia.com

On 09/04/2026 12:09, Gal Pressman wrote:
> GRE is silently dropping packets without updating statistics.
> 
> In case of drop, increment rx_dropped counter to provide visibility into
> packet loss. For the case where no GRE protocol handler is registered,
> use rx_nohandler.
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  net/ipv4/gre_demux.c | 8 ++++++--
>  net/ipv4/ip_gre.c    | 1 +
>  net/ipv6/ip6_gre.c   | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
> index dafd68f3436a..96fd7dc6d82d 100644
> --- a/net/ipv4/gre_demux.c
> +++ b/net/ipv4/gre_demux.c
> @@ -159,14 +159,18 @@ static int gre_rcv(struct sk_buff *skb)
>  	rcu_read_lock();
>  	proto = rcu_dereference(gre_proto[ver]);
>  	if (!proto || !proto->handler)
> -		goto drop_unlock;
> +		goto drop_nohandler;
>  	ret = proto->handler(skb);
>  	rcu_read_unlock();
>  	return ret;
>  
> -drop_unlock:
> +drop_nohandler:
>  	rcu_read_unlock();
> +	dev_core_stats_rx_nohandler_inc(skb->dev);
> +	kfree_skb(skb);
> +	return NET_RX_DROP;
>  drop:
> +	dev_core_stats_rx_dropped_inc(skb->dev);

---
At this point in gre_rcv(), does skb->dev point to the underlying
ingress physical interface (e.g., eth0) rather than a GRE tunnel device?
If so, does incrementing the L2 physical device counters for an L4 protocol
error case pollute the physical interface metrics? Unconfigured
GRE traffic from the network might cause physical device drop counters to
spike, which could be misdiagnosed as hardware issues.
Would it be better to expose these via protocol-specific MIB counters or by
passing a specific drop reason to kfree_skb_reason()?
---

Yes, it points to the underlying device, and that makes sense IMO.

At this point, the packets are still not associated with any tunnel (it
might not even exist).

>  	kfree_skb(skb);
>  	return NET_RX_DROP;
>  }
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index dafcc0dcd77a..63fc8556b475 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -593,6 +593,7 @@ static int gre_rcv(struct sk_buff *skb)
>  out:
>  	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
>  drop:
> +	dev_core_stats_rx_dropped_inc(skb->dev);
>  	kfree_skb(skb);
>  	return 0;
>  }

---
Does this fully account for silent packet drops during decapsulation?

Looking at erspan_rcv() and ipgre_rcv() which are called earlier in this
function, if they fail internally (for example, if __iptunnel_pull_header()
fails), they free the skb and return PACKET_RCVD:
net/ipv4/ip_gre.c:erspan_rcv() {
    ...
    if (__iptunnel_pull_header(skb, len, htons(ETH_P_TEB), false, false)
< 0)
        goto drop;
    ...
drop:
    kfree_skb(skb);
    return PACKET_RCVD;
}
Since gre_rcv() checks for PACKET_RCVD and returns 0:
    if (erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
        return 0;
Does this bypass the newly added dev_core_stats_rx_dropped_inc() call under
the drop label entirely, leaving these packets silently dropped?
---

These are also silent drops, but these should be counted towards the
tunnel device, maybe as a separate patch.

