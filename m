Return-Path: <netdev+bounces-69891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7F84CEBD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0579BB26B2E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB681758;
	Wed,  7 Feb 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e86gQjOQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DB81209
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322588; cv=fail; b=Vvrj0JWG+uuLWYjAwtMV95ayvSM8VPZMABtJHkRhlsxhiyH8I257lIarjfOihqjz8JuvQFxYpGmX/ZPYCvveQZXhEzopLxXE9nsbRbZjsa+cFXeRwEc5Cy3amFHumcan4goZerKprCj5TcyRj2nLNkxCYDIA4DmeY9mBQOHqp1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322588; c=relaxed/simple;
	bh=klGokUfbUZd2yQOC9mRtiqPBykTjq2zhsX4VXbK0fY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XsuGt3RWtzWdmuqO20NChGMG4rzZlAvzIQOsBuhQZLHnnFH3MQCFFsu22YYYupNWUwly+yGjUlmGG+v4nGoxMs5sdA7XVbCqFIBdUBAcKTIA7H8WNyUHyqfOmV+1TIPhB5cgVoCIr3OyG8DbgYwPVt+sPpQp/8hNOPH0fj8pyYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e86gQjOQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707322587; x=1738858587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=klGokUfbUZd2yQOC9mRtiqPBykTjq2zhsX4VXbK0fY0=;
  b=e86gQjOQfUKVZoQ/o8Cr9KE6DleHPz0Opc7ZfOd6bCHju3MAbeLs3n3x
   mRLbVS9S4l+OsqY/2/3RBTHH01ozqOEzmkO6Mcy16r7BkWSiwMJguA93n
   b/t8c8y0cPTzji0I2NdX0TZ2ACemNH7Oxsi59O+NxJ5lE+4tEPsvv+PCU
   Ky3sAkZ0UNQohe9vsY+4fwWCLcFmcUPJFY9wq+rkQRFd1n8jh5PiFgV5u
   XpOYXj2mQkNdJXBbdvqYHk4qOlSuKvHCgt+lRixW53EeFK/q3ikKJagjo
   sQozIb8IrIFRI+mJFLqyaRYW6dtpyy2JlVe3A1tJW99/9yItzBmcfGcYn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12380317"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12380317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="5996074"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 08:16:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 08:16:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 08:16:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 08:16:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 08:16:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R552aqDk5v78w0UbyHknC3lXhcnxzZ880fj81qKz6sPeVurH5mPAjFR6IXkcaCXBeJUSzM1MrrGpyFQ01ZldzjsXPOCFPyK7Ak0Kkj2RzEGeaSaFFdyTprUFyQ06OgQp13ACz201LIA/itqLeYGAoMh1XTp7+ox+nMb6Nh6HWs/g3rGyKsKgFeD0VVqqkTAz4KkEqvhFAauMSYjCP4TM7upJQaS0CIfz+6QDufZQQpFFiqaM4wzZ2j5qOgX8ZXaeFTx2U308SdREof5yhV/2a9qUUwQyCN8L0VrBJN87ZQzg8Xo1KE9FqQpmV9W/FdZU4i2blFvuXai0VBmqtxbmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCuqcMm/Bdzrz0A+ZGU3idOj1QmAkA/HQyCv8KZBKls=;
 b=G9bp8nMNnRcKOdvb3HwLucjul8JY7tcBQtlXK18UC+u9h++Kdbv3YKc/zzjkE/R62Msar42/dXo0JwjJEn7fox6AENMD6is6y9XngUyilbGPuLdY3Pp70ban4iibcLIv8tr+FT2HmwhgVk/zDBymzvCFvmTl2e8fkJfCV59vrHuD81s1WJPHOTKqVqdfIAzrMwKyHvbuSYon5aHNlXfEJ+VOr6SoMg5zFFWL1rKLhq3ul5S1Vm6OoyB9mGTK+kkNEnh63ipqFSCL6QmlGXdfd0DAPXf8IBrfZXsSJD2FGhVN5reKsREXOfrlii/woZxwDHKdfiMHLjGsEo5VCnEB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB7318.namprd11.prod.outlook.com (2603:10b6:208:426::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Wed, 7 Feb 2024 16:16:20 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::69dd:6b79:a18b:3509]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::69dd:6b79:a18b:3509%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 16:16:20 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: RE: [patch net v2] dpll: fix possible deadlock during netlink dump
 operation
