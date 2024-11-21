Return-Path: <netdev+bounces-146708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3C9D5355
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B040C2840EC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546821BC070;
	Thu, 21 Nov 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHyj8tyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DD1AB535;
	Thu, 21 Nov 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216423; cv=fail; b=YD9x/RJK7fS7Bat+USmRocPmo8zDRTNs8PAOWTXHfmINo36WYukKz+LySyjUuphiUUkFgkkVzh3juFQDyeg7Ux4uWES8ztet0eP4COEslRE+mXrDC44YaeNNsULz6l1C47ri7ig+IICSHZU2Uc1wlboRUhrhdCoBhw97DoOHxFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216423; c=relaxed/simple;
	bh=BD4Ckv25rF1fHfeJEkCIHVlvFzvROl6xNkJJ3piHjVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCc3WEkyB5J04JkSoiiS3tyx9VwyJ30hrjRMetG19zcAT4OxW2mWkW9La8P+kdn1S/cD3sRRuCrMRYVQ7f5STfOxM0l7yhGMzwUwZO7tIvTsngcPa3Xdv8T+8A0VDvSDtanD8L6eSKevd2HmZ3sL9qj9RdlAAZ7sCo5UNuGyNSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHyj8tyJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732216421; x=1763752421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BD4Ckv25rF1fHfeJEkCIHVlvFzvROl6xNkJJ3piHjVI=;
  b=bHyj8tyJPXu1JYZ2XCEXnVXl5l3j5XE2hTBg16nDPkCyx+zAJOUXYLcm
   dqlL2okPZwYifbrRCIcjugkQjkqE5868FViowoKUyRod+RUtRcTJVjATF
   BSn1dF2AiMgewURQI8uYkkw39NJqFjbZ38Wg0xQ9edlfG/sQk4Otuyb6y
   yCITH6WIL88p6XxaNl/wJrdlycJG1/tIwKsjzaxZbdFGrVGCOLo7AQui9
   fVUnu97/yDdYz+unyTxwfYEXRJCC902Z+7nhYbz89i+wNHPJtP5RaRqOU
   hfSujjGqVnvI7REZEVVEfxkHtxhhJCOe8qM9IwVg2su7Hm6s+AiXVsYgd
   g==;
X-CSE-ConnectionGUID: GnkadKW2TBaF2iGBjBxQfQ==
X-CSE-MsgGUID: L27GIULhSK6Xsggg9TLBcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43732346"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43732346"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 11:13:36 -0800
X-CSE-ConnectionGUID: rQ+GS9wIStWahu1jRIB6RA==
X-CSE-MsgGUID: 4ZUKSC+zS6aFOPuHp61BLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95297138"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 11:13:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 11:13:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 11:13:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 11:13:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjJNOVg1XbvfhvYRzKPmXg2K8AA3K7nK4+qfExzV3CgeUR7xSHUguWpSYwkPyWS2DCEZqfXqHiTUW0vag6AeLlR9HbLOv7ofMj2Ww1xIY52dz5GNo2u5zu3ajygvLscNyAg5tT+y8dnl8bvnXYR/6ycPWnd/BARH+FbT3eROqYvouAom2ucobQeze+D/9b311sYf7bRsnw1mq0hb58PqQvoU46oZIZPluwtFm66W5hlUDvGJns0lL37DBji/QqZrz0/dwL0Qz5W9LmTiS8T/Vn4PA78dp3DhAxTlk0wwqQ9BqW7QJBAeR29XbytrJer2dA+NrvMRo65Hr5x6vyuHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD4Ckv25rF1fHfeJEkCIHVlvFzvROl6xNkJJ3piHjVI=;
 b=lZdUv0J6D9+4f1RqKCw4Y8axfGvgETz2wXwLXubT7o45IR4CAAWUQgq+sHJpGzq4wKMR43JyCnaFbcIB8UM9crw8bAIHtIP8kG5hZ636F3x3idV+zCjefgdq9wAOnOM5Q5Hh7X9cHu93WQqzjAhnsv44ZDS6TfO+RUkYf55wu+qscgxTCVMF7X7ngSXZOpnRZSvjD2N3ByZdPAicepX5B/mX52d0EEUFsQwLQVG/+9OhizSlTu2+gyB7JixqVnaSGA3NurZb2J0TrPfYoAFLKwfHgFWrFRilmf//mnTaCnQHw80uWLdNm9hi/LPmAZCLKElNs3B+hia6Ohs9DN+5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6460.namprd11.prod.outlook.com (2603:10b6:208:3bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 19:13:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 19:13:12 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
