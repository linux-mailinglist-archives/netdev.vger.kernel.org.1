Return-Path: <netdev+bounces-307019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KVblFlaIVGrvmwMAu9opvQ
	(envelope-from <netdev+bounces-307019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:40:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D1747987
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lzqaW5zo;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307019-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307019-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 659AC303283E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2B383323;
	Mon, 13 Jul 2026 06:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66E3859EF
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 06:39:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924745; cv=fail; b=GehraYQvEy73YzqYWP30alBgXMmyYyNYKQw3sI9upKIStzwy6/IQiIH9UVxG4d8nqIOPxJY53eD0d2nnvqd+b7Nya0b2fxlYP67P8SqxmjVoIR8Kcdq6rPcxnZyFJM6REtbjsuNawim7SB7Rsw9KN3suxyfC4bls3KYYD+6ZhWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924745; c=relaxed/simple;
	bh=5rWnGTZOck7FfBYBGlWzrM7bC3dWWjUhgoSnZfS3Afo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dj/MUvl9dEWqFzzBCJX+VEkhWqKZPtCcdL+DK+NKa4LGzr+eguPMVSCfbbD79TGL3VWQVoHO7TEDz0m9Ar8Q75vgucFaf4TGMAq7XzDCUoNgk7jXwrsQZ8ipKGottAuFsf4UY6EDHhNlUbnu3p7O2vJMUW946CWOeA3+LV+qxKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzqaW5zo; arc=fail smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783924743; x=1815460743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5rWnGTZOck7FfBYBGlWzrM7bC3dWWjUhgoSnZfS3Afo=;
  b=lzqaW5zoZ60+qqwFiiyWJ85seyJlwgRjku8FzHpyeP89GRTDdV9J0XTm
   R0yrjDabSvAlcK8buttc68ZrC/FJT8QwDXZJdo+0bdstKftfcY6ozJlEa
   BVG/mi3T/f7gpCw2tb85pgwj/DIjwhpU0DxvTKfOG9++sJrkaV1oBReyT
   5ZFDOqKMouiC6LU44aPRu/b21XNXy/I1euONstliRjSX56KMb7Gsmtbvi
   5AJ363HkjqahaIpnws3DgEALd5O/efaai5JFbo1+fcryKsKx/jqVhsaZC
   9UEuSLv5ExLQDacf7AA2od0p9zxwWcW8FZ6cxOvmL1sYgrTlZ7LSbtL9n
   w==;
X-CSE-ConnectionGUID: xjkf6PLWSiSdDOfDw3v4LA==
X-CSE-MsgGUID: s85cMYsNRYW0A1osFZfV3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84576944"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84576944"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:39:03 -0700
X-CSE-ConnectionGUID: s3J8U3OETOWlNX2UJ+senA==
X-CSE-MsgGUID: JPylYRXiScmVSlwNSosQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279874157"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:39:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:39:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 23:39:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iz412hUQRjpNKFWsXtE4q/Negzy614x+tutaI2YXCBS8KdW3el6YSmvs8/GmRI30aV5fjW/RihcD6GvMhXevF27FJC5Zmmulp++noZEKglwsXCvueTh3QdvV6NGPaR86dWO7LKebUqKDdT2EQXFkteQ0ksTDYZZObe30gbCAzwRZYjywDqZ5xauZO2dPXc2jb4Lcqqjz0Lr7ni27slJPaSogLJuDrjLnwEZHIXnPQ8xaIe8mictPFt8/mt1+bTThpSTqG893zdhm+3kSO9sDN5olA7uYjnhAckkWO1YCSwOpl1+1JSwaedi1+j3SdYQ67+90gUXPq//HJertsM/xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rWnGTZOck7FfBYBGlWzrM7bC3dWWjUhgoSnZfS3Afo=;
 b=ixYuvhDQ6jkJUkTwi5hW/4iYCK1ibznssCI2P8SMhSviDkxZWxtV2CKX2o4SXxtFWjdaiYJyQV3WlGxHQbFD1iNWQkFv+aqWbrhxSMEHdNmTi1IRNn5RoWPpojKvZypajXn6H7GAdyTVNQL4k0ilDgu51DzlvTQh662UhvKhGuEctyHvoKe2LuQyTG7c/nE8K65OJIMzvm+tv/zrIiF1LNM8h9TPkcZxMSNm9g8RNH67cdO2iluAesu4IFw1cmiBnP06ZJWKk1iFl4haVYBhGdpehEL2ZuoMgFZzFrf3LCm202NlzTYlPfBedHQ/gjXD601eyxhjECbeBJjacb5vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA1PR11MB6709.namprd11.prod.outlook.com (2603:10b6:806:259::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:38:56 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 06:38:56 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3 3/3] ice: Cache struct ice_hw
 pointer for split register reads
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3 3/3] ice: Cache struct
 ice_hw pointer for split register reads
