Return-Path: <netdev+bounces-293024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+CKyNCGWqNuAgAu9opvQ
	(envelope-from <netdev+bounces-293024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:37:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6E5FE9EE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 856143062613
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9B3A254B;
	Fri, 29 May 2026 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEN2kRdo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8A3AB496
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039931; cv=fail; b=CXOxTkhCgSDn4upe/qxmFt4O8az8xbMwuiRy3Rk0LK7JnOB8vJ2BEyhYgK6TFL6sE9USzsrP0NCHtGXwgJEaR6SQrk9QKa7TaGBCFhcL/yq/rCOvZQFq/Mz7KENyx9HiIY0VZVQqvfmIWX/lIwJNyX1Gj95fLncEPu0/EIv0yqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039931; c=relaxed/simple;
	bh=SKCkIcsCKGD2bHCgxrnUZDUnoPKx+OQyXD3Q2Sdfz3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOWtpT+Pj/trr0yGlFjCRk4247hjWNBYoBRD+Fo6khxTb2UuMkbsrs/MTsQ2GqtuquJxhuWcbtIVxaonE9RB3yZF6rNTxeocgBbm24HHq7PvxqB0J49lDaxQZxg6rInoHK1zUZynJBX5UPQ9trN39lYukNwcs6krgj+JR2X9thI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEN2kRdo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780039928; x=1811575928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SKCkIcsCKGD2bHCgxrnUZDUnoPKx+OQyXD3Q2Sdfz3Q=;
  b=SEN2kRdoZlB3c7PRgWqa74ALJkFFYPatzcLNcOCkPudzyxqLM3LfHTRg
   wKWCa9S2MK7RU1+tho5W4DebirYMVb7h+ylN3NExG6Kxfa8qTXJ8lQreV
   iC+T3jebuIQWVDLm8P3qaIiUHhjSouPL7MNMV2iyCvph5/hngFKdtGwWq
   Nd2Jaw6IfPv+4tfmhnQLAAVnLUonq+Zlqh0W/VawTH6G2ab72vJAgzbA6
   tvgmTk8g0jiLbl2cfWtarAvBga26wp4GANEd59EUqk/b5x0Nkw7O6Ymlo
   qK8yHv8Crg3vwvH2ZpgQ4UvJyc5UPjs22mG/hRWm3BKMcCyPtg22jgftz
   Q==;
X-CSE-ConnectionGUID: EwNICIVRT1qGpVP8u3dM2w==
X-CSE-MsgGUID: Wuq3ZJ45Qeu5ZXuPvUOrbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84747845"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="84747845"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 00:32:08 -0700
X-CSE-ConnectionGUID: pebMqcbdTMizAd0AZoTO9w==
X-CSE-MsgGUID: MIVJRFM6TUSUYAfYTATrBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="244599366"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 00:32:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 00:32:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 00:32:07 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 00:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwD+8crEIt+yG9jAo1JCN3BobN5AL6ZwjiG3wKGIQiIgk9U8rprZAcJYQ9/wu8lXOCLnHd8fFHBJ6OyBHEUTN5NPCgJi1GHlHGTzOh60qTexh8kMasEJNPAvEsatrPCqS0yWTbBEmN2+8fT5CYmKAKoTpB/X6pkUvnBUA3mUFOiSWVk382CIVpfMmMc3vr4tBg5Paqm7qWVbHQR4qIsNBG3gA8+bOTPfNh8I1v2WasZk1LROcPOfOehQEIAv5U79amXsHx0B5O1xdZviBEHWSlx2GxNLJ4ThtebrGgq1GTsK6ABgHJhlybTIeOHlHUqWLJFdWO8pvyIVoOLqTddp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UUf+0z2JArcXbh2hdJC33G/ieUaqy9CjMnF5ryFXWg=;
 b=gyWBSulF26ArOhLFh4nGXeNrFvXHbYlYwJ8NJ8nsxoLLI8hPshyP9V/KXTBU0wW0n3W1u0Hh11XunlgbG6v9eA4fUMn3+26GYk5c8s1bB8jj1m/yN6vhPrggw/ORWkWZc889xqE47UDrgppPe/JZk/2BtOKqZvFYQb2WmHp9XAtKSvNZJMwM472LsX6N0Oiz5JTBCFOnLNTe9yurYcLRuJyqRMEVlPEt/hjbDx/ShWKnkN0cXj07UKLVGEiOdVwKhFhEPxyQRIaU5myISh7nut4SZvO/sxGBl3dyLf0/GdlhP+Ghi3Sv7sHIcPc4iYKuWD5iMULI90FuanBsfIC00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::831) by MN2PR11MB4728.namprd11.prod.outlook.com
 (2603:10b6:208:261::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 07:31:58 +0000
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::3dc7:50e6:ac39:32bd]) by SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::3dc7:50e6:ac39:32bd%7]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 07:31:58 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Vincent Chen
	<vincent.chen@sifive.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 2/2] ice: remove redundant switchdev
 check in ice_eswitch_attach_vf()
