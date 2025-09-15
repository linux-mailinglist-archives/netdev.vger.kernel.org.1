Return-Path: <netdev+bounces-222925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15470B57068
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212643BD8FF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189427FD49;
	Mon, 15 Sep 2025 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxxJaQEP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931E1E260C
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918207; cv=fail; b=AupvhuWWKk294WXePrFl+3HDB8egemd7RJMEi09ereKJXSFw4L/Hu7Vk0qYAFcGfKta+Euu+jh8MLQRD0PflogPQVxCPnRH0dFDXubXAgeThMgwOGBMZer7j5wyx93+rD2lvfa32kOqJ3qS5AugFIU/XBPUKIEU6Z2mSITOQ38E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918207; c=relaxed/simple;
	bh=fmYh8OhoUx594QQkbVtiOVncgALlom7GT9ye5/8TNgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzJ1td0AAsGKNWY4689mRiwLjJBJ+Ns+35BIFlwg3ErGFUATfJIt7NLXBCmBsurYag41kR9ZkeIZfgLe3/uhCgQJG6gUpNagc+xzgbRO0KQC0f4wDe7Pt7weQLxGxOQJ6vLwyREy1u/kuHenhZqaUypg9DzzEwZ1wYS6HA6g/ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxxJaQEP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757918206; x=1789454206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fmYh8OhoUx594QQkbVtiOVncgALlom7GT9ye5/8TNgA=;
  b=dxxJaQEPY9rvcKHhm9/e0oHMJVn+rKMiBkDJU3JSX6RvjzWfVJKDvyR/
   N4qTHZsGeC95xx8JnDhD1WPp3+sulYX3fVk6bSaYxHz7oLjtyEbPDUukv
   o/vaYgwwOxpGFqNH6Sh6/Etqpge7zKdlhzbrWRN6KN9J4uXrbfCU2XW7b
   kI/M2GNBKj8egw7LYT+Ok0MdPEmh1fBLyNHpxJEcfBNQXA1zmXf81sALM
   BkpgHZK6Np2DQznqIBtgsyQME+NOQF3TMCMGrvx+tYYEMDk+p+ziQmHov
   TLuuogZa6lyyHJmruQ8GgUfgZAUg8wuPLzDVIXU02+yEXtjC4WVMmrQ3T
   Q==;
X-CSE-ConnectionGUID: NUVzLFMCTRiJm9Zo8dSnBQ==
X-CSE-MsgGUID: iUt0QYf9QNqrQy/QcHrfQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="63983828"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="63983828"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:36:45 -0700
X-CSE-ConnectionGUID: WpdWYKpBQDmKUdoVPZzOhg==
X-CSE-MsgGUID: S2cCPoDsRRCvEoH74ajkxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174350313"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:36:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:36:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 14 Sep 2025 23:36:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajNNTq02aPRKuw/P2A8C7Oq6Q94OuQ/muGTp4jS5lgL4cKRqwRMJAegWRRd7wRbv3gUg151aR/yccSaBV05xp8wDu8ASNDRO437W9XiNOWF9EDnrFE2qXnkOMKJ8GtW06ffAC4qLC64pVo5Mm1CFE3Fc9iO5vX105MBoc8LhTrMmd6w7GvDctGM8Noc0j1n+Y0ewBPwkfEhIbZZ2m7hmDpDY5B90OOO9ygmHiDfc3sm589zeUtKNUkx40ix7pct3r4dNIbO6FM7fqObfc8GCOiBxNl0kyeCMGmlnyZCdbTuXG0c6pzj1ol3qQzhO5A7/YLaSx6VExgzRd8nobsvnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmYh8OhoUx594QQkbVtiOVncgALlom7GT9ye5/8TNgA=;
 b=h7QxfPWlHSGcPiox004xP8gYewo7ukxOMEAxN7PJJwGPlBOMlZWDHhd644vzqrRdPElOe1uGdbNeNojhHOL7iWK6I10kSk7ZMspR6I9KQgNt/2mAO5pWdQYQOvqAqeu9QA7yX8ZA/n30JMYDXkp2G4eFw1qLGSdEeONsqCNpmlNMUEKqQP2MT8DlgT1mjl5BMhahSGS4l4N018EfqYDcDnb+tm5zQsSOofnfLlYab60WDCdZNikQw8uVT7LJdTX/Wu9Xa3RvlZfuSs+YuJGb9kCy7frEIii6TTfv1rRxqsBRg8QszC/KSHQ9IF9JXDcqS2Yhyaj8mMHfBWhVCUxkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 06:36:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 06:36:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 7/9] ice: extract
 ice_init_dev() from ice_init()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 7/9] ice: extract
 ice_init_dev() from ice_init()
