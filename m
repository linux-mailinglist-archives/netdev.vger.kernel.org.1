Return-Path: <netdev+bounces-192465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F931ABFF70
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 00:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5003A6DE0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63E239E95;
	Wed, 21 May 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRSwlri/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBD134AC
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866393; cv=fail; b=Gss0/oZoJVwOf1T3qShyKN98nRZdU2nCdozAuFvifMYPGnTRYvDaQkOQbTRq697oRjzKjNRfF6DW0xbNtDLXsc71/GBUaxljHCWfIJnzBU6EemiSe3bzEh69ODd72WerMQiD97YayK+busc9Ilih8G/FLiUCJB+hi9CEzYYgaoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866393; c=relaxed/simple;
	bh=hI0IYNQ2pnSgeCt+UEPPDXEFsYjUXXEh9b3+QXAxxPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XYqL9k046vu9rYJ0uYJdFZ9SvdTHPaoz2jkOcW0v6d4Ub5SVYQhBWL4HxgsftnjSfCgFOWuooR6e/fI0rGAi+eDCLrZl4AwnBhpiaCwk2TZzVejTtcNF1+vEKBXP2jvL0t3duqtCvc86ywXvAZXM0VRJME0nqz7zroDRZh7XTyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRSwlri/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747866391; x=1779402391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hI0IYNQ2pnSgeCt+UEPPDXEFsYjUXXEh9b3+QXAxxPU=;
  b=RRSwlri/2bEb09NwezmtN+vEodu57Ox5JwM8mi5mfEsLPT5UzyARgbhi
   a+dH/x4hrsbldsrHg6onOtwvCgmWDGnqiyGtuQTtIYdADAnWhiKeoXYJC
   mMAOqbI45c//4DMFxaXPP0WKsNIFiP+fYqyYRglAeAYeT6ORUGq4wDXgV
   /wi5p53PJ27IkbGr0jk3pIKYcmcejesARq/pmbf7hsehoy13caZ3zu5T7
   ftsUEnaefwGOnA/bp72oRD/ahrvgObf8PjcV4iRreJ7Tri2IubAtk9Wtr
   OdyygUZoZuYr34ge86x1LkPeS0tQXe7JXZBtUVcN01HcbXVfLecqDACm9
   Q==;
X-CSE-ConnectionGUID: dhOZ4QfoShCDc/1KiHUYCg==
X-CSE-MsgGUID: jJWVaXctQuigy8mWeZ9jEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60506089"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60506089"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:26:30 -0700
X-CSE-ConnectionGUID: /jQ6BMkmSMikSf7s09Cp1w==
X-CSE-MsgGUID: Ki2JMPbsSLOEdYKDMNFS7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140809461"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:26:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 15:26:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 15:26:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 15:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb5bmj0V+IOw9UXGwwHqwXxCv+3y4E7xFsWY3gNazIPpRVzWQX7V36jOYMIwnjg98zKMPiy25qsEAIqIy4GJa6w/aSHGkYzeK6+lx1Vr+J+cXZhpP5nxFO8bpn23cG9IPb7nsMPjgJkVWPHHHk6CcxSbs+eJ33Z3P1KutUNsp0W1x/EPLn6FkBae1xYkchDZLk+Qwuqz3e2D1N1ye0a2ATPgy6NTB3OlClmU4odGWox/Zyp6dZAe21jNRD9CJ2oqVFXvWxQ+O1tncubLT+1Gic+AHZw4/GrBIVcepMBtYmps5RGNpYq4dk0/a60QfGbpqESzdTQ1DxNAnQZ4Ymb0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI0IYNQ2pnSgeCt+UEPPDXEFsYjUXXEh9b3+QXAxxPU=;
 b=oBKXhpct40T/m7poK19njRROtViwdI+L4AUE2msBdazza1uWqxNQw4T2vd7ra5q9TqahSlyvsKTOEjeAgkYKJGweQ3juto3KzDPBaC3z2p+i7LJJJ1EVf957YM9nDR/Jx7z+aHVQEEOEtVxc8yNE5M83EizIX7cFPnfeGzgU3iCy0iCi8Mp+H9qnBU1rpND1IsXA7CON+xLmDRVRu7JDd5frxCuU/AguZsGLVF/gLHUZrjqWzQiF7QyLKeW38VGuEZ3C0z0nRHFcucdWnGXSnKn9Gb3PNDgeD2H8j0dkBIP0T/58RvyASTXNQRN1SfkgvyBQWVluHzjp/97vB/Pj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 22:26:23 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 22:26:22 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "decot@google.com"
	<decot@google.com>, "willemb@google.com" <willemb@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Zaki,
 Ahmed" <ahmed.zaki@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid mailbox timeout
 delays during reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid mailbox timeout
 delays during reset
