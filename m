Return-Path: <netdev+bounces-290713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOKiAaALEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1045B040B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07CE2302975B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044839934A;
	Fri, 22 May 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIbhqbEk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC145346E7D;
	Fri, 22 May 2026 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436118; cv=fail; b=g7YKB7LMVS5ZCTmIISd7j5A8bLk+byi6vh6Rj11f+fwf2/Cbdtx3ix7z9Lsq32iLTi0PBM0hVm+BTNlEEr+4VwNt25z6WZoJox+wRu4WHedze0VmD2Mix1WH00sQIIT7619IpPQY1pmcdT2Ie/w2+jZuXGLbMzBx3inLJVn9M58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436118; c=relaxed/simple;
	bh=btc7xKEaAn9klKQ7uCAzBQjgUCrNx1QUlet4TUwS+JI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B03ItxhjoQlitKt6VOphoimT2uT1KDEPtm86dh4vxrSNM8Yo1j0cv+u6Yb0BpqV770Z9fvimXVkAJB9Rqd+ZoraA7nIENlImO1u8Cra4wU747mElbpZOlhIiUl3iCLPma+laXDSnT2m43ydh05I1KhXHQVwS+bq2XTvTa+4vd50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIbhqbEk; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779436115; x=1810972115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=btc7xKEaAn9klKQ7uCAzBQjgUCrNx1QUlet4TUwS+JI=;
  b=UIbhqbEkNX+cWqIqZ7zTw5uBp42028up8WSYdVeZTZnYvb6QftwGWqkE
   O9hU2SN+Uo62jJBxMbeAMxXV6k0ddLC7Sqffx1Wsi1l4ezs7WRm8qFplp
   cGUD1ogw58ab2SiSemV2Z+wIN5cv5K5XiSF5th+HwMH7qhlr1qjGUMasJ
   HArzazqoMVMq4w38p+4Q6YE5wPTlZj5dQiyTGYkoZXI/1tbBVyq156U2y
   fjxVGwMdpDf5WwKq8h0Xv7s6/ea10CTFJ6x2dkpBBFLQb+2FLtuI8ddUd
   PIx6ODYWNvPBPHHp9YjWopiDsplg7t1SFq9DCOfy9oUmeX36XGCcDk08v
   A==;
X-CSE-ConnectionGUID: Ec7eYx+4RWCS31JWsX6c4w==
X-CSE-MsgGUID: r4xPfD+7RxWKKEVsUBMfzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80346890"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80346890"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 00:48:32 -0700
X-CSE-ConnectionGUID: Sbi3J6MZRteCzg1cG3M5ew==
X-CSE-MsgGUID: BFpAlouLQHyGowQ5iF5jaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="240719525"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 00:48:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:48:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 00:48:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu8CrBnqe4zn8PvbENkd7DMnReU49a8lBsq3LqI39QVCQByw8U4/Xq9hUY7vZERxXGx2vpi6gyrufEfj05UJB0JvqEGRQ+lUSxsp1QvC57ciI4+Rx5nSxfxS5eJBhaNUH6UeOUIB9SoKZqAHmR2nsmE/o1jk/pdSNBEK++4K+Mnm80hfFRdO0eqLZ4w57JdNOjIAomku5pg7q+bHJDbEWGL1/D1yl8+3dQd8ngo9LFeK20UG1Jri3e755Z2L7nmGku6y6E9UHp9DUCpgnJ0vKCL1R+0b+wiBAIDF/IJsztVvaoQLN4fZ95t5jhYPuNBXfEv92392GSbr1+yI1on6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btc7xKEaAn9klKQ7uCAzBQjgUCrNx1QUlet4TUwS+JI=;
 b=M/PkfLfmaq6E35xEXaAP62IogyGXTznC2CnzJ3U5NPOjdav1eRX/ablmL1sBLikW8gRjoxiXh0D3WWubiZ3YzhEwDXSTFxPJwviH5wktgfmrfRiHBoFIAvwqP+hfafc8wxM44b1BA8e5y1GyohxoQFluCtGTg3g897+6ZMPv8ODItU6zcbwYytkElKKVcElpiJZZ9DVVCDf7k1nLU2n/VkTYvugab4D5pcTUY8EG0wHsNNQSZMu3TgoOzsvhJJlYnHC+3J3xsrg/UkGxJGiqSGeDlqpXIbA78Ly/wFnqCLP3Sg1Kftlx+q8cfHQTin2mjUQCNXsPnnCeU/3y1TcBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:48:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 07:48:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, andrewnetdev <andrew+netdev@lunn.ch>, davem
	<davem@davemloft.net>, edumazet <edumazet@google.com>, kuba
	<kuba@kernel.org>, pabeni <pabeni@redhat.com>
