Return-Path: <netdev+bounces-120446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EEB959634
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3991F21DCF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49A1ACE07;
	Wed, 21 Aug 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdYhYq/x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBA199FD2;
	Wed, 21 Aug 2024 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225944; cv=fail; b=Pi85cGHGKGSCQSp4jq44z9CZGuLp+kVmj2Vk0nF/elmckr+rsvmv0M2vMQ0RaYCmNKqJq4eHUlc6Jb2Tg56zOSxSh5K54B0qwG/YjX8XXnyb4YfsUyEZfjI0xikZt73bXFi86aRPf407nob+Yo7CnGjJmZLab697FEmmWqhJMyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225944; c=relaxed/simple;
	bh=4s7WWnLF/BmYFiNtui37MIxe1w/orhBR+9xA/tWYRyU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yn98z5fwFtKjYTEpl48bCCz/E36nnDlqI+NxV/WMElJ+1QUPp3hBw6B/OYM8tC/Bo6KEWpcg0mGdSUnF2o2iVgR/053E+8N6HRrJoxEFbKEDkz9EHXLUuDAIft4oMDolXEwoNnZ1Yb0WjCVrDei4h20J3yuSp1Y4zGJ72kG/+9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdYhYq/x; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724225940; x=1755761940;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4s7WWnLF/BmYFiNtui37MIxe1w/orhBR+9xA/tWYRyU=;
  b=WdYhYq/xkZVKZIW5WZTTgqWKwAm8dkkuMx9FtIvkbTr7ENjvK6W7VM0t
   r0zQ48Qn54Rbb5C6c0Lp6qTGrypD3Ckho+PkCSdGdvLQjf6ICzhkCNsE7
   Q+dlaS6Y7C7qljAzXVAq5CYWJU+I3ysS/v7wzmOeEATsGysGYaRXUmEaQ
   K01Tvj5S2r0wijCnHUv9fwS+E2du30WUDC1eSTN71IJN0Et0PBsNHbDtB
   a9UjB5taT2sMTnaN1hwBdFWAP86dSUIdHnlFBTIA9Zs9ADhL7nJuYEKZ+
   75ZUrHmnanylFjbKJTX3E7/HBrXqrjuc9zmFgVb0uI6qJXVNYDOw9Q7kl
   g==;
X-CSE-ConnectionGUID: B9Eryz7DQgei1gKTQpLhTw==
X-CSE-MsgGUID: fmlYXFscQxmHaIBHapRIlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22436297"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22436297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:38:49 -0700
X-CSE-ConnectionGUID: ySI8xnR4SsSl7Pd+M95oPA==
X-CSE-MsgGUID: vshg1Hg4Qrqpxj+I6OQ24Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61156180"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 00:38:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 00:38:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 00:38:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 00:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKxriPTH6X478AHFuN7NkWgQPIDik2ck0P73CLC6RocwJDhKmt9FU16Gp5fp439fTfr5MlnlpzyqQpocf7QD205EufFx47pKPC6OeNnhQnq1W+VWts0uZpWm+IcmQLIrNkJs2bZuuuEMi2TDZsv8iFB+UL1DNdbUPPr6WWlNtji1W2GHgyYy1tlHOIuUz09uFtmlKP0NvY3TZeBZHiHmvJlKRDXtkM2Hzt0UTTjt8d9z03naMjJlmkGlL5nPO7ACa39P2euz2WuinMJxDF2Lam3Q4mxL7LncNny7T4C5aq3nLsMDX4jtgLoHwnLIoN3dEt3ErnBqHQk+tM/4yLj/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O28VWLOc2sy88rKH3ioMT0dpUQIKFuxah8s75wAT3as=;
 b=pAFgpbSpQJSxg321xUBU3vpoq15CDkBT7y7WUs+RpNQtcKqBv3b6dvE5i1YSXMUG0N/tjMtNOtZsCWtM3O57CNLaDQ5tFG+QdcfzH8rLqSgd04JOrkJ5gGMTXoZzr/qWOPYSgCaBuAbE2HSz1zbFCaQYcJNbmmYPY7Q0rn84OhMlSVODLGKiyzvO7f386UEXBFtBzHvC0od6nwFgFIfKIIGSstVV1zQlYuxuvmOmIpUrCe19x0M9Y5nLxlW35ddChaX3ImaZeusxpaR5pG9jxgZrTUxEL4Z0lm4uc/5uXX5t5y5AN4I3ipKgFU/rRMdxgTp13Bvzm3Q88ual2C/b7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:38:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 07:38:37 +0000
Date: Wed, 21 Aug 2024 15:38:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: sunyiqi <sunyiqixm@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, sunyiqi
	<sunyiqixm@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] net: do not release sk in sk_wait_event
Message-ID: <202408211524.546a8e56-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815084907.167870-1-sunyiqixm@gmail.com>
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd2af1e-aaa8-413a-fabb-08dcc1b444a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mo+aiF0zdYa6f5hQlkc9oeNs+/erqQdpd/31rSET38qqzNhrMPjPocjrxs?=
 =?iso-8859-1?Q?pJA4kz5johTSna7jpzQ2NpinH2wFWAw5NmFTxC2nENBKk4OfbIdCVCkCk9?=
 =?iso-8859-1?Q?9uE7HJVAAS1aCZdC8/hUi9vqapMQpbUZ00y3c70LueL9eqB5OvUeNaDoZO?=
 =?iso-8859-1?Q?+KshPqanqQMJ6qJCEX5zmweRm8NH4Pm0pZsvKj3Q93X5AdN2qEFn0x1JgD?=
 =?iso-8859-1?Q?hxTqrGhQCxCmsAb28UXSRVsbbfN8hPxPXKSLXutNN5uWvE02yWEE/ETIOV?=
 =?iso-8859-1?Q?HSaMVoWyTVKV3tMCnrMP89g2KN4Wt6RtnCfxurpDn1IpLCmTz3/ORQn1ap?=
 =?iso-8859-1?Q?N2Q27az/c65r/aAamiF2OPY0hMPy18f+5G8gqykDc25y+3taYiHyNHeW1n?=
 =?iso-8859-1?Q?ruumhXKDAsLB85iZnhewPNmu8n3qcV1OJJ2ncNpRXrDFvKH6AHrnQleCKD?=
 =?iso-8859-1?Q?icGKC6bMxQjeS/HgPb4/aMhYo9yDZSyjjWYipb720D3ubAHX//Fuq/Y1kH?=
 =?iso-8859-1?Q?8eLgwgyZVlip/GuiBC53ZFgkgylAXTAdtsqA0SzWjBJjQciHNzobW544H/?=
 =?iso-8859-1?Q?wCghBa4yeBlw+THgRkdC7d92cKI2Rlo5AdP6vKhuG9Ui1J1ZNyXRMNDXE2?=
 =?iso-8859-1?Q?U2lUo9z4qMXgWiGv4S3xLdNDtG6ZSczDJZjrJf3PBpYNeAdfVce/JsZ4/x?=
 =?iso-8859-1?Q?lxhYiAMwL/FsEb7o66Vp1TeLc2hZhJwh2d/eZ5PPzq6h0wAfjm4eN0T4Qn?=
 =?iso-8859-1?Q?ESg8iHObvRnmNV+MdKkn3hKEJp5Lfbckc+lwCRLGw9Za2un0M3+GDG0foW?=
 =?iso-8859-1?Q?epuMX59HHHEoEmgcdt7sZ95szOO3l6i/VYBytp7bQQ/O58iGXxkdVP/Tz3?=
 =?iso-8859-1?Q?ziWPcgEPLW5XsDqEWRl7IVHLx86MX0P+dRH/7DX2KHz1XTA7wJwPSNCQ+4?=
 =?iso-8859-1?Q?emHb5Mi3oHsE6iqt4V7YxPYXxpgj+dfnEjzBYZlp+3G8mX2apjDtumR8hS?=
 =?iso-8859-1?Q?QZphCASbWguSR5zaNkFHuwQFt7d00+Rb9mJGF/m7aAbJgemNFABBGiF8RV?=
 =?iso-8859-1?Q?oT65Lv3tnPJI+aZdxj7S8NQsz73pKqZUXg229KmA46LaMdZgkApz9MIp+u?=
 =?iso-8859-1?Q?C3QKvcr3xn5cI07UJQAlbyoSb35EJS0D2EQtUusDA9tEkuYZK71xf3TORJ?=
 =?iso-8859-1?Q?YNWHf5smrdjDL9Yk4/p29Lv4w1NFC0zyEsA09iieRx2J85xpyCzkh32kvT?=
 =?iso-8859-1?Q?Qx+xnnfjRASYDz0hDZ/UxUix5Ox9FS2Edkl1BgABhgmgb/1nT8ho5mEPPL?=
 =?iso-8859-1?Q?d4WXYHOA1r/8ueMkT4IPJDBlk+FN7slnR4xAuI0wDlhAP4XqGPZd+xCmoJ?=
 =?iso-8859-1?Q?o0Blli+oX9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KgE1SZSH/QhmNT+bcZLIM+z/+zONS6xJUERhaWg8BFDfEVYpI8JKylUzc8?=
 =?iso-8859-1?Q?siAtV6BdLeG6AbtvI4LNRYjMU6H0GHqVZM8C4u6s++ZG2Y24hn2o1rjEix?=
 =?iso-8859-1?Q?Bh2zERevvocKnr67IzrR4PJZTS6Itp4Q25gnouBrPAKO2z/uD2hb6lhL/5?=
 =?iso-8859-1?Q?VbErhh1K+qZLYatSr0xBaJo9CU2gwzFudOD2+sYzBwCG2fvKuHDyAeBXH6?=
 =?iso-8859-1?Q?bRGFkbxGua0B/QWc4IZO5DJon5o5KbHijkC+YiSFtN610pq3VCYHugFq1Q?=
 =?iso-8859-1?Q?TmV/v8iIAiXM4ayqdCu94CFcWL4cLt9AOR62q7v9V+5mH1LkPYyYszluS+?=
 =?iso-8859-1?Q?FI/CNGkqId++PtuBn59EjTE1Uw4L80J5W/856ldhXGLroaBSSHaz1JpGZQ?=
 =?iso-8859-1?Q?ccd3R/pnO4fJZH6IUs2Qd/1asHArXhLJOhcH84CvIK9F7jFNbGLnlLA8MB?=
 =?iso-8859-1?Q?Qy5HhLsvyVjyU1vnUSteGSH4Z6/YVch7euz4W8BEbnaejQSYpABC2Ox8kJ?=
 =?iso-8859-1?Q?NuanwoPliOpGmAk1W5Oeb0s6vwJzyLBOt2Ryj7JVRusJd8WeITmSLdh9/Z?=
 =?iso-8859-1?Q?bjXwBmBIrS8lXrlbcpjoNIR+CJnlaErPCAkJiwN3E2kv5NrKknZBIa92AX?=
 =?iso-8859-1?Q?Y6xnBpc+LWCNidW2+XXcQyqDjjlX0b/E+fjvsMwWvO+l+5Xjlk1KrdsL1j?=
 =?iso-8859-1?Q?I3GQRpqmOueVFpQ0X0bMqkaLUtsXV3nJ94Fh4OZsxjlNg1MRxgn48fzYEf?=
 =?iso-8859-1?Q?LA9ftJYWtO4szNYHAeSyvIZTID1NB/lMdBM6pkavmrz2H2EzooqAGSmQN1?=
 =?iso-8859-1?Q?V4f+WGQ6jNPHanvaDQULL34a9FMZ9P4Rj35m7AuhRUgVnIqsioVCP8vGYs?=
 =?iso-8859-1?Q?aeUxkcce7ZtwaL8wrr5m/0EcCQqkrRgJoqCkJ9LxOuf/xkNZEMcg7qqLJQ?=
 =?iso-8859-1?Q?T0Eg7Chqn8n3/Ka+RyRBdnQDnAWj+sAt6PPkbTtda7/SqFYsC6qiCr0sxN?=
 =?iso-8859-1?Q?rywfuVLhbL8Rf0iRkEzXGYF5HGjJvPSS/vifr1ucvjlq9lM1J9jQ5/QcxY?=
 =?iso-8859-1?Q?QX3yEV6/bIISp7ROyQgBCD3GPZ5XYBRffhfFnrSn7QznHHm59V8dGVPV30?=
 =?iso-8859-1?Q?BcheJJAIZEQyAaWDG4H2MjONnqp8v87NPTv5/9Mt1MSztYUzUNwt6+UTfb?=
 =?iso-8859-1?Q?ULAX4s9vH5QrWtcnCMJ2/AnZA+ET7Ay2to2QJlRv2osg7pjKeICkeCheVW?=
 =?iso-8859-1?Q?5ZexPBF/lq7dXJ+YDInmHv5UR4ZSrbtZ3PDyOJk5tTMBGSeHOcXskExAba?=
 =?iso-8859-1?Q?O4YKvPLqTdIE2OTrdGX3OKRa5C1dodYN2+DIOwjHQqKs32H6smWZ/7EK7Q?=
 =?iso-8859-1?Q?SbimJb6GQAMUXaBfBo6b4Jg/RwBocvx1ssXajP2bHKGNGnfscHu/5EUtnv?=
 =?iso-8859-1?Q?ue4nsnWsV3D9YJHYrvfiaV6sLG90qApyqICXhPidyLZJkY0+pCX4UrFMG5?=
 =?iso-8859-1?Q?jSdPq9fDO12ORY8lTfO5V/PlLDtgvqOkRMQnNB217/i4vWKZ+NlkH47VLJ?=
 =?iso-8859-1?Q?9SWk5iyEJUGi6MPL4xhlSZu46+Ja4XtIm6Nj/jU50neeePCVnLZqkgvKR6?=
 =?iso-8859-1?Q?he7eg0wZsL2j1R4DMkuEU1KZrSp5o7i4r8V+Zs7yQbljrXlkyvqUIf/A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd2af1e-aaa8-413a-fabb-08dcc1b444a1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:38:37.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d8iw/qsG2N99Ub4UZ17u8zAiAWlJ2dq98+zOwVOOUpgwNi1cU/RfMqEVZkzawisaTFbz2B6r3IjUvkWdwygdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -100.0% regression of stress-ng.sock.ops_per_sec on:


