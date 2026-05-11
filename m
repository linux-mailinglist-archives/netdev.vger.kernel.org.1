Return-Path: <netdev+bounces-286579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNtKIdqkAWrShAEAu9opvQ
	(envelope-from <netdev+bounces-286579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:43:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783F50B311
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E72CF300C305
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA73C061D;
	Mon, 11 May 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwEQoTyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A33BF685
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492617; cv=fail; b=O+5npRp/tHKjyCcpErniDLt0fAefBWjQSeoQVYVm3Vt1rvlQFdBN9xycqEmLmPqgJ25bWWEOvDEsuJAQtfl86V9gOSy23rq0HHjjYeK52GlrJ26HLyuGxUu/766hZP8KYVviK92jJHMrkoTUflex2RQp19Jxd7IkrpdQmayUL38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492617; c=relaxed/simple;
	bh=J/SVNE687zyPHbTfckMcXOUZG07r30ceNw/HoLvjWSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShzqLzbFZ2SZU6L5MouMhRV28Ajzq3S22UAnyope4AdlPXuaV6I/CUKdLpFKzW/ckAPrdQ1nYTmnDdnCa77UCaoR2buvhcG3nAYs7dBBfqt3xFTL0rKkTWln/45AK7hI0vQnfZSbnMAt7jRCIzYslEGKToWMw1Zvud6+GLY58VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwEQoTyJ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778492616; x=1810028616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/SVNE687zyPHbTfckMcXOUZG07r30ceNw/HoLvjWSQ=;
  b=ZwEQoTyJwYFxlK2YRmYa7+WxiL0a374V8Gy62Hn4rNSZv8cH4JwTrcvq
   YtYk6MQCUCsTALKkBSJK0cpEH3C3mn0B/yekyqMuhW6QqAdIwcnskI7qo
   Uj2fJUYc90KcevW05fDGXm9zOsISb4kQ4M1nyad/OGiILcohgQ0JGs9ZI
   FVVkQl9/9yrSOzIILxFfl51w1w/xT1flGpZwTFRANKlJo73/qD5REepPS
   TJmdT0fVQaKI5KsvEVimYcqsUYs0mluy88AF6Gdb4TlKi3V680fASKNIn
   b+2arE8pnFotAWcvy6jsreSFiwfRYMjv8uOQmYAUHC7xV7NKkhG3HnvDi
   w==;
X-CSE-ConnectionGUID: n1D4xTJJRXOWJ6tL8HKDQQ==
X-CSE-MsgGUID: vH2GlflZSreEFCC36hYnOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79396934"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79396934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:43:36 -0700
X-CSE-ConnectionGUID: f0xVTODqSsyJzvjpIBbr/Q==
X-CSE-MsgGUID: vLDvXzTHQR2ErVwuDAgDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="234343498"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:43:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:43:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 02:43:35 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N98bFPFoWEKR761MI4lBop2fQmKvUDIPg8nd7VLwpfGesIGz1liclM8hVqJJlG7K1eir+lacvQTZpdXP9yhkGYcBMGJhmFW3jDVd6OcgonUPwrNuUTA4bgTn4rWQ2K4zKFlPxUSS7Hjwe4HNmw4BX3TOCCsaC/uGCdSFJYcJ1FJ97zw4DnDMKztc5U6BrAeT+VXbRWSqT7msH5OifMnJtgcgu/xR7HYIfe4D+OzbKN6wgMWTl+6qRl2huBobJJM9go9v77pmm1dO1CXzawOmS6WrM5Bt7lz0vi+hRbvz8pkiOI61C7uzgzSK6p6IAcrcy1jgh8hB4kJkcyqsjMXRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uzzjpo98UdTLtLKem2v1XSUXvcgki93asasvUErEXo=;
 b=oLfxf67cfL9jpR7sd8+G1J247LzY1tdPMpa7NyYvpik7jFy+nnvGjwHXYhJwmB9cpYRTJtLNxP8W2sUEelbKnL6s+5T4mYtbS59+cKNaVBAQa5Kqq7wMJDTECXBIHJda0OMZCzKrFIWhPiukQWpN9YdiCFrpKYFBp3wrC16BN4LfnWjlzyJcj2m51FSzzuJw/XfErlhqfVpR38i7P3Y0F85jt9tST1UXbLV43oe6Y3G5IBKzO3NV6WTCf0mGJAYMqXTR3sIghziIiRY/bgjX7uriXYarf+hU+wijArSuf39c3EX4LnlSvo0Rj0lgCmv3GsHEj+pqbbgOZ0gQNPKBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SJ5PPF0FD67B0BC.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:43:33 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::62a:1a7c:6360:a580]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::62a:1a7c:6360:a580%8]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:43:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [PATCH iwl-next] ice: add rx timestamp tracepoint for debugging
