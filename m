Return-Path: <netdev+bounces-115755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8298C947B0C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5ED281831
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A121E49F;
	Mon,  5 Aug 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RD3gpa5X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB918026
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861295; cv=fail; b=BSJgyGd+lssCi9DD2dhwWR98eyXxKJuJGep1G//RrQLQZJnddclWQ4AhzP99OtxLh+wtrWST2pK3VxrJuUeUqbjhAWXYLz18ddxOeVDz1DwhAvxJ/6VAzHnk8SoFjbwN7bE19FfAv2Nn83S1YI21xqeLKralzLp0eDfSPy4sN+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861295; c=relaxed/simple;
	bh=yTDa+/J6Nujl9/Mj8dELlvhznQ8TEIYO3LnfMbuChno=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WwqBYEMwIYaKQ5r1WzT2+5/8reQAIMXdCG7/dgoGK1NAMpxhG+DOjkeD8gpMR0ftFYGcnfTf9BnzW9fC7jIOU5yY+5Dt8w3aaqZ/tDd9NiHh4hVIdSvtAAcMDlh0rQzf3JQmN4+6xmznJfRVnqirkeVS6xhoRu0B8C0Ytq3Ktro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RD3gpa5X; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDKVkedNBNUXypPkpze9YVSOeYh/kAN4Aa7mHYcnqeK/VdJkYFmdbRYfXFiC6+dNZ3F9JbLI0X0bdrvGR43S5Xqo8mSzmZUNf5LpIGBoUAR5xA0QQdc1XbKSxLbJ05tbY3lscXTUs1nMaSWH+isaICo1slFTFY0AftD+I2UHBg6Yj6JV72Qp/TJPo1ICWGtf0g/5L7rsIM4Xui19LyDIK3WDlia3oCjG7RLhHjViOroOOa2yHvk9ixMBGwV9wyk15PvCfBu5OAIMbzoSLWn74TkWek7haaCqDI0gOrEXR8j+Zb4yNju/RJS9/11eC1jXqPr55/hS1ET4j3PloyGPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtOgS9Mw0VBPucTe9z5gfqFfPr6zpjayMIC18tLKPOQ=;
 b=wOCO009Bp5WO+KS9kr7veebPvlsJh1psPeM2AxUl2iELxjyjcvK2N6AZyKaHeARlBUZZ6khni6SZM+WnM7nw/JPc+eCWxmCzDR3RiBVvcA6N5tubsFyc11hjfvbSiT+Bi6yJr+IfQZ2CCY2RxIpwLYBGmY+bppr03l7k+uxKM1iZ4pzXA+3myZLQsSTio0liWU9/r4kjlwLpoYP4+1+nyp4tpKamU1mfkJHYR2CGnnYLukTecrZ8PEUyOUyyp4NFpYetELgT/ASbyIDNceQ6+OC0PUQ7BPEuD3fc3dwxNFvP6KVwzK4/TQSnXGQwNb2f17KML/DleSCrvDLaSlx6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtOgS9Mw0VBPucTe9z5gfqFfPr6zpjayMIC18tLKPOQ=;
 b=RD3gpa5XmCwvUaEMiMWdGABpmqK1W+d7Usvqzgz5aHlHb1ZO8lrNcIpw8e4kMPXYrhxV1D90hGdnlCaNAgauvRFmiQ3rgaaCipudxxLLhhYwa1oSDmh9jSkfWuVPbVWLyoq3mRo7oHHLAOQWxoBOS7pHE0o8YuNi0q893g8SgILnfyeJCWLh/t71FWUqUIc401KqwPijnXzd7P9bqOwoqAPY8dlGViybgPcYkEOs6ToMxtktrBLdS9GrbF2fgp39VfLvJB0DqzusAcnVs7TZjAkbXpVy2S7rAc8RxXBri+42esRtlF/N1Qprh86wQvx7TActkSroMopYIdFPgXVMSg==
Received: from DM6PR05CA0048.namprd05.prod.outlook.com (2603:10b6:5:335::17)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:34:49 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::2d) by DM6PR05CA0048.outlook.office365.com
 (2603:10b6:5:335::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10 via Frontend
 Transport; Mon, 5 Aug 2024 12:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 5 Aug 2024 12:34:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 05:34:40 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 05:34:35 -0700
References: <cover.1722519021.git.petrm@nvidia.com>
 <e0605ce114eb24323a05aaca1dcdb750b2e0329a.1722519021.git.petrm@nvidia.com>
 <20240801193928.GC2495006@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Donald Sharp
	<sharpd@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/6] net: nexthop: Increase weight to u16
