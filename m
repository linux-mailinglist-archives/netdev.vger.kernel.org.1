Return-Path: <netdev+bounces-110837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7392E83E
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D252B1F26D96
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615215B10A;
	Thu, 11 Jul 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMd3pNPS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091614532D;
	Thu, 11 Jul 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700818; cv=fail; b=QJp0fmsW4n9xAV5K3dYm4FepSuLqFnDsN8nm0H2Y8uvAlNecc28J6vJXpmbR09RG1duMWDnJMC9UHdqh6fbV8E0lbmKmZeoAIJqNdkiz28tZKASb9hUS9p+gfms0hTFz4SH94RS4fBZZNhXi52C/XXA6KTck7eytDZ9PT8QLB8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700818; c=relaxed/simple;
	bh=ghiqQBnDGikEE7h98ebmS4Ppd38JI8ayx+NpxDLdqNk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RuwE8SLDhR7lH7iaSOhbuFfKN89XNKdffZ5tIFl92UqmgGqGGcS4J95EmxnKN5wBB94I2yhdl6PPZhpZJ1apCxbxnOOUTk56d3zcu5zPNazUxhsPfqO8EN9kGWRV8+kL9dYqYQ1/e4QfOWECCQYwN2vG7iPt5btC8wbirZmhgCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMd3pNPS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720700817; x=1752236817;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ghiqQBnDGikEE7h98ebmS4Ppd38JI8ayx+NpxDLdqNk=;
  b=iMd3pNPSl3ZTb+WQUJJnpiHYuaZ+WUIL0abrA9lcqLVQTK/yJwIM7BFm
   mV4zBxIpRiXsmH24YCDaIDmF06zwGPOmZF6tfMwJu4Fui3E/wTbQ8+6CC
   BkxIe2p+JfhdP3Du9seeDwzNTaDONwC0uwhXloNBrxRzKHFO0CtUBgdt5
   Bd7k4mRjzRJWbyLSYh+UKYa4MNLejbyoEn/51D7N79azcKBtRAfJcgZol
   0DDr7EuOB2eOusarie5BFMnwEWMRTw35gzP8KI25uwCBK13pBC4Z5XVc1
   xfCw37cRxrpGi1aWCXhKoqlWZ9USe1H3auhBWt6rUrRSrGbV5ijLrllo1
   Q==;
X-CSE-ConnectionGUID: neOpBx7xR4ejknjBHkNdjQ==
X-CSE-MsgGUID: UUBfuSZUSouZm3yAOmlLmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28675956"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28675956"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 05:26:56 -0700
X-CSE-ConnectionGUID: Y8pJgdqtTt2LvKUjJ74RoQ==
X-CSE-MsgGUID: UrKk8DZKSr+ldRtq2ZJ0HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="86036646"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 05:26:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 05:26:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 05:26:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 05:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9katxXMTukvtylS554kFCNkMQg9PINWhZDQ7gXAnvEoDc+JZLcQw1pygK6vmEFtcc4N/fpYKh+s4DroEl3aDmXKgR+YWx7cYG3PRt7Oh/IGdoNim/OQWNVqkdCVD6dwD6ZGqA5ygN6Qsdx8F2UXOx+7N296P6/FH1RGoMS8iWmdp1MZWYNztqKT/MkleHngOZopTm6Dv3GGCdAYCLN4BvvWk2Twu16IOTt5fw7A85UtmkWFPy2WtgnJkkyi/oGlQKglVlx6P6FuejApwORoZYMWF05k81lt3bDdLpICayydZeeyfKP3RbuNf6FFyvexN+0nw17rytQsPvrRBTfZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTo2sp7VnYgSG3tQyVWt5DuhHMe0NhTzykyGeUz4FVI=;
 b=KTGNN2LyPz8ateP6FCYp/9rPSBD+0tv0W0bMR+yTS5DNnk84PF4JfcDxilSO5neud42HAhNtPj06cqXfxGDS6bIakLgIkBL8FsREPyarwfU9Sz01UBCeEc2yuBu5fAiJ4S2hROsQ1iYUWSfaG0FQVZUShPztJTUc/va6AN1DfemdPccZdhKT09Zzt9IdHl/mTKcPXaK50FJXQyYput1euPO8i5tvvE+//V/gxcNT67iPu7OY43RWvY3Tnixxb9wK7Z4LdOe1wrqI0bqPVvSLQTuE8qww1TbJU6DzVwmDkKusqy8Rs7ekDTh64uzbm1NzNTtMFkdSpglmy+7maxCGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 12:26:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 12:26:52 +0000
