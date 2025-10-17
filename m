Return-Path: <netdev+bounces-230308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C0BE68BA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31C92356749
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103CA30F7F5;
	Fri, 17 Oct 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThTMvDBD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B930C37D;
	Fri, 17 Oct 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681436; cv=fail; b=Bm0igVMAkK7/8gaWTwIZ6OBlSXndqPL6osZG3Dl/zOURNbA/kQGlQqcKjpCEnVr0T4uATFnFMrXkAIBvDIFlbDO634ChByyoNZpuCpFDxti3Y9kPy+jwl/6bxdrJPt4hveBG09RGLns5FKlwRuifxxl2LoZk9ou+RUS/YFvht5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681436; c=relaxed/simple;
	bh=44QVY6IXDttPPuRKoOqeUHiYJIrvwfo39rEPqBGeRak=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LD9GmTFhK5ceDjTQqVqe45okOEjFTX6lJ8IOFLXS/W3GN4550EQe0icOXiKGSxFrhQfBqJSYA3bTzMje8tbyZ9O/IfWtAOtKjPviwUd2vMqKmffTHdtCj+WvQoyAZ0+k+BNZxO2eZUBdKHDUfMhvQXDXMj+vztVfUXL4iM4qyqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThTMvDBD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681435; x=1792217435;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:mime-version;
  bh=44QVY6IXDttPPuRKoOqeUHiYJIrvwfo39rEPqBGeRak=;
  b=ThTMvDBDnnqtLNsloxwNdmEF6b2iL3wLnCXwMyR6TZa+pwf1XrWAda6u
   2mO0QU9SRFXBxcNQ2hZREDna6unKI/TVccBlii1g5HtdT3zcBM5+LlB1e
   phr2ltuLVJu12Ii+UskAmcJMZTf9fkrO7QdBv0u722ZIcd545yE4SDNTM
   IH9n36+Mr9PI/2Me0X2Het8WVreiTgi+OUlnOVm9/JH06R+sGzi484U8E
   a4niGkjhPJvs9Q/tcvDI7wLd2R7Hl+ad0qCyybFKeQqRBQGadmNKRTkcZ
   A3W/vUrQVM5Ew4GyLkycVkiyreW89sT3QFskCtwEPjEhirRiS/FDgUYdp
   g==;
X-CSE-ConnectionGUID: 6V24u3+ASzqzd+biLaqvDw==
X-CSE-MsgGUID: kWIMB7oKQBOvLCYMznB22w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80516590"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="80516590"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:34 -0700
X-CSE-ConnectionGUID: fJRQGnpITHqiPjKRr/VA+w==
X-CSE-MsgGUID: hboWjEcWSgqooH8ltdEyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="213236890"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 23:10:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 23:10:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 23:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TddqXHWmrTS04t/D5Rh+GNfWWrHmVY5PS9B1gygl9JPtKFTt+EPMUqQFCKGUgOJtJiEg6ukC7avACsWTyvH5w1J9kRNUQ7ZvW5cJTRRo7CVgV2G8H7uaO5fuIt/p9zlMJL60aSHedMQcd9HSsuL5QFQUUZDLksQMpuXo38yQrT3o2gsqXP+x7/oMx6ZOBAFCnkUoa/U+Jvms8bC00Xe4MP/FWkGaDGRFrmeRWEoFSwwwFq98JbVt+S+zuGG2lfRYPP+YjIswO/7SHrAOb3CC0Ri0BcEXrN9CmxHapzE+jQnfcqsALe4s3dUsYrJhrpvhsfcKmtcaHbNXDMgJUbE8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44QVY6IXDttPPuRKoOqeUHiYJIrvwfo39rEPqBGeRak=;
 b=gzc3Z0TO+ai0zFUGOxSpklzsdYVz3NVyRK+ciPZUeWXSX6tqboQJshAtyEliio7Qwaxq5Kk6WhOvoZxsRIY89rBCO93IubS3Jc8oChljeMVD6QwBS6ZbKj1+Lujiz9a2RkqO4btu+fkZ7A/AFVi+CXF5qC+mqQ71zrryoxhUNfQTMwWUVZqTaQ8rkBx02nUBHJVh6DBzmSFyQfnhnzH1UCIHNjONHaLSHjOI+4+u/WzIEcjqK2YHDtWhO4RLEBBmemInkASQPj/KUpEkslFRCRLNS9fsIMzag3xeJHXwSEodrid8TdvApe7jaAMEWjOYw5Y+H72zLWR5iNccYRm69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 06:10:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 06:10:30 +0000
