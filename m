Return-Path: <netdev+bounces-99522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9748D51E1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13533B21910
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D54CE05;
	Thu, 30 May 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxwiUM1s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7F187577;
	Thu, 30 May 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094308; cv=fail; b=VI784GZnTLaY1ZI6WR8FHGpxEfhpUVLIJK+8+kkcrNFEzypZRA1oZ2vUGjIYX58KH7bnSdBwwSJ3cEbY65S44qbqrXMSU9TrnN70uRi2IIC/EPrNCy0wiGSs4YVuIPNAI2c0jNg3+VQ1BjJbIqi7lNlWrFkJEyUQMnSXxSyHSNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094308; c=relaxed/simple;
	bh=Y4olmUBENkf6FZ4yPcfkSgZZKFf01qE0/+Tcudj/4no=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzyW4acPMzbvkE2o2CnLFh9yzCInMxb9g7Tvcq+u6mA7jp+hhsErg8o+yLKDND++uv6GYAa4p7edJIxNWw+hcDl5Z15zxZtr994N0sY+Jz7/14vrEyPk47gM7/hdSWhyUWWCPbgDSuSOObhS/dnHgv7s6S7i/CTicuT2dltNuPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxwiUM1s; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717094306; x=1748630306;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Y4olmUBENkf6FZ4yPcfkSgZZKFf01qE0/+Tcudj/4no=;
  b=ZxwiUM1sedY4UXCX+S6/O/y3hUJlnjxXTIFhNMA1JMLuw/fGXnU+u8QR
   kf6WL1D0iPROysjzZq+cbQglpDqlbA+mRrDvSy4828c0o7A8C0DnEUd8f
   Aip/f58CF7OF4CgGR3V9Nfxk5JZvnJtsiI+FZInAVlztxzV9v60T37t+b
   1XD/39ycb7xXyUXaKWK59akW5ozlUl+8/I8/yxvRiv1Ov/2LBu/GFlGvP
   dD0LuU+nJeKNBMntlEaNA8QKQbFKEihlxNe5804cWQ3JwWXI9YUa29UCV
   rBbGNAMuZZQ69FtWpbXoVcBZ1td10SGWNTNgzeDu05Z4ojlKviR0GJQ7h
   Q==;
X-CSE-ConnectionGUID: +S3wDv0fQP2Oq7oBae3zUg==
X-CSE-MsgGUID: C84HLulkSLulFjLvBy2byQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24167617"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24167617"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:38:25 -0700
X-CSE-ConnectionGUID: vFPf6lQzRBW4kjQU4x6UCA==
X-CSE-MsgGUID: OtT3fxlYRP6X4NsuXyTZag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66775345"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:38:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:38:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:38:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:38:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im/0GDxb9k22hitTWaILEYxsJuWS9JiUdhJnHK6DHZ7MB/cfjOb9XXpTxxnqFFamgiatuTrNDmTOy85wOTQroB7apr3JQxjTuisVBSC3ONw4m5/U0ufw5XgPNA+MTAKt47zQPgMQIJNBu/F+bufuk3O9OfVOw+q/FOI1cC9oWtSYKa9snoQBjZ4Hh/r2TaNmrZQf2squB29Cc7RzxIsroCxRdbqdQtnAbPTLn3YObsrx+juWfQIGXqVGUKf3mbAeiZKqpafU9i3CLyX4rQucAoFF61I0cz4o74BEE+QSabuunTAx975Fo14gifqLXcuhycgyaEyzVX/AtyWh+v3LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ2g63CwHwCotKc/Ht72irZpF9c4TM2kGkcml0NjbW4=;
 b=kmw6qSK5J6BGvrU2WVnbaICzqaKm55bPnbTMHy/F8LzftzMBXweFTrBLS494nV8kGsVKCREuhueNXya+bZf5+qRrej0TkVoJdhWNAxwii85z/g1Dszbs5OHAZiAJf1Ce+q1EkV0CRI8fp0ltkzPyw4iOYtxcJbT61TT1s04Ux5aB6M2ntBOzVIPwYVkutgfgzfwh8jyjUvu3rTqLXDSUCuxxTuuBXtwzCgFmiCeIITU0Pu8yyl9bVFz2dLxi3T1/pCuPa16qhJ2O9ByCtdRFqJ8pqeRgnwVL+MzOWZmkZz+3x45dKwwcpAFgD2JJwpoEqHw26UKhu7VSYXepgDpMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 18:38:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:38:22 +0000
