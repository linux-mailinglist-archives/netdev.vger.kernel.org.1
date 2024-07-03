Return-Path: <netdev+bounces-108915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADBB926375
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50362B21C5D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B441DA21;
	Wed,  3 Jul 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceV4jUtG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74D4C7D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017041; cv=fail; b=WCjJ07syERgv3dOzZBMq2jn8OCNi+4xhznwkHap66EJkMTNQIOIlmN2xX1Krx4wYarb6c8f6aEOTc4cbAqLxZzlJsUQrP8F/24Ar2Zx5Kj68KbAjCCDqki2OFaIs5KyT5MMIVsVrOQF/AQ364bCLzJe24PtBgFqFnPXrFeFRI+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017041; c=relaxed/simple;
	bh=uYZGqOqnOj0KtXei5zVgJ32x1DwNMwGixdl5y9Atybg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADDyB419YawMu1Eof3RJzAck/S/sRnNHRFkgD/l9OVzeqFcIQmEi0IATF+Yy1HvTPdabIf6cy164HaiS55SqbapUFLXLqEeI3eKmTIEInme1eZrz+G/S4mNhjCXfudZ42BPb1PI0nY6f1656f9DqMBoOy0WneH2Fzj3s+OdrgWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceV4jUtG; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720017040; x=1751553040;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uYZGqOqnOj0KtXei5zVgJ32x1DwNMwGixdl5y9Atybg=;
  b=ceV4jUtGnJj/wNIzEs/MdCzL3umaEExlFUH/66y4Jg3/mwvWqz+gu5gK
   lnvi3kXQyy8uEAloM38FmCp0GspFalvs8HqcQXnpNvQ2eqLNaEm0jnubx
   1lYbfxZQyPwVT9u9n4y0VmQ6WSPqfgorY4xkgbrEgMHHlFg5fONQjscKf
   ieyJ2yegw7X3tY1y/q/1Q0Dza15YI8eD08zx3Klyr31Zd+Z/TapJQuG/q
   qdnF1MU88lXqw4R3OlKccA16ws4POPzTHYTwseAoRDkEp0ZoQ2ZDLhpo+
   j68o91juSQ3mdBDB0IyESqHkEM/i6D4VxyRoZzBw7otXoOI/rXu/S0ehp
   Q==;
X-CSE-ConnectionGUID: d74YRYCsRuaz4lazzF94sg==
X-CSE-MsgGUID: fPsRPr+ZR8yfK5/ez2hnwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28387588"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="28387588"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:30:38 -0700
X-CSE-ConnectionGUID: GNwkdqV8RM6VmseNwITkug==
X-CSE-MsgGUID: G7PAGrtsQtOZzPTb0bW2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46944913"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:30:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:30:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:30:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:30:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:30:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWTBdz/bvJw9Px8hvnlDqerv/Kb2Ocx9ORTa3h3XZQ77XJGwSBycWlfQAJ0qiRHcr0sAgiduOck0PbNVN1NBTbSuB+2nid8LggTyD2wfW6YCSKglAj9gL+qk4MC/NT2nWvDlk6tQYy5nictPPrN7LjmpdLW8Tq+LqfbdgsecIa7eV2Ly6FJ+QzEnGEjivdB9wIr9GixQU14mx4Wg8LL8DSdgvrTt2Q0UI0iAVnfF4m9HDYqJ1H2vEmrrYgpgpT2eyl46u+H2arjIeRVgpBLoNAeO1fuMJ8QsN44DCj2mr+DuX+TRHoJ172sHdvexCbe7d4QjZ6cb8Nsw8jiz1ztmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iapAF/cBFKhrtGPmCDNwSRX3Ixlrvgkj0SrGIw8Y8Y=;
 b=jv0GQYP/JczV4+g0pZB1w++wfOOvSDCx87ZxEeFHQ01bOFPapBqP/vSOTHbukXac27pQqRTwvjjKQffjy5CkYr+WeNUXOdsd9ySQJHno+iNqGZ2kh5arz5KDPVI/p16mySrnoGsYW6zSmCe4fX8KirHcyl3a7s0cN6hONMEvZRvOeuMwQ54a54NBTr2AoIo0hflB/hXJ3NlJ4G29x98p64JYAJo4AGzbLZCyhvGoRGSX6sDWBOthm1YnWctp0Tj/hmRyI0PV/P13aF8fmmqI7L+r+AI+GYxhG3PFFP2SCna5q90LvjuW0Y9YoYCC82xFSVaWZxesaGMlZJU5N+nBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 14:30:29 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 14:30:29 +0000
Date: Wed, 3 Jul 2024 16:30:16 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: <edward.cree@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <danieller@nvidia.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next] ethtool: move firmware flashing flag to struct
 ethtool_netdev_state