commit: 485a7c1b69390b4db80d68c086dc5b619465c9c6 ("[PATCH] net: do not release sk in sk_wait_event")
url: https://github.com/intel-lab-lkp/linux/commits/sunyiqi/net-do-not-release-sk-in-sk_wait_event/20240815-175112
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git a9c60712d71ff07197b2982899b9db28ed548ded
patch link: https://lore.kernel.org/all/20240815084907.167870-1-sunyiqixm@gmail.com/
patch subject: [PATCH] net: do not release sk in sk_wait_event

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sock
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408211524.546a8e56-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240821/202408211524.546a8e56-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sock/stress-ng/60s

commit: 
  a9c60712d7 ("Merge branch 'uapi-net-sched-cxgb4-fix-wflex-array-member-not-at-end-warning'")
  485a7c1b69 ("net: do not release sk in sk_wait_event")

a9c60712d71ff071 485a7c1b69390b4db80d68c086d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7918          +172.2%      21554        uptime.idle
 4.039e+08 ±  4%   +3375.4%  1.404e+10        cpuidle..time
   3139094 ± 54%     -65.0%    1097704        cpuidle..usage
  93316867           -99.6%     370101 ± 18%  numa-numastat.node0.local_node
  93427347           -99.4%     517330 ± 12%  numa-numastat.node0.numa_hit
  92697012           -99.6%     339810 ± 20%  numa-numastat.node1.local_node
  92828493           -99.5%     424633 ± 15%  numa-numastat.node1.numa_hit
     58497 ±  7%    -100.0%       7.17 ± 84%  perf-c2c.DRAM.local
      2382 ±  7%     -98.9%      27.17 ± 20%  perf-c2c.DRAM.remote
      6334 ±  6%     -99.5%      28.67 ± 18%  perf-c2c.HITM.local
    539.33 ±  5%     -96.8%      17.50 ± 31%  perf-c2c.HITM.remote
      6873 ±  6%     -99.3%      46.17 ± 18%  perf-c2c.HITM.total
      5.25 ± 10%   +1799.0%      99.75        vmstat.cpu.id
     91.82           -99.9%       0.14 ±  7%  vmstat.cpu.sy
    357.35           -99.2%       2.68 ± 50%  vmstat.procs.r
  27285633          -100.0%       2512 ±  4%  vmstat.system.cs
    529503           -95.4%      24285 ±  7%  vmstat.system.in
      3.05 ± 17%     +96.6       99.67        mpstat.cpu.all.idle%
      0.00 ±100%      +0.0        0.02 ± 19%  mpstat.cpu.all.iowait%
      0.48            -0.4        0.04 ±  3%  mpstat.cpu.all.irq%
     19.79           -19.8        0.00 ± 36%  mpstat.cpu.all.soft%
     73.65           -73.6        0.08        mpstat.cpu.all.sys%
      3.02            -2.8        0.18        mpstat.cpu.all.usr%
     12.67 ± 56%     -92.1%       1.00        mpstat.max_utilization.seconds
    100.00           -97.6%       2.35 ±  2%  mpstat.max_utilization_pct
    512298 ± 18%     -53.4%     238782 ±  5%  numa-meminfo.node0.Mapped
     24524 ± 39%     +62.3%      39800 ±  5%  numa-meminfo.node0.PageTables
    566127 ±  3%     -95.8%      24008 ±  5%  numa-meminfo.node1.Active
    566113 ±  3%     -95.8%      23992 ±  5%  numa-meminfo.node1.Active(anon)
   2747024 ± 31%     -83.3%     458096 ± 39%  numa-meminfo.node1.Inactive
   2746948 ± 31%     -83.3%     457980 ± 39%  numa-meminfo.node1.Inactive(anon)
    967060 ± 11%     -99.0%      10023 ±121%  numa-meminfo.node1.Mapped
     27090 ± 35%     -65.6%       9308 ± 17%  numa-meminfo.node1.PageTables
   2794844 ± 30%     -99.1%      26390 ±  6%  numa-meminfo.node1.Shmem
    569024 ±  2%     -95.0%      28197        meminfo.Active
    568987 ±  2%     -95.0%      28165        meminfo.Active(anon)
   6545198 ± 16%     -49.1%    3334716        meminfo.Cached
   8122714 ± 13%     -39.8%    4892326        meminfo.Committed_AS
   3879368 ± 24%     -66.5%    1297885 ± 12%  meminfo.Inactive
   3879138 ± 24%     -66.5%    1297660 ± 12%  meminfo.Inactive(anon)
   1477918 ±  2%     -83.2%     248731        meminfo.Mapped
  10781439 ±  8%     -28.0%    7762846        meminfo.Memused
   3461321 ± 30%     -92.8%     250853        meminfo.Shmem
  10898889 ±  8%     -15.6%    9202079        meminfo.max_used_kB
    834112          -100.0%       0.00        stress-ng.sock.byte_average_in_queue_length
    798960 ± 35%    +224.0%    2588527        stress-ng.sock.byte_average_out_queue_length
    173337          -100.0%      12.46        stress-ng.sock.messages_sent_per_sec
   4561553          -100.0%     448.00        stress-ng.sock.ops
     76023          -100.0%       7.34        stress-ng.sock.ops_per_sec
 8.575e+08          -100.0%      64.83 ± 14%  stress-ng.time.involuntary_context_switches
     96104            -4.0%      92291        stress-ng.time.minor_page_faults
     17471          -100.0%       1.00        stress-ng.time.percent_of_cpu_this_job_got
     10191          -100.0%       0.71 ±  3%  stress-ng.time.system_time
    334.28           -99.9%       0.17 ±  5%  stress-ng.time.user_time
 8.622e+08          -100.0%       2163        stress-ng.time.voluntary_context_switches
    128351 ± 18%     -54.0%      59054 ±  5%  numa-vmstat.node0.nr_mapped
      6176 ± 40%     +60.3%       9903 ±  5%  numa-vmstat.node0.nr_page_table_pages
  93396523           -99.4%     517565 ± 12%  numa-vmstat.node0.numa_hit
  93286044           -99.6%     370336 ± 18%  numa-vmstat.node0.numa_local
    140292 ±  3%     -95.7%       5974 ±  6%  numa-vmstat.node1.nr_active_anon
    686202 ± 31%     -83.3%     114574 ± 39%  numa-vmstat.node1.nr_inactive_anon
    240443 ± 12%     -98.9%       2638 ±117%  numa-vmstat.node1.nr_mapped
      6791 ± 35%     -65.8%       2321 ± 17%  numa-vmstat.node1.nr_page_table_pages
    696959 ± 30%     -99.1%       6577 ±  6%  numa-vmstat.node1.nr_shmem
    140290 ±  3%     -95.7%       5974 ±  6%  numa-vmstat.node1.nr_zone_active_anon
    686199 ± 31%     -83.3%     114573 ± 39%  numa-vmstat.node1.nr_zone_inactive_anon
  92804117           -99.5%     423580 ± 15%  numa-vmstat.node1.numa_hit
  92672638           -99.6%     338761 ± 20%  numa-vmstat.node1.numa_local
    140679 ±  2%     -94.9%       7154        proc-vmstat.nr_active_anon
   1632998 ± 16%     -49.0%     833351        proc-vmstat.nr_file_pages
    968473 ± 23%     -66.7%     322808 ± 12%  proc-vmstat.nr_inactive_anon
    367618 ±  2%     -83.2%      61923        proc-vmstat.nr_mapped
    862027 ± 30%     -92.8%      62383        proc-vmstat.nr_shmem
     38965            -6.8%      36332        proc-vmstat.nr_slab_reclaimable
    124313            -6.0%     116811        proc-vmstat.nr_slab_unreclaimable
    140679 ±  2%     -94.9%       7154        proc-vmstat.nr_zone_active_anon
    968473 ± 23%     -66.7%     322808 ± 12%  proc-vmstat.nr_zone_inactive_anon
    246757 ± 18%     -94.8%      12714 ± 44%  proc-vmstat.numa_hint_faults
    131080 ± 12%     -99.4%     810.83 ± 79%  proc-vmstat.numa_hint_faults_local
 1.861e+08           -99.5%     944616        proc-vmstat.numa_hit
 1.859e+08           -99.6%     712564        proc-vmstat.numa_local
     21455 ± 29%     -44.5%      11903 ± 44%  proc-vmstat.numa_pages_migrated
    704523 ± 13%     -91.2%      62163 ± 44%  proc-vmstat.numa_pte_updates
 1.471e+09           -99.9%    1226836 ±  3%  proc-vmstat.pgalloc_normal
   1170858 ±  4%     -51.4%     569424        proc-vmstat.pgfault
 1.469e+09           -99.9%    1228672 ±  6%  proc-vmstat.pgfree
     21455 ± 29%     -44.5%      11903 ± 44%  proc-vmstat.pgmigrate_success
      1.51           -36.8%       0.95 ±  4%  perf-stat.i.MPKI
 9.383e+10           -99.4%  6.083e+08        perf-stat.i.branch-instructions
      0.43            +3.4        3.79        perf-stat.i.branch-miss-rate%
 3.712e+08           -91.8%   30507919        perf-stat.i.branch-misses
     19.35           -13.1        6.22 ±  6%  perf-stat.i.cache-miss-rate%
 6.833e+08           -99.8%    1669451 ± 10%  perf-stat.i.cache-misses
 3.385e+09           -99.6%   12178757        perf-stat.i.cache-references
  28327876          -100.0%       2265        perf-stat.i.context-switches
      1.35           +29.9%       1.75        perf-stat.i.cpi
 6.377e+11           -99.6%  2.637e+09        perf-stat.i.cpu-cycles
      1052 ±  7%     -71.3%     301.76 ±  2%  perf-stat.i.cpu-migrations
      1429 ±  6%    +394.8%       7073 ± 13%  perf-stat.i.cycles-between-cache-misses
 4.857e+11           -99.4%  2.988e+09        perf-stat.i.instructions
      0.76           +10.1%       0.84        perf-stat.i.ipc
    125.84           -98.2%       2.24 ±  4%  perf-stat.i.metric.K/sec
     17986 ±  6%     -59.8%       7222 ±  2%  perf-stat.i.minor-faults
     17986 ±  6%     -59.8%       7222 ±  2%  perf-stat.i.page-faults
      1.43           -61.5%       0.55 ± 11%  perf-stat.overall.MPKI
      0.39            +4.6        5.02        perf-stat.overall.branch-miss-rate%
     20.31            -6.8       13.48 ± 10%  perf-stat.overall.cache-miss-rate%
      1.32           -33.0%       0.88        perf-stat.overall.cpi
    925.76           +75.9%       1628 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.76           +49.3%       1.13        perf-stat.overall.ipc
  9.15e+10           -99.3%  5.959e+08        perf-stat.ps.branch-instructions
 3.613e+08           -91.7%   29926582        perf-stat.ps.branch-misses
 6.756e+08           -99.8%    1608044 ± 10%  perf-stat.ps.cache-misses
 3.326e+09           -99.6%   11926187        perf-stat.ps.cache-references
  27798409          -100.0%       2219        perf-stat.ps.context-switches
 6.254e+11           -99.6%  2.588e+09        perf-stat.ps.cpu-cycles
    941.05 ±  8%     -68.5%     296.14 ±  2%  perf-stat.ps.cpu-migrations
 4.739e+11           -99.4%  2.928e+09        perf-stat.ps.instructions
     16959 ±  4%     -59.0%       6953 ±  2%  perf-stat.ps.minor-faults
     16960 ±  4%     -59.0%       6953 ±  2%  perf-stat.ps.page-faults
   2.9e+13           -99.4%  1.818e+11        perf-stat.total.instructions
   5204371          -100.0%       1604 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.avg
   7682820 ± 15%     -99.6%      30824 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.max
   4090321 ±  7%    -100.0%     143.87 ± 33%  sched_debug.cfs_rq:/.avg_vruntime.min
    255159 ± 25%     -98.6%       3519 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.90 ±  2%     -93.8%       0.06 ± 18%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_running.min
      0.34 ±  2%     -32.5%       0.23 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
      2382 ± 11%   +1019.8%      26682 ±189%  sched_debug.cfs_rq:/.load.stddev
     30048 ± 68%    +181.8%      84679 ±  7%  sched_debug.cfs_rq:/.load_avg.max
      3973 ± 74%    +194.0%      11682 ± 32%  sched_debug.cfs_rq:/.load_avg.stddev
   5204371          -100.0%       1604 ±  7%  sched_debug.cfs_rq:/.min_vruntime.avg
   7682820 ± 15%     -99.6%      30823 ± 23%  sched_debug.cfs_rq:/.min_vruntime.max
   4090321 ±  7%    -100.0%     143.87 ± 33%  sched_debug.cfs_rq:/.min_vruntime.min
    255159 ± 25%     -98.6%       3519 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.53           -89.4%       0.06 ± 18%  sched_debug.cfs_rq:/.nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.12 ±  5%     +99.4%       0.23 ± 10%  sched_debug.cfs_rq:/.nr_running.stddev
      5.33 ± 67%    +173.4%      14.56 ± 32%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    247.25 ± 13%    +121.9%     548.67 ±  3%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     32.60 ± 40%    +156.1%      83.51 ± 16%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      5.33 ± 67%    +173.4%      14.56 ± 32%  sched_debug.cfs_rq:/.removed.util_avg.avg
    247.25 ± 13%    +121.9%     548.67 ±  3%  sched_debug.cfs_rq:/.removed.util_avg.max
     32.60 ± 40%    +156.1%      83.51 ± 16%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    936.50           -83.3%     156.14 ±  8%  sched_debug.cfs_rq:/.runnable_avg.avg
      2094 ±  3%     -46.0%       1130 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    586.33 ± 17%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    188.89 ±  5%     +32.9%     251.07 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    585.27           -73.5%     155.25 ±  8%  sched_debug.cfs_rq:/.util_avg.avg
    438.83 ± 22%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    126.75 ±  7%     +97.0%     249.71 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
    652.42           -98.7%       8.73 ± 55%  sched_debug.cfs_rq:/.util_est.avg
      1409 ±  7%     -62.1%     533.50 ± 10%  sched_debug.cfs_rq:/.util_est.max
    400.25 ±  6%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est.min
    147.08 ±  9%     -57.9%      61.85 ± 25%  sched_debug.cfs_rq:/.util_est.stddev
    519373           +76.2%     915125        sched_debug.cpu.avg_idle.avg
   1258453 ±  8%     +28.1%    1611863 ± 21%  sched_debug.cpu.avg_idle.max
    193107 ±  5%     -12.7%     168533 ±  5%  sched_debug.cpu.avg_idle.stddev
     69255           -43.3%      39244        sched_debug.cpu.clock.avg
     69321           -43.4%      39260        sched_debug.cpu.clock.max
     69168           -43.3%      39220        sched_debug.cpu.clock.min
     42.19 ±  9%     -80.6%       8.20 ±  6%  sched_debug.cpu.clock.stddev
     62909           -37.9%      39085        sched_debug.cpu.clock_task.avg
     65633           -40.2%      39228        sched_debug.cpu.clock_task.max
     48891           -48.9%      24973 ±  2%  sched_debug.cpu.clock_task.min
      1059            -9.4%     959.90 ±  3%  sched_debug.cpu.clock_task.stddev
      3521           -94.1%     206.83 ± 19%  sched_debug.cpu.curr->pid.avg
      6093 ±  4%     -36.7%       3854        sched_debug.cpu.curr->pid.max
      1825 ± 45%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    582.09 ±  8%     +44.5%     841.37 ±  9%  sched_debug.cpu.curr->pid.stddev
    625107 ±  6%     +34.8%     842597 ± 24%  sched_debug.cpu.max_idle_balance_cost.max
     11913 ± 39%    +148.1%      29559 ± 44%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  6%     -72.2%       0.00 ± 17%  sched_debug.cpu.next_balance.stddev
      0.90 ±  2%     -93.7%       0.06 ± 20%  sched_debug.cpu.nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.33 ±  2%     -30.6%       0.23 ± 11%  sched_debug.cpu.nr_running.stddev
   3783489          -100.0%     601.41        sched_debug.cpu.nr_switches.avg
   4086725           -99.7%      12429 ±  9%  sched_debug.cpu.nr_switches.max
   1967335 ± 16%    -100.0%     115.67 ± 11%  sched_debug.cpu.nr_switches.min
    225133 ±  6%     -99.5%       1176 ±  5%  sched_debug.cpu.nr_switches.stddev
     69172           -43.3%      39230        sched_debug.cpu_clk
     68115           -44.0%      38175        sched_debug.ktime
     70010           -42.8%      40067        sched_debug.sched_clk
     73.23 ±  2%     -73.2        0.00        perf-profile.calltrace.cycles-pp.stress_sock
     49.51           -49.5        0.00        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     47.66           -47.7        0.00        perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.41           -44.4        0.00        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     38.68           -38.7        0.00        perf-profile.calltrace.cycles-pp.recv.stress_sock
     38.10           -38.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.stress_sock
     38.02           -38.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.stress_sock
     37.20           -37.2        0.00        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     36.42           -36.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.stress_sock
     36.27           -36.3        0.00        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.94           -35.9        0.00        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     35.87           -35.9        0.00        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     35.06           -35.1        0.00        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     33.43 ±  5%     -33.4        0.00        perf-profile.calltrace.cycles-pp.__send.stress_sock
     32.80 ±  5%     -32.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send.stress_sock
     32.72 ±  5%     -32.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.stress_sock
     29.87 ±  5%     -29.9        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.stress_sock
     23.84 ±  8%     -23.8        0.00        perf-profile.calltrace.cycles-pp.__send
     22.48 ±  8%     -22.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send
     22.43 ±  8%     -22.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     19.73 ±  8%     -19.7        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     18.54           -18.5        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     18.49           -18.5        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     18.27           -18.3        0.00        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     17.36           -17.4        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     16.87           -16.9        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     16.86           -16.9        0.00        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     16.78           -16.8        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     16.70           -16.7        0.00        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     16.21           -16.2        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     14.79           -14.8        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     14.37           -14.4        0.00        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     14.10           -14.1        0.00        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     14.10           -14.1        0.00        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     13.28           -13.3        0.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     13.14           -13.1        0.00        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     13.12           -13.1        0.00        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     13.04           -13.0        0.00        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     12.72           -12.7        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
     12.70           -12.7        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
     12.65           -12.7        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.skb_page_frag_refill.sk_page_frag_refill
     12.39           -12.4        0.00        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     12.21           -12.2        0.00        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.skb_page_frag_refill
     12.10           -12.1        0.00        perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof
     12.06           -12.1        0.00        perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof
     11.92 ±  2%     -11.9        0.00        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     11.72           -11.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
     11.68           -11.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
     11.40 ±  2%     -11.4        0.00        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      9.77            -9.8        0.00        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      9.08            -9.1        0.00        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      8.90            -8.9        0.00        perf-profile.calltrace.cycles-pp.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      8.86            -8.9        0.00        perf-profile.calltrace.cycles-pp.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      8.71            -8.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.skb_release_data
      8.67            -8.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page
      8.64            -8.6        0.00        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg
      8.48            -8.5        0.00        perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked
      8.41            -8.4        0.00        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
      8.33            -8.3        0.00        perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.skb_release_data.skb_attempt_defer_free
      8.13            -8.1        0.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      6.78            -6.8        0.00        perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      6.51            -6.5        0.00        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      6.46            -6.5        0.00        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      6.41            -6.4        0.00        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      5.78            -5.8        0.00        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      5.50            -5.5        0.00        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      5.50            -5.5        0.00        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      5.27            -5.3        0.00        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      5.10            -5.1        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      0.00            +0.5        0.53 ±  7%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main
      0.00            +0.5        0.53 ±  7%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main
      0.00            +0.6        0.64 ± 16%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.7        0.67 ± 15%  perf-profile.calltrace.cycles-pp.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.00            +0.7        0.69 ± 12%  perf-profile.calltrace.cycles-pp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.7        0.70 ± 12%  perf-profile.calltrace.cycles-pp.ct_idle_exit.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.7        0.71 ± 14%  perf-profile.calltrace.cycles-pp.sched_balance_find_dst_cpu.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common
      0.00            +0.7        0.71 ± 14%  perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.sched_exec.bprm_execve
      0.00            +0.7        0.71 ± 14%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.7        0.71 ± 15%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.71 ± 15%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +0.7        0.72 ± 14%  perf-profile.calltrace.cycles-pp.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.7        0.72 ±  9%  perf-profile.calltrace.cycles-pp.show_stat.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +0.7        0.75 ± 19%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.8        0.77 ± 19%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.00            +0.8        0.77 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.8        0.77 ± 13%  perf-profile.calltrace.cycles-pp.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.8        0.78 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.8        0.78 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.8        0.78 ± 15%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.78 ± 15%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.80 ± 18%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.8        0.80 ± 21%  perf-profile.calltrace.cycles-pp.update_rq_clock_task._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.8        0.81 ± 18%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.8        0.84 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.8        0.84 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.9        0.85 ± 18%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.9        0.89 ± 18%  perf-profile.calltrace.cycles-pp.write
      0.00            +0.9        0.90 ± 12%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      0.00            +0.9        0.90 ± 12%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.9        0.90 ± 12%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.00            +0.9        0.92 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.9        0.93 ± 35%  perf-profile.calltrace.cycles-pp.read.readn.perf_evsel__read.read_counters.process_interval
      0.00            +0.9        0.94 ±  9%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +1.0        0.96 ± 16%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +1.0        0.96 ± 18%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +1.0        0.97 ± 13%  perf-profile.calltrace.cycles-pp.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.00            +1.0        0.97 ± 12%  perf-profile.calltrace.cycles-pp.__vfork
      0.00            +1.0        0.97 ± 10%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +1.0        0.97 ± 17%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      0.00            +1.0        0.99 ± 35%  perf-profile.calltrace.cycles-pp.readn.perf_evsel__read.read_counters.process_interval.dispatch_events
      0.00            +1.0        1.02 ± 15%  perf-profile.calltrace.cycles-pp.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread
      0.00            +1.0        1.03 ± 25%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00            +1.0        1.04 ± 24%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.05 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.06 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.07 ± 25%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.decay_pcp_high.refresh_cpu_vm_stats
      0.00            +1.1        1.08 ± 24%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.decay_pcp_high.refresh_cpu_vm_stats.vmstat_update
      0.00            +1.1        1.10 ± 12%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.00            +1.1        1.10 ± 10%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +1.1        1.10 ± 36%  perf-profile.calltrace.cycles-pp.perf_evsel__read.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +1.1        1.12 ± 10%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.13 ± 51%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +1.1        1.14 ± 14%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.2        1.15 ± 16%  perf-profile.calltrace.cycles-pp.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +1.2        1.18 ± 26%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.readn.evsel__read_counter
      0.00            +1.2        1.18 ± 26%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.readn.evsel__read_counter.read_counters
      0.00            +1.2        1.18 ± 16%  perf-profile.calltrace.cycles-pp.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.2        1.19 ± 22%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +1.2        1.21 ± 10%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.22 ± 49%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.00            +1.2        1.22 ± 24%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.22 ± 10%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.25 ± 17%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.3        1.26 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.3        1.26 ±  8%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      0.00            +1.3        1.26 ±  8%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.3        1.27 ± 18%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.3        1.28 ± 22%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.decay_pcp_high.refresh_cpu_vm_stats.vmstat_update.process_one_work
      0.00            +1.3        1.29 ± 23%  perf-profile.calltrace.cycles-pp.read.readn.evsel__read_counter.read_counters.process_interval
      0.00            +1.3        1.30 ± 14%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.3        1.31 ± 24%  perf-profile.calltrace.cycles-pp.readn.evsel__read_counter.read_counters.process_interval.dispatch_events
      0.00            +1.3        1.31 ± 23%  perf-profile.calltrace.cycles-pp.decay_pcp_high.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.00            +1.3        1.32 ± 17%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.3        1.34 ± 13%  perf-profile.calltrace.cycles-pp.setlocale
      0.00            +1.3        1.35 ± 16%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.4        1.40 ± 49%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.4        1.42 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested._nohz_idle_balance.do_idle.cpu_startup_entry
      0.00            +1.4        1.42 ± 19%  perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.4        1.44 ± 49%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.6        1.56 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.6        1.59 ±  7%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.6        1.59 ± 12%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +1.6        1.59 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +1.6        1.59 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +1.6        1.59 ± 12%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +1.7        1.66 ± 19%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +1.7        1.70 ±  4%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.8        1.79 ±  9%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64
      0.00            +1.8        1.81 ± 10%  perf-profile.calltrace.cycles-pp._Fork
      0.00            +1.9        1.85 ± 10%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +1.9        1.85 ± 20%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.9        1.90 ± 37%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.readn
      0.00            +1.9        1.91 ± 13%  perf-profile.calltrace.cycles-pp.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.92 ± 24%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains
      0.00            +1.9        1.92 ± 10%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +2.1        2.14 ± 10%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.1        2.14 ± 15%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +2.2        2.16 ± 21%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs
      0.00            +2.2        2.19 ± 13%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +2.2        2.20 ± 20%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu
      0.00            +2.2        2.20 ± 13%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +2.3        2.31 ± 11%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.00            +2.4        2.36 ± 45%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +2.4        2.36 ± 45%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      0.00            +2.4        2.36 ± 45%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.00            +2.4        2.36 ± 45%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.00            +2.4        2.36 ± 45%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      0.00            +2.4        2.36 ± 45%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.00            +2.4        2.38 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.4        2.39 ± 16%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +2.4        2.43 ± 33%  perf-profile.calltrace.cycles-pp.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread.kthread
      0.00            +2.5        2.45 ± 32%  perf-profile.calltrace.cycles-pp.vmstat_update.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +2.5        2.48 ± 13%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.00            +2.5        2.50 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.00            +2.6        2.63 ± 18%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +2.8        2.76 ± 16%  perf-profile.calltrace.cycles-pp.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.8        2.85 ± 16%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +3.0        2.99 ±  6%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.00            +3.0        2.99 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      0.00            +3.0        2.99 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      0.00            +3.1        3.10 ±  5%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +3.1        3.10 ±  6%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +3.2        3.18 ±  8%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +3.3        3.28 ± 12%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      0.00            +3.3        3.29 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +3.3        3.30 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00            +3.4        3.38 ±  8%  perf-profile.calltrace.cycles-pp.read
      0.00            +3.8        3.80 ± 15%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +3.9        3.86 ±  5%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.9        3.92 ± 15%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +3.9        3.94 ± 11%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +4.3        4.28 ± 15%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +4.7        4.67 ± 10%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +5.0        5.02 ± 34%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +5.0        5.03 ±  8%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair
      0.00            +5.1        5.08 ±  8%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule
      0.00            +5.2        5.17 ± 12%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      0.00            +5.2        5.22 ±  8%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule.schedule
      0.00            +5.3        5.28 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.3        5.30 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +5.6        5.58 ±  8%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.balance_fair.__schedule.schedule.smpboot_thread_fn
      0.00            +5.6        5.60 ±  8%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +5.9        5.93 ± 31%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +6.1        6.10 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +6.2        6.17 ±  7%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +6.4        6.40 ±  3%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +6.4        6.41 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +6.4        6.41 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +6.4        6.41 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.00            +6.4        6.42 ±  3%  perf-profile.calltrace.cycles-pp.execve
      0.00            +7.5        7.52 ±  7%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +7.9        7.86 ± 16%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      0.00            +8.0        8.02 ± 15%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.main
      0.00            +8.0        8.02 ± 15%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.main
      0.00            +8.0        8.03 ± 15%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.main
      0.00            +8.1        8.09 ± 29%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.tmigr_handle_remote_up.tmigr_handle_remote.handle_softirqs
      0.00            +8.6        8.56 ± 14%  perf-profile.calltrace.cycles-pp.main
      0.00            +8.6        8.56 ± 14%  perf-profile.calltrace.cycles-pp.run_builtin.main
      0.00            +8.7        8.65 ± 28%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.tmigr_handle_remote_up.tmigr_handle_remote.handle_softirqs.__irq_exit_rcu
      0.00            +9.1        9.15 ± 26%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +9.5        9.51 ± 26%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +10.3       10.30 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +14.5       14.53 ± 19%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00           +14.6       14.65 ± 19%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00           +15.0       15.04 ± 14%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +15.0       15.04 ± 14%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00           +15.0       15.04 ± 14%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00           +20.4       20.41 ± 15%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +21.0       20.95 ± 15%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +34.3       34.34 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00           +35.0       34.99 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00           +38.9       38.87 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +47.2       47.16 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +47.2       47.18 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +47.2       47.18 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00           +49.5       49.54 ±  5%  perf-profile.calltrace.cycles-pp.common_startup_64
     73.23 ±  2%     -73.2        0.00        perf-profile.children.cycles-pp.stress_sock
     94.70           -68.3       26.36 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     94.39           -68.1       26.30 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
     57.83           -57.8        0.00        perf-profile.children.cycles-pp.__send
     49.62           -49.6        0.00        perf-profile.children.cycles-pp.__x64_sys_sendto
     49.58           -49.6        0.00        perf-profile.children.cycles-pp.__sys_sendto
     47.91           -47.9        0.00        perf-profile.children.cycles-pp.tcp_sendmsg
     44.49           -44.5        0.00        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     40.87           -40.9        0.00        perf-profile.children.cycles-pp.recv
     37.26           -37.3        0.00        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     37.23           -37.2        0.00        perf-profile.children.cycles-pp.__sys_recvfrom
     36.30           -36.3        0.00        perf-profile.children.cycles-pp.sock_recvmsg
     35.96           -36.0        0.00        perf-profile.children.cycles-pp.inet_recvmsg
     35.91           -35.9        0.00        perf-profile.children.cycles-pp.tcp_recvmsg
     35.11           -35.1        0.00        perf-profile.children.cycles-pp.tcp_recvmsg_locked
     25.74           -25.7        0.00        perf-profile.children.cycles-pp.__tcp_transmit_skb
     23.73           -23.7        0.00        perf-profile.children.cycles-pp.__ip_queue_xmit
     22.26           -22.3        0.00        perf-profile.children.cycles-pp.ip_finish_output2
     21.67           -21.7        0.00        perf-profile.children.cycles-pp.__dev_queue_xmit
     19.22           -19.2        0.00        perf-profile.children.cycles-pp.__local_bh_enable_ip
     18.94           -18.9        0.00        perf-profile.children.cycles-pp.do_softirq
     18.86           -18.9        0.00        perf-profile.children.cycles-pp.tcp_write_xmit
     21.53           -18.6        2.98 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     17.87           -17.8        0.04 ±152%  perf-profile.children.cycles-pp.net_rx_action
     17.34           -17.3        0.04 ±152%  perf-profile.children.cycles-pp.__napi_poll
     17.28           -17.3        0.00        perf-profile.children.cycles-pp.process_backlog
     16.98           -17.0        0.00        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     16.68           -16.7        0.00        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     15.23           -15.2        0.00        perf-profile.children.cycles-pp.ip_local_deliver_finish
     14.80           -14.8        0.00        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     14.57           -14.6        0.00        perf-profile.children.cycles-pp.tcp_v4_rcv
     13.69           -13.7        0.00        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     13.32           -13.3        0.00        perf-profile.children.cycles-pp.tcp_rcv_established
     13.16           -13.2        0.00        perf-profile.children.cycles-pp.sk_page_frag_refill
     13.13           -13.1        0.00        perf-profile.children.cycles-pp.skb_page_frag_refill
     12.66           -12.4        0.25 ± 20%  perf-profile.children.cycles-pp.get_page_from_freelist
     12.73           -12.3        0.40 ± 33%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
     12.71           -12.3        0.38 ± 33%  perf-profile.children.cycles-pp.__alloc_pages_noprof
     12.22           -12.0        0.16 ± 41%  perf-profile.children.cycles-pp.rmqueue
     12.08           -12.0        0.11 ± 54%  perf-profile.children.cycles-pp.rmqueue_bulk
     12.10           -12.0        0.15 ± 43%  perf-profile.children.cycles-pp.__rmqueue_pcplist
     10.47           -10.5        0.00        perf-profile.children.cycles-pp.skb_release_data
      9.75            -9.6        0.11 ± 51%  perf-profile.children.cycles-pp.free_unref_page
      9.57            -9.4        0.13 ± 41%  perf-profile.children.cycles-pp.free_unref_page_commit
     20.82            -9.3       11.48 ± 19%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.92            -8.9        0.00        perf-profile.children.cycles-pp.skb_attempt_defer_free
      7.56            -7.6        0.00        perf-profile.children.cycles-pp.tcp_data_queue
      9.40            -7.1        2.32 ± 33%  perf-profile.children.cycles-pp.free_pcppages_bulk
      6.52            -6.5        0.00        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      6.47            -6.5        0.00        perf-profile.children.cycles-pp.__skb_datagram_iter
      6.45            -6.5        0.00        perf-profile.children.cycles-pp.sk_wait_data
      6.30 ±  2%      -6.3        0.00        perf-profile.children.cycles-pp.__sk_mem_schedule
      6.22            -6.2        0.00        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      6.74            -5.9        0.83 ± 25%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.80            -5.8        0.00        perf-profile.children.cycles-pp.wait_woken
      5.53            -5.4        0.11 ± 67%  perf-profile.children.cycles-pp.schedule_timeout
      5.51            -5.3        0.20 ± 29%  perf-profile.children.cycles-pp._copy_to_iter
      4.38            -4.0        0.33 ± 32%  perf-profile.children.cycles-pp.__wake_up_sync_key
      4.25            -3.9        0.35 ± 27%  perf-profile.children.cycles-pp.__wake_up_common
      4.13            -3.0        1.10 ± 24%  perf-profile.children.cycles-pp.try_to_wake_up
      2.80 ±  8%      -2.7        0.12 ± 49%  perf-profile.children.cycles-pp.__mod_memcg_state
      2.35            -1.8        0.53 ± 24%  perf-profile.children.cycles-pp.ttwu_do_activate
      8.89            -1.5        7.34 ±  9%  perf-profile.children.cycles-pp.schedule
      1.67            -1.4        0.29 ± 24%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.38            -1.1        0.32 ± 46%  perf-profile.children.cycles-pp.__check_object_size
      1.32            -1.0        0.31 ± 34%  perf-profile.children.cycles-pp.update_curr
      1.07 ±  4%      -1.0        0.07 ± 83%  perf-profile.children.cycles-pp.try_charge_memcg
      1.82            -0.9        0.88 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.81            -0.9        0.88 ± 16%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.20            -0.9        0.27 ± 48%  perf-profile.children.cycles-pp.switch_fpu_return
      1.12            -0.9        0.22 ± 23%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      1.04            -0.9        0.18 ± 55%  perf-profile.children.cycles-pp.check_heap_object
      0.99            -0.9        0.14 ± 60%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.05            -0.8        0.22 ± 43%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.64            -0.8        0.83 ± 16%  perf-profile.children.cycles-pp.update_load_avg
      0.81            -0.8        0.04 ±103%  perf-profile.children.cycles-pp.__fdget
      0.92            -0.7        0.24 ± 43%  perf-profile.children.cycles-pp.read_tsc
      0.89 ±  2%      -0.6        0.25 ± 36%  perf-profile.children.cycles-pp.prepare_task_switch
      0.70            -0.5        0.18 ± 17%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.57            -0.5        0.10 ± 62%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.52 ±  2%      -0.5        0.05 ±104%  perf-profile.children.cycles-pp.put_prev_entity
      0.71            -0.4        0.26 ± 36%  perf-profile.children.cycles-pp.__switch_to
      0.66            -0.4        0.24 ± 22%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.47            -0.4        0.07 ±116%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.44            -0.4        0.06 ±101%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.61 ± 10%      -0.4        0.24 ± 40%  perf-profile.children.cycles-pp.select_task_rq
      0.42            -0.4        0.05 ±114%  perf-profile.children.cycles-pp.pick_eevdf
      0.54            -0.4        0.17 ± 36%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.85            -0.3        1.51 ± 15%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.62 ±  2%      -0.3        0.32 ± 29%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.53            -0.3        0.23 ± 14%  perf-profile.children.cycles-pp.__switch_to_asm
      0.40            -0.3        0.14 ±  7%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.40            -0.3        0.14 ±  7%  perf-profile.children.cycles-pp.perf_mmap__push
      0.34 ±  4%      -0.3        0.08 ± 77%  perf-profile.children.cycles-pp.update_cfs_group
      0.53 ±  2%      -0.3        0.28 ± 30%  perf-profile.children.cycles-pp.sched_clock
      0.37            -0.2        0.14 ± 52%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.75 ± 12%      -0.2        0.53 ±  7%  perf-profile.children.cycles-pp.__cmd_record
      0.45            -0.2        0.24 ± 46%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.64            -0.2        0.44 ± 23%  perf-profile.children.cycles-pp.set_next_entity
      0.25 ±  2%      -0.2        0.06 ± 47%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.24            -0.2        0.06 ± 45%  perf-profile.children.cycles-pp.generic_perform_write
      0.89            -0.2        0.73 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      0.22 ±  2%      -0.1        0.07 ± 80%  perf-profile.children.cycles-pp.__put_user_8
      0.32            -0.1        0.18 ± 30%  perf-profile.children.cycles-pp.__get_user_8
      0.20 ±  2%      -0.1        0.07 ± 90%  perf-profile.children.cycles-pp.avg_vruntime
      0.11            -0.1        0.04 ±100%  perf-profile.children.cycles-pp.remove_wait_queue
      0.12 ±  4%      -0.1        0.07 ± 49%  perf-profile.children.cycles-pp.place_entity
      0.06 ±  8%      +0.1        0.12 ± 24%  perf-profile.children.cycles-pp.mm_cid_get
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.unlink_file_vma_batch_final
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.vm_area_dup
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp._copy_to_user
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.diskstats_show
      0.00            +0.1        0.09 ± 33%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.kcpustat_cpu_fetch
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.sched_balance_trigger
      0.00            +0.1        0.10 ± 42%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.__mbrtowc
      0.00            +0.1        0.11 ± 48%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.07 ±  6%      +0.1        0.19 ± 29%  perf-profile.children.cycles-pp.task_work_run
      0.09 ±  4%      +0.1        0.20 ± 23%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.00            +0.1        0.12 ± 33%  perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.devkmsg_read
      0.00            +0.1        0.12 ± 41%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.00            +0.1        0.13 ± 41%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.fput
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.node_read_numastat
      0.00            +0.1        0.13 ± 40%  perf-profile.children.cycles-pp.perf_event_ctx_lock_nested
      0.00            +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.complete_signal
      0.00            +0.1        0.13 ± 49%  perf-profile.children.cycles-pp.free_unref_folios
      0.00            +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.i40e_service_task
      0.40 ±  2%      +0.1        0.53 ±  7%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.1        0.13 ± 53%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.00            +0.1        0.13 ± 42%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.13 ± 23%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.1        0.13 ± 34%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.00            +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.update_group_capacity
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.00            +0.1        0.14 ± 58%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.vfree
      0.00            +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.06            +0.1        0.20 ± 30%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.14 ± 50%  perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.perf_stat_process_counter
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.acpi_ev_sci_xrupt_handler
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.acpi_irq
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.irq_thread_fn
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.00            +0.2        0.15 ± 12%  perf-profile.children.cycles-pp.do_notify_parent
      0.00            +0.2        0.15 ± 20%  perf-profile.children.cycles-pp.process_counters
      0.00            +0.2        0.15 ± 31%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.acpi_ex_extract_from_field
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.acpi_ex_read_data_from_field
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.acpi_ex_resolve_node_to_value
      0.00            +0.2        0.16 ± 53%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.2        0.16 ± 33%  perf-profile.children.cycles-pp.irq_thread
      0.00            +0.2        0.16 ± 43%  perf-profile.children.cycles-pp.vma_modify
      0.00            +0.2        0.16 ± 31%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.acpi_ev_address_space_dispatch
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.acpi_ex_access_region
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.acpi_ex_field_datum_io
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.acpi_ex_system_memory_space_handler
      0.00            +0.2        0.16 ± 32%  perf-profile.children.cycles-pp.acpi_ds_evaluate_name_path
      0.00            +0.2        0.16 ± 49%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.2        0.16 ± 26%  perf-profile.children.cycles-pp.filemap_read
      0.00            +0.2        0.16 ± 51%  perf-profile.children.cycles-pp.mas_split
      0.00            +0.2        0.16 ± 26%  perf-profile.children.cycles-pp.open64
      0.00            +0.2        0.16 ± 12%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.00            +0.2        0.16 ± 43%  perf-profile.children.cycles-pp._compound_head
      0.00            +0.2        0.16 ± 32%  perf-profile.children.cycles-pp.__pmd_alloc
      0.00            +0.2        0.16 ± 27%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.2        0.16 ± 17%  perf-profile.children.cycles-pp.exit_notify
      0.00            +0.2        0.16 ± 22%  perf-profile.children.cycles-pp.seq_printf
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.2        0.17 ± 25%  perf-profile.children.cycles-pp.leave_mm
      0.00            +0.2        0.17 ± 62%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.2        0.17 ± 35%  perf-profile.children.cycles-pp.wait_task_zombie
      0.00            +0.2        0.18 ± 21%  perf-profile.children.cycles-pp.__send_signal_locked
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.flush_memcg_stats_dwork
      0.00            +0.2        0.18 ± 36%  perf-profile.children.cycles-pp.slab_show
      0.00            +0.2        0.18 ± 36%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.2        0.18 ± 46%  perf-profile.children.cycles-pp.rcu_report_qs_rnp
      0.00            +0.2        0.18 ± 42%  perf-profile.children.cycles-pp.__close
      0.00            +0.2        0.19 ± 40%  perf-profile.children.cycles-pp.__do_fault
      0.00            +0.2        0.19 ± 49%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.00            +0.2        0.19 ± 38%  perf-profile.children.cycles-pp.perf_poll
      0.00            +0.2        0.19 ± 44%  perf-profile.children.cycles-pp.mas_find
      0.00            +0.2        0.19 ± 24%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.2        0.19 ± 31%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.00            +0.2        0.19 ± 26%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.00            +0.2        0.20 ± 49%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.2        0.20 ± 49%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.2        0.20 ± 58%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.2        0.20 ± 36%  perf-profile.children.cycles-pp.__do_wait
      0.00            +0.2        0.20 ± 49%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.05            +0.2        0.25 ± 30%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.2        0.20 ± 56%  perf-profile.children.cycles-pp.copy_string_kernel
      0.00            +0.2        0.20 ± 30%  perf-profile.children.cycles-pp.shift_arg_pages
      0.00            +0.2        0.20 ± 28%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.00            +0.2        0.20 ± 40%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.2        0.20 ± 25%  perf-profile.children.cycles-pp.acpi_ds_exec_end_op
      0.00            +0.2        0.20 ± 42%  perf-profile.children.cycles-pp.mas_walk
      0.00            +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.fstatat64
      0.00            +0.2        0.20 ± 20%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.2        0.20 ± 45%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.00            +0.2        0.21 ± 33%  perf-profile.children.cycles-pp.strnlen_user
      0.00            +0.2        0.21 ± 28%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.00            +0.2        0.21 ± 47%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.22 ± 47%  perf-profile.children.cycles-pp.open_last_lookups
      0.00            +0.2        0.22 ± 46%  perf-profile.children.cycles-pp.dput
      0.00            +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.2        0.22 ± 18%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.2        0.22 ± 34%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.00            +0.2        0.22 ± 45%  perf-profile.children.cycles-pp.schedule_tail
      0.00            +0.2        0.22 ± 21%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.2        0.22 ± 49%  perf-profile.children.cycles-pp.step_into
      0.00            +0.2        0.22 ± 18%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.2        0.23 ± 34%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.2        0.23 ± 36%  perf-profile.children.cycles-pp.get_cpu_sleep_time_us
      0.00            +0.2        0.23 ± 35%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.2        0.23 ± 48%  perf-profile.children.cycles-pp.__get_user_pages
      0.00            +0.2        0.23 ± 41%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.00            +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.23 ± 45%  perf-profile.children.cycles-pp.getname_flags
      0.00            +0.2        0.23 ± 33%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.2        0.24 ± 36%  perf-profile.children.cycles-pp.__d_alloc
      0.00            +0.2        0.24 ± 23%  perf-profile.children.cycles-pp.create_elf_tables
      0.00            +0.2        0.24 ± 52%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.get_idle_time
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.2        0.24 ± 47%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.2        0.24 ± 34%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.00            +0.2        0.24 ± 37%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.2        0.24 ± 40%  perf-profile.children.cycles-pp.set_pte_range
      0.00            +0.2        0.25 ± 42%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.2        0.25 ± 27%  perf-profile.children.cycles-pp.rw_verify_area
      0.00            +0.3        0.25 ± 21%  perf-profile.children.cycles-pp.do_poll
      0.00            +0.3        0.25 ± 39%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.3        0.26 ± 29%  perf-profile.children.cycles-pp.do_open_execat
      0.00            +0.3        0.26 ± 30%  perf-profile.children.cycles-pp.dyntick_save_progress_counter
      0.00            +0.3        0.26 ± 39%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.00            +0.3        0.26 ± 17%  perf-profile.children.cycles-pp.down_write
      0.00            +0.3        0.26 ± 41%  perf-profile.children.cycles-pp.memchr_inv
      0.00            +0.3        0.26 ± 19%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.00            +0.3        0.26 ± 37%  perf-profile.children.cycles-pp.mprotect_fixup
      0.00            +0.3        0.26 ± 18%  perf-profile.children.cycles-pp.vma_complete
      0.00            +0.3        0.26 ± 30%  perf-profile.children.cycles-pp.unmap_region
      0.00            +0.3        0.27 ± 34%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.3        0.27 ± 32%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.00            +0.3        0.27 ± 15%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.00            +0.3        0.27 ± 29%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.3        0.27 ± 28%  perf-profile.children.cycles-pp.perf_evlist__poll
      0.00            +0.3        0.27 ± 42%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.3        0.28 ± 23%  perf-profile.children.cycles-pp._IO_fwrite
      0.00            +0.3        0.28 ± 17%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.00            +0.3        0.28 ± 17%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.00            +0.3        0.28 ± 17%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.00            +0.3        0.28 ± 37%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.3        0.28 ± 18%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.3        0.28 ± 18%  perf-profile.children.cycles-pp.__tmigr_cpu_activate
      0.00            +0.3        0.28 ± 40%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.00            +0.3        0.29 ± 27%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.00            +0.3        0.29 ± 37%  perf-profile.children.cycles-pp.dev_attr_show
      0.00            +0.3        0.29 ± 37%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.00            +0.3        0.29 ± 49%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.3        0.29 ± 28%  perf-profile.children.cycles-pp.all_vm_events
      0.00            +0.3        0.30 ± 18%  perf-profile.children.cycles-pp.setup_arg_pages
      0.00            +0.3        0.30 ± 30%  perf-profile.children.cycles-pp.__vm_munmap
      0.00            +0.3        0.30 ± 29%  perf-profile.children.cycles-pp.affinity__set
      0.00            +0.3        0.30 ± 48%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.3        0.30 ± 40%  perf-profile.children.cycles-pp.get_arg_page
      0.00            +0.3        0.30 ± 50%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.3        0.30 ± 14%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.00            +0.3        0.30 ± 34%  perf-profile.children.cycles-pp.do_open
      0.00            +0.3        0.30 ± 28%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.00            +0.3        0.30 ± 32%  perf-profile.children.cycles-pp.poll_idle
      0.00            +0.3        0.31 ± 28%  perf-profile.children.cycles-pp.vfs_statx
      0.00            +0.3        0.31 ± 14%  perf-profile.children.cycles-pp.wp_page_copy
      0.00            +0.3        0.31 ± 25%  perf-profile.children.cycles-pp.mm_init_cid
      0.00            +0.3        0.31 ± 19%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.3        0.31 ± 24%  perf-profile.children.cycles-pp.wait4
      0.00            +0.3        0.31 ± 37%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.00            +0.3        0.32 ± 40%  perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.00            +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.do_sys_poll
      0.00            +0.3        0.32 ± 24%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.00            +0.3        0.32 ± 33%  perf-profile.children.cycles-pp.wake_up_q
      0.00            +0.3        0.32 ± 20%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.3        0.32 ± 19%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.3        0.32 ± 39%  perf-profile.children.cycles-pp.vma_prepare
      0.06 ±  9%      +0.3        0.38 ± 45%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.3        0.32 ±  8%  perf-profile.children.cycles-pp.__evlist__disable
      0.00            +0.3        0.32 ± 23%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.3        0.33 ± 40%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.3        0.33 ± 28%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.00            +0.3        0.33 ± 34%  perf-profile.children.cycles-pp.seq_read
      0.00            +0.3        0.33 ± 34%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.00            +0.3        0.33 ± 34%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.00            +0.3        0.33 ± 26%  perf-profile.children.cycles-pp.dup_task_struct
      0.00            +0.3        0.33 ± 21%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.3        0.33 ± 25%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +0.3        0.33 ± 36%  perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.3        0.34 ± 21%  perf-profile.children.cycles-pp.__poll
      0.00            +0.3        0.34 ± 27%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.00            +0.3        0.34 ± 36%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.3        0.35 ± 26%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.4        0.35 ± 31%  perf-profile.children.cycles-pp.copy_strings
      0.00            +0.4        0.36 ± 17%  perf-profile.children.cycles-pp.cpu_util
      0.00            +0.4        0.36 ± 12%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.4        0.36 ± 12%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.4        0.36 ± 18%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.4        0.37 ± 35%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.00            +0.4        0.37 ± 35%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.00            +0.4        0.37 ± 31%  perf-profile.children.cycles-pp.kick_pool
      0.00            +0.4        0.37 ± 33%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.00            +0.4        0.37 ± 27%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.00            +0.4        0.38 ± 36%  perf-profile.children.cycles-pp.folios_put_refs
      0.00            +0.4        0.38 ± 31%  perf-profile.children.cycles-pp.kfree
      0.00            +0.4        0.38 ± 25%  perf-profile.children.cycles-pp.tmigr_update_events
      0.00            +0.4        0.38 ± 28%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.00            +0.4        0.38 ± 22%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
      0.00            +0.4        0.39 ± 27%  perf-profile.children.cycles-pp.d_alloc
      0.00            +0.4        0.40 ± 52%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.00            +0.4        0.40 ± 23%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.00            +0.4        0.40 ± 17%  perf-profile.children.cycles-pp.load_elf_interp
      0.00            +0.4        0.40 ± 19%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.4        0.41 ± 22%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.4        0.41 ± 14%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.4        0.42 ± 16%  perf-profile.children.cycles-pp.__x64_sys_exit
      0.00            +0.4        0.42 ± 21%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.42            +0.4        0.85 ± 22%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.4        0.44 ± 31%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.4        0.44 ± 27%  perf-profile.children.cycles-pp.dup_mmap
      0.31            +0.4        0.76 ± 12%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.5        0.46 ± 20%  perf-profile.children.cycles-pp.need_update
      0.00            +0.5        0.47 ± 26%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.5        0.47 ± 20%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.07 ± 38%      +0.5        0.55 ± 16%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.5        0.49 ±104%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.5        0.50 ± 20%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.00            +0.5        0.50 ± 25%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.00            +0.5        0.50 ± 42%  perf-profile.children.cycles-pp.__perf_event_read
      0.00            +0.5        0.51 ± 22%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.5        0.51 ± 28%  perf-profile.children.cycles-pp.quiet_vmstat
      0.10 ±  5%      +0.5        0.61 ± 36%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.5        0.52 ± 26%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.00            +0.5        0.53 ± 13%  perf-profile.children.cycles-pp.zap_present_ptes
      0.00            +0.5        0.53 ± 36%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.00            +0.5        0.54 ± 10%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.00            +0.5        0.54 ± 21%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.00            +0.5        0.54 ± 20%  perf-profile.children.cycles-pp.do_anonymous_page
      0.00            +0.5        0.55 ± 28%  perf-profile.children.cycles-pp.__lookup_slow
      0.00            +0.5        0.55 ± 21%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.6        0.55 ± 24%  perf-profile.children.cycles-pp.__queue_work
      0.00            +0.6        0.56 ± 22%  perf-profile.children.cycles-pp.call_timer_fn
      0.00            +0.6        0.56 ± 22%  perf-profile.children.cycles-pp.__mmdrop
      0.00            +0.6        0.56 ± 14%  perf-profile.children.cycles-pp.run_timer_softirq
      0.00            +0.6        0.56 ± 23%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.00            +0.6        0.57 ± 14%  perf-profile.children.cycles-pp.force_qs_rnp
      0.30            +0.6        0.86 ± 17%  perf-profile.children.cycles-pp.ksys_write
      0.28            +0.6        0.85 ± 18%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.6        0.58 ± 17%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +0.6        0.59 ± 37%  perf-profile.children.cycles-pp.generic_exec_single
      0.00            +0.6        0.60 ± 20%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.6        0.60 ± 17%  perf-profile.children.cycles-pp.vmstat_start
      0.00            +0.6        0.61 ±  7%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.6        0.61 ± 13%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.6        0.61 ± 39%  perf-profile.children.cycles-pp.smp_call_function_single
      0.00            +0.6        0.61 ± 25%  perf-profile.children.cycles-pp.__wait_for_common
      0.00            +0.6        0.61 ± 19%  perf-profile.children.cycles-pp.collapse_huge_page
      0.00            +0.6        0.61 ± 37%  perf-profile.children.cycles-pp.perf_event_read
      0.00            +0.6        0.62 ± 17%  perf-profile.children.cycles-pp.__run_timers
      0.00            +0.6        0.62 ± 19%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.00            +0.6        0.62 ± 19%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.00            +0.6        0.62 ± 10%  perf-profile.children.cycles-pp.zap_pte_range
      0.00            +0.6        0.63 ± 19%  perf-profile.children.cycles-pp.khugepaged
      0.00            +0.6        0.64 ±  9%  perf-profile.children.cycles-pp.zap_pmd_range
      0.32 ±  2%      +0.6        0.96 ± 18%  perf-profile.children.cycles-pp.write
      0.00            +0.7        0.65 ± 17%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.7        0.65 ± 17%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.00            +0.7        0.67 ±  9%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.7        0.67 ± 15%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.00            +0.7        0.69 ± 12%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.00            +0.7        0.71 ± 20%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.7        0.71 ± 15%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.00            +0.7        0.72 ± 13%  perf-profile.children.cycles-pp.__open64_nocancel
      0.00            +0.7        0.72 ± 14%  perf-profile.children.cycles-pp.sched_exec
      0.00            +0.7        0.72 ± 14%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.7        0.72 ± 10%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.7        0.72 ±  9%  perf-profile.children.cycles-pp.show_stat
      0.00            +0.7        0.75 ± 19%  perf-profile.children.cycles-pp.pipe_write
      0.00            +0.8        0.76 ±  8%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.00            +0.8        0.77 ± 19%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.00            +0.8        0.77 ± 13%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.00            +0.8        0.78 ± 15%  perf-profile.children.cycles-pp.pipe_read
      0.00            +0.8        0.78 ± 33%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.00            +0.8        0.79 ± 14%  perf-profile.children.cycles-pp.wake_up_new_task
      0.00            +0.8        0.83 ± 12%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.8        0.83 ± 19%  perf-profile.children.cycles-pp.rcu_core
      0.14 ±  3%      +0.8        0.97 ± 14%  perf-profile.children.cycles-pp.sched_tick
      0.00            +0.9        0.86 ± 16%  perf-profile.children.cycles-pp.walk_component
      0.00            +0.9        0.89 ± 67%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      0.00            +0.9        0.94 ± 56%  perf-profile.children.cycles-pp.drain_zone_pages
      0.00            +1.0        0.96 ± 16%  perf-profile.children.cycles-pp.dup_mm
      0.00            +1.0        0.97 ± 17%  perf-profile.children.cycles-pp.exec_mmap
      0.00            +1.0        0.98 ± 13%  perf-profile.children.cycles-pp.__vfork
      0.00            +1.0        0.98 ± 14%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +1.0        0.98 ± 11%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.00            +1.0        0.99 ± 15%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.00            +1.0        1.00 ± 18%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +1.0        1.02 ± 15%  perf-profile.children.cycles-pp.move_queued_task
      0.53 ± 12%      +1.0        1.56 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +1.0        1.05 ± 17%  perf-profile.children.cycles-pp.affine_move_task
      0.00            +1.0        1.05 ± 14%  perf-profile.children.cycles-pp.elf_load
      0.00            +1.1        1.06 ± 23%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +1.1        1.08 ± 16%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +1.1        1.10 ± 12%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +1.1        1.11 ± 36%  perf-profile.children.cycles-pp.perf_evsel__read
      0.00            +1.1        1.15 ± 11%  perf-profile.children.cycles-pp.exit_mm
      0.00            +1.2        1.15 ± 16%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.00            +1.2        1.16 ± 14%  perf-profile.children.cycles-pp.intel_idle
      0.23 ±  2%      +1.2        1.40 ± 16%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +1.2        1.18 ± 16%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.00            +1.3        1.29 ± 17%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +1.3        1.29 ±  7%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +1.3        1.29 ±  7%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +1.3        1.31 ± 10%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.00            +1.3        1.31 ± 23%  perf-profile.children.cycles-pp.decay_pcp_high
      0.00            +1.3        1.32 ± 25%  perf-profile.children.cycles-pp.__memset
      0.00            +1.3        1.34 ± 13%  perf-profile.children.cycles-pp.setlocale
      0.00            +1.4        1.35 ± 17%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.00            +1.4        1.36 ± 28%  perf-profile.children.cycles-pp.perf_read
      0.00            +1.4        1.38 ± 16%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.00            +1.4        1.39 ±  6%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.00            +1.4        1.40 ± 13%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +1.4        1.42 ±  7%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.00            +1.4        1.44 ±  7%  perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.00            +1.5        1.45 ± 48%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +1.5        1.48 ± 48%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +1.5        1.48 ± 10%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +1.5        1.48 ± 18%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +1.6        1.55 ± 14%  perf-profile.children.cycles-pp.copy_process
      0.00            +1.6        1.55 ± 28%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.00            +1.6        1.55 ± 95%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.00            +1.6        1.55 ± 95%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.00            +1.6        1.55 ± 95%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
      0.00            +1.6        1.58 ± 14%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +1.6        1.58 ± 13%  perf-profile.children.cycles-pp.mmput
      0.00            +1.6        1.59 ± 12%  perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +1.6        1.60 ± 10%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +1.7        1.71 ±  4%  perf-profile.children.cycles-pp.do_exit
      0.00            +1.8        1.78 ±  8%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.12 ±  3%      +1.8        1.92 ±  8%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +1.8        1.82 ±  9%  perf-profile.children.cycles-pp._Fork
      0.26 ±  4%      +1.8        2.09 ± 18%  perf-profile.children.cycles-pp.update_process_times
      0.00            +1.8        1.85 ± 18%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +1.9        1.86 ±  9%  perf-profile.children.cycles-pp.path_openat
      0.00            +1.9        1.86 ±  9%  perf-profile.children.cycles-pp.do_fault
      0.00            +1.9        1.87 ±  9%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.00            +1.9        1.89 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +1.9        1.89 ±  9%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +1.9        1.91 ± 13%  perf-profile.children.cycles-pp.alloc_bprm
      0.00            +2.0        1.96 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +2.1        2.13 ± 24%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +2.1        2.15 ± 15%  perf-profile.children.cycles-pp.evsel__read_counter
      0.00            +2.2        2.16 ±  8%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +2.2        2.18 ± 18%  perf-profile.children.cycles-pp.mm_init
      0.00            +2.2        2.24 ±  7%  perf-profile.children.cycles-pp.mmap_region
      0.00            +2.2        2.24 ±  9%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.00            +2.3        2.31 ± 27%  perf-profile.children.cycles-pp.readn
      0.00            +2.4        2.36 ±  8%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +2.4        2.36 ± 45%  perf-profile.children.cycles-pp.rest_init
      0.00            +2.4        2.36 ± 45%  perf-profile.children.cycles-pp.start_kernel
      0.00            +2.4        2.36 ± 45%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +2.4        2.36 ± 45%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.28 ±  4%      +2.4        2.69 ± 14%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.00            +2.4        2.42 ± 12%  perf-profile.children.cycles-pp.menu_select
      0.00            +2.4        2.43 ±  5%  perf-profile.children.cycles-pp.do_mmap
      0.00            +2.5        2.45 ± 32%  perf-profile.children.cycles-pp.vmstat_update
      0.00            +2.6        2.57 ± 31%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.00            +2.6        2.62 ± 11%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.00            +2.7        2.67 ±  4%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.29 ±  4%      +2.9        3.17 ± 13%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +3.0        2.99 ±  6%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +3.1        3.10 ±  5%  perf-profile.children.cycles-pp.search_binary_handler
      0.00            +3.1        3.10 ±  6%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +3.1        3.12 ±  8%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +3.2        3.23 ±  8%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +3.4        3.36 ±  8%  perf-profile.children.cycles-pp.sched_balance_domains
      0.00            +3.5        3.46 ±  9%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +3.5        3.46 ±  9%  perf-profile.children.cycles-pp.exc_page_fault
      0.41 ±  2%      +3.8        4.17 ± 13%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.42 ±  2%      +3.9        4.28 ± 12%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.46 ±  4%      +3.9        4.33 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +3.9        3.91 ±  4%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +4.0        4.00 ±  8%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +4.1        4.14 ± 11%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.00            +4.9        4.89 ±  6%  perf-profile.children.cycles-pp.vfs_read
      0.01 ±223%      +5.0        5.02 ± 34%  perf-profile.children.cycles-pp.process_one_work
      0.00            +5.2        5.24 ±  7%  perf-profile.children.cycles-pp.ksys_read
      0.00            +5.4        5.40 ± 19%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +5.6        5.61 ±  8%  perf-profile.children.cycles-pp.balance_fair
      0.00            +5.7        5.68 ±  6%  perf-profile.children.cycles-pp.read
      0.01 ±223%      +5.9        5.93 ± 31%  perf-profile.children.cycles-pp.worker_thread
      0.00            +6.0        5.96 ± 11%  perf-profile.children.cycles-pp.sched_setaffinity
      0.00            +6.4        6.42 ±  3%  perf-profile.children.cycles-pp.execve
      0.00            +6.4        6.44 ±  3%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +6.5        6.46 ±  3%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +6.5        6.54 ±  9%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.00            +7.5        7.52 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +7.9        7.86 ± 16%  perf-profile.children.cycles-pp.read_counters
      0.00            +7.9        7.90 ±  9%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +8.0        8.02 ± 15%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +8.0        8.02 ± 15%  perf-profile.children.cycles-pp.process_interval
      0.00            +8.0        8.03 ± 15%  perf-profile.children.cycles-pp.cmd_stat
      0.40            +8.2        8.56 ± 14%  perf-profile.children.cycles-pp.main
      0.40            +8.2        8.56 ± 14%  perf-profile.children.cycles-pp.run_builtin
      0.00            +8.4        8.38 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +8.5        8.46 ±  8%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.33            +8.6        8.96 ± 26%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +9.2        9.17 ± 26%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.00            +9.2        9.20 ±  8%  perf-profile.children.cycles-pp.sched_balance_rq
      0.00            +9.5        9.53 ± 25%  perf-profile.children.cycles-pp.tmigr_handle_remote
      0.00           +10.5       10.45 ± 10%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.01 ±223%     +15.0       15.04 ± 14%  perf-profile.children.cycles-pp.kthread
      0.01 ±223%     +15.3       15.28 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
      0.01 ±223%     +15.3       15.33 ± 14%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00           +15.3       15.34 ± 18%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.45 ±  2%     +20.6       21.08 ± 15%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.50 ±  2%     +21.1       21.62 ± 14%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.01 ±223%     +35.4       35.45 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.01 ±223%     +35.5       35.48 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
      0.02 ±146%     +40.1       40.10 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.03 ±144%     +47.1       47.18 ±  7%  perf-profile.children.cycles-pp.start_secondary
      0.03 ±148%     +49.5       49.53 ±  5%  perf-profile.children.cycles-pp.do_idle
      0.03 ±145%     +49.5       49.54 ±  5%  perf-profile.children.cycles-pp.common_startup_64
      0.03 ±145%     +49.5       49.54 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
     20.82            -9.3       11.47 ± 19%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.48            -5.3        0.14 ± 49%  perf-profile.self.cycles-pp._copy_to_iter
      2.56 ±  9%      -2.5        0.06 ± 73%  perf-profile.self.cycles-pp.__mod_memcg_state
      1.64            -1.4        0.28 ± 22%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.15            -0.9        0.29 ± 37%  perf-profile.self.cycles-pp.__schedule
      0.98            -0.8        0.14 ± 60%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.79            -0.7        0.04 ±103%  perf-profile.self.cycles-pp.__fdget
      0.88            -0.6        0.24 ± 43%  perf-profile.self.cycles-pp.read_tsc
      0.56            -0.5        0.09 ± 53%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.56            -0.5        0.10 ± 62%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.54            -0.4        0.09 ± 51%  perf-profile.self.cycles-pp.check_heap_object
      0.68            -0.4        0.26 ± 34%  perf-profile.self.cycles-pp.__switch_to
      0.60            -0.4        0.20 ± 49%  perf-profile.self.cycles-pp.kmem_cache_free
      0.41 ±  2%      -0.4        0.06 ±101%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.49            -0.3        0.16 ± 33%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.41            -0.3        0.08 ± 82%  perf-profile.self.cycles-pp.prepare_task_switch
      0.44            -0.3        0.13 ± 48%  perf-profile.self.cycles-pp.update_curr
      0.36            -0.3        0.05 ± 75%  perf-profile.self.cycles-pp.do_syscall_64
      0.52            -0.3        0.23 ± 14%  perf-profile.self.cycles-pp.__switch_to_asm
      0.32 ±  2%      -0.3        0.05 ±103%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.32            -0.3        0.06 ±108%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.32 ±  3%      -0.2        0.08 ± 77%  perf-profile.self.cycles-pp.update_cfs_group
      0.28            -0.2        0.05 ±114%  perf-profile.self.cycles-pp.pick_eevdf
      0.29            -0.2        0.08 ± 81%  perf-profile.self.cycles-pp.handle_softirqs
      0.42            -0.2        0.22 ± 53%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.67            -0.2        0.50 ± 15%  perf-profile.self.cycles-pp.update_load_avg
      0.26            -0.2        0.10 ± 50%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.21            -0.1        0.07 ± 73%  perf-profile.self.cycles-pp.schedule
      0.30            -0.1        0.18 ± 30%  perf-profile.self.cycles-pp.__get_user_8
      0.24            -0.1        0.12 ± 62%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.24 ±  5%      -0.1        0.12 ± 57%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.05            +0.1        0.12 ± 24%  perf-profile.self.cycles-pp.mm_cid_get
      0.00            +0.1        0.09 ± 23%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.09 ± 29%  perf-profile.self.cycles-pp.sched_balance_trigger
      0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.set_pte_range
      0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.kcpustat_cpu_fetch
      0.00            +0.1        0.10 ± 42%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.1        0.11 ± 21%  perf-profile.self.cycles-pp.__mbrtowc
      0.00            +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.00            +0.1        0.12 ± 41%  perf-profile.self.cycles-pp.tmigr_quick_check
      0.08            +0.1        0.20 ± 23%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.12 ± 54%  perf-profile.self.cycles-pp.mmap_region
      0.00            +0.1        0.13 ± 37%  perf-profile.self.cycles-pp.read
      0.00            +0.1        0.13 ± 42%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.13 ± 34%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.update_group_capacity
      0.00            +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.timekeeping_advance
      0.00            +0.1        0.14 ± 36%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.14 ± 24%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.15 ± 56%  perf-profile.self.cycles-pp.sched_balance_update_blocked_averages
      0.00            +0.2        0.15 ± 18%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.00            +0.2        0.15 ± 36%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.00            +0.2        0.15 ± 14%  perf-profile.self.cycles-pp.pipe_read
      0.00            +0.2        0.15 ± 31%  perf-profile.self.cycles-pp.acpi_ex_system_memory_space_handler
      0.00            +0.2        0.16 ± 42%  perf-profile.self.cycles-pp._compound_head
      0.00            +0.2        0.16 ± 34%  perf-profile.self.cycles-pp.vfs_read
      0.00            +0.2        0.16 ± 35%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.2        0.16 ± 46%  perf-profile.self.cycles-pp.need_update
      0.00            +0.2        0.17 ± 46%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.2        0.18 ± 30%  perf-profile.self.cycles-pp.affinity__set
      0.00            +0.2        0.18 ± 36%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.2        0.18 ± 45%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.2        0.18 ± 35%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.2        0.19 ± 40%  perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.00            +0.2        0.19 ± 39%  perf-profile.self.cycles-pp.zap_present_ptes
      0.00            +0.2        0.20 ± 49%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.05            +0.2        0.25 ± 30%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.2        0.20 ± 28%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.2        0.20 ± 42%  perf-profile.self.cycles-pp.mas_walk
      0.00            +0.2        0.20 ± 34%  perf-profile.self.cycles-pp.strnlen_user
      0.00            +0.2        0.20 ± 20%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.2        0.21 ± 47%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.22 ± 25%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.2        0.22 ± 49%  perf-profile.self.cycles-pp.refresh_cpu_vm_stats
      0.00            +0.2        0.22 ± 29%  perf-profile.self.cycles-pp.__tmigr_cpu_activate
      0.00            +0.2        0.22 ± 18%  perf-profile.self.cycles-pp.down_write
      0.00            +0.2        0.22 ± 13%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.2        0.23 ± 38%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.2        0.23 ± 36%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.3        0.25 ± 13%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.3        0.26 ± 30%  perf-profile.self.cycles-pp.dyntick_save_progress_counter
      0.00            +0.3        0.26 ± 41%  perf-profile.self.cycles-pp.memchr_inv
      0.00            +0.3        0.27 ± 26%  perf-profile.self.cycles-pp._IO_fwrite
      0.00            +0.3        0.27 ± 42%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.3        0.28 ± 34%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.00            +0.3        0.28 ± 35%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.3        0.28 ± 28%  perf-profile.self.cycles-pp.tmigr_handle_remote
      0.00            +0.3        0.28 ± 32%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.3        0.28 ± 29%  perf-profile.self.cycles-pp.evsel__read_counter
      0.00            +0.3        0.28 ± 34%  perf-profile.self.cycles-pp.kfree
      0.00            +0.3        0.29 ± 28%  perf-profile.self.cycles-pp.all_vm_events
      0.00            +0.3        0.30 ± 28%  perf-profile.self.cycles-pp.mm_init_cid
      0.00            +0.3        0.30 ± 26%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.3        0.30 ± 33%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.3        0.30 ± 26%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.3        0.30 ± 18%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.3        0.31 ± 22%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.3        0.31 ± 39%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.3        0.32 ± 22%  perf-profile.self.cycles-pp.sched_balance_rq
      0.00            +0.3        0.32 ± 19%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.3        0.34 ± 37%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.3        0.34 ± 37%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.00            +0.3        0.34 ± 24%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.70            +0.4        1.09 ± 15%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ± 35%      +0.4        0.50 ± 21%  perf-profile.self.cycles-pp._find_next_and_bit
      0.31            +0.5        0.76 ± 21%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.5        0.48 ± 28%  perf-profile.self.cycles-pp.mm_init
      0.00            +0.5        0.50 ± 17%  perf-profile.self.cycles-pp.evlist__id2evsel
      0.00            +0.5        0.52 ± 24%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.00            +0.5        0.53 ± 27%  perf-profile.self.cycles-pp.read_counters
      0.00            +0.6        0.56 ± 23%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.00            +0.6        0.58 ± 17%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +0.6        0.60 ± 20%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.7        0.75 ± 27%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.9        0.90 ± 11%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.00            +0.9        0.91 ± 15%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +1.0        0.96 ± 23%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.14 ±  3%      +1.1        1.26 ± 16%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +1.2        1.16 ± 14%  perf-profile.self.cycles-pp.intel_idle
      0.00            +1.3        1.29 ±  9%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.00            +1.3        1.30 ± 25%  perf-profile.self.cycles-pp.__memset
      0.00            +1.4        1.44 ± 17%  perf-profile.self.cycles-pp.idle_cpu
      0.45 ±  4%      +2.4        2.90 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +6.2        6.20 ±  5%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00           +10.4       10.43 ± 10%  perf-profile.self.cycles-pp.intel_idle_xstate




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


