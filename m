Return-Path: <netdev+bounces-168080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B127A3D48E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861E3189CF6F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00DD1EA7ED;
	Thu, 20 Feb 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhrUeels"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343F1E1C36
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043348; cv=fail; b=MaZRBJS9uukiEpSmSoM3tIhKKoc2IDXpMSOMu7am4WCZ2emEEp9A/cK2NMbJO39HXuSPeufhGV5/hBhLTrQFmNSJBa7S5MefPGA8eLOzbKnJL5A1VmkbezSjxhn5+R8MKPEdU0r7sEWe3Aj7G2TlFBmBGJYDR8m/Tn4bTYGN+tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043348; c=relaxed/simple;
	bh=i8aY9DeefQ26DxZdyjqgiVtp2juUapcwrvzMxlwtiTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyLYmBWYYIFa9r6+99Hn3U7egAqqXbufe5qRwGyDzwZeBpRm2N0abf0BmwNHRpNVTptMLLDz/cv/r6EpcgI5X9h9xdfiBKM0NZWWyCiSJrbJxGYU1NOeeyCA4NcbgG2hGEsXZgv1Q8/Gcm65rDYaGlQPOVp4vi8Pw3qjPXz5Wkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhrUeels; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740043347; x=1771579347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i8aY9DeefQ26DxZdyjqgiVtp2juUapcwrvzMxlwtiTI=;
  b=NhrUeelsGvzDWThbcwzKsld7EDIyrt2+klVRW5T93C3AKyVax++W7awz
   uRWzebDr86vY/urY0N4R/ZE+H/5zvaiWxo38FIuPq+c9BNliHCFNlJ1j7
   AG7Y73VjYVYrdOHUYZzvGhQFksAtWeZ1mOLSUzz7zKgF/kP47At9LZ4kj
   v2gsXxzk6hqqGrXhiQxyPvSICROj4/WAaaVyg7gtna4QtagiLMYPizJqL
   sdgw4HHzWPqeBnXnzZBJtC9RVjB1rDjV8oKt3Sp8kGTuiTdv5/alNO+cJ
   kMmXzf7FHGF2uhQYNbsD6VGr2U+UQ3TCK6FW5Q6/naQUuygbj8hA3/1iR
   g==;
X-CSE-ConnectionGUID: z8F0sdB8QU6qxkvRBfdnEw==
X-CSE-MsgGUID: F1imyBhBS0O5YT6bfraTOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="28408660"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="28408660"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:22:26 -0800
X-CSE-ConnectionGUID: eA3aTy3vR5meHH9DGO53qg==
X-CSE-MsgGUID: dmQuEl2DT5CaJjP0wPdTzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="115177106"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:22:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 01:22:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 01:22:18 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 01:22:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ka0fOzZ/r74OAACIsT1AL4v8i83m/AcvdxbgKYsyGNpWel327XOGL2P0gFzp087h0PgOuLN89yQMHF2y7KmD6E4QgmWL2OWpciRB2GoTpbSKgxAxRfYdSyx+B/aQZ8YjBTJDwKtbuz4rO5F29+ZgAEv76BLbBzVHk9KwYzNx59vE4h2dQYqzmq/GmpxpsO3BotBMchJDHEO3HuNWb2p50AxYelcf3vcbU4+K+qGyHR7c2B51U62Hs4UbkKMDLwiOUyUJY5koOepfqEauSMR4cQsfk1SN9jwETIM/h+l735iRsC7WfaXk3XcywA/bGmymFaTPT1FHvmR8Pydo2u3ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8aY9DeefQ26DxZdyjqgiVtp2juUapcwrvzMxlwtiTI=;
 b=uT7vpa0i1llkNglOkr6XSFnDeXl+MIWp08HA/Z1oaBTkounR4IVPFhsc05/gjraHLSgnDUUD4y1ohvAVvqgS/HCvJTB4Y8d4BJStRaRirqExVnvxACdW5gwASk7cWZWGhVqg3VCACljaHBIfGt8eplf6THQezLgfxIqNeKBf9mgdW9TktsN6mv8N7oioSZUFSaDaE3fn8vUVDtV3UxCe+jhQNakxCfWqwRNoRjWuNNXekhjevhHAJCGt2HnBFshIcdtIGsG5PVlXYBWS4D6JXomLwJiiebLe5mcJkb0kC/3bhm2ymQQF5HUPZGOhJjwbk4CaxQiYEZjU0Ks0pVUU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 09:22:01 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%4]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 09:22:01 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix circular lock
 dependency with netdev_lock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix circular lock
 dependency with netdev_lock
