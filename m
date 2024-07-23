Return-Path: <netdev+bounces-112531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C490939C39
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9EA28326A
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB314B955;
	Tue, 23 Jul 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nn2t34gJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56510979
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721960; cv=fail; b=t7H45Jg9WAjjgG6FkgYpd5+GRY92wKthcuyI8Ep/9N9EcLK5LRXNWAn6VjxiaqeOs95ptHVjW4lL+CSBn1IyMLGDCBamQnjgVVbZf3MH7IF8jLgMQmnOP8cKYReNbdiHLThEyITF/Y7Y6Rbzc1RG5SD40DyDcuVmfw2Bxpeb784=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721960; c=relaxed/simple;
	bh=V0BL+n0OXnmLQlFEfgu+XRrgwpoj697cmOEIxTIM7Gw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9W0d8ucMgS6jagfQwaoaxjpFu1jSQahod/Yjao8gxWqd5QqWU5rMw8UEH35050dkFGh3ChZj3Cuvp/IQoT1OUYdkOZFmUY9gHgI1yZLXcy35WSYPIorPz7l/fId0X6k+IodgBwsnGd+v+KGfygM30n0zyDjvhOQvobLj/VB+30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nn2t34gJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721721958; x=1753257958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V0BL+n0OXnmLQlFEfgu+XRrgwpoj697cmOEIxTIM7Gw=;
  b=nn2t34gJ8uf6SUaLAwxIYzCHbjfCFtrZmDdOEg1Jd2LVLqpMnIc2n156
   7BsrGLUyZWsheFWM+YuOZL5D+AK3scZjEMk/M+xi0PFyy+cQbyrJegRtE
   iHB9+RIRC2jcFM6Huz+eFLzcZyS/0OjMiPCNCxhNfz3ssaNrqrfWZl4Rc
   NHuE1b4AF6AGasWXHnptgU2ke6yDUS6hjx0ZzUlOiylISN61VFjGKtvmE
   VrckQK1/4Qnr/PFLdTtayFYqo7o+i0Z9pTl9Sq/6WuwUAZK50fbXN+MrU
   /VV3mYoriJik3AUfRge0I4M2M7ZFVMJKQLyRq/GNKdtkMB2aqoNpgsVox
   A==;
X-CSE-ConnectionGUID: WpbEta/uQIWAVB5jWOyh9w==
X-CSE-MsgGUID: 18ioY/iPSaWf5Fy+GvCP2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19463574"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19463574"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 01:05:58 -0700
X-CSE-ConnectionGUID: Ya0x6Zf0SXuOP/d3E8tptg==
X-CSE-MsgGUID: JR7xbaoyRMirp9ZJyNMv/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56458019"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 01:05:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:05:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:05:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:05:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTMz2Xdg6f8EPcnHA3bUWpjwyDcjmn6ZJeG0poRIgdjgE8bnsh1hSa9UBd2BLlr3EjAPM2BRxV6C/cpD3FpIRVxMLl8/aodhgiCQS6K0vBRtnNrpzZG+/p2JOvRhrVfCrcTGZHGuflU6N4GJbjval6/hM9I+47aAZV3HBqUZdx/kdAnZSXA32/X5YJAT9jJ2oa6i30CP3PqQLC31KpSzzgYIBgx8jV1/p7aYwsg4pFQnyo+6bVaX2cwWS5S/ovTEXl3zbwcpySih5hCDsGg/Mc2eRTFeyPxEZv+qmXLzjkyiUp+wvYXSUvU3XRT03psM4I5ykUimmBt8N9elui7OYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9VPlKdxpeWU+l/GdNdQZiexmRwaQmjkQ7NUWoYdlH0=;
 b=j10k1nWaGTI6wOYoiow+5LEP2ibr8vgDrnrKzubxzn5aK0WB4v7D3j2kbr6WePWFJOG09C1Iucf0lvXc+0pIxrjoerR5TVHk79LDOFVwikM2afQJm7dZGhFPuBMmMp3ZseFYl64/JO2sjDXKImfg5kTqIuWhuIA8Qn4dAqFaswl07kou+ejdxXRUYJhWbcpameyaP1d87Zb5cu0l0nlqDsUEnz1mnybw8hM9NZPZi92BZm7rkwW/GS8iAryerU78K8QKeb3AlDX3lt/qlg9VRwzu73HIlyyLKFDIQrsRjP0CMezChdDn8YsrzqyrULJaaLd96v7uMaFJi8R6lm4k0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 08:05:46 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 08:05:45 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 12/13] iavf: refactor
 add/del FDIR filters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 12/13] iavf: refactor
 add/del FDIR filters
