Return-Path: <netdev+bounces-307626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p+IyGtnUVmrcBgEAu9opvQ
	(envelope-from <netdev+bounces-307626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E44759B6A
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:31:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dhueCEka;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307626-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C95383023302
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713958003D;
	Wed, 15 Jul 2026 00:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239446B5
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:31:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075477; cv=fail; b=QPgWtJGoQngEEz2jEipG2WXJQt/U47jH9fcRMKWg6MIdNvAMBZ5ZEoBurDfH8i+QqdRzsmZBH+TazeByuMuqoftHdgBvE0ZeKvXhb8U1HR2CqM5HnsP71+GE13mIVnX8Wdjd5ENoej0UVm0K95P33CuDS2p5YiMOBx1nqEQHhCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075477; c=relaxed/simple;
	bh=JM61IxLDg++xB6P9aTZnU+5t/VEIuWN2ZF48EyzqPRM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rudPynOVMWmwqoTmP/bKwGWXTR/e/RhaSKZTrWMv04J/GD/eLNeE8OvJFaS1fQXFwARPrsYQsaWyG3ZGLcp5Bi9Ojz6Y8XCf8x/EtKtHJ6gnzS6Izt7m/RoobzW7/j2wZwY7j3PdrF9dsOgT1v2UnILLUxSoXPn22QCyQbeM8oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhueCEka; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784075472; x=1815611472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JM61IxLDg++xB6P9aTZnU+5t/VEIuWN2ZF48EyzqPRM=;
  b=dhueCEkaliKhBcAV9fAqFad2WD39WLvk5FcNmoQ3SUTXG+yCON5JZ8At
   AJYTUgrI6TBSQ0EMHnoZ4JnrpwYCP14Q4yJwGHM+2YMTowj87fCyU3HrJ
   FSbl9sMYEXp9GCe6YzImLHc+KdBJIvut2V2Nh4Bx1flOJllsXoJpG1B6D
   GcUzzm95lIJX2kMAoB7G9KGusfV9ixyI/gdsDWZA+etvYdjFxHZDTntmu
   lhu+hBYdOUU4AlRdUIMyUS9EjZKcBsB+tJGUjZKYU2arptIVlJCRjWomO
   tZXTYAfmmDzNrlSKsrW9fKzTtFpysn3kimcIgGD98jrXcOqDxGK+0TDGL
   Q==;
X-CSE-ConnectionGUID: Y/SLM5DyTRKXv+ruWHwRVw==
X-CSE-MsgGUID: SAe92BwPQGG4SAS/Hc3yvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84796321"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84796321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:31:11 -0700
X-CSE-ConnectionGUID: V4T10zwpRim40Pv1p31tcg==
X-CSE-MsgGUID: QvoVH1yiQfCDCDoeZX2HGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252619284"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:31:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:31:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:31:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNyhl9uUT+xEa9G363BfxVE6oYzAYvLYZums5jsqS9MEttin5HZ0cMsn0mXIRSiMDYwEOkWODGFIcIU8Ug46d0Nixk0VTzX2MP0mP0NfgI7lR5PH14ahnu/DxSZp4gBrnOtNuWRl0ZJM7mlkiSuW8vLwoebJvN3K5taVFJMTiJrZ3GlTxlBd7D0WTDFZS9mB96DxyamK2pAEeLBNLFoJtMQpL6++fsIGIl6UZxtYdfEbqi5LOkY2s8hFcexeD2HVW0cBoi0D7gEPBPg/aOpr4miJ8NmINTDtN7Q0Wyaa4iLkyBUlvEwYHyuLyaCglGEeyeXngte6CdM6hYrNI2NkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewAXTQV2DV0y7Flx9bZXplHvbJHv1o/OFbpTvNgai9o=;
 b=nlrF0ZDkVKYLWkEbxyEeQbPZAkTESDZN4YKReBt7AS0SbLp37SXfEk9tjcO7M/4hu7XfJbbalfhh8mR1oTPaWHY+aY0UGZrincF7XuomsSTYFznPdmkzLHSKd1gaLLPYm/ECj8C3POGGFjPfx5qY/P+E63ORQBXy2Jveb/85R7qqBWF44FNh3TsyGYV1TolUpKKcej0cI4ecXCYrPxjpVi1Y1nR5kNjFDODpLLb/gv300/DiGRnlw8MbNo2DPXUSv532CX05MwKYiFlE65jfFbc0xc3T9kV+w9Xuk+06cwTbDxe2tlvoTKH0ZPmCPlF5ox3x2d2cybmc49O3k1meaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Wed, 15 Jul
 2026 00:31:03 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:31:02 +0000
Message-ID: <20bb3c63-b66e-4ef2-a230-481609b7f186@intel.com>
Date: Tue, 14 Jul 2026 17:30:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: txgbe: fix FDIR filter leak on remove
To: Chenguang Zhao <chenguang.zhao@linux.dev>, <jiawenwu@trustnetic.com>,
	<mengyuanlou@net-swift.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260713091911.1614795-1-chenguang.zhao@linux.dev>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260713091911.1614795-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 949d1227-27c1-4e2c-15b8-08dee20859cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5FwXxHoSWVaRXTeQU97z95jdisEsqa3M+LKrXjR184X27ApVe1pLDWTYMR2er+FdXeTTGCyZrK5SB74DQbfP1eZzhV08b5Y7M/JrRhNxp8QR+d0MnFgYeOxHP6P9tgHH9x6EEoFiR3v/aSnwGfcWERv1ybPa1xAD5btOrizcUExXvqbQwFPRVxpY4WRu0NvbWVM06RLClXyerFuDmi+yH7jqDDGXJ8qNKBN2iAxuJv22/iebPXmrvdebBjBMdSDqGdVR/SF9u8oIVKuVnvayaFd3996kkeCJcHJetRVOGaGnoCMCtcwoBpbQGvH/zbWmMgMXhfbaeOYHQkuSNrw1B6sC9Ld9z/7gCXR8yuRZVfvm9QNCt5eEmyYL7KqNxUInc4qYe787WsoNkJ6R/Xttk7StXaHY9sSCrg3caS5LUShG216VNSQLtQXWRiJWYDn3rLmnYrRRVOyZAKxFtZ8LiJful64ABv+PX5zCOfIcDKVF1jUE+fZrfy1U3rOZLeh/hPqBATVPwH3xsCe7ej43nNXe/k1wXwZ4dTtTOuJIvhDJGI6CvhovXtUatoxmMP5s/X1vctFh/uH78ch/17GqUf1ahN02gSvjmY+KNWHewmOreRzmxk6xGOwGNrEYjodpev7CkiVJbTvUj+dWyXTLSLyhojdtjDKETGJ1oVNFK+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hGK2VkY3VuRzlnUWtQUGllcWc0cnkrRXBwaElaS21YT3ZDaUFoaHJBT1h3?=
 =?utf-8?B?ZkFxUUg1ZXVlSHFQR1lNSnErY3BwVDJlVnBqSnBONFlyMGhHV0NMQzZESWVT?=
 =?utf-8?B?dS9Gdlp3OUpkdUt1Uks2cE5yTVVaUjRlbThhNjJhRVEvVjNuS3NSTGRZMmhW?=
 =?utf-8?B?N24wSzBTZEEyNVAwcUwvVFI3ZHhiZDM5a1gzU0lOeXFKV3ZlWGxTdlBOc0lu?=
 =?utf-8?B?aXB2QjQ2QWpmSEYvdFBwVzlzVWQyTXpJN1VZR0JMUW1xWFNYU25hdHo1VkRk?=
 =?utf-8?B?ZW4yd3lwUzZoYUc2KzArWDBSYUZFcW9uYzcwZ050UTJ3SFM1THRyM2FtRXJJ?=
 =?utf-8?B?YXRlZW9XSktkaVR5dkdUOVY4QnQ4bWdnWFlVbFF4WTJRSWlPaVVyTVE3aHY0?=
 =?utf-8?B?MlpFdTExMUkxWWdqcXdkMzFmaWQ2SnFobE5IREpHTVlYVE1keFBKVlJ3MDFD?=
 =?utf-8?B?V2VHQ3hmaVl3VlJKZG53QnFtNzk4Z1N2cUxPZUtDM1ZDNHJ3dFp1R0VhT1Jl?=
 =?utf-8?B?bTcwamNBK09maGFWZzFjOUd3bUU5Mlo1SkhBRUNwN2lhTiszTlBBR1JPTVBV?=
 =?utf-8?B?Y05BK0lWaDdVaGtaMFl5UW9OdU1Kc3p5cE1lbG9hV0RzWHlCdjB5dWNjQUlq?=
 =?utf-8?B?Z2JKSmdGbXd2WWErNW5UY2tNbFZkK3V3alprQmhMRGUwdzBDUXBOUmZiTWdt?=
 =?utf-8?B?QmFYeGFyNnRHTlZlRUVidmszd0lpUTVhUnBMdUxHblhhY05OMHhYdHZrUktM?=
 =?utf-8?B?MnBtcDA5MG8wTFJmMVhzTzA1WmtkK25NT01BM2trL0dQeGpqQkZGc1dLeHlr?=
 =?utf-8?B?VGlvaFVTSkFjbXZ3VE9OOEdMTjVBNTc4ZEc4TW9keVNRb2N0Z295TU1FUG5o?=
 =?utf-8?B?eGVHUWw4cVJNN2svbFNORTNITHhPczhrZUl3akc2c0FkUWdtL2VCOUJZc01x?=
 =?utf-8?B?QW9FcUllZ1ZtdENEcnRqWmp3OHVvd2dZWFR2cHFpZUdsQnRuVzg4blV1WW1z?=
 =?utf-8?B?N0RHZHV2TllLVDdSWENTZkVvejl4OFIzdlZzMG9VMXl0dHJrV2Y0a2IvSDFJ?=
 =?utf-8?B?Tk9jcWJlZktTb0pSVnRCK1lMUEpqQUFOY0d1RlBXMHhxeG15d0xQT3Z4enVj?=
 =?utf-8?B?UzE5cEF6SHVPTlRxcEJSWFB1ZFlRRmwzajJ0SWhmSzJBTDdCNnhJYkFvTlZ1?=
 =?utf-8?B?d2t2Y0craUQyQkE4SDFKK3d4VVlPMGNaSTAyaUxiRGJmTWZTOEYxZS9ybG1D?=
 =?utf-8?B?a1FyL0lrb3BYNEg5Z3ViUWlva1B1MnU4VWZrMGZ6N1hFT1dTM2JYT1NmWm5L?=
 =?utf-8?B?cTZxeFRIMWtRWFdBRXJLclVPTXFIRVNtckI1ZjE3WmoxaDQ3UDVJcEpaMXJZ?=
 =?utf-8?B?SWNrYzM5eHRDT2xsdzVYQUdqTGxIQzd2ZXZiK2pBeUdHMUxDeGxXVnZpWmo0?=
 =?utf-8?B?OUhVUlpjMldITUVmUEJBRHZxeEhJQkU0enJvTEZlb2l5MjhGdVJVQm12UVBJ?=
 =?utf-8?B?NE9OYmZadWFrN09CWUsvemNNNzA5TG1CVnNxNXRmM3dHV1ZCcVZXcTExdUVQ?=
 =?utf-8?B?elJxaG9taENhVVR4YVVubXkrbXJ1K1kwUGNlbVFuc29abmVTcDFCZkczbjZz?=
 =?utf-8?B?K0d1WmZ0aEhlWFRwMStVRnVhcXM3YzUwM29GM0hMd3Vrd1Nqc3NSVjEwQWd0?=
 =?utf-8?B?cVlzekFaUm9teG5QaFV2N0pJNnBrT05IUU5rZGQ3dmlQSG5obzViRVRtckFT?=
 =?utf-8?B?YkxVU0FOOTZXOFE1elpsaEdJNkpFU3BBM29JeC9hSGNFVVBabVNOTFhZaW1U?=
 =?utf-8?B?T3dvVU5nZjNRZXNhVEI0dldrbi90TW02RXF4Z3BKNEZjcWh1QmtwSXZQa21j?=
 =?utf-8?B?S1JHUTdQQ0lFUWN4MzVKWmh6WTIyeEphcU90T0phZVVTTkkyakZycWRwODlH?=
 =?utf-8?B?R2thY0NPQUNrZTVpZEdRK0JBVUhyVTlGdWJTMTg3bldraExwT2pPb3ZSbUdB?=
 =?utf-8?B?b3NqN2Q4dkU2VUUwT3YxQ0lhTDkxajM3YTNwdklQMVdqaGdLZGsrMURTOTVR?=
 =?utf-8?B?TkkwTDlScUE1ZTlhdEFZRzJleXljVVlxeXpFYmpqcGVOMXV4TzBIWHBuK25H?=
 =?utf-8?B?NDJIRFlPbzRPa1JRTUpncjlDbFM5eVlMMnZGb1Z0SFpiSmVNaEZRdVNrRjRK?=
 =?utf-8?B?Wm5rMGlDc0Vmb0oxTUdySlF5bFlCaDBvVVJWYXVzZnp0LzRWdFZXdG9pSWdY?=
 =?utf-8?B?L3JNZHhPbWl6MmFKZmh3YUJlRWhIRjBuMFQxZzlSTVZkK1k5Sis3azNLWU9P?=
 =?utf-8?B?aXlOM0JjNnVSMW9vK3ZScUtNSjRwQnp4Tm81dzhGcVc2VTRiOXBzQT09?=
X-Exchange-RoutingPolicyChecked: rSmnh8nX24tZpzmkHr4xODS3L9doIH3tU4b76d8vQBkL2SNXY0BuTj9ZVmpipJIq6TgWc+THUgeYdshzZn27fLEWtrPwtEXFBHUoArtzYDA8zmReksq1ML1lgjnq3/DE/tocgKYQ/Ie4sifeUl7UOvy+6FmYjqGxlheEchxFJ5pdpxm7BpZRSGEnE6pVzbs+3uMkXshBi8AixL1mWBY/3kfl4x/r5yEdAQabz5grhjHH4cxTjXo8S0fW6zSswNp77D1h7q47yKaLAJu4C+caIXFeZ9koTyuleD1/PeJlGE7TDp2m+64D2Amju+gNc8pk+f/DGcsO9zUyaO3fSVJaUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 949d1227-27c1-4e2c-15b8-08dee20859cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:31:02.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHwyRh3xlwZsNCCaPQTLarOVslGha1vpk0YZjW5tTXSqbcJt1tt9UwPAz5P6DR81wBupePw8g5L1d7JTHEiNq2/1USNXEj3SXKrWjxEZkPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chenguang.zhao@linux.dev,m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim,kylinos.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3E44759B6A

On 7/13/2026 2:19 AM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Perfect FDIR filters can be added while the interface is down and are
> kept on the software list for later restore. unregister_netdev() only
> calls ndo_stop when the device is up, so txgbe_fdir_filter_exit() in
> txgbe_close() is skipped in that case and the filters are leaked on
> driver remove. Free the filter list from txgbe_remove() as well.
> 
> Fixes: 4bdb441105dc ("net: txgbe: support Flow Director perfect filters")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> Reproduction:
>  1. Load the driver (interface remains down after probe).
>  2. Enable ntuple filters: ethtool -K <dev> ntuple on
>  3. Add a perfect FDIR rule while the interface is down:
>    ethtool -N <dev> flow-type ...
>  4. Keep the interface down (do not bring it up).
>  5. Unload the driver (rmmod / PCI unbind).
>    unregister_netdev() skips ndo_stop because the device is not IFF_UP,
>    and without freeing the software filter list in remove, each rule
>    leaks sizeof(struct txgbe_fdir_filter).
> 

Appreciate the reproduction steps here. Helps detail the way the leak
sneaks in.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 20c5a295c6c2..c277863baf67 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -945,6 +945,7 @@ static void txgbe_remove(struct pci_dev *pdev)
>  	netdev = wx->netdev;
>  	wx_disable_sriov(wx);
>  	unregister_netdev(netdev);
> +	txgbe_fdir_filter_exit(wx);
>  
>  	timer_shutdown_sync(&wx->service_timer);
>  	cancel_work_sync(&wx->service_task);


