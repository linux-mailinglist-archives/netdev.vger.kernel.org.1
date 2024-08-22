Return-Path: <netdev+bounces-120996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1584795B5E4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0557283F0A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698411C9DDA;
	Thu, 22 Aug 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRgNbqD+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3381C9456;
	Thu, 22 Aug 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331922; cv=fail; b=fYYFYSa3AaYFc+Z90ZITIW1N4Q8Gfn+sl/OO4pKFiqxRC+0vQk1kAldnFsMpsGlUSCDqmOKjemZpQGtxCg3gb+HXfgqwAUB/5075I6p30DBS/WMoDCxG5ssswoArpChAu6UbBdDKEqQ6767/+ZqqvtoLsayBdgqOSSDIj6a4Agk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331922; c=relaxed/simple;
	bh=FRS3PzCaabi0xgGiNNPKXn+KNkPXiOV3mh/A3tQ9yOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BW1ClqPUxZJSTw5lhuJYDSDryqkTXBfAqf2ISnBLPcUa4J/Xd2DSlGkoKI04NmvTuOdzFGmo8/rvOFxoNPozAu7P7vRS+nmdbUM4zrvG4n0x+U+e1T+yI0V+RGhXQPvL3Zc4l3ELavv4w30fD1CWWQsKl+0yMUY2hwe18aNv67Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRgNbqD+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331920; x=1755867920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FRS3PzCaabi0xgGiNNPKXn+KNkPXiOV3mh/A3tQ9yOg=;
  b=IRgNbqD+fitVgd6eGOvEDalXTmu8+0P3AXaima8HdJW4FbRtBaTojbh8
   w0No65WlpSQybYxNMCy0DiuxZkL4uj9vh7S23Y3FcpFiZ3I/6g1+9J/Sr
   Kl8iXtaB8/xBszFWNJowmCk8LCAKBKOwe6H0BDekdvauIp1R5jVW85lgl
   uFJL/Vv2ksmH3uhMzbuDhIbAHQsUyzFipHckazedQLCydmdZeU+wXIZIS
   C24QiWFK+b3CC2s0OhsrNQUgt0aewk0IBSwEvrXOr6gTN9dpiStIH4kkj
   RzE/G2vlwiP1Va86DQDGhUcW/GrWMsqe/GiystqJbPg2463y0ptlCfqyK
   A==;
X-CSE-ConnectionGUID: zPyPIRKOTvCGe9cgys8nhQ==
X-CSE-MsgGUID: f12e5OUXTba2Yxpc5ylEFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22914159"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22914159"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:05:20 -0700
X-CSE-ConnectionGUID: PScwAj09R6WVWKZtN7xltA==
X-CSE-MsgGUID: 04/mYd+ARhy+VwaQioejeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61462022"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 06:05:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:05:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:05:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 06:05:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 06:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydBMyOO5F1IQSh1sELOWCxIzK8q3GDVaWI28KAGTlS4eHkJs8dJIG1C5wGezIex7WiSg8kBl0M80w8fcXamVSJibAVjL+XgSMgBgU/lZncNbyBoFEqWCMo1m2QcYlo2V11pNNso3arFjPDDsw1uftMDiPVPPFCXkBANEmr4dvjr+eT6F/NubYuLmHcZ33LhQkXQdvZqXN3ZUeNpm/1Tw5s2UpLfIw69UZTM6L/WTM/GxBwp0rPylLq9dHLY2ztnUVSYn1BsF26CIlvbBPYCeUsyrzdyb/wSCyQgF0au46EyarTeAp1qQqw7+dDMjgpzu2QOiUPGvfRq701etcvCn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRS3PzCaabi0xgGiNNPKXn+KNkPXiOV3mh/A3tQ9yOg=;
 b=pIrAa+cC5UF15gHqfRZTsdZtu7wPcfn5nwe2x03hyQOUVp28F1EFUPuUPT/dO9OvuBGJDrJOsya16z/wqRvma4Nt3vpVn94FXVDalGjRE0JD6gJt461bzPMO5QBMtruygkmVhKC/lPP8kvr3lfBByYeGdAYTpAyWsZECQFEmL0Ne9icpK048JAZdvn04CxD6dpu9myX/QsNzN222VaWIY+zSu3/GWyEFLQeewPmV3aQqzI17hQDLyoVPa+n2JR6luIwWT2aZF68oyxVo0ZDyS6LawymwZ/whju+ClUlF7qfCx8zzTm15O97abH4ZKysZqHbm/jDpEuRJjCPu41y1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 13:05:12 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:05:12 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Daiwei Li <daiweili@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "kurt@linutronix.de" <kurt@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] igb: Fix not clearing
 TimeSync interrupts for 82580
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] igb: Fix not clearing
 TimeSync interrupts for 82580
