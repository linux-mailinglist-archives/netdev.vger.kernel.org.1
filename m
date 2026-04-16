Return-Path: <netdev+bounces-279101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AhRFMYc4WmmpAAAu9opvQ
	(envelope-from <netdev+bounces-279101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:30:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB3412BE0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA4D30BD14F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6C93264E3;
	Thu, 16 Apr 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpHzDsOq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF52325495
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360248; cv=fail; b=q7U4tXaKPs2OwnJUoEH9a4J60Gru+jHU63xgXbDJxuwqvsiJya0NpzHIjeB9Qznz8LxnMZpP5U2oST6ApfNIRl15Vpt1x9CYKe2e1zQj8KfRMbKdAee/RTjvZdxh+s2fSNWCGuoXaguZyGfuroSij62ihS7tABqeu85FsLlR60c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360248; c=relaxed/simple;
	bh=l/Huha/kY4ZcUfuWCDku5ucqIyCGKGk6U0uKJL0DR7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tQk9qRD1DZpokl4jwnNChNvY6w4FZ5B8txUvkFfglHkdMTqKep/zr0dY7PNuyUPnF/ZV9uMtmh2GmkihYd2JPELcWupJ+crTlEyGnaGnpzD7rIWLNahnpLHiBKN2r4oR23/tLY7QpOjJEXlGtI10UdHNCocRmcgI3+9D1ybOXKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpHzDsOq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776360247; x=1807896247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l/Huha/kY4ZcUfuWCDku5ucqIyCGKGk6U0uKJL0DR7o=;
  b=kpHzDsOqDWTHxTBQSDro1qND4VHBmFjAoxo9mpTXHsM0SUBSlSuJWWZ5
   JqTHl9khLCx69NPfVQleZO2NcmBJYot6p6rYDA+cJbwAmDgYll2mFO6aC
   Tu81Et0XViQJTqPnBA2BULpcmMi2/zuMUS/UgweHlhdX0/yll3W2Gm+CH
   M5pojC4gZI3udAJt9J1cZ1sF7qHsKbtfENtvb2NCwenItC2UhQsSDGd4y
   xCRFwnka+LqjgZrvRAWBKKbBPEKHhByFE2Q7QYlh6lGqhLeHWPravjvEr
   Rrbrc6ivzw9QdxaCU/Bvh6WHd76AZDkurD63L8HzZFgUqqlBIRSc7TNyq
   w==;
X-CSE-ConnectionGUID: 3Mmk9LjjTcW6NzZzvbF99g==
X-CSE-MsgGUID: VObAh083TLyf6356umubgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77486187"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77486187"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 10:24:06 -0700
X-CSE-ConnectionGUID: UToqG3iRStOHMt/D9v6XUQ==
X-CSE-MsgGUID: 1pvawah6Q++GTPBT6qdCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="235169439"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 10:24:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 10:24:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 10:24:05 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 10:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6NYHD0FlyjG7B49dPY6fbK8a6oYcp/BrlYAr/EJdHyDup9YJG0AtAa1qKJbw9VMYaspb0LjYCXagSv9zEginp8DZ/999A12LEyGKxksMnczuilf8Gao8WX4i+8/EN0PQosg+3OFj9LO5pi3Ib3qTjlIZw6nhchw5WQx9i7FzA6EU0wYfVMlUs+5O9Hhq5ecE2oD9Fz9eqJuEWAsdxrYL1AJ1mm+/yj8KN8TQKlOck1aryeW/iPUtLCe377pFMeHRWWYj4VNZWy6rWVwe1F+6+Aa8TuO+0BMKUJwFzw3lU8xFORW8xhEg8J6mqCUfRBe4Lnczh6uYfWM3tXaW90wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/Huha/kY4ZcUfuWCDku5ucqIyCGKGk6U0uKJL0DR7o=;
 b=ai5ggq7Q+fbvXfhLhdc7qYDJhORKE1WWsO6R6RfFVr0OuZQwt66gY+4/QV3xjoVkWcOKe5fLnvMHUVgXG+VNTVSjkKyafRZpfjZxqnx8W0NNYywaRDRxFNhwcVKFQy1BWrYrcYTTy9drGj+PiHJrp8xELhV6tS4+Bq+Az73texeaZu6ucLRDAorsBBoLo6bar1wLPgoZJjOLqu2KS0kYFweey9aDUO9fU+fuC9ZzAWAunQYCuxPIQp28/smUUNGXu9q+kFDCx+Bibnq8AVuRzlPlnyJPsMPSucpORr2G/uXyklJ4bSI+9fQrhF9PWNK4lQKPhheaArQhGlNy0OmCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by DS4PPF240F42FB7.namprd11.prod.outlook.com (2603:10b6:f:fc02::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 16 Apr
 2026 17:24:02 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 17:24:02 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 4/4] ice: fix
 ice_ptp_read_tx_hwtstamp_status_eth56g
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 4/4] ice: fix
 ice_ptp_read_tx_hwtstamp_status_eth56g
