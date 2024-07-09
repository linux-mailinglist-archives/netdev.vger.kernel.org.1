Return-Path: <netdev+bounces-110130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA492B117
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9101C21607
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2122513AA4D;
	Tue,  9 Jul 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Riq/T39p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED10482E2
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510257; cv=fail; b=ALvazMz7Z83Lz8ip7EoEEfce4i3pKjDsWm3rRQZI9+KVWRxHXUjqm6bcJVSY/y5RCHE5X8TdOkFBJzXE8r3PsCSBFv1jMZRyXlLUd7SajghT7y8BA9k8rFIaDKXm/R1nZ2qZCHN7J/ew3+CluQw5gt/JvtK58d0JVf5LYhXES+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510257; c=relaxed/simple;
	bh=vwYj0NwM6han2SZel2RtTQbLH5M3+dMhpCAfn+rLAXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iP4JG4fehQVLaDycZQtA3ht3K9M9R79R9ZXbKEA+OJYgnwehKhOGX63u4Vg6rbJrkpmbFoD9OSLxbXVGsbTNlgmXmiOO6zztI0l8jO6Ge/Mm3dCtyO74LtHwS++Yodwl7qwToqk8f1QPElPdjZ7YzKe/rkycBSbCla9x0DtaUWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Riq/T39p; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720510255; x=1752046255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vwYj0NwM6han2SZel2RtTQbLH5M3+dMhpCAfn+rLAXo=;
  b=Riq/T39p1Sp3DEaOhTI/emRTnQ+6rx2SYIjahX9v/TOGKrprJA81qoB5
   riynU7JyMKwwGML5k3KLZZ2a/UGCyRUMk5iThiQMQ7bYtleLv9OPl9rKj
   zn7MxkTJ1iRhRQHgQmuN2wycoi0HDUNewDLFEDJDwkM9pow4xIoGhLGB0
   nldN9UVrpJVFTgN+SsvtJZJAOtOEfRn2MwoDASw41A2hPjBxE/SiVJMLI
   Q68wcUtHcjlJ3r8cdGT5vfKuSg+M0G0aXe+07okHEl/MezmlyIA6SKRk9
   I3I877zKzjtFf5k06CqvzGfSv8TKidrf3aUpX9pQo2X9fzS5y15Xw3yMm
   g==;
X-CSE-ConnectionGUID: vKSUnLw0Tlemj3F3LaKk2w==
X-CSE-MsgGUID: pvZmnnKMSauOymuli64y9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="20646507"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="20646507"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:30:55 -0700
X-CSE-ConnectionGUID: xBud9/dGQZ++sjG5FA4eGA==
X-CSE-MsgGUID: I0rAyEGhS1SMreNx2ryLhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47548327"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:30:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:30:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:30:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH5+P5tHs5kbA3neKy19XvosWjsSw2qQKH8E0iLxDgWqhAh5YHYf7pXBGt3mHMtvTXl+GhIwUEpbKJJ8EcSkWYJqFBZcOzlRgtqTaQaCoGsWWlEBDDmVUdtRDuwWbZYiV/Spci7Y9m+oK1sUZoHLw+YWo7fGiNOycnhrEV5Z5a1Eg0dd5XjeHqrdQFRnxaWWrvasykK+Q+Gnp9YosOUbGXzXF5BXTJ2k838Y7eCTvTSDAib4Hw5rtKY2ZQM5Xl4GMrEbIUiznBbbk5GiRwSUNRMZKGDxIc/m8hVgnkat37/O3EOQlV/1U9Nfli+AO4wSZXX/JG1QRo5iJhkTtOgKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhPcNcXqxKmHYOuhAWjTebbuCj0qprWJwRWaqHtRgMI=;
 b=fjHkgMglomkAvBHhD9t9XjxThfircQxQpzHCbtoCl3EM5phSgMo0DkZr2DWucLUmDifjZSMnjtWTXrEr0xN24a2zq1YiZJ4kPnCuz9O7Jo0UAANF4RxidIw39k+eE7SuAk81IbYQYq+42q/vSusOY7qLM5sopPd1kz39/riJpuMbVxGrDD4YmFbUGFNOZw/kEs4e0siNSVGGxtVWRZXQr1OAN7iWoVrjzgtfc3ScL5P7ll0tZ/BiH6DszNYBBS97zuIImfvy3QQaSxAuFdiMewqqtfa/4M//txZGIQr9gfcI+k1Kkzar/JEoiJlBHbe0ScPLNlYIUvGsLFz7R/Xsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 07:30:47 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:30:47 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 2/7] ice: Remove reading all
 recipes before adding a new one
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 2/7] ice: Remove reading
 all recipes before adding a new one
Thread-Index: AQHayKIVupxgMIHoV0eSwJo19rEgTbHuEn3Q
Date: Tue, 9 Jul 2024 07:30:46 +0000
Message-ID: <PH0PR11MB5013D762A7120548FAE9C0DB96DB2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
 <20240627145547.32621-3-marcin.szycik@linux.intel.com>
