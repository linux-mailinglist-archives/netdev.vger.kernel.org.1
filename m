Return-Path: <netdev+bounces-207233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC2B064FB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F52F567586
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345C27A93A;
	Tue, 15 Jul 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHtlusho"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C311E5B7B;
	Tue, 15 Jul 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599597; cv=fail; b=GfLjNX1CZ+m5P36YcsR9XlLH7FACEHsKXJBR80HrODKS/DJJo073afFwyO+slvdiqp/p7YBCoQsA1A2tdyhwGAeZwZnfceNhohOmYL3YmBCk/liT1yQUpyfDccLpWalSQWjtj5ImFJvOzkWG4Gfny+DVB0E9MBnwQ4Wr9g9NWrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599597; c=relaxed/simple;
	bh=igWWx71U3PQ4s3XX/FSMA/XGOKzM8PnAMaqkyM4A0Rg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZqWzM/qYT3puViys9xdBTsq1RgBV78p0sFdwGG9vtrhGFtfvXMIrRSuPefAQXPMvgMeLpxHXQnZ+V2jo64sOWt82qdLcwIJybKwNnJ6kKar0nHs31jU73vG8ZwHlAE35bwQMLLdg+igNE8S9BA1OqDuQqPRx7z8VjYDRi11+U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHtlusho; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752599595; x=1784135595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=igWWx71U3PQ4s3XX/FSMA/XGOKzM8PnAMaqkyM4A0Rg=;
  b=KHtlushorRg7OlqMuto7OH9XKakzLWn1tYERYKuIdnCAT036NDwck1c/
   TvkT4O1tuldI4StNcRfgarWkNz0ko17zHyd5DiBx5yjI4xI9NemggquNY
   UTwrbPq3ViQch35n9dlHEKsdGdSMF4tfnFG533f1K4RADGpN3L3VfgEUb
   WBDSqSpbF+ONozARSAb+jzCQelSDQqyBjsCY4lSiVtnINkRYU4RDCklPY
   tCZdeQxgGGjF8VRWBdD9rWKPF06S1+UnE3ygdnNsYwh/+3L836NM2nHGl
   ITi4CAxnVad6DUCMYK8QZuu3YJ5nJE7ZxcdFAA0E/DJq3IMjKWWvQdk//
   Q==;
X-CSE-ConnectionGUID: b/Y1z8vKSkapw2dZc0n6PQ==
X-CSE-MsgGUID: uo6Bd4jkSE6qchz/F6IKYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65527923"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="asc'?scan'208";a="65527923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:13:14 -0700
X-CSE-ConnectionGUID: rwHjEtwRRFy4BZXm/XydjQ==
X-CSE-MsgGUID: IwtmsvQySJqyiXFMQGmSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="asc'?scan'208";a="157826068"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:13:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:13:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 10:13:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJoQnNwzXbDSJNttIdHb6psXJZIWkfE99+JDNTguzodY/4/l9rU44kES6L+hz/Z6a4PwbD40KFFDSwaJshiq8jmw4Xk62DXsqof1AFvJ7rUuLXvYyf2GASj7gfzzBTi2C70HoCZiUh9jHKaQki8N3NAd6nQqC7Sj0wRHhuv85I1quZHd3jgUVrLhsb1DygmknG5OfEiqvanQeVWExMlmY5YjF8SxVCcYVpCrLS/o02/1FM3plN/SLkUeEugURXAyY7joJ/MsfrNftGP8Ne9yzXlT36Zyk1Vg1JZVMrefmU9gLrH+P2WSIdUH8GlxvZbJOUQd+Zhf5m7EuCWGhIpfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9vyzswx6k0aR6I6+paXzJMsg/dx8WzDQrtkbQzMPMU=;
 b=XfQUlQhyuLVwlIYqefku3bUQyareO2aemjf0rRaz2bNYmQGaHCL4AUb7MHREIijl+F56i7T4iapgcOLv7e66nVLrV4hiZwZCxUvy5AWoJ5Vez6160VYS3GWrXtcqxvsTRheufSJB3tCgomTISIt3fp1lKpCh6wnEcGz1otM0SAn2hzYTN+PlvP3ZVzZS55fM65JYMIMwoAd436tdi2W+kbdYCU96JFhxccmwvidnpjxbkvw/18n+Y9wGtJ/wEjBFzeVkKPrMOmPo7xaXFqjdVthymp/XSGsWUGOI3hYmGbWD4zmjCDC6dkaX011izzBYktwISCH9GajbRu7ddGq27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 17:12:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 17:12:45 +0000
