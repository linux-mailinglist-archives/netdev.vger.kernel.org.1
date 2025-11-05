Return-Path: <netdev+bounces-235756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E3C3503F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54A1634D849
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC85A2DAFA7;
	Wed,  5 Nov 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8K/wXbP"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90812BEC27;
	Wed,  5 Nov 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336989; cv=fail; b=fGVybEzku8WLjptP2ktZI4gdPSeR+QprbG2xUXTziXxIIGSpxVPV+nUzJFP0br4qVs901Sg5g3TGgV+mBdFDAErOTy5IKeJUVQqeG0cyUJjYsLYlPB2eadhgjfX7ScbSZpNKnQSE0+1t0O0ECxED85YaIPkcBHzRC+V8kOJdWTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336989; c=relaxed/simple;
	bh=C0wIALhgZPLs7x6Q/fWZRZ/jCQFGABw6z2eo/3ySL+U=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rummNe5fQETXe543no+bxGd6tynEeftvPdvJryhykWmUMVUso290O44MZc9CIPW8IF9HbszuHtGQUGjsa1w1TuHglmy9Fccd6FDfgKPCa6WJVofn91VveLYuH2lTzl8A7/1thMV2Z0mTWpNR/GrNc+VejgtOArR/gtew4i0wTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8K/wXbP; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhEZMHq3JYSSAlz1SbPw+z+uAk2rHFiAHn+Ya1Uvl9lsQntuhK019Dz+Uc2FWYaeD/lgzgf2QMRitMWRXc0UEI1kD3EXkwmGgM3Fo7BMEIP9BNcEgsPBTy/ytquw9yj0fmjA/b3/7vXdjkqD7ux0h89dmx60aMmyRJd6Pmw1fwWcSK7tReL0g1Kq/f3FgGhciT91bYtpmtThxBVwH/MUAG4EPcBixx8jBRFMyT3tH4JaqHFuYkWLWCrf60dach1aNlDfzZ5ze4j6dOrkx9M/grpFUaLjbUl+bfAzZACMB7+ZXSmbmVF95cBJ4VeVUd4BQtIXexAziXzgfF3ggbKBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8xaaryHwWkSoN3bxqDEXtJ/7rg0HXN0oumd3OigNsk=;
 b=SqK3KXJ8w2PVYuV+CNJOffydhdHrbf3f0a3ZPvSzkNXB/DOM3uywMeDHYO8umyQKupIlvT7QJsjGHsmbv9ktZV5l0z8A5YHwwYGrpuw1rnIO9UIBuM+o3aF7Iln2qnDtyNJJvTsEYPZ/OYuqqkysFI50fzizG0RbKhSti3co2n0kbMq8jK1TxqUePKpM8PCL8julj14jVk6H7o/Bo5ZgI4wacUScnGG6v+5bhc+7JCOJD6o7L7qnMwbrO+sRnRHiAYQ7DZiR6YObxiC7Jb9Sb8812t5RoFeX4qwTAJIwfdrP4+o54ByxVbGbNCGcomoneSsQ3QviO47X7cOTMIGPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8xaaryHwWkSoN3bxqDEXtJ/7rg0HXN0oumd3OigNsk=;
 b=o8K/wXbPL4LAt4BOi/IuD8qnnzIGTdZcNkuAZpooWJGOzgMrp8ScxwVJtLDDBOQXB4HuTrNuto2g8Ch/L3MyUPKrhJKMvuxgRQoaR+qmjfp39qyDbs1RBlFIJrR1/qyLXohiyukiY6WHHk7RI7CTS01AGwpk8/4xwSMePcA1ceJrpitIOiYB0fzAMtFc8nLWnwDZKNOYU774XNt2BAjroRxUTRW5Hurs8Q+NyrZbz3adFPMV0tu5w/bSLzrGVVJ5RDQRj3fWuhEoaR5WQCb0IgDiAXmkAyjsXFfnq77WkvbrfwFPnhb7LDBISbsBNmJHHVdiKsNNmJgqKytQraW3dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 10:03:05 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 10:03:05 +0000
Date: Wed, 5 Nov 2025 10:02:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, jasowang@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state
 check
