Return-Path: <netdev+bounces-174096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4437A5D665
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE43B48AA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A121E51FF;
	Wed, 12 Mar 2025 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeiXQePD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EA35947
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761420; cv=fail; b=qyj4OAVswLDzORJGn8IWTKv9bKgRfJY1nT/rD8Hv8WHqcI4i0FEWs3hfvxJPvz6+IckztBlMPu2oRXAZOTUWx19QS7MUWODPSCUkQPLClwZEv3m3Zkovc9kbmpp9DRDLZZ5HnHJMFw3oiSczJYTXODvDgBuz734MFEsK/acXzVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761420; c=relaxed/simple;
	bh=wv33mNugYybXDETRT6H7a47zOJYesnru93sWT6m45ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jn/9diFyN/vsB25g2zt503znKLg5L2Ep//uDxLpAzGvRePEBovhD/oy9I5/r3jk2ARfnd+sHXO/Wh8kdGMJ9lXEVhhilZxfnk/7KcOg2T8xdaymQzKzNbyvZmzK5y+5iCf1YnPeT5UUR5CzQNXgn1Z3PXVUh7IrLaXIFZmc3NXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeiXQePD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741761418; x=1773297418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wv33mNugYybXDETRT6H7a47zOJYesnru93sWT6m45ps=;
  b=JeiXQePDQbqfnvbvpEWlDdc5UIqAbVUVimu8bKo4m3iQzYk09JaV+p+w
   L+LaQ8k+OJS2twTCeg3eLeO+LUop+Nt/E8X8ffu98kKJOS31wPvIuqt5X
   ZEsi25VJQQCl/ixdt9ddUo6v0jdiQdIure4tNuM3aPfKa5usPsdHeldti
   YoBYw4bRjcV3lpxIRGhGDc8PG73uOvpBLbF6CbORpDbj9va7DSZf7xbHi
   aQ9jc4M9ihC8bMJX6wVJCmunugzM5oArRezIF3BtlqhgWdNoCJetRhVvh
   1NHfu/ArdZGn3oCrYJBCokpnUzxMRwLYaLiVAAJVgNZMcHVzlYUQ2Wwk/
   g==;
X-CSE-ConnectionGUID: 1TCqoib1S/6ugusyu4OIjg==
X-CSE-MsgGUID: FYgZZEV3RDWK9zgEcNEi3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42739327"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42739327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:36:57 -0700
X-CSE-ConnectionGUID: RgJ9k5yRSBqsNH7D+PLjmw==
X-CSE-MsgGUID: Hmf9e7KwSdOK79VZtWKDTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125579020"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:36:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 11 Mar 2025 23:36:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 23:36:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 23:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rftuvstXIog4kdJyVR7/XA4UZxprK4k50ExlW9c3r9FDraQ2rrfCOZ4GkNqjqbH5oZK8AeSdsns82ObBDHzXQGyQ5tKakTeNdtrhg6YhLGnv8l3Ig9f1p3U2JS/UhMMEk7csCS2LwoG3kSgubRXpqW2MJML+x8G2pK7iA8ToIxKsKPWvfI1tBl/LDQZAUYktV/grGI9ycHQha1SoQPecTuNm3Q15b9zEvMAnriyvpHo5f6eYBJCQDpqHHuH2fwJlU1VKVwBHygZ2wNnBfc9cPk9WsNwyEu0Ok+FujWWSbiPNJyyP9UbUKCHznOno1bW8j42oRXCCM19gMwYC9LKolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUH8UT2Fpuy4mrTAahJ2NYSsNmiHeg/oeU2Rwi06Bnw=;
 b=t8OIq5c2U51jFYfufVpKXS1Kh//GxyA/vegYLyAv8DCf1RBPpZ0t/8HewPEVMKZvEB07dbGKqz3U4OASZWVdilQEHi3TILE6WhjyEze5KJF/APeeL+NyPaNtIkOMMHSbUutMUdf64uwcWr6EXpVFjwYLE2lWc0ZO6SOppRNyrpjpaiD8NbSqc3q0MBPQnp/+9elNa9PrqN87Uaz/kpYuEHE7V6N0P+nWVO2TNej7stOxtoC5QPsvyA2r8ThtXSY6jZ3bWwH1vBof4VKSQfn+43O5Q5DIuXKd2XYszXiDxtJ7z6qHjQKcvQqmCXw2/xQ9vYpeNVMfEifgBKfE1uqhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by PH7PR11MB6649.namprd11.prod.outlook.com (2603:10b6:510:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:36:53 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:36:53 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"jiri@nvidia.com" <jiri@nvidia.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Mrozowicz, SlawomirX"
	<slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 10/15] ixgbe: extend
 .info_get with stored versions
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 10/15] ixgbe: extend
 .info_get with stored versions
