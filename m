Return-Path: <netdev+bounces-211175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290ACB17014
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D3E1AA5BD7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27C2BDC05;
	Thu, 31 Jul 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJ30s1DK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E820C461
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959887; cv=fail; b=FTlvyI+5FRK/jaKyDG2RAjXKU6oDemmaFXdAUGPeGP6FIE6BkCWZpXL48MHbSA+4Di4egL5n4CyaOmTVrQnAI+P48tCr4KbbetzD9mTc37ZWFeuIx5wj9FngwpitC1SDJlNRGZQjX4cbUXjDUNAc9rXVgj6SC+VGvMhsft3XT9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959887; c=relaxed/simple;
	bh=XGJHVCEtOBOdBiYHzzq3hdpAAJgFbXCqGuYiAZbt9yM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PHuWFOafUxxMnlrfzYKgcaNucGPdrv+80rmZYx8amz2TpTw11y0V/npAYmj+CLAGDuYAYChX/d2JaIkgmlfiyQ57fanK3KHol8RgCIFBozmtfNqwel4gC3ylYcAZHpZ/HFoNLcsRD8AXQUOD/rC/TTzBIlKoNs1eL3M9u7YPUj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJ30s1DK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753959886; x=1785495886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XGJHVCEtOBOdBiYHzzq3hdpAAJgFbXCqGuYiAZbt9yM=;
  b=cJ30s1DKYeqXQacJqPlXOUZxjRHvquCua0xw4OTh0h0zwg+LF4//oLDc
   Hf9fLPG4pDhgR2GPxg78nuhgjeDFyIV1xXLrKOJENFux8gBir3edw/PJ2
   s92nSqMXCvOKdwQ+WS13vJG7TD3a90WnNWNnBXlcl7pw2Z5QkXwageG7v
   N+KXZ3K3eUgsEq9CZlfhePDnXNzRZ48tkA0F8pWM5bjNidM97AS+ll1tb
   1bFtphy+n0gigD/ttKH4QRf4DCYVu5fhIT2Apqdp7P0kyzSOlJioZCM73
   gBp0cSofOZRMs+2OE9iie+xrBcQJsOv8tZeOYc2CHN0OqqmHWshlCdRDO
   Q==;
X-CSE-ConnectionGUID: 57XN2PJ5QNKVNtr+R2IREA==
X-CSE-MsgGUID: kxwUlORIRSm2WJmpovVB4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60104401"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="60104401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 04:04:46 -0700
X-CSE-ConnectionGUID: 8lLAJK4HS6i9IhnOq75+kg==
X-CSE-MsgGUID: kpEAPXFXT/SF/BAkhADOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163127358"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 04:04:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 04:04:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 04:04:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.72)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 04:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0GhFjrdbpmxhmwzCMosJOPqsZs2ROOYnyhcumrnKRWlcMjPunYb3OUQTxSdapL6Hghw+Himt7YWbOj1rAI7n9HzPZNG6G1IkmVfljTtRIJ7077k5kFAz7ZtjoAUOuusWdhR/kCJurUs3cSdF12Y2lZL6A1RcqcDlel7naCo/n+4SMzz83tx+9GLsuu9gg5GVFrAkzmIfKK7HqtJymf/ZBHUNpnDjGtuAwvIms5oKIhprnOotXVnB1Yn726NXYyeX2ZD76u/cleQ1nGm6LqSBqvxIuxSWAskHy75wymX8/xmczW8BtRhEMhkVHZR8PUfZFIznJBkXRzx+mqOQYf+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFwuNY1VkbB+ipIzHGEBLqDIXVE5+81Vljy/y/ilF+A=;
 b=WNM1mwt4ejxsUbcGvBTriAfmHtNaiinIbPMSNVkNqwYVdrHUouTjF4ymtKcScKuUINfHIw/gaIEII+E9nkg0G3rj6bku59iCnHzNELbNgnar0mWam7YOztMfNvThxRadLh8PSs8/W1QefxnoDzfMnUtkjOAKTbzh9ZJXoXotqmGVx3kjhSzyooMFQdgCzRJqE+czVKF3Q8ZWDeattlOi9MgzaIaPMKEXq3PjsBKc+TFf0aTPRL8ktWXkG/6UiknsCxI+GgMFIOgPNfSLwLMXM2+pJdy0jVhtHI4jKMDO1W86l8Ps0aBd3zeQ0ObhaYYP1sgpDBvoF0F40tQHv61Viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DM3PR11MB8757.namprd11.prod.outlook.com (2603:10b6:8:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 11:04:43 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca%4]) with mapi id 15.20.8964.025; Thu, 31 Jul 2025
 11:04:42 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-net v1] ixgbe: fix ixgbe_orom_civd_info struct layout
