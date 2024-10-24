Return-Path: <netdev+bounces-138861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7779AF366
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296DDB212D5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0B200BB6;
	Thu, 24 Oct 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNUHelSo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BD2003C3;
	Thu, 24 Oct 2024 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800870; cv=fail; b=Jqg36rZL2eW0a5W+R1CmQPnuclKilySeSO+Ozy8TFVM4EuapMjSZuwT6uo8x3QKaUNfNR4IVm2ytnWiYyq91nxH/+MuCsQnUP4PyxTTlomXsAKi4Uz097UtFcdDP8GcgT65rWS1eNajhPD2H++Nq/WHnq36ouN++0hRcvn3XpN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800870; c=relaxed/simple;
	bh=hbmwwF9KYMaJLCSoJ2NSQ30xXnnafhVgqfgEZoFTknM=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yhm/2v8snBaRWEX0wHKNYVn3URO4emIIYJ9lDGw+0clLq2wk95eKsrKi+iY2hsU6IysCvymD36MVaPt8CwfizFSEzeAFP2psB4muNWGeJEGBBL7ajEoEBR++sqRLo2VxNvK+R0PO2zi3/FFqBcft8y32ZGSBYYsXajaTdaGoVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNUHelSo; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729800869; x=1761336869;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hbmwwF9KYMaJLCSoJ2NSQ30xXnnafhVgqfgEZoFTknM=;
  b=aNUHelSoADKYifu/WBZwOej2usrL7nm85IDDzWhDH2fpTtDeIBMhy3DJ
   7t6D0tlPlcDkdyOz7HyZZW/gea0ore+iXRoNVhL8yVe/Yb7ucq6Mwmaax
   WgSTl8DBVhrRr5B+eOBN/FnfR46m0z3ICmDwGpVYiJxOtGr0izTY3fI1/
   jRsuQKno668irqqZ4cDCPtHwrT5qHUEslSuu6n7kuIldBoCb7i+hrP0wH
   bl+uL9vnDCBv9hyX1WWLzV95vjNzFKyIEIkDqLJj5XA44TGzucGN20we8
   V4Er3pOYTkvwD7hrMLGt80mmLDuuVJ29CNHFTJVuaKtQVGZqIRHz/EgGS
   Q==;
X-CSE-ConnectionGUID: rz5goQvvS9+uSZvLdSIJ4Q==
X-CSE-MsgGUID: NpPnYlgGRd+PkM/QCBhBPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46919283"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46919283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 13:14:26 -0700
X-CSE-ConnectionGUID: xeFhavaQQpC4U3HJJV+DZw==
X-CSE-MsgGUID: qetd+CkGRY2xvkXcxKSPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80810391"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 13:14:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 13:14:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 13:14:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 13:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jphe2kv/2BeSW6YYXPtbefOD75oayWQisVZkHHU79AI3ijSg6iw3Wjn94IPoArV2aBNN9qtk6WlWtnHZLAwPFeCsCdR8T2nah49Ftgw5sVLVLtTWu3h2ERpqQrOLG1l681r6Dlrtn6wy2/OTX7bB6NCCZ8A0nbMP50SyKdJpd+hi4CGbsYzaczlCv7htgXPieySrRPS3M90kX4zo9S/PODiAYCnDCar6QnhhC1VnGg0rDIY97BBs48PlsPB4wtErVhBV/QuVVxSTMdmh/eSw7viEZnZTqMmqt17pjOOco52oePdRmbmrSqKMfzjdAXy5HN0UJiyCwPvQWNQo0xzWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DQSBbJX9X95bk59ILjzCTBknRM832EixhNfP2R2s7g=;
 b=AmQNaR3NM0cUn9mcxxKrSX+cbY56qx4+7n9lMugEpLVgOb7bzenuMRmK9Qtab0uPW8A01bFxzbVgLViuWh0QhUtqv0VDdcvZ39doWwM80E8OMIyp1cMcUVxH4DiqxyfN+wc4Vuzk+dBzA+AUCoCLleSKPaPJgW86owg6M5ENUe58PmEKMQdEOFZPSs+qjJTrJ5yVz7K3XUr25aSq9QVYidFVUsK3jHIqHkkB1JyxrsKpZmP0n8E21HXKgcNQbsywPhe5fGdTi5dfLyZmAZ+UMFNRvc4Mx46BYoHgymhkPV1kkzL5obMAM4z/JuuPoJHGd8EKj8baXGOCW+l3cPEgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 20:14:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 20:14:22 +0000
