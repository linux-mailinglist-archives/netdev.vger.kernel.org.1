Return-Path: <netdev+bounces-132091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412C9905E9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3A7B20C6C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8C215F49;
	Fri,  4 Oct 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQk4swDR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCB1B7E9;
	Fri,  4 Oct 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051790; cv=fail; b=Idz0FRrIoWRJsWm5wiNdePYA+eqCgpE62j6HKFYC4EHXGfvHa6P6Rvo00STt0TVyTCsftco5bkyqoM/OsUB0wXtetzD232gY/5kdtS3AlI6rmtteSC696Bvd4GEfiYG32sgYR+NIM6bjdbOWmtt3mknPGKJQwNUHZmC/a3rSg0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051790; c=relaxed/simple;
	bh=MLkhh+EPEZJ5mYvmVbtrMjnAXdvnGEw9UaJLIKS8WUc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQD/AfQOu58mY320R4MSa6eUyL1JMtvAGsdaDTPDjfR4AgA7ZPnmuqQ8qKe++a930iRlBZ+Z9OmDBn9Cv2B34/HSnxU9FNSgrqjC43EIMPG7vpWVEA7n/Xu3tIt/i8EOZ5NErJpKMu0Np7Ea36ozvk5SLkk4GtBdlh5cck2vw5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQk4swDR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728051788; x=1759587788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MLkhh+EPEZJ5mYvmVbtrMjnAXdvnGEw9UaJLIKS8WUc=;
  b=HQk4swDRRhw0zJz3q+DClO4w3k+B6Q5AMFzmCdgGpVxrQXHtgP+4TVFZ
   t2oZXRTGXAbBj+Fgba2KcQpf4InFV6/yqO7kbjakCrnqHOcoWejsKvZWc
   kVR4du41h3e6LJiDwALmXmqwkMvw8j6lPvo9EoRD1XYmwfKk+JypKoz3c
   jpc7QJJAsOB6mUglrVQ/w67VFEJUP1dDgPcgE+Cy4RkhYsLCaS1HO4/sv
   wIROlPewlC9iqyE1wjmpsyvIqo94jCLjIb0g77h/2+BJQhraBC2DGfKS8
   BUR3IooBaBlFQlFMT34EW+yoJK5IInRjnl2yfdDSrJB7SP5e0t5XmVnBS
   Q==;
X-CSE-ConnectionGUID: EsS1bHkmQVGWaEeRDJO+vQ==
X-CSE-MsgGUID: 4X94p8juRR6a8/RUxftIIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26782815"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="26782815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:23:07 -0700
X-CSE-ConnectionGUID: btWXKm8XR16gToLFUV4Ijg==
X-CSE-MsgGUID: mOF8dg+OTdqLsyKXRuOBpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79148655"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 07:23:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 07:23:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 07:23:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 07:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY7rdtGiMxzHKIRxuAXQDqEI4EUkJRtWroYkQJtRftw3r4qng20u6scNfn05eRMnEuh9+vJwRdHN0ZiEXr/Z2+QAm86Km1T2GsA9pu63POuK1EC8ZYQUa7dI+k9qzgMZZvZHPDPDWZ3H+diC7U3qNZjnjZ56b6KZNwqVxCe/EDZsGWUNanWmDp9NEY3H6e3N3ETaOSw0gJQ7FkSAOOZ1lR4/vTNuFApEVoACkCZjRUJaW0wEau9tm7vI1STsYmdHVvP/lqVV9VzPGVb2OGZWRUNrAsERroZJVzgvqaa2M89tW/jOY9RaqRy0t8XCnSZ4aQO1OFN3QxuADynbW1wvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF25a7QFmo+o8UqiHq+7OSxBYZPWbEmGDkcJly/Rej4=;
 b=DSxYNe7kvCC2uP3azNmyJYYKUwhkBqi1vKkXvCKDaHlb5vev8dAQSgJCnV8UL1mtT9fOLSozUtnP+PDKDtPPC8qX/5Cgt4SlTBu3a2m1PYMBuLA5CAhztgYFQIvCGX+m/hq7p8FbceLrU3Zs/kWN9zrAv7VpQ8u5ioZuxrcAau1zgxpnKhUgi7Hwh59ijxmkCGtq8cXrTrCa8V4mxV6yYKeoVzMy3u338JZ66SEI9cj1mN3IrAr9eDm4BbcEbpOyaEl7r49oFSRcbzZlkw8OGYmZFwvOUeraiSAWPKhOQPVwC41Waf2+dLDPUZ1avXgPbFNzEWHA6Sv/JpmWXszt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 14:23:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:23:02 +0000
