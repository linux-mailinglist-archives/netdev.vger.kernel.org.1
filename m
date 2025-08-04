Return-Path: <netdev+bounces-211548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42584B1A0A7
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A3A174906
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0D1DF265;
	Mon,  4 Aug 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oc4Iwwqd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276F15E8B
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307691; cv=fail; b=mPAlw3q32LYtws0YjM4wqoEJB8ACvSkhXpVf/uLY0tHHoQBBtaWYxwpJMUVa5ES8IofunZC0piUNA+gkLW7dy5r0aWNt2CgvSew8aOcHiBZjyZNE06xgzo66A0ZmPySb9Hq/xWXuDJ8bD+cFQoH+0lSMiZnWhaMUvv9zJcU+5zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307691; c=relaxed/simple;
	bh=AepgNZ7P7SXFgoBmnhHVx19wynhuOK+XU2wQzts/zqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTBML+6mI/mmyIzyMChLsSLKNwQx+zIEaFE+Da1d2DcCoPNcFiOoo7eHlLPF0qm5OLRdvBK1jDGID2ZYM2RMzXCIBNUnLRk1l/Sbe/KjoYjxGtt1WwXXyEKYyys6LnB14mOycl7rOfN2UZLopRYXreFut8a7PkIusRkJ9CFkgHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oc4Iwwqd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754307690; x=1785843690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AepgNZ7P7SXFgoBmnhHVx19wynhuOK+XU2wQzts/zqk=;
  b=Oc4IwwqdsxJy4Edpb6nSUUlUvDvmFbFnTnNNEK9/ZnCIvSSRnHhR64JU
   eguZ18ACoQP5vc8BxZ3qPKm3vfkstUr6gu/2CqreASzW9hAawB4tZCpXb
   4h5MVSyOnZpGRlhcOGscPb9assHI2PJhb28d3m9IEgPlJrKmKzKB7aduV
   K30KqfHx5V6sFItTnDEF159Uy6ntsLJeMIo/2N/EmjENAHA626ihp7PJz
   S8Oa9BYOmoZln8aK6M9yvGtCMgkkRDir0Gn7yPs1XLEO7sIQgJ7xE+sA4
   FmmerIgSJULAx4k+JGns9wJXABlkciBy5qwctpKgRbUf0APRDNJ4xXUaM
   A==;
X-CSE-ConnectionGUID: i/sjoiVoRwCAZOjog6ziDw==
X-CSE-MsgGUID: 3XoeyXYeSJaTdXJz14Rm+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="67628802"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67628802"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 04:41:26 -0700
X-CSE-ConnectionGUID: pCoEjXk5S0i+02HPUXmXaw==
X-CSE-MsgGUID: 86EoBCHnQHCj4vvSvekV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163686992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 04:41:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 04:41:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 04:41:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 04:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSiTlULfprLtPfLXYcmr1+kyNQYP3M8cCvKG5NIMDPd8ubV5/KKVJl3RsavvYt5xSj16V/OxfQP2iZEfVT/GoThu7VfQZtkx7a1XWuuwQwis7hYouYP8UNtkLemLoq7EPqaTFvqS6yuI9OQyBuBSjGn/rdM0kQg02uc+DgqbxmGnCswrvibV4PEd1uw0/KKALDCuaiZbutJxrso/zRMmVSJwOCWsEti4Lr8Az2clNLP805Y0fukPy/JfWQ0FszwlmiHIcDbuwxmnVpHq85YuPmncdYUk2gr+NrKqV6u+2bSrwuEHkPT137jgntmayWCits5NZSJfJsN12sgy/s4cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AepgNZ7P7SXFgoBmnhHVx19wynhuOK+XU2wQzts/zqk=;
 b=u0+z+ZficZz8Ue9Xw7i1WAmyAMirCqns+yENe/BBlTesG33xNeK+b/2WEiJbGjjJf0+d0RFjiqmCY2AbSh7T/rEJnp+C0TD6OE7Xpv0O9AXB0Eny7K9plXGyxogPIlz+wjwi9SRMpMaOuOnCb4euYpGV9Qds5yr0LOji+KxE7N9O4pj7PTZqdmvpbVX32AOowA95T2XSoja9chpMxoVL9SUy/A/KMmNLGuWHnKkNj8jSJeJE5ntjgmkff5XQ6zalp9Vii48oGUlqKra9qj+1BhrxdDps9DcBSspsebRi0/ospgP96O2A5F4LFyPWSRbUxjN4fxBm8zeT5dccZmtBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS4PPFE901A304F.namprd11.prod.outlook.com (2603:10b6:f:fc02::5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:41:07 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 11:41:07 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"David.Kaplan@amd.com" <David.Kaplan@amd.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/2] devlink: allow driver to
 freely name interfaces
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/2] devlink: allow driver
 to freely name interfaces
