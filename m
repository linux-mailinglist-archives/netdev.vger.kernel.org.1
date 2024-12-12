Return-Path: <netdev+bounces-151569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79449F003D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E24161D9D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DA1DE899;
	Thu, 12 Dec 2024 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkmLgMsq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603981DE4CA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046538; cv=fail; b=l8L4vUWie5PiMMf+SRf4DI1h4VP2BWK+D2Ck5qfsKEIBxj2e1u4uU1MXbk3ykCmtfJaW+hwrGC5aVloFpsZvoqzbAtdr2gn7YdfJ2H9mNT1UHNXw5Aot6NPV0azSBIweM8qWDgJCohUfIhCqqx5S8xDzcFQXOsR/nmjs+Ady8NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046538; c=relaxed/simple;
	bh=J1uLVKHPO0uE5od6X7sEz01+iwuXzMjqqRTteY9x+rA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sgZgLVRkzG7U/jcOraHKQg1xlS5+tMaALThGYEgWWWiMM1Ix075zNf7qzYRdNHhUru43zS/152qRINuZqQvxB6sX9NclAePCIw9cEDUN14bvmxn+mqvhGP2h03ssh8agbB9V/3g4ohT0GLCSCrj7zN3eoLn2F6m0vmPMNlhKNNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkmLgMsq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734046537; x=1765582537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J1uLVKHPO0uE5od6X7sEz01+iwuXzMjqqRTteY9x+rA=;
  b=kkmLgMsqo9m2CBbcpEg5il5e+DVU8BqGhZyGxBRAL8YyAU4QcPnACukj
   eEIEIf0qMotoxIYEf24Kf3nW1P0mQmtw/HM6vYElsSu9mpKMOOP8PaMiM
   nRTYCeRJKxUiLCy9LsyW9hPKE9QPo03qarvxtMEvKeukHD7D+4sn9pfbs
   dBQZirdxzTzfzbmP6Y92Q7onRi9QIgm07SyQP9ijcZ7zzgWKpf72e3WWS
   uhtjZSYe3s1vEp8yFhgjruaFZZoae+9AxpwsZx1QeSZWhoyPgjpiw1nSc
   ZvSdMBlIb0wFdfAIDXrlOxuB0fRN0l7xt9AgK83Z+YVb0apPE6VOPqaPC
   Q==;
X-CSE-ConnectionGUID: BSxbTDFcTvup0HoE6Yx83A==
X-CSE-MsgGUID: v1ZUc3yGSRSN9Cm0POQT8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34362956"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34362956"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:35:36 -0800
X-CSE-ConnectionGUID: 1N5HK8BsQymi6V50V4gAdg==
X-CSE-MsgGUID: u2eQ1NtXQDikTzpKQe5U6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119623378"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 15:33:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 15:33:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 15:33:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 15:33:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1gzfw8AXOoLJEpUegOjWFdDqEf9iMvyWFoyrfEoFyfHBwwnYoBW3a5V6FV8O3ulX9jwe67UFZsJ0w+b5pbCdZ3CyuJT673f13hOKe7KjY2g96agdvfOwCz2ZUoW8kctbC9RRQCo39ihAyK0NcKS6V3NKYyoko7hnx5wz7HnyJCcGhakCcRTVcgOwx4/CShlT/TnQ0l4QzxTQDcADj/bdemwH4daabPphAxgWTGHFu5QmjLTm3uzgjrnUwpqjshvK5538UoKtNR4jtq+bEraLof5X/ndQLKZDTLpK7FiA0fJfToKrsfYBpWPi7JHvTontJk5xFmDw7O5HwPPvf/tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rcX2svSlG23wKRBuit2SHGEtzM1T2X7r6ArqOavnoE=;
 b=k2Rs5C4tLlrAZWn3Px4KK9Q9QdZZnQEBEUJxTL/1a0Pf+fKezeiEeKzLAXdCzxU4Ymh/9OE65kxpBr+E7CJd1s3aqZTxhe4SnBLgyQfMkOnEhfiHFsV69TPdRC0zYJfXVflruX1sDRKRBwYAvyYn2gXNDFMIT7uqLmGwZglrMVE1pfvCRPh17rjuWBYuy6uImKKSI4J2kyGN1aaPDQ52Upjzc6IBdOmKQ0k0JwKfOFnLWrhBAvL7jgNcDhQRdL29bIK+xmPyBdKeKrDv47qGVtV73s98xT5LLLRaYhnNtSyN3V71zkQ50fKJHtj/HeFpJd0Su+d5Kb4yb6VADfTlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 23:33:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 23:33:30 +0000
