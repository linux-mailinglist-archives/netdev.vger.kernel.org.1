Return-Path: <netdev+bounces-216301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B9B32EED
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B54F202A60
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB135968;
	Sun, 24 Aug 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6aQbdF8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6C29D0E
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756030539; cv=fail; b=L4H+7ccJaDheIi0+NhwOKRIjGqfoetOvqZRQ6X97gN/XkcRK1lOwy5Rwc0bUtFSkDiG7NAPQwojFPg1jE/whMFz8HV8KT09DGR08BICHjHCOQ1CVkmrK26bph/gxN4//3P4Qorj7T4kZ2xLTdOCwY6a8v3s4mTWGQOgVM6G7Nc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756030539; c=relaxed/simple;
	bh=nI9VuXh96IOD6j61qEqVVf0aGw2Yrv4JhbdacoHQEhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AjpjnxcVe+XyBn8aoYzR4swlRmP/mraIznMEjbqY0fiyPY+jcGD5yIB3zGBeBDPVCEEDqzdLY/3HPFoy6CY4QRGC1bjr1xP8eJqBVYZahPkvcFR8Z27ziZoWRzMmjLNii+nBz1zZqOsQtVvvPIQrfTOHEXS1SoIKpaGbP4baWHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6aQbdF8; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxF+3zmwNOWPU5T0A7fyZmNke3P4fFYp9ANqaQ4SpAM5esbv1L5bo4v+gTrsvhN0+D9MmKPKO24Qp++AIomAx0UmkNWJTLMiK1rGe/prLzScAaVDn8bshcT2t1LPO1/nW7f6DvQR+FiyMFxdOaXt8NZFhF3h/5xJxlDWolt778NUIFiqlSLmxbpDWkiKGa6sTx3JuqUH3pBq3ELOaySbbBUzu2Vc3vrTZZVkKSIxTG1SqkKAnlxPC/Zydx1za4WscvNh2JRI7jaEwEiZCWVCj3JJ9WvtDfRjpxFu2SW0W8cRN7SSzcerw0Z1NYVLJh9TSqAIDqPYyOvxUbG7zizjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zh864R59HSF1XgC9VlQeq8fr6i1mu9BkQ+930JcRMQ=;
 b=HWPdde8mljVokmxg+1154r+Tjkf04wbeeUa44QA3sb1zSov5v3UsCIAsEbyEr1pMBLkA9+2+8nSchfzK63XGA31I36GB0pC1APXfVd/RF7Cp05keADFXDNkS05WguHW+718AkAuQMCaCFDVOy3+EQzmh3ldwJl64C5rWvO0cuG4XH6MxvVuzWQ2KmdoG0m2pWyRDqdFyENJgoELzspcjT3vJtJl1T2NMDeaS/lS3XMZLtxvV0N7GGV0cHNMbDwRCVq1lI7dBew5Jq3c6gQqs3Svd8Uj7sUBmZxG2BY3NM9bxbIt3vNtRgfGi3z/hq0n3pbBKV3NFqjlfGjcSFNgzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zh864R59HSF1XgC9VlQeq8fr6i1mu9BkQ+930JcRMQ=;
 b=X6aQbdF8+T/gswSW0V7mmTcrUXFd/4xXXBhDaBdss+XLo9VfQ7PF6vgQdQoXZSIyY3NtSi755wJD7iM6hIOxxixKD9l40DqjUVfXZ1b5bhcLaTcvzYeDBDm/7KOJiFFEXzFC3djwxrloAH/k3qdQOx/oAI5ejNLiPPe4aF/v8tQIZxJumjSsMqko9zExjccIhndZrdYvYLh5v2bDF7tFGNS9nkUDfdItUuDgbIL4T3P6VLZ9/kFgr79UhsZ4HZ0Jsd7T4UCIBynh3bawaC8OexLh+VVvOLvD30P/kbMNm4DadQ1t4ziV4jUqlGBc7FKYhjubTHFR+HBATFYPlv19sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Sun, 24 Aug 2025 10:15:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 10:15:35 +0000
