Return-Path: <netdev+bounces-108415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB05923BD0
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF881F216D2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F2156F33;
	Tue,  2 Jul 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgkuyJKt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCC51004;
	Tue,  2 Jul 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917453; cv=fail; b=p2r5R1RZBAab+ciaIXJxANoGR16qS6vFujAvG27K7QbHx+5HgUBLPR2UyxhIgkLJZRkqZKFhC8V/BaDyvIdHnJ821w3ihJfpNAPenJG+Pp39gbklLhTlUDQ0L1IikxCpDlPTfnSu310vwhQXCRI6677o6KFqWf/RQVD2bcdNsiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917453; c=relaxed/simple;
	bh=MN9HHMYwB4BTGu/iKHfGlqJjwDGf4NhZZykqEYaqHBY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDglXvqeNXWM1nYD44sIOFMCB6flBkryCA67WGU6crd5WslL3O0p2o5PROeM1LRu3x06GUhGC2pjJzTpoYyddW8PpOZ+oJGjzpVjb+ZKuTYS4qHNLYgzCL5i3WNzErVQd+ThlJlrLDuDbSsNAwtCE+im+6eKIEdM5wiJ+5vIw8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgkuyJKt; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719917452; x=1751453452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MN9HHMYwB4BTGu/iKHfGlqJjwDGf4NhZZykqEYaqHBY=;
  b=XgkuyJKtcPu+Tssz54wMMaW4LeieKunWelAwL3Y3g/o4NMbC2Q3wOOzo
   0kfYiDpC+f9gDHCfpX+3lyTkvUJq9WU+RZ5iqXEV51tILeN/A++2TaIy3
   pnz7OVve7IfbGt3QQ3PwMIUkNUKHzCm5s4oxiryThZ/9wC8exRQ82HcKs
   +cG3kKd1/6rBo2/o/jDG2yXOCRko8QfGLHW8IaGM7kl5f6gmfwzH60OnE
   0tiZ+VIP0tqPB8wuI00loUBdMzVvWFw7H8zy58PZxfq0Sq5G9xFmcU44I
   OJN7tIDCPSifGtIC1/APHZHTDxxuEzd/WSC06aMApecoN1nIIXNg60r4C
   A==;
X-CSE-ConnectionGUID: XyoBv8I+RdCFG1I4cPyZ4Q==
X-CSE-MsgGUID: fECfCdhXS2urARldYLVU1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28216710"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28216710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 03:50:52 -0700
X-CSE-ConnectionGUID: tKPO2WTsTl+sEmB4erWHTA==
X-CSE-MsgGUID: hppKYLWtQz6FMYwA+b+NRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45655544"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 03:50:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 03:50:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 03:50:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 03:50:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 03:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI2Jr43MaUOtpgTCcv64wIp6GxsgLo6Zpou1/nW+SglAuyRPuQ3u2hnHUOk9mum7I+azc/KrcvHWtl2isJvRxBYk7m0s0DfxGA7OrX8BaWEm9aGKWYE5fsvaPr1IHp+d7//fqnyYRDlV2yDKLn0iwokh2Kp1Xcn0seK/Ka/gMht+SNsBKBT1krq5lFKm/eQzA9WCFt9UuDmWiAdXvl2nHqO7/Gp9tjq4DaIoWLriACAPlV82kwuwh8I6vQnt9tK0HeHwMWAfpFsOSFKDirP16wEnGZfSX3M+8cKqB3Sj990f2KlwyTVkRP+pAGM7QbyLTFOriLmy8nDl3D5ObKflFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwBL9KvizV0qBzvgd2YgNIEc8FrFMaNKueZ9F2RPz9w=;
 b=i33Eb7ntyBiryCl7VZO9MMnKRFIFrNVvwVvOFe/9P4iXrjD5M7y2XnV71O46nLxio3tStaE5jsBvenpCvNK8KQFfTaFro1eDqW/7r3c+I2l8HFzQffdpYMWgvmj8Usa8X1lHhhWVcUG4aJXL3VEFaoPc+xIpZlcqTDTPIW8VllcFk0JXzKLetDycxc5nLxnX1RsSILxPc2qt4rsMPosNSnMaS+md1B5jZq0homXK7qVr4xnqY4TrxxsfrV1brg9ryZqT14P3GmT6tVFyiXu4bcJRsWvsb/1X9UfdKlWaWLSmLcSiQ+nCNOjKilRCLprqse0bbN6dYiJOJa5Fw2TLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 10:50:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 10:50:47 +0000