Thread-Topic: [PATCH iwl-net v1] ixgbe: fix ixgbe_orom_civd_info struct layout
Thread-Index: AQHcAWPaLIJPv3P1VkioOVb6MO8lV7RK0W0AgAFAWXA=
Date: Thu, 31 Jul 2025 11:04:42 +0000
Message-ID: <PH0PR11MB5902E977BFC90DCC8DB99FD9F027A@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20250730145209.1670909-1-jedrzej.jagielski@intel.com>
 <20250730155334.GK1877762@horms.kernel.org>
In-Reply-To: <20250730155334.GK1877762@horms.kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DM3PR11MB8757:EE_
x-ms-office365-filtering-correlation-id: 2abadc2e-b3ec-441f-0219-08ddd0220d6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QOfm3M3dbSdNmxps610+QDT2tJUQFqyHTKOvfUNOW2tVo/9HOHIpNgA6Ot4G?=
 =?us-ascii?Q?XbrXVCoMI7ratsg9kxUDFbcwuKeAbuJOo8a3RmW7f9uTr/cl2FkEOhPK5zQF?=
 =?us-ascii?Q?3v1JU0AAMPw9azppNWAbM3YXkPbLskOV1CiXAFPLliXl55J9FstV4w1rBQ5w?=
 =?us-ascii?Q?p6LRmpo4C43KsuyuaAyqJyS+/Z20fUaflhbPK6V1KuEO+nubvuFDV6Pg+D4g?=
 =?us-ascii?Q?fgHRAm1qjmy1vguJIZ1Q6SxneROHsUgRUdBRKOMI6fSKkxe1dxOu8frlWOyZ?=
 =?us-ascii?Q?uhZr991l3BKs1Qs+B7srrk+YMmZdC9F2+AV5IyOkhK1VG4XylZ7NOo4iNaod?=
 =?us-ascii?Q?yy0ir8vaB1KgTY4CIfp+R1y8569y9N9FlYlwfKUUy1FL25q0C16brfIKNg+8?=
 =?us-ascii?Q?JMlgeL+UCZmBQ4RJqSBJPWXq4WiVlUQ0hUHjV16saaLsy8a93fMfjK5FEpQ5?=
 =?us-ascii?Q?Oj7grUKTBVlxuTJl/gl6gyUdO8C/ACukNlHdidYZfLKOpSBYdhISk9MWoirx?=
 =?us-ascii?Q?rvhwjhVFmwJllcxWjqBNbfapGbLH5MXCHhjeYzfONQSshcVPX1IqaGegTsXO?=
 =?us-ascii?Q?xc2TAuj9IdUEAVtgjqnta0eZnEYCTIn9yfDSNRW9BRQDC1Eh6DLsCQyCMEwW?=
 =?us-ascii?Q?NO8X/f8gM5INTugAe4HJ/UcKHi75rTUwBvrrCSYd0E9J7TVXVi/7kuMY/Vbp?=
 =?us-ascii?Q?T4GaByHeMPQG5M7cO8nIjpF/TmJ4BJguIAoqp9+NUSNu/VGZTfM+55EKVUUP?=
 =?us-ascii?Q?3UUV9QloUGO6BsAgaU5l52PHsXCzC2cli+9Ze7gKCD5gEmDJK8NfE6GpLGH7?=
 =?us-ascii?Q?NGLSXSJH+7ePBNxJcEzh5CL63ocgsy+8gGPttDo4+6SAtwSmn7/gTHcJgqgY?=
 =?us-ascii?Q?txAMbaEAEGUjMM3YrfK2TBnxhj7X11me/j/Hlim5enD1GzLtipMeHWyMZ1Tg?=
 =?us-ascii?Q?CgQq9deBV1X90WjaHwrFR2uJl4Et2RTo1cdOuhJl5s9vjY4dYOfWU2m5dCJn?=
 =?us-ascii?Q?Vqh5m51M5gbnUZjqH9fJnt20tKRqBgMGOBrxQUkKYEbfnMLXYfZo3AVyzerJ?=
 =?us-ascii?Q?FgW1axKGcrXtbCsCwa+bxKoBTJoQr9wB9pfLn5LOXN51J7eRY5Rbl/LTevMq?=
 =?us-ascii?Q?Qb7RGXDzjWgvJm8WGSxoRnTOKKxg4t+zfw0eLxr7OCUMJZUehft7UnkCDW0B?=
 =?us-ascii?Q?gYJfXRM46SvYM648ev8cducC0eBDNksNP+ArwA1W8sQpT553Y0DQWsl0mbUA?=
 =?us-ascii?Q?ZGRd0h5tvOWUin1V0NNvXrHBRJfrW1SuymcgHiIDHerLmIQdZG2nO0f5ho15?=
 =?us-ascii?Q?J2oQwGMWkX+vWbbxq7dbTeHcsxH8N/dNhUHEdlbZb2xK6eF0h+p+M35jGSCO?=
 =?us-ascii?Q?ZDP9x0dvcxkzlYYYVxe6sLjNkDyM+4nj8bvAprW1fiu70it95LAFYynotUdB?=
 =?us-ascii?Q?iVwK9oAcs56zbiiTO1LyA9M76PWFlCafOA4FqRyi4ylIYe72tyT5vw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7c71P99/I8qPjAkDlKRqYhbrTha+/o5bNANY9pVM/7H0Wovl6QwEuLsnpWVH?=
 =?us-ascii?Q?34u1tG56M/Qtby70Rs4QPRij9dHBerWPpoFRQp0sFiHtGBoMZZcv+MNTqdUI?=
 =?us-ascii?Q?fLan0fwogfRyLcNFp7Oo/wUZNiQGBuNfLEY2NWCEzuw5G2nx4ivHf1bKsnn8?=
 =?us-ascii?Q?IE5OJgpQy9W2b3xz2KOsUjw3rTv0ds2DB1Ad7As520vLDRtveUaN6Uox6cXd?=
 =?us-ascii?Q?RmErX3e7XL8WU55gXwp+8p6T5n49ihEVGg62/AWXAMJ52PQmM2cqMOEt+ATD?=
 =?us-ascii?Q?kB+nvSxpWGYJr9XnXOmruNXmqC8TEaQ8xiCrYpjly/f4+Xqg3AFw5U7vSxsM?=
 =?us-ascii?Q?k6Di0UhfRPv5PuqiqnAO156RjNaGF9Fxi/ROsxMtUnanZcEIlScG4ZYdH29R?=
 =?us-ascii?Q?Upnk/T8xSzO0YZUm/b5eglYgaz/+MsHRTq9iruGEqREti/cKkXFFBL0BpREH?=
 =?us-ascii?Q?T5apmn3b3OJaTz19+cuwp7GbWn83UDCBoip85qrIEQH6g3oWpDcCFpaCyn3b?=
 =?us-ascii?Q?e8pqXzVY+ZkQ+Cb4neJdQAYMhX5bjNuroMqTvzoQ3CHJXKRAwwngseaTqYAg?=
 =?us-ascii?Q?9Gt8535HXDjqZFVi9ra7dwRY02ReWwRRzgv63X/5cIpFj6SZrNbgTp7Wd/Du?=
 =?us-ascii?Q?SbJrUnogY24Axxcq3EWWtBwPabXD/A5lRp3aaKkKQAzgwONsDwqRzs89oGbO?=
 =?us-ascii?Q?E7t1UKtCyAbQRQXP6AecdomsDBSZN4kFCs/ZjHqqRClvSTM4le19/JZDOz4o?=
 =?us-ascii?Q?Ur6mCAdCxl06Cs1S8oWHUpiBMOMVcS3DPM0gF02lvwg6YXx2Gk7sOWVxeXc/?=
 =?us-ascii?Q?pXBfu/pldiQuk0v9tmpAGQ+6hNNmEYH1bx8QJxyJ+9spX6RtU0CGB9wjXvE3?=
 =?us-ascii?Q?njHwtS5MFsCji+yZTonuio5XBqi/4d3mPoLfcT3gwRNGG+qFZrYu6zaI5D6j?=
 =?us-ascii?Q?Yv7f78OFHfTrLxXbp/6qJ8HZxbva/DbA1isdaDSNx6Jau1zuRQ3lwPLhSHR6?=
 =?us-ascii?Q?OJUZdP98ZPCq4ccpS1u+TfDBOE9kum4kceSWai8b6xFRoWo1YjBwqTN8L1IR?=
 =?us-ascii?Q?ueicjd7y1OpCMlBDR/q4VxZ3yepzp6Vd+TlWqJsH3lFGx0xg0l1exRC1bDUt?=
 =?us-ascii?Q?XjWiBmozr+nj1H0q/X+L1fy1L9CB2BZgi4lvmFEwnL+Vx4ub0Arewqq6JHEw?=
 =?us-ascii?Q?FpKpptz2DlXAM3KmDel3yVCpY01aoydPM+uepQ+A1ywZVE4Ldm7yhQWXEgsx?=
 =?us-ascii?Q?fesJZAeUuMSL1Zi3VMI3Tf/4DZxvxFHkedqYXANgyUn3Q2LxiwPtLIzpaC52?=
 =?us-ascii?Q?Q2cmJVaGQ7P4gjcFB+WUmgTCXkLKUXOOssjNcmf5XysZf2Jd1YU3TZYf5NLt?=
 =?us-ascii?Q?9e0R89d8zrzT7ZeJPq4lnP5SqqWwEdxBj7Card3UkyGKIm9ohH9fUe3O3hpC?=
 =?us-ascii?Q?f9rryIfSb9lpycArAuhZS1fLChnmo6CC0T/N4fW+L5of8bJLkLYVEBgP85ys?=
 =?us-ascii?Q?ckYOVyQ4ein64j6ReGwNaeVg8cUTva6YNF/X5mSq6Tz14nfz9ab6DQ1XeK1F?=
 =?us-ascii?Q?61FzkefH4OynBqHozR50MDL/gPTkOSi/V90e0Cbl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abadc2e-b3ec-441f-0219-08ddd0220d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 11:04:42.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IkoO4A4qcey4geVla0dkY+PXNl7gMPHFb9+8oYUZ4F2UcrqNCXWnD0s/SRvtQHWvNumMqi0AgEr7kIQ5ABUMgG76UBhnGMNmCiOHDVntBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8757
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>=20
Sent: Wednesday, July 30, 2025 5:54 PM

