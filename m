Return-Path: <netdev+bounces-98491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FA8D198C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D331C22340
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287EC16D33C;
	Tue, 28 May 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBBbSQs3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98D16C872
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895933; cv=fail; b=pJ1FWPcrLtBSx/OuV8sIrtuuLMc4EnzJUxLHiW5acggqegCHFK5h9FuitJxtgJnkb6C0A2PmfXVLF0wAzqTHXvIggs7t7yi7DW4GX2S6tfl+wjMzpFU0oPt+bNk9qvXeWzVsLTKpi8OIDHaK1zHedzad18wIRHfnYp0qiAvnhI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895933; c=relaxed/simple;
	bh=87IWg7TgVZQlyrBSr/IpVtcrJSla1RduCS/h0ysiXd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G+nMg6n2UoJEX4mS22GXlDBaKD5gFUT9v5K81QIjWdSXBkB7Iuob+vbYHa5Og1+bpjX52Ze/B6Q0IWSb2YRSmqFWnsgc+1rFxpdZ1PzlnnhwBJmYN2JcUP+zw048Wl8//1AJh68+On4t9XVlPpsdHwIfSJhxlNv8UVYs1Ceqwqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBBbSQs3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716895931; x=1748431931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=87IWg7TgVZQlyrBSr/IpVtcrJSla1RduCS/h0ysiXd4=;
  b=XBBbSQs3riK5wGc8uC/zwauFswDCmZoLcMSIi+ppRjMPRg8LdatP5dSF
   9ec8omQpBIiTdRfLIHy2/buOPUAfvccv4TU6zH4cdew1WWlYLpdtTMHLX
   0fLoj0xoD4LcZdQF5oWA+5UGSQVbgxiDxQscaGi7qqMwm2C1WSJapKq7c
   CUxyt16JBqVifzTB/J3o0nOr8hOMyi26cldj04EzEs7W5gVCVsFXg4of/
   WUlDrfU+Reodc19JWKSQB2drMAar9GTiwnTcjWnLfrW6XIKy/QGzSY3xg
   55+DOvRX1o1qfnEpY1ZV03//q4aoV+HbNH3x10EfxzmUNcRQ7QRKuv8iv
   w==;
X-CSE-ConnectionGUID: MaITH3G6QYSfvzG/dT3U2g==
X-CSE-MsgGUID: WQfrWbJLRl24CysCwenYqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13082287"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13082287"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:32:10 -0700
X-CSE-ConnectionGUID: 8Fmy+O/6QLClDcBkhO0GrA==
X-CSE-MsgGUID: Tf2fyxxDSEqGwVRTwuhttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="72470685"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 04:32:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 04:32:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 04:32:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 04:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEQ1iY7B50M8WgDeihyWft2z6CMVOg3/dZNtYxKOzpiJLfNwptUaWorTkWfsDew5APTYpIh9IoNHY2DfhYJ+1kWK6WHAd4QLiWuk1InHeQIODmf++FPPqSHZeFQG1OkXGxp9PGkbN/+79GXLSqDsp+SkDukIqmUOQcykfjwnpo3to0M5OCyb256Li39palVe+mhlNYGZxD/5wityeTkXYDCcWPrASVGR2cjIzXP5ohwuLf8EQST9oRdzod8Zf5OsJ/9TTUgqGGHzXWIaQK9uuXDKPSNBJ4Fx2pG49vYSyM/l9iXk8LVQxUPE66FMJJYv6g8rle73xqXdillwpK50Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np2Q27iBuA+kUR8XglVK5bc1J0Q7OVoRk0Vem2I58qE=;
 b=dXoXuBHVd64gN1MHAP79ZDAoUWug5CzylH7AqvqWhuBnGLkPznlwfhz59Jkgq0ooRKqAa29M6m7QtrlKBCdhu1oLiwH32FiUNxNoHNiKhd9Gkf9Lv99LvOL6agRqT9HYSgPG9YcwaRWvBBksix/qy37+cYHjTvwA7C+4NqxMEALkhRbqLALy2LzqPQxzLLMDvcRxIpeDp4BKQzgfTDvpkIgxAa4SS2Pv5WZIa9q72UHOl0EJE/6LPRnnSCghxqIw/EKlUSkhsEyCUzsMGb4m5VPxPqemCDee7rHfufxCh4Bf3bBVyvMCCVfYR+e0EUjlhu0kqPHtd48IhTiL/bCffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.20; Tue, 28 May 2024 11:32:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 11:32:07 +0000
