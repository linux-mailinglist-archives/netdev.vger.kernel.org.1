Return-Path: <netdev+bounces-292601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHDCHa8FGGqdZggAu9opvQ
	(envelope-from <netdev+bounces-292601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:06:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B405EF37B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3AB3225905
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB4389DFF;
	Thu, 28 May 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO/Bn/wy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30F38A73B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958296; cv=fail; b=cEspMyPTJiRgLbncC3vq0iUelT8MUt3/1uOG4qCgP+X7lSq0PhKRvhV4UmnSvNC6xOF6AIJNJnFZKG+6rFpIpHwKfzgz16EXeFegIsVrlXSdP0CrIC+pu4llHNQNLUlDkTqaukHPkgUe9hawYBd3ouTncoZ51UW1dc8QcWyMm88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958296; c=relaxed/simple;
	bh=oD+T5HnnSLSyJ7HOfe271nAbR2ReN+KfWbmA9gAbtos=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o3booc7uMmz2eJ0BNcyz4+TndjTeuXWMXC78QpogQE7D7P1fZp3iDT5oYSI72MBVtklfUYiNdq9IFvCMJegdcSDIMcvip53L1DIJVsH/W8S6cEc0sG3YmccIKyeo2MMHIANy8awcT49bfnYj+4Q7SyQnjX9QS61DrSaTag3FG2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO/Bn/wy; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958295; x=1811494295;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oD+T5HnnSLSyJ7HOfe271nAbR2ReN+KfWbmA9gAbtos=;
  b=gO/Bn/wyn9meBjdC/LdGuzd0vWvuRV8smpIuWLhnBesAgq0OHhJH+LV0
   bYFqwcZvx0Cu7fymjUdXkM8HHO89qBGBXV9mCBKivM5KYdnsLixuqiEII
   3Z9Pr25gonDPfZg0LVXr2NZ2G83hs/rbQSz9sNUG+EQGR4hjHrGmNoKmW
   WmzyfN6p1goVje+6/Sdd66JVz6b07GWp98esNJuafLsujsdl02U7Yl/fJ
   nB/WHDK03Dk338vM37DhEBNLZ1RiGPEACUPEg5+xZsnlStG25JGQoALNI
   qG8Z/UdBOrJ2cZlXaW7rJJuMnsUdNEVl/RYDxD3IVbbgteP2dAljr3hrB
   w==;
X-CSE-ConnectionGUID: WPWhDW6CTH6U1olZlSFj2Q==
X-CSE-MsgGUID: ZaelJtRVR2yvorJPBz5zzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84423460"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="84423460"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:34 -0700
X-CSE-ConnectionGUID: eNydyUWkSQSw9/7f8xkyZA==
X-CSE-MsgGUID: lPDe9VVpT0K4lrEoiYN/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="236137730"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:51:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 01:51:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHcG3YPPIBntLjkRHguyaTaI8OJRzKZeUPmYAcAYvs2BkdQrmNXnEY2HA7JJOm0oLNur6ohX/jz8/uY/tayH04gKlzB3Q2NfEyUw5npkPhdgID3TyZJpNA8AFV1N7kasXk8ysLHsbWybxu+cDeO6dnhkTyq5sEBWsnw5/e3RvDVviygT1KI0D+QPbWoKvg5hQy/dAYXPbwRWoszCSyuKJV+/tefpHr5PXPU3okEzQfSJGbHFlkpihxf1ShuH99RMFpmzVuHMlGMy0wXwlR8euhk4irBbmfy5XBs+5s19FWvw/3XDSnkn0ICM7hv3la5WsTP2YJNeuPhIiKLta5YAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfTccvaTOvXZQ/P2UUBrlqUQiLDWsXR49vFZ5tSeDkI=;
 b=DTIKdZB3jOJnyyCv8lV51haK3bAGyhxiVK+eeHBln91mob9L6xV4nz5Gd/wVHwOLV6xRqfHomMBOOx2YOU4rPJ2SYWJL+Yo/UTTgMEvU6QEpE5uzGtvBFK/C0Med3YAqLjr53xjL63SLSfF6EH9ZfNfEkB5+FcvSGLDpKiDGDJsSzg+yu7VkRq5s1BBWSK8SRDRz52x3uzMVhCUbIn8Aj/urQJWVcgIcFhKR/WilKrcWBJ/MORf5++AHKr8xFIHQ9MFL9FnMEK8GZG4HXNBwG2c7g3aQK1u58IKuYU8yu0jD3917xg51yiJOhf7ovMj84zVbPto3Vcg1z3KLPxwaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:51:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:51:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "willemb@google.com"
	<willemb@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability for
 set device clock time
Thread-Topic: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability for
 set device clock time
Thread-Index: AQHc3xvFc86iO82i6UKcRa59LU29H7YjQBRg
Date: Thu, 28 May 2026 08:51:29 +0000
Message-ID: <IA3PR11MB8986551646265A2276E0F127E5092@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260508185123.2422760-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260508185123.2422760-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7104:EE_
x-ms-office365-filtering-correlation-id: ee2af9b9-0cd5-4cbc-c713-08debc964f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021|6133799003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: iTAIVws1dlNzfgC1M9cZ3soknAI0cBzSn1wd30y3GJi5cexGKdfxKfivqmvNYA9Tr6BbqeyIr05wMFGnoP4OyZEMZRucmxSDyDXxSg4BpyU+1wxBjK1n/sKrNLIQn+jJcxl73SmG8zcqkNixPtZ/uF06UL+91u3Vt+XMo1EKzrMWFAyixy5TdwHWPdm0CRU5s7lEJVabd9w53CMK+M+NYp3lCKkpKDZjP3Vi9whDmKWD9uoTGHx/vmFy87sLQ2PoSJfW2WUYBhv/3hgiDnyDYToCTJsvimsksvHG3UcnnP3cP+jo4LtdSton96YBGbs/dT4SeoISyoyAJjfOrXgWV31d6tWH104plQlpzBVMWJ/Tn/RT9uRu2R9MebQaZm7urW3tD+pLhzVsMRneXZJwqlQppTH8Gw7FtEEy5xsoB+uSR9ovy64gOONIEXNrpXc8j+XCkSF0WjcyFkXFOFRPBOZVwImm6n5Ob1/Lj2rjXKM3EdxklrAkvvxxL6ECdwDxXA4CCRQBO8HhHaXY9rGg+Gj8+cl4Gk4EeGQjWtUghtuSWIXT14iVCKL9xFLVu4aHMsr4P67oQSknFPIaF/c83kor+WEsEIpW/a5PDN7LPWzBrGVbJWkKuob1LDxsk3vxyukQ0KaMQkkW7//+HHem7b5rzax6fNgSKPOQk6WRmrU8PRPdghcMqe7XWy8Sl4WtRXJ2uaywjIFDaXBDCC6K9rHsoFw9w80hvvcJ1BF58VSJfOgav1fUsWt3cgI7+Ded0m3ZZJ+dmX/VQW4Agz5csQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WV8ZiLof7Y5SbrFxBIvtA7hgDeORy9kzwgVr0Ht17ryVQXk8pqWrUtn8zI6Z?=
 =?us-ascii?Q?TY1qDIymA/T/pyz7LmOFh6BCczAl4gKbVFw1FiLB1eRRj7Gy01/dhaqC/+Hx?=
 =?us-ascii?Q?jzf3MPlftxpEMIA/JqpOc7QgU5yWYDUFlktiSP9+5TyXvhBnD4zH4qkCCOPT?=
 =?us-ascii?Q?YxzkVB0nut8p1L8NzI7hjdmyj1eZJgk3XP8IjYIEz4LHduUG/Oo/ijBhhijG?=
 =?us-ascii?Q?5I/FvtSYkohegg5eMH/OVfxL1/pBAK65pfPh22ha//jbfrTrNyazkuDNDW/g?=
 =?us-ascii?Q?rzsJV1yMh0xZ+m6KvRrOBnmJcJFUYTWEvUtvY/errcIrUiomlIwObgyFajtK?=
 =?us-ascii?Q?FCYjBuFQo8DeBLMildVaw4v4lMWkBAMQ87hV/qAV0zNDn+9qgkwmrVmzxwau?=
 =?us-ascii?Q?Jr7aGFdPf+8riPS9mmy/vj8o1D5ueD6IQhpFuRxd/+/LOuBV2XOwkvrANnWK?=
 =?us-ascii?Q?lglYCJ4I3bmzG/pZKOYN7Q62ucyGSxwR3cdp04K+dPVHcL/woedXDkOmvNVq?=
 =?us-ascii?Q?JoOcUBWzN04J1UXudaDPqT7zWc3a29j3ti5PVVhqNTyCq7I94Y66ezuwHbGB?=
 =?us-ascii?Q?XiNmlJk94iaI9nQIH6WoKinhoSrzL+wswfh1QBS//GZEN5+xLgxUVJ6GpLxh?=
 =?us-ascii?Q?Zym39fpJEvxn9XLLWUfvUE/J4YJOYouv4favGVs055sl3JB/gJqShsx22quS?=
 =?us-ascii?Q?XotzwpEZJ7ue0BMkA17zahjnPFrMiw9PQbYLvdvrYpoiawWCRfsQyqaTUhf/?=
 =?us-ascii?Q?rQnxd6AIn/WWrkLU00g12jHi1aqvsNT3Z3sKyX60GK3HbOyXOBInX8ZEsb9c?=
 =?us-ascii?Q?25BGyNZU6MjBZbu9NdTMayLRfoc3eEL4dWmKFHjU+9ZJIWr6saiJLKdPbOei?=
 =?us-ascii?Q?Wky85+gtSqOSq2jawSxHII5pTfhU/PtSZp1sQQg08whVsk2qijCTvI3KNWnC?=
 =?us-ascii?Q?d0YMWwgXvQ6DcvRCLotUWtk/CMVpI2YHRt0iacbjODQ6y7PYUvt3Q2AsH+ki?=
 =?us-ascii?Q?1MGisoY+O3a+llEaqidtEVr5Rz4vIoBZoSqUn/RdVESI7+vJ2IvkUZa2W3F/?=
 =?us-ascii?Q?F+6C9zOZQPOva8lDWNTLPUtUEmMuWsxM8SWZXuQGcgN3S7XEW0Otcob+LLeB?=
 =?us-ascii?Q?BxxaTyeLEmBBUadYPPkF4LhAAWk90UbYomKmb9xAFUX34v40hsHmBVdyYsJM?=
 =?us-ascii?Q?VzxbzPwWrYcLbnycNyMd47kw3bK1KoTur674qfDzYZLPmW2URx7PLKnC+YzA?=
 =?us-ascii?Q?SbhMRIeyBt+ADND8u0qZJtwOC3kqPFpEVWz5i01B7g8+a8ByWxnpSkkurPuP?=
 =?us-ascii?Q?bR7jWl3dAURz4bVZlMDdx6KVPrBHDMV+PDdraHf/nTFDWHTWkz7KzWlEqL+n?=
 =?us-ascii?Q?YbYaz5r81gVBkjxzceUjvctznktWgSnpEstPgFD/McxqS8eeOo733BjbCUgp?=
 =?us-ascii?Q?1Oif9STXlAzC6L3xDjiM5abLgMnS11lH0lpfOEf5lndesShEnH3PSq1mAOGr?=
 =?us-ascii?Q?Yn8NCbUV3xE3ZocCAhXzZSHIsFSB371Xb2azS5+rlXo+sG4dTXVN3lEV5Wez?=
 =?us-ascii?Q?Z9wePBaDc7xMfiClOrkf0Eq3hXexb8S1yk7TRjeftQ9BhmchpKQPbzvqCEAz?=
 =?us-ascii?Q?LYWMUJWZu9VI6wOtjdS24FnX3KMkKC4folW1nk/pAHLpeZCYVJOY3HUhBmaC?=
 =?us-ascii?Q?77dvEQIIBa8+jcprXm7upt5d87BuQRyRRbSSQrsemR6MCJlJmdYokMSkfrl5?=
 =?us-ascii?Q?FFHHe4fxLDzpAw0BQo6nr8+6HRlZPHA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L4xbLSLDv4IP49Ocd9LY9gkGo1n/NZj8/zj7QRXjgH3jtJ4PSjGL5d+vVcd61uv9hcMie8ZlIuITJd1tOqk/wh0EqPyYX9kZl41x6YuB18/NKsvg6diVX/qYOXelYiYrLzTycujTYhIBO93zSjKwAFwu+wW6Qkjz/Qn4/6BDg0tCr2UklZFfKVugqt65fC6Xql/iVKfIxGC2gp5xE6b2McTxJw/QxDImwucAkJlEqkkRCFSutVkiaFyra8c00xq3dBfuHJKY6DZocmWZWFY3886z/amXxHtRma7af42iU9UZlt/IIq4dVerItF6a2m9f0QgKJuq7nrnxhg7WiE0slQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2af9b9-0cd5-4cbc-c713-08debc964f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:51:29.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5e1lltB0aEREXgQc0ugNS0rrSVPrCXZKRN+XhAw/hEZbIT3g9rNyVNjh7XuUnIVVO13qy4OxsOSJT/2tpRY7xvZowjHNsLuK/1FkMe83Vi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292601-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D8B405EF37B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari via Intel-wired-lan
> Sent: Friday, May 8, 2026 8:46 PM
> To: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Keller, Jacob
> E <jacob.e.keller@intel.com>; Olech, Milena <milena.olech@intel.com>;
> willemb@google.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org;
> horms@kernel.org; intel-wired-lan@lists.osuosl.org
> Cc: alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability
> for set device clock time
>=20
> The current code incorrectly uses
> VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME
> for both direct and mailbox capabilities, causing mailbox-only support
> to be ignored and potentially reporting IDPF_PTP_NONE.
>=20
> Fixes: d5dba8f7206da ("idpf: add PTP clock configuration")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> I did not hit a runtime failure directly, but this logic is
> inconsistent with the capability definitions.
> ---
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> index eec91c4f0a75..3295e2f1db9c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -51,7 +51,7 @@ void idpf_ptp_get_features_access(const struct
> idpf_adapter *adapter)
>=20
>  	/* Set the device clock time */
>  	direct =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
> -	mailbox =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
> +	mailbox =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
>  	ptp->set_dev_clk_time_access =3D idpf_ptp_get_access(adapter,
>  							   direct,
>  							   mailbox);
> --
> 2.50.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

