Return-Path: <netdev+bounces-204155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA6DAF93C3
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0353AABC7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 13:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8B2D9EE5;
	Fri,  4 Jul 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIp/yeYB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D32D63E8;
	Fri,  4 Jul 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634691; cv=fail; b=mwgJRIg3kA9BsrXULhr2QhkgPfvdsD5gbwPSj6fgQg7hUfmsKfirTeOwo0guSX2xq0mrr7402qplSI/mbUDim63g6p6E4tOGd2n8l+dg6xUJ0Y0uSX85U8m+7aiFfuL7aOD0uJG9US6XNTpirZ9Sm0MeeCaRmLtnTht2Z96KY8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634691; c=relaxed/simple;
	bh=TdVpw5t+sLPDuDK+dLsZXiheTHBR1y5Xv3ORcv4v1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QFETkmeX5jgn4uSy2+Seqj4TdBSvUsU63Cvz2NIaMyDFXgn/gF2dXj4pJ1dbWoWtOUdYm3LvCEASb7Y7X8ivT/ia7CPkM1Z7IAafgZtjGSXMbOR/RvDUfc6E4+M1NzwRjUs9JUE9bUHVoY9V4wkMcvxfnciWt8IwKmwd8qAagkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIp/yeYB; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFWJyF1o8EdJ8uIWUmb8Aa0vPAK46zYa5Os/sBxFxxpJjIqlZHUJqTnTQMpsg09OoeNtRMe6e6jTtcBj81mktwDEcZHim3muWvBNEgTIVs4rN5b95IqRSlk3zODBKSIAiA7DvlNg+nBiNkvXem9GWx050Nbc4Zggff34R0tghmeNQrqK5+d/5+m/UHottQMw/cCaHofMiF7TpNp45RdG4v9m9GF9uXoQNnmZmDfNQbQH9u4l0pdkgI6wujb0NsoKq3cnsaSenoasjvmkpVe0I/Fb0V0x0ZepQLNonoxLXUeDQCy8uhHKRDgFR3Zj9sJvYwUj+H9Xab+mF6sO04yUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi8vjZBv6sSVhMg1N+OmnvXfR+6UjPms9QMI7EZOApQ=;
 b=o/0RiKFK0xpRx9LTFvYCrgww6oo8dAUlAqAq+L+BuJhKHui2lLFgfsHsOIgj74Awj3+wpImnecLpC/pr/UfVXrQYlvJl8jmBu4+RjBcGHv8JCAySsqOk6j0IJOul53Yb8I/pmh/8sbWC0ivQB5TuJ2V5MyTB45VhvJOEKuzaKuw3f0myfa4Y4D76SCS9YW7+TCKhUd21d5DFuOUpqndEOHSVefom87lOorrPXTjmUM14Omqdyf7O6uLFCU90iNqZmRQhs3kRcv4EPDVLjH7rXZao/FRpyvMI7ixRmmNXtLLr+zTi99TEzOHqaqr5Rk+6mpx3gHLHkLPczxXF0TLvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi8vjZBv6sSVhMg1N+OmnvXfR+6UjPms9QMI7EZOApQ=;
 b=dIp/yeYBoveB4Kv7HrNg5XcjX7LUbd5l+KIFzTpCCUbVX55RkH5mW9dOMIZJk9zqndhMT4dOalhNFUPDMzOKEvo4/zL/3jgEqjGWoHtgSUvgeVVdUAOLgODt40Oc5f2VjQ/iELDqdS28wLa+Tx2ZeEpfjytbKqHp3Te2i7QLUzsWziADU9k2py+xYY4dMYFUJql1heeLnxzLHvEuspsejVqrjcS2rckFLLfIDJBa+CDg1EqcX8ExJIHiWrtkk2cGqdEr3dgpI16TVoGC5n4w+U7aICGCSzMHD7hLuUr37KyQq7BhOdqA/im3T/wMk6MEHaO40vjTbJlRzSjHAnor6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 13:11:24 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 13:11:24 +0000
