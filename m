Return-Path: <netdev+bounces-254593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EtTKlAHe2maAgIAu9opvQ
	(envelope-from <netdev+bounces-254593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:08:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 255B9AC6D5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAA9301A417
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDB379989;
	Thu, 29 Jan 2026 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9qZ3MfI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B01376BC9
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670478; cv=fail; b=AeW//OcutugdzIPCVpYzojdRGYkWrIpUuRMRMyFVYr4JQq8cg9yneD1wTpO17ldD4B6SWBHHWJDGhC3BdQ+6sr3qJod/ZEKt+2rMh4qoynDFus4wjhyNaGMiQ1NrOzSphhGGMX4kYINVQBKY9IBhWA9cFZJ74HzD0iqgwl5M6+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670478; c=relaxed/simple;
	bh=BVtFEJE4SL5rMqonMPwllvXWhjXV50/U8Mn+9DU/0Xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULa9pT8ijeSsIXB/LhcBGsnHFGNQrVhxIDV3abbu+mLt75pYVobqfd3Wrv467FDmz7+WL60e4s0vpzZAF5gd22hHzCyAyLlvh/fcBoYA+1Ul4en9LfxyuOUxBzGRbaM41NPVqk53ijcmvJN7LWXZxhlsJHRGbXlFkopwO4eX0Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9qZ3MfI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769670477; x=1801206477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BVtFEJE4SL5rMqonMPwllvXWhjXV50/U8Mn+9DU/0Xc=;
  b=K9qZ3MfIyV4H0IUtcqDcthkRiojwfbLTYcH0ludpmLQPbi9LmlWc79Vp
   FPhLkPmMYL/Sb6iFLGhjYl9EoWPcx5aTueg9c0eluVOx76baN0wP8vO9J
   4+JPr18wGo08LXNyJV0Nzxr1ViUxrfJ4oy684dU4Vcgqpx5GKzu/yK2OH
   ha1Z5UXRfAiRjGtEa/sUwtfVL+PZNgQxfqG64pz9SF0S/szJYwbU8LwwV
   si5e3FBYaI4UfH96WgF7xPKncGRaMoaj1SeZNjrHxNpMGZFjwLf+/L1lW
   cP+gED2A733pwaPt97/5DKOVgb7g5bPcGxU0gM8lqXWQ1IBFjpzuij5d0
   w==;
X-CSE-ConnectionGUID: NmdPEPgRQ1qMGNA+lI5gGw==
X-CSE-MsgGUID: 3RHRhustTOaMV7gLrqKSzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70793527"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70793527"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:07:57 -0800
X-CSE-ConnectionGUID: DcN3gqpnRQ2bfrKWZTBTbw==
X-CSE-MsgGUID: wZ5mwEW0SpqwB1IErQt+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213362219"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:07:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 23:07:55 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 23:07:55 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 23:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaQgocbpspwvarAoEvjiBAi9AbI3zO8MLeMPNnjZBhoAhBEf5reeQJPck7a7cIAnvTi/h35Zdm6IPpmBJcIlkYRDClcFRc21xVykfpUgPMWJkHna5dk+EsHsKcU8KuZmUCs2s9EYIXmTF0G7dzjP1g0gDfPYaEQ4+CI334UWtN3mdBZhyPLiVi3PDhdMS7NgE5YNTldLWf0btcHsdv6xq4zwC76pe9OoDxhePnHN//PsUFV+o9FmqO8P5yy3r0FJDF0yfGb5OIpl0LWXl8rrJUTelhDN22DMGrzrUTYBhzCyKC7caUqM7YoShZnt+Ln5n8kcRmICMrtayuT50QNB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNiikoLg0wkwQx1XeC+keouRBgaP4T6a7yn2GxOahL0=;
 b=KjG9tiRtZlS3notwWBoah7vcyRgFg63FzlgQkM/33qtsSppSLY9tdwvk+1PLdUAWV5yYueULhtYXSgO3f85Y3E4hfhozoxF2jVnrtWLCdkNU7i0oI47C+YEYrcOMdYKX1aC4bWpOVBDOWJ3TgKpop4RBawmYDsRYC9dSoVhgyiiUGGC8qXnrp31zagiD3JtxE+Ysr0k9TPzijT+9k32GzLpIpQP5hRJj5HvH/kIfxYiM6oFRDD6yDuuT0qbv5vKhfMdWpipHqfzjgqZmEjborxpqt2i1CPm9LoBKkKYk4+5ch/gOfMhq7XVHyVdfpMEnpHJc+mKfX0wXEND6ULvqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 07:07:52 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 07:07:52 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"aduyck@mirantis.com" <aduyck@mirantis.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH net v3 1/2] i40e: drop
 udp_tunnel_get_rx_info() call from i40e_open()
