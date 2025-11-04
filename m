Return-Path: <netdev+bounces-235386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609ABC2F99E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FA3B206A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07163016E9;
	Tue,  4 Nov 2025 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNbQB4X2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80C250BEC
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241169; cv=fail; b=aTOElgDrmLzE7sqT+IoOtTapgNuS0KVmX75DLLsXTW0nMNEH2IBD8Dgpo6eKa8UpWbIAjbg2wjzqRSrVngiMUg84CW+fu/Kah6VmWwFl1MtI1p4kB75pGQODLfE1jiSeRFwXfkxK8GTusTpJvbWhg7IJnPn5I/bMQArf8nCRXjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241169; c=relaxed/simple;
	bh=Gr4M86Nixs76APd7DhqR7yiOEf0dt5y77gd9N6Jbctc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=png13soZyqtssDMSARSxOhzgb5IuQQmlpUzwDitMeUXVqeFOiBDmHrMPGdHHD+lvSQx4XF7T9V4cGttd9gcqKxSlNvxQzO4GUXgW+OOl/MV3yx7VufgKoloO3aMBWOCY8ih9gUL70XrhUE1fl8IqSMAbwWFTl2UJ+5zf8ntlQzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNbQB4X2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762241166; x=1793777166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gr4M86Nixs76APd7DhqR7yiOEf0dt5y77gd9N6Jbctc=;
  b=TNbQB4X2wfXjYqzMdu58ed305Mr+bH9r2M7vrQsuyhXphjc1YTqe+r5n
   AzY1Lnmm9P+GiFgo/+b0tbFR+pWODX0acd3vDi1uS0wbk0+FamDn9ZdU+
   3CQezpDTQhi1estaSZKOEC0m/ytBqi8afUFAfDmsMzZddc8imPx0snuuK
   KbKzCizzGytYhvqVof1X6vuBGnsq8KtKRN9NR6wnoTdafUjJZnl8p7vmX
   cxIokURsGPsU2/g386NeYY3N/MEpE9E26LCAKwSgHuP3A4u45A4uR1d6v
   WGso+beRJyuZxDUlikvOvYV50ubevLvuIV550W349JcP5ZmmE+GyQu0qS
   g==;
X-CSE-ConnectionGUID: DZVRJ6gDRoiPl4QXGHtkOg==
X-CSE-MsgGUID: vZs6fvNsTtuGLI/mRziYVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89790417"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="89790417"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 23:25:39 -0800
X-CSE-ConnectionGUID: 2tCkuOajRnSabwFDNDK13g==
X-CSE-MsgGUID: QL6NOwSPRxqN8WJMXj6w6w==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 23:25:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 23:25:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 23:25:39 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 23:25:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLCJ2AO2tGuX2ubqAlDsEOD3OwaQhUbf0DVZyBMbAHkCLJR6sNFmuym9/43MAmNztxek+fkpxatkXpA5tQ6LoeQPzqX9eQbRLlZhQWowWwmWtuTzbMX317CQYZ0zXzgmOTJAcgIc8+IEMkxupeFNNxnthwyz2Ps1A+rkfkijZC7UvcHHUdBZ1MFl7alwup5UpLLQTUuzqA/tHe4+yx9FDbqh6DUrxaudL6j68hpX7jm3m1/+95E6Qt/lxsnWxKoP0rgqwINfSkP1MtRGNiEhWnXWqwa2b432//6CJduOG5rxuVq8GbhgMEOW3szJZ6DRSUEfv8gjMuASMU4OA3VmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr4M86Nixs76APd7DhqR7yiOEf0dt5y77gd9N6Jbctc=;
 b=UVVKpp0nYCa1hemIrAvVVNeF43h9+c8njRd8uv1yYkpqFv9rYSY75gbHQB+Q32cVAxvGy/P2YzpmK0BuVgLzgwLb3ennJcydW6I89iKqHOwOhC4nlp4wXRr1TALKtglFmde2oxnDid/U1F/FOsrj8RIxEOKhWqQ3gRSil+Bkkt2+ZtYihWDBds9NACcs8SEk4k4fEpLljvizVx3cTslOmWSEBzl30/yykh+Wdz6O146O2ykKUSJmLrU592+450kQXZV43Fzw/kJBTENpRJUXREfOWbIL7tdIhuOlUjfMbK+/Yu80dYUlZ/9Bu9x5xUpKHv0Fr2sQ7HWjGvuluGsGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:25:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 07:25:37 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next 9/9] ice: convert all ring stats to u64_stats_t
