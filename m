Return-Path: <netdev+bounces-125889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0196F1EA
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02C0285223
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB301C9ED1;
	Fri,  6 Sep 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBy3l2Q+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E941C8709;
	Fri,  6 Sep 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619924; cv=fail; b=ubBTIHruPsCEIZjihHrgdVN2Oxq8fXowLtUT0YGpWGrnT0BvgAtQJxKHkH07uZXZPMhXYcGD4CywDyIFCJFqUys6MuCr8sX5rEZuuxG+cJ6eIwU59iqZUdty7WI7VRyM/ZTfzVFRMq1/mxt/oLCQxqHea2zWiezsQhmziG2fUeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619924; c=relaxed/simple;
	bh=9RFQ7EKm5tUn/IZcml0x7ZyN7Gvr1ELCatMENVPGH80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVe2IK3voVHnK1a+sLE7xCLvo1KyZMokp301pVXPKIq6jMjiSdt4BcWiMZICyi0Teh8di4mgizoBy7h6tgReM/GmxqMojVRVjCetPFpJ7pEG76T8ddG9L5YKwsmbgKXmvJupcaUWaWAzWlT+ivHVIug9mhFp7o13/o5YZtLzOUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBy3l2Q+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725619922; x=1757155922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9RFQ7EKm5tUn/IZcml0x7ZyN7Gvr1ELCatMENVPGH80=;
  b=HBy3l2Q+YaCzrHgIdrCAnoEIOALtxUUkmm1YuukuDOdXOQgRH4Mdzozl
   mQgKWSL8Ed/4DL+Y5emi6+pD/FcDhVZYDfUnq1EAm9irAPujlmqi2fHdY
   /BGSE0G9bb8SaJJHQFvwKYT0mtx2GAUpu6A7/rfabyGPvDvr6x6MfsBZe
   D9bjVca/SvbUq6Fd1DhL+X7sYkhx4s16CNrA3woD9IGFeY811PYebQxs0
   Mb1n6iGtXvE20OSvGTeY2N01C1TOV6l5EHiWT20c9iKJiFbwoVga8gSYk
   FQ/TLd4XlnnRb847oZwAJumaRTIX7Ipt9326HsF4bX2FXBdORO4WuZ34x
   w==;
