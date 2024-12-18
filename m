Return-Path: <netdev+bounces-152937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE79F6647
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A642E18933D6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88501ACEA4;
	Wed, 18 Dec 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E31AlJhi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178A19CD01
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526623; cv=fail; b=hVCHC7DTBeluAbVBT7V9b79mO/MqvAtcEQosHLzbAeMq8zrmgseNpRiN0KFdLG2BZbOrv2fqTVFo843LBpZOGVn8zNSlrg1LsnTQCSowjhkURn/QpadyhdP+vKA4FtyHh/lyRSWhJocmnmiSNSOgpOfW2Vj9I+DVQb+Chhx5veQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526623; c=relaxed/simple;
	bh=sPeyBWrn5oG0ewXjnjcCqta9rM6OdUfXESdCvcwNJkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvXeboN1pG/lDxrQDydHgmckOQl/lhFE1V+leGQLXfuqXFzCjYSZpVkusuQ0BTBl/+DJcYrTjz04csb5ucuWw5BpbZaNDzKTRw/J5nOPep1l1GoDFvGljm3fGKdn5iRXphfdEC0sOUflBqmNAJzcyCALDtMxiy1azZqsVuvoH+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E31AlJhi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734526621; x=1766062621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sPeyBWrn5oG0ewXjnjcCqta9rM6OdUfXESdCvcwNJkw=;
  b=E31AlJhigZesnPwYnBDz6X1/HCVfmZxCwhexXrXOiSIkrbcctbIFtNN7
   flL1Nx+Ydqp7PY0PzBHC/8icX4BAWojSta7vIEy6W1ZnPbel7UDNGe9Hf
   aq78/3DZ+Zr9SJpRmnZJfSI+ZnQQW1z8cy2sRTXC3Tg4qZdlYsdcUSUKB
   u9iZUi3w3+Nn4sJCGIsua8T+ep3N/tBgy4I2K4qul23PVKVE6oNT4DALu
   LUCV3H/a9demm4oGmYYev0UTd7/0DC93WCgJ8zh6uRcZZVvbl3bGUFAWg
   eaLFB0hcL26mfT6pQZp0nmbnFTJmlk2xIpl419dCyKtzhkFZex4DHf/Ed
   g==;
X-CSE-ConnectionGUID: UNl2g3HVSaao+4W28sU7Iw==
X-CSE-MsgGUID: hOC46XwNRti2ykiD3sz49Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35152918"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35152918"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 04:57:01 -0800
X-CSE-ConnectionGUID: xr2lEjA5S2+zwt0+y49Hmw==
X-CSE-MsgGUID: 3cVhSx7XTKKKV9vwOt6GaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97697201"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 04:57:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 04:57:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 04:57:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 04:57:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwZO4V98lWi5yzxNMqSBPZfR/Z4tMMEBdbDAm7lRKiGY5sHTNlWQHgp4cFcVO3BC9x5oepYxj4/F8kQeDtVAQE2LDEkWWdtmHo6VbY+4JW7deue562s36fuXz0dZW2ksPvGvJXU+1R6Ld7sNhSfZ4+x6Qhb/dmU4LPemSqKK2BQxN9pMZu25bX295+999X1G/vVyXe+wii/zAm6FmHF/P5Rm3QFO3cohBkeO6CL0k/aw7WaQLLlgvMLS2u7Iab05zf6QyDOrDT14ZrWANtaOe1RCfvCw1Qvt9+EdCz4pgEP+gstlmR4xrMTK/qVHpmrBYfw9l2DGTjm6bpzJuZN71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUIubie4DEcLmhDj/v6hIvhc4/J1iCIL1pt2dCfWyU4=;
 b=ycN/czKx4TesHHntuxXt0gFlX6Xdbu6jxbQqs3HYsStfcaFlDWOaineTT7p/j3cjp1zspaMDe+YeQndqJqUoftuXM/SShzy2+/IdjsI1MOVo/lQfasMTsm0+rHTPl7frIs9mp2R1KqUXCOfgpLB6FLDjf7FUl+xwS4YD0kV/desJKT+GZ88j/Ebjw7L8swjIJ/OMUweXb237nrVXLMnNQNvdnYDlipLhi66sw8bA8ziIAztX4LBkWf6vce5x6HOMJKLV4mzzWivr0d39tkDsHnf/lbURYKy8jbRRu5moLRlLiyKe8ZuhnH4ASya+F5lABL7z1UWOHDBXioNT3jjN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 12:56:16 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 12:56:16 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v12 1/8] ixgbe: Add support for
 E610 FW Admin Command Interface
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v12 1/8] ixgbe: Add support
 for E610 FW Admin Command Interface
