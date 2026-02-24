Return-Path: <netdev+bounces-260367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHgIMnhPnWkBOgQAu9opvQ
	(envelope-from <netdev+bounces-260367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:12:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840A182D15
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382AE302D947
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018D31A041;
	Tue, 24 Feb 2026 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVwu6bjM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB033191D4;
	Tue, 24 Feb 2026 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917172; cv=fail; b=JEfWFq36S77r0Gg2fxS7ImbOspTcf1rPMch+lulj43qOyuq7xhADt7iySYms7RyrzLND5p270lh1B3yidr42V7F0TAMsOrn5+fbco/s851en7B0FxCpztL9jemVWaJBElBjpSzC7WFToGOoZaVID1YsmFOy650Hn0jw0dwbe/Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917172; c=relaxed/simple;
	bh=pCsc6MBVOmxquuFVPQJ/zd1EGq61myhX8y1fyKwkIuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6btDVZzGSuootY80VrTPYX9UW80SAb1EgtJqfYBk3IBcicEME1xsjKUej9uNg9Pp9ULU+iBUkVyAn0pZieD0P1HlWXKNEmfRjN7duGjPGoLIGnN6Xn8e9333CFxjfcuLlotU+9SKQOAZH8D9swWKsHmc3mBr9bPPLJBPZZmylc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVwu6bjM; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771917166; x=1803453166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pCsc6MBVOmxquuFVPQJ/zd1EGq61myhX8y1fyKwkIuk=;
  b=VVwu6bjMgtjZXlSRG/c8Epa5i+ad2g9rUoLAq8FkxN8lpWc0cISEGwJD
   gQ+j5FoLWweZDlNixQjWBauRryBsmKgGCRG1LsSiWLSimQOWxb7ud/4z+
   OzRCT/yk+9sXFjsjpuYc+S8Qfhsl7tKCjbveScG388sA4QoFmu4qd7Ppo
   W+DNzAMONAtEtt8k51UUi8X9UhC8k9v7WNCyfUdB9/6E/mEN9SpBH4NV0
   i6I/meHGNztIDJeg0vqIe6DNTrjse+4833CvmiBIC/NRQ9rBtxH4z6dRx
   bjp6Lt3rZRZS1gq4cet0oGFiLu4OXvUcnouan+QQ3Y4zXPVtTrLmyPEbT
   A==;
X-CSE-ConnectionGUID: lFDo7MKMSmO8+jCwutszNg==
X-CSE-MsgGUID: KBjKGjjgSJ2hAW7xZ+Qosw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95540542"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="95540542"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 23:12:44 -0800
X-CSE-ConnectionGUID: 9ezg+ZqcQE2OtPp0c9TZLg==
X-CSE-MsgGUID: LAclfiHYQwGYWmdJ89Ub0w==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 23:12:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 23:12:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 23:12:42 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 23:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMLwiQGPU/ntrCnuFfNLKRU/aiO4F46gpguBufXAjJKCpavrDdoEUp9dRxxAZiDvoK+HV1Bid2YFI4JdgerzigzQzBgRVNTq5LKfziASMZgPmtZcpBYf4vnkS2V8kTEzcnZHhonTMcZJurjxpCMVJ1r2Wdkd8L0FF5tN68JA43Bt4YNdBzDgSd8F2zJKSAOkYkIA1Fc5loTwtyy3WxjzET1bVJQutGYIZAAsKSVbpjaRDavIz+2+bmcJnLTMip3KsKai1Ai5/oKjjqv/cGO53Oa7GkRkiitfECEsTMrldpy41U4QxZ7lEXBItq6vk2CM6PqncoFi2LvCZfq4bPVnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJYm25QmD56kKflWpWSpsc4lrP1JMJJU1ez3LpXPvAY=;
 b=XoBhCviVrmPhRZAy9G3raMyvek87LBNC4EEyxQzFTmRt0MhLEQ34Qk1OYdUY1B2+jQ/nzopR7kb3COHwGTRcV1zVukwTyXNLSTylAhJlEyeLay9DsaVsalmMdpgO8Dl9XPS0FztPwiNO7i5zm5GqcEDk6deo989FQ7p3fB6mqRopPGgZk2M0nuFa/lgj6+PD8UHpjQf85g9ns/lI1RffeixsXNa5oNeT4g4kzudKz5O5fmSwu+jguSsZBv8tgjbEZoHgt7aqAuiIlE2aQElis2HxzU6SE+0wrv9v7fjLXelnHOIzMsbqk0UEcBDZq8uDcxf+77j30PuudD3SEWoOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 07:12:36 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::b351:6cda:caf7:64a]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::b351:6cda:caf7:64a%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:12:36 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Burra, Phani
 R" <phani.r.burra@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add
 bookkeeping support for control queue messages
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add
 bookkeeping support for control queue messages