Thread-Topic: [Intel-wired-lan] [PATCH net v3 1/2] i40e: drop
 udp_tunnel_get_rx_info() call from i40e_open()
Thread-Index: AQHceDH3Too9ODD+c0WwFcFpzjUfNbVo2/Vw
Date: Thu, 29 Jan 2026 07:07:51 +0000
Message-ID: <IA1PR11MB6241DC627D84F32FCF7FB8448B9EA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251228194021.48781-1-mheib@redhat.com>
In-Reply-To: <20251228194021.48781-1-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: b7b77268-5e1e-4c9c-ae2b-08de5f051e3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fAiiUuinTNz6J+/gD0FBMVG3MjLC3IsO5zRfpSOFzbtN0gG37ayZFwfmwM0B?=
 =?us-ascii?Q?PPNk234YjfVYSlz7bE/KOq3V1vclGAk0jJoa+GW7U5c4jRuoZJ/vy8fkmnxN?=
 =?us-ascii?Q?8SNEEoBEznf4rhKG3wLBNG+aDrNLLgbThkG2z/5C6MzS+GoWwmb8v7drh7p/?=
 =?us-ascii?Q?o1mYTbyt85f+Og70rvV1A/FE0i9U5zXaOtCV88uZU+qHo+Xuj4g+nsWiQcrM?=
 =?us-ascii?Q?Kg5E+NF8Hr8Zfa5ePlQCKBC1aOeZdhq6be7nyYjPir9muy56a59xXWDH9uHX?=
 =?us-ascii?Q?icV0e0HLukECzyWruyM2YCuRsKhUDFpJ1m/FqMtie6PQg/b7BkdrSVBpumq1?=
 =?us-ascii?Q?6UlFUc+DIwQwTPh1hPuckv23JtJS1Q6vMdFicHlOg+TFoR9gEpFXWnGmEcB4?=
 =?us-ascii?Q?ynRI61rLHbL9395x7dtMZNUNdYpCl/BYtH9w0ehTIcHwm7HIZIBi7tlzXmB7?=
 =?us-ascii?Q?zgxAf9QAkfA9V/vtIck2q+LKhmZTvd6E+MYUgx5vPwK2BeMdXvE8QK/DzC75?=
 =?us-ascii?Q?JPkx7tK8EOXNkPALA4dyPVcrfl4uVOXR8QMAOR8BPX8d+x/H8XXJVyRoLwaT?=
 =?us-ascii?Q?HZzCPFFUKGKqmGW4uDZDWSq42a3sLm2xkfm/zJ5ErmqSih7kaNI1vQb2r8Te?=
 =?us-ascii?Q?cinQ8y+vQg9bjlJ1gjPIDcbHVDKyimtnp4+GDV0gkWYD1L8SSro3obGRwxD0?=
 =?us-ascii?Q?/onjoWyeXGJRnZwQxNSDCNgB0ueRxIxcY8smkZMauHIJt/93J1XRBC3KJMxe?=
 =?us-ascii?Q?fiDw6ukQLGGAwyhKaqmNcT89+0fqe4HL4N2RFUBtRAKkicaV+rXr9enwlNef?=
 =?us-ascii?Q?DPEotW1JsVxLSpq2o9/KN4zykAICarc1L5z4zHFCZntk/+q/MavPxqNLZmY2?=
 =?us-ascii?Q?hes6hQTsPt2T0p1xo0mi5CuzajbOv1Oh6mbY9KHWb8aqr8eDRjmDy9YS512D?=
 =?us-ascii?Q?RS9CSJHEu+Ingg7gKyQJkV08WDucc4Bs0ez1Ob9YnBCTPAc0ubxEvBHYuwnf?=
 =?us-ascii?Q?xe5l/dAOgtJ/SClJNNe+get/EOzHCdKzWqcvU7TuYBOwGOtArQJqEUwcSERE?=
 =?us-ascii?Q?SLNrnTYf3xv6F8RHkU3wTYRf2hwhORdmA6dSTAsjBaHpIA1ktO/MeiFAmRJu?=
 =?us-ascii?Q?NzbehnCoe4X//B8qecEI9ngjaPsl8iJXss9ZISHzmQqDIvB9LDOHNg60sTzD?=
 =?us-ascii?Q?rcRpqMduM4KNM64736FpENu8ToKa/5LhcnhhJ+tqCPrpq19BSyBLrPo8gK3y?=
 =?us-ascii?Q?mY/HLzbPcheu+6p9Pj6Jxe55prRDxq33UeeFMqdL5+OA4zgQbYPZtdz9QMva?=
 =?us-ascii?Q?/flIaT3QAxQ2+yzwPQPR65Cw4736otUcGxbqYQyP1XMqMcvIOC7iJBs0Abq/?=
 =?us-ascii?Q?MHcMfW8PSn5YH8X+kxqjJQ94A9pcLTsSrT9H9Q4y0KPH9NBgmH0tyOaVncYJ?=
 =?us-ascii?Q?UcEvcD7oMLowGQddXdm0L3nzayVSD1KDkEmXhKtxX5n+I9Vu2EX/ZLjBJ0ci?=
 =?us-ascii?Q?YnB3NjPvhL+mieEwrDgAevm5xzsydrzTpNhthVu+MGrRjBkPQUFmMJ5e9JoP?=
 =?us-ascii?Q?RpJ4b1P1PeahXYTgQ2UDATAlzv2K7UjUx1rWE9XwIO+0p2Pk1Pr6wKbzOjKd?=
 =?us-ascii?Q?3Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CAHPQEbZhl2VyfP77jir/gGYJKulcvBt08e/aHhMDb8MsZqquitw3LLxWavA?=
 =?us-ascii?Q?lmS8CRM06mXeWvSNvgRVXJuZ06nx0n5S+7+dNjyjXBKrQkN3SptZcrtc3z9L?=
 =?us-ascii?Q?5FEu0BFrfjYvJJDHnDTxWMNiIVc0ytvKg30XxW+6S+u6zpoEpMPJRwolTTX0?=
 =?us-ascii?Q?m8am1KQSWksb4cVzIBt6O4hos4Ki7OS6czcBywCLLCqErvWiYD829849TBNh?=
 =?us-ascii?Q?plf9gVnG+QYnZ52EdsrdFyuRrX6fGVHNMYLoK1w39Md1q++BcN5MMU9uLs5F?=
 =?us-ascii?Q?ijgnjfQdc5nF2ijWgotmDoz3ueXie5l+aez1lF/FO2ApoFT0H2EC5jxca3EL?=
 =?us-ascii?Q?s04om8rUrx1JSe3gwBK7Zzd3FSaZmda7UwweKxZYH/uww2+Po5Uqmicv70Pc?=
 =?us-ascii?Q?rQ385qK9yWFRu+CAiV2SspUwAgo4v7AWcnDlzx6ivIfVsrZ6yK+pprxmjVrj?=
 =?us-ascii?Q?OagcXRtKMScbutGSKAuVEHe6ZPrNMZ98VG1qTeec7faJdxu2immtak2iCd+j?=
 =?us-ascii?Q?HKVPxxVP0FxUNGx30Spc2VkpkAlg269H9MqsKf8oFvM0JOwtxsLb3epcaAvl?=
 =?us-ascii?Q?gIr536ci/79dtIPaq7iLZlapHogbVmnnDk/lYutYNGoaEl7BM1Y4vyLSPyH/?=
 =?us-ascii?Q?I8Xi1W5qHtBaqNoSeMC6+bfXO6tTnWi+6tA5pCHNdG2TbMbqImhdk6Go1y/6?=
 =?us-ascii?Q?oIF+sp0MPQbhxqtw1u0QOtGjaWhjy0Tn7tDPJ6jhFeshGz7SIQz4aRtIhCcR?=
 =?us-ascii?Q?iS5OCWxm69dbTjvgKF3A0lOMw9NLwUsLWMRBkS77sQUYqzcB3Xx+WoXh6NPv?=
 =?us-ascii?Q?TPuqeszJLUkPcPzo1Ru8q8YfsmRRqDNMtaXpaqhWXpRtLdQcVSHLZLshJr/d?=
 =?us-ascii?Q?CmT/8CCJbNwwMXfcJfdHMIKMntiglj4FzUTOD1yjOEPixnDL0XZOM6lPEmH9?=
 =?us-ascii?Q?BecRvymigZN6vWX93hXav3cD+w1MlpI0aKUDCoP224coidTk4rzsAV31YQ6L?=
 =?us-ascii?Q?Op2P45cPGmPz2BbjShQ3Xn3J084oS4d74Uss/YELlKG7wPDGH5wrDWgOHfFy?=
 =?us-ascii?Q?6/mG3l5kyed+Cc7tbPbknQW7mEl680MeU+wBZGj97hIb0tutyElLMYsVqrCj?=
 =?us-ascii?Q?zC0vpfHq80wl3u1xhIKElqxtzfxP5PEPCmbKsnbURMnNI4vstuFdL1o31NHR?=
 =?us-ascii?Q?xsN6Bf8FNDgen/T0fyVztJ2dz/ylM2/VqRb7MYhtASG0Zi+Ltoec/FKhf2zm?=
 =?us-ascii?Q?n494PCrNugV2Qpt8H16GF5i5woXuLMZ3XaxEzIQezWjOuQVNa9A68gv3w7QL?=
 =?us-ascii?Q?ji5mMJocD4JHS0osMOZkAcVyRz4Y7G1l7IIEGe97Up9Lb+w6bLxnJTm6OciY?=
 =?us-ascii?Q?cQm7H5Yg317rfrJEH4+GrqVW2LyChWWk+hfh1dP23xoPReGFmxsET8Y6/Aph?=
 =?us-ascii?Q?vBtfI7dA/0BZ8chRZScEMhgO2dVPzFYogiGmNrY7qxW4Bx9bsmRJ2VUI/Rzl?=
 =?us-ascii?Q?Nd+1lOYdCHkuzsxyXOcUxwZuwXC+DbF6PI5jjXCLTmfpiVNeT8QkkmztgOZy?=
 =?us-ascii?Q?5MzE6Fc9dMpiBHn5CHGrUBdzxfp1CA/I0mKLRRV+Te8PToWT/hcjd8wqu293?=
 =?us-ascii?Q?oktnzjZl1HikgrnOaB6UaeesYi7D5HOCNvpuzbBM2rN1ZKfvf9xk8t+kU864?=
 =?us-ascii?Q?8rAPSCDc6AjGi9Sd9Rz69a4k9NV3hiyO3SDs3FnwvkuqbKzT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b77268-5e1e-4c9c-ae2b-08de5f051e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 07:07:51.9237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO5lKWs6EG5h0ce8ycgGjVMUw0lhX1Ag2LfrAskr6WzyIoXvmk4HO23s/8400cI8FWuzo6K0k8RHoDyZB8x3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,davemloft.net:email,mirantis.com:email,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 255B9AC6D5
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: 29 December 2025 01:10
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; davem@davemloft.net; aduyck@mirantis.com; ku=
ba@kernel.org; netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@inte=
l.com>; pabeni@redhat.com; Mohammad Heib <mheib@redhat.com>; Loktionov, Ale=
ksandr <aleksandr.loktionov@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH net v3 1/2] i40e: drop udp_tunnel_get_r=
x_info() call from i40e_open()
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
> This is redundant because UDP tunnel RX offload state is preserved across=
 device down/up cycles. The udp_tunnel core handles synchronization automat=
ically when required.
>
> Furthermore, recent changes in the udp_tunnel infrastructure require quer=
ying RX info while holding the udp_tunnel lock. Calling it directly from th=
e ndo_open path violates this requirement, triggering the following lockdep=
 warning:
>
>  Call Trace:
>   <TASK>
>   ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
>   i40e_open+0x135/0x14f [i40e]
>   __dev_open+0x121/0x2e0
>   __dev_change_flags+0x227/0x270
>   dev_change_flags+0x3d/0xb0
>   devinet_ioctl+0x56f/0x860
>   sock_do_ioctl+0x7b/0x130
>   __x64_sys_ioctl+0x91/0xd0
>   do_syscall_64+0x90/0x170
>   ...
>   </TASK>
>
> Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
> i40e_open() resolve the locking violation.
>
> Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
> 1 file changed, 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