Thread-Index: AQHb7x+cVAoh4qOyMUiMYybkTz8E6bROmbQAgAPxEnA=
Date: Mon, 4 Aug 2025 11:41:06 +0000
Message-ID: <PH0PR11MB59025A3E1985F38E2F4EBAB7F023A@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
 <3f6fbb95-2ee1-4571-913b-6dc6c3197032@intel.com>
In-Reply-To: <3f6fbb95-2ee1-4571-913b-6dc6c3197032@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS4PPFE901A304F:EE_
x-ms-office365-filtering-correlation-id: 84dd583a-4771-4a70-5475-08ddd34bccde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?US9kMzgycldGU1RUZHVCM2h5eUlFN3R1N1EvaHJYSmFJdkM3UmMvZzRoa0gy?=
 =?utf-8?B?aWZYQzJXd0ZWTmNDOG9lNU80N0RVdHlxd21ldDlGaDVFTWhNYjFhd1JGWFhj?=
 =?utf-8?B?Zm5NbkNQNjlwU0I5clZ1dWt0MEFJNkFQeHVWcHl4MlZaRTFQVGd2NnR4VVlv?=
 =?utf-8?B?ZmJJVHRJUkNvZ0UwOW5xTldIZUdOMytObXFsVFlITnl2QUtLQU9vaWRrbnA2?=
 =?utf-8?B?dk9oUnVGMHh4eVRvSFFQa0FqeDVkZk1uTlNRWHRoT1Eyc0FpZ3B6S0RlNFM3?=
 =?utf-8?B?OHMxekx2VlNnTDNLZGRES201QnNqcHNpT3hYMEliYXBtSnJVOXBXR2UxZWJX?=
 =?utf-8?B?c2lvbFZBL1BnbjdBY3V3VW9MZ2dwQzNFMm5nVVVsa0hmVEs5RUFWUDBHSDlp?=
 =?utf-8?B?TWlnU1BOMkpObEtmUnJpOXM3QldycWNadk9sMU5kVzkrd1NQTkU5bi8rKzd3?=
 =?utf-8?B?ZTBsYXVXUm94aHVjdVBPQlg4dXplWVBRUGtuUlRmOGlGaEsrOFpudml1UThW?=
 =?utf-8?B?Nm1QNGRTUFR0Sk51cXRJL0VQNTh5NHA1bzkvMUs2Y1Jia2pPY1JMdWUvSnMr?=
 =?utf-8?B?cEhENytmUWNMUlFrTE9Cdy9hYlZEZWpZdkM3T2kxTVVxaHkwS01SK0dBZ3hK?=
 =?utf-8?B?WDZGMGZUaHB5NTZhcVpRUUR1RkQzUzFRenJsTjEveGExZ3dVbjNwbEhubkZZ?=
 =?utf-8?B?MmZwdU5BNDMwdDVxQ3FCUGhyTEs2cE8zWVptN2s1czlDWCt1bW1ZT3NtdVhO?=
 =?utf-8?B?bENaWURONWJqb00xaGVuNTlQZ1VQMk1Cc2hzTDEyN0M1Zkt4aGh4KzdLSVAx?=
 =?utf-8?B?SU4zbU1tL3VYTG9nSDVLSmVKdytvVHBsbEpQbG9KY3dhTzhyWkZUZE1Qc1VL?=
 =?utf-8?B?d05FMisvanp5NDEvWEIyeVdZMjRTMGpWWEFYME0vWEpoNkxBZG91bVpzUzNV?=
 =?utf-8?B?SG03dDN5L3BIVkt4YkNjd0REZ01scU1UNjJhQy9nc294NE9oaVo0cTNsa2NB?=
 =?utf-8?B?NWNJN2NlVnI0UFFJeGU5RXQ1OEo2Q2JNei9pRjRlZnpoK1YxdmhGWGRKU0pp?=
 =?utf-8?B?SlFnZ0VFYlVWZ0pLL0c4Y2ZCSjVxZkFUR1VvdG9jVm90b2FRd3ZnRVQzcE9N?=
 =?utf-8?B?UlpCV0pYSWYvb1k2Mm9IcEtyRFB1bU5adkpQSlpyWm5oUVhoVzZNTGw3ZFNG?=
 =?utf-8?B?Q21UZnlWTHNjUmp1TS9yMmlBUE95ci9RdlFZT0dkeTg1ZTNNR2hMTkM5NldN?=
 =?utf-8?B?dnBoVXdTbXphakZtRU1qbUtPaHZGdFZvUjFQdER2VE1RVFhienBEUlZHQWd5?=
 =?utf-8?B?a1pTZEJWQ3h3L2RUVnZtUzVLMHRRQStNNDkzVXNVR2RtdWRYeXNCa3ozVmo4?=
 =?utf-8?B?eDBpbU5TS0VSYTV1YjZ2c2pXQ01jckoxM0hsZ3lSWi9oQlRrNzk4Ry9jZ1Fo?=
 =?utf-8?B?K3gvcElRWTNkVXNiT1BaSVltOElhTVZZUGJHT3Vjd3Y2VjBab0JySEtnRWhF?=
 =?utf-8?B?VDc3OEdqNkF2T1ZFVFB4SmJSeTlRaVZhOTAxeUxqK2NPYlAvaWpuV010RGcv?=
 =?utf-8?B?dE9uNUNvbEVmVmFzaElTODFzNTU1S1IvbjdtVGsrU0lkeHExb3llYUJiT1di?=
 =?utf-8?B?SXdoMVJ4RTQwMEI3cFNsMFJZeWFCQVpxdVpZQkNnbWdPUi9ibzBwd01YK1dl?=
 =?utf-8?B?SExTTUQ2Nlp2Nk1Lak5CbW5zQStLMitCZVNMeEwwRXhROTQzeWdWYUI5ZXhi?=
 =?utf-8?B?WHpScEpBLzdBOG1oWHdLZlAzbXlQT3drd3RCTjVGV2VzY2swYkNFSEtaVW82?=
 =?utf-8?B?THVOdEl5akRpVElEZUl0dGdBN2lReDZ1NS9qYnVUNzFvay9Dc3RxRnluSTVT?=
 =?utf-8?B?UEZNSmJSVWJrMHNHdUYyT1Z1UE1SeGp0cUxESEFNYkFxQm9uNmVWcEVWMEtH?=
 =?utf-8?B?TTJRcjlCTEcxQWhka1JGNlNzZXNjdG1tS3cwYlgyMEoyYVZVNlhuanROUVFj?=
 =?utf-8?Q?iUpgaIeuv9QYS2cCKWHVqfMTJvasRc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlBBK0FLeXlxeTJEQlE5bjF3dTUvdWZ2TmxBMmJKOHAzZWt0VlNBM0J5NlIr?=
 =?utf-8?B?b2lmdWRoYk1jVGdjVU5SY0VpZS90NkVXeXJCZEtLL1dCcW9JMVBXaUUrb2Jx?=
 =?utf-8?B?L2w3OU8rVDZJUXZPU3I2RHNmMnlxQk4rZ2JiOTZGdXdoQStDUmswaEFIOG1J?=
 =?utf-8?B?VUdNSzVONG5POFJqbmR4MkxyMFh0bk1TbXgzZnhpRUdHaW5wL0c1a2xnWEh3?=
 =?utf-8?B?Z2lEbE5YTGY5YlB1RnRlYUFtYWdqc01TcUtvSzBlYTM0N3UrbUFjczZEUFhI?=
 =?utf-8?B?RjNDRlhpRUh4bDcwMnVrZVVLaklMbHNINHdFUksvUk1CK3B4Q2VOR2FFVS92?=
 =?utf-8?B?WFJaL3hXcXZJQjlicWRkVXY0N2JlZ3ZkY0tqWjNVMnBERkNtOFhLZVp4U052?=
 =?utf-8?B?UkMrVVRnbytCOHdkVXVqZ2ZYdXBOT2Q5VTk0eXpNYlExSWZSR2p3SkxKaGQw?=
 =?utf-8?B?ZGRrMUtoeEdhaDBPRzZlYTlKdEYzdi9PRFFYb1lEMWl3aVB6blFVS3o0T2Vo?=
 =?utf-8?B?bis0cHliWHNyQVhYeHhHSHNidmFPQlRuQmtzZ01YNEpBelhnMkltbDUyQkhB?=
 =?utf-8?B?Lzh1NmlsS05mZytFZWhuVmZuN0lzazBicHRQdGphcmtMVnd1MHFsVkFkU1pK?=
 =?utf-8?B?UUxxWXVOWSt2OXB6RlJSek5JaWhMR2tIeXY1Y2wvMU9BejZjVWtmdmdFRE80?=
 =?utf-8?B?bFdrem5XUVFzbWZMUUdFbGRmUVF4Zkp5MWg0ZUw5aldqRGc3SVl5YkZoU2VN?=
 =?utf-8?B?OWxtTVc4MGIrUWdJeHFEK3FPZWNRd3BCSzh0Mk0ra21vNHArQXJ6Y0t5c2tN?=
 =?utf-8?B?d0g0c3daRnNmSFFQTExQT0RJVEpRMzliSVk5TytPNENhMXJTMWdpQkQwb2Vl?=
 =?utf-8?B?bnZONlVLTWRhS09wZDVZZ2FDcm92WUp6ZlEwdnJFc0pqSnhndnlUYzNqWWpF?=
 =?utf-8?B?elE0L2RnY1AyaVkxMWZHbmppOGVDV09ZcnBaVGdJWTl2WHB1OUJuSGFFUVRZ?=
 =?utf-8?B?NVJieGpZVmZnd0JJaklwNWcvWUErejBIc1UweDE1YWhYWGFrcDUyK1FUb3Yx?=
 =?utf-8?B?a0U3N25VS29kaTUva2gxcldxdDhPNHMvZklQcUF1cXJnVDZHV2llY0l3RU55?=
 =?utf-8?B?NWRPeS9Fd3ZWQnVRYkpZOG1zMjRWREpGa09QTmw4VHorL3ZaYk1PZFlITnFF?=
 =?utf-8?B?aGE1QnZJU0I4a21SZHg5SWZ0U003TThMNmZ4VnhmdEtPUDUxUzRMTi9Lbjhr?=
 =?utf-8?B?emNka2NTMnppbWNjYmRxL1lsYW5yUEk1VEx2eG42SCtwT3oxSHROMW5FZ3l2?=
 =?utf-8?B?d0JCZURUclVKTENOMVhjQW5Gd0FZcTdBbVBLaHo5T25EWlBCcTdSWTVNenZv?=
 =?utf-8?B?Q0p5UzAwaklrdEIycU9ZMWh0UmdPTCs3QjNWMWpqblZYSWhuMFZHeXQzSHhN?=
 =?utf-8?B?R0o1YXF4L0lJT25IY2JKVGQ2aUh2MmJHY0lzR2hlTHVtTkVZNXlsdVVuVjhN?=
 =?utf-8?B?ZmlMV3dMZEdlQzFQOVhyU0haYTIrK1REZS8weU04SE5Ickx6VWl1SHJ1d3Ra?=
 =?utf-8?B?dGN3U2N1RVUzRFl2T2VxTjJnNnFURElQcU95RUdaZzBHaU5sOWxkYXE2U1BN?=
 =?utf-8?B?bVB1ZGE1OWh4YnNYRGc5RFdQalJIY1VPbzFOcXpKakp5UjMwREZlc05BRmtK?=
 =?utf-8?B?dWw0UENTUy9xQXlEenVQandrNmNqQnk0ajlvcWdNQnFtV3Z0MWprZHZ2M2RQ?=
 =?utf-8?B?ZUtDZUg0dTQ1VlpRL3ZocldxejZram0xU2d1c3lKbjF3Nlo2VDVFT2hVY21M?=
 =?utf-8?B?cERaNFpUSUlUdWVjS0g3dkYrWUt4WndqOEdja2s2eXplZVRnUzZUN21xSWk0?=
 =?utf-8?B?TmhNYVZySmVKaElpbjBOOXpnMzl0Q09XREIwQVBFMDNpQzBhOEFuWXVGaGNW?=
 =?utf-8?B?RGFLQm1VTEMzUjZ6TnRoRkRjRVdGY0hHSXlVWlgvSDF3bVA4ZWhBaSt5Q2x3?=
 =?utf-8?B?ZERjcFl6TmxQTFdkYmVJQ3N3TXplOU5KQ1JyQkR2aHErN0ZYL2pCbkdRcjJ0?=
 =?utf-8?B?OG9aMy94azRPRUMzbytXZzV6ODB1RVo4Q3drUXdETjlET2ZpZThReEVSaG15?=
 =?utf-8?Q?f1IF1mj2QPAdnMEklvWuE+rH2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dd583a-4771-4a70-5475-08ddd34bccde
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 11:41:06.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8oAJUDSpY72Jd78qzD+eLgn2ir9aoJBY+7HvkR9YLthtcDe3Jo7z51zAx+EPIJd1EuCfdzODKQSHYlawsLWV+mpl81Up47ztDOZPsDDgUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE901A304F
X-OriginatorOrg: intel.com