Thread-Index: AQHbwEpI3XQPilWhh0mQYoNuAU5BELPdt+eg
Date: Wed, 21 May 2025 22:26:22 +0000
Message-ID: <SJ1PR11MB6297AB611B60EC35490E77279B9EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250508184715.7631-1-emil.s.tantilov@intel.com>
In-Reply-To: <20250508184715.7631-1-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DS0PR11MB7788:EE_
x-ms-office365-filtering-correlation-id: 2f57c686-a245-4856-3bf4-08dd98b6841a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?SMqZ6ZRPhZA2LwmJGsIQcMV/O+QYdTgyiE6jLI4lcsq5m2O0nAGEadcGAMYA?=
 =?us-ascii?Q?41HjATYiEGZ+nG/vnluf5PH9hU1E/ahTpqfFCrW2qfIanvNCfN045DgbszHN?=
 =?us-ascii?Q?qfRTV/TdIdc9brdvZDVRfrp9hD+BND/T7lm/Mt2c6pUm0wKaXdQYQkwRFpH5?=
 =?us-ascii?Q?z4DteHnso1zAfUB2DRFmkPQfpcEoAdC+lMj5np1mkWVDSH4LaFqxVEJIv88w?=
 =?us-ascii?Q?+cM+N2vOeYwjnIAQFbSYrsN5l/jT6Nf/uyu6bsuCmys67kPrNzGthH7p0z6f?=
 =?us-ascii?Q?Fggdtx7s7B8PHGEXldUyeLfuyCRvl/5KdoDxR9eFYSlXmtVSdYZ2ksPIWBhs?=
 =?us-ascii?Q?N+uoiefGw61xDjTAxEMlj8PrLzfR9MwuqcsIx/MCZeg91Zg6cj777XER2XZs?=
 =?us-ascii?Q?Ym9lEOvTUHOgYbSivSJYNdYKUWqxurbS3Vu+q0s7oLrfPqfFN8Ppv4kd2fz1?=
 =?us-ascii?Q?eZmnD75bufRCpsn0AZiIEYpVAC6nLLLA6PcDh6DpChvVowKrGimtUrNXkPBK?=
 =?us-ascii?Q?gCU3focWGH+tNel41IAsQdAvQN3fgRts1/PE/tCIHPmsQaxR/F3HbhTM8E3d?=
 =?us-ascii?Q?NzfMLNvRNziZ6hEQzQ6tAOR+BiUSY4CUCWC14QSR0RI5H3DuEQe4KPqoAYrg?=
 =?us-ascii?Q?RvuFy87+PqvouW5xK2zt28EqCtw2q5is6YJ5dska6a5jna1nxhjAJtz05rFD?=
 =?us-ascii?Q?ODYnNcKNCkEuRw4ddPCNKWKxPcweokf0eX6j6k3L8wPEUGL25y6LVU/xsmK7?=
 =?us-ascii?Q?PDAjxr7TLOt9UZN5Z6OUvT322zhyhgRTUtFjlF2SDxePvR6S7SYzjaW1m7Uf?=
 =?us-ascii?Q?euCFiAeSAuM2rRdTGmE1BUj9vQ8jecYBzzooMFl1MsvRYhcIRpGQvGs4anXM?=
 =?us-ascii?Q?ZP77xoDr9S2XPiJ47mrNKPbLLrVfAVkF7i7cfLx9HBm7dbzJq29rtqfPFe1s?=
 =?us-ascii?Q?4MNrlNaOvyf7imuMImtiUbJJHD53/BRIT2keF3+3HkWLJAIuzhSFedvYZOSJ?=
 =?us-ascii?Q?EcBkw94YXqtvEaOll3MuJ36p901qerFH5APzJ7XBJ3Gsw891hpbfAcAqjiO+?=
 =?us-ascii?Q?yJZfA91X0RihXQ2a0v97G52pFd7Ja5vRSqVr2TJ8fpcLUIMGDac9WkensJEt?=
 =?us-ascii?Q?4bOjuhhyv5MgqEyV6a46dm98gILMOKG71cQPqzx+koHKvPD/nXWrcFm1FloJ?=
 =?us-ascii?Q?tjbUuXZeyFPGa3136xHtcFIs8ptaSSqomFHSFYC3ffcr7APS2tvjErkZiqt/?=
 =?us-ascii?Q?qxSPSmab/lHJnehZiQWmLF/UZ275Yh2tSBJsDJlRrdLx0t4itDr5/z0co2my?=
 =?us-ascii?Q?1rOdeYLXRal/a8zdbAPUcygu6PgX+YbBAB1NRA0t7CoQ7Fa6vfJ4JQ4usVu6?=
 =?us-ascii?Q?h0BUfIdfD6cSPpuLwOFJs/+VTKIpg20JPO8pDtXtlx38LDp7GpjYoSXmZBaX?=
 =?us-ascii?Q?MIhTBt9E4oUg6kDljW0ljZi/GNKRcgI9Od1+uJpCsjRqBlVlwPl+KQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z5D34FrTdlG7GHGzyK/7yWBaThpzoCdF32wqlrbw6T9WltDdzw7yExi7IOxr?=
 =?us-ascii?Q?KOv6IxSVdCci9D5nidK8mVosJGOwEW7hkkJB6U9sjM9vixp+ZZM8umCDLjOU?=
 =?us-ascii?Q?vp3y1IAIR0JNjJbz19yD/MNNtbsoNhxCcjvyWHjubQWdKYmpYaDOJyX9d9hy?=
 =?us-ascii?Q?pWEAwC1RkdcSYow5xG1kQVgZ3S67Egq8yNEdVpyhfnjpSBpIBufa94SiSbYK?=
 =?us-ascii?Q?LYreMw+3QIsBgbm7158FB9Sht4topRZZT/k/zHTZdVA8Pk45mxwXvngydlAn?=
 =?us-ascii?Q?A0U57UOFchvCsua4AtzfACYv5955Q/yKtOKA2zwpt7/6MSwD6bjXx9pfloDN?=
 =?us-ascii?Q?g1TRIGirWGJldxvbOGFDk+l0MBDb6nYjzzFKt/YJE6xwRQl8eugIE3cpEK7K?=
 =?us-ascii?Q?7EnBeclCbWm4SZ0mRmWdRxvSE3W4zTfwyXOExO/Um+/al/9CQHESGJ6ynrCQ?=
 =?us-ascii?Q?KJktnpd5IrCS7q28gS2dA4v06Pv2JLTzqBAVb2jcQvvmKAiGRFU9bwBPD0uP?=
 =?us-ascii?Q?UXjHqoEpsEEETNnNu14BYq+nhKsLjF2T7vYRUuHVenaUIAQ1oALG2djkbh4P?=
 =?us-ascii?Q?0NRECUur8Fe62Vf+2H4IqY6MdKksXTSBGl0Kyl/f+QuEHXj52AAIb5LEXEvK?=
 =?us-ascii?Q?KAx9GPS2AjIWrPgqLXOE6MA4/uUiCQmMG2Gc46ElY2ACAqwlxpQjXb4GUDER?=
 =?us-ascii?Q?Ip93B1oIpCtGrnHtKwbqdCUD4j6Opy70++RcLZauwojPXrsMnqrgzl3u0PKK?=
 =?us-ascii?Q?u3dIHayH+qyYbsx/zY0G4KsyZh7zKCoXRBWNZwGpNAYVN7S6LjFjo76iPutj?=
 =?us-ascii?Q?TeSo9xjA6a5taMtLvbPdR7EFCYZZgmejJiUJPtFwoM9WZqTx8IZPo9VqmLKb?=
 =?us-ascii?Q?+06u/vTVAA6cziWLrYnTkBph3q01/NSkTt+GQ72obN3svrFmU/PPQXLvsBLt?=
 =?us-ascii?Q?zE6t2XkargkAN07RUdDo0DqEj2+8DXBKp3iv/bBE87foVyGYLR3MElSMCUoY?=
 =?us-ascii?Q?w73VVa1zfUZR6Yr6uPPvYgbkvGVomIJ2FGhTrOGd4JajVnqLhsrWk9BZKWxq?=
 =?us-ascii?Q?doN0Z5Lo8sMwGjJ/niLozcTACW6P/Wvipy1dSQyvhvPqoHI2x1Ppj2raPiBP?=
 =?us-ascii?Q?p9ItN0dM3f4NmpXF0eWzZS2sZu6YqqzuPSBdLo9tk7wBD5A+Y/HZaZyorj2u?=
 =?us-ascii?Q?8vO7DThgkhIPXwxsocRBSW8yHYgEbHUSBFEt+IEhiOrr5OUzmyt5bO4CA/+Y?=
 =?us-ascii?Q?au6rnyCFA7LhV5nypf3palZzHkZznjIywAgk+LZsqC+jESMjGIOg2dGmaC7h?=
 =?us-ascii?Q?U5jqZIXf18m7Fcz2+6oneVDf0JmFMO430Vdw56sueOROeHRdOfficPyK+7Ci?=
 =?us-ascii?Q?ErTw51C2ZZag1LOhXF9UhBeVyedNWlrdHPJbiL7ljMpJhJL1Rbr7V+9xsDE3?=
 =?us-ascii?Q?Iry2HL1c1liFa6O9K3oPG9VkdHDTvEoQFRzh2bIMzJtTrAQ3b8k0oS9ennkZ?=
 =?us-ascii?Q?fVgRCJBwOEL2mbLZ/mVNHo0IxIjM1LKo/C/SY+Ay9GEbJPjxwBoivkpAPEbw?=
 =?us-ascii?Q?2KNXqu96dS/gUcN2KMMuNP4Ji5jCk5CTznHyBujh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f57c686-a245-4856-3bf4-08dd98b6841a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 22:26:22.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KoCSnsSpjMlZW7zJH9Ta+5zSJbZ06P1Ct5pxZYQ/Zeouy4nADAvFINSF9iZ23vwkw94E0KECbRZbenjTqdtXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Thursday, May 8, 2025 11:47 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; decot@google.com; willemb@google.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Chittim,