Message-ID: <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>
Date: Tue, 15 Jul 2025 10:12:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
To: Simon Horman <horms@kernel.org>, Wang Haoran <haoranwangsec@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250714181032.GS721198@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------C48alhRnwohvqxhlSmI1pbTI"
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: edead46f-5875-4a42-c4f0-08ddc3c2d0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmliWmJETHFBWTdzVVdoM0Q1YW9XNzZNOW0xd2xmaUlNK0ovcDZYaHlhOVl6?=
 =?utf-8?B?VHhMY09VRVRHZFFxMXNPcVc2TWkrWUVhakl4R1JoTy9tWUwwNlZSUkFMcHhx?=
 =?utf-8?B?YytuRGdZR200d2t5SFJpajgyNDdzOTFjM3BCMnNpNkZ0S2JpakRTMFRXb1pt?=
 =?utf-8?B?UHFiMFdpZ3lWaUFBSWpYUkdzanJ2czRFMWh6ZlpYK2swTW84clhVSzNWY2dx?=
 =?utf-8?B?Q1Zoc2ZKYVJJRHB6N0lIaXBLUG55Y25qYTMyeUxqa2VUTUZwMUFFckp6Tk5G?=
 =?utf-8?B?d2VoU2F6eG92aWY1UnpKaDY2VjNNUXFaejhyU3doZlhid3RCU2FFbUluRlFs?=
 =?utf-8?B?OHJHOFU2a013RUtMMEtxRnVKNno5ek5FQkRXRUl5eUlrNHRsTWx0cXcvd1Nx?=
 =?utf-8?B?UHdSeG9JRUplaFM4T1RMTFpiejJDcmQyNG5uaVZKMCtsTUpaOEw2bmdVY1JE?=
 =?utf-8?B?bWk0RXJ1NDdkUHdEU2gvMkNUWlNaTkQyc0ZHUmF3ckNpSWppd0N1SHlpcEFY?=
 =?utf-8?B?R3hLdmRVanJocnkxU082MHJBaitReHBJSTVCVmZaQ2ExNENZV3E0S3J6ZUx2?=
 =?utf-8?B?WTlLWTVHaFV0UHFlYzZMSVlLdWtva0VqT2lzU1E2MUJ0UjU5Zk1xdXFQU24v?=
 =?utf-8?B?NURGZkpUUE1Uem5nK2xubXJlM0dxbTdtdHA4L2pYcnZtMzVIZFBaTW8ra0lp?=
 =?utf-8?B?NnY4bjk4RjE5TmtvU3BNcis4YWNYQWErRG5Xa3RseHhJM0JUT0NZbFNtYkx3?=
 =?utf-8?B?bUNWcXdNMGV3QzNyWTB3OEt0d0RlNU9EMk1NazZ6UEVkRlVSN2tMU1U4M0U5?=
 =?utf-8?B?cEtxcksrYmRxdUxYWURCZHA3SkJ4azZHQWUyMlVISzlRWkVNMG8xSVVPWkli?=
 =?utf-8?B?T3o2bStCRzNFMGVMa2tLN3dDUERBQktSVUxGcXErNVlXKzk0ZVBlbWZQakp1?=
 =?utf-8?B?cG9LTTVYVSt0eGdHQTR0TFlnRWFuMXFKTEhUUXY3QVR0MXVpZmF5QWt0alNh?=
 =?utf-8?B?Nk9kbm1UNFRVSllhaVM0emNJa2drbEtyQmhlVEh5aWZXVnpLQWlSMzlYdjNQ?=
 =?utf-8?B?amNxSFRwQXB4bEpJT0pJcjMzNi95Z0s3WHVaWllBU3Npbzd5aVhoZThHNCtV?=
 =?utf-8?B?OXB5cDY1TW9CY2UyVWl1VXBHTHp5Yys3T2wzM2VsMnJ1K2pPajN4ZW00bFJ4?=
 =?utf-8?B?NW9uSFRWZFFqcmMwcjN4enFjTWNCaFFoVnJZSU9WUUVHZGlmVStTUFBka1BO?=
 =?utf-8?B?UHZZZlI0MWZVR1RES2ZTZ1l3dGFnS3RabEFKdFJUemRnK1NOSVQrM1BXblR2?=
 =?utf-8?B?MXpkZEV3blNyL3o2OGQ1RFNxMzR1RkcwQmNRRGR1RjhuY1JkdkpzMXRaalds?=
 =?utf-8?B?YTFZV0VkZTh3OUJkbldORHoza2hDeXBaMTF1bGwxRnlndnN6ZnZUZ0xQSzla?=
 =?utf-8?B?WWxqbjU2UHpUZVNQN1RiZzVRRktYUXJPdEs1VmpUOE9oWDF5cmFScUhLLzRk?=
 =?utf-8?B?cWdEZGVrQ0wyd2YxbW1ISCtTNmRUSFIwbmV5emhyeURTa3krNnc0NkVocldo?=
 =?utf-8?B?VW83RXcxNlBkTGNGWnVEbDB6VGlNNmxzdEphcEptemxGK2llUnZKanJxZDdZ?=
 =?utf-8?B?YUpPNzVFOXpjbkhyUTVkMnZFaUk3eUZsWnEzVmhGRnlSQjY2ZlQ1dmFpUTgv?=
 =?utf-8?B?aGZzai9PVkVuSmJVTHhEbTlHM2kyQ2dDZGZ1Mmt5MjdGWTMvZ3FuS05sL0t2?=
 =?utf-8?B?cGs5OUc0SXVpTzZndHR6Wk9hUlpXNHpJeTFMYWE3NEViVW9rejZvSzJzS242?=
 =?utf-8?B?L0hqWENBQXY0TVJ4V09Zc1pQYmE0TU5LY01XQ2xyVGFDR1prSDFsTEpYa2E1?=
 =?utf-8?B?SjIrbHR0NU8vOGpjRXBWaHI3TjA1WFVlaU1xRTBVRSt5M2p1MVNCcjNvY2ta?=
 =?utf-8?Q?mRGsiV/GhKM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BabU5LR0dWVU5QcU5xQk8vN3QvZ09iaFVTVlp4dVYyQlgxYjY4bDcwbUNQ?=
 =?utf-8?B?amJsN2N5WGhXbnU4N2JYQWp4cTBEcTM0amxiakpkNEpLZ3hsREtMMjY5WDhY?=
 =?utf-8?B?SEd6WWdWS0ttL1N3Q1ZORXFGUk9OZlVyNlAxOVJYWng0UG02YkR5OXFTL01K?=
 =?utf-8?B?NTdGWWZCNU1CMmpheHkzVEJObnV6ZjhwOUZQVForNWQyVVg1UVBxSlJpU3ht?=
 =?utf-8?B?OGx1NU40UVZkdk5GWHVpZXhmbjlldXVEVTFSNWhKWklqRWlMb1lieXF2Nldz?=
 =?utf-8?B?L0F0M0tYREdOQVk1cktXOHB0cVZKaWk2M3ExaEl1WmREMnhENys4eVdMLzQ1?=
 =?utf-8?B?ejhaZ0JqcFl5eVgrVk4wenJneHhGZXU3TjFORDhpR21lZzNQYlBjMEVadDJZ?=
 =?utf-8?B?c3o0NDlWTStzVmQvMzdON3ZnNit3VDg1S3MrOFBySk8vbTBuMW01a0pBQ2x2?=
 =?utf-8?B?Vk5FdDJ2N1dqNmNzVENjVm02NkxZMmJsZ2xtU2dON3JybGJ0UGFYdFVvL21x?=
 =?utf-8?B?NHdSWjZ0cGpxbTZoaGR4cFRueGdWbk0zaDhyeDA5d3BOeU5xbVFGdkplamlv?=
 =?utf-8?B?U0w3TURYWnROTS8rQmZlYnd6R2kxMGFOUDVqVTUzdHVvTjN4ZzJGRDFqc21C?=
 =?utf-8?B?ODRwbEZnS1p5a3VYQnRoZXpFRlgrUWtMdmgxVVA2b3dFRkgzR2tTVmllWUlP?=
 =?utf-8?B?bG43SUhDYlA4QWZMSGI4ZmZ1V21UUGJBYWpOejltSHE4OUdBV21uTGsraUdp?=
 =?utf-8?B?YzE1NG95UXY1cENNYjhHbHU1dXFWSU1lakVMWHJpL0JGYStTY3VNc29Wam5T?=
 =?utf-8?B?aWdTRWM1WklTL2tMUEhyaU03WWY4S0FxVlhsWTdjM2JQQi85NUFJMVVJUDNY?=
 =?utf-8?B?bkV0S2pRWGRMUGttUHJOdlc5dURxTmQ2Z3VFazR3M1ZkeFordlFhOUV1V2w0?=
 =?utf-8?B?N0FBM05PRTMwVWpBWTJQTTlIdWF6cHpIQUdnYmtRL1g5MG5XNEc1Z3JaR2Na?=
 =?utf-8?B?dEtyTk4zc0FRczNqdXV1M0pZTjlkT3ZNZUJha1VJU0ZOc1FQczNkN2d0Z0h0?=
 =?utf-8?B?c2RhYmFOYmw2enFXY0VxTTJHU2ZGS3NTR29rZ0Z1bm5ZaXB6c0wvdlM0a2xs?=
 =?utf-8?B?cUlwK3IxUVBBaVFJNXkwMXU1dmVmaVFobElPS0RqcnRtNU05b1lFNXBKMDBC?=
 =?utf-8?B?THptL1ZvMDZFWFg1MlJRdGtvYmo3aEVXRFR0dDVPNkk5dGF4VDRJMzZDYlpH?=
 =?utf-8?B?cjkwK3RNZ3Zkck4xVituL3hpQ1hFTnNiSnN4eTJGMGxBcnY0RnRNRWppZ0VU?=
 =?utf-8?B?M2RQUUVLZHI3MXh2UnNJM1YzaStNeHFBZnc2V1laOENNL2swUXp2YnhNaGcy?=
 =?utf-8?B?TXNUZnM5MFhFbURkdTc0eXRRQW1KQWVFUEwveS9qK0Mrd1Qwd3E3VUNuTTkr?=
 =?utf-8?B?SXlhZnhuN2lKRjRzUmVJcGFrWVN3Si92VDZQVmIxTG8vSVZYOU9QbW9pMUVz?=
 =?utf-8?B?Nm1Xam9zZ3RhQTE0V2dHNFU4YkRGTVBzVjlCMmtFQTBmSUU3ZnRKNU1IY0Mx?=
 =?utf-8?B?VlNJbVZIbGJRZU0rUXJreEI5UUJBN1dMWDlNRUpHZDlzb1hBOXV0TnowL1Vw?=
 =?utf-8?B?Vkh0VjFSMDBCMVBDMk40Y210SWpJeWpWeFQzajRtdVdCZWNRaVVweHJKazcy?=
 =?utf-8?B?dVNoNWFRQ0ZVQnJBRDNvVGwzS2JTZ2xVZ2liNEI3eVJiTVFzd0k4NlNIZ2RP?=
 =?utf-8?B?UVBmbVlTYUZZVUVIQ3JiUGFKYUI5OFB5UFdkL1Q0UE53aUZ2ZGZBZVVOZlF4?=
 =?utf-8?B?MkpqTDVtM2psdEtjQVA4NWcwZ3ROdS8vSW1KUlRtU1kzMnVHUExtdENlWkQ2?=
 =?utf-8?B?YnVBb1d0MkNNRTBIWHlUL2xKaEo0ZCtKZFZoNjIyUTlLbithdXpQQm9ocG5r?=
 =?utf-8?B?UFovbXNTTm9JMElOUDRJVzgzNk9KL2k4ZjNIWHlURHlZYUFDN0tJRjNhMVZl?=
 =?utf-8?B?RDAyeStBQis2QVBVVXY0MFdFMGdEWjFVRWd2SjF5QmRQY3NpbU9wVzZzZ2M5?=
 =?utf-8?B?dnBHaFpiVXN5VWdncEpsTi9VN2Q4MndaZXIwbzdRT3UzS3gvY1V3akJlT3Fs?=
 =?utf-8?B?eTFNTzZaYlJHWlBVVkcrcyt3NUZNMHJvK1ZpWUVqWnJ5L29URkFRcjkrbjY3?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edead46f-5875-4a42-c4f0-08ddc3c2d0e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:12:45.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q7sSfmsk2Fd51Y2dS/D0DVFmLNcYIf4fbQlzMT+UCKkLvHE1sB7rRZKZjdADb1jpU5bauNcZRYUlgL/cop8aKh0pjzpUw07X7OgHlm7T5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com