Thread-Topic: [patch net v2] dpll: fix possible deadlock during netlink dump
 operation
Thread-Index: AQHaWb0V4NKhEqzQBUWiSO+qP3hnAbD/DfkQ
Date: Wed, 7 Feb 2024 16:16:19 +0000
Message-ID: <DM6PR11MB46577C9FAFD92CA3A2C0BDC09B452@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240207115902.371649-1-jiri@resnulli.us>
In-Reply-To: <20240207115902.371649-1-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB7318:EE_
x-ms-office365-filtering-correlation-id: 2c661226-bdf5-4cf7-49b1-08dc27f81eb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUfJKXPCgPayZN42XddvdTs01pRp3a31h4jRyKFC7aZR6DcZ8Jyu3UPe81Rq8eMJ8sxij1V6Regzq2UUOgBuAo/RbIUa0abgf853qUhkbQT0G9R/HOZnyfSB1Oi8Z02v6KBiyObZiVIiuxMgE0MbXGwGQ0gJNLsaBmXIubYKaaw8hUTtnIjDW0UjDjXOefT0OuFA8h3+KnDZFyiStIL+/pqO+47/MhYmQqPy7pnh/25kwVYeKq98UclI8tRAkL7pNk5CfUmfaSl/m1FWjb8bn3tfat3CSD2243FXZjdv5XWL3sWASyjv9/LjpctQ4pCSozByCOfBDYVUethWRsBRPnCWGqMxW6ksEJRjOqwWMr4k4pvLDxwnNzqOCkIkQ44pCeD2pIILDVcxdzcuPRfCAuD+zWGoe7LjbALs789Wk2MzxRPzTF0u9swGw4VGRwDPdzVM9WXudOVs73nyMIhOdbIKtrLD2hwre8QXh2/m8NoKEK1J1AP8eN2Qi1sPtPLbCSr5MdZoZqhejJlIe59bkoRZiwXTYHuQ94Mj7QlmOqK4kftIdDlsYhswx3+sKuhKTZg+5sYiX8/1CpIxIWXi+6JMgzgM0bbdHvqJGLzSlP/3T4WMF/Dk+oFn8yujPoyS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(316002)(76116006)(41300700001)(64756008)(52536014)(4326008)(8936002)(8676002)(33656002)(9686003)(6506007)(478600001)(7696005)(71200400001)(5660300002)(110136005)(26005)(38070700009)(66946007)(66446008)(66476007)(54906003)(66556008)(86362001)(2906002)(83380400001)(122000001)(38100700002)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SaH1IU9YFSTEZfo013WmjfGkVPO2dIP9XsCm7skrPYfxizo9uMjfYnfbu48W?=
 =?us-ascii?Q?IJPwvyb19qM1fa/lKzkYDGSzL/nKawvuAwZxbc8kGBK2PHIKJSiuy+6pvlqN?=
 =?us-ascii?Q?CPWv12vatP+R761ti+9a7sP37LUBtqDT2iCL/xzFSufFwekNI224QG9LeVb1?=
 =?us-ascii?Q?7IGwG1j/7d9Iy+O0yFksJxZAWP5ye05xz6iPFhKyBJmqTvl2ZqvECtKF4bvn?=
 =?us-ascii?Q?vHSDxW4JMT9yTJmHN88YYdGsw9bxW+292vnfEEr+kBZgmpph8A3WEsXj4Zv2?=
 =?us-ascii?Q?/9ikte357XD5dKAV6PoTKlmzUfs7PpNDnNpHOg+gPrGF6vX5Xssmf9Qj4I8K?=
 =?us-ascii?Q?s3NmBqtR3wo8We3Pypkfk9f0Rj88IV9aI2M+GmE2uzt9gwcu+703CxEvi2H7?=
 =?us-ascii?Q?jWUB8OEjg3DJI0mQQ6eHVVfrCOEq8z+96fohDPOuKwYSbuda54rKy4khqBWs?=
 =?us-ascii?Q?uLdsbXUVsHa7hYHr9plw8iqYvjW1fQ7cAX4SVV7r6Wif19sfNV9qItCGXeKG?=
 =?us-ascii?Q?YCtclTBIHMV8TRscGPnk7LOE8sf18qj052mFbnQHOW93MeurehkuNbz74i2I?=
 =?us-ascii?Q?Xrxcl/CPj2WCuqFd3mcPe5c6B5OOckz6aSTrKKLIa+4zAwrGU0e70Elvjk0d?=
 =?us-ascii?Q?ZOksqX1C6iGlxeCpyZ69B5JlO+gYSR2KXEixhwJ/tf/9K0mq5mXYeCfXmASw?=
 =?us-ascii?Q?QPEsRbc0HSr8VHEPOcL6a1MhQic5jAKTwVwG2ljJcUyd1iYl9TysbKRW/N/E?=
 =?us-ascii?Q?X8gW4WilBJFd/9YdtmpZgjw5imZ6L6aJQaXkpVE8ugyFtMoBSuX2gg4j6I6S?=
 =?us-ascii?Q?TNGqAwafj/BD+8ik8zMKECQjoPlep4Q7uFhzeNd9K1NM2HDwFaRWCb+rSADb?=
 =?us-ascii?Q?4wZ3E4WcTwaVwzbURBDdg6rRO6DZoH4FF9vmNy19rkXQXu9EALT1ZAdv/qri?=
 =?us-ascii?Q?HiQuhPSVE/HzZc0a84Q9Q6jdcYaE/RL0wRalFsamFFCncZmmLc+Eatowvgjh?=
 =?us-ascii?Q?RfkWl9qvhvK6RHplN4KKmAml7FAIZEoPsy2+gdumC1TNFt2imB2op1yO4y0Z?=
 =?us-ascii?Q?vDGDr2YzIpjxs3gMYUSjnPRZiB7oFIhj6apaAnpVb+0w4wRgRTRpRBTnitmk?=
 =?us-ascii?Q?e1O3oRwaJrfVHblBSfUCfYsgRQpd2lW6kHV7veyZPj+Wfldc8CRIsbDff3fT?=
 =?us-ascii?Q?PwjoAnXSWc79vv0Y247mUzUBQNy5nl6frzGKQLsgEvszyxMOY4ocptptrEat?=
 =?us-ascii?Q?BJuxRiDJoxGQv1rAs3peQoTP/YN31znxj4kDIcw8GK+hd7kVvFrHJ5+t70WA?=
 =?us-ascii?Q?07q4wGXFxNFgJjOCcFgv5SwxCM0nBvNwHJp+5ZKd9O+Zao+6AjIK3mnFREZM?=
 =?us-ascii?Q?ejXv+pI+TuFLJBUT2LuRwO4pov4xVTuFLVlR+ad4dsUpWgpZaTnR2PAcpiTq?=
 =?us-ascii?Q?2fQe8IaGiYtXKpX/3KXjNCGicVjrZ5MQQexw+Im3sZkWjD8EHQ+sLANi1Q2b?=
 =?us-ascii?Q?AtwLU6nUSQqHxm1mfWlttDk0UlYRWO3xIvAcpnGqYInGUJ4/Z9opQauCgEiB?=
 =?us-ascii?Q?FBC71RUXZSKFqqKmLoz5GzzC2Gn9PE4qvuqk6mki48y+l0OHnmK106QIIdS1?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c661226-bdf5-4cf7-49b1-08dc27f81eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 16:16:20.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nyQ0L4tsKcjdLNvrcfY0686nTcb0JbuRO9/lkZrk/hhnpVM/kmHx0u87QxUJDxGE8BDNxovJy5l8BUD1BdTGZyi1djWo/+zGyQes9SZEP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7318
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, February 7, 2024 12:59 PM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Recently, I've been hitting following deadlock warning during dpll pin
>dump:
>
>[52804.637962] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>[52804.638536] WARNING: possible circular locking dependency detected
>[52804.639111] 6.8.0-rc2jiri+ #1 Not tainted
>[52804.639529] ------------------------------------------------------
>[52804.640104] python3/2984 is trying to acquire lock:
>[52804.640581] ffff88810e642678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at:
>netlink_dump+0xb3/0x780
>[52804.641417]
>               but task is already holding lock:
>[52804.642010] ffffffff83bde4c8 (dpll_lock){+.+.}-{3:3}, at:
>dpll_lock_dumpit+0x13/0x20
>[52804.642747]
>               which lock already depends on the new lock.
>
>[52804.643551]
>               the existing dependency chain (in reverse order) is:
>[52804.644259]
>               -> #1 (dpll_lock){+.+.}-{3:3}:
>[52804.644836]        lock_acquire+0x174/0x3e0
>[52804.645271]        __mutex_lock+0x119/0x1150
>[52804.645723]        dpll_lock_dumpit+0x13/0x20
>[52804.646169]        genl_start+0x266/0x320
>[52804.646578]        __netlink_dump_start+0x321/0x450
>[52804.647056]        genl_family_rcv_msg_dumpit+0x155/0x1e0
>[52804.647575]        genl_rcv_msg+0x1ed/0x3b0
>[52804.648001]        netlink_rcv_skb+0xdc/0x210
>[52804.648440]        genl_rcv+0x24/0x40
>[52804.648831]        netlink_unicast+0x2f1/0x490
>[52804.649290]        netlink_sendmsg+0x36d/0x660
>[52804.649742]        __sock_sendmsg+0x73/0xc0
>[52804.650165]        __sys_sendto+0x184/0x210
>[52804.650597]        __x64_sys_sendto+0x72/0x80
>[52804.651045]        do_syscall_64+0x6f/0x140
>[52804.651474]        entry_SYSCALL_64_after_hwframe+0x46/0x4e
>[52804.652001]
>               -> #0 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}:
>[52804.652650]        check_prev_add+0x1ae/0x1280
>[52804.653107]        __lock_acquire+0x1ed3/0x29a0
>[52804.653559]        lock_acquire+0x174/0x3e0
>[52804.653984]        __mutex_lock+0x119/0x1150
>[52804.654423]        netlink_dump+0xb3/0x780
>[52804.654845]        __netlink_dump_start+0x389/0x450
>[52804.655321]        genl_family_rcv_msg_dumpit+0x155/0x1e0
>[52804.655842]        genl_rcv_msg+0x1ed/0x3b0
>[52804.656272]        netlink_rcv_skb+0xdc/0x210
>[52804.656721]        genl_rcv+0x24/0x40
>[52804.657119]        netlink_unicast+0x2f1/0x490
>[52804.657570]        netlink_sendmsg+0x36d/0x660
>[52804.658022]        __sock_sendmsg+0x73/0xc0
>[52804.658450]        __sys_sendto+0x184/0x210
>[52804.658877]        __x64_sys_sendto+0x72/0x80
>[52804.659322]        do_syscall_64+0x6f/0x140
>[52804.659752]        entry_SYSCALL_64_after_hwframe+0x46/0x4e
>[52804.660281]
>               other info that might help us debug this:
>
>[52804.661077]  Possible unsafe locking scenario:
>
>[52804.661671]        CPU0                    CPU1
>[52804.662129]        ----                    ----
>[52804.662577]   lock(dpll_lock);
>[52804.662924]                                lock(nlk_cb_mutex-GENERIC);
>[52804.663538]                                lock(dpll_lock);
>[52804.664073]   lock(nlk_cb_mutex-GENERIC);
>[52804.664490]
>
>The issue as follows: __netlink_dump_start() calls control->start(cb)
>with nlk->cb_mutex held. In control->start(cb) the dpll_lock is taken.
>Then nlk->cb_mutex is released and taken again in netlink_dump(), while
>dpll_lock still being held. That leads to ABBA deadlock when another
>CPU races with the same operation.
>
>Fix this by moving dpll_lock taking into dumpit() callback which ensures
>correct lock taking order.
>
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---