Thread-Index: AQHcx4gzcpjlKyY080WniJS8Dh5LI7Xh++Pw
Date: Thu, 16 Apr 2026 17:24:02 +0000
Message-ID: <PH0PR11MB752234B07424CB2B3FD4A9DEA0232@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-4-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-4-b959da91a81f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|DS4PPF240F42FB7:EE_
x-ms-office365-filtering-correlation-id: d129a114-5126-4d57-67a7-08de9bdcf3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: GTeQ6c90cUxrVcBH33/zFZSV0JkDwhPMIIXxRpCyJvhlPP6BLQy5euxpmBZuZfXE8R4NoJVGS6GlQNlhuraHhxEYMe2eWKLHJsJvwWU+LJQi5oj9Cu8FbFbYvjwLZB8YdFveXg+lF8LsbRvtGQkNXtdD3jym57YIYYahcXEud/BTPvsBV+2G0a7u5WJ8HwWkFadxAqNdqWTFAYFulgD+ozQsiSgkWegw3UCx0F7ROMiIhTlyZUB4a+D+4aMpI2xrNbvu3fwbrR5I8IFVJNCHtHYwtp4qbJqgTmv8e4Y/v2xC86Zyq1KKV70W0YXf6KRcqm7mDW1ghlWbaaltWx/RSbsGFtz1Gtn6i935/mZ7dRd+jhjCDWuAfkjmGMmtTuJ466Phw/PbG8vHDK6CWKv2TMdiqnJlagnFtj6CEIGm2KioAf8wukCySzWrnIrnsSnk4yjnoTiQlmKeDxtgBskZOIU6g4ioPXi9Vx+dOQatVIQhigHLIkQ390VCqaFLaxrFCMqXLtMPGFV8I1bawFHwXxozwfmZctojIYeOhdmcz6HuCkXoupJkO498GD6qW2yOWHnIJXG5pPn+9RwOVSqS3hxBIHmfCCJyVlPGd0x/Sd7OZcU1vOG2E/uHifgVVZjKyaPoHLCdhwzmenDpNrFlAs+KcuH9MgkSYBzuTPiBwz5UAnqr0s4/lKczVBFHW93a78c9iH6NeooYAdlZ1YGZjXiZQA86dUuzznrUJEr4HYc3mZa7VPC5xJbHoG+Z+Xxv6mh63gcr93ei88acOaOritx0FYTbT2Sn2/cnz5UQXnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHFaOURpS0hrTVNXQ1BQd091UVFLYnQ2Z2tJZUhCeFJ3RVBLMUhhZnBoTnZL?=
 =?utf-8?B?NUNVOWVjd1BnOXB0aGU2aDVRWjJjQ3pzajFSbEdMeXVDMHFQekdxK0xzMjVm?=
 =?utf-8?B?WGt3LzN1YUw0YW50NjFOWkpvUm5OeWJiMXF3b3IzelJKNE4yT3BaNERWQkVm?=
 =?utf-8?B?Rk5QZWkzc2tlWjJ5aSt3VitubjBSRWtGTmw1UjVFSU9jVzNZMEZna1J3YjlW?=
 =?utf-8?B?Q3ArcUw0N3dBZ0J0bVoxbkFIT2tyck1WSjdJSlJmQXFIczVJUTI1YXFqd0cz?=
 =?utf-8?B?ZkJLYlRVdjhUazFEdmtabndkQWJXYTlDVVBJM2xDbW9NM1RZRDhOYU1tL2ll?=
 =?utf-8?B?cHowS3RnV1h0aHNDZXRHUDhZUENXRjFoalBCQW1FQmxoWlFGamhFaWtscWRV?=
 =?utf-8?B?RHZLcE1pLyt1dSszSnA1SXRXSTZIRi9WWlVVbjdWSSt3clA0WVNPZ3NEYjRr?=
 =?utf-8?B?QUNXL0YzTjNwR0Z3clRJaHJZRmJKTGRYazZya0xvSWd5Q0xVSmtnUWFJSE8y?=
 =?utf-8?B?ZU0vdC9HWUhhZUt2emxVeGkwcGQrTG16cHl4M3h3eGx6bEVVNTAzajREU3h4?=
 =?utf-8?B?aFJQZnpqRzZYMnhUN2IrcHJVb3E2NGI5c1ZQREVrRE9uZzlRbEVwK05OYkp6?=
 =?utf-8?B?ZnV0WG5qZ0FWdHZLbHRqOXBDWDgyUll1aVMwSEpYT0NoSDdETG1hWHpsbjlo?=
 =?utf-8?B?dmFhaVhlTEZMSk5hUXd5VjRJVkF3R3Y5ckdxSzVYRVNEVXF2cCszRkU0alhW?=
 =?utf-8?B?SElva01PZTZuYXUxc3pLODRBT2d1d2lUOW1GcElnQ0srYytRWlNYNExBZzV1?=
 =?utf-8?B?QzJHZElaVlRqYzdXTk12MS9QbXI1VXYxR0RMcG5jeVJwdnVuc3ZIRFdzZkRj?=
 =?utf-8?B?cHVFcm0rVTNwUDMvRG5iWU5qQkUyUEFxclpkbFAyWDl2Yi9lSzB0Y2RKRzRC?=
 =?utf-8?B?QWVVODB3Y0F5QkdSRXJFUnlQY0VZLzlGcXNXNmZzdzhKQTBQNlhiN29jR2ht?=
 =?utf-8?B?WVhYWEZ1OEhRT3FRU2xGc1p4eEJqd2huZERBMDBOMUd2dnQ2cVBPNVg5Zm5C?=
 =?utf-8?B?OWlCMUlNMUVyN1RMdHk1RDZ1L0R0WVRacHZyTUFxeC9mTDhOOTlwaTlFeUpL?=
 =?utf-8?B?YlRwbVFDaXZiNDYzY2pqaG5mNkdFV28wNEQwMTVrWEJLdXN4MTBwWGF5L2xT?=
 =?utf-8?B?RDNld25RNXJMVytWSnA4RkRHVlFick1USHpUNERyK0o3NSswN0RnWkFOYzZa?=
 =?utf-8?B?c3ExbWx1YkxRaGJmYisvRGR5UkZkbkVEWDFNY2hNSWVQZnpUQ1QxNFk3eXdY?=
 =?utf-8?B?WjhBNVUvSGtFcTRUN0dsQ251ci9CRHNJM3c5RU1SaVlMdEVtK3dUMStlY01F?=
 =?utf-8?B?cmVpKzNGZWgvNXN3U1IrR0NKeVZybEF2U0swNWpDYmt5aW4zNFBxTU5YWWhI?=
 =?utf-8?B?a0JHNmxCakxIVTkyL29Xay9MSTdnMzBENk9SQm9wWSs3Q2QxSnlpbEp2SlNW?=
 =?utf-8?B?amNqRTkrMUU3M0t1bENhY2xUditEUjMvaHUreE40ZjU5OXJBbm9pdTRTWmJi?=
 =?utf-8?B?UDZ2L2ZXZ2ZsTVZHVjJwTzRUVHpyczNqYkNIRlY1VWp5QUtqbVpReXVLVUZP?=
 =?utf-8?B?SDFkL3JMU0xNbGpsVFZCdjd1VEhCZ3FOaVN6UXNSK3p6cDY2TzlIcDRNd3lB?=
 =?utf-8?B?YWwyYm1pdXAwc3p6U1dFNlNqN0JuZVZsUFFzNHNSVDlJU0F6WmloTHpkS1Rw?=
 =?utf-8?B?WUNkdDkyMUJoQVdORXN0anJMdjhMditBYzhweDRBUXdBdmZoRm5TNU5JeG82?=
 =?utf-8?B?R3M2Nk1yejRCZDU0cEREUkF0RGp3OFk5S21jck9OV3FyNWY1MVAveDNQei9v?=
 =?utf-8?B?em1LUGMxcWttaWM3SmZUbEx1L092elhFNlFUSXE2ajR0RHFlWm1PUG91Vmpk?=
 =?utf-8?B?SXl3OHdOQ05aMXRxckVhdmNmVm9nZkNpTC9IbnVXUlZDak5sR1VCejJLYUpD?=
 =?utf-8?B?VlBrYnNZeGo5MVRVUndOdktvSE85VmJTU3VBcEhRRVJIZDFDai9hZzMvaTl0?=
 =?utf-8?B?UHVDZm0yOC9UNW9XRENDZlF4STFmb0NlbW84dUdPeDErR0J6UC9LdGlKamxz?=
 =?utf-8?B?VnN2ektJNjVHYTIxSUdHR3VDYmZBSDNheHJFSGp1dzFrb1NLM1ZHVzQ5TTBJ?=
 =?utf-8?B?VW4razNoaUcvZTRkQVVzL2NDcHJRZ3d5UFhsWVVRWWI4VENCQ1VDOG1QSSt4?=
 =?utf-8?B?a0F2cE9QbnJtbkErK1hpV0RBT1ZMUXJpbnhhQXVKUllZSVduUXhuWmIxcGVK?=
 =?utf-8?B?aUZldGI5YnJvbVh0QnRYM1lYaFhhckhuc2NCeFlsWFB2eVkvNlpmZ1UzOGdE?=
 =?utf-8?Q?qEAs4jzlSxVRdx08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GTwmsCK/uRDMgVTdPA8M7LTWc2HZFJJcKu80EAxz1tnqbm+0eh80qBH/w5hLgauhi+0MacP1ozlH2y2Mlwg+B+CN1e0yw34pCAO4se84JJm5pqtBUWKEw9FxdZpFTTbXDFUiopBc3RlT/+syBvJoCCuLufo93CyRMZevjlJm4Ek/qs2PKT5Lsn7jZ2hl2HhCCPd69NnrLf5HYtgFx1FwmavyDD3NGiTaTtE6/lWznLfFv+1ZVGAj/uHaPe6gT4tKOQStaOv91synjMiSZjsiNAzkvs/EE8ezm6kmoSI8D+TEmwdSG0ZyCPve1qQXOyT6MP4eS43YJNNRWzsQLHVAxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d129a114-5126-4d57-67a7-08de9bdcf3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 17:24:02.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17Fu0GIiBHgNQcUbYvFiAoJgD48zPSc1zXdGfb9rvcEQn5DQDjnWGvfKI5DUutSTMoweLJmdXqB9iS9jVrB0PxK3zaPeMZ2nYkZfsaftTkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF240F42FB7
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279101-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB7522.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9ACB3412BE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGludGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5v
cmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxsZXINCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCA4
LCAyMDI2IDExOjQ3IEFNDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+OyBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vv
c2wub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogTG9rdGlvbm92LCBBbGVrc2Fu
ZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgS2VsbGVyLCBKYWNvYiBFIDxqYWNv
Yi5lLmtlbGxlckBpbnRlbC5jb20+OyBNaXNrZWxsLCBUaW1vdGh5IDx0aW1vdGh5Lm1pc2tlbGxA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5ldCA0
LzRdIGljZTogZml4IGljZV9wdHBfcmVhZF90eF9od3RzdGFtcF9zdGF0dXNfZXRoNTZnDQo+DQo+
IFRoZSBpY2VfcHRwX3JlYWRfdHhfaHd0c3RhbXBfc3RhdHVzX2V0aDU2ZyBmdW5jdGlvbiBjYWxs
cw0KPiBpY2VfcmVhZF9waHlfZXRoNTZnIHdpdGggYSBQSFkgaW5kZXguIEhvd2V2ZXIgdGhlIGZ1
bmN0aW9uIGFjdHVhbGx5IGV4cGVjdHMNCj4gYSBwb3J0IGluZGV4LiBUaGlzIGNhdXNlcyB0aGUg
ZnVuY3Rpb24gdG8gcmVhZCB0aGUgd3JvbmcgUEhZX1BUUF9JTlRfU1RBVFVTDQo+IHJlZ2lzdGVy
cywgYW5kIGVmZmVjdGl2ZWx5IG1ha2VzIHRoZSBzdGF0dXMgd3JvbmcgZm9yIHRoZSBzZWNvbmQg
c2V0IG9mDQo+IHBvcnRzIGZyb20gNCB0byA3Lg0KPg0KPiBUaGUgaWNlX3JlYWRfcGh5X2V0aDU2
ZyBmdW5jdGlvbiB1c2VzIHRoZSBwcm92aWRlZCBwb3J0IGluZGV4IHRvIGRldGVybWluZQ0KPiB3
aGljaCBQSFkgZGV2aWNlIHRvIHJlYWQuIFdlIGNvdWxkIHJlZmFjdG9yIHRoZSBlbnRpcmUgY2hh
aW4gdG8gdGFrZSBhIFBIWQ0KPiBpbmRleCwgYnV0IHRoaXMgd291bGQgaW1wYWN0IG1hbnkgY29k
ZSBzaXRlcy4gSW5zdGVhZCwgbXVsdGlwbHkgdGhlIFBIWQ0KPiBpbmRleCBieSB0aGUgbnVtYmVy
IG9mIHBvcnRzLCBzbyB0aGF0IHdlIHJlYWQgZnJvbSB0aGUgZmlyc3QgcG9ydCBvZiBlYWNoDQo+
IFBIWS4NCj4NCj4gRml4ZXM6IDdjYWI0NGYxYzM1ZiAoImljZTogSW50cm9kdWNlIEVUSDU2RyBQ
SFkgbW9kZWwgZm9yIEU4MjVDIHByb2R1Y3RzIikNCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2Vs
bGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIg
TG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jIHwgMTAgKysrKysrKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KVGVz
dGVkLWJ5OiBTdW5pdGhhIE1la2FsYSA8c3VuaXRoYXguZC5tZWthbGFAaW50ZWwuY29tPiAoQSBD
b250aW5nZW50IHdvcmtlciBhdCBJbnRlbCkNCg==