Thread-Index: AQHcV8kNyg8t6l7GyU6w7LKHdyn3hbWSChCQ
Date: Tue, 24 Feb 2026 07:12:35 +0000
Message-ID: <PH8PR11MB796529491E8E14C116704BDFF774A@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-7-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-7-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|IA1PR11MB7368:EE_
x-ms-office365-filtering-correlation-id: 642f303f-ed24-43fd-e822-08de73741646
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?xpSxlJAOQvVUWpvFmbi/qBjaG9AyEDJqDvTF0RXI3YorFfoSOeDU/CMBGqo/?=
 =?us-ascii?Q?1/ei4dz+S2uCuLDSqJ+/T2camjwuOIzAhehvjgAaMRKiTkoE00WWaWAyIskM?=
 =?us-ascii?Q?HFji/k4qI2u3skFB+3xXtj0N2s0c2UQRkua6XXFQ0MJfx7f5tJpLn3Fmeihr?=
 =?us-ascii?Q?6iNsUvNMvg0v0j+/IZSg1epPP9N18m0NbfzTwAIcyS0E6RSGrHPEuEOxqCvt?=
 =?us-ascii?Q?Q0yA+wJv2v6a6UlGxVLfOrPASiNRniceBNXMet2Z191F9CIpcRGWjf8Sx7h1?=
 =?us-ascii?Q?54Dw3JgQb6IqmnOW6Xa7b6QynXaQ+i9rN0uCw3Ixmyb73KWWRInoay5AyTua?=
 =?us-ascii?Q?7+gAvH4jOxNH/V/YuJk4/oYXBGufm/t4590xTT7CL64l+pojYneA0c0N4jDn?=
 =?us-ascii?Q?+V5UaPjwNZHqxa58bUQ3vAHZl1zGvEkhLtFj8M29u63w8egne6/2WZOPD2WV?=
 =?us-ascii?Q?rLSYEaEvo44MhE1eOusunQzr6SVbXOd/kOcsqRbtKfL7fqLUdKHMuIKKRaXB?=
 =?us-ascii?Q?Fwx8+Zt1iZjBKOLN8IzeTIU+eD8no6e3aNOltL3lXhYSVlMDUUtHTZ6eeNBV?=
 =?us-ascii?Q?EBGaMVDtFRjPGO//fsEzV7fMyBoPe9FJvh4RM9lrlxEsI5yBYpDpEV+0y7/u?=
 =?us-ascii?Q?wr3x+SwaKinJzHu3mQGSTwiyFmSd7aXSeT4nJIV951jG0Eplcsc/RKU352ho?=
 =?us-ascii?Q?QvB7HDhOsnyP4WnPzFq7q0ItKjdNp8GOrC2C6y6sswH+p3DZL1B3YYxtun1Z?=
 =?us-ascii?Q?LTO5v/DQoYIIMOzpCgzB9Gv39W7VPd0yaMr4BZYvjAzi4u0bLJPH9TAoBNB6?=
 =?us-ascii?Q?pfDlxguC1Oc9I0TysWZoNDT0DQu4F29jOSGyi05uhlzsho3MG19okMNwE2wD?=
 =?us-ascii?Q?zBvcCMdRm4sQvH2lFxe4T7qOa4tg+tVnSNfhkHdUgRkQWsrYnIfQ53O7Pjma?=
 =?us-ascii?Q?Gq+mNgYAqYBuCXwtY0K7PnDF7dm54YXj2tgYYVDN3vBVKC/mQ4vByYtWAYvl?=
 =?us-ascii?Q?7AOuNh722VlcV2WkZwDK03XjknmfyunB6vNHKzMSTDjfV4dwAI92XiZbkUZh?=
 =?us-ascii?Q?Atn7TAs082dxxUHlm3xFgkglOwJzaPsEPVBmOjcI9owDMsGKiUy4Z2ShlyNu?=
 =?us-ascii?Q?sK5QXWesDQW2aEOnnDJSnRNxD4NQo56tQum8qDEntXqwVMhmZjXAtSullC7g?=
 =?us-ascii?Q?bQcCwHV6ID6Oc4ys4ZM12OaC+yRpvFm0GKQ/NKX3jqbrbn82ZW6pE+HuAJ5F?=
 =?us-ascii?Q?gUQo9xYou2JAfhF29JFtxlqvAYWhsadPTU5gogQwp3AA9h1cV0NR9CVPBuhR?=
 =?us-ascii?Q?4RYCR4pkiup8wDy3fsrxfQlzyM3ZlPTc3t2v8i+ehEolSLSEzwgKLMlUUeij?=
 =?us-ascii?Q?am2aAhMaEZCyBFIgDchiUUgM5tjk4glprb5isnBjj04e1yQAUqFyKFPy6rg3?=
 =?us-ascii?Q?eZOLmbmy15BSG8T+z2HxA6P9verdGCU2n45QacKAZcYu7xXRGwdLtXqj2b5a?=
 =?us-ascii?Q?tjg4n+HDhU5hDsi35n2On/grrJB4V0cm6AS45MuOjinF27wZbqe+6s5vbtjy?=
 =?us-ascii?Q?MSqKNUXkDfW13sfwDYdZr/hdp9DfiTjMd0Ucpup60pgFZylVrCooj+JmTQeC?=
 =?us-ascii?Q?dLi07XsAeS6c6PSvtY2ZKyM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BtLSOCk+5sAUpSoZN2e2JpY4IDlsQ6J0f07Tf50/SH9XLy3b4PCX1jiaAnPh?=
 =?us-ascii?Q?0qS1u3Rb9tMMsRzZq95G5ENXMi+n0OGrYrFQZyRYp0a7b9fznb38fvDp9yW+?=
 =?us-ascii?Q?gdpFi5z20dgvXbt3O7h2oBRoKs555xXQlofux/+IgNnkzckEYY6tfYOlkKNZ?=
 =?us-ascii?Q?A5i4ErHwqxR9oY5ZjmdQgn80UnGT/s4unuR6zG7gAFEeCQF/tgYLXku/FVvg?=
 =?us-ascii?Q?MjptfljWgwJaPmqpmmq2TrFYj/NlifFnD1zYGt1J+3vFS9Pa7sVh62nVOu8z?=
 =?us-ascii?Q?Uy/iAnDVIQWpDkQr8RbnG5BnHelF8qky6KsgFnMzq2qD5mMiVodd/71eBEAv?=
 =?us-ascii?Q?kt2BXmlw89W4j7j/O0srIXw+mofm4xiWFQpK4xcfQZAwABdopB7ax4jA3uha?=
 =?us-ascii?Q?fhB433yWzUicQY3qVA0xbtu7Uz9FIYlBz8YFttrT3dDan7zLaUtWm+0R/53X?=
 =?us-ascii?Q?MZBEic4ggESFaYAqmqblOGlIZktOqth87uHJAjvWaqqtzGWDwLcblPPx5dH6?=
 =?us-ascii?Q?ue80EJRyB2zNkt/sZLuFOcOxnbCsKUKlhrHCDa6Q1UARa2DQU/re06+9bd9r?=
 =?us-ascii?Q?ZKJoQ5d437h1pw9toC7N+ZNmvCJWfMkvSFbYg73c9wL4arTLnmjDSJQ6V2Hf?=
 =?us-ascii?Q?QJmR1z3kNMhUUYSAL1MIrNJxHCXP97TAlqN/C4Mm4TMo0cS1RU1nrh1nWyMG?=
 =?us-ascii?Q?kb3RG6sTw5bQzIeAszsq927ZDIgzN8r9JO/TyWjJ2aegnXNvL55i4uuIFfK9?=
 =?us-ascii?Q?TYlKa/0sHgKJjed9sSUPM7Oa6TzsJw4SzC/jwucX0IOd481IG99HWvT62T/C?=
 =?us-ascii?Q?IPgTTT0yC1okuzjt1Jnt7AbV1JHqSYVhqNIhDncbRcxx4rkEnbst5vSPnvxg?=
 =?us-ascii?Q?QQCVuuKyLVE/pzZT2xdKd36AQeJAZ9VVpDoVRQBJ0R/FfT1Vx7oLkfj7d6xg?=
 =?us-ascii?Q?I8d86VoPuFRMnBySSeUgOQ+RzGhJ5Alm3dG97MUcy+WnK4O4FYO7yZllA/pu?=
 =?us-ascii?Q?AFAgTk7rvPTUb+lfRG5JitCU9qh3ETTo4oFHejwjU5VD7jr613+MgxMK3azc?=
 =?us-ascii?Q?3DLrusfUQTe0bhfUZk0bg8lSBIRKAQ1siqVzoe/gszm+J1UDzcQzd8PyXh1t?=
 =?us-ascii?Q?jyHp+ejrNY9ZikHfuSfoLUsIKqJXKAxwp5RDogm/H8Q/HVLyyq7gzK/DXHl9?=
 =?us-ascii?Q?7zvSWga7f9lCnRCyMY8hHlVJEAK7MbW8Jq2MYWW2bogLTrAgRAtUg1D4jH6o?=
 =?us-ascii?Q?3yfZ9hWeqVO2V3jaA+Q4CRyMIMPv8ivO9pn/7yMR1nd9ZxXNZ304zLTLbD2e?=
 =?us-ascii?Q?ZgRSBKVQirAqKe33BbIpZU3d3PBZ23PivKEahxNmxuoiFpHMCL/m1nH7Autp?=
 =?us-ascii?Q?kPrpwPfmPP/pSNqZiuuUGQYaQ3N/c/1W6u0X9s5nUs2Mr8r2Z/JpOxSbOUfB?=
 =?us-ascii?Q?ZILEWrgUh+ADlCvi8nM2hZc8L4916ABNhm7CeHaB5ZllF3LkYGMP9TdPghdz?=
 =?us-ascii?Q?aZEMUKPnYyVyhhxtUY24Vpf7VgQgw1fhxpbdSs/x/S7Zy0tMpj6qiTPmIjpx?=
 =?us-ascii?Q?6cuSEjr0SJrqWs0c3DpdSsbGZiTpW51HW1xPJQJJBB+eRASLbPG2U9BsDnyu?=
 =?us-ascii?Q?P73+PxuyKzAJATXAQSxRbCAeELRKhIQV2hiLRorSAvjMKxLRiFkH5wwYDcP5?=
 =?us-ascii?Q?FhqF5LYrYSRTY2VF+lT7g3OGdDObFvHqiW6xYjsy5qYlPBAX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 642f303f-ed24-43fd-e822-08de73741646
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 07:12:35.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpKuxN8iDW+iU9NY9w4dkINPjbPMwAFwptTEMpEOgreFoVuZVPyH615Ibkn90woN5fGCZnx73MY9wmQbQuBGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260367-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharath.r@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4840A182D15
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: 17 November 2025 19:19
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> <phani.r.burra@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 06/15] libie: add bookkeepi=
ng
> support for control queue messages
>=20
> From: Phani R Burra <phani.r.burra@intel.com>
>=20
> All send control queue messages are allocated/freed in libie itself and t=
racked
> with the unique transaction (Xn) ids until they receive response or time =
out.
> Responses can be received out of order, therefore transactions are stored=
 in an
> array and tracked though a bitmap.
>=20
> Pre-allocated DMA memory is used where possible. It reduces the driver
> overhead in handling memory allocation/free and message timeouts.
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/controlq.c | 579 ++++++++++++++++++++
>  include/linux/intel/libie/controlq.h        | 172 ++++++
>  2 files changed, 751 insertions(+)
>=20

Tested-by: Bharath R <Bharath.r@intel.com>

