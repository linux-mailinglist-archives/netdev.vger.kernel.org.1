Return-Path: <netdev+bounces-134149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C19982DB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C582B1F21F1B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C111BBBEB;
	Thu, 10 Oct 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+E9uOGy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD51B5EBC
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554016; cv=fail; b=BRS3/cmHBHHm1awBabMl3TbR+hfC41YRyCNyCd76icrMsGvhe3upLbxbl47NX5+eoyltwpojPRaFfNMyyA/ng6ICMyT8HLHBIcEa+9p5y3pb9JuVkpMcs9VLJiWE1WE1pPbirJm3DVJ/UHWL6mSc0GLFhMM6KPi18ylEXh7rajc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554016; c=relaxed/simple;
	bh=WMqStIez8D55C8k2uDMv3aURirnBITg8voEdUz6nAlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KgkXxgyYVAP3R2+fnJfuoNyzwUXUVy5717SgpCMz0wO/VGRkBpcy3/WoRcuV1DSIbrQ/ffZZFCKkUcDzrRdAKGbqyu3N+cey/q4x0S4Kt01daleVTUp8MRxnqVN3hDzto47fP/gmp0hbssq/QDEo57zUjAJZC5CVzMn7w+er2So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+E9uOGy; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728554015; x=1760090015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMqStIez8D55C8k2uDMv3aURirnBITg8voEdUz6nAlw=;
  b=n+E9uOGylFnP+ReRYbP7r7NKSfhaUOqhG6hXPiZur2N3548Sv+61Kifb
   zNZK/NXL/B588STiBa9Wd6wEMU+eMy6eyMLRzHLFO0EWI5JfTbxbWxS5w
   9ChNK/Sz6ztFSNbCpJ4TGa6xxaqz9dsjzu/7d90tQ06l2OfTZtLnlhYX6
   1awuwSr1SfEFcQmlmhJxx3ujoEEaYXM5T5qCDxdtLJsUtu+TxU4tItGRw
   TM+TwxOhhk7yMAw2iXTd6hm00kdpzl++JK+iuwAAXDE9k0bVTVmvpHmb0
   3Zv4tA2FWJgh+NrOGxBEk3rkSK8r9qtEnJ7X+49ELFse7bX5Ddup7KR+A
   A==;
X-CSE-ConnectionGUID: Qs+uukrzS3qKbuUwVeVZKg==
X-CSE-MsgGUID: ehE638QKQmarBxebN4lg6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27712433"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="27712433"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:53:34 -0700
X-CSE-ConnectionGUID: ZHBAq+xLTM6HvPSS6U5VYQ==
X-CSE-MsgGUID: 4/auEo2vQoe92bNSZG9asA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76456832"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 02:53:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 02:53:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 02:53:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 02:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raIdcRSdFXwxxUqkNrl752CpZB+LUg7zGsv/q2K5PGY/FsTroF8RPPQVJ20kLy0cm56Ivg5OUUPHrksYty0Uq4yRSXwcDpx941C+cyeiWi38943mW82fhk9p16ZtIfFWvzv3oKyXYF+WGqV3TWmLM87IWTG6ts1gHzpmVwHQ/1Hj2XFDtFR/zIHKfTqhg/lgVdATfZqMoFt8xLEytQtWxACshvJaYrvNm3RVuN1uKWY76NA5Rga2IaMd8LESb6dFOpkUZvS99rQ5edw+XK8U9YDuYcqC2cX4o7e3DFHybe5+S8RTdVmJib5r0mbwLHy4xhY8Pg7kjn32Bvk9xVqUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms9YVPR8Yo76rRly9QiEvZfBNI057ZalK8pbtkGL40o=;
 b=FHq3hFlkOSmuzdKl03fHN8g7OHThLForZ9wzgUVBpgvsxXFTHg6fdj0idPUvfAs/945Xh+55xahpaXJBHTV9Qf7HGH6RunJt1xB+7tCtSx2yVEPeljfGohzxF4CCx65fshmgDe2nsBtWt9vOndpsHBinLzHt5MfjeVuY1Fmdi+YNcd5wlPTfuOBzaJ4g3WKxYlU1S48lxlP69QIOlNKCMokOnawf0Bhr3GezLiw+VGnIots3fIgYDujHRoi1mzN2Fl2JXIzmzV74mH1YS1HeO3gPZUsemzThpUYQd7ZI2I5clO+19JbZx7ksEp/iJxZ647g0WlIy5TRNBJFtskOSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.22; Thu, 10 Oct 2024 09:53:31 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 09:53:30 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>
