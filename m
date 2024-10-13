Return-Path: <netdev+bounces-134935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55D99B98D
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EBD1C20A7B
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20672140E30;
	Sun, 13 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrKgKXTC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27E1E871;
	Sun, 13 Oct 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825487; cv=fail; b=bROINgasExWZ1Mze529VXJlgu7bAyyQ9cvjI4ykQCCbQEfhk7z72TGgs8pzKzJH6/2Dn6iheitmkkB8YY1q6IPVASmL/YChy1hPOw5KkWJ/eLRKpisojY3R7/m3NFM/4fHUIlHLybvbla39RhdxIqPaXDI04ZSRNHxTzcd3/N+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825487; c=relaxed/simple;
	bh=KCCnHeUN1wQmzTCvXcNr8CfuGgzQUI7hp+AORJjhhv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qhjp4jvxXhXxh16GLSW7y5sVDLE0HfCAe23tb1Lz7HfATldiAnU0DKvui8oklHunmOu7Gx25JwhEZpwy5Rx/NUJyUOfXSKqD8IyiRsDRHehWma+9wSiF9ElV0Np9crqbqsejHGvLI3HgXgnUhFJXiPQX6vbcg6Lq06klST3tivI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrKgKXTC; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ58g/VMUxt7lhVt2xv9fDo9zYU70leuJjRbBER3cIoZ6Pl72Lsw51niFDQdhQqmfCXtiJdyixf0YoLVmCJgewSoeviQmdanbo+Dfy4LsUPrHcYAQc5Cej723sEZHx4uHk5CeIzZLdpa+AUGh82pjLoicgYQEQSsUFJEybGAN6J3ooJJF+M3Gox2HjBCJvWDJlvlLstGErH5jvMyrgeBxqKnmO4PvqnlNYFI3poCVY1HA16PHb7PMJz3K+r0XH2GeO5fh+/OAwXWsyGosuzxLxCs13HQs3PuuIGGslnwTzt8Jvk6/xSIvJZXXtfkSY10wp7RXmQx/JNjtv9ThKXTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzAD1FBaGLkf9Z2uM7ss1VlqHY/3F45y6Zv6R+ER/+o=;
 b=rfydfMrRMQFrLx2bfNWMOZOFdFOlmcY+0TuYpXM/E9rma7kKTrm7D3Tp9M2kUEAZOcyI/dEel8H+MXYGG2EzUp1GjpUJSmL2Dy/GGUY5tcGnXQLAUZkqy/2neFGv9veJQBgd7xXbJmUsJIOosfUCv9tdyNwpTGY5KxFmDBL0sUHbeguaqoQeV0bPJovPEjtNW9X6adqazsLuMqPjoaAYJgglycY5xuVcjRSKLihx8Vys13hhsSoBTTZdBB7eOQfndvaeqXJ33CKIR9U7ENtSy80RqSkQlGwHWd8HNaj+WAb5wVW7NQSOYSp2Gu9tStrdEs046tRWyRmaP5zmu0c25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzAD1FBaGLkf9Z2uM7ss1VlqHY/3F45y6Zv6R+ER/+o=;
 b=hrKgKXTCASNsLNSGlmhsMUG89kmUiyp+CjKDh1lWMKxzG21KdbS1bJ1ruXPT5RE37ALBL+zBS1MEENYaDGNWQEjxXg0I5a93pwVdusokFVkmLaUt5RysjuCcynE2XhAVirz8E1c51vnfK46PL9JqGo0h7/BwUqaKUspNtOUkPmNBu4p/AYmf6npMNqfN/wje4z6czbruVYosgR5zNjlaI4iL/5UgINNDbBwzRYK5JksDN1Y2Ibd+2IKCVKA2Qi1M3GXxkkLcnVpWHi3aZBxF5b4vi2PT80J/yw5w2uX5unhuJx1xPBsVintULqdmDxjoOzdeH+yMdaxW/xqPDdH1tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 13:18:02 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 13:18:01 +0000
Date: Sun, 13 Oct 2024 16:17:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 09/12] net: vxlan: add drop reasons support
 to vxlan_xmit_one()
