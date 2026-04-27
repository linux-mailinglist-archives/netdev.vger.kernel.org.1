Return-Path: <netdev+bounces-281398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Em0MWqF72klCAEAu9opvQ
	(envelope-from <netdev+bounces-281398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26455475865
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95C1E3223920
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B223DA5CF;
	Mon, 27 Apr 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUUeUqfn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443453DB627;
	Mon, 27 Apr 2026 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303820; cv=fail; b=sSMimxVUJ5YdQsxfdjpJPajHrfAryhyomIN+suOwWOXPXp6OQmQtjK/dijwKF2tprsukN6p3r9j+lrCuR/GIyadOrN6JMjeYuOWqugGKIxCewuwgo6koo//S/AahTabOeCnYhjsp6cTZnetCobiG1uVZhoULeN24Nq6HbnfEjxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303820; c=relaxed/simple;
	bh=3Oc+lokG1n60s8Z+/oKFReuWKsKxXWcnGjnOPLa/vuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFSgSNCfJM1OkaJs+VVs8koXbwpoMueGiXRvG47BvP2n22odnfUppE987kdsu23jQ490wfEE2UpsVPuOTOOuzt+ZJ6mnqHC95H6dKpbH1JbAdtixwVYDJUJW9umyoAMKyrBTyLTp7FVDxGlh5znwkFVXj1nTQk7tVCLSa0EIGeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUUeUqfn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303818; x=1808839818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Oc+lokG1n60s8Z+/oKFReuWKsKxXWcnGjnOPLa/vuo=;
  b=XUUeUqfnCfmY+RQA2E7/IbNvOK7rDB5AHlMyQ+i0Za6GGKEhbkgApcCR
   lLa9HPEbFtZGZYgF27d44Gq2i0rUffB8oi9Lny9xmsmBHKkC80BomooU1
   NSi8PrQTH7uJMIYLNaauRrzgSTzhbfMxduZ4/XsshnuqV0CfBciuUPqTP
   Wq4QkqZo121T9Rck0oVZ9vMco/Wgc59iVeC2kQAQFLHpxet0LkeU7EfGA
   GrS0ogRsyFXmfmYJ2Go/URTYMJWKAmcB4iuPpYsOf6xumQFfFBEXNhrN6
   LYNRhcc3MhibPTNTKN7D1QyxsBMu91ExZstS/y1QZk49LH2/mDPJ6wMwL
   A==;
X-CSE-ConnectionGUID: 5y6XLtI3Szi8bbAPN74VFw==
X-CSE-MsgGUID: ivBzsqNDQaeaeOR/LIzi1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="80769849"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="80769849"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:17 -0700
X-CSE-ConnectionGUID: FYe/hC+nRAGl0UyeTfUjKw==
X-CSE-MsgGUID: L7IuBRMGS/m/lHdvaJE7Pg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 08:30:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 08:30:16 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 08:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOwPtMzISM/XBmSQzBNVy1O5xmlWAfmf3Zc3DGmhplHvxCqa+EIfUmsuPRBbim9V8qE4wMDXmaSn7LUJwij5SITgi4OqjFzyeF8lQKuzgRLj5DJXuLVJdZjOP2FYk2qLYh+3XmmWj3bU/PjVc1qxt/TjmrZzLQ0aHIesjy2EymhGvWr5CTlsJ4PLHHOan8PqBKg2VxBCRe/ZopVAk0sCIM2fYsyquX9Z2p43AfaR6aPrxYsmZ9ertx321rXhwNQMl7HMXUmzfure9SwqqlqmlIDmbhhhyl74v33nF+/7/uutJPpPLpeTCHVNk7N/cdLvsXhpCoB6YYCmHEjKISwtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVBfMFiORIwbJvS6SgoVtUu0p5VBTkQMzgfGOakLNTQ=;
 b=MhP2i6omiUg8GhXpeYSOq51LJyHJsflXmz3Vj18PVWzZz57AnfBgRnMg6scZhRLG9QH+rOdbHkja6e4chNkFEjhhiTtyXRSJU+T8iAkr3qWO7bUj2MS+copAMVXeRISuGavCexmRuzA/fPHwM3gpelb+4eiAPC8I83oas2/5kFWlhHSF7GRwtIfECAjWHiBVNUOHO5zBNwJGoX8BIBVNB9aqyBIvqnyHPoKyDZRl4VQfJLjsjsctOlEIwLHq65opmECapNsSZCyTPK7sND4sW1maQMDyOUaY8G9/e3IDP7khnGbYQuO81TTd+zvi4wi468XssfbUwiqMiCrBYEMhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:30:09 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 15:30:09 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Schmidt, Michal" <mschmidt@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, "Oros, Petr" <poros@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix stats array overflow when
 VF requests more queues
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix stats array overflow when
 VF requests more queues
Thread-Index: AQHc1lk48Odsf+k21Uyipa6RzxdPxrXzCECg
Date: Mon, 27 Apr 2026 15:30:08 +0000
Message-ID: <IA3PR11MB898650A3226F812E881C1630E5362@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260427151827.43342-1-mschmidt@redhat.com>
In-Reply-To: <20260427151827.43342-1-mschmidt@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB7254:EE_
x-ms-office365-filtering-correlation-id: c9fa4db1-1c9c-45ca-582b-08dea471ddb9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: WGst+Sa42WBAi9wny+N3DVBfoRRJcH0lpjunpvKPCqjy/9m7fLgatsdHGNnc01jY+SwKkqpyBtIqvi3rRcCc1j1B9Bd8zP1wya3J9SYPfuc7/yXXlcZO35sppljTGb7RfUyn6XS11WyF7cB6Jp6I7Q9v5flTUIOKUXvB88zyLq2Rb6QeogVsp94jTljJlgHNH9udAXRj9I5f/dZFhtaEoMfCHQiJ3dXrXUtDLgAbfEO0RPWS0JCU8bXXWMheuJj0F8DJ4HJ/ASAGXIwCFIUHl2yYw0+J4QjZXCym+Z57pgGQwyCTj1X2RB9G5jXmMSeijDvwVH0m1BdXxB5BOzNiZKs/JV+r5EDsVWmjIJpPCxqp/r90lV89AXRqkJmm49pcvynQLBR79AQgAf7YlQB0kkRsxKrGaJ7lbvSvGy5zkyooe85ySNL1BnC3TM0xBbsanOKhmyE4nZwiifJEArMVDrNkiVBMXp9YQIAp8CvZ+Iq33oJ35CYE4amGum+peFo/munW6t6oMm6IGuhm4DlOetnLIsBSNQz0m4fEEwxwF7GaubaYiWZ5DAR/FCvd2GOXe0e6XzVpJiiifzcYVwbN5Am063D71e9k1ZvNchGngSDQCY0AK4B3ZiCOW2nyBeD4diYg9CPyH3fK2J82uk6Cz6ruQoRnC5HAsg7JW1qnP84dpiJqi60VLCLjw8C7YmNZ4t60Tp85Dzpp6dtK4XLxl5TCXo+tCgq4j8tTaiWBA02oyzZ1LMFnOktTfidVJrlajDRe5DHH7dlWMHrUwp9noyKzz1WLv5vC74vwkXjb7WJ4TDBJjaX0ImdTlHjjGJfP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LyyLjpQE0g8bmgTnNGPP9dDkcDPnVM94pChSycwqLV7Z2xqxW306cZfTRaHf?=
 =?us-ascii?Q?b7O8gNUiIGhyvOiZXgAIc+UCBB9B3hq/fFH/LCpj9jrRdIOi9c90YLjorSUV?=
 =?us-ascii?Q?XjIIaAAA2Q1JIWUjAzoCZov+owTvnFWllpkhihNQmONDEuNJqE5MpEpR2yjC?=
 =?us-ascii?Q?YZwXU5aPsEQZESQQX9q+EsfEN5HciSgMjYGRaNdndWCpbhzVzxI21Lvgxafg?=
 =?us-ascii?Q?AnmytwqDG/ae1ECeDFhq+CVpmz7iUsQLstQBlxfW/kz+6lq+0yxG2Cc27/5d?=
 =?us-ascii?Q?/9TXVNTXGwga6OPEXJa2k4D3fW/hKU1VDV1S1D/060WJyig118t+EWvHdowa?=
 =?us-ascii?Q?JR24jYWzbaXLCGryCsgoIU+6qU7PMVoNAq69RQaoVSlKTj/oD4svvcEqIqq9?=
 =?us-ascii?Q?ih+WQi3VO3e06K1Na7jMSV7tWiJeoIwUZ6VK8mrVLN8j3g++05NaHe2O45w0?=
 =?us-ascii?Q?QS+v4UYUop68YPvKlOgA14WdeJMSWQN0Mpki8SLJbFrlLE2OPpO3E1v+5Zs+?=
 =?us-ascii?Q?3MX0vn64lWNJ0oBMIWPchiTGOG4hhKFR7/yndD1D81v1CTxwt9omnbIzso3v?=
 =?us-ascii?Q?GvUg9U2JQy3PvQ6FIQCprkQzwR5r3tcFbzh5CB6gcSoxi7u2lrelBkFzg1gF?=
 =?us-ascii?Q?edVUWyhxG/5Df/4EJg9yqOh4YfdsA22uW6a2fjYkJ/nAYximn4DbXxAEZgGZ?=
 =?us-ascii?Q?fUO/QSgsveyTKZqlfEEdrlCVMomfI62cfACr6yjp95iudWNwl5NhGmbzvBg4?=
 =?us-ascii?Q?wjk5+YRN4WlYZwjxwFE9oJhBi3FSYdAXdhzYluhfXoJiPGRldMEg53WwwXgu?=
 =?us-ascii?Q?mf6dol0hDllzRB6PKuz5C5CKRmIVw4U9Gib5ogifG4xz/LQhxgVLDsJwR2Kk?=
 =?us-ascii?Q?HEX14MDQSdj7W61vR91oRjp86+T2jK2Lab5s/9GbvGmR6YxybUKvxk/zE7kc?=
 =?us-ascii?Q?dvaSDO3Vz953llCskkTZ+NoBGpS9nY0WjoIOzmTcLlQZJrWs2C0yRkQuSEhc?=
 =?us-ascii?Q?bKNcUgS19wwzUNO0VcTipYsjukrr+RjkzVpdUlHy1Hstz1IFjyHQtTmP4wmv?=
 =?us-ascii?Q?ACoyv9Gvq8tsCDi+t8GvXEvgRyV1Z+g5HpRxybSDpVFn1ntI3ljfCF1pHF4g?=
 =?us-ascii?Q?fIb95sJeDSl2BmqueT7e5p8ZewAEFYJFRYEGWDocsuXJpU5850hCht11bMjk?=
 =?us-ascii?Q?rSSP64iixyg/hKrumuPHFigoFkdpGqEKpBClafHWvaIE3qPeDzFPYApQILW0?=
 =?us-ascii?Q?MYfBZTB5Idpufjtl9OyvJ3RrEcDvDR5a5N8vbWwO89R44wle3J5HicPTdtRp?=
 =?us-ascii?Q?oR0QQ6okxioIQhAgSwdci22lVoa3YM9Pm6I4B289sdClim04Me+PyiMKOp2R?=
 =?us-ascii?Q?O/riYfWtmGvgXlTwlKrEwFxIZNvAdC3MMTrr+0RnosDfNBUBtomjKuDm9rPl?=
 =?us-ascii?Q?DanJp0zGxZXk9MTSpD5K2c/7a3BzamaG/EXTaO03J48h6epFhjNWJdAF3HWv?=
 =?us-ascii?Q?3XUoja7nndoZ2HkXDx6Lgqfa0j34+hutUPB5YLvGZtMuMp90+eRJCM1wrARc?=
 =?us-ascii?Q?+Be7MG7N5j8LyexmXxQthsBjGl4tdB2trAZ5wMZ+kKa+3bYgrwAf8uhuhecy?=
 =?us-ascii?Q?EQ/VGyZZRqkSW1vCAZNQzlAdKOv8Ctg6RknlZTh8vRZsBThzAFkpsp+6gED7?=
 =?us-ascii?Q?O3XP7zdL65fX1VY4yUEFlYmkBB7ml7TksqecfmVC9E7UajtaOw8hc3bkLggn?=
 =?us-ascii?Q?E29hsqnwzhn+S+Rf0l0ylGqvS2epcuQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SpsnHXlkfkFkxvfzVJ8DVWtDYbk+Jz44q25lCMgESbhfVv8y3rZsQTTCBq8VuJE2Izt3rjaMX0xJ+x+Vvc+d9GyAi0VFFZzwlXFPxPFKvXzOjnLBiCtVE/muj93hY8A40cGIUOq4vvrOirGWFWNxoKBBJNKd/iJBuhWSPJtvxwrmMuFT41Aqspj/KKn+XETUbLDWTuoCkeF0iS23uhHadcXGlBLtjTUa9JMo+8WPzZ6dFkOVnTezs633yp/Sf0OS40NEr+Su4Fes/xYKCIjfHfxd5ibnjWwjVP79lDU4tz9AfhMRw/bQg6ErJWZQVaNxaNrBP4UIM04+VMwv67NRMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fa4db1-1c9c-45ca-582b-08dea471ddb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 15:30:09.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xt14jlUSSNtuAtkIBnkejUxzLZTo8gYtM/8ZqECDPNy7mR5Sf4590917CsbPJMPhP4SMUxVOqlEUL/b55nO/z11wrqET88Yy3fyjTgJm2x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 26455475865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281398-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michal Schmidt
> Sent: Monday, April 27, 2026 5:18 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Oros, Petr <poros@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ice: fix stats array overflow
> when VF requests more queues
>=20
> When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
> ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
> The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
> followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
> stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
> alloc_txq/alloc_rxq to the new larger value, but
> ice_vsi_alloc_stat_arrays() returns early because the stats already
> exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
> alloc_txq and writes beyond the bounds of the old, smaller
> tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
> metadata.
>=20
> KASAN detects the bug:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-out-of-bounds in
> ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]  Read of size 8 at addr
> ffff88810affea60 by task kworker/u131:7/221
>=20
>  CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+
> #1 PREEMPT(lazy)  ...
>  Workqueue: ice ice_service_task [ice]
>  Call Trace:
>   <TASK>
>   ...
>   kasan_report+0xd7/0x120
>   ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>   ice_vsi_cfg_def+0x12e2/0x2060 [ice]
>   ice_vsi_cfg+0xb5/0x3c0 [ice]
>   ice_reset_vf+0x858/0xf80 [ice]
>   ice_vc_request_qs_msg+0x1da/0x290 [ice]
>   ice_vc_process_vf_msg+0xb15/0x1430 [ice]
>   __ice_clean_ctrlq+0x70d/0x9d0 [ice]
>   ice_service_task+0x840/0xf20 [ice]
>   process_one_work+0x690/0xff0
>   worker_thread+0x4d9/0xd20
>   kthread+0x322/0x410
>   ret_from_fork+0x332/0x660
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>=20
>  Allocated by task 2439:
>   kasan_save_stack+0x1c/0x40
>   kasan_save_track+0x10/0x30
>   __kasan_kmalloc+0x96/0xb0
>   __kmalloc_noprof+0x1d8/0x580
>   ice_vsi_cfg_def+0x115c/0x2060 [ice]
>   ice_vsi_cfg+0xb5/0x3c0 [ice]
>   ice_vsi_setup+0x180/0x320 [ice]
>   ice_start_vfs+0x1f3/0x590 [ice]
>   ice_ena_vfs+0x66d/0x798 [ice]
>   ice_sriov_configure.cold+0xe4/0x121 [ice]
>   sriov_numvfs_store+0x279/0x480
>   kernfs_fop_write_iter+0x331/0x4f0
>   vfs_write+0x4c4/0xe40
>   ksys_write+0x10c/0x240
>   do_syscall_64+0xd9/0x650
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
>  The buggy address belongs to the object at ffff88810affea40
>                 which belongs to the cache kmalloc-32 of size 32  The
> buggy address is located 0 bytes to the right of
>                 allocated 32-byte region [ffff88810affea40,
> ffff88810affea60)  ...
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ice_vsi_rebuild() handles this correctly by calling
> ice_vsi_realloc_stat_arrays() before reconfiguration, but
> ice_vf_reconfig_vsi() was missing this call.
>=20
> Fix by calling ice_vsi_realloc_stat_arrays() in ice_vf_reconfig_vsi()
> before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. Set
> vsi->req_txq/req_rxq from vf->num_req_qs so the realloc function knows
> the target array size.
>=20
> See the linked RHEL Jira item for a reproducer.
>=20
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
> ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
Not sure are links to local JIRAs are acceptable in kernel?

