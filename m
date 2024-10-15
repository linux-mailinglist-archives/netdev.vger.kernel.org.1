Return-Path: <netdev+bounces-135864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326E99F741
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894031C23228
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057E1F80CC;
	Tue, 15 Oct 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAvtwALd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2821F80A1
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020422; cv=fail; b=e5a2GJ8CTO+k6/8WCmw3QfxaPK6fXvhx7uj2jp7hzOoejqrQDWyl/hl8BXaGDAQ961CsilYO84aBbG+W3JPWiHj4CkpyleByUFvnntQi6pQz7jlxWtjVz9MuMDL06pd/BJOIF7RTnHf8DU/TOWLX3J5+Ra8w7jAdXc68mrb7Zhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020422; c=relaxed/simple;
	bh=iamUgUZcM8GCnjAx63xNf2QMZXZNholuFbrjLsfdfWE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtXit1k4nS05zTyi0JBCLqewUbbDyNlRedpuk2F8gO75mbdIyUClkohokAfPuyMaczNnqpLQyVZH7lPojAxo5Eu/Hup8AZgn17PTmNC3lM6fcxPUGhLPon8mYkGX8VQXiFg5EKkDjkHvACO/wwavzUO7u5dAUEdujmsBCpT6WZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAvtwALd; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729020422; x=1760556422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iamUgUZcM8GCnjAx63xNf2QMZXZNholuFbrjLsfdfWE=;
  b=MAvtwALdEW6+lir1pMHW4N7V4RVZV4spb4XHFKl6++p0rtJyXvX9c6dX
   A8vADr3jJhp/9UM6ig02DAlp61Y8xKaf34OeHcdMWVLwt5wsJzqSkAAdF
   J+7mr1rX4n47nnq1CiJf0vixZcBjPwtQ0upFEvu43hLUYo9WPks2B5sQr
   TykQzHRFR6WMPmuHhc4aWLM90kK4efCt9Omh97ST+qNONyCwWfQkmiZvj
   Kf8pZmQKBeTw9c8TJitrI8gwFACsQmr6zpR0Fxeh4nciyepSb0Q34jmV2
   V+O7gj/oJmHN2l0Yd9mpEIfDXwMiT8DSIZKOb0cL/BW0fXN+GFExCsqNc
   Q==;
X-CSE-ConnectionGUID: R1/GqZHYQcuQX78bVKYd5Q==
X-CSE-MsgGUID: vLzdgGODQbG3YYUPMqFIOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39013201"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39013201"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 12:27:01 -0700
X-CSE-ConnectionGUID: l4leIUThSduWGWBSTCzNgQ==
X-CSE-MsgGUID: vPVmvY7ASfinia0/C0acpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77656511"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 12:27:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 12:26:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 12:26:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 12:26:59 -0700
Received: from outbound.mail.protection.outlook.com (104.47.73.174) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXh0uhaoYlReLRLyZu4d5ztQDVE3eNa/qu+JseqJ3WXg7BfyPHQXPDMTt+jrXYFtKHcgqs0fpPIUIJujU2mdrmij7KQ3K3MvIs5+0uufyXMIk/e/olPfDdm2JCKUdUpUgSAEdUapxcqoB/dRd56LfNxdzWz/P/JrVr7iz6fSj5wYOY1en/OCXzoRsVRyOf+c+4Rp4Is8pt7nbxbZ/ZAMi/SMTulbT+T3D8y5r8cKFXuxB5uQqkrQW0UDG4EvUrD22zBGgz0O4OT3ZYwDSdUTg3Zwb9N7fj/6F6+4EGrWZfFaxst3VRexmhj6SxuwcylynRX7EyR32xg4U1E+spHjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itNK4PQlb1NkY6FYdH0rUv6hKHVe0Iq3NHdlt8OCpBU=;
 b=GpCN/fW26nPGahFQPNEKL3bcUi4taX0iYh4jU1W0xLuwX67c2EMbx+7Wyqvc7eWSWZT91jTeiiUvHK2xgiwQ0rIdVQDNPPJ8ZHpwb4ZmztpY1mhRLsQUUVLNlKystiDtD0Iu4oL1cjXSaLdwi6+eQZWHEiD/mQ/UirU/270OIsqPlf6la1dTwB2Ai7bG4BBzk3shNhDDsDOLSw1C100Is0Hj21aYf7687nj9k+p2nguk2VHd1MX4jNUUu2vTQUUJ5WgfkHPrgXuTpNg74hGI7D7j5bN6H1HVjp0s/ZaXHDzxGoLKQDxmf90/kPTwH2AmNvbqdI9GZhf1XelNZfjVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 19:26:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:26:56 +0000
