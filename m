Return-Path: <netdev+bounces-226611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA2BA2FC6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80A51C215A7
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83CE298CDE;
	Fri, 26 Sep 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNgi+aQc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102B286D46
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876045; cv=fail; b=r1SUhSryZmJn0RtJTt1pnsb4SqVnEXSrqPTwoLjLkOASMxjf+jUjoOksPDz5tQnhFqZQ6lGjUgbKhRfVvX2/Li5epyFFm6VooS4pxpsaAAqNCH6Vccup8ypGg5l3msR2jexJAgdGlgIsixNUNx+RBcxnLCr21ZfYg+VQLI6bhcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876045; c=relaxed/simple;
	bh=Fv0MrupqRB3OmN8aecWg+mWH1epkVeIbHSLP+r1l2LQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kxXnc+O+F/hLmLK0zzeSeCIUxcueusS8n9069wy7IOmWbdjMYt1kZBYbZ5ADabfyMzNkPr026qq6NIUHw9yn7uxvyz+pR46Std0r1okS1+iwxMNrwJWsmO4e8a2UFYEB5wMVuvRp/EuwQ+q5pN+XqWB7kWSRC2Ik6t05Og27L9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNgi+aQc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758876043; x=1790412043;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Fv0MrupqRB3OmN8aecWg+mWH1epkVeIbHSLP+r1l2LQ=;
  b=NNgi+aQcOeeVcAZDLi6WTxP2AoxIVN6f2Q6I47XxPyZ/saYtiajpIjkJ
   y/Tb/rKhywmCwCiPC7wAn0mEwJvkyJzixocQ9VaLmOt2j1qpui7Be7KYu
   DOcZ0X1hLWOBfr9BanrbaKCzrmyLGJkfaFjsYLxhXW0qqpEbUx6H2FCZQ
   BhyswcsZeBkYOF4BeQh/H5lg0ySuS1h+oSRB26TzWyHp6lYlDy3/N4+6v
   2iD4VUc+h5/JOaQAy6V8lrxk4kNFGoPWP7AmZRXYCzk5Mdq55c+ndxT6s
   ZEeXAFrEm6v3W7h5GBy6dMGAQlrO0+Bkx3DGDojrCHDTYvRfwKxjKJ7l6
   g==;
X-CSE-ConnectionGUID: GZVDzspyQb2OkoZtfdTfrQ==
X-CSE-MsgGUID: 742SUJI2RQ6nvSYUHapxsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71824967"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="71824967"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 01:40:43 -0700
X-CSE-ConnectionGUID: nG28WpFgSF2FuYoL6j31PQ==
X-CSE-MsgGUID: NwQRrfXOTKmwyvpJdJpIMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="178011856"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 01:40:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 01:40:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 01:40:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 01:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXvNthou0O2KWd9rihsTLyop/BYiyeBoKAlas5JO9QwlGJNlURIhUxQvdUgLHJaYVCpuDwk43JbVf1aziACB9deiivMo9B8OVw8xVwNL+OMcbbyi4w2wLCIZID7FBU0zj/C7A5+1wI85u3IY1PnRHdYbX7f9KdVonwHoUQcDvYAsdYF2o0bsTr7Dx3D2S3miYNFzPrIRCYmroW0MqtzZV99ucnhkyW9hchcCczl5boXhSU3u2SSj+WZ7cmXIARSuJsva4q6SFfVaWFn4TLf6gYG9xdQ6lmlnyC7p94tTKVCMasQZNUftJyjsTQFEIjK4ttSAis/WlFOl/m/5zMfs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3Pw4UrqWCoMLBT48ZIl+fTDdBPcrfGB9gsqSjeIE0E=;
 b=y+Msn0fXSV1OCzlsHJRNSXtJfaxfBVoY34rbvGWoxAXJ4nLHyVjqTW4GWvwjl7/mInOq5XYucx5EWq/ogj5/vNRvwZ9uBiu14dL75x+osnrexQv9/uKPMUOhh3hCubvRbtosgTdL/F2q9L4KmHNwXl4SxVjq39AmfvzXWOVw/MngXabz9+lp1H2pm0nP4u6C+JN1qCpvAFTgNOSz09nyEIPgEmKiRzsMQSfbcvqtxmpEzGI2vqN66qwbrl3nq2uQguYfTH1w1oCm7Zn32pkvYLmTGty9Js7wp9zL95FFZgUKa2MuHOpCn7/ofKtZo8NL/x0imSB6m02l+abwSbFcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 08:40:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 08:40:36 +0000
