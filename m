Return-Path: <netdev+bounces-202555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51CAEE403
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967947A793A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A1295DAA;
	Mon, 30 Jun 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfXcYu5X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E27290092
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299941; cv=fail; b=Aynch0IY5h/+coxQ/YSzNJmb7AlvtJTefjKz8lK7zLrf1LtxNhDJ+boLf2JwYsnfwsXD/AEGOqzIuwWCULv7APoL1pmDS7VtZHx2tMdDclCmehYceP7Q9NX7gHelaEDv+V6giMYmaQkvfJaIdW/xzsxBLU55nqf3DTi+5h0XNaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299941; c=relaxed/simple;
	bh=Xlghl5P40aoLig8FBu+8/7eTPVeayTk8385UI03u2Nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YabzU4yM54PZuKk9lPtWaznhsaGldWjgyV9mr95rMYuEczAKIOMOYy9VzhzLCeyy5Cs7ca9H0oEhDHPqwq3jN3HYxFzxt4cyoloNaDNa6uZdX5FrtxzsolMO4yTYaWlF2Sx514VYk+P/bZ5xvwyZI8L+oDTjQdF25lo4Zmx8q+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfXcYu5X; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751299940; x=1782835940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xlghl5P40aoLig8FBu+8/7eTPVeayTk8385UI03u2Nw=;
  b=lfXcYu5XiAlSwXasam+tykGScCu3Ha8OsDjYRwJoucV0rDYTYlHgkCW1
   GJTap+LBkt2DcHK+gIdgXakzrVzU700q2hpUOQE16RXv7kl8CpAvE0h66
   MpmRAHlFfz1dmQX9Fiow5dxhYnqy9z9HwdChWlkZG4FWzjj9YvdSCB8oW
   NJMvGTEeXqe2dvowfjDKA9mD+vx685ZM0yT5Oss1cXBEWdkj4PJrEy0kJ
   easujtim85V9PW5esSGgMTEkyeNeC7+dbFlBBLNK0/BroDCXEWIUQmkmx
   O1TstltunJFo+jCXkHhuBRym75haoa+WgZs+IabwZLS5ZVXj+uDadBSOu
   A==;
X-CSE-ConnectionGUID: a9SfkLYyQKSv5bhW5sJ/YQ==
X-CSE-MsgGUID: jRaQ1iKpSLCjN5cZIoDU4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="52763151"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="52763151"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 09:12:16 -0700
X-CSE-ConnectionGUID: dpttbSwVSkmfK3RYd2aNfQ==
X-CSE-MsgGUID: nW7go4AOR0eJaKOtYpNdWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153139209"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 09:12:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 09:12:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 09:12:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 09:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpjFsctvbxKPMp9CykLHCeF1BkE8/99IQtCjbeRa/G0G9yuOLzDTAxA+7voysRmapRCuBZ/giF87c2bUr2W4bc2mnKAzvdhuIIPRmmbA4WjpZPKFnNDeslZzHx6AyNPOP7E9MuCb1/mf6Y5GW6dNRsMIT3bAvgQ40y3tEtIFvAfpyAxQSX0xYeSCBxFcQS5FrCXAUZjgmT4aVSFcnW1BGpBXhQs8dvoYlILR8WYsqCxM5pJDeSG1YveW5FGybUS06z4rjOjlVbz/6GJg44ohxJob0YHPp2hD02J9fjmiFeIB8f7YxLljB07/y6m3qqqZE1/nS1LQFuG129mXENtE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xlghl5P40aoLig8FBu+8/7eTPVeayTk8385UI03u2Nw=;
 b=sxVqCd/gUiUecMUqRPrcLwVeHb1D7FA8KlZB+NjSteOHUHfth7Wrxg+p1vpcFIZLhhifuzwW8OJvyg12DHSG8Tmr5TQ80mHj/N9bepXz+0pwknxuvpym2+emlP3duxMXvlzt0p9JrMcOsOaeVOgQHmo1msEA/ME1yIzIzoW8GVvEuRelC5ZWNpqEpL5lv+RUmtDsnhBRYLbCVBL565ca771FH93c1FJ0iLc7fPrqCEbDBqjh1Ll2UiEAjoJDDU30rFxkdl9ATkvLIwItIQam30k1NytKqMQ2IFZRCmD5VdJ7No8hIx4GSipradzbezDg7ozj6MNhax7cUTFHT/19zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV8PR11MB8581.namprd11.prod.outlook.com (2603:10b6:408:1e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 16:12:10 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:12:09 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Luigi Rizzo
	<lrizzo@google.com>, Brian Vazquez <brianvv@google.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net 3/5] idpf: replace flow scheduling
 buffer ring with buffer pool
