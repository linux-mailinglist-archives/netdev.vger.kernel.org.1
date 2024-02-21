Return-Path: <netdev+bounces-73715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC285E012
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF88C1C22E60
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB4E7FBA0;
	Wed, 21 Feb 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kjQSe85I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953579DD6
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526497; cv=fail; b=OECwqXHQPQEUgj4MD8JW3Z0uin4lnLWg131YFKdqCIb6Z3jDbt5goeXPaTi5ulxRVDyEj2tIJE0CvEpCUt5+W3WDbVSM/9xlXaLVD9457y/Q1EUhHxd+qMfrOzvXZ+/rG3Ob5HGxFCJR6gLd4aJsL9K+4ap/3no14ANlHyGskx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526497; c=relaxed/simple;
	bh=gX1M3rPcl/ELEn77wB0v2Ccyk1nnD7SaCb6fCh9I0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iHfI5CEl3S0Lz4zwuEI8eaiqGCC9b5O+l4YwR5PQjlz0PsxQHecebX5YU4KehKT+/xy5Ie2xO/fb81WWlAsG8S7TCGoMmlv0PlY70ByIOCZP4/RHFv/Uvu1cXaAMCCvPdGqKTzFfSdvfbEJwBUxNCwO7kUztfXEak/C4fh2Vsls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjQSe85I; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4o68nUwuk7DWOvJ6aSF9fryVFT2vnq5DVGGizGS9ucF7iMhagIl7NMfB2clYr45FT03PUMphqIqJ72t8I1wy8NTldu3gTAIu/Ij0h5NQuViwFpRttMd0IK8oTupoJN4/BWOUxRWrDJRx1oU0UbbXUS0CMi2omRryMX+4BjsrQwZrQMi8dcFVtP9tWeYHYLhJILXQGZr2NvdVMk1qu2zHEs0j29huZQErQZjzsWMLdGNE67IWatE/PFuMDqyyXNTSuY1u8P0MC48Fdx3pBDNPJ9xbNF0+fVtPyX/+cEohwoXKg0oIr6mvWoD90GvFcyHEQnl1EOft7s8F7gXrc5v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GYG6DWSR3aEvHyqRL0KVIrylvcLzIVEeAxVftzDKJA=;
 b=fRITvzKPZclJ/dVw38g16waaWbCYLdOBFJjJWabTnSqcGefyc5NucozvBME+XKVS95PgynY0BIFZPAr3z7vNaTd//Bikp+fSV3G5uucjfjtEJRxkIpJ6mJu0Do1dhob3QZK3cH1Vorfw1WM+ohR3Mvr1ygClt7s1gbbJ1/de7Nw4G//gszRh53GtbtlexBiya425rnkzbih6Cp2jzljgHZg3u1+iunmH8gKj1aSU2XtmPViM7HqjlvlwEvF6yfMBk0x27IArsrTPEHG8UAAWc9rRkTgqj79+sSaQRiZS9WiVc9IqhJpQc41ULH34X5Z9S5m3YcwvBzHlwGH2YmkyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GYG6DWSR3aEvHyqRL0KVIrylvcLzIVEeAxVftzDKJA=;
 b=kjQSe85IcR5OQUZf1Ih9iBklTc9JJ5JjmZIViCihkx+bTFHu7S15/6XKNMUx4yLjHmCSZNew4CYptxGQ8rRy/VUikNmaDDAo53PQssil+GXbRatCQoqAda+t51sxHsdQ2mOUXRTvFxdYTRfbyfZcNHqD4yxhe5sscm0RuFfaJOmKKuWfgPhIqN84gLpj6FQPGg61v+WXsOWHYGU8hrfEOIpgjivE7wCB+nuEjmzAyCMdpRE5iPh4aMf8fMYd7HEWaMZga95E0elj3QNfxVJWXitFzB+QajliA4wYUmib2i/1VU0sYvrn4cTkthwUNj6tfXHYxjP2rI0SIxVl6aDZbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 14:41:33 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 14:41:33 +0000
