Return-Path: <netdev+bounces-116984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588FA94C42F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B18B1C22763
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF313DDD9;
	Thu,  8 Aug 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaLfQ5Sc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44B5579F
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141240; cv=fail; b=KDe2vNYYzmuApuj3EU6doPdqRlNbIHJze2Q9H4IFZVrVZigXH6xNnPPVCQ5cmRf61ztkCapPQ8hDD8Ey3hTP7Mo28mEoe99gD34uqUgWVaUy4x5XqzcRC+nD+PDLcI98aXyKwpKNEf1GztRF+DKykof43Di/kV4uUbGM/wfT/FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141240; c=relaxed/simple;
	bh=r9jmXqZ//gvDZc6UVLnIC1YhPD9GES3UORGis/k3xHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccofPcuvML2S6OJLF+0hz8bsYH6N4HGKN+Drj4RhBlFCO+J52QqP1Fk+Q2V8W24FgsD3E2pPcJBdSxpo9FZVRTf/c+YrmAZqa5yxnTsWUibRrq0c9GUx37LwawgllxHOxBw/UvGKhAjo4UXBImw4L1fl5D9NxwURZIemkAIXfKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaLfQ5Sc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723141238; x=1754677238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r9jmXqZ//gvDZc6UVLnIC1YhPD9GES3UORGis/k3xHM=;
  b=QaLfQ5ScNYUUKYhz/wWVEG6bWwrZbrwaIWuyPAGIL8WBtJkcsXxx8thi
   3nyGHKafrDx5yD7+KbFt686WT+gYT4b9GJLNa4jPU15zu9wJSI+EnMGtv
   aCv6Ozxgn6NAPWT8N97OKf0xwI8AaoWeKM/gPi0eZXsEnmxDFbkN1QHRQ
   HsFsgD6uNo3sZL38Ob0xGDlkzAXVNn2GOSzyLQustHxCeVYHCHU4+k0o7
   QyvNrD7ouTsY55+2WLoOhSyYTiUpozsWcHvm/xnMCdnGmPPi0XCy3zVkm
   ejOEwdijr4GicdYEaEOL5AERYartxadNaYRLFc1bgfYYxYVngZVupL++Y
   g==;
X-CSE-ConnectionGUID: IskYfwP2TQORt7SAgrL7Uw==
X-CSE-MsgGUID: Wj4qolEuQNq0/ug1gbdADA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31962127"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="31962127"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:20:37 -0700
X-CSE-ConnectionGUID: 0nzBrcZsTjyCDpdIGtMPVg==
X-CSE-MsgGUID: iPVk8CMlQ+2N/SUvIomwSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="56972418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 11:20:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 11:20:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 11:20:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 11:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlFbX1m7n1np3M45Atq3WvkyNCFINeU2qPr4C3JODlgcoaWq8+QZla2a32Q7Qatg3mPJAbH6hLnKSKRpEvM+UTxNLmqQgCZ1kUDxQB45FI4iaY7g4iE2bRKEv8F60dXgLUH32CSkF+jgHDZ9SXYEWVwEbYj7W/ObhL/bH7JC6evbU9SlhG35CJ747YX3GmVnBLG1AcABmSi42VRcxr54jO5dKH+gP+J7o2cxWDazNLhZ2v8FUiUjpCVG0IrlRunVdfNKYEVCXsrArd2H5ldDi8dHwkYfn88VTzH0ZXj29u1QLTyNrrHJG1/niLmn9R3i2Vzbd90TWOCP6VRDmXAhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m8MOI1sUhJ5p1vCJV4FEq/VF3/3DZhbaxvo4fLOna0=;
 b=XJa+TOJlnLqMsInYb/QEaE6HwOWeBxaujJhhSh8u3iP+OtSE5hquVlJG8XyBheGhkTjnZ6ZNPsoem7QWRm9ojwgL3VXOu5wN2PtnlYOl7Vactd8sOtDnr0skIwytEJjvUFWCMdrg7Q40QOzjoj5fz8UBjwYAqkGOTUcOcOq6r1I7E0lkuHuReO5pibFyqgT1Dc5FlgnYkcVafTZNzzZxw2Ube03/UQ1Ped5a9CNjcXWg0WkS9eXicyTFjm13ha+hzORaDkWB3Rz67lkNNjsBXCVNlXcieJVcTxDx346oINbt0BLiWOtZPLnmXWSxp9nK2SzbMnRJV9pF6oMz1BQBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.28; Thu, 8 Aug 2024 18:20:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:20:30 +0000