Date: Mon, 5 Aug 2024 14:33:45 +0200
In-Reply-To: <20240801193928.GC2495006@kernel.org>
Message-ID: <8734nj5esp.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebd52eb-fdae-44ea-2be1-08dcb54aff21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llOzJ0vQsu6XXbBLr5muwrQVIxxYvacp/XA9zMCCdmCjOyRZHqibaz2t4XYL?=
 =?us-ascii?Q?t5mzAJANj4c0HmNfME732iAxLPdwiY0MunkVa+hO7FIfSOUvWaLvqS0F6iFp?=
 =?us-ascii?Q?XCBx6+It78tRqNdlq08etC3nc757k49l/PLXUQWzq2BpV8xnqauSe48bRZsG?=
 =?us-ascii?Q?DkoAFsUaHGnvqph697dHx+PShL2YGPh3xMPRGjPFsQAw+mdD4kkiE31kjRU6?=
 =?us-ascii?Q?HquXLAKWKstOO/p/O54PxsY4M6vOetTh3uY2kwQMRGZydmtFYSK2LfIm8kQ9?=
 =?us-ascii?Q?4B3uOOBuTgoL7NlDHlqj7W9G83VlxBUBXSkN/kQOQPkqLFYqjYzHVXkxaIqf?=
 =?us-ascii?Q?Lek3MH3x1c0gS7nn5FhVoopSWy7U6kmmERfSEockOFTy4ZZfVn8/zBqC31D8?=
 =?us-ascii?Q?OXa75lzPtOeUM6cc8dQUMLlnhQ+17YatCfy2MoMAKF6GatdIbRpctI2WggJL?=
 =?us-ascii?Q?U434GkSBnbBOibQkwZrbIApI3zCo0hvrGG3QxZSW1rO2oBXK9XwksqadY8ph?=
 =?us-ascii?Q?UXL8vRce7pICSCyt/VVj2O/mOlxDNEcoQtCB5hX3gVsFu2uxNaIONZn3uRL1?=
 =?us-ascii?Q?oancv2xW7tlWwFS0UBruh8l74p+CS8dAriM5pbJq5tRUNAa/AVZ7XThafWjt?=
 =?us-ascii?Q?LXGh44QXNlHW2EgL17LHkP6b7Qzd1eR95hmw5l7XYuBG95svgsfCnwwrSESa?=
 =?us-ascii?Q?W6IkK9PQa/PECIYxUR8F6lNX8gJmrHD5/SVGq+qPZEdB1kqOZZhh0vsPUaJ7?=
 =?us-ascii?Q?yH00p/et9jxEIchOdbgSOBwLGmnosRenbg+NPQLA/Mw0QCrr/Gd9MoXWmBUu?=
 =?us-ascii?Q?WWOBunqBKo27QnDzeBgAc0rWuAryDxldpNL6rsu8v+Lm62zSukaKOClq+47w?=
 =?us-ascii?Q?6IVEydf6pf3Yfw3L9VMDzMXgvldGwHd2u22fWdop6fVpmzyBlnU0lAPxHYfB?=
 =?us-ascii?Q?VYSyB988/jUobBg+/VnytzSsyc3VJ8SkT6Kv136lq3cmwNMPHs9yLqSFGOyN?=
 =?us-ascii?Q?YAuShrvGRBCBN+Vc7uJeavGhyZjdyW42DxWYEyM4fVSo2imA6V76G/Zi1cIr?=
 =?us-ascii?Q?J+qtKE9RxnXbzOpEfM25erVdbKM9mbR0Yd5Jr3J62fkX05LSo57fPy5otg6p?=
 =?us-ascii?Q?eKSNCZfe/kwr7LS8TsDqeEWLpF8NXOq4x7qRxnwdtvL/hxCB2rtxDkmjp69+?=
 =?us-ascii?Q?ynMXyf6Oki5p0TzzKzWPe5N+FIraZp+eBm+hMvw8KbOHJEzVqC1+WNqvYqmA?=
 =?us-ascii?Q?qwO0xfFTpPqupn93rIwSCk51Z0dmaYEeT3OwGy0WFno7Y5qoUuhMfywS4bXD?=
 =?us-ascii?Q?GEzBCSzwE5YjgZtECp7iuwGkko/2UyuyFBPagw7tVTNTb7jM1odC+Ant9B/m?=
 =?us-ascii?Q?bX42dI82OhmybuqOMvJmIMwaMbARBTlQQ2QL0npqoVbXLExYbv2Piejq329T?=
 =?us-ascii?Q?y9jcM0LJsPWW7Ms6PUqQdTtR9n6uP5Wp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:34:49.0620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd52eb-fdae-44ea-2be1-08dcb54aff21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352


Simon Horman <horms@kernel.org> writes:

> On Thu, Aug 01, 2024 at 06:23:58PM +0200, Petr Machata wrote:
>> In CLOS networks, as link failures occur at various points in the network,
>> ECMP weights of the involved nodes are adjusted to compensate. With high
>> fan-out of the involved nodes, and overall high number of nodes,
>> a (non-)ECMP weight ratio that we would like to configure does not fit into
>> 8 bits. Instead of, say, 255:254, we might like to configure something like
>> 1000:999. For these deployments, the 8-bit weight may not be enough.
>> 
>> To that end, in this patch increase the next hop weight from u8 to u16.
>> 
>> Increasing the width of an integral type can be tricky, because while the
>> code still compiles, the types may not check out anymore, and numerical
>> errors come up. To prevent this, the conversion was done in two steps.
>> First the type was changed from u8 to a single-member structure, which
>> invalidated all uses of the field. This allowed going through them one by
>> one and audit for type correctness. Then the structure was replaced with a
>> vanilla u16 again. This should ensure that no place was missed.
>> 
>> The UAPI for configuring nexthop group members is that an attribute
>> NHA_GROUP carries an array of struct nexthop_grp entries:
>> 
>> 	struct nexthop_grp {
>> 		__u32	id;	  /* nexthop id - must exist */
>> 		__u8	weight;   /* weight of this nexthop */
>> 		__u8	resvd1;
>> 		__u16	resvd2;
>> 	};
>> 
>> The field resvd1 is currently validated and required to be zero. We can
>> lift this requirement and carry high-order bits of the weight in the
>> reserved field:
>> 
>> 	struct nexthop_grp {
>> 		__u32	id;	  /* nexthop id - must exist */
>> 		__u8	weight;   /* weight of this nexthop */
>> 		__u8	weight_high;
>> 		__u16	resvd2;
>> 	};
>> 
>> Keeping the fields split this way was chosen in case an existing userspace
>> makes assumptions about the width of the weight field, and to sidestep any
>> endianes issues.
>
> nit: endianness

Thanks, will fix for v2. For now I'm still waiting if there's other
feedback.

