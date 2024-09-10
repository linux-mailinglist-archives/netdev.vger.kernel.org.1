Return-Path: <netdev+bounces-127042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B748A973CDC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1591C214A0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20981A0734;
	Tue, 10 Sep 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy5u4+Oo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4D1A071E;
	Tue, 10 Sep 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984114; cv=fail; b=o4mQZOsBUAdYL2E1yc3bW64+mvtnyjK15BFE85ER48b0DWPGjOqXEwn/bkipC5npJkxUIz1i8MPYs6ISjS9gSUG13HRUJE6O/MQF3XAzR1BSOU//DdL4jmBYVhJbu9oWhzYNAqJ6Rd5yl139UnL6gR10eM+8qML6uH7E93TOxRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984114; c=relaxed/simple;
	bh=bB9/ODhQLC1M5LISYHa2iSR6jjfSa3whk/F9EOALFvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K9LnOscclGLBDS2h6KQ4qHY5wYSeKD/XJlhJMJZnLdbA2Od5laPTtlIk88klTBH7sx06hHl3E3cAQMwp8m21rBEFhL7mOYXvIGpHgs07MnaeBl/oxJpz16YYrr+pka/LepY2VqKdrX/UTb3/ctm43B5ZyGUI68IeDshH3p1vorY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy5u4+Oo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725984113; x=1757520113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bB9/ODhQLC1M5LISYHa2iSR6jjfSa3whk/F9EOALFvQ=;
  b=Uy5u4+OoVUmMNRuOWgaC3DkwhfNJ2IgOk7wH4uRLR4O9BW3dcapn+gZT
   zjj8roqSCdn40v/qwWO0GlT+D6NKQhPbZmDuN6gXWNTia89q3Vfeboyg0
   DhNf0FCpEfgvA6UBbeacu6epYDfWdkX7liRppBQBFp+8WZtUEJEvJckjM
   1lEwp3Ei5OgAK4DIZrxbrqiPWt7rhv6lBWW5m+CSCsV2iF7fA5nrvkiOV
   tXQmRwQgtIHN9eQeZXzyTRcjtzRkU32PKU16uMPUZvIZa2wqi8vuYRg6R
   wBSaD74M204dEdy7gqHko/aALiNM/7qDgumRkaW/XLQocY67AlmJrq1L4
   w==;
X-CSE-ConnectionGUID: vsNYez2cSoGCeW3c5TJhnA==
X-CSE-MsgGUID: FogHbacqTIKMrymZBQkSDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24884776"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24884776"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:01:52 -0700
X-CSE-ConnectionGUID: hOGvTdz+RYeVzVePp9ctpQ==
X-CSE-MsgGUID: IuFcrTlnRjmJ9obESwtyvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71837561"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 09:01:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 09:01:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 09:01:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 09:01:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ2UBZ5E/QV3U5Ipz6moklQVMO0fvDhnFNrhfS8qFPJiK+7SKXhb8gmMMPJ+0VEwR2DPPRFqSc4UzH/ahCx+6wzEyBQLYoqZiRV7suhZVKfROP2vx+A4HwwG32PUI8Y2pvVkUeNpAPZmnwef9FaHEZsiesLNsMdjeDRIJryVxnMYVr+xCbOKiPAbyoe5xtHQbqrT2FgKZJSCdnlg3AOsZ4ng96pYHfWED9sWfUdM8QN9CtD+qACzS8p+o1JQkdfPKaBBsWJat1X6y28Tfrj5zgJbPYivYkvwlI3HDRtDQg2tVoxaKh63MrFr/TON30ztoyrnFtui6QiKHcEegR36HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm8n5fy7+7x3NlKRr6fHZvWFmYpYVTvnswZK0/aHtlY=;
 b=K24JjAH6qTV5JBbQofbmv3DXNwwuINMsWM3tHzJyOGaRjst45bzlNtmZqgHSSNkwaVm6M+18LoQ3McE6t9zWoatGs/cs0pnKKqLi4AiaQTdw3Z9e7Q7MloQXpWKZxRx0MopUVJTVpb6vYsKHz/d21tWwW4W9BjwlcASUlW+YXO/QzJWNod9UHyvIR16WpWm+Jmr0MYuqab6XBbnb//3XcNnhnRhfWOIS48oghLEO2is8u1TbTDEZTD9wp1VdycgUjq4K8pzLBDt0olXR+DTjObwN9lDNGoHUvYBgXjmodOe7Seow3kvizirCJpsfoyT5kcBV5QuRaVT2/ViSa9ETxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 16:01:47 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 16:01:46 +0000
