Return-Path: <netdev+bounces-74214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E048F8607B7
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F62F1C21D6E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7E370;
	Fri, 23 Feb 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRJKCQb/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3C38C
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648162; cv=fail; b=j68N2VSewGQtJtxJ9pWCCjA7G2AEu6KiyVzP+DcbQRWEg98YbKLHo/G5pH3BhEqsHaukrXnyZmb3xGZIIFZmWVbHAb9llq6nYJUjVzcnY9s125k2Id+r0eEiif7rWktE1DO9SgwKLUoimoeEuI/Uvlfw0EJiooysuNWNZWB51j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648162; c=relaxed/simple;
	bh=KdIfUsbauwfUtOlYE0K6XoqqlJvyRZpORB18dOEX+d0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tcgfJIJbrY8dkJhPnW3yijnW4T39WZ0ODHRzRgpweRpsDzFQDL3n4qrhvqQFM67cnnbnpgQNlOg5avPyeQKVOXLuQ7QjvJLnvHY6WLq1V9wHsQEbNRxEq+YqSjVnRUuZJXGQfMKz3RBRjgZTBwA/oQTI9CEYft1ifpT82tnHrsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRJKCQb/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708648160; x=1740184160;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KdIfUsbauwfUtOlYE0K6XoqqlJvyRZpORB18dOEX+d0=;
  b=dRJKCQb/FmaqeoSVjBOjT3UWyAP263Fk7acJJW7vWvOnP53fQeKex/Vj
   FgDkc9hpHXFOH0z1PIjnsZr5o7be685metyyazUBiBNcuiKsoTDqCs/4A
   eHXoAcD9/12KDFwRA6elErMdPgGFsKuHXWTjNgQK5X6/9e5vB+0Aa3j+2
   4ojcbxFhN9RZDqWgK4RLr5wHLfuDq3urDqbU/fPvE7+BvS7xKdH4bzHpg
   U+N/RE+gyEbMgkjkivOX8vIMBB7AjfFVqiwWvPG2omoOFOnGVs3QzOtaf
   vgwY6L/Pss5rXbld9vd/K6QeyiSbR+ZIUf0orpzxX1xno8QOWVj3bl3T4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3436144"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3436144"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 16:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10291047"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 16:29:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 16:29:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 16:29:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 16:29:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR6rwsJOTgsLf8YRVrympMhLFl82ZoIy7CxvDijwfmHlZ0IWb3crDZGR+M08XqudtdDDbvi0fj88QjZziSie8lgBMy3u8NURLtrPUd8+DESVmlPaymh1ULFWYwcsuiAv92jGvx1j+IB8slPQu5pliJj9pZ0Vdiq7SraZDxTzci1mY4vKJT7o3OPl8l4Kf/FI14LEcolLWA91wVDulPWMgdC7vXjw6ChV4Erf5G6W52QzGrbFZOwUST+4olQyLpo+fSSwjpMuiA+cz73eJ2PdYVv5N16KZpGLg7iN8TJWgaoCft3/nID17pqWU47KLihDUJTs0vKVuT+YC/zJvDiGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxXzHQ52O7zxLUQ65MXDy9IgrJ7/0t47ZuDd1VcJbcU=;
 b=AUnsWO6I9dA1O7akTY+59aZmeLalwfXj6r79QLu78G8+iukDPWSMm5W8ySO6EbtveIYDN3mUlsTPPNlxSCTVLp3Kk6EQF1VZmvEAYwMmEwJuv3iJCo4L36H3CLv2LUrhM35kAoCw8S/2nftb2l/WO6QnOvDU6RQrsn6V7nwMhvC0VxojybptbRcA+ai23Ux3xvzZgugqIMMdcIVDZcyn+Q4+hXD9InBX1A/0Rj2cCAJkutBlU0OzVGXK3D77WLYpOu5Vd616UyENek39Gx+8FPhecHTv8QW9H2QMq5xjDWR4RRkZC9WONUmIAsrmwwfV9eRjI8TyuupYYKDt1Xpf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 00:29:16 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 00:29:16 +0000
