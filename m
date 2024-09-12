Return-Path: <netdev+bounces-127930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E524977151
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0312B24D38
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5C1C1AB5;
	Thu, 12 Sep 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XW1SJUT1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51C1C2DA8
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168357; cv=fail; b=UCca2BcA8Ee0LoDENh8LN3SjxeccrhZJ5/xDyk41YJUJiFJhm6Tc1zgGy5Q91Bzq3YuQMcdKNIZilMnzEjiNNVG1fdk+hPxzhxeD6Eq9ZLEUerWqq8QSWonTpGRbzNW7KeaLq7vt0thUucfEwPpFcVTHOkXnSLyZqkIVXVMZFWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168357; c=relaxed/simple;
	bh=R/N9iFw1smkXLNNUPvv7beO3yaEzJcSaD7u73lUml/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dXxy7P4r0W9Yb9+Ly5nMXOmqVbW4BZV+n7EfyZU7mjfJ5DlwZNc4L0fBTgg7oISufM3K53NM+ar3pQqxj38EcLlARBP+O6KPna5ae4Kai50JaL7lTrwS4eI0Rb2Z7rphF3bgRJhqQbKs8oQT6vBiuIR/ZYut6pJz5QS/cZm9bok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XW1SJUT1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168356; x=1757704356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R/N9iFw1smkXLNNUPvv7beO3yaEzJcSaD7u73lUml/s=;
  b=XW1SJUT1EAanKboN1Xj9X8cRpNQLxGMPyZq3+IikOVczUV13nGrrpt9D
   iWRnQUUe2BCOo1byKX3MRZHMM7VVKajrROZZXNy4Ot+9sR9nOzO/lY402
   SsDUC3xdshTDQL1XIE/HOL9xv0mVJw6SDULFNaaAp7bSjPLVSiSZGCLBI
   6RqOaSiGNdHaB03ZoE64D+/QmNIeEAz3XORTy3rH6Md7Ro1dSVmaP23HC
   t17Zmb+tIT3irqbaIDf5iwsUx99Hyu+bdZ0Hjm5G1s08XQqAtrB/PCC5A
   geZb0EXa1qRP6jgw9TxjbHbqHE8Mj2ta5Y7SpqtkRrRR6EeuLlxhpAejC
   g==;
X-CSE-ConnectionGUID: QYwroVpFQAO6d7GL6uIuhQ==
X-CSE-MsgGUID: xFOaaoHcRqqKurUQLOYaJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36395860"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36395860"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:12:32 -0700
X-CSE-ConnectionGUID: qY5xpIFuSeCnq/ZNg5b2pA==
X-CSE-MsgGUID: lTw36mm4QaWXbMXUDLJJ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67516256"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:12:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:12:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:12:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:12:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:12:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ8d3/qk4a0aL9NNspIBW5ToLPuhzDpl7tAOHZS0NVmcr6jEh31gKctSNWgRmLDTkYS8m1CnQaZ0gJVbCsTLTUEI/JAbt4t0NTpHuI2DO70tCZanhQm0BF06rn8q0W23bMVhpRNMwQZbzqNMlwXw/+5V0HuZ1MW6OVHG7UmmT/Su7XXU4EmPxmndZCCEZqjiDMMsFooQ3sk39pM637hi910Y7EZ53dYDfaQ2p1Y7BfIrmEiXhSSHE2b7xIIG75x/AabjgkzfCzE3a/hjuVpVvxhTO6Rzas5+n861TdM1SF6Bdvqc/vF9F/G5cLPfCa6KwcxM9QSIYPxwxTGRBCFkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NBv9YB60Yp6T05JE2UFuougYDTipwJcuyMKoF39NcM=;
 b=SMyz9227doBuQ/RCDv377qDpmbCQmUE5XaTSX6Mj4z6bJXMl0J7I33HsvQLvpsP+qCXYjgh9Ui6tVZNEwIbhvfj5aRHcL6LEv8HdbkvP8NkB3rv8/GRYG7TskBL3fqzHT6tcNXQAZIqG9G5WGNSfJ9/VaYy2GUghts16GECoUts6C4sGST38gMjEVtoUi+ufQNZutqt6s+zWFLVJpggIygye+bAok1/n9B7ZpaxpkR9WAAqmOG8zTc08U8EW4uYnCxoPbR284Y0oI+SeKe9eE3uNlmdjdI9UnLybDUaO6Y+DUu1Lud1bNCGU9tL5zAAXmkhA9vfZqHgJDhiekJEjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:12:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:12:21 +0000
