Return-Path: <netdev+bounces-141293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79909BA5ED
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4835CB217B8
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5017C234;
	Sun,  3 Nov 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WuoM7r8q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF94171E55
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730644057; cv=fail; b=akusOr1ScOEGp9b2PHTjHXGaEFp/wnA8KYhoCuNaepGih67elXS+Ky1xviJ1LPuxHxIe7jTPQnkltz2g0qkA9mHvFLGpLTmmpyLdwV7Cq0gHapGp7OyMYiqg8yCESQKvc3INTV+mwT7xI+zi/XKFLAodgliL4z0qlKGkpv2BO4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730644057; c=relaxed/simple;
	bh=U4DlIQiYl+FmRYaloxaYCgrlpDeItizHoF38E/jRxNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sEAgMzxiUIJ873vwjMYLjhbwtuAB5WPkpQzxu5nNwgdjfSFm/3eC82/pEujFZUDA8qJSENOMEaY6lu4f2pmwhjYsMtMibKic/Z03yNgHDJj8YBEz4Mqqzl2LwNiS9sdQ+X433xQTwAJaVMSVnnImK2Wi31OC5Oi/9qpjJGqmQd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WuoM7r8q; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epE9s1zavcei0Xvisxgx8+hOCySar/rTi0DMKlWa6hkE2CZpj4A/+gvEle00Xy+KFztmNgi3zpBs4aGcABHa6sWTCkX/b7fm9SH9Ukyjd14+G80GPLsdeVop7fceu1AT+l2QCiSqOeUi63RagCzxdF7c47pruombPU6szSFueODt86ble7m0Z6NvKBA0eAzMlkWmokrz2TzMlED4j/H8OXzMrYOY/+16rwxf0apFxiHakJ1J+laSI5Mu/WDm4fZC5RGOdOsJtQKTVsnRIHBppino3Nf1cFIXaMg0Ex8N+1O+ITrcC0bXSC0PYtYk9/Xhvk9SaZUuN9cU84XiS43mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HZqeo3M9dg+rQJDxXAi7SsZ068Mmq7n4jGy8+LyH6E=;
 b=f1/SqmQdd00QgCEPKZExse1MYsWj+dw6UmaFGjZ6SNoxSTXFqyqxeajzWXzHWjaMFaQ44wCNfegO4NZXYfjXuhq0N1O/ydzyIrw9YX07gd5OggwkTwWeUACvJYUqN8lePXLLo7hDmYR8GcgWNYeNhhTkgJPEPalFp338z4HVydpP43WikEPg6zne8Mu+MKUE1iNNwqqfgvDO1jN+JMbTnvZ5R6wpU29D0BsvP1Le/g+P1QBYfmnVTQJymLbcRzWjDC7fqYQjKlbERiifM5qC2j7DyGev11GIvYz2B6bT3Vqe222UCkjmkSZbFAWX65O8p5dc2STjzUmEZssf9z5A5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HZqeo3M9dg+rQJDxXAi7SsZ068Mmq7n4jGy8+LyH6E=;
 b=WuoM7r8qn9PQjcC34vdVB0ejCUb3Ggl2kj4I/vByxfI1YRtwnrxcEhMubr9tG5e06hHdseJZ0HWY9Yqj8Yxq5q2SAWw+55zSN3LwpFuTJvgz3IOmOGIcy/hVz78zG2VtExi+HFxzajOGwMvTceBksB3lSvWMdnZxS7TjWWh9EOexxx+HqdXN4YoVQ2cnKVNk3HYY/mI4V9JLZpJDicpz8ZZO4aAHuNLhpFCGwJYoseBwkeagWbWL8BRXC/PPHsZcwc1zUaPOSZbx1u1v3Tt48tkU/6scNNV85FGWDmLhG16TU602VnGR7HuknANs+rszFlziSFW88rM480mJQEcNEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 14:27:32 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8093.027; Sun, 3 Nov 2024
 14:27:32 +0000
Date: Sun, 3 Nov 2024 16:27:12 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v2 4/4] xfrm: Convert struct
 xfrm_dst_lookup_params -> tos to dscp_t.
