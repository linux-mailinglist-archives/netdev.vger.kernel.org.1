Return-Path: <netdev+bounces-138088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB09ABE14
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25C91F2359C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F5145323;
	Wed, 23 Oct 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwrCUF2o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5E136338;
	Wed, 23 Oct 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662007; cv=fail; b=XQ/dkgh0L55pTQ2Ob0yktBjKaNIuVcoqeMCx2mTS1KKfPejm0n1UYJqcnIqn+RgmrdUX/HUfquV4HZnqvfRSWn0AJgzSH2G7E6ubiRv+sxFz+2nMV+c9n1MuNoVf5eztBbQoc+WlOtdgkLcaTYbLnQW6eYvC97chAuAQAgdHytY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662007; c=relaxed/simple;
	bh=mGsmGg3E9ySka06ewsAL88+HIPp3be1BliJfHSIv9j8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IEEgIUIB7lrEwCYtdq/2U+W1fZSWVrg+lO+zhbejK88wjG5AbkHS/Kby61cWQtNoNW/UMBpj4CPrRberAdypwdLj1hczmBI9I2RpvonKrzQ/lHP4dlsrNleODtTeo/4vxe2n3nql6UWMbJ3YdTVX4N+d7V4alwJ2JaV4SNmg8UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwrCUF2o; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729662000; x=1761198000;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=mGsmGg3E9ySka06ewsAL88+HIPp3be1BliJfHSIv9j8=;
  b=MwrCUF2opcIygF9rdqQjLAKBPkBId4eh9KoIGoH1NE6JNZkqWkXlu2Hy
   XONez4sycBOZjr/UxS4ltbte/aYv5i/Zde0cqzxLsartxY2ZG0nZs8L6Z
   8lAvbM1ZpMjeoHalN/ekjtFHOcKxshj2Sx9aUY4iwPlssNq6YxKf1/AJr
   7eOeKhTydRqF/Jvl1ug7XanSWjdIZR3ohS1eT5JRqUbTP475qT9PCrbB3
   ft6jCq2jVdwcwhr5jCxMxcD/V9Ode9juDALaDXnUmwzqpg9v2XpdM044m
   zcwuKiCiEct077wLfndeIXlV+eNykx7UPX0I860i3SgfyN8njuzqVmR2z
   g==;
X-CSE-ConnectionGUID: hMJ9r0WcQkeXrF6qf7ctzw==
X-CSE-MsgGUID: AbByhAcYS9iggb8XfWvEgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51772058"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51772058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:39:59 -0700
X-CSE-ConnectionGUID: LCgXAYj5TeGcUz4UWzhd5g==
X-CSE-MsgGUID: SSDcMjJMQC2mNp3WGvxn2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84877834"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 22:39:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 22:39:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 22:39:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 22:39:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 22:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GA3eKpDhhvMTUCPQgMpfRo1fYmnMLLBjuvHbwL/Bs4uhK9YktOLdy+zHQ3g1HB9qmi1YBVfgkKf5Cy83Zl4Bw3asg2FwksByjpJBqZlZ6aY2rmZhtjzznMHlGTULBM/hGIerCuPr9wLH69NXbUwuDfTCM5HtZftIB7RcKqrYRpMuvg3qpfCTrCeo/bI2XHPiM+jrqBQSGAklyM6phKssQFSmbuMmAzjJQMyFw9XpxhH9CDNFsPc7vLmWePwqWz4td1+kSQ9v26qwIb0gNSzB34DN3ZcXGm0IK9AsD/QSn/L5mlHkarGAwU1/Do5i8DiPSgj0idqWiLjAbSejTJ/f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f81Vco7q62rZz8eFee/aoU/SzVMwcMQgN3Cxd5JFca8=;
 b=t7/OjAun6fl1zIBSW97o4eUNR+mgO+gk2viV7WyH+uuX/Yb3PaiTrLzuH96g8O/c0XjWShYLK3nnT1gIde+D8H/arHwYkaDOWRgPCkn4geIoxtYL/l7u29MhWPZr8z9OKpyGB7HWLHjhCUS95OEfi09NMy04ggdNGWrgNjmQqKpV2kOof1a56T+w1snny9RgHQVdzS2X9a1LpTg0jfSVgh08PaFrf7smIwOLLjxJxlbpWSo+UyHqsQS2PGID4NYCz+O0ixQd8/vciIq/qWb/wlS/okydSVBXadiv6et3EuQa9TLb0yUQvwoFYDmxMhuHpjuj10FXrC8ayMNgZk6OmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 05:39:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 05:39:48 +0000
Date: Wed, 23 Oct 2024 13:39:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>, Xin Long
	<lucien.xin@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [net]  ac888d5886:
 stress-ng.icmp-flood.sendto_calls_per_sec 44.6% improvement
Message-ID: <202410231338.ff7580ab-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7df9f2-f9f0-434e-d857-08dcf3251af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?k8pao8OzwVecTX35tqE5bf8FUxWrl4jVS/b4AopQrR/tCkeik2wfkjVybh?=
 =?iso-8859-1?Q?rlzX9RLhWyPEYVlw6uFfDMNQHxrZffc8FXFCUwh7zXgt4Y7khtGcHZg6dF?=
 =?iso-8859-1?Q?k6L6dqNvLOOVwmIgtES8MgXVDGJ4IXrPByJDGbzIiMaC+a2CcaF4WyHobT?=
 =?iso-8859-1?Q?SQRp5KM+R0tWMN7eqivHKG2V9bBF8NIZ5rKI30EArUHXc3wORQ4HdqDfRn?=
 =?iso-8859-1?Q?MRrgb91UPV2ISPbQMtwF+7981ZYdFvlQKMM/Z0ybEXpz1KSeRwGjENc5T3?=
 =?iso-8859-1?Q?wGQqjwXSWswFwcb2pZJShGRAX+NABjVLM0q5XMifKxjFKuz9ypSKwyGSL2?=
 =?iso-8859-1?Q?sMDXlhBf0inxjtLPkGbnitC65tNMZM4TauTxXdTIrZTLEdzU0u0NCOTPIa?=
 =?iso-8859-1?Q?LM4+R9d8k78uIgpHFILR9/ZiObTmLz0Rr40RVYijKjyq5RO0YrILlHRMUn?=
 =?iso-8859-1?Q?98/zAo0Hfy12PXlwCLTDuws0jdGOsacil/oTIREZmGFvVLcbnRn+JfAlrh?=
 =?iso-8859-1?Q?uFAQjYNPy/1SQeoFp8dGuvmNiwU+wTxX5Iww3c05NZM+/jRCfmuXZeQnVk?=
 =?iso-8859-1?Q?XAJaEBVTfQf2bORU0PPpUgGyOCuVkuGZKFTNvMRaAoxyt9TLQhx0oVZesy?=
 =?iso-8859-1?Q?CHj5SXDP1vF3x64N8f+ftMJ2+4N4Wu2uRmp5bcJsmGd3nVzJnhrzSgSVT3?=
 =?iso-8859-1?Q?9F85GB3dTqkaxf6burt58TvMvjAOwEhtgIZ22GXQoGkNOgJqGCpVXrnpyi?=
 =?iso-8859-1?Q?bqTxgnuIKGZLKK93BJhvrFDTgUKkmimmal9Th3xqdYuZRYCz2LgqJut/Z4?=
 =?iso-8859-1?Q?MB4QowuS65ztgyTchRf42Lrob5RvULvxzioIHDUTa7bz2VXkgQT3WCk6oW?=
 =?iso-8859-1?Q?gu37mVBNfKXdAljvQioUSFtwOF4Gn1apjIJTyWnTuE+IbhUs/OrOd8t8Sy?=
 =?iso-8859-1?Q?11Mrk/iIllgEu/cbfgq08m5NCWO01qOx2yK7nfEdspjo8pSRUbLEy/kmID?=
 =?iso-8859-1?Q?G+iNwZPXU1wajwY6AdE6ID8xIPZUXjY1JIhgXgx/exXfUb5hs2jaZYQgsJ?=
 =?iso-8859-1?Q?qpu6HEUC+Njc+LRVbSC+EePByPC5JXS0Jw+1eXCQgTyqONGQj861wZLzDg?=
 =?iso-8859-1?Q?Hus9QjeuGSJQShyPE+z05VSpb5yeOZcsatqua/nWhyVNwS9zs2/tSzQdsV?=
 =?iso-8859-1?Q?dYGh5nJ+7rOjdH3wyf+dFr1LAQ180HAlyBXrasR0KkAuPm7Oo1KYo/0htj?=
 =?iso-8859-1?Q?3KvmauULSZPTKbaYgWIaT6rVgX7yivEEhdLk5/2frQpY+4scfUrylx9h34?=
 =?iso-8859-1?Q?K+UZnKSjEnrazvFdNzad3h0NNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?V5mxSE0A/cCPERLbbpApoi4dtOtFuhIVDjbGYuxRt4zwwr4iKGQxTRS8b6?=
 =?iso-8859-1?Q?UAsGVofImbgaThbXOPaV42lLUJPsuon+kRFWAeX+/xM4UZVW9TBaFSTOi5?=
 =?iso-8859-1?Q?AaBMlH20Ih8MgkDU2Bu18YxwB4b3YVUrYpuVtco3F0PIhHOVU7fIQheKc5?=
 =?iso-8859-1?Q?sFtgE/a56W3sieC9DHd74hcenr83FX2sNSzFFXfGcZroqwmf8ZNy1hQpEl?=
 =?iso-8859-1?Q?C2kizrFXimrOnWA0/SPr+3G9/qziCKlWgXEeashm7nLdsEnojLuYitp68x?=
 =?iso-8859-1?Q?gJje41igK/X8jy7PBoZGDOu2IyGRE7wHfB70O6GbYji6MGBKLSb91PyyeZ?=
 =?iso-8859-1?Q?8TseNX39P4gdfXLGa8fXGez2lofjw9IVfhbsEqHwXgE3ec71krtaV9NVj/?=
 =?iso-8859-1?Q?wE6j8y+gaKRX/KFLDup0UKhRLwRYYnoX9tDNHS+6WwyngkFvcZ80UGccF5?=
 =?iso-8859-1?Q?fjo4SSV+zacNlupYDD7gIkZwW6uWJ44F1/PtrOwnvThclLdaNc3HkEI+OX?=
 =?iso-8859-1?Q?b8R3ViCEp35I33YHpfwuLGvUGuwzr5cQCUeumyuxhUupRqs8LwaRui2/xF?=
 =?iso-8859-1?Q?9JoVWAb+L8yk4AZLJTAj1cDqhLXam/jKt5eUdpMOML/ULIver//2DQ7b8o?=
 =?iso-8859-1?Q?bCNm8Gh4NHo5dYmODkgqVIRPI2flbo33TVa6YzVM+8wBcu1lYv0+dkInKw?=
 =?iso-8859-1?Q?aucK+08n/lHdND5Qv1OQ4h4cEoUIx572KT850Da87L+DdclRtEHjLnQbKU?=
 =?iso-8859-1?Q?MR6HF1C5FP/WffEFtwnlD65nCIWpdXnXuypCuKpXtnWI4gn9rSZr3CN2fa?=
 =?iso-8859-1?Q?Fh3DW1gCK8U0/wOtEhPL1Sp4sgYU+uPv+4iZT44ENr7aDeJimEjpyn2rB3?=
 =?iso-8859-1?Q?joN58PM5cdLuyO0Vo/TU5OlSLVo7azyz+JP7ZjNwiuPJXZsOrmT1unhmPF?=
 =?iso-8859-1?Q?dVj4yNOsSMf8/WQjHTzWccIdI3BbGUtkPd6Fkdg/PJF7wUxDw2y/lH6APV?=
 =?iso-8859-1?Q?HXK4/1Ro0WR2a5wPsmB18w6yYTQbdfUwaGIZUNvvOhadkHBZZbUfs7bQ8S?=
 =?iso-8859-1?Q?gC2WY+qjIHqm+du7OpnVTg8yUfNljkS+wKwkXu+tgKYRvQIums5+3wSvT9?=
 =?iso-8859-1?Q?3TXzDr/kYrkYXOPNCImbMaWH5BuheUtr3XAWmjHP16gefkH7waK2j1E9mQ?=
 =?iso-8859-1?Q?UGsK/sKtGdAH6EXhtx8ugB/oHmfM3ldKAPil1VuQTS7W6sZR+yfYvesJRh?=
 =?iso-8859-1?Q?SETy5eddWAVNi0N+yQOZxCsuLx2t1lNNiBzVF5xXDfqAZ5NezTgEVuC8e1?=
 =?iso-8859-1?Q?LJilZAFsusYiU1pVcCXZbLPC5ShEzFxq8AKXA3KiVl7MpvdMh5dFUA5tqD?=
 =?iso-8859-1?Q?PUzGFhFVSZTFo781+Sj4tJSCWiujR46MpSfn2NPUHFaApfKDp3NpMJzke7?=
 =?iso-8859-1?Q?nOGKHbBbAAwtgXIZ0b8Fxgb/6IcM5scuopGd/965JyvSZdlekLBf9CFYtB?=
 =?iso-8859-1?Q?Cl/Cj1V8uz67WfQwLrEe3Qa8jJjK+GaL6eIVccU5FYvOTspvEsdtlOUUOJ?=
 =?iso-8859-1?Q?/9Xo9lqc2aJ8b1hl/4KhyaovhW/8biLSfsGLYt9E/+0k5U8QyiijQKlH2p?=
 =?iso-8859-1?Q?19yHV0WIezR23gDkfoeKDotWebXy1Sq8MfguYqhtjx80m6XljIFBdoBw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7df9f2-f9f0-434e-d857-08dcf3251af8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:39:47.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqT2VaQZMKU1SqXU+cUQTAgfxhQgasuyQ7sUProGbbexbXqYaBcGsVwR2ZtcuKoJqF/l6rMRizkYtvtyJ5JL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 44.6% improvement of stress-ng.icmp-flood.sendto_calls_per_sec on:


