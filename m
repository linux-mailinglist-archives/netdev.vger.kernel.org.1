Return-Path: <netdev+bounces-289909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHroKz2fDWqC0AUAu9opvQ
	(envelope-from <netdev+bounces-289909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AB58CE68
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7769D300184C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73499376A12;
	Wed, 20 May 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHC+slNX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E62F8E8B
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277226; cv=fail; b=JJCufYER7EWkT3CoMfQq9NBxkwWtm+ip+lmxeGRY/1c5dvQYlYFVezUOY5U+V6s3RkyY6VT7n2jvnoYSnFOIJ1t4z1sfonCsvEhE7pFNISBO+RdU9QROGYrjCbVAqlHPXJ9zn+Up6mhOpggKBu/HSV2JZUQRlOBbmyl/u+1ACfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277226; c=relaxed/simple;
	bh=l1/8ijtObymL/ixKhcVwAX6mrKIyaR1+5mgI48V64F0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLVDZmvvuKA33lEaRwj48ZH4qhMDOKLr7txyg6GNzAq2AnC9I1Ocu6WFvcL7wTwd3Pb+kl39RZADdHp6ilmyhOHH8Jt2dpHZH/ltVnF71kbKqu7vpiRCnhnwOrd/fHiRv/ury+92AbQhENSSRJLq8U7A+zb1p+oRn1VgvO8OT0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHC+slNX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779277225; x=1810813225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l1/8ijtObymL/ixKhcVwAX6mrKIyaR1+5mgI48V64F0=;
  b=EHC+slNX9u+yyXi8zaybQjddd1jMDHnc1a4TE9xqx27+3Og3SNoYZlyk
   dV9nVRLiNyT99tQ0Mfym+cebmgKJnBVfw5rpgD5dhVmZmfI2jGQpOPnJT
   GHML6F+esumtSNsUcTVyJ6G5BxfUrDDG8H3bcB2QpBTi86n+30Q+12sSV
   gQuXdnvBaQpdAShI4g14QCugDYjCGoDWYdHDnj4fMcec/wJCxEIuPR/pd
   DwAZnvsGKceUzdT/2xvbGKUhJFZytTfNs+kyWkq7vhClLAFwnlCPuwdpv
   lzHBNlk+ml891SAOYOf4WHKbAf/v1GU06ZuuT5RmuH16bbKhzRV7D/1YU
   g==;
X-CSE-ConnectionGUID: zuk7YMgaRD6tyBeEGHTt5A==
X-CSE-MsgGUID: DF05YXT6TROeO/+D5yHuhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90749967"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90749967"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:40:24 -0700
X-CSE-ConnectionGUID: bOI+pWSORL2qJeRyDld/gA==
X-CSE-MsgGUID: X6myji5DR5qNlYniFOgNMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="270502763"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:40:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:40:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 04:40:23 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G30+u7StsOYaIWprxpnyGwYzj+B/nXXTg4st4GSmSGHyR77QSejG6gHXirsJyUQocoXNFrpPOgFcD5eZTo1cQMjThDLmezYchJyUB+j2K0vsp1dFZp7EzYXafxwB4Vpj8D87f9QYn5SuaRpMeynRMYyCEvYNxzfNze1o7KLNaUqzcxICEQDVH8UHujxKege6ygjJTdTooxgMDDgWLDYKQTO5nRqKUdQKPFmF/TIJ01h0H47UmPGBZNUte/adEaIWL0Pf44gHB07CzM8XGJdJfXMRR5olCbFro4vgKVcaE6fA3R1ccp/SBUI+UYrRVdV2PhRJSYs+HErBMcbNZCy/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g15OZA4rzDVjiIE+BPkVeoqTOjRS1V9PiBLVeo5jBE=;
 b=UuFUuunk3f51/eUd8zxVDjpsVHFW1TBzKU/RkumFprWNiRuA339YQfErpdExY2TXyQ1WYDlA0Jr3vKBKsebUpWiiMCaMtipuJiEYDHJVGG3SUOk3aJQ9e736/MHqhVj39SFR59z1Wek7JKQzn1/Qc4cTI9lCgKmNQLm5j8B4WLL2Lm/WZyiZ4I+nQmyGDcIs3fi25pxqRFn76shR7/0r5NC40YM/gxjU3x5pYSzjUH5p4vsoN1V9juYid5k9/y3njoe4wfQwpUgxK0DLo8YOPXfXixi0+o5MtiPjUJ52GNmvp4cXnI6c8ZhL1PVT1CZ9N7lX98CYve7YzY3i2ALwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:40:10 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%7]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 11:40:10 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [PATCH iwl-net] ice: suppress DPLL errors during reset recovery
