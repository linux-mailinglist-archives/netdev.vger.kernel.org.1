Return-Path: <netdev+bounces-300101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/TCOghsMmrdzgUAu9opvQ
	(envelope-from <netdev+bounces-300101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C375669802F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:42:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="mLk/t1vK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300101-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300101-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684FB302CB56
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561D395AD0;
	Wed, 17 Jun 2026 09:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93544341ADD;
	Wed, 17 Jun 2026 09:40:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689222; cv=fail; b=ZHC2s2NJFnNoNkU4eefQx1nxqJ1GUWQpTBvsusK6hSYjMGT+IWFvF7p8yjFBfdqj4WTAICUG7KJ3QtOvRiYwHUnrsPTgCDsVhTIWH5B3GcoRvbZiX8pMtqfBx9ZanmTUzZ2fPOCMPaqslLfX1uR3OvLqiQX1pB8YL9ha4aYavsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689222; c=relaxed/simple;
	bh=T9zKCqTmzEz8+/zChrqA4MtwFJASS3CATZ7o/YpjzAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sjoHaXb7c1mUzWkBncbw8XebHYCzRrAPJia/lYsj4TGz8kxWyJbxPBKslydqAVTPXmqLMpo7S+fuw3e31lmU0fPQUfEK4UGAhgxk+OHdqmFXC9+z3uvDxZK/Zfeib7XDmrAjtWuwjfb8r32vAfvtEU0SiQzKdEvgxtTnijYI7Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLk/t1vK; arc=fail smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781689221; x=1813225221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T9zKCqTmzEz8+/zChrqA4MtwFJASS3CATZ7o/YpjzAM=;
  b=mLk/t1vKLvRfWcYptCsc0k4pjlgxjKTeuuUfdq2qM20G9qkzi+5GiPKN
   obWt/4lge8nPhtJVQiRKmxVrR53iktYDc4KSHX+SxswIeeyc0utK9iLSs
   0bPOc1Q0CdPC/h1Y0/pGTa9p/7LrMwRQBldkR8hZ5syQcnhoGr2SXTzvF
   FtQuBi6ckCcLqLbhdHOY7/So3oA373mEEMt9HUebpdir9Fy5CICPwuYqj
   zRJqRw5fOuAJRj7E9+UQA6xL8MKF5ATUWlAQqnw24LS+CIiD11QmE53xp
   Kxb73tVlF0i77oPBoKU8zS+17opZPU9Ni0FcdcuJuL5hqNyhTh5lyANtk
   Q==;
X-CSE-ConnectionGUID: bY5p02soR9qCjaMdRSY7Pw==
X-CSE-MsgGUID: 1fGAoDlvThuonL9HIj7jZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93963171"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93963171"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:40:20 -0700
X-CSE-ConnectionGUID: 8pJj4PTfQxq4qnVG92si4g==
X-CSE-MsgGUID: wjUGYfzoQ6iHhqPXiI1dCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="248082752"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:40:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 02:40:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 02:40:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 02:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwUeMdw1dK2ceUtiJwCQljdwgri2Q16q4O+hFqjVZebGb9H10vKxrAyY2lX2JC56M39DTlg0xkY3pcpNlSEQxwpAtisuvSUGge5GJYbnM5hRYX5PaApspTuQok/vOwuZYvQLlOtJGI2zl3qjtJFW3xnEFFUVROshAPbIE+fgaza5THPxUgwb5xi8Zy+S2JJ2NY1UKZ81UfpjXCRTrSZDhL0RfzEYSjjuWrZ6TNF+xU8+LUy3Jma36WMtr+m7L1Nr8+QIB0WoEIjVfTKvYwysPlFdpcIxfazHVYnAdRITu3Ju83MTaT6mI1rNYPC+N26aNgjQ3aW9HE8sjyHlL5aeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K2LIv40q/PgN2kZKaVMb7yRSg4aI7pvUoJ1raFvvXY=;
 b=ouaFJyN/hsNhdM3gQIJrWZm5UteUpNpVPN0SOfqq+bTlxgX0fTfM2/avlbw2Y+/xwAq9Iu4jQIZAeihktKzxmludkSOnfSzFfDmX4XjB7+FrQi+DNzr65cjpUw+Gy1onYzMJs/Ls8kS/mT0aAM0WqoJsiQnwcIYvOy8r2mNoAFOBnImZ+o3/yXVy1eXxKAIL0KUDcEAPlsla9CzcdWeJKWhhl9N97N5W0uETYtIfjaUmkv7lKubr4Erh831/1aibnR/3briZzcRI/cSBVkRn9P4UBdX5XrXvuYEFnj+FUkJAwY5/Cn3tzYWJxaE8s8NH6WeMjjRYimtk8vbKOvvksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 09:40:15 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:40:14 +0000
Date: Wed, 17 Jun 2026 11:40:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Menglong Dong <menglong.dong@linux.dev>
CC: <menglong8.dong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	<jasowang@redhat.com>, <mst@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <magnus.karlsson@intel.com>,
	<sdf@fomichev.me>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bjorn@kernel.org>, <kerneljasonxing@gmail.com>, <netdev@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Message-ID: <ajJrckiXEUztBQDz@boxer>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn>
 <20260613112113.55d9313f@kernel.org>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYn10tJ2SIGF1pAhF26DRQ@linux.dev>
X-ClientProxiedBy: DU7P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 25672ced-fd09-4de3-d413-08decc546f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yBn+hSgo2Y9sM2Kd3IS7t2Y5bGue8Pla4Bn+svwfiWFAwosuUJbnIgbzw0fUHEEG5i5c1QfalOJCHYEWYpZ0RrkDNf7SR7hNGZl9ZEKWNdlkpK+qCbZPGkMrRrzKWTz7ECFuW9FIsaTnsQdPvmfx6H5tJuNZlv1KbdRE9acz768D5QXeqcRWYGR6KpGAGjOF3woy/CqMMC4u8khdYx4VeyhiYPWxXKmLzcT+d/yS59hvvBvPMnLmQVceyqFEF6Dz6ayO8FoaQrQaR+q73oe88+/hQtnB6SCYfch9oIrSGM+Er9gfF01wiqrz8Lsb3UjPPYfCeslsRGmIE3Oi+pso3LynhsUYKa64nGPRfUrPu9xhkRD1lUWqsUQbUwHNIjQoMi/e/RR34ZntWALRNxH4jTdjid1nsycyPY7gDkpJal8iL28xEUEcuMUfKiWwid5xByqJZEXdTyzmR+GRq80TVlz2eGNi27n2vieEmPxtjaYPXgfs2dcpM3OwwO9fsu7dXTr8IT5zKCux7g+Bo4gYwkFjnE7je7pO18hy5ap2CUDqa3yU6BAXOdsy6VPnfPVskjsfJu4kT+ATCUeic9dd4HZ+iClWi1qMoXytJuwAQYsIjVvyJKwe4rEuDVDfu+y7BNC2fNh5f4EPf5DB3yDEUAhATYm502Os+4Tvs0FHsj4VFucN8sDl0G5xYiLDaUgd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ik76MwBcI7GBjVkWPihIySU+fb5BS5VAIT/5oCK80cFAKau9g8rktKu7+enT?=
 =?us-ascii?Q?ly/3geh73IS3VJxEVup2eE+fP+ou04aeX8Q3kwuzjyGs/53Nd7beGtVWnE1Q?=
 =?us-ascii?Q?yZ9ly0IYJAJh3OzVCsCdxEEq1lYTNVxVmMmPERk6Ie1WnSmqniMv2SQ93X7/?=
 =?us-ascii?Q?7wQZ40Wh49MpHXSNTB6d2IepqOdQ/okLgLpsegHnusq9nG8m+y75wZKjTqug?=
 =?us-ascii?Q?Li5BODp134C3Qv4CuizDR5fk6HqSPf2WeA5FN11uGV3Hzw0AHJ5f3GJAWvyE?=
 =?us-ascii?Q?dueeA1LuiYkFwfeRara1ED5s2UChMe317CH6dY1tscS1SsTqdfzKCyNL6wIl?=
 =?us-ascii?Q?aFUjIrOn4HP8+c6Ekg/JXSYOVRjn7f45bbbo/TRSndgEsNcfdU5r97i3CcJp?=
 =?us-ascii?Q?w0ygBWiD4jcokLSagd32rT6dWO3hlyT5K9mCYe1djeTNdIBk+e3iJxbANTIk?=
 =?us-ascii?Q?bv6KzuW1RNB7UhgzZ1+jOvRiid6MfJu055Qf+WC3cU9jxXPkNVWBK5RAA4XI?=
 =?us-ascii?Q?vR0bfjSFBEfPbR2I/7iZ5Cz5qpZ5HGke4OZbbSXdUMGBeLsbCUikLGOyno9C?=
 =?us-ascii?Q?GAfH62JmUcAA3GD/GxilnqgA47L5hLxa/tYBggNLiAf7gCpgTKZ2BvKxI5js?=
 =?us-ascii?Q?Tnz3EaAfSuhNhovZzNHniMM7A0k+9VOnN8IdYCpOW2+8dkN5z9j76eGWTc8f?=
 =?us-ascii?Q?H04n510h5QrSxtwGftL6FKD03fDkzNLtbf5VcEFj4adW2ewDjmUroKQfikU1?=
 =?us-ascii?Q?2Bi6XaoqcnffN8PL4SRKY+UgFhzxvYZddfWqq0j9cQHpqoe4Xh/M41JbqqaW?=
 =?us-ascii?Q?ehSVBPdfLeYo39YxxogQKAmpZVJMlcCfxGsNxYDF9zUsLbsluHtQstUK9EY7?=
 =?us-ascii?Q?ePoVcFJAhAlmMlTt1z5VU0IJYoBwsQSwKBK9crV8IiQ9i7663hbpYHJNxITa?=
 =?us-ascii?Q?n/jcnxKtNKGqhYQ3Dem0Y4tLrCjZuWiqnMU/EgHECCQ9Kggk3LvWgILyGRit?=
 =?us-ascii?Q?xF9ayj8TLAab0XC2UNzBR6oI502IxD/zU0LfRpm6cjjv65kVeLNI7XwMldDg?=
 =?us-ascii?Q?Hqcd0Iy9m9LcckBbk4GrnfB1X807VRBTmC87FqjS5Cxs/cI+KtsV5nwn1AdT?=
 =?us-ascii?Q?KFWiEOzxV87DMWQ1ZpRKsgNXdrqAZEkzl0wc2R4a4YN7ZiWN8A0J7tS7BpuS?=
 =?us-ascii?Q?LUqppgjDb2KFmSl6rmeddNPPkJCzha59XcSkZvUWZW3/gYqtKNEwsmrAsw/Z?=
 =?us-ascii?Q?RbgT2i/unT+lOYKFawT/7HqeLhsNK1mWxdSthkM3kw98A+gbytomzFFjy9WB?=
 =?us-ascii?Q?QFVT/kgxhQCV1rPtZkPLu67QaINtALVXnHy3DiQQPxM4Ce71kBUe10kWh9/T?=
 =?us-ascii?Q?lmkdJHPRWJKoUqRpJBTiMczPg/8FbNYKOkMwbT9PNpiAsNE4xprvPErncJhh?=
 =?us-ascii?Q?woTa5fJnn++Al4EUXiqtvCwbhlbGjeuxDUXGKZ+Ug+PkfhnyHBQ42aK+bg+2?=
 =?us-ascii?Q?l9cHuQVr0q2QSaG3Kr/NAJp7opwy7A3Tf1IPCmy1Ij2yagaMa3uvoT7Ygqjw?=
 =?us-ascii?Q?qBbGU8iiYwyLhJ+2cFovd0GpIwmnowDvmSlteemyVCwaQP1CWC4VT17BA8jV?=
 =?us-ascii?Q?Ej/mSOkX85mIIgIp9bCuckq8lyTehxz9afXHyeYPPRHEaEjwRIVxM8dAuScS?=
 =?us-ascii?Q?bs2d7+JdcjXHceq4JLdfVydOBCbC4M/DYhb9D0KjhxJETF9OqJtt5foRRXee?=
 =?us-ascii?Q?M/f7amEZILc4R51RYu4J8Y5M/igO+FY=3D?=
X-Exchange-RoutingPolicyChecked: TiIIuV8xOVIwLbNhQ/anOBqwoeL82Iczm5ftolwkDhpkcCgPwAXEhpYOKzPRs8trOBT+uu0/XZwBP5EUWxy+2YS68CYb+QLT9cJlXiB1z/EIFUzZ7jhendsDvtADHDvOeLhYKSDLEElFqs9pbqNyo6naTlNo+wOhoCVCzuiYandkF5rCQvJFXerZxRdFBs3mnq06WXlgp9DdUcXkLBqv0huFlfCoxPOMQcsdsQuMOjtIZU/WPBwxIFUIeXgg8AIPHJ8Er4a4A0PrpwoSWyjc3e2aw+7hVOIIoIADm3iKHkxRBHkH4FLhba3cipVQOpqWPULCo7pT7psT3PSH+U8BlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25672ced-fd09-4de3-d413-08decc546f15
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:40:14.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ab5mXyRQiOigjtApqrgxEUK0eeTX65WB3Dd5KBjIv5Fn99hdgJ9tucj3qlQSmnZNyjVs7uewpaWCxbtm25ZWI3+Nc1EIylMh+2nzIEElb38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:menglong.dong@linux.dev,m:menglong8.dong@gmail.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300101-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,intel.com,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C375669802F

On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> On 2026/6/14 02:21, Jakub Kicinski wrote:
> > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
> > > will call napi_busy_loop() for the specified napi_id. However, some
> > > nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
> > > doesn't work, as it can only schedule the NAPI for the rx queue.
> > > 
> > > Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
> > > napi, which will schedule the tx napi if available.
> > 
> > First, I thought the only difference with Tx NAPI is that it can't be
> > busy polled. So if you want to poll an instance don't register it as 
> > a Tx one instead of adding all this "tx polling" stuff in the core?
> 
> I see. Register the tx NAPI with netif_napi_add_config() allow us
> busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
> sk_busy_loop() can only busy poll on one of them.
> 
> Before AF_XDP, we don't have the need to send packet via tx NAPI, which
> means that we don't need to busy poll it.
> 
> I analyst some nic drivers on the implement of AF_XDP. Some of them
> will check xsk tx ring of current queue and send the data in it in the
> rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
> for the AF_XDP zero-copy queue, which will poll both the data receiving
> and sending.
> 
> In the case about, they will do the data sending and receiving for the
> AF_XDP in a single NAPI instance.
> 
> However, some driver receiving the data in rx NAPI and send data in
> tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
> rx path and tx path, as we need to wake different NAPI instance.
> 
> > 
> > Second, can this problem happen for any other NIC or is it purely 
> > an artifact of virtio's delayed Tx completion handling?
> 
> According to my analysis, only virtio-net and ICSSG driver have
> split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
> me that it does have the same problem.
> 
> I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> Maybe we can modify the driver instead by using the same NAPI
> for both data sending and receiving, just like others do. The
> advantage of introduce sk_tx_busy_loop() is that we can split the
> data sending and receiving, which maybe more efficient.

Would be good if you back your changes by any performance numbers. I
believe that drivers do tx processing via rx napi as before AF_XDP it was
only about cleaning up writebacks, AF_XDP added more weight via actual tx
descriptors submission.

Maybe you can vibe-code virtio-net to work only with rx napi and see what
are the results.

Side note/question - Do you have a tx-only use case for AF_XDP ? I am
planning (for a long time actually) to implement asymmetric AF_XDP
sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
queues even when you do rx or tx only.

> 
> > 
> > Third, this series does not apply.
> 
> Ah, I'll rebase this series if a V2 is acceptable.
> 
> Thanks!
> Menglong Dong
> 
> > 
> > 
> 
> 
> 
> 

