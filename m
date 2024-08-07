Return-Path: <netdev+bounces-116549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53C94ADBF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068281F21D52
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6F84D29;
	Wed,  7 Aug 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlQF0qxO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA678C9E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046980; cv=fail; b=gzMXbEfPVDJ6Gln4NvoTfzTgF6SF8m3Cy4kc1sy8OYUajaPrKnsu4N6k+7ReYLuNzYCMTqApKfB3ODGaBQc3tLeVo/xCc8K2CxiJ69VzHbO3F9h2qQt+rPLtnsaQ/JESLm1hEEEB8jIk+Emnwlhe+VKRDeZU5zNYgsVsqv2x03k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046980; c=relaxed/simple;
	bh=7rEEzgDhRDVx6M2eF8qpBOfHW1U7K+6aNJFuz2a6XK8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QiQIGOzcwZO2fMpZwvbT6J1WyNs0B2TVv9EQgn0DeG228Vdl73xnWrK0O/2ngM+fz1ySJpnDjbovuG8bBsOpJl8h6XvNw/IZjSZ38KZpbFeS1tH26S2/8JsRqgHnMmCEzZ75HiGLVbK0wWmuLN/9DfBwz8sRMdI7sdc9t7HLNc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlQF0qxO; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723046979; x=1754582979;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7rEEzgDhRDVx6M2eF8qpBOfHW1U7K+6aNJFuz2a6XK8=;
  b=BlQF0qxOLXKkrKcfN42B+sS7JEtHDtyLddFKTR7immMU7fvI/sSvmvyl
   iIWWpb4jbATfZraHh0h7uF6ISHlxLbMlSYxeNwE66N8bzdzkQGi4XxDw+
   Jk6ipImh5yP+HBzQneSjVqZB9XYD5hNpoMsB7OzXnKpsfF+RBkmbtrd/t
   0qWOkSY0JPBPEBNnDHqJXjQ4IlrxwRX74Lbh8w6H2T85BJglefgu5jEZb
   kaTXSN4T68KMTyAcRgs3i2oevp5QNjj/ab+4zy55noS2aK1VrJ5hIqHCd
   YzFqjgTfGaCL0N1fXsert0harSK4xC/mXeYNGg/TsyUauQjIwdNH3WqXt
   A==;
X-CSE-ConnectionGUID: eeIQVbNBS2ishy3/DYeqPw==
X-CSE-MsgGUID: rRe9MXXkRRusUtwN/mIpQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21100681"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21100681"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 09:09:38 -0700
X-CSE-ConnectionGUID: PS42B8PcRBygdHNURXX6Dg==
X-CSE-MsgGUID: yYJiGGmpRq2rGaLB+rf66w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56989633"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 09:09:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 09:09:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 09:09:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 09:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+15qwY5AWhQ/NXS8BPELu9MadDGQX51xaGSmFA3QCzOIDIzFWfGSRGAOG1yNw/OgWGEJ0l8i1D0U4sXqJjbKx9jZ1obejJAEdHZh9lsLilE7jPZgVoTeD0BeZbzv9QZLW0Cccxq9vfdmfh8VM8Z4Zz0VHBWjhMwybW2MVuNdxyevvv3b/KJLPecCG1Q0MQYi5qGjUO4aoCYCat5LKQYGNzksadNkrB5rPwQCyL+C0nYWZCvszwHFzSC4rHmvviZeWZmqQwlifTSCR8emjcXj9Xtf1tz4cn3SBtraGBZO0bud93u3b6krft4U+k0QROl3pa2gAVkO9B+UsEPCZqRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWJVvnlIVq1hoO5p8h5ZwHNMxD7+e7GU7CMqPcVHVx4=;
 b=tEYLjplWRwBUqBuSD0Qcqzo+kg9KFlKiPWe2g+do7GcCjsjNXWE+QUfnYnhKXUzfFf7ir/lSTD112psOogeShUCxjVNgkSVvSmv77qlVGvsu/dSLiJ3m4BHw4KE83Sl5m4897u2BI4u7vW+FdWFHUpQoz4cbEBlUR5b9/S3XIkGqeAqmDY8u3XFNghGU7Yv/gWHd121oMUZZN7hUL6gw9PqOeBaluOSSHZoeTyMATRNkv//dZSgQ9FF2Z267JgHb48TNL4ZdE95llR24nMFyN7tvFJEF4K+q6ir+ciM/LGd2NMz+obBwwA78VBa3NsM5Q0htrIVHMsF2UtMP0/jyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 16:09:32 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 16:09:32 +0000
Date: Wed, 7 Aug 2024 18:09:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Jan Tluka
	<jtluka@redhat.com>, Jirka Hladky <jhladky@redhat.com>, Sabrina Dubroca
	<sd@queasysnail.net>, Corinna Vinschen <vinschen@redhat.com>, "Pucha
 Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <ZrOcMAhE2RAWL8HB@boxer>