>On Wed, Jul 30, 2025 at 04:52:09PM +0200, Jedrzej Jagielski wrote:
>> The current layout of struct ixgbe_orom_civd_info causes incorrect data
>> storage due to compiler-inserted padding. This results in issues when
>> writing OROM data into the structure.
>>=20
>> Add the __packed attribute to ensure the structure layout matches the
>> expected binary format without padding.
>>=20
>> Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/driver=
s/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>> index 09df67f03cf4..38a41d81de0f 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>> @@ -1150,7 +1150,7 @@ struct ixgbe_orom_civd_info {
>>  	__le32 combo_ver;	/* Combo Image Version number */
>>  	u8 combo_name_len;	/* Length of the unicode combo image version string=
, max of 32 */
>>  	__le16 combo_name[32];	/* Unicode string representing the Combo Image =
version */
>> -};
>> +} __packed;
>
>...
>
>Hi Jedrzej,
>
>I agree that this is correct. Otherwise there will be a 3 byte hole before
>combo_ver and a 1 byte hole before and combo_name. Which, based on the
>commit message, I assume is not part of the layout this structure
>represents.
>
>A side effect of this change is that both combo_ver and elements of
>combo_name become unaligned. As elements combo_ver does not seem to be
>accessed directly, things seem clean there. But in the case of combo_ver,
>I wonder if this change is also needed. (Compile tested only!)

Hi Simon

it's definitely worth incorporating into the patch, due to risk of unaligmn=
ent.

Thanks for your suggestion!

>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_e610.c
>index 71ea25de1bac..754c176fd4a7 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>@@ -3123,7 +3123,7 @@ static int ixgbe_get_orom_ver_info(struct ixgbe_hw *=
hw,
> 	if (err)
> 		return err;
>=20
>-	combo_ver =3D le32_to_cpu(civd.combo_ver);
>+	combo_ver =3D get_unaligned_le32(&civd.combo_ver);
>=20
> 	orom->major =3D (u8)FIELD_GET(IXGBE_OROM_VER_MASK, combo_ver);
> 	orom->patch =3D (u8)FIELD_GET(IXGBE_OROM_VER_PATCH_MASK, combo_ver);
>

