Return-Path: <netdev+bounces-292595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFkhHuoBGGp+ZQgAu9opvQ
	(envelope-from <netdev+bounces-292595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:50:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38C5EEF3C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DEC33002939
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033A8383C87;
	Thu, 28 May 2026 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NkPSX99c"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87683383C84;
	Thu, 28 May 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957920; cv=fail; b=hhbZ8i9PaiaPN9lxPzRZ2nv/hwcrgDratA/EgLxYhpoH6hezUMcMRE1lO2iSymf8pG5z8erqy/hU2MayLPMUiUiBUGIj5WXYKND8IlB4JoIK7BgpfSTmkMRMp52Ye7Lq9oMfeNBbO6v522koD0QTcYsb6fOsb8yG/MzoGG2M5PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957920; c=relaxed/simple;
	bh=ixTD5mg/VHX4lpmK/P5Mt/Rn1qOaYj2Gdxq2pC8WvXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EyLsGQutP510oLNOidkqtylJsFFab9+Q26gRkLTN8gEWEjaVBtU80yV+KiIfFHDyGwRsM3uBF53q0dG9qRWn+3rax201vnKng43X6mRTV7ZhaI11prKWIYZFvoep4HhbZWkSeljHzRlbn5FXUyuC+GQ6OKwOVdPPyDYrLwS9Qmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NkPSX99c; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO57kXM++e+AGd6aUWR3Vp9w0doKOthc1mmWAcR/2gcMek2HBlOAbuujJ74IdwSN40ej8pfBBvXmstu/SpnkyPM0wG3NPiuyzUwfgqF/Tuh1Qyvb/Db5b78gActe6Viiw+d75nsgjAsz5Ai0c91ur6IPAvLJ8cGPGc5h7MfaOSbOh9VgyA8tG+8L8uDvmAuAxwP5rneg15CmnGmo/NWoq8C+0kgAI9tIuA9EZy+/8kKgfSxD6Z/g69/y8ig1p82e0Ud0B1iW07cZGmcP1vxCAo9NLNiQFCBHuC9Uk9elBEZ4wEkE387D4JTaiiLIvMzGreKYVzNUYTlBQtFHGz4rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcZXBvH25qbNxXPyVOzdYJnAy6bf0n950Tkpdq3K+0Y=;
 b=kTVpax3eUtIv1vEwqVBZN99sj5o2+qdBqrGLoKASnlhzIv+Hkj/AyVkOaGb3lv9qA3VHgrSPAIIJ9oha197NgXWV5IBwPiJiZ6r+SoGYA66A22+AIHhj6YNRz2rRDiLTt/jlzcHrmUKF4DCQRKJlsa2127w5WXuLwxbK6CVdG4lWdOquwDZE+EpxoGkRVoms3AJ9antBd4dj5eJvzcuLlYqDjutmZw0voHq/V4S5vAzRrfQpjjP3B2J02mHzTyV/rb52Imeirlmii4I5LuXxKC7T/QeizRFMGDdo2mgemhRpAMW0vRdztr7AQf+RSFbx9mxttvU1t5XWxpyvr3Z7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcZXBvH25qbNxXPyVOzdYJnAy6bf0n950Tkpdq3K+0Y=;
 b=NkPSX99ciSoWvGLyYZhLwknDidICmOf+CLgPsOTnIivYaADeOUpYtsdvolbmY3VK0i6rEBsAUWfPHI0pgzEmk24xviB/8mESbAno1vuLTN5tfrQBxHGL8peNnzso1GJs7RnuMykvor7hYFkBA4sPqR7OtiQ4I1lySmlpdl0FCew7M+0N3FZ0UdcgjUpz7kyp589z7uvGtGRK9X97DSKeKJb16bXWzLJ7oLJJjjklEFZAIbOn54uHGxGbDJrxWKGLiTdxGcmBotMiCTXCND3oS5QLBYgYpLlQCW0NPHE/XopVRE58VaiiRk5q3zzdYVI9QnPEHNTJIxU2cA16FxFFKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:45:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:45:12 +0000
Date: Thu, 28 May 2026 11:45:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv6: fix possible infinite loop in
 rt6_fill_node()
Message-ID: <20260528084502.GA592092@shredder>
References: <20260527053133.180695-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527053133.180695-1-jiayuan.chen@linux.dev>
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c23e36-9e09-4b65-23ba-08debc956e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AmmpT/6CyaReW9amr93jUrDVzqLGzbf64oT+RTlssouYqWoJ72eN9F6mM/pKJoHvktlmLTC/x/t2q27uhSl0uMbEIhDNIW8Uz9ylrtDEMA84CCaBflX1Vvra2efhcdvdBNQp3FwPT448z2Awhwt22B+y+s2Xz/xiwxjVnowLt8FpNaY3pHANw6bDUdQKUfIZ87EgprSEvKdB9PIlBcSO+pgAf1sJOlG5TlJnSKWunJlybhv4kEsGlEwRt4mEZvHZPBraFo7mjf6ys8uAlqvfhXCa9mdT/j3XZr8mXxHpsP9OE+KC6uEAlvQ/i8tsnF0dRzv7LHymfu14kqNPQi5AhqWovJiBvFv8Z9eOp6I7AkQTZSA9iylPIVKvfd/jI40H9Iyy5zoQT6rMacJl9/o7lsV/Lmn9aksmNNW3w/mWZhvEH07wr53zr6MJjpRUfyBe7dQMlFGkpSUlj2DDUpBvJvX7WYSn/itArnV/+HBv/mWhyWXLBjM6vBEG9EV1pcJOOJhlvKY6L/ZCxBFap4ovnEBSyWr9FbCMH0lKlPjw9uqtQvqVJt7wJglQuoultxw88+bUaBjJk6qzwAdcJnaRB+Cba0dq2EDRZJQFlEecKHpdTwWkhrpA+tA3hpWEL/Xd7JiMUytnTpaGqzyUhXEqDJ+Lnlne7z4T759nYFRdEg+CzwNboND+AfMs7bbC4bhf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00uTlB47Wy/AvOaVZiwjmStC2hPQySBZHJ9KWIm+qR2hHs0DjKVijIWf54Me?=
 =?us-ascii?Q?Ay1PzJHXmi3V5jiKCgoB2UswzkRMO4wSv3xardA+AIxrvLogmcqYdEouSoxm?=
 =?us-ascii?Q?jg0UIDErSYzv6evRRg8z3Ybxkk0D4WRpOMnE68yS0oMSLQzgkty6RndWUQqX?=
 =?us-ascii?Q?IkVkKYkWfQ/xGYwylR/qZGqWiDHAj1SUWg0lOqsfcmxur3wm9aXFoOY1gzS5?=
 =?us-ascii?Q?B0VPTpON/PrWOfdXSy82n8pRKqWo+I426KWYsJc6ksiRArEV2P4HWaYhR0yZ?=
 =?us-ascii?Q?/qk890/ICKtrVIgyXdQmbp68CyVQ6eQhPvZ5KsoIS4NGHpMnlJNwY8WSH7B5?=
 =?us-ascii?Q?9vngoxIifxh+0nc2JpmRVYEhMEKTynMTkOeECI81TcRdacbkWCo+mpsZL3ba?=
 =?us-ascii?Q?/0GMzpqUCbUKxeMQgWLC+qvLwp2xY/fTsRix8I5f1m5965pm8nVFs/ZkQvxC?=
 =?us-ascii?Q?nyHdodKx2UqYHDlTmgQHL29XDqjflaRVUFdcWQITwd9nGwh07DkR5WkMVTSh?=
 =?us-ascii?Q?q0FsJhHMMUqkKAF1PIdJc9NPGN2GXusA62/SbCFTBdMC8Q2octzdD8Y1mkoY?=
 =?us-ascii?Q?3vSlMvhwO+aoAK7AkaYCONccdLJ+RebFily80//jqHW3LG1J5lWfODp969mB?=
 =?us-ascii?Q?a3wgHWz367xXhxT5jtnF5aztvHFybWzaLHn+x6xo9eOhMfwQeCyOZdB4S8Qg?=
 =?us-ascii?Q?ssQorxU0P8+I3LIRelnxmrji7d36aq6lD29LfW0Djws9uNDJs/97AfSwCqrC?=
 =?us-ascii?Q?PkZDl/tensVRiyTdmUohQV971pQv3RXzANfv3QTwTSJ4klukbktbTZL+O0Ls?=
 =?us-ascii?Q?BXPqxnByiGvJbsqrCjPfCNKA0ayCop5+p7yaDVqKWJLGpx4bsjUjbipAYLDj?=
 =?us-ascii?Q?H/QheBMEckb8hEhiePCbhloCT5hudEdWH7aXALWA60lKEsPad6+HBu4gJTvJ?=
 =?us-ascii?Q?g5XIPx2/OSvviaZ6YHRHJ9jtP7RnmX74hqAElrB99i1c01fDrG5bB0o5LwJa?=
 =?us-ascii?Q?u/pvGttLfziAQ1MZs/AjX7jdvb4cxhB9flmBItGMTE6w01JwG0Xya4XkaWpQ?=
 =?us-ascii?Q?2IPTiyUDk5JshIN+zU/FB6Hf3/yCzq6hVvQP9icifSzeYXQmC596PupT4MNO?=
 =?us-ascii?Q?gHkYLNWV5aOA5Yb2Fxbrl8A4NwHlVVI/BwwRRqgXT/24WkXqNk2Ujg9PDhR+?=
 =?us-ascii?Q?1b5eGB5l/4xrMlz8z5f5lOaRDpW3+wmU/GpbkHQSH8AY3G4ywGviC4bl18S1?=
 =?us-ascii?Q?ywNc8y9YhN9SnZYSqvg+//MACOxrEeXUHfNVpJBD5yyDCvOxKuwyzaofDgSa?=
 =?us-ascii?Q?QJ/QXmBI9X+pv7uRYpHLQbkewXI28ACyNGDUTinLhw0d49jI5zJgxA94IKKY?=
 =?us-ascii?Q?30vEXbm6fUHho511wD5e+84vOzQSemTu1SeVhHtjVDA5QR4D6KSW1QmcK2mn?=
 =?us-ascii?Q?b6U+1/ZN53dfWQ4COQNOTdrSzrgZtHvpFy/pq0b86oe5jZ51C9o0GmNb8XVT?=
 =?us-ascii?Q?FrmMf6RUiwYKRXqAz93A4SJaHMn4F+tN11oPGci+YikSypR8lw0uzxE0LEe6?=
 =?us-ascii?Q?N71vqsVjXo4I8iK2+F1JGs4UHiFayPvwd3XAwfIqpkUT63CGfpvo8TjISoHH?=
 =?us-ascii?Q?NGGi0Y6NmKlyDkY0n+fto5wVZXov/o9oEm3YjlnHMUjrYsv/T3xWrWqTFxuW?=
 =?us-ascii?Q?Pd/iU0MimhLibuBiXaqAHN2jNupmNe3EDOKNToKcaBTHXJMUW/WaU+cLJCPl?=
 =?us-ascii?Q?vG8c3VUAMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c23e36-9e09-4b65-23ba-08debc956e7b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:45:12.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJL03osrzYITPvOhrgZNg6sPb+MAxGx+1UmqC6yCe5mG80nPHUPVrz18fjcRz/qlFWcZ+KyntwfM2lI4OAd50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D38C5EEF3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 01:31:30PM +0800, Jiayuan Chen wrote:
> Sashiko reported this issue [1]. Apply the same fix as
> commit f8d8ce1b515a ("ipv6: fix possible infinite loop in fib6_info_uses_dev()").
> 
> Writers holding tb6_lock can list_del_rcu(&rt->fib6_siblings)
> without waiting for RCU readers; rt->fib6_siblings.next then still
> points into the old ring and this softirq-side walker never reaches
> &rt->fib6_siblings, causing a CPU stall. fib6_purge_rt() always

s/fib6_purge_rt/fib6_del_route/ ?

> WRITE_ONCE()s rt->fib6_nsiblings to 0 before list_del_rcu(), so an
> inside-loop check is a reliable detach signal.
> 
> [1] https://sashiko.dev/#/patchset/20260526020227.4857-1-jiayuan.chen%40linux.dev
> 
> Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Sashiko points out two pre-existing issues:

1. Same issue in nft_fib6_info_nh_uses_dev(). Fixed by:
https://lore.kernel.org/all/20260526020227.4857-1-jiayuan.chen@linux.dev/

2. Missing nlmsg_{end, cancel}() following ip6mr_get_route(). Seems
valid, but completely unrelated.

