Return-Path: <netdev+bounces-269610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBS0Imw8vGlxvgIAu9opvQ
	(envelope-from <netdev+bounces-269610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:11:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E87A2D0A14
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264A53015D03
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C29397E76;
	Thu, 19 Mar 2026 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M48P4/Ig"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662A35CB89
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943903; cv=fail; b=ZFucjZ5joOE+jdXYMAWVr1UOuwUwbNKCcVJPGLTHBxXg+p39vaKKCQFqq97ZB9+bKRyClVrbXH7suGmTjnPy1ysUD7L+V+PrlTiz7VemoyYPggaPNL+/hpz5JH4brKypZqzGWHLbWq+F6jG/zAb5AfOtd6MbGgwBeMriXHxR/zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943903; c=relaxed/simple;
	bh=BqPvtgtCN9FaEZSDzga57qThX/fvMBhmrWmJzVt3trA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QpePh0AseTD5GT5X0QuNFc8oumol802NhEpEqpdNsSJIx+laTnnQWYTdnSzN86myJckNw0b/9Pb1ems+ODsTU9onJRX4VoGPYAeyaXvfimWmAcQVF1Ibh63RJwTJxdNQULiRS1miETkcEvDqBIz+RpxatettQl7aVGfbb0VMS84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M48P4/Ig; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9haWg8BW+aVwoYHCkk29B4bMRIIo+RUX0HgKeutsY5VSUYZ5DxzizfQnvb7P4RDR7LGkRLYESWJ0H/An6LOD9QZtrLlcEH24tQQJTRUgHQIUkwhP7uUK2I6Gx5Nm2xI6uP8G3tzkch8smST+iC5Q6Q71MJ7Qsofk6c2F+uQpvtw8U73D9Le1K/W38sA7qS7W6HKLLE2tchxf7ajH3Ra6VIXxOb78EiKHr0pgMX1nlKvCoe29R4Q724Uxv7p6Axk4ET4WGCz547B297/iyYMH6vunIlGu5sVNF4Tti6r2JYjwMiawPKlUsIYB3hL3BWV8X279JXZ0iJtBjgfZDXobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+veMhcBX3JJc1OShvvzzDXIn2K+y+fjqU6LeKa2/MVY=;
 b=HESn0TbOC1C22vy/hG32Mm9QUGCfIpSRkozCUzfcC8Bc5Qhk4gkMpKacWa15nyAPbNy09siKwBeRAHvN6CCpnfe2BEnmcJoIVyoe3FDmjGC39+IjbHbNEnbPGc4aW1ASkMQBrUOESsGqSqrsv04CZpdYu8L9aZR/uXecwPm4kAm0pnp3nWj8Vu4sqozF42zBJ6jOdtRvmfZz4iuATnDLOWUkk29PfF9O5j1zhukw9cHAHGzoDk4bdqMYDrfWcf0lywQNZVMLoMG+mMoAkAY6JGtmP5nCHsrqHJ8PVaAMh3Oj0iGoHp14xGSDDLS2a3pp5Msxs6p5Orpl6k2Xj2rLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+veMhcBX3JJc1OShvvzzDXIn2K+y+fjqU6LeKa2/MVY=;
 b=M48P4/Ig5BYEp+Wd1OQ9O8/Xr0b7f4f19wIhwQqu9kA3hgq5GyNDXlwDtFqB13mAPKDj00zBkl51XRigo4Gcyl7Pe9UmjhYZnmHqIA7J5giOiwQ4djI2CGERWi2mbaeRObgt3gGzSKOQMyazYG2sTVLE04p+qaFFOd2y9qvHMdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:11:37 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 18:11:37 +0000
Message-ID: <1d62b0c4-8156-4133-97e5-6b9890c81a6c@amd.com>
Date: Thu, 19 Mar 2026 11:11:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: fix persistent MAC address override on PF
To: mheib@redhat.com, netdev@vger.kernel.org
Cc: mohamed@pensando.io, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sln@onemain.com
References: <20260317170806.35390-1-mheib@redhat.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260317170806.35390-1-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2d46e8-2aab-4717-db3f-08de85e2f5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	UgPDzCpXCrgKv0z0Fl1v+6qU9mfW1+gMjq4vJrNh02gj8rcV6gXDxBjr1MQGjtfIO//7g+VmM6pU7ijsE90pvoIPBcQWBifW2uLMu2dYTAdXuwKN++U/qqxadIukMsZRnoiEowQIFIHJp1rqH3idiYpUu+CbEL6+xYVmbT/o5xsznIrHw/xYcWJN/Hcy0kwNNvIKU1U4hcNP7N6Vbzmm+qsaqwxOl7FzLhzNyQz9fH9GWLEawsUilkuorWniMov2J5PQFSYv2qx628s5NTIkMpUfjt9CVQB43IUW9CYvKR3Ka+nx13iUZuciNbke7dfDwt+BrpVToAlYrFiakpc/IqdX0YBWX79rRHDo5dDjMPLFy7C1rpz7DYgeRwMDtEir9GnxqlW2DC2sSpCsIVEFfZuLU4691/27jQ6ig0x8pJOAO9lIb+Gy2tGrL3htbaPCpADbgNKLlhHWvB6eEG8W80/p8y7wr7Db4C8ENceEBJ0CeGsRWC+F5IALvvSqNwx5ZAU6hxm8aiqz9BrENK7phyZMELwxxFRXU9faluAVOQY9GHzz8S/Fohdm3inp1buwmho5vrTDh8MCfE7u3W/8N7zQsu5EEjhjik6bOaaZOUkKN3DrN1GBiOyzKqtxwFEAKx2OwpE2M1Bt72FtzXwSxpmgptNbDeeJI8nyz1eW0UQRd5/iWD+JJ8XWPETB0i5iZzmZtDX6x4nSpFFZfgQE1dFnZkKXtfM5WCz1rwsKaiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlVMNmg1SmNtYmFwZ2YxSlB2Z2ZSL21oY1B0eUIzZ2EvdXdhYzhGQlNWQjVo?=
 =?utf-8?B?K3U2cnNjaW8yWFZNVmM5enBVUStGSnRzV3Z4d1g5cVNvbE1vK2tJcnh1YU8y?=
 =?utf-8?B?ZEtnRzhSbjk1R0szRmxCVTJ1L2JZd3ByMXpzcmZYdmZnMDJHWGxhb2FJSDdr?=
 =?utf-8?B?dWlQV1EwSEY5SENtMGs0aXE1SGRQNzNva3FSeUJNL01WNGI4UUVQdWNBSk5u?=
 =?utf-8?B?ZjlFNm1seGh6K1Bnd2FyN2VUZ2FkcEhZNkJZN3NkR0pHV2FsWk11d3hLWHBz?=
 =?utf-8?B?M01iSDYxSVZVNjIxbUprSEY5eFdxMHI2MTBhTHJFK0MzakdaWUNNUFpWQ0xz?=
 =?utf-8?B?UFlrSUZkUWZxRWlOR21Hc0V3cEhSNmVISVVQUk5vc3RXM2theEhjb1ZFSCt5?=
 =?utf-8?B?QWRNYXZTS0FQQWRrWmFPNU1wQ3NLNkNsTkt6RXV2VVVXY0FZUmpML1JiU28r?=
 =?utf-8?B?QkFtamI1bTEwMEFsT2c1TlcvVFNVUEhGblZnQ1lMdzBOdWh3ZVZDYWVJeW1a?=
 =?utf-8?B?RkhnaXlDemZBU0NVcTVPMjA3VXE4eEpTOU9VSVp6Q0x0MWN5d01GcjVJUVRJ?=
 =?utf-8?B?ay9ucDBkS1VmZlR4akNUTzl5eUNjSVRtZFpsV3lBL0krWHpoY3lHcFR5S2xM?=
 =?utf-8?B?dUhDcTZZTDI0WWlxMHV2TklTMjVzU3JTQnhneXd2Wi9YWFFUc3M5LzE0dXJK?=
 =?utf-8?B?MnlxUk9uYVorektpWFh2SlMxampMa1BDaXNqZVN1UTgvdzNLRFJ5MVBNY2RH?=
 =?utf-8?B?RGs5ZGdCN3Rta214ekVTNUE1bmxCa2RwWVpuNGxFcE54N1ZYOFpTN0w0QzlB?=
 =?utf-8?B?bW9EeG05WjYveVdXTXcyUGVhTU4vTHd5dEhPZmVyM2FnQUJOZmFSSDRtcnJr?=
 =?utf-8?B?NktjcWFneWxKZE5wRTc1dWpFdC9Zc2lwb2c4S0tKWTUwTWdpZ3loemgrd29Y?=
 =?utf-8?B?YWE4UVdpd0ZUMUJ5cFd1WWwySElFcmRkMDlobVZmdmpnUjgxVG5LRjJ6ajBp?=
 =?utf-8?B?cGRTTkI4dGlLai9qOTF0eElycFM5QlJ1SUNBOTluSHk0OGorQlI1cTlGZmo1?=
 =?utf-8?B?cXJReTd6Y1U1b3lPTjgzMlZnOWtFK3pybyt1d2pFQ0NMTTl6VG5YcXMzck1K?=
 =?utf-8?B?MEN1RFpvNmtVczhsa2ZBRzkxVlBOT2Y0Y2tQdWNVRGdjVzNZZEZ6eVhDa2dS?=
 =?utf-8?B?ZUhwMTVCbEt0RzlHWURpTFVSNjJySmVyRm1UYXdVc3BpNzZjQURpTkZYTTFU?=
 =?utf-8?B?dzN2UE1Xdlp6WS9uaTFOWE9hRjNEYkZ2VGsyLzhYZU9YVDl0V2VwME9ReHVh?=
 =?utf-8?B?NG1FbVZnb01QZHFSZkNZR203RU94WGtibitUblEramJmY1p4MFAyZFZKcWxp?=
 =?utf-8?B?WVBVYlJzdExBWGlDZFdESmNzS000ZDJBU1pyYUdCYURsdTdOZ1NFNDdZL2NK?=
 =?utf-8?B?TmdEWkN0MVJmcTd0eWNPeDVNeENLVzNEVHptR01OVGhDY25hUXJJczFTeDh2?=
 =?utf-8?B?VDE4RVZoZ3QyenpNY3piUng0THhtRXpqLzZnVHZFWUFmaDNORDQrZ2VHV1dt?=
 =?utf-8?B?YURDRThkOGpMNlphcjZMemk1V1pDYXdyR2Z0L1pET3hSTzB2SVlBVllUZk9G?=
 =?utf-8?B?eXRMVjNLRjEzK1A3RzgwMzBXQTVERldkM0ZsUm1iYlJLcFlQUy9xQ3QwWDZK?=
 =?utf-8?B?aGRMKytOUUJ3bXdZT3V4QS9KZFo2ejU0N3o0dVJyWEtNbUw5Qk5DYkNKYWFx?=
 =?utf-8?B?OXlseFNucHBjbzRvcFdYL2lFa0hoa1M3ZFdyOXo2cmM5M08xSFpXRmEvNzRU?=
 =?utf-8?B?ZHk0Nm9tRE93dXZZS2pIbGtqTE12UU16eWdlNWczakJhM2ZPQUpjUllpV3lZ?=
 =?utf-8?B?YnNKcStQZTR3WkZSMnZaOUYyS0xnR2tvYmo5ZmlWL0FnZ20xWWNxRlhFNEpE?=
 =?utf-8?B?MnQyWkY5STJ3SWxVUE1GUWM3eDU2Y3NzSW5QeXRJNi9vM3VpSVVxcG5ka0ZR?=
 =?utf-8?B?enpPMzFHNkl3RGZSWXl1QmhsSkZuemZwRUwrbDZFYUxpV1RXVG1KUWw5Wlh2?=
 =?utf-8?B?RVFxV0owNFNoNmlmYStEMnk5bmhXbmNoeFNZNDRBUE8xVnlaNndNdW9Pb2dw?=
 =?utf-8?B?dWlHSWR1ZzNhbHFHbnlmNjhocXJObTdXczRYVTMrUHQ1L1FOcEl5OFliamRl?=
 =?utf-8?B?cVFaOS9EcStZTkJTai9Xd2xGVEFMcWZ2WnZvYk9pUnYvWExMOUd0RkNJTE9C?=
 =?utf-8?B?NjFqZXcyQ3dkL1JEV1gvQmg4eFdHWWtkcG9uc21OYU1oRWppei83NU9jSFh5?=
 =?utf-8?B?aHlXSk9mcVBVTjd2Q0JHZDUvS1hWV2dmQ0V6NncwL2xTMUswSjNpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2d46e8-2aab-4717-db3f-08de85e2f5d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:11:37.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +k0UXzb5SwuqHTYrcQG59gjXO2Kxn4Ado+wiXCwHomMgI2fv2Bd778bBW87/aQWxXNJRw4xDgWug8zHXhpaWCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-269610-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 0E87A2D0A14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 10:08 AM, mheib@redhat.com wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The use of IONIC_CMD_LIF_SETATTR in the MAC address update path causes
> the ionic firmware to update the LIF's identity in its persistent state.
> Since the firmware state is maintained across host warm boots and driver
> reloads, any MAC change on the Physical Function (PF) becomes "sticky.
>
> This is problematic because it causes ethtool -P to report the
> user-configured MAC as the permanent factory address, which breaks
> system management tools that rely on a stable hardware identity.
>
> While Virtual Functions (VFs) need this hardware-level programming to
> properly handle MAC assignments in guest environments, the PF should
> maintain standard transient behavior. This patch gates the
> ionic_program_mac call using is_virtfn so that PF MAC changes remain
> local to the netdev filters and do not overwrite the firmware's
> permanent identity block.
>
> Fixes: 19058be7c48c ("ionic: VF initial random MAC address if no assigned mac")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 8d040e611d5a..637e635bbf03 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -1719,13 +1719,18 @@ static int ionic_set_mac_address(struct net_device *netdev, void *sa)
>          if (ether_addr_equal(netdev->dev_addr, mac))
>                  return 0;
>
> -       err = ionic_program_mac(lif, mac);
> -       if (err < 0)
> -               return err;
> +       /* Only program macs for virtual functions to avoid losing the permanent
> +        * Mac across warm reset/reboot.
> +        */
> +       if (lif->ionic->pdev->is_virtfn) {
> +               err = ionic_program_mac(lif, mac);
> +               if (err < 0)
> +                       return err;
>
> -       if (err > 0)
> -               netdev_dbg(netdev, "%s: SET and GET ATTR Mac are not equal-due to old FW running\n",
> -                          __func__);
> +               if (err > 0)
> +                       netdev_dbg(netdev, "%s: SET and GET ATTR Mac are not equal-due to old FW running\n",
> +                                  __func__);
> +       }

LGTM. Thanks for the fix!

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Brett

>
>          err = eth_prepare_mac_addr_change(netdev, addr);
>          if (err)
> --
> 2.53.0
>