Message-ID: <7d89adc1-2d2d-4681-b6a8-166221639997@intel.com>
Date: Thu, 22 Feb 2024 16:29:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 3/3] eth: bnxt: support per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<danielj@nvidia.com>, <mst@redhat.com>, <michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-4-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240222223629.158254-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e1a64b-c462-4b45-53f1-08dc340677ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMRDnwxmp3dsY7dfJpw1B4i6bYFl5GHkDh1AgVR7Qj+PLVknCjTLtCohFqfUpStwrtZm3Od0hULVlZXsGm2SMmXyIrR0tzQ4WXLDxxPi5A8mxZUIZNouqI33e1dAr5LOwIHFM5fPGe50uOU9qMHOglTW48pIxtNGAtwx+iI1gDtv0osAAJQ+hrqiIDVOMch7/H1WidDhVeoQR2rqjcHuR2QBTYnnM5HmLwMV3ZrQ4aJPSl/Wp8VyHMQf24paKZmPfN+4ZJUokpl7NuhyAb1Se6or4S3lwaz1uwMiHIbSGbIhuG/LvXuFeA7Xfp6+5DDBDt3oEOmCFuu/mhTbBfNp5jOdbOP+kTs8CedpyfH5u3NOPujI383sn4eECEV5NaQMkgCwFOiRNFmeqHX2as6mB0HpvdZrWUT2c8hIAeG4KePElHBTVQ8t4AC4EIhhjnlLnuhQJxq1NLbY9teWE+f8mRKWYHJ737Uu3D8T3NBXkKM2466+XgYGwUg44h/2YIBuIlYMcr5wR6RJvQHVq7JJALriKAnrEG1jgYXaU/REdeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5VRGoxVGNFV3lFYUt2bW4ra2F3VlRuWTl1ZkdvSkw1WE5EM1BxWkF2STA3?=
 =?utf-8?B?blN5bW1Sc2VrZ29PY29DaXcwbUYvRXVBNmlYSEppZDJ5T0sxSFlvYVVkZENH?=
 =?utf-8?B?RGpzYm9Rc2w2cGZZR1VsYWFMRDVYZTh6N29DV1l1YlY3TDUveWFlOXZIci9F?=
 =?utf-8?B?OE9UK2taZVUwTE1ZZjNIUGdMeEh0NFdvcGIzQkdTSWtNeUUxRHBINjJmL2xh?=
 =?utf-8?B?eG9UMmtKRTZDZk9BUEpWeEdZOC9JTnUzdHorNUpXcmlUNHhsTWc3TndXZE1s?=
 =?utf-8?B?VThhNHVRbFU2cWNodXMxbFdwYUZFM0ttTWVlM0NJcXF5b20vd1RFOWtFdHNa?=
 =?utf-8?B?b253OXpLR1pxRnAyRG9vM2g1MGhOOURiUmUvcytCWjIxLy81ZWlJMTVNYjBz?=
 =?utf-8?B?enRIcE9zZHFEdGk4ZmhqTld6SW9UMjdxOWlFcWVXNytyMWlLM1dlQjlWWFBW?=
 =?utf-8?B?S0FXRHpHR3NKRnZRWVlDOElsdTFuOGdYOHNXaCt4d09kbkx3MXpTMStTMWJx?=
 =?utf-8?B?d3JZbHNtb2V3V2xyd0VIQkRZbnJJNk1BK2NSbitJdFVKQXFtanNEMjNRTk9t?=
 =?utf-8?B?SW9tSUlWUDk4RzVoSnhWWGpGWnQ1c0hJVzNGK3ArYlJtaVdPRHg2WTl1aXpr?=
 =?utf-8?B?a2g2SlhxV2NsdVhRbFp2MlB5MmlFM3pNbEc4Q05NT2xiNmdMRFo1eisxbDhU?=
 =?utf-8?B?WFRRS04zeEdCOEJoL2p5Ym9ZdjY4bm1jVFlxWW1PQkhneUdBTjJldWUzeit4?=
 =?utf-8?B?QmtyNXFSc3NvYzIwSTMvK3A1NjFsNGFUVC8zZVBPYlpnNURJRXdUb01HdlZN?=
 =?utf-8?B?NDBIN1lOYVFNMk9xMHN0QWxLQXd6MitWNkMyVFNPb0RmdkNKOGg1WlpHRGt4?=
 =?utf-8?B?eWlEZ1pzMWZUbXFkTUpMNWFMQmZTSFdGc241dlFHejlKdE01VlJWRVl6dWJw?=
 =?utf-8?B?NlMrbytqRVlhRGV5ZnRYRzBEUzZXaUFvNS9LWEZhNU9jV3J4dGsvVktyUVBj?=
 =?utf-8?B?L1RHYkRZVGc4MVJaZ25NSjZMUnZ6WVpCdmR0NGhSc29QY2pmMEZvc3BpbzRa?=
 =?utf-8?B?aUljTEVjUTJpRXNrL29hU3RYSm1vV1l5S1l6ekFlVTZPNVJrZGIxTkV5OU40?=
 =?utf-8?B?WCtGWWhZSkZXVkRwczhIZGhZSUloeXZULzlRTENKRVFlSC9HdHdmVDl4b1Nh?=
 =?utf-8?B?QjJOMUhHWmViOEUyUEljZkxnKzdDUjIzYzAzdU1HcGdSUktGd256dEROMWFW?=
 =?utf-8?B?b1psTG9HNU4vNnNDTHBWLy92K0Y5OGFTNkM0U0t0bkU0NmZRWDdoampqeTFa?=
 =?utf-8?B?RXlpZHMvdnZvcklYYTYxUkQ2eUxBN25hemlGVDVXN092dnQ2cGc4dk93ZFl4?=
 =?utf-8?B?VWlLeUxvU1EzMzRXY2xMdWRpb1NxcU1vaUpSU3VhVm51cG81NjVwdzUwOUY3?=
 =?utf-8?B?U0hHcFRCWXhGTS95d09kaWVTYzl6VDhqSSt5cHlzaHFEZzFIUDB4K1hRN0l0?=
 =?utf-8?B?TnAzZFJBWTBkRHNseWJ4TTVLc3NHbEtxbXNPeDhZenBqVHc1MGdMZVdpdHZY?=
 =?utf-8?B?UlVaUzU3Ums0cHJsd1V2c0Z2cGF2NWIwR1E0bU5rVFpsTHhWOWFiOWI5eGJs?=
 =?utf-8?B?Vld6NkNoZTUrSnlFRWplVXdQaUcvRFRSSUpOcGc4MTZFNHQ5bzNaeDBFRjN0?=
 =?utf-8?B?ZzkzZmJRZlR1aDQrUE9sN2I0NkZ0cEV4bnhtcTVYeFNZTGtnejJoYzg1eGZX?=
 =?utf-8?B?S3RGWXVUbXJ5NXJ3VjladzNlckFkWmN1TTNjdjRTWk5MTFdtcEllblJ5L3U1?=
 =?utf-8?B?UG9TQU4xWm84VXdnS3Mxb0xvMVRaeUROcWZEcEFoWGNpQTVLeWRQZ0JXY0tv?=
 =?utf-8?B?V1o4TDJjV1FRYkNjem4vdkc4Yk5jcm1nOUY2MVBPL01NNmVkaGJVRGhweUZ6?=
 =?utf-8?B?NmZQWGVpM2JzU2VZWk9BblcyWnJVZjVMOGtja2V1K3B2NFlzeC9mMzR2dFF6?=
 =?utf-8?B?MTNSdFE1SjhBM3pvZVBDL0ZtenhndEM0ZEQ1cVBEbS9PRnRiM1VPWHMvVEFE?=
 =?utf-8?B?RTZnV29uMTQzUGlSN2ROMm1oeURlZjlHZ2I0bHVPMzA0TUtLa3NHcmNob0Fw?=
 =?utf-8?B?OHRMNmwvM1VCQldMVmJXMWdLUnN2MHduSXhBbm5QanZYZEt3MitKS1FRQThM?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1a64b-c462-4b45-53f1-08dc340677ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 00:29:16.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9avDga3kSgvRvnC+9nC/pgNwmGJJfR73QhyiSwruhEydcYzvoCueX/hZTNo9Eerur3OwYnykfmMOFTjM4e3GG+cGYjFkwKPM0gTyNW4EGsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com

