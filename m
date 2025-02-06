Return-Path: <netdev+bounces-163565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0BA2AB8F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A8C162E87
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4F23642B;
	Thu,  6 Feb 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGH2jn4F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000F236427
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852690; cv=fail; b=IATIfjricmKVcV3GX3LMw4fwx05YUWcNMDS8u9tYquqJkCyPhrtcRVsx5vM9Qr68Mk3aPJzwapEmNG/DELBsRPL4vA3SIgkPlVrG42p8iKhfgyMuaoIYEBJFSRXnQvIyxTxYInnmJAjqEqxzM/WLqgEROGAaIJyVkJFRwdOq8uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852690; c=relaxed/simple;
	bh=2wrXjwQL+QOoAa4nsOSEvvkIe3F3JxCwhZpYCWoNHrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bflR4bU7ysusFgjp7JWbe+G2N6E0AyeEC5G8zL9r3KRZev882DXt+WueGBFphJOov7+lrJuCgEmGKVTDQPB4SS+6mj9YmQfzaT4U1tQj3TW5SUGtHtrH3CYyKPcIAtEPppF5eIJpeewyigEg2RQyA+9QqKmpNK4rp6HHf0+bmh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGH2jn4F; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738852688; x=1770388688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2wrXjwQL+QOoAa4nsOSEvvkIe3F3JxCwhZpYCWoNHrA=;
  b=IGH2jn4F7+Q9xKo33pb/ogbAG7cq1WkGfBigrHceq4ecDfvuZLg0prk6
   nJaeaKXdYNR+ES4t6Lx7SCkaEhNh6QMgVmFRR1t39gBLqIvXK9lmALnw5
   oixttV1SH4k4g81IBhlWjwxxE/ijmUSOUMt7t0WgFD4TkzctBU/EZzBpB
   dgBUO2BTUEc4lhalFGZkMMQKhYAwhy8zisA1dFu6psrLrPYSdeHYhDSRa
   txhXXyqCOIEp0DjmQVJzXmmBrGpvr87hc3cBoRacn+YpNfK9J3fbMgj4X
   8WtBPMsOj1D1FVOW1ZtRzhWJUWPW8jf+zJ9Bs9zaPlW0QfPXmJTyPI9DA
   g==;
X-CSE-ConnectionGUID: ipXrlIazTQyPnr+1bwznPg==
X-CSE-MsgGUID: tZg43tJhROmf/IJfZdOA/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39570932"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39570932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 06:38:07 -0800
X-CSE-ConnectionGUID: DQ2aEeY5R72LGvIzdXYLow==
X-CSE-MsgGUID: V219oZRhRj6Xii+epBsy4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="116256404"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 06:38:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 06:38:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 06:38:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 06:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1s0Bt7MijilT7QCdEBjhyxCCNeyv6gosXe1V9B8aYrcPgqVb1wqLwKCxWnkXtdbquT7YoAQYG745VGM/8TZjhdVmTGRvmoHFjCXmBLmrTHNnY/p0ETgk7HkApJfvnjN/cp3tty76HpWgqaV7CufUSvRED0WcQnyXWzAHXhBLnljQwwkNdBalerfNVy+jt+9ArYQSQSAjGFWvKrrKyswu2ZaiB63M+ic2eJiHXazv88HoUUslt3Z9MNGy5QRCBu8o4H96aqeO6q1rULOuyksUOXJ6muLXX629o9zVPYHqphT7Xlh/60QGvKFUzqFWmhOuK5A+J+UCbe+8OFR4B5T8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC8caHR+UaOqnVfxOe2/zaix7foyGuSEJMvGJbc8lks=;
 b=lKylD78WNKYlZRi6Moo+z0YhZAvvivDKUx9EvWDdGsPfRexfWVHXqtqrSHncfxM7Fzhm3Np6yEZahUnpKsZ/qvC79mueaMQisuZyKiddWr8RXV1vpIdJ98k/p0JRZF7USxF233Vpoqlw1RlTBOZF6TqUDju7nwuGkITo5zT9qsKWSPzWNlf9p2dFzg5tDwvVduAlvtYFkmEYkwNIajbExYYZg0cZnVMhaDZbzzM7mpsSzL1MgrYoBtZ88e3SHhvY3TAcKgjbjjo0eiPKk/yyQlhBHzUnJ3HBVt9RDIiWegCRMEQJhAGuTnnJFN6Ky2CE2kJbiFVngoNz9ALMNhCRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 SA2PR11MB4890.namprd11.prod.outlook.com (2603:10b6:806:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 14:38:03 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%5]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 14:38:03 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next v2] ixgbe: add support for thermal sensor event
 reception
