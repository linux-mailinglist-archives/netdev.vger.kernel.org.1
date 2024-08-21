Return-Path: <netdev+bounces-120427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5DC95947D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F2328217E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C516D4E5;
	Wed, 21 Aug 2024 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnPqQ5RQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D31C6B5
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221373; cv=fail; b=HBlFtwRocCaYd3mm2S+R1aVG89jRnFq7EjL7fwYhhrv+MoJTF/zxOuy0P6OaF4u+1HonpvCrVdcpUAm5mucZPSjQ/QlKwBdCXdcczOIE8xna2hni/IQrXqasX6woHynfKerhC/q6GDW6Grv61izMA5lVaSd7CD6w5Ij18BimBQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221373; c=relaxed/simple;
	bh=mbklVEWqT7JrZkTyfzX7ldZZPGEKOKdLlIFWHN5PI0Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OTay/Z2/Crhkbg/MiUa2dBDyrz2TNxm/S9mXS10N/Caeh48j7PhxlZ3j6PJUpPJOIfYjAOM2sXEiUN8FWYRBdYdJtRjyEE1YrXsf3EpwZFs6vJNBO9hFk4qBKn4DB6oLvDE+gXhvE4/fOq7PO8mwr6QeRGmdgYuDQhH9T+YZKEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnPqQ5RQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724221371; x=1755757371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mbklVEWqT7JrZkTyfzX7ldZZPGEKOKdLlIFWHN5PI0Y=;
  b=AnPqQ5RQFIlwSb5FlMs/VUHVBN0CAVC40hqIC1fLpMxPgdkZOta34yd4
   c4S5Uce9anqfCgnJaUcPCEf5CWh5GGQJDHCs5gx4eq4fVExB2Plkoplmr
   TEPy7c3zlJYW6lGNasaXGckOLd5VaSpA0orPIbsXRfXtI14S29fuat04A
   eqSUTrYGl4k8Ws+qB/iliagfKnN804PsH3nol6UaHwpuCjIIu2vSDp0XC
   c+p1x5Q2cgh4P3vWmZaN6bWls+xEiSmVWnGmcqEL03KBhYaQoVegHUFvA
   rDYz6sbLb1tR2WS5B9v+KdL2w8W9jbuTi2Hexa/Pe+G+mk1epz08fuYcR
   g==;
X-CSE-ConnectionGUID: bgga1Wt9Q6ucvALVmedGjQ==
X-CSE-MsgGUID: gpltRTLeTG+WnotCJMvHPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22443382"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22443382"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 23:22:50 -0700
X-CSE-ConnectionGUID: HwKUbD8PTtaqYM46T3jJ/g==
X-CSE-MsgGUID: MqyH/jkGQM6eYMLn8l3ezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60707331"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 23:22:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:22:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:22:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 23:22:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 23:22:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdVldg6goob1ZZchO7/Yf2tO83fPR9nYoHWX5mL/2wl07wrSxRqaVMI7eYlMJW2Q4uPCqbZar+lZE947X5XMzexgYxrTKrLzVC0I7QTdXX44whBOoUucFT1oFRrzdQQn1h6o0IoM8ZFk6EuGZd74Blp16w/mbdghyPBPjUvlJbWaG4y/SmFkGbjN4nJ5g/akqwBfPQXDmZN8jATxVV6TVCizQFZ+5Nn94PsiMFcEA20utfDV3yINr6VioPPfTd9EjPzTQ2HXpO0c7FjBzUA20ME9j+qQbstf161j+jFTDtNto3oHnYQ+GOVxLwL2OnJ00aQfHPEyHJtT5TcI5MBpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw5MH+5lkrbT6st+niPQPLgddRqP40XNeyrZ4Lf1geU=;
 b=R6GBJ3/V1ivttSW75QvXjJ4F4LlN00BEKxusGAGmsFPS6jK/XfMCZT4ZXU4SoSS6Iwtm7m6GRcN17JAP0jeDUXpNSNwS+z6C1YM9E8JHntJJkhrok/RHIv0b/YxPZBI1dReLYWIxRoCTf0Baw6XmhGIIZ0993FzwAC/fsuSAbS4pSg5j7w2FdJZiuyiNhANd+osyZIl5Bn0Yp1Ded6EosGqViqM73X5QdGqGSoDUREzSjsPvffUu+pLQ8RTFMZ4Xy7KiCRXzE7YKxolWUqrYAO8yPUwHWjdkwOlpgjgg1HnpayPSMRBD+579KBLn4zlQ3pNSI9IM36ZV09VpzlBgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 06:22:47 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:22:47 +0000
