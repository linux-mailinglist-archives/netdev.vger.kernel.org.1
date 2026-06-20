Return-Path: <netdev+bounces-300817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ScfO0yaNmrDBgcAu9opvQ
	(envelope-from <netdev+bounces-300817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 306446A8F66
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dlqDVR3v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300817-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300817-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0207301F482
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA53939D0;
	Sat, 20 Jun 2026 13:48:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B93909B8
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:48:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781963337; cv=fail; b=WKjinJkKMZQK6ngHFvGesj23yHCSkRn2SWhhKDVi07zU1YXa+kWbvyMUbw9JeMQaVH7afuSxsvcSdQX4A+P72MIdthEDQ1OY1GcH3oVeF3GpY78poBgbUQROwyU7oSQj28LypUzUtfVFU+fkxjz7QPSVs6hYLPd7akhSoKzozRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781963337; c=relaxed/simple;
	bh=RVeouFYimmwQOn7RGM2wGFMwvPBVGP++n57WxWue9iM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M/H19fVHwA0b8UmqfOpPXYr0bwoWHg2W6pr5kiv8rruoPCSQU5+m/iD8d26qv2uf+M2xn7X/8B01P0boONywFWtCS5Wn9GzMS8HFmdJyhqNhv8X22edmwfh/4oN23+cDVl0dnSxdQ8XH7EDzYaKP/FmS7g89GX/LLisILhk2494=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlqDVR3v; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781963336; x=1813499336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVeouFYimmwQOn7RGM2wGFMwvPBVGP++n57WxWue9iM=;
  b=dlqDVR3v6/bckDD6CNd2iNKSQB0SjHcZKc3Pvqo5WwxFDsMFrGLqGqhY
   QOauxhvZf3RXS8q60i+aPI2UOIdEr2icj8FyInw+4bfVeZqyt2+EDIemr
   I8Y4dOM6nXkEuRBlvzXOeOC74mn4z6tH2D8EWafvo5NrNzCGtzk/G0czR
   /tdsaJZf4vKAQ4hKIJG9BZ36Xtt9DrY84Jq6dUzh+kXRun8YAP7Jd9KF8
   1vZgFkwcdKwhQwSsE39EZMd46kLfJ5w4hjZBFtQ+nKbY+JfejF4EwMzWF
   03QIVyDAsE7JR6VgQlLfGXfZmGBc+Cjod17SqZcmaaQjuCidT9O1OZe/Z
   Q==;
X-CSE-ConnectionGUID: v6EqehifSgqgIe86r8WiyA==
X-CSE-MsgGUID: eRnhSLt/RM+4OlyNbXNiUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="82657477"
X-IronPort-AV: E=Sophos;i="6.24,215,1774335600"; 
   d="scan'208";a="82657477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 06:48:56 -0700
X-CSE-ConnectionGUID: wQleTDJ8QhWsJFUYcfqFdg==
X-CSE-MsgGUID: +gAMMkhnR6iOxFIyUavU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,215,1774335600"; 
   d="scan'208";a="247955027"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 06:48:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 20 Jun 2026 06:48:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 20 Jun 2026 06:48:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 20 Jun 2026 06:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Objv1u36rSY5pumsZ5LekiUkC1TiWtt0LYecd+RyOMh35SgLZEUlTuW0lD64M5xIf3F3azYAuK8kA2vYjbY6UcEetmcQl2+swEp363dvit4z98RGV/eHD8A1LHyyvgyvCiMF+Aw888YvwU3HUJ9IEkStqneeU/GbxiI3d1SgqjWqqI2X+uHGgU0F5sneq3eYzCsGCLFHTDOj1GY3Zxzuw+2POzCfk5Afxh5ASJh2XOwURbzEtDPx88C3XzsW8VzDasEkm+f+UkZpBTEEon3gfK9Plcoq3G5O1FWpTe03E8j75UlO0RqzJBG3EMY7bra9uW4a3Vy5nfxhn194qslfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtzwuK5Cu4bcIDmRoXVh6OEkxKmEdP/Jo31BHjPYKMA=;
 b=g3Pr2lEzDKuM+5YDULQGMOJrRX5ZY/8RSwiqv7/n/yV8Rd2XDoVz5WdPLB+hNYNlYjfwY4orJ3erodKSDLcaf824H32k+/m2eJVp0NnAz/+epiOLs1bMfywhI0Cwk+ANorlvQRVymmJ8BAwDTe+sLWG+BAOGigElmpFisH46VE+BCinMXqu3lV/IyxF+J8fI361sgVeVV8IywmYIjpb1qRjoKrcxY0KdQeeLw479I5Tn5qRe+W2HVK3cNiT83Dt6GiNisNFS8PB0uPx4jaGrcol6FEQFqngJttPFBjxeTFkiKohwaM5CMiMvR1wH5JJW0tzEQX81WaX/l4uJxFi+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 13:48:52 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0113.020; Sat, 20 Jun 2026
 13:48:51 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexander H Duyck <alexander.duyck@gmail.com>, "lee@trager.us"
	<lee@trager.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>, "D H, Siddaraju"
	<siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgA==
Date: Sat, 20 Jun 2026 13:48:51 +0000
Message-ID: <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
In-Reply-To: <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DM6PR11MB4723:EE_
x-ms-office365-filtering-correlation-id: 3fc6966c-eb64-4575-4123-08deced2a9c0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|38070700021|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003|3023799007;
x-microsoft-antispam-message-info: f7qW1szVBFHT//nU+w51hJ1HzVeXKg3cooBb4bybc1nKu7lllTF+bH3dM35hWS4JpxxMVJci2a3oJt11RJtQ32XaRnFpo9AHz6bfDzwLkJyqxVNWJXy46e0aNtyTWWv/Upu6+U1R+zsDBegtlcVHB4FSJXgw0+wCtpl3bbQidyQ1Ip1WQCWiQPnzvMBWayberG1j9aFy0f3crUiRjsnc1P/L+vaTyORvtOqlwhQe8yZdyYiZfShYcdBf95wZDuMUc7lHDHG9sOotA0E1pB7sGsPneRHFa37wYE8ORoIORi2CydQQ7VUnBr7VNwADzjZYiS//tkpQafkuYiAIUipFfYTgWTJBJNiAWuhORyA0N1ruwnK2Dq8XAfnzZbjCQzrcWu1HiVg6Ic/bWvx9bDE6qjcdw10fTqwbr1b6iLNXnx/jwBbKyGUhIorWBWuMPEZCz0mC1wJ3OKsfPz6tFc0LB9fy6TW4c93/EjT7o6CccOB83g8Uc0DylnZ6prCOtJPP6QRtBBaow3tOFHrd8e/SDbmkyXAcVfyw1BHAfPxhVU5gwsr5k4Iy5bKMyy6pBNNLUMNY32Yg7T8WfHHomkwwZoLYAz4933aBrpu7u0QNYCbkqo53xW1eKcbHSGOgiBzIAWE/FuXpZIKKiE977EjrzJ5Ai/6B4VI2b3loJrPXGep1RXYa3eap2sDd5Th1IKaJ5R/yJA9b1bcq9nRxfDgOeg2JJcCJb9bAO2atYF/9SgE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S4D1NKr87w/aYlmCLCYDacfD+bk9CnQRTQAElcV4m4+1Iclg0N/C6W04doHX?=
 =?us-ascii?Q?5kP9Qa6qtKzhRNulKMJPpZv84yVWI1Zs7FIx91j5v+B0x4uKRFvw0wV3IA3+?=
 =?us-ascii?Q?6sb+piequruev8tqNbfCHb1IFjShSQQQOBZsVMtmdbo9K4fyAq7SyzyyjyyN?=
 =?us-ascii?Q?CCJsxmG9wB7c3WlxGdltzGpReB2aGX9OJvq8hJAefLrV4zPqIQnZKUvLsBBM?=
 =?us-ascii?Q?xzwALUFHd246BSYOJnLbapsYZloQCZFgUw8it3Q3o8eiY9NkM4mUamxojf5t?=
 =?us-ascii?Q?qQY9rSm9jbMl5Gho1cn5Vqbnu8uPW/9araJKk0GEKtKpuSSAj2r9EgHfnc+O?=
 =?us-ascii?Q?D6MDXF6MZ+xwA5OpXCqvBOMxYSMSw0HWrMgRDvGcCRz+GA6Eh9TdLDnLAimZ?=
 =?us-ascii?Q?+PBQQEjvPoAi+2sIabvdD6665N+dEHtJMHGUOhYCUyaXUlhl8vszE4OFk9iP?=
 =?us-ascii?Q?eDlRyR/wzQH6BqIphVYyiW3Z7S5HS+8g4MMaj1Ia/fbFzsQVi52kFx7zB6V7?=
 =?us-ascii?Q?RUx4MIFhI7V5UzufeTtqiqYcOJbUIMsJVyGPTRdZqC25xk86GxKz6ZhWGhx9?=
 =?us-ascii?Q?6Zeoqvv/1BSvznZxLNhtd0kpApRX8bz1Kb/NJpJ8mpdhMs//UTnscpWZ3/+E?=
 =?us-ascii?Q?CatEyYHeP1JRg/ZM2zyKeeKhNDriotHqRQ0CTk2ntcAsdwIF1d1nV9Xvnwu2?=
 =?us-ascii?Q?sFEMS7uOeRjyi3ebkFDfHx7m0LQ4k0y91tCipNE/qjL78G1clJUJaZ9Qvl6q?=
 =?us-ascii?Q?nF1oY7y6mVQ90Mxp12Uxk/U8RchGTRI4z84osxPCwoz6DyNTZ+zLEcxiEGmI?=
 =?us-ascii?Q?zugWIzv8ovr0jbAi/9pptn5/XIq+0Gk4xaXnM6400ejcO2cYYuIAb1SR729Q?=
 =?us-ascii?Q?0ABxlqoJuSxq/XKaFl/Fm1R3QG7H4zPKR2EgJM7Hg+rzdVMZkvHDSh9sLt0+?=
 =?us-ascii?Q?fs3j+CbMVcPVs/VJxoora9Lw1k+MPxkB5ADZn4RvUClrgmyk1OnNuyy2Vb+m?=
 =?us-ascii?Q?5kDEf/97ObuaMbCf/CIzSU4gljZoN61XGnK8iVBnRZJNZlGzl3/+/Jl8aJqF?=
 =?us-ascii?Q?bf4ENArP2vfZUg/7R2VNuAyAXmbJV8SQCDPpfqOZQMqKJovc0+P32yLztnna?=
 =?us-ascii?Q?2FHq6Gyfg5j70tVtToMbYaalapvOC8JL/ldMmU+anNPisu5/wsb9WRLU5Bzs?=
 =?us-ascii?Q?7x/S+pguZ6rR5AqJ9a9nitcEDyuA9ico9FZGsUZUsTayGMIARkdWndbUizim?=
 =?us-ascii?Q?JIn31W/mSJ+XIOmKb8BwAw/c2pKc2KUuw0l7DoSbfgbsJpjbYN8bmu7Hs2t3?=
 =?us-ascii?Q?Hu/Xwywy1HA5BzaBuMPOtvCZGbvNjZlSQF9t4crrK3Q1iNCanoqLef0nRGZi?=
 =?us-ascii?Q?bekdaVl0qRgWaH9JGbb8JhhFP9/MWM2D8gH4a7sIHlVcpyJacLz0mbLPCrv2?=
 =?us-ascii?Q?fLiYhetiGiRrGDFVLMTvRawP1rrniWZCkThRm9v+0nuQvctJInvhpz453Mya?=
 =?us-ascii?Q?5kAjU5V2CsqfkezwDnWKqd9WHnUSvUbK+CqUwjPvM2qh6/2V/g7DDdoWE6x4?=
 =?us-ascii?Q?puDzGwD9G8piGU8cNUsK+Wltfy2WupQLuRapRWKMevxEQ6HYlmdofz16gT54?=
 =?us-ascii?Q?B3z+CiEmFNWR1XcFsJGwc1+By942kw3Yzg1EdaStC9+6haJcTm3iNKpG0Gg7?=
 =?us-ascii?Q?HSd1cEeynwlM0KhqnZDXS4+jU+CsRrgMdVjlA3EpPnV+kq8+k50sL0QTX09B?=
 =?us-ascii?Q?h7CH/I+3xEOoeemxh2mx/eaqgKlsDyQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H8uv60ywgMNa40T6xMHoT44e3Kh/X/PlLDE1XfHh2pCKMwCtOKHBVwOuKrPpveMYEZ7AkGXd6GbIs5ppokXq2Gc7k+/7uWcLvFWgxg1xjSzzzQ4kFd3lfdrAAlnf5FkO2rEIWMkX+kp1v1O0V3P0YgUfUSXTyYASklBHj6kYIlLyVAGwRkeD5Fqzjkds4hcpyTTr9EqOT94dk5mHSIs9pgKSNafdQIMJB6iWkDiafoHdsfy1ysniB+FH6IYs/qea1RJ2CjUzNzhu/XrFlom6NjrfSIGdC6s1HscziNQbsLtEuHfhiQC1MtQjT8FuC3oOFy9V+v87Pqt+1hp1LpJzoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc6966c-eb64-4575-4123-08deced2a9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 13:48:51.9574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZEaFh6BC1zJi1A4rCU70Wyv6D8Zeg2kffW6P4EtF7lmirdT07KrA789dOGRK/h7cJR1A2jBzwFSBSaQCSOFsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300817-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email,intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,lunn.ch:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:lee@trager.us,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,trager.us,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 306446A8F66

> Can you change the firmware to expose the 802.3 registers for PRBS?
> You can then write a library which both plylib and your driver can use.

Andrew,

No, exposing the PRBS registers to drivers is not possible in our design (t=
he registers are buried deep within the Accelerator/NIC/PHY/Analog IP hiera=
rchy).

Additionally, the PHY PRBS registers are not in accordance with the IEEE Cl=
ause 45 definitions. For instance, the PRBS registers are paged and 32-bit =
wide.

Given these constraints, we think ethtool --phy-test is a reasonable starti=
ng point for exposing the long-established Ethernet PRBS functionality to L=
inux userspace, as it aligns well with the driver-owned NIC architecture mo=
del. If you think a more generic layered approach would be preferable, we w=
ould appreciate guidance on the expected architecture. That would help us b=
etter understand the implementation complexity, required effort, and delive=
ry timelines.

Thanks,
Shubham D

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 20 June 2026 00:07
> To: Das, Shubham <shubham.das@intel.com>
> Cc: Alexander H Duyck <alexander.duyck@gmail.com>; lee@trager.us;
> netdev@vger.kernel.org; mkubecek@suse.cz; D H, Siddaraju
> <siddaraju.dh@intel.com>; Chintalapalle, Balaji
> <balaji.chintalapalle@intel.com>; Lindberg, Magnus
> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
> Subject: Re: Ethtool : PRBS feature
>=20
> > The host driver does not directly access any registers but requests
> > the PHY FW to manage PRBS on behalf of it.
>=20
> Maybe a dumb question. Why?
>=20
> Can you change the firmware to expose the 802.3 registers for PRBS?
> You can then write a library which both plylib and your driver can use.
>=20
> 	Andrew

