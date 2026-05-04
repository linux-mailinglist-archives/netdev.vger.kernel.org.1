Return-Path: <netdev+bounces-283768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL0dACZs+GnPuQIAu9opvQ
	(envelope-from <netdev+bounces-283768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:51:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAC4BB404
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5856F304DE8A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E83914FE;
	Mon,  4 May 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q49Dj9st"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3038D6B1;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888118; cv=fail; b=i3t0KAbiLqjs/1+O2kdCrXlBxTM7krtydOuM8p1wapC7LAR5H+Aw/nZoeK7w16pt8/lPk1I/ZqYY6yT1pVTmitS40RRMGXyjX57L03H2aUPogL7MEhPsIOYZEAqj4cnRXLUFCRybsV+9MaOv6y5r9Tr14f2G2frcAZAzROtzes4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888118; c=relaxed/simple;
	bh=bwExt8WHePP69KgU1NGxDEyxJHi2ZewSsh0c4CHRoo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtrXy1kBiGVVuH/Lj3pGPKtuzWP18xtsH5dgVY7BqdjdLlRlC/+jlGnlYo7qXM94eH8xO/WeOdXLuNwi7ucLKoJkQ16AfNy8z7jqvYBUMp6DNG6yDsNtsGTAAmWbgCeHEMlIKRbZdVaUCWv22evsJonJqyIZdQPA0oL9jrsgcQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q49Dj9st; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777888116; x=1809424116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bwExt8WHePP69KgU1NGxDEyxJHi2ZewSsh0c4CHRoo4=;
  b=Q49Dj9stOERZkPkX0x8IKrjxQ2oozlwbGDK4yst66O11t4VBB2QsyoHh
   YXClDAtNrkDJS4OQK/TbE2Dn57s6wCoqHfhN4C01GVzD65i61JRinVQQR
   P6Ddw51O496eyslamvBkb9Yl3C9UpiLuh29N/PobyTyNg0a2LN82TQTn3
   b3owGUIS1grcCasweZ0WXB0CGY+XVysJTDuF1i6ajQG3ZIlawskZXXqtm
   RoqhJpUtsST5FKpAMCG/IEaYxl+aDuTDe1wV5X6SwiPFi8546gXeupSMw
   9fTvwFfrP6Bx71d0+d0RjQWWFRP7Yz734p2ZZ+Z3aDCHRkEw8ZkGHfQvd
   Q==;
X-CSE-ConnectionGUID: eIkVy/yWTuGCOmJ90OP5jA==
X-CSE-MsgGUID: NyjJpJz8S1qj2eBo1WSf/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82354558"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82354558"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:48:36 -0700
X-CSE-ConnectionGUID: DuL1DyjZShO/Z5gyaab7pQ==
X-CSE-MsgGUID: V8tX4pgESROSpS7+03YPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="258824313"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:48:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 02:48:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 02:48:34 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 02:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A35dbtjupVNKFacTMIJNNcj10xMyLfbg2MojV/6sNkLJP37+2B8gUGc4jzYjgbHDyd1P6UgI76pndM3EQktvOBxgDFYdsM9DReI5ikLUNIsxz/yeWG2XhlizdH0s4ypSYuVslootO/63lEljcws/VdY03UDdO0FLnS4ZixZ38zNmRrw00P9KGZgnrMde4NxgJpe796WsqBaE5GBenAQfPFaRM+aSUYFT8JKKDFla3QvCmTI6T21t5Xjr6FXde7RvR//6P3oUuuhRH3v5D6Mn3K3w76qnzVHLGWBpTiXQlvB+qwe5dV6+oeIJl6JX0SMgZf7qCaDL8BobBWVteFZMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwExt8WHePP69KgU1NGxDEyxJHi2ZewSsh0c4CHRoo4=;
 b=gdxPxAYQLWfwM5KuYmzvPN9wr9AoTf+OW1DKfKhfoNeVPwwD4k1xPNcOOWX+CzrxxBDOnI0nY7WuCV76vSWvmqyFENxSUDiDUTNHUsOMiiQYYSV6VjM6lQSDE6QxEQOkJckVzdJ8Pa2bVS3wNDeHaSHI1bTXHSr2SsH9WdgWFN31D6D4CCOmzmwlR3/nG5q3l9Bukhf/+tyEiMYv6WpL2Fufzs1tmt61PuDB+LaYUQVR3Pg+6XuyrOOaVT3Hmm9hBhB9vhT9mqpE0yl9Nq8DkSd5NdG8CX0k2wcFbKkNazM6M8f8oqGl6RNxnXHUWQ5ZUOHE8oEYy3oEiKhMDFc4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV0PR11MB9837.namprd11.prod.outlook.com (2603:10b6:408:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:48:27 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:48:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Vecera, Ivan" <ivecera@redhat.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>
CC: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Byungchul Park
	<byungchul@sk.com>, "Nowlin, Alexander" <alexander.nowlin@intel.com>,
	"Rinitha, SX" <sx.rinitha@intel.com>, "David Hildenbrand (Arm)"
	<david@kernel.org>
Subject: RE: [PATCH net-next 12/15] ice: access @pp through netmem_desc
 instead of page
Thread-Topic: [PATCH net-next 12/15] ice: access @pp through netmem_desc
 instead of page
Thread-Index: AQHc2TUmw/K7K13I30WlEenjdkUdmrX9o9Rg
Date: Mon, 4 May 2026 09:48:27 +0000
Message-ID: <IA3PR11MB8986E36DEBAD265141C60D2FE5312@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
 <20260430-jk-iwl-net-next-2026-04-30-v1-12-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-12-6f27ae1cd073@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV0PR11MB9837:EE_
x-ms-office365-filtering-correlation-id: 5b4e78cf-0d83-45fc-5e41-08dea9c24ac0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: PC1vE58i/vlo1SuP1INyI/Tp4XaChWk+mbVgNbR5kbybpPvtkdTVjH7bFqHdqkAc+dDj6z9PUeNMEGCKi44MnGzNY5ivUx3nvzsD5oOfG0Sn/WShr3ehZ2R8ym9Jvv9lcFN+6sliVYIrK3l25IhyJNQ0wE28UuBsJJ/esy2MSq/wNTJ9h70LoJhKtQJS/E5+XsCPNJybNqpSL9WGvLDma+QAW98aIqo5o2k0oMWB87byDuZteFzIzIi34CyCdvrvsfbrP7cw6u+VgJKCmy54q7pTpK4IRdSBA7oibcxFbQ0VGpBvCnjfIphzSQkVawfay5jgx0DImRVOP93vx/QuuOSX6vLw41VmpJ0z9wwu2eybq5jN1Md8HSUXRossTCsAZ/EpKzhHr/YZ1NxFESDED2X80PZKKNL85FJCXoJ6lvlS5pFdbK+20nUTPvC2qWI9UNDqNcNq+hjQrUpz5iPPVwDQZszMGOEIwi+hW2dmntmEVvWTA1VgtweuH6se780WB121Tqkc5U0wCIIxrJ1++cNwL9bPF71vB2MsEVYzhLm52e/xL6qNMXXquH4qroZMGWgx+wqmkAua0v5i966Rj9ANAvWar3+U9SUIljD1gfQNA8XfldG0dS7Vdtn6GAp75pQJHgthaXU4PgO5nsNo34g5Fckko55b2PMSESQBhofZ/8cTMCHpJkWWhhVfSbq7t0yJBE0lNqTygn1c16DfIRjduAPl7ph8Z4xOKPw8h7P/h4KLuB8s6jLo4dW0BOph6QCdri9BAXC11fTldlPwhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDdFY2dDMTcyZmZWb2U1a0xqYU0rNlZKNUJ1L0dvT3A0amtRaTlRbkprMlBo?=
 =?utf-8?B?ZGluajlva1EwRzhicHNOYkJrUTZIeGVwcHJLSkhQa3J6cXZvQ1BwZlhKWW9L?=
 =?utf-8?B?SmRPelV5SlNHc3IrRllLaDBHVlludU0vRVhwZ0JaQktxSXFoYTRJK3hFMWJN?=
 =?utf-8?B?R2l6OW5RRkE0WGZLMzBKWDhLRTJyZ3poRWRuZXZOQVBmZEswYzkzL25KVVZ1?=
 =?utf-8?B?ZTU3eDE1YlhpbWhTUElkY245cUFLZ0tQRVdXcHhVSXlHN2JCUmF0dnVhSXlP?=
 =?utf-8?B?dFJlVzZBbjZpbEREdWZXS3NBVmNsQUt5TS9SaFBsWDhnaE9GVXJMcUtOYUU2?=
 =?utf-8?B?MURMby9RbVhSbldFdVBJSEkxV3liTk9pL2szQXFhMjZMaFZCNnhrOUxpaHBq?=
 =?utf-8?B?VlQySlhqLzN3OTJ6OWZxZ3dLWXZIUk5yRkxkcTZHdi95TExVS3JTbExvUFlu?=
 =?utf-8?B?cm5teE5rUWtpQzA2R0ZDTkYyMkxneU8zN3d6czliTm5sNnhRMzc5aDFXVi8v?=
 =?utf-8?B?aUxDYXA4ZUYzM1kzNFhWOVJ4VkFSZ0ZLWnk0NjhZZ1RwbHE4REttcWdLak5K?=
 =?utf-8?B?THFqYmdSVko2Wm9XMnovSlEySVg2Y1Zwd1lzWGgrZFh1NVU4Zm41RDZSa0Jq?=
 =?utf-8?B?bmhmZ3lKaFg4aU9RQWNyOW5ZYVlwRTg4cWpFeWpxM1RKdDFDeG03U0FGNU5z?=
 =?utf-8?B?c0IyS0piNHdKOHAyTGlwelBPa0kzZ1NyOUlHZ0NndHFQTWZ4TVFzSVpVcXpk?=
 =?utf-8?B?VjYvTkdMMDR1cnhEZU5CZ0YxeXROUHptb25RWlVUbTh2MEJHQ0kzQUd6V3pq?=
 =?utf-8?B?WTcvNmtTOVJUWWpvREwrRWYxN2FtQ1UxY3pzN04rdWh2cFQ5WmNBQS9NM05I?=
 =?utf-8?B?c1J6bDlVbkF6VTg0U2dqRkJJYVl6ZXNTTzBpMmZsd3hocUN6RkdobVg2TU5R?=
 =?utf-8?B?S0xBRlhkZTdleG44RGpTbGJGUXdHZzcxWjZmendzeUF2MzJ5TTlhNDRQckwz?=
 =?utf-8?B?Z1VQT0VqSi8zRGpodFhVUU8wN3cvc0ZjQStTNkIrUEFnZkttNk1MNmFzcXIx?=
 =?utf-8?B?bmIyWHpNK1JGRVVzY1RvRmduTGFXa0Y1T1ZNTnZNd0FYTUhIaHU0Ymx1UEtT?=
 =?utf-8?B?S0Q3b2h0ZkRFL1NBckRSc1lYaWJsMGh6U2RFOEd6bzRucVdhUmRFeVR1ZEpj?=
 =?utf-8?B?a3RRbHBDdTEreTdJdVREMU1lekl1QTd4eklyNHlWOU44YUl5REh5Y0hPZ1hF?=
 =?utf-8?B?aGF4N2xmOEJ5SElxUjF2Tm5iQ0ZnakhKQys2ODNiV0hQaWRMa3lROVRrQ0pD?=
 =?utf-8?B?dU9oQ1RYckp4bTROTW4vL1Z3ODVYRWNDeHV1anJpaTNldjdCdFFHNXJHTDZh?=
 =?utf-8?B?TzFlVzJzajF3UzBza1dnRkllcEN1R1dlRDBDUndHOGNPcTFQNE1BSVJQYjhN?=
 =?utf-8?B?TGYxYTRjb1pHUnU4eEdNdWNoQWhIWTFZbnJ1YllydXltUzFvb2RNc3Z1bjVm?=
 =?utf-8?B?TC8zblY3QzB0WkVMQ1NySEovaUs4Um55SUthOTBTUFVpaGZxNmIvRUNhZFZU?=
 =?utf-8?B?RFo3NzQ0c3lxSG8vdEpVZHRLbS80aElUdFBoMFBFQVNoZHZ0TEtMNTlENU9x?=
 =?utf-8?B?WjN3dU1qM0lwM2ExUUNvaFlJVDJ6SStPRkdObzFtOS9IZTJ6ZEJUVm42Tjdh?=
 =?utf-8?B?KzYyWGV6L3J6TG11eHZWdVR0TDcyb3dFbzlCMjcyUkUwdGpObnY4ZG5YK1E5?=
 =?utf-8?B?amFjcXo0TkN4eWVWcEpZNFE3czVsNENSY3JZWi8xUmg4TU1pOExUcDVHRk1q?=
 =?utf-8?B?K2pFcEMrVGcxWnY0R05IUHAwVDBxdVV0cDB4WnZORE5wNlZlS2ZWRUFzbEZn?=
 =?utf-8?B?TlNaVEllMkgvK2E2cGh0WjllVzdTQU5SK1VrbWpYQVNyL2EyUlR3Ukp3UHg2?=
 =?utf-8?B?bHArWWdHUVpEQU1ZTkZVZXYyY21iVHFQSDNhQlJIK25lTFJROVNEd3ZWZlVN?=
 =?utf-8?B?b2hZVVJ2cXEwTk1pTUZjNGdjcWo4QVg3SkZZWG1XRTJOV1VQcFdZQm9zMEZm?=
 =?utf-8?B?TThvRklLeW5jVS9BRGRLVXBEcHViK20wQThybmFxUnZPZGdzbHhmUVp2SnU3?=
 =?utf-8?B?UjJ0a21LYkMxYmRaaUhERk03WFpRb3lnVTl5N2t6UnNpZU41SHZreW1BbGxy?=
 =?utf-8?B?RzdQdWlkOFNlYWYydm9kVDJnZ25LbzJuTlBvUldmOWc3aTl0YjVYbG05Wkp6?=
 =?utf-8?B?YkJDblBiVXozdUZ6ZXBOZEdkVW1NVklJNDQ5MytTWWNYQktZc2ZMU04yS0Vt?=
 =?utf-8?B?SWV0NlJvRk81dVJKckdYbTFFZ0pyUVdCRWZJV29BT0ZWNUV2OE9CQkdkcEJh?=
 =?utf-8?Q?gLQNmbh3tJrqnBC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rgEi0KHoAN5YQ5q4kbSHhjdGofDyCzmHk42k/aR06Q55Shy7bzWJFsJWotN6TQXwB4jjy8R1tMBvsYebqlkleJ79lKYTRFp+0P9TnTooFE0nLj+PTvt+G/24t9ZnfqiLWlUjk+VYUMe+xVmfaD9jluhHhsEwD7QVvHgqq/FE53EjCHwce7tdiXKg3bcO0MyxbzJgwBRCyn1YmLaq+3x2T9MG4mY7Mhf2ghbEkPZ/JCyr8WLP8cEcSBHrKU7OFKCEuV4J6JNjhS9jfJDE/ggYP7murXHMNJAJuCK5ZQlu5xcVI55VY8eRheWiMNv9gSEa0UFXPn9HFqUlXwpvmDpGYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e78cf-0d83-45fc-5e41-08dea9c24ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 09:48:27.5908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsm1VFPKMtQZEabQo1/Rk0XYnKKXWQZ9T+7tQWgCYokNh/io4qiUiGCB6OPqMqLzb4zXSym8ePpUV6ZOnY//BnswlIHiAUNkqkXPpDInIfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9837
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4ABAC4BB404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283768-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDEsIDIwMjYg
ODozNyBBTQ0KPiBUbzogS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGlu
dGVsLmNvbT47IEFuZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBT
LiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3Nh
bmRlci5sb2Jha2luQGludGVsLmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47
DQo+IE1pY2hhbCBTd2lhdGtvd3NraSA8bWljaGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNv
bT47IEphZ2llbHNraSwNCj4gSmVkcnplaiA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPjsg
TG9rdGlvbm92LCBBbGVrc2FuZHINCj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsg
Tml0a2EsIEdyemVnb3J6DQo+IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBWZWNlcmEsIEl2
YW4gPGl2ZWNlcmFAcmVkaGF0LmNvbT47DQo+IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8YXJrYWRp
dXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgTmd1eWVuLA0KPiBBbnRob255IEwgPGFudGhvbnku
bC5uZ3V5ZW5AaW50ZWwuY29tPjsgV2Vncnp5biwgU3RlZmFuDQo+IDxzdGVmYW4ud2Vncnp5bkBp
bnRlbC5jb20+DQo+IENjOiBLd2FwdWxpbnNraSwgUGlvdHIgPHBpb3RyLmt3YXB1bGluc2tpQGlu
dGVsLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEtlbGxlciwgSmFjb2IgRQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsg
Qnl1bmdjaHVsIFBhcmsgPGJ5dW5nY2h1bEBzay5jb20+OyBOb3dsaW4sDQo+IEFsZXhhbmRlciA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+OyBSaW5pdGhhLCBTWA0KPiA8c3gucmluaXRoYUBp
bnRlbC5jb20+OyBEYXZpZCBIaWxkZW5icmFuZCAoQXJtKSA8ZGF2aWRAa2VybmVsLm9yZz4NCj4g
U3ViamVjdDogW1BBVENIIG5ldC1uZXh0IDEyLzE1XSBpY2U6IGFjY2VzcyBAcHAgdGhyb3VnaCBu
ZXRtZW1fZGVzYw0KPiBpbnN0ZWFkIG9mIHBhZ2UNCj4gDQo+IEZyb206IEJ5dW5nY2h1bCBQYXJr
IDxieXVuZ2NodWxAc2suY29tPg0KPiANCj4gVG8gZWxpbWluYXRlIHRoZSB1c2Ugb2Ygc3RydWN0
IHBhZ2UgaW4gcGFnZSBwb29sLCB0aGUgcGFnZSBwb29sIHVzZXJzDQo+IHNob3VsZCB1c2UgbmV0
bWVtIGRlc2NyaXB0b3IgYW5kIEFQSXMgaW5zdGVhZC4NCj4gDQo+IE1ha2UgaWNlIGRyaXZlciBh
Y2Nlc3MgQHBwIHRocm91Z2ggbmV0bWVtX2Rlc2MgaW5zdGVhZCBvZiBwYWdlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQnl1bmdjaHVsIFBhcmsgPGJ5dW5nY2h1bEBzay5jb20+DQo+IFRlc3RlZC1i
eTogQWxleGFuZGVyIE5vd2xpbiA8YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+DQo+IFRlc3Rl
ZC1ieTogUmluaXRoYSBTIDxzeC5yaW5pdGhhQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERh
dmlkIEhpbGRlbmJyYW5kIChBcm0pIDxkYXZpZEBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2wuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbC5jDQo+IGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9ldGh0b29sLmMNCj4gaW5kZXggZjI4NDE2
YTcwN2Q3Li4yMzZkMjkzYWJhOTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfZXRodG9vbC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfZXRodG9vbC5jDQo+IEBAIC0xMjUxLDcgKzEyNTEsNyBAQCBzdGF0aWMgaW50
IGljZV9sYnRlc3RfcmVjZWl2ZV9mcmFtZXMoc3RydWN0DQo+IGljZV9yeF9yaW5nICpyeF9yaW5n
KQ0KPiAgCQlyeF9idWYgPSAmcnhfcmluZy0+cnhfZnFlc1tpXTsNCj4gIAkJcGFnZSA9IF9fbmV0
bWVtX3RvX3BhZ2UocnhfYnVmLT5uZXRtZW0pOw0KPiAgCQlyZWNlaXZlZF9idWYgPSBwYWdlX2Fk
ZHJlc3MocGFnZSkgKyByeF9idWYtPm9mZnNldCArDQo+IC0JCQkgICAgICAgcGFnZS0+cHAtPnAu
b2Zmc2V0Ow0KPiArCQkJICAgICAgIHBwX3BhZ2VfdG9fbm1kZXNjKHBhZ2UpLT5wcC0+cC5vZmZz
ZXQ7DQo+IA0KPiAgCQlpZiAoaWNlX2xidGVzdF9jaGVja19mcmFtZShyZWNlaXZlZF9idWYpKQ0K
PiAgCQkJdmFsaWRfZnJhbWVzKys7DQo+IA0KPiAtLQ0KPiAyLjU0LjAucmMyLjUzMS5nYWY4MThk
NjMxMjZhDQoNClNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5s
b2t0aW9ub3ZAaW50ZWwuY29tPg0K

