Return-Path: <netdev+bounces-293734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLxKM9Z7HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECE61F4BD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5A4830640A3
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B6377EA4;
	Mon,  1 Jun 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPqjAwh0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B4377579;
	Mon,  1 Jun 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316804; cv=fail; b=ahuHDHME6tQuS0N3rZoVtSUi4tgJCuh052Ws9pcTK6+Y6Z3Y3oAV5V2rR2YfPGu6bNsoEziOMSf98Xc2scFxc4WlzxfFAXuNeMhJ99JU76kZqDV4J0O22UnN0/IN3NH2GzFX8Bw4c8TNdgaaoNMCz1jvBXTMMcOBVFasjJHaO8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316804; c=relaxed/simple;
	bh=dYV0E4/CP/hI3ALSHu9jp7bFqy+V72OvuRJ79FoZD+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UCMTikg5EK6XekvCb1Jk0r+36rRN22UQdSWGILP88dqB64v/kKgVxorFJVe8v2NVd/SVaHwSgKt8Kvu6f+qdRx9YFWNMZxqJpZ2hJ25F+HlFnBhCMnW/S3fQLyLX64QsoTLFS+0BQ005NQf3hfQAg/0DVEE2i2R7xOCqO068Las=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPqjAwh0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780316802; x=1811852802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dYV0E4/CP/hI3ALSHu9jp7bFqy+V72OvuRJ79FoZD+U=;
  b=mPqjAwh0KdiDk5BwkOZMX7tzxE/4GiC0FFWvH1tG+H0r/rFXPfkkrhzQ
   kJo8a/1lQ1YtRccIQNmP0amDuatlVxwtsmuJ4gfKdhwsXdwhnI+C7YHdz
   TYtLX+OMTmFkR30AsnDOEu7eJCTiwAB/BS9lUqreairebFBfcZ6+GgAPI
   GK76XVSuJptaHHEedVGwX/jMAmTNmi2W6T+YrtpcE/52JAFP5fsRgpjH8
   0RPu2LdFNhrbJMdTmnDrVo+FZAdD5Up7dYiBWZxqFNJUXLivy4DTm49ne
   4Lxh3AtcEraBYKKFszwEAYCccJR3Ye8OAe0Z3l0lc61zY/sHmodlLZhxi
   A==;
X-CSE-ConnectionGUID: 3aS2xj7QRemmK2SVEAmK2Q==
X-CSE-MsgGUID: 93Q+jwWSQxmPcX7cbbCb3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="103742235"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="103742235"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:26:41 -0700
X-CSE-ConnectionGUID: DRGmTdPERNmT4oHIdMwyPg==
X-CSE-MsgGUID: Fh2IUnEVRcSLG0Qj5mE/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="267451819"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:26:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 05:26:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 05:26:40 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 05:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnIDvpgXhn9KNiM3BIPVLPAKWXXrlX+97DPgL7I2ynaQr4rSBf2Jcu66oePWRYcHwd8omyn8Ry+sq184KYypV2GVbPzYCKYMYbH7xcODvfcKBFXDs1lpzeNuMg+E4zFN7fv4Rv6Z0pn7B/6TuNE4D1+CX+c7A5PyzoMC0no7Dy8gFrWY204dQkvy3G29o5DWmkayUfu647TRrTTC6vuzHZJzDrt+aeq43iV03nj5W6iC/kE4LKe9z1zRBKDAgQ5PF2JdIyca0FpbWnXYDILc+SP+1gLTPT3vjElhDyT7442t0UZ9pP2k6uGE9dnAgFQtKHbPlnYKvA0n2YRgRlcG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYV0E4/CP/hI3ALSHu9jp7bFqy+V72OvuRJ79FoZD+U=;
 b=C0fDbpfvgBJPqI286YBeptlGUHWaKXG6wo0M66ee9gzRpcLj8jiJXHuKrEXJ3virbVZt0JYwePzoZirNB/i7d8oW4eoq0DE0oiIqtLD48fT9hKptmf98l/YAIU6YPd6ONwENB0+DxgG5mLgRMxaWH/NZQtqieT6xidY9CbSrjWzPQ02KOiWP2Lc0MMJOGGddsR6QhqVZBewHF5s3zgwObUQqbLKwf9MDTIf4STudA+bgfC/meneOkk47b0cWNy9f15ie5fDFPncPa2Qwk998eAprTiZnYLorlUsluAWSdDODY295fTgMa8CCMHqN/J3Ce7thX6ByiAFjVAE4dUWwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 1 Jun 2026
 12:26:37 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 12:26:37 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "jackbb_wu@compal.com" <jackbb_wu@compal.com>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 10/11] net: wwan: t9xx: Add power management support