Date: Wed, 21 Feb 2024 16:41:28 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Bauer <mail@david-bauer.net>
Cc: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Subject: Re: VxLAN learning creating broadcast FDB entry
Message-ID: <ZdYLmDx7Od6-ouBq@shredder>
References: <15ee0cc7-9252-466b-8ce7-5225d605dde8@david-bauer.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ee0cc7-9252-466b-8ce7-5225d605dde8@david-bauer.net>
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 98aaba81-ca8f-4fa7-6d3f-08dc32eb32b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6oqCRuNYzVsMh1xgKZfZz2eLwDWmdMhMOq8s0/EnlgERUPSTqUq/AWLUqHweUF4xjQc0VmlOImhMzO0wEuLCOiGDpOD79aSykO3GDKbMGh6yiqVsTVUH2mqi49vuM/G6TS3RCzAqGr+lGt7cNdZ0+OJXsZThk3lM/CrOHUbhhoSEqD8OC/0E1LQKLLkfMcxav6niBoLXXYxyrgV5YeErjCkr0au9iOstKN3MH17eGBfLwpw4+6uCBCw8eRPFi9ytCWABSYSAEQY+1IfU+qwBr7OJMbYSlYTTBMiSJ6Rj9fHIiqipNTt5we2I0gxzJPRgFCAJIBWZ1BsPYx4pndlFWmsTgC7+BMsMGaQL0D94LDW1YaSCXyab71zB3quObJONwk1OXjH8HDIwuV9VcRTsO+Wmn0+qXbv28yVU2adrx2VVSGG3NkTa1QI4j0A4jlsT+FmZCUNh7J20TY0cxBsNAr7yexTFpSefOmYADDXyIdePaNpPpapoH05dkgQHYJpFsNdsIDmS7fQVFz7EgGzg/BeEQk8S9Ml3B6kRYpgsvbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKP/glf7xm4O0K+ZDvEKiCTvpy0/3ugYdJOfyJtYhAVsQnSAmPdyI2gQUQgH?=
 =?us-ascii?Q?cp5npO+/DAJKKVESjyDsK6xFc7kNNt9X1q8JamP+jNhn+fqkCHpTnv/OpXPh?=
 =?us-ascii?Q?LlcvPdLBa9QQ5caOXXgubmoC8punilTno0n2Ay1ROL3UOSiPtirKQABaCCsw?=
 =?us-ascii?Q?wVE/FOP1/m/1V93Q4dxPNjxazsP20bCB2Nei0DGV6KF8L/1O2wCXqkGsOO+a?=
 =?us-ascii?Q?Ocx3FZFBXMnb1GikGJiWsJASJaG6yDhSy9KZb4ja+/0/cDMItHP5lRSY8/Vp?=
 =?us-ascii?Q?UZc+onCv+Z6x+Ehhv0Hj1L7SG+xYI8VeRSCTTLhjfCUPV4xeLJhPkICRDXHm?=
 =?us-ascii?Q?whLzJ0UeyrDqfc4PTYYrQKl+5lwIQqIP5b8hawyOE5/7RCarfhGvxuqt1GE5?=
 =?us-ascii?Q?+ZcsoeiTsQ2EJ7m0wZsk6trUCdv8QEEbcxzps1G84l9qZGjT7/ZS4AvX+JVC?=
 =?us-ascii?Q?r72T9V908+DYKv4eQoCLewXg2YsxUbxhHnrmpXr4F0MPV04eL/YSuvsgkm5z?=
 =?us-ascii?Q?+Sw4eyfjqJ2keOnBnkTrutp9K7ujFIP9aI75EYwgM/y5Lb7dGoZ+Ld9HUhfY?=
 =?us-ascii?Q?Qy5TKrgvXF/wJdSeNPZaFzx5dyVHaQ8Lf+vEfmfxTvS7lBgzNn2NmTb3YHb4?=
 =?us-ascii?Q?ktZHRtdtc6gpo6M4vao3MOzx4ZcTo9iX+qgLd0U4/of/8rLIZZdxzcnihJWl?=
 =?us-ascii?Q?qyaCvT/SgT8/jt2YUQYvTZ0KRqBDsIGx8xfFyMz+3tWKNXcv1IjX20dZD9+r?=
 =?us-ascii?Q?X+bXmBEof6zwyGeeE8tFYGqxi22D33kQNHHKwx4yKxo8Lt7T1V+IS6ctLD1d?=
 =?us-ascii?Q?a3+LDTDMUj3NOa4DdzWvUn2mle7PRgnlgJtBOjwEkLeHB2lMVM3XKLsGH05F?=
 =?us-ascii?Q?9VSsBDRRF/XIIvHzJkOklJiZZoyZIVTPX2dcAEbFTIehAwzhE5EU77juVof2?=
 =?us-ascii?Q?UsaFPjZiICgGG5r4GnQD2qB36FyBvkEeaKVF8bNdfmJxG9tACGMvxDH+Qu37?=
 =?us-ascii?Q?BLUPxlUJyxbMRL+1A6LJAEF2E+OFr7lnJ105iaTHGAoD7i2IfsESf+ABvdeW?=
 =?us-ascii?Q?5ylA1BrDsYGcbsoPaS5sJN+Xk2u18//wP4t6UM4j7npYhfZQYXLJ/3vE57QQ?=
 =?us-ascii?Q?zBXOEMHM5hPEUoluT2UwDGQWu/cblTNlW4dDUO+xAG9YngnDoqccUCL/sff7?=
 =?us-ascii?Q?56MMsy83/z2rw7vgJy26VHY46gXpuBW3gjfU167RwF0vtuuFD3cWjoKJTC4E?=
 =?us-ascii?Q?zO+d5CclaaAr46nD3ASTrzG+vdPFdiqzlmdnzGtdafxaI0zUG6zidQBLTVlK?=
 =?us-ascii?Q?2vJ1m4FX2f50ySKthVX2xZd7zEAkMVY2Pe/+AQEujkf3FOsMeoL+aTJGcCV7?=
 =?us-ascii?Q?dgDgE4iTPx/4NkhWToocSIVAE7J9cJNsz3N+bW7F5cMZokUGWTtWXr6ToJbT?=
 =?us-ascii?Q?lwZyH32ocbrrbGo0bSnSmNpYgp+GDf3XVhuO94sNUuwpdmGFfZqX/R9o5H+d?=
 =?us-ascii?Q?ZuKcdSWy9WkfNcU07520y0FFluGEfE7AEYZu6xFhWFcWT5SB/nZHSyG9TnsF?=
 =?us-ascii?Q?4K19T7elgMJ5KsbJ8dQZgDI90lt4Bi48rghvQduv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98aaba81-ca8f-4fa7-6d3f-08dc32eb32b6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 14:41:33.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTpafSVD78DO+1qZsYkTbuL26hmxEcnvprb3SGsZmklafBoIP2RR3QzTBefHgtF1+X8YmIXsMRPiT6sCAUHbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

