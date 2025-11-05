Return-Path: <netdev+bounces-235727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA51C3439E
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 08:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8BA3AB93D
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C62D2493;
	Wed,  5 Nov 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw0rB3nS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F534D3BA
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327808; cv=fail; b=XAJwHMnOnFcfoYHeCHrYfUB6RXccxfwxZspadIMSRMLK/OlvTDlJ9NYLBeHjsuXzXbpiyGvM0BkB5EHFpuj9wb/OZ3fYDt0WHkMK1NAANX8g6M2vYnsudIgEUtiMMugaSpwjr+7fKHL1Uaj4MALSCLYBsiSiX6TTZlkP8jjE/cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327808; c=relaxed/simple;
	bh=k7uauQR1Ho9pZPHLPLKiJrCxUi2V5JfzdYxwrRiJ6B8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HNDAgHvY1W7m+T3vinsR1WWu8puCwlRBZV9J1W6meHTSPaTwUEUDlhYJeotjMJ5LoX3J3yeFuqEVb86ZxGzUakkM/d01K73pngo+28P1W2vvOqSpgeV+h8rk7A1hO9pZm2SVCkC5J72eMDvhYFkGkuwaRHDfYhRSXxaqyPUBq4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw0rB3nS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762327806; x=1793863806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k7uauQR1Ho9pZPHLPLKiJrCxUi2V5JfzdYxwrRiJ6B8=;
  b=kw0rB3nS5sUY/D8nbZ9Sl+VvekOm9kz5k6d3lR16k/FBwYKFizGUi2xe
   fVDoGWXPz8mmWdOFDop8pzhpnQ1L9IblErptNmAWnGABFqa5nwWXVeaUh
   PuflrAkXy22ncC5q0550dKZzCdLKFfosINB/qvkEXKYVol9RF/RVWe3HY
   Bwp6izttIhoAEIXQKXTvrtXeA38etnv7361+UJJxEdsaFhvCvkNAD/2iQ
   U9csZYrNkJ/bON+TVUg9/Kifci17+mrq0peLSx+EYaI4L9KI/4Q+4MdFo
   gW8REaQwK+B8EIGB55HvDhU9h1a693Y8kny6pvF3o9CWb2ByjLfZhS0v/
   w==;
X-CSE-ConnectionGUID: rnK3R6VXQOiDgIggce682g==
X-CSE-MsgGUID: WIxaHMjxS0eMSGYEa6rHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75114664"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75114664"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:30:04 -0800
X-CSE-ConnectionGUID: X7/EpyKNTdOv3DmLO9TVtg==
X-CSE-MsgGUID: NoZtiLstT/K6856wG03rUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="218025929"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:30:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 23:30:03 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 23:30:03 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 23:30:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBzb5/H75AyWMUMa6l+zeDRSiwQN5BidWS83NpSGlfEia76lP6TCZY5MSw0RTJJ3hcPwr+iKnaYikPfq6E+11EGKsFCxyTyTbofae/8BYeVTwKnizblpxpH6oT4BAXQJ1B/LVjO0N+Dl/CGAtJP3jsL/YgX/rRfun51ODYaFq0gr2GMzW/vMYKNAmP0LvYx747Jzf07fsnYGoKxHAsGvxOiO0f+sIKuQyr5sxqWpOSFJyfjhX0pqMjzA2n6S/dbHv8F8x6FVsGJw4XPrFhQzjjYZdQT3pWNRUiD/iMaVq1/sc4l8lmhl88mb14a4PYy5h6C25hA4qyTsRJR4uxXW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxhXAiipuSGTjTCFz5ZkG4M87jOuWnPUhsFjLC2+tgI=;
 b=e9xmJu4sSMw8DjxzjLtY/YuElMI9f0LkSriYLG5G3L3byNJ/NJoHUFfOkMcUqgJywXIxdwsS2AckPGrmM0NK2LgD6LyyhwJr7uag7+DTGn0vdfptoVgg44UIj1IvG0bDaTvmSqNOs+cIOxE1RVfiSMhAqW5uYabkwnXEoN7oND1hrW3/LMNc6Bj/kND1T60ESJhiFTzdYQd17pMtFKvVO/AL8iqt1e3azv6ULdkIwpdO0a4JKWSMjAYWKd1t4ocbnXwDILUV93WMfY5Te+M68MeIzZzOUs0/jfV5PSKYJ1xGFts3LdGmnam+FHu2Tk/kOsCH7jiJyLegcsFlR8ANRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 07:30:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 07:29:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2] iavf: clarify VLAN
 add/delete log messages and lower log level
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2] iavf: clarify VLAN
 add/delete log messages and lower log level
