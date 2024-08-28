Return-Path: <netdev+bounces-122965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98B9634AB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4911F22E06
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF01AD3F2;
	Wed, 28 Aug 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F72BTXG7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E381AC8AC
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883968; cv=fail; b=XqSeVJmVoVaokmPBkod6lL4gr2eEXv2rNjXlsFlov+0mTDokE7iqKC7d42zsEHPDzS2VTHoTqpBZWUCoSA6lDOKpknLelXFeSSm41WvAM/9Zxsemmz9TfWZKYLUMriA0pViCjJ3tlDjTrR1MiTwNesj+IuoHZ3Jdk8XY2exZYKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883968; c=relaxed/simple;
	bh=kjLjuRuTVZFxtjkztq+ynXWdDrRjvh/WRfVNnA/dIEk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHHBr5HjuLhlxw3azt+TojjhayNxMOXGc8qAENYxRHUY0P49uY4pIOF4rDlFZGZnYdKi9D1/xWmJYMX6k6nXfSKQ7NvzBttjS42PkDwEtxGbrC16F85xbswL1shBsK7B9V5N1Y35Ey3u4gvVCzAkZ8pVm2fOf2N7RhKarVzr/zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F72BTXG7; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883966; x=1756419966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kjLjuRuTVZFxtjkztq+ynXWdDrRjvh/WRfVNnA/dIEk=;
  b=F72BTXG7vDCKKNCyx3m5i4a1a4PMvwIVj17K6nAl8GMLDoPCoMRKJQVV
   YIDUQeE3zbKTMv8YlLKWc+ze1NEC7UPPVbAANY58tDoxR8Ism67dPVbW/
   OhVkLyZvA6vhMjzgVqJpJe8On3wp/ANEdo30cT5x10Krva/Of/BAiqwuI
   pLCC/Nola9RBX8Lb6rV9vPLkpSIcVWHpYPKQnxjAl3ozTBYajkhYbJVZ0
   LN61wJ62Wo/OARY/447ebON5VO9cUHwO69behkcICl8Wo8mupLygMDrs+
   7XA1SCaTR/9OeQRS46MSNqtA0FAXY19bhy3GvQcpAc7b1I231zFrGPesI
   w==;
X-CSE-ConnectionGUID: CkzZ8AFxSuqPJkgxWFNXYw==
X-CSE-MsgGUID: 8QinyvvRSvCbaA3sXdAYNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34103438"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34103438"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:26:06 -0700
X-CSE-ConnectionGUID: jYMSohoVRKq245BdCjBkuw==
X-CSE-MsgGUID: heNwgkmkTRGhkCpeDb59hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63556415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:26:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:26:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:26:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxXImLTzoCjuQhPR2bVl3b6pzZk27ISX9PTfrGmjXd/PbJYVqK9ZTxOX5bY5OW2ajk/duUicylAX6sKxJCQiNhtZKsKCtr6S2BEw9Z9VoESbHRheK6/3Sa8MKgWv+vRExF410VI5m580NS3kJK1h51Fyul4eBz7C39V2EVWlt4nMMdL+cY1aYTlSUQ97pJkNcOTKtatcMttz0XmvnGPLaIH6ffTNZ+uQA76Cnq4bV80fPk0V9tu3cMtzGbmxa+feyYIrNjIFuKQI5RO8GiRMZNeZjPrNDd283g+P4wPPGhsDGk/ZmP3i+ZP+8cwJOq35xrE5294cHbLT4Ms3hWfZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mmdSGgfNkiCQI9z4IByupoM66HsQufpcA6QG8diufY=;
 b=Y7Tg7104wWg6GCY4DU2xi+LwMVlTSnIMRr2gHWhaJJ1+lcriBBbLRNQMWRYq/0cKMwvjxkjI5NBz6WOXY0xi5EbYkn3Ry0isnUQbPvucArmIUyeFQ/ELRIKf4xMDSl8mffVYMwTFFKAfTV7rOdkcCIxor9inMGVVmc0yiagj01dSdXcBYML6rnMBFxK2ViY9r+JSkeND1O75zTyCPYFynG6+X9O506iXoCu9wrQu2wuDfhptkjjaQ9rsWumml4Ovd87U07kyHIVn3gqAP0PXjEXnNqk/2NTkae3iUUikHdG94thMkIKKcMMrVH7NJo6Ndrb4VAlfV09oAqlRIehvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 22:26:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:26:01 +0000
