Return-Path: <netdev+bounces-178829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D6A79193
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C23D3AB3CD
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95623BCEE;
	Wed,  2 Apr 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6QeQk/5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C223BD0E
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605856; cv=fail; b=EiGuqOeN2YvJknpQZj5PIQJYD0rREdfqBwMPUdm5zzg/uWZ/1W5mqGeo52/+xuhe01QU+SyGr+QBVXi6K2Z7B5Y04K376zDA3Mrbx1tCVey6SVbb9p0YojcYI3cNpTMgWtnqu9CkL9lBfBkt1KQ8Ajmzz2yykPW+1wjxaq71NRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605856; c=relaxed/simple;
	bh=cWPg8jpnmQjECElic6g/yd3HejHL/KLo6+1KBtfYijs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TpTEgl9a26AcCskG+S/2WuNxwq7PRuBU2hDCy17anRXaEP9vGR6nS0k9OaZrTFoXtMuz9y7RWcGtVXHZ2THug+jsUJmLCWQvh+mBlmS6gTcSS24wUOpxH1alcKsaBzDFcDeG/HIi4jSB8YfvBE06nKf/fvAVa6Owd3pa4LGPRhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6QeQk/5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743605856; x=1775141856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cWPg8jpnmQjECElic6g/yd3HejHL/KLo6+1KBtfYijs=;
  b=g6QeQk/50TOVKp5s4sXFGcoirBx6UHHXd2Cv+LjzcL+pHb/W4nhF/IU2
   qOmO24jnURWypP7fW3kugFAjl35r8WBHIk6r84BnnOAhIUEF1OSbVu5Tb
   IBdGIotdh32mJpaLXfW5FeLWURu3VtvaNpY7CMCkWST90sWztfTrXOkJG
   JWZhcAf4iFXXeiXmHNcZKMZ2AjZLNFbwWkvVpAwIjfVVf0kSf6WozM9K8
   jscxAfLI6/RhW+1aAhif9QeP/zNzzgpo9rxOS2WblPNmSv1mI+hT2pqTn
   TZyMeG2iYOG2ZNYiS3AprixFD8XBvStR5HGMMGH4Jld3MPkVpr2WoMxZR
   A==;
X-CSE-ConnectionGUID: 4oEYIkiyRs6k9pcF/xH9Jg==
X-CSE-MsgGUID: VnNlvd3vSnOn5e2X6CLARg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56348581"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="56348581"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 07:57:35 -0700
X-CSE-ConnectionGUID: Zae5sB2+S0m7I6XecqwVxw==
X-CSE-MsgGUID: d6ILAmNfTlSDzEe0HKrCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126685006"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 07:57:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 2 Apr 2025 07:57:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 2 Apr 2025 07:57:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 07:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv0tlsE1gO+6r9P9+nTvZyiy3LsQsPryQ8szC3k/fnpx4TFT5DbQfHK0WsTZ9Zq0uL937udw0ZXIt/nO+qGn8j34r6mu61VnmyKf69LzIqmb9/n+vS0Wx5vo6mWdBPbYoGnYOb7Wh+kmsDftUS7KMKvTQibUS0umSdy1qW7jQ64XFCNf2PmLEiuIVKCDQ2MkNFv8pC4S4gDS+1pkS285JIXKxXEw3GZHufB/r9B0bnqxLZqMDuaKWubQmRkfUxZJoAToISrBjWOH6tRCdjIxow+5IvvHSvUFjp4yjv4lCivC4AYaRqqM9uShVmM1t29yjm39/qbq/iW+rJ918tQNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm2vSI3TAollDa916gYhhBOHltm9H1NFzNMxqLnp19M=;
 b=jo4OMCu5KgyRc9594Yq4k7DoPC1W/ZEpnXkCsORJam1n0Vjt1QneoJMFhe0+O2LD6fG795g2b84JvQMzqP+U1OUOJQ+CUh+OT5N051/U0jwhD8ZpWuKo6gGYPU26+rVJwQf7DUmnkGsTL/0fHtXMe8tPwhlOLRqDhjPBZ4oDm6rSBgOiT5C7BdPwwhZPjUq7eqQD50nOM0avkDG7rLN/VmS8LtX+zrzamwN+Gr0q4h1eLOsu8dEpEjUoa+ZxlaDd2UwKrHRPKZzMALOi2d+0gnBEOF0acuqMIPhkfrk/DCPqvj1xFYCMFclCDhk+EwVTZqIdiGXZKjjNBRGft0uQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 14:57:30 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%3]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 14:57:30 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Dumazet, Eric" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: RE: [PATCH net-next 08/10] idpf: add Tx timestamp flows
