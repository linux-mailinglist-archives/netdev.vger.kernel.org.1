Return-Path: <netdev+bounces-152240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB609F333E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D6818838CF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88318E25;
	Mon, 16 Dec 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXbbY9KM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621117557;
	Mon, 16 Dec 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359446; cv=fail; b=Av14bHAOIIhBKDqbCSMxydJ+oPK6uKGLl9j/PvnleAJ52SXbBZcD/yTYjFdkmafWibTRvHVMtMWkJmv0X9qopANHhaZd9qiM/mcAIYcy0KejVr7yE4K8XMoUCliCd4tFyXd8AgwbF1rRcEkrZA9SU+5rIRMI/PvE0AAa19zzL4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359446; c=relaxed/simple;
	bh=3WJ+s5bbysbgiYLxKmin/GLmSbuRxfLy0f5IfULcGVg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2X9A7h7q2S2h7gPxOsJoJZGc2Lx5l52HwpWB3dbjboqOmQCJUCXbx7Of/U6jkomQFCfoWNr3uEP0cvxnZkM8gGMddg4frGkfUeA6G0i/knuJbJgQyl9k0GwT6TsmKCEUWRTyMbPkchR2CQq/HQwhf8iWi0HXO0w7mlvKgyYT8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXbbY9KM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734359442; x=1765895442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3WJ+s5bbysbgiYLxKmin/GLmSbuRxfLy0f5IfULcGVg=;
  b=OXbbY9KM5t6Xs+vX66SUrXfj2esK4TxgtbZLKpFnWLwm90oIF5j/uqFl
   ccqLKjU/+3sjjcYM85iZhXKExF4nroH16QbhK2BkhuPC1cGLsqfd9DxVl
   5egHnJHwyYrPYzNg/fvJE4Lv6fiPQ2QkQkBjIJ+UrImugsWC2gTMeCub/
   p+pDuUydzJJ5CZtV9KR2pXj5oF1d14zZl4kEQ0CFuT6at1jvAiYYR8IHg
   6myqMK8wM5ijTc5lPWLXNo8rD2APfI6czm87WqAFk3Iob2sx+qC9HQf+l
   ZZewi6Pi2kSzrdwEDG89ApWiE1ddZRwy2QH1K7mxq9So4aX8oJGjTow5a
   g==;
X-CSE-ConnectionGUID: emDHuPxRSVu9wCoxFPyXlA==
X-CSE-MsgGUID: vEwxdbc0Rem57DWvEo4mTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38518144"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="38518144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:30:41 -0800
X-CSE-ConnectionGUID: 9iNzqR94SOekAfXQMpIjkQ==
X-CSE-MsgGUID: sq1fDmRnQsy6MVwHeiX4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="128015492"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 06:30:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 06:30:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 06:30:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 06:30:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLZ7Ge97FmH2G4y6/aHI1aEhepYHiBKHtN2okhnR4783B0OZMWkM5KsvTgobrl6EKk1V9WsZqKfgSjDIRlbx+/bhmoQvLHet5h7JOssLGLLjoe/H8M+sB8urJd1tFNrafKWU+bO3yMNzxy/JkV3X8+SwvYfjbewilA7Nvj0brb6AZk1iIfrpenXTnQGfYiU6E8xSs8FAKVSGtTmao0T85UN37FDRSyOIe+AhQ9wCcqGGzXOheDXlkp7IVMIuXdKoqKqW4UZJmiSeyxKvyaczytbWM72cYmoxhzEnF9q4RwDFa0xc38QqKoVUGNhygKT4uV1TYQpLHGyzJU5eeZPXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kl4qG2eSEqeWRO06KkdrcUqvTvrgzMKSKPpg3ZFtyI=;
 b=cNm90OKwo1lKPMzq6qI5l4l46ugJjoCpCu/blHw9NgbnQ+jHILP0zKNXRgbY8y8bo46dsCLKhxZN/TQqLIlL7Hi87cJrR6Yd/4+b2jlXNPxAuDeSLHX5HRG103LxDZwH9oBb8NY77W7bWDI6yShDiL21ZLyzAnN/ILmFOegwkrcURTfskkw2L4hbtRjvsitOVloweUVIm/vf0F5x5XJMMH+sgvG6ezH2kNxdIDVELF0Vco8a8UrhOxH5yXAdAqN3IyCTbnnVMktTcK4zu23gzH8zFq6rNdEvrF9+aYSaLnuslu1mXEp68dngXHwGqiVCdnRkgEgCpzAJB1MBzetWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 14:30:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:30:23 +0000