Thread-Topic: [PATCH iwl-next] ice: add rx timestamp tracepoint for debugging
Thread-Index: AQHc4Rivut9yvXud+UG4BtGc8H/HybYIkwFQ
Date: Mon, 11 May 2026 09:43:32 +0000
Message-ID: <DS4PPF7551E65528F616E70541CFBB3679BE5382@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260511073657.1073780-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260511073657.1073780-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SJ5PPF0FD67B0BC:EE_
x-ms-office365-filtering-correlation-id: bdc110b0-785a-4cca-c7a4-08deaf41c406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: LwqKZXL1mCbvNDdQo4oWMAjrbbwTBc95j1TZZiGy8DHbz6mUt60bQYzNH3JO73JfxM+9e26S2Sxin+xqjcMgYc7bzPiij7+31BD7+7z9Ki4mxSuJ80jVhoiQeFXD3fzITYT0p8T8Ls/NtOFavfyvcUNUAKmHUMmeNVsIMm2p43MlnonIHQp7RBHt53GO/mcqo6yd2FJaSCuIPcbI/it+x/ByzQNEETmpiLHL4FobBXUTvkoT6PgIn0x9bFoY4RHzjR/iMnLOEEfk9aRhGZbQp+r4NSu0L6Xiu4tawgW06y74p9S5L9wthfK7kHmkX1mmDpHDRYtWY484UU66neBSWyx6I0a1galXweWoJpNRIbuXCgZSnkvZrYRbBRPANwtkWOb/WTSZyFpTcpFNxnTmmytgI6+DpPE/mZXy2OcQk7lv7/FAuSDS2M8mtL0dPEXHYXXVB4Fg+DPbqfnd/WAb0MdtoexLrg8S4LLSk49Z8ci2hTmoISBeMoK0wzu4VhTqMAORv8VjVUKwgaBADjqulZkcNGTnL/HZ9RVZ7LcBUW+h7ORTNWY0gBAQdeuKC7ycrjDK24n+Y/2/OlapTQassAolDhZ4tIoaSac3cnAZM43IiSQBdnBxNvvVhTn6gvl9wCjhej+LvQjvqLjESnvFIizRliGD8JC2e1vghYbgMJ/pEiR9My/tgBq/Hs8pTV8yQtCVaX4yEQFzT+P8Pfu9BE3i4oaQcYA6FyupsxxuLK72hjptzuzTVhGym8H6iNOi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hI+Cz5hxHfOY/H3lXYyyEQijW6ERaIbnwqsKKOddYBYwaUq42V91b3CQQt7b?=
 =?us-ascii?Q?Ouf/udz5h3dHK03aNP6cVvteb0KjmkAwOQjl/3ESSbDJY6ImNZpS/DJt37PL?=
 =?us-ascii?Q?L3DXRtZ77C3tsvVxXZScSYLhgR0h91/W5O3O3P2LJZYo7Iiktv71omSjQf4y?=
 =?us-ascii?Q?0zaCdFF6pT2c0fKIjHRDVuN6WgIBbXTu5+HN0B6q70lD0oTfKgLMwxoYVTkl?=
 =?us-ascii?Q?1ddV2gV+PyWYy+RiS/sTGEgRPhB5lyNhzRg17zAww3kiAx0HQ9qx3oUCdolx?=
 =?us-ascii?Q?c3SXT/iFyALXukM8uE+em/v+dyGZsdbhtWcIWqOCzvAZ7UMa6rNgQvw6MFIf?=
 =?us-ascii?Q?ydjAIJLRVr/YNKEzomkgqG1vVmy7Mh+ByOkVu9UmfQrtH0VKmeAucV8i3hcx?=
 =?us-ascii?Q?nzNmmFExpUZGLls6Pu5azT9jmz+wlnzNvnIuzlgQ1/OtuI9YJ0I7wgdoNRoT?=
 =?us-ascii?Q?En7H0SO3bh+FK9e35omjRhC3fPAHxp7UB10XCsUCvuRJpJvNxnYp/OvnnsF7?=
 =?us-ascii?Q?PimcqiTni+OB4sX9vx1gWWkJrm04Vn08v+yw9VvYiozo1OKMwkIVOhtB05Re?=
 =?us-ascii?Q?KuuTM/yi0sEvG0Vd8cJs1MJ878SnqVYXgx5zwKnYET3kZIUm35hMQA+Cx4R9?=
 =?us-ascii?Q?7upDltDgUExAMiTKaBdD5GSJYoEyccoGwzP4O0E0d2b7/usTB/ZjU1ZjexIr?=
 =?us-ascii?Q?rp4ZWAZp3EoYQIHZR77rBQly0DwXen4WQ9XR5EFUylG8nfkPnW0aHTVDa9+o?=
 =?us-ascii?Q?NXQF18CknbbRIxukH2C5YZxcWc4tMIyYKoBdD9Bup/MbR3exfAwNSS3Q17ez?=
 =?us-ascii?Q?cQo3u0fYxENFI/sPIZZRfM27HHF3p2VteyFWR58COjLjN+Qcj9a4L59rd17B?=
 =?us-ascii?Q?cAZIf+TY0pTr5Jqt/QothVGl8PV7NUfsaVBn2XN92CL5yAAC5pqFpneeb6Hy?=
 =?us-ascii?Q?sck3hYjGwaIzCh8PagZd9oPa8uX3ReK46FeAb4i7ccDKnAxBFuTspFtR5OnT?=
 =?us-ascii?Q?aefMkXliQfJF4NreqHwgZsTJCr8snfmhfgvhl9gsrC4AN79hK32u7uEB5fUH?=
 =?us-ascii?Q?q0X9UlHu33pUtECciFpUSWlCIZixxBDbTmoyVJ8Lrgb/HEbfKUAD3pEvYPCj?=
 =?us-ascii?Q?hY/OgXYZf63EzxeyEqwD8bDv4a4HJ0jDVvzevuJJ+G5GChZyixpbgPoO26PP?=
 =?us-ascii?Q?GoYr8up+k1MhM/9kmTnc+zkfbeH3Wu2N6QQ4scUTRncjVCuYo7xW2B2x6yfg?=
 =?us-ascii?Q?h8XRZWLYEPzeZGGCg6rq95ncmy8plRZCP7RN53gqQ1wwwdL9j8zBe4iWeXq3?=
 =?us-ascii?Q?W3JzWxuue9ZNTgzKN4Yg3DvKRxzgND3AWNbxNPAYYe/f+n6tQqUgj+T6PH3B?=
 =?us-ascii?Q?6gJ8T1m3AaYSEnw9wBhHg2CxkQSkVjoccTmseukfsPFjBUVEJ9nJLEBl8+js?=
 =?us-ascii?Q?NdFC7BipMJCxJS4PBQ8TZUT9ISyXjfPv/oRgt9gL6CPAScqNXMjTFSPYqzru?=
 =?us-ascii?Q?qG9JonVbF7XKQ5PSuRRt+xXChnt6+kdDr8xDDg1BaBJ+QddWFM7JKUkvnVi2?=
 =?us-ascii?Q?Pr5r6KnBCoUjhap1Sc+xoehy9cEryZsPlCeAsMt9i/TFA7UsT3ksdQWS9IUr?=
 =?us-ascii?Q?YEBICVgKsUnOc6jAANryerkO4NU/OCThO6NK/ksoteRoGopoX1diSb+eJrfh?=
 =?us-ascii?Q?0BB6pfw4NItkevHZ6e59BXP5zQd48ZL4LWDa5ia4kh4qDZNW6U7knCE2bYOl?=
 =?us-ascii?Q?dmFuIuk2EU8BezTv7+m3vTSqhUhG4Nw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bciQPIXopcMVi7i4qhQPnH9EQ6paB+o8kzckT3ndtkePh5DyJaTWLyfmwilLhOI8kMxiQ6TyN3j9UAnw7OEZsX41UKz/puHuTEWPwIy6u7rMx0DbG24x6EOuJgCTL/oteS8ToXCImtCPfiiwnNSIY6Rlr12G5+diyuMFWNnHrCgDcRfiC0Bl5wDv5ajnYlaiDMau6W6NRLQCRy5iTfP/9zRPCIlN1Z87D8zgRZbe3eTw4nJTQ5wYeAXEywgBx0pJv9VDV4ZU8QkVtKt7zPZTocnD7bsoIhv/6kwjT2dpaWBD4Z/+SDc6imx3G/BqALCzth+th5EFjWDQ1eRFSo2xbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc110b0-785a-4cca-c7a4-08deaf41c406
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 09:43:32.9489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BA5uakEwkNomh1koOypPvA05ZPFcQu/j2TZ6mLUX9+MN02k/EzhOQUdZqgXrQ8EyfqSN/gYqulxoFQCFXdWi67XRvZCk8do+IIy0K49bp3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0FD67B0BC
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4783F50B311
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286579-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,DS4PPF7551E6552.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Sent: Monday, May 11, 2026 9:37 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [PATCH iwl-next] ice: add rx timestamp tracepoint for
> debugging
>=20
> Add ice_rx_hwtstamp trace event to help debug PTP rx timestamp issues.
> The trace captures cached_time, ts_high, and the extended ts_ns value
> in ice_ptp_get_rx_hwts().
>=20
> Enable with:
> echo 1 > /sys/kernel/debug/tracing/events/ice/ice_rx_hwtstamp/enable
> cat /sys/kernel/debug/tracing/trace_pipe
>=20
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c   |  2 ++
>  drivers/net/ethernet/intel/ice/ice_trace.h | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 691f05c62d4e..07e621813ff5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2333,6 +2333,8 @@ u64 ice_ptp_get_rx_hwts(const union
> ice_32b_rx_flex_desc *rx_desc,
>  	ts_high =3D le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
>  	ts_ns =3D ice_ptp_extend_32b_ts(cached_time, ts_high);
>=20
> +	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
> +
>  	return ts_ns;
>  }
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h
> b/drivers/net/ethernet/intel/ice/ice_trace.h
> index 4f35ef8d6b29..3cb8c6ea03cf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_trace.h
> +++ b/drivers/net/ethernet/intel/ice/ice_trace.h
> @@ -241,6 +241,24 @@ DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_req);
>  DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_done);
>  DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_complete);
>=20
> +/* Trace event for Rx timestamp */
> +TRACE_EVENT(ice_rx_hwtstamp,
> +	    TP_PROTO(u64 cached_time, u32 ts_high, u64 ts_ns),
> +
> +	    TP_ARGS(cached_time, ts_high, ts_ns),
> +
> +	    TP_STRUCT__entry(__field(u64, cached_time)
> +			     __field(u32, ts_high)
> +			     __field(u64, ts_ns)),
> +
> +	    TP_fast_assign(__entry->cached_time =3D cached_time;
> +			   __entry->ts_high =3D ts_high;
> +			   __entry->ts_ns =3D ts_ns;),
> +
> +	    TP_printk("cached_time=3D%llu ts_high=3D%u ts_ns=3D%llu",
> +		      __entry->cached_time, __entry->ts_high, __entry-
> >ts_ns) );
> +
>  DECLARE_EVENT_CLASS(ice_esw_br_fdb_template,
>  		    TP_PROTO(struct ice_esw_br_fdb_entry *fdb),
>  		    TP_ARGS(fdb),
>=20
> base-commit: 5c0d2ac5900d689d422a31cd45073175150c0a39
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

