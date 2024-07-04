Return-Path: <netdev+bounces-109104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABD926EDF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49812822E5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50E181BAE;
	Thu,  4 Jul 2024 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="Sf7dQxBO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8133DDA9;
	Thu,  4 Jul 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071401; cv=fail; b=dwPys/6hSwOcf+zPbFM1IUPw24rdAHC5qA0EqurhvIDG0XyNJ3OtXiOhbIINY2Wkjg3X/cyExVsbGml5eI6h0/TIL4iuW2MrxUXajWAO0Q88sBJuKfy+k/xfSiZRANnq2HVY+QPEgPInS74GHsnuMBmuMi49dt1Vdb2SjItv0k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071401; c=relaxed/simple;
	bh=42KjWbnIEzZ9RdUPWV0IqTszl5dD2uUdPykdGCxi20w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MqSNSArGQiVNnTtY5N53wA0unKNTAOxc6Sw4sLwFug0VxJBwz1hLxXAThUT7hJCb9oJuGku0PDP8hKZXBbd58BxJKjq0rQHgojriNrkoOPyrAMItUXwQC9rCEkae25qJD3tonl/qL5hvpHSXcMsuiWfOv0Wme6aCv1wgToNwPuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=Sf7dQxBO; arc=fail smtp.client-ip=40.107.94.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCvg4np5xNm77CoQ79czRrPuUqFREtG/lkYSaOnGEs+Lk4JNrl/YtSRtKVpFUFWVtDms5GQH7PgfDH6bwIowaNuR7o1wdlETOpvLXWhpEQbA2LJVuWtExiBIC+rTEePumw8fasfJsxp8EABEbcKHCVzBX5Ggucx5c9xAhYBeaddhxF5wAVVC3+bAaA1JmcDxISJBr2o7kGiU7Dxfze/teQvxbJJEDslK5gYMYWG9A0KXpcCFShXYFFxD13PQDrv70FIli/0CNMSEsn8/1hWTwc+uEYCc2GJuR2+6DCd2JKwJzOt4sJVwGO//QXyX/n1ldPZdM4l6sd0hWgs57ros5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTVDUocgr3CobAXPdc03/rRjTpkU5KDfIbI/OtGZhhM=;
 b=Wnp+zXwF7C9xmY+cwmCQAybWD7nUquxExfly1vyRlfvth65dEX48k9xBR6SuUvw3lPLGkn1QTN+En10+xdghh/yNaoP79rWBimXz/Ub0xtHDVGrzroaAtPbhOqLPkdXetmgrpkP6Hac4dj3QFBFEHZz9OMDCiIQE6jbBCc1dNs70XOWId2HitWAOK5p7aoK1Bb4KA3U+uCFlYyBJaVkb3yhSEbzGzgpWWNvNRLGov6eaylBKyv4cPkVCUleNhcn4m+TzqGv5BJ8UFqNal7rSja52vXwaEtqwBb8JLi/XYfr1TbwTdkfhKA0Q/B84HrztZwVsyX8a7roMVIb3HvSVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTVDUocgr3CobAXPdc03/rRjTpkU5KDfIbI/OtGZhhM=;
 b=Sf7dQxBOcYeWJRMgxjNRkpiGWhjtocinB5KADPNgV62lUIDJ9skKB40V3vaSfNvf6pRrHd7NnIbTXdGi4AqSeD0IxNCn3jHIqf6cGSzWoCkuI/Rfox7J7k49g+E39qb62aNx2/REAnL2fkcroU6JwRPLDBgEnILLRvjBvZm3MVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 05:36:37 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 05:36:36 +0000
Date: Thu, 4 Jul 2024 07:36:24 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, yinjun.zhang@corigine.com,
	johannes.berg@intel.com, ryno.swart@corigine.com,
	ziyang.chen@corigine.com, linma@zju.edu.cn,
	niklas.soderlund@corigine.com, oss-drivers@corigine.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ntp: fix size argument for kcalloc
