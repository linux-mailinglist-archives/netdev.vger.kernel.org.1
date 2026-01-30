Return-Path: <netdev+bounces-255116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GdDHi6TfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:17:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E471FB9F8D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB543036EBE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14637A491;
	Fri, 30 Jan 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9j58ZJS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3537B3E1;
	Fri, 30 Jan 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771495; cv=fail; b=PSiMJRxUsmpJPCJI5oT1x3oQ7491tmaZGyLK/DIDh43Gs3jk9Znt7E51jq4vBXGgWJ9bpNPRQNZK/+4Ls6HG/8G98zDA4ML3Dzl+pp9qdQkNIB5KKYhOTtN4SKd0QniSO9ZdKAUq86euFaeCYfStqnL7K+FeB7ppJT3VuZz54p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771495; c=relaxed/simple;
	bh=84U9cDxJZkxBlvCVJ1RVfWqPxJgwISY+QwB/hC8Azo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ostg/46uN8DIMIMLYIitXOT1hUlbK2buCgFz87Q+o7gQrwMygIlBmQ0eQFTnJg0F8AtL7HnNnD7pe0BKLnX0kLd57TF+KQoaQeUB8KnBz6IjNAPx2CvMRp19A2gSUiLgW/5v3eQh5IH8ZTBinphagaXlxB/aqGBwtWb4lPo5lVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9j58ZJS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769771493; x=1801307493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=84U9cDxJZkxBlvCVJ1RVfWqPxJgwISY+QwB/hC8Azo0=;
  b=V9j58ZJS+SqaZTVY9i7k3PNSsaHbcPNZmk9W7xXSw26/XakhgrDsvjCs
   VW9P4De1iqmSuC7hVS3D4CbCZssaA+cC6Wya5QWDss38UQy768LXaChuR
   5SPKnQ9bi7cbCcsA9VoMdhY2JYDJXdrfmCqAhxmB4XP/mADgAY0DXVE/e
   zqO8KP3nUtdTHKjX3WjXZVUOK06fB0615yKiuDOEitKYZEJhNHvJF61Kp
   qgLeTiQJcqG9Rcl2eCRlqwvrpe0hUKUieGib5PVJWDaUOLJj3RhKOwBfv
   JrFKzvC2i9JbpROfx8HCcksITubZnobGb+h6uBXNOFhk4+iwoy7kVK9fN
   g==;
X-CSE-ConnectionGUID: tXyw9a7uRX+8GY+q3yOyWQ==
X-CSE-MsgGUID: Tcr8LCagSQeb4vD0txEtKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74872769"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="74872769"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 03:11:33 -0800
X-CSE-ConnectionGUID: ZRuH46fjQ3GUQfwQWweH2A==
X-CSE-MsgGUID: c1F9UbYeTTSv3XCCh11ROw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213782128"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 03:11:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 03:11:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 03:11:32 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 03:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xahE/D7FBHndxsP/laekGt13Q2lKrlwhxdwskofnvKwLijxk2hj2Jgz1KCdxy6C1f0Jz3X7gz3Q71CauZvuBo5Yq2MfyAOlyLZcChs5a3QIXJt66YE3aCiF70LkrUUsf07t1TxsQ+od1DpNmn7c7JM6gyAhwpY0lZ8Y/R/GKjj03HIFYAKtnIq8J7w59ps7G36jfGAGs+o7hHu6wq2L92jtNrmKZQ70f/RhZy13sBL6XGxh81o69sGaFS4B+hOOdDsfnE3IGGBReZIQmBNyB5ZaV65LABn5gN3lBMDmeAICdGYVEOB7tnfSsWfYMyLCrJ3zwWuLRmuGfFDF//Z2Iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84U9cDxJZkxBlvCVJ1RVfWqPxJgwISY+QwB/hC8Azo0=;
 b=MuvUpaY/UwdtNDdkjyK8g+al4x3CcIyJMTuml28Modvjt/PmPfUW2QIOf7Hu9i95Rnw4GT/BtJLAG+s0mExrsgEJYtzeoMEmOEwBwWWwt6Vxtuin+4e0wR4x/xTrLHd5lRTISkB4LvvzXfPZ8KMkKM2lErUajtY/ZUy5TuNOqUfs2WuxUcivU9//T7HAHJ5zC2nIAqzYztDP/p3wS2L4KaFgYTu89cYOJH2+0KAjXvr6pJuLgGGBqrj7lFOsPTcsvRHV4LsgsQYj7C/gFvqZV7u3x9MqVMyF0IsKhW++N+4amfD3KXIZAoVSmyyN2GmHIQPfJYbizYgrCfMH+5fOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 11:11:29 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240%4]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 11:11:29 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 19/30] docs: kdoc_re: make
 NextedMatch use KernRe