CC: intel-wired-lan <intel-wired-lan@lists.osuosl.org>, netdev
	<netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next] net: e100: replace silent
 'hope for the best' with debug message
Thread-Topic: [Intel-wired-lan] [PATCH net-next] net: e100: replace silent
 'hope for the best' with debug message
Thread-Index: AQHc6Oh/Q9N7zFqJ5kC/Pq6VYlCqMbYZrKkg
Date: Fri, 22 May 2026 07:48:20 +0000
Message-ID: <IA3PR11MB8986EDBA4EA8378617535BACE50F2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
In-Reply-To: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB7841:EE_
x-ms-office365-filtering-correlation-id: 6ea7abc5-eb5f-4f15-2cd2-08deb7d67e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021|11063799006;
x-microsoft-antispam-message-info: xkJE6Nt3TWbXbqTOCo2jzK9U6+7GDv2YNxst04U99fCB7zYUkDIaaIRN2hbKeCqzobub+1RZSMQyz21Hy9NsgKxvOUluUXRyhKAQv297rQ6ssCR4EOStDucReyL0FOTG6RpLqg98Sd6eoEJ/BrwvEaozmDQcEeQmKi2dJgrFHjTt/YLh8bqafzd+NpiW07Ae/NuC+7wSOAVFiYjXr+WN47LzGJ7pO19YO+Y7Bz5tInWyJjtCe/Tq7ZpARBAx4Z/9AZP+oXOX0TpHbOsmxvPOvP4TZqtP0vAXjYXaKzIRw/+L5vILWGuU/JhJpPw1YzdZnmPPVy+XMoVAVCtXCvPYEia96eOmWmZUfCgIpT3YaSpOmL9EpPrIEgxGL3O+Z3jaBDD8Jw9uPNVyFuH+VYoQqSJoT+eY8T6JO/sFJNFf1gOpkDP+5eE/E9wglTdSrtWrNvYFXVQHXZOYZS4bgxr79MhRPXnFqRaxnuS6TGTvHp54VXN+WPYDsULlqP4DMN8a/23PaniIW1VF/16UAthE+z+rA1ex9jUGLCiKSAXYWdJQYWV9Gy+nyb+2GSHPsuvW+vTx1ClMLmetgdhNHE1bTE5bUe27uCPIRbnHhC6ZFT296FmP1dnJW1FKOMvxZHWBL4i85cbaseVivw1WwzGvwVVDpxeN7dgeEpY3KkxChbx8gh6Ys6ZSiG9p4yfZAVfGnwVLS9lH9FHY1bjmUM3W2hrF6cwf4XwHz4lSb25t0DoIXOCs+UFYAG/TUeu499lO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0hGem1KU3A0SENEK0xhSUNnTDZaZW00RTduc2VrbXJaRVl5SVRyRFB0MFlx?=
 =?utf-8?B?WDMyOUFYVUUxRG13QXpBeEtGU3lWeUVHNnhOYjc4NHg2cmt2NTArb1JEVnNv?=
 =?utf-8?B?WWc0UXJCUndEbkFJWTZSTXNkT0VRSDlYZlV0VW9nZytiQVQ2SWhiU3VweXVK?=
 =?utf-8?B?QkI5QXpTSkRwdjlqZDRlNmNtTThpckNFSlFSbDJvV1p5WHpRbWo5cTZUaUlk?=
 =?utf-8?B?NXE5aC90ZHMzMDh6d2ZoWWFxSkxXTmUrYmh1cC9pSDRLdWpHdm5xWEgrWFp4?=
 =?utf-8?B?Zlk2V2x1cm5YTDVSSFZTTFRsT1dnTmx2dUNqT0ZSVFpIcmx1RStkbmwweURI?=
 =?utf-8?B?MmlFSndPaVM1Rzk5dHlKVVlzSDhEUVBPNS9NMXV4RmU2K1pQQkFEZXhxUnJJ?=
 =?utf-8?B?REtzMEJ2akhkNEdmZ2pHVERNSmhGakQ4V1JqSkIwNGRrakIvKzRKZ3VtOUN1?=
 =?utf-8?B?VjI1QXVYTDNoVDRHcW1jTnZiV0JqZERnWVNIb2xQWmFydEYwVUhxSzdiRjFP?=
 =?utf-8?B?a2VjVUQrL2JBZlpaOU00cGJzWDhjYUpZc2UzMnBMYVlHUGtVUDRzaUVobjFk?=
 =?utf-8?B?SFA3cDBKYkU5RS9nbXRkKzN6ZDRWbEZubWVwVHJXQUlWUU5GWnNtL3F4Y0My?=
 =?utf-8?B?OGhpK0huR2NzdnROTVhNMXM5ZWRBQ09xRVgyYjNxRzVaVGhJaGduaGU2MGJG?=
 =?utf-8?B?SEg1K2dhUUU3a1Zsc3JCQkZpQklFNjVrOVJiYVBqRXNBQ2FrYWFJRk5qR0h3?=
 =?utf-8?B?cnJydTJ0MWY3aVlzdFFJQ0NjTmZYZVA3SnhOLzg0VU1sYUg5RHNjRWVFdFdY?=
 =?utf-8?B?bGJvNFBYdzN1T0VoaEwrQzlZVjhqTGNYem9COXY2aEhJc0dia3ZzYjZyZHZI?=
 =?utf-8?B?ODZLNTdWcHBsR2cvZ2NNRk9rcDRRdUNZQlcveklNVDdTdytRR01VVVVDVGND?=
 =?utf-8?B?azRQSU5XRGRYZkVCREh4Z3libzhLVUZXeHd4V1U2VDd2eGZwUEViRUNCaExz?=
 =?utf-8?B?RThQWEFpOU1QSWlaUGEwQVFYeVZJYURJWWkzVGhTcEVONlhLaXM2ckFhVDJu?=
 =?utf-8?B?RDRYU0FEU093bFFaT2p1U2h2UTJsVTJ6WUFuL2hpVmpIR0dtYWptVjl0N1FF?=
 =?utf-8?B?WEF2QUJQZ3Bqc3ozWFNQYzQwVk9IZzBVOHFxeE1UYkRKTDYrSGdpSTRnMTB0?=
 =?utf-8?B?eVA2Tjd0Skw4N2c3aVJ4Q0ZaUUxvdjkxcVFOOHF0bE5IVFhaK2ErcUYvVzE5?=
 =?utf-8?B?MHdHV1ZsVzVISlRBckJsY3pQUmRqVHpzNmZ6Z0hudlJPYlpVUXJ3K0VHN3c1?=
 =?utf-8?B?Q3BleGd4dkEyVnVUWlE4MGsrYy9sV05jVFp3cVRlN1ZKbkpFTVpYUFE4ckFV?=
 =?utf-8?B?U0NNRVNnSWlDOFl2WVc3SlFDbGVlYW5qTE1iYkxQdjRZaWc3eVlhWFErZ3Ay?=
 =?utf-8?B?TjR4YTVyYVJFZFdEZWpwMUEwQ3FkTERFbitSSVk3NVlmSnk3eGVYNXpadjcw?=
 =?utf-8?B?Q3R2N083ci9WUk5Rb0pvbFhxR0NvRTEzRFhNeVRkTE5JTytPSi9IbGh2bllo?=
 =?utf-8?B?bkZvbnh5U0t0eGRkR20wQUNPd3RoMkcyNTFqdUxndjVldjAwNWFQTlliMklF?=
 =?utf-8?B?VTFEUk5Id2FwUnk3UjRDYkxqc0pHMXhTMnhBNDJRNVNZVEdzNmNma0NqSG01?=
 =?utf-8?B?d1FVclBEU1g4b1p2UG5Ndy9hZityYW5jVHladk90Zi9qVlhDV1VtV0dDTnFF?=
 =?utf-8?B?Mks5amdmK1pKUFBudE0xeG96L2pZcmRpbG54L1QrdStxT21PbDQwRmNWeUNZ?=
 =?utf-8?B?TUE5ZFZmeDgzQ0owNGJhck9PWlNQUUdRRDB4c1B5K2RhS1JCS3dvMFVMVUxy?=
 =?utf-8?B?NmdpRFhTVXUxajlFUjMvTWZicHFodDUxM1NnWUJEbUhUaFl6M2s1VGNYT3RX?=
 =?utf-8?B?NkR0aWlmekIxV2U1NmY0eG1XZW52cFJVR2RRWEtWV2RCUFY0OXV0ZXJacWJP?=
 =?utf-8?B?WjV1bmY2VkdDTnM2QWQ3OGcvRC9ibGI1OFlWSUpGVkpOTzcyR1FXcFhGQXFV?=
 =?utf-8?B?aXVscW83WWpXVG55RXI5UjBoeS9Wd0dXSFFqMVBneFR2WEFsem52NmlGR0hx?=
 =?utf-8?B?d3FuU2x4Y2VTaXE5K2lndk14QS9XWjNmekVvMmZJdWxnMGR3VU5Wck45aHl0?=
 =?utf-8?B?L2hMcS90SzI5WGZjTUF1Q3NickpmNFNtS3kxdnZTUmdUTk92Q1JBQnBWT2Zx?=
 =?utf-8?B?cGZjUnFIWGZmaFM4c0hSclVrQmJPR2ZYOUQ2TTBjQjFMTks4U0d5cHMvejR6?=
 =?utf-8?B?eE5vTUFqczhua1pFQ2Z3M0RIYUVTK2tFME9Xb3dhV0RwVFhkSHJPMXc0RU10?=
 =?utf-8?Q?asebP+x5RKSoQMG4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pTAcDQQMBpmHOP5SoANCPdQVGzSMa4CqvwbU3KQV0hGKFsyQbojl/6tGI9urA9lR/JYdf5tI0lu+0RQlGMzroqhxsH9z8BAqn+bmaT5u9CsrEI+i/FrVAxvslGivQn9PkgKNcGrS8fuMHVPUUEqlzdwvz4eFxpB8UiWlLdmpiOBUM4gGH7OKrwsXI9Y00HgGfnPO0DtiopFZJEOxNVpfvCi3nUDuogmkB5PQrYdQeHlyPkhLR6s1IcScKhTznusC9OgE+H9Yy84UuoYWYEH/GZNqFQ86U7/8teiHU9+a7jI8fmm6NhepsGtbSkuAeo08p5NvCIQmY5TOTN2KMnPbAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea7abc5-eb5f-4f15-2cd2-08deb7d67e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 07:48:20.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJFrxiZY9K5rGXOLAv95igmIrbpLkFrLv+HjAZAWBdMwob7H0OrQHYvMiotxQOwfTXy5aLdEDDADYgD3TXoGQse7LhpxqjZqVGByRmUNhrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290713-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url,davemloft.net:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.482];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5A1045B040B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQXNo
