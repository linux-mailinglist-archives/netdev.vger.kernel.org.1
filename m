Return-Path: <netdev+bounces-286834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH8RIutLAmpaqQEAu9opvQ
	(envelope-from <netdev+bounces-286834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:36:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910E516590
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A21130474DD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC44D90C4;
	Mon, 11 May 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVDcKecf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFEB4D90C6
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535367; cv=fail; b=fCHW7fkqZg66RDzzl07Ei7Yx9a/+R42lDR1HVXAjULLDZUyRqOXdi4AHHQ8jmF/XRsaS5kE7ViNVK5OKiIDquCpIpK6dEbNJapjpVG4giYhfgsCg5mmYhdJ+dqo/08YWXb6I+xC/2HKeQJDrAAq7tt4UQTfkA/0QYYAZUDDfTJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535367; c=relaxed/simple;
	bh=9r0ASrQDacaO+kIADL8ObG5moNLdUEl5w3VChAnf1V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PdBV2vLwLfnVXBBR6UKcijIAMwv0VWuHpSH8g9+28Z4qm98+mCbdcjpJbZxC/WQ3luvMtBoyqVNhkPrTubcsDCqkwTizpaasc85aT5pJSw3kHywD36yZFX5s8krA9L24ZX8u5xjlY5RMDmCdZwHTSql71ja85+wR52SUQ4FtJtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVDcKecf; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778535365; x=1810071365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9r0ASrQDacaO+kIADL8ObG5moNLdUEl5w3VChAnf1V8=;
  b=RVDcKecfg1AjbqAklC1/PmcsVwbMzHnIJkeYxGEa3ibyJz3DuJlI3DGr
   xOkyAWf59HYD9LTj57eshbyg8UuTWIrNK/Zg6Lt1Rb/4XngV2/vp2lYMc
   eFVm9aW3moVzVabZdvxJmwaWNLlzt84Jg7XYCLq0pHj+oCvLtO38hurfI
   Fx929bqyJ4qfvfDzicoWF9VE/kzdIWjqN95V0fXn6udw+iXGF47wOQYK3
   lPF1WoEA8drZEfK67TSgbCUR/BrENbQdtMhazqTqFBEnCe9hD8NtbJxWA
   GG6E9TdqhgUJerNMv/qgY5v/kdLzZvCTChalKi3RozULZJDl7+WuklEi4
   A==;
X-CSE-ConnectionGUID: Pfr6INo5QYOevGp503o30Q==
X-CSE-MsgGUID: MbZFXV6rSk68golIsSHNNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90816406"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90816406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:36:04 -0700
X-CSE-ConnectionGUID: 5CRVPLhuSV2na9bRlEhEzQ==
X-CSE-MsgGUID: O2VnV3dHTmG47Ubxyeysmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="241927811"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:36:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 14:36:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 14:36:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 14:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPGVZZLuGjFV/54wNMuw0uMK+osQCoFB80q9WA4QhppZabOaUF9bQdvk49WFw5uZooDqfxkR+jpf+6hltHH528aQLeA60yTtCVkjF4YTguCkLIj5RGA8/ugasEMPgdDviM8ZRtMHS5QDkC55+GrMBD9chRC9hew2f3MH9ogf83fQ3Eiay307tbPKrWsPt8pkrHSQ5R61vg813aC4pXbaD6xATg3cw+GhOG6KzPT4l+t/gsMijwnMjhgvuOuIo2Fgpwmlnze8QTsulQen4anTp50LTbnlLi+HTDIBOB2YxQXOHffMnZLztsHfidwRvH23fm+MUFm/FUHugBtEXtbDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r0ASrQDacaO+kIADL8ObG5moNLdUEl5w3VChAnf1V8=;
 b=SgjLZkBaOHADsztQ9b6rhL12qkWnEID5PTcj7Jy92fEkaHV09RowZIczPXeWSBBCk6jC251RkfVmnWHyt/U7MMihvj3Vh8ah2VPEkscoAR5RvJGQfxXnP6Vl7ssaHDn6TXjVpUwtW7lhPJgTej6KK9cpCHQsw6mPUGlHK30gRrd3cBMl2T93L0UmL28hxyHNLLa++A1lbuL3ud3woVSdZIhNC3hoSgWM+WnNoAiIEHhysK29yQrzLxBt8yqFb/UO5H8AJf6ULojVG8wnmTC8rY21sI3X71tYw6NamKGSCHnPPNWlUAaKb8QLxqjAfa0j/cywHxjcnz1itFX374gugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:35:59 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:35:59 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: support SBQ posted
 writes with non-posted support for CGU
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: support SBQ posted
 writes with non-posted support for CGU
Thread-Index: AQHc3tRgAJYqKemTs0ONT51MLixDALYJXmEw
Date: Mon, 11 May 2026 21:35:59 +0000
Message-ID: <LV1PR11MB8790B31B42FBF1C3C3C3309D90382@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260508102247.826375-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260508102247.826375-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ0PR11MB5920:EE_
x-ms-office365-filtering-correlation-id: 76b01804-c0e8-4b6d-d085-08deafa54b08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|38070700021|18002099003|22082099003|11063799003;
x-microsoft-antispam-message-info: JnfcVSYTXn6c3Nj341HrSny+sxYhdMP/kPQncAvJT6zMzZwULGxFWk1zTsD/tOw/ueDLFN4bLX74yXn0cqi3V4SlzVOE+LszdcHiMDfPb2a6iq7TGPAM6if6egyOHv0tJSJ/KxssWERgGQ2nQyNWyfzSqrLLjWKJuNmhAh2JL0LrIKI7IJ0CkBdz/6UaHL13loQ3HdlFFmooqQZL4XgjOu8/LmibhwzJkNWsnJt7Xw5cPICc4x2bAH2hFNOTlzMM7OgjCmqPSNNKM6/tTmFZ+qgkKFJoHdroPaCg2e5eoOb7dnZyivv5MTR11sQDOhNDVHVl9YW3Z9bQzWzjyny8TcvLxCdkl9t2CLxszabvjFLntf7wmWrSzbbaOW8N1PvoFiBYHZ8CnidE4OCbgSBZPj4JASa/jBmD20FzbwJoHcj7ZhZp3NbE5W81uZPJAEgIcdky9z+EugvKooH0UH3cY4M7zKpdYe9Q7JqXOaEr9QgIqlpWjIFRUB+xj8PIbi9QGgzyHhQ+kIgUacxQFdcTL7ehv3ecBGuavuuZzLFKXicC38qCld+0XqzdbeCsHDOEKWp6w+SvDicJ8XonBpNbJoYfMzyyPTyWJve9rZugZ3YFX6wdHydWgEi8RLiwcVldKDsDUn+hJGzxy3/2SwEbkzViI1NLgXTiXE9eXnOGikCN5yfMYBpKw2DIN0nD9N/Fjnn1R4mGlW+nkcxiGWeYlTp0lz1JkxL1R7kUkkUhEYMKiHWvxle7T6/C6fGRA4Bs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(38070700021)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGVYbDdXTHNuNVYzdGdNMGFrb1ZUZ01QWHhyVWtadkduSklPNjJBbEE5Qkl5?=
 =?utf-8?B?WVJCMjZJam1DSk8rQW1RWHBqQzVZYW51SGI3SDhmMzArZDI4NGU5TGJrT09X?=
 =?utf-8?B?STJUZ0lET1dYcWIrUndjZVovM0l1blpWZldPOXBWTGw0YytTUDg5S3FSeDFL?=
 =?utf-8?B?b0xUSGpJMllOU0lodHF6MVdlUTVkYkd4VSs5dk1va3B1dHBib05udHJscVBj?=
 =?utf-8?B?bnRiRE5CS1V3WlArVWJpMER2WlBpZnYrL01pVFMzTTVManRUNHQwODVNUTZ2?=
 =?utf-8?B?UXNIVEk4NEFJMkZNaDJ6R2o3TlNSWVc2TU1KL0Q1NE54SFozSDdpdVl5anor?=
 =?utf-8?B?cGxTVlpDMWwxMkRUL0FkMHBIZmlScFNFN1c2RjNoMlZBOHlvbHpLYmxMR1hN?=
 =?utf-8?B?Z2NrNGE1SjZqL0xLYUhnSEthSWIrcStiRElSSldmRGNablRxYW1DOTl5Y3J3?=
 =?utf-8?B?L1dmM2d1WVIvcXFsV3UvYmlGcTRqVExNYWszOXBoMnk3Mzl2WmRqa0tScXIz?=
 =?utf-8?B?UjBVOFJDQk16czByKzg3SXRNTWxqQlpSSlZQRnMxNFJXVW83RWhhREtFcHdJ?=
 =?utf-8?B?cmJFU0o2cTRHbDJOZXFOS0thaUdVc0dOU1RFZFZZczMvcUNITjJMS1dFSFBW?=
 =?utf-8?B?Uk5wNG54MkRnZ05SVFdTejU5MVdhd2VRMklEM2NhQnpTRHJIZHpPZC9DNVUx?=
 =?utf-8?B?eE1mZElia0MybFI3c3B6VGtOVXl3RmwyQjRqRHJhRGRRS2FpUWVucVkzWWNi?=
 =?utf-8?B?Z1l2eFE2RXVXZnY2bEFkRjN6cGZ5NStwMWVwMVBueWtKWkFESTlZVlE1VG5n?=
 =?utf-8?B?c3FtUjU3M0hLRlE1VC96SDZhL29NNUxrN21va2JXb0xObXZQMzJzclkrM3NT?=
 =?utf-8?B?WVpVcW82eHV0ZmlEVXE1blU1SDlUSml2V1BvbWRwTVpZZGRyUTFlUzBzeGtB?=
 =?utf-8?B?cnVzbXk0cFBYZ2t1UjdHMWNlWkd2WmRLSER0U0pwZ1pJZ1pGUjkzVEJTcXdQ?=
 =?utf-8?B?MjJTVkZ2MUx3Z2tOM3FjRVA4a2Z5YmdBY1REelRKZEFLb29LL2FJdGdlUmRT?=
 =?utf-8?B?R2lLRUwxVGpneHY0UmpteURpd3EvMDBiUGZ1QzdZK1JESVV5N1F0R1NEZ3Ba?=
 =?utf-8?B?MWZMbVhjMzRQcmY5SGhDTVVxN01HU3JvS2RvdmJRRVh3L1JuOGFXWkkxbmVD?=
 =?utf-8?B?QWl4Skl5cWVHbitacWxjaDJGczdxbC9hbEFkT0QrU21va0svN1pUaTJQSzhP?=
 =?utf-8?B?cnc2RndjZUFTeWltRUkrWEhFcXJ4eitrcXBYRTg0TWx0Q00xcWQ1MjJiVDdl?=
 =?utf-8?B?WHl5K1k2TjlLeUhNWnk3WktmanQya1NLZldQYXZ0MTBybFRnZDgzWHhCZE53?=
 =?utf-8?B?S1hkQUNlMitUN0VZdXdGQ3RiZE5lclAwUlVmKzhzVTNTS1dSMWt1UEUvcFA2?=
 =?utf-8?B?dURYMG50bDgwdk5rUFpOUE1RTHY1WGEvMW1TSnF0K3dBV01IaVJ5ZnNBU1Bk?=
 =?utf-8?B?K1NlV3JmNHFLM3dXSW1KZVhkYVhHRE1FVGpKaHBoRFFtQitvK0V3UXg3L2Vo?=
 =?utf-8?B?NGJFYWdQckdLdUcxaEl4WkFsZWJrNm1tY0trdmhxa0JBZzZVWUE1dENsL20v?=
 =?utf-8?B?bUEwcEp0N25zK1VMTGVxdnJvTVY3S0paQjhwY2xlT0liem5Pa3RLeE5UV2RQ?=
 =?utf-8?B?UWRuNmUzTXBiVGtDY3YxUjF3ZTQvc3NXSjRTVUZSeWN6QlRYQW5KNXlxdGkz?=
 =?utf-8?B?RVdzS2dtZ0lZUW9IYlBNVGdFV0lhZVpSb3JoYStiRDEvNG0ybHRlblNVeFE1?=
 =?utf-8?B?c0lhbGNxdmRDRllQSko4c3VwRTdNSE1DY0l1U3lMdGtCOVNCYWhaTFZlaGRq?=
 =?utf-8?B?V1ZsaEZSTmlxajlsUkNtTTFwS28zdnFCOHpMaU00T29raCtMUGRjNHFLRnhY?=
 =?utf-8?B?WE5veEtPU2ZSWlBTR2Vablh0bkVUb09iRThKdXVzRDg3S0JVbktkS0c0Umky?=
 =?utf-8?B?Wm5iL0g3YUp0YmlCODdsV3EwNG15YzZOdHJlVmF3VjdOS0JDaU13WTNyc3Mx?=
 =?utf-8?B?K2NBSTNEUGx1b1V3eWc3aVdJNHdScnlVSmxGT0JxLy9XUWZIc3ZCUnBmQXRC?=
 =?utf-8?B?bmlRTkwzcEtZK0pBQjRmcmFtM243YVZOQXMrNU5YNGwwUW9DbDVqL2pNTzVx?=
 =?utf-8?B?MUVPUkNQQ08yYko2UndHaGI4dW4zNVF0RkFpajhJMnBjcFM3NklZUFE1b3N5?=
 =?utf-8?B?SklsbGZwZXd4Ky9sdDdEYnVuWkxrdWhRYXRTSkdCaEk2dFI3Rk5QZDRnZDJQ?=
 =?utf-8?B?aEtrTkk5Q2JiMVNoenZyaWZ3N1Z0QjNINWtkSDRMSXo1WWhUYkdwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jUU+pQjMBIErhb7tETp65It/G+KpnKt/z+qgFKL3sSiB7HfzBBURH0CWhMjL7/n+vv2Wb6TZ7B3L+pWcMV+0BKlp3qWDS9GvC7inHpyrbfzzVcntC3i2u3NKM6Emee5zM4BckRnrHlRIhffTtBKSo3pRgJ6ZqimKz6SoyRPkjX//2NmOC0CfvRrT87Bq7G0tzTai7uy/w9kXVgZDDyu+LJ9aiGaJ/8h/0DEBteUitPoZjWgLyyFXoaeHLOc+mgUVGCgZtQ3NxJaMySGYQmycVK8oeBsRU8+Jq3ZP9NCS2AKgR8Ifg0NYO7kI86Qzv1NxP4CS1PLmUdknh4Cxrj5ZPg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b01804-c0e8-4b6d-d085-08deafa54b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 21:35:59.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpBxzN4ItN4E3PnnZq6R/WYbGMGAGReof/j2iKDdNd2TjQb0+OY/5tKGYftywJFOg2KwIclFNvFp0Svy8pB++5O1UIB/mhUSxS6R+liYksI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5920
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0910E516590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,LV1PR11MB8790.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBQcnplbXlzbGF3
IEtvcmJhDQo+IFNlbnQ6IEZyaWRheSwgTWF5IDgsIDIwMjYgMzoyMSBBTQ0KPiBUbzogaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFs
ZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCANCj4g
QXJrYWRpdXN6IDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15
c2xhdyA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJl
ZC1sYW5dIFtQQVRDSCBpd2wtbmV0IHYyXSBpY2U6IHN1cHBvcnQgU0JRIHBvc3RlZCB3cml0ZXMg
d2l0aCBub24tcG9zdGVkIHN1cHBvcnQgZm9yIENHVQ0KPiANCj4gRnJvbTogS2Fyb2wgS29sYWNp
bnNraSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5jb20+DQo+IA0KPiBTaWRlYmFuZCBxdWV1ZSAo
U0JRKSBpcyBhIEhXIHF1ZXVlIHdpdGggdmVyeSBzaG9ydCBjb21wbGV0aW9uIHRpbWUuIEFsbCBT
QlEgd3JpdGVzIHdlcmUgcG9zdGVkIGJ5IGRlZmF1bHQsIHdoaWNoIG1lYW5zIHRoYXQgdGhlIGRy
aXZlciBkaWQgbm90IGhhdmUgdG8gd2FpdCBmb3IgY29tcGxldGlvbiBmcm9tIHRoZSBuZWlnaGJv
ciBkZXZpY2UsIGJlY2F1c2UgPiB0aGVyZSB3YXMgbm9uZS4gVGhpcyBpbnRyb2R1Y2VkIHVubmVj
ZXNzYXJ5IGRlbGF5cywgd2hlcmUgb25seSB0aG9zZSBkZWxheXMgd2VyZSAiZW5zdXJpbmciIHRo
YXQgdGhlIGNvbW1hbmQgaXMgImNvbXBsZXRlZCIgYW5kIHRoaXMgd2FzIGEgcG90ZW50aWFsIHJh
Y2UgY29uZGl0aW9uLg0KPiANCj4gQWRkIHRoZSBwb3NzaWJpbGl0eSB0byBwZXJmb3JtIG5vbi1w
b3N0ZWQgd3JpdGVzIHdoZXJlIGl0J3MgbmVjZXNzYXJ5IHRvIHdhaXQgZm9yIGNvbXBsZXRpb24s
IGluc3RlYWQgb2YgcmVseWluZyBvbiBmYWtlIGNvbXBsZXRpb24gZnJvbSB0aGUgRlcsIHdoZXJl
IG9ubHkgdGhlIGRlbGF5cyBhcmUgZ3VhcmRpbmcgdGhlIHdyaXRlcy4NCj4gDQo+IEZsdXNoIHRo
ZSBTQlEgYnkgcmVhZGluZyBhZGRyZXNzIDAgZnJvbSB0aGUgUEhZIDAgYmVmb3JlIGlzc3Vpbmcg
U1lOQyBjb21tYW5kIHRvIGVuc3VyZSB0aGF0IHdyaXRlcyB0byBhbGwgUEhZcyB3ZXJlIGNvbXBs
ZXRlZCBhbmQgc2tpcCBTQlEgbWVzc2FnZSBjb21wbGV0aW9uIGlmIGl0J3MgcG9zdGVkLg0KPiAN
Cj4gVG8gYW5hbHl6ZSBpZiBkZWxheXMgYXJlIGdvbmUsIGxvb2sgZm9yIGFuZCBjb21wYXJlIHRp
bWUgc3BlbnQgaW4gaWNlX3NxX3NlbmRfY21kIOKAlCBwb3N0ZWQgd3JpdGVzIHNob3VsZCByZXR1
cm4gaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHdyMzIuDQo+IFRoYXQgY2FuIGJlIGRvbmUgZm9yIGV4
YW1wbGUgYnkgYWRqdXN0aW5nIHBoYyB0aW1lIHdpdGggcGhjX2N0bCBvbiBFODMwIGRldmljZSwg
Zm9yIGxlc3MgdGhhbiAyIHNlY29uZHMgdG8gdXNlIHRoaXMgbmV3IG1lY2hhbmlzbS4gV2l0aG91
dCBpdCwgY29tbWFuZCBiZWxvdyB3aWxsIGZhaWwuDQo+IA0KPiBSZXByb2R1Y3Rpb24gc3RlcHM6
DQo+IHBoY19jdGwgZXRoMTMgYWRqIDENCj4gcGhjX2N0bFs0NDc4MTcwLjk5NF06IGFkanVzdGVk
IGNsb2NrIGJ5IDEuMDAwMDAwIHNlY29uZHMNCj4gDQo+IENoZWNrIHRyYWNlIGZvciB0aW1pbmcg
Zm9yIGNvbXBhcmlzaW9uczoNCj4gZWNobyBpY2Vfc2JxX3NlbmRfY21kID4gL3N5cy9rZXJuZWwv
ZGVidWcvdHJhY2luZy9zZXRfZnRyYWNlX2ZpbHRlcg0KPiBlY2hvIGZ1bmN0aW9uX2dyYXBoID4g
L3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZy9jdXJyZW50X3RyYWNlcg0KPiBjYXQgL3N5cy9rZXJu
ZWwvZGVidWcvdHJhY2luZy90cmFjZQ0KPiANCj4gVGVzdGVkIG9uOg0KPiAgIC0gSW50ZWwgRTgz
MCBOSUMgKEZXIHZlcnNpb24gMS4wMCkNCj4gICAtIEtlcm5lbCA2LjE5LjArDQo+IA0KPiBGaXhl
czogOGY1ZWUzYzQ3N2E4ICgiaWNlOiBhZGQgc3VwcG9ydCBmb3Igc2lkZWJhbmQgbWVzc2FnZXMi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBLYXJvbCBLb2xhY2luc2tpIDxrYXJvbC5rb2xhY2luc2tpQGlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5r
b3JiYUBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFya2FkaXVzeiBLdWJh
bGV3c2tpIDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4g
LSBmaXggbWlub3IgaXNzdWVzIGZvciBFODEwIGRldmljZXMNCj4gdjE6DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2ludGVsLXdpcmVkLWxhbi8yMDI2MDUwNzEzNTExMC44MDkzNjctMS1wcnpl
bXlzbGF3LmtvcmJhQGludGVsLmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2NvbW1vbi5jICAgfCAyMSArKysrLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2ljZS9pY2VfY29udHJvbHEuYyB8ICA0ICsrICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX2NvbnRyb2xxLmggfCAgMSArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jICAgfCA2NSArKysrKysrKysrKy0tLS0tLS0tDQo+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3NicV9jbWQuaCAgfCAgNSArLQ0KPiAg
NSBmaWxlcyBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCg0KVGVz
dGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==

