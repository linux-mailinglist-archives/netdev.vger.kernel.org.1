Return-Path: <netdev+bounces-293688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eExfLFppHWrqaAkAu9opvQ
	(envelope-from <netdev+bounces-293688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:13:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9761E276
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D66CE3009E1E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C2395AE8;
	Mon,  1 Jun 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfaENj8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072D331222
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312405; cv=fail; b=YQ3IlxIM/rlRXRE3VsawBTzoHIZy2TgpuB4bu6LBVV7KdZMuSMCzb20VdgpQybvg4WxXpGOWo2dROVQBTYV08X4Zgv5evyOVShOs38GpuI+IKyqVF9bpdrlHmfvQxE+rOgZdM6SI0ZFBSx+Z//RAlCqDX9v4sAK78nu1F5vHk84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312405; c=relaxed/simple;
	bh=eV3T8WdBZ3GjkWWGsuXUBM1/ewt+NvQzC/C54k5o4gw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MvwKHW2YUAmjgpUpu8Usv5GRCO7UiScLwP3ajqBFuDGEMtzP9ySrRvk7J7zNx/io04dZl6ffmmnNlrYVcx6Pd4IPkWFFeht6QxLAKTdQd2/BSXEFui+7MtYJKTnKJ2m2PlV2n/K3gHEcquogdb1kSeRcEG5FXPzGsMEae/mAhNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfaENj8T; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780312404; x=1811848404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eV3T8WdBZ3GjkWWGsuXUBM1/ewt+NvQzC/C54k5o4gw=;
  b=RfaENj8Tt3AAhkWNuma9pkNm31OcGTQdRcPCQHhzDUIIdkhudqupGs1x
   8RjbbVpeBOrETGJiL+nqj2WdUMAwvUx29vXgiKKh/IawcCIPM++MzLiXy
   HL1Vw+2q2QYxenrg2gW0tsxRrzm4+9px9Ui3u7dxSFVPVW15hqUxgGCdQ
   szWeIpaA25Panpv8N8n774FQQB+dvxqXuim/2Dw0XaLXgvznOfqJ4nh8H
   GhBohsKIx+nU2WnHcEvxZrnmuN1YwdacOYwFZA9GCmdi/ZlFKPkkCrjv7
   kHdboiDvH/my/H4uDNty1fCAbhmg6FvzlkhvG8gkcp2uP60PD+mcM/wN9
   g==;
X-CSE-ConnectionGUID: Y/Oyb9SETh6og0ao30O6Yg==
X-CSE-MsgGUID: o3JPD/fqQ0uLvDlmeELzaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81062112"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81062112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 04:13:23 -0700
X-CSE-ConnectionGUID: BSuu7jmLQ0ayjubExtUjpQ==
X-CSE-MsgGUID: Sz/ld5ZjQRSjYZywbWeIsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="273829774"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 04:13:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 04:13:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 04:13:23 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 04:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO7ld1xu0JLPVc2+tBCw6GLc+g3KEfBhEGgfbLnse41+7n5NBgd1vCru4ZuB0AMfe+zKuIJ58YmhUQkoK/AaenQFeJIG7+UhgQTyMEgvKmEaFFEk12zbumUBgtecXM3SSyTW3Zz0kIWcoieurhes5TgS2nWoI0mJdd0nEqq9PIHxBXCQBp0Grub6ZU9+gAcATDXDvCH39PFDcj00iB/0LLxY7ZHDrexoSasZI2khgdhES5CwiZlbxbFpFoeyF6x5bx9BLYq/JwbizTpFf7pn4O6YeJTWl5i73INHTZ5hglNiHpw5EKs+zK6XWYUqTdfDJW/GU+kyxU6HMOAjaisokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLbXUgIxWCKO6rnIMQRYxOXEQG5lqfCpYFaKrOt3/cg=;
 b=qa4BnhAj+hlyB7sopeIQ5Muq2E2Bg64NPlz1E1GLKsBO7kOOOmi0ygf9/eNhnYQsjJSPw3+xTA/2S8UwITNGqN6m68bodfwo8SxOy5M/JqSNrMZjOhGqRWKEDadAjI/pLc1enfO0Nm0l/kZrAticzcM21zC11cCv8ZqkkuhnDs2yiSZ1Bad0j8qKLvCDSA1w5voteYJjblVppuN2HnVoxGllm0nsU3xZ1OYnlzzBpJdmZfdKHKWWftSqUx+Zpdc/tvWWtRecdq/8bpfni3Hrh2431H+wzwuomqLJk07DSztbRP2KySReMnNkM3f0V3Bhi431h6GroWivegX0sji2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by DS7PR11MB7885.namprd11.prod.outlook.com (2603:10b6:8:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:13:18 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 11:13:17 +0000
Message-ID: <65752da7-a23d-4495-9863-541bdd3f7888@intel.com>
Date: Mon, 1 Jun 2026 13:13:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <riana.tauro@intel.com>, <dev@lankhorst.se>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <kuba@kernel.org>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-5-raag.jadav@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260523050212.557292-5-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000220.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f6) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|DS7PR11MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa21cdb-3ea9-4ac2-5015-08debfcec823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: lbxAsjyKrHeI5e7X0HlsYyfcctRn1kBFkWmj3jhlHx+U8j5U1uElMjsPhQp/Qei2KiiIUhBxIKDjBfqVs72e6JvdDRya+PzcDhC+IINPLLgPwtrKBhp3JuyHxSyQOKmSwya6efYix890ce8AZl8nBEIQzhUNz3qeqns1Jgj4LG0/W2qmuRC7wr3QhfqHbOc5jdh0yE6kmwjKoGJTV+dgjBZeCINIKPHkrxGBKMpsJM3rPhv/muHt+5tZLYs6Otk8XY1GqVtYrSShNHNf/JfdTOmapqp5+3T/s5LqCH1FEEk1ipWVfXCO9uN85tJTmnc0UmVdFOCb1npWNipxAmeJoqcZtEwpzh4g4f8RCuld6NrxOdtWLozSGgtVU8HtXFXNLLDSA+CrpkNCEM/NiAAnM/ah6jx//GvuFXLOp9V05QRIpaB3kChj0MKvaDByTm+T+6VdjKwKoe3VhMpkpkWlbEv2aZ2hzznQRwNabwFW487QLnZKbbNtWX66Et2cgnYlVkx/QGrusyPCZ4jlj6WxXxfWB7GWP8g13m6sfKqwBTp66u2UHeyAZI04deqs2n+nUirYxpDV4bW2l398BTuibgwAj4r4cYK/ws/SYnlXWAzqfa84LxW0Z74i1i1wvFZH5qHV89seVKFeA4MAxGnWpKHLmarW/77IEaor1yhgQcPCBMdztU5Vm8t9nHQjev0q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhVeDZCbG4wUVlFdnZCeFJCbEVNUEl5QjFlQ1VGdzdEbzdOQ2xTd0E3MUEx?=
 =?utf-8?B?SWthU2pyL2JHN3d3R1ZKOWNkeXNFQ0o2bVBTUVVaaS9BU3pKUE1kK1RiUUta?=
 =?utf-8?B?WmJJblQ4Ym1PMlQ4TU5uRXI5UkNYR3NXTG8rNDJRdjZLbGs3bGxlL2krQ3Zx?=
 =?utf-8?B?VGVzT1NQTE1tdERGcGdiK1pVVklJZENCVWQ4NlZJU3NRY05SRzlHVUgvTFps?=
 =?utf-8?B?cmxaMWppcndjRzRJSlR5Y2dsSE93V3NJbmtWUDJqR2lkL3pCK2lodkJEN0xj?=
 =?utf-8?B?MGd2YXE0ODUxTW1vRG1GTWhqaGdWeW8xM1U4b29FUEQ2RkVpZ29yRjNZcy9Z?=
 =?utf-8?B?a1g2a3kxcnhHT2E4NEFpTXBMaklLNTUvMmpaNS9WaUpRU0hvemMwOUZaWDFj?=
 =?utf-8?B?TUJoc1RQZmtRV2ZoUCtjd0U5V0RLYkJKY1RMeFJZRkU5Y2VDQTJ5VnNRSkRM?=
 =?utf-8?B?R1hNOFJNZUNHSVNmdytPZVVZV1hERWZVbGhNUGtVb3h4UVlXamxZYzIzZ1dU?=
 =?utf-8?B?cWwzeTVBYndVNWxNWmhYQWZTQTNJMkFJYjZibWFqK0JCSnh0VWU2clVQWG14?=
 =?utf-8?B?ZU1aSzg5Ynh3VVZQNitYL284REJrdUxpUkloUTBnRnlvVUdlOXJTdkp1L3hj?=
 =?utf-8?B?Q0FoRjFWbWl2UmdDYzlkYkxwVk5rTU85b3VqWEZsQzBOcHVlS3R2QW5NaHVL?=
 =?utf-8?B?dGtDYzNmTFFKcG9LellINmQxalEyVjM5TUpvSG11WXdoVVhOWkZWQWRsRERu?=
 =?utf-8?B?bk1NR1RPR3BFMzZRZVcrYUQwN29QZ0VyeWRoeEJ2dCtjZjk2L0l1Q1RiWEpm?=
 =?utf-8?B?ZUI4U0RFanJGNzM5VElvQmp0NjlNQ3c4U0lVZEVkajR3MVNUWGJacGFCWWt6?=
 =?utf-8?B?STJaL2tubFphZ0pNbU5ld2FIaDFsR0hsb0tmTFk2YTNRK3lHeS8zem9KaUVT?=
 =?utf-8?B?T3lDWlhLWjJtWVF2SmR4ZGUrbkNGdDAwWmtXOUNIdVZhTXlLREV4dXFyKzNH?=
 =?utf-8?B?QXE2dGIxeHMxelhxc2tveEovOXZhNFdaRW5icXJuWXIzVmhXNjdZY1B1SjFR?=
 =?utf-8?B?MXNJOW01Rys0SGFRUlIzcW12a01URmtJRllMeVk4QXpYUDJOSzdqVnFBdFJ6?=
 =?utf-8?B?NS9MalhTN3puUHhYTUZvaWFLYXlndnhFMzhpMjFqeEpaMFQ4bmY1VDhsS2Q3?=
 =?utf-8?B?aXdHODlpejcxVkdiVm92Y0twU251aDQveUdoMXp0MnY2MURsU2hwRDdKZFFG?=
 =?utf-8?B?d01pMWtnOUZVK0RiSGxLWVg5UU4wdTNTalVGOXZleHhLSERWeVI5ajgxWHly?=
 =?utf-8?B?RnRNblVzS0FxVzY1cjlyeHR1Z2hsTGpiMGExYzlSK1hLcUdhNklBSXZRMHN0?=
 =?utf-8?B?eWNGaGpzQ1pib1lJZDRCTjJya2JJdnFTc3FCejRqSm1XMG9wMDJLdURVN1dC?=
 =?utf-8?B?Rk42eU5kdThIZi9IbzgxNVBiaGdGQ0UzUm5pT2FBSWlyVklOTHA0RmJaQ3U5?=
 =?utf-8?B?MFhSaFVRRTd6MGpJZlZxTmJqbzRKSUh6VHNqWUFvSG1tS0hmTEZRdVUvNmhv?=
 =?utf-8?B?SmJscGR1ZnpvN3dXdDdJaFd6R3JGZXVmRDVBQWxkWGt3cUp5RTFObEtQY2JK?=
 =?utf-8?B?Tm82SWpLcXN1c0ozWHZESG9LUW1zVC90SG9lNkxBV3dkd0NVYTN3OTlGQ29F?=
 =?utf-8?B?WHFKOTBuaEc3Y1RvUnEydDVPdWVRQU8zaWgrTEt2U0JKbjFUOGw4Qm5hdTdH?=
 =?utf-8?B?MkVyTGE1STJwQlBBT1FJbzdFVFcvTlRWRktBeGVDejViTHltVkwyMnNsYVNy?=
 =?utf-8?B?LzVReWlTb0RMTHB2ek41OFRycU5BRDBLSDdoZCtPWTljOEpEdzBZL2E3L0sr?=
 =?utf-8?B?VE1iTGJGTmZraVJ1eXNzNzZmTC92Yk9MaU55TWZoTmlrQzhqalYrWmRxdXBH?=
 =?utf-8?B?RzV6TjVsV2JJSWxJWWNkb3FjVTc0OE95cVM2anUvNWxpSnJYbUxtaTdvV1VE?=
 =?utf-8?B?cnVHL0VpVlh0Z3lieHBKYno1QzJJN2ZrS2k2ZnRUU1ZKbEQrczdIZmNWVzZO?=
 =?utf-8?B?SzVnanBJTlpEYWpQcTc3UWJzVzJWd1JsZkpjWFROQ29Vb2NHOFlOaXA0S1ZR?=
 =?utf-8?B?c09XV1ljL21hYUZ0YUltOXQxWDhOVHBTNXgvMUtSSEhCN1NRTEFEUksxcTRj?=
 =?utf-8?B?ZkkyR1U0RWpweENjT1lvOWZGNUs3aGdUY28rZ0pKaTZmRXBMUmlqbmI2Z1BI?=
 =?utf-8?B?SzRqZHJWeWRIYmJxTG03RjgreTNSU1FNZUw1WFROQWVoelQ4TDNmdWhFVXcv?=
 =?utf-8?B?NlZMaGd0UWMzSHNqaFpFRkFXL0FNUFRIQ1VPRkMyOFNBM3d1QlZ1RGxLc0NV?=
 =?utf-8?Q?QG5bT9alFpi3DrGE=3D?=
X-Exchange-RoutingPolicyChecked: o3R3X1B/sezAt3cV2zuemSN971Jw52PS7JI6OOKNLuqennco2X6xpZAUQJCRXvBKxjlpjYN1+gvTuB45ous64N/6inq/u2U/+7oZnKWpW+tRoYtHacexDsiEr/jwrrX9NX3MOQBOxUB60FV15OQMIoXIwZbWp7ZwlFxznXfgBDx/nyfbrTX3iJNilJ+R18Lo2FiVu1exsdHa/r20n1TcYhgsjCt+5D+P/YXIr7timdW9gAy/LJQMkhgthQiejf8iTwGhTfQXl+c2JfHubz2fXz7JEbPXdCXymCBy+IEZ7OgJm+Co4DD7xN9G1sBYWEgQtk/Jbw7cewuaCHn3yh2RKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa21cdb-3ea9-4ac2-5015-08debfcec823
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:13:17.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGQNfhKpksYYmkxsG1zMeRzs58whMZ3hSDhJzot/Qs9osuD0qPJ/lcpMKTBVYswLw0MRVNzgHNDeYED0dNQf7Zdv/RiHxKqAXMq+pjznoO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7885
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-293688-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.wajdeczko@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AFD9761E276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/23/2026 7:00 AM, Raag Jadav wrote:
> Hardware errors should be logged with HW_ERR prefix. Make them
> consistent with existing logs.
> 
> Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> index 5135e8e4093f..4b72959b2276 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.c
> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> @@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
>  	struct xe_device *xe = tile_to_xe(tile);
>  
>  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> -		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
> +		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);

function is per-tile, so shouldn't we use tile-oriented logs instead?

		xe_tile_warn(tile, HW_ERR ...)

>  	else
> -		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
> +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);

		xe_tile_err_ratelimited(tile, HW_ERR ...)

>  }
>  
>  static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> @@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
>  	struct xe_device *xe = tile_to_xe(tile);
>  
>  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> -		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> +		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
>  			 name, severity_str, i, err);
>  	else
> -		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
>  				    name, severity_str, i, err);
>  }
>  
> @@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
>  
>  	if (strcmp(name, "Undefined")) {
>  		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> -			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
> +			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
>  		else
> -			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
> +			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
>  		atomic_inc(&info[index].counter);
>  	}
>  }