Date: Thu, 8 Aug 2024 20:20:23 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Jan Tluka
	<jtluka@redhat.com>, Jirka Hladky <jhladky@redhat.com>, Sabrina Dubroca
	<sd@queasysnail.net>, Corinna Vinschen <vinschen@redhat.com>, "Pucha
 Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <ZrUMZy/oxdu7m6F5@boxer>
References: <20240806221533.3360049-1-anthony.l.nguyen@intel.com>
 <ZrOcMAhE2RAWL8HB@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZrOcMAhE2RAWL8HB@boxer>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 622ed6ca-d276-4d81-2b03-08dcb7d6c8c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j13f3eLva7KOWgwPXgTZ0OeEq7gjy42GwoJGd4rIyYbGEc4Ca7MqnB2S1y6I?=
 =?us-ascii?Q?M/FSPMnlqTqiFQUKqvo5yYjAAiRNhPtMxlid4IRux/wKgnVQggTSQD0EqrBe?=
 =?us-ascii?Q?woPE8xEblhT0sX0txytGQSe4RC7bB3M8UT1CdiOCbkodmH2q8qIPLEB3H0F0?=
 =?us-ascii?Q?OW2qsxiEezns+fVXp/nKwHPvTgAFM+wRA5Sj9n1SsE5J8qeTjtbpjzLDU4S4?=
 =?us-ascii?Q?1CFYJuhlx6ODNZpnpxG2Em5b+6nv4zCeNBokciDYNMVukyMcF5xOU5cxGUY0?=
 =?us-ascii?Q?QPjciYXTo2Kv6ZmMi4ticSj9CG8uC/5tYhENyhc2QqTeubKHod4mrYESwytk?=
 =?us-ascii?Q?Ll1Rw5eQa9gFz9aweUeQp7GumfIGn48Z7W9xAL5XmkLGVK4v0ad29WGgH1zI?=
 =?us-ascii?Q?VNYvGVCvrE43peZwHS9aIjKgbsVCGMEQAuFy27QAB/XM6G9Mk2EUtVbZqYUO?=
 =?us-ascii?Q?6Da4bfMwC3hjPVl3y7frFNNp9oSlJunwurHCjEycUUqTZVa0oHKNSLPU+2uG?=
 =?us-ascii?Q?+Lt4rjG1ASoedAdQk13NEE92au2e3lSc/mVxronvi8PDsLDrCIlar9fOidhY?=
 =?us-ascii?Q?KP/BtTEf79Kd6lEToA48T/GEmLcrvXRO9a2FB53aF54XnmNm/ZqK5N/0wJpE?=
 =?us-ascii?Q?iUjC18ZQs2PzsMj0EymhYJkrY5QKSWQiaD0lluqYRcg1TvJ6yCaARQ63J7WE?=
 =?us-ascii?Q?nNUEQj+BZO5YiVkQPq92B0MFyijH7Cy5635kAPOcQQBhkt6KPZyOReBVXul4?=
 =?us-ascii?Q?XVnPeIfsbzGA+H/Rh8AdJpf0YvBsgFrZF14SII/ilVFivKvbiTXcEXub/Qti?=
 =?us-ascii?Q?9LdSZOxc4FWO1DURwtJvsceLSuzUB4Ch1xrvLpX1/Z//sZ01fR88VxxA0PFf?=
 =?us-ascii?Q?65sb0pP/N+vRZcUxA2VwHJb1tC00wxgvtcXefCNcinCoD/vATKkVgycp5HGZ?=
 =?us-ascii?Q?pubcK1OEG8d/rDToMLe6z5xobNkSYaraP+UoVtmHHYH+ajHe6pQa6QxcVDj7?=
 =?us-ascii?Q?g2s6xBedhSHF5C/rpf/7E+YaMYDcbZiLJrnEIPtPKgQ19rruonSGOttfC9p2?=
 =?us-ascii?Q?+57UeZXxWw5raLufTvxTj4XyI9Whc4lICwWZZPt15T/CbfH2ebO2t5oKVYf8?=
 =?us-ascii?Q?Jp26GeeR0kIDMuVk/UCGDm/3ouG++HfbFp63tts8veAqFS2y9fkhBoftgwQq?=
 =?us-ascii?Q?N+o/8E8WQhehcoV/pUT19swmsXaKbPgfhwyF6hPO7YoZb9gU0NbP52fTIVYo?=
 =?us-ascii?Q?d8PB7A6nCu9FUbonhghA/0EPLH+iGp+2fmO51mtzRT2pF77K9WPNqhO3FMEm?=
 =?us-ascii?Q?ptc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zpHTrqc35wq+fwKpGLapTPq3IEZUxeb2p474tI/gdWXPthW0xogXTy7q+1Ce?=
 =?us-ascii?Q?HK+5cExFppgQUyYZ59aWMIR/K8myrnQ5aCTrAH93qgsLBuPU45sCGCYRRixJ?=
 =?us-ascii?Q?K4NUCVcL7cwT1MIO1s6Pvte2qVugNsccGg+NhmW7dhH0qjg5WmGEqtPDBehi?=
 =?us-ascii?Q?PfaRah/9dlugYswThgVB+CJCd8EPOZTG1Zg8TEMuu6cPK6TQFT79Q8S5V8e2?=
 =?us-ascii?Q?pIIQgMq6qZL/hqPE4so5AkDXoh/bhpwS9GjrM7VIpMkJS+fGXgTNW9kKMd34?=
 =?us-ascii?Q?j0+83Gs908KXxUZV8fgRTH82ydwbjJmvLt85O6/xfzMhJzFipttmP47Fc5YS?=
 =?us-ascii?Q?f/T5BNp1HcrbUBeyTPjuziFYyDeptqC0Z2UbbLLH32EgiOr8OqFWnvKYVUef?=
 =?us-ascii?Q?qQU+ebx1Z7CnmXX86lGIPZ9ZSoYriwwdtznCZ39wWC1cQ412nvZLJGIajJqF?=
 =?us-ascii?Q?dMa7lg6DEA10RYiTuGVbh17WXsvtpIooVxVXAJUGBHDPQIQomTEgnY24mP+p?=
 =?us-ascii?Q?3hYoUsQ3Praw/yf/0EsLZZTVcr0/xKa8Hla9MkJUI6Jb1rL6X/590JAlRhKk?=
 =?us-ascii?Q?F51nMQflpS+yW40lSkwXAoaPHe6fofN7xk8HWkjn+guM2V3+xp2xAmqVxz3Z?=
 =?us-ascii?Q?Vfok3Wp4vdFA+odmIjYXtDvevcSoZGoOgkpfn2JoI4JRoPZg865kHD7/uzyR?=
 =?us-ascii?Q?tjtwqcv5UdmkzCMrfe5Fhjurx9FTEYTzHNRCbFqgo9L3BNZl8hU+TYv7uOHO?=
 =?us-ascii?Q?rhk2qkLts65O1xbP1mY/IFHqr1FnEPnOd/hQv54AQ+liAdazCkmPo5zk+4UR?=
 =?us-ascii?Q?8HBCVqhGn7RtcJiq+2Og9HtvRPO6jWgnIeOUdzLRmdZXFtOwFDplOZvjLxqq?=
 =?us-ascii?Q?0hPyQflVq7PPoEVnqRxyfPeHgm2u46zSUT+ENbRjVWKbDJydgbMJ9Y1WyINc?=
 =?us-ascii?Q?q/KIROPZtjDu1wsFl4Yu5+2Ej7/q0WHLPr7iTL2d9XQw6FryFrjN0mQ/MEvg?=
 =?us-ascii?Q?j54AE3JK0DU4o5O9ihDmbIay02DY7wiJ2odx2Y7XMlYAIsDjDWUTdl3PSF4S?=
 =?us-ascii?Q?SDh14agHdkoBJ0ez8xHKeLBcUPPORoRbEL44x+8LyGI1nRzqXGiqApP2uUfB?=
 =?us-ascii?Q?j3+NybvVnnClS7ZPD8nlqPM56s8o29lkupmoxMV6L7cgYZ1tGnzWiQqZuPin?=
 =?us-ascii?Q?d+8wEins9id2ef4aKCCjSFrbqfiZSKdVKC91K545xSit8wiCoOJv02g+dayD?=
 =?us-ascii?Q?i/0ac3Sp9fDfoVw6qogbcr+mBQUb36RLre2aI86cie4Cw45BrDV3m9CIYs8d?=
 =?us-ascii?Q?W0nEj8gBpg2rDVVt0Bv7zwlccJEFcshAl4YXWYLRT7yWOrBf8dy8silkzYaO?=
 =?us-ascii?Q?ouVwdPuSXTLLD7gKyoA1/h5i4YYEhGLCWmZDMFwR6igDAEtCTQLcFmfoKINS?=
 =?us-ascii?Q?adAyTgkNoJ/Eefx7d2ZU9shYOFwJdoFuPi9uTbqs4lEoNfnk8gb6IVdihWl9?=
 =?us-ascii?Q?i/AErfO9Z7894YaodpyqgUcjizgAijwvzwXwLXmP1snncESnWXoHHW8NFUaM?=
 =?us-ascii?Q?TA2qpjo6CXgStIZ/9eaZ6x3l0WZTOIZP1XUVnH4hmn5iR1ucJkUMRKY8bLCT?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 622ed6ca-d276-4d81-2b03-08dcb7d6c8c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:20:30.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByKuMoFVVxFXAONSKv3hVaoWl86xlo5Ucrp5roEP31kSNmVu/QqSW71gDH09iIyBryHchy/mfm5NLQJnOtF+02f3idEFma32BCu3eQ9316o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com