Message-ID: <7a03dd30-8e08-4bd7-a7e9-f63aa9b5d6bb@intel.com>
Date: Thu, 16 Oct 2025 23:10:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Nowlin
	<dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Jie Wang
	<jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
 <aPFBazc43ZYNvrz7@horms.kernel.org>
 <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
 <20251016165648.2f53e1fc@kernel.org>
 <4ae9d5d8-2d88-43d0-95be-ae75f0506548@intel.com>
Content-Language: en-US
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <4ae9d5d8-2d88-43d0-95be-ae75f0506548@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------8BbOd9SEg00yzVocbCRn7zBA"
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1473c4ba-009d-40d8-45b4-08de0d43dfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk9lRDMyTmpzMnZMUklPKzZsT1laM1U3YXNuV3RBdlhXZCt5RFFOLzEvejFz?=
 =?utf-8?B?WG1FSmFWZWFhbklzc1N0TzJiU0lib3d2K3lHaWE1ZEZBTGo2QUhteENick9h?=
 =?utf-8?B?WjN5a3BKSEtDUXpUcCtYNXgwV0tjdTJRM0hYVUZjT2lXTUU5L2lHNHF6Y0lT?=
 =?utf-8?B?a2ZDV1IrajZITVNJTFFJbHdpVW9xVTFIbXFudjI5MDZjYUl1V1RyckpwalRQ?=
 =?utf-8?B?a054amc2Z0FzYjNZSkhNSlhNMlB1N0poQ1lWKzNuRWppUlM0R0d3UlpOWnBZ?=
 =?utf-8?B?ejNrVEsxN3NIdFN4MThvZ2dNNGlPM2UzcDNScDZaYTdEYVVZZlNxcXl5Slkv?=
 =?utf-8?B?SXBqYWNNSjVFT2ltdU1tQWVsMVM4ZndzcllQbnowazI5MDhtdjhVMTZuZ080?=
 =?utf-8?B?ZzJQb2FNbFhpSUVVd1k2S1Q1SGJYUG1Uc1ZQZGJYK0lHQ2JYNkJBcWVua2RY?=
 =?utf-8?B?WUhhdXBueWpmandzZkNxRGJrTXZoUHhJS0tWZEllZXBtNkRGWW5BUkZ6WXlR?=
 =?utf-8?B?Zm9SZEVDVkhDeldveTUvcjlaaFE1K2k4TFI5QkJSUnBydEFKN3Fyd2FoSG44?=
 =?utf-8?B?ZGQxQWVSZWx0WkFLcGdaWlN4YW14U2pkd09lY29ZSm1kTVhHRytNa1Q5UXll?=
 =?utf-8?B?KzJaNzRKTmxIcUxRQm5KRFdFMnNaQ3hCbnRHWkd1YUxyYTlkWkVOMDFOUTIv?=
 =?utf-8?B?TGdpYzdIMUN4ODkwZmJ2Q1lZOUhQZXpseU56T1ZaYmZ3aHZhd0U0NHpnanN1?=
 =?utf-8?B?dXdxeVQxeFhKYU9MKzdUOVBaTENmaExLTlFiR3Mya0N5QmFMTkpWVUt4Ym55?=
 =?utf-8?B?QWdERGE1VE04aktGYk5nL0ltdjdKMnZWM3hLQ2QyNEFReGlVTWRJeGcxL2E4?=
 =?utf-8?B?Q1MxbFgxQ0w2QjJQZXB5TjE4QWVwQmVNcUw0VVBPK3NNZ1A1eFQvdzMrUlZx?=
 =?utf-8?B?V0VKUkNCdGw0TGZNZ21LL01qZU43b0QzNnNWK1M4alFvalVHenBDSk5ERUxV?=
 =?utf-8?B?TEFqWldGVGMvVHY0aXNXVmJ6ZmFZWllyTFZhdmhvRzNqalRPS1VGOXRrVTVD?=
 =?utf-8?B?ckJlVXdxdmJxb3FrVUVZWGlKbFpSNUFTejdSWFE0a3hDQmFQODBQZGlFZ0x0?=
 =?utf-8?B?elJGZUFyOEh2bitZK3N4aWprbkpGSURqOVM5Tk1INGtUZFY1SHRMRTllRDU1?=
 =?utf-8?B?U09JY29CQjBqZk00ZTdMMTBIbmtSdXZneUNwSnhERU5oTkp5SUl5NVFpTlBv?=
 =?utf-8?B?TGNNQmNnVEt5clNtdThWUjhRTTJiT2U0Q3YrYjVmN2xQYnJ6QTFXVFkxRFkv?=
 =?utf-8?B?ajVRU3U3MzRHVllVeVAvUS8zSFdncHFEeVNZbU4vTFNsVi91OS9ldHY0WnpC?=
 =?utf-8?B?QWxGdm9RQkJrT1AxR1J2TzlybUY4UnpYR0FBWDVoSGptMEIzMWpjSzlqNFg3?=
 =?utf-8?B?ZVI3WGs4V2lJeTgrNlBmczJhanNmNS9lTGE5L0I2VkFiN2l2dzJIVDBYRS9J?=
 =?utf-8?B?UGhKZ2t0M3h2eXZMUENnSTEzL3k4NU55YlZjMWUzY0ZuSGs2M0wxeW9SU3ps?=
 =?utf-8?B?ZDd1UjNXSmVYV2p6UXkxRysrM1VtN08zNkMycjhQSTFRSGd4Wmk2V2FCRGdF?=
 =?utf-8?B?RHZMWlVaZE9lSzY0b2NnNUVHMnVUWGlXL0hMZ1FySkd3anh3VCtCMzZ5OHh6?=
 =?utf-8?B?eHVHZThheGp5Qjh0R1B5N09nOEtEVnAvc3I0UndicE4zNFdxVzJDSTVRU1hq?=
 =?utf-8?B?RGlhVTNUOWZKR1IxTU9TWkdHUldpRWVrRjAyK1J1M1dOQkM1eE1lS1U0cmdW?=
 =?utf-8?B?Uk1TUTBlZnJtUUp5UzhNMXRrZWJmcElHbjVvczBoMG1VUVY3NTIvM3lmYWdZ?=
 =?utf-8?B?RVVtektNbUNCbi8zbDN0ZTdHTW9RYXo1UThlM1FKWmp2V3gwSWNiTWplRW5P?=
 =?utf-8?Q?ds4BlM4uxtkvDthvH8eaBjen3Cd+JTb6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5YeTNyQm84dGF5dnZJdFJUTW9LUjZXNTdzU1J3dGgySXY3V0pXTEZEaUk0?=
 =?utf-8?B?V3NjZUVhNkoxUmZVeW91VlB3c3JUVGFSeVdKS3dxWUVwSGpzWmtGSnRpQmEr?=
 =?utf-8?B?RWxPYTVMZzY4Y05LM2NCenR5K3VvdDNMUWJVaFBUejVWWi9UNktsZmM0NldR?=
 =?utf-8?B?R08yZFdoOWVBZjZjVmNGdFFyZkdqMEY4Umd1cnB2SnFkTnBNemlSaEFCRVgr?=
 =?utf-8?B?VG1WVDgxY0x4YzB0c2lQSUpmR1l3VUQ3dzNnS05naGJ3cDI1c251aVE0L0tU?=
 =?utf-8?B?TmR2bmJMZ0FqZ0NISzlHVTFVbkM5cHJPMzZKZWl6eEFJUit4S29BcXRudmtK?=
 =?utf-8?B?NGw2elRSOWk0NWlOcE5UdSt5U1E3citCNDZDVmFhWWQ5WGZCVlRscGFPcnRv?=
 =?utf-8?B?L1pFZDJjN09pd3kyVEtKTjFLbUJ5Tms4QnZ1WlZzeDdpblJBODdFZWRMT3N2?=
 =?utf-8?B?aVhCMHR5MlNYcDQ0L2xITi94VkVQbk9pM3h4UHdjN0loL1hpNXdtdVlkMXZG?=
 =?utf-8?B?alNRK2U3dk5oSS9UQ1hWc0JUUUJmZHN6MC9lczBzS1pSeStkLzU2ZG5id3NX?=
 =?utf-8?B?UkRXK0dKRUYyWDV6ZWc4eG1oVEFhZTk1clZjaVNVaklwa3lFQ1NKSjd5Rmdz?=
 =?utf-8?B?UHpPTCtCd1N3dEhsQzE5a0RiZUYrUC9rTk1sUUpIRWsvOVFCQWllL2hkOXg5?=
 =?utf-8?B?eGJZNk8wbVNpekwxRXlOT0hENGZSakhvaU83M1k0SG9vY2NHMUg3UTBSRlMw?=
 =?utf-8?B?MWRwZVVOQ3lwL0FaenRXMDFVeEJXWFBRS1R0YlhQT0x3NFdQcmM3Zms4THpB?=
 =?utf-8?B?UkxpMzBHNHlwK29XbUhBNjR0elo4V0FnTnVpZDBtWURkTlVqWWhRQXZrTEZN?=
 =?utf-8?B?NVB1TjdmcVFBcUJiZFRLSnBsMFAxQ2xmQ3N6NHlNd2FtYTN2OTNjMzRQeUVN?=
 =?utf-8?B?SlBlUEJuTjFJWXdMWk91TGM4Rjdqd2NwTVU5UUxwOVJmWUJpdnQ0Z2IxcXl0?=
 =?utf-8?B?RHhPUHhVVXlBUWZtT1M1Tm4wbHdKNWtrdUlVQW5TeEpjMHkrSWFQVVVrbURQ?=
 =?utf-8?B?RkJ4aHk0dTVCZXFMV2QrNGQvZWllZ3hNNlZLK1pEa1QyK0pOaXpieVczMTVO?=
 =?utf-8?B?L3NicEZSS2VqeGl1UEZBTlRLeFI5cis2aEszN1dTaTFQL0oyM0k1ZCtQOEtC?=
 =?utf-8?B?M0ExRy9NektxYnlVVXdaeVNZNmo0VklERU1mU2pXNVAxVGM0R0Mwa1NTWXJQ?=
 =?utf-8?B?ME1hRDI3NEo0NThzRVloRXNReXFtNDloVlMyc1RoMjlRTjNtS1BBaUNlMXBD?=
 =?utf-8?B?eEx2MnRWY0tQSDIxZHlKeU1aNE53QkgvRDY4d1AvTkhkRDROVmdaNXZXOWg1?=
 =?utf-8?B?VVhqSUFtS1ZTY3Z3d0xIMlFRSGhsUURQVmZUYnQrK3BlSnFMTTVodXZzYWhI?=
 =?utf-8?B?TTNxc3BWTzVJSGJqbzlLWHA2VUY4T053Y2ZDN1N1NmpWd2hJbkRwUzVVZ3lO?=
 =?utf-8?B?NXlaZ09sd1lLWFk5WXFlanR1VERTMDIyTnF1VUZPTEQvUmFjQVkxTFNGa29y?=
 =?utf-8?B?bnYrWGZ3amVtRVhuYnlhdUVvZ2l2QVdwcktmZUthLzFJRlpJeWdTV1hVeWVR?=
 =?utf-8?B?d1YzK3ZMOEdnWldjVkI0WWE0TGRiQXJadURkUzVubTNnYlNDT1FNUEpOYktV?=
 =?utf-8?B?YlUrMFFONHVZK3dzSEVKamIvZFhyMTlFNXdCWUFvTnhheEtIRVhLeHp2YkxS?=
 =?utf-8?B?Zi9JOVFVOENJTEpTdkZlV2ovYkhsR004ZTBaN1VsVUNmSzY5OGtFYkZISUlw?=
 =?utf-8?B?L0c0Tm5Pd0VDdlB3cEFTOWpVQUVkeFpNZXZRbWZQYjRBdW9XM01zVXBQWGFZ?=
 =?utf-8?B?TmtKNjBia2dkaGhoY1JFdDBlSFJjWGVjQVJxZEYvcGRSV0VWTk10bHovWk1K?=
 =?utf-8?B?NklFZVFxbTRqRk1XYm0xckxqeFVoUGF1VXV0aXZacSszUE5hMnRXL3l2MjRB?=
 =?utf-8?B?YXVvVlI4UWw1R0VaUHM4MGxpS1U5UFdmUGt4N0lvM1pkejBkd2MxdmFrc3Z5?=
 =?utf-8?B?MEc4UUxMcjJlZ1VicVJVNitVWUFEZGdLVncrYVl2QkRZcFZPMUxnK2xzdEhS?=
 =?utf-8?B?TmdRbHpTVWQ2aVNIQWRkdHk3WTU4RUhkamtNZllvREF1RkN6WVdvZEVweWw1?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1473c4ba-009d-40d8-45b4-08de0d43dfe3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:10:30.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB3psdORYMwgJ0hDhNUkEqWN0DFoLpG8uvP4JTI09UiHGy7vdQp9r2KCFnclbEV8XK1HtP7ZXFhG8Bpqi4d8IfPTinPMECZiQPCIheIw4aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546
