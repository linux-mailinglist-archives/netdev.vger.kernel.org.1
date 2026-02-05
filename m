Return-Path: <netdev+bounces-257103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VnYqMPVthGmk2wMAu9opvQ
	(envelope-from <netdev+bounces-257103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:16:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF0F13CD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7DE83014137
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72F27A916;
	Thu,  5 Feb 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV+qM8Y5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99820DD75
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286578; cv=fail; b=Wgwp9y8OVtZoB5nHAykGabrOQsnrLebyuq0GjaTg39pJLfvw/qdVafaSW1MCW43MTd/FMuUrOQJWGNpHZI323CBOxiMqhVFGWdFbEfwrzvV99dLbAUpW4pMUFExS/0PwUrFy41WDXYtLwC+l8Zud32YlKvWvaay5/tIIj8UAqoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286578; c=relaxed/simple;
	bh=neYBt5/bKL8aFT5I+wBEQYpOT+2Y3+8uKfGOLAVPrzQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rV65g4Kpoe8JBH2TOWW9r1VOKIMEeu73AKdnyU1phu7pHLTCRs8LzEw8VhynqQu1J9lhnZa/aR4XmbFlMOzgNwxoU/A2CWXk+arjPAbrBRf7MHv+1Yo3NeNtm+H3d8iKKVe1BFMnZ/0TmcP7tnEihw/Gk/acTZB5RHbYYojBLUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IV+qM8Y5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770286578; x=1801822578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=neYBt5/bKL8aFT5I+wBEQYpOT+2Y3+8uKfGOLAVPrzQ=;
  b=IV+qM8Y5TCx3ZG7wtzDhEY1eYL99jZ2lQHRYQdbfXCcBKDTeTAFJdxys
   coxvAs277N6qu/pMC7mYU7myKFj5jxjOEBOjAXTUXojPJVm3/m1oDswAD
   mjxMTEwi2QqJlnJOeRWD4yHS9y6cY8pR01bhNPMa8yf5mck0EsRv2K5aI
   yNXAbZ4L32CgIba+v1rLcv78/l7cdx7bI0/efOM4LYb49D4EmxaWhHqDL
   uqHcaMceBHqQu9EPW489R+bqkIzluYIMQzX4BWo45/t6Z1xgieATO7T3M
   xEuhP43qsWc9FEeV5SccJEbJMA8wKAisKAVbnS+lxFDYLaXehKJAgqQu1
   Q==;
X-CSE-ConnectionGUID: pc4zmzDSR6iRdzLe0SKbTA==
X-CSE-MsgGUID: KYpbzRVhT36blhfhYQu7mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82601218"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82601218"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:16:17 -0800
X-CSE-ConnectionGUID: F+/VfI96SyeCwFyjkR4cIw==
X-CSE-MsgGUID: oTIykZnOTGyL0AenMW7tYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210408014"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:16:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 02:16:16 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 02:16:16 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 02:16:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+oUBQDPUqg5eOCflGFfuGZ3vWe1KIgU1+Lv+FX7oYhOCOi3UTIjYpRS07Esfhpqo3wJdOvK6EgQQ3+bnjfou+X1neT4nu/m7kVHO1Z3Kqya6ypDCJ487WZkcjs4JyFyYknyMoyBLpwabYRm7v/obIX6CoozMEEb0drzm2mHx8j4qtutPiw6B+W3FdR37QBLkzjwstL3Q7SGk16aI4aiYOE46lsq/6krk5ZrQXgdmx1OhofEUV9qYr6sMNOvW2ILprLZpgX+UV3HVgDzAO87OQdgFvZRBD36xNAJv9FrerdnRk21wsymfJF5jEuqlNdgt1cOI7M9h1S70HwX25Ua7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/778OEvxMHngML9UEkXcZUVgsI+buINtxSNz7U/lPE=;
 b=KTV7+Yjk53OkVOGM3xk5cBbbvrAV/PCY5HyArGtWlzUlQHJ0qn5QccatJG5nQWRcnxOQlzwtpFPImFfcF07j8J8sQm+aKqCB7x70NCzX2NjfrY0gEtz4NcoIuyBSVlZCK/+t81Lpy6tw0MFPeg4gG6/AUdOJk/ZnNPXibAtVmAy+hT3jBljqXznGupYzzv6qXGSrWsi/r0KF7FIs9uF30i7akHA75BU2eZCTq+Bezigo40U+/Fk/CxuA6eOu2HkJCzwW4x+vkvyMLIVsp9ONxVzjlV4EhADQJPWpOwbrIt1HLomJMajVrR3DgJCRBmvCqC3A+G4gMEs3G6iAT+giHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36) by IA4PR11MB9371.namprd11.prod.outlook.com
 (2603:10b6:208:56a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 10:16:13 +0000
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::1fee:366b:ed73:b459]) by DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::1fee:366b:ed73:b459%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 10:16:13 +0000
Message-ID: <3b481682-5a64-412e-a085-8d3c6323dd4e@intel.com>
Date: Thu, 5 Feb 2026 12:16:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 iwl-net] igc: fix null pointer dereference in
To: Kohei Enju <kohei@enjuk.jp>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
References: <caf4b292-5fd0-4ced-bfbb-1ea4b99dca24@intel.com>
 <20260205092650.7779-1-kohei@enjuk.jp>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <20260205092650.7779-1-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF814058951:EE_|IA4PR11MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b31fc61-7639-4edc-1374-08de649f971a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vjk2V1J4Vi9WUWxIYi95ZDlzdHJxQllKMVIvejhZMVhqRWl4Ky80WVh6ZDFJ?=
 =?utf-8?B?SFBSYjJGd2hyQjU1Tkw0ZzZrRGNpeEZxMVd5SVZVeFhVL2JVa09aeVNKcjBI?=
 =?utf-8?B?ckpVbWpPU3lUekRpbWJycUQ4ejhtZHhNbTVXZlRhM04vaW55cDNYeWdaNmlo?=
 =?utf-8?B?QjlIek81dEtWY0lHSTc0VmRGUjVuUmcydWpieHUybDBQWTEyU0FDK2lVUlV5?=
 =?utf-8?B?RnVIRGMzYlJSZ2tYdEVQWXkvRklBajdhOTlVUWdua0xsR0luSFJiTXI3S1Fr?=
 =?utf-8?B?MFcvV3pZODJDZVFDR3VJeG9zelMvMmZ2Z0FIMlk0R0VMQ2NzQ2h0Q2dKM2Ex?=
 =?utf-8?B?b0JHck1YVForb09YSUx4UXBuNC9tbnNGQmQwQ0wvdmpMaVNnakU3RnpsclB3?=
 =?utf-8?B?NFhoN0hHbytlN3JDQS8rWDVEMGNYMWdaWnFIZXZEZllLcHRmVDYzWko2OERm?=
 =?utf-8?B?VUk1a3pVNXA4NEt6UG93b0VPMGhlUzAyTlV1dHpqdXhTaU9FbVErTkJpNzE5?=
 =?utf-8?B?Wm9VR0NYSW9LV0hxdmdpRWZOR1k2eW0weDZaOFZmZ0xldkNXMkpPZlhNK1Jt?=
 =?utf-8?B?VUxWOTA1NFRLVWs1Z2NaSGJPR3hZQ3N3cTRscmNjQUtPV25yNWdhaVJQelFm?=
 =?utf-8?B?T1JWNXlxMDhuR2VaZ2d4d0FrL2ltTktxOHl1UFRndHd6VmJ1MEJVNzJtejZB?=
 =?utf-8?B?V2pNM2g0aG55bVRNL05oTmZiekV2L2N3RVN6UmJLa2M1VUI4dmVjcW51NlR2?=
 =?utf-8?B?THJRNGptQ3AxRnBnTmdBM3ZVSjVJa2tncHZ5Q1JCYjRnWTl4YTE5QUcyQ2Ru?=
 =?utf-8?B?RTZ4a3FiSFY1dWtadjRSNy9ZR25XelVMTnA3N2lZYnlpdXZBR3VEUGw4MkRl?=
 =?utf-8?B?WHFsM2hGcGMxeVIwL2dON0FoVzROQ2ZPdHA1WFBDR09KeVkwTktQUjM0andD?=
 =?utf-8?B?cFFaODFFZC9iNkxKSG9TL2V5NEtsOVlMdWZyeldPUUhNdThkTXVHUWs1MW5Q?=
 =?utf-8?B?b05XUUNXNTZWVGlUdGVnRGxWam1HeU16WUdzVTlaWDl2RXB1UzNoNTc0WSs1?=
 =?utf-8?B?c2l0Uml4TGtRa1lqUU9QZmhVMzhHbEFPNUZoeWVpbml4d2d2NkRyenpmcnpG?=
 =?utf-8?B?aWVxRjVUWGUxRU5LSWJnNWhYK0NBKzhjR3pCZ1ZIVURpbDIzWkVVWGcxQ1o2?=
 =?utf-8?B?aWtCNlFvUWZGdWN3RWZTVDl5YXlwTmlvckRVMjN1dElTREdvTjhhSXhSQmJu?=
 =?utf-8?B?ZW1MT3RPcXdGN2ZFamhwUGNZbldsaTRkY0JRS0NiV1NmSzJmTHY0Wjd0dkpB?=
 =?utf-8?B?SnNMZDNWcmllZi8yMnppMjBpRDBYZUZZcWg1RTdiSlAwa2tqUWhjVDA0OWF5?=
 =?utf-8?B?SkRVYmJBdjRzSnN6VWtia3hUWnpwNVh2RURJUkxpT3RtbEdmaUlGcUVLQmd6?=
 =?utf-8?B?dVN0aC9ZQ21KZ0lSbTVRQTJIUVI2SlNzaUtDdEJwd3ZZZ1kvTmJoQlhZNlI2?=
 =?utf-8?B?NjQ2VEhaL2tCdWlnOXJtWE5nSjczcjdJMzhLbmNhb2NtVm9VU0p1Vk5XOWdD?=
 =?utf-8?B?Z2FZUVFRYXpoeGh3ZGd2SHpBQW1WOFgzL2FrU3g2SlhwaVVQckNrVUFXa29I?=
 =?utf-8?B?S3g3V0VEWktWNG10Z3A0S1RNOE9DckFmUE80NkdPM1g2dGlvb1Bvelh2czlD?=
 =?utf-8?B?SmpOT0d5K3JuSmxaTUNwbFFYcVJyTmY1STRvTGhtdk9KVFI2cGgxMDJqQmdk?=
 =?utf-8?B?aFFPckpwWG5jTFFIeU4wWWNxM1czUDhIN1F6VU9TL1g3VXJYVVZGUDRHYjZC?=
 =?utf-8?B?bW05aUFBZVFML0trdE1NSHJYdmJjd2lSOTFNSEc1OXgycGxQWmd5SHAzN2Jo?=
 =?utf-8?B?Zk4wVlJ5bGNWUXJrTGNGZnpCMFd2bklVWk15cldUelZxRlRwVlBCZEU0Ynk3?=
 =?utf-8?B?WDQ3T3NlaTg3ZmlNc1o5U2QyWC8zQmFRY2psWkFMV3hJdG9lZlpLMWFYRHBo?=
 =?utf-8?B?eW80dEtVVGxOQVZRblc5djlRVnh5QmJ4TG9oc0ZrTTNkUzNWSjNXT20yTVZP?=
 =?utf-8?B?V21SNW9hUnpyeEc2UzJlMjVDdXkvNThCMEltYVFPRkkrM1BDR1huYkQ1bE0x?=
 =?utf-8?Q?5vNw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF814058951.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZqVmMyQTFYRDNZMFJmeVhNSnRwbnJjSU5hdU1rY1BsWFZ6eWdqSkdGT3lj?=
 =?utf-8?B?RWljYlF5emF6WVBOQ2thUjh5cTFqdzc3S2FCU091SXBJeVFobURKZWo1eUVl?=
 =?utf-8?B?dmRNeE1OQ3hJREJrOGVjQmc0Uk00WlZKUndQbkhuTTNLam5wSDhQUXRTUDZa?=
 =?utf-8?B?MnVMZG16RjdPWVFXZFZUZ3B6dGFEWUF5RkNESThpbU0yRFFYdStUa0swN2xK?=
 =?utf-8?B?c2tna3VzUmFiTFBxcXI5dGtBYjd1UkRMTkZ0YURUYUxVUHlDT2Z2M05Ma2JV?=
 =?utf-8?B?VUg2RnU3TUpzNVpLT3ZIU3VQdkxacXJNVG5Sb3FRRUJzSUJUYktMb0FONHQz?=
 =?utf-8?B?aXNQWW1zMGlIR3hvV1lxTHpGS1RFQVNieCsyRElmeTlIQ3VGNkN6K0tMMHAz?=
 =?utf-8?B?eGtGL1pHSnpFWDJuaUtpM0pXNUwrc1hOVlhsTzU5cUV6eG1ndVl6UEFCeDNN?=
 =?utf-8?B?WmpDc2IrR0Z2NHZWeEE3SWtmTjZya2c4NXdOeTF4cklndVUvN2dGYm9SaTRX?=
 =?utf-8?B?MUtEZ1FNclBLVWRPY3hLdmxkRy8rUUNiM1VYVTc4OGFFWWJFOHE2T1gyY1lm?=
 =?utf-8?B?YkxDSmhoa3lxaW9VYWc0QlUxY0hzNjVlaVdwNy9kSENvNVVvWWthYVNaZVFN?=
 =?utf-8?B?M0p2WmJqSi9HbWdOYXJ4TWp4TXo5VFp2UkVpNlViRmdFYnA0djRodE5WSFhu?=
 =?utf-8?B?eHBTbVRCM2cwSFdDK21Bbm45K2tGbHF4ZFhaQTc3WHd3WDU2cFVyWWR4Z2xz?=
 =?utf-8?B?U0k0U1ZjTGhieDlVenZMRDdFVFNCWU16cGplRCtpdWpYMmpzOGdsRllVc1Vr?=
 =?utf-8?B?Z3F5Z3lNQ1F5ZWdqOGpLNVNPZ3FkTDVQU1FCYU5DTVc0ckNzaXFZYkJMandX?=
 =?utf-8?B?UUNxK3ZZbFBCR2FQNm9IcFZRZlRsWWZNM2gvL1dkeHd0OXBKWWJWRFIxUCtY?=
 =?utf-8?B?Q09qZWRXVjF6VjdnaGlCTDg0b1dBZjB4MlZwbVV2RjdCbkFUbm9NeURYMDhS?=
 =?utf-8?B?VUdveHpZUi9GTHBpSGs0Z0VkMytjdTkvMENYaU5McitzbVdCSE8vcjk5OWdZ?=
 =?utf-8?B?R0NQQWRGRVRlZ0VjNWpBMDJOUUdTLytubDVRdEpDZFB2RnNINzUzZjZJWlhD?=
 =?utf-8?B?blZEeno2WnJKeXJvakVzc0FaMzRUNzlaOGNuemhoWlBtZCtGN3lGYk5pOXJ0?=
 =?utf-8?B?T0t3Zk55RnpodlRRRC8rU3BlUUlFbTNLMnBLMUV5QUNyQ2puUXNoL0c4aEh5?=
 =?utf-8?B?QjFHSVBRb0Y1R01iNTRCbEZrWTFXY2FEMDRSUThNSXhtcFdVUFJWaEVGa2FX?=
 =?utf-8?B?YzhzSjd3N2RVdzJWeG1ydHNVaTZ2RTQwSGZXUWJyQnhEdXh6cHJxK1dSSG54?=
 =?utf-8?B?dllldG4xbUdwV2JQbDM4NFRkWnhrY3R4Q0NqR0dGNnc1Q1I4SW1kVU9EY2xl?=
 =?utf-8?B?a21Sd050b0xpcm82c0ZqbmVNNnZla2tkUktDSjJ0Y3VGTVBDc0FQaDhHRDVl?=
 =?utf-8?B?U3NNdDFVQmhnOG9OWmFEbWM3MmV2c1JlOVNLNXlFMm4xY0tpNXR0Wm1CNUUx?=
 =?utf-8?B?YWFJYUg2cDNoVUx4R2wyQ0tPa0ZjRWNVV0dLY0NIM3QxdVNQZzNSV1NpRGgw?=
 =?utf-8?B?RHhFZXNyMG92dUU5YnBJUFdzdUFRbUNzcmtQN3NsZ09QdGVIWTJKRFNudmxm?=
 =?utf-8?B?U0hINEc4bTJmOUVjc1oyZVkrZW1mZS9FbjBLQVE1azZXMUQ5T0drVDMyRGFQ?=
 =?utf-8?B?NzVxRXh1UG0rdFl5eWNRU3hEYjVpNDVVMTVYZEd6aE13N0J3WXhJOHJTYTA4?=
 =?utf-8?B?aTArZXY1L1RKTEJxQjlLdWR4OWhzR1ZPR1d6QThzcG9rSkJyZ052cjNKVks3?=
 =?utf-8?B?QkQ3cWQvY0M4bW05cEE3Y1hJVndTMDU2eEpObnFtSzF6VlBMS3ZRelpkZGkr?=
 =?utf-8?B?N2lRZ1JJQ1A1eWFkekE3TU5XQ3NiWTJna0s4dnRUOTNsY2FIVmdESkc3dXpo?=
 =?utf-8?B?L0hsb1hpWUU5dDgrM1pvOEtEeXl5cFhYSkhORjFOV01nY2RrVXZhNlZGSkh0?=
 =?utf-8?B?cU5uaVNRTllRRGpCVEt3WHRuWWJSeTI1amcxQ21SSHlOc2xjZkt2VTBkUlJv?=
 =?utf-8?B?KzNyZWVkcFBkSVBnSVZwR0ZJNnMzZGNONVFNVFljUDB6a09LbnJTQUtsNnhL?=
 =?utf-8?B?bWNtMzNTV2ZIdnptUjM3cjhmMVhraTJYbnBNTjhZakE1OWlab1MrTUl2VXEw?=
 =?utf-8?B?RWowZE9XTDUxTGR2SXZVRHg1bkJvMHBwdjlXSXgweG94d1ZCQ1ZGVEQ4cmV6?=
 =?utf-8?B?RGRpYTZwemJGM25EYmVXNDM1RzMxb2x1VE1xZkp6NkJBK3NaU1FuMDBVL0NX?=
 =?utf-8?Q?02rxl7oeodW+R8io=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b31fc61-7639-4edc-1374-08de649f971a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF814058951.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:16:13.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBKt6ONgqQyTR/BBLTEhLR43NggEDORco841AaZ8gvqX6WYESRcxXIM9Uaj9fjAlb9cBd93iSKDafE+kAwfFR8Tz71SwRAbmzreogbctMsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9371
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,lists.osuosl.org,gmail.com,kernel.org,vger.kernel.org,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257103-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vitaly.lifshits@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1ABF0F13CD
X-Rspamd-Action: no action