Date: Fri, 26 Sep 2025 16:40:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, David Ahern
	<dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [udp]  6471658dc6:  netperf.Throughput_Mbps
 200.0% improvement
Message-ID: <202509261609.dec14b91-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: cd117f4c-1535-4ead-05f5-08ddfcd85d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zQJ8aZ2VlyCQCMD/gt72CtGyAeq1XdBlx9sz+tUDwvTUEg59rWSnly7Kgu?=
 =?iso-8859-1?Q?SNraAK0/iXC9LBPB9ANLBPVZfmz/zR6WcNHHmHQDsGpkcVw61FllrSj26v?=
 =?iso-8859-1?Q?n15MUGDBzAbFMyOPzoGK4dVlyT1k5AIW4qWWYmyJ+6m/sTI4Ok95Feg5Gn?=
 =?iso-8859-1?Q?P8MTr3fBu55fiN6BcZDBfmAO1jjJqi2ztQxTNqO5LlZSadDlniVf4j16t3?=
 =?iso-8859-1?Q?s+c+42Tw3kTW8gTY2xnIxNUH2X3o4Zn1cqvSZzE/FNZbf368br4ZnyhTwF?=
 =?iso-8859-1?Q?zCqsLv5+Hx8KnhGw41T5Y5FOr1JB/QLaexpn/kGzzdecV4PqNuisp+9v2m?=
 =?iso-8859-1?Q?RHrn0bnaKbahq2pSvPIAJka7j5AG9tZPfnbPDBwjOn8zBt2twr+wY6KYyW?=
 =?iso-8859-1?Q?vmvzjCtjekAmoAtM0uNiyAWFShxqYDPIuJ9iTvMu9/NuAl1cbS2gzjAGUJ?=
 =?iso-8859-1?Q?3aP+3LwtmGWWST1RTGUnPnEnZBOu4I20fOm8YFG48u0KS2ANTXZ1Cupvuy?=
 =?iso-8859-1?Q?KOl678zjPA7BtnL2Htq8dCYeTeXOifGX6Qd7q4rPhaYhwPmH+L5Cz+JRn8?=
 =?iso-8859-1?Q?0w6OErhU42U0BLZ3ciPn1ObbXlg/mG8YXuUiG9K9QNEnihlP70+qquJcCm?=
 =?iso-8859-1?Q?cIoDsMrrhPUyOXeJqWV9ph39/PXX2WuzfuPWkBr1znsbC3DRyVeqEbKCqp?=
 =?iso-8859-1?Q?cIEUyp1iSK58mGAxhwwLmHTxWWvWPBCCj11Cmn3X0aYVhdrvwDavQ12/ml?=
 =?iso-8859-1?Q?pWsoo+TISqM/8kJkLhQptjyqMVwekxHIOq/4W9HmZB8WaemSx9L8J750Fm?=
 =?iso-8859-1?Q?muynWrblhEMfuP5YF7XX5DGhjlsXOjyKYvGM1bjDtn7fM4igvXr4STKmWK?=
 =?iso-8859-1?Q?J2Pfa1LM5m16Z97p5v83yeqsJKbb5wSaJXvtbPl/77BuvUg44bLhaiwAsO?=
 =?iso-8859-1?Q?I7bB0gX1SBJXeOnnlYOjqpsjaTEcYyPUJQ42w/CUx+EW38FUf1otJaR/+r?=
 =?iso-8859-1?Q?yNXA38ykrXsOunJL+Q1i4drGGoqPzR6CO3rerkgWcmf1jdO0jDt8kKcias?=
 =?iso-8859-1?Q?zKtmcFP33vW+W2WQQPC/l2497e0fllAttLgo6Od5j2w9fzCq9MYPaSkgXa?=
 =?iso-8859-1?Q?MsLfdCdrHARgMp/WaF3OujkWR8wVMilslcGM1t36dvgf2Gf5G3AdOvHFNn?=
 =?iso-8859-1?Q?obFGc43w4upUaMxfCxq33QGBLs7ZqjOtmlWtVNouclAij5Stkt3jTlJ+we?=
 =?iso-8859-1?Q?JRymgsQ3Nx3aO8IsEb166u4B2sYu9GlsVkRGLmT7j8a1Yc45Er+l/5y1i+?=
 =?iso-8859-1?Q?XfhsNrH7rWxJi/KaIMqEZuF26bAG5pIiyqhWlsZjmN4AzG4mXGWkYe0NKY?=
 =?iso-8859-1?Q?xL3argT7VkTttx0mLlrM3JzKYODlR6c4KEM2l5ViB5+WK/cA7JuZwPsPAm?=
 =?iso-8859-1?Q?yq6MQJpL0+1WcEOK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kWCUWx+Qr/lj4q9q1pZu4xiB/MVttmD69oN7PBSSuv83wRnROXOiXqYhmB?=
 =?iso-8859-1?Q?HmbJmlbVPe+bN8fnvuOMJYRrUvROXQoslgHG1jjfHwUn5s7EQLk9BUk0E9?=
 =?iso-8859-1?Q?bdLoe18m7XrKfX9MD3LRF3/0eNBbmH+dN9iQri3RjtuXHcSz/XTH/ccBc/?=
 =?iso-8859-1?Q?lxZp2zi4tqV/w4mHAWrv0EwxcKhL8Reg/gnikowSimEAydb6KAlc4OuWTs?=
 =?iso-8859-1?Q?/o3TjX8+k0oFfjnd9Ar44MhOZO7WnsCzHtUy9jRj8JXRHTVW0t4iexDc2h?=
 =?iso-8859-1?Q?A5GJAUviJbBw/p6PnLQ4D552L9g9Co2NhtQkXvSBRU1zEinLoLTFXTz0CW?=
 =?iso-8859-1?Q?IvL/gokfxuTk6jstjKmUF63/iALda4si1NGYvnA2V7C7cbPI0chFacRwJ2?=
 =?iso-8859-1?Q?CIX70f/njagyklCynjK+V46lxsp1auMDj801QWS+3Ql9EVOhUnw5yUANON?=
 =?iso-8859-1?Q?xZHjtFVku8PwDO1u29ytQKLyLfNXsoFhikhBriONtWNAQc6CFYiFvoRRhu?=
 =?iso-8859-1?Q?x80CkhQxh7oDRkd4VIZPS/NWUfwuew9b+vDDBi4kN6PkkUFy/tKv++d46p?=
 =?iso-8859-1?Q?+6ygcXH98eQ9qL73m6JCyhopAQx3YCcsKnExxWOGa/F/Moo/L13mT4RXWF?=
 =?iso-8859-1?Q?zg2GyksG0kwTNKbteQnlNTT9mCAebpNqDiOuKT5VFEoymDl0TxvuFlcBt+?=
 =?iso-8859-1?Q?xoOE9Z91Ysb/m6V+7cTtX1j5zhPx8t8RMc6y48MkwSvLY3owIcOZ/ycxNc?=
 =?iso-8859-1?Q?0xCg30dcS4LJESCFIHUvzlQ6jh92EbhDdvkCSJAz2CaHGnFjMPLDkbCAue?=
 =?iso-8859-1?Q?EjkB49ozxWkoIcZEjNVEHcQPm2XDummhWkIC2TzUIohEx5YNRMv/H/b53V?=
 =?iso-8859-1?Q?H9ZzETQkGBmCnf+2rPBlIYQI1ei6Ip/cUycjAbQCYUG6ISxiJh7DjaANsO?=
 =?iso-8859-1?Q?OCIHMUWwN2xbMxre66pwHv4YCGAtIsjobTV+HmllQkEbe6lXCiNgg5BYdP?=
 =?iso-8859-1?Q?tupADay2RVaNt+WQhL75lhkDFNEjXvOHc4s/77QCG6b7IjkvFSHx4quxqu?=
 =?iso-8859-1?Q?QS53Lqy3HNBrdv1LM2be1BXIj0zGB+bES9D7gYl0DRMPlHdAo09fDzoB+l?=
 =?iso-8859-1?Q?St6oOcqxQ24ZtHPLCLi7OUoJH9bmaouUkSQKCthEHFkzaG1Ubi9VNL8rMV?=
 =?iso-8859-1?Q?9Ja3j+EtzZbvTccX4gl0pMpZwHbnxjzcqgFuMm9+QEXDro1uHtOra5TtSp?=
 =?iso-8859-1?Q?kcMdpWNj5+Ic8gXDtqJcn4W6ExZE2DS6krQlmUMIu/NSrCAfTZEyqAMiGJ?=
 =?iso-8859-1?Q?70YV5ltqnHUw74eDa5fo0hnSxv1MWma8hTOzYo7fUAIwvg48uSmFsmjDNo?=
 =?iso-8859-1?Q?g/M4126Wfp5MhjkdiwcoD+5Eh86D+7/O8a1gMCH74tP9dRJotGa0OFS+D9?=
 =?iso-8859-1?Q?Zx31LYhwbW5MdtOx0TR+iubJxOyDyfOGEz8SOeDnOwSELRM0a4c5tNIt42?=
 =?iso-8859-1?Q?fmKKFw39LWzEc9YslqJoddLimSA03R7ornnmGFB0Z6lumaDfp38nRIEc6M?=
 =?iso-8859-1?Q?ypxJQzBVtivNWwcfSmBpTDApWSkuSAXjqOjAE/m+IQps1MSIgDq21TjW4r?=
 =?iso-8859-1?Q?KVPqp5Y4e/jtMWzqNG7a+nojb+HPGSjlOmfaMKJVXS/ElZhJN9Yva3gA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd117f4c-1535-4ead-05f5-08ddfcd85d0b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:40:36.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qai4STY8g4IFhQWzfpAFIWYeIBt0U0Y/NGnb1xVR2nEgCRJMEUS7i2KD4yLkVw1rkHasKlUdTXdOYVF1GzVjAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 200.0% improvement of netperf.Throughput_Mbps on:


