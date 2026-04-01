Return-Path: <netdev+bounces-274194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBcpOJlNzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:53:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DEF37E384
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 114B7301493F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B4477988;
	Wed,  1 Apr 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOKbG/XI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679447A0BE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062227; cv=fail; b=lFSeROvh1DZHfD8ePmolRLil3xs6Kie0/J7e0lhSopr4ItTT9gGCNiUjOUtYLsbYKz8y2jMiK+6goIhZ5ZzB6f859OBY+i0EurlwxCP9m7+YbOwEpFEdQMOZdm6t2psRnoASQNvaockj9sibd1/lSoF/UvkbcPbNGzC4RaBI1oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062227; c=relaxed/simple;
	bh=rAKH1ZY3bMFC0XdmzICVxSKrt6Q7ZDDZyYuXsHLQ8eQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RyLKZRsUrmmk6tpaBxZH0BFh3iK5vT5isSlJF+xkvJglA1MY1dZY8JAkRnSWJile2MVIvySlnXvQtwAS7lSSx5Vn6ctLcOxbG/AgPVeHWPDgYAEwDJ/rGrfceFm9PQQ7w7bxei1AcRwY3lVBWfRlmcZaT1esYtf9OEJWRg55OX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOKbG/XI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775062224; x=1806598224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rAKH1ZY3bMFC0XdmzICVxSKrt6Q7ZDDZyYuXsHLQ8eQ=;
  b=YOKbG/XIwJhQUixgMO+FiZIvPFdYFuKi1VjzBpNFLVMswoYI+jWOH4Sv
   M2RXUAZbNazH3wsOilxaM2sGQT9769cL3prBz+vGxh/1zc+rIFL+4CneZ
   ZFHNNinQY5hOmrWboQyQfmGL4dhOMlnAKaG+r1nDTqa8lPvmhkkcIsncI
   8CIeBxO3IfSwQSfTLN/JTvvOfbodAMmBm8lJoOJyOcJe5qrgh5R62q8rc
   OreBywpLw/BemN4eZ96UoFcrnbV0qWy8g1p2eQF7qjYR8SeUR1e2ictEi
   EjFWaDKXaksFnTAzXO5xkzrMFo0yl2TWrQREUWljRhdOANEo2MVSIzJhR
   w==;
X-CSE-ConnectionGUID: qAZmLIErS4GnJukA/uVGLw==
X-CSE-MsgGUID: xVj82roOTemz1T1vYU0KKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75825199"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75825199"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 09:50:23 -0700
X-CSE-ConnectionGUID: 0M0SpHRGTvKLKYIsIQMmPw==
X-CSE-MsgGUID: 5TQ+6XELSUGxd+zSnWnZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225717280"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 09:50:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:50:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 09:50:22 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiPxZebmMVbK902HX5fPqXx5Pvb/0OX2NuEmSznjofa4ZSyFvybP8jw7QA1cilemtppNfMU9HewQVvCOdzjkvtkJ0ioIco7LD9Mo9A9nGph8yWcI/Hboo7RmGACD8eWi0uJpSj9QZeSDgfK04AYkKR54EL3B5Q5kluUXD42aZQHcLRi+ogGpo+Pzis+WSMo1oXCHYoUoHN/dzNN6cpPgrOqzL5SRZAmBccWDBDeOeqfXhAFFDLOhaCsQOXZvOkJOxsT7rmo5O38qhj9NTjpLkD+uxGzjniAZ4Is2/CEZHaRwscBZRdwQRll/HmfqsL/UwJ2aveXki2kNfRv+A0REgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8tOtQ+gDwB9XOYYrwb5idlZOVyxEjpJgoh2jvObLyg=;
 b=UdwVPcihYvBujGhkRaJpvePFiQ2FK9bqqddJjQEztAkmfYlX2EDUwpQ7ZPZWkRk+2ChUinUYus0awUQv71srTZjGStbEhiRcW/Bq3WRb9yG9cQFaGCXSU/+b6DPPuO/wKmGiRRpVkvI44QvzQ3EX+BRHtucRkGPcZoQjs0jy07u6f76X7I9GhqJgCiT5lo13zL+TcMIqTldPjlCRUM1meGzq9GqDF2lXcW/1jsJnWLqNA17IKjFntiwqLWyyEdKl4DYgwo29Q19CleF6KBubYuXNQLvUJi+EvhNkxgYIpmxZB3zfm6QNMhULu8hB6IVzgKRaKZTm+lpTj0nBMHDi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 16:50:17 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 16:50:17 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next] igb: set skb hash type from
 RSS_TYPE
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next] igb: set skb hash type
 from RSS_TYPE
