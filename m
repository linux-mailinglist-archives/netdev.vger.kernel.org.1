Return-Path: <netdev+bounces-215587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA12B2F5DE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44378AC0CA1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B430EF70;
	Thu, 21 Aug 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gr6ujj7J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D930DD3D;
	Thu, 21 Aug 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774372; cv=fail; b=ZWaFtbPs6ivOf7EGgEt3WxuUx9e9mww1iZG/sDqJOyBaP6+bRTM+eDZKtXh2tTgsim+E0fL9Tv3JSDzGRLD1IXKeJiP7lglm9eZneW5l4u+yAc98JN41y5nOsugFDkFvaNcp9+3twU6aNRiw4RiX1JZYI03Abm4XP6Fhp2jMowM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774372; c=relaxed/simple;
	bh=KiFdvzSiHOtPZA/uH1AYoqbon2aLRjLGfBrHSRcAoec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amDx27Iy7bS1MabnjZM7a+AMnY+0CtNPuVybmIest1WDF9+KBnGvnq1NPJ6DoepVPCoR/fSZZVwyy/5avhL3uZqR7GOPsPMPVeZtWv6TgaCvFcWwi105W9hL81OpsGha4PgSU8ChvS4LGEnu+S1FipuPou/xeocdoalETz7GHTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gr6ujj7J; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQPrG+a1JmX1q+JfFG8xX19Z67yKzVgDLs1gcMLLfUq/UPNJtbwZ1Rqb+VyrXrk9pKtBRHEgXbB83sntA0kZ3hX+dY0fGftM+p8CP8C2XCw7Ybl8GI480s1Auw1ZopZPeaBup/Utrjx9Z2v2n/vmy3HNoGw42evJ0gdDueGomwpZyBIDc8ePIrD+Z7TLJq6b2+/dFT+arZQwSn44PY3x3GfKBzPal+JJdLNiZmOYL4iGUblVQRefu72Q2xst6nDP6pDG6YCwVi3rE5faOu9ZMXt2FyuWTFb9ylr3D86LBAv4supIWk8n2LB8F2LQCY0Xym6KMajastccuNG/RoldrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5uhweenUxS/RUOBKvmTsSvczRSMYAqRjshJn+GqHlM=;
 b=q6aBcXjQzBARkMqlHz3q7e0obDQFzDdWrdw0OlTtTQKTBZOgkZzXl+4T0MYvKXVEKewisTWcVIdp5jpxTsxHl+QMoRTZnDK+KdJqiSAg+tqPLJ8EI57h5+Rop9gHZ9WR2enhJmXb9ghCoxMZiCoB1sqmXkTeAf1sbdE2nOWxTwiLCVs4OU4UZQio350QwI6HnHT052jpOTbx2ttYi7RNnzYl248TSfEjXXU8dpmpDu9G7kL6QzAUMaC4/TDEnq/RnIrXygU2sgdzJzKlpgAMHfGvxgjciJXmzAYMJ5pVkNqj3sLgaEFOjQokLng95m55jwwG2Tpt6AIdgN3/auEeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5uhweenUxS/RUOBKvmTsSvczRSMYAqRjshJn+GqHlM=;
 b=gr6ujj7J+N4ObvUI2FLXWEO0e1oJel1fODQ5C5BWHml0MOUc/2Opw+mO0wT1EnI4EjpqFURo4+CFysFTE4m94/chCOTg/4sB5/fj/eeaZMCjxWK9eKIPcaoSGNSjlCvCQl46QBg4RUBTtG1EBCpHL55nNzTisOrFxXUuzgRjWKAT6LphFfCGKCMFt/DWgz4i3GHyGPD4tzJ+p5uAsvw1of9Up5wHn3iQKP/MnnCkkxvTplw5fgQB7jPgn/jXpIGOQVf37R5LCCt0FU7N9mVMvVdXGoXsCTNzIrW+EpdGPm6/FNKClGaewpFXSapGXr8VtbNjVxGgiYi8nXXGWkCIzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 11:06:07 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:06:06 +0000