Thread-Topic: [PATCH iwl-net] ice: suppress DPLL errors during reset recovery
Thread-Index: AQHc4SFJB4FU4tyD20+2+bc1yCs3p7YPaiiAgAdsMjA=
Date: Wed, 20 May 2026 11:40:10 +0000
Message-ID: <PH0PR11MB4904E0DE1E258B46A8A1B24B94012@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
 <20260515181111.272950-1-horms@kernel.org>
In-Reply-To: <20260515181111.272950-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|MN2PR11MB4725:EE_
x-ms-office365-filtering-correlation-id: 5f570dac-c04f-42cd-f88a-08deb6648cb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|3023799007|38070700021|4143699003|11063799006|5023799004;
x-microsoft-antispam-message-info: t2TIx+Fv8QZxbWAhzaA4DlKTkkih5vFieBz1zYjlF+hN0NhYBejTxmw+A+MuxhztVb/48xs6EeJjuQTbFBLaYpfHSSch7jhHHpZqAoBURy3j4ijDnHuOHMhXaiyxXd//2UtxTWCiQOEoXahk+akeI+JPM0r/b4DDzChm525up2Wlw4f2SkiLUAj7EsqUJ+yJPaij3IpFB9uzi26nswTsIIC626TdSovzMEoFThUAGwBqexJ3rKoy3dWnNen65AB5IolILqIir19N2zCHRRfPPyvFQ+3ivSPfd5GLLYxx/vfwClKAp+W3YOtdLA1NPaputLPxdvQyrQKGK/Ul74NfjPGKfta2ew8AcU1exF+0ibXf75FxQw9LT+sbGXTqU1AIAorXx7gOQWIxDC9ivR8JfCfAh+0F4T7ETv66dlvNFwpmNocFpFFOJ3DdNuz1iuGVl2wHc1W5AziBqx5eH1AETXB3p8ccoyewsR2RYPS50v8TRpXCOtWR7bhvmpBGk9tCYRDaNumTcSbuk65fw2mPs7xZySTXpPvqocN8JXjbcLC3NzEoKJxGoJWeKBXfKSek+xAgBAdER1jhVpGABNdIXCRXClQsqBr2l1m+G+4L0GPl0WKGDCH24vwLZEqhfSJ0QyE7kY3Oz30EJrJHyxTkf3qE6pmsC3y2AwVOJgMOex55dDjXJFM46itJrtM1HB9VexT9SwX+m+ufjRsggzGtDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(3023799007)(38070700021)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lx9SJYY/T0RH2L/MO416bLCgs6RNcIerdaVn3GHZO6JT/+ffMvaYFolOxVoW?=
 =?us-ascii?Q?lgsQOLJXhaxwbci/TPcWXGB3KtnYQyunpTwFrhYZMfdElj5mq/JePcDmrOJG?=
 =?us-ascii?Q?808hvHtjvD3cjsLddEPfRMPOsy31p/KoZ2fb7Ke3icm4KBLwcWCVbZ9tn1tD?=
 =?us-ascii?Q?Zp0rh2vioy+jwZvVVJCCFEXEaMtbcqpjU96VLu9/zETy6w03KIb2TUkmNNQc?=
 =?us-ascii?Q?5Bv54ynPri2y73KyUcngPFqQ4eYAlsef/6U3TcqJl8xisz0b6GgyJbi8WXA8?=
 =?us-ascii?Q?bg2r6S17JUJ70hxeG8hjbXIcdje6gtVzvgYhP45yX2pGTFZ//i3rorKY4w7X?=
 =?us-ascii?Q?ZJEaXQBYc9u8m2xmcyONI3Z8X9jAfOaSFItSuI+m3Etj2kmMBkPDtSPHGc6f?=
 =?us-ascii?Q?ares75M3gr0ighoPG5laBnHDYBGE6vEGciXpApduPfe/CUwG/iZnufO83A29?=
 =?us-ascii?Q?02H1H0gE9GOR8JCVWOP6IURN9Rr8xMbb55NLxnUw4WniWxnoesAGKxOiqZol?=
 =?us-ascii?Q?r7GldQMd9EKLaC0qf2nGUEXrtpbjcvcuWujNo1b5ljGknZj9kPStqSpqwqeL?=
 =?us-ascii?Q?58nTfWOHI2pRty7KrM4suPNfZRkkXNOtefb+guG2znY/FzjK6SMTLbB6AgyL?=
 =?us-ascii?Q?fKyzrh/D6z6QcxVmft4PT/vao1M7vh6G9i8p10DeaSwXe7/6rSVn+yHRFk8G?=
 =?us-ascii?Q?DfC2JeN7BDPkBHUrF1hqCYAK2lJBINyDBReymVE17wsZln43P8QrypkQf7jA?=
 =?us-ascii?Q?YI1yKrhxDOt1sEwNvzmn68TMDaCLB0jmaN0+JefSWLcA0NOoBqOR3Qvp52QS?=
 =?us-ascii?Q?C9X//HbQrvOaafdcjfaYZDNgPzuO51OK3f52YwHvdIJebvTltfmVvrE7Lc81?=
 =?us-ascii?Q?vGCovWyBRM3iQqC5i16qCnr8JAp1Y+RuSszfgDjbqGTryxzDJGjyc9vzIF65?=
 =?us-ascii?Q?u/uq/B7/yg9Z1z6TrQcF5Zds0yiw1QbDLXGwkrofZs9LyO8Kz96wFd+t/Idc?=
 =?us-ascii?Q?D25mYxlyXELryLQzKVQtSCcHbeuFABLPgo2MPR+5yT1xKHq3imj66VuJRhz3?=
 =?us-ascii?Q?e6RL+Zt08FILWpFk6yzopX0tjWEA5h29Ul61yZGjp51WZW0LICGmrvHGAqSl?=
 =?us-ascii?Q?3ERqPH6SIW7fkcY+ES3aswtk1w88uybWiwOYKHuSWfI5tSXVXgsowxkJh5hO?=
 =?us-ascii?Q?CRZMgNJ6SyIYgjImml0NWjkw3apCfTabZOoPwLpevYmH/HP0SfM0NhrrCl/k?=
 =?us-ascii?Q?n22FUiBoH1inPb21z/+fobsbAm3rlCbo+bs3+98pMpwqgM8LRdILvHKblOLi?=
 =?us-ascii?Q?VxWAFboxwehCRGqN/V47OhXq1ir8D/jFdgHVxcxSIuinaJo1EDYqwsJyzaVt?=
 =?us-ascii?Q?pzBaSe3qecN9aqP8BLV9a1PwBr6plYn/Thw+OKe8siggOSljvTZQ+yrSxFGV?=
 =?us-ascii?Q?XlIVH2jZ2kmb/SWdg1apUwXs+9uqL2X/kDWfumD8iLX/o7yPf16/DyPoQwSE?=
 =?us-ascii?Q?jSJSAr6jhkKGS+BHm+N1+u0yNySwwTJ/py4IK4LW+9CARQnZdLfI6PEUMV5T?=
 =?us-ascii?Q?7K9tFf7+TtgVSPBnDwDYMbB7EE3L9KcH893iWPnA0pHc7IxZ6nJM03RVmMHC?=
 =?us-ascii?Q?PMP85LcNfg0YKvxU3eWbbcDUoL9X3W9GyyAHByg03K3Uy3PqzvuUVOHSIo+1?=
 =?us-ascii?Q?WmGapUABpx5zXKMRfBI0vrn4ts8lkbaF5m475C1CiLdeSgMde9zZ9+1UpONw?=
 =?us-ascii?Q?+KXfUNVUWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i8sLxB1r2XTL+fR72xQkmbLQ0vUVm5/4uxROcvQPjFwB4DiFN1HLaTQgks5FlnZoTd94HvZwciCmbhB5yAZVtIJG5eC3PyHxPbKf6/xY7drzcwusSuB8cxLV5vJuVuqUeuKPo0bkeXpk+aObGopDhUOUiqlUlxb7Wz9nR6FhOQkhOEUEhtxxF72s3HhxfUDWYNcAbVDE/2BvdmO33hMHJYso1aviuRmZUdNlJjm3LpI7OYYaL6YDWNfDD3mpztkNbDqQVVqPdcCyFy1v6s+AxXcjcsBrggKTn9+ir2zY8/l5ZdjDAjuKZkrfBzT4PFkJEhjBORpw8E47QNqqWMojNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f570dac-c04f-42cd-f88a-08deb6648cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 11:40:10.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUS+WBEGbB3T/uLwX9x7EXC8/ic8m6d5CCQjMcHtJ4W73vqBlFb/RdV6HcaFYfOhRYOr2xPbs53nur9BUfAKNtkVyuT9JWI6dUdpkRT+VGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,osuosl.org:email,intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CB3AB58CE68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr




> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, May 15, 2026 8:11 PM
> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Cc: 'Simon Horman' <horms@kernel.org>; intel-wired-lan@lists.osuosl.org; =
netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>;
> Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Subject: Re: [PATCH iwl-net] ice: suppress DPLL errors during reset recov=
ery
>=20
> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ice: suppress DPLL errors during reset recovery
>=20
> This commit suppresses DPLL error logging and counter increments when the=
 admin
> queue returns EBUSY. The intent is to avoid unnecessary warnings and prev=
ent
> the DPLL periodic worker from being disabled during reset recovery.
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/et=
hernet/intel/ice/ice_dpll.c
> > index 0704e92ab0430..78b8836b534b3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> > @@ -784,7 +784,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct=
 ice_dpll_pin *pin,
> >  				   ret,
> >  				   libie_aq_str(pf->hw.adminq.sq_last_status),
> >  				   pin_type_name[pin_type], pin->idx);
> > -	else
> > +	else if (pf->hw.adminq.sq_last_status !=3D LIBIE_AQ_RC_EBUSY)
>=20

Hi, thank you for review!

> Could this check of sq_last_status race with other admin queue commands?
>=20
> The sq_last_status field seems to be global state that is modified by any
> admin queue command. If this is checked outside of the admin queue lock,
> could another thread (like an ethtool operation) issue an admin queue
> command and overwrite sq_last_status before this check runs?
>=20
> If it gets overwritten to LIBIE_AQ_RC_OK, this would falsely evaluate as =
not
> EBUSY and log the error anyway, incrementing the error counter.

