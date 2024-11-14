Return-Path: <netdev+bounces-144916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82619C8C65
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2521F2427F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CA3BB22;
	Thu, 14 Nov 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maY9znnX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582D14287
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593031; cv=fail; b=coclHO4jzMuJciln5UD/ndf4FUJmcmdVu3vgeWikgNtIKdFIPt3vC8LNetRB4U8zQ/8AgIaPZ53hqxLY6vK5HM0ivpYYTCd6cpM2id0kfKTK15otZWdFhgOL+iXWFKxzwtRIjIsc4ayfuINLrLsWBub6Q6W42dDF9h8oQImeCCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593031; c=relaxed/simple;
	bh=umz07cHUaRAyyo6CJSK5CMjixw92+wd3nDIS30TvBOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1akN4+2BEC9m8XhlBZTm2wXxQTEA6eZ1WQijrizKaCpVKiq1Isth8DQFutkNcF+jVdnvQIvSXrX9JCWidRN7QGTgoR7nZ8c1VQubTFluUO38e5T56JtKiK1SxWAiYZVHeP8ct6yomJ2mbL96J8k/+lhV5OZBP9xghfgGDml2VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maY9znnX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731593030; x=1763129030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=umz07cHUaRAyyo6CJSK5CMjixw92+wd3nDIS30TvBOo=;
  b=maY9znnXTzJRlfx1LltdYek0gfJsjGeiV6+LrOYet4y1LGFtv2kVUtFp
   gzxnlCoEh0Gv+oEG5/cU/oQJouD/jT/U4EkVVuxymR7aTZ9Ap1u9rDKWx
   KY6qBEjiofSgJErh8/lxFMxdzWLvlALqlq6z8rBRorh9ZggvPvrIgVDq8
   lIMzti21+M/SF8n7sJQuvRjemvRnvXeMjPslbtaXyX/tK7GZCtgwb/bSt
   ZHA+eTEfRS1rcDzM9q0NThTQTMkVO70h9Sec9w6P79zE6HJLW5V6NSwcH
   ylkxryOv2+Wpzpd273QwZ6ugOVkWZP4J1o4oTUlwoEmz91SaDRHA7aZJc
   w==;
X-CSE-ConnectionGUID: ndA3b4zzQ6KJ6i35N4Q5VQ==
X-CSE-MsgGUID: aMe+qhNWRZS6ZTRDdM/oRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31317726"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31317726"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:03:49 -0800
X-CSE-ConnectionGUID: NAJirhgDTRa/bTvzGVtjKA==
X-CSE-MsgGUID: 8GCfwrOcR9e2+xOVogWubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="119149686"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 06:03:48 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 06:03:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 06:03:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 06:03:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz2GQlrxwQ5Cyb+aIeQ0XUhXDIWH3hkt0uUcijsOMCEqXjGSLsszauUDG2VACsS3TSLtEIsy+ez/xuIUjs5VQ9V5YFs7bxiReEmJl7Dc/zhNVs3fVG+mSqC/hIN02DE1BfJWxvFfylLBKEIf8DtzA4VRT458hC2PPTw2/xS1Ot26EExehjqpEiBoEcJGL9vkvD5v01GIYJeu1F2JcsVoJrU5EkRASGYrjR2YLo8LMoThrKaiE/LwB4GE+jZuRB39hFNGRmZFPf9+pAI1QCTUrlREmvGW1uzNYyyl7Cu6f0RHosPUkIKPrciwZyBeGsESpILPNBWUEnwjlgnI1tYVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4qS7dqTVPSQVlAzXWgqNwXRqUYHnYYLS5LdWab76tI=;
 b=PWkpe5PChQOxyTp0jzLBgIO0yUIIXzO0FZOH4OeYV4fcrku2mFAJoy7jvxMhIyCW09SyV+AfMvieB5Ixah7DkVPxnX++omEzF/bfa7PbqDxYDd0oM/+e8IhjnDkMcFdFd8UFUM0MWAjS0b5ZQJaEE1V78e6iU0XBaYrtzY3Lu00zeYXhlv2LOx2x0gsKYqhMqUk44OmHupZ0hF/WnD0X0bfEW2CuTiOjjS75mx3A5z0ftOahJQlZwkwKxakaSTqgZ79ihWh8mufQtNdpBjNnnnKTqMU8Y9J2zZMLrNwlN+4Uui9seRwNYiVbc+Cs44x2Gx/JNt5R+Osyv4KcLvFbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 14:03:34 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 14:03:34 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "Szycik, Marcin" <marcin.szycik@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Knitter, Konrad"
	<konrad.knitter@intel.com>, "Chmielewski, Pawel"
	<pawel.chmielewski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, NEX SW NCIS NAT HPM DEV
	<nex.sw.ncis.nat.hpm.dev@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v7 1/9] ice: count combined queues
 using Rx/Tx count