Message-ID: <6f4874d9-4233-48cd-8ee3-0576068fbc4c@intel.com>
Date: Thu, 30 May 2024 11:38:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3] octeontx2-pf: Add ucast filter count
 configurability via devlink.
To: Sai Krishna <saikrishnag@marvell.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
	<sbhatta@marvell.com>
References: <20240530101515.201635-1-saikrishnag@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240530101515.201635-1-saikrishnag@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe6cc67-55c3-45ce-de5e-08dc80d7af38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXlOU2ZmeDYvbElnMEZiTHYxR2VkMTU1cUgraFZtMjhmVWg4Ly9KYjZiMjNV?=
 =?utf-8?B?SnlScTlqT0Vidm9LUVBXVWpZelk5eVh5elJmOXdqQzVtcG12NmxwQkV6UkV5?=
 =?utf-8?B?MnB0d3pra3U0Qm5uR1pDSmErVjlYWk9OdzRCb0NsK2x3QnRHSmV4eTd1S2ZF?=
 =?utf-8?B?R01JeEMzVkdwTjZQVE40d3JmcStqYllIM1V5UFJIQWdoRCtOcGp0R3cvQit6?=
 =?utf-8?B?N2E0NXJRcGNmdnlYUlpudXNjZkEvK3c0TW1XbUJBYkpjZTg5azU5OE90NDlJ?=
 =?utf-8?B?OXNXR3pFR3BGWkNFaTcyN0llb3NmRTBZKzlUc3ZjUTJmWEtOOTNRa3lCVjJm?=
 =?utf-8?B?d2FVdXFxYUNucWQ4TkVaeFhhMGR4RHowbk5IU0N3MEpTdTJZWFBrakJ0bVh0?=
 =?utf-8?B?ZUN1UHFUOWhYNWhOWGIyTEVsOHY0dFROM0ZaQ2pxNE05MFBsaEl1N2N4b2Z4?=
 =?utf-8?B?YnR4bWE2ZlQrSERvc2R5Zy8zZEZFMk9BM09WdjRpa3NaenoyTmUzeTNnNWto?=
 =?utf-8?B?ZjBZb3QzU1QwcFNmelBsTmN6Y3BvSnllb2Nwcmp5Q083enVjSDhka2krR2hi?=
 =?utf-8?B?b0thNGYvUFg3bFRrU1dpZ21kRktua2NRR1ZlN3FRY1dNdGhpUzhsaFJPNGtD?=
 =?utf-8?B?cXM2NnhCWmhiWjlpMVYrbnBVdG83UnFyNVVQRHVYRWtlSUs3dk1GakFOLzVu?=
 =?utf-8?B?eHMyWmVjbTJPampxNDVwMHEyTmZoSW1NSWFneXZSK2p0Y2VLeVh6VXR0b3I0?=
 =?utf-8?B?ckFaYlpQeU55OTJHOU9UMEFzNGVhMHNubStrRnAwekVCRmxGOEx6aGN2TEtF?=
 =?utf-8?B?M0NRSjdJd09MbGZqN01MRlQrSTVzSkoyWU1XYWZaSFZmMG5GZGRNSUYyNmRh?=
 =?utf-8?B?R20vdzhyYUhlWk0yZ0xqTzAvK1laTjFnTklMT3V3S0xRbXBIb0R5LzZBR2VR?=
 =?utf-8?B?aFJmVGYrYSt1M29yeWZ5OHh6QmE0QWRHUjhNU1BEQ1RIVGZYbE1CRWJaZ2hG?=
 =?utf-8?B?TGhoMWhVSkZOQlFla0FnWlVzckYwRFZlUWdGRU9uUTZjSjIwRnRuRTZaNU51?=
 =?utf-8?B?amkwUU5VTkVjVVl1bTRlS3kwY0NXMDNVVjdJcERDTkNVNmw5K3BkSGJKZEdr?=
 =?utf-8?B?VFlPNW00S0ZjRzBQQVc3ZFd6Z2ZRelloYjhDWUdwc1kreUdpUWpKYmlXbW5s?=
 =?utf-8?B?YlExK294ZFpEamNLUnc5NEw5eE5pWG83VHNGQVhoSHVlT3lpWEVNNS9vYUFv?=
 =?utf-8?B?cHJPZzcyMStrZmZjdHoyNmNWc05YOER6ZnFDc2hwTXhFZEI4VU5HY1kxMlZi?=
 =?utf-8?B?alk1RDNkYk5SL2xDNXR4VHo0SitheXNpZVpGd2Y0bWJ2L0lIRk5aSjBLQ2J5?=
 =?utf-8?B?bUlNSEVpRHJzV3BrL2xqQ0tld0FQZUh3VXlzbENaUDVqdmtucWxSckc1K1pQ?=
 =?utf-8?B?R3V1cy9KOHV4OExaVlZ5MmR6a0NjNkpjVTc4MzFrWFpvRW0xVTVVSTNuaHkr?=
 =?utf-8?B?TkFXK3hUbjRseHFUVE5rRjNPbk9kUmVObHRIeEVxNm1RTzh4dm1uNmRrZGpi?=
 =?utf-8?B?L3dwSjRIeHdZdXBSTnlidEZ2YlE1YzlwRGFDbFpna1hhaGZSdlBoa2ExTUJZ?=
 =?utf-8?B?OWo4Mm9ZYXJpeHVwUkVFM2dkWVNudFZWRXpIZlIzSnI4dlYrN0QvUjR3encx?=
 =?utf-8?B?QWF6ZHdFNC9vbHZPYTVSam9BR3AzRW04Y2t6Tmw3VS9yU2dPUkI2VzhzaXBG?=
 =?utf-8?Q?sbnlVgZfDsmaGiEK3pDwvq5Yh2Fjru5t375KlPl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymo3YWJCbEdsSVRQWlNYQVpCc1l4TGsrYnU0YWUxdDdvNktaT3B0Q1hMd2Za?=
 =?utf-8?B?T2ZrOTRWdG0rbXFmNXQvYkFvOEhkU2ROMlJycitZaCtoYXpzRzEySkZmRVUv?=
 =?utf-8?B?K3Jya1hxWDVDL3NrSW5VVUpRVUVLbG4yWnY4dWNzMEg5R05WUkJGTkZDWCs3?=
 =?utf-8?B?TXR6dG1xbEgrSXZveGpUWExGRUdaUG9YVjRzRjRUQU1KK1VvOWpSV0RLQlcy?=
 =?utf-8?B?eUJyK0lYNVFPcnhhTHd2UGZKdzJVSWYzRUNjb2lMSXRuNWFCWEx0WlVpSWF4?=
 =?utf-8?B?bVNuS3VRK3BKT3JzbGxoMjVlUk9GajcxUjFBZ1dKM1lsN3NremdKQlJ2M2Ri?=
 =?utf-8?B?RHFUWVRNMmpYMVRHSFlXbmg5YXYzUk52VlBpZFh6ajhlcEkvYlR0T1ZpdTEz?=
 =?utf-8?B?eXRoelhEZkJ2L3JmeE9wRXd4L3h2cFB3cjVLSisxTldxVlltZ2t4UjdTWTZK?=
 =?utf-8?B?Q2kzUm12MzF0MTd2aHFvZ2VjcGFkdjkwMXZQaW1CcEZyVzBNOGg2QmZhNC9O?=
 =?utf-8?B?SFVuRFJMNVhORDhBenVjM3h2aWVXWDl4bjNGdXRQaXQvamlMMmlYeFFrZmt1?=
 =?utf-8?B?ZGhqVlRPcU4yMkMyY1NTZzVIWlYzWUJwVkNSWmp6QzM3SVlra2FCNHFKRFBo?=
 =?utf-8?B?OGVTYnRnM0djbEZSTUFDZGtFaEMvRlI3aDRvVzBnSm9yWWxucktXN1FnU0JM?=
 =?utf-8?B?K0xTT0xCcUZOVjB1VkZKZ0gvdS9TN1hacnlVc1duampXSnVlaTZ4VXp1blh5?=
 =?utf-8?B?TGlYZHAvRUJmRFh4UlFGTTUyV1hJL2NxejdUUWw3c1ZoRllBam5jMDJXWG10?=
 =?utf-8?B?MG1MSnp3ZVRQQkVCY1JtSVdjV0ZOU05tRW43YlNLZXk5TndiTURGdTJETlY3?=
 =?utf-8?B?T2FDdXczQ1NaM2c2c2Q4ZHFhMU1haTNCeGR4dDBUY1dUVDZ4VDN0a2U0N1hU?=
 =?utf-8?B?NE5NMWRORW81NktoampUWnhaL252aDMrWE81Tm55S2NDangxcWhocWZ3dXFk?=
 =?utf-8?B?dE4zenBhNHBHM2EzaFg1OXVtTU9IZVN1RjlyNldtSUpJQ0M4NjZrN1Bzbm1W?=
 =?utf-8?B?MmQ3cTJVQy8zNmlVbWN1OG1VWlQ4K2NzUWw1bFRQTjJHdWYrTndwNWJiTEpB?=
 =?utf-8?B?RS8xYWxZdlYzN3ZpWW1LRnh3RWI0alg0Q2h0SWFKZTExV21FN0hMNHBZZ0Jh?=
 =?utf-8?B?c2oyY1RuTWdESmpOa3ZFTWhqbjEzSUl6bkpFc1pQRXdZYTQ1VG1RU1lKRnNn?=
 =?utf-8?B?Yk1mZW1NSUVMZ1NSSWxWc0hSVHY3ZFRMY1c2MlJ5RXJncDNxTS84dGVJa0hm?=
 =?utf-8?B?TUhueU1aUVRCVk1aN2VQZlRjM3lhRnpEcDlEZ0FQMUpJaDViZ3QyVHNOUnVD?=
 =?utf-8?B?d040UXhONUZlZnVmRUFHbGovVzRlV3VReWYreHJwR3JFUzNTSDdBZWJBZEVw?=
 =?utf-8?B?QnJTVzh5bDNGWXBIb1R4RWN5bStzN2p3Vzd3MFNlNWl2czFQZWttQ2pOUE0r?=
 =?utf-8?B?SDluaUozREpiY0d3WERZZ0hTM2pHZGM2VmZPbGdDYUU1RXhZT3dpN3cvV2xD?=
 =?utf-8?B?M2t3RURXUGoyOGVHMVlHRmljTklBUzV3Mzl2SlY5S1cybDNiMzFmS3lScnBJ?=
 =?utf-8?B?dWpIdEQ4SUs5dXF0TU5XdjhIb3l2VTJnb2tnVUp3cVFES0tCN3VSVjQ3MUxC?=
 =?utf-8?B?cFVQTzhDR3ozNnA2aWsybDhxaTUzanVTalMxK2NVSVNnUGVKdU9IQ1VIT0FQ?=
 =?utf-8?B?a2grL3RXaDU1M3F5UmdFNUJOWXdxMzZtRDFPbTk3cDRqK01BZ0d6TEtlMXlh?=
 =?utf-8?B?OWJtN3l4OEhqZER4aXRycmZ3L3FwVEpuaVdDOER2MEVIaDlLYkdWVWJjZ0cr?=
 =?utf-8?B?TkdWREhnUkhTVWZiQ205QTlzWStmUTRWUHhKa0dQUlBzRlZwam0zVlJBblFR?=
 =?utf-8?B?VVN2eGZLSy94WkR2RzhXd1loZ1dsaDRxTTFNNXd2SEVxYWNFUUJVR25JNGtK?=
 =?utf-8?B?ZWVDSzQxeWl3ZWpZa21FMGF6VFI2N216VkRoY3VIOGxGYUdPcEhCZHBjdndV?=
 =?utf-8?B?RCtrVEpqRGlRYUl5ZkRnT1B3RE9pTTRIQlVERHh5TGFHSHRIT25GU0lla2Ez?=
 =?utf-8?B?aHJqVmxYMndNMHJpUkpHR2ZWdE83UjRGTytlRFV6aTg1akNSeHZ3eDF5YXAw?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe6cc67-55c3-45ce-de5e-08dc80d7af38
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:38:22.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvN/tq8K++quRLCCBBsxVfrG6n6t716ouH50CJN5XJxPkNVYWJZ/a0byCrJBA2ZA+9Jbl9b1mtVwPyMSOYWsAVKqVDmFlXkMVzggllb9Jho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com