Thread-Topic: [PATCH net-next 08/10] idpf: add Tx timestamp flows
Thread-Index: AQHbmCC4vwO8eNIcxUWhWZrilGNsdLOD24QAgAyyzjA=
Date: Wed, 2 Apr 2025 14:57:30 +0000
Message-ID: <MW4PR11MB588902CFD752740F584854798EAF2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
	<20250318161327.2532891-9-anthony.l.nguyen@intel.com>
 <20250325060030.279c99bf@kernel.org>
In-Reply-To: <20250325060030.279c99bf@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|IA3PR11MB8987:EE_
x-ms-office365-filtering-correlation-id: 85380b0d-8d3e-401e-f5dc-08dd71f6b0ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sMgp73H86aeBZQkyPsCWg1+tki68AjyjEh+LsFFm5WTL465pxfi6dJzMyTco?=
 =?us-ascii?Q?kkXLHrVkdshR1Y/oqCzQ1FA8cl1mIhwQrOkAtJf4Rj0FRXcZ7GyLt+8JST5P?=
 =?us-ascii?Q?2b3q6SXcdEyxX0iZhlD8+XqKnNGrHxMnEj5EqAM0S08KbxKkWJeAlpAp3u/C?=
 =?us-ascii?Q?rRWO0cCCevwEh+98RqDuxHDhNak6EObY4ZFjP3AH4eE2L0BslPbW/6BbHz66?=
 =?us-ascii?Q?09avh8dh5m0yE2Vl1WFqB0U5n5r64gsFahEc4RhpbDfaMePJUt6hM9oJy9UL?=
 =?us-ascii?Q?jxVbSws2fO1L3CEKt/JkHyh8VspbcUHIacZ6uTfR9U+NuC5I9DHmoWkpbrs7?=
 =?us-ascii?Q?IBnKQ3xbaJOgZoDCVHDbxOreQ6+eUhFrM0bkT6s5WzuJNOwql8EDOb6Dqb6U?=
 =?us-ascii?Q?/pBCnucsFxKWfQR1pqoJNFIT38Aj4ooxTubw9oC+to2BoHSXStpjAj26AkaW?=
 =?us-ascii?Q?oDYnpkq5sd7gX+oJv/uz5P4H+6Ant06vp/yEtWUDwHeF+GtEWmfjUqm1Dzln?=
 =?us-ascii?Q?zLpFu8S2FURJfcIUq+yeDXFz28+TqxH+PbiYrHl20kRKyFe7+376SfUF4evI?=
 =?us-ascii?Q?oiFQh8JiwfE1vhKgcesyn1BrzWqRpUBX7c5A31EKqMgCf0eOwehsYH5vSoxn?=
 =?us-ascii?Q?T+DBmkivTT+lxarZmFj180MT1s1Jm/AozBFgUKqZUtw4Sr8HiB3qZPVs2Wvy?=
 =?us-ascii?Q?cg0ekvHhsT61hxqnRi2+AbbxBTRiSLKgPOcWSeZKlscgP19h0XVIYNC/5Fnb?=
 =?us-ascii?Q?aKpNAnsPuQam+dZkST602n9eXDqK9RZzzPkJjr+TOsLmP/kQebYvQrGRlDSE?=
 =?us-ascii?Q?1AXDwp1+OPwOUH90A04QdDHIqCCS3SsVd3DetXiSOBQRUfegPNVxhQwe0Ygx?=
 =?us-ascii?Q?u9pQKjnN+CtwFeLudEYLY4hgiV1eYePTHkdrOU9i/lFK9yPUtVR/cddHrD3y?=
 =?us-ascii?Q?evxlbhjXz13dWVZlAJ2PZcCSzG4SDQLrsQ3/fvSSQZHa+4XEdfg5B6pUUEcr?=
 =?us-ascii?Q?9rAmYmkj2rI0zdv3ZtGJ40re2AasNuK3YW7qVw7Wq1rDUHhMzGjpIb42IBmk?=
 =?us-ascii?Q?1ARZV2M32sTyRC+hPNucXoxOWI48GXHnHGUDhQDc2i0fuCpfpFKAIvPTlmYg?=
 =?us-ascii?Q?6b0ftTlkXrk9YLsBciwXbDsVBgI07B+GHbfOd2u2zUCGh1FPDN82E0Xssx7W?=
 =?us-ascii?Q?lS2dbSL+uFkjPjB46gWMT+fogozgc25Z87Bcd0bzKZFqHbdIkgRlp8cxvT7K?=
 =?us-ascii?Q?01uFN3WVtq7NCU+hb+rKUBk0fy+NsNZfkA8CgHIVvRj9UIGMpaRFbOErskyX?=
 =?us-ascii?Q?L3bKjtx/eVQbJptrV1wXy9tclBA4566rfY1DCOQ0QtyOaYZ9vZXD4aq4O8z7?=
 =?us-ascii?Q?0IrEuv2TkltVK3/JSVTWkfgJCHC14qoHq4A8Q2yY4ejwIU3ePHvWtoJSnXwR?=
 =?us-ascii?Q?r7lcPBxOwdVTHLmLW0wseV2/58C2J0IU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hjeMkLF/ftAChKpoRK8DuPubZNkatMGbyF4sxwxf6MEIzp3AMxgy1l+42h+J?=
 =?us-ascii?Q?I5liGvKFBYeLTgVnm+u2hRlTL6RpBk8qlX9L41j90nrO3m0YxkHR+LxpwNrC?=
 =?us-ascii?Q?hs/PZWUmnVA15/kygCYdcRCoQWH1z42p7sulF87+mra4ToF9z9CS0AiveNIP?=
 =?us-ascii?Q?HHZUbV+IvBcK2l+i+yR+NxC9r8zjn4c6SFcaeGULY3DXnozt33SUDAWIvWmf?=
 =?us-ascii?Q?cWeDtpAj8L8tBqQs45ztNahQn9fdSzM8uTB50vcbJpYmSe5vA4/xM8z3t81Y?=
 =?us-ascii?Q?xaIvmzEd7SWTB4H94yIuoJ/+WRkzEJ2DaQACXNYr8EPRfy7RoDMz1YMNd8V6?=
 =?us-ascii?Q?Ee6LZ7OwnNMlvenivLdS/vvafdOICnU3plCwu0g4UbloKGeksyj4VPRZr1o7?=
 =?us-ascii?Q?qL6CG50HRt4Te5RmouuOKyeoYDfvKfY3/ytdgQs5eVBWgT5znhNoTGDvPIzF?=
 =?us-ascii?Q?su8BgjSHqpgx5PX32NdusTdPuhphMokWcuRlPSFxYtqdr4g+qO60qgSpBn0k?=
 =?us-ascii?Q?yPz1W1VKiTGUvuPWyXZ3k4NujALkzy+BvKKv1IFc7iauJsMaMadLDMnxpIhG?=
 =?us-ascii?Q?g9usu5o6DJt9fsY78evIOG8PZp6ifgdtNhnm3CdNLX/Zn3xZi87WsPvlScYo?=
 =?us-ascii?Q?Ys36d/sauKdNZM8lYOmSFqMd1jOcAvjo9DHgFR7AO9QfTZWlPwFli+miPPof?=
 =?us-ascii?Q?nQ3VgoYjWv9SkXQQxKRFkItmX6Sck1QIWnxLDRXdhuvUqrjYl4G53sOeh2ol?=
 =?us-ascii?Q?bER19Ivt4MUiPk289bHSEKXK6M6XbbJzzEHBWoEdUPFnmskPnd8kkjJwYZyk?=
 =?us-ascii?Q?+2jbjS3olrLPR3CWyzHI2S9sPKuUcxvz2T6ZkIzyzv/nROwvkLD0lwyLvZo7?=
 =?us-ascii?Q?ukBub/UQEtlSvVOfisKOooXV7KaqnqNRu3jujbFcLjnCDCtITAgec04s6TT9?=
 =?us-ascii?Q?9/rIQOerg1kER5H4vtCX2f1rbVpULHMitQmoDByldbCxJ2WxApxzLrs4ASB9?=
 =?us-ascii?Q?+MT0foEdJ7CXpt0aasXt30kyfEInfnUxrWKdOQHDKBXSPjm+jO8Aab9d9+vA?=
 =?us-ascii?Q?GibS8DZeVhMVLQFz88b1qQvNgptfv2TJj9mKlS07+GbbnNn4esNAB3rZlVIG?=
 =?us-ascii?Q?3w+/QIUnNZNF+XfRX7+JneA5VdcJPK06UWLBuZ2vKbTGSlJZ3acwWfMCwkcb?=
 =?us-ascii?Q?Iz0LM9CGc4RmjCwlRrznZp6PyqBMl+k1ZDz00Z2ZbFDHXAjS9f3Jv5QXRld3?=
 =?us-ascii?Q?bd09NAPoWakNDg/ZU366BZh1ITptLjRCFbU38RsniiHQDknz1wYIb2aVThBg?=
 =?us-ascii?Q?OZI75Ty2c1bO4fBbPrlEF7jj+Wio/wJa5HIHstB9QDZ53R/mRbfPZG/0HqMy?=
 =?us-ascii?Q?uJX03axUuw3CdRbPqXZXx5paLCxUwdHu+cBnn7r+gBtgxgiJfSafvS8Ua6qe?=
 =?us-ascii?Q?2LC3IFbW7nuGJqe4w18nweVIU7vnSRElCLmX9z+EJy2G/LH/SK/aDfdANrPO?=
 =?us-ascii?Q?2a6ZliTZg27hbcV2XIuxkD/l0VIBA9DS06MfkBFAMntF8YMXGmvpZ2V01RSH?=
 =?us-ascii?Q?CTOVUUvsaE0bTYyZiMFGZxd9uzjrznH0EJ7Pe44a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85380b0d-8d3e-401e-f5dc-08dd71f6b0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 14:57:30.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIpZFW53676o1oGAnM0sA2xuqrnljQVgPQvnpn830wbM9LVECZTH6FToiMKVfK7ZZmeZ+iMqRZncR0Ma+F8EhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8987
