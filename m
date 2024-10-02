Return-Path: <netdev+bounces-131369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96898E56C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A91C20DB0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2A21730F;
	Wed,  2 Oct 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDvSLUqc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126A1D131B;
	Wed,  2 Oct 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905469; cv=fail; b=KXjF5p+JjTo2hVBkB7B1JZ6BxrX54pS31ZoXwVb+6IW1oGI7rjurK2Tcu+OSlvtPtYWi6eHrYWpkm8h3Hs+cFLfKZV3/tbdtd5NDVaYJd3o30XMkAtgi2HAiO3zpYFNarkZjaRAB5c0aPO6Ehg9kO2rKytjxbX0Jw5ySoilNQkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905469; c=relaxed/simple;
	bh=QDiKGgSHXkusSq8M6D/MZflk8WidxAP8Nt7jgsEYfNo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5ywkuzw3GDrMqJ2bVbb00RDlb4/l2twVywIlF7cXhmJgcH8D/fH6Wp0x2pf+o0f4j3VT4KxvnXyXPkhFIaBz/vc15OeSGuPIbvPbxVE4gFxyXwjYL8/bXNlNhpufesM+vG/W8UakhhmfLnY/wr7rU84lg5PGZvSbFnU/Bz+FdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDvSLUqc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905467; x=1759441467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QDiKGgSHXkusSq8M6D/MZflk8WidxAP8Nt7jgsEYfNo=;
  b=JDvSLUqcFvPHxV47p6SLHwGzf1d/CS6a3DWn9jAcoa+9Jom+423YoL0g
   A///pQqcIM2hIXLsiiZ4kyYKth69nbEsktgOp9hx4Dc+WNVXwVuSYbx+N
   V9KtaMkuZB3IWCYDoCqnAW45Qof2VnvaH3i4JJM7kW8s/Cg4A3s54gqnH
   14QB99YPvUrX1LFPnXwqmk6WzweMzH53fBw/kOXtymKTRfIuEqdoC082w
   lVnLzFyzyl2aSEhvTAM1hoYc4O4wUPYkWzs7MXEm8JrxdRbATGMYcBeHS
   0vTp61UFpcRI70qP81ejpSC5DgHhNXqFhmPxpCkwazozkFvXsE5KzWMCa
   g==;
X-CSE-ConnectionGUID: I6EGT4B2Q1CSfnS8X5VNkA==
X-CSE-MsgGUID: l5jALoPTQhyuMCZeOqhN0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37675702"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="37675702"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:44:25 -0700
X-CSE-ConnectionGUID: D6Xz8N66RDyLeRuryI3c3w==
X-CSE-MsgGUID: d8e59ONtR3+ljSU62H5oGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="97475073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 14:44:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:44:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:44:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 14:44:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 14:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2RFWnJb2UNGwj4m3bJasLCrjwuBmCWQ96uwM52jfIohfQxT+QAuCBkfcEbXJ/dsevQ4sECZLZaoXwnzNUM/jbGsacsZDz7xI8ECDUdAQ87EuXI92i4bMIuJmrkhK7aRkFyLp6BouHwiVbL8lztXE4ScXxQ5bAsKBjoow87n8p1hiDNePtu8oz+8jF4czix9XMEMyq6xcuXPmYH9I1V2byO0HuQWN+/buidOOZzsK0XBViy4Cd/o68tLdQmwiS6Af8ru3NBH22ErEenyytb0R1FdE2GI9GX8aYPuPYBfevlDqvgWY1VPhVelAuBAOQjjasPn0N4sedACsu3+OKdcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1hhMuodw2cPA5F6DPgZzk8JBTrwmdPLAf3CrV4GW/M=;
 b=TJkBHQ3I3xG7eT40RPWmprRwQ5G3Qt5qGmDt0BPybacQE3phFeXHFPpiADXICiEAwYNYIiYtzbqwCThUU0Yjrh4an3rUXs/CCfhXp5heRLIDmSN9sNR1dMcuJXBZAwr2d2hsvdG68OVyOOsP4bTLgSvslx8OQBz70J9cyrXSTb/zZqRpEw1TBP3AarA0M+oZ5sjrgvNr8QxIl+ILB7/0cd+UG+xX9Qdka+q6GTWbM6XJIaKtEoqheQAI0/yv2xS+3oNr0d+fY5UlQB4/dQrTcC2dhBv+kTFWyCtHkmVfZhXwLy8gdQTLWKr/8GuNcjCNatSR8ND7eNnZ4ApbjW+QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 21:44:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 21:44:14 +0000
Message-ID: <63e7cced-5eaf-43ba-bb2c-b7a8609bedd7@intel.com>
Date: Wed, 2 Oct 2024 14:44:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net: sparx5: prepare for lan969x switch
 driver
