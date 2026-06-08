Return-Path: <netdev+bounces-296751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TdEgIMpCJ2pPuAIAu9opvQ
	(envelope-from <netdev+bounces-296751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D665AF9B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KPBYDVKP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296751-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B48B3012C65
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0739A805;
	Mon,  8 Jun 2026 22:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763273672AC
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:31:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957892; cv=fail; b=NXrck/wE+6O7eZFX2A2DCIf6G+9SdRXewoItR+xQ1oAR/qHT9IuebgiFc1hzjSJYbxvUuzo+zbi1g21cbNkNmYbZTuK0MwEBFHvtecun/LxPH0cGfHBinxp3rzv8FLaCSswUoOdtKbb5GjM9gxHolssNGavkkVZhla2E+GS3ftA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957892; c=relaxed/simple;
	bh=ZMdRNX4dU+T112TPhWUwXbfv/TSOrw3dXyhB6qXq8LE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nEx5ANau8/zdGCXIZQRakk+tReai6LsTMSPdVctmjpAPFBL/QbRGF7LUCI8hxpa1Mlboa/dT9671F2N4Vfb7YX1qgQmypUnenzpYvmUGYCkftILu+ET0Kgtt0CBp+st45VIusO1BmnN/fClHM+0B3d5SH4Nel1HkEt5X1yVJOaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPBYDVKP; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780957890; x=1812493890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZMdRNX4dU+T112TPhWUwXbfv/TSOrw3dXyhB6qXq8LE=;
  b=KPBYDVKPG+Q2f4XnNvuXehpNEqfDNxqnDk/6fqT0VaMLLgvPA6GKZQa9
   1h8h+A1jKUy9sl+ipuSlIrWXECGesRHGxTFrouADk6gunI6dv6NaKW0zm
   +YamzAFR32HhS1oiLrupPIt8Sdcj6MP8OlwqF7iWpPgtmzf60Ndmv+/d4
   Pq4amf620x9iTvkzZ4jKPIpZZ7hmD3glTib3JrmqqAT8Jlt7mHLbD6gQD
   OqxwzyRo/i5hTCAyiNZhuQfS8pNds0uP+CgfHAAOy1Jfl7FJTIczX9IB8
   C6VUEvKdnKoOhEvBltF66BhOg8xwSIJPa6i2gtyE7A9xEWKb64BaSketv
   g==;
X-CSE-ConnectionGUID: DWKHhnETS86RfLAfsK7Fdg==
X-CSE-MsgGUID: YvAR9CKRRbijMHN6E02BGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81774870"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81774870"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:31:30 -0700
X-CSE-ConnectionGUID: r0mGzSxJRMWXAw/MUhoM6A==
X-CSE-MsgGUID: 7kdTD4yaSzCcVVutjixVuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="241240549"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:31:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:31:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 15:31:29 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRUSm5V8z+HT0PgdYDvqV5LVeD+5mDyDakFygxFe+hjE9xHz4brtZwiqpBi1NwAPj3py0jdYpreI/tCGvapntejA8B2R8pjm7HtUnT+eCKdhbYsr5iHMsJCHy+KMI/ZF7rfNgde8jLstlC3J/ApRwYUOmfmJzDQv0JLejvxTTBOCmd1ULMQCPnmQLumduooLmtiHE1+sEps3lWIg11TeMMVjftKKzUTsXkPnfUPcaI7RaHgRO5IWMq3MHtFdj8Sptu3NTbCntegJSG19sseUDtcbwkxv7vvknJzVnBHF4YIZ6Qx8fdzjlaNyr8N0rWpYqW/7cD7UEGhjrJGQlT/+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGo5ulR1qk2xoYRCCgLipuak/puiJo6eHsy0wyy/Nys=;
 b=QyAKL4j3zVphGjPzox70Yf6Z/5whNYoSO4v06aHGtBEr7kJ/QNMDyfRdOSf+rMJEbsyq7a5yHp/5H2gt2QpFF5tyNeDrkWlS8LhbflZ2igUodjIkaQBM1kim4BnEovPCJStgbTRGVSLL7n7BUqPRVKa2nBvTHSZzt26VAlirV0juKDuH4Ylon2Q8/3Q7pUNaFFgPjY+fvK0x/NW4478b68vLPquJru55XzlFXL/Vh1ZIQwGg4IaI1TbQ+/lnouOtNHB0dbh9YA2qocuStMAWqikanQqnc4WBfheOmONbZkkXi03a0GGYwU+KYAcOQq1gYT85uZo/wQo2+/uXymWTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 8 Jun 2026
 22:31:25 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 22:31:25 +0000
Message-ID: <9c013ab0-e96e-4670-932c-bcd1e30a85b0@intel.com>
Date: Mon, 8 Jun 2026 15:31:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>, Anthony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <michael.chan@broadcom.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<joshwash@google.com>, <tariqt@nvidia.com>, <alexanderduyck@fb.com>,
	<willemb@google.com>, <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
	<jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c56fef-91a2-4e19-b84f-08dec5adace8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|3122999024|18002099003|6133799003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: FjwuppFHz774xQVWF1okY8OFrv6Z53AubgMSWeXSmz/nF7Jmac5+I/Ymkn887VDNzrkskFI5vHlU527HDX/ljmVjfXQGAmrl+i0W9+pyzX6BH/YP99C5PC/eoah9jvxotz0lteJa05EpEibWrv7NXDiAf7NYmVz4jsaZ0p9q6O3K52r/KOEP/CXAfppRbBMJm4hAFHuqBbhG/y+xdkpUZOnT4RFp4nczQV5RG14QRT+8drKbonkmHy098PHIxiiSNllf0aalbA5PxnbLc46T7w0ZVTguOh6WIg4ucGUm/iIp8vwk0AejS6Y0RbgktDs8k/RGypNlsE+KsGEDebDkDRz5pQOZ6Sf2wAkGsVhUes06LWuU2REvEMF0QVuf12iJOyCo4Xnq2v0bHL32UCIW6JgrgpZg3u0028AY5tXhvpNNxzmuf70N86v50jphJDjc/4FymnVOPv9QSOIphmrl+TbcLETM8SKhEHLeyP7ubNqTG1yJaaSgMvdmjwrojrzVu2mB3VNE5ahgEPQbiXE5s9xgWtgRVAi4T5VqtpIRscNtPczLCcqKNfAFmlTQEznOL+NUr+vVIGUqaqvPTZLhp34Zvh4rm8bJnvcqli2fXVVZ11ItZ6xolmmmrnn71PBAePFmRiX90kUn9PNpsfzxNJGplt7nuMUD/VRGdLDWWRkwMRMNtc6W7gaOe7bwc55N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(3122999024)(18002099003)(6133799003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRZK0hFaWpiVDV2UU05eHo2b3c2b0ZtM1lqNmpXaklkOGdVWjVXa3I3Wmtp?=
 =?utf-8?B?dWU1Yi9PaHZQejAxZWJvbnhrVERFMUtPQi9WR3VMYStuTytFdkJWK0pzVHBH?=
 =?utf-8?B?MlVLQkRvbWp4VjBUTkVtMitreWJxUUxNYnYzeTNTYlBrbmJGSmFnOXkyQWlR?=
 =?utf-8?B?ZXBsZ3RWUVdMU0tyRkhBK0dycW5RK3g0K3hTYnFQQkVMRG54Vkc2WXFpdmVv?=
 =?utf-8?B?aVdUUElESklQR1l4SWNVeFBwWHZJT1I1ditVdXhkUVJ4SExHcFVKUHYvbVZV?=
 =?utf-8?B?cTJoNUk3RmgrVkxzWkkzNnhxcTA5Y21LTjg2VGVCUGtadmx6T25XU0J6MFQy?=
 =?utf-8?B?NWM5aWZyRFY0QnkyaG1YM3kwemF2QUJUbGFTbEdxbm1BMUlrbW9GZXFSZjY3?=
 =?utf-8?B?OXZmenlEZFBuV2xoMHgxL2h3T1czK1g5VEhWWGlWQVhFSU9DTy9UMHpDL21z?=
 =?utf-8?B?TkJ3YWV1VjdrQjNuakhvbEZiUVRQNE1SZDQwYlMrNHREU1h6Sk5VNEFuQUxs?=
 =?utf-8?B?M3VzUzBtWTh1eUo0SmdOOU45VHZiZ1hveTU0ZzdRWWlES3ZjZHpQREJlRmpz?=
 =?utf-8?B?SXFpZVlNWkZJeW1vL1NpU2dmZ0UxcWl6OGFiYlA1RjdhRDhaUk9yY0FITjh4?=
 =?utf-8?B?ZktUdndjWlMwdVoyMGNNUDA5S05tVzlNYnFaMjVJbmVvYWYrajRaL3BxdUt2?=
 =?utf-8?B?ODdFZHljU2JBOUR4cURTN0dmcnR3NlZ1UDdQYVQ4WWFqQmU1dG5hSjhMM0xF?=
 =?utf-8?B?bFpEYlpqbFVSTjFvRkRjQVkraWMycDdxU2NaSkxnYWNiOU5iK3A1TTl0U1Fn?=
 =?utf-8?B?UWZvdndvSW1WZGVlWnlhOUNRcEl1NGJuRXNvSWw4WWJTUkVOT29vUDI1RzAr?=
 =?utf-8?B?eWdSbGgzV2hNQXNIYStZUWZTNGRKYmxBaFFWN2pocnhiTi8vMkVTNjFmRUpM?=
 =?utf-8?B?UkVSSVBDd1VmcVpRRXNoWGJXQ1FMSVg4ZHhXNzVKbXVZRzJwdUw4dkY5ZWF3?=
 =?utf-8?B?S0tJZE9GNFFNZWRXclhtK2VqNnZTWG0rK2ZGVVZWa2xhOTNXbTU4cGE2YUFD?=
 =?utf-8?B?OEFzbjY0T2xWV3BsekF1eHRldW1yZG9IZHMwVGtnd0Q1eDg0bE9EdGl0U3ox?=
 =?utf-8?B?Ymk3WGRVMXJKNnBjQTMvVDI2dGxyYnhBakJZMUZNS2RTdWg3RFRFWjgyZG5w?=
 =?utf-8?B?ZVZGM0g0RU9PaTZFNVRkRmZGRVVIbEU2dkFwTzVVRytGRm5rVThxNnkyWG1T?=
 =?utf-8?B?MHRJc0xGK1h1dS80dHY5WWtWWnRyWUFYWnMyUWNiRTJvbkVkZWRtZEczZjVZ?=
 =?utf-8?B?VURqTWFKdVZRYWdvQ3VJZkhEQlNvbG94MVNKZDFSajNpbHJNZ0xCcWZnREVw?=
 =?utf-8?B?Y2cwbFdHLy95N0ZnZ0ltU0FiYjZYempORkRFNXVabm5iaHo3UUdXRWJtbU5X?=
 =?utf-8?B?MVQvYmYxYkd6VnYzU3RTU2ZSRysyVGxDSysyaENlOGVsK0wvUzM4TGNLazly?=
 =?utf-8?B?TjVuNzFhWFRDRy9WMmYvRjhWQzBNQzQxYktWUGl3WXNIL3ZqSkVBczhEUVdo?=
 =?utf-8?B?NUpQNXhzL2pIV1pMYTBwNFZrbUgzaG9mYVFjelZ5TklPcXlza0ZWVmNlK0cx?=
 =?utf-8?B?eFBJRFJra0tCcVdkWWU1Z2tZQjhlckJndFpnbS9hMHB4ZFJOeGxkQTBvYVlr?=
 =?utf-8?B?eUxlaTZnTUd4VHY2VHhvSTlySE4rYUR6b2Y4djBwM0ZXVCtGY0xmSnNmMHJQ?=
 =?utf-8?B?YUo3RUJyM1FZc3hDRGUwem9GKzI4d2JYS2loZ0hQTkVzV0hsRE04aGVVYUJx?=
 =?utf-8?B?TUExbGk2MzdURGFUQjlGMzhEb2JlbUNvWllaT1FiR21oRFl0QkR3aWQxOTBK?=
 =?utf-8?B?eWZvQ0JiRldpQUwzcklycC9GRlRtRkh3OS9RYUZBWDFsM2diSit1Z3llQS91?=
 =?utf-8?B?YlZha21RZzR2dExDK1paNGFnWFFTQjB2NGZoZlFJWlpPRWhEYnpmYjRRTmp4?=
 =?utf-8?B?UFR4Q0hHUkZxOHlvOVZPOHQyQUlsK1hHUFp5a091aXFPZittRUVXZWpzVXpJ?=
 =?utf-8?B?RzJWY1NBeVFkN3FWTTNFTm5qUGUxVi8ydVYrcGh2eS9BM0VTcE1waTR1V0ZB?=
 =?utf-8?B?WjFBc0hRMExtTjdJNGFBbE9Ha1pXQXY1VDBRZTdTZEEvZUVZaXFLRWprcEJw?=
 =?utf-8?B?d1VOUGNDNkRXZ0lzNUdiekVSSXdEYXZQZ2RzamZDVDlIM29lUUl4eFZCaDF2?=
 =?utf-8?B?bXNicnNHektnTGZRR3dWeDdZMlBvZnlFbWt3ZzNEakFGQ2ZKYXJaWnFTOXR6?=
 =?utf-8?B?bm9vdGNlSWtqaTVPb0FZUUpFVlFQVSt3MkplbWlrbVZtbkpidEJiUT09?=
X-Exchange-RoutingPolicyChecked: SkwF2IocKkphLvgA/+gZTzsj27WRwPdQCt2BDE/O1SHLNSaRGJTX7Xt+5x7D1EPF7YUKCzYHG11Mt1pIfusSFEk2BOM8rBusN3+0PHnL5pYnQpvvELpieu0SrcyNw/Kn3sO1SNWVN5ahIBJ2kbuekL7EhXzCxeWc+I3/L+LLRkESkqsUl+1vZU9pJbkmDdEzxn+yb5bCi9I8F3i4wULeVwNqw2uVjusM4vW20Tp3vME3mMiI0N1AzGLVKuCgdTfVcqWjAgprTdU8y+52aEAxNmPiqhZuadUrlVmLlSEkb55n4nMZcthRja8whI/6nm+jxzdw6oG8CDivfJdoNHYDxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c56fef-91a2-4e19-b84f-08dec5adace8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:31:25.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWwNuM9KprxFdshnPrNggggSnzKUdtwMNwF9/UFSn5e/2waAQCK9bt/7ayk7qlel7mKgjjcJ5YugbvmX74IT9uPFzRCXVreQodzS0VQBNtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F3D665AF9B

On 6/4/2026 5:29 PM, Jakub Kicinski wrote:
> With the ethtool_get_link_ksettings() situation hopefully ironed out
> the previous series (commit 6a5d837f0ce2) let's return to the main
> part of the series.
> 
> We have been slowly moving towards removing the rtnl_lock dependency
> in driver ops since the concept of "ops-locked" drivers have been
> introduced last year. Since last year will take the netdev instance
> lock before invoking any ndo or ethtool op of "ops-locked" drivers.
> 
> We dipped our toes into rtnl_lock-less ops with the queue binding API.
> Queue stats, NAPI, and other netdev-netlink objects are also queried
> without holding rtnl_lock already. It's time to take the next logical
> step and lift the requirement from ethtool ops.
> 
> The direct motivation for this patchset is that ethtool ops often
> involve communicating with device FW, and may take a long time
> to complete. Aggressive polling of device state on machines
> with 10+ NICs have been shown to significantly increase rtnl_lock
> pressure.
> 
> There's a handful of areas which still need rtnl_lock (see below).
> I decided to convert everything to rtnl_lock-less by default, and
> add a set of flags which let the drivers request rtnl_lock to still
> be taken. I don't love this, but I'm worried that opt-in would be
> even more confusing.
> 

Agreed. It might be nicer to opt-out first, and then opt-in the drivers
that don't do the update_features.. That would make it easier to prevent
buggy drivers slipping in as easily... But that would result in the
following messy situation:

ethtool ops for ops-locked drivers don't hold RTNL lock, *except* some
which do because they might call update_features.. *except* those which
opt-out of RTNL because they know their driver implementation doesn't
call update_features...

Yea. I think that is too messy. This approach requires slightly more
vigilance on the part of reviewers to ensure that ops-locked drivers
don't make a mistake here. However, the checks to see if features
changed while the RTNL wasn't held should be enough to help catch most
cases. Ok.

> Known issues / exclusions:
>  - qdiscs - qdisc configuration currently assumes rtnl_lock, this
>    is mostly impacting set_channels callback. qdisc config is probably
>    the easiest one of the exclusions to tackle, it's fairly self-contained.
>  - features - even tho feature changes are (correctly) plumbed to
>    the driver thru ndos they are part of ethtool uAPI. ethtool itself
>    calls netdev_features_change() if it has spotted device feature change
>    before vs after to the callback. Some drivers also call
>    netdev_features_change() directly in response to various changes,
>    e.g. setting priv flags.
>    Since features have to propagate to upper and lower devices anything
>    that touches features is quite hard to move from under rtnl_lock.
>  - phylink - phylink and SFP depend on rtnl_lock today, I suspect
>    that this is purely for historic reasons. I started poking at
>    it and don't really see a need for a global lock. But accessing
>    the netdev instance lock from the SFP entry points will require
>    some attention from the phylink folks.
>  - phydev - similar to phylink, looks quite doable. But no ops-locked
>    driver currently has a phydev (fbnic only uses phylink) so phydev
>    related paths retain a ASSERT_RTNL() for now.
> 

Makes sense. Taking some steps towards the end goal is better than
trying to wait until every piece here is done.

Whole series looks good to me. I had one minor nit about one patch
adding a bit flag at BIT(1) and then later changing that to BIT(5) but
its ultimately harmless and should not force a respin of this important
work.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Tested on mlx5, bnxt and fbnic.
> 

I think currently only iAVF is ops-locked for Intel. Tony, would it make
sense to see if our virtualization validation folks have cycles to give
this a quick pass on iAVF? (Regardless of whether it merges before or
after, it would be beneficial to make sure we don't have any lingering
issues there).

I know there was work also being done to migrate ice to ops-locked but I
don't think that has managed to land yet.

> Jakub Kicinski (12):
>   net: ethtool: serialize broadcast notification sequence allocation
>   net: ethtool: relax ethnl_req_get_phydev() locking assertion
>   net: ethtool: make dev->hwprov ops-protected
>   net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
>   net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
>   net: ethtool: optionally skip rtnl_lock in cable test handlers
>   net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
>   net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
>   net: ethtool: optionally skip rtnl_lock in RSS context handlers
>   net: ethtool: ioctl: concentrate the locking
>   net: ethtool: optionally skip rtnl_lock on IOCTL path
>   docs: net: ethtool: document ops-locked drivers and op_needs_rtnl
> 
>  Documentation/networking/netdev-features.rst  |   7 +
>  Documentation/networking/netdevices.rst       |  17 ++-
>  include/linux/ethtool.h                       |  36 ++++-
>  include/linux/netdevice.h                     |   3 +
>  include/linux/phy_link_topology.h             |   5 +
>  include/net/netdev_lock.h                     |  11 ++
>  net/ethtool/common.h                          |  76 +++++++++++
>  net/ethtool/netlink.h                         |   8 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   6 +-
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   3 +
>  .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +
>  .../mellanox/mlx5/core/ipoib/ethtool.c        |   2 +
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
>  .../ethernet/microsoft/mana/mana_ethtool.c    |   2 +
>  drivers/net/netdevsim/ethtool.c               |   1 +
>  drivers/net/phy/phy_device.c                  |   3 +
>  drivers/net/phy/phy_link_topology.c           |  10 ++
>  net/core/dev_ioctl.c                          |   4 +-
>  net/ethtool/cabletest.c                       |  12 +-
>  net/ethtool/ioctl.c                           | 123 ++++++++++++++----
>  net/ethtool/mm.c                              |   5 +-
>  net/ethtool/module.c                          |   6 +-
>  net/ethtool/netlink.c                         |  62 ++++++---
>  net/ethtool/phy.c                             |   1 -
>  net/ethtool/rss.c                             |  21 +--
>  net/ethtool/tsconfig.c                        |  10 +-
>  net/ethtool/tsinfo.c                          |  32 +++--
>  28 files changed, 363 insertions(+), 114 deletions(-)
> 


