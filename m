Return-Path: <netdev+bounces-185437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB6A9A5A5
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974811B83F9A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A5207A2A;
	Thu, 24 Apr 2025 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uHDBJdDG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27020D51E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482737; cv=fail; b=sliMcwq5e4epQsA9FwETp95U2nxJjIVaIru+3xpj9GOhJAASazwX2bPFycP2ChNgMfoRozj9vseb0/6SW5HhsKvTcGySNNCebQYe5vTWTjIYWBN9zKo4TxAWmVXDeZfobh97ZDf5y7U9438b9iWXqMDFSoc2Kpvb22cTNNwgNlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482737; c=relaxed/simple;
	bh=h5TO2Z+icrm8UU+gUjiJxsZaO3/03gBa7Bb9nraNKRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHJZiruLEKSoUR83ArMAOnctACWvC2nD+yvT192On1XNrjbCZboD0TedjkryplKkpWtLzEYuEhwvYF6kcSG0/F/KL9EBvpc1L0rJ4tfG8MyLEQ+xe8/VUyUe1l0L36a9dyy3pBWzgjOWc9DYMCPsR201L1R/C0Zjz+u6Npxsrts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uHDBJdDG; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZah13mfo8qOBfhGNqgyqjTr0M0SSBNwWa022nQNqS0ZbxLxzqUKnePBq7vJba1vGYWDmWMzpdQ4/L+CwVyCrYZECa50tcOcBNNrT9+PT5kuUEIR+wDCHnzqeLepBtPrdVfU7301ifWh6o52yIpWSpAO8Lf0exWPMiF5oMPYYApf4+jwuva/epoTY25R0eh/1PjPeXiKm2oFz5/ILVlj7lH2UmATFb68qGsxnYO78Whux99lxkJg2o1/3E01GKAUbqQ5/WcPiHd+oBqFSgPpJXMxqZOsygNXFYGqY2mhXXsDmWEAtcqEW6scXCCqWmRGPosMnTyaxGG3assUdW3c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzFieiz9r8HQU4jNU0gwn+/BFKhMtdQNTqLZDRjNhrU=;
 b=ntqf37+2ScxvmlesknbB6ccP7wAhNjGwBAvINp4huTwMOF4srOCvNCBCl3tKm9V0yXYb8rp91TLRLU1eMcnZMRFGKQW6nbZfAXskdTYG1rTe4Lyr6Ho/ZycXOILzqxN2DOXPM+0sH04kC8blZIYFQ2cc4/MVeLx8bdpwKv/EkKXqEVfM7YBDYY0PT713PUqGHIzhZRu5b55jNW1PcUi9ZLdXSSYIFaA4IPyKSOMTkBvG9CN0qVk8gZ/4YdyGcaCEfFEuNP1RIMUifXydo72++SyMQbx2tLlPxaMmgFQUs8GLks7BqzNd1pYVvKU98jzuEgth09CFuYAvMTQziZr4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzFieiz9r8HQU4jNU0gwn+/BFKhMtdQNTqLZDRjNhrU=;
 b=uHDBJdDGkkLBxbEAD4GHrzs8cXezfQq7DuS7LQCZHbzC8EhKqz3ADroZIGdDl0VqNLERP7Vl2Dx9Am5caW/QggBmfe3Q2HeSPm8O8vHjHiLSXeZD8nH7HbJyFnT93jJRzDEarfzDWoiQuyBCHjcL8DtcK7SOW0LHxHc3rHbV8rlxYsyjlIUeRqtrFqGLCPhExml2rTRo3TIE4qosUSWOsbtPub9bMrh/F1/vPLjNaRq1MvdsMHB5TTQFDsVamCqcuAiAQQ72Z9zFWmVvbp/Gi0gQqeKQNAcWMhnI1M075JFRefryG4ufMcH4UAuw9/BPR9aYNZgjAlHL2j7XavEs3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 08:18:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 08:18:51 +0000
Date: Thu, 24 Apr 2025 11:18:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	petrm@nvidia.com, razor@blackwall.org
Subject: Re: [PATCH net-next 13/15] vxlan: Do not treat dst cache
 initialization errors as fatal
