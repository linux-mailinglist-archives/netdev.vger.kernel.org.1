Return-Path: <netdev+bounces-218411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640ECB3C512
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300F95A47D5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F71D61BB;
	Fri, 29 Aug 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHncBasc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DB2874F6
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507129; cv=fail; b=NTdKdMSWjCPX4tVBuWFpZjtazx7Dd0hriALbMr9wsM0d7fZphdHgGkHgxHFlCaaUJzoDrboCw3Jm2HAP8Iu15g3cDMWD6sTLxeClvAAG2q+mBje9bAmxQcS0L7AWoYUls9s/1L7RjFBDuu9vu2kSRlNJPppNZosvUTCQ6if75vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507129; c=relaxed/simple;
	bh=6GZg8A5J3gPUlhvfPd7nKhLiiFIrBPgxVOHuGr94uXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXzwqfpi/b/FiaNhmKhtvP9TUXQK3Vd6rLZRk6lfOuMX6iqhzlqVOFG0/l5VSDs57aQwTgqx0VDI6B7uPy7AMeCWIHfO1uCFvazby/C/v8LhJ3o5AEuiUAwSNMGQ5xQS+hpa5upqJBDpbvvykLRVylSe0FKZ4hd/0UOMscNrp9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHncBasc; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756507127; x=1788043127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6GZg8A5J3gPUlhvfPd7nKhLiiFIrBPgxVOHuGr94uXw=;
  b=iHncBascanmf1zA/Bsnr9RmLEK22cKXDOR2dUum33LzReveXwXhEOm+N
   QI5PBQJLFKifcwR0AA41X6uMn9sDpltkqMcXy+vnEdoKiLZFqtCwXLJBf
   vClH5LySp6YqvrEP3LJn5Lb0sEaqh0nMwSqduyb1t00JHGaCcL9yepb78
   aAwQdJquV2DyGi9ech8HgqJTg820KgcPxwjw0Yos5ayMphTHQUQ8u9t09
   f+VicQy+BlkmgyNDLSyeIAaGfQxm2h2XNdBVq2k+qM86fYmXcsMBBqzhA
   vWi9ULMC1l3AsHf2t7HX+39KuEaxe7HFx75J3WdMAM0+hBbdLSZ1FzZES
   Q==;
X-CSE-ConnectionGUID: J+quuMY/RJqd+ym3NBX34w==
X-CSE-MsgGUID: l991OqH3QzuuX2EJY4DlpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="70170552"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="70170552"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 15:38:46 -0700
X-CSE-ConnectionGUID: KHyeLNvIT9euoCPLxIqUWw==
X-CSE-MsgGUID: RHBApwEwS4WFuF1wKQbPGQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 15:38:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 15:38:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 15:38:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 15:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXCcFFr8kprKlhDPhNqhOa1llD2r8XrEnfhxFtQnfpvqlN7nVBMePXCJ3Cw2zLTkkAgRSGWASh24QgnP9wrv2RMqtVgpuXXKy0A3N72uAmLZdH1AIYupPliNILm+r+05DU/ujnLLUaJ+QgE/Mggql4Dikh1H7kgD7QZ86TqFFlSE16pOfdqwMTGTzxH/kfziLoER1eAXYsy2HuBDuDYOA501Tz3XKgEs2icJRFJZBHAR2wvBt29pyv/JkIMp6m1H/NDAwwOC8bM58yzFXsVCkwH6KbcdmrTbtwYTtmqzWT//v2OCKCOn2Cjqup/t89h9dKabExc04cInqdvYwaKi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkFLPoJX1/sE8W5hAXBSdmmTmCdlBRDnctp/pURB15o=;
 b=tfl7sdDG20geza0CoBPFLflf2v7hj8O6DaA8SJN2gATF4I/mpWKzQOTXdrsq/L2DipeQjUTwHkfYz5r8ltsc84xpWc0lchdhUXw5OiCXVe8P/qMboB1O1JvPA9kiqFwtYU4YsE204G3/hfcFzxevIkrvZD9kKqJTJy6Wu2GynikUyomUWhLyHLFsJ5zKYkoz6Y+fkSHb7l65m7z0ESr/xiIrzI6sXbpBZ5IbCZHuPBJT9luibjT/3LMsve0r9q2RieSN9foRdMHWwL5ThSEYZAS2tVL1xGygcmbmD6xzNaHdfrOgt0C9wZifCO5ZUuLuWXUW+d53+2ER2C31WE7WPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 22:38:38 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 22:38:38 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "willemb@google.com"
	<willemb@google.com>, "decot@google.com" <decot@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"jianliu@redhat.com" <jianliu@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] idpf: set mac type when
 adding and removing MAC filters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] idpf: set mac type when
 adding and removing MAC filters
