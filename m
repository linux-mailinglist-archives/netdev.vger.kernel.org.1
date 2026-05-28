Return-Path: <netdev+bounces-292596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ua5GJhsCGGryZQgAu9opvQ
	(envelope-from <netdev+bounces-292596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C425EEF60
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A2CC3009E03
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24AD38398F;
	Thu, 28 May 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JkuZm9HG"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE82383C87;
	Thu, 28 May 2026 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957935; cv=fail; b=kJlY7XkBfkvuhvU6R9vXgR8dZsb6b0wPe1MTWHk3s/u+p3MEB09GjFiMw0jTy8lkALD3uqTMrkrcIYqDlwds8ZeONyKgZBaq5MOU9GiYoLnEdXnO4p1RUx+tfoH/d8V0xx0/V37SCGnOM4hDzxUejK8J1QxdQrJipp82U6cXu4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957935; c=relaxed/simple;
	bh=+mZmjL9/gra2CsTBpcprVaMqN8wqGqOoCe3N4OAHxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ACJX3YqK9e10L1Z3PIVS9j5Soivbo4YG4y42J/tCZbjzlFQNmxshO/8cgMFRb6heujrJGRg56JWmWR84UXpNVvS4R2SyewkHA9569v0elIv3EkqZWGRcH1g656ab05dvvhaNn8wp3m/FsIvNkPfaG1yXTbbr7M4iQdQuyrRORuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JkuZm9HG; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmtUxtzRjI7N3WpGikoDApS/49g4/RdKpPF58beU112mfZKPLcxCfBNAj6GjK+tR/RxINpwrRozPBe0jazjolKSHbGdaP6ZeyHDRU86ZbwkPgeGyXLkdYCmRW3Dj2j5I63EVPo/zJX5MrUkktd2IotPsDx4SmJs/101GffWBron9JewhnwKbpHTMzXKUVcmjXRDyqMdgrOpaAGAcrLiddl4LjVWU+/1PUV6/062k+UvjqwFyMiF/MeIDE8GR/WSq4Vkj5aNf6G3/5tVWFoLx+5eXVtBpLcoGqbwl4isMfPnetLPXJEW+fhuUtwHQNKCIrfvbU5sDQUwWDzSLKrIikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIZCUWA6KKPHE5T/0+6lkiofVTGIf/fBlGkqHEspHB8=;
 b=hJumCL6Sx8ZDMn+OcdVXM5GP/l92C0hLi8DNBcxVcOkLMFerc//U/GCrTBHXVnOHu3PBQus5aozUlRPbTwdOIfbnQT3wDWk2OOzkmSuknS6xY3AV8LzMjt/UN6z4AL7V1w9lol4Uwy3XxrhwunXAHC6i5fj532RqG7bIWFveqapdtDHBSHRi+GI0WTvW+rFbBpclixUEZ8eAON+VBG45gIpgBi9aL2NBtZ3zJ5KOb2hDXW3ojvSUXypvgj6376NLFTqOQ5YIX99kVsb/3VW3jtgLKS4chqBHGoujQGKxZ5P2EW2bLg/2uYfFI47MDkaaoh0CVB7fF75GI21iWl3O1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIZCUWA6KKPHE5T/0+6lkiofVTGIf/fBlGkqHEspHB8=;
 b=JkuZm9HG/BAIHZF9P0sVGwsb94nY1Y/atFEQU/owvat0Qz/qBGpwzQIX9/2S4rmdi9YmO3ZJptDVCCY4pxYKOTxwSSLOnkfR0pLLF9BhdWg2ylySpa7PZ2EzAA+Y+2mOQjoWxaDb+sIGMY4dIUBb1suldxZ+P3e0TwR7+p/G7xugONtFeSSN/x2zFrCoorQSOyQEKckjd2Vg3tTD7rPO182jZtDnSY+nC/sSoeG0/4bLJXU/s/LwqIsxwWY4fPKbrPh3gamcidmsxLqrcwo2zzdohkY2CSNNPj9COuaaKbmGQO681ytJeh3JxxJI9BBI0rfzJXcUwdrbtrRDSm2l2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:45:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:45:30 +0000
Date: Thu, 28 May 2026 11:45:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] ipv6: fix possible infinite loop in
 fib6_select_path()
