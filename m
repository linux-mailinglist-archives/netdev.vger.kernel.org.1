Return-Path: <netdev+bounces-287451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEnQKJolBGp/EwIAu9opvQ
	(envelope-from <netdev+bounces-287451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A473E52E794
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F423301A266
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B23BB110;
	Wed, 13 May 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPalRMaA"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FF36A364;
	Wed, 13 May 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656659; cv=fail; b=WbHQS5VTxwNjJORTFukowuOUj3/bftFZjV3a06hcpt4O82/kF56v9HISRYjoEXbeHcMuSu+PVBkPbeADuNmbD8Ty8shrFc65qKW1lxaswwCtaBqBNDFk7k4wJ2L2uqhcNO6D41jR5jnsd8oP5d0K26udvR3+HpHqr7e5me/7KVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656659; c=relaxed/simple;
	bh=pctFjEfKbedvHMYf1GQrW53gN0SjxZolXbNAW7ryIvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AULi6xzP4J8iO2rHS0HkMH8R1tWlhTIj7N2k6CAfL6dOnbwX/D8QFSx5Lk0r1N4ufM8p+SDA0NqRog95L59qFa1tZMec0Az3x41LndWWmAbL90t89m6YaqKGEGqgUTjDqJcRdwTwPmfAbLJlrtSLidTTWPaYZBadHAgiRD5wldA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uPalRMaA; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHXadg2Q6tUtE5z1q3vU7u7hPaFd1X7sPxonOmATZ6DBn7A6CTlsswhp0cauTE15g6Pl8IQGNw+WhkVzJiGibqK2el/9PWUzlmQogJOwHNx+85suz/+hes3luDIP5EkWE5fyFmqhhszha9iAkowwPMbi6mlPSWkER4z8qgTOp87l4Nb1oV8eGxB13S1OqSLLuCzFWQtbmVaN/DCqKBd9mQBQb0Tcvkr0k8m/MsxuSPtwPkkMV+H9UJ0qrtqLA6EErR4hYZYHToEgiDgGj9uu/7rqMEIhacvg+zcR6PhXxiSUm12ZtIDVYy8FacBVDR5/PexygJn4eNlPmg7Il/vT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kALzUjdXuBEUJT5IXCdrTKHHWhRGzBzFMupq5QA52E0=;
 b=RFcO2iIraj9O+5sAmOO8pE1s7eaOzTQsumq8ncxoCy+LgL0E7hNDfiHtAGpcc+chN5id1rq4i2lkrRPd99+s3j6M87ehLnOM2plyAtdYbrNE2BKMEQSk6lqjh7jMVvbXjzFbksTCUsDp6CuOda7ltshDS4feJl+Y6T9rlZIRvS+Rs+0Noxa1X6lgRq7x31hiDZBavm5/OXqISkJSPmaggnNanB8wTilzqbknRUVCW13t/TsibdKwAllyJiUErCIcd6/CuDgCTrTRb8rUswLJRzT0NuX3CMklXRC857KEx5QDGvgCtK1NIALnVoCFLzLyxI/8tSFe7E1y26SAJTELVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kALzUjdXuBEUJT5IXCdrTKHHWhRGzBzFMupq5QA52E0=;
 b=uPalRMaAlRjmBkNIZr9/iRwleUe4qcKI2xlVXTHPXAID2keoFXiK4BcSLlA87f8Ttcufs1aH3xvXf/DdAt4cWWzbhEQKoyxXRK/MWmmB33lLBaHHovHuFx836nXA3xLinta3hUpIGgnXbFN92BnQofPkdSM3LhM/sKIwHKRl+qQKZdun6pNkZpCcld7NHFNDZ9O/JjYTvywz1/hS3Fh1mvhJIcP6wHBUlghbFR7sQXP7DFCz2OjnqUC4Ww8WM8qo5/VJ12vKNEYmzlfzdlD+9idMhC30gfl3BJJxNyBOKw3/V9lbtXBd+m2Lz8FM6xqoDE6BPag5wkmrcRRoA8K4HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:17:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:17:34 +0000
Date: Wed, 13 May 2026 10:17:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, fmancera@suse.de
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, horms@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	davem@davemloft.net,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Re: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation
 after prefix deprecation
Message-ID: <20260513071722.GA334995@shredder>
References: <20260511122645.6233-2-fmancera@suse.de>
 <20260512170117.0d7034f3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512170117.0d7034f3@kernel.org>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f191a1-d95b-45c1-5561-08deb0bfb456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MpBt/D38gcXpAn835ViXVnWzq54EWjvOUARvTacvKfBtyThOCW32+9SqYOkbDqfusQFzIe9DOelYHuWkXwqga1A0LfALyqLzDrWaCbz+L7feJ0KiyG/aQ2tdLN7cSz7P9TG+XdeSOk3lx2EuUjJY47wisvA4+SrWKOZ92n8zkJwlOKF1dwXeH94Y9x3BFMAJwlLkqLIZyakenbTYcDd8NH3GGc3sdd9S8e44213yr83hKcnUaiY3r5X5C+EpDSr/z3/vjE+BJJoMMiq4s0XtzyBQJtI+08qKlycSgZlA7dz9QKlUf5y7glqvUV3+pLPef7QW1K5ymwpqfYZWNEcdfG47rO3au7YiNEQwasLnqI+CL8RlgFKValyh9mffaFbvBWJ1pnquWFCoGRIwh4OX2ppyI5/ast1ZPTAFJmFXiqqtoziiFCY1tlSatI7rV61VWjhdICznrDlRspWBTvNZk6tjUUmZni4A6ip0eOzPYiwGPDD0m4stJAnXLL2TzqV4SMk+/k2zDMqs9jP5si7fCNn3F9pOIv946Mebi7Y88NnBZ21DiRGy7tNyf49Ma6IQHIKgNAAxjT85VeBYT1q4fmiEYnWsnF4QVOaBwhmssVeG5+ypX9Q7tZn6Gm0UQkEEjYC8m0gDvdaCvNDKufHzAoJ8IoX8hXKN1FlkFVriyLhviWSne2GNH+L23l9RCAmX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBd3zpD8w3EiZu90EN/gIDEFbh8FEAyIOAcRcurM5HlqWwxVpyv38z2+5KZa?=
 =?us-ascii?Q?mjOXYTY3azbERYoJk8aGxHQqGlnCk9qgBhbta8wqQmHRwGVCEpdGo+k8KE5O?=
 =?us-ascii?Q?Auqgs8Kn2qD6RrqwOlZMZnsRxevWEvMjRp64mqUf4OcJ2mSBbn+Xt1BOqj6g?=
 =?us-ascii?Q?08TtHS1GgJW1fbAvD1/Ulf1exH6ZxhT72QbpCnRdYu7G3dtN+CedcCvKqxhx?=
 =?us-ascii?Q?l8FDDnec+dLkX2fbwoP8YUluchaxV03A6MoSmGE7FZIQVyJfv8Ju0u4ahCoB?=
 =?us-ascii?Q?YD0vm//eMC1JJ0T7Xq5xxQA6wuUwDQM0149DlvRYEB1KlTC3fBMlNNTkyora?=
 =?us-ascii?Q?hpieI9myF1XdG0YM/SEdv1Jb4vbVGvMd4wlCslOq93sktQhgxZxlCX+OGDa8?=
 =?us-ascii?Q?gkGPz0JHs46fSM9sYlA6jrKOIILFNw5shQZP7wfco2fUmTojfo3HTJzrzsH6?=
 =?us-ascii?Q?USS46gdmDQ+5L4CHmXrQ6nO3y9fzMIFUbGyWRtUbuZDrK3Alkw9+tINK8v91?=
 =?us-ascii?Q?Qofg0CyQ9hIGz89Q2LvJ8ZMHdHL88aKdZ4huXcylSf4/8tZhaDwcIDFL054I?=
 =?us-ascii?Q?kcCfbP9zWxB3qb7GMjYsdeBKKO3d/1RJmDtf6QLJxsz4qcLIwBz8N33632/S?=
 =?us-ascii?Q?pwzTAmtAbLc0rWHSjXHQkkVGSNquchQwt+aocVREUcppEN7vMOUkorMNBBP8?=
 =?us-ascii?Q?TQIQz0NNqSLmBlzvVDck6JBZiUKfemXmsHF2HMWB9iHOR8fWqJLyRDHAIMGL?=
 =?us-ascii?Q?vra+7VCntieoAljN+HFx8ikdZqugvxuvam0wj+38zNtTRckddACBEzHOEP1b?=
 =?us-ascii?Q?gvsbBtb3MHxt0anOFEjLAyV/Gg8bXGtubqjSByxyYVTPWs3bQ2lL5Fktkejo?=
 =?us-ascii?Q?MhQT6agXJwXRJ6qMWuuKewNoM6SkcvpCIpa5MNTvl3owF9Qp2HAEf/VIxu0s?=
 =?us-ascii?Q?QknNiCu0cI2Kig5SdzxMr0WpsPYIOIdc+o2cAuyqztZ3vkVKf32GL9LvzWK2?=
 =?us-ascii?Q?wuCMI9pkiegYDk9OYhzGJp4CaN/GzefqfqLgdWtAewcHfTCSme56bBOy0Ije?=
 =?us-ascii?Q?Wbk/TLr5j5VxJz/8gZ6tzExJsba4vtuwVjf4pLp6S5Ucq6JVsyCCIPhxMTsf?=
 =?us-ascii?Q?wQywAJJdpc5e9s7pMkG3s2tzm3LRniEuqFaxyyonMKgadgOSWqLVT/IC6IVt?=
 =?us-ascii?Q?21uxxg2kn5e4eS1LjZXhh0hQ2/uxB4LmFFoQn8cUpoQrRUsZzK+C+r76YN2d?=
 =?us-ascii?Q?pq8qtQteqS/XAQmmizEmLic3VlJQJQZthkjXmm8VaX/MUtSWRL8Lv715M52K?=
 =?us-ascii?Q?uqF0c0ia21BvdPX5Yw8Q1VTr4Z3WpRTk+6/ggmpiXa/eMSmiDnDsTalhn6eT?=
 =?us-ascii?Q?3fSTH0gsqAjQqY2A/XuQLmTI/nZ8BDqjRPZBnJr5p5lkWVXeWceNI9RZyHxS?=
 =?us-ascii?Q?lSSYVuGQHHtjPAVuL85x5AcgXL0jkkp+CBw/rJevFCSGf78uoT/Ut9dVXAEg?=
 =?us-ascii?Q?4t2p+A4BJPRzqDBdBaSkabcZWvAg+kk6YY7S64qMC/zXFLRf6hF7J2U0tlH7?=
 =?us-ascii?Q?sBEI9x0OuoNbcpsw3/2ffEJgrMfJfU2VLEdr8OTMKAx5+iYECIlyRVpcBwMP?=
 =?us-ascii?Q?U7tx6jr+KTFSwT98cODNJrwnJODpYWzrcBHfRIqQA8Vjlhdoe+KOHbKOT76z?=
 =?us-ascii?Q?9yTGh9xO9Z8odVfyi83sh+1Z5jZwln0K5Wn7ZamWOib833up?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f191a1-d95b-45c1-5561-08deb0bfb456
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:17:34.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoDW9h84M2JTLtTk+kUAqbeRfH6zCpboADZbrLGzk9Nk2XWa8eJX2cicB9cln7zsOvJL/izxtyG3Nk+o0cvozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
X-Rspamd-Queue-Id: A473E52E794
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287451-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 05:01:17PM -0700, Jakub Kicinski wrote:
> On Mon, 11 May 2026 14:26:45 +0200 Fernando Fernandez Mancera wrote:
> > When a router temporarily deprecates an IPv6 prefix (either by sending a
> > Router Advertisement with Preferred Lifetime = 0 or by letting the
> > lifetime expire) and later restores it, the kernel permanently loses its
> > ability to generate temporary privacy addresses (RFC 8981) for that
> > prefix.
> > 
> > This happens because the address worker attempts to generate a
> > replacement temporary address when the current one nears expiration. As
> > the base prefix is deprecated already, the generation fails after
> > marking the temporary address as already having spawned a replacement
> > (ifp->regen_count++).
> > 
> > When the router eventually restores the prefix, the temporary address
> > becomes active again. However, once it naturally expires, the address
> > worker sees this temporary address already tried to generate one and
> > skips the regeneration.
> > 
> > Fix this by checking if all temporary addresses for a given prefix have
> > already tried to spawn a replacement when processing a new RA. If so,
> > spawn a new temporary address.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> No feedback on the patch itself, but I wanted to check - Ido, do you
> think this is worth handling as a fix? Sounds like this scenario never
> worked.

No, I think we should target net-next. The scenario never worked and the
fix has the potential to cause other issues.

Fernando, please wait with the next version. I need some time to go over
the Sashiko feedback.