d2luIEd1bmRhcmFwdSB2aWEgSW50ZWwtd2lyZWQtbGFuDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkg
MjEsIDIwMjYgODoxMCBBTQ0KPiBUbzogS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5r
aXRzemVsQGludGVsLmNvbT47IGFuZHJld25ldGRldg0KPiA8YW5kcmV3K25ldGRldkBsdW5uLmNo
PjsgZGF2ZW0gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBlZHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47IGt1YmEgPGt1YmFAa2VybmVsLm9yZz47IHBhYmVuaQ0KPiA8cGFiZW5pQHJlZGhh
dC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vv
c2wub3JnPjsgbmV0ZGV2DQo+IDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVs
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQt
bGFuXSBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZTEwMDogcmVwbGFjZSBzaWxlbnQNCj4gJ2hvcGUg
Zm9yIHRoZSBiZXN0JyB3aXRoIGRlYnVnIG1lc3NhZ2UNCj4gDQo+IEZyb206IEFzaHdpbiBHdW5k
YXJhcHUgPGxpbnV4dXNlcjUwOUB6b2hvbWFpbC5pbj4NCj4gRGF0ZTogU3VuLCAxMCBNYXkgMjAy
NiAxNTowOToxMiArMDUzMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIG5ldDogZTEwMDogcmVwbGFjZSBz
aWxlbnQgJ2hvcGUgZm9yIHRoZSBiZXN0JyB3aXRoDQo+IGRlYnVnICBtZXNzYWdlDQo+IA0KPiBS
ZXBsYWNlIGEgc2lsZW50IHJldHVybiB3aXRoIGEgZGVidWcgbWVzc2FnZSB3aGVuIG5vIE1JSSBQ
SFkgaXMNCj4gZGV0ZWN0ZWQgb24ga25vd24gdmFyaWFudHMuIFRoaXMgZ2l2ZXMgdXNlcnMgdmlz
aWJpbGl0eSBpbnRvIHRoZQ0KPiBmYWlsdXJlIGluc3RlYWQgb2Ygc2lsZW50bHkgaG9waW5nIGZv
ciB0aGUgYmVzdC4NCj4gDQo+IEZvdW5kIGJ5IGNoZWNrcGF0Y2gucGwgaW5zcGVjdGlvbi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFzaHdpbiBHdW5kYXJhcHUgPGxpbnV4dXNlcjUwOUB6b2hvbWFp
bC5pbj4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwLmMgfCA0ICsr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwLmMNCj4gaW5kZXggOTA3NGI1NThkZTM1Li5i
ZmFjZjg3N2NhNDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2Ux
MDAuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwLmMNCj4gQEAgLTE0
NTAsNyArMTQ1MCw5IEBAIHN0YXRpYyBpbnQgZTEwMF9waHlfaW5pdChzdHJ1Y3QgbmljICpuaWMp
DQo+ICAJCSAqIEJ1dCBkbyB0aGlzIEFGVEVSIE1JSSBjaGVja2luZyBvbmx5LCBzaW5jZSB0aGlz
IGRvZXMNCj4gIAkJICogbG9va3VwIG9mIEVFUFJPTSB2YWx1ZXMgd2hpY2ggbWF5IGVhc2lseSBi
ZQ0KPiB1bnJlbGlhYmxlLiAqLw0KPiAgCQlpZiAoZTEwMF9waHlfY2hlY2tfd2l0aG91dF9taWko
bmljKSkNCj4gLQkJCXJldHVybiAwOyAvKiBzaW1wbHkgcmV0dXJuIGFuZCBob3BlIGZvciB0aGUg
YmVzdA0KPiAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgbmV0aWZfZGJnKG5pYywgcHJv
YmUsIG5pYy0+bmV0ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJO
byBNSUkgUEhZIGRldGVjdGVkLCBjb250aW51aW5nDQo+IGFueXdheVxuIik7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gIAkJZWxzZSB7DQpEb2VzIGl0IGNvbXBpbGUg
d2l0aG91dCB9IGVsc2UgeyA/IA0KDQoNCj4gIAkJCS8qIGZvciB1bmtub3duIGNhc2VzIGxvZyBh
IGZhdGFsIGVycm9yICovDQo+ICAJCQluZXRpZl9lcnIobmljLCBodywgbmljLT5uZXRkZXYsDQo+
IC0tDQo+IDIuNDMuMA0K

