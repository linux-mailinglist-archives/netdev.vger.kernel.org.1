Return-Path: <netdev+bounces-152643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C350A9F4F83
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BC17A21B6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053C1E519;
	Tue, 17 Dec 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqZRE9Pr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6213BC12;
	Tue, 17 Dec 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449594; cv=fail; b=O0LMplSo0h/9ugcu5HQR8Id/9uL7M82S9RwO5ecA388BYFqix8XYQdVW8L/r59vxeqtSPoMzPSiG/fftchjyej8EVkMH3aoyHh/53/o+/crbmLBC3zq9H8ytw/5E7/HsZmdyyKlUVMXnHCjiicIWCIkVLhBizrZ9cWy9Fb2q5H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449594; c=relaxed/simple;
	bh=TXfJQLvze3BXUVgxeIlHh+TWBvFEMAWmcfzSYm55Vkg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vA+3gq84lb8ntYH9LftPSasyfkfPG1jCTA9wDHP8Prf9fTGA1akqbZXwv/uQkjKN86I1meTg9K2XnkExShyIV0O15k2sSuO9C1KqsaHVEEyNkm6rZN0uNwKRqVlAYvBEkT4QrGh1OOjaRNzW4HTiEdpNfZS4fk/WHB90nK5MPaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqZRE9Pr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734449592; x=1765985592;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TXfJQLvze3BXUVgxeIlHh+TWBvFEMAWmcfzSYm55Vkg=;
  b=DqZRE9PryvnebqIkyWZlgqsQJiud0uoRu79zE0F7tx4nM67QjvZNitWx
   7V+MVuj1bOFVz8d3jYk6MqOI9MsyAx6sv47h2Cm16EnnOiIjRx9BcKsh3
   WSiGTNRsFqzoClNrGB0lCAbSbSwU8jgD2CZC7nrQS0opw6sTgYHrCAt9x
   ZGMURv4b6wlTpJPuHzjoGLryA3Lp0Zr+bIp3cTbzvc8UFy+SgB3gNnKkm
   PLJwOLNZxq6+Jf5KxCX/rX+FODa3fB4GQVWJcHrcA5twmthQNxrGXL2o1
   G0cyj+cleRw1eVOuL2uqDHRsvD2hO4sgVNpb1ZjgfLPLzFrOnc3JQ3uJ0
   w==;
X-CSE-ConnectionGUID: 4JrDSkaLRBW2AA95m29Wrw==
X-CSE-MsgGUID: 1Hwkd7LeRv+weOWeus433A==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35030500"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="35030500"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:33:11 -0800
X-CSE-ConnectionGUID: zTPoS8umRZ27+GYajBI5sw==
X-CSE-MsgGUID: TD38MOThSWCNUBufjBNK2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102549596"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 07:33:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 07:33:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 07:33:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 07:33:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly7yZYslxOr1Jpgp+uoppGc0eZYUGEFUfx9+G6wsWUO/51LyH8Upg0gSK9GSAVJIzwa3i3pdU6O/xnbaD8EKl3kD6jNYUvPx6+gNMoCX+By8CR7ywotqfdZalM9mpDq5ubFg8w8xYFYZ+qDdj2oLOB4Mr5UsYkKEyXamU4KJm/UegFHcmvHvNSpXd982HVz23G9VTkvBVZRBjFtHl7DW2sLuZ4P/5GgHIXQSRPKq7NB/e7/N+eRogH5wA0WgRa8KtaWd6YptJYqHRFa2noV1Und5dh8clWi3s2g4KvgcLDjS9de2fnYPoGUcjgVtvikbw4RuLtXtKWhBh6TWgDFo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEUgRgsI2fJByr+ZfQSdZp1LwIpxi5qSVdikN6oGV6k=;
 b=eV7qJm0634o5lk4Hd1AMW9NyMbpe6jERPQrj1eQ09y/LiM3eodQRmyk0d/KhbpCbCLtjb3kqEBF4fwI9CDswGr8/mHr2w+99qsRjNberc7IliWkEha6bJQ7WeQvwn3vif8/804fpcE2GKYsZAUHi7az4TjRjXEXcCsIXJ97sYs79JDLJWDA+ds+xUHtHsK2GNQLhozDw3ZfguVyYgbMM3E5ay51OsA+hoH/cX+22rDHLCAPmTOe1p8iFD27m6KoY5IfXcmkA7yJel675VYGeja29nnx8Rv9iFvWcwLWulE6IPZCoc5e/sbeTJNntxLMjg/A5kPBnB2HHtsxbzPSV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Tue, 17 Dec
 2024 15:33:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 15:32:59 +0000
