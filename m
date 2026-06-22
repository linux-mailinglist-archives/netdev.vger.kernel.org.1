Return-Path: <netdev+bounces-301145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OE14FCFROWoPqgcAu9opvQ
	(envelope-from <netdev+bounces-301145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659F6B0A0D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Ygydk04U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301145-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677D53007E10
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16A32F757;
	Mon, 22 Jun 2026 15:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED0330315
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:10:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141053; cv=fail; b=kL0iplBsGPCFSvv6tKWEgbKLQqEyy3LQAEOGUZj8YqOw3dlGoCappaOHKiK5qGHKsXPVXDt6gONNWYA9Vo7b9xp59NaikWLxb5vcnDOlHdyZZbzO7WYVrIF+jQPVlfU0/RhUKQyM0SRhlISS4IvAxxDSARLFvH0Akl4tqyHuQnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141053; c=relaxed/simple;
	bh=dSTnCrBlOadlJFOzm7B81DZi/sF4kyvcOSwBiqh4TEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COEGg0PuGSI1ji5H6zZq8KmpSGKHs9zKgYpGeGBLCTjLS+22TwWYB3mQKHE0FA67ag/z7SLcxnRsJ5ibmVopWs9UkraxOH+wDddHYaj/SzzSR/O7Mwt85gaAnKcj5L+7MT+L8o5xOQu9dLRe4HuJHShUDH5yW+zeBN/NvonMV7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ygydk04U; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782141052; x=1813677052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSTnCrBlOadlJFOzm7B81DZi/sF4kyvcOSwBiqh4TEo=;
  b=Ygydk04UmdlagHNkQOwmNDJJzV7y1cXsimH6HbvNm8gkLWR8NTjgmHat
   AzkZzqLZ8B9INcJBresDuCam/T2hJu0bChOKRnsrMqiszFYUdB7mfhxUA
   BimtktaDBlODH1MpMfQLAoNgglNAjBDD6O8o5rTQDZvJ6/aUlVxJMdzfp
   Fqhr91L4oRlXo5sYSmFZkFHcBuDllBYfnlRKfxls6kgU2zhaEdzZYd9sv
   PMNEC+j1+Dcwg/YSgBXr6v0qRa36pCTOgRmO1XKMawYRDphP3y6o0n1lI
   7N4mC8+Z5xNiLx1w+YNMo69v9aNsgY5jViXwLMP2m++BsU6gMHRy6wHyI
   Q==;
X-CSE-ConnectionGUID: 4MXwrbMST+G5dY4kVs2mLQ==
X-CSE-MsgGUID: /oUFLGNOSsS6+YsXIctC4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82757191"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82757191"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:10:51 -0700
X-CSE-ConnectionGUID: GLSoXFoLR8SIfdV5prlXHg==
X-CSE-MsgGUID: V+8JA+h8SWmxTrekAyVd3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="253595572"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:10:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:10:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 08:10:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSjaDgRI5Q0b9SzELWZOmPZ+ntAdJvBe9cOi9VnmuQLRomvo4aMwWrHv5jkDaHO9JGClrVNHsDMve9LG0IpsxKtanY8BDTbr5rM4wD9vfNmxMgHYV4767yl+Rb4DJys2EcjbBPDD2MILy6jkDTyQkGSN6HwInuxX6dvtJ9E34zaihR3S7UnvLW4BJC3hAHw4ojMwlBpr6oIz1bo3fjX1WsXQczndiIQUVYaNbKF+6IfRWGosQiXhR7bE4jsLv2BUGaWfRFNRMr0be3gdWFtOPDdNl2jQErj/HYIUdYpjgoOZuebUh4xfOEQ6L19C87dhHFQfwG8lrLWtjZyUQaFg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACLDNRy0s3Vmv1gGZqVs8wdr0JH2l1rWJ3vMtosO6Zg=;
 b=DVU6kucbDaVhmXRjcookKlhEKe9Yu1MHKf2lkRbjbWqDxWEB/RyiyteUQhhhKgSKOAc6lrRwswRkuuGCjtvYZygQaZLzH3eFzCkAdJGtVmDLmF9o6pKI9lER/jNv0i778UhTuITqyC2zD2qBW6ifzzj2Gzajhuyj4V93g6N7k6Qb0MId5h7S1X+/oUMRSqVRmAtGL4KM7YweCNZo66nGIZCkelZ9nK5Jzzq5DNiLN2zCflq4U0AgllNozYOgznIMMRwNNoHZaRiuEvqyjtCgbYG2PCXGyo5cfHlA8UjH13kvDMKOpSS+PNpIIzbDluTPTxskhGt0QYn6yZRdTsf8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:10:45 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0113.020; Mon, 22 Jun 2026
 15:10:44 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: Alexander H Duyck <alexander.duyck@gmail.com>, "lee@trager.us"
	<lee@trager.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>, "D H, Siddaraju"
	<siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAAnWvoAAWxfbcA==
Date: Mon, 22 Jun 2026 15:10:44 +0000
Message-ID: <SN7PR11MB81092F72FFCAA99DB97244B8FFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <b61ee484-f9f5-4504-9e88-aeac701cd4e2@lunn.ch>
In-Reply-To: <b61ee484-f9f5-4504-9e88-aeac701cd4e2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DS0PR11MB8717:EE_
x-ms-office365-filtering-correlation-id: 058d9536-a38d-4a1e-8567-08ded0706ee2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007|6133799003|38070700021;
x-microsoft-antispam-message-info: mz16OvhGVbHqIKCW0l/2L0JfeJSUiShiM6rPSoD2gjkhOSSlAhlNCCo41TtP8eL6vTH8+Ei/r1fUb3fuybUFaupr5AoVhCrqUaK7NBseT/9hz3wkte2RH6pI53q2UxnhKGYsvJ6DfFNziJbaDAecUUCqUf/x4zHUeBoCqHO5sKiOUFZ6sfLRJR98ARIB7t6qHaEm7m/4iMRMsijPrpZ7Wzck7IXU3sWdbrtX4MooAOFyzISgRXgU3lxy5AIhG/3wouzbYiSD+KFKvOEwI3Lyi0d3S3W743wDxqQtgmpU/pnNz4uwyMwcF9GkNcSi/LcZLvt0xbNTcx3g9NJPuli/oH6Y0eFr9WeOm4Jg/s5PQQynqUGViRxQ72BEYXYFXdKrd9ga74KsCxmChkdxNthTZJU78ReEftM4bpZpuJRCr9lP2gRBOXZw4IEkMuwI2qDlLr3k+qKmoZUhCJGk4tSEoivtYsOcPUDn5Jb6LN0/d6UttYIhyVBTIDUdsNh3Xang/vQSzfrWTz/HT2XS7Yvi2xKibAUb8O0Ye/tArEWsUYAIV+wcWGH8wd1pGCIATDsttXnxQFmuKiWXLiUqzsZxRFE+AJ3UknPqY52Fr04QkbCGLsn4CfpvpCY47wBkLJv7tTH4RBLo4fyRMRv680HArIzbO5oMQCBHJhyRvgP3N25UBcKQChf3Efk0uz2EqHAOdqPXSICQ/ggZ4kmzTqJz8oAGPeD6opIsZHVBlTFW73A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v7CeGXUQmqt7lxn8Klha50IS/JQk0soZNWbIN3jV6e1dkOC33BFbIZkZ9p+v?=
 =?us-ascii?Q?FvrwUU6ZfIIuO6MRdQH0G11pKkUuKpybLDBIPtepwJCYILpIeur3a6CFlhF8?=
 =?us-ascii?Q?ndK4V4W6emAAHslWj9iCe7VlVH5T05Mf7yEyNCys6Pq08pw6MIv59CTlXFkc?=
 =?us-ascii?Q?qvRad+smvlrEMaFblSvbe2e6IxI0ZgQvJBklt1ExKX58YBR6Z1ggw4gjHdDM?=
 =?us-ascii?Q?kz5ItwRmn0Q6/mJ9s1+6KZV/Y0FIyn/8nVvpBRs3In5Fy1WcrVa/Y6b/Sr5s?=
 =?us-ascii?Q?AzvODlhSOPphkGAzjjUAJ2SiDnzRnzWfDcAqB+3o9Yg05r5cNcVif0Cg36x2?=
 =?us-ascii?Q?D0WUwv9k7rq9THIFo55N3aRZ9u1B5Cjza/z2A1dO5qrw55cnGOc9jvgfuJBi?=
 =?us-ascii?Q?1hMXOAGS38/NkcG1Ta1H95uH+q1deMdP5jgWoi4AqGDIznA72OEAx7mLBXFf?=
 =?us-ascii?Q?RWXpUuKyK/mwXmeLpWdTIJhfaK8mkQ/CbqpDpWYQJVxe8ybWehFWpwdEQoCV?=
 =?us-ascii?Q?hwEJjzYRgLUHuH8AWVAi80rDxe5ZAayslOg0rGu3NiEKOOY2q+uDu/qhaHta?=
 =?us-ascii?Q?82lYJr3yZqLNOwm4ftCp1i3TY2FWz+ezmptISbFd7efdWFG+zcuimSQ7a/vS?=
 =?us-ascii?Q?1dg9KBGWjDTDTn9/JBp6WDQbT/dqCBSFriCFVHRR8LAtWnMpWVVupKaigrzO?=
 =?us-ascii?Q?w92rWnlBh2DdBqIlxd602Vw5Y8IU9HGVASYM7/jUBSLYWvtm9f31inGJqsB2?=
 =?us-ascii?Q?sAJpl6/0eugPgEVVTQvJQR4++jGobXja6xpNjVO29TATpJ/GhTrMdV1U4Mk/?=
 =?us-ascii?Q?5DccrnBhbeELMpq3UD1LVIqGDCm02R60udfWeoWqmoRbgkMhdT+Pl5c6PgGT?=
 =?us-ascii?Q?RS5Y+5+U7Gk7S28IxemTFXETZn7ieEvCKERS9upzMdwkH5n0saoiDnRZkcop?=
 =?us-ascii?Q?4xyYfKhPncIH726K84LEKjwFV0Ncf/TZgc1wzzCJS9M71/NiYwcPit/yvm2O?=
 =?us-ascii?Q?Z29AW50o1Fl+VQiTcWxCbs63x2nVb2dQgWm+mWVkFlQqsLiOsPipaEtCCvKO?=
 =?us-ascii?Q?5V3PXUbv3ekvXkhAS4pyDDXu3izF8WUBQ4MCPSPtDQPrCpmdg9vIiIiwZgzm?=
 =?us-ascii?Q?PVgaOgmpV93zzHRKTrmaQfKS3O17hMh9cFJjxPSQpax2w848b4Ptf60ZUx/v?=
 =?us-ascii?Q?bYEDdxDoytkohgZ2XrtGmkVeGthX1E3anzv1YlsuZjwZ1t1JtD3b0NkhTREB?=
 =?us-ascii?Q?94uYeV7ZqtUILrExN7Cewg2j2LuclBJXbOdgWp1N1vEJpIF1BNRTl+9lOiss?=
 =?us-ascii?Q?nR4bjMFycuZEmUJ8/1VQ0JZEH1Ot9ebcXDDXmft/JfCrt92OVbNSORTzKOH+?=
 =?us-ascii?Q?udm1Wzl8sJwPzl+DPRxKewXc2Kgfd+OoEU7Mx/9t6k8nXkIE5INoYGPwaIVz?=
 =?us-ascii?Q?jCc8qOZanzHT29K5p9VmB0gW4ybLzu+vqvgnOK2du4pP7MeIjesWTE3L/Vje?=
 =?us-ascii?Q?njaOQCbu+JVhUFx3guOw/lClznUjxA+LQj4QLEd7ZxvCSlNTCQFf+mKCvy9G?=
 =?us-ascii?Q?8gOxxOYFY5GEijGEYDkK9BaZXI5YthnzTlhYhKmdVgC4V52BNUrQmibSNrgL?=
 =?us-ascii?Q?th6AQ/Cic1oScnbDCu+j41YOhJ+Zzx4CjbhA6VrzP9XgRqwtHkGaF7Z3/VD7?=
 =?us-ascii?Q?FyahYsqdkOI1ymxBo/Dql//f1H6lhvNjGRt75nf+Aa0Hf+h4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IYHezQHdwD8I1L+6xyr+3w/HRLlP6tbJUO/JYESXnZyg1SC5+h3gYpGVRhpEneHv+VwCFZMw6v1Ik75XfqmPawzCnJXexE5sshmzEcB+Ej9g4hGJCIdk0OVBhysv9JmGpQVSGDTs+jA3mEix0EwwE4mu4sCA0YjwCMhhxXy5M4Yhb0F2FpO875aTkNBUTRKY0ywcuvOrFinKJ8BC5Pme/S8N9pYf61oWs2k+Lxs6jdIeuJYul0QX+fZe1JBe2OjP+8BnrNBXSat3IUd4DKJFA4VlodyzPl4LIIXnIFcs0vYrjGNyD2sBdzjH91bcMYmfoSkUG6doA8blWKKDhAxKZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058d9536-a38d-4a1e-8567-08ded0706ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 15:10:44.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpQ2MZ3KwuqBYb2EVsuiCZpfBtr1XKEedaWv5s9QyNO14MNJM6/kn/0S3NxkbNjoEk9K/xGwBoZXROoJpai5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,lunn.ch:email,SN7PR11MB8109.namprd11.prod.outlook.com:mid,ericsson.com:email,bootlin.com:email,suse.cz:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:alexander.duyck@gmail.com,m:lee@trager.us,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9659F6B0A0D

> Do you at least have the functionality of the standard C45 registers, eve=
n if the addresses and bit fields are messed up?
> If you do, maybe we should actually start with a C45 conforming implement=
ation, and then you can do a translation layer to whatever oddball implemen=
tation you have?

The PHY supports the equivalent functionality (PRBS TX, PRBS RX/checker, BE=
R testing, error injection, and symbol/error counters read),=20
but these are not exposed through standard Clause 45 PRBS registers. Instea=
d, all operations are implemented by PHY firmware
and accessed through a command/control register interface.

If we want to support both driver-owned NIC architectures and use cases whe=
re the PHY driver directly manages the PRBS functionality,
Should this be exposed through a common phylib abstraction/API or a differe=
nt approach ?

- Shubham D

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 21 June 2026 00:51
> To: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Cc: Das, Shubham <shubham.das@intel.com>; Alexander H Duyck
> <alexander.duyck@gmail.com>; lee@trager.us; netdev@vger.kernel.org;
> mkubecek@suse.cz; D H, Siddaraju <siddaraju.dh@intel.com>; Chintalapalle,
> Balaji <balaji.chintalapalle@intel.com>; Lindberg, Magnus
> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
> Subject: Re: Ethtool : PRBS feature
>=20
> On Sat, Jun 20, 2026 at 04:39:06PM +0200, Maxime Chevallier wrote:
> > Hi,
> >
> > On 6/20/26 15:48, Das, Shubham wrote:
> > >> Can you change the firmware to expose the 802.3 registers for PRBS?
> > >> You can then write a library which both plylib and your driver can u=
se.
> > >
> > > Andrew,
> > >
> > > No, exposing the PRBS registers to drivers is not possible in our des=
ign (the
> registers are buried deep within the Accelerator/NIC/PHY/Analog IP hierar=
chy).
> > >
> > > Additionally, the PHY PRBS registers are not in accordance with the I=
EEE
> Clause 45 definitions. For instance, the PRBS registers are paged and 32-=
bit wide.
> > >
>=20
> Hi Shubham
>=20
> Do you at least have the functionality of the standard C45 registers, eve=
n if the
> addresses and bit fields are messed up?
>=20
> If you do, maybe we should actually start with a C45 conforming implement=
ation,
> and then you can do a translation layer to whatever oddball implementatio=
n you
> have?
>=20
> > > Given these constraints, we think ethtool --phy-test is a reasonable
> > > starting point for exposing the long-established Ethernet PRBS
> > > functionality to Linux userspace, as it aligns well with the
> > > driver-owned NIC architecture model.
>=20
> I agree an ethtool --phy-test makes sense, but we need to ensure standard=
 based
> C45 functionality is covered, not just your oddball vendor functionality.
>=20
> 	Andrew