Message-ID: <28205ad0-71fd-4cdd-9525-9bf4fe402260@intel.com>
Date: Thu, 11 Jul 2024 14:26:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] netdev_features: convert NETIF_F_LLTX to
 dev->lltx
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
 <20240703150342.1435976-4-aleksander.lobakin@intel.com>
 <668946c1ddef_12869e29412@willemb.c.googlers.com.notmuch>
 <e53db011-fe6a-4e63-b740-a7d2ff33dfa9@intel.com>
 <668bf4c48fd5a_18f88d2942f@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <668bf4c48fd5a_18f88d2942f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV2PR11MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 06009f5c-edc6-4422-d0f6-08dca1a4be4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG5hZjhHa0lDMmV0Q2c2YmlVQ0pTdlphK1pYRjFxcFBwcWNRZUdpaENBVWlo?=
 =?utf-8?B?NFBGQSszbXIzTTJOZlJNTE1Gdk14dnBOL1o0eUpPM3pXQlJQelpORjZqbkVx?=
 =?utf-8?B?Qnp6RDFBSEhnL3piNngrS0t1bFF0aUszS2JCRHVvMlVsSnBYYzBjaVV5Q01P?=
 =?utf-8?B?WTlEaFgramFrZmZ0dHBYRkFFMHB2K0RIS1h5SmhhL3AyWFp6NkJuenhOeXpL?=
 =?utf-8?B?cm5WbDBhRHpMaEhLTHlOeXd6Qk04M3Q3TWQ3ZzFBRkxGU1g2OERrV0dEc3dk?=
 =?utf-8?B?dzJCMC9UeFp6dHVoVXUzYTFxd1kreXdxQkR1aUdZekFPWG8wUEpkc2pJTlB2?=
 =?utf-8?B?VE1odmdubU1zTWZPZ1VTeFplZGxzSXFiNk9hblB4c0FFbFM2UkxZSHVRZnEw?=
 =?utf-8?B?eE01MVZ2aU5rZUh1bHBSRGZIVkJSYjF4V3lLRmlYUmpnZFdFUWFnKzhhejZX?=
 =?utf-8?B?S0pjWldvcG0xYU5KMWxQL292VVVmbnNsUnB2WmJMOTkzMkc5NDdXdldqaUEx?=
 =?utf-8?B?VnpiM3JYam1YRjBOU1pZV3YxRHpNSWl3Mkhzc3E5NHRxRGltWGNnK0NqdFpi?=
 =?utf-8?B?dVBWT29paEtDV2ZaTkY2R2g3WW5GVEtMZG4zNzdvUnAyQUVoWi9SRDFITlBo?=
 =?utf-8?B?SThNQ2FLRjZCZytpempLay9qcEg3L2Y5enlkZlkrQUJFMjQ4cFdQdTdJdFZz?=
 =?utf-8?B?a0NzczZ6NENaTHVaR1NwZDB6Nk9PclE1MjlWSnlLbGhYelp0dXU1dW1mT1FH?=
 =?utf-8?B?SjAwZEN6Q05Rb3NYU09rMlRkbHh0N1R0UThlT2NJYzlpb3p0cWxpVFBpWm9a?=
 =?utf-8?B?WW9zMFgrYmJEblpjeDEvN1B4ZFI1L0V6YmlKeFQveEZyeEdxQUNIaGZxdFM4?=
 =?utf-8?B?TGM1SVBzR2JVRVh5eFpiSndqSTRWVU1vbDFocW5jY1dOc2FRTlpGVnhsQUx4?=
 =?utf-8?B?ZFdYdnFOZ3ZBZXlUazNjRm5GWERkUVJ5cEdIRDZCOXIya1c3OUdaSXZmdmN6?=
 =?utf-8?B?QlVhdlZkWXZza0loeE9mMXdVZExZVHAvOURKWlpxemFNTU9TVFpCeVJ1TUpF?=
 =?utf-8?B?TGd6NnZzZE4xQkNEUUc1RWh4VzJyYlVIM3dHV0dpTDNMNG5HTGZLZDlXMyta?=
 =?utf-8?B?UEtUU0dGSk1jdjRSSEEwQkNCRlZwb0NWcU9Cb3BGYXNPM2ZaRXNFK1JyTjYw?=
 =?utf-8?B?elBoTzdpRDhLa0JtbEZCQXNJeGNGYlZxZXlRWkp3eHJ2NnNYODJwUjR0OWJM?=
 =?utf-8?B?ZFV3d0JrL3k1bC91alJXaXhqNHErdm9MOWgyLzBXRUQwU0RLZVR3bjdpTXlW?=
 =?utf-8?B?OHdvd3d2YXVtUnQwaDFkM2Evcy9QOUJUL2tHdUttQ2ZLWVlXSzAxZEgzaW5y?=
 =?utf-8?B?RDBLSUFQZitDZFllZTdBYVRVR0RYUzNCNDBQcHhsL1BJak9leGF6MW5UOStI?=
 =?utf-8?B?T3FVcnh6dklBbTh2NUkrK0Q5MWt6MWZLQ29VU3VzaDI1VzhKcU10M1JYMWo3?=
 =?utf-8?B?bEgzVnhvQUNUb21kNGgrMS9YSEtvVGRTeDhLQkUrQ08vOUhFN0gyVXIyYjVj?=
 =?utf-8?B?MkV2Nkxjc3c2YjlmZGw0OXZCMWpIUnc3QUt0VjdjeTN6YitKdTU4TWF1VkQ5?=
 =?utf-8?B?NlI4cDVQMUNWU3NIRmRWV0ZLYWNUZU5GMmpONTRsQ05hRFBQOWRjRHUyd0pt?=
 =?utf-8?B?N1ZkaDZVVWtpOVVLdXM4QUVtZjlQVG1JQmJxRFRvNVUrbHNSRTNZVkNwa1FX?=
 =?utf-8?B?T3lSbU0wY0t6d0JWSjZVbWE4bUZhNDVIdnFQTmFvUGR6cFpQdWJVZHBPZmZv?=
 =?utf-8?B?ODZFYWFjcVFTN1VzeVRTUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VPVkYvY1lJdlJxdHRhRnZSM2ZlUmRXajFrTllDU1oxazhCRjNlSVBSWVN3?=
 =?utf-8?B?Ny9CV3U5aVRrUkpOVDFOZkE0b29ia3h3dXpoOTdGTUs1a0l6cXJOWlBZQnYy?=
 =?utf-8?B?VlBEdzJEdzB3eElkSjdnWWtDaGVmSm1KeWFTUkhldHBscXlRSzhYd01NZzQy?=
 =?utf-8?B?R1BzLzdoOUpVZkRpdDhIU05NdGRwUjFjUm44d01xL2RJalNTQkU1VDhBczBG?=
 =?utf-8?B?WndCbDhnYUg4WEdzSTIvNWxaTWVYT3Y5Sk5JLzFpTmg3TjhnWEo2aEdUNjFU?=
 =?utf-8?B?d1dleVlMcjI0TDNNb1lRU05obEFtSlYyQVpNLzM5aE15akZRYVNKaUp0d3E1?=
 =?utf-8?B?alJ6aVRDNTVrWktJVnpBL28vMXZrTHdPWWZQVnFTR3h4UEtBNVF3ZDF6c3g3?=
 =?utf-8?B?a1Y3cWhtOUI1R0JURWUzRzhqR25kZUMvODU2azk3TjhrbjZ2TjBMbnYzYkRr?=
 =?utf-8?B?NDE3Q29xd0p6UHJxOFEwZm1kUnY3RmxBODFVblFYaTArUWRLM2hZOW1jSDhq?=
 =?utf-8?B?a3JTbk8zbTU4UFdZQ0lzMFY5R2M3elgraFNzMEVZOFl2RVFWOFN2RUNhbkw2?=
 =?utf-8?B?aC9LTTlHak1qdzlFU084OW1UVFhJY0Z0Z1RUU010ZGhPdGFTQWIvMGJJb3lk?=
 =?utf-8?B?WElucWNvVk43SXNLa1FFZmtxeTF2eEU2ZFNHakg1dTI4aE5rNHlJbjRSSVBR?=
 =?utf-8?B?bUJxS1VuM2hHSk50ZEtrUklzMzlJT05uV0daR3dPM3IvTUk2UGNHbFE1VmVq?=
 =?utf-8?B?UjNXOWQwQ2t6U3F1RGRHS1F3aWJYWFFLa0pjQThZcHNOV2FuU1l3aThtTGVm?=
 =?utf-8?B?NkZSMkFpLzZ5MlNhbmw5UXMvQW9HbFRCUzVjTnZuNXRCTnZhcHJvT3ZWY202?=
 =?utf-8?B?UGlBVWJVUU11NnRKbXFTelRLMlNrUm5Ha1dzNzJOaEtlWTFhQk9sbFBXajlR?=
 =?utf-8?B?dGxpQ2pkVlVUL3JOazV5ZTR0T00wd0lZaVJqZW02UDBvVVlhYUNjMEYvOTIv?=
 =?utf-8?B?azF5YWVudklFL1BnZUl2ZDJMSngyMStTTkRwMEZPdkxqQldjZXdycDcvbDBr?=
 =?utf-8?B?M0pDUGluZlg5S0g3Y3BCdzh2SXFPMytTbG1DVEFnelZwRWtQZm1jenVPUis1?=
 =?utf-8?B?SVl6WUhyemR4bkpZektXeDNuVlB0Y0t2aVlwcWVBZzJBbmJPYjNJZmEyTUJq?=
 =?utf-8?B?RXgzekJCKy9pUWtlKys2ZVQ0Vi9Qd3RhTVVXZ1hNZEJSaHhZOHJybUJDUkJr?=
 =?utf-8?B?ODFyMmNHZWo2R0RwUXB2MkVjUE52MkxzZW9ZbFA5TkNYVFdyalYrcGltUVV6?=
 =?utf-8?B?OExPRUdZeFRBUXlwNnBHMHgrdWZMdzFjWGpELzVOa0k4Mjcxc3N2OEhHR1Fy?=
 =?utf-8?B?RUxWU1Qva21haFNkRGJuWEwrdWtqU3Zxb3pkRmJZS3JJdlJSdkNGUS9UYlRI?=
 =?utf-8?B?YldUeERLT2VETElMS2tCdWhqSjh6ZW03TGx1bU1ocGNUUitrYmwvTEs0WlBj?=
 =?utf-8?B?UEZNWDUxb1JjeTZ6Yll5S2NvUTNwOGNGdXdMYjN4T2lOaXhOM0NDU25STjQv?=
 =?utf-8?B?aDNGeDAxV1ZUc2VHdlg2QlR0Y1RENFIvU3NZTTVWL3haUjJaelFzSlgxaHNQ?=
 =?utf-8?B?WnpnbVRKcHlmc0VwR0hRVU8zL3F4MGVHdzJ4Y3lDVnRnMVZuaFB4VmJPcW1k?=
 =?utf-8?B?UklpeE1hK21QZVJtRFRBbHkwYk1IRU9LZzZqeXBhcWVaOTNUSFJQcEFHcDF6?=
 =?utf-8?B?V0VZbFNtYURaK3gxYnlsQWNGMjNmNy95T0FXV2kvUGRkZGhjbWVzb3pCOS9y?=
 =?utf-8?B?L04yYmE5ZjdPcTVaRVN5a0t6S0MyMDNBbXIvUmpxODRma1hCZmtFR2o2L2da?=
 =?utf-8?B?ZUJjRWIvcXFTRjZhOGl2b1ZrdG4vT2FMZ2IyQ2pDZGt6OS9udWRBK2lVMERB?=
 =?utf-8?B?OW5RenkyWjBOTmovUXovSlpYS011eFBna25oTkJJK20xMkJRMEpuOFpFZ3hQ?=
 =?utf-8?B?NXdVREFEOFMxUFNpMHl5aVc2Q09rWDI1RXROcXJwMVVFd25wdWJPMFNpRE5l?=
 =?utf-8?B?ckpPRi9tZTVPNW1EcXNMTXZJaWhXTmRlUk5qN2FBUXB6NzhhR3dlbXh6bW1P?=
 =?utf-8?B?aTJRSHRVK0NrWFpkN0FUdTdBR1hucWpyYmI1OU9HcVdlT0sxZDhuNUpCTDND?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06009f5c-edc6-4422-d0f6-08dca1a4be4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 12:26:52.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQVCBf+oBxcIrTZ5d3ZdknV/GheJ1MYIIjgFyMRZG9mVZkGQDSp3PmBZ8PlXy8mE7HdU0eas07qAj6bKL1y/zJqBVIWc8rsBXV4xWTopfG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 08 Jul 2024 10:16:36 -0400

