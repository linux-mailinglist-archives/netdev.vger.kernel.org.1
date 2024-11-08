Return-Path: <netdev+bounces-143460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094EB9C286E
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 00:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B704F288472
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32E1E0E0C;
	Fri,  8 Nov 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZ9dcPUA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F061AA1EA
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110044; cv=fail; b=bJPvY0HxcP4j5VfoeMDqSxFDEJ7NFezO7hAMCVtREnLiD6emYXyyWFmV2CXNaJX5wiEnXgCp8vjad3iIQPPyPc/I/obWK1jIXf+hTwCE+/h1Azpewrhx8SiQqSFpeTlZc4+jquF+Da71OhP+1oYqrudpBftizmherf3saH4PFaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110044; c=relaxed/simple;
	bh=tK1RdLfqcGvnO//N77feQO4Dc9lzyrpG8O3BhKXkBfI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEOGBDES8l58cP75SMWewKuqPjzbGB+qo4R6YgMzOdbAWvh4ald84J9I8xIHER4VUwH3tV5AKm5fa8Op4U4Wnmp/HVjFb5akZsvhfd5ro9vNxCP2sRBRgJkGTvFVn3nOZh8me4SpHDQIR98ZtiZAYx8j1L0SD/+9ToSCgKv3si0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZ9dcPUA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731110042; x=1762646042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tK1RdLfqcGvnO//N77feQO4Dc9lzyrpG8O3BhKXkBfI=;
  b=GZ9dcPUAwBX9rkLG1Z839IJyUmHsvPgixiEssVg0jOJLoxPPxk7xlaPY
   daTcCseSSATj6ko1WbAOHDM+pLU+fwxxkaMUa2RQ5X+mni+KzTvpl0y2u
   d0gujkqoXz4LgkcOjEUnWAFfOJPYTmUdYZ/Mb909I9NwhWLsOAipg7PHi
   JmKEDDvpNzH142CIgPajnltDMX+//gohriRwXV4PmovBLrvRC2ddqE8ZY
   r7dAJTbgEJvSl0T/YzhvNsYq8nTHmyIWn6VDOtLHnN+5KuYtFyv0jDIUH
   oHFI/lCKhcSdoJK/ZGtCtKkPVwnk8sGZu+QEd60+GSETx7+wPgFym+xyK
   g==;
X-CSE-ConnectionGUID: l354W9/2QHKTpc3RBFGdPA==
X-CSE-MsgGUID: jxK4rgbEQmalfy7sx1l25w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53570788"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53570788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 15:54:02 -0800
X-CSE-ConnectionGUID: AgqpaMQlSJGDkCZPe53z8w==
X-CSE-MsgGUID: Wtat+/hpSuybp19dJ4GJlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="85431477"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 15:54:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 15:54:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 15:54:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 15:53:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yttL7Qr2445tN9lSQgkygF9veYODG9wjh4D9wtZZ2xun8okI1HSNL9m4gncyARHL9OU1bQMEekN/lKWOULFfvCxhj5ipsSE/msq5v4DB4aPE20yMzQbHK3LQPRtxQNSaIN4Hq4OBk6SjuLBYRb3pdPeKRqATi78Qsz3qNsZwfhtsxKxEVvTfas4KSbvMALsNpO9Jidl+OtkAFN1kusH3jxbu5Aa4K+e+EziHJpdv2LD/VhJl18nE7P+lihumZ7NzJGekhDZY+1CkZ470sG2Sthrf3pYqCWPhTfkiPRDplJg60JZOHCYSGzCKFIa6uuCyk5XzXNfkKP1GPBtYqIvD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1mN5ZIxi8qEtmY4GXMwg5fATs81ChuLPQuSW9zonic=;
 b=qyxVz4+rvRzFMrBG0XzPuDFYoNZ0Jk6++XW3fCWjBiTbvlk5dZwY3Vy292GVV2GGa0+70FtXNHj6Vo7VP/8LDrOIuOEqgmTAJqgItiX1Zq1whmVlunN2kiOc9SbNJ1bjuQy+C6MOKsVKVTsLGimJeANxOUCwx3nltft3F4TzG671ZDS4jfAVJjgpdWqdLuLQpHvm++nmq6PXmN8uhdeh2o73vJWzfyrgNzUXkrVxAhoi5dDl39AoZmqL/Q4G5DwhtVs0fuAcXNuouA/84R16HDtVthCjBAXWohkI6b7mPaElCIqWJhAYKzvqTb2G6RUxD3TvuwVYZJd3iR+/n/ZEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 23:53:49 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 23:53:48 +0000
