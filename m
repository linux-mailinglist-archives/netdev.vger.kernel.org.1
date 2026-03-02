Return-Path: <netdev+bounces-262658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGCsNIaUpWnXEAYAu9opvQ
	(envelope-from <netdev+bounces-262658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:45:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813001DA077
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E7B3004622
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E663CC9EC;
	Mon,  2 Mar 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mH4S8c8/"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43143379EFC;
	Mon,  2 Mar 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458720; cv=fail; b=kRCs+mUIaakkk2r9C+QoUuNORsYTxFEvytQf56Bts3yXw2V6gVN2D37reJKu5EsR/Awif2ArVgXBHudKh7muvWWfycRHgCLz/qQUgRfDeQZx56OuTuVp9dSh/FSb17SyisNl3HFeLOZ6LH8NTYugv6IHOUAZId3VPoekGekP/kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458720; c=relaxed/simple;
	bh=kQVKSw+5SCiKOuEa95p6m3wy2OFZ8W2aJ+If2hKygyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5BqGnSSWkBdRuy3iTMNbm5JFuhbXctlI78JHUuhBsdnSRYfYSmNer6X8b0jCv+xoCcE0WAbnQDmmi9YAaGO7R3LOFPsG6msybKvOs/TcQiCw/P2c+mXAnI+Un4tEHYWKzH6ZNpL8eI4SvIEz+zDEbMmfvhyvC3vKcsNk8KptkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mH4S8c8/; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qylieMUS/nFWT6rBAGqSrlQLfdun46bkFV7Z+5wOw3p/PFKiXrmm80a0emRcsF7GK2B3w7BFRPPbvEntwupb6zpCHW5ZBsIsrM6ttLj4WFhymx2GYaJIQxMVehR+jhEXpzYArArWNKjyco19wg3FntlsHQyPfoFyuLvKBBlnC6Ztl7MXfvR/fqBNsNPOvc8cd4gbq9JtCvv3WWfWpn4LjJ5H3RVJvzPqru1g/jJYwbYVFupnez83D8pVAksUgr2v0jTku++OWQLCXNknA9yVQ1PlhAfQRGiiFmi4iuv7+pM4K2fSzI+W36Mfok5DJQ5Xa9b8MJJpspv3WdHrKSQh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXGHIEmmHpRsNzwNPW+fq6dyu62m37Vj2tPHnmzcpqk=;
 b=gRt9RpBQU6mGl5pBOvnB+BeSsmBKCU+P/r8tumd8qdIzvuDKL5XZjL/qpCSWONCnRRatvxMhOV62FiO7eJpUI4Njsq9nAEQSciXj10Rh6Gc9kqW4suBRvx/5VrtmxVkRAxlLaap4DGOpjMiHsHNYy20dx7gsXbwrFyeXLTDd4jkYcUavuv0g9VePPEQc3zcopq0Rb1X8BIiacwcIjCFBkfQ13xmlCIl/wwT10wQ4dDH/LkLnBo08RPSN9hHDzkvRkY4uXc2Pmt7hrNLRwiVlME15fyNS6omqq+HotBGmsnsC7vzJDz9lGl1s9Kl09gE7Tq3dS9zW4fZe10BJYuw1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXGHIEmmHpRsNzwNPW+fq6dyu62m37Vj2tPHnmzcpqk=;
 b=mH4S8c8/8b7elTBN58zK/dfSPJUy2ImNNE3sBk3EaSwMWGcX3ug7TntjXnZA75CNqlhfGB7FNYbXaMzcODwso1ZrUEmXaTLesAm4Oq5K4RZQHjD3HKvW7DpN8UBepVKYu0BpNEp6kWdStNL1IPDW5otwa8ajMuKxYAi+/U8nk5+wH0dcKDeLBL3FBrPqU7ItEfARi6HQmFlcyIXYCTZ2oKGJ9CVaAd/jFRR+lRz/eb7CyTvV4zHRP1bE1Klh6A92OOikTDkNe1C3+NbXQM/K+dPyIiSPishO0wi7yY39xH+a99Mngwuyv0dw0vnRPmQT5qE0f6jGLbmF8BaXikpp7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:38:36 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 13:38:36 +0000
Date: Mon, 2 Mar 2026 15:38:26 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ipv6: fix panic when IPv4 route
 references loopback IPv6 nexthop
Message-ID: <20260302133826.GA918339@shredder>
References: <20260302051132.66314-1-jiayuan.chen@linux.dev>
 <20260302051132.66314-2-jiayuan.chen@linux.dev>
 <20260302082551.GA814377@shredder>
 <80cf6abc40af7f2d072bd9c55758849bb05bfa95@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80cf6abc40af7f2d072bd9c55758849bb05bfa95@linux.dev>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: ba45c4fe-ec84-4b2a-2229-08de786100f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	KaWF23UAQcwK40HwfoXrcuS5CnoVv6iecRgYgRVmtXfHIFkrGx8RePyjEPWCn8W3Q90R5JEqy1lPfb0ILbW13zljWs1P4lsdBiqTEPWXbJVLdSh9w/Ijv5YZD4Nl1JI97EfeSn/q0DT0eB7YrCF0sj1penqaup9LMpnm72Hg50ZL2f117OLORQLpiCv4O5csNbul5bBYmYK8W5HocvCkN540jRikwQV4y+az5Di7l9BJ6KSG7WxUaNMpW0nJauWxKfL0J2GGFY2aDftnWSIU4hnCdaIyA17fFWvWUhoS2UtuEcb8EHHfcc+kLORgKZv0tTr6yHjwncMfZmp4UxOQIaiRtyR91x6Rqznlk/HR3KrPUZmHE4eNPKXSq2bwYysR36otcRMEvu8k1AujPH0bPDMGnbfhwlu/2er30oVYepkTze7HwT0Ygbf5oJjsKWwpMlKSTXmHKIv2IHvOxjV22Z0ijglWwe7qgNURwmN+qk96YRr7ShDON5nSla7FS+t2XHwXNRvi5ihE+9Bistb/PM6y9m17AIeVkhsf4GhHz5E5lH5Dc7G3IqGEUh/VC3cqyNm8qt7nL3jd8qNy+uVh8tTpsLHX6SsjR6t/oc4Ic4M968fdJ4twySe058MbVCaSp3u1N6ry5QbOTfeZquPspO2DPGWiwShzrJOdC/djgAQmGQ+yU9LNXT2r9rlK+micKBa8D5a8/RXL72WmMAhPwr5lRiHiY+9DnGO+maesM4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?82pi+kVWy97O2IuEbgX6WUEdoIBY7U2J/uULksk7N6pGjGLexFV/BPDF1+W3?=
 =?us-ascii?Q?YzZpu7D652q3gIkXcme/BgBUmt/WXWEOuvr0DsRM5j0RaFG9ij9+LIKb7ySH?=
 =?us-ascii?Q?ML3oJ1VQnX2l9JYWM9CD6m9M82xtBxNp6djyao+nZBYlJwVEfX06P+LrA0SY?=
 =?us-ascii?Q?em4XoMJ0lhHpUiVDD9eIHDOYhlwEKreg3u2q4y7gERGTiJB6Et43OeU/oqsP?=
 =?us-ascii?Q?kqkd1ALoyWQtZe3h3FR4T0T8ukdzpRHsTti3eNYEfpSQ3PxlI6SUJboZDKLf?=
 =?us-ascii?Q?h03t+9TabDQUxWIbb/ffTwgsPU72GROIfDSBVFVx+jwYYktk1j2DSrLclq2p?=
 =?us-ascii?Q?M3ipq8lI5qvlBaFu5VYZHAF+VPiX+4wkqfAZEKgDhU74zjJ5jgSJPzUe90gi?=
 =?us-ascii?Q?X6+FcT430TUV2LhFJEXn9Y6wlqRZWeWPcYV/rTrDxErqV2iFQI3h6YauXduZ?=
 =?us-ascii?Q?lQvrYDe5YNEXV2jxOlpmEI28aws5DFSPBmA0AzsYIWzRrq8aRI2/dTT7MlMm?=
 =?us-ascii?Q?U4107CtXtELVZnC52NOFmaKhZUsvUYNCt2IfsezfB1TZM2+pA0pX6QFDXjtT?=
 =?us-ascii?Q?3eWjKXpz9mXO/g/F+Dpi4EUpZUztFZQ/8VAyRbl6cfbJvzhNmwR0tw8fvZCa?=
 =?us-ascii?Q?EEb/Hckf/U+0rBbGQm9ltRQqTRbeWt0xUhV17YzRTSMzGF56C3x+ypzEy9AN?=
 =?us-ascii?Q?bW+iSSAOGQFOQfVlzcWsDRqHIWBfll2HKjRmgEBdkbRWxyhrIu6v4++tXAh9?=
 =?us-ascii?Q?L4GEjLrb/Qy64qMC16J+SLYf05prD7qp1onXSb4k6WZBvTegyYab1PcrG+oE?=
 =?us-ascii?Q?WnWa5HZGfA5+wwVIrOfB3giOchBYNKQnd5NYR+vY5ffmTSnl5xIeZMQOblI1?=
 =?us-ascii?Q?djFRSExz1b51BNbeFFLPodb/xVkBmdIsFEaLUOvnnT8eMaBBeV3D1LKjCSHJ?=
 =?us-ascii?Q?tL29aXS/SmWSN3vZsli8sZd6Sk440OZ84E2Eg2TwjWuMrPEhaXsqy4KoXwdi?=
 =?us-ascii?Q?Bo2zLi/do1vtf+aX7L3OGA3u/R5ANVPLf+4l+t2fQ9i33Sdl4Dw7jyNmIlDg?=
 =?us-ascii?Q?WixUB6coPoGqpXzpR7OlrSQGjtsxFOzezpKOYgHdt+74lmjlajKUIfR1DHIe?=
 =?us-ascii?Q?JUtOpt12MZO4f/v7zl7JVTmioGwEI0nMVTup9reqoccnPRpKLYjzNv2bopVv?=
 =?us-ascii?Q?2w5ENFZhRioheDD6mY2cL0JvyBaEnEfx2LwYgEZ76ehHCurA3oEVoQ2pIcXp?=
 =?us-ascii?Q?q+CdoMnRSjxzzfC4ECLIk0K7PETm+F7bPUP4U/JPUA9lDuvArpTA8de2sb0X?=
 =?us-ascii?Q?VD9HNongdi10viKEJI4N7ntpa5W4qie68V4vzwFNqqJp4YfttNhIUzwnjc7/?=
 =?us-ascii?Q?/rMic3/oC0AM0o3y/6z8cKKtPHjsHUlurfq12rmzpTS+mYDtiFWsoHNT3cGQ?=
 =?us-ascii?Q?PsKB4bYfjjpBvcx2JutfS2L3IKdGNRmPKy1MCVakD5Nou4EGvW1X+95VP18x?=
 =?us-ascii?Q?Yzoe2zDbWpuIuJoanW3PT5m8iNGmK5ru6QsCvk5bdWEg1gWeMhR2V6Uhmm1K?=
 =?us-ascii?Q?UrH1ogdgtjdb8JSKbwYDbrdT2u1t6Rn0Mh3O0d738PtaeikBcpzavA30dayP?=
 =?us-ascii?Q?yn9GgBW5xFd8vMNwLKRDcHrzfkrYZCzf1Sh64Q/a/lmBWvmB+nuojc2iHhhi?=
 =?us-ascii?Q?QdCu9G//8biR/LRPQTSGOtgPGpVwdxDOtgOJzJv/etuBIvNUSpjnXPJCU3BE?=
 =?us-ascii?Q?bCJQIo0Hgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba45c4fe-ec84-4b2a-2229-08de786100f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:38:35.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYRoXyrLQDQX5mSfjhYjQ/WXs0k5U5dgdvVZxaHXfneo4jTIr27H4UxurUSCVwAtOy2fqIBC8z3r/5IT98ysBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262658-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 813001DA077
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:07:34AM +0000, Jiayuan Chen wrote:
> Thanks, this is indeed the simplest fix.
> 
> Let me walk through each case to confirm my understanding:
> 
> Case 1: Explicit reject route (with RTF_REJECT)
> ip -6 route add unreachable 2001:db8:1::/64
> 
> cfg->fc_flags has RTF_REJECT before entering fib6_nh_init(), so the reject path is taken.
> fib_nh_common_init() is skipped, nhc_pcpu_rth_output is not allocated. This is fine since reject
> routes never need it.
> 
> 
> Case 2: Loopback implicit reject route (without RTF_REJECT)
> ip -6 route add 2001:db8::/32 dev lo
> 
> cfg->fc_flags does not have RTF_REJECT, so fib6_nh_init() takes the normal path and
> fib_nh_common_init() allocates nhc_pcpu_rth_output. Later, ip6_route_info_create() calls
> fib6_is_reject() and marks the route as RTF_REJECT.
> The allocated nhc_pcpu_rth_output is unused but harmless.
> 
> 
> Case 3: Standalone nexthop object (our bug scenario)
> ip -6 nexthop add id 100 dev lo
> 
> ip route add 172.20.20.0/24 nhid 100
> cfg->fc_flags does not have RTF_REJECT (nexthop objects never carry route attributes),
> so fib6_nh_init() takes the normal path and fib_nh_common_init() allocates nhc_pcpu_rth_output.
> This fixes the crash when an IPv4 route later references this nexthop.

Yes, that's my understanding as well.

FWIW, I ran the various FIB selftests with the diff that I suggested and
didn't see any issues.

