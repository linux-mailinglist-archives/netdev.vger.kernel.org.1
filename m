Return-Path: <netdev+bounces-212415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF18B2018C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 10:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4877716188C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281421772A;
	Mon, 11 Aug 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xf2+jFVb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789226A1C4
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900223; cv=fail; b=Piln6oevmwC6PF26++9soW9T0zOIAlBdE9NeebcwX47mCAjinnk6vw6Em2+7QP0CTkU4DiJeh2j4vP6lkBaQFtDhWhcq2jFftoSFlBE6yhVj1a5+RoEtRU1JIa9suSu9tlq9tZ+9wGQ4ERTexrxwqvz1TDuAGGt2rvWITiknAqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900223; c=relaxed/simple;
	bh=YLiFxTgGLaD1VsMUKkZaKLQ2fDLVZE+ObQr9uGfKIZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXX3M9nn2pl1hr57dQpFhufdj87c0otS694DLe640hgpokYWH5ooepWAQlBUs89xvsexK4mwzrqspV3HVH6aPlxuAqOxLADqphwrSGaxQjVyiL+BDNRIzS9mMXMfqyjxLO/sEwZxjhvV8/FIZ+6+pQga0hBIcaio1cUbhwpzz8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xf2+jFVb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754900219; x=1786436219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YLiFxTgGLaD1VsMUKkZaKLQ2fDLVZE+ObQr9uGfKIZo=;
  b=Xf2+jFVbf6KSoZSAL/Yyhw/2Q18hW62C95KPfIpvNLl+Ujq6RAo3zAMq
   XR9/LUY1yG7DZMYS9wCNVnHUhy2NycirNktSBl1pcePZA4y2PIx0x6g7B
   MBnkeuIgJok+HYh4/Dqe5vr0zxDPuB1wjwRWlxx2cJXuLjzYI2yPQPUgi
   V3oGzPtq7qSDsX1SGU7S3ssWd6yTHnY3zL9bJ4/bfNn4hW8akl6j+VgG3
   GMX8GCuDiE1lP2y+4WBaqfBgQdIpzLYPvekth+A2FTgBBwo0S28EagNon
   PCxz+H8FErajtpu0RFAN2SkM8EtGszvgtONkuxFVn9gFXZirtSiq1Ojv5
   A==;
X-CSE-ConnectionGUID: Idh/5XldR86GZxNj1Bx6yw==
X-CSE-MsgGUID: vD95pQzVQTueOu+1YYY0pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="60776536"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60776536"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 01:16:58 -0700
X-CSE-ConnectionGUID: 4EcEOWSlR3OJPA1NhJ1eAg==
X-CSE-MsgGUID: NdyyXmhzRCiBWE0BCOLX9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170065304"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 01:16:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 01:16:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 01:16:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 01:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfT7aR+KJj5ulxFUcPkY8Mek1LKqE+LCvgm4HE/bDTkO0o/1PyzxA05xkqmSXPnm6U/DxnB2gQmrHbTNf2RF0Ct+8TIJnkKqfQ0bLkpYfno6TnD9g8Q2fRhpwKkFE0XzLkOivgtdvcxd7W5LP6GLcmJ6TsM40ShduSqcaNyYS2ZFiZFu+f3YEUQkU1jfXA0PgZbI1/Ry5fDzNZOLprw44qz/+HHUKJZI25MEAof1wOru2D9qBmJxJNmfB3ZP0qRguvvWJ4vqt4naLm0eNqwEvD8alYXxlu+kDEOBhm8ZHTN06GZAv7e0Kb95/nD/RF605uBYfxAXslqVROaWe/fpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7Kl2eVoq6NxmuZxNX3jKXNEPN5OxdKtguxdyzVg644=;
 b=uNIdppyx85bVROKzK7aN+6VliOvLRGHVVgJWn1bwocYcYEM1okXMiCqAq4cIp0PnhKSIqPyABCQlBaF1sHa9TRRA2ZU4/FyCpnbalz96AzuZPU3+jw8D9/WAdClPVvbRfEwcd6+jiPF0XTLm9YtddBaK+TzlECKSOLVxcuoFVRXyDfWgIrDcS8jXwXjGRl1YImtDQ7wrrpaBI+Wt8YVdjGt39gx4eWsdhpIHxjczYYm29Sr7XjwB3GwUEqxiSuwPAmAFg7gpQMVQyJ9DV52Cqy16KAo/mwtuaguggwhqJG3wifGZ8MtPBe4cWWD+HfP5wWEzkbnQDDJgBMEqQKiFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF6E320AF71.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::833) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 08:16:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:16:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kubiak, Michal" <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter for
 buffer allocation failures
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter for
 buffer allocation failures
