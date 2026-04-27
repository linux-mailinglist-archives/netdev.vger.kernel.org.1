Return-Path: <netdev+bounces-281385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O0KCN1z72kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:34:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9EF474715
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 317C6300100F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531292D3A7B;
	Mon, 27 Apr 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COrtQwhe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864202DF136;
	Mon, 27 Apr 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300434; cv=fail; b=pXYiFxuskQBo6smx4wK1UbrUGLf7Bdw97nn5WQ786NApAPjgASkBOFXGhG6K2SPn0WzvjYMgiuhtOrAyQ7SgT6rjEfcVlyrgY9CP+MWbd6FBaJGEqEyOzOiaQf7M+eyxhsXg3BzW8uSD/4UHaM4UQjqnLGPD6FYUN0ownP77vc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300434; c=relaxed/simple;
	bh=9R2rVuaICb9OrItwIKVun/5OCf6ejJIb4IQdZKhDuJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnZv7qmEb3bizViBpTvME10cAvpSjNDAutPInmKoKsBeRE/nHrwDseer8wTwU+fTdyXw54l/UvCW20Lq2t5PrJYDG8dMH/nAEBbRYgUURj8sqNGi/Je8XyWTEKcTDpSuLt5q9Vc1wV9SOgzX+1vtNFPwRx1Gy/U8G3xxKgmXmoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COrtQwhe; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777300432; x=1808836432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9R2rVuaICb9OrItwIKVun/5OCf6ejJIb4IQdZKhDuJo=;
  b=COrtQwheXpRJT7FZzIYgItAgdvp7H9k4kMgT+W3PeSqlDKSUlCsMMe/2
   Bdny4zHSXPpKXdh8KFWQqJDVxblVVX+6rI2u/TW+w5pwpps6J71lBUYUK
   LOLxZr15Uk6HP2HL4RUfI6w+vRRAtUl8eDd7+7p9sh/DXkhMf967TbeBt
   zQQScYJQ5dV2g6UDEy3zXg4nBpc3IZ+efXumc4vyytR5+wFojln4W5P8m
   wTsrNxvWpBoeTJ/DBMM+BHxyOdKkNYtfIlLCkOo6D0yqDS081RnvwUHwv
   KtdVQPdwxaHXIjgwRvd3rDPNMYttDcyp8hRecCGgQtkwc0zPgBDeldgC7
   w==;
X-CSE-ConnectionGUID: 6k0ez73iS160QzsgmT3cug==
X-CSE-MsgGUID: bdhzbx7xRTy8Z+pQ7onQhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100846802"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="100846802"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:33:51 -0700
X-CSE-ConnectionGUID: J/MIKb2jQoqYCTY54OXUNA==
X-CSE-MsgGUID: iXhZOMTPSh+6zfZp4bOuyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="237982741"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:33:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 07:33:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 07:33:50 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 07:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnj01lwD94Uz8wJIt1dCkuCmwIQHAxXRQJl4wfp2J26k2Q2FO4bG2rIaiUi90a5uXaAuHLocPDX/xNZdTfQcthpnRLLqyVK6gqNdHsEVM4jTs9GK6VImlSBqfR4xwY7FMFohvkF9XT2LAFlbCfV4ysO2d5ciTTSIxLf8eR1FbABc3FjZNKdctF+lHJu19VB5KCctlbIG/uSIgZCPlzt9c0end571Kmyf8viIAo48UWWL58u+I1Dbcbzujs81Qp7ojhM5lXhgSZyHjY7YTPZkSEh77vlfNOsITbfzFGVgMv1mGDWOg39nFNQWKpLS8/lJ0rMzjMgFpnE1yCMt1Yl9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBpYO/4/x+3OsW8k4BstOHQ4aul5+3xhLlXULAL5ZyE=;
 b=dF1oaH2HmF8fGDxnlAw8srmJ3eOQWKaGefyWAqXh8QDAtUwttzeyze5L3QRIfe5aLWOY3K1u6k0YV606R/gNNfxzQp6Sy2+tfyoS5w8FQrSSqsYc1YwP1KkiBRqlxEbgaklqcTqEJRt2pVJi8bPWi63pVsCmezKY9YcqudNSE090zWei82cvSG3jBfIxQHt7Exl77Q+cUteYjfdJMKAa+HaSsY0kQNtfuAK0k1SsFH93nz9dhJE4cXELGBq67cGk2B391CassI4SgVX0TJ3lQ6Rl2gOfnP0n++/YjTFSArw8pXkoFLGgKXBxdA2pjvllkTlKiIOlr+aegZYku+Nwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 14:33:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 14:33:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"Vecera, Ivan" <ivecera@redhat.com>, "Schmidt, Michal" <mschmidt@redhat.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Rinitha, SX"
	<sx.rinitha@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net v7 3/3] ice: add dpll peer notification for paired
 SMA and U.FL pins