RnJvbTogS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IA0KU2VudDog
U2F0dXJkYXksIEF1Z3VzdCAyLCAyMDI1IDE6MjggQU0NCg0KPk9uIDcvNy8yMDI1IDE6NTggQU0s
IEplZHJ6ZWogSmFnaWVsc2tpIHdyb3RlOg0KPj4gQ3VycmVudGx5IHdoZW4gYWRkaW5nIGRldmxp
bmsgcG9ydCBpdCBpcyBwcm9oaWJpdGVkIHRvIGxldA0KPj4gYSBkcml2ZXIgbmFtZSBhbiBpbnRl
cmZhY2Ugb24gaXRzIG93bi4gSW4gc29tZSBzY2VuYXJpb3MNCj4+IGl0IHdvdWxkIG5vdCBiZSBw
cmVmZXJhYmxlIHRvIHByb3ZpZGUgc3VjaCBsaW1pdGF0aW9uLA0KPj4gZWcgc29tZSBjb21wYXRp
YmlsaXR5IHB1cnBvc2VzLg0KPj4gDQo+PiBBZGQgZmxhZyBza2lwX3BoeXNfcG9ydF9uYW1lX2dl
dCB0byBkZXZsaW5rX3BvcnRfYXR0cnMgc3RydWN0DQo+PiB3aGljaCBpbmRpY2F0ZXMgaWYgZGV2
bGluayBzaG91bGQgbm90IGFsdGVyIG5hbWUgb2YgaW50ZXJmYWNlLg0KPj4gDQo+DQo+SSBmZWVs
IGxpa2UgdGhpcyBzb21ld2hhdCBsYWNrcyBjb250ZXh0IGluIHRoZSBjb21taXQgbWVzc2FnZS4g
VGhlDQo+cmVuYW1pbmcgaXMgcmVhbGx5IHRoZSByZXN1bHQgb2YgYSBwb2xpY3kgcHJvdmlkZWQg
YnkgbW9zdCBkaXN0cmlidXRpb25zDQo+d2hpY2ggdXNlcyB0aGUgcGh5c2ljYWwgcG9ydCBuYW1l
IHRvIGRldGVybWluZSBpdHMgaW50ZXJmYWNlIG5hbWUsIHJpZ2h0Pw0KPg0KPlRoZSBmYWN0IHRo
YXQgd2l0aG91dCB0aGUgZGV2bGluayBzdXBwb3J0LCB0aGlzIHdvdWxkIGJlIHNraXBwZWQsIGFu
ZA0KPmFkZGluZyBkZXZsaW5rIHN1cHBvcnQgbWFkZSBpdCBjaGFuZ2UgaXMgbm90ICpleGFjdGx5
KiB0aGUga2VybmVsJ3MNCj5mYXVsdCwgYnV0Li4gSSB0aGluayBpdCBkb2VzIG1ha2Ugc2Vuc2Ug
dG8gaGF2ZSB0aGUgb3B0aW9uIGZvciBvbGRlcg0KPmRyaXZlcnMgc28gdGhleSBjYW4gYWRkIGRl
dmxpbmsgc3VwcG9ydCB3aXRob3V0IHRyaWdnZXJpbmcgdGhpcw0KPmJlaGF2aW9yYWwgY2hhbmdl
Lg0KPg0KPldoaWxlIEkgbWlnaHQgcHJlZmVyIG1vcmUgZGV0YWlsIGluIHRoZSBjb21taXQgbWVz
c2FnZSwgd2l0aCBvciB3aXRob3V0DQo+dGhhdDoNCj5SZXZpZXdlZC1ieTogSmFjb2IgS2VsbGVy
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNClRoYW5rcyBmb3Igc3VnZ2VzdGlvbiBKYWtl
ISBJIHdpbGwgdHJ5IHRvIGJlIG1vcmUgcHJlY2lzZSA7KQ0KDQo+DQo+DQo+PiBTdWdnZXN0ZWQt
Ynk6IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKZWRy
emVqIEphZ2llbHNraSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiB2
MjogYWRkIHNraXBfcGh5c19wb3J0X25hbWVfZ2V0IGZsYWcgdG8gc2tpcCBjaGFuZ2luZyBpZiBu
YW1lDQo+PiAtLS0NCj4+ICBpbmNsdWRlL25ldC9kZXZsaW5rLmggfCA3ICsrKysrKy0NCj4+ICBu
ZXQvZGV2bGluay9wb3J0LmMgICAgfCAzICsrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25l
dC9kZXZsaW5rLmggYi9pbmNsdWRlL25ldC9kZXZsaW5rLmgNCj4+IGluZGV4IDAwOTFmMjNhNDBm
Ny4uNDE0YWUyNWRlODk3IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9uZXQvZGV2bGluay5oDQo+
PiArKysgYi9pbmNsdWRlL25ldC9kZXZsaW5rLmgNCj4+IEBAIC03OCw2ICs3OCw3IEBAIHN0cnVj
dCBkZXZsaW5rX3BvcnRfcGNpX3NmX2F0dHJzIHsNCj4+ICAgKiBAZmxhdm91cjogZmxhdm91ciBv
ZiB0aGUgcG9ydA0KPj4gICAqIEBzcGxpdDogaW5kaWNhdGVzIGlmIHRoaXMgaXMgc3BsaXQgcG9y
dA0KPj4gICAqIEBzcGxpdHRhYmxlOiBpbmRpY2F0ZXMgaWYgdGhlIHBvcnQgY2FuIGJlIHNwbGl0
Lg0KPj4gKyAqIEBza2lwX3BoeXNfcG9ydF9uYW1lX2dldDogaWYgc2V0IGRldmxpbmsgZG9lc24n
dCBhbHRlciBpbnRlcmZhY2UgbmFtZQ0KPj4gICAqIEBsYW5lczogbWF4aW11bSBudW1iZXIgb2Yg
bGFuZXMgdGhlIHBvcnQgc3VwcG9ydHMuIDAgdmFsdWUgaXMgbm90IHBhc3NlZCB0byBuZXRsaW5r
Lg0KPj4gICAqIEBzd2l0Y2hfaWQ6IGlmIHRoZSBwb3J0IGlzIHBhcnQgb2Ygc3dpdGNoLCB0aGlz
IGlzIGJ1ZmZlciB3aXRoIElELCBvdGhlcndpc2UgdGhpcyBpcyBOVUxMDQo+PiAgICogQHBoeXM6
IHBoeXNpY2FsIHBvcnQgYXR0cmlidXRlcw0KPj4gQEAgLTg3LDcgKzg4LDExIEBAIHN0cnVjdCBk
ZXZsaW5rX3BvcnRfcGNpX3NmX2F0dHJzIHsNCj4+ICAgKi8NCj4+ICBzdHJ1Y3QgZGV2bGlua19w
b3J0X2F0dHJzIHsNCj4+ICAJdTggc3BsaXQ6MSwNCj4+IC0JICAgc3BsaXR0YWJsZToxOw0KPj4g
KwkgICBzcGxpdHRhYmxlOjEsDQo+PiArCSAgIHNraXBfcGh5c19wb3J0X25hbWVfZ2V0OjE7IC8q
IFRoaXMgaXMgZm9yIGNvbXBhdGliaWxpdHkgb25seSwNCj4+ICsJCQkJICAgICAgICogbmV3bHkg
YWRkZWQgZHJpdmVyL3BvcnQgaW5zdGFuY2UNCj4+ICsJCQkJICAgICAgICogc2hvdWxkIG5ldmVy
IHNldCB0aGlzLg0KPj4gKwkJCQkgICAgICAgKi8NCj4+ICAJdTMyIGxhbmVzOw0KPj4gIAllbnVt
IGRldmxpbmtfcG9ydF9mbGF2b3VyIGZsYXZvdXI7DQo+PiAgCXN0cnVjdCBuZXRkZXZfcGh5c19p
dGVtX2lkIHN3aXRjaF9pZDsNCj4+IGRpZmYgLS1naXQgYS9uZXQvZGV2bGluay9wb3J0LmMgYi9u
ZXQvZGV2bGluay9wb3J0LmMNCj4+IGluZGV4IDkzOTA4MWEwZTYxNS4uYmY1MmM4YTU3OTkyIDEw
MDY0NA0KPj4gLS0tIGEvbmV0L2RldmxpbmsvcG9ydC5jDQo+PiArKysgYi9uZXQvZGV2bGluay9w
b3J0LmMNCj4+IEBAIC0xNTIyLDYgKzE1MjIsOSBAQCBzdGF0aWMgaW50IF9fZGV2bGlua19wb3J0
X3BoeXNfcG9ydF9uYW1lX2dldChzdHJ1Y3QgZGV2bGlua19wb3J0ICpkZXZsaW5rX3BvcnQsDQo+
PiAgCWlmICghZGV2bGlua19wb3J0LT5hdHRyc19zZXQpDQo+PiAgCQlyZXR1cm4gLUVPUE5PVFNV
UFA7DQo+PiAgDQo+PiArCWlmIChkZXZsaW5rX3BvcnQtPmF0dHJzLnNraXBfcGh5c19wb3J0X25h
bWVfZ2V0KQ0KPj4gKwkJcmV0dXJuIDA7DQo+PiArDQo+PiAgCXN3aXRjaCAoYXR0cnMtPmZsYXZv
dXIpIHsNCj4+ICAJY2FzZSBERVZMSU5LX1BPUlRfRkxBVk9VUl9QSFlTSUNBTDoNCj4+ICAJCWlm
IChkZXZsaW5rX3BvcnQtPmxpbmVjYXJkKQ0KDQo=