Thread-Index: AQHbj26wpWklysdPL0iAapntHvBhFbNvEzmA
Date: Wed, 12 Mar 2025 06:36:52 +0000
Message-ID: <PH8PR11MB7965C83AF1943B8FBBF16846F7D02@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
 <20250307142419.314402-11-jedrzej.jagielski@intel.com>
In-Reply-To: <20250307142419.314402-11-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|PH7PR11MB6649:EE_
x-ms-office365-filtering-correlation-id: cd1ddd85-9381-43f1-924b-08dd613046c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?aBOTn+sU6FY0aSUcwPfJiu+oEUHlB2BU5+ovZO7O10UKqs3Ce6At43+4E6FK?=
 =?us-ascii?Q?6bs+OcL6yYIzWrba2bx8adDitbc9aj4085O25uCJEtMcuBxzFKAc3A+gFNag?=
 =?us-ascii?Q?2yIZWnVvUPbBinJJUWtIiQJc7I71rcqAWZFJwaAa/rM0VJjJlyC+twrBi3Yy?=
 =?us-ascii?Q?XS/+sUOiR3r3YrreQtwD4THrPcsmbZx80G1bvkNGIw/rkNzws7Yu0s2Ehbym?=
 =?us-ascii?Q?2zHCXDb+slAHMsXS7ea+uo7q7rZT4noZjaLc4bXE+rzB5g2X9o8X/bGVVVz/?=
 =?us-ascii?Q?vZw8RuNrVjzH15692BJzSdLa4xgznjjABRfAn8huWRyUh0diJKtvzvmzZTEh?=
 =?us-ascii?Q?3QpdQvpwHS1VU08KxBZOske9wZpyTCT+BWnQcbxyMGOvl+g5lk+a1BiCWaAu?=
 =?us-ascii?Q?L5OLBGFqY6UGZejkSgTeEoaiL6BRF/TSThEzxJIMacgz95W4tF4ZkyMtk62r?=
 =?us-ascii?Q?4WFkPIo7ObWIbvRL0S9Jf8lxsVt8ElHEr5ovGX6YOKQ2RTQh1aYdaVr/bp97?=
 =?us-ascii?Q?/ylpQQ7Ivj7FD2xiXZc/CzJjuiJWW3DBGj+3bkqDi1Wru9XvXGmuCBp+nZZj?=
 =?us-ascii?Q?lmAxxKqg3SRQLdD8nxsP22N04rbVyv7URDk3dTxjh/dTlqxAHLOJc+d8X/xk?=
 =?us-ascii?Q?o2HcROdeN4bKYwPqFfAZwlTBp+xNbl9Coeo6mZQn0wlcpZZfb5k4G8zCLwaj?=
 =?us-ascii?Q?aBaZqJFcL4XSPbz17DKNoRz6fsb3KdUqCOwKI8IvaxZIHi08kcfs7igeIg4B?=
 =?us-ascii?Q?dEpDUx7hUtVRAgzd5Ylg2CUmehFVJqHlrlEzB5+pTcxnRvo+nEgx+Z+7khS+?=
 =?us-ascii?Q?FsSRGWRsI6vP3MSMdZLiex9Aceg8uJuW4QK4R8RIa54d74yPYab6plUn6433?=
 =?us-ascii?Q?XfC3PTC20GmPGCYR/8LPMfAgauiYQej/1XPhdKZEUpF8EtKj4EP3nN0/28y9?=
 =?us-ascii?Q?fHPDINL70mNsw749p1P01YMhJXSYZ90LwBbFFLfBo+q4UgMyWX7/RKIpHHbI?=
 =?us-ascii?Q?Mva68D1vUFVtpdqhdLM5ytfXsce2zNCF+Pdtk3HJRqNi/afl8Z8JlyFnVeZ1?=
 =?us-ascii?Q?xRcwzf57esJP4DBlje6VVuN03jRwLpRR29G4F+cwjFlJxZPFNaPORK3fB8W3?=
 =?us-ascii?Q?lujjV65L8tv1CAvYApnUsKpq+4MVKVcz1F73OHfz9ADNQgVv+YvZyRcdVlYm?=
 =?us-ascii?Q?VYAYOYpgcsrceYEuw7Bky0uAoa50haeMimg2yeTgIKrkd1GlA0l3s3uFJnYN?=
 =?us-ascii?Q?VKTkPl37yBeq3Cwk0OxmKIHgjSGp47PIDCiSWHpP6IAgUnzvIM8m2AwLhy52?=
 =?us-ascii?Q?MJWZfLuPQIaU4+WFOwaGVap0syvAej1dkgczCcFNZGAhDYVMezCgluxzU97/?=
 =?us-ascii?Q?pq1Pdj3qbHAJH6E0fPv3C8AwAbMI4E/ChI2mJy9bGnRHFJAtFAcQutL6AUKM?=
 =?us-ascii?Q?6wb061dnuwE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YOBcu7/V9TLouD9VNc3oDFSzWqz9e9NdaDwvLeIObAA/WVA6sPIJDpwS0J95?=
 =?us-ascii?Q?X/XDS0N58EHrTX4ZkIrB9hYYmP5EOSn5RvG3TDeaf3IUgnIfZTjDYv0KXVpe?=
 =?us-ascii?Q?vbuxL4PRIwOCNi5nu7Kaht+tBDqwpEVQUfe29p6eZdWP/Tv4Pr9A9rDAQpEf?=
 =?us-ascii?Q?guIpwwzDCghHvO0XmBvOaFMjeH9iFX2MSQXfjjtOm4PKSrdEJ3Xyj2rNuqxD?=
 =?us-ascii?Q?T7pj9qF8VBlbcdNKTtWvM+a/smMcRoJI6Vm1qrpWjWTs95QDVrb5WetMKB0w?=
 =?us-ascii?Q?I6RkV3OksBCvhOKvviGqPT84N7L74SMgyXerKuyrYesS5I5JZPCbMJvIKyRE?=
 =?us-ascii?Q?4cpjhNQczGJlC/AtmK8fQQYbHwFvREuK8iTQUhlUNPCejSkQTu5aMM9MVEMi?=
 =?us-ascii?Q?g4P9DU6sMi95X3gEbstTYMtIMmfwWF/kK4Elq/5f9N9KTt6Ge2XuQPdt8XlD?=
 =?us-ascii?Q?gLrJenwpqmBlasrzUh2QJUU0Pm7bpKyJVTZDVBy7D7N4oPVUetdkUL4juVln?=
 =?us-ascii?Q?pw1kAiLHYAGi65WiyDRSiEFiNQ5qCiVhCJeTWWZQPhN6VRRzjjBQYUqDn0ge?=
 =?us-ascii?Q?rCBiS/BnWlsM8UrrN9wpNQemEB+mGGLyFrNhhck59F6WK17zPABuMOwHAGKx?=
 =?us-ascii?Q?QxEbxZLQ+yXvDy+by+YN8zLn7ktmKhtxlo7bDupgcccLSahIWrZXRGWHb9tM?=
 =?us-ascii?Q?WsgMEraAwjR5sXbXzrfj0sFI9oBvdI1PYqz98mgvYW8IkSQScLK59k2Yg7Wi?=
 =?us-ascii?Q?vSuQkbrqeCWia/kuGfQaHXxdv3BGwoeLlj5ShpsH8Typw5pfxUXBK3b62wHJ?=
 =?us-ascii?Q?3M+eFWDNn3GKiS4SEjuNlpASrgV/HxNKhxFd/UeZo8yRwa5t2+0e3YOTxe5O?=
 =?us-ascii?Q?1cktnsZCg94t5MccnFiOP3hteJy21XNr/H/bZAKafjjXKU9Z4kBMFWZ3yPK/?=
 =?us-ascii?Q?DmxZJQZByVDvrsIPZ0PFcxsjxC+U2Z9BuCiREXeucRHRtXZGd5kVkzOT7fwJ?=
 =?us-ascii?Q?v5DdTg//fVedwB1CIX4Bg7mseKvsP49e4/E0mJhMD/dzhoWQp1a1YNkGbI59?=
 =?us-ascii?Q?EXQlWT2BgU9Z5WK8j+mQeMopxZ85kFLVQxynJCajzO8tPMOgxrt2EzrmK1Jn?=
 =?us-ascii?Q?ZfB0wGUYgF0PiloPXGA+3yurVx/eRJCHT4BSKKxhRPE7asJQnQaVEzYuIr4E?=
 =?us-ascii?Q?VHZYoc2bSFPlV5vUNfk/zdz8QI1LjJ+TKIoIBPc1k7idwusDMS8P0B3b9xGZ?=
 =?us-ascii?Q?Bnm7uhX1piyFsM8nBBUeOyjCE1tlZlfN8XOhn8erFi1sP03wDhnbw8DXZ+07?=
 =?us-ascii?Q?3wKebihGIdzBCtN+DFf2uhyEIuG2MScEkKrUV13t2VzyRoruKeHIXHnckr6v?=
 =?us-ascii?Q?ZZI69bJkDutlvF1ok6GByVba65JSqeE2Dn09+KG7TsJAns3FFYLf9H2HCv10?=
 =?us-ascii?Q?zldO4nBDGiaJtPUzzbDtb/MaSCGniCOxCf9athuo6NJr/IhcD5ZsZ7FL2Dh5?=
 =?us-ascii?Q?kBEGgIP9fzV14LmNYCr6y88naoQgk0XrCIiYAy6nF45uWlDAjYK8X8NZBiVC?=
 =?us-ascii?Q?JdehckOfOIeg19GdbSV8NHhgaLDvwPqRjvb9WC9L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1ddd85-9381-43f1-924b-08dd613046c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 06:36:52.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spwBBz+TOAAGf1XlZx4kNjQWJe4yGatRffA5IgJwLIL+e2SKkyd9CqyaEEuav+eCmUIihRNaqBGvXG/IjepcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6649
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, March 7, 2025 7:54 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; horms@kernel.org; jiri@nvidia.com; Jagielski, Jed=
rzej
> <jedrzej.jagielski@intel.com>; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Mrozowicz, SlawomirX
> <slawomirx.mrozowicz@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 10/15] ixgbe: extend .info_=
get
> with stored versions
>=20
> Add functions reading inactive versions from the inactive flash banks.
>=20
> Print stored NVM, OROM and netlist versions by devlink when there is an
> ongoing update for E610 devices.
>=20
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v3: use devlink_info_version_*_put() function; squash functions dealing w=
ith
> running and stored versions into single ones
> v5: add else to if/else if statements
> ---
>  .../ethernet/intel/ixgbe/devlink/devlink.c    | 214 ++++++++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  59 +++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   3 +
>  3 files changed, 252 insertions(+), 24 deletions(-)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