References: <20240806221533.3360049-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806221533.3360049-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY8PR11MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: e18fcf1e-bda0-4182-6190-08dcb6fb5304
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RLOLjquRUJjcAyNY/Lhf+3qnIo9aZss3p3UmnNy54qjpgBUpZUJn7VVF+aGM?=
 =?us-ascii?Q?y4M1KtlLF1HCSFHpEJ+LJWRgFkY69kMouCQLgreN341bW6JlD8xAp9EVCflu?=
 =?us-ascii?Q?382Tpm8+f7f4ZCVOBKSlDEuMb43doS9X6l7IjodqzmY1PQD/078rzVujYmuh?=
 =?us-ascii?Q?pQrpiXvDDZCuNUFE9R2yVPiMx0ojIYB1bFVi9pwOhbkIYXERNF/oqxqkNxFq?=
 =?us-ascii?Q?KbV1IkIiovljWwL5Km0/B9xCGZ58pKoNNOVSH5gevf1G0TT6Rwyifk9ZNvkw?=
 =?us-ascii?Q?6UDPifJKgaDq6fF2HP1aFF/oOyjcbfDZcKMZMiOHStB2Btltvo10lJxHBoz+?=
 =?us-ascii?Q?MviuMHTRknXfvUacZ4P/0ZrdhPOZYm5q1L01rLoVZPRfLdJRjJal8HylS0kL?=
 =?us-ascii?Q?ZtUx+MkbEhCrKGbOlH87ytkOHKfXCXgYDPTw3TbZRNhrdTe1udnnNTQtBqR5?=
 =?us-ascii?Q?QrQZ6JrL+Cn3yv1X+Lv/gtWdXCTS1bQPYwXI6aLTX3UNdcizrJ1rRDEVoDrL?=
 =?us-ascii?Q?2XnyQCgtUO9Yh49LIrgt0wp+3OTvAjbWsxgeGeGsVt7AF2ftIc3jQ0YFsdHH?=
 =?us-ascii?Q?jv+qfy5FsVy9SCJHsLSUcppYSbQYYF3pbLjVnwMtM9o1NUbuVZieQjaa+K/o?=
 =?us-ascii?Q?fOodYVzeW66sAFe9XwU4QB52DSm9LJdL0qjq8bWJidpG4SMYxX7jYy9Y477M?=
 =?us-ascii?Q?t0CKhtI/v/AKdG6DUE904Ba2f3KFArAf2Xv7NKd5ANJ2fwhYcU4+CJgd3R2n?=
 =?us-ascii?Q?0iE3KfLp9wak+nUpPZnreZ8ilX8hSQ35wEbY2O4IHBXa/jb6J8NJ4NHE50XF?=
 =?us-ascii?Q?E9qezYkEmrlrdAky8RQLqxmlE8i5LCaRU/0RO0YgtdFF01qj+Y7Hj5Nk+BT6?=
 =?us-ascii?Q?kxz5p2gbR6OxEStw12q9MiUnjoH8G1XUZGnFfgIz3Dhb1GCr1ElplJj7aa/5?=
 =?us-ascii?Q?Kcti3JZt0OmdgfwgustfZvTCrd2BNOlFwG7SyhwiiCKgUiIaflYJu/2QtdUH?=
 =?us-ascii?Q?PytI+XP9lTg46wVgoOyPHLpMx5iV6Miq9Db0wqi5hydIzzjWgoP9nt+0v+2M?=
 =?us-ascii?Q?5LAT8KzbABRJL4ZVHTYIda5fXR4+iccdQyrzZPrZvRV6TB6ad/fXzkuitEp2?=
 =?us-ascii?Q?kEHvqg8hErhN4Ob2ma7/+Scdv35YXzK3gt97o3O7xk8KNjw6S/0xmX9LxwJu?=
 =?us-ascii?Q?4CpPQVoxHIuN/YvzenqQBNd+XqqZXbyeX3L3FiKXM4ZrOT+VqL6lLLShd68g?=
 =?us-ascii?Q?/Uzbh3kTY5eB4PBRJDcyA4+nDkhIoOXOTi3gueBqqp5mhU9FmbtpB5qdnj4x?=
 =?us-ascii?Q?F1Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNFuMZT0tIcVziFSzzeTfWq4c1TtXqbn1I/9yHfb4XnavQrOJ3QwKv22yHbO?=
 =?us-ascii?Q?aX4KHgQIILO5tpEPt+T3hHv8mpNjgm8oRnjiENgUSLFjaHEN23aC3MEKuP18?=
 =?us-ascii?Q?XfFAzfR76WpKiDvULY2A/1eUG3IQHyRkp4YU5/qcG5RWoPlap4p3YbZdpkDv?=
 =?us-ascii?Q?/b6EWUJfpaMUgc3Fg1sG2F4qkyG2yNYOqnfB3Z+k/98db1nO6i32OUoxtGlK?=
 =?us-ascii?Q?Ky/D0zWzJ0+YrzU7n8gnV6KKeoKWHWginL6ASuwZrt+Q6BChwn2zcjmON5a3?=
 =?us-ascii?Q?gJUHEEjnUIKOmA/QaUCMD3z594k6fZSm9UTFzzVb8rq12QX2nHmMyTnrFdgX?=
 =?us-ascii?Q?JqZP7opT2t68DFn8rQjP4X8/c/S/+BdhovcSfwdkygPY2+SMa5aMB1VOj4aJ?=
 =?us-ascii?Q?gcuTFizDt+aNnla/eYd2AwsWFKRv987lYCU6RUTTeeygAYU3hcYa54quVXte?=
 =?us-ascii?Q?abA50qg1csP3fXeWk3YI97l9hf2IhWeaH4Car1Vpf/emI/pmKRzoo6BYsHUf?=
 =?us-ascii?Q?+iO6NYbJpLHfEYM7dbKnF6IIAbIEOBQWRe8ZgJ2yBuGloVybD7EP637G2Rqi?=
 =?us-ascii?Q?qcsqxtJWsv/7F61jVbKGPycNZt4nh5vBYSC4y/UeH7z4rFVB7AhBk0CuQ06j?=
 =?us-ascii?Q?CxqHLsskQQBtEruA0A1RrQGsOT4Z4SFLBNZkGyZWby0y2nt1n9WwMD6NvXrC?=
 =?us-ascii?Q?LoaMZekX9/sNYcbfjJS6ONa+e4BCNEB40cK33jPQ6P5XYqZD4zcSWE8bMVvX?=
 =?us-ascii?Q?eZ1VVKSybnQD03RXQNNKGj1J96z8fd3wcG38qFU90TssDhbsk+hlNxA7sFB5?=
 =?us-ascii?Q?iv4pyudcBX46k9OS0/aQI2nRNU/EaFJy8CFPA8P5O4A/I4L5xlmFwx9PQyXr?=
 =?us-ascii?Q?1JVNyqdQXqt1VRao50210tUuYszFIWaNLFtCRG+a/q8biKpu8Q6s714/5KKr?=
 =?us-ascii?Q?AFxkgfv4cyvSFOiTsg0FiVJfigypG0Do0lEfmppQNl9MTO142O9KknXS3RMH?=
 =?us-ascii?Q?iPAXnxAc3k+nLChXiR1KLHA54PyGp55xF0SZE+WtgPaQrXOJnQTTX47H1OLV?=
 =?us-ascii?Q?Jj7W4EBDMVa/pYbokAEGktJCcGvihijzE39XYQOrr64ZeDEZChYcmJX/tYh1?=
 =?us-ascii?Q?3NZmkRsDFuUQ9jP4xPdnSReO+YfqdY/ujZabiaSrTeduM8oYa3rAvUJzRVNI?=
 =?us-ascii?Q?W9P0JnINACmDj3Wc916MVQAWz30/QV2RWtyW/6IAdwfEE5sLrcCxmsk4OnGN?=
 =?us-ascii?Q?UtVTVYnYxSTG1n2WiXljF6/gBL/WhQxcmmUDjQ9jfqeEJyo2g11ePRnPhTEm?=
 =?us-ascii?Q?n6WgcCu3S72UeCUlISZTVRzhBm6RIdcWeXtogfR0syWk3yNXzRVXy9+sXfOw?=
 =?us-ascii?Q?Tib0KZulCalrrKHIMWwzuiISyRgWXLXWRG8Du11gSn4osBluzPeRao1jp1bN?=
 =?us-ascii?Q?qp4xia/2hK+nFXerWiv+IGSHufSWmZMvd/wsmgRphyk74B7F0fk/WGN00SUY?=
 =?us-ascii?Q?IxGgbSJA7HdD2EwGHZOTO2FZsernPcjfYQEu+pChaZsq00f0Y8s9CygLm1La?=
 =?us-ascii?Q?nZ2y7SZiSzK2hn/AZXrfvPiFkly17SLGmRIT94BW1jgVNtC8U0wWFgLEMQY1?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e18fcf1e-bda0-4182-6190-08dcb6fb5304
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:09:32.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjMlWzTaBus2cIamdiex3UzuCDTRmdMxrbuunIXQYBjD9ACNt6f2yQmws5dIVm7Bue61xLHQFSpyZPVpKW6/60+0aK8mc3obCQclTm6H2rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com

On Tue, Aug 06, 2024 at 03:15:31PM -0700, Tony Nguyen wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.

any splat?

> 
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
> 
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>

Where was this reported?

> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> iwl-net: https://lore.kernel.org/intel-wired-lan/20240718085633.1285322-1-vinschen@redhat.com/
> 
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 11be39f435f3..232d6cb836a9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4808,6 +4808,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
>  
>  #if (PAGE_SIZE < 8192)
>  	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> +	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||

We should address IGB_2K_TOO_SMALL_WITH_PADDING for this case. I'll think
about it tomorrow.

>  	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
>  		set_ring_uses_large_buffer(rx_ring);
>  #endif
> -- 
> 2.42.0
> 
> 