Message-ID: <095e7aac-4539-4f0e-b698-dd7b3f95f1dd@intel.com>
Date: Tue, 15 Oct 2024 12:26:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] gve: adopt page pool
To: Praveen Kaligineedi <pkaligineedi@google.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <jeroendb@google.com>,
	<shailend@google.com>, <hramamurthy@google.com>, <ziweixiao@google.com>,
	<shannon.nelson@amd.com>
References: <20241014202108.1051963-1-pkaligineedi@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241014202108.1051963-1-pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6e3fb2-b8ae-4d39-086e-08dced4f5526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTJwcjl2YWQwWWRTS09qMnd4ZjdESlhlVkFySUtxOGl0ZExLZ250cTNjdG03?=
 =?utf-8?B?VEN1Q2hrSmVrOHdNOFVTaUszSGI4aGZQK1U4Q1J1aFVYT2NoWG9ZTDRzNzNO?=
 =?utf-8?B?cjhrd1NQdDRpUmlUaTN1MDlKaHpYV0VHd3FGWVZCYURqUmFYUWNuUEdmdHhy?=
 =?utf-8?B?Zzg4WjI3eGIxWE4vNUV4WEU0SnhIRW1NY0lGR2ZRcUh0bitSZEgyNTFZZDZG?=
 =?utf-8?B?eXJtMllJN2RBTmg4NEZyRVp1cVBQczdGNkVqc1JyL0RJTUJtMWVkUTBlUWZJ?=
 =?utf-8?B?Y0tFRWlHYUplTk03ekZRcC94Q1NMcndxRFo1Y1FuWnRraUFTNVJGVFRXRmhT?=
 =?utf-8?B?S0JzSmpSTXdrdkxBZk91engwYUlHUDk3WUhNcmV3ZmFTUEZNSlptSzkzNjdT?=
 =?utf-8?B?RW4ySXl1ajJYY2ZpZlFhd1RkdFVUUGxtMG9JT3dGVm5tOEVmS05ubE5zTlZz?=
 =?utf-8?B?S2pVbStTYmRHa3k3VjlGY0thZExNdjNtY0F6TEJJbnFrTFZ2WjFaMXQwMmZ1?=
 =?utf-8?B?bnVxSmpYUFF6QXB6WUhvRS92dVUwTnlKUWZiZDF0WFNJSzdmRTI5SDdHckdP?=
 =?utf-8?B?RUJnSUg5WnFYRXNuSnZ0Y3NldjB2R09vSWhXREEyWmlkVmNwUldYRy82M3RS?=
 =?utf-8?B?SXVhWUR0bmczMXkvTWFsZHlUMjZJamRmcVVzOU9WWWh6bEx3dDVsbEY1ZEsy?=
 =?utf-8?B?amVSWUtWa2d6aWNMbVBSK0JPSGVrL1FaWEUzZ3lvRElYOXNXZzhyNUxlQVFn?=
 =?utf-8?B?VEtYdVR1WUFzMGFQcDRyZVRoU1RBb1hoVk4wNjlRTjhCRWFaeTRETGFOeGda?=
 =?utf-8?B?cFBBQWpKa3lrR3FmYy8zak13U3pkNUhUY2JleTF4R2FnSWhZOTBsNUt0azNQ?=
 =?utf-8?B?czRUTElMZS9CajN0SUNkTkNTdm9CcDhEMHk4MEU3WGJ6aWphNE1TclFNU0Y3?=
 =?utf-8?B?Y0RFNGZleVNyUlN1SzVWcW92UUp3aldiMklvYkFDZnNDN282UkF4TmtEZkow?=
 =?utf-8?B?Z3VCYy81Z3lpQm95emtaNnVQYkRlNWllV3VQSmpHK0FWcnAwMmNqaFVPK3cv?=
 =?utf-8?B?UGtpNHJZWDI3T0d2WmNnU09Ub1JSY3plMENCNlhmYlBWWFhJbFd0bnk0RVBO?=
 =?utf-8?B?R083dkhwYkUrVlp5Z2NxZmZ5R2lwMFF3QVEyZ3Rkbms4cEZQOUM2OWlPdlJm?=
 =?utf-8?B?TitaQUk5M0lZWGJhRXFNL2FlOE1hZy9jQkNkNG82V1NhWHlmbnpScTFzQ0U2?=
 =?utf-8?B?R3RMaENFcGZrTElLekt4UnJjTkVlRFZKSHJYaG1rcFNLb2x3TVdpbTZ2Q0I4?=
 =?utf-8?B?dHBGUkg5T2w5Qjduam9oNFdBbzRCVUQwaXlXU0djbDdCanlyNm92Syt3SFZ5?=
 =?utf-8?B?OHpYeDBoM0VPZWI1bkp2ZW9QRGhycHcvY0FXRjlFT0pqZ2ZWUEFpU0U3SzlW?=
 =?utf-8?B?WFc1NVNqLy9SMW54MHc2d056Y2E1am4wUSt0Mm9LeVpCVkhSdThnNWdMWGNu?=
 =?utf-8?B?OTJXUnArVm1nU3ZSaWhqaGVMeDRkRjJlTmZvd3ZyVDFvb1BZellnN1R2bEF4?=
 =?utf-8?B?c3dWUzRkQjI5dlFLeXY0NE44K0V1bVgxYUhGNjU0bFlqQjI2bmYxRUUySVE0?=
 =?utf-8?B?WWd3c2NmdlI0SkZKNkFiSVhPZHpmNDNpWlhlRVRVYUpxQXpwVDA5T0tsSkts?=
 =?utf-8?B?aDRJT3pCYVd4WW96UFcyR2xmN0Q1OGxqaWdTT2c1RDBFVVIvdHJiYTdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdBQkdyT3Z3SWNPdlRIK0hKUGR0dUM5Vk10WmVsb04xVWIrQ2t0cEFvRTlq?=
 =?utf-8?B?ei9RU0srdFhETEY2b1dtVlpJdFBtSjljZHEwT2F6TnN5dkdRTmh5SUNjMjUx?=
 =?utf-8?B?d05FbjJHTWhRbVJsZTlvWkRWOGMrb0Rua0dqOE5IWURBOTBINldkanZlTkpx?=
 =?utf-8?B?RzJzMFlvaEdyVnlNaWowcUNzd3V2d3FtOXJQMUVQdCtsdjUxam5mSnE3WTNC?=
 =?utf-8?B?SFVmS2M4K01iS2JNT2VxbEtGOGs1elFlMFlELytpZk9wc0srZlZMZkVFdDhG?=
 =?utf-8?B?ZVJzNkpEY0d4TEsrNG1VYnN4MkIzMXpoaFRQTzFWNUwzRm56cEEvRmlNLzRw?=
 =?utf-8?B?RGcxYWF3d3l2bXNsYjJPUzcycXpRTnVLMEtVQzdSNDlFdVA4WllUdjF4R3M1?=
 =?utf-8?B?RE9xamhtRFRnRUFnTnl4VGJ2WDk0b1FheEJzNEVRemVDYmRYdFk0Zk95Wmov?=
 =?utf-8?B?MEdMYnlGelIwMExmWmFEQlkraE9YVWNnRnlZa2JuUk14SWRvTDFLenl3T09W?=
 =?utf-8?B?VUJxYjBJTitDRUZCeDJGenAxcjFhbTF1d2t1Yndqbnl2SFVpWlZSTHBPTnhR?=
 =?utf-8?B?MmhST1hIMjBXWUQwRXZNT1k1T2FiSEJ2K1dBRkFJcGV1UURySFR3Y1VveEp5?=
 =?utf-8?B?dzhOdExmd2ZXaVpMYmVKSGZJdmY5UGsxTm8xZ0d5NmsvZUVqWWpTUnBzRDZs?=
 =?utf-8?B?SU1STUZiR0lGZmZvbU9qUHJDU0d0WXBETzBIYXVRVzAyTnk2T0NidWNOTFRy?=
 =?utf-8?B?OElSNitETFZFZndoMWdKME56UjJGYmVMaXpXSytWRkc0VVFBYVVuZlIzcUJN?=
 =?utf-8?B?WXhTbWEranhZclFHci9FQm44elluN1ZudSsrYys1bUJUdnQvRDd0MkhNN1Fs?=
 =?utf-8?B?RmlJSDBFTXo3dm1aL3kzbjZvaUc0eEVnS0tvemFoYmVYZFpBTGx0K3pYb1gx?=
 =?utf-8?B?NHlaRTl3SjZTN2ljRHYvcVZkeXJFa2RoRWhSYmpKS1BES1pIK3AzV2JJbjdj?=
 =?utf-8?B?SjVubDBRNE11Q1RIanFwRjJaYXk1a3ZOTWE2RXpkejJMRDNFcnErU1ZVRk5a?=
 =?utf-8?B?YmpZRm5NNFBoYXNDclJsSU96d2pocEdYeGRPUEZkdWxGeGM1NnVMWEFVb0tj?=
 =?utf-8?B?LzZoMnBJTWJRUmhoMFRvT2c2L2djWTAwV1piNEJ3SWxhZjJKOTJocnFkZFpv?=
 =?utf-8?B?UzdEOGhJUWF4UDVtMHpmaUV0QmMrNVpVUnBTVVM5bmZoSTQxTjYvNVlOWW9X?=
 =?utf-8?B?czVKc2ZaQ0NveXU0MjNpOTZrSmdOYmNISUN0SXJ5Y1AzVUNKd21SMzJVTHo4?=
 =?utf-8?B?bTM0dU1hRXh6UUlsQ0hqUkFjbzV1dEZFUGlIb1FFdTk2bVFhdjdWRnljMDRm?=
 =?utf-8?B?Mk5PelJCS0s3eHNsVFVRTFFCR0xYSmN4c0NZVHNwMjRlNVhjM0FJR1lTTXA1?=
 =?utf-8?B?TEppaWtjclQyb3ZKWXNSQldkUlpqYTI1eFQ4QjVMNHFiWDEyTlNqSXZJMzlC?=
 =?utf-8?B?dStwT3Jkb3ExVmkrMVRRTDFiV1hTak9MdDhSVVNjdzFCOXdnZ1Fhdi92LzBx?=
 =?utf-8?B?ZExnUzc4VFkrQUJVcnJnamhXV3VycVhjQWljTWJKYVVyZVVJaXhhTXZ6VnVC?=
 =?utf-8?B?TGorRlhtc0E4Y3AzUE00dkZ2amppSDdpMFZPRjRFRW85OW1GNmg3K0NIZEZ0?=
 =?utf-8?B?R2JvUGZPNm1Eb3c0VHBVU251MmlFVVQraW14bzlqeTRjMDRvbmg4WjlQV3E3?=
 =?utf-8?B?UDFabFI1QXUyVVZrdHlEQzRGU0xEWEVsbmdnMDNwbVJNdXc4ZlVQa04zcStw?=
 =?utf-8?B?SGt4ZExWUlZIeWZLOWdiN0ZTdU5JTmxhVS9RMERSRFFQMlBIZzMxNXFNOTNS?=
 =?utf-8?B?OHpaS2dVWDNncGJEa1haemNQZWUwWStHWGltV1p0ZXJoNTVUQTUyOHQvNTQx?=
 =?utf-8?B?NW05VTM4d3ZEOU11dGxNTDNtRTVQYy9oS0Q0azJSc1Q0cC9vRTExbXEyZEt5?=
 =?utf-8?B?cmgycEFueG9TSzRUT0hvQUtvN3FiZ1lNa0ZPaHNMdzM2VHVYNE9oU2MvOE82?=
 =?utf-8?B?QXdCdG5jcng2bitvYVVXeU1pTGFNejdvVU1EL2F5Mnd6UW9FRWh6MFVEUm85?=
 =?utf-8?B?WEF5K1QyZnN6UlBBdFJnWmxIK0lyNEFjODV3S1dLT1RIa1d3V1pxZ0NqeVB1?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e3fb2-b8ae-4d39-086e-08dced4f5526
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:26:56.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U4vleSQ4Uf7Y/F4PaClmGvKujdNepslYqhUuRznu4OHxh/l10c5EHENtjHaGJVrOemgUGVSFwR5psI54poF/tzF5iNukflXwpM5roHzN4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com



On 10/14/2024 1:21 PM, Praveen Kaligineedi wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> This patchset implements page pool support for gve.
> The first patch deals with movement of code to make
> page pool adoption easier in the next patch. The
> second patch adopts the page pool API. The third patch
> adds basic per queue stats which includes page pool
> allocation failures as well.
> 
> Changes in v3:
> -Add patch 3 for per queue stats to track page pool alloc
> failures (Jakub Kicinski)
> -Remove ethtool stat for page pool alloc failures in patch 2
> (Jakub Kicinski)
> 
> Changes in v2:
> -Set allow_direct parameter to true in napi context and false
> in others (Shannon Nelson)
> -Set the napi pointer in page pool params (Jakub Kicinski)
> -Track page pool alloc failures per ring (Jakub Kicinski)
> -Don't exceed 80 char limit (Jakub Kicinski)
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

