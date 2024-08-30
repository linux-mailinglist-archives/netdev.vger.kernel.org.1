Return-Path: <netdev+bounces-123852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC2966ACB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DC2B232DB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1681BF80C;
	Fri, 30 Aug 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqVN486k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2911BDAA8
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050359; cv=fail; b=XOAQBWaU/+6ug1ZH88M+k8ozUqrSqgiWpVGk6LKUHFM3M1D1nDYiJTcOuQXudHv0Kb0egtaevrKR3kIYU/OKvQEJ4fiMaZQxZvm2zY8oGaGEIAFihfUxj2Wwt16bE58ozMqWHh0jZF8qfJArxXe2AHBY51xPZ0AdKbSDR8XSDV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050359; c=relaxed/simple;
	bh=QNqtE+H84Dudx5TlGEhzkOdXWMUT3jiQl9/9FGAZO4A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DTejUIS9cla/3jpRrxjJqFU/mA1LZ80s8E5mdxhkEg/4Em19hNrXQsk3qq71rWljEObBKsMcKlqfDBtm/Ih/uxx+n9yiE616dn34uPjQEr2i7yKDj4mfv2rv6NJjGoW9pSyIiw6xldsqBu7Nj16ETjtZ4iQfR9D4q7U5jV2CdUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqVN486k; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725050358; x=1756586358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QNqtE+H84Dudx5TlGEhzkOdXWMUT3jiQl9/9FGAZO4A=;
  b=DqVN486kTmk8GpWUF41bA1k/HUqM7Tl1W2o3GFjmKe2xRxJ2yMGRLd1X
   u3LWya5G+c7bEFw9ReM17TND7g0RDKLskAicTYfI6asO+sOvenVPMkXZV
   yVWZ9YTM3UW+LgFQnyNNJrTDBXGmpXS5EmNoVVhSPlpvYcRFCZfRsO5KM
   dPBpLlo0373laVgrjo7I2n8xf3ieZXEQIyFAWqtJ/CKsjGVTsYuCI4NsZ
   3aj9dPN3AxC6DYBzYl6XIKfA/2om4NaOTspMi0paNsBhUTKTca25fMraH
   Chd0Dn0TeSl9Zj65VuCDhi4qI3oVljIJfm4u7ZnP9QSl6LpAkHd/0jaK2
   A==;
X-CSE-ConnectionGUID: wooqUzzYSVOjAnDYdmHytw==
X-CSE-MsgGUID: may3sSjaReqD5bDL4mp3Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="27498804"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="27498804"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 13:39:17 -0700
X-CSE-ConnectionGUID: /ZHjuky4SGKWg1jC9bWiJQ==
X-CSE-MsgGUID: XazVmvraTIKHm/P+zdfSYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101494080"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 13:39:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 13:39:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 13:39:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 13:39:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSQ6yVzXOmH8tdsl7JaJO8SeAaCrm33Q/l29hkxE4Impu3qtLMZxPt2H+H3kLlKm7wtRpuvuFGf7ZvTbXyyf7sNWZLDgbX/XVWycMMsQg7aUJN832/cY2dNdfn3xl28MuvHN1WbKxHwvz+A2Ng7qfQEqd91H0giueVtF5eqkTGEaNfaR5l0ztrFJQcOBOdraLTD9lIQ1TtmrdTohsS1t5nBrVSAhh5B4J1jCmrxEJsyPUKfL/H923/411Ca4AQjY2Xd+zdJlhs4y+n6G0n1WGKwQbioGCpTpObGiayowOAkXe25sjha1x74BC6xYwM/EybAW2A/ndI4wF5vJcxNsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkmoDUr3nDSaoZ5LRd32oj1RhTmLHCq0p8IYsx65mVI=;
 b=KvNqiqfE0czqChgWhH1TSESTGTjLtmCmXDkCyWTMOrVyekndVrRunxYvdiu6wVnojSUwT4HcwEj/dJMao1fq7FtiOSLjfMt7Agtkh/ukflAqcIGl3ZIfqG7MUGvREZkZJHnka9PoTuj259Gfu7OtxRega4kTNaDf9QmZVHSB1MzaygGF3zt23Kug3206fb/XtKlUkU5dAhWilncxKNfJaL7qote4jtqMdm5Pq8xMyOIX5ndGU1A8vaVcH3lFxcdaLHKv6MfnFw7EzuC1AzGg5GSsocjc3jvaxIXs5DiHtNZNSAnBh+okkp2/iB+MyU7aMNuM163s5HiBtNtzu3X12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 20:39:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 20:39:12 +0000
