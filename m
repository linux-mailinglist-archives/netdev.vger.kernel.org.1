Return-Path: <netdev+bounces-106207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5E91539B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE5286D28
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC019DF6F;
	Mon, 24 Jun 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDiiapf3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4219DF61
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246268; cv=fail; b=c+5Y5BcMmZWGkG5Gip5F+6oymyHhbb7o0iYTZLO9CzjaHfPqQF7WmSR3e5OJ9vil4H8n1Y33SOhOr45oYUmosr76gxLlN8U8ObGAVs2BVUsZbuFu9XjXtbqYG8Qp6gEVpJrSroIQw4t2rrL+ujS3Yvl3xAzGVZjObElLUvY1y8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246268; c=relaxed/simple;
	bh=bZTgIvMBw4Utf0Hzpk1eeRBAPs+NrskDIPpogR810tA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/uza1uZx3QAU6xSWkiLcEhPYXnQZcbQA4wTi9o9SjCQFSA44HVzHfb3j2QtswBi23C1ov+vYj9HWdWiKAn3ABVmGOlWHk9CBnIsY6yhkvaD6UWmA/C6TmKg2rI0u+Ah0bc3ufEsCF/gH6V4khL9VcRXLkuAjTK+kzXdkAAnaek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDiiapf3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719246266; x=1750782266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bZTgIvMBw4Utf0Hzpk1eeRBAPs+NrskDIPpogR810tA=;
  b=HDiiapf32HKS1hOHWuBuQbRP3g1QpyW1rElQVRoMo/N1+KEG96O5HZQL
   KFUeDa5IkyRf2dLOIbLw4ZAsjX03lTyiB6vWK6jGhAEhEsU9YPi/ZvPLu
   6ZzPYM4JarOvooIvkkE+Ko4h4UydwMeqmbciaf0ducQgpRHkc0IQ/TKxc
   fGT827jo+/BL0T+ZM3AorZfvoJL6T93DKe3LCAD/dxVjTnVVVXGIBnjaL
   6nBrek7Ts+3BHiYBy3g2HEwjuR4WAdFsYlw+M2YKyWwSlYvjTh0zIbktN
   73DS4wRhfN/OHNpzB843xUwtA1PjLQYgKWKTZc42HX2Ke/18CyRvGQBqH
   w==;
X-CSE-ConnectionGUID: WD/6tFcDSiKVK0oqSQ5bXg==
X-CSE-MsgGUID: OJqOmxR3TbC7xWIkByAKgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16051744"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16051744"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:24:20 -0700
X-CSE-ConnectionGUID: EOeJXjrISOqc4h+FjMM6Rw==
X-CSE-MsgGUID: q15hbA9dSHOz30MuxQ+xgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43461498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 09:24:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 09:24:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 09:24:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 09:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1fTlnF21/OS+W/HFTxrgD71ZLnLTvHo5Xz9Bt7/FBOwJWyZRD7CVP+lLIVO0opZkYBjIlcmvprv7r/dfIO1qx3863uL5e/vD62X64FwW4AwxrQxKWGAwSWRE/WxlMoyICNpAnbshv+j6UDirNp+toAyyfOvCu0x+bAM4AdN+ffxgVCY3h8giwejZw18/QNOxFSqH7W1zYigBqTZ6hd2EZM4QvuO7p7Hpt5knjXqBEFmFOvK3dd0NNQU5xA6CXyD5+rYaCC49Oj8n6vkxp0UGayAWZQs7/LnUztudEYiWto+1OAPdAOntet8MzXq+9q0ZDJS/MgOUbfFDvpI7Atm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhHJIi4UsZLm4mvmkeirzDP3fO6vvi8LJ/eH8LnRSgg=;
 b=XxOh7JhxhvTEHKPmDkCGbQ2rZWM9YEunjjl2tCpVw0FFM08rdaLiYtkW7bWphGdX5hcv1PWbGHqmDJrt7ua1+QiWzAlrxP2vNCYeYSpaXdwpVMQ62PV2toOmh5czyOxAS453xs8njXVrS3sLlKFLwU/G/EqtQlxrjsPuwrWHR+O4WaqW6ERIEDRMzxpLDPjy2SYeU4VMbCEWO4aMZCg7nYf56wz1Ztj1AOs5imuMZe7nOopO7wVXQ8bK1RKy+veaxBgT7Gyu0N6tRXSvZC/i2hL4fJ55Gq1+21JEkMFw79W3qG06w9La1ssuSeju9Fn8X+G/9DK2pA6u46/gkQuj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 16:24:17 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:24:17 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Samal, Anil" <anil.samal@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Czapnik, Lukasz"
	<lukasz.czapnik@intel.com>, "Samal, Anil" <anil.samal@intel.com>, "Pepiak,
 Leszek" <leszek.pepiak@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: Extend Sideband
 Queue command to support flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: Extend Sideband
 Queue command to support flags