Date: Thu, 21 Aug 2025 11:06:01 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	parav@nvidia.com, netdev@vger.kernel.org, sdf@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/7] queue_api: add support for fetching per
 queue DMA dev
Message-ID: <t2zyihqylk53fwnu4svxt6rrq22noulgbumos2tu2calwclsho@dpcfos6aldo3>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
 <20250820171214.3597901-3-dtatulea@nvidia.com>
 <20250820180100.7085a7d3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820180100.7085a7d3@kernel.org>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a0de8d-cecc-4cd9-bbbf-08dde0a2b991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6crlwdGiesDd/SI/Zqp7qBtrxkHMuxPNOEdWKtRSDAdVhJ/EKSzo6bTNA8LW?=
 =?us-ascii?Q?6XmV2jjfIO58X2WcuW+YXN+C+7Pe7QkQBWaKIUPyYJbfUSz+6LowdQYeuEGj?=
 =?us-ascii?Q?NFQntSE2SgpJhkBir1T9lVC8TZVcjWdPs4wlnp3wrkFuaMM4AVtG3tq10Xt8?=
 =?us-ascii?Q?Kx+zV11UGaAvOhSyziu7coAaoApJtpBUAD/PVmFolQwYF7NGVMCc1W1ir6yn?=
 =?us-ascii?Q?QSvgO5TxChBoprcci63ZTQlrfzRgm/DLixJyoqrkgkxlsiU5+2Ff0QKLG3Dz?=
 =?us-ascii?Q?N8qkBM/YdUSshkVIawEM/oIyS3dLQZjpp6Ti6wfH8MRm4Sx1tuxxGS7Dvtan?=
 =?us-ascii?Q?cLxlSUba0WSLWcsJuVB/Cci00MXrRg76SPvhlPh8+venZd4qrMgV7HOkfwW4?=
 =?us-ascii?Q?S8Ga7/kKKYM48L4v7JMwcWtb4+1bFcekt+AepThZg8FYCyrU74R9OdyYxZbY?=
 =?us-ascii?Q?h2keFkr/QLQTHzGJ+KOh9h7sfe3DTR25oa2mFF1fTx4SnFUW9HacM9LLkI3p?=
 =?us-ascii?Q?OGvfFBw6fVM0jJ2wLSsiFBgHwgoCUsdwrJgctY0B01MlDP02v0Vm122ZKqzf?=
 =?us-ascii?Q?5BwVaKFL4MKxDb4JnULk4aBOVRvCODJwdMMVE6HzktyKMZGy/Kz+pfKLFlr3?=
 =?us-ascii?Q?qLmqrB7Oug+uudCq7Ip0Lgl+lmfGrdUDGOCZ9Eh1OH7dFZD04SrFhJhx7QvL?=
 =?us-ascii?Q?ugqSbg5H4WLX8efaryOW2KXTuADzbcasF4HJATDHa7017mDeSveRNFtJX8+i?=
 =?us-ascii?Q?gXIdernmRkaARo5sIvhbkQJxvusDf0KYfGk9fkVvTT1Sdz4aFBU4jryGfKRd?=
 =?us-ascii?Q?AiKrSzFqQfXkUyG+//GYR+8TqG17Lw4741WvA+02Xek98293P6z3tRMG6ST6?=
 =?us-ascii?Q?KMxtNzRzD5l+lm3ZGrSFnl45GHUzmWJ4vNWPNW909WP6lbXTZf2Tsrk4JSrt?=
 =?us-ascii?Q?eeHu9Bx9WWJ/Sj8BCm4gMBaOkBDxLSbQPjcunXOzalmfXnzuIf8mrQUFFHpI?=
 =?us-ascii?Q?06JN2ETH0u78HSWK3+uPT5r3Fz16mq3LwxEouVl7Djv493uCYFXMRVBdKj3P?=
 =?us-ascii?Q?WvuR1m1mPtCpvgdkVjINCjfN/EMyf+iau77tQvlvyvxZObURjJhr++A4jjG6?=
 =?us-ascii?Q?BBukZGsuskM/fTkkqys1FCiX81aQXwgbnbPkC9oPfXI9+voGjEVEwzLI3AU8?=
 =?us-ascii?Q?oDZQ8TupgujADeQkL7KUnP9SXnG+worJYv1czhWj6dtPjjY3qE3nEEUoXSnc?=
 =?us-ascii?Q?daew6upun5lZQ+IascnKs90XHbU9suTqNcsuDSOLTJd4oQy2oGMUCW+fJzCp?=
 =?us-ascii?Q?IFMdCdf/5F3y5jvqZuzD1GII3+bXlYntMXolUeb/Fjuwqu3q28ulQwTeyUvJ?=
 =?us-ascii?Q?T6+Ux+KGifteGXdOz934Km3d7sPmj/xBxN07csqBxlihSBksMtGVqAvgHSKq?=
 =?us-ascii?Q?VpmvQ8UEvYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7a1kmGQOGbu5Hc2q2aRvKf4aq0vidNR+77DkItXtzeMOViOpRupkWJ8ujSN?=
 =?us-ascii?Q?sIohweTeFNPSIkVFuSrcDOQb0XWAMIBZDi5XxkgHV2OaOBnXZJj7QCp4AMrO?=
 =?us-ascii?Q?/Q0tN6V8mB6RQKyWKsOngdcRwSr1Qvbk/pVH+Rp4nCRxsnx/b7Z5JbfM/Y9P?=
 =?us-ascii?Q?qPeAQLrLoluFFtzWINa5ibEvpaL9s/3AhgFCGRYSiQqd+NmMbBfbunxavSk0?=
 =?us-ascii?Q?0VMrbxsMloCojTpKcoFGyxsjojKGIV81d0kBilWB5xOkSSYHZfgOUuau30rt?=
 =?us-ascii?Q?Y+TCUgOWqe1NRuvIuhG2IDFxuY6Q7sRpIZX4+HnMoxyQcpG/qrdwuSTjrtn6?=
 =?us-ascii?Q?H/xAbQ05QBjbFRXYVXR1es8tmzl7hvLGwbtgxHNzQY84nXeFmpagRaH787Ko?=
 =?us-ascii?Q?54OLaIIKe1Twgj/7+QkhTuiP63UZRa/hJodY1dFhhqlCDCraKiV+z4iAxJ24?=
 =?us-ascii?Q?3UgjZBatnaDKXS0LQEC+AeARzOmPKfd2RHRGFjPKkAT2VPsUaFFcvxf/mQmY?=
 =?us-ascii?Q?0F5W1XogZmoFQTY7fQW94HGvIQF1uTbJ8OD/FrrB6zjb8rTInqxTBRgP6aZn?=
 =?us-ascii?Q?p2GAJv7d6tFgftID87YIJ7SjXYeAXptkj27vgKpCjmHcyrSE5XMAidNlY4/d?=
 =?us-ascii?Q?+9M9peeiNcon+ljeHHVL0ltGm00E7AsQ7uwN7dtwhMnMFuySa/K0c8Y94my1?=
 =?us-ascii?Q?uPgLU12KTrKe79o7q6hJC9XH0ebK+5bBuzm2Jhb5+W+2yqIMOpsEhnzMVY6r?=
 =?us-ascii?Q?nbrrOcHzPaj9xuRyoE1rUhTf5LwjHJc32hAFlle7jOZJ9PVm/dDpRoHPxi4p?=
 =?us-ascii?Q?BK6XL21ePNiVplIgwWfEtmoMgqg/RIdi2ETw/yCBFqhLlPNojpge9zv0RBJm?=
 =?us-ascii?Q?gC3r7N44iYl2kfcY7302GNApRcOklZUW/NU7uLx5LN3IV8U9MJT4mkdiEq8S?=
 =?us-ascii?Q?XY10utK+0bsd25LJflOKeKY7dDZFbkYdxcVY44xVsdPCNJwsQFD/zQPddDrn?=
 =?us-ascii?Q?s7RbnYSlXVBmlXyAFQe63kJZj4CCslmLx7T265BC7DF3vVSrOcnKh6FoHYuu?=
 =?us-ascii?Q?HrYtYjDk9xVY6c9NmjoJg2jHqeFNumOXZZEnNLpg3zv1zbX4w6WZP1LmBcXo?=
 =?us-ascii?Q?hrkImy9zMunxC3AhTXQNACJNzegUPOKYQls3kEzawzAtal4FAdQZridfvjpx?=
 =?us-ascii?Q?t7G0gkt/XqdalXxPU1DEfbmpKTJacQZheukdQQzVU1qzCqWDBiUuyi+h7wDk?=
 =?us-ascii?Q?DnAgtEulXECxd2su48bq2wix8SrL1u2tMgMQ/isE2blc2QVJvf80jHzuzvri?=
 =?us-ascii?Q?OGP0uHcyhrKaiOx0TVMhUtrWuxTOKcINHDyI22ynNC4dF7F2mkHV+FKZ512V?=
 =?us-ascii?Q?108JgN/GbVJeZZJuuizsqMXEwRHVfDwCXbmZTbqUAa4qmehDnVJ77/Zz3Xp3?=
 =?us-ascii?Q?itsF48VddZSNH/IklWXC85j4ZcYYAb+JRIAMRPfdRTnqui1UGZ6dcjM7LXoJ?=
 =?us-ascii?Q?7cWhFcc3v8u70K+DL1LJSyGctr/+XQ/nmocgHG/uPK3yxOoeLIulMkc9G5KJ?=
 =?us-ascii?Q?dYDBWPJS6VpKw1kVhCQc3Kss2FJMywhjS+STEGV7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a0de8d-cecc-4cd9-bbbf-08dde0a2b991
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:06:06.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBAbuGGHSOL7ff1Ksr2h/IjY43yCyQX4Xcw9eTccfHiAQmydCj7H0XvscclBZsYNeKARGQIcwKUfKYcY+ejOeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

