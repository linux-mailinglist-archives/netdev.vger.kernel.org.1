Return-Path: <netdev+bounces-102865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A990530E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6221C2820F0
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0C176242;
	Wed, 12 Jun 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+UE6T2u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC5176241
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197026; cv=fail; b=ol/yIOCZPBO9cepRwppCahraPlMrax0XQdnjbHg6YR6kDYwz3Iae7raQwdAqVLoGbI025J1Q9QEdUsJV0FYqS1deWby6sBRBGB3y9JvVfCrP+ZNiFgWbWuyKnKcjzhGk9QEyU79FqdPtdq0IPRxch/wGeh9vGnatVcYDGmDDUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197026; c=relaxed/simple;
	bh=fTrZ4rnifWDUoxPudIWAXwQC36FdrirrazC5WAuSD10=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDrzA/tC9U1iZFeuwvIGtj1xlR417IUxZuKZieIwEwplbCTtAIIf4HCVgTwnoOJJ6jQpJ1W7iIXOfiLz/dX9ErFIZOHambW5HHbVxUgxzWh+XmWOLiyqK5aM7Bcx/AFYDi1hBPHwFSQVKEQP3yfJz7EL+Lr7gFmIb7s2SblKGMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+UE6T2u; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718197024; x=1749733024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fTrZ4rnifWDUoxPudIWAXwQC36FdrirrazC5WAuSD10=;
  b=T+UE6T2unEloZKHpEFpV8XqrA1CHZqzG+WDushWSiDtRblrn6SbCFjHm
   AiA+JODrvJ3p+4KLIkhwtgWy55DT/y+AFO8z9laAXgDGTB6iam3usMBSW
   ozlPw0BcqLCH1BrDVmMqq0AqFQ4qNBsGuHQ/CHU7Rxdcur0FjiMeTphUb
   rXsI8usIyQGIdb05Y3MoMzskrspXJ5KWIg4MDu9O4IK3ZZZ5QqlUwHeS+
   lZlWKwMvaIGZY5zX1JOaAGb7EeLftuvxpbvRFSd3kMDvMj52s0A9D+n6q
   HndkFPQCrM5TJVwF5FU0iBg+DiJB/qd7pHBB2kBbMF1ldfNZa0OdxPn3q
   w==;