Message-ID: <ZwvIfwUv3hmKyW60@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-10-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-10-dongml2@chinatelecom.cn>
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa23044-509c-42f9-8a02-08dceb8976e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ffFWQ6K40QYRLbmXJo1tu8DFDLrD2i+k8Di+vxIMviGzJQw/+gpa5Lc08wE?=
 =?us-ascii?Q?SF29e/oPFZGJnAo1GdVqKS3kXLB3wMj8y0MB5NljpX7jlynEnT0TFsj45ga3?=
 =?us-ascii?Q?9qFrF++BxS/pl+COGBC1JJdRgf7njQ+E4Lkt467jYBohgnz8qyW4OIJL2cMg?=
 =?us-ascii?Q?5hbz3HFjWUf35JQRs0XWNxE7MEiPKnrV8zIQXAY/GVaHjQKALXHfsL3jNALo?=
 =?us-ascii?Q?wRhePPnM/I1dh8qq5DDgSFPz+y960FD1s6S1mQQgmx3HHjQ7j/YMryHY/MTs?=
 =?us-ascii?Q?Zl1ci+SVqKa9XAHkqVRXri0uGq4WF6w30rx23F5ecDL7DdJv9QpGqgOm6j0J?=
 =?us-ascii?Q?tcFaQgyG1jvp9HBegmsbDLU1obqubwDAgiO7UPNssLVGGZDncoDNdi8nThWX?=
 =?us-ascii?Q?SOHcX2zrT/UsQWLaFvTx7ld9Xu98bTB0PDMjYJJGqNFE8mHssk5ceNHboAU2?=
 =?us-ascii?Q?2rfgEGC57DSIwkZQrFUGgWI9mblbwpuntodYAsPP0+ib1vhJEoaZ/uJpzM99?=
 =?us-ascii?Q?MQyWY1sODJ6NIMDdCP1jILVwtGcVadoL30ce/1NeLym0h3oCkkmjm3qMxSjf?=
 =?us-ascii?Q?mRmHFxCl9LTwvWM7QMImKxPnawKQDdDmVUfjWjzU+z2w1oIlfxKztVWkfkrQ?=
 =?us-ascii?Q?APDKSnEusXl7uMdlgdCvTEQZjbh6t5BBbF/sF0Q2YCAncfWNRlQgk/pJ1Cqu?=
 =?us-ascii?Q?pucOBat7lxb+6LbwY8lydzgshV6Y1Etf/eAm4e2NKIGMjq9pXJx9XBS+zYmm?=
 =?us-ascii?Q?Fnhlv4Q/rx2upH9XTEhJDhDJtycp9+f9ayzndA+O3MY4aBnUtIELHr7zsCCj?=
 =?us-ascii?Q?cSr4PGgCPSmrgSqIRwaWPPrG0Jss1mvkHh4WeMoHcXARpRXPhT8o6+Urn+Rv?=
 =?us-ascii?Q?4Ck/rquzA2U4UFJOsGBoOfnlU4rREHksagRsPEUWMnwpaSq0xdfs4l9pDefd?=
 =?us-ascii?Q?9gKAmvIJILCZoISBQF46Yb+eQGU7uEhE7fL5o9uwrXANNXNdiNqC9L9NXhsU?=
 =?us-ascii?Q?zo42RSJ5gWkd49H9pX+nOO1J2VC8nkyze8YrIhxpR8jtP7bk1h7/jiwAsqnu?=
 =?us-ascii?Q?9ZRf4xYPVn6wAHwKOkklWC8PEuHilYTz5nDtaCz5DgpSBJEA/NvFIQCqVWni?=
 =?us-ascii?Q?UVs/Ana3UAWQJS9oEgOG33ioYpiuLJ1rEt7eadVO+LWnyIWORxY1nlFyqROq?=
 =?us-ascii?Q?AfehoH8LImLuN6Wji1JKat4i8ri3xtjpBIkRrNxmQlA2rgxznBpq2V3+jrKS?=
 =?us-ascii?Q?zIo0OXY5ZvtVv6MDTkY2P9/HDJ71FVnLSvExLiGPSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C2ROjqV8lhgjgBkE6W13tKlazeDHmkgxi9VCMM3PkU2Hv38S4reDd100qd70?=
 =?us-ascii?Q?Avp0KVJKzcGgbbh9mkHe/UYRcXdaLYZy32PxrOwfI78oqeG1MRP7YinfgWyg?=
 =?us-ascii?Q?6LrWiDGu2sANFjXJJUxonVN7zIZzNiYSBJijuo0K0jaqyspFQDeohl4CDZTK?=
 =?us-ascii?Q?peqV2DQvvh4Pjzym3v0hbLzrPsMWGautMweypytFlcg4wBdpLQviOF1aEiFt?=
 =?us-ascii?Q?I7xxQK2dPeXj6pKDWhfADl05CLH3cjQhEZ83UTFzz2Jbv8vleUowXSD0z788?=
 =?us-ascii?Q?LOenBN6+VLro7uZUELQI9zwqyPpTdXWlUz482jslY+LEJTWlvtCeLnRdkYms?=
 =?us-ascii?Q?Y/IN9R/cfuD+8g/ihQF2+70M5W1ok6IF2ZQg5eGXb/70e8Q4HZbXWPpJQ4Ua?=
 =?us-ascii?Q?83P2ZsgQLd8vUKpqVuRaGlVDNy9eg63PQktAEqRNBZPOR9Z13ewmyTnl4lHL?=
 =?us-ascii?Q?6SpkkGb0k0cTJaMlgXFOdmuhhpqxWi8AqPS4Cc+d1EZVwE9xo6BDJ59XS/tj?=
 =?us-ascii?Q?K1eFD5As4rK9cK9d6kb9//SdY4h5t3sOiuSK0BLqk46DZoooMPeqyYn/RRo6?=
 =?us-ascii?Q?M7I5cPQKti4vCuIi6rITamUn/b3Tufe3LIOgRQSSU7t5zxkVDDZZ6ZG99JEU?=
 =?us-ascii?Q?uzdmutiEdHheKNGKjXDVY0/wBRh/cuOWDFABc3EbboBZSgpKEOn7ix3xZqB2?=
 =?us-ascii?Q?KMghSGBQ8GtWOwsDigMo1WESKewWxF3bymLMUyoDAVu9aFYwh5Aq1RPtCYdl?=
 =?us-ascii?Q?+POogU/fzkVtqhUL0eKsrlsZgewLBi+VGoo9ccnNl4BFWkEO8EzICqOAA9k3?=
 =?us-ascii?Q?1m7L/jaq/eIdL1aJHkTC0ngSvqdQAQS6DVvy9fADp5bQrbBkavGujGyNNl7n?=
 =?us-ascii?Q?pWGO4wiiF2gHMptbP3OPOidd+kS+PmKRR2olZzDiB9puqY1OQmrCFIYjC9KO?=
 =?us-ascii?Q?QxkYNT1mkM1eziMW0iSe81qDvbrZbf+UAX0rAEL4q9WDkFKedEACha0jCR28?=
 =?us-ascii?Q?m0KrhHaE2qGVEIZT7u5RX7aaOE8PR3mBwQ/NWt4/iybSTLYYFJ2DC/RI8EwD?=
 =?us-ascii?Q?QoXbZEwtAxXDwJ9qXRJ9jIhFvATbznNsDSmHQQxUITP0Kb7i7xWxi1GQuHr8?=
 =?us-ascii?Q?NltL489iZcFidyzCwDVRMWZg4+HpKvDTKkfqEHvEjxTdzxt6vYx8WBxbqVUG?=
 =?us-ascii?Q?pAtmcmPeBqVrBodYbgx4bMOgaSYF2zu+AbpL0z+XSQublgcCTLMcybAl1jgq?=
 =?us-ascii?Q?n5V7iGoozK2EipCF+f7kdfvaF23fwI6nghoLq2ruf6UZiPbcSVXJPaNUkN5V?=
 =?us-ascii?Q?Sew64ke6wwfgZhRrPXaRsdZG7x/tmlGxQeheNCaj0Tbw9B9hj3zy3vYiXVhQ?=
 =?us-ascii?Q?LswEjNmB9eIVAZeyVMVZLph1drf9HY3V1E09kDO3mSodVGTTPFzwz3CrxCM9?=
 =?us-ascii?Q?2gtkkDDV8lpElhfaA9SOHcUys84zEGLE52uo93MNZ1jL/8kpRoklaec579jn?=
 =?us-ascii?Q?Ab8qgA5YMMDbh8GbesWMWDpdc3+P5EPM8cplxGkrokypXlA/lFndfEVUgcJ7?=
 =?us-ascii?Q?BvVgvUSebYJOIhQQDySt61TGrzrH1zZ2lnNNbvnK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa23044-509c-42f9-8a02-08dceb8976e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 13:18:01.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKsTVdtbpwnDA+2hxs1bikXp/NXweY30bXbMNOlvVsHycE++UG2ZNETDJx+FCTDrca2hOaxt7f79WCnARnlsHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

On Wed, Oct 09, 2024 at 10:28:27AM +0800, Menglong Dong wrote:
> Replace kfree_skb/dev_kfree_skb with kfree_skb_reason in vxlan_xmit_one.
> No drop reasons are introduced in this commit.
> 
> The only concern of mine is replacing dev_kfree_skb with
> kfree_skb_reason. The dev_kfree_skb is equal to consume_skb, and I'm not
> sure if we can change it to kfree_skb here. In my option, the skb is
> "dropped" here, isn't it?
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