commit: 6471658dc66c670580a7616e75f51b52917e7883 ("udp: use skb_attempt_defer_free()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 50%
	cluster: cs-localhost
	test: UDP_STREAM
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250926/202509261609.dec14b91-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/50%/debian-13-x86_64-20250902.cgz/300s/lkp-srf-2sp3/UDP_STREAM/netperf

commit: 
  3cd04c8f4a ("udp: make busylock per socket")
  6471658dc6 ("udp: use skb_attempt_defer_free()")

3cd04c8f4afed71a 6471658dc66c670580a7616e75f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 6.079e+09 ±  4%     +47.8%  8.983e+09        cpuidle..time
 4.012e+08          +320.9%  1.689e+09 ±  2%  cpuidle..usage
   9360404           +22.3%   11449805 ±  4%  numa-meminfo.node1.Active
   9360396           +22.3%   11449799 ±  4%  numa-meminfo.node1.Active(anon)
   8894257 ±  3%     +22.2%   10867440 ±  3%  numa-meminfo.node1.Shmem
 1.044e+09 ±  3%    +206.8%  3.203e+09        numa-numastat.node0.local_node
 1.044e+09 ±  3%    +206.8%  3.204e+09        numa-numastat.node0.numa_hit
 1.013e+09 ±  2%    +218.0%  3.221e+09        numa-numastat.node1.local_node
 1.013e+09 ±  2%    +218.0%  3.221e+09        numa-numastat.node1.numa_hit
      9.93 ±  5%      +4.4       14.28        mpstat.cpu.all.idle%
      0.59            +1.3        1.89        mpstat.cpu.all.irq%
      1.77           +12.4       14.15 ±  2%  mpstat.cpu.all.soft%
     86.78           -18.8       67.94        mpstat.cpu.all.sys%
      0.93            +0.8        1.74        mpstat.cpu.all.usr%
 1.044e+09 ±  3%    +206.9%  3.204e+09        numa-vmstat.node0.numa_hit
 1.044e+09 ±  3%    +206.9%  3.203e+09        numa-vmstat.node0.numa_local
   2339319           +22.4%    2863299 ±  4%  numa-vmstat.node1.nr_active_anon
   2222754 ±  3%     +22.3%    2717697 ±  3%  numa-vmstat.node1.nr_shmem
   2339318           +22.4%    2863297 ±  4%  numa-vmstat.node1.nr_zone_active_anon
 1.013e+09 ±  2%    +218.1%  3.221e+09        numa-vmstat.node1.numa_hit
 1.013e+09 ±  2%    +218.1%  3.221e+09        numa-vmstat.node1.numa_local
   9763805 ±  3%     +21.6%   11869079 ±  3%  meminfo.Active
   9763788 ±  3%     +21.6%   11869062 ±  3%  meminfo.Active(anon)
    805138           +15.5%     929863        meminfo.AnonPages
  12584871 ±  2%     +15.7%   14565534 ±  2%  meminfo.Cached
   9930753 ±  3%     +21.2%   12038335 ±  3%  meminfo.Committed_AS
  16167194           +14.9%   18577687 ±  2%  meminfo.Memused
   8962742 ±  3%     +22.1%   10943457 ±  3%  meminfo.Shmem
  16392623           +14.4%   18753189 ±  2%  meminfo.max_used_kB
     38913          +200.8%     117050        netperf.ThroughputBoth_Mbps
   3735655          +200.8%   11236826        netperf.ThroughputBoth_total_Mbps
     18515          +201.7%      55862        netperf.ThroughputRecv_Mbps
   1777441          +201.7%    5362763        netperf.ThroughputRecv_total_Mbps
     20398          +200.0%      61188        netperf.Throughput_Mbps
   1958214          +200.0%    5874063        netperf.Throughput_total_Mbps
  88004812 ±  8%     -78.3%   19110782 ± 18%  netperf.time.involuntary_context_switches
     41333           +18.4%      48917        netperf.time.minor_page_faults
      9067           -24.1%       6883        netperf.time.percent_of_cpu_this_job_got
     27208           -25.1%      20391        netperf.time.system_time
    158.64          +115.0%     341.02        netperf.time.user_time
 2.139e+09          +200.8%  6.433e+09        netperf.workload
   2441370 ±  3%     +21.6%    2967589 ±  3%  proc-vmstat.nr_active_anon
    201274           +15.5%     232430        proc-vmstat.nr_anon_pages
   6049392            -1.0%    5989283        proc-vmstat.nr_dirty_background_threshold
  12113577            -1.0%   11993210        proc-vmstat.nr_dirty_threshold
   3146655 ±  2%     +15.7%    3641743 ±  2%  proc-vmstat.nr_file_pages
  60865222            -1.0%   60263229        proc-vmstat.nr_free_pages
  60728673            -0.9%   60156480        proc-vmstat.nr_free_pages_blocks
   2241122 ±  3%     +22.1%    2736223 ±  3%  proc-vmstat.nr_shmem
     43088            +2.6%      44210        proc-vmstat.nr_slab_reclaimable
   2441370 ±  3%     +21.6%    2967589 ±  3%  proc-vmstat.nr_zone_active_anon
     46931 ± 26%   +1165.5%     593929 ± 21%  proc-vmstat.numa_hint_faults
     35701 ± 34%   +1506.1%     573389 ± 22%  proc-vmstat.numa_hint_faults_local
 2.057e+09          +212.3%  6.425e+09        proc-vmstat.numa_hit
 2.057e+09          +212.3%  6.424e+09        proc-vmstat.numa_local
     10954 ±  3%     +77.0%      19391 ±  2%  proc-vmstat.numa_pages_migrated
     95835 ± 35%    +588.2%     659561 ± 20%  proc-vmstat.numa_pte_updates
 1.641e+10          +212.8%  5.132e+10        proc-vmstat.pgalloc_normal
   1186751           +45.6%    1727586 ±  7%  proc-vmstat.pgfault
 1.641e+10          +212.8%  5.132e+10        proc-vmstat.pgfree
     10954 ±  3%     +77.0%      19391 ±  2%  proc-vmstat.pgmigrate_success
     48468            +7.4%      52040        proc-vmstat.pgreuse
 1.689e+10          +108.1%  3.514e+10        perf-stat.i.branch-instructions
  38251661          +111.9%   81050915        perf-stat.i.branch-misses
      0.92 ± 45%      +3.6        4.57 ± 41%  perf-stat.i.cache-miss-rate%
   5.1e+09           -84.4%  7.944e+08 ± 13%  perf-stat.i.cache-references
   3325973 ±  2%    +251.7%   11696843 ±  2%  perf-stat.i.context-switches
      6.70           -56.4%       2.92        perf-stat.i.cpi
 5.565e+11            -3.1%  5.393e+11        perf-stat.i.cpu-cycles
      2315 ± 14%   +1249.5%      31253 ±  9%  perf-stat.i.cpu-migrations
 8.352e+10          +121.5%   1.85e+11        perf-stat.i.instructions
      0.15          +124.3%       0.34        perf-stat.i.ipc
     17.32 ±  2%    +251.7%      60.92 ±  2%  perf-stat.i.metric.K/sec
      3553           +50.1%       5334 ±  8%  perf-stat.i.minor-faults
      3553           +50.1%       5334 ±  8%  perf-stat.i.page-faults
      0.62 ± 68%      +3.8        4.40 ± 41%  perf-stat.overall.cache-miss-rate%
      6.66           -56.2%       2.92        perf-stat.overall.cpi
      0.15          +128.5%       0.34        perf-stat.overall.ipc
     11795           -26.6%       8659        perf-stat.overall.path-length
 1.683e+10          +108.1%  3.502e+10        perf-stat.ps.branch-instructions
  38128826          +111.9%   80783216        perf-stat.ps.branch-misses
 5.083e+09           -84.4%  7.918e+08 ± 13%  perf-stat.ps.cache-references
   3315367 ±  2%    +251.7%   11658619 ±  2%  perf-stat.ps.context-switches
 5.547e+11            -3.1%  5.375e+11        perf-stat.ps.cpu-cycles
      2310 ± 14%   +1247.8%      31146 ±  9%  perf-stat.ps.cpu-migrations
 8.326e+10          +121.4%  1.844e+11        perf-stat.ps.instructions
      3534           +50.0%       5302 ±  8%  perf-stat.ps.minor-faults
      3534           +50.0%       5302 ±  8%  perf-stat.ps.page-faults
 2.523e+13          +120.8%   5.57e+13        perf-stat.total.instructions
  26243720           -28.6%   18749089        sched_debug.cfs_rq:/.avg_vruntime.avg
  28003592           -25.9%   20752934 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
  25141866           -32.7%   16920920        sched_debug.cfs_rq:/.avg_vruntime.min
      0.30 ±  4%     +26.3%       0.38 ±  2%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.30 ±  4%     +28.8%       0.38 ±  2%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    209424 ± 34%    +169.4%     564215 ± 12%  sched_debug.cfs_rq:/.left_deadline.avg
   2071516 ± 26%     +50.9%    3126519 ±  6%  sched_debug.cfs_rq:/.left_deadline.stddev
    209420 ± 34%    +169.4%     564200 ± 12%  sched_debug.cfs_rq:/.left_vruntime.avg
   2071477 ± 26%     +50.9%    3126440 ±  6%  sched_debug.cfs_rq:/.left_vruntime.stddev
  26243720           -28.6%   18749089        sched_debug.cfs_rq:/.min_vruntime.avg
  28003592           -25.9%   20752934 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  25141866           -32.7%   16920920        sched_debug.cfs_rq:/.min_vruntime.min
      0.27 ±  3%     +24.1%       0.33 ±  2%  sched_debug.cfs_rq:/.nr_queued.stddev
    209420 ± 34%    +169.4%     564200 ± 12%  sched_debug.cfs_rq:/.right_vruntime.avg
   2071477 ± 26%     +50.9%    3126440 ±  6%  sched_debug.cfs_rq:/.right_vruntime.stddev
    209.56 ±  6%     +32.0%     276.63 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    192.89 ±  5%     +31.7%     253.94 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    819031 ±  3%     -65.5%     282924 ±  8%  sched_debug.cpu.avg_idle.avg
      4756 ±  2%     -37.0%       2995 ±  2%  sched_debug.cpu.avg_idle.min
   1084177           -55.0%     487973 ± 11%  sched_debug.cpu.avg_idle.stddev
    740.98 ± 24%     +55.0%       1148 ± 24%  sched_debug.cpu.clock_task.stddev
      2338 ±  5%     +22.8%       2872        sched_debug.cpu.curr->pid.stddev
    742501 ± 19%     +46.3%    1085919 ±  5%  sched_debug.cpu.max_idle_balance_cost.min
    106154 ± 12%     -44.8%      58635 ±  9%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 17%     -20.6%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      0.31 ±  5%     +24.8%       0.39        sched_debug.cpu.nr_running.stddev
   2579918 ±  2%    +252.5%    9093241 ±  2%  sched_debug.cpu.nr_switches.avg
   3594985          +181.0%   10103415 ±  4%  sched_debug.cpu.nr_switches.max
   1042225 ± 52%    +546.5%    6737845 ± 14%  sched_debug.cpu.nr_switches.min
    135.08 ± 23%     -24.8%     101.56 ± 18%  sched_debug.cpu.nr_uninterruptible.max




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