To: Daniel Machon <daniel.machon@microchip.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <4e89dd84-eadc-4cae-8892-c33688cc051f@intel.com>
 <20241002074714.uprnmhf5a2f2hyzw@DEN-DL-M70577>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241002074714.uprnmhf5a2f2hyzw@DEN-DL-M70577>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e9022c-00cc-45d9-233a-08dce32b5b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YThrSXRaL3lSVk9uVExsMXkzV20vbjZ2bGJzTGt6cTBDVUZDZG52YXBTcFRJ?=
 =?utf-8?B?aUQyS1phSkkvbWtsZFZnQTdwYURFcmNnaXFZYktJYnF5R0dPRTQ0WGdBTTNy?=
 =?utf-8?B?Y3NBcW9EVDVlazFpbzlSYVdiZzJoSTV2QTU0QUhSaGhvamk0aVVuOE5GVHEx?=
 =?utf-8?B?Rk9DclBGR2ljM25sS0pzSUZsaTlOTjBOM3JpdmV3d214YlZraEdSaDJsZldI?=
 =?utf-8?B?VWJMdlZ2VUloQUZSNXBaRDdMR2VGcU9HRGpiRWx0Zkw5M3JwbFFsMkN2ZWlB?=
 =?utf-8?B?aFlRaTV5Z1RmK2t1WTVRZ1NzdzZ0TFUwb2R1UkZIcWFIMTBpOEtSandrMks5?=
 =?utf-8?B?MkFKRkJUYVN2L21QTE1JZ1MwU0xHZXR5RnVFSDdaS21QNTRFdjdjcnJTeUtR?=
 =?utf-8?B?UGh6NzViNFdna3ExbWlnQXZ5a1lqY1FSNWpsdm4rZnRuWEZMcElSSFFRTnFW?=
 =?utf-8?B?RUk2dC9Zd3NEb1JHamx1Wis1YlV4S3V0ak9tYWlYTTlUdFBrbmhPcHpMa29K?=
 =?utf-8?B?VW0vN0tTK2lqd2FZbTJ1VnJEMVF2ZzBLcGZjNUh3Y2FnYnVUbG4zWDNCWHFK?=
 =?utf-8?B?VGJmelNmVHd1QjczNG9DSTZHTkoyRTB6K2pZYllXbGViQndjYm04RFYvRTRM?=
 =?utf-8?B?R2w3TG93K0dGVGp5by9idjNEMlM3WEJzK1FsOVJrcmdZUEI2RjgzdDRpMTdW?=
 =?utf-8?B?NjhCN2EzTzJLMmlSSFVjQ0VwRVZiR0Q4NDNEZExvdGNic0wrU1M4Ni8xSGtF?=
 =?utf-8?B?OHhGVUlpL0IyUDBZU3lzQytnY1p6aExvVTRmSDJLK2JKTGRkd3pOY3VHKzFK?=
 =?utf-8?B?aHo4LzdadnFrSmo0dEFTRitNSFlrb0JmWWxyc1UzeXk5a2JqMldCWklCMnk4?=
 =?utf-8?B?dGRrelFkOVkvTVdpOGkyWXpHZ1AvaWlhcGgxaVZUbGtSbmtHOE0yRWdLVndv?=
 =?utf-8?B?L2J1R1ViVlh4VVYrZUN3bGlOK0pMMmJ6WFFTT0xtSDd3bmxPcXY1ZDFnYU9y?=
 =?utf-8?B?OVZaMzNHN2k3Q3kxcGplM3NOdjRmM25GNFQ1RVArdzhsRnJqRUZBbGpqeVRx?=
 =?utf-8?B?SzR5blpaSFhqRTJxZnBXYzMvSDNLcEJmYW42L2VLUWdZdXRncUFTWFV0Y1R1?=
 =?utf-8?B?TmMvQVdSQlExL0lmV092MW1qZjhyRmNjcGhhTmpQbEdmTHpUNklCUWdvaUFa?=
 =?utf-8?B?Y0JEWmZvcGR3Q1JMT0JYS0dYRjJLR2tCeXo3R0RZa1ZuRlJkRGFmWEVDNDJp?=
 =?utf-8?B?aVo4VnlZRzZQOTBZWUJkMWNBQVZDVWNEVUJ6N2tLSDNiaEpnSklhbnlJQzJR?=
 =?utf-8?B?WUxmeHdLSjFSbmtKdGtpZGtSOFRnaWhkTUhpOVFtKzk3WkNickdoY1ZVa3hB?=
 =?utf-8?B?KzBST1V2Y3pxVDMya1pUYjBnNGFqdVl6REwrcjdQOXM3MFVtVS8yZXV1OXZT?=
 =?utf-8?B?OGNPMjZ1bjc4QVpCbGlqeVZRL2NEU3BhZmVuclA1Q3RZMURDaDlsRVFxNExz?=
 =?utf-8?B?Tm1RNnREV21BdFM0aFYwQlJGNTJSYnAxbWlPWjVjT1hRdFpyKyt0amRGWkl0?=
 =?utf-8?B?enlwTmRSNldtK0xiaytLZndOM2pUWkducW9TanRLYmpVSWh2WGlJRTcxOXhP?=
 =?utf-8?Q?G94voZOXJOicGwc9XITf0lIQk1gsok+tr5FFvY+o7ArA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxyaW50QWJLQVR5SDdmbnI2VUFmems3NlhWR3ZGamwxRmxPeGd6YnR0U2Mx?=
 =?utf-8?B?Tmh1VGZ4WEEzaWR1OTkwdDF1MGhrb3IzdDhGTU9ta1JHazBISWhxQldqcnJD?=
 =?utf-8?B?UXZPSVVNd3JONlpTVDFGaVlJNGNMZS9Vdy81NW9xbWgxSlNTSEtJT3J4K2Rj?=
 =?utf-8?B?RVZVNjBveDMwSDZzK2ZJazRGNTUzTStmeWNJcG93dDIyOVFXcytGNzZ3cHd4?=
 =?utf-8?B?TVlMVU82aHlLcDNNc3JaMldNa1ZCMDVVZG5VdURpSHN1cHZyMVBFaEFDeXpL?=
 =?utf-8?B?UllWUnFDdGtiV003MmZhM3MvYzNnZUdQRjFvWlpJSUdnQmpzc0g4dCtIRkRo?=
 =?utf-8?B?R2hUVjk5ZlozRzRaUnM1Z3lObEJNS0hSQ0cxc0VRODlKOUthdGUvRmpraXFo?=
 =?utf-8?B?S1FSNXpnL3U5YmFMK0d2eWpMZGNwZXlkS0FQdTZ2QXZoYndSTkVhTnlHVnhC?=
 =?utf-8?B?Y2JZdDd0SmkrU1J4aDFwRUVMNU5HeG42S3ZZWi9hR0RCNkRPbEJxR29Cb3hw?=
 =?utf-8?B?UlVMbDZqZlRrLzJXVU5qTWtaVko4Q3dHS0ZpYVpvbjR5QkFKTUxmaVV1YUdh?=
 =?utf-8?B?YTFGZW1kK3JDclUzckxLbG1MLzlqTWVuRDlBMVAzcStaOGJWbDY1Wm9Pc1pK?=
 =?utf-8?B?U0JLbEpoRjR2eGJhRmwvb0RmMVJKOXFOSHVnOWZ6cjJDN3pDRU9VTFNHeTly?=
 =?utf-8?B?R2p3NW5ROFB3dEM0ZjlyRGtaSVRVYnZCL3NyQjRBL0JWRzRrTTVRL05YQ1JY?=
 =?utf-8?B?b25PWUZWRXVYYm5CVWxsL2pVM3hTbTFicUZ0VUNQdTg0ZFBoNmI5L29JS0Vh?=
 =?utf-8?B?MEpFWHZHNVFnZHE2QWdUZVpoQ01UVysrMzlpanl6Tmc1ZmYzU1Z4ZHJxM2Vy?=
 =?utf-8?B?SXdOTVhxZ0NIZ29Vd1J0ZDJONTB1NGpvNE9UWndLRzZnUW1Md1JaZjJuVU1B?=
 =?utf-8?B?WnhPREZRMFF1Q1JBYlN5Qk1IK3A0bTFyVE5UL0NBK1drNHoweFU4cG1DR2Vs?=
 =?utf-8?B?ZUVGdVNPeHp3WnRSTkh5YUI1bnVvb29wRjAzcHUwdkVBeVBxWVBYcTdPcTZs?=
 =?utf-8?B?Mld4ZzZKaFBlZ2FONnlvV0xvMnFDN0VhV3Y4cVd2bWRmaVBIaDFyQkZocm12?=
 =?utf-8?B?VmV2KzRNbWhKK3JBZnJsMlpzSzkzYVJOcTc2cjNjVVVGT1ZtMVJSU1d5UFNu?=
 =?utf-8?B?cDZ2NzhLYlRvU05ySXN5VWVxbEVpWE9zbnBaVUpLK2R2NWxtQVduT3JkbWJU?=
 =?utf-8?B?SVJoZnBvcUYzWGJmMXhza21aaVZZU2NUaU80TDg4REg4S3piMjBDL1MyVUlk?=
 =?utf-8?B?eVNYbUd0S2RUdVhxWk44d2RXWFU3R09VbmpDaVY4WExFWkZGY0crc1R2anNE?=
 =?utf-8?B?YXJjNzRPNUFPVFArZlhkaVUzMHJTRlRwbjJFU0YyZ2xYMHpiNEprYXpFUVlj?=
 =?utf-8?B?NkMzY3VxQWx1aStyWit4M0N4Smh3cFY0NU0rVjh1dTkwaE1KN1l4bFV1Q0VZ?=
 =?utf-8?B?MXBMR2dVYjg2RlJyNWJZNkZuMGN0cUR2ZXcwRWx5K2dIOTcxMytjbWE4VHpS?=
 =?utf-8?B?dXprNzg4Sk44Y3czZGxKR2tZM1llVElNaWZxV0dMVkVvb1hIYkY0L0FOT1p1?=
 =?utf-8?B?V0w0dGlqRGE1MFdVM0wyNFdMTjFCYTBGbFZzQ3JXVDJYNDh2OTA1OWRObTJY?=
 =?utf-8?B?RFhJOHRtakJ5YStRQTlsaW5WMzNXK1RuQVRaTkJMVm1vVWlzTnRtQzZwMGVi?=
 =?utf-8?B?QWN3ek9iRVlqbjZlbzZHdVo4MFBHR0xEakpCUVBjSHdpemxyU0FqYnZFZHZ3?=
 =?utf-8?B?OURPbktiTWV6Mlk2THpVbnpaRG02TzhKRkhSM1VZdVllb1ErUnlEVXBzVUVC?=
 =?utf-8?B?THo0TXcvUDNYNUhRQ3g5NnFvR2NqNmtFVExaeUo0dFpGVkVieGFYenZGNXlp?=
 =?utf-8?B?U2RZeFY4bVVhQmNrcUZqZk9heW9rV2RCQU9scmxVN1R3ZTBRR2x5dXJOeUhY?=
 =?utf-8?B?R1ZnOUNlYjNSczdOcDUxeGQ0blN4T1JoSFQxM0crQ1M2YTZYZGU1elp2eWE0?=
 =?utf-8?B?SDIzNG5KSzNBUWZDWmpEM3l6Zkl3clAzeWJiQk5HbS8rNE5FcnFsVUMwcURK?=
 =?utf-8?B?WGZ6M1BLU0xTcEpDcDRVS3loZEl5dVhZem1yRi9CQzBPSWxEZmk2QklIUjNX?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e9022c-00cc-45d9-233a-08dce32b5b93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:44:13.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLM4irxur19DX9VY24yfybwiSa+EPNYQoCy34AoSMwT3dKHFgDx+8d+m3CV5YCtMHuVtJGe5DiWhfM/WbXcguj0wHjy5grjTTaRLI9G5Wv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
