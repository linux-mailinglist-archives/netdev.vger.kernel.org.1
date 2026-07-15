Return-Path: <netdev+bounces-307767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pt4ZBmGUV2qbXQAAu9opvQ
	(envelope-from <netdev+bounces-307767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:08:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9987875F29B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:08:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jFZGqZGk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307767-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD902304F38C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F230D40A;
	Wed, 15 Jul 2026 14:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D33115AE;
	Wed, 15 Jul 2026 14:02:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124124; cv=fail; b=cdRwGg1P3pxfmbRZoxw8v7NjhZs9pLC1SsSn9AOhw8vkNJ60tPoQP6umZHu05z7FqopMJNK7yroEb7dW3za+CJTTpSeuJcXtE/Zqs7Hrro1seYZ4ezb95aF3Bk4jt5PvVvoETvBgjiWuADH6PhCcOCaP+4PMmkatOqX4tV1Fy80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124124; c=relaxed/simple;
	bh=18FR2DfnavlH2oMS2wMtMgwbRwD5l4WH3PADGXkkgdY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lnbs/hdjcBnrDca1EsXSZxo0tcH6vV0OKv1kmhsf3LJkGdQFMSIKCebqYMDX92AHe2kSkqHAlN1BRwfhUVYZ12mMV4f3A9qEIAd7KMhuaPTMRbQ/WGuPr/ATdNiYE1QYE5K1Ao1DKb2hsnvpn+V8BHRWlYs2FhwRIyBOZVpZK0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFZGqZGk; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784124121; x=1815660121;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=18FR2DfnavlH2oMS2wMtMgwbRwD5l4WH3PADGXkkgdY=;
  b=jFZGqZGksaZBSi6KKA4jvP785NnkJXQ985Tf54mx6yCCG46Q1r8WOpRy
   3GdSrsXvqDO41YE+a3C8rEfi8pS8Xf9HoMzfVMT/9uN9TucHvXlwlE4Bh
   smtqJ8q8/Q7/7K8aAdTBGRdcc4DuHvihgOg+QF6qHYAkjIROgYk8wlKai
   6nGHhJvX9fvXjGynD0QwAaKsh7BPjLZ7w0tgW3wrllrPqiL4CRyysO+ZB
   Y6yWHnbN1zzQ7Qoa0Ki1Gs7dtadcTAHOzyFi6B1GhWp5Dd84UbjR9QCuw
   vCdEgNFbJK5YaiHeJwOgOpFLZuZApYMTxvP6arrsgQiioG444RfumBrsx
   A==;
X-CSE-ConnectionGUID: DEts8O0MSXGQXhm43y+gpQ==
X-CSE-MsgGUID: 9ag3YwCOR0eDHkcjehyLbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110308303"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110308303"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:02:00 -0700
X-CSE-ConnectionGUID: fvdB+zDvRKuENylLbJhw4A==
X-CSE-MsgGUID: mxekyEneTdyaBkyFxccL1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="256838720"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:02:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:01:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 07:01:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV7fI4YZCG/8jiIgPB7oUxKNGoH0dneWUYk6P2J0BAsagSs35zt+YkzKfYr9g2nObF1oO4Lct+0pDP1QMUd3yo737WbWCQ/gFs/RcYU3m9Q7CzgJo/zmSCCDejsnI+Tqa3yicTR84IvPFFW7GA6azuF0bp9nj2LBpQY30X6XDyCcFu8W/rKRj3SBkmwvaemv0jcScJ/PjwbvATy9SxZKYN2E1LcocMTebr3VihWM8g/sZQ8Z3r5z+YGQ6wpt6ZHmqh1w/NqiYz5vZlKZo/xxPsrcAVl8/tK2YhaAmfWZApoR1JSLuT4sdhh3ZR1mfv6OcIHEtoS1JxKYcNQyZrZHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72bN5xV89slNbpV7FUIlhTqFL+ItGocxiaUQnxZtmTM=;
 b=fzJ8A/4KZEM5pvvywBCBYd2kg3fMdX79P8NErzUZ35plPzV5BDm6sPpA59IadgBdqe6Uw5/LTpKvhQHFuByDNeFaT4fLsITmrZf8clDTYnVXKJwy9g/F25d6HYVtsB/hVSlzzBJb8IlN5A+nnSSI7xBceE2EJhsN+bNy9HfoTwiUWa5+ET5szoYYu+l5J2yFVAlpq24WQkzlhvFsZjt1dsQqMR1hqdo6BQpVCczj0Q8CdK5dvfcB8BuSzl4fNWH1eCtAOuZ6llJ/JVLUnnxBU0c2XIbRRP+Pf8GXAO3+EdkJoXrgfjUAMVDLlCe4nP+7rBWjY/RJLyGszPmPm8P1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS4PPF30373102B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 14:01:54 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:01:54 +0000
Date: Wed, 15 Jul 2026 22:01:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Brett Sheffield
	<brett@librecast.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	<linux-doc@vger.kernel.org>, Simon Schippers
	<simon.schippers@tu-dortmund.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <202607151550.5d829a99-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS4PPF30373102B:EE_
X-MS-Office365-Filtering-Correlation-Id: f2734fed-ffc8-41ff-80be-08dee279a0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|3023799007|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: l0HsLtiHMGP8zahRzmUHuTemNOLnlPPAy4FitUNp2oOsKwxfwq8vDLXEVcK+xiaum1jWS/quGAGFyEiQ4lBKsn2igOmggu3V4gw2vJockm5SVQoM3uxyqM7DtMUACSnsdWt8PNxYv8cE3ZQvJBE/Z6rv8Kb6EYQCoCGvOl76HYW50DnlK+1OmPMLVsR2d1Zmn92rf8su60jZ0CSDCFsl8PAEx8YjLeqpMD+2HLRDEZ+z7IqlPSBf1yGff3F+aj3oToESslbn/ev4PpgUVg7vEp2TxFjnsdRJK21mX7qRpSIZHVuAg21o8WepBsK/FU8rR4ffNtpyE5gz/FRxshIsgRXltYN88ZVjt5kzKzA5FS00h2MFp37uVmAXwORIPT47tJZKkj+0JXqNNaYKHsMzcDpD0KAccR+uDalKgPllSRj421JeX+lDan+HJsiKeI04pGi4nsylxS/YBVEgMmsdiUEEAngLLdkWkSfLAcjS0CHJKyMfj+TENNpE7Nbz2RpO7tvpPevPae5I7zwDJ9ObWgwEP6F273BmfdhUqoI373mj6O4I9xDiZ3ksNOIRczaiCHzbepdupa6MPv15wh79LGxH+funikWvzP2oyM1DqFRLwFWxtENLnYrvOdO4+2DQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNVWVA1UU9iT3BINXFiRkpoNTBBMmFJYnZpSlFZbDBneWNFZXBRNEVxaWZE?=
 =?utf-8?B?dGlnb21RWFdLR1hFc0xCRGpISkxUK3JFWUJuQW8yV2t4aCszMzljeGVsWnow?=
 =?utf-8?B?Qm8venlFZ2REQUROK1ducko1aDJ3d2dQdUQ5aVJaRDhnREd1NVRrcUV5OWRi?=
 =?utf-8?B?RlgyRWVaUWxCRmdQWmRMdjEyUDN1d1QzN3VaKzc3TkNXdVA5SEFxS2JKZlVY?=
 =?utf-8?B?Y3VIU0pYRi96WkNvdHVHTzVoRFZnWnBnL3BBRXVNSVYrQk1qTU5NRVZZazV3?=
 =?utf-8?B?NmlJR1VhckRienoxKzlNcDFiU3NCRGVZUmF6TFFtOE91cmNHMjQ3YkJNY0ZT?=
 =?utf-8?B?Y0dNMFFzelR1c3ZFQTlvK21tSUxTSVM0bWNqcWhqb1hlSTE1WmdaR3JvdFNE?=
 =?utf-8?B?VWhhRVBGK0hVSzQzR1NZQ1ZNOXZtWkNiTGcyQzdlaUJNbFBKRTk2RFVzeHVr?=
 =?utf-8?B?MzVSWmh4WTMyM1luOThHVHJyTUxXcExMa29NdkF6cDhjNXFPME1udzYraHFw?=
 =?utf-8?B?d3U4UFJSTEFKUm5DdnpPN01sMjFoT0g1eGFKbnlxdUFRdldJSUNidksxRThE?=
 =?utf-8?B?VGthaHlaTm91bUs0VEpsMXRxSUlLRXlwZk5Fd20rK2NZLytSZklCRW9wb0JN?=
 =?utf-8?B?cHJKVlcrOU9uTStjUFRwcDZwMUFVTHRUL0FlNTFPcGN0ekY0RXJha1QwRVVm?=
 =?utf-8?B?dG1nYlNxeHpMR0hlVm44bXBrYUtXUVRwSTlpMlZFSGxMMjhiUWNKMXJJL251?=
 =?utf-8?B?OWVyVjEyWDBySnZNTFhtRWRMSDhaK1ErS1JFcTRrcG42aVZYY3RQVnpleE03?=
 =?utf-8?B?WGR4alZqUVZhVXFlVzZtNU8vUUhxUDhORHpMSG03M210dmpDSFgwR29EenBZ?=
 =?utf-8?B?SFp3VFRPcFZwUE4wTS94eURaYUpEM3RRWTBkQ2NSM3NKaUtyRmZFci8wZVVO?=
 =?utf-8?B?UlhvblNoYW9jaXJrSEtBclFkZm5kWEtET2JzekZCMXBXSW0wcTRxcjJSd1FQ?=
 =?utf-8?B?M0xud3RrTHFuczNzRnVNZkRBSTZIMEJYUnh2YUhERWNoMlNPYzVBcUVuM3Ur?=
 =?utf-8?B?Mk1tNmFXeFovRkhEV1VsQSt0ZWRiQ1NjL1ptRDNvQ2Z3NHY0MzFOdWNjY1Y5?=
 =?utf-8?B?aUg0OXYxb1h2T2NwVlhmSkRIRUtpREJvWVNGVEFJNGxtZjFUek5qN0N5cFUw?=
 =?utf-8?B?ZHNFbElUL0p1NnpzNXIwUjBBOGdFQVVDd2ZTY2pncHRpNmpXemFYT1BRakhY?=
 =?utf-8?B?L1pOMVR4SzdhUlVNYXJ5dzMwajBOUlp3L1FBbXpHLy9zWHhya2dHZWNacmlK?=
 =?utf-8?B?eFBDZDFIaWl5aW80VFB0cy8rekZSbEkwdUY5anN2eklOOTZxcHhkcm5SZjJK?=
 =?utf-8?B?cVJYMFoydUZYY1lWNVk2aXNhK29aOTE3WlNpenBiekRJeFhkZTBnQ3IzbU1n?=
 =?utf-8?B?UXVtYVdWd1N6OU9aVHVCMGlyZnh5eTUrRFJqanUrazBud20vMjE2UFFSNlVC?=
 =?utf-8?B?MC80NWc2RjRGd0ZjdWs4WFMwQTYzV1BRQWd1STlHaFpIZm8rR0c4M0JYMFBF?=
 =?utf-8?B?bktTQWI5b2FEcHBwTXpxekYzN1VsbmtQMWMyNnF4MS9ydkVUL28vamRRTXZ4?=
 =?utf-8?B?TFZDeHF3WW9DMDlBbWJFWi9FQ0hXbnZMMnB3cUc1aG1LTVFxNmplVlRTcU9U?=
 =?utf-8?B?dE40Yy9RckNHVGFjVUxlZWtmOWN2VEN0RUZ1Z0RaZElueGtHOURzZUJidkN0?=
 =?utf-8?B?RVluem1HVjhsbTNjSXc5dVB2RFdrRVBsWjR1SE4zN2RlL3VTN0NkTTZRRUMz?=
 =?utf-8?B?TGlvbkpGYWFYRWcvOVZhS3I2NThzeW9XRzJ5RUk1ODB2Uml4eEFOYitwMjJz?=
 =?utf-8?B?bGMxYjJSR0ZnOCt3clA4a0QvNVJweXIrK1FRdmVpb1VHSzVoTTNtc2tNRUlM?=
 =?utf-8?B?RHdMS2ZmTVluN2RkZ0FXTjVGS3ByMVNDa3V4MnFkcTV3TnViQ3RyeGtkc3dw?=
 =?utf-8?B?REpTNmRSQkZHVWlReWlEQTMwb2xVdmIySCtCWVpmMTVrVzRkejFVOCsxWDc3?=
 =?utf-8?B?Y0xMK0ozRWFjNFVSbm9OUDJJV250QkN3NEVvME85cVRWRHkzWG4xSGI5a3Uw?=
 =?utf-8?B?eG9JVTFHck9JYXlaYnZNWWF4UDV5TW96RXQ2NFJXOWYvM1lkTENlWTdrUVky?=
 =?utf-8?B?RFJ6UHdiU3hQSDRkQUM3UmpDeWVrVFlrMnllTG9QYmxDbDIvdDY2THNwMVhZ?=
 =?utf-8?B?ejBIYStFRHdqNFJhOENJSTU1RnhOaXI1WG93Nm5GMmJ3TVJ0dlIvNmhvK0Yv?=
 =?utf-8?B?N1dwWXduajJCSzZrbXVkVFVMVXdVSHR6ekpQQ2NUdTkvWkpnN1k2QT09?=
X-Exchange-RoutingPolicyChecked: QaXk7rAkvCkJKWCFT8E0Z+2MmBwLtKf5GFwCSUhAjHRXYyJD4PN2UKz4vnIrTkmmLhWt/FCFYmNT/jnZ9O/j4sePklwaDtmsRc2JBEJDWuupNNsjXqmbTH4l7VlMiX+u8NtCH691WMIpEStIUSVE+hMMY/ghJZOyu/Akcj0RU82X45NO/NxkWgjFBuZvayYGFpts8l1BFUzOWp6yiZiyUIr8gEJpdRipmuGA/CnP0MV9+KkR3AM+eH8YCOISFDzcmmEnS/HRH8cHQJszblLcPLkZJf2a6VRB7/QYgz7rMttbBVvkQ49O5x6sGCoFCCZ4zbNhLscQiGT36qxhU8bF4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2734fed-ffc8-41ff-80be-08dee279a0a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:01:54.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw2uYEkV1Rh3ak0x2WKenmSoVb0u8mpxdjxbmfNWZlNETGZD/s06joowL8WmFYL6V3tQ1/TT7YI6seiKVfdgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:brett@librecast.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ltp@lists.linux.it,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:oliver.sang@intel.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,librecast.net,vger.kernel.org,lists.linux.it,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9987875F29B
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "ltp.ioctl03.fail" on:

commit: 09154ff2072e36b86ba2d92d436b7f27df153ed1 ("[PATCH net v3] tun/tap &=
 vhost-net: make qdisc backpressure opt-in via IFF_BACKPRESSURE")
url: https://github.com/intel-lab-lkp/linux/commits/Simon-Schippers/tun-tap=
-vhost-net-make-qdisc-backpressure-opt-in-via-IFF_BACKPRESSURE/20260709-181=
234
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git fabb881df3=
22da25442f98d23f5fa371e3c78ec4
patch link: https://lore.kernel.org/all/20260709095511.168235-1-simon.schip=
pers@tu-dortmund.de/
patch subject: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure =
opt-in via IFF_BACKPRESSURE

in testcase: ltp
version:=20
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-03



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (=
Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607151550.5d829a99-lkp@intel.co=
m


....

=1B[1;37mgetuid03: =1B[0m=1B[1;32mpass=1B[0m  (0.028s)
=1B[1;37mioctl03: =1B[0m=1B[1;31mfail=1B[0m  (0.047s)     <-----
=1B[1;37mioctl05: =1B[0m=1B[1;32mpass=1B[0m  (0.471s)

....

Execution time: 3m 35s

Disconnecting from SUT: default

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80
Kernel:   Linux 7.2.0-rc1+ #1 SMP PREEMPT_DYNAMIC Sun Jul 12 07:25:38 CST 2=
026
Cmdline:  ip=3D::::lkp-ivb-d04::dhcp
          root=3D/dev/ram0
          RESULT_ROOT=3D/result/ltp/1HDD-ext4-syscalls-03/lkp-ivb-d04/debia=
n-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/09154ff2072e36b86ba2d92=
d436b7f27df153ed1/0
          BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/09154ff2072e36=
b86ba2d92d436b7f27df153ed1/vmlinuz-7.2.0-rc1+
          branch=3Dlinux-devel/devel-hourly-20260709-190759
          job=3D/lkp/jobs/scheduled/lkp-ivb-d04/ltp-1HDD-ext4-syscalls-03-d=
ebian-13-x86_64-20250902.cgz-09154ff2072e-20260712-19649-tc8bu6-0.yaml
          user=3Dlkp
          ARCH=3Dx86_64
          kconfig=3Dx86_64-rhel-9.4-ltp
          commit=3D09154ff2072e36b86ba2d92d436b7f27df153ed1
          intremap=3Dposted_msi
          max_uptime=3D7200
          LKP_SERVER=3Dinternal-lkp-server
          nokaslr
          selinux=3D0
          debug
          apic=3Ddebug
          sysrq_always_enabled
          rcupdate.rcu_cpu_stall_timeout=3D100
          net.ifnames=3D0
          printk.devkmsg=3Don
          panic=3D-1
          softlockup_panic=3D1
          nmi_watchdog=3Dpanic
          oops=3Dpanic
          load_ramdisk=3D2
          prompt_ramdisk=3D0
          drbd.minor_count=3D8
          systemd.log_level=3Derr
          ignore_loglevel
          console=3Dtty0
          earlyprintk=3DttyS0,115200
          console=3DttyS0,115200
          vga=3Dnormal
          rw
          keep_initrds=3D/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x86=
_64-ed2758122-1_20260711.cgz
          acpi_rsdp=3D0x000f0490
Machine:  unknown
Arch:     x86_64
RAM:      6895596 kB
Swap:     0 kB
Distro:   debian 13

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   syscalls-03
Runtime: 3m 24s
Runs:    183

Results:
    Passed:   2144
    Failed:   1
    Broken:   0
    Skipped:  222
    Warnings: 0

=1B[1;31mFailures:=1B[0m
    =E2=80=A2 ioctl03



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260715/202607151550.5d829a99-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


