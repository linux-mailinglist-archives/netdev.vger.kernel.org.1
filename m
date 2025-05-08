Return-Path: <netdev+bounces-189049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0FAB0123
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC695027CB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209F20E700;
	Thu,  8 May 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMsS/U/S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11521C5F39;
	Thu,  8 May 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724420; cv=fail; b=S34kgqpwNd5tbygBqQXzLCo9eBBsRsy1tC221hGHd+0Rw3XhNv4j5Ivu9ZG5DqVKIj9NqCeMuG76mjQc4/fjl1XnrDSWQC9FuBH3mFaIyFG9h4+VPdccRsrsuAR3b1t0M/UwlQz5/DLo2WlcJ0jaTjq5hGf0jmtggQ2Pb7mT3Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724420; c=relaxed/simple;
	bh=w6WQ3JuA/KymoMlQy9FjJ8QiCrqrHUE9meO3WqtaPHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r2Ci5DbSebaM+KgGCu8iiVE/2f1kVpU1FTHxhpXol+E3REIFAyefLiR5cTl12xJjMWnxcvxj84tWUcNrdto0V4f0wB62m66wltazQ2FNLCks9wugDTSzRTrJjaHgtYVUegAxXwb+GY7pYaXaBUmkXAm0iMNHOMpiICxu1UuszUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMsS/U/S; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746724419; x=1778260419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w6WQ3JuA/KymoMlQy9FjJ8QiCrqrHUE9meO3WqtaPHI=;
  b=QMsS/U/SisZMwcJfwv7Y7skQXh9VdOLm4EcOyvAQJPPRHiKfmVSi+1AB
   ThecMwYoSSDPgM9GlGNK+Mwss3vaC1uJWt7gEC9MAoM311Y9EfZEBG8tP
   H+Ahb7NhfMB6xVThKSBYemizGiDxN2/Jew9znfUGusvEc1HY8lbcaMTW+
   4ur8mxgSXFDZ37QmMIbDJmL/XFcRID8gur55Io/17k7YWv2Kgq+/rENM0
   pybC9NQi6AvF7rVYdCA4GDzxXCLtF7rfvu79Sh0/dhZg6Sz/YgMqYYorA
   faKP8zmdxFBV/zrro8j0RU5P//mr2sG7FTrSgjMmHw4iko6SY+v5szrVa
   Q==;
X-CSE-ConnectionGUID: rwegpD7+SuWF8PPKuMs8rw==
X-CSE-MsgGUID: R0GMEMcZSZKtyIz+A1+ImA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59154602"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59154602"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:13:38 -0700
X-CSE-ConnectionGUID: kxCkAHjwQr+UID/LoqmInQ==
X-CSE-MsgGUID: IJxHbmUtQoCbkshB/CCk7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136847057"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:13:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 10:13:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 10:13:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 10:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/3z3KAKJ6d/qKnATjWOhBwfy6LW4iCkjht4Xz11gfUToogEwicCXbZ35vlhg96cfj97v2Kww4xRB9jVh2p3GMsMHFylC1dDl+i4tM8lTgT4giolK5VjZY+xum55k1pV9iUvjJ9hkLp1+ThpgW7YuJylpGxxVWYpnKwk9vNOctk2OzB0ILM9kBj5+n5CBznZmdZU9kUi8stQZ3pL9ypgBXppDkZODGww6P79xZ0x2ap3ubqnkvbxa9L0N8uZ/oDwHZOBf0gWXjOZ1xXhSh6P81F94DLUS+JATbsRPqL36DA8ZNfnYyKmfKZ+I189hPY5LfITcZPVgH49/p3rpT5rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeeBrb+VtVddwTUWk5IpnSzo6i0338677TfU68vK9UE=;
 b=P2QxKqnmXRC7VvNVQNEkB3g4mnhJmBsZoc+N1xDvYmGa2fAWsiBCdZkegsMnHOWSxO/ev5DgAD9+RiVNF+wIfGnDgZBraHg/B35F0WAN8g36gff4nD1znX42pL/UGxmNmvs0hTF5spJajfcGQC5d5TqA4mnVxeYH5GlZuX9hMa2Ky2wjewifz8i0vKVDGpR6SBAYEiduHWvfpD02yaTBsFclL0lj/O4qpTW12nu9zAIzeOGa0L3NgXSsObdQzVlzWMf2TmsNbcnx/buQ5m5yohm5hbt7KXriZBay27LFEhRWDAtsLiCaf2C3gZHGAClU/qpHbAHaP0YwG04tyHI/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 17:12:52 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:12:51 +0000
