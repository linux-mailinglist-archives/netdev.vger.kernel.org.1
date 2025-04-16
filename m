Return-Path: <netdev+bounces-183486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D1A90CE4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80658460238
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CF822A804;
	Wed, 16 Apr 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYws4qT0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D146227BA9;
	Wed, 16 Apr 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834531; cv=fail; b=Desp1GdN8kii3mrEjrxH5WtRt+POLzxikTSnlydd6q3HDLYq91xcE9Y2voOiHW08zr+54ZNgu4Z34joiE1swfcHCYBvzNb00X+Vz/sFwaZ6LJaPzB2yiCD8oIOHNnF3hgBkMb7xNaEMvE8C5jtPEtHchTcUZBgPtgkRLl40JSAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834531; c=relaxed/simple;
	bh=AyCfJLs4dmAGiUfhKhU1Fw4Dq8wo5lkn5X8f5mstOT4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZPanE0m+WV7wWOr3FoEG82LDBD9/2m6ZvkQIiJIwwoPtILAz+VALtnjgsWI+tMKzmyApBppnM04C8KP9ln3G2mEUNL0fCjJoQLCxKRmUOKhs3BnvD3xKdFMv72gZDHwBb9nxD3OwYRCy4cu5mAm88P+a4soAAcwJaR7UyjT6jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYws4qT0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744834529; x=1776370529;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AyCfJLs4dmAGiUfhKhU1Fw4Dq8wo5lkn5X8f5mstOT4=;
  b=dYws4qT0hkVXR5aSHGKqKcROPUjODUOGGkyoQoaFFZEt72doWXBkDWZ2
   rllnacEFN2qKgGT3PQ55PSNxNrVMcPNlPF2jriFHfxMpgYhmZZEzn0qpz
   d9oKdgOoTIy1AUyI3bAVI12GWq1Ed5MfziPFKy7UBkilQxlBv3diH1f6Q
   De6UafA9WtoiM1G2U7uDWfzFJbsRWoKd7sY0V+dLqekXY8bqu+QROWVjj
   shwTaSB/OrdCpomedQwZZoU8EDPJOUf/CD7BLPbrn1tiLftOVhP3Cxt6a
   aayDEacdtKd6zjpq8JbvnyJfUvQiaT+NlLgacqds9MI3XIUoLVKY0EFg6
   g==;
X-CSE-ConnectionGUID: C2txLzSyQf2V5pKOENvC+A==
X-CSE-MsgGUID: mvy3LtGJSBSj2MbUH4VCHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="68894236"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="68894236"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:15:29 -0700
X-CSE-ConnectionGUID: Fa17kL0ESb2Y2rkhYajWQA==
X-CSE-MsgGUID: XlZecoAtQH6FnHYRiQlmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130348477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:15:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:15:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:15:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxz/JLhLfFAqwmRurKETbxc4PhCX1liaWGCR8kbz9nxsWvKHOHHFuVc8VFYSxeQDvErsZwudGwsD0WA31ognQjuaEjL7o9f/Oy2ENYBavbucS+odOVp9WiXGjla7YoOoiywWUr/yEcpeoAPOy/C51fBGAUWjBiunMH1QSTsj8mvI9MVGef3BNuQeXh/zHT9mQM8rVbFf2qfbdE8k80g+xTtQcNTH91GR+cKO2AlCUFVMEoIg1FV02d/tDeeCV9rtFifSjKaZomqdQZ2d3zBZSTb/OW0gmHCIDfiFSfNvAlPWlqEC/xjPqgYiXaccc6l7cNSkF1gG3pZracLGB50jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXP7lew7TN1moEEjJw1FeeKlyGejl7paeU1bHSlXwwA=;
 b=H1Q4vepokJBwu8DJk1+e7nFdOCEEx6a2954NxCzRjkwDDyOGunVkH3fawtVp1cJMlLEc5GW54+vllj/3ot9K7PlbySPPYWbtlivyBG2d2E1BOqNG+rxFXD+9bcQ+d8ii0s4mFBRNJBA0NmoQhBikZx/R+k724++vpGaeRb8XF8DauDSqLiD0bKnRfB6zbebRpaBT/rWGSRYj6EWN1NRoUnYu+ttx42LvTdGEUuLJa/Tp15riR5UGBe6jD32iIwafLQvyR5SseMPO2iMyHMqdSjvyvud9aPI/bpcz6Ko2oNMzRQd1488r1/PWcVawpVdNlaTiXCr0KpECy7iB9dxR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA4PR11MB9251.namprd11.prod.outlook.com (2603:10b6:208:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 20:15:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:15:11 +0000
Message-ID: <8c82cabf-b282-4084-bf73-ead2ffd70272@intel.com>
Date: Wed, 16 Apr 2025 13:15:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 3/4] pds_core: Remove unnecessary check in
 pds_client_adminq_cmd()
