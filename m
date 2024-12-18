Return-Path: <netdev+bounces-153045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE939F6A44
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F40A7A5B72
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA501B0422;
	Wed, 18 Dec 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezucBYAy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9043145B1D
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536561; cv=fail; b=SEe4RbIcBuVaYJlIfeMDViJAvGrNYp9qMe0cHspf3RvaCrfxZvnot6eYskPpyvuhyz1M12zBX/NDtyPjeaIgGu4f+mTStmf6NN4psyXmdb4kdi6QcA608h5QzklBmB5PZuQAj2eWTyUhrFWAp64VjHkOTMxDHiubX5pnHdCzhBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536561; c=relaxed/simple;
	bh=zkmT4u/NqHSoXuWTK7wySSDNLvF2UFO2Uqmnzy7kU70=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T5r4WB5YfOqLkntevKixLivbbrI3nSgUhK/L6Ym9UxTaLng+COSIArozpiTMqllGQXXH/DNSa0O+cdotBu2Z0t+7413oayvNlvdT2ZRDChwL/v5YWYi2jDJS2L9FRFk59DLWfaf8gbD7wna/Vky+46JoFie78LUiqLiHicPi41Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezucBYAy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734536560; x=1766072560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zkmT4u/NqHSoXuWTK7wySSDNLvF2UFO2Uqmnzy7kU70=;
  b=ezucBYAy2Lp7RF1jIon/S7wQkq0lOTZbYtCibvpd3FEPT3nvVXQNVrYD
   zu+uoC46do5kxZ14NnnTA3EuumJp13tlwTW5NyKdP+RUG+9pl8DUVHGUG
   bWWTRuk2y8ZrJpD9mAWsb0etsf6wOXUOw8mgWCN9b8dqN6h9dvF3tIsXH
   wxnvfhAEIr4XVQ5wXelln+ONG9sIbyqTIJGQPr7iGBFEDcvAXaavME2xu
   Pl0+28+QlDxo0SikfhzGAmr3vftxwAXx54hw0cHNDYrboa6Oc9exB6X4j
   gGclw8vqBPvgU66BNL/fRC5KoCGxvKUJqcQMQ8LX9obAFrD9CvbesCVvQ
   Q==;
X-CSE-ConnectionGUID: 0p9k0sZVS9+t49N1viXDOg==
X-CSE-MsgGUID: pbQs2zpjSMertGIdKETPKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52544367"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="52544367"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:42:39 -0800
X-CSE-ConnectionGUID: 8nQbI1dHRfiTB68gIxanTQ==
X-CSE-MsgGUID: 3dT6/Nt8R2y9qhDNy9GvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102040921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:42:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:42:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:42:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:42:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzQMTnHBWlbPiFdp775rebhTCoSESS5kQf/XSW/ELf5k3plQsd/eh6HBv2TlLJ7Ot0rMVQYwoFX8WWI6X5V5tnthLVZx/+XAPW2Nuf+HRe1D7ZrZKxAwCqyYGA6mZhdTd78ItwAR8uH7zvxLoQRHNCCiduttuTz52woL1YcE3twt3GExuSIJuSNtdU0XRSTfqOEVpirniU7plAiJHE20W5VddSqlv5EYGTRqlpic36oawDfPCiDupH20gJzWnR4cgxRw9xcIBTvA9k3Gu89kfkC9v6YuoXTYSHi5vLC2JZ0Sm+a/gYmRgmmeyveHsJ5u5bSQxhJGdAzGahnptI/njQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW98Rsbzt16DWss70pg0NJqhtDki9ubFGfLGjIiOlic=;
 b=Sx8fGFFUdI4GW0LKc4k8tYSsU7EiBQnYwQGjpASb80vpH0QzfB5pEOznezG2htE1fYSzTB1vuWo7NwAX7ZcX75poYxp/2JhwiO3X6q0NOcDOxipL1iXYb/k/xsTAP3eVAl+HsxQ452JLyha9KuN4bS0irwA3y+nEl90IWRhgv9NV/DcuUqI5HO3BU5xQhOk/qTwMsktT+JZpg7DtQ+xjeBPZBDR5PV5f9f+APaqQfs/UhV1/zbTf+ZCNVhJRZhue0T13SEWXDTUPfi5ePbCX9HvhJJ6BC7TcB6gXBdDPjRzl0A2HdkzZTRSH2ZMyBFbClQ6l9yab3DG2T+I9BTFOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 15:42:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 15:42:35 +0000
Message-ID: <6f8615c6-3c36-4094-8c62-bf792fc30b79@intel.com>
Date: Wed, 18 Dec 2024 16:42:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: remove efx_writed_page_locked
To: <edward.cree@amd.com>
CC: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, Andy Moreton
	<andy.moreton@amd.com>, <netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>
