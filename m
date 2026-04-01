Return-Path: <netdev+bounces-273890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FJjLbeqzGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF7374D7D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ECF43078186
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125081925BC;
	Wed,  1 Apr 2026 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvpdkqRw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C862D595B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020725; cv=fail; b=uLUbdSXhgZz3k68L35VfLN09egGPaYcK343bVCnPizu5Ah6d6kt/HkZmjPlGHmLw4a33d7Ye5xT0U6E7VhQ5nlA5fSolDjpR8pZwgk14aE/KqXtMHySiOEiHLAdlTdTSPQPw0VSgqpwZ09k8YlEZt46tmK5/b3yO+x0sljXbeWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020725; c=relaxed/simple;
	bh=fFEJnIZIciF03J1BFt7lkE9ZQuQR5ZDsygyW5P6fevc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhqkJ3FIWH2HIixwK5x8VwoT+DUOll5jH3ZN5ZTzkTLszaedCYlCt1yUjw0oFO83Fynm0bG8jO9Z0ZjjckjsoXOtL6pYRZcxuQhkcebV8WZEDnz43OX4+2sNior6rL6pXjWBDLqbYKgSupOcNGpzaA9GUe3KMcRT/D6DAB550Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvpdkqRw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775020723; x=1806556723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fFEJnIZIciF03J1BFt7lkE9ZQuQR5ZDsygyW5P6fevc=;
  b=RvpdkqRwmn+93N8s0C6mBwV+0xL7lsKHUpAR3u5SdaxuPSTkM3x/w9ag
   GGqbLCPd0VbrZpDhaAIip1kyOXM83U3lEJDI1VYgbhJ7Mv3mKFRn69inf
   Q6noTUt1LvB/bTWw30j30+tD/yHbwR80FAuIp5S8ZM88uqs12fwqh2vPE
   jLkCKIpSrlt1l2cc+26uvlLcOHeGE6wuSZ0HSPFqiS2QolcPLfm9loIce
   d8C/jIWOn0kdHU9LCYMhDWN4qZAsTTW6lxHEg4yo7Ifduk3PLrzDcicWb
   Cfz3gbpg6q3Rch+BFkn78EbbKXt+ynmiWdSyN1eLSMqgX8TyKDlAIQS+b
   g==;
X-CSE-ConnectionGUID: 594mvByeQMWCnyrvvRdxqA==
X-CSE-MsgGUID: tWUyBkZETtWW9/iSOLVXGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75934541"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75934541"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:18:43 -0700
X-CSE-ConnectionGUID: h/tB+bi5SsqzkmrUwZhMRA==
X-CSE-MsgGUID: feWBLtxbRIerHLgqRJEIyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231370439"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:18:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:18:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:18:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVUCLz6PZu3E6sY6cYjSlhFJ+bFc6x0hHFbsGy1JFRgkhzmyuJ+JB2xvHspeuSQuizIV9iYPWuEm24XuOhSxoElZeu7vXGO1ItA3zjJJgMsO06Xu57S0rr+NvZBWxO3nXFAK4qsvBZIi9rctaF0OaTJoEEspGtgo2pFOf6vBB0x/ESskSubNx4cmn8dafCCw1RrNOK+hZT8D1dNRUejtl/2yp6Br28adA0MFeTaIlQFhP+3Oun/S1CqnHi1mmuzctDgJKbyG6mDwTAVG16XmgeeuVyrnW7GWbklmaTu/aNohlOQIgRx+Kx0a8Tks5HJ5aN1XwhtmhSMfzFwnjEL5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFEJnIZIciF03J1BFt7lkE9ZQuQR5ZDsygyW5P6fevc=;
 b=JIYayCPKD9sLB3rsfuzRi3NiyLywL+HH94zweqJJVjos/ydIoLSSD9XGyVTXfWC0s+AVDYLt8EJ8KPMvU5NlGcqi2S30J3Wq/14N+l6DGYdQqTq4CfTh1lpCltx0K5b0DPC57f0++tSlxHzXrmgrxelRvPGZMQ+uDxP12A1PGKElsF1xM3nmC1/e6g3HyTCtG58Vbf3HwiozTboPnyLY6WrvWuKzCrHaheaHLK7lR1+brDfK8G+EiCO7bNu4h3aXKtdmn4VJPKgGGVZ1UwkY6uuobBQqfg3FCXR4687WCsZJQ0RNAOKKnDlMG60hQ70XNPmmi4PIx7MP/4UZLRYKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CH8PR11MB9505.namprd11.prod.outlook.com (2603:10b6:610:2bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 05:18:36 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:18:36 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] i40e: only timestamp PTP event
 packets
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] i40e: only timestamp PTP
 event packets