Thread-Topic: [PATCH iwl-next v2] ixgbe: add support for thermal sensor event
 reception
Thread-Index: AQHbdta7xAZOXWLD/EuwSFeTRBNAMrM3HkcAgAMhq9CAABD1AIAABhpQ
Date: Thu, 6 Feb 2025 14:38:03 +0000
Message-ID: <DS0PR11MB7785A56D5CC627637A4B5E3CF0F62@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
 <0a921f6c-a63d-4255-ba0e-ea7f83b8b497@lunn.ch>
 <DS0PR11MB7785AA7575BBA0E6FD576B31F0F62@DS0PR11MB7785.namprd11.prod.outlook.com>
 <0b81ee70-efe3-4a06-b115-1a56e007b9a7@lunn.ch>
In-Reply-To: <0b81ee70-efe3-4a06-b115-1a56e007b9a7@lunn.ch>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|SA2PR11MB4890:EE_
x-ms-office365-filtering-correlation-id: fbbc14c4-ea6d-48af-2f33-08dd46bbdd03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?peYJXyfak8Kfwr14IYNk/hMTyS08MsuY/d5aeYvwqkPJ/Eg+KWqkGEoPzM1j?=
 =?us-ascii?Q?R9Vk1yJzxTLzJRE+nrePOeK73nANY46zA6UEGDmZkwkX97MnkGqcbh1U9bLU?=
 =?us-ascii?Q?9uilajJ5YsRiHrv5ZjqYJJS712Vx93wWL8Ht0pxLie0Vu+MQIHjCjtrC5Qk1?=
 =?us-ascii?Q?DqWjiQoswrBKi+ix1OjghzGrRej5Pr+qRZm+lz6xCkLqrXYker4diSe57g4H?=
 =?us-ascii?Q?w6JPL/bjzoWpbYoyGpPPkrvOqXLR3emQso2Ts5BWZdlbXWWbT8TZ/ZPNampA?=
 =?us-ascii?Q?NGncP3gq24+qs0DpMsm3QlOy+KMt31A3qIn9HVY/M2bRZCoyfRiiieQwrjMf?=
 =?us-ascii?Q?eGjPoqR+4N8aof23b8MbfRpsSEBEAK041GAVfV4AOHXmpEg6HbDJNb/gh71n?=
 =?us-ascii?Q?7El0h3DDwAXA/Aoh40/BDljJeqzPxH1r3tt7q1Uzru7CNboUZ8YfA7vIvcw7?=
 =?us-ascii?Q?GQvGNYf4gVNZNu0u5kvA26QO9qOqjPKGrcEakmShbMt7xIX4ZtsiggAWfLOe?=
 =?us-ascii?Q?GHdlvK530ksFwSCu2IHy8F/4L2Ar4xa3+Vtr2G+PrMrDAXNv9bGEeuKfi7YB?=
 =?us-ascii?Q?om+tQk93As7b0fN84G+gF2RrHjFswTYLA2EOWSsrePBwe/lrYQDPm534kZrW?=
 =?us-ascii?Q?xukdhsyT038EpUKHgz0bNcPDvn6iUu7jYr0V0vsk3XHjhCEYRf0Ot9gHsXfS?=
 =?us-ascii?Q?JdFFvALoLCbWoJdXYBmkNsUwAPYidMEyANtyeTmuw/xsIctaO3joH2OxZjS2?=
 =?us-ascii?Q?zhpwP29lgHz/C/L7pFIWC28rskWCKq6kkCl6d7sUVEHj4zOZRGBGE9CdiV8w?=
 =?us-ascii?Q?basNCl+qtkqUKpf4+vI4crJQjq5GtvWCYPK9RleYULDBjEDpbM4ssbVDgATn?=
 =?us-ascii?Q?AV7CzOurQtnKDxl/q5z9eR1TUTg/prF6078MPVGtR2I2+oYtE3afEbv+eIeN?=
 =?us-ascii?Q?lUfEtJG/rGVFy4vOybEy35So0Ue9XD+PzLnU0YN29w3E4/1OQsx7uyqmNqCZ?=
 =?us-ascii?Q?+QQG8/pBnjV7HBZbabfKwGdb9Hja+GD8IheYIV9M14pfdQRbcA9EcguSHTsp?=
 =?us-ascii?Q?0bgKNIk2+wkYe/Cl97FEzEtWauyoGcWrQ0wurqqdatfuQxa/sfOYLDiUxId0?=
 =?us-ascii?Q?2mGtXqtMZhucSIH8anxcTd4V4hS1AttKMpU4frTti72j/lckzd03NzGkhjg2?=
 =?us-ascii?Q?BCTqArmuXCIKw/OhloPrKaDGH4Bspl7ID11PAzrr8LubH6aCiZOtuZiBRJs5?=
 =?us-ascii?Q?+rlTOn5+8PUDRPsq7hFTSkg2ah/5FBhIbQhhyCersFTYmfFl/qsefKrY2339?=
 =?us-ascii?Q?WDkGItLjyH+evZFw8Nt+/PEzmQgHwKRAnPuC2MQ9MifG5w4DSyl2uwpZPiaK?=
 =?us-ascii?Q?4ynBtOX0YZQgEAmCA3YtU40ZWJ2lZZV/0Idw1FYDbRU+vl5oTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A2wqHrBa8cfs1H75J1J4T7Tc6ABnw05BK5Enhq20G6S69E28h9loqu3Wdshx?=
 =?us-ascii?Q?Uc2kHhNZdEhs7PhTRro7l9vgsPPiKkoJ2vdQ+hBS07uretHNOls3+QNqojdH?=
 =?us-ascii?Q?zS8m9qgHt/cHK92FrrAPIp/KKLnat4tDHhLAa3P3rL7PQUQP6cX08GQ/rlKr?=
 =?us-ascii?Q?D2KkM7PEPZzfAaHjX1N3o2Qaq/SVNsVIPmcT7bCNhNpQIaq7+hUC8cDJVXKe?=
 =?us-ascii?Q?+m7KIjpbRVPl1dwZWPxe7IEhN+j/AeXTYqYIj731ZcHbFEcvmDMGGCDv0DEU?=
 =?us-ascii?Q?eHF8bcyJVKsIrLdr7Lf1pwlOGFKAR0+8lSYhc8lYWOv9dA/gdQ8AaQ3Z0DN/?=
 =?us-ascii?Q?ve3YlhlveTxw/CLi6QEy9kORZ+c0geO5GBBLpUz0kJA8SBYGGekeq4K1vxNH?=
 =?us-ascii?Q?Qeft8+xQLNMNBSZjfqSO3dFvDOXRSeTPQb1qJdkF19LUq6bHedrQYWZFLUYN?=
 =?us-ascii?Q?dGfLdipx1TErc4GeL9J2m3ikkqMlGD2/lkZzlxHyvirtw1F1glsskRMCA8kP?=
 =?us-ascii?Q?KiiMQqcXhlLD9mYb6ALcevyQUTHqlYD5G7572pXbmjr/KYScb46Ww58vOUYp?=
 =?us-ascii?Q?upN2JYL/XW9jl04mrgoMzsZcEBRo58ns8r52Kj5I/BtjUiDyWK/hntKViVys?=
 =?us-ascii?Q?TufUhBUP13BCAZk38nJrlRYHalDso1drB+hdLYHCql6v5JoF+GJeW0KRwsyf?=
 =?us-ascii?Q?lZiOtREDVI3BRwixIQrBRCFlg4BUZIunNdSc7j8+nXc23zFOUlZ5/Tfr+AmC?=
 =?us-ascii?Q?FRQJVQUiRfm+ngOMGKfgZcx0/lUmRFIslojGO6MDA3nCB0+mT1IHNbDAC84t?=
 =?us-ascii?Q?wgcu8+SyEGEhh0yXpASj82EhaFqW0Z79/cqy8FUl0QQhoTgGRheEluAyt0Ju?=
 =?us-ascii?Q?GsGtYClTJG/0mwvlhwWC64W8NmYY+bQdNcVrCrlmYt70qBh762cqB050uB5p?=
 =?us-ascii?Q?f13mc1fjwL7p2Aa+DM/OOnxHZNDtEqztIF36egHOi6Mvv75uifYLnWdIWSRd?=
 =?us-ascii?Q?ixZFanVoayWqAH3q0f0WnYMk/CInQGjf/Y3+Y2xGcto3gbefrEiWmDmA0twb?=
 =?us-ascii?Q?ihVm0BFo3KYncj/ZYc9PH41uDloXJg81fXifzEVDo2dSnW9HCnmKGzhiInXA?=
 =?us-ascii?Q?/P4l3UqulzLHPL/UQREHlEj17Ex1vMwOroIfJvbwxSJb9h/XhZ4sqsFcYw6v?=
 =?us-ascii?Q?FweavAJtzJCXzvxhVRVi3RaBVOpUMAgBgvJ6+T0zhYjq6JofLjBbC2K1GU1x?=
 =?us-ascii?Q?2jVycO0fUU6cNcDlewP8kuqdCAbzahHaOY8s9+uFcjvXxVgZP0bm6zSH8um/?=
 =?us-ascii?Q?qAycybtMgO/jFaESrSLv6vK0YwaFlPqb0cslse43HkrFC8R/ZYEY9Nc/9gRz?=
 =?us-ascii?Q?4DaTPqMcD+pa9H6OmwZ/6WVuct35gLZXV8jSzzdeUxYFuKRDAFrp8drCvRKB?=
 =?us-ascii?Q?XCdkAko4AXnJD/eyMQeyswl4z2Ec2MilcbPtVKFLCeaMMoDGZoSE/Thj2dDv?=
 =?us-ascii?Q?I0P1jNXb2tzl02rF4hbu4WUGVcJdr8+3JU0r++8xiPCX3RdxccBXBZJuWTsE?=
 =?us-ascii?Q?+FsTpNnzgaN8JGM8qnVP+NHlRD/Sq0A+M1j5f2qb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbc14c4-ea6d-48af-2f33-08dd46bbdd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 14:38:03.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRfGCUFGka5KsLxRUlmo6wVUls9mZedbYF4p5ncdx8OAjdR3xD1A+K5BVQel1RKvQl+AajNIpJwtclJWS1XSosaguQvyTXksWZlubnC4/YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4890