References: <20241218135930.2350358-1-edward.cree@amd.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241218135930.2350358-1-edward.cree@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e33d14-5018-493e-6f6d-08dd1f7a97ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M20vc0tyM0xuOXF4QXF1amYwdW5PR0FyMmR3eVk5QUdDSWdYa0ZCV1AveG85?=
 =?utf-8?B?bUd3aVBlODFiNG1pYnExNXJtVEgzOVM4SGpXSHVybnlRRFlQTXZaNWc5MEtp?=
 =?utf-8?B?TzZXRytIaElJQXorRjk4Z0oveTRpQWRlTVBQZTkrMy8xYjdvUmNEVjFsblJz?=
 =?utf-8?B?SUhNWXRSZzlVa0QxTWJGSUw0UmpwdXpPL0dCZHk4OUtWUkFPWCt1ZnkrYzNP?=
 =?utf-8?B?UThFUDJzaW9Bb3RlVmphVEVHeUt6SEJvWUw0VXdPWDJzaHVGeDFlMmNIODh6?=
 =?utf-8?B?N3ZDeVh4d1puMGVpTmxIck1xZmlDQjJDMVlEajBKZWxZZ1FEM2RQMFBVYUR5?=
 =?utf-8?B?b1hCL0swdWdiUVdqbkdyVGluRG1qeUx3Y1B0eWNreE1YZkFza1NHY25yZWI3?=
 =?utf-8?B?T0EzTUw5NW5wWEJFajFaeVZnTElHQTdDaDk3VWZrdGZQVDEyQ1JjajdLQStN?=
 =?utf-8?B?UUpvd2JyaUo4SlFQcmxNNS94bVIyWWQzN1kwbklzOExPRHlGcHVGNUJvWTJz?=
 =?utf-8?B?eDVpekJlaGRNS2lWRmdBOWVqTng0dnkwMmRZREtCc0pHdjF2WllsUkVDMi9K?=
 =?utf-8?B?dkVpUUE0VFlDSTB2Slc3aHdjeE9ITHI2TXlyR24vZXVrOGhXRHBIRGg0T0RB?=
 =?utf-8?B?bVBZSjNhaTl6SjlVMVRTTE96djgxQ0VxcDdDMldINEo2bTZpTzlFMkNaL2Nl?=
 =?utf-8?B?Y0FaNVpvSC9Bem15ZDNGZmZlc1l3b1NxdVJyTG5SdFJ5aVRFRDdsTVROcEN4?=
 =?utf-8?B?Z05KQW5YU2dDZlpSei9PMk9iR0pEd1czYjc3MThvOHdtY25maWg2OThzdHB0?=
 =?utf-8?B?UHBqVnF6OU1LaUs5SURTTnNRbjdEdGxkQ1NLak95ck9NUXdiYnRtU21wNXBH?=
 =?utf-8?B?U0UxQ2hsak1KZzVPclZ6UWpneTBnYkNzclY2czJJby9SblY1WFUySURHM1h2?=
 =?utf-8?B?bGlXbWVYZURzUzVrZHRqME00YzJVUmkvNnZuUURrY0FSdnBCUFUzdHl5c3FU?=
 =?utf-8?B?MFpGUXpSWEt3UEllWXlVOVgxa1dkUzE0R1lhemlHUmsrR25mMDRvaWl5VlVq?=
 =?utf-8?B?dEp4RGQ2NnBaRDMvN1FuUmk5L1JpSUFNK0lHVHlaa0V2dktOY3FiN1pxNlla?=
 =?utf-8?B?aThDZksrbnhQTzlEcS9PSDZDNFJDcEJGUlozcDNhUG9JemRGNUFjQUVSNnE2?=
 =?utf-8?B?cXhNMzFIZkpaK0I4MkJldnBuNGFWMFUxYkpnWGUyTDZ4d293MGxyd1Z4c280?=
 =?utf-8?B?QjRGNXZVenlXY3l6OWhQYVl3K2pZZnhqT0VFRi9JdmEyWVZHYXFNdWo4UHRu?=
 =?utf-8?B?bGdXVUNIcFB2aXhudVBTbU1iMU1XKzdSdjBHSE9UMEtqQXZIZGlJQ3FKK1dT?=
 =?utf-8?B?WnpVa3RDZnU2R1VmbE5vcklQKzdEN2tjOUJnR3hlWDdZUVo0MVlxUWx5NTJn?=
 =?utf-8?B?KzE2UmNFYmh1QTNZNm9ZMkpqRXRObnBCbzB3Skp1dEVVSmQrbktJcm1PTHFP?=
 =?utf-8?B?bFZJbFZJaWRSYUlBczZDQnJiampCMk9OcHFYK1Fkb3U5VUFONHl2dG1jcmRv?=
 =?utf-8?B?Q2xPUFZOUkFRTkVFZW9MQWd2NUdaMXFXK21xTkhtU29mYmhXcEd0ZDVCNlFl?=
 =?utf-8?B?TENGbFlkd2p0d3ZISWhLeXZOa0kxbGJDNmk3VzdDczhRZG9SUDJ3SlNGUGtj?=
 =?utf-8?B?TkRDR09MM1lUNlF6V0dySFVuWjM3T1lGeWF1YVdsVE1yd0hqOEVFbkJJZExG?=
 =?utf-8?B?S1Zza2N0WmhoSkxiVDIrQTF0cnZsR1dJaUIyRndSekwvQlpTdU4reU53Y2lD?=
 =?utf-8?B?QWxxWWNHVkdWWnQwRGx3TmkwSENxU1JFWGFycWtQN2JvbG5yWGdiRExoUlU1?=
 =?utf-8?Q?mveK1xpHTf6HK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajdBVzJ2eE9xUUF5V1NZNjFmOElyeEZUM2FqbkgvZERpSUtmcmtmSFYyZUpl?=
 =?utf-8?B?RXpnRkwzRDhlUzVmNVB6S3BqTUVkTHN3NHo5c2FHRmE3Q0RiaUhwYXJJQSs2?=
 =?utf-8?B?b3pIVXNNNXJ0OWErbG9DWUdQU2I2OFRWUjQ0ako1OHUvampKLzlwN1kwK1F5?=
 =?utf-8?B?QW5zY2hTK1p4cVhRUzBjWVZFdUQySFhiSGlEekwvMXdBbG1XL3RJVEN3S3hh?=
 =?utf-8?B?SmVKN2dIUFY5MmszMEJnNWV2UzI3NE5lSVZSYytEWjJUV01reDNlUm1Ka1pB?=
 =?utf-8?B?eTFhanhDL2RHM2VkaG52T0c4OWd1SWl1TW52U2grSHN1MjJHdk85aENYVDdX?=
 =?utf-8?B?OUFXdkZzT3ZPNnBXVm1CVHVZWEx6ZGsvay9lc3hDY2VLamJWYm40TDVlYVow?=
 =?utf-8?B?Q3p0TU9BeE5JVC9ZTTNDdlB1SU1lT0JvbEQwU1ZxYkFBUHFiMml2eEZFVDhG?=
 =?utf-8?B?d3hiVWNSSUh5VGd3dG9oWTEzdjFmSE56UjVqUWNEbWZpYUYzRCtITDVqTGw5?=
 =?utf-8?B?UkIyVVc1MXV4R2cxRnJQQzU4WGQ2WFpaaFBad2FObUFDZ0duZmtZWVRDTVZ5?=
 =?utf-8?B?cFVoMk9KUzFJb3Z4SURsZC93NkdQb2tPVEh5M0IxaHFERmxsaG4vb3BEQTV4?=
 =?utf-8?B?RmpLcFVQRVRZNW9LRFpYM2x4LzUxZDhtaytYNHZqYmJFcm92Wko2TlZLaVRP?=
 =?utf-8?B?VG92Ky91alE1b0pmSzhmRFFjRzBYS092MDl4NGdFN1lreXVHZVRDRzVvZmVq?=
 =?utf-8?B?azg3SU9jaUsxOStWdm8ybGhPdVVERi9YTk13QndsQmJSMEZzMXZRZTl5UVFP?=
 =?utf-8?B?azVCU2x4Y2lWOHZQcjd3ay8xRWNUbTRBU0l2S2FrWTZUTlM1NnRBcUZvMnNO?=
 =?utf-8?B?QjU3eTNmNkh0ZCs3WkhlaEFEaDdHS3RDdmh1UkZVWkNmK3JJQUQ1R0RjQ1l0?=
 =?utf-8?B?U0NMRmVqQ2RVcnV6SWIraXdOZ3I1M0tyWjJEeHNoWm01VzZEK3lHbm9WWXdm?=
 =?utf-8?B?cU5NSVNBeGRCQXpPeXA0YXZ5em8vMFpjQ08vTy9McUNjb3FMVTFqdTN1V3BX?=
 =?utf-8?B?TTkxdnJqbHIwN2dDUFo2SzkwTGdKOCtrb2xiZ3V6eVdhMnFxaUpDVWQvclVW?=
 =?utf-8?B?UDdGd1lSaWZpRmV4RENueXdwamlXKzh5UVFPL1pHbFY4QlViN2ZVL1ZBUUFX?=
 =?utf-8?B?dnZycjhoZmFFSGkvNXU4TDRzcFRYMWZ5WGpNdlVYOGNEK1RidmNvZHBmYUlL?=
 =?utf-8?B?b05MaGhXb25FcFNwWTl1YVhoaFlkVnhrQnlYV1QrcUxjOEg5S1FRVDBaVlBI?=
 =?utf-8?B?aHNJdXNoWlR3TXRISm5RUXh5R2I0Y2xaWm1Oa0FCTVZMdjFOWjFKT1YvZ0d0?=
 =?utf-8?B?U3BETitzRXRUK001THY0ZmM3aUpxYTNiK1ZhSDRzSlhhTERidzY3KzEzR292?=
 =?utf-8?B?dlArNW9INHp4L3JRcnh1QmpIVjg0alFVMjZRSWNza2x6ME41V2F2OU9TQjZO?=
 =?utf-8?B?aVBidk84aW5Obm8xc0J3RURyNllHYUtSb2s5SExvcWlZYVhRUS83RHUyRmNw?=
 =?utf-8?B?blNHUVlkMTYxSWJHdHhkQUhNdTNleEg3Z3A1TFVPYkU0OWRzRmdQRnUyK3dP?=
 =?utf-8?B?SGhqOVRwQ3Z4NzRrZk5RZnVVL0xseEV6eWF0ZUt0WnNWRDVUZ2xaWmJYcytt?=
 =?utf-8?B?eDE2MlJNOXl4dWFPOVFReU9wY2lWb3c5MVdYb1BwMUFpb09JSmFUWVRBdmlh?=
 =?utf-8?B?VXQ3dXdKckxsNXFEU1c0SU42enBhaFVoNkl1Z29NMmZuNDNVckhiT20wWGdn?=
 =?utf-8?B?NnVUcVZrcEpYbk5mTUxJMWxPUTJFU0U4UHphVmlZNWEwZDlLMnBySFcxT2pt?=
 =?utf-8?B?MkkzY1lYdVNkc2NmcngwVlh3aVNwbUFnQ3Q5TXVVWDhxRDV0SjZNWWFsNklP?=
 =?utf-8?B?aGZaKytDME5KVzlaMzFESWl5M3dxS05jUVZHVTA3TXZIUEdUcUtSd2Y2cFB4?=
 =?utf-8?B?VkUvVVB1NlE4bkRlbTREZVpGcElBc2daSUF3R1Y4c2Vla21vZmhBWkZHV3RS?=
 =?utf-8?B?YW9obHljVC9kL3NoczlqVURFVE9BTjRuelVYa2N5K1VEdXdDZ1lzL2plSGNs?=
 =?utf-8?B?T0svRDhWRFdyblMwMmQ4WFFmK0lGMU0xU2NMVUtGRVVwbmcwOXJkMXZKb21t?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e33d14-5018-493e-6f6d-08dd1f7a97ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:42:35.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuQ3p1SINaP4aFPnnDru+og/mvkDD4OoTdRvpFI9jmdO0zkZB+PkJMc0K4k6hQfNY4mcteJXYvmDT4voNf2IqakXOG+r7N7xKit8NMQFtvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com

