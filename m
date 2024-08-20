Return-Path: <netdev+bounces-120191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3DE95885A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9290B2224D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D2E19068E;
	Tue, 20 Aug 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iq5dOiub"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB0190670;
	Tue, 20 Aug 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162372; cv=fail; b=ecNe2UKh5cAdgkA/6XFZ96/gFRwiu+XOeEMiJ+e2p483gGh5nE820hy868Na94+GSNgJ3O9ITNjT/2TSmAxaapxav7pbayCYZFezNlIOzCpN9kekuzvf/XwU9f6GOjIHQ68lX6lCqf0ym1jqyjWytZ3qKexSwSPRJ7oZczNNunQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162372; c=relaxed/simple;
	bh=yGL1JeGHjID7KUKEbgzUhGG6lssp1S3xBBARpxyyKcM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7mtoLRDrvAzuywJDf3QlK6osEk0jRuVVc49pwcU9bl+FkEF0bW5NbLq6UoRnOAJUxCgSfoElrbN6tTr0bfT/I+ZGXr6dullNL8VhQoJ2MVtxV3tSK+nnIBIySL0KuCxdLU6sYQR0eEc4UsF9x7R6N4P7mbA1vfHUp5lV1em4kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iq5dOiub; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724162370; x=1755698370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yGL1JeGHjID7KUKEbgzUhGG6lssp1S3xBBARpxyyKcM=;
  b=iq5dOiub4YR8ES9DsUtPbHScF8vEyKxs+kJxmVj00OZTgtmwfUjfPB3R
   7s0EeAAZGejLxxPOnGngOYdhSg5Zd+86SD0zTQrfMlWDPxeMzWm0cOIm+
   e+hlkwG/8xQREKt2bnIeJjAzHJbvr9XyICp6lR4EiemDsx45FxNt7afQh
   ilPppdXkY5RcqLA0Q/JmOkCnEpJJ/h6vX+S21VsjSlY9dMYyqbe9Yl5VZ
   IgxVKHRcZ0F9Web537smk25vrEqc7VCj0Vwb1t0GuM5O46LFETi1FYScx
   AjlDVwxpIuh1IR/S0TIwecwcSuCssuaSAWQwXTvNrNwcN8qRZa+KKLipn
   g==;
X-CSE-ConnectionGUID: rHV6iOkCTeqCmJsr9BrBeg==
X-CSE-MsgGUID: gHGvHy0OTte+LaHTit2Qag==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="21999158"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="21999158"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:59:29 -0700
X-CSE-ConnectionGUID: G9kCZmB1TX2vSiNa+zJeeA==
X-CSE-MsgGUID: jDEAwvPlQIO25LrdAUc7cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60797695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 06:59:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 06:59:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 06:59:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 06:59:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 06:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsRS/jEDbvxmle8ZtGhm9JAg2sF3MV5F5pVmSNsJERXRuCiccgEPrnsF5WZhDlGeWj9gCm1p/s0ghLfjE294nbVbTbTUJ1NvU7+D5BCb6wTVhCvmcJpmceDHgJBo6pMK5N5yx9HlheyE61aP/+LVReK6iFnZ7rB3+gVzRIYDJyqX1MI/hJSg8PClx4QVSgcwdKczOhYF9dIlqC771dEQZ0Fz6Z/YPio+sudVxXurUNpSi1wR/cFRw4EI1ZyPiZ/5TKTnXU1/8ck4goHNtCFA2EnNRzIvmS1OXdfiAI3tQWG3EXQOrAaaOVvM6wZWMaYm7jwATEc66DrUqYAkOcp3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilzB6f1DwRFtnmqTPqe9ncISdL753ZVRidd51ggqQvg=;
 b=ZNKbxZU6/UspDGi9SqY28D4s/6HqgSeXW+Ngf7SRYRLfa31SykQeP/E1YCYgS09b2WbH+MEva78P04L9ll2cvYYYotEe+iTP9oYKq7fXPf7bBDrbRFjs8U/xFQW9bF0ntCCduV91b6+j7ovHY0gGXErDhiun6L1gJHkUUJdFT1xEv+YmDNybx4s1CAgoXPldITV5mgJVP8wIESdRmcXjgy+lIL4T0V3+JzxZ/Ue6f6ayBITw28bnDZorl6y1Vs9cVhdoWP+fszOFD36o/aqpfrr5qGMPVz7X25k0+rM6w61uHHMfaJDSzUKXwrHhIdzvgNgqmyNZcJNoeHba7ydFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 13:59:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:59:25 +0000
Date: Tue, 20 Aug 2024 08:59:18 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur
 Tabi <timur@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 2/4] cxl/region: Prevent device_find_child() from
 modifying caller's match data
