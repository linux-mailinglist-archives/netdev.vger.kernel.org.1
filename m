Return-Path: <netdev+bounces-158491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A5A122CF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DA5163FE1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721023F280;
	Wed, 15 Jan 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFgJS9MK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8862139C6;
	Wed, 15 Jan 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941185; cv=fail; b=N3kaJ9VhdgqqX24Z/Wag9UrOSzxPs123vwihLfQSplIuxd+X1oE1wlS+uL0VVUpL4wj7yuyv0tgVI8gwtKsvNCVjM8R+K4dRIp/DhgB5mzBIqTZmOBCAsCbqfonArbajpboPfN3LBbZHAB1bvNGBwW6MCqCyzbF/1c2h9Ax+B3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941185; c=relaxed/simple;
	bh=u1jdyBFTx1mnAmGJO/cs4bisbbsvKYatZvXXwJlg9Fo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbCIyB0ycz4sy1dP9jOzhydDjd4lY5Y0bUKOlGwO61uyX1/lBF2kNVSSJTkLo5NC8TquNfX+ilb+p95peu7G7vjhGYE+8qVDTkRAeutfo80DEcHvwsK8RZuL6Gz2+RwdcToNQuW3coeqQIpk2AvBj/aRyqfJzS0DAmhfTbgQl+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFgJS9MK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736941184; x=1768477184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u1jdyBFTx1mnAmGJO/cs4bisbbsvKYatZvXXwJlg9Fo=;
  b=BFgJS9MK1QTGyB60Ro5cUm6vAbFUD7jU+YD6mQhsGgUj+1aPYPgaiIai
   1flxV2Cs/Qsqo3/KH7nr+0gy2tLjzgQ76zZL0kHXKptCXDwzmjgHLADQz
   40xhx/Zwp3omc8GkDSIorzpxTdJtoLGQ5x32SCxEKab4+Wqw+yq8WiSdt
   BqH9hinY2K3tA8Xfv4vF2mvpt5W6Y7g0LRyyYMlhAUfJHOZ2K3vci7BBN
   R7LJi3sN+2Bckvb/10Enc359N89jxfMi49gNet0zQeCB56XHVdAYzOcMz
   dexFV8joveJxGe2PomsyKO8okm4muYNCeoea7zXE0Ee/vfPUwg8uKIScT
   g==;
X-CSE-ConnectionGUID: lpCxmJZBRJaLvcNp6SG0FA==
X-CSE-MsgGUID: zbp/qpzESKSKRafY+r5bfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37156037"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="37156037"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 03:39:40 -0800
X-CSE-ConnectionGUID: vTiQPS8GSpupZdJTNOp8hw==
X-CSE-MsgGUID: TvkftUZKSDGL9UHOp1DG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="105304083"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 03:39:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 03:39:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 03:39:39 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 03:39:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPdk7innCx30jJIIC9eABENd+EZhC6eatH+/ZijQfMocrOT/tJPwl1cPrwD2pvQtLI0OiTWgW57ItmXcfncDfBqUkDlzvrvP7raMraMQCDruQATRbDIBk32lx7RHehq3ZgZIkAm4TsGauqdP3rtW3PGF5v6NeDPNop3+yTXSEiBQ8jgZf2K1JsgD/ST9+WVLYrKzUGCS7dIgIQhNaKKDV0AQKnkmXwEGwH4WM+eHS5uADpouKbI1k/lb5Acap7XReoksa85jGzoba8B4MD1iI2NWvLfpnsWABVly5C+EYHymfHnG7mGXWzr1OyJvMTNWIBuz/R/Gjwsu1uiCOapaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z6lX3jrNuiR8wzQHalILygGGumNpqF07A6L4wIYGZc=;
 b=Djfejt+gvHu6b8j0TpwWuIUk25PAJELaEk2y4RilUe4VJyuYJacynArlIoOIVGjfJzFGTkYdlz7l0qsUXs0ZHrWbUwPc1hi3mLWJBF6CnHKh2mP7FYDIHatXv3mYcSbakGjJNZNRJcBfOZVWOYqWHFcwEVD3glD2iOVopqzTpen5JViF5Aa9F8GMc3+wr1X/HEqu+RWkVPCxR31t0MzG+xRs5iwlom4rVPSlkUlNGYDUNmlDgOs4GRs+0gJJCbZ+2tc98rm9y6LusbAlMdXC9u7LlB95k3m+u7LAvRD0fspGStyHSv/IU7OkH6QxF+MYFypN26VLC/CLKQOtAn7LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 11:39:09 +0000