Message-ID: <ee42c65c-cc35-4c6b-a9d0-956d06c56f7e@intel.com>
Date: Tue, 17 Dec 2024 16:32:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
To: Wei Fang <wei.fang@nxp.com>
CC: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<frank.li@nxp.com>, <horms@kernel.org>, <idosch@idosch.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-4-wei.fang@nxp.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241213021731.1157535-4-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: f4850311-b263-4de5-447a-08dd1eb01638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUdBSjY0U2hwcW5GcXJQRVBqb0UveWg3OXl4QVluWDJ5WTVOVkJnazZwdWo1?=
 =?utf-8?B?eDlRcEppRVdlRzZZVEdtT0x4NWwrRUlYVFBCMFBvT2Z1TytXTWNkcTQ2UTZk?=
 =?utf-8?B?b1lzS0hyeW1IWHp0cVZnNjFKYzlBRlZOY1p6YjZ0eldzTE42cDZUWmdkdWxi?=
 =?utf-8?B?U1N2WVhkVEJWWFB0Qnc0OWdadDZ1aDdYWnovMk5RcHBjbnpYSkpwZXBhWTF6?=
 =?utf-8?B?SXMxcjE0a1lCUlZucjNScmpTaCtWOHJGUDJQNkdNNTNtK081N2krZUx4dXgx?=
 =?utf-8?B?RjJOWmFEbUFTMDhZUWpQczVtaHM2cFUvbVFvNmtyTEk5R044S2tRcjltVFp2?=
 =?utf-8?B?aWFzTFhGcGc0U1lFZTFXRWhRUnZNZUZ4M2FPeW9oemRKZG15Z1d3ejV1dTFo?=
 =?utf-8?B?UmtjQzlrRWJKa3NhQ0pVbzV0RE5UWTBOWE9lVlZSUTEvU0ZwOTdXT3dXNUtV?=
 =?utf-8?B?anplNGFNVVRNMlhJKzBEd0RaWXU3UGU5QkxNaS9VamQ0Z0FZUWNZU3VoaFJ1?=
 =?utf-8?B?UFNVdVRuZmo0RFRnNEZ6ekZ0Z3VMbW5rWXAxenB3Y0JnWmZaVGQ5Tnl5QmpC?=
 =?utf-8?B?Z3l0eTYyOHF1MnpjeTk1bHdUb3RHRXZqbTNDVWNROHZ6R3A2V2xtUm5rTmlL?=
 =?utf-8?B?MUlGZThwZjhuMjZHRVhKbVl5bVk0VHRYTTB6TWxoWnplZUNTQkhzVTNnQ2My?=
 =?utf-8?B?T1IvS1RNWTNhWUVVUkpBWVl1eDIvdzRHNEhCRFhEM0RRTlR1LzlZVHlkbitQ?=
 =?utf-8?B?UWNCWnBrZHltWUhCT1U0VDlMcThrZ3RmV1NqUEFXMDY1cHFvSHBOSkJ2Vjcx?=
 =?utf-8?B?UUE1aWlKR05ibk9lVzNQVnN0UzB2OVpqL2U5QkF3WDFXNEQ0OE01NXovaEdj?=
 =?utf-8?B?ajdpM3VpNXRLTUQ5U1M2OWRhQmJFQnBiMFYvc1J4QWxlUWJZZEhIUEZ6ZHJT?=
 =?utf-8?B?bTQ3YzN0QUp2dkt0bkJxamRDclFnbTlqRWh6dUtYYUlOclRaczNiT0xXdGkw?=
 =?utf-8?B?d1NSWUlKNjYxM0s5N2dnZHpJNDBlejVWOEE5SG41Sng4cXpiL1F6YnhGVkRH?=
 =?utf-8?B?T21xZU9ycGV6c0NXeE0za2ZFeHk2YjVZL1dzMWx4TTkrTzIzZE5EOW81VXR2?=
 =?utf-8?B?Q1hyRE5STExCVXJNcFFPenhCdzZXcUU0S014NGU0dmdOalR6WDV5VDQ4SFBj?=
 =?utf-8?B?SlNjdytSZ0N1dDUzdEFzckFudjU3MnRLTmF4NXFQd1Z1VDEyaGVNSXIzYTB4?=
 =?utf-8?B?STlmcGp6aUpzeVR5TkQwUm43VmM3Y011Z3NjUDFta2VtcEdVdTQyQVh6U3kw?=
 =?utf-8?B?L1p6bkltSUZlQmxBMXdXSUFMOUZQK25PcE9LUTU5MDdvU3FWQTd6MGxLdkhm?=
 =?utf-8?B?T0x3cUhkYnZ2STNZNDlCdkpHQjBkWkkvb1FEN2dnVEVxZTRTcGl2MFF2UDdm?=
 =?utf-8?B?TXdqRCtkNjkxNXRmRHY2UkEwWXFzdHM2WXEwNFdYMHp1ZitmMm9mZmFhOHJr?=
 =?utf-8?B?UzlkL3NNWHdTK1ZXaWh0bk1DdW1hMFRzU0QwM293MUpuOEVZa2N6TnZkODdH?=
 =?utf-8?B?L3lZSVRxKzliSWkzZEpwY3BSQW1GV04yUHczbk54QmdLVlBDL3UrQ2dKVkwv?=
 =?utf-8?B?SWhaMnlva0lVdzJHejNVNGZDTEx4TS9MMCt4TUsxWWt4c1JHeklNVU5uWlFE?=
 =?utf-8?B?eDYyODVtV2piTjVMM0VldHIrYk43RGJSRGRUeUJZdHdVR2ZkNjRRdllFYXNo?=
 =?utf-8?B?eUFMYVE5R3crTWJ4UGhkc3lIRkdWUGdKMWx6V1JDRy9HeGZKVitwaXRRNWRn?=
 =?utf-8?B?TC8wV0duajQwV0w1dVVHZHV5Z1dYbkpXMkxaZUsxK2ZBTEFubVdwM3JpOUdl?=
 =?utf-8?Q?ffsG7QWAzRxno?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c09tZGZ3R05EREVmOGYrZnFzbnpsQUpNeENaVnpmSVhrNGpoNlpDeS9kck02?=
 =?utf-8?B?QWhTMEorM3pZUzlIU3VEMkNqL1hEVHlDbzRQQnhDSzIzRG5yUnhIaEp5ekIz?=
 =?utf-8?B?U2RMdGxjdlFyTnBmZjI2bitteHRjK1k3Nm1rSkNQWDViK2E4TnYvV2dQamc1?=
 =?utf-8?B?UEpMcXJZMzl2NVZRb3lNdEtqZnBWblEwL3lYMDA2VGtTcXNwWFcvMTRjTzBk?=
 =?utf-8?B?M0NSN0x2eUJ5dkl1U1Qza1o5QXloMVhKR2pHbzErcnRETVdsR3BVZmg3VFBp?=
 =?utf-8?B?azBEL3l5cHVHdzN1WTJkcG5qdXcrZW1KcE5MWFUxdUY5emwrb3RHRDJwVGVs?=
 =?utf-8?B?WFpPWGxHSGNVNWxaNVFtUUkyTldMNW9wYS9TbHF4YkVRb0NKbVlRMHlSWWFT?=
 =?utf-8?B?c2R3Q0lnb1ZkQndOcVVJN0RFL29qajQ1SHR4d1B0Y0lWZXE4QjNDaWVEOUZ5?=
 =?utf-8?B?UjBRTmNyKzJZbmYrOEJiNzlhUTNqZHJ5UGwrVWF3K0Z6Vi9BbEdNWi9sREVN?=
 =?utf-8?B?UkNscktHZ2Y3TDFRdkQybXlub2d3T0JaMUdid29wWmFsQ2FIL0ZXM2tsNjRV?=
 =?utf-8?B?QTdvNkNaOFFLbFpGRVI4UFRZNFdsV0FrenhGeS9vT29jRTBsZ3VXWFh1eE0v?=
 =?utf-8?B?MmlxbnQ0TTQyeXNNRDFrTWlPVjFwRTVRVWdxSWR0RlYrcWROSXNsR051eC9H?=
 =?utf-8?B?VjVjMmVVZWRUV3BuZmFIcE1remgybE5acWxNYjBpZm0wcTB2NUw0M3lKUytN?=
 =?utf-8?B?RzlSbExGUytUazlBRmNkRXZmUllOQnFLTWJxb1lkc3NFbm9kKzg3WnBhSGdB?=
 =?utf-8?B?VEVacWp3aGdIZ1UzK2wvNHZ4OFV5aDVDUStRZjdYd3FqVVhMNGpVTjFRYmR3?=
 =?utf-8?B?NVk1YWx1cEcrYTI2QlZZNHdKOElacVRlTEV1NmMvRkxDdzVHazhnRy83dXpp?=
 =?utf-8?B?R3I4NmdOWXJ5NDJFUjk3ekZ0MFBjVDhJU2JJYTJvTDdvU2JNUk9XYkJSazk4?=
 =?utf-8?B?dVp1Vk9qbzNOT2JqMUIzYW9ZOGxnTEpvTVQ5UUx5ekhxdDNRR0JKWGNkTWlj?=
 =?utf-8?B?MHkxakRsNDZ2Q2tnOUVSemFrVm9BUEYxZ3FLZ2hidFN4SVo5bDR1a0NMU3dm?=
 =?utf-8?B?K0ZmSmY5UnN6elJHRStBV0NRdXNBM0pmKzNDOHZ0dnoybGppTm5tMU8zU2RH?=
 =?utf-8?B?YXhsQjNXb3kzbDEzZzNVb1lxUkxnMDdPanRwaHVJSm14ZlByRGhEakRaeXVI?=
 =?utf-8?B?WDBpRU5IdVE0SmZBdmRoWDVyRzkxQzY0dUh5N215bUJUSzgyWi9VeWluazB1?=
 =?utf-8?B?UmFOd0M3eDVxMHJiV0t6MUJ5K0Y4M0NZdHFvOTg5SG1yZk9IOTd2SWFSTVdi?=
 =?utf-8?B?ODd5bWwvdTB6eVhCQk9XUHBVZG4xNVg3a2xlZ09zU1lKbTZ4SmxxMzE1LzN4?=
 =?utf-8?B?RERiUi9QWkdIUFg3N2x5UkhQWUJIS1NRSythNytKUHkwbWlqMktrRjhOSHky?=
 =?utf-8?B?ZVJ6WXJYL0prRkJXNTFyRFBQVXl2M2FVU3lOMmdDYWszdGw0QjJyVWc5YkpN?=
 =?utf-8?B?YUZtbkdUTHBxMDQ1Y0Z4VFpIQnpILzBLdHNZQklyQTRTZThhd3dsYnhJamt0?=
 =?utf-8?B?bTNsM2lvVVhKdFQ3SjVUNDNTOUhiQThITUxQZkQwZUVJa0I1U2lDR2xDZ3FH?=
 =?utf-8?B?N1BWMzVmZnBpU1RRNnpZOHgrWGpqMlpMNjhHSWs0Z1Zvb2h0aVNUTjBUMk10?=
 =?utf-8?B?bkZKd2labTB3WUU3TWh3dFBab080eEEyNkREMk0zRlh1YllnMDBkUDBzL1ZF?=
 =?utf-8?B?REx0RVo5SCtXd2ZlaEpYQjFFanQ0QzFzS1J4WGJjSnp4VkcvRE5HNWFGQ2xy?=
 =?utf-8?B?Y2V3dW9aQ2pKNGNYOEk3Q2MxK0dlVVVUUlJJU1JyOW5PZEwzYXBrZ3hMU0dK?=
 =?utf-8?B?d0ZSMmg0TU45R29VVERBUWlid3ZTTmRKQnc0WnRPUllHdGwyLy9nYzdKaWtm?=
 =?utf-8?B?WlNPUi9nQW1FSTc1UkkySmNKa3hQeWk2TFRybFVNVHZGczdmaUM5L3YydFB0?=
 =?utf-8?B?K1ZZcDM5dVFWTS9JMUNJZ2M5dzRlZ1pyaHdGUk1qZHl2WkNlaEhZVitNUjAv?=
 =?utf-8?B?UmgwUUlqRmRLWmF6cnpST2lwUWQyUGxUSjZUUE03cTQ4cURyZjJrRGt5VmhL?=
 =?utf-8?Q?R3r4TAHZxP9AutPJD2yTH44=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4850311-b263-4de5-447a-08dd1eb01638
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:32:59.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0YVsZt+eCRq194UsmV+myI4aBAAi9Cloz4ummlqwBtm5n+YuJW+FwWfMbFmqUShXpgk6L78Xxp4/Lm5MgYFwpe5z+CdnV4KLFABKPQE+Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

