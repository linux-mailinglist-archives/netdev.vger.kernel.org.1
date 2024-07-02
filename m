Return-Path: <netdev+bounces-108456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F80923E2C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30544B2276A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C816C6A8;
	Tue,  2 Jul 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bA5MGwaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8815DBAE;
	Tue,  2 Jul 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924938; cv=fail; b=Eoa95uwMro016awmbOb0vbSftw5PdLax0O409SqJ4cShbtQP4eM5aQyntWJ9NDM4sT0pKi3DH86nsOl5uu4Mgy3+tzbJpDuLXl7gBwjwf0Vwp8i6/UoAHQCwpoUwy5gDDItCHpGsN3LUR6jwTe3jjibqeCTNc0JDTf6Cx70RuIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924938; c=relaxed/simple;
	bh=djNmOuYz6WPqsTUA/jSxkIGDGnd47A/C2HYMhxFABuM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iaLmm4Ei7o3WvtMr1zErGtv72QPMXgLgxoD+8nRRmc3FLiFhXsAJCkBdiYDZKlBKRAs9ApOrbwDVYmoCQKFmK+m4HyyrYFt0BcIMb62V04LjZKe+Lwz3ZBvqHB6T2anRAj9gDdcLNHRY0gzuUpWFM0PdqdVG0WEUHUc/63mdFKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bA5MGwaQ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719924937; x=1751460937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=djNmOuYz6WPqsTUA/jSxkIGDGnd47A/C2HYMhxFABuM=;
  b=bA5MGwaQ5x7b7yAVhcmnKdPyjrXXtxDC+mpdUSlGrGQ1KTTkH6LFDq/V
   LkSnrlMBLVvagt4D9H3SmF3f2zDFKK1JqJJ2Xr0ZwKYFkpgJkhUKoDRjt
   zjY7ktYpCCj7NgZHljz0Vrx67Zpxnvsm/kwKIH3JzIq/BHh3R0ILdNLfi
   v8Q7/K1vjtvfs07jKrsljvOEub0gG9ipNItB1Ye0+m8GO+uA4UBok496w
   Nw8XHQRF8VQOyqWRHBreDl2fU3GgLiy8OmMCEar4jOWmi2ULvNKf4TYCT
   ntB42JG8/1kdDgyD61th+2p4GhkLPApRYkHehPwBnrbR5KmVz0afDnqJP
   g==;
X-CSE-ConnectionGUID: 7mRAx++MQh2Q5RYoFzijSQ==
X-CSE-MsgGUID: jIPX3RbGRUC0oAWOUXWT5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16820412"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16820412"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 05:54:47 -0700
X-CSE-ConnectionGUID: XCTonmYpRGyrWuwu5BCiYw==
X-CSE-MsgGUID: pt664QFnQTmBqt4RA3PSUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50334622"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 05:54:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 05:54:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 05:54:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 05:54:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 05:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeN5KFcGy/NWzchhw3JTcVgrkXfXc60+lkBcHbuBwvv2RHOHnquWfywl27eRgW/FOAMkDfeGuuDfFvb2RdUPPZPdT9S1Q1RRDec0NAkRefoULgXBtrTLLmhIr2kNPuflOPU9FNkjfArE/bVQgI4ERhi3L4+E/89erGK8o11MrEshs4I13XEJHzDwhaZNQF9uv0bqCYGJZk7fOQ1Q6rg4kZPPnVv1A4F2TMBW02i3BL3TGFBEtBmy2fEdLSAqnbdgLaQtLmInnkJwI1NJjXEAYEwriQE4nZxnTko59k8mgkKdhIQ3FDrGZYW9o1InyU5t0k6OvdvjHtK8lag+HLzw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVZZ4VTzgfIOM+qonaT5aN+CDkBlPt4+awheLHsJyX0=;
 b=A6QnAuF31G2iydXWFIKHUPJlcbw/qKSqMPZweXEl4nuttV/yLOJTrw5kImt4e/pmehiTZ2PX7URUYE0+pObQUQ1dxhcBH0PmexoMSX1Dh9YHVgtRkF4xLvTa91M3qOa36mUsAqOimc2BWszZQaI8ZfjlNfxouHy0tJ7LcC0eHP/alV/JDhUzqA1TOnzX3+tvwmwaQDod7qapBFjU3bqes0Iltl9oO3aD3TVmu6nFEystCql4s9OzMEJitUybdqfIwkgzZdbCsbhxxXDBUq+vq2uKv10crrtUbF4UCrEoWAhx4NoTRWTcmsFnr9RCvCRHl6e1i2Q+zih/BQvvJBqGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 12:54:44 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Tue, 2 Jul 2024
 12:54:44 +0000
