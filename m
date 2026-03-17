Return-Path: <netdev+bounces-268690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGTrJ1WLuWmTJAIAu9opvQ
	(envelope-from <netdev+bounces-268690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:11:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E12AF1AC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7B143050A8F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2E3F65E7;
	Tue, 17 Mar 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzotKFin"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401863F54BE;
	Tue, 17 Mar 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766694; cv=fail; b=XSaoKdwJ8VYXlvLonQfIpjWRDtniqCtRoC9pluy9mHmU36m4bZ7IypNZigD/sn9fqS8PLj4MpFgbKwr1PgNC3MFa41IZQndf1+3ga59sL0MfOw2hxp+o5TCR1B/3SdlhBuS3L8iRMNV2lmnHDCFn9uTDm0iGnUsAW/hBAIbjrhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766694; c=relaxed/simple;
	bh=kXSwH5WXEr+oWYwJJJH3WLEA/bkjedVslJAVozeyDLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EHHbF81c/1NBnG64kTWevtgEw14nDeR/2FtwPKiUQeg8tap6ZMF7GSZbJzEd86rgr0hPOa/5iZtZLyR8N1JfUE3jG/0iyj/e5uN+Q3eQRdyVnDQu8HkwGPj5Hg2yZbtp6J35BmL+7HPR3l0VeElkTU5vNiA3cS6VPPnnTvhkRQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzotKFin; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773766693; x=1805302693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kXSwH5WXEr+oWYwJJJH3WLEA/bkjedVslJAVozeyDLI=;
  b=DzotKFinJnOa4DFR1u3lU/NWlKXaF9s0CKqQkcJcVMBS+ShQLRMIh+pm
   rzPmajo3Kk1gL1VbNwFj976Zd2xY0J0gro3gjvFdf9F6DpaLj7zT2D8ep
   3eCrTuMlj8cmkxT+UY12LB99cW6XxdEd7iNSVJnRlxlfnVkgo6QZQbyNp
   CzQuz2HoaDoqguelXtA19GAdsmJw8CwZaPRGPkHl3U/2PGdB01W2QuliV
   8KzSTmbFXWYTB3sNoGrfuQy0crPWsRJkcJ7wYUh+a7Fx0V3Qc/qy/jWiU
   jvsb6ZrRMY080ivV8jzZ8fV/roli/lLCyEnrq6oBcmk5G55S+XGXX6Xsa
   g==;
X-CSE-ConnectionGUID: zTw0oPJ/T26D2OTxozqVGg==
X-CSE-MsgGUID: dgAQw7pFTk+XEgLzk8etxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74990968"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74990968"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:58:13 -0700
X-CSE-ConnectionGUID: 0Tsos91SQ1SIgZWxOaqkBg==
X-CSE-MsgGUID: OKCz9EAoQMqAlHK9/d7I6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222546643"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:58:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 09:58:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 09:58:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 09:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0aJIdUKpwtxHE/0s5gAFs1noGyexk+3YIPaoA+Zam7wHvquJ2e298P6W1T8viLDxqPtOmzYoFJ2R52ttB5erw8hMG5NmKxjkI1vjHgIl0T4mj5a0IS+4mbmlKPGXCPx+Jo74leOLj8ErGz3CGvnrNv3LutgjPBRMUic432/Sr7EWFy8j25mACYFOrIIuO1gmigNDMXw7sfr0mwDr/UeAj3bE3ldAUwDcM7sJB081pED1IyiMCPyiqSaiq1uJWYk0WZ5D3qQEK+lmCCxb3h/NaCJpWfUnSNDparTq1iINyvO1rY71FbMhvgM6Fv9C0iT4IJFOmrp2FsFqEgic2ZwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXSwH5WXEr+oWYwJJJH3WLEA/bkjedVslJAVozeyDLI=;
 b=BXkQMk749D23IKvJTYhf5q4zvfDniH2txCwh6cpsZ26yn8l6yoPbErHcnI4dXwis0Suiare2qEA1J6dm/ilc8VAQAZmXSnTUBDLRFf+27n/aOmEX1a+p2gR2qWvSQ9gkwG0Z0dhD3e0+rzv256bt5DXeCqeD1WnsXtjLpYFLIH9yXZEw7TWX97keOEL5RFqCMZZ/TVPmIOFHpK0QbiQ7kPrKymfYW/hC46OGD5mPXTx7/YfiqGGeaUEURrEO5K/fCyp1m2rzDBlXguNfLVfwsD0c0/BnSj+pqP7w13Ja3foXwPc8QKGiFGgGAnQSLwnQPMn0ULPk9MYBBnzVswlBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 16:58:09 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9700.009; Tue, 17 Mar 2026
 16:58:08 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Fodor, Zoltan" <zoltan.fodor@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Grinberg, Vitaly" <vgrinber@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v11] ice: add support for
 unmanaged DPLL on E830 NIC
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v11] ice: add support for
 unmanaged DPLL on E830 NIC
