Return-Path: <netdev+bounces-297061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGS6OUweKGoU+QIAu9opvQ
	(envelope-from <netdev+bounces-297061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB31660DA2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:08:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nLbj3RRY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297061-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297061-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530D13005D08
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE4379ED5;
	Tue,  9 Jun 2026 14:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716263793DA;
	Tue,  9 Jun 2026 14:00:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013616; cv=fail; b=mPYKLCgmBg3tdRA5+f1zSiFPBQLqts8fbT8MEyAiMRnWKqjQt5pku5BB67aKxUwWyW3mvzyVxyNH4Qbi5HvJrnAGiOIcGTUUH6a5YiWQsRojOnctCZMz3k0fvvM87hmYhlTeLGHPdD7+XZNslP0SZMuRlW7b5mjVHQ416OoWLmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013616; c=relaxed/simple;
	bh=+HlCnizcyhFCw3soH5SHrjH/mzqpzo7EuFMJUOyTz0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+VvQrdRqzUf7YLqMNoV1G0iaU8rryJ/Bop4jrajI/P/dENZ/fzPm8KLf/O62B8WhOzwDBDQHzJ0SX9KklQm/llMb/5i7Xell0ouWqpGQd0YPDfsmVxJRlcGn6j62/MO4BxbetXHUWccBy3bSnajW5LSueG41p2tORsTeZL4rGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLbj3RRY; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781013613; x=1812549613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+HlCnizcyhFCw3soH5SHrjH/mzqpzo7EuFMJUOyTz0Q=;
  b=nLbj3RRYEClPHujBlzHMIh/dlV6bXA78nyui07gvwSnCFfKOhN8coJti
   CpfPK6pCfc6jb/2c244w6SS3gnVIXgMhVCsFLUUNPcfqXbhwU2t7mBwwa
   L9PKqguEUhz6KaJ3pSbW8Ywd/epXajl98JlJByN6+2QPjscTkQ1gaEPQ3
   m8aQJlAAoD5PfhoNO2vyLEqjUEfGwrUIzfuD+fM1RnVwp7rPvsCr2w0Fz
   To6JbX/xaUU1/VnkuvMS9glZLQyY8pBNgv6MyllilDZ8KAebv33CxTf6s
   PQS8ht2Ut1siHsHrZAefGVOxbZUd6/aTsWTKFRdIkITB2dCAUJkAYTtL7
   w==;
X-CSE-ConnectionGUID: XC3KTiIfSoyp8zJ2aUAYCg==
X-CSE-MsgGUID: D6hAXt1uRx6ZGGtqgcDqAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85664610"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85664610"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:00:11 -0700
X-CSE-ConnectionGUID: lFiTBEW6SCGvX9aQt/qO8Q==
X-CSE-MsgGUID: 7l/s68+pTm+azmCW3H7Rbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245965018"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:00:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:00:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 07:00:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNcQfbg9PeGn0fChCuSv2Q0yJX1POlsDNgiEGUqYIyBia6KE7I00DrfXLSKAH33gwRoyXY1HkzjJX3/ZdHwLz2kW5gpFfRanGItov7X5UakUZ9J6AYp5Mntel6RqHZc074AaBSM77mG87FKURTjnsOhCeudKpzX8ZT9ETU4sEGrZxbDs42wbBM0NUjNs0WxQAsNWGi4TmRcJjy6qRti1mDKw8yhwR+Y9rrTMIgfFB6Oo8NzNljerHX+QoKqLikgbH1olhL1UbDoXE64Z69fkcvzZMqwKy6EY53zKMA0dIaY1Iv0goRhIOAPFK3COJ5IJOSk+wWhC4UE2Dwfhl96t+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eTB7ju/UNHwOq/sRkDBmfuAmzprA8W5OAnejBxrDYY=;
 b=ZtbYJhlwgL3idYJaFFpXghA09WbJtZaVUj+FIYBI/QGaHighe4RhgUjY8Bp22PSmWpCaCX1EkMbO5vFYYI9pZkV5Sz8TA8Z8KG2C+3Ib6BsJyK8p7/g1RvmQiB499rPx4N4UqUx24zWVpr639m7CWB5qfbqB87Yll7/HcmOW0gdCShleDB+4Q9MCTjp8f319kco/Gb3jEmkwHO/E/AVOywhzEsjfQKTIEF83y++MDAnr+t3ZNEsgDw+nd69EhZhRc4wzlr8Bjosvdu2lLaPtOekf6+09akZXKzjjpEriKYAdMcaTh7iZ3c9RCtlgmWX0+jTw0EHkVwf/1JF+mXZr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14)
 by DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:00:06 +0000
