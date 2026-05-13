Return-Path: <netdev+bounces-287387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOhHC7jYA2pb/QEAu9opvQ
	(envelope-from <netdev+bounces-287387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B952C132
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9516E3005328
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A91D63F3;
	Wed, 13 May 2026 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciGzO7AX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18B37BE74
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636481; cv=fail; b=DKqLvzZjZQaO91KEaHl8FZI/rkSWPIUiRUF/fpq6KBTsU86Rnm5IiUurai6flW/0iS49SZsBRqmHFLjDCUQkZRzdKsJlker95kCABSTzs3ZUOT+1qPDY9T3Aq7DpTCFB4ag7CvgfbSBxRg/RpFoVWwUPrltuSYcfA/2Cmav7XEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636481; c=relaxed/simple;
	bh=AhmiavBEq4grkFkKYz56UjucUqmRQ/NIItC9UjsFgOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WwLdVsXTWUZYgHemU23MBRKkikYJ2vWh9GoQWreOiqMszCms/kjTT8IPrVjMkHtNbeE/s3Hu+wWN9qn2T7YHfQdDaMLjC6qiuSILhFKmCO0Qoc92OdQmKNp/5+GqMf0eg3dNDUTiDyOY4YykQx8zMrV0XoBl1vCwrwBTlLUzUYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciGzO7AX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778636478; x=1810172478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AhmiavBEq4grkFkKYz56UjucUqmRQ/NIItC9UjsFgOc=;
  b=ciGzO7AXg617sciCEg+Wwb5GCHztiIEVhUon9NDtDLlUPg+he5Sxr9Tl
   L1VOYlMaDNKuu5aHmINNeDWoUdRn54YAIG9UwEE+/BbptsQfMX9EgtwjM
   h/OBGGUbDY4awOLJoaW9PBOe7TivxShFCdQr7n/aUax0dTef1fsRiASHD
   14PsNmU9dQhcpaB0wv57ccpYqeOw/aby7BjhygNiYeu/t1AQ96dthRLWg
   nDi/ar1Lpec0LdemQHEUYx37t7CWMDG+sVb+oD8vxxeJsjcKEZl3cDpaG
   u+ALQRjOFhmw29pdcmJ3e2N/DOLuTB7kPOku+DLS/rIpF75ube9VrmrWB
   A==;
X-CSE-ConnectionGUID: p7m66HFATMiSd9Y4JQxavg==
X-CSE-MsgGUID: bD/LzUnhQZG11KG3YEccww==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="89859222"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89859222"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 18:40:49 -0700
X-CSE-ConnectionGUID: j692PkdkRR29WuhdtrSuvQ==
X-CSE-MsgGUID: RSGxagBpRlqXcMY5m8nCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="241958870"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 18:40:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 18:40:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 18:40:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 18:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niFTyb1SZDX7I7dg3EAVUnNFM6uRvCY2ZlGI3vIXOucO4nkI14zekfFuicYUDWNEqdz+qjLBnwUR2xZo7p9Zzw7P51h8Nxft4YpDC55+ldt9hnBNTtq/Mi61PvRmo4kzRRA2uiO9inagzBqItzMBtrwuM2Hy16aL1MqgzcPTaPjXa5PtJA8KKYkPvTfh2TFjm30gnLsmSzqzGy5mO6StNK5+Czw7ej9goTK85Xgqv4Bco4Sdj1jfLX1SsLI4EjkiTQcNrNjf0FiVzrrUZuafe6Ql/AtN1KtxkFg0OlukZrXm0ZGQohQFeyERdMYOoXF+MAWz6n+8CeAEVYr6iheUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf3SNCG8RlHM6pfrXr1GTNeGwQNIQx6tEB6sz6rtjso=;
 b=VitN4ExSapHxs8eLzsw9jrZ6g2rkKIGLF1I0qLnEt/kBQCoYkwpwKSfKhMlgBqIfvrhiir6LuWiHXRG7N4VlUqRADb3gJscfrtel3DKiqvw1s0mlgvzDuhMXeOR/aZswjoxEMdsg7sEHjXjFHmQgjW7Dt2rYf4ebG3+o+X6lNuNrO52L31pgNeE5W2ur2E8pwbXNqUYNYtOZtSiyXTimdMjPRAw7Qmv50O+vtRa2A1mLZD37+klUCkZEwYa1yNzDGelVWHq5hcZrcxFqwKnYWSMd2k9gEZ9FRZNr5y/GO/FZEbSwvEB+8qQsrhUOOmsNjjG/LsrPnFa9/UyOcSLG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SABPR11MB9940.namprd11.prod.outlook.com (2603:10b6:806:4ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 01:40:45 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 01:40:45 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Vinschen, Corinna" <vinschen@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Vinschen, Corinna" <vinschen@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ixgbe: only access vfinfo and
 mv_list under RCU lock
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ixgbe: only access vfinfo and
 mv_list under RCU lock
Thread-Index: AQHczjveydXAcYSWzUqExiQwIvubNLYLVgSA
Date: Wed, 13 May 2026 01:40:45 +0000
Message-ID: <LV1PR11MB8790EB3A2DBAD68676B21BB990062@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260416084227.3787828-1-vinschen@redhat.com>
 <20260417072828.3887753-1-vinschen@redhat.com>
In-Reply-To: <20260417072828.3887753-1-vinschen@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SABPR11MB9940:EE_
x-ms-office365-filtering-correlation-id: 7519f3bf-0581-4939-36db-08deb090a6e9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799003|38070700021|56012099003;
x-microsoft-antispam-message-info: 6yEkYLou9tijQkH3w0G8EPNuRZ8fO3vZlhjz+6+RELeM7WLnfnHcJtaO6NROyYZcBdhllyo6BEjWmKYE50H3wNymhtRXz/dXE/MAEYguz9ML6E2kMRuZsGoQdi8hyHw8gC2kEDQ3qhxYzkZKtFh1hO3i8zmvggkXXVg1AfqtEkIhbokZ7zu9SK55TdKMpuwOxwPHXLVShL0hhAKPYZlp0JUfYp+9Ex7xxa/+KPIkRlsR8UpKKJAnEYZ/zTRcdnoflCGhbmXojP09n/kqie2PR6RyP8BUsSVU8ucAEWyhzo99pSndPS4uFFmXBG6LZ6Dyl2cKcgWE+s5hxYnOfSYaJaZDvpv2csbm351Zo+GdcUzlWxVv121vO2mhcUClstJBabQkiTiqHvRH+tmq4rUDP4npoiYAAUFPgG/3n0uBFW6yErgolYdrziFiL2rkdWQH8c3dE1+520Q/MdbZOxyLowKK1ph7Y7R0Op+kMkWv7TjuIJza7BdYIUNQ5T+YSETzQxVzU6+C8fjCR7chNaGtw9WOSQDdCg21MhpadjnJZWAbtgR0bxK4rolIm51qSYdmI/AtOYQ4ZJby8N0qfU/XeWoXt4dY0EnNr+eyPVXw/ZB87q4M6vDy+ay4VhokJC44HqyBAp9bW81iT2uBRGD2l38a3y/cnPpeHAjaLmZFrbg4yfXAfNxkpt8wprk4XI6OLXOcg1/a4bB7ffdL5HSf0Y07+XtVSV8OcNiSTj3xBpprNZDz3Zw6Oo9km3LOjG3V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TI7lAedmllWDV9veqypEYY676Ecweqh53OkUGyL0EEgUZObZtbWnzrTbiM/r?=
 =?us-ascii?Q?WEQQS7yKQ7DNy8AMFUVKFQ6HFfErZk5xlXwEF30bN7onLtRNo1zJtoIgaHj6?=
 =?us-ascii?Q?t0M3MH0Kg+MT1UGGee6UAQO1AYQAoYYSDHeIylA3ahqilhunpsWzTjrEwXxG?=
 =?us-ascii?Q?SL/ysfaVo8Pv1ieshsrhhsgrhfqOloIsAS/qTQt49dTWnsgDiOD0mO2GOrz1?=
 =?us-ascii?Q?Zl1pDRPOIMKVZJEt/boeF8ozNHinCXIhO4Fm1cvmk4aDdqiJ4svUCZ39sAiU?=
 =?us-ascii?Q?q9Ly1Rb5lD6b0Xc9vWrHfLWq1QlN2YS+pgtTIlaBEb5W+qTCSZ5E40GQ3WFb?=
 =?us-ascii?Q?d6dTzCQNA4E3PCWhhg4bAgYxrrMEUL9HrSEwBYGc/nXSlzLzzupsH4uvL5Q8?=
 =?us-ascii?Q?mGmuJAucq1z6+3Zsk31UAS9EGRoq5b5PCXejvL2jvBUp/cLA+qmOWt0sbNQT?=
 =?us-ascii?Q?UFTd5xpxBxq2qZK9p5obdrLZ2dU4DT2kVKNMPevVQnh4QMYEm1KhDPVnthFV?=
 =?us-ascii?Q?lMZsA35zwAKo8ZHmweDANSTZSGR3swvqLwbJUCmAIl9hWmMWNENTJs9f8bxm?=
 =?us-ascii?Q?+wmndUZX26ZcSnYfiHQvFnrHFwICzWMR1vKnsO7k5H0eFv8OSQ4W6ImFa/K+?=
 =?us-ascii?Q?D8764jHCAGTMNPb/zYPgcny7byP0KGELXAnWaDfHBbJANjdybxibfjzyKi5e?=
 =?us-ascii?Q?nAGAybGpOUE1UQ6M5ohtVHb5KJkyV9vFyxp0bCn1Ubi+sX7D7hU1Tpi5qZI3?=
 =?us-ascii?Q?dHZQ+S2GDA7n7AudzaT9z9vp6q91T7xD0AVGnNyCwGlRy/jG/bJjAQbUlXfX?=
 =?us-ascii?Q?20BmPtFFlZbqt4xkEKaFtkyl2NTiRpmDo5miDHVWEfl6yHZGPBrwOYmn5Vpa?=
 =?us-ascii?Q?OW1H9uHihr0zLFPuf2/akiKyxi9iHRtuAThu+HlQ0fV3BJQaIydDk9DPRA3P?=
 =?us-ascii?Q?P+LZPo7mV2Qj5ZzG5NiS0SEmvJQDLaEWIlNnkuZ6W4iC1NgrXShoQ8xyaPKF?=
 =?us-ascii?Q?pqBXVLgUtgIpoLpPclAkgmR9x6cEY317WwDfUW61U3x5YHElJU268P0OgIMB?=
 =?us-ascii?Q?yOaHAMlmLDnpAOGa+OMPe5zVAC6eC1GGVnzVAq6VeMs8WCetw3xc7nDViN0g?=
 =?us-ascii?Q?Z6klhBE+63bLWHKzSZZdmoevE9C8fGcLicG88ZwnH4cnZcHUsVbr3OCTuIJT?=
 =?us-ascii?Q?Icm7d/Qp4jTXXymKGilXXXp2Qu9z749kuarnbDcDXFmcqDLwIO8bcI/YGo/B?=
 =?us-ascii?Q?qT3fDCFJtHYQIU6FX1kwFeALNhD+KcQCgEqKm35LSvVHen9HdICb8uzbsyh1?=
 =?us-ascii?Q?kyVzSwUzNhTxbweoaLWK+AbKk/siDdmB2ANBNnI1AV4MS41f5xy7v2MJ2io/?=
 =?us-ascii?Q?oY1zufdj5ClfcnLtbngunkE27dx5EnXuseHcPlYK/uwpqocwzrmFH/EPQAXy?=
 =?us-ascii?Q?3HBuWE4O8ohuP5D7+3IZ1FWkX1GJV4Q6HvHV0Lv7wddr2xGA87owRb9PTIki?=
 =?us-ascii?Q?oNlz+rVLI00g9TlhtlMTnQB/srKfTQWKJb8lzsKgTAkYM2r6G5jslSkH2zIE?=
 =?us-ascii?Q?xM5aSCEi32LxhR78Dq+HtTnZWXzGSzyVfxYIyMegpdHIwEcfLzqkHF39hSfM?=
 =?us-ascii?Q?ZwgsSfrQNH5Zc/dfQ0qRawe+rvLWHaVPGD+ijE+Re48cT3PmyQARTpDLpT7l?=
 =?us-ascii?Q?UA1N4SYY6XJJsxj4DzjcBreCH9oVts77S+VygOlqOk78vWMLrM13/gXvNIO1?=
 =?us-ascii?Q?NDJ1qHGENQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AeWN10mpCvxrVWqMktB1X/7LgAs5e6nBPUHE8c3vgcSF7VsVwdJemhRw68ApZzaAA+wsw5nJKe890bqPCJnaJ+nEeG6TnCbUoQpzJOj+l/zDQ3HmBu77EV6FoIo/1C9RrMzXrO/IoGizprOcqT7M6q1TiQTEvlSnGiL8w2bPwsgrJFHtyqdbhxYm98LKfClHtLKiEgYbpJtTazZBndLARoEsi8g9yamzdheTKw8ro//Xg978z5X3XuNnlh/vDnMDIB9ucwhVuF26QeZrGRWPfZ1T9gTYeKraL/bPTBjIWiZBiO2Ov0oY9DUsmS0vlVqKzdAyxdeE2R3NqgaHwCKahA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7519f3bf-0581-4939-36db-08deb090a6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 01:40:45.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSq6g3VnIorrzoshz4U0OJ+ex1ywMpXHiLt2evwVJbClSqySX626xYWn3LN15y93duoBfiagMakRXzIocvp8efAeRVwzW6xRG/P744YStHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9940
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0C3B952C132
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287387-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osuosl.org:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of C=
orinna Vinschen
> Sent: Friday, April 17, 2026 12:28 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Vinschen, Corinna <vinschen@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: only access vfinfo and m=
v_list under RCU lock
>=20
> Commit 1e53834ce541d ("ixgbe: Add locking to prevent panic when setting
sriov_numvfs to zero") added a spinlock to the adapter info.  The reason
at the time was an observed crash when ixgbe_disable_sriov() freed the
adapter->vfinfo array while the interrupt driven function ixgbe_msg_task()
was handling VF messages.
>=20
> Recent stability testing turned up another crash, which is very easily
reproducible:
>
>   while true
>   do
>     for numvfs in 5 0
>     do
>       echo $numvfs > /sys/class/net/eth0/device/sriov_numvfs
>     done
>   done
>=20
> This crashed almost always within the first two hundred runs with
a NULL pointer deref while running the ixgbe_service_task() workqueue:
>=20
> [ 5052.036491] BUG: kernel NULL pointer dereference, address: 00000000000=
00258
> [ 5052.043454] #PF: supervisor read access in kernel mode
> [ 5052.048594] #PF: error_code(0x0000) - not-present page
> [ 5052.053734] PGD 0 P4D 0
> [ 5052.056272] Oops: Oops: 0000 #1 SMP NOPTI
> [ 5052.060459] CPU: 2 UID: 0 PID: 132253 Comm: kworker/u96:0 Kdump: loade=
d Not tainted 6.12.0-180.el10.x86_64 #1 PREEMPT(voluntary)
> [ 5052.072100] Hardware name: Dell Inc. PowerEdge R740/0DY2X0, BIOS 2.12.=
2 07/09/2021
> [ 5052.079664] Workqueue: ixgbe ixgbe_service_task [ixgbe]
> [ 5052.084907] RIP: 0010:ixgbe_update_stats+0x8b1/0xb40 [ixgbe]
> [ 5052.090585] Code: 21 56 50 49 8b b6 18 26 00 00 4c 01 fe 48 09 46 50 4=
2 8d 34 a5 00 83 00 00 e8 cb 7a ff ff 49 8b b6 18 26 00 00 89 c0 4c 01 fe <=
48> 3b 86 88 00 00 00 73 18 48 b9 00 00 00 00 01 00 00 00 48 01 4e
> [ 5052.109331] RSP: 0018:ffffd5f1e8a6bd88 EFLAGS: 00010202
> [ 5052.114558] RAX: 0000000000000000 RBX: ffff8f49b22b14a0 RCX: 000000000=
000023c
> [ 5052.121689] RDX: ffffffff00000000 RSI: 00000000000001d0 RDI: ffff8f49b=
22b14a0
> [ 5052.128823] RBP: 000000000000109c R08: 0000000000000000 R09: 000000000=
0000000
> [ 5052.135955] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000002
> [ 5052.143086] R13: 0000000000008410 R14: ffff8f49b22b01a0 R15: 000000000=
00001d0
> [ 5052.150221] FS:  0000000000000000(0000) GS:ffff8f58bfc80000(0000) knlG=
S:0000000000000000
> [ 5052.158307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5052.164054] CR2: 0000000000000258 CR3: 0000000bf2624006 CR4: 000000000=
07726f0
> [ 5052.171187] PKRU: 55555554
> [ 5052.173898] Call Trace:
> [ 5052.176351]  <TASK>
> [ 5052.178457]  ? show_trace_log_lvl+0x1b0/0x2f0
> [ 5052.182816]  ? show_trace_log_lvl+0x1b0/0x2f0
> [ 5052.187177]  ? ixgbe_watchdog_subtask+0x1a1/0x230 [ixgbe]
> [ 5052.192591]  ? __die_body.cold+0x8/0x12
> [ 5052.196433]  ? page_fault_oops+0x148/0x160
> [ 5052.200532]  ? exc_page_fault+0x7f/0x150
> [ 5052.204458]  ? asm_exc_page_fault+0x26/0x30
> [ 5052.208643]  ? ixgbe_update_stats+0x8b1/0xb40 [ixgbe]
> [ 5052.213714]  ? ixgbe_update_stats+0x8a5/0xb40 [ixgbe]
> [ 5052.218784]  ixgbe_watchdog_subtask+0x1a1/0x230 [ixgbe]
> [ 5052.224026]  ixgbe_service_task+0x15a/0x3f0 [ixgbe]
> [ 5052.228916]  process_one_work+0x177/0x330
> [ 5052.232928]  worker_thread+0x256/0x3a0
> [ 5052.236681]  ? __pfx_worker_thread+0x10/0x10
> [ 5052.240952]  kthread+0xfa/0x240
> [ 5052.244099]  ? __pfx_kthread+0x10/0x10
> [ 5052.247852]  ret_from_fork+0x34/0x50
> [ 5052.251429]  ? __pfx_kthread+0x10/0x10
> [ 5052.255185]  ret_from_fork_asm+0x1a/0x30
> [ 5052.259112]  </TASK>
>=20
> The first simple patch, just adding spinlocking to ixgbe_update_stats()
while reading from adapter->vfinfo, did not fix the problem, it just
moved it elsewhere: I could now reproduce the same kind of crash in
ixgbe_restore_vf_multicasts().
>=20
> But adding more spinlocking doesn't really cut it.  One reason is that
ixgbe_restore_vf_multicasts() is called from within ixgbe_msg_task()
with active spinlock, as well as from outside without locking.
>=20
> Additionally, given that ixgbe_disable_sriov() is the only call changing
adapter->vfinfo, and given ixgbe_disable_sriov() is called very
seldom compared to other actions in the driver, just adding more
spinlocks would unnecessarily occupy the driver with spinning when
multiple functions accessing adapter->vfinfo are running in parallel.
>=20
> So this patch drops the spinlock in favor of RCU and uses it throughout
the driver.
>=20
> While changing this, it seems prudent to do the same for the
adapter->mv_list array, which is allocated and freed at the same time as
adapter->vfinfo, albeit there was no crash observed.
>=20
> Fixes: 1e53834ce541d ("ixgbe: Add locking to prevent panic when setting s=
riov_numvfs to zero")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
> v2: always return 0 from ixgbe_ndo_get_vf_stats so as not to break
>    'ip link show dev'
>=20
> Interdiff against v1:
>   diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/ne=
t/ethernet/intel/ixgbe/ixgbe_main.c
>   index 6ee8c2a140c2..e0a986f1c96a 100644
>   --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>   +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>   @@ -9797,7 +9797,7 @@ static int ixgbe_ndo_get_vf_stats(struct net_devi=
ce *netdev, int vf,
>    	}
>    	rcu_read_unlock();
>   =20
>   -	return vfinfo ? 0 : -EINVAL;
>   +	return 0;
>    }
>   =20
>    #ifdef CONFIG_IXGBE_DCB
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   7 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  36 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  44 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  17 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 227 +++++---
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 547 ++++++++++++------
>  6 files changed, 592 insertions(+), 286 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