Received: from DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::c24a:5ab8:133d:cb04]) by DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::c24a:5ab8:133d:cb04%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 11:39:09 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI descriptor
 registers
Thread-Topic: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI
 descriptor registers
Thread-Index: AQHbZv9tM9I70sqEbUy0Yg8a9+yJPrMXsu/Q
Date: Wed, 15 Jan 2025 11:39:09 +0000
Message-ID: <DM6PR11MB4610DE31C2D26BB4CB709341F3192@DM6PR11MB4610.namprd11.prod.outlook.com>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4610:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: ed33a93e-e4a1-4ec2-d87a-08dd355939f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nSgTdJzS5gT1g0dRm6MACi8QohXLjhxx0xTxG9Pj7SMool+2JcbPHmwzHJni?=
 =?us-ascii?Q?iy3NLHnKuSOqgvOhr04S4svcc/Zv5dPDcI3b1jjYF1oEYZr/TBRq+LLivE/W?=
 =?us-ascii?Q?mrnw3XeLIoi8WeCCJMmQSUPGBmOVuJhfhRiAlIDgyOvoOX9/JPVxHthWuBJo?=
 =?us-ascii?Q?Gh4Sdr76KrzP8B2pelPITuCnE7uIMquysrs23gZzfFdaMdHJh1GLUGoiKKGG?=
 =?us-ascii?Q?/BcAG6QVm2d4iMK6buhFonr06VkXFbkXLD8CU9lYnkrwcY5ejxlBtMZX0srl?=
 =?us-ascii?Q?P4Ot2J0aop8l1RE6sDMLoFKNLWXGJx6J3i6XYqdYKQoPbCXDUKQpKHlhq8oK?=
 =?us-ascii?Q?zZLzfENoep8frmk79WtQxDv9jz6xjqQcNIAIUarhWhBjufVjptZIp8zwEj3E?=
 =?us-ascii?Q?GoJDputliJdFvK+OulloroWDf+Tuz17qiuqD4QrjjOv9uy3QGcgdbV8lnSYo?=
 =?us-ascii?Q?E/ztd4rmIhNdZtoZ5Q1Z2L2mir+ldArpPHuByBULp56g/wamZZgOfgULTbNN?=
 =?us-ascii?Q?GANEPuWcpVFrjbbnZHatDhi0+ckrvI7vjDjG5RBXale7md0LY8Ggl5g9Q+QN?=
 =?us-ascii?Q?dd+54LpNhUZAkn8ywhFEnsbJRZK+wotsoCy0qggIEmulEG0z2kX9V+RWMPij?=
 =?us-ascii?Q?SgsNfwEaPX4GhFLs9zAj5KqGJ1QncE2nwPNp0wR2GvJC7nsUbf273zomKO98?=
 =?us-ascii?Q?JRp2uYyad0KZ69e1ftK2UWcA4E41mA4RgvNEfxlB/lAV4uemuVnlp4Jj+QFH?=
 =?us-ascii?Q?2tgAastmn1MN6iFqatKrzsHJt6yrS4H6G6LEoq+7iW9LWGibttTKk1XQUlnh?=
 =?us-ascii?Q?jLISXrRMnwtzlx8qmNcuWlDPmCz9tChFsODQnTR5HmGNltatBqP1TDCcULcf?=
 =?us-ascii?Q?E5yNoKz+Otgct864YxdabKWmkPx2mJaV6qssD70qeASJ3PPR7Yhe0iwDC4DO?=
 =?us-ascii?Q?4ld8Cb0XwhLFzOI7gvHHczVGcxJlbTflQd+Mnw1rmSbUx2IRJWbt3HKDJvgn?=
 =?us-ascii?Q?CAmFHeqtMxazUx54+oPTtgOAxGM0CQFYP+qv3oar8wr05z5QMDN6pDvIHVlO?=
 =?us-ascii?Q?ekaOJl3R3GsywhdHec8sRQP6Dsypn6YIxlHkVyGPCkHWHI3pLFVgQNDua+Z2?=
 =?us-ascii?Q?t+WB9gpTz+e4rg+VRND7zRNJo8m5e6iiGT3pGrotH4SYzFeVF5uIiEDlzCVw?=
 =?us-ascii?Q?6U6gcPtlCTSahuKip7/FH6dO1TkHY6D3vhye4jecLwvm7d6JygB2DhUd54nS?=
 =?us-ascii?Q?JCieFAUjSNSMBu02AbmAlMjj9VK1Jxe7SxQDpndZLihYPmn2MxGvQ54/6OB3?=
 =?us-ascii?Q?ojsB4bRmuznkyz6u/ycONaFEYLVbOFnylo47Ud32osree5yVKLOOj6oY4jRl?=
 =?us-ascii?Q?xQVlPYgQ8Iaz2KTMG07NRliXSKYb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BQd9rbIssV5tdWW0l/UcKIPKK8nBaUuYcgDFBhwGZMA0bZR9lOI+XMS5rJVx?=
 =?us-ascii?Q?s1KJGboVPrEVvTyjzTNEAX276sXLU+f2YjvsyNn5BaIFTT/gy+uGqBAv23oD?=
 =?us-ascii?Q?aznz73DMdzFsWHrrvlfe57LtUzn8KUUAnAGMe1/j9yDJ7k0xvDKtvT70FeuD?=
 =?us-ascii?Q?frI7XhRgF7di9IZZWQEhyOguFXLSKXbH8xaxx2OiQZA6SzwBkNZLv715aH/F?=
 =?us-ascii?Q?AoF85Vy0dQbPlrkf53WZDq3A7xCrmoIizvuOngzicJzXoziVDRyL4W2i4U9w?=
 =?us-ascii?Q?kHukBIHZDDNiLgD9wq31j2PyWqDLJ+PDyJPhibkVmr3CYyKNRgljwrSH/ctn?=
 =?us-ascii?Q?O1PX6r7lNPG1Ir1ejETAdg/PnHQbYitGr/BFgb+Gsr/2o6BQ7sw6a+LdmqWC?=
 =?us-ascii?Q?AHchAW+LTBBkl6j0FIp1+5ZQWCnfKo1PISD6cgMyIewI4jhmk554hjJ8b88x?=
 =?us-ascii?Q?4tcGORnGlbGAvGM94fgdYM/rDsZGCJU+5xsFq70p9eJLrys07lXC/fuy2o2E?=
 =?us-ascii?Q?U0wJTwtFjtXMwjpP7XxutiHN1OS378hCN8v/QQ8QR8AO3O9Zoae5zZiHk9bk?=
 =?us-ascii?Q?XFjuHKs418suHXLE4HFYmFCRayH/FioS5qWrFPqIqzf114fb3Bwn2kPMOVOH?=
 =?us-ascii?Q?73duIS3xPfW1oBhHK57ezFKEZdkO+aaSnfdVNN4G39p6wpBLAVfx+FW5rHn/?=
 =?us-ascii?Q?RDhCXu45WkF6Ly0dClubIr8xVtXnKFs15GPzrAMt3Kle31Y2A/j0kXHcTk0q?=
 =?us-ascii?Q?rRXPA+srz/3oz6+uCpYA3bcfMryqXrsDH5SKeeWBwMyEBK4G/Eajs79ngmEc?=
 =?us-ascii?Q?3YSGVp+Qwf1LcvtGe+u688ahwAGlrWauAfSE/1rirNxZbGSr9FYzrQ3atraW?=
 =?us-ascii?Q?XFtp7qnEcAcJPbfXRBOFekUKn4PLGsb0XnQWdCoLllHiJhBXbwPoWyLOFdwQ?=
 =?us-ascii?Q?41ToQcAGjoUWzRH1TL/d9a6vxyfOUHuRRaXURp+rXa4TWUSjfOR2ebCkeXt3?=
 =?us-ascii?Q?cmvk8lzPTPdfvuCu2tg8cgFJ1hWHCO1Smor1U6cndcjt5eSN6oeea5ha6msr?=
 =?us-ascii?Q?l4KvZmy2c3kt7ucG0C1lSYbwaxoRzHOyhdrc9pzPQbBxKXhylbtSHLhhBxLD?=
 =?us-ascii?Q?x/eQOvRz/tV+pTrHNwnFX/RmpfdAPoy2Q58RVkReKHu8ylARvZNkw9QiY4D8?=
 =?us-ascii?Q?pSz8h3GkXIk/zxsKSnPsie3psqNhU0KlrSys7C+AFSBJfJi+F2a/7azEM0Js?=
 =?us-ascii?Q?HNXQACw9hUuUmjzDJKTWsbbitpe5Ly2w8U1755kFqfKFTAKQP8LV9tACwVE9?=
 =?us-ascii?Q?+SF3vnPzPl92XcgjMBf+Zg//6lQQlc85ahWgsPFoaBwmTi5wxPXgCEJDPtWL?=
 =?us-ascii?Q?wTHFQNt4+iA30kbUUyKvJ8qx0ZYpZgTey29wNDGLxRYpNUC2xEvCLiRCBtKs?=
 =?us-ascii?Q?UYJUwlpFMas1CFfRZCoDPhllXzNPIdNNbSbq4ORtnlBWIrCXQZNDEi/X3jRs?=
 =?us-ascii?Q?QDlDHAzAvOegCEBecqKjIIbvQVLfyHmbvfT1l9QoJtiRDORzOHGiik0XQxFS?=
 =?us-ascii?Q?BVNt3lBsTTa140Qz56tuUzAbIcCEtYCFQB8QBVMP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed33a93e-e4a1-4ec2-d87a-08dd355939f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 11:39:09.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oxcV3vmKqHeUVG51fIxPA3oEWi1NJy71YebNBmqAWR/2fzrQuxogu9mBAPO2273XWD0XiD7jNGm4GoIeo5kqGV3EhW1VWGfztcOm6ZHQwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>=20