From: Wei Fang <wei.fang@nxp.com>
Date: Fri, 13 Dec 2024 10:17:30 +0800

> ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> and UDP transmit units into multiple Ethernet frames. To support LSO,
> software needs to fill some auxiliary information in Tx BD, such as LSO
> header length, frame length, LSO maximum segment size, etc.
> 
> At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> CPU performance before and after applying the patch was compared through
> the top command. It can be seen that LSO saves a significant amount of
> CPU cycles compared to software TSO.
> 
> Before applying the patch:
> %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
> 
> After applying the patch:
> %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v2: no changes
> v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> v4: fix a typo
> v5: no changes
> v6: remove error logs from the datapath
> v7: rebase the patch due to the layout change of enetc_tx_bd
> v8: rebase the patch due to merge conflicts
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 257 +++++++++++++++++-
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  14 +-
>  .../freescale/enetc/enetc_pf_common.c         |   3 +
>  5 files changed, 301 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 09ca4223ff9d..41a3798c7564 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -533,6 +533,224 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
>  	}
>  }
>  
> +static inline int enetc_lso_count_descs(const struct sk_buff *skb)
> +{
> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> +	 * for linear area data but not include LSO header, namely
> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.

What if the head contains headers only and
`skb_headlen(skb) - lso_hdr_len` is 0?

> +	 */
> +	return skb_shinfo(skb)->nr_frags + 4;
> +}
> +
> +static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
> +{
> +	int hdr_len, tlen;
> +
> +	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
> +	hdr_len = skb_transport_offset(skb) + tlen;
> +
> +	return hdr_len;
> +}