Thread-Index: AQHasGgeThq546xlEUuZrq/3bdH6WbIETVkg
Date: Tue, 23 Jul 2024 08:05:45 +0000
Message-ID: <SJ0PR11MB586591C56698C59446013D098FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-13-ahmed.zaki@intel.com>
In-Reply-To: <20240527185810.3077299-13-ahmed.zaki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|SA0PR11MB4591:EE_
x-ms-office365-filtering-correlation-id: a8f19bdf-14d7-4fd1-18ef-08dcaaee419c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?N5AJR6isUMz86tmb0EN78tAzpVotQXYVIX8uUaIMCqdAQ0ikZ7yXHzIXJbvp?=
 =?us-ascii?Q?BR7+hLPMCKSwXEOV9QT6XS0JE7wkOnJbWWOt1Lh8M18typMx/Lp9nXqUTL/v?=
 =?us-ascii?Q?TmehzABDG880tFOCW8Ubu7NGPPIv1UIL43/Yvp727GZOiPNpY5L0hoLhnwZn?=
 =?us-ascii?Q?Wq7dv9DkvLOX72c17HRwYLC7skm0kDacJkADazYsq+cxx4eJcKoeKobe37yY?=
 =?us-ascii?Q?rLztGdCElxd1AB9AuHRtwWd40LVP3/cndZk+XxC141TtkKfuNIimx0LU2IFV?=
 =?us-ascii?Q?DJO8edjbAbv/5n0uiwgM3NgqTguGHAM/AejoP3SzXcp3+gWYYRhnAnezV00b?=
 =?us-ascii?Q?8Zmfh4AjMAV+z7hxMIadQqIYPP53/0it9H+zELSjhJzI4nN4GZCb3KgF4rEZ?=
 =?us-ascii?Q?78P7fBYeVThc6GBenkJC0e1lZJmxxcArO0JBSz8eAqVEto/tiPJ72tN7RTYB?=
 =?us-ascii?Q?ZmZUFMWCqpXWQEcenU/m5IBaARPeZtDfzKXSn4GIsKImymdTtYvgYwdK3WJM?=
 =?us-ascii?Q?dakmLJscoVsen2yC+7bOg5QI72TXi4wU/7t4XRzpG9QQ9Ux1uWPlmZbkaf4V?=
 =?us-ascii?Q?KqyKpPYSxkLgskOjYMnSpbBIobwd1dsKk5Tracrh6YsXpbfIzl2LuF5aokSY?=
 =?us-ascii?Q?Iov74J1LlEciNM3C4hJmRJ+lZnSSZtK8/eUipc+oeS31RnGLiftZo9RlBix7?=
 =?us-ascii?Q?i90KQ5lAt6iMEPkyjT3ukf6WN/HaXF+lcrr0LAVH9H7mf/CoEHCRNdFVJDee?=
 =?us-ascii?Q?78fi9AY4a3R1fvd0Bb1PZHR3cNYUTT8g/nIO28F/iRpH06tTToY6OzT/01LM?=
 =?us-ascii?Q?4keUFTfQ/Mg3rrNP+gp/fAezf4jK1r0+Sx4/8tKaNnj4VD6X7tDHLMq0NMfg?=
 =?us-ascii?Q?cTyXi0GuALMgTsNML1AbP4TSjAle5pb2ZIOfl0Dk6tXfWqJ2zWDiIJi095UI?=
 =?us-ascii?Q?kbg7/q4N3NlzT++T+o7eYHoDelbpUlwoDDUzcwGV6vJ31IFMYojY7nvzU1hf?=
 =?us-ascii?Q?Xg1bwqZJ5SDx0aAeY0tYc2Chnn+f3qVeQd+intDZhmhN9fMq6Pi7atj1JRrk?=
 =?us-ascii?Q?7YtukBRHI/qoiu55akPkdVdhsLUaEeq3TIZlwtFhVdBWL5cZpK+y4ehmQwWP?=
 =?us-ascii?Q?n42gBS4wexVAnead5stXoWxlOD63L7SY/7xpFVJooSm/yTM9ne9rxXU3blyh?=
 =?us-ascii?Q?LOlG7tHS+9ccPYguq555B2YyvUwo49KIShXIjJfqFFo2+sZVqildy3Z1/8Bh?=
 =?us-ascii?Q?3YZCeVd/zWLp+bXJZ0eduLifzz3K2N8qbH01c1rrjSTWhTzlYMqWHHF3hlO2?=
 =?us-ascii?Q?NM01HzYgrF4Wmk2FBygh3pnkKbz0MWZl9rxpwiQnGFZ8lX5GuOLFBsSlhU6r?=
 =?us-ascii?Q?vjPHg9uwZ3+/6v2Ghu8sH4Q9tOvFi3ZCBFBVb0QS3v97cvXMIQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Epydoq2FoDW1YjX1nwYWhx/KLw/FLo6mZCs9ujXpgiBOjkdSEbdiBqsnilPa?=
 =?us-ascii?Q?s2ZjR0ysG9Fsy+14MO8CqQv1MI5vpaEY2aZFnsvCJdbKm+HVmFMw5uwRm4pB?=
 =?us-ascii?Q?vz1CVZmpxzrcHZt25X2ZZliB/+/D7saVQr+QnfnOvIMaKZ8f9K0UtYw0df4a?=
 =?us-ascii?Q?khCG0WdN9Vep2mKSjwUJA6XG53F4bpPJrY1GZkQov4+4TnQCTGOZcUEiS8er?=
 =?us-ascii?Q?bUeURozYnmIs+vkgCzhdWYiOeAWfVPQNR/z8hD1vg0OX0rKcS6GokM0b5eTb?=
 =?us-ascii?Q?h+I00jyyxxodGT4cdal+zjdj2RLAnfIAbOzvExt1KRJ5EonaIBSwF62y6tqe?=
 =?us-ascii?Q?uvSr6MTbFYlctzSDBR3fXhgVNgEjW+KX87Ote6/CfDKNDCHfmwqLcHE++Hzc?=
 =?us-ascii?Q?CXKaRjzNdSNXN5U9AKKDflXHdrchTylsesF30Lwx4xuY9lLHQpxkHZh9qlqI?=
 =?us-ascii?Q?iAI54IhgET5yFzQTAQX0fKqjxpojQB63QsByzST4zK1llswlImHPVj0n8Ejp?=
 =?us-ascii?Q?GVf/IAVQDijqiKnhRviEyVxjDSX4dkAJwZQeLQfPTPZGFCitiVYAHZSP1eFy?=
 =?us-ascii?Q?PjoqJ4Jf+bjaUcZunJRf/bKVz3k9gO/VuYlNLI4WBAz6+Aw1c3buFkFxsLEw?=
 =?us-ascii?Q?zavpawLXlciPZYDCvuePe0PWrkWA4+vyjtpTXS/Q1MZjGFk1eRyzuWLV0QDZ?=
 =?us-ascii?Q?GNANs7rWeqSLlhbN09dItWz+k3qB8hjiln1mEJkbJVpRJdUDewtSkjaL1c0V?=
 =?us-ascii?Q?4xISzkJuys7QxGh/V7sgdIVpUX8Y8biSqtcnJYVVRQ36eTn/zhnSH0T/BM3V?=
 =?us-ascii?Q?A7EFp/H3+76mU0wQkHvSoDzYINZXjKCX7HpM4igYwFND+3PPmzlM5vIs6WE8?=
 =?us-ascii?Q?UMyAcORJB2mx4e/U/ZiQr4ixUXznWjIw31g4JB1LuU8tUGSWVBUBRuzCNdc5?=
 =?us-ascii?Q?e2fiD/K+opySrOZFHVbDjScZIuOCGzDElrR0vkN2nH+vgbUwr7xdPd1ewFPy?=
 =?us-ascii?Q?OHdAVMAzgrK+XSK5vyz1kJRPzp1MuQBf5kPdPHZUUm1NuzG6OuSMlg48EHVn?=
 =?us-ascii?Q?coIGnAZP4TPnsql/GFgo+FiMf2f/UDYHH4BD8aD3CIXCIma41+PAHAb6bYiU?=
 =?us-ascii?Q?8hXsYwh+CWILOjjcNGPdBzJUz5Kx1wwL8JB3pstj4pNH0Sx2yEy8eQV8z1nr?=
 =?us-ascii?Q?I14RcRoxIIqqhWOzcy/X5T4TjTXvizQCU0WD/o4sWjw1a4xLnrPI4ZQ5P358?=
 =?us-ascii?Q?WcX1NQDKn8XJU35pmPWnlYqr27kqmFzoAarQKlSa0t+eQo5QW4Mne7tE2VSo?=
 =?us-ascii?Q?HCBSqM5JLx4egAUAvfaWNgnVoqGPEo9y1JdVynUzNjvqwiMwxOQKibn2WwQ3?=
 =?us-ascii?Q?ucG2SBIVuJE7a/EZ4G1MC2TuX5iJgcelvl2vcqZkchrubkWB3Nmsell42PRL?=
 =?us-ascii?Q?p/1I5dWErjqDxuR5ezAlOqF5z6TOyh4h/2QJcrKSqbimsEShxmUxL6ypF6/P?=
 =?us-ascii?Q?PgrNKoAtY1dyZDn2egrypkbdsFv2zQBuYwj7Npc1SElZMdfaSwYEI+1oEq+W?=
 =?us-ascii?Q?GU6EIcmaBL0Pca2Eec762NaxRz1FJ0Eng19gjVhJUtIhYJaQqo6Fk6ZXxyYq?=
 =?us-ascii?Q?QQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f19bdf-14d7-4fd1-18ef-08dcaaee419c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 08:05:45.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hA4ixs9xoFCM2AEBak9nB9da4uIZEHpjMPkxma5bKbt5kFDcAHB9Px14iqs1Q8ZRxukLJDLf5MxtrhWwwft5DDu0JH8FI0GRUJssMvvrurY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ahmed Zaki
