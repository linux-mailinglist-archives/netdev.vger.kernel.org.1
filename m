Return-Path: <netdev+bounces-134534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C099A040
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBAC1F22A25
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036E20ADE9;
	Fri, 11 Oct 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdTDuizI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBA1F9415
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639482; cv=fail; b=ojzteYFYRYbiVd8sSvLBU331mJ7rm8/C9n/mCHi1Fs2cliiG4nbvbySyHEjmmXzzVADblqfaJ8JgXCahNrFM2+DrGKiCy+0Pg/+vqTN35do1Bg5nUN9CSfk/p5yBYT5s0PUKgqGMpDd32rbLyxGRiT2G8dncyukWiw5pSfGd2ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639482; c=relaxed/simple;
	bh=ablus8rfm4TMyZsC85vrwCeO21WFWD1s+ryExB085i8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eInd0wat5gxpxDgBfJiSBWFqWSMrmkFgzpO6PJP2c9d4IopE/DH1/nU2WwTJO+eYVOXjbeTeMT1ZeMAH8wrIRyRaGNRtggeliHBQu137ti8XAjVbFyn39Q5W+HdA+Ow8/+V40T+jFak09m1GUAlmf1aAPO9mJ4HkKKjdAI2KacY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdTDuizI; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728639481; x=1760175481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ablus8rfm4TMyZsC85vrwCeO21WFWD1s+ryExB085i8=;
  b=CdTDuizIC7+WvzbNhFnArTaNwFE9s2iP6HP4X5t8NAnMU9HeLCmHRMO2
   DcRS1zjvq2Mk7pxbvpMKppXk/Da86vgVls5TU6Tod1uSFGPCabzU0OAMd
   /EBwbVtFdx8IwUwh3NJj1uVHVttkEDQD97c0TbeoCkWYZL+qQM/ea/MQc
   X4RdzeWtorrTuUhV5j+FPBFf3V91vbGnIzCuCBZWZTYR0hbMXI3Ws2fmX
   tRX+5oFEUHylb3e7fXSOSybEb8h6p5UtFtrRVw78FQRiH4biR+wrwjhvk
   ZAMgynTHwq5xnPOsg2ZkhuqLjinlsvehlYPXU7q18DlUO6In/OUAW6ebF
   A==;
X-CSE-ConnectionGUID: 2o9m2/GPQqmfcxhicdNXAw==
X-CSE-MsgGUID: 6h59NuzNT3O81M3DZ/auTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39427845"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39427845"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:38:00 -0700
X-CSE-ConnectionGUID: fG4vq2bvRbal3DZhfpM6AQ==
X-CSE-MsgGUID: z8Knwv9UQtyPW3HEemE0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76773895"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 02:38:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 02:37:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 02:37:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 02:37:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqlugmQBQw8GeMg68cbvwHPZW0vxTAa6pyirsVpFPxAtkCxgU9RDMIl6a6NUwiqbFGRixf6kNsAmKAASxE0CssBvN+/eGIVQBaFpSRJw9DbzCQsFFjxawXRXuW+NMBvgccnyZ62dfJbmG9mgidPI7f+dCoWXnjQ/LhQ/SNrcxNAvzUYRL87V7C67bIynnNUoJp1/TreqSIdVagMGRzqRBrzj6Oy6/PXCZN++PPtyZY4ofHqGTo1gg2OxOywarRWBsqtBgufWirwwGf3c4VXcE7kYrQ5Hr9jb2Bn4AUe99+pVDj0C63QAW81msLBr1zWJr+Ni3kSERjrzXsFvKaRvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvydJGr0ORoEBSOPL06QcuMqplHNs3P2toCjVoCaPZk=;
 b=IFyitDAm6WVm32RV3xKjvRKx6J9dzHbtd4fH2b8qYAOZIKxOzt3k7iK79RrXzcL9MZa0jNupUp8Y0vdFLaB4cZjjXqylYLnmJYQSAYzxCrVSfBjhPs1ab6jG1GHgFxLS/l69zCBnxDWRTWtFwUD02GKM94o4B0zDWV/VHdz5MwsCQSl9y/hDf2SSfrDPfSbLFCdFgyNkt32W387qgpTGDJXJPip30dtwTXb5o4v+mJl1/I5ukc+r27hsvhaLI0mowRxoOZkalQ1P6n/BlaZk+Vs3HJtIAo4KN3kC1FfLGHO9HodTXY5slJxz3U33QO/fLXTclu3UEySwmAj/jxnXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 09:37:53 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 09:37:53 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Nowlin, Dan" <dan.nowlin@intel.com>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/2] ice: refactor "last"
 segment of DDP pkg
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/2] ice: refactor "last"
 segment of DDP pkg