--------------C48alhRnwohvqxhlSmI1pbTI
Content-Type: multipart/mixed; boundary="------------f4ampK609q7hnmn0gAiwsrdd";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, Wang Haoran <haoranwangsec@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
In-Reply-To: <20250714181032.GS721198@horms.kernel.org>

--------------f4ampK609q7hnmn0gAiwsrdd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/14/2025 11:10 AM, Simon Horman wrote:
> On Thu, Jul 10, 2025 at 10:14:18AM +0800, Wang Haoran wrote:
>> Hi, my name is Wang Haoran. We found a bug in the
>> i40e_dbg_command_read function located in
>> drivers/net/ethernet/intel/i40e/i40e_debugfs.c in the latest Linux
>> kernel (version 6.15.5).
>> The buffer "i40e_dbg_command_buf" has a size of 256. When formatted
>> together with the network device name (name), a newline character, and=

>> a null terminator, the total formatted string length may exceed the
>> buffer size of 256 bytes.
>> Since "snprintf" returns the total number of bytes that would have
>> been written (the length of  "%s: %s\n" ), this value may exceed the
>> buffer length passed to copy_to_user(), this will ultimatly cause
>> function "copy_to_user" report a buffer overflow error.
>> Replacing snprintf with scnprintf ensures the return value never
>> exceeds the specified buffer size, preventing such issues.
>=20
> Thanks Wang Haoran.
>=20
> I agree that using scnprintf() is a better choice here than snprintf().=

