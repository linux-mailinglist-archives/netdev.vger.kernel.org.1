Return-Path: <netdev+bounces-145617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF149D0235
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 07:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E123F1F22B91
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 06:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF417BA0;
	Sun, 17 Nov 2024 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lT72qxyQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FE33E1
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731824555; cv=fail; b=Iwj+9XRrCJDIXzp/ewC3hzhsmquqKn7JHfgvi/czYuZFnAccHvJ1kpe9UJvDPBv7swkgrsThiI6Hl03l3ap6h0DK1oZOrG22X92xMtVo8oBKbmrmJt4cHocayi01D6UIyNlQkC84PVzvel9yMa6bBz29f/IAR7VuH0Vr+lo2jGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731824555; c=relaxed/simple;
	bh=imFodXCZva6erhVuYZ3HCNxQeRJjzD2USnKSwrxcTQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdVXAmewD/6r+mRfe17gwP52vNPhwML8wntK7cx1nmHixsR7m7Zcs8TByVxw9LkY97ooF6UMmMTREXEkb8poPFuezF6hDxEZ43zd38N9R77ZvO0rAoD/bAbKFO4ryDPXSjGAHfHIU49FZi/MDwGy+oA1jaI0jaiFFCrgShRoc5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lT72qxyQ; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eu+BNK11J2j/qszFy/zrzJCDiDXu6m2QEUGqpVWKhsFG0EN228AFLl2yC5S0ADA14aWpXo8cqw1TXqqxHrOOvGAHzANdjVQqj5NQUfPBr6zROeeJeXYQa5J8WxZrtLj/gCICV+Mb5AJP21Xa9ZcSG0EIee9eLxRGLeO7LuN9AXNeWse+ejHXOxxXt6+saVMrLF9eDzaWveV5O8pOas/mzxoYVYaJvCjyqNnIqlt59o1RISjKd0NyiEGl5zMzeKy/VsguBV4xkKB+RgUiYYC2IPU5u4wsilW3huSAr1WcvefATE5AoaVkXsO7MESt3I5caEBupQMN4Nzrs88brzGEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROqkEbtxVhhDfxreavWSQBqlneAdW+yoc1n1cXYInZY=;
 b=weoflpuPHVF5qZRKa/V/RMBe3xLzgWWUp+APAJbxObO8n6i+cYWTU9WGXyi1/re5xMJ2Q/uF8dAq4ULt5TGa0GL//Arl7bjRsjFhzSpCPWcq3H0cmx21u18pXLaAH3todvG5rqEvR6s8GhuF6wud6YYn/91fczfLIUyKhnK4y/Re9pcehLsBYC5cRDuCEQKbUPQYEVsjakvVl+lO0GVXAtaX438UWboi9LEJXwFcHjTCzvE1eCffXZensWOxVnjl8s+MFq9NpWM2RsQhKw9/s3xQO3FL8HU2K4JXxo+vSc+68B3R1zwrRYZfcSJAJLzvYMdXUquO4ZU7spys//TUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROqkEbtxVhhDfxreavWSQBqlneAdW+yoc1n1cXYInZY=;
 b=lT72qxyQEpJs962eZKsn5rohREzLBiAnJyd9ds25WMucraW/hyn+Q+wy9dr6Txve6xFW5LoLKw8DUQvyut51yOMrV3at8QC5KiTHlWPhwLQ0suEmfDRkVyh8FfQJabU+eRTC9pJIBjP5iVPKcEB9xrXPXSezk77tKTYFu8DuCwLiDJdRNcMGijJFUhDCGcVoxh762GP9zNSMH2CoKDCzyKC5Yj6rPgM0DtrIRBCKl+kdwnhUWFY6NDcChEgesjV5QHnmHDh94+w1xVbzQU2FJlRzXono7QxiEdUty/AmJnE/4i3XnFku9R1hySz3ksW65l9AryTo5KPgDbngqI2UKQ==
