Return-Path: <netdev+bounces-301152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XA6sACRYOWqfqwcAu9opvQ
	(envelope-from <netdev+bounces-301152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:43:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA86B0D69
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:43:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MoyrL2iS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301152-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301152-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 831753050C8E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184583B7B8E;
	Mon, 22 Jun 2026 15:38:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B638331D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:38:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142723; cv=fail; b=eBr8wDtLnOML61r6MehsKlXyKZOkdntxv7CZGz7gDMVaMWk3y8mtZW8RNqQFxfUjcHkXFt0L8G2uI2bmqpV9D2sjShuzYmdYoM8GpBLDT9dN/IISCGnabmMLr8osNd7hcs6Uu6D/2KBoBfY/1diiFfgAmuSrUx9bA5DX5QKn8AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142723; c=relaxed/simple;
	bh=95fqy5yOIVJQXYFxXiiuNOZQmhsdTJCoemUKoCBpT+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdmqIbjyP08eh0Hm4ntG9FdgJV8xbWFvXgYGQO12P4rNEq/khAwUQtexvr6vnKjc9smxeKf9yE3NX1ozSFEjtzG8tJalBu1SPrVyOA1Xs+MlPepIOAKtPgQWdkaOM2HlD9uycdyxiRaBbUJY0uoZ+1qtgmJxSQ8u7K7SBXWGVNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoyrL2iS; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782142721; x=1813678721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=95fqy5yOIVJQXYFxXiiuNOZQmhsdTJCoemUKoCBpT+Y=;
  b=MoyrL2iSicoYaJKOOfVFHKatJOjCkRgcPabL7WODT7ffUJf5UNYfXESb
   A/sBzCI5+IWoN9S62CNNDJzkFJ1BsYV+vheJprUiWFoLsOJ9qEKRBI1tx
   Bq1fDtY2uvsosd8nSDFjWeEUN4aGxnWCLeeqCvjGZG1e4mxRd5eoiyXBg
   RCQbJyxrQdzDQXfkatg5SytnYUUMPKAx9Md93t7VI301ASaQq/1dW+8je
   dlk8BlQrVD7NLtjz/gvrXI+LUdsYlbYxUk3rBp8+tUVdMepoiJoaPTc0W
   YKM4J5uI5NZcDiXeMA1dmceOCaRBNwc63AnW/RMvNf4beUSSKzbz6xedJ
   w==;
X-CSE-ConnectionGUID: OW7gf4vjRFyDTJ8skUubvQ==
X-CSE-MsgGUID: u78kw899Qu67V74adpXjMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100426886"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="100426886"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:38:40 -0700
X-CSE-ConnectionGUID: QkdUGtC0SWKUgz5Kb25vcA==
X-CSE-MsgGUID: P4tjV9HmSXmN3i2z6Eo6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="279440192"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:38:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:38:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 08:38:39 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3iwi3sLFo4S960O8yYZicbMnX90Qwe1is/F087/3ibruGs/YdTvVM2M5RYxdiw6enGi/mG+XqjjEILloX+0K1ouV1TeF8NK5RGFtgWVoFh/Gyly8mX8B7xdae1eywPwNMvSZ6vUVH/dtjs/PYZa9QkUQz5MCj2jIYJXFaqMDlVJ0aiv+gbDsO9jMx5rrhQZaP19uIwsgqGuvgbi8mX8xXCbBbH/9RCkhzXgO9xM4nEEzAYNDeW1ggwBwQddjJpYI7QxSUv9OTkmNc6ClM27+qtNGbk2AbziE87AZRcjWxR5wTh1hyYVnow6cY8XpiCQWXYNWu61Z7MSOJn4Ydx63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95fqy5yOIVJQXYFxXiiuNOZQmhsdTJCoemUKoCBpT+Y=;
 b=I1fMcj3d5SmFegkfgqisI9lNzcUyiVz9z7aKVMvVivJU6WZNEinCqSdjxS0tRPhZ1I3L5nNxaY4bmYKVE/Z1f534j/Xmf3LcNLdtVsWu+y2UYVFb84vdOxbMmrY1nT2sglAXeF+fZx+gBKmXIjWqy2ZSZNLaxH8aQ+S511brfB50t8zKWRSlDQBFr1XNBENonWsTk9Qpo705YLYqP3yzDlqpJqebVI7b3Lt8gYMm6NoBk28utd7fdVZEos90GozWXBBSYTFcL4E125g/5VUzDBJ788i5uQvYTGt6BfEiKW/w/YLIgRIYaABMDkXB3OVYFjzA2cnjmDJn/XC1ypax8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by IA1PR11MB6491.namprd11.prod.outlook.com (2603:10b6:208:3a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Mon, 22 Jun
 2026 15:38:30 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0113.020; Mon, 22 Jun 2026
 15:38:30 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: Alexander H Duyck <alexander.duyck@gmail.com>, "lee@trager.us"
	<lee@trager.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>, "D H, Siddaraju"
	<siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSA=
Date: Mon, 22 Jun 2026 15:38:30 +0000
Message-ID: <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
In-Reply-To: <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|IA1PR11MB6491:EE_
x-ms-office365-filtering-correlation-id: 6a738fde-8df4-4575-28da-08ded0744f9f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|3023799007|22082099003|6133799003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: Z2euUesD3Benp/vUXcEd3usqtM07PRTSy7Sxr+B70L8paCMFZnygNvmrvj6pE5Jpvd3dc2yTaxwwQCANN1qlZ66mnefflOC9YzkUawbEVb6ozrgr4uH5VnZWiBp3XS1CVB7U+GB88bma2JgU6/G3MlFrDbyXtDpxBtVxsgcH68zUGn3z3c89UnWguCNKD4Z9al4x099ZLObdpeU27IzDKxNUD1SKWOWNefNld+soqv/5ZLKX63xEsQwv5BOneOWgE50kIHmjuVhrmNDpMVoRZVbjjS/ErFff5LDye/eUQbx1zFKb68S+FHioe26bj7Fb+jRkZi47nSo87Js6G5K94BO66CbBSCCOC2Uu0BOa/VJyDz+0vJlSgSsTcES3lHog+PyRQwa1vf0vh5pQH+7iKYQRaDdd4tMEDHQAy3CkbkEiIs84yej7pOP6KSy9ZB+Npgvk7I+PSuVO2TF7Q+ypcxdVNp1mMSGeHn8VN2ZAYa8UOEX9pZOSBVe0pjN8OekYPLTC8FNQReBGuw1X1HnUS6vK7BOC7KeouV/5R3y/bJ6wA0Af+JgVNPXCsnTNiGusDH2whsvQqtsU0Z6dfPNOrfLTG/hWdsEak28Bz6+1/l4ofgbZk6FzUlGQ4JZUwiLh86HMzDgyXZzZT6mD70DvoXauwKTJ6yjEbiy1t0XcSLojLDyyEPmYDZycOHZMoXAbmmA9DLdmxWTbkc/KaOjTzefOw+Eww6yJLIKGJSqvrN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(3023799007)(22082099003)(6133799003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFFmNmRaaENpUWN2N1lBQjNTUXZtOSt1bmgzRXFmeG0zSENpamlmMmhiUFZB?=
 =?utf-8?B?NXRqbTExcVNRaWJVemI1QzlFY214WkpQbUFWdE15YWlzZmxrbWFZdHZEYjc0?=
 =?utf-8?B?RlVUWXB6ZGovVmdsdGYzQVZzUmVMeU9OQzYyZGtYMi9DOXVZZCtBZUlLVlVZ?=
 =?utf-8?B?aUdZbTZ4U055cG91MzFSTWtxbEZCV0dXTlpGQXI2M1JRT0syMHhNTlMxWG15?=
 =?utf-8?B?K2pnV28wbFZTLzBMb0xnQllTUXdkNFFrdDBwbTl1bzhSbkRHT1orYURWaTBJ?=
 =?utf-8?B?b3duMmllRk1SbVpoOWpHQURCSlBmRUtUR0liais5bC9WbWJyRjg5dENSVlpj?=
 =?utf-8?B?NnhFQUVXU3U0b09YS0hEM1Ztd1lkYmFSbXNHY2FPWFNpbFR2SktlVWlLdVJW?=
 =?utf-8?B?SldOQUhJQ3lqTFp6YjM1clZjTHhiY1djWFVsRVBnTkl4ZWdwWElyLy9WK2tp?=
 =?utf-8?B?Y1BralYzS3ZrMTMxSS93Yjh6azZBc3hmZTNtYmQ3NVk1Tk8yNXZuUnFRMFVw?=
 =?utf-8?B?aWZoem5URmFkOWhBMHBYQ2JvUUE3ZXlhUmdLZUNOcUtmSDVnRk9RQ3Eyc0lE?=
 =?utf-8?B?K1dLRUUveTFmVC9PUlpNTTdaY2thSmVZMjFnVjJlbDBrUzViL0VTSWpzV1Zy?=
 =?utf-8?B?emkzSEY3aW1yTEZ3U1R5Mis1cEtKZ2x5MFVGbzlVaU9vQkNYN0pueWRpeUdE?=
 =?utf-8?B?UnBVZTRWeTVFSVV0cU5ERDMrV2QvVmNPdStiVkEyVXRSSERkaEUza2NaZmYx?=
 =?utf-8?B?b2VSbzM1OHptMkhLaVRYZ2FUSWlZTlVmVnBrVDZmSUczK3RuQVljM1dEaXJV?=
 =?utf-8?B?eDdEYXJwdU5OSWNKbnRRQlNHblM3VDBPQ1MxajRXaFRCVkRaY01NYkVNSTRJ?=
 =?utf-8?B?T3liZU9DUnlEMUF4UktRaXNDU2FlOHhxNXpFM1dnQ3VETDk5cytad01JWGR2?=
 =?utf-8?B?a3Vya0NwY1ptOTc4aDJJaDVMOTVoY0FoYjFvbFhMbE9EZERBeWpFeGtjbExJ?=
 =?utf-8?B?S0FHNm91bkV5OTJuVjJaWXl0SzV1TjRzdXpqcVA0OUNRMmVMRkx3NCs2bm5J?=
 =?utf-8?B?L3E4dkdOU1dwVEcycDF4akh3UzVGcXY2Q0hxK2FtL3Q2OHR1ME1OQUNkNmJO?=
 =?utf-8?B?aFBGa3Nxd0RWSVFmdVpRSGl2SVh2cys4UVlZMmZ2TG5UUkhzU2c0bzFFUmNi?=
 =?utf-8?B?cmgrcTd4SzlWVHBvNlYvYklFcG0xSWdoMjMzc3p1STBkSjlmWHFuM0dCSnJI?=
 =?utf-8?B?cXA4ZjUzQVgvVkZMcHZZWjd1L2o3RGhuWllEY0tUVTBRYkhDcUppNGY3TGkz?=
 =?utf-8?B?MnpaZVhnNkMraFJ4MlNHZlFFTG1ZcjB4SStCdTJLTVFIWStsVDVoVlNUTUlE?=
 =?utf-8?B?dlZLYy95VnFTeDk5dm9IQUdCUXpyQUM4SVoxVE9DcjdQNHdCdTJjQTFzSnhE?=
 =?utf-8?B?LzY3YTR2cDE0QStWREMyUSttdklJSlZHRGNoaXYwR2NJbGdGRUtaRU5DaHFI?=
 =?utf-8?B?Qm5takRyaHBwRmExaW8zakI1aGlXZWttWUhBTTVxM2ZpaXVYM0tLV2t6M2xJ?=
 =?utf-8?B?UkNDM2hGMHFsWEtLQVQ5UVZ3RUhNek9kVjNiYjhZelJBdWFiREZ5Y01TcEh6?=
 =?utf-8?B?UE1kTFo0Sm1VUm0yMEEzS3ZLUmZ6Y2dtdXlYSFJQWXBtVnBGY3FFQ24xK0ta?=
 =?utf-8?B?UFVydFRDQTRrQjlZTm5RK2E1Y2dkcEVYQTBaWEp4VEVBL2YzeTNKWDFLOGxY?=
 =?utf-8?B?SXZCOU4vTW1RQVA0ejBkMjNRaERYT2ZtYkFXZXZMbFBRaXpnRmlDaFN5S0VK?=
 =?utf-8?B?cWNaeERZNm8xOENIeWZ0SDM0dkJzekRqZ0RQMDhSbEZ6eERyWS9yRktLajRl?=
 =?utf-8?B?VS9DODcxTW5SakE4ZFNvelVwVUJLYXZKQ1lQM2pvVnV1ZUhWNDgvNU90c21E?=
 =?utf-8?B?T0trNnBEeDdEdmVEcTQzMy9UdHpSbVpkNFVxRXZpcU1heVVwd0FkMWNlWWpa?=
 =?utf-8?B?NDFQZ1haMHZjNVVDT3VxQlZpd0RkZmdOOTFwV1M0ckVNalBpU09jVWtacWMr?=
 =?utf-8?B?Ylp2dU5pRFl0REJPOXpiaUhldUJxdVpNbGhyYi84UXlHdHpnYjYxS0dSOFQx?=
 =?utf-8?B?R1VFTVdqLzIwZkh2b3hOejZ3Z0xJZUFFYTlDYzVOeHRSbE5NWkV6TkJQNUN4?=
 =?utf-8?B?VnkrejNxdUdjL0YyVnU0QkF4UFpkNlk5WHNmWDFpb2ZFamhycjRSeDU2cXlK?=
 =?utf-8?B?SVpIb0dZQ0JjOHpPTG1maDZUM2VodzdvakVHS2haWXZzUklJU3VBWUZxWnVj?=
 =?utf-8?Q?1HbvCKSA2z6FXTKc+J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZG+rcbwxB6H6m0GKT0K2bh/2YpIDba44oRZft0VZxr7AMprMQ8t/VVKoGeWIvcULUQO4ysiNEvwc+s1Mu6oU84kZ3HzVfZxWloHfneQlNm+HF7/v1tHs9GRkikWRPXNC3ePYmPzIR5F5LsRQBonhbm71ZWqlZZ0Njl9KvIS9zlZ4G6TT+3xJ5mNgQOe6geShNbMEn5ztcHvMA+PZKIbuqtjRKrqHsGHMVPBTS9GVwH4c1xRNUIJNInbxe+lwX+IKmyvvTUMiFeHYXef2ekrrlwzD1z8rYxEOpIFyLIP5lA8r1hsjuQmCAoOu/qWck6pAN7LBWsXjFcSPqdnY3L8gCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a738fde-8df4-4575-28da-08ded0744f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 15:38:30.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzRpRvPXakt0TU82ToBx1Nq0+RtfAng89tAu9w93OVnJ4Gvt8kaLBn0O6Vd3y/viF0BZmorPv7C7UxR64Eja1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6491
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301152-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:lee@trager.us,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,intel.com:dkim,intel.com:email,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email,suse.cz:email,ericsson.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,trager.us,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44FA86B0D69

SGkgTWF4aW1lLA0KDQo+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHdoYXQgeW91IGhhdmUgaW4gbWlu
ZCBmb3Igbm93ID8gd2hhdCB3b3VsZCB0aGUgImV0aHRvb2wgLS0NCj4gcGh5LXRlc3QiIGNvbW1h
bmQgbG9vayBsaWtlIGluIHRlcm1zIG9mIGl0cyBiZWhhdmlvdXIgYW5kIHBhcmFtZXRlcnMgPw0K
DQpXZSBhcmUgdHJ5aW5nIHRvIGNvbnZlcmdlIG9uIGEgdXNlcnNwYWNlIHVBUEkgZm9yIFBSQlMv
QkVSVCBmdW5jdGlvbmFsaXR5IHRoYXQgY2FuIHdvcmsgYWNyb3NzDQpkaWZmZXJlbnQgaGFyZHdh
cmUgbW9kZWxzIChQSFktbWFuYWdlZCwgTUFDL05JQy1vZmZsb2FkZWQsIG9yIGZpcm13YXJlLWJh
c2VkIGltcGxlbWVudGF0aW9ucyksDQp3aXRob3V0IGV4cG9zaW5nIHRob3NlIGRpZmZlcmVuY2Vz
IHRvIHVzZXJzcGFjZS4NCg0KQmFzZWQgb24gdGhlIGZ1bmN0aW9uYWxpdHkgd2UgY3VycmVudGx5
IGhhdmUsIHdlIHByb3Bvc2VkIGJlbG93IGNvbW1hbmRzIGluIGZpcnN0IGVtYWlsIDoNCg0KUFJC
UyBUcmFuc21pdHRlci9DaGVja2VyIFBhdHRlcm4gQ29uZmlndXJhdGlvbjoNCmV0aHRvb2wgLS1w
aHktdGVzdCBldGgxIHR4LXByYnMgcHJiczcNCmV0aHRvb2wgLS1waHktdGVzdCBldGgyIHJ4LXBy
YnMgcHJiczcNCg0KQkVSVCBUZXN0Og0KZXRodG9vbCAtLXBoeS10ZXN0IGV0aDIgYmVydCBzdGFy
dA0KZXRodG9vbCAtLXBoeS10ZXN0IGV0aDIgYmVydCBzdG9wDQoNCkJFUlQgVGVzdCBDb3VudGVy
IFJlYWQvIFBSQlMgTG9jayBTdGF0dXM6DQpldGh0b29sIC0tcGh5LXRlc3QgZXRoMiBzdGF0cw0K
DQpCRVJUIENsZWFyIHN0YXRzIC0gU3ltYm9sIGFuZCBFcnJvciBjb3VudGVyOg0KZXRodG9vbCAt
LXBoeS10ZXN0IGV0aDIgY2xlYXItc3RhdHMNCg0KVFggRXJyb3IgSW5qZWN0aW9uOg0KZXRodG9v
bCAtLXBoeS10ZXN0IGV0aDEgaW5qZWN0LWVycm9yIDENCmV0aHRvb2wgLS1waHktdGVzdCBldGgx
IGluamVjdC1lcnJvciAxZS0zDQoNCkRpc2FibGUgUFJCUyBQYXR0ZXJuIDogVFgvUlgNCmV0aHRv
b2wgLS1waHktdGVzdCBldGgxIHR4LXByYnMgb2ZmDQpldGh0b29sIC0tcGh5LXRlc3QgZXRoMiBy
eC1wcmJzIG9mZg0KDQpBcHByb2FjaCB3b3VsZCBiZSB0byBhZGQgYSBnZW5lcmljIGV0aHRvb2wg
bmV0bGluayBBUEkgZm9yIFBIWS9TZXJEZXMgYW5kIGFsbG93IGRyaXZlcnMgdG8gaW1wbGVtZW50
IHRoZSBvcGVyYXRpb25zIGRpcmVjdGx5LiANCkNvbmNlcHR1YWxseToNCiAgICAgICBldGh0b29s
IOKHkiBldGh0b29sIG5ldGxpbmsg4oeSIGRyaXZlci1zcGVjaWZpYyBpbXBsZW1lbnRhdGlvbg0K
DQpXZSB3b3VsZCBhcHByZWNpYXRlIHlvdXIgaW5wdXQgb24gd2hldGhlciBhIGNvbW1hbmQtYmFz
ZWQgbW9kZWwgaXMgc3VpdGFibGUgZm9yIGEgdUFQSSwgYW5kIGhvdyB3ZSBzaG91bGQgZGVzaWdu
DQppdCB0byBhY2NvbW1vZGF0ZSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24gbW9kZWxzLCBzdWNo
IGFzIFBIWS1iYXNlZCwgcGh5bGliLWJhc2VkLCBhbmQgTUFDL2Zpcm13YXJlLW9mZmxvYWRlZCBQ
UkJTLg0KDQotIFNodWJoYW0gRA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE1heGltZSBDaGV2YWxsaWVyIDxtYXhpbWUuY2hldmFsbGllckBib290bGluLmNvbT4NCj4g
U2VudDogMjAgSnVuZSAyMDI2IDIwOjA5DQo+IFRvOiBEYXMsIFNodWJoYW0gPHNodWJoYW0uZGFz
QGludGVsLmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gQ2M6IEFsZXhhbmRl
ciBIIER1eWNrIDxhbGV4YW5kZXIuZHV5Y2tAZ21haWwuY29tPjsgbGVlQHRyYWdlci51czsNCj4g
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbWt1YmVjZWtAc3VzZS5jejsgRCBILCBTaWRkYXJhanUN
Cj4gPHNpZGRhcmFqdS5kaEBpbnRlbC5jb20+OyBDaGludGFsYXBhbGxlLCBCYWxhamkNCj4gPGJh
bGFqaS5jaGludGFsYXBhbGxlQGludGVsLmNvbT47IExpbmRiZXJnLCBNYWdudXMNCj4gPG1hZ251
cy5rLmxpbmRiZXJnQGVyaWNzc29uLmNvbT47IG5pa2xhcy5kYW1iZXJnQGVyaWNzc29uLmNvbQ0K
PiBTdWJqZWN0OiBSZTogRXRodG9vbCA6IFBSQlMgZmVhdHVyZQ0KPiANCj4gSGksDQo+IA0KPiBP
biA2LzIwLzI2IDE1OjQ4LCBEYXMsIFNodWJoYW0gd3JvdGU6DQo+ID4+IENhbiB5b3UgY2hhbmdl
IHRoZSBmaXJtd2FyZSB0byBleHBvc2UgdGhlIDgwMi4zIHJlZ2lzdGVycyBmb3IgUFJCUz8NCj4g
Pj4gWW91IGNhbiB0aGVuIHdyaXRlIGEgbGlicmFyeSB3aGljaCBib3RoIHBseWxpYiBhbmQgeW91
ciBkcml2ZXIgY2FuIHVzZS4NCj4gPg0KPiA+IEFuZHJldywNCj4gPg0KPiA+IE5vLCBleHBvc2lu
ZyB0aGUgUFJCUyByZWdpc3RlcnMgdG8gZHJpdmVycyBpcyBub3QgcG9zc2libGUgaW4gb3VyIGRl
c2lnbiAodGhlDQo+IHJlZ2lzdGVycyBhcmUgYnVyaWVkIGRlZXAgd2l0aGluIHRoZSBBY2NlbGVy
YXRvci9OSUMvUEhZL0FuYWxvZyBJUCBoaWVyYXJjaHkpLg0KPiA+DQo+ID4gQWRkaXRpb25hbGx5
LCB0aGUgUEhZIFBSQlMgcmVnaXN0ZXJzIGFyZSBub3QgaW4gYWNjb3JkYW5jZSB3aXRoIHRoZSBJ
RUVFIENsYXVzZQ0KPiA0NSBkZWZpbml0aW9ucy4gRm9yIGluc3RhbmNlLCB0aGUgUFJCUyByZWdp
c3RlcnMgYXJlIHBhZ2VkIGFuZCAzMi1iaXQgd2lkZS4NCj4gPg0KPiA+IEdpdmVuIHRoZXNlIGNv
bnN0cmFpbnRzLCB3ZSB0aGluayBldGh0b29sIC0tcGh5LXRlc3QgaXMgYSByZWFzb25hYmxlIHN0
YXJ0aW5nDQo+IHBvaW50IGZvciBleHBvc2luZyB0aGUgbG9uZy1lc3RhYmxpc2hlZCBFdGhlcm5l
dCBQUkJTIGZ1bmN0aW9uYWxpdHkgdG8gTGludXgNCj4gdXNlcnNwYWNlLCBhcyBpdCBhbGlnbnMg
d2VsbCB3aXRoIHRoZSBkcml2ZXItb3duZWQgTklDIGFyY2hpdGVjdHVyZSBtb2RlbC4gSWYgeW91
DQo+IHRoaW5rIGEgbW9yZSBnZW5lcmljIGxheWVyZWQgYXBwcm9hY2ggd291bGQgYmUgcHJlZmVy
YWJsZSwgd2Ugd291bGQgYXBwcmVjaWF0ZQ0KPiBndWlkYW5jZSBvbiB0aGUgZXhwZWN0ZWQgYXJj
aGl0ZWN0dXJlLiBUaGF0IHdvdWxkIGhlbHAgdXMgYmV0dGVyIHVuZGVyc3RhbmQgdGhlDQo+IGlt
cGxlbWVudGF0aW9uIGNvbXBsZXhpdHksIHJlcXVpcmVkIGVmZm9ydCwgYW5kIGRlbGl2ZXJ5IHRp
bWVsaW5lcy4NCj4gDQo+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHdoYXQgeW91IGhhdmUgaW4gbWlu
ZCBmb3Igbm93ID8gd2hhdCB3b3VsZCB0aGUgImV0aHRvb2wgLS0NCj4gcGh5LXRlc3QiIGNvbW1h
bmQgbG9vayBsaWtlIGluIHRlcm1zIG9mIGl0cyBiZWhhdmlvdXIgYW5kIHBhcmFtZXRlcnMgPw0K
PiANCj4gVGhpcyBmZWF0dXJlIGlzIGludGVyZXN0aW5nIGZvciBtdWx0aXBsZSBwZW9wbGUsIGVh
Y2ggaGF2aW5nIGRpZmZlcmVudCBoYXJkd2FyZQ0KPiBkZXNpZ25zIGFuZCBjb25zdHJhaW50cy4g
SXQncyBnb29kIHRvIGNvbnNpZGVyIGFuIGl0ZXJhdGl2ZSBhcHByb2FjaCB0byBidWlsZCB0aGlz
LA0KPiBob3dldmVyIHdlIG5lZWQgdG8gaGF2ZSBpbiBtaW5kIHRoYXQgdGhpcyBpcyB1QVBJLCBz
byBvbmNlIHdlIGNvbW1pdCB0byBhIGRlc2lnbg0KPiBjaG9pY2UsIHdlIGhhdmUgdG8gbGl2ZSB3
aXRoIGl0Lg0KPiANCj4gV2UgZG8gaGF2ZSBmbGV4aWJpbGl0eSBvbiB0aGUga2VybmVsIHNpZGUg
b2YgdGhlIEFQSS4gV2UgY2FuIGltcGxlbWVudCBQUkJTIGluDQo+IGdlbmVyaWMgUEhZLCBwaHls
aWIsIHNvbWUgTUFDIGRyaXZlciB0aGF0IHRhbGtzIHRvIGEgZmlybXdhcmUsIGV0Yy4gYW5kIGhp
ZGUgYXdheQ0KPiB0aGVzZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIHRvIHVzZXJzcGFjZSwgYnV0
IHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoZSB1QVBJDQo+IHdlIGNvbWUgdXAgd2l0aCBhbGxvd3Mg
dXMgdG8gc3VwcG9ydCBhbGwgb2YgdGhhdC4NCj4gDQo+IExldCdzIGZpZ3VyZSB0aGlzIG91dCB0
b2dldGhlciwgaWYgeW91IGFscmVhZHkgaGF2ZSBzb21lIGlkZWFzIGluIG1pbmQgd2UgY2FuIHVz
ZQ0KPiB0aGF0IGFzIGEgc3RhcnRpbmcgcG9pbnQgZm9yIHRoZSBkaXNjdXNzaW9uIDopDQo+IA0K
PiBNYXhpbWUNCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gU2h1YmhhbSBEDQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQW5kcmV3IEx1bm4gPGFuZHJl
d0BsdW5uLmNoPg0KPiA+PiBTZW50OiAyMCBKdW5lIDIwMjYgMDA6MDcNCj4gPj4gVG86IERhcywg
U2h1YmhhbSA8c2h1YmhhbS5kYXNAaW50ZWwuY29tPg0KPiA+PiBDYzogQWxleGFuZGVyIEggRHV5
Y2sgPGFsZXhhbmRlci5kdXlja0BnbWFpbC5jb20+OyBsZWVAdHJhZ2VyLnVzOw0KPiA+PiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBta3ViZWNla0BzdXNlLmN6OyBEIEgsIFNpZGRhcmFqdQ0KPiA+
PiA8c2lkZGFyYWp1LmRoQGludGVsLmNvbT47IENoaW50YWxhcGFsbGUsIEJhbGFqaQ0KPiA+PiA8
YmFsYWppLmNoaW50YWxhcGFsbGVAaW50ZWwuY29tPjsgTGluZGJlcmcsIE1hZ251cw0KPiA+PiA8
bWFnbnVzLmsubGluZGJlcmdAZXJpY3Nzb24uY29tPjsgbmlrbGFzLmRhbWJlcmdAZXJpY3Nzb24u
Y29tDQo+ID4+IFN1YmplY3Q6IFJlOiBFdGh0b29sIDogUFJCUyBmZWF0dXJlDQo+ID4+DQo+ID4+
PiBUaGUgaG9zdCBkcml2ZXIgZG9lcyBub3QgZGlyZWN0bHkgYWNjZXNzIGFueSByZWdpc3RlcnMg
YnV0IHJlcXVlc3RzDQo+ID4+PiB0aGUgUEhZIEZXIHRvIG1hbmFnZSBQUkJTIG9uIGJlaGFsZiBv
ZiBpdC4NCj4gPj4NCj4gPj4gTWF5YmUgYSBkdW1iIHF1ZXN0aW9uLiBXaHk/DQo+ID4+DQo+ID4+
IENhbiB5b3UgY2hhbmdlIHRoZSBmaXJtd2FyZSB0byBleHBvc2UgdGhlIDgwMi4zIHJlZ2lzdGVy
cyBmb3IgUFJCUz8NCj4gPj4gWW91IGNhbiB0aGVuIHdyaXRlIGEgbGlicmFyeSB3aGljaCBib3Ro
IHBseWxpYiBhbmQgeW91ciBkcml2ZXIgY2FuIHVzZS4NCj4gPj4NCj4gPj4gCUFuZHJldw0KPiA+
DQoNCg==