Message-ID: <a2e5f614-5540-46a5-8438-23d6eea663fe@intel.com>
Date: Fri, 4 Oct 2024 16:22:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3] idpf: Don't hard code napi_struct size
To: Joe Damato <jdamato@fastly.com>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<horms@kernel.org>, <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20241004105407.73585-1-jdamato@fastly.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241004105407.73585-1-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee525b2-2fc7-4838-6c4f-08dce4800e40
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWRLOExBeTU5ekg5VythL1llQXFBYTRuNmJCUUhyY1JNNndhdUJRbkE4WkVm?=
 =?utf-8?B?cFV2MWpsaEVoWUtBMlRyNXJqODdNZ1B5NWFjdk1KM2ZwVDVEUUtMUmg3dmE3?=
 =?utf-8?B?MnJuWm5ZSkgxZ1hGcmgyMjN1Nk1PYU5rNjh1K3VUVXppc1dpTnN2ZGE3R3VL?=
 =?utf-8?B?ekxGZ0xKSnBtRTBMeSsySkg5UVVoV2dRbW5vUG1aY2pBam9laEsrRTREcno3?=
 =?utf-8?B?NGNPVk9RSUJ5eFhyRWhWK0srQ2N2WXVOdFhud1laUG9mVmZmSFVQaDE4Qkly?=
 =?utf-8?B?Rko3YWhudXFDd3ZFYkt0NlppZCtRcEcrZDlsbFg1ZnBiRU1hbmcxNjFUR2l1?=
 =?utf-8?B?ZkkvaHpiTS91Sko2aTA4eDMwU2IxSGlldnNsa0h5cmxiZFFqWGVERW11aEF4?=
 =?utf-8?B?WHBKdlkrTlAvYS9ycDlYc1RxWU9ZQ1NwV0d2TGYwMFkwK0hrK2JSbVBZL2J5?=
 =?utf-8?B?ejZ2aEhJTUExZi9CWVNmbE9kaXVWOHJhRzkxWnNJYWZrMGtMa1VvUzY2WC90?=
 =?utf-8?B?UFJsNS90Q3RQZVZ5NlR6MjZhbTI0SlMvblQyTGNxRzVmemw2MTVlTW1FMkZW?=
 =?utf-8?B?WkRZNDJUTDk4U3NGc3EwR0diSUpYelE5VW9aVXAxc1A4TVNNK1NDeGhXTzFJ?=
 =?utf-8?B?WUw3aFZ2elFIVFIxSHV3a1lRZVRGT24zdmtsVGZFSkxNSXNsTDA2UWhkVkty?=
 =?utf-8?B?M0ZvWXJTcDJ4S0xKK2xpMEk3c3NIUDVOdnl0SW9vcDRYNkRzM1FFbUdLWTZ1?=
 =?utf-8?B?MitIZ1VJZktoMWFaSGVuOS9QZVQ5NTYyS2xvd3BFcFFQa1NKbXkvWnp5R3F5?=
 =?utf-8?B?amZ0R3A5ckZ6RFhhaWUzUi9TS0lGeE84NXFzTkpxZVpjbk1hNTJuOE9sMnI0?=
 =?utf-8?B?clE0Y2xvQ2xxT0ora2ZMUEhCYmZFYmp5Ty9ZSStxTVZmUU45NEhneTkrMkRG?=
 =?utf-8?B?TkFDVERQTUFaRmZyUTg5amZxbk5HSlYwNjNUVThFTDh1eEJnZGN2ZnlxcHAx?=
 =?utf-8?B?Ri9lanhCNU5SRSswbCtyazkveU9qQURTckNUbno1Wkt2cjFSMzk4cGVxZ3VO?=
 =?utf-8?B?UkZRY1NTSHYzdExHNFg3R3VLL0ZuRzllNmc2ZFBsdHpKVDE1NUFnWTF6YTVY?=
 =?utf-8?B?TXRKVHh3cEswQ2dyUHVGS2JBTm5scWs5Y2dHMlJuMTVEWHNJaEF2TWlkUGNz?=
 =?utf-8?B?RGdKOU9lMTBLWlU4RFl3T0F1SWo0OGdGZkNocm82OHIrQmRuSGtCYVFqVlhK?=
 =?utf-8?B?WVVmVDlrbHhrVzdCRVBvZCtUU1ROZ2dzOTkyTGNUQ3pTWXR0bk5RdmRrUmpC?=
 =?utf-8?B?d0UvdjlSc1lkSnRSZnhkWlJoZ3RTTERKZ2tQSXFVU3RRbHAzNkFZaFROZGhy?=
 =?utf-8?B?SFZtNDBpL3I4cHNlb0lnVzUrbC9sNGNPeWFnK0VxNVlhSVRTRk9FVVVma0xi?=
 =?utf-8?B?UmxOUHJ3SE14OTN1d2Vnb0NnSSt3bFZvTWpDWUdoZVUvZ2x1SktONWlxWmNv?=
 =?utf-8?B?a1BaMUw0NkhhRUpqeE9rb0N2c2o4a25NZ2VGNEhTekVUbU15U25DL0toMUxp?=
 =?utf-8?B?TjJ4OUVMczhHbGZGWk1JUHpoWk03bVo0cWxPb2lLVUhZeklEdHkwQmNuY3Zy?=
 =?utf-8?B?a3VGS0prZnhUMVp4eTRwZE1kL3FIcTdUUW1nWmhmOU5wNldKNG1pYkVabndw?=
 =?utf-8?B?M0ZuV09yNldhMjBiUmhaeTFuRU5lOVJDT0VNYlJkSVk1SGFuOTJmN1VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBuTFc0VmhaQXlINWptSEtoOTJvWGQ0N2ZjdUhJdnpPZStEQUR6bHBiQ2Vo?=
 =?utf-8?B?NUg3ZytJK0U5MDVYNWdPRkZqK05wa05Yd0Fia2pDQjRpVHoyTUN5dzl5RnBu?=
 =?utf-8?B?KzkyRWZUK2tTQUxOUEhNUkNtbHZLVEJ1K2xCOXpGMU5iU1oxWDZkRURVTUhQ?=
 =?utf-8?B?TGNvMGd6WEtrVzg5TlVDWGR2NmxFQTQyZ1k5VWwxQnNFMHFuK3cxaUlDS1N5?=
 =?utf-8?B?RHIzR2NidDk1bWVXUGg1aHB1TXl6MUUxc1lLTE5nTEV3eWh2N0I3QnJScG44?=
 =?utf-8?B?RlR3RGFJQ1lZRkVoMEI2OFY1YjJWV0tVdXhjVVB3UXEyYmdoTEFGaVVqbWdo?=
 =?utf-8?B?UXJvSDVSOENMeFZtMkx3QlNIMUpCVGtUUlBKZnZvMDNFbVdZM3ZFTXFodnhG?=
 =?utf-8?B?SlVNT2VtOWFkQ04ydmVSRFM3VWJVQUxrK1lTVFhIeFRxSW1vVEsyd3M0VXFW?=
 =?utf-8?B?SVpTVlZhNjdtdkNKTlV3VkVoMFlDVHhNaEM3L2JnTThIVDRtQkFXYWxscmpB?=
 =?utf-8?B?eWs1Q1N5NmdMbC9IUk1uOU1DTzJyMU1FbzUwelAveEZXYlNibXFyNHlHb0l5?=
 =?utf-8?B?N2ZXQlNBZ0FQejdZQXFsWlVzbFNyU2JDU045VzVwNGNENXVmRURTQTNMU0lq?=
 =?utf-8?B?emZYeEthazNBdVJyRXoyOWZ1RXJ6c2FhU2I5NmlYbzFmVHd2aCtvZ0lrQm9w?=
 =?utf-8?B?Rk5XU0E1NHl1N2xWRWdjUVNjb2YyQmczM1lJTlVlVXVmZWdWT1ZOT2VLNEl5?=
 =?utf-8?B?REhWcUFmdnkyZGdRRHphb0hpbCtWbTNvUWxOMjN5YUtXZ2JkQ2ZJeXplWmd6?=
 =?utf-8?B?K1M3UHpiYkNzQks5bzVKdmh1TGZUL3J3ZWU0S0JuYy9OQkZ1TkNPWmJLOCsw?=
 =?utf-8?B?cEJvK0xPdlQyMlNaRDZqWHZCY3JGMkpxQzExNWU3c0hFUDg4U05nTElhM3do?=
 =?utf-8?B?dWVqWmoyWlFBTWo4RysrQ240d3VCUG9kdVhPRFdEQTlrT01DenBmTVhhNzBu?=
 =?utf-8?B?c3cyUDZtZEEvaGdjaVBRSTR3WEpQcVpzYi9EcU5hRTNvNU5FblhGMEhURmdp?=
 =?utf-8?B?YmRRZWY4TzJVZmFkT3dUa1MvRGxERmQ2Y2F5dGlMeFVDU0E3SllrdTJOSnU1?=
 =?utf-8?B?MUd2b2ZOUmxHOTBjM3VkbFlya1FlSjBURTF2VHVLMENROG9peGZCekJtYW1R?=
 =?utf-8?B?VTVyTEJJS3Zpa2FCMVJtM3pmeFg2MDZxb1ZmYXQ4WjVQWDBLV0NITVkvNVJO?=
 =?utf-8?B?NUo2QlZJdEhLR2NzS3lpMkZxNHFwdWkreGVHZmpUc2hQYm1uYzkzZjRLTXJw?=
 =?utf-8?B?aTVvUjFwSlU5bnIxZFRveWZyVTJPc1FYSnZHYjViOUpkVlJoM0MwbiszSGtB?=
 =?utf-8?B?dUtGRnRUa0FVbjBoQ3lIdGMveUEvbTFQNlBva0NYVXJsTW1OUHRjWTVVbUh2?=
 =?utf-8?B?b1VBSldiUlFtSTlkN0VUTWlKdWdPei9jVHp3dzdZUW5DOHVzeGxiSzlWNTlj?=
 =?utf-8?B?Uk9MbmRHeEx3Zm8wNUd0aW56ZzlXbitYMnNUT2ZEUW1OY3ljNTI5ZzRhRTJE?=
 =?utf-8?B?UW1GOGZJcjNBayt1YWFhcncwMmJGTk9VYWQvTG1LVlBQclpJUVZ2amd1R0JC?=
 =?utf-8?B?bXRBdGpSNmVzeGFqLzdCRCtsNUFoZC9jSlNtQjB5QTczMVpWNjVTakFpWits?=
 =?utf-8?B?VDRENjk4cmdMY0N1VFdQNkFlWmdwZWtDaHpUVWk3SVltRytTdjJUUHJGRkhj?=
 =?utf-8?B?SjlqN0hFUmdySDNTaEovUG1pcU15SXF2dGxNM2gyZFlpOVM2bTRmYUxIeGxJ?=
 =?utf-8?B?bXY4cSt1NW9CY3FrbmlRU1NJYytNblp0dnB0clJVdmpUd2Zqaml3QWZBZCs4?=
 =?utf-8?B?OGtWcVNMRThXOHJLYVpiTjFRSWt5Y0VhZ29URWw2MmhmcktZZFBQVkkvcFJN?=
 =?utf-8?B?MG44bTFSc0F5RDlzRkVoL2kzLzAra2JHTzRXTFNHS1pLQXFXVitkVG5OMEx1?=
 =?utf-8?B?SzZ3WjhlR1F6SEc5cDdVS3ZEWVhETkRjN2IwNWtiNjlGTW9uWVVaZmhSRFZU?=
 =?utf-8?B?SmJodzhST1JDNUlTR1hXNmsweHovdlE4b1AySU0vSG16L3U4Mm5DQ1F1Z0pL?=
 =?utf-8?B?WFlLTkFkZGVHSHBUd2s2cUpEWW04dUJDaEZrQUFiKzRrRTBmQk9DWm9CUjRU?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee525b2-2fc7-4838-6c4f-08dce4800e40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:23:02.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMP6gpVDh5XHmQpHO3i3kDDxmZ/PSdieK3mVQqPr/iwCz12XuowqWSoC0/Y4sFscUcim36jBXffp0wnC7S55+Hany82RVySrhc0ea06qW94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com

From: Joe Damato <jdamato@fastly.com>
Date: Fri,  4 Oct 2024 10:54:07 +0000

> The sizeof(struct napi_struct) can change. Don't hardcode the size to
> 400 bytes and instead use "sizeof(struct napi_struct)".
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

I'm sorry that I complicated things a bit with those assertions =\

> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index f0537826f840..9c1fe84108ed 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -438,7 +438,8 @@ struct idpf_q_vector {
>  	__cacheline_group_end_aligned(cold);
>  };
>  libeth_cacheline_set_assert(struct idpf_q_vector, 112,
> -			    424 + 2 * sizeof(struct dim),
> +			    24 + sizeof(struct napi_struct) +
> +			    2 * sizeof(struct dim),
>  			    8 + sizeof(cpumask_var_t));
>  
>  struct idpf_rx_queue_stats {

Thanks,
Olek

