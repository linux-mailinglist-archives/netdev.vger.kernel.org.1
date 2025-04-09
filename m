Return-Path: <netdev+bounces-180584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9A4A81BEF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4251B66C58
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D71A8F84;
	Wed,  9 Apr 2025 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAxnp5qN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930A259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174189; cv=fail; b=Hd6cGLwUwTSKnIqp1rRXlB3obRm4CjWQVTIUw5wmkFoHVsEXY4seU0Bb4aRdJCayXN/yzi5Cek1WpaBiZPnZ3kRGFUWZVZYPmuxn8LDFe8A7qQcpkvCG1n3C6uyDqQBaScchED9jpqk5GQ0vbNgTEaAApl20MJ5NGVOBL6BKJec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174189; c=relaxed/simple;
	bh=BMOKmRkt8myMxX+FPf6B/nMTsMnlM7kSeYLaHeM99m4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qwh1RfZIeSzj2KlC1fOvJOEkIoUZhNpoI/3/I71lUR65sASiw3brczINRs8x47rb+coZOil74Xymvkq50siJnna1p0M+1SlFJHxpkixtHPOdhWUIxte9Ps+YQNxS6pQCAdiFHUgjBQtmVRA5IqhsFap5l3yOCLa+lcGMTgF0XR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAxnp5qN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174187; x=1775710187;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BMOKmRkt8myMxX+FPf6B/nMTsMnlM7kSeYLaHeM99m4=;
  b=MAxnp5qN7t0ar89bYNM47Y5LRtd2rjVTUp5o+o8R4xc8gKomZHuNvMaK
   IP9uY0mR4TCZnDN+numl81EbUijBXJ6bx0Fl2YdqPiSq7gFIZqbzZnciM
   dM20EmSciyUA76KiicD0JvMcx23D4qaj7Tir0KIl0SJal39LPl1omqKPD
   aFFzIufRyIA3KdHAdHPQLtGrCsldojOWfg2EjG2HHEY+pjRgg2yAKL8Me
   7ErumBZozAPH+d4X8tbjnpgfKRtkJuapbBdh1LbQ8Tg8uwX7le/TEnAPf
   IiTtDLVOE+pj6HhuIKSmQEEHkfokqs6/8D6kfZ1haQXjRVpF+9LQoL+n2
   A==;
X-CSE-ConnectionGUID: Fp220VRvQ6upfitgL3Tv7w==
X-CSE-MsgGUID: GUwA5HJdQ4iw2hePv/Lf1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33235411"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="33235411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:49:46 -0700
X-CSE-ConnectionGUID: sCU+LaCDSomq7CeBj5kRrQ==
X-CSE-MsgGUID: PlnalopISd+eHWMBRjdYTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="159447965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 21:49:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 21:49:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 21:49:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmJzFVysD/x/UDTqSB0FMkFi+hObqh0mobf5+xVO3NKE2gw6vo2rDtw4OJZQ0ZWb3OHxSWycP3rXytQy4bOcGazqOQ3el5D+F2hjBcugQfuW00l8b9ttJMvL1mp/UQMi70VFTUAnh4191MVBjILWv60gbKNYOc8dhBzKf4B8ni41Fm9JUhWReC3jo7iMDRuS9F8NixWh/T3Abn/cM8qbHAj+ifV2LrfhL9c5YDSmUyZoJZb3idNgaugpM9wBy2/jab/b8BI5ndTv+93Wwsu8jzK1Lmsa8VEeTrQ0pKLkIPrZ2md1oMSHCl8tFtIn4O39r7VSMDreRqQ3phjb5ZFd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSqx3EoyWdlLnIQlbgpaDpd8Ine5m+BT44w8bk60CNc=;
 b=l+0vHirk4AWrIInZA2lbCkKcpolfFQsOu6nzjBxj1kuYQ54r81L81e8CBy4sJcaCYUwwpqCtEY0NnH9dasbaV+SrdHSTfbcGi+KCqOLcwPB75c2OlxIozhCghBHYKqEAo/BbNRfEUwsx6TSAg3iNBW1dR2dC7dVaZ1+Uix4IgDbfy5ywYPJc2HoNwqPFkC3uLEpMW/zTAI1Ev/+eYUK/tdB3wk0oCDelPZGhf12N5w4pvNiBXKbmEy+f0XIe2/syt4CqOV39QgC8Q2ui0LPmGW+cAs92/givtptMej5EAH0ckDpt+RNbrwCkfmAKK3X/96m26f319XD2ejjr1abzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 04:49:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:49:08 +0000