X-OriginatorOrg: intel.com

On 03/25/2025 2:01 PM, Jakub Kicinski wrote:

>On Tue, 18 Mar 2025 09:13:23 -0700 Tony Nguyen wrote:
>> +/**
>> + * struct idpf_tx_tstamp_stats - Tx timestamp statistics
>> + * @tx_hwtstamp_lock: Lock to protect Tx tstamp stats
>> + * @tx_hwtstamp_discarded: Number of Tx skbs discarded due to cached PH=
C time
>> + *			   being too old to correctly extend timestamp
>> + * @tx_hwtstamp_flushed: Number of Tx skbs flushed due to interface clo=
sed
>> + */
>> +struct idpf_tx_tstamp_stats {
>> +	struct mutex tx_hwtstamp_lock;
>> +	u32 tx_hwtstamp_discarded;
>> +	u32 tx_hwtstamp_flushed;
>> +};
>
>>   * idpf_get_rxnfc - command to get RX flow classification rules
>> @@ -479,6 +480,9 @@ static const struct idpf_stats idpf_gstrings_port_st=
ats[] =3D {
>>  	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
>>  	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicas=
t),
>>  	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcas=
t),
>> +	IDPF_PORT_STAT("tx-hwtstamp_skipped", port_stats.tx_hwtstamp_skipped),
>> +	IDPF_PORT_STAT("tx-hwtstamp_flushed", tstamp_stats.tx_hwtstamp_flushed=
),
>> +	IDPF_PORT_STAT("tx-hwtstamp_discarded", tstamp_stats.tx_hwtstamp_disca=
rded),
>
>I don't see you implementing .get_ts_stats ? If there is a reason
>please explain in the commit msg. We require that standard stats
>are reported if you want to report custom, more granular ones.

TBH I wasn't aware of that :<

Do you think that the lack of this stats is a blocker for this series?

>
>> +static int idpf_get_ts_info(struct net_device *netdev,
>> +			    struct kernel_ethtool_ts_info *info)
>> +{
>> +	struct idpf_netdev_priv *np =3D netdev_priv(netdev);
>> +	struct idpf_vport *vport;
>> +	int err =3D 0;
>> +
>> +	if (!mutex_trylock(&np->adapter->vport_ctrl_lock))
>
>Why trylock? This also needs a solid and well documented justification
>to pass.

Right - in most places idpf_vport_ctrl_lock is used, but I guess that for
PTP use-case is safer to return an error immediately when the vport cannot
be accessed - for example because of reset.

Thanks,
Milena

>--=20
>pw-bot: cr
>