Date: Sun, 24 Aug 2025 13:15:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH net-next] ipv4: Convert ->flowi4_tos to dscp_t.
Message-ID: <aKrmOtDqr_46icM1@shredder>
References: <5af3062dabed0fb45506a38114082b5090e61a52.1755715298.git.gnault@redhat.com>
 <aKbDCJWjMpUEOtXe@shredder>
 <aKcoAbPXff_IT7MN@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKcoAbPXff_IT7MN@debian>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: e82d310c-5b6e-4861-1450-08dde2f72a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?21F8TBToNgIHR3TFfzK7W/lpwhZHoLQvyRuaRenmvogeL8enWLIuy711/KAD?=
 =?us-ascii?Q?cAAyFbumiM9p7oxM/r8M2cIk/Joxcdl0D+8tK4KCxjyrxFQ1NqJdb5tSx6/K?=
 =?us-ascii?Q?1p1xAMJuLhVYjC+PAOvILFnwvT0FzHN+L+n+PdnDonbSPhQD/hmqLQdQ9XrG?=
 =?us-ascii?Q?BRpof3605ghs6Vh8S9nxsR4vwjMffDBMMUasoNV15mgYqlByS67d+CTxp/KT?=
 =?us-ascii?Q?OscjL1fk28oZUOriQVhgN06RY+AgVFegDCwQo1DdXRvK87/04L/iD9uSd2AQ?=
 =?us-ascii?Q?Z1Ey3dTtyuOQ9nmNKoHoye8EFyMUNTZM3F9yNx0lR6p3Qu6PyLt7D4/jc4++?=
 =?us-ascii?Q?EznE+VUG4W/5ap2DGj1i9h+s93eOP83wsfa2pBimufYSEFkcMrO1e+pNqzOw?=
 =?us-ascii?Q?uSUTKNjZknhqTR+1mD18vLcFlekTzCId3HsD7iGNK8ASujq5NxEeGBIeghh7?=
 =?us-ascii?Q?NZ56kYNHiKeNxU96MBDDGZ5A98UsrYVQTt346ztnDOusocdMWDTzH8Knk5FN?=
 =?us-ascii?Q?OLSjG4RBO4oOKB/kfza3R16jiqiXZyY1qI6X50lLu7qFRPVQ+BJjSnld4mFW?=
 =?us-ascii?Q?+sjRYtNEK3yjIkMFZfkVaj0K4D3fnJp2Niw4pSxkErAwxcpyAwG7RpW1cWeb?=
 =?us-ascii?Q?ncOFYWTUmbJBDki+OOCRlPHve4atbztL8My7hyqyCJQEXghu07HaQouOw9/6?=
 =?us-ascii?Q?iUDvmwM6zkz8SMvSmMyitduECtR/m7FdO58t8ReZ9AfRn7Ui1VMsJKg1sNpn?=
 =?us-ascii?Q?lpauphWHncXrmKX69G20XdkyT1iOr/DnvG6zRr9/b4dlIKhho0ksOyS7hYc7?=
 =?us-ascii?Q?jiM3b8jbWWAD6aliDR3G8xhiKStJqoQw2H7jB5u6lXsu3MJm1FgExgR2FVzS?=
 =?us-ascii?Q?VithARWFPEblaiaZJNhJD/D1etIKScswHuIX7e+e8msTPB13ERPJwrJp4onJ?=
 =?us-ascii?Q?7bvF2/TcD2CDTJflhQXEWNW1lOaW7R8H5rmKpB16Tbv71kbdyXYAYhowZbDM?=
 =?us-ascii?Q?AAUCJWrqfk2XzwXqDE+zLjK+Ng4KwhxpNSwXOLLPT/bDaIuTP5XqbliHTVSe?=
 =?us-ascii?Q?mID+aierSMQ/ZReTlSoLFfJz4/uLdV0USmgeTONFc8ei7TlKUrq4y/s7V7E+?=
 =?us-ascii?Q?Fzo0RCkWKkE+nTdTgFUILmbqwYWYYV8xsK3RhRPRe9fjoWZ6GrLVS9Vm6RbD?=
 =?us-ascii?Q?hkq8amishl03Gd/sBKAgbeErFp6tyjCcKzRRvhMz2gxjkhQm+oAUKuVXu2Z5?=
 =?us-ascii?Q?rB+5z2AHlbALtl4LMdk8JDbXaC18KoXavFsQ7ttNksWe07rSHTwpfBaakqnc?=
 =?us-ascii?Q?z6tORNl1EdQYiRW1Ys/jgALqibOQeV6fOsvV8u2WkKEQut4HVPT5Wu4tvxdj?=
 =?us-ascii?Q?HfC1Kk2RJAA/68OS7p5Y5Raz9bl7irbtmEgPKmcg36tshB9l3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwiJnEFnaV6Hv9tPEM3komxjaco4pIdgVAKdnl4n7yz83VaqrS2mPWlFv1hB?=
 =?us-ascii?Q?qVO8KQC3eMAv8s7bsnylyJo0gf6V5HbKIDVjZc5nhi2e9m9qThdQDxAN4xFj?=
 =?us-ascii?Q?Dnut2Q4ZsgpcD1ECIHhF1nJruhZajacI/0or2kYZFBYgRL2xnzI2DRm7cYBS?=
 =?us-ascii?Q?/C57I5BagZKCyUKs+Aoyd2v1lV7ro4d2R3EH9Wn+QptN4VkjP66dpYIsTK2Q?=
 =?us-ascii?Q?THvm0Nc42Xz7yTFHSV8vVs5tT+Qdh0ytl/e8wfmuGBwVVmmpfnzbr3ft6nbf?=
 =?us-ascii?Q?J05kQMxS0lPILo++uqrQJQlOqHUPdDclpryydZJhyTIr++wHr5xLy9MIa8dm?=
 =?us-ascii?Q?4bCSFmBQ8kx4+JSlxveRmxzP5E6BgMaS99g67MUYxKfRg4rFxr0IY+/PstHD?=
 =?us-ascii?Q?wzGBd41tYT3qskauKQd9EF56fKTkNKje3J8UlxTU940MWPpSWmPeoHDG/QwO?=
 =?us-ascii?Q?S6M+gpAHAShwDoFAnV46emXEsNqISds0+l2nc2wtFyxdIVd7eUzT2RMBydKi?=
 =?us-ascii?Q?dlc/Y+83xdnHfne0oiJK8fGARIxQEk8LN86XSAk3Z4m9Vpx1j3MSt3FUSlhr?=
 =?us-ascii?Q?JrWs2Zj0p0A6U6dhxTQb2TYRGCgdqdJ1HksVrksvPj44FFWBUjBqKIHZPZqt?=
 =?us-ascii?Q?i1Da10IkLnkA7nPZNqFhzFjdCmhc5rLmXV+y6CQzCqpbLur/1xXIuadD7X64?=
 =?us-ascii?Q?Nv+b3lpaI29iREfnOaQ4D20rHa1fZuFtkaLur4zP9UrnQWtOxkW6635H/4P0?=
 =?us-ascii?Q?V3Rb6xHwCPab9vao2+2jQ2XYyaG/m+NYnIL0rx+JsQCCn8t4IlveDgDJvnPL?=
 =?us-ascii?Q?BKUPzI5S0yGBMJrr6bm2RXQRuU5pUXo/VUVLzB1N64UwM+kNj3O0h111tZfO?=
 =?us-ascii?Q?czyJg7n2zTf1J36Fit2JxYbY2LwXOnZ79+543i0MZm4f4lmMLRVRZealbg9z?=
 =?us-ascii?Q?mc8+2ZCw58Yb0usUzNfhL9+jrk7EOcm3tKDfrwEbvfJln1Onm5egGVnK/M2r?=
 =?us-ascii?Q?mx1HkEAmRNxe8+c+PMLMdMUaEKPmXXTCBQ21OrsTQZUysFi3OVw+fb1TSM8R?=
 =?us-ascii?Q?yDbZ9mfarHosOMBRG5dn1U3fySjHr5okpc5JI7/WmBjz5d3anWbTfmf+oMSf?=
 =?us-ascii?Q?CWOhne3qKRvSocYsexO3TFnXWtL5+5WTIJk91F0fZF9dlJLg/ec94rnFZm/b?=
 =?us-ascii?Q?XtWBtT0KTUY9llLkuRukMn1onE756knNH4RZhOHjRUdlhMLHIGtJjTKFYgjq?=
 =?us-ascii?Q?bbXKyubxBuK42t23C0A/DpCt0dLybfLZ/u86PaMhxK3+LuSh4ONbkyMYcZN2?=
 =?us-ascii?Q?svh50Bkeju97yr1hRvTcs13C08b65gXj+5/wn6kUxOA3fPyrJXOMX4MySM/t?=
 =?us-ascii?Q?f7c8D0EkefJw8J640IDTZ5VLfCFGnazUkC9UpNAhMEuzRUDLyRiA1h7l94F9?=
 =?us-ascii?Q?9naVSiyy9CWN4NW0vG7kMF7dTQzojScUNRk7QM2Yzc2AGXX6dsFR4V9vUzZC?=
 =?us-ascii?Q?TrPouC+NQiYFc8FyCHi9mX6Q6OzibrrQyxSRgyTeFLiZjfAUeCu8qSFTewy6?=
 =?us-ascii?Q?EX/YMcQF/ICjTw6L7rJjtByX6VA5pQDeCDaSV1XJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82d310c-5b6e-4861-1450-08dde2f72a61
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 10:15:35.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /akYXPgPjK1x85/ZbFkRumeqsN0Bbnzcs0sxb74QdDcZb2h0A1eb5YjTJArwuldvy2u0MPEagJK8noZ9FLGrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887