Message-ID: <ZyeIQAOOMsZWK6z4@shredder>
References: <cover.1730387416.git.gnault@redhat.com>
 <8b7dbe727a3aae1d61a2a43ec4a7f932feed70a0.1730387416.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7dbe727a3aae1d61a2a43ec4a7f932feed70a0.1730387416.git.gnault@redhat.com>
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9057367e-1da8-4cb4-9557-08dcfc13a736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rrgyKbxxF4BevwhYgzPvuaNlk7rZRHgdNiZN72F48MDdkmBy0Bh3YQH/vFCA?=
 =?us-ascii?Q?lWt6oFzvRmIGt/Rs5ZAD/DAbUGLLEsZeqdy6Wt78CHk/SOFSU4Hu90qdHa5K?=
 =?us-ascii?Q?4k5WM7sF2kLHPxKHejIRH8U0GluS16U1WDulmQMNwl5ObSgNWovpMBkanTAP?=
 =?us-ascii?Q?cpMgYhRvAXB0LXSTkjBeYmzXDRmZGTuz71hn/E44GdEyFqRl+ffJ5wp2s7TD?=
 =?us-ascii?Q?wYf4Wq6nDD1u3z6p1gHFWAaG3G4MWasasRYaXhGyBgJmie9O7GqH1DKwV5tw?=
 =?us-ascii?Q?d2jvGxl478AL9pPK/rTLb76hiVowE/VJCExbpwv4/NKc+zhxPLtjUcr5z08u?=
 =?us-ascii?Q?IbU2YDTO7S/UHQYtX87Voy0NI13Au9mft0NV7Ugip1KzmbW2rmLeYv+XB1GH?=
 =?us-ascii?Q?dz0tddcQinyYx0EStbd30H/qunp91EhRem8RScUdIJvMnA10jDDbYkBjNQOa?=
 =?us-ascii?Q?bdTdaOiwGQOoYA6Hw+CaDbtCLHUbOwemqQitxYgk4vQxJZ9WBR6nJxY3iDCq?=
 =?us-ascii?Q?scKK8hQ4TaW8zkcRdA8D6tEWJThW8yWEjx0KKXJKcDjl+XuUAzFE7p55cBCW?=
 =?us-ascii?Q?QUcWMueGrlRiV2qHVxqOEsXQMeh7BouvYXT4qiJn1MgwMSn51JrXOgdelxlj?=
 =?us-ascii?Q?s/o78vUJfhppVxdjKCjBqLm1hsm9dAMfv5tkOAAiVJFC+5qStgt6HFq7LV3M?=
 =?us-ascii?Q?K7W1znTSj+eJogotJ/7zShXWJmnmo6ijysS1kx89KShaYmwB7rkSXOQ5XuY/?=
 =?us-ascii?Q?dFHyMDuIpNCZuvuTRBkhBRDuKrHYVcRAcPiBu9N4CI5PjGdIUwFTLjRYnCH7?=
 =?us-ascii?Q?bVT5HUa+sVmeSXHClBs08HgcvagBm2yjdMS2f3vpcE4WnAFkFyLn/uv0YFFv?=
 =?us-ascii?Q?P2vgxdHkDPR/MxBa/ZR1kh5tzCtQ/JJofLVVlHdggDVoUckAOE76SoD4FXYr?=
 =?us-ascii?Q?k8zxfKWwfLQqc32oyMXBNAccpnlTb7gHsXC6BPLRsBuPIYAH0tbyI1wH/5GU?=
 =?us-ascii?Q?3XuliXAk+4X0bLAAQaFf05gQGpcB45Gase+VUlsUCiX9IH1WB4ANwABK4jM3?=
 =?us-ascii?Q?NwO4dCgcAl1Byi5zwxRd8S0O8m7wL4qkxOEwKW6159TkuFjWtVHZeTnp1VKk?=
 =?us-ascii?Q?ZQnHNPzwJ3ZXcU6A+YFBEzU2r8OaQNQo/WKQduC/isENzrPDwMMp63oE0/+g?=
 =?us-ascii?Q?Oqjf53M7Ebx00doCB+FJLYw9rWgQTt02hTepY2fzuE1cAbIayPGoS5OzPYaA?=
 =?us-ascii?Q?D1yeVmGvEjpD7GqYZzF+R9HOFw87hixir1k4Qhh4+fIndZt0idWe9vgRpdp/?=
 =?us-ascii?Q?HEPD/8AJAXWgEHCxpKpaxatQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hk1J3WakGD/ZU06Ctfmn9/vjkmq+pTkv4Ywzx1/ZO9Wr2NxMySdt9oIjt9YO?=
 =?us-ascii?Q?5zFMtsFFacAEWaXyrQqUq9UeGQ8hfrOBOWSBj1tx6hr+QKZ8caZwzsDb8tzr?=
 =?us-ascii?Q?pdJnKlC4BM98nEZOCFUGkJ4MCteoidR0fZx2e2e7J2qnOEZkyaDOv0OXFAGn?=
 =?us-ascii?Q?fUr+SPBoLk7fzstwMLp2k5s9dmlRC6pBc6Yi9zYzaN9THNQ7hZSoIuaUDcq7?=
 =?us-ascii?Q?bfZSK5DLBT6agy35v4WmYIAUM6eOEOGeGZSPGhyrxL8EXiWHAD4J0zvNWegv?=
 =?us-ascii?Q?gsL64LBAGRB5wiELPQ0Gqij20w+Rv5Aym8zNxWOSGh57ziBB6WygyplygM+o?=
 =?us-ascii?Q?Je+lVsp2xTtg1g6As3OWaoRrX8GomlLuJKJ+16dH1MDLIo/zU1Z5iBRe9IlF?=
 =?us-ascii?Q?4lQj5hoMitHZWZ6KcPHgt1GjPwRL/wd5UzO39EW81YEKGjKZ32W3V+GAao1u?=
 =?us-ascii?Q?gpFP9L3yKnzQMtoRGlxmacfsFzNogd0ekcGBzQhlv+xoIDgAjxz/PUpWIg3h?=
 =?us-ascii?Q?v/F7bUfMLsB4ezILAEUQvwg1Yrh7HyR1WJ48/pPCHP/Xtu/nnb0VxqrPrCo2?=
 =?us-ascii?Q?0FNCwwIgq0KdFSZ+48skzcXQSZLpQDsZNygr5aTbpK57+IXHshB2DBSI7dCv?=
 =?us-ascii?Q?cK+VNu9CIl6K8EHqSxo5Z2fQrQ+uWCE5LXLLT6ieB+k99IdFt+m6Zh3hhTZU?=
 =?us-ascii?Q?QzyY/bjSE371tXpLccM95eEG/8VYV5zEiBbjM6a65en7IEJN5bfGmCWzvxVg?=
 =?us-ascii?Q?2Z8I7sS9FFR1FDDeQDnGj0xWrAEBYjSbw+/ksVfOQKwIs8Jmt5GMmBMehNau?=
 =?us-ascii?Q?OUxjMJIAsjNv41sVj0PEFkBqqGiBHYrT7nOVVUjuEb2KQHxC73BLEBJqdRUw?=
 =?us-ascii?Q?pzr+hlLdPHv3n4aQkctvz1H99E3q5HpfFkTXAThq028JoBUvsBSpcIH62YIr?=
 =?us-ascii?Q?uWVf5Xhio+qoTULdWdhwHkllkEjId+FjMud7dvypv1Jz1NeSMEQqCiGGSCLi?=
 =?us-ascii?Q?ubkE1x26S7rdxLL8E3dY2aOerJN525xNXnTpl2i5LbJo3nKoRZQm0ZI1uLH0?=
 =?us-ascii?Q?/1SZ2EKo0mNEbmOIf8hFOn/RPs9sdivuaGQ1Xn8t4QNulf4Bxr4yP5LRIk9m?=
 =?us-ascii?Q?bsOd9ZuLxhFP7/I9lgzDa5h4pUyXxmOztonHQIMs3z457GJqBjM9jKQ6tR4i?=
 =?us-ascii?Q?nC2SFO9qMUMB8b2yWR1fjtO3/FbmHLgd+W1bty9c7FunZbztVv5rzF/ktB5f?=
 =?us-ascii?Q?vLPdEEUcgRMt96Q13LBwcDG98q8b04XUWd3mpMaABR6Qk5qqg3ixjEKFDnmK?=
 =?us-ascii?Q?LdOtQfjiI+iiE6airaYTQQoncgVQJhr8BvjtnH8Nt8o7w7ThS5n0AQgEZzqa?=
 =?us-ascii?Q?xbz7HcBsCp1Kpk/uE7je4i1rPHETbtbN52RM10IqhxSbj7b8MDsP70fh9cS1?=
 =?us-ascii?Q?zjOpB7PoT+Mp9DXas/5kNvjuDwdk/Si9O8tOa0jRnE19EmqK+zlbkK3ZcA7c?=
 =?us-ascii?Q?JbULtksQq3Qu7BSYG4bpx4IlLbVY3G4MnfBWmRxk0MC8w8jzyo9Qx/FUgEaz?=
 =?us-ascii?Q?aZ+AeOxFGji5CtiDN2Fd+Tg1z+3s6SdhzAJ0brKh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9057367e-1da8-4cb4-9557-08dcfc13a736
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:27:32.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gEodsMOHxx5R8qY28kYaS9gxRd8TRhkAG2APs/BClRZgVqVV+A5P77OsgZkMVmm9ILyPnH9yKITpgQSWQsEKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

On Thu, Oct 31, 2024 at 04:52:57PM +0100, Guillaume Nault wrote:
> Add type annotation to the "tos" field of struct xfrm_dst_lookup_params,
> to ensure that the ECN bits aren't mistakenly taken into account when
> doing route lookups. Rename that field (tos -> dscp) to make that
> change explicit.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