Message-ID: <92cc7b8f-6f9c-4f7a-99f0-5ea4f7e3d288@intel.com>
Date: Tue, 8 Apr 2025 21:49:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/13] netlink: specs: rename rtnetlink specs in
 accordance with family name
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 3917b05d-c561-4521-3799-08dd7721dce2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkZnSVNqWE5FaDdRWTM5bW00MVJveXpnTHBWMVhDZGdEdDRkTFZCMWJ1MGcx?=
 =?utf-8?B?QlZqV2M0cE1sZlVLOVdlMEQwUWhlKzNjRmptbUU5emlHYzVGZFhHYXlCYm9G?=
 =?utf-8?B?dmJtb0NwMDZDblpVWll4RFl3YmlPSTZXQ3h3a0V6SFRoYVhjcmhHQUJwaktw?=
 =?utf-8?B?d1RTaWRpMmRabWx6VjA1M3RUeVhlYlNYZUszcXpIcWxORXNmMzlFTkpDVXB2?=
 =?utf-8?B?MmdYeVhjTklqSkdzSzRKU2R0M1BQZGt1UjJsYkZyNDRTalJIK3dsK2swYnl4?=
 =?utf-8?B?ZTEvMWdsV3A3cFBWUEIwcVl1U1huWWlkQWZqb2dpK0w0Q2tmV21qSktHSXdo?=
 =?utf-8?B?SGJKU0JrVEQ1RGU5SDkrQXNCUVpHMmlpN041R1djbHE0RjdEMnhsZWRwcG1h?=
 =?utf-8?B?T2Fhd1RDVGh1SEdZdTZCTm5KTGZWWmg5ZUJnNU1BdmxUN3hvV1NRUWI1eHMr?=
 =?utf-8?B?ZjlCak0zSlhGckcvc084Wkt2dTZadytYdVNwTVVoZTBDemVPdGxwN2RMb1BU?=
 =?utf-8?B?aDZ1alViWmtyTGxxOHlZSWhhMTlJZjFMVGZaVDBtM1JraG1tb3lBT1pzM0lD?=
 =?utf-8?B?Wk9nWHk4S2lHWmZNUi91MHpJUDA0Ykx6Y3BLcjh4eDdZczM1dWdmV1lnRnR4?=
 =?utf-8?B?dE5QalZqUTZrRHMrSWZJeHZZU0JZK0NFVFVtbU92UTBONThIZFF1U2pmZm1R?=
 =?utf-8?B?b1I0VjhRM1ZWaEgvNFJpbldEQStSZ2xJcnBYSk1nYXRoZytta3FFM1lvbmlt?=
 =?utf-8?B?aVhUM1RoNS9USmt0aTBkNHYxNHJLblo5SEZPNGk2U0tOYU9OREp5TXZ3RFIw?=
 =?utf-8?B?VERJL01JcTd2Q2ZUYTdjMUtXclVFb0hDSE9VS0hVY2MvZDF0Ylk4SFV2RXA2?=
 =?utf-8?B?RkJBQ3ZlTWZYckFuaGhBU0FjY25rV3NtbUFlc3BZbFZwZVZqdWVMczdFL0Nx?=
 =?utf-8?B?aTRnenZndDFzN0wwTEd6bzlmM0FiNGFIaCtQZ2xsTG1QaGtVSXJYMXBqVzl3?=
 =?utf-8?B?dGVLUDZ6TC9BMFZvbkR3ZU5YVDhrRGtCNjdacGNFNVZoTmlMYndhSlpySGVP?=
 =?utf-8?B?QzhQUndKTlhUWW8yck9hc3hYZ3BkNGQ2Sml6RU9LMmM1N2dPNi9QQ3VEVUtq?=
 =?utf-8?B?T3BlMisrVnZ1MXVXYnhvaTBqNjhvaEJ4L1pETzJ2MVlsSGdOakhwaHVOSlU2?=
 =?utf-8?B?b244Q3FXM1FjWmlQVDJPNTdKanBaYS8zT2NnS0p1UGxVM2pOVXhIaGptMm4z?=
 =?utf-8?B?clJGWDJZbnQzb0s2bHNLbjB2akcwZk4zb1FGNDY0UzdJYk1JM0xMUmR0Rklo?=
 =?utf-8?B?MEZZUm1VVVlxOTkvcUl5cXdkbTJHa3hwbGFGUkQ3eUdDb2R4QWhoS0cyeUVx?=
 =?utf-8?B?b0pOQnZGb3B0YWxQcVVlOFl0RmhSNXBLemZlUXp1dTlhbVkyYVJCVjdYWHI5?=
 =?utf-8?B?YmlGQW02Wm5YNCtiM0JjSWNXRGpLWWxMcWJzUksvTEc2ZkVTd0pIUmxJMFhU?=
 =?utf-8?B?Q2VFOGVZc1VsTzIxSVVvRkZHMDEwNWhQemcxeEFvWEs0VWFidjhNWHFkRExS?=
 =?utf-8?B?VnkwbS94dndVdWhPcWNjQ1g0WDhmYlZZbFBTSHlhUWxYdkZDdFpZZkx5amk1?=
 =?utf-8?B?b1R4dVFzU1I2WlFMbjhjS3ZEaStEQk5lenlYRDhUb3JUSjRwSDVRWS9jV1Av?=
 =?utf-8?B?TWdmdm5iSVRWSE02SC9rMnZ1K25JWFJlcVVmMjQvdXMrZVZhWmpza2xvRDhT?=
 =?utf-8?B?OUthOVRkek1DcnFPM2tTajVTU3FEb0pqM0tzeGdRZ08veU5FKytkTHdDODl4?=
 =?utf-8?B?bzAzV1VpZzN2RUI2dThqRGt6NlpDYVVVOWFDTXFHZ3FQakltK0dyaktyTmpG?=
 =?utf-8?Q?QVJffNMpq4x0h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdXTTc4NXQwRFkvRk9kdFhhd0x6aUUwQmFFenBhanJWbksxUkNIK0JpcXBp?=
 =?utf-8?B?RjFRb3ArenVUSnBaU2I5N3lKUXBLc3lmbmlpeXRLUGs2aGdlK0hodjdxQzAz?=
 =?utf-8?B?T3dwaUFyaEtzTnlxNUZ2bWxNNVA2WWRWWXNDVERuWmhxNlFxUUZRaDZOcmVq?=
 =?utf-8?B?YVhJVDQxRDNEK3pOL1dNSDhJZzE2THJQd0JUQVYyVUdycTV5V3RuRkYrb091?=
 =?utf-8?B?VzBnTkwza09jQ1FOWEJ6OWRuZ2pSZStnWm1RV1Z2a1kzaVVidjVtWUg5QTFz?=
 =?utf-8?B?UXJYcFhSR2RucDd5MTVRQTZ0S3Q0Ulp4a3pvQnJGTCtZY2pZVEt3eTl2em92?=
 =?utf-8?B?N1AvcWppcHBwenhuVmRsOVM2QXpiNGVYU2hrc2piN1dna1RkZEZVa1BqT3JO?=
 =?utf-8?B?R3FaRkpYNjQ3V2xaM1B2OHNqL1lodSs2TFAzWFdzNnc2T1E3bUZ4RFF6OHp0?=
 =?utf-8?B?RTdmZ2hORDBuYWNSMkdSQ0RpOXVIQVpLc0MycUJjalAxMG1hY0pWRFRONkRQ?=
 =?utf-8?B?dnV4RExYTzdCZldXSWdOd0QveUI3d2l4RVFzTnI5SjZaVmxuK3ErU1dEUHRV?=
 =?utf-8?B?eWpQTmZNYlpIbFVuc1JJQWhxVy9NZm9SYVVIeXlPcTh3SjlYeE5neDJtcE16?=
 =?utf-8?B?VTlzemRYOGhtRlk4YjdCV2NNZG1KUjNFQkhUa0JIU1FUZUlsQmlPUHcrVW9H?=
 =?utf-8?B?enRpS1JBS0FlL25UK3d2b3ZPaU1yVWVTNXY0TTZUSE1veStIcDMxZEdla0NF?=
 =?utf-8?B?TTBlNFRSUmNGb3AxQzUzSDBBZFo1TGhSU1YzaTBXSTlBZjJ5NWQrcFQzODda?=
 =?utf-8?B?aVZrM0lxZnJOajgzdnlVVGJlYjhIS0dtTVBDbEVTUlg4UTBsZHdOSlZZTFY1?=
 =?utf-8?B?UlVVR1hzTDd0THNaWlF0WUlyOWk1UjhrZWt3YVlVOGVpVlpXaU00S3AzazNU?=
 =?utf-8?B?KzNSYlkzcEk0TUYxNVdrMHBLYjVjR00yWmZYQ0l6UXZaRE15YmRmVFhmY2dm?=
 =?utf-8?B?aWRDZkRwdDRGQjMwdmcwa042cjN3SlZNak5CYVR1SDRQVVpCL0g2aEtxMlQw?=
 =?utf-8?B?TVVRYWcrdWdOOHdRNVd1SW43eEExMjRSUGFleHVnU3lPVWxXb1paZEE1UGk0?=
 =?utf-8?B?RituTzBmRnVvVERaTUp1a0RObjFXZmluNDVCdldpME9qL1ZldXJzMUlZMmQ3?=
 =?utf-8?B?elJBb0pxVzcxbW5EQk9WQU04SEdvdGtwcnJRYk1sbDByRU5BUXVyZlhFRUlL?=
 =?utf-8?B?N1JBNUtMQVFONXVHNWhUTWdMNlVTWkt4dDJMdlh4Tm53ZzQ3aUc3T3dseUx1?=
 =?utf-8?B?NnhGVkxtUjhOcWVRbHZScFB5b2NyOUJJM29rNW5lN0I2VjNpMTZwNDA5cjBT?=
 =?utf-8?B?WTZQVGlYZGZwSksxYmtHeXZ6UFFGWndPZTdubWMzTkhOMlM5a0JacHh1Y0pl?=
 =?utf-8?B?TTE1RXhwb3JWMW5GbXBndng3MnpqSVlQOTNuRmVsQ2JydzNIcTFJRnY1MERv?=
 =?utf-8?B?bUxyZU5OcFI3YUo2UWVFOTFZcHZSbTg0Ti80Z2RYeE5GUEwyZTZoR25TZTU0?=
 =?utf-8?B?U2daSmlmNHNXRHEvaU16Z0dINnFucFZ2aUovSnNPa0JRL3ZqbDFIQzA4b1Z3?=
 =?utf-8?B?VEZ0ZllFVml0d1cyU3UwTnhTRUIwelcvNVZycG9xbG9EQjh1QkJBa01id0tG?=
 =?utf-8?B?Uk1wb2JFRUN5ay9ybUdBbHdmYW9NQTFnVFpoeU1TdG9lS3hYUU5aa0UwZGtL?=
 =?utf-8?B?a2ZGOWxuMDRhOVYxQlA0WVJJYW03bER5d1NLZkpiMGE0QXlpQys1emdOOGhk?=
 =?utf-8?B?MXp3c2o2aVJmaktCTW5GcjlLS1ROMjl4NnFidll6NllRRkxVdE5FV0Y1NHlT?=
 =?utf-8?B?UnFwdENVczRPL2luWStOVkd4Yk5oT0M1OG16T1hPckRibkk2SVNqTmUyVlQz?=
 =?utf-8?B?b1N1USsrQUxhUjZIU0xDTTlQMXcyTzBubnI4cHZUZlh3bk5USzNrWDIxaDAv?=
 =?utf-8?B?MDExOURWcnVIbGRheVVMbElPNHk2Ri92ZUxJYmdSVldEb3A3OWZiaEtIQUtN?=
 =?utf-8?B?ZkRjNE1aZmNwV1VwL3Noay9LVHlUbnE5OVNyTjVHTk55YXJQZlZ6ZnZ3TGxp?=
 =?utf-8?B?akZpNzE5Q1JNMlM0Z0oyMEhPWjFoeXJkQXBzbWw3aEpuWU1CUWh5OG90bHYx?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3917b05d-c561-4521-3799-08dd7721dce2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:49:08.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPazgXIc4Jpzi1GPrUKZQVuwKcvVklK9HQX92EiuG9KcX9qglSaAK80x65144l6w9z57Mb6zpwKA+qq2Fnn80aZkUc8l1R/4RCiYrda5Ic8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> The rtnetlink family names are set to rt-$name within the YAML
> but the files are called rt_$name. C codegen assumes that the
> generated file name will match the family. We could replace
> dashes with underscores in the codegen but making sure the
> family name matches the spec name may be more generally useful.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
+1 to being more useful to have the family name match the spec name, I
agree.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