Message-ID: <97d55f4e-606a-4882-b977-be0df851baa9@intel.com>
Date: Wed, 28 Aug 2024 15:25:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] sfc: add per-queue RX and TX bytes stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <9695a02a3f50cf7d4c1a6321cd42a0538fc686be.1724852597.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <9695a02a3f50cf7d4c1a6321cd42a0538fc686be.1724852597.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 230e79ed-1aba-42d9-cb3f-08dcc7b0657c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUtGSmp5azJEUTZKVDBvQTJ3QnUwTHFSRnJITkpkUUI2L3EvU2hZYWFXanA2?=
 =?utf-8?B?WjZuMXlzUmVCbjZSNVpMeGpGZnJhTEJZTDlFNzU0K3hIdE9OOFdWZG4xUyt1?=
 =?utf-8?B?cGFyblJIaVVIdytoVWdFRllyZ1dIbHowYWtkSDlOTURFdklwdElWQU9ZTHp2?=
 =?utf-8?B?VER2ZWs5MlRZTjNkMkVOZVNhaXI5MjUyZFJMQXJsOUdoU1d3ci9QdUIyUkF3?=
 =?utf-8?B?aEl1RzBZaFd0K3g5OFBiTWNoVVE4VGY5aCtvc2o1KzZyZHpVeGRGZkRlSXNR?=
 =?utf-8?B?Nm9UVVVSeW1MVWJmYnV2aGw0d1c2eUFxd3lpTlRrZnhoZ0ZCZk90aWRlZ1lr?=
 =?utf-8?B?c1FQUFUyNGlzajlwL2haQTlBUkZKa09hbWlRNmFGY3REbmVkUTVFZEhFaGIr?=
 =?utf-8?B?dmNNOXF2eEhpZzRjREhUcDBPWmY4dTEySUZkbWlLWGRaVms0VlFHbUNzVExk?=
 =?utf-8?B?aWg0NUpaMVZGREM5eXNkcEIyeThybHRmVjlhVTQ5S01YYVpmQ0UxVXlJa3Rx?=
 =?utf-8?B?WkRJbVpxcUpOeHVWdi9RU05Wem10bVRCcEFIaHNvQnlhbGhRakxCaGZ5Q21o?=
 =?utf-8?B?YmRPck5QQ2hHSjhDMlBtNTk1WUdqdlRxcWFjQjhYWWgvQVV6NnNrNUpSTHds?=
 =?utf-8?B?eW9JZmpMb3l1amo3b3crR3A3ZjJDQVdxZFY0K3YyN3p4MHhBdVRyaUZlV2Jw?=
 =?utf-8?B?bXE1c3VBU014MGJ5ejQ2N3VJSDNYNFB0QlRHYjRMeXl6d0FHYkNuc3Ywd0Rp?=
 =?utf-8?B?S0cwSkRCRUtsQzRDUFRweHF5cXlRZGliQWZWK0EwTmNSc0lpQmx3VjU1ci9n?=
 =?utf-8?B?QmZMMVFMTlBhclM3dFNYb2FOOEJMWXEvU3p4LzFVazAxZnlCNU5lZVFSWTB2?=
 =?utf-8?B?cHNObEswUGU3aUszSUd2TmZYeWlqQ2pUV2ZRL0IzUjdiWVN5VGt1ZDMwai81?=
 =?utf-8?B?V1liM3I1ZEVXelFPMzIxOXFnd0RxeFc4em1pMnJJMW1xbXhKbzdrbU1aMXpq?=
 =?utf-8?B?WWpMZEJCa2ZxYU9ldzVtQktkQUdrZTM2VjY1UmNtRXVtaEtLYVFzRHFpMWN1?=
 =?utf-8?B?U1oyNHl0dm91MXdBNWVQUGVVUEFWbHhkdVpwclM4VXE3OWFITDdvR0VVYXE4?=
 =?utf-8?B?NnNMMkdhMUxqKzNLTjdzY3p2Mmh0bjdubkZsT0oveE12Z2drdUtxYnhGcnpV?=
 =?utf-8?B?WFZTeThGUzZuMkFVRmlGNVo4cHVDQWtoT2owMWQ3Z0lHcEhITmI1ZDZvYzlw?=
 =?utf-8?B?WTBPQzhxamFGeFdmaXY3Qk5uK0pSUTdXQWZxS0JpSG9aUFNodVZzdThiQ0VU?=
 =?utf-8?B?QjZ2WFZLOUhGZlBJOUN5K3NodmxuZ0hVaXpaK00vdlZONExYZkhQVUVJMzB4?=
 =?utf-8?B?T2ZDTzR0RHBYdEo4bzJkS1ZuYjBzQ0poSjNTV3VBbjZtb3VxOFJPKzNITHh5?=
 =?utf-8?B?YW14OG1JVmNpeFR5aS9rdmVQdStoeVFzOWFXTGIvT1B6c3FJWHU0VGtSVUJF?=
 =?utf-8?B?R2NNUFphak5SNkdITWdJRmdQT1hTN1dlMGFUbGt5WDNjSGhFZTFhUzdoakc1?=
 =?utf-8?B?M1NSTlhPZkNYMEwyb2x1M1N3dWZLdUE4TXJuUlpJenM0MnF2ZmZWSHpzaXV0?=
 =?utf-8?B?TEd3b0hIcnhwRFdyOVNvQjFSNTZRM3V3RVN3SW5wZFBEYk1ZV056eS84Tkxm?=
 =?utf-8?B?TzBVVWgzVGZiMWpPUmdlNmxkVlkxYXQvS2NRQ3NrQ1dhUEFPUFF5aUM5WW1i?=
 =?utf-8?B?dXNXOEtoTEMxQlJRUlVxbWRFbEYxbStlYnVISHBSTVlid0ZYTWZNdmxwdVNC?=
 =?utf-8?B?RVgyWC9QQnhGcHlueXBFUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFQ1NU5SZTVDNXB4c1Z5ZFpVcnhRY3d0REtTbXp3MjI3YmdmUjUxemRmSnVz?=
 =?utf-8?B?enhLTFF6VkxsSmt5Q2xodkJsWnBOSDBZandnWnlQYnVxM0xxWWpiZDJaSnhB?=
 =?utf-8?B?aXFnRWZyWHBqOFhiNVRyK0xGanQwbFFkYnNOSi9xQ0tsNVJQamZUcUc2RnQ0?=
 =?utf-8?B?SlJuWEszaUg5RDY4V1RrU1FVazVoRitKVjhVM1FZSnQvSXlta0k3OXVqdzhp?=
 =?utf-8?B?R1lYSUVXT043eXlxbnBEZzBuczZySVVTZDcybFc4Zk0zdWh5QndLNHgvbjRS?=
 =?utf-8?B?bC8wOS9wbWtqSCtScGRoZjJPWHRuSUd6aWwvbUVZWWY3eCtUQmZ3dkJuMDZR?=
 =?utf-8?B?akVyK0g0OFpsQ2lQTTkrZWdhVjRWN0VmTDRMTStTMzNtRUJMNGMycjQxWFJz?=
 =?utf-8?B?STZ0V2R3R0x1Yk53M280eUlQTUt6b0g2SndIOVZsNDdHa2VQZEhhVUJyajFB?=
 =?utf-8?B?MTREc2hFWEEyRjlKYmJJdXBDSHh2N2dBNS9RZmRuNnFTNEtMdGU1c255UjN4?=
 =?utf-8?B?RTk2bzV1ZG9La0JIOVhGNVY0UjV6YjN4Tzd3OFp5M3QwNEsxaVFNVndad2wr?=
 =?utf-8?B?YWNHZUVHNHhQRHg0Qzhvckpmak5IUk9YRVd3ZDVmN3MzakxtN21icGQrSzZG?=
 =?utf-8?B?TmdHRXNHQ3VoSnhodmppNDFyUUZNTmZVenBibWw5RFFwUjI0TENDZHdNekxZ?=
 =?utf-8?B?QUZSSTdCbSt5dVFlYUJGamRERHVTb0IydjFUZFd1eUNxWitCMWlKVStrN0Y3?=
 =?utf-8?B?b24zMmpiWFhGNitkOHlJMG9KRXJSNDlOc20xdFdNY1AyaWd5NWN3bTcrTm5t?=
 =?utf-8?B?L1BIelRmUnFGVVhyUVl3SkpnUTJLRi85UXVCWG1NZ1NOWnp4K1REOXY1Zksz?=
 =?utf-8?B?Um5TK043YnZQa1ZCa1lhQlV5cnlDZDJlakdBRFlzcVQ4ek1HRDg4ckUzSGZ1?=
 =?utf-8?B?OHVUeHZVMFJZS1RFdVFwN3A3UmdRR05DZ1FPa3FveTFML2dMcm4wOVRKQUx4?=
 =?utf-8?B?WFJyYWlTZWpDc1ZjVStvbWRLcUpJUHdpS1hwWjBFNW82bisxYjVoVTJQejY1?=
 =?utf-8?B?aXRXZWxoZmJMMkdnZ3dyUzc2c2dlT2VRdE1oWUlxVnRxb2hFemMvL0c0bDhX?=
 =?utf-8?B?K3FqUDdLYzE0cmJIajNyRFBjZnV4MkNuUXRKaWJqR0dxZ0M3djkreTFxOVky?=
 =?utf-8?B?SlVSbmMxZnFpR3AxamxzUVhHWjRZTVZ0NGNrRkMwa05YbytxMHE2a05VRVIw?=
 =?utf-8?B?MEVvOWU3L29mNG9oMzUwSEZuVCtkTW82czZDWlBnY1dDdXByd09vbGNLc0hn?=
 =?utf-8?B?WTl5cE5zSW51cG5MQjVtWXlNMDk3VWh2L09maUhGZ3NYbGdFWGRjL1ZERmFv?=
 =?utf-8?B?RDQvbG1hRGJTTEtaZHhCaE56S2tiVHpnK2FQSU9SS014WHJlK3V1MStKci9J?=
 =?utf-8?B?ZjJXWGVDbFRCdFNHUnZ2TlJoOExjTW1lSW9UdnZNbEx5cnN1YUo0WWowWmE1?=
 =?utf-8?B?TVZnVGFRRHh1Vk5vK3FsTHgyenlmR1JMYm9BTHd5b3VmTVpyZ2UwZUhBWkQ5?=
 =?utf-8?B?WHlWbTl4eVFnRzJJZk4zTkhkMzA4eXN0R2doajc5ZC9ZWEpEai9zQldzaUxQ?=
 =?utf-8?B?V1RjdkVlRzJpUTV0OWNMdXNwRGpyeVNCL2ZIVXNqMXhZNFh6U0xoV0NGV040?=
 =?utf-8?B?RWZHa2tOOEZmUzR3N1gzQWp2T1E0LzNMS1JZdmp1ek5VS3lwcEVTRGpNblZD?=
 =?utf-8?B?QXBYTDVDelZoS3Q0RWFuby80RWsrZTQ3Tk4xWFVlZE0wdGkzRmpNbHVrMU1v?=
 =?utf-8?B?Z2VMTDdhSmhjMWlzdEE2dWxsblY3TW82WW1NRVJwK2E4SWhkcFBpeU5uWlhX?=
 =?utf-8?B?WlFyTXlzMEJpa01Namp1RmJHT2lPMnVIRGlsYWtZdE1UMXpVQm0yWFk5RmZj?=
 =?utf-8?B?aXZuRnJzUEx0ZTVqR2pDcXlLOUdNSFY2aUU0YkYrUDd4QUpjVUtkTWhOSXNN?=
 =?utf-8?B?VUVLZ0l3dlFhM3VIWktSRHhEcXhkN0x5L1FTbjcxUWN0QXU4STdBZjVVaDdH?=
 =?utf-8?B?ejM0bWwvV0pRV3BhczhLSlNIQ3RLK3I4Ulo1T0xnRFpsZ1JLRTZIcVMydlB5?=
 =?utf-8?B?Q2oyMGRORzdqTEZ5OUpoUENnRlVHNW9ra1p0cUozUDZUQUp3Vk1qVDNtS1hM?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 230e79ed-1aba-42d9-cb3f-08dcc7b0657c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:26:01.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx3D7gJ3d6Nwt9lffhCx0aA//U/aUkDYuE3S+f/oemt48TSpzlnJm+8jIwhqhSE+teiViQwA/kZLAtu9ktaFbSmMkicEA467syJcEAhoj5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com