Thread-Index: AQHbFSlNJpJcyAWjbEGhDF9DV93EqrKBV6cQ
Date: Fri, 11 Oct 2024 09:37:53 +0000
Message-ID: <CYYPR11MB8429F5EA7967B93BC0299AA6BD792@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241003001433.11211-4-przemyslaw.kitszel@intel.com>
 <20241003001433.11211-5-przemyslaw.kitszel@intel.com>
In-Reply-To: <20241003001433.11211-5-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|CY8PR11MB7394:EE_
x-ms-office365-filtering-correlation-id: 2f276aa4-7b72-4eac-4675-08dce9d86187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qyN3PxyINLKsU/eTqgDDpBSGSEqjWSi27RtN+wC2JZPOUeFP8J9EtUvG4vRW?=
 =?us-ascii?Q?Y0PCK5mwNeWu+fXMYYCGiNWeYFv0mtFV+gbgZyrqp+4btG6Vpmdtg04v+xhy?=
 =?us-ascii?Q?zQLiJU2RSdNHHCy2lTIq90pBaqQBskHOh3klCDp2pNDBVNu4qsF2+lnnm4sG?=
 =?us-ascii?Q?7nJShdnqvOGbgLK1iO+sl/4xyC7TSeq0K3HkxkHFi4QJCCvnTOt83XjxUaji?=
 =?us-ascii?Q?44DuxqsSa9Arsmt9dkCo3GSJ/XM26bC+ZSHzDjZUX8ZN96cuMT+v/ebIyHeE?=
 =?us-ascii?Q?5i0cXV0TGkVFnGQCvKq64adsiiD2PZvHI8Xyj++L3BNaGcDqQRmlXzcQS29J?=
 =?us-ascii?Q?cioL8wapKIngs/8OpSkBMj/SsyjZdDO2mvPJB0nIEChh9h64ImgUQYhRkxIl?=
 =?us-ascii?Q?j/FSFG3zIcJHvq9nb+LIl+Uioke7L0Z08aRtuntlIWj2qCjDG9WeLtbfb43i?=
 =?us-ascii?Q?V57VWgB5doia9IqZ/+U8z9Ggx+MbHA/EN8lhFO1oUOl2VPLIMAWMBT+F6qE7?=
 =?us-ascii?Q?5z1kGQtFBZ+vd9MIEMrE3Q23/1fltMOHifj2sK3/FyzrpKWI7xv/1UtyNEI7?=
 =?us-ascii?Q?X6R1jbylgG9x0EifpJlLb0lkRbFjqS9XKgcsIKHgFTfHUGnK0YJyShkr1K4i?=
 =?us-ascii?Q?9J/1JSKJLT3rzoMLIkKLvykd+RnFIDbBluiKG53+XKPGB+I22pM1HJUoPS7i?=
 =?us-ascii?Q?7u5YS5H2JXrslcALAZTlCmwRfVLpRPBbPCxTV2YBAEcyTNAuN42QYKIBkxiE?=
 =?us-ascii?Q?nHBhzeTI16AfB74eTONNjVuP3xZfRXjY4Sc0jx0PPSRRyxBWrl/LXU9MG73L?=
 =?us-ascii?Q?xRxUhlKxML64qBKl5OL8dTlbpJ/fP5CiG1pPDD8hQM0ZauaBKoZCV4qLEXvc?=
 =?us-ascii?Q?SUap0IQzxzYtNsH5IxLoZtsMC2P1pFnwH4IiE9Dyi7mOF5EK4FFuGq4AiWUE?=
 =?us-ascii?Q?XSibv8zoUx7X2D6nnJVDgRtQnPG/qEu2uECqCmY6JczBgPq7gx8rSArOR8R+?=
 =?us-ascii?Q?eQBmEX3Kl/PZVqSSMxHnIumi5ZwjXPARpvuWIvkmGgT8WofQq5Zf5dFk7iIb?=
 =?us-ascii?Q?ZjLsm/S82yG8lepA5gwsROP0MoQJOdTet/YQNuU1inT4yIzB6AnUqOik6ezL?=
 =?us-ascii?Q?StK38zWVKkeW2o2bJlhVlaXURb274DU7Pl5Y5FovXisLgnnt9HAkTxlwnlgo?=
 =?us-ascii?Q?1XI9s/0ZptKEcwmsFbVggwogrjxcKddRSlMfQa/bwp0eBoFl2kDqUUK7aVbZ?=
 =?us-ascii?Q?XbTVLKAsQ9xjMv9lm5P1vDOfozTIMOQrfYhHky2zqZxq6K+j+N4n1qnYIFlg?=
 =?us-ascii?Q?nayBj+/vS8BpUCWgw/+UPHnkU8nQ+m93y7gD0Gdwztaz3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dmJKxl1GI0IOQ2iKoTeMxQLri8aAsdBwu0awdsC0BRT43x52+Sx6vrY4mOsE?=
 =?us-ascii?Q?iEIKVzsBAyPfoEIY2nWqVMOXZon3dr76wylDqLxmj9y+pqwDAQKZUAqkkXli?=
 =?us-ascii?Q?MOYvZgg4r7+D/unCxB7Ooy55G+cmQgqK9rVqj/bcWL/EVYV4a/LFY6WQz++K?=
 =?us-ascii?Q?DVCSsuDkYPGYmC6NVKyg1UZLHp4HWAwr+Bsl0Qn6nucaOinbInsGPEERnfW2?=
 =?us-ascii?Q?pvJ197eEs61emLlhLc3GiE3XxzqV/jyDmO7nLfnQ6E0aYNRSEYZTjNrdJxak?=
 =?us-ascii?Q?V/uOOoBkPEnL1e8Wq1kL6f635F5ngLto+0u//xVyPKvIdoJW43yWWp0+kbZY?=
 =?us-ascii?Q?w/pJbv06r/BnRF1bxhP8ioK8ZcW0Zk3AYL3NYT+5CGw8JJPpD77tRp3Hh2Sv?=
 =?us-ascii?Q?3QfFCMkJ8WHZCLwMDv2TQoAOzli3/0zNpKXW7Ekk/7WgagiURN+EsdA4qIdN?=
 =?us-ascii?Q?9hfMDF/LYoLBtdcbVR4OhtRGX0MrWeHYxcAPFcdjBwl0ZYb4yjbtUADwPeQZ?=
 =?us-ascii?Q?QQdc0CMM/IgZgZuC4eG57royfpG/bgMUJtJjQkP3H/eljcI5F9jm5nNFmiex?=
 =?us-ascii?Q?h1fIXUhuz+f1xcmA1Cuvfbhq9H9fGFF5sFYMVT8Kdn8z9q3nB1d5M/0UpFdw?=
 =?us-ascii?Q?HisJ4x8OxrxRmhy5Z+W3Tv7TbDHysLh+aNLVwZe8saTwVysYzCXzGJCBaktO?=
 =?us-ascii?Q?BGaPlyZshoYLQA8QBmwFOVAZSZeMkAkmVGo8MKD2ilNB+5MXgo+JA++chetu?=
 =?us-ascii?Q?6mQBlTOx/7Dg6tCidFJSn60BDou80RLQoOH5Cho0WZ4zQS6H/twDwQ5vgm9i?=
 =?us-ascii?Q?Uxj7tz5n2I/vdyDFG18J25pYEcCdigLazxo79L09bDpVgOgCAdJ7Mf6WF5M0?=
 =?us-ascii?Q?JmoLgicUmrNl/TMpZGnkpXuKMUXQ2toGp3TroTW2CVzFPuqmtr63CCZKVDVX?=
 =?us-ascii?Q?ua3bftE3dzB/hsgP8aBOAGLwAbTiMAPF1w4Q7uWKRP/GvxNPBjCn2Y2JE+Tk?=
 =?us-ascii?Q?W/q9q7ulDXcdTyWqhvuPhbHJSWdLtayUyt74CyF05G7lx6XO4Ns/lJKbfyL0?=
 =?us-ascii?Q?pXccme/hLnxtfHg6dWOcNUG++svruwHR3HAJgVCEjXs5AcuJakini4ADmrLn?=
 =?us-ascii?Q?P5uRogvT0ICUHLSoI2cnKdcTV0+xvIlJSMmE9HkrK2O+kiJClVccZOuQ2AvO?=
 =?us-ascii?Q?7NcSUX40VLbMmceNO0gC5DkcV4m9aAmJcLoAajtpQD0js87Afl6uDx5CsxnV?=
 =?us-ascii?Q?qC9rsgPhApWqRrE3VfGsVudkw0WZeDiagfwfX56aQD+bqZMLnkMtHFn3VroA?=
 =?us-ascii?Q?vi29tObiV5Wd5vpn8Z2lFFg6Zw7SsOxXrXWDFWtZrupujz07aSbABL30k3lg?=
 =?us-ascii?Q?Bov/DGgtolhqYoKZelC2ho92vYWk73glp8fTjo31aLwOBdBV5MV8BZilbgMF?=
 =?us-ascii?Q?Wwj+w0b6gLHozKuCgIB3NzdpnRWWmKgEKjBBDR4ldW/3WZpAEMiiTyITsTs0?=
 =?us-ascii?Q?wUQtxlp9QkUsd4Mx6jNyvmUKKm2kMyLsBeW6omUJogV08LCFuVhgvVj3MkyB?=
 =?us-ascii?Q?scMBOaO9hGzU88l+Cq72PneHDt1dKWDsmPODLsptZiRV2lyLVpQCnL3gm7u7?=
 =?us-ascii?Q?qA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f276aa4-7b72-4eac-4675-08dce9d86187
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 09:37:53.7826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Csqj92J+efW8O/2BcdKG15XCfhAW46d30VXtmMUYVcvGA/HCikwpuJFqrVRgUuVQv9Uhwsi4TxLVRGR6MWjiGNHPYUi9XbziTIg5/zc19KkXQ2vx4yKtThe2z3oWDAkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: Thursday, October 3, 2024 5:41 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Greenwalt, Paul <paul.greenwalt@i=
ntel.com>; netdev@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Kits=
zel, Przemyslaw <przemyslaw.kitszel@intel.com>; Michal Swiatkowski <michal.=
swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/2] ice: refactor "last" s=
egment of DDP pkg
>
> Add ice_ddp_send_hunk() that buffers "sent FW hunk" calls to AQ in order =
to mark the "last" one in more elegant way. Next commit will add even more =
complicated "sent FW" flow, so it's better to untangle a bit before.
>
> Note that metadata buffers were not skipped for NOT-@indicate_last segmen=
ts, this is fixed now.
>
> Minor:
>  + use ice_is_buffer_metadata() instead of open coding it in
>    ice_dwnld_cfg_bufs();
>  + ice_dwnld_cfg_bufs_no_lock() + dependencies were moved up a bit to hav=
e
>    better git-diff, as this function was rewritten (in terms of git-blame=
)
>
> CC: Paul Greenwalt <paul.greenwalt@intel.com>
> CC: Dan Nowlin <dan.nowlin@intel.com>
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> git: --inter-hunk-context=3D6
>
> v2: fixed one kdoc warning
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 280 ++++++++++++-----------
>  1 file changed, 145 insertions(+), 135 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