Thread-Topic: [Intel-wired-lan] [PATCH net 3/5] idpf: replace flow scheduling
 buffer ring with buffer pool
Thread-Index: AQHb5eri8BpsPutmtU2jA42VkLZEzrQW/daAgACci7A=
Date: Mon, 30 Jun 2025 16:11:51 +0000
Deferred-Delivery: Mon, 30 Jun 2025 16:11:21 +0000
Message-ID: <DM4PR11MB6502B06BBC80AE1EC3416A4BD446A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <20250625161156.338777-4-joshua.a.hay@intel.com>
 <cb1ef2d3-4750-40d0-85f9-df6a8ed3ec22@intel.com>
In-Reply-To: <cb1ef2d3-4750-40d0-85f9-df6a8ed3ec22@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|LV8PR11MB8581:EE_
x-ms-office365-filtering-correlation-id: e656b630-c039-4881-06bd-08ddb7f0dd99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1ZsMDhOd0ZaejRocHozM2JBUU5ZZEZLdGQrSDNyNU1NanB6dkRuc00rTXRn?=
 =?utf-8?B?ZjRQbWhVTzlFbDZvV0YzeGRrR01wS2t1WnAxb0FMUENwMFNISURkU2IyN01i?=
 =?utf-8?B?Zy9CRUJNVTVHdUJ1V1V5Q3NQVkd4SXF3Y1BMY1pSc25yTUNrZ2FQUjEyVlda?=
 =?utf-8?B?a1pDaW1DTnBiNXJTMWhISCt6RzFqZUl0UDhrWjBWMmhIUXRJWnFxb3AvNUVZ?=
 =?utf-8?B?dXlsN3hmeU5NclZuVGsxV1NnSHdvWHU4RDRqbVZsTlVwYWJwcVI2dlgyRFIy?=
 =?utf-8?B?eXVrYVhEcTU3bkNoQ3FlSW9ZQ3ZTN214RC9ZdjhZSCtySUxDZDNSKy85VnZQ?=
 =?utf-8?B?dGVTeUpQQ0JXVjhmYTJmYU80K1pLZjZwYmJHUTdvb21rWnlQSVVad0dUNTcy?=
 =?utf-8?B?aHFvVmhaYkxlWGpMT0Y2NExGQ3VISFVFdC9nRFk2Q3lOMjBPek9oTnU3eml3?=
 =?utf-8?B?bWpmYXZtczNoUCs2ejM4SDdXUkk3WUV2NXVzU1lrYVBsSXp3SHNVWVZCRU1D?=
 =?utf-8?B?ZTNiaVNOWmgxZEVDaWJvdXo1Um1FUXdUM1JueUdROXZrRkhONDdGZzVlSVA5?=
 =?utf-8?B?QkpkM1U2aE1NbE5KY1J0c24xeVlDS3dJRlFiL2QwSFhjLzIxU21nQlV2OU1S?=
 =?utf-8?B?eXVFR2NXa0hVL2dHZHhaUURBV2IzQ1NYd0JDd2lMMC9wUW16Qm9sMzczMjNw?=
 =?utf-8?B?TkNVZE1NUHUxZE5LZ0FCOGsyaE5jNXM1c2VSdjMxMW82V0lobWxyNUd6dTVp?=
 =?utf-8?B?YUdkaExBaVNQNXU5UFBVZGUzL3FwNElYcS9lUzRUUW0xY2FNQURYcGFlV1o3?=
 =?utf-8?B?SDR5Ly9tVmhucExWdUU3ZVllcDRsZmZVU1IzRjZsOVAzOHpTZE41STU1Ym9K?=
 =?utf-8?B?VWtwNHl0U1R2Wkd0Yll5aHhNSkx5MGNIYjVBK1FwTWJIZ0ZjU1A3alpwZkFQ?=
 =?utf-8?B?TmppOWNkQkgreDBxM2doYU4vUldIVDkrY29nOUVjZHhNRTlGRlFISXpwa3B6?=
 =?utf-8?B?ekFNSkZqaDZvMW5CanFQaWFDMTRNN2h5SU1jRHVHdVlVaDNzOFNCaE5uUXRz?=
 =?utf-8?B?TGQva1V5VmVBY0VNOHJRTEVDTjhBM2VMK0VVMXBFdkk3RDg1SWhxSm50L0JE?=
 =?utf-8?B?dW8rbjE3RjN1MGlwTW55ZEtNa09xTGU5dWtBN0dNQkpKRVduMm9mUzVXODRj?=
 =?utf-8?B?VWNIMGMvbEVHcmZ3SWF2RTFaTXBSby9yS3JNS0tvMDNtZDNMQjJhbG5ub2xx?=
 =?utf-8?B?OGNqNEl5K1pkS1JqZGpjQ1g1dGtUK3kwNm1UOERza2M3THBrMTlWWVRIdUxm?=
 =?utf-8?B?dmhYVWVMZFh4NmVyZytzSkI5U1FkKy9MbHJrRTdMWkQvUDlaVmtMWG1HK2xG?=
 =?utf-8?B?Z0pUYXpSN2wzbFQ1KzVmQWhCSmRYbytITXBPRmJoalFCR2RIU1dLNUdTY25n?=
 =?utf-8?B?NDZJQWZZZHZ6bm5iUXFpK0FHTzVkUEZjYkN0ZUNZQVdTUmpTckE1S2pNc2lJ?=
 =?utf-8?B?c0RKSm1ScUQ4Y0Q2bWUrVEJNY1RRZWNzV1l2M0ZhZURRUHZEbUw5cDNzcmJ3?=
 =?utf-8?B?cFF5QU93NERJaW0vTldQN0kxYUR5SE10TmJjdnI2UWt5Ym5IRkoxb2NFU0hy?=
 =?utf-8?B?VHFURGQ3QUF6TU9CY1cxRzArRXZkOXQrZkdCc1l2cFFsVklMbWVlL0JtSmlN?=
 =?utf-8?B?ZGR5RHNXQzBZZnNkelFtUmYyMUJlS2xoTzE3Yis3c0dmR1FnUGgxOGFDb2xH?=
 =?utf-8?B?Q3R3SFRpQ0hJNWR0eGdkMHlTQlNRdS92VHJKQWdxY0psLzdNb2s2QUF4QkJ1?=
 =?utf-8?B?VmppRTVqQTd2cGtGSnplWWZ2K0tyNjRKNjFuSDhGR1IvVFp4Um5JS1N6RHRE?=
 =?utf-8?B?YllraEVjMVdQNDQ0dEJJZVQ0SUZsdG9vTjBDS3VXY3ZxNEVBWTMxQ2tuc0pz?=
 =?utf-8?B?dUUxWW1HQVhKV2pCd3ZaTmNMZW04KzRpZXVCNlVmbzBZNVZIcEN0ZTM4dExa?=
 =?utf-8?Q?mH0zd45FlkA+GUq30nxIG7x27X9kcI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGEwcVJXaHQxbEJuWWhrS1ArbUhLcGQ1REw0ZGlyU1Y4NUduakVJS0lYaDNl?=
 =?utf-8?B?UDZrRnlkYWhpa1lxMW02T1NGck42UENaQkdrNzhINmwrR2lyN2hhd3ErbkZm?=
 =?utf-8?B?Y0FaNHExR2JVdnVtU1poM091WDRkRUFUUVhrajBHVVFUbTQ4azNlWnRIdGFN?=
 =?utf-8?B?cXExVVN4SSswV2I2OWFXV2RGVVJ1MlJrK240RU94V01BRk9IbmU5MEdrODZH?=
 =?utf-8?B?blJiNndWYzRUTy9LamNJR2o1NU5tZUNOaDB1MHdkZjhFT1ErT01PK2RKcTh5?=
 =?utf-8?B?UW1rL2hQVkJ4em1LT1ZodzB4UTQxQkEwTTUzRVA5d0UzNEY3TTZWd1N0UWR6?=
 =?utf-8?B?UXB2UE93TTZ3WXRZOVhBVThzN3k0NWZoUW03bmo3bzFqRlJTaHI1QmFsakND?=
 =?utf-8?B?VlFaWmJDeWwwKzJRUi9UTTZPUUxWbUFxd1hkZ3dLdVpMbVFuZXZNemhHaVQw?=
 =?utf-8?B?LzhPZTZNSUx3eGZBZFRpdGR1YUJURkM2OFMyUEJaMms0S09GbHJiNThNOFF0?=
 =?utf-8?B?WFlzY2FubDExdmpzMGtuS0ZGYjhFRW5iMXF0NlpCbDNCczhsNVZReE5meFV4?=
 =?utf-8?B?Z2JROFBQRk9kYlc5S09hYVZhZ2l1dUlNdnFyWFIvVC9LR3ozbUFnNkJ1SEtt?=
 =?utf-8?B?VFpHc1FEVUpMQXhmczRPeVpJUEdNeFRHYUgwejNFamU4SGo4Tk00S3ZLMmIv?=
 =?utf-8?B?ZmZiNTZuVkdOeDgrU005QVY0Ry9uNS9TV05TaHZqR0s4RGY3SjhTQzlhK2Qv?=
 =?utf-8?B?WVZtYjN1RkNNUFJMQ2lUQk01VktyMTRzWkFPamh3S1NkM3k3TGp4R2thU2dp?=
 =?utf-8?B?SFVidU1KU05jOWZWWjlyK3FzQm5QaUZxYStqN3VBSXhYWlhzT1BmSVhEaDlQ?=
 =?utf-8?B?d2N4emVXZGl0aDM5WS9qUHQrbjkyY0k4RXRodXQxRkVhZU1yd3liWEtZSjR5?=
 =?utf-8?B?RE1DUHRWaE5yOVZzQVRyeDJubU9DNHVQMGpyUWxUSk4vbWtCemtyYzdGYU0v?=
 =?utf-8?B?QjZkbHUzWjFxVDN6cmRVeUF2ZXh3c3dRckE5Wk91OEJMU0V6a0FNMjcybkQ2?=
 =?utf-8?B?SGF1RGlQSmFvUzhJd053SFV2V2UydUx1dmE1THhBNHZaaStldDZ2dStxVUtH?=
 =?utf-8?B?UnovRkJnYXJHanlFYWkzdjkwZWpTVXo1UlcvaWVhUXFxNjRlS2pmdHVtNkhl?=
 =?utf-8?B?NVhaeWtkcmZrZWNESE05VkxnQlNGQ3pTU3RwV0kvQW1PK2Y4VUs3MmdJREZk?=
 =?utf-8?B?aHgvdUZPSGUrUk5mc3RzSTZFMmRIVzdhaXZQZmJZVjY2cmhPSG54SVJaSDhX?=
 =?utf-8?B?RHMwMjNLZmhHbEgxVmJHU2JSamZOQnlNcjgrVElYeEE4QjBTQVVGYlh0K09l?=
 =?utf-8?B?T2xuZkxweDhJSWZMRDNqd3dTRWYrYlFHL04wZ3ZEUVN2c2JVd2puL05FS3BM?=
 =?utf-8?B?Z1hMZDk4TlN6c0lEd3N3OXNKS1Q4cFB5TUNhTWxkcDNBZ0VzbGFPdTZ5akZw?=
 =?utf-8?B?NGVpaGdzWFJ3YWFwZDhacC81WUZZRGtONkhkNVhSTmdPSTYvekRBSmhuZWFl?=
 =?utf-8?B?UWszakZoSEFuWkF3dmF3MTFGVXNOeVFtblFiREJLK1dXR1pZbUZLNXZHdlRq?=
 =?utf-8?B?NGRSZTF2djZwUkx5USs0UmM3Q2s5SzFuNGVDSmZnY0JCdXhrdDlyU0x6L3Vr?=
 =?utf-8?B?UEJLZk15L0hHWUk4Mm1Tay9CU3gzSHlwWXA0TGNTek1DeEF0Qi9VM2hpU2xB?=
 =?utf-8?B?TnlHRllFYjh6clhqWDF5QTAvckNPQmhwb0NaZ1JiR2psRHJkV25UZi9JRlRK?=
 =?utf-8?B?dEhNanh5SUl4V1ozVURlN0crUEdFY0Q0OFpjZzliWGRiN2V3ZVd0eDBJeEpS?=
 =?utf-8?B?S0g5dTRYSzRUVFEwV0Jwa2hjWXY3dU95elk0cGdpTWlXV25XRzhMb0FVeWJY?=
 =?utf-8?B?amZZUXkrdjBzOHdjT2JqQ25zQ2F2Q3JXZDBqN0Qyd2QwTmhidjZFVFZqT1RG?=
 =?utf-8?B?K0s1R1Ryd0p6eUhIQ0c5WmRPTGI2Y0JDWGRtOWJZVFhST1pla3JDRHVCWUJU?=
 =?utf-8?B?djkycnd4NCs5Rkt4V1lyYkhHRXVDdndHTm1wTXhYUlFuVnVjRVg0cm9jRmxq?=
 =?utf-8?Q?n/CqO03bQ16RueHPzHYpC/7rf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e656b630-c039-4881-06bd-08ddb7f0dd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 16:12:09.3845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYM23nbuuqPEWMBr3KYDVHHhZq38gAATSFteEQaH8Bgl3sxQIyOpWBvmpJzkplFpmczn9P4b7CcBT0N34l5BiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8581