Thread-Index: AQHavlrFCTJFfv7N9kiUQQQbB/r4rbHXKOtQ
Date: Mon, 24 Jun 2024 16:24:17 +0000
Message-ID: <CYYPR11MB8429109D28A347BC5691EE44BDD42@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240614125935.900102-1-anil.samal@intel.com>
 <20240614125935.900102-2-anil.samal@intel.com>
In-Reply-To: <20240614125935.900102-2-anil.samal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: fd4ce0a8-38e3-47dd-4821-08dc946a1835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?53XOWtcR11XjwoZjrAvUXhSYrzQhrbXapI5i+yQqyw+RJ0vGesc930183lRZ?=
 =?us-ascii?Q?O3E8fEjbBJypaC0LQs4M4EpcVum21AmrTyb57S91ldLmc/nAx6vDhLippY08?=
 =?us-ascii?Q?2MYhx9/UrsRx/oOqf1a/4mr3gjQgvaeRm67MJ2qmjyGFGzHL3WU0OG3I973/?=
 =?us-ascii?Q?e7uE0cPSlBBAuvDl7cVjd+XEMLOZqGJW4RItWiIiT4mSOUyBpM1tq6Cpa6e3?=
 =?us-ascii?Q?XZcsjjNTCls/I5WG5lFtMqNsdE1x0OB5JQLh4Ag/j7Sw83VKqjhsMZ763lFg?=
 =?us-ascii?Q?x1x3eRje0ozlhoTL4/IkSVYFAcWvpyexSjFTswNfuFkd7o1QU1bydWkdneMa?=
 =?us-ascii?Q?M0hzqspYplZqew516pSLgO8+iqb3Jdtah+G4IAPI7RghFEEyADUWSDLLOWCO?=
 =?us-ascii?Q?gP6wKSVaOrMzbpTV5zpK5QPJ0wxGHaehNSttDuRVTPJ11W9/lNH79ke5RlUx?=
 =?us-ascii?Q?46JO7Se5OLiFdL6g04D28QjJgLLUvz6Ni7RUkGiMgGM+W63dAakk04JELy4O?=
 =?us-ascii?Q?2bQdKKMT2FKk6FypZh4Iceaatr3Ui4R0Xz52UpAPqIBzblo9U2FfFNZ9xksP?=
 =?us-ascii?Q?257ohVfOBD1bruwc73k7EwZg3s50M33a3VhDSruPHkfIQYP2YJoj+YXWHCRX?=
 =?us-ascii?Q?yt0JtRLNdAtO10yK2lD05EERnuuThSloH3TU1SH4g/GyzYYnFNHAYS9vd6R3?=
 =?us-ascii?Q?5GRCHGDxAlzRiZZ8UiOdKfKZksJTS3+mWrC2GytP9zYClgnhSowSIn/OP8Wp?=
 =?us-ascii?Q?qBkNg2YEH4MbLpjlZTWadeCfK5yGl4g5JkgS9yNgLdqYoGavIvNyAB6jVU16?=
 =?us-ascii?Q?ccGACMz8TGgCAviGck5841skYP8NtVbMgwr5GEpRNvHMfsjLMQXrugykyGeX?=
 =?us-ascii?Q?iTswpSAXPgnqOXkyqYj9ttIJ7JV9XjyR+MHotWsHEM6MX2nnAoSkRKkaebPa?=
 =?us-ascii?Q?/BLItO/8j1L7zvwyhje7bOnU5gHFuxmATpDIqKydgU3bySJw2NavQeSB1MDP?=
 =?us-ascii?Q?eox4aSmU2XqDKV2AnFZRsv6Mk07gFH63Fzl/mT7Yaf2BsdUKSo6+CUUtDy8i?=
 =?us-ascii?Q?ftA504//f8V5qeyACATFvH/tGyfszANekCrrcFTk22r2ZXPfj1i3/eFlIJC/?=
 =?us-ascii?Q?ap7I7jJVRSP3j5fZovcQabA+VTjy4JYPb+tjqDF5VGRLw7EC56xPXxB/Oaks?=
 =?us-ascii?Q?np56YoJPYO5umVQrKWrVGAtLz4jVuh9diD4/TkSwN7TU9/GfW+7As0ISfbbk?=
 =?us-ascii?Q?7G/L05vktSKCzmQ9nHVEFtN8qqHAor5q9BfToRbawsRgmUk+bmMO347Lhesq?=
 =?us-ascii?Q?OqBH8daxSX2c+qA2zS+nVAIZfy7lpyYdhoPpQCQk9rwT7tnvyszIY7LjXZbN?=
 =?us-ascii?Q?+wRzsgc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lzlUhFZ/i0q2779Z9pQPIk8jgj87iPwfia2yxzROVgq/jfGGaiJlQaJq29Ez?=
 =?us-ascii?Q?QC68x4rpXJnjnTCC8i4Mi2SfD8A28k0DjTVKNUxuQAKYHd/ymD7fw5bX2aYP?=
 =?us-ascii?Q?9aDQZDLnsWoY5pYZZBsNbPckdXdmE3AjbHkzWog8mpUfRigv0dioKCcCQCTE?=
 =?us-ascii?Q?dGbselHlGc4/3+aldGznDsZfT5Ekd0Q/nKgEzUPE+Ej87Ggo4JlW5sMtXumV?=
 =?us-ascii?Q?TX9VWJ6xXHiOeg9CpSORZ9JibUf7ka+Eh89VGIfi4q8BxtHxy5zjmUxn0NO5?=
 =?us-ascii?Q?8DDLAQBog3qBVD5yymiF/fw1kEkEJZ9CmMzlU0EifwRyblOv9sqwz+zkJNc+?=
 =?us-ascii?Q?KmjgRlUb/Nt++okHfArQ7cTApY2D7DtIVMbLAEikWEVwjHS+tLPnWQqjfVgC?=
 =?us-ascii?Q?MTNfCaAg0pkp4+7mrvaXg3z6CpNeCf/q1ZFtXMXDPn1Hu6diP472Rq8ngJpN?=
 =?us-ascii?Q?iUaG/0PQ927TDfuPjfuloJ9mt09LhhuxA+281rNrhn196BQjjpgsyfUdN7kw?=
 =?us-ascii?Q?j1uFC9DGB5JC8jJjw4JpZwQRqdlzAjf9U4m+96HCm2ymByHmp42W8WOtOtiw?=
 =?us-ascii?Q?TPlvfXueiYdN9vAcIPDWb/GzBrnYP5jDMAqdWhSyYgHEiZq0RczqECvKCAnC?=
 =?us-ascii?Q?YoyvV2teFRSRRAhqsDY01NVaTrj5G8YsIlWnWpj8S+hjYeWrH/vEPkY6H4SQ?=
 =?us-ascii?Q?5mhKd3Rmzo54faPzR6r71L0fjsHoOlFvhYTaEYw8TEoVIIcikyBRb/qfXtQJ?=
 =?us-ascii?Q?eWZo7V1EZUBya9CwAgGI0pPubslRypLrf/156rQp3DUvIDk3ZGzW9xAJZrwb?=
 =?us-ascii?Q?KTiytGB+wwzKUW8eU8/wePUhOLKY1odSwcsw+F725A7Ccvylq5dIz/LsE3P/?=
 =?us-ascii?Q?W0KoavmrJ85Ru+mwQGw0r4y1k87J6NlRzj1rI4umme3kFm+3YT9NagExy0z0?=
 =?us-ascii?Q?W3hEbCTmO07iXyVO6a267oaYkuSkzR5vlT/ClXkBDSWNG5vJrc7HOdfjQHcB?=
 =?us-ascii?Q?fFhV/IhPubu/wx2hux43PNpWViGiXHWEuHzAETNt2o/key4NZ/DrXlIiUDPy?=
 =?us-ascii?Q?1S0lhHqh4r4i0qbjv6MK9VP0xBCndrJUHgU07R79Z6tXbygzcELIRYqdXXHo?=
 =?us-ascii?Q?xoZk3VO2N83GSKqw0HPpUWbO1kyLgFqh8hK5awKxGYD9mP0Yln7zLhIi3B7S?=
 =?us-ascii?Q?VLJ1qzHfLCZowRZgLuJ1vDEytNnnhztXT8DSWKk/bMzmHC5EKl6YU8qZ2rde?=
 =?us-ascii?Q?TM1+DBl1LpMJMlZQohRxe9BxEhwQPng1RjvENOnCMWxWeqwll79RAXgtlVeF?=
 =?us-ascii?Q?2FFgyH8VFkInYviN9R2qc7D3Us+zLQBtWJoj2+yz7+wDQbGvcld2ldj8T+8J?=
 =?us-ascii?Q?d+jDB17Krg9HmG/SPoCKtQeLR+Fud3NYvKgNJquFzdm6W48yC5VyIG7jfNOM?=
 =?us-ascii?Q?J8Nnsqzl/MkICETU0em3OTnAdoI+fBqGkuaOomxPAXr9EybVGxXZnl7LphQw?=
 =?us-ascii?Q?kMnz0c0kQthIcZqAbLQVmm3zslWZ22x0BruxV4SlT3ARzWrlMuTcpjqUrl6Z?=
 =?us-ascii?Q?7h4Q79hicC4q24XqtxLyfoYchiSL9VHlt+HvPubX8MllUipk1R/iUaQpF6Ay?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4ce0a8-38e3-47dd-4821-08dc946a1835
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 16:24:17.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRQRV/5+gDfEZh2cl9maPse7YhjPX0MmsIVU1dzbbpxEndNZ//gOldnxPmzvY+NpxN1Y6WU/+dbb6g5b9KdVb7NVfhbhYDdW6pO7+EbxfKj4CCwpCqxCZb+k+JhfVQal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
nil Samal
> Sent: Friday, June 14, 2024 6:28 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel.com>; S=
amal, Anil <anil.samal@intel.com>; Pepiak, Leszek <leszek.pepiak@intel.com>=
; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kerne=
l.org>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: Extend Sideband Q=
ueue command to support flags
>
> Current driver implementation for Sideband Queue supports a fixed flag (I=
CE_AQ_FLAG_RD). To retrieve FEC statistics from firmware, Sideband Queue co=
mmand is used with a different flag.
>
> Extend API for Sideband Queue command to use 'flags' as input argument.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anil Samal <anil.samal@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  5 +++--  drivers/net/ethe=
rnet/intel/ice/ice_common.h |  2 +-  drivers/net/ethernet/intel/ice/ice_ptp=
_hw.c | 20 ++++++++++----------
>  3 files changed, 14 insertions(+), 13 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


