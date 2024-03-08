Return-Path: <netdev+bounces-78616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51473875E6B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7F7283FF9
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D284EB49;
	Fri,  8 Mar 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwUo+9qo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F74EB46
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882761; cv=fail; b=R8imhUPt+gJhKds94dNVhaq3c8NqOazCRspqol16fOcT7ut7eiFOHRZ+2qJgs7wm2oKU9pQnN9JaVNmw7gcMz1Jwxr5PQMpKbkC2u5mX9JqfWpEqOWzrtd4FzRuV3BqogjwthoF1Tsf/oixb7FjkTVtkfdIPISYuOIJsgzqKEMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882761; c=relaxed/simple;
	bh=Upfn1DSq+dGJoX1ZBFVANHp0PzKXZ5lDD5reun/HQ+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAbVcKpOnvj6wJIDgsV7PnyMUX+RRoB7VhCvW+sQk8DWIYgsiQI4Chr+9zjfuNENNUiGEKuASAEKypWQ+Ibens3QXUgmh+lWIr/Cit2t5ZldrkTnPqxJBq5Bisil5WSTJeM2UkY8LvTnRzk2pedKxFk3JhSp+P0NUwByCLXFulE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwUo+9qo; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709882759; x=1741418759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Upfn1DSq+dGJoX1ZBFVANHp0PzKXZ5lDD5reun/HQ+Y=;
  b=XwUo+9qogKm7LhV9XhC6LxHGbES9vQescePky6hKkZiBUcF/lWp5HJPu
   r88z1EX2RhpsLrV9IFTUL93K1MyptFqG9QtZViAP66s8gxKGB8angNyb5
   ETih+shpHel2gFCjNYXetrU/4v0UXiDcyIR9fwlntgTIjel02yLBOUREm
   dBAfVu5qoGPj65Nygpf3cPcQZLSt1WV7ITOHjG2tT51RoeuvScuYnagYT
   /ZG4aDRnR19qZRU+R/FNtX70sshZ8cHJlpO5+FBoVP0MEpq/d3U7vZG9/
   CSfdKO+7Vm+Jmi3VRDSSGW2Cmp22dApqrSkaY+iNvnqzgwIl0CxFqHoT7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4730859"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4730859"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="15072391"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:25:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:25:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:25:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGTafgz13rOhPT2OmtHQkBtDE9CxOCiw5C7tizqidEnP9OjwpdB55AY3p2+jbs+FiQMAl4dv35pfFZCuJiN5KD0JrmjwJcHt/9mhzEQksqu0GasF1LleBKteKpVnPZM5iPQDrqabs2iTl3zG9X9nBabwcJAlfgKYUh9FR7TAuJIuvGWFOya55YeTof7E56XuqCywxTAQuCRfQsgtiulNdIql51Mflbn8EJMfjQcehubE8d4xiBlvp4iTSNQd/YaqLpPI/XxziRTEIWBekFJ0KbgPiQDYSUug2TIP7Ds/2FucpMWhIu4YaGSux/PNIBVAxBf5x23qdsC09chqNgautw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qifejmYkWeGWdgNy2UbC15QFIlhPYjxguuFZuE0daao=;
 b=nPFfMCoStIVGPzLOgHs3+kaNINfWI2E7XnIQYoqCm5271qZ6uO8cVay+NwjHXUYWDpBVBvJ5k1BSTGi3RWeZFpWl8x5SExgmBnbENv1gjQQXesnAMFD1l9/6iWEbWQCUeElRSqL03U+DJ0xkzPntDcyaCr/374lAeVwYDcoALVBBG3sqR6OqdcxXp3pQYlvlyzTfl58eEOOSBtwg4Pew1egov2HzIaSmiN8nW5dlux2MHGyrd5xpUVRbfy/sJZlLhWkoJVnwwo+RGfZVv967Z3zd8XA7qeKpaVW4xsyhPh//ntW+qOCbLInsqWbXc6dBoWHmFF/HRmIolqUvFYr3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:25:55 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:25:55 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>, Marcin
 Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 1/8] ice: remove eswitch changing queues algorithm