> Madhu <madhu.chittim@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; Hay, Joshua A
> <joshua.a.hay@intel.com>; Zaki, Ahmed <ahmed.zaki@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid mailbox timeout de=
lays
> during reset
>=20
> Mailbox operations are not possible while the driver is in reset.
> Operations that require MBX exchange with the control plane will result i=
n long
> delays if executed while a reset is in progress:
>=20
> ethtool -L <inf> combined 8& echo 1 > /sys/class/net/<inf>/device/reset i=
dpf
> 0000:83:00.0: HW reset detected idpf 0000:83:00.0: Device HW Reset
> initiated idpf 0000:83:00.0: Transaction timed-out (op:504 cookie:be00
> vc_op:504 salt:be timeout:2000ms) idpf 0000:83:00.0: Transaction timed-
> out (op:508 cookie:bf00 vc_op:508 salt:bf timeout:2000ms) idpf
> 0000:83:00.0: Transaction timed-out (op:512 cookie:c000 vc_op:512 salt:c0
> timeout:2000ms) idpf 0000:83:00.0: Transaction timed-out (op:510
> cookie:c100 vc_op:510 salt:c1 timeout:2000ms) idpf 0000:83:00.0:
> Transaction timed-out (op:509 cookie:c200 vc_op:509 salt:c2
> timeout:60000ms) idpf 0000:83:00.0: Transaction timed-out (op:509
> cookie:c300 vc_op:509 salt:c3 timeout:60000ms) idpf 0000:83:00.0:
> Transaction timed-out (op:505 cookie:c400 vc_op:505 salt:c4
> timeout:60000ms) idpf 0000:83:00.0: Failed to configure queues for vport =
0,
> -62
>=20
> Disable mailbox communication in case of a reset, unless it's done during=
 a
> driver load, where the virtchnl operations are needed to configure the de=
vice.
>=20
> Fixes: 8077c727561aa ("idpf: add controlq init and reset checks")
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
> 2.17.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