On 2/22/2024 2:36 PM, Jakub Kicinski wrote:
> Support per-queue statistics API in bnxt.
> 
> $ ethtool -S eth0
> NIC statistics:
>       [0]: rx_ucast_packets: 1418
>       [0]: rx_mcast_packets: 178
>       [0]: rx_bcast_packets: 0
>       [0]: rx_discards: 0
>       [0]: rx_errors: 0
>       [0]: rx_ucast_bytes: 1141815
>       [0]: rx_mcast_bytes: 16766
>       [0]: rx_bcast_bytes: 0
>       [0]: tx_ucast_packets: 1734
> ...
> 
> $ ./cli.py --spec netlink/specs/netdev.yaml \
>     --dump stats-get --json '{"projection": 1}'
> [{'ifindex': 2,
>    'queue-id': 0,
>    'queue-type': 'rx',
>    'rx-alloc-fail': 0,
>    'rx-bytes': 1164931,
>    'rx-packets': 1641},
> ...
>   {'ifindex': 2,
>    'queue-id': 0,
>    'queue-type': 'tx',
>    'tx-bytes': 631494,
>    'tx-packets': 1771},
> ...
> 
> Reset the per queue counters:
> $ ethtool -L eth0 combined 4
> 
> Inspect again:
> 

So, with projection: 0, the counters would remain unchanged after 
reconfiguration ?

> $ ./cli.py --spec netlink/specs/netdev.yaml \
>     --dump stats-get --json '{"projection": 1}'
> [{'ifindex': 2,
>    'queue-id': 0,
>    'queue-type': 'rx',
>    'rx-alloc-fail': 0,
>    'rx-bytes': 32397,
>    'rx-packets': 145},
> ...
>   {'ifindex': 2,
>    'queue-id': 0,
>    'queue-type': 'tx',
>    'tx-bytes': 37481,
>    'tx-packets': 196},
> ...
> 
> $ ethtool -S eth0 | head
> NIC statistics:
>       [0]: rx_ucast_packets: 174
>       [0]: rx_mcast_packets: 3
>       [0]: rx_bcast_packets: 0
>       [0]: rx_discards: 0
>       [0]: rx_errors: 0
>       [0]: rx_ucast_bytes: 37151
>       [0]: rx_mcast_bytes: 267
>       [0]: rx_bcast_bytes: 0
>       [0]: tx_ucast_packets: 267
> ...
> 
> Totals are still correct:
> 
> $ ./cli.py --spec netlink/specs/netdev.yaml --dump stats-get
> [{'ifindex': 2,
>    'rx-alloc-fail': 0,
>    'rx-bytes': 281949995,
>    'rx-packets': 216524,
>    'tx-bytes': 52694905,
>    'tx-packets': 75546}]
> $ ip -s link show dev eth0
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>      link/ether 14:23:f2:61:05:40 brd ff:ff:ff:ff:ff:ff
>      RX:  bytes packets errors dropped  missed   mcast
>       282519546  218100      0       0       0     516
>      TX:  bytes packets errors dropped carrier collsns
>        53323054   77674      0       0       0       0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 +++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 6f415425dc14..3ee8e3b827e3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14432,6 +14432,68 @@ static const struct net_device_ops bnxt_netdev_ops = {
>   	.ndo_bridge_setlink	= bnxt_bridge_setlink,
>   };
>   
> +static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +	struct bnxt_cp_ring_info *cpr;
> +	u64 *sw;
> +
> +	cpr = &bp->bnapi[i]->cp_ring;
> +	sw = cpr->stats.sw_stats;
> +
> +	stats->packets = 0;
> +	stats->packets += BNXT_GET_RING_STATS64(sw, rx_ucast_pkts);
> +	stats->packets += BNXT_GET_RING_STATS64(sw, rx_mcast_pkts);
> +	stats->packets += BNXT_GET_RING_STATS64(sw, rx_bcast_pkts);
> +
> +	stats->bytes = 0;
> +	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_ucast_bytes);
> +	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_mcast_bytes);
> +	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
> +
> +	stats->alloc_fail = cpr->sw_stats.rx.rx_oom_discards;
> +}
> +
> +static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_tx *stats)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +	u64 *sw;
> +
> +	sw = bp->bnapi[i]->cp_ring.stats.sw_stats;
> +
> +	stats->packets = 0;
> +	stats->packets += BNXT_GET_RING_STATS64(sw, tx_ucast_pkts);
> +	stats->packets += BNXT_GET_RING_STATS64(sw, tx_mcast_pkts);
> +	stats->packets += BNXT_GET_RING_STATS64(sw, tx_bcast_pkts);
> +
> +	stats->bytes = 0;
> +	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_ucast_bytes);
> +	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_mcast_bytes);
> +	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_bcast_bytes);
> +}
> +
> +static void bnxt_get_base_stats(struct net_device *dev,
> +				struct netdev_queue_stats_rx *rx,
> +				struct netdev_queue_stats_tx *tx)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +
> +	rx->packets = bp->net_stats_prev.rx_packets;
> +	rx->bytes = bp->net_stats_prev.rx_bytes;
> +	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
> +
> +	tx->packets = bp->net_stats_prev.tx_packets;
> +	tx->bytes = bp->net_stats_prev.tx_bytes;
> +}
> +
> +static const struct netdev_stat_ops bnxt_stat_ops = {
> +	.get_queue_stats_rx	= bnxt_get_queue_stats_rx,
> +	.get_queue_stats_tx	= bnxt_get_queue_stats_tx,
> +	.get_base_stats		= bnxt_get_base_stats,
> +};
> +
>   static void bnxt_remove_one(struct pci_dev *pdev)
>   {
>   	struct net_device *dev = pci_get_drvdata(pdev);
> @@ -14879,6 +14941,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto init_err_free;
>   
>   	dev->netdev_ops = &bnxt_netdev_ops;
> +	dev->stat_ops = &bnxt_stat_ops;
>   	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>   	dev->ethtool_ops = &bnxt_ethtool_ops;
>   	pci_set_drvdata(pdev, dev);