Message-ID: <ZoVgeHbWG7N5yj9s@localhost.localdomain>
References: <20240703121849.652893-1-edward.cree@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703121849.652893-1-edward.cree@amd.com>
X-ClientProxiedBy: VE1PR08CA0007.eurprd08.prod.outlook.com
 (2603:10a6:803:104::20) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DS7PR11MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 464fdd32-9b27-4cc9-23d5-08dc9b6cafd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yT/90wUY8a06uecqAgnNsO4yd8hGHiFhUn2F9JFSKYu/rC1Ag90Ci4aZxZDk?=
 =?us-ascii?Q?BeZRjz0YO6yhtfv4LptzJWOcwXaUUyDO64YRtVu58tpRBU+5vC5fl3B53QiN?=
 =?us-ascii?Q?D9UUzPM9K2BGLHz45n7BWpyoD8S2+iG5LPCJABIdSW1oKUwHuD1D3d0YsBOX?=
 =?us-ascii?Q?yGEOPzU5caRK7NGS4Qa2Mo766t9Htqr02h4uA2s2ivgqy3Rf/wFtsiVSC0SD?=
 =?us-ascii?Q?YDP4TxB2J+wxYjGI3y1fW3KLBfbsZfMp+LrqNTWyPTJKT/6XDrQoDlE6eYwD?=
 =?us-ascii?Q?+Hy+UaJTTCFHxKn9NfH0/YqhxGjXTI9w2O38+ksB/Dr7CTVUVnH5bszDOSmM?=
 =?us-ascii?Q?wNGUzeBEs7hGY2U2QFM9iqcZ2Bz8KfMdraUcJPTYUusqmtjLQF2QTZxgEb+B?=
 =?us-ascii?Q?3FG0Zh+6VFGW7k8L1zWJyc4hQ9vuJP8RFs2pqpcttwtug/aEQC3UPeGkHd5y?=
 =?us-ascii?Q?/sgDZOjPxHbIE0naNXVtB31ekBIZFjBZY4tVVqCoU8HFs/2I85okPicy8nXk?=
 =?us-ascii?Q?8wOfFEOB4oMF/XwwrI6MH5wrSIrt9wv8HDGM1LQ2dWO8lAQfUdNy1ANXoON1?=
 =?us-ascii?Q?9CRLDWw9yyyli/VW5C310b4kApEVOsXG/UAJ6OwklT0g5MoP0T6uqxg0/yVD?=
 =?us-ascii?Q?ZWzs4SrGaMFM+KdFMjA6fMhVhYNMqVKRxZLgW1GiSKqUQTehg14UjVGnhuuT?=
 =?us-ascii?Q?WkDVtxMFymgAhMQO8SjZS2bNZUn+ARqqAbt/PXAhZC/t1AARhkKx4NIAX3nr?=
 =?us-ascii?Q?BkOEX/it0/lRkXIttuevY+C3XwiiyXerLTxrw/z72nd+hlggpGgq01EW33EY?=
 =?us-ascii?Q?/s2MORW+91DUX2j9qvB/V4lWxYGsB5w/ZQrWnSjtbuXYMT9gpGpSUMsMhd6j?=
 =?us-ascii?Q?nhR3mWRBt4x1uHIu6YTEonhBNt0ZhfknYEC73jEn2cHWcQa06rbZ4aNENT7H?=
 =?us-ascii?Q?cdravAZMsXNrz5Pzo2nT8esWDj28W9MK56/+1op9GzfAlLp1J11vPSN7FSSx?=
 =?us-ascii?Q?24/kTzNYV1TgVU3R5ypZtrQzWrdaaUjOhPiN1GGAhRFNlAztVHD4JTJaGbhe?=
 =?us-ascii?Q?qP98oSAzMIbxTULvBxIWP0pVdEiy83oGxBh0VmND1FxBRy8WTRp9wci28zVm?=
 =?us-ascii?Q?iSjBlKFXn8eVVnlC+ShtzoV3sGxCmgptz8XA/VEHsf+LKJQQGmbEBvq2wpt+?=
 =?us-ascii?Q?7kisSWHVjaQJ/BBXCYWXYrpKU+lu/JwR8RUwOOMut2XZPKxwnhvZoJY4Wk2j?=
 =?us-ascii?Q?kstXNmO+0WeYJGmaNTeGfWLbV6giEmyZ4md/THytUvQPqhSXycFpsP5YHxEJ?=
 =?us-ascii?Q?ZoRTfNovj/Mad1/Oo59vu1/adT4VHvk3IqJ4Uzx5/BNUyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?945VEMJohgch7mqj3Nx0cs6SIui6Wq0QEHfmkjU9iNj0L+w/Sm3YRGIDoQJ2?=
 =?us-ascii?Q?LehCTuxTrXIlkWSrqUB+xR2y7UJ0wj6Odlgnqk7AIhZml2CYEATgaxr/lV0Y?=
 =?us-ascii?Q?96tCxJvtOgTkc5qMw0Uk4TLcAzv1ylTlMLwlMDdz5/evyc5qpT54S7UcbJNs?=
 =?us-ascii?Q?tQnvKFzVWA0LR4bI/RgcNwfFWy5JphmjCbUBOe7MsAJHs5uzIUGXIlHYhRCp?=
 =?us-ascii?Q?Qf8hCm2Cpimsx0zGepufHnPw1+y5p7pXge3aWA43659zen3mDycQFT+fnDvr?=
 =?us-ascii?Q?bjJ/hGpYYfaqSBM91g8tWjM9NWr5ujAvMUZAp1jLnGguFtGLOkDvsbelBbCM?=
 =?us-ascii?Q?099rarP7z1XKxN7EFU2Z8wOu5hq1uMAFLd4M4JMF35V/1V1ynBsWL3zoaKPl?=
 =?us-ascii?Q?qCGTJWKlLQYuzd6Uvr/n+hfra418A07miS8rx1bXMplQAL6YRUlWEBIOJp4d?=
 =?us-ascii?Q?2Gt1P9I1EQiu8ph1+nDKn0C3StE0vGyQRfQJd8X/836QePTRQuZHe8HKDGlZ?=
 =?us-ascii?Q?wkEoir4fmdJfAYZZcamEstTNMJpE3JwU8NJWKxbkH6rEuk/HsfaYCfLjYUdv?=
 =?us-ascii?Q?Cl1oNZPaxMx/5YCQDvORaPQV0HeBgPtykV5UXlwn+xvW+C1OR8uIlk4T2p/g?=
 =?us-ascii?Q?XXBP93SetWTaWsiRIvN9NwkQtTI0h4Sf7/krU4xVR3dDBSgmXlxXGthgV9i3?=
 =?us-ascii?Q?eUHHOHWKujTq2ntJ1NCf7f/fJWC+y5+XRu3mUk397fMHkodWW4e8onShiCFu?=
 =?us-ascii?Q?Iw/yOjPRc+CYkyJDp9GNhWQWx+YUySjJz1q5QVoAaO4EHdbTzy1xpZ9pOx3a?=
 =?us-ascii?Q?V7jj+NNuqL1RfRXCUnaXnBsEIFZDenCpmtx4XYI3qX9Yl7P3oQ3Wh4uKybDx?=
 =?us-ascii?Q?mZT+LkPXan5eJD0uFYMzxO9UnYYn4gzslqoKnPoZu0nM2y8zbHUZItatNW2V?=
 =?us-ascii?Q?vtkcbPqFJ9zwfR8SaBBEVYf+TaViZ8EJUSWcai9hM+4p0OdUH2FnCsAepyCf?=
 =?us-ascii?Q?h9kkIf2nCh/PpWvKuRMQ5yd7gttpLJ8GMvMO3G7s8XUUYrp29kh//FcShgui?=
 =?us-ascii?Q?lClZft0mtzCJVZH2G+Zbx80WxOOs3QBea7UUo2RxUHW2tapC9kqr2jjlF6Op?=
 =?us-ascii?Q?Gt9Vtp/6Vhn4LrjZFoOWqS/QbEGk/ZOP6UAOzlUm73X4MdCyrfOrgSkOILMT?=
 =?us-ascii?Q?toCsoKTlW7mmLg6e+aZDJC7he8mqNjhRdOCtuftvnJvnz1/ZVGS4HnHsXolt?=
 =?us-ascii?Q?ew+sk36kVWxUncnh1rBY5M5kCcQHx5yiUFPAY683FIFvEX77xNE0wNPmZl1H?=
 =?us-ascii?Q?wTNnq0hdCzevDnm4dWobQ6aOi8lNJ/MtE5f+OYLMSg7VpTM8wESmOrGwZIrH?=
 =?us-ascii?Q?AnFf+yqWyImFOdxlKh/21RTcyv3psm9gZhKobxGpcuLDOoUFJTitLq4OAA/L?=
 =?us-ascii?Q?IZ+TuvqhM9jUsHQER3XiQb+3IdFFyVfzIUXCce4S2Sost04ZclQyCEiMTJAa?=
 =?us-ascii?Q?O6qeA/rVCMsnilFoH8xLJKMiImx8hKgKdj1vw5BhVGizRtPn1HHxe7LPVdZT?=
 =?us-ascii?Q?dWaEXLCItSTlFzmz9aNRvN/2ONhtZRaKSIjU5YZAXIM90dfY7jhWdIIQX+Ct?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 464fdd32-9b27-4cc9-23d5-08dc9b6cafd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:30:28.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sohQnPIiADBJ8PLc2ChGHQdUtFqayj2fBCQPg7SCUHtVkoZzHoBz0ukdHnkLvJXjINyYq38eWxmUk0eVxbQdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 01:18:49PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Commit 31e0aa99dc02 ("ethtool: Veto some operations during firmware flashing process")
>  added a flag module_fw_flash_in_progress to struct net_device.  As

Nitpick: unnecessary space

>  this is ethtool related state, move it to the recently created
>  struct ethtool_netdev_state, accessed via the 'ethtool' member of
>  struct net_device.

Nitpick: wrong indentation in the commit message

> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
> Build tested only.

The code changes look OK. Just the commit message formatting needs to be
polished a little bit.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