Date: Tue, 10 Sep 2024 09:01:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>,
	quic_zijuhu <quic_zijuhu@quicinc.com>, Ira Weiny <ira.weiny@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
 <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc889da-f358-4c37-8da3-08dcd1b1df11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E34uN70f6v3OyhmNoLLwTY6bsWd1jZi9pwwWpoLiz2zLzWdPZ1JOeylrXCWN?=
 =?us-ascii?Q?HwEJyOw27BzHhuk9cd/bHz8WXNr0H5hABQqghpWX3yu6/VeqYDLFtqt6P9bU?=
 =?us-ascii?Q?7Szi/3Qq2BJs0ho9ITN4bIwvlISYLde09S8PR6QkTtrcZcfItjRg4NHh5kkS?=
 =?us-ascii?Q?v2qa8imOdO1LQOTwD0QCnyZsCorcF7duSZS6Mk7xbVtdOeJIIH3EfNZBx+G5?=
 =?us-ascii?Q?ltYQFnA87hBGcr/Rf5DPB5DLGTYbPFJcXLyiqbr3G1O1CQc/LpGyGs1aBcNo?=
 =?us-ascii?Q?MKxvTIfPq4JW/3bi8vr+Vq1cfnl+HT/KNcgE0sAgj8OsFpPM1MO5ZgSkdPLw?=
 =?us-ascii?Q?F87DdKVwRYMBA+Ij4Cly5ZjpbjBMKmeLXjcbFJIFd0tNyfh4MHgcoVm6htRi?=
 =?us-ascii?Q?vMKEGqap873z4sxpfaZhzrX1/Le3ejGvelircCjfa8H82a8821bqwn8Sc8Sc?=
 =?us-ascii?Q?9pFuIjJXd/XW2z+FUBtvZpizXHWSGB/OQC1g4ZRtTqDbkao3qp5sQ50Tafsc?=
 =?us-ascii?Q?POh4ovrLxY7poQ5o9Uw4SKliUiFDWNrOapxTxENc5dY069GH/z4zFYPCl+dv?=
 =?us-ascii?Q?1k7s7HL/lJTaznRG1CGsx1iK5M13CqvJ9oLxj0SWcnn4MgR12CV/INf5gFxS?=
 =?us-ascii?Q?AwNxZb5ujpNcO4qqqnKo0H2mzI0mGxbWyGnczKsjNnO3T8rE0fuKzMYwiNVL?=
 =?us-ascii?Q?4/C7NPDK3ju5EBObqaVKzfN2pLQZQrpGCRYzwQnU5wKQj1n7fUUEqA1xa5m6?=
 =?us-ascii?Q?AQJ9orJOwt876k6ia1+TzU2XB9jtUIWrPmBmsTD0KGeV0kiPqAquvRr6Yb6s?=
 =?us-ascii?Q?u2OGEHzhT2wq0THNz/Bu+6/rAgI6Q/wDp3R3uQaOYUbYltZ4mg8z/iuCyqVx?=
 =?us-ascii?Q?xJjstHV1nnocn9U7EHncr9FuHLW+7MFImbWM7/5ljy2kB+RPt92R0iGAa8eV?=
 =?us-ascii?Q?znc4FerN6pQWSiXhjgPxpJhKC23G3VcF3i9fs0UeHD4Oqfch4x8EgJSIy2Cy?=
 =?us-ascii?Q?tn+xE0XeeMkkhjL+JkYsCR1uj21FNX38fUNmfYmFDWFH2smk9aHzZLpUPN8Y?=
 =?us-ascii?Q?RnUsRhnLK1MfN9r3I4p+bMJpvcKZO7CE+wy3j42AUqgR+jKfroXR06ckQHC1?=
 =?us-ascii?Q?2ALwHYe3PUUyGTA2pVR4Hw02wJuijcZ7gkUrF4FjVOZxlyp2sR1Ojq9k0nNF?=
 =?us-ascii?Q?Srv+VBlLum3xdZhi915hAocd245ilVOEhGCRXYfeSR1dIF4+UEmNkd1NeCPQ?=
 =?us-ascii?Q?XNmFcUaG4QuaYzaegMkpZtZ394c8Ahb+8Ntu/AyR4xwHO5mJxCa8Ogb5dsgF?=
 =?us-ascii?Q?VSg1T0jrUAVz7CSoIhIo8odAa4jmU8XKstG9QOBvJhH7DwY9nIJbLhT7ZJka?=
 =?us-ascii?Q?oYytT+0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZsQPj55b87E27MKp0b54ViDw/NZ5NJAZ0XXodO+ID56Ize4auaDZUs71sGmW?=
 =?us-ascii?Q?6fKuYA6KXO7AmlAhahj4+FlZ0rl2QQQAtt1B6/MkKSilvwV7126pcplvDBf5?=
 =?us-ascii?Q?KUEuEj+aPjtcHUSvlwGz+6H0MdAa7CZREIF+rvZ7xPpYhmS3Fcjhsbt0DV0X?=
 =?us-ascii?Q?kjo3I+pRj+Gx74EHnRMbhh1BI4b/2thaH7brA7KZihVRfQmb3pPCdoMcBvJo?=
 =?us-ascii?Q?H4QBGNupgN1vwcx3XlSROjm8iR89AI5fV7h2ASXhSEmZN3Zw05T0i7CHCYsD?=
 =?us-ascii?Q?hrZrry8OOejR5AyBBfgP2bSciRlAUiAHRtLXSsirow5F+HsZ8j5lTHipq9u1?=
 =?us-ascii?Q?ItIfLCcGYrgfGjzL8cUehiwgb1mESBhxAcVEQU+qXxJsXD+UlD1rULs640Gx?=
 =?us-ascii?Q?Acx0WyK8KM2DTWZUJlokUlv5LMNTEqAvF/yb1AZsBrXP43yjYFS9Bic9X679?=
 =?us-ascii?Q?JJYT42huN1DzIGN5EdH6+Vf0xmHo64fZz+SOuw4KWmksWf4tOm0xoLPCtWRT?=
 =?us-ascii?Q?e8/iKgi6Cbn//+ztQhaWtJsUSj+L1ml5CRATUrt/Daoitu1mm3WocqeoKrfX?=
 =?us-ascii?Q?YOvcQwOoE7l7Z2E8+Frwmx8M8yy3kpi0cPezc3y7sLV8I6UlzG34Polw1a3y?=
 =?us-ascii?Q?OM+ROSK3AayU0w3+FeixSNdCLemqgVJfM+qlKPLvGnpTM+8xcrT5Y2kHPQK4?=
 =?us-ascii?Q?N/nK4+u25BvGcjVMuTBn2THv019BL5GemGrx+Sgt/33mPlcpL+X2SedfWmHG?=
 =?us-ascii?Q?eflnPF3QHrQ3uX226rEuCqDrc6cg6f3c6GNg0RxNNpB5SGaiAr4ir6J/3SzU?=
 =?us-ascii?Q?DUqU+PvxW4SBdt67RNXJ2o/ubiNuX+YDjBiPfTKZ+65aQ1gEROYw6k99aEQg?=
 =?us-ascii?Q?kjNZPT0zcm1AUivoNtpLpMntpFiVEi8baxu+9Tfw7ywEFbLymBt6ParnD1MN?=
 =?us-ascii?Q?XjY5FkJyq2w/HQlw6zqPfMO+LXE/fGEY0FFLXwLN6hlATFh1rMSfcktPS2gc?=
 =?us-ascii?Q?O9Y192zD5S8VIkyCAxmw4SIno+F39RO6eeecb3SZdZxfbwCzsC7ce7Mc+0En?=
 =?us-ascii?Q?goIt1RoPVlyL19O47CpO1tqcdlYzBnXzP+OPzwx4nrBFV6W2bmLGRSsB1i4i?=
 =?us-ascii?Q?VY9TmF6Bj+v2vV19OBvrO8f04UuuSbQs7Wrh2wtBsIBy0CzAp6BZio901ung?=
 =?us-ascii?Q?RAJfDmP9bu2ckvmQco0vsH3/jmTTMoLIXCld4VoJk9fhu3fbI4ik/3Q9mDhf?=
 =?us-ascii?Q?cpebPZKYVc4axQ6pxUv4mdQDnZc2GQ4V706/IB09orgFO3GawkPgvN1RGibu?=
 =?us-ascii?Q?28FEpn2Cwu/Ivyno4O7XBgrRWS6L4OdKDZ11lDJHCxlCeL/RZwSyuDN/dL6s?=
 =?us-ascii?Q?juVqmRS5wBJ+jXo5zMH5IA3rA7TATZ0YN9XEpLN1X/gIF+A8jJHwAiqf0wnh?=
 =?us-ascii?Q?vF/P2T44YlxXkQhQCMjaS+NGBaSAJ4jbFgzQnA46VNi6+p8FI+uaka+mthAf?=
 =?us-ascii?Q?C1pHrHby1lSQMTzwf3tY+2RZ00jDgjhxkA+puxw143VsS8MCDvocSo2A+C8K?=
 =?us-ascii?Q?iZYsEoa3Yg6P1O/Ej8PcXEsV/CZrkkvJywF14iJi+z9uLSvGV4ObjfxLr3Vr?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc889da-f358-4c37-8da3-08dcd1b1df11
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 16:01:46.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xZX/h7QWfv0msjE67/qkNaQtUW9b9txQpvMfwJs1FtYYtT2iiCNSgni8nCINWlxYwkEVaL59Q7y43b8Dh0Y00v8SODczidVrvQPO+ZtfUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com

