Return-Path: <netdev+bounces-71852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D77855582
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7A1C26602
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F91420DF;
	Wed, 14 Feb 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6FJbptF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72B1420D1
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948287; cv=fail; b=ijVcMyvw2iTXPQqf/zETL15l2y0wWaRDNQN1cWXHmTXpPL2oJVhl9Bcpypu8OrXlrT++VK3orWBdR3/tVO2DXMVwwP955+jTBHeCeC44xK2f5JLfpfVOTaweUwPzBmyBYkdef56lcRvihA9tqozaoiO6TXXFPQyuf444v1fEpCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948287; c=relaxed/simple;
	bh=FVmkBQyDcWwgn7PPOCMdH2BeJpUvpC04k1W7VzlVMms=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhxiaHMlESlwNppyChPNZU8Ne9XJNiAavxdGd7J2+T6FYuKzrIl4DGhmfR/bNwZUlfr/VS3x1VYWghW4M2UBSWSnSpCuMFHLDm/C50GlHqoPo+fM2GnjUo87G2gDA+k/t/Qen+cVlfUwscDgsf2GJhvEqLzur6xwbxFT26d5Rpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6FJbptF; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948286; x=1739484286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVmkBQyDcWwgn7PPOCMdH2BeJpUvpC04k1W7VzlVMms=;
  b=a6FJbptFnNRUD9sDGRRDgrx5bp9WKt9hlAMZpegKghIxub094wRmmaeT
   WqaPIMrYYIv6nsHCg0Ll7K5pu7ivN45krNRaqUlh6kB2qXYX5uTwxO4nY
   QV6KjD7QRXAZLuLjkzj4HKK4X4ECq0A2DZMAT7GAZoRCnP7mukW+zLxtq
   uu/4CzguJ4VGs42GJz744c0ML9sQk1VjM6+lCtP0s6QEf87jA7pyr0Ymy
   IV1LhtAZRoJUQPC5eE/37a8b+Hx1Qnm5kLkX5Oh70HYl78oN5IKDqu+ZR
   8ef+elAgHc3yNqYsxJv9RX2+3zcV0cnjaVSYixpjdGWkkLJ0FbI7KGSN5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19534340"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19534340"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3700697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:04:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:04:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:04:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:04:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/W93FJeDcwJ9f81Xi6wU6tA6tuNfnfDNkkhSmG2VovYydTSHTvJAbnc1qBUKFfG+cxyI/BEOSbNgYpXRbYsQMnd2RLny7iGyzb8gRKSeCFNsFmatqUtKbmhSQqeaTtTZf1ligvEUjILYewUusduiQOmq/wZwxJTEnzhQu+w8OYDY229Xx0wt/8zB/S8nl9iFQIWzPn5Y4iubIX8QIPtcYNvzOO/mZ7gy1zQ1uS4EFkLxDqwh8qfrxhT/X7kVBrFs6iKGC3q87ehzoftZukzMf+QOr1EOyVNZJrT3hF5s3/U7MtZ7cPopW/0EH+eX+PpqMaCy3rLyUFu219dcTgP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuJJ68ZHS+atge6bsQ0/96Ho8N64q0RWtBVDreCuOYM=;
 b=cfQO3y1O3/bbTTPh2kYFKzRT88qHSblsDaFrPuyl/R0xpZpi0la7r6Ui3F9HmRoT7CRqI03pPILCSFBDECtDN5rNlh7arGkYxwk599y2tQqhx4n9YXJlroLDMQF8CJCrlxs+V8r3giuUIN7RbVQTwp/oquBv2NnFFEoh6tpgiRM0IlONO3hGiz9QsuEu1m+LSw9s1wppQ1yWv0MbkgdZBGLhcq/5G0Hz0qZHI6x8p2d0mR+iS9VXWSMf3PL+fmlPTxrE+4zdHFIJadaPmZIX/1h3KLrzUFc2cgN1aXR6XYZsi2F0xyK4AhIfJ7Hy/1bzlKBLITWIeP1FaWGxe7yFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Wed, 14 Feb
 2024 22:04:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:04:42 +0000