Thread-Topic: [iwl-next v3 1/8] ice: remove eswitch changing queues algorithm
Thread-Index: AQHaa86bEuO+Cq0VgkSXcrV+vUOmGLEtfAhQ
Date: Fri, 8 Mar 2024 07:25:55 +0000
Message-ID: <PH0PR11MB50134E2BFB524C07D4FB135296272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: ba039e9a-babd-4edc-febe-08dc3f40fe52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NyL2ioBycktO9EiVQrRUVP52uJrxFl488jV+DhhRoaspTEBUEpEE15IaQqxcLK479TFgKB/DrBZnzEI8uWFyix8O9ZTxVY6A6k8HW066fCK0alWDjBRKVvGV7TpAxKW4zICcsOWd5kY3ge3nVi/qIfI++5YCQSN4P+rNnJcMk07O+G/bKClosVpfMS2TCNCFI28JUOO3Kcmq4d5aybz+/uHaeiz2oCvuJxkku6flw15yzU+gphC6veO2bpxBc0HlGnSaAI601tNy7QDDFVAHWZ/w9sfGzHVdCAsqMWA3XujF7fN3K/1Hk7n5FtUbMcb4YXXv8FRN3y2hZn9esS/0Z8LHcictuZrMl01n0AXduAfTnq993yKqtfmty7GLvpuREW87A7bVzVRMh+5WBUyJtR57qXA+CXZQ/TlakRklL3qlHCuw4vAKfrIXMUYMfcxnKcF8QbnX8YGmIMvbzcPpxzAhUQIDGM9h5mg1SttpB4XJiUwCPe4+Xhm7y4RZn9ueB/Ajs1oRP2C9c02w03gjN/sqmAkMWl8p3zeeDFZRZjmR1ARgLPS/EWHppG4afdI9LTcqWjKUDUM1OQdjVKYo3lBXBjp45Xq2LRPccF1vHGkPhbmWN/g6MRdQ6c1g0yKRe0m75jCEnhhCmwKrjlAAWcar9YcwblOgfEYUKKhnkFPoBk4+1pI9gJ2whru5bRj6B0h3PzyiorEVZtSsWxslmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2CePzUEp/jDpGzDr4EIVoleeIQwp5pv3hSQcyOFjKHjeDrzvnQo0EN/s2P5j?=
 =?us-ascii?Q?tz9oU1Bq39zhuoL593DKbUipNCqDycNYCJzV31L67UHtF1JqdQBj+Jctp4Dz?=
 =?us-ascii?Q?xaxTA24JG/CoCXnMcDllhKQrgRiz0O9z82bE4CaxaRAYjd2UddAeIKRn5TWQ?=
 =?us-ascii?Q?CeliBxBmRTs5Vr3vs9hCQAQIkpYHBqiAafxRSRjd2ljPIY21+VXVeiYgOMFK?=
 =?us-ascii?Q?wJDcZcPH73E7qdAIOgk+EP2UcntxS7TMQ4sWH/z2bJuCTQaEnOOSBzH6IrCB?=
 =?us-ascii?Q?k583z/mqVhrkHwWbkNmkrJJxYJ/fkTClIBVc7wR6yiTrNnNJvT8LfGbsFTUo?=
 =?us-ascii?Q?OMZlEWp0NIgHd9uAmf0R3AyPb1a0zsu3p6eyO5kcw0x2ywF9BLskkusqje0Z?=
 =?us-ascii?Q?UIehUOsmVrtZtMQPsz43wNJcbazpBSm3dbp6H9wKkt5OyjVROnbwIAm586mC?=
 =?us-ascii?Q?cIWjBAykZX89yzd8Y7PzUNq28nsjbWDgkJiaLwecJ1R7aIOQm8AI14NBZpqA?=
 =?us-ascii?Q?pUO6SOtvjtX3oS2Ll1ADrAhiCFBOeBSJUTTrotYt73+4L93y3fN6XzrXgKD/?=
 =?us-ascii?Q?6vZ22F2eiu4lJJC60B2Xl6EMlKkRvumn9qsHVUV6TQ4jnGKgvW8jlvss23bo?=
 =?us-ascii?Q?ldwndza8HUjhj535UvPZaqc42WOUpVnZ2nr3IIxNMcPNB3XxTNFxBwUAcXE4?=
 =?us-ascii?Q?pZZY9NuUft9xGD5qERMRUs9qTs4QWSuKZHewIe8L0PYcP6jU651XbjYSsHVM?=
 =?us-ascii?Q?xe+RNHvIaINvoB+URaUJE8Q02lDXWPUv7YQVgQ8/QSSnMlU5J3ZfUdzx0V8B?=
 =?us-ascii?Q?yV0dnrWQAtmqeZ1RlAhPFYeGFduiZ/r+tHHXULa4gaZ+l5djlknlxWkfv1Jt?=
 =?us-ascii?Q?x09wx1MnSF1U0aNb0KdCOUSVMZ5v+INRNDcnlo9xp9dZFNjpe2MQhELc/h1y?=
 =?us-ascii?Q?+/Md44U4hP3A2km2XTFWPIsP5ouMlXQ2onUiRYOGG9jsvbRS9kq7F2PDh1+k?=
 =?us-ascii?Q?mOm8L7k/58Ur5/gqo1tvfsnAeEQWa73r4Qv+krHOkQ9imoRqG5oczkBrhLNj?=
 =?us-ascii?Q?SYuKcGPcddTeDa5NoWZzKsL4Rf+fzytwiUZh2pZG7c75J/2QAyUzgmOUAPrJ?=
 =?us-ascii?Q?rBKMce9j/9nRdu/YDmiBTzrMAA/uLQho6Ww3+YOQ5oijVUi5HSwro0KSASsB?=
 =?us-ascii?Q?0CfeYYPTbQbVWLptemSSNJyuoGERWy0AR3Q30sHsOK64aFWj5TQMmV8M3qA1?=
 =?us-ascii?Q?2b8IqqzJvnwW01pg+GoTzQiQHWiUbax5geRz6Kv8wXr4hUwfCxBCnkwii/kx?=
 =?us-ascii?Q?R38ZNpaEpqKi2I+1otKUo8Tq254m8fIVO6fdC80ExBs5DZ/Q/+KbOEMJeUms?=
 =?us-ascii?Q?dVQcD1Jru0/F1ACx6EngOKQireN6WQbEX7nAMmTdAIXhRurTWY464Jr0pOfK?=
 =?us-ascii?Q?CE5j0NoI1VnyaKBM/uWm7/Y/mHp192eJsplz2VyVPIsWiKlFTy+ld82ZZQG0?=
 =?us-ascii?Q?uQRXipyPoruQdam4qM1YI7lnmGhn8BbuIxBR/uIXOYN7RbujwBmKn1v10QSm?=
 =?us-ascii?Q?l5UG5T/B6oqVC2EdzShbUH48+at12kWQ7/eHmjoxzYKlLKp8EUEv2DbnrTAx?=
 =?us-ascii?Q?Sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba039e9a-babd-4edc-febe-08dc3f40fe52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:25:55.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoy18UO5Sxy6xPnWFVoGK3S7EgZ7Xq93TqIm/4ucKcGUgoA1QxYTMuvwlRC+tx6W+6j3bS5H035x6LF06PV9JW8d5S3ETBP3o22tP+eu3Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, March 1, 2024 5:24 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>;
> Drewek, Wojciech <wojciech.drewek@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; horms@kernel.org; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [iwl-next v3 1/8] ice: remove eswitch changing queues algorithm
>=20
> Changing queues used by eswitch will be done through PF netdev.
> There is no need to reserve queues if the number of used queues is known.
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  6 ----
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 34 --------------------
> drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c   |  3 --
>  4 files changed, 47 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