Thread-Index: AQHbfnfIWfF9OVhVx0SWRsXAltdZ77NHM5EAgAjBN4A=
Date: Thu, 20 Feb 2025 09:22:01 +0000
Message-ID: <SJ0PR11MB58659496CF5E4D27CAB5D46D8FC42@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20250213-jk-iavf-abba-lock-crash-v2-1-033d7bf298f8@intel.com>
 <20250214114008.4975ccb4@kernel.org>
In-Reply-To: <20250214114008.4975ccb4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS7PR11MB6271:EE_
x-ms-office365-filtering-correlation-id: 1325d8c1-f594-4be3-6897-08dd51900859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4oAIITd66faga3aO9hsKk5DqI7fwiWKM+5nMEkTLYPUMxbvsTTmBrovqC4CB?=
 =?us-ascii?Q?UMUrCXaqW9/m1YUD5rgl0UaTK1RY25OA3O8ULWlgAUdj+vN2hXzismIRB4j/?=
 =?us-ascii?Q?/eZbbUHbapj8JkZx0TMlbe2qXfMnn7wCylt1K3lae+0ot5j2WZx2Twcvhnb3?=
 =?us-ascii?Q?u3+dvwJ7/S12dOF3FLiVrB4b5DA7QrgYk66/CHU+SNwiJ359ambwSmyt1ibZ?=
 =?us-ascii?Q?gHnTIBxwlkCsOBCYT8Cq+KtejkQHbRn99IgwQLW6lzTsTdEL0tbTZKeYIL1h?=
 =?us-ascii?Q?wZA0jGFMPQRT8t9c+gNBZfyf3+LODc5YNZpvHQsX7mllRUY5P634Nz5fyKkx?=
 =?us-ascii?Q?Lkm3RxP1V3LBfp6eGP8/7qlWqpQHC90hUAx3qvIXbjX0feTBRZOdFvxSGoZZ?=
 =?us-ascii?Q?qa/ZHFXxQ28A5byYjBhCGn+j6P83HbV9b7u9lIxEfxf5n6i9Tjr2d7a0037r?=
 =?us-ascii?Q?1Dn3MnFH9m5ikcw0cRNLEMGRUmWA+U6UdZ4eiQqH+VRPXWVkzm7tK9bBz3+V?=
 =?us-ascii?Q?uxE2tiUFf2WyNoD1CwlGP1aFuW7RMjx5+FVD4WqRo1E+WmnxIag7HNFfC8aR?=
 =?us-ascii?Q?duHZFYZV5o77C8F78jeFZZQmmW8hNc8mN5tVALuANs/L0SMTivKbhckj9yvT?=
 =?us-ascii?Q?70Vv0PEe9zpqusEfaG27u7v8uSUX0xMTt3Dced5+d8f/wHTIF5oyKe+GoiEV?=
 =?us-ascii?Q?b3Vu9t1rsw6MT7z5Z/4NaJJyFGTbq2GZH8Im/9mKUqp34AlsC95QJ0WTHsia?=
 =?us-ascii?Q?fk1x31RfyDQPgx88eH1poMaTTOoYcbS28Gg0hdeMYW6+VbZ2xDOPxlySlPJ6?=
 =?us-ascii?Q?Sz9ObZQX5j9r1Ch60rh0lNbgrNQ2gcNNI+YbnhgIxDzDKavzhTwdZk5zE9RL?=
 =?us-ascii?Q?QRd1NwZvZ46oFZCG1XnFdhbyhuahziRM8BpKSI1A+7afsji6MM0KkQV8U7HW?=
 =?us-ascii?Q?EjldNRrNyTENh4BXghP34tonm3HMT6PTKL/kC8kOXIFfAc32nTVee6w4YKyg?=
 =?us-ascii?Q?m9lJLVMotmNIuF0+0pbsA+S+DvC+YCrKRtrQzSrIn2RG+qNxz3HHc84V4X2r?=
 =?us-ascii?Q?Dhy4fyvZuGxxR+Xl541TJjXPtVnqns6XPWL46zJUOjzypP9gvkkbVa5IHbAd?=
 =?us-ascii?Q?xSPZIar1er8SpH023Yqjrp85iikgz85qgk6ZRsAc6b4j9YAj1aaITHN16h27?=
 =?us-ascii?Q?rvXbpnMfKbPnHmqUwrjyPSz+tKcgnp28LNBUBnFM5MlaGPV361t+X+hMPLf8?=
 =?us-ascii?Q?wuiTF1Ji38wl0ByXvMyljTezoQHkxC8yr/Hl3dKfDGl2DxxYPbrVYIVBzej2?=
 =?us-ascii?Q?FDw1WujU+4pZdc5par34ZboB8vaQHwEHqpEg8mJJxwd7DfJ8vdsfnAHdxi/B?=
 =?us-ascii?Q?3UfG+NU/sNjlkm06efFQGZuLVsDHxxQMQE5Mm3dD6CpVSgqEFFQKHqe2/bOI?=
 =?us-ascii?Q?PWAZd6VU7cd8OEXXO72DUq+GvZ/zEC0h?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QBidQVzSNJ0ofGkIaVT92/lsywPfBuf2homBQAyqgnOdxL4zv9ZcI+uLizuh?=
 =?us-ascii?Q?N3SL9qFji5akBxmmZL99DJfmgFZrOIj95UrauLnB68T69vzwWdYSefZsSwbi?=
 =?us-ascii?Q?8eo0ArfQFUlnXz7PdJOD3aYCxVvp7oyOrQnBmvHV8UcmA1oHNBwr03t0GK9y?=
 =?us-ascii?Q?8yjvvqIWkOytJY1ax5Uov+8doy+afhU4rEmn3z9u/y/tKmieXV8I0ZXSCfyy?=
 =?us-ascii?Q?Kbww7sRdM1FXdUM5rfqUtpKsy4VuAp0SyTHb5jcHEZYPZkEQQ/NztuKABmPk?=
 =?us-ascii?Q?EloWiPONq0jMQdDjd+HGJVyKavr6icIloJMvSrOE+7CmbgrEmpRl5ywKuS7G?=
 =?us-ascii?Q?e0WLt5LC5uiPV/BmsaTTJKzZwTlqwA440NUtG5JOi952C99P9q2sTZuxOqj6?=
 =?us-ascii?Q?7/Y1bkBSxOpPAF+8tiURnr0st/bANgJJW8RYG57QVI6d/w+b6NVnZNXQ28xk?=
 =?us-ascii?Q?owHox3ph6IhydBbxGDP6ZH//rrA4Sld4GduN87+fZtLY06TuQJXuTABIuOGq?=
 =?us-ascii?Q?40aUGTu0ZV0gJjuiIoOizj2JQRvCc17H3V9JGKkG/eDpHthLrOPnBud6s5HE?=
 =?us-ascii?Q?KDfApCdIdzwYX5ImnuEMN3mpDQc4LSh8vYICNnCq7WRyPNiJW/PoTOj78iY4?=
 =?us-ascii?Q?DrcoIwPzkNFWYfVmkL1i7bGYVtdTIRWcGdcKcQ/G5ozl0ihZzcyzsVbMhXY4?=
 =?us-ascii?Q?FW/K93+9P8/ZXGQDnLbOSUpI0Zse5AMgN0gmnTJetp3Rv1si09FuKoTZP9yB?=
 =?us-ascii?Q?yIGuoxch3yppj3f7vGSMzHHZPjjSmvj8qGu1bC9AGroAq3rd574Nnt9pQwW1?=
 =?us-ascii?Q?ETPberhbIJ05al16dRRcjz6Rq3bQVbXyz2Y9HNO0iMJHNBuagH5cR/boZ96n?=
 =?us-ascii?Q?268A7tGz12GLRUXOoSaV6C2UtJZBWdmHrHjNUKGwcJYSZHDgO8DaFKt/Yrvh?=
 =?us-ascii?Q?WTGX8TCLTZWjwBuHVIU/eh7UIXHx5xrvUq9kRRQOcmFogz0V+Mu4Yz8smpu+?=
 =?us-ascii?Q?ZnJ+nHxp/f+UHAxQxT5V7Bha82YR9e9Te9AKbgob0h/B2gNYW3Xo5XSJWwce?=
 =?us-ascii?Q?Y7Ycmgs3ceDlYhHy/piK1e3eMBFjN8A3ODMa4aBLnIMI9S3Anwtf4RsXZTkS?=
 =?us-ascii?Q?SiZ5rM18VcBQv6+2vXQWav2Sa8eJ9CkLw02DXqEUFJ7yiY4h4Bwr1iaz9LAQ?=
 =?us-ascii?Q?nAg2DItQWXIUlt0h3WQYTiEq1RgxVkuJpGbE4hf4t+LSG2VaJVMpuhoKNqTY?=
 =?us-ascii?Q?xoQ5+Stfwilr0hM5sEnmtRuYyREzZrHinoACyNleqRpF5iv9SKFbKan49om8?=
 =?us-ascii?Q?ipguefxG7iczIF7DXipalAXknfRP/Ev5iQ8gPkCLFgjuT83FSZhdUL2Y2xPO?=
 =?us-ascii?Q?zYhmpVCAkfo+Su91D+M3WPW9TB/VQLGmbdyCI2uqP2VFeO77y02jbQx9voFn?=
 =?us-ascii?Q?6FstN74bOL0yxcmpa+D4pdYRbWdD1HthcVaBz8gMgQo1dSXgThywzp5HnQJc?=
 =?us-ascii?Q?DJCnW9gvQtk4U3oayBdfrLT83FcfyTjmXuyztYvHjNL9YSsMJisxTYyKnlwt?=
 =?us-ascii?Q?HdB1fVyPdg939q2ljkCjvYJbxuRZ0ca7U134WhehD+8OprZm17wK92+4fHAB?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1325d8c1-f594-4be3-6897-08dd51900859
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 09:22:01.3264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NRdPP0tONZ5PeuIAHMrJvU6Cbs6H7XhNCvtlIC8tYVE4ExYQjWtfiJ7sfmHr3bojmxCpcHWHJ3y0p58CjiitgygAHBDgePRv6Ef2tL5n+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
akub
> Kicinski
> Sent: Friday, February 14, 2025 8:40 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev
> <netdev@vger.kernel.org>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix circular lock=
 dependency