Thread-Index: AQHcoCdUWm/06WIofUmFPGdKuGWTVLWzHPsQ
Date: Tue, 17 Mar 2026 16:58:07 +0000
Message-ID: <PH0PR11MB7522DED2EB3F75FF0C9B65C3A041A@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260217155808.1209194-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20260217155808.1209194-1-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|BL3PR11MB6315:EE_
x-ms-office365-filtering-correlation-id: 914659bc-7894-4622-e58a-08de84465d40
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: Q7bpi6DLiwqjmOTuugq2cI6fxuPPcx8YxEdFKlYhIjjTHkpcz/25l5V/e6SEnUUfkzQhVe9a7oFL/SICbQAmt+DPAe3G7GZoFa1kQs9GDyNItFBpzTdJIDEwyRT8U4qknFMPF/fGXhDqt6N7mMegtP3O+vA81vMz96ystleNV9EdV3fvveruKUyOZRdPQ4LmyPi0Mh+7qqnOQWr9kVOZvv5A7PiDcZNFEoHDvd7d998Q7ZeyFl1AXic+FbmCFd5ZDz/rDwoBU8UIHtU4/asnDGURlQwLaMxBcBephclnYJe9wGq1f+LpBUN4pNnnagLW+AOhahMRa7bb23k8wribclqj1WgYRJn0yiPaF1nebCyn9TO8NB5RMuQMmOtKX90HOKgmOuwtZ2Cly4+WglSf+wFXF/aNUNQdRS4ZJVIuMZmL1nbWqF5PQcCVEmG0zVESHPhP3tmxWv2K7XJg6ULJb5SniFt03s2u6/d7tl5mAJ7zFog7vv5AHJlbhw3HANBxhbC3wA6ixejFHVskTti4UjlcDqdu+Letyz4CyGMlYypsstVle95PtF22HB/ReQ/D2qSm+VJqDbFSKVyvGEXrqC9JO0E5g4hYy/O+MG7/ja6dcdVn7V4AV7yOIf3nhZSKypjglRWkzgE1srcfv+8IMhtb7IYiFYKHo9s2yEOLijyU+CyzfU33eckMNptHvs4htSbOxdK2E2FbqCVMaXQrkF8XbAdJXE33LlHf2LWDoZCROIKJYWEi3K6UxfgLKJh4NlZ1xF/j+rb4Go6HmAYsAPC1aHAwgx6JMAPgRX7yPsY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejZIZFJ3WWtZS2RGbWFvMEZ1cXZzeWVGQkhFS0xsSHgzQmpyVklCbWVJdXVv?=
 =?utf-8?B?b1dOOWlBVzI4TU5rU2JCOEZER0Y2dlp5VTBKcS84aVZIZ0Jsb29LV2dxQ2lH?=
 =?utf-8?B?c01WemNQVUI2S3RMTGRYT3AxUnBlUGxUQjBxSjI3Z1pnOGVtbzFVd1NWL09P?=
 =?utf-8?B?RWVYbVdUK2Z0SCtjMytzbFZhRjJlWnRFS2ZseEJzTkdaSmg5ZkpoeCs1WWt1?=
 =?utf-8?B?OTEwVlNGU2JxUW5HVXM5eTkxTHpkaGVmZWYzNzdHSkRTWG5tU0xmNCtKZTIv?=
 =?utf-8?B?UFcrM044Y3drSUFDRnZHZVJWVG03dWRYRXg1QjlCa1Z6L2JWNUM1MWNhY3RN?=
 =?utf-8?B?MDVDaDB0SE95UWpOYW5XVzczZUdQclBhTHlyN2crY25pN2owMFpob1VEaEt1?=
 =?utf-8?B?NEp4OGo4b2R0QlNaV3hrV3NDbVc5YVhOVHJQcVVPMDhqL0t4SitjLyswR3BC?=
 =?utf-8?B?N24xMlo1VGF2MkRBVEhGaWgzMzI1QWVkNlA0VVh5Uk94a0ZTRUtmNzNtTWFH?=
 =?utf-8?B?ZTVWVVpLVGF4aW5kYzVlSEhTaTd0S0IxSFBTWlZlUWE1eXo5YlVzakx2Z0hk?=
 =?utf-8?B?djhTRkZ2STFZZDkvZXpDUGc2Vk9tcEZzOHNSL0laT3hQcCtPaVB4ajVIYlVI?=
 =?utf-8?B?c2dRamlHcHlHWDU0TU1hejFMVDZYOXJQWElueGxjbE1kalo5Z216bm1qYmdX?=
 =?utf-8?B?MEgzUW5JMlJMM3p0aTNRaVYwTFdlTlFpbkpOYWJ1WDlDT2dsd3Z6Z1krYVl4?=
 =?utf-8?B?VVNEcFZNMTZVQVVsV0V2cDVaa2IzemxWZ3k2RVdvK0dxN3hxZEhsank2b282?=
 =?utf-8?B?OTJJU1BPQmtJcXp3RklRRTgxb0lZS0ZJd053Mng5QlBVR3NSTDFQMTZKUkxa?=
 =?utf-8?B?YTBlYWV4aXA3TFkvdmE1dzYyeWRSK3g1a3dJQzg4Mm5PanEvbnhBMWQyWTZM?=
 =?utf-8?B?VHBHNGFNajJXM25oR1pnTkw3QUpHMkZZTHVDWXdJY2tsUlJRK05QR3JJdjhB?=
 =?utf-8?B?a0NzbmJWSDd6ZWRaY2Z3dnpWUnJMTEdKblhudFk3WTBLZ2tLTjVBdmt3eDhS?=
 =?utf-8?B?K2RtVVUwQXp5NE1WNXBCamVveHdiSHk1ako5TU10UmtIWktBLzJTT3lQeWlE?=
 =?utf-8?B?UUsxUWFkOGJLbDRVWjk5WksxNXZkYWF6WmJCNzRLd0lUQmpPcnQ4SzVSVUgv?=
 =?utf-8?B?eGZxWEFtQmVrUkRMSEtFR2d3aTViRktvWCtHODVzT0V6bmZBRUV0OVp0cEpC?=
 =?utf-8?B?MjJLZVJOa21QUFhUWWFaY0dhT2Z4WFJUNnpSWk9jenVGUG1ZYWE4S2RhNmpY?=
 =?utf-8?B?S2xpWGlnTVMvMVRFQmxkQUwyZUZ4RjRMUXBHR04zb1ByTFVDazRCNFhrUkdm?=
 =?utf-8?B?NkY1SEhNUnQ5NzNIcEw2NmdoT1IxM0F6b1hwV3hSTFlEcmpUZU5RVFpVN3FM?=
 =?utf-8?B?YjI0T1RMN3FvUGVVdzFiam01Z2F1aEdoYUlSdzU1S1M4MnJZQ0VJbUIzZjFC?=
 =?utf-8?B?OThqZVpSNHhsT2cybDRGS1VLUWI5U3NnY3JEWldJUm1LQ0NkUTJkbEY5US9M?=
 =?utf-8?B?SHNWQmxkNWJaaEFJU2MzSlpRNTNLaFEwNHVqWGNuMHdqUVc3ZGV2SGxIbnlI?=
 =?utf-8?B?OHdvU1o4YmxmeDY2bkIvUWduUmx1Z1VSVHFEVUFxN04zSXo3TzAvN09nUS9D?=
 =?utf-8?B?NmQzTnBzWE1mT1hQMEFDTVZSeFJSbm9xR1owaXRnM3FiS0ZubUNmakZsS0Jp?=
 =?utf-8?B?YllQQ3NXUkhxQ0IyTytrRnVZRkFHaUNScENVcW9mTHBMM3RrQlVvcCtoTnF1?=
 =?utf-8?B?MmFIbjdsSDZxN3NpV2F5b0tpbzNseC9uRlVWK3RCNnVxU2dOeW4yM0tKTTdu?=
 =?utf-8?B?R05lK08wcGorZUhJMzhubGl5WWcrZW1YSHRWajdkSC9LZkFCMlM0UHRaQ25O?=
 =?utf-8?B?eWo1YUkzK2grL2REL011ODNjNGsrV3ZlaVh0VFNSMFZEeE5XR3JOZGEwU1cy?=
 =?utf-8?B?T0hIQ2pOaW1FakEwNkRkWDRzeU5VbURIWGtnNXNNQ2U5Q3g4ZHgvRjI5OFFX?=
 =?utf-8?B?aXBMUUF1b3NZTE5kMWgvblN4TUpwUXlnQThJbTZDZzFEaG9pMnR1Z1JkOXJO?=
 =?utf-8?B?ODZNdng3c01pbkN5NjlvSjhBWC82MzJrdy9ZNEQ5aHg0RlNSWTlHYjB0elJN?=
 =?utf-8?B?dVRjVU95aXVobVRGMEdsRWdMRVViTy9YQlo0dlI4UkEvbG1neWtmdER2SHRx?=
 =?utf-8?B?L2VXY2k1SkZrNXM4djAwb3RKbEUvZVVvNCsycHBGQU5oWEZHODBIUGUzRG5I?=
 =?utf-8?B?M0ZCRmg1SlN6dU95Y1pNdll0SlBQZFNPUlFZb0xjZ2Q3aWxZdmhPZExHSkd3?=
 =?utf-8?Q?NG+S5+3fdfEwb8Qg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ij3TuRh2q49siH6I37C/8z4zxivz63V+fQdqq+lmfyhK+7Cg03vT70mPVzgSA61Lvf31q8vV0JDEUFNR0ISJPZSnwmn8Sq+zCNGMMXzrfJLHzUI3WvGusXSqwcZ5AfnePDrY70QXb44LHgFaV1u4W0q66H2uEgZ/Lht1XJ4ftDsfT0HMxCKFXrRwZv5mOrjIXjqcM97ZkNB3q7Rul5/AcvEv9DmS97q4lvXYkLc7GxXuxHNGxDlNYaXe60VD40TjB2Hx7GgMY23si8OlY0zA0eEEpjEviJ94pf/jdcJOEWXLQC3MhYx460a22nB4MtooOfMxuFioY6susbtg2yURkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914659bc-7894-4622-e58a-08de84465d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 16:58:07.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FED+TsdVIEZkRDduy+VHTOruPdNE8xtJzwj3bSPAGoprVVGDi8KHqBNhrU9DxVfh7GZ3K/yKRz9XnuHtfdQIAW4SlT7A9TnjXwx5Km85Co8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,PH0PR11MB7522.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 969E12AF1AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBBcmthZGl1c3og
