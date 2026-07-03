Return-Path: <netdev+bounces-304553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IkL7K+O4R2qmeAAAu9opvQ
	(envelope-from <netdev+bounces-304553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A828702DB4
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:28:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="AjeW/8Pe";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304553-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304553-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC2230EF2BE
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171B3D7D93;
	Fri,  3 Jul 2026 13:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9B3D566B;
	Fri,  3 Jul 2026 13:18:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084688; cv=fail; b=WRKvXVKuJyNJklzQn80n+gCxUKWmNanRnGaGAj8S3yfZHcYos0e2PYORADmmrFrBri+zzLW0BfdJ0HRXQvh2eLSyHwrN5z2ZzxKrOQeiwxu3zj0kY31HypQzCDGruWVmFuW8Rdz/RJ4ffh3E5FmYkQUrMPzcf5Fe2Wzmg4s6SsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084688; c=relaxed/simple;
	bh=B+7YHBHOGnVytoW7Dy9MjQotbFFKT1/XNKz7zKpkXiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOFpLK3NbQY3qEHjsjgBaHGuSkRFUYNCDBVbIhbR494IB2xNWY5B8ywoX8Hf5fz3Woy3AIOMM8dwR8k1/hgejmY7IP6bJZ1Rkm+bc/tobLW1B6s37dB5MikxcEl0FrV6xst7uffrxUFLTCirgKuGAmcFv9pYM8uobjx5AbXJ3fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjeW/8Pe; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084687; x=1814620687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B+7YHBHOGnVytoW7Dy9MjQotbFFKT1/XNKz7zKpkXiA=;
  b=AjeW/8PeyZtKE2Ix0zHnA2XNibhFA/oliiUsCZdn9bDse2o7oc817Qlh
   ZqfRBGIhVewm/FrN6A8qorwCQirE+aiL/5nKEiheHkBNN/hRs7RxaxNor
   6R/vPEypqCsb9VnWhlReyrhbGLO1H9guyHATi5fmWFnyjsm/P687WLxtL
   0iNPMXxmvqIE8o5qq33sOLuG74ndxz+ushIgf4Powb7oX2wxXSrxeqGRA
   CG1EHg9e1qG0R7/PEmkreTS9y9R3PW2oKUUfdloOg999WGHQXdylprrBn
   Uq0UJhED2qUNNoKXa5lpiz9YQtISQ5MDZ8Uhi+N0BVVEPHiRvydhbEzmT
   A==;
X-CSE-ConnectionGUID: rkH0QQDrTq2cXj2LTv3nKg==
X-CSE-MsgGUID: 4EAUhc7WTFOjDQPRmmwjGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="82825683"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82825683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:18:06 -0700
X-CSE-ConnectionGUID: SwWk4eTRR1G/S/u3QBWjew==
X-CSE-MsgGUID: ppujfMieR+eKqDIUdVh+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="251393800"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:18:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:18:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:18:04 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVNPuSFpb4snGNO60hzH+0Qwo+SwU+Z+KpyfKp7DPVrVXAvbCd8C4UW+2NnY4eGlFlzN4yfJ3f5U/mfFFbMv3CUG3aumOs4BHqsRUlKYnIF9JyENuUdirmvMQaYM7r9Gakuzb4+aTZdWCAWg4hKzq5R9DuRszgutw2YK46G3XJLky1chELfIv4e2Wno/zOszZA0QoED20Ujp2Y8odmUHvn0Y6m7Cu6/qtPEFITRJ5dBEP1dcIwQxw/HHo+VT1vTrDJ4sXqenIG/2xD3JKti2/nKGV+Um3GUANJ0LWpdMs4Y7rhof2RxLDyjm5Xkm2QyNwXHgQLzlzgbkHRKEbVntHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+7YHBHOGnVytoW7Dy9MjQotbFFKT1/XNKz7zKpkXiA=;
 b=o571FIiIkrCYMtiqkSlNFGAgKEuOYT6ktnIQKr2q2GFCpPOOTIF22sRuRX6gHKpVOTn82KuC7Y3635BBhDGKhLolzKs3Ov8gvolu8nyy9r1o69fvDHZxTuBrfRZZnQg45k/Fe7DnI6ihMqMUxv+yy4MLMfyxChG8E2t6JhXOT8A5U/N9VcyUNQn2Y01VRlEGgvUDfBdA1fVU71S41WZX8a5I/Qzjv/C4oQJt1neROmp9oZrH5h52zLt2DbRl3Cp7kZ5tdWI6VyHUKAu4Z4tMdQQgVsZcdZM5sF0q7zjKZFa+VgfsgztQvf+GArRMbLSDyBUYFUjUFRWsDYuq4knL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by CY5PR11MB6389.namprd11.prod.outlook.com (2603:10b6:930:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 3 Jul
 2026 13:17:59 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:17:59 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 05/17] net: dsa: mv88e6xxx: Add conduit state
 change handler
Thread-Topic: [PATCH net-next 05/17] net: dsa: mv88e6xxx: Add conduit state
 change handler
Thread-Index: AQHdCsDRhhBkftfF1EmW+CBYaMspCbZbxK0Q
Date: Fri, 3 Jul 2026 13:17:59 +0000
Message-ID: <PH0PR11MB59027C0E7F3C9B01C9FE76CDF0F42@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-5-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-5-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|CY5PR11MB6389:EE_
x-ms-office365-filtering-correlation-id: 0b52c74e-1676-4398-fd63-08ded9058111
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006|921020|6133799003;
x-microsoft-antispam-message-info: P4ruCSYlZKnIGMYnelQTrbymIRmH1W/PXn1/BCss61rFHjlZQSAbiizWD7iDP7uTCEIwl4KdU4CuB3LYl1h2IPJNX99TX7zXAj/pQxK4l4AFDK0vZCUXGpgrQcIr9X4mMpnTl2dlwoeXTl4lwa0Ow4zoRWZQbEzBWl2/A5okrv5KoQaAFV2FUZS+pb6kySnXwsAS78h1TYoPTxqTJLeiOQPEQEI7NxWs4jQIzBbrobzH2m2Kye/PNQEOyYa68L9MYjMkuXbcUuipImPN0R1NfF9iwgyP+MZVONiHZmZNJP1NPtpqw9/LBC8NB23DFHLWAvL+KVYv1unJTc20a5Ohp6h/Kbi4yKKnJ7k5/80TCu8V93811XgxMqsHNYxqT49oYHGUNR/IKUgar/qwsyzL2tC7CYhxtvLuXtT+qmH1Z4eoo+YVkNPUxVB8YAq5L5MmvgwxicqC6ZOsyUIwm608uzeR5KIn42nOqEXmitENIr5JOujEf9OjC+Kay7Xzc66RY5KjjuOe3q/CEgH8gXFM7iTlPVw0qCR/vZnhgZX5r52oCRYCvRnhTm5gCEGxZr01DdOIYA/HhD+I4q8EguOyeiHS0+fh8SUDL6BKRm/BcmoCZM6nsCqvobROem7s6387+j8G86UC5JULwHOfA7y/5VspQIksAJGKICkUL+9KCkLkZdYqwG8SnapKZkE3sGdzgfq6NjwSYGm5W4X+q0QJpGkG6sTeqZQBTCn1s+/CugrWqNkSvG/yGw86kWdaeUmc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(921020)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWJwd2ZxU0ZzK3lqRzV0THg4bWE5S3lqdkVYUU5OSnY3YllSMzV0YXdCczRE?=
 =?utf-8?B?UXNKeTYrY0ZKbnZhbEgvZ0haVGVtT2lXbVNWQWt1SlhxQjlMY0pFS0xvTzJk?=
 =?utf-8?B?ZWNFUndNdHFWVk85M01pOXVGK01PZnpXWmhUYlFmT0xHSFoxMlhNT3ZZTkRh?=
 =?utf-8?B?dFZyNXU5aDhaZGZoVDhrdGZndmF6eXlXU2lSME9zM2M2MmVuNDNNSjhYM01F?=
 =?utf-8?B?VGFxVFBRMmFvb3g4bFA1UTNzTXROaFNkOUwvak5sQ2wwRDF0ZEs1MzJhM3Zu?=
 =?utf-8?B?MDk4b3lZWmFBKzVhZjlSd29vMUVLbzJjWkN4WDN5RWN2bUtxZDRzMTBhZzVI?=
 =?utf-8?B?L2tKVS9SVXhVQlo1RTFiU0VYRTFmb3htMkYyb25nUk5zSlR6aG85dTZ5ZEo1?=
 =?utf-8?B?N1k2TGF5dWh3bGJUc3pOOWVQc0x4L0MwckpMZlJXcXNMTWU3OFBuRWRjdlBD?=
 =?utf-8?B?akZHdmZKeWVJUkFDM0RCNVROdFE1WXlDNjR2ZFA1Tk82Qm9WVE8xNkhlVmFh?=
 =?utf-8?B?REMwYWh1d2htTkFnYkJPd01ja2xkQmEyQ1d1SjltdHd5bDRyYVJzRCtGSXRE?=
 =?utf-8?B?ZFZYT1hCTGdOcm5ldGhTckRhU2JwSjhsZUdySXlKRDdzU0JmQ09DdHJIUG4x?=
 =?utf-8?B?a3Y1a0ZteUZyZDJSUCs5SXdzcDZFUVNJd3R3YUtTTUJtM0VNYTB5UlZzdGsz?=
 =?utf-8?B?SGRaQWEyejNBRGkxR2VyaDBpMmxCVGZZNXBIcWxrdEtPOFhhb01OMzRaUHhm?=
 =?utf-8?B?VVkyZk44NitTNDJmR1lVMWEzUWpvbmx1bEVQNTh1RDBKQXllOWFwUU1pNlAz?=
 =?utf-8?B?dWF4Q3hpb0R3UFNTWmpPTHg2WURwUStzSmdDZjAvbDRxT21EV2FvRHdWTHdL?=
 =?utf-8?B?bUlsS2VoTkFJUSthcjBGN0tEQ2tMcDluY1hrcGEzVkdBYnZkdlozTS90M3pP?=
 =?utf-8?B?clZsVmpXMTE3NjhkczBKNHhuS1M1QWdCU2ozTGRXVTdlbk5rUGtqU0NHT3lt?=
 =?utf-8?B?cFlEQTNnbUVlUlE3elVnazFsY1ZFN09QMVI5ZFovdS8velhzZ2t6WENTbHM1?=
 =?utf-8?B?UXRMeXM2MDhiYmgxWWJGZEs5aWR2YWU5THNuTnhxRW1vbzlRMFFHdGRBUFIr?=
 =?utf-8?B?QjRidUVsYkJ1eWNFNVFobVVMNStsVVZZOGcrUkI5cGQ4SFRUK0VMLzhQUVpM?=
 =?utf-8?B?b1BwT0lZMEpsTG4xLzB0UUljRTNIT1RmcmR5bTdyT0x6Z3gzeW5MRGhJTC9U?=
 =?utf-8?B?SkRlM3ovVDVmV3NJVUE3NVIxejJZSlNHUmYwbHBmMXRCSkdWSXdqdXBHbDhm?=
 =?utf-8?B?ekxtNVlpdHF0T1RGYjJ2WTI5U0lFQU1VSTJsdkhIN3BEU2Y0eGVhejh5T0tC?=
 =?utf-8?B?dmFXem1Wa1BFei9ybUkzUDRlVU83MGFDeSs4REZBZ2oxbUMveExQYVJkQ3Zy?=
 =?utf-8?B?MGNvaVg0d1RPektkUXcwbXFUaGI2Q2UzbjhaY3JwV3BRQXNWYlNDaWl5L3kw?=
 =?utf-8?B?MkY4UnJoSjk3d3VIR2JaRUZsVUVlVTNTb21xMXdXN3hOOUlqTGJmK2FBRWgz?=
 =?utf-8?B?TnRuampTWC9XV3lYbFBpNVpvREFFUXRreGZsM05RWlpnTkpISkRsNDAzaHBs?=
 =?utf-8?B?Zlo4Y04yVGt4UVBGVkRHYnlnZmtPYWc1d0ZZcm5XRGJVbi83OCtWYm1NVXB0?=
 =?utf-8?B?Rnh3YUVySHkzSG1kVTNoY2dFV1Q3TDdiZDJ5MlREMEpNbTZoclJWZ1EybzNa?=
 =?utf-8?B?eXhiT1Q5SjlsVUhuaVpDeEh3OWJYRzAzZnZ0blYyTGhZL0ZmSTN4VHF5Y2Jw?=
 =?utf-8?B?M1g1YkZCeXNxbGRmMnZjTUY1d2hvTHlIY2QxWHQvdWtaOWZYYmRBZmxONUFU?=
 =?utf-8?B?WmpLZSs2NXptUGhMZllXWDE2RXI4NERmeVg4aUlLM3I1VXNoTTBDbU5QMkor?=
 =?utf-8?B?aWIrVUk3REFWdDlNMnIyOTRJMUcwNHlSeFdGdUlML25NZzBJTmc3eDdWS2x2?=
 =?utf-8?B?eXRpOFdpR0taMU1PSTh5UEtYNGcvWUQ2TG9xK24raG52dSs1OWFQdXFjZTI4?=
 =?utf-8?B?eklyY3d6R0RtZDErMTRuYmFiRVRVb1YwOXdZR3hpUW5hSmd1MjJFZVZyVE9j?=
 =?utf-8?B?dGNYSDVQZ3FJWG9TV3NHVnpnUkkzNGdKL1djU0FFMUl1cGxSNmF2WUozTTBu?=
 =?utf-8?B?U1kzNzlqalh6cS93bm9wa2VhZCtLVExMOTczSUMrMHo0S2kyVDMzOEdTMXVH?=
 =?utf-8?B?cjJ6WHQxb3RWVmJyeGhDVnE1QUQ0ZlJNaG44UnV6VEVvR2IxMkhOZCttM0Rv?=
 =?utf-8?B?T2ZxQk1UYmFkUEZVY3ZycU9SU0xCNVBQazZFbmNVTHh0V3IrdTlDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gnSdx2rdrBs0UeyM5K57rQQOGxeo0HZ2nsfBOAsOjF8UoJudimccs/BnrW4VprI74vUoq4lXw02SAJ124pVLBkJb3+JifTS8Asx9EfCzlzmlncBRqe5JvrcMlNDOLN4OGD1hDBEwJ73HUaJGJvGbj23BQVsAcL8DM7OoKON4Yzm4PNpGzKwJXz3vygmhru3hWnVDuewBlIn32MhQ3Uva2ZVLpJYLRJ3MAfRVu6utnPfPHW9oCuqH44g22OMl/iGYxpi+4As/afiP+xkhyute6Q9HVbn5Hnfl5JlZeh3s4WZUzQVkChSWkcoXD+P6EQCIzZBW+vFEH30Z+65O+vnYLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b52c74e-1676-4398-fd63-08ded9058111
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:17:59.6496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raZJ8/cT8lqQB2T8b35DT5w+gdFTrWgSHU4zMmscPWmuSbJUZ8/8I0R0lnuhph9Et9hBaHciYXL038f/lV/iR1K1yb+T3L0dGwMcrHsB0hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6389
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304553-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,PH0PR11MB5902.namprd11.prod.outlook.com:mid,lunn.ch:email,intel.com:from_mime,intel.com:dkim,padl.com:email];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A828702DB4

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCg0KPkZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4N
Cj5XaGVuIHRoZSBjb25kdWl0IGludGVyZmFjZSBjb21lcyB1cCwgdHJ5IHRvIGVuYWJsZSB0aGUg
Uk1VLiAgRmFpbGluZyB0bw0KPmVuYWJsZSB0aGUgcmVtb3RlIG1hbmFnZW1lbnQgdW5pdCBpcyBu
b3QgZmF0YWwsIG5vdCBhbGwgY2hpcHMgc3VwcG9ydA0KPml0LCBhbmQgc29tZSBib2FyZHMgaGF2
ZSBjaGlwcyB3aGljaCBkbyBzdXBwb3J0IFJNVSwgYnV0IHdpdGggd3JvbmcNCj5wb3J0IGlzIGNv
bm5lY3RlZCB0byB0aGUgQ1BVLg0KPg0KPldoZW4gdGhlIGNvbmR1aXQgaW50ZXJmYWNlIGdvZXMg
ZG93biwgZGlzYWJsZSB0aGUgUk1VLg0KPg0KPktlZXAgdHJhY2sgb2YgdGhlIGNvbmR1aXQgaW50
ZXJmYWNlLCBzbyB0aGF0IFJNVSBmcmFtZXMgY2FuIGJlIHNlbnQgdG8NCj5pdC4NCj4NCj5Dby1k
ZXZlbG9wZWQ6IE1hdHRpYXMgRm9yc2JsYWQgPG1hdHRpYXMuZm9yc2JsYWRAZ21haWwuY29tPg0K
PlNpZ25lZC1vZmYtYnk6IE1hdHRpYXMgRm9yc2JsYWQgPG1hdHRpYXMuZm9yc2JsYWRAZ21haWwu
Y29tPg0KPlNpZ25lZC1vZmYtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCg0KLi4u
DQoNCj4rKysgYi9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L3JtdS5jDQo+QEAgLTAsMCArMSw1
MCBAQA0KPisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPisv
Kg0KPisgKiBNYXJ2ZWxsIDg4RTZ4eHggU3dpdGNoIFJlbW90ZSBNYW5hZ2VtZW50IFVuaXQgU3Vw
cG9ydA0KPisgKg0KPisgKiBDb3B5cmlnaHQgKGMpIDIwMjIgTWF0dGlhcyBGb3JzYmxhZCA8bWF0
dGlhcy5mb3JzYmxhZEBnbWFpbC5jb20+DQoNCnNob3VsZG4ndCBwcmVzZW50IHllYXIgYmUgcHV0
IGhlcmU/DQoNCj4rICoNCj4rICovDQo+Kw0KPisjaW5jbHVkZSA8bmV0L2RzYS5oPg0KPisjaW5j
bHVkZSAiY2hpcC5oIg0KPisjaW5jbHVkZSAiZ2xvYmFsMS5oIg0KPisjaW5jbHVkZSAicm11Lmgi
DQo+Kw0KPit2b2lkIG12ODhlNnh4eF9ybXVfY29uZHVpdF9zdGF0ZV9jaGFuZ2Uoc3RydWN0IGRz
YV9zd2l0Y2ggKmRzLA0KPisJCQkJCWNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlICpjb25kdWl0LA0K
PisJCQkJCWJvb2wgb3BlcmF0aW9uYWwpDQo+K3sNCj4rCXN0cnVjdCBkc2FfcG9ydCAqY3B1X2Rw
ID0gY29uZHVpdC0+ZHNhX3B0cjsNCj4rCXN0cnVjdCBtdjg4ZTZ4eHhfY2hpcCAqY2hpcCA9IGRz
LT5wcml2Ow0KPisJaW50IHBvcnQ7DQo+KwlpbnQgcmV0Ow0KDQpjb3VsZCBiZSBzcXVhc2hlZA0K
DQo+Kw0KPisJcG9ydCA9IGRzYV90b3dhcmRzX3BvcnQoZHMsIGNwdV9kcC0+ZHMtPmluZGV4LCBj
cHVfZHAtPmluZGV4KTsNCj4rDQo+Kwltdjg4ZTZ4eHhfcmVnX2xvY2soY2hpcCk7DQo+Kw0KPisJ
aWYgKG9wZXJhdGlvbmFsICYmIGNoaXAtPmluZm8tPm9wcy0+cm11X2VuYWJsZSkgew0KPisJCXJl
dCA9IGNoaXAtPmluZm8tPm9wcy0+cm11X2VuYWJsZShjaGlwLCBwb3J0KTsNCj4rCQlpZiAocmV0
ID09IC1FT1BOT1RTVVBQKSB7DQo+KwkJCWRldl9pbmZvKGNoaXAtPmRldiwgIlJNVTogbm90IHVz
YWJsZSBvbiB0aGlzIGJvYXJkIik7DQoNCmRvIHRoaXMgY2FzZSByZWFsbHkgbmVlZHMgdG8gYmUg
dHJlYXRlZCBkaWZmZXJlbnQgd2F5IGlmIHRoZSBnZW5lcmFsDQpjYXNlIGFscmVhZHkgcHJpbnRz
IGVycm9yIGNvZGU/DQoNCj4rCQkJZ290byBvdXQ7DQo+KwkJfSBlbHNlIGlmIChyZXQgPCAwKSB7
DQo+KwkJCWRldl9lcnIoY2hpcC0+ZGV2LCAiUk1VOiB1bmFibGUgdG8gZW5hYmxlIG9uIHBvcnQg
JWQgJXBlIiwNCj4rCQkJCXBvcnQsIEVSUl9QVFIocmV0KSk7DQo+KwkJCWdvdG8gb3V0Ow0KPisJ
CX0NCj4rDQo+KwkJV1JJVEVfT05DRShjaGlwLT5ybXVfY29uZHVpdCwgKHN0cnVjdCBuZXRfZGV2
aWNlICopY29uZHVpdCk7DQo+Kw0KPisJCWRldl9kYmcoY2hpcC0+ZGV2LCAiUk1VOiBFbmFibGVk
IG9uIHBvcnQgJWQiLCBwb3J0KTsNCj4rCX0gZWxzZSB7DQo+KwkJaWYgKGNoaXAtPmluZm8tPm9w
cy0+cm11X2Rpc2FibGUpDQo+KwkJCWNoaXAtPmluZm8tPm9wcy0+cm11X2Rpc2FibGUoY2hpcCk7
DQo+Kw0KPisJCVdSSVRFX09OQ0UoY2hpcC0+cm11X2NvbmR1aXQsIE5VTEwpOw0KPisJfQ0KPisN
Cj4rb3V0Og0KPisJbXY4OGU2eHh4X3JlZ191bmxvY2soY2hpcCk7DQo+K30NCj5kaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9ybXUuaCBiL2RyaXZlcnMvbmV0L2RzYS9tdjg4
ZTZ4eHgvcm11LmgNCj5uZXcgZmlsZSBtb2RlIDEwMDY0NA0KPmluZGV4IDAwMDAwMDAwMDAwMDAu
LjcxYzRmYzFkNDExM2YNCj4tLS0gL2Rldi9udWxsDQo+KysrIGIvZHJpdmVycy9uZXQvZHNhL212
ODhlNnh4eC9ybXUuaA0KPkBAIC0wLDAgKzEsMTUgQEANCj4rLyogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjArICovDQo+Ky8qDQo+KyAqIE1hcnZlbGwgODhFNnh4eCBTd2l0Y2ggUmVt
b3RlIE1hbmFnZW1lbnQgVW5pdCBTdXBwb3J0DQo+KyAqDQo+KyAqIENvcHlyaWdodCAoYykgMjAy
MiBNYXR0aWFzIEZvcnNibGFkIDxtYXR0aWFzLmZvcnNibGFkQGdtYWlsLmNvbT4NCj4rICoNCj4r
ICovDQo+Kw0KPisjaWZuZGVmIF9NVjg4RTZYWFhfUk1VX0hfDQo+KyNkZWZpbmUgX01WODhFNlhY
WF9STVVfSF8NCj4rDQo+K3ZvaWQgbXY4OGU2eHh4X3JtdV9jb25kdWl0X3N0YXRlX2NoYW5nZShz
dHJ1Y3QgZHNhX3N3aXRjaCAqZHMsDQo+KwkJCQkJY29uc3Qgc3RydWN0IG5ldF9kZXZpY2UgKmNv
bmR1aXQsDQo+KwkJCQkJYm9vbCBvcGVyYXRpb25hbCk7DQo+KyNlbmRpZiAvKiBfTVY4OEU2WFhY
X1JNVV9IXyAqLw0KPg0KPi0tIA0KPjIuNDMuMA0KDQoNCg==