Are you sure the kernel doesn't have similar generic helpers?

> +
> +static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
> +{
> +	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
> +	lso->ipv6 = enetc_skb_is_ipv6(skb);
> +	lso->tcp = skb_is_gso_tcp(skb);
> +	lso->l3_hdr_len = skb_network_header_len(skb);
> +	lso->l3_start = skb_network_offset(skb);
> +	lso->hdr_len = enetc_lso_get_hdr_len(skb);
> +	lso->total_len = skb->len - lso->hdr_len;
> +}
> +
> +static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
> +			      int *i, struct enetc_lso_t *lso)
> +{
> +	union enetc_tx_bd txbd_tmp, *txbd;
> +	struct enetc_tx_swbd *tx_swbd;
> +	u16 frm_len, frm_len_ext;
> +	u8 flags, e_flags = 0;
> +	dma_addr_t addr;
> +	char *hdr;
> +
> +	/* Get the first BD of the LSO BDs chain */
> +	txbd = ENETC_TXBD(*tx_ring, *i);
> +	tx_swbd = &tx_ring->tx_swbd[*i];
> +	prefetchw(txbd);

Is this prefetchw() proven to give any benefit?

> +
> +	/* Prepare LSO header: MAC + IP + TCP/UDP */
> +	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
> +	memcpy(hdr, skb->data, lso->hdr_len);
> +	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
> +
> +	frm_len = lso->total_len & 0xffff;
> +	frm_len_ext = (lso->total_len >> 16) & 0xf;

Why are these magics just open-coded, even without any comment?
I have no idea what is going on here for example.

Also, `& 0xffff` is lower_16_bits(), while `lso->total_len >> 16` is
upper_16_bits().

> +
> +	/* Set the flags of the first BD */
> +	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
> +		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
> +
> +	enetc_clear_tx_bd(&txbd_tmp);
> +	txbd_tmp.addr = cpu_to_le64(addr);
> +	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
> +
> +	/* first BD needs frm_len and offload flags set */
> +	txbd_tmp.frm_len = cpu_to_le16(frm_len);
> +	txbd_tmp.flags = flags;
> +
> +	txbd_tmp.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START, lso->l3_start);
> +	/* l3_hdr_size in 32-bits (4 bytes) */
> +	txbd_tmp.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
> +				      lso->l3_hdr_len / 4);
> +	if (lso->ipv6)
> +		txbd_tmp.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T, 1);
> +	else
> +		txbd_tmp.l3_aux0 |= FIELD_PREP(ENETC_TX_BD_IPCS, 1);

