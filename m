Return-Path: <netdev+bounces-96286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926588C4D0A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055B0B22FA5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF011717;
	Tue, 14 May 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHbBNd0b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867FAD24
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671802; cv=fail; b=jFWPatNM4eXMkN1twPF+0GHyhYPr39UG5oGAAgxO+zjuzgwjaHk175kW2aokfSWVGHJOUL/hLPVzqfoDjjZfJgPy/eqYw2hDO8ItaXBGOcx1vlgvZwkKNb6Okn4iVccn0x0LRniorKJnKry8spA/rkum1NyvRboDAtgheRlchbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671802; c=relaxed/simple;
	bh=rSKRtgozesddnyq64C9U8lX0jGJJNqacFYC9E5UWqTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yurh1MOK8u/iBeNHpNaCtFlgZBxbKnLmbG6yEBZOMy1GeTHxtC1er3CBIrh0SsbvLCqz1viNuEP/6ibOvTo66yhbN2xgH4+G1l6Xf6vGHsyDG2Pa6olgmz4abHkDZURiucFY9LgSDOa/El0SLjG2PFRoL8hcSb80ZpyFOB1S6pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHbBNd0b; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715671801; x=1747207801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSKRtgozesddnyq64C9U8lX0jGJJNqacFYC9E5UWqTo=;
  b=UHbBNd0b7ban7Xo4szbs1b8XbYz+6I233usNi0jbd2fj6RIBgfiXC+GJ
   Nskk2A7Wo0oQQto5Mz4ruUxZlcdv4A/Tn4E/IdDfbRlLMlVdA/sGUfISn
   dvVnAZkNkU+hHGJFiV77463fY0yIBuFDWBPneetEHa8WEFLKDAs3ZhZaW
   znX/dI82upuwNJbHfhqrKYJISMKRP+Q9gT0ywKN42i7XkUqkTEHP7OcTg
   ZYU4D4hW/SFp1mgxF0em83xB48B0wROoHt2nh3hXXfyQTmknUz6NxOrZ1
   AfeJt6hJ/oy/HxG4e1zHjTEIz/OhVN5TIjvKMXpGd4V69dBBLsOBO0Eeb
   g==;
X-CSE-ConnectionGUID: 3u8LnBVtT2CHaTX/Sp8suQ==
X-CSE-MsgGUID: LUFJ/T2gTnWw4+ffPgl8tA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="23041756"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="23041756"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:30:01 -0700
X-CSE-ConnectionGUID: ny8FPOG8QL+5KT/B0iOsQg==
X-CSE-MsgGUID: rXUFsFzYSL2quJOhW3t6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30545026"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 00:29:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 00:29:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 00:29:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 00:29:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 00:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2UQivUP3iKUQ96rZi7wfqC2t1PJneWXyuM7u7ue7MI0p38bEGVII4eSoRm9ax7GaNJw6msjOIJm5NabSoWzJThz6qYcCyRAiEl4WS1Op22NPuh/OjZNyXzbPkgcmNub0iXHklBavtjqhMPHOVDmEJX610NhAj7BbcL8X+WYthr/sjVdzrsiLKLFUExcZyRQHz7jGyaM7hUhFgOeyJy1hTEAJQA3PSXmfXfNVWkXN03jftCsahT9TpDxJRPwioMYEaL+2A84RRpJS7Jjz+f9Mz5wsHLnkG0wSaRVI0LaM2+Uq3yfGLWlDuvx5ZCdryuaVObdqp1Wn+So/SKBCEE2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=537vuo67kmMH/XDusQqIRzR5CFIkslxoE/jZNg1nqiU=;
 b=ld4FLRz0R8oDql7ewRjPSFmB9d+mvI4TxqC00+GncRL06yCcRZop/SS6BouMGOgT8nAEAwO9pmzCfT2CSDYY/ShYXvbc0vyGcyJLguzBUOcR1GgGDS4sSlC/qCk5fbncbSmcUoH5ubj+yZDVnLfpq/C36Fi6ShoL4Ax8FGZka2nYWpGsMqe9nahBVtz+mfUJY2hmqr6T9crBsfAvMOFuXd6eHIxPWIqMlOfK5WZ6rXPP1G4Ghbf7tBkoPLwAYMZOIgS34/nn+XFY1Itr0Ssr8IcQ0R4Mo+fXqVNB1wWGIYngiEA+qmAq/LPcq6tXjlDBHWO6mqMhH2pJ+CqbJ7jEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:29:53 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:29:53 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>, "Kubiak,
 Michal" <michal.kubiak@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v2 2/4] ice: move devlink locking
 outside the port creation
Thread-Topic: [Intel-wired-lan] [iwl-next v2 2/4] ice: move devlink locking
 outside the port creation
Thread-Index: AQHan5FY70fccU+9ckGT263VMG81L7GWYdBw
Date: Tue, 14 May 2024 07:29:53 +0000
Message-ID: <PH0PR11MB5013731E06EB737578C56FC696E32@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
 <20240506084653.532111-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240506084653.532111-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|MW5PR11MB5931:EE_