Message-ID: <c631fc5e-1cc6-467a-963a-69ef03c20f40@intel.com>
Date: Tue, 2 Jul 2024 12:50:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mlxsw: core_linecards: Fix double memory deallocation
 in case of invalid INI file
To: Aleksandr Mishin <amishin@t-argos.ru>, Jiri Pirko <jiri@resnulli.us>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240702103352.15315-1-amishin@t-argos.ru>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240702103352.15315-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: a9642c40-ed4a-407e-0dcd-08dc9a84d4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHFpRVRtZVlvYVZSVWdnL0J5a3RLcjBLU0JnR2pLUkU0UEJhY3lWSEtyd0Nq?=
 =?utf-8?B?ZytPb05XdWxOUWsxZlM3elErTVZlL290aytXZmVYaGp1bXlJc0lhN2M3MTJH?=
 =?utf-8?B?SitXZE1tVFVMSVBiSU5ZTWFIVTdQbnZGZ09QcVBlQ0R1SWoxKzlCL1lvZmF3?=
 =?utf-8?B?bnZ2WjZzZ3picWdwZHU2aERxZkhobHZkUFBUUFY2MEMwWWlZdnVMSVNoelhs?=
 =?utf-8?B?Zjhsdk80TUh3NjZoSE9JbmZySDExV1dUUUpCWjZEUUhnUTdud2JhZEI2MXVJ?=
 =?utf-8?B?UW03MHFnY0h2Qk1XN3ZMYjNCMnhLM2wzSjlTM05vTThSV1praVNrZG9HNmNo?=
 =?utf-8?B?R0hKTWlzUkk1SVRzQ1h3TU1sZ3Rac05zZWlIYWswL1NOc2Q0bkFTeTY5Snhi?=
 =?utf-8?B?TmF1bVprYzVJTDRyNjh0aEdkY0thb1lzV3NXODZxVVVwTjRTNHRhWWN1blp5?=
 =?utf-8?B?UTNyeHVwckgyQWNheEQveU5IbWFGTGN4Q1BBYU9SWWxyUnZCVE44NTVUemc2?=
 =?utf-8?B?SjNnZnRpVm5ZSmk0eG5wTFc2Yzd4V0JRK2dYeVJ0RTh6Szh0bGlFMStWeDRS?=
 =?utf-8?B?WDZQUk55YngxK3U0U3R0dHVRekwyU0orTHordFpITUIrUiszQUFyeHgzN2Qy?=
 =?utf-8?B?NkVGOURyMFRBTS9oWWVwVkNkVGhEOW1yYXNTUFYvL3VxSGZ4OEUvb08xU3BO?=
 =?utf-8?B?eTcyTjhFaG4vU2djMmdPRk5uRUp0ckVuNlJCdTFhOUU1ZmVkVHdyMG16NkJh?=
 =?utf-8?B?T21ubDhKbjUxZkF6Nmg0KzJzTFBGaTJDdXJwSDJHNGVlM3g2OWxaUVdsVnlt?=
 =?utf-8?B?VnRsVFVGalc4WGFRdVBuTXVVM2dZMU05Q1ljTjZtc3dOZytCYkFuSHBucUFH?=
 =?utf-8?B?UmFnRmEwY2pZV3Y4WkZyM3Izcm8yR0NZb1FBVk8raUdldDYwTThqMGhNaW1V?=
 =?utf-8?B?cFpVdkFJTk5adlhWeGoxUVNDMkhBakdENzkwS0loaUVnMDhSRlhhUkFTUDJ4?=
 =?utf-8?B?K2dyMmJYdXVuRnpkR1Y0NFhBUXVlbG1MUGI3QmY3dk9MTm1CMk1VS0ErTU9E?=
 =?utf-8?B?ZEF4VnBkd2xBa0lId0hiU1puNHlmU1dXWXphV2c1TUJKb29Wdjh2VXMvS2cy?=
 =?utf-8?B?QWVNMS9FUEpmK0krYzJyank4SUNsUlgxdlVSdzVMM0hSbGxIbVZaVCtaQXlG?=
 =?utf-8?B?WTR2MnBQU2Q5VFFhWjJIaGM5V1pweER0ZDd5Z0tMNm5Yb2lreHkyOEZERXJx?=
 =?utf-8?B?WkM0cUdpbXQwNWdXWW8zTFBaelJVcmg2a0VueUFNejRhTWd2QURERXVlQUl6?=
 =?utf-8?B?alVodjEwcVE2dDNvZk1qb0V3b2YwNVROeTBIa0NzUGh0cGI1cmZIZDc1aWE5?=
 =?utf-8?B?U056L1JiU0lIODh4OG5PNm9ZWURyU1JSci9YL1A2Mk1kT2Z0SDdpMHJ2OEo4?=
 =?utf-8?B?d2lZVXNCVFoxd05TSENwSUhneTExUHdLZjlORkFla3ZEbXE0RVp2aDRYVGhs?=
 =?utf-8?B?enBKamFDQTNaOWJKYWpoOTRhbmg2STlBVE9pRkJRMHVMMldMbVVzRWhCVnRj?=
 =?utf-8?B?UkZCeWpDRndtd2hoWDJURUZ5UEFPaUx4OHA1Y3R3cHlYbWJpam1ja2FIU0V0?=
 =?utf-8?B?djRjY1NsQVAvdUhWN0ZCakFQa29vaGlXLzZvVzVVWEhoS1h1Qy9rTXVjZURx?=
 =?utf-8?B?czVqaTdtY0x5TkUyaWE4R2t3YlMvVkZ2bEtWemZWbk94dEp3NHQyZ1BQYXl2?=
 =?utf-8?B?aWN4T3UrRWovNnNpTTZKVjBOakcrS1RGeWI2bkUvQ05NRFI5c0huOEVQVWJC?=
 =?utf-8?B?dldTY2JYWmpMTnhqNUNhQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStOdlNLVHdsNTBONEFmVWl1QmtjU1Y2Y3pTMTh5bDZSR3lQRzdLWmFwVzNZ?=
 =?utf-8?B?UUJ4L2xPbDBCRVQ0VWdseEJwSU45cWlBTHkrWk1DZjQ4clczTUNESVJXeTBE?=
 =?utf-8?B?aUtRbTlXQ2V3VTNDN2hveCtuQm5MdWg2VXN3TXJqS21vUHJyeWdrZG9OZXZm?=
 =?utf-8?B?QndGdERtNVhWRWhFdFRYeFNyd3BIWWRQbUJ6a2ZkWEJSWlhsU294RTdGNmVI?=
 =?utf-8?B?OWIvL1oxOGJPM3lXc2xWSXFtMTM4eTlWcDY2ZXFjY0VkeEdIbXZnbTNjTHZi?=
 =?utf-8?B?MERLWG5mdjB2SGdLeU0rdG5QVVdJeU1CbGs4SzJXOEtaY1RLblZJdEkwbHVy?=
 =?utf-8?B?ZFB2QkxQQk5mRFJaUGY0VGlXMGtZb1ZlVGdFWHFKZUdHbGxVT21oSTBTRTJW?=
 =?utf-8?B?bkpvano0ZUdsYlFKWkFNNWxVYTVrdFM2ckdmSnZiK3B3b0NOTk5jY0FBRitq?=
 =?utf-8?B?R0xCTzZBWmgvQUMyZUs5Y1pVRDZSWjNrQjdadXZYRG1wbThBNjUzMVM3T254?=
 =?utf-8?B?NHdlZExhejRUMlFpbzhVNmlHYnBJYjdCSjh4OVJFdU5wNnlzWHc1MjMzYUxH?=
 =?utf-8?B?dVNLR2hzMjJjd0RQdnpqakI0aGtISHhTLzRReWJHYzd4OVVqY1MrdVprMnlh?=
 =?utf-8?B?MVBxMGZNVUk0ZVdaaFdaTGdZMG1JQ2FubVlNOE5oUDhxSHMxaG0vbkRpdzhq?=
 =?utf-8?B?dzRBWkh1NFpIanhoU0d4QzZWU2ZLWk4xVEJSelZLcGFlRGZqeWx6U0t6bkN0?=
 =?utf-8?B?N3N5elpMMUJlekMvRWN6aWl2bUlpRHlleXFFS1ZHN0VyR3dQOUpHSzBpUzZG?=
 =?utf-8?B?TmJrcm5rdDMvMkhtSmhJTVZQUHBINU00Tm1CeG1PalpRQWU0U1dBbGF2WmZo?=
 =?utf-8?B?UjBtckRMemlXK1d6eUFiMm85Smd6OFl0YXJWK0FZdkpmREowdkM0eDVtTDJx?=
 =?utf-8?B?UDYwejJJQ3NhM1grdWhuanVnS0QrN1c3S3IvRlNBRUEyNk5wRGpydjV3WVVM?=
 =?utf-8?B?amlub3J1UUtld3ZEMmlseElqYkZUTnZTUWgvMGc5a01iUEorQnROcTlxYTIz?=
 =?utf-8?B?NCtlK1VpTk9WV0c5OW5mZ05SV2pEc1ZkaHBwNm5hWThUT1ZZOUNNaFRsa3Bs?=
 =?utf-8?B?eFV0aml1MGd3R0YvZnNWVUJ0aHZYUVdxTUtwdm5DK0VuZmVQMG1rU3dVMU1P?=
 =?utf-8?B?YVAvNzVWU1JyS1ZjenA3b0FDUk5rLzZNZ3VSSVB5ckZUMXB5eXBxMmZTTmIz?=
 =?utf-8?B?T0Q2aUNNWDNpcDJ4OElUOHlXNm5ZS3pDdndOd3NTdWtZWDd2cGlYUTE3Zkdv?=
 =?utf-8?B?RTVxVFlpODNveWlkdGZuQ2FHL0VSUmtJcDFreVBEaGJYMHhvSzZ4VmdDNis0?=
 =?utf-8?B?a25rOW5OYmF4YVFNaUxkRkpiNzg1OEVTZlNHc0RKSklpMDV2RlRiS0xwVkl0?=
 =?utf-8?B?VzEycjJ2a3p4aFkwc2JncjRSa3lIU2NhRGFieTBac2ZzOHRWZmxQWjVhcDFl?=
 =?utf-8?B?ZkR5eE9Pb0J1ZHlPRFpJOHV3Q1BwazFHZy91THpTYzYvWXc0ZkVlK3o2Nmo4?=
 =?utf-8?B?dmZsSnhIaTlBZ1ovclNveERNZ0U1K1dKWmtHUXdPV0RVT0dCSy9adW1JNC9q?=
 =?utf-8?B?RjBBb1Y2L1M3bm9lbGZzdjFVY3JFSFpzRVFGT1hIUE43M1BMektPdjlKR1I4?=
 =?utf-8?B?N1VROVFFWjVsbmE5cGJkeUlmS0p3cUw5bjQvR1dpN3AxT084ZVVjKzJCREQy?=
 =?utf-8?B?UURYZWdMY0NVaVZEbk5nY3lEMU9GeWlJWFpBZkxxZUdsZ0ZlWjFKNDhZQnNU?=
 =?utf-8?B?NTB1YUc1akljZTN3MmwzU1RZK2JoVkpsc1Z3ZVBFTndKZXcyTTd0NERXdXNq?=
 =?utf-8?B?bGhPRVVwV2hvdTZlTG9XbW94KzM2SDJkZWpyc1lWZWZBTHdxbXI3TGRtOW1h?=
 =?utf-8?B?S2VOOVFSaSt1Z2U1b1ZSdzJiSjJWeFhlcTBTMGx2SnFUcjVJa0NIclZ6RDM0?=
 =?utf-8?B?RkxkQ2FET2E1ZmpJVVFGQTY1alV2b3ZOSjNXeVFGeFVGZjRQVTl6eDVEaUFJ?=
 =?utf-8?B?NmdNaGUvSEVHQzRKWTQxL0VTSUxWUWp1UDVUNzlsUEtpUnFidTlhczRkSElO?=
 =?utf-8?B?MVFFRVFWUnhvZHBEcm50cERxbFlWOUVIaDV4YzB0UkxQRzZaRjU1bWNJMXpR?=
 =?utf-8?Q?TUzH3tcq/UudChFlcr6PeG8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9642c40-ed4a-407e-0dcd-08dc9a84d4ce
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:50:47.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgjcKX7QaAfDHT/xRq9bkuk6SekQ7hFZyBIilt1tBKy01IF4fAx+oXyKtTGvQ70Q6qdRhEaUdoRFR1IMGgLUwKjsgY2ZOzM9B+pYLuJT+5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

On 7/2/24 12:33, Aleksandr Mishin wrote:
> In case of invalid INI file mlxsw_linecard_types_init() deallocates memory

IMO there should be some comment in the code indicating that invalid
file is not a critical error. I find it weird anyway that you ignore
invalid-file-error, but propagate ENOMEM.

> but doesn't reset pointer to NULL and returns 0. In case of any error
> occured after mlxsw_linecard_types_init() call, mlxsw_linecards_init()

typo: occurred

> calls mlxsw_linecard_types_fini() which perform memory deallocation again.
> 
> Add pointer reset to NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b217127e5e4e ("mlxsw: core_linecards: Add line card objects and implement provisioning")

this indeed avoids double free,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
> index 025e0db983fe..b032d5a4b3b8 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
> @@ -1484,6 +1484,7 @@ static int mlxsw_linecard_types_init(struct mlxsw_core *mlxsw_core,
>   	vfree(types_info->data);
>   err_data_alloc:
>   	kfree(types_info);
> +	linecards->types_info = NULL;
>   	return err;
>   }
>   

BTW:
mlxsw_linecard_types_file_validate() don't need @types_info param