X-CSE-ConnectionGUID: Dz3HTspaRcyhhV/iedh+/w==
X-CSE-MsgGUID: CnXkyKWzTb2/dLpiCkw2mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="17881635"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="17881635"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:57:04 -0700
X-CSE-ConnectionGUID: f1oRHRI+SCGBlZqteO9Z9w==
X-CSE-MsgGUID: pURgDQ3bR3udhB6WSOQ90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44171648"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 05:57:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 05:57:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 05:57:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 05:57:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 05:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAgF9UNHDPNn0Fo+xp64R+HO8l7Q2C7n9TefEUwerJsPSyAnWkxYOuMZuNtxXRijaFq1gitmmydBLA1FVhDRLVBxCqk1X1nz0CB9S/SXfkj9v1flEtwwK8dDNvzXQcTv/lknqaPAoz4H7RWy0mwUyHWkg4m21+/88XAk6XYJatRD7vKhey8oi5RS52oM0m1udjpYIOTbqimA4K36IvpjQhNEZpiykypJVNxatZ7Oy/OtCph9s/B6ZQooLtXPBd3PewGPHuOwLr+EF8rifhXsKra/RnpchfeGvZXKF+t22ZXBCyJ2S6dI6GoYbPGRkA8a6eXyz5ZakxD4ZvdqKd6Mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/QSNWirNEGzJMBq5gGZQRbaPRo2oDFcK0ro2o3Geko=;
 b=RQeDsydBFVmoXW58nfvhXm7i5Sv1MDFE4YyuY2XpNgAXh9G1746jzDjrzqe4+WeRkG5h/sWnAsGnF0XywBD3KkS5mhxbktFV0T6JDjr7CWgVzGkWFe8swwsNBwf31iZErjzBoign/7jfOwRM+FTeXgR5IYD1rAPZUvdJEuNUtJNZjk0L166aJzvaBT8Gs6E7f2Nl2r2R7ybQcmGevB7knMErYhhkOGOFZMRK2pzUlN4HUo6kT5uVVNLmj2/lukoe38qkUhb99qF4r1GDbUeTiR/fenKceXdk8tsjx0c2beHPxfMTFmCYuM5O5mkhLjxLTxVFu57OuKGBGXfolnDJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW6PR11MB8368.namprd11.prod.outlook.com (2603:10b6:303:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 12:57:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 12:57:00 +0000
Date: Wed, 12 Jun 2024 14:56:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
Message-ID: <ZmmbFWJNb/s+UFNq@boxer>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
X-ClientProxiedBy: ZRAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW6PR11MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: dd00d2e1-b97f-4d0b-ad36-08dc8adf263c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwGgl1EK9eBHDhJ3gc96dNK1n7BgMybLoXEn3h2vcCdNbrypqpzZKGe8QH74?=
 =?us-ascii?Q?UUHBfn0HXu4OpKkK6LrwZcrDy8Y9GwoBRDqFZMXX1CUMzRWyhv/Z+qedIoNY?=
 =?us-ascii?Q?7nRMv19CeQ01wgtPXwo44EobPAxMVpcAm/Ovt3RgHF72UrVMDoEof+bdRhxU?=
 =?us-ascii?Q?oVIQz5f80ZpEX+khiLdMWc/MsM9AQOcO3XDvRaBZ8iSbq/6tiDSwl3RmKpyR?=
 =?us-ascii?Q?60E6CmDhsyXRrvP5nThOuE+HySLXkWRC+WL2BwEAESt3QcMhZvNxYh7U0fTN?=
 =?us-ascii?Q?ln93tVNejZGxkjNlnie3lioS7Tl9LAX8S5r9Rf1xlBJ1UycWk7ZQn9M7ooQc?=
 =?us-ascii?Q?JnjyuNQuQwBUI8TE6X6u7EmG7mlP2y05kWzWnQC92L+3cDVyHH6WEMG+yrG7?=
 =?us-ascii?Q?yDFTz972pd+saQyeDGZm3f3GiGlNdjFcFxXqjFoE5GaHloGVNU77qZJPNIf0?=
 =?us-ascii?Q?M6VQxHwVhkfOxRSP+Ja0nBISR080mYl5dONLisVVSlh8vo5MFFSzxlAjNy0O?=
 =?us-ascii?Q?DUls8yq2gKOpnMNdchYsppISOA7/1jlUVbL0K7Tpbb3w2+FOGLHhvJufujJd?=
 =?us-ascii?Q?344KMpzhkpiuT4ytCgXsUcLNNXdZWA4RHRzJNlE8AfwZdSkvjMfX0BhoqE+C?=
 =?us-ascii?Q?ZAkIdXvtFr2Qu7YzVnqMQ3KzfTWAW47cG30e9jPZM7gkMkECZ/sqH3+SGF/L?=
 =?us-ascii?Q?pOCE6TMRkIkfMSTWuBw85Ex7iwHCWpMTX50AiNXtHbd6GOhSf8uhs/L5lV86?=
 =?us-ascii?Q?RmQZ7cLS6LqL4sBlgHzwriJg+fRfImzmsqVXJkqe8mcAkMJWjBekuv/Rfek/?=
 =?us-ascii?Q?qbzDp3jeUuoDdiQOwqc1pd1IfQXtsI9ipGe18x8MwO3onn7NladJce25meMX?=
 =?us-ascii?Q?5rvAUs+TS0xFaqG+AeShNk0fzz53SomF6uE1Th73IBP8SjIEFneVj0QJ0NB8?=
 =?us-ascii?Q?6aCj/t/LDOBG6qd6qyWnTpuNn144zb6R9OblnvTcFN0AypEmIHLmVRrJReOe?=
 =?us-ascii?Q?R+NG4Eyqi5z9+bXKFI9wnUQHcr8kgfrs9UHKy/OaoJ+v5kR6Oecg5v3AmRhm?=
 =?us-ascii?Q?Ry6LWSw/vfAwqyJ8tohg7s2WO3sYNFY2rWWQM8xJlgQKWF+TOg2mc5x41AFP?=
 =?us-ascii?Q?U6S8U0W9Vzl1LgthPZyGkbnS9VTr9pdaITnViuYfzXMffADlQjkW7J7Vje+G?=
 =?us-ascii?Q?M7VmttNpOe9dR1u5YU2o6GaH7nYjqaNB0wMH0QzWCT5FV4DyBUlvcH/Jg2xr?=
 =?us-ascii?Q?QBNx0PpX0d6ItajsCOJhdVTlfBckyIYPEbSNYSaFdkmoyi9YNbl9mW+kEDBy?=
 =?us-ascii?Q?ccE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PH4CKapjr/NJzYvbXAMRLPF9pL2Oddsoq4IG9syn58gYE5nOcmtRDaUeudL0?=
 =?us-ascii?Q?XgDchTSXkmwn1RGPOSapiIduJUbpgYLlqLxAm6Svs1JiBXwp48UPNIAsIT9I?=
 =?us-ascii?Q?Flp/jNWKwNQUZxyeweioCz9M+I8KQ7uhZ0k1gK7e3PzhReTOJU2JrPgmdvfg?=
 =?us-ascii?Q?mmkSSMIAYV8OPzmUtKMz/YFRS7fglwIBGRsP61zNja93UJqOUoAjhee0A9Er?=
 =?us-ascii?Q?xaW4yWLCgltfLxGi1MfV38F5/QcWIY8nB92stxQzgYGrJT4mj/836ufGup1C?=
 =?us-ascii?Q?OsOmLloyKxbJpKIbo7qDEwcRYqVn4aBOoM0dYmd5xY4IIyhg3dg/PmxkJMFf?=
 =?us-ascii?Q?HHK1glaH7NGBaW+s018q0W2oIUdlfmWrB6NWp4xdnk1UQp8Luc+rlmDdbvtb?=
 =?us-ascii?Q?HiHW2E4+MXfc9/fup2M8LtTF/QyUQivDHvzmv+U2Cqp65QwWhZHq1wRPLZW2?=
 =?us-ascii?Q?aHZqJ8BVyJ0TgWwxgvItJ88xs2QtI5iLfX8MRjXv608Onj4aM24ee9pzOqtS?=
 =?us-ascii?Q?2HNkNna3ANlCZAcyHrQQTR51yvQ4MG2ltG1YK2OpgTkdxsnh46hq+ne9V0Iw?=
 =?us-ascii?Q?sFx3VUAxo7qOYIc2choNM/5T4RaS8iJP231DY/Lv9Ohv4RupE2AgK40I7v72?=
 =?us-ascii?Q?VTqYV/hn0sRqxSUSS3AhR81jsVHNHujBBWWG+Uy73Q9rszA6J3+sCDyJw1CN?=
 =?us-ascii?Q?BXfA8wNyuyEkqp8LLWLIlgDcF5e069gn4xn+XwDgf2JgpE4pAYDZ8jJrmQN7?=
 =?us-ascii?Q?RSs4YMw2DFqnNGKC6uY1xS+1a7/psA0Q8YgIjU/Di5fsbZwXXcyC49++hHlg?=
 =?us-ascii?Q?sCWIvNU5YGgjDdmXULZle0dt/veg7h3meyg81OOEVeytjg9FEZ0U52OqVK9Z?=
 =?us-ascii?Q?kdL4sd4AJifPhlTyhyiOXwkSQDKUebFONCPbh+DfdCdYTfNIWSmfmHIvtN/Y?=
 =?us-ascii?Q?hgrNIo7/4PzAKxGxmKMfl/Ld2IuEsp5ExrCCzv1L/EJPL+fRIfC75a7QatSr?=
 =?us-ascii?Q?0DgxKxgpzdhdq4znv8I4TwiwGb3En1ksIUNK3Y8P6pUCgTOKQu+Cpr7TD41W?=
 =?us-ascii?Q?rLCVnSsHqCKCuJJ7klCguWkP+9/lHj3t+FPzUkZUao/Wybc8uMlQLdp9X46y?=
 =?us-ascii?Q?TFSaUPUC3ZGRSt3l4PQYMkw7Fef6w/oMwB5TCrZLDtrfCZF5RylSd6u7NZZr?=
 =?us-ascii?Q?pQGu7YrtyCwy65wZqYhSND5cBfuexdZjc1DeyTXZlTWwWbKN+EGIwBNZ77Z2?=
 =?us-ascii?Q?IpDGhygSKhCVpPmZaear7gh3prWDDAoz4cpgk5138E2LyJgFKJ1Zcx5L3ERd?=
 =?us-ascii?Q?StI1GI9MFDtE2ulnJ67QaoPbrmk85WI+TfFcqVb1r29Z1qiNfDvaOtuGD6sl?=
 =?us-ascii?Q?o1EJgwcAt6oHBQEsKWMxuEdJyS+Ogso1Lw8+HIry4/77CAVyhyh7NEAi5eT2?=
 =?us-ascii?Q?q7a+F7suWXBsGcG5HxQ2Mqm9zR6V2UBbq3PedESSsiN47yolNzHoWom30YFh?=
 =?us-ascii?Q?y83qo/cs/f1P6edqDAzkFn+rqL/a2AX6eeZAEn/IVdmWvYJFG9xfFQ0+Azd9?=
 =?us-ascii?Q?tjyRpfj+R6NQ13I+9y8B5cLLZAwjG4GiD1SuR/RrBHnMSOEXHOtiH86S5wXr?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd00d2e1-b97f-4d0b-ad36-08dc8adf263c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 12:57:00.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VIEIGL/L+gKugNP5KmzEdW92cZWsRqxlqsGN/to2YZAaYS2PZ8hJy//PKCyQldBI6ZL23APfooCrgJ2gj6Pgxk7cdrvgZa9NdUWVCF52TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
X-OriginatorOrg: intel.com

On Wed, Jun 12, 2024 at 11:24:53AM +0200, Kurt Kanzenbach wrote:
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
> 
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
> 
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
> 
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 8b14c029eda1..7bfe5030e2c0 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -682,6 +682,7 @@ enum igc_ring_flags_t {
>  	IGC_RING_FLAG_TX_DETECT_HANG,
>  	IGC_RING_FLAG_AF_XDP_ZC,
>  	IGC_RING_FLAG_TX_HWTSTAMP,
> +	IGC_RING_FLAG_RX_ALLOC_FAILED,
>  };
>  
>  #define ring_uses_large_buffer(ring) \
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 305e05294a26..e666739dfac7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2192,6 +2192,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
>  	page = dev_alloc_pages(igc_rx_pg_order(rx_ring));
>  	if (unlikely(!page)) {
>  		rx_ring->rx_stats.alloc_failed++;
> +		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>  		return false;
>  	}
>  
> @@ -2208,6 +2209,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
>  		__free_page(page);
>  
>  		rx_ring->rx_stats.alloc_failed++;
> +		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>  		return false;
>  	}
>  
> @@ -2659,6 +2661,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  		if (!skb) {
>  			rx_ring->rx_stats.alloc_failed++;
>  			rx_buffer->pagecnt_bias++;
> +			set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>  			break;
>  		}
>  
> @@ -2739,6 +2742,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
>  	skb = igc_construct_skb_zc(ring, xdp);
>  	if (!skb) {
>  		ring->rx_stats.alloc_failed++;
> +		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
>  		return;
>  	}
>  
> @@ -5811,11 +5815,23 @@ static void igc_watchdog_task(struct work_struct *work)
>  	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
>  		u32 eics = 0;
>  
> -		for (i = 0; i < adapter->num_q_vectors; i++)
> -			eics |= adapter->q_vector[i]->eims_value;
> -		wr32(IGC_EICS, eics);
> +		for (i = 0; i < adapter->num_q_vectors; i++) {
> +			struct igc_ring *rx_ring = adapter->rx_ring[i];
> +
> +			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> +				eics |= adapter->q_vector[i]->eims_value;
> +				clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> +			}
> +		}
> +		if (eics)
> +			wr32(IGC_EICS, eics);
>  	} else {
> -		wr32(IGC_ICS, IGC_ICS_RXDMT0);
> +		struct igc_ring *rx_ring = adapter->rx_ring[0];
> +
> +		if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> +			clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> +			wr32(IGC_ICS, IGC_ICS_RXDMT0);
> +		}
>  	}
>  
>  	igc_ptp_tx_hang(adapter);
> 
> ---
> base-commit: bb678f01804ccaa861b012b2b9426d69673d8a84
> change-id: 20240611-igc_irq-ccc1c8bc6890
> 
> Best regards,
> -- 
> Kurt Kanzenbach <kurt@linutronix.de>
> 

