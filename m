Return-Path: <netdev+bounces-187789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30185AA9A49
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676BE3BCD1E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397725C6EA;
	Mon,  5 May 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo7o0BRk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC71A841B
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465654; cv=fail; b=qHkdHdWTzk93YaaiwpvR/qC/dXN2aXVAR/9ay+zzqyJkTrJy8Yw+WHN19F/FucYgOz3dBfvZnMiD7xtNrVXSWc+rdqMlNv+oPRho9s9cFjXlFkMUI6uvKD0GvbDAMqutFttEVBUfUZhfFZH11Ksm7xlmGvsD1VQnrb0wKi04ADM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465654; c=relaxed/simple;
	bh=7yrqu3dS07NcmOygaraPPT8DirR5g0qK9/5RCcueI9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SOuLZp+2zBwo4fOZYMtL2mnLb8TAII0emK7Toh3AYttN9k4rUAeBdFVvyrSzsxd7dqHQ7WUC7OOCrPzcjk8kUJ9xyXHwjQYedceXbm2DprfY9SPLDykqva9r8FnMYZ8ElRirUM9hfQT9fUhNjDP/IVxLK4ASQH4eDIIQZPlunVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo7o0BRk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746465653; x=1778001653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7yrqu3dS07NcmOygaraPPT8DirR5g0qK9/5RCcueI9o=;
  b=Wo7o0BRk/zalELzAUmfd+v7F4h+88b4dXaG38FY0PyDNJNpOCGF2NXE3
   L9SxrXdUOeq7NohLNJkMQPVNmfrvQ5Rpb3BZyJeuZcMJW9unYxeBFaYUO
   Kyzt+hE+V3X19SoP+qhoHP6WEjJmrtINAMHIdubbxqUOYp2fdmS+FuDZJ
   Rcs5NYmDXdB7IDO7JEL/92XZFA0cRK/FqSxiuX8XD0+vfqSDxkOvlo/Z3
   nN9b1XS6oLzBi8cChYOvvrBNKRgKdpAVvh7Ru3VolJPLQNVLEYqueVE9c
   GOFSbBAinkItFvjGqQYoosV5Yg80W9joE9MIxemTYzaZ9zZ//SYb2Hp+f
   A==;
X-CSE-ConnectionGUID: KRz79djqTP2xqv9xzVBIKA==
X-CSE-MsgGUID: qDpviIdWTpujAMoCYqNDxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="70590796"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="70590796"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:20:52 -0700
X-CSE-ConnectionGUID: eA+43P3rS0uHO+VLYpEfmQ==
X-CSE-MsgGUID: hnw0spcOQ7aKb5f7k/oLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="166369139"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:20:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 10:20:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 10:20:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 10:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBP2o8S5+TtDavPEmXAMAR+ZRoeOTg4FNkEclDQK/MKmpi4jO4zZKx5FnZcf+bglec/bTYW2Y/KDnH9jcWVux4f761X+cpDIwnxG7cSkthZiCuLAF5k8mlI7Uelwl2rGbNniv7Y1C4kY4wyovcai3OkLLUpQLdsRGxFq5Zwex5SKIZSIoxlNFwZxJhUicXkGfRbDm9IVmmzI1wruGAq4Lx7qE3s1ISywGBFgvub0I/cencFukeTEwSohJwlzvrSW4p5XQjBGEOCYEzSTPPH2cGsFybA5On5FXG8Jbw4CCx83iyZt4My1BqV+S+a32gBAUyGi2gs93AFE0IIgr9ek3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxZV4Q47qIYfj/PfcwJLT95gsPhhwXlXeei9G+RezR0=;
 b=TxLLt47qT+DJ2f7BSmAvHVneIM/7hjcPU8JnIXGHwFXLWvOPVqfZHzu2pZd4w1YOe3OYFlGjMVRs4vGI4cmmto0NFsFVHE3BNkxQB/DLlmtQajR6OVjF6emdkS4cotX9/WDZtpBqWpvRw5rQ2SNQwI5plFaeKVF1zFswbs/oLDBirk6/NlOtuKDP3rrAcb2M0SEOmkUnWkVZy776WkMc+38dtU/+OZgnkGvWZkpGwrELgcRMRSDSypuu5E0aHAGokQM2s6YA7DmG/OvsCgm2yamt843wGIPpOpgv09oBm2MzFRYQFG4sCGdkyvi9KiEWq0IkZNv3NaECnuWq5a38pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 17:20:18 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%4]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 17:20:11 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Thread-Topic: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Thread-Index: AQHbtixghtBT1IyYJEugZ4El30KEQbO50eAAgAFgtgCAAAMSgIAJHzlg
