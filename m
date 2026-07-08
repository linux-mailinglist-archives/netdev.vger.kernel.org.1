Return-Path: <netdev+bounces-305849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E0RFIQ1dTmpJLQIAu9opvQ
	(envelope-from <netdev+bounces-305849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5061727434
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:22:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DYfOzcsE;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305849-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305849-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 505A5312AFB2
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141D480974;
	Wed,  8 Jul 2026 14:12:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DC47A0B5
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:12:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519929; cv=fail; b=uy+EAkRR90KZUD/odat/2RkHDMWYagp9OmPend2uzhZzf8ah+4LoNXG/J8n7ykZlHX+PqG54yhkvC3TSBof+VpfX3owYZb0QEIVmR+nqaQ9P7XZc+FDXTk9MoVuqmPKVdRmLMTkuQK+PlY8U9Xi6YImSBKj7Gz0hwXfjOlPIu5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519929; c=relaxed/simple;
	bh=riHQCfhRRaLZ/+BhSJ4b19daC3TNqetq3sMoRoKbFE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWe1emNNUKVM5yAOLFr1nzk2KBceS05ulbZfrRUnuqP9wwSfuEn0lddKUIhmYdxfRvaV0OG6wRlxyQD3e9CNMEhV8WwQ3v6af0NzjMkSRqgLYfhCSxmDhQOeNPDUFUrKMjkytoc+QJKKNAKyJ5LiPIjI2ygSoAq3UNbPDvWGBXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYfOzcsE; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783519926; x=1815055926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=riHQCfhRRaLZ/+BhSJ4b19daC3TNqetq3sMoRoKbFE4=;
  b=DYfOzcsE4YmtK59jChKYWFvVRuzNm2zVEkfp/F9Y6EGMYcxLdUsAxOH6
   bEJcckQpZinxJVkkwghFYsYMQsVO2+KjJ7XYLgWNZmiTLWsTYT/HrKR4S
   g5vBbCXqFQJAjkcR/zSvmFExI76tV+EH5I8Epz9pw+B+ge6Mk+oi39Tgp
   cGFoR3CJgrLG5L6jfN1GlAMU+Mzbi+2/GSJFNsRw20tjQhfO+tYmHzA1r
   QM9YfvlKN3r0TIMsa9qqxbHM4eENb1k7NiBgNm7Wjucm7Gnlvvmmoim1K
   /zsiGegZiwffKA2gt7c0wAvN9l6V99I1dUvec5kjbtfPOSOHRRINequvp
   g==;
X-CSE-ConnectionGUID: v1Wy6MfuQdaWBqQKg0V3YA==
X-CSE-MsgGUID: EW5hfownSgK7z/BGWTq0dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109727850"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="109727850"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:12:05 -0700
X-CSE-ConnectionGUID: rSqdQyMKRtWT4tOHEMREbg==
X-CSE-MsgGUID: v44SlSPzQVSSAL3FO577NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258166228"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:12:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 07:12:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 07:12:04 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 07:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwfcmQUavaWIRI4tG7oWHH9p4FUclQR9Wotb9hQgPzsaxwp9n287VqbtPIx7ZecIAyQkvdlvUUkUeSsnEQtLx6dVtHpGmvxvqYuNsT91R2lJRS5zD+9UTZz+25bh2bkEcfM4bcBASmUjn6uUE6mpEtCkYF8bnQXLTcCbbGjKJEGo9Nm73L+J6Oqegw7SkzaXMFR3rPlkJDYy07g69bv59YVyPaKOrz/YhozPROf8dp26LuVR5CewXFY4XdeqO0RT2Xbitkg86dZInOWSFtJ0oAEUMF+MyHd535CYn/ou+iwgavYbxpZeo0c0TlmhtPAg0/w8V4R+W9w4FyIAf9VN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laxnNFpS7Vi1DX3mrIG3OE0ECfwChbVaR1NIF3mm+CU=;
 b=hNXdfIOMESq3lc8QgFUySrX/2EQM1yJWqGhIzvNwkEhYHhTF0YCWK+rykXfvXzHB7QqQJFmrT1pAsgDrd4l8WnYfzBMfDi8AGEOsdeBh63DKqsXzDra01rycLB49KdlnNTlzhyutIyY/PZNPbbIFNoF7Y77gXC39I0p8CvdJJTDVLO6Jm6LywH3aC5v21zQf5N3eZkMLqQcs8PIw7pQUGoRxDeiE9Xg8BMvglzxqzXi4vQ0o67X9MkmrnqwxO3tO2IKl854M4m1GHttcxKs6MXirKt6JYpMiuRB5VB+i9XL7MMQr2c/5IDapCVx6md4eIqbvEOpKsN8KzGIiPXL23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 14:12:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 14:12:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Schmidt, Michal" <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [PATCH iwl-net v2 2/2] ice: fix stats array overflow via proper
 realloc
Thread-Topic: [PATCH iwl-net v2 2/2] ice: fix stats array overflow via proper
 realloc
Thread-Index: AQHdDZucvkDJkTnbH0Wr7c0JBOZxNrZjrCGQ
Date: Wed, 8 Jul 2026 14:11:59 +0000
Message-ID: <IA3PR11MB8986C47DA43C5A358645CB94E5FF2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
 <20260706224346.22546-2-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260706224346.22546-2-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB6863:EE_
x-ms-office365-filtering-correlation-id: f1484889-d118-494b-5ed9-08dedcfae080
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: vU0h3hOfZKnFc9wZ3XA8lBPGRf8l2YfrSquDlJVYpU/sHpr2nehg8nMvQtX8MLAZZC1BO60TnKdhBLTBbgAcy809HbWxz18lMv/Je9pAN2UvRjY55CY8xSi55GPLpQgS8Ds6Z6X1Ky4Cf5XJ3diPIRpwZYQ5nya7bCd/pF+ycLqoDszrQJ2kbwQZkgDikdttGwIEJAMCD7gl3srN26ii0wxURKNsPR2tSGX2HME78IpbV4qk6GqTWW8P7KCWi5P3v+ccmERcZ11/ZYeadeuu0FJ4k5MEBSx72ftSPOc3Nco/RWDXAJ6czSzpw8KCdB6H4G1wMkgwuPe21vfoIqr+v+xuqzxChPnmETG0mRPJ10Jqemz87WqlNLeQBI7SyNgYWTtNx/doWKtNpE1gWxHbD6yGE38OCOtdWa90JSMUzm7mqFwRUfZqYthp/+M34b9DTUwZZRTyT+0IueA2Ilen9XqNfELZBfY6P+8CViT0xnWVZHHJsiZx2IVVGC4FrK55Y9OxaVhqPVhRywjAiaRFqD/WRTWaf7pUAnwM9tkxSvDnO8lCsRV92OkYh/2rNOBAWiV4ZOE0TQ9/FAZaUe1fMQ9Tz7NE1Zk7Eu8iQ/cMNA+Y3bcYnA0DTPad5pr4Vszh3XpWJWmphmV4QJNmwZxzGSZFKnCSbI853fEF87YDqvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rkviAgSrr5v9mUK4PRYIM+dO00inEzPd5o56ehTU30eCHt/BpygOR7YWGfan?=
 =?us-ascii?Q?YRDNHbBGfqtIZmMvwcej5RtqfEym/HRclRRMW8rT86y2AoEoZYGi4UZtwa9B?=
 =?us-ascii?Q?zDlc/2rAWOIkZaFFJiSf7us5iuRinsN4q/7WnL0GGrsyExsTZ41XoBIg1RJq?=
 =?us-ascii?Q?M42XjSxipHN8Kj/BxnxolJGlRUTkijq4jzR/q8FkQNCn6M4wkjKl8HZD4+rn?=
 =?us-ascii?Q?OomMXedhbqyyy+yabPD5uyMJkX8ljYhNbYcdD2ZsGQuk8Q2ZgqUredXLKsbR?=
 =?us-ascii?Q?myTn9MoouohhzY218ABnHC+WCuKN36w08haqsqp8iii5lfpeEJC+s7X1M5GI?=
 =?us-ascii?Q?Wn3+zRc8Ecrdgvw4F8rJ+6Nrf5K08Z5vGIkxFunRPXZepT4HWqYmxfDL0LN5?=
 =?us-ascii?Q?cNLjyTZnnyfuko550iOQDyh9xOKeTjab+cC7f7V95gZ+R/RikBPbCqVdkasf?=
 =?us-ascii?Q?eVQJiyeGnpBTMPcdfmDcYD8tuZzJtWQhE9ZG/QR67Vqecsl3aonQ195DyqE7?=
 =?us-ascii?Q?vTSwZ17Bj32ZeD6nRVeFo0CoKDZbAyisf3otwMWcBFvGwaZjuaT2dmLhquMy?=
 =?us-ascii?Q?uauMaFdT1Aw/INajgp4RzmSp+j6Kn7y1m5bogE/N8jZxN2x6YpAYw3JIWgFo?=
 =?us-ascii?Q?zCin0rNqtuoGUN0yJFPUSCgJoQeXdZoAUUs/sgpMDdBk5SrVoO1oc2xmZnl6?=
 =?us-ascii?Q?yPZnnBayVxMCf+crMw64jtBgjh8BH516ir9V1o+/MtHSS7mn9q+GJ80QqFRW?=
 =?us-ascii?Q?Qa0RImBnTpf/FuTCN3cTqyAvSU6dbZO4ONWSr2egr3y7OpDCHrXQdAXlMrGW?=
 =?us-ascii?Q?GTRYOFGb62mlYbc3Bm21VfHEVzJzUwdzyYiPoG+4bvc35nsXlhFIlukbOaWK?=
 =?us-ascii?Q?waV4/pnRywZER2598IJuTKWOiLLah5guNeqSldeFA/GiL1MoeXRiBe6PIcwC?=
 =?us-ascii?Q?EDk7A3bNiOtjgChWFAewvSazsKb/XRR1EUYiFWcZNHNTAhpH96gWx0pQqXXV?=
 =?us-ascii?Q?Plri3imiQVL/EGcf/41wj83mqGdyXTEU/zoYl7ZXLIsOl4zygZDUXw1DfEju?=
 =?us-ascii?Q?AaUGBQeMtGmmjt8j/DAtPzwjBlgCRWT/1usAnaWixM12UF3GkJciAK/m++z3?=
 =?us-ascii?Q?Der8wvmbSJF+ghL/b1oe2pa5nQlKgCU5y11hcqQ43BKPzOTMmM1gWI4qrngF?=
 =?us-ascii?Q?ZWVRJ5s0L/2wwvQtRGr+ZNoDlGoGi/81DvkdgJaukotz5+LHCxuC+9MP2fgH?=
 =?us-ascii?Q?wDQ5OpUKRe5iAM59cirP207g78rksfZnqB+jwXLq0FD1XuOlu+tsi3FaGFz6?=
 =?us-ascii?Q?u5L6pKK+VrZgXlnL0Ap9pYkGuhV1hKVGctfCz53TPUJDhixuvZ52j97/Y15d?=
 =?us-ascii?Q?PdcOrgDyiINUjHmEZpWVaynm6GthfQWoxYqpWIKYd07ykg/50bWrJZlQnEUt?=
 =?us-ascii?Q?V2OQybefYGf+zyjztEZh6dQhNA1nxm7dYa2JRr37kIJU3qjYrkOFH24IEKul?=
 =?us-ascii?Q?hNIVVIZgc3hYgX80sSLBNhWNf83fv29MiquD9FLl3VD2OG66GEadl4cwfxLI?=
 =?us-ascii?Q?uVnnXe0v+WqUX+MxZPLabKkn6o8GgRtKXLJkNaj4DjqOG1Tx2ZOC4F+Gq03Q?=
 =?us-ascii?Q?wDwBIU4GYG1ZV34ZQCXfQlOXum9Bhffr+BtxueIZJgGKGfS8bXuRUrExtL+4?=
 =?us-ascii?Q?xhZ6A33/ISJBmM5FttAVHO8zcgnCrktaB0hvUUlbkLrCZ0lDN4AXwagBnGAj?=
 =?us-ascii?Q?7kOMxEIEB/NgaBYRyBmdntd6PzFrNLw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FlQfXIw8ajfZX4hZ+s6OV7gvgqRGhzSUro9esoUwd2tddZ5maMXE/A7RKJzSE2zlcvpCHUhdyg/OgeJRm4XqYYClx8rhLFY+DgylieJqpyxvoR+xhsGVXbERwmb+fNqLt4Bk+M0oYOZg+brvQam24z3B8SPKBZYSfCIhYDDx+rY+/vb6jyMg+ZkYWfwbW50sqrwxVLCOCcGTdCRB7+x5ARL81SuW1DH+xyDFHZgdnVOvDK2dnEU71aWw8m6YrQ5fdeoPs/OQ3c9z97X/ma9wN373c5TidS6K+k1+CcbI6Dz/QBSE1ZQwID7nqHhsXZrkpqo0fbO/SovqOInkQisY+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1484889-d118-494b-5ed9-08dedcfae080
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 14:11:59.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycmjAY17eLFD8JZsZRskRSTqa1H/udxMVRrD2VbWzS9kReH4AaLwgpB3o7DPKeIhQCsuku6qItxciRVwTtHUK+6Agh0C0tsDe8m4KJ/mjBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305849-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:mschmidt@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:marcin.szycik@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5061727434



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Tuesday, July 7, 2026 12:44 AM
> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [PATCH iwl-net v2 2/2] ice: fix stats array overflow via
> proper realloc
>=20
> Integrate ice_vsi_alloc_stat_arrays() with realloc variant.
>=20
> Instead of keeping two functions for stat arrays allocation, change
> the
> ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
> entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
> ice_vsi_realloc_stat_arrays().
>=20
> Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as
> they were in the replaced ice_vsi_alloc_stat_arrays().
>=20
> This is a fix for stats array overflow that occurs when VF is given
> more queues (an operation that will be more frequent, and by bigger
> increase, when we will merge my "XLVF" series).
>=20
> Splat for increasing number of queues thanks to Michal Schmidt:
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
> ffff88810affea60)
>=20
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
> ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> This is an alternative to the fix [1] by Michal Schmidt, which were
> blocked due to AI feedback. My fix was already developed before
> Michal's, just not public back then. We have agreed to go on with my
> version.
>=20
> [1] https://lore.kernel.org/netdev/20260520183501.3360810-3-
> anthony.l.nguyen@intel.com
>=20
> v1:
> https://lore.kernel.org/intel-wired-lan/20260701104141.9740-2-
> przemyslaw.kitszel@intel.com
>=20
> v2: Sashiko:
>  * defer pf->vsi_stats[vsi->idx] to be done only after successful Tx
> and Rx stats arrays
>       allocation - this avoids "half initialized" state processing in
> ice_vsi_free_stats().
>     The above was reported by both opus-4.6 and gemini-3.1-pro. All
> other errors reported by
>     just gemini were a mix between false-positives and too-
> cornercase'y. Gemini report for v1:
>     https://sashiko.dev/#/patchset/20260701104141.9740-1-
> przemyslaw.kitszel%40intel.com
>  * store also array lengths in separate variable for better tracking
> and proper freeing.
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  2 +
>  drivers/net/ethernet/intel/ice/ice_lib.c | 80 ++++++++---------------
> -
>  2 files changed, 29 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index f72bb1aa4067..b63b59f2d203 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -328,6 +328,8 @@ enum ice_vsi_state {  struct ice_vsi_stats {
>  	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array
> */
>  	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array
> */

...

>  	if (ret)
>  		goto unroll_vsi_alloc;
>=20
> --
> 2.54.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