Subject: RE: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Topic: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Index: AQHbGkZvGPkGlPu6Y0mXskgCaB/USrJ+WQiQgAAbU4CAAUdtYA==
Date: Thu, 10 Oct 2024 09:53:30 +0000
Message-ID: <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
In-Reply-To: <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA1PR11MB7131:EE_
x-ms-office365-filtering-correlation-id: 81f09875-6804-457b-0534-08dce91165b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lm8XtKiclhQzML1ayP5fqgwnjiIkWh6O3Q78nf4dg+/wXchMVjidDwmGGeA3?=
 =?us-ascii?Q?CZzyxJSlxcExpnY6FdYLDgGjhW2Zolf10R4pthguEusWlo1aT3BmPHHa9n8E?=
 =?us-ascii?Q?hUs3EJhWoF7ozOBZakWenSW78pb8rL4KdbmFDzvnQysDapQTmwj6o34ALxTU?=
 =?us-ascii?Q?wGwjeFE+JcnVN/3cJacPVOFpSvhrGFZjxUSrNPH6ITak1cfmF11Dg0RD3Heu?=
 =?us-ascii?Q?L9mvBVJXCcdj4o17/2SuUSTYdNpvL/jiGcdkO42VG54jElWKgdX/tmTrwreK?=
 =?us-ascii?Q?z83eTuTGEXproDCxaZL4pfz73IYgBO5fIDbVcr4k/zLgvhaqOauuwZ3GaSDv?=
 =?us-ascii?Q?J8fuhbHBWARAd5CPs7CipLJ2QAkO9nyV+527WwEt2+9/X+NOyC8LqAxTbvrt?=
 =?us-ascii?Q?xbP3eIi/C1P9m1qmORgj8YJie8gf1XfrWYqHJ5mdiL+X639DiZoNQNfkLcD3?=
 =?us-ascii?Q?6YukP0/KW8pdDltQ0JX2el0IEotUYhJs0UGzJhNzmADvK2X6fFDgGvFLEP6k?=
 =?us-ascii?Q?V6MjIE+tH6ZFKntJSHzYNd5zRjZlZ2aBWVrUuSEhho779Y/NYZxR6s58ZVKY?=
 =?us-ascii?Q?bQuqnGALQ0r2c8qFh5uXtlMCzuNZiADNtpNdA3/vai7UGzcicFFZKH9M2dRi?=
 =?us-ascii?Q?jroTNkzy4C2W/xyTBNltFb539ZpmokiPnQKjz9HSlvs3kyWYVuGUaS2CvcyD?=
 =?us-ascii?Q?dCECY9GHSwJQFj3J4BRyjoclHSjS0ActuP5hbDJVWh8kfY5y7izDBmUGq+42?=
 =?us-ascii?Q?98OZ+uThISyaDg2mnahU5POv21TXseaQwZW3g4sQmOKTyvdk7cQvCzBcLJ/w?=
 =?us-ascii?Q?UUfmmlIG3KGjgTkeNB5pLtnDdCmQdEYkFFWmuYQ2Eujv3lFgNdv1JEXoPOPa?=
 =?us-ascii?Q?8vqGFPSg/yM8snUpVAW+A+DF3L0WUCRVuQPvIkbLwwyGKXbNhGL40h9LjaWH?=
 =?us-ascii?Q?RLCGfdo4quAZYFvBN0BCZ1xDeYKeqK9fbZ6ir74Iy6U8Y4G2O2hHkK1f/2uY?=
 =?us-ascii?Q?SjG4iH+YvSOCqRd0iYBRrEycrsPbQzfgdNu+q1fF8QjsFbfPE1S5uQU5vTvg?=
 =?us-ascii?Q?GelG/0qf8OA0AFjRvSwD7KadmFT9BZ3htEnv45q7U5f3M8Kjgk9q7O30akc7?=
 =?us-ascii?Q?wHXP3Y47XRbd6VrrqTcB7mT4jXYj00meCSWSuDQ48p6+yqaqq2NTXBjXA53G?=
 =?us-ascii?Q?EGiUFjOVlrbBYn5OOuro1eS3PRynneiUGabCa5rIm8Dvi3Vt7Q8Elh2T7fky?=
 =?us-ascii?Q?DOtTgmHVlSyKccd0Tn+fHubRLmB1kl84rTIpXk5uNXEaQKk99xDrN/j+vmRo?=
 =?us-ascii?Q?abxUkp/geJfrP1r9rj8ul1kgA9xMGERG1zP7/cYoV0Xrhg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wsy0AcVeA98BH2Rb5LM0vONg5g1j23mBn5q4R+f1PjgyVr8VAufkM+lUAU2G?=
 =?us-ascii?Q?w+K5Eq5ZdBOy7H8+w5mN9MOIyy75ahIBNX/oyeeef4kSWGkMeVZMJE1hxc38?=
 =?us-ascii?Q?go1VDQuxfRUFXKBKlVGe52T2igOykApMSiHncHPXjUswWrJxMP8KRAU3AwlD?=
 =?us-ascii?Q?7XNX7ID6SJYnjNhJz5YQJXceOK35ywAzivqMJMxENJX+vrkXWhrlIOqfrP2o?=
 =?us-ascii?Q?d5bH4lsfzPVNJc57GsHcwecMQCQSpMa9/ZEXLjJchKrMTr/zCHvZnrybiVnF?=
 =?us-ascii?Q?Usj4c0PUP7Fb7ElHZS0JPDv9l9J6b+fsFHX/J90zLT3rezhVLLuwyLlikOv6?=
 =?us-ascii?Q?V3G3NQDLzmjNR8TSEanDdOkXQC+AQMZLxh1hW4LCBHVkiIuLqQlo9AGzSXWy?=
 =?us-ascii?Q?E/3vJeAPw5sCVBQzHpeH+Ub2oHlcBJCpB3vT5F46CzWqfyWxdMQLtA0r3iP2?=
 =?us-ascii?Q?+NgznQpVGS1poCO9TY6uQKCTo4HqwAS62nn/oBvus2Ny3oQQmdoT9DNmHYUp?=
 =?us-ascii?Q?hvF55IxesLQTvsKKiTDUiq1+dlUtXXfiS7RiLngxcnRIRtBP3EfxbjKdM6eI?=
 =?us-ascii?Q?RaIWE+IovkN12jdb3Y78UErTI4eC4KjKaXhTZSvlESoCTdFZjbY+MobJ8YN/?=
 =?us-ascii?Q?t/Bn/G5mmQQD62Haqqp/ZFNyKDFtXg0nAKeq3xXlPecnBCwC3e6t/AsNQGs0?=
 =?us-ascii?Q?Wu2WmQovehadSaywLViECoCuVL7e2axWC6dwYPDTGwfgbWzxA6tRpWEDyC2m?=
 =?us-ascii?Q?573z/NfZM6kALBykIh3Up34H/UUitmdiTY3jl6PxJwhx7X4yc0wVNIhoH7zB?=
 =?us-ascii?Q?hWNh+ghemHWpVuQUy5Z9X/YfzqQenUZx5Z0JSJXUbwtl7k5nIOFp2bEIbFmP?=
 =?us-ascii?Q?cI5ArYxhFK6Kces5irOBZevagXzNccxzwSdBAiEMpFzfTcnK4lUJ2zH0/6Ue?=
 =?us-ascii?Q?BhMFbSi8+bYnvNCGM3C51HJx8BfR6BhhQbyh4gHzA3u6+UF8V3wuaW9pyIJI?=
 =?us-ascii?Q?3E6oZ6r2sImG/gvkXB50Fy6X1R0sZS7cnPIqUqVyh9B8md376ZjJ1OBMtGdo?=
 =?us-ascii?Q?DY+N83JKjJW6Us327sCHuOJgkg5zx5y2nQxGAoXxuyV4aX+HNzSnjZwMgEDz?=
 =?us-ascii?Q?ioU/wEF7I3sYysNjsuR1Bz8KdfztJff5zU6Ky3RU6+8ofBbR1XzFnpPbBpFT?=
 =?us-ascii?Q?L6BoTL+wDnq0/Cgvxw5SSFZhmBlEFXDaFdSutaOjgC7JT71N/ijfL934tY/r?=
 =?us-ascii?Q?a6400oZ8QLMcovQ6kwPqzim7du1nlYJq5udofHtwrhodic4UPBW4l64CAZYU?=
 =?us-ascii?Q?je3CTgj4IiaE52aKcpHSWR38J/BSQXw06TCTBg/N4rtF+FM3LLD2dmZuoZ5a?=
 =?us-ascii?Q?aFCaxnBUsJ0Yx45z7Y8sbJ41lX6GmbGeKtdqj3jer78CG8GQECJr/d76aMnz?=
 =?us-ascii?Q?AyJo/nFhdS/mym82UPjPT/qxjjyN+bXzBzmeV8gCn4bAd7sEjqSATf3T+jYE?=
 =?us-ascii?Q?BfJjrYULfEW+pW2Vyqv/GMldggfsqo52GwG8YujES2n7gmJaYb+kw6oFjTsr?=
 =?us-ascii?Q?dptQ9ROmskpQjMuaioJ9tHbrXIQ+lmiT5rPGAzu2WtTqP8DFWGfd9sKo/o8L?=
 =?us-ascii?Q?GQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f09875-6804-457b-0534-08dce91165b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 09:53:30.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROnfAOkW3hgC3RJqEtOvrGWhWpEsTle9/4gcH+/yrFr8I09ZY/o1gAyMDnkuQUE0uveZJIAJjsYldAbmRsYRfX7qiqiHdofVbhOvZHnTKIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, October 9, 2024 4:07 PM
