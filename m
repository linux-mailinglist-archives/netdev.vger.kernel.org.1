Return-Path: <netdev+bounces-112574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1596E939FC5
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF83282E90
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5414F9F7;
	Tue, 23 Jul 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP5d/PQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE414F9E1
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733916; cv=fail; b=mzYWqzef1yb9qo2u/Aq8a3IG+NL9CGoo/uGVNT99ZRVgDHzKMNZ8VNzP/Shv6mGBVBbHhjANEfMjQi4A07qab/Q5rElVmHyUeKptHzdoG6MdkgdehV9pOCuSWIpQp923bZdFMeULbbq069BgVkGKwHXw8ACrmYyF8fNSGqssFJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733916; c=relaxed/simple;
	bh=wio0QUBCmvhm9INQ4FIM4AWNZjKNr4TKN7dfs+lINxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tL8+TvYvSd8mFifMzVDP4TvdGkJdrx0QdiK0ym3du4zYiOJ0MvG0K12NQIFawHR2S7prapsqTkqDiEWYQReQEpB+8PyFlekdYcUsnNBxP5RbvG8zUwodm9aJbmqkDPI5z707m11tLV5Af41ggz8pa7UyZbZi4Mj/n2WInGS2+Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP5d/PQJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721733915; x=1753269915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wio0QUBCmvhm9INQ4FIM4AWNZjKNr4TKN7dfs+lINxQ=;
  b=bP5d/PQJuiXb0Oj/b5jTMP0076sF+EoZzkHcOaCn1g2tlx11hZ0xqYBz
   vsqFivD78fq4Z7kRWMrtOZo8A/WNFu4exr6MUovP0lkHm5BSlA5b0dwsj
   6MBreSnhMK4gumTJR+ugGtEER0boHDdrGZ1DX2LmLz57KleA2LSLJkeDc
   k7mpNemUYhug1HaKy70ED+GtOqPqxLI5kmJdn1nwULqm3SZ9c4AK9+CHR
   ObaplNrA5ZsBbdEn0CnxXEJq1u83RR8qvYWPVu8dUPZummHkoFXqoErFh
   5GEjS3cjOeEFmyqKO5SlF04hL4Im7Vqwroez89y5JadahmTVOpeVdc6Lr
   Q==;
X-CSE-ConnectionGUID: +Q6KMuEQRuSjZjwNpvLC0g==
X-CSE-MsgGUID: jKVcGVJ3S3a58B9GgZDYAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29941549"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="29941549"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 04:25:15 -0700
X-CSE-ConnectionGUID: TbdXYoS0TLyYekWwok6DLA==
X-CSE-MsgGUID: s1fmk3Q+RTOysUrh9hnuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52219003"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 04:25:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:25:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:25:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 04:25:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 04:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uekLp0WOH5UgzZPJYSGRc9whoLu17Dw3vA9mP6ZcOAyIg3mvXqyeQaxobtN9gQfRsQ40ndICaJw/w8AlAfYFH9MiY7hJCHPTkL2PvQCCnQkiyW4YQjAlnNKqZ2EwYb3DHupH6x8wv4hbt5o0OeiTdonBKHzdEFdiChabqiCI+crssf0RK9n6sZrs1NFs3SLikKAkRdaQvnKXKT29PUfdHgcKaPCEo8idUnOV4f88Pr9mvNpeCAuM4yqfZ9JGX4kJFVMhD0rUka7Gtx8BE7x1sBdyOHNLanLc007tuUu+tSKHTwyBxv8oM+Zw+N2KBoHwsVw0+32hC8AptCG9mrYmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqquL6rsKupIPgo3Ctn5rilSvpAfZkmka6NgLKZh2J0=;
 b=URqF+L/7MJFQIOYOSoOajr3R8Qq1eZF+OOK4i7UuO8i4nfCAE/owUVjExyrg/tEryjGBaksmAxdIUJQkx8FGT8a916uUl8GCUbHwWC3HKFQWw5xx+74AHQg1GuUl8scGZH8tOMOKXORyM7zsEZYJdOkxE8mNalsZSzHDRW3MpJVnQaMfWrMyu15VvpkAPYYeAm+5PZND6SbSIvsfjdZZ/DSSWvpClTMfbnoy7s7ypi7lRtMENP3Y7RsARrGwinAqHdnv1C29ylPBfHqte2WgQ590bkBLY0fY126EsBWY1sHjw5j/9N2LLISpWKZ6nykDq8siN0xLp7GcELXX9dHndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 11:25:10 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:25:10 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v5 13/15] ice: support subfunction
 devlink Tx topology