Date: Thu, 8 May 2025 10:12:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 02/22] sfc: add cxl support
Message-ID: <aBzmCjCStxiQRJkK@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
 <aBv7woc3z3KSMK8Q@aschofie-mobl2.lan>
 <0de6789e-9d19-4e90-a0cb-cf77f12428c4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0de6789e-9d19-4e90-a0cb-cf77f12428c4@amd.com>
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|BL4PR11MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ed97cc-744b-4995-78ed-08dd8e5390a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F8NrfUkHGyGBv49xAgeCAQw6aA1hvex8UxdNwMBYTwLUXeTBYDkRjY3voafb?=
 =?us-ascii?Q?HhK096ebJ1rRREkePYlKH3ESs0dM+U90jbj9X3hvLDT53NESZq6AilSW4Kwg?=
 =?us-ascii?Q?9pBLGfYk4eZcv7yOj19HqxSDfHXQdsdpuWZorZB2srgoG8Hmz0OF6e1A0Gwy?=
 =?us-ascii?Q?oYhR1xvKS8lbFJEd0TQlj/+GPDlj9xa8Cj0Ted/BFTY9iW0DAPzGSSGoUFuy?=
 =?us-ascii?Q?Hib/0xty3pYORkMbnrcyRNbx+m8vsgSagbauZdlgV+bSsMYRudkhI7EiFjs+?=
 =?us-ascii?Q?IEDSDyfBZHNg7LeQQfow6+rFiWp9htUMui+ws1BRfSnod6uGC/zGyv3Ssl0R?=
 =?us-ascii?Q?LWuhqFW9sosFyNARCuXJfPG6oUkGAzHiF3V1Ln/ytoLTZiR2HD8rEaRybe6H?=
 =?us-ascii?Q?AxSeyJII3n3GPW7/rXoVbWpsKLQnrCMiGLk9eIbfXP0nbV/ZuhikNIg/Ek9B?=
 =?us-ascii?Q?QIdR4piJ3oizJLzvliCG/ri1G70HUi1k1JfamS07Af0oPYQTFfWvLKpEvbbj?=
 =?us-ascii?Q?Uvh/jTu4GVxu470XjjmpVlK/WLxd+mZ8QJyDhqagcP/FbCombwMel+uHgm4P?=
 =?us-ascii?Q?B0e1cG6F4pg1uiKuwuJ1ATxU0I9w6is4kkDpK92/DtfftJs1CZPG7qsVZb1v?=
 =?us-ascii?Q?9Jo+FLq/9aikbW6tRxU/Rq+KnPc+pcUFUOW+xf9DpDqJp8euzn27RW4cBsvv?=
 =?us-ascii?Q?6dSkv2F9BRYe5fKwpEwlB/0AEZYpRedfZ6Vc0yOZYtHUl1S9bqmZVHHkx+B7?=
 =?us-ascii?Q?0LX3ljQQM4FxuQv4RRQlKMvy8NIPniyznrVA38a4QUgVkqQVP3RToWRpai2Z?=
 =?us-ascii?Q?7MPbuzvdl/yqIpBvGNM/7pPuLCqZFVjcZMO0QxL2ZX79kBX5anP9kn4XWxNt?=
 =?us-ascii?Q?7gARBqxo83OM/VasoZ3qqZSEAveLEH/KAgWPZ9VGuYoG46GI1Fxm9D0iLMba?=
 =?us-ascii?Q?hrehH5N/sKH37UWaHHAFaxD6jGsXhlwx/ljKLGkIVSUKwff526ufXXB9Wquw?=
 =?us-ascii?Q?k6nPssniE8XHaHWdh4N63xdz09p8VERG7cQH2RNVxPunr5RjZIv+cWElDi7O?=
 =?us-ascii?Q?28yErtO7QMToCVor/my74erICMJjMPJBoAhlHmQxZntEmcPuXAxOTHdxcSz/?=
 =?us-ascii?Q?8B+T6fm7NmmIkrkgEpTFj6c2nslX9PrYBEWB9IEFWSiFpZwMh4OSOw1IyMAx?=
 =?us-ascii?Q?px4Jc8DJ39CJEbSyTOUL+CXRGsPpcOxsPSLqh53xmq+qdppLHa/7ss6rDEp+?=
 =?us-ascii?Q?MYINi0LkHW1J+WjBrUStcGbzgqnG8HVuEtz4OhO1hXh2X43/CIFD07GrjoJE?=
 =?us-ascii?Q?4+gD3HbNht+ss212+InhuA2r1ZQO0UGa2pvHwlZW5O6uaM8i8/MJk+G6ZCjV?=
 =?us-ascii?Q?RZOsQ1P6MneXfAuneCPjWucUucJPXJXqMKpW2rCeRp5OHR6rlJqP56soArzv?=
 =?us-ascii?Q?ruuk46Thx9A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYRfo2I7FOifr6mvCVyEWIOVkdTexE29STWOsuhGBzYviNxAh08GLQh/avEY?=
 =?us-ascii?Q?60K3oWpn2NjAHuzlfzRAIhGmh542phH406n1gbgqG9xhEoywE9moLRZ+l3y/?=
 =?us-ascii?Q?wJMkdh8QY6GqIlV5oK1W4RSbwpL/EJrL5MNLbqhv+L3oVgmGoM+SGYpNhDyn?=
 =?us-ascii?Q?3pJcvIFA3g4p1+V4mmgMpi6L2PKymIu25wk6e/Fy8ofyvwA2BznDgzk060qJ?=
 =?us-ascii?Q?pZEk9JSYj5Pmep6D6qRo9hBDyK1upz9Y+2FJevKy6KaBk78J2ziBECiaJ7pO?=
 =?us-ascii?Q?heZkOY1Pdi8ptW3jf6oFx/ZOuFAqTbWU45n3IKPh7E+CpDDzDYLkt6hTUPVI?=
 =?us-ascii?Q?p6061MLcDya//Mf3zYxfo/HYDUfNrSXOrfoR5sT4Rq9MCss/HvlcpU0NUJZi?=
 =?us-ascii?Q?aaGU6kx+lz7+I46uKmfOP5BASP5lgluU6+Esq+5K5n/3w49Jn9nU7E6zJwbG?=
 =?us-ascii?Q?gmm7+dwk54ahVPg/oDK2QzjhHpbGHTWZq74PwBn6mNoxtIajD0/4jdOATPk/?=
 =?us-ascii?Q?jQDHI81cqcAZPF/k40rE8isE063guy1T6uSyxbMGr+Cr/J8Y13HXL+PrEVsy?=
 =?us-ascii?Q?+/sfeOr4OfngnpzRA8llXaFYH6GfQL1eTbgB2UggSVG4Z+GPT/KtKK4WMjLA?=
 =?us-ascii?Q?c7L4xNc1X4J9eSzvaS0xf+KGXVRH6pC25EZxW8H351jtsDBoEmBvYFkxbhy5?=
 =?us-ascii?Q?znudShd1Oq3q0mXfGky+53A9WfXDqpK+aDrtviYDDG9qWHDPbELugkZQmigZ?=
 =?us-ascii?Q?K/wU52nmUTSV45qyUQ7ta58/nuJ8BhkTk7wfxEIXksskjR/CFuoI38PW4sGl?=
 =?us-ascii?Q?79crOuwexWj1z71PYAabFP0w34Ofk2lYvDBvi+XUBnoGzRDpbgTtLNDpKD3Z?=
 =?us-ascii?Q?QMZykiH6yxGN8HQ0bfv1zVpplPrF1sPU4VXYh9OUdbOUdULNhHERc8DlQfv2?=
 =?us-ascii?Q?L7XoNXJE5GpXwovWpFZWvVuBVow5WmrbI+k3WwOfN0yi8P/gpdt49GchNscv?=
 =?us-ascii?Q?HY2sRDLCpOCyMIfUdh5gjXh4et6f+vPMph4ICujoD2GpOOQ9XuG3I/ugTLwW?=
 =?us-ascii?Q?3UQ46aAFHRlkF9jT+4w6jNV78PoA1fAiGZDCp6riw0NWzg+xW5PmaxLeaOtN?=
 =?us-ascii?Q?MrvQDfYqTCk0AzXSsGSTDBU63cOWF2tGo67j2MndydX0xHktwcWNYgWkk/oq?=
 =?us-ascii?Q?JvBqdgAY8sCyjWA8YDvT7WUB6qsLMFcAWEllPJx5XYD4mYBIPO/0jmmqaQ6y?=
 =?us-ascii?Q?Izo9S+J88yjr3vSmyFmTpuA5jvUdPROLBI2idAvi/7bPnx+I/PV8JnkYMSpD?=
 =?us-ascii?Q?N6OEUy+gGEUTHloycxPIkyZy9BwYJxcFI2t1DfPN2u5ObyKswh5WXy21vjgR?=
 =?us-ascii?Q?3tqEm2LKLmhaFaqY/5zYhC+vmG7r3L0U5iT5a4AgnuqCukNt9p6KafDF9ajX?=
 =?us-ascii?Q?xB5WvOAKoQmarcWP12pHdxHE4v0owRWQFM6zhyQ3s6WvmUOWZ/ATNXpaYdtV?=
 =?us-ascii?Q?UKnC8ZtP+DmmVAetPD7d4BMhk7nSyOpp+l2LMybw6o5p+/wEUTPfQroFFkwk?=
 =?us-ascii?Q?AinaGQrOkdGN78xfNNqm/NO3mzc1ddxqr2ICwJu26T33CmQNlrpgCuLtXPuv?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ed97cc-744b-4995-78ed-08dd8e5390a1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:12:51.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UB7/lieYF+4BBldG123ClBiVyPBuL81YuT9lpuBVIIFA9Lwx/G3VbH8KJd9duJbwNvlMPC7NMVwmL4LGIuQ1O5K8hCx1kqnToaFjVFGTTGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
