Return-Path: <netdev+bounces-148641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC969E2BD5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7067284A36
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A901FECB7;
	Tue,  3 Dec 2024 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akGC0YhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCC1FE461
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253460; cv=fail; b=loiwoMrAMQzeaEFKTQw7BstI49AXbqaknN58uii0Vtn+llW23SdaIPOWoAiTr41kFgpbzKKaIr42v2QhLepjxRL2bcpOlecDCqvth4dJWfOXgQBZYx2kLy9NeM/rjhkFxirJsXp/SaPYzZWeireViDqS705LYwW4Aa0vei9Ji0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253460; c=relaxed/simple;
	bh=5tGrc/gBNISgVznWcLCxjhJfjnIefenV3UeOb0QJ81U=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWScyvrIeiX/KVv7hE/e9rvBCdCYe5712VEqvfbcO7sprZdLxHUlFo5bVZqAfYb8yxMGgdQHxp2eM/eXNMs5QIgVYuVzlwC1ziYO2CRASKMOzA91d3iAM7h0BpmaKC27cFuovEjmGVF8L6afBJeev5kfchvCeP9xl38BR7mmv9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akGC0YhQ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733253459; x=1764789459;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5tGrc/gBNISgVznWcLCxjhJfjnIefenV3UeOb0QJ81U=;
  b=akGC0YhQ949Q+imJPZ1RExkEAXMrOA3uHqfIAwckno4aL/8o4dYs4HFe
   /nvSwuRnze6CNvYjCuMliJngekoXmtl8tIi9oBG4+nNz5tf558ROcoj7c
   qRuqMiTJpUBYBdmURfOp9rgaTmbB44G+HDkOcWxGpWYeIIPuwpJKnlLR8
   918EX6/6gpS+ZesgUkKEisdZm+MNp36qFmrnZNwE/GG2nfCYyQiaSY7+f
   KPXGDoKDs1bGw9M3ED3PB3474cuRRzx3F9hNfOp/zz44VwHZiLiKw4Ucn
   uxn1RCM3H1anIzmaJoRTROVHgtfVIO/VNcGMeQ/DgJ8qmsvZdXJBuUvSG
   w==;
X-CSE-ConnectionGUID: y2JVvT5lRNCkr1EaRJGMYQ==
X-CSE-MsgGUID: s0C0tdM6TQOqNSuiNJdWVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33365390"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33365390"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:17:28 -0800
X-CSE-ConnectionGUID: O8gxNf1pQo2uAZSsQIW/jw==
X-CSE-MsgGUID: MrNpgqrARFGOsabqE5aK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="116781876"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 11:17:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 11:17:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 11:17:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 11:17:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo+nCmQmBIHxW32JbmFrUoUHInykO3fZCwnF7QATT1zVQPijaQOJWG5QQB2M6uQ0L4Eb9MzRrIOLQiwYBNLPpDt1uUbEUudOF1GQNnTVKoQCMlgJYJUXE6Re+FOXAqKRJxEUJXk9n18ep1+AEyBg6SzXpblWBUHOJW7cjEtNtcQhJFLQ/nj8iZNR6RbBvme/kRI/ruuNNrPaF+PZOJFE722SJvlKh94V04gCpzNwojZFZWfo3sgKsJ1KQh6p9tQ7Fhdr2R+pvpo6y7jYiuhcQoEpvlRN7tgOB0g681UGLvil0Km0bUYVel4bpoReGMns8k7WP3x6fsWlHeCfSx8xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01ioEG9NfnoVE0Ie3MrdPBIzsS9DAxRvqbjx/JeYzwU=;
 b=D9hnJ8dMGarScSEws3IxJ7rY2e+iuvzXxFvQqEW/0VihoyA0LaV2ZY4SXgEIeeYPyAb2GAkMSBVSD3HCi8D7Km21ltvlwQ7vVhMfQYHMTYGRCJY3cpwknHu6iRVIDF/XB4tXSYC3sUPg+GCddidpNyCaP55lCnCcA6Ef7gmJ3wKQJgEGCNGKOQAtReaA6g25qVClU1/m00DbuBdLTiJddXe7nsKMwQeMhSYmXOYEcawxsqxou6yqX6o0SN4sFik6oFnCJyvVY7Ec4kUvFJEJUM/HU0iJ4f7mnbEnxQxi8vJnLsi433jGFgO0JWBeCyvDMpO48VIvO9XTNu7zbn9H5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 19:17:20 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 19:17:19 +0000
