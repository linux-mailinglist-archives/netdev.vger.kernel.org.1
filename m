Return-Path: <netdev+bounces-213846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C66B270D8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E563F1CE0563
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCD27702D;
	Thu, 14 Aug 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHIwTpO/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF83202990;
	Thu, 14 Aug 2025 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206971; cv=fail; b=Ah4kx54LXx8opfD/E/WVsnbAwYeglMjJAXeuKwavQ6t9uzrEbMN5CdYIDjxDr9lyzcOX5WjYEHIaq+LkxJ5xkJCvApx4XekttLU379O7estBRNbOE0yVBRa2RcRzWzw2uVGprljTQcg0o72wnblU25VOVvbH2EJpuubrMcltAVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206971; c=relaxed/simple;
	bh=AKzISJpqtPesIJoWPrDFgJisjJT1KTVz2psCozyYkUc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C+x9k8tdG1MLnfTvcZ76RHxADujR02R3dIlfU60ZnTTb3h631/G6glqt+8JKCQCOXdmRYPXMLVeqGcpKOpNpIa7RBvRIf8GGOKv7JKW9wy4acsJcklNyCRuhAsfkK1hFeI4SKm8QI/yCRA/iJUcTVlqoqOSCSAODpxdlZvjkcJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHIwTpO/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755206970; x=1786742970;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=AKzISJpqtPesIJoWPrDFgJisjJT1KTVz2psCozyYkUc=;
  b=jHIwTpO/cclOSUWqmFryr4GyxRL2XiMEbf812HQYGysLj/Av55GZav9P
   NFna5swTq+v/hkeLRGntHTrh51G+tjKhvcdtOsRAO2L2lGTKp8/LtiyMW
   PyO34vGSLNvZb4PCZRoqypKwrDoz/OhG9ZbVG4RMtIavVgu8YpKV1hjys
   mZqTM//L95JMWkj6m252DhSqqE0Z0UflMkJRKKuN6LwTdUKUGGNQcHMmY
   Ii/LIzIejvLWibQX1Nv2kDgfRSpSg31pggTui0MynOeZvESQ5mUcNfXev
   178tJMgFrtpDvdSCbExMY+Gg916oXHd8mp11mybnQuGd/mKrEdF4Be7nx
   w==;
X-CSE-ConnectionGUID: URsjo/VFSDCLbDWgNTh+wA==
X-CSE-MsgGUID: Ej0vRBgXRYCQNgvws087kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56559361"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="asc'?scan'208";a="56559361"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 14:29:29 -0700
X-CSE-ConnectionGUID: Bgy5USbwTE2PC4QjBnMMcw==
X-CSE-MsgGUID: JXEhRAF9RsCVg/1jQHV89A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="asc'?scan'208";a="166357624"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 14:29:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 14:29:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 14:29:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 14:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xhwo17Yon+U7i6ZlI2dcwyHIOxbQpAAP84UQbaW1NcUEDRlLtTMsW4uAvnbtvu+EnGhXXmL3IDUmi+PBE6q7dK7eaurB9es7ubeHt1c/Gh2wSkzozfwvuX/xg6vuzTtEDxhqUOv+DlN4NZTnYAVkVnwnGBfuXvoyV/XUtB3rmh5jcqYeZSRLHN3F99chH/UW066GGwbMfFBdqtO0meBhMAJqwb0EIFbMcJwsxM+NdzgReuUQByKyBaCO4ywt1bpwROoGsP3TXl3ia3nHhxcQQrLo1G2G3GhUA0EL7tbeJtb0EEN0dNu9I9kXJQumZMQAMV6wt1VUx63g8kkH36eb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYafUdDESTcL9mdHH026LmLdTfduIjFEe8tf2UyOFbM=;
 b=IUpzTcjjj8Jc9NbFroCWnedZYKrDGteEBU5Wk0e5y4ir8vhAa4pMh9xXwl1SPg535/fKWNmm+KN0lLlWb7IoC62NG2n77gXX+lUz1fAZ8jSt/++o7gSGNb+/7PWk4V4CxOsXWniG+8wXfiM2OpqtSqUe0crWpRr8ecfrR0BNn3Rr518qLzZ/bJ+OqLNafn5zVw2ejqBLZFxFpLRZBK3on8Luag0MAPcbnyGswhcElDN5H5lz92/hOwW8tfw5RIqVwZs/jCyHNAkSFWrBTAOFGX3kOVn5HpzVFkSRkVj2QUjURuHdAN4JJzErMuS/VDyGWi9CxDbF77vG+aHfcRHsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 21:29:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 21:29:26 +0000
