Return-Path: <netdev+bounces-122270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC3960966
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37BE1F24250
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F781A0B08;
	Tue, 27 Aug 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iu7N89W+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEE1A08BC
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759874; cv=fail; b=XLfAxmajcNVXX1MVqTrZs9litKs13zwBZob2NVyLD5Ix0YXFZXE6eNI05L1dmyY3efDzB8aChseV0jLe6Pbnag4fBX3iGQ3oP63ZXeA8FlEWS2q+nrJWVVcMfu5zvbP8no8vT0RVOOOidEMxXogQB5yxceJICRMkPMh3dRanqSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759874; c=relaxed/simple;
	bh=RrfABgZwv28wS/5k98u4r5/xmRebWgKK/eUYqXrwQg8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROpyXlLphWnY7ry6B/0vmGraBoPppu6zt7RWJiTDQMLbU4GghZpIeCbc6Z/xkMpvPNZgw/D0j5n11KIQuDVQAN9/fB6yHOqKPLD3piB3wy0+lu7MT5txRvzVnvMrN8zc52lpJDVYYx1vlnDG83LMjt2V0zVLFldHt14HHqtarwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iu7N89W+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724759872; x=1756295872;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RrfABgZwv28wS/5k98u4r5/xmRebWgKK/eUYqXrwQg8=;
  b=Iu7N89W+yz9DfK8EYKOWcCU7huN68LiZitie7FVejnx0HqkGZ+wJ5RDh
   6FUWSwmRn4JNYXm8XGsAUiKzPBZF4m0UTqhXQPgebPBLjoinBPbPJyVAY
   bfLkOXOQShMrxfE5SW8RUq+KqiTkOGzEGdET8wglypMzTMCTyzK2CNIQn
   w01FB4vzi0m4lAU+AK7UTIcfXbALt1zFYV97CUm0XrwD4JL3Z0J8x7qCM
   ySBjbEvXfaEZaUnX39Bg2w4RMBYVqOrXalvibk+Y0A51MZsmpKGUKnEb0
   Fuf4CPl57tjAtRXWX6gZoNmgT1QvwtAooHbXJ6tSwv2Zuq1k473i77xQ7
   Q==;
X-CSE-ConnectionGUID: 7wq9I8wPQYSAKSF7l4rfKw==
X-CSE-MsgGUID: ttQJ+AN6T72cpCi3Xgpz1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40702284"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40702284"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:57:52 -0700
X-CSE-ConnectionGUID: EZGad/7dSA2uoUE8/7gJXA==
X-CSE-MsgGUID: zRDeC3poSca0fDq6j9PORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63001026"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 04:57:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:57:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 04:57:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 04:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtJIgGS+iKtnMiZOnwptXXiQkdZun5PEdfScnJhjAE86sXFGgqKknmaiIJT+0fD46+/zn7I5v36/rgHWLgbueQDkuSsv6P+kTlYOPXVWAOzLcBGFLeIPtgR8jG1UX+MymB5KyMkowdY/uh11YmP80tPR0U2hcU5mL76N+ZkBB5zN/YGTUf8NPp99B49tGPI5fNlHs74skfeabQx6JrKkumNr/plxvYTV35H0T7i9Sy/lX69QlNQsA2FZFK/ZGKAdzjgRi/1tKqYfOlzUC7QluwETY7mB5ybrkYqQzpJ8VQhiEq1ffbwLXxAv0+UlcRa6L9mo6AVVkEekKn1lkfeuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ajUUJRe8JK5ZmJ7veJI8J99VopPnecbPrAHIGo1GtE=;
 b=bgBXN6c/xfwz+wlW3C54dp5TXK7XLVKvWU4h5en+XwDJpS53orBLnQ0jBt7rgRsrROCVnmDp+J4CVAas1hrH3r9Ycv6aMQrSLS8WVjEJlKTeWE6Kd9uuZEAC334g98lt7ZnWOU7BGiaCLmUdMWyL8b3qlurHFrxRyBw08lmReyqaRNUn2MeE2OvnqpmJtASFnz76ExesIFP+mj4RZXVt6ndsscI/yAQZj7126fMemzwEowhC7mgr8DGrjA36hCTDNZcKAn65axJMvDugFIDDioAbdfJttlK9mij37GrkHyrzO6gLjzuFCF54fJYgfewvcBBch2xPXDh/U44rLB2vkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 11:57:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:57:49 +0000