Message-ID: <a45e79f0-ccd9-6d66-19e3-689c9d510c97@intel.com>
Date: Fri, 30 Aug 2024 13:39:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham
	<sgoutham@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Christian
 Benvenuti" <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, "Yisen
 Zhuang" <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	"Jijie Shao" <shaojijie@huawei.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>,
	"Subbaraya Sundeep" <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Bryan
 Whitehead <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"Horatiu Vultur" <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>, "Edward
 Cree" <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
	"Imre Kaloz" <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
	"Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 933c35df-5248-4227-e545-08dcc933ce4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlNoQmdSc3ViRmRxdE1DL2ZNbXdhN0lhZ3BwNHlNTWRlNkZIQXVYZy85bWFm?=
 =?utf-8?B?YldoUXBCN25Ec0JVb1J3SGQwVmpkVGZwcnBPTkh6aXhxRjlDMXQwOGdzaHYr?=
 =?utf-8?B?dTV1b2ZOMWp5VjdNaGZpNlB4em9oYjhiTm5CK2JzTlA2WGhyYTdlR2tSTVdW?=
 =?utf-8?B?OGFuTUxNUVV3QmN1THZhdGkwRVB1VmJDc3I3UTJXNU1rdjdnZHlxQmRCOFdo?=
 =?utf-8?B?OE82eHFrMDVPRlJNSkdvbjFlZXZ5ZWQvSlB2aU12L3NsOERNV1d1NnY4M1kw?=
 =?utf-8?B?Y0xkeWpySnFUdE1HSVV1ZEpUdEh0NVNJWFpTZk5rbGlFOEZFMjZrdU9FRFJB?=
 =?utf-8?B?alEyZXQrWU1YaWNFVlUzdXBwaGZhUUdPS2RuWnRla0xDdENGQTF5V1RlZEhv?=
 =?utf-8?B?N1ZaaFNDVi9ndi9scVUyOXBiWWZQdC9sRERhUjB1b0RWcVA2cDZtc2p4ZC9L?=
 =?utf-8?B?WDZHbkZVeHgvczhOVWxDeVdqbVJDaUVrM2llckRBeU9jcGxvVDdLMFpkd25w?=
 =?utf-8?B?UEhxZmk0d3NsYlhjeU05elUrNkNHc0FXYnpzRm9yZHBhZ21PZUFkRUFkYzN1?=
 =?utf-8?B?cU1Rd1YxTzRGVnhjWHY3eDBDK0kyMVYyRWRsSVJid0lOU1V6TERyUWJZeFFy?=
 =?utf-8?B?OTVlcDh5aitkRnZuZCtSVG4rYmMvUmVwc1VHeVMyNDlnVWhrb05nZmRxMlk2?=
 =?utf-8?B?VzlUOG01cmtkZE5jZkxBdGlDZUpadWRqSkZZYXM4bHlsTGwwR28rd3hRTHZv?=
 =?utf-8?B?bS80bHdlZ0tsdDkzelE5Sm54R3J2aWtFNjRNZVpzc1I5SUhhdGpOL1o0QzhL?=
 =?utf-8?B?aWd2SUdkQnBYVWVlYTNhNGh2Sk1zby9xb25qSlVKVW5zMGRoMjdIQ2tuM0VT?=
 =?utf-8?B?MGplU0xsTWhDOTRuSU5JNkx2U0ZkQ1ZlSXZLelpzV3RJRW1xcUZzNzZwQStq?=
 =?utf-8?B?aGkwbms2ZUxNbjVJWUpRZmNkK25pdDhyUkdTdFFJVy9JdlRoNWg5RU5yZ2ZH?=
 =?utf-8?B?ZGdOeU00N2VCN09FdjRtUG5qYUVLVVYrZzdRbzVJY0VHdElPSEYxTUZKNy9G?=
 =?utf-8?B?ZGN0L2h4VGgwb2FMdENjRDlUVVNkRFJpTHNuV254bHRCRmZlc2xHZkF6TGo5?=
 =?utf-8?B?a3RaM0NLNStncVRSdG9iYkFvcGtwZVVPU2IrdVIyTXlTNTRKTTFzU2tHSzFm?=
 =?utf-8?B?aVZMVVlYZXRsTTc1L2xuNVNXeVRjbEdUZVZkdkRXZWpSUjQ1a05wcWN1T3NM?=
 =?utf-8?B?V1JkT1NSSG5GRWNsTGI3NFZESFM1QmVzS3BQRmJXRU05UVhHdHU0MkttRWNn?=
 =?utf-8?B?UDRmR3BVTE9CczRiUmpoM3dXMzRXTzJqN2c1d2hudE1LVU5hUDczZGw5T2dh?=
 =?utf-8?B?RzhuaTZIbDltendseUZjQVNzMkZaTHljUFhPcnJSM2lqbHF6bHJaQkJQelFp?=
 =?utf-8?B?TVZrYm9SL0lwMTNWaFVtNzNzR200OTdMbVNVWWYwK3p6d2tySkhlUHRpTjJr?=
 =?utf-8?B?VzArcldxUWJ1ek9NN0RHKzE3RG1CWnBPMEdwb1J1am91UzUxZm5IQlJTaWxr?=
 =?utf-8?B?M3I4WnQzTFNLVjVhR2UvNHVKV25TTDhneHZHeDlKZjkybkVLUVNnY3U4T1du?=
 =?utf-8?B?Zi9FNnVHN3ZhV2t0ZW9xMzZ6OElibCtTV29USkI2OUw2V0xuMmk5ck5xZkV5?=
 =?utf-8?B?Sm9jcWdwN3JPaVBSS2J4dGtBV3VyU2ZtZWlDWVFLMFhtNkMxNER4R3dLWnNY?=
 =?utf-8?B?RVNpVDFINkY2eitrWlZmdlF4NVBGd3BVdEF0YUNyN2pEenkvZWx6dVdJOWx1?=
 =?utf-8?B?dENUYnM5NnpVS0Zxa2M4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFvdUplYXRQdnZKcSs2QnZtUWVrZU1aRFdDTkxuMjJHL3lRb2cydHh6SW1R?=
 =?utf-8?B?K3BlektmM0wrYjl2NEFSTXRuR1orU0grbVhLbjcxVUt3WktCZkdjTW1wUzBw?=
 =?utf-8?B?dXM4MmlmR3JNQlpXN2c1RXFPZEVsb0lZMnZvTjQvNlFhdjVCTzZqUmhwaHlm?=
 =?utf-8?B?K2pwLzRhRHM5K3RhL09lZm9USndEVkdnUkFOOHJJbW8vVHlZL2JrZFNySXdw?=
 =?utf-8?B?dExUNXA1U3FHZExCWk9kRElNSGRjTGx1QUh2bFpBbDFyMFg4SDNub09TZlpP?=
 =?utf-8?B?dTB4VldmeWMxdkZOSExVT1ExNUtwZ1dBWU9IaVI2Y213NmI0UEt4UjZYWENi?=
 =?utf-8?B?K1J0TC9sUGM4N3QvbC9ybzhJNDUwTHU2b011Z2tnMzRTMFdTVGd1eG9MRDZE?=
 =?utf-8?B?YjM5MHVYWG9JR0E2K1M5VHF2ZVJvcjZwVnpiOGErMVBxVHVET0Y1a2toTFFo?=
 =?utf-8?B?alA0dlNKTG1jN2JYd2I4UXp1MEVqcWpZNk9VRkRpVmQxUXRpVWZZVngyaFZa?=
 =?utf-8?B?S1ZiNllTc0FXdytYNTBLVkltUlZ0ekgrbnFZcHlCWlRONFF2RGY4MlljQzhr?=
 =?utf-8?B?R1FZR2Z2a3k1ZmswcjZQRDN5WHpaczA5WU9xNGdiNGNBa0JCeHl2NXhSWDll?=
 =?utf-8?B?cnhYVEY3OU9UdXZUV1llb1dyK05LSlNlSlVMSzdSV3UzeHJKMXpuT1ZBR0VF?=
 =?utf-8?B?aDYvUzdkeTl5UVdZazltRWpsdmNrZWpySU5LZ3FuTHlTdFhhVDZydVJMWjlu?=
 =?utf-8?B?aVVIWHk3SkNkOWxIMGdwV2l5blhkbnN4NjNVWURENmhseG03N1dZTE91QjRI?=
 =?utf-8?B?RTFxWGM4OUFyUEowVGRxM3ZwWCsyRFpIRStKeFBkZ1ZqWGxnZG1IeDZvTFpN?=
 =?utf-8?B?cHNJNjdTU1VzTDFxdWZ5MDdTQW1WTXdyUGtEbXR3dXRFUnRhb2pUZUpqRFY4?=
 =?utf-8?B?NStQM2xOQ0s2REJGenBLMEpINDlnd2dGVm52cXpaNVZyQjkyNTcyTk5ianBk?=
 =?utf-8?B?KzRzYm0yc01aQTNKUEkwdzVzTm5iU0lIUFpRTUhCOFoxNjMwZmpQRW9MeE95?=
 =?utf-8?B?ZVg5dVZWMVdacVZSNkJRT0ljRWlyQThlY1ZadjBMSmZ0RDl2SHlCK0JPV1V0?=
 =?utf-8?B?YUdodnUvTjZ3UjZvRENOR1UyMjdOMEZkV0dMTE5URUo3d2c1dDE2Zk9KcWpH?=
 =?utf-8?B?QlFZMlMrY1VXVG1NSmNSOVJYTVdWaXlLbS9LcU15byt0SmRxRndMVGtqQ1NJ?=
 =?utf-8?B?QmRWMzU4Vkthdjg0ZUpTWnlIS2hhaTZ5RmJBVGxlejE1U2NNRHJBL3Npd3ZI?=
 =?utf-8?B?RERWYWZFYVVKZHRoOE5PQ2ZIbjNocnVuQ0xmQnJpUnNYOUorZS9Yay9Ta3VX?=
 =?utf-8?B?OFVWRHdtenZ1ZG9yZm15SzNIUXNuVG9oR2dNSzZvZEhkTm9vWiswdWs1ZkNV?=
 =?utf-8?B?b01XYlc5MUxHUGVPS2ZuQnJXUnlFWnI4aEhLTWdOTitzU3VmZG90OFhab3M4?=
 =?utf-8?B?dmd2RGNoSURlZUQ0L1A1ek9Hb2R1YjVUd3hlU1VCZXluOTlZckQ1THAyS3dX?=
 =?utf-8?B?TzZqQWU3UUwzazJvQThsamtINTRPNGhHb1FCRCszZUM2UTJqdnJCS1dMMWRn?=
 =?utf-8?B?L3lScS9lSStFRG03NkpXcWFvZUxKeFdvR0k5TG1tRUk5TENNMHJTcXVveVZU?=
 =?utf-8?B?Z25CS09SdUt1Z1QzdEJLaFIzN21ibUtkYjR6V3ZxV0h3ZldMU3JGUHpyODFj?=
 =?utf-8?B?RWNua0RBS2VTc3RMc0tZR1p4Qzd0QzlOaTUxMzVqdHl3Mko1ejEyeXpKbXJi?=
 =?utf-8?B?b1lrdmMyYm42R00rbU9hN3VOcC9vUVVVT3FRUC9hNzdQK0c4ZS9lUDBjRWwv?=
 =?utf-8?B?UW0wRzBjTXloc3Q3Sk5QMEtmZFlva0pxa2ppSTJza0t3ZUJ4bFY1TloraG8y?=
 =?utf-8?B?eXYzWjhZR05oWlhQS2dHajJOMXlreWNtMmFYeDRIV1puQ2NrMzN2cTZZN29J?=
 =?utf-8?B?YXc2aVVDVTVCV1E2cXc3OGI4Y1Z6d2ZTTnZLbVp1b3dGV0lzMVFJWnB1TEsv?=
 =?utf-8?B?enRoWXJQOHhPTGptYXJiMzF2bVVqMk90ZUorYXRVTXFISXkvTGhCakttZ3Br?=
 =?utf-8?B?ellXcVJnQTBaVmJJTW1CbjZINlJCckpVMmhleVN1NzI1NUtZNG01RGRjSnha?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 933c35df-5248-4227-e545-08dcc933ce4d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 20:39:12.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5oDdMt4lObC4/JWCOXV9FJ7OysXUBbV6/tjEq9ryzO4/lGxNGPu19rAA8g6TkG4rs4e+tjEuBpVdZS47SVxm6400vO5PSt0zn0wV+bBPRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com



On 8/29/2024 7:42 AM, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>   drivers/net/bonding/bond_main.c               |  3 ---
>   drivers/net/can/dev/dev.c                     |  3 ---
>   drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
>   drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  4 ----
>   .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +----
>   drivers/net/ethernet/broadcom/tg3.c           |  6 +-----
>   drivers/net/ethernet/cadence/macb_main.c      |  5 ++---
>   .../ethernet/cavium/liquidio/lio_ethtool.c    | 16 +++++++--------
>   .../ethernet/cavium/thunder/nicvf_ethtool.c   |  2 --
>   .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------
>   .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 +---
>   drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
>   .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
>   drivers/net/ethernet/freescale/fec_main.c     |  4 ----
>   .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
>   .../ethernet/fungible/funeth/funeth_ethtool.c |  5 +----
>   .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ----
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 --
>   drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +-------
>   drivers/net/ethernet/intel/igc/igc_ethtool.c  |  4 ----
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ----

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com> # for 
drivers/net/ethernet/intel/

