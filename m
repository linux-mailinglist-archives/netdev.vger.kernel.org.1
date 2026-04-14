Return-Path: <netdev+bounces-278343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE5iFFf+3WkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D33F77D0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 281F2300693D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E33A8742;
	Tue, 14 Apr 2026 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxgJaPoL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45092291864;
	Tue, 14 Apr 2026 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156240; cv=fail; b=bNe0rZtrdMlShurYZJzuhw1Snnma5yzMg34gHS70Wa7WA9XmfiPNTwN/z8CeOkvpXpq13a82xfP6jgKZaix5hvyQPxkacBUyXNBaYpNBhYF+XxF5Lem8dkKm6zNRoRam+90trHDDgqYu1qkg9VCnePVjvsVGMxQ7+gWGuW4eECY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156240; c=relaxed/simple;
	bh=fHIiyIfhGsjWE136KA+gBZFOTc1+ui6fC5JwxbH/xog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EDp0wkji4MfgXWBnbeNbwKSkIcqXuHHZIq2wg8Phs6PCTFrpJbpXOONg6pgf52blJai7VsMYJFQ0xtugwz1uM91KGfuyPzntkYads8gWSi9jRWyl6qM4ND5kUkXJkBFU03EXzO/uigyRdm96rMSDdLdJroDkHDuKvida+uevAaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxgJaPoL; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776156238; x=1807692238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fHIiyIfhGsjWE136KA+gBZFOTc1+ui6fC5JwxbH/xog=;
  b=OxgJaPoLNIWL3Iae7+vdiC2NW/PZ/ccQk4F69hF8uPDI8O8VHBoNCjzY
   OZHBVlp1PzP8cFNB7XHEqwAJlsG0GHoigew/FI2nv7yUGDmd/WhtlWLtW
   r2kjDwN5qttjcQi2rMaqPFHrWFhMQ/KGHNh8NVYrsqTYrS+a9Y9x1qSWG
   tzVKgH3rsQObE+aKipElrGZcuq0M1g1P53HQZQS9YayJ/R152BRfx3T0Q
   EEcuXcboDIKzPukYKFUhcs6IQ9fZYzTz/ztTG0k5Ym2O14kQYPKFOznZa
   1ImH0F10b+sTt4z9WyDazR9kDv9Qxg7AIibySObezgTaiI441wI6gCDom
   Q==;
X-CSE-ConnectionGUID: 0ngr7yOzRxq/AmFhDGjiyQ==
X-CSE-MsgGUID: /KmyoEKCRt+BEsoX7USeTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64642162"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64642162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:43:57 -0700
X-CSE-ConnectionGUID: ooa4Jz3KTCuBge13RT01Ew==
X-CSE-MsgGUID: 1KUhvPf7RgmyDJoV5wotTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229909177"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:43:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 01:43:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 01:43:56 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 01:43:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHo4ZaT1AkNzY7QffBprxXnxDceQITboaAqNyx8c8h7Hz4a68ORBI3/3AaOdqSfUmzBrGZKv67/YBDUDg/fzXiOjXWz75rI6tWXjHfaRMeR/wGWa5UUd47x55FXZDjnMMh3ra2vQCr2NUvFgxi1sypJNEL/BzWTnBWiT6rF+0nKDQw7zmN6va2o0h1BdytdU54nao8AAgjbhG8W7U+ucYR2M6+ilXGYAAqMuL3hLTVtqabEpJwQC9ylwApYqXKkdtpY07m7YiyEfXOLUf7xXVDcK9qw6SD3dcyYCb+qwGEv/XJCxRaaj0McgLEsh/4nwVsh+MUap1FKWnNyJwd/8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfW4NY60C/bwnQ9pjdUE8de3J2gv2SSpYE+GGz1lwKQ=;
 b=MCiCzJwGomgeaguKSViCiFIIdNZF5wB+5BVpqZedUS4tBvcUDUnSZrlfNC9CriACVfXdv1YIMz6nSm+PCtUVP6m5dMBclmEqiXWIMdBBslsVpwulrve3ALmclRRZsCNlRLP/E1MmfhAv2xPaBSbT7KDCodEd+JBJvDf9NfiE608BiDjAO7EBMzIgk4TW2qhdj+PPH23OQ5WQJmPzp0MqQn1o16FdPIZ/LHX+8ZMtKDqxeVAUUZjocnGlQ7TD1FuLGcHXHbRvJ1/HcvZbqvviLCnUbscj3FEFn1nuicsqosOitSa5Cm5Pjz/9B/lSzU7NYHEP6YfsO4rS0LH5VKUFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:43:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 14 Apr 2026
 08:43:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>, "Ertman, David M"
	<david.m.ertman@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
