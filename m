Return-Path: <netdev+bounces-52425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1677FEB3D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BDF281BB5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D23066E;
	Thu, 30 Nov 2023 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5vJt0iR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969CCF;
	Thu, 30 Nov 2023 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701334611; x=1732870611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ijdu3NvzS39Jh1Ykk+F2NrhsEXL1EDuyRr5fJI3dFJE=;
  b=K5vJt0iRrINZzF1iJhx/oovDZ6eeM71HeBMU6KrGu5mFrtWCa0gu93TG
   OpX2iIO1lVDgQa3dfB9lYcucDiZZ+NVigkJutz0+f5//pmn+2K0LMFvPv
   +1CqwDvRSluNr7fDfJon6D+9t8EKGxL4ewhwCal0v2SLHZQf42V8IjdK7
   AWoWy1VTyoxpAw6BRJX9WCcV35T3VGMqXRQyO1q6awCgMIQMPi+yePLIN
   uywHkFWm9JRUuAZW9GBZhEBY8J7L/vq46lGP8O4+GDqkspdSxLp9CZvYj
   azLhhFol8Zx6A7kdPfV5ptOIKt36ObdsxsqwLpCfbXLcp1Ci2PdS7CnBz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6565935"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6565935"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:56:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016572588"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016572588"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 00:56:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 00:56:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 00:56:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 00:56:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 00:56:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQWR+X4L2nFcVmIILNdB75RU21jRa+OpTnTDfzfER2ITEWUnXlVD8lKw6bYm8KSGF/aW0tINwYhkwNRg3Wgc5WiQ8z2wzcJdPVoJX0Jv+zc+kIon+esLvkGxAjfxH58eaotMEu/k4dhNm+VeBxhleCjpOsiEsZhyy7EflPl0PQkW9WjncSrCqsPtBVaybO9cp9FvlcsxClxHVrj5IysGUrn8c7+0DBisT0v7VfyuaR+pgCMCqdU0/ZWak38v90gAm8kXWV7hpD/RlsnUonKU5g67fbsQjSbFkwq2ySPHUfNnBLvMqylhTyzJIDO0tGIek+IgLhtMuWJ8G0IMV8Dl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEGFgoy9UlOv3WW+n9Vuq285bXYgGAPb2Kiq22qyuJ0=;
 b=jBBGOOMDsyNbGHrDZB9q5EPdORJTW+OfO0yfmHb5QNTyfz932Wgck2OkZTGbBosj9HynUbeuD8THwmLmWhmEZQ+GzZk7U1poyrX7EtuiDvYAFF3QPmumrIeB1HOpuTvZjpCxWGfqHPc2AaLS9QI5JiaP82mYQV7TnlHhWXPwzgt+zJt3w4A/C+dSVDm5SIZKLF4vOMtpOMu3RpJDiLjA1h++cGXkuPxna//JRXeh4VmIP5YGFExlBO+8d5F0xMk775s2CRsqFk8aRjgybs7NcjNaFs5Bxji5vm0Fk1Nh9xloBZLbvnvxlJGuiOjNUhRXX9hliOrKKE0cHy1owS1hQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5447.namprd11.prod.outlook.com (2603:10b6:208:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 08:56:47 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 08:56:46 +0000
Date: Thu, 30 Nov 2023 16:52:10 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: kernel test robot <lkp@intel.com>, <davem@davemloft.net>,
	<oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<leitao@debian.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] docs: netlink: link to family documentations
 from spec info