Thread-Topic: [PATCH net 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
Thread-Index: AQHbO1N+PrDtURiU7ki3SKFvrME1E7LAlWyAgACKYoCAAPw0EA==
Date: Thu, 21 Nov 2024 19:13:12 +0000
Message-ID: <CO1PR11MB5089671D438D9CE392B1BB3CD6222@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
 <20241120135142.586845-2-parthiban.veerasooran@microchip.com>
 <b20ed55e-cb77-4821-9b5f-37cdf3d01df5@intel.com>
 <0776911f-f537-4662-b3e1-a5f2f455f8bd@microchip.com>
In-Reply-To: <0776911f-f537-4662-b3e1-a5f2f455f8bd@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|BL3PR11MB6460:EE_
x-ms-office365-filtering-correlation-id: cf762af7-d872-466e-f73f-08dd0a608b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?WW9saTF4elhsd0t5WXUyTVNoRzYrRkpqYlhzMWk4SHVNZ2xtVE1jVmM1bDhh?=
 =?utf-8?B?N3ZPZUZ6dmF3RGtScjVKSXBsN2Q0Q3RnM2w1V1hVeDdDVmJ6dVd0REhXMjFu?=
 =?utf-8?B?STFCZTllU3FjYkltK2U2S040ZHVncGkwelpwS1ZhbVNJRFVqbFRZQzFBTW41?=
 =?utf-8?B?NXhSVDl6bnEvMHVMZ0F1SFVhKzMzZjFmRzlFZmRMcS9KZWtmT0RnT1NyR1d0?=
 =?utf-8?B?ZWFLd3hjUjdZc09FQ2pCcnlKMUY3d1ZRMWZiRTBxSUVFMGxkLy9Odlp5OTh3?=
 =?utf-8?B?WmdIWVpTTGhzZ2crSjlkSVhFSE1ramZ5WnM2UVh4U3ZJdHBJNlhnL3pSc29o?=
 =?utf-8?B?VEZWay96d2VOU1BGVkI2NFcrZW14NjBTRE1YSXJEODdNYnhBeHNVeDIwOGFC?=
 =?utf-8?B?UkZjNTlXQnF5Z3pOc3lBVFFpT1FBazd2WFI4bE5la3hpUHFsMzdYY3p2ODFl?=
 =?utf-8?B?UUl1eUgzVHVHNk1PYjAwcmhSTVRaKysvQmh0bXMyOEhrQ09hWWVMZ2VKVWF2?=
 =?utf-8?B?QVBsc2hZMkxsL2tHWkw1R1dMMWRCWWVvNmRGbzRtQWo2a0d4Q2E3OHR3MzNO?=
 =?utf-8?B?YVNUM2JrdDVuQWJhdFA0bXFCNHgxanl5ditObGoxSjE3RVFEbDFmOVFIZmhs?=
 =?utf-8?B?MnBUYWszM29FTkZLZ0ZHUDFZeEY0SFNLemlHUTVjL0tLa040UWZmK0FxRDJ1?=
 =?utf-8?B?R1dYVFdFUnViS3dkdXVoTUg1QnZHUFpXTktNUTcyZngwaUVkaFlueitycFZJ?=
 =?utf-8?B?SDYybzhLQXgyNmIvQ1FIbThjaWdrYm5FcU1KQzZKM2YwYzdCUC9rY1lXZGhq?=
 =?utf-8?B?eTV0c1hMTmM4TGsxL3RSMDNPMVVKWGUxOW5adTBoTW5oYlJFWVlkWXNYZTI1?=
 =?utf-8?B?WGJFQ3RCWDc1ODBZVWQ2bmhvRldZSnY3OWVNU1p0anNOcng4Mnc2MFhmQXht?=
 =?utf-8?B?MjhHNkxheHpFb0F3ZW1WZXpraDhtbnJlRDl5OForN2ZQVUpDS2pWRU9rQ2s3?=
 =?utf-8?B?ZGl4Z0EzcmhLanN2UUZuTnFrZWI3eG1taUQvYWlodnhSRHVTME5zK2RRdHd6?=
 =?utf-8?B?S3RzTVJlQzI3OGY4Zi8wNHdmL2FnSmRLRTRWUDJlQ04wTE5JQW9NV2dyNDli?=
 =?utf-8?B?UStGVlZyaG9mSHhUMkRYWXo3T2I1YlFBMWhGL2w5Z2tpZzNrS0NQWVJUS0tJ?=
 =?utf-8?B?a0ZpUDliL05HUUZldlJtVC9tbWwwemdiN0lwM3htNkFId0NPKzZHM1BOa0RW?=
 =?utf-8?B?K3VXLzBGNnhlRlFFVEI2OGpGWnlOSTZ1S0thMzZCWlRYNEpYN29kK2xyYlJJ?=
 =?utf-8?B?dWJaempEb0VWTWZ1ZU0rNVJ6OVhtUFBWb05XL3BTRHVaVTg5dHNSTWZ6Zksz?=
 =?utf-8?B?TFBmT2pSblA0cVdWVE9NR054N3pLRkdqMkR6TkRBZlNDdk84STlHeld5dTZB?=
 =?utf-8?B?aUVnSG1oQ0hycGR3TkZuK3ZiMzVmcml4U3NlNjV1dENVbmFNSXB4T280SVdM?=
 =?utf-8?B?NFpMMUNMUWh3UnRlSHd3RWZFZVlaRjFXOStXVitDZ2pNTnltZjVEK1E5Q3NY?=
 =?utf-8?B?a3V4NEc3bzVYOHZCMS9EM2FCVG92UnN3WWhNOU04SEgrSXpxNk5GUTNIYzJN?=
 =?utf-8?B?ZUp6bm12OFF5ZHEvQnZJdzQ4Q1R2OW12TzQvaEpIczQ5VTR3VGRXMDZkSzBw?=
 =?utf-8?B?NVhPbXhUOGxWaEo2TEQ2bDJYR1pZU2hybjZHZ21OUE9XbjZ0MG5HT1pRTm9x?=
 =?utf-8?Q?9HCoBJ/7sId0Caad+auzFG7we2PGC5ulRrLQY+6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDlobUhva3YxeVFMRE9uNTV2MXEyOFdBUTc1YUxsRVk3TmdWTHhDQ0JMVzM5?=
 =?utf-8?B?WHN4OFltSllaNWxPWENXd2JDcVJBazJpKzd5Zk4rQzZXYmNVL3hCQUk3Sk5s?=
 =?utf-8?B?KzhiQnR6eHlIUDd5OTdCb1Y3V1lLck1ocHU1eVpqSEg1Y2d6dWZhc1R4ZlFD?=
 =?utf-8?B?TFM3UlRWaHF0SnJVSWhqYlVVV1JMMFNwbHIxZHAwTW5hK1dUNXJ6dVRUS2Zi?=
 =?utf-8?B?T1EwQkwyNWo0Z1ZEaHl6bXFsaS9INHhYMDBraFo2bDhaazlENkhIalNJckpz?=
 =?utf-8?B?RU9IU1VSOXJUQksxRlR3VHF4RFpNTTVBQXRDWnhIdGIzVWpZVnVvVjlzQndH?=
 =?utf-8?B?OFlOeXhHRFQxeVZNZVlGKzRoSVZ0S1VoSEJwNi9oWGZjbFg1QldDQ3dibk5P?=
 =?utf-8?B?aWNraEVtSFR1MmE0MEJjYTY3UWhFRDI1dEhDQkk1UzZTQ1V2djQzYUVCNThx?=
 =?utf-8?B?bHBzdnFCMU5ZU1NNaWZwTTB3T0RwZFhqYUU1czAwYW1qenh6MllYWHFjSE1o?=
 =?utf-8?B?NHc1UFkwY0FTQ0s4dGhmVGZUM1FPbEVFOXA4aUlQZTVnblRWSGlrUzc1U2Z3?=
 =?utf-8?B?M2ZiUU5zdEd4SzFvRnErWG1kOG5RcDVqZTlxSTdZdmhpNmhKY2NhZStlNGpn?=
 =?utf-8?B?YlQ3TUJOWklBUVVlRkd3dlBuY2RNa3BTNllvczVmSGZqOFNkN1ZXY2VmVWpj?=
 =?utf-8?B?dDE5UUxUWnJEUUxodzFMMU96YTdzeWVLYXdvaEx1WDFBdVhQalVuN3VlWlVl?=
 =?utf-8?B?UzJmQVlwN0M4eUJSUFlJRlQrc1JyN3llMGVKd0RsakUrWUdTUFMwTUpTZnVW?=
 =?utf-8?B?WHhKa21DYjRPWERJRHhsSWE3dTJVWWx4TS91QjBZZS9FeldiQWlCaXhubGRW?=
 =?utf-8?B?WVZDWGEwVU1EWW1nd2J3bnJTMVpjR0luZ3FOSWxWbkNwTXdmVG5tZEg3cFo3?=
 =?utf-8?B?UnFpZlpvRStVMGcyOXh5RGRkV1pXV0pBeWlmclhXbUdpVFJmcUFqMkZFVjJn?=
 =?utf-8?B?SjRoS0JXaWFoNVJxdVU5dHB2eTkwbmxmazVaSFUzTUpQZ0hXVXRjTGdqTTly?=
 =?utf-8?B?ZUxZdFZQRUh6UFArQUtEMG1sOGlsS0FYbEJKajFMYW1ibUliUmNRNkRQRVFR?=
 =?utf-8?B?MWJnN2VUclV5VE9LalROR1NaK05GYi9ETzlRM2ZhY3pNdmg3ampILzlnV1ls?=
 =?utf-8?B?Tkh4M0I1OHp2R09Xc0xLdzhIbWRhYkJZWHBYaVErc0srelpzU0N0Z2hVQXAz?=
 =?utf-8?B?QkxrOS85VWYwU1ZBM2lxdWx1VHZGQ0ZxWHRyRTBoQzNCVnE1NzBUbFBidy9Z?=
 =?utf-8?B?N0t0NWNzTXhKWmI3c2RlZ1ZEQ3pNeGQ5MzJGRjJtakNZZStqVTMrNlFDQ0Va?=
 =?utf-8?B?UVRNeXpkbDlRTUJSQ2cyU2tPSWxxeEJCcHlMU2MxQWhPcTNmNklZZ1hsaE11?=
 =?utf-8?B?MExMeTJlZDMrNDQ0b2FSZlhoWG8wWG5UMmVETHMwSHptSU1mRmVuYnkrRE5n?=
 =?utf-8?B?RkcwUmtCd1MxOTdEcXFhdUxEWXdRdmdnM1pPS0JCSGVsaXUvQnRTTWo1dEVD?=
 =?utf-8?B?RFVXTHQyclhlZ1l2dlRJeHRkN2VnZ1RDaEd1alZBdGNrdi9vbWdJWFZhWjgx?=
 =?utf-8?B?TnVIZTdPdUFvVkhhSnpUeCtsbmxlaCtBUERpa0lHM3Y5czJaYVhyWVF4eitS?=
 =?utf-8?B?cFZPUUltSVQwSVdIRm5NOEdLQXFxNUN3cXdobkYzSk9DVitnY2NUVGFFUS9I?=
 =?utf-8?B?c2JoVmtMdVgxclFDOE9DZHhLNXpwekdjK3M3TXQrRHRtUUxHMEgra2ZBSXFU?=
 =?utf-8?B?ODd2WHhYUWJDelB2aGRkSkhTTElsTHdrOWNoWWRiRmRhVDBrNWg0SEFwQXAz?=
 =?utf-8?B?ZWkvQWhSOUk2ZStQczlSNW1rbmZldS95MjArcXVaTFdCYjFRMjJCaktlR3Fh?=
 =?utf-8?B?VGpldmZaNzVsVnA0aU80SnBMbFJSMG1VQTNQN2Faa2VhZlhEb2hvS3JoUXYx?=
 =?utf-8?B?NU9rTCtua0EvU0Rxc1MwQzVCejN5M0YzOEFMMmJ6eXNEaFY3cnRHZmg0UXFv?=
 =?utf-8?B?U1VHY3RTZlZQSm5uSjkvejRBWjEyUkJ1eUorVVRWL3R3UnZ5aDBsdWtLOXdQ?=
 =?utf-8?Q?+69RmAvFkGEsuS363TVIqgV0k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf762af7-d872-466e-f73f-08dd0a608b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 19:13:12.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LRDZGUjUZkAj7vBd2VcpDAyuy3vtiK4cIe6gsd+zSqC9Iyf5KRXnplxgmDUNrTIVJjnZSVpHE8LVaF3yHu1WmgwmR0M51Yz+X2jisWpg4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6460
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFydGhpYmFuLlZlZXJh
c29vcmFuQG1pY3JvY2hpcC5jb20NCj4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAu
Y29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIwLCAyMDI0IDg6MTAgUE0NCj4gVG86
IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBDYzogYW5kcmV3
K25ldGRldkBsdW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29t
Ow0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBQYXJ0aGliYW4uVmVlcmFz
b29yYW5AbWljcm9jaGlwLmNvbTsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gVU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldCAxLzJdIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjogZml4IGlu
ZmluaXRlIGxvb3AgZXJyb3Igd2hlbiB0eA0KPiBjcmVkaXRzIGJlY29tZXMgMA0KPiANCj4gSGkg
SmFjb2IgS2VsbGVyLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KPiANCj4gT24gMjEv
MTEvMjQgMToyNCBhbSwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KPiA+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
DQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiA+DQo+ID4gT24gMTEvMjAvMjAyNCA1OjUxIEFNLCBQYXJ0
aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+ID4+IFNQSSB0aHJlYWQgd2FrZXMgdXAgdG8gcGVy
Zm9ybSBTUEkgdHJhbnNmZXIgd2hlbmV2ZXIgdGhlcmUgaXMgYW4gVFggc2tiDQo+ID4+IGZyb20g
bi93IHN0YWNrIG9yIGludGVycnVwdCBmcm9tIE1BQy1QSFkuIEV0aGVybmV0IGZyYW1lIGZyb20g
VFggc2tiIGlzDQo+ID4+IHRyYW5zZmVycmVkIGJhc2VkIG9uIHRoZSBhdmFpbGFiaWxpdHkgdHgg
Y3JlZGl0cyBpbiB0aGUgTUFDLVBIWSB3aGljaCBpcw0KPiA+PiByZXBvcnRlZCBmcm9tIHRoZSBw
cmV2aW91cyBTUEkgdHJhbnNmZXIuIFNvbWV0aW1lcyB0aGVyZSBpcyBhIHBvc3NpYmlsaXR5DQo+
ID4+IHRoYXQgVFggc2tiIGlzIGF2YWlsYWJsZSB0byB0cmFuc21pdCBidXQgdGhlcmUgaXMgbm8g
dHggY3JlZGl0cyBmcm9tDQo+ID4+IE1BQy1QSFkuIEluIHRoaXMgY2FzZSwgdGhlcmUgd2lsbCBu
b3QgYmUgYW55IFNQSSB0cmFuc2ZlciBidXQgdGhlIHRocmVhZA0KPiA+PiB3aWxsIGJlIHJ1bm5p
bmcgaW4gYW4gZW5kbGVzcyBsb29wIHVudGlsIHR4IGNyZWRpdHMgYXZhaWxhYmxlIGFnYWluLg0K
PiA+Pg0KPiA+PiBTbyBjaGVja2luZyB0aGUgYXZhaWxhYmlsaXR5IG9mIHR4IGNyZWRpdHMgYWxv
bmcgd2l0aCBUWCBza2Igd2lsbCBwcmV2ZW50DQo+ID4+IHRoZSBhYm92ZSBpbmZpbml0ZSBsb29w
LiBXaGVuIHRoZSB0eCBjcmVkaXRzIGF2YWlsYWJsZSBhZ2FpbiB0aGF0IHdpbGwgYmUNCj4gPj4g
bm90aWZpZWQgdGhyb3VnaCBpbnRlcnJ1cHQgd2hpY2ggd2lsbCB0cmlnZ2VyIHRoZSBTUEkgdHJh
bnNmZXIgdG8gZ2V0IHRoZQ0KPiA+PiBhdmFpbGFibGUgdHggY3JlZGl0cy4NCj4gPj4NCj4gPj4g
Rml4ZXM6IDUzZmJkZThhYjIxZSAoIm5ldDogZXRoZXJuZXQ6IG9hX3RjNjogaW1wbGVtZW50IHRy
YW5zbWl0IHBhdGggdG8NCj4gdHJhbnNmZXIgdHggZXRoZXJuZXQgZnJhbWVzIikNCj4gPj4gU2ln
bmVkLW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuDQo+IDxwYXJ0aGliYW4udmVlcmFzb29y
YW5AbWljcm9jaGlwLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
b2FfdGM2LmMgfCA1ICsrKy0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L29hX3RjNi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMNCj4gPj4gaW5k
ZXggZjljMGRjZDk2NWMyLi40YzhiMGNhOTIyYjcgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L29hX3RjNi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L29h
X3RjNi5jDQo+ID4+IEBAIC0xMTExLDggKzExMTEsOSBAQCBzdGF0aWMgaW50IG9hX3RjNl9zcGlf
dGhyZWFkX2hhbmRsZXIodm9pZCAqZGF0YSkNCj4gPj4gICAgICAgICAgICAgICAgLyogVGhpcyBr
dGhyZWFkIHdpbGwgYmUgd2FrZW4gdXAgaWYgdGhlcmUgaXMgYSB0eCBza2Igb3IgbWFjLXBoeQ0K
PiA+PiAgICAgICAgICAgICAgICAgKiBpbnRlcnJ1cHQgdG8gcGVyZm9ybSBzcGkgdHJhbnNmZXIg
d2l0aCB0eCBjaHVua3MuDQo+ID4+ICAgICAgICAgICAgICAgICAqLw0KPiA+PiAtICAgICAgICAg
ICAgIHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZSh0YzYtPnNwaV93cSwgdGM2LT53YWl0aW5nX3R4
X3NrYiB8fA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YzYt
PmludF9mbGFnIHx8DQo+ID4+ICsgICAgICAgICAgICAgd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxl
KHRjNi0+c3BpX3dxLCB0YzYtPmludF9mbGFnIHx8DQo+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICh0YzYtPndhaXRpbmdfdHhfc2tiICYmDQo+ID4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjNi0+dHhfY3JlZGl0cykgfHwNCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGt0aHJlYWRfc2hvdWxkX3N0
b3AoKSk7DQo+ID4+DQo+ID4NCj4gPiBPaywgc28gcHJldmlvdXNseSB3ZSBjaGVjazoNCj4gPg0K
PiA+IHdhaXRpbmdfdHhfc2tiIHx8IGludF9mbGFnDQo+IFByZXZpb3VzbHkgd2UgY2hlY2tlZCBr
dGhyZWFkX3Nob3VsZF9zdG9wIGFsc28uIFByZXZpb3VzbHkgaXQgd2FzLA0KPiANCj4gd2FpdGlu
Z190eF9za2IgfHwgaW50X2ZsYWcgfHwga3RocmVhZF9zaG91bGRfc3RvcA0KPiANCj4gUGxlYXNl
IHJlZmVyIHRoZSBiZWxvdyBsaW5rLA0KPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjYuMTIvc291cmNlL2RyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jI0wxMQ0KPiAx
NA0KPiANCj4gTm93IHdlIG9ubHkgYWRkZWQgdHhfY3JlZGl0cyB3aXRoIHdhaXRpbmdfdHhfc2ti
LiBIb3BlIHRoaXMgY2xhcmlmaWVzPw0KPiA+DQo+ID4gTm93IHdlIGNoZWNrOg0KPiA+DQo+ID4g
aW50X2ZsYWcgfHwgKHdhaXRpbmdfdHhfc2tiICYmIHR4X2NyZWRpdHMpIHx8IGt0aHJlYWRfc2hv
dWxkX3N0b3AuDQo+ID4NCj4gPiBXZSBkaWRuJ3QgY2hlY2sga3RocmVhZF9zaG91bGRfc3RvcCBi
ZWZvcmUgYW5kIHRoaXMgaXNuJ3QgbWVudGlvbmVkIGluDQo+ID4gdGhlIGNvbW1pdCBtZXNzYWdl
LCAob3IgYXQgbGVhc3QgaXRzIG5vdCBjbGVhciB0byBtZSkuDQo+ID4NCj4gPiBXaGF0cyB0aGUg
cHVycG9zZSBiZWhpbmQgdGhhdD8gSSBndWVzcyB5b3Ugd2FudCB0byB3YWtlIHVwIGltbWVkaWF0
ZWx5DQo+ID4gd2hlbiBrdGhyZWFkX3Nob3VsZF9zdG9wKCkgc28gdGhhdCB3ZSBjYW4gc2h1dGRv
d24gdGhlIGt0aHJlYWQgQVNBUD8gSXMNCj4gPiB0aGUgY29uZGl0aW9uICJ3YWl0aW5nX3R4X3Nr
YiAmJiB0eF9jcmVkaXRzIiBzdWNoIHRoYXQgd2UgbWlnaHQNCj4gPiBvdGhlcndpc2Ugbm90IHdh
a2UgdXAsIGJ1dCB3aXRoIGp1c3QgIndhaXRpbmdfdHhfc2tiIiB3ZSBkZWZpbml0ZWx5IHdha2UN
Cj4gPiB1cCBhbmQgc3RvcCBlYXJsaWVyPw0KPiBJIHRoaW5rIHRoZXJlIGlzIGEgbWlzdW5kZXJz
dGFuZGluZyBoZXJlLiBIb3BlIHRoZSBhYm92ZSByZXBseSBjbGFyaWZpZXMNCj4gdGhpcz8gSWYg
bm90IHBsZWFzZSBsZXQgbWUga25vdyB3aGF0IGRvIHlvdSBleHBlY3Q/DQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IFBhcnRoaWJhbiBWDQoNClllcCwgbXkgZXllcyBkaWQgbm90IGNhdGNoIHRoZSBs
YWNrIG9mIGEgKy4NCg0KUmV2aWV3ZWQtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJA
aW50ZWwuY29tPg0KDQo=