Thread-Index: AQHci6XZlS43sIeF20y6Gc2on8FRdLXKSD+g
Date: Wed, 1 Apr 2026 16:50:17 +0000
Message-ID: <IA1PR11MB6241A3BE3467192EEA0CF77C8B50A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260122134809.7765-1-kohei@enjuk.jp>
In-Reply-To: <20260122134809.7765-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS0PR11MB7734:EE_
x-ms-office365-filtering-correlation-id: 3b8d9070-70ba-4dc2-bb73-08de900ec120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Bp8aE7ctwmVihRDKmiZmh1UZ5mHQAVU/iX9HBxulc4zu2CUqpC+RMMexJW0qSBYrpvG3f8gSta8iOGrbjoHG7X53gm+klkgczajIwpOLShyUOfnYs5uLmhJGxXS6roSP5mggv4W9r9xu41X6ClGiwNXcX6Qx4qEcNQos2ZtC2G7aPGrgl5lx+YegtE/L1J42kj2sgysSQlfSjT3grnRpfyEKgRjdCRY/aA20fnEO4xWPAbCrkZ+9kIvSAyuF9i/xw3ZW80mHjA3l58YPdQQCdPcHPQc+DQxlhYfPUsZaRJlwgFJ2UhtHT0XMLGNH//qfRPrPkNLStKIoz3TUodgDK83b2JzNCMqV2Q3qYYM5jyIR2UFUZ4mZANt14toLbeaK03JJxyr0HuDZMySZbaSKap4bGAUBzBVpDG2sjfgXRstWvNmwCfhzqBlUQF9pbERNfX6HHA5Gm8nbnf4VesWUngcthpZ34fpm73xeaB6kyeiB9MGtpd8cemyqvQBjCQKIYbK0JmaXFa1uI6J9X84tlLA+ZIrNFPi1tnzqvPJCclFxry4NkDVAdacfZkUz6NHD4xnd+G1CDKLDFZuZC0lqYWvWRW4lV1UIUyzuv1HR8dbUgN5v4fDZGrw6sZvoCSeCYSZ38sdD64FL+0ZzZDtVuS5KN1puU+bxJ6VNiMR5tQ0l4vogNTdCPBADoDE4K95IIKL3MLelR2yvBwDpIWR5IXf1/Jm4LTUwPV3Q9+SDIFTK+LSe32oRrYmXPH/JjVuCPi002x41azdsHra/xEIKt47r+RUO9kgX+T6odfRpG0/Evhm+vUH+/R3mJdlRlaIL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5wslgOPQRNDvJwJDSXzg9hY+9oGeZsSiaJ044fwcNBE5jjCyC3uo9Ylb6GFu?=
 =?us-ascii?Q?KikjKoOWg/Hy/vs460SJEoJXiiIlFFC0BPriIos5MLG2NNebAskrO72tnRrG?=
 =?us-ascii?Q?ZnSif1r6kjn6PFNEAkrgOIztb4ws+czI8nAS9p+njcAtgnGCFIOS79Hqa1LI?=
 =?us-ascii?Q?Q59jTtckt6F4K2qSPuAULvLGX+kkFl3UHN5gUMteHiz8stx6eW40PpH30lUx?=
 =?us-ascii?Q?8UkofEUgAVMqRTQLmWC9uVYmVx0IEJ6sx5E5kW/fKsfPAZlizRzUHMZ4GMoL?=
 =?us-ascii?Q?uq5AdN7Ple5ulyH7wW4Uh7sF2iSYVFtkKXY5V5HpHM5W9MIdeApHJfVAQ4Cv?=
 =?us-ascii?Q?5BVEs2W5iNzyxxA6ftuUjTky5tqhPLKYCKV72BADZ3hG0eR3fwqlgUBWgEfQ?=
 =?us-ascii?Q?Nvg/vokNlbDXzMTadsap2KwXB9rStPANDlAIsK7pmAk8NgLO5IXZgTSKDxNj?=
 =?us-ascii?Q?KT8n9NSd1B+B6BcEG5TGiDkq3yzWq11rPFFa39bf3ej48A7tkn8bog8iVQWw?=
 =?us-ascii?Q?fG6NOCW/RUPzFvIBg/XVZGRnXZdGlOcmOuvPtEXvQ9nu7NS1Lpwl+dY08Ehw?=
 =?us-ascii?Q?u75X1aCNdQ+VaabmEmclzYAM5qxtN0DzfKCaCBl5OPsJsEHpu5zxH0CR9SY6?=
 =?us-ascii?Q?1IScF3mHlFWHm9OC5HWk75qziT3SLZE4QEzkW6xX6PhtdhbiHalIIpvmjYDU?=
 =?us-ascii?Q?T4aMntJOhfPPKxxm8SBcwVUxkDDNp7qt7sZNepfG2lyIoD6mYl6n+SWl1rMC?=
 =?us-ascii?Q?KbzJMI9+5Vkd2rkoE97M2+V4W8G4Jq5wHimEkyZjW+W6jF+6WubkXoqAEPc5?=
 =?us-ascii?Q?hwlua7Tx5SoSKH6RU6tS1Zp8A2Hzyf8TSRO8WR8QKKzJL6oEh7X0qkbAPa64?=
 =?us-ascii?Q?O2UBKVEYSvaa06jPEtWQ0vTlJ06Iz9ieawynoBW/1/38cwcO7Z99hZUpJqlF?=
 =?us-ascii?Q?CZcXtGMmIixGM83pAxjWN3b//Jyh3W209q+3VNmX+2lVH84lHKwk1JBuuNCe?=
 =?us-ascii?Q?FpSG1eQmsCY76L6pExWEC+MYxJ6h09Sf1KUCS65yM3yFhTzMTC8L2NfPufki?=
 =?us-ascii?Q?Po5tzpiFmEfXXFQkHBB3gk5wSNdH+uoQbbc0s7L4xGM8Y/Mwp45nCCXbopaP?=
 =?us-ascii?Q?fN3MO7ULAKO06spnOLgKqzeX9YNplTCFnPAISPaaKlILmV2+clBKweuHw9s1?=
 =?us-ascii?Q?HKI1H4kGwnc3gxu1cnOTtt381HtJUdV4VztxgOrvQ1REDXne0FHp/yLAF+l1?=
 =?us-ascii?Q?lNkChPsug7mJQdDP2M4z2H1QLgLSQLDg14Pr0oUnhdo+KvK4zZoO1i5O/JhS?=
 =?us-ascii?Q?9drlcssbsqch9toYhXEjaXAWFWyDo1iSPm7EiMhhBDq/JC/1CielLOV3Rq1I?=
 =?us-ascii?Q?rwwEzlVewvfL43xBCSbfeLKXzSBjB5IPqw6tZwutINXVgqT2YYRXomDJ9+cq?=
 =?us-ascii?Q?W5rOR3AZt029MpLLTAPrkMWCNxEsdXVv2z+JoiPk6fS77tZwft/zE4pkOE9Q?=
 =?us-ascii?Q?m2tqwAvliR93WtKEN64QJWGGGH2DMAs1Q613CN6JDgO8TCdWebUqe9ZKWKcO?=
 =?us-ascii?Q?pNh89pT5A98kddK3mC91cJyX7Hy+sJjRCRACrRrkiNbFSZqHV9fGh0iep30F?=
 =?us-ascii?Q?zmtDBDzZ3R+UeZyHFEzDNahcLIeIJdlreBvypx9U+z4visemGGqJr0sqHoJ3?=
 =?us-ascii?Q?J8lLvrpdj/OjP8IYiDhqkTGS9cHx0Y25xpXQP9/rn6DlGEZ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: irAIqoQ3xcvtJIiCyWx6mv5GPv19ll4CXZ+ipwD8W6BeK8PYD9kbEnsccSSdvq/soOUfd/6jIcvaJynYr3GKektrxu3UjPwqAVcPY+B9R7HE8pLbgXfTpi0SEZT8TLopn/ASuVnKGaMe7hVbIuiYAiTyBgwBl8WEBXRA84/lOMcpcI4R8mjgNHWoXZW3/CYzyhxGQTC27yrdP9WDipcx3PwYcxSPPRSnoDE9fPZAT+4MTUMBOjkbxeg2NFc9hEtA+cZqGg5C1hZfXBcfFsTDJG3bdYIC/DC/qZNBGv8lliVzABPzAdipNThIwBJj6NZa/zMOu35thLLRLUuRgEMflQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8d9070-70ba-4dc2-bb73-08de900ec120
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:50:17.6842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ha3bOBsppOFqraKecgwlUToQDCU33l5VTbZAy1zpVKNfUrkU9ZB6MrapmEnvptp63HdcXRfTiAChQMeZQ7XfgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274194-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 79DEF37E384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
ohei Enju
> Sent: 22 January 2026 19:18
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; kohei.enju@gmai=
l.com; Kohei Enju <kohei@enjuk.jp>; Loktionov, Aleksandr <aleksandr.loktion=
ov@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next] igb: set skb hash type fro=
m RSS_TYPE
>
> igb always marks the RX hash as L3 regardless of RSS_TYPE in the advanced=
 descriptor, which may indicate L4 (TCP/UDP) hash. This can trigger unneces=
sary SW hash recalculation and breaks toeplitz selftests.
>
> Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*
>
> Tested by toeplitz.py with the igb RSS key get/set patches applied as the=
y are required for toeplitz.py (see Link below).
 > # ethtool -N $DEV rx-flow-hash udp4 sdfn  # ethtool -N $DEV rx-flow-hash=
 udp6 sdfn  # python toeplitz.py | grep -E "^# Totals"
>
> Without patch:
> # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
>
> With patch:
> # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-takk=
ozu@amazon.com/
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Changelog:
> v2:
>    - Fix max-line-length by removing unnecessary comment
>  v1: https://lore.kernel.org/intel-wired-lan/20260119175922.199950-1-kohe=
i@enjuk.jp/
> ---
> drivers/net/ethernet/intel/igb/e1000_82575.h | 21 ++++++++++++++++++++
> drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
> 2 files changed, 35 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