X-OriginatorOrg: intel.com

--------------8BbOd9SEg00yzVocbCRn7zBA
Content-Type: multipart/mixed; boundary="------------H2SDQIiPJySnR66Up17zSeQb";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Nowlin <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Jie Wang <jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Message-ID: <7a03dd30-8e08-4bd7-a7e9-f63aa9b5d6bb@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
 <aPFBazc43ZYNvrz7@horms.kernel.org>
 <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
 <20251016165648.2f53e1fc@kernel.org>
 <4ae9d5d8-2d88-43d0-95be-ae75f0506548@intel.com>
In-Reply-To: <4ae9d5d8-2d88-43d0-95be-ae75f0506548@intel.com>

--------------H2SDQIiPJySnR66Up17zSeQb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 5:31 PM, Jacob Keller wrote:
> On 10/16/2025 4:56 PM, Jakub Kicinski wrote:
>> Oligatory advertisement:
>> https://github.com/linux-netdev/nipa?tab=3Dreadme-ov-file#running-loca=
lly
>=20

Got this setup locally, its pretty good, though it is a bit slower than
I expected at getting everything compile-tested. Took long enough I
stepped away before coming back a few hours later. It would be
convenient of it showed some sort of progress.

I've got some ideas on improving some of the tests (kdoc in particular)
which I'll look into soon as well.

Cheers,
Jake

--------------H2SDQIiPJySnR66Up17zSeQb--

--------------8BbOd9SEg00yzVocbCRn7zBA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPHd1QUDAAAAAAAKCRBqll0+bw8o6JIr
AP9+RdMbfHnCYPk0zirTUE7snyy9+BttBcHn4Ym09aoeDQEA7jWv70tbggdorkTZfi6rmaN5WkfN
zDtUM2D89eTtLww=
=tYTa
-----END PGP SIGNATURE-----

--------------8BbOd9SEg00yzVocbCRn7zBA--