LGTM, Thank you!

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>v1->v2:
>- fixed in dpll.yaml and regenerated c/h files
>---
> Documentation/netlink/specs/dpll.yaml |  4 ----
> drivers/dpll/dpll_netlink.c           | 20 ++++++--------------
> drivers/dpll/dpll_nl.c                |  4 ----
> drivers/dpll/dpll_nl.h                |  2 --
> 4 files changed, 6 insertions(+), 24 deletions(-)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index b14aed18065f..3dcc9ece272a 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -384,8 +384,6 @@ operations:
>             - type
>
>       dump:
>-        pre: dpll-lock-dumpit
>-        post: dpll-unlock-dumpit
>         reply: *dev-attrs
>
>     -
>@@ -473,8 +471,6 @@ operations:
>             - fractional-frequency-offset
>
>       dump:
>-        pre: dpll-lock-dumpit
>-        post: dpll-unlock-dumpit
>         request:
>           attributes:
>             - id
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 314bb3775465..4ca9ad16cd95 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -1199,6 +1199,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb,
>struct netlink_callback *cb)
> 	unsigned long i;
> 	int ret =3D 0;
>
>+	mutex_lock(&dpll_lock);
> 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
> 				 ctx->idx) {
> 		if (!dpll_pin_available(pin))
>@@ -1218,6 +1219,8 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb,
>struct netlink_callback *cb)
> 		}
> 		genlmsg_end(skb, hdr);
> 	}
>+	mutex_unlock(&dpll_lock);
>+
> 	if (ret =3D=3D -EMSGSIZE) {
> 		ctx->idx =3D i;
> 		return skb->len;
>@@ -1373,6 +1376,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb,
>struct netlink_callback *cb)
> 	unsigned long i;
> 	int ret =3D 0;
>
>+	mutex_lock(&dpll_lock);
> 	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
> 				 ctx->idx) {
> 		hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
>@@ -1389,6 +1393,8 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb,
>struct netlink_callback *cb)
> 		}
> 		genlmsg_end(skb, hdr);
> 	}
>+	mutex_unlock(&dpll_lock);
>+
> 	if (ret =3D=3D -EMSGSIZE) {
> 		ctx->idx =3D i;
> 		return skb->len;
>@@ -1439,20 +1445,6 @@ dpll_unlock_doit(const struct genl_split_ops *ops,
>struct sk_buff *skb,
> 	mutex_unlock(&dpll_lock);
> }
>
>-int dpll_lock_dumpit(struct netlink_callback *cb)
>-{
>-	mutex_lock(&dpll_lock);
>-
>-	return 0;
>-}
>-
>-int dpll_unlock_dumpit(struct netlink_callback *cb)
>-{
>-	mutex_unlock(&dpll_lock);
>-
>-	return 0;
>-}
>-
> int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff
>*skb,
> 		      struct genl_info *info)
> {
>diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>index eaee5be7aa64..1e95f5397cfc 100644
>--- a/drivers/dpll/dpll_nl.c
>+++ b/drivers/dpll/dpll_nl.c
>@@ -95,9 +95,7 @@ static const struct genl_split_ops dpll_nl_ops[] =3D {
> 	},
> 	{
> 		.cmd	=3D DPLL_CMD_DEVICE_GET,
>-		.start	=3D dpll_lock_dumpit,
> 		.dumpit	=3D dpll_nl_device_get_dumpit,
>-		.done	=3D dpll_unlock_dumpit,
> 		.flags	=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> 	},
> 	{
>@@ -129,9 +127,7 @@ static const struct genl_split_ops dpll_nl_ops[] =3D {
> 	},
> 	{
> 		.cmd		=3D DPLL_CMD_PIN_GET,
>-		.start		=3D dpll_lock_dumpit,
> 		.dumpit		=3D dpll_nl_pin_get_dumpit,
>-		.done		=3D dpll_unlock_dumpit,
> 		.policy		=3D dpll_pin_get_dump_nl_policy,
> 		.maxattr	=3D DPLL_A_PIN_ID,
> 		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
>index 92d4c9c4f788..f491262bee4f 100644
>--- a/drivers/dpll/dpll_nl.h
>+++ b/drivers/dpll/dpll_nl.h
>@@ -30,8 +30,6 @@ dpll_post_doit(const struct genl_split_ops *ops, struct
>sk_buff *skb,
> void
> dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> 		   struct genl_info *info);
>-int dpll_lock_dumpit(struct netlink_callback *cb);
>-int dpll_unlock_dumpit(struct netlink_callback *cb);
>
> int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info
>*info);
> int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info);
>--
>2.43.0