X-CSE-ConnectionGUID: uH/V/amMQY+LMXMVOhLBjw==
X-CSE-MsgGUID: kn453B7JRYe0wmzM0NIjOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24174212"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24174212"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:52:02 -0700
X-CSE-ConnectionGUID: rg3JT536SqW2bFsFkifWSw==
X-CSE-MsgGUID: v6mUZPsqS/i1os8goqDHFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96632590"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2024 03:52:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 03:52:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 03:52:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 03:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtEh3gZ4ycEn08MA4JEpFNzYtK6TppcXnGf9p6He9ytvTNTap5R93AcfQU/sP7iXyJ41HgLoV1N1Egue9sb+8F5i40rverf+NI9frFtXDIaYn39mwrQ9FBdo0O2YNtLi9QP/35pamF3uajlC6HJCzeLA9DpfeMp8bIhMwTDYwFBGL+mSV5RqoRSxBtFT48CkvSMMLyrFh8SghJ365VYAHObFLmHN1rk2T+MStD1gEM6cgbLvUuxh/PlFNqKf+5sIj3ddDpuKmHHUWIe36MihTpVhT0MG1QcVd8VXzVrz6gCkppTfmo4eXYTGC2V2pQy/ale15hmfPP0hKGWS+qpq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFUSLhAdPmgkorf9OjRjCum1pcFaQwaOgAEi7Gqo3bU=;
 b=scyOzFAB1zAQZ9mzmPWAdeVekytA+jeaneQWSGPb0M1oMKLmdlV3weIDMjSybjmDXqnkAFuj7KfGX6HBfNLN0d1uCfJbFEw5FxfcepbD26KqCBG/wE5DPxekIT+at1ovorWm1dVj6Cc4dl/bAPb2I/9KZQcmxNBTU1tDffwFsfPnqFh/FLrGzdESorCVcvaaX+lbChTvT+4/44QUD9XiQAtMoxh5HcD2NnymtqDGH8nib1mdYJvmZq0Jba/ksyqrz1Q+S2rr0a11eccH/Qf88nOxFveXeh316MJe3ZiY+WpSWqDJztXeOvZr/o1ZUs5nNb2fF+LBmRX40Sa3BXZU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by SA1PR11MB8256.namprd11.prod.outlook.com (2603:10b6:806:253::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 10:51:52 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:51:52 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, mschmidt
	<mschmidt@redhat.com>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Miskell, Timothy" <timothy.miskell@intel.com>,
	"Ertman, David M" <david.m.ertman@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Daniel Machon <daniel.machon@microchip.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix VSI lists confusion
 when adding VLANs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix VSI lists confusion
 when adding VLANs
Thread-Index: AQHa/TBJ3usx9yrcrE+0+UHMqFUIILJEUf6AgAZJHbA=
Date: Fri, 6 Sep 2024 10:51:52 +0000
Message-ID: <SJ0PR11MB5865AC266F7AAC0BCFE3AF908F9E2@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240902100652.269398-1-mschmidt@redhat.com>
 <ZtWY5ZJkAc3OGth0@mev-dev.igk.intel.com>
In-Reply-To: <ZtWY5ZJkAc3OGth0@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|SA1PR11MB8256:EE_
x-ms-office365-filtering-correlation-id: 07c5d20d-4057-4e50-f45e-08dcce61ea88
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1vPE/+pOxW7l8cE1JuSdK3uvSP/MIGBVs1YMgtqwf9XikuO9kJAATt+8T3Py?=
 =?us-ascii?Q?Bowle4NrLKY/8UrlI6U4XSmmVrmuMA3yAf5//Q+zCgpIWU6gtuTrCCL4ir9k?=
 =?us-ascii?Q?RMd+zPULuEWNq8wzSw2ZwbKB7IHnnJj0d4UiQuwx9vMaBET6QvslIstCt0Gj?=
 =?us-ascii?Q?wvygI583CaNuuaAdZnloNVjHPvp9f546Gd8JOHaxn8Jv4GF9kPL3inMxN2kI?=
 =?us-ascii?Q?F8V46EGZVchhFt99kyyZKLOIE0aUQZERVaQWBW30UE9iYrigPF1XHaMAq0FR?=
 =?us-ascii?Q?yZBhgfQIm0Vplz23maquogxRTkMj0W7wm2HWJGjxBI6LYXTdZUg5TBB5KIW3?=
 =?us-ascii?Q?MUnObJR8yeNU/DhuHbKNcFtu2zwziBFYUntsIZwFnbPmu8CGzYMq+PRkxZtl?=
 =?us-ascii?Q?lm3W4T9AVFHBJ9GRAmwTiVM18K5/xcQjv+ga2//YseaxGyPAYIVX6zhAEHkX?=
 =?us-ascii?Q?wWwXupuqkWvGS4pbVtr+AdZlinPwr1w+249myRsZ704c9jQUcbJdsJn9aaVZ?=
 =?us-ascii?Q?R1nbj1APdOZ5m/4E24Wp0KRBbvnoush3WVsXkg8iQuYe72N1c/APxaY/rLct?=
 =?us-ascii?Q?A7naMACNdj3uf3OXGyYnqBtnoPomm4JviKal2gh8FPJVxe/BbakpRGoi4iF8?=
 =?us-ascii?Q?jQr0K9r6/8zJoVf33OujbyOU/QiMOWTRfQsAJvOOQnxn9z7ek91Cg+XISsa3?=
 =?us-ascii?Q?STokfUT6EnEf/MD9ga1t8vqrzD5oHx6fyyx080ZO0gluqQ3MYZNiqJiLRL2i?=
 =?us-ascii?Q?XOx5+UFoe81DUT9V5EpdSNSPS7R7F+ylW+il/DnF2aCIq3tQsxG0Vr3iBIJa?=
 =?us-ascii?Q?7u9X7s5WJai8pGy8lTj7lhkd2cBt/ImaLboPgo3owjO0yiyYWoc5QuUcHyCx?=
 =?us-ascii?Q?0LWNKngoJtRzRWiLSa6u3XDiKPmHPsrSlIP1Hy+M7K2c91pc+VxFImr9cjf2?=
 =?us-ascii?Q?NOdJgWcUqYKE2Q+WsD5EcLli5CxhIbeU9LpE0cPMjq1r7LchdavBzSUfgFKz?=
 =?us-ascii?Q?11QEuCuEa/Dz6jSdhCYhbRnogvtLMs39PnZqRinbPrMgjUseShKRRiR6UjPK?=
 =?us-ascii?Q?fsCiF645v2u0vnQzQzxsbmEwAMKL6jS7iqTbSAajJ1l/Um0AaxKay6BkFRRh?=
 =?us-ascii?Q?v5rI+4KselbDjLTyy7k4HVZ3xRhmj/w9O54y1cX7+Z+i5N9pELFU+f0X1g10?=
 =?us-ascii?Q?f3sDHqAdczu08/MJyfKnGWKKMuxLH1mX1k7L6nEC2QhRRFXmMBOlbbzelTcM?=
 =?us-ascii?Q?BTJgNQP0GP4V71ACYN2bhP5Y81yubhRjm8JG0HiF0VKCSlnyqnZmglDgg4+S?=
 =?us-ascii?Q?NtbYBW5wPGchBwZAoUWl514li+m5janb2uM9DtR0Oa7OsYnZHqLPgIP7TI2L?=
 =?us-ascii?Q?JQgEdUm7jGgXlyo+DgN43NcfSYHGcnMpEiQdsBIsDbM5tH+PZyDewXDGoNSc?=
 =?us-ascii?Q?PVpAQnWaTX8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rvC2tlplURW5vmmoB56oWTu9JOFWLCOnrU5KrUHcouj9q75kbeSYPrOG17NB?=
 =?us-ascii?Q?6vyOd9MedfAsDj4RZvnak1io9Uu19MHAWDgnh130sol87vdU/dEz04/9MiGR?=
 =?us-ascii?Q?SPo641wE8arMbQJTYaTkZ47yPdDFFN7Qv+SpC7Fc/VrWgt7U5g92oHEDqrsR?=
 =?us-ascii?Q?PIYzwPEorGs5VRHZDMGt8Pm+CMoqZfZiXBKyDsUi0vMJvQvsJGPg+t233Cze?=
 =?us-ascii?Q?ao0wZojI309LWpCrq+bn2LiYcNpSnUFitzFE5aMRnLqmnqMJD7Wwz8qVmeOk?=
 =?us-ascii?Q?AJmazguQgU2V7kU5d1FZyunnBCWYXANSwr/olycZLGK9cFHJpnmjK+KeAp/W?=
 =?us-ascii?Q?bbhigh4gygh+XvPsbzr65MgaHCwQQ7Xb5vUbnjpkFQo5TAjtVVRoohKnZXX2?=
 =?us-ascii?Q?KNTLtGVAGb+v74CjaFOMOqxz5jfqhrxRdMEMdusg7YGcEKqdZYPRrfl9+bru?=
 =?us-ascii?Q?ERsd2i786myDO3A6O8raobRBbRvsl836lZC3H3Qe2qHLfpnY3HDWTGwMvlmV?=
 =?us-ascii?Q?coKSLkaRKlRHCAawqNL4ocWo6/VKI4FhgiegGxYvdh/9H/uHtMTxGY0RgJ1F?=
 =?us-ascii?Q?3PSdN2Qp39gFIKaRgm8WnKn8pubRN84BQAUIT8h41plhj3rpw8opxm2h6Yg0?=
 =?us-ascii?Q?95ibhFhvr0rnqaBw4PcjvxcEwe97R1SPVnzDLs4bfF0PHwMsj+Hi7vUZtO7O?=
 =?us-ascii?Q?bxTb0vT0EIbSmUNsPI0XCr1S51ti/VqIyfKjVA0JHVhY+I67ZfnUdDJMy7xq?=
 =?us-ascii?Q?qxqzuoA8W00Y05fiY5KK4gq1M1Dwv4KOVEhpcpN8SMywm9PDwRqbFXBnJS7C?=
 =?us-ascii?Q?g9iMXCcJP9lJVN/ajhBgwe4ZONoY9LbpO7tFLRtOHv7OiWfTfdbE4NoHv7DH?=
 =?us-ascii?Q?laW3MEyXGGmLYYYdgsyNgFM+BdBdn3jTE4TTRl8awU6jji/7UPBkgRuheZT9?=
 =?us-ascii?Q?A2ockNCETCxRG7y+0FNrXt46fSLe6VwFQH1slaXz7x4aSqswRRsnQ5++Jke4?=
 =?us-ascii?Q?28nJP7Zf3UPTsiY/X0IM4+L66gqgk05CrjJIZALQ5UAEsXABPKBZF/WDBCM9?=
 =?us-ascii?Q?zpDDJfQiHZKueDDTHD78gVaT7i5/1D0FZjqEzrQPPQndkLkX7ZexOYRVyCfU?=
 =?us-ascii?Q?fWD6NmbPTKgTrpaKJnkMm728GDi7FeFAa8yJ6Opp6iuQvZctaFiDbvgnLVcF?=
 =?us-ascii?Q?tIa5LhKwiZ37WsWuzdPiWtOOeLY8hXP7CsGkzA9yCUblkmIbhLIfOrNUg3d0?=
 =?us-ascii?Q?fcwms508SczYideG1oI0FzUncWZcSp47Lm4bBnVIXVbJgXbU3jN9NAsqyKp1?=
 =?us-ascii?Q?AyMCsM1bQN+ANuG8h2QvQ1DCXj0lZRMFULZ0deFV2evlHS876057YHX4dJrF?=
 =?us-ascii?Q?uMfLmmDH71YwH9X46XOGdCWXPQTdbasauLraeA4PsJvvcMZ8c4njNJ74G4JZ?=
 =?us-ascii?Q?gTL3hfH3HAo3oLUJh9jJ6pT9R3bWDQZ6M7Iq7Gno23LpiMsbIK2CqMQQh/DP?=
 =?us-ascii?Q?dU15ECQc9QBbeiLaFMsub3EHaOBHcfKiheA3pIbhr5SJDJ5T1EGpPxw9xpD0?=
 =?us-ascii?Q?gKy0N65CjVA+yyvPtJHoVM2mDdycf+r9NCUAtsCzf/ecmuOOfFJJkaaN21jk?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c5d20d-4057-4e50-f45e-08dcce61ea88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 10:51:52.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvVKnCgDGo5ovsCEX+KlELEfdipq+78GtrmRCMqLPNJt+yfjwAJMKACZmo8hwzSer//OcoTxpZfyHvVRYsWx4VKoO8J2l6Ztd5Cngl+qd44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8256
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Monday, September 2, 2024 12:52 PM
> To: mschmidt <mschmidt@redhat.com>
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Szycik, Marcin
> <marcin.szycik@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; linux-kernel@vger.kernel.org; intel-wired=
-
> lan@lists.osuosl.org; Eric Dumazet <edumazet@google.com>;
> netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Miskell, Timothy <timothy.miskell@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Daniel Machon
> <daniel.machon@microchip.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix VSI lists confusi=
on when
> adding VLANs
>=20
> On Mon, Sep 02, 2024 at 12:06:52PM +0200, Michal Schmidt wrote:
> > The description of function ice_find_vsi_list_entry says:
> >   Search VSI list map with VSI count 1
> >
> > However, since the blamed commit (see Fixes below), the function no
> > longer checks vsi_count. This causes a problem in
> > ice_add_vlan_internal, where the decision to share VSI lists between
> > filter rules relies on the vsi_count of the found existing VSI list bei=
ng 1.
> >
> > The reproducing steps:
> > 1. Have a PF and two VFs.
> >    There will be a filter rule for VLAN 0, refering to a VSI list
> >    containing VSIs: 0 (PF), 2 (VF#0), 3 (VF#1).
> > 2. Add VLAN 1234 to VF#0.
> >    ice will make the wrong decision to share the VSI list with the new
> >    rule. The wrong behavior may not be immediately apparent, but it can
> >    be observed with debug prints.
> > 3. Add VLAN 1234 to VF#1.
> >    ice will unshare the VSI list for the VLAN 1234 rule. Due to the
> >    earlier bad decision, the newly created VSI list will contain
> >    VSIs 0 (PF) and 3 (VF#1), instead of expected 2 (VF#0) and 3 (VF#1).
> > 4. Try pinging a network peer over the VLAN interface on VF#0.
> >    This fails.
> >
> > Reproducer script at:
> > https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/test-vlan-
> > vsi-list-confusion.sh
> > Commented debug trace:
> > https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/ice-vlan-v
> > si-lists-debug.txt
> > Patch adding the debug prints:
> > https://gitlab.com/mschmidt2/linux/-/commit/f8a8814623944a45091a77c609
> > 4c40bfe726bfdb
> >
> > One thing I'm not certain about is the implications for the LAG
> > feature, which is another caller of ice_find_vsi_list_entry. I don't
> > have a LAG-capable card at hand to test.
> >
> > Fixes: 25746e4f06a5 ("ice: changes to the interface with the HW and FW
> > for SRIOV_VF+LAG")
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c
> > b/drivers/net/ethernet/intel/ice/ice_switch.c
> > index fe8847184cb1..4e6e7af962bd 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> > @@ -3264,7 +3264,7 @@ ice_find_vsi_list_entry(struct ice_hw *hw, u8
> > recp_id, u16 vsi_handle,
> >
> >  	list_head =3D &sw->recp_list[recp_id].filt_rules;
> >  	list_for_each_entry(list_itr, list_head, list_entry) {
> > -		if (list_itr->vsi_list_info) {
> > +		if (list_itr->vsi_count =3D=3D 1 && list_itr->vsi_list_info) {
> >  			map_info =3D list_itr->vsi_list_info;
> >  			if (test_bit(vsi_handle, map_info->vsi_map)) {
> >  				*vsi_list_id =3D map_info->vsi_list_id;
> > --
> > 2.45.2
> >
>=20
> Thanks, it for sure looks correct. Reusing VSI list when the rule is new
> seems like an error. I don't know why it was needed for LAG, probably
> Dave will now.
>=20
> You can add in the description that bug is caused because of reusing VSI
> list created for VLAN 0. All created VFs VSIs are added to VLAN 0
> filter. When none zero VLAN is created on VF which is already in VLAN 0
> (normal case) the VSI list from VLAN 0 is reused. It leads to a problem
> because all VFs (VSIs to be sepcific) that are subscribed to VLAN 0 will
> now receive a new VLAN tag traffic. This is one bug, another is the bug
> that you described. Removing filters from one VF will remove VLAN filter
> from the previous VF. It happens in case of reset of VF.
>=20
> For example:
> - creation of 3 VFs
> - we have VSI list (used for VLAN 0) [0 (pf), 2 (vf1), 3 (vf2), 4 (vf3)]
> - we are adding VLAN 100 on VF1, we are reusing the previous list
>   because 2 is there
> - VLAN traffic works fine, but VLAN 100 tagged traffic can be received
>   on all VSIs from the list (for example broadcast or unicast)
> - trust is turing on on VF2, VF2 is resetting, all filters from VF2 are
>   removed; the VLAN 100 filter is also remove because 3 is on the list
> - VLAN traffic to VF1 isn't working anymore, there is a need to recreate
>   VLAN interface to readd VLAN filter
>=20
> In summary, I don't see the use case when reusing VSI list which more
> than one VSI on it for new rule is valid scenario.
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> Thanks,
> Michal


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



