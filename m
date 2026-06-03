Return-Path: <netdev+bounces-294672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cLXbIXPfH2o8rgAAu9opvQ
	(envelope-from <netdev+bounces-294672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C863576D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:01:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=t3a+0p9f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294672-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294672-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3DBE3009015
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A19403EA2;
	Wed,  3 Jun 2026 08:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB0407569
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:00:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473639; cv=fail; b=e+kO/efeWw7AbJ82Y4eH0v9ZKqAHU/kf7bW/OuwVo69mxK+L0T62NqTvSEzycL5c88OX2s9gJKwKJMRYJEcsDOyZ8HXjZJmJ8kYBTUXlFxCWUdvgPYmUL16MmbHHdnbWJjaVVV4ig0NAesLMGZ/zbsaR7YH6uyBAI/V7xfZ7ovI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473639; c=relaxed/simple;
	bh=9VUEhwB9dmuQW7mtm2n5RiTS41vzPux5zK64BxvyKt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fw431W6EJs1bE76p9XcbRLYMzD3h7eOhD6FTS8gfu3iihWczrg+yBlgMprnqeyD19tN6qBq4NNLJ0ufo8QGnFEx/gtoj8BdEkK6n0OlqlcDEQZ9iU7Mfxts5T3VeO420D48IS2JhkjTgo4NsoYUgDyiR7VxdkriutEjBdcsgCws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t3a+0p9f; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtWXgASZ7P/6BSRZTqRglk5n7F+YmOXe5I4Bc96gGnaAkiRGTN4nWbp67dq76PPfb0sBM48cyYfWUxO0kpJgFQznSPXYz69fIhxbuTi7linIVbPbpOVZZST85uacSw6jJ03CovcoIE5yl/BBJYf95TtBbSqkD5WGreMHs1Z/XlS4mYa4AJBHANgmHz1BVCCb2rcUHBm4545h+PfstVF6xdh6icyBQkNd2U+xk6wQyq6Nz1AMl7sb4Lo4oSeb4BWkUzhsDv9/9WSs4vtcoEcaj7gZZOla8ASY3+o2zgRIa/YPG7D1rSXR8RDjEj2vnOdxI2cs+LZj0GWh3HJHqeiQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VUEhwB9dmuQW7mtm2n5RiTS41vzPux5zK64BxvyKt0=;
 b=B7jXcQg5rYG8sn6GEsVmbPyAAQ/nIndhvE/MBrxQoFgIPADYedTaVEbU+PW0a+hkFjQ96Ecs7OdMS782orFVVHZq218BksTBaWjNFV/oRQiMDb7EdLk8BHe5VIBUUL0V3tHrwG8ExbZT3v3+TCwXDKH0XX7jQA47fZWA9ogK8lgRZfsodyo/6srqT5tlgvarXLIfX6H8LxJcbYePvY43PL0UqXK8jrMaoHpxd4f9HsCYs0u+wbIVHU8zAqNMuxYuCZzjYaGs6PLRbObxJFve9bg59xZ1x8UxahzmK0NiT7tMsXVVrT6v/CIpQRPhCHphUVQiDO8j/56NtbKTvW/Xug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VUEhwB9dmuQW7mtm2n5RiTS41vzPux5zK64BxvyKt0=;
 b=t3a+0p9fpiQCFWUDZ9n42zi2Vo08+6+XN4wtbSaTje5ooknBVK8XO1MkAQ0pPpt0giqpcFad8YyWuV1NU2N46i87OAdQDgBLFPGqqizfxP+nU/9lW9ynYtiOP2afnoTp2l4sIprNllcurhliE73zEl4cw32KZzvSnPODU+FEbqaQIxN9db2+ouHdV83YH5ag02+MWUgiGAX8bnrGi1yvC9E0whL6GsyzsSBH+qg1jsPVuXwZMXhF73ZBYj+SOfbTBI/1tSirLUHLc77t2K8q/QMb1TWASYsO44caGHJAkla0tf9Wk5fNdsAbTy68xSr2+33s25RsCMwA0CsRoAm80Q==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 08:00:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:00:33 +0000
Date: Wed, 3 Jun 2026 11:00:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>, netdev@vger.kernel.org,
	yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org,
	Chris Adams <linux@cmadams.net>,
	David Gibson <david@gibson.dropbear.id.au>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
Message-ID: <20260603080023.GA575206@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
 <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
 <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
 <eba11df5-3ae6-4bc4-bbe7-be358a0d4717@leemhuis.info>
 <ee2b92e5-6d95-4c36-9fa8-6cd2a1572556@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2b92e5-6d95-4c36-9fa8-6cd2a1572556@suse.de>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 52814d34-7af8-4bd3-4cc1-08dec1463023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	yISLtu40VavjS2tGOFNbLP2g4l9OGxlvocGFSyMSti3UPMg5JMN8sdY7lXuOciwTvNVsxynYyPk7+pqnNJMSSu4SALphmF3u3qQgL8ZNWUAjcME7fXdYasLF6qduVMQJqn2R36DLVcgh4QK3GHbMHRJJNllbUU/nVs/drEFmIcEl1MzTx3d8GhrQXOPCsvvBujtAhbe8SUVP1Yxqa0Z05IXVdx/pqaW5s70+JfFTDwtENR8z1o6VsH22Ux51+WGdL+dy4RCaGOhP76vlPgRrGQao6l+5lrYZOCcMY4HoA3gr6ccJNxUQh2DpCqV0kxFIaPA6TUIamEryPNf00Xy/hHjgMd9xMVdudYrZ9SQbiSmZsTpj0OYgW3oTq9WNAXAjuEQN4z8Fts/eGTZo9EO26gfLnEK0fZTzLWXeni86OPzCUgNvdQMCwHRQwOkRF8YYhfN+Rs66VRmAzlfwwb+mMw/+YoiO4yCnaHNZI/K43RvUkMD5XbMykKDzWxHls9bk2Aifp+3px48xahs6oskHx1EgyewECgukazGTaPK/h+BsMv1kSj0sq7r2A+K0NiYVeedFHkGHBvB7ZzSaWiCU4gJfeevTaz92wcUIIskf0RUPfGUW7KGIDoBgTMuQg3CfR4QatdOVisqTD5ayi71RtBZYUB9S2cV1hbJ/MjmbeqgPgezqMW12+p4/7Y3XUzyI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfTg6Y5ryefYH09yOIwnaRxHJAB6YIYNFFiMRJ6fh6heBzfimofVwb96N6EA?=
 =?us-ascii?Q?Fq+5rraIpwS1q735hjI/tUSWhUfATfI8XMSc2YwhND1p4LyTvY1XFMmprs7M?=
 =?us-ascii?Q?E2zA5ETzFkFbPLUFRXHQMUFXIe7o4pRSeoNYP54f/27+/yj4KLGxmvay2lMQ?=
 =?us-ascii?Q?ue7MfQvM3m9BVWW3pNX8hrVy+CUS20mdfw1SfiO/AQBQV6Blcli16w20ZSM/?=
 =?us-ascii?Q?oYEgRt6gDYJ2PyvvBjW/2qKRdd0ssYTFCtwj1k6imvs4hu4PGXBB/y46GNvJ?=
 =?us-ascii?Q?Y0KJkTwLS3fLoxmuu7t62nnefWIzisweW7uueV1PtGmlnS3Aj6m50SO+rtwo?=
 =?us-ascii?Q?OjsU9djAynP4PLk+s96Sq69IgONl/uUOUnvbLYu2ZS8gsQs0P/46Ub8n5JSK?=
 =?us-ascii?Q?im6a4c5njRtN6KTXUdRJMQtdYJOfyNzy9gVt0GKZ7mhUJchnoYoOYRxpTxDK?=
 =?us-ascii?Q?/mmbKglBT4rBSxvlDYAvSg7zgvF2/ILfQZHCNNFbcPRAIg9FIDmjSsLq5sdG?=
 =?us-ascii?Q?JnkgnClGBocVEBVEp19WlywHpwAxml8RGsvD4El8z1v+yefnjrY4ASl3E25t?=
 =?us-ascii?Q?vb80bAzb7v4dtPp7LLhIgeaRV3TkAUIyNLOiUOwK0xmKkReyw9GgZhJMg/NQ?=
 =?us-ascii?Q?E99P4ksQggxdrYJbaCOlxoTcTGilELCiP9U7nME2eafWy4dc1ZCWOLaJ871E?=
 =?us-ascii?Q?+/Pe6K+r9C04ATfZtOiHJa9SMR2xoxMsoFgca9LF/o3L96c7ZqhCeJIRDUxP?=
 =?us-ascii?Q?glquAPwZtqxYty3q2fQqWkxcNqfrIsUOVFBJ2loB2KhujwNA//lUDMQZ2Ejc?=
 =?us-ascii?Q?G0ZTRJOfCjHWC6Ye2yhP9aYatNeHEOBEpyrgrfEmMPE9HCgt+JcO00ImTeer?=
 =?us-ascii?Q?ydmFmul9/jDFcQEZAOYGIOyog0T0cmLnCuzULkPi/5omDf0jUhgb+Z0HuyhH?=
 =?us-ascii?Q?JKhB1eFTka1K0dMcAa94+fcwkAEHjvpxMT5fscs2DDJKg/MV/biF3St36UCu?=
 =?us-ascii?Q?DQQors9tPOTQrYGShCVaBGjsOvztqQjjR2A4BT3GC+JjrwNSXzYxnmc9ppBT?=
 =?us-ascii?Q?hQBos5tQtSEZwTwCBdmIQ/WCKCg4HexaucRkbXmVw1b3+lsE6gDwqGK7Mxw/?=
 =?us-ascii?Q?bpSbHC2i08YaKL1CxssyItxUMuAKF831HnfcKFGCjE6CNgHxbsfUaJe4Yahx?=
 =?us-ascii?Q?gZabUc8HcwQwIyj7LY2e326jtjLFgv46RTRUgDSrj/kcdOQfotfqV5mk1XiV?=
 =?us-ascii?Q?X/AAUnpQLLAgvva/lCYsPihkxoMYTczJjynw0VTKWifDBdOg+QsMX8MuiY6Z?=
 =?us-ascii?Q?r3gxdz15tDS7pR80b8nTCTF8eImexkKo3500R0SBaTftGJEuT5SYhQraooXz?=
 =?us-ascii?Q?VCZRF9e2ey/OzRjePd4cqLJ9Xg+Swtvmg0CWAr+tpjE2BIawizYAXVlsXvTD?=
 =?us-ascii?Q?CVgNbWaj5Lkvy7R48qwv1oF0Klqsce7ruIBU25yJ9OS5ZnEdJZ29fpMWYSql?=
 =?us-ascii?Q?haYfaFwr8RVPPejFIB77w9csKugo35mhHC1qUEszoCKW9MaXnRwYyY632a4f?=
 =?us-ascii?Q?ODSSN6HMXXmIDdLiHS5GrzAUocWsva9zLaFAADcWDpysnK3FDs+PS+KRyOnI?=
 =?us-ascii?Q?NmQAQOwtI8b1ttqqbHNryKsVOhGZtubMjtBTVNXzS0+EhC9jWrX+4D6CeIk/?=
 =?us-ascii?Q?K3cICLA+ZZpsfKwfDyzkHylWUT+Zr0fJR/2onxJWs62bM6po?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52814d34-7af8-4bd3-4cc1-08dec1463023
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:00:33.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dW/3m453y5YKSB+if21JzjGAqwdvKtcTlC6XFc66pNQ3KrKPa6ySdGVgAMOmQfwNM6slADj1fYEwZtnvTmNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294672-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:regressions@leemhuis.info,m:ihuguet@redhat.com,m:matttbe@kernel.org,m:sbrivio@redhat.com,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:david@gibson.dropbear.id.au,m:bgalvani@redhat.com,m:andrew@lunn.ch,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[leemhuis.info,redhat.com,kernel.org,vger.kernel.org,gmail.com,google.com,davemloft.net,cmadams.net,gibson.dropbear.id.au,lunn.ch,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,shredder:mid,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE6C863576D

On Wed, Jun 03, 2026 at 09:29:55AM +0200, Fernando Fernandez Mancera wrote:
> We should document that the order matters, no that it is "random" because it
> isn't.

Did you consider writing a kernel selftest for this? Unlikely that the
order will change again when we are explicitly testing for a certain
order.