Received: from CH2PR10CA0011.namprd10.prod.outlook.com (2603:10b6:610:4c::21)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sun, 17 Nov
 2024 06:22:28 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::68) by CH2PR10CA0011.outlook.office365.com
 (2603:10b6:610:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Sun, 17 Nov 2024 06:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 06:22:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 16 Nov
 2024 22:22:20 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 16 Nov
 2024 22:22:19 -0800
Date: Thu, 14 Nov 2024 12:27:06 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Feng Wang <wangfe@google.com>
CC: <netdev@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20241114102706.GB499069@unreal>
References: <20241112192249.341515-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112192249.341515-1-wangfe@google.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c1d3ad-50bc-430f-0626-08dd06d035ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oZ7e5bDUZyb4byz/ITukZclv6c3Sul03jIRmr28ecgLLIvRCgPwBmiPNNjmw?=
 =?us-ascii?Q?mttI7q1YR5fVKp48Lyg5ecX4zzmmdubikSCr1inR9Z6/9wnm2PtwgSdCIPbT?=
 =?us-ascii?Q?tgxFhk9y8UIdEBmPJqMo7L+DKUiuxxwtslW92R0F5yKdieSFPvohiZ0DfQZj?=
 =?us-ascii?Q?NbSlnD43mdSCXAxiqMo2ZldJF4K+2TYotmMxYkVeRkexmP8pc/LAroU3PAEt?=
 =?us-ascii?Q?nZrqB0vcVFIOxgE1cPHrrJvGbHuZbFnnljqo1xPSwkoRnXMOW1lP0i4j2Zg5?=
 =?us-ascii?Q?l+MExmBbIe9FYOU2rG+AZRj4uXL2bAhS3yA581fJNJa01zBTJ8P/TMPpjKas?=
 =?us-ascii?Q?3X2smZpZNkhh2reQK5pHpRzvdge76mFIU9BUKrnp3hBGqYXeZCdglFYryOLj?=
 =?us-ascii?Q?zuCjS3kpzuSd0uwn+UljtM0Wi7Cn66j3yZwCtje5cghZJI7QswXA9vsgmkhg?=
 =?us-ascii?Q?vdPt/WE60OMtHVwPalv8NjG1l1aNmwIloenCTZ5msUS72bD5Tz5eqAHfdKZo?=
 =?us-ascii?Q?47PSLQN351w23IWRa3TbIXS3p/OI2MzpgapVLM/uQty6jrs1MrNqVmPfp9uN?=
 =?us-ascii?Q?QBzo7xkzOtfEKxH9GO0M2zbtksfi/062RSPKdnbWpzlNJKDoVhJ0FeclNQjw?=
 =?us-ascii?Q?1SI6UqRUCPKyQ3XrhMqVAL0hQQOCztooGNqWuEqQDoYYq9Ueya/epWCzAwSE?=
 =?us-ascii?Q?V4b8MomG/C6ScRM8mBxPbclvLBW+KFP8eCsCw7Pi6nCheWuQ4SVdQ4iJmGFG?=
 =?us-ascii?Q?tLK20WwyfmqzFDUvnsFHXJNEAJI2jvYbdNkAFuNz8jbtT8yrm/XA9qYgAVIm?=
 =?us-ascii?Q?yEQPB0sh6UmEVH6NJ1Jjh6S1T8i803IGKL4xi4tEMKzC0dxz9zMyP5/rIZ3s?=
 =?us-ascii?Q?9vmEfwYufLBVF0gtwINUUzNEpKWkemLcpA0jK2wOqdB8a4P2hKSKh8axyLBD?=
 =?us-ascii?Q?WAfvSu/UD/9zLKw6F5PXOlrJWe7n08GKcW1aHZ85nlvMSZr4/XHMktMu7d4V?=
 =?us-ascii?Q?W9rO5lN2Dl2GSU2u3AViXGIhuuNmbgz7jb075w5ztWsnUYWDOBdo7H9tlWPA?=
 =?us-ascii?Q?ZoV5tKtcpZPklWsGFzna3W5kBjtIAZoNOeBb1SMns2MfsQYmiqfUmrVx7Jzt?=
 =?us-ascii?Q?dx0BFlct1NsvDg3x5Reuo5sGeWwVOD5ABRKXPHC72KvOJDRd+X7O6gGJ7dLK?=
 =?us-ascii?Q?1hv8Bx1+0sJqgcI8LP49XECpBGLjhUHgR30mSvCcOWrVDQuIgQBSSl2qYe0X?=
 =?us-ascii?Q?dX4XeM2mbAfh+dzO8PgBA5P6JhAy6kKu1VhzztgATQN9mikO949UeXHR3g83?=
 =?us-ascii?Q?ml23ufiT6Iyiqls4nw6mbU5Ca0zIAKezJqZqwicKYRUGG2Muj1J+2wJWMbF5?=
 =?us-ascii?Q?B86IQAkkHB7P7v2A4m4r+iyXokJ++Qg1gfXXExERngmTbvoA5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 06:22:28.0312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c1d3ad-50bc-430f-0626-08dd06d035ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

On Tue, Nov 12, 2024 at 11:22:49AM -0800, Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation.
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.
> 
> This SA info helps HW offload match packets to their correct security
> policies. The XFRM interface ID is included, which is used in setups
> with multiple XFRM interfaces where source/destination addresses alone
> can't pinpoint the right policy.
> 
> Enable packet offload mode on netdevsim and add code to check the XFRM
> interface ID.
> 
> Signed-off-by: wangfe <wangfe@google.com>
> ---
> v4: https://lore.kernel.org/all/20241104233251.3387719-1-wangfe@google.com/
>   - Add offload flag check and only doing check when XFRM interface
>     ID is non-zero.
> v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@google.com/
>   - Add XFRM interface ID checking on netdevsim in the packet offload
>     mode.
> v2:
>   - Add why HW offload requires the SA info to the commit message
> v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
> ---
> ---
>  drivers/net/netdevsim/ipsec.c     | 32 ++++++++++++++++++++++++++++++-
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  net/xfrm/xfrm_output.c            | 21 ++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
> index f0d58092e7e9..afd2005bf7a8 100644
> --- a/drivers/net/netdevsim/ipsec.c
> +++ b/drivers/net/netdevsim/ipsec.c
> @@ -149,7 +149,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
>  		return -EINVAL;
>  	}
>  
> -	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
> +	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO &&
> +	    xs->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
>  		NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload type");
>  		return -EINVAL;
>  	}
> @@ -165,6 +166,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
>  	memset(&sa, 0, sizeof(sa));
>  	sa.used = true;
>  	sa.xs = xs;
> +	sa.if_id = xs->if_id;
>  
>  	if (sa.xs->id.proto & IPPROTO_ESP)
>  		sa.crypt = xs->ealg || xs->aead;
> @@ -224,10 +226,24 @@ static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	return true;
>  }
>  
> +static int nsim_ipsec_add_policy(struct xfrm_policy *policy,
> +				 struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static void nsim_ipsec_del_policy(struct xfrm_policy *policy)
> +{
> +}
> +
>  static const struct xfrmdev_ops nsim_xfrmdev_ops = {
>  	.xdo_dev_state_add	= nsim_ipsec_add_sa,
>  	.xdo_dev_state_delete	= nsim_ipsec_del_sa,
>  	.xdo_dev_offload_ok	= nsim_ipsec_offload_ok,
> +
> +	.xdo_dev_policy_add     = nsim_ipsec_add_policy,
> +	.xdo_dev_policy_delete  = nsim_ipsec_del_policy,
> +
>  };
>  
>  bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
> @@ -237,6 +253,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
>  	struct xfrm_state *xs;
>  	struct nsim_sa *tsa;
>  	u32 sa_idx;
> +	struct xfrm_offload *xo;
>  
>  	/* do we even need to check this packet? */
>  	if (!sp)
> @@ -272,6 +289,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
>  		return false;
>  	}
>  
> +	if (xs->if_id) {

If you are checking this, you will need to make sure that XFRM_XMIT is
set when if_id != 0. It is not how it is implemented now.

> +		if (xs->if_id != tsa->if_id) {
> +			netdev_err(ns->netdev, "unmatched if_id %d %d\n",
> +				   xs->if_id, tsa->if_id);
> +			return false;
> +		}
> +		xo = xfrm_offload(skb);
> +		if (!xo || !(xo->flags & XFRM_XMIT)) {
> +			netdev_err(ns->netdev, "offload flag missing or wrong\n");
> +			return false;
> +		}
> +	}
> +
>  	ipsec->tx++;
>  
>  	return true;
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index bf02efa10956..4941b6e46d0a 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -41,6 +41,7 @@ struct nsim_sa {
>  	__be32 ipaddr[4];
>  	u32 key[4];
>  	u32 salt;
> +	u32 if_id;
>  	bool used;
>  	bool crypt;
>  	bool rx;
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index e5722c95b8bb..a12588e7b060 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  	struct xfrm_state *x = skb_dst(skb)->xfrm;
>  	int family;
>  	int err;
> +	struct xfrm_offload *xo;
> +	struct sec_path *sp;
>  
>  	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
>  		: skb_dst(skb)->ops->family;
> @@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  			kfree_skb(skb);
>  			return -EHOSTUNREACH;
>  		}
> +		sp = secpath_set(skb);
> +		if (!sp) {
> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +			kfree_skb(skb);
> +			return -ENOMEM;
> +		}
> +
> +		sp->olen++;
> +		sp->xvec[sp->len++] = x;
> +		xfrm_state_hold(x);