Thread-Index: AQHa7gY9GsnqsJ2CWEmpT/is1FAh1bIzS2ew
Date: Thu, 22 Aug 2024 13:05:12 +0000
Message-ID: <CYYPR11MB842936EC47BD7C75EC331F48BD8F2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240814045553.947331-1-daiweili@google.com>
In-Reply-To: <20240814045553.947331-1-daiweili@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB8502:EE_
x-ms-office365-filtering-correlation-id: ff19429a-110d-4b1f-6d64-08dcc2ab0ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TFVwVFNuTGRmUEJmN1g0SW8rQlNWWHRNL3lPdklYTUhWNkFEdjU3VDU0bTlP?=
 =?utf-8?B?eFJ6cWhaMWtCcUZQWUVDeHN6ekR2UFlyUDRsMXQ0eDg4UmROaEFMckFsY2VN?=
 =?utf-8?B?RTdMSlI0dXBvb2RRZkdpRDQxNzlHbU50eGlTZGJxUFRlVWJ1azNuOFR6STJk?=
 =?utf-8?B?RElQb0lQWGowaWsyRFhrSUlYTm5Jcm5ub1ZvcUxpamZlZVJzV1JNRjNwMFNI?=
 =?utf-8?B?OE1nck90VktjSS9iSWEvU0pLa3l0REhDWnludFc5QXpBTmo3WTdFZlpWaEVk?=
 =?utf-8?B?SEdYZXFIV2szRjU4NzkvSEtMaDhZUmhJdDNtVFdVUjY5bHc3Y2R4ay9BWkhM?=
 =?utf-8?B?dHRoekNvdUxCejloTXNMYlF5VkZrdHMzb0ZlTndFdjg0dVRSZk9BNGZTR1pR?=
 =?utf-8?B?cU9WODAyb3gzblRiS3ZsSXA0VEw5aUsrUDd3TGU0RU5VT0ZBdFVMd3ZGWlYy?=
 =?utf-8?B?NE5aeDUzK0M5czh5cDRWRUVCSURTSmh0cVBLTWtHdFliWjFpeDJBTFhicHJG?=
 =?utf-8?B?QTRBVERlZEMrMEsvZEJ2TmF0MU5XdElXOGtoY0RVQlBNRzY4c2UxVzBEL3pE?=
 =?utf-8?B?WE1mV3UzMm02aU8vbXZsMzN2M0U4YVNzcFh4ZVNZcmZlYUNDeU5pamxtMjN5?=
 =?utf-8?B?YW0vMzdpT2k2Z1BPTUNabS8xTlpKZDVJRGRlL2x4MnB6VUxpcE9pVVU4THhl?=
 =?utf-8?B?aDdCbHBQSExkQmpzZlJtSndGUTg4RWQrRjM3dHE0aHdCdklkTXVsMWtURSsr?=
 =?utf-8?B?RWpGTXJGNVFRUkRlNjBaY2l3bHV5bGl3cUp2VWk1WnA5bStYR1I0cjJ0M3kr?=
 =?utf-8?B?Mi9UZUtNRHd1TUNtdzEyOENVYVBpS0NOdjRoamxqbk9ZVjdvS2t2QjY1Q1ZI?=
 =?utf-8?B?MzY3Y0xUMDBDTU9RdDJ4V21NMWRlT291Y29EOTR3MUQ5OXpFRmJuMndCTWpB?=
 =?utf-8?B?OUN4TU5ORVlscEdteHY5T2xWaFY5bmpKNUVoQzJCY0hWZG9Ka2hkdUt3MnBD?=
 =?utf-8?B?QktIbXpKQ0ZUUTFPY0hrQ2RWVVN0QzFhRjBmQll2c2QrbWdZRzN5SGViZmxX?=
 =?utf-8?B?Ui82RjNDaklEYzZCTWp0V0o3TjBld1BrSkdzblJ4SkRKdFZZbWx1N2F5N1d2?=
 =?utf-8?B?ajhyNllYeHB3OXRndGk0bEhwMjd0M1ZjYWI4NHVVRUNET0ViZE45YWRpM3dv?=
 =?utf-8?B?TGpva2RTaytpSWh6aFpuQWNRMDBRd2YzeDdtSEF2ejRaVmZGTW0xMko2RTly?=
 =?utf-8?B?d1I4azF1VFRBNUpzRUVaOEJqY1ZwZWo3M3ZzRDBjTkxmTEx1eEMweWdUbmZC?=
 =?utf-8?B?bkdQa1lENG9GR0dUMkJIVmxwc1gvRHhKSmxBaXBmQkZwbmlZWjJ3WjZiNzRr?=
 =?utf-8?B?QWxMZGZGWFV5MXh5akFITDdibmI2dEdWaHhrWEp6RWpXWjc1ZWdEQnRnSm8v?=
 =?utf-8?B?WFV2ei9ZVjFtd3I4dkdGRC9kM1JGc2hCSGFpMFliVHV4RWlJaTc0cFBhL0Np?=
 =?utf-8?B?dTBTR1ZqQ0hkK0p5L0llcFNBWnplWlBoRFdkVGZwU2RFYndTN2VtTmoyZURn?=
 =?utf-8?B?WjBkaXByUUwzVlBGRjdkSGhQcjZmUkpTY2RadnJtVnkvMlFMaFovTTVuWWNV?=
 =?utf-8?B?L0wwYUJjaU84U2FaTXU5R1ltK25pbit2azJZOTVuMXpsVFBQVmtFNFNTajRx?=
 =?utf-8?B?cEY0bTErNjE4OXBtUjFvMUhEME1WY1BkeHRsVkYzU2VuM2xMMmZpTFZTcDhs?=
 =?utf-8?B?RFUzYWJpY1JmR1Q1TndCSkVpamdJeGNDTElFa3ZqOG05eFd5dGYyTy9WcDBy?=
 =?utf-8?Q?PCg8SfyhI8bPuVmjJLPoxu9wn/+SwrnavRvOc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE9OZ0JGbzE5M3FqajZKcW1nSXdvd055RDBTdis0aXNkTmdBOXFnZkNIbCtR?=
 =?utf-8?B?c3RyVVpmSzVPVUNSQUdubDNwUU4vbXVWQjF1dGw2S1cyWDFTK2pMc2EwSnZz?=
 =?utf-8?B?TmNxMjhrRG9EaE5zS3FET3pOa29jZGkxa2tNQ2VBejJGRkE4SDExKzdaS3cy?=
 =?utf-8?B?eEw2NmhFbE04cHNXRkdQUTdmdDREcDFhVzVwcDRPZ3lHZ1VUN3FIc1VoQW5o?=
 =?utf-8?B?cVpzY1dzQktaVjlGWUFhZjZpRXRLaXJNV2lWYXF3Nm1GWFhHWlBpaTJONUJG?=
 =?utf-8?B?MkpuOW4vWW4wTkxNT0lCUWRiTDNEVlVYQ21BOG9RY2syZHIvZTNTZEZCaUp6?=
 =?utf-8?B?L1BHMVEzWFUzcmF1ckYxQWJSbmtzdk9TSEwydm9Dby9pV01hY2tMTzZNZUpj?=
 =?utf-8?B?SGFkbGx3YlBFUi9scC9aL202WXFkRnZ3RkRnL21QOWE4ODJCUExJcDdqbE1l?=
 =?utf-8?B?cGJSNGcvVmFpbjRhK2J0dTNRRjM5UXpWcG0wdnNHdDQ4VmRCbTNwMzJvbW1z?=
 =?utf-8?B?LzZNOWZwZC9tNUhjOHdMb2d3SDU0elg1Yzc3ck1vN1AwRzY3UDV2VEFvZHhN?=
 =?utf-8?B?WGZSV0lUOGoxSkdlNVNDbUVlTnVidytONml4VWhvMkp5L3V0NTYySCtscncw?=
 =?utf-8?B?bFFNWmZ6VGdNV0Y3cFM5MTdUWU1KZVN3WXJRRjBvLys2U0J3M21IY0pzUDZj?=
 =?utf-8?B?OFNqV05xblQ5ZXdMMlpxdzJOQzZ0Y0NsVmJCMy9vakRIVldyeGZIeFdrNHkz?=
 =?utf-8?B?M3hkV1BBRFJFVURvTnJWTEJ5STBOUXJ0cTYzRjFlOHRRU3Q2NEpEYWp5VmNE?=
 =?utf-8?B?TDFBYUFrWE1qZm55dHdkMHhJLzFTSU91T0ZUc083QkxQU0JsUDk5anpHQ0lm?=
 =?utf-8?B?RmNFalVDcnRyUVVwL1pvYm5lY1NXOVRTRUs1dXRzZE1vMkx6TTZzV0dHWC9R?=
 =?utf-8?B?djNxaEVuMlhvUlhuVm5iSEF5RVlZeGJaYWhBWHhsUHhiOURGbTQ5V1B2ZnZL?=
 =?utf-8?B?NG9VeFEyVStQWWdvM0RXVWtiTXREMHNTbWs3YUxLWm8vYWpkL1U3U2tSaXB5?=
 =?utf-8?B?SmZ4Q2xNSm9qL0V5NWJuVVAzODZ4cEJGOFYyNzVhUWFuWWVuWjZCQXY5RWpO?=
 =?utf-8?B?N3BQZkxHWEM2aUltdDIrdVU5SUQ4T3BOZk9IRVpkVzdmZlFJMzN0emFVTXdy?=
 =?utf-8?B?NW9FT2tEMnkremtzbUNaZ1E1SHpUOS9FWm9KOUdHSCtaVjNYMHBEb2Flb3VV?=
 =?utf-8?B?V2dEcjhTTitwaU82bUg2MWJFOFk0NEtDUW5pV0FHUERNcklXSHc2OFVGMkdl?=
 =?utf-8?B?TGt3ZzBhS1hVWFZYallSVGpYQ2RZbnY2OHZpSktJMmczOTAvU0RoVDZzaCsv?=
 =?utf-8?B?MmZFaEgzL0VCd1ArVHJmcEs5TnZyNFlhL2pzNE9Xa1NickRDQ2JTbkxzUjJY?=
 =?utf-8?B?UFBnZ3psSXJveFEzbHA1NjhoRi9paHd6TitjQUZ1WjJhNUpIZFFqM2w1cUxU?=
 =?utf-8?B?Nkdka1RwZmNIMU1Ub1BYMkxMN3lHOE4yV0Q5a3ROQ0lReHZhTFlWL01ja2I3?=
 =?utf-8?B?NDVDSWZQcEdON2RKNlhZR0Y0ck91VHdzeFB5L0RFZDNkYjlyVDVDZitGUmMv?=
 =?utf-8?B?aUFxVVM5UU1GNzhnalBDaGhCa3FLNGQxSll4Ui9oWGVRb2pTQzRhaWxGQUkz?=
 =?utf-8?B?WHQ3aS9zaXNzNmhCTHNMZmRHVThsaGJIMElyRDZZdkFxWHBMZVk3ZkVwQUI0?=
 =?utf-8?B?N05lbCtBVEJOc0txR3hDMEJiSHlhZUpMamNZYzBMTDNGZXBUTmNVYzJTQ1Vt?=
 =?utf-8?B?Z1pqeE9mdEdTekxDZ3B5K1FjWWxZczJOY1hicFBNRk5KKzFFU3l6NWtkeXlp?=
 =?utf-8?B?ZGRMTi9JNkxCTThBUG9leGFscEZoODdnZzBJanZFNm5ZYjRKUDRtTFRtUVRT?=
 =?utf-8?B?UU5zUHhRNjF2cFRBWHB6dEJJRmU5TGpmOW41RXdRcHBwOTBndURwZFp0emtK?=
 =?utf-8?B?THR3T0tpNElIbVNHZUFTQzBRaDJlejBlVW9UYnpMcktIYjEyUU9UdkVUanlq?=
 =?utf-8?B?M3FHdklZeS9QVjBpcnJ2TVJJZWovSXFJTWdtVWNkS1lyUlA4dXg1R2lmSERk?=
 =?utf-8?B?V3lCcXdNMThERWFyNTBKdEswL1Z0S2RQNEUyaGVkK0ppaDcyV3N4alpmRS9x?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff19429a-110d-4b1f-6d64-08dcc2ab0ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:05:12.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKV/bl4Ed5Gfblp0GrD0We9FmE5oZmhOcKYOArXqWR1/5Ny465zOf/nEqftyCY8t0CMx+5Ucg2kf47nXMtHdEKWCFuD+qXHwqYbCek70PhrbrOKWjChlgiDe9gHcdP9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBEYWl3ZWkgTGkN