Message-ID: <ZWhNOvnxSMAudjXM@yujie-X299>
References: <20231127205642.2293153-1-kuba@kernel.org>
 <202311280834.lYzXIFc4-lkp@intel.com>
 <20231127190611.37a94d4c@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231127190611.37a94d4c@kernel.org>
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: a40b28ee-3bd7-462d-7cef-08dbf182485c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSMVJNEgwLSU3I2mEwqW2aj5RmQXPPiXZqdls5mTELQ76P80L8OUuSyVu1CQDL/tIG4GJ9Z0J0JignWjuJeIoBe1gCIfV644rbtmqgFOT5IIhKuiE3/jxrpbbOhsyrLsEeAVl/AoLCUF9ioqbsdJcIgd955jdvOWhyoSv0dMfOyuMl4LmcvJ0q9zfMq6U1XvMQZSJ+9k1xgveXC5p2VHpG3kzt89MpAf5vr8i2oUrRaw4CCdUJzfRjD3ukfYi6EdHohOBBN//ba3257UADXqbReJifNphdcW0hjC8T+gWZ07H2MGPoGeN8pqBbbXz9mE9SDgpmbkSBqytP1C3rfaCsWOCD7kM/yyVXPIOYIyWYdvm+YSnl+/lt2v431DaAHInBe29t2XImcI/cXtj82T5bhg/XrpfZOMAFE1k5/dmIt7uU4YVq5aJiMXgYERNAvj8ev0WSJ5pdemPhBLvfYiAvy74jMKRifRywbAclsEBBLBhIilEzLLY6dwG1kcBcl4QKm93QrLJwxv+ZZstq25Tdxb+23p0i+Gv5IMRiFk0Hs/z6nfmRmqKBcf3JO9kj9MYak3F3gkd/atxr8aAh6hICL03jeaRPMvYm+qwbBK3Vy5k/tr9/R1BW/SllSj6cmqKvXe+yCRtvb3IZ9S0cSShQ32E5Fx/uviFKVGAfghw6Ib+k/fzNrUQ7CrMoA9fjlj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(82960400001)(83380400001)(26005)(41300700001)(38100700002)(202311291699003)(9686003)(6512007)(6506007)(6666004)(33716001)(6486002)(966005)(2906002)(5660300002)(44832011)(316002)(6916009)(66946007)(66556008)(66476007)(478600001)(8936002)(8676002)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ueuJICF7o122asjeJa4BoIUJVVIIxQxRcqY/gdOGlJtjD5Up8AAuENxkSYZq?=
 =?us-ascii?Q?4YxjkPwAoE28JlIzzWclXTGbVKsYX7cFvvg2OFN4sHYeX/3crAWUQvaACW6N?=
 =?us-ascii?Q?YO0ztmETg1+3/FE1JK4QGRLqipT8jMlObMnnmH61HSpx4tJnS/+ud/U2t0XG?=
 =?us-ascii?Q?kEKcZ8dhnwXmAFNAkJu+SViemnxgVRs1vlW9ZL5is5ObGel73cASLPLKfkXV?=
 =?us-ascii?Q?OeLaWyx/vWifLe0lQY9D1IhjHm+26+5uTPwmXwECnKfdOh78dYL1dm9jwg6p?=
 =?us-ascii?Q?QDa/O32N6U3Yg015Xn3R0hufyVCjDzVPKpWZipKKU3gblILYsZJitDAoj4N1?=
 =?us-ascii?Q?hz7QQduTSNvlCj7qzLpsYAgrAU/9cWDE9v/fTgsqvKGaDETD5UiE+9MMbRQO?=
 =?us-ascii?Q?3YeXi7OxIKm1x0plDTAhrcR6pVib3wC5BYTexCIF8+OycF6tu9QSZfsWvlGn?=
 =?us-ascii?Q?WHiBquCmNPia5bjPtLFF/3NXan9hnZ0vX8kkvf0Jls+kH5hr9n9aCfIeqV6D?=
 =?us-ascii?Q?E5Ix83ue7bnC9xwc+uSrVzUpP2aK4VxjVGSixgwdzGbmk1psvRVsZoFvuegQ?=
 =?us-ascii?Q?hkX+GzRszZIiql0G1ziGoZCD5nF7wZMX936Tk8e0Z+wcC95cIhjt0RI+UYwv?=
 =?us-ascii?Q?DlEME3OPzPRhaYm6NjmdmwMt/r4lUX5kCRIiYeIExWkf5HSfobJbhcN9tM51?=
 =?us-ascii?Q?B34vBojWT9zBldMMkY4q/QD+HSnY7U9j+f92NWT7PevA/0SgitfWhfhJaXS0?=
 =?us-ascii?Q?BI7ujEaXOiaikW1+SHMBxP5+LVQmJI4im0TcQ+o78uLcQtRM0mSHUJNdxEOr?=
 =?us-ascii?Q?+FelZkrwJXOj9y0ldOjzxzdecNQPMm6KVRfYDQHjacaVU18AE/Wz5D2R9t7E?=
 =?us-ascii?Q?Mchv+RjSGaVKXWH+9Q0o/DwoTAXXWqyDUCyb7NcpsuKKa6CZnMkX4HNpDWS1?=
 =?us-ascii?Q?42R1/ADmno2HQAe/izhvTKp6DRM6/jzLD1d3liYa85UG6mvOQagKLmWxc7Js?=
 =?us-ascii?Q?8uKX/nC3lAKKHU/wjjlUn4ah4qWDdP2szmbc+hv8PuVIe7PxQX2rXn+4yrDm?=
 =?us-ascii?Q?UuUEC6rdNEpV0Y0qce6gcu5Mes4fCh1u2EmciZ22lWPnHSqIjCkihyHzGK78?=
 =?us-ascii?Q?2hSZEdbo3BwwZ6PaktedUmmbIsxFUmH4U2HsCe1YunT3ag0ptUARMsnVllyX?=
 =?us-ascii?Q?0gmTY5FGDEvHzILLUp639EB4YXRD4ULUI+DdhXIpnkvCED2Yu8T0T5OnUCOe?=
 =?us-ascii?Q?D62L6lMNwzZgLirYXZRXsOJXoqzoL/rpJxRgRbQB9sS4u9lswGyhh/sFV9Ta?=
 =?us-ascii?Q?sE/Z5HzwSk3OyoYPJSYyp/tYE0/1bwMjV6lJYBbafZkbLa5swvPDMsPRp6O6?=
 =?us-ascii?Q?CVxdxtj38szOlG37trTnmG0qK9Za3XwUFp5SjADzy6l2rOQmEy5FmHhde/pE?=
 =?us-ascii?Q?MmjFyUQTNHCb+PvKLcEpAWiQ+VapY2AW/3q0UQrYNllza2rpsvz+SDNedLmo?=
 =?us-ascii?Q?OHbel5uPrWXbLxKwDRFREHQDyfG18sIOaN3tma7HAF+Rct0/Q6FgDjRZa6ez?=
 =?us-ascii?Q?JT5UAs26CU6lbnJGUbjaddgMO0XAIY8TcHGXkTYt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a40b28ee-3bd7-462d-7cef-08dbf182485c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 08:56:46.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey9tJCw+dARISehvIJ5a/vegQAZBshT2Hge5fRoZOubAxkbu6qfsdOTbaWxpIJRRdL09VIFyHvQFO3HVBE0GyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5447
X-OriginatorOrg: intel.com

On Mon, Nov 27, 2023 at 07:06:11PM -0800, Jakub Kicinski wrote:
> On Tue, 28 Nov 2023 11:01:55 +0800 kernel test robot wrote:
> > Hi Jakub,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on net-next/main]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/docs-netlink-link-to-family-documentations-from-spec-info/20231128-050136
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20231127205642.2293153-1-kuba%40kernel.org
> > patch subject: [PATCH net-next] docs: netlink: link to family documentations from spec info
> > reproduce: (https://download.01.org/0day-ci/archive/20231128/202311280834.lYzXIFc4-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311280834.lYzXIFc4-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst  
> 
> Is it possible that the build bot is missing python-yaml support and
> the generation of Documentation/networking/netlink_spec/index.rst
> fails?

Hi Jakub, this is indeed due to missing pyyaml module in the bot so the
doc file is not generated. We've installed it now and the warning is
gone. Sorry for the noise and please ignore this report.

> 
> Or is this an ordering issue?
> 

