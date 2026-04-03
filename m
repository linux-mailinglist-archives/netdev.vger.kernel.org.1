Return-Path: <netdev+bounces-275029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDqICgu4z2nfzwYAu9opvQ
	(envelope-from <netdev+bounces-275029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F5C3943AE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49BF13096F2C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715D3A9637;
	Fri,  3 Apr 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNv109Q1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1193A960A
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220296; cv=fail; b=bCNDmyZJtoHRsXdJUixydeig7adFDTizxgKMzL+ZMuB1FCcdO4Bbi7MqZzP7GWXYgmjySv69UTHLqgzoVpMHIf4mncKN1Y0V/m2xMq9rKILnqDbKDRWhazy593pSAO2pH1Hyl7W5+xFJ0+dehKIgz/jc42w5ZHaEtPSSG4F8X2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220296; c=relaxed/simple;
	bh=jklD8qAaV3QvtqeYuiN8xuLsmIpy49Lrh4DOHE7TIUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aoFsmvQCHpODtrfuAlcAyh/5D+MwSsmt7ZKkLKwKtOc4N2XRCe2ImdCx2cB61GHiTWPsZ7WPFpdfi2hu/1G76f/xxttaIYwwmZPbE7HF6TFyu0AuwtSOrezdqu5FePZWpoKhwhw4kCsTwevSzkGPExQj1OvN/B+Fd9QUefGhS7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNv109Q1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775220292; x=1806756292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jklD8qAaV3QvtqeYuiN8xuLsmIpy49Lrh4DOHE7TIUg=;
  b=WNv109Q1kjGkrEjmqYqW6qEhsIBTb3QmzMYXju6Jp5Rmd97cG2nSs8Pr
   +4cUhQ7J0QZ1HlVHlyDEehxvnB1kW4SgPIAerheZp9BOFjkopt1YEddnT
   canEYsIM77flsYDyJO11xgTFijmCtRArA7Orq+HM8TAvLRdDUPphADhbd
   rxjBKkFd3AZYHHoZirLze9wTJZ/fZpZ3hZiV6c+Of1dRu/dBSFL3raWtA
   ZUD7rXe2e5ys1oVKKz6xf+2UqToWpksOuZgDt+Xk+nFDDKzQocVxjLYP3
   drsByjKglwQ9f4gWBsUcPPu8NM7jr4H0mRk2GfxkQ6NLrX37sqJuWb7YL
   g==;
X-CSE-ConnectionGUID: yXRKa2rTQt+jbnPX9ccshQ==
X-CSE-MsgGUID: LQdGalOsTHuU2h1S9wJIzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86582376"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="86582376"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 05:44:52 -0700
X-CSE-ConnectionGUID: 5EZzCBwAQXOCDIyVTW4SeA==
X-CSE-MsgGUID: kJl9d6s9R9GzytvLvS5Vmg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 05:44:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 05:44:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 05:44:51 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 05:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUEl8hkidfpo34DMexlrTi9HdgD6VQtOddv0NqiZha1qY1VtDd6A1/qiTg03NkJKSpIfcDUto8rEpyKn42PAIVIN3DZaoEGbuB3cjR2GQVRk7rlkrXZ/6rlwjzkmMDgEexLkreSCpjfJWqrqzzehsRmYyb78AuL0wXQxwmdHAkKl4wmJDVay+A0yoHM3s4ST6rPBPI73IRK6R/fYa288oUyOQ9VezA5tsZWUDjyQputpEpRrvSvsRWBgAasExpGpSho0XhkfdTHvAxK3XtnyidLWroWCJzB2YezVaP/Uz3nbvlPiMc7DcsO6r8yQ3uLbupCJTz2FCzw4+Cn44VLiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jklD8qAaV3QvtqeYuiN8xuLsmIpy49Lrh4DOHE7TIUg=;
 b=MQgewVyNfosMSqB9xStf3mobaQSOf7aivcxf6AAP9glNy+SjlcAOMl3t8e5DxpsYCzafPrJh/kXAhcidKVJfdK7Hu7gvpytRUgWOyodNyQkdKJZ/OMLgK0CUC9W/Fqar5DoF99QgVrCtG+2dIa/9dK7HpARxjZJmtVKhVIul03CHGwvEi/snR9p4nvmPD/sveRwcDQynATUPRDAQPXfCXpiK1S72kMvZqJ9HUEWvI9p00PpDtZ3J1Xfk7WTt/2bxkHrJYtHpwPUJ4m7W6Wy+L4sV65PEpBdfrFTcpGVGiyn5Ld+ZikIf9xqoiz/RNi0wQhnEGnXI/8qiaP9FqBDp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS3PR11MB9794.namprd11.prod.outlook.com
 (2603:10b6:8:363::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 12:44:48 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 12:44:48 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, "He, Guocai (CN)"
	<Guocai.He.CN@windriver.com>
CC: Thorsten Leemhuis <regressions@leemhuis.info>, "Berg, Johannes"
	<johannes.berg@intel.com>, Friend <netdev@vger.kernel.org>, "Linux kernel
 regressions list" <regressions@lists.linux.dev>
Subject: RE: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Topic: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Index: AQHcwOon+EXpRGfVfkKIJTxR0EbLd7XJePpigAICbwCAAaZzGYAAFfSAgAAVTuA=
Date: Fri, 3 Apr 2026 12:44:48 +0000
Message-ID: <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
In-Reply-To: <2026040331-evasion-walk-f572@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS3PR11MB9794:EE_
x-ms-office365-filtering-correlation-id: 0b6d4008-3dc0-4620-6a57-08de917eca83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: DwbLIzBWstYFeoMWwzY+VWcOFkFoCyx7hhHeles6tFmWMlW0Bacl8eue18Xh2U07R9UsxopD2pKhQ21q5vLR7UD1YS3jLMGcbWVt3L7wHB0mR6iFa/AqeOU+vy4eR9BSn/zOyJJTfXdxrwhtekbgAhFWofFU8aiV+OGEGypSx6M4MsHdLnAckFAbUWqDNGUprOSdu9jKpCK7Z/bv/evYJQ6eIbBv6xsZdO3i9kNBTPjWSv8hXc5RHEXaWoVcWatuiUfFcv05Qsh40VsB228hQ9B26fsXWBbbRYF2saDpHXS+b9S7B6ZEmhcy1sdzhKAVTJk+Jk8kTT2z7NcZHjQu2fq3/q39p4mw+nXOI+HEQ8KhmAOyFw4Y9fVXXul3oEXMsuFygHf6NDG2Zkd1RnLT0Tvp3e2PykFEzCxuD8f3Uw6SkmuKgh6cuSLQtIq9UjBYuBdyfcwJoohvoVtLj1kjKlTBiHkT7A49jdbqF0OmlCPaVmNGWk6jaI3rhHss53U97/cxc6moIus6FvY8EsJSvexmvjzgrjRLDEI7wlwQU6QXg2yBSU6fQaX2Sh5vKiFAJP/eU0rWOySwCMhEUKeBDans5sGexeAgAEzZYvFLSdOSFueRB3oZBFGrBVEfN2yC/duyuKhoVz0hTdK86f9daQuZ8810l19eqpSzhgiPe+B97NQvfWJQ4igLziGQ+12K/j+H5ArC3kTfaWkkY1Jg8ot6XYiOhfGMhZHc/i+I5JVmG5emRqC9/6GT48AsGjP4q1tnm3SOU5GzvHcg/ipxquHOWECmM9YFXeqf6et3K3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1hakc2OUN3SVhQelZzeXlyZXFIZmEzYXNJampJc1FlYndGRzlzSThoR3BV?=
 =?utf-8?B?ZWFiWWRnU21BaUNYNE12QUV0akUxd2JoUm9OVUE3cUNBWFViWUtnT1pVQlhT?=
 =?utf-8?B?bDlMclA5dnB6RzhvWmFBdzIwYVplbHJhekVnOW1WaCtDRG5iUUVLVTRhQXR6?=
 =?utf-8?B?QXB6Vm81TkJ1bHpsci9CeWZPQWNWSDUwT3F2Wm1US0E2VWZTTmRpZHBUUlBy?=
 =?utf-8?B?aGl0NVFOdnZkb1ZUOUlvZjBLOGhuZ1dnN2xRdWpIMkhNcENHMmY3MUJYajVN?=
 =?utf-8?B?VFZoNzNROFpmTmREQ09Bdkt2bThLeERoekpkVHZBb1MrVlhPWGJZTWZzd3lU?=
 =?utf-8?B?M1JwYVNzN3Z3Q0pRaHBqb1hYd3lxQTRyNm5Panl6RTM5TklBQmN3UEF3MVJE?=
 =?utf-8?B?dHZ6OHhNZXlRTHMvOTk3RGRDdnl4THgyaHBBM1Y1bkxjcmthajZjYVZGbjlF?=
 =?utf-8?B?V0V3MERUbnJsUGduRWhZOXovbm1heWhmUjhNRkJKU3cxb2tTZitaUW1Ob1V3?=
 =?utf-8?B?Tzl1aFpLWG55TmFYSU1yWWVaNE1hdzk2M2tSeWpMeWI3OG1EaVFQTitNQS94?=
 =?utf-8?B?REtQQVN6N1hPdGNLZ1BpZHhiWDhxZVdIKzdPNHd5bFV3bzhVdExVajJmdkQ3?=
 =?utf-8?B?eHdaZnd1bUpzMU9oc0NadGp0a2QyamtOaURnQmQ2cFR5T3dLT2dSWkF6Z1hH?=
 =?utf-8?B?bXpvczNGSUJTRkJxWmRDd0tDUVlxTzlkVjVWb2hHdytJN1Nqa2VZYUlkeWV6?=
 =?utf-8?B?TUpvZFc4YVkwM3lldmxyZDNUTVJrUGFGdW52QXFJNHl5dzBJeUdsSTFQbDEw?=
 =?utf-8?B?cDFwOHgrelIxWjBEVVhsem1VaDVhOGxEK1d6NWMvTG93eVBMK3lvb29SenpF?=
 =?utf-8?B?N2VpUXZram1hbThpaDVESVNzK1BhNlBuSTBrVllRblJ5NWUxeUowQU1CSjNW?=
 =?utf-8?B?TDR6US8zaHVCY2pvaWhpbU15Z1BQVG5IUldtOWhodDFVdlg0U2lJTXlVZHpR?=
 =?utf-8?B?MnNXSm45VW1peGtCYmkrWlNySGlZeUNiWGJNQ1Z5RmVaUHdPdzdvMWs0em14?=
 =?utf-8?B?OGR4dFZibWRqa2RRUVZhUy8zbnFVV3hvMGZFbXU1UTR6WGR1MEx0N2s2eURE?=
 =?utf-8?B?YUN3aVJiZHQ3bEU3N2dVbHFISjYvUFpVWEs3dGJJZGg5S2VFNGc4RGtELzdr?=
 =?utf-8?B?Y2xQN0xIdlRFdTMvOW5DTmdGbmZZcE1yRTVRaklIZHBmaDBhdzQ2a3pNMnNa?=
 =?utf-8?B?WmsxYm94aWdkdGhzUytsS0YyeGdYNlM3c3dUY3VxOU5mSDdGOEdmUVNCUVRF?=
 =?utf-8?B?dW5JSVZoVkx6aUNLR0ZxeS90bC8ycFU5eW1mcDMxUTlaR0E3MXBmTWJWcENO?=
 =?utf-8?B?RmdtV0pYZXhzZjBCMVJLcHdHV29YWEtYbllHTFozQ2dmN0l5L1pYSnJ6cENs?=
 =?utf-8?B?bEVRRHlBVXFtT1dwZitlekxQSm1nQi9JTkZ1bXJkaTBjYkxnUXR4akpTLzBx?=
 =?utf-8?B?WkUvUlI0dXlTbWZnYzFnOTNBN0ROM2FKVEFKSnBCNDEzZ1FWSTBoNnc4V1pa?=
 =?utf-8?B?VFl5bGZMWmxmRUw1S0RndUhSSEgyN3RiM2FQL05xUmFYSGQ3VE1GNTREZzE3?=
 =?utf-8?B?b0hIZVlTc0ZFWHRXRHdPSVNDdlQ4eVdtWjRsTGhyL0hKUlVUNFJQc1d3MFVt?=
 =?utf-8?B?MW8xN21iMzBRRkVkRXNnS042SXB3U2JHWFVpUHJVYlBSbFp2ZVdiU0poZVVU?=
 =?utf-8?B?MDA3M3h2L1p2VXg1U1hwalJlOFVES1dzQXgwc3VlMmJaZVZaZkFQTGNGdUda?=
 =?utf-8?B?ZDZMRUhIMDZUVDJCbEViK2krbzNNUWtzdzFIREtnMlI2QnNHTGx2anRWR2k3?=
 =?utf-8?B?bTdTNHpia3YvbCtMTmZ0MGVIWVNKVEJjM3E5dG91ZUw5V0lGQ3Z6TVYzeG55?=
 =?utf-8?B?OWdKUXFOSitUV042bE9NcmZESjZoMlRpVHBaOFZ4dTRaRlZGN3dEV0krMFhh?=
 =?utf-8?B?ZEZscmxMNW02RDdOUGtwcHBkOXY1cVZGcldmM2pQQzlsV2d3UEdJT29KRU5C?=
 =?utf-8?B?dEFCWGJkaDNIQ0xUNHUwSVNURTRSSU01L09xQWRUcUp2cnFGUGFQUmFBMldm?=
 =?utf-8?B?cGFsLys4ODg3emtnMjZYSU1mOFdTV3F1a1lmUHpJNkQ1bWxxQmNpa2h3aHUy?=
 =?utf-8?B?VXpIcS93V3piVzZNK3Z4Si9qK01zRWFxeHphcGU4ck5QYk1BbjJINThOdFR6?=
 =?utf-8?B?S282R3M2RXliU29QOEVMeGR3TlJxKzgwMC9MT2VmUHpvS0xPUmowZTRyUUZP?=
 =?utf-8?B?Nm1xK1UycFM0WDJjZnFUQnF1Qi9QRG0zYzZFOThzSFNTdjFOVnZqNk5TVmZK?=
 =?utf-8?Q?XqH2+3D7FvuNzC+U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KdzCYFkoqjv9EXR8Y8SrBSNOHmD2bMSYG2ii/E+P3lAUybOvgLEDRn89OYi4drWpgzFcgTyRmfyvyhfBNWPWXDbhlmCSO4aQSIYihvU3WbOAsnu5giqySdH2nbQnDLxavcywdG7HMZFPVb8npl+8yDUpvzodDeWM1M0mF6SOESqfTkB0JPTYwAKD7HtPaPaGxYt8p2TuN2jw+sKTRHFWA3llr1CKTVMN9JDUduzl2VSBQbF5cGHwD8VvgBOTscmbVU9WlnANJWv4grhp/BF65k/bwZQuewE+/4ZWK4z7963qqba1PwnmfPWm1MP0g6LhfB3jW8/AINTVpP5pPn9O0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d4008-3dc0-4620-6a57-08de917eca83
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 12:44:48.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szPZOK5pZ4mIXFewmKh7fPW9Zvgf+kglLfFmoj1l2hcXRomP92759Ah3nCW8LuZBtsdZuZl49nL4E9HQ1Mtt5xJIHIuW7rNQ4jFcpflNpf1PmLqNYvqM/0WWREfprIgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9794
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-275029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,windriver.com:email,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 68F5C3943AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMywgMjAyNiAyOjI3
IFBNDQo+IFRvOiBIZSwgR3VvY2FpIChDTikgPEd1b2NhaS5IZS5DTkB3aW5kcml2ZXIuY29tPg0K
PiBDYzogVGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+OyBLb3Jl
bmJsaXQsIE1pcmlhbSBSYWNoZWwNCj4gPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNv
bT47IEJlcmcsIEpvaGFubmVzDQo+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IEZyaWVuZCA8
bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IExpbnV4IGtlcm5lbA0KPiByZWdyZXNzaW9ucyBsaXN0
IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+DQo+IFN1YmplY3Q6IFJlOiBjb21taXQgMGM0
ZjFjMDJkMjdhODgwYiBjYXVzZSBhIGRlYWRsb2NrIGlzc3VlDQo+IA0KPiBPbiBGcmksIEFwciAw
MywgMjAyNiBhdCAxMTowODo0NkFNICswMDAwLCBIZSwgR3VvY2FpIChDTikgd3JvdGU6DQo+ID4g
Tm8sIFRoZSBtYWlubGluZSBoYXZlIG5vIHRoaXMgaXNzdWUuDQo+ID4gVGhlIGNoYW5nZXMgb2Yg
MGM0ZjFjMDJkMjdhODgwYiBpcyBub3QgaW4gbWFpbmxpbmUuDQo+IA0KPiBUaGF0IGRvZXMgbm90
IG1ha2Ugc2Vuc2UsIHRoYXQgY29tbWl0IGlzIHJlYWxseSBjb21taXQgZTE2OTZjOGJkMDA1DQo+
ICgid2lmaTogY2ZnODAyMTE6IHN0b3AgTkFOIGFuZCBQMlAgaW4gY2ZnODAyMTFfbGVhdmUiKSB3
aGljaCBpcyBpbiBhbGwgb2YgdGhlDQo+IGZvbGxvd2luZyByZWxlYXNlczoNCj4gCTUuMTAuMjUy
IDUuMTUuMjAyIDYuMS4xNjUgNi42LjEyOCA2LjEyLjc1IDYuMTguMTQgNi4xOS40IDcuMC1yYzEN
Cj4gDQo+IGNvbmZ1c2VkLA0KDQpUaGUgY2hhbmdlIGlzIGluZGVlZCBpbiBtYWlubGluZSwgYnV0
IHRoZSBsb2NraW5nIHNpdHVhdGlvbiBpbiBtYWlubGluZSBpcyB0b3RhbGx5IGRpZmZlcmVudA0K
KHRoYXQgbXV0ZXggZG9lcyBub3QgZXZlbiBleGlzdCB0aGVyZSkNClRoZXJlZm9yZSwgdGhlIGlz
c3VlIGlzIG5vdCBzdXBwb3NlZCB0byBoYXBwZW4gaW4gbWFpbmxpbmUuDQo+IA0KPiBncmVnIGst
aA0K