Cj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTQsIDIwMjQgMTA6MjYgQU0NCj4gVG86IGludGVs
LXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBEYWl3ZWkgTGkgPGRhaXdlaWxpQGdv
b2dsZS5jb20+OyBOZWZ0aW4sIFNhc2hhIDxzYXNoYS5uZWZ0aW5AaW50ZWwuY29tPjsgR29tZXMs
IFZpbmljaXVzIDx2aW5pY2l1cy5nb21lc0BpbnRlbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IGt1cnRAbGludXRyb25peC5kZTsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgTmd1eWVuLCBBbnRo
b255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdyA8
cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJl
ZGhhdC5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQNCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxh
bl0gW1BBVENIIGl3bC1uZXQgdjNdIGlnYjogRml4IG5vdCBjbGVhcmluZyBUaW1lU3luYyBpbnRl
cnJ1cHRzIGZvciA4MjU4MA0KPg0KPiA4MjU4MCBOSUNzIGhhdmUgYSBoYXJkd2FyZSBidWcgdGhh
dCBtYWtlcyBpdCBuZWNlc3NhcnkgdG8gd3JpdGUgaW50byB0aGUgVFNJQ1IgKFRpbWVTeW5jIElu
dGVycnVwdCBDYXVzZSkgcmVnaXN0ZXIgdG8gY2xlYXIgaXQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9DRENCOEJFMC4xRUMyQyUyNW1hdHRoZXcudmlja0BpbnRlbC5jb20vDQo+DQo+
IEFkZCBhIGNvbmRpdGlvbmFsIHNvIG9ubHkgZm9yIDgyNTgwIHdlIHdyaXRlIGludG8gdGhlIFRT
SUNSIHJlZ2lzdGVyLCBzbyB3ZSBkb24ndCByaXNrIGxvc2luZyBldmVudHMgZm9yIG90aGVyIG1v
ZGVscy4NCj4NCj4gV2l0aG91dCB0aGlzIGNoYW5nZSwgd2hlbiBydW5uaW5nIHB0cDRsIHdpdGgg
YW4gSW50ZWwgODI1ODAgY2FyZCwgSSBnZXQgdGhlIGZvbGxvd2luZyBvdXRwdXQ6DQo+DQo+ID4g
dGltZWQgb3V0IHdoaWxlIHBvbGxpbmcgZm9yIHR4IHRpbWVzdGFtcCBpbmNyZWFzaW5nIA0KPiA+
IHR4X3RpbWVzdGFtcF90aW1lb3V0IG9yIGluY3JlYXNpbmcga3dvcmtlciBwcmlvcml0eSBtYXkg
Y29ycmVjdCB0aGlzIA0KPiA+IGlzc3VlLCBidXQgYSBkcml2ZXIgYnVnIGxpa2VseSBjYXVzZXMg
aXQNCj4NCj4gVGhpcyBnb2VzIGF3YXkgd2l0aCB0aGlzIGNoYW5nZS4NCj4NCj4gVGhpcyAocGFy
dGlhbGx5KSByZXZlcnRzIGNvbW1pdCBlZTE0Y2M5ZWExOWIgKCJpZ2I6IEZpeCBtaXNzaW5nIHRp
bWUgc3luYyBldmVudHMiKS4NCj4NCj4gRml4ZXM6IGVlMTRjYzllYTE5YiAoImlnYjogRml4IG1p
c3NpbmcgdGltZSBzeW5jIGV2ZW50cyIpDQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvaW50ZWwtd2lyZWQtbGFuL0NBTjBqRmQxa08wTU10T2g4TjJadHhuNmY3dnZES3AyaDUwN3NN
cnlvYmtCS2U9eGs9d0BtYWlsLmdtYWlsLmNvbS8NCj4gVGVzdGVkLWJ5OiBEYWl3ZWkgTGkgPGRh
aXdlaWxpQGdvb2dsZS5jb20+DQo+IFN1Z2dlc3RlZC1ieTogVmluaWNpdXMgQ29zdGEgR29tZXMg
PHZpbmljaXVzLmdvbWVzQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFpd2VpIExpIDxk
YWl3ZWlsaUBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lnYi9pZ2JfbWFpbi5jIHwgMTAgKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4NCg0KVGVzdGVkLWJ5OiBQdWNoYSBIaW1hc2VraGFyIFJlZGR5IDxoaW1h
c2VraGFyeC5yZWRkeS5wdWNoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0IElu
dGVsKQ0KDQo=