From: Edward.cree <edward.cree@amd.com>
Date: Wed, 18 Dec 2024 13:59:30 +0000

> From: Andy Moreton <andy.moreton@amd.com>
> 
> From: Andy Moreton <andy.moreton@amd.com>

The patch is fine, but here clearly should be only one "From:" line.

> 
> efx_writed_page_locked is a workaround for Siena hardware that is not
> needed on later adapters, and has no callers. Remove it.
> 
> Signed-off-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/io.h | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/io.h b/drivers/net/ethernet/sfc/io.h
> index 4cc7b501135f..ef374a8e05c3 100644
> --- a/drivers/net/ethernet/sfc/io.h
> +++ b/drivers/net/ethernet/sfc/io.h
> @@ -217,28 +217,4 @@ _efx_writed_page(struct efx_nic *efx, const efx_dword_t *value,
>  					   (reg) != 0xa1c),		\
>  			 page)
>  
> -/* Write TIMER_COMMAND.  This is a page-mapped 32-bit CSR, but a bug
> - * in the BIU means that writes to TIMER_COMMAND[0] invalidate the
> - * collector register.
> - */
> -static inline void _efx_writed_page_locked(struct efx_nic *efx,
> -					   const efx_dword_t *value,
> -					   unsigned int reg,
> -					   unsigned int page)
> -{
> -	unsigned long flags __attribute__ ((unused));
> -
> -	if (page == 0) {
> -		spin_lock_irqsave(&efx->biu_lock, flags);
> -		efx_writed(efx, value, efx_paged_reg(efx, page, reg));
> -		spin_unlock_irqrestore(&efx->biu_lock, flags);
> -	} else {
> -		efx_writed(efx, value, efx_paged_reg(efx, page, reg));
> -	}
> -}
> -#define efx_writed_page_locked(efx, value, reg, page)			\
> -	_efx_writed_page_locked(efx, value,				\
> -				reg + BUILD_BUG_ON_ZERO((reg) != 0x420), \
> -				page)
> -
>  #endif /* EFX_IO_H */

Thanks,
Olek