Thread-Index: AQHckWmm/8LYYqrwx0KdQWDQJsb/A7XKAigA
Date: Wed, 1 Apr 2026 05:18:36 +0000
Message-ID: <IA1PR11MB62415AFD07D8050D078EEB628B50A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
In-Reply-To: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CH8PR11MB9505:EE_
x-ms-office365-filtering-correlation-id: 5f3d5bee-c34f-448a-cf45-08de8fae2042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: CisA3qelK7gh7LzGlzLASlVHF94n2mSao6SaCkjJepsf6BD7KStXMYokj5iAtXdMaqCYuUj/HCtBFYNMoQAMCGyVjztdmTeGW5rHux9F9NtFTGxOv4wrTJh/5G4i3XBW7IMyvU8tVfWDD1OAM/AjA98vBOKA+OWqWU/tdAveSiAWXu/V4a20ifdP0Y6GtKyr9PlJABZJzCiv9YHsEFJxEoEQcE9q2Jl8iuaMb2RUqQa0QH1znYEBoFPpFt2lN5ZTxWzHzQnSAJMjGKC61xQ9IEG3deFmJUUWKgFWExzDfLoIaNeWWHLXtJ5L7/fD0eeSVYUpHCEbof3pQC9D8fYJnzAURu9O1jM1+sQ1GmDTgrgUsTKG6rr7+d02LFzGKki1EIM8IhXQ/vzKV4vmuntV+cS9L5e+ciARA7ptuS/s/Oi2sEZG8qgShQxl9xg902sTNv94pE0IECmpHPlbwYGO1KPD88F4WhPOegx74PIsSVxV2xKSt01Qxgu39CKRagM5uv0CLXStVJ6pPl626QUTv1eM/z/BWHBJ575vfC2iqGR4JJ506DnNLWeeo2ietBxO66P6Y0u/0Yd/cdpn/wDC+YOwbfYFqwHGaRQ2v0ZAMxraEvv753dGd9cET8o9VaTO629rPtMPJ17nk9PdC3kAN46vYN8XdwCzpVgL5kzrG0ygON74cxcLvJqB9QE/XN3jhmtUk3kHQCQTF7dCV6Vhl0v0+pdQFb5dTUbmcePAOqFB6MHy7URtBNBmMJlnXIY4NFuaHNCpNnKpURTPL68jBXrHj85c38GiDNAwmqLKlEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Und4WUdRVTErNU1vdml2blZIMnZIMENZM3FDeDR0RDVRd2xjRVUyM0hmeWlP?=
 =?utf-8?B?VnJ1M1RKYUhOT2pBWW9kdnYrd1ZvNm91bXRUUVZmSUhCSENhM0NFVzdveTgy?=
 =?utf-8?B?Tlg0WWp5UmZTM0NOSDY0TUQzZHlPeDFQWStPZjIrK2VDU1VKYVZaaFBra1Nj?=
 =?utf-8?B?RzJkZFIvOGgyNThYSWl1QWNVSDFNeVRkRWxBS050UVBhaksrc09NNGhSOG9S?=
 =?utf-8?B?WWYyOGwrc1BkZE5zN1BCN1hkK08wM053MkV2d2oyRjZuakhJV3hCNDZ1a3Qy?=
 =?utf-8?B?LzA1dlRRUzRvaEpWU1NkT1E2RGtPWXNvcURleC9tRVc2bDMyb0FuS2JzaGty?=
 =?utf-8?B?ckxtNDlTTTNodFRBQ3JGbU9Vd1V4dk14Q0pRR2xxOThRVWt6bFNDbHRYazRw?=
 =?utf-8?B?bUVRYnc2L05rUUZsMytEL1ZiYm9yeW1pTWFpRVFDb29tSFZqbGIxNEw2TzN2?=
 =?utf-8?B?ZVlDWWE4VllBZmxkTWdhMXlYQ1Q4UkFWc2NUdDFvT0ozWmtFeThWdW1qV1BC?=
 =?utf-8?B?bU9UZURrMFdxT3VxRjAyNllZaVpBV2NQdlVqenRjbm9VTG1VYjV2aTRNSWxX?=
 =?utf-8?B?SDFsMDhwMHlaUEZGUjlSN0wvVC9xUWJPNWNnbi9pN3M1R1huWkJFMWY0NHhL?=
 =?utf-8?B?NktvaDRGT001azBHd1hVekkrSjhFSHRKeTdXeVBIb3NKSExOclF3M3ptMVFk?=
 =?utf-8?B?QlRueGxsbks0cUxNYjduODlEclFWcThrVzVYUGkxdWQxaFFTdnA3RWdSbGFx?=
 =?utf-8?B?OVVaalVsdmoyT1hFSHhpTFZDa3V5YVVzc3h2UnQyU2ZkUmpDYk5PSzdFdnZB?=
 =?utf-8?B?NHFnNExqV0ZwUExyMmZRMlUwN2hOSUhQc2wwbThONW9yZFQrM1BXNnoxQVRu?=
 =?utf-8?B?c0d2dGtEZUlmRnR2TTdGZzJyRENPN1NlSTNEVjZuSG1uWXlDYWdpcWNFcFF0?=
 =?utf-8?B?czdDTFBTLy9Kenp0NFJLZUtvaCtzcWd1c0ZZVGhZdlU3OHhTN2NVdTNrcHZE?=
 =?utf-8?B?cE5KL0NUbnN1OTA2M29NMU1vcFFOOTVFZlJXN254WElrNGg5elZ2UlJWSFpK?=
 =?utf-8?B?Q0VXSy9PdU9QZDdiVnc5TkgrbGdiU1ZJZlBETEM2WjgwNzZqVFdlSGJyckhz?=
 =?utf-8?B?N01kWnJYZFhCQkdFREQrVFdLTzA5SXE3UkZHQ2w1ZE93Y051OFk5aUlhWE52?=
 =?utf-8?B?cS9teEc4cnB5ZlJyMzJLWGVQa0QzREttb3A4LzRCM09wREdEYXVVdGpmUXRs?=
 =?utf-8?B?ZCt5ZVMvdjJnWEFMamozV3l5dkc3NVl0VGhhYlgzeTVlbVYvTDl2TjBRUzRG?=
 =?utf-8?B?ZVFhZ3dEWlR6ZDR2eE84Nnk5N2VFcWlTN05OSzJGbGY1MVlsbVdYK1gxSjBv?=
 =?utf-8?B?WERaUlNGTHZKVXdkNG5BSkhkN0ZzRmpSQm1vLzU2UTNJWC8xUDN1alNQeG0r?=
 =?utf-8?B?NDhUc2E2TnlnSTZhenpsTS84NVE4TlkybnpzYVFBdXdPK1pqbFQyN1o4MFlN?=
 =?utf-8?B?WWhFOEtmS1hTaE5oMnE3Y0xZamUvYXpBU2VGODlnb1FIalRFSmNaVmNBSmxm?=
 =?utf-8?B?VEZNQU5GN1A2ZFJEZ2x0NVoyTTRjUkl4emFjMXhrdmd6STh5U25QZVB4Ymt2?=
 =?utf-8?B?Smg1QU1KekhVck1sQjExQ1VFV01qOHlZNmMzQ011eUxSZXFuOXhHdDNOVmpp?=
 =?utf-8?B?QzFWTVNVZ1hCaU1UWmRXYnFNTmJ0Z0ZZajlVdzhLOEZtL0tXVFBQY2dJdDNi?=
 =?utf-8?B?QXNicWM0TEk4bXJxRWZUZ1dCMmpGUWFHVUVSRkt3bmdwd0IxU2RiMXYzSGJr?=
 =?utf-8?B?MGhYV29ZK1ZhVlJXS3Zjb0lqZnBGZzBVOWE0bnJXc0lLeE82OGtzOTNma3dX?=
 =?utf-8?B?WmZQR2Y1V1RCS0FTOHVSaUdEb0ZjaE1iVm5vWmFiM2JCZ1FVaUlZQmVKU0tq?=
 =?utf-8?B?N3A3dkt6enhqbkJWb05HeVlhTENQbjJPSjRya29jQ0dOd1pvYWFoZGNaNHJI?=
 =?utf-8?B?TmhRY2Q4cWhFSkRxMHFVM1ZLT2RVT1dZN3JBRVQ0MFZobkRCWXBuRFlEZGpB?=
 =?utf-8?B?TUtYT0pyVi92alIzb1NkbFh5Z0hXM1ZGNmdwRkNQQmg1UGJ4N2NYNjh0SUlD?=
 =?utf-8?B?RkRlWDBoVktsa3BpMC9qNmNOTHRib2RLUlR0U2NzZHZ3QlpkQWtVU1lTNHg4?=
 =?utf-8?B?dFl4ZHVrSEk2U01samdZWHMyeEZQS3RQcjY0bU05RllWa3IzajQyV0h5ZnJr?=
 =?utf-8?B?TW5iMS9qQXI3U3pQOUNZRWt0S3dWeWdsbHNGN0oyeDBwVkkzWmFiaUhKRGNW?=
 =?utf-8?Q?0SkLou6m9NdtNtdHKi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YgPhIGM0DQLRIyETHcGpJ/9vdAxb9Wgf6W0BIZtrR7pLECayHgmpN0yS68FmE3f/j3aTMyktt3NcWoSRCjejh63YXPeIuIfyPnWt68fkJB6/Dxe5cCTRc3uiuf/LAhg70vQTj/fxMJNG1rtHqSG2ZfAGyFXgnl3Lj9MeVzPxY5t94wX3ku9orOxPdYOTXzGVq+5N+RNzS3wQ4DZWMgmZzHDhpPri8rt/Ncf7I7qedWQ0LO900rSRsCDk5S5dGML4ShBezmwGyiRkZJS5CUwVAMvm/c5o49IMGpKklKeKQgxT7B6Jiwb19psF6ON32dTPYgZRl1wFWhVpMvBcdMEorA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3d5bee-c34f-448a-cf45-08de8fae2042
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 05:18:36.1397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1pvNpLexzfg4Ombzssa0Twb4WR6mtlKKetzUnFOZodkpeIgjcPBe1697hDPIrE/bqEunil6T+HYQpi3fsgIOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9505
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1DBF7374D7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMzAgSmFudWFyeSAyMDI2IDAzOjIyDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4g
PGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsg
S2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFs
ZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRl
bC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dF0gaTQwZTogb25seSB0aW1lc3RhbXAgUFRQIGV2
ZW50IHBhY2tldHMNCj4NCj4gVGhlIGk0MGVfcHRwX3NldF90aW1lc3RhbXBfbW9kZSgpIGZ1bmN0
aW9uIGlzIHJlc3BvbnNpYmxlIGZvciBjb25maWd1cmluZyBoYXJkd2FyZSB0aW1lc3RhbXBpbmcu
IFdoZW4gcHJvZ3JhbW1pbmcgcmVjZWl2ZSB0aW1lc3RhbXBpbmcsIHRoZSBsb2dpYyBtdXN0IGRl
dGVybWluZSBob3cgdG8gY29uZmlndXJlIHRoZSBQUlRUU1lOX0NUTDEgcmVnaXN0ZXIgZm9yIHJl
Y2VpdmUgdGltZXN0YW1waW5nLg0KPg0KPiBUaGUgaTQwZSBoYXJkd2FyZSBkb2VzIG5vdCBzdXBw
b3J0IHRpbWVzdGFtcGluZyBhbGwgZnJhbWVzLiBJbnN0ZWFkLCB0aW1lc3RhbXBzIGFyZSBjYXB0
dXJlZCBpbnRvIG9uZSBvZiB0aGUgZm91ciBQUlRUU1lOX1JYVElNRSByZWdpc3RlcnMuDQo+DQo+
IEN1cnJlbnRseSwgdGhlIGRyaXZlciBjb25maWd1cmVzIGhhcmR3YXJlIHRvIHRpbWVzdGFtcCBh
bGwgVjIgcGFja2V0cyBvbiBwb3J0cyAzMTkgYW5kIDMyMCwgaW5jbHVkaW5nIGFsbCBtZXNzYWdl
IHR5cGVzLiBUaGlzIHRpbWVzdGFtcHMgc2lnbmlmaWNhbnRseSBtb3JlIHBhY2tldHMgdGhhbiBp
cyBhY3R1YWxseSByZXF1ZXN0ZWQgYnkgdGhlIEhXVFNUQU1QX0ZJTFRFUl9QVFBfVjJfRVZFTlQg
ZmlsdGVyIHR5cGUuDQo+DQo+IFRoZSBkb2N1bWVudGF0aW9uIGZvciBIV1RTVEFNUF9GSUxURVJf
UFRQX1YyX0VWRU5UIGluZGljYXRlcyB0aGF0IGl0IHNob3VsZCB0aW1lc3RhbXAgUFRQIHYyIG1l
c3NhZ2VzIG9uIGFueSBsYXllciwgaW5jbHVkaW5nIGFueSBraW5kIG9mIGV2ZW50IHBhY2tldHMu
DQo+DQo+IFRpbWVzdGFtcGluZyBvdGhlciBwYWNrZXRzIGlzIGFjY2VwdGFibGUsIGJ1dCBub3Qg
cmVxdWlyZWQgYnkgdGhlIGZpbHRlci4NCj4gRG9pbmcgc28gd2FzdGVzIHZhbHVhYmxlIHNsb3Rz
IGluIHRoZSBSeCB0aW1lc3RhbXAgcmVnaXN0ZXJzLiBGb3IgbW9zdCBhcHBsaWNhdGlvbnMgdGhp
cyBkb2Vzbid0IGNhdXNlIGEgcHJvYmxlbS4gSG93ZXZlciwgZm9yIGV4dHJlbWVseSBoaWdoIHJh
dGVzIG9mIG1lc3NhZ2VzLCBpdCBiZWNvbWVzIHBvc3NpYmxlIHRoYXQgb25lIG9mIHRoZSBjcml0
aWNhbCBldmVudCBwYWNrZXRzIGlzIG5vdCB0aW1lc3RhbXBlZC4NCj4gDQo+IFRoZSBQVFAgcHJv
dG9jb2wgb25seSByZXF1aXJlcyB0aW1lc3RhbXBzIGZvciBldmVudCBtZXNzYWdlcyBvbiBwb3J0
IDMxOSwgYnV0IGhhcmR3YXJlIGlzIHRpbWVzdGFtcGluZyBvbiBib3RoIDMxOSBhbmQgMzIwLCBh
bmQgdGltZXN0YW1waW5nIG1lc3NhZ2UgdHlwZXMgd2hpY2ggZG8gbm90IG5lZWQgYSB0aW1lc3Rh
bXAgdmFsdWUuDQo+DQo+IFRoZSBpNDBlIGhhcmR3YXJlIGFjdHVhbGx5IGhhcyBhIG1vcmUgc3Ry
aWN0IGZpbHRlcmluZyBvcHRpb24uIEZpcnN0LCBvbmx5IHRpbWVzdGFtcCBsYXllciA0IG1lc3Nh
Z2VzIG9uIHBvcnQgMzE5IGluc3RlYWQgb2YgYm90aCAzMTkgYW5kIDMyMC4gU2Vjb25kLCBub3Rl
IHRoYXQgaGFyZHdhcmUgaGFzIGEgc3BlY2lmaWMgbW9kZSB0byB0aW1lc3RhbXAgb25seSBldmVu
dCBwYWNrZXRzICh0aG9zZSB3aXRoIG1lc3NhZ2UgdHlwZSA8IDgpLg0KPg0KPiBVcGRhdGUgdGhl
IGNvbmZpZ3VyYXRpb24gdG8gdXNlIHRoaXMgbW9kZSwgc28gdGhhdCB0aW1lc3RhbXBzIGFyZSBj
YXB0dXJlZCBmb3Igb25seSBldmVudCBtZXNzYWdlcy4gVGhpcyByZXBsYWNlcyB0aGUgdXNlIG9m
IHRoZSAnd2lsZGNhcmQnIG9wdGlvbiBvZiB0aGUgVjJNRVNTVFlQRSBmaWVsZCB3aGljaCBjYXVz
ZWQgdGltZXN0YW1waW5nIG9mIGFsbCBtZXNzYWdlIHR5cGVzIHJlZ2FyZGxlc3Mgb2Ygd2hldGhl
ciBpdCB3YXMgYW4gZXZlbnQgbWVzc2FnZS4NCj4NCj4gVGhpcyBhdm9pZHMgd2FzdGluZyB0aGUg
dmFsdWFibGUgUnggdGltZXN0YW1wIHJlZ2lzdGVyIHNsb3RzIG9uIG5vbi1ldmVudCBmcmFtZXMs
IGFuZCBtYXkgcmVkdWNlIGZhdWx0cyB3aGVuIG9wZXJhdGluZyB1bmRlciBoaWdoIGV2ZW50IHJh
dGVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGlu
dGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5s
b2t0aW9ub3ZAaW50ZWwuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aTQwZS9pNDBlX3JlZ2lzdGVyLmggfCAxMCArKysrKysrKysrDQo+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2k0MGUvaTQwZV9wdHAuYyAgICAgIHwgIDkgKysrLS0tLS0tDQo+IDIgZmlsZXMg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4NCg0KVGVzdGVkLWJ5
OiBSaW5pdGhhIFMgPHN4LnJpbml0aGFAaW50ZWwuY29tPiAoQSBDb250aW5nZW50IHdvcmtlciBh
dCBJbnRlbCkNCg==