Hi,

On Tue, Feb 20, 2024 at 07:33:54PM +0100, David Bauer wrote:
> Hi,
> 
> we are using a VxLAN overlay Network to encapsulate batman-adv Layer 2
> Routing. This distance-vector protocol relies on originator messages
> broadcasted to all adjacent nodes in a fixed interval.
> 
> Over the course of the last couple weeks, I've discovered the nodes of this
> network to lose connection to all adjacent nodes except for one, which
> retained connectivity to all the others.
> 
> So there's a Node A which has connection to nodes [B,C,D] but [B,C,D] have
> no connection to each other, despite being in the same Layer 2 network which
> contains the Layer2 Domain encapsulated in VxLAN.
> 
> After some digging, I've found out the VxLAN forwarding database on nodes
> [B,C,D] contains an entry for the broadcast address of Node A while Node A
> does not contain this entry:
> 
> $ bridge fdb show dev vx_mesh_other | grep dst
> 00:00:00:00:00:00 dst ff02::15c via eth0 self permanent
> 72:de:3c:0b:30:5c dst fe80::70de:3cff:fe0b:305c via eth0 self
> 66:e8:61:a3:e9:ec dst fe80::64e8:61ff:fea3:e9ec via eth0 self
> ff:ff:ff:ff:ff:ff dst fe80::dc12:d5ff:fe33:e194 via eth0 self
> fa:64:ce:3e:7b:24 dst fe80::f864:ceff:fe3e:7b24 via eth0 self
> [...]
> 
> I've looked into the VxLAN code and discovered the snooping code creates FDB
> entries regardless whether the source-address read is a multicast address.
> 
> When reading the specification in RFC7348, chapter 4 suggests
> 
> > Here, the association of VM's MAC to VTEP's IP address
> > is discovered via source-address learning.  Multicast
> > is used for carrying unknown destination, broadcast,
> > and multicast frames.
> 
> I understand this as multicast addresses should not be learned. However, by
> sending a VxLAN frame which contains the broadcast address as the
> encapsulated source-address to a Linux machine, the Kernel creates an entry
> for the broadcast address and the IPv6 source-address the VxLAN packet was
> encapsulated in.
> 
> This subsequently breaks broadcast operation within the VxLAN with all
> broadcast traffic being directed to a single node. So a node within the
> overlay network can break said network this way.
> 
> Is this behavior of the Linux kernel intended and in accordance with the
> specification or shall we avoid learning group Ethernet addresses in the
> FDB?
> 
> I've applied a patch which avoids learning such addresses in vxlan_snoop and
> it mitigates this behavior for me. Shall i send such a patch upstream?
> [0][1]

It's not clear to me why the VXLAN driver does not drop packets with an
invalid Ethernet source address like the bridge driver is doing. See the
second check in br_handle_frame(). I would suggest this instead:

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 386cbe4d3327..936c47743318 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1612,7 +1612,8 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
        skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
        /* Ignore packet loops (and multicast echo) */
-       if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
+       if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr) ||
+           !is_valid_ether_addr(eth_hdr(skb)->h_source))
                return false;
 
        /* Get address from the outer IP header */

But I also think it's worth trying to understand which application is
generating these packets on the other end as it might expose an even
bigger issue. You can try running something like this (ugly) bpftrace
script:

#!/bin/bpftrace

k:vxlan_xmit
{
        $skb = (struct sk_buff *) arg0;
        $eth = (struct ethhdr *) $skb->data;

        if ($eth->h_source[0] == 0xff && $eth->h_source[1] == 0xff &&
            $eth->h_source[2] == 0xff && $eth->h_source[3] == 0xff &&
            $eth->h_source[4] == 0xff && $eth->h_source[5] == 0xff) {
                @[comm, kstack()] = count();
        }
}

