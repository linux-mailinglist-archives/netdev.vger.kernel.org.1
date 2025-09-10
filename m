Return-Path: <netdev+bounces-221650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAAFB516FC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18754E1D81
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084C3164B4;
	Wed, 10 Sep 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsF3q/nw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C56319878;
	Wed, 10 Sep 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507656; cv=fail; b=eNDvtIFWBnU6eHpOBcjZdo9Zeqg8qjhBniKyHYnnSBy5MFH8Ufdg/KAJXXzk4ymv0+SGCBbK3Np7rPH91tiubVjhzqp/q4Q8SMcjGikTVDB/pyzAK4HyZ9MqfXAWpHWBN9O39FxKL7jFhgOBD2i0FrdoSv91Z6OY7EiBfeCYkds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507656; c=relaxed/simple;
	bh=JOVauC0ZEGqKrYtpt+F43LJd+Vbi8uh7BtasOOqfcD4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nOvWPKMMXfWxiWhXncn2pg+ruU6TS5NskWAbgMI5Nsbvf0mtqKnaR4/1yW/kyotSaRuIprZhs49SabHPAiK7CyQ5qaN5ZT6ALbMvusRZnqneOkd7yasGMGImjnMKJvy6VRcY7Bk94AL/8hJpT07XQGMuwwYwflXylqKvVUc8s1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsF3q/nw; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757507655; x=1789043655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JOVauC0ZEGqKrYtpt+F43LJd+Vbi8uh7BtasOOqfcD4=;
  b=IsF3q/nwhav90RAYCt7jCIfhO5GwLAGdTyjLMKI8tWpqWHNNdbYdaLdV
   9bhbgv8NQUBrEaYfOJJG8FVu5Jv5BZPQkrtx8klhYOqo/xI4tBcbnAfCo
   RMKfGHrDHtZBXCMOoGFEzhcaL63a2uKAjZX1UTBxCUInXwOIbroAedmzC
   B3yi2Ccw7n9iAvvWUm5MdOSTP4txPsGe5wAeFyj2yebbps/zhFI7/IEC2
   cRKi7V1NtcK44bld73mvgF58Rry/+kO2UX0i0juY2YaFi48zlrszx34rl
   OGskEF9yyvHtsPPhZM0GsZgH7klu1vRTS3eQO47kHdcHCtKQ433sB/Yc4
   A==;