X-OriginatorOrg: intel.com



On 10/2/2024 12:47 AM, Daniel Machon wrote:
> 
> Hi Jakob,
> 
> First off, thank you for your reviews - I really appreciate it.
> 
> Let me address your "variable scope" conerns:
> 
> I had the feeling that this could pontentially be somewhat contentious.
> 
> Basically, this comes down to making the least invasive changes to the
> existing driver code. With this approach:
> 
>     For the SPX5_CONST macro this means shorter lines, and less 80 char
>     wrapping.
> 
>     For the "*regs" variable this means not having to pass in the sparx5
>     pointer to *all* register macros, which requires changes *all* over
>     the code.
> 
> I thought the solution with an in-scope implicit variable was less
> invasive (and maybe even more readable?). Just my opinion, given the
> alternative.
>

Obviously there is style preference here, and someone working
day-in/day-out on the code is likely to know which macros have which
variable dependencies. As an external reviewer, I would not know that,
so I would find it surprising when looking at some code which passes a
parameter which is never directly used.

> Obviously I did a bit of research on this upfront, and I can point to
> *many* places where drivers do the exact same (not justifying the use,
> just pointing that out). Here is an intel driver that does the same [1]
> (look at the *hw variable)

Yea, I'm sure a lot of the old Intel drivers have bad examples :D I've
spent a career trying to improve this.

> 
> I am willing to come up with something different, if you really think
> this is a no-go. Let me hear your thoughts. I think this applies to your
> comments on #2, #3 and #6 as well.
> 

It seems that Jakub Kicinski wants the entire macro removed, and his
opinion as maintainer matters more than mine.

Personally, I'm not opposed to a macro itself especially if the direct
access starts to get very long. However, I think the parameter being
accessed should be, well, a parameter of the macro.

> /Daniel
> 
> [1] https://elixir.bootlin.com/linux/v6.12-rc1/source/drivers/net/ethernet/intel/igb/igb_main.c#L4746
> 
> 

As an example of *why* I don't like this practice: It took me a while to
realize the hw variable was implicit to wr32. And I worked on this driver.

Thanks,
Jake