Thread-Topic: [Intel-wired-lan] [iwl-next v7 1/9] ice: count combined queues
 using Rx/Tx count
Thread-Index: AQHbLrMOHt/NT194SEGByMXK3txjU7K23low
Date: Thu, 14 Nov 2024 14:03:34 +0000
Message-ID: <CYYPR11MB84297DDB1B1D47392B745024BD5B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
 <20241104121337.129287-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241104121337.129287-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8678:EE_
x-ms-office365-filtering-correlation-id: 14a06b31-15f8-4e9b-cc05-08dd04b520d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mjxVJW1xeata/l9CYA0kvWAdtwn43hs3j2u/bIKl8P6guu4Gy7klGdItOjIr?=
 =?us-ascii?Q?/gpvOisdCwQoy4+8coeNyiBn2fkwQVSVQlKwwy/FkCTopRnhi9EkgWmucG04?=
 =?us-ascii?Q?Y1Swt2NT1+aqXdefQYDx+v/aGEMwBdhrk2wNqfYJNr8KUF6hsk5B4F1y02Ol?=
 =?us-ascii?Q?pWDJqoyzV9xX3pa2dPUyEt+AN/QXA7Zf4WeUWN0gmRNmVGKQafh3Yu2LPHIy?=
 =?us-ascii?Q?mIuExkSeZ5u2kAQGFc9+DLdxwxYQdaQ45lxDPtBky9JUeSqvXJ3HNcfvYdwk?=
 =?us-ascii?Q?r9QMc6vwkXL5IrahOWenCkvU3Y4GcXRzSfy3WV0ciJ3lM1uXGgDBVZFUSLzp?=
 =?us-ascii?Q?BVryKJ4PXcwjT2XCuQPNGQYZS5kEQjskhOqZsK/8vAD75tEZWWFYBM2LHeHy?=
 =?us-ascii?Q?Z4QAcgFKeyYOT2WqybowoCGGDtRGl4TfVLtDXFyAzgkns3PJypq+AOSQUz4i?=
 =?us-ascii?Q?RCePKMbMYbCZJbhz4mE/WCes7+fa65KQBweA4I7naPWt7d9R92RwmzuyfS4U?=
 =?us-ascii?Q?cu/wpm+HWnOdMdZ9+GvKjHIqUfqEC7M6yLZII70bElYF6tcpMl5Yk9CRphcv?=
 =?us-ascii?Q?EsaMbLz45LksvVu0fKf6uqFSdpoKUr3wK30lfM+5gUZdMjoI1QqdssOqAPuC?=
 =?us-ascii?Q?jPsY+e8B7NYt+NVR4Rk2GjsnKJbXmeTHnaBoUrvgk0N4HTU62GskqkvvujvJ?=
 =?us-ascii?Q?1l1IapyeU76KJT/q01/iUKPiz9NIAerSeLwyM8nPS/TEsu+SY2oDJ01J8A1x?=
 =?us-ascii?Q?tJJv65tdjcucK58E+HeJIopctrPerc+cE4Hdv160SJiuKksTbI6CfLU3kMVa?=
 =?us-ascii?Q?x5FFYB9/Co92q5k3k3oV104YwZIkOHuiDrkxWNUtu6rr9QSNyKXklJ3eWN2l?=
 =?us-ascii?Q?gezOv0BdvIgD6CLX1FtWkMkFOGs6PAaGtw/H2QKyG/+kXYt49Uyt0GmZr8KF?=
 =?us-ascii?Q?yHCWCruGgU86MbLGG5mUCnTko+fzFhAqU1v+nC/Je8+EN0oLh1QFfNFZ5pF8?=
 =?us-ascii?Q?t/sFJGC0hV1mkP/tJFkrt6w1mlNNKD0x6eKOg2DJUCQ6sVD/U+PungjHh3Ni?=
 =?us-ascii?Q?BKevCf/LfwjULrq8ugVKMlr8of5Sg8/T/cj+8CjsKHKL7l6tt26XBVJ6lN8I?=
 =?us-ascii?Q?3Fv0ruN/n9we/RbiK7GfBOni0zpBFdSnMhtz13C3fL74yQ/4nkA1+i7Lue3l?=
 =?us-ascii?Q?5NPS2yvjt2ZawfQ992ewjEaG6wg6S7BhJ0hEaX1btgX1zXEYoL3CnYREf1Lr?=
 =?us-ascii?Q?x+RJ/k7stvQjCL3neeB2W27Ezebl+Dpkjpt0spouGEioxhUXwaA2qOH107Vy?=
 =?us-ascii?Q?JiIgcFO8KYieF82L7LB+nE0qPjWysxMKuNUybL5/9BZ6F0uAcqZFSV5ooBvD?=
 =?us-ascii?Q?g0IxlpE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ZIx0xr62eV5QdC+7uxp3aHhabkAAxqPzmKRJEwm7dxE7BgB94vTKvpakn89?=
 =?us-ascii?Q?+0AsdenoaJvxV4Tx+s9g7tv2+uIN1yUE/0bCTdQPYwGj06JSUacIpuC5ltdw?=
 =?us-ascii?Q?M9zoCpIthgWC8Xxq+EAWCvjAfRyw4HeN7QYUSckDte7730RztTOi+yYage8S?=
 =?us-ascii?Q?HH97jTYCJxXoChZE4pz0LIWIR/XMENKbimhNsxykBiEahYwAZu6YeLPrz3Dw?=
 =?us-ascii?Q?yeSCcJfkVUmothnyY+KxYXUjDW1XGzhR6YaDKvslPlX/f0/XwDJMD00jz80r?=
 =?us-ascii?Q?DYxkaSHVD/7tyZpkdW4w7/NhULoS0ZCdk6UOhtpEmoLhHWEwTNzmCy7nL/mP?=
 =?us-ascii?Q?gG2kMJl5uqyJBxxIKNaENkYn+nuWkw0i4p54Cd387c8+g7VZTPeNngap/tz9?=
 =?us-ascii?Q?SasFaq0cMHl4fNNCpEABorXk6qdN8DHngn5oCnQ7bWv45x++ugiOuOpWIAm9?=
 =?us-ascii?Q?fJbWksIz/GwVBQUF9k4FFi0brKrmA+vDQoYx0jQzu9rXavHWRwd2SgJAFrAu?=
 =?us-ascii?Q?1Vfqp//9+sRgmV4+dEY5rxSsmn/H8CdhoBAW6Jz912nNG6DsQkio2+4fdomH?=
 =?us-ascii?Q?Hb8WNWDTepORMDwyk3I1XtvIFHbfcXD24K4wffdFLqQChZB1QNES5ARo3LLm?=
 =?us-ascii?Q?vGk9AHrkO/7r5/aO4v7LYXUugABWcSBZuHDKldZDKEEej1EyALi7J750CJ8G?=
 =?us-ascii?Q?qVXHf8deJXFHmbp/sz6VTNDVWoAudxRoa34+ph2Ap2lUhJn+OQfsh0SHnJoB?=
 =?us-ascii?Q?H4jwHJ+bGbmcER3cSVCnsS/R6psY6FvGwjIwbXkjkXs9R/v0Mrzn84ljRrBm?=
 =?us-ascii?Q?54pVKlzI/mWXXsJOgGf8dq8oiZSlipJXLspcd/Dv3MzYIHMWcTVsuISvtKSw?=
 =?us-ascii?Q?KR4jSIKlkU0ZnoOGDEiJ4nyjmt/Rho6bCe4v6TbA8OTCBVL1LHySpVjYQcJ9?=
 =?us-ascii?Q?bB/N7Hpp8SbRHjpvSHvvB4PGIT40QYnKFoFvzPmUoYVTyRQPX+VzbHgDpqKZ?=
 =?us-ascii?Q?Gi3WkVGKnu6kjqLeNTL6vh07YNG+GYDxrdxvLpS0grDDdTT2wOFwRWCbgESZ?=
 =?us-ascii?Q?s4LPqc4dFOJRiPvh5QyXGeT/FmLJ6PkBPJcHxGvhQ/TvERTVhjPU+/XG2Zza?=
 =?us-ascii?Q?54t9F4mmfrjH6WwLOg/t1pqzdFIeJSkvu2UI0Oj1biv/UkIcSzot0Y9JmnvB?=
 =?us-ascii?Q?JUiDWBn6EDkvbMSnv2ogSN1Nq2jkXPp0hts3dC9FwaxpiEYnPBM8oC/ALh4X?=
 =?us-ascii?Q?+r9I4j0UBWuyIVgpTCKdnjzGLf6TOigW1+ttwJp2MvPizEuOLJnHnP9U06aa?=
 =?us-ascii?Q?79DxUCLTxY0Lhq1aITVHYi6ITiQXifHi0iBH+m4BNfccdZfZe7l9W+dBifMu?=
 =?us-ascii?Q?II7NPdEuKNlq87vR+AOb0fXE8uIIungl4mJsEEaybOmwvW0I5vAG01Wvontx?=
 =?us-ascii?Q?nWOvCd+NCiZFuJvZw/ocFAyez/2PAdSv275cqyFaXCCgcJtI0ktrQ54v/laQ?=
 =?us-ascii?Q?dwU1hz0mgGliejDQWpUn15Pz9rflambP/sLcgmi7ny9qZQH+7YOIwjdxBOCE?=
 =?us-ascii?Q?0GMc9O+PQOcn8Qp1WXUvg9wnOBeC4zqZE4WtYZoerb0oGSTGla6BJlseQh6R?=
 =?us-ascii?Q?NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a06b31-15f8-4e9b-cc05-08dd04b520d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:03:34.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ji3ax+334ibXfVTEnlqpyDJcMUZV+mf1kgrXt/7j1b6763hU56+8x9p4OF35NSu9ecp0vqC41k+oI9h6+ymj0A99LY0PTEcnmAWEl45eaL/ASbK/RT639Yd9534UVHbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 04 November 2024 17:43
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; Drewek, Wojciech <wojciech.drewek@intel.com>; =
Szycik, Marcin <marcin.szycik@intel.com>; netdev@vger.kernel.org; Knitter, =
Konrad <konrad.knitter@intel.com>; Chmielewski, Pawel <pawel.chmielewski@in=
tel.com>; horms@kernel.org; David.Laight@ACULAB.COM; NEX SW NCIS NAT HPM DE=
V <nex.sw.ncis.nat.hpm.dev@intel.com>; pio.raczynski@gmail.com; Samudrala, =
Sridhar <sridhar.samudrala@intel.com>; Keller, Jacob E <jacob.e.keller@inte=
l.com>; jiri@resnulli.us; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>
> Subject: [Intel-wired-lan] [iwl-next v7 1/9] ice: count combined queues u=
sing Rx/Tx count
>
> Previous implementation assumes that there is 1:1 matching between vector=
s and queues. It isn't always true.
>
> Get minimum value from Rx/Tx queues to determine combined queues number.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