In-Reply-To: <20240627145547.32621-3-marcin.szycik@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 3094be5c-8c6d-412e-33aa-08dc9fe90cc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YdT+mE2heOQMxQ9W+oeuBAzAug+zv5iu3lsUoakl2fgJqC/cuCovsqL3Advx?=
 =?us-ascii?Q?nioGXrHvknzbT6Qmo8e9E4VsBS95G2oIkcbS22RfBP5gbR+r8CBN80h42heI?=
 =?us-ascii?Q?j7c7PBXc89o4fqu1Xf9z9cJf/aaiVPbTjza2WBz12j891GCN3ljoyhKjqXTi?=
 =?us-ascii?Q?kpu0PnnTyMhjXXtGm8zT2MlguBvH9zHC8XIDwIQXsHYZQP5Li1azXc5IF0y2?=
 =?us-ascii?Q?cL8YACebeZ0tsPcjINhhjRxO0UEm4NTo5YwGMpZWBvx2FZsIL1Ea6T7lIVuW?=
 =?us-ascii?Q?lqTkBobnSw4x/KLZYi/euIU1AAMEBUswsiksJiFbjOrUScLBNk42cf4rD7Jb?=
 =?us-ascii?Q?UXi1orjhiUlc6QEdgkXmEawS8q+ThcXtNv2w4WIYbc7VoXkMuHas+j5ezrqF?=
 =?us-ascii?Q?Stg9Nfn2koK8bmj0T1OeapLK9lhUMFe0dT+SSK1ohQQ0fslQMqyB232fNC4E?=
 =?us-ascii?Q?7zjKqZSE/435k2rP6OWUrNfwwS3zFlB+e8BMVbuoWPBQq18DNosbo9UA4P8W?=
 =?us-ascii?Q?pEuq6gah2M5DCSG7LhqFrV9qN2l84fsZwAJPUF6xoLuGFZJr+6nLi4gp1mq/?=
 =?us-ascii?Q?3sMoMK2esntFtokRlTPAP86W4XtJclJNHpwNXU2Ob2bhlSeVu5yJoqAJ8wLv?=
 =?us-ascii?Q?XadlRXLQ/3EPOpJhBDii5K9JHd33R02LzrQTQQqmPYep3HIP2862q3WjzGkZ?=
 =?us-ascii?Q?jyPFiB9DGoAx8LBjz6Binu+ojeOgW5TrDHA74t8XLFeeJHVJJ4R3sE3XQ2xY?=
 =?us-ascii?Q?xiusaCxCf5WEQRNpiSfIJy3FZId3sq/7VBu02cVCEZRoERNBav1h/EIRjQ3T?=
 =?us-ascii?Q?oc778Dl+WIEZTcoSEx0TXOkEDGI2kPOw7IxiEA2s0x9JEK5EF7PHOLqy0Afn?=
 =?us-ascii?Q?hvRnXssm37jLLNWHQxlgo/FttDZbnP1VJpEardTUvUC8HXlR0TtLWCy+Zq2+?=
 =?us-ascii?Q?vDykR66NaJ/6t4wDLTn7OMBkAbBGqv4XumlMLN5LGK2k9rpjUb+aHSwH0ZpR?=
 =?us-ascii?Q?iDztUOkf/9s4I3RbAyIMksoxdi3zYysY3NGbktfNSyNdHI2MTt2HVIkLCzk1?=
 =?us-ascii?Q?++VsAMQFMmBP29QMVViIw6y1BegZ+5rZOumCHG+6MGL2RfFsnVZIKVJK8qz3?=
 =?us-ascii?Q?3G7ZAiDleq6xietckgd3hey2e0AIL41DK2wdYYuo2rbYAveNc7ZkLeWLb2mv?=
 =?us-ascii?Q?cOXlFg2OKXzy2niIlfxT5MH7Tc6xAt22dvXcwBcw1mrZEnTbRtgvS4sQCB+4?=
 =?us-ascii?Q?gaVydaspCvkI6UwExMgSe7kNozg0qn5luYSLcfd/+ojrD0+lqgID3bML/csd?=
 =?us-ascii?Q?du29kbwgy7T41Yn4h6/ZEMwEAx9B+58+6RCW44rh4QiR0O4B1wiMB7Ftj+RC?=
 =?us-ascii?Q?fy6U8j3oslUgs884gmg/xcCj3lVugbqgy1+/slNiKWsUxXO+Yg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NNtw3PhsmBQwOTX4ZYQxpOvVlyvXy/XJLm8Xsan6DZm4IZbOmPdpBhCELOM0?=
 =?us-ascii?Q?Puso+XRKNw0dvtAMgnM7cze9j8+bv7SNXYgUGhxjUE3xDzqNkrFutH+lmrFy?=
 =?us-ascii?Q?l6sSIkZB7j/i+h38b01S72GutIZcLL9Ndym54/2I4AaMMrVdRyLB1HroBucI?=
 =?us-ascii?Q?sqseaXjzpXZ23TamXOv2bUXKkJolxcWyxzaKGNujY8AQbyclKa2UevGr2tOE?=
 =?us-ascii?Q?s1/sowtOt/IeBCQQg/WplUHcn0wBcA//08+wl+yEJpWmQ76wqS6dOHKvbfDJ?=
 =?us-ascii?Q?vshCfa1nPE5iF3rhbzCGVGVntYXHzaWLTpbq8kAJax5TUeEUpKb9EgbAKuRG?=
 =?us-ascii?Q?La5DZurhavTz2/I6QN9MsUBjAMQUVXuaORSC/cSTly5MXa7huNGPnxtLa7Yo?=
 =?us-ascii?Q?SmpracvnCTh9TFakQ7QM38fSSA+Qj5cTOpgB0tTQ3KoY+jf1g4mh9GgnMx49?=
 =?us-ascii?Q?5GIzOJfsvMyyB/5sY2m7EWgGnR1NHmqpF7uH7IDvRvBDoS65QvdXtNHpbdO2?=
 =?us-ascii?Q?hJK5JiqX3YoxVsd27+KT3ta2FxpkiUEpn+sNuIcQ4VcsT9xSHknkq6B+5SgX?=
 =?us-ascii?Q?rhQAQecfhM/I0oH7LEwIYc36Y+6LxI56XCK0566N4X+He+XLSuoIJexFGJo0?=
 =?us-ascii?Q?r+uiH8TJwY9FvJowdEkpbf+JUdiBZicTLYfkVr3QawrVILq8Lrj+fH22+w18?=
 =?us-ascii?Q?QTQvnwNZMRXllXKBVG7OYkT+N0qER4TLm9LrDt4H9YvtgSUeD0H0qy/46VyO?=
 =?us-ascii?Q?vmZKku3bBEqIU9wK0dQZmIV6b5uYU3ua5szrHB8uAk0r5bBRuqTS3C6gDC9R?=
 =?us-ascii?Q?fOqfYVeMiKN+e2l3DOnujPoanGhTbsAb3dE6i29fd+BZFs1KavPvi0IZHWo+?=
 =?us-ascii?Q?ivmFI1WVOaHQT+jr4yDcQ1NfagKQVTXiNPkD00Nqwrob3WOu2GkFCdh6r0Px?=
 =?us-ascii?Q?PuyeirniHcpunYqhvzzu2sw1t4ppg5cxldkJEuSmlh6zxOtsqiI9zbp0l+7r?=
 =?us-ascii?Q?QaiAeFn+KBY9rrcdL0mbNXJT6g0govBvqUz3NnaQXM8bkQc+XaxL5sUZK6az?=
 =?us-ascii?Q?KzuAMFDXwtvqmhNwzsxblrThWkr0pIJx+8618eh7+CHWy6vvrT/OuvnGiwcW?=
 =?us-ascii?Q?7oHaoEc8PtI2atpbFjlUiBPcCbVXuSEXzMywuCyNgmaOK/+i/vciPt7SzqnZ?=
 =?us-ascii?Q?sZcQ36YHMyYyA/ro3xUlUrn/QMVlDcElB1SD79mtbEpf9Q7ffqxJEMIhssMD?=
 =?us-ascii?Q?h53R4BaAzrPdpzHzQtfrjNKNcPugpKFxqCQYdbp6szNMszwoiurSuWatxPZ5?=
 =?us-ascii?Q?bOQNRZgQdbDE7n6C8+r069FvyD+Vnnd9rx0rcCuOHFpAegor4wOpL/TNLBO5?=
 =?us-ascii?Q?fZ26ooFFfzy8n/diNdbn3CIQSMr62P3UtNstaB05c2D6sdnMCB+lWpLrNBAN?=
 =?us-ascii?Q?QBngsUBbYTaep5ELOBBQPjaRfozDJM9Y21JBMq9vPgRbHPYMlkSi3q9CfAzZ?=
 =?us-ascii?Q?3fH9SFklXn9uHXSq+X8wiec1YJf8qTKOeIjuPrwyZh4qbyBn+xXUAbeorKhB?=
 =?us-ascii?Q?iBtyijo/zKTFv7DhPUiL9lM4LoW4ZQ5gg4wHTwlZDZ4bZkCBm4umhYGKukGo?=
 =?us-ascii?Q?Vg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3094be5c-8c6d-412e-33aa-08dc9fe90cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 07:30:46.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWFkU+ZSbgfha+GpmW1LMU3HThl2A6vHQzvJz3Ghb3nYOyJQ2PGhJ3e2fv2nOY0r7toyFj91BjESl8Zu2ETPj8jhyc5ZPB1ZFzESPAymY/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Marcin Szycik
> Sent: Thursday, June 27, 2024 8:26 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; michal.swiatkowski@linux.intel.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 2/7] ice: Remove reading al=
l
> recipes before adding a new one
>=20
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> The content of the first read recipe is used as a template when adding a
> recipe. It isn't needed - only prune index is directly set from there. Se=
t it in
> the code instead. Also, now there's no need to set rid and lookup indexes=
 to
> 0, as the whole recipe buffer is initialized to 0.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 29 ++-------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