Date: Mon, 5 May 2025 17:20:11 +0000
Message-ID: <MW4PR11MB588916A3C03165E0D21B73528E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250428173906.37441022@kernel.org>
	<17fe4f5a-d9ad-41bc-b43a-71cbdab53eea@intel.com>
 <20250429145229.67ee90ea@kernel.org>
In-Reply-To: <20250429145229.67ee90ea@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|SN7PR11MB7065:EE_
x-ms-office365-filtering-correlation-id: b6ef3b18-e338-4122-f282-08dd8bf917ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?91//y+adG+XJCk8+2cBahoJbV3wVurcSewwTuoKhBVXw/0TPjthfQPH1BE29?=
 =?us-ascii?Q?3m0dOnTDT7GZb8VqJ4Qo00qkITRkSss2OScwnKRZKKn+ev4mqYaYSgwClwGn?=
 =?us-ascii?Q?IixoiQh2O5CXurpLB/V0oJwxfITVo53XJ0KR6Pd87ehgY1+RKffjzeb0xbyV?=
 =?us-ascii?Q?gwJvOnWMy/8g3j+60r5qcXtztXvLpY758Po3jilz/53SWg8jrvHWT7sL/RfJ?=
 =?us-ascii?Q?bAL//6xKk6ISHGkoQZ9BgtFNLftUkrIZR4HkYXgsr+5T47pMshOlyP02E35x?=
 =?us-ascii?Q?h8C8qrW6/JA1QM1r2rSZ2Lp9i96WIPNaSqu2rW1yXz0Q97WoDYsDwQZ6fHPQ?=
 =?us-ascii?Q?urku67JYH1idxhrcDtuiq/pJLmBk5Ur/DaQgu10cKK0aCujUZPpxyVQ2Pnce?=
 =?us-ascii?Q?J4n3c5pJre+khmGWwEJq8X5v2nfMBJl8uhsNiZNAsNWNqxoyxO/kGgQ0C7vC?=
 =?us-ascii?Q?s+R5VpFUcNXKVOfL0iXNOnBeoUzToVGtzuWh3RSFhP+rnLDhnsAZ+XkiGXsF?=
 =?us-ascii?Q?uU0QZMJzAgUl3/qBzn76JdV2lH8I9S6mW5ka+KaeyGHQ9WhJ/z0I+gji5Y+x?=
 =?us-ascii?Q?n0bBJJa4SiEXPRmoBUw0sU6wZCixrEzKUHG7lHxHwv3v5dY0UKT5DAGIWCjo?=
 =?us-ascii?Q?Sd7MAwDacyXebXEuHeQ4OVum8/kX/aPW1NDi+6tr0t0NE31mxqhHc1tPWWJc?=
 =?us-ascii?Q?nzwQAjNbzPYbksZzpw2A/YONacV/tu0iz7wOD6IxZR+bcto2/MwYBWyLXWh+?=
 =?us-ascii?Q?ErFW7Jdvrs7WVYt+DysriS+yPbCACqb6VVhQCKLjYfzZYxkPpjQycirim2dk?=
 =?us-ascii?Q?2A1bBlM/PsFq3Gc8NU3QpAfEkDWjGDzAi1NekFusSdxnAl6IlIhR4TLBhxeX?=
 =?us-ascii?Q?TdQgk6b3bpa+Pri6sl8mTv9lgJUhf1cXEi0VxMOmZmuFIfAVRQthRwcznkuH?=
 =?us-ascii?Q?nv0lSRvfFT7Ndfd0Q3OGtBTMmYFoD2hpXnIQvQX3tE5uGcyGV6gUceD8/t79?=
 =?us-ascii?Q?7rGPFicZIr3KKQAWpFLEm10cfhMS9k5K1KAzFe/p7v95B6OYDTxdLbVsU6p6?=
 =?us-ascii?Q?A5AcdeVHFwBgBYqDfVbZbE5RQpzMt31lIeRQFq1Bq6SZOZgLJVJ4sEXeohYE?=
 =?us-ascii?Q?78Uoi53MJ5ze4qg/pjEfpp8HhYtdig6oBTsokPZR1uTBlgOCSl7MSbbJ+bkF?=
 =?us-ascii?Q?DGfmCxaC2lYTM5Z1zsuFd0/ZfAYq0fP1ByXKW7VNgYU3iD0KL54xVoQMHKxa?=
 =?us-ascii?Q?AXVqHAt2z7rAL8UdGJlkEBJqTF8qeiEdiSPNF0Sh9v3AaVI82raLk2GYePSZ?=
 =?us-ascii?Q?uVaMfG5mtrQggwn1A4Tfx3VJKfjS5b7H0Jgqid4T4kXuLjRHuN/AJUII8U3P?=
 =?us-ascii?Q?Jf2Qa5IZDe5/VDsp9xPR1HVhdD/3u0Ci+a/WgQkPsSe5mMQxVN6jmf5Bx+5I?=
 =?us-ascii?Q?PuVOabX/mM3IL7XkyPXSUp2XzjvCtPbSTEnHxTZvqdscre9FcB6DOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j+Jkfg+ZrMFODqt1BBnm8rHZAGgXqOa5GsTsjcHRp7R8DKXuJtyhAa8QIj5L?=
 =?us-ascii?Q?OVRDCEVAc6f8NaYjINLlvCrv9QHAzM4fXJjXgSXT5IatVo+668hcQWow0uQj?=
 =?us-ascii?Q?D8KS3OCIlA9P0K4rBnY4YnV4sDWlaVVl5FZHUiQ8n2yJ0oLNw+aRat7QuuAH?=
 =?us-ascii?Q?iTJcCLOl2TWOHDZhNoKB+v1Ue/f7BbO3d+DUKqv4wJ6y9dDKNLE9OUU45ILd?=
 =?us-ascii?Q?B0z/YSx9YId4DfGBSFBWuFIWQ4Rs04glPJVXKOqP6oAwa2/5y5szDZHvdiKt?=
 =?us-ascii?Q?eQ0u5pcXD60vwAHEl28mlGLzl+iO4vxckLx13VvL/dA3Jg+o7k2YmOt/vqZK?=
 =?us-ascii?Q?2v7tYGMwzqOcXun1r11XZuaMZuB/OztQVd8QmHpgCqSZyPjDn5GlbGIRoHu4?=
 =?us-ascii?Q?0DhCbEVajJusyZ0Un8N88+t2CwwWTz2dFamdt821B7tJtl0hAOIWTn/IhXMa?=
 =?us-ascii?Q?K4fG+ovMKo84kyN2VpE8wikFynDQQh/wPpgw3vh0MpS1LkTBXam6PVkimnGg?=
 =?us-ascii?Q?BlkbyoeIXgzSX3tYEyjVb9XFHYZlQN0M8DllGxFgBWQTt+FOXDrPKRDvO6b6?=
 =?us-ascii?Q?voi4LuCqlVaIeTWFJGPQhoVZpdHLfqC9K+PgJHU63U6i7guhNSUQ9FQ8ge01?=
 =?us-ascii?Q?YyX+BiB3cP4I4J7RNiIxZhlbi8rUF0GWUbT+HyLUmbcnEzkib824caVCQVdE?=
 =?us-ascii?Q?hhfamdNjt8i7/C8OMn7L/CoCplBZ4DsLYrvy1atF7Gpwbnfm4AhSaAubiKN3?=
 =?us-ascii?Q?Rz1FD6iIMkZvpCcZOwOYtCMo/0i1ljgk/8K/8jo2AsCHIlSp1C+eCZuQdDsn?=
 =?us-ascii?Q?8SB4nJkyfNozrAO3wAC7/1wEA3ncYMt3IF7dJqWZQhcTCrbRxntabjzLyg38?=
 =?us-ascii?Q?GtZ7mz7SJNfZhOFonowuBoHx4EB5is1W9YRZ1lJzAGf/bhP5DBVozoWSGZ7u?=
 =?us-ascii?Q?v9W8T03RpxPxgu5xokg/b4h4zzup0FZeLO6ka6MovbHfvFmG+Ut+Xi+qQg0t?=
 =?us-ascii?Q?q1F0d/JrI0XursLTKTanuFCBxG9NyjSJ5W9akblxE9Z8G7hG7SE8l09oh51b?=
 =?us-ascii?Q?EPB0UWfRgaC2a+2CC3K6XXTMgZRLTDyrDbeUNkG12LUBV7ba9PGI8fXExKTJ?=
 =?us-ascii?Q?IA2/qphO4tgEMy+eoR+tbJqfo+2oKlAv37WDSdRueX0fufdsfnwJoyDmrXpd?=
 =?us-ascii?Q?MeyF8o2GYjZotszJNBQClb+3im2woFoqHf9xWKvSG7d1RwdvUooQJIXJ+8AY?=
 =?us-ascii?Q?VTciolOBqZ1/gX79I70eC6fiHBMd3gZECPTyK6Om/PlF45rqooXEqMjB8yC/?=
 =?us-ascii?Q?alL8ZY9enrckkYPf7XKNEGLzAnFhjnhsskirMFv4g1nPNdLEWRknKG33N1ID?=
 =?us-ascii?Q?YGf8wBd5qoJ/JQRjdg32w1EbPKA2q9DLk+pJIeZHiYgNyFw8TdwbxKEf9MYe?=
 =?us-ascii?Q?z37PorYHR5BvecbG+I2diLDTVE9YPTVMvyOsBpw9JfK+v1lSyJU4H+MUovgj?=
 =?us-ascii?Q?3uIn3e9mbcJKfmPKIi2oGfM5kBho7d2C1j3lJdo5aJcI8CsV2xeoxgZ7yq+p?=
 =?us-ascii?Q?K2xHXDZ8JpgacqScWn1uEl7JKH+EsNAmvNH6OCun?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ef3b18-e338-4122-f282-08dd8bf917ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 17:20:11.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8TCs6XsRBk7gpgSKtNzXDC4Smq8ARW4BGYWvfSlIiGwwafpw1COGa+0iEFIoewh28y+gj9lSP3qT9fFQkGcIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-OriginatorOrg: intel.com

