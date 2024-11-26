Return-Path: <netdev+bounces-147443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC89D9874
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BE11648CB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58DE1D5165;
	Tue, 26 Nov 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lcgqpc8f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7E1D5140;
	Tue, 26 Nov 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627362; cv=fail; b=Q46sd6GuZU/EvVMhmKWcnjBeIR418F30MD/K21mZJzNoTxH7+kUx2FNTtZIcnk0JqpIP3gAvFmwHkdT+S3nQQJ9/yD6Y0tNKOOImWi0l5gRjhP8tdlqolzVFspl9LIufOxttyM94BqbRu9Xz44g2CGB0OzYnJ5jtEkwhAXXh9fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627362; c=relaxed/simple;
	bh=EMarhmV9hrHzxsdBGodQrE3rleSbMaYpD+DYTEEQRKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzDsL86TTqZwp7ieIqQh6Ytx+oqf0PFHHJ2gpY+bSZHROUjhCiNPxkzcyhHpcSDr3X44m/yuQUKIVSgJ0fMK6BBSbIBi+fh9cllefM6Z42RukTNbI2VQMoR+YGtpvd/2Ftn54Pzy+3p1fOSymlx/zfTP0YdNuTzrLA6TGxfIRZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lcgqpc8f; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPlC+ocmBsl4iPLwNE58bD498h75gS16KlTCef52yg3MPqoIo03+TnMsMO9qI+ZZEQzCU5kiGWjKTS+1kRQrQdEB/pzSq2IQyO3Dh7lSaosIufDU+hexMySsLoKQBDUlMY7irZBegqxfYfPuc+lOcSV6s1cG79+DGKqFgMKelsJfNkq3dbyzRNxr0qxvZB4TQG/5KkhT5K6tYBPhGrXNy+Eah8SgySM0099OXfKA4v3SK6WJG+b+Z1JHisf8t2FnvVCemO3LHq+qqIqKzLfiDCJcisbIOYoNm/7CfTdB0od4hWX47zetvlHe+jg+ailwG23mQKXTJx8ajwgyaoAAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1JtB7tWmXIXOyq3mVhyffXe7A3TywgsrslEDXfPzsI=;
 b=oE1i+/fxJ1c6A5h2qDoIY+h6IRAoz2O4c9wg60uqUwwWjwsJVWKctNZqXSdPr/QwJaVaJYYACNRAwgWW3P9gpJeKTx904yH+Q9/MM/lo+wt9SFgvaUqARVxdR27YMSmFstdWUaqSyuRlfhc3WxlgDHTR/JIDbeY8l90h0IMYW2k4LPCPtrROJx7yzVRU0PLJSC5BYRZQeIg97n2DJJoy/wNKSeIfeGvolgtjk9AEVI2v0ltCzbJ1B38AKpM3218rS5/VR8lfpgULaLF+LaYhl+T2dREM3EPP1gTJVDb/ERvJbKXk83YLfiXBX4qc213nh5i3MjUI9i3vXY1XYPvZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=secunet.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1JtB7tWmXIXOyq3mVhyffXe7A3TywgsrslEDXfPzsI=;
 b=Lcgqpc8fX4CjzJPTJ1vjJ34ARoy06RI039dwAsor9IAmRlvOaKfhy24hIedwnozsYbCT4nq0d9TmDwQn2prOWmWTp7VtCODXRu8M4E6EmNCE+sGSsNJy8JWgLwdtoRupzBMsAECiUt+Tu/wLUB4mjEBw9vnKWivUwU0Z1yzLi6ZH+B4ug20dLOeQqINJ67OPA7VMicsTucuj7dtvYwd+N74Z4ByfYxC0LwqlWeMfB2ZMbMvGA+JaBO6Pq4hIgt3pIsuXY6ol4kThLpKD6dK3l0GhJfytuwkvgWW35HGTHvv1+aYyzO6oBy+wcH423yX0T0XBJ1+25lzk5CYuEmZ8AA==
