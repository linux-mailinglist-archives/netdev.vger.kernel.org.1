Return-Path: <netdev+bounces-208633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87028B0C725
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C6516567C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2919DF5F;
	Mon, 21 Jul 2025 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7kfufbf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0561632DF
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110094; cv=fail; b=Fi/JdYMzMSJfen4KXeuZruFWQ9CkfoZB86EFJrm3FCYSE4MvOxYgy7Y0BSEaAKU0mzw06uTY8XSOXPcc7KTp8YsKJm1tppX+8HJatRxGQrATrrc1QhI5m2yuCS82xwhKTk0cokT1ZIFVCzYdPs3wD1FaIyqIRErGZuXSGwEHGmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110094; c=relaxed/simple;
	bh=2UaxsEeb3SB1BK1Z+o3kUyilm3SVP/wePzevON61JFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nIpTIURoxmay022UbKhbTWWMHdQ41MVDvzjSshbYAOCqbGoyr2aK2G93pQWYkv42BtWsYxxYMCnBKJT8wxoAhZZRSfei31a9bp/uat3GKDI3C6G44jyZMJgULMkMmVQXXHHCZgGOluBgHdQZBPu9a0Iy6XJ+5ZMRzb2XwvUS8VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7kfufbf; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753110092; x=1784646092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2UaxsEeb3SB1BK1Z+o3kUyilm3SVP/wePzevON61JFk=;
  b=h7kfufbfuVjl5YIMpfqlyR0Ht7E9emOf4IcGEgyAUEexk/tLCnnATOjg
   7/02inLdu3Jst6Hgq+QzawimiTcBhdPFNUoXlm9ScbaNPqhP/WHKpB/KO
   MtTgZR8KL1ipZy4kHcSKTdtw53kLiuPfMIKqPlyqI8z1qAh/QqYnoX72z
   n4aJv68tz6TCqQ8Jee565MZIZTrl8Kgf+6lIBK5BeIz51Liw8PcBNdKm1
   N4dLHsMLR3dEaEqNgyPICa1z43kPjmYLBO+w8js4OcmAabyPafNmCA5MF
   qAsvnvqbhC/H7z2iXd0FadKGTFpHsGz28rofkTZjr1sJWhdJwZ/UkfU9a
   w==;
X-CSE-ConnectionGUID: hKEcU8miTmu9qfbz6UXnzg==
X-CSE-MsgGUID: CRFZKDJkRwqd0vgN1MNfdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="80771330"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="80771330"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:01:32 -0700
X-CSE-ConnectionGUID: wnTCBnfnTguPWhBUQ1mnMg==
X-CSE-MsgGUID: AXDoQaSvRA2PIcf1qlb11w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="163159618"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:01:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 08:01:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 08:01:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 08:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUPRvyYZL47U7L+TFeGWMGjjDd/qJUo2esstfN4hrv5KnI167t7ED47yOst2kuwej04PUzPqniKSUaK1S20YQWe8/yktyUbIXI1yM9TzPYMdUCgrhDHsA559weyX64QYKTL0YlzvgKTHa/1M3IjURr0HZWmiOz8f+kwkvplYiRtV6fl42gHQamE2g/Gerk05EXNPh+k4vKxbp/Y0XbU+Sw4l4aQ5GJ2H+Ru6AiWaYkVk3IIenucTt5ro4mwy1hUgGdqQXpGfHOheYM278mu+oXGxdGTZ+VZ23A8FRGBKg13sRcgTFn46mIpmlUOEOUO678+8LFvCmr74rL79kX3kUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UaxsEeb3SB1BK1Z+o3kUyilm3SVP/wePzevON61JFk=;
 b=eQAM5QhgQOvd8d7fiwKfQ2EVal2FF+dNuFXQdKYVpJ4zlmQFoc2WHf1xXtkIDRdvp/TRyatzeawXBQMfCZuh5s0T2kWi8yABn2MhMv/Dl82ltzlekbgmxyReunCnbSvTcgeTDTQHryVDW4cVtWme5h+IvAW4kTN5FXuwwNJ0CWTqcAq5vt4JE2XoLWCk6gHRusFHlZumiQhmwCUjleGuPgGMi/gJCW1IyeEOOv1w7oce7opvNlt5yP1ppGKIb/uqjdg2g+ws85ZYg5ePb6T1XiffaSotnlMQtnolaDnlZC5IKaaEDzydDzYdMFvdNBHn2otgmu9IMhCjOplj/gBQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW6PR11MB8410.namprd11.prod.outlook.com (2603:10b6:303:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Mon, 21 Jul
 2025 15:00:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 15:00:23 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "Grinberg, Vitaly" <vgrinber@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-net 1/2] ice: fix double-call to ice_deinit_hw()
 during probe failure
