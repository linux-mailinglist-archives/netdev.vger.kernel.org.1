Return-Path: <netdev+bounces-150875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3599EBE03
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDD1687A5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8372451EF;
	Tue, 10 Dec 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuDVcynp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7A2451D5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870734; cv=fail; b=Ximv3caTgOAmAkoZ5FnAvkNemhi8p4lxlGpvqZTYS7HWk94xuigivdMWOaZGfZw8qadCKXDtRK+cjGYLrJN7EVVUt8aCmtQaYK/MeblUBO3Qdz/pBtweB8DpEaK19iWWDbfyNlKLwcrZ42+BoUJukpfcaBUj2oPmEJq8/vVg5LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870734; c=relaxed/simple;
	bh=GDkxCgDD2/f861ez9TdyryNfS1BMJRHcTm4TfpRIi4E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ooOj2YERm3oh4y14KmlwO3IeWiGvqcJe9ny8pnMx924xEmGlsxf5+AGA4RGC7Xecl6ZCSaZ0HxTegl7X/uudD4p5BwAKFPaIMP6f8Rl1sehZZ0t0A/YyjaIOV6hEFX6vjb9fA1GpIkPez9fYuyPVEvNCkCVyVOP14fCqmEtuJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuDVcynp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733870733; x=1765406733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDkxCgDD2/f861ez9TdyryNfS1BMJRHcTm4TfpRIi4E=;
  b=WuDVcynpFim9+X2wOvXNjnoZIj7vClvdjLsn3sX3DmxSCY1Vy2liJj8v
   GH3ZtdQ5AGovgooK3mVbW6w04TjUk5fdlTUgXqbVB6vVEp+S+VEdN9JOG
   skiPkQQ9RpC3AapPwe/wPnXybXGchSaJstUmytwbhmU5GkWO3jEyM2gn1
   cPEaw2QfbY9NmHQhvOiZBdfj8ut/CWBoHDwGQy5MKDp1Zx6/CjJcxNeZW
   CQSXPac/jKOF1RmdIFi0ah8DWRTi6xacqKtwzhr/R/FwR4yA2Q4Y3/XyD
   xLuphxRN+MM0gSjSki3koeaRvdnaEL6nJn0B51AuneczXqfgjZdFaMpuM
   Q==;
X-CSE-ConnectionGUID: rdqmiOq9TvWqQu1CS8QJMA==
X-CSE-MsgGUID: eV93vg9/T5e168hBMDu2Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56715221"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="56715221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 14:45:31 -0800
X-CSE-ConnectionGUID: rY/QfEkHQtKAnNV3nN+YlA==
X-CSE-MsgGUID: R9TNdWaSTLyRKmR/FtVySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126380457"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 14:45:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 14:45:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 14:45:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 14:45:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c04YVDsAKtfKuCpgqyUyJnfO4oQ+sU+JC5DRezXE1pgWa3Ao6vUtMX0/SQ5mt+VXQrEVk6bOaAhzYxVD+/4rBjOspRYO6/YMiDq5B+7g211o1bMGDDpglTrUAy/ejHLjNaKrg9ZcQB67ovxDPGH4pios66DWZ73VOh/zIaR0mZNbZM3WLXVVa2VmOLkXxtfpAHSHlHY7xleQqlfSYD7Ke1Isiq2spEubvWIKaSNsUS4B/Yys3lXmh4CH64gd9uUFEb5MFDK5s1YOZlBQQTVRU6RdIdQOSIeNFru5nUBoCSow944CBG4XdLnW53ggHHCQynpfE+TD7qUmpK5b6TdGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s86MnhkrIMl622fdye8ymlsAEmY3bNo/I/IDUrBX0Uw=;
 b=uNVfOqkmVxGiIKqbPkFndS3Zev5iw4btxG/UptvG5U422pHULzgXvEzBW5UcwKujfBqHDx/pHcG0ReVdRgQAgjd9pToHVUko7hdxNomRtzLUmz611SjyYEHkL7nPlTMKf5jUJoPXr/ePodlYZSD2icnND14Q4UCI97IOlOC2uDDHlF5WDtsnJsJdrhrZy9QVO9g1mUib7hZ9Z/0EIZtidWBVPyQjNUjM+WVGaQNpEUHhWoqLlPE667BnabKxdLBlkc+OBjv399w62JljDbXZrJZRghNT7qPky0jF3UCmeXw7OV7s18ErIcmW/JBz7PyYgCxut9xBiqm0NTcMOs0XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:45:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:45:28 +0000