On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> While this does add overhead to the fast path, it should be minimal
>  as the cacheline should already be held for write from updating the
>  queue's [tr]x_packets stat.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Ah, the broken self tests from the early commit get fixed here. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/sfc/ef100_rx.c   |  1 +
>  drivers/net/ethernet/sfc/ef100_tx.c   |  1 +
>  drivers/net/ethernet/sfc/efx.c        |  9 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 ++++++++++
>  drivers/net/ethernet/sfc/rx.c         |  1 +
>  drivers/net/ethernet/sfc/rx_common.c  |  1 +
>  drivers/net/ethernet/sfc/tx.c         |  2 ++
>  drivers/net/ethernet/sfc/tx_common.c  |  1 +
>  8 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/ef100_rx.c b/drivers/net/ethernet/sfc/ef100_rx.c
> index 992151775cb8..44dc75feb162 100644
> --- a/drivers/net/ethernet/sfc/ef100_rx.c
> +++ b/drivers/net/ethernet/sfc/ef100_rx.c
> @@ -135,6 +135,7 @@ void __ef100_rx_packet(struct efx_channel *channel)
>  	}
>  
>  	++rx_queue->rx_packets;
> +	rx_queue->rx_bytes += rx_buf->len;
>  
>  	efx_rx_packet_gro(channel, rx_buf, channel->rx_pkt_n_frags, eh, csum);
>  	goto out;
> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> index e6b6be549581..a7e30289e231 100644
> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> @@ -493,6 +493,7 @@ int __ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
>  	} else {
>  		tx_queue->tx_packets++;
>  	}
> +	tx_queue->tx_bytes += skb->len;
>  	return 0;
>  
>  err:
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index bf06fbcdcbff..b3fbffed4e61 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -638,6 +638,7 @@ static void efx_get_queue_stats_rx(struct net_device *net_dev, int idx,
>  	rx_queue = efx_channel_get_rx_queue(channel);
>  	/* Count only packets since last time datapath was started */
>  	stats->packets = rx_queue->rx_packets - rx_queue->old_rx_packets;
> +	stats->bytes = rx_queue->rx_bytes - rx_queue->old_rx_bytes;
>  	stats->hw_drops = efx_get_queue_stat_rx_hw_drops(channel) -
>  			  channel->old_n_rx_hw_drops;
>  	stats->hw_drop_overruns = channel->n_rx_nodesc_trunc -
> @@ -653,6 +654,7 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
>  
>  	channel = efx_get_tx_channel(efx, idx);
>  	stats->packets = 0;
> +	stats->bytes = 0;
>  	stats->hw_gso_packets = 0;
>  	stats->hw_gso_wire_packets = 0;
>  	/* If a TX channel has XDP TXQs, the stats for these will be counted
> @@ -663,6 +665,7 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
>  	 */
>  	efx_for_each_channel_tx_queue(tx_queue, channel) {
>  		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;
> +		stats->bytes += tx_queue->tx_bytes - tx_queue->old_tx_bytes;
>  		stats->hw_gso_packets += tx_queue->tso_bursts -
>  					 tx_queue->old_tso_bursts;
>  		stats->hw_gso_wire_packets += tx_queue->tso_packets -
> @@ -680,9 +683,11 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  	struct efx_channel *channel;
>  
>  	rx->packets = 0;
> +	rx->bytes = 0;
>  	rx->hw_drops = 0;
>  	rx->hw_drop_overruns = 0;
>  	tx->packets = 0;
> +	tx->bytes = 0;
>  	tx->hw_gso_packets = 0;
>  	tx->hw_gso_wire_packets = 0;
>  
> @@ -693,10 +698,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  		rx_queue = efx_channel_get_rx_queue(channel);
>  		if (channel->channel >= net_dev->real_num_rx_queues) {
>  			rx->packets += rx_queue->rx_packets;
> +			rx->bytes += rx_queue->rx_bytes;
>  			rx->hw_drops += efx_get_queue_stat_rx_hw_drops(channel);
>  			rx->hw_drop_overruns += channel->n_rx_nodesc_trunc;
>  		} else {
>  			rx->packets += rx_queue->old_rx_packets;
> +			rx->bytes += rx_queue->old_rx_bytes;
>  			rx->hw_drops += channel->old_n_rx_hw_drops;
>  			rx->hw_drop_overruns += channel->old_n_rx_hw_drop_overruns;
>  		}
> @@ -705,10 +712,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  			    channel->channel >= efx->tx_channel_offset +
>  						net_dev->real_num_tx_queues) {
>  				tx->packets += tx_queue->tx_packets;
> +				tx->bytes += tx_queue->tx_bytes;
>  				tx->hw_gso_packets += tx_queue->tso_bursts;
>  				tx->hw_gso_wire_packets += tx_queue->tso_packets;
>  			} else {
>  				tx->packets += tx_queue->old_tx_packets;
> +				tx->bytes += tx_queue->old_tx_bytes;
>  				tx->hw_gso_packets += tx_queue->old_tso_bursts;
>  				tx->hw_gso_wire_packets += tx_queue->old_tso_packets;
>  			}
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 2cf2935a713c..147052c1e25a 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -233,7 +233,11 @@ struct efx_tx_buffer {
>   * @cb_packets: Number of times the TX copybreak feature has been used
>   * @notify_count: Count of notified descriptors to the NIC
>   * @tx_packets: Number of packets sent since this struct was created
> + * @tx_bytes: Number of bytes sent since this struct was created.  For TSO,
> + *	counts the superframe size, not the sizes of generated frames on the
> + *	wire (i.e. the headers are only counted once)
>   * @old_tx_packets: Value of @tx_packets as of last efx_init_tx_queue()
> + * @old_tx_bytes: Value of @tx_bytes as of last efx_init_tx_queue()
>   * @old_tso_bursts: Value of @tso_bursts as of last efx_init_tx_queue()
>   * @old_tso_packets: Value of @tso_packets as of last efx_init_tx_queue()
>   * @empty_read_count: If the completion path has seen the queue as empty
> @@ -285,7 +289,9 @@ struct efx_tx_queue {
>  	unsigned int notify_count;
>  	/* Statistics to supplement MAC stats */
>  	unsigned long tx_packets;
> +	unsigned long tx_bytes;
>  	unsigned long old_tx_packets;
> +	unsigned long old_tx_bytes;
>  	unsigned int old_tso_bursts;
>  	unsigned int old_tso_packets;
>  
> @@ -378,7 +384,9 @@ struct efx_rx_page_state {
>   * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
>   * @grant_work: workitem used to grant credits to the MAE if @grant_credits
>   * @rx_packets: Number of packets received since this struct was created
> + * @rx_bytes: Number of bytes received since this struct was created
>   * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
> + * @old_rx_bytes: Value of @rx_bytes as of last efx_init_rx_queue()
>   * @xdp_rxq_info: XDP specific RX queue information.
>   * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
>   */
> @@ -415,7 +423,9 @@ struct efx_rx_queue {
>  	struct work_struct grant_work;
>  	/* Statistics to supplement MAC stats */
>  	unsigned long rx_packets;
> +	unsigned long rx_bytes;
>  	unsigned long old_rx_packets;
> +	unsigned long old_rx_bytes;
>  	struct xdp_rxq_info xdp_rxq_info;
>  	bool xdp_rxq_info_valid;
>  };
> diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
> index f07495582125..ffca82207e47 100644
> --- a/drivers/net/ethernet/sfc/rx.c
> +++ b/drivers/net/ethernet/sfc/rx.c
> @@ -393,6 +393,7 @@ void __efx_rx_packet(struct efx_channel *channel)
>  	}
>  
>  	rx_queue->rx_packets++;
> +	rx_queue->rx_bytes += rx_buf->len;
>  
>  	if (!efx_do_xdp(efx, channel, rx_buf, &eh))
>  		goto out;
> diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
> index bdb4325a7c2c..ab358fe13e1d 100644
> --- a/drivers/net/ethernet/sfc/rx_common.c
> +++ b/drivers/net/ethernet/sfc/rx_common.c
> @@ -242,6 +242,7 @@ void efx_init_rx_queue(struct efx_rx_queue *rx_queue)
>  	rx_queue->page_recycle_full = 0;
>  
>  	rx_queue->old_rx_packets = rx_queue->rx_packets;
> +	rx_queue->old_rx_bytes = rx_queue->rx_bytes;
>  
>  	/* Initialise limit fields */
>  	max_fill = efx->rxq_entries - EFX_RXD_HEAD_ROOM;
> diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
> index fe2d476028e7..1aea19488a56 100644
> --- a/drivers/net/ethernet/sfc/tx.c
> +++ b/drivers/net/ethernet/sfc/tx.c
> @@ -394,6 +394,7 @@ netdev_tx_t __efx_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb
>  	} else {
>  		tx_queue->tx_packets++;
>  	}
> +	tx_queue->tx_bytes += skb_len;
>  
>  	return NETDEV_TX_OK;
>  
> @@ -490,6 +491,7 @@ int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>  		tx_buffer->dma_offset = 0;
>  		tx_buffer->unmap_len = len;
>  		tx_queue->tx_packets++;
> +		tx_queue->tx_bytes += len;
>  	}
>  
>  	/* Pass mapped frames to hardware. */
> diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
> index cd0857131aa8..7ef2baa3439a 100644
> --- a/drivers/net/ethernet/sfc/tx_common.c
> +++ b/drivers/net/ethernet/sfc/tx_common.c
> @@ -87,6 +87,7 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
>  	tx_queue->completed_timestamp_minor = 0;
>  
>  	tx_queue->old_tx_packets = tx_queue->tx_packets;
> +	tx_queue->old_tx_bytes = tx_queue->tx_bytes;
>  	tx_queue->old_tso_bursts = tx_queue->tso_bursts;
>  	tx_queue->old_tso_packets = tx_queue->tso_packets;
>  
> 