Both these "fields" are single bits. You don't need FIELD_PREP() for
single-bit fields, just `|= ENETC_TX_BD_L3T` etc.

> +
> +	txbd_tmp.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T, lso->tcp ?
> +				     ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP);
> +
> +	/* For the LSO header we do not set the dma address since
> +	 * we do not want it unmapped when we do cleanup. We still
> +	 * set len so that we count the bytes sent.
> +	 */
> +	tx_swbd->len = lso->hdr_len;
> +	tx_swbd->do_twostep_tstamp = false;
> +	tx_swbd->check_wb = false;
> +
> +	/* Actually write the header in the BD */
> +	*txbd = txbd_tmp;
> +
> +	/* Get the next BD, and the next BD is extended BD */
> +	enetc_bdr_idx_inc(tx_ring, i);
> +	txbd = ENETC_TXBD(*tx_ring, *i);
> +	tx_swbd = &tx_ring->tx_swbd[*i];
> +	prefetchw(txbd);

(same question as for the previous prefetchw())

> +
> +	enetc_clear_tx_bd(&txbd_tmp);
> +	if (skb_vlan_tag_present(skb)) {
> +		/* Setup the VLAN fields */
> +		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
> +		txbd_tmp.ext.tpid = 0; /* < C-TAG */

???

Maybe #define it somewhere, that 0 means CVLAN etc.?

> +		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
> +	}
> +
> +	/* Write the BD */
> +	txbd_tmp.ext.e_flags = e_flags;
> +	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
> +	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
> +	*txbd = txbd_tmp;
> +}
> +
> +static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
> +			      int *i, struct enetc_lso_t *lso, int *count)
> +{
> +	union enetc_tx_bd txbd_tmp, *txbd = NULL;
> +	struct enetc_tx_swbd *tx_swbd;
> +	skb_frag_t *frag;
> +	dma_addr_t dma;
> +	u8 flags = 0;
> +	int len, f;
> +
> +	len = skb_headlen(skb) - lso->hdr_len;
> +	if (len > 0) {
> +		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
> +				     len, DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))