Zijun Hu wrote:
[..]
> > So I wanted to write a comment here to stop the next person from
> > tripping over this dependency on decoder 'add' order, but there is a
> > problem. For this simple version to work it needs 3 things:
> > 
> > 1/ decoders are added in hardware id order: done,
> > devm_cxl_enumerate_decoders() handles that
> > 
> 
> do not known how you achieve it, perhaps, it is not simpler than
> my below solution:
> 
> finding a free switch cxl decoder with minimal ID
> https://lore.kernel.org/all/20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com/
> 
> which has simple logic and also does not have any limitation related
> to add/allocate/de-allocate a decoder.
> 
> i am curious why not to consider this solution ?

Because it leaves region shutdown ordering bug in place.

> > 2/ search for decoders in their added order: done, device_find_child()
> > guarantees this, although it is not obvious without reading the internals
> > of device_add().
> > 
> > 3/ regions are de-allocated from decoders in reverse decoder id order.
> > This is not enforced, in fact it is impossible to enforce. Consider that
> > any memory device can be removed at any time and may not be removed in
> > the order in which the device allocated switch decoders in the topology.
> >
> 
> sorry, don't understand, could you take a example ?
> 
> IMO, the simple change in question will always get a free decoder with
> the minimal ID once 1/ is ensured regardless of de-allocation approach.

No, you are missing the fact that CXL hardware requires that decoders
cannot be sparsely allocated. They must be allocated consecutively and
in increasing address order.

Imagine a scenario with a switch port with three decoders,
decoder{A,B,C} allocated to 3 respective regions region{A,B,C}.

If regionB is destroyed due to device removal that does not make
decoderB free to be reallocated in hardware. The destruction of regionB
requires regionC to be torn down first. As it stands the driver does not
force regionC to shutdown and it falsely clears @decoderB->region making
it appear free prematurely.

So, while regionB would be the next decoder to allocate after regionC is
torn down, it is not a free decoder while decoderC and regionC have not been
reclaimed.