Message-ID: <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
X-ClientProxiedBy: MW4PR04CA0357.namprd04.prod.outlook.com
 (2603:10b6:303:8a::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de696a0-7f4a-4513-1c06-08dcc1204c9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RM+MK8OCXM/czKC8H1YCeeYlMpIGaXYZDOB2UDaih7K3AQmn4ESe9a68L6qv?=
 =?us-ascii?Q?HLyvpUrsRUakAvDniWx3EfFzV00tEQ9LoLaRDnOGAaQJrkAQ361u0lHPwYu8?=
 =?us-ascii?Q?t8Z9G1miszmvHHmIBJqocC/OeuNkkMBWdiDON2Lq0lqinEHHGmZa3YWJmXoO?=
 =?us-ascii?Q?0swNYz6GSl545Uu5BdD5tMcL6htu9hphhmtvQJZcH8TweOugmMJvfLrtirdD?=
 =?us-ascii?Q?kgI4M+DvHdO2YBDpwtzKtBTlgEX+7ctlcbUeD8IVrFBLaM1PS7w/Q5QbZRZA?=
 =?us-ascii?Q?IjSgjizMT754FXqCgnn27CRiGpCyBdiG+Ku5klXKLzsvMDLoGILLcn5TppaS?=
 =?us-ascii?Q?9AuRX8uD36fO+5CuU6m/uD4it1zInDMdszKDUqbgPb2xdcsh/N6AhrR15lva?=
 =?us-ascii?Q?78gRK7mkSRLZbpym5fV5USpNm803gV+A7wlAiR8S0+uSzo7wVggisCiaaRy5?=
 =?us-ascii?Q?O/sAn+1DmvloRG7tV0RInrD72xqn75KiWYwdUt685wZT5QnpbyFRswlvSi0P?=
 =?us-ascii?Q?3YlbYOctHtQWe8q2uMEdptiKKVs3u4nHzyiBrFagAUSZMYCreWEqCbd6s52T?=
 =?us-ascii?Q?80oIUTyv2A90HZ0GV2z0HfBb6ThcSXyO9bWP3a9z+qzNFZcm/NeIe+MqmSnM?=
 =?us-ascii?Q?Rh2Z7OIQW6cZvIVJQc3dFDmMha1wT6RIGdfSd6Ke+BSk9pxrgdfcOtYvTN1N?=
 =?us-ascii?Q?gCn1aCtJVTWDymEUC7AiKKre70A5YNjo/Bmn0+fDwylkbyf9Qb3DzPLOZi0w?=
 =?us-ascii?Q?1OW2fxExucYdLep2nvJezqa9Q278sVOebpL6/GpN17BKfT6prZV2frihSrmZ?=
 =?us-ascii?Q?XVaVtGfDAf20kqBNuSYf5hRGZUXW2HfVJF2pNQjw0k1QSdiY9MJXzO8623+U?=
 =?us-ascii?Q?jgCVvf2FCzxSVwlDIaPhL+0EV1oIH7Lu8B9xPa+fuHRxcDA9/CoLiuMsHQnU?=
 =?us-ascii?Q?NnJ31xO+58j/QBo3dfQLcXaUTS2h8eNLctRnWSP3EZZnB3+GMwqvIbgZ2um6?=
 =?us-ascii?Q?kuv6ALQvsFSZ2VYTJVZ99Rav18YUALAR6XJrzyFw7ANa99TIpZ6mCI44otVV?=
 =?us-ascii?Q?te3s4+HwcScdkB/Mtbx6mf1bhM7ZvLlLb/x4+GLwvOuELmuvAwYhE40UY/Rh?=
 =?us-ascii?Q?yHmN2fUU5uH96tie3yvL5QmV7x6lUwSAFHyjmq+yfxZ1L7jAaMANRRM1yEnk?=
 =?us-ascii?Q?37zOMcmJH55fRxHZs97FJkxGkThtXqJgPqPLcRm5cj6rBSmxkBUfrmcov8+l?=
 =?us-ascii?Q?NwFk5oqb24w1DvZXOMBLak2fje9BAhC2QQ5ru4wiySntbtc5XF1FZ6aAe2Sv?=
 =?us-ascii?Q?SaX3Ao0SfBeN0h4zZ2vjB3tGKeTXjPqu6SW9w9/g4Jq5xEaQvrhSStcG+vOA?=
 =?us-ascii?Q?IcjZxTJjkVKkQEClUCwzIN8OO3es?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5oCgon0ORmK8P0izb/HlVYL3BHM1W1qFhhglMc6Jxq30z1eGKRQLSCsAZfkb?=
 =?us-ascii?Q?wMQWpoFr/MhJA/Ali5AeHoDJPPjzFpITXiyu+2VJ6Hu/drE+A9fddlyxZ63a?=
 =?us-ascii?Q?Y5dShBJXmylepyrBQUO2kRorn9GHOM69TqOELEhAkBuyvIYvx2rvhzIS5jYA?=
 =?us-ascii?Q?TV6FcmRQYFfa7+6FDqVKwZGav8ZH8YB0MprO4eNJP6JwM/DPejZtbgnBCJq4?=
 =?us-ascii?Q?OyA/HvR1aV7W6CS+xcuOy9/D8T3hlAO4YYuqV0fJboI8/khNtbUqPNQDabv5?=
 =?us-ascii?Q?J4p69zg1Rnik2/c7qrv8evHyo1dLOVPnubbn3vN6e7QPD+gilld/O3/P8PLs?=
 =?us-ascii?Q?Kj8NzwEuE+CBY+Yx5fYHS4CynSVOQab0RsZa4A21TAAUfj23IhfciWo33TZs?=
 =?us-ascii?Q?jM++I2SiG7zL09uT0ev/WstXJmzAAi+ogiFePNDsQyfpihRku09Jt+lsYPeb?=
 =?us-ascii?Q?OwOfEIqDpwc4WTOIwHKY0wGuGm+6ToBUAyWj2NRywRo2mhOL602mXVEvCAoh?=
 =?us-ascii?Q?yrLr+8Im2lFXTs7T7qsfUFn71jJvXMP3kA4rhi3nLKqXTh7pGiVE1EWw3XzU?=
 =?us-ascii?Q?lzat5AmTB2O/gzUFmAxY6sppaYeagO8a0ntniDptaF4H+x+AsyCrsuwbM35V?=
 =?us-ascii?Q?Pvorx4tkjIKLdMacXIOc0rVo8OzlHBtYgykZo2xlmGojg/LqkeYbfR5MOOmg?=
 =?us-ascii?Q?7GjlUxnkHdV1EJxTkMp5fRSg6Jm/PGWWwSnqp2WaZTzzRurLgBoAXYwfq3/H?=
 =?us-ascii?Q?qiif86lLF5lZkmw3/IteoXz+E4fjp1t6dnlGjEHQOX8Nf55/36s0nazrK274?=
 =?us-ascii?Q?Jyoa8wTdbVwIRFRdE50d7IVoqDYGutWbXd+cALwGvb21xz/yj3opVU9UW1kA?=
 =?us-ascii?Q?cFndlChgQKrPE5BS3X2cRzBM02xNqpgUhg59YMsa3xGV5qSeA0+DfIkuB/uS?=
 =?us-ascii?Q?kIfDbqW5og8+uFHLFwiDskbtGy+JLCreGJedlfc/naKG2U204qVuLKPomvF3?=
 =?us-ascii?Q?0xWicU+vAUA6MpBFzAcSowC549nVUEZNJ0pJ3TVAg9N0JptZWNux6di/72sh?=
 =?us-ascii?Q?Do4Ny5d9MlAkKkXE50qwkt4tr4E+kFZUIgtpGTbo9JDBWQYlsWoc+jJ66L4l?=
 =?us-ascii?Q?N1CJGOTASQmHWR6dQIW5Orcg+JCUAhZM9+pRktFhSJoz8XnCdfowZG/wbGZR?=
 =?us-ascii?Q?wYy+QGVjPnAY7YbuIIG0QCaaOQ3xOSNMzEir4ntr7lL5wHf2wZBTt3u/YrJw?=
 =?us-ascii?Q?ZCI2lOqEjQkEhhPqP6IxYQVnAI2LYl5mibTSQyY26OsKTsGm+xLoyFbauuVm?=
 =?us-ascii?Q?Ir1fFBpFzgQ5WGZGvB4wTghZ2ih7zTXjd75J66jL6MgerQZOS/MhPh51MkoZ?=
 =?us-ascii?Q?7F9rMc9tQUKsgf1UoPqyTkTRyC8GmOjI0iFfR+O+lq0ITbm+frBUL5RFHGbg?=
 =?us-ascii?Q?/7dXs1nhWbH7f5OJhCZvoyBUmLmoR13R8+AL3Rq1Aqrpk99hkmcbBLMFdgnG?=
 =?us-ascii?Q?H64j9R66M3bW69NOUEUobtBnwK+8mCx8GRAya/CY5gZV+0EozUqD3Y/aM5bF?=
 =?us-ascii?Q?O1ny6ihwTWp2f0B/1wab6EE03Guui/tOowybwSHU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de696a0-7f4a-4513-1c06-08dcc1204c9e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:59:25.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQjbua+2ItgpOSM/xi9Gw7Thw6aXnk4YbhUVkoWT8+ZFZpwgtbm2xNgdjsbmTJkL1GLKHNXntBBHJ6odSIXXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but match_free_decoder() as the old API's
> match function indeed modifies relevant match data, so it is not
> suitable for the new API any more, fixed by implementing a equivalent
> cxl_device_find_child() instead of the old API usage.

Generally it seems ok but I think some name changes will make this more
clear.  See below.

Also for those working on CXL I'm questioning the use of ID here and the
dependence on the id's being added to the parent in order.  Is that a
guarantee?

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/cxl/core/region.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..8d8f0637f7ac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -134,6 +134,39 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
>  	return &cxl_region_access1_coordinate_group;
>  }
>  
> +struct cxl_dfc_data {

struct cxld_match_data

'cxld' == cxl decoder in our world.

> +	int (*match)(struct device *dev, void *data);
> +	void *data;
> +	struct device *target_device;
> +};
> +
> +static int cxl_dfc_match_modify(struct device *dev, void *data)