On 04/29/2025 11:52 PM, Jakub Kicinski wrote:

>On Tue, 29 Apr 2025 14:41:30 -0700 Tony Nguyen wrote:
>> On 4/28/2025 5:39 PM, Jakub Kicinski wrote:
>> > On Fri, 25 Apr 2025 14:52:14 -0700 Tony Nguyen wrote: =20
>> >>   18 files changed, 2933 insertions(+), 103 deletions(-) =20
>> >=20
>> > This is still huge. I'd appreciate if you could leave some stuff out
>> > and make the series smaller. =20
>>=20
>> The obvious stuff that jumps out to me that can be moved out=20
>> easily/logically doesn't save that many lines but, perhaps, Milena has=20
>> some other ideas.
>
>Right, nothing too obvious, maybe cross timestmaping. But it takes=20
>me 30min to just read the code, before I start finding bugs I have=20
>to switch to doing something else:(
>
>It's not a deal breaker, but I keep trickling in review comments 2=20
>at a time, please don't blame me, I'm doing my best :)
>

To have fully-functional PTP support we'd need clock configuration +
Tx/Rx timestamping, so it will be challenging to remove something
logically :<

The only ideas that come to my mind are:
- Remove tstamp statistics and create a separate patch for that
- Split PTP clock configuration (1) and Tx/Rx timestamping (2)

Having that I still need to implement get_ts_stats (more code..),
maybe we can proceed with basic PTP support and focus on working
Tx/Rx timestamping, without collecting stats (ofc for now)?

Please share your thoughts.

Thanks!
Milena