>
>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>
>>>In order to allow driver expose quality level of the clock it is
>>>running, introduce a new netlink attr with enum to carry it to the
>>>userspace. Also, introduce an op the dpll netlink code calls into the
>>>driver to obtain the value.
>>>
>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>---
>>> Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>> include/linux/dpll.h                  |  4 ++++
>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>> 4 files changed, 75 insertions(+)
>>>
>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>b/Documentation/netlink/specs/dpll.yaml
>>>index f2894ca35de8..77a8e9ddb254 100644
>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>@@ -85,6 +85,30 @@ definitions:
>>>           This may happen for example if dpll device was previously
>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>     render-max: true
>>>+  -
>>>+    type: enum
>>>+    name: clock-quality-level
>>>+    doc: |
>>>+      level of quality of a clock device.
>>
>>Hi Jiri,
>>
>>Thanks for your work on this!
>>
>>I do like the idea, but this part is a bit tricky.
>>
>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>spec "Table 11-7" of REC-G.8264?
>
>For now, yes. That is the usecase I have currently. But, if anyone will ha=
ve a
>need to introduce any sort of different quality, I don't see why not.
>
>>
>>Then what about table 11-8?
>
>The names do not overlap. So if anyone need to add those, he is free to do=
 it.
>

Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
As you already pointed below :)