On Wed, Aug 07, 2024 at 06:09:20PM +0200, Maciej Fijalkowski wrote:
> On Tue, Aug 06, 2024 at 03:15:31PM -0700, Tony Nguyen wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > 
> > Sabrina reports that the igb driver does not cope well with large
> > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > corruption on TX.
> > 
> > An easy reproducer is to run ssh to connect to the machine.  With
> > MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> 
> any splat?
> 
> > 
> > The root cause of the issue is that the driver does not take into
> > account properly the (possibly large) shared info size when selecting
> > the ring layout, and will try to fit two packets inside the same 4K
> > page even when the 1st fraglist will trump over the 2nd head.
> > 
> > Address the issue forcing the driver to fit a single packet per page,
> > leaving there enough room to store the (currently) largest possible
> > skb_shared_info.
> > 
> > Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> > Reported-by: Jan Tluka <jtluka@redhat.com>
> > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> Where was this reported?
> 
> > Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> > Tested-by: Corinna Vinschen <vinschen@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> > iwl-net: https://lore.kernel.org/intel-wired-lan/20240718085633.1285322-1-vinschen@redhat.com/
> > 
> >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 11be39f435f3..232d6cb836a9 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -4808,6 +4808,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> >  
> >  #if (PAGE_SIZE < 8192)
> >  	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > +	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> 
> We should address IGB_2K_TOO_SMALL_WITH_PADDING for this case. I'll think
> about it tomorrow.

Actually from what I currently understand IGB_2K_TOO_SMALL_WITH_PADDING
will give us 'true' for case you are addressing so we could reuse it here?

> 
> >  	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
> >  		set_ring_uses_large_buffer(rx_ring);
> >  #endif
> > -- 
> > 2.42.0
> > 
> > 