On 5/30/2024 3:15 AM, Sai Krishna wrote:
> Added a devlink param to set/modify unicast filter count. Currently
> it's hardcoded with a macro.
> 
> commands:
> 
> To get the current unicast filter count
>  # devlink dev param show pci/0002:02:00.0 name unicast_filter_count
> 
> To change/set the unicast filter count
>  # devlink dev param  set  pci/0002:02:00.0  name unicast_filter_count
>  value 5 cmode runtime
> 

A bit of explanation about why this needs to be configurable would be
useful. What is the impact of lowering or raising this value? Presumably
you need to change the MCAM table size? Lowering this on one port might
enable raising it on another?

It seems reasonable to me, but it is helpful to provide such motivations
in the commit message.

> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
> v3:
>     - Addressed review comments given by Jakub Kicinski
>         1. Documented unicast_filter_count devlink param
>         2. Minor change to match upstream code base
> v2:
>     - Addressed review comments given by Simon Horman
> 	1. Updated the commit message with example commads
>         2. Modified/optimized conditions
> 
>  .../networking/devlink/octeontx2.rst          | 16 +++++
>  .../marvell/octeontx2/nic/otx2_common.h       |  7 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      | 64 +++++++++++++++++++
>  .../marvell/octeontx2/nic/otx2_flows.c        | 20 +++---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
>  5 files changed, 95 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/octeontx2.rst b/Documentation/networking/devlink/octeontx2.rst
> index 610de99b728a..5910289b4d4e 100644
> --- a/Documentation/networking/devlink/octeontx2.rst
> +++ b/Documentation/networking/devlink/octeontx2.rst
> @@ -40,3 +40,19 @@ The ``octeontx2 AF`` driver implements the following driver-specific parameters.
>       - runtime
>       - Use to set the quantum which hardware uses for scheduling among transmit queues.
>         Hardware uses weighted DWRR algorithm to schedule among all transmit queues.
> +
> +The ``octeontx2 PF`` driver implements the following driver-specific parameters.
> +
> +.. list-table:: Driver-specific parameters implemented
> +   :widths: 5 5 5 85
> +
> +   * - Name
> +     - Type
> +     - Mode
> +     - Description
> +   * - ``unicast_filter_count``
> +     - u8
> +     - runtime
> +     - Used to Set/modify unicast filter count, which helps in better utilization of
> +       resources against possible wastage(un-used) with current scheme of hardcoded
> +       unicast count.

The text here could be worded a little better. Once the patch is applied
then hard coding is no longer the "current scheme".

I might have worded this like:

"Set the maximum number of unicast filters that can be programmed for
the device. This can be used to achieve better device resource
utilization, avoiding over consumption of unused MCAM table entries."

Or something similar.

