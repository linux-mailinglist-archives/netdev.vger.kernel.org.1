Return-Path: <netdev+bounces-219801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01BB430C0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EEB7C02A6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB21E1E12;
	Thu,  4 Sep 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDObxytf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17813DBA0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958574; cv=fail; b=N0K1Q3YfRxMxY2cej1YeumjXouDYRK7+vJE99TestvMGPEswFU74Bb1eOzmLcwpu7p0iLFaszBmw92mMtweM5GevS1eC9omfBEPGYstvwPAVWDjNZAubUt5c4JO1NAQgST5tb+EML+fRaa0T1I8ith8ofBCxDc82LU638fOBvqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958574; c=relaxed/simple;
	bh=XIywxKlivQH0vDaLq/TxDyfXzq5nOSnXDiMZyvDcOWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRBsn3G5tYAEj7RhMF8Y926s5cpXy5gZkw2vXsLoEVj1xINqGyHJUtPxClq7t1Upr1OvYs6Sp4o5D4ksLX1vv+ydeMUnXYANBh/X18Pr/fgJT/B23sTvN6nNrtxhzrT0/aUEM+mS/j+LQuxHOiz+s4xgz5lCpAQzqcit/I2xsqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDObxytf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756958572; x=1788494572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XIywxKlivQH0vDaLq/TxDyfXzq5nOSnXDiMZyvDcOWQ=;
  b=hDObxytf7uyrUE1LcThg8X6LapqQlREtc4BGSMtGYrE3Rov53ujn43nN
   6YM5quBc3tF1wDCBrQSru6DreiaqgB2IOTgg4E8NiOfpJXhp7/QPkNigS
   qNXmgZteaP227hvV62ZE+JvOHnWS+rhx9gyvTw6k0Bl5UzvYr/sjmlout
   1PFXAC1lBXVkZCDXSvBNdZvtMAls6hw+RtLnPn/mEiC8TCzfwBhDBuSwf
   yOPgoMdL3N9AL9p6v/4uOMjTTHfJKX56ovg1QwdYaQYHAkzaRD+8/42f4
   27GcV5qfrW8SI3ZZ8AFGk3DgW8e6zWBOfCaszVR+VHKhgDV0HyyOcacNx
   w==;
X-CSE-ConnectionGUID: iHv5BFy+T4+iOw9LZhoBog==
X-CSE-MsgGUID: vmOItvVKSde5s4Zp+beEhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="58501567"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="58501567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:02:52 -0700
X-CSE-ConnectionGUID: GDLON8FhTReQd4DMaiXZ0g==
X-CSE-MsgGUID: I3PCffxCTVufaUZ2xuTtbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="172606116"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:02:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 21:02:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 21:02:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 21:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9MxJDVjz1fcJ48i34AeaU+9NXdBO/gavkGDDRu4Cjsq/FO+fEUuclNkwmwb2FY0imIQaBod+wuKnVZHdhcEkvEkJMcejdWVyyXPIJ6pYdDhGcW+ZrmfKkznF6Krp6p4zVO6NEgygH33QZ5XCDQ6NMXzCUuABF1dpGQzn+rPoDGHAgKkbz8L2avvb+M1v82jZSTzQZ9UvHit06Eu+hVkz9A1a+3gzGn0xtZy7anTDgN6xMA/4vxBA1fGCQfuje9kt3ydUcFk+YmheG38cCjWNqjKGAXg/IydTa8KJTPQLVaY+AZ/jeeqarqsa4GIJPzvww52ARSps+i0+rfsfE0cbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btj2LJVICpqPG8GOYHHx3htd+PlKj4A3aU3AIFG4ZSQ=;
 b=nCvXQUUXDzDY+ENb9OSkFqRxDQXQ8E/XwGP8XtT5iNspQqfgcXdKNFbaVL7B3vHoulJqzaJDQW+J8oSLe/K8D0ckyltPEDDZsGBF5CRXiTl6NgpzMBiArlVNoOrWm4r+PhEPekFTeGHlHOWHR13J0QgRflvkDyY/uXVbOMBXaCbskz8830nC1nZb+8dLiCMyELbVaUVkZ+N5JYxUhc/tuKuaOcqVv2O5Vav6+WQmLreyuFr+dI1Ex7Oc9TEN9gLTxrdR+GLmm2h9zXLfxkzHg7XFKjMRdIi41P1UudN+T4pwN9zwmjuPM3X++zBAp2BC03339qLek1kzdhh3lIngGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 04:02:45 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 04:02:45 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "dawid.osuchowski@linux.intel.com"
	<dawid.osuchowski@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 07/15] ice: move out debugfs
 init from fwlog
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 07/15] ice: move out
 debugfs init from fwlog