Date: Tue, 2 Jul 2024 14:54:32 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Srujana Challa <schalla@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>
Subject: Re: [PATCH net,1/6] octeontx2-af: replace cpt slot with lf id on reg
 write
Message-ID: <ZoP4iG30sr9lZohg@localhost.localdomain>
References: <20240701090746.2171565-1-schalla@marvell.com>
 <20240701090746.2171565-2-schalla@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701090746.2171565-2-schalla@marvell.com>
X-ClientProxiedBy: DUZPR01CA0300.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::24) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DM4PR11MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7870982f-465b-4682-5e4e-08dc9a962533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UrLwwB9M5/RFGd8Ba4i43C8F+mgJnvK7nIu10nAaFTkQQvsYdDoPtncb3Q4h?=
 =?us-ascii?Q?hQehWZYGhvEh3ImU53kIaliyOuCGLZ+goeKu6dhzwMuvMnsYCgCKEmiO662T?=
 =?us-ascii?Q?1tiBNeMqmP2+cwXFdnDwi4CCKGzSP0Oc7ead5d99okmCRYqSb9FrXF+5WVhU?=
 =?us-ascii?Q?Kl5RQb79+AIR/hvfqERt0yYp6E2363uGOaHK2mDb2AVNXUlVuWkFPSYCyUgR?=
 =?us-ascii?Q?fcakclwODWrIBz/sGFEE7FU3gZejLnlk7ffR51pBFVreX97a7CXqNicDv3ha?=
 =?us-ascii?Q?E29rTXRPVxxWBQVBBzD/uutm34/EYlZGga9EnlThymNzNkQCKtzWFyx26r6/?=
 =?us-ascii?Q?1zbGpHOYrFsVTfFHB2NnMs1o7f8x3dSZhSkdxhA2xjGkF/Z9Po+BnSZLHPUI?=
 =?us-ascii?Q?29Q5EfdbufpFGz+29s3EtoeK120x01WFc+SgyDIMdexdWuHqQBiZX6PCiPqk?=
 =?us-ascii?Q?mNNvuOtpxjL3Tf3bJ7QrYCBUgroKWPM/X6/UK6NEf1qb/dq4Er0dVy67MlnA?=
 =?us-ascii?Q?ftwxBg1hUmmnV+bkBm04sTnR/dFBkJ4IvubULQe3UeuoabZmt4fCZ6IyYL+r?=
 =?us-ascii?Q?NUmITEf9Dlcp2cA2VZpWux0Dww2OXjxXnhtDspvKt0A0/a6sArSPet9FvWDt?=
 =?us-ascii?Q?nlK2NfRaNzS6U9hKUtSdQUHAiGDKQ1c9Xm/w4g8B+PkmeAnll+N2TNo6E0q2?=
 =?us-ascii?Q?z/FK2mjUKAI8bu5Xx0tvbbbySMfL7mgtvhdXheeLPhwTMzB8lk2mFafHOhp8?=
 =?us-ascii?Q?A3WKlkDHwIyrMI/i0HnhIPSm9hOHp1vDWTG32mJPH5OuJzDu5+N6w/w/tPEh?=
 =?us-ascii?Q?rA+aHIbnLODZqmSgXoq4EPKicO4e852Pwg0MDz7PqNT984bnjpU8XC8JwcCc?=
 =?us-ascii?Q?KNmlx/GnAFrYkgyzyhCj2aDcYw+aSajr+g3EsJNk6Qv+T0GGmbGR4/HUZuK7?=
 =?us-ascii?Q?oYq9M8nMssLbi7siHL0/iOpgr3eO2GomzHGjzHrQKm3l0E2groFD7uVG1PU4?=
 =?us-ascii?Q?JgM+4Sj9DrYo1aVT4hOhn7O3yzp1MP35PMFtxpRdAO2HeembyditHsKVNmnN?=
 =?us-ascii?Q?qmpEBeYsv0Vclxgl3PA9f32n06UfSBlFyI4KdLI81MPN3X01jMgD1HgRibRk?=
 =?us-ascii?Q?sV1uWF1/xV08bCr7rRFucNF4PC+qLRTqqAX0CcyFQTcLG8ery3bOMCmVYaK0?=
 =?us-ascii?Q?xk/N1A9jrpl+lEb4YsltPZGMjComYZZvhULQUoKUxSk5cpBGm8EOIi9WRIB3?=
 =?us-ascii?Q?oEI1X+Xy+Ek6FERHqODCxLEQeI9/11Js00gIEbMitmzq/SGrDzMa2qNSHSza?=
 =?us-ascii?Q?lo0VckF05zBZEmADiVodSEeCftmWAr9cEXArYW1u1Snk6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fB67jcLQ1EtnEsAF/+5SNbghm2pdyT+78LBZbvDxDsZbwvYDLLyIJynoL/Jy?=
 =?us-ascii?Q?PMRagBzJzJj+q9aSEr+RB90ITeOQvUiAfgXFnxMFADqjf4/QwuNaXlG7LQRP?=
 =?us-ascii?Q?BdqB3LQg1AGYFb8Ex/hJjL63QoN7S+pmfwa3QKPEoBS+xtSAQL+EIc3e5kue?=
 =?us-ascii?Q?LGfTDhrQ5zjRCSxfq8iMOVR2OMyxdzrQ6ctfPXtpkqU+B1vUhwAt6QbCmqL3?=
 =?us-ascii?Q?OYCfCum42Ciu8c/mIrAQV/qPqgX0kJKcidkacjAHpq0rk6AOsy0wyeoZBPeO?=
 =?us-ascii?Q?iLt8Oj7v6ZejLxbOerWfVyOz4ge8VgiXJwxqZv4vEjeELeSb0B2uCWYGw/LK?=
 =?us-ascii?Q?jNeriWn3tfE2fBeAcZFYI4bUZ+aUFvZnIyFwMIQ9qNl8IvcynFCwjxwze/mn?=
 =?us-ascii?Q?inTnJ9sA23sDyuMoiZITgQk6bp4zztsS2VHk8r4p5CqKNABf85UsscsAacGc?=
 =?us-ascii?Q?jZC6YPf1PFFcSnKeJimN8ep9+ovULDouv4by5+RlcKrRDOWoadhDUD0cvBV4?=
 =?us-ascii?Q?htWCkaGEyqIFmtYSnv8rMj3bFExGGj6r4RHDqVoqmTEVUAZRvis3boTF+BZm?=
 =?us-ascii?Q?zLQccvtnPZQnpwrs3HROK2XhAq/LxgJT0logApjZeCw2RETJF8x9RP7J7kjH?=
 =?us-ascii?Q?sxzYY/JenQoYKSBpu7sS5ISDiCNnFG0xkNGGJkc4+P6kcC7oqJ0XGx7JzOvr?=
 =?us-ascii?Q?FrQfqWJsIUMXtTMLpdJWC/4MIjBBYmOfNNFUilvOIMCkyD0f0rbzcKbMe12s?=
 =?us-ascii?Q?K50pKzYh7l1s/mSEd2mKlBYFF9+NQ8lltJAPGpgYbbOOaJrlrRtt9rgMcmGl?=
 =?us-ascii?Q?epW60E5m11WOhjoRr0FAgMvrP/3g4wgDYx+SlGrb+bYm7zEuBuepP32DR+W3?=
 =?us-ascii?Q?nFs/maQhKjMEcja/qgn78QiC/23JlkSbs3xGrJANRBkOE7QoyYRjhyHKGlA8?=
 =?us-ascii?Q?2kMxLk4dLdwS/yIA92HhWsA65v/7o1/J77RmQ8c+A7gdX0q6J3Ff6xku96yq?=
 =?us-ascii?Q?EpJCSQmqaQC6HYqrScodUiDNQrDUDs8FWRikIsK9V5RwQJOhV+pdYaD6CY07?=
 =?us-ascii?Q?F8+XjXfpy6AWEqIOJUzONgvwYF3RHKBOB2H3Xl989d4nqgGlnM2itaRXsAmK?=
 =?us-ascii?Q?jTmFFUBBhwulSiHmrzwRzqLkezaWoIj4XYyyMWcpdnwbT9YS29bzOrDIGJYi?=
 =?us-ascii?Q?LMbkMWKDhtGKXCxnr1rvcuoONIqLdgkXB1DEFM8ywgJ+NajmO7jLZTWuJJJ3?=
 =?us-ascii?Q?2nigudwK0ZjXRdgOHZkQJXjx/M810JnTrwpZQpxs5JCwY1+r1KrL4TMQFmXf?=
 =?us-ascii?Q?cjausnb0d0l6e9mJ3fw75VKjKGDh46SX0QApMBvADIvUNZDK3SOrUExfXLzt?=
 =?us-ascii?Q?lMR5YqsuqzG1a+0wUIxVIytIYNKj1vyjz0itWhdKtlrsqZ4ZVBLBppmKl79q?=
 =?us-ascii?Q?W+pbEweBapaMh/J1xO0jUZ8CTSt1XorJLxVsTO2ZizHnYMGE38w8nnp3JQ9C?=
 =?us-ascii?Q?Y4wwaVvH1R6cj2oOr8iyzKW+Kp8Fd+HIjmz1Cc27ctW2tfPQpsJWMoytDXVx?=
 =?us-ascii?Q?j64pIrblqM8dZdLQN9igBaOnAzFM3FiXbvWIhu9vWMPGPnLyTbv3lmtpfCfk?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7870982f-465b-4682-5e4e-08dc9a962533
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 12:54:44.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk/YNeNQ0Qt065s5yyo8qYKgMSRp9yU7jAEqYG1e4MVKo8OQ0SwTWVMeWs4vzRkuSxhqaWtp4O0UQXZOxwfzKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8177
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 02:37:41PM +0530, Srujana Challa wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> Replace cpt slot id with lf id on reg read/write as
> CPTPF/VF driver would send slot number instead of lf id
> in the reg offset.
> 
> Fixes: ae454086e3c2 ("octeontx2-af: add mailbox interface for CPT")
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> index f047185f38e0..98440a0241a2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> @@ -663,6 +663,8 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
>  		if (lf < 0)
>  			return false;
>  
> +		req->reg_offset &= 0xFF000;
> +		req->reg_offset += lf << 3;

I think it's not great to modify an input parameter from the function
named like "is_valid_offset()". From the function like that I would
rather expect doing just a simple check if the parameter is correct.
It seems calling that function from a different context can be risky
now.

>  		return true;
>  	} else if (!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK)) {
>  		/* Registers that can be accessed from PF */
> @@ -707,12 +709,13 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
>  	    !is_cpt_vf(rvu, req->hdr.pcifunc))
>  		return CPT_AF_ERR_ACCESS_DENIED;
>  
> +	if (!is_valid_offset(rvu, req))
> +		return CPT_AF_ERR_ACCESS_DENIED;
> +
>  	rsp->reg_offset = req->reg_offset;
>  	rsp->ret_val = req->ret_val;
>  	rsp->is_write = req->is_write;
>  
> -	if (!is_valid_offset(rvu, req))
> -		return CPT_AF_ERR_ACCESS_DENIED;

Is moving that call also a necessary part of the fix? Or is it just an extra
improvement?
Maybe it's worth mentioning in the commit message?

>  
>  	if (req->is_write)
>  		rvu_write64(rvu, blkaddr, req->reg_offset, req->val);
> -- 
> 2.25.1
> 
> 


Thanks,
Michal

