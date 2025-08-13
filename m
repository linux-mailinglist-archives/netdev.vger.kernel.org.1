Return-Path: <netdev+bounces-213309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C495B24823
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B7D3A9D25
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2602F2907;
	Wed, 13 Aug 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcBmZ6cp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AE1A9F9E
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083653; cv=fail; b=r81U2zKYxRaBIFmBIAvEumNT+2KBF0DB2SC/ReiWVmKRyyRzFcrlGwltaP1uVBG0utbyUbyX+3VPjTKB7nUrfDNHc6YShLmHqVXBQJflvecZ13SlyJ8CEAH9dxBZ+9pFg68r+FhSfknF4LnRGxjvNh8Ejn2gxPqcjtMI3SALXWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083653; c=relaxed/simple;
	bh=9hAEWlB2eogBlxk6TXBdgsJF6WPvQmPeMirwwY095wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALUnfxxhYU9IHJ3lpvNKs8kNXRw5H+n0V7K+bxLZA+dcbbS86yX/J5iVu3c44Pl9sneXdoNtzIII9Fa4sUfc1WWf/D5F7e0dj2lYFxCocCokC+8dh3DmdPsYXDKC+LYusACX75ZGA6c/C1W0uL1jXAMDcfiV6fOoIYiiNTc3KWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcBmZ6cp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755083652; x=1786619652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9hAEWlB2eogBlxk6TXBdgsJF6WPvQmPeMirwwY095wk=;
  b=JcBmZ6cpsre4UsUogVNzOlpBWJl6apCtGLwKombRcivbAJfUyxx8vTU0
   qOvKvp0o1TyA/QTe1glPJiibs1jTJADp+ZZ0kgrruaM/5XHW+iTu+eF3R
   mt193AZF4uy3ckk3B+36NXyCxlNHUeIaqBZjgvTZOu/U7sWwQ3cc9JiFm
   yigJNVx/O2WySF4CRuFsq6AzyDTYq6qFhwNE66veiFT2gJ3QtJR4yRw3U
   0IcwUuSEsLW42uvlUYcL7FTxlXv7JNM7Uq8ejEf0t1ed+6c8ZG+gvMgKz
   DkiDeLSwBOHC9Ec5Sw5pFwiWmsRlmUbJ7mZoDcgRoTD42NqJYb1FeA04r
   A==;
X-CSE-ConnectionGUID: m87xaWADSyCyYkT/OuOfdQ==
X-CSE-MsgGUID: e4eO8fHkTLiAa9yKtj6zYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57452831"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57452831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:14:11 -0700
X-CSE-ConnectionGUID: 4Uc9e2xxQL+liStxsrj+Gg==
X-CSE-MsgGUID: C4dujp1vSKKi9iHanHc+xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166712410"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:14:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 04:14:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 04:14:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.40)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 04:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF2hc0GEt18CSKTslsTpwnwjHuxSuFC7xCGIG9tdFbZ5r0VwTEaxx0GRRwAjzMYTy/G+2prxYIy6ECoFiq+pWGqEsQVuwcyLMYB7pyeWBhMal5d261GZCnBKlZ92Qr75TEEhxy0VzgfMmq6cotaBO11tI6WnRjyEmfGZc965UB4JhjihEVBtMnRGLImOXvtSrNDqTkdcStUixEz3fbCk99SiJDLONqJpJZppKkHDLtELmm3LLGxN36BBb1Ccs3M1xWU1bher4zeV1oQ7U4c+KWgdpbA1DEfpLXnFzNzbPux1SWnPJHrw8DYM4G1PkOtIdzYHIvsPrZQpzYEVURZWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hAEWlB2eogBlxk6TXBdgsJF6WPvQmPeMirwwY095wk=;
 b=C6utoXCLh9Egv8NN5SqQjljFCkEmk8NkOT3vRFnjFXw1NYxJ2jpSFtlXwM4VdnAeK1sMLeR6hVhKKE3MXMUF5y+A3cX1iQLo0LCR97tAFpah4JDkDdxpr+BzuGQ1uXUTPHrMAku1C/AOlJstQXThlVrbBxW/OJfBoNOh/xUYXXVUCob7Ra+hVeG6sWEPJkChPYAii+ZdxvWhm5DhwRRT6qKd2GPtlsKNF4dQcmP2KP+WDf7TiyL2akvOV7PNVl2R7AJhdx8iO8ir8DqB1AKxL3GuKiFohrGVBP9YmNDKQ1wz6ilwplcB8iJb3AyknuNh08vE5UojdsJzbYD4F2QFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:14:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 11:14:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/3] ixgbe: xsk: use
 ixgbe_desc_unused as the budget in ixgbe_xmit_zc
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/3] ixgbe: xsk: use
 ixgbe_desc_unused as the budget in ixgbe_xmit_zc