On 2/5/2026 11:26 AM, Kohei Enju wrote:
> On Thu, 5 Feb 2026 11:16:50 +0200, "Lifshits, Vitaly" wrote:
> 
>> On 2/5/2026 10:50 AM, Kohei Enju wrote:
>>> On devices without NVM, hw->nvm.ops.validate is set to NULL, therefore
>>> functions that perform EEPROM-related operations such as
>>> igc_ethtool_set_eeprom() and igc_probe() check for NVM presence in
>>> advance. However igc_eeprom_test() unconditionally calls
>>> hw->nvm.ops.validate(), potentially causing a null pointer dereference.
>>>
>>> NVM-less devices may not be common but possible, so add NULL check
>>> before calling hw->nvm.ops.validate().
>>>
>>> Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
>>> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
>>> ---
>>>    drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
>>> index a43d7244ee70..973d26a5a6c9 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_diag.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_diag.c
>>> @@ -158,7 +158,7 @@ bool igc_eeprom_test(struct igc_adapter *adapter, u64 *data)
>>>    
>>>    	*data = 0;
>>>    
>>> -	if (hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
>>> +	if (hw->nvm.ops.validate && hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
>>>    		*data = 1;
>>>    		return false;
>>>    	}
>>
>>
>> Hi Kohei,
>>
>> Thank you for your patch.
>>
>> Since there are no NVM-less devices I suggest removing the flash-less
>> code entirely from the init flow.
> 
> Oh, I see there're no NVM-less devices. Then removing sounds good to me.
> 
> Could you clarify what you mean by "init flow"? Do you mean removing
> only the flash-less branch in igc_init_nvm_params_i225(), or removing
> all flash-less related code including igc_get_flash_presence_i225() and
> its callers?
> 
> After clarification, I'd love to work on it. Thank you for taking a
> look!

No, you shouldn’t remove this function.

However, if for any reason the flash is not present, the driver should 
fail initialization.

There are two related places that need to be updated to enforce this:

igc_probe() in igc_main.c
igc_init_nvm_params_i225() in igc_i225.c

This way we avoid supporting a configuration that doesn’t exist, and we 
prevent the driver from partially initializing in an invalid state.