Date: Wed, 21 Aug 2024 08:22:41 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<larysa.zaremba@intel.com>, <kalesh-anakkur.purayil@broadcom.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Igor Bagnucki <igor.bagnucki@intel.com>
Subject: Re: [PATCH iwl-net v4] ice: Add netif_device_attach/detach into PF
 reset flow
Message-ID: <ZsWHsaUbYo9Qb6v2@boxer>
References: <20240820161524.108578-1-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240820161524.108578-1-dawid.osuchowski@linux.intel.com>
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BN9PR11MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 93274ca3-4602-4c1c-eae6-08dcc1a9ac94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O6h3bDGa8hGfyX2ibL3bprptCYXZqGLIXJWnSFW6mN2saWF9ufwon+4DgH/V?=
 =?us-ascii?Q?WzN/gCfNFAopyrtgzjEtpN5DlozniA9cNXSRaXhazThexCEI+h27NC6c0qmv?=
 =?us-ascii?Q?HtlPy4AQUqIt6cigaJ2nqgriW38V6rDN+/Ln2TQAEL7RPHTQcJsZzmrDQTWO?=
 =?us-ascii?Q?c7VBsnnsOTk2EWYFxOpSPpNlvXilcNFfTs4aB4p1u/eYI6BlpzVvYaqlxe79?=
 =?us-ascii?Q?FaN7ta4heXSGQpkZllkG5ta+Uut6+U8Ja8E1LDdozglGPv53qA9zNO/nE63R?=
 =?us-ascii?Q?+huRW1d1rqiyRLz0HAZUWGiBhcCI77IYVBfJbSTgHEbVubUvJk4OjZJ8xytb?=
 =?us-ascii?Q?zKSAKAyand2Y39OYOSVUuVAyR2PYHNVYj171ElbEQS2zKbV2qdV6ETt9qqM7?=
 =?us-ascii?Q?xxDjE7LVUbL8MhTjQb1jCkYDc7RExQQC6LB/4oyeF8kk3+91dHPI99KwGjHP?=
 =?us-ascii?Q?mHg0CDmWCIj6/IjPbsN2Vgr1RKSNlHzuBzpNMOEEzyKE2vIq6iSkpbEEWaT6?=
 =?us-ascii?Q?OpafiQPhAIrcr2JhALWg2b967o/B9SDPH+zcD33rOvQlhRb057zYeV0yjrdX?=
 =?us-ascii?Q?XAKAKY2riqSQk9liqV9hh5w52tvQTy7xZRONHW8RkIDAuwb1oFjiaDldAlcp?=
 =?us-ascii?Q?n63Gra3opCn/soscEnnWwPS/irNQeTthdHNWjNjDeiQ+KwEv1rAmUgd2W6C2?=
 =?us-ascii?Q?TOybKL2xxuur5yDZ3K/dx5NbFbGlWdecNdNJu9qi0+TmLrY1rj/tJWUhdEU+?=
 =?us-ascii?Q?dilm4vXifPK6nBOOFgSILwyD5YBWnFdkV1B3MYISOmM6Wichm11CwcZ9/iip?=
 =?us-ascii?Q?AroJptUtqMq8stJ4/87ywRWMvI3F00KaBFN2kUAJPD/as8EGM34KJLSXJsYd?=
 =?us-ascii?Q?cKcL0dL3FXHr0BF7RrEMQlmWqHhDQpWzZXrdBH5q49LJjQT2YJe6TVCl5fF2?=
 =?us-ascii?Q?2HTiDap96SDvJzQlguksedhNukeUzhD7D345zAB3sbAvsUSWI9ybChKKQCvB?=
 =?us-ascii?Q?sXqS+r3U0P5b1Ps4ssh+KEwQdWeUI5ki0f7pppk/dSzfCJfqTfxevyMt0RAV?=
 =?us-ascii?Q?vIiI06s+sTn7mWkr0sK25yiVh+3WqcNBLk2jnoBbVL9nxuudc58rPUPTj3Bn?=
 =?us-ascii?Q?RuSd/qGREYzT3o1tr8aVxjrzk47wXMPt0YIBNzLOxRkNxZfd4QBdSA6P7Fce?=
 =?us-ascii?Q?57H80kdM+7QqKZpSnAKhXERTr15fUvRwfapRywH7glcyT9YIXSgEmXuvr1bU?=
 =?us-ascii?Q?zoOa/sPF1aqLs0uFFhsOD68OaQqYjvGw41zHYw1/XlUqz197lRLWA2u4UwCm?=
 =?us-ascii?Q?7BOa0QY3EAu7el3TLqYbkZKh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxINM7u0mXDwQyS+oz4hRqsTiOlT9t7IBz8j3CtrzlFzBiz5h9/NIgB8noCR?=
 =?us-ascii?Q?7QvUMEXHTQ1JsD/4vbD+SW2cpxTHKbKY8gMopuNV3hsKKLaPZptKkmMj5A7Y?=
 =?us-ascii?Q?6FDVEPY7ULbbOz+Tw4xZTmsrL2IN2GpQDxzUCCFcN6P7KiZUXMVHBCodAxC0?=
 =?us-ascii?Q?7rIoKPOvqo+M5URUA/4BDQntliG/nVNl5OOIkIPz+M9PvqhjZ5WfyCQeHIB6?=
 =?us-ascii?Q?0gCCGc4b4wMf0+JtlkX0Xgk23n6zaMfZjQ9ibjJmz5945s2mwrFYxEFY2RUd?=
 =?us-ascii?Q?obyc4vST0pk0KviplJ4k8KJq+yJhblz13lIeoqdVNTmqKywJmcLix1Y+km7E?=
 =?us-ascii?Q?Sci6W/SqbtAwIz5QqXiKw1+Inzw3UKULRJ7yVMygZn7CCdhw8kqDTNIqa/pA?=
 =?us-ascii?Q?qdC/opbeX0bQwpsHvNIce3eJFuGWJii0ly/f/4yODmPVqFg6dRuxqja5Q70v?=
 =?us-ascii?Q?yzJj0jhbIVKRAore2706bKS3qGgj0zhkJsQUEhaTdRadOZVhNXU+EIIHwXH/?=
 =?us-ascii?Q?aJ8Zl2RyEC1oC8nHfqGMFWNB86Mr5b6Ba0l+HdPkCFSb/OOqsG3DvndbkIFX?=
 =?us-ascii?Q?Ch8VMaRBNWwZJ1XBELVkeRf9seatajv8rG6MWKv/p5ZAP9ULS2GwYnLtHy5j?=
 =?us-ascii?Q?t8x0pjB3gz1GryOUVsVsuUMX5HoSgZZjljZQyFcwIvMbhZ3sUPg9eV89MmPK?=
 =?us-ascii?Q?byo5YaffWcIAMKpWpAPYa54dhJWMIDngiR88nUqbQs2zbbxyQ/TbBgljJ7g9?=
 =?us-ascii?Q?j+k6wi4pUH/K111/aP4Tqh2AAGZNSC/wu57FXfCHbkeiNjKy5SydLOLK1Z9q?=
 =?us-ascii?Q?j1RANKQK4DK1PeehX9dhC1KHWkGOczzjGmMzhzvu2bojeFkSk5s/fYa5hrfK?=
 =?us-ascii?Q?IudcCVTA5Gk6tCsV7t0GlPDqp7ZWwFJKGQVa13L6FkwoHIDetfUwr98cF496?=
 =?us-ascii?Q?UeFpPqyqsBllxM1Ys3RZZKEe+n6utRUkXeHlN2ihrjJzN2VXhYG6wZ7QZrmq?=
 =?us-ascii?Q?z5ywcgB3xRCGh+a+COcwAuMAcDp30P5c5ENioIbPYUN7NPCVNEcWOhTL9j+Y?=
 =?us-ascii?Q?ZbzhL52TaE0SLILP18B8w4rAT4d1bxRAirtj+eMyjonJC+akBNHZrhPiQyE3?=
 =?us-ascii?Q?3tdbcXeiSBs1vf5Cl8/I52N1YBHSh1wRlW+iKhsGcfpbvIIEMhHOyNcADdsg?=
 =?us-ascii?Q?0/jns//HXzMnGB1dDI03qylUB/DhVXKwlQKHJRYNaPgV56uoIBr0OT+ptFV9?=
 =?us-ascii?Q?Cjl8UG20NTRY3Xwy5k67GUj/rSXeMFHr3tRQQVu0m2Cfyby7gLaC4CSwUNzK?=
 =?us-ascii?Q?Xto0q9r/faF3Nrg3QTwq3GiKqvt8NHoCkDSqdtPGzvOMsLxMuR4mVkMa1OIW?=
 =?us-ascii?Q?mSfxpa4go+dUOS7Bg7wV8gY4+qZjh/QVuWGb5N3QCRjlxcH9oA2tq5xX1Fj6?=
 =?us-ascii?Q?lbLpwxfrzthMOBIiKD/VR2YCpAlgv+MqfjoQPyrpRJHXXo6bwOELYh9MJ36m?=
 =?us-ascii?Q?NiPHwS1hu/z35U3p7EFJ637vd56oM+rwBktLpSnQQa8QuPapmdTw2JGRxQ+Y?=
 =?us-ascii?Q?NZt1qa7cOfpTzUcsNnmCIpuFJyYneSJ0pplOE0pgMKF8Q4KimdLgbfTgwzxd?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93274ca3-4602-4c1c-eae6-08dcc1a9ac94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:22:46.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91wcmrz5N49Y8U0XzthKNUT3gdksTA9tEM4hfHtgV9KifgE+8dW8o7EGhYxULgkVt+a1Tvt4JJmQ17ZyU55DHF1XkPlCuoQpCnu3hgY8+Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-OriginatorOrg: intel.com