Why no Cc: stable@vger.kernel.org?=20

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Assisted-by: Claude:claude-opus-4-6 semcode
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 837b71b7b2b7..fc78176a2a8d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi
> *vsi,
>   * ice_vsi_realloc_stat_arrays - Frees unused stat structures or
> alloc new ones
>   * @vsi: VSI pointer
>   */
> -static int
> +int
>  ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)  {
>  	u16 req_txq =3D vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h
> b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 49454d98dcfe..6f7da84384e5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -66,6 +66,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
> void ice_vsi_decfg(struct ice_vsi *vsi);  void ice_dis_vsi(struct
> ice_vsi *vsi, bool locked);
>=20
> +int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi);
>  int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);  int
> ice_vsi_cfg(struct ice_vsi *vsi);  struct ice_vsi
> *ice_vsi_alloc(struct ice_pf *pf); diff --git
> a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 772f6b07340d..9edb2c14f553 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -268,6 +268,13 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
>=20
>  	vsi->flags =3D ICE_VSI_FLAG_NO_INIT;
>=20
> +	vsi->req_txq =3D vf->num_req_qs;
> +	vsi->req_rxq =3D vf->num_req_qs;
> +
> +	err =3D ice_vsi_realloc_stat_arrays(vsi);
> +	if (err)
> +		return err;
> +
>  	ice_vsi_decfg(vsi);
>  	ice_fltr_remove_all(vsi);
>=20
> --
> 2.54.0