Thread-Topic: [Intel-wired-lan] [PATCH v3 19/30] docs: kdoc_re: make
 NextedMatch use KernRe
Thread-Index: AQHckPaU+16WdF1k80ap4WH7YTIlT7Vqj09w
Date: Fri, 30 Jan 2026 11:11:28 +0000
Message-ID: <PH7PR11MB598356D94CDC4CA9EB6A22EDF39FA@PH7PR11MB5983.namprd11.prod.outlook.com>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
 <8a7da8d12e69a5a70d63f85a3d4ea11af6ac782a.1769673038.git.mchehab+huawei@kernel.org>
In-Reply-To: <8a7da8d12e69a5a70d63f85a3d4ea11af6ac782a.1769673038.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|BY1PR11MB8007:EE_
x-ms-office365-filtering-correlation-id: 3f9282fe-8677-4c5f-b574-08de5ff0510c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZjAxZVJVY2N1WVEvNG9RMkNEUTE0THYwWGkwcGpSNVVzUXJvdFZSTnFsNVZW?=
 =?utf-8?B?UURPQkxRbEE2Q3hYS0dhQ1l0Wkw4TjhjbEN4NTRoeENYbmw5a1VKVDJnWHN1?=
 =?utf-8?B?MUowU2pZdmZVbStsK0lBOXVWYStoeGkySEQrYWZvWmdRMzh1MnV0Z1Nob1FR?=
 =?utf-8?B?c24zYTMzV3kybkNvaHlQcmZQN3I4VUlEYXY4NDVpdVRjd1BvYW91aEpTY3NJ?=
 =?utf-8?B?Y0hORStjdVBDSk1zTkthbzh4K1J6anY3TlljSTc1bkFnWnBKMm5Lb2VHSXhV?=
 =?utf-8?B?UEZxdmVlRkYrTHlWdiszQ1ZBSDJPekI2aHZuZFFsZkNlVS80SG5WT214UHBZ?=
 =?utf-8?B?SUJlMGJvenZROFlmamNjd3NBdEd5MjVRMEdrdCtaaWgyZnF3YlQzMVZpbU16?=
 =?utf-8?B?aHgxWWNKUFdSL3R3VDFXTS9YUThraUdLbWZIaVIwMFhlNndzaUZ2ODMvblJ5?=
 =?utf-8?B?UTBmQWQvZmFKSVdpVVFnZ2NnWlkwR1FxV1V1eWpWZVdPZDA0bmZkc3ZnS01T?=
 =?utf-8?B?aGIxaC93YnBHWXFHMEgvb29meDB5U3ErUWdXOHJ0SHBYbHBYdDgvWjF6bHNm?=
 =?utf-8?B?UncwMVZ5R3l0NVdWdHpqTkNwa0JrckFHdHRXVzJXejJKTXdWdlQvZ2lZSWIr?=
 =?utf-8?B?NjAyWWU5ZmJ2MkwwZVpPbGVFRGNVSUVoczdKOVd3RUR1YnRmN2FFdXFtWGdq?=
 =?utf-8?B?OG5mZEtON29STVg2SGJITHN5WExudEFKSDlYZDJDMFY5SWZtcDhBWEIwYmI2?=
 =?utf-8?B?cTVkMzBIMWlRZkdNRWVCU1VETm1uTkV4b0cvdFpZajhFS1RSR05oV0pUTnd6?=
 =?utf-8?B?TmEvVHZrYjZlOElBcU1SV3JiNm9CRVBWRC9mUGxZQmlDWEhhMmVRQWlhbFZX?=
 =?utf-8?B?WEhNNWJ6aXZvWEg2dnZCbldpb0xyWHlmTGhoU3Y2bzl0ck5XY0dra0VsQ3d4?=
 =?utf-8?B?LzRMRHA5VkdFc0RxczdLemJYU3VhUFc3MVhSWjUwZm9kWDh4Y1NkV2krdjNI?=
 =?utf-8?B?Sm5qUE4yNmNwNHBuUnVNaE04Y1NJQkdJbHlyNEd4bkhuckhScWVwcHlFMnow?=
 =?utf-8?B?cmYzZ1o4NXhDdzl2Y2h5WEhibC90UjFZaERmck81dGtoWElxMittMEYxaEtH?=
 =?utf-8?B?RHQ2WTlUT2dZdXFvV0ZUKzdMamM1eUxONDg2anRoMnByOTF1cTV2NGFZdm5L?=
 =?utf-8?B?bHpJUnFUaDNJZXRVZ1BTRG8zWndPY1RGeTN4N1NBVS9MSExtS0ZOSC9TOCtL?=
 =?utf-8?B?QnpCWXF1bVR0a3BzTFI4UU5hMHY1K1dKSTFzTDgxbnVNU2x5aDMxV0hSYmk5?=
 =?utf-8?B?K0dXTlpRdkwrMzZYSEZDaVhBeml6WklKRHg2dis1UENIcy9wcHlCRDBuQkVY?=
 =?utf-8?B?RTN1VkJnQ2pna3ZTT2tZeE9hWHlsVTJodVRyQWxRVFFyK0g0MytmOFYxTG85?=
 =?utf-8?B?cVNuaTIzN1RNZnoyZzQzQWNQNERhaDNvZkhxYjRGWFhPbWdHREUwblhYeVNN?=
 =?utf-8?B?VU9sZGZzNmJJSWVGYzFIcjVwL3pzM1RpT2twOVVYcnhXTDZyVmVGTzA1TnBp?=
 =?utf-8?B?b2d6c04zVExMTDdib0JpMmEvNFE2NitSM3ZoWmxWTzlKc2lvL2ZyVWkxN2c4?=
 =?utf-8?B?dUVYcGRqZkxWWnFocjdwUzg2Y1ZneXFuVWlYaE5zbkdOVXFGcFhhTi9JKy9u?=
 =?utf-8?B?eWJlTmEwd0Jya0ZicW1TbzBqUkE1c2pwNEx0cXUreStXMlJScVNmcmJWQm9s?=
 =?utf-8?B?RVp1SmZhdzVJMDlTVVZSVC9DUjczcExKejF0STE0RzB5aUpqSGtrUGJSKzdH?=
 =?utf-8?B?akp3WDlZREZ3WHdLZzZnMmhmY0ozSWxuVTFUZmtic1E2OU1HZHZBZ2svUjAy?=
 =?utf-8?B?TGhySGpUTDQ1dzNEOTd5amlZc0Q0dmNqNGs5QklCWFV4V1g0akZWcXBIVkhZ?=
 =?utf-8?B?NW1pNDZjR0FHOFVpeXZNcm11T01TLzdFcUhyOXdrbGZ4SGhPbmMvZTBqcXI5?=
 =?utf-8?B?RDFQSVlsNEJnTUU2TXQzWDNpZC9YMTBDNi9RWDA1VDBucFk1OXlrR0gzbjFm?=
 =?utf-8?B?WEplN1UzeXdNN3VvRGtFbGpTVmZNdXAzR3k3VkV2T052eXp2VWZmZVJYbFNI?=
 =?utf-8?B?YTg3djFDM1J4SzRtcWZQck9Bci9SdUQwWXRiSVpGMjZONWNZM0NWYnhTRVFj?=
 =?utf-8?Q?FuDTux9img3ANVEp2yglscU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cExocnJhNGd1b3F2cXJGT0x2eTYyQjFQNEFlY1VkczRpclBiNzM3eVlnOVIz?=
 =?utf-8?B?eElwdDFzcDhFS3Bsc0ZSUnBKSVRyL1VxU0hrR0NVeEc2UFNvUGplbDQ0VFl2?=
 =?utf-8?B?UVMxdG0zQTNUZndJb0pPSUhEb1VDbm5raEs4bURMbVI3YndpYk4rZWJHNHJm?=
 =?utf-8?B?K2dUMmJGY0MvQ2RndVpCSEF2ZTlzelpINGQyYnNlV01Yb09CVk5iR3V3YjdF?=
 =?utf-8?B?akN2TUt6TDVqdnVSM0V5VUQ5bXFmNXBSK2RsNEt3NUpRT0RuRE5COGMvaVlK?=
 =?utf-8?B?SUpKMjB1UVdoWU0zV0M5OCs2aXo2RTFuTVVmUkZTZ1hvSmI5U2wybXYvdGtV?=
 =?utf-8?B?RHdaT2RSSEVoazNFKzdRamFMOXJOalVDTXVpMWhYK3VvREpNTkFhUit3V2lW?=
 =?utf-8?B?NmVlMXVoNG9RbnFFRzNjdVQ0OXhHV3FiM2VpZjZTRXUydGw3YjNaSExkNUZ3?=
 =?utf-8?B?WU1kRkZ1RzdlaVM1MktpNkk2K3ZsWWJ3WVBlRW1VZDVNcFhlaHFkY04zaEdN?=
 =?utf-8?B?dm1RY1Z6d1pzUmVBbWRiT1A1ZnlXU1ZSVUJvUjBTS1JlWTdSNDJpaDRUUXpK?=
 =?utf-8?B?aHc1T2h5VVBGWm5DTnJnb1NyeTdwZ09hS2FrVlFzZFFVbHJBcjZoY2lxUjJP?=
 =?utf-8?B?OWVLRDBCYWt6UEU3cXhUbUFMOUw2Ri8yTzhhR3htanNmY1U2ZE1DcFcxRkNi?=
 =?utf-8?B?MXh2K0dvdlpIcUZYWFhhWTk0OEJDL3RvR29lRDVoYVZlUzZpbGlZSGdZY1VP?=
 =?utf-8?B?eW8yRm5MTVNydnl5T3NOUUhQWE5LNHpPSnNkL3pFK0lkZEZUQ0I3REZtMjV5?=
 =?utf-8?B?MEVod0NQZDZYaG5BV0FaUTF0ZmJDQ0phMlNtcC9ZNXpXOEJZUzZjTGYweHhl?=
 =?utf-8?B?c0gxNWtxZmRSYldaZDRiTzVNekJtbWN2bmRNSmw3VDB4Tis4MnVkc0x3UHdl?=
 =?utf-8?B?NCtodTJJeEhxM3htRW5jcWJ5dHFTWWU5b3FTaXY2cjdidVdsL25nTEtDSGhU?=
 =?utf-8?B?Q0ttYnNqWGlRUnQvcVhIVUdMT1pFRlpzVkZ2QmREYU9SL1k3aTM1MitGLzZZ?=
 =?utf-8?B?enZ0SUxQVHkycjdWNTRIZWU2UFo3blNEM2N2cmVTZjFCVjRYTWNUTDlRVlkx?=
 =?utf-8?B?M0d0VEMvRU5JRGZ2a2RHYXJOUlNXRXJZT09Kek4rb1dpKzlEYnpISGVQamVs?=
 =?utf-8?B?NHd5OGVQb21YQXZtWVQyUTB6VXR6YVZRbm1zV3A2VTM0OWpmZ3FSN2xsaVE2?=
 =?utf-8?B?azByZjgrN1B1cEltM3A2blVSYlBMVDNHcG5iVjJraG5sY3FYb1FqbE53UXNR?=
 =?utf-8?B?Z1JqTVM4Vk1zTzc5WDZuNlFkYjU4RjdiMzVHZnBwNnQzSGJMa0d1clZETnVo?=
 =?utf-8?B?U2Vqai9WNCs1SDFpNFppN1NvKzRFN0EwRXQ2T00xL1pKNlI4SUhUQmpsWHAv?=
 =?utf-8?B?VDB3b1ZwaHJLSmNQWktvNGRvbUR1bTA0YkRJV2ZKSDRFZVA5NGt1M1J5NlZ0?=
 =?utf-8?B?Q2F2MlplL0M2Mm9qOHhOUGJqSGhBb2RCdkw5bHJYbnU4cjV3YzdBOEhwNG82?=
 =?utf-8?B?YmhFWTVSSFJJMUJtcjF3NFNEOTRSMjBrQVgzWlBxSVF5bC9UUlRESGxnMitK?=
 =?utf-8?B?cEkvVmp3MW0yY0RXcEd2YmxrbzJsMUV4MXJ5SktodHNkWW1KTHZPQ2JvdGh6?=
 =?utf-8?B?VGl2UGVtTEw2UXJUOWptWWh5cUxKRUF2Q3cvTXFUdElFZ1luUzNRWWFEV0pj?=
 =?utf-8?B?STZ0N0dEem1EbHNnbldncStxeW1uZ3I1ZU00a1BxUDd2L3FGOEIvZGxUSUdm?=
 =?utf-8?B?eUJPVERRVUtXOU5ldTMvaUthWG1LdFhyWndPK3pYbzRUeTJEeFkrNllVa1Rj?=
 =?utf-8?B?eU15cnZ1R2pEcVRXSzdkR0h1NHNJa0RjcHFXMzlQS013cGRxYzhmUjhwbzFD?=
 =?utf-8?B?TDFUdklFVDlqcm9mQnNUM1kvLzVtR0wvTXVtckhZNmpCL1VCeTBiMFl4cGZD?=
 =?utf-8?B?NWExUDNhQkh1ZGNoV0hteEtQeTFlUTlFeTlvV3RkWW5FSkQxNWZYZnl6a2M1?=
 =?utf-8?B?K1RaQm1ScGZYemM5d1ZmbkNWTktPUVRjV1I1NTQ0VE15T1dMcGhlNnYwNDV4?=
 =?utf-8?B?T3I0Y1JmRU50eVpDNExHSjdrWGVNNDNhU3FTYjgvNklFamdrRkxoOURQTWJj?=
 =?utf-8?B?RDlVUitkbWNYWlhIZDlpbjRyMmpxSmRWcWQ3OG1mcjNrbU0wdE1FK09vOW82?=
 =?utf-8?B?R3EzRm9hV3IzOWRCVzM0K3RWSktoMlY0NDBlRTdreEVha2J4Z2dXWTg5Q2Ft?=
 =?utf-8?B?MXJBMTFod0hsWGloRk5iNmNaM3NEWGUxM25VZUU3eUk4UGlFSVQvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9282fe-8677-4c5f-b574-08de5ff0510c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 11:11:28.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjWvmAw8tN/SEvxx57FaAhBMWaZVlEB92g6QTSURjGvLAgwgJxC3fSUrPOgUTsm+MaVIuMc7o03nq2C4KD29hDBuhWUEcoWcvwD74OovLpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255116-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:email,intel.com:dkim,PH7PR11MB5983.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E471FB9F8D