On Tue, Aug 20, 2024 at 06:15:24PM +0200, Dawid Osuchowski wrote:
> Ethtool callbacks can be executed while reset is in progress and try to
> access deleted resources, e.g. getting coalesce settings can result in a
> NULL pointer dereference seen below.
> 
> Reproduction steps:
> Once the driver is fully initialized, trigger reset:
> 	# echo 1 > /sys/class/net/<interface>/device/reset
> when reset is in progress try to get coalesce settings using ethtool:
> 	# ethtool -c <interface>
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 11 PID: 19713 Comm: ethtool Tainted: G S                 6.10.0-rc7+ #7
> RIP: 0010:ice_get_q_coalesce+0x2e/0xa0 [ice]
> RSP: 0018:ffffbab1e9bcf6a8 EFLAGS: 00010206
> RAX: 000000000000000c RBX: ffff94512305b028 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff9451c3f2e588 RDI: ffff9451c3f2e588
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff9451c3f2e580 R11: 000000000000001f R12: ffff945121fa9000
> R13: ffffbab1e9bcf760 R14: 0000000000000013 R15: ffffffff9e65dd40
> FS:  00007faee5fbe740(0000) GS:ffff94546fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000020 CR3: 0000000106c2e005 CR4: 00000000001706f0
> Call Trace:
> <TASK>
> ice_get_coalesce+0x17/0x30 [ice]
> coalesce_prepare_data+0x61/0x80
> ethnl_default_doit+0xde/0x340
> genl_family_rcv_msg_doit+0xf2/0x150
> genl_rcv_msg+0x1b3/0x2c0
> netlink_rcv_skb+0x5b/0x110
> genl_rcv+0x28/0x40
> netlink_unicast+0x19c/0x290
> netlink_sendmsg+0x222/0x490
> __sys_sendto+0x1df/0x1f0
> __x64_sys_sendto+0x24/0x30
> do_syscall_64+0x82/0x160
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7faee60d8e27
> 
> Calling netif_device_detach() before reset makes the net core not call
> the driver when ethtool command is issued, the attempt to execute an
> ethtool command during reset will result in the following message:
> 
>     netlink error: No such device
> 
> instead of NULL pointer dereference. Once reset is done and
> ice_rebuild() is executing, the netif_device_attach() is called to allow
> for ethtool operations to occur again in a safe manner.
> 
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
> Changes since v1:
> * Changed Fixes tag to point to another commit
> * Minified the stacktrace
> 
> Changes since v2:
> * Moved netif_device_attach() directly into ice_rebuild() and perform it
>   only on main vsi
> 
> Changes since v3:
> * Style changes requested by Przemek Kitszel
> 
> Suggestion from Kuba: https://lore.kernel.org/netdev/20240610194756.5be5be90@kernel.org/
> Previous attempt (dropped because it introduced regression with link up): https://lore.kernel.org/netdev/20240722122839.51342-1-dawid.osuchowski@linux.intel.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index eaa73cc200f4..a840690f2385 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -608,6 +608,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  			memset(&vsi->mqprio_qopt, 0, sizeof(vsi->mqprio_qopt));
>  		}
>  	}
> +
> +	if (vsi->netdev)
> +		netif_device_detach(vsi->netdev);
>  skip:
>  
>  	/* clear SW filtering DB */
> @@ -7591,6 +7594,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>  {
>  	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw *hw = &pf->hw;
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);

we have an unwritten rule that is called 'reverse christmas tree' which
requires us to have declarations of variables sorted from longest to
shortest.

	struct ice_vsi *vsi = ice_get_main_vsi(pf);
	struct device *dev = ice_pf_to_dev(pf);
	struct ice_hw *hw = &pf->hw;
	bool dvm;
	int err;

>  	bool dvm;
>  	int err;
>  
> @@ -7731,6 +7735,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>  		ice_rebuild_arfs(pf);
>  	}
>  
> +	if (vsi && vsi->netdev)
> +		netif_device_attach(vsi->netdev);
> +
>  	ice_update_pf_netdev_link(pf);
>  
>  	/* tell the firmware we are up */
> -- 
> 2.44.0
> 