Thread-Index: AQHcI+eeet/XV5vfxkenKl6rz6O+0bSTzhOA
Date: Mon, 15 Sep 2025 06:36:00 +0000
Message-ID: <IA3PR11MB8986D35D5E935ADBDAC6224AE515A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-8-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250912130627.5015-8-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB5803:EE_
x-ms-office365-filtering-correlation-id: d720c2a3-383a-4285-45d5-08ddf42222f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?K/3N/fIu8zyX3dDfB751r8nS+SdzJlzsmoRMyo6Hh1jgmd7iU6IcFqx3yS1s?=
 =?us-ascii?Q?thNasH+AfbELGUqQNqZkLMI+5xe8Nzbl8EYBxD2zdKc60FZfekDbSevBbKsQ?=
 =?us-ascii?Q?nuwr7OgKYCYe/Wemkn9cUlbdFMJxL1iC3NRb8JO/LbtvDl4/G8wWFNw+7xI5?=
 =?us-ascii?Q?iCR4CC8VtZ0V8ra0rZ0BfOQCKB5N7PNYLiwQgWPA6LwI9XwUns4E+pvE6IgR?=
 =?us-ascii?Q?0aY95/+vPtiQybshy53HZG5lwYSgSPVhzZMQBMHkeuvApftkt/VMSxDlMjH4?=
 =?us-ascii?Q?1m4KONcML7Y0hmRn8fzhiPNL4SnYnllun9REwTqLM4DfqCaRkED01qhQY61T?=
 =?us-ascii?Q?jo/JJ6EP/9zUJeu9vigeUG59gMwGzTm0qbdyCH7pG1sr18J2Jc5MkR2DgXN9?=
 =?us-ascii?Q?i432iNczjgAzPviDaBnBQDzbQaS6u/0xsui/rCyDb7PlfdSUPzx6bXi5i7vM?=
 =?us-ascii?Q?7Ig+zn3PdDm0QaMuBLrHu/0bZoJOIXzZwl3g5i7tjSXcd23SbNLUasrkcc2+?=
 =?us-ascii?Q?92tmhbZH+VKJ7QT1ZXoI3mTLsl5mGYvEZLrP1w97iaJzjKrg+KeziEmaJqt7?=
 =?us-ascii?Q?0rI0AksPZJRau9xBdFspRAreZvCtkcK9F7ExuTJT2fqq0GPM9+IxHl6z3yHf?=
 =?us-ascii?Q?vXWUD7nvAaNSM0X33zeltPRSFNDA19Cqa3ouiI8Gwl3iSMZwvJnuX2mz3J0O?=
 =?us-ascii?Q?qcUF/9JYZBz5WdX/pMzATTTXpM6JLVW5XJboHBqpUuYDHagmiP7TQpQoAwLB?=
 =?us-ascii?Q?tH9yPOq+RvupfuWTcgKNhwnbsJEL89MzjHh36IYYLUWu5ujb8QlQxg8e4K2t?=
 =?us-ascii?Q?imdcgTjrtcpE58aC6+lZYSa9mhahzyYdHV02wsSSH4DSJDSpQX52U7WpvVZD?=
 =?us-ascii?Q?O5p8Nzjq745PTqVULyZUKyOIz25GSW6v4Hcqw/6t8PMFUj1NyZ2HSGv+VZKX?=
 =?us-ascii?Q?11+9Njo1U2cmLXkNifG+zTI/3L3Ys5er/RRtJqg5f155SBNimvPIhf8CHia/?=
 =?us-ascii?Q?iUCO5STQQX5xrG4mZJv8VKYmDNPIBYk7Tttyue/avfJXe1Fd+wD5h6JraBYb?=
 =?us-ascii?Q?c0nyMT2YoFa8vLzmWZYTRVySFDaonWGRBCxG36gkvljkFJGiQbJPIBxU+Xh/?=
 =?us-ascii?Q?VfEdUCOEqT73yowtZzoRbMKYxHPQ+NcjE9kWfNdHzC4Tb+3CUv7RqNxLzSd1?=
 =?us-ascii?Q?15hXZ1GJCCr2GYz2jtfsNsY4EhV7zOrbIocSrrAJKWEjt2oM9DJ7NB/xlcQE?=
 =?us-ascii?Q?bOIeNrd4OT//cHuMpMVu1J/PDMc5NnIBWtx3BMmh6kdf0+rCXmJAB2Fp7+AG?=
 =?us-ascii?Q?xnCV3OTJ2b7vJ3NISJ5qHQuDBjCHalo2NcJMo47+IF2T5bhgfDpGwDHxrEyk?=
 =?us-ascii?Q?CbBhPWbgCl/NhpgiQF7dQfslqliUt8kq5V1WepExY09aPypvJ6xVnxRX20zA?=
 =?us-ascii?Q?LWMrnNqU8OJjoCcSGakQ9/WwpvG7eopHAPm5pwmc+jzhiQvHjYTPHIgsFaBk?=
 =?us-ascii?Q?9Z+ef8ofhxMn7vI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OnIcGSIaOAq3Q+I9vBsLDpLnGXisvU4lRsF97EwLHbjeoopqD94XtR+MooQ7?=
 =?us-ascii?Q?WuMdctwYNvdCWx6WHjeIO+YE1KCiaec8dOnCKtO+RjieDq06EVGYkKgUzpjG?=
 =?us-ascii?Q?LmhyWyjXm/voMJonctaXYTP7nVOTC+wEeuLEepMMRlIEfFkMOuAUBA54x5bI?=
 =?us-ascii?Q?4t4NwrOgTwpcxQ8cxSdk//yPBTP76vtcCaK8IctZCfB65lcjfP+YOXiLvQzp?=
 =?us-ascii?Q?ey8rRjBdImDltOIsmvMwh2BOt9aHfZLqrEyXxbzVwDXKXICVnLr5zwSKhYTc?=
 =?us-ascii?Q?kk423xjNsh3JMF0WL6Cjd6T1vmmHeGGu6Z1n3tC7z089T1Eajp1oiku5IqMG?=
 =?us-ascii?Q?u33ezas764yUKTUq9pJKlVtZFKa7ZnEJdeRArw1lOw64gHjTS3lWZiqG4jK0?=
 =?us-ascii?Q?jeJn9av+Ey9+rPwbkRz1coY/IJTay9LRTPs2/wywgCrasl+47bKVmfb8taf0?=
 =?us-ascii?Q?HPYKR42W7mUHP3I00r3aN2NWfNRUDH3m8Iu4wuwj/lMLik9u1PzIMsxnh9Tl?=
 =?us-ascii?Q?nBlCkQj9Ni5dwjm1KsxjcY4Zd6All3DPVAC0lUnzoq1sWK0w6uQjkyjrNkQ6?=
 =?us-ascii?Q?SwgmkxQWXL36G9pzmvR5mdwGCArCt6edVTqJ+oK00/TUpC0VIKy7VfVXIVk9?=
 =?us-ascii?Q?3UiQT4sS2X8ss2ArQvjoBM4xduGFgpVCboxBMLazUAjCcO4vG6DV7NqL1u8f?=
 =?us-ascii?Q?iTNi+VnnT6m1fGYmEg/QBCPc85AS3zxw822lT1Ct++4eWd13HZwxWOeXlZSf?=
 =?us-ascii?Q?q/NGAK22XK6yAd/R2bNzXFAngpJODdqVLoFOuEbdMnm6JSldEi3d6LpoPcHX?=
 =?us-ascii?Q?kS14fLdxn2yHRGeGY6ccnaTbJwjYH6OfkuUHxojE/xh9VyCpw/L/qu61007/?=
 =?us-ascii?Q?rcGQ164lCDqWDSVLYbt5d1zdC2BsexisXXghQTQEp8/GXlbt/iUJdufUHLcs?=
 =?us-ascii?Q?ZsHNydqK9O7EBHCf55jafn6Tgw4vipk/V90+2DGi0SuF1AH+wQ6TwSanQe0x?=
 =?us-ascii?Q?YsvPvmLBCrDDE6qzRnq3aLlqsYJpGy09gF9w9/s7IUtvdctxfcxJvCQO7Uj0?=
 =?us-ascii?Q?CEDyxZre8zgSG4KDLbo+erJVI1lMKjmQlnAY+TohHUa+ty0fedQ8OMJNdnYz?=
 =?us-ascii?Q?+Qz3Nb732dkgwy0qN0/uMxNHvs5eHMUi98GA37PxocGQ27LtFCnxjMwm22k2?=
 =?us-ascii?Q?o1Iz+8D+55Qe1FP/okoeSDbo9vDd3UVl7QrazhWnKfzad8sZUXcvOBm74Rs+?=
 =?us-ascii?Q?66MOyGNREJgT8hpp22rtxezZKDVJqUOStLy618bECRnC0Nu8iOw09KvGgQQq?=
 =?us-ascii?Q?VRnoxAL1OUlC/i3Nm77k3hNfsje6cItYWNPew3JNXlYEa/u1/WzwjC2idNxM?=
 =?us-ascii?Q?7MnX/vdvxmatM/4pJpwin/loPO3L0oN/JRaisuPMZZrOgL5jsw51aGeKeDuB?=
 =?us-ascii?Q?10+Ni491u8CHjF8iel0WNPdxuPqnTUK2PHz1znAwBeVPTqhTHCvO9z9qw+zo?=
 =?us-ascii?Q?Kn1vN3Ly6ODG4WFkBmIDs6ZfWHxu0LDU8fj9A49VYvB+MxoAmnc0bCOkw0oP?=
 =?us-ascii?Q?rYS8Fks9gGvFLRd6/ZI7pF7evvFp+IcnUx6XJa2cyx98Asg89rX+DxjYhcFk?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d720c2a3-383a-4285-45d5-08ddf42222f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 06:36:00.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPACC2xhG5y4JCDbZ4nxUTh5DegO4ThlNx8iYaTW0U8bV8U8W2jXlis3M256Mr3ySukwfspuOO/OHoTy+nOhrEVI3aJnNA09z/iogpE0eug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Przemek Kitszel
> Sent: Friday, September 12, 2025 3:06 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 7/9] ice: extract
> ice_init_dev() from ice_init()
>=20
> Extract ice_init_dev() from ice_init(), to allow service task and IRQ
> scheme teardown to be put after clearing SW constructs in the
> subsequent commit.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

...

> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