Date: Tue, 27 Aug 2024 13:57:43 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Brett Creeley <brett.creeley@amd.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 net-next 3/5] ionic: use per-queue xdp_prog
Message-ID: <Zs2/N7K/IIATcANm@lzaremba-mobl.ger.corp.intel.com>
References: <20240826184422.21895-1-brett.creeley@amd.com>
 <20240826184422.21895-4-brett.creeley@amd.com>
 <Zs28CpU2ZkglgUiZ@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zs28CpU2ZkglgUiZ@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: VI1PR07CA0253.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 78eb700e-9867-46ad-1367-08dcc68f78e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?09twg0KD04c+6ohrHGK/IXwCubjemqF8BsuiRyh6BOfC43nMhNdWetsfjjz0?=
 =?us-ascii?Q?KHzGDpYk/UnUdhMB/jV71ckjHMuGRM+Xj4mkZp+GMV2JaGITz1ybNt1ooB7a?=
 =?us-ascii?Q?62d+k33Hyg74+jd+DxWq0nzGYFATGeNcpo+SEEjwui94g9ZVvPyDn7gddLwJ?=
 =?us-ascii?Q?XoQCtLmqd/iSSnfkCX4wbmTqwS5qxWVSegkk42xwvY2FU3xOClTczjgh/6nS?=
 =?us-ascii?Q?1R5bMMaf9gw+FNs7oWu5yLnI/Kejykov6wEhnUCeoVt0WoFTcp9KUqWJJXZm?=
 =?us-ascii?Q?IurUnAvW6Z8qFcqmonstDx37DsY0k3DypCNNYccNS90L0pWvYDWKYv6haTor?=
 =?us-ascii?Q?9s2FUkvk/Xi2vt5n/I55veGVXYCTG+cHWpJjTXxEoa1qBL16+c4gO+G0qNHE?=
 =?us-ascii?Q?jWP3ErfmgQvSJ4mAPjCXrd/z+WRuPrtniFFSMWCTFjxZZ/f9RuCzblm9UOrC?=
 =?us-ascii?Q?UsdbvDzJPTAq/GDkLCy3UZKLfHK/b2pt104CZN0cCSeIPZjvzM0JyDlZYqGw?=
 =?us-ascii?Q?HnJv7WT3Ikqk7WKw85taRohWrCrRJtU5DMJcVN8CbjiYIidd/9Y/63BlPsny?=
 =?us-ascii?Q?/OiQ05SyRo8k8CIrvSmNRUkfWxP8rmNyy7N6HGmdAW1LKoqiLWpY/3ly9b3a?=
 =?us-ascii?Q?T/6I8zqP4kolzRtZvC/76i9hKuB50X9sq2vqof+ajyLsFVRqkmSD8yxd+iVY?=
 =?us-ascii?Q?lFyeOd4s3wd7R8O0SMJYbC6aG9uHbDEAb9JB+HV6lGkvzGzgKPGBCiJB46GU?=
 =?us-ascii?Q?ZdGkljfUZm6DbbSZLsYdf/d6Rqf6aQjj19iiHOyJDK2xvRUyl7OSwuf0P/c5?=
 =?us-ascii?Q?NGTbLkmXa/S4XRf95CMY4FBNPMx++WZOndai/85vuOiORaxbi6IRGxQUbWYz?=
 =?us-ascii?Q?9YK00akvjDynUL/uzTtlJUbzKWWlCSlwtr1YDis0KZC8x/4ukHM62ARLtYy2?=
 =?us-ascii?Q?7KfT+l2rMal6i2hDtKh48geabtbgYWFXvYGEEPso+IZjwspB76N4KintHKhP?=
 =?us-ascii?Q?ewrWtOTt3VDPcJjfXFDlvOmN6E43GtXlNbBkeXPOEBs7BjnAXvKxx03OWN/W?=
 =?us-ascii?Q?EBYYeiYvXTa9uV+zeb56WG09y4xD6vHYJ9EmU3/iZeuCLCsM2z7hSgslEwFm?=
 =?us-ascii?Q?EgvU4ik5KZo4aLk57xHud0vy1dv6IOgoGH4Anyfv5K2F7weQm1M9ayzDNIXR?=
 =?us-ascii?Q?u/Q19XSNghN4Z2AyomW+03IbTIvW8k61VGk4mGW34HbA9++xdaoURUY+fbPg?=
 =?us-ascii?Q?8W82xA/nFcl4A9oazRLucSnPcUUoWbD8Fom++hucpmSn6cjcXFCkAv+H6fv3?=
 =?us-ascii?Q?tV+DVUfAkAtBnZ6IBumguJjyAPnVygQ2+2VlLdYUA9UDaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2d25krhPPlp+EmyTrFBCVPRQvuASp5acy76a/0b3N5/guu3QIsm8XZJuY2og?=
 =?us-ascii?Q?CTYB1on2PKWEyKltfTS/xWNzoRU6izcXPkDj4tPTqbksqhXRd7bUF/xU3QqO?=
 =?us-ascii?Q?5xJAyREARCQzHjV7+N8pc0sPJZXb0zslBcmVLHw9QqKdppVGhKLLlV7ETFRs?=
 =?us-ascii?Q?WVrrJdlX9BLz12p1ufZ3uS6MFFctIZEDZJ5fp23yJwVLwr7FpLyzyZbUd/UM?=
 =?us-ascii?Q?Lhg8OFeiNPcGBRp6BI7+CIqHWdBgT+cZnDvsg6dpqrKT6NMDlV8lLvaDcKtl?=
 =?us-ascii?Q?3fzxUw+Zz+tffl6bKtpmsK/AcxbFPbCZWZKvG422JcezWCkq3QtfrUblqY+1?=
 =?us-ascii?Q?OIJkcPmUcIrJZBk4lkfxYue/itnaYJtsFlT68SIDvKG0Suu4vrBTPXdeJC4Z?=
 =?us-ascii?Q?LGL3d+SqdTyHCaj8D/q14gQBMuADYvMK+KcNePJh4guFwf4N/vN/4XCPpse2?=
 =?us-ascii?Q?s6QCzH+xpAKo5vDlzQHAU8Fe/sKqtPnkQLUecVOjSr4GsXVHzd3Q9AdnjWlZ?=
 =?us-ascii?Q?4Dbq3uLSLAV5vvLOkLaV+spmYgPJOj1sEINI7t8GUDNN0sRb/SsBNGVSVEne?=
 =?us-ascii?Q?uK71CE5SrTZx4ZEp+94ul4LonJFNH9ncPA0J4IS7px68DH9eXlUc6sICX61n?=
 =?us-ascii?Q?2jRRaUN9trtKjC6VN3K5wriQQSETqFya/V0rs601a+G/PJEdqEcZYk+2RrqN?=
 =?us-ascii?Q?LxeJPfyjEPrkkQNoeb1+klj1AFGFqxUJWlSn174Xr5IpMcvhPotrRBVeIYpM?=
 =?us-ascii?Q?+Z8pCeGUNdluUKOr26BgLP26umQ8DyfQcXj25XodoVMmqrqsyIdbYMe53dqj?=
 =?us-ascii?Q?qcwIR7C3j+AVJN1ZooxDFuTb3ZK3MEKpDJKW9xJc8ef+nB/IRRGJgqPkrx9Z?=
 =?us-ascii?Q?qafmVFxQQdYLeWxyA61cVwVLiX1K7ykmhrXBCSWyAkRHfIHtuZ/0oeUkguwT?=
 =?us-ascii?Q?tbgPD/Gm83zBta8TGBlrJ8Wf1ejL0GM2rKSDemBUF81jZvJeI9Q7AVMvgl0B?=
 =?us-ascii?Q?h3vQmCof8eomteQWRdMdDPT15Ful7jSM7frUO8av5PgdrC3HspcZe9famttC?=
 =?us-ascii?Q?qZJfX9K5qoBmNZCgCbkunya9EQYo04hjTVioGE9NUFXyCO0iZV/8qFN6KAkv?=
 =?us-ascii?Q?snApju9SUc5Tz33pDiGW/FTG49bpGtNDIiZlyPG9o14gzVWfg+7vxN5a0Gw2?=
 =?us-ascii?Q?1BSygV46qjsIZF+EjiH1oX65VKNDzkJ/+bxglEkfUGycsbofonyKdors/RJ1?=
 =?us-ascii?Q?y5ufBlR+zox2BcQJMhMg1Xkg7VoOGJtYG2mUUcSGhphn2sLhsTrz63k3wLKn?=
 =?us-ascii?Q?ymAk3A8Qj2+sjXOkqbMrwN+DnAKIG/BsG0cAPhg+EvT95lazZp8t5n24uZea?=
 =?us-ascii?Q?fzoTxkpZfSL5tUUp0qnPNIt7hADm4oRuDg+byA3dZW2NH69661bcMqc5EhXE?=
 =?us-ascii?Q?zLL96Edt1HhmX4Ugvd0MVxSxmVSBLSB/1k42jDO/uU8hdgAiayjL3T6L+7kz?=
 =?us-ascii?Q?BYQNYTR0KwASQO4mkQViPuc8JyBSfBjAjnnYlHjwYY8++DpcsDTJLhRwvxBT?=
 =?us-ascii?Q?PymnL6/9cSkDFjt8BhR2dr6XYLX5l+ugoE+MkDQ4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eb700e-9867-46ad-1367-08dcc68f78e4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:57:49.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no9lJfqiZ5LKunXqV/ilOCyN4+CzW2fMxnZ2rXoXywLAV3GFEyTdQhQlzBwWIUA1sxPBtFF1r3QcNWuKKcFQKpBr9z7ruTTxPP4tC8jwRJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com

