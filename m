Return-Path: <netdev+bounces-153019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220EA9F696D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685E1188D4B3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FF1C5CCF;
	Wed, 18 Dec 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXZlkn+V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A71B425F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534227; cv=fail; b=faL1vZbecuNyvvTSp1m5q5XjDncTmwyT8CfR+c0OOZqTf4Mq/n5JjOlqzZYxbaV/YGEwesqUy8xGl+5NuQCeo9vdyXJKP/9Cpov7jeuuyXp+j3TvetZd95WkS66A2jMHaMM0l7H/KqrDrTEg63/yCdbZf/RM2CHCLK+r3ZCSGyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534227; c=relaxed/simple;
	bh=wXkkuMZc4v/qJxRaSPkbtt3BRPtC9SqhDZwHxWJobVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xaz71LBgmbPYb3g8gYov5TNji/y8uygfFetaD9UTcNaB+rZcaRS957x2p7e4tC/xAualSYDWBLe3C5skvW7Ln8C9vz9iojYa9pxegFyc5F9TN1d93hFOgMmMQtbGeZ3lEdWNw6DJNpb5N6nmWBlFVCCtdm+gN+4idZRXrsOSwz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXZlkn+V; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534225; x=1766070225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wXkkuMZc4v/qJxRaSPkbtt3BRPtC9SqhDZwHxWJobVc=;
  b=KXZlkn+VqVdkrff/Ve//FSEAu0QHSRKAaTCZPAFwxpPuvXKYxNl2wFD4
   +dmInsmIqZpt88aMWZl0SWDvyC7eXhyEUt3U7oVox4rDEreHeQzLMPI8W
   9zqe/0AYG+T19vilveC0BM0fObsaaAocmdEbNzlh8V7rReLVntn5AEAJy
   rtzFkyqMmOiWciHy+g13p7vRowmlO4ZMLAPk+2Az2n59jd1s3SPPC2g8K
   ASU7gstQP+LTGDvTsyH0RIqclHRzMUcoVLhpetCUKcdYuChHQdL1sJXge
   Ze8rcthL02T+nVJJvSFFeX8PYZNxlWAoxM4oChVL7gqayDuwXj669oQ2Y
   Q==;
X-CSE-ConnectionGUID: fFwP9rgKT6G7MM6xdMGXIg==
X-CSE-MsgGUID: D8SchcAcRg6+8rbj8QWjRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45503029"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45503029"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:03:45 -0800
X-CSE-ConnectionGUID: 9MHuD8GJSpSX6QuI2FQ8Rw==
X-CSE-MsgGUID: RQDrbHIYTDK2cLT2nylaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121149440"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:03:37 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:03:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:03:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGxl5h1F5hvGW30T8wy5Qs91gojKCqzmOa4/gsacLJB20JIEeoug/e+r54uewNleKI2rTm4yfz4ZqMILBBurytOIGmZ1Gksgp7SoZpF+OzEPX2eFmBQNtePkgi50wycTE4se1PVXFfUQNdgky5KxinBLMUUheX+V5mc/pj7jJFBsSJuUk2ySlbctQiEqGLkUko4GcRIvUZiljcSLOIUdm6P4RIiHayiHIeVM/4deU9y0qvlrS6ZDuErI8C+SvYnVOlh9BZkDMNWOo1ai5cortSQPuNqtz7djcKMTX12zYTaQrAX+Or/gyJpJPNikYgb20zjhsT0COEuHFgyNUvAkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXkkuMZc4v/qJxRaSPkbtt3BRPtC9SqhDZwHxWJobVc=;
 b=cA/3RhLESoJb8j8tgBE4I6FBxn2HRJIWs1Uqc4vaQuXU3a5mZIrdE5YsDZcEfLMy6pAjEsKFtIAB0Byh25PkOI3DgUh4USW4A7wsVoxuqbnDniJ60JGUPy3ViAxHQv2U+PGuo9g5Mz+pEmDB6U8Hsl5TYMR6Ce/VorZHfLJuJXgFQI8GPtMHABI+Ce3F+HBA5TzhonKtx0WHYVqH1FDAdZfZYA0OGo1KHuAYQQfK6n8xFnJlEL7RlDHz9EDRj5WFcnV5IRnZJO1VPE2hBkOcPYeLxvju1eKuNPtyW9JpVgVKOWQoA7aMs/woiec8/8bMrErBf5X0GFRJoXHbuS0L0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:02:44 +0000