Message-ID: <miwqc3uxmvvs5efvcqv7s4boajxjgko2ecqkyeqk62e4pwjexa@qi24ta7rftx6>
References: <20251105080151.1115698-1-lulu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105080151.1115698-1-lulu@redhat.com>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b963a8-87b9-4a5c-8cc0-08de1c528375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFlc8HvkXC+pb4jsBoOhkxgcrcSUzMbdobrdYux92OAz088mys6lG56xMfOT?=
 =?us-ascii?Q?+qh+QeL2Q65cuLdp+LZmuNTU/8HJP6fJ6NhZle55c/NzdTi6QvOxh1X1kwlv?=
 =?us-ascii?Q?FuQPyDLozymXVJjKyz5qkBCR3MdNnHfB5pa1f7iQRRW9L6bWsXhI7ZDPXSDQ?=
 =?us-ascii?Q?ahYmW83mV1OUyqGiNWOT3y0fLsybvy2U8dOeOqptoRP1oT/obKw8iszocIqP?=
 =?us-ascii?Q?4QWQaRbKsnNEnvAiMcuzYtftpdgM4Q8azngudmch4bXnmlGP5sNbVjXYTY52?=
 =?us-ascii?Q?Ik3pkgE8n4Q74MatVNpjlIkS087QDDOM+lU2xt5kA7wAn2FTy2TaQvg6TF7I?=
 =?us-ascii?Q?u8zDg6D4ZFuf4FbBn1RpU6u0pOJ3AvkmTcwWRU2Cyg0QFh3cTxna4pUIz1U1?=
 =?us-ascii?Q?HQiqyDugdCuoER0SZ7purCAGibNuBreYfnEJnPw8i5BCHU873m4hqPgIvKZ5?=
 =?us-ascii?Q?b4PNl9tz1d8aSPW4EwsQ7WIN0/0A47qsIx9FJGSChkhB39fC0CZiBdHOD5gb?=
 =?us-ascii?Q?YjKeKsFcKr6fKj3DKxB4BCniBxWLE0H79/QVLZHzNo2lVOkDKsFhcCm4H8hn?=
 =?us-ascii?Q?dJ4V/8kCajOsX5Yn7hJNVBg2l01XgciYecmiLM37eza+419uzXdPDMqZi50w?=
 =?us-ascii?Q?4RvtvSRxCb3Pd8UT8VxYo3tNEMMpB0xH6i5pX61tQl3AjGSl6p5KFqOSGFDl?=
 =?us-ascii?Q?FS4E6u9Av5JaB9SM9NvBpMYqp86vgw+Xk9BbbXrjVyCcrshw5Zk252GfGBnw?=
 =?us-ascii?Q?7XLctX6A29sbLqW0RlXLi0cHJG7uHY7s+TVf/6KKN54HD8TWkJOt6PV0apiw?=
 =?us-ascii?Q?2XiMFPJIkjpqvzLqtMh55hnEJbeAWt2yEoDqYUEf1pfb5NsFislUpXhC3RpV?=
 =?us-ascii?Q?r7LyhSYNBQWrZpZ3RhGexkOhAxAYypkNrlpZ9F7HYsfCsx7B5uIUgy9XYKGO?=
 =?us-ascii?Q?JKBQMLz+KVCmEwX+4OW3bYxbVlUCMhy7GNSZD2oftL9OMmrZUKK/MWbRy7Lx?=
 =?us-ascii?Q?anjNXLrzejJvWARk6ff2p7WzWTfSl/2Q2gfUJgRjwvHRCDAnI3i32Ga5S/39?=
 =?us-ascii?Q?c+gSwkF9UwVgsntAy46ej78k3hvKcZZ0tPv2U/ZWZSn9+I4sl1ckVqFWhmqt?=
 =?us-ascii?Q?5Hxm6VGbDGEZ1Oicghb0J57PC7Wg1yA5oyO0OFPsW78Z8RKR/MIxxVqIk5gf?=
 =?us-ascii?Q?B0TyZt7HZvelwtBXTL0K9z8Q2PJeTKZ5EPjvve4YekjDuOXFU5+REAnGP+q4?=
 =?us-ascii?Q?m7wkvZYj3jENYUsp98z26co3rvvW5Ezmo6wf+rqAk5Axe5xf8UVZtgwLrJfF?=
 =?us-ascii?Q?F5woVrIHDMiUCwVlk4Qsi1dKq/fxQEa1Dwf557PGUhKTQBuqzs4ZnpjQU1Id?=
 =?us-ascii?Q?A9JWyBFfO4V7B/le+DlWnYeT/XpWEdMkPeABohrNnyYE4P7Y7r58CXz/BOrs?=
 =?us-ascii?Q?wdgM5hHmmxOow3pS9/sp43+Pjbcvm268?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0zef/fyqJ9+hamL+kkLwCs4frdN5DzGRZtQBFMoOxRY1g3UTjNI/bf6O6v0?=
 =?us-ascii?Q?edHsLxI/qoMB2qslNOf8PDMWY3ltHkYGbN3COu7LIJ4TvF9mIr7ISdWvfypx?=
 =?us-ascii?Q?K+XogqbN/CvqbA7fJCbH2plGTWQM6IX6zK0xzHPClWBbK+egBYHvDWOCWZKg?=
 =?us-ascii?Q?rshIOwtmUXipODqDGt22Z4xzLA+mSqByoPExq/EvkFB4p0hi24+QGvuDnmja?=
 =?us-ascii?Q?1qtjJIvMsTMDDF2r8C5YTVk8ZrRwkuNpJuGKQw6yDZpAVUfKZ/S3LLdmnoEl?=
 =?us-ascii?Q?1IKO1SEh+zkIfOkl7Giy6hUTTmUPLYSIah0qn2ZcaSFuvVveCWgK3xTXsL5l?=
 =?us-ascii?Q?N9Bv8LWsXZxptX9C3FT2WWBDCwJ21VZjAEUp0QFDrMI1xYX3HvMwbAiNutDP?=
 =?us-ascii?Q?+9irPY8mtduaIdN+MOw/NtyKLYaztJXuqpQVXuHAFLOISyXJgcaz7eGQpaVO?=
 =?us-ascii?Q?OT7eoXB3TCZmMg5NUb85as8AZUsle0n0CSY1IIGvivSePjNUu+h/7i25Ve+m?=
 =?us-ascii?Q?/siimhHlc9qXORdKMJaL0B86u84EVxC6EDUY17yc1hTSdjcmTY3UH2Ql7JYx?=
 =?us-ascii?Q?YkvYSkNmY/zWLkHU54PfFLirnHCi8iSxpHCRBYitEY6bC/SD8XCNgDATJKKV?=
 =?us-ascii?Q?Osp51CpxD2WhyZVurYuj2Xyz5IBDuFEo/fjkRXd4hwBnqCPbTC7Z0S+WspeA?=
 =?us-ascii?Q?7KifexFr+5JtS1q2jrG7Pc+1bDE2o0P7qgMXDQF+XrvtxFuKY76D1zK9z2Kz?=
 =?us-ascii?Q?H9dw9tQP/WXYer4dH0KnTTyGm5cbk9W280wC+ZdQE4SOO5gupci25qCVxT0L?=
 =?us-ascii?Q?9uYQPsg4TvH2MT2tnyoiDegdYjS7nP5S1KNU7LbQfC0997YcOeYsMYXB1cYT?=
 =?us-ascii?Q?7QkQHlbTK/Gst5dWxT1uFg+Rjud/3lEYGhNsPbaoqEZeMfXXtV81IiC1mAvs?=
 =?us-ascii?Q?kvPA5oC0klMJ46VxgzU3IQ7MnGrynabBLMBL9fD37dRzoPG7HeFhQ6gIWerH?=
 =?us-ascii?Q?uwBstEUOswnLq0J98PzXzdhJcpeCHPb6qT8C65+hYCt80IZyAceGowVye6V7?=
 =?us-ascii?Q?olSGfzd1yWVTdu+M3Wh4WKrNt+4q41ggylS2wYlAqQYxLvO4BX+tYQdwyhCt?=
 =?us-ascii?Q?bYjmvU7ZJezxoV8spE91lViw8UfdjQ67C37F5lBB2DWfS5tiUj6CkRgnGTJ3?=
 =?us-ascii?Q?hQNSX5cnlIfHkVPs+rzda1OKt5Y/7t8OtQKx6j/lLJrm2yEWGjQvjWYLUUf6?=
 =?us-ascii?Q?r2DoIHAtN4g03zm2yv7g4w3A4ZOewn59SR4uh/cTn02WTpnRBTZ4ZcjRfhQP?=
 =?us-ascii?Q?iYrxssrBN3j17XkmMVF88y5FrAsS4y8uZzYL3eP1+XTsTg0TQswYMFSD97CF?=
 =?us-ascii?Q?vBfKY6ZqZb1RBPbly44k3VVGi7QNg0gChapC9s3Nahrg/24ZFPFiCGcfB3YM?=
 =?us-ascii?Q?W+MSwBUMRCIatRBgXW4EJhGb/YP/l8njfUwNX66xmLccDHMtkqccT+sdqY8y?=
 =?us-ascii?Q?22ibgugo3G8OVpRH8snibFBzWIjk9LggDaOEOVnnrsEGI+e/GUZoy3CiI6SX?=
 =?us-ascii?Q?BqgFWKVvx9j3RSvtbOIhOccd7U/219g7/dkz6gLc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b963a8-87b9-4a5c-8cc0-08de1c528375
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:03:05.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzQoLQOe9zxQcpio+Y09elo3Je08b248iHrsFlp6xNJoqNxC9rCj6m9i42JYjg/Fugeb3c4loKAcomE2YHmqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

Thanks for your patches!

On Wed, Nov 05, 2025 at 04:01:41PM +0800, Cindy Lu wrote:
> Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> feature bit is properly set only when the device is not yet in
> the DRIVER_OK (running) state.
>
> This makes the MAC address visible in the output of:
> 
>  vdpa dev config show -jp
> 
> when the device is created without an initial MAC address.
>
So when the random MAC address is assigned it is not currently shown?
I don't fully understand the motivation.

> Signed-off-by: Cindy Lu <lulu@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 82034efb74fc..e38aa3a335fc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	ndev = to_mlx5_vdpa_ndev(mvdev);
>  	mdev = mvdev->mdev;
>  	config = &ndev->config;

> +	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
> +	} else {
> +		mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\n");
> +		return err;
The err is EOPNOTSUPP. Is this the right error?

> +	}
>
Why is this block not under the reslock?

Thanks,
Dragos