x-ms-office365-filtering-correlation-id: 5db1ddc8-5413-4a61-897f-08dc73e7a597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jf01fzVZLqymrppm0hgSG8pzc5SEe5dd1Ei0C8iow81ZLgwuVNoDr/lSy5Mt?=
 =?us-ascii?Q?K2ZGltXr3MWG5V6asVXD7r14GqkY17N3txKQJbYjaLi37cud4J7qX/n4xajI?=
 =?us-ascii?Q?HdU1Y0Af2kFLLg/cdbxWYA0/MSyIrzo4CY6HoyWxmgfSyuRna1QyqJ7qEQNU?=
 =?us-ascii?Q?7bYJb/etRLdP37TZomkwd3bwQZLG6WXgGwjQGzjg/aG60KvKNnoIfulG2HIP?=
 =?us-ascii?Q?/iGpOPeOp1J7NoQ5qBNbqSZnK7CAWkhummEmZsyf3cFq6lcIMKukM1xGlZlb?=
 =?us-ascii?Q?ygx/jl+ITuKBeKMQ9xvDfMbZpzGiGa0/sBTFEm78x3Mo9oCrysu9jk5t8lyu?=
 =?us-ascii?Q?sbwxITWRoPQkPu9eA2CskqBSeQ2MthBdN2B8d8cfpDdD++KhMha8L2bfTlvI?=
 =?us-ascii?Q?73zIvyZhzPpcU6emzWrXUQYX1S3UbcX4e+fSdjDGJOOi5IoaIFpZnDWIU60+?=
 =?us-ascii?Q?LwlokN89recDJ1SYveAxGlMHTlefwc8LOuuOHv90sWqrxIi8cZaHdq4zF/sW?=
 =?us-ascii?Q?hrZdt0E8hvEyFXWqNgjFcVn4sioxdeAiUN8xFcftNMfEGdkNZgcBdUviqC1D?=
 =?us-ascii?Q?M2+zVvjRvzyH5m2wXGQSoLNybGNSxN+AgwiqynHOM96baUvnDt5d3UohA34M?=
 =?us-ascii?Q?F6VqRdWRiyOIulnoKXLBx0WXLzAS/pt4DH8wCO5woi5Vq8umoEfBbE8ZMdSL?=
 =?us-ascii?Q?8W2RLsXQsgpB4thp7KhcrcmqZvK/nWlT4WL+uuk85Yu2Gcw/IREERdHwBxcK?=
 =?us-ascii?Q?9ZPqBFLFOJJ2kKM+Eq8T2D2WCBuql2f1geSmks87Y4eSjfGasxQTvhO8BzZa?=
 =?us-ascii?Q?ZY2/CQT04tfgpJj5I5KFnkKMYQyoDIcDIA9VMdJxvYiklTXl85dwkTAyCi5d?=
 =?us-ascii?Q?bMKqubQpN54kyCkvUcr8p9V0iKh2pTsTaSiOBrDnz/bM8VwkA9lFNNk9MSvG?=
 =?us-ascii?Q?37CLtfAHxjSmVxFesNxUU/svyfVePPcNej5oEFTQTzt3kJWiU04vODFiY5sC?=
 =?us-ascii?Q?NqS5+K30AhmgYlXJNEbCAZHqbe/yqiTk9X+YPo/LWlbkaPU9SYtI98Xc59Gi?=
 =?us-ascii?Q?uTOM0GwJFFHRSghLYkaDvoJO4ivk1rIyP9TkSA6ZPpvOc0hJPt1DT8fjQlVY?=
 =?us-ascii?Q?NxAlfnLjbJKjUYT/MUKkwUPj4Sv/om4AM1vRaDt6h3pNEnJ3ObkMFy3TaCyc?=
 =?us-ascii?Q?RNexfAnpw7Vw+DfxE/ZRpSqZWCtN4HghcuN1wgukRWxg+dfWJc0xp3qUVuvj?=
 =?us-ascii?Q?OK5+bBmFgH0zDA/Dk2W7+ID9UemO3I93QOco/wb1BJT8kKGldwlph+0uFl5f?=
 =?us-ascii?Q?PyZ2NiLaMAmrbElbgQrcpNLH71IfRvtabkzHSXQzoBzkTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQomK1JHFCLoMiBSzvJr1gM5rvJ/dY1NToKNwFhFS+XEOp2X8wFLNhT8QsPW?=
 =?us-ascii?Q?HVrIy2OKxxX0Q4e5lgVXyxXAUCcWaf14PLRyMQp0XOZIDy6DrHalaPPfUeQU?=
 =?us-ascii?Q?lJslDAdnZaJRDbvZGmANnYkQ3AOr87jeH1ixTjDb0ILVIAIXuC1OW7dMikiz?=
 =?us-ascii?Q?t6ZITCDvbEG0jGO35YXJgQdvycejUFt5pwID/tGjCeUO/zkmLAUAYWEbvmcL?=
 =?us-ascii?Q?b9V+ZfmOayIkMOnuu9gTh7Be0whBHqrPYWgHay48DYq1vwyzLLcPsdFIDlpN?=
 =?us-ascii?Q?3JfHIJTDgHoeLAG7vtp0BjynL+tLidgvjP7TY84pJryAmp3yckCtGJRncYBL?=
 =?us-ascii?Q?fpNIDry8jRqLfKe4/CH7nuGmKlEeKjejp91f1pg1+dB6E06gE6yEylovpbwo?=
 =?us-ascii?Q?CUKBPHyWImA5pXWfQgOU9OcKIYyekHxOtP3tqtLShccKhfnKrN12v406wtjW?=
 =?us-ascii?Q?M1qR5Rq5SZDhoUsgFa1+UWJneHJ60CcjaBnrfZYbhx6xBYAUAUaNEQz0CR5w?=
 =?us-ascii?Q?MEMdFdiM64t1agMriQOSHXxh5NC7KdfzgOnYEvdY4XZ8o1KAbp/Y/8+bN0Rr?=
 =?us-ascii?Q?6/X0Ic1Q050Kkj2LO2bpDg+NkWHTZbMghVnxi/3OXtOwUMdX8N8u4dflgnFw?=
 =?us-ascii?Q?1leQ6kDFW9cmvnDVt6YD4HUlmnToyKrif+wSTFT6xhKlR2wk5+67iioQ/4JZ?=
 =?us-ascii?Q?SBShYFkWTEna7rtJNncT62aJc5TkS3NLpvrnehpQxuWfs+b5V1KYDSm3v4QM?=
 =?us-ascii?Q?S7gO8twsC9NsuTc+CHSTvxuyLBpYHjfNG4wx+az3ddRpUA+/XRdjpNwZP2Gt?=
 =?us-ascii?Q?9bluqiYcIBpcKvUcqAVmlYW37vQGhRbGFzDcw9ruceJkI6ikl3k2KvDHOgjB?=
 =?us-ascii?Q?InePqKznwgEOEU110SDkeg90jjFzgWpahyw0LGMRWQtFk5hkt27aCkRrpuPA?=
 =?us-ascii?Q?nCu+QeiSbTO96vdeEksNfISfC1PKvlBJrKekoLSpas9Lc01UpGcsJ/sJgLeo?=
 =?us-ascii?Q?LxXnsgp16kV793bZdd6J/WupsbrVt5JK4syq0mYMnWcV9G2XGNB+fdfGW7/b?=
 =?us-ascii?Q?IQRvomsEX769IGqkXHl7AVFSYURN7kXMMd5Gp8h/3XX8ttEUP62hGIKo1q0L?=
 =?us-ascii?Q?UZ0fCYGE5JazW81CYs9zp3YGxtJYnNMoLtBgsInaybRY4mVCDJMEEKlQ2iVn?=
 =?us-ascii?Q?uCSxxn9vzmeK4Bn6qXQN3U3w07GXFYUs53DBY38q4oKLEzcWggPdAFH7hGMr?=
 =?us-ascii?Q?3XdpssrKie3Rj2LuHTrXsB6+iy05GDCTd06AC+3ion2Z5tYmheJGXpGYuT1t?=
 =?us-ascii?Q?+nTNUFRNEfEYd35J58Ub5LudswXdadF5ByK+BUdQP9x8HGyfypLTg2TGw+Vt?=
 =?us-ascii?Q?QoaqM53AFcgf7QaXqb/rS43HINW5670Spu4KlviNYudkZjapgBrnSNanSo7P?=
 =?us-ascii?Q?HoR+R26te+EKu+QLv+E05afK+yRr0yNNcjHeYsm8gMPmXdXYb3Spn8HsW4l7?=
 =?us-ascii?Q?DioE2CSXQ3bhejEOt28AyAHPk7cXiPLGo4iAtizTxtRmKsGwpHVu/suv2Xem?=
 =?us-ascii?Q?gWOwH+eepf5HRw49XKuyfZtTPtbA7sw9kspjypAOeTT+dpZdRTybbYgqkTpY?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db1ddc8-5413-4a61-897f-08dc73e7a597
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:29:53.2007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DFfSAhi5CnCHL/qi8nsqMaWCVaAULa8/nWVUjtLDeee9GFCWFnghNADFc/BBoTM8XqvJApuPY+fyAAEMOn0O7Qp/DTJzO+bMCTNel4C63g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Monday, May 6, 2024 2:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> Samudrala, Sridhar <sridhar.samudrala@intel.com>; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>; netdev@vger.kernel.org; jiri@nvidia.com;
> Kubiak, Michal <michal.kubiak@intel.com>; pio.raczynski@gmail.com;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v2 2/4] ice: move devlink locking ou=
tside
> the port creation
>=20
> In case of subfunction lock will be taken for whole port creation. Do the=
 same
> in VF case.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c      | 2 --
>  drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_eswitch.c          | 9 +++++++--
>  drivers/net/ethernet/intel/ice/ice_repr.c             | 2 --
>  4 files changed, 9 insertions(+), 8 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