Message-ID: <996c9327-fdab-403c-9d73-b2d3c292fde8@intel.com>
Date: Thu, 12 Dec 2024 15:33:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ionic: remove the unused nb_work
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241212212042.9348-1-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241212212042.9348-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9732ccd3-ab26-42cf-437b-08dd1b056307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzNoQVl6Zmt5Zk51dDVyRncvam5XTElHTFBzYlVyUVIrMmREVnBRZ0FjazB3?=
 =?utf-8?B?ZExWZGZJVTBzQ2JEYTBQSmV0K0VVVmQzZitDd2p6TXhFdUtVdmtoQ05IL0Qy?=
 =?utf-8?B?NVZGOExBckU1YXRQVFFmbGo3TVI1SUJhbjhXbEtGSXZleWI1b0E5OGtHbWRm?=
 =?utf-8?B?N1BDNVZxMjEzdHVRUk9nNGM4L29PaFcyL09yRTlyRUkvcGN6Vk1HLzRWTkJD?=
 =?utf-8?B?TS9zQzI2N0ZNQzRZY3FuY1JHVTA4dWpDZmdhcVV0T011R1VYano3L0haRXlj?=
 =?utf-8?B?cS9ZbjVEK253VDJKcS9NUjZBZ0hFTWxvZS9idDNhcHZhQkJsR0JyU2VwRzJT?=
 =?utf-8?B?dWo0MUpDZkNXblBmTjBCTm9POE1IWDhhWEtEWTVyK25hdnNWcm9PSFJKMDN1?=
 =?utf-8?B?aVROTTFFNWtNOTFRbjkrMFBXKzJiL2craW9DTUtFck8yTzJJSXIxd016SEdV?=
 =?utf-8?B?c2k0aHM4NVBLUkZ4RnZKNzFhdXpOeGhNd3pmRGs1c1RXK0VlajN5bmVyZzdt?=
 =?utf-8?B?T3FBdDNsZU0rOWRBaXpueC8xbnFJTmtkeXh6OFZRYkVxRzZIWHdrbHhqZHY4?=
 =?utf-8?B?SDkwYzN1UHI5Mm5QVzArQXpTN2llN2YvL1hjbWtKREF0MitJYmc5R0dBMTJs?=
 =?utf-8?B?c3EyR2doOVdaT29tUGVHVUhHLzVPdXBrSWRqRW9jMnZwZzZ2T1JPdVpQU29Y?=
 =?utf-8?B?Sk9BWXJMNTF3NFpnYWVXYWhUaFdLMHBRNjMvdjBHb1JRTTN3TTFHcW11YVUz?=
 =?utf-8?B?TFhFMFVmUElnRENRS1BMUmFGekhTL0t2UU5xSWY0OU5tUm01RmJDb3FuMTds?=
 =?utf-8?B?MElBS2tTUGhOeVQ1RVpQK0RXdmtLeXlOVnBQRXhyRExTQWE5M2FCVk5Eek1M?=
 =?utf-8?B?YUN3TTFDbnpDc3RsUnUrcFZ1OENBblBFTW0xaGttQ29LRHBoT04yQkFjSWlY?=
 =?utf-8?B?dTB2dTgyWktFb3IyMjR6bjVDQXQwWDhuK0lPdFNBbGZuNUFDUWVUdEJrVU9C?=
 =?utf-8?B?VmZDRkVrQzFwY2dQL3BEZlZJeHk0emVQNjdOSDg5d0Y3WlM4eGdodTJnRDhk?=
 =?utf-8?B?a1UzZlJDamdpWlBkakE0VW9FRjNUT1RvS2ZidlZZUWFUdk1vNjQ3R2lucmcy?=
 =?utf-8?B?K0ErNlFzc2pId3VGRExqN1E4OS9pYXNnVDZGQ3FzWVgreHRsU1g2WmNMYXVW?=
 =?utf-8?B?M2UrYzdVR0NjWGRDQ29FMUlHQU1OOFdnYUVsUG1EeUhoQzZ2ZFJZVXNmSXlv?=
 =?utf-8?B?aUhpWGtWNVZMM21hZlhyd05TRWFab1VMM0EyaU01dmNobi95b0xMZXpkK08w?=
 =?utf-8?B?NzU3M0xibUVaTDBjaHRoM0VXU2NJbmtnd0FEeWJHNkZTbEowZGJrVW9CREcx?=
 =?utf-8?B?VEFwOGRHa3FibFhRUHBISEVqRkNJTnhxbUF3dTJpQ0FXTUZDT21xNi9FSGo0?=
 =?utf-8?B?WTNwUklNWDM4akFXS0xJM3V1TmF4V1JLNHliUXY0NHZOS0FqcUdROXNZRndV?=
 =?utf-8?B?YXltSWxtRDk1R0Z1aHpUSjcreFB5RFdScmhSV0d5Nlp3ZEtQUXBvOHBpeE1S?=
 =?utf-8?B?K3BESXlicHVxM3ltaFpZc1NMYlBEcEpaNy9sL3l2U1E5eWY2Q0p6dS9ZamVD?=
 =?utf-8?B?WTZXazVoeEIrb3AvL1Y2Q3h2VVI3aTRaeWdMMEJZUnJrR0UvNXpNalY1QTVz?=
 =?utf-8?B?Nkh6U0VmdUl1ejZEM2lIZjdtMS9nMEhlaWltekg4TXZ5UHkrbmcyMGFBd0hZ?=
 =?utf-8?B?MWdCQ1NyOVpkY1ZheHRyalo1eEFDcmJ3SWNqc2RsZXM0RVJqdUdXNCtNTWRY?=
 =?utf-8?B?dFVvdHlHMXVxWFdoV0pBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29kUGNUMXpDdiszNDlGV0ZWSDB3aVdqc0kzTFJuUkdOa0pIRys0c2tXV1RF?=
 =?utf-8?B?TWRibGN2SlpKdEpQSlZvNEtIUnRLZ3Rzbk0raVVmS2JNei83b3RBNHBGMFEz?=
 =?utf-8?B?bGdWTUZrTDFHZ2FCdldHY3ZnbzZXVEhVOGFmYWtvZml6azJSOFlORHo4em9N?=
 =?utf-8?B?RTI0d1RLTktVSHczMVAxZnIrTVZIWWxpOEE3OUdJeXgvOS9POXR5K3VRdzZu?=
 =?utf-8?B?ZXBnRHlhbDdGYmI3alRBak8ycC9lcitsU1pQdnMzNW1VQkN3Mm8zUFhHOUlW?=
 =?utf-8?B?MWRJMWM0Zk43anFsTnNVSE9CNEVyVVVEaHlyQS9sR3BBWEZlRzEwQW5RMndK?=
 =?utf-8?B?blFFVkJPaThpamtnMTRvTEpaQ2gzU1d5VXpha25NazRETlV6YmFocGZNK0hH?=
 =?utf-8?B?NWZPVWNjaHJxRnBUK3hzeDFqM2pWUlFad2dRb0dReE5nbnJqc3dZODFtN2xK?=
 =?utf-8?B?T2F1RkRaU0p5NVhpeU9yQWtBalNiNWlMeEQ4Y2Fabmw1VEVteTlpcTFMNytO?=
 =?utf-8?B?bktqUkFsQUdlQnRxOWZqdW9kN2g4M3FuK09BSWVjZVA1VTkxQ3dYZXpPc2l5?=
 =?utf-8?B?L0xDUUNFSDkvcGVjT3kxNWNuS3pLdlgwNVFYRFkrWlhMR1ZzVzFaYTRjeE9v?=
 =?utf-8?B?U21pVUY0b2dlWDlId1d2bGpzWC9mQW5ma2RsVVU1OC9VSE9uN0lXZXdzVnJo?=
 =?utf-8?B?T250RDdhd2YySHpBQUFLWGh6SkI3eXlvUVptQkRDQWcxZ0REY09lNTVRbWNu?=
 =?utf-8?B?ZXQ0V01qZzJaSi9CTnBIaDZ0cHZ0WEw1VXQ1VFJKbGN0a2VTOGM2ZHJCbEhh?=
 =?utf-8?B?ZHNNcGhwTWh3RVBNbElLK0dORTZmUjNwSEd6blBzZjRKWVRHbDFycVROU2xK?=
 =?utf-8?B?ZXlkMDdrWGpuMGVwUVNDWnoyd2JxZ2hvOGpJd2h2Sm9KZVZQS09iSU1hUUFJ?=
 =?utf-8?B?aTRnUkxTMzhoblYxdTd4Zll3K2VPUDJyNUsxOFdoNzFqSEZOQUkxdFg0RTFq?=
 =?utf-8?B?WDJKdkd4ME9GVVdEVkVIRkJUR0QvMzMxNDNXeG11UkxONUJQQWtaejJTdUZ6?=
 =?utf-8?B?NTlUbEZCU1ljcXRvNklRaDNZWHlhVlBzRnpZMEdiWG1zc21UdU5SR0laWW5N?=
 =?utf-8?B?NFpZNnhjZVA0NFJMQkVUTUhSLzRKOVE3TDVqY0phamdQeDB2bW12U1g5UkMw?=
 =?utf-8?B?eE8rN0YzL3Vub203T0FzNFMxemxmREZlUnNETmphUVZJV2lYdlhZaStxVXZs?=
 =?utf-8?B?alN5RXFaV3RQbytwQW5YMTNlNHdYUVNmZFMySU9UTkFzRjVuc1pUOTZBS3pR?=
 =?utf-8?B?TC9EL1MxelZ2V2tLRTVxa3pvUXNtMURoSS9Cb0VmbHFyL3N4VjBwcUU1amxG?=
 =?utf-8?B?Qmp3NHU3TVJqRmt6MjlVUkhqRGJ3TUs4STdRMDBEY2JIcVd6NzQzaFJ1eDMv?=
 =?utf-8?B?a2l0UXlMQ2c0Ukw1blVKaE0wUXJCVkw3eWExVWZzWmNpMXhxMEFzbVV6MmlO?=
 =?utf-8?B?TFFPQVh5cjBqa2I4UzY0U2t4RnNiYmdOa2U0YUNBaE1mdUxMNG5aM3cvSURx?=
 =?utf-8?B?Z1FPZmxSWEpIQ0VLMjNxZkEwdzMrV3JqSFJKZXVPcGdvT2N3QjE1K2pGYjBT?=
 =?utf-8?B?NER5bnNITkpTYW5TQ2VnUmNnR3RSMVUxVkJjK0k2aW9ROFdHSnlndExCeEYy?=
 =?utf-8?B?cVV1cFBtU0hHRXBIL0JrM3BSWjRhMFVFTGVOTTJjM3NKQm1qSmlQWHZYRmFv?=
 =?utf-8?B?RTVub2p4bjlXTUpMKy9GcVE5VDhXWi9yZDFlUXVyb0c4S1MwMnBBOVRoSVZw?=
 =?utf-8?B?MkdKQVZ3S01heW1VaElLREZTUUI1Ky92T3RrVThoQjZ5MGphaHN3RDZFckh0?=
 =?utf-8?B?R3JEb2RZZFRXL1dLc1V1eTNJOVhsSlltT0dWb2ltVTNEZ2FydGxLTkwrQzMz?=
 =?utf-8?B?Kzc4cWErM01XNzRobzdkcTd6anNRVkJsQzRGUUY3SkVLUlVLUGpGUWEvSDU5?=
 =?utf-8?B?VTg5TjhvakxmNjZwVlNMZVZUQTZBRVJNK2o3cUJUTWp2U0Q3RXdiSnBNVEd5?=
 =?utf-8?B?eGY0N0R5c1N4elBsMVFJNTVPZlQzY1VPUUpVNjZLYmxEbUFvUURYQ2xVS2V5?=
 =?utf-8?B?UEI1L2RFbFc2Vjk3dXFreEpDTnBHNnNUVXdybE82d3JlQytNVkdpeDRQOHRL?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9732ccd3-ab26-42cf-437b-08dd1b056307
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 23:33:30.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb2Y2Sqraqx7bgMxcb0HN1pHfFeY/5U0ihhQLP4cULYKtTuGfJWydeo+YzY6sVIz2CzgMJ5cKNtlbFM8w28jsq3w8bUftu3HiXeKGNTT/u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com



On 12/12/2024 1:20 PM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> Remove the empty and unused nb_work and associated
> ionic_lif_notify_work() function.
> 
> v2: separated from previous net patch
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

