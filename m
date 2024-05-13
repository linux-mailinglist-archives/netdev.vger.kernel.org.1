Return-Path: <netdev+bounces-95898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B98C3CFB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46025282353
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75567146D62;
	Mon, 13 May 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBshQHRb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DD146D5C;
	Mon, 13 May 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588184; cv=fail; b=QIj09QhI5m/PLvjaOAbU6atheQw76vGW2e2mQ/5lYX94ZVfWkdDrExZBaSo81dcPc6VkNuL/oR0rcp2Har4qNvDpDAoMXNr+7oe6W+ZTTIbmWo2U+DIoWtr/l+AC+O4SXpdsKo457QrSmal56StDdcEg3YtElL+KiDJDwElthp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588184; c=relaxed/simple;
	bh=+oLix7l25MbVhmblU8SRzGu+O9pmiUMShDOm0l0N2w0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVyVUKmyPfJjt6/tI9qk0xf5ZOrL7A1IMnCQ6Npv6N04dtfY9fUJ6ZvIYr9yyZKfB2ypxga7FpiQyizl9ecRixvwAWQUgSyZMMsu0BqwD15WNMzoyklPJN7fZ07ox9Vqrhq8ElE3FeoNujFFHiuVS05wxX3C6i6w3b2atcmjdkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBshQHRb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715588182; x=1747124182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+oLix7l25MbVhmblU8SRzGu+O9pmiUMShDOm0l0N2w0=;
  b=HBshQHRbtdbhF9/OGklsZDOa4fheHMqH7BwTum4LzvCeIPWCMI2BVjNq
   wCT90+F1dXnIX9jrHYV5qeBggpWzzAuEagC+AJ6pBcqRXkSxSLDv4YLU5
   VLi4Wght/hrbOb0oq09on5rTtV1JOjcecSk6lwvByqB8fecDUENjS2Mgo
   F69Ts5H191pRU+I30Vbw6dKjbUzL/yw4fhoJi5zTzDrPhOMuwKRu8h6qV
   rHc9o2Vavc6Aho525WxF2WWl3MqgCg6F3s6Cf5sbknAuOA8QZ78JA1Pt9
   zVQIEF6Kd4n5JaFZZJgEt4neG6EODvI2dOTP8uCmazzd8WhUWxqb7O0Fx
   w==;