Date: Fri, 4 Jul 2025 13:11:01 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "almasrymina@google.com" <almasrymina@google.com>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 839598ee-338f-4bd9-4594-08ddbafc472b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dceMWbGzp6ILw5TA6nIkR/694g0A8RCaMWv8LtBHLIh/Gtw91QkOw5in/1qi?=
 =?us-ascii?Q?zzyGRM6JDmI9visl1rAMJM/DjOTSaIliP4Wx+gJotshRMQMIkUIaDyowK1gG?=
 =?us-ascii?Q?nt+JPB9Z62EsRWUTp+nBnxJj9WWLL2vo9uRJEaLLuW0jbhr3DANNLF3CBV6a?=
 =?us-ascii?Q?WU2xYOzYWTudqjq4rXdVI6cJx8viRp5JgWIcAnulKk1oA0uYjYoKEjBiKAVE?=
 =?us-ascii?Q?lmStlqLkWl6+InQ1Bko5WG1EtkHJxnpKc/znxqt6EUiY/We/F10X0T521XQW?=
 =?us-ascii?Q?K7TLQfj4ALy5BEGn6Zifgp93d4ZHTYUgksyDpxwGofICuCnfeutyQ+3ThBew?=
 =?us-ascii?Q?A9V2QLpYeMbCdILI8uuwQksrrY5/U0id7wenwE+vydMIW+r0TsPtonf+ORa9?=
 =?us-ascii?Q?ZTHobhP76hG5ZLU9knAx9AjBQREbpphRAPjwtpZ4g76N4rtSaBcnSOKf8RBr?=
 =?us-ascii?Q?Fw0N9vv79zzGn38xE936IrctVRna1LWsA2Cw3B2VsOMFy+IIZJiDrwJdSFHH?=
 =?us-ascii?Q?AKtExjWGq/wRsor2qeQRt+HyCZ41hYifKyIznHbbZ7yuTowltoKgBDt2nSPO?=
 =?us-ascii?Q?BjEWBotfYSKRUqSwpYt78GTShtLFa7hI13VZhv+FZ9EO6vwq9ubepynlMjt7?=
 =?us-ascii?Q?pzEE/Yp40wMy+9G48O5tC5IBMcrAwY0+RD6NCPJD8nYnwXsyubz5tSOdKhxL?=
 =?us-ascii?Q?dAsnhLq6kf42Xc8S9/ISAcoNZF2JmJF46dJ5bI3XLBhgd9f6O7qiOBBx3jVN?=
 =?us-ascii?Q?ceAKtVzV29Y3yyBFukCnRHjtdRTk0kIRIyEk2ot2MZ36DaTyffi5FJPmhbyb?=
 =?us-ascii?Q?og+aSiRXmCu4BpaZQaHbEsD5XmYQtGkbjsR/DbQtye/HnkYRGi6U4VC18fxR?=
 =?us-ascii?Q?Sh+47l7mrNCBWCtaBe9Cr43KCgFxpI/EhBqQ+hj63G913cYfQ21mk8h7KlPT?=
 =?us-ascii?Q?1JL/RMFpI3pS/wsLcwJxHcJlSZKWH+r4d1cLcpN1iQsxyvQiL+LzzmUqyeU9?=
 =?us-ascii?Q?xlbaDA4/MWqD38CRkxJxBC6EOMCXOVk+GbDWLdYSbRVeF/X9DTMZkFhRy3oM?=
 =?us-ascii?Q?3NIeEuMFauZ4nyn6/jE6+g5ycXR4zAbv2MfYVfkwRv0Un+BdtBP7z1dYFo66?=
 =?us-ascii?Q?p4rluOMSnvbiCoukRwfHKf1KDXgsvDQ6lBF7hU0Hw0Flv3jiAMqIiwbrkEeT?=
 =?us-ascii?Q?i4idK5F52vH7ynOfOxoQ/1bqQKRVyktSf64W/Stt0Pwuqaorm3AnuQ99/Ixl?=
 =?us-ascii?Q?/td3TQTw3rvSF/U0RD9b3+6epIvKqxjjIRDKXpv0vPPd3htA7jlTs4YISFVj?=
 =?us-ascii?Q?o5+gYIuDfR3f/T2/mycp4MNjPthwjMMVnI6aVjsjFCTZgFXywnUt3wI+tpdk?=
 =?us-ascii?Q?AL/jTgRCAy71oaKLuYliIQ/6YQ4eMzHW1A8qspW5XC4nr6ivOzK2t0QNIngx?=
 =?us-ascii?Q?16uNJq8iYQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ynBiZzSrTuNbF3qFmXQiIrk2CJshipYedA6gJrqYLBNajOFmJ/nRL98CL4pT?=
 =?us-ascii?Q?GXtqaqJaGWjJosv/K8NOADgKPQt4t/nWsBmFFIQXbdR2QP9MHOVcrAqLIj09?=
 =?us-ascii?Q?yjGpd72f5CjeIwDJVmwdIGJhAcryvd9dQzLaHE/ljmMsR4A3uh0l8pSoh5WG?=
 =?us-ascii?Q?6eBhVRgQK1DktB4kl4J/PVmlwLkhrbL2lhhEyU3QyPqdGOxwS1QRLKU+eYZR?=
 =?us-ascii?Q?M+JLMwQVT0t8nYsypAYtKJUAo+dLcWH56d/QMxr/MEU3enc8Od1JeX8hLMU4?=
 =?us-ascii?Q?VRC+3n8brJ+lxT7vQ44VYY/inyYeE1qyRmHF/hD5tAQXpGptO0w42Eq2vv6C?=
 =?us-ascii?Q?UL5TFYsi8HMYgkzLzDjUHrpIp3QwLKxmf9d3ovXPsNsHMf9E5m/wbmUe7TI9?=
 =?us-ascii?Q?fqpAKnCWtYaYSz2bCr0PZ7NjKdMm3wlK1U00ZJGIBQgKvibo972H1SfPllQa?=
 =?us-ascii?Q?3aVUfrPIxIgQBYH2zDuvXaEerJkvMsRLWdjTRYH2QkD+IumD3xozJbwVjxJA?=
 =?us-ascii?Q?EmlqtnUwxucCaV4F19iZoHyvh09T3wVMHEYFd3NjGWZ2jFL2ZJQDiOWJtY97?=
 =?us-ascii?Q?NKHkWG2lnlGx7q0POEzzJi0FC32PF/qWcn7A+Y+DYd/AyJ2FQQ+FdDQOE6wY?=
 =?us-ascii?Q?vlQOBtf3ZkZ/nuCiUjFZ/ocfP0Nh8tQu92M5tYlXNIarXy5apa6LMSfogw7y?=
 =?us-ascii?Q?wQgH0vHXMd+9nM+rg2q05yFC7mxs9H3fLGbYDJaQgCpI5tV/WZteM+s3yZjR?=
 =?us-ascii?Q?6El6AM0uGRdIjRZadDL0R1pk2OdtqUXPjxWL7hU/7sWivZtf3Y23DW5dw6Pw?=
 =?us-ascii?Q?40XwWL23Lz6cffpEqc2TogfICkfhLwx5uqLfS3+oPo4GY/eyXXig1RyBPiQ6?=
 =?us-ascii?Q?McoO/8MdzKdB/J+WbYbaOYOt/IHIMN6z6dh1Uzx7xXUeyaBP8nOA5TA5Nplm?=
 =?us-ascii?Q?pfeuMq1V6ydwOVkIAtFzBjmUc3ITydhgM7u+ZFuzwmgE1KUHWzLZ81qKnF/N?=
 =?us-ascii?Q?ZgOjRo44mIcRAn8MhF7LNwVjHrlFcRHQpi08zbFncCi3DjGCCKSbAsA7xauo?=
 =?us-ascii?Q?VvoH8TjxKKpNXGkbHfPnVS8qkeBogqqksVCWEmGu826wAeauCeEiQe3Noqq6?=
 =?us-ascii?Q?gUexYIkQhhUXXvqLgA37DX4CK3kuO8/g1LMPpw0ZWS/PSm67htZCUZPdPNOc?=
 =?us-ascii?Q?Csql0jX6MesVc/NTN3LhHr8NnA2oqEKHOCFNPRWXh053fgozlY/+1WS3bI1Q?=
 =?us-ascii?Q?uHk61tEfFmsIto570K/8/++Y6upE7HBhgAglKaGnrLSBF6xU44AfPIpGlFna?=
 =?us-ascii?Q?w6zCpLIg76Um6SUJrxhk9DlGDoVBrvrLe0O2g3xsuzaSizUzgjbU7esAKPmW?=
 =?us-ascii?Q?QgB9sG484V4lqMdk9o6Nj39Rn7mQWAGEIxw0keqTxZX+yfTTv6hgjr1qZ8cS?=
 =?us-ascii?Q?zvAGNKb1+Wl3rJRZm2fJZN6S1vfUBQfIOZoQOg/ue7PQDyDpar7SSW8VtYQn?=
 =?us-ascii?Q?71Lo8XO8lVGEvASlrBNp8evR1uqDD0c6L4I8AInNqUowWzVxUX95texPZKeT?=
 =?us-ascii?Q?dOAYWKQGEpA8vlgMm0g4rQZUkr/S4rYRWESW/2Gu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839598ee-338f-4bd9-4594-08ddbafc472b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:11:24.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQfs9AjvY1Y8qtqlpyeyMJdvv7vnj9deioBwt0tlGS9wOxb3mDEuEzCCTDS+kasRkQlmn5/IIBz8DhmZgxb4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