Thread-Topic: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
Thread-Index: AQHcy3nU1atNAwqxf0yC9yKd/4co+bXePnfQ
Date: Tue, 14 Apr 2026 08:43:47 +0000
Message-ID: <IA3PR11MB89867EE1AA6F3CE065CB48BEE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260413191420.3524013-1-poros@redhat.com>
In-Reply-To: <20260413191420.3524013-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW6PR11MB8338:EE_
x-ms-office365-filtering-correlation-id: 8cadec66-7ae1-4579-cf01-08de9a01f201
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: hr2sFXfm3whRROyQMhXC0Qd1rErL9lVomsERYwMJQ5E1KsUFapdN8GW+q1Pxv0k8srX1JsMetOjcF59l4uLzebOLMmBCmNX0Zgu7H8oOuMiX68f+v3gDHtLCo43kwwAiLV/eJxMVoC9J3731F+3f4LqcW08aHI62cEy3AOEFTjBr/odpu/SR9xKR/kxaFA/L99zd8a9L9GF/qWS/MPslnstGlKxINQyCHOuXVZPSWGZqTVo8skVHP4YphvrRuwd0qXI84vyVF1W1vvLwHqlBpgBlGf+LfMO9q0p504An2Zxv5ZpchcnUf46XKTw4hmVtgRi/5miQY2SBgMEtpWrCaTYliMxQU+8AcQ/DJDvJ7zFp3kMJzdyvkxdABv7U8vMwCFJeNG9fiVSK8QCoFLnS7VsesqHnBhl+sH57sc3sbzU8bSCQEGRwFxza7Z70vg5qGDIusBoyKycLTJCG87VD9FzFCdGJWEw3h4FH4Gzmz3dCcAlP081+pcK7FBSFe9IHk/qXnID4OAhAL/ri4rROkK8ad56hRkIR8T6nHwYtvHHG3Q9i/N4V3IRSzkVuNWndPJyRkK+eRRdL0DAE1vh5PoXvv3YHIQJKjsUubTS8ZRuvpp82mPR3pAPbZr2/88EpIWD6NOc6fI7EIcqqes7hyfMGMXCRZnr9K5W1AnbjkhH6XAijtZH3CKE2/G0W5cARu89norN0Mc4Ibwl0S8QVD5SmS0X2CHoMUfnHg9NssW02rIFA7jYboORBSdv2yAbhhVwj0MK2Jdc9vVDdzJDnYStz8yzJUTOyKK2YZVoJZ54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y0WcHoVH31KkrxCBYmu2ouMkiyB6aV7iHYY+Q26beHkdCutZ8raumgFtPCrv?=
 =?us-ascii?Q?nSHUgfcnqObp+0y8ML4A1hWen1d9TtTMhF7WHTLBhifJ2A1/CNIz0C8ajFRX?=
 =?us-ascii?Q?g7sTP8yB88SY5TUxCBSTw9HLmWJjgmPkxIeUsZZSoTEoCtfwEV1pUyoZWdkm?=
 =?us-ascii?Q?IfgNFkyRTiKeziZ1/BdGqpE9yhhuF8VGSdSLqBRfXurQSI5Zlo26UgHrA/Ju?=
 =?us-ascii?Q?wdWcKbV/3mbbVfFxaK67XEpudFPbwmk2ivIKsS7VbrSngVMAi76obr1/I2NZ?=
 =?us-ascii?Q?flp+NI2t9FIue8Tl2h2ot41uWpiJiSfQ0NbhGP5MJPMVp/nNK5TzOYmepuCm?=
 =?us-ascii?Q?8EvW++Ejs/mbICxqjNGVj1tNbPA9Otb0lL7LQaKb55oKY/WWuj6DHl/4/LWk?=
 =?us-ascii?Q?/ivWNltxCrsALrXMoeMgeUPDbHS+SQpApin50SyjS/nRZXa5qEr5QDm1HCJv?=
 =?us-ascii?Q?i1r1+cqeoC3lhImBtu05Q+byKLuiFkSKbqElvYdKnP8ofrcQg3PySjfqXeMI?=
 =?us-ascii?Q?5JEGQZcGFSeJbsqg/RzTywNhNyCOPHMAGgQTkZeQV2d+ZNWI9bVM9T3I1OEe?=
 =?us-ascii?Q?U6KLz7k8uo3o67+4XniChqJoIxFJyjA4dpppBrDqkTHNzouErvSzteUMVVvR?=
 =?us-ascii?Q?MixSAc5eINXxBHgKnMbtrrnXGlF/JiqvB1z2hoTPdLn0XbG4xp/4uzFHiZ67?=
 =?us-ascii?Q?DzNiBAK4B4d2bg3PJVL4+qpWNorvvi15S/SLVf1iY57OVJD0EYRAJbJ6r1wb?=
 =?us-ascii?Q?+76gtByvXo3XifHiRPPrlbYk3kUeh74Ry3sc8ya/t5EaDXIab00uDPVg/tzB?=
 =?us-ascii?Q?bkFasslke+7OV4NitojKEMLHNrwuCIXyXjeTnoI/XoCj3w3KKTDSl8fEu1uU?=
 =?us-ascii?Q?J9F2hwLXfbp4nODW3nAWx+vPh5QUNt+JCLBgK9hqaiQeq5OqvWMv99GM+330?=
 =?us-ascii?Q?DxNelCIETf4pfmOsZtGFtmb04RwPGjR2duIGdyuNTNvG9nfTQLMGiU2ofd55?=
 =?us-ascii?Q?FobjYdFA2kbFJNTHH21wEvHFwq7wt9G97m58lf35Lt2ccBWmYPQVeuWAsRkH?=
 =?us-ascii?Q?0HJPSrngDyoswVkYF6TqG7ljNVYX46kH1tLp3oS9Y00fnxBiBtMkPmJ622sO?=
 =?us-ascii?Q?ymyfz8xlbGPkXCtvVKK2M6atMejU95k194nzLukq3J1AkEEgU3dHVULrAAv/?=
 =?us-ascii?Q?qUlcMQ+wktY6HngCQcIQrEJf5BOpc0olhJZvms1nfs9oAJ8eyWemKgsZxumm?=
 =?us-ascii?Q?+xqVQDdVu2iKtjLHbmLx0pZeUhv7OsnAmB51qUjS6xmZ41LfL4CkIOxiJ/ju?=
 =?us-ascii?Q?6o1DcjusMQZZH/22DlBAd44LLnJrYHXw0SfjqITsPHrVvfDbPhnR7Qc7KFLy?=
 =?us-ascii?Q?imb35erX5StfYN/N6vJu4P1QPEormONkI52l83OYhFIPuAip3Gvit3r9XpIV?=
 =?us-ascii?Q?s0jhwhQgIPDzC4JroCnjxonlORf9rzNxL3ebdI2siA1vBgFwKjFdmjeSKe/i?=
 =?us-ascii?Q?gbsyzdZTR7stzcxg8hU6aFEeTolE5JrHIQ/VaIdb/ZdZCETM+ABCVArCfEea?=
 =?us-ascii?Q?aqJabiUo3SmNiHuL3RwPnLERhxyGHXtJO1wP2bwG9Ev5NZrNKcH71bmQaJ+i?=
 =?us-ascii?Q?VRzk8AOHwcOiL6h25q91jpI4+17SGPGVEShYE5lyoKfPF6sCJC9Rk64ZBWJ0?=
 =?us-ascii?Q?xrEN/SYOy01J7GsCl6Bp9Sr0anOr/xAGlY1qjJ3l6Kmagr49zxbDHMjN1q3j?=
 =?us-ascii?Q?b4PxjzWJkF+6yv7scfCb6KDIroflUrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kFBNBAgHGkQm4QzeVEw3CMWuhu3zkdmSgdznj06Uj2LaUoBg234z9DaR7OENHhjgocjg93fRDjZX8z2pXJnwMniYzJdzMFfT70Gkt7rZ29fawBKUeGTa03ISyMEnMa5lIXVp3QQjgx1tUfAJsGTNMSZsP+v88fNwriowCpvTz+9lzFtY0453oI7PmTQpDWRlHsockMW+vIXGJDjFvgakXdQO1k1TyZgLXEQVBxtEY8I+lrQrFXIUOtWrfbYkasGESMOMpV50qaJ5l8BE9YbRzhlgKcscpr4obKkjzDrsg5f0Umvcq4EUaPwiiggNSkazRu0FS1xfkIS/Kcg2wTPuWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cadec66-7ae1-4579-cf01-08de9a01f201
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:43:47.8793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Qn+nDSo2xtUX02E8DtT76C4va0BZ3vlZgqhQk4w295r2OzXKBbgLMOlffv76WSEYS8kh57WrBGPp0/H/DQAFLMtmqKXfqSYSvAiOnAlEKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278343-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,blackwall.org,gmail.com,linux.intel.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3B4D33F77D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Monday, April 13, 2026 9:14 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Nikolay Aleksandrov
> <razor@blackwall.org>; Daniel Zahka <daniel.zahka@gmail.com>;
> Greenwalt, Paul <paul.greenwalt@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH iwl-net] ice: fix infinite recursion in
> ice_cfg_tx_topo via ice_init_dev_hw
>=20
> On certain E810 configurations where firmware supports Tx scheduler
> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo() may
> need to apply a new 5-layer or 9-layer topology from the DDP package.
> If the AQ command to set the topology fails (e.g. due to invalid DDP
> data or firmware limitations), the global configuration lock must
> still be cleared via a CORER reset.
>=20
> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
> scheduler config fails") correctly fixed this by refactoring
> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
> lock and re-initialize hardware via ice_init_hw() afterwards.
>=20
> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
> breaking the reinit path introduced by 86aae43f21cf. This creates an
> infinite recursive call chain:
>=20
>   ice_init_hw()
>     ice_init_dev_hw()
>       ice_cfg_tx_topo()         # topology change needed
>         ice_deinit_hw()
>         ice_init_hw()           # reinit after CORER
>           ice_init_dev_hw()     # recurse
>             ice_cfg_tx_topo()
>               ...               # stack overflow
>=20
> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
> caller, ice_cfg_tx_topo(), intentionally does not need
> ice_init_dev_hw() during its reinit, it only needs the core HW
> reinitialization. This breaks the recursion cleanly without adding
> flags or guards.
>=20
> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
> are preserved, only the init-side placement of ice_init_dev_hw() is
> reverted.
>=20
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit
> paths")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 ++
>  drivers/net/ethernet/intel/ice/ice_common.c      | 2 --
>  drivers/net/ethernet/intel/ice/ice_main.c        | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 6144cee8034d77..641d6e289d5ce6 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1245,6 +1245,8 @@ static int ice_devlink_reinit_up(struct ice_pf
> *pf)
>  		return err;
>  	}
>=20
> +	ice_init_dev_hw(pf);
> +
>  	/* load MSI-X values */
>  	ice_set_min_max_msix(pf);
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index ce11fea122d03e..b617a6bff89134 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1126,8 +1126,6 @@ int ice_init_hw(struct ice_hw *hw)
>  	if (status)
>  		goto err_unroll_fltr_mgmt_struct;
>=20
> -	ice_init_dev_hw(hw->back);
> -
>  	mutex_init(&hw->tnl_lock);
>  	ice_init_chk_recipe_reuse_support(hw);
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index e2a5534819d194..a27be29f9bbbfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5314,6 +5314,8 @@ ice_probe(struct pci_dev *pdev, const struct
> pci_device_id __always_unused *ent)
>  		return err;
>  	}
>=20
> +	ice_init_dev_hw(pf);
> +
>  	adapter =3D ice_adapter_get(pdev);
>  	if (IS_ERR(adapter)) {
>  		err =3D PTR_ERR(adapter);
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

