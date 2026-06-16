Return-Path: <netdev+bounces-299826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G3LKGsZAMWoHfgUAu9opvQ
	(envelope-from <netdev+bounces-299826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:25:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A668F492
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:25:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GhKLVPLo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299826-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299826-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 619123001CD9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48643CAE7F;
	Tue, 16 Jun 2026 12:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2543DA24
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:14:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612073; cv=fail; b=gba2/5Sow32qF2RHFgVqaXy2kfJ0kRsE4h5WzOaT9uYNkCkgy84aoAwm6O1gcNFMHWkpYRtmVFMRUmjej5+Ba+QSD+IlEQd1+cMPIq5sO8Y3FdpFfDQRGjwSPDRbGEp3mGaCFllGP7906IZyGN4fTcaQ1pqDTzxtP3tdFi0J17k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612073; c=relaxed/simple;
	bh=/eI+1V6uwHlEzBRQp7rgKZx3cfjdQ+6LoBeyIOiY+5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=so6ASt7QT88kBM/eMx2KUnR1I3j2YLlyMp2gCJQQ8a9ItCDBsQ9QhNV19yknTOPxRoNI7B1InZYclaJBHf8LftLXg8MBbmTtdIhBqMkdNbor7tVggU2v7rtAh6095E+gaVZ263CHCg3Sn5Y7het/86COOhn6gCbzKKs6xDH9Qkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhKLVPLo; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781612070; x=1813148070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/eI+1V6uwHlEzBRQp7rgKZx3cfjdQ+6LoBeyIOiY+5g=;
  b=GhKLVPLoSPauPNb1yuHTD/CHqUkg8riCjy6O3yzugY/P7eogbN6lfrS9
   p5mKCpkFlC/zKSL2ghV17Rm1hcTAph+N+0uu0EIbhcpp3C3FlE9WFAmdi
   RYYPl/pt9bMa0k6Y9k7FZKOHjjwKIDF+tXVUjktYV+1mMUlVSffaHesqU
   To8NUIB74Wqa+9oqvo/PyxDBfbA3iQGXuZKHSMfDHp1mmLaQA/WfaoKYE
   58jIDNhdSO2gQl/iidR/76lgOAAIpR3zvZ2vA73LuLdoUxnZqNL26NdfR
   +L/fom6sr4UlqRsA1rnX+U5/bAWg3t0Zxnkdmx3WoI+G3k32qWjMRq8xJ
   A==;
X-CSE-ConnectionGUID: WcAB1zb7RhmEy51+oReMSA==
X-CSE-MsgGUID: t3qU2tKQSRWoPomTqqwrdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86212435"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86212435"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 05:14:29 -0700
X-CSE-ConnectionGUID: 8WUv1c5dTSOxY9gVEkkDSg==
X-CSE-MsgGUID: fttYe+mqTRqIpBjl2R2O1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="285861519"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 05:14:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 05:14:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 05:14:29 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 05:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca3O68FA7qNeggHcRWeOTOZabLMh6qYcFUlKtZ1Ke5rvQKFYZE14svqJtCW+mX3CDCZXSxLqU6PKxNCqw3EGW4Xj5w0/wTma+59VoID9kXiJE4zbEoBz4983lMPUZnDySBhPOeYaOfCIsQxZvhYlTQjTaDAx4rEaUOA9j8VVHFQcDvri3abk7OcVBUVGdD1TJb6ea73/Njh0s1qOpwmlK8FUh9xzz+b+gjZmv8ZD7rbXp7Rh/MTi+p7kqIwFNOd6GsubeDC3QHC42uIWInDR9HdljaPS11qm4ErlSVxG6XXsvD+iIrVToRMMyQu86jeV6ZRNj0ZjNg1NkGhwG3Oa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD6zPI6qY9g3Y1RTeZKs+sgF6xteYSpepMcaVK+sIJM=;
 b=dOSuafDJqyPW4rxk19opd7svXA85S7PN+BuazBjePYKZ3KXRwgwYWieerurE9yFuOOd3/rJOW7JcW22zoTV6fq4lAepg+ZNWNW/VctAXc5UMGkjvddXZve95guglNP9dh63qTF8zpIYBPHPo9SH0HNrhkA/0w0BPaRYb4V0/wmbMNP2nXhdXrjkWGUOGNyhP3ziVFBCghnwFkTdoUva7yfj4eYPRWYklodXHD0P91h3eyH1CHkB5jlQsWyxm8UYm4Ri+3j5CyFFk6OWau0kCtANOu08cdiIp1Pi0V1ZZvSQ00C8+V0REdb5e3pLDOtzBvlZzz+oD0dMHr6BJ7gVYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:14:21 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:14:20 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkA=
Date: Tue, 16 Jun 2026 12:14:20 +0000
Message-ID: <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
In-Reply-To: <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|IA1PR11MB6268:EE_
x-ms-office365-filtering-correlation-id: 708105fc-a3c6-46b7-21b4-08decba0cbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|56012099006|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: T05zt4QduNUXeNxd742JufNlI7UBaQZsmWRz21yqQwuH2QOapdqVHbT0jofoml7ziCAfHHQEixwzP6NnU7oqQmM8Gvk6gil0E2crDPWr8JzgNUBiEvpwa1rtMuiXofApc2ZGVUGIGcKK1VwPRWIdbhUX8xlriLMMKq6YrnMQcAP1IEPq8WosGWcztoYTm4JvOZOty2Y+dz0v0UN/F4zt8tlSTM/BS2dVH5830Qvr8XIowNYNAEGZerKH4kKFzvWa0Rq8aX+CRwrKdP+9Xcy73nyM05mCGxcHL9fBsvz19rtBfEU1OT/Htf/RHH5rnf3xa2blbmGn/5OprnXX/D25ecGH+aqWPVANQ8mivLDReMmOpa8tRW0ysGL6sgO08+ni7WCGndAdE1bwwcH9ccjovJvno7VUPnGsQcAcIHtfCB/emINzv+vD5fnEGN34opme9lWhU73d8xMTTdJyvaBhuf0zYTQ7jHbOzDKGjNUx4plG4rtr//cCNJFZQs3nSJwyneLGs8w5EAhFXRajZxFFYPVTFYsI3U/ZDoWkEkp7tsFnvtD5XlD8mug/Lc/cd2II8OkjkVVmWA8P0il54HVM3xTQCMv/cZc3miyVE5SoKmiwgsPXJWepb5rSBvxfsUg8lpXvvfW3TZB34KKnDobjvsn3w+ctbmo17nQUCEn7gIH6BhxgGctdp5bICVdk+n11QZ6k+VqX/BDnX0z+PIGPmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z2z8PWBwGJMG+MeK6BajDZTC1v95I/Ip9izLDDVC4kVCAqrm3gc2R/GhAU?=
 =?iso-8859-1?Q?dlAWHqfSaEYZ7C8UCX7NXmSH9Q4GLi/z1WclNTTA/axgdX8MAy64ehj5FN?=
 =?iso-8859-1?Q?ZrBOXTYP7diwlIW7sMljs1N1oQX9KinzWVdxYS7GoH3rzJ+qeE3WRZdAUu?=
 =?iso-8859-1?Q?o1o36SVH/pj9s2tsjm0pcqSEvXQ3WXcqifm72oQvQns6GeRrIZ6ZPIOyBP?=
 =?iso-8859-1?Q?21TpUGaG/mB6uPzjKpqIedaDTlwrphdFPtq3O1pWF+l+X0OCaOyXvNyH/1?=
 =?iso-8859-1?Q?0IiWmt54Bd3ijYWFcgR/uLK9uzN4rDWyzoB4S5vX4RIxJepnYIS1kspoe5?=
 =?iso-8859-1?Q?CMF9Fn6El5yPnMf3r4IkGr+c1eIbsbUK65pTjjWPzAslmbPoZBFgUEXEmS?=
 =?iso-8859-1?Q?rLqsB2SG5/PVe8aNiX4tN1889Y8UREncWTVD+2zBDKe/rr7NQRwwrX4kFW?=
 =?iso-8859-1?Q?hTJBLv5j9fJ4DH+etQfa0XKuPEG9H+sHAXn3CMsD7ryhftHscf2Joa/hJq?=
 =?iso-8859-1?Q?ci5KMDkwwA6+u3zBhCLBJsmEKkmv09A1tCxOpqqYAV8KVG7QZYjVDf9N7N?=
 =?iso-8859-1?Q?k27/bimIRHMujV/gNcjTAIRWj9vuTIJPUdQtBROgBTBAHr/kdNs8qIzhgh?=
 =?iso-8859-1?Q?HUE/UVqBNAhPQn6xN7c+qXpGNWB7OWLa/GJjhstpg8ifDndgYbVqD/k8ae?=
 =?iso-8859-1?Q?fJVvSaqVhVTNq3ocwJGyW4MkwyRgYYL+bTD117chFUvEDjfl36Ko7gm7tz?=
 =?iso-8859-1?Q?5r9IiE1wD3kQYbtDh7Pe7n4e/YnF2/Th6zP6BoPMRVdKKIWREpRxLsYrrD?=
 =?iso-8859-1?Q?DMRJdSFtb814SR13P4b9iYRJeQzO1w8YX0CiKdtyCYoVAd0YdYtymDtt1N?=
 =?iso-8859-1?Q?ejEL+CCnNYTaLMW8XUOtcyhb9aq1CCKlhh+KgXSfZRNqWIA+nqdQNJwRzu?=
 =?iso-8859-1?Q?pvuTeWK39ZMawp8OKFtCwBs6vpPEDvWzlzmFs+lPuoywrvUf+hJ9oqsLOL?=
 =?iso-8859-1?Q?fzVJY42G7pRg9VpVTSq5aRrPnPhsuq/l9nP3GJ5nwsRlawwkpN5EZBupyg?=
 =?iso-8859-1?Q?xcRpPNYQOlnQu88ESw9X0DgINWNlNZH3fXTL8h/WYoUAo9MtbtgFyuYbRB?=
 =?iso-8859-1?Q?uVohGdJepbzknIblhIYNQN/CA1nWUOia/qUX/bweUSp8HOKrPDYJ/8Jl0Q?=
 =?iso-8859-1?Q?4mmcHO1WJY2+6hMK4ct9eHFiB94mKl3lKKJ9CowwSD77bnBMkEnWa6OHhc?=
 =?iso-8859-1?Q?VI2ATISx8PTEP8OIOpQS1Kws2tE9FSK8btpNHrt6iJULZZrL+5xjxQ938C?=
 =?iso-8859-1?Q?RfpYicCamVMf9ZTcV37WMiKN1PqyZEnBNvkhqEDZ6gi8pZ/9mTFT8TGqQN?=
 =?iso-8859-1?Q?o/vplO613qjUXf5cSw5bu36mtmcQKZ1pjtyCMYQ7xvkCdTVeWuA2FcEnr/?=
 =?iso-8859-1?Q?r5uo9Bc5vR0H9OJSV9DeV38P6nGX1309LSvuf0lVMW3Qo30aa3v7jQN+KJ?=
 =?iso-8859-1?Q?dK5SOlnNIOgeKXlujTeEJzs+/lKrKOkzWyTbdwKE/WqDm6EQ14+MN38C9S?=
 =?iso-8859-1?Q?QImSEbGz5xRYw7C/pa4weg3NUik4VyZy6GlhzLkMyCRocLPp/1o/t8AOPu?=
 =?iso-8859-1?Q?wWC7SHvdLh2HtDCwdvy6SlcEWKBnjqhlI7jpJinNF7jU7lSOf8DwEuhnqB?=
 =?iso-8859-1?Q?IeedNJV33KD9csp8XMjwCv2g9dLzeR8r0tcrhmRHgMrmULfo9rbF3sjz8E?=
 =?iso-8859-1?Q?ANTAk3LB/4MT4Y344z+pVw3dmrlVz5ljm8Hj+5mWGbxRxh3rmiY84ywEEe?=
 =?iso-8859-1?Q?R8Y+QbXTTA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VocUNkHH2auEIZPqCn1rU+shBDhNt2t0NLnuxtsd7R+/90YvVDOQhr5vFNorqlMlyzAHIPwMW/I+/v9TycdFryhkmhm+5shEkcJCkjJb7h0pxk6zu7KCycIml1qYKKmIlfYBj3sXvXSN6212X9byy65aEtA2pIwZaZYrqON/rjZ+cZOtL8BRdE+7RAyHL0zbVLj6jpURdCOZt07G95bEEIkbiAfp9MmU1kPRmC+AXnxTTxUAOdk+5hARcCNDPFS/t0ZoUI2jtrrfMPZo6Cmrux3pcKNxzFr50uZMMXZ7ZPYTjo2qkdcxglJx7Oj2rDEENBR7vMWLY8TvMxj7UYYkbg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708105fc-a3c6-46b7-21b4-08decba0cbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 12:14:20.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLuwx5/dFEH2MEIJQzVn6co6JoMBqdyT2fNIa60FqyFmBgMU6t27PoV7bhWhRWrqbSKxVvBq5Mfq660sCJHYow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299826-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,netdevconf.info:url];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 685A668F492