Message-ID: <b7bcfc3a-9947-4689-99cd-28c064fc0f1d@intel.com>
Date: Tue, 3 Dec 2024 11:17:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] ice: Add E830 checksum offload support
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Alice Michael <alice.michael@intel.com>, "Eric
 Joyner" <eric.joyner@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
 <20241105222351.3320587-2-anthony.l.nguyen@intel.com>
 <20241106180839.6df5c40e@kernel.org>
 <7aad3452-a08c-4c28-9bd9-3fa1cd1f9b39@intel.com>
 <20241107201427.28e00918@kernel.org>
 <4b22a368-d266-442b-9cad-6c40688f735b@intel.com>
Content-Language: en-US
In-Reply-To: <4b22a368-d266-442b-9cad-6c40688f735b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f29c20c-fabd-43dd-5f18-08dd13cf1b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzVDbkZxY1BQbVpqekRoL2xhTDczSHNGUVU5c3dodENKNC9iYlo3OU83bFRx?=
 =?utf-8?B?SktTTU5BMjdIZ3ZSTkxpS2ZxWElaRVJrQ2VSQmx5dGhHdkt4d3YvWGFaRUh5?=
 =?utf-8?B?YXNJb3FsdE5EbGEyVFRlZ1dZalcyS25TeWhGaSsranJldEpDN20xK3I0NUFi?=
 =?utf-8?B?Yzh2aTRwdkFhdlFrZXJTVzVjRjBNNU9YM0lDZmUzTmlLSGR2STNlM3hMclll?=
 =?utf-8?B?eHlDNjBJR0w0VHFUV2hhbVFFSmh6bGJGVXpwSEwrTmN2Y3BLamppR3FSd3RW?=
 =?utf-8?B?Y3UzTUtSVmxLb1dxQTRlR3lPbFpTNVlKcEFoS3J2SFltZGQrc2VkMHI0QjJE?=
 =?utf-8?B?eEpaU2pPem1VeDBmZld0Z3pZOWVpODFyY3F4N0YwOGVPT3FGMWRDYi9wK05G?=
 =?utf-8?B?RFYzdnhXNGFrVWwzT2l0R25tUzcyUjY1cm1UdEVDTWJScjg3a3BxVHhpVzhr?=
 =?utf-8?B?SEpiR3hmT2dRYnRiQXg0MDFic3MwbHZTNVJOenVja3BVc2NreXREeTZMdzFS?=
 =?utf-8?B?eUxsTXFrWXM2QnJRc1JGUmM1LzFXTlh6dzlDNndLS1FiOVdjcHA4WHE5M3dL?=
 =?utf-8?B?dm01bitQb2V5MmxPMTEycUJDRmNwQTVBMTcrZE9XSWgya1lCZlo2a1Zib0Vw?=
 =?utf-8?B?THRRRHIydWRFY2krTnBvRytyZ0F5M3ZiY1RaQnkvTk14ZDV6SzN1QnFnNDNo?=
 =?utf-8?B?RkNneWVCZ0lPNDloZHZLS25XTnpKbkE1dU5LM0FTTmpLNVAxc0lORm0zbDho?=
 =?utf-8?B?S2crakp4WEE4dXhLTXV4bDBxTUJMMSsvMDV0VEVzdVZKeEVYejJhNC9UaExt?=
 =?utf-8?B?YkhVR3JEQjU1QW5ob0Vjd01pT2srSUprajFSY01ON29iRlowMGdSdXdiVHdD?=
 =?utf-8?B?OXRGZDJtUFR3SUlDUFBVUEk2cERsbEFPMmZudnNkZEowSFpEZCtQbjdFeEVL?=
 =?utf-8?B?b21ncnpEL00reExNV1ErOXRQa3luWHA2UVlPeFUxdUtPWnJKUmpldEJzT2ZD?=
 =?utf-8?B?dVhxYkNvTmlJKzVJdGlJZmo2QlFUcUs2cmVLQXg2ZFNvNlpxckV2dVlOaXp6?=
 =?utf-8?B?bmFla2lUakM3S2FBYW01VUZJWnRhYXpJY0NneDRTdDNuZHpmS3N6cmdFakp4?=
 =?utf-8?B?clcvVURkSnlZM3ByWEpQalZFUFRCd0kzZ01LSVBmTkVpNGFaMUxGZ1Z6aGx5?=
 =?utf-8?B?MmQ2SWdoZXRtUWhxcXFTUVlyc3BjS3hsTUdqL0RLRDFvL3FNSlI4R1d0aW9Q?=
 =?utf-8?B?RW12b2pEY1Q0UzVkRFJyVlh3OGd6WVlXMDY0aENGcDNTYS8xTWZYUFU4TFVD?=
 =?utf-8?B?ZllDZlhFRUR2akdJRmFHRXFEREV2Q2FXekF1dE9mR3F1UG5DazhqZ29wbjBY?=
 =?utf-8?B?Wmd2SFVHcDBLanRuUXdPSTdmY25lZlJzSW5pdFdDM1VuUEJ2VXJTMHp6d3hU?=
 =?utf-8?B?Q09nMWdYNXF4TzN6a2V4QjRoVHROM083VFFVQ0h6dHBGTFBFQUlTSHpsV3BL?=
 =?utf-8?B?MWR4OTAyNVFTSWtsNzh1TW5PNmRyQUs5TWwzdHlEYTE0YjlUdXRiY1V1MXNx?=
 =?utf-8?B?K0JtVnZOam9UQjF3Y1VNVEhWbVhGbnQ2QTFRdGc0SHd5OWdBcThNY1kzVGdo?=
 =?utf-8?B?K0Z2akdCelgzc1o4YlIxZXYvZU9KWlFLR3FwQ0prdFJ1S0k3Umg0enZhN2R4?=
 =?utf-8?B?ZEF0YzBPRUlVWFZ1ZG9WNDMxZ2hnam9Nek1XUmk1THZuTUZnVkNCRkQvMEpO?=
 =?utf-8?B?V3NYU3Fwd3A4K01kaGZFSTh2OVFmRU1QQjhEMnV0WTczakZLMElvSU1aeXJK?=
 =?utf-8?B?dkJBN25FNVJZRFJZVnY5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVweWQrcm83eGdOZHVBYkVlU3ZCS3VuUGR0OVptU0VsQXdyVWYzZGRaUWcw?=
 =?utf-8?B?ZTk3Tm1QQlZoZUZ0SjhoUHhjcWJxcWNmeDBncStUd0RTbCtLcHZ2ekY5cTJt?=
 =?utf-8?B?U2hBWkhBalJyeWt0NDdrN0QzTHhhNGVhbHpnbmIxOWgrNEVPNEt4ZXZqRUF2?=
 =?utf-8?B?QUpTUGZ0dWF5c25kUWN0L2JHZUQxaFhVeXNmOHkwZkg3YTZGbTkyWXZKUDQw?=
 =?utf-8?B?TG9HSG1pSlkxMVJ4OTAwbDYvTGh4Vm16S0JUNkFmclE3alAvZEZkeHFXZFM1?=
 =?utf-8?B?NjJMSTRYemxVSURSNkJyeGU3Z2RackYrYUJIMWI3TTJOQ3JxWHJFcWp1T3Zu?=
 =?utf-8?B?TVp6UTVJMU5naXVzSXVWVURhL3hBU1JqRUJiOHROcDg0MXQrNmJ4eTR2L20x?=
 =?utf-8?B?b1hCQWJPUDBkQ1Z0eFl3VytXcTlsVHFLZ29uUTRGbG8yS3dOUXpCdHZKSm1S?=
 =?utf-8?B?b3M4TDBnait5N2o1WFhSRVVhdmoveU81NURzemE5Z0MyYS8yNVptL0NtZlJw?=
 =?utf-8?B?QjZ6MytLNmI1VHNvNmNsbTFxZzh3aGUvOWkxZXFLWk01dlVENHROOU9qVGxo?=
 =?utf-8?B?aHNGTGlteHUzaUtXd0JQK2Q4OTE0YzdKVmE1em5WLzMxVW9qQTl5TXlOa05F?=
 =?utf-8?B?MlFNQ3BLd0hTcEZVQlI1S1RyK25RR1RuTDlNVjYwajRZT051anFSeDlwOG4v?=
 =?utf-8?B?WVc3UDRsNzBJdTh3TDkxZkhxNFhKRzZTZklpdUdWMkg2WjFyRHlVdTNuSnFr?=
 =?utf-8?B?ZEV0enRkQjZDeWhWNzJLbGtZQTNJK2NlcDF6Q05scGlCNzZYM2l4eGx4TVFP?=
 =?utf-8?B?czF4SDFxMXMwRXdGY1VObjZ6N0srK3FMaWQzR1UzQ1JuSlp5ejJKMUowN3Rr?=
 =?utf-8?B?clFtY1Nla29rdUdsK1M3WW1GS3pwU01ublp4c2lrelRLVGg4NDRSUjlCU1JN?=
 =?utf-8?B?di9SalNGOEREQmpvQmczVVVHQWI2cmxUVFpkVmVCTjU4WnlFUGtzSXhWRTgx?=
 =?utf-8?B?V1I2eVAzNndIQ3ZnWnVWZ0xzYXJDTmdKa21CcnVCYnBtd0pXQmtpdXh4NGYw?=
 =?utf-8?B?Q1luL1h5WFp2Z3hESXZzOUFEVW1kT2dCVDJaYzFyVXVlV2ZvSWJEV09aOXJy?=
 =?utf-8?B?TkJBQytaSTlPcXlYTFV3Z3dwT1NnRUd6R1pWSUwxQTBTcWlybyszeU0wcG50?=
 =?utf-8?B?dS9DY2JLVDZmQ3hsNWd4b1hnSXBEc3R3RnVCOVFmN0dhamRLY2NTbCsxL3Z2?=
 =?utf-8?B?WFVNeG5Dd3VEejd0MFdBcGtYWmJVTGZkNU9ITFBxb3lDUkUvZWhvY3lTUkFX?=
 =?utf-8?B?ZW9GckRTME9rWlptTU1rTUNISHo2M2xnZjd6aGdNOGgvZFZFazFPbGkwZzQr?=
 =?utf-8?B?aEtmQ3V5d2w4MHlqSGNsUEdiMElvTGF2L2dibWtYRzl6UzBOTUtvRXhZRDJq?=
 =?utf-8?B?SWM3bm10Y0ZuM25DdTl1Z3NuOE9qY2p5MmlLSTZIbUh5a2FRdkZmM2l6Ynl4?=
 =?utf-8?B?bFdaZG14TytaTC9HSVorRmdQYXFZRnFUUXBQWm9YRWtiSVpEZ2orZENRcXFv?=
 =?utf-8?B?eWt5V25EVW9WK3V3MFN5OGpRWWcyMlFiWGhxVkwrbTNCUlpWMlo0V2VlQldi?=
 =?utf-8?B?Vm5mc2JRYldyK05HZzBGcmgxako0YkdRcUQ1WVVsdCtzR0phNXNaUTNtemoz?=
 =?utf-8?B?R3FOZWtHWWNZdzl0aWpuTlo0TkF1ZjVNU0JmenI0N3dBTGZpTWREMEU3bGpQ?=
 =?utf-8?B?ZmhSRHVTelhUSUh5RW85bkd4NXpQbTh2MTBPV3VkQWdYb0VydGZodFkwbkJN?=
 =?utf-8?B?VWFrUTZCaU1EcDk0UGVVSnhDOEhESFZyMGdWdVAyOFJUMDcrOVFkejRHWk1U?=
 =?utf-8?B?dksyT2I3b1NkcVhVMmJrRlFNR1ZZY2NSdjNTSWdJWHdCUkVxWkZLMU9jbmxi?=
 =?utf-8?B?MjFRQ1UySkNXQ0VIS1o1TGQ4NUUwTWlTWWRvNXVvZENRVnJNNjFPT0prS1Vj?=
 =?utf-8?B?b1NPc3FuTW5rZTgwcVFtTnZpZkUxWENYTFVOWEExNkhXNmNyUzBUb2ltMzRW?=
 =?utf-8?B?NERLRFFGR3JsNytKYmlDM011R1RQR0JsTUdtT2ROTlFROFFrcVZCQUtyck9G?=
 =?utf-8?B?cHpxV1gxbVg1dEJxaFgycUNWSEZWSS9CbjR1UFpQNUhhOFNvYllOR0JaSklT?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f29c20c-fabd-43dd-5f18-08dd13cf1b4c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 19:17:19.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmmKffC8irz4fZnzRjos3iBel+jNUA5kdy8PxgE7weXt1GHtyaft39fTyIosAUkWznQQ6rwrplt1kDPsJjyvyWq8kKgUZiWnjQ3TAEUQFg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com