commit: ac888d58869bb99753e7652be19a151df9ecb35d ("net: do not delay dst_entries_add() in dst_release()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: icmp-flood
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.icmp-flood.sendto_calls_per_sec 51.2% improvement                    |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=icmp-flood                                                                           |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.udp.ops_per_sec 20.8% improvement                                    |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=udp                                                                                  |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241023/202410231338.ff7580ab-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/icmp-flood/stress-ng/60s

commit: 
  a354733c73 ("Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue")
  ac888d5886 ("net: do not delay dst_entries_add() in dst_release()")

a354733c738d905e ac888d58869bb99753e7652be19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.32            +0.1        0.42 ±  7%  mpstat.cpu.all.irq%
    296.91 ±  2%     -19.9%     237.93        vmstat.procs.r
    390079 ±  4%     +19.2%     465148 ± 10%  numa-meminfo.node0.SUnreclaim
    364275 ±  4%     +17.4%     427590 ±  8%  numa-meminfo.node1.SUnreclaim
    754901 ±  2%     +18.2%     892412 ±  3%  meminfo.SUnreclaim
   1117999 ±  2%     +16.2%    1298993 ±  2%  meminfo.Shmem
    924736           +14.9%    1062835 ±  3%  meminfo.Slab
   4256286 ±  7%     +56.6%    6663464 ± 19%  numa-numastat.node0.local_node
   4443038 ±  7%     +52.4%    6770636 ± 19%  numa-numastat.node0.numa_hit
   4881798 ±  5%     +53.9%    7515513 ± 13%  numa-numastat.node1.local_node
   4959806 ±  5%     +54.7%    7673941 ± 13%  numa-numastat.node1.numa_hit
      5013 ± 10%     -76.6%       1175 ± 17%  perf-c2c.DRAM.local
     10585 ±  7%     -86.9%       1388 ± 20%  perf-c2c.DRAM.remote
      6368 ±  7%     -88.8%     715.33 ± 20%  perf-c2c.HITM.remote
     19990 ± 15%     -31.9%      13604 ± 24%  perf-c2c.HITM.total
     13.11           +44.6%      18.95 ±  8%  stress-ng.icmp-flood.MB_written_per_sec
 4.012e+08           +46.5%  5.877e+08 ±  7%  stress-ng.icmp-flood.ops
   6686652           +46.5%    9794614 ±  7%  stress-ng.icmp-flood.ops_per_sec
     25994           +44.6%      37596 ±  8%  stress-ng.icmp-flood.sendto_calls_per_sec
    222490 ±  2%     -17.1%     184342 ±  5%  stress-ng.time.involuntary_context_switches
     96881 ±  3%     +21.0%     117223 ± 11%  numa-vmstat.node0.nr_slab_unreclaimable
   4442908 ±  7%     +52.4%    6771347 ± 19%  numa-vmstat.node0.numa_hit
   4256156 ±  7%     +56.6%    6664174 ± 19%  numa-vmstat.node0.numa_local
     90585 ±  5%     +19.5%     108272 ±  8%  numa-vmstat.node1.nr_slab_unreclaimable
   4959435 ±  5%     +54.7%    7673890 ± 13%  numa-vmstat.node1.numa_hit
   4881426 ±  5%     +54.0%    7515463 ± 13%  numa-vmstat.node1.numa_local
   1061425            +4.2%    1106394        proc-vmstat.nr_file_pages
    280337 ±  2%     +16.0%     325304 ±  2%  proc-vmstat.nr_shmem
    187078           +20.0%     224554 ±  3%  proc-vmstat.nr_slab_unreclaimable
   9405166           +53.6%   14447110 ±  7%  proc-vmstat.numa_hit
   9140406           +55.2%   14181510 ±  7%  proc-vmstat.numa_local
  17314887           +57.6%   27283641 ±  7%  proc-vmstat.pgalloc_normal
  16733034           +58.0%   26431950 ±  8%  proc-vmstat.pgfree
 1.539e+08 ±  5%     -92.6%   11349148 ± 68%  sched_debug.cfs_rq:/.avg_vruntime.avg
  57665563 ± 10%     -97.9%    1238574 ± 74%  sched_debug.cfs_rq:/.avg_vruntime.min
    352.28 ± 45%     -83.7%      57.25 ± 44%  sched_debug.cfs_rq:/.load_avg.avg
      8542 ±191%     -91.0%     766.75 ± 28%  sched_debug.cfs_rq:/.load_avg.max
    820.51 ±172%     -86.1%     114.42 ± 32%  sched_debug.cfs_rq:/.load_avg.stddev
 1.539e+08 ±  5%     -92.6%   11349155 ± 68%  sched_debug.cfs_rq:/.min_vruntime.avg
  57665568 ± 10%     -97.9%    1238574 ± 74%  sched_debug.cfs_rq:/.min_vruntime.min
    844.23 ±  6%     -46.6%     450.55 ± 54%  sched_debug.cfs_rq:/.runnable_avg.avg
      2415 ± 16%     -42.9%       1379 ± 18%  sched_debug.cfs_rq:/.runnable_avg.max
    307.01 ± 24%     -48.4%     158.29 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1422 ± 14%     -28.7%       1014        sched_debug.cfs_rq:/.util_est.max
     94326 ±  6%     +28.4%     121148 ± 15%  sched_debug.cpu.avg_idle.stddev
      0.44 ±  4%     +10.9%       0.49 ±  9%  perf-stat.i.MPKI
      0.76 ±  5%      +0.2        0.94 ± 14%  perf-stat.i.branch-miss-rate%
 1.261e+08           +28.1%  1.615e+08 ±  8%  perf-stat.i.branch-misses
  39697390           +23.3%   48966097 ±  9%  perf-stat.i.cache-misses
   1.2e+08           +21.2%  1.455e+08 ±  9%  perf-stat.i.cache-references
      6.77           -18.6%       5.51 ±  8%  perf-stat.i.cpi
      1327 ±  2%     -65.4%     458.59 ± 11%  perf-stat.i.cpu-migrations
     16492 ±  2%     -22.7%      12753 ± 10%  perf-stat.i.cycles-between-cache-misses
 9.523e+10           +19.3%  1.136e+11 ±  7%  perf-stat.i.instructions
      0.15           +24.4%       0.18 ±  8%  perf-stat.i.ipc
      0.72            +0.1        0.83        perf-stat.overall.branch-miss-rate%
      6.78           -17.9%       5.56 ±  8%  perf-stat.overall.cpi
     16226 ±  2%     -20.5%      12894 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.15           +22.6%       0.18 ±  7%  perf-stat.overall.ipc
 1.236e+08           +28.9%  1.593e+08 ±  8%  perf-stat.ps.branch-misses
  39120458           +24.6%   48746085 ±  9%  perf-stat.ps.cache-misses
 1.176e+08           +22.4%  1.439e+08 ±  9%  perf-stat.ps.cache-references
      1305 ±  2%     -65.9%     444.88 ± 11%  perf-stat.ps.cpu-migrations
 9.364e+10           +20.3%  1.126e+11 ±  7%  perf-stat.ps.instructions
 5.873e+12           +22.7%  7.204e+12 ±  7%  perf-stat.total.instructions
     23.32 ± 41%     -90.4%       2.23 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     32.49 ± 48%     -96.1%       1.26 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     27.08 ± 18%     -92.3%       2.07 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
      0.41 ± 46%    +269.7%       1.52 ± 60%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     27.93 ± 12%     -92.5%       2.10 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     23.55 ± 43%     -91.9%       1.92 ± 80%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.10 ± 18%     -93.5%       0.14 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     25.73 ±110%     -91.8%       2.11 ± 65%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      1.90 ±119%    +164.7%       5.03 ± 54%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     27.98 ± 13%     -91.1%       2.49 ± 32%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      6.25 ±144%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     15.90 ± 59%     -82.7%       2.75 ± 35%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3.52 ± 76%     -98.0%       0.07 ±105%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.16 ± 15%     -98.1%       0.02 ± 84%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.77 ± 13%     -62.1%       0.29 ± 35%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     29.09 ± 19%     -93.6%       1.85 ± 10%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.77 ± 25%     -95.7%       0.25 ± 33%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.32 ± 67%    +339.1%      23.34 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
    128.46 ± 51%     -92.9%       9.15 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
    162.40 ± 22%     -79.0%      34.03 ±103%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    156.35 ± 37%     -97.8%       3.43 ± 86%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
    202.92 ±  9%     -93.5%      13.18 ± 51%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
      2.17 ± 76%    +255.8%       7.74 ± 43%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
    234.22 ±  5%     -92.5%      17.50 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     75.02 ± 65%     -92.4%       5.71 ± 91%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     63.71 ± 66%     -95.5%       2.88 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     93.74 ± 82%     -94.2%       5.40 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
    209.83 ±  4%     -85.2%      31.11 ±126%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     13.66 ±171%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    121.57 ± 41%     -86.9%      15.91 ± 40%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     28.68 ± 58%     -97.3%       0.76 ±127%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     83.01 ± 14%     -90.9%       7.58 ±179%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     75.54 ± 51%     -87.0%       9.85 ± 92%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    244.01 ±  8%     -80.8%      46.78 ±109%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    184.22 ±  7%     -94.8%       9.60 ± 17%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     16.65 ± 13%     -93.5%       1.09 ±  9%  perf-sched.total_sch_delay.average.ms
    378.37 ± 82%     -80.7%      72.94 ± 65%  perf-sched.total_sch_delay.max.ms
      7.18 ± 21%     -44.9%       3.95 ± 34%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     55.87 ± 12%     -92.5%       4.20 ± 17%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      7.50 ±  5%     -29.2%       5.31        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     58.85 ± 19%     -92.7%       4.29 ± 10%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1237 ±  7%     +21.0%       1497 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      8547 ± 19%     -93.5%     551.50 ± 27%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.17 ±223%   +1300.0%       2.33 ± 58%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    899.33 ± 10%     -87.7%     110.50 ± 58%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    777.33 ±  3%     +40.7%       1093 ± 16%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7892 ± 16%     +64.3%      12970 ± 27%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8678 ± 12%     +87.5%      16274 ± 27%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4106 ± 32%     -75.5%       1005        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    468.43 ±  5%     -92.5%      35.00 ± 50%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1243 ±  8%     -18.7%       1011        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    562.84 ±  6%     -10.0%     506.50        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    171.01 ± 13%     -91.4%      14.63 ± 72%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.90 ±141%   +7048.8%     207.33 ±173%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
     23.32 ± 41%     -90.4%       2.23 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      6.48 ± 22%     -47.9%       3.37 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     32.49 ± 48%     -96.1%       1.26 ± 78%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     27.08 ± 18%     -92.3%       2.07 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
      0.22 ± 99%    +414.7%       1.11 ± 80%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     27.93 ± 12%     -92.5%       2.10 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     23.55 ± 43%     -91.9%       1.92 ± 80%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     25.73 ±110%     -91.8%       2.11 ± 65%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
     29.38 ± 18%     -80.8%       5.65 ± 76%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     11.21 ± 78%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      6.74 ± 26%     +87.8%      12.66 ± 62%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.34 ±  4%     -16.6%       5.29        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     29.76 ± 19%     -91.8%       2.44 ± 11%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.32 ± 67%    +567.4%      35.48 ± 87%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      4.56 ±153%   +7661.5%     354.28 ±129%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
    128.46 ± 51%     -92.9%       9.15 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      4097 ± 33%     -75.5%       1003        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    156.35 ± 37%     -97.8%       3.43 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
    202.92 ±  9%     -93.5%      13.18 ± 51%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
      1.95 ± 95%    +279.3%       7.39 ± 51%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
    234.22 ±  5%     -92.5%      17.50 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     75.02 ± 65%     -92.4%       5.71 ± 91%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     93.74 ± 82%     -94.2%       5.40 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
     20.01 ±117%    -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1122 ±  4%     -10.3%       1006        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     88.23 ± 12%     -89.5%       9.22 ± 20%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     39.10           -39.1        0.00        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs
     37.78           -37.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core
     37.71           -37.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_destroy.rcu_do_batch
     37.35           -35.3        2.06 ± 18%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     37.36           -35.3        2.07 ± 18%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     37.36           -35.3        2.07 ± 18%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     37.36           -35.3        2.07 ± 18%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     37.33           -35.3        2.06 ± 18%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     37.33           -35.3        2.06 ± 18%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     37.33           -35.3        2.06 ± 18%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     37.33           -35.3        2.06 ± 18%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     37.25           -35.2        2.05 ± 18%  perf-profile.calltrace.cycles-pp.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
     13.44 ±  9%     -12.2        1.26 ± 23%  perf-profile.calltrace.cycles-pp.__mkroute_output.ip_route_output_flow.raw_sendmsg.__sys_sendto.__x64_sys_sendto
     13.68 ±  9%     -12.1        1.56 ± 18%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.raw_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     12.61 ±  9%     -12.0        0.61 ± 56%  perf-profile.calltrace.cycles-pp.rt_dst_alloc.__mkroute_output.ip_route_output_flow.raw_sendmsg.__sys_sendto
     12.58 ±  9%     -12.0        0.60 ± 56%  perf-profile.calltrace.cycles-pp.dst_alloc.rt_dst_alloc.__mkroute_output.ip_route_output_flow.raw_sendmsg
     11.73 ± 10%     -11.7        0.00        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.dst_alloc.rt_dst_alloc.__mkroute_output.ip_route_output_flow
     10.53 ± 10%     -10.5        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_alloc.rt_dst_alloc.__mkroute_output
     10.47 ± 10%     -10.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_alloc.rt_dst_alloc
      0.66 ±  6%      +0.4        1.02 ±  9%  perf-profile.calltrace.cycles-pp.__ip_append_data.ip_append_data.icmp_push_reply.icmp_reply.icmp_echo
      0.70 ±  6%      +0.4        1.09 ± 10%  perf-profile.calltrace.cycles-pp.ip_append_data.icmp_push_reply.icmp_reply.icmp_echo.icmp_rcv
      0.74 ±  5%      +0.4        1.18 ± 10%  perf-profile.calltrace.cycles-pp.icmp_push_reply.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu
      0.00            +2.6        2.64 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.dst_destroy
      0.00            +2.7        2.68 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.dst_destroy.rcu_do_batch
      0.00            +3.0        2.97 ± 12%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.dst_destroy.rcu_do_batch.rcu_core
      0.00            +3.6        3.58 ± 12%  perf-profile.calltrace.cycles-pp.kmem_cache_free.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs
      4.12 ± 24%      +9.5       13.60 ± 48%  perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_push_pending_frames.icmp_reply.icmp_echo
     19.49 ± 13%     +15.5       34.97 ± 18%  perf-profile.calltrace.cycles-pp.icmp_out_count.__ip_make_skb.ip_push_pending_frames.icmp_reply.icmp_echo
     23.74 ± 11%     +25.0       48.77 ±  8%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_push_pending_frames.icmp_reply.icmp_echo.icmp_rcv
     24.19 ± 11%     +25.5       49.69 ±  8%  perf-profile.calltrace.cycles-pp.ip_push_pending_frames.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu
     26.03 ± 11%     +26.7       52.68 ±  8%  perf-profile.calltrace.cycles-pp.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     26.11 ± 11%     +26.7       52.79 ±  8%  perf-profile.calltrace.cycles-pp.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     60.82           +34.6       95.46        perf-profile.calltrace.cycles-pp.raw_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     61.22           +34.9       96.08        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     61.22           +34.9       96.09        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_run
     61.30           +34.9       96.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_run
     61.32           +34.9       96.27        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.stress_run
     61.56           +35.1       96.62        perf-profile.calltrace.cycles-pp.sendto.stress_run
     62.01           +35.3       97.33        perf-profile.calltrace.cycles-pp.stress_run
     37.06 ±  7%     +37.4       74.42 ±  7%  perf-profile.calltrace.cycles-pp.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     37.14 ±  7%     +37.4       74.51 ±  7%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     37.12 ±  7%     +37.4       74.50 ±  7%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     37.40 ±  7%     +37.5       74.91 ±  7%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     37.52 ±  7%     +37.6       75.09 ±  7%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     37.52 ±  7%     +37.6       75.08 ±  7%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     37.68 ±  7%     +37.7       75.36 ±  7%  perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     39.18 ±  7%     +38.5       77.66 ±  6%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.__sys_sendto
     39.18 ±  7%     +38.6       77.80 ±  6%  perf-profile.calltrace.cycles-pp.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto
     38.94 ±  7%     +38.6       77.58 ±  7%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     38.96 ±  7%     +38.7       77.62 ±  7%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc
     38.95 ±  7%     +38.7       77.62 ±  7%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg
     46.97 ±  3%     +46.7       93.65        perf-profile.calltrace.cycles-pp.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     51.12 ±  2%     -51.1        0.00        perf-profile.children.cycles-pp.percpu_counter_add_batch
     48.66 ±  2%     -44.8        3.85 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     48.45 ±  2%     -44.7        3.72 ± 14%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     39.95           -35.3        4.61 ± 13%  perf-profile.children.cycles-pp.rcu_core
     39.95           -35.3        4.60 ± 13%  perf-profile.children.cycles-pp.rcu_do_batch
     39.93           -35.3        4.59 ± 13%  perf-profile.children.cycles-pp.dst_destroy
     37.35           -35.3        2.06 ± 18%  perf-profile.children.cycles-pp.smpboot_thread_fn
     37.36           -35.3        2.07 ± 18%  perf-profile.children.cycles-pp.kthread
     37.36           -35.3        2.07 ± 18%  perf-profile.children.cycles-pp.ret_from_fork
     37.36           -35.3        2.07 ± 18%  perf-profile.children.cycles-pp.ret_from_fork_asm
     37.33           -35.3        2.06 ± 18%  perf-profile.children.cycles-pp.run_ksoftirqd
     13.50 ±  9%     -12.2        1.34 ± 21%  perf-profile.children.cycles-pp.__mkroute_output
     13.96 ±  9%     -12.0        1.95 ± 14%  perf-profile.children.cycles-pp.ip_route_output_flow
     12.60 ±  9%     -11.9        0.68 ± 34%  perf-profile.children.cycles-pp.dst_alloc
     12.61 ±  9%     -11.9        0.69 ± 33%  perf-profile.children.cycles-pp.rt_dst_alloc
      0.89 ± 10%      -0.4        0.50 ± 30%  perf-profile.children.cycles-pp.__irq_exit_rcu
      1.16 ±  8%      -0.3        0.83 ± 16%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.08 ±  9%      -0.3        0.77 ± 19%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.81 ±  7%      -0.3        0.53 ± 13%  perf-profile.children.cycles-pp.rt_set_nexthop
      0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.ipv4_dst_destroy
      0.09            +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__sysvec_thermal
      0.09            +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.intel_thermal_interrupt
      0.07 ±  5%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.sched_tick
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.siphash_3u32
      0.28 ±  2%      +0.0        0.31 ±  6%  perf-profile.children.cycles-pp.record__pushfn
      0.04 ± 44%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.07 ±  7%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.sched_clock
      0.06 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.06            +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
      0.06            +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.sock_wfree
      0.07 ±  5%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.check_heap_object
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.06 ±  8%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.fdget
      0.06            +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.sk_skb_reason_drop
      0.12            +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.08 ±  6%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.08            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.13 ±  2%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.04 ± 44%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.06 ±  9%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.kfree
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.07 ± 12%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.06            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__call_rcu_common
      0.13 ±  3%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.10 ±  5%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ±  3%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller_noprof
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.aa_sk_perm
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__ip_local_out
      0.10            +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.__check_object_size
      0.08 ±  6%      +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.dst_release
      0.11 ±  3%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp._copy_from_user
      0.08 ±  5%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.skb_release_data
      0.11 ±  3%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.08 ±  6%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.ip_rcv_core
      0.12 ±  3%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.10 ±  4%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ±  3%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.11 ±  4%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.netif_rx_internal
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.skb_put
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__build_skb_around
      0.13 ±  3%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.20 ±  5%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.11 ±  4%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.__netif_rx
      0.07 ± 15%      +0.1        0.14 ± 54%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.20 ±  4%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.19 ±  4%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.16 ±  2%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.1        0.08 ± 55%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.15 ±  8%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.stress_ipv4_checksum
      0.14 ±  2%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.skb_release_head_state
      0.17 ±  4%      +0.1        0.26 ±  9%  perf-profile.children.cycles-pp.ip_rcv
      0.23 ±  3%      +0.1        0.34 ±  7%  perf-profile.children.cycles-pp.csum_partial
      0.31 ±  8%      +0.1        0.42 ±  9%  perf-profile.children.cycles-pp.icmp_glue_bits
      0.19 ±  3%      +0.1        0.30 ±  7%  perf-profile.children.cycles-pp.stress_icmp_flood
      0.23            +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.loopback_xmit
      0.25 ±  3%      +0.1        0.37 ±  7%  perf-profile.children.cycles-pp.__skb_checksum
      0.00            +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.get_partial_node
      0.18 ±  3%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.consume_skb
      0.24 ±  3%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp.csum_partial_copy_generic
      0.28            +0.1        0.43 ±  6%  perf-profile.children.cycles-pp.__skb_checksum_complete
      0.26            +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.24            +0.2        0.40 ±  9%  perf-profile.children.cycles-pp.skb_copy_and_csum_bits
      0.06 ± 51%      +0.2        0.22 ± 69%  perf-profile.children.cycles-pp.shuffle_freelist
      0.08 ± 23%      +0.2        0.27 ± 65%  perf-profile.children.cycles-pp.allocate_slab
      0.46            +0.2        0.66 ±  6%  perf-profile.children.cycles-pp.__alloc_skb
      0.49            +0.2        0.71 ±  6%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.19 ± 23%      +0.2        0.42 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.58 ±  2%      +0.3        0.86 ±  6%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.66 ±  6%      +0.4        1.03 ± 10%  perf-profile.children.cycles-pp.__ip_append_data
      0.70 ±  6%      +0.4        1.09 ± 10%  perf-profile.children.cycles-pp.ip_append_data
      0.04 ± 73%      +0.4        0.45 ± 90%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.06 ± 16%      +0.4        0.47 ± 85%  perf-profile.children.cycles-pp.__ip_finish_output
      0.14 ± 18%      +0.4        0.56 ± 40%  perf-profile.children.cycles-pp.___slab_alloc
      0.74 ±  5%      +0.4        1.18 ± 10%  perf-profile.children.cycles-pp.icmp_push_reply
      0.20 ± 17%      +0.4        0.64 ± 36%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.7        0.67 ± 13%  perf-profile.children.cycles-pp.__put_partials
      0.13 ±  3%      +3.2        3.38 ± 14%  perf-profile.children.cycles-pp.__slab_free
      0.34 ±  6%      +4.0        4.38 ± 13%  perf-profile.children.cycles-pp.kmem_cache_free
      4.12 ± 24%      +9.5       13.61 ± 48%  perf-profile.children.cycles-pp.__ip_select_ident
     25.98 ±  7%     +22.5       48.46 ± 19%  perf-profile.children.cycles-pp.icmp_out_count
     23.74 ± 11%     +25.0       48.77 ±  8%  perf-profile.children.cycles-pp.__ip_make_skb
     24.19 ± 11%     +25.5       49.69 ±  8%  perf-profile.children.cycles-pp.ip_push_pending_frames
     26.04 ± 11%     +26.7       52.69 ±  8%  perf-profile.children.cycles-pp.icmp_reply
     26.11 ± 11%     +26.7       52.79 ±  8%  perf-profile.children.cycles-pp.icmp_echo
     60.82           +34.6       95.47        perf-profile.children.cycles-pp.raw_sendmsg
     61.22           +34.9       96.09        perf-profile.children.cycles-pp.__sys_sendto
     61.23           +34.9       96.09        perf-profile.children.cycles-pp.__x64_sys_sendto
     61.57           +35.0       96.54        perf-profile.children.cycles-pp.do_syscall_64
     61.60           +35.0       96.59        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     61.62           +35.1       96.71        perf-profile.children.cycles-pp.sendto
     62.01           +35.3       97.33        perf-profile.children.cycles-pp.stress_run
     37.07 ±  7%     +37.4       74.44 ±  7%  perf-profile.children.cycles-pp.icmp_rcv
     37.14 ±  7%     +37.4       74.51 ±  7%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     37.12 ±  7%     +37.4       74.50 ±  7%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     37.40 ±  7%     +37.5       74.91 ±  7%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     37.52 ±  7%     +37.6       75.09 ±  7%  perf-profile.children.cycles-pp.__napi_poll
     37.52 ±  7%     +37.6       75.09 ±  7%  perf-profile.children.cycles-pp.process_backlog
     37.68 ±  7%     +37.7       75.36 ±  7%  perf-profile.children.cycles-pp.net_rx_action
     39.60 ±  6%     +38.1       77.70 ±  7%  perf-profile.children.cycles-pp.do_softirq
     39.60 ±  7%     +38.1       77.71 ±  7%  perf-profile.children.cycles-pp.__local_bh_enable_ip
     39.36 ±  7%     +38.8       78.16 ±  6%  perf-profile.children.cycles-pp.__dev_queue_xmit
     39.47 ±  7%     +38.9       78.39 ±  6%  perf-profile.children.cycles-pp.ip_finish_output2
     46.97 ±  3%     +46.7       93.66        perf-profile.children.cycles-pp.raw_send_hdrinc
     48.45 ±  2%     -44.7        3.72 ± 14%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.21 ±  2%      -0.1        0.13 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06            +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.siphash_3u32
      0.08            +0.0        0.11 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ±  9%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.06            +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.06            +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.sock_wfree
      0.07 ±  5%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.05            +0.0        0.08 ± 22%  perf-profile.self.cycles-pp.dst_release
      0.07 ±  5%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.icmp_echo
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.fdget
      0.09 ±  9%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.sendto
      0.04 ± 45%      +0.0        0.08 ± 13%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.04 ± 44%      +0.0        0.08 ±  9%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.06 ±  9%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.kfree
      0.07 ±  8%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.08            +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.raw_send_hdrinc
      0.11 ±  4%      +0.0        0.16 ±  8%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      0.10 ±  5%      +0.0        0.14 ±  9%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.10 ±  7%      +0.0        0.14 ± 22%  perf-profile.self.cycles-pp.__ip_make_skb
      0.11 ±  3%      +0.0        0.16 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.09 ±  9%      +0.0        0.14 ±  9%  perf-profile.self.cycles-pp.ip_output
      0.10 ±  4%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp._copy_from_user
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__skb_checksum_complete
      0.08 ±  6%      +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.ip_rcv_core
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.process_backlog
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__build_skb_around
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__call_rcu_common
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.skb_put
      0.14 ±  2%      +0.1        0.21 ±  8%  perf-profile.self.cycles-pp.__sys_sendto
      0.08 ±  4%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.__ip_append_data
      0.00            +0.1        0.06 ± 29%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.14 ±  2%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.raw_sendmsg
      0.14 ±  3%      +0.1        0.21 ±  7%  perf-profile.self.cycles-pp.__alloc_skb
      0.15 ±  3%      +0.1        0.23 ±  6%  perf-profile.self.cycles-pp._copy_from_iter
      0.14 ±  6%      +0.1        0.23 ±  7%  perf-profile.self.cycles-pp.stress_ipv4_checksum
      0.15 ± 14%      +0.1        0.24 ± 19%  perf-profile.self.cycles-pp.kmem_cache_free
      0.15 ± 10%      +0.1        0.26 ± 17%  perf-profile.self.cycles-pp.net_rx_action
      0.04 ± 71%      +0.1        0.14 ± 58%  perf-profile.self.cycles-pp.___slab_alloc
      0.23 ±  3%      +0.1        0.34 ±  6%  perf-profile.self.cycles-pp.csum_partial
      0.16 ±  5%      +0.1        0.27 ±  8%  perf-profile.self.cycles-pp.stress_icmp_flood
      0.24 ±  2%      +0.1        0.38 ±  8%  perf-profile.self.cycles-pp.csum_partial_copy_generic
      0.08 ± 61%      +0.2        0.28 ± 30%  perf-profile.self.cycles-pp.rt_set_nexthop
      0.12 ±  3%      +0.2        0.32 ± 12%  perf-profile.self.cycles-pp.__slab_free
      0.22 ±  3%      +0.2        0.46 ± 10%  perf-profile.self.cycles-pp.dst_destroy
      0.04 ± 73%      +0.4        0.44 ± 90%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      4.05 ± 24%      +9.4       13.46 ± 48%  perf-profile.self.cycles-pp.__ip_select_ident
     25.75 ±  7%     +22.3       48.00 ± 19%  perf-profile.self.cycles-pp.icmp_out_count


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/icmp-flood/stress-ng/60s

commit: 
  a354733c73 ("Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue")
  ac888d5886 ("net: do not delay dst_entries_add() in dst_release()")

a354733c738d905e ac888d58869bb99753e7652be19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     80.60 ±  4%     -19.5%      64.92        vmstat.procs.r
    104288 ±  2%     +17.8%     122845 ±  5%  numa-meminfo.node1.SUnreclaim
    130762 ± 13%     +23.2%     161126 ± 15%  numa-meminfo.node1.Slab
      0.29 ±  3%      +0.1        0.38 ±  4%  mpstat.cpu.all.irq%
     71.69            -7.2       64.50        mpstat.cpu.all.soft%
     22.02 ±  2%      +8.4       30.40 ±  3%  mpstat.cpu.all.sys%
     22678 ± 11%     -61.4%       8753 ± 21%  perf-c2c.DRAM.local
      3573 ± 14%     -28.1%       2570 ±  2%  perf-c2c.HITM.remote
     11014 ± 13%     -25.6%       8199 ±  3%  perf-c2c.HITM.total
   3867621 ±  3%     +38.8%    5366352 ±  5%  numa-numastat.node0.local_node
   3899321 ±  3%     +38.6%    5406358 ±  5%  numa-numastat.node0.numa_hit
   3705953 ±  5%     +49.3%    5534658 ±  3%  numa-numastat.node1.local_node
   3740477 ±  4%     +48.7%    5562397 ±  3%  numa-numastat.node1.numa_hit
   3896930 ±  3%     +38.7%    5405464 ±  5%  numa-vmstat.node0.numa_hit
   3865231 ±  3%     +38.8%    5365458 ±  5%  numa-vmstat.node0.numa_local
     26760 ±  2%     +14.0%      30499 ±  6%  numa-vmstat.node1.nr_slab_unreclaimable
   3738034 ±  5%     +48.8%    5561028 ±  3%  numa-vmstat.node1.numa_hit
   3703510 ±  5%     +49.4%    5533288 ±  3%  numa-vmstat.node1.numa_local
     96547 ±  3%      +6.2%     102575        proc-vmstat.nr_shmem
     57149 ±  2%     +13.0%      64572 ±  3%  proc-vmstat.nr_slab_unreclaimable
   7641355           +43.6%   10970330        proc-vmstat.numa_hit
   7575131           +43.9%   10902585        proc-vmstat.numa_local
    166748 ±  7%     +14.4%     190766 ±  6%  proc-vmstat.pgactivate
  14698033           +45.1%   21332981        proc-vmstat.pgalloc_normal
  14460259           +45.7%   21067582        proc-vmstat.pgfree
     41.14           +51.2%      62.23 ±  2%  stress-ng.icmp-flood.MB_written_per_sec
 3.146e+08           +51.1%  4.754e+08 ±  2%  stress-ng.icmp-flood.ops
   5242030           +51.1%    7922747 ±  2%  stress-ng.icmp-flood.ops_per_sec
     81667           +51.2%     123487 ±  2%  stress-ng.icmp-flood.sendto_calls_per_sec
      1469 ±  2%     +37.4%       2018 ±  3%  stress-ng.time.percent_of_cpu_this_job_got
    857.06 ±  2%     +37.2%       1175 ±  3%  stress-ng.time.system_time
     27.06 ±  4%     +41.9%      38.39 ±  5%  stress-ng.time.user_time
  29575933 ±  5%     -92.5%    2231510 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.avg
  55968875 ± 12%     -78.8%   11864634 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.max
   5776737 ± 18%     -89.1%     627611 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
   9982367 ± 13%     -78.7%    2128671 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    544.32 ± 96%     -82.4%      95.54 ± 20%  sched_debug.cfs_rq:/.load_avg.avg
     57.92 ± 52%     -82.9%       9.92 ± 16%  sched_debug.cfs_rq:/.load_avg.min
  29575933 ±  5%     -92.5%    2231509 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
  55968910 ± 12%     -78.8%   11864634 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
   5776737 ± 18%     -89.1%     627611 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
   9982376 ± 13%     -78.7%    2128675 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
    997.32 ±  2%     -24.1%     757.36        sched_debug.cfs_rq:/.runnable_avg.avg
     63788 ±  4%     -10.1%      57347        sched_debug.cpu.clock_task.avg
     55281 ±  4%     -10.8%      49307        sched_debug.cpu.clock_task.min
     16482 ± 17%     +46.3%      24116 ± 21%  sched_debug.cpu.nr_switches.max
      3094 ± 12%     +29.3%       4001 ± 12%  sched_debug.cpu.nr_switches.stddev
 1.214e+10           +36.6%  1.658e+10        perf-stat.i.branch-instructions
 1.634e+08 ±  2%     +39.8%  2.284e+08        perf-stat.i.branch-misses
     53.94 ±  2%      +2.2       56.15        perf-stat.i.cache-miss-rate%
  40940691 ±  5%     +32.6%   54289639        perf-stat.i.cache-misses
  75541848 ±  2%     +27.8%   96549218        perf-stat.i.cache-references
      3897 ±  4%     +10.7%       4315 ±  6%  perf-stat.i.context-switches
      2.83           -28.3%       2.03        perf-stat.i.cpi
    405.34 ±  2%     -67.0%     133.73 ±  2%  perf-stat.i.cpu-migrations
      4817 ±  3%     -24.8%       3620        perf-stat.i.cycles-between-cache-misses
 6.795e+10           +40.3%  9.532e+10        perf-stat.i.instructions
      0.36 ±  2%     +37.9%       0.49        perf-stat.i.ipc
     54.09 ±  2%      +2.1       56.16        perf-stat.overall.cache-miss-rate%
      2.86           -28.5%       2.04        perf-stat.overall.cpi
      4757 ±  5%     -24.6%       3585        perf-stat.overall.cycles-between-cache-misses
      0.35           +40.0%       0.49        perf-stat.overall.ipc
 1.194e+10           +36.7%  1.631e+10        perf-stat.ps.branch-instructions
 1.608e+08 ±  2%     +39.9%  2.249e+08        perf-stat.ps.branch-misses
  40205833 ±  5%     +32.7%   53341905        perf-stat.ps.cache-misses
  74275006 ±  2%     +27.9%   94991644        perf-stat.ps.cache-references
      3812 ±  4%     +11.0%       4232 ±  6%  perf-stat.ps.context-switches
    398.19 ±  2%     -67.0%     131.59 ±  2%  perf-stat.ps.cpu-migrations
 6.682e+10           +40.3%  9.377e+10        perf-stat.ps.instructions
 4.143e+12           +39.0%  5.757e+12 ±  2%  perf-stat.total.instructions
      1.49 ±103%    +212.1%       4.66 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     18.41 ± 16%     -90.0%       1.85 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.62 ± 26%     -67.1%       0.21 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     19.28 ± 10%     -90.3%       1.86 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
     18.27 ±  6%     -90.7%       1.71 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     15.92 ± 40%     -90.7%       1.49 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      6.15 ± 12%     -99.4%       0.04 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.84 ± 43%     -69.6%       1.47 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     12.83 ± 43%     -85.4%       1.88 ± 36%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.42 ± 74%     -89.6%       0.04 ±133%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.30 ± 46%     -71.9%       0.08 ± 58%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      8.21 ±  8%     -80.9%       1.57 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.17 ±100%     -97.1%       0.06 ± 99%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.17 ± 69%     -98.5%       0.05 ±135%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.41 ± 49%     -94.1%       0.02 ± 55%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.71 ± 23%     -90.6%       0.25 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.10 ± 11%     -89.5%       1.59 ± 32%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.23 ± 27%     -89.9%       0.23 ± 41%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.41 ±101%    +173.1%       9.30 ±  4%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     78.61 ± 10%     -90.7%       7.32 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     67.82 ± 17%     -87.2%       8.68 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     85.16 ±  4%     -85.5%      12.38 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
     89.02 ±  6%     -86.5%      12.00 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     62.40 ± 38%     -92.4%       4.72 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     63.40 ±  4%     -96.4%       2.29 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     71.81 ± 36%     -86.0%      10.08 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     24.34 ± 77%     -74.6%       6.18 ± 31%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     50.99 ± 50%     -87.8%       6.20 ± 28%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.87 ± 51%     -84.8%       0.28 ±202%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     83.63 ±  5%     -64.8%      29.42 ± 28%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     49.08 ± 42%     -84.7%       7.49 ± 49%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     58.64 ± 15%     -82.7%      10.16 ± 28%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     14.35 ± 83%     -96.8%       0.46 ±135%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     32.20 ± 45%     -98.0%       0.66 ±187%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     29.88 ± 40%     -90.8%       2.75 ± 67%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     76.93 ±  8%     -92.3%       5.92 ± 24%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     91.19           -81.2%      17.13 ± 26%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     63.13 ± 10%     -89.4%       6.67 ±  7%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      8.46 ±  3%     -86.5%       1.14 ± 10%  perf-sched.total_sch_delay.average.ms
     94.72 ±  5%     -68.8%      29.60 ± 28%  perf-sched.total_sch_delay.max.ms
     38.55 ± 10%     -90.3%       3.72 ± 40%  perf-sched.wait_and_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
     36.54 ±  6%     -90.7%       3.41 ± 37%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      8.18 ± 32%     -65.5%       2.82 ± 95%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.94 ±  9%     -18.2%       4.04 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    179.81 ±  3%     +14.6%     206.09 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     32.42 ± 10%     -86.8%       4.29 ± 26%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    120.67 ± 14%     +49.9%     180.83 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
      1530 ± 12%     -71.1%     441.67 ± 22%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1089 ± 17%     -91.7%      90.50 ± 52%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1123 ±  5%     +11.4%       1251 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    170.32 ±  4%     -85.5%      24.75 ± 22%  perf-sched.wait_and_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
    178.04 ±  6%     -86.5%      24.00 ± 34%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1102 ±  2%      -8.7%       1007        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    193.28 ± 58%     -81.6%      35.64 ±165%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    569.34 ±  5%     -11.2%     505.80        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     64.34 ± 37%     -88.4%       7.44 ± 28%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1442 ± 30%     -26.0%       1066 ±  4%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18.41 ± 16%     -90.0%       1.85 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     19.28 ± 10%     -90.3%       1.86 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
     18.27 ±  6%     -90.7%       1.71 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     15.92 ± 40%     -90.7%       1.49 ± 54%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      4.52 ±  5%     -11.3%       4.01 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    177.10 ±  3%     +16.2%     205.83 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     17.32 ±  9%     -84.4%       2.70 ± 23%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     78.61 ± 10%     -90.7%       7.32 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     85.16 ±  4%     -85.5%      12.38 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
     89.02 ±  6%     -86.5%      12.00 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     62.40 ± 38%     -92.4%       4.72 ± 41%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     34.50 ± 34%     -82.7%       5.96 ± 13%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1441 ± 30%     -26.0%       1066 ±  4%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     30.84           -30.8        0.00        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs
     29.13           -28.0        1.15 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     29.13           -28.0        1.15 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     29.13           -28.0        1.15 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     29.06           -27.9        1.13 ±  8%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     29.05           -27.9        1.12 ±  8%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     29.04           -27.9        1.12 ±  8%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     29.04           -27.9        1.12 ±  8%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     29.03           -27.9        1.12 ±  8%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     28.96           -27.9        1.10 ±  8%  perf-profile.calltrace.cycles-pp.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
     25.80           -25.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core
     25.55           -25.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_destroy.rcu_do_batch
      7.72 ±  3%      -2.8        4.87        perf-profile.calltrace.cycles-pp.__mkroute_output.ip_route_output_flow.raw_sendmsg.__sys_sendto.__x64_sys_sendto
      4.68 ±  7%      -2.5        2.16 ±  3%  perf-profile.calltrace.cycles-pp.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs.do_softirq
      4.69 ±  7%      -2.5        2.20 ±  3%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.do_softirq.__local_bh_enable_ip
      8.52 ±  3%      -2.4        6.07        perf-profile.calltrace.cycles-pp.ip_route_output_flow.raw_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      3.82 ±  5%      -2.3        1.47 ±  2%  perf-profile.calltrace.cycles-pp.dst_alloc.rt_dst_alloc.__mkroute_output.ip_route_output_flow.raw_sendmsg
      3.90 ±  5%      -2.3        1.58 ±  2%  perf-profile.calltrace.cycles-pp.rt_dst_alloc.__mkroute_output.ip_route_output_flow.raw_sendmsg.__sys_sendto
      3.57 ±  5%      -0.7        2.91 ±  2%  perf-profile.calltrace.cycles-pp.rt_set_nexthop.__mkroute_output.ip_route_output_flow.raw_sendmsg.__sys_sendto
      2.55 ±  7%      -0.3        2.21 ±  3%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.56 ±  4%      +0.2        0.78 ±  5%  perf-profile.calltrace.cycles-pp.skb_release_head_state.sk_skb_reason_drop.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.52            +0.2        0.75 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.59            +0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.icmp_reply.icmp_echo.icmp_rcv
      0.61 ±  3%      +0.3        0.89 ±  6%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.raw_sendmsg.__sys_sendto.__x64_sys_sendto
      0.44 ± 44%      +0.3        0.72 ±  6%  perf-profile.calltrace.cycles-pp.dst_release.skb_release_head_state.sk_skb_reason_drop.icmp_rcv.ip_protocol_deliver_rcu
      0.56            +0.3        0.86        perf-profile.calltrace.cycles-pp.__netif_receive_skb_core.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.58 ±  2%      +0.3        0.88        perf-profile.calltrace.cycles-pp.csum_partial_copy_generic.skb_copy_and_csum_bits.icmp_glue_bits.__ip_append_data.ip_append_data
      0.64 ±  2%      +0.3        0.97 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.dst_alloc.rt_dst_alloc.__mkroute_output.ip_route_output_flow
      0.78 ±  3%      +0.3        1.11 ±  4%  perf-profile.calltrace.cycles-pp.sk_skb_reason_drop.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.66 ±  2%      +0.3        0.99        perf-profile.calltrace.cycles-pp.skb_copy_and_csum_bits.icmp_glue_bits.__ip_append_data.ip_append_data.icmp_push_reply
      0.65            +0.3        0.98 ±  2%  perf-profile.calltrace.cycles-pp.stress_ipv4_checksum.stress_run
      0.54            +0.4        0.89 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.rt_set_nexthop.__mkroute_output.ip_route_output_flow.raw_sendmsg
      0.73            +0.4        1.09        perf-profile.calltrace.cycles-pp.icmp_glue_bits.__ip_append_data.ip_append_data.icmp_push_reply.icmp_reply
      0.75            +0.4        1.13 ±  2%  perf-profile.calltrace.cycles-pp.csum_partial.__skb_checksum.__skb_checksum_complete.icmp_rcv.ip_protocol_deliver_rcu
      0.75            +0.4        1.14        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_append_data
      0.82 ±  2%      +0.4        1.21 ±  2%  perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.88            +0.4        1.31 ±  2%  perf-profile.calltrace.cycles-pp.__skb_checksum.__skb_checksum_complete.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.85            +0.4        1.28        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.raw_send_hdrinc.raw_sendmsg
      1.02 ±  3%      +0.4        1.46 ±  5%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_push_pending_frames
      0.82            +0.4        1.25        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_append_data.icmp_push_reply
      0.27 ±100%      +0.4        0.72 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu
      0.92            +0.5        1.38        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.raw_send_hdrinc.raw_sendmsg.__sys_sendto
      0.26 ±100%      +0.5        0.73 ±  7%  perf-profile.calltrace.cycles-pp.fib_table_lookup.ip_route_output_key_hash_rcu.ip_route_output_flow.raw_sendmsg.__sys_sendto
      1.12 ±  3%      +0.5        1.61 ±  5%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_push_pending_frames.icmp_reply
      0.71 ±  3%      +0.5        1.21        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      1.06            +0.5        1.58 ±  2%  perf-profile.calltrace.cycles-pp.__skb_checksum_complete.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.sendto.stress_run
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.raw_send_hdrinc
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.raw_send_hdrinc.raw_sendmsg.__sys_sendto
      0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.__call_rcu_common.skb_release_head_state.consume_skb.icmp_rcv.ip_protocol_deliver_rcu
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.ip_rcv_core.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll
      1.23 ±  2%      +0.6        1.82        perf-profile.calltrace.cycles-pp.ip_route_output_flow.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu
      0.56 ±  2%      +0.6        1.16 ± 21%  perf-profile.calltrace.cycles-pp.sock_wfree.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      1.22            +0.6        1.84        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_append_data.icmp_push_reply.icmp_reply
      0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.sendto.stress_run
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_iter.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto
      0.00            +0.6        0.64 ± 29%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit
      0.09 ±223%      +0.6        0.73 ±  4%  perf-profile.calltrace.cycles-pp.__mkroute_output.ip_route_output_flow.icmp_reply.icmp_echo.icmp_rcv
      1.54            +0.6        2.18        perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc
      0.00            +0.7        0.66 ±  2%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.00            +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp.stress_icmp_flood.stress_run
      0.00            +0.7        0.69 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.dst_alloc.rt_dst_alloc.__mkroute_output
      1.34            +0.7        2.04        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto
      1.65            +0.7        2.35        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg
      0.36 ± 70%      +0.7        1.08 ±  3%  perf-profile.calltrace.cycles-pp.dst_release.skb_release_head_state.consume_skb.icmp_rcv.ip_protocol_deliver_rcu
      0.97 ±  4%      +0.8        1.75 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.73 ±  2%      +0.8        2.51 ±  4%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_push_pending_frames.icmp_reply.icmp_echo
      0.72 ± 26%      +0.8        1.56        perf-profile.calltrace.cycles-pp.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.60            +0.8        1.44        perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit
      0.75 ± 26%      +0.9        1.63        perf-profile.calltrace.cycles-pp.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      1.94 ±  2%      +0.9        2.83 ±  3%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_push_pending_frames.icmp_reply.icmp_echo.icmp_rcv
      1.20 ±  3%      +1.0        2.19 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      2.37            +1.2        3.56        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_append_data.icmp_push_reply.icmp_reply.icmp_echo
      2.62            +1.3        3.94        perf-profile.calltrace.cycles-pp.ip_append_data.icmp_push_reply.icmp_reply.icmp_echo.icmp_rcv
      2.84            +1.4        4.26        perf-profile.calltrace.cycles-pp.icmp_push_reply.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu
      5.96 ±  8%      +3.0        8.94 ± 11%  perf-profile.calltrace.cycles-pp.icmp_out_count.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto
      4.70 ±  8%      +3.6        8.34 ±  8%  perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_push_pending_frames.icmp_reply.icmp_echo
      9.91 ±  5%      +5.0       14.88 ±  8%  perf-profile.calltrace.cycles-pp.icmp_out_count.__ip_make_skb.ip_push_pending_frames.icmp_reply.icmp_echo
     15.05 ±  2%      +8.8       23.88 ±  7%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_push_pending_frames.icmp_reply.icmp_echo.icmp_rcv
     17.71 ±  2%     +10.1       27.78 ±  6%  perf-profile.calltrace.cycles-pp.ip_push_pending_frames.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu
     23.41           +12.8       36.23 ±  4%  perf-profile.calltrace.cycles-pp.icmp_reply.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     23.64           +12.9       36.58 ±  4%  perf-profile.calltrace.cycles-pp.icmp_echo.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     37.64 ±  2%     +19.4       57.07 ±  2%  perf-profile.calltrace.cycles-pp.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     38.06 ±  2%     +19.7       57.71 ±  2%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     38.17 ±  2%     +19.7       57.88 ±  2%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     39.75 ±  2%     +20.5       60.25 ±  2%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     40.72 ±  2%     +21.1       61.86 ±  2%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     40.78 ±  2%     +21.2       61.94 ±  2%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     41.13 ±  2%     +21.3       62.47        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     44.41           +21.4       65.77        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     44.61           +21.5       66.08        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc
     44.68           +21.5       66.18        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg
     45.37 ±  2%     +21.9       67.25        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.__sys_sendto
     45.49           +22.0       67.44        perf-profile.calltrace.cycles-pp.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto
     65.94           +25.6       91.50        perf-profile.calltrace.cycles-pp.raw_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.36           +26.5       93.82        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     67.50           +26.5       94.02        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_run
     67.84           +26.7       94.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_run
     67.92           +26.8       94.67        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.stress_run
     68.99           +27.3       96.28        perf-profile.calltrace.cycles-pp.sendto.stress_run
     56.64           +27.5       84.18        perf-profile.calltrace.cycles-pp.raw_send_hdrinc.raw_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     70.53           +28.1       98.63        perf-profile.calltrace.cycles-pp.stress_run
     34.21           -33.6        0.64 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
     34.52           -30.3        4.20        perf-profile.children.cycles-pp.dst_destroy
     34.56           -30.3        4.28        perf-profile.children.cycles-pp.rcu_do_batch
     34.57           -30.3        4.28        perf-profile.children.cycles-pp.rcu_core
     29.13           -28.0        1.15 ±  8%  perf-profile.children.cycles-pp.kthread
     29.13           -28.0        1.15 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
     29.13           -28.0        1.15 ±  8%  perf-profile.children.cycles-pp.ret_from_fork_asm
     29.06           -27.9        1.13 ±  8%  perf-profile.children.cycles-pp.smpboot_thread_fn
     29.05           -27.9        1.12 ±  8%  perf-profile.children.cycles-pp.run_ksoftirqd
     28.25           -26.9        1.39 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     27.14           -26.9        0.29 ± 16%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     76.45            -8.6       67.87        perf-profile.children.cycles-pp.handle_softirqs
      8.22 ±  3%      -2.6        5.67        perf-profile.children.cycles-pp.__mkroute_output
      3.84 ±  5%      -2.3        1.50 ±  2%  perf-profile.children.cycles-pp.dst_alloc
      3.91 ±  5%      -2.3        1.59 ±  2%  perf-profile.children.cycles-pp.rt_dst_alloc
      9.76 ±  3%      -1.8        7.92        perf-profile.children.cycles-pp.ip_route_output_flow
      3.58 ±  5%      -0.7        2.93 ±  2%  perf-profile.children.cycles-pp.rt_set_nexthop
      0.18 ± 73%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.ksys_write
      0.17 ± 76%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.vfs_write
      0.18 ± 72%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.write
      0.11 ±  4%      -0.1        0.05        perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.15 ±  9%      -0.0        0.12        perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__cmd_record
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.cmd_record
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.perf_mmap__push
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.handle_internal_command
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.main
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.run_builtin
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.record__pushfn
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
      0.11 ±  5%      -0.0        0.09        perf-profile.children.cycles-pp.shmem_file_write_iter
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.writen
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.task_tick_fair
      0.07 ±  5%      +0.0        0.09        perf-profile.children.cycles-pp.map_id_range_down
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.skb_free_head
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.check_stack_object
      0.08 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ping_lookup
      0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.skb_put
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rmqueue
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.08 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.setup_object
      0.08            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.07 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ±  7%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.stress_mwc32modn
      0.06 ±  7%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.find_exception
      0.13 ±  2%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.08 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.qdisc_pkt_len_init
      0.10 ±  6%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__ip_dev_find
      0.06 ±  8%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ±  5%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.raw_local_deliver
      0.15 ±  3%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.10 ±  7%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.ip_local_deliver
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.free_unref_page_commit
      0.11            +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.neigh_hh_output
      0.13 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.ip_finish_output
      0.11 ±  3%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.ping_rcv
      0.18 ±  4%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.09 ± 15%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.kmalloc_size_roundup
      0.21            +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.17 ±  5%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.security_sk_classify_flow
      0.11            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.12 ±  4%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.free_unref_page
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.icmpv4_xrlim_allow
      0.24 ±  4%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.kfree_skbmem
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.eth_type_trans
      0.14 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.__build_skb_around
      0.12 ±  4%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.raw_v4_input
      0.09 ±  4%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.12 ±  3%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.ipv4_mtu
      0.11 ±  6%      +0.1        0.17 ± 10%  perf-profile.children.cycles-pp.stress_mwc16
      0.14            +0.1        0.21        perf-profile.children.cycles-pp.nf_hook_slow
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ±  3%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.14 ±  3%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.stress_rndbuf
      0.19 ±  4%      +0.1        0.26 ±  5%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.15 ±  4%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.ip_setup_cork
      0.17 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.fib_compute_spec_dst
      0.27 ±  6%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.27 ±  5%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18 ±  3%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.skb_network_protocol
      0.17 ±  2%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__ip_local_out
      0.19 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.21 ± 12%      +0.1        0.30 ± 10%  perf-profile.children.cycles-pp.fib_lookup_good_nhc
      0.21 ±  3%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.rcuref_put_slowpath
      0.19 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.siphash_3u32
      1.15 ±  4%      +0.1        1.24 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.import_ubuf
      0.22 ±  3%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.shuffle_freelist
      0.06 ±  6%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.inet_sendmsg
      0.23 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.xfrm_lookup_route
      0.15 ±  2%      +0.1        0.26 ±  5%  perf-profile.children.cycles-pp.aa_sk_perm
      0.23            +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.22            +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.22 ±  2%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.25            +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.sched_clock
      1.09 ±  4%      +0.1        1.22 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.26 ±  2%      +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.fdget
      0.30 ±  2%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.allocate_slab
      0.24 ±  2%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      0.29            +0.1        0.43        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.29            +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.20            +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.30 ±  6%      +0.1        0.45 ±  6%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.02 ±141%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__put_partials
      0.42 ±  2%      +0.2        0.57 ±  3%  perf-profile.children.cycles-pp.__call_rcu_common
      0.33 ±  3%      +0.2        0.49        perf-profile.children.cycles-pp.__kmalloc_node_track_caller_noprof
      0.36            +0.2        0.54 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.38            +0.2        0.57 ±  2%  perf-profile.children.cycles-pp.netif_skb_features
      0.24 ±  2%      +0.2        0.43 ±  3%  perf-profile.children.cycles-pp.kfree
      0.36            +0.2        0.55 ±  2%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.40            +0.2        0.60        perf-profile.children.cycles-pp.ip_rcv_core
      0.42            +0.2        0.63 ±  3%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.47 ±  2%      +0.2        0.69 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.52 ± 10%      +0.2        0.75 ±  6%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.54            +0.2        0.78 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.46            +0.2        0.70 ±  2%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.39 ±  2%      +0.2        0.63 ±  3%  perf-profile.children.cycles-pp._copy_from_iter
      0.34 ±  3%      +0.2        0.58 ±  7%  perf-profile.children.cycles-pp.__ip_finish_output
      0.50 ±  2%      +0.2        0.74 ±  2%  perf-profile.children.cycles-pp.stress_icmp_flood
      0.50            +0.3        0.76        perf-profile.children.cycles-pp.ip_output
      0.51 ±  2%      +0.3        0.78 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.58            +0.3        0.86        perf-profile.children.cycles-pp.validate_xmit_skb
      0.57            +0.3        0.87        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.42 ±  2%      +0.3        0.72 ±  2%  perf-profile.children.cycles-pp.skb_release_data
      0.64 ±  2%      +0.3        0.98 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.66 ±  4%      +0.3        1.00 ±  2%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.67            +0.3        1.01        perf-profile.children.cycles-pp.skb_copy_and_csum_bits
      0.65            +0.3        0.99 ±  2%  perf-profile.children.cycles-pp.stress_ipv4_checksum
      0.79 ±  3%      +0.3        1.13 ±  4%  perf-profile.children.cycles-pp.sk_skb_reason_drop
      0.90            +0.3        1.24        perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.66            +0.3        1.00        perf-profile.children.cycles-pp.kmalloc_reserve
      0.70 ±  2%      +0.4        1.05        perf-profile.children.cycles-pp.csum_partial_copy_generic
      0.74 ±  2%      +0.4        1.11        perf-profile.children.cycles-pp.icmp_glue_bits
      0.76            +0.4        1.14        perf-profile.children.cycles-pp.csum_partial
      0.90 ±  3%      +0.4        1.30 ±  6%  perf-profile.children.cycles-pp.fib_table_lookup
      0.84 ±  2%      +0.4        1.26 ±  2%  perf-profile.children.cycles-pp.ip_rcv
      0.91 ±  2%      +0.4        1.32 ±  3%  perf-profile.children.cycles-pp.sock_wfree
      1.06 ±  2%      +0.4        1.50        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.90            +0.4        1.34 ±  2%  perf-profile.children.cycles-pp.__skb_checksum
      1.12 ±  2%      +0.5        1.59        perf-profile.children.cycles-pp.netif_rx_internal
      1.17 ±  2%      +0.5        1.66        perf-profile.children.cycles-pp.__netif_rx
      0.72 ±  3%      +0.5        1.23        perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.31            +0.5        1.84 ±  2%  perf-profile.children.cycles-pp.__slab_free
      1.07            +0.5        1.60        perf-profile.children.cycles-pp.__skb_checksum_complete
      1.22 ±  2%      +0.5        1.76 ±  4%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      1.09 ±  4%      +0.8        1.90 ±  3%  perf-profile.children.cycles-pp.dst_release
      1.64            +0.8        2.49        perf-profile.children.cycles-pp.__alloc_skb
      1.77            +0.9        2.68        perf-profile.children.cycles-pp.alloc_skb_with_frags
      1.22 ±  3%      +1.0        2.22 ±  2%  perf-profile.children.cycles-pp.consume_skb
      2.08            +1.0        3.07 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      1.55 ±  3%      +1.0        2.56 ±  3%  perf-profile.children.cycles-pp.skb_release_head_state
      2.63            +1.1        3.74 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      2.79            +1.2        3.99 ±  2%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      2.39            +1.2        3.60        perf-profile.children.cycles-pp.__ip_append_data
      2.59            +1.3        3.92        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      2.64            +1.3        3.97        perf-profile.children.cycles-pp.ip_append_data
      2.85            +1.4        4.29        perf-profile.children.cycles-pp.icmp_push_reply
      4.71 ±  8%      +3.6        8.35 ±  8%  perf-profile.children.cycles-pp.__ip_select_ident
     15.88 ±  4%      +8.0       23.84 ±  4%  perf-profile.children.cycles-pp.icmp_out_count
     15.08 ±  2%      +8.8       23.92 ±  7%  perf-profile.children.cycles-pp.__ip_make_skb
     17.73 ±  2%     +10.1       27.82 ±  6%  perf-profile.children.cycles-pp.ip_push_pending_frames
     23.50           +12.9       36.36 ±  4%  perf-profile.children.cycles-pp.icmp_reply
     23.65           +12.9       36.59 ±  4%  perf-profile.children.cycles-pp.icmp_echo
     46.80           +19.4       66.21        perf-profile.children.cycles-pp.do_softirq
     37.70 ±  2%     +19.5       57.16 ±  2%  perf-profile.children.cycles-pp.icmp_rcv
     47.01           +19.5       66.52        perf-profile.children.cycles-pp.__local_bh_enable_ip
     38.10 ±  2%     +19.7       57.76 ±  2%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     38.19 ±  2%     +19.7       57.90 ±  2%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     39.78 ±  2%     +20.5       60.29 ±  2%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     40.75 ±  2%     +21.2       61.90 ±  2%  perf-profile.children.cycles-pp.process_backlog
     40.78 ±  2%     +21.2       61.95 ±  2%  perf-profile.children.cycles-pp.__napi_poll
     41.15 ±  2%     +21.3       62.49        perf-profile.children.cycles-pp.net_rx_action
     47.17           +22.7       69.87        perf-profile.children.cycles-pp.__dev_queue_xmit
     47.45           +22.9       70.31        perf-profile.children.cycles-pp.ip_finish_output2
     65.99           +25.6       91.57        perf-profile.children.cycles-pp.raw_sendmsg
     67.40           +26.5       93.87        perf-profile.children.cycles-pp.__sys_sendto
     67.52           +26.5       94.06        perf-profile.children.cycles-pp.__x64_sys_sendto
     68.12           +26.6       94.76        perf-profile.children.cycles-pp.do_syscall_64
     68.39           +26.8       95.16        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     69.16           +27.4       96.54        perf-profile.children.cycles-pp.sendto
     56.67           +27.6       84.23        perf-profile.children.cycles-pp.raw_send_hdrinc
     70.53           +28.1       98.63        perf-profile.children.cycles-pp.stress_run
     27.14           -26.9        0.29 ± 16%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.64            -6.0        0.62 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.13 ± 10%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.netdev_core_pick_tx
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.07 ± 10%      +0.0        0.09        perf-profile.self.cycles-pp.rt_dst_alloc
      0.06            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.map_id_range_down
      0.06 ±  9%      +0.0        0.08        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.check_stack_object
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.05 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.ping_lookup
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.stress_mwc32modn
      0.07 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__check_heap_object
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.netif_rx_internal
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.icmp_glue_bits
      0.06            +0.0        0.09        perf-profile.self.cycles-pp.__ip_local_out
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.find_exception
      0.10 ±  9%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.__ip_dev_find
      0.08 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.check_heap_object
      0.04 ± 44%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.move_addr_to_kernel
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.08 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.skb_copy_and_csum_bits
      0.07 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.qdisc_pkt_len_init
      0.08 ±  6%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.raw_local_deliver
      0.02 ± 99%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.xfrm_lookup_route
      0.09 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.skb_release_data
      0.08 ±  4%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.skb_release_head_state
      0.10            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.neigh_hh_output
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.09 ±  9%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_local_deliver
      0.09 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_setup_cork
      0.10 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ip_append_data
      0.10            +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.nf_hook_slow
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.ip_finish_output
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__napi_poll
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.icmpv4_xrlim_allow
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.20            +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__netif_rx
      0.12 ±  3%      +0.1        0.17        perf-profile.self.cycles-pp.__build_skb_around
      0.11 ±  4%      +0.1        0.16 ±  8%  perf-profile.self.cycles-pp.ip_push_pending_frames
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.icmp_push_reply
      0.10 ±  5%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.eth_type_trans
      0.08 ± 17%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.kmalloc_size_roundup
      0.12 ±  3%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.raw_v4_input
      0.08 ±  8%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.stress_mwc16
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.11 ±  3%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.10 ±  3%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.22 ±  4%      +0.1        0.28 ±  5%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.18 ±  3%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.11 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.ipv4_mtu
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.ping_rcv
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.skb_put
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.14            +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.__skb_checksum
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.14 ±  8%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.dst_alloc
      0.13 ±  2%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.skb_free_head
      0.12 ±  4%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.11 ±  3%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.aa_sk_perm
      0.14 ±  2%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.13            +0.1        0.20        perf-profile.self.cycles-pp.kmalloc_reserve
      0.14 ±  3%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.stress_rndbuf
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.15 ±  3%      +0.1        0.22 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.18 ±  5%      +0.1        0.26 ±  5%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.15 ±  5%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.ip_rcv
      0.14 ±  2%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.___slab_alloc
      0.17            +0.1        0.25        perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.22 ±  5%      +0.1        0.30 ±  5%  perf-profile.self.cycles-pp.__call_rcu_common
      0.17 ±  3%      +0.1        0.25 ±  5%  perf-profile.self.cycles-pp.skb_network_protocol
      0.16 ±  3%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.icmp_echo
      0.18 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.19 ±  3%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.shuffle_freelist
      0.20 ± 15%      +0.1        0.28 ± 11%  perf-profile.self.cycles-pp.fib_lookup_good_nhc
      0.16            +0.1        0.24        perf-profile.self.cycles-pp.__skb_checksum_complete
      0.16 ±  2%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.fib_compute_spec_dst
      0.17 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.import_ubuf
      0.17 ±  2%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.21 ±  3%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.rcuref_put_slowpath
      0.18 ±  2%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.do_softirq
      0.22            +0.1        0.32        perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.20 ±  5%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.sendto
      0.18 ±  3%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.siphash_3u32
      0.20 ±  3%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.17 ±  7%      +0.1        0.27 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.19 ±  4%      +0.1        0.29        perf-profile.self.cycles-pp.validate_xmit_skb
      0.20 ±  2%      +0.1        0.31 ±  5%  perf-profile.self.cycles-pp.netif_skb_features
      0.22            +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.21 ±  8%      +0.1        0.32 ±  4%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.24 ±  2%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.25 ±  2%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.fdget
      0.24 ±  2%      +0.1        0.35        perf-profile.self.cycles-pp._copy_from_user
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.inet_sendmsg
      0.28            +0.1        0.41        perf-profile.self.cycles-pp.handle_softirqs
      0.26 ±  2%      +0.1        0.39 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.26            +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.27            +0.1        0.40        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.29 ±  6%      +0.1        0.43 ±  6%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.29 ±  3%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      0.39 ±  2%      +0.1        0.54 ±  3%  perf-profile.self.cycles-pp.loopback_xmit
      0.32            +0.2        0.49        perf-profile.self.cycles-pp.ip_route_output_flow
      0.35            +0.2        0.52 ±  2%  perf-profile.self.cycles-pp.net_rx_action
      0.11 ±  3%      +0.2        0.28 ±  8%  perf-profile.self.cycles-pp.__ip_finish_output
      0.22 ±  3%      +0.2        0.40 ±  2%  perf-profile.self.cycles-pp.kfree
      0.35 ±  2%      +0.2        0.54        perf-profile.self.cycles-pp.__ip_make_skb
      0.36 ±  2%      +0.2        0.54 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.37            +0.2        0.56        perf-profile.self.cycles-pp.ip_output
      0.39            +0.2        0.58        perf-profile.self.cycles-pp.ip_rcv_core
      0.40            +0.2        0.60 ±  3%  perf-profile.self.cycles-pp.__ip_append_data
      0.42            +0.2        0.62 ±  2%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.43 ±  2%      +0.2        0.64 ±  2%  perf-profile.self.cycles-pp.stress_icmp_flood
      0.38            +0.2        0.60 ±  3%  perf-profile.self.cycles-pp._copy_from_iter
      0.47            +0.2        0.70 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.51 ± 10%      +0.2        0.74 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.50            +0.2        0.73 ±  2%  perf-profile.self.cycles-pp.raw_send_hdrinc
      0.44 ±  2%      +0.2        0.67 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.48 ±  2%      +0.2        0.72 ±  2%  perf-profile.self.cycles-pp.__sys_sendto
      1.28            +0.2        1.53 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.56            +0.3        0.85        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.50            +0.3        0.79 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.68 ±  4%      +0.3        0.97 ±  8%  perf-profile.self.cycles-pp.fib_table_lookup
      0.63            +0.3        0.95 ±  2%  perf-profile.self.cycles-pp.stress_ipv4_checksum
      0.65 ±  3%      +0.3        0.97 ±  2%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.68 ±  3%      +0.3        1.01 ±  3%  perf-profile.self.cycles-pp.icmp_reply
      0.89            +0.3        1.23        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.68 ±  2%      +0.4        1.04        perf-profile.self.cycles-pp.csum_partial_copy_generic
      0.62 ±  2%      +0.4        0.98        perf-profile.self.cycles-pp.raw_sendmsg
      0.75            +0.4        1.12 ±  2%  perf-profile.self.cycles-pp.csum_partial
      0.86 ±  5%      +0.4        1.24 ±  4%  perf-profile.self.cycles-pp.dst_release
      0.52 ±  2%      +0.4        0.91 ±  5%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.67 ±  4%      +0.4        1.08 ±  3%  perf-profile.self.cycles-pp.__mkroute_output
      0.90 ±  2%      +0.4        1.31 ±  3%  perf-profile.self.cycles-pp.sock_wfree
      0.71 ±  3%      +0.5        1.21        perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.05            +0.6        1.65 ±  2%  perf-profile.self.cycles-pp.dst_destroy
      0.80            +0.9        1.74 ±  2%  perf-profile.self.cycles-pp.rt_set_nexthop
      4.51 ±  8%      +3.5        8.04 ±  8%  perf-profile.self.cycles-pp.__ip_select_ident
     10.23 ± 12%      +4.3       14.55 ± 10%  perf-profile.self.cycles-pp.icmp_rcv
     15.73 ±  4%      +7.8       23.52 ±  4%  perf-profile.self.cycles-pp.icmp_out_count



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/udp/stress-ng/60s

commit: 
  a354733c73 ("Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue")
  ac888d5886 ("net: do not delay dst_entries_add() in dst_release()")

a354733c738d905e ac888d58869bb99753e7652be19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3185249 ± 10%     -51.0%    1559487 ±  4%  cpuidle..usage
     53909 ± 42%     -32.3%      36472 ± 49%  numa-meminfo.node0.KReclaimable
     53909 ± 42%     -32.3%      36472 ± 49%  numa-meminfo.node0.SReclaimable
   5153239           +12.8%    5811560 ±  2%  numa-numastat.node0.local_node
   5195670           +12.4%    5838265 ±  2%  numa-numastat.node0.numa_hit
  11387705           +23.9%   14105088        vmstat.system.cs
    243802 ±  3%     -11.4%     216057        vmstat.system.in
     31.16           -10.0       21.15 ±  2%  mpstat.cpu.all.soft%
     60.21           +10.0       70.19        mpstat.cpu.all.sys%
      4.71 ±  3%      +0.6        5.27 ±  3%  mpstat.cpu.all.usr%
     13476 ± 42%     -32.3%       9117 ± 49%  numa-vmstat.node0.nr_slab_reclaimable
   5194696           +12.2%    5831003 ±  2%  numa-vmstat.node0.numa_hit
   5152265           +12.7%    5804298 ±  2%  numa-vmstat.node0.numa_local
      7394 ± 16%     -49.0%       3767 ± 30%  perf-c2c.DRAM.local
      4965 ±  5%     -59.4%       2018 ±  7%  perf-c2c.DRAM.remote
      6899 ±  6%     -63.6%       2511 ± 11%  perf-c2c.HITM.local
      2464 ±  6%     -80.8%     473.00 ±  4%  perf-c2c.HITM.remote
      9363 ±  6%     -68.1%       2984 ±  9%  perf-c2c.HITM.total
     58351            +4.5%      60968        proc-vmstat.nr_slab_unreclaimable
  11825600 ±  2%     +10.2%   13036553 ±  3%  proc-vmstat.numa_hit
  11755780 ±  2%     +10.3%   12970839 ±  3%  proc-vmstat.numa_local
  22029814           +11.3%   24511283        proc-vmstat.pgalloc_normal
  20340842 ±  2%     +13.1%   23006810        proc-vmstat.pgfree
 3.582e+08           +24.4%  4.454e+08        stress-ng.time.involuntary_context_switches
      4023           +19.1%       4793        stress-ng.time.percent_of_cpu_this_job_got
      2298           +19.1%       2736        stress-ng.time.system_time
    118.74           +20.6%     143.22        stress-ng.time.user_time
 3.643e+08           +23.2%  4.489e+08        stress-ng.time.voluntary_context_switches
 4.195e+08           +20.8%  5.066e+08        stress-ng.udp.ops
   6990774           +20.8%    8443151        stress-ng.udp.ops_per_sec
      3.43 ± 20%     -49.2%       1.74 ± 75%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.13 ± 62%    +123.6%       0.30 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      5.44 ±207%     -99.8%       0.01 ±118%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.53 ± 60%    +648.1%      26.40 ±130%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     15.67 ±217%     -99.9%       0.01 ±118%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.85 ± 20%     -49.2%       3.48 ± 75%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     35.32 ± 26%     +90.1%      67.15 ± 40%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    211.33 ± 24%     -55.1%      94.83 ± 27%  perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto
    586.67 ± 22%     -61.7%     224.67 ± 54%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    233.50 ± 24%     -65.7%      80.00 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    182.50 ± 29%     -63.8%      66.00 ± 33%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      3.43 ± 20%     -49.2%       1.74 ± 75%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     34.71 ± 28%     +92.7%      66.89 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.44 ±207%     -99.8%       0.01 ±106%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59 ± 62%     -75.9%       0.14 ±180%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     15.67 ±217%     -99.9%       0.01 ±106%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
 3.015e+10           +18.5%  3.573e+10        perf-stat.i.branch-instructions
 3.093e+08           +18.1%  3.653e+08 ±  2%  perf-stat.i.branch-misses
     27.93 ±  2%      -2.2       25.71 ±  2%  perf-stat.i.cache-miss-rate%
  48499261 ±  3%      -8.7%   44270940 ±  4%  perf-stat.i.cache-misses
  11916700           +22.6%   14614549        perf-stat.i.context-switches
      1.46           -16.7%       1.22        perf-stat.i.cpi
      1424 ±  2%     -51.1%     696.77 ±  5%  perf-stat.i.cpu-migrations
 1.526e+11           +19.1%  1.818e+11        perf-stat.i.instructions
      0.70           +18.9%       0.83        perf-stat.i.ipc
    186.16           +22.6%     228.26        perf-stat.i.metric.K/sec
      0.32 ±  3%     -23.5%       0.24 ±  5%  perf-stat.overall.MPKI
     27.81 ±  2%      -2.4       25.43 ±  3%  perf-stat.overall.cache-miss-rate%
      1.44           -16.3%       1.21        perf-stat.overall.cpi
      0.69           +19.5%       0.83        perf-stat.overall.ipc
 2.966e+10           +18.5%  3.515e+10        perf-stat.ps.branch-instructions
 3.039e+08           +18.1%  3.589e+08 ±  2%  perf-stat.ps.branch-misses
  47733487 ±  3%      -8.8%   43525997 ±  4%  perf-stat.ps.cache-misses
  11722751           +22.6%   14374400        perf-stat.ps.context-switches
      1399 ±  2%     -51.2%     683.22 ±  5%  perf-stat.ps.cpu-migrations
 1.501e+11           +19.2%  1.789e+11        perf-stat.ps.instructions
 9.317e+12           +18.3%  1.103e+13        perf-stat.total.instructions
  13759920 ±  7%     -85.3%    2025500 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
  34265100 ± 11%     -77.1%    7838035 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.max
   4531390 ± 20%     -71.8%    1277742 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
   5747264 ±  2%     -77.2%    1312895 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.57 ± 13%     -15.9%       0.48 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
   2376765 ± 97%     -99.2%      18167 ±142%  sched_debug.cfs_rq:/.left_deadline.avg
  22167427 ± 43%     -95.8%     935337 ±156%  sched_debug.cfs_rq:/.left_deadline.max
   4783360 ± 49%     -97.4%     125665 ±149%  sched_debug.cfs_rq:/.left_deadline.stddev
   2376735 ± 97%     -99.2%      18167 ±142%  sched_debug.cfs_rq:/.left_vruntime.avg
  22167360 ± 43%     -95.8%     935300 ±156%  sched_debug.cfs_rq:/.left_vruntime.max
   4783305 ± 49%     -97.4%     125660 ±149%  sched_debug.cfs_rq:/.left_vruntime.stddev
    106196 ± 85%     -84.7%      16242 ± 38%  sched_debug.cfs_rq:/.load.avg
    729690 ± 33%     -71.1%     210891 ±114%  sched_debug.cfs_rq:/.load.max
    190399 ± 40%     -83.0%      32305 ±113%  sched_debug.cfs_rq:/.load.stddev
  13759931 ±  7%     -85.3%    2025500 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
  34265136 ± 11%     -77.1%    7838035 ± 16%  sched_debug.cfs_rq:/.min_vruntime.max
   4531393 ± 20%     -71.8%    1277742 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
   5747264 ±  2%     -77.2%    1312895 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.38 ± 18%     -35.7%       0.25 ± 13%  sched_debug.cfs_rq:/.nr_running.stddev
   2377630 ± 97%     -99.2%      18167 ±142%  sched_debug.cfs_rq:/.right_vruntime.avg
  22167360 ± 43%     -95.8%     935300 ±156%  sched_debug.cfs_rq:/.right_vruntime.max
   4784167 ± 49%     -97.4%     125660 ±149%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1123 ±  3%      -9.1%       1021        sched_debug.cfs_rq:/.runnable_avg.avg
      2406 ± 14%     -22.5%       1865 ± 16%  sched_debug.cfs_rq:/.runnable_avg.max
   1054887 ±  9%     -21.9%     823898 ±  8%  sched_debug.cpu.avg_idle.max
    253962 ±  8%     -26.2%     187541 ±  6%  sched_debug.cpu.avg_idle.stddev
      1515 ±  9%     +14.0%       1727        sched_debug.cpu.curr->pid.avg
    917.36 ± 16%     -31.2%     631.03 ±  9%  sched_debug.cpu.curr->pid.stddev
   5590314           +23.2%    6885329        sched_debug.cpu.nr_switches.avg
   5813699           +23.3%    7168647        sched_debug.cpu.nr_switches.max
   4704792 ±  6%     +24.4%    5851797 ±  5%  sched_debug.cpu.nr_switches.min
     16.17 ±  9%     -29.4%      11.42 ± 17%  sched_debug.cpu.nr_uninterruptible.max
     16.18 ±  6%     -16.2        0.00        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs
     13.58 ±  6%     -12.6        0.96 ±  3%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.56 ±  6%     -12.6        0.96 ±  3%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.60 ±  6%     -12.6        1.00 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     13.60 ±  6%     -12.6        1.00 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     13.60 ±  6%     -12.6        1.00 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     13.56 ±  6%     -12.6        0.96 ±  3%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     13.55 ±  6%     -12.6        0.95 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     13.52 ±  6%     -12.6        0.94 ±  3%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     13.44 ±  6%     -12.5        0.90 ±  2%  perf-profile.calltrace.cycles-pp.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
     12.25 ±  8%     -12.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core
     12.06 ±  8%     -12.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.dst_destroy.rcu_do_batch
      9.69            -5.8        3.84        perf-profile.calltrace.cycles-pp.__mkroute_output.ip_route_output_flow.udp_sendmsg.__sys_sendto.__x64_sys_sendto
     10.22            -5.7        4.51        perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      7.32 ±  2%      -5.5        1.81        perf-profile.calltrace.cycles-pp.dst_alloc.rt_dst_alloc.__mkroute_output.ip_route_output_flow.udp_sendmsg
      7.43 ±  2%      -5.5        1.94        perf-profile.calltrace.cycles-pp.rt_dst_alloc.__mkroute_output.ip_route_output_flow.udp_sendmsg.__sys_sendto
      1.79 ±  8%      -0.5        1.32        perf-profile.calltrace.cycles-pp.rt_set_nexthop.__mkroute_output.ip_route_output_flow.udp_sendmsg.__sys_sendto
      1.06 ± 10%      -0.4        0.70        perf-profile.calltrace.cycles-pp.sk_ioctl.inet_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl
      1.32 ±  7%      -0.3        1.02        perf-profile.calltrace.cycles-pp.inet_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl
      1.40 ±  7%      -0.3        1.11        perf-profile.calltrace.cycles-pp.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      1.68 ±  5%      -0.2        1.45        perf-profile.calltrace.cycles-pp.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.78 ±  5%      -0.2        1.57        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.76 ±  3%      -0.2        0.57 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.dst_destroy.rcu_do_batch.rcu_core.handle_softirqs
      0.53            +0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.ioctl.stress_udp
      0.56 ±  3%      +0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.validate_xmit_skb.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      0.54 ±  2%      +0.1        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.ipv4_pktinfo_prepare.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      0.69            +0.1        0.83        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data
      0.73            +0.1        0.87        perf-profile.calltrace.cycles-pp.__check_object_size.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
      0.55            +0.1        0.69        perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.syscall_exit_to_user_mode
      0.70            +0.1        0.84        perf-profile.calltrace.cycles-pp.__check_object_size.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.72            +0.1        0.86        perf-profile.calltrace.cycles-pp._copy_to_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.74            +0.2        0.90        perf-profile.calltrace.cycles-pp.move_addr_to_kernel.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80            +0.2        0.95        perf-profile.calltrace.cycles-pp.move_addr_to_user.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60            +0.2        0.76        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.sendto.stress_udp
      0.81            +0.2        0.98 ±  3%  perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      3.63 ±  2%      +0.2        3.80        perf-profile.calltrace.cycles-pp.ioctl.stress_udp
      0.75            +0.2        0.92        perf-profile.calltrace.cycles-pp.irqtime_account_irq.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.74            +0.2        0.92 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.sendto.stress_udp
      0.43 ± 44%      +0.2        0.62        perf-profile.calltrace.cycles-pp._copy_from_user.move_addr_to_kernel.__sys_sendto.__x64_sys_sendto.do_syscall_64
      0.95 ±  2%      +0.2        1.14 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
      0.72            +0.2        0.92        perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit
      0.58 ±  2%      +0.2        0.78        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      0.74            +0.2        0.94 ±  2%  perf-profile.calltrace.cycles-pp.__udp4_lib_lookup.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.80            +0.2        1.00        perf-profile.calltrace.cycles-pp.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.73            +0.2        0.94        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      0.76            +0.2        0.96        perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule
      0.54            +0.2        0.75        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.83            +0.2        1.06        perf-profile.calltrace.cycles-pp.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.42 ± 44%      +0.2        0.64        perf-profile.calltrace.cycles-pp.__netif_receive_skb_core.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      1.00            +0.2        1.23        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.dst_alloc.rt_dst_alloc.__mkroute_output.ip_route_output_flow
      0.85 ±  2%      +0.2        1.08        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.54 ±  2%      +0.3        0.80 ±  2%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      0.98            +0.3        1.25        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      0.34 ± 70%      +0.3        0.65        perf-profile.calltrace.cycles-pp.wakeup_preempt.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.07 ±  2%      +0.3        1.38        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      1.07 ±  2%      +0.3        1.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      1.07 ±  2%      +0.3        1.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom
      1.73            +0.3        2.07        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb
      0.87 ±  2%      +0.3        1.21 ± 15%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      1.22            +0.4        1.58 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.86            +0.4        2.23        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      1.99            +0.4        2.38        perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto
      1.22 ±  2%      +0.4        1.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      1.22 ±  2%      +0.4        1.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto
      1.22 ±  2%      +0.4        1.60        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      1.66            +0.4        2.06        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule.schedule
      1.72            +0.4        2.15        perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      1.54            +0.4        1.97        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      0.34 ± 70%      +0.4        0.79 ±  3%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      1.65            +0.4        2.10        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.stress_udp
      2.27            +0.5        2.73        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto
      1.91            +0.5        2.40        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      0.85 ±  2%      +0.5        1.36 ± 18%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.dst_alloc.rt_dst_alloc.__mkroute_output
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.sockfd_lookup_light.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.08 ±223%      +0.6        0.64 ±  5%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.udp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.udp4_lib_lookup2.__udp4_lib_lookup.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.handle_softirqs.do_softirq.__local_bh_enable_ip
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.clear_bhb_loop.recvfrom.stress_udp
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__schedule.schedule.syscall_exit_to_user_mode
      1.10            +0.6        1.68        perf-profile.calltrace.cycles-pp.ipv4_pktinfo_prepare.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_entities.dequeue_task_fair.__schedule.schedule
      2.10            +0.6        2.73        perf-profile.calltrace.cycles-pp.recvfrom
      2.27            +0.7        2.98        perf-profile.calltrace.cycles-pp.sendto
      2.93            +0.7        3.65        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__schedule.schedule.schedule_timeout
      2.30            +0.7        3.02        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      3.02            +0.8        3.77        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      0.00            +0.9        0.87 ± 19%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      2.91            +0.9        3.81        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      5.13            +0.9        6.05        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
      0.00            +0.9        0.92        perf-profile.calltrace.cycles-pp.dst_release.ipv4_pktinfo_prepare.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      0.00            +1.1        1.08        perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.18        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.83 ±  2%      +1.3        6.09        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.98 ±  2%      +1.3        6.28        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      6.08 ±  2%      +1.7        7.74        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_udp
     10.70            +1.8       12.47        perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      7.46            +1.9        9.35        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      7.65            +1.9        9.58        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      5.10            +1.9        7.04 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb
      4.90            +1.9        6.85 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
      4.99            +2.0        6.95 ±  4%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule_skb
      5.25            +2.0        7.22 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
      7.97            +2.0        9.97        perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      5.38            +2.0        7.42 ±  3%  perf-profile.calltrace.cycles-pp.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      5.78            +2.2        7.93 ±  3%  perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      8.68            +2.2       10.90        perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
     13.53            +2.3       15.85        perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     13.71            +2.4       16.07        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     14.17            +2.5       16.64        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.80            +2.5       17.30        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.stress_udp
     15.73            +2.8       18.51        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     16.76            +3.0       19.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.stress_udp
     16.83            +3.0       19.82        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom.stress_udp
      7.69            +3.1       10.80 ±  2%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      7.82            +3.1       10.96 ±  2%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     18.26            +3.3       21.54        perf-profile.calltrace.cycles-pp.recvfrom.stress_udp
      8.98            +3.5       12.49        perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      9.44            +3.6       13.08        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      9.57            +3.7       13.25        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     15.19            +3.9       19.08        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     15.50            +3.9       19.40        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
     15.70            +3.9       19.65        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
     11.17            +4.1       15.23        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      4.95 ±  5%      +4.2        9.18 ±  3%  perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_make_skb.udp_sendmsg.__sys_sendto
     11.88            +4.3       16.18        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      5.86 ±  4%      +4.3       10.18 ±  2%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
     12.04            +4.3       16.37        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     12.77            +4.5       17.28        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     19.03            +4.8       23.82        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
     19.66            +4.9       24.58        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto
     20.92            +5.2       26.12        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
     45.32            +5.2       50.54        perf-profile.calltrace.cycles-pp.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.58 ±  2%      +5.3       16.90        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     21.50            +5.3       26.81        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     48.26            +5.9       54.14        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     48.64            +6.0       54.61        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_udp
     55.31            +7.7       62.99        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_udp
     55.42            +7.7       63.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.stress_udp
     57.43            +8.1       65.55        perf-profile.calltrace.cycles-pp.sendto.stress_udp
     80.20           +11.8       91.96        perf-profile.calltrace.cycles-pp.stress_udp
     24.46 ±  3%     -23.6        0.84        perf-profile.children.cycles-pp.percpu_counter_add_batch
     22.03 ±  4%     -19.2        2.86        perf-profile.children.cycles-pp.dst_destroy
     22.14 ±  4%     -19.2        2.97        perf-profile.children.cycles-pp.rcu_do_batch
     22.16 ±  4%     -19.2        3.00        perf-profile.children.cycles-pp.rcu_core
     18.24 ±  4%     -17.3        0.97        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     17.25 ±  4%     -17.1        0.15 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     36.23 ±  2%     -14.4       21.82        perf-profile.children.cycles-pp.handle_softirqs
     13.58 ±  6%     -12.6        0.96 ±  3%  perf-profile.children.cycles-pp.smpboot_thread_fn
     13.56 ±  6%     -12.6        0.96 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
     13.60 ±  6%     -12.6        1.00 ±  3%  perf-profile.children.cycles-pp.kthread
     13.60 ±  6%     -12.6        1.00 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
     13.60 ±  6%     -12.6        1.00 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      9.71            -5.8        3.89        perf-profile.children.cycles-pp.__mkroute_output
     10.23            -5.7        4.53        perf-profile.children.cycles-pp.ip_route_output_flow
      7.36 ±  2%      -5.5        1.84        perf-profile.children.cycles-pp.dst_alloc
      7.44 ±  2%      -5.5        1.96        perf-profile.children.cycles-pp.rt_dst_alloc
      5.13 ±  7%      -3.4        1.71        perf-profile.children.cycles-pp.__irq_exit_rcu
      5.39 ±  7%      -3.3        2.05        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.36 ±  7%      -3.3        2.02        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.82 ±  7%      -0.5        1.35        perf-profile.children.cycles-pp.rt_set_nexthop
      1.14 ±  7%      -0.5        0.67        perf-profile.children.cycles-pp.finish_task_switch
      0.60 ± 17%      -0.4        0.19 ± 37%  perf-profile.children.cycles-pp.common_startup_64
      0.60 ± 17%      -0.4        0.19 ± 37%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.60 ± 17%      -0.4        0.19 ± 37%  perf-profile.children.cycles-pp.do_idle
      0.82 ± 12%      -0.4        0.41        perf-profile.children.cycles-pp.first_packet_length
      0.59 ± 17%      -0.4        0.19 ± 37%  perf-profile.children.cycles-pp.start_secondary
      0.84 ± 12%      -0.4        0.44        perf-profile.children.cycles-pp.udp_ioctl
      1.08 ±  9%      -0.4        0.73        perf-profile.children.cycles-pp.sk_ioctl
      0.45 ± 17%      -0.3        0.14 ± 37%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.35 ±  7%      -0.3        1.06        perf-profile.children.cycles-pp.inet_ioctl
      0.42 ± 17%      -0.3        0.13 ± 38%  perf-profile.children.cycles-pp.cpuidle_enter
      0.42 ± 17%      -0.3        0.13 ± 38%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.41 ± 18%      -0.3        0.12 ± 39%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.41 ± 17%      -0.3        0.12 ± 39%  perf-profile.children.cycles-pp.acpi_safe_halt
      1.43 ±  6%      -0.3        1.14        perf-profile.children.cycles-pp.sock_do_ioctl
      0.34 ± 17%      -0.2        0.12 ± 37%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.71 ±  5%      -0.2        1.49        perf-profile.children.cycles-pp.sock_ioctl
      1.79 ±  5%      -0.2        1.58        perf-profile.children.cycles-pp.do_vfs_ioctl
      0.47            -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.ipv4_dst_destroy
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.perf_exclude_event
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.sched_clock_noinstr
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.inet_lookup_reuseport
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sched_tick
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.neigh_hh_output
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mm_cid_get
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.qdisc_pkt_len_init
      0.06 ±  6%      +0.0        0.08        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.06 ±  9%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.inet_send_prepare
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.09            +0.0        0.11        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sched_update_worker
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.perf_swevent_event
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.ip_finish_output
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.clockevents_program_event
      0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__build_skb_around
      0.07 ±  8%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.switch_ldt
      0.12 ±  4%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.import_ubuf
      0.12 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.udp4_hwcsum
      0.12 ±  3%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.nf_hook_slow
      0.19            +0.0        0.22 ±  9%  perf-profile.children.cycles-pp.x64_sys_call
      0.14 ±  5%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.kmalloc_size_roundup
      0.13 ±  5%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.raw_v4_input
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.09            +0.0        0.12        perf-profile.children.cycles-pp.skb_pull_rcsum
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.security_sk_classify_flow
      0.12 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.__skb_try_recv_from_queue
      0.10 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.resched_curr
      0.14 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.17 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.skb_network_protocol
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.update_entity_lag
      0.16 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.26 ±  2%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.34            +0.0        0.37        perf-profile.children.cycles-pp.ip_setup_cork
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__get_user_4
      0.12 ±  5%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.raw_local_deliver
      0.17 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.__put_user_4
      0.17 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.ip_send_check
      0.13 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__calc_delta
      0.26            +0.0        0.30        perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.finish_wait
      1.08            +0.0        1.12        perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.25            +0.0        0.29        perf-profile.children.cycles-pp.__check_heap_object
      0.09            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_bh
      0.15 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.08 ±  6%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.24 ±  4%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.14 ±  6%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.22            +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.20 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.22            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__ip_finish_output
      0.32            +0.0        0.37        perf-profile.children.cycles-pp.sock_wfree
      0.16 ±  5%      +0.0        0.22 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__sk_mem_schedule
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.enqueue_task
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.udp_queue_rcv_skb
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.skb_free_head
      0.16 ±  5%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.11 ±  4%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.eth_type_trans
      0.23 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.__enqueue_entity
      0.16            +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.28 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.stress_udp_server
      0.19 ±  2%      +0.1        0.24        perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.24 ±  3%      +0.1        0.29        perf-profile.children.cycles-pp.is_vmalloc_addr
      0.24            +0.1        0.29        perf-profile.children.cycles-pp.rcuref_put_slowpath
      0.29            +0.1        0.34        perf-profile.children.cycles-pp.__ip_local_out
      0.24 ±  2%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.20            +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.udp4_csum_init
      0.16 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.udp_rmem_release
      0.24            +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.place_entity
      0.24            +0.1        0.30        perf-profile.children.cycles-pp.xfrm_lookup_route
      0.36 ±  4%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.netif_skb_features
      0.30 ±  2%      +0.1        0.36        perf-profile.children.cycles-pp.__cond_resched
      0.28 ±  4%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.35 ±  2%      +0.1        0.41        perf-profile.children.cycles-pp.__kmalloc_node_track_caller_noprof
      0.17 ±  2%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.05 ±  8%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__put_partials
      0.38            +0.1        0.44        perf-profile.children.cycles-pp.__consume_stateless_skb
      0.38            +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.37 ±  5%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.stress_udp_client
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.25            +0.1        0.31        perf-profile.children.cycles-pp.__dequeue_entity
      0.15 ±  9%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.cpuacct_charge
      0.29            +0.1        0.35        perf-profile.children.cycles-pp._copy_to_user
      0.27 ±  8%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.35            +0.1        0.42        perf-profile.children.cycles-pp.siphash_3u32
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.apparmor_socket_sock_rcv_skb
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.get_partial_node
      0.30            +0.1        0.38        perf-profile.children.cycles-pp.__put_user_8
      0.28            +0.1        0.35        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.30            +0.1        0.38        perf-profile.children.cycles-pp.vruntime_eligible
      0.23 ±  4%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 ±  5%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.29            +0.1        0.37        perf-profile.children.cycles-pp.update_curr_se
      0.41            +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.ip_rcv_core
      0.29 ±  2%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp.update_min_vruntime
      0.10 ±  6%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.16 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.35 ±  2%      +0.1        0.44        perf-profile.children.cycles-pp.update_rq_clock
      0.37 ±  2%      +0.1        0.46        perf-profile.children.cycles-pp.__get_user_8
      0.09 ±  4%      +0.1        0.19 ± 22%  perf-profile.children.cycles-pp.select_idle_cpu
      0.35            +0.1        0.45        perf-profile.children.cycles-pp.update_rq_clock_task
      0.46 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.__virt_addr_valid
      0.29 ±  2%      +0.1        0.39        perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.52 ±  2%      +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      0.44 ±  2%      +0.1        0.54        perf-profile.children.cycles-pp.ip_output
      0.38 ±  2%      +0.1        0.49        perf-profile.children.cycles-pp.avg_vruntime
      0.28 ±  2%      +0.1        0.39        perf-profile.children.cycles-pp.inet_sendmsg
      0.02 ± 99%      +0.1        0.13 ± 22%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.45 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.24            +0.1        0.35        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.60            +0.1        0.71        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.44 ±  4%      +0.1        0.55        perf-profile.children.cycles-pp.___slab_alloc
      0.43            +0.1        0.54        perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.30 ±  7%      +0.1        0.42 ± 12%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.29 ±  6%      +0.1        0.41 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.55 ±  2%      +0.1        0.67        perf-profile.children.cycles-pp._copy_from_user
      0.33            +0.1        0.45        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.51 ±  2%      +0.1        0.63        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.55 ±  2%      +0.1        0.67 ±  2%  perf-profile.children.cycles-pp.__call_rcu_common
      0.58 ±  2%      +0.1        0.70 ±  2%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.47 ±  2%      +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.udp4_lib_lookup2
      0.61 ±  2%      +0.1        0.75        perf-profile.children.cycles-pp.native_sched_clock
      0.51            +0.1        0.66        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.72            +0.1        0.87        perf-profile.children.cycles-pp.kmalloc_reserve
      0.73            +0.1        0.87        perf-profile.children.cycles-pp._copy_to_iter
      0.60            +0.2        0.75        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.68            +0.2        0.83        perf-profile.children.cycles-pp.sched_clock
      0.50            +0.2        0.65        perf-profile.children.cycles-pp.os_xsave
      0.65            +0.2        0.81        perf-profile.children.cycles-pp.put_prev_entity
      0.59            +0.2        0.75        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.78            +0.2        0.94        perf-profile.children.cycles-pp.move_addr_to_kernel
      0.60            +0.2        0.76        perf-profile.children.cycles-pp.wakeup_preempt
      0.84            +0.2        1.00        perf-profile.children.cycles-pp.move_addr_to_user
      0.60            +0.2        0.76        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.18 ±  2%      +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.sk_skb_reason_drop
      0.59            +0.2        0.75        perf-profile.children.cycles-pp.___perf_sw_event
      0.84            +0.2        1.01 ±  3%  perf-profile.children.cycles-pp.ip_rcv
      0.38            +0.2        0.55        perf-profile.children.cycles-pp.kfree
      0.56 ±  2%      +0.2        0.73        perf-profile.children.cycles-pp.pick_eevdf
      0.78            +0.2        0.96        perf-profile.children.cycles-pp.sched_clock_cpu
      0.80            +0.2        0.97        perf-profile.children.cycles-pp.irqtime_account_irq
      0.96 ±  2%      +0.2        1.15 ±  2%  perf-profile.children.cycles-pp._copy_from_iter
      0.93            +0.2        1.12        perf-profile.children.cycles-pp.check_heap_object
      0.75            +0.2        0.95        perf-profile.children.cycles-pp.__update_load_avg_se
      0.76            +0.2        0.96        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.77            +0.2        0.98 ±  2%  perf-profile.children.cycles-pp.__udp4_lib_lookup
      3.80 ±  2%      +0.2        4.02        perf-profile.children.cycles-pp.ioctl
      0.60 ±  3%      +0.2        0.82 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.81            +0.2        1.02        perf-profile.children.cycles-pp.netif_rx_internal
      0.86            +0.2        1.08        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.77            +0.2        0.98        perf-profile.children.cycles-pp.__switch_to_asm
      0.50            +0.2        0.72        perf-profile.children.cycles-pp.skb_release_data
      0.85            +0.2        1.08        perf-profile.children.cycles-pp.__netif_rx
      0.89            +0.2        1.12        perf-profile.children.cycles-pp.rseq_ip_fixup
      0.85            +0.2        1.08        perf-profile.children.cycles-pp.set_next_entity
      1.01            +0.2        1.24        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.80            +0.2        1.03        perf-profile.children.cycles-pp.__switch_to
      0.10 ±  6%      +0.2        0.35 ± 24%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.76            +0.3        1.02        perf-profile.children.cycles-pp.fdget
      0.82            +0.3        1.08        perf-profile.children.cycles-pp.pick_task_fair
      0.99            +0.3        1.26        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.92 ±  2%      +0.3        1.20 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      0.89            +0.3        1.18        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.77            +0.3        2.12        perf-profile.children.cycles-pp.__alloc_skb
      1.29            +0.4        1.64 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      1.77            +0.4        2.13        perf-profile.children.cycles-pp.clear_bhb_loop
      1.89            +0.4        2.26        perf-profile.children.cycles-pp.alloc_skb_with_frags
      2.12            +0.4        2.49        perf-profile.children.cycles-pp.__check_object_size
      2.02            +0.4        2.41        perf-profile.children.cycles-pp.ip_generic_getfrag
      1.18 ±  2%      +0.4        1.58        perf-profile.children.cycles-pp.__slab_free
      1.72            +0.4        2.12        perf-profile.children.cycles-pp.dequeue_entity
      1.13 ±  2%      +0.4        1.54        perf-profile.children.cycles-pp.switch_fpu_return
      1.61            +0.4        2.05        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      1.79            +0.5        2.24        perf-profile.children.cycles-pp.loopback_xmit
      0.21 ±  3%      +0.5        0.67 ± 24%  perf-profile.children.cycles-pp.select_idle_sibling
      2.30            +0.5        2.76        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.40            +0.5        0.89 ± 19%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.93            +0.5        2.42        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.58            +0.5        1.09        perf-profile.children.cycles-pp.dst_release
      1.08 ±  2%      +0.5        1.62 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      1.13            +0.6        1.71        perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
      1.99 ±  2%      +0.6        2.57        perf-profile.children.cycles-pp.update_load_avg
      2.20            +0.6        2.82        perf-profile.children.cycles-pp.update_curr
      1.73            +0.6        2.36        perf-profile.children.cycles-pp.kmem_cache_free
      2.39            +0.7        3.08        perf-profile.children.cycles-pp.enqueue_task_fair
      2.61            +0.7        3.31        perf-profile.children.cycles-pp.pick_next_task_fair
      2.96            +0.7        3.69        perf-profile.children.cycles-pp.dequeue_entities
      3.04            +0.8        3.79        perf-profile.children.cycles-pp.dequeue_task_fair
      3.00            +0.8        3.85        perf-profile.children.cycles-pp.ttwu_do_activate
      5.17            +0.9        6.10        perf-profile.children.cycles-pp.__ip_append_data
      2.31 ±  2%      +0.9        3.24        perf-profile.children.cycles-pp.switch_mm_irqs_off
     17.86 ±  2%      +1.6       19.51        perf-profile.children.cycles-pp.do_softirq
     10.75            +1.8       12.54        perf-profile.children.cycles-pp.__skb_recv_udp
     18.46            +1.8       20.28        perf-profile.children.cycles-pp.__local_bh_enable_ip
      5.11            +1.9        7.05 ±  4%  perf-profile.children.cycles-pp.__wake_up_common
      4.95            +2.0        6.90 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      5.00            +2.0        6.96 ±  4%  perf-profile.children.cycles-pp.autoremove_wake_function
      5.26            +2.0        7.24 ±  4%  perf-profile.children.cycles-pp.__wake_up_sync_key
      7.99            +2.0        9.99        perf-profile.children.cycles-pp.schedule_timeout
      5.39            +2.0        7.44 ±  3%  perf-profile.children.cycles-pp.sock_def_readable
      5.79            +2.2        7.95 ±  3%  perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      8.71            +2.2       10.93        perf-profile.children.cycles-pp.__skb_wait_for_more_packets
     13.57            +2.3       15.90        perf-profile.children.cycles-pp.udp_recvmsg
     13.73            +2.4       16.10        perf-profile.children.cycles-pp.inet_recvmsg
     14.18            +2.5       16.66        perf-profile.children.cycles-pp.sock_recvmsg
      9.11            +2.5       11.64        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     15.76            +2.8       18.54        perf-profile.children.cycles-pp.__sys_recvfrom
     15.89            +2.8       18.71        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     12.52            +3.1       15.64        perf-profile.children.cycles-pp.__schedule
      7.76            +3.1       10.89 ±  2%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      7.84            +3.2       10.99 ±  2%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
     12.67            +3.2       15.90        perf-profile.children.cycles-pp.schedule
      9.03            +3.5       12.56        perf-profile.children.cycles-pp.__udp4_lib_rcv
      9.47            +3.7       13.12        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      9.59            +3.7       13.27        perf-profile.children.cycles-pp.ip_local_deliver_finish
     20.56            +4.0       24.52        perf-profile.children.cycles-pp.recvfrom
     11.20            +4.1       15.26        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      4.97 ±  5%      +4.2        9.20 ±  3%  perf-profile.children.cycles-pp.__ip_select_ident
     11.92            +4.3       16.22        perf-profile.children.cycles-pp.process_backlog
      5.90 ±  4%      +4.3       10.23 ±  2%  perf-profile.children.cycles-pp.__ip_make_skb
     12.06            +4.3       16.40        perf-profile.children.cycles-pp.__napi_poll
     12.80            +4.5       17.31        perf-profile.children.cycles-pp.net_rx_action
     19.09            +4.8       23.91        perf-profile.children.cycles-pp.__dev_queue_xmit
     19.69            +4.9       24.61        perf-profile.children.cycles-pp.ip_finish_output2
     20.95            +5.2       26.16        perf-profile.children.cycles-pp.ip_send_skb
     45.46            +5.2       50.70        perf-profile.children.cycles-pp.udp_sendmsg
     11.62 ±  2%      +5.3       16.94        perf-profile.children.cycles-pp.ip_make_skb
     21.53            +5.3       26.85        perf-profile.children.cycles-pp.udp_send_skb
     48.32            +5.9       54.22        perf-profile.children.cycles-pp.__sys_sendto
     48.69            +6.0       54.67        perf-profile.children.cycles-pp.__x64_sys_sendto
     60.02            +8.9       68.93        perf-profile.children.cycles-pp.sendto
     76.98           +11.3       88.28        perf-profile.children.cycles-pp.do_syscall_64
     77.73           +11.5       89.26        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     80.20           +11.8       91.96        perf-profile.children.cycles-pp.stress_udp
     17.25 ±  4%     -17.1        0.15 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.79            -6.0        0.80        perf-profile.self.cycles-pp.percpu_counter_add_batch
      1.00            -0.2        0.80        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26 ± 16%      -0.2        0.08 ± 52%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.15 ±  2%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.ipv4_pktinfo_prepare
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.inet_lookup_reuseport
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.sched_clock
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__wake_up_common
      0.06 ±  6%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.ipv4_dst_destroy
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.mm_cid_get
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.qdisc_pkt_len_init
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.rcu_note_context_switch
      0.07            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.sk_ioctl
      0.07 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.sock_do_ioctl
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.rseq_get_rseq_cs
      0.07            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.neigh_hh_output
      0.09            +0.0        0.11        perf-profile.self.cycles-pp.__build_skb_around
      0.09            +0.0        0.11        perf-profile.self.cycles-pp.put_prev_entity
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.first_packet_length
      0.08            +0.0        0.10        perf-profile.self.cycles-pp.__x64_sys_ioctl
      0.08            +0.0        0.10        perf-profile.self.cycles-pp.wakeup_preempt
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.sched_update_worker
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.nf_hook_slow
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.skb_release_data
      0.08 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.update_rq_clock
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.do_vfs_ioctl
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.ip_generic_getfrag
      0.17 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.ip_rcv
      0.10 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__ip_local_out
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.skb_pull_rcsum
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.09            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.import_ubuf
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.udp4_hwcsum
      0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.xfrm_lookup_route
      0.06 ±  7%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.12 ±  4%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.08 ±  5%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.11 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.11            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.09            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__ip_finish_output
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.move_addr_to_user
      0.19 ±  6%      +0.0        0.22 ±  5%  perf-profile.self.cycles-pp.netif_skb_features
      0.09 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.resched_curr
      0.11 ±  5%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±  9%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.raw_local_deliver
      0.12 ±  6%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.raw_v4_input
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.ip_finish_output
      0.10            +0.0        0.13        perf-profile.self.cycles-pp.__skb_try_recv_from_queue
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.13            +0.0        0.16        perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.08            +0.0        0.11        perf-profile.self.cycles-pp.rt_dst_alloc
      0.06 ±  8%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.select_idle_cpu
      0.11            +0.0        0.14        perf-profile.self.cycles-pp.security_sk_classify_flow
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.place_entity
      0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.switch_ldt
      0.06            +0.0        0.09 ±  7%  perf-profile.self.cycles-pp._raw_spin_unlock_bh
      0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.kmalloc_size_roundup
      0.13 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.move_addr_to_kernel
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.dst_alloc
      0.19 ±  4%      +0.0        0.22 ±  5%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.16 ±  4%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.skb_network_protocol
      1.04            +0.0        1.08        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.12 ±  4%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.15 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__calc_delta
      0.18 ±  2%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.__get_user_4
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.ip_send_check
      0.12 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.14 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__napi_poll
      0.16            +0.0        0.20        perf-profile.self.cycles-pp.__put_user_4
      0.24            +0.0        0.28        perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.15 ±  4%      +0.0        0.19        perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.finish_wait
      0.06 ±  6%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.netdev_core_pick_tx
      0.17 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.ip_setup_cork
      0.17 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.15            +0.0        0.19        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.15 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.set_next_entity
      0.15 ±  4%      +0.0        0.19        perf-profile.self.cycles-pp.__cond_resched
      0.25            +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.__raise_softirq_irqoff
      0.10            +0.0        0.14 ±  9%  perf-profile.self.cycles-pp.eth_type_trans
      0.02 ±141%      +0.0        0.06        perf-profile.self.cycles-pp.arch_scale_cpu_capacity
      0.16            +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.09 ±  4%      +0.0        0.14 ± 26%  perf-profile.self.cycles-pp.sock_def_readable
      0.32            +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.sock_wfree
      0.23            +0.0        0.27 ±  2%  perf-profile.self.cycles-pp.check_heap_object
      0.17 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.finish_task_switch
      0.20 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.__dequeue_entity
      0.21 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.__enqueue_entity
      0.22 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.__check_heap_object
      0.15 ±  5%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.inet_recvmsg
      0.18 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.14 ±  4%      +0.0        0.19        perf-profile.self.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.apparmor_socket_sock_rcv_skb
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_socket_recvmsg
      0.17 ±  2%      +0.1        0.22        perf-profile.self.cycles-pp.sock_recvmsg
      0.20            +0.1        0.25        perf-profile.self.cycles-pp.ip_make_skb
      0.19            +0.1        0.24        perf-profile.self.cycles-pp.validate_xmit_skb
      0.17 ±  2%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.25 ±  2%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.19            +0.1        0.24        perf-profile.self.cycles-pp.udp4_csum_init
      0.22 ±  4%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.20 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.update_rq_clock_task
      0.23 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.rcuref_put_slowpath
      0.14            +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.22            +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.dst_release
      0.22 ±  3%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.ioctl
      0.15            +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.17 ±  2%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.enqueue_entity
      0.22 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.stress_udp_server
      0.21 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.udp_queue_rcv_one_skb
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.inet_send_prepare
      0.22 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.schedule
      0.14 ±  9%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.cpuacct_charge
      0.18 ±  2%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.perf_swevent_event
      0.20 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.is_vmalloc_addr
      0.49            +0.1        0.55        perf-profile.self.cycles-pp.handle_softirqs
      0.27 ±  2%      +0.1        0.33        perf-profile.self.cycles-pp.stress_udp_client
      0.24            +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.39 ±  4%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.__call_rcu_common
      0.26 ±  2%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.26            +0.1        0.32        perf-profile.self.cycles-pp.inet_ioctl
      0.13 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.prepare_to_wait_exclusive
      0.22 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.update_curr_se
      0.26 ±  8%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.28            +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.22            +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.14 ±  2%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.udp_rmem_release
      0.24            +0.1        0.30        perf-profile.self.cycles-pp.dequeue_entities
      0.23 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.ip_send_skb
      0.27 ±  2%      +0.1        0.34        perf-profile.self.cycles-pp.sock_ioctl
      0.25 ±  2%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.27            +0.1        0.34        perf-profile.self.cycles-pp.pick_next_task_fair
      0.27            +0.1        0.34 ±  5%  perf-profile.self.cycles-pp.try_to_wake_up
      0.26            +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.vruntime_eligible
      0.24            +0.1        0.31        perf-profile.self.cycles-pp.pick_task_fair
      0.26            +0.1        0.33        perf-profile.self.cycles-pp._copy_to_user
      0.28 ±  2%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp.schedule_timeout
      0.28            +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.18 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.28            +0.1        0.35        perf-profile.self.cycles-pp.__put_user_8
      0.25            +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      0.27            +0.1        0.34        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.40            +0.1        0.48 ±  4%  perf-profile.self.cycles-pp.ip_rcv_core
      0.26 ±  2%      +0.1        0.34 ± 10%  perf-profile.self.cycles-pp.update_min_vruntime
      0.32            +0.1        0.40        perf-profile.self.cycles-pp.siphash_3u32
      0.30            +0.1        0.38        perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.30            +0.1        0.39        perf-profile.self.cycles-pp.ip_output
      0.13 ±  3%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.26 ±  4%      +0.1        0.35 ± 10%  perf-profile.self.cycles-pp.recvfrom
      0.34 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.__x64_sys_sendto
      0.37 ±  3%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.aa_sk_perm
      0.24 ±  8%      +0.1        0.33 ± 16%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.22 ±  2%      +0.1        0.31        perf-profile.self.cycles-pp.inet_sendmsg
      0.36 ±  3%      +0.1        0.46        perf-profile.self.cycles-pp.avg_vruntime
      0.76            +0.1        0.86        perf-profile.self.cycles-pp.__ip_append_data
      0.65 ±  3%      +0.1        0.75        perf-profile.self.cycles-pp.__ip_make_skb
      0.36            +0.1        0.46        perf-profile.self.cycles-pp.__skb_wait_for_more_packets
      0.33 ±  3%      +0.1        0.44 ±  4%  perf-profile.self.cycles-pp.reweight_entity
      0.43            +0.1        0.54        perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.33 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.__get_user_8
      0.39            +0.1        0.50        perf-profile.self.cycles-pp.ip_route_output_flow
      0.36 ±  2%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.pick_eevdf
      0.40 ±  2%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.udp4_lib_lookup2
      0.27 ±  7%      +0.1        0.38 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.20 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.26 ±  2%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp.__udp4_lib_rcv
      0.48 ±  6%      +0.1        0.59 ±  5%  perf-profile.self.cycles-pp.ip_finish_output2
      0.41 ±  2%      +0.1        0.52        perf-profile.self.cycles-pp.__virt_addr_valid
      0.31            +0.1        0.42 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.44            +0.1        0.55        perf-profile.self.cycles-pp.__alloc_skb
      0.44            +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.udp_send_skb
      0.40            +0.1        0.52 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.46            +0.1        0.58        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.24 ±  4%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.switch_fpu_return
      0.69            +0.1        0.81        perf-profile.self.cycles-pp.__check_object_size
      0.47            +0.1        0.59 ±  2%  perf-profile.self.cycles-pp.loopback_xmit
      0.00            +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.52            +0.1        0.65        perf-profile.self.cycles-pp.__sys_recvfrom
      0.55 ±  2%      +0.1        0.68        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.47            +0.1        0.60        perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.58            +0.1        0.72        perf-profile.self.cycles-pp.native_sched_clock
      0.49            +0.1        0.63        perf-profile.self.cycles-pp._copy_from_user
      0.50            +0.1        0.64        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.49            +0.1        0.63        perf-profile.self.cycles-pp.___perf_sw_event
      0.58 ±  4%      +0.1        0.72 ±  2%  perf-profile.self.cycles-pp.dst_destroy
      0.46            +0.1        0.61        perf-profile.self.cycles-pp.udp_recvmsg
      0.58            +0.2        0.73        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.43 ±  2%      +0.2        0.58        perf-profile.self.cycles-pp.__mkroute_output
      0.47            +0.2        0.62        perf-profile.self.cycles-pp.__skb_recv_udp
      0.10 ±  7%      +0.2        0.26 ± 27%  perf-profile.self.cycles-pp.select_idle_sibling
      0.49            +0.2        0.64        perf-profile.self.cycles-pp.os_xsave
      0.56            +0.2        0.72        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.55 ±  6%      +0.2        0.71 ±  2%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.68            +0.2        0.84        perf-profile.self.cycles-pp._copy_to_iter
      0.04 ± 45%      +0.2        0.21 ± 24%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.63            +0.2        0.80        perf-profile.self.cycles-pp.do_syscall_64
      0.70            +0.2        0.87        perf-profile.self.cycles-pp.net_rx_action
      0.30 ±  2%      +0.2        0.48        perf-profile.self.cycles-pp.kfree
      0.55            +0.2        0.73 ±  2%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.50 ±  2%      +0.2        0.69 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.69            +0.2        0.88        perf-profile.self.cycles-pp.__update_load_avg_se
      0.76            +0.2        0.97        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.78 ±  2%      +0.2        0.99 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.76 ±  2%      +0.2        0.98        perf-profile.self.cycles-pp.__switch_to_asm
      0.76            +0.2        0.98        perf-profile.self.cycles-pp.__switch_to
      0.68            +0.2        0.90        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.88 ±  2%      +0.2        1.10 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.68 ±  3%      +0.2        0.91        perf-profile.self.cycles-pp.update_load_avg
      0.55 ±  3%      +0.2        0.78 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.90            +0.2        1.14        perf-profile.self.cycles-pp.__sys_sendto
      1.62            +0.3        1.88        perf-profile.self.cycles-pp.udp_sendmsg
      0.69            +0.3        0.95        perf-profile.self.cycles-pp.fdget
      1.14 ±  2%      +0.3        1.42        perf-profile.self.cycles-pp.__slab_free
      0.88 ±  2%      +0.3        1.17        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.28 ±  5%      +0.3        0.58        perf-profile.self.cycles-pp.rt_set_nexthop
      1.15            +0.4        1.50 ±  2%  perf-profile.self.cycles-pp.__schedule
      1.75            +0.4        2.11        perf-profile.self.cycles-pp.clear_bhb_loop
      0.48 ±  3%      +0.4        0.86 ±  5%  perf-profile.self.cycles-pp.prepare_task_switch
      2.28 ±  2%      +0.9        3.19        perf-profile.self.cycles-pp.switch_mm_irqs_off
      4.32 ±  5%      +4.2        8.51 ±  3%  perf-profile.self.cycles-pp.__ip_select_ident





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