Thread-Topic: [Intel-wired-lan] [PATCH 2/2] ice: remove redundant switchdev
 check in ice_eswitch_attach_vf()
Thread-Index: AQHc16S6row3TqqJs02hNAlIXkK3qrX1wuKAgC8INuA=
Date: Fri, 29 May 2026 07:31:58 +0000
Message-ID: <SJ5PPF6806D69E4E71ADD4CB2583AC3CFC68F162@SJ5PPF6806D69E4.namprd11.prod.outlook.com>
References: <20260429065127.423949-1-vincent.chen@sifive.com>
 <20260429065127.423949-3-vincent.chen@sifive.com>
 <IA3PR11MB898631399BEC9181B1E1705EE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898631399BEC9181B1E1705EE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6806D69E4:EE_|MN2PR11MB4728:EE_
x-ms-office365-filtering-correlation-id: 48629d9c-4bdf-4e4f-a3b7-08debd545e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: Zkc22WrGQz9UbJFqqmzjorFsZAVDuESsISlTtfE4G92+raiKFr80gkgcI7OSuFx6CfHg2Wa7LLp83vHGTc65wdg2CqBemPBu9JrRaeZNPcyIIk23ZnTAO2MlK4YcgH7WjQMITJf2u9PJ/otvs6+M1f631eeyZ+GAfwESXFr8mCu96ffWLT9od4YwWq0bOIG57Pmx0P4kWLmxBnoIk6HgNv01GiWFt1PeXPNlskvzYLfrPRW9+1dgjpxZLgmvzHTF9EJH9KNlQrFljvsZAddbwK/PaTob72qX3LfAhYvnVD3XMb1NGr++vPNU2CXWTtzQsHp1OVQQsYeTlnjax2b2wEDjbqO+dr/unYHHIB4vzzOv3EMerB11JewiVRZCjxBjlRfk8pJFWJ+0AlxnrYXtWaYPdffWHAUbQj9vyspbaGVau7Hlb0ymvi6RgzBP/yvedKicdJfkTXcXDg0ED2z+4x4gsMlA5O9T1WWF1CqqrnQ8AqrqLM1hAlkZe/aJYkGbwQMlDljLgV0XXIa7yLapF1Um0yuMukTIy9XqFIeOOGtlkXH0xYET1aVTQc+92hBN4FN43UYJS0DHxu5LCd8vpHHi0X33nCslKXIfi8RwyOBeiFVaHYwpSA29nBG9aP45Xa+rF0j5UXYT2O0k4inItOfliArb8zdXTo5cANOkMpuBDt8BuoFiKWxa67eRys+Y7YjE0EX6wFnq4IvaLxyCCk0zs/a4LVCBaDveLGLMGrypzOvT0QoARA77VfyPVE0J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF6806D69E4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yzin+/K617e8RYbsZuaGt1VZ+v4pu9yeUv7gPrfxQxftc0ivambloSYd2tpv?=
 =?us-ascii?Q?ng28fPvtillYYCl9wHzrP4k+z+l9unAEkH3rBsKzgCi3zQuL380Rf5ZTP8zh?=
 =?us-ascii?Q?g18Bhz60MUOyQS7PwdHDC+gWoucy+bNxQECoc7p0Dyn64xoOLAN6iYi6LowH?=
 =?us-ascii?Q?fFCrSVdXUWuYkoxRR3l/zVeRu+wwLyW215GAJAcsvgwSfAM1mbBW3VfUJPWb?=
 =?us-ascii?Q?7GJsHs2zjc3BRq93UM16UOloxwq1v6FL1UDTIRYYBvUU7dVsClCpMlUCMQKF?=
 =?us-ascii?Q?ea6bJOXB1F67+O8+RVNC69TkQuTihXl8Gv7qrhZDVSakn5/g5V1TJUJGVrqR?=
 =?us-ascii?Q?pAL3Sdpy3CCwYUojj24InnUqKFaR1uOOEfy7aCEjQB8LNlDfiyD7aY2gQli0?=
 =?us-ascii?Q?RJ8cu+eaqgEen7JR+8LtHdD+SfeRjjKuTPQNj9n3VLmQCffONTmyoZUPNGg1?=
 =?us-ascii?Q?xoz4jC6WWathk2gUoDL75IMN2xnYgJTSrjEWk+vUTPf9fDUFi2L/dRh02M1R?=
 =?us-ascii?Q?9yiAort6QBFgTjU8ilSG0RagxFIzczH5IxahAhdpOj1a2ydlosHeTcPqEi8e?=
 =?us-ascii?Q?6iCadqVPE/wwyL/s/l5ryW/Ev+o/CRjJLwM7EWZKNeqnVxsb/mWizVtqYEFm?=
 =?us-ascii?Q?ea04iLDrLkM7QDg3fWKJYVqVkP28G+j/xl76Gc5cB6qG50TbkRHOArxOv2A6?=
 =?us-ascii?Q?FDpiCo8jZLsQEvW/taZWxdiW4tbQnkTWFlb88ZEQbncizntwyo/7PYcX/DBA?=
 =?us-ascii?Q?TmiYsmkpPDho3ST6bVpMyd83sVHF6gDBKR+gk/w+gsHdTmH8e3ucEyZB0xmn?=
 =?us-ascii?Q?b48VdIt3NtXWVGCWHM+g5NPkpdr+5e1OfE5ngK/hrZOgjaOqiQ63Vfp5cv6H?=
 =?us-ascii?Q?p9sjvtfksUzlyxbUlozT2e2jLz1STiXAab5vZ2VYAHEaG1DgAaY7qmQEGyKk?=
 =?us-ascii?Q?oiClyD/h6NLy6ZEMPC194XFuhw87Kr0S9q6V170xp2CbgDtwC+IOLuIFKt7W?=
 =?us-ascii?Q?M0PtQzoyyPCLJNL9GXOGeHg3yi98j/Dvjihdr6IuIE+JxT7enZGhEqKxWnjE?=
 =?us-ascii?Q?sdyv9owJFrAt0NtQkF+ZDoJkFS0T+o3lmtTdByON1fVF5sD0aWhehKAFvt3s?=
 =?us-ascii?Q?u6k4NfCqCdKZdmQpNi7NUdfIrhFrUBqT9aYEfQgyRyRdYCZ1cQhJtw+NHpLg?=
 =?us-ascii?Q?OITniYMeL1dQTGh/yGol4gAOASjorBbAanTenMsD4iAcyoFeZ7UxV2RYEsgW?=
 =?us-ascii?Q?mZ0VKNR82wECOXcNxUp8NCZRYUkRV6Ae/kbwgL/x8HBVcVF5YaQf4BrfE9/7?=
 =?us-ascii?Q?x7r4cXCt6gWHccynBGx4jBIdycjrV1FjFvZ6/PZyMWQSKHaxoliTBRNs0IGD?=
 =?us-ascii?Q?1Nd3ZGhTTUTZWaHrgdBlpZVBhkVihGKqOkjVlnei8GaQZtINTdoVRxDNbziV?=
 =?us-ascii?Q?p2UfwA0dcB3+J2MXYkEDci4yyP/EqXXtQqfIGgVjINn9vsQSGTm55RWZJaSq?=
 =?us-ascii?Q?823aK0xOlAKxmYQm9Nnbi4hvQIovUfViOg6U8xmmeH7Vfp/HNgm3vUB6wxqP?=
 =?us-ascii?Q?Oi3hoAxUingQnNGqtLlEOIV5F1cpDqNw0tlJXA8s0qT4JY4cz+1onrWZUgs3?=
 =?us-ascii?Q?mKfPXgiiv+7B3e36Ctd+UDqrCneeXSS7ZQZOyJPomwHDMccmUG8LDrPRbge3?=
 =?us-ascii?Q?r4F02G+GA41VLg9GwJNUnXU8j5fZEKjBVDmp6htOkm4WfpaCOhMzJ1KWarG6?=
 =?us-ascii?Q?7VNvPIHbHA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PzgVrzLyyEfDwDhrM9EovM19dRW1DlbI+Bs7wYV+lZ+B1+Ge46ACpfeAx+NNC/mPqt0myU75N+z9KIn3dDq7fBhpy8gEtsOdpJ5Axh2J8Duv7jSk/tFWlgGs7d+Zj/a9vhjsARZ/k7Kn9knLIqhX8Skde+O/5t6kl0zfj0zeP5eLnnY04QTWhR3aQcQnoCR+z4bfdj1UriWyi7OidYXEy5xuI9pL0bdCgqIIShtGmOoQ9rpPWVqd86gxU064u1dRMDxZbzYbi+wB6VrO1/9JcfHZ4IyfB5unFiNydyToSBUc9R84gXVACWGt76iYdTVRhOddXVrZBanSKwO90yXsBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6806D69E4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48629d9c-4bdf-4e4f-a3b7-08debd545e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 07:31:58.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bkBTYjDIycHOwBKs5DhCXm57dx6He8W+NKVglCnbiEYiLXDw93EgoOKGYzKAm8iX+dwXQBQyQv4YgHRALecXL3cnTNN41BETlL3bCiL5E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293024-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,osuosl.org:email,lunn.ch:email,intel.com:email,intel.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0DD6E5FE9EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Wednesday, April 29, 2026 11:18 AM
> To: Vincent Chen <vincent.chen@sifive.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH 2/2] ice: remove redundant switchde=
v
> check in ice_eswitch_attach_vf()
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Vincent Chen via Intel-wired-lan
> > Sent: Wednesday, April 29, 2026 8:51 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; vincent.chen@sifive.com
> > Subject: [Intel-wired-lan] [PATCH 2/2] ice: remove redundant switchdev
> > check in ice_eswitch_attach_vf()
> >
> > All callers of ice_eswitch_attach_vf() check the switchdev mode before
> > calling the function, the internal switchdev mode check in
> > ice_eswitch_attach_vf() is redundant. Remove this check to align with
> > the design pattern used for ice_eswitch_attach_sf(), where the caller
> > is responsible for checking switchdev mode before attachment.
> >
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > index 2e4f0969035f..c709decb26d5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > @@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf,
> > struct ice_vf *vf)
> >  	struct ice_repr *repr;
> >  	int err;
> >
> > -	if (!ice_is_eswitch_mode_switchdev(pf))
> > -		return 0;
> > -
> >  	repr =3D ice_repr_create_vf(vf);
> >  	if (IS_ERR(repr))
> >  		return PTR_ERR(repr);
> > --
> > 2.34.1
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


