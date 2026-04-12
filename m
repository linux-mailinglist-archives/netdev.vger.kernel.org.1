Return-Path: <netdev+bounces-277749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPqxOFNN22kL/wgAu9opvQ
	(envelope-from <netdev+bounces-277749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 09:44:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39A3E30CC
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3573014BD4
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E630B51F;
	Sun, 12 Apr 2026 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CYjd685J"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710627A476;
	Sun, 12 Apr 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775979853; cv=fail; b=eai2LrmUEzeL6wVoXuhCWoHLn2s2wvYockt4oA/hBKDGyG/SIjN1eE1D0UlWu9NHRL7ySMhiyzjfIhsvPlHJvQ2hWutxYHaqlCt1vS17NEb9b1zpI/Mf1G0Q9dgzVX/b9ajVQMam4aczRA/povpgiBQi136/n/j009LDqHQo44I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775979853; c=relaxed/simple;
	bh=2eVJ7JwH/aXxNisVe3YlPYZJd+ZBNpYNxpNsa/7o7tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mwRUdXa1WeQHjc0SoFPBglYrLgGjz3rJTchoOudGRn2MuZmTZkYRkLiMqzycwP3DLh4zFI0lMvWIdf7U/FCFXgOoqFmm1CbCRAMtpP+7leh7Q1z/8ndoJIZQ509UIY0yta35CoJENJT7do+yh0Iej1J7ALZorNgh8q0SU4ThNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CYjd685J; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUoyfopRIJ/6FesT45aWX4Heiq5SaFMKLRzWMb6SiMHXUEoo9KTFwSxQ4cAgKn08qmrfLkw2OdZFoBLAsxzsnEiFKxXb6tqmr/ovQS49MXb304WO/be6iPdnFZd1TXyhQGvk2WDr5vRd6r2tPvqxAQ66h6TKHeCrWZsfoLD+ynn1pk8Et9c7F54d+WTtXddlMcvCqRE6YZhmBLI45xddrpjfPOzxTEmCTHf6nn9W6TRLSM3QYDRqJm6cQet0D5GpzmsIr6LulidcVKmQaIa9xaL7gR+Ltl2IAZsKl+6B305v++oBgeTJV8rK8So+qBVk48FTNYdM94c5ZY6MB/WswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eVJ7JwH/aXxNisVe3YlPYZJd+ZBNpYNxpNsa/7o7tc=;
 b=hfVGzSDTKFO76pxPjnPF2lqOMwLupflFxmNUj2pALMbj+9/PT34B9B2jyqxptWTh0rRq2xrcIdCGuxhyqai0aF7EWoptw4BoPylb18ICWZ0TeVvUheGKZZAgyQkZH0JbkY2TITB8OwcoTZ5F6XW4Pq07bp6VsPoL9+mMIcDdcThLGfoeKpGKo1eQ58sHaag7OUT7KRHI8gubmUoL5lwSME/EuE5HaGgZGE4gYtynJ2DDoVQUQjSi8O4gYKUXRhu2Q9XxmJSKj6rtBDPYvmczjhZ46qtspffwo70CHOEEb+tlvee+RIiFw0vuCg7eNG0jGTH0jKme52FYOHU/LAv/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eVJ7JwH/aXxNisVe3YlPYZJd+ZBNpYNxpNsa/7o7tc=;
 b=CYjd685JYmwBE03Cp2vNERgggbzE9ie5zT4+tDHs6koGuc1F7fADAMbsRdP/+osw/Bf2GeGVjNryoVbCdC6UuazoOo2I4WCTaHKBOQ2QW0e2UyBL5Y8wYckciFNbe2CA6oBR3rb6std2XN/aef+YkxK61YYeN21dibIE9eQsGxayWYxUXCyA6ZI+Oa1r00bAhxwtWFyN9l2BCNckW8ocFjE0KmNdQznTaAYlgI4fsfY3Gva+36jpT1b7A67T4LSZoNLtOjVkhFM2tlp2rvgsUBljGRY8IH73Cy24L8GEePIAWPO1kSnf8M56KK8Tha6IWV//JW4kBzSHluzG3pN1iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Sun, 12 Apr
 2026 07:44:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.043; Sun, 12 Apr 2026
 07:44:08 +0000
Date: Sun, 12 Apr 2026 10:43:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] ipv6: mld: encode multicast exponential
 fields