Received: from PH7PR11MB5885.namprd11.prod.outlook.com
 ([fe80::b1f3:809e:5b8a:c46e]) by PH7PR11MB5885.namprd11.prod.outlook.com
 ([fe80::b1f3:809e:5b8a:c46e%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:02:44 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Linga, Pavan Kumar"
	<pavan.kumar.linga@intel.com>
Subject: RE: [PATCH v2 iwl-next 07/10] idpf: add Tx timestamp capabilities
 negotiation
Thread-Topic: [PATCH v2 iwl-next 07/10] idpf: add Tx timestamp capabilities
 negotiation
Thread-Index: AQHbP/oCOLXQoexp/UG82XBQ8RX6U7LOaVQAgB3R1PA=
Date: Wed, 18 Dec 2024 15:02:44 +0000
Message-ID: <PH7PR11MB588553078B0F4CCA7C3E8D868E052@PH7PR11MB5885.namprd11.prod.outlook.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-8-milena.olech@intel.com>
 <6749dfcc21228_23772a29463@willemb.c.googlers.com.notmuch>
In-Reply-To: <6749dfcc21228_23772a29463@willemb.c.googlers.com.notmuch>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5885:EE_|MW3PR11MB4732:EE_
x-ms-office365-filtering-correlation-id: 2df2e0fa-4e5c-4db5-1384-08dd1f75070b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a09qUm9rZjZrUHFzOEM3eGlMYUR5ZUR5Q3FRc29JRm9JMXo3YlgxaTlTanc2?=
 =?utf-8?B?MkVaZExXR0wwekZrcDE5YUlPWXlxQ2JaUHZYZ21SRDRkNzJWQ1FEeWhDcWlU?=
 =?utf-8?B?emtoMWJTNWpmOHo5N3hKQU91WmpCUzB0dVJPbXhDZmM2dWVBbzZ2NHZnZGlZ?=
 =?utf-8?B?MEhVY3Z4WUdqWDk2dkZrT1dSa2laUlBMbmFhMGc3ZU1Ccmg5elRZWXNlVDRh?=
 =?utf-8?B?d2l2bmgyZit3MnBJcFNMUVc5SUtrRytNWEoySkVWYkxVNlBZVFdMN1NTa3g0?=
 =?utf-8?B?cHJPaDIyR3lqZWRnK1lLbHQ0Q1k4TDJxc2w2Mkp1dUxhOWpCWEFJb2JLTE9i?=
 =?utf-8?B?MkhqWnd1emh1QmFtamlta2FnWExVT1dic0ZUN0F4WnV2UHdUejJvRGIyWGpE?=
 =?utf-8?B?bHFVc0NDMGdIU2d5T0dMcmlvR0s1M2ZlM09vR0k0TXRrSTZ0eEpUNnNWS1Bz?=
 =?utf-8?B?eTY3ZXpPNXRXYkpoUlBrNXk1YWFweDkxby92dUJTMlE2bTlHNUdzM0EyamVt?=
 =?utf-8?B?ZkN4MExhNWllZFhZUXozbDBRU0U2bHM1VEpUQ1g4WEoyTTFQbXhjOGpRQ0Nw?=
 =?utf-8?B?SGFlYkVKR3NkQkpsc2Q1b3JyTlVoRFFCc1JsWGZacTAzbStMVEZXbGNBK2F1?=
 =?utf-8?B?Nm1WUmV6Ty81dG4xODJnT0pTbjgzL1dKb2FmcmtOUXhsVm92ajYrOExvbEhL?=
 =?utf-8?B?dzZQSjRHOFQxZml3WnhVZHY5R3F4alJMS0RuemFiM2tuMytDU0xMaXVsU21K?=
 =?utf-8?B?YVZubmJpMTFoUmJrNzVXMHVpWlZkQlBlM2FxTkZFYmpqK1c1TlA4QmRHODM5?=
 =?utf-8?B?d1JNNGJhSDVQQmJrQ2xyVUdicXZQcnplZDVreFhxWUFzTHZJWkpnNmJUcWFj?=
 =?utf-8?B?OGtVTS95RWg0ZnFWVThKc0hOZjlteG92bkR0L0tFZnhmWDVzM1J1TStzYzZx?=
 =?utf-8?B?NGI0YnBGbURyWmNzZWhaQzBYK0lKdzcxcXlSeEdRYVg1UlRDU2FoNnkvWDF4?=
 =?utf-8?B?bTY4NWs1aVRrM3o5SG40SWxndTJKQ1ZMa1NEOWdtMlU4ZkFmR2ZzcVY1TjlD?=
 =?utf-8?B?L1F1QVRUREVoL1Nwb21MU24zRTRGMDFQQVJxRGRjT2EyMW16alRmVzcrSUpD?=
 =?utf-8?B?Qm5uSTRzRkRsNEVMWWFjV0NrSkQ2ck5sdHU5Zy9Ramw2TXJ2dHR0TG5jQW1C?=
 =?utf-8?B?R0kyd1doRVlneldRRUxpY1BZVUZuTSthaWpJcGdGUjVBdmVHekxVYkc4cGNv?=
 =?utf-8?B?enpUb1B4a0ZNdGJuaWVaQm41Wk1iekdCYkwwa2Eyb3g4Yk9weCs4NVlqWVpS?=
 =?utf-8?B?d0pZYnBFVVA1b0hGckJRc002ZnFiY29oMUJzRzFGa1prN25vWXhFdURseXow?=
 =?utf-8?B?c29TMHc4UyswQzNSbkJyNE5KY1ppSENOaEo0alNIeXdCUElML3hxYTNQT1FR?=
 =?utf-8?B?RWlJOElpeEhWdTdmb2pQNW9JalM4QjdNQ0E3cnZ5UUZYU3VXQ3VWVGJXMk5O?=
 =?utf-8?B?UzhzM3ZWMmxsMlVNODkvTkZ5MlluM01pWmtHNUhUMjdVTzQ5RGMwVHZ3U240?=
 =?utf-8?B?bWFrbzNVOXQ2a0tIVHZTcElCNTJKaWdsUUpPbXVVbnVtU2dSZ2xUT0FCaHV0?=
 =?utf-8?B?eWg4dGh1MFhyY3kwaEpNdzNRMW0vWWhEUGlzUzI1S3NaeXlmdkhwMXA3N001?=
 =?utf-8?B?U3BNMGJRV1FhWmlGamYwU3U1Lys5M3UyR0dKbndDTm0vRkt0UUxCSVd2ZG8v?=
 =?utf-8?B?RlJ4dTFnNXhJdUdIaG8rSVVuYitldmVCUGtxMThjM0VlODFkaTVKRVR1KzY3?=
 =?utf-8?B?NklIWVJVVkwvM0tUdThtNU1kcE0yREhYR01jcmRJOG5UMmlBd2NrcnlNcGh1?=
 =?utf-8?B?TWlKWXRVK0wrTUs5T2U3Qy9EYWNHL0FyMEovS2hZTUorQXFhUHdBMzY2VTFp?=
 =?utf-8?Q?Yw5ZeHYDHE43qxxz6Ok+Xkp6luxUFTJM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGxBeGRpcGFLMnFmeWlHYk5GUzcva0pVUmRsNkNqRmM5SDNWY3plZ0tmU3RT?=
 =?utf-8?B?YTV4TGdJbkk1UGI4ejgxRWhTZTN2Vy9MU29NN2MzdEFoc2NLR0c0bjhjMnhH?=
 =?utf-8?B?ZGNpU3dZOU9ZUkRtaGNzc0VuRlpTeUszclZCS0pRaWNrcVA0aDdJRlQ4M3R1?=
 =?utf-8?B?YS9DVU94RTU3QzE2RGtFUVA4SjJMZHErV0dCMUlVN0tsK1k1UkdhcWFVRDZE?=
 =?utf-8?B?b2YvSXVLTWdUMmUrcE5UdlhjeHdiemdNYnkvZWZkNFo0R2JFWVBjd3VDeEx3?=
 =?utf-8?B?byt1YTFlVXFqazdEYjQwaEo5R0FoV3hEbk9lSmloSjFjdkxHbWhXYlpsUU03?=
 =?utf-8?B?UHBwL1BtSysyY2V5UVlGSmNhQXJvRy9sdzFyUCtteTdXUkwzdjhoK2FCaFhT?=
 =?utf-8?B?aGNpYWlPcVIxVWMxQzVsWmxVOWVjLzBWMjA0aGc5MWVTWmYrVnV1M1JuTFpx?=
 =?utf-8?B?MDJWUC9lMkI0VE9SNVhSeDhaSjlQRHV0a2FLQldsbkhTeUowRUE1eHlpRGx4?=
 =?utf-8?B?cXZCK3lXZTJ6QXpzdC91ZVNiUXN2STVyTm9qem1acnFuVGtocGFtRTJzQklp?=
 =?utf-8?B?amY4SVFBeHpmOGJlSlBpYVFLaDNiVWZQWjFsc01TYlg5Nm8rZGZLanBXZ0xK?=
 =?utf-8?B?eUtHcHdZckZmakpzTTJ1bTltWXRkYjZHN1oxbnU1ODJuQ0ZqQiswSmc4WUh5?=
 =?utf-8?B?WWtUQTMwNmhMUm1Bd1NoU2dXNVlnTit6M1hBQ3lGSjdEc3RaRHZzOFYwTFpV?=
 =?utf-8?B?cXhKS1phSmdMN0NpaGlwaVkwQjBqQ2VqM2pQWVFkc3pvZTR3L0d6UHQ1bXhF?=
 =?utf-8?B?RE1iMU90U3BNTVZHdmtlVkM2UjBZK1FvcnNzRkhZUjFwemtCeW5TRjBDZUxD?=
 =?utf-8?B?MnhpTUZTMy9RUldBdEw0QThaUUlsTE5KK2JYU3FlU1dxMThBeG1mbUZUTkto?=
 =?utf-8?B?SFVXRUJ3SGV6ZDF3S2RVMFpUeitMWk85K3dzVUlHYVpJY1h1SmduOEpKVlRI?=
 =?utf-8?B?WTd0OTF3bWZhNDJiejdzcjFJVk5DOVlNS25MY3J6MXNDUnhsMmpsSTZKcDFN?=
 =?utf-8?B?MUtmZzBONVg3Z1prZlpqUHZnM01KZjhtUC91V003QisxK1Z2TSsxK283TkIr?=
 =?utf-8?B?Q2dNTEtPbmlOTjlvNUhvemRYTTVLeGRveWZDQjhEc243V0FqRi8yd3hrSW1q?=
 =?utf-8?B?cUhUUkwvUURTaFhsMmh1RE9tcFlYUDlueWhhTnlWK2RsaWJtSTQwVGEzbG53?=
 =?utf-8?B?VzBSdXg1VTg1MXZvNlRmTG1ONXhCNCsyMno5UHNQc21GY2FMb1lXNngreFZG?=
 =?utf-8?B?L1J5ZmEycFhXQWJmenFHNTVuWVhKZ3U5bElESTRPb0NpbVBXbUg1clJ4SGYy?=
 =?utf-8?B?dll5N01LM0RlcjhtdWhSNUZhaHVQbWdqZ1pmcHdyMFhhenRNaVJzY2xiVXpO?=
 =?utf-8?B?QVJXckU3UVdOdG5acXNuTEZNaENiN3V0RDRBN2lJR2VQcE80c29hTzlTSXFm?=
 =?utf-8?B?Z2VjYnc0bTZMeG44LzNQOXRwUHZ3SncyZitPTkZJMHcrVHRZVWVoRmlKNnE5?=
 =?utf-8?B?U3BvakNaOGZxdlNTanJLNVZqbW0vMTVHdGhFV01QSTc5MFVGUnhnenkzN2Ra?=
 =?utf-8?B?N0s1SUxoMUw5M1d6em1vSjJJZEY5c2dibStuMDhrN3BIZ2NzYm5TeVMxTnVr?=
 =?utf-8?B?QitJcU5xdVBUaUFNeWMwQUpvUkR5OWRuNXdPV3hEdjFEVUVzeFk1S0ZHc0RR?=
 =?utf-8?B?aTVoNS9FOG1zTTIrK1hqcmlRUkpsNEtPUGlORG91eU5LM05MSEcyelNVNXM2?=
 =?utf-8?B?M0NOR3U5aFR0bHhRMFpJMTdJNUJKcGpZUlhUeHI1SWVMTmJwaVk2aFhqQWpN?=
 =?utf-8?B?NnpNKzVidVhMN1RJcHpMSTVvOUZNLzUzM0JwcCs3WmtxNGpKbTQyOUVQa3hG?=
 =?utf-8?B?Q29YWHVjLzY5M1ZrOGcwaDNtYUd6S0F4SFhKekJ3Q09ZU0Q2bG1OU0dLZllQ?=
 =?utf-8?B?MG9BQ0dyZE5aUyt1RjdFYXBhL25SVi9rL1hSR0R4ZGxqQ1pwaHhpWHJKOFQ3?=
 =?utf-8?B?OGFzd01oaWsyMVBOZTBUa3d2U29tN3phcHQreU1PYWxhVllEVGdoUzI2R1hS?=
 =?utf-8?Q?K0pRmdJxZyo1QsxGH2xVGvRM9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df2e0fa-4e5c-4db5-1384-08dd1f75070b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 15:02:44.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6/WPKtM/DnUhzUzdUiPQK3ArxWCvUtgV58UlW4olEZpn3pRqgAIqgWGU/NS3U8uWY+xoswUs5UxNeGB9CkAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com

T24gMTEvMjkvMjAyNCA0OjM4IFBNIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6DQoNCj4+IFR4IHRp
bWVzdGFtcCBjYXBhYmlsaXRpZXMgYXJlIG5lZ290aWF0ZWQgZm9yIHRoZSB1cGxpbmsgVnBvcnQu
DQo+PiBEcml2ZXIgcmVjZWl2ZXMgaW5mb3JtYXRpb24gYWJvdXQgdGhlIG51bWJlciBvZiBhdmFp
bGFibGUgVHggdGltZXN0YW1wDQo+PiBsYXRjaGVzLCB0aGUgc2l6ZSBvZiBUeCB0aW1lc3RhbXAg
dmFsdWUgYW5kIHRoZSBzZXQgb2YgaW5kZXhlcyB1c2VkDQo+PiBmb3IgVHggdGltZXN0YW1waW5n
Lg0KPj4gDQo+PiBBZGQgZnVuY3Rpb24gdG8gZ2V0IHRoZSBUeCB0aW1lc3RhbXAgY2FwYWJpbGl0
aWVzIGFuZCBwYXJzZSB0aGUgdXBsaW5rDQo+PiB2cG9ydCBmbGFnLg0KPj4gDQo+PiBSZXZpZXdl
ZC1ieTogQWxleGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+
PiBDby1kZXZlbG9wZWQtYnk6IEVtaWwgVGFudGlsb3YgPGVtaWwucy50YW50aWxvdkBpbnRlbC5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbWlsIFRhbnRpbG92IDxlbWlsLnMudGFudGlsb3ZAaW50
ZWwuY29tPg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBQYXZhbiBLdW1hciBMaW5nYSA8cGF2YW4ua3Vt
YXIubGluZ2FAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogUGF2YW4gS3VtYXIgTGluZ2Eg
PHBhdmFuLmt1bWFyLmxpbmdhQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pbGVuYSBP
bGVjaCA8bWlsZW5hLm9sZWNoQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gdjEgLT4gdjI6IGNoYW5n
ZSB0aGUgaWRwZl9mb3JfZWFjaF92cG9ydCBtYWNybw0KPj4gDQo+PiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWRwZi9pZHBmLmggICAgICAgIHwgICA2ICsNCj4+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfcHRwLmMgICAgfCAgNjkgKysrKysrKysrKw0KPj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9wdHAuaCAgICB8ICA5NiArKysrKysr
KysrKystDQo+PiAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdmlydGNobmwuYyAg
IHwgIDExICsrDQo+PiAgLi4uL2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubF9wdHAu
YyAgIHwgMTI4ICsrKysrKysrKysrKysrKysrLQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lkcGYvdmlydGNobmwyLmggICB8ICAxMCArLQ0KPj4gIDYgZmlsZXMgY2hhbmdlZCwgMzE3
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGYuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYvaWRwZi5oDQo+PiBpbmRleCAxNjA3ZTk2NDFiMjMuLjE0YjgyZTkzZGFiNSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZi5oDQo+
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGYuaA0KPj4gQEAgLTI5
Miw2ICsyOTIsNyBAQCBzdHJ1Y3QgaWRwZl9wb3J0X3N0YXRzIHsNCj4+ICAgKiBAcG9ydF9zdGF0
czogcGVyIHBvcnQgY3N1bSwgaGVhZGVyIHNwbGl0LCBhbmQgb3RoZXIgb2ZmbG9hZCBzdGF0cw0K
Pj4gICAqIEBsaW5rX3VwOiBUcnVlIGlmIGxpbmsgaXMgdXANCj4+ICAgKiBAc3dfbWFya2VyX3dx
OiB3b3JrcXVldWUgZm9yIG1hcmtlciBwYWNrZXRzDQo+PiArICogQHR4X3RzdGFtcF9jYXBzOiBU
aGUgY2FwYWJpbGl0aWVzIG5lZ290aWF0ZWQgZm9yIFR4IHRpbWVzdGFtcGluZw0KPj4gICAqLw0K
Pj4gIHN0cnVjdCBpZHBmX3Zwb3J0IHsNCj4+ICAJdTE2IG51bV90eHE7DQo+PiBAQCAtMzM2LDYg
KzMzNyw4IEBAIHN0cnVjdCBpZHBmX3Zwb3J0IHsNCj4+ICAJYm9vbCBsaW5rX3VwOw0KPj4gIA0K
Pj4gIAl3YWl0X3F1ZXVlX2hlYWRfdCBzd19tYXJrZXJfd3E7DQo+PiArDQo+PiArCXN0cnVjdCBp
ZHBmX3B0cF92cG9ydF90eF90c3RhbXBfY2FwcyAqdHhfdHN0YW1wX2NhcHM7DQo+PiAgfTsNCj4+
ICANCj4+ICAvKioNCj4+IEBAIC00ODAsNiArNDgzLDkgQEAgc3RydWN0IGlkcGZfdnBvcnRfY29u
ZmlnIHsNCj4+ICANCj4+ICBzdHJ1Y3QgaWRwZl92Y194bl9tYW5hZ2VyOw0KPj4gIA0KPj4gKyNk
ZWZpbmUgaWRwZl9mb3JfZWFjaF92cG9ydChhZGFwdGVyLCBpKSBcDQo+PiArCWZvciAoKGkpID0g
MDsgKGkpIDwgKGFkYXB0ZXIpLT5udW1fYWxsb2NfdnBvcnRzOyAoaSkrKykNCj4+ICsNCj4NCg0K
U29ycnkgZm9yIGRlbGF5ZWQgcmVzcG9uc2UgLSBJIHdhcyBPT08uDQoNCj5JIGRpZCBub3QgbWVh
biB0byBtYWtlIHRoZSBjb2RlIGxlc3MgcmVhZGFibGUuIE15IHN1Z2dlc3Rpb24gd2FzDQo+DQo+
ICAgICNkZWZpbmUgaWRwZl9mb3JfZWFjaF92cG9ydChhZGFwdGVyLCB2cG9ydCkgXA0KPiAgICAg
ICAgZm9yIChpbnQgaSA9IDA7IHZwb3J0ID0gJihhZGFwdGVyKS0+dnBvcnRzW2ldLCBpIDwgKGFk
YXB0ZXIpLT5udW1fYWxsb2NfdnBvcnRzOyBpKyspDQo+DQo+SSBzZWUgdGhhdCB0aGlzIG5vdyBy
ZXF1aXJlcyBkZWZpbmluZyBhIHZhcmlhYmxlIGkgb3V0c2lkZSBvZiB0aGUNCj5sb29wLiBJIHN1
cHBvc2UgYmVjYXVzZSBvZiBhIHBvc3NpYmxlIG5hbWVzcGFjZSBjb2xsaXNpb24gb3RoZXJ3aXNl
Pw0KPg0KPlRoYXQgY2FuIGJlIGFkZHJlc3NlZCB3aXRoIHRoZSBzYW1lIHN0cmluZ2lmaWNhdGlv
biBhcyB0aGUgb3JpZ2luYWwNCj5jb2RlLiBCdXQgdGhlbiBtYXkgYXMgd2VsbCByZXZlcnQgdG8g
dGhhdC4gVGhlIGZvbGxvd2luZyBpcyBubw0KPm1vcmUgcmVhZGFibGUNCj4NCj4gICAgI2RlZmlu
ZSBpZHBmX2Zvcl9lYWNoX3Zwb3J0KGFkYXB0ZXIsIHZwb3J0KSBcDQo+ICAgICAgICBmb3IgKGlu
dCBfX2lkeF8jI3Zwb3J0ID0gMDsgXA0KPiAgICAgICAgICAgICB2cG9ydCA9ICYoKGFkYXB0ZXIp
LT52cG9ydHNbX19pZHhfIyN2cG9ydF0pLCBfX2lkeF8jI3Zwb3J0IDwgKGFkYXB0ZXIpLT5udW1f
YWxsb2NfdnBvcnRzOyBcDQo+ICAgICAgICAgICAgIF9faWR4XyMjdnBvcnQrKykNCj4NCj5QbGVh
c2UgY2hvb3NlIHdoaWNoZXZlciBwYXRoIHlvdSBwcmVmZXIsIGluY2x1ZGluZyB0aGUgb3JpZ2lu
YWwuDQo+DQoNCk9rLCBzbyBpZiB5b3UgZG9uJ3QgbWluZCwgSSdkIHByZWZlciB0byBrZWVwIHRo
ZSBvcmlnaW5hbCB2ZXJzaW9uLg0KV2lsbCBmaXggaW4gdjMuDQoNCj5Ob3QgZm9yIHRoaXMgc2Vy
aWVzLCBidXQgYSB3cmFwcGVyIG1pZ2h0IGFsc28gYmUgaGVscGZ1bCBmb3INCj5pZHBmX3Zwb3J0
X2Zvcl9lYWNoX3J4cS4gVG8gaXNvbGF0ZSB0aGUgc2luZ2xlcSB2cyBzcGxpdHEgaW4gb25lDQo+
bG9jYXRpb24uIEkgc2VlIHRoYXQgY29tZSB1cCBhIGNvbWUgdXAgdGltZXMgaW4gdGhpcyBzZXJp
ZXMgdG9vLg0KDQpTdXJlLCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSBmb3IgdGhlIGZ1dHVyZS4N
Cg0KVGhhbmtzLA0KTWlsZW5hDQo=