Message-ID: <3c021b7d-4e1d-4bf4-82b4-f6b88a5df53e@intel.com>
Date: Tue, 10 Dec 2024 14:45:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] ionic: Use VLAN_ETH_HLEN when possible
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-3-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210183045.67878-3-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: c436b7c8-70ee-4973-9bad-08dd196c5838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5BUGlXNzc3ZlVSWXJlcGhKYWwxM3RHQWlqMVB5R3BWQys2dUkvMWJPN3h6?=
 =?utf-8?B?TFlNT3I4Y2JrM1RLU1lmTHk5Qk1GSzV0NmEwUVdGQnI5dGZLK1hsdW5ITU1V?=
 =?utf-8?B?WWMrbWFYZTJCbzZJNFJiWXVRNituVXJ0OFRTSWdtNjJqK3BRMytNRWVKbzZr?=
 =?utf-8?B?cHNvTWl3RkgrS1NuZWxBYTFnZ2tnTVV1WFM2UThTbkRQU3JrN2VqZnhMTS9E?=
 =?utf-8?B?VlpVS0lMNTFWYUVqRXNBWUJhaTE2V3pDTjY5U1lESWtLSUllN2luMmIvZTBM?=
 =?utf-8?B?SEdNWm5xTkE2aXhraG0yZlZFUWdqWGNXbm9ibm9KRFpPOUZVckl3eFFJS2hQ?=
 =?utf-8?B?QnM2eklKelk5ekphZU1XcDFjK08yWFlpRXRoSTNzbWdram1KblZlOUFqc29C?=
 =?utf-8?B?dDRmWGdXeHN3elBrWE15dkt0Q3JTVnJESG5XOC9VU2syYkJmMmxUcHRhVzVB?=
 =?utf-8?B?azZHTHRsTzA4TlZSdlEwbEVkcFVZb1dJdVFGeUtqYVNVWThaNUluU2N3c3dm?=
 =?utf-8?B?elZGeG1JUXBlbEFudVJBU09qdzU2LzdQSVhBNXAxdUl3ZnVmUWJmTkVYZ1Z1?=
 =?utf-8?B?U2kyaG4wMVUxclZrUlZ6NVJoRmdhRjdTV1RQNEt2UUhqQnRHcXhqWDBZdDJZ?=
 =?utf-8?B?ME1qbDJNUytLZ2RSZVBnMnNCZHNaeHQvME8xZ2p1K1dGN21MaUlJWUpHc0R0?=
 =?utf-8?B?cXI1T00zMW1HSmllY1BZZDU1eGpzUE1PUnZOWkFGRi9VNGNycnFpOTJvQS9x?=
 =?utf-8?B?K3JidUw0aXFMMm93Q29tckd1SG9RWFMwWXhEemlTQWMzYU9JeDFIbHZPUFRQ?=
 =?utf-8?B?ay9lb29CZ29qYUt2ZjZvZ3NKWEFxZzMwTkdnWk5FR1NwamRKK2hpR1ZQV0Rz?=
 =?utf-8?B?RHJmQkNYNEp3QmJVTVI4V2NaVXkwQURnZWkxSmRzNStkSjN4bDJXREx0UktZ?=
 =?utf-8?B?YXRYUTVtTUM4a1FXTUNOUGVZY3I0YUZzSW1KTVZnVXNRVDRyeWpmQ29YRzB5?=
 =?utf-8?B?ZFhtQjBpQ01CaWRKcTdrSG45QXYyTktBbkRybUExUXhNaDFtZlZzVDhnbmJv?=
 =?utf-8?B?ODMrMkdSYnd6djdwU3hlUEZGT3NGRTVLVDFMODJtc244MGlSVjVZNEZLU0lh?=
 =?utf-8?B?Sk03dnJFeFZ4OVZLSU41TjdZQVhJSEhyUDlkdFkzVitvYXh3NTNZSWF1SjNl?=
 =?utf-8?B?eWhTckJ2UVRldGhjQjEyNU84ekNqVjBheWcvbzhRNTBrNWxXS0NnOU9rbXlq?=
 =?utf-8?B?dFdEc0dOSCtJcGR2QVF6RVBHVEhTdkMydFRiK0tKZjAwK2Y4SXBPV09zZUU4?=
 =?utf-8?B?KzFVZmtZNjJzcGlQN2hjWlgvV2d4S1JTQnAzYXdtT3g3K3dkU2JpaUNvNFUz?=
 =?utf-8?B?UDFySEh6S0hQQTFjSHc2Y05VR0dyY0JJbUNrUU9sOTQ5S0VOa1RCOGE5VURY?=
 =?utf-8?B?SVc4aE1Va01zcGJOUTBiT1RWZE9BRjBZU1hhZ2I5V0tRTUVlVGJ6NmRKbXY0?=
 =?utf-8?B?c3NKMENNWkptWDFPbGVkNmp6ZDNPd0hHdzZyaUNEdjVKRVpzU2MyazVERnZF?=
 =?utf-8?B?QUNOYTdyMWc2SzBJbFlMcEZrb21mZTZlOWx5OWtxQXI0YTBSQzgvZFRBaXln?=
 =?utf-8?B?aUx1eU51eC9namZYT0JaaGdnZ21FRk12WEo2RWhZRVpBd0YrdURvQk1MVnNB?=
 =?utf-8?B?R0NBem1Kb3daeTRYa2E5N0hhZE5EeHA4Rk9BQ1BodWhKOVd2azhuaEQ2U1Jh?=
 =?utf-8?B?cDZNK3laV3pMelFWL0Y4MldOcTdBb3pUWHRLZUZkVVdPMFE5cXNXK3dIVXJ0?=
 =?utf-8?B?OXQ2Z1UyOFdxajROL0RlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekwvZkpRN3Jac24vVXpGV3R1N0xGWDhNQ1ZRQ2hBSnltM0NSUkdad1NhQ1VK?=
 =?utf-8?B?U2hSek1rd3lkbjNSQm1BUlNFRkhFWUpmWERRM2Y5dkNFLzFzakxBV3NJOXBZ?=
 =?utf-8?B?MG9Ea1k4RDN5K3JlQ2RWc2RBMThMMlp1NzdScmMycmxyazhMOXU5TFFsL1g2?=
 =?utf-8?B?QVFKS294QUYralFyZi8zbnp4OWtTT3oxaG4vZEVabTljMk1uc0s3MHFxV1d3?=
 =?utf-8?B?NXZGTWdDVDlKWktoekxjRXlrTUdyNU5MMmo4eTdjRTFwSjh4cmdvS2RpeExD?=
 =?utf-8?B?a1ZxQUdEM2VPbm1tc3JpS3dwNlJJTmVDY3pQRjdpNWlUUGZtUmZjejk5d0pz?=
 =?utf-8?B?dE9nUmZuWFRKbWhTeFoxLzdrcXZXYnNiWkxtWFlWMUpzS29mZ3NmTHRsT2h5?=
 =?utf-8?B?SlRtWmxJWm9YZmRZalkrZHJnWUNnOHFPdEVqTWRkaW5jTUFNSldqTndBTkt6?=
 =?utf-8?B?ZG45SDlmMGdMa1d2aGdTV1M5Wmw5dEN1a1UzY1N2NDF4aWp1NUpRZDRXUWxP?=
 =?utf-8?B?ckFTVlN3bmhDbjlCSlJ5R1Y0WVBFK04wQngwa3NuVStzOGdlVHM5YjhCMkk1?=
 =?utf-8?B?ckpZc2NtZTk5NkFIOUREMzhROG1abWt4WHpaWFRzNjBrbElJa29rM0huanZu?=
 =?utf-8?B?WlNwc2lFRnltampLbDRjM05oOU9ZcEtCWGRtUTBBRzh3WUE3R3EzQmE3K2l6?=
 =?utf-8?B?dlB1bTZaVVB5NSszNWI0N09IeVJ6d25XelREQWhpdTNHWmd5SEh5VzdjV2M5?=
 =?utf-8?B?OElhUWMxY2E4a0FwRG1TSVRMNkNQSm0wbmdWSjNYd1c0LzZLbG9sa3lCN0k4?=
 =?utf-8?B?TXdBYzkycWs5czA1UlE4c1haSVE0NUFRbDVrelZCTHRvMHR3cW9PSVArM2di?=
 =?utf-8?B?MFZHZGYwSUgxN1h2ZCtqVHlsREJBRkNjdUdpdU5RbDM3VEI2UGdmNXU3cUVl?=
 =?utf-8?B?SnJURGthZjlsSHRPTDFETTBmTFJWTE55VUlnRTZZMm13M2c1VEs3cVpURWpX?=
 =?utf-8?B?cXVYazVYSExjbm83YkJGZVJNcTVrVnAxby95RHBGdTVkOFE0M3hjQ1dERzNj?=
 =?utf-8?B?SGVsM1ZscFYzaHQ4Nm0yWDN3MnN1UHppempwejB1V2hXQmNpZmJKblkvcEwx?=
 =?utf-8?B?dmF1em52TkhQdG51cVB1dFlLeStHR1FsM1h4am5tT09jSmZHSnAvanVDc3l2?=
 =?utf-8?B?UXUxWUNtcHlDNTJOMTFpL3NDWEthYU9PVTA0MnJFOG40aVhvVGhjQTdPK1Z1?=
 =?utf-8?B?WDc2MjBDSVQ5QnA4dG15b2VoeHhWY0pmZVRHWVhoT0NaaEthV3FTTHZwbkJn?=
 =?utf-8?B?TUt4RmlJK0N3UnJycXhjanR1ZXBhY0R2Q2F6aDZORE9Mclh1T0ZMNjlnWEhj?=
 =?utf-8?B?M0ZNcWFJOS9WSDJ5N0RyL0kxVHJEa2g4SFh0T2xSWjFJRWNDWllReUxZbWc0?=
 =?utf-8?B?aDl2NmVrc09rVWRpR0tramdSdjl3RmJNb2ZIUjkyajFsOUtyVVBVNitTR2xw?=
 =?utf-8?B?MHV2K0Y1WUpNa3pmMm5JRXdEZEU5TnN3aTY2aUMrN1AreHlEblVKb0kxZHVS?=
 =?utf-8?B?V3RsUklGSnp1UCtydWFoTFVoQitRRDRmbGoxcnkxNlhJSmNIZUVoZzVUZC9F?=
 =?utf-8?B?a1RYcHJDTkxRaExhRVZZT2VHMVE3TjRodWFYV3QyR2VER1R0Vi9jaXpYTDkr?=
 =?utf-8?B?RVRqWE5YZjAwQjEzYU90aUhjWURqeWcxTkN2dzllL1ExcDIyY0pMSXM3OVRF?=
 =?utf-8?B?SWdOamFNbmdGZ1h1YWdsTnNaMjlwRGVXR3F6UVZmWk1zc0I3WW0vNTQwZEJo?=
 =?utf-8?B?STVBS2JNTVR4TzJEMFVHTHBCQUd2RTB5VnNjUjUyakxmRVM3VkVXVUtwTTlk?=
 =?utf-8?B?bStmakxNdmNoTjE2MmR3dmhzSjdWQU5mYmRrdzRYWnArU0NTUEFjalRwbVJU?=
 =?utf-8?B?ZEUrblNGQllDYWZyVVJrdkxUK1lUYllZcFB5SkRabWRkL2lZRUZqZXY1YlNU?=
 =?utf-8?B?aS9BcVVyTWtiMW5mSmxTZ2cyY2ZjaDRmNVNsR2d5YS94Q0IxWThtcUhvVmpk?=
 =?utf-8?B?bEhSS0FJTldpbTl4UzRZcEh0bEhISHpPb2FJNSsyaTN0SFJUKy9RSno0NXhM?=
 =?utf-8?B?Y3BST0xDZFFxVGVHc3owOUJTa1lwcHhjdDdRSUxXZEVOMUJHYWRESmgxeG9u?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c436b7c8-70ee-4973-9bad-08dd196c5838
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:45:28.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kin3k660+mA3YtiNpTnnL523wIid210l2QArOqQLd8rQJltBd886yXCrmkl6YN+dizqCUEzzl+AVpFmnIQi+jDkPzuS1DyElFSWl05qWKmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com



On 12/10/2024 10:30 AM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> Replace when ETH_HLEN and VLAN_HLEN are used together with
> VLAN_ETH_HLEN since it's the same value and uses 1 define
> instead of 2.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 40496587b2b3..052c767a2c75 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -3265,7 +3265,7 @@ int ionic_lif_alloc(struct ionic *ionic)
>  	lif->netdev->min_mtu = max_t(unsigned int, ETH_MIN_MTU,
>  				     le32_to_cpu(lif->identity->eth.min_frame_size));
>  	lif->netdev->max_mtu =
> -		le32_to_cpu(lif->identity->eth.max_frame_size) - ETH_HLEN - VLAN_HLEN;
> +		le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
>  
>  	lif->neqs = ionic->neqs_per_lif;
>  	lif->nxqs = ionic->ntxqs_per_lif;

Nice shorter line.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