Message-ID: <80c591f0-ce17-4a58-9749-ed66f14ecc6c@intel.com>
Date: Thu, 24 Oct 2024 13:14:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Vladimir Oltean <olteanv@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
 <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
 <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
 <20241019122018.rvlqgf2ri6q4znlr@skbuf>
 <7492148c-6edd-4400-8fa8-e30209cca168@intel.com>
 <20241024134902.xe7kd4t7yoy2i4xj@skbuf>
 <38f27382-3c6d-4677-9d59-4d08104f1131@intel.com>
Content-Language: en-US
In-Reply-To: <38f27382-3c6d-4677-9d59-4d08104f1131@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:303:8f::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: ec859ad9-028c-46d2-046b-08dcf46872f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUc4cjB2bFVVUXoxMGllZXlMR2N6OE5jOVJ3QkZ2RlhQS1RpQU9BZ21DVG1l?=
 =?utf-8?B?TnRRZjVOemlOdWFlVUlRVFhUWTRsNHF5WWlSSzlLVE9EWUtZdTAwNFpKQTBm?=
 =?utf-8?B?WGhHWXZWcTVTT29vREduaFNJQWFDMVlad0F6bmY1aTFvaFY5RWJNd2Y0YVI2?=
 =?utf-8?B?cDBHMS9DcnAwVGFpS0xkYTJvWTdObWNZYVVpemdPT0hhYjhoemRVUFU1cHlM?=
 =?utf-8?B?b3U0eFpLKzVielh1OEZOdGVVWUNDUkZ1YkZYWGVPWEpPQzQ0eHNGdXBzZjZU?=
 =?utf-8?B?ZTNTZWVtMDlDbFNybFkzRzNFOTZqNDZNbllHNkt0MTFON1RvQWVXb0RZOFF1?=
 =?utf-8?B?WVFWWnVUelJZdnFpbExra0ViQ2FlVTJCamgyKzdIRUtrRnVMSzkwRHFRZjJP?=
 =?utf-8?B?WUdRK3Z2TTJ5TFgrcDI0b1FDc1JWVVdOUERSbkVXWmNMSktjUEliZlhUTjY3?=
 =?utf-8?B?MTFFQ3djdHdWK2FTcDFkTTlFYlhhWkt1QnJ1R2Q2dnR4UXVPVVQ3Y2VTYmNF?=
 =?utf-8?B?U0dkUjU4MUpGYmN1M3FTd0VRcGpHcllEZXVTeE05UkZxbnFpWlBpbzVJY1Z0?=
 =?utf-8?B?YnFwWlIzblovK1l0Vk5nSVZiQlpFL2dtZDlJK0krQ1IvbGZkcHphR2tBOEM2?=
 =?utf-8?B?YnoxbExxMENkdDhqZzB2L2Vzc0JHYUJ1ditHTjhwK0pMdEl1TytGN1kxQUU4?=
 =?utf-8?B?TERUVEV0T25WdVYxR1lhT2hHV0E4SzR4NEhKdFRuNWNtbStBaW9LSXVmVUxs?=
 =?utf-8?B?UTV0aHljS1Zxa0JKSlhjcnpBVWRBT29xbmZoWi9NY25YUW1Pejh6MnIxOVJw?=
 =?utf-8?B?UTd1ZENaYkNrZ1BzQWwvSDVEYmJDMUhWdFlMVmdyMnZIenV4Uy9GNHdqYWRp?=
 =?utf-8?B?Z3hQZVlWbGUzOXFPTFdDa2UzSjRnRnNxWXp5aE9oa2MxSkdjNGl3eHRLSDk5?=
 =?utf-8?B?cUw2Sm9LZTJBaTZ6QjJ5U3J2V1pJWk5ZRlhkR0dNT0NzS0w1by9sMjdzVUVU?=
 =?utf-8?B?ZUsraVFYQ05jcnhWVmEzUmxYZ2NqYm1SMk9KWVVXTlJuTDFFTXBMTUEwejhP?=
 =?utf-8?B?T0ZCeGdhVVBlT05FNUpDZit3ZTczQkFGMHV6V25qZ0FkRTh1S1JURkhBZzBP?=
 =?utf-8?B?WnZ2K2pqZ01oRFZpMEhkem8vbjEwN3Y4Yk1meGdrZ3ZaQnBnVXBjZHRNemU5?=
 =?utf-8?B?SGJRUzN2cG5JOWF3WUhrQW8vZGJ4VEFWejZOdk45Ym9Gb2lpcVVYekYxdm1W?=
 =?utf-8?B?ZitYTlhXMXZCZTlMU09DRDFMRWZiOTZjZXRsa2hWV1JnbHRrNkx2KzBSRUU4?=
 =?utf-8?B?RXgwU1JOMWxpejByZ3ZrWGpWZU4zcFdMSzNVRUwyaHRWb0lZY21Qak93Vk90?=
 =?utf-8?B?RGhkSUhhL1l5SThDMTFtK0tpSVZTNkNvRU1lR0xUd3A0UmxYaDJ3Nk10dTJi?=
 =?utf-8?B?ZzNFTS8zWHh6cVJvamlaQjRjcHVPMXNmRjZnYUx0YlozV2hZeWRFbHdCUEdt?=
 =?utf-8?B?aWN4d1Y0bWgwRllXT3ZyWFZ4TnR0bmRpVkRVNXNyRCtRcW5qMmtTTUdqNXVJ?=
 =?utf-8?B?bzJhU0cvNUw1T200ZzZKL1I5eFlITndzckdOb1N3RDBZMVlSTHpZS1FobVpM?=
 =?utf-8?B?MC83ZUR6T0RLUFh6NTl1VFlHYXFWT1JPS3FTSkp1cjgvdFpKRFozTkxUTXhp?=
 =?utf-8?B?VTQ0M0h5QkJQazlLcVlmZkQra3lsMUs3SVJZZGkzWU5mMUdmRmk1azZIRDNB?=
 =?utf-8?Q?RgrWy1gRIautPQ49qPAY5ING4dbcg/N1/yhw6re?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxqeDV1QnVjbmh6ZTdibG1vTktwYjVNb0M3dUM5cFVSaHRKTGNBdXBOY0FT?=
 =?utf-8?B?T0JES0xLVUpMSXVEU2tWZWFJUlZpUzFsZC8yd2dtNU0vWjRsK2VNTFlwQllw?=
 =?utf-8?B?VG1YWmtMVWV0eDNQOVd1U0g3azBpWU10WThwMzk3UnNKaVNsOWlHME9RVWZB?=
 =?utf-8?B?cE0yUUtnUjhkNkVQZXREZlFtL3YveXhIZURyWGdrV3VGQkMrcWlxeFdLbmh6?=
 =?utf-8?B?OTYwdXhGZkswWmFhb2ZjTFpWaC9Tb0U2alMrcGV0K0R1cSsyWHhOZlF0RGNs?=
 =?utf-8?B?MnZUMEczWjdrWmZBb2NRaFhHNldvQU8vVStKeGlSb0ZuczB5NWRjRHJWVzdt?=
 =?utf-8?B?WnVWMWw2R1kzSUlXQ0doSG9UNnN5NnhkRjVtUXRuRGR1bjNoK2xNZ2FMcHJ0?=
 =?utf-8?B?dXYxQmo1V1Voa1NDWkJlQ0QzbEFDUGRPRXcrc2RhRkxwQU5XS2F3UHpUdm5D?=
 =?utf-8?B?MWlxNUErSVZ5aDhiaWVGUWdzWlpYYk5LZFBKMHkrRkltUm5RbUtYUXcrZHhz?=
 =?utf-8?B?and5cXNYSXlENHJ0NkJJK3JReXRZNFVWNXorTUR0S0MxcjVRVE5LdVBNRldC?=
 =?utf-8?B?dFJuSkx0SmY0MUh6MDlhS1hYWFludGN2cE44SDQ2dFRuVDQ3UFQwQVVMVEFW?=
 =?utf-8?B?aVdwWm14L1pnSnlEei91YXQxR0IwamhMR0NhdldFV2ZkSG95Z3gvMWlqcXVx?=
 =?utf-8?B?WjR0TzRUNmFCYksyTit5aHNwMlViZTJxeXhzaTltN2VKV3F4ZHluUEtkY2p0?=
 =?utf-8?B?aXpDTElCbXQ4TGcvT0VEZVM2UzN2ZE55OWNRaGRXRG5kbmFLbFYwRTFwNDBD?=
 =?utf-8?B?bDY2dGVVanU2Mzh2K0VCcmw1OE1SQllEdEtjd0g4cS85UWN1bGlPU1Y2Ukhr?=
 =?utf-8?B?aXJtZjhHbnYxbllMMUdCektlUjl6VXBkL2dUWVZHVmxnU3U5eHpIOHJKZDNi?=
 =?utf-8?B?b1M3Mmkrb2NIWGthaVZscEQrKzY3aGlZb1YwT2NRSXRTeEkzOW9xQnNsclhk?=
 =?utf-8?B?TEpJUk5VdThtTDlub0lweDBGRVVEdkZRaGVETWFVcjk2MkliTnBDenFMRFdL?=
 =?utf-8?B?Nm9mUjNIL25qN2VsbmFqcFZsTFg2SkE5V3NFMTFaYWl3bFFlemZodXdHTFdF?=
 =?utf-8?B?QkNMZ1JWK3FGNlBEZDc2a2ZCMmZHOVFrZ21QNjRGYW9uMzJhK3Z5aUN6NEtT?=
 =?utf-8?B?SU1IbVdFVFhXWEI3c0FmUG5rdVJ0ZGgyd2VXWThCNWM5ZzFpZTdUcnBjSXda?=
 =?utf-8?B?eS9mcUhGTUIvWGsvSy9lZVhUcnp0VUlOMTRha0luSUxXcnFva3ZWOVJnRXNn?=
 =?utf-8?B?czE1UTA3dFV6d0drM3JZSUJLR2E0aFl4RzlRVjR4bjI3cE5sZVZxUEQzTmJq?=
 =?utf-8?B?aXNQN2lMT0JJWVFMczlGTkJubnlGQ0tqdllJVG8vMm5zREhPMjJhSU9SUi9Y?=
 =?utf-8?B?YnFVNjIwTGluajVsOVF5cXVUL2tIWGgyVmRoZDYyTVBMVm9vQVVWdjlMeFNF?=
 =?utf-8?B?QnpSRXhxUEk4MWhiS3N6c1ozZXhTTXNNZkJtVTljOVNranZCd0kySHRrZDI1?=
 =?utf-8?B?MW5zRWlGUE43VmtJOVlIMDkwK2pta29qQ21jbnQ1eVptSmk2REl6NDhaUW0r?=
 =?utf-8?B?bmNsVE0wckdPeWtxR0NpR1o3OHpRblZqY0cvYVZUVXBLYnA3Und2Ym1XemtJ?=
 =?utf-8?B?T1pkdjl2ZVhwNERzdHBOYjhSaHVlSEh3Nk11WE1FSWsxeVphRHRBNll6UjBv?=
 =?utf-8?B?aXd6RnNwcXhwUWZBVE5YZUdsWnJ0aEtsV1pwOXJ6SkpmcGpNVEtyOHRBMGxG?=
 =?utf-8?B?UEJEVHJxT2RodkNvUy85bGJkZEpMUHMzN0M5cFdqclgrNlVQZ2VtSUpSTHI4?=
 =?utf-8?B?RjVlWkVXUWpWYlQrYjZTWkJ1N3prdXdzWkgvQ0JOR2k5L1Y0eS9SNUVySDlk?=
 =?utf-8?B?dG95aEZidHY4ejNPOVJuamYycHgxQ2ZrbDc3OGdEK1ZlRlh6VmVta0F5TnRa?=
 =?utf-8?B?V0pkUDNrQnJDZ01nS0h0WXpIc2VqVkhma2tHZHNBTkd2S2dQeGUxamJtSG1C?=
 =?utf-8?B?WDY3RXEwT0pkbzZncy84V3N2eDlhUktFM29uVXVZWGJIS1hhRFlZQVdJK0d0?=
 =?utf-8?B?TEE3MFNMQitEQmtYaXNGdzJMRzUrOWdaclNlY21OclpLd2ZZM3FXR0pzZ01a?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec859ad9-028c-46d2-046b-08dcf46872f2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:14:22.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYCjqDgk8p4p6PW6H73zG2ERWHTMETqdGX8yJHrt/bfuHqCtdsv5HXUQ71NH9Bro7IzY1GjwxHECqEuIPFp34CPFhpfWEt5gJwXc4BdOXCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-OriginatorOrg: intel.com



On 10/24/2024 9:38 AM, Jacob Keller wrote:
> I also have some thought about trying to catch this in a coccinelle
> script. That has the trade-off that its only caught by running the
> spatch/coccinelle scripts, but it would completely eliminate the need to
> modify Kbuild at all.
> 
> I'm going to try and experiment with that direction and see if its feasible.
> 

Coccinelle can't handle all of the relevant checks, since it does not
parse the macros, and can only look at the uncompiled code.

I'll have a v2 out soon with Vladimir's suggested approach.

Thanks,
Jake