Message-ID: <aAnz4J1CkoLw518t@shredder>
References: <20250415121143.345227-1-idosch@nvidia.com>
 <20250415121143.345227-14-idosch@nvidia.com>
 <2c7972c1-ffcf-4d28-83ec-1dfe5dceb8d2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7972c1-ffcf-4d28-83ec-1dfe5dceb8d2@redhat.com>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffb4e1b-dda0-4c62-5c25-08dd8308a52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Q3dvi8qJM5k85+nPOdvWMK1bYur9n069stetw3fsTzrTggCKHgmxtNBRMZD?=
 =?us-ascii?Q?YNFUcjGRD/Nnzwisqz/limnBEZWmYQ+FYf2ErU+PuwweD3zA3vQeyTWlEilZ?=
 =?us-ascii?Q?eC80ZmW/jTFSDyvx7DdPu4kK4OkT+wzgRFXXV9Vs5hByJqyvrKqobbZmPR7l?=
 =?us-ascii?Q?hvTDEernv1EWWnsbeUciX5sSpJrOT90E19iyWYM4ADlBC/aw48EyQ9Kep1Uu?=
 =?us-ascii?Q?Gq4TOtPO0bvUg7ZDyRbwPlE75z7XkzgEmYHYQoRaUT6bDHXMj100uyyAXaaF?=
 =?us-ascii?Q?WEWXRFbD+5zoy0pqnZ06pqL7ZnGW+uv5wDCLcEKjEKD3QEP0EpO6IBrkkePN?=
 =?us-ascii?Q?DAm+Eybs2b32FIjMdi6OS9AAlQstfGra0MfCWOTPg0hyzDaRDfb5gECPDcNZ?=
 =?us-ascii?Q?QLWaTlQO9y1OuAIbPfFHHyOpPM3AMdqnRdY7dIcILAMjsg4j7CtrNGnFOu/A?=
 =?us-ascii?Q?RpmCDXvj4YYRViIDkUzELk2rO7xXxR3knv3rD8CNLwdkbffWj2i3pApD+R4q?=
 =?us-ascii?Q?whj/er6JDNXYH6ByY2qZpdeoQQ1J1KGoX7jV3aO6M7VbsA6x0UmeHoF3hXX+?=
 =?us-ascii?Q?WU/temO0Ar5my464lQG/+glQdoC6DvldY82a4bph/YfyALc4yPPRHNv9n/bu?=
 =?us-ascii?Q?rvzjheUjnM2McFj6m0MhncnrR68bdiq5RW1vSWNF0g9TpEZRQIt5XGdvGjv4?=
 =?us-ascii?Q?iqhZcbXGE4J40ULAPjolOg7sfC8NVEnXeNxRO6DUa9qIxMPBFRsrDu062TS/?=
 =?us-ascii?Q?3sC48z4XLBHuPCOEw0p/ZB0Ndp9cfjL6DM+grcQPyNbV8t6/03EMjXMtvi14?=
 =?us-ascii?Q?VGxHAEVWijR/vLA94oO9PMj8ww1jwG8teLBS8NBb8hC8SgqgfgtFx2UpBVje?=
 =?us-ascii?Q?cRi+aL/OzLZtynGGrwB0/qgf7Ml43YuBiVzI3lbiuoegtywUugeLfUGZLEj1?=
 =?us-ascii?Q?PX8Dejqxbj7BLGD/zraZbwEFnN7dWxrtsQNdLLL5uCouXWmAMqgPny2GZLV2?=
 =?us-ascii?Q?riSFZ8zhXRJ+/4k2CfDchBWQEV9STgjo+h4sczxJMYKo8f7u+Gn9D7Kpsrnz?=
 =?us-ascii?Q?9CMe0sIrV/mnfXFSZiGP8KHgp1qE2Q+MbOYp4TdA3qEQXIfVJdy6TiV6/dQM?=
 =?us-ascii?Q?WuHgWDLU69RzeUMtv41cUO78/wwnJ3hxz/Kgyk2jpfymgW67bGWhW3jk1hUr?=
 =?us-ascii?Q?EBhYPEUtSqqlK/0dVhf/t1xyzymlBipKsnZPySaG/oHRdhkw01ggzJNv1Ifw?=
 =?us-ascii?Q?qH24mR/GWLGhr0CVESIODd/PESzXla++3fr+cEhNvD4otjgKKIrKrGnqDl1v?=
 =?us-ascii?Q?OMRsyK5NQl66aWjar+rd5lS548DKi/mpG9y5cTas6wZuOmDz3HXPGO2ELlfg?=
 =?us-ascii?Q?EtY6h3vr5Ih9y+fjpxM6cA8tfDdS17as8/TSeEsSfLfeBEignYKVrlhpWR3i?=
 =?us-ascii?Q?bJjMs2xjskc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Tw2Ch+7kkiNmDSMUXs4UP/DiMC0mcDGW0Jgs9Hsl9uZXoudreQ2nn3dbBhX?=
 =?us-ascii?Q?6MwJgJ7cXuqcx88Ld/gta/fNz/BMq0ZYFKypLC+jY8XKYcHZCNfZ4POFQ+F4?=
 =?us-ascii?Q?KZKCZ62CLNquCkBzAtBzpP1kQbVQlvCdpyb3G4El4DQ0UJqA7BJ6A2ikjxzn?=
 =?us-ascii?Q?vxL9zyqeKK5JEJtB6shYXR61TRZ9Ov0oKiWPQTzUc7FTJg71OppUu1OrkMSD?=
 =?us-ascii?Q?xaGJ/tjUAoXokHS253em4hr5/4/QSXFw8wZNH2fAc6uUhorNmlpKFNkIleu3?=
 =?us-ascii?Q?WLRgXRXabbf7Buu2f/UhmEvKyQJXThTq4CbtDNH5YpZv+T1/yI7qh1gpmk+T?=
 =?us-ascii?Q?YAw3Lh17JhiuW6LgWhZFMG3UbbEdcVtUO7lUDNAPvd33LFjdtGuzYA1gbfPz?=
 =?us-ascii?Q?ooO2mrIEvp+mYv+Xs7c0BMd70u/qW1aN6tVuvKp+EQPuHIoikaQvaNjYovGf?=
 =?us-ascii?Q?RoJgqfiirZKw60d/tbS1//EddozuPcYORZ6jfUPXRr9hJ11u2zrsgYxpYA93?=
 =?us-ascii?Q?OSPuHZwf1yBvfEDnjrnjKHmd20k5ugIpmNdygRbxsxMSeg7Jyl3QndDRz30e?=
 =?us-ascii?Q?BopraAiCfAL01lbyF18TjEAat7gZJq+7Q5XfqoPVyt6VuN+liQrO/95zsXKy?=
 =?us-ascii?Q?9aUBTvFw4SPaivCaq1nfvL3bScn8zBFObRY0LvlOG4t9PIpsxrpfEQTleiaw?=
 =?us-ascii?Q?JTCCO9zViG/Sp43Chj7qUwDPjFhi4oD2gYt0HdQBZMO9hKo9y9xOEzGW1Lkq?=
 =?us-ascii?Q?MSYvZimn/13yBQtL4j7bC5M3Owna5F8mZfSHbTBC+ebRsyAco66z36l1PIR/?=
 =?us-ascii?Q?koM3MDjeGpbcprse7Ee+pkHdhc8hZby+qeRkXrNriHA06+6QEro7dXpWjPKZ?=
 =?us-ascii?Q?yh5Vq9srl9ecyWy3BUFlAfkVXgl1XacZomr0J5ozwLQCMSCHcf7fPaGuzLsg?=
 =?us-ascii?Q?U1Jf5IpOCLfc8TEFY/FBU9KBV9PgUYPtsZSV+g9U8oaMuKZQiKhbtrdJ36Ye?=
 =?us-ascii?Q?OvLoxUNg+DWWALAIzx8n/y0oXu69GjHVfhCXr5SSJpU4HqxP1zwFSbKJVtrl?=
 =?us-ascii?Q?NrS0uqNUu5+U6XteD1hzUMc/OSGhkQZlu6sxE8jPqklfKXmwMwJsDmdjUnQs?=
 =?us-ascii?Q?Tb9/mW8T1wG2D6h6uhubL/tGIFc3dmROOvHVDrIUu3pYB8zSl2lLJt0KScbI?=
 =?us-ascii?Q?h8cjbhjcL8vEl+Ql6eXJC3TdT/ScctR6QjNXtSf0u5xE2jrPvnE40CmU7Iup?=
 =?us-ascii?Q?ma3a0ITRnJl5tHixzPfhR48EduuyNLmbP70NktQfvgFnMM7HWDLxAyb01LEb?=
 =?us-ascii?Q?PsnvX5dT6MtB131mdUbw4w7B9gWzjR2DPCQpd5clBqGcZyBlUJPA7REvZGZW?=
 =?us-ascii?Q?+MFU1Bmp7kYxofhzCKisvq8ihFEUA0yismnwxxJ5ApGpFZIIGt6hYrCGknui?=
 =?us-ascii?Q?C5ijB2KAuEZ8GzElHb4X1lDQeivbnrzd9DmkypctLEyWOZ7jfWLCtiRXsup6?=
 =?us-ascii?Q?I3SA+giT6FM+rN31arHNBitYgN3KMF60Gv0wSc+Az9p/P0BbTC0PUfv657Gy?=
 =?us-ascii?Q?quC2gbDnvqXUkUaW4koNo7Ql0jzL83dRWfy6XL6W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffb4e1b-dda0-4c62-5c25-08dd8308a52e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:18:51.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9zg1J4kzdxgUznyLw34dBRtuHceOvEFw8gJSIpGCwYDSmGWRqPwRuDBSybQPB1HiFL/zhKfUOF11YFd4XEv0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632