X-CSE-ConnectionGUID: POLzp3GGSRyG6IxUi0HIYw==
X-CSE-MsgGUID: 759N53f0TXWZJcMgXiv+Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22656976"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="22656976"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:16:22 -0700
X-CSE-ConnectionGUID: WtyJdZMiR8a3IWkYMtpahA==
X-CSE-MsgGUID: iIKhCEn/RrKbeWke+kJsBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="53481727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 May 2024 01:16:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 01:16:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 01:16:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 01:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF/uci+LhH3mGmDj3Xx5sPD7H57iBBj/gXYX2yWmkfSYEblkb9VhFLPUJvLwms7xsF2QmJHuhP0RukN5N7pKlddYxx8OemcgPeIWXyEvJnBNUHV67VDjxnfHH499ul6HjLlR5kYUdMgPsDsFrH4D/1vU8AiGM0L6ePgLFz/0OMi8oGeMcpcIoUI1c9YNyruqt823iW8zglaSfFCrCWSclsMp6iJzRSBhxElNYD1a/KSH8zqPk+mZ2SUm4+Y3GGztg/idLn//3Pg8DWuZi63I7Z3XMVYRhDNzGNKLkT+q6EDGfEkU8622P9hIGXR0Ij5l0sPlk08ZOwDxVRYOy5iTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i8WNs78ZhLLF32a30lJCi5SWMvK9rT3HAHfuBTrl/c=;
 b=gb10OFLyZMxeIxKtvTdyP/F+ZNE5+5d8T5tVt4pHXHIdnH9y5ZZsP9DQu+XF0SOKrXfeM2a3d3OtNRUmKE4vMPuLxOiawf2iqb1RqBDNEbxiS9eVKZ4QVyi47HF5jcfTsTRskRXIdvkTA6GcGQ9yK/JokINioM9rxGjvlAtdjroq35yWxRUQHSvlWnhTBMpJAB28hsV8YnH36i7W7obcMe4sP/Px+/PpxTL/ehWa045zFnDmRZtVAFOOkn8U2RNqEptFJ7QlxoaBgF+PeNsx5HQD4nnQ9XJZenAUd6BA2Q5Rm5mtxdeFRwzFTrvvLf8QV19IGT1LVf8FxKJyvo97fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 BY1PR11MB8029.namprd11.prod.outlook.com (2603:10b6:a03:526::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 13 May
 2024 08:16:18 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:16:18 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "Glaza, Jan"
	<jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dpll: fix return value check for kmemdup
Thread-Topic: [PATCH] dpll: fix return value check for kmemdup
Thread-Index: AQHapOWsatwUWu0/UE+e+JAtWgclcLGU0SgQ
Date: Mon, 13 May 2024 08:16:18 +0000
Message-ID: <DM6PR11MB46575EB151D97B15ED9AC92B9BE22@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240513032824.2410459-1-nichen@iscas.ac.cn>
In-Reply-To: <20240513032824.2410459-1-nichen@iscas.ac.cn>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|BY1PR11MB8029:EE_
x-ms-office365-filtering-correlation-id: b740de38-8760-437a-dfbb-08dc7324f77c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hJsNEpVSEY71xad/74i7dbeq5sQtyeuUznrg55z4+bWxZNJptcPDP12kUDak?=
 =?us-ascii?Q?7taWZkYZkDIOpJK4z1/sQJ0HxKBXO+khlxrM/ZpV/wZYwnSnj9eBqcU3Tahw?=
 =?us-ascii?Q?8ux5mlnpBU6/lUgi6+VTJP438kEh4oWO+0t5t0ZYuDgtg0ycf6V1t4Solsjr?=
 =?us-ascii?Q?GpFWfXbHyewR/kEaizSZyXUxxmsKN0uQnGIkkPtxNndg9T8GYkAI7VT2Tb0D?=
 =?us-ascii?Q?0+16DPFka8uxBtGb7OfM3wscmAdlTn6SM5dy2pwuU8Mn4k1mk9VgH3Flp8Z0?=
 =?us-ascii?Q?rr92v+cHc6tDy92Py7JPBPGZDzIBNgqEbjYmSb8B+RcxJQoZDcCJ5RCp4k/h?=
 =?us-ascii?Q?dn1/aIXgpH5NxHYMGuJsDR+auZsgpMrGCT9dxP7wh8VlpuxyhsTQy1vz7wvA?=
 =?us-ascii?Q?YurI3qTFrS4O8eaEkdRIBvftcZYgjSJPm9VogUwnnRZgy67TMlsbEy0bsOof?=
 =?us-ascii?Q?sE7d06xnDLGQOumPhTrTQZg9GDLAkw/UVZbqrH+scVgP2zLDpy8Ftlr88BHa?=
 =?us-ascii?Q?ebQhhSh09dm1zkijaoV9ZTlZwXkYM9qJsVEL9/Cg0sZhHapMvRYodG2MA4Gi?=
 =?us-ascii?Q?nTFYgKJj2nVuPkXHgLJ9TW1porG+6auiEpRfR1GPtmwwOjj2id5UBPFVOn6q?=
 =?us-ascii?Q?iluYZ1rwg4nv7hDRML2cG9tf97RFS1PyUZSmzo6oSyGauav6Hd/qiGvlsqWE?=
 =?us-ascii?Q?Lc18rhT2cm7E4RrnQawyHgjs9L+OhZKEM4fTl2/V4nz0Ai9Bnq+CP++jqXbx?=
 =?us-ascii?Q?OO3F4uEigQXreIJ1ga+XmokW8iMxrwO2+bB5g90oERlAUv9sQnsiFQems0ra?=
 =?us-ascii?Q?S1RU31xY91D/qzZLOWjQCCeq/0DdWE5vd9iKXala1cuyoc83wU2BjRNu/nyr?=
 =?us-ascii?Q?zVyLkZ9O+wsTnkjSP0DikBnt+kF5JXXl6C5f6quY8X0uKFklngBjJHEfMuIw?=
 =?us-ascii?Q?7ZJRkTWq9F/nOutFR5rOlChCiX0AonWUKki/sgKWiF0VNlwU7bHlZLauI6AK?=
 =?us-ascii?Q?YOThdUJck06GHqpAZ0RjPyPixn8QA3flcFkd22Pmr550yb+m0vbKawfAkwyJ?=
 =?us-ascii?Q?kUF4rhQRZm+RaCB4L7EZz4bHTK6YWNiBAxRO4oA0SG8o22+IQtyB29j/y/ZD?=
 =?us-ascii?Q?AD4pj5bkhT4yxxgvll4LKtFAwBfnLLbJadnsMcmrwLkwpaaJHJCfi2oV6TpI?=
 =?us-ascii?Q?rWFRLgk+PbPiYOCYQ1pUi3myfKcWnU1cgsyp2ur48R5FiOaEZ8E5hV7D3b84?=
 =?us-ascii?Q?voElV53sq6sNCGBIeinFVjrzV1/a0JW1tlnXC6eLseJWEiKj1oq99hmX2II+?=
 =?us-ascii?Q?uTKaoRwQeuDvK0wUw3CxU8Lk4eJWIOzdbr6tC0H8OtWY+w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+DJRphO5SsyHzAkHQ7o+Jscx3LcCsujiyCIG4lhUErZxW/u9iK1JEZ8NxwF?=
 =?us-ascii?Q?etPfbY0FUqmocIeyxTDzT6TuNHBR+Brtl29uQIweDLDaOKOrnDw42OaULuOV?=
 =?us-ascii?Q?H86zmMCbXTybik4uMUIaicAGOzdWNjRTPniDvO9hSFmO0V8BL50YvyEYDIzb?=
 =?us-ascii?Q?qCkCZDtAmwKdwY6fP5TEN28KxJO8RJHpbHgVoQ4tEGi2SDhTcjO5uqhTHhr9?=
 =?us-ascii?Q?/3KHLsYgh18U1MJO+qraazHs/Qi5OCy+SDASAqPpXx8dAt/QLt5K6/Ne3uoV?=
 =?us-ascii?Q?caLCsuCqqo5dMD3bbTTJE8gBLGTUy87sDqQvMWeHOGwUgawqNIqFYKq22SgB?=
 =?us-ascii?Q?O+NL5+7IY+ZByHkL1SrEz55lKBuPY84PzcJMS4lmyQZr56xitHb3Sz2rQih3?=
 =?us-ascii?Q?cZ9l7tNBlDw3rZycSJ5gAyLXecUlhqudtBjodFM2+HWl/gYti0iKXe5DPFy3?=
 =?us-ascii?Q?BfoAt30l+KOqhmG+lk6x/27Z0mkX1hFx/T2+Fuzqpra6ArJ36I4CggotGNAF?=
 =?us-ascii?Q?Xmxd1UGha5barqSjpUZq/FkusMGiIU3NUe51ESrO2puwrO1bE6JupUJf2CGQ?=
 =?us-ascii?Q?ZMRTYCXqrVKcxtOxes840BY6jlT3ZvTbehc8DFYxNLdUZYg0DGx6AgzzE6O3?=
 =?us-ascii?Q?jLbc5cOzvX82fm4QJf1fQAqPoUpSrpQXrBmMRVP9QRNxsUZGS13reH8hbRnv?=
 =?us-ascii?Q?WrqKXuErZ22xDpHhc2vVtFCo6l1VYmpppR4+6mDTHGiIpe/JSheX1z0+r0OU?=
 =?us-ascii?Q?HMhhTTZXYfKdLW3DFt6QFL6L11FcYCxRYQr3fhJMkT4SYx5/2Vm0gGyYZ+ij?=
 =?us-ascii?Q?364ezPOt5VNBOQvbHAzBOYNWixpLd2bvihipHAxxEDH6ohq1NwUafYgv2HJu?=
 =?us-ascii?Q?K9dCXvSrENurRhlbf8ICOG+j7PWnfgYWRy4I4p8vb6I9CZfSugOcpxZ1zsp4?=
 =?us-ascii?Q?B3atHM/sf0gO/rRKdOIOpsBwVtf7+Y3+zweRVBXZoxbJc1P47yD5G5IfjUmd?=
 =?us-ascii?Q?rEXSYc7DfMbADw56xNd4ArvqwM8oVsGAa0nG2u6aOOC0A259GWvgyQyoxeFd?=
 =?us-ascii?Q?MmIaK8Hf2yOwtswBdBrBv6iIrt8h046q/On2GTT3fn9FrN2IWjVQnM2b5kq6?=
 =?us-ascii?Q?YEnRgNoVeK0sigxmEj/TQfMOXletoAWEI9CKSnKY3ZrtFa3iLLmf0ftpxY9D?=
 =?us-ascii?Q?g6+e/rMhblB6D9+v31bixpnls71U1wd60M4+otfaKr/G1euvL8qXbyR4Luez?=
 =?us-ascii?Q?25rKmUXfkqqrheBkKThbV0GxDOWV3HvLZ/4Ztfhlmliagqk/GMhXmwkXJXfJ?=
 =?us-ascii?Q?2UbFodSaL31NYbI3bA445/Bmq38sMi0R+bLXE1d2h7LeKz4jtmdMzyNoSSxg?=
 =?us-ascii?Q?uRapSxrTtSgCiW5uq0R287wSifR/K/sIjH/Hw9Fs6Wr0RWFANue3QaT6p/qx?=
 =?us-ascii?Q?B1uy24oo3rMpnV0B/bE5fymi7Q7TxahqlDuIEVOFhbwpLqoT5Y+QaBuxoY5Y?=
 =?us-ascii?Q?lzkskK78RncLhxUjQp/xnAQcPMiM//0JgkdARdL+26hw7zMM961YbvjnDLkK?=
 =?us-ascii?Q?c0T+aY7E306DVdFSEApzMyTwKYuYFvYw1O/LocjcWvxLzpLQXEdp5miYcGZw?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b740de38-8760-437a-dfbb-08dc7324f77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 08:16:18.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIohtdZeRlTOm0w2Nfbrx7xX9gpbNxhxGlyQvFgAd/P7akca5vbATHOb1KIoeQqGUqlQYiMFweNIQ46ZCU/Dd2LDDAQ+nVqFdTyK9RSYx2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029
X-OriginatorOrg: intel.com

>From: Chen Ni <nichen@iscas.ac.cn>
>Sent: Monday, May 13, 2024 5:28 AM
>
>The return value of kmemdup() is dst->freq_supported, not
>src->freq_supported. Update the check accordingly.
>
>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>---
> drivers/dpll/dpll_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index d0f6693ca142..32019dc33cca 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -449,7 +449,7 @@ static int dpll_pin_prop_dup(const struct
>dpll_pin_properties *src,
> 				   sizeof(*src->freq_supported);
> 		dst->freq_supported =3D kmemdup(src->freq_supported,
> 					      freq_size, GFP_KERNEL);
>-		if (!src->freq_supported)
>+		if (!dst->freq_supported)
> 			return -ENOMEM;
> 	}
> 	if (src->board_label) {
>--
>2.25.1

LGTM, Thanks!

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