On Wed, Aug 20, 2025 at 06:01:00PM -0700, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 20:11:52 +0300 Dragos Tatulea wrote:
> > + * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
> > + *			   for this queue. When such device is not available,
> > + *			   the function will return NULL.
> 
> nit: I think you're using a different tense/grammar than the doc for
> other callbacks (which is admittedly somewhat unusual :$) 
> Also should we indicate that "not available" is an error? Maybe just:
> 
> 	Get dma device for zero-copy operations to be used
> 	for this queue. Return NULL on error.
>
Sure. Will fix.

> >   * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
> >   * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
> >   * be called for an interface which is open.
> 
> > +/**
> > + * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
> > + * @dev:	net_device
> > + * @idx:	queue index
> > + *
> > + * Get dma device for zero-copy operations to be used for this queue.
> > + * When such device is not available or valid, the function will return NULL.
> 
> Unfortunately kdoc really wants us to add Return: statements to all
> functions...
>
Ack. Will fix.

> > + */
> > +struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
> > +{
> > +	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
> > +	struct device *dma_dev;
> > +
> > +	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
> > +		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
> > +	else
> > +		dma_dev = dev->dev.parent;
> > +
> > +	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
> > +}
> > +EXPORT_SYMBOL(netdev_queue_get_dma_dev);
> > \ No newline at end of file
> 
> This is in desperate need of a terminating new line.
> 
Ack. Will fix.

> But also -- why the export? iouring and devmem can't be modules.
Oh, right! Will replace with a newline.

Thanks,
Dragos