Date: Tue, 28 May 2024 13:32:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Michal Kubiak <michal.kubiak@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Wojciech
 Drewek" <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <ZlXAsws/K6KDWjVB@boxer>
References: <20240516164108.1482192-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516164108.1482192-1-michal.kubiak@intel.com>
X-ClientProxiedBy: WA1P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fe89f8-9dd9-4dd8-0446-08dc7f09ce71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O53mfXSOUtfJDf5f3cBisrOWfeCKNIdpKDT4rPJ16CGUQC5BagFP4GBJJoGz?=
 =?us-ascii?Q?UG/gDfDjJPCnjwhLTLMllC/3/Z4AeYKRljJwxq5UtzTHXNiWP/6TDqtFctS5?=
 =?us-ascii?Q?HKMTHXluZszhdu/PZbGrJ/cURfakLaMmlCfm8PJ3mP2qslxZ7lwHH/fGFKGL?=
 =?us-ascii?Q?lI7caetM2fvMSEqunUAgGm0pRQU5SBdx/fcEnqWlYplSxyIfWGdOnX0VXuPB?=
 =?us-ascii?Q?0FWV9QGfDQPagcF5pEYOooSv54xzfemIQRqzXjykGzcCl7qiBTkR0ZGnlBm6?=
 =?us-ascii?Q?H2Y0YhK6E/AyOi+emDE4AciYEbEPGIgARnDiCtv3LIz8nWqcQUtYkEam1ae0?=
 =?us-ascii?Q?ZDQGUJY1JDsE7x5A7rttoFzu+QMS3FE05NjV26+PPN+tl1xz7mf0iZvWaUr8?=
 =?us-ascii?Q?oQIOqL4xz7nXBCHCbfrm6fPSUAeTINK9NapHuDLgeOHiV5ViNMa4UTt2p41p?=
 =?us-ascii?Q?pA9IyuTwVRN3nvPwInyaD8Loxf1LNtPP3gL8ly6MyTUjsCqlp16Rpsoyvaxl?=
 =?us-ascii?Q?hxdFNatl/Ng1ul4jvDHs1o35biv7JEDxfftYpPb9BwJF6gPqjRlp5jpGcEvS?=
 =?us-ascii?Q?9niuHzjfO1RK6XmNa/RbPyf46srf/C/wjGMEyVx5pRs5z8Kd3Rap85wpXq5m?=
 =?us-ascii?Q?zFP0oEBrAVJOLzIxhICeC/i1kFPAhxYcdQVoi/+yTu6WFJuQjeH55u5aGnEo?=
 =?us-ascii?Q?QDjBkJ7sGwbtukSoNZOqM2iDMjzCIXXTHLkFgZ+4LvvPevWgFZwJfNzZ8iuL?=
 =?us-ascii?Q?wQ4lrgstpFOYvarAE3Vixzj4dDL47cdrxu75hJhxbm5etSlP9o+o4K4q4iUR?=
 =?us-ascii?Q?o5v6gCz4qmjL16/naokPTx0yEsG3BLTNAb8Z0cGy6MXh+OTON0YMgJHzAs+B?=
 =?us-ascii?Q?zl32BZyaTkgL3aYqRRPexf+3P9+31EaXW+s1Tc+pjOc3jlVZTM2QF4OjN450?=
 =?us-ascii?Q?bPmUAQ6CbzgJjv/od0IIro6RPa48g3ibA3lCHVt0gF0UGyPiRdFehmaAREXe?=
 =?us-ascii?Q?6IwrxVU2UFfksMUY/4POlRhC0LryLq0muTh6pRG/JeFdLYrl4iSq3Rajv77Y?=
 =?us-ascii?Q?kNQuJwkdsd6bunaOIvEeUSe+KdhUzv5fSDOLVLMth3QPXhwaPEpdiSew9vMt?=
 =?us-ascii?Q?MvE6NjBUcheftd4bIz2Ajf5YpIG1YzcXzc86JaY7FRzftmjM/Gjyr2H4lp99?=
 =?us-ascii?Q?MJmvCP7XrnTObAwUQxPOmkNEiTxr0O41A2svte/ypMG43LC8DlNcGFl63jiR?=
 =?us-ascii?Q?nbXvFMTS0QPCWosSvq8+QO/0SgdVnuIm/fbyy2VsdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJMDbj7KFS1XdFNxLXjnx5V6T6JCR7GKVopArFkcw9PHU+FCOb8vzBig9X/R?=
 =?us-ascii?Q?TrwcIxM4qOnEnYAPhfK8KGIrOjXx2owJ7RGmYGQSskmoSRw1q1MKPd4I5xSi?=
 =?us-ascii?Q?hzm2Hj/oo6v9Iibb7KwB/gMUcMtqOZNF/qyRdaCDeF8C+kwuHVnL02oC/fLm?=
 =?us-ascii?Q?t/f3oWgLGeckDf+g55nM1f9xAMVjtCtG1NQKxjGA0DQj90BZjRVB0fq04RPd?=
 =?us-ascii?Q?yX4ZyOnR+JVbn7cSBIxNooFKdwZA/UGk+6ro4mO1J2y7BxWdQ4NJpuNyBm4r?=
 =?us-ascii?Q?cmqEtVObOseg2AA+kv/Sywtx9U2lXWm0sCdiyNoz53ATQclQH978iOSDAVJK?=
 =?us-ascii?Q?FXRf2igvvxAB89S00zgldHjs1jJ0f21Tm6wVk+Yy1pTShLPJgtwpZPOgK9kP?=
 =?us-ascii?Q?zxoaEDJrVAKypnCvSIosHbIZGsM7FPzvIVK8vVJ0iJsWSloFrQg/MpDAjnX1?=
 =?us-ascii?Q?hHTB4/f08hdDgAbQN+ElrjncueBimp9AhTSHd60SgmlRPiNBdKG3N+tsaGM2?=
 =?us-ascii?Q?I+y85YC8byccUolbc+TA2v8dhCqgR3RS76B3zRFgPwTGWI9iBCnq1scksHYP?=
 =?us-ascii?Q?RHD8cM2BHtlfUcFWXtb7ssJIahOpvO+Ogzo/cz8HSO/88l9eq0nxonV+2l/K?=
 =?us-ascii?Q?C++3LZzslPrbe5qbGY5q75d3EGXzOmnrjOClKNnUKi7L7iyr4XtPAO5vs0Xg?=
 =?us-ascii?Q?hEc5Z/h72sME4cBfvfnYLQLidkYGCjA4tfZzXaexSlJfo2k1BlFainGxRIvX?=
 =?us-ascii?Q?nNtYeEnPUWosfZ+ipLnua8PKUhKdBWPgdf2j8aJXxwX/LKAB7qZWrKyvPGVN?=
 =?us-ascii?Q?nSxb/SbQCYIXcKrVz3FUT6S2G0ZxuYXnIBu36riaMrl1WZCaUJc+mSPzvpYg?=
 =?us-ascii?Q?JA2qpJ11nqVRN2xRIKM/sByHo/SSHM+Mjee1ffw+4zOBQYJkZiFAG5SAePEJ?=
 =?us-ascii?Q?t7C8sFvyltX/irGUkIOxkhbTOCrHTkwbme72vBs+ppPVdyj9fCf6PNUxSVal?=
 =?us-ascii?Q?VrmhhbNbVdldBuqP1VZXvLaexHQYpOixY2fMVxkPX5Wrl+AhowB/9/6nP0qS?=
 =?us-ascii?Q?IlFIdBKRvE114u71q6EalQqDsKQCPvvj/gE7OsQQ9cjaIDGxY0BOX8fAt5t3?=
 =?us-ascii?Q?qQFJzVtrMtqcVTkkjjo9p/M+HW8Gd+hj4DNsgCQjhNBa6AB64k3N3v5FowAA?=
 =?us-ascii?Q?DUrDyq6k0FEZyMB/8h2iR+kfBuu6qAyLv20sC1OD5EPf84Mt3t3OUy+Nqx/o?=
 =?us-ascii?Q?sOHoqT2SKJNyDtyI5esiWUu2slWytzoBW1TB48/7elVqFwq4i7lTb76UNmfX?=
 =?us-ascii?Q?Eyl4yL4MuPcFKaOcXoNAUg1lCzYHQNv5rX2DmpxKAR892CDDrIKNdle5Vpa9?=
 =?us-ascii?Q?ayVUW8OKW9XhN4260vWzthOB5Os+p7/ltapm50PjpJwoxmVWa+5efq/B7q5b?=
 =?us-ascii?Q?Ehv4x2suTWk1QOcXyK2F/yEu14aheVq/t8JtHUPg7CLRtgYQKAlAi2nWyVA1?=
 =?us-ascii?Q?LV5dcBZhGGouELJjD+CkF93z0Z4C7FsQj2vTTSOZNua+qMIkquviAhRnjHhc?=
 =?us-ascii?Q?Yq3L3xHHmYMfFXPFiDMmYCkxWHdk9yZIWOlLCrpq6SFV9Fnna5APIL9qQBGU?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fe89f8-9dd9-4dd8-0446-08dc7f09ce71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:32:07.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMMMHG1Vp52nxF5husehrrcM3IMV+Q0IlvPmHbcI/aKY3y7UE1QUrX4PD7yDwyBFi+tnLI53zmwVPQqLsVG/9avO83uHgSDZVJP+vmn7na4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