Thread-Topic: [PATCH 10/11] net: wwan: t9xx: Add power management support
Thread-Index: AQHc71dg3p58paF+dkGNm+/Z2KZ0brYpow4A
Date: Mon, 1 Jun 2026 12:26:37 +0000
Message-ID: <PH0PR11MB590224D70D016B8108DDD7B9F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-10-bdbfe2c01e57@compal.com>
In-Reply-To: <20260529-t9xx_driver_v1-v1-10-bdbfe2c01e57@compal.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SA0PR11MB4704:EE_
x-ms-office365-filtering-correlation-id: 8929df49-5124-4303-1823-08debfd906dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: gsX0EIkUs9pl0ZTlyQ/VPB/IzhWH5M9PYb/bdbrCs9TnoeeMnSAfEWSPVp5++sKcBDAmkWlobO9o8ZU2pORVighjlBeaRjFdjyCH8YQsbmojTU2aFoOIk949IIh4tAl+64zZWbsrPtOWhcQKqfmgHFYJYTR4BwDLoZuZEen96nxudY8Z959oLEnY2gBERFSxVOtbqfbaAwCLP2Np8QRzhA4+oDME/W2i3lT9VWMFIzgq3flq1Mmc8sY3ZYB3DvVUZYx9FF4/4sAMQhxC+Ru+gplE/FPEWy7EKVsEKLhbw8sNWtsc2aBBNIk+/nwhW/nDye2bF87P10m/vbCv2oo/Ekhzxkw0uLD7wdhnNnBMKVznJqvMZgVYTek3JNv1XMfvHLaEhpdYfVrje3Ail97Sb5BivSyCp15Ch+EEmZNswbHFYH73FBpSxNhYYGEzYquBKbN2UFx+Cg5W0UBxE+LGD7Zo28GZd8IfSAl2oNbGdFsiFB1Gcc4gjrmSX8E9+XqgQP40nwjwEsiscaPx/wrfcZGPEGLyIeXNtGaPv1Gh//smPnw3XBXL3gb+kDXPhh1ejw/kk9FjdQytpRzJRCnZdmUoq5FfgXnLnVtL98r0U6AuHWhkuF1WIsq2T2f7DbHih3XFnT5U4jgtBNS7YIOHxPyLSsoQDFXP6BCiAe2/qGqCZug2NXyEZJXj7bXf+8S/3WN1SoA5f0jdrlV+9lZH2RLcnuEVyO12V8Jphz66R9Or36zb4q8jaxKjsLn8bdiliwgmFtxg0VEMe9E34FHexA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V21kbDBpVjVvQVJKWW8zejVSeUQ2eUovekljaVFBaGdXdTVKR29nb1BNRDZ3?=
 =?utf-8?B?N1BPZFpjNStRaXZQNUdiMy9YZDV2WUdQYTRMK3R6dS9MelJ1VTdXaytYS29z?=
 =?utf-8?B?WnNFR3VoVWo2OUxyN2FWNXJ1eTB1QUJqN0lLa3BVQjdDWUxkdFFIVzg5TkNN?=
 =?utf-8?B?SW8vN29LVDVjRWNlYUJDaG1rSFNZaDgvelNZMng3WksrSm5IZkxjbERrU09D?=
 =?utf-8?B?NUMyZmRxS3E3VjJVWGpodTRSOWpxbE1VTXIzc3hSdXhQbS82dS9LdERFQXJ3?=
 =?utf-8?B?aG1WOWorc1pJSE9Rc2hacWhTNWdaL243clBTM3dlZDZlUk1QajUrM1BiOUNa?=
 =?utf-8?B?aWQyWUxaUlhpUXZEZEdNZmJzYVllbkhEZGJzSThsNVNLZWxmRk10c1Y1RmpJ?=
 =?utf-8?B?aGJtMU1PcEZBcU96Q2RYeVo2QWF5MGdtak42Y1hZTmcxYmpQcHlHbDhjeWx3?=
 =?utf-8?B?aTcyaUowMVRHdjA2dXFJYkdrZVdpMmdsdnd5Nm1RSllnWEFqUUMyYlJpSFlj?=
 =?utf-8?B?WE95cnB4RGF5L0l2ZjdvKzg4UjB3bHE5SFY4elp1Y05ZeDJ5QktNWnZXRjMy?=
 =?utf-8?B?ZFZXR2xMN3lEVkNEZy9hNW82U0FzT0NaYmZsODNrTjF6Ly9iREhYLzZxOXhV?=
 =?utf-8?B?UzJFZS93TGdoOTJiUW5aVEpPM3ZCZEZvRWJjcm41Qzk4RTlmVkxVUHEwbThQ?=
 =?utf-8?B?bWREZWV0ZU5NRmpEOGVCMHhlelRyR3FZTFNsaUovTGJYb21uWHFpNEtkeWto?=
 =?utf-8?B?SlNHd29TSjU4Z205emdEc042TzgwNjROMXlSVzZ4RnVRejlXbXpubm9uZzln?=
 =?utf-8?B?cmorL1ZMWnYxd3BBdFRBcWtENGUyVVVURHdDWFZkRUcyaXlqbnp1V1dUamVF?=
 =?utf-8?B?clJ1TmZjVnVzSDg2OGY2K0pHOGpWN1czRmxSNXV0NlJGQU1GR3hXbHZsL2d1?=
 =?utf-8?B?eTFReDl3dkhlTXNDZWVDSG1nREdsYXBqY3JCSUNNWnVBN29oZWFrMzZEL3ZC?=
 =?utf-8?B?eFdTczRxc1VITUlQUHNjZFYwdTV1OFVXNDVxeXRXdkxpZE1OY0FFR1NCUWlH?=
 =?utf-8?B?SFNTcEgxdnRRL1o0S0tiVzVBSUJ3VWFlWXphRW5PemZLQnF2cGR1c1o4bEw1?=
 =?utf-8?B?bHcwdDlBSFlCdHkxVXNpSml6bUIrQmxSdzJvNWhVZUZKdldMNTJLZkFrdkdn?=
 =?utf-8?B?ZXJhWkh1Tk1WOEpIc0ZQODIzMFVpMHJXMlNHKys5d0FtMFVWelBLb2tRVzFF?=
 =?utf-8?B?OUVNY1dlQjcwSHpkWTZBMDNBdkI5b0RZZ3duQ29zbTlKZm1tdWx2MnJlZ0NX?=
 =?utf-8?B?T3VKUy93bWdlT29CaGZnME01RjYzd25OZzFoOEVIU3J0c1NHUUpTc25OWEpZ?=
 =?utf-8?B?aE1pNVBHc1BqOVVDbzUvKzlodnovNXc3MXZtVU41MnpVUmw3WWdmc3hKSDJF?=
 =?utf-8?B?Wk1PZ3VlK3J6K0lNRkZDK0pCZ094OXB3d3BIemFwYTBxL1VTRjQ3bkZwQ0JJ?=
 =?utf-8?B?cHNVd055QnlWaHRrSlY3OWo5a1ZpTjdYTjZiZmowMGFHSC9qL212V2pLeXRW?=
 =?utf-8?B?UkFoZ0M1dnZNRXpHUEVsUUw0YVdRRUFnUnlpRjZiMGIwa3l6d1BWUDluamRv?=
 =?utf-8?B?Y0xuMENFckRVQ1FHM0cvZEpUSDJaY3dqZ1RFb2Y0WlNWNHVNZisveGVBS0JY?=
 =?utf-8?B?QWVBU0NaWm5RMlp2dVoxT2pwbk9WZ1A3WTNxMmV5ZUFVbTlGOVdwTEFsL3hh?=
 =?utf-8?B?R1Z2NkhHVWtsOGlSd0dZM25NRXI3cUdZUnNjMzRobzMrc3YvQjJBVE9xeEdq?=
 =?utf-8?B?NldOQlgrM3JQNzkxZVYrVEJnWHhpVytqY0ZLcGllTUwwQ2JhWkJ5bmUzTjJm?=
 =?utf-8?B?MWttV0k4cWhDU0htSnFUck8yM0pWTWN0ZVFMYU1mdEFsQkV0UHEvQnlUTVpW?=
 =?utf-8?B?U0dOOUhUd3AxVmd1R3lTZkhQVG5Sd08xZ2xuQTM1N3krbmhXYURGZEs3ZFZR?=
 =?utf-8?B?QWFzMTdKdnFjbnVGRXVEYjFCL0ZKdE5MWVZRb0pJeG5IcTZ0UWR0ZHI4ODdz?=
 =?utf-8?B?dWMra29KRENNVE5GdkdoQjY4Y1NLYlBEZjd4Sis2dGoweG8rcUhUMlUrM2Ey?=
 =?utf-8?B?Wm1DcGg4cFNxcUVpaW9BVmd5R3IxbWZZNzBRN3NoUnpZRW9CQ3V2eFFpY2dp?=
 =?utf-8?B?K0lVdnBnaWNMQnJHb3NXV05YY1MvNXh5dlRoR0NaUlRVRE9LSEV0cXRZVHM0?=
 =?utf-8?B?NHZHZTJ0dmp3bWpaaU01NzdBa3FjTkY4aVVTbmQ4VjNzT0VBcDFHN3BmWXZZ?=
 =?utf-8?B?cXJMMFkzRDZhNHF3RzBTclhCT1BqenJ4b0k1U1lNSGx5TVFRTTlGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: loHhfVlg5zfE+gFCIr3zQk/2gb8WT8g9Uz+KwO/CtRQ4l+8vIjq8wsOWgWoRkq4o38/sIYgOPY8/or5FVC/MiI/PQE13gM+BUaX8KN3qleednBiCOgHsk3ZWhmApYdrZiji0ShyW/m8nk+W8oGOWDXQMrJWno+pK+P7uAtPVqUEYbSOrAEmmjM5INlH+Sqrch6N6stFxgQc3BJ9toxKQrdNTDwpL8HLZTGMdvl0XV4xOox5g8bbypCY3ytzApCx9YmHrd/zY86I/DfsxH+mWX/yhezbToC4uoEux01DUbNphVUkI1pMKCZxb/HB+pRlOGDUqpvTI6bbvbvo7q7Lzkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8929df49-5124-4303-1823-08debfd906dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 12:26:37.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53vwhraN0DMw6mjb1aMVh4pNfTJNJ9cKNap0+0iQXunGV1JrkpNgRRUiVXEMGfR+KQrBGo6wA74I1UVkaNsuSr2Z0mTMGGFp0LvdSgXDFZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-293734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[compal.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB5902.namprd11.prod.outlook.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,compal.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 37ECE61F4BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogSmFjayBXdSB2aWEgQjQgUmVsYXkgPGRldm51bGwramFja2JiX3d1LmNvbXBhbC5jb21A
a2VybmVsLm9yZz4gDQpTZW50OiBGcmlkYXksIE1heSAyOSwgMjAyNiAxMjozMiBQTQ0KDQo+RnJv
bTogSmFjayBXdSA8amFja2JiX3d1QGNvbXBhbC5jb20+DQo+DQo+QWRkIHMyaWRsZSAoUzBpeCkg
cG93ZXIgbWFuYWdlbWVudCBzdXBwb3J0IGZvciB0aGUgdDl4eCBXV0FOIGRyaXZlci4NCj4NCj5J
biBzMmlkbGUgdGhlIG1vZGVtIHJlbWFpbnMgcG93ZXJlZC4gVGhlIGRyaXZlciBtdXN0IHF1aWVz
Y2UgaG9zdC1zaWRlDQo+RE1BIGVuZ2luZXMgYW5kIHNlcnZpY2UgdGhyZWFkcyBiZWZvcmUgdGhl
IHBsYXRmb3JtIGVudGVycyBsb3ctcG93ZXINCj5zdGF0ZSwgdGhlbiByZXN0b3JlIHRoZW0gb24g
cmVzdW1lLg0KPg0KPi0gU3VzcGVuZDogcGFyayBUUkIgc2VydmljZSB0aHJlYWRzLCBzdG9wIENM
RE1BIFRYL1JYIHF1ZXVlcywNCj4gIGRpc2FibGUgRFBNQUlGIGRhdGEgcGF0aCwgbWFzayBNSEND
SUYgYW5kIE1TSVggaW50ZXJydXB0cywNCj4gIHNhdmUgUENJZSBzdGF0ZQ0KPi0gUmVzdW1lOiBy
ZXN0b3JlIFBDSWUgc3RhdGUsIHJlLWluaXRpYWxpemUgQVRSLCB1bm1hc2sgTUhDQ0lGLA0KPiAg
cmVzdW1lIENMRE1BIHF1ZXVlcywgcmUtZW5hYmxlIERQTUFJRiBkYXRhIHBhdGgsIHVucGFyayBU
UkINCj4gIHNlcnZpY2UgdGhyZWFkcw0KPg0KPlNpZ25lZC1vZmYtYnk6IEphY2sgV3UgPGphY2ti
Yl93dUBjb21wYWwuY29tPg0KPi0tLQ0KPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtf
Y2xkbWEuYyAgfCA5NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gZHJpdmVy
cy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hLmggIHwgIDMgKysNCj4gZHJpdmVycy9uZXQv
d3dhbi90OXh4L3BjaWUvbXRrX2RwbWFpZi5jIHwgMzUgKysrKysrKysrKystDQo+IGRyaXZlcnMv
bmV0L3d3YW4vdDl4eC9wY2llL210a19kcG1haWYuaCB8ICAyICsNCj4gZHJpdmVycy9uZXQvd3dh
bi90OXh4L3BjaWUvbXRrX3BjaS5jICAgIHwgODUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gNSBmaWxlcyBjaGFuZ2VkLCAyMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hLmMg
Yi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfY2xkbWEuYw0KPmluZGV4IGFhY2I0MTc3
ZDkxNC4uYTUyMjdlYjU0NmY0IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9w
Y2llL210a19jbGRtYS5jDQo+KysrIGIvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2Ns
ZG1hLmMNCj5AQCAtMTExMyw2ICsxMTEzLDEwMCBAQCBpbnQgbXRrX2NsZG1hX2V4aXQoc3RydWN0
IG10a19jdHJsX3RyYW5zICp0cmFucykNCj4gCXJldHVybiAwOw0KPiB9DQo+IA0KPit2b2lkIG10
a19jbGRtYV9wbV9zdXNwZW5kKHN0cnVjdCBtdGtfbWRfZGV2ICptZGV2KQ0KPit7DQo+KwlzdHJ1
Y3QgbXRrX2N0cmxfdHJhbnMgKnRyYW5zID0gKChzdHJ1Y3QgbXRrX2N0cmxfYmxrICopbWRldi0+
Y3RybF9ibGspLT5jdHJsX2h3X3ByaXY7DQo+KwlzdHJ1Y3QgY2xkbWFfZGV2ICpjZCA9IHRyYW5z
LT5kZXY7DQo+KwlzdHJ1Y3QgY2xkbWFfZHJ2X2luZm8gKmRydl9pbmZvOw0KPisJc3RydWN0IGNs
ZG1hX2Rydl9vcHMgKmRydl9vcHM7DQo+KwlzdHJ1Y3QgcnhxICpyeHE7DQo+KwlzdHJ1Y3QgdHhx
ICp0eHE7DQo+KwlpbnQgaSwgcTsNCj4rDQo+Kwlmb3IgKGkgPSAwOyBpIDwgTlJfQ0xETUE7IGkr
Kykgew0KPisJCWRydl9pbmZvID0gY2QtPmNsZG1hX2Rydl9pbmZvW2ldOw0KPisJCWlmICghZHJ2
X2luZm8pDQo+KwkJCWNvbnRpbnVlOw0KPisNCj4rCQlkcnZfb3BzID0gZHJ2X2luZm8tPmRydl9v
cHM7DQo+Kw0KPisJCS8qIFN0b3AgVFggcXVldWVzIGFuZCBmbHVzaCBwZW5kaW5nIHR4X2RvbmVf
d29yayAoc3VzcGVuZCBwaGFzZSkgKi8NCj4rCQlkcnZfb3BzLT5jbGRtYV9zdG9wX3F1ZXVlKGRy
dl9pbmZvLCBESVJfVFgsIEFMTFEpOw0KPisJCWZvciAocSA9IDA7IHEgPCBIV19RVUVVRV9OVU07
IHErKykgew0KPisJCQl0eHEgPSBkcnZfaW5mby0+dHhxW3FdOw0KPisJCQlpZiAodHhxKQ0KPisJ
CQkJZmx1c2hfd29yaygmdHhxLT50eF9kb25lX3dvcmspOw0KPisJCX0NCj4rDQo+KwkJZm9yIChx
ID0gMDsgcSA8IEhXX1FVRVVFX05VTTsgcSsrKSB7DQo+KwkJCXJ4cSA9IGRydl9pbmZvLT5yeHFb
cV07DQo+KwkJCWlmICghcnhxKQ0KPisJCQkJY29udGludWU7DQo+KwkJCWF0b21pY19zZXQoJnJ4
cS0+bmVlZF9leGl0LCAxKTsNCj4rCQkJZHJ2X29wcy0+Y2xkbWFfc3RvcF9xdWV1ZShkcnZfaW5m
bywgRElSX1JYLCBxKTsNCj4rCQkJZmx1c2hfd29yaygmcnhxLT5yeF9kb25lX3dvcmspOw0KPisJ
CX0NCj4rCQltdGtfcGNpX21hc2tfaXJxKG1kZXYsIGRydl9pbmZvLT5wY2lfZXh0X2lycV9pZCk7
DQo+Kwl9DQo+K30NCj4rDQo+K3ZvaWQgbXRrX2NsZG1hX3BtX3Jlc3VtZV9lYXJseShzdHJ1Y3Qg
bXRrX21kX2RldiAqbWRldikNCj4rew0KPisJc3RydWN0IG10a19jdHJsX3RyYW5zICp0cmFucyA9
ICgoc3RydWN0IG10a19jdHJsX2JsayAqKW1kZXYtPmN0cmxfYmxrKS0+Y3RybF9od19wcml2Ow0K
PisJc3RydWN0IGNsZG1hX2RldiAqY2QgPSB0cmFucy0+ZGV2Ow0KPisJc3RydWN0IGNsZG1hX2Ry
dl9pbmZvICpkcnZfaW5mbzsNCj4rCXN0cnVjdCBjbGRtYV9kcnZfb3BzICpkcnZfb3BzOw0KPisJ
c3RydWN0IHJ4cSAqcnhxOw0KPisJaW50IGksIHE7DQo+Kw0KPisJZm9yIChpID0gMDsgaSA8IE5S
X0NMRE1BOyBpKyspIHsNCj4rCQlkcnZfaW5mbyA9IGNkLT5jbGRtYV9kcnZfaW5mb1tpXTsNCj4r
CQlpZiAoIWRydl9pbmZvKQ0KPisJCQljb250aW51ZTsNCj4rDQo+KwkJZHJ2X29wcyA9IGRydl9p
bmZvLT5kcnZfb3BzOw0KPisNCj4rCQkvKiBSZXN1bWUgUlggcXVldWVzIGZyb20gY3VycmVudCBI
VyByaW5nIHBvc2l0aW9uIChubyBhZGRyIHJlc2V0KSAqLw0KPisJCWZvciAocSA9IDA7IHEgPCBI
V19RVUVVRV9OVU07IHErKykgew0KPisJCQlyeHEgPSBkcnZfaW5mby0+cnhxW3FdOw0KPisJCQlp
ZiAoIXJ4cSkNCj4rCQkJCWNvbnRpbnVlOw0KPisJCQlhdG9taWNfc2V0KCZyeHEtPm5lZWRfZXhp
dCwgMCk7DQo+KwkJCWRydl9vcHMtPmNsZG1hX3Jlc3VtZV9xdWV1ZShkcnZfaW5mbywgRElSX1JY
LCBxKTsNCj4rCQl9DQo+Kw0KPisJCS8qIFVubWFzayBDTERNQSBMMSBpbnRlcnJ1cHQgKi8NCj4r
CQltdGtfcGNpX3VubWFza19pcnEobWRldiwgZHJ2X2luZm8tPnBjaV9leHRfaXJxX2lkKTsNCj4r
CX0NCj4rfQ0KPisNCj4rdm9pZCBtdGtfY2xkbWFfcG1fcmVzdW1lKHN0cnVjdCBtdGtfbWRfZGV2
ICptZGV2KQ0KPit7DQo+KwlzdHJ1Y3QgbXRrX2N0cmxfdHJhbnMgKnRyYW5zID0gKChzdHJ1Y3Qg
bXRrX2N0cmxfYmxrICopbWRldi0+Y3RybF9ibGspLT5jdHJsX2h3X3ByaXY7DQo+KwlzdHJ1Y3Qg
Y2xkbWFfZGV2ICpjZCA9IHRyYW5zLT5kZXY7DQo+KwlzdHJ1Y3QgY2xkbWFfZHJ2X2luZm8gKmRy
dl9pbmZvOw0KPisJc3RydWN0IGNsZG1hX2Rydl9vcHMgKmRydl9vcHM7DQo+KwlzdHJ1Y3QgdHhx
ICp0eHE7DQo+KwlpbnQgaSwgcTsNCj4rDQo+Kwlmb3IgKGkgPSAwOyBpIDwgTlJfQ0xETUE7IGkr
Kykgew0KPisJCWRydl9pbmZvID0gY2QtPmNsZG1hX2Rydl9pbmZvW2ldOw0KPisJCWlmICghZHJ2
X2luZm8pDQo+KwkJCWNvbnRpbnVlOw0KPisNCj4rCQlkcnZfb3BzID0gZHJ2X2luZm8tPmRydl9v
cHM7DQo+Kw0KPisJCS8qIFJlc3RhcnQgVFggcXVldWVzIHRoYXQgaGF2ZSBwZW5kaW5nIGRlc2Ny
aXB0b3JzICovDQo+KwkJZm9yIChxID0gMDsgcSA8IEhXX1FVRVVFX05VTTsgcSsrKSB7DQo+KwkJ
CXR4cSA9IGRydl9pbmZvLT50eHFbcV07DQo+KwkJCWlmICghdHhxKQ0KPisJCQkJY29udGludWU7
DQo+KwkJCWlmIChhdG9taWNfcmVhZCgmdHhxLT5yZXFfYnVkZ2V0KSA8IHR4cS0+bnJfZ3BkcykN
Cj4rCQkJCW10a19jbGRtYV9zdGFydF94ZmVyKGRydl9pbmZvLCBxKTsNCj4rCQl9DQo+Kwl9DQo+
K30NCj4rDQo+IHN0YXRpYyBpbnQgbXRrX2NsZG1hX29wZW4oc3RydWN0IGNsZG1hX2RldiAqY2Qs
IHN0cnVjdCBza19idWZmICpza2IpDQo+IHsNCj4gCXN0cnVjdCB0cmJfb3Blbl9wcml2ICp0cmJf
b3Blbl9wcml2ID0gKHN0cnVjdCB0cmJfb3Blbl9wcml2ICopc2tiLT5kYXRhOw0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfY2xkbWEuaCBiL2RyaXZlcnMvbmV0
L3d3YW4vdDl4eC9wY2llL210a19jbGRtYS5oDQo+aW5kZXggMDRmODNmZjBlMzdkLi5mZDM5OTg1
Zjc1ZTcgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1h
LmgNCj4rKysgYi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfY2xkbWEuaA0KPkBAIC0x
NjMsNiArMTYzLDkgQEAgaW50IG10a19jbGRtYV9nZXRfdHhfYnVkZ2V0KHZvaWQgKmRldiwgZW51
bSBtdGtfaGlmX2lkIGhpZl9pZCwgdTMyIHFubyk7DQo+IGludCBtdGtfY2xkbWFfdHJiX3Byb2Nl
c3Modm9pZCAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsNCj4gdm9pZCBtdGtfY2xkbWFfZnNt
X3N0YXRlX2xpc3RlbmVyKHN0cnVjdCBtdGtfZnNtX3BhcmFtICpwYXJhbSwgc3RydWN0IG10a19j
dHJsX3RyYW5zICp0cmFucyk7DQo+IGludCBtdGtfY2xkbWFfY2hlY2tfY2hfY2ZnKHZvaWQgKmRl
diwgc3RydWN0IHF1ZXVlX2luZm8gKnF1ZSk7DQo+K3ZvaWQgbXRrX2NsZG1hX3BtX3N1c3BlbmQo
c3RydWN0IG10a19tZF9kZXYgKm1kZXYpOw0KPit2b2lkIG10a19jbGRtYV9wbV9yZXN1bWVfZWFy
bHkoc3RydWN0IG10a19tZF9kZXYgKm1kZXYpOw0KPit2b2lkIG10a19jbGRtYV9wbV9yZXN1bWUo
c3RydWN0IG10a19tZF9kZXYgKm1kZXYpOw0KPiANCj4gI2RlZmluZSBkcnZfb3BzX25hbWUoTkFN
RSkgY2xkbWFfZHJ2X29wc18jI05BTUUNCj4gI2RlZmluZSBjbGRtYV9yZWdzX25hbWUoTkFNRSkg
bXRrX2NsZG1hX3JlZ3NfIyNOQU1FDQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vdDl4
eC9wY2llL210a19kcG1haWYuYyBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19kcG1h
aWYuYw0KPmluZGV4IDQzODAzNTg3YmZjMy4uNjMyNzNhODVlNTMyIDEwMDY0NA0KPi0tLSBhL2Ry
aXZlcnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19kcG1haWYuYw0KPisrKyBiL2RyaXZlcnMvbmV0
L3d3YW4vdDl4eC9wY2llL210a19kcG1haWYuYw0KPkBAIC0yMDUsNiArMjA1LDcgQEAgc3RydWN0
IG10a19kcG1haWZfY3RsYiB7DQo+IAlzdHJ1Y3QgZHBtYWlmX2lycV9wYXJhbSAqaXJxX3BhcmFt
czsNCj4gDQo+IAlib29sIGRwbWFpZl9zd19yZXNldDsNCj4rCWJvb2wgdHJhbnNfZW5hYmxlZDsN
Cj4gCXVuc2lnbmVkIGNoYXIgcnhxX2NudDsNCj4gCXVuc2lnbmVkIGNoYXIgdHhxX2NudDsNCj4g
fTsNCj5AQCAtMTY4NywxMCArMTY4OCwxNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHBtYWlmX3RyYW5z
X2Rpc2FibGUoc3RydWN0IG10a19kcG1haWZfY3RsYiAqZGNiKQ0KPiBzdGF0aWMgdm9pZCBtdGtf
ZHBtYWlmX3RyYW5zX2N0bChzdHJ1Y3QgbXRrX2RwbWFpZl9jdGxiICpkY2IsIGJvb2wgZW5hYmxl
KQ0KPiB7DQo+IAlpZiAoZW5hYmxlKSB7DQo+LQkJaWYgKGRjYi0+ZHBtYWlmX3N0YXRlID09IERQ
TUFJRl9TVEFURV9QV1JPTikNCj4rCQlpZiAoIWRjYi0+dHJhbnNfZW5hYmxlZCAmJg0KPisJCSAg
ICBkY2ItPmRwbWFpZl9zdGF0ZSA9PSBEUE1BSUZfU1RBVEVfUFdST04pIHsNCj4rCQkJZGNiLT50
cmFuc19lbmFibGVkID0gdHJ1ZTsNCj4gCQkJbXRrX2RwbWFpZl90cmFuc19lbmFibGUoZGNiKTsN
Cj4rCQl9DQo+IAl9IGVsc2Ugew0KPi0JCW10a19kcG1haWZfdHJhbnNfZGlzYWJsZShkY2IpOw0K
PisJCWlmIChkY2ItPnRyYW5zX2VuYWJsZWQpIHsNCg0Kc2hvdWxkIGl0IGJlIGRvbmUgdW5jb25k
aXRpb25hbGx5IGZyb20gRFBNQUlGX1NUQVRFX1BXUk9OPw0KDQo+KwkJCWRjYi0+dHJhbnNfZW5h
YmxlZCA9IGZhbHNlOw0KPisJCQltdGtfZHBtYWlmX3RyYW5zX2Rpc2FibGUoZGNiKTsNCj4rCQl9
DQo+IAl9DQo+IH0NCj4gDQo+QEAgLTIwNjAsNiArMjA2NywzMCBAQCBzdGF0aWMgaW50IG10a19k
cG1haWZfc3RvcChzdHJ1Y3QgbXRrX21kX2RldiAqbWRldikNCj4gCXJldHVybiAwOw0KPiB9DQo+
IA0KPit2b2lkIG10a19kcG1haWZfcG1fc3VzcGVuZChzdHJ1Y3QgbXRrX21kX2RldiAqbWRldikN
Cj4rew0KPisJc3RydWN0IG10a19kcG1haWZfY3RsYiAqZGNiID0gKChzdHJ1Y3QgbXRrX2RhdGFf
YmxrICopKG1kZXYtPmRhdGFfYmxrKSktPmRjYjsNCj4rDQo+KwlpZiAoIWRjYikNCj4rCQlyZXR1
cm47DQo+Kw0KPisJbXV0ZXhfbG9jaygmZGNiLT50cmFuc19jdGxfbG9jayk7DQo+KwltdGtfZHBt
YWlmX3RyYW5zX2N0bChkY2IsIGZhbHNlKTsNCj4rCW11dGV4X3VubG9jaygmZGNiLT50cmFuc19j
dGxfbG9jayk7DQo+K30NCj4rDQo+K3ZvaWQgbXRrX2RwbWFpZl9wbV9yZXN1bWUoc3RydWN0IG10
a19tZF9kZXYgKm1kZXYpDQo+K3sNCj4rCXN0cnVjdCBtdGtfZHBtYWlmX2N0bGIgKmRjYiA9ICgo
c3RydWN0IG10a19kYXRhX2JsayAqKShtZGV2LT5kYXRhX2JsaykpLT5kY2I7DQo+Kw0KPisJaWYg
KCFkY2IpDQo+KwkJcmV0dXJuOw0KPisNCj4rCW11dGV4X2xvY2soJmRjYi0+dHJhbnNfY3RsX2xv
Y2spOw0KPisJbXRrX2RwbWFpZl90cmFuc19jdGwoZGNiLCB0cnVlKTsNCj4rCW11dGV4X3VubG9j
aygmZGNiLT50cmFuc19jdGxfbG9jayk7DQo+K30NCj4rDQo+IHN0YXRpYyB2b2lkIG10a19kcG1h
aWZfY2xlYXIoc3RydWN0IG10a19tZF9kZXYgKm1kZXYpDQo+IHsNCj4gCXN0cnVjdCBtdGtfZHBt
YWlmX2N0bGIgKmRjYiA9ICgoc3RydWN0IG10a19kYXRhX2JsayAqKShtZGV2LT5kYXRhX2Jsaykp
LT5kY2I7DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19kcG1h
aWYuaCBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19kcG1haWYuaA0KPmluZGV4IGU3
ZTJmMzMzMTQxYy4uMjBmZDUzZmQ0NGI1IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L3d3YW4v
dDl4eC9wY2llL210a19kcG1haWYuaA0KPisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9wY2ll
L210a19kcG1haWYuaA0KPkBAIC0xMCw1ICsxMCw3IEBADQo+IA0KPiBpbnQgbXRrX3BjaWVfZGF0
YV9pbml0KHN0cnVjdCBtdGtfbWRfZGV2ICptZGV2KTsNCj4gaW50IG10a19wY2llX2RhdGFfZXhp
dChzdHJ1Y3QgbXRrX21kX2RldiAqbWRldik7DQo+K3ZvaWQgbXRrX2RwbWFpZl9wbV9zdXNwZW5k
KHN0cnVjdCBtdGtfbWRfZGV2ICptZGV2KTsNCj4rdm9pZCBtdGtfZHBtYWlmX3BtX3Jlc3VtZShz
dHJ1Y3QgbXRrX21kX2RldiAqbWRldik7DQo+IA0KPiAjZW5kaWYgLyogX19NVEtfRFBNQUlGX0hf
XyAqLw0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMg
Yi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMNCj5pbmRleCBiYWFjMzY5MmYx
ZTMuLmY2NTljOWE3YWE5NiAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNp
ZS9tdGtfcGNpLmMNCj4rKysgYi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMN
Cj5AQCAtMTEsOCArMTEsMTAgQEANCj4gI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiAjaW5j
bHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0K
PisjaW5jbHVkZSA8bGludXgva3RocmVhZC5oPg0KPiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
DQo+IA0KPisjaW5jbHVkZSAibXRrX2NsZG1hLmgiDQo+ICNpbmNsdWRlICJtdGtfZGV2LmgiDQo+
ICNpbmNsdWRlICJtdGtfZHBtYWlmLmgiDQo+ICNpbmNsdWRlICJtdGtfdHJhbnNfY3RybC5oIg0K
PkBAIC0xOTksNyArMjAxLDYgQEAgaW50IG10a19wY2lfcmVnaXN0ZXJfaXJxKHN0cnVjdCBtdGtf
bWRfZGV2ICptZGV2LCBpbnQgaXJxX2lkLA0KPiAJfQ0KPiAJcHJpdi0+aXJxX2NiX2xpc3RbaXJx
X2lkXSA9IGlycV9jYjsNCj4gCXByaXYtPmlycV9jYl9kYXRhW2lycV9pZF0gPSBkYXRhOw0KPi0N
Cj4gCXJldHVybiAwOw0KPiB9DQo+IA0KPkBAIC05NzAsMTEgKzk3MSw5MyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHBjaV9lcnJvcl9oYW5kbGVycyBtdGtfcGNpX2Vycl9oYW5kbGVyID0gew0KPiAJ
LmVycm9yX2RldGVjdGVkID0gbXRrX3BjaV9lcnJvcl9kZXRlY3RlZCwNCj4gfTsNCj4gDQo+K3N0
YXRpYyB2b2lkIG10a19wY2lfcG1fdHJiX3Bhcmsoc3RydWN0IG10a19tZF9kZXYgKm1kZXYpDQo+
K3sNCj4rCXN0cnVjdCBtdGtfY3RybF90cmFucyAqdHJhbnMgPSAoKHN0cnVjdCBtdGtfY3RybF9i
bGsgKiltZGV2LT5jdHJsX2JsayktPmN0cmxfaHdfcHJpdjsNCj4rCWludCBpOw0KPisNCj4rCWZv
ciAoaSA9IDA7IGkgPCB0cmFucy0+dHJiX3Nydl9udW07IGkrKykNCj4rCQlrdGhyZWFkX3Bhcmso
dHJhbnMtPnRyYl9zcnZbaV0tPnRyYl90aHJlYWQpOw0KPit9DQo+Kw0KPitzdGF0aWMgdm9pZCBt
dGtfcGNpX3BtX3RyYl91bnBhcmsoc3RydWN0IG10a19tZF9kZXYgKm1kZXYpDQo+K3sNCj4rCXN0
cnVjdCBtdGtfY3RybF90cmFucyAqdHJhbnMgPSAoKHN0cnVjdCBtdGtfY3RybF9ibGsgKiltZGV2
LT5jdHJsX2JsayktPmN0cmxfaHdfcHJpdjsNCj4rCWludCBpOw0KPisNCj4rCWZvciAoaSA9IDA7
IGkgPCB0cmFucy0+dHJiX3Nydl9udW07IGkrKykNCj4rCQlrdGhyZWFkX3VucGFyayh0cmFucy0+
dHJiX3NydltpXS0+dHJiX3RocmVhZCk7DQo+K30NCj4rDQo+K3N0YXRpYyBpbnQgX19tYXliZV91
bnVzZWQgbXRrX3BjaV9wbV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4rew0KPisJc3Ry
dWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+KwlzdHJ1Y3QgbXRrX21kX2Rl
diAqbWRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4rCXN0cnVjdCBtdGtfcGNpX3ByaXYg
KnByaXYgPSBtZGV2LT5od19wcml2Ow0KDQpSQ1QNCg0KPisNCj4rCW10a19wY2lfcG1fdHJiX3Bh
cmsobWRldik7DQo+Kw0KPisJbXRrX2NsZG1hX3BtX3N1c3BlbmQobWRldik7DQo+Kw0KPisJbXRr
X2RwbWFpZl9wbV9zdXNwZW5kKG1kZXYpOw0KPisNCj4rCS8qIE1hc2sgTUhDQ0lGIGludGVycnVw
dCAqLw0KPisJbXRrX3BjaV9tYXNrX2lycShtZGV2LCBwcml2LT5taGNjaWZfaXJxX2lkKTsNCj4r
DQo+KwkvKiBNYXNrIGFsbCBNU0ktWCBpbnRlcnJ1cHRzIGF0IHRoZSBkZXZpY2UgbGV2ZWwgKi8N
Cj4rCW10a19wY2lfbWFjX3dyaXRlMzIocHJpdiwgUkVHX0lNQVNLX0hPU1RfTVNJWF9DTFJfR1JQ
MF8wLCBVMzJfTUFYKTsNCj4rDQo+KwkvKiBTYXZlIFBDSSBjb25maWd1cmF0aW9uIHNwYWNlICov
DQo+KwlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsNCj4rDQo+KwlyZXR1cm4gMDsNCj4rfQ0KPisNCj4r
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfcGNpX3BtX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+K3sNCj4rCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOw0K
PisJc3RydWN0IG10a19tZF9kZXYgKm1kZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7DQo+Kwlz
dHJ1Y3QgbXRrX3BjaV9wcml2ICpwcml2ID0gbWRldi0+aHdfcHJpdjsNCj4rCWludCByZXQ7DQo+
Kw0KPisJLyogUmVzdG9yZSBQQ0llIGNvbmZpZ3VyYXRpb24gc3BhY2UgKGluY2x1ZGluZyBNU0kt
WCBlbmFibGUgYml0cykgKi8NCg0KdGhlc2UgY29tbWVudHMgYXJlIHJhdGhlciBvYnZpb3VzDQoN
Cj4rCXBjaV9yZXN0b3JlX3N0YXRlKHBkZXYpOw0KPisNCj4rCS8qIFJlLWVuYWJsZSBidXMgbWFz
dGVyaW5nIGZvciBETUEgKi8NCj4rCXBjaV9zZXRfbWFzdGVyKHBkZXYpOw0KPisNCj4rCS8qIFJl
c3RvcmUgQVRSIChhZGRyZXNzIHRyYW5zbGF0aW9uIHJlZ2lzdGVycyBpbiBNTUlPIEJBUiBzcGFj
ZSkgKi8NCj4rCXJldCA9IHByaXYtPmNmZy0+YXRyX2luaXQobWRldik7DQo+KwlpZiAocmV0KSB7
DQo+KwkJZGV2X2VycihtZGV2LT5kZXYsICJQTTogZmFpbGVkIHRvIHJlLWluaXQgQVRSIG9uIHJl
c3VtZVxuIik7DQo+KwkJcmV0dXJuIHJldDsNCj4rCX0NCj4rDQo+KwkvKiBVbm1hc2sgTUhDQ0lG
IGludGVycnVwdCAqLw0KPisJbXRrX3BjaV91bm1hc2tfaXJxKG1kZXYsIHByaXYtPm1oY2NpZl9p
cnFfaWQpOw0KPisNCj4rCW10a19jbGRtYV9wbV9yZXN1bWVfZWFybHkobWRldik7DQo+Kw0KPisJ
LyogUmVzdGFydCBDTERNQSBUWCBxdWV1ZXMgdGhhdCBoYXZlIHBlbmRpbmcgZGVzY3JpcHRvcnMg
Ki8NCj4rCW10a19jbGRtYV9wbV9yZXN1bWUobWRldik7DQo+Kw0KPisJbXRrX2RwbWFpZl9wbV9y
ZXN1bWUobWRldik7DQo+Kw0KPisJbXRrX3BjaV9wbV90cmJfdW5wYXJrKG1kZXYpOw0KPisNCj4r
CXJldHVybiAwOw0KPit9DQo+Kw0KPitzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgbXRr
X3BjaV9wbV9vcHMgPSB7DQo+KwlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhtdGtfcGNpX3BtX3N1
c3BlbmQsIG10a19wY2lfcG1fcmVzdW1lKQ0KPit9Ow0KPisNCj4gc3RhdGljIHN0cnVjdCBwY2lf
ZHJpdmVyIG10a19wY2lfZHJ2ID0gew0KPiAJLm5hbWUgPSAibXRrX3BjaV9kcnYiLA0KPiAJLmlk
X3RhYmxlID0gdDl4eF9wY2lfdGFibGUsDQo+IAkucHJvYmUgPSBtdGtfcGNpX3Byb2JlLA0KPiAJ
LnJlbW92ZSA9IG10a19wY2lfcmVtb3ZlLA0KPisJLmRyaXZlci5wbSA9ICZtdGtfcGNpX3BtX29w
cywNCj4gCS5lcnJfaGFuZGxlciA9ICZtdGtfcGNpX2Vycl9oYW5kbGVyDQo+IH07DQo+IA0KPg0K
Pi0tIA0KPjIuMzQuMQ0KDQoNCg0K