Thread-Topic: [PATCH iwl-net 1/2] ice: fix double-call to ice_deinit_hw()
 during probe failure
Thread-Index: AQHb9zvvdyiY4kgBbkusKFJPLTbJzLQ8scLw
Date: Mon, 21 Jul 2025 15:00:23 +0000
Message-ID: <IA3PR11MB8986384371A15DDD2A279F86E55DA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250717-jk-ddp-safe-mode-issue-v1-0-e113b2baed79@intel.com>
 <20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com>
In-Reply-To: <20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW6PR11MB8410:EE_
x-ms-office365-filtering-correlation-id: 0039be3b-0222-43d3-8b49-08ddc867518a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WjNXVGdicEQ2NVpVWWRYUlMyN2lxRG9HVnpEQ0ROKythU2w5TEJrbi9CNHF3?=
 =?utf-8?B?ZldSdTk4S3d5T1YweGZhYXZUalg0UG5qSFdnMUNkRmFET29iSktTU0NERzYx?=
 =?utf-8?B?azI4Ym8xemp6eWhKVTBPaDg4VVVFY2p1V21lVDlndmRLVU9rT1ltOUNHcUdL?=
 =?utf-8?B?STYyYmZDajQ2SndjRzN3WHA0ZzJSWkFzYkFOeHNnTTFRS214SlE2TjRiVExo?=
 =?utf-8?B?NUJucEZEOEw2cG0wc2ppOWk0TFJTZXRtTnJVTEFzRGoxRXJyQzJkZk13U1M3?=
 =?utf-8?B?VldRdDBRSDN1SkN6NGdZNDRvZlFlTXJGT0wwQ3RLTU9tRnBXc2dNbGI3dlFs?=
 =?utf-8?B?OWx4bC9hanptK28zbXRXL296MEQrVGtYcHlOV202emNRYm1xdUhjd0xoQ3Ra?=
 =?utf-8?B?SXhqZ2JRd1pwTE5USWt2TnltZXE4S3FQcDlmcm1TZ2tRUDFBUDRveXpGTUxa?=
 =?utf-8?B?VEJTN2FSdTNndVYzTVEwWEExN0ZIaXl2YWpBOGZidlNNbnMvVW94bjZLaG5R?=
 =?utf-8?B?R0hiZWFiRmNWazk3MWg3cSs4cXg1Sllib2VINk9acE0zZlF4NHFEZGR6elRZ?=
 =?utf-8?B?Qzkzbm0vVmFDZHZidlFsZzVUWUVZbk04Y3ErRjRWRWdBQW5reWtDNlR2R2Uz?=
 =?utf-8?B?cDh2SW5FK2NTZG1VbWVLdkRSZ3c1R09HbUlGRXZvdGxPbUNtTGx5VjlqTHhU?=
 =?utf-8?B?ZGlvWFZndy9FNmJweXdaMUI3K0c5ZDNGUEpxem9iWHNVVkJjL1pHQi9VMGxT?=
 =?utf-8?B?a2pka1lxRUJIMkpJTEI4alVGYkRIYnV6clU2RklOWkQ0THZqanNZNzBFOVZq?=
 =?utf-8?B?dStUcFBrWTVuTUl2QTJMTitIbjRaMkhDOXMxVENIL0VMMDREMTRDTkhzOEJT?=
 =?utf-8?B?MENOTXRqNHlvWkZsU0JkV3M4ekY3YzJ6RUxjL1k4akNZRnoydmg2bi9hSTlX?=
 =?utf-8?B?M0t6aDgvY2FZay81WHJGWjNuQmZiQ2I4cGxUTWRKM2VyMUY5SHVueG5TRVVK?=
 =?utf-8?B?aWlKRmN0YW1seFFEbk5JMlRpWFhPZWFtYXZabEpyeVd2SHBZL3RBdml4OFcz?=
 =?utf-8?B?THVJL3hPNGlzaGVqRjBNR2JOYzJkaVdxckNMWGhibUxFZlprdVVHeEVMMkNo?=
 =?utf-8?B?OE5rMitwTW51UkkvUStnYUJKWlpiMEVneW90T3ZmVDR2WEQzaWZHN3VPUXQr?=
 =?utf-8?B?Sk01dmFWRFJWYTV5dG11ODFCZkpscGhSeEZ1QzdkN0NiWC9YUDNMTU1xTStt?=
 =?utf-8?B?dEN4MVFVU0xMcTl1TlI4Y0gwTE1RSkZRZGRvMHpOU1N6dFdUUU50R3JucEtn?=
 =?utf-8?B?ZTMyTVFQWDFSOUhPSXl4anN6bUpvb1UvOVF2U2w4azV0cUFENEZwNHMyaVIy?=
 =?utf-8?B?NDlhSkk3cDQyeG5rTzJMeU5vSEtQQU5ETWcyWXlOQ3FEQXFOR1Z5aGNwQWxo?=
 =?utf-8?B?UERoa0JFb2VNY281NzlXbWtTcW4vT1FoaDNkT29tTzRjTStma2JzUTFrUDQx?=
 =?utf-8?B?Zm1RUm9TK3U1SEV1Q2RTdWJyd2xKR1lBa3NtMkhtZlh3SXpGeCtrWWoyZnIx?=
 =?utf-8?B?VFBkWEM4NW0wTjQvWjBESnhySWRuYjhSMmFLbmVqd2V2QnNXbEN4SEhCTVg4?=
 =?utf-8?B?eW1DdzhOdzRxSWxYNE5kV1A4em1qWnNSUGlXMlJnTUl5TWFyS244MUowZnRR?=
 =?utf-8?B?bUV5bHRpTUVGbTk0U0Z3R0hweDRJQy83WG5FY3dqcmUyTUNqNmdVZTZ2UTVK?=
 =?utf-8?B?WC8zcElsc0tvOXhRN1dOMHlMdldmQWY0R3RxZ1owN3JkWER0TTEvY3c4RmFX?=
 =?utf-8?B?WkJqVDJmQXFkSWpQTU9OVzBPUWp0YXR6eVVKRDRLZjJSdlNNMm1IZldqMDFu?=
 =?utf-8?B?aWFnNlpRTTNtWUdCa1hEd1Y0L2RwZE9XYXFkM0lMcCtiZ1RHakZGUWh6YlFq?=
 =?utf-8?B?M1ZMbGxOa3hlL3Z1eGpsMW85MGN3RjZCR29kbTFaL3JtWEhobjF1ZlQ5SFNN?=
 =?utf-8?Q?JznP4Mi68nHDQBEkdhwARIZ52oYw6A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJBN25FVVp4UjhtRVBtbVorVFk4eDRnUEUrNURSZk84dng0UGpLdGV0UjZD?=
 =?utf-8?B?UkFJeUVaUkhIYnhudEdYbENKcllkYm5rbUhLMHdsK3J1K1dvanVmQTVLRGh6?=
 =?utf-8?B?bDk2ZHk1UDVYNWpQaUZ4UWMvSWV6amJEQncyalp5eWZWMUJlcWE3UFlPZnp5?=
 =?utf-8?B?VnN1WHR2UStaN09aNTFiTmdIRWhRWlcyTXZBMW5DeXo3NDJaTHdRQzhTM3oy?=
 =?utf-8?B?aThrZlh3MzZDRW1mc2lnTS9JeFNZMytYNndHdkxrQ0I0SUpDRC9kRC9DMkE4?=
 =?utf-8?B?NmdCM1NKYVhqQnVoajIxVkkxNEIrOStJME95RnVxaWxlZDJrd2hPOEhMN0Fm?=
 =?utf-8?B?ZkRpMU56R3ZSZWdjbnlsbEhpZ2w0RTZzaCtEekc1ZXhERm9OcVQreGQrOHRk?=
 =?utf-8?B?elBUeWxVaTh2RFZTU0xJVHlxZHI0MUZsd0tmRHQyYmY3UmllZmF4L3VXOFVP?=
 =?utf-8?B?RHhGUXV6U2h5UFM1Z3VydzBrRWdabEpCeE5rbkVIb1ZkZnhqdjZuYk11UTVK?=
 =?utf-8?B?RWw1c01OTVpoZWU0Y1JEL2paVkk3NFFHbjFraXFRNm51cllmcS9xcVhZVlhs?=
 =?utf-8?B?TkVRZm9nNFBlWjh0ei9UNlg5VGlFVVQyblF2eXBLWFcwRjZvOEpGeFVMcS9l?=
 =?utf-8?B?b3Y3WTFBcWxDSnBtYndnY0VtZWdKTk1SeE5pYkNCd1NKalh4am9SSHM2ZlRI?=
 =?utf-8?B?RlI4Mi9YblplSEtvL3hHZ01VQklaL0gzOTVSdU1qMjlJeVQrbDNGOFkxS2dI?=
 =?utf-8?B?SlhyYUFxcm1iZTNKdnZqYWJrREc3NkIxWTZ5MlJGN1pKSGZZdkdwVzZSWWdw?=
 =?utf-8?B?UHlHRUpyZVpEbGFYZ04wS0VjcDJ0L2t2ZUEydS91NmxQbTZZT0VrdXJkdExu?=
 =?utf-8?B?OTBraDRmZGhSMWUzWmRSeW02Y0FWVjBHVGhtMlhMUEM5Ri96UDNrNzd2Mzhq?=
 =?utf-8?B?WnhzMUxLR3pYajFJejRmUnY5UFJwOWNBK3B1QkppQlUySU5LTUVFdHM3dUpz?=
 =?utf-8?B?Z0VyZTFPWWp2NEtOS0I4SHpGRW0yZWdYd0JlckFxbUdKbk0rSFcyQ1R5M0cv?=
 =?utf-8?B?WVRiUUo0clMrblhFaWdXOGNka3dxRzBGWjM5RjFEZzBCQXRNVjQ2alFUTHRj?=
 =?utf-8?B?QXpDak13VEx6eUtaalJZR0tsdHpJVXRxWTR1NitzTWJnMzdzVGQ3TnI5VC8w?=
 =?utf-8?B?alBuOFNjUmREampuMmg5RmZLTGE5enFxcS95MUV1M3FTb0JKNWtla0xyMFdx?=
 =?utf-8?B?TGFZek51bU1YdFpqR0F4eXlrdm5YRjA0R0hZSUYra1ZEeDVyMEZCSkg1eVJO?=
 =?utf-8?B?dnpra1ZRQjNkTWZBaHVSTlo5QWl3VVhKZ1pFdkdZM0x2Z2hvMERRTnRUc0ho?=
 =?utf-8?B?a1NNc2Y0OGFTa2FZc1dQOTMxcm1iVU1aZFhYM0dZcEZZMjdySldJWGFKalZ4?=
 =?utf-8?B?ZVl2UHljeVVxWmo0TjFJWGpidlBYS21ZcUpvRHNjSWtvOVpyN0xQbmVWeWpm?=
 =?utf-8?B?akwrVkt4RkovbzZzcVluR0lFR1NBZTRsTW1kN0s5K2Z3K1l6V252eU1IZmIx?=
 =?utf-8?B?aTI5SDI2bmlGeFg3cEVVRkhBY2VVMHEvMjBkWGVmSVJ6WEs1OGRPTXVGQlJs?=
 =?utf-8?B?UVBkV1BQZ3JFV0g2SnZ5MjMwVjZJQkdLdjlpZnlSV2tVMEhKaDV2RFA3Wll4?=
 =?utf-8?B?Nnh2K2luU2MzUkdpU2hzRXgzL1prWGMrei9GUEhtbndwUXpuNTFzTWhNY0Vj?=
 =?utf-8?B?SGFLYmRXOGp1cEZKSWJZdmIyQ3U4eGN1bVY3ZEtEdDN0ajkzdzRtNkZlRVgr?=
 =?utf-8?B?ZUt4cW9zb1FwV1lUaDNCdWRlQ1pTOWExWnZFRGY4NnI5MGhSL1Y1K3pHS1Bi?=
 =?utf-8?B?b0dHQXhkcHhLS3pKKzRXK0JsVkFYaHFxV2FSUjhmbUsxSklrSGhoL2NoTEwy?=
 =?utf-8?B?dVVjQU1FNkVsYnF5Q0dlZ29QVVJTK2ZMRmdibllFbkk3bDhCWmJsZEJXTkpT?=
 =?utf-8?B?YUhVbDNTaFJWaGlrTy9vQmRaY0pTdENFREFGaEdrUVdtOTRNT1NISWdVWkpp?=
 =?utf-8?B?Q1VzREtKRHVRSkRMMEVCNWdaWFBxMWhGbFhTUXlWYU1kR3gzbXYrWFBDdUpW?=
 =?utf-8?B?T0Y3SnVDaGlwVjErVDVjVnZJRlprWC9RWjNYcE1FcFV5WlhuRmJUUG0vKzRy?=
 =?utf-8?B?WUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0039be3b-0222-43d3-8b49-08ddc867518a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 15:00:23.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfzUtdALNOyx8VUc8FVakIIPaWBDDKhPBkLP8SbL2gfbPebOBHkQx3VzxiTnwfpkNSTOViTxdbtoK1w9MWqFXuVD+6ahsemT1lMcIHtfcIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8410
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE3LCAy
MDI1IDY6NTcgUE0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47IEludGVsIFdpcmVkIExBTg0KPiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmc+OyBMb2t0aW9ub3YsIEFsZWtzYW5kcg0KPiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47
IEdyaW5iZXJnLCBWaXRhbHkNCj4gPHZncmluYmVyQHJlZGhhdC5jb20+OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV0IDEvMl0gaWNlOiBmaXggZG91Ymxl
LWNhbGwgdG8gaWNlX2RlaW5pdF9odygpDQo+IGR1cmluZyBwcm9iZSBmYWlsdXJlDQo+IA0KPiBU
aGUgZm9sbG93aW5nIChhbmQgc2ltaWxhcikgS0ZFTkNFIGJ1Z3MgaGF2ZSByZWNlbnRseSBiZWVu
IGZvdW5kDQo+IG9jY3VycmluZyBkdXJpbmcgY2VydGFpbiBlcnJvciBmbG93cyBvZiB0aGUgaWNl
X3Byb2JlKCkgZnVuY3Rpb246DQo+IA0KPiBrZXJuZWw6DQo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBrZXJuZWw6
IEJVRzogS0ZFTkNFOiB1c2UtYWZ0ZXItZnJlZSByZWFkIGluDQo+IGljZV9jbGVhbnVwX2ZsdHJf
bWdtdF9zdHJ1Y3QrMHgxZA0KPiBrZXJuZWw6IFVzZS1hZnRlci1mcmVlIHJlYWQgYXQgMHgwMDAw
MDAwMGU3MmZlNWVkIChpbiBrZmVuY2UtIzIyMyk6DQo+IGtlcm5lbDogIGljZV9jbGVhbnVwX2Zs
dHJfbWdtdF9zdHJ1Y3QrMHgxZC8weDIwMCBbaWNlXQ0KPiBrZXJuZWw6ICBpY2VfZGVpbml0X2h3
KzB4MWUvMHg2MCBbaWNlXQ0KPiBrZXJuZWw6ICBpY2VfcHJvYmUrMHgyNDUvMHgyZTAgW2ljZV0N
Cj4ga2VybmVsOg0KPiBrZXJuZWw6IGtmZW5jZS0jMjIzOiA8Li5zbmlwLi4+DQo+IGtlcm5lbDog
YWxsb2NhdGVkIGJ5IHRhc2sgNzU1MyBvbiBjcHUgMCBhdCAyMjQzLjUyNzYyMXMgKDE5OC4xMDgz
MDNzDQo+IGFnbyk6DQo+IGtlcm5lbDogIGRldm1fa21hbGxvYysweDU3LzB4MTIwDQo+IGtlcm5l
bDogIGljZV9pbml0X2h3KzB4NDkxLzB4OGUwIFtpY2VdDQo+IGtlcm5lbDogIGljZV9wcm9iZSsw
eDIwMy8weDJlMCBbaWNlXQ0KPiBrZXJuZWw6DQo+IGtlcm5lbDogZnJlZWQgYnkgdGFzayA3NTUz
IG9uIGNwdSAwIGF0IDI0NDEuNTA5MTU4cyAoMC4xNzU3MDdzIGFnbyk6DQo+IGtlcm5lbDogIGlj
ZV9kZWluaXRfaHcrMHgxZS8weDYwIFtpY2VdDQo+IGtlcm5lbDogIGljZV9pbml0KzB4MWFkLzB4
NTcwIFtpY2VdDQo+IGtlcm5lbDogIGljZV9wcm9iZSsweDIyYi8weDJlMCBbaWNlXQ0KPiBrZXJu
ZWw6DQo+IGtlcm5lbDoNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IA0KPiBUaGVzZSBvY2N1ciBhcyB0aGUgcmVz
dWx0IG9mIGEgZG91YmxlLWNhbGwgdG8gaWNlX2RlaW5pdF9odygpLiBUaGlzDQo+IGRvdWJsZSBj
YWxsIGhhcHBlbnMgaWYgaWNlX2luaXQoKSBmYWlscyBhdCBhbnkgcG9pbnQgYWZ0ZXIgY2FsbGlu
Zw0KPiBpY2VfaW5pdF9kZXYoKS4NCj4gDQo+IFVwb24gZXJyb3JzLCBpY2VfaW5pdCgpIGNhbGxz
IGljZV9kZWluaXRfZGV2KCksIHdoaWNoIGlzIHN1cHBvc2VkIHRvDQo+IGJlIHRoZSBpbnZlcnNl
IG9mIGljZV9pbml0X2RldigpLiBIb3dldmVyLCBjdXJyZW50bHkgaWNlX2luaXRfZGV2KCkNCj4g
ZG9lcyBub3QgY2FsbCBpY2VfaW5pdF9odygpLiBJbnN0ZWFkLCBpY2VfaW5pdF9odygpIGlzIGNh
bGxlZCBieQ0KPiBpY2VfcHJvYmUoKS4gVGh1cywNCj4gaWNlX3Byb2JlKCkgaXRzZWxmIGNhbGxz
IGljZV9kZWluaXRfaHcoKSBhcyBwYXJ0IG9mIGl0cyBlcnJvciBjbGVhbnVwDQo+IGxvZ2ljLg0K
PiANCj4gVGhpcyByZXN1bHRzIGluIHR3byBjYWxscyB0byBpY2VfZGVpbml0X2h3KCkgd2hpY2gg
cmVzdWx0cyBpbiBzdHJhaWdodA0KPiBmb3J3YXJkIHVzZS1hZnRlci1mcmVlIHZpb2xhdGlvbnMg
ZHVlIHRvIGRvdWJsZSBjYWxsaW5nIGtmcmVlIGFuZA0KPiBvdGhlciBjbGVhbnVwIGZ1bmN0aW9u
cy4NCj4gDQo+IFRvIGF2b2lkIHRoaXMgZG91YmxlIGNhbGwsIG1vdmUgdGhlIGNhbGwgdG8gaWNl
X2luaXRfaHcoKSBpbnRvDQo+IGljZV9pbml0X2RldigpLCBhbmQgcmVtb3ZlIHRoZSBub3cgbG9n
aWNhbGx5IHVubmVjZXNzYXJ5IGNsZWFudXAgZnJvbQ0KPiBpY2VfcHJvYmUoKS4gVGhpcyBpcyBz
aW1wbGVyIHRoYW4gdGhlIGFsdGVybmF0aXZlIG9mIG1vdmluZw0KPiBpY2VfZGVpbml0X2h3KCkN
Cj4gKm91dCogb2YgaWNlX2RlaW5pdF9kZXYoKS4NCj4gDQo+IE1vdmluZyB0aGUgY2FsbHMgdG8g
aWNlX2RlaW5pdF9odygpIHJlcXVpcmVzIHZhbGlkYXRpbmcgYWxsIGNsZWFudXANCj4gcGF0aHMs
IGFuZCBjaGFuZ2luZyBzaWduaWZpY2FudGx5IG1vcmUgY29kZS4gTW92aW5nIHRoZSBjYWxscyBv
Zg0KPiBpY2VfaW5pdF9odygpIHJlcXVpcmVzIG9ubHkgdmFsaWRhdGluZyB0aGF0IHRoZSBuZXcg
cGxhY2VtZW50IGlzIHN0aWxsDQo+IHByaW9yIHRvIGFsbCBIVyBzdHJ1Y3R1cmUgYWNjZXNzZXMu
DQo+IA0KPiBGb3IgaWNlX3Byb2JlKCksIHRoaXMgbm93IGRlbGF5cyBpY2VfaW5pdF9odygpIGZy
b20gYmVmb3JlDQo+IGljZV9hZGFwdGVyX2dldCgpIHRvIGp1c3QgYWZ0ZXIgaXQuIFRoaXMgaXMg
c2FmZSwgYXMgaWNlX2FkYXB0ZXJfZ2V0KCkNCj4gZG9lcyBub3QgcmVseSBvbiB0aGUgSFcgc3Ry
dWN0dXJlLg0KPiANCj4gRm9yIGljZV9kZXZsaW5rX3JlaW5pdF91cCgpLCB0aGUgaWNlX2luaXRf
aHcoKSBpcyBub3cgY2FsbGVkIGFmdGVyDQo+IGljZV9zZXRfbWluX21heF9tc2l4KCkuIFRoaXMg
aXMgYWxzbyBzYWZlIGFzIHRoYXQgZnVuY3Rpb24gZG9lcyBub3QNCj4gYWNjZXNzIHRoZSBIVyBz
dHJ1Y3R1cmUgZWl0aGVyLg0KPiANCj4gVGhpcyBmbG93IG1ha2VzIG1vcmUgbG9naWNhbCBzZW5z
ZSwgYXMgaWNlX2luaXRfZGV2KCkgaXMgbWlycm9yZWQgYnkNCj4gaWNlX2RlaW5pdF9kZXYoKSwg
c28gaXQgcmVhc29uYWJseSBzaG91bGQgYmUgdGhlIGNhbGxlciBvZg0KPiBpY2VfaW5pdF9odygp
Lg0KPiBJdCBhbHNvIHJlZHVjZXMgb25lIGV4dHJhIGNhbGwgdG8gaWNlX2luaXRfaHcoKSBzaW5j
ZSBib3RoIGljZV9wcm9iZSgpDQo+IGFuZA0KPiBpY2VfZGV2bGlua19yZWluaXRfdXAoKSBjYWxs
IGljZV9pbml0X2RldigpLg0KPiANCj4gVGhpcyByZXNvbHZlcyB0aGUgZG91YmxlLWZyZWUgYW5k
IGF2b2lkcyBtZW1vcnkgY29ycnVwdGlvbiBhbmQgb3RoZXINCj4gaW52YWxpZCBtZW1vcnkgYWNj
ZXNzZXMgaW4gdGhlIGV2ZW50IG9mIGEgZmFpbGVkIHByb2JlLg0KPiANCj4gRml4ZXM6IDViMjQ2
ZTUzM2QwMSAoImljZTogc3BsaXQgcHJvYmUgaW50byBzbWFsbGVyIGZ1bmN0aW9ucyIpDQo+IFNp
Z25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KUmV2
aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwu
Y29tPg0K