X-OriginatorOrg: intel.com

From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Thursday, February 6, 2025 2:59 PM
>On Thu, Feb 06, 2025 at 01:05:27PM +0000, Jagielski, Jedrzej wrote:
>> From: Andrew Lunn <andrew@lunn.ch>=20
>> Sent: Tuesday, February 4, 2025 2:09 PM
>> >On Tue, Feb 04, 2025 at 08:17:00AM +0100, Jedrzej Jagielski wrote:
>> >> E610 NICs unlike the previous devices utilising ixgbe driver
>> >> are notified in the case of overheatning by the FW ACI event.
>> >>=20
>> >> In event of overheat when treshold is exceeded, FW suspends all
>> >> traffic and sends overtemp event to the driver. Then driver
>> >> logs appropriate message and closes the adapter instance.
>> >> The card remains in that state until the platform is rebooted.
>> >
>> >There is also an HWMON temp[1-*]_emergency_alarm you can set. I
>> >_think_ that should also cause a udev event, so user space knows the
>> >print^h^h^h^h^hnetwork is on fire.
>> >
>> >	Andrew
>>=20
>> I am not sure whether HWMON is applicable in that case.
>> Driver receives an async notification from the FW that an overheating
>> occurred, so has to handle it. In that case - by printing msg
>> and making the interface disabled for the user.
>> FW is responsible for monitoring temperature itself.
>> There's even no possibility to read temperature by the driver
>
>https://elixir.bootlin.com/linux/v6.13.1/source/drivers/net/ethernet/intel=
/ixgbe/ixgbe_sysfs.c#L27
>
>ixgbe_hwmon_show_temp() is some other temperature sensor? Which you do
>have HWMON support for?

This feature is not supported for E610 which has no support for reading
temperature

hw->mac.ops.get_thermal_sensor_data() callback used in
ixgbe_hwmon_show_temp has no implementation for E610, as there is no
such support from the FW side

>
>Or is the E610 not really an ixgbe, it has a different architecture,

ixgbe is used by several adapters, each is slightly different
in this case monitoring stuff is pushed into FW

>more stuff pushed into firmware, less visibility from the kernel, no
>temperature monitoring, just a NIC on fire indication?

yeah, right

Jedrek