>=20
> But it is not clear to me that this is a bug.
>=20
> I see that i40e_dbg_command_buf is initialised to be the
> empty string. And I don't see it's contents being updated.
>=20
> While ->name should be no longer than IFNAMSIZ - 1 (=3D15) bytes long,
> excluding the trailing '\0'.
>=20
> If so, the string formatted by the line below should always
> comfortably fit within buf_size (256 bytes).
>=20

the string used to be "hello world" back in the day, but that got
removed. I think it was supposed to be some sort of canary to indicate
the driver interface was working. I really don't understand the logic of
these buffers as they're *never* used. (I even checked some of our
out-of-tree releases to see if there was a use there for some reason..
nope.)

We can probably just drop the i40e_dbg_command_buf (and similarly the
i40e_netdev_command_buf) and save ~512K wasted space from the driver
binary. I suppose we could use scnprintf here as well in the off chance
that netdev->name is >256B somehow.

Or possibly we just drop the ability to read from these command files,
since their entire purpose is to enable the debug interface and reading
does nothing except return "<netdev name>: " right now. It doesn't ever
return data, and there are other ways to get the netdev name than
reading from this command file...

>>
>> --- i40e_debugfs.c 2025-07-06 17:04:26.000000000 +0800
>> +++ i40e_debugfs.c 2025-07-09 15:51:47.259130500 +0800
>> @@ -70,7 +70,7 @@
>>   return -ENOSPC;
>>
>>   main_vsi =3D i40e_pf_get_main_vsi(pf);
>> - len =3D snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
>> + len =3D scnprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,=

>>         i40e_dbg_command_buf);
>>
>>   bytes_not_copied =3D copy_to_user(buffer, buf, len);
>>
>> Best regards,
>> Wang Haoran
>>
>=20


--------------f4ampK609q7hnmn0gAiwsrdd--

--------------C48alhRnwohvqxhlSmI1pbTI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaHaMCwUDAAAAAAAKCRBqll0+bw8o6M0/
AP4sbouAC+PNRmXNbTouq9OFgknUTN/deZXFgfPTR9dA/wEAlzfisGBafuJviBISaf1V4mGVhws7
rqOdy1K9n9v1Fwc=
=O2L5
-----END PGP SIGNATURE-----

--------------C48alhRnwohvqxhlSmI1pbTI--