Message-ID: <4b22a368-d266-442b-9cad-6c40688f735b@intel.com>
Date: Fri, 8 Nov 2024 15:53:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] ice: Add E830 checksum offload support
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
Content-Language: en-US
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <20241107201427.28e00918@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|LV8PR11MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: f122b4a7-9622-45d9-5fcd-08dd005096e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWN1eFBpSlJSM3VteXBRcXFtTExkbWFuU1VtSlBLWEdWcm1pakxVSi80RFRw?=
 =?utf-8?B?OWY1Z3N2QTlreVozT1FGNHE0bG5KU0d2MjRBSVF1ZEo0bzMxL2ZBMTl1YktV?=
 =?utf-8?B?aDZWbmM5WFNmVXRZT2hCc1JRNXZSQW9hK3BFV0JGeVZiQ2g2MlM0cTlFZjds?=
 =?utf-8?B?MmtJWEh6Y3JpSUFlVUNmSmdvbFF4b3lzYWtXOVRiVmJmT0FxZmxBdmZZQ3Jt?=
 =?utf-8?B?Um5Bdjd6VGFITW9zQTFVQVdjdm1HUVFRM0phWGx3KzdFTnZzNzBISmlrT2dD?=
 =?utf-8?B?eEk3amFKOEF5REJkMmZwS1V0TWdMTC91VXQyN1UrdG5GU0hCeS84T091VVpO?=
 =?utf-8?B?N0NmNHRYanp1RHZ5MGh0R24wQzZ1aW1sY284OE1GekNwTzJDd1JlUHJoVTJz?=
 =?utf-8?B?dENHY0hpUG1MVWRjbVpZVW9CM2JFTzlpby9VUm5pbHUrRk5VOTZLWkVMSDRG?=
 =?utf-8?B?a2ZTY1RLaDllUWV3K1Z3RmkyUUN0VnFPNm42SEdYY0Z2MTl4bkdua0xoMXR5?=
 =?utf-8?B?ZklZRElxbndrall6VmZSTVFDdjdNTlFWcy83YW5NRkZxNFdBblBDRmZKeldN?=
 =?utf-8?B?WmlkcGtUOXFRR1VmYXFibGkvdEt1R1FJcUNhNk56YzhqamFpYk5Jdzgwc3hu?=
 =?utf-8?B?SnZ6TkZPT01HQWhMaUtXUUJrRUxnaTNVQzRXSHJ6aWxhbFRHNFdyUlYra3c3?=
 =?utf-8?B?dHIydzNMMTZKN1BPdHZMQkZkWDl4dzlUUGhDeHkyS3FhQXZsdEVlZlFrNktp?=
 =?utf-8?B?NFlZbVVjcElzV3lESGtaOXRlV3l0cVM1QWVkYUJBeGJEZzBPMkh1dTBrczkw?=
 =?utf-8?B?Y0JZdm9kZDlPVHFkZjFyeTV6ZjAwWVlIRkNvekE4Z3RySmI5OVRsdkR6bWd0?=
 =?utf-8?B?Q1RVQktIdG1rcUdjUVpCbnNGZ3pTSGJxb0ZvOUh6S3JTUVRna3Q4U1pFYUFX?=
 =?utf-8?B?SVI5WWNIbW1uS0VtcDIyQ3ljczJsQXRqTG43ZlpRTU1Sb2hybU1CTHBWT0w2?=
 =?utf-8?B?UUQyMDJVWGo3dGJFT0E0V0dnUERtUC9Wa3VQTnpQcEJHWFljcWpFc0Fyb2N0?=
 =?utf-8?B?WU9MYkw5bHJHVTMxOFhqUk1xK3NxdWJld2ZuQmRwd3JVOWQwNGY5LzVGaW5F?=
 =?utf-8?B?YlprWlBCREg5SFJTVFNQaXJNUlJ2bGYxdXozQ1lzalljRXB3N0dyTTVQWnpr?=
 =?utf-8?B?UGxIdlBubTBXdmJOTDFUUVIrUTJ5VEhXRUwrQzV2a1J5VEtianEvN3Y1Mlds?=
 =?utf-8?B?emc5ZXFLb3ZlNHBDZjkvZTZKMUdFTWtuYjhubzJGbFJlREhIMlhHQ2FWY0Rl?=
 =?utf-8?B?a0VZeTJESys1TS9Va0lhUDJUUDcweHQ5QW1KNXlYTE55aFd0SzJGQmRwNUxu?=
 =?utf-8?B?eUNzSGJMYlZ0VDc5bUtDYzg2a2psVDQvdEhIN0xpQXBQYTN2S21GNTdkcHQv?=
 =?utf-8?B?VDJKa0d0VkdxcnhqWm12bzRXaHpGQW5aQXo1Tm15cEMzbFh0RzZFVnFid203?=
 =?utf-8?B?V0o4cUNYdE1DZkwyUE11Q1dRTHFTdEh1em5Ld3FHbnZQYWlxVmw2WUpPaTJ4?=
 =?utf-8?B?bTNuWHpFQ1I5T2J4d2hvVXlMczF4VzUza2RmTGRlV1IzK3o0cDhjSHJ2RitT?=
 =?utf-8?B?SkU4Ym5KNVQvVG5DUjBYYmU1N3NVSVM2Ykx2dzVMZVpyWHExb3lEZi9ab2R6?=
 =?utf-8?B?YzNJMmV4WWsycyttS1RVMytIQ2NjUlhqa3JCUFVQakRPcEpXOHVoZEFxMXNz?=
 =?utf-8?Q?nXQIKAFHSaKzKKMkHrVAZOb8MdXFHCzfRI1pTXu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRDMTdWbFRUeWRYTEJnNjVpek5LYlVhRThoejZTdDJYSG00V0JFbGpwNTc1?=
 =?utf-8?B?d2Vxd2tTUGVCNUJuVzQ4UG96eWtVeDh1elFyWUNBc3F5a0lHbGFFWHlraTZO?=
 =?utf-8?B?dG01eGcweFY4TUNKdFhBaW5Bb0MyMWZUYjFOUjk1L3Q4YzUwU0ZHN1FpWlpJ?=
 =?utf-8?B?Qy82N1p2UkhqZ29EUWdva1pPRFptcjUwTUExQ1ZXWEZGUHU5dmVyMVQ2dzd6?=
 =?utf-8?B?UCtlWjRKT0NqUXpiY3h1MXEycTk2RXN1eUR4Vk5YUjAwbFNpTi9kdytvVUQr?=
 =?utf-8?B?a0haaWFtaENPOHh0VUNwLzc5c0hqRUFUT0diWk5qWGhaYzdGQjZ6T1FsbDJq?=
 =?utf-8?B?NTNGV252ei9KTkxSSmFKaEpxY2xseW1hU3ZIZGVETEwxclhPMUJWRHlXbzI1?=
 =?utf-8?B?STJiQWZFNzdHU1J3V1IzM1FqeW9lbFVaT25PSEoyUlJhWlRpSjdzb3I0eHFn?=
 =?utf-8?B?VUZFYlJ0VXRyM0loUk5iSUtBSC85TEZrM3BsT0QvSm13M0JYLzJJMTk4UWxq?=
 =?utf-8?B?clAxVTQ4VExRM3cyVGFYN3IwcGdjWE1INWFGbDVIb1YrbW9RKzFKSW1PYU56?=
 =?utf-8?B?SFQ0eVhiV0l0UG4wdzJSRUVrV0ppdTVobVBybmxRN3czQ3RzUDZMYVY5bTB6?=
 =?utf-8?B?anE5cDIzcmk4NW41ZEx6dG5KMDVUZE54TGdKSDNONjhUT3hYdVdpQUc1SGVG?=
 =?utf-8?B?cHF6c3J6cFdYNkRMVUtqZlN3QjN5SWFucngrMUQ1cDd4eG55T3pGUmo4VFA4?=
 =?utf-8?B?MWdxTkFtS092ajYwYXlndUlwNUlKVlZtUTBJZ3lpZ3dOa3dKSytSYkdCNStE?=
 =?utf-8?B?RWlreFlXbUhydDhMZjFHTWdmUjJUM29zODQ2cndCaUtseWFsUy9EckcrTmdV?=
 =?utf-8?B?OTJqQm5xOE5SUFl4aE8vWDZtYTBneU8yaTBGZWM0b0xTTDZ6eVpCS0c2YkVs?=
 =?utf-8?B?UmlwV3dxSFdXbmViMjJrT3lBRkFXV21XZHJ6TTIwa2VyN1UwYzl5Y1RPT2pZ?=
 =?utf-8?B?L0NnM0wrRnBBaTRVRjZZdjlIUnUyUTFxQ3BBbzVJdUEycDdqUHd5OUozd0lL?=
 =?utf-8?B?RnVjSmJPMGJSdGlRdkhNUnVSRElHbnBBMkIvc0xGSmdzcmNncDBlNUtBV1R2?=
 =?utf-8?B?ZEhlNDlGQXJBWmlsYzFmWTRqVnVLaFJPeHE3UWtiR2hHS0dmd3dML1lZS1lw?=
 =?utf-8?B?ZS9hTlVIam91U0ltNEwvaW1NNkhWNGowckJ5MWJoNjd6RUJaNTJNeUpkZ3JP?=
 =?utf-8?B?YUlpVHlUaWZ4UHFXVS9hMnk2OW9UT1h2R0dRc3V4Zmp0bGkzb2lMUWh5R1pI?=
 =?utf-8?B?aXdibFIrbGxOWnViTitRdStDM2VJcnJERG5BWEZPakFzOUtmWlAwbm5qR1kx?=
 =?utf-8?B?WGpUdG5LQy9tck5HNjNPc2p1WEZaeWZwdCtnNGtUbTRXU0Q5ZWh1WjVXVS8z?=
 =?utf-8?B?NXhxLy9la0RmRTUwYUQ2T1dkNnZVb3hNR0Fkc2Zua1MzWGI4bzBjc3llb0xW?=
 =?utf-8?B?Ym1jeEpuNFdCVzNma2ZCK0syRDJibm1NRXE1TGF5QkUwWTJWc1p3SVpsazE5?=
 =?utf-8?B?OEwrSmZMbHQ5a0w0OSt1V0ljZjE2WHJvZ3JyQXhzY05GMHdqSitCVG9OWHM4?=
 =?utf-8?B?TTVpM21TZUJvYzF6Y1FrbXZ2dVhrVXdPOEZodU5UQk5LMG8ra2Y2TTdubHBl?=
 =?utf-8?B?TkFkQldWRDFOOFNoQUhsRUZXQmNBMTE1RkVNM0lWalgyQ3VydC9XelFyK3pv?=
 =?utf-8?B?NlI2c21EQklaVVpXdTFOc2VDRWV2VkI0MmRlY0xnN2gzbDV1M1dVbjFvRzFJ?=
 =?utf-8?B?YmF1RXV0NGd0Ni84enhvbk03dENKTnRuUVJEUlYyYXNaVmFSTUZ3YXNqNWR4?=
 =?utf-8?B?dFZlbkcweDJzRm51NUM4VDFlR09GYm8wNktRWEwzSC9rVmZnOE9yZE9mdHMv?=
 =?utf-8?B?Rk9WWFU3R3hLYWU1QzhTYUVSbFlRTFdlUkNJS3VIWU1VWmRCcFAzbUJTVEhN?=
 =?utf-8?B?eDEzcWZIY3BmQ0ZMems4U2NscXFmOE9Ba0tReHkvRHVGWlU5enRwTS8xK2lP?=
 =?utf-8?B?Tjd1NDh0NGZzTGlNanNwRnR1S0NrY3JjUkRVdzlkKzBJS0liL3UyOUFycWNX?=
 =?utf-8?B?T3BreU5wU284c3FtUUFQTGRaL1dGL2g4SUpVUTM5ekltYnJOWjlGbDVUWlQ0?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f122b4a7-9622-45d9-5fcd-08dd005096e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 23:53:48.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ee2b7zumYvkCMDboTpTKAwRuea5i8IaXRYi9M91jAnxhYR0b09D/zDwQAj/8w9ciGkJ9yUWNlPd67mLc2dQftdiK07uxrUtfOVwzyLyshl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com



On 11/7/2024 8:14 PM, Jakub Kicinski wrote:
> On Thu, 7 Nov 2024 17:37:41 -0800 Greenwalt, Paul wrote:
>>> why dropping what the user requested with a warning and not just return
>>> an error from ice_set_features()?  
>>
>> I took this approach of reducing the feature set to resolve the device
>> NETIF_F_HW_CSUM and NETIF_F_ALL_TSO feature limitation, which seemed
>> consistent with the guidance in the netdev-features documentation.
> 
> My understanding of that guidance is that it is for "positive"
> dependencies. Feature A requires feature B, so if feature B is
> cleared so should the feature A. Here we have a feature conflict.

Hi Jakub,

I also considered the netdevice.h comment for the ndo_fix_features hook,
which states, 'Adjusts the requested feature flags according to
device-specific constraints, and returns the resulting flags.'
Additionally, since this patch introduces E830 NETIF_F_HW_CSUM support I
reviewed the netdev_fix_features handling of NETIF_F_HW_CSUM and
(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM), which seemed similar—though that
case deals with a feature conflict rather than a device conflict. These
led me to take this approach to achieve a consistent implementation.

Thanks,
Paul