On Thu, May 16, 2024 at 06:41:08PM +0200, Michal Kubiak wrote:
> The commit 6533e558c650 ("i40e: Fix reset path while removing
> the driver") introduced a new PF state "__I40E_IN_REMOVE" to block
> modifying the XDP program while the driver is being removed.
> Unfortunately, such a change is useful only if the ".ndo_bpf()"
> callback was called out of the rmmod context because unloading the
> existing XDP program is also a part of driver removing procedure.
> In other words, from the rmmod context the driver is expected to
> unload the XDP program without reporting any errors. Otherwise,
> the kernel warning with callstack is printed out to dmesg.
> 
> Example failing scenario:
>  1. Load the i40e driver.
>  2. Load the XDP program.
>  3. Unload the i40e driver (using "rmmod" command).
> 
> Fix this by improving checks in ".ndo_bpf()" to determine if that
> callback was called from the removing context and if the kernel
> wants to unload the XDP program. Allow for unloading the XDP program
> in such a case.
> 
> Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index ffb9f9f15c52..19fc043e351f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13264,6 +13264,20 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
>  	bool need_reset;
>  	int i;
>  
> +	/* Called from netdev unregister context. Unload the XDP program. */
> +	if (vsi->netdev->reg_state == NETREG_UNREGISTERING) {
> +		xdp_features_clear_redirect_target(vsi->netdev);
> +		old_prog = xchg(&vsi->xdp_prog, NULL);
> +		if (old_prog)
> +			bpf_prog_put(old_prog);
> +
> +		return 0;
> +	}
> +
> +	/* VSI shall be deleted in a moment, just return EINVAL */
> +	if (test_bit(__I40E_IN_REMOVE, pf->state))
> +		return -EINVAL;
> +
>  	/* Don't allow frames that span over multiple buffers */
>  	if (vsi->netdev->mtu > frame_size - I40E_PACKET_HDR_PAD) {
>  		NL_SET_ERR_MSG_MOD(extack, "MTU too large for linear frames and XDP prog does not support frags");
> @@ -13272,14 +13286,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
>  
>  	/* When turning XDP on->off/off->on we reset and rebuild the rings. */
>  	need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
> -
>  	if (need_reset)
>  		i40e_prep_for_reset(pf);
>  
> -	/* VSI shall be deleted in a moment, just return EINVAL */
> -	if (test_bit(__I40E_IN_REMOVE, pf->state))
> -		return -EINVAL;
> -
>  	old_prog = xchg(&vsi->xdp_prog, prog);
>  
>  	if (need_reset) {
> -- 
> 2.33.1
> 