Message-ID: <fa3700a0-dfdb-4861-82f7-1512374c2cd7@intel.com>
Date: Thu, 14 Aug 2025 14:29:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tools: ynl: make ynl.c more c++ friendly
To: Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <donald.hunter@gmail.com>, <horms@kernel.org>,
	<jstancek@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250814164413.1258893-1-sdf@fomichev.me>
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
In-Reply-To: <20250814164413.1258893-1-sdf@fomichev.me>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------OIoZhdmxlYyOxibheSNGBzrw"
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: bad3b89c-0d3f-4511-b63f-08dddb79a4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDdVbGRBeHo3YzJxWEg1dlR3QTlNTWlCa1dzbHNYSTZLUTRnUHVqeEVtaXdH?=
 =?utf-8?B?Vk8zbVNWeGJKM1paMTZ5VkZMZ1g1TDV5WU51NFhnTXJjSmc4cGVFODBwQ0F2?=
 =?utf-8?B?S2JjRk9oK3lYTHpaRE9rb3BiVDdmeTgxTjR5K1UyOGZSVm1rRVZHMUJPTnNm?=
 =?utf-8?B?S2E5UE02OHZRUW1zUUVqZU9MZHFHKytzTkQ2RTJuRUhwSkJSSkFrMjlTUXdq?=
 =?utf-8?B?Vkw1K0xTL0pvaDE0SGFqZTNTWGkvMjVmQ0NOTVFqT25xMXVnTXFZeWgwV3pF?=
 =?utf-8?B?cDZjQXVlMTRwRTNJcXVoNnpFNFRnLzhzZVdMMHdSZ1h3MHAxL3NITXlvQnBl?=
 =?utf-8?B?M3hGaUhVdk00clE0cUJ5WkVNUWRjT1Z3WG5pRHB5TWRteXUrN0NRM0U1aWlF?=
 =?utf-8?B?elBpUEJ1djdBV2UyejlPcWFPSy9BRmxwQzQwcFNraG5mY29iL1U1YlpqRGMv?=
 =?utf-8?B?ZU1PYWJXaUdoNzd4MmIxRVQxUFlaQ2J6aUV0MW5sUmZiRWhsbGVBVFdybVda?=
 =?utf-8?B?eDVCMi9DSzYybThKcDhGSXk4SFV4MVZpd24vU1FlenJQOHB2Ykt6cC9YYnFh?=
 =?utf-8?B?NVQ3SE4xK1l6dUhIYkNnamQzQzVjZVFpSlFYNnM0TVBaQnBJQlZRcXVwbkkr?=
 =?utf-8?B?b1AwMmx0MkNnUitsU0twWHZIL3pTWkZscGk1c2ZkSTRYbHhpN1NlUG1HRmlE?=
 =?utf-8?B?aXh3RnR0WmdSZnYyMVZwZzR3VXNNTzd2R2JRN3VpNHVZeXlNV1BvREd6dU40?=
 =?utf-8?B?Q2VQcEpuMmtQVVZiWWYvUkhmK1JreGhNakZCcEZvVmU3NSt5RHVjSC9vTlBC?=
 =?utf-8?B?RG5zdG5LdWZPUkVBRlpwMC9Fb3N3cHVWS0FSeEJ6OFloeFV5Z2VGeUQ5cXdR?=
 =?utf-8?B?SEtBU3ZNOGpVWFg5d2pITzBmWlV2eUZvSlBKRVRBK0VZdUliV29NRlkwbmxz?=
 =?utf-8?B?VzFwOUZNMzV3dmw4MFNhU1E4bjlaa2gwM3JaZnVLRDFnc1g1YTRQODhKMDdT?=
 =?utf-8?B?dlJUb0E0S3J3TkNkamRlYm0rMnFkLzZDVlB0QytoK2x2ZGNHTkRFNkdoaDZO?=
 =?utf-8?B?bDlmczFvZ3k0VUFOaFRUZWJkTGp6Y3U0S0NTSVpXcXBYckZVS09Cc2YvN0pr?=
 =?utf-8?B?bTROdDFmc2U2WE9lRTFlRmo0WFNRNXJqSGYzcytuYllReTNETU43elphUUhy?=
 =?utf-8?B?MHErckMxcTQ1U0hqUlJxOXpuVnlWd0RyVjlpc3MxTXJLN1hoRzJqTEF1TEhO?=
 =?utf-8?B?cFZKUnpVZjVxQ2ZhNUJpaFFqbDA4OFhTYzVYNGpMYjh2NVBrRVJ2K05qNzVL?=
 =?utf-8?B?MDFCZGFMZ0hvZVB3RU1MekR6RnZkelBzRVplWDNrK0NCVlVnQUZqeW0rT3Bv?=
 =?utf-8?B?NXRBSmxpeFl6Wk8yTmxRazhiK0JTV1VoN2dVMzVadXVlTGNGclBFMGwzdHdY?=
 =?utf-8?B?ZHlsOEZrTzZDcjU0ajY4TjRMOFBaRU9LR09jV096QWhyUzFDK2I4SjhtUWNT?=
 =?utf-8?B?YXNwNDdST0NPd2I1aWhoNm11R1htdThaMTlyYit4MHJrMFZ2eFo2VWpJUUIw?=
 =?utf-8?B?TjBZamd4S3NheUpPc3FZejhjSkhnOWdXMXdwbU1ObHlpbnRvS1pvVFAweTdX?=
 =?utf-8?B?WHB3a1JjSUtVVlkvbkZYeCt6b3IzMDV3bXpvTThPUXl6WmNWN2lyNmpuYkRJ?=
 =?utf-8?B?Mkt0dkhYRkJ4NmlvN2ZvQk9XT1RRcW1yZWdheEZ2RVJoYktmSTMwamNCK0k1?=
 =?utf-8?B?ZFpDRmptd1dQczNCcm9FQTRVM3V3SDZlWUdCUXErM01HVlA1UmJxQXp3YzJq?=
 =?utf-8?B?QWhZUG1RU1p0UXVmS1VlN1cwNWl3eHFGNHh3alJtYTArOTV4dmlpQWM5VkNE?=
 =?utf-8?B?Y1IwOHRFNlp1ajVkd201dnhRZDIxaDVZOW5uZy96WjArb3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhTa2wwYjU2V1BiWmVwbThMRUZVTEtLUDZ3LzNBRGxuNVFjeFNQZnhHUDQw?=
 =?utf-8?B?VFE5czRMT2ljNktlV0pKTk4rUlNjVHF4elhLYk5aZDVEQnJGWXNtVHlFRjNu?=
 =?utf-8?B?VmEzRjBiOUt2dnpPZ25rR29tK3prWFE4MWVvd1hCWTdvWFhSeVpHaHpadC9p?=
 =?utf-8?B?R0JoVSt3eVJ2NTQ3NDdlRFZrTjY1bTRobWFUaGxyQSt2T0JxbFhLUE1vZ0pa?=
 =?utf-8?B?ZTBDTDVxWDJ1M1k4a0Q3NzREcjUweG1RdmIxUVdvY0F6U2RWMkVzcEpud2ZQ?=
 =?utf-8?B?M2E3RFpUMUxxSnFRYUQvZ0hDYUpRQlVNWXhUTzJVdzZYakM3TXI3QWptRkQr?=
 =?utf-8?B?L0xXYW10T2FtekFzZW54cDRoSllhODNsZVp6c00vQytSTGc5ZWVXUjZpNFdQ?=
 =?utf-8?B?cGVLNGZVWi82YlY4NUhWUkJhQUIzOUpOTGZ1RTE5N2dIYWJuV2dTQnBTUHBP?=
 =?utf-8?B?cDFCZzVBdU0vZFY5emQvM1YwdFFhdjJKb3ZpSm9rNmFYUkZTeXdSQjl0R3Nx?=
 =?utf-8?B?MXphRnNIbUw0ZUpISWozYTMwK2kvTlg5UFlDR05peVhHckFuQVdaMmhZczVj?=
 =?utf-8?B?RmZOMXhJUjNVeCtOWHlMNi9OOUFMSTBCYjBxZ0xFb1B0bnB2NldMQVN3cjRu?=
 =?utf-8?B?K3RxUDdFVTR3Q1lUWThzYm5BVEtnem9wdFNOSVN1eWVUSCtUUlZiSHB1Y2Vq?=
 =?utf-8?B?WTh2c1pFaWdsd1gxL1FxdXhFQ2NNL0VUdDJrbkVzQzBlRGJsakt5TFJnSVBV?=
 =?utf-8?B?ZlpqK01YNWt5QXJCZVZoaGR6T3RQdGhIOVhTMFlaSk5PVnhvUFdSTk9Gd3k1?=
 =?utf-8?B?OWtxVTFEOEQ2YmI5OXduZDFReTVYdHdtZmhUZ01PQjBZYkN3Z2JOMXBnOWVL?=
 =?utf-8?B?RUxjeXY4WlJXUzVQWFFZSGNqUDBJNlRmYVhtUlRudXMvVVdITGZ5SGJjZkpY?=
 =?utf-8?B?dmowd3ZhelNUV05tOUtYY2ZxN3kyRll2d05tcUR2aWJZandpY0d5YmJVTUJJ?=
 =?utf-8?B?a0ZnK2RhbTdDTnJ6bzA0ajBnemMxa0RSTkU4c0dLQ0Z5T0ZodyszNTJqQXVp?=
 =?utf-8?B?SER0WUdPM0UyZXZHdHdlb1pPOExLeFR3OXlmVndJYnFVNkx0WXFvc0pEYkRY?=
 =?utf-8?B?OG1KeTZYV1F3MHZ2eElCM3RsdHhuRUdjcDlQcVNuQit5U01kOHc5d2JlcmdX?=
 =?utf-8?B?bHZQU0J2SHFDNUM1dE1KSlJZUUQzZWhha1I2VnFOOTFNNzNUN09FbFRwQ1Jp?=
 =?utf-8?B?ZUtIdnFvcnNrU0l2aFBtakNIekZHK3ZYS0czNFdFZlhpNVM2YkFzTVBLRUM3?=
 =?utf-8?B?UUw5WXp1ZFFUT1BoMms1dDEvUzIzNVVvMmxOZGJxTlRESGJDdFB1bDlWd2th?=
 =?utf-8?B?aXhaWDhwdzRQaCtEYTVqTnF5dFFjaC9LbnNDZ2xodjFNbGpaOFZocm95RGc5?=
 =?utf-8?B?R2Jlb3ZQem42bHBHd3NNQW0vaDNCbXU5anNpQzJ3S1ZMY0VIa2EyRkxlZHE0?=
 =?utf-8?B?V3JKTnhUUUFsZmZqR1VJeW1OT054azZTZVp6dTVOYnBmMkh3aDVUNjNxelRu?=
 =?utf-8?B?OVdVWmRwZHgrU0tXMkErLyt0bnBic1ZYMm93cVpSRTBORzlUSTVuWGFYNjFu?=
 =?utf-8?B?RkZrTTI5Sm5xZ0VkbEZ0eHFXSGVYbzNPTkFWc0VMQmVwTDR3QlppcDg4cWRr?=
 =?utf-8?B?SWNGVVZicHZ3RTdRb3JNT2g4bXhId1FwOXpaU2U5QWlhVzNtT1A0bXdobmFu?=
 =?utf-8?B?eFRDKzJCVXIxN3gyOGRXSzNGak1IZy90c2FOZ3BTeHNNalYxcEczbWxpdU9K?=
 =?utf-8?B?VVNXRTljbFlBa1ljUTFweU9UdXVrVHVvMEUyUGxNMWFpdVNsN284cFFneUZ2?=
 =?utf-8?B?ZEdDMDdtMDJjQmlKMHFGOUY4cXZqOE81WjZvajZxZlMrdEV6Y0owam1xQWxF?=
 =?utf-8?B?L252S1VUTVY4cWJReVd4NkJCR3MvdFA3ckFsMitJQ1V2T1JUaHh3cittekJJ?=
 =?utf-8?B?NnY5VmpEdCt1ai9lMWYvdUZkd2QyYW9Oc3I0YmxWUU0yQlYxMkExeXdvNFQ1?=
 =?utf-8?B?eVZrYVNMS2poQVdWYldxMDFIemJYUDJhK3RQdmlacUlIYWxyckF5NnlwMmNX?=
 =?utf-8?B?a25Dd3c3RklDeWRtRFBtSzFpU1loUGg1Wk5YQkRuK1dFWU55MlZhMnN3K1Vm?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bad3b89c-0d3f-4511-b63f-08dddb79a4b9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 21:29:26.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5k41A5p+5N+6M/VlmVLXJUuPRYj4SZxTe5sC6DSq29/Dekd3cnJBZDDpFosr2Cx+eNWCfBtgGRPZR04PN9DgzzDaIjqq9lwhIYD/fSmERVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com