X-Rspamd-Action: no action

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSW50ZWwtd2lyZWQtbGFuIDxpbnRl
bC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YgTWF1cm8gQ2FydmFs
aG8gQ2hlaGFiDQo+U2VudDogVGh1cnNkYXksIEphbnVhcnkgMjksIDIwMjYgOTowOCBBTQ0KPlRv
OiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTGludXggRG9jIE1haWxpbmcgTGlz
dCA8bGludXgtZG9jQHZnZXIua2VybmVsLm9yZz4NCj5DYzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFi
IDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPjsgYnBmQHZnZXIua2VybmVsLm9yZzsgaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgUmFuZHkgRHVubGFw
IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BB
VENIIHYzIDE5LzMwXSBkb2NzOiBrZG9jX3JlOiBtYWtlIE5leHRlZE1hdGNoIHVzZSBLZXJuUmUN
Cj4NCj5JbnN0ZWFkIG9mIHVzaW5nIHJlX2NvbXBpbGUsIGxldCdzIGNyZWF0ZSB0aGUgY2xhc3Mg
d2l0aCB0aGUgcmVqZXggYW5kIHVzZSBLZXJuUmUgdG8ga2VlcCBpdCBjYWNoZWQuDQpUaGFuayB5
b3UgZm9yIHRoZSBwYXRjaC4NCkRpZCB5b3UgbWVhbiAicmVnZXgiID8NClBpb3RyDQoNClsuLi5d
DQo=