> 
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: 03 July 2025 02:23 AM
> > 
[...]
> > Maybe someone with closer understanding can chime in. If the kind of
> > subfunctions you describe are expected, and there's a generic way of
> > recognizing them -- automatically going to parent of parent would indeed be
> > cleaner and less error prone, as you suggest.
> 
> I am not sure when the parent of parent assumption would fail, but can be
> a good start.
> 
> If netdev 8 bytes extension to store dma_dev is concern,
> probably a netdev IFF_DMA_DEV_PARENT can be elegant to refer parent->parent?
> So that there is no guess work in devmem layer.
> 
> That said, my understanding of devmem is limited, so I could be mistaken here.
> 
> In the long term, the devmem infrastructure likely needs to be
> modernized to support queue-level DMA mapping.
> This is useful because drivers like mlx5 already support
> socket-direct netdev that span across two PCI devices.
> 
> Currently, devmem is limited to a single PCI device per netdev.
> While the buffer pool could be per device, the actual DMA
> mapping might need to be deferred until buffer posting
> time to support such multi-device scenarios.
> 
> In an offline discussion, Dragos mentioned that io_uring already
> operates at the queue level, may be some ideas can be picked up
> from io_uring?
The problem for devmem is that the device based API is already set in
stone so not sure how we can change this. Maybe Mina can chime in.

To sum the conversation up, there are 2 imperfect and overlapping
solutions:

1) For the common case of having a single PCI device per netdev, going one
   parent up if the parent device is not DMA capable would be a good
   starting point.

2) For multi-PF netdev [0], a per-queue get_dma_dev() op would be ideal
   as it provides the right PF device for the given queue. io_uring
   could use this but devmem can't. Devmem could use 1. but the
   driver has to detect and block the multi PF case.

I think we need both. Either that or a netdev op with an optional queue
parameter. Any thoughts?

[0] https://docs.kernel.org/networking/multi-pf-netdev.html

Thanks,
Dragos