Thread-Topic: [PATCH iwl-net v7 3/3] ice: add dpll peer notification for
 paired SMA and U.FL pins
Thread-Index: AQHcznrcFpwjIZU3fkew+HsbL7CrI7XzCJcA
Date: Mon, 27 Apr 2026 14:33:36 +0000
Message-ID: <IA3PR11MB89868A62A4D45B49F64CE3CFE5362@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260417145907.696307-1-poros@redhat.com>
 <20260417145907.696307-4-poros@redhat.com>
In-Reply-To: <20260417145907.696307-4-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB6995:EE_
x-ms-office365-filtering-correlation-id: 2b330814-b419-4628-de17-08dea469f798
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9dvqlvkORrHQX3sCPfaacIXUEQUmVPBfdbGpY55PyOQH091dKKcsouC0+4ypDM8yA8uhegvX2MQg8HlaSEgrtMYgpYI56JGbfDlmqcxi3wAHHfVmPZt2FLnFA+lrMtFqG9YkqZqC749F3OzwZ+EQRe3dBIVkTpAk8iRgHvIx2BWnpTISGXphFJlLnR6homcUWbDUnuixksCp8W5ZWatAVFRFp4RJ41HqkLGd0jEZhBDw9fP11kLn/eD/r0kE+AuagHVR5eMc3Gy8+s4C/GvWnqTV6phh0/4qvJXbuzEBBtGUaN7Jkrym2GLy10nqRnHC9zcaXZXnNuvytskl28OGEvEJblE8+ipNiRxLB4599TGKT56BlALe5CmlZ4sjklTKeGfgV5etusvJ8H/BL+J0LB3Jq5EOE2J3nnD3/Ut7DQZZCA2UbCk0SEsAPzSvKqknX5S34W1PzTykcMYXopr8TfDy7OBRfnkYC7VkiUEdL4/rbvsM7rwDVQ87Fk9PfcbuOxzHv73Dy8zidxs1x29U3Bn+pW4ZHF7fpiiMDmdSLvvH4tEeqv406/014DTduEDyupYhyf9d8sSdLIbc0bfpLGCtoblfxnGxs7a9DNkTcN2Wi9+lQGeezqV7becZtoqBygVcEOVYhwkbIQ3vzEUPMIuKPklkBzIfaGp3H4D53fw5EcEwOLRmDeUsEuxtI0Mb8jYjiOyyaloLbyelC0xMLTdgzKwCbLInvE0j9ut053sxXcOgAxZj6AHCiii3BSjxnIzgPInQ/qt9j+F+wgK5g9GgU/Lol/oj3m4ygNbF9kg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bj7K+bZ2OD8YWFT4zt5K+Cj+pyZieswEwPiuNyMHZ45Cxm2G5YUUpp2ILOOp?=
 =?us-ascii?Q?DTkXeymdpXfAxRd4j4I6O1qWcdT74h9ItKlAExTER36T2uWDLUbWX8gtTLmY?=
 =?us-ascii?Q?xLBBz/S+DN9BZj7b7sfVS2ZMqNTe4jErCk863eP7gwG1yrDJlSMFi2kEV42K?=
 =?us-ascii?Q?M9DYt/uwdY7y53Am3/wQoTQYZA/+uEb151YyNYbpwHwKWDVemgN0d1K3ALS0?=
 =?us-ascii?Q?vFX4VDcEWh4kvg5yhKSmIZDwXw0SANSXkiBzKpxoZzFF6yoJBYFdrnsOygd4?=
 =?us-ascii?Q?3QFXda1E2f+CaPeLRXuIOK2w3EY/lBcevSGPMraA5tNV0hqKQ+VoyXc/a6vp?=
 =?us-ascii?Q?JSDvK/5jf1fdQKUbzYaX5e62kG+kywa5gCHbCF1Fd1M8brVC4vhyGT5ONuow?=
 =?us-ascii?Q?lD9XOaLpNEoQxnldSoLo8clSJzFy5inyPSmUhmHaUMWhpW4RfOkNnDNlAlTV?=
 =?us-ascii?Q?HGvnL3wVCIhBVtoKESKfd7oQ2XBpOan3gcW7VIrYudFOItzfjX7brXfL0TzN?=
 =?us-ascii?Q?Czq/iiVj1M3drya7FFP9ipQkLIoaX6xL+iPkMSwqrx/WYBUOLaukg2fb9Fah?=
 =?us-ascii?Q?GgBviYdNfTeZCsNdqgV4gJhq/O0MF3pSZeRlUERIrUzesxDjKrgJUdDQ+L/q?=
 =?us-ascii?Q?ydfxkwkst8oMh6OwO4vELC/F9I3+DHeUsLAdbNUSBq6Z/XJUZL52/n7XolWC?=
 =?us-ascii?Q?aRaLebYYI14bVzjbvTHaOwu7X2FUkaV93uxrGMBc82Q8tlu23jej/9+2z8Xn?=
 =?us-ascii?Q?b99ywQFa84L62mE+FRS86SXjISONcgaku76Yqd1N0+vlPM+wLHYZivXAfCZB?=
 =?us-ascii?Q?m9JeMpPGMmbMXjCcY7JIRzDQ+TemroGshPYVgwCY0o+FJhxVO08EZtHLFc7X?=
 =?us-ascii?Q?s83IOhhHy2snwEP17m7ezXx7x2yRNO9Zs3yIcBSFJlTKv9l7P81ZJnyv+eOK?=
 =?us-ascii?Q?A0skuLMeXH05pJVTP3czVd7kgK1cE7Kmq9knZ9yVi4XNN07cWdtNKOvVSgsV?=
 =?us-ascii?Q?hl1AZXfgj9mv9mWz1on2iYm1xWhG09IoaUcc6WCQwrXir9VHKbgSjvbJi1Hf?=
 =?us-ascii?Q?MRKPy45qP+2AHfc5ac2eWRCfFzymzOmrAii8/MPcIo0wicbwkTjiM88JSE4T?=
 =?us-ascii?Q?XIUYKhdTgtRFY3xyq1G/uHas1mIchTtuw/WpuYL20eGQ71I3ltqZGeDzPB1B?=
 =?us-ascii?Q?9S+nqiIX359qiFmqxwFPSZtSfu8O41xI4jWUMNtO9srNhYnDFcHDboWkwFv6?=
 =?us-ascii?Q?pEmmE/CJ6L2zgLIFes8dieGB4ULeFQJQuigSYXlziRsbT8OBYVHJgywZPZca?=
 =?us-ascii?Q?q4oxQWQmI1X1PIR51KR6yDUq+j6YB+d0uxFOmKqQCLuHHNRKrnk1xG8jj++W?=
 =?us-ascii?Q?moK1uzaumr03b46twWW4rv0aFXWeFTWhzNdEXas4v3a4eBMt3qJOhQddISVE?=
 =?us-ascii?Q?CbeEDUnrzzIgnDz04oB6S8kbOROmdR2VnGyc6AYR/rDvUvOzqzEdFfl5lOgJ?=
 =?us-ascii?Q?BgMNMUAEg7v/R20pQYgb3M/DxeUHUVmiLdegVlGlAIt/4OHId4bNjcEcTJvx?=
 =?us-ascii?Q?koAMXTmAbpNSfaNF8gJuVf61+GpYGtjKH3QR0ZBevl8+8AOVHlJid82ehqUU?=
 =?us-ascii?Q?rTDnrt2+ObvddM/Oonko7xeKiy7ScmVr/6OSFozl/r569gXEBJtiKonL0M0K?=
 =?us-ascii?Q?kB2wrQRPyfSGyXGkKgjF7lVxXf2dyQegXq/HO3o4Ez/j0y6OqhYKjGWAuRym?=
 =?us-ascii?Q?AYd8kc3SWfpC7V+9ZGj7A6Bt8iYFFa8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tkd/zVTH0p7DgHbXIm3r9sL+GlcTyLKWIjJDdrtBLhzC0ibM8i5OOkb3BZ+Cwd509vj1E7BrQ9EEoFi1WnrZLfTVKywf4WuJ8sqw4tWqVV6B2Im/EbM9B4sTBEI324EBVrCHxLi+TZef8THIvmeFKGmbNqlHEDYAVrRvdiJFQ0XJM+4pHifcGSJgZkNkt8csy/FFwOk+sY2nhB+wadeVIqp70ndleq8s0jVkgQ0642qNWklQqpdwXcsTBL6j+bRz4d2y0z6Gb9JV/o+M+owu3PeIBsSEyHO2ApG5SBP43mZ4keZJGZc8/JIEcGqbR9xZGAH7SQfiu4Y8eXsd6W3WVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b330814-b419-4628-de17-08dea469f798
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 14:33:36.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNqhy4kTa9i5R+G8ZkKutdFXyIyDDLC4nKKEb7lvq0apuwcc8Vjtct8SoyWB0Pyh+rpCfCBqJEkZx3rX1cKUW80974ZaSy7udbaV+805pn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AF9EF474715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281385-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, April 17, 2026 4:59 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; Vadim Fedorenko <vadim.fedorenko@linux.dev>;
> Vecera, Ivan <ivecera@redhat.com>; Schmidt, Michal
> <mschmidt@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Rinitha, SX
> <sx.rinitha@intel.com>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH iwl-net v7 3/3] ice: add dpll peer notification for
> paired SMA and U.FL pins
>=20
> SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
> SMA2/U.FL2).  When one pin's state changes via a PCA9575 GPIO write,
> the paired pin's state also changes, but no notification is sent for
> the peer pin.  Userspace consumers monitoring the peer via dpll
> netlink subscribe never learn about the update.
>=20
> Add ice_dpll_sw_pin_notify_peer() which sends a change notification
> for the paired SW pin.  Call it from ice_dpll_pin_sma_direction_set(),
> ice_dpll_sma_pin_state_set(), and ice_dpll_ufl_pin_state_set() after
> pf->dplls.lock is released.  Use __dpll_pin_change_ntf() because
> dpll_lock is still held by the dpll netlink layer (dpll_pin_pre_doit).
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 32
> +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 11b942b83500fb..be72a076f7a15c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1154,6 +1154,32 @@ ice_dpll_input_state_get(const struct dpll_pin
> *pin, void *pin_priv,
>  				      extack, ICE_DPLL_PIN_TYPE_INPUT);  }
>=20
> +/**
> + * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a
> state
> +change
> + * @d: pointer to dplls struct
> + * @changed: the SW pin that was explicitly changed (already notified
> +by dpll core)
> + *
> + * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1
> +and
> + * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
> + * expander, the paired pin's state may also change.  Send a change
> + * notification for the peer pin so userspace consumers monitoring
> the
> + * peer via dpll netlink learn about the update.
> + *
> + * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock
> is
> + *          released.  Uses __dpll_pin_change_ntf() because dpll_lock
> is
> + *          still held by the dpll netlink layer.
> + */
> +static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
> +					struct ice_dpll_pin *changed)
> +{
> +	struct ice_dpll_pin *peer;
> +
> +	peer =3D (changed >=3D d->sma && changed < d->sma +
> ICE_DPLL_PIN_SW_NUM) ?
> +		&d->ufl[changed->idx] : &d->sma[changed->idx];
> +	if (peer->pin)
> +		__dpll_pin_change_ntf(peer->pin);
> +}
> +
>  /**
>   * ice_dpll_sma_direction_set - set direction of SMA pin
>   * @p: pointer to a pin
> @@ -1344,6 +1370,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin
> *pin, void *pin_priv,
>=20
>  unlock:
>  	mutex_unlock(&pf->dplls.lock);
> +	if (!ret)
> +		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
>=20
>  	return ret;
>  }
> @@ -1462,6 +1490,8 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin
> *pin, void *pin_priv,
>=20
>  unlock:
>  	mutex_unlock(&pf->dplls.lock);
> +	if (!ret)
> +		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
>=20
>  	return ret;
>  }
> @@ -1657,6 +1687,8 @@ ice_dpll_pin_sma_direction_set(const struct
> dpll_pin *pin, void *pin_priv,
>  	mutex_lock(&pf->dplls.lock);
>  	ret =3D ice_dpll_sma_direction_set(p, direction, extack);
>  	mutex_unlock(&pf->dplls.lock);
> +	if (!ret)
> +		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
>=20
>  	return ret;
>  }
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