Thread-Topic: [Intel-wired-lan] [iwl-next v5 13/15] ice: support subfunction
 devlink Tx topology
Thread-Index: AQHauAPGFhnkcDBUq0aBr5RCReN6LbIEddkQ
Date: Tue, 23 Jul 2024 11:25:10 +0000
Message-ID: <SJ0PR11MB58650556467CC6FB3A5874DC8FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-14-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240606112503.1939759-14-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: b2b0d1e8-2ff6-49e6-d768-08dcab0a1d3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OHCcIJXM+dHm7Owyk3DKpys3Hx9Czw6V6dnYWzFHxDtytbLePbFuN0rdXbB0?=
 =?us-ascii?Q?FDk2lr5ylofCUacajoIxZEHjELRpH9IXinnNKQoTwdk1uo3VLkE2MDZZI1Vx?=
 =?us-ascii?Q?t9LBhMt7yApQshseUFqL7MIiXKfohlL9WLEchN5nB4LrKMwkmdOCCccDRUit?=
 =?us-ascii?Q?r5MLrVv+hxXdokcxuJxAuBJoKdjwOBroQ9lg0EqLqDmSmCqGYmr9gwc+oE1u?=
 =?us-ascii?Q?mHnhmzBcKOQwg0vvC9vO6Fg6CY4FwtSjq8npwBHRxfBP02PY9s56I8RHGzR4?=
 =?us-ascii?Q?yc+Qjhpf+neq/Xf3/W/DsC2tFcMofzZPZR7LEwSzJn3JRhFdrM+xdZrw5ayC?=
 =?us-ascii?Q?gN+kvyup3mOsDj9YFIrGhhKXXRdeppdafNYuj76ZcCnZQksCpHyGJptZDd0U?=
 =?us-ascii?Q?itrH/Qxi3Z5ZOsFa4f7Pj7PKMZi4OTHmuM09v7Ub3wMHTyetm27q0w7V5/as?=
 =?us-ascii?Q?9z2ubEHSNT+ve9YPBzVRSq+Y4NwvUWxXL93ouvWJFNll/JGtzQeDNjuyXVYF?=
 =?us-ascii?Q?VjKrhPQhxIMRFW9UXuYMcAx1F1SOuKSqoMgVP1JNtubq3fGUWIQRyAOblK0M?=
 =?us-ascii?Q?s/EBE8hlNgqYqf3SZOdJ1yz+AiJpWex05sXqJOapOVHLBCMu+E1hQ2gx7MdI?=
 =?us-ascii?Q?pqBXf7s4k4GTjvQi5G0Bd2Rq66OzflvQ4vK9akqKnMSXo8PSdAAr2T3RqNLY?=
 =?us-ascii?Q?qDURZ+Gu6wSU714kQKI725mltJ++H9Ab/W8yBdPICjOcV5gF7aOMM2Rs3P3T?=
 =?us-ascii?Q?TUSoPCt3xIoImHZq/6b3xsz/MFzhahedxZxQT5T5RJTknD63IqlsU3XSXpyI?=
 =?us-ascii?Q?dY8A53zipUx2Nq+G3edcKQLe6a7zl8g1X2OxV9nsIk6W7mbnCe2QSaUSUibE?=
 =?us-ascii?Q?llGqPDDtvqfN8od1bh5ZlHM3K89sBbcmaTTc1fHjwdcSUAXgu0emQAXR4s/i?=
 =?us-ascii?Q?SIj/cL/ZSIvKowl54muGcUbFdRq1ylpwZV91TkPeZZ01rdEB6FBVvE6HRq4r?=
 =?us-ascii?Q?wbwn1n9TixCHFoAYPTIrpID9wT3epO2nBwI2LLAow7OH9A3GUXJx0Sl6siij?=
 =?us-ascii?Q?rLBHviJ73GikuptCXvEq7iSKxHqi/nTJVDYGa8woMAKHF14OPAZ/7XQZ1otK?=
 =?us-ascii?Q?pCwIVX/LMcuPLahv6tKzfzFxDrcSNR+B1vdhWwUTJ4oUKeKBDkk8euMhmVym?=
 =?us-ascii?Q?NxqMxOhNCVKYov6oy5jHpN9vrb1IOMo03efQHOmdeA8vsICFyLgtJJdd5/Mt?=
 =?us-ascii?Q?e7mYI24TOLXa/GTvytQxw287rvoWgv13VtuIWHMeceqDr6hteJpO1yw9OOx8?=
 =?us-ascii?Q?7DV3RcifQ/YyG5bAqvNR37yO5ZOkTIuy1y6c7aWgIGQpPVS2wTB1TDsj4gl8?=
 =?us-ascii?Q?HOqL30K5PjjzMSTfjOh33+PoQp50BKtDZNBn1IWtSHyfpwp9nA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yjH7JDMyf2s8Z9vn+GzpjxQxmVDVM+Qv5/XV9BOvRR0JzzzDMAZiRgU/Ji5T?=
 =?us-ascii?Q?varpUomoB9TZV18M8/jW4ITjHbYfvdwJlVCgZLq0jiV9ekICAGQWWAB+Tj5D?=
 =?us-ascii?Q?erBMfHKg/ueN7Jm3P7puCvpOHPSJDfHFKJnvO5LLNsQUqvqXrsNvYFm8rYyS?=
 =?us-ascii?Q?fzBLDuCdfLoFdrpz5UPX4cujgaKWpD9whHXLveLlItgTABEcSwImQmuESCNi?=
 =?us-ascii?Q?/lTHMrFActFH3QWyVi18scUO3enqnaUrHaXdyIvs1Ukkqn7ExLUvBHnd5nvR?=
 =?us-ascii?Q?wIG3/ueao5YxZT3lwo/ofxWEjoAYvEygeifmGX8k8rtV7eQlKdFQAio1ay5y?=
 =?us-ascii?Q?vcAoDb8oSDP4fT37LmIW08YfZQ1yEJMiDd+SSOwgae6rqjyaCzQQLGDRyaxP?=
 =?us-ascii?Q?uCxq07jWvMYxbetDKoaGUYkUwI99giWoqhkskZ6sZsUbma77kHkB6z8UIahC?=
 =?us-ascii?Q?orKIDH7Eia2Ov75lZM8gNZBy0fUmiMfOthaddwGRiKx1tqB7q8Tq4YvUYRCQ?=
 =?us-ascii?Q?YJOtbHIWfyye+ErIy3TO/nCEuAxxsHWRhBYZDSKzZXt4FSHSNKSuqkYsKZp8?=
 =?us-ascii?Q?fdgI8JqQ2fd7KEko50y2u3y6+qP0Ziwp4raZDcZOSYCndSLRfHxRTes8f/Vk?=
 =?us-ascii?Q?EJKSRNlGt7BrJQNwG5YPPJ5ebEnpMrA7Nb5CnHM3yOWcM3b0x6RglCNxPBbH?=
 =?us-ascii?Q?8mXT3uQG9iyA6eVpK53fW3FVcFBz0cwQRcNAcndp8bmDOf8arhZVQY2Hw/ki?=
 =?us-ascii?Q?+Eozgg1R51QwC/8wqxqVDgpgAqvE1vCtCG1zBUgsM7usTvPh6EoW9oCbNwwg?=
 =?us-ascii?Q?3iM5DqwmhszIywoIKeTYUzuifCy217ojRpbw1BpO1o4wtQVGh68U87Ql63ex?=
 =?us-ascii?Q?RxHQ+94ugrk+uu0A+XQdrA0Y1nlgPl1WJL0qMXW7CPCxha+beW+UcbLDjWeH?=
 =?us-ascii?Q?G5Udy6PzBy0Der1Brs7MeF7UZz96vLiNSnw4eNuh/GZHK3c/MhukrNPdhVO6?=
 =?us-ascii?Q?MrYvrsdUD20HGJ8IVPlfTTwyaLF1qMh9mXIR+S6m/OSj9HynQdvm3WqdrU12?=
 =?us-ascii?Q?1IbeHWLxusW3j4/f54PZ7tgFahnbZg+ZEIlnvkDTbNOajKdSk8vIz2iDYUnC?=
 =?us-ascii?Q?K2m3pOGiCngQH1YWdb1rKLn8d781IJ0QvNd46m/dLXNw7qLKknPbB6gSgRmH?=
 =?us-ascii?Q?oBVProAEDOHFHn1kIUlQsQ+yN1FoyiDIwmBHwAlL43FQF2/Grlik3MvoxsVO?=
 =?us-ascii?Q?pBiY04B8B1ATyvT+Wy4/8N37gRdhH0cr6146TdYKRGpb0XX+ftCjBNwYQ7dv?=
 =?us-ascii?Q?KoMB1I+I9p94z51xacZth7Fm/b3MRWMAktYY/ctzXTkgFLygT+R+nKx9uGtf?=
 =?us-ascii?Q?nloEKjdEdWWZnjId2RT5hI53TVbCWjMMvEQLaRQJDhenMvePCSuIETLhpt4y?=
 =?us-ascii?Q?fUcBQVbN8AKGdwq+SKYtpJH/mbVYPPk1JEMpcjsQdJ2ZkT2IGKmWW0VZl7jI?=
 =?us-ascii?Q?Vj8omOR9ssqw3443Vm0pifLtF++nf93s+7b7Pp9dAsEQ9Rks8FKM4sTvc36e?=
 =?us-ascii?Q?hIJwsp51zridY44jj/s17430EtjBVwf80TLcC7MFUJAWN1ARx5saW2nFjogm?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b0d1e8-2ff6-49e6-d768-08dcab0a1d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 11:25:10.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7DnA4vAqWPH0aOGbwHmAyWgCuHh6kLeN8eBYlmdbVZ5vaAQgprQ2RJPx6qBMOzlb8Qg1NVjNMr9f6UULuh5L4TYWReQTNZXTqjZ88h4Hhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Thursday, June 6, 2024 1:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> horms@kernel.org; Samudrala, Sridhar <sridhar.samudrala@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@vger.kernel.or=
g;
> jiri@nvidia.com; kalesh-anakkur.purayil@broadcom.com; Kubiak, Michal
> <michal.kubiak@intel.com>; pio.raczynski@gmail.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v5 13/15] ice: support subfunction d=
evlink Tx
> topology
>=20
> Flow for creating Tx topology is the same as for VF port representors, bu=
t the
> devlink port is stored in different place (sf->devlink_port).
>=20
> When creating VF devlink lock isn't taken, when creating subfunction it i=
s. Setting
> Tx topology function needs to take this lock, check if it was taken befor=
e to not do
> it twice.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c     | 12 ++++++++++++
>  .../net/ethernet/intel/ice/devlink/devlink_port.c    |  1 +
>  drivers/net/ethernet/intel/ice/ice_repr.c            | 12 +++++++-----
>  3 files changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 9bcbd04d29a9..037f4621e517 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -746,6 +746,7 @@ static void ice_traverse_tx_tree(struct devlink *devl=
ink,


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