Hi Andrew,

Thanks for the feedback.

Yes, for multi-lane ports we can accept the lane number as an argument like=
:

ethtool --phy-test eth1 lane 0 tx-prbs prbs7
ethtool --phy-test eth2 lane 0 rx-prbs prbs7

We referred to "Lee Trager's" "Open-Source Tooling for PHY Management and T=
esting" session:
https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-mana=
gement-and-testing.html?.
We have been trying to reach "Lee Trager" to seek more input, latest update=
 on the approach and understand if there is a parallel effort in active so =
we can collaborate.
If you can, please help me connect with "Lee Trager" and others who express=
ed interest in Ethernet PRBS. We are happy to align and start implementatio=
n.

About standardizing across other bus like PCIe and USB, I had a quick discu=
ssion with our internal designers, but I didn't observe any such SW-level c=
onfig knobs interest.=20
Looks like Ethernet has clear interest and we are joining that Ethernet PRB=
S community too.

Ethernet PRBS configuration and diagnostics support is well established and=
 already widely used in existing Ethernet SERDES deployments.
We think Ethernet is the most natural starting point within netdev, as it a=
ligns with current driver practice and existing validation workflows.=A0

Thanks,
Shubham D


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 11 June 2026 21:14
> To: Das, Shubham <shubham.das@intel.com>
> Cc: netdev@vger.kernel.org; mkubecek@suse.cz; D H, Siddaraju
> <siddaraju.dh@intel.com>; Chintalapalle, Balaji <balaji.chintalapalle@int=
el.com>
> Subject: Re: Ethtool : PRBS feature
>=20
> > 2. Whether similar work has been proposed previously.
>=20
> There was a presentation at netdev conf last year about this topic,
> and how you use it to configure SERDES eyes. And then a long
> discussion on the netdev mailing afterwards. You should read the
> discussion, and incorporate the ideas. There was a couple of points
> raised:
>=20
> SERDES are also used for PCIe, USB, SATA, and they have similar
> capabilities to a SERDES used for networking. Do we want a networking
> specific solution, or something more generic?
>=20
> You need to include lane information, since there can be 1, 2 or 4
> lanes involved, and you need to specify which lane you want to test.
>=20
>       Andrew

