Return-Path: <netdev+bounces-271848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL4gM5vIxGnO3gQAu9opvQ
	(envelope-from <netdev+bounces-271848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:48:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81732F7E1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDA00301F98A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF0CA6B;
	Thu, 26 Mar 2026 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9i0Gzzx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF31B652E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504088; cv=fail; b=GspM7KSgeabVD6L2xbyganJXioVCannMK3WHLBUkI+6/wtzFJ+xZGH+fWVxrrAYQ+H2n/2wSb1A1a4R6fh7eTfddeiFzMlT20ZOVDIKRLYOdkrsFoi4fmn213bRq3VnTKfjp7d0wjph2OaCiHOarDxlaOCk6da4XRc+BgKebTko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504088; c=relaxed/simple;
	bh=tD8kuXWf2YHcFxJROqC8pKxYoD/n2QwiWoeSKOSyz64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KB4dYfgF7+UeeI2lXroXt49Usa4+TpmS9Dzb9Qln9GByvrtHmtxWkc3W84K0EJ5eEwEnT8vd/BxiCOYnkt+8gjUyIHgHTIN3fdsws1y+5Zs7v0NxBwHN0dUNwjKuE2J+K86aFs7u3vk3r/qJdDTGChSfuE/ljuN8NvVD9kBDMAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9i0Gzzx; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774504087; x=1806040087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tD8kuXWf2YHcFxJROqC8pKxYoD/n2QwiWoeSKOSyz64=;
  b=g9i0Gzzxd2eEM2EXoHNWmKljARKB2dib4u0tbcW8Ic76dvb9yQtJKcNQ
   tFyKZPdgEZTFatIlUunzHxxz2suK8BRwdEUvwmh1pw2mfJt5z2r1mT5fC
   wQExR99Hydz429rc+bnCOSXh2ufLT2/zeySC5VtY/fUKhRedXnq83u8Yd
   y6QeJP0tVqI3YImBN0zsNnAAxfHO8Sgz/kJ0Unk62B8SwgCb7lx01XJjU
   EtQ+RSv3GhSoO21nh8kpf5mK1CSbEsvhEC0W33raICD5SQ+AExY4WmUmb
   8i3383NGYeaSpDezDSSAEwQR0xaY4+3rISjNlDhNRhdQieRUSReFEBNr7
   w==;
X-CSE-ConnectionGUID: pI6GzZb2RDC4KcQZI98iOQ==
X-CSE-MsgGUID: lbO+opXzT6iB1g7pV1oyig==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93132749"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="93132749"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 22:48:06 -0700
X-CSE-ConnectionGUID: DJ9q3WoDRfah4kyYzGlz0g==
X-CSE-MsgGUID: 7NOVffPOSxig6dwakmDA8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="225154755"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 22:48:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:48:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 22:48:05 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMBgc1w9NfB/JkarTtbqdxQ46+lvLa8Us6srWEc8gE8+E3TfsYZ+KTpKSmbtMUK56jHUNffBGxPeHkA/M+BrsAWpeG6/dig5wCyrJ/y7iViPBSiUt2IcggmRbpBoNVhrveHM/e7WZMOrZVDPzJU7l69nlU0qGx3gIcHuyFW/feSUL3YZbGAQj4huQ3JMwsngrjGll21nUar/WL6IBCgVmJPmVkn/EGZDGz8Jm8YglvKIOrs/d64chyebxe8jqv8wVPg0Q0lWRX06mXbnqEV9IsT6jJ0wpsgEsDCf6uTv89bIXjAg0cWUSImO4rTmmjqEaElvaOYUw1cx77hV2Y62oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT1gKWgABM+JOF8jOqVHcUZYbTAA1ZJlbpNeN4Mnkcw=;
 b=ILAzUOxfRstzJhYuj90QwbLXTMJ8w08jp7mttMVL7XuxWpnzJ6HWptFP/pLBjuJ+RZhPD/HytOCbwMujmxs1xLuRHiih/2eIq2n0Jpbe/hlVq5hc9/eXjTCJsSnC/7PJuECfX+O2SMhAUBpwrIJQnFFWhVWkDeMlpLyLxbIcmFtU5ftaY9xVm7FidED4SaSIAogOW7U9lxOW2BWW2mgoJo7/FHXEEoi91wjMxp3czG30aqQbMAhTm9K32SQR8fNdQ1EnzaHu+065/LkPga0DY95CntVp0k8HSU9RcRWtiuRJI4wjYy7hVC31+yOqhGuxOkT9FEafVz33LAa+XF3DRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 05:47:57 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 05:47:57 +0000
Message-ID: <4972e037-5465-4ecf-8894-e8b77f964bd2@intel.com>
Date: Thu, 26 Mar 2026 06:47:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
To: Jacob Keller <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Jiri Pirko <jiri@resnulli.us>
CC: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"horms@kernel.org" <horms@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
 <IA3PR11MB8986E7BC738215D7C5069556E549A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <fe8ba892-e8c2-49f1-b7ef-06f4acdcc946@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <fe8ba892-e8c2-49f1-b7ef-06f4acdcc946@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be4396b-8cae-4069-74be-08de8afb3b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MPqAct1nInAi4kQypwvl6XN7xIb7t2yQdFpvGp0+gMpbxUo3LBrqrth1y9KPB7o3Sxxj2fc0M7Eiofmq8kXjSVQMm0uiZ/4kbvXm18la8ILWy9GFAUajzUvFTT/ff24t3sTGZKV3DlvGUWBSbCgz1j7e8rLQnnc4wNbiZ27824RL+tdPPSvLbja3eui6sYynMvrIHWWQGUgIgjpK3SGZFt4dKT7Tmv1XUooAiHnup4T3YByRvv1DoaQ7t3G0e9zhYWlJWCmx1YcmPIp1UJoqRCeXVTzNlgkP42VNuY05FRind/4SJ7qBljT9Mb6e9OspArklbmmYz33pL0oSGijA+MkBmQhcjydcC0XJyMZnNuCfUrxx/sLzcyehr/oUs2sFADfIQ3S7ecm6w61G/BLbgSpo4QjSd04RnsPV2D8xoMiMxexs9ffrpE7mdr4pxKDKZOyvZbndEC/soxxzjlxsBO1bLASAX7k/RKoGvCom9SbDMY5zlvCytBNWieckUMjtGflBYCopQhP6zZoW3XkDdht1/gj2rhNJd/SdcjbjZRBFNGjGza2KQCbI8hIjot/DL/nRh+Z1C7aJLU3I97QzzxsPG7Qm3yFTZCBzsBhRQrqTMIRaWOG/I93msQyiGvuMYKFaHSxD/1PV2mOITHbUIre2xJc4y0gR1Znd+Ll21cSvOpIQmj7yFcAhiW/25vc56Kd+ICvFpQStX3nW7wPXHEj8OEi87F07DWFiNzksqRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktzbEh5QjJHUi9oTlZhT2lpeGY2a0ZhaVR4MW4vQlRCTExiQ0VuTTlkMms0?=
 =?utf-8?B?cFM3OGQwdGZOeGRUcnZZQXlOM0hwOElGcG00V1FGN1hySlpuYkU0L1ZnTmE0?=
 =?utf-8?B?QXVpVDNhUWU4RVZKTHlDSVNreEZVUlkwQjFNVWtmVi9BcUFzcGVJK1RsUWlH?=
 =?utf-8?B?VUNaVS9lUCthSlpQRjNjY21aWklEb2UyWWV3enFDYVc4VXJWeW9XZGZEZHJL?=
 =?utf-8?B?Qmt3Qk9oYkhVRk5JUkFRZStwa2tmVDVpQlJGUGl3bGRDbWZxS2J0VlY4QXlU?=
 =?utf-8?B?NkF3WEpCWVYyZ1ZsZUFxOGdzQ2FReGtWSFFhM3pYdnR1ZGJnM2FGWEFWblRS?=
 =?utf-8?B?a2RLQU4wMXh1OU9qY2ZUc1NSUElPRjZwZmtJWXV6cGI0RVpKcnRTemFFRXVj?=
 =?utf-8?B?SDBQSFdHN213UWZhMHI2cEVNbVZGaXg2OTBpUTczQkhDZUdiakRRajZNMm1U?=
 =?utf-8?B?Vnk1YXYyUmEreGFXd2NUUVNDOE1RZTNiSFZTa3Q5YVNHa0RqM0tIUWlnNWQx?=
 =?utf-8?B?andpQ2tNWGVudXdHdU50UUpZTk5aUmZyWnlBeTJ5eHBtS3ZIeU5FYWJDSTFX?=
 =?utf-8?B?V2xBLzcwc2dDWlptK3d2RnZTaEl2YWI1UFdhZkE4MFhRQVdHT3ZGdkNPY3dt?=
 =?utf-8?B?TEpkYTBSak5zSWQwMlFWWGwwU2IyL2x4am9rTnFlUDZkYjJJdzNXdlFBZnFu?=
 =?utf-8?B?VXlLekI5U3RQTWM0d0hyS2dIZzdyQXpJMzlsU0hlOFMxd3diUW1zRDlKamMz?=
 =?utf-8?B?RWVRcTZVWUczSnYxaFZhb2pudFZjazJ5VFRXdzdObk8zZlljcHZhNlp4eGU5?=
 =?utf-8?B?VDBabVZEM3hhVC8wQVAvTVcyYmcwemJINTUza3hNWXVzRVI5NktpRmsyUzJU?=
 =?utf-8?B?MFpjc1BPU0VGNlpOUmN6ZGNvZ01vNU1NRnpMaHFOU1pQTVJPYVZKYkRMbFJC?=
 =?utf-8?B?OTNBQUlzdzNpSTlWMzJadDRsQXBIV0ZEV0diZytZelBTZlJTMkc0dUM3ZTFx?=
 =?utf-8?B?L0FyY2FKQTBpWFgxeDZ5ZTI3NXF2eHBtelNHZllYODBRbFBRN0krd2tPdVRi?=
 =?utf-8?B?R1k0YmJSeGZaMkJNVi9jQWNhVFliYWRZMXAzRk1FeVVlR1F5ZldwNlpsQjJj?=
 =?utf-8?B?d0V0U2NxNnJ4UmVHL1RNR3NZd2t0NlU0c2NybERmRGxFdDNaR2NYd1F6T3pa?=
 =?utf-8?B?V0NQSk5nMFpVOCtkb2kzZXNMbXBzWmY1ZTNjTFpGcEErTzJWUXpkeFJNUjhW?=
 =?utf-8?B?SWhtMDBYVGlnQnZPRC9DLzkwWEx4Q21qVERGeEQ3WjdJdjc0Wk1reldLdzZV?=
 =?utf-8?B?blI4S1EwZzNFWUVlK1hHa05HTFZKc1p6OEhvTVpENUFKVzJWdFlwNU5wdEw0?=
 =?utf-8?B?aExKcEpablVhK0w1UGd4WFhsVktBTlkwUEx6OGhYZ0R0dlFVMUhSZGZUMlNT?=
 =?utf-8?B?R1V1VjV2cWJlVGM5Qk0xciswSmNVbTNuWk51ek01aWdaOHhiR3YrNjJ4Qkts?=
 =?utf-8?B?cjU5cWZCQW1Gb1hqMVh3OGFka016b0htUkNhK2lrUjVWSHdvYTZkeUptTmdz?=
 =?utf-8?B?T0JnVDRFYnQ4YTdHWkJkUk5KRks0MXFRMEo5Z3lGQllmdVhXSForbjJMVTh0?=
 =?utf-8?B?cXdZYVNKa2NqZ093alUrMmpTYmVGZ3dvTlNvYnFhMjlmRVNSSkVweTcyOWx0?=
 =?utf-8?B?OHQxN05XT3ZjczdMY1ZLSEVSaHNHdUdrVXZzVmsyc0xkU2JvWnBhNkNxdXNC?=
 =?utf-8?B?bDliS0lZZ1F1QUhqL2pFb2lRNndEWGtZbnpncUxpakxib1VWN2NVandvTEk4?=
 =?utf-8?B?MmpCNnUzdnBwc0Rwc0NqbHJTYWVlUUlTU0JJQnoyejRpZ2pKdFVCT29odmly?=
 =?utf-8?B?dVJuRXRDME54eDAyVkhuQVJYKy9HS3BtbkgvUWlFNHVzdXZ1ZXpCWmMvZmdw?=
 =?utf-8?B?Nk01UVF5YVV1eEdIRUpWS2ZOQUtQU1ZnOUU0dzd0V204R09nc1UzV0Z5TUFW?=
 =?utf-8?B?dDZ1OU81MUVpTVZ2SVFoVDcvNlEySTdiZW1QbTZCOHFveTQyWlhCKzdEa1Bi?=
 =?utf-8?B?aWZ4UEViblNMSG1SZzZrY2oyZytlNlJDWTYyLzJnVkRaWjc1VS9Wb0NrRkUy?=
 =?utf-8?B?dytvUzZjZVZ0RVRDd3paemcraEs1TkpkdU1wUjVvalhtNk1ZSVJDbjhMbmJE?=
 =?utf-8?B?ZitFcVd6Y1pDcGN1UVVYN09uUndYc1g1RndCOHFNdERDTEVtU2E2cUNoL3NN?=
 =?utf-8?B?em1oWGhhN092VkVrekt4KzZKQ0c4UW0zMnhJMllaRUlGQXlMdUU4SVFZVnJk?=
 =?utf-8?B?cHVjbnFmdGFaK1I1Mi9jZTlpdjdhaHQ5Sk1ua2RwVFJ2THlKbzdpOG1XYnBK?=
 =?utf-8?Q?SSZQ+wmp4xsOL8Nw=3D?=
X-Exchange-RoutingPolicyChecked: N97LQWHiMbJKVYNHpZJDg8M9H0oX3DkbGMSNwBv00XIKo4n3QRd8Z7DfL5clR9ZbqCjpll3oMRME6eMaamYiLv0tYFWVQtPQGW1SvDYxqfXnDzy+7jfsmtzxz2VyfkJj7ttQIyUmtGHlEKOrfkoQD7Lt/SAuJed571WomrIg52E2ok5BZqoFTa537NL6931Zvqq86i26T6OfazOJ5r6ba12wds6RItIZqECJzblbW4n9ysDsgxpuhaoQfUAb/9ZCYeVcceuhZYwvSlhva4TDp3sGtypjiQoARx9Bh0c7iojzsF8+9iMtapfu2jvJVbb3O6CXF0aRA1UtPzTo+dBY4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4396b-8cae-4069-74be-08de8afb3b64
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 05:47:57.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ox8wHJnBmT9N1jehZdNKapNJewXtTd//7KVDk8PUd0y+j3UJqEVfiiE/P++WHjIFUP3x2rHmgB0lClTF3ee9gQXTSDoObtbkYrzKA5HJVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4F81732F7E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


>>>
>>>   struct devlink *priv_to_devlink(void *priv) diff --git
>> I'm worried about priv_to_devlink(), if someone passes the result of devlink_priv(shared_dl) as priv,
>> container_of computes garbage - because the pointer came from shd->priv, NOT from &devlink->priv.
>>
> 
> There's no good way to detect that inside the priv_to_devlink either,
> since it can't know which private pointer it is looking at. Hmm.

We could achieve that by adding a marker prior to priv data, in the same
layout for both structs. I have code handy, will post v3 later to don't
spam too much (and hopefully resolve discussion on the other patch)

@Jiri, I will not add your RB, as this would be significant change

thanks a lot for reviewing so far to all of you