Thread-Index: AQHcTZ0IkgEDbSYX0kmbwdo5tWm1RLTjsEmQ
Date: Wed, 5 Nov 2025 07:29:55 +0000
Message-ID: <IA3PR11MB8986153AC57FBE801247FD50E5C5A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251104150849.532195-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251104150849.532195-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7631:EE_
x-ms-office365-filtering-correlation-id: bd4c68e5-08b2-4430-75c8-08de1c3d1e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?h6gYLA7motiyMW8JkZM49STPNInK/lm5GpFa/UbRaa4ypDV3GOmUQRUYHDkE?=
 =?us-ascii?Q?xxS92mR8ll/Ttbg24Ui3LvPQ45R+LkAASHmscX/q+zm/QbOab69LUx2XOG3I?=
 =?us-ascii?Q?wrf0MgiRLrd4uP/ljklXpkjshH7Fh3gwn17q1yKLk4mbuHGRy2IMFgaPpf6g?=
 =?us-ascii?Q?GxcUjuAtFJa1/kt0VE5gNmQlBxIyQTqZ+zIkUw7QhBxKEFDsae5JmSXhCmYv?=
 =?us-ascii?Q?eE1oKzdKy7lphXpgQ9LX2uOGQGkwWzfaxbm+CPx3rZW3v+nJP4ckgr1b0QeJ?=
 =?us-ascii?Q?odhoaBsoE6cw2lP9Yw6sDswc/tta7Fo5BzvTY2X4SXGU1y672JJ4N70aqbgp?=
 =?us-ascii?Q?kI6Y6YmtcdJm8QhmOrp0MgRxqcu3j79v/nmNoOh6A6pUb6dPs3pVqc1qbg6g?=
 =?us-ascii?Q?ft2M3zFm1duMemacUlVC/bEYVNt9mbymJzsQsArRJrddvGp9T7jCzFIPHTFI?=
 =?us-ascii?Q?OjEpt/Ixjm0kuQqp49gVeoECJXfBVOGinL+h4LuW1k5JCmpW20gRCJBzHn1O?=
 =?us-ascii?Q?MLBxgWC7oZBMinwrTa8LVjIXwDv7RS2pLk43rWBeSYa6cOMQCQmGydnudAhu?=
 =?us-ascii?Q?6XzHaxYDTpaJnsugVslFRHqoTHauZB5xOAdvmcJLQHGIyK45CjbDBUDkJp/C?=
 =?us-ascii?Q?/UM1P9fzg2hN3Tnur5hlpeg2RBe3vI7krxhnrDNX2iFoODd2aIAOBfeA9Q9e?=
 =?us-ascii?Q?A1ux+DkluTKWkeYBHf1E2SSGbnwZ6WlCsLrHmZZJ7pwgWLcvYBBjOfOY9nEJ?=
 =?us-ascii?Q?mooFNZERELCSWSIkRLPbbWGsmUYoyTs5YlrYaOEgQUkp1Kte4ILJNY5iU/p8?=
 =?us-ascii?Q?zexgnffprIUp+I7OaMZzMqzICR+Zbs3rL6AbNwtMRYA8xd5rlocG+EHH2ejn?=
 =?us-ascii?Q?El5xK3iXVRHsxEkzDB09nC1WSy+a20ceC63Q58+p+/C4IZNV/Bc3Y1kqERup?=
 =?us-ascii?Q?OfPPNZZ3EvuKUgPHfuGR7uRCMxc1KHrZ/SlDG3tBMA1U3/Z/fnaSPBC/7IVK?=
 =?us-ascii?Q?MJS5KkpK2vdmowzrPHGSD6YS7cOcGx/DDqhqGyv+K2+p+p+hI8QLAjH4Mkdd?=
 =?us-ascii?Q?a6h19LzxlCF9LvbeztjwY2A4/RyaafClkEo2PFuNolZD6Lra7KpHe7SjFO3f?=
 =?us-ascii?Q?IjiShmYPdSr5sU9XKy+ux7R4v2UiCD77/SzF4nTQ8jsWuH/zZoT+TpoOIjpP?=
 =?us-ascii?Q?io/zLJ2Rv4UAXgf5Hk3WxKbwZSq/0r6C38TVbR84B0UMBG1cz5a9b5o224fz?=
 =?us-ascii?Q?YhXvHWvCee/GqM/8x4DrhjgFbOMYIEZGNduP0xoy/IUHfafl5nBiARiyUqvH?=
 =?us-ascii?Q?GQPeYOM9yKnwIaQHSa0UskeLnO6u/CrV0z92WbuHD50SM3nEaXWipJCL2uUM?=
 =?us-ascii?Q?ClsEZSutk20cIaDceDr+B81/Ej8gDZP2kEgBahrPgY02YHmyf0uqQJ9KcBDP?=
 =?us-ascii?Q?O2PFSuDQ7Nt9+pUOOJOjQcLsmg3CEOdZvFsZOW2x4fhHZ3BzKjBekmSe3o6P?=
 =?us-ascii?Q?PqiVm+3roN4/yoPdji0kkVH4PdE985Xuwku5yTcsgPeQWQxJlNolHT0iwg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EjQ/KzNBmZ/2NJVQGTmDt2hqqQURMUYQwJu4lQqsgSku58+InCH4llK9wzrR?=
 =?us-ascii?Q?h1q4ZA+uEIRsx3i13IPJMXWJgD5JNDyerLAYe0RUkZkH+M/H1Ra+D8o6NxRQ?=
 =?us-ascii?Q?24XjBqjxvXNCTgJCquSAmQl2M6bfcpXlvAybfSb6QaOu1bSf3cjnPian+PeA?=
 =?us-ascii?Q?mDkSnQJ9rgmD3lvqfUjh/kDGshzjyvvXm/gvJjHRDjgRMF2deMQQiq9XFqS9?=
 =?us-ascii?Q?d6mVaYoF4WlKZ0BXRbeTgvjy57Esfb75+tRuhGRogtbaC8hvcKvMLmp+cXFh?=
 =?us-ascii?Q?LsMmZ1fEnJ8kYyF69yc5tEoEgNiSNqL4PVAciDT/R26jX0RX+/KS+bbUiXYc?=
 =?us-ascii?Q?QQ8aheXW+qfLtyOk7wRebzXK/HvhaB+ZDgCuAhV+nwSBC139uyshVZUT5BCf?=
 =?us-ascii?Q?M+lVQaN2P2PTPa699Cb+i8FUXUE7TIWLmNPp73QE6xARAtnp4361yPBkQ65X?=
 =?us-ascii?Q?1Klq8Hk4yVQwp41l3Sr+Yg9I/meSd+TTWWOdvjeCwyEvRSsdt1pRNa3H1kiK?=
 =?us-ascii?Q?zuvxfD4ESzldtVZLynUXNetlgL6nL5rNq0dmVPTw5LzcBm9bo+gysOuM8yib?=
 =?us-ascii?Q?uxSwCjp/ZEA+gsNKHAYN/vSSzas4btQWGjZwdC/haPj54+h+KS3k/BNNz/Ll?=
 =?us-ascii?Q?h9ImumSDIF1aHVmfLpl1MH/xuEGhWCPlfxa0ipQGdu+0jfKNge+y8S/RPZJO?=
 =?us-ascii?Q?Zgx/kNqeV2gaLaTTR44oMBL1L4BfLyVzKBzMERf1n78r75nbZr3de1Djd/o8?=
 =?us-ascii?Q?wPQ5WuQJRPQBuqMtv+Yd9cSZFVlruKx1y2ZCgAO1akLnEjszy9GH8uA/l1WH?=
 =?us-ascii?Q?xKeD72mzuTQWWE64Gxyofry7yXTiXK9fZrcvlLihgKlT5HrwYUBShbwByI9F?=
 =?us-ascii?Q?ltqKzPQSyZABaDclAuiXPcbhur9tqt8yr9y0NCEeRToAFUQqsCPUb2BtwwiT?=
 =?us-ascii?Q?WKUUxsY1XFaGYxhew7Yk/4InBWkG9pSkza4jktcH2892zDOAxS88G96TteEn?=
 =?us-ascii?Q?qELnZYqyF7CGS0SBVwfL2WTS+E31SKYlaQdj3W5l6hCasz8o3KUWp32ZPdK3?=
 =?us-ascii?Q?fu6ITdF7sVu0G3gOVghd/b6ih4DFrO+JQ+e4Zklsg7odahLkaZzJlJHWMxWp?=
 =?us-ascii?Q?Tb7FALqMXQ1TO6ESS2OukSYEzlxclrWBUkEVaf/KJqolbxrZji4sUhlp/bzi?=
 =?us-ascii?Q?DjkIdn+nw2CDmz8OLJ7/MhK3+HQaKXnkmz/tX3pvI3KRa7MZS/tbhUZYtu2f?=
 =?us-ascii?Q?wc/It992SztORfzwIAvMh0HXzKXgu/tDexH0WUn5NSregOHZa3Tnn5E5KJR7?=
 =?us-ascii?Q?hPRW+HmjbbRgICQ5ZiUJmUHDhgRuE+q18E1GXOhBOONoRgVJ8Gk8HjaeBMS1?=
 =?us-ascii?Q?ewxgK5xeRaDJDbrFbAuKc2q9awW5pEkGFWCosgYyvImXlPHgMVYEdbjutTlF?=
 =?us-ascii?Q?IRtXYqltZJ2PPOVrraqIcZSKYdtEAOtkoVTmhx/Jeaog+jUlKltii3tPto0X?=
 =?us-ascii?Q?CEGXIHCOM6N7zbKnnkCv3fq7fFwb8JRGP+iV3RM3qYdhusWWs77MDPY2KZ8+?=
 =?us-ascii?Q?LBX4bwwgvLp1e3rDoZ1JN9vezUzWzWZkZ+KHxMZVf4CH3YXmoVW5aGMA8F+T?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4c68e5-08b2-4430-75c8-08de1c3d1e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 07:29:55.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvvvUocxhl8aUnWXf/RCznCbbPoe0j8uvCJNrZuEqWKiq5hlCMxWXr7YXnfQgFTqEsiwS0TrRWhMauluX7JnoUSq1eeBl9cmiHZecOjGXkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari
> Sent: Tuesday, November 4, 2025 4:09 PM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> horms@kernel.org; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: clarify VLAN
> add/delete log messages and lower log level
>=20
> The current dev_warn messages for too many VLAN changes are confusing
> and one place incorrectly references "add" instead of "delete" VLANs
> due to copy-paste errors.
>=20
> - Use dev_info instead of dev_warn to lower the log level.
> - Rephrase the message to: "[vvfl|vvfl_v2] Too many VLAN [add|delete]
>   requests; splitting into multiple messages to PF".
>=20
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v1 -> v2
> remove "\n" b/w message
> added vvfl and vvfl_v2 prefix
Why vvfl and vvfl_v2 prefix? For me 'virtchnl:'  'virtchnl v2:'  looks more=
 clear.
Can you explain?

Thank you

...

> --
> 2.50.1