X-CSE-ConnectionGUID: xHocZ3SZRkyLSpiKc67iOg==
X-CSE-MsgGUID: zraAqPkCTqiARUyWOspYzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59923717"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59923717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 05:34:14 -0700
X-CSE-ConnectionGUID: 1ZoNr2wZRlGNG6Qs5TeEXw==
X-CSE-MsgGUID: 9JfpD9iTR4+ogxrcXZniZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="177414412"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 05:34:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 05:34:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 05:34:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 05:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMsw7+jRwvDC90jp2XAqdPSF6AyqAh5n8G5zDGD6IaaJENwUPMWqhH+0wUT2qKl8QQ4BWaVHnACHAOmRSeIBNSODAMrmwMYrq5FDPSHsfBjeKJSw2vSJo0/7QIQog1w+PBIci6U7Lw1aP1ATLGbiLQgxuglq1ATb7U7Cbp1SUmeHB7Fs14uqHP7cDh8261t4Lx7DMAzLPEo/G0yEWJ12P+t/Ioy6hFawzRi/0Zivw5BQX6xCkULNJ3Gy3Z9ak+O5l+fgYslpJPz36odCMoLdzAq5X6QZsaLHpMjvU09im6GHdPVNdcNtgY3TB01DIAQmkPAyqYZAIOaxP95C8PlYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdq4ECldbws/ijppStPK6i+jxF6HS/qieQE6DR5KbdM=;
 b=Rz2/rSJSU173dkej0+wVudETin7zugjw9YP/eiTp/hHTtPKFqOolurpM+pUz1+l+/dqrlHiJbOa/SwJhF9TfdphorhnjneWIRSQEjNo8C+oaIyuyuBHMsOiojhHTT8WMl2AlDdSBIeRwqFBROT/ikApaLaUPCqTntS5aua7fK2+gN0rlt6z6D+0P5Xw2IxjTgs7qVGfIeI0qdpa/8xeprVkmlkP6Exs+fhGAqPxN9ftZT6hMFkyM9HaQM6tD3jGH4ep7E+xBJuUG5A2XQ6GXMjgGSMSeyJN9VlOlAS4t5u5SL5K1jI86urUrqeluPPyBo3T16OeQeTBq0HQvMtEsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB7161.namprd11.prod.outlook.com (2603:10b6:303:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 12:34:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:34:03 +0000
Message-ID: <ac8f54ce-8348-432d-8714-9643fce3faa2@intel.com>
Date: Wed, 10 Sep 2025 14:33:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: zl3073x: Allow to use custom phase measure
 averaging factor
To: Ivan Vecera <ivecera@redhat.com>
CC: <netdev@vger.kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list" <linux-kernel@vger.kernel.org>
References: <20250910103221.347108-1-ivecera@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250910103221.347108-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee529a5-4de1-4714-a878-08ddf066538f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjdBUTFCQlJuTUFqTGpVYjlqSUQ1WXNYYzdYVE45U1ZKWTBYYlRxak1vUjBN?=
 =?utf-8?B?RkI0Si9OUXZiZ2h5cXN0eWhsVm9Xd3ZUY3J6VGFlcVc3N3pXcjdhWHF1R0Zp?=
 =?utf-8?B?N1gyZjJCNUlIOHlGTDVDeldOdmRwc3J4eXZQZXJhWkZGQnBSVHdpWUtrekJ2?=
 =?utf-8?B?NmIxVitZNEdRRzl3anY5b2hWTXNZcjJJRHhQcHprNVM4aVVBUHRSRjFJczcx?=
 =?utf-8?B?L0lLcys0aHd3SDZZaWRvWVQ4Qkx3M3NBNGNOQ3N1Y0QvMGI1bjI3R2xjaUlE?=
 =?utf-8?B?aTVueHZnZmJ6Yk1IMHBhLzR2K0lZVC9aZzYvbnRGT2JxM2JKdU44aXZxOUVH?=
 =?utf-8?B?UEFnMGNrMjk0enBUZFlyLzcxNDR2U0o1V2JTVkxPRkJsakFVRmxXUHpkTmFY?=
 =?utf-8?B?YnR5bW8xQkM4WnB4Nmg3M0V6NUJLbTR5Uno2RGs3SjNxM3ZTYzNGVXlvS0xF?=
 =?utf-8?B?NVRML0d5am5aSzQvSENmdGd0b2h0UGdnOFNJaEluWXNRUlVIa2VUWnF0WEZE?=
 =?utf-8?B?aHRmaG4xNFNoL3BqRTY3ZmFOY2RpUDlaMGowWGpLbmg2RVk4QUtnaGFqZlpl?=
 =?utf-8?B?K3lsemJNRWlYOTRnREZBQ2VUOGJsb0cxU3lmUlZ1a1VHR0pwWHFWVUhwMUwy?=
 =?utf-8?B?UUU3UWVUalN2RXpqemd5am13NlY1QmxCUXM4TE5HeUwyYXVSKzNScHhFNDNC?=
 =?utf-8?B?Sjcyb1BIVlU5WGN2V3FRdVB0eDkrVEIrUDY0TzhrS3ByVmRKOS9YQ3dTcEZp?=
 =?utf-8?B?ekFjSE5DN2N1MDY5Qkt1SXNHZWNqRXAyMjQwVm9BYUVYWEVPUitTOEEzNG1m?=
 =?utf-8?B?UmtDNXVjaVo3L1dsa0xrekkzYTR0Mmk3enZTMXZpaXE1Rmw0SENDSUdSNk55?=
 =?utf-8?B?YXhPS2hxcVhvNmlkdVZLcDFrbzRUazdsWmhobGQ5MjBaM2REQjVLK0c1aVM3?=
 =?utf-8?B?RitwaXRFVTAvNVgrZkZ6eEJoQVhYSmtLcW1ZcWRDTU53SkRGWlYvcXIwV09u?=
 =?utf-8?B?dVVoSlgzalBRb3dHMktlMUhoRHljb3FBWXM4U3BrZFZWRllNU3RKNmc2THpK?=
 =?utf-8?B?eXVmSDBDVXBvQS8wd1BoN0R4NGhzOHpuTDJmUUVMOTNocUt4WGtoOWpGZFNG?=
 =?utf-8?B?Q2NYcHR2ZWhpKzJYZFFzak1TK21YYlUwQkNwazdWUTVuTnRuaHhwSzBueVF4?=
 =?utf-8?B?K0VoQW9oSEZIdHg5OVJnNnJTVHludVM3Qy9GMFp1YW1YSHdCV3JUZHdkTzJ0?=
 =?utf-8?B?OFRRWmZodGQ2aXVzd2tlZVIwWmhoQnNUM2hML0RLVDc2ZXFrR0w4RlZPYVQr?=
 =?utf-8?B?aWRCSHpsYWhBQS8xdUc5ZHBJVVFiMkk4WWhqK2sweVdVZFZRbkVlbGlLZEpG?=
 =?utf-8?B?MkxiSlhGMUhpNk9pVHFVOWE5WUlsNDY0N2FKTlNIWWZpQVZBV1VzOWN5LzE0?=
 =?utf-8?B?enY5alNTT2NteTJLMXN0aG1YN1JZbWo5WjhoRVQzNFBBanQ2WUtrZVFKZG5Z?=
 =?utf-8?B?RXpLb2MxeG93RklHZWtmajZVaVVydERERjBlbEhJWW9aZk0xa2FRS1JpaFhs?=
 =?utf-8?B?SDIyNS9oQ1RJd3p5SktwWFV3ZzBVVlcySGV0YWZJZXN6elpFMFhBN0YveW8x?=
 =?utf-8?B?R2pNWW5pYkF5YmNrcHZhb0MrekgvaEt2WFB2ZWNZbXl3OU45MitJQjZHdXFY?=
 =?utf-8?B?VjhPbXozaFdQU3d5aXZqWk00TEQyQzNRMGk0MGF3b0JRR2lPcVkwNG1HM3pJ?=
 =?utf-8?B?ZXMwZUFkTHNZQ3FjREJsUTQzQkdTQVJMQ0ZxNXNweXhma0VtM0tjUzJJR3Er?=
 =?utf-8?B?UFRFMnZrYURhakZtWGVoNkFtTFRYT1pTUG9YNGtLUTV0eXRLNzhqdjlwUnE1?=
 =?utf-8?B?dGdhZlZvcWR4Mmo0ZVlPbUJCVnVSeFhZMWFrTFJ6akQ3VVpHZWdXUnZaN3hx?=
 =?utf-8?Q?LvCFYpuldTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpKK05SSjk2UDN2TjUvaDg5RHdtdUxFbGlrZ3dabmZ4NGU3a2g0dmJrNklW?=
 =?utf-8?B?WjJGdFZsWGJCSFEyNk9XWGNNTE9QWUxoSnRsck1JaUhrK2t2NWlDODZBbm9i?=
 =?utf-8?B?amFnWDFlVDhWZ0trL1hNckROZFBTWi9IL2RIYzZkb09FZzBVdVRIdld3MnNn?=
 =?utf-8?B?VEsxVlNpQUFtQVZmQzhKTnVpT0JxN2dKVzFrRDFsRlNxRUNLRU9LdUZ0Ump1?=
 =?utf-8?B?Y0JFL1JvTFAva3doVW9VMCtFeHNORkY2STdHQURmc1BWKzBEclZsaXZHMVlO?=
 =?utf-8?B?RkprTWtKWG1tdzV6Z0hVbmc3YnVyRmlPZVJjVmlGSjlNaEg2Z0hHUFhVVjBh?=
 =?utf-8?B?RkVoSS84OHRCUG52MTdsYThQN2p0VGNJVUlKTXdBUmc1TDBYSFpwbE9kblhr?=
 =?utf-8?B?clN0a2E4eGRsZXUydHVWMmJtb0xrcGNvUVB6UHdRWjZ0dFpyMmM0OFN2bG5N?=
 =?utf-8?B?ZEJRY05mVGRUc21Xa25OemcvZEdSNy9hRWRQUVBGY2Z1YkdCZ0FIR2hQbUtN?=
 =?utf-8?B?VnRuZ0dRNlpoV3hsckswTks0NDRwQTZYSFFueUVOM2k1TDNUT2g5Mi9IOXFq?=
 =?utf-8?B?Z2dvWnlHWllUMXhZLzg1TFJsL25jTnhKM25NSXFnYnMrSDJac1BXdGRnVk5q?=
 =?utf-8?B?RW4vYlRzWDRFbUp2YmJnbk5TQjlicnJYclBCa2kvVEZFa2l6cnBRMWtwaE0y?=
 =?utf-8?B?cDdManVrRFhjL3FtWCthb3ZGY2Z4dFFHb2JXeVY4c3ErRjg1eVB5YlluOG1P?=
 =?utf-8?B?QS9KN1pBeHUyQlNMVWM0ZTI2alNDRHR5VURiZ1craUpTeU56cUxYTjVZQ0xP?=
 =?utf-8?B?RGdGcXdhSHpuWXNudTNicGQzOHVYdHZTQlN6MEFXY1lHL296b043TFZZeE1m?=
 =?utf-8?B?bExUNDdvejlucmlpbUt0Mml2dDl3QkRIS3QxUVlpTkRnRWNBUWJwM3F6eXVz?=
 =?utf-8?B?M3p4SUh6Yk9ZbndDSnZ6Sm1WS2sraUo2KzlGNkMzTTU1MGM4L0liSWQ4UGU0?=
 =?utf-8?B?TnJTNEhEUSs0QVBXUlBrYWFuL2Z2bGl5TlM1WGZNNVFPTVpzL1pnRGZ2SXJG?=
 =?utf-8?B?Sk1IbTI0OEx6SHdlT0ZIeDlZZVdiNlNFMjZ1ZnRzd20wcDNKNmJrUkh3dTZw?=
 =?utf-8?B?NS9oVnZNTk9UN09GNlpjcllkeEVlWmorK01HcVhVOXIzeDQyWG9HRThTUWxt?=
 =?utf-8?B?NkxjRTNXcUgrcVpzbWxXcDQ4cXd5SDMwamF0ZGY4WHA3ZzlHcHB5VzJOZDQz?=
 =?utf-8?B?MnZMUE4zMitUVXMwOEE3cTRTVW1hUzVqY01kNFpINURtNkRxd29BMFB2VVFV?=
 =?utf-8?B?TnprYmM1bjNsbXZIa2dicTBBakdWMWNtYUF4VVhabURaRmNGSE83QTFGbVBK?=
 =?utf-8?B?bEZUUHlreXpXWWNUdnBZYXNvT3dRS1Bxa2IvbDRrSElPLzVRMXpjaTdGNS85?=
 =?utf-8?B?VDd2ZitZbGdhTWx2VWtPTmpMQkpHL1dmWjlTNUNVN0tTNzJ2dFNoT2lWNTAz?=
 =?utf-8?B?dXN3cEhxaVdDd2dENVQ4U1NxZVJFdUkrR1I2dXpobkd5bDY3UlZYMWZ3YWMz?=
 =?utf-8?B?b2xmS3lwdkxjc1FzbGRjbGhyUTAzdVJ3TWxUWGlNbEkwZXE5TXVXZUV3YXFV?=
 =?utf-8?B?Z0ZrK2lvUm16bjFyQmtaZm9ZWkNZQk9HY1ZFWUxzQnArTnlveWIrKytQeWh6?=
 =?utf-8?B?UzJMTmRRcnE5MzNlMG5OcCtxZkpWTm52YmY0UW9ranFFZzAxWEZEaFpmSXNu?=
 =?utf-8?B?SHRJNk11VmtCK2pzVlBwRlNPUFJaTWVoL3cyQkIrV0YzdmZuWUF2TkxsNy90?=
 =?utf-8?B?RTBkRWc1ZDVmcy8xQXNOaVFmMXRyYXZUQlFhM3NzTVdNL2h3WTlLZ2padmls?=
 =?utf-8?B?aythc3dpWk1zYVpFWUhlK21QMVV4M0N3M1ZHcFNJcG44M0hnazV5U21YRTU0?=
 =?utf-8?B?UEhzaGc3MzBaL1VudDluUlR6Tkw5emRXalJKcjdFb3lYT1FKKzAvSlFIOTZY?=
 =?utf-8?B?c29jSTFDREVyNFF3bm5vaEJoS3o0TWwzZE1ENzNmVW9KQzl2LzRYTm0xQzZU?=
 =?utf-8?B?NFlvVkcrTGNaNkZENDJoNTVpdjROMGtvbDMrd0ZCZWRHSElHSytXTWNRL3lB?=
 =?utf-8?B?OUFpY1d0aTh6MXY4ZUsxRE1VUEhvbGNRM2JwSkFrbHNCemx2V3ZSa05VaHNo?=
 =?utf-8?Q?arA0Z2ahoLMWgPLZjUuy/yw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee529a5-4de1-4714-a878-08ddf066538f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 12:34:03.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhLIadh+w5RSPyPeG0wqvEcBBwAgWaX4bzrf9P3jAlMj32NzvMRs7jpFteHyLEakPO7wUC6mdFlSVFMBlNEumaAycVhtnjtw5gwx7RKUCk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7161
X-OriginatorOrg: intel.com

On 9/10/25 12:32, Ivan Vecera wrote:
> The DPLL phase measurement block uses an exponential moving average,
> calculated using the following equation:
> 
>                         2^N - 1                1
> curr_avg = prev_avg * --------- + new_val * -----
>                           2^N                 2^N
> 
> Where curr_avg is phase offset reported by the firmware to the driver,
> prev_avg is previous averaged value and new_val is currently measured
> value for particular reference.
> 
> New measurements are taken approximately 40 Hz or at the frequency of
> the reference (whichever is lower).
> 
> The driver currently uses the averaging factor N=2 which prioritizes
> a fast response time to track dynamic changes in the phase. But for
> applications requiring a very stable and precise reading of the average
> phase offset, and where rapid changes are not expected, a higher factor
> would be appropriate.
> 
> Add devlink device parameter phase_offset_avg_factor to allow a user
> set tune the averaging factor via devlink interface.
> 
> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   Documentation/networking/devlink/zl3073x.rst |  4 ++
>   drivers/dpll/zl3073x/core.c                  |  6 +-
>   drivers/dpll/zl3073x/core.h                  |  8 ++-
>   drivers/dpll/zl3073x/devlink.c               | 67 ++++++++++++++++++++
>   4 files changed, 82 insertions(+), 3 deletions(-)
> 

looks good,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> +static int
> +zl3073x_devlink_param_phase_avg_factor_validate(struct devlink *devlink, u32 id,
> +						union devlink_param_value val,
> +						struct netlink_ext_ack *extack)
> +{
> +	return (val.vu8 < 16) ? 0 : -EINVAL;

nit: redundant params, not worth respining