Date: Mon, 16 Dec 2024 15:30:12 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
	<thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
	<konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>
Subject: Re: [PATCH net v2 1/4] octeon_ep: fix race conditions in
 ndo_get_stats64
Message-ID: <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216075842.2394606-2-srasheed@marvell.com>
X-ClientProxiedBy: VI1PR08CA0247.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 763d658c-f600-4031-3e65-08dd1dde2d14
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Otw+26b0QQWmeyH4JpAspCZvRaYivv48u5tSANalkttg/CaD27JyyuZLbvW8?=
 =?us-ascii?Q?D+137uPql/tX2O0z3r8BfePPV0+S4ni+kbntJ1AWHdvI8RKcpemwz5dQm1L7?=
 =?us-ascii?Q?6NWU5eyFWuE429TNtZi9SLjcujvuZxRNkhozyN8RrkDjBuZVFoVbqtwZmPSa?=
 =?us-ascii?Q?LrONn8xwFFbRKjD2D+OXpi1TJeebj7Ss+qnFvl2sJM+YZkvZgw/NGaq77kQL?=
 =?us-ascii?Q?xI7AM1C6EH7k7JHiY4/ZITXF04lpk1ZYedqWfgGKGjOgkD1zQ5OsTNpXQci2?=
 =?us-ascii?Q?sNGqxa1/1VedBzOsIO76wnTdqD4ijgvtqp+PvacVJ3/2UCkeMysArFB32Emz?=
 =?us-ascii?Q?NdHv3hznqDYOE7/7trfmjdTfsHQKL5wLUFISogbyk27/2bauAtYcGDudUdzV?=
 =?us-ascii?Q?RzxJIVFms11g9l8AbXjZkecTDU344NEBDtJufpnaWCWZ9VZ81DPdBPg0yetD?=
 =?us-ascii?Q?eVrHminOIg+r1UN+hOk8+0/WUEyNt9nZPOsE+hcNQu4KWbEs0HScJLr7LNmC?=
 =?us-ascii?Q?ap3w1P87fNY6RgX5nvispUC/Jqa9CiHxspChzI8dHFvTAny7QWT76MY/My3n?=
 =?us-ascii?Q?GuyCNLSvLFbp6QVw4x2cC8LbkwIw46QG2FrB62UYLC2U/43utXGWqCr5ykmA?=
 =?us-ascii?Q?Jk7PQ+PM4/OAf28wUCRiox+VXYx2akkskgE0sDUeJxMlFCu5cihmbIdpDHXv?=
 =?us-ascii?Q?LZoEnhC/hvDR+3kWqKgD9jL5bQ/nFm7E8EKzblPoz3c30CTY+miPEsJhnf8u?=
 =?us-ascii?Q?8JqMu6Cs46bggbNlIkuiOEAlVDap0ULgkFW+/R1p48TMf9QHSPmSKEzot2+h?=
 =?us-ascii?Q?KVUt5HfaUi1AQV/48zz1ZoUt8wVsflirkji3ZYMWPq7yjrYL8rwP0bRJ+Iw8?=
 =?us-ascii?Q?IOK3tlkhOo3I0+LZ+8S2N0L2vuXrRso0ATAAaAUUf3GvEkCup/0mchX66cHb?=
 =?us-ascii?Q?dxPH8MnW5lQ7aIUfEYNVaIbs7qt14p8VRwQ+Xi9fZkwcVkTDrwZSPHamJsT6?=
 =?us-ascii?Q?YNZZ16pWm+jEktsfKK+eNH5uf67UwcJ1dki1zKmkcj0IofAzmRktft3Gy0oH?=
 =?us-ascii?Q?A/BKK7XRrOS+4ptRKCj6v4uuagn5fk5Y3S3bUJzYEpWPMSbyYZvXaDqGv/Pw?=
 =?us-ascii?Q?Oqn2fVDrHW8UkB4O+WSpUbFFa/RV0GP5wDbt0uFPA/O9tjq/VUw/LbjlKzaE?=
 =?us-ascii?Q?gMKcFf+mwIZg5jUV0HEBlBf+i7LWX7DBM7Raujyha3ZuZQcMg69/FMFIJXJ9?=
 =?us-ascii?Q?A3831Qj8OFg2AYcGW1rUPkoeQF/NumIOMN6ErjyB+mhwelIG8/QTSo6LtYJ0?=
 =?us-ascii?Q?j+MMQeQzSJbM5RWAupaeKXMs1uHbi0Qi+Ha7f6l18m2M1K2Lar3YcBAGssOp?=
 =?us-ascii?Q?Gp2HIwi1YUQORMqiuScJzClogBCq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZQ8qLpiJLjPaPUkoqaeEiND7MA+lV4ADvzLpkLXMahQxWE4gRGOKfWv3fd0?=
 =?us-ascii?Q?up4aAoWvC59e/mW8XDFUNZqKKhwwFtjbFBdsPGV2AVtxg31oBz05RlDcy2Je?=
 =?us-ascii?Q?iAGpTaxKmVOBVMtkiXprZ/vdKG1UB2knBhPUwHcdu0kGpG0BqbulT5osj4O7?=
 =?us-ascii?Q?/aIFFOZ2WAFWk1L1NsluhwYBDJdBgVcBymvb1qef/gNmmsJmO2YY/hzLBpzu?=
 =?us-ascii?Q?t6WpEy3HWOgN9G6z5Fv4SZTt9oWhCMXld7niwWc2MvkEsomORyU6Ukuvp0bh?=
 =?us-ascii?Q?UURlvUwnjOyKjsmg9tDcJyXM6DHcI/XOgeeQ+abfuwhD5gsMIMMaIGV5xuep?=
 =?us-ascii?Q?RaIwYnYKDUaqSeXewCFXXE9AV2LtEcZikqhW1SLpbcfPIydtcfUrb+5PDQgU?=
 =?us-ascii?Q?NXF1ZLeWmMkvV78Oe4t/PebnV7aX1E0CGQQMZdTo7f4AIt574VkL7WoRcA54?=
 =?us-ascii?Q?pImU0ZwR+FdWgb5nB4WJ33uq7g2zYFhQFlJ6b9pn3jhJZHHuUE58Jq4oQNVN?=
 =?us-ascii?Q?q1RZlCouVd544NT9LTXA9LmxEb+PIVUtjUZU1fQtXJM2HgGqotqb48rgUpI5?=
 =?us-ascii?Q?oZA30dXUDcdBpCpBTWnpCdM8MuRn41IFD8NJAPTIVCX3iSRT6dwuH3ltktil?=
 =?us-ascii?Q?jtrNs+SsfnSqrz2eQST8LTJ0ajQD9xag3vkjqMikUB+gLFWHcEF1U21Qovfl?=
 =?us-ascii?Q?Q6pMEsoT6GyTE70uGF3Ro0SZg1AuDP/tghEn/+hd7+7SBC4Czyq2x07v8QE/?=
 =?us-ascii?Q?UCXSpzzQD5bATs7NFXXJOZ0ONVYwCmPV4ZXOR3iTCsr8I3HyabqsyaVYhwME?=
 =?us-ascii?Q?aMP0svD60kNTHSFyn7zxB4uaOJrspaWOC86VnIhy48Wmrl5nban3jGW0p5bH?=
 =?us-ascii?Q?yHriURyFjtFGyVLdlQCCrW8jN6w3stZehh79HoWZfZoxYM1bnGnDaxvcvcyv?=
 =?us-ascii?Q?iLCTNgLusOKlEjEGUq8OYxZcq5tYB3QqwBBQjywjBSUa+x9prMl5N82tTJM8?=
 =?us-ascii?Q?qVY+y3gcqMr9bwerdoZFYY+fyXqmblr0iKgBsxDBxkioQuNQ7mOqY/ubRUQl?=
 =?us-ascii?Q?go7QYOIT5itGmbAbRs7g0Y2PyMY2oUOXjLTN26H3BWOmeF5yy0A7mhM/PG04?=
 =?us-ascii?Q?6M0pOfeKlTzwTjN/QFboV9nahUV9UlHX7kf30PHwuzxZz3YCLG3wP7BdCrf6?=
 =?us-ascii?Q?RfrDE7+VJB3n361fpJeNaL/kMeG4LqhZUpLH0Zc3ig5hhR1bnVnujkL6A9bn?=
 =?us-ascii?Q?phVgT3aQzOvtXoYQg56+7C0P9TA/JGGjuijfZcAMyGvSTG610fsVuL4o5WxC?=
 =?us-ascii?Q?OOqhkfagsUnQGuWu2kJ8H1qMhIf6Jdv3keloAzddkPA9KyVLXX49wAI7nVFH?=
 =?us-ascii?Q?iN9kvdk6l+4S10vEc5YMP7wgRqnX8ZuygLp82wXVrcDYPAFhOA2xQRmzVlun?=
 =?us-ascii?Q?WEqOQ0kK44LNSb0DEztNwdFN0O2viym4vLQaOwX97pEzChT7a625hLwk++//?=
 =?us-ascii?Q?Tnk+hAHlpIQcXqRY+j0a9qSemgYV3g0jet41tFxAfWzZeNcwsuYCnSGvOMg4?=
 =?us-ascii?Q?0l7eVyHEmA3S4D0/oSlXjzO/hMO1dAqPaqd5LtpOJW8atSNlXt3ZjVT7EBEK?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 763d658c-f600-4031-3e65-08dd1dde2d14
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:30:23.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85CUXOtJ+KMHMG0g+wgeuBqgjraZm+1067+cC3knHICHXUBSLukWjF0bVMPVsKfADAja8WhPmLKw71czfnW5yML7OQQCq5UIfvHH+Q2q5dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

On Sun, Dec 15, 2024 at 11:58:39PM -0800, Shinas Rasheed wrote:
> ndo_get_stats64() can race with ndo_stop(), which frees input and
> output queue resources. Call synchronize_net() to avoid such races.
> 
> Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V2:
>   - Changed sync mechanism to fix race conditions from using an atomic
>     set_bit ops to a much simpler synchronize_net()
> 
> V1: https://lore.kernel.org/all/20241203072130.2316913-2-srasheed@marvell.com/
> 
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..941bbaaa67b5 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -757,6 +757,7 @@ static int octep_stop(struct net_device *netdev)
>  {
>  	struct octep_device *oct = netdev_priv(netdev);
>  
> +	synchronize_net();

You should have elaborated on the fact that this synchronize_net() is for 
__LINK_STATE_START flag in the commit message, this is not obvious. Also, is 
octep_get_stats64() called from RCU-safe context?

>  	netdev_info(netdev, "Stopping the device ...\n");
>  
>  	octep_ctrl_net_set_link_status(oct, OCTEP_CTRL_NET_INVALID_VFID, false,
> -- 
> 2.25.1
> 
> 