On Tue, Apr 22, 2025 at 10:49:12AM +0200, Paolo Abeni wrote:
> Note for a possible follow-up: AFAICS, when the allocation fail the
> user-space will have no way to detect it, except for slow down on tx
> using this specific FDB entry, which could be surprising/hard to debug
> or investigate. What about adding an explicit pr_info() message here?

Are you OK with [1]? Using ratelimited() variant as allocation can
be triggered from the data path. Example output:

vxlan: vx1: Failed to initialize dst cache for {00:00:00:0d:02:4f, 10010} -> 198.51.100.20. Tx performance might be degraded

[1]
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a56d7239b127..a042d69b3f55 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -569,7 +569,7 @@ static int vxlan_fdb_replace(struct vxlan_fdb *f,
 }
 
 /* Add/update destinations for multicast */
-static int vxlan_fdb_append(struct vxlan_fdb *f,
+static int vxlan_fdb_append(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 			    union vxlan_addr *ip, __be16 port, __be32 vni,
 			    __u32 ifindex, struct vxlan_rdst **rdp)
 {
@@ -586,7 +586,10 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	/* The driver can work correctly without a dst cache, so do not treat
 	 * dst cache initialization errors as fatal.
 	 */
-	dst_cache_init(&rd->dst_cache, GFP_ATOMIC | __GFP_NOWARN);
+	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC | __GFP_NOWARN))
+		net_info_ratelimited("%s: Failed to initialize dst cache for {%pM, %u} -> %pISc. Tx performance might be degraded\n",
+				     netdev_name(vxlan->dev), &f->key.eth_addr,
+				     __be32_to_cpu(f->key.vni), &ip->sa);
 
 	rd->remote_ip = *ip;
 	rd->remote_port = port;
@@ -875,7 +878,7 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 	if (nhid)
 		rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
 	else
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+		rc = vxlan_fdb_append(vxlan, f, ip, port, vni, ifindex, &rd);
 	if (rc < 0)
 		goto errout;
 
@@ -1028,7 +1031,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	if ((flags & NLM_F_APPEND) &&
 	    (is_multicast_ether_addr(f->key.eth_addr) ||
 	     is_zero_ether_addr(f->key.eth_addr))) {
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+		rc = vxlan_fdb_append(vxlan, f, ip, port, vni, ifindex, &rd);
 
 		if (rc < 0)
 			return rc;