--------------OIoZhdmxlYyOxibheSNGBzrw
Content-Type: multipart/mixed; boundary="------------QXf0BjHxZYH8F2gX3ZZCnBie";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, horms@kernel.org,
 jstancek@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <fa3700a0-dfdb-4861-82f7-1512374c2cd7@intel.com>
Subject: Re: [PATCH net-next] tools: ynl: make ynl.c more c++ friendly
References: <20250814164413.1258893-1-sdf@fomichev.me>
In-Reply-To: <20250814164413.1258893-1-sdf@fomichev.me>

--------------QXf0BjHxZYH8F2gX3ZZCnBie
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/14/2025 9:44 AM, Stanislav Fomichev wrote:
> Compiling ynl.c in a C++ code base requires invoking C compiler and
> using extern "C" for the headers. To make it easier, we can add
> small changes to the ynl.c file to make it palatable to the native
> C++ compiler. The changes are:
> - avoid using void* pointer arithmetic, use char* instead
> - avoid implicit void* type casts, add c-style explicit casts
> - avoid implicit int->enum type casts, add c-style explicit casts
> - avoid anonymous structs (for type casts)
> - namespacify cpp version, this should let us compile both ynl.c
>   as c and ynl.c as cpp in the same binary (YNL_CPP can be used
>   to enable/disable namespacing)
>=20

The changes seem ok to me. Obviously these violate several of the usual
kernel style guidelines.. But this is a library which has a lot more
reason to be compiled with C++.

> Also add test_cpp rule to make sure ynl.c won't break C++ in the future=
=2E
>=20
Thanks. Is this run in some part of automation so we can catch issues
from future patches? Ah. I see it is run as part of the normal "all"
target. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------QXf0BjHxZYH8F2gX3ZZCnBie--

--------------OIoZhdmxlYyOxibheSNGBzrw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaJ5VMwUDAAAAAAAKCRBqll0+bw8o6MLG
AP42G/FWZpfuk9EZ2qf8eg1iPfnm5vJBb6gzqDdrMvdG3gD5AfFTreG+aTO2Af3mpRqKdzTCXZAx
3SVl5aLvxVElKQ4=
=WLOo
-----END PGP SIGNATURE-----

--------------OIoZhdmxlYyOxibheSNGBzrw--

