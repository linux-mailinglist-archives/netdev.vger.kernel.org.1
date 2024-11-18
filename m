Return-Path: <netdev+bounces-145815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE09D1079
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E071F21F15
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D981974F4;
	Mon, 18 Nov 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+5QgxJA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5773477;
	Mon, 18 Nov 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932324; cv=fail; b=U8msKh042uRm3BINRNj7FxQgHUB3AbcSX0+OdYOACT1Sho+dxpSvLPfQb5Ji8Ai2gExDaxc0JuT918sc51N+NA61gqogrkEVnfWH7p9BXxZnz7uM0Kz/BpaecGL4zCBPGAojPtzc7Ka6OcYYMDr4+Arow92UTLoQvH1tNCFbpmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932324; c=relaxed/simple;
	bh=GcXDXHLASJY9RG9lyi/Mp/YZy0quKq6+89TxsDAPFbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NTwMCbSrdQH+h4Tf1CPQ0JChZqc1J78SOHzAHsfu1fovD1CWA8lsRiuArmIpU2+tPtqLlKtyIbT+YZXmMULPQnAO1afql8Y9yhXZ1uqBEoqr6XVFovOyyUB8mKC5ZN9iRK4JNPAJFumF81L2GShNr6nn/TFEw+LRzwWyUNxDTtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+5QgxJA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731932322; x=1763468322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GcXDXHLASJY9RG9lyi/Mp/YZy0quKq6+89TxsDAPFbM=;
  b=a+5QgxJAe2KyFlVyrpgmcIaC7o+FAdBtMkkhAqJz8EY1NMYxBTyVvmJQ
   S+fFf18KQfyya9VxHqvIzyHGHAXNYYaNfwGD+Qozsy8yDjNdmJFz9iUag
   k/mred4IFyJK9AigDd+fmZ+6sVo4H4klZUtzDhSSZsweMZkF7mTkOAvQ/
   YSlpOcR/2iMVEu1nh29EiicrgGR4yf4Cx5nrJJozkCbPgL9AGM4J0mdX6
   BAzgz/AfJ8dBdtw0R9yyi2TpPg4GY0q6ng6Ttrmzrdss4D2A7Yk1h6ErY
   6Q2kC7xs1DVG2haCri3xWlhMmL5JEZr+etJgm91azIutmziMEK4FNQRfa
   w==;
X-CSE-ConnectionGUID: zdG2YB7BQjKc7CLbRTpzpw==
X-CSE-MsgGUID: e1fIcwa5Rt+CFWXRxCXXOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="43282139"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="43282139"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:18:42 -0800
X-CSE-ConnectionGUID: uwRZq8iDS1+5v5k2HSSr0A==
X-CSE-MsgGUID: 2+VcjGz6T0iks5PlNuguWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="94026067"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 04:18:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 04:18:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 04:18:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 04:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvh1/JYbEZdQwKAgZhhlevLxp2ZVnEad6YHzbFndHzp5zAsPt4O/NJWa8JEsO4AEgg4i+lAo2Pu0xsKMMCxvFiDMTYmFTEr8XcZFiWzQKcXZneghuz4uGZ2Cys/AqhQXK7U3KMevjBWtw8I4r9j6mdvqd/7yjdsohMQPZrkS+HRBQDI2PZTadeylfYoRCdUFO6lNzHC7dA8RGyB0MWEhwPGT/tgcZAa0d45eWcwq7yLAc6XZiEYtItiXYH9sp+gZKLGLOI5RQPOlStY1kNZQZ88dBybUK9Y40c6T2sJ3K2stN3U7z9zjHlorRAvdPuS4xp4lNDNJosXJ8Ly70tYosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7dKqyT2leczjq5qzO1NWv2YV+dOgTKcIPK6zVE9QFA=;
 b=nK4+Lcu6soo72X7mYpsUYJomxhUK6sMncXSt6JHkIydaD8RO2vAA8HRNucI30FeeUBv+7tid9cwkb90pQ6Tc0hry4+1qQ6gMQyH200rqEv9C++X2Xwn6XwBWVgRcQWxD3Jvw3iEo7Br5LO23HaTMFUcGHXK/QuZtu47jWXXLN1mv3s+8dEJMikMGXD0+OEIgn+WndKekYNJ2HmCJ0yDUaAHRpxHWKdwuBLbbdPDpGPNvt5zlGOC1WEqWFgDdBSJgmoHqzmU566A3rQCNpax57RtbCLm6QzzRFib83IjkmBWLU2sj7WeUT9I2725Ius9IdrVz9ADqhmk01Byh1Ewwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Mon, 18 Nov 2024 12:18:24 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 12:18:24 +0000