Thread-Index: AQHcCHy8bdBCi1HN8k220V4e1Z54+LRdH2vA
Date: Mon, 11 Aug 2025 08:16:45 +0000
Message-ID: <IA3PR11MB8986A93931BC654D32B80085E528A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
In-Reply-To: <20250808155310.1053477-1-michal.kubiak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF6E320AF71:EE_
x-ms-office365-filtering-correlation-id: 0a663519-7162-42be-607f-08ddd8af691b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RBW93gDHZrVYnhe4kQ52dOyxc3zmodeYUZ/1YTx3CWQAhAH7jkSK02n69C74?=
 =?us-ascii?Q?xurKowTd9HKlYtcuqkeCBMzCjkTuHEMjBJmvdrF0kvpc5cKSbTwjVyF7eECq?=
 =?us-ascii?Q?s8Ac6x9N2sK3592MK5epdE83f/ehotCMB8tPTRazkAg8xebSFgxyPqZLgIh/?=
 =?us-ascii?Q?xm+lpTuw5oN3NKwu/lVVklTRm1xQP4uXajEgMpNXuU70QnvbGU4FIkNKNE6d?=
 =?us-ascii?Q?ynwSP0ScKleTyJSDSJw8eqTRH4MPCoh84VN3a4u/Nd5EQVhsnkolORK0yjPw?=
 =?us-ascii?Q?muxvS6pbIwuTKUqB4i7ep8TV0tPFT9joqoCKCmvT8x2v/ANA0nLS1I1cj4C2?=
 =?us-ascii?Q?eS1aDSDaW9GlC0Lb8eALBCTIwJdpfvhxFLbHsC6IIZFvCsweD6im7tFwigwq?=
 =?us-ascii?Q?AkIR1kcSz0HRSIzr7qofJCxzuj86jJPPI/uyoWy4hpWZWqw0+QJw4quS8aEz?=
 =?us-ascii?Q?rZfwyoB5GMbK6acxYt3MJJ68fKrtmzHpfh+C6qeFyx5E/9zJt4/M0pDFOglg?=
 =?us-ascii?Q?QjXMtccSyniFzOwl9P+IovjKK+Us8ADLj1FGzx+5rIw/jnHwTAy8NlV3he3a?=
 =?us-ascii?Q?WqD1RQZUvR3LfKxKJHzjTkz4vAQpzq7fPo08XuKiGUM9s6f43PyJbKaXF+Dp?=
 =?us-ascii?Q?mVDOOW0MTeiUNfwJPTAd65pYMWiPerUhVpW9avLnEpA74rLYqvyfvh/2y8w+?=
 =?us-ascii?Q?Df3eetmlYiorn3QKgqhsYCHcdxwrLeHjIqEpv9swhV4i+XxWTbMuYJpdxiEU?=
 =?us-ascii?Q?eyGFdbHbhkmO0h9qLXSA+2QJBWcp0PGAmh9eaz5Oq0HsBnjHZnIJA6uGl9Im?=
 =?us-ascii?Q?VluIkK37QFuSJc9bl96lekmDQSke/vtu7mTekphFEfXj747CQLMcmFtD9wH0?=
 =?us-ascii?Q?P34ksts+kHewmyaQ3/3FI3NjZDQ77unNvPTUktz4Ym2+R1VNpTzZOj/k/lQ0?=
 =?us-ascii?Q?VA3CfVCfGvPuG9WabwZhQHIjzPFnaFwsU24wWKaIUom2xLStyS+ELDthiFhS?=
 =?us-ascii?Q?+zkxfl5fO7i9AQwV1GvN8n/hhf+eoRWan3QiKALQZFIrknWbflu8xXLqc3iw?=
 =?us-ascii?Q?UyfCp8THsYwIUF4KWfnH+oqW/EcPT56DiiLlN/1uKw4ThIpiVHkk9fv1rEaO?=
 =?us-ascii?Q?3fQkw5QNriITK2fV16vXqqkQIDCmKgA2CgRLo70ExXxw96mJ9efqyKSMLpp+?=
 =?us-ascii?Q?Kl9tQI7nvSTFyc+op0Atqvg5I17HxG8g92t9HrN9PnZWwCGVQNvmhknbREHK?=
 =?us-ascii?Q?/ipeMBEqFv+JUDas6eai6g1srGLSPcsdi0PuoQQM+IToK8YXwLpeM/tycmED?=
 =?us-ascii?Q?Nzo1nFw0Y40sdK21EsqFJziDY12n3FJiqyDRe1GTZ4UEStteJ3udrzH/NlPB?=
 =?us-ascii?Q?WuuQVJe0Afw+4tQbbwKyjduM7h2dnn1AjlROetfoKzHCg8wri2nJutxtJqXg?=
 =?us-ascii?Q?oQjXNMXmKeJdjjF7fTYhUElE8TyG56BVC2R6Yf5yNViV2gBUJ9237PTw+31O?=
 =?us-ascii?Q?S0cJ0a3lfcwRq9o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1D8MeCxNWYzgkIxaYPN1PxOZFY82umQyfzXHVLA2+PQV9g4qgoRc7+KQjQks?=
 =?us-ascii?Q?//Ko2CspetK5+XOT5gsGutC9/jOEf22hQE9cVvO+603nm6En4g82XlTIMK5l?=
 =?us-ascii?Q?WAxx1x2lcOjR548iqXeQUcxprdrqNcnpEtMig+nVUaVKIy0bxXogobALiQ3g?=
 =?us-ascii?Q?IxdJaHoqWdHThKelFkJonf/NkUUuaxANSR5/sEEz4ngVCikW6KUVT/B0cS1r?=
 =?us-ascii?Q?TrspXmbHRBTCgxUEs1CgvDomTkilzDms3rpUm+IJ11uy5AW7veitiv6JZ4ba?=
 =?us-ascii?Q?YpQVDpH7GiAbIma3XmtLyqRNvs8FxKZFC0OdPwgYWMipls5uaD0JuinvkixQ?=
 =?us-ascii?Q?FNKayeBd6QRFVyHl7zbVps7X/CHISTXgmbSJOqe4yz0k97zfoqtOnAgg9SNr?=
 =?us-ascii?Q?MmGGLMwMaH/tvW4VtdIkq+2Q6b1tyH80pNe2TxVDHfyPbeiV5jGcD5saN8wv?=
 =?us-ascii?Q?dXdeKCdox2UCC2+lrjHlnlCDrwbnojq9gF4KX0dcdhVs7exyOc7CoHcMEZ/V?=
 =?us-ascii?Q?Su1Kh4rtHgH/DKXsOItQKoz0JaE08QR5R4zxSmAvFolvN5PrNFpC99gFOPwV?=
 =?us-ascii?Q?u0y0JFHQ3Zs+GUDDOg63kUYSCpBNwLiUwCnlJApYZ0e9mU1E9L8ExEGOkV+a?=
 =?us-ascii?Q?N6oeifA1MH84UqV6CVgh3+WvgKHR6Wzy36Jo8v0GxMRM5RHxNual9OQfKy9E?=
 =?us-ascii?Q?ifLQ66j8W94L7pIP63SFXc/ieAYtzgDJAySGT8T2qA58/LzKrARvVmBaW93o?=
 =?us-ascii?Q?7D8E+oNp0ML0f9LnhxMPXjydh9+f0Gdtm3+ZLtqRlx5KjOShPbDIPgf3PH0W?=
 =?us-ascii?Q?FkrmTEWkmQncwR+FEf0TIHUg94PxeSnVT4tpzY1XLs5sdVni/Nk37dMrg9JT?=
 =?us-ascii?Q?BEYWhOf2r2Zaghk/ahmZvqoXD6hUmoJqy39veGRFzlpCPZB7buYm+MMbd9WH?=
 =?us-ascii?Q?uOuicUC0EYv+e27uX1EIUgPgIQRsQjb/mB3vBvHkcjfke2apSA5UedSIQDqR?=
 =?us-ascii?Q?5aYiFPwy/8vMls75Cw8ENPBbAsIIoNHblNcMkVCuS2EAYApS6gMlpTtBgYvR?=
 =?us-ascii?Q?6d+TTMYF0vBW4K8kkjWGi+hnWreHvSwoa7VwszZEgZvj9sXd1O0JtnwDt0Wm?=
 =?us-ascii?Q?5zH1JeQkr1dWo+oo5KuD3FZZM5iG+1CiL0LBJG5wzTPAdoWHIiYsd8wOd1G1?=
 =?us-ascii?Q?mTLBeMfo/PmZIcXd/o5ATNaChGUzKyptjBSyGgHikjRj7zWILXhMvL/wNJpR?=
 =?us-ascii?Q?+Ty1xocBnCc+6XAaKLCOkJcwUGAT5lCnG+uhV1/89Ur45vOJdgHwHmGTHTj9?=
 =?us-ascii?Q?D+yJ7yytAZVtmh7BpyRl+VIEv91TWGnCzwfJQ/FJ891LOw70HGo+eymK33I9?=
 =?us-ascii?Q?TGUFbyar8qaZpg6+7PtblQfddZ0/oKsCFjsGi/D/hegkdweRy3TXte4/0Vll?=
 =?us-ascii?Q?1TxVjY4cBcAK1l33e224LrbrghoE1nVjkCxXpYWo7+Br+zsrqjWZOzgB44x4?=
 =?us-ascii?Q?h2nOEBUMwVnGH9yrJxFT4ZTZXe3AlURKDHatoHLFR7syootn+AY0qGDBw92z?=
 =?us-ascii?Q?x2xlqCL0fGWk8HCHzqf2759wMi0MGmfVM/4Ve+tuzdO7I+tm2oIm3dD5INV/?=
 =?us-ascii?Q?YQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a663519-7162-42be-607f-08ddd8af691b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 08:16:45.0168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptuuvr1GuQFt8bTOEZpFzDEipOsFYveW5eqQFKhDaDES58ldTKSKu4guC85AeCUOrCq87G8wkJyKgZEG4FAFuqRL2AdDKiNv2uODKgCjXSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E320AF71
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michal Kubiak
> Sent: Friday, August 8, 2025 5:53 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter
> for buffer allocation failures
>=20
> Currently, the driver increments `alloc_page_failed` when buffer
> allocation fails
> in `ice_clean_rx_irq()`. However, this counter is intended for page
> allocation
> failures, not buffer allocation issues.
>=20
> This patch corrects the counter by incrementing `alloc_buf_failed`
> instead,
> ensuring accurate statistics reporting for buffer allocation failures.
>=20
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx
> side")
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 93907ab2eac7..1b1ebfd347ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring
> *rx_ring, int budget)
>  			skb =3D ice_construct_skb(rx_ring, xdp);
>  		/* exit if we failed to retrieve a buffer */
>  		if (!skb) {
> -			rx_ring->ring_stats-
> >rx_stats.alloc_page_failed++;
> +			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
>  			xdp_verdict =3D ICE_XDP_CONSUMED;
>  		}
>  		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
> --
> 2.45.2