> Sent: Monday, May 27, 2024 8:58 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Marcin
> Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 12/13] iavf: refactor add/d=
el FDIR
> filters
>=20
> In preparation for a second type of FDIR filters that can be added by tc-=
u32, move
> the add/del of the FDIR logic to be entirely contained in iavf_fdir.c.
>=20
> The iavf_find_fdir_fltr_by_loc() is renamed to iavf_find_fdir_fltr() to b=
e more
> agnostic to the filter ID parameter (for now @loc, which is relevant only=
 to
> current FDIR filters added via ethtool).
>=20
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  5 ++
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 56 ++-------------
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 68 +++++++++++++++++--
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  7 +-
>  4 files changed, 79 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 23a6557fc3db..85bd6a85cf2d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -444,6 +444,11 @@ struct iavf_adapter {
>  	spinlock_t adv_rss_lock;	/* protect the RSS management list */
>  };
>=20
> +/* Must be called with fdir_fltr_lock lock held */ static inline bool
> +iavf_fdir_max_reached(struct iavf_adapter *adapter) {
> +	return (adapter->fdir_active_fltr >=3D IAVF_MAX_FDIR_FILTERS); }
>=20
>  /* Ethtool Private Flags */
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 52273f7eab2c..7ab445eeee18 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -927,7 +927,7 @@ iavf_get_ethtool_fdir_entry(struct iavf_adapter *adap=
ter,


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