Thread-Topic: [PATCH iwl-next 9/9] ice: convert all ring stats to u64_stats_t
Thread-Index: AQHcTSdo/te3JUSIN02RbDWhwrYkB7TiHgSQ
Date: Tue, 4 Nov 2025 07:25:37 +0000
Message-ID: <IA3PR11MB89866CF89D419B8BF17CD8A6E5C4A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
 <20251103-jk-refactor-queue-stats-v1-9-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-9-164d2ed859b6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB5160:EE_
x-ms-office365-filtering-correlation-id: 992c358a-325f-40f0-a2e3-08de1b7359b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?czJRM1hscCtCc2hGM3hrSSsvRGhqQVJ0VnZDK3FzL2tSRyttWmsyVDg4eHpx?=
 =?utf-8?B?TGozRkFLRTMvR2IwcUFNdzFEd25USTBOQWhleG04TGxmamg0N1M5RFRxS1NL?=
 =?utf-8?B?ajkxek1yU3JCMWg1QUxnRG1FM28waE5iTzVORkF2a2R0SFFYY3dya0F5OVgv?=
 =?utf-8?B?RDRkMXdNSUVsYldZSTlvOGZZNFNadUE3L0tBREFudldqRjNCTDkrQmpMVk1K?=
 =?utf-8?B?RThrdUFaYXBPUDJZYmJkR3RJVDFucGxBQVp0NGtFYTdXSi9zN05nZGl4ZEEv?=
 =?utf-8?B?aDJNb3B5WisxYWM1UjRLWCtTYWpNbml6by9uZHMrczhIZGw1ZFNXOHNTZjBx?=
 =?utf-8?B?WmlhdlZFOVhqazRYSGthV3Q0ZlUwVnJqVnpKRzg2SlhKTXJoSUJaVTlWVkxD?=
 =?utf-8?B?WS9RK1RKSFA0QTYrcDROaTlkTUx3VXBDbHhCYWdhcnBXV2JLMkl6bHhrVWg2?=
 =?utf-8?B?M2tSY0l1RVoyaWZUNVdJWllhNDNNTTJORjU4N3p6WllRWXQ4YVlnUml0ckJ2?=
 =?utf-8?B?YkRHemhEYXNpL1c0M1p5NUJ4b1JZQ2MzS0JsaEJtMUU4SGEwZTMycUVyZ0Fr?=
 =?utf-8?B?K1RiN3FKOW1mUkVLdnhiUldIdklEZWhTZ0tmTENTWXVRSlZGMHp4aXVpZ3lM?=
 =?utf-8?B?RXd4a2JTQ0g2VklhbzdodTNYYWhpLzZTaitQMXA4MVdyNCs0YkJvWXRJN2s5?=
 =?utf-8?B?RDdweHBvbTBrMFdzWmV6Wi9WcWxaZHl3Z2Y5eDlCVmE3TGtBSjNwZkYySVBu?=
 =?utf-8?B?c0NxZFJFS0VUZDNmYzNFVjAwN0JWWWlEL2RvNU5ZeEhLaGE0THoxSytBWnY0?=
 =?utf-8?B?M1UydDBjU0EvUUtvVXk2dzhqaDBlSDBtRmlGeWxseHBmZHpYdFQrSWNvRUJZ?=
 =?utf-8?B?VDI0N2g3S2kwQzA1dHB1WXBPQjRYMkNDSk1LNG9WZ1l5THFBaTVkelZIWExM?=
 =?utf-8?B?U0p3ZmhFc1JwQ09KNytGcytlOGplOXR0VTVPWWtNTmllUEQ5ZVJ5QmdZYnlx?=
 =?utf-8?B?czQrYkV6UXpZbllKS2hORjhQeWU2VGc4eTJjQVN0b0ppWEYva0ZDYVFKQ3FB?=
 =?utf-8?B?N2JlQ2Q1bTZnZ3Vpby9NMzJpOFl1dUxzOTZlY2hLbGpSL1JuTEFITHVwVWFI?=
 =?utf-8?B?UGd3Vm1HcE5yb1c2U3dDYzJRYlZjT2M5SUxCb0I4aGdSK3NZMm9ZTG9wdk9K?=
 =?utf-8?B?SHAxUzBqeVRldXc0L09acUdlNnBQZVk0ZzMzMU1xTndiQzVZektMSEN0dG4z?=
 =?utf-8?B?R3pWQThBRlN3QndwdE5VUjZQT3RoY0xCS05Dc3g2QjhPN1gyazRqNHRxWjBN?=
 =?utf-8?B?emVDYUpUOW0wazgyUlhJU3ZXRjZ3TlFYSkk4N2w2UnFvc0ZqdlkzWjF5UVYw?=
 =?utf-8?B?MTJaRDVQMEZ4aWM2b2tGWFZXSStWQzVlMWVMUjJUVGtQaE8vRkI3eG1Rc3Aw?=
 =?utf-8?B?WXQzM0dyVTE4NXlsUWsvb1VDUFB3djVmRU9rY2hCL2gxUitqTm02N202UzBS?=
 =?utf-8?B?Y0YySTdFMDZxSnV2cWJsSGhMcDBkUGdOYUNVdy9pQ0xwVUhBdDZ5VldPUzBH?=
 =?utf-8?B?YXhjNmJYeWtOWGF6Q3RVTjV1aXhkQjY3ZGRzZUNpSjFuSkFnTXRLL2hzL1Ju?=
 =?utf-8?B?ZHNiRzZIaDJJdGRxLy9jaXp2ZHdOQnJUVTF3V2QvNW5lbmQzZjdoc0QrRDFG?=
 =?utf-8?B?VG5UdTNNQWVLUTdiNE5hYnNHd0IzZmxhVFVXN0g5SlZTeXA4TVBoN0laUUtx?=
 =?utf-8?B?YlB5alRvaVhVNDVXSytJZFNrMFlsS2l2VEhkeGVFd2ZNNUE5S1RwTmVKeVVQ?=
 =?utf-8?B?Q2JHbitPRkVkZG9KRnpEVGdjSHJrUFByNmV0S3hIc2liTVlxcTM4MlFUOFl2?=
 =?utf-8?B?N0lpNFdvOERDOXJFWjhTVnFuWVltdXVkR0ZQOTdGNi9iMVRGUUZ6RGhXM3Rt?=
 =?utf-8?B?NmJuVko2MFlyVXlPeTFqa0krM3dlSytybHoxYjVzdjZrcGlkRUgxR0tpU2xD?=
 =?utf-8?B?YWdzRDZ1dUd1TWx4VDVFTmZydkN6NjgxZVRISzJKdjNSOUV4eEtBZ0VzdURi?=
 =?utf-8?Q?4uaZ1z?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy9paG4wNHRrSmlGQjJvallUeTBIZS9DQWZSL1VZbUl5WWpYSnVoYy9icDM3?=
 =?utf-8?B?U3F5RC9MOXBRc3ZEOVB1RHdsUHFlanZJU3lmVlRCT241a21kSkpJS25USXdw?=
 =?utf-8?B?a2NEbUY2M1pmQUxJTXBWNExmaGpzcldEYk16VkVnTHZla0R0KzlHeTZkZW9n?=
 =?utf-8?B?WThqeHBnb3hscXF2RmI5VSt2bDAyeStOVks2Lzc2SjJxdVJWWXU1ZUxXY2pP?=
 =?utf-8?B?YVJBTDFtaUh5QWdPL2haVDBoa1BHcnlFUFAyTU5aNjZkdG1UZ0pXTDRocGhy?=
 =?utf-8?B?NURjZ1J5ZEZhYlhUenJwUW1uME80cFc1ZEVRRi9IV0U2QmM2ajY3ZlV0UVc1?=
 =?utf-8?B?WTlXMXBEOGpHR0VVeTl1YnZKeWlhbVc0OHpuQSt5V0VobUFXbGdkMU4rSlFw?=
 =?utf-8?B?QXJtUEI0ZDUwM3BoZWFHOS90eTFUOTdXVFhrRldsZVpaWTVXaThMamNralB3?=
 =?utf-8?B?Tks1OERPRWxrWk5QMHlyc0VuR1JRazNxcFc1NkQ0cXlmc3dCN3lCS0Jocm9h?=
 =?utf-8?B?WHFlcVVhOU9DSndsQUxhYXNtRGVMcmVXUDBub2J0d1J2dkJjZnNGZWl0blV1?=
 =?utf-8?B?clZJVmlTc01aL1NPaDQyTVNBQ0xoYjE4MThaZnoxUHdkTnFNbGh0SWFxellY?=
 =?utf-8?B?ODErT1pXUDRXQ3NWcUJUbzd5TG1tajBaRDUzT21ndDU4YUVWTm1IR3ZrSGdS?=
 =?utf-8?B?R2JvcGxESzZiQ2prNXR5amp0WGczMkFKWm9wTTFyajZZQ05GTFE0bEw2Mk1h?=
 =?utf-8?B?Qnh1bzQzMDdVVVR6QWVJMlp2R1FNVy9rZFN6UUl5aDl3VnpYYmhuS1V3UUtS?=
 =?utf-8?B?L3JmeFBZc3lNV1NmdXE3Zm5KWjIyeHRQQ0duVTlFd3BjWUlHTTlQL0ZyN05W?=
 =?utf-8?B?c05CWjVDWlVIVzFGd0VxN0pKblhTRDhRb2YxVVk2aFY2Sm1xdkd4QjlUR3Zr?=
 =?utf-8?B?dHdJcjZpM2pEWGhHREhMYnRBVS90VTJ4aXJpdmh6VlNDQ2FvdzJaMFgySk5E?=
 =?utf-8?B?ekNRZkFablZwRHJCVDNqaXR1YjFvMTlxUEQ1ZWJxL2cvTjVBUS9XQ3VqWlhi?=
 =?utf-8?B?Zk8zcTFVMy94QkZnVER3WXE1eUNaMEIvVnM4UWV4dElZSlBCOEsxd2lnZm85?=
 =?utf-8?B?dUpiZHBxaGRSVDFtYmZSWExVRXdxZ0VPOXlDZlRFSzNMYm50QVdxWXJaZ054?=
 =?utf-8?B?QThxRTBJRnFOTC9sdHRUUEluWGQyeC83ZHdadklXMGd0a3J2WDRMVTVlcE1X?=
 =?utf-8?B?RW1SQ1NMS0M2YWw2OHVOOFFhYlRkSGkvUmx5UU8rSzJoNmZFZlpqYmlSdDFl?=
 =?utf-8?B?RjR0U1RKNGY2YnhNdnNYdlhKRmdKdzdidHBDc2d6bGVOWXZzdDMvdVJyZ3ZW?=
 =?utf-8?B?ZXJ3TTkwajUxUFI4VHNvVjFkZkFKOENxRlpGTE8zS3I1VjVyVUMwa1R2Tit0?=
 =?utf-8?B?bGJMSVc1Sjd0YkQxdEkzUTZjUUZheUJ6SGJpYXRiUmFjeFlvck1wNk5DQ0tX?=
 =?utf-8?B?cHlXb0d1NTBrdGlyc3Z1NTZManA1QisyRUZPNXlXcFp0b001M1NZci81aTFt?=
 =?utf-8?B?TW96TTJjazV4T0x1MjhCc3NHUnQrb25NOU44Y29YSnRKdmMrZE82dGZPOGNS?=
 =?utf-8?B?K3lacHloeHV4czBwOWJETVpYOHVYMUZIWXpsbjh2NjFrVWU2c2h3YjVFbFVj?=
 =?utf-8?B?QWllNFNLWGtmcDVORlZvSE5ieDMyUG5PRENpWEk2dStqMm5NZHdPQzBYaTkr?=
 =?utf-8?B?ZEJONGZ2NncvelRFYjVnS1JpVHdwb2Q5TDlZeHlTWlNVSHNPb2lacHZnMHho?=
 =?utf-8?B?Q2pubGExazBEdGZOMmo5cnlELzJmaEE3d05GOHNUQzBjdWw1SGxCSTVXTGxJ?=
 =?utf-8?B?ZE1RNi9HZFhlbFBVRzJ3UHIrdG56UG1OK1dIQWl3QkNncTNaOGtPMjhDcGMw?=
 =?utf-8?B?WkNYMlBGZ29Nb293N3pLMnNwckhxandyVFcvM0tkRTRjOHlMNTM2aGxId3pi?=
 =?utf-8?B?TVZxMHFlM0VEQ1dXWDh1VXRmSGR4YVJzOUFWWG9ORS9rSFNEQ1BvSjgraVhY?=
 =?utf-8?B?bU00NUhzRlJlT0JrZlZkRCttMVdNNzdVMWlWOUs0M2UwN2RhajJHVmJDbEZX?=
 =?utf-8?B?TC9hamdhbDhodUNsc0VBYWt6UkJyT0Nya1hoRFlRNXhmR09LKzAvRFhHaXU3?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992c358a-325f-40f0-a2e3-08de1b7359b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 07:25:37.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Am079Vj+0NON8g6WYIe2YmE5QIGoR0cn9UOpZ1QaDXhnlM2NXNqgEhCnHSt/XkDZ9Jkp0J78jgliEdy4l2+ETZMTXTSfx/k9fQ6foGvOWOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDQs
IDIwMjUgMjowNyBBTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPjsgTG9iYWtpbiwNCj4gQWxla3NhbmRlciA8YWxla3NhbmRlci5sb2Jh
a2luQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRl
bC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgS2VsbGVyLA0KPiBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV4dCA5LzldIGljZTogY29udmVydCBhbGwgcmlu
ZyBzdGF0cyB0bw0KPiB1NjRfc3RhdHNfdA0KPiANCj4gQWZ0ZXIgc2V2ZXJhbCBjbGVhbnVwcywg
dGhlIGljZSBkcml2ZXIgaXMgbm93IGZpbmFsbHkgcmVhZHkgdG8gY29udmVydA0KPiBhbGwgVHgg
YW5kIFJ4IHJpbmcgc3RhdHMgdG8gdGhlIHU2NF9zdGF0c190IGFuZCBwcm9wZXIgdXNlIG9mIHRo
ZSB1NjQNCj4gc3RhdHMgQVBJcy4NCj4gDQo+IFRoZSBmaW5hbCByZW1haW5pbmcgcGFydCB0byBj
bGVhbnVwIGlzIHRoZSBWU0kgc3RhdHMgYWNjdW11bGF0aW9uDQo+IGxvZ2ljIGluIGljZV91cGRh
dGVfdnNpX3Jpbmdfc3RhdHMoKS4NCj4gDQo+IFJlZmFjdG9yIHRoZSBmdW5jdGlvbiBhbmQgaXRz
IGhlbHBlcnMgc28gdGhhdCBhbGwgc3RhdCB2YWx1ZXMgKGFuZCBub3QNCj4ganVzdCBwa3RzIGFu
ZCBieXRlcykgdXNlIHRoZSB1NjRfc3RhdHMgQVBJcy4gVGhlDQo+IGljZV9mZXRjaF91NjRfKHR4
fHJ4KV9zdGF0cyBmdW5jdGlvbnMgcmVhZCB0aGUgc3RhdCB2YWx1ZXMgdXNpbmcNCj4gdTY0X3N0
YXRzX3JlYWQgYW5kIHRoZW4gY29weSB0aGVtIGludG8gbG9jYWwgaWNlX3ZzaV8odHh8cngpX3N0
YXRzDQo+IHN0cnVjdHVyZXMuIFRoaXMgZG9lcyByZXF1aXJlIG1ha2luZyBhIG5ldyBzdHJ1Y3Qg
d2l0aCB0aGUgc3RhdCBmaWVsZHMNCj4gYXMgdTY0Lg0KPiANCj4gVGhlIGljZV91cGRhdGVfdnNp
Xyh0eHxyeClfcmluZ19zdGF0cyBmdW5jdGlvbnMgY2FsbCB0aGUgZmV0Y2gNCj4gZnVuY3Rpb25z
IHBlciByaW5nIGFuZCBhY2N1bXVsYXRlIHRoZSByZXN1bHQgaW50byBvbmUgY29weSBvZiB0aGUN
Cj4gc3RydWN0LiBUaGlzIGFjY3VtdWxhdGVkIHRvdGFsIGlzIHRoZW4gdXNlZCB0byB1cGRhdGUg
dGhlIHJlbGV2YW50IFZTSQ0KPiBmaWVsZHMuDQo+IA0KPiBTaW5jZSB0aGVzZSBhcmUgcmVsYXRp
dmVseSBzbWFsbCwgdGhlIGNvbnRlbnRzIGFyZSBhbGwgc3RvcmVkIG9uIHRoZQ0KPiBzdGFjayBy
YXRoZXIgdGhhbiBhbGxvY2F0aW5nIGFuZCBmcmVlaW5nIG1lbW9yeS4NCj4gDQo+IE9uY2UgdGhl
IGFjY3VtdWxhdG9yIHNpZGUgaXMgdXBkYXRlZCwgdGhlIGhlbHBlciBpY2Vfc3RhdHNfcmVhZCBh
bmQNCj4gaWNlX3N0YXRzX2luYyBhbmQgb3RoZXIgcmVsYXRlZCBoZWxwZXIgZnVuY3Rpb25zIGFs
bCBlYXNpbHkgdHJhbnNsYXRlDQo+IHRvIHVzZSBvZiB1NjRfc3RhdHNfcmVhZCBhbmQgdTY0X3N0
YXRzX2luYy4gVGhpcyBjb21wbGV0ZXMgdGhlDQo+IHJlZmFjdG9yIGFuZCBlbnN1cmVzIHRoYXQg
YWxsIHN0YXRzIGFjY2Vzc2VzIG5vdyBtYWtlIHByb3BlciB1c2Ugb2YNCj4gdGhlIEFQSS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHhyeC5oIHwg
IDI4ICsrKy0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGliLmMgIHwg
IDI5ICsrLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbWFpbi5jIHwg
MTgwICsrKysrKysrKysrKysrKysrKysrLS0NCj4gLS0tLS0tLS0NCg0KLi4uDQoNCj4gLS0NCj4g
Mi41MS4wLnJjMS4xOTcuZzZkOTc1ZTk1YzlkNw0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExv
a3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