The check happens immediately after the AQ call that set it.
In practice, the window for another thread to issue an AQ command between t=
he failure and the check is very small,=20
and even if it happens, the worst case has no functional impact
>=20
> [ ... ]
>=20
> > @@ -2955,7 +2957,9 @@ static void ice_dpll_periodic_work(struct kthread=
_work *work)
> >  	    d->periodic_counter % dp->phase_offset_monitor_period =3D=3D 0)
> >  		ret =3D ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);
>=20
> Does the reset recovery suppression also need to be applied inside
> ice_dpll_pps_update_phase_offsets()?
>=20

I agree, will send next version.

> If ice_aq_get_cgu_input_pin_measure() fails with EBUSY during reset recov=
ery,
> it looks like ice_dpll_pps_update_phase_offsets() only checks for
> LIBIE_AQ_RC_EAGAIN before logging an error, which might still spam the lo=
g
> with EBUSY errors.
>=20
> >  	if (ret) {
> > -		d->cgu_state_acq_err_num++;
> > +		/* EBUSY is expected during reset recovery */
> > +		if (pf->hw.adminq.sq_last_status !=3D LIBIE_AQ_RC_EBUSY)
> > +			d->cgu_state_acq_err_num++;
> >  		/* stop rescheduling this worker */
> >  		if (d->cgu_state_acq_err_num >
> >  		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {
>=20
> By skipping the increment of the error counter on EBUSY, will this create=
 an
> unbounded polling loop?
>=20
> Looking at the end of ice_dpll_periodic_work():
>=20
> resched:
>     kthread_queue_delayed_work(d->kworker, &d->work,
>                                ret ? msecs_to_jiffies(10) :
>                                msecs_to_jiffies(500));
>=20
> If the firmware gets wedged and persistently returns EBUSY, the error
> threshold will never be reached, and the worker will continue to hammer t=
he
> admin queue every 10ms forever. Is it expected to poll this frequently
> without a backoff mechanism or an upper bound?

Line 2950: if (ice_is_reset_in_progress(pf->state)) goto resched; - during =
reset, no AQ operations are attempted, it just reschedules

EBUSY usually occurs only in the brief window after reset flag clears but b=
efore AQ is fully ready

If FW is truly wedged, there are bigger problems, that should be detected b=
y other mechanisms.

Thanks again for review