Date: Mon, 18 Nov 2024 13:18:18 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <paulmck@kernel.org>
Subject: Re: [PATCH net 1/2] netpoll: Use rcu_access_pointer() in
 __netpoll_setup
Message-ID: <Zzswim8DI85fYlRR@localhost.localdomain>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
X-ClientProxiedBy: DB9PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: d6687266-3c90-4f76-0065-08dd07cb193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5EmrODLHa5TYhCDoVAnZ5hyQBH7jCSAgfqtAfuRMuii+1XjPhXfBiBU/hjy?=
 =?us-ascii?Q?23HRhNPMl6k/lmCY/8c+3YmvFonDmJOw6BQiOk3SCjf4OFHsBjsQ6/UJ7R3e?=
 =?us-ascii?Q?S/KVM0XgusX5PwH3g8ru/6mSocX2k7Mt1fUPpuJLtHtJkmMbB8iek2zhSuja?=
 =?us-ascii?Q?TNtqswPiiX12tB/hCWWQbOJki9wGQFUy8/NM2Cw9++bX/cqzdD9J2HuWyGZb?=
 =?us-ascii?Q?UXKLUtOf+YPXpjC2qyKrWtr9tUBBY6YWfNyyKvWKfuX+3vh5IuJz8/8QSZ1M?=
 =?us-ascii?Q?Wzg3p4U2a6I4ME3zwPmVH/5x5WIrtWQs0Ir7ys4FNqRoY41m5G9iGKbSIdVK?=
 =?us-ascii?Q?OSdm0KjhAzVzSni/lJUIfp2bAVmeXeU5fnmV9/qhWFJwqQZrdbtz4xCCVUHy?=
 =?us-ascii?Q?XQm84vhTctDwOSUmGpDz7QuZRPYtx8LUBtCFiZE5l8yP55iQQflIbdcTJiNI?=
 =?us-ascii?Q?/YIorKNwI1ZuqBJiWsQSHkZYS8qJ3sW3YxGkS1Vh22Nvz+Yn3qNGTjUQXbiW?=
 =?us-ascii?Q?n7XjkTZFQLcAulfgAycoZlSlRPekrw/U+CdwtqXOYk6BAxwbW2KBYrCmUqnB?=
 =?us-ascii?Q?r4Xv2eJnlL58LrprUMtrsRnO4LVkB12NcyxyWoNU5uN9cZiwRIcAo8nkCPHZ?=
 =?us-ascii?Q?MJpaS8ddbILGQ2IMpcmBgEr2JOIsp9fFUuOSqVw0XG66ZFwNZo5DLv/mtaDM?=
 =?us-ascii?Q?Z4GzhBIUV8VnnrS4hBE35Tgqzy6hUKGqUL3db3GjINqmBeKCUFBcv0J6GTrX?=
 =?us-ascii?Q?sVHlFPxDDhwmHwI7cd/jxO+qRlwW09YvrUV236OkyXvsSonwcBoVKrxs/z43?=
 =?us-ascii?Q?u8OhY988exrrUM+8TD92J04Njc2C3WXOrTtZZ0Xm/5nLUd2BhQMQ7OjcRAb+?=
 =?us-ascii?Q?p+XKc54dIQ5N4kVj4J01fzdlgLIJp7edXNRlEveyv39968l00SeSIN9iusp6?=
 =?us-ascii?Q?5KySmASa51aGyS9LZdbZ3aE3AzSLOu+TzQQxPCWtR5xV/IcUIbXrpAaG8A9i?=
 =?us-ascii?Q?x/md9Uyjt5i/H2Vs4gkekekoFUAzjwGg90i2b+1fxsh4AO4jVMWZmRSxDXJj?=
 =?us-ascii?Q?7fpQ9m7DD1cA+qtjn1wgTFOyyRIJ4uAH5F0C9Oe08ms/LWlswyXeTj3fBasC?=
 =?us-ascii?Q?/sQ5dlFFquXlkSeQBIdhIqkyXeHFAEf+rMxTAr5fqdYIzK3g5Kvj6TuG/FsV?=
 =?us-ascii?Q?MNHnC/vDNmOfSKoPFNwYw/XTaC7e005gjVMui9I2yelV5LFSIUtD/C3tlrQ3?=
 =?us-ascii?Q?51Q42j0nAiZq4v2PuaIgXIwWupMR407nFp5WjlND1NCZvR5rzgtlBlmCw8oE?=
 =?us-ascii?Q?GR75TbxSAs51Po+RHnLqmdL5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmogi2D5RI+G1H2Z9hviKpi0eMba3M2n3CfYHj+KXZc/zfYwc1yaozoeMeU+?=
 =?us-ascii?Q?elgFADkaxYsEIMZl9oTzbtC5nMvuLICrHAU/ZLnF+VW2YkoTk1BMhHaXR9PW?=
 =?us-ascii?Q?UGkMeupVDhE5Mz8Bf97UeidJvxfIZAidsyAG0F0eg48jb5jqfz30i5f62+0t?=
 =?us-ascii?Q?rJNBXbYKnHZXKBBtnKo7zhVa9OtMkjplx39H4pWuNiKavAQGtdJcl7EbmV3R?=
 =?us-ascii?Q?aY6KmdrbisMVuvFftytfypI5vzLvqqFjRzjDIvuOc8t5zLtxv5rje4VG71vC?=
 =?us-ascii?Q?xY2UxPW1Ib7dzcRpdzmG3mptw95YkdH92MG3qXPdHmcN5HaCtee9H0tcXMxF?=
 =?us-ascii?Q?DY1nTEyQoyNtt6/79xg9OIVlqMWQ3rW0l5Snong7RePD3JYMVcsmLhQPVz/q?=
 =?us-ascii?Q?UQLe91uka/BUI8xajk3WzDs1qBZkjBUVwrFrmacOx/cbG0wSJ0ebUNgSDBol?=
 =?us-ascii?Q?pPt6Ej9nIKdWMA7DwJ+yT62oMdO2rRl3gfqLp859ELi7PoCa8ag4uL6CZJHm?=
 =?us-ascii?Q?hi2XPt5eFqBdhQ89/nsI7u8DybLTIOfraKGBQQ/keekmObzrWKiTI7QuwSbY?=
 =?us-ascii?Q?+Y7efe4nX/dcDowxEIlpuLo4OmthOXTUpk3ZMvcd6w+e3KH1Ph2aKzHNS7n7?=
 =?us-ascii?Q?G4LbxU2m0W4T18Saa1NDOn9ASgZApjSqci76HdcvCozKIYcdRxqPbcwfuCJl?=
 =?us-ascii?Q?+RjTt4wJvs5eaHXSHYX6tIaYhg+EGOZNQAsxa6zAVW+7LQG4i6fiuSOnXZPp?=
 =?us-ascii?Q?lv8UZYyba9oGb8OpeHPKrkdOqNgMUDeEReX4ySwN2QGqq6m3s3I0GCvg0zW4?=
 =?us-ascii?Q?fh0V/g5iWoqFhJsvOB/YGXXczTd0ATb/M8f8EHcvlP1P1weKKXU42QSmUbkN?=
 =?us-ascii?Q?7ilU5kr39ZUwVZuQaJNwXmigRg6H8ZaiJKopHl7Zw60jeDu55f13cbJBBeog?=
 =?us-ascii?Q?n7/+qW6RChPD6IiZiwHYn38JWVwTYS7lSxdzQfvQ7UeowVaDSX7iMoT+loLJ?=
 =?us-ascii?Q?UzT8ubsqqMiOOPLrwo3oFatd4QiXW5b7q4M4flp3TES4NpL/9rII08SN7WeQ?=
 =?us-ascii?Q?sJvHn8Xj2224d7TXgexp+JV3CyIkTbnCapTKv5OZeioS3/0niOe6bRUl/w6X?=
 =?us-ascii?Q?pT007ggY9XRzgM0urHpnlfq8Jt8up3ZfWdoAVJSjU4+pwjHXF3aqkGVS/NNR?=
 =?us-ascii?Q?Lkv4dFmXrH+zDdZOFR71JN8ffpfdd3daJRyPLTtR/H0HnwhJXNxnFyr9dDkV?=
 =?us-ascii?Q?FCe6GqAon4LR1kzhkVo9hDzZLuDiLF4CjspSmXNBnQgoXbhk7mu8nhXot0Rq?=
 =?us-ascii?Q?3JXRzYpsSHm3wQ12Z98yh8fQdIscudDMcXEZ3CjP9YsyOnckjs7K7//mrMZg?=
 =?us-ascii?Q?hvKWgNw4gHvTJn6KpdCz24an0Q8Yl3hss+Y/UdNAwwcZfycCClho2VX7HZrO?=
 =?us-ascii?Q?a/EMcy6hn2/1Gx7dwv/qo8lvLZ4SsBHiVWJKVEd7jlb4zsaqZ3E+n6jn/sgZ?=
 =?us-ascii?Q?29VaCx6U/X8ufoy+zy0bRYFHWfjO0zpUCu8rQFjbLJ/icTU29r2qgPNZZvp/?=
 =?us-ascii?Q?n0aZ1skhjpy/IV7wPKMxVmtoyw7v7MpRoEC00See9klSsm8PQSt59Cb5ypLE?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6687266-3c90-4f76-0065-08dd07cb193c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 12:18:24.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPOA/YWdpBYRXB2zOs1PAwVl/dnmAcGMPFBm8zFXjHRyfvONKIhPenKRpPxis40n/EC+XmSinEZumWDqmKzvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com

On Mon, Nov 18, 2024 at 03:15:17AM -0800, Breno Leitao wrote:
> The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
> accessed directly for a NULL check. While no RCU read lock is held in this
> context, we should still use proper RCU primitives for consistency and
> correctness.
> 
> Replace the direct NULL check with rcu_access_pointer(), which is the
> appropriate primitive when only checking for NULL without dereferencing
> the pointer. This function provides the necessary ordering guarantees
> without requiring RCU read-side protection.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 8fdd95ec162a ("netpoll: Allow netpoll_setup/cleanup recursion")

nitpick: Shouldn't the "Signed-off-by" tag go as the last one?

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

> ---
>  net/core/netpoll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index aa49b92e9194babab17b2e039daf092a524c5b88..45fb60bc4803958eb07d4038028269fc0c19622e 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -626,7 +626,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>  		goto out;
>  	}
>  
> -	if (!ndev->npinfo) {
> +	if (!rcu_access_pointer(ndev->npinfo)) {
>  		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
>  		if (!npinfo) {
>  			err = -ENOMEM;
> 
> -- 
> 2.43.5
> 
> 