S3ViYWxld3NraQ0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNywgMjAyNiA3OjU4IEFNDQo+
IFRvOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogcG1lbnplbEBtb2xn
ZW4ubXBnLmRlOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBLdWJhbGV3c2tpLCBBcmthZGl1c3og
PGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255
Lmwubmd1eWVuQGludGVsLmNvbT47IEZvZG9yLCBab2x0YW4gPHpvbHRhbi5mb2RvckBpbnRlbC5j
b20+OyBob3Jtc0BrZXJuZWwub3JnOyBLaXRzemVsLCA+IFByemVteXNsYXcgPHByemVteXNsYXcu
a2l0c3plbEBpbnRlbC5jb20+OyBHcmluYmVyZywgVml0YWx5IDx2Z3JpbmJlckByZWRoYXQuY29t
Pg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjExXSBpY2U6
IGFkZCBzdXBwb3J0IGZvciB1bm1hbmFnZWQgRFBMTCBvbiBFODMwIE5JQw0KPg0KPiBIYXJkd2Fy
ZSB2YXJpYW50cyBvZiBFODMwIG1heSBzdXBwb3J0IGFuIHVubWFuYWdlZCBEUExMIHdoZXJlIHRo
ZQ0KPiBjb25maWd1cmF0aW9uIGlzIGhhcmRjb2RlZCB3aXRoaW4gdGhlIGhhcmR3YXJlIGFuZCBm
aXJtd2FyZSwgbWVhbmluZw0KPiB1c2VycyBjYW5ub3QgbW9kaWZ5IHNldHRpbmdzLiBIb3dldmVy
LCB1c2VycyBhcmUgYWJsZSB0byBjaGVjayB0aGUgRFBMTA0KPiBsb2NrIHN0YXR1cyBhbmQgb2J0
YWluIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24gdGhyb3VnaCB0aGUgTGludXggRFBMTA0KPiBh
bmQgZGV2bGluayBoZWFsdGggc3Vic3lzdGVtLg0KPg0KPiBBdmFpbGFiaWxpdHkgb2YgJ2xvc3Mg
b2YgbG9jaycgaGVhbHRoIHN0YXR1cyBjb2RlIGRldGVybWluZXMgaWYgc3VjaA0KPiBzdXBwb3J0
IGlzIGF2YWlsYWJsZSwgaWYgdHJ1ZSwgcmVnaXN0ZXIgc2luZ2xlIERQTEwgZGV2aWNlIHdpdGgg
MSBpbnB1dA0KPiBhbmQgMSBvdXRwdXQgYW5kIHByb3ZpZGUgaGFyZGNvZGVkL3JlYWQgb25seSBw
cm9wZXJ0aWVzIG9mIGEgcGluIGFuZA0KPiBEUExMIGRldmljZS4gVXNlciBpcyBvbmx5IGFsbG93
ZWQgdG8gY2hlY2sgRFBMTCBkZXZpY2Ugc3RhdHVzIGFuZCByZWNlaXZlDQo+IG5vdGlmaWNhdGlv
bnMgb24gRFBMTCBsb2NrIHN0YXR1cyBjaGFuZ2UuDQo+DQo+IFdoZW4gcHJlc2VudCwgdGhlIERQ
TEwgZGV2aWNlIGxvY2tzIHRvIGFuIGV4dGVybmFsIHNpZ25hbCBwcm92aWRlZA0KPiB0aHJvdWdo
IHRoZSBQQ0llL09DUCBwaW4uIFRoZSBleHBlY3RlZCBpbnB1dCBzaWduYWwgaXMgMVBQUw0KPiAo
MSBQdWxzZSBQZXIgU2Vjb25kKSBlbWJlZGRlZCBvbiBhIDEwTUh6IHJlZmVyZW5jZSBjbG9jay4N
Cj4gVGhlIERQTEwgcHJvZHVjZXMgb3V0cHV0Og0KPiAtIGZvciBNQUMgKE1lZGlhIEFjY2VzcyBD
b250cm9sKSAmIFBIWSAoUGh5c2ljYWwgTGF5ZXIpIGNsb2NrcywNCj4gLSAxUFBTIGZvciBzeW5j
aHJvbml6YXRpb24gb2Ygb25ib2FyZCBQSEMgKFByZWNpc2lvbiBIYXJkd2FyZSBDbG9jaykgdGlt
ZXIuDQo+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9r
dGlvbm92QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1v
bGdlbi5tcGcuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEdyemVnb3J6IE5pdGthIDxncnplZ29yei5u
aXRrYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFya2FkaXVzeiBLdWJhbGV3c2tpIDxh
cmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiB2MTE6DQo+IC0gcmViYXNl
IGFuZCBmaXggY29uZmxpY3RzDQo+IHYxMDoNCj4tIG1vdmUgbXV0ZXggc28gaXMgYWx3YXlzIGlu
aXRpYWxpemVkIHdoZW4gdXNlZA0KPi0gY2hlY2sgYW5kIHVzZSByZXR1cm4gdmFsdWUgb2YgaWNl
X2RwbGxfbG9ja19zdGF0ZV9pbml0X3VubWFuYWdlZCgpDQo+djk6DQo+IC0gcmVvcmRlciB0aGUg
ZmxvdyBvZiBpY2VfZHBsbF9pbml0X2RpcmVjdF9waW5zLCBkcm9wIGlmIG5vIGNndSBhbmQgbWFr
ZSBsZXNzDQo+ICBpbmRlbnRhdGlvbg0KPiAtIHJlbW92ZSBmbG9hdGluZyBjb2RlIGJsb2NrDQo+
IHY4Og0KPiAtIGZpeCB1bmluaXRhbGl6ZWQgYm9vbCAqc3VwcG9ydGVkDQo+IC0gZml4IHByb3Bl
cmx5IHNldCBlc3luYy0+cmFuZ2VfbnVtDQo+IHY3Og0KPiAtIHZhbGlkYXRlICdmaXJzdCcgaXMg
cHJlc2VudCBvbiBlcnJvciBwYXRoDQo+IHY2Og0KPiAtIGNoYW5nZSBkcGxsIHR5cGUgRUVDIC0+
IFBQUywgdGhpcyBkcGxsIHNlcnZlcyBib3RoIGZ1bmN0aW9uYWxpc2l0ZXMgYnV0IFBQUw0KPiAg
IGlzIHN1cGVyc2V0IG9mIEVFQyB0eXBlDQo+IC0gdXNlIERQTExfTU9ERV9NQU5VQUwgaW5zdGVh
ZCBvZiBBVVRPTUFUSUMsIHdoaWNoIGlzIGNvcnJlY3QgZm9yIHRoZSBpbnB1dA0KPiAgIHBpbnMg
dGhhdCBkb2Vzbid0IGhhdmUgY2FwYWJpbGl0eSB0byBzZXQgdGhlIHByaW9yaXR5DQo+IHY1Og0K
PiAtIHJlYmFzZWQgKGJhc2VsaW5lIGRvZXMgbm90IGluY2x1ZGUgZGVwZW5kZW50IGU4MjVDIHBh
dGNoZXMgbm93KQ0KPiAtIGFkZGVkIGhlYWx0aCBzdGF0dXMgbm90aWZpY2F0aW9uICh0aHJ1IGRl
dmxpbmsgYW5kIERQTEwgc3Vic3lzdGVtKQ0KPiB2NDoNCj4gLSBhZGQgY29ycmVjdCBzdHJjdXR1
cmUgZm9yIHJlYWRpbmcgc3VwcG9ydGVkIGhlYWx0aCBzdGF0dXMgY29kZXMgYW5kDQo+ICAgdXNl
IGl0IHRvIHBhcnNlIHRoZSBvdXRjb21lIG9mIDB4RkYyMSBBUSBjb21tYW5kLg0KPiAtLS0NCj4g
IC4uLi9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pY2UucnN0ICAgICB8ICA4MyArKysr
Kw0KPiAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvZGV2bGluay9oZWFsdGguYyAgIHwgICA0
ICsNCj4gIC4uLi9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZG1pbnFfY21kLmggICB8ICAx
MiArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2NvbW1vbi5jICAgfCAx
MzYgKysrKysrKysNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9u
LmggICB8ICAgOCArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RwbGwu
YyAgICAgfCAzMDEgKysrKysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2RwbGwuaCAgICAgfCAgMTAgKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9tYWluLmMgICAgIHwgIDExICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jICAgfCAgNDYgKysrDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5oICAgfCAgIDEgKw0KPiAgMTAgZmlsZXMgY2hhbmdl
ZCwgNTkxIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IFN1bml0
aGEgTWVrYWxhIDxzdW5pdGhheC5kLm1la2FsYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29y
a2VyIGF0IEludGVsKQ0K