Thread-Index: AQHcC15/WwIEy6U4Zkim7V6fTriaNbRgb0/w
Date: Wed, 13 Aug 2025 11:14:08 +0000
Message-ID: <IA3PR11MB89869A1D876059D6EBCB64E0E52AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
 <20250812075504.60498-3-kerneljasonxing@gmail.com>
In-Reply-To: <20250812075504.60498-3-kerneljasonxing@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8771:EE_
x-ms-office365-filtering-correlation-id: 8ae6d560-86cd-4a3e-f91f-08ddda5a85b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?T0ZsWW9JVnpCQkJ4azdFTTg2WlhQd0lEYTd0WjJKbjRqMHBZUlhzZktLYUhs?=
 =?utf-8?B?ZnlvaE5CS2MvTTNZVWNvWE5HalV1YTlhSVhSdVRyUTY0Y3lpeTRtb01BUnRH?=
 =?utf-8?B?UnJiYUhvampWMFBWTFJ0ai85KytEM1QyUVMwY0ZYeDBVYUo4cFRlemwzV0FV?=
 =?utf-8?B?U1R6TnhHMVp5N0F4SjdML2RDaHlVVTVzazArUXR3dXNzYThkWmk4YTRDenBj?=
 =?utf-8?B?RDhsYWNJSElFMGJ5MDlmams3bXZlL0liNjZSSlFlNFZpYmhObTNYQWpOcHdO?=
 =?utf-8?B?anVGMm05cDd1cUJmOSs4Z01nazFsT3Jyd2FnZWl4Vk9kd0xkQTZ0cFZsVFMx?=
 =?utf-8?B?RnEvelRpZnNFSTd0ODNWeExnaEhTdFEzckJrVU5PRi9sT3dPOEZ2NWN0a2Zy?=
 =?utf-8?B?UFB2NStNUWRHLzhaenIwNVVmNWNqUGRONUkwaGRPOGNYUEl2V0JndlpHN004?=
 =?utf-8?B?Vy9wNUExL09SOFhEODRBM0ZPb1AyZUlUUHRqNC9xb1Q2cVNJajR6Ry9tMFI3?=
 =?utf-8?B?bStxUk9qV2QvQVFVcUJYWGx5eERjYkZWSm1DRE9vSGxxTFZod1kwRjk3ekxW?=
 =?utf-8?B?Z3Y5Nk83ZGJRM0Jab25HWGJqVHJKay9ScEozTExrMlVwWGF1c3RkSXZpRm1u?=
 =?utf-8?B?UWVFdDRLdklXb3V1N0NBc1U2eC93eGdsRENaWUNUdUZRRFRaMFhKQitIVFJN?=
 =?utf-8?B?NTRCcTdia2g5Z1FqRFRFaHV0c2N5RUJwK0ZZd200dGlRcXhEZUFHbFlVVEo0?=
 =?utf-8?B?a2E2TGRuc1FORUtHMVlGWXI5bGJlaE0yYm5OS2JDekgzSCtYM0JFMjFEUnhR?=
 =?utf-8?B?N1NBd1lIQUx4bkpGSGlVelZFYm53ZEFGUytSZk5aSEJaaEd6MVpMdkQzVU5W?=
 =?utf-8?B?WUFSUzdOVER6ejJGenlFMzVXOTRNTHR2MjdWNnJKdDhEM05kZ29UTDlqQ21l?=
 =?utf-8?B?bzhWZHVzM1FYYTc3MzBkV3l5cnpEMzZnNGJMVkZJUy9zN0xvYzFkQ1BORGpp?=
 =?utf-8?B?TWt1K3MzU1A3TjZtZ1lkcTBhbVc3eGNBK0FlZFExdG43eWtWeDN3YWx4UUhK?=
 =?utf-8?B?Ym9NYlpSQkdibUQ2cVZsWFlWM0RSYUFmbEFKeTE0TjRhWkRwTStFekJmRnJT?=
 =?utf-8?B?SWU1SlVTV3VIcEhTMDZsbzlXOXFISTNQaVdKcEdUS3AzVVV3K1RCS0pKajda?=
 =?utf-8?B?dmFMSkdtOWJyTzI5VVRjMW5tblNLeWF4OFJQSFVMbE0xaDF1Y0FGQ3BOZXNh?=
 =?utf-8?B?QVlRbFZmVFd0UVByQUNwcWdkbitzNGNxMGE3M0NYaEI4Q29mOHpnRzdZMjZD?=
 =?utf-8?B?YWdNOVFTTWQ1RUk4dzNMdkFrQWJBWExpcHhHdnp3TVJpT1JaTmdtOFQzSElL?=
 =?utf-8?B?WFF5S0hoOUs1ZnlCWWQxbmRuL2ZvWFZ6WGNURmdCUFlnVExRSWtLamRzMUZC?=
 =?utf-8?B?d1pNNDhiQU9nVUJSU2Ira21QOUJOV1F3V0txMVNkYiszbys4UHVoUDdGSVdD?=
 =?utf-8?B?S2Nkd2E5VGZhcWYwVGRGWVdCazhnWmlPUStXSDNvajNIS0RMWE1UdHdvS3d3?=
 =?utf-8?B?ZFFLT3NPd0tnMjRieUwrb1Z0NnpqUEp0Zkh6bCtneEFGdlNlb3I5clcxYytr?=
 =?utf-8?B?eDc3NkZKczR5SnMyYzJqZ0syYXdtSmM5YXM5cVA5Z1dxcjB5OU5rRnlibThD?=
 =?utf-8?B?KzI0MHFtWWNjNXVkUFN0UUM2cUo2K05BTlBpMEhUMWlIckpTNGY3UVp5SHA0?=
 =?utf-8?B?QU1ocDNDWFd2UkY2L2FpMzBoR2FCbTkvaGIzR3dmMlczSUVhbzI2K0FPNjFU?=
 =?utf-8?B?RC8wNjcxbGVZNk1qdExFUDM0VjU2VHNCdVhqMk4zTjJ1cTcvd3JzUzA5bW4r?=
 =?utf-8?B?YWlRN1NzY05iSFl5Sy9pUXRyd1E5QUJpM050WFpkc2QzOVd3SjA0VWJOUkRh?=
 =?utf-8?B?eTJ6T3U4b08vbUU0Wng0bFh4VGpRRmhOYWVFVFNhQlA0MmVzbWg3Yzd3SEwy?=
 =?utf-8?B?NEdhTnNtbER1N3Z6K3ZPUDdteTE4aFR5SlB3elZxdzN6U2RkSGE4Q1F6OE5O?=
 =?utf-8?Q?5JlKMa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU5KaUhQelVOTkJ3VmRUUWtuUDNGb3JDTy9qa2s3NGxoV1FGRWtGekRIdVJM?=
 =?utf-8?B?OGFDakluZE83Q1JvY3VVNFdyblNQNzFEN0xTelVTTkxtSCtiMlBQMlFmekht?=
 =?utf-8?B?bmJza0ZEazNvdVNvdEI2NTg2bVdpVUJXVHRvSXlBbTYwT2xqbDgveFVuR1JG?=
 =?utf-8?B?S3JPdE94VkwzWjFoRUFJUk5QNlpxM0UyNWlkRU1lR0swcklLRGs5ZUZ3SjJW?=
 =?utf-8?B?VDNKbktQYnVLVG9RclFNSUJobFgwOUFCVGtwdTRSU2pqeWlXTTdnQTVmRTZO?=
 =?utf-8?B?SzZhd0c5R1ZMbG55V0ROTjljM0pTVkFsdGVSR20vOVFDbkdVYXVpdWtmVFBJ?=
 =?utf-8?B?Qis3dm8rRzBmRGVHaHAwaURkNUxkUllVNnJGZnZ4My8vOFhrV1ZLZHJ5aVpZ?=
 =?utf-8?B?dFJ3enp6Yk5YdDl0M1ExM2tQRFNCMkRhRWt1V014bDB6VnorQzRUSFNaR2lZ?=
 =?utf-8?B?cTh4cEw5a1FQVU5jUTB0VEdDLzlaeU4rbVc2alNtNWkzUWVwaElOYkVtQ24v?=
 =?utf-8?B?YTFRcmpXd0ZsL1hSekd3K1RRb201M1J5VlVIaDY4aTVIMW1ETURNS01lcGgz?=
 =?utf-8?B?M2VRQ1dReWN6VWRMY0pxeXV0RTJpSkRNZDBuZ2svb0E5QXpiUGlySjVvZEpq?=
 =?utf-8?B?TTJXUlJnMjd1RnhVYm5EWFB3NFZ4Mk8ybHIvdHBzaGlTNStpWXcwK0NTL2tt?=
 =?utf-8?B?TlFRVmJqT3pLK3NLR1V1UjArTGd0NitUSXliRk1WWUpMeEYxSUowbXArcFcr?=
 =?utf-8?B?Znd3T0pVbkU4eUhvVFBCamlqZVR6Y05sK0JxUzM2bXUxQkx3TTE4SE81Y200?=
 =?utf-8?B?czJycndaNk1IdXRpSVBYeWowYU5MTGFaUnlIMXdBM2FmT1lXb0pXZnpkOFNn?=
 =?utf-8?B?QkZUeFBCRytweFVwbXhrSGhVSUE2VW5XYmY0b2lZZ051UkhjcjMxRmc5MjBy?=
 =?utf-8?B?bGpoNUNsZ09kU0NPaUg4clVXZEZBTlU4ZjFubXU3eHdpeHVQODlhdHRFL0Nh?=
 =?utf-8?B?bFhNU1VEWjhtVDZCSVgyQkc0aTVzNTY5ckhxOXZXdWVicWMrSVZKYkpma1BM?=
 =?utf-8?B?dVgrWkVYMU9UVnVTRk1OczNhOFNhcllxOFFaa0JTdUZ4SlQvVnV4N096TzVh?=
 =?utf-8?B?NUI5a0ZNaVdLOHpQaW5MUDNBS0w1bkhndzZzaWRqTE0xR2ttdUV3SmFTdHpF?=
 =?utf-8?B?YlBjem14YmxybFZQcFpKMHh5QnpyNTg0MlE2MVlqU0lqYzY5MGgySzJUaUNF?=
 =?utf-8?B?V1RXekJYblhoRE95S0JRK0NhOTVKVkl4b3pRZVF0d1I4bi9VUkVuUGV5S1Zx?=
 =?utf-8?B?ZXZaUWRvR2hibnZSZW1iOWZYL1hjZmpuaFRMZDIzeHJQVEFVdldvZTRCMndP?=
 =?utf-8?B?eUo5M0NhVVFEMkpJRi9UYVRRaUJ1cE55eDV4dU9JSVEvTHp0R09Eam91Zk5u?=
 =?utf-8?B?aWhYVmZmc1M1T2xtdkdCcVBEeTNFUS9MOUZ2YVgxazhmWmFIWUN5ZHJ3RFVH?=
 =?utf-8?B?c0dqdUZmNnQ5TmpONGpVUTVFWUlmV0VuUjFkWHUxQ1RuZEtBakZJYkovUkRU?=
 =?utf-8?B?dEc3L1lNZkFHdXR0bWk2b3dTb0ZCWk1kVzMyeU1DZkQ4WmZ1NkVLZmhTdVdL?=
 =?utf-8?B?b2g2VUhpNXRoTUpyclo2U1kyVWlmeXZHTmtUMkxGVWxRNGFETzNhUUFNdldj?=
 =?utf-8?B?TDJ5WFVOdndydG9iN0JuK0czWUtoeDdnMTVtSDIwSXZZSWRBQzFSaGdrZGJ1?=
 =?utf-8?B?TTJyZFhwN3MyNTN0K1pzN1RpbytGbGEwV2E1Y2FSWXJnS1haejg0akJLdWw3?=
 =?utf-8?B?VWlvQXBsVmY0WUI5U1Uxc0FBZUgrVlRmZ21oVWI2Y3dDWG80NTZJaXVJaVBW?=
 =?utf-8?B?bDlZeEEwY1ptVXVIVUJZZDVKRUFRczRZd1ErUStjQlIvRlhOYytPNTBWS3M4?=
 =?utf-8?B?ZFBhSWt2T0JUWGJ3VUplOEJrVkh5TjcyelJ5ZGpwWTU3ZUR6WUFpUjF5SmhO?=
 =?utf-8?B?eG1TZ2V2citJK2RLUkxnUTBEVmFLeTdzQWdweFYwUTNqQ2V1UXphUjk1ZCtU?=
 =?utf-8?B?MnpJa0ovemlkTmxlcnVoUy9mZG5VRE9qcFdhUTJrWlZNWHJiOXArY041b0pH?=
 =?utf-8?B?YTBBTXE5WTlCOHJFRlhySkNIeTlIVXpwbjI0SXl3SS9KQktQVHlVaXNVM3Uw?=
 =?utf-8?B?VEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae6d560-86cd-4a3e-f91f-08ddda5a85b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 11:14:08.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YMKEFotTurvHmblalvWsh0ga+0hvvuT+TTQ4PtPyAo1bh5a05YENBSMaFl6QQyWXtp+Qi94v0tpYgh/9v1Nwunc3EKCyReF3Fa4WVaA2Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFz
b24gWGluZw0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTIsIDIwMjUgOTo1NSBBTQ0KPiBUbzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
Ow0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgaG9ybXNAa2VybmVsLm9yZzsgYW5kcmV3K25ldGRldkBs
dW5uLmNoOyBOZ3V5ZW4sDQo+IEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+
OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsg
c2RmQGZvbWljaGV2Lm1lOyBaYXJlbWJhLCBMYXJ5c2ENCj4gPGxhcnlzYS56YXJlbWJhQGludGVs
LmNvbT47IEZpamFsa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5j
b20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgSmFzb24NCj4gWGluZyA8a2VybmVseGluZ0B0ZW5jZW50LmNvbT4NCj4gU3Vi
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXQgdjIgMi8zXSBpeGdiZTogeHNr
OiB1c2UNCj4gaXhnYmVfZGVzY191bnVzZWQgYXMgdGhlIGJ1ZGdldCBpbiBpeGdiZV94bWl0X3pj
DQo+IA0KPiBGcm9tOiBKYXNvbiBYaW5nIDxrZXJuZWx4aW5nQHRlbmNlbnQuY29tPg0KPiANCj4g
LSBBZGp1c3QgaXhnYmVfZGVzY191bnVzZWQgYXMgdGhlIGJ1ZGdldCB2YWx1ZS4NCj4gLSBBdm9p
ZCBjaGVja2luZyBkZXNjX3VudXNlZCBvdmVyIGFuZCBvdmVyIGFnYWluIGluIHRoZSBsb29wLg0K
PiANCj4gVGhlIHBhdGNoIG1ha2VzIGl4Z2JlIGZvbGxvdyBpNDBlIGRyaXZlciB0aGF0IHdhcyBk
b25lIGluIGNvbW1pdA0KPiAxZmQ5NzJlYmU1MjMgKCJpNDBlOiBtb3ZlIGNoZWNrIG9mIGZ1bGwg
VHggcmluZyB0byBvdXRzaWRlIG9mIHNlbmQNCj4gbG9vcCIpLg0KPiBbIE5vdGUgdGhhdCB0aGUg
YWJvdmUgaTQwZSBwYXRjaCBoYXMgcHJvYmxlbSB3aGVuDQo+IGl4Z2JlX2Rlc2NfdW51c2VkKHR4
X3JpbmcpDQo+IHJldHVybnMgemVyby4gVGhlIHplcm8gdmFsdWUgYXMgdGhlIGJ1ZGdldCB2YWx1
ZSBtZWFucyB3ZSBkb24ndCBoYXZlDQo+IGFueQ0KPiBwb3NzaWJsZSBkZXNjcyB0byBiZSBzZW50
LCBzbyBpdCBzaG91bGQgcmV0dXJuIHRydWUgaW5zdGVhZCB0byB0ZWxsDQo+IHRoZQ0KPiBuYXBp
IHBvbGwgbm90IHRvIGxhdW5jaCBhbm90aGVyIHBvbGwgdG8gaGFuZGxlIHR4IHBhY2tldHMuIEV2
ZW4NCj4gdGhvdWdoDQo+IHRoYXQgcGF0Y2ggYmVoYXZlcyBjb3JyZWN0bHkgYnkgcmV0dXJuaW5n
IHRydWUgaW4gdGhpcyBjYXNlLCBpdA0KPiBoYXBwZW5zDQo+IGJlY2F1c2Ugb2YgdGhlIHVuZXhw
ZWN0ZWQgdW5kZXJmbG93IG9mIHRoZSBidWRnZXQuIFRha2luZyB0aGUNCj4gY3VycmVudA0KPiB2
ZXJzaW9uIG9mIGk0MGVfeG1pdF96YygpIGFzIGFuIGV4YW1wbGUsIGl0IHJldHVybnMgdHJ1ZSBh
cw0KPiBleHBlY3RlZC4gXQ0KPiBIZW5jZSwgdGhpcyBwYXRjaCBhZGRzIGEgc3RhbmRhbG9uZSBp
ZiBzdGF0ZW1lbnQgb2YgemVybyBidWRnZXQgaW4NCj4gZnJvbnQNCj4gb2YgaXhnYmVfeG1pdF96
YygpIGFzIGV4cGxhaW5lZCBiZWZvcmUuDQo+IA0KPiBVc2UgaXhnYmVfZGVzY191bnVzZWQgdG8g
cmVwbGFjZSB0aGUgb3JpZ2luYWwgZml4ZWQgYnVkZ2V0IHdpdGggdGhlDQo+IG51bWJlcg0KPiBv
ZiBhdmFpbGFibGUgc2xvdHMgaW4gdGhlIFR4IHJpbmcuIEl0IGNhbiBnYWluIHNvbWUgcGVyZm9y
bWFuY2UuDQpZb3Ugc3RhdGUg4oCcSXQgY2FuIGdhaW4gc29tZSBwZXJmb3JtYW5jZeKAnSBidXQg
cHJvdmlkZSBubyBudW1iZXJzDQooYmVmb3JlL2FmdGVyIG1ldHJpY3MsIGhhcmR3YXJlLCB3b3Jr
bG9hZCwgbWV0aG9kb2xvZ3kpLg0KVGhlIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwNCmFzayB0byBxdWFudGlmeSBv
cHRpbWl6YXRpb25zIHdpdGggbWVhc3VyZW1lbnRzIGFuZCBkaXNjdXNzIHRyYWRl4oCRb2Zmcy4N
Cg0KPiANCklmIHRoZSBjaGFuZ2UgYWRkcmVzc2VzIGEgYmVoYXZpb3JhbCBidWcgKGUuZy4sIGlu
Y29ycmVjdCBOQVBJIGNvbXBsZXRpb24gYmVoYXZpb3Igd2hlbiBidWRnZXQgaXMgemVybyksDQph
ZGQgRml4ZXM6IDxzaGExPiAoImNvbW1pdCBzdWJqZWN0IikgdG8gaGVscCBiYWNrcG9ydGluZyBh
bmQgdHJhY2tpbmcuDQoNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gWGluZyA8a2VybmVseGluZ0B0
ZW5jZW50LmNvbT4NCj4gLS0tDQo+IEluIHRoaXMgdmVyc2lvbiwgSSBrZWVwIGl0IGFzIGlzIChw
bGVhc2Ugc2VlIHRoZSBmb2xsb3dpbmcgbGluaykNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
aW50ZWwtd2lyZWQtDQo+IGxhbi9DQUwrdGNvQVVXX0o2MmF3M2FHQnJ1KzBHbWFUam9vbTFxdThZ
PWFpU2M5RUdVMDlOd3dAbWFpbC5nbWFpbC5jDQo+IG9tLw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3hzay5jIHwgMTMgKysrKystLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV94c2suYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3hzay5jDQo+IGluZGV4
IGE0NjNjNWFjOWM3Yy4uZjNkM2Y1YzFjZGM3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV94c2suYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9peGdiZS9peGdiZV94c2suYw0KPiBAQCAtMzkzLDE3ICszOTMsMTQgQEAgc3Rh
dGljIGJvb2wgaXhnYmVfeG1pdF96YyhzdHJ1Y3QgaXhnYmVfcmluZw0KPiAqeGRwX3JpbmcsIHVu
c2lnbmVkIGludCBidWRnZXQpDQo+ICAJc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wgPSB4ZHBf
cmluZy0+eHNrX3Bvb2w7DQo+ICAJdW5pb24gaXhnYmVfYWR2X3R4X2Rlc2MgKnR4X2Rlc2MgPSBO
VUxMOw0KPiAgCXN0cnVjdCBpeGdiZV90eF9idWZmZXIgKnR4X2JpOw0KPiAtCWJvb2wgd29ya19k
b25lID0gdHJ1ZTsNCj4gIAlzdHJ1Y3QgeGRwX2Rlc2MgZGVzYzsNCj4gIAlkbWFfYWRkcl90IGRt
YTsNCj4gIAl1MzIgY21kX3R5cGU7DQo+IA0KPiAtCXdoaWxlIChsaWtlbHkoYnVkZ2V0KSkgew0K
PiAtCQlpZiAodW5saWtlbHkoIWl4Z2JlX2Rlc2NfdW51c2VkKHhkcF9yaW5nKSkpIHsNCj4gLQkJ
CXdvcmtfZG9uZSA9IGZhbHNlOw0KPiAtCQkJYnJlYWs7DQo+IC0JCX0NCj4gKwlpZiAoIWJ1ZGdl
dCkNCj4gKwkJcmV0dXJuIHRydWU7DQo+IA0KPiArCXdoaWxlIChsaWtlbHkoYnVkZ2V0KSkgew0K
PiAgCQlpZiAoIW5ldGlmX2NhcnJpZXJfb2soeGRwX3JpbmctPm5ldGRldikpDQo+ICAJCQlicmVh
azsNCj4gDQo+IEBAIC00NDIsNyArNDM5LDcgQEAgc3RhdGljIGJvb2wgaXhnYmVfeG1pdF96Yyhz
dHJ1Y3QgaXhnYmVfcmluZw0KPiAqeGRwX3JpbmcsIHVuc2lnbmVkIGludCBidWRnZXQpDQo+ICAJ
CXhza190eF9yZWxlYXNlKHBvb2wpOw0KPiAgCX0NCj4gDQo+IC0JcmV0dXJuICEhYnVkZ2V0ICYm
IHdvcmtfZG9uZTsNCj4gKwlyZXR1cm4gISFidWRnZXQ7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHZv
aWQgaXhnYmVfY2xlYW5feGRwX3R4X2J1ZmZlcihzdHJ1Y3QgaXhnYmVfcmluZyAqdHhfcmluZywN
Cj4gQEAgLTUwNSw3ICs1MDIsNyBAQCBib29sIGl4Z2JlX2NsZWFuX3hkcF90eF9pcnEoc3RydWN0
DQo+IGl4Z2JlX3FfdmVjdG9yICpxX3ZlY3RvciwNCj4gIAlpZiAoeHNrX3VzZXNfbmVlZF93YWtl
dXAocG9vbCkpDQo+ICAJCXhza19zZXRfdHhfbmVlZF93YWtldXAocG9vbCk7DQo+IA0KPiAtCXJl
dHVybiBpeGdiZV94bWl0X3pjKHR4X3JpbmcsIHFfdmVjdG9yLT50eC53b3JrX2xpbWl0KTsNCj4g
KwlyZXR1cm4gaXhnYmVfeG1pdF96Yyh0eF9yaW5nLCBpeGdiZV9kZXNjX3VudXNlZCh0eF9yaW5n
KSk7DQo+ICB9DQo+IA0KPiAgaW50IGl4Z2JlX3hza193YWtldXAoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwgdTMyIHFpZCwgdTMyIGZsYWdzKQ0KPiAtLQ0KPiAyLjQxLjMNCg0K

