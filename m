Return-Path: <netdev+bounces-307017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gAueBhyIVGrtmwMAu9opvQ
	(envelope-from <netdev+bounces-307017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:39:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C4574797E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:39:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ONhoY4HY;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307017-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307017-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA37300D967
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E26381E9C;
	Mon, 13 Jul 2026 06:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65563B9
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 06:38:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924732; cv=fail; b=fhJLRprT9DEGb68wQj6AYBfFl46rvQwx7pacZniJsNXHyPFHmoJpCvUK3hDrp320VA7tPoTIMH5lvpOk1C+vMsgrbfU0dlY46LBii9Syn0tXVTTtFHfjcb6/RwhmeVCR1/quwJ+iZh+Xgc9dp2J+eT/4f0l60iMlyoAThLfzquw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924732; c=relaxed/simple;
	bh=qT+gLtTZs5PhMH7COiSVfM46dHon541PZaq7yNwCwVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DpEp/Oa/AoGTAUJv/Qx/eNXu1pZxn0DbJ8SOhY+x09/lvhG9IEIrWH08GGl9CrN6wNQILesInEzS5zraFPUgYJ52OzMYPfy2eaGcveLgEVU8Ryx1hd3uhwnrOfmvo0wtjQMeNO/OWVLG0Vwj3Oz8Mp8FMLTCM48yk5ePS4iSc4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONhoY4HY; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783924731; x=1815460731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qT+gLtTZs5PhMH7COiSVfM46dHon541PZaq7yNwCwVk=;
  b=ONhoY4HYj26wDsxwBL9aUcnNOWBmVt2dvV1cFCikPhvamHL8mU+gFkLc
   o7rNMLjhkHy/7dsFrJjdlSDaf6EkgP8G8UJm/STmZfZaWU8mp77YWHujb
   4/EmxeY3nX+UsDxnGDq7bU0CZ+dLCHgfP/p+UcrWac6mgxaH6Ttl8ophq
   XgHCST5++IXMrx9bfFdGM/vzhF7IuD0VADiibywRfRRAIbOZYDkqpfwzU
   U721z6a8bAJyOXAbm4EYi+uszucTe+MYtzJgHVAP83x82r5rU1lWh6UQO
   DQAwIbY19pvtd/iPhfLSDxDj4UE8Rkn5sxOPX/34GiwzZ6aqRZjzgk0in
   Q==;
X-CSE-ConnectionGUID: sxBeyCTLQGSctD/QQZJg3g==
X-CSE-MsgGUID: l5CWyypgRQuICPHKlfalcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107326543"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107326543"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:38:50 -0700
X-CSE-ConnectionGUID: kVNWKIU4RaextFjL7yvPyA==
X-CSE-MsgGUID: iwbn4Q4PQbivM3JsBbktqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260347502"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:38:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:38:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 23:38:49 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbz0hafkZmieifi19HyTBLT2a8HpchRSOn6IcK5W/AnPiwr+wgaMcD1VNFOTLxlhbJnbmH7EoicnyQXBKWw6XCs79Stnb1EPmCzZ/g/spt/rgh9i6zItuvPzm4rqS5N0R6cOuHKIWs81bgduFkuphrQea+xU4V3ZSlel52VT58T0F2szW06RRpG/vkt5pzayDsjT5dqj4Qp8tIIc9S80+eLV1TYrsOISP20rgtDNYg+krIf3AvUEOv7wlOeiZtx16ZRhGQ0WV/7cWf7hFKSbJMd8MEPcHOFVXveDUci2zs9qo7ZmPVBaQ5ptwPavsBSo2qfSOnIO6hYVDvFX6UZEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep1x/WwF2bhV9Z14lMc63UILUp9/RYw4ThqXUB3KD6s=;
 b=u8S+8WzLc2bAuIWVQa5Wg8BZi0z7AZPow1LRkETuplNoqyZJQMd23H64ZIb1ddbEk06qb7ObteGm2m0aeUDw7uVgz/h3UiH7u35HoCR4AZYXxAHZpDpWpNsw55K3hhcbVfWzzFhLzttH6HzCTngYIC6+IT3Qj/8fSkA4RUgTcKXlUv8mknu9IFkb8z9x+ZhmSr080UGqAoYIT58yngSNah+lfWkOV5Uu29Wq2tsVayvVsN/vCJgOF+TZqCU3UJF82OArOdDyIHPVFuKc4YVV5iVXEfAOnMlJLc+76NNxQWQavIjYr+XZyaBTIi5xVxkS1u4gQBbY9CMUGXRrNId3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA1PR11MB6709.namprd11.prod.outlook.com (2603:10b6:806:259::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:38:46 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 06:38:46 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3 1/3] ice: Convert ctrl_pf
 pointer in struct ice_adapter to RCU
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3 1/3] ice: Convert ctrl_pf
 pointer in struct ice_adapter to RCU