On Thu, Aug 21, 2025 at 04:06:57PM +0200, Guillaume Nault wrote:
> By the way, do you have an opinion about converting struct
> ip_tunnel_key::tos? Do you think it'd be worth it, or just code churn?

I'm not sure if it's even possible. For example, on Tx, some drivers
interpret ip_tunnel_key::tos being 1 as a sign that TOS should be
inherited from the encapsulated packet. See the script in [1] and its
output in [2] for example.

On Rx, drivers in collect metadata ("external") mode set this field to
the TOS from the outer header (which can have ECN bits set). The field
can later be used to match on the outer TOS using flower's "enc_tos" key
(for example). See the script in [3] and its output in [4].

[1]
#!/bin/bash

ip netns add ns1
ip -n ns1 link set dev lo up
ip -n ns1 address add 192.0.2.1/32 dev lo

ip -n ns1 link add name dummy1 up type dummy
ip -n ns1 route add default dev dummy1

ip -n ns1 link add name ipip1 up type ipip external
ip -n ns1 route add 192.0.2.0/24 dev ipip1 \
	encap ip id 1234 dst 198.51.100.1 src 192.0.2.1 tos 1

ip netns exec ns1 tcpdump -i dummy1 -Q out -n -vvv -c 1 dst host 198.51.100.1 &
sleep 1
ip netns exec ns1 ping -q -Q 4 -w 1 -c 1 192.0.2.2