dma_mapping_error() already contains unlikely().

> +			return -ENOMEM;
> +
> +		enetc_bdr_idx_inc(tx_ring, i);
> +		txbd = ENETC_TXBD(*tx_ring, *i);
> +		tx_swbd = &tx_ring->tx_swbd[*i];
> +		prefetchw(txbd);
> +		*count += 1;
> +
> +		enetc_clear_tx_bd(&txbd_tmp);
> +		txbd_tmp.addr = cpu_to_le64(dma);
> +		txbd_tmp.buf_len = cpu_to_le16(len);
> +
> +		tx_swbd->dma = dma;
> +		tx_swbd->len = len;
> +		tx_swbd->is_dma_page = 0;
> +		tx_swbd->dir = DMA_TO_DEVICE;
> +	}
> +
> +	frag = &skb_shinfo(skb)->frags[0];
> +	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
> +		if (txbd)
> +			*txbd = txbd_tmp;
> +
> +		len = skb_frag_size(frag);
> +		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
> +				       DMA_TO_DEVICE);

You now can use skb_frag_dma_map() with 2-4 arguments, so this can be
replaced to

		dma = skb_frag_dma_map(tx_ring->dev, frag);

> +		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
> +			return -ENOMEM;
> +
> +		/* Get the next BD */
> +		enetc_bdr_idx_inc(tx_ring, i);
> +		txbd = ENETC_TXBD(*tx_ring, *i);
> +		tx_swbd = &tx_ring->tx_swbd[*i];
> +		prefetchw(txbd);
> +		*count += 1;
> +
> +		enetc_clear_tx_bd(&txbd_tmp);
> +		txbd_tmp.addr = cpu_to_le64(dma);
> +		txbd_tmp.buf_len = cpu_to_le16(len);
> +
> +		tx_swbd->dma = dma;
> +		tx_swbd->len = len;
> +		tx_swbd->is_dma_page = 1;
> +		tx_swbd->dir = DMA_TO_DEVICE;
> +	}
> +
> +	/* Last BD needs 'F' bit set */
> +	flags |= ENETC_TXBD_FLAGS_F;
> +	txbd_tmp.flags = flags;
> +	*txbd = txbd_tmp;
> +
> +	tx_swbd->is_eof = 1;
> +	tx_swbd->skb = skb;
> +
> +	return 0;
> +}