Received: from CH5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:1f4::18)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 13:22:34 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b9) by CH5PR04CA0010.outlook.office365.com
 (2603:10b6:610:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Tue,
 26 Nov 2024 13:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 13:22:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:22:25 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:22:24 -0800
Date: Tue, 26 Nov 2024 15:22:20 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Ilia Lin <ilia.lin@kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <20241126132220.GB1245331@unreal>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <Z0XEXqe38O5lcsq5@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z0XEXqe38O5lcsq5@gauss3.secunet.de>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb694d8-96d6-4b3c-ae74-08dd0e1d6314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dPM7slrm0p09pBeFM0BeFZT/Vvq+Iog+sIBqmm5NOXUFiGL8wJebdvwxHwcq?=
 =?us-ascii?Q?Wyrg7YMJHeepN9Kwj2HpLwQndSaBXabWwr+GX4aspl3iqbOziiTipYhAybXL?=
 =?us-ascii?Q?YDurdh66DF9k5Ucays/phZhSaCY/F4u5HXQ4mFJsE9NLsRJvwxDgkpZZpUAv?=
 =?us-ascii?Q?mFwuSzeSjnY4bOP9GlfR6SFLea8bMOC10tSkjCi/1nTfupudA6Z7cDtzPbGT?=
 =?us-ascii?Q?LhosKo9ifKvDt6fJe6kf78hfe7rVodxyVzC8XLhRmgo0XkCZ16dzMvMXyVvK?=
 =?us-ascii?Q?26DXm1krwcg8UY6AVyzcHJiaQxBgRoAH0KfUoVtioLFUEccdFPXRbtKdAADz?=
 =?us-ascii?Q?wOBsrwl1reM7dzDne7NmXw0gFpT1dnzub4obaTC6idYxrZq666F1Pe/4453t?=
 =?us-ascii?Q?ydchMXGvHAJzZ/f2KgfqAICui/hr6PgoFsk7bmpPOik52JwP417XY+ilOT6S?=
 =?us-ascii?Q?YWN2S9Lc83UrBb9JZRmeQquii5Q2N7LaaFQei/K5Ts0f0xI2VAUR40B2b+zj?=
 =?us-ascii?Q?5FfiH0n9vGOFUDqXY7dOSrgfYcTOE56YBH52gyxmXRxvekfek61J369ABxSp?=
 =?us-ascii?Q?ajC4p3BIMZ/zmRDeCR0zMdOo/LgN6pZEdJjWnd8+m0iQV5xSoiCuUPQx82vI?=
 =?us-ascii?Q?K+/7GEQ/YaOThj/D1sj/NlBoXUj+y58vNpEcRQgfdbqO3N7n0fnM1Q6/XLHs?=
 =?us-ascii?Q?ITuHx7deBMUQxz/35NcKAHHhHkLBLaK5eo42jGT9x74XHWFI9TwQs9gNgp0G?=
 =?us-ascii?Q?6vWH+VNQmCzL7FHFFWKdQWUYuY+WD0EoCjWQCGWOX9AJ3CE1SiUhSLaygCPe?=
 =?us-ascii?Q?8Zxp+W6UyqSo6zi6Rjlt82ZjoInjirB3ylKCkVS+YfkNbArOKFhIhtjQATSJ?=
 =?us-ascii?Q?1GIubY4JjVR4JIgPlUlxlLbhxZZwxuP0/UEPskupHDgP0egcY4AY/q7A9cLo?=
 =?us-ascii?Q?lYS5PVECHFrX3YPUyGEivY/KVs1bYTzGBEMBiSw1IyVgMaWfDnDfjYFbx/oe?=
 =?us-ascii?Q?Pk3QREjEyxA8oSPV79EMt26vLeBWxm1NnnzWYkkfOU2zEMXhAQnEnSQlrM7q?=
 =?us-ascii?Q?BPCBUX5IZFvNxIO1a7RqvRMoj+FxjvrwvN/IfJijAuMCA2Zf5KessxOeYtdW?=
 =?us-ascii?Q?O4lwbf71kde1XPMlT87hRDGk1Syomm/3XYDuvHlUosc1s8RBxJlWlErmkXjW?=
 =?us-ascii?Q?S8c6SxRrfNk6iQ17iuD5Z3LGk5VKS5FY2P0Yx4NzKYyTaGmz5KsqL3WsrQhL?=
 =?us-ascii?Q?RQVEqdNlTUsbYI3pcRoGElVmvyY0my6O8/VUWoGQ9cW8ZKAX6LwSC7GgwCG9?=
 =?us-ascii?Q?tRd9+N+idnj+ka8Xwm+p0YNZiknfldsF2LgG7mDPeMpIAr3JHgKdP6cCKTfi?=
 =?us-ascii?Q?lVd+dPbeJnZeoAa2s1xzZAvZrnv1Sa19tSklkG3zCLRHwk2REPaatSEfG9fL?=
 =?us-ascii?Q?lETvXl88zD7wIHdRNrsk9l/Xan1GZ/b9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 13:22:33.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb694d8-96d6-4b3c-ae74-08dd0e1d6314
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

On Tue, Nov 26, 2024 at 01:51:42PM +0100, Steffen Klassert wrote:
> On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > In packet offload mode the raw packets will be sent to the NiC,
> > and will not return to the Network Stack. In event of crossing
> > the MTU size after the encapsulation, the NiC HW may not be
> > able to fragment the final packet.
> > Adding mandatory pre-encapsulation fragmentation for both
> > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > on the state.
> > 
> > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > ---
> >  net/ipv4/xfrm4_output.c | 31 +++++++++++++++++++++++++++++--
> >  net/ipv6/xfrm6_output.c |  8 ++++++--
> >  2 files changed, 35 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
> > index 3cff51ba72bb0..a4271e0dd51bb 100644
> > --- a/net/ipv4/xfrm4_output.c
> > +++ b/net/ipv4/xfrm4_output.c
> > @@ -14,17 +14,44 @@
> >  #include <net/xfrm.h>
> >  #include <net/icmp.h>
> >  
> > +static int __xfrm4_output_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
> > +{
> > +	return xfrm_output(sk, skb);
> > +}
> > +
> >  static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
> >  {
> > -#ifdef CONFIG_NETFILTER
> > -	struct xfrm_state *x = skb_dst(skb)->xfrm;
> > +	struct dst_entry *dst = skb_dst(skb);
> > +	struct xfrm_state *x = dst->xfrm;
> > +	unsigned int mtu;
> > +	bool toobig;
> >  
> > +#ifdef CONFIG_NETFILTER
> >  	if (!x) {
> >  		IPCB(skb)->flags |= IPSKB_REROUTED;
> >  		return dst_output(net, sk, skb);
> >  	}
> >  #endif
> >  
> > +	if (x->props.mode != XFRM_MODE_TUNNEL || x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
> > +		goto skip_frag;
> > +
> > +	mtu = xfrm_state_mtu(x, dst_mtu(skb_dst(skb)));
> > +
> > +	toobig = skb->len > mtu && !skb_is_gso(skb);
> > +
> > +	if (!skb->ignore_df && toobig && skb->sk) {
> > +		xfrm_local_error(skb, mtu);
> > +		kfree_skb(skb);
> > +		return -EMSGSIZE;
> > +	}
> > +
> > +	if (toobig) {
> > +		IPCB(skb)->frag_max_size = mtu;
> > +		return ip_do_fragment(net, sk, skb, __xfrm4_output_finish);
> > +	}
> 
> This would fragment the packet even if the DF bit is set.
> 
> Please no further packet offload stuff in generic code.

+ 100000

Thanks

> 