ip netns del ns1

[2]
# ./ipip_repo_tunkey.sh 
dropped privs to tcpdump
tcpdump: listening on dummy1, link-type EN10MB (Ethernet), snapshot length 262144 bytes
PING 192.0.2.2 (192.0.2.2) 56(84) bytes of data.
13:11:02.742405 IP (tos 0x4, ttl 64, id 64774, offset 0, flags [none], proto IPIP (4), length 104)
    192.0.2.1 > 198.51.100.1: IP (tos 0x4, ttl 64, id 21845, offset 0, flags [DF], proto ICMP (1), length 84)
    192.0.2.1 > 192.0.2.2: ICMP echo request, id 360, seq 1, length 64
1 packet captured
1 packet received by filter
0 packets dropped by kernel

--- 192.0.2.2 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

[3]
#!/bin/bash

for ns in ns1 ns2; do
	ip netns add $ns
	ip -n $ns link set dev lo up
done

ip -n ns1 link add name eth0 type veth peer name eth0 netns ns2
ip -n ns1 link set dev eth0 up
ip -n ns2 link set dev eth0 up

ip -n ns1 address add 192.0.2.1/32 dev lo
ip -n ns1 link add name vx0 up type \
	vxlan id 10010 local 192.0.2.1 remote 192.0.2.2 dstport 4789 tos 0xff
ip -n ns1 address add 192.0.2.17/28 dev eth0
ip -n ns1 route add default via 192.0.2.18

ip -n ns2 address add 192.0.2.2/32 dev lo
ip -n ns2 link add name vx0 up type vxlan dstport 4789 external
ip -n ns2 address add 192.0.2.18/28 dev eth0
ip -n ns2 route add default via 192.0.2.17
tc -n ns2 qdisc add dev vx0 clsact
tc -n ns2 filter add dev vx0 ingress pref 1 proto all \
	flower enc_src_ip 192.0.2.1 enc_dst_ip 192.0.2.2 enc_tos 0xfe \
	action drop

ip netns exec ns1 mausezahn vx0 -a own -b 00:11:22:33:44:55 \
	-A 198.51.100.1 -B 198.51.100.2 -t ip tos=0xff -c 1 -q
sleep 1
tc -n ns2 -s filter show dev vx0 ingress

for ns in ns1 ns2; do
	ip netns del $ns
done

[4]
# ./vxlan_repo_tunkey.sh 
filter protocol all pref 1 flower chain 0 
filter protocol all pref 1 flower chain 0 handle 0x1 
  enc_dst_ip 192.0.2.2
  enc_src_ip 192.0.2.1
  enc_tos 254
  not_in_hw
        action order 1: gact action drop
         random type none pass val 0
         index 1 ref 1 bind 1 installed 1 sec used 1 sec firstused 1 sec
        Action statistics:
        Sent 20 bytes 1 pkt (dropped 1, overlimits 0 requeues 0) 
        backlog 0b 0p requeues 0