[...]

> @@ -2096,6 +2329,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
>  	return 0;
>  }
>  
> +static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
> +{
> +	enetc_wr(hw, ENETC4_SILSOSFMR0,
> +		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
> +	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
> +}
> +
>  int enetc_configure_si(struct enetc_ndev_priv *priv)
>  {
>  	struct enetc_si *si = priv->si;
> @@ -2109,6 +2349,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
>  	/* enable SI */
>  	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
>  
> +	if (si->hw_features & ENETC_SI_F_LSO)
> +		enetc_set_lso_flags_mask(hw);
> +
>  	/* TODO: RSS support for i.MX95 will be supported later, and the
>  	 * is_enetc_rev1() condition will be removed
>  	 */
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 1e680f0f5123..6db6b3eee45c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -41,6 +41,19 @@ struct enetc_tx_swbd {
>  	u8 qbv_en:1;
>  };
>  
> +struct enetc_lso_t {
> +	bool	ipv6;
> +	bool	tcp;
> +	u8	l3_hdr_len;
> +	u8	hdr_len; /* LSO header length */
> +	u8	l3_start;
> +	u16	lso_seg_size;
> +	int	total_len; /* total data length, not include LSO header */
> +};
> +
> +#define ENETC_1KB_SIZE			1024

SZ_1K

> +#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)

SZ_256K

> +
>  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
>  #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
>  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
> @@ -238,6 +251,7 @@ enum enetc_errata {
>  #define ENETC_SI_F_PSFP BIT(0)
>  #define ENETC_SI_F_QBV  BIT(1)
>  #define ENETC_SI_F_QBU  BIT(2)
> +#define ENETC_SI_F_LSO	BIT(3)
>  
>  struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
> @@ -351,6 +365,7 @@ enum enetc_active_offloads {
>  	ENETC_F_QCI			= BIT(10),
>  	ENETC_F_QBU			= BIT(11),
>  	ENETC_F_TXCSUM			= BIT(12),
> +	ENETC_F_LSO			= BIT(13),
>  };
>  
>  enum enetc_flags_bit {
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index 26b220677448..cdde8e93a73c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -12,6 +12,28 @@
>  #define NXP_ENETC_VENDOR_ID		0x1131
>  #define NXP_ENETC_PF_DEV_ID		0xe101
>  
> +/**********************Station interface registers************************/
> +/* Station interface LSO segmentation flag mask register 0/1 */
> +#define ENETC4_SILSOSFMR0		0x1300
> +#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
> +#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
> +#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \

Why not FIELD_PREP()?

> +					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
> +
> +#define ENETC4_SILSOSFMR1		0x1304
> +#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
> +#define   TCP_FLAGS_FIN			BIT(0)
> +#define   TCP_FLAGS_SYN			BIT(1)
> +#define   TCP_FLAGS_RST			BIT(2)
> +#define   TCP_FLAGS_PSH			BIT(3)
> +#define   TCP_FLAGS_ACK			BIT(4)
> +#define   TCP_FLAGS_URG			BIT(5)
> +#define   TCP_FLAGS_ECE			BIT(6)
> +#define   TCP_FLAGS_CWR			BIT(7)
> +#define   TCP_FLAGS_NS			BIT(8)

Why are you open-coding these if they're present in uapi/linux/tcp.h?

> +/* According to tso_build_hdr(), clear all special flags for not last packet. */

But this mask is used only to do a writel(), I don't see it anywhere
clearing anything...

> +#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
> +
>  /***************************ENETC port registers**************************/
>  #define ENETC4_ECAPR0			0x0
>  #define  ECAPR0_RFS			BIT(2)
Thanks,
Olek