Thread-Index: AQHcC0U9zIeenx0eaUGtZRpkTxWGHrSA/VPw
Date: Thu, 4 Sep 2025 04:02:45 +0000
Message-ID: <IA1PR11MB62416E139302BB48DD9E86D18B00A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
 <20250812042337.1356907-8-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250812042337.1356907-8-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH0PR11MB4774:EE_
x-ms-office365-filtering-correlation-id: 87f0a44e-6b15-4a91-bbec-08ddeb67e7b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BbTXu+hWuDVfYSzBM1vj8RQD9ReS8mPWz72tbbZs0EVhf/hTF8AnLaRKxPRa?=
 =?us-ascii?Q?eSx5BWF9iEl9mhsrumOJEI5J930B8sUZ8CKenlbCYsRoDue6ccEv2vNF5tq6?=
 =?us-ascii?Q?ulCqhbkvA7S4dL8+lr9XgthGbulZtuunNnuitDQHj84QckYn75SHAf3NFWnP?=
 =?us-ascii?Q?W8SARgTh8poEsIOgru/ufcAwN2juSb5L9m7bQ2saZDXr8Llf3EMwGO9mz60Z?=
 =?us-ascii?Q?9UqXMvb1vjQi8XAdizxsxgcElRSp2psNKzmGWcHOIMDK2qVnpMK/51ohRGJM?=
 =?us-ascii?Q?qZ/SNSYscGn0x7V1XIDPuGWlZfjv01XisBnD+Q5ptMwT9vA1IyQRMXPlqTwB?=
 =?us-ascii?Q?xqbQlYsMkTTPhWKiiukrh0VjaQsqafiUVBawzs/nh7SbGtDVo60eqeBahLEZ?=
 =?us-ascii?Q?ZRlHq2wfzMPXJjTrjlvLbUOG1C/qrnjR/Wi/WOyEfgJkwSF8WHye940cqysX?=
 =?us-ascii?Q?7oZWRlqgLxWhYHenB3YbfaswIf0JJ44Lic0SzF/OiC2I0N0fE4LVpIdWhoe8?=
 =?us-ascii?Q?HJLmcJ+LfdwUnm3AOK64OBPEpwT+zWTolgEaS+xJDxd/dk/5f5qri7y0BlnV?=
 =?us-ascii?Q?CFNBDp4fXONz5Hx2RcajZsOyGbaX/0Qh1FqF5dZdeJXNC0iW8t3jZKhBBsW1?=
 =?us-ascii?Q?gnCHa9G40lLU3vpYgE5qoZgK3PKsmY9HHODSLzlWSgA8pwRTdgW8xPoOucNQ?=
 =?us-ascii?Q?dRJsNtE921eQe+sAzqPdnSBlQEYhy5XMGt5g+gInlgf+PXvPBMtorORgsekF?=
 =?us-ascii?Q?oBzq14c36G7TbpNxzUdCLPTw4uxchtiXt2zqhmdjgBck/bPcNsrW3g2w95nX?=
 =?us-ascii?Q?jAkxtTCr7TOTy0eOa3cBYRkskj1tvHB5w5OtlC5obD5ylFRPQz2yD9bfVmeB?=
 =?us-ascii?Q?WzffOJ/TUbIjeIXi/5bnUbaVQqYiv4p/V9EDH3xyhtCoCNgvrbOSkzUwTqNW?=
 =?us-ascii?Q?JqkOBhj/3XF6WoMOemLKkGge6656dL8BuEIH/QikCpbfFHUkp9fanCKVylQP?=
 =?us-ascii?Q?cWh+dug50rWMJqvEPWTGzW+Tl53iwz77ry9wsaVKGygGb0jzjmCOV1ODqc0B?=
 =?us-ascii?Q?k5HdAOLF3zyCzafvoLuLRq/ZP7yDXgsLL/bm/xjsuRtPZwvRbGzrwj5pa0cD?=
 =?us-ascii?Q?5M+fFNhFBmqeVcGIU8NDP8L/US1KYQpD1jmFoByqHb9Ig9S2geODHXIcVXZB?=
 =?us-ascii?Q?Bod1eoPdsW5Yw7KLzd4O3nTeCvR9aLrcaKsu/UelLgUE9Uh5SPyIAR0zuoY5?=
 =?us-ascii?Q?Rg9IikXkjDW5S0JrqqhyLLd6i7HltpvSpR7ASnR56qMcNXlBEIuKzsHd3HYF?=
 =?us-ascii?Q?87WGf6HGsY3NrcOhTTbHADsijRiS1TdR4GjtkEZU9N5XN8IZTuXE++2bNmRJ?=
 =?us-ascii?Q?8YlsXVHcpxPnoQX4NqwU4ruf9MDiXRuO4wksSvKLbh48/0OvvL7WCrSKwG2L?=
 =?us-ascii?Q?P6mnaVDr6Zi8jRzc9xRXBOf/oM8H48mSgkYnpiIEtiA3Gcz9z7pi4g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5j7v3LEFIIqApPpNDUh39gBBhIEitqnnURN4u0y5R2qKrCCaUl3Nl4WRs2jv?=
 =?us-ascii?Q?ImhB6ZRU0h8N4gfMmdeUs+AmKfzBHt+UPk2XIPLokm5swavF5xSdEhcbfH5A?=
 =?us-ascii?Q?VlFDdN0NkyfvViPI+Mp0TuSgwo76qfARSFpxMBR07BFIG7tKfpgE4TMNep9W?=
 =?us-ascii?Q?egkNMPPsZjcr5PXVwqZ9D2q2mIALlTl5R2NUhs7zl0WcLz0cQ0tjSFFX2cow?=
 =?us-ascii?Q?/KWROU+SAEU1ZGXyZtUry/K8l3AzDhRRdkiWXHZxWmSfibizyNq9tC/WVU9C?=
 =?us-ascii?Q?EERtb3oB5IXYa7YLPBCHnuT417gq2/Ba8gktntBmD+EDJ59uGByWgAYT7E22?=
 =?us-ascii?Q?528igmy44rpTNaV0d7rynkW2FcaJTvJnzBVXll+F0XWm6Hlalh3ur45/CN0T?=
 =?us-ascii?Q?pOK0x3cN5gMbYBiac5JJ4T7j81M0YNiAc0Dvv6DpGv0WI10tAEqFIMQ63CfE?=
 =?us-ascii?Q?ic42Hlnm0vp223Uh+/jlVIOKBgboRABQqGAN3g0SUUKGBBocqdaiGOIdMLDB?=
 =?us-ascii?Q?JyhVA+X5KBnW9e2fDi28MwQLeMfG2Ggy5NMvgbKOMhERpgTq5EO7wv/iltP9?=
 =?us-ascii?Q?12xWovRfuUaRVqvek8v6NsyQPxPHzDv/5hoXtYfkNmIPNJUJ52H6M940Fvwp?=
 =?us-ascii?Q?sWjORDRwRzG5IwSDm7WBrZMvvC9r0OEeJlZjI1I5K8hobRAhHR7DWrSeyvqv?=
 =?us-ascii?Q?Iddh8jGiHNF6sviAiWmy8Ct/GBj1yEkU1e0YIVYUgq5OUp49a3zs98xTafb7?=
 =?us-ascii?Q?UPfrBmKMGUMGOaQLRz1hSfTFVXniNu1AaO0bP4mxD9tUEW3hZFzHkWyw4PZk?=
 =?us-ascii?Q?v/e6fHRzqvYdU8d87sWustPZm6TYpyyoUWt5yhg2jIu72luhMWpo984u3Cwe?=
 =?us-ascii?Q?yG5VqnGtiOg5ISGDKve+YtnRksTK0PEcU3gv56m+/MLcmbXy/tfoxYHggiVX?=
 =?us-ascii?Q?KU2fdGX+qBkkkB6OLatbpNnNsaDhUPMbuKb7govPlwd0Osw8AmQ807DVImpx?=
 =?us-ascii?Q?+GnIe7RZFKtKybWxc4xQYKUD/jDgILQh6npNG/rbY1itOyfV1UzIPPKF3N36?=
 =?us-ascii?Q?F/z9QT/ZpaZHeyZJ8+NM2TU3LgDXDOprV3Sr8vQu55taBZ4YDO7Vod1c6YPl?=
 =?us-ascii?Q?1GsmVaGKckrAL9LaeaiYtmRkijcSB3I3ipUnUYPJVvk7l0srNs4IHSCFkmzO?=
 =?us-ascii?Q?0tr64BowXUNPoUESlg+cEPOk580HNALK0eZ6LTnhMWihqMELUxbDkZ/9ndQi?=
 =?us-ascii?Q?kxliKAAEQ43c6zawNz8fL8toJZiz7frY6fhk8H4RjG4VshsXKPfS56wWu7Rp?=
 =?us-ascii?Q?Os+Ccpf0lCnCHuUm1g55DCjci818EUpAf2r3bAMDtK9b5A0iV7kiEr+T9Xxo?=
 =?us-ascii?Q?wSGJLyoj2ry9vQ6iLVhOAKoUMxXahtHTey8SK4R6L0z8ZeQCdLnQsxhMkK6f?=
 =?us-ascii?Q?D7iYhCuEys62+fHD8mv6Ep14Jjwlxcl/x1h1gY9nA9g1Yl92DWH53dlU6Hvb?=
 =?us-ascii?Q?90QmaYY+lvN6r7v8wyBpKxXs5mjvaQjvCWHcWhgj/vzz62/gATx8KAkQKsWb?=
 =?us-ascii?Q?GhcmF5sbMhJldw+ckxkl9disSZYP7LU58V2fTKyj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f0a44e-6b15-4a91-bbec-08ddeb67e7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 04:02:45.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9YTdmz6zhpZDOkvU1qoNvpDGWPQPpJqJyTzgZsBWSv4U9mXlYM29xA94mOd/iJd1Kkn7eoghL/c+styP2zqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 12 August 2025 09:53
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>; dawid.osuchowski@linux.intel.com; horms@kernel.org; Michal Swiatkows=
ki <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 07/15] ice: move out debugf=
s init from fwlog
>
> The root debugfs directory should be available from driver side, not from=
 library. Move it out from fwlog code.
>
> Make similar to __fwlog_init() __fwlog_deinit() and deinit debugfs there.=
 In case of ice only fwlog is using debugfs.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice.h         |  1 +
> drivers/net/ethernet/intel/ice/ice_common.c  | 14 ++++++++++++--  drivers=
/net/ethernet/intel/ice/ice_debugfs.c | 20 +++++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_fwlog.c   |  2 --
> 4 files changed, 28 insertions(+), 9 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