Message-ID: <20260412074359.GA62552@shredder>
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-5-royujjal@gmail.com>
 <20260407134502.GD849209@shredder>
 <CAE2MWknjWczxM3WrKkQ0eHV7PdNxMQ62GnTAp6tCPToumZnE=Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE2MWknjWczxM3WrKkQ0eHV7PdNxMQ62GnTAp6tCPToumZnE=Q@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 74642653-6b8e-4e0f-9e4d-08de986747a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VNgVdNvFanMVsACtrPGtVAODEGsSi7Bay1vojZzMjqQddPkNchJCrcfiZaIm+PCBR3IOk3vi2/BqcwNCC3y6pm/bTZ180SbaN8jMVANlb2PyCVPaIfbuV/RSYGOLkvM3/sYRyl77p0hM6kUp2fUwMzay3nKdKxc8JLli3o6fG2CTESCL2RhL2rZ9KFkYjuPQ4sH51b/TSjQmGLIA6wbDuuCxoUMe0ityV0AuNK8HbUAIN8NjjoI93Oji4Y+7I0zFt4cXMtRiZnGfZ4x34lh9tA14hq3KbVnKTL1pypqn5hVRufOf0nuBugLUsBc2DZb1/9fTGMxAQvFr2JS/hw1NxSK4yAJnxMhw4TdTQa9ouJ0vS26YUaWCQ9aXmD3+o+umHy116lBnxrZ0slEizjcNs/gC6wPeJ260j/USPF6bgpsdYnIWwtrQ8+Gf+osnkt8pVyCiG96ATvLEXmaA4CqBoPnYk+ZAB6YTZ8WdjfdkyuIjkIR/wuUDRzJPaMMsTn+C1I+mC14ENAtQ6o/b649nyh2hx1NjibcX4ceXjq+CD6XwA8HLbUIYTiPHzLY8BjKEZ8hWDvNx9rVGUT5GUtiKiR6gLvoBmBFcvOgiE2vJqagvQ4zAtltZeB6TOb63ig21+5khL6liaBPCU0iyyoXdJ6rmQaUFA70QJ+oPoXv+FPlkMLfDP9U1e0GE7dwFXQ/GuceZL1Qzv20Q+A57diu6TmcrcZNi5o1j1RH+mNYrm/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9zxw3IauMt3hCOBYGg4PzLPzP89FXTaIVDRLbpyjSPfBNDFUVNLWFDvnNn5?=
 =?us-ascii?Q?Z9mWWXQjT8znEKHZrar+ye0OkSlaLRJRzePG2yyt8WRMPn1yO8z7f9Nh/pNN?=
 =?us-ascii?Q?bUNJFUp5ZAmdbRobpr3waLfZLaS6BxliRqqIcvg+zgg4TI0TOkmfifNHx874?=
 =?us-ascii?Q?gzOBtcoiDxrmj8VexMDtpIcJ7QKjMAlEwLPxEnB3NL+z7e0gC+3VRlagsEOP?=
 =?us-ascii?Q?QBfWiXvAhrqN7J5EI3JEzi/hqr2ODidscajv+ld2/nk4RHEhZiIaHeGvqq1d?=
 =?us-ascii?Q?04x6N1UvuyUJ/GKP8tiqu7Lj0sVM3MVwcOYm4Scx08tGkJK0eWXNwl62jprM?=
 =?us-ascii?Q?RXC5J+CNWqMadmV2FTxS4v/Zcz3xd5W9Hy1/JVdPDDjMla3fA61ZEs0TiwHj?=
 =?us-ascii?Q?UmjAFczldxuPN2wkAjfG2XJej8CDyXGhRPuU8t4Y5Z52GY82tV0IjiVGj6gq?=
 =?us-ascii?Q?Nqw6D+0azkoAAHeBPdxbA7Oq5HdWgy5Dw305LVd0dfquelIy+zdXpiq3gvyZ?=
 =?us-ascii?Q?ZUyTSml0tJ/EtQ2m1k6r4sj8Q1coXB7gOO4g/MhPjJFlyz5Jlh4et1qkZaMD?=
 =?us-ascii?Q?Pro18B413agWl6LHbqSC0ws9Am+IFFcrhvyHKGYjdmOX45n9H7M2UhY88n24?=
 =?us-ascii?Q?nZexKP8NYOSXpjNhruvuGmjd2yNvGtozm46B60kMqQMaroZ66bQSpdwvnnbe?=
 =?us-ascii?Q?w/+9gus75UV2nYkoalza+FEgugv7Elcu+i50i3fn/0cinQsexmcLLROxbysx?=
 =?us-ascii?Q?cIb2yNKq96TVl35NPHPNDKMQ/nGIDhZQHidOYcV36AmLPb++q17Pj7c768yA?=
 =?us-ascii?Q?dhhNg7ccJAXKZpSyhmpzNkt6fZE6o4UVdSpqgA5O//fmdK1pJM0UzpzXYbgQ?=
 =?us-ascii?Q?b0z46CKh7aF2nQotF0kbaacBgImBLXV1rwNa0MeiKj+THID1UJMh9BzOTODs?=
 =?us-ascii?Q?WW8Gco9x0J4aEA8mELhc0oDCvYUiw2Djnvr5RStOjwzAFY2lEfwQ+UBeOEMs?=
 =?us-ascii?Q?bpPD/HaTAKC+6M9htfgAqVV/THQCZKzx0bVMrrbNP1Ufl95wZEwy8lFtRApI?=
 =?us-ascii?Q?m1E7wJBPR4+eCWz2hkBXFG0Kj17dtQV180mjTxB21Kh2pzC/jNyuDe+SnqFZ?=
 =?us-ascii?Q?SC0/vBvdlhHaPxiZWJTqjFrkPvWkYZw2pSHt5uNqJoNfwwIpo9SspDn2/oBd?=
 =?us-ascii?Q?keHHPlrINeFqCKWMp9lhp/ptFyO7tF80PbQvWINEH16wJAf5E0F+qFmdyiLv?=
 =?us-ascii?Q?h8RPgaARdye/ydUGO/S85Xq9+u9dRhM4F3fyqaiaD5COPgyeaNZE6Nh94BKo?=
 =?us-ascii?Q?pBH5yYFukBC7IdkE32B3IbShy0vHwHdHgMacecs/9yYJm9G4kfPR/41sMZsr?=
 =?us-ascii?Q?Z9PPQzK+fGirLdyHEhjqkuKxianOjjuo7TmX7eQSI6bkCQpJ5IwENKe6mrvz?=
 =?us-ascii?Q?1xCj2p/FgcdlpDdFflb8wZ9uK7nXQ49YC4tl1bJDlp/UV3x7CXvahyUkMvoZ?=
 =?us-ascii?Q?sC9c6ZkeSH+HApNtnxrUTreuZ+KHyPqG/Ah6ZEUk3d8qCoyM+pM3i8GkxcCe?=
 =?us-ascii?Q?qFdWolxiQ4FmX9+ecq0H6jRd/sc03CLO5vQ05DjTBIK4So6gOHkFjzmxqkq7?=
 =?us-ascii?Q?McwLd4eQ8i10AoDf19OoduMjpzBt3QPPlQx3Qe3KvqRws4uo1KEqNi3YfiFh?=
 =?us-ascii?Q?Ty0fZHM1E8Wlq+jFDRUOIzdx6lr4TsHXyYzjUNjU1IpWDvky?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74642653-6b8e-4e0f-9e4d-08de986747a8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 07:44:08.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 243zZGvU/ZEuZz+pgWT78vcslngwX1koYol5YG7jG/G1wc/p6CCYhkjVHuzYoxN3QPhiCVJASDD1IhEpH7x6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277749-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F39A3E30CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:36:59PM +0530, Ujjal Roy wrote:
> Do you mean to include "Reviewed-by:" tag into this commit message or
> the entire patchset? I will modify and send v4 once I get the reply.

This patch only, not the entire patchset...

