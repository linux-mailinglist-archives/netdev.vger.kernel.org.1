Return-Path: <netdev+bounces-236407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B5C3BEF9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473B1188663D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682363431EC;
	Thu,  6 Nov 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF562P+H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0A303C81
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441032; cv=fail; b=rOyev6xpMhDJ4BCPdEgdKgMlZHztb4hdriSfE6h7prz7CZKLB2MoKJRSnxLN2tufB9lNrmF3JZY+EO7vbmGnS4Ey3tHtSjmQVACjEOJwu0fQIWGH3J2JcHD5kIaQhxMJbTnaZv3GgbAyO2gwv16uqOSbllebJ2WuM3F56jgDLpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441032; c=relaxed/simple;
	bh=zqlp/w/j4XT5NvLCjA4Wangc4IfEImbj1e6zRkWp3Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C81bs/mkWvunH84Ym+U0Bb5+4yco/8HSbB7rl1MvCbK2IednPcfAD8P/421ktPqGDd593dyEu91WDNUsNzy6YvKU7XPocYlEGpqea4n9I+xnmoat2CJEkKkUV4DSq6+E6IlN6ZJiThdn7a2iCtvoyu1fMul+SZBE4FDPVpmxxiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF562P+H; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762441030; x=1793977030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zqlp/w/j4XT5NvLCjA4Wangc4IfEImbj1e6zRkWp3Nk=;
  b=ZF562P+H5LqldEzZoLJZl7Mx/rn4udNfEgAvmqbGkMSLH62VQ2snYDS3
   zhVzkOMck0+7PkLEUCs5tZYGNWM4bZL7HPhtU+MTDYVw48f1RMXtgGJ41
   wr9cF02KxsRxPZ2ScSECXLmIAH57KM3ONatRmup+PAbeuQKqH8ntxesvu
   3sWpeHLc8zwvGzQYXqWMj9mT0PZMLfRVz6EynMzfWpJKS3zdymBIwveg3
   9ALWR/2lcxyuooYcN6i/lffhB+O7X3pwWbJr0HNUB6ol0b97mgCubSq8E
   FeD9L4sZgmeWpQEalGEiYgU9mJw2gZ7ffIm+x3C1gax1Rr4GTXHzVpV6i
   g==;
X-CSE-ConnectionGUID: gs14P6mKRZ2JaLVbAwcX7A==
X-CSE-MsgGUID: Ij1PgeaVTvG1yUouZzdq6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52145501"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="52145501"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:57:08 -0800
X-CSE-ConnectionGUID: DIaU1pNURhelk5C1gcbK6w==
X-CSE-MsgGUID: 9DSw2zy5RGeqIYGVtFlwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188218386"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:57:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 06:57:00 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 06:57:00 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 06:57:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMoxI+XrekOVkkaXps/P2cEDrFn9n3Em0KEj5DkC8cL1UzVWCmdmnnmLZQSbZXUFOPYNYwujmcOCZMG8bfUDmJKtUpr/KivAeAZBkTYwU9U96QlSjtzZw3Ve0vXi+0OpLDWsOtmZYKQOTa+69J5O8xwxnIWyWHgQG7kXGud1V1xKJeRUL7nGlXgE+af12VsjZ1S+EBDlnVNdsfsndm9KVx/FzubnNX5fLc8X5j9UdV2X4//8AF4ccnDRmRyMS1+vVNdyNarGaqr3qNMlxHanvP3zjJRBBOHIb3AIOMdjhCG6mNHpM2mVPGnn6Eeq8yBlc1K3XOQaRjqxZ2wUjt35Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqlp/w/j4XT5NvLCjA4Wangc4IfEImbj1e6zRkWp3Nk=;
 b=bk4ow417ACO0oODIswNncjvfvysG110NaDN3C6o3y+EY6OrqRnGGnl0N6S4IB6i89wfxzAdHjfPXD1DF1+s7tQi+MwSMkPEnx1IhJnbHhLRg++9kcdzCap1axZVCsm5Zd7zG1AJYLcepKimp3ZlEd+jWemvM+NUNcnmYhDhMTHOArkW/j1YuYTtEYS6AlXX5hqkrA2nASwh7EgHitSqTL8Jk9RhMRRk609Yjw9PhphDaednHMvnKVoBDHbaN8DmOxMCfcmNT1vAw+WZ1jhNTIaub8/J5Tu5Xl47eY0AoUwzRCwuilNlSveotoM6463J54U/NEycQwTht+M0PK7O7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:56:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:56:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 4/9] ice: move prev_pkt from ice_txq_stats to
 ice_tx_ring