X-OriginatorOrg: intel.com

On Thu, May 08, 2025 at 01:41:15PM +0100, Alejandro Lucero Palau wrote:
> 
> On 5/8/25 01:33, Alison Schofield wrote:
> > On Thu, Apr 17, 2025 at 10:29:05PM +0100, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Add CXL initialization based on new CXL API for accel drivers and make
> > > it dependent on kernel CXL configuration.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   drivers/net/ethernet/sfc/Kconfig      |  9 +++++
> > >   drivers/net/ethernet/sfc/Makefile     |  1 +
> > >   drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
> > >   drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
> > >   drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
> > >   drivers/net/ethernet/sfc/net_driver.h | 10 +++++
> > >   6 files changed, 129 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
> > >   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> > > 
> > > diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> > > index c4c43434f314..979f2801e2a8 100644
> > > --- a/drivers/net/ethernet/sfc/Kconfig
> > > +++ b/drivers/net/ethernet/sfc/Kconfig
> > > @@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
> > >   	  Driver-Interface) commands and responses, allowing debugging of
> > >   	  driver/firmware interaction.  The tracing is actually enabled by
> > >   	  a sysfs file 'mcdi_logging' under the PCI device.
> > > +config SFC_CXL
> > > +	bool "Solarflare SFC9100-family CXL support"
> > > +	depends on SFC && CXL_BUS >= SFC
> > > +	default SFC
> > > +	help
> > > +	  This enables SFC CXL support if the kernel is configuring CXL for
> > > +	  using CTPIO with CXL.mem. The SFC device with CXL support and
> > > +	  with a CXL-aware firmware can be used for minimizing latencies
> > > +	  when sending through CTPIO.
> > SFC is a tristate, and this new bool SFC_CXL defaults to it.
> > default y seems more obvious and follows convention in this Kconfig
> > file.
> > 
> > CXL_BUS >= SFC tripped me up in my testing where I had CXL_BUS M
> > and SFC Y. Why is that not allowable?
> > 
> > 
> 
> Not sure what you mean here. This means that if SFC can only be a module if
> CXL_BUS is a module and you want CXL with SFC.
> 
> You can have SFC as built-in in that case but without CXL support.

OK - get the desired constraint.

Why use >= with the tristates and why default to the tristate instead of
'y' - like this:

	depends on CXL_BUS
	depends on (SFC = m) || (SFC = y && CXL_BUS = y)
	default y