X-OriginatorOrg: intel.com

PiA+IFJlcGxhY2UgdGhlIFR4USBidWZmZXIgcmluZyB3aXRoIG9uZSBsYXJnZSBwb29sL2FycmF5
IG9mIGJ1ZmZlcnMgKG9ubHkNCj4gPiBmb3IgZmxvdyBzY2hlZHVsaW5nKS4gVGhlIGNvbXBsZXRp
b24gdGFnIHBhc3NlZCB0byBIVyB0aHJvdWdoIHRoZQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmMNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5jDQo+ID4gaW5kZXgg
Y2RlY2Y1NThkN2VjLi4yNWVlYTYzMmE5NjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmMNCj4gPiBAQCAtMTMsNiArMTMsNyBAQCBzdHJ1
Y3QgaWRwZl90eF9zdGFzaCB7DQo+ID4gIAlzdHJ1Y3QgbGliZXRoX3NxZSBidWY7DQo+ID4gIH07
DQo+ID4NCj4gPiArI2RlZmluZSBpZHBmX3R4X2J1Zl9uZXh0KGJ1ZikgICgqKHUzMiAqKSYoYnVm
KS0+cHJpdikNCj4gDQo+IEFsaWduIGl0IHRvIHRoZSBuZXh0IGxpbmUsIGkuZS4gMiB0YWJzIGlu
c3RlYWQgb2YgMiBzcGFjZXMuDQoNCldpbGwgZml4IGluIHYyDQoNCj4gDQo+ID4gICNkZWZpbmUg
aWRwZl90eF9idWZfY29tcGxfdGFnKGJ1ZikJKCoodTMyICopJihidWYpLT5wcml2KQ0KPiA+ICBM
SUJFVEhfU1FFX0NIRUNLX1BSSVYodTMyKTsNCj4gPg0KPiA+IEBAIC05MSw3ICs5Miw3IEBAIHN0
YXRpYyB2b2lkIGlkcGZfdHhfYnVmX3JlbF9hbGwoc3RydWN0IGlkcGZfdHhfcXVldWUNCj4gKnR4
cSkNCj4gPiAgCQlyZXR1cm47DQo+ID4NCj4gPiAgCS8qIEZyZWUgYWxsIHRoZSBUeCBidWZmZXIg
c2tfYnVmZnMgKi8NCj4gPiAtCWZvciAoaSA9IDA7IGkgPCB0eHEtPmRlc2NfY291bnQ7IGkrKykN
Cj4gPiArCWZvciAoaSA9IDA7IGkgPCB0eHEtPmJ1Zl9wb29sX3NpemU7IGkrKykNCj4gPiAgCQls
aWJldGhfdHhfY29tcGxldGUoJnR4cS0+dHhfYnVmW2ldLCAmY3ApOw0KPiA+DQo+ID4gIAlrZnJl
ZSh0eHEtPnR4X2J1Zik7DQo+ID4gQEAgLTIwNSw3ICsyMDYsMTEgQEAgc3RhdGljIGludCBpZHBm
X3R4X2J1Zl9hbGxvY19hbGwoc3RydWN0DQo+IGlkcGZfdHhfcXVldWUgKnR4X3EpDQo+ID4gIAkv
KiBBbGxvY2F0ZSBib29rIGtlZXBpbmcgYnVmZmVycyBvbmx5LiBCdWZmZXJzIHRvIGJlIHN1cHBs
aWVkIHRvIEhXDQo+ID4gIAkgKiBhcmUgYWxsb2NhdGVkIGJ5IGtlcm5lbCBuZXR3b3JrIHN0YWNr
IGFuZCByZWNlaXZlZCBhcyBwYXJ0IG9mIHNrYg0KPiA+ICAJICovDQo+ID4gLQlidWZfc2l6ZSA9
IHNpemVvZihzdHJ1Y3QgaWRwZl90eF9idWYpICogdHhfcS0+ZGVzY19jb3VudDsNCj4gPiArCWlm
IChpZHBmX3F1ZXVlX2hhcyhGTE9XX1NDSF9FTiwgdHhfcSkpDQo+ID4gKwkJdHhfcS0+YnVmX3Bv
b2xfc2l6ZSA9IFUxNl9NQVg7DQo+IA0KPiAzLjIgTWIgcGVyIHF1ZXVlLi4uIE9UT0ggMSBSeCBx
dWV1ZSB3aXRoIDUxMiBkZXNjcmlwdG9ycyBlYXRzIDIuMSBNYiwNCj4gbm90IHRoYXQgYmFkLg0K
PiANCj4gPiArCWVsc2UNCj4gPiArCQl0eF9xLT5idWZfcG9vbF9zaXplID0gdHhfcS0+ZGVzY19j
b3VudDsNCj4gPiArCWJ1Zl9zaXplID0gc2l6ZW9mKHN0cnVjdCBpZHBmX3R4X2J1ZikgKiB0eF9x
LT5idWZfcG9vbF9zaXplOw0KPiANCj4gYXJyYXlfc2l6ZSgpIGlmIHlvdSByZWFsbHkgd2FudCwg
YnV0IHRoZSBwcm9wZXIgd2F5IHdvdWxkIGJlIHRvIHJlcGxhY2UNCj4gdGhlIGt6YWxsb2MoKSBi
ZWxvdyB3aXRoIGtjYWxsb2MoKS4NCg0KV2lsbCBmaXggaW4gdjINCg0KPiANCj4gPiAgCXR4X3Et
PnR4X2J1ZiA9IGt6YWxsb2MoYnVmX3NpemUsIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCF0eF9x
LT50eF9idWYpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiAr
c3RhdGljIGJvb2wgaWRwZl90eF9jbGVhbl9idWZzKHN0cnVjdCBpZHBmX3R4X3F1ZXVlICp0eHEs
IHUxNiBidWZfaWQsDQo+IA0KPiBKdXN0IHVzZSB1MzIgd2hlbiBpdCBjb21lcyB0byBmdW5jdGlv
biBhcmd1bWVudHMgYW5kIG9uc3RhY2sgdmFyaWFibGVzLg0KDQpXaWxsIGZpeCBpbiB2Mg0KDQo+
IA0KPiA+ICsJCQkgICAgICAgc3RydWN0IGxpYmV0aF9zcV9uYXBpX3N0YXRzICpjbGVhbmVkLA0K
PiA+ICsJCQkgICAgICAgaW50IGJ1ZGdldCkNCj4gPiAgew0KPiA+IC0JdTE2IGlkeCA9IGNvbXBs
X3RhZyAmIHR4cS0+Y29tcGxfdGFnX2J1ZmlkX207DQo+ID4gKwl1MTYgaWR4ID0gYnVmX2lkICYg
dHhxLT5jb21wbF90YWdfYnVmaWRfbTsNCj4gPiAgCXN0cnVjdCBpZHBmX3R4X2J1ZiAqdHhfYnVm
ID0gTlVMTDsNCj4gPiAgCXN0cnVjdCBsaWJldGhfY3FfcHAgY3AgPSB7DQo+ID4gIAkJLmRldgk9
IHR4cS0+ZGV2LA0KPiANCj4gWy4uLl0NCj4gDQo+ID4gIAlpZiAoaWRwZl9xdWV1ZV9oYXMoRkxP
V19TQ0hfRU4sIHR4X3EpKSB7DQo+ID4gIAkJaWYgKHVubGlrZWx5KCFpZHBmX3R4X2dldF9mcmVl
X2J1Zl9pZCh0eF9xLT5yZWZpbGxxLA0KPiA+ICAJCQkJCQkgICAgICAmdHhfcGFyYW1zLmNvbXBs
X3RhZykpKQ0KPiA+ICAJCQlyZXR1cm4gaWRwZl90eF9kcm9wX3NrYih0eF9xLCBza2IpOw0KPiA+
ICsJCWJ1Zl9pZCA9IHR4X3BhcmFtcy5jb21wbF90YWc7DQo+IA0KPiBTbyB0aGlzIGZpZWxkIGlu
IHR4X3BhcmFtcyBuZWVkcyB0byBiZSByZW5hbWVkIGFzIGl0IG5vIGxvbmdlciByZWZsZWN0cw0K
PiBpdHMgcHVycG9zZS4NCg0KSSB3b3VsZCBwcmVmZXIgdG8ga2VlcCB0aGUgY29tcGxfdGFnIG5h
bWUuIFRoZSBwYXJhbXMgc3RydWN0IHJlcHJlc2VudHMgd2hhdCBnb2VzIGludG8gdGhlIGRlc2Ny
aXB0b3JzIGFuZCBmcm9tIGEgZGVzY3JpcHRvciBwZXJzcGVjdGl2ZSwgaXRzIHB1cnBvc2UgaGFz
IG5vdCBjaGFuZ2VkLiBUaGUgY29tcGxfdGFnIG11c3QgYmUgdGhlIHNhbWUgYWNyb3NzIGFsbCBk
ZXNjcmlwdG9ycyBmb3IgYSBnaXZlbiBwYWNrZXQuIEJ1dCB3ZSBjYW4gdXNlIG11bHRpcGxlIGJ1
Zl9pZHMgcGVyIHBhY2tldC4NCg0KSG93ZXZlciwgSSBjYW4gc3dhcCBpdCBzbyB3ZSBwYXNzICZi
dWZfaWQgdG8gaWRwZl90eF9nZXRfZnJlZV9idWZfaWQgYW5kIGFzc2lnbiBpdCB0byB0eF9wYXJh
bXMuY29tcGxfdGFnLiANCg0KPiANCj4gPg0KPiA+ICAJCXR4X3BhcmFtcy5kdHlwZSA9IElEUEZf
VFhfREVTQ19EVFlQRV9GTEVYX0ZMT1dfU0NIRTsNCj4gPiAgCQl0eF9wYXJhbXMuZW9wX2NtZCA9
IElEUEZfVFhEX0ZMRVhfRkxPV19DTURfRU9QOw0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQoNClRo
YW5rcywNCkpvc2gNCg==