Received: from CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968]) by CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:00:06 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Schmidt, Michal"
	<mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, "Vaananen, Pasi"
	<pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Topic: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Index: AQHc8TXy37RQpn6zaEaBmwzfbXb7M7Y0w/LQgAAWBwCAABGk0IABDEQAgABT0HA=
Date: Tue, 9 Jun 2026 14:00:05 +0000
Message-ID: <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
In-Reply-To: <aifTFMZtWBgLzhCS@FV6GYCPJ69>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5394:EE_|DS0PR11MB8163:EE_
x-ms-office365-filtering-correlation-id: 9ec1b112-52af-4f82-7fcb-08dec62f68fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|4143699003|56012099006|11063799006|3023799007|22082099003|18002099003|18092099006;
x-microsoft-antispam-message-info: THJaPjUf1ClukflSs5MxJzu5KFe6bYgpAYu7R0eEXKe1iUNpP7CKQyE8lHrMBSW5VmdmT3A5oksXLUcJwHI1R9AEYXtafYIRaTlkbLFSRA8dGW1SDAjw7dB8kBCt1CCCxAbu0GpoF3K4IFO4EEhH21I5h8GU8ApYST2ceCDOHDQPatiW6Qje9Y4HhjJHsIDr9Y2NFOOhiu4Ucz88vu7Gv8uC3KKz40og00PUIjnAfGeINhlJf/4SGh1FTKzsENIzno/RD1jJYkG0w/gsRHEKkTBwXZrqzd5eN/8la+7089tUTLk+ls8pk1z4vvZ5cllS3cDGAAbviv5T8I1VSmnt+8ycQswjcdAXGb1/X3NpZvvIWgHmtSXYSLEsaQnS+TycVJhC7OpcovRmJpvx2aTKUvFXt+2Er7Nmk4BOqG9M8AVBW3cBxxc8D6Oy2P+OMAsPGe1k73K1VUr/Luq7J+PCuEGpuwGQG/dCvnexxc1PeprxS9jsvTOVHhD9ZvEX+ZYU/WS0u4jeEywh+KjdVq6HOr/GcdHh7BMVIyTPTnS7ZmTY1UHPWMRuoic+hblW3dHTymxLvGWq4wTzCLkRh05Czzoy1ECpcKLdTN2PhjcIbGXrm7mcN1rrtfDFZlxUh0PH6YcaDHx4+6yxyNi80ix7+Rqplhg+oMuKsc4q7vU+3mzeG49CJpNBMtfanKc2jfLinGRhQHhjJiqMafgKf7YR4+MR22M9867GUIhWJxYrRqUvN/jH4byY8jlITqeRuQ3Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5394.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(18092099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m3UrPl8MieU1R+Jsu4x8YZAeCINSjfGxh3swouOFVcgIgLpwzsDsbv0Sqp2x?=
 =?us-ascii?Q?Z0JgvFCuFqrQLOYT7CUrpLsvy7RhEaMibsI+z/T24g+IgTZHbB+e34oABSkw?=
 =?us-ascii?Q?LnrCH6sRiK+kDHnpHOgsSkQrF4wusvRHnkFLxgnEaUuU5JLPUcrYtbwHvj/L?=
 =?us-ascii?Q?7G+bWXUOfGq+pyMd1slczrVUWinorjxdcd8SiK2cRXJuz4kxoSzNV73esj9s?=
 =?us-ascii?Q?1TS4JLAbe/jq/4EqKnPh2GLH3XKxw0Im2s22XAeAI+2rN/8nEsExPxzcYC/o?=
 =?us-ascii?Q?HeFOqxKUZjmbfsnbSbZ7fovuZfy3+mAm5X4gS2hn8V0xBAG2JCmkfv+A6FC8?=
 =?us-ascii?Q?yTYxNw4fVVKiP4UwJJz8bpVz+dFNSnUDzW8W886Zop9ifV10vSEg8y+FQX8a?=
 =?us-ascii?Q?wcX35M/AFy0/O8x7R2H2LgW/CxkBUApT+BYVtVcbSzzWlbn2go/YO6X7sp2p?=
 =?us-ascii?Q?Z01At4H9WbLmRGeQ2XAp6mVb8tYAxrqDPivbh+yX4FCc5DEKzEvjmzkx4aPJ?=
 =?us-ascii?Q?WDzYV+wEBpsKzRIzfQu7AAtIo2HvmMtlnK/cRsi9pMe4aKAL1jchEOYQcDq8?=
 =?us-ascii?Q?PGq0TlESE+R2eM8y2bYLBRKJFcxqPSDLvJgGGG0wXTHBGApwiWrY2l8ZrIgy?=
 =?us-ascii?Q?Jl9mhfg32p+vnsdVRej6cOylNXPI5Syj5nTDTEYYbsveiU7DWJEKlXuxkB9T?=
 =?us-ascii?Q?NeOSlU/AItqr4q0Jrd9ead9FfrXFGfFftfwDGcOF5Ln2FFG4otTEa8S6V3Pb?=
 =?us-ascii?Q?Zc96il94ygT+6QPOBuAuFdyNNAqnG9M4D0x8hwlQkDn0McIcrnkdMEMez9bt?=
 =?us-ascii?Q?EfIxT6J49+Oen6+HkGkd4cBX44KEee9bTxuQixbmEjXvCOMs32Ir/7G96IcZ?=
 =?us-ascii?Q?XbC10Iv6veOy4q/QNzaizPvZHZJ+GOYE3Qhj84963U4gNMb59HJ0PfJtX4St?=
 =?us-ascii?Q?JTT6LKb3oWQra3b6c64iGyg+Il3jY1xOk9VTOkbcvZRbh83sxYR/G0RxKCHn?=
 =?us-ascii?Q?yN+m4tCApBaadDMY4wqU7h2avMNOP53DEwP2I/F1taNWJOW4J3Xo4VRSVplX?=
 =?us-ascii?Q?seZW47KCLlwIbi9HGN1iCex5IU2XyPQzTFQlk8kOQd8uR3INljwZOz6D51S2?=
 =?us-ascii?Q?BGQncsjFI+By2gTHbIcBfBauovwxGN1ICMXC46mFU5//gGe+W8T5tKCTqqWJ?=
 =?us-ascii?Q?DR+3Cbhsn9Kz/6Or5V4LZy7FB5Y3P4iq9FMjPuVGWYf+EAEGI0+dVIIbCjzm?=
 =?us-ascii?Q?UwB6nbLHJ1pFKoM589vCzC7efukeKdZigQOm2Ahpo1T4aSByhh7ZmXVLHdon?=
 =?us-ascii?Q?XZbegtLHGjvLGAGO3lzwrqjYpsjxHCy5wyHJPoZkxyqHhvpmhyVTOMnwOJIG?=
 =?us-ascii?Q?mBpj+ARIY9TEd53uuzqYCiRMooDTLLUqPdELe7Oi0tZ1p4SFDQyhLR7eeP3Z?=
 =?us-ascii?Q?rgXFYbPv73cuEz4deh4v2HfjyhuWqA5eJOlSL989vDa81V78hnX4Xfqez0A8?=
 =?us-ascii?Q?++4CT8vx3KiK90sXt2JdpRbwZ1dT8SYhmC5eSKnpVD9OWeeb2sG1MYK2kr2d?=
 =?us-ascii?Q?ju6ATvaZcQAplKipfPFUtYX+EsIkWcop6to4T5rjD06KyQt3zgoknbFL4bWj?=
 =?us-ascii?Q?neGUaXb/w4ASTkIe6epak1xvRlzylHwJfahjdFsFe6iM5hypl4Gh85ka41x9?=
 =?us-ascii?Q?M0R88iAREQv7QjYlqmhdRIey9EWMNb3UiVWISsByQxvWRuiyXrSTzgGvJOib?=
 =?us-ascii?Q?wcpCmyBTmMGWH/ArjID+RzJ7fH/ArXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ok2s6rlaSySDTD/mRZtSfEV1txkJEGI6xuVgxS1Er81D124ddpGLW0DAlXTMiDjxK5rq7U/EVy56vWLgDz4aXDbxHTW7VUSWcyV4Odf8IgmmwLeHX/NKUsatiErvGl/h392f0ay36iQzGLX1pYdxxqOEeXtGE4g+a6mzLWCjY8dcH2n4bW8SgKvDaopTj3fGaoX8KpFoq/aNoyvzrB1W1rQMREYZQAAEk0T8QWRja9SlDtxWO+LIFKEtJYdpBgll1eNsJ/hA2l9o4cShOQlcxnotl66HAWhqBxw9UccAhe/9kxMy0Pbfzw+CVDzxJdO2XAg1k5ZJQ1VigvPG767y+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5394.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec1b112-52af-4f82-7fcb-08dec62f68fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 14:00:05.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iOjXx3svPKOHMfcKdDlbxeu+y2PXPXSWQpvhjPJLARzV1M+QzmP3rD5Wwby/E2RP/LrdDOJ8URnDDT0xuAUtiA+WimhKPCNGvzgc+E68hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,microchip.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:email,CH0PR11MB5394.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AB31660DA2

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, June 9, 2026 10:51 AM
>
>Mon, Jun 08, 2026 at 07:03:46PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>>From: Ivan Vecera <ivecera@redhat.com>
>>>Sent: Monday, June 8, 2026 5:48 PM
>>>
>>>On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>> Sent: Sunday, May 31, 2026 9:44 PM
>>>>> ...
>>>>>        -
>>>>>          name: gnss
>>>>>          doc: GNSS recovered clock
>>>>> +      -
>>>>> +        name: int-nco
>>>>> +        doc: |
>>>>> +          Device internal numerically controlled oscillator.
>>>>> +          When connected as a DPLL input, the DPLL enters NCO mode
>>>>> +          where the output frequency is adjusted by the host via
>>>>> +          the PTP clock interface.
>>>>
>>>> Hi Ivan!
>>>>
>>>> How would you control this in case of automatic mode dpll?
>>>> Automatic mode DPLL shall be controlled on HW level, such pin brakes
>>>> that rule and requires some driver magic to show it is higher
>>>> priority then the rest of the pins?
>>>
>>>The NCO pin can be connected only in manual mode. In other words a DPLL
>>>in automatic mode cannot select NCO pin (switch to NCO mode) by its own.
>>>
>>
>>Being picky on DPLL_MODE for enabling feature is not something we can
>>allow if it is not related to HW limitation, is it?
>>Could you please elaborate why it is not possible for AUTOMATIC mode?
>
>In automatic mode, the pin selection logic is defined upon prio. I can
>imagine that if NCO pin has the highest prio of the available ones,
>it gets picked. I would be aligned 100% with automatic mode behaviour.
>Is there a real usecase for it?
>
>[..]

This is not true. AUTOMATIC mode is HW solution, SW driver ONLY
configures priorities on the inputs, not manages the active inputs.
This brakes that behavior, the SW driver would have to manually
override the AUTMATIC mode to be fed from such NCO pin as it doesn't
exists on it's priority list, HW cannot pick or use it.

The real use case is that any DPLL can switch the mode to this one
instead of implementing MANUAL mode just to use the feature with a
'virtual' pin.