Thread-Index: AQHbRvInG38dHvyDB0SbOWbNs1HFQ7LsCh/Q
Date: Wed, 18 Dec 2024 12:56:16 +0000
Message-ID: <PH8PR11MB796560CDFA6D194A555F01D2F7052@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20241205084450.4651-1-piotr.kwapulinski@intel.com>
 <20241205084450.4651-2-piotr.kwapulinski@intel.com>
In-Reply-To: <20241205084450.4651-2-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|IA1PR11MB7941:EE_
x-ms-office365-filtering-correlation-id: b134e340-bd8f-4de8-7075-08dd1f635bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IiHt6xtkrfuxoq1qvUXs+oJF10eRJ4GnE3sfsZXVFTK9deQixM22AezXqZ1d?=
 =?us-ascii?Q?NyYwgTDGlmYMoFEE5vZzRVDx4qU+LtOEgxXKM1z7sUhvmBnbiIOkWyWLV5M7?=
 =?us-ascii?Q?BBdjUMJx0ur+kTaFEz2zAeFqiK16lWYc4HW06v0VAXO/ZENFN22OPYeD/Je0?=
 =?us-ascii?Q?F1sXhGl0adjcRk+lgrruwy8E97J8kv3HjZv1tX4iG4EBSxGH/u7oGloBdA9K?=
 =?us-ascii?Q?4jJBHCEmtN48Ta6Py8Df9+3G5JA2baKnSV2W3Uo4yLoPgoZty+r2mpiiTj/S?=
 =?us-ascii?Q?hvx5fzfkZD08NXCH5BOuzwSAeaCrR3mMPyugEjlC4y7DwwzBXCYPUcTfkzTz?=
 =?us-ascii?Q?wCP6VHEpKMIwfvbcVluQzODM53U1mdL2IUBCCJP2F8yvoOZUxvQB2TfJG1Nh?=
 =?us-ascii?Q?8bkQmF6WPOJBv9inJd29mAWQOA2vULAbuhghL6CgLI9IpW/cGQUGcNUIKsXD?=
 =?us-ascii?Q?P+yFrbfA7cluQR/DBxih5gJ6P94VBalUY2VLo+emcExdQIMfNJ4OrqaPSblJ?=
 =?us-ascii?Q?p+W+psfQ0YaEnKN88b24Rebx3CYoAIw4J6kqC5EqG+FNgtSneE4LwIq/xp2v?=
 =?us-ascii?Q?EykCX//4TeILuHSCDCpaZIe6RNkOK2lw8EeJHue6N6x5ImwjxSBZq6x1lV2z?=
 =?us-ascii?Q?2Dgl10hO9y9XLv2zE3G+adG4V03WBqWoEc5Is3bKgogr+hg4UQr6D27yoVYz?=
 =?us-ascii?Q?UnehUQPYmGQqIoVercUQ/VaAd3O0TIrBCVJj6+r0y2LRXEAopz83t+8om4PK?=
 =?us-ascii?Q?8A5rl0vhXw9bNPyoKV3AZBop3Y5Bi9j507PjacnMNP0DbyHuYUNKF0qG9MNB?=
 =?us-ascii?Q?Yp4ls9Ca5skAAq7SkFhNazJW5wHIYe5SAP3lCpeuFH78ktH2c8n1+n8gOyBb?=
 =?us-ascii?Q?ndBfj22Zq1lrMEXtdG+GBlE3Iq9ejt+GEj9l2Ytjj6uTMPIal2IdACIiGudN?=
 =?us-ascii?Q?kgVxaAVYIBpWt4Mg7NsCRh1svcWHHHZb0UfUSt+hJZkqwq7AEu6kn7KHHDyD?=
 =?us-ascii?Q?sHsiwoPb19ROqtHXL/gXC1axaAc9eSu7na+3lvST+5HlpzfkhWvgeNff8xuJ?=
 =?us-ascii?Q?1k7jgB8OCWCwcj1KD521/FZXyrM2LUfs/Ur6ial9iw/6Gb2roHv/TWGHDGz5?=
 =?us-ascii?Q?zF177+YAoBf2me4nV3vWsZtgxOboffd2Z3oeNOPNBY6mSLPO4jhc6k8v1mip?=
 =?us-ascii?Q?7uidcirW4hICrL0q1+Vhal+ogQTzNgGD/GuNQhpqU+yYZDYAvta2QnAAlOaO?=
 =?us-ascii?Q?RajsuIxJM6Vdkz+q//K6LTT1blsrR9Y9L6bh16IQ3bl1+kI2aCp3J2fNbfLy?=
 =?us-ascii?Q?Md47ZdH0ks/9GhDkszyfK0UAznRDY6b/svWsotBJzjXyPVg0sWNkUp6vFyZE?=
 =?us-ascii?Q?VPlSOvhYQGGDE6IEzKlrNwTHR/fFhQ6DbpO/+rzHQ3Yx7oNrbTpONWmY56LZ?=
 =?us-ascii?Q?qsFqPoCJ7C//e5sCdpkg4pZmiuW98R3H?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7FsUhMVqUGsg9XUvBovIooZEQUwmEXxZpFFB0J/0l7styhW6KxPpw/ISsIGy?=
 =?us-ascii?Q?+ywPmMqn4/7rXRlLHhH4BGjlZqsBEC5iU5EA5tMuAEFJjXAdyePjFtaNz/Hk?=
 =?us-ascii?Q?UyhZwQNNRobm/U7sF/3hwnvGM6anzAUZoCVhqtdInHx+0Htgq4X/hiOqIlE2?=
 =?us-ascii?Q?td4oPLq0/02gbSGppGt7rxQFEMZSmQO9dnapsq+8O+GgEPjz9zuORFLdv1Pc?=
 =?us-ascii?Q?XAdAX31qcwCQfzJbE3a4g20EPh1ulIJkE2D0FXehvo9iWM8wz+yRIeUtE8+N?=
 =?us-ascii?Q?M2zeQ5XRrp6EG9zIJ6qZdFQXhO+1ewy6BKwFzKotEffdXGdUUGWFwOGYXOOa?=
 =?us-ascii?Q?w71QcWB3bcoDaGVuM8paWum7SbJbOQaJ1/9i0Rt+ZKUE53UwlSloXEdxFxXL?=
 =?us-ascii?Q?+1CC/ra2DGnnnnN43sFPhiCfELuk/59T82V2ARF+btwqGzmW8fOxxH6HhrE7?=
 =?us-ascii?Q?tmvFrK9e/N0WFytGWwWKFI/25pVszjBYTlGzwKr+vjiNAm/YLEjmwq7iInsC?=
 =?us-ascii?Q?yiIIi17pyNCvrWXIL7FhT18+65os1XGllx8vpPuVJvZo4Kt2qx3BQRg+BvyZ?=
 =?us-ascii?Q?4GW++GUyGZer0Ak/v5wAi7KA4hm5TmCc1jz5l6mdzyGjVo5weyggGwwP1Ne2?=
 =?us-ascii?Q?seR3TjrHJqQArGiOvKKtDr7dhDcpwPbnAw9JHsceqitqCYo5sNiw+qHLmovU?=
 =?us-ascii?Q?yBIQW1d8u6+feDRS/ESxsqUKiny6SoJHy+TNcEOHHWUOONBnr+lAD20HCt8v?=
 =?us-ascii?Q?jetW1Ncv8d3PrzgK6G+hLaq46fWsoHvfLe1GPipzLknkOUlgACh/gpXgE9fX?=
 =?us-ascii?Q?AhygrtvJkV2BH0dgr/aI+4Nvz4/Q/7NRRgMrbIT1U2AabfxEevez/nfCCzwb?=
 =?us-ascii?Q?Ccmt4bebF6OCK683WorIEH11NrzdC+AFGKjVplF1r1qfMlPGbBmBeMyF7uge?=
 =?us-ascii?Q?ilUnLoFaLupUYAbMm1Zuu8igjgItAWw0Sp86JKn+cTrnFiQZDuCYXbPjK0RW?=
 =?us-ascii?Q?fXbExCaLwMQl34FsLV2oEHbHLBs+f1rRPXotn8pyfsZvyXxDoLYJRx+cfq7C?=
 =?us-ascii?Q?ROsY5KnKOtNS2OMX6D5L5NFVVjWLO8Fc9ZFcigMr2d+Mvx2ksgqYpM44rRhx?=
 =?us-ascii?Q?C5VGoyTPtK1uBj0AXfFqYhFIeF0KgrtI0GQXtskC7kkBbyF/askne7n8jte5?=
 =?us-ascii?Q?Op0LFcrylUS7LYuPkxl50RIhe5Sr5ITEsifshNFEXeqY+U6gre+s4aWPagJd?=
 =?us-ascii?Q?odhLyg9EDUd7r/sJRFKYD/2BZNUOYBXBz0+CNsZOztXAscP/I+ppy1tfp+u2?=
 =?us-ascii?Q?uGODB+7HIAJ7261Q4xx+30RdJtcFihWn/tbLVloZabBgCNnMDm7cZxDnzKju?=
 =?us-ascii?Q?9mqM0OFFSPG6X2XtLsYk3r3934DrnZGEQrQccr41NijieuH5ZJq7vOax4hWK?=
 =?us-ascii?Q?cYgM+JIwTGiU4U7EQv/YgfbkhPULmoBN4aeA92xWdanJ3RnqSgGj5uUFL32f?=
 =?us-ascii?Q?+i7u/APmocDm7u8UB942f1E/UTB+tZEon1DSIgS+65QOtZn6gVuyYUC/ar//?=
 =?us-ascii?Q?l+skC9dc5oVOi42v3y205OQ/dajwJJO/uhSlV6oc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b134e340-bd8f-4de8-7075-08dd1f635bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 12:56:16.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4wNEduLoml27wDvpmKGcI0F3pbikBRCVncqpfTg6FVpgjyse6heFC+VrzU0AP/Y/3AmUDhA2ksAsB9l2C8l7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Piotr Kwapulinski
> Sent: Thursday, December 5, 2024 2:15 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Wegrzyn, Stefan
> <stefan.wegrzyn@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.c=
om>;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Simon Horman
> <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v12 1/8] ixgbe: Add support fo=
r
> E610 FW Admin Command Interface
>=20
> Add low level support for Admin Command Interface (ACI). ACI is the
> Firmware interface used by a driver to communicate with E610 adapter. Add
> the following ACI features:
> - data structures, macros, register definitions
> - commands handling
> - events handling
>=20
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_common.c   |    6 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  496 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   19 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   72 +-
>  .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1066 +++++++++++++++++
>  6 files changed, 1656 insertions(+), 7 deletions(-)
> =20

Tested-by: Bharath R <bharath.r@intel.com>