Message-ID: <ZoY02KXZ3GyS7nXg@LouisNoVo>
References: <20240703025625.1695052-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703025625.1695052-1-nichen@iscas.ac.cn>
X-ClientProxiedBy: JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SJ0PR13MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: 550fc4c7-f403-4acb-6f16-08dc9beb4538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jenhVTDF+yLOy6bcfF1rlmecjr7Il8HHYGhNnEdQQzIUQs7ITxOlzPDtlRcr?=
 =?us-ascii?Q?y5kkgkShv4Ta2q4FuWQeryzXBQlvl571jkr0VLM5bLoBCzZ2x5Mp4izsGR02?=
 =?us-ascii?Q?p+idZe3mA6NtDQGR+7ikyc1VYavpFmn+ZOeCRbYCGY/JFxqDI9QSLqd3tI+M?=
 =?us-ascii?Q?+mEZFhDLImOmHo1oUuCEU0PlKjIzQlJ2sGuTE05PVSAiVRuAODbf6adQpL1w?=
 =?us-ascii?Q?n67H7RxXibh/9iOQZ9LRR4pW+GIKJM7DeNl5a1JZX1ihof9c/UGOHrqi6yPt?=
 =?us-ascii?Q?2TY0wH5//L58JhyuU/oykOzDWGiIva4iA4eOMG478lZKDGOVSzE2lzFP6KzF?=
 =?us-ascii?Q?11Gc2vVCSvdg7tk6sVwvz7m3nONfS4SF5hzFuIHVqrCK8yt7KILqZhmFKgEg?=
 =?us-ascii?Q?lg2TznyssYkNo7rygTN6ATAT8QRMl7sfEzue8Md5lgiO0uM++SfM7lo7cCxQ?=
 =?us-ascii?Q?awVNphr1WKJVVPz6BR50GuKMgNnq2U7831GdBmsAxE6+sgqj8tARcc17fjbP?=
 =?us-ascii?Q?gJuRc5h+FHVvp/B2jKrcT/Vd6841NVyxYhc2zmtW+8W0RKd+yqhr7MwXMAQG?=
 =?us-ascii?Q?DyHNK14AQ7sbRzDR/zbp4CQ0F5GnExF8WYYc5bv5v39GziGkP6RCqVZ774p2?=
 =?us-ascii?Q?ffkVwzwW8uFXII+A1zE4s+fQogAw0jj4ObCE48CNIceOypCWl+/ktX1cY353?=
 =?us-ascii?Q?PhBWtBdn7BUrGUupaRXc/F+amFwn/TDAM0P2dBsaGxxdujJ4G5guDLRk2Hip?=
 =?us-ascii?Q?YwQh62Ol2VEDr19blg/o8o6BTtJkPL1OEGfz2Yk2bxevxhRTPOI1/baTiaJF?=
 =?us-ascii?Q?sQDt6VIan18aMsE9hwUY/MOUPM4Gpd79wNL0Oh//8e4DUA0rA/wu+idfR57d?=
 =?us-ascii?Q?0b/x7SSty6YcgqUU64TtoIbkahFx46rCMbmvAAsq2BkpZIFpC0q5tU3n/Pgd?=
 =?us-ascii?Q?iu+3aIhxmUmGiUkG9vNi7zNVRRNLTS6FlGrIKM8ovMklOS3k/0Dnw51FKIPX?=
 =?us-ascii?Q?SShiE4aj6EoYmIsf12sLJRxVm4fR5jKQdQMJTJfOi4SpEV8yTuHei+WBudEL?=
 =?us-ascii?Q?eHxa4OrQ6z5yt7eAU8G033svhettM/6lJEaqocj3nq4MC+9aPb4Dfrtpetxi?=
 =?us-ascii?Q?MsTBPAihaF0eBjKmoL2sinobFbpfgGm3e05LZygWr7dhNsTo3jjpMo76Wbb9?=
 =?us-ascii?Q?196XdrJ1SUn9h3fAB2ggm1RvfbuDDFpV7cMSXDS9OtLlkNIG2d/JH/bUI14R?=
 =?us-ascii?Q?dzGtA7KVaz37DexXVuf+RMIvbQTojFExQJrIVWU3b0u16u/KD9O86Wo0Ff29?=
 =?us-ascii?Q?RapU+y89ZnqaXWuexKcjd5UODAj4Ya6tGXF8BpgcKhgzsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?155f0CF4D0gIaV33h+ZACvtc+poVkV4sKADYlQcWBI3PVyAiBgDPuWAoaeIT?=
 =?us-ascii?Q?vNIAErs01Hgn8vam24XU9DRtME3SAypRUguen30lNftPOHrLaDhlX3bxZdWC?=
 =?us-ascii?Q?L90G2RiXlBPrIjSgPZG6FBu//ZEN5JMXHGLnNZXbwUwJ8Hfq2LLn5Zb6V06T?=
 =?us-ascii?Q?Cx95jW5rCjmhUSW7oNeDwZw1D2Uy+jdEx/0OLOLcbOxcVWkBS2mCv8kUqnhU?=
 =?us-ascii?Q?TAxaReDw6oCnturzvyXjOiLY1Us7RFOhk/lj3g3IF6oKOYvvpvJjUjJDTb9B?=
 =?us-ascii?Q?mwjddKTOH1lFU2LDD58hus/aqI+s9ZLwVhWBf0hypTgL2V+YGEkcowqs8jcS?=
 =?us-ascii?Q?5+Aw2pmPBMtea2Jc5p+2hrBrRET6rM9zmCyWnYc3TFSk22bAC5deLBIrKffj?=
 =?us-ascii?Q?mDfRqUGMPnDAiK05H9Nb7GC/aYwQP4kWlgGqBKwUa/gFe3Ckjv3RPJHtijUO?=
 =?us-ascii?Q?blunoYRdWTxT++5XLGUIJ6lF38ycm0t9ZLhhY6hcK1b0mI0tccGXzMunV/V+?=
 =?us-ascii?Q?Ed8oG91LYkKqmkjluj6I0XiZTpSwOnxXvrMtTFNw3Bq8JDWJWPqHNItrsqSM?=
 =?us-ascii?Q?Wy3fgH6p6zb94DyL9n1ZP2Yk8FlHaXLuvJv0PcrH/aEfVkzR7j5ntDu6pWpD?=
 =?us-ascii?Q?B5e+TEJldwhGWPdRAqWOaWN3QDYxLt54nhDYIs5UyqF10fxOp728lu+zpq8d?=
 =?us-ascii?Q?KvzC+UckqpIAu0IrtlGxrWkViVn94J4A9DKywb/IOZVBWw57YHPcLHgdhznc?=
 =?us-ascii?Q?B6s3u2CE23QUii5yBlSmPkj4HNT0jHiH0SKnhw0NfwiR2U7En2vKn79JJ+bP?=
 =?us-ascii?Q?4oO5CWY8b0NSA0BIA5eSUcQWii/LTa/7ET9q84fvy2OCCaN+9yesMM1O3o+S?=
 =?us-ascii?Q?5fS08dhhSH3PIdXV8z3P8QwIiQ6KIRZcPAmj/ONdymsVffkUgFHUdaN73v1x?=
 =?us-ascii?Q?QUh7NsJ9DmrkvWUAJyrC+jnxCgxlLfdTwgJ6sqRXftMweeoMxI61+dVvtDuq?=
 =?us-ascii?Q?RRNb4ouNAKHh0CJHyY7Z/brVjK1a9VnicucvX5MmY0UDaUocIZ//uEPeoP3z?=
 =?us-ascii?Q?CQLQBGeYZ4bzpac/YLvHpAKJT4hSeN9D0qPCguWHhwpaS8zucCjyupeiyI2q?=
 =?us-ascii?Q?SXTWyfb/Jdnzy6sF1UR6r6/dGlhcmhc/GBFlXTtFWzD3afT4yoSNn1c6OxRq?=
 =?us-ascii?Q?RWHARXhJWyIyjeQXsiGYW45wXLb35qFV2c9kEX5nF1YrmB3t8/Y8+MiV92km?=
 =?us-ascii?Q?raULY8AwebhewAfRcoZ/8JhBQejsmpneRuQ8/j+t3IGWVrijQYwzxt7dEk6J?=
 =?us-ascii?Q?bWXsmTLOLNVifJKGcXb8+KOCwXbdErD4G+AN2xPn1fWh0Gbler/bWkVtuJWW?=
 =?us-ascii?Q?K51FegClBTmaR3k2ne4rtQIkoCLbnJ+AEkEqJs0ZqjChHlvQf19PDOwF9+MV?=
 =?us-ascii?Q?O4dsFABBv+XRBkLnmuO2eQriCvycjj3Lrp7tdAS2LGrWXdqpTKbd37u6aPTz?=
 =?us-ascii?Q?fqm+kO0uSSYNopfJRLdTkzds7tziyC9C7KystuAVRB3LXW08H2YQfIP7QtEd?=
 =?us-ascii?Q?xeZQe6Cai4t7udr6K3UT5C54eiA/o8OyhCjBcpaDr/tsicpDZqrdJv7g2apK?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550fc4c7-f403-4acb-6f16-08dc9beb4538
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:36:36.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEKGF6020Y4WpWgbmHT6oHKCeFta5gQfgnPhFfr0zZ6GCzxklr2QfZxq77QfONulJu1RQhqE3DloR7+qKExtRYWjRKUFDM3pXTJyfpQpKyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5545

Wed, Jul 03, 2024 at 10:56:25AM +0800, Chen Ni wrote:
> The size argument to kcalloc should be the size of desired structure,
> not the pointer to it.
> 
> Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 182ba0a8b095..768f22cd3d02 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2539,7 +2539,7 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
>  				  nn->dp.num_r_vecs, num_online_cpus());
>  	nn->max_r_vecs = nn->dp.num_r_vecs;
>  
> -	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(nn->dp.xsk_pools),
> +	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(*nn->dp.xsk_pools),
>  				   GFP_KERNEL);
>  	if (!nn->dp.xsk_pools) {
>  		err = -ENOMEM;
> -- 
Looks good to me, thanks.

Signed-off-by: Louis Peens <louis.peens@corigine.com>

