Return-Path: <netdev+bounces-192713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8962AC0DFA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BAE166475
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB058288C87;
	Thu, 22 May 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQc4bEZm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3D2236E0
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923806; cv=fail; b=HRc1daPsD3L+WcMbCTKqBPvTH+v/RosOVUfUMOH9eROY9RbP6qyoVMq6e7bRmWs4E6leQ+ouNyo6WdRseOoQ9xGWIkf7+HnnO+6VtO8Bi6wWAEmvArjdzH/RdUhWgE5ZdJlLrvtvN+85Wf4to0j4uxkAxcTVq5y7znAgA+dChso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923806; c=relaxed/simple;
	bh=6pnmdEVb8xwRjikE9XGUBA4afEAgZsvKsNt6e2vHLhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/b97iQcTdEWEfHzc9mx0A7U6G59rvkKKCBVEhCQ/BZfvQjXVxzG8MlX+EEI4+RQmpqrmuMUay2GB8rojePwtGDZ4/DTT5Hp7V2clZ4r3fJfqJBk/M2e3mZ8NCQOmQAWn2qK/0O+LVfTLjhYJDkEYT0/wFldulOIOVL0a5VdslU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQc4bEZm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747923805; x=1779459805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6pnmdEVb8xwRjikE9XGUBA4afEAgZsvKsNt6e2vHLhs=;
  b=kQc4bEZmsElLf+EUejJ1bRgGhaRxK5iRFyzihCzAvpi79vhQt1NKsRcX
   eNrGFa/cp1qzaBVRaFqJ/WEI2WWfCzd/Tnh8kRSpW9BlXYXdzWX2Cc/bD
   25jmboyAIMPI35RQVFTdTB1fL0gt3cwx5LtKB6HcjC1cvyU8+NCTujU67
   llhk/H+bM4uOl7hmIz/t8v4k4XriLZnOnmCHh6HgQV6xhrro7qPpfM/p9
   ciOOUUYkFzGjxxw4QsEE1DXgXfx3rLsQv7Qz6sw8EY9j8OdoKWuRo6EcS
   myUnu5+58qUsP9X2ZPccK4sgfDb4jbCbFvJwjlc3j6cEbOpZadutNjkkh
   A==;
X-CSE-ConnectionGUID: XQMDC5wVR0iNMo2RP7um4Q==
X-CSE-MsgGUID: e7ozK9g5RLaFQDiKkOZgng==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50097061"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50097061"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:23:25 -0700
X-CSE-ConnectionGUID: Z+uCn9zHQP+Kr4V0xREh+Q==
X-CSE-MsgGUID: GigdKPjrRjScw04WORiSWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="141040201"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:23:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 07:23:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 07:23:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 07:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv6tlsjomgh4GdItbGhkeNwb4k/ioy4agI6kQoYDIRofD0rpc691tF/gYu9MtN/G7l9luXIVBiWIma5y7OjNHFCNIe62EdKFgin/v4S+RAYQxcTs4fulA033HV5xCVTV9GLIfO8vGkT1aDOjFCtVCJFzKbk4bTxfiYp3IpUGhQ3pRcC+ygSgquA6Ld7nPU7oHrOohvHJ9QqDmmZ6kIb2QUCKsyDk22OrE1Wrv28nIUAleuJgGeMrLEb3Yef3HJSqLX/YsdneQ316jhtH9ozzH90LViz259+KApqbDmrNY1cDazom58+W5zgtf1Acyj+NNqY/zqjV++6HnjeS/068kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pnmdEVb8xwRjikE9XGUBA4afEAgZsvKsNt6e2vHLhs=;
 b=cUqJGFSee7416u4cF0CjhRTnkT2sNz0LfjTF8FkxU8WpDkCI2Tfa20j0uTMAkDTC4PIO/Bl6umqZHwagN41hwlrikCaFv4qHgAhMJY5NtHg9al0MK6rNf+MIAu5ErEYtgheKZLVuE/9mg+6wGGRUkr5C+r8rrH3MU+lYv98Bnu9BkRIHwePgeYGBFXYZw8K+2lNV7GdK46G/iBNnEl4k8z/BOPFSo2AE52KLBrx4VQ6tc2FC8Wz4y5orkKIAmQPbmeDSAAKmac7yeiapRL9n6qfstm3KZfqZ+xez2P+p1oSxh9sJnrBPa3MRlnnolME4hcgGwfxnGyFBEUWGa0PKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 14:23:07 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 14:23:07 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, netdev <netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v4 06/15] ice: add TSPLL log config
 helper
