Return-Path: <netdev+bounces-261734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOyVEUtCoWndrgQAu9opvQ
	(envelope-from <netdev+bounces-261734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:05:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851A1B3A02
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8D83075E81
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1D33262E;
	Fri, 27 Feb 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiTQKH/7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049F3290CE
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175943; cv=fail; b=lVFMcpIDKGhsDVnmR/E+NvydtzbzK93EIis89+g1YJS24eglZOh8k4HYWH6eiC1l0qBX624cJEk13GRPU7TUlGHtA6E9QaQxwwZ2Cld8keH/d3pyO4PiKZR8+NUQeSwJzVNuLRDdkTCyhL9FQ3FHrttSGBv4uoD8US2fGnRdN0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175943; c=relaxed/simple;
	bh=rTFfo2a/99oSO40jJRJNaZbsDEVoJ7ieOlr2MRP8958=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQiajzTQelklhlCnQ9xRYzIMw/IVUQXQsJjypGgxHPEvvesHQKIKxWAi0yORRxBUDtByG2qGTs4E1xchx6lcaL5y9d3N0EHE75AFEsRMu9O0EUQnivRUtvhFPdqJe6scBXyjfT9jMtdM6z4OuAD2XatRRRN9lS9w5ASx14d/h38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiTQKH/7; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772175942; x=1803711942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rTFfo2a/99oSO40jJRJNaZbsDEVoJ7ieOlr2MRP8958=;
  b=WiTQKH/7LJ47Odn4o358flfpqIMWtnt4eYC+VRYkjevaGklLssGcVHfk
   7ArVhEmK7lzmpJXO/0Pat2cWzkDq51VvcyvdDQRkguwd+4tXT66/irKA4
   PK/rZbhwVLDAZ9Q1xe0XLohvrSbu2U6VqOtEXAPYbmxciuLKO/2MF/6uI
   V28W/X0V5wR3CooLBpqd3q6DkI4VcZMM4LQ5rC3qC1XV8G7hiq+rGTjIz
   BZ/Y/T1VY5941IlOx52Mdf4mK4jBk7x00wHj/p101J1SeSNWKWBHBDjrW
   6BSe0obIqSXENDwTRhrVq5gpbN4NCvWb6H6N4oyya0dmJPHEE7JfEAo9N
   g==;
X-CSE-ConnectionGUID: 0FzH4CxyTCaK9kgp6Liggw==
X-CSE-MsgGUID: JPd2J3XVQzSWSimwn1TWlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84606917"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84606917"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:05:42 -0800
X-CSE-ConnectionGUID: R8iOnp8TRSKIkIhWXipxwA==
X-CSE-MsgGUID: BVVVhpmWTiKnc8+pxy0weg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="220962619"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:05:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 23:05:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 23:05:40 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 23:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgUIUU+7wJf+BMUronrIDDXlA0tOOMB2ngKOYRLF4fqtVtQGn5+h7mek/QFQDvzHC6lHCQfmC2BU7McSIPJQO/JCt9aT1SUghWVOW7I+I+8Gh2y4qjcpHLfgtaOu9om6VXwDPOUWUgFV/VdwWp6XqcTq6R6FrELFGyp3BWD5Wwyyw+xjK9olWOGrGLv18CA6yhPNF7dWvWdrk7NWA1YJuka4ba8m5hUSAUm8cbKgo4JTJEB0W1Vy0bbZdYoi7vxXV+007MQ4TRAyqygWywvy+DQjo+O4IbiEevwh+HgUqbGPTt5UlXIPnGM/vLLH8AutLDVJ+J22IiHO8rXjvhy5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr5WxBNeqx85ne3SAGpsLv0LjJHQ4YROTXij+EQwklQ=;
 b=KD4ZoerMaY81NjOEqm2IQw7VJnd/Jr3mwCNrKD5Dm9YinNt1A9a6+ZlBA9kh7ZWj9mjrl5T7zlnkvVehBbrJ1nhv+GuqXREMczIHdcxeewchH0tZ+A1NBJ7XIvwSposOw71ygPrT7VsVjeLzJw79VZyu9UqfblIubII1wKuDBCVSbgLDgKKOtmw96lUGlKNx3ZZfQ0mYLnWqXZQsYWbXC8/JyNhfvrFxn4WExiYhTLj1x3YnxRqOm3CEJcfbQLoe8EzWnfxvJBUhrB3d7oVYIpYpHosdsnr6V+KcIbREzXu0ssygBn9/aaV1M98heAJiQl9z6FZ6m1pY0u05ujj0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 07:05:36 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 07:05:35 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: e610: add ACI
 dynamic debug
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: e610: add ACI
 dynamic debug
Thread-Index: AQHcj4fYEf28jNMW9EiOVK0vDXvSqbWWP5qQ
Date: Fri, 27 Feb 2026 07:05:35 +0000
Message-ID: <IA1PR11MB6241C6D97D9D6BFECA39B6F68B73A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260127123711.595435-1-piotr.kwapulinski@intel.com>
In-Reply-To: <20260127123711.595435-1-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CO1PR11MB4868:EE_
x-ms-office365-filtering-correlation-id: b5f490b3-eb45-4218-5bba-08de75ce9abc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: CmgbpKvfIzm0vPFIi2bpXaerbSwpbAaaWOOYguaZngvRxu5tHldH9tCyhV9KQtDmMLfebzy+bhszl1idnO/opiIi3EQZU2ne3uoDy+BNG97U9CKDK2MydJNP8ps+uMGa9VoscD1zX7SwwLwUgTcjp/taXYepWUxx/kigsAxBYmOr1d7YqsHxoLsskEV79HflGw7DwK4Bx08j7ItYIb2ugom6EEteBcOZK0YS5O3FBaqKeZ5+4bk1PRae4GmA5laTadeoK7MBSr1OwKgABzx3Ehux/kRP9EKkXxd7vWJ8kKroJPhgac5EI5jBEWMmdGfhkOtOvnu5jVn8xYSSRGrfOV7z+IV0W/VFPi/JfUuNBgAM5sJQFNKnFtYIextCO3uGJqSn9tNckEUPW8ywvwgMi76uULrgCpCM9/KvRuwPjIWJfIUQAcJZRte4lQlzM964Zc5I5n/RwcSjKIBQ2UggWBrhPCO5GNIGBN8C2sEzUHny5Kwspt4gsJcYJTg77w8LavBh1ZM2n//1KVpRq6MRQr1vtLeuUOHF63LqgEWNcfDxFpbcGy+EIyBBOJ8ORHYsTepLH5NJlXMBFCQ/d5fK5Z+eFgEDfzyjLqf+36tAH1ZNf2rgDISgH0I8SENATja/Y9Na26EOLktCjTzSvuEOji6oDUMgE0QlOi4ciX48HdGLICGWFKwnHPrwl8XMeoOnYUHxyU+Mg1xQd4Gptl8V6VuV61CRvawR3c9IzgbdRCtaVjAF1My0yHgRbJD90SzKysiDUELWllvGm3fV+w/ZMg3VitNg7cyPomVW/1AntWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?es2gcMv73xw9n5ZyKS6fy+6Z/9gWQ7e10o+de0J6mDdU4GPcByAjHYnqZv6y?=
 =?us-ascii?Q?5cWIMFu110P+3w5JFoduQAUuO3eg0Xbkm0fHBo2LnQGts2Mmfi8+HUc21/r3?=
 =?us-ascii?Q?PHvKPMvH9oS740JsFhTQ7IiWfyQgubmSFTfRLS+n+kogSOvZvPWEqTWubTAx?=
 =?us-ascii?Q?wtaElL5aHkeKcbke6ZVo+2wCKhIMY9CjD6w10xma3rUI4zTOrvyrJX4rpmqw?=
 =?us-ascii?Q?3v9kRBStc8egh3drba+a5ejFW4q/NAEafmLTo3NJ4hnNrWHzIv3x5HtgOdoO?=
 =?us-ascii?Q?UCVq0k787U/Cjq38lZZ9RQO3QdH1mgQiDjrgLn87FNXNk96SQzK2TQVkphZY?=
 =?us-ascii?Q?OI+eBsBwafGcN9YfTBtV8Ze+RY100qgSLL3+gm+P1USwuHBEccX+YgU/VGqH?=
 =?us-ascii?Q?K1liWnJXMOwhIZpPO9ggJg++WYi1yldIY8RyCSfXeIfCrZBEuCDotAX8eSu3?=
 =?us-ascii?Q?Btze8OoSowMzi824JljbXGeizav2G+d92tbo6ucKaDlGvz41lLtpbV8Uxxc6?=
 =?us-ascii?Q?Nu7Z7Lr7e9A6bAwMTtPIXdLa/P6jrlAz9RmUekiA0wSzXkRro2eGlckvQEDJ?=
 =?us-ascii?Q?2JW4pUIlMcU44n/dLpzrcPL8/uYazQEPhl31u45LizQrPV7cvz3ACVhMMJhj?=
 =?us-ascii?Q?Ao7NrngSka66EVbvSFhMXUPRYbCf0Fjpc/3PrdFpjKZCyTUFvU3y7ohAsxvV?=
 =?us-ascii?Q?bSXjS7D7FvWJzuAkH1N60QftGXHBSllYmbpJUMcRS1LXRJp+lnmQls/qGaUc?=
 =?us-ascii?Q?8jO5m4WpwP43IJXSSDlkQtnBy33HmHiiB6JgmjIkxeetimQ/9yuDhpNrDQBT?=
 =?us-ascii?Q?ihcrHgf4uHLMzc/MwTI/HF8yaWdgl89mWTQsRQobAd8+9G5qmNS+cIB++Vi2?=
 =?us-ascii?Q?jkc7ONqz9g87GHW9ClBwnkAeCiynsuUxNElGCxqGoTJpfLkzDvLcvJ6R66XA?=
 =?us-ascii?Q?U6CsXrznOUyL3VGywxO4ZEdfCtW6flwe8Bv9cHSfIvU67bk4AEQ+jz3wWFdg?=
 =?us-ascii?Q?d9S1Omf4WZvKzdYkk3aapBB3pxOrQepL7OFpKS919JPGNJHcE1a0gcLBqHd+?=
 =?us-ascii?Q?M1dUDa8Gnm4S4Rt+aP4D9xpJDzdlQUlRuGyH2Dpxik980hi/sV5JjQvvqABx?=
 =?us-ascii?Q?cwC/EQ1O7OwJR6nG8bwX72Lj9yDF6vnEjPXHLLswElZmjPwMWI0qU7wZMUxt?=
 =?us-ascii?Q?fcPyeDv6Uwnt3Y1DaNaVH8JZrDWCisFSXLSSquQe43tWNBfLwR1eyjyjmQn2?=
 =?us-ascii?Q?79BqrQwGrIzB+wHwBjPtMpMY9zXA4yxFpwn1W1Sse9chEmbEcBo9fzc2wweW?=
 =?us-ascii?Q?DOp+WoljmgopUCrYfVqtEWFqZ3IOUs5dCtUWBHuE4xvnp+1nHnLjJuuh5GUE?=
 =?us-ascii?Q?xyCsIGcO/66QUavJO7uJ7u/IJmWyyMr4/HGNRBV8dDAleyaWeaY+cu0G0UU1?=
 =?us-ascii?Q?J7TjcWJVeGBKJEOLw069cyCIajWG97Rr5N+psH38Vdvzdeb2lGGJBn163onA?=
 =?us-ascii?Q?zE8ov1dVULcCPu/LNwoxp92HdQcPIFdHrO+5J2gL+x6GQBMJdEEHPKTLvuC5?=
 =?us-ascii?Q?Rfo2I3Fgtauc4yOxrsyWtVm0Kv+ymQXoLLzcqs/B251/fGWAyJMaMFkXFJNP?=
 =?us-ascii?Q?3KJfxpxeYCzGwoGRT4dhrwSZnvX5rhBlmlZ7CsnBzIVf0beF31D6NWGcZfXX?=
 =?us-ascii?Q?+He0THX9NYjbApFg4uiJd+wmjzcZgWNK8NSE9gPEPKgSePtA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f490b3-eb45-4218-5bba-08de75ce9abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 07:05:35.2719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMnXC8gAn9amelhy5a9GQb519dnUE5IPR5IkW+K75HTEsDw7fnvlMxTHc6c95PGysz3D+QaMvvhBMLRI9UKhJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261734-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7851A1B3A02
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
iotr Kwapulinski
> Sent: 27 January 2026 18:07
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr <piotr.kwapulinski@intel.c=
om>; Wegrzyn, Stefan <stefan.wegrzyn@intel.com>; Loktionov, Aleksandr <alek=
sandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: e610: add ACI dynam=
ic debug
>
> Enable dynamic debug (dyndbg) of Admin Command Interface (ACI) for e610 a=
dapter. Utilizes the standard dynamic debug interface. For example to enabl=
e dyndbg at driver load:
>
> insmod ixgbe.ko dyndbg=3D'+p'
>
> ACI debug output for e610 adapter is immediately printed into a kernel lo=
g (dmesg). Example output:
>
> ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0701, flags 0x3003, datalen 0x0=
060, retval 0x0000
> ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
> ixgbe 0000:01:00.0 eth0:       param (0,1)  0x8194E044 0x00600000
> ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000
> ixgbe 0000:01:00.0 eth0: Buffer:
> ixgbe 0000:01:00.0 eth0: 00000000: 01 00 17 00 00 00 00 00 00 00 00 00 00=
 00 00 00 ixgbe 0000:01:00.0 eth0: 00000010: 1d 00 00 00 0b d5 1e 15 5e 4b =
90 63 aa 0b 21 31 ixgbe 0000:01:00.0 eth0: 00000020: 69 eb cd ab dc f8 8a f=
d f4 53 e2 dc 54 e0 81 fa ixgbe 0000:01:00.0 eth0: 00000030: 12 dc 41 82 01=
 00 00 00 24 20 08 26 53 08 00 00 ixgbe 0000:01:00.0 eth0: 00000040: 08 00 =
14 00 00 00 00 00 00 00 00 00 00 00 00 00 ixgbe 0000:01:00.0 eth0: 00000050=
: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ixgbe 0000:01:00.0 eth0: =
CQ CMD: opcode 0x0009, flags 0x2003, datalen 0x0000, retval 0x0000
> ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
> ixgbe 0000:01:00.0 eth0:       param (0,1)  0x00000001 0x00000000
> ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000
>
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
> v1 -> v2
>  Commit message updated
> v2 -> v3
>  Remove unnecessary commit:
>  e610: Convert ACI descriptor buffer to little endian
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 112 ++++++++++++++++--
> 1 file changed, 105 insertions(+), 7 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