Not an expert and just looked how XFRM_XMIT is assigned in other places,
and simple skb_ext_add(skb, SKB_EXT_SEC_PATH) is used, why is it
different here?

The additional issue is that you are adding extension and flag to all
offloaded packets, which makes me wonder what to do with this check in
validate_xmit_xfrm():

  136         /* The packet was sent to HW IPsec packet offload engine,
  137          * but to wrong device. Drop the packet, so it won't skip
  138          * XFRM stack.
  139          */
  140         if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET && x->xso.dev != dev) {
  141                 kfree_skb(skb);
  142                 dev_core_stats_tx_dropped_inc(dev);
  143                 return NULL;
  144         }

Also because you are adding it to all packets, you are adding extra
overhead for all users, even these who didn't ask this if_id thing.

And again, you should block creation of SAs with if_id != 0 for already
existing in-kernel IPsec implementations.

Thanks

> +
> +		xo = xfrm_offload(skb);
> +		if (!xo) {
> +			secpath_reset(skb);
> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +			kfree_skb(skb);
> +			return -EINVAL;
> +		}
> +		xo->flags |= XFRM_XMIT;
>  
>  		return xfrm_output_resume(sk, skb, 0);
>  	}
> -- 
> 2.47.0.277.g8800431eea-goog
> 
> 