Thread-Topic: [PATCH iwl-next v2 4/9] ice: move prev_pkt from ice_txq_stats to
 ice_tx_ring
Thread-Index: AQHcTpgvzTQPfWLtrUWp02Yo7zm2K7TlvdiQ
Date: Thu, 6 Nov 2025 14:56:56 +0000
Message-ID: <IA3PR11MB89862D2AABBDC895B6AB4CD6E5C2A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
 <20251105-jk-refactor-queue-stats-v2-4-8652557f9572@intel.com>
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-4-8652557f9572@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB5952:EE_
x-ms-office365-filtering-correlation-id: 27a4bc6a-6eab-41ac-1312-08de1d44bb47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?dkJXb1RiaWc3S0NRd2ZVTWl6UC9CcnZ1aElPclpmRytQNzNMcXp5NkQ5L0F4?=
 =?utf-8?B?MllzTnFDYzNEQS93V2dFUGxWVVJoNW9PTitEY2E4MWZ5cVJnTnhaQXhKN1Zp?=
 =?utf-8?B?TGlWN1MrVU5jK0krOTNqK3hkczBzaThrbjQyVzNhRzZrczBSbDZEZnRCOURz?=
 =?utf-8?B?U08wSGp4MjBWN1VLa0puWVczWHZuVXAzMlJTNityOWwwaGhxVm1TRTZpUHhi?=
 =?utf-8?B?N2FTeHR3dFdDS3BDeEdaSGl5YnpIUzdaVmpLTWRMZjVKV0tNU2cwbDFlOFRi?=
 =?utf-8?B?UFBTZEVYS0dpWHNmdTY0a3M3YTZVYVM2VzBQVTNlV1BDREsvQlhNbmJlOTNK?=
 =?utf-8?B?Mm5mTjZmL3hDenFsN3JtNTNuSFd4WVU3eHhqcWxhUWQ1Q3RNYzRGWHRJWE04?=
 =?utf-8?B?TGdRMDZKVW1nY2t4Ujh6UVMxNHhmTGhCNkErN3N5dFJLUFJpYk5tcjJjK3cx?=
 =?utf-8?B?d3lkMDRiSWI2amxzWTJ1eVkvTkdKM3RvZkNtaEpmSEl6cHFKWVA1UFlHZWlH?=
 =?utf-8?B?UHpOTjR4emY4NGoySFZXYUZVTkZSVVRBQ2Jvc2FtTEpYSmNDN1JIaUdrajBZ?=
 =?utf-8?B?TGNheHk1dXkrWEtERWRmSVE2ZDM3aEhaMWNVYUNvK2xYR0o2MGs4UW12Vyth?=
 =?utf-8?B?U3lxemQvUXF5b2ZSYmdlbTZUdDRjbEFvMm0xRklMSGM4SjdRcUJuL241QXR6?=
 =?utf-8?B?OGpFUTh4YTNqRUdVaDRCRSt3clhVZE9PSnNkQXhyOW43OFdJSE9QR1BPZlhN?=
 =?utf-8?B?L2FTVkdiM25iMkJHOHNjSSszQjlUK0pmRi9QMjE1NVJRYzVraFc4L1cyVTJI?=
 =?utf-8?B?bVVnMWE2clFwRTBnRFZoQjhtTzlGTjcxZ3hEMzFTWHQ0U3pDSWgrcHJ2R2tT?=
 =?utf-8?B?dkp1OVZ6WUIzTHhCZHNCZitWK1IyZFl1Z0plVnUxK3YyWWJtZDlXNDAzQ3lW?=
 =?utf-8?B?cmFHTGhwbEorYVRCMXU2NXVtUU0wM0t3dW4xbGpZSk52SDAzd3dGbjQzSjFw?=
 =?utf-8?B?Q0d6R3BtZzNWK2RmQVFRcURIOFpNQ0xodU4weFI1VGM5alA3VE9tejBRMCtl?=
 =?utf-8?B?dEd3NlFiclNOeUhpeWV1dGNPbUttUzRVcUVxRnhyNUc4K2dqMDdHak4raEhO?=
 =?utf-8?B?MW9VbG1tNlg5QzZ5cGhEVFZiRENKU1ZRUWhBRkpQZ2hmWjY3SmNxT3J0RUNP?=
 =?utf-8?B?aFNVaE4xZzNVdUJpYk1OMnNGc1A3dUUrVHdXZWgrVCtTd1FoM0Z3c2VGN0kz?=
 =?utf-8?B?emFZVWpOMmVmOE9jVHdBd2Vxdjd2YlplUUQ5bUN2OHNFUjhPMy9TV1d4UFhB?=
 =?utf-8?B?ZWlSeDlCQURBNnU4c3BXZlhQZXMzNkJxRWlacU80WmgxdmloZ2RIZTlYdVdM?=
 =?utf-8?B?cUNpUXdLY0dJOFRndFZUR0thWVd4MkV2NFQ3dDh2U05qTE1GVDJmWnMwaTN2?=
 =?utf-8?B?azJCcGFTRGU3Szl5K0dUZllSYzVPTXFjb3BDY0QvMWwrNC9KcldtOEE3OE0r?=
 =?utf-8?B?MmNWS1Q5RkMrWVdNTVBORUo2R1ZvTWRkTkh1b3pTNnBOUTJYaldTRis5c1A2?=
 =?utf-8?B?dWdmbWc1cGtZVmp5eW9YanBRTlp2TUVlczJ2MDZONjkxZ09tRXhLT2haVUhL?=
 =?utf-8?B?am54aE1yVzNZeUlhMkEzTGs2aFlRd0FDbWt2TFR3akRqaDNGMzRxbjNhemVp?=
 =?utf-8?B?a0dNUWVXRVZsMHR5T1JZSjdxL3VlcFhyTENGMGRXVnpDM0RTV21zalEwSmlH?=
 =?utf-8?B?MTVrb2xjTnY1VkRlYmtyOGZFSCtCcHdsMTJZYW56bmVYSE9TODRWWGp3dTdW?=
 =?utf-8?B?bjAvamdZQUlKcHM3ckJjTzNhQ0lvK1RKMFFnVElQWk4rK0xvRERTNE5Cb0NZ?=
 =?utf-8?B?Y2hyaERuTlF2Z3lkS3ErMzY3eTdreFg0Uzd2V0VoSEZwcHFSNWZEczYxTy9E?=
 =?utf-8?B?cHYyRXozRzBTc01PaXorMGQzMHN2d1MrZXhXL2crUFl5MWljekFyNDQvUnFE?=
 =?utf-8?B?Tm9Ea0xSbk1hYS94OVN3SGxYaTUvY1hGUytGY0RBMEdLWXRPSWJsYVJSTUtx?=
 =?utf-8?Q?vtSIUH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3d5UW5GYk1pZ0lWVEtMQWp0SDJxdlBKYmJ3Y3Z4R2lNZk1nNVI0eTVKODN4?=
 =?utf-8?B?bWt3eWRTeUF2WWV0VVdJU0lSQVBtQ2drTlJKZzRQTjR1TXpKZERCdEVZNnJX?=
 =?utf-8?B?Vjd1NmRpQk1tOC9YcWVQcmtxa3RvSWhyM0s2V0oyOVR4aHAyN1Uxc2RuM3hx?=
 =?utf-8?B?aExQMnhHeDNHNXptdzc3QkVTdWV4THV1cG51amxicTdFb1d0cUswanVNT0ZB?=
 =?utf-8?B?L0NJYkh1am83N1Nvc3NvL011bVZrc0FyT3VTMmV0VFgzQzBlRkdOUVFhZW1s?=
 =?utf-8?B?NWt6cWNEYnhGTFBkRHpUazZselZuMGx5S0JsekN6L000NW94amU5WTE3clJW?=
 =?utf-8?B?V1orWWY5cjFpeWozYXZ5Sis2R21YcS95bVd5QkhzWkFycjFUZ1JVV2dlc2xK?=
 =?utf-8?B?RHNsRVpsaUxwUG5SditSWkZiM3N5TGJRKzhrSWFEMWJBNzh0T1lUWjZWZEVj?=
 =?utf-8?B?bzl4K3RVeXdQOGtYUUVpcmszbUluTDF6MDVFNUJqUENTVkdVK3RRbTZZMW5Z?=
 =?utf-8?B?WlV5Q1FzanpPVUxScEw2SC9tTUt6MHQySTBRQVNBS1B6S0EzUTRpaVRxSlFZ?=
 =?utf-8?B?dFRVNUMzZ1VrS24zQlh0WXVEZzdLRWJXWDYvam9WYUZNYU9yQm9TV0NMdzB3?=
 =?utf-8?B?K3d2bW5rQTQ5cGRTMnRPbVU0b0c0L09OZk5IUzhDbDhCT04wdVZBL1BHcVpp?=
 =?utf-8?B?VDlJU3RaYkZRUmVnWGdVbDBIYmtaR0pOQ0ZoNzZoOG9uMzNuSHZCc3liVnll?=
 =?utf-8?B?NWtXeDErSE5uOExpcGJrcStaeExneE5hK2dzTkVjYWQ2SVVBSjFRYjVRNzJk?=
 =?utf-8?B?SGYwK1VFYllScjA3bnRMR2o2NFVqOHdjNDhaZ0M4eHB1OEVsSmdWWlVlOUtI?=
 =?utf-8?B?MlZxVGIyckZhN0RyN2RNWGN3MWYxQWhyTWh5QUF0dExYTDF5Tm1BUTVKUnFp?=
 =?utf-8?B?ZzNkNHhNSllmOFN2dWI0bW9uRFBUY2NOTkN4T3Zwc29QTTYrcXdTT1o5YXg5?=
 =?utf-8?B?Y0ptL0w3UFM2N3E5UW5pbEdWS29CeFR2YlBlSmxLc1EyOFVqVzdEb0pNYnpz?=
 =?utf-8?B?K3BjSEJZYURWeDcyd3d6V2Rqei9kekZsMG5iMEE0ei9sMGZxZjUwMUJocG50?=
 =?utf-8?B?WDEybjBhMEQvY3hXZkt0dWZ3cjlGZWRibU51QS9DRjFPMitTMGMwT21VV2Vj?=
 =?utf-8?B?V01OSlJWbHN5M28vYmppUXpSVklLSnl1S0ZiKzN4M3BaczkyWnJvOERWUWFp?=
 =?utf-8?B?QmlFdVRhMkcrMkI4WUlzUjFBR0NJbW9EYm04RXUwNVRPaGNYZUFlN2ZBL2xG?=
 =?utf-8?B?S3NZK0drQnhGbFFkamhud3JQQnRkTCs0U0NBajZVZWlHd3lKZFpQVEdWY1VS?=
 =?utf-8?B?akdndXV5U2NVOFErYlBrUmtLQkJKLzZ4TmxJazV3aVR2WGNIZkFDOVdJQTRW?=
 =?utf-8?B?cWZIbnFoSTZ3YzdMejFYWG5VNkFKRjVOeHlKZ2RoMWlWU2lrN1FiVVpJQlB0?=
 =?utf-8?B?OUlldDlmd04vWmh5TTFwWnMxRThZQmdWZU1aU1djVWVHdHF6ZHdVdWNnRXJK?=
 =?utf-8?B?Vm1UYjhBaG5XbXdZOFh4UlhUd3lpQ2lhTDZMUWhpSk83TUY3amNHVTFjb1Fj?=
 =?utf-8?B?Z0taQTBlZEZ6YjdKMm9nM2dZeHFhU2FWZDNsMTZUVVh0bmF1UXE5Z0hvZlpV?=
 =?utf-8?B?SUEydllQODRxektBWWovT3EzdzA0eFMyaHI5eG1WZnNFamI2c0htZ041bFp6?=
 =?utf-8?B?U0JMOHEvbDZveVAzMXZGM0p6VVl4cTZMckRSa1BEMHZ4MGNkd3p6TktpRnFx?=
 =?utf-8?B?MjVuSEpYd2RPVnBqQ3ZrWEVHUWlJeWNiMVpNZEF2OVpOdnd2VWtpdjVteHIv?=
 =?utf-8?B?eEFTQjl3MkpKMjdITDdKS3JjWTNZNWlTRlh1bzZWeDZGMk5kdTlVU3UwZm9y?=
 =?utf-8?B?N2x2djVXYktMYWJ2NFJhNVlYSXRtVkxvSHNNK1ZFWHZQK1Evci9hK3QwM3Jn?=
 =?utf-8?B?ZGRhdHVvQ0ZkR2lhUmc1MStlRUdDR3AwRWRua0x4cnNEQ1hHQW1XTC9YZTVk?=
 =?utf-8?B?ck5NTjNLcVVVeS9hYTErejM3bm9MenVjVWZ4c3ZuT1d3ZG01NlkyWEllQWpi?=
 =?utf-8?B?aFVzSWl2dG0weDhkMTFQSkl3L0hPN1NFVDZTNXVFcGorcHh6aTh5bnJ0SlpF?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a4bc6a-6eab-41ac-1312-08de1d44bb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 14:56:57.0110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9oby9XDf8dNcPA33QmJsoELPhPpEBRkYdHUhUksno0XG0KYk4pMpaQ0MiuyphwL7g8rkoef9OU1x70hyOfDqRPkrOZ926x3StLGUB7o4rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
NSwgMjAyNSAxMDowNyBQTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5s
b2t0aW9ub3ZAaW50ZWwuY29tPjsgTG9iYWtpbiwNCj4gQWxla3NhbmRlciA8YWxla3NhbmRlci5s
b2Jha2luQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVu
QGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBp
bnRlbC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgS2VsbGVyLA0KPiBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV4dCB2MiA0LzldIGljZTogbW92ZSBwcmV2
X3BrdCBmcm9tIGljZV90eHFfc3RhdHMNCj4gdG8gaWNlX3R4X3JpbmcNCj4gDQo+IFRoZSBwcmV2
X3BrdCBmaWVsZCBpbiBpY2VfdHhxX3N0YXRzIGlzIHVzZWQgYnkNCj4gaWNlX2NoZWNrX2Zvcl9o
dW5nX3N1YnRhc2sgYXMgYSB3YXkgdG8gZGV0ZWN0IHBvdGVudGlhbCBUeCBoYW5ncyBkdWUNCj4g
dG8gbWlzc2VkIGludGVycnVwdHMuDQo+IA0KPiBUaGUgdmFsdWUgaXMgYmFzZWQgb24gdGhlIHBh
Y2tldCBjb3VudCwgYnV0IGl0cyBhbiBpbnQgYW5kIG5vdCByZWFsbHkNCj4gYSAic3RhdGlzdGlj
Ii4gVGhlIHZhbHVlIGlzIHNpZ25lZCBzbyB0aGF0IHdlIGNhbiB1c2UgLTEgYXMgYSAibm8gd29y
aw0KPiBwZW5kaW5nIiB2YWx1ZS4gQSBmb2xsb3dpbmcgY2hhbmdlIGlzIGdvaW5nIHRvIHJlZmFj
dG9yIHRoZSBzdGF0cyB0bw0KPiBhbGwgdXNlIHRoZSB1NjRfc3RhdF90IHR5cGUgYW5kIGFjY2Vz
c29yIGZ1bmN0aW9ucy4gTGVhdmluZyBwcmV2X3BrdA0KPiBhcyB0aGUgbG9uZSBpbnQgZmVlbHMg
YSBiaXQgc3RyYW5nZS4NCj4gDQo+IEluc3RlYWQsIG1vdmUgaXQgb3V0IG9mIGljZV90eHFfc3Rh
dHMgYW5kIHBsYWNlIGl0IGluIHRoZSBpY2VfdHhfcmluZy4NCj4gV2UgaGF2ZSA4IGJ5dGVzIHN0
aWxsIGF2YWlsYWJsZSBpbiB0aGUgM3JkIGNhY2hlbGluZSwgc28gdGhpcyBtb3ZlDQo+IHNhdmVz
IGEgc21hbGwgYW1vdW50IG9mIG1lbW9yeS4gSXQgYWxzbyBzaG91bGRuJ3QgaW1wYWN0IHRoZSBU
eCBwYXRoDQo+IGhlYXZpbHkgc2luY2UgaXRzIG9ubHkgYWNjZXNzZWQgZHVyaW5nIGluaXRpYWxp
emF0aW9uIGFuZCB0aGUgaGFuZw0KPiBzdWJ0YXNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFj
b2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KDQouLi4NCiANCj4g
LS0NCj4gMi41MS4wLnJjMS4xOTcuZzZkOTc1ZTk1YzlkNw0KDQoNClJldmlld2VkLWJ5OiBBbGVr
c2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