> with netdev_lock
>=20
> On Thu, 13 Feb 2025 16:30:59 -0800 Jacob Keller wrote:
> > Analyzing the places where we take crit_lock in the driver there are
> > two
> > sources:
> >
> > a) several of the work queue tasks including adminq_task,
> > watchdog_task, reset_task, and the finish_config task.
> >
> > b) various callbacks which ultimately stem back to .ndo operations or
> > ethtool operations.
> >
> > The latter cannot be triggered until after the netdevice registration
> > is completed successfully.
> >
> > The iAVF driver uses alloc_ordered_workqueue, which is an unbound
> > workqueue that has a max limit of 1, and thus guarantees that only a
> > single work item on the queue is executing at any given time, so none
> > of the other work threads could be executing due to the ordered workque=
ue
> guarantees.
> >
> > The iavf_finish_config() function also does not do anything else after
> > register_netdevice, unless it fails. It seems unlikely that the driver
> > private crit_lock is protecting anything that register_netdevice()
> > itself touches.
> >
> > Thus, to fix this ABBA lock violation, lets simply release the
> > adapter->crit_lock as well as netdev_lock prior to calling
> > register_netdevice(). We do still keep holding the RTNL lock as
> > required by the function. If we do fail to register the netdevice,
> > then we re-acquire the adapter critical lock to finish the transition
> > back to __IAVF_INIT_CONFIG_ADAPTER.
> >
> > This ensures every call where both netdev_lock and the
> > adapter->crit_lock are acquired under the same ordering.
>=20
> Thanks a lot for figuring this out, much appreciated!
>=20
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