On 11/8/2024 3:53 PM, Greenwalt, Paul wrote:
> 
> 
> On 11/7/2024 8:14 PM, Jakub Kicinski wrote:
>> On Thu, 7 Nov 2024 17:37:41 -0800 Greenwalt, Paul wrote:
>>>> why dropping what the user requested with a warning and not just return
>>>> an error from ice_set_features()?  
>>>
>>> I took this approach of reducing the feature set to resolve the device
>>> NETIF_F_HW_CSUM and NETIF_F_ALL_TSO feature limitation, which seemed
>>> consistent with the guidance in the netdev-features documentation.
>>
>> My understanding of that guidance is that it is for "positive"
>> dependencies. Feature A requires feature B, so if feature B is
>> cleared so should the feature A. Here we have a feature conflict.
> 
> Hi Jakub,

Hi Jakub,

I'll make the requested change, and resubmit.

Thanks,
Paul

> 
> I also considered the netdevice.h comment for the ndo_fix_features hook,
> which states, 'Adjusts the requested feature flags according to
> device-specific constraints, and returns the resulting flags.'
> Additionally, since this patch introduces E830 NETIF_F_HW_CSUM support I
> reviewed the netdev_fix_features handling of NETIF_F_HW_CSUM and
> (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM), which seemed similar—though that
> case deals with a feature conflict rather than a device conflict. These
> led me to take this approach to achieve a consistent implementation.
> 
> Thanks,
> Paul


