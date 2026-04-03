Return-Path: <netdev+bounces-274975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJQgMiWPz2mmxAYAu9opvQ
	(envelope-from <netdev+bounces-274975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:57:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6F3930EB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C89573023D9F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F86279DAD;
	Fri,  3 Apr 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EjjZdOcS"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5D397694;
	Fri,  3 Apr 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210211; cv=fail; b=prAqZqrMmU1U2z921ROCNxnvO3hrbMPaxTjt1MMBbsw7xldVUsLfyM9FY3Rhsz9hQpyCScblfYjowTUhWXIb4KTC9Nd9rW8g3ucBYiaEFO1O88uP+Lm2JFdKt117DYBjOEuoS7nI2EXfnlKXIEKU9Emvy+we0thhVnrPI9O4hls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210211; c=relaxed/simple;
	bh=dUOE+A3ZF64KYQA5eiNPQhtFU+848elqHlv0N3kndbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNwUbcX0/fw0p2FpdScg9XDww4F63K86kwCVXqYj0AjJD0RXD7ie1rmnklokfB9T/UNdFw7KuEVB6j3H3VJgbISp2mhzi3vJBbUQ1p3GiH7Ied4zuOKA21Qg39cRitq8hWGDPS828h/hzeX5iimELd+33+Wu+F6zklMxoZxbzOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EjjZdOcS; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq7aJPHNelb9E6mq4PxN9V4kVcydabaGNkd5h2u/VRcAHJmvzmjTt2zgxyngd1QaSzAMJy8EcUiEyzjq5t7aPbayvlx9q+100Sd7NiPiGYfTzsKUJKm1mNIqF/woqaFOI5gbcN7iQA8SuXenx93DEWf0TdofgFsFOT9LhT6xv+nGNdfqc/fJhbhMMZ/NL0s0ZiKZ5jJcRA7iQGLQ9fp09F0pNIkgpXPNbWnJCf12tZutCngz64+KS2Vi967g9Gf2WK7guq2cdkk5LwdUIGmCZActJVAh45hOnxNGHG/IkFtuPp8ZxUvKb7g3i/nxUgezJY1sLp03Cbn8X7pBkvt/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzxX+pwHU4KPonECuRk13YVR6oijexhs/wEvnCyItqU=;
 b=Cs6Ls+Jtr/CXMq//JinoepIYUV5tg3TPu/C1VXpBQXK2rbjianvEUut42jyDv8lptRSx8AJMMaMAKrWUQmkOpPmQB1GQOOJ/v4sFjOB/qsRJpznsqi7cmbZSP+fI7oQ3Ywf+l76G29VqS9cHmfJVbIlvU2bThSyuLMPx+NfyViyTpA6k9o5rWYJZdBaBJgEHIOQsXvNvlGjgo9x/CDikmH5WXA91vlCA3NruAHCj0T8pimLAkHY0fTRwmMJPD1YwthSVAUK/lP63bb/E0yS7SJ43RRU2rBNO/VPwidjD+PfFFvRxTRfcaViSNjB3M3wn3hK28ASUnvbHkMFZdXEo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzxX+pwHU4KPonECuRk13YVR6oijexhs/wEvnCyItqU=;
 b=EjjZdOcS6fUUQT+lJ+sTKvlw2hWDHxwwAtF4weV0LdEwL/VHpMQL3LeZq2LX1mEh8tHRayVAZ9dF7lH2yPKzIGJX85MtgmXjQOo87y+TbiFk94n7oAGoIOTM38+ARW42gK5aAuW8ojRofH8wGjuzq+MNfILbR5DIobLM0EGdCfHaWeWG+x0obdfiuf+T0NJMAqTCHWbbjTyZZniCxDFHWjrjLlQ8bSUq6oaIpQLUlaxItx1xj8DqWkDOq9GcolAjL+FUSmd8YILPqBufoSRoS3dWrA4hKM/mKm2dssnumTM8Mbgh97W8s3MljJ8gZDhGmoZvrAjL+2kCYVFuh8HVvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 09:56:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 09:56:39 +0000
Date: Fri, 3 Apr 2026 12:56:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, petrm@nvidia.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL
 vlan group
Message-ID: <20260403095629.GA65129@shredder>
References: <20260402140153.3925663-1-yzjaurora@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402140153.3925663-1-yzjaurora@gmail.com>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db2f7d0-c108-4442-d676-08de91674ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gZ8xPir8vfYhA6PTGOXV5IZbwJ5D6CRuYKRpVNkOqCjaA+aVf2uOt9RbJEWuJqE0zJGiUyh/ggHydD8CY/v+MT+AUzcar80wVH/B699F8uxr0F3MsEBR64gg8iqqAajHnsGk5LqubasOkpupGPb6uKjmKO0sIh24/wOtF8eMtKUfgG2pQw2c+ZNGqP5+YCLDQxeYFXWmm5iFD6SwTfYnIjFO/fwAl/iHdPOcGdNKriBAmNrT6+qzgeFLxTEM++gri+fhR1n81VmFq9RtNoft/bdMXjerPNjzSKPi0adwc9j5VfUyKb0xyZooInZ4uITXZw4/vj6ARmF9wTrCk2DYimZ+m4CArLE6JNTe1a6XJzDSnWR6C9BOpeoToadOGhHNdUeg+89D4nHWQefe5fjYxavS/4IsjPkldOPsrQKD+L4eJbv/qN8z8Ybwv3HRnqp4EutAasd7bRr5y2ePYDl/SIo1zFPL6lNHLIIMWBtxz4ahKxPMMV1Jj4I5Y7NKHjch5T9/Pu9izRTYFO5auSB7EY4RyNW4Tpa67C4XDGQRc0zxBvD2XcAfr/BdLKHqOuAZKKAowMC9z2jPegUZTHX4fiTl7bXnoutGMaqDyUvXf+AsPBmN8u2/EhREHyyDdMjl+a0jI90e290im+XDyHf5S5k85GiIo7WruLboN7FdQwHH7QLx8MPhW8iQh9VaL9smEIl0I3RwNPVlKgItBcqHfmi25v/WE8OzsuAYLRLTQZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVAOfMiQjvd2PaPNhm+F8vUvZUBm9OPHZEw6ZrBdHD7CUijp3OOtw6fyTFEn?=
 =?us-ascii?Q?/m61vFVbDR3W3xzXBe7VJlj4BCYqQjFR8UUufA5wS2Bu5d7tfbS3Du4Izd8M?=
 =?us-ascii?Q?cdgR1dR6X7hKWykkpE3odwe8tf/Qj0jKmoIkxGJ1MjlKY4B8AB7ZpN/iv6f9?=
 =?us-ascii?Q?eVeLBUkwq72Xm8PO9KASJpp8UBXT6WhLpKTWk725NnakXWiKynH8NkXmx1b4?=
 =?us-ascii?Q?RRt8XP53BLYsSSd2PBbiQ1l3624vidAtNptAyJJq4S6i4EHNGQC9jeqU8k7I?=
 =?us-ascii?Q?QwhZJnm1zYwZjE0UP2Q4wXWj+sHDS5MnqpYctek+LLfl+KE7UUfSDNWBCKS9?=
 =?us-ascii?Q?9JRa8kZBCzdBnwAdNJnN6W7xGgHHYpaYIf7kRycjowHPLpQwureGrsg+pbmZ?=
 =?us-ascii?Q?HOLVY4oylIy6hSMsc3ClV46ZszEOb5Jn9DUchg5A661Gr94beyzWNPJ9BaCL?=
 =?us-ascii?Q?0GCh0j8dA3OKqGIu/4x6ql3EMW4fhHU3m2Ue2k5jD4keA8HMJQ3WZrlEuOon?=
 =?us-ascii?Q?LcMrPmFm3VOENEdlQQN1APiKb45JFbngXw0+T5/y9gx2thZ1z0viBrlUiT6I?=
 =?us-ascii?Q?2MC4YY/H+7axYS0qIM+DjAD0K+4pK8dOQQ8x4zAbW9g4YCteBVt177nkT1Lz?=
 =?us-ascii?Q?Ye4DB/KSy/Pqo0p4YrLx3pndTbhveYXFrp/yhR/9oGNdTJCYaidHqM5sqHLa?=
 =?us-ascii?Q?IuMCwCMTpH6Pe4nYcg5neEJ2SJvk6w02Yt86WT4Za2tn1vXdHxXBQ4r1Q8mp?=
 =?us-ascii?Q?RN/PvcGXXK7yDbjqUPA3OsZjQFQeqeJC475MxmYJywnXqH93zAIfHVZ4Bl9D?=
 =?us-ascii?Q?7LAROE/edsj1hsIl/NaNGNlBtDSLg3Q7mSPlngS3KSNSXF79h365ywHBY/3b?=
 =?us-ascii?Q?qISNtGfh3/lFvg/xHw1FQ/Ak8aEb0GiQwJ8dYHkJ84V/DwErz988LV6cSbbi?=
 =?us-ascii?Q?mk2WJiR8eQiLvtiVMEHZsvspegKBjTPxn4Rnji9vXEYygZHtMKe/de69D3uk?=
 =?us-ascii?Q?n3bg2bZ2xc7W7EvShoxc0H7DBKwZDhPMXmfV4FV2NaltDuMdp2FFuCRHMa7z?=
 =?us-ascii?Q?vpjHBJbiO+cCwmxgG6My6KIOpIwG9jBHHu1lLsXUCNXTzbgOAPQf5nfvM0q0?=
 =?us-ascii?Q?pkPvjFORriTiNWhsuLhUcDX0BBgk78foQ89O1qnEQhCcq0L8jIfOVKOMGudl?=
 =?us-ascii?Q?jCOyUvfCjJojaifZSW6IYCS00kh2ftp4N3qVdK8P7fddoYo4T0QZ2Ck5QB7W?=
 =?us-ascii?Q?sMID/pmH0DGcl9jcV7bBu9Lp1SkeLHNi/hp1Or5Ez5luwQYDNpeqJHZDrZua?=
 =?us-ascii?Q?rHIlHBY6dYrR+/RBCBdolBjcsDvP3Le0YiltSdHCPos2Mj1ktpPg/x7C+9WG?=
 =?us-ascii?Q?pKxJ7TggAJROVP/1C4Ja5Ob2ZVXrr3nFRx5CaVv6CdFHeOi5+nN6350Gq0Rz?=
 =?us-ascii?Q?DWU8tbBF4xLSfyPbVy/1LtUIHuwR6uTPUsVPudlcAZrByJp3omXEqmK1oyEy?=
 =?us-ascii?Q?zcvtRIIozcqghMmHweGytHBKy58CDP3OwbkUlO5rkmJSlNjm3sLrvYckpijy?=
 =?us-ascii?Q?fQTGCj0Mz6S8Wnj8VQtg0BaGWMJukxkWD3jWzAYV8rg0IYIXLR7uMNQl5FYV?=
 =?us-ascii?Q?SltF6etRC2ZNcvOhZrrVeSKnNpQTZDcBrKHzPZ9Gw7Q9+Rzum2vOhexDX8M8?=
 =?us-ascii?Q?yog/e5OuH0M1843O6c4tINNL+v5UBb+frs4OiDS6pntudxZ1bGlYRbJbxaih?=
 =?us-ascii?Q?9mHX9HoKGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db2f7d0-c108-4442-d676-08de91674ce6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:56:39.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnZWbwurDa/Y8gSOii47qkHkc6h0AjyFoCNDBKbI7FkZM5tybEN6+2qXfVQsMxd65x/QDJ1eGToGGAmVhjZZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274975-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 43B6F3930EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:01:53AM -0700, Zijing Yin wrote:
> When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
> nbp_vlan_group() return NULL (br_private.h stub definitions). The
> BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
> reaches br_fdb_delete_locals_per_vlan_port() and
> br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
> is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).
> 
> The observed crash is in the delete path, triggered when creating a
> bridge with IFLA_BR_MULTI_BOOLOPT containing BR_BOOLOPT_FDB_LOCAL_VLAN_0
> via RTM_NEWLINK. The insert helper has the same bug pattern.
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
>   RIP: 0010:br_fdb_delete_locals_per_vlan+0x2b9/0x310
>   Call Trace:
>    br_fdb_toggle_local_vlan_0+0x452/0x4c0
>    br_toggle_fdb_local_vlan_0+0x31/0x80 net/bridge/br.c:276
>    br_boolopt_toggle net/bridge/br.c:313
>    br_boolopt_multi_toggle net/bridge/br.c:364
>    br_changelink net/bridge/br_netlink.c:1542
>    br_dev_newlink net/bridge/br_netlink.c:1575
> 
> Add NULL checks for the vlan group pointer in both helpers, returning
> early when there are no VLANs to iterate. This matches the existing
> pattern used by other bridge FDB functions such as br_fdb_add() and
> br_fdb_delete().
> 
> Fixes: 21446c06b441 ("net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0")
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