Thread-Index: AQHcDXVWUA1xqB+NDUyxpSrttgTCTrR6UBlw
Date: Fri, 29 Aug 2025 22:38:37 +0000
Message-ID: <SJ1PR11MB6297F99D91CB8144253F7FBD9B3AA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250814234300.2926-1-emil.s.tantilov@intel.com>
In-Reply-To: <20250814234300.2926-1-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SA1PR11MB8448:EE_
x-ms-office365-filtering-correlation-id: 23a28048-cbe0-472a-24ea-08dde74ccbd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?BxosHRrj9xQnDTK3d2wuA8W46xz7pIto1T2Ha0fhFtmj081ue0SM4iTwTAXs?=
 =?us-ascii?Q?h+/zIRvq/xaVu8Oy3PJ4wMG+V8cXip1MfVeNe2m5mYU1rj2UV/rk/y0dI0bx?=
 =?us-ascii?Q?0sYApkMFGoYlqLszSIW70maM44cq766c5nmk0YkvhV6GIWSqXkTcVXX2kzsc?=
 =?us-ascii?Q?jrI5n5ZlOON0XFKs58VBCABq/pz4xMwJTTtb13JlitiDVwwEIW4CeoJSWUiL?=
 =?us-ascii?Q?uFeHskVMW6pphV5gb6QmXKeCR/83t7c6lPDydtk6tvl04xppPq1VqtA7LFzr?=
 =?us-ascii?Q?5tBTTpMKcIT2E17KONbGslkIXEq/CTRt00Wy+jd4AQxofBpi5/YgMoolEoK1?=
 =?us-ascii?Q?ZywfHgp2YLWJ43alMUvK9qJL9ai8mOhJRICixd+WahHm+iEPf8loEtlUGgi5?=
 =?us-ascii?Q?4bQzlDJohZiBmNi1kjAv5lWdcBpEMsPosHg0yn5bniV7Zydx6uDsEXeA9yUa?=
 =?us-ascii?Q?hZ5qPxCw6HkH7GV00LOsIIeYX3EX2bYtlFE0aUNYMY69SBq0Qk1ima1N8TiQ?=
 =?us-ascii?Q?toA/tho3xCQ2Wbns2bsM2LeEksaVTF9Xa05X8ByG4Wsfq6JH82AaVw/o1pjE?=
 =?us-ascii?Q?aZZGKRgR2gqr9mDjeZjXHiR4fXTgbArBaDxelF7sfgRoVF10PO7WCiAQ7hGw?=
 =?us-ascii?Q?DsuY1dW6cxpWltS22L+tTBXFTQ94xnQ7nqLy+0wQP4OTIvq9Z8n6jgGYApy/?=
 =?us-ascii?Q?UeE5WT336UCg4J/u8rfkQ6BqZa745iG+l+JMI50289R2mSME0ow8+7qKPWK6?=
 =?us-ascii?Q?taqtv/mlpGwq5ir/Wfphlkpgmx5L30/+XQ0VqAUwPWzigEmBOV29QlfGLsoh?=
 =?us-ascii?Q?a4ZX3e9VOG4lEPO99eKKinYWSUeWLEAsO7ydmvv+mE2zIvkbXd+q9D8WX2Va?=
 =?us-ascii?Q?jD2jT1l1yI7YIOrIPvFa559i0KXldQThywdSeCE4B8zbBbVFHhSnNUHVhjbY?=
 =?us-ascii?Q?CLzHk/EF08AeEm1VWfILC8Dxjx+1ig5Za3cjcMGk+9+RBh0LBT1YjJVaAa88?=
 =?us-ascii?Q?O7OYut0lwp5gpYWOX8CFjsM5MpmJrXzDPU53dTBQeRcNnV195dGgPmlJ4PMO?=
 =?us-ascii?Q?uNWNmKHjAMpvQySiW52adFUcNKHlhf7q/z9gG+K593Rc70vJHJZatAQs6As7?=
 =?us-ascii?Q?ExROSjfiH3cYqHHltRhvirFx/E229Py//R63gX+iIdScDbSWDFlNhcDr3EA0?=
 =?us-ascii?Q?RytCcTmshG6A+opiUmCNx73s+dJWXiEsyszWkmvWXKQDeRNPsm4ig2/y1WHs?=
 =?us-ascii?Q?1p4I/N/EWrar5RoSxRn5bogjM7nsYE0RI3XFtrtLn/MNsML0cHFW5mJ0aeMD?=
 =?us-ascii?Q?N+MIJYzsZaArotnCVnmeCi+7qgl0fWCOMDtAktKfFFcu6nHa4YW+K2+Lbg8g?=
 =?us-ascii?Q?2BbD85ksbsipAQG3GBUOPIDV9yZq6N834F9qWnqLKtUuaCQCQHegCly9tnlA?=
 =?us-ascii?Q?0sc6P2jWheMEKsz/orsA6xR0fT5chz3GtoCwBbAlSsARwO+3jV9tqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nC0tsciZoG4h+N8hc5F6gsf89qTVavyMVnWFbLIKgtefcYudCQMfzvKDt9ld?=
 =?us-ascii?Q?i12c62CaSgFGKJhCcvJGI/Vmwp5Yooif6EXGbicJrqR2X5n6RnMKSBDsLHv3?=
 =?us-ascii?Q?CqChFHlUyV0GZ9WFl0e/n4E/+BJbzyou6LkDO54oKnW0KF+P6GpUA2Nyssga?=
 =?us-ascii?Q?rlPhLalEEIFYdJris2KyYKz8ga1LCptMthwT3Jm61G8rLXX49/YWW8D0xKW2?=
 =?us-ascii?Q?71HcCgPVj8yJ0XwUF6pNyFwP5gHJCFujaHfvCgvXUsU9MHenuq+kF05Zt46R?=
 =?us-ascii?Q?4CcAYk51C0FmaMn4rmHluQG+Z7oL+Z0QD7Pb5JWNvaTRJ+y0zpgmA3Wnldww?=
 =?us-ascii?Q?Ie+E8FgbDKGOKlAA9Aluevu5E1VGgWzAGMZVlZ8B0blqXIRRHwqmT2PkpJ5e?=
 =?us-ascii?Q?+nDJSsVss87yTilurxqoAl/wOUVDdafBWyeevKR/mek4Z/i87LA8cPLM0Ww8?=
 =?us-ascii?Q?sX7WP+u9a18RJpem6CNJW/xH0lWKkLpudbIQnfpyzDGBzF6sYz2obj6yOrit?=
 =?us-ascii?Q?ru0VhptGHd62/0UTCAsash4lb70GpcNwRQ7ShET8gi/QwoFj9+HJAcwfGst3?=
 =?us-ascii?Q?RAtdEid5WzIpgzpE2CURizWOWLyFDz0U9Z0w6c68K7IS36y0S5GVLB5Xr9pa?=
 =?us-ascii?Q?dlWEWcWB7kHPjx1wF180ABePQalE4eYnRO1WGIWL5K6hQgHnB0ZYYskjcnLl?=
 =?us-ascii?Q?lEVmJl5b0lxXSbASMsEfCcNblHRu7C1/t+CYTJSD976d78CeuloysczjVa8h?=
 =?us-ascii?Q?yBWi0CSI7wKun/4H6/EOWCrvgU7KSKixCbKWOv80cohMxgMLse5v5EuAhs77?=
 =?us-ascii?Q?kKNKrwFrzoXTZc7rcZnhZEV+2Xjo36Jhj1LVazqLoDWHCXYnH24CQSKAXzQr?=
 =?us-ascii?Q?3crHduN3jhEdClDoiSaP6JGVAFwf03+rv9o3MWsTf1ScoU0LdIDsHs0RCB2R?=
 =?us-ascii?Q?yEmncjAzXxkJHeDlEZRnRbnIbbaZyEul7Zvx2vbGk+qlADPBMBdEuGXFZte9?=
 =?us-ascii?Q?IV/BVfzO8KjGm44cmnwma8aAKU0NkwX9ZVhIjYjKnhBH1opOB3tL661XrSiq?=
 =?us-ascii?Q?Z9MJxok6Qi8JVRW0fauBrPxEzbF8JSDJiX3MDGqXx4np3QKiB/340StuAXZO?=
 =?us-ascii?Q?8PKDTHP782/aq89UfKevmQ8bzdaZJJARavqEuIRAOuEIUjEWEGInHJy1bpnZ?=
 =?us-ascii?Q?fvWxK0Wc3GyW2xiUIi9FWdM+SPb/1fDvHI8Dx//ocsw1dGZnXUjk003XcW/f?=
 =?us-ascii?Q?dGC8Wiz2szNoCAhC8W88n73HWPKtBkbPBh3R1TztjDYxaWhLBPRvjHl938cU?=
 =?us-ascii?Q?BjBCWWVTXkACGctdtLWnZOJVXncnYPob80KWliHUzaV8Wf4mQRyALv5g6Cvw?=
 =?us-ascii?Q?CaG9MjOvLWfFw4HWT2/vPccch6VLOx86TGGJoSK1huO8uqw4bczvYZxDtUhO?=
 =?us-ascii?Q?cjBWwrPvvhqhFjKhu5t0FJeEAFvHLNesvhsfxmB6pn/wjyA52Q+3Zl99L8PZ?=
 =?us-ascii?Q?APCTDsTo6682Kpm214jBasVOb6C6XU//rG3JJviQOkWDuDXy7CJ1jE65bSIm?=
 =?us-ascii?Q?76023K2Cxb0thhRCu2m4Fg1sS6oMn1ZWhU0ortGY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a28048-cbe0-472a-24ea-08dde74ccbd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 22:38:37.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29j5qbSQvmQBP/6VPzyPL5AwkdtWLGGuOmUOhxqWvKpKN7vfCLKigorBRCD2rmlT9HCvcPt7ejEoDhczmNjWhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Thursday, August 14, 2025 4:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; willemb@google.com; decot@google.com;