On Tue, Aug 27, 2024 at 01:44:10PM +0200, Larysa Zaremba wrote:
> On Mon, Aug 26, 2024 at 11:44:20AM -0700, Brett Creeley wrote:
> > From: Shannon Nelson <shannon.nelson@amd.com>
> > 
> > We originally were using a per-interface xdp_prog variable to track
> > a loaded XDP program since we knew there would never be support for a
> > per-queue XDP program.  With that, we only built the per queue rxq_info
> > struct when an XDP program was loaded and removed it on XDP program unload,
> > and used the pointer as an indicator in the Rx hotpath to know to how build
> > the buffers.  However, that's really not the model generally used, and
> > makes a conversion to page_pool Rx buffer cacheing a little problematic.
> > 
> > This patch converts the driver to use the more common approach of using
> > a per-queue xdp_prog pointer to work out buffer allocations and need
> > for bpf_prog_run_xdp().  We jostle a couple of fields in the queue struct
> > in order to keep the new xdp_prog pointer in a warm cacheline.
> > 
> > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> 
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
>

I would like to rewoke the tag, see below why.

> If you happen to send another version, please include in a commit message a note 
> about READ_ONCE() removal. The removal itself is OK, but an indication that this 
> was intentional would be nice.
> 
> > ---
> >  .../net/ethernet/pensando/ionic/ionic_dev.h   |  7 +++++--
> >  .../net/ethernet/pensando/ionic/ionic_lif.c   | 14 +++++++------
> >  .../net/ethernet/pensando/ionic/ionic_txrx.c  | 21 +++++++++----------
> >  3 files changed, 23 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> > index c647033f3ad2..19ae68a86a0b 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> > @@ -238,9 +238,8 @@ struct ionic_queue {
> >  	unsigned int index;
> >  	unsigned int num_descs;
> >  	unsigned int max_sg_elems;
> > +
> >  	u64 features;
> > -	unsigned int type;
> > -	unsigned int hw_index;
> >  	unsigned int hw_type;
> >  	bool xdp_flush;
> >  	union {
> > @@ -261,7 +260,11 @@ struct ionic_queue {
> >  		struct ionic_rxq_sg_desc *rxq_sgl;
> >  	};
> >  	struct xdp_rxq_info *xdp_rxq_info;
> > +	struct bpf_prog *xdp_prog;
> >  	struct ionic_queue *partner;
> > +
> > +	unsigned int type;
> > +	unsigned int hw_index;
> >  	dma_addr_t base_pa;
> >  	dma_addr_t cmb_base_pa;
> >  	dma_addr_t sg_base_pa;
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> > index aa0cc31dfe6e..0fba2df33915 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> > @@ -2700,24 +2700,24 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
> >  
> >  static int ionic_xdp_queues_config(struct ionic_lif *lif)
> >  {
> > +	struct bpf_prog *xdp_prog;
> >  	unsigned int i;
> >  	int err;
> >  
> >  	if (!lif->rxqcqs)
> >  		return 0;
> >  
> > -	/* There's no need to rework memory if not going to/from NULL program.
> > -	 * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
> > -	 * This way we don't need to keep an *xdp_prog in every queue struct.
> > -	 */
> > -	if (!lif->xdp_prog == !lif->rxqcqs[0]->q.xdp_rxq_info)
> > +	/* There's no need to rework memory if not going to/from NULL program.  */
> > +	xdp_prog = READ_ONCE(lif->xdp_prog);
> > +	if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
> >  		return 0;

In a case when we replace a non-NULL program with another non-NULL program this 
would create a situation where lif and queues have different pointers on them.

> >  
> >  	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
> >  		struct ionic_queue *q = &lif->rxqcqs[i]->q;
> >  
> > -		if (q->xdp_rxq_info) {
> > +		if (q->xdp_prog) {
> >  			ionic_xdp_unregister_rxq_info(q);
> > +			q->xdp_prog = NULL;
> >  			continue;
> >  		}
> >  
> > @@ -2727,6 +2727,7 @@ static int ionic_xdp_queues_config(struct ionic_lif *lif)
> >  				i, err);
> >  			goto err_out;
> >  		}
> > +		q->xdp_prog = xdp_prog;
> >  	}
> >  
> >  	return 0;

[...]