Message-ID: <20260528084518.GB592092@shredder>
References: <20260527053133.180695-1-jiayuan.chen@linux.dev>
 <20260527053133.180695-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527053133.180695-2-jiayuan.chen@linux.dev>
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f60357-adee-4100-538d-08debc95794a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VXhrJewf10lvlZyLPak26Agr0OePGk/oIeJHUfQNY7a9RU4tGo0TQ7p6L23tK4X1GGxRq9zG/L6vuO4cOjA0FCrK63tWfR/yl9FMERI8X7oTNLZZjptzmrvVI6JEzHBTYElugXVX5WMgBdJfmW5LmqtpzS2bEzlApWrdSh8wgednD/bCr8c7rr9Zzg761mhy3Z+Tyyd4TBY7jrb1nQC22VcdLFtrEu0hJ3yIIOIsjjw3Lt6AcCJX3Za+58YrWJVszzy23YgwmNDHgfojI+w35qYQ4dRWQBW3k1HLsCKcRdIFe2wE2zr2TlbDSgDZFn7uD5VKQ5e+DBoX2Q6qvBjMvV9hNCU8C6bRc1Hg0PWhzJHLhXFA+fU6bR0IXU0skXB59eDmwu31whWPfyZSnJvwzMAn3dY4PUGN63uPQ8gbm9ZQ1YId4//EmJDqN+quxBBFTqbtVKzMsSF+uqt+No3MfLJMCyEcmdX6hwgbP4jAOdNJn44bvgd+qAi26I4ghfATp+qUZpdBZktJw/bLXaakcRhX39v9J+i36UJVDQlZndieDfIvvvjFj/8TOwl1UMq+pmAkH4qjHG7+nRI19q5+akKCcD59v3XslhFoBBN6uZNlvHLbt2JHS2lmnbz3SJdDa6aRGxApbfMDTrYYq+2MqAKlQKBsbtdQsLwdYj5MVw3MZsMy+12otXR9+pPhCoW9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ojExeS+dudKLR3MijVnZqqqCpT6YjI4AQEKGjAzzAyLqhYydGXTHvNdZWU3B?=
 =?us-ascii?Q?6iOuAp5QtPTLw+zoVx7+cUZhe15u69t0XMlyY1U41J/Npiz9NN8nTzCKugDL?=
 =?us-ascii?Q?Vuwz9Hs5gI0esmESo1KwWrdVYMgYM2DX3NJnoxJaX6p1jImYDXX7wefoeOpZ?=
 =?us-ascii?Q?49x1eRmUEELWZ/DBEPYejyBRgFM2+xeF8rgQKpW18AaJ+D7xNLVI9OYiqruL?=
 =?us-ascii?Q?bHDAp7cY/S8CpxZCT6RCQjIGQE77FTNkSit/ss4IVjBYy1IMoeW6oa/YNYSY?=
 =?us-ascii?Q?7jzVGHJqM2USrhMzd4lZH2DAQ/k7Piq+pnhL9z07ZKzoyb/LYFXubbrRFocg?=
 =?us-ascii?Q?FHmLNi2mo/XLC2VAW2gurdl1fD/S6kyfIbuOCfLBMI2AisNs+rhY1uQMnBa4?=
 =?us-ascii?Q?D50eoXnHEGlVz8MUhKg0aQtj2Y6AB8wfadib43Jol9WL6MLNhTR6PXtRuxXy?=
 =?us-ascii?Q?GphbkH/6XO8dQWdgU+YFXyp3QMpHMfC6i9S5BLO6y+i0CqbsLLBWM4bQsVaI?=
 =?us-ascii?Q?80Pti3mpnu4jdaPtk2xkTF/S5Q4nUf/hRiDNiavCKgMHwXX0H0mHQP8FoHhj?=
 =?us-ascii?Q?4rRK/OFjEqiwiuizuvgwtTo/EldC1QxvnQL3J0ZzcRLeCoiSaY4RDXSYJzXB?=
 =?us-ascii?Q?DMYJE1Ih7C9f2HIfESC/Q2bGzL3440atnTMu9y/OgAouyxSoLttBIkLEFe0p?=
 =?us-ascii?Q?qWyef/0vCvcCItLg9RSBqUQTxcQ7rauYZ/pJnt0o9FSPozSQYWItxJOmKIjj?=
 =?us-ascii?Q?5C92ajcVI6RHk4qDt4wC0aPjwzaG/43kYrV32B63rM5ojhVK+vWTMRbOKhOd?=
 =?us-ascii?Q?16uGC3t9FGQ/e6SAaslyx9+9+vQaK+OXv3J/kV3D0FVPvKiFQmSZyJ8ypA08?=
 =?us-ascii?Q?mRDLNbgMC24VmAflpOQIhewDMBT53KoW08ObT57ktUjQVK3NE/E+j5KF0WDu?=
 =?us-ascii?Q?u4oxB06YP9WbLkseLfcw6VALh2UKZ2+Qs8366hqzkTB8Jm3ynG1OE6JBLZCb?=
 =?us-ascii?Q?elNTTzyzzeeRHwE4+R3wxIZcQ+p6ZZjsrWjdXJnZ1YXFNXOnBmLa34249ZtP?=
 =?us-ascii?Q?E7359pXHTJ4T6R0Ek8c+MlogseRAEM18b2QmHHAb1qc0wTmwZoLH+qdYewPZ?=
 =?us-ascii?Q?0ojcKgTlsE06bCzjrJOdGIOlXlAcaSD10pswCqv4viLw5mU1TFXGdXT0hLmw?=
 =?us-ascii?Q?RDl31TlCgPHENqgnc2eaMm0MTNve4KEvOjU/JNS2hG2FRJiHNjd3VI5lNY0L?=
 =?us-ascii?Q?cQ6GUUs2+g4w134KnZznll5FC59iEVI43Omwq/aSCrV/YCUYPymZWnxn2kaD?=
 =?us-ascii?Q?wUGqlzeOJ9wWgEmxFjS2eYVkrE5IDhWaaKwDpOfSxEHb+Br+y3GpKXs7hPjL?=
 =?us-ascii?Q?Ez3tLmk/xwwZWE5dAFp/mNM2Wg5bNB+hJhplzeTXIhsJN6cDaSIOgswAXhJ7?=
 =?us-ascii?Q?NyAULDb/5OWHh0la1+O0G1B+mS8ahXUUIgIF6V6WsC2uOreVPgZWL1V9IIcF?=
 =?us-ascii?Q?wqRoa+gM+9XmVMKZHEjg3dJUYCIBuVHKLjV1dqRjavpCLwqAc6tpU84r0rvF?=
 =?us-ascii?Q?IcEyKLprzBxavHekRlCwFuahY6DREhHnypt8StGvLpL5tMhqZBnv+LkGyOIj?=
 =?us-ascii?Q?hQWRkS/QSf2TLoe5gTxveb7WjcjFNBg7bsr5zv6+MJgp7yr5P0LgKNZcc9Rg?=
 =?us-ascii?Q?wVZWbg6ZI02tc118/xixIsJSKwrF5Gf+AfgkjjN5uee1pOyeSpwnuDFSUrxW?=
 =?us-ascii?Q?68G9yn6f7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f60357-adee-4100-538d-08debc95794a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:45:30.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+Ye0OR0lswk5A6TCxQ3HAmDRMaGIWZ3Vtl6/c+xR4zd4q/AyM9qCEegIS+raQr0DE4iigCy6DOLrTZQ3tztCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292596-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 88C425EEF60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 01:31:31PM +0800, Jiayuan Chen wrote:
> Found while auditing the same pattern Sashiko reported in
> rt6_fill_node() [1]. Apply the same fix as
> commit f8d8ce1b515a ("ipv6: fix possible infinite loop in fib6_info_uses_dev()").
> 
> Writers holding tb6_lock can list_del_rcu(&first->fib6_siblings)
> without waiting for RCU readers; first->fib6_siblings.next then
> still points into the old ring and this softirq-side walker never
> reaches &first->fib6_siblings as its terminator. fib6_purge_rt()
> always WRITE_ONCE()s first->fib6_nsiblings to 0 before
> list_del_rcu(), so an inside-loop check is a reliable detach signal.
> 
> [1] https://sashiko.dev/#/patchset/20260526020227.4857-1-jiayuan.chen%40linux.dev
> 
> Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

