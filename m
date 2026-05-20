Return-Path: <netdev+bounces-290028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFoRH0L7DWrO5AUAu9opvQ
	(envelope-from <netdev+bounces-290028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F07595D1A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935B0346F50F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466E3F4DE7;
	Wed, 20 May 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YL9WDF6k"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EE3D75DA;
	Wed, 20 May 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297931; cv=fail; b=WxPZyMfetGf2O92HY9yYC6g3pQ25/Z7YeMY4U7Frye4/DTrPaa+YqL+WJkTWChR7gwOB4fgRx+OO9qZhKRm4bqFrDP8VatbQV0F8Xh692RQfAleAD5Wvs4dZNIh+jlK9V8TcZSh4/NTpVelv7gMxemcJbX3VuWynKmwil0o0hcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297931; c=relaxed/simple;
	bh=+ZADWFmz3lJ5EzVc7fqbrpAeyH35ONwPpaz4LjPiia8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SA8E42tgUevPiy3ktMGgsiob1cnYdBDmOnhWNfld6qyVVJVNc7FVB3cSMEJPO+JFFZ5SIbfI1Mpj6DizGQ3tqGNuh5XevxX/W5Gw3gnmOfvsEdyE5OaP4/yQklys/apSmZMCM9/EtkQXVtZUwQb2JEbk9Eot9tspBYwIn0ef4lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YL9WDF6k; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVa9kWgdcMDH3ThLGO5Hr6TsBljcnqlL6+XXBa+QyqbfPJ/PPaVuy+ybyfur8tXehB//Uw7rMsvNEfKy8AOcH38glJm7ZZNIAJcpQEwXMmswD2kUSXNHBxMG6KQs8sE96gG9ZGeaeaUGwzxNJcCVJueR4Fw3h73wfojPZHhj4hlOm7C1AafkIuRsC4SsxrTtVPQbnwz4Buxyau0QXyXxvl9RAO+DoLoXJzvsSqmK5SkMgoyLnywUyg/znBTAn4G37aIjEZ1yTKKZFFJX8t4UwQcxn4zFmYWJwKuLlj5p/yqHTLvvcoXCDnFHvoVI9VVDMS1panl5BzlZ8ifUgCUaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZADWFmz3lJ5EzVc7fqbrpAeyH35ONwPpaz4LjPiia8=;
 b=crfFUUoJa0TNr8jWLl3dOvFQDrA9oWmJFOrTPJhtXP2r6uIFa0S3uvwhPpIrDefKadRofDI3gluq208+Nf6sKBCVOvl8EZGR8KET0IbnrPMRsD+vGX3KT213nqdI849aLZYNtd9sFqOX7uzU/XcfJO48N2My9VJi6ASKBut3FXl32va/y6ksReuIKcvdleVDyauItWgGheFnRBWESLnBFrP3+BoYSdgSdXWPvYf4h42bSbIlsI4naLhV+y4OOy/B3ZWSsDIt75VrFJs5O4pDdXj+dsy8lLf30MYEqbzFwmA1x4z5sGI5DbTxEqEGNVf2XiCV6tGLwUDMz06S4eKJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZADWFmz3lJ5EzVc7fqbrpAeyH35ONwPpaz4LjPiia8=;
 b=YL9WDF6krAV7dTMJCSGu2Pqkn68TvVcJxps3cPqAPWEVIpjfs58iCI/BecFzGem5lRC5ImQz6GwRR94E3q9pTbvNvfOzp8RIGOhxskY75MgqYEG9gYmTPtNayLtGM5vyI63UGsZlFHJzxhrSgykuXaS378+P4l5Z1SwX1Qej39ITNkq1V8xQyhnc0SoCNtGJbKUZ5zguoBW62jCO62r1MI5qOJiXjiCgXuJTAysCS8ZyevmMNJ/zSRnmiXyEqJxkXW7rKsWjwh2KtUN+RGUu4jMrwS7HsNgqpZ7KHMOXF01QwcsW4vZ21SQA45RC4LkLAa4zKk9B3Z0RjX4SJgeaHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Wed, 20 May 2026 17:25:25 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 17:25:25 +0000
Message-ID: <e73d39a1-1ac2-49b0-8958-93d4f9d8ea3f@nvidia.com>
Date: Wed, 20 May 2026 10:25:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] vxlan: vnifilter: fix VNI add/update
 notifications
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Roopa Prabhu <roopa@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Chirag Shah <chirag@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260518165700.1975478-1-aroulin@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260518165700.1975478-1-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d242cca-6bfb-496f-b8d7-08deb694c7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Zk/j1PIaZDPF7PjUC/p+uvzfFHWO5ES98RrocxemUMKopBFAzZbelBTWSii2HyeFtSSYhWsHtNqWHroiIS7K0Vhvo5lqmJ5Da3CV9OvQrJzG5bJYlGqeYXkzny22L2vIqZegT//AwsYqddOAX/JriZD6/OcGhd3PKs519vKM0uOExPnfiLKZRFjeGELwG6EYGy86AhM0U2jU9c6wfHXZuUlIqSf58uEfBN3sut/PTSUWYt2JIxi8Ez5MQq75OmdxAV9WgQ2zw7yS+K8l3OrjoSRZFv+EiRYVCTBVNSh1HPpWIqMDna1Tq1FxRdbk6GNwOu9sB08AgVKJWC+6SQTIJ4mgnzLrxyunhkLrNDqMO2K1UQjWeszatkmZNebkwzAx/eEPRPvY5BrIYYSdWaKp7lv+F1utKfv2EM0bpjgaUifWREF4eRrEEhn31yEl/pFf/S7mLDC4/z7J9uvr74ixgbnwPKPlQ3omJxxhnVlXZ+8R6IZMeEB88Rgb9SrljvZ6TyFsQrP9bNDEQZLnKC+Yn8UaaGQm7EU8q5X/ksDoSYQ1a40WVxhlMG4d/+ISnA8UB1stfe1X57jvpm55DGVZnZVmfpPA6T9kIBvIRyY6TYBxsHdE8Hr4FeAF444BVCr2A2pJpKrFwhEXME+c0LypLc2wypXPdHuyFvHqvW0RC69jFVsw4Daf0n+9V3cA+Z0d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU5GOHZpUmJpZ2pmeGQ3bDlHT08waldUMGN6cVhoRDNVQXYrYktqQmZIOEt2?=
 =?utf-8?B?aUlkSHJYL3prenJrekRDbENJRVNOQ1BmNE1DQXcxSEMrcXdWQVNvSFNnSW1T?=
 =?utf-8?B?U01iYTJzeUJDRE5ZWWZxb1BBRkpzRVJwcm9Ca3hYL0V2Q2h6a254TlROZ3NT?=
 =?utf-8?B?Z1cxaHNTazFBRXcraW90K0dONmZHSkRJWWtZVk5wZCt6c29YUkZtMnIwaU95?=
 =?utf-8?B?aXo2YW1nSFJCYzlGOSswelpnVDk0STIzQ0YvZjV1bnNlUW5qN1pEMWNOWE1D?=
 =?utf-8?B?L09CYnlnMC9uWHZrcUhOQzZLSGVydWIwT1h5dG5pcTJ6UEkrUkxEUDdkOU4x?=
 =?utf-8?B?eGpLVFVVeDg3UnE5L29MczNFYUdGYXVPTEh5ZWh1akxvSUlLMmdNamNpMWlF?=
 =?utf-8?B?TExDQzhVT0xjV3RzbU1jUGlDenpPSk5FcWdRWk5ydmhydGF6clhKd3czU0tx?=
 =?utf-8?B?bHBKOXlyQUJIb1NjTmVyUkdSY01zVXUxZkZWc084ODZNU3U2R25wS0V5VFFJ?=
 =?utf-8?B?VXFjV2pObWpBY3REbHcreGs5bEZ5VlVXZng3Zm9lQjRNb0NjSG9DOWdZc1do?=
 =?utf-8?B?YndBV0xNbUdsblh4VU51QjV2dy9mRkF1Ri91S1NRcWV5RUtzZXM4dnVNbXp3?=
 =?utf-8?B?WHZOVnJoNTNjWU9qS3ltbFYrbUV3dTh3akR1SEwrT3h0UGJxbUIvelh3LzNO?=
 =?utf-8?B?RkZ5RnRMSmFBdUY0OU1RRyszaGxwaEhKSW1sL0ViTStlazVaZ2YxUWo3NlRF?=
 =?utf-8?B?ei9ySlBzN1g4RzBBWTFYUHJjZkFhdkpLb0VmMExNcXkzWi9aY1JvSXJFVFRK?=
 =?utf-8?B?cGdpK3lnM0lBa1F4bXBkeFo5RVkrS05FUVgyRmVrU2pNZEhVRHFpYzlwM2FH?=
 =?utf-8?B?WVYzN3ZaN3hiYk5yRWRDbFRCM0YxMmtRYUhkY1I5bjFtUDVaclpDbGRjM2tP?=
 =?utf-8?B?SEtrcWMzbU9vQVA2eTFjYXB6azZQNHNWdUdLVXZTM1BtRWlaUUt3V2NJSGxN?=
 =?utf-8?B?aXpPSFhlNkVjN29qWktPUEluMWtRMHpSbTg5NkM1MS9GTkVGdzRLTERzbTdw?=
 =?utf-8?B?YmMvV3FpWWpBQzlMemYzS01qSEtiSHFuTEhvWkRKODM4SDNaRm01eWNzd1dW?=
 =?utf-8?B?bjR4RTZtSXJPVkx3YXJWdGljWTRSaEFCeWpTZHp3VENWMDVYVzlIT1VJOFJF?=
 =?utf-8?B?ZFFySDdVSWpFRnFpZTlDZXFJTkVYbGJjSEFLTnBpQ0V5UWlrSnJyR3YyeTE3?=
 =?utf-8?B?eW52RGZRTk4xOGJXaGp3WWQ2bmE5OWNLRHF3UDBXQi9SZVJ0RVBjcHFldmw4?=
 =?utf-8?B?Q054RjNVcWhZWEQxVUE2MGFlOUxxa1J3c3BrVG5EazFiZlF1ZXdUb3RmdEtq?=
 =?utf-8?B?OFlzTXlId1Q1VUFvWC93YW0rY1lYNWNmWlcrQnhXdzVRRkxPSXZHbGlSK2hv?=
 =?utf-8?B?S2gxdVNsZ0ZJOFZOeFI2M29VSjRtKzhmd1IyODJHUDZZeGpleU9MWm1Rd0FX?=
 =?utf-8?B?djJpUUN4R3J3VTEyUTJQdjlkZ2dCcFNqcHZKZEVtckR4VzZSUEM4TE9LYkxZ?=
 =?utf-8?B?M2FCd3Qxd3dXV1lWMXZpYnJvNkVLZHlsenFlVUJaSVhnOFlteTFkN0pzNFVX?=
 =?utf-8?B?Zkx0SzA5d1krQ1hhQ1d1aE1OenRaVkI3MFdDUWdsMDd5Rnd3YlNuV1Ftekk3?=
 =?utf-8?B?ZXZzWS9ZOGpnbHEycnR2TjRBTWhwdGJsNEg0OXJuaFQxV3RMUFAybWR3UDl0?=
 =?utf-8?B?RUV3QjliSkZjVHVBVzN3K0diOVYxZW5XT2l2NkJFbG4xVjZjOXZWSTFSNWgv?=
 =?utf-8?B?ZUZjNE1aamZ3a29qcG9pMk5tbTdIaDhlVGtUWkdhNVZlbU9JY0RubGlxbFow?=
 =?utf-8?B?ZXQ3ZFRodnN6dy9hOVFkUU1ZM3YrT2hJak1lUlZVKzRrczdTN1l2RlU4dXdD?=
 =?utf-8?B?UWRpdXlNaHRFMWpVaitmSEFNNnN2U0tDYVk2blZ1VkhmYmQ4UVFnOWI3RWo3?=
 =?utf-8?B?eUNQek96NEIzdDBYR1F4d2Q2ZGQ3Q2hiemUrQklaU1VrV1dDNFFYa2lyZERV?=
 =?utf-8?B?YldFNmFNZ3pkZUZNUi9hdHpkV0dQWGpCSDIwS2VJc1VHY203dEdnQUxRdEV3?=
 =?utf-8?B?R0VNcmlzeXIzU0p2RWV5TjdhSklWU0V6MFZVMUhYUDcwcTF1eU13TGgybjl4?=
 =?utf-8?B?ZFJnSFNoQmJMY1Q5bE5Mb2VzSmlVQTV3eHdQOGgxdml3T1BCTG5ULzhIemxs?=
 =?utf-8?B?Sk5SbnlDSlZsSXlrVTlZQzJUQVJBYndBWXd5ZW5QejVEbSt0NGowc2N3bG9i?=
 =?utf-8?B?TGNMcFl4SnhyOTEvZVp1RndqVHE5di9DeDlBOWc4ajB3bVdadHM4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d242cca-6bfb-496f-b8d7-08deb694c7a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:25:25.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7l2m4THFU06/R+rPe1Q/pp6s1J5bidMeEO/vPrhSaTABIWR9Jl6or+VuKOIAXAlExFNMbDwVTgMrJlWHj6+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290028-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A5F07595D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 09:56, Andy Roulin wrote:
> When a vxlan device has vnifilter enabled, userspace observers

Please drop this series — I should have targeted net instead so the
fixes can be backported to stable. I'll resend against net shortly.

---
pw-bot: cr