>Sent: Wednesday, January 15, 2025 4:41 AM
>To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <p=
rzemyslaw.kitszel@intel.com>; Kwapulinski, Piotr <piotr.kwapulinski@intel.c=
om>
>Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com; michal.swiatkowski@linux.intel.com; intel-wi=
red-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.=
org; Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
>Subject: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI descriptor=
 registers
>
>The ixgbe driver was missing proper endian conversion for ACI descriptor r=
egister operations. Add the necessary conversions when reading and writing =
to the registers.
>
>Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interfa=
ce")
>Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selecte=
dIssue=3D1602757
>Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
>---
>Changelog
>
>v2:
>	- Updated the patch to include suggested fix
>	- Updated the commit message to describe the issue
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_e610.c
>index 683c668672d6..3b9017e72d0e 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>@@ -113,7 +113,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw =
*hw,
>=20
> 	/* Descriptor is written to specific registers */
> 	for (i =3D 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>-		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
>+		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), cpu_to_le32(raw_desc[i]));
>=20
> 	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
> 	 * PF_HICR_EV
>@@ -145,7 +145,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw =
*hw,
> 	if ((hicr & IXGBE_PF_HICR_SV)) {
> 		for (i =3D 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> 			raw_desc[i] =3D IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
>-			raw_desc[i] =3D raw_desc[i];
>+			raw_desc[i] =3D le32_to_cpu(raw_desc[i]);
> 		}
> 	}
>=20
>@@ -153,7 +153,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw =
*hw,
> 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> 		for (i =3D 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> 			raw_desc[i] =3D IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
>-			raw_desc[i] =3D raw_desc[i];
>+			raw_desc[i] =3D le32_to_cpu(raw_desc[i]);
> 		}
> 	}
>=20
>--
>2.34.1
>
Please avoid the closed external links in the future. Thank you.
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