>
>>
>>And in general about option 2(3?) networks?
>>
>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined In
>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>Quality Levels).
>>
>>Assuming 2(3?) network options shall be available, either user can
>>select the one which is shown, or driver just provides all (if can,
>>one/none otherwise)?
>>
>>If we don't want to give the user control and just let the driver to
>>either provide this or not, my suggestion would be to name the
>>attribute appropriately: "clock-quality-level-o1" to make clear
>>provided attribute belongs to option 1 network.
>
>I was thinking about that but there are 2 groups of names in both
>tables:
>1) different quality levels and names. Then "o1/2" in the name is not
>   really needed, as the name itself is the differentiator.
>2) same quality leves in both options. Those are:
>   PRTC
>   ePRTC
>   eEEC
>   ePRC
>   And for thesee, using "o1/2" prefix would lead to have 2 enum values
>   for exactly the same quality level.
>

Those names overlap but corresponding SSM is different depending on
the network option, providing one of those without network option will
confuse users.

For me one enum list for clock types/quality sounds good.

>But, talking about prefixes, perhaps I can put "ITU" as a prefix to indica=
te
>this is ITU standartized clock quality leaving option for some other clock
>quality namespace to appear?
>
>[..]

Sure, also makes sense.

But I still believe the attribute name shall also contain the info that
it conveys an option1 clock type. As the device can meet both specification=
s
at once, we need to make sure user knows that.

Thank you!
Arkadiusz