Message-ID: <69f6b954-7f88-43b3-9b74-c9249a7c6ff3@intel.com>
Date: Thu, 12 Sep 2024 12:12:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 10/15] net/mlx5: Add support for sync reset using hot
 reset
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-11-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-11-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:303:84::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 70266b4e-74a2-4f0e-6d2f-08dcd35ed3e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N01zcVpSMHJ0Tk1xcVJBWEFIbmJ6MWlvSTM5YnNRaEtKMktpcnlmdDh2NFVP?=
 =?utf-8?B?cVJoNmIrUmZtVWE3bGVyd0ZyUERpOGUrajNvZ1hicjlLbUJUSzZoRXRXb0Q1?=
 =?utf-8?B?MENPekJxVjErbEVOclo3TEpnVk1PeGVHOWE1NGNuZEIxci9YZ1UxRG84V1FU?=
 =?utf-8?B?alZwMXVJS1ZvT0JVTFRZcHlIaGo0d25URlFRY3dqMUliN3ZvNUplY24rVHNN?=
 =?utf-8?B?WEtQY1ZUVG8zQy9xZGZBTzJVaFVoWU5PMFNPV1R4Q0FxeVVpM3dxeS9uS2ow?=
 =?utf-8?B?ZjRaNnljMEN3b2piNzRieWlUMVc0NHh2dUk2bENuOHhmZ0VhenQrQW1lRGZM?=
 =?utf-8?B?VTh5MnBmM0IxQnJ2OW9YeXJsZ2FBLzcxdDBBUXBPY1BQa0dJTzNuNy93NWFW?=
 =?utf-8?B?NW9jMi8wNm9DMXowcWhHN3ZsRkljQmRYUld4ZldtaTdadUVSZlBvSWRBMlh4?=
 =?utf-8?B?V3J3TnA1OW5KaEpuMG9JUXJLbDVaa3FCb05rU1d2dnpoaENFTEJwUUtzY29G?=
 =?utf-8?B?c25ZVE9oK0hvYXY2dTV0MFFNajBhYjZabXpyaFNnTHFIb09LR2VUS3ljcUtM?=
 =?utf-8?B?Qm1lajl5czJPZHBDL093ak45MVg3SloxU3YvT2ZHeGwyYjJKOGtKYjlNR0s0?=
 =?utf-8?B?K0xQdXkwUVlKcHNiTEN2anBDd3dkbWRuQ0IwUE4vdzk1VHJZZW03T2xINUpa?=
 =?utf-8?B?QXJkdWV4U1gwMGZEQ05oTzBHUGNiUGxhbVYzOUlldGh6bmRLV1d6SkVZelJS?=
 =?utf-8?B?ZGRQN0E1M0Y4RSs2QVRQcUpFOURCbjJnaUhFRHM0UjluMm91RUczN25nMzlN?=
 =?utf-8?B?bmgzZTQyM3JhMzh3OUVuTEhUc3l1S1lSMS9kbGt3SEdST01HZWZtaWJNcWxJ?=
 =?utf-8?B?Tm93UlpuSzY0Q3YyWlliOHdIcFAxUFVUV3kwY3F2cDFiOHllS3dzcDFJS1Vr?=
 =?utf-8?B?U0NGaGR2MXRYd09NWlo0Z05CZVllckhKWmlxb0dTNWZEMVBYdVJ0U0RmV1l2?=
 =?utf-8?B?Y2xPM3VKNDg1a0x4NDJUM3NrRG9HOFhaUWNSTm5uY0hKQU9jemlTTWpKNE02?=
 =?utf-8?B?bE40RWhhNms0b1AvV1k1cmtkeEUvMHFuSmQ1N0pRc2VlbzBvMVpTTzQyYURx?=
 =?utf-8?B?emRic05SV00xTFRPNEhJb0FCRkEwc3IxN0R2a2xVQ3cxM3ZoOFkwakJPdU1v?=
 =?utf-8?B?UlFzUXN6QkVaV3NpY2lubUhlaW1DNDhCN2RjZlhVVUxSdG1VYy9KbTNpVEJG?=
 =?utf-8?B?am83RkRMd2xYbXM4R0kwTWQzem5maDlpTm4zejIrWVdpaWRVYmovWUpsUk5v?=
 =?utf-8?B?Z1BVNkZzZ0ZKeGdRZnk5ZVY5UFJhOTU5eFc0cnI3aDZFbXJxSHBWZHN6WkEv?=
 =?utf-8?B?TXZSOGZGR216MkxHcGpJUzNYY2NNa1ZOeFVzQzRvckZNNkNsdzhWM3dpTTM4?=
 =?utf-8?B?NmlBNFdjNGZyMHptTUNtWGk5MDFvanNSVE1VRVF6VVNUb1N6cndyRThSMGZn?=
 =?utf-8?B?Nk51WlJ2S2xtRDhMWDRST0RUUVhzUGloZENRY2xxRW1QTndGZWRMZ0hpb0ly?=
 =?utf-8?B?dDdmZitrWGgralhxa0NzUzB4RHpYK3NyM1hHRUlvNjc3cGJGYmlGeGZ2THJS?=
 =?utf-8?B?c1oraUZNckFJS3RxVURmS3lVS0dseGlGdFdoNWh4dFdFVkNUa0RaeW55aDZw?=
 =?utf-8?B?MVEvZCtHR0RmS2p4bXhud0MxWk92M0lvb3pZMzZTcVNTRHZwdWNuendHTnZD?=
 =?utf-8?B?ZHY1bmZoYUhrcUQ3bXgrZ3F4MXpQUWx1K1BRbC9sMUdmMlV4ZDFLeU9tSVVr?=
 =?utf-8?B?WFNSbGJJaHc0Y2g0WWtqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lKTDVvZXJVd0pHSEVlMEFXQ1MyVVlBdFduZEx0cEg1WnRGcmt3aWM3YXVn?=
 =?utf-8?B?QS9PWVV2T1EySk42MXRHNkNqOThEUEgrTi94QTFTYmhRYkthNXBpbGNya1Qr?=
 =?utf-8?B?b2dNbGZOdjJ6anAxSkNxTDJ2bGVWYmNBWVRQN0xuWS9Zank5WEpvSjBSVWtT?=
 =?utf-8?B?Q1NjSGcweVhPOCs1aGg0cG9VRkQweWd6SFQxaUZnaHR5Ui9JOFpYbG9kZkFX?=
 =?utf-8?B?eHMvL2pZb2lYYTZQR3VnSVFFdHN1NzJMeWdQQzc2TEtXK1FjbVRkSVgrdUpt?=
 =?utf-8?B?dlM1MjVxbnV3dHlmRG1zN3NSd2FwSmhDMEdpYnZCb0syQWNXNnJLcm4vZ0V5?=
 =?utf-8?B?RDZXVFdlWm5URllZcHF1c0hDMU9DU3ZoSERCYUJJbjZ6RUd3NE9zenRicGN5?=
 =?utf-8?B?WW9Wc0ZrM1dsWkNDWFAyVkpONjArbmd0THMwUnJRWnl6M0RPMHN4cnM0Umh1?=
 =?utf-8?B?Z29ZSkN5MGdqN0I5enliUWtuQVV5YU04QzQ1bEQyeEVpVHZZWjYyVUpLVTg2?=
 =?utf-8?B?RTRJNEhNRENDbnhzeGdRSGN1OFRaSHlhS0Q4cUxmY0dHL1RkYmE1SktaSjdh?=
 =?utf-8?B?MW55b2o1Qm1Va2F3ODdFTVlveEtiNzBRblBKb0VoclZmREJuUjNUNzE4cEVN?=
 =?utf-8?B?OEUzcWl3MmhPbFd0SFp2UTUvaFpENytob0krd3Y5eFlndTI3WW53aU1pRjV6?=
 =?utf-8?B?UUFwUDRTVkczekd4cTg3eFZWUXgyTm5JWHI4Ukg4VGl4b01yZTJLbmx2TkZ1?=
 =?utf-8?B?eDlYdVRzVnpTMWlYWnE0VzFXZjFXcExDcDQ0bk5CVUE0WmJjUHczTHkyVGJh?=
 =?utf-8?B?RGNGbE0renBGQ3oyVVltd1FMRjRpK2k0K1U1WFhvejBnbDVlelJFNTBONGpP?=
 =?utf-8?B?YjNSRk5hMEdFaVlUNStUbXhuSjZuR0lqQVMxa1d3ekx1ZytWa2RwSTBxMTZo?=
 =?utf-8?B?UGRSOFZtaSsyQy9OSkRNdUlQOVJwNC82eDM0TTJSazhkcHFLYi91VWM0TC9U?=
 =?utf-8?B?ZUtmSkcxcGF6NWI5OSs5OUc4WFp3eXhsNUJyeFNJR0tKUFRaRkRQZHpOcGt0?=
 =?utf-8?B?RitmcEFBR25HUmgwWWJVNDBMQ2tjZ3VpbUpsL2Z4NXFSdmhsNFExTmZ1ZHNu?=
 =?utf-8?B?Y1RCOFpFSVRwOUtPclZOUEY5M0pHZ3c5TVNKSGhaNXQ3d2lkZ3dyOUU4aDVq?=
 =?utf-8?B?eXYvNE9yYVJYRzNFMGxaSSt2M3haZG9oY0svbVNzSUd4Q1ppYWVOQVNuMU0x?=
 =?utf-8?B?SjhMYXFNSXM3K1h3TUU3VHoycmVOV1lRWDY0VjZIM2pwR1grTm04a1hGbDF1?=
 =?utf-8?B?Z2FuMVdOVlJZYXo2dmovYWo2TkJTeXlSWlFPd2REK09NKzR5c1pWa1h1alEz?=
 =?utf-8?B?WkhjbkNtQnNDVW4zdVlLeWNOVTkvLzZJMFZuMi9Fay9hY095RWtxZ0VwQVha?=
 =?utf-8?B?bTBmSHprcFVITVNEa0FxVVQzVmZxNzAxWGVhUE4wQkdRZ0dzRk1Yd2Z5dHJJ?=
 =?utf-8?B?SytxcVZicGFxcDNYUzlMQkRRb2NVRXNnRFlhMWdWTXBKQ1hNWW9kbTdyMFNL?=
 =?utf-8?B?M3p4UkYxNXdJbnJjRW91WUFlR0JzZUtmcWtTWGFKdDR4bk44U045Wk1JcmNo?=
 =?utf-8?B?MUlpWExJZGJOR2pULzNOaGJkcTJMbG5rZUMzTVNValk0VyswaHlQc0V0UWF4?=
 =?utf-8?B?L3RYWmZHVGtWL2hNdmtnd3ZRam5ERkhIOFZHZVJNZ2w1OWllY2MzWnBOUGk5?=
 =?utf-8?B?dG14SEExcFJCdmVWUFNFNTJmVGtSbFI5MDZzb0VyZ2NkTHFFei96bWtueEtw?=
 =?utf-8?B?bDNNSG85K0swRWJ1SDRNZ1Z6OUZsNkt4MXhvQ1Z3WkZKeWdZTkFyNEZ0T3Vn?=
 =?utf-8?B?OE9JYXBmV1dZdmltdjNEZmlFQ0hyVkE5b0o4RWlwV0VKaUJWMk9rVzFOUGVm?=
 =?utf-8?B?U1R6MEVBcnkxdHpzbDQ3WVVaQ1o1Z2FIN3E3UVFaMnk4ZWNPckh5cEFXMmY3?=
 =?utf-8?B?U213bFlXYXRCcUtOQm5aeW5KUUNpUkRpZDhUZDdoNHF3TzNrUFQybktZcFY4?=
 =?utf-8?B?TkRhMURBSkhFM1VoUk9RNUpYVXNvNEl0b3B3dzIzUk9mdmNNd2duVkx6YTlP?=
 =?utf-8?B?RTl2WTF5MC9vSHR1QTk2ZFk5d3pRQXEvK08xTG1lZGkxMkF3Nm1taXYybnVI?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70266b4e-74a2-4f0e-6d2f-08dcd35ed3e9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:12:21.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jbcipm9Kuw3/P/Mv7yyLDvXsLC+OpI9GJdjbq9KPX7Ge6/RLsODOibC9J22EFOTLClGvoGvJw4Yld9pAR4jBN7JoaLlJmypVJMtbhU50jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> On device that supports sync reset for firmware activate using hot
> reset, the driver queries the required reset method while handling the
> sync reset request. If the required reset method is hot reset, the
> driver will use pci_reset_bus() to reset the PCI link instead of the
> link toggle.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