> netdev@vger.kernel.org; Hay, Joshua A <joshua.a.hay@intel.com>; Loktionov=
,
> Aleksandr <aleksandr.loktionov@intel.com>; andrew+netdev@lunn.ch;
> edumazet@google.com; jianliu@redhat.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; kuba@kernel.org; pabeni@redhat.com;
> davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] idpf: set mac type when add=
ing
> and removing MAC filters
>=20
> On control planes that allow changing the MAC address of the interface, t=
he
> driver must provide a MAC type to avoid errors such as:
>=20
> idpf 0000:0a:00.0: Transaction failed (op 535) idpf 0000:0a:00.0: Receive=
d
> invalid MAC filter payload (op 535) (len 0) idpf 0000:0a:00.0: Transactio=
n
> failed (op 536)
>=20
> These errors occur during driver load or when changing the MAC via:
> ip link set <iface> address <mac>
>=20
> Add logic to set the MAC type when sending ADD/DEL (opcodes 535/536) to
> the control plane. Since only one primary MAC is supported per vport, the
> driver only needs to send an ADD opcode when setting it. Remove the old
> address by calling __idpf_del_mac_filter(), which skips the message and j=
ust
> clears the entry from the internal list. This avoids an error on DEL as i=
t attempts
> to remove an address already cleared by the preceding ADD opcode.
>=20
> Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
> Reported-by: Jian Liu <jianliu@redhat.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> Changelog:
> v3:
> - Update the commit message to clarify the change in logic from ADD/DEL
>   to just ADD in idpf_set_mac() is to avoid another case where the contro=
l
> plane will
>   return an error.
> - s/old_address/old_mac_address/g
> - Refactored idpf_set_mac_type() to use ternary operator for setting
>   the MAC type based on whether the address is primary or not.
>=20
> v2:
> - Make sure to clear the primary MAC from the internal list, following
>   successful change.
> - Update the description to include the error on 536 opcode and
>   mention the removal of the old address.
>=20
> v1:
> https://lore.kernel.org/intel-wired-lan/20250806192130.3197-1-
> emil.s.tantilov@intel.com/
> ---
> 2.37.3

Tested-by: Samuel Salin <Samuel.salin@intel.com>