Thread-Index: AQHc8afpIYeL1U5kak2TcHrkU1qPBrZrP6rw
Date: Mon, 13 Jul 2026 06:38:56 +0000
Message-ID: <IA1PR11MB624177DCD5CED233C7E69F6C8BFA2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
 <20260601091951.3017848-4-sergey.temerkhanov@intel.com>
In-Reply-To: <20260601091951.3017848-4-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA1PR11MB6709:EE_
x-ms-office365-filtering-correlation-id: cd2a8b9b-f0bb-468b-f344-08dee0a969cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: ixkQZ1uopqENCaSEBqg9haUTGA8FFnJFvQQSug6AV8RL/GH6G5mXJlJ1SnAgLnyaaPr8wYaAm/QA4qV8FUHsItnHO77qmHQyW1IhBniH2oa45KJEwSTZS1zDtoGLzJCV+P0rcUSEsYbCI1/WnjK75cOn/oOdn4nLAKMmMJWi5zn5cw8xaDxdNM7kPMDAjicKcMiJ/k6fNET0Bquel+EMsrpv8LFV99jiAoCq9+o2Vt38bSIMWD+Kg/xTKTm1CYIK++jBYWM4hB1+ZGOpL8NlfywKBcmr/fjVI2juKjmbJkwSg9aER7cX+rik6jFt/LPaGhNH+Kown+YZEpepLbggt8ymBpV1BEMA7ouxtDdHwzfRXbO4obsEsuoOSH/8bW9XWG1jK5avTtUc2PzF6QHRcD76Cr8B63LcliNtEjB7aUGJ9oD/nyGgXVGsKlpSg5OcOBcpmHZ0i3OP9AvELt2PTdFG0GHBpVVf+6iSmol8k42fPKQw5JktExRCykl2Ndn2hWK1uMvMOZN3gM/FXFptDPLousu/s3bp9cM//qIHsYh8CMwgGlz7eWzb1RagrwAIKFhObSgB1LQiQe6gkDG9UYM73n5QlBO9Oo7s6miY0CcpiMEl8gDYCCAYAi7T/0gKoqt3GMxa7iCVYulNK8wGezkFKuajqvhk1THJkHD1Y/d7m9Vxy/lx+pPAxvv0GsjFo7MPB+feB+3GvsAqLsstJ0D0YT6ijsnJTPC1lcWPOsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3HDqTIBWG4cPSwHcgBO4wPxdBNajIMtsYXFNRIy3zRcdnj/aIY3pIzJAtNuQ?=
 =?us-ascii?Q?A23zOQ5JwDJQ0ZcTK9lKqK7BbALUkyns0kGGqjztQqXwP6plWjdXzZrfZfvA?=
 =?us-ascii?Q?tjB+NKmamMWloEGaXh+8xRs7qO1msve0dNMQn+ITT2XLrI1mGWt+bQgvcoLb?=
 =?us-ascii?Q?8hmnXPJDGlHM0HtGNkEZM0ddDcSes6LJPtTMiQoI/oeeklcYNCQpEXQZCoJf?=
 =?us-ascii?Q?8WM1E1EAYoRV6q3pcQ/NErCnky/OSvLcrGv3ipa9DtUQdYjMYJxCqQl4nxnx?=
 =?us-ascii?Q?rGuaoZlq6haZODGEyLn1ITq9GhWQeuGLaMDGRk31hZsdxL9+SxVbPXKv42Hg?=
 =?us-ascii?Q?BeQGVFJ3TG8Uuii/rC2qd7ykLqd+3miA8Ff8GXoTZd86nZUgt0QPaKgiKedB?=
 =?us-ascii?Q?OdwKn3WgUW7xa5qUpXOU+AaztqYwuYc5ChlxkL9Q2CyFPWzwVsen0hbcvwWK?=
 =?us-ascii?Q?p+ftstjVgKSFbXkGKrAzBpWKon6FHyCVWxJ8NEq+FiTVub3nh9HrShMCfjgQ?=
 =?us-ascii?Q?aYKjDH/3Lzth+qU2pA11dR6D2F3NcYGacgxLUkr313koHWyDfkLaaobSWShy?=
 =?us-ascii?Q?1qrcMXVO3meYSGuKDGBHDFHc+CdCEDqeoZm78Hcp/plaO4XO/gU3trg4eobI?=
 =?us-ascii?Q?dVnqwurzsT5eHiC8Lb/0woT0y67rUBqU3ZXsR/iFGtk1pwdglilvzij84bkO?=
 =?us-ascii?Q?u/WqYeoabyP8LG/mJ2ZcwKIcx+hT1lZj8W2SLmEg6t0MGGcMgN5XgNFmVX50?=
 =?us-ascii?Q?Ki/X5r3iU/l49yhSUBUvczW3VTy4RTltfREgPWS4Xr+kZaA6EgeI36FqgJBB?=
 =?us-ascii?Q?7cT/LDfRdriCHof2J7NXmGWUStKmWgCSHMeh2jgR3rqaHbAA3uEIVZytT1O1?=
 =?us-ascii?Q?KMF4mignAa3Z+HmB6yN1+OjQ17TuTv+Ci4Bcz3x8Fh/78O7rimz5B/2tTtke?=
 =?us-ascii?Q?mMHRyK3Ry7qHQGB8OFXltCFoVySaBhX9TpicztwSuLoZm3O85A/JB9o0IjKP?=
 =?us-ascii?Q?kRC2J3JqttrlbzhN7k1c3AA3ACeGknCfvPgl3NlJezMxwCWrJjoXIBeNF+EF?=
 =?us-ascii?Q?AL0f9MWrLa8TzWu6FHHLA9LRXj/esDDyMjU7qwrQZjtLODAkgEyFROMzKDz8?=
 =?us-ascii?Q?12W9GHPSIKZr1uaE9MRiyNso/Ia8YfP/JVf6WkR36qh1MlphhiiuqH25codw?=
 =?us-ascii?Q?WT/QrePTbtEWFo+AjFS64Gl0DOKCnWGGKhzP1FlQl7SfixZQTdCrKIL7pjlI?=
 =?us-ascii?Q?agaMw6gWA+TZYna7kGhAxoloNLE2hndSVf0dthq0aYE5S+E+HN3VvEqQXJDb?=
 =?us-ascii?Q?+znPYkm4oVsmjpmssMR/dH3OJrsYa3gQD+/6+rueQUCU2GcMb6m1Aeh22NTa?=
 =?us-ascii?Q?Av5fS4emZPSyT2JJmong9bG0IpICSlvY5EAzJRAXjRR6vbyn/KsqQC1jyCxN?=
 =?us-ascii?Q?TZ6wt0btWYqI40xyTz2pi3Oqo5hEDcnFDqghiMww2qD3QuVstUGYtHoxO/m0?=
 =?us-ascii?Q?BQQ8dtP4VFyGH1Y8e+IJ3/lWmP5iJUdfiGcgoLv8EcXImMAEJJsxXWp30Yvr?=
 =?us-ascii?Q?eXboBOArwmz3DKfoJiLF/rlnHN3rFe4eVTnlEW9TYrD3QwlZnSYHQbvvkr0f?=
 =?us-ascii?Q?YGvrIFXLuliL/7B+dgAi6Wb5y8u7nXV6q+6IBdl/DmmVUaCFf5W40juW8h/C?=
 =?us-ascii?Q?5P7bI3YX0Qcnc3xBRGE0vjZoBFGMpl4mZRArp+Nk/J8zOIqF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hkdh+BayqIl22UNiYbjjYo3Lom/M40nE3MZteY2Q3UsOGcNQel6EN3h5dcH34e/c1rBiMIhpZq4kl2QGAmN06P1oIGDxKk1mH50xi5Ib//PPDUxWMm8XD0n1fKjqvW3KaA1LSL23SrOWxfXGORr9Omi8dtq1G2aTBfoDlJ/wPFf8G0JrFocjCrRfg7zSxwQmbi5UB50YVEEG6CCfLgTcVGlsh901HhehYZaUyvP+O5wlEvb3OUHDdX2dVIqB53enhc9GrpWkRiKZULDm1XL2dopUHeiEtQ5HtiDUMIRWSGyQZkDKgBBXY7MtnKdxn94P/QOUOVaz1V+q4IbXXGEBQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2a8b9b-f0bb-468b-f344-08dee0a969cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 06:38:56.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssPiLXrivM2x3I6c5cPzpsleoHkhxlzpMfaF4amSpmm6OTuix2BLWhSC2DfvZ3RCU31DJXvQzC4MJK0KkyOEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6709
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sergey.temerkhanov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:from_mime,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cloudflare.com:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B9D1747987

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: 01 June 2026 14:50
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v3 3/3] ice: Cache struct ice_h=
w pointer for split register reads
>
> Cache the primary ice_hw pointer to ensure consistency between calls (bot=
h parts of a value will be read from the same NAC).
> ice_get_primary_hw() will never return NULL, but during the ctrl_pf clean=
up there may be a case when one call will return the pointer to the ctrl_pf=
->hw and the subsequent one - to the
> pf->hw which generally are not the same.
> Struct ice_hw is embedded in the struct ice_pf so it is protected by the =
same critical section - no additional synchronization is needed.
>
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 device=
s")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Tested-by: Frederick Lawler <fred@cloudflare.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