Message-ID: <42c18bac-9930-4c40-bb7b-b4b26419267b@intel.com>
Date: Wed, 14 Feb 2024 14:04:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 6/9] ionic: Add XDP_TX support
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-7-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-7-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c80f42c-7053-4fd0-7e39-08dc2da8f22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPfKwzUU0YFh9uDiXg+sP/EQQFJQgvBhETzXgCVxBajaJZmBq3BHxw60T1kqV4WyrIG4bhbeuu6k1ZV8BvRfLTU7UjpCH1c2LfHFSzlNAdDtQ55XmfCkaz/0708dEaIpGa2JBbIEoMVEPPU0OVrvTEeMofWCTvqjJOCtlfV5kUVDVzR4eizG7CI/AMrpNb0c71OaBTwI7LSU01HuEP4pxhzHx8BtiCG1HXUP0bbgM+AFLl6zUx1+YPebAJpvVheOtTsdap3aEt8i6js4x7XVtWMk9uA525IIiRXs8IqEHKipig8oILVT/BFkm6p5FvPCwpmPSF/262Jly7WUAo0xjxqsk4KsLDKA4tE5svgr6qbR1JHYo4Mq/nogYxl4PsyWMSUSyg10sOAbo3VDNPg33WEzHQGDzNjSVjfDWoHLpcdurqD1j6xmniNPpHMw/a7MybGsNGgjAH2oARCsfbEjzMOT6/UaqP/bW/DiSMrs8Gucc49dqr9m8GLfxez/tFkGAkBjr8AmpO1R55TYYIPIbKQrrDyoFQ46A4fCBkzLddzNcMfZzquBzYkzmBqJuvTB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(31686004)(41300700001)(2906002)(478600001)(31696002)(4744005)(66556008)(4326008)(66476007)(66946007)(6486002)(8936002)(8676002)(38100700002)(82960400001)(86362001)(316002)(2616005)(26005)(5660300002)(53546011)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlM3aDJpNXFxMGF3NDBpZW93UVg3OUpkNnhwRDk5SVVmWTRwTVUwQ2hIQWlX?=
 =?utf-8?B?Y3hpcTlMZElNODBLdWhlY3lCT2ZXMkxvQ3p3WTFjZjhvSGorcWN1bnc1UEtN?=
 =?utf-8?B?ZFR3d1MyQjdhYms0TExlQVZKanZ3WG42dDNOZEZFdGUzUXR3bTJnRXdDVE41?=
 =?utf-8?B?OCsrUGtYUkovdll5aTYzaGZuR25IZ0VTbjNTWmNhTXE3TVB4TXpTTk80Wmhh?=
 =?utf-8?B?MHlUQkRFQis5dXJubGFwQXVsdlRyL2VLS3JkMlZNSHJUSG9jVWhIcWxCSDlF?=
 =?utf-8?B?REtiaFJqS3dCaXU2bWlxVE5USFFRRWFVNzFEZGlNZm9mYlRVYXArVEZSVURQ?=
 =?utf-8?B?L1lwUHVZVC9lbG92d3hhUWdTUFlRcFJjWU9WMmRpSEtna3hFUS9zUXBnSzEv?=
 =?utf-8?B?b0Z1M2ZONDl2WkNwMHE4NDJwQzFXdmFBMXVMOGJKd1hyMlNuWW1yNlRTREU3?=
 =?utf-8?B?SUNiaHoySGJ0emRGT0lrRTloZ1E3TDV6VkZEaHc2TVRHZkdlbXdVZDNWNTJE?=
 =?utf-8?B?MENqVDFUMWZnU3publNWSEp3RU9rOWU3eXpBalhCamNIWndEbDZTb0twaG85?=
 =?utf-8?B?WldpTG5yWlQyd0xyaXRmTk1oNUplQ2FSZDFmampNbFBuQVFQdVhqNENhcnBW?=
 =?utf-8?B?ajlxOFFwOHl2WUpMWW1jSW9hMVlXbE05VWg1bDlNV2FaQjJCeStHcXZ0YlM5?=
 =?utf-8?B?RGZSQnR6ZWZ4bmNEcHdMWjhwbWw3MUFLaURjYnlMa3kyVHZDNUsvT05IaVdE?=
 =?utf-8?B?ZTJqNDBGMWxRYTlQOXVjeStoSU5WU21jWkZhSVhpVGh0aC9DdmdPU3JCYk9v?=
 =?utf-8?B?QnF4ajk5MzAxTzVScmNtYitUK1kxL3VVZ3BVd3FJeXhwNEgvUEhaZllvUVg5?=
 =?utf-8?B?NEVyazdkOFdYdmdLV25yQVloQzhkcDhCTnB1Z1hyMldObzdMRzNTUENjTUlJ?=
 =?utf-8?B?VU50MUorNHRQUDE4WFJMdHV6RkxLZDVKbTdtMzBFRHI5bGVUTEdXbUhXZjYz?=
 =?utf-8?B?VDh3K0FzUWR6TGQwY29KL0ZtU0lHRFBRdHFXc3Fwd2pxM2N2Q0RFVTN0b1Yr?=
 =?utf-8?B?SGJVQ1VYWUZsTWhRdDR0N3pBRDV4UlIycHQ1U0pVWmE5N0RqS2c3WUVwcEJs?=
 =?utf-8?B?amZOa1BJamJKWW1VMDZIQnZ5TDNKSUhETnJGazZPZjZUWDZ0ekVkVk9nQTBs?=
 =?utf-8?B?c2FxcUo3dkdWWGVNRWZqTnpzblNxK2pJU1lPSWhDQkpoaFZGNGdrSC93aG5M?=
 =?utf-8?B?M0d3bWxieHJjVUpvcnhzbzRQNWhDL3NicVBTRE1mQlg2ZkN3UkppTWJvcmo3?=
 =?utf-8?B?OEdaV1NXMTJQTHd2a2E5S0I1aktvc2Z1V0JzYVhBZjVseXR3cVhmNWhOZUVJ?=
 =?utf-8?B?NitPbWRpdndxcUs0bXNDWnFZOWQwZ01NRkp1RzJhaE9Lc1ZHdytqNGVhd1Fy?=
 =?utf-8?B?UVpNWlRKUlZ1Tm0raWVSYzI1eGN0b0dhSHFxQ0MrVzB0M05FZ252b0gxUHVS?=
 =?utf-8?B?MU9mRk1rcXJ3ME9sUTRTbkhEeVlDSWlPODFIRkFjSW9qS2xTQlVVSlpFUHJk?=
 =?utf-8?B?M2FRTEZPci92cTFCOVAwaWM5QjNKSDJ4YmU1bi9UL3o1eC81MTFGUnBGOHlQ?=
 =?utf-8?B?Q1pMQUNiRmNwcE9mSWRuS2hXMDhmQWx2a1BDcTMwZUY3UVFaTFhGd2xGVFVP?=
 =?utf-8?B?ZUtMak43ZEdpemk0L3c1a2pnWUdJVzJzMXltTzBZNThScW9nOXBFajJldXZq?=
 =?utf-8?B?eXJKcm54bTJ5Y3dicURxL2pDcm9ETncyUmFlRHJlcFhZZDZVaEc1eTl4SWtE?=
 =?utf-8?B?TUNEbk5UZHFKTU9Cdy9qVkdDYWR3eHk1d2g4ZW96cFlyTS9YUEFoZlRLczF2?=
 =?utf-8?B?c0gyZ2thMzJ3VmFPTXpTOUlaUy9UVDFqbGp6WUR0bmVTaFMrR0g2Z29EeFNC?=
 =?utf-8?B?REthRDlBMTFURnpaSEkyV25ueGN2L3dTUW84bG84d0JlY0NlU2hyaGF3bG9s?=
 =?utf-8?B?eWI1ZjNDcDZZQkFCSHRmUURONTdBdGhqdndUdkNia1g1N1RZc0hib08vcTNE?=
 =?utf-8?B?S2pyVW5WSk1Tb0R5R2R0c1Q0YlJPN0YzQTRJOVZvL1Z6QVBYNmFpMjIzcGxH?=
 =?utf-8?B?OXdWN2x2UUJySldRZUlISUFkd01SNDZDUHdLdlpGOFgzelFER1FrVnltUm9h?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c80f42c-7053-4fd0-7e39-08dc2da8f22b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:04:42.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIGlzkST75myTFepaMLne2djMwKXl1uYafi8xKoXQBR51yW0jC+8bNd0Ga+1moarVDhOs61hWLoJ6W8t/WBrRmyxt7BNwn5Xbe5WmWBfgQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> The XDP_TX packets get fed back into the Rx queue's partnered
> Tx queue as an xdp_frame.
> 
> Co-developed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