Thread-Topic: [Intel-wired-lan] [PATCH v4 06/15] ice: add TSPLL log config
 helper
Thread-Index: AQHbuuwTSc51BxTv2UqVUBMWBf9aObPe09ag
Date: Thu, 22 May 2025 14:23:06 +0000
Message-ID: <IA1PR11MB624152F4CF4A8AC7D3676CC88B99A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
 <20250501-kk-tspll-improvements-alignment-v4-6-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-6-24c83d0ce7a8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW4PR11MB5934:EE_
x-ms-office365-filtering-correlation-id: af4a5952-119a-4899-4866-08dd993c2be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UnltanViWVdKR2VlSkhSL3AwREN4NndOZUlTTlZxTWNPT2FUV1ozZStnUFRN?=
 =?utf-8?B?RlJveUVac1VpMjQ5QnZtTFJGQnB0MVVzYXdlOHRZRzZLTVVVeVgwNDBTbExH?=
 =?utf-8?B?bW83RFdJNUhQNjVDazVxR3pJVmp2czlrYzRpdHJGcWQrSlBvN0JldlZON1Iy?=
 =?utf-8?B?aXFsKzk3c1UxMUdvalN2bVIrMlh2Tnp1ODJQU0MyRHJBc3VLYXpYSEpqR3Nz?=
 =?utf-8?B?T1ljUXVrTGk5Q1pnSnNqVDNXSFJubFIxK2pTem04VUJvK1B6MXNUZkVheGU2?=
 =?utf-8?B?WEk1YzhNRzJ2cVRlSGlQb1RqY01GZjY0SzVUbUhQRlVDenRaWDhKWmFQUTRj?=
 =?utf-8?B?clVNdTl4MytteFVIVVZNUWpxZFVPbFR5ak9wNDB0cU9XSjNhYWYzeDVXV3ZB?=
 =?utf-8?B?VEU0K0tMSkE5WFNUYjhGUXd5bDZYYW96MVBJSmR0Zk5qNWlkY1Y2R2VZMzlq?=
 =?utf-8?B?MU5DL0l2UHF3UFpwUllldTVKWlpvTlBWYzZTZTJ0WGxuRXQ1V3JkTlk0YkNQ?=
 =?utf-8?B?azhmQ01IRXFtUytBbWk5aGNmMjFEUU5hOGhBUUpiSFg2SVJ1b0pCOTV6WGUw?=
 =?utf-8?B?ejBqaWJLTVhySzhUc2xONEErMW1qMVordXV0QmxvVnBUYnVvV0VST1BaTXQ2?=
 =?utf-8?B?cHFLcDhBNnoycDhweTNRb3JhcktvbmJvNTF0YnVaYXhXYWtxTEMvYTFqcHF5?=
 =?utf-8?B?eUVwZ2pIMThKNHZMY2tVK1l3bk43RUpzWDJQL1YxRVFKVmZzRGxkaUxnemhU?=
 =?utf-8?B?TC9jWm8zQVBlOXlTOEZLbENUUEMxZjEzS3o2TUpreXJEbGJtZzhydHU5bVdt?=
 =?utf-8?B?TmVybDJUVTM1SnJLRnk2eGJmU1EzUmkvTGhtamVHVFIxSmswK05ZU0FUNkpI?=
 =?utf-8?B?QW1DRVJ6SVV4NzdrQy9ZZVdwbVlmSU5kbVNJK0ZmZ0VrdFRPWEZwVnd5VStn?=
 =?utf-8?B?Z2NkRUI2YjBJQTdCbzZCdzdJQ2NSWGVra0Y1RnN6MjdRZFhiRXdPR2E2WXIv?=
 =?utf-8?B?K214RHZVd2tMNnU1MTRNUDdMSGN4ckd5MnlUcVRGbjFTOURVenlsK1Nvb0sv?=
 =?utf-8?B?YU9JOGZYSE9Ld0tpZWw0NWMvK1oxUVJvTXFJUEZtdWVobWxiTU1yeWF6ODJO?=
 =?utf-8?B?VzNkNnBVRUZlUFdGeVBmaG95bm8zRE1uM2tCWXAxS0cwTXVIanhIaWJVbG9L?=
 =?utf-8?B?WW4wYS8rb1YwUjlxV2o5VWIwYUVXZGN5Q3JxQ0V0YnY3T25lU0RlQXB1RnZm?=
 =?utf-8?B?aFpHS3JEakZaRTlieTk4SGFnUGtEdVBMcjFFV2k1ejVTUDcyVDJ1S1ZxNGFp?=
 =?utf-8?B?aFVzM0Y2c0JPMHM0SFZ5dTJ3aU5NclMyZFZIQ0xkRStZTzFyOWQ2ckFDdGtp?=
 =?utf-8?B?ZVJTTlR2Z3RxK1RxdVVVaUZ6TkRmT2QvZ3dmaFdiaHI0N01qdkVLU0RlYzJC?=
 =?utf-8?B?MjFIMjBIQUw1VTJlaUVzLzRVUnZNWjR1cWJSQTBuR1JrNUsyUEZucEhCMFl1?=
 =?utf-8?B?UTRPMTZHb0lwVGdpZ21nQWJRazZseFVZaFlxQ0V6QzRLYlVvb1EyVlBDeEht?=
 =?utf-8?B?QytYVUVGY0cwQ09QVi9kaEd4bEtDK2FBbm5kTGZ2RE9jWGJTYURKVzdXa2Iv?=
 =?utf-8?B?ODZWNmFLL2NiQzQyRU0wZEdaRUU3dkQ4b29zbnlUdGxBTnlrbzgxcTExdnpF?=
 =?utf-8?B?b0J3L2ZTeElSbFZNMkFCbGFiejkrcjFwb0xhUUlzWStyUUp2bzZRdFlHV1Fk?=
 =?utf-8?B?M1VlNzRVQzNPRHRxNnlsME93cmJ3c2pQc251WWh0NGF3Rzd3SVlrNWs3OW01?=
 =?utf-8?B?NzB3THdYTmxLSkpPNWp0dHkvYnJuanhNM3N3RHVHdjJjTTNnTWpMYmtTSzhr?=
 =?utf-8?B?bXE4Qk5BdHpNb2JmWWJXOEl1U1FYOGVwT1pXRWlObzNQR0t4Ui8zS09GQnBn?=
 =?utf-8?B?WW9ZbkIxTXpWR1d0RVozNFUxZ0I4SWh4S2ZJcDJvVUFaZGtkQWk2NkRFVHMz?=
 =?utf-8?B?SVZIS3hQQTBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFQ5RFFySHBkMWhpWnBHams5L3Jaa3pQQlIwK1FpcDJJUjYvL1ZFcVQ1R21t?=
 =?utf-8?B?dXI0RTVPUlpIaURPdkJnckZyWW9wejlLTDJZclJEa2pkbmtnczZFdHUxQ3FB?=
 =?utf-8?B?MEhqRU55UzFpYjNhcFZBVkluVGowRjZldGlQQlVobFhZOERmcFNTazcyVE9j?=
 =?utf-8?B?dE5MSFphT2plWFBTK3lQaW96RHcyTnRvNU5RQzYvZXZ5VG54ajJ2MCtlblRt?=
 =?utf-8?B?Q2prY0dvbzRvYnkrWCtBVStvNFJkV0JiUS9zUnAyZE5wcjVmS1dDS2g3djlC?=
 =?utf-8?B?REd3Rk9RSWVCVTIwU1luUklWWm5scXh4dTl4My95bGN5R3Uxb21OeXNBamw2?=
 =?utf-8?B?RXVod1BRbFBDako5N1hTVzd1UjVGUFFVWVZRdFZrZ0poNDMvSXoyY2xDQ3BN?=
 =?utf-8?B?YXZYeTZZVTMwTGpOSVVxVDQ5bzk3OCs0VTZmOFZVSzlBanJ5dXhTbkpaeEs3?=
 =?utf-8?B?YTJmNVhacVROM0dLTytQeHJZTExwV3J2L0lVQ0FsQXEvUEJhOHhWMFBOeTRT?=
 =?utf-8?B?Z2RQMzlkWXNUc2hmL0VQVHl4bUEzZGVQQTZkSGgyb1BjUThzT25Cc3BTeEp0?=
 =?utf-8?B?WkRyY1Zua0hwdCtXcjVkUjJ5WFkxUHhWUS9qTWc3SFRaVmp2aUZuN0QwRUds?=
 =?utf-8?B?dzd3Snh4YThTalV0UlJta3JCalI1dkFVdkZ3NFJmalVHQm9zNFlQRU9adHo1?=
 =?utf-8?B?SkgyNnBqYkhFUU5ibnlVbU5wUDVDbWhNYW55TTlQTHluYzlUaHRuL1I2NmJk?=
 =?utf-8?B?Q3hUZjhBZ1lydHpNczhkWDMraUs3ZEFGcnJzdHB5NjYyMVBnRlUrc3V2ZkxI?=
 =?utf-8?B?TFlaVlg4bHBzRkoxejc3UDBpSllTQW1qczJRU1JKNDRqdTN0MVQ2b2N0WXpm?=
 =?utf-8?B?Ulc1RTV3SVV0ZDJGVERLcEZUczQ4WWE5TnR0aXkwU2g2WUN4c011UEpObDFU?=
 =?utf-8?B?R3FPRis0WWt5cTFmYTlxQ0dHYWtKRE5PYW5MQkNqK0tVc2dvS2tPUXByZnpI?=
 =?utf-8?B?cmZiOFd3eWtMOTZFYk9oaFd0MnJoeTc1cmJRSnVnbzZNdUJCZjNrUUhpVVor?=
 =?utf-8?B?K2l3cERZbG1SbmJsa1dDOHljRXVJQUJuKzhod2x0eGE0VFdJUXVxSzh4OVov?=
 =?utf-8?B?Z0JsLyszM1M3Vm9pczUweFhNQ1BZeW9QYTNPWWhDNEhFNHdGT0FGUDFzUnIv?=
 =?utf-8?B?dUtqMFkwUXRNZHFEVG92RkdlL3R3d2UxK0ptdU1mNDEyRkE4ZGFiMTRwMHl1?=
 =?utf-8?B?ZS9tak0xMmhISGhWQlMwQzJ2Qm4yWnhoUGd1OS81Q0J6bXBpRVF6ZituYlhY?=
 =?utf-8?B?cnp3elc5cDAweVF1R3REUHVpV2tXRHUwN2dqUXlUM080blk5WlI5ZEF2Qkth?=
 =?utf-8?B?RG00UngyY1c4VXFhSDFMVlVQYkR1Wm0xM3ZNeG84ZHlvZnpKajI2WWRGbDJ5?=
 =?utf-8?B?cVk4UFBWRjQ2QW1qN3RwTDNlUUxUWHgyU1JwYWJiSklOWEN2MXYrL3N0bGUv?=
 =?utf-8?B?NXJ4bkJ5ZWtLSHlRbE5yRkFpM1lhd2VtVC9teU5yMjZJMlErcncxd3YwT28w?=
 =?utf-8?B?Yk9PNVNBdndjTkd0Wk5rcHlaSmNYQldVblFLR2JTVHE0RnNCcmJIZWhSNjl5?=
 =?utf-8?B?NWhhWVBTVEZaeVNzMVB4TFpFWitzUlFvZ3RTZHdwWGNQYjRoU1dvbmwyT2lP?=
 =?utf-8?B?K2tCVFhSdWJWdHlqNWt5MiszWDBEbmwvQzlvOVN0Y1NJVG5ZcFV5LzQ3c2sz?=
 =?utf-8?B?ZGVRRGs2S1JPamlCTGZSdVJjVEFLNEFrOC9oWkl2cUsxaWlnbklRQkk4SnI1?=
 =?utf-8?B?VVBLWUVPSi9Tdkh6WVBaVU9UQ1UvZnl4SWpjbzA0SnZDM0FxVUltSGk3bXdL?=
 =?utf-8?B?eGdjN1ZqK3BSbk5yWXc1WEM4UFlqQmhhNkZlSCtNVmRXS2FoVWgwRVU4WnU0?=
 =?utf-8?B?RWxJVzhQWGhLdTVxbUlodTNRc3dlb0pPRVR4cTY1NDhvOXhtc2tUUDJ3U3FZ?=
 =?utf-8?B?OTRaejJuL1JEcWJOc3dPNHg3MEN6ZFU1dmFjWDRibWZwMXhhZ2lnVm5SVi9V?=
 =?utf-8?B?dVBOeGdOWmF3SndvYzlvL2ZYVlN3N2ZIZm9MekU0WkFWRUFIQ1p1V3hrSDdL?=
 =?utf-8?Q?157zXOZDh6Sn0iRWAf8+9BXz6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4a5952-119a-4899-4866-08dd993c2be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 14:23:07.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uB8oBawZNT32aDA8NRv70/xMF3xYWo1n7vvKcrBNyXQBwH3XH5ZIv5eecCV5+o1dP1n17ley2PMptENqTch7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDIgTWF5IDIwMjUgMDQ6MjQNCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+OyBuZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+DQo+
IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEt1Ymlhaywg
TWljaGFsIDxtaWNoYWwua3ViaWFrQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtvbGFjaW5za2ksIEthcm9sIDxrYXJvbC5r
b2xhY2luc2tpQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0
c3plbEBpbnRlbC5jb20+OyBPbGVjaCwgTWlsZW5hIDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPjsg
UGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU3ViamVjdDogW0ludGVsLXdp
cmVkLWxhbl0gW1BBVENIIHY0IDA2LzE1XSBpY2U6IGFkZCBUU1BMTCBsb2cgY29uZmlnIGhlbHBl
cg0KPg0KPiBGcm9tOiBLYXJvbCBLb2xhY2luc2tpIDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNv
bT4NCj4NCj4gQWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRvIHByaW50IG5ldy9jdXJyZW50IFRTUExM
IGNvbmZpZy4gVGhpcyBoZWxwcyBhdm9pZCB1bm5lY2Vzc2FyeSBjYXN0cyBmcm9tIHU4IHRvIGVu
dW1zLg0KPg0KPiBSZXZpZXdlZC1ieTogTWljaGFsIEt1YmlhayA8bWljaGFsLmt1Ymlha0BpbnRl
bC5jb20+DQo+IFJldmlld2VkLWJ5OiBNaWxlbmEgT2xlY2ggPG1pbGVuYS5vbGVjaEBpbnRlbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEthcm9sIEtvbGFjaW5za2kgPGthcm9sLmtvbGFjaW5za2lA
aW50ZWwuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV90
c3BsbC5jIHwgNTQgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFu
Z2VkLCAzMCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4NCg0KVGVzdGVkLWJ5OiBS
aW5pdGhhIFMgPHN4LnJpbml0aGFAaW50ZWwuY29tPiAoQSBDb250aW5nZW50IHdvcmtlciBhdCBJ
bnRlbCkNCg==