Thread-Index: AQHc8afcXoEk52B+0UeBOiD7Y3asxrZrPZYw
Date: Mon, 13 Jul 2026 06:38:45 +0000
Message-ID: <IA1PR11MB6241F6843BD3795460D517EA8BFA2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
 <20260601091951.3017848-2-sergey.temerkhanov@intel.com>
In-Reply-To: <20260601091951.3017848-2-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA1PR11MB6709:EE_
x-ms-office365-filtering-correlation-id: 7c79a4a6-ea18-495d-b052-08dee0a963ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: MiDTANiXR906HKVdB2IW9fGoEYTUPr3vcHm2DGEkXAArKSmJrw4XnLobs5gxCpkFJc35H6qduTyOPbv+GzT347a1r9gZYMezG/vSW2KHZaMdY4fj/JKJ5vYAt4ytslhnyUszJmfof4rOX25q3YHIrSwM9FfemHGlxp2epiBPcwkKBsYJx3ztvQgJ0wHnTIFqajDdskpBqh3qoDV1SYVpikwxT7EpOvUsKyKv38/fWbBByYo8MoXQGrPQP6ytiPkjqw+C6+cV7mHMndfODfqhDTfETO71Wg2eI6EFnD7KNcZM0xSJftHaCIxKzcPkd7U+7dhnYbB36JBO2OPD1Wv94lHGi58lQxdcAR/3sz8pYflcFQrxUJoFYopjnNf360JJq8f7dPPnTqIy8BedlOdeep+wJP7m2078ZWgO6255gYR5xqNaJSUCT6N2on3Ixz2DKhAV9NjqxDV9tB/nlju+faykJST6JPylwql0clucc/brChkTNuI76OuG/k0GS5a3o9VvS7U2ZOC00ZJ/xzBaxVJaMCrfvqR1zfY3viuxi18C73ZUOhK0W4Qg90cAEzKAM/zzqfKOCAowuh5KHzzRmCwbEOtlK8sbzYN+xNiBFMyP/zdDiCz9OdrUgZqu4/WaR9E+VXh8lkQLEIAsJ5CGr0OhusYMQpOTa/3kcKnOinFI9sGF+Ubw+cT05EgU87/jlCyS2X0evJ0aqQ9w0HwE5/2C5Q+yqRLwY8AcqK/tP1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p6igSiIaeMxHAto/D9IbQn9kJFgVZzLVlh0kfQdathgd/F2xT4b6MLvmgWuW?=
 =?us-ascii?Q?Eaz6Wq0fNHV+w0I0+z9WB3NEp8z3792gDIm/1RZbzX217Y75jt6z1kuQALb6?=
 =?us-ascii?Q?HWYeYhZk96dBAS3IRh/yeVLfifjAoiL8zeL3DisipBhzx1ke+AjnuVSsPrlb?=
 =?us-ascii?Q?0FB9sCLUzMR7e6yNKJaBViQRvuHbDJMy6XMLy/bZjW5q7LzIC12Cbom4gPqA?=
 =?us-ascii?Q?jQotgGzfaPVLbMSWEKmNlb4J5TtA3DWMFax/sEvSq6r/DkY1hd9vNbepFc/X?=
 =?us-ascii?Q?lnWNxaGTmnqDhLWX9G7DNgn267sZe87f2qE1nLSrkrfTfNnAYOG/9ichtChh?=
 =?us-ascii?Q?Bh2cPV7lQzuHGOAJz1WuJUlNq3RJ3wAIDen2PPCmsjgq1nHi18JjAdAcCkl6?=
 =?us-ascii?Q?Erdhy99RzUFZ2P27JwIuJywFvs072ulf6ONdU0BM/HJhgT5bC3I67NMi4IXa?=
 =?us-ascii?Q?x959GJRnUGqizhdoFdFiH1fuPh597p8+vWTbaad3K2bNC9hQvrtFeT3OCKpZ?=
 =?us-ascii?Q?LhTGdZ9c7JTUiUlX0g72y4Z5XJMrZjXoznhWfRfYUnrv33M41e4Wi/jxGTqy?=
 =?us-ascii?Q?rfb9M52BNC9qFTAEqDu2IGy9VJ6KdkSL1DEfJIM7dR+mfMgHGSEp4QRI9Fxs?=
 =?us-ascii?Q?d6yNHkp8e53RK0SH4uMx/L738ak4z4/LZncyFIhQ+PdZ/kv9mPyHl1wq213R?=
 =?us-ascii?Q?tvGQl1n/L5BBIx4eRS+GRLY0keiJT93VSf6j2TEAT+Q3yZMZN+kLSjepc1WY?=
 =?us-ascii?Q?wWIvzONIy1VEd5Ki9gkNv+4zOAxzYyut0/x9SbK2yVhWfFS/q3/p0f5V7q25?=
 =?us-ascii?Q?WR+0YIHqkHHntxvtJ9RNR3M7gl8xF6XaqtXYtd1DaVVwIdzvKrYj1Y8eyb3E?=
 =?us-ascii?Q?hn/rQhqZf9CHYTebhjfrSRwV2U363U/MyJroJDnAvcw7o0ZjX/f2dnSGdSfa?=
 =?us-ascii?Q?xri6LtSADi5mz2Gj/cc3SReyFGCJPpRkqnefXTMqVLQB5FrOA3WOZb0rHyia?=
 =?us-ascii?Q?x+tr6iIjssd8rRma3juTlXwFGzPdwWwR+iUXol0/Ec7geg/cke9/B8grnoPC?=
 =?us-ascii?Q?EGNQSa56yzyFvvbY5+0cd2EgrhGLqS/uawNBPg6QubbNX1LN7j3vQbq8Ie/J?=
 =?us-ascii?Q?5SvZodZPtJqXCemLL2NGDf0GUTQAAcv7g97Q3e1yCzdKOxxXkj+Z5zBu4mf9?=
 =?us-ascii?Q?JZi0dpbIBgIKyaAp1bo2+OMCFjPI6YlBmXY5sNdBJfOhgoSvIybUHjLd66IK?=
 =?us-ascii?Q?OOEHDs/Ulh7cJMNt7Cmq7ObO35i4y+0tl4HMO2YOG8y2tR1M1Bko7KEJEALo?=
 =?us-ascii?Q?i0C5mtbP4zA3ixNWcyAl5VzbQvDK+kdGfpvYjbwizfuHV7DBrUtbg2iKc/1D?=
 =?us-ascii?Q?KxQ1N2iniB/tBPSbb+zsTumK74MrgLpM5nuCHhSOz4acqLUM4cI/OEWDwWFP?=
 =?us-ascii?Q?cXHkE/PaxA12byP20GvCyDDiTF8zwqPodJ/yI0zMdFSvjs3bFQOPI805MLi7?=
 =?us-ascii?Q?AzwND5iGFyNMgDExnH3INM4JZcedrexRAQX10l56MwZZoDEhRzQy5fFEgpQE?=
 =?us-ascii?Q?3wpcAJeqaQn/a8O+DUCWMi/3Xx9yFggHMpqKfrraHIl/9JHhbQafKVyfixfI?=
 =?us-ascii?Q?I9HexN8xCwGB6lOcEBgbR0wjKyg8LfLYx2zWq+nzLAgZKLGYwqI5Ilkbpm/h?=
 =?us-ascii?Q?WCMMJ/t+2E938uLY4EZ+fNysGzzdHxJfWkpOWMIeiXCDCMh/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jTWC2ykCazk9l4h1p+8vvdLkc1nmoM7nJ4TLtW/pHoIedSp6QcAru5N18fXjg908KbeMKVocMdJN9xAmHUMlBi4r8wksSCINHCeDFMduWoOB4e7rd6oija3mT1eMpBXkg4AB85x1VWNOcynW2RDMIWF1LQiqrHpULAQ7SFwj5QdI8EBTcanb1RmCjBSBl/zpV+HBL9FUg6UFmqYgARTorLUs546TbPySS/4duLujjE2obkbF2f4GWto9do2L3w0AuDynju/0RWnsgCcnsF+UgNQhTG09Emwbuhhttn2Imn/EY8v6Htf2lRj9keRfkHPgUrkdRIszs7zVEzoe0w3qpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c79a4a6-ea18-495d-b052-08dee0a963ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 06:38:45.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSZLxdI3gAeGgs0qcKiZ8rIbaz7wtCOdkRKcI4AjMLRymuikuJFEj3YtXKaIXWLXcVIVFPbMF3X+9pZ+BQJgRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6709
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sergey.temerkhanov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:from_mime,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cloudflare.com:email];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63C4574797E

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: 01 June 2026 14:50
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v3 1/3] ice: Convert ctrl_pf po=
inter in struct ice_adapter to RCU
>
> Use RCU to ensure the consistent state of the control PF global pointer c=
ontained in struct ice_adapter. Enforce RCU usage on the callers.
>
> Fix a potential invalid pointer return due a TOCTOU issue
>
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 device=
s")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Tested-by: Frederick Lawler <fred@cloudflare.com>
> ---
> drivers/net/ethernet/intel/ice/ice.h         | 10 +-
> drivers/net/ethernet/intel/ice/ice_adapter.h |  2 +-
> drivers/net/ethernet/intel/ice/ice_ptp.c     | 99 +++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  9 ++
> 4 files changed, 84 insertions(+), 36 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