To: Shannon Nelson <shannon.nelson@amd.com>, <andrew+netdev@lunn.ch>,
	<brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.swiatkowski@linux.intel.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-4-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415232931.59693-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA4PR11MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 714db6c6-6be4-4319-1e9f-08dd7d2363c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTRTZ3p2ZE9WS3lXVzh3b1d5UjRiNG9mVTl2b0h2T3FNeGV1QWhXMVk1Q3VC?=
 =?utf-8?B?aldGbVdidlVsZGV1QlppMHVQdVlnMURQbVhSWlpBQ1hzaE5kUkQ5T1FPVTcv?=
 =?utf-8?B?TGtBbWlvVEhVbCs3U3RoWkdzaU1hUHgyOWJDWjJPN3ZsQThNUjFjZEF4aU9k?=
 =?utf-8?B?UjJkZDVGc3p4NmpWUTJFUEdDTVQ3V1Juc1h0WlpYZkhSSFJ1Y2lDM2NKSzYz?=
 =?utf-8?B?S1BUazR1V3F4WFhZT21RL0JrMGdxZGFYRTc0SXMyMjcybWc2SGlSbnZac2dy?=
 =?utf-8?B?cFFob01NVzdUeTUyUnRuTGN0VVBWb0ljYlpGdGEzWVlZc1M2RHR4bjBRanFh?=
 =?utf-8?B?ZEowS1UyMWdVWkxKdUY5Qlo0MXhHYzFwdUFqdTJ2VENTRWUwMDF3THVqUDNy?=
 =?utf-8?B?ZnBTa0RTRldJVzRiK2dLZ0VCTjE3QldQZm11b0V6ZUN1bGFBUFBYakFHSWZx?=
 =?utf-8?B?bGw1Z1U3b0RHRGVhRE14ZFUrRExsRlZwSkRVSkJHQ0FPbEFvUUhibUNVVmdM?=
 =?utf-8?B?aFQ4Sm5OcWs5WW4ySXhiZmNHYUtyMUoyN1NKbHQwVTdqeGtHcHJ3ZzU0cml3?=
 =?utf-8?B?RXlhVVRscjRtVHE0TmFRY3p0bUtxQjBzRndUeWZncXQvbmZtd3gyREowMkkw?=
 =?utf-8?B?VldmN2hMVFhUS25iUklLMzQ0NW1XU2c0cTYzZ3pzN0k3VE9BZVdqcHNCQjh1?=
 =?utf-8?B?bk16WHdGYURVOFdRZndDd0l2ejdLS1FwTFVEZjg3TFplQkt5Vkxka3NyQktI?=
 =?utf-8?B?VVNNemxGY1pFakJiSEE5TWR0M0xOY1lHZ3RvN2I5aXNacDJHOVNrRUp6bEpT?=
 =?utf-8?B?MGxFYnh3NXBHN1ZmbFRoOXRxQ0h2ZGplM0xkSkc4b3JiOE4xcUExWG5qNTVk?=
 =?utf-8?B?ZW5DenFPQTVPUFJEQ2RPUVl0bVEyTHFJU25xZTdBVEUxTWd4QWR6U1p0a3Na?=
 =?utf-8?B?NHl4Mm1NR3lhZHNKSU9yU1JUMUt0NTRYRjRZL2k4NmNNOTJuN2ltenNLc0ww?=
 =?utf-8?B?V01zMzJnSFY2SVpyWmlDS3pTUEJyU0R1d2hFdjVxUVc2QUlvc0MyOTRya2xU?=
 =?utf-8?B?VmtWWWRld3JYNElMZGhBSmlvVGhwajZBVndZaGlBeTZ0Nm9PNnpaN09xcjll?=
 =?utf-8?B?SURhNEk2S3ludDF4dDlDaWlVMk8zTHZYSk16UDkyK2czN21rTlkzVS9RSkNJ?=
 =?utf-8?B?bXVjL0FGYUFZMzFhMHBmczRSQnVJeUJ4VzhLNkpyQk1xQkVtYXkxTUNlNUpo?=
 =?utf-8?B?eTBYQ2lBNklhOFdVdmlBUmhDbm0rQmpBaEpSVWVkUWFqajZneEh1M2FIYzhE?=
 =?utf-8?B?UEt0Z2hyU1YvWVVtaWg2aU90aXp3WHVaZDNBUU9TalZHb3BEalhVVDgzWDlC?=
 =?utf-8?B?VHJ5Z1ErRGkvcFZkMWVmcEdTcnVBQ0xpNWNoU1B2dVcyRXZBaCtZMThEN3lh?=
 =?utf-8?B?dndnRlZBUEkyREhhNTBmbXhndmQ4WDZyYWZ6ZnNibUFNblBuUVBBRjNWUGdW?=
 =?utf-8?B?NFJYdm5vdlpsZHpmc3dCUEk3RWxTZUsvNFpxa0dsR1pYbWtUQlB6Rm1CWjY3?=
 =?utf-8?B?SDdFSnhCOTFKeUtITXU0QkFUUzZWQTExSlRadnppNzhXZDdlTUxsVGh2dm15?=
 =?utf-8?B?bDhidjZGUW9BeUJMTEx0d3A2NHQzV2V5T29EclJTNk1nQnkrMlNFM25NMC8x?=
 =?utf-8?B?anJIWENWZTlTNHdIdDlOdXV1dHcrNzJkWVdYdjVuaDdTclhtdmdqaDVmUVBO?=
 =?utf-8?B?TEVnUktmRnBMSW9zeEkycythNXFjMTdQRkp6OG12bzhmN3BGWG9pcnF6aUlY?=
 =?utf-8?B?am1BaTNQVkpSWWlENjdIS1B6dHNQTklvM0p5dzJoUTc4c1hGY0xlNEtNMEpq?=
 =?utf-8?B?TU1uVWxSUTk2REMxQkl2NGVKVCt5NDNUeFBtbkd5bC9DYmJrSmlWWGtKa25U?=
 =?utf-8?B?NTdYdDgxaldkdUVSazJZQjdmbjhHMFJCUXpiQXg1dllmWjZraUV3ZHorZE5U?=
 =?utf-8?B?bzI5eDRuSkJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3FBUkZYemVQT0hlSWlYbnRoWXVDcklmclU0bU1jVms3d0VLc0tQUFNwMnFE?=
 =?utf-8?B?Q25nN0hUMkxuY3lNTEREV2ZYTVNBTEZwSDRYT3FNQ0FUbndSYk45bmEyRVRE?=
 =?utf-8?B?YlVRakVWR21QKzVQTlBGRVQvL24vQWp4OTkyOGkweTBndWMrOTNyMVhORW5y?=
 =?utf-8?B?S21rVlpvVU8rN3JWUjhiV0NWNVdxT3hRcXRwSUxiaE00cEdKTVZ3WWd1bC90?=
 =?utf-8?B?QlJMdTljWmUxTDRCbzRKTUFsRzZMNW1EbUM4ZGNpblFmVnZtUUV2Q1Ard293?=
 =?utf-8?B?RGNkaFV4aEZsTkhPMTRnSTVsN1FFKzdxVUlYYnE0S3NvS0NzSHZWbXZLcjVa?=
 =?utf-8?B?d1RaVkxPLzNkNmtVN0xZUWxBV1FzaGFmdUFXWjFRd0g4dWM5UGhMTFJ4dnF6?=
 =?utf-8?B?V0h5NEo1MC8xNHdPcWNiUFl1NGVUa0RQR0cyZ1ZwVFp3d1JBekVwZmlESGJl?=
 =?utf-8?B?QjIvOEFiODhPVGhtTWdDK29IUHpLTWRETk56R3JRK2NwVFpFZEk3TGdaRmVt?=
 =?utf-8?B?M05QOVh2ZXBQZ3J5clJkZjhiRUhKZEwvZ2ZGNEFuMW5UWG9zMFdETnRTcXRy?=
 =?utf-8?B?S01RdVNJTmtUYVZKT2ZjLzk3b0VVRW9zZW0yWGtPZ1hwRmJ1U1ovRTVFanJW?=
 =?utf-8?B?YWNVY01JRnNOMnQ5TWpZZ25yNTlSMFFpQVhQcVBSMDVEZmtYSmZSSWYwRFJo?=
 =?utf-8?B?Y3dmOUtLK1RvTmwyRnlrK3lUSjlBZDhWZjhOODByN3hqUzBweXlRYWJMVkJh?=
 =?utf-8?B?N0E1YzZMcWxlczc2eGpSclhwNHZJWnFmSEJ5aG5XM0hhMFVlUU5nWHh1eElR?=
 =?utf-8?B?ZDNwNDlyNU8zVjJFb0J5MG5WYmh5WFN0TDFKN2pPWmcrZHBRM1QxRFB2eTJ2?=
 =?utf-8?B?cGZhVHlCUlJ2TGNaMEEzNkZVQkw4NXE4MlV1UWxtTU9odXRXanI4SEdQei92?=
 =?utf-8?B?Skpxd2JZQXZGUHlJbmVrVnJLblJrRnRXdWZKWitBZHVJU2tDU1NHa0FQUjBF?=
 =?utf-8?B?OVkybzlWbWF5TE1GMnkvOTk4Sk5qL2RQbStFSUhvQjY1REJyaFNIT1R3QkVL?=
 =?utf-8?B?UHhPS3QxVzBhcXFMNHZEdDFTSUQxNTZGVUh0RWNiYWVBNEJKL3p5ek1MeTBT?=
 =?utf-8?B?QVV6V1ZFOHphUHVybWVsRjgzNUh5REpLdnlSRmVWUllZcDhKSU9hM3N5VlFG?=
 =?utf-8?B?RmpyL2RXZGIwNktXQ0NvWG1kb05lWkRRanhINUI1eE5SbGY1SVRJWEl0a1lK?=
 =?utf-8?B?UmMyTGt4SDI2ZEtqV0JuUDBhMi9xNThZMEQrQi95RmZYeEZDRllmS1RYVnRD?=
 =?utf-8?B?a0tCMTIxckRrRVhpRGZqYzNEMGc1aUhjbnVZNVRZbHZlbHJsSFlXV1NzQlRI?=
 =?utf-8?B?Mi8za2FUMlFjTFFpYUtFM2NFaTNHbUFkeS96akR1KzRQT21ROWMyZldPU3o5?=
 =?utf-8?B?UkJ4QTRDRnZvU3NaVGRLUm9yeVlpZnVpTHNmY1NIc2tadTgvMDQxR0hOd0M0?=
 =?utf-8?B?WXM5MEZGaE11bVdWbjRQK05pR3JwNjZtUStmeWttVDl0dlQ5TDkrOHd3WGhq?=
 =?utf-8?B?eUNDT1lGSHpTdkJwYlZ6L2c5TjlTb2ZCS050V0x1V3VyM2w5dHJyNzQ5WDRt?=
 =?utf-8?B?ck9iZU5oOG1sQnc1bWgyZGs3U2ZvQTZVeXA1cFNaazNpSmo2ZFF6M3o2d3l3?=
 =?utf-8?B?NFZySXMyK0E5VWE4alFrNkFzQXVFMStMMWt1enQ3T3JqZkp5ZkR6SjVCeE1w?=
 =?utf-8?B?dEJ3NGhXMnR3bXpEWHFlc1l3TW12dFlrWTg1V0tYNlZoWVA3Zlk4VFRiN3g2?=
 =?utf-8?B?SUYzRk1YRHRRenp0cVVmaHNTSXQyWWNDV2dSdGpZbG1EbGlTRHNseXovMWNC?=
 =?utf-8?B?YzF1NlNlL2RzUEgzNHQ3VkNRVjcyM0NQQlZRTG8rNjNtSnVLWW84QlFFQTlp?=
 =?utf-8?B?T3N4N3Z3Ni9oeWtTYVVlZUhCTk9GVDcrSzY1RlRwNHR5aE5zNUo1SGkxN2FB?=
 =?utf-8?B?Q3NvRGlhRmZtdzkxK3VXd1hYblRCSmJRaFFwNHRya3E3SWh2bDg3MlliTUhR?=
 =?utf-8?B?K0N2ZTkwM1JlTlhvMDh2UFY5K3Z0L1FFZU5pYVFkY1o3RFhBU0srOU9jN3Fj?=
 =?utf-8?B?ejJRb3FVUW1GWTNJVUhaVHAya3lLaUVqT0JsSjhvZ1BicDh5SUZGSms5MFJP?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 714db6c6-6be4-4319-1e9f-08dd7d2363c8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:15:10.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqqqv2DJpyoBPv5Ar2kjL9IAmnRgmxv8gZPla6QI67L1OVsszxzGy1s38r5bU1xCqNLwumeO9mPTmiboS7XhLhqNEHGyYv11K8OBrt3yI8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9251
X-OriginatorOrg: intel.com



On 4/15/2025 4:29 PM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> When the pds_core driver was first created there were some race
> conditions around using the adminq, especially for client drivers.
> To reduce the possibility of a race condition there's a check
> against pf->state in pds_client_adminq_cmd(). This is problematic
> for a couple of reasons:
> 
> 1. The PDSC_S_INITING_DRIVER bit is set during probe, but not
>    cleared until after everything in probe is complete, which
>    includes creating the auxiliary devices. For pds_fwctl this
>    means it can't make any adminq commands until after pds_core's
>    probe is complete even though the adminq is fully up by the
>    time pds_fwctl's auxiliary device is created.
> 
> 2. The race conditions around using the adminq have been fixed
>    and this path is already protected against client drivers
>    calling pds_client_adminq_cmd() if the adminq isn't ready,
>    i.e. see pdsc_adminq_post() -> pdsc_adminq_inc_if_up().
> 
> Fix this by removing the pf->state check in pds_client_adminq_cmd()
> because invalid accesses to pds_core's adminq is already handled by
> pdsc_adminq_post()->pdsc_adminq_inc_if_up().
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