> Alexander Lobakin wrote:
>> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
>> Date: Sat, 06 Jul 2024 09:29:37 -0400
>>
>>> Alexander Lobakin wrote:
>>>> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
>>>> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
>>>> Free one netdev_features_t bit and make it a "hot" private flag.
>>>>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> [...]
>>
>>>> @@ -23,8 +23,6 @@ enum {
>>>>  	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
>>>>  	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
>>>>  	NETIF_F_GSO_BIT,		/* Enable software GSO. */
>>>> -	NETIF_F_LLTX_BIT,		/* LockLess TX - deprecated. Please */
>>>> -					/* do not use LLTX in new drivers */
>>>>  	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
>>>>  	NETIF_F_GRO_BIT,		/* Generic receive offload */
>>>>  	NETIF_F_LRO_BIT,		/* large receive offload */
>>>
>>>> @@ -1749,6 +1749,8 @@ enum netdev_reg_state {
>>>>   *			booleans combined, only to assert cacheline placement
>>>>   *	@priv_flags:	flags invisible to userspace defined as bits, see
>>>>   *			enum netdev_priv_flags for the definitions
>>>> + *	@lltx:		device supports lockless Tx. Mainly used by logical
>>>> + *			interfaces, such as tunnels
>>>
>>> This loses some of the explanation in the NETIF_F_LLTX documentation.
>>>
>>> lltx is not deprecated, for software devices, existing documentation
>>> is imprecise on that point. But don't use it for new hardware drivers
>>> should remain clear.
>>
>> It's still written in netdevices.rst. I rephrased that part as
>> "deprecated" is not true.
>> If you really think this may harm, I can adjust this one.
> 
> Yeah, doesn't hurt to state here too: Deprecated for new hardware devices.
> 
>>>
>>>>   *
>>>>   *	@name:	This is the first field of the "visible" part of this structure
>>>>   *		(i.e. as seen by users in the "Space.c" file).  It is the name
>>>
>>>> @@ -3098,7 +3098,7 @@ static void amt_link_setup(struct net_device *dev)
>>>>  	dev->hard_header_len	= 0;
>>>>  	dev->addr_len		= 0;
>>>>  	dev->priv_flags		|= IFF_NO_QUEUE;
>>>> -	dev->features		|= NETIF_F_LLTX;
>>>> +	dev->lltx		= true;
>>>>  	dev->features		|= NETIF_F_GSO_SOFTWARE;
>>>>  	dev->features		|= NETIF_F_NETNS_LOCAL;
>>>>  	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
>>>
>>> Since this is an integer type, use 1 instead of true?
>>
>> I used integer type only to avoid reading new private flags byte by byte
>> (bool is always 1 byte) instead of 4 bytes when applicable.
>> true/false looks more elegant for on/off values than 1/0.
>>
>>>
>>> Type conversion will convert true to 1. But especially when these are
>>> integer bitfields, relying on conversion is a minor unnecessary risk.
>>
>> Any examples when/where true can be non-1, but something else, e.g. 0?
>> Especially given that include/linux/stddef.h says this:
>>
>> enum {
>> 	false	= 0,
>> 	true	= 1
>> };
>>
>> No risk here. Thinking that way (really sounds like "are you sure NULL
>> is always 0?") would force us to lose lots of stuff in the kernel for no
>> good.
> 
> Ack. Both C bitfields and C boolean "type" are not as trivial as they
> appear. But agreed that the stddef.h definition is.
> 
> I hadn't seen use of true/false in bitfields in kernel code often. A
> quick scan of a few skb fields like ooo_okay and encapsulation shows
> use of 0/1.
> 
> But do spot at least one: sk_reuseport. 
>>>
>>>>  int dsa_user_suspend(struct net_device *user_dev)
>>>> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>>>> index 6b2a360dcdf0..44199d1780d5 100644
>>>> --- a/net/ethtool/common.c
>>>> +++ b/net/ethtool/common.c
>>>> @@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>>>>  	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
>>>>  	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
>>>>  	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
>>>> -	[NETIF_F_LLTX_BIT] =             "tx-lockless",
>>>>  	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
>>>>  	[NETIF_F_GRO_BIT] =              "rx-gro",
>>>>  	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
>>>
>>> Is tx-lockless no longer reported after this?
>>>
>>> These features should ideally still be reported, even if not part of
>>
>> Why do anyone need tx-lockless in the output? What does this give to the
>> users? I don't believe this carries any sensible/important info.
>>
>>> the features bitmap in the kernel implementation.
>>>
>>> This removal is what you hint at in the cover letter with
>>>
>>>   Even shell scripts won't most likely break since the removed bits
>>>   were always read-only, meaning nobody would try touching them from
>>>   a script.
>>>
>>> It is a risk. And an avoidable one?
>>
>> What risk are you talking about? Are you aware of any scripts or
>> applications that want to see this bit in Ethtool output? I'm not.
> 
> The usual risk of ABI changes: absence of proof (of use) is not proof
> of absence.

Ethtool/netdev features are not ABI.

Shell scripts are not ABI and we don't maintain backward compatibility
with them as it's simply impossible to satisfy everyone and everything
and at the same time move forward.

> 
> I agree that it's small here. And cannot immediately estimate the cost
> of maintaining this output, i.e., the risk/reward. But if it's easy to
> keep output as before, why not.

Because it's not a netdev feature anymore, let's not confuse users and
print unrelated stuff there.

> 
> And hard to say ahead of time that the argument for dropping lltx
> applies equally to subsequent bits removed from netdev_features_t.
> 
> Alternatively, please do spell out clearly in the commit message how
> this changes user visible behavior. I did not fully understand the
> shell script comment until I read the code.

Thanks,
Olek