Why not just put this logic into match_free_decoder?

> +{
> +	struct cxl_dfc_data *dfc_data = data;
> +	int res;
> +
> +	res = dfc_data->match(dev, dfc_data->data);
> +	if (res && get_device(dev)) {
> +		dfc_data->target_device = dev;
> +		return res;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * I have the same function as device_find_child() but allow to modify
> + * caller's match data @*data.
> + */

No need for this comment after the new API is established.

> +static struct device *cxl_device_find_child(struct device *parent, void *data,
> +					    int (*match)(struct device *dev, void *data))
> +{
> +	struct cxl_dfc_data dfc_data = {match, data, NULL};
> +
> +	device_for_each_child(parent, &dfc_data, cxl_dfc_match_modify);
> +	return dfc_data.target_device;
> +}
> +
>  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> @@ -849,7 +882,8 @@ cxl_region_find_decoder(struct cxl_port *port,
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
>  	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		dev = cxl_device_find_child(&port->dev, &id,
> +					    match_free_decoder);

This is too literal.  How about the following (passes basic cxl-tests).

Ira

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c              
index 21ad5f242875..c1e46254efb8 100644                                         
--- a/drivers/cxl/core/region.c                                                 
+++ b/drivers/cxl/core/region.c                                                 
@@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
        return rc;                                                              
 }                                                                              
                                                                                
+struct cxld_match_data {                                                       
+       int id;                                                                 
+       struct device *target_device;                                           
+};                                                                             
+                                                                               
 static int match_free_decoder(struct device *dev, void *data)                  
 {                                                                              
+       struct cxld_match_data *match_data = data;                              
        struct cxl_decoder *cxld;                                               
-       int *id = data;                                                         
                                                                                
        if (!is_switch_decoder(dev))                                            
                return 0;                                                       
@@ -805,17 +810,30 @@ static int match_free_decoder(struct device *dev, void *data)
        cxld = to_cxl_decoder(dev);                                             
                                                                                
        /* enforce ordered allocation */                                        
-       if (cxld->id != *id)                                                    
+       if (cxld->id != match_data->id)                                         
                return 0;                                                       
                                                                                
-       if (!cxld->region)                                                      
+       if (!cxld->region && get_device(dev)) {                                 
+               match_data->target_device = dev;                                
                return 1;                                                       
+       }                                                                       
                                                                                
-       (*id)++;                                                                
+       match_data->id++;                                                       
                                                                                
        return 0;                                                               
 }                                                                              
                                                                                
+static struct device *find_free_decoder(struct device *parent)                 
+{                                                                              
+       struct cxld_match_data match_data = {                                   
+               .id = 0,                                                        
+               .target_device = NULL,                                          
+       };                                                                      
+                                                                               
+       device_for_each_child(parent, &match_data, match_free_decoder);         
+       return match_data.target_device;                                        
+}                                                                              
+                                                                               
 static int match_auto_decoder(struct device *dev, void *data)                  
 {                                                                              
        struct cxl_region_params *p = data;                                     
@@ -840,7 +858,6 @@ cxl_region_find_decoder(struct cxl_port *port,              
                        struct cxl_region *cxlr)                                
 {                                                                              
        struct device *dev;                                                     
-       int id = 0;                                                             
                                                                                
        if (port == cxled_to_port(cxled))                                       
                return &cxled->cxld;                                            
@@ -849,7 +866,8 @@ cxl_region_find_decoder(struct cxl_port *port,              
                dev = device_find_child(&port->dev, &cxlr->params,              
                                        match_auto_decoder);                    
        else                                                                    
-               dev = device_find_child(&port->dev, &id, match_free_decoder);   
+               dev = find_free_decoder(&port->dev);                            
+                                                                               
        if (!dev)                                                               
                return NULL;                                                    
        /*                                                                      

