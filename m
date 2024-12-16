Return-Path: <netdev+bounces-152077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989C9F29A6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 06:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA84B1882F23
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FFC192B70;
	Mon, 16 Dec 2024 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyHQO3Da"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F921422B8
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327536; cv=fail; b=XRwZYkwZzOIQgSG7/4kW/vIrCsWHPwmRroXLQsiWJCUjI5nGcnMlsPGsRBQLdvsYJIMMfU0pFkhxJWgS4ttLI/Qg9FXt/rNSeRx/Ymkbml7p9ZlaBIG4cEi4wrjxm1qafFfbmQh9KfMPrwg1hmTHoRFLxbSOyXBOHpPPJw5euyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327536; c=relaxed/simple;
	bh=ILTcKjx7O4qnqucwCR7BhyYsKUtx4d2uw0o9U5GDJDY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eqtg74pCEtcowWn0QbOZEz/zApDN/uu9d/GBlmJVi4WECARLf1iJ3h9VebsaRmDBjuYihaGgw5CxW0rBQKwixsq26N/XErKxAQ0L9LC00aS6HnrdmuKXFpRgSrsIu6XYoqlsuTIZL6ZQ3fSFC7k8rPCPmAA69B6kH/pXOWZbaTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyHQO3Da; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734327534; x=1765863534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ILTcKjx7O4qnqucwCR7BhyYsKUtx4d2uw0o9U5GDJDY=;
  b=IyHQO3Daxe3y1HaLPALkZj1LtzeZ1Pjnd6sAMPEroFD39RWGanGf8tf6
   fWI1ji/dwINOUlazCscsaGmkhn7aNU4zJKM8hHW0veHgOrlll+I0eSiCH
   MRcX+9LwmVLTI6bHohlPxF7VnQ32oEdOVeIBPPS61NVOEqFDsur9ApYpg
   IWSk3niwpUb2l++sczLvlje7WmGB8FHvzd5mREEVDWf9HVmt8IRe6Iht/
   kW+DZasXMeeiyEljfj4J+EUae3bdjTIrtf4KKs88Cj1iEkpq3kRoNmdkq
   awxTa15s8228W4UVJwv8/xUafKLP3c7mrXRQKhobQ6l23C3hZwPp6/AM/
   w==;
X-CSE-ConnectionGUID: BPhE1cr1Q7m74R9rTWSpmA==
X-CSE-MsgGUID: k+cTDf1yT0+4oFjqCodOpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34858909"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34858909"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 21:38:54 -0800
X-CSE-ConnectionGUID: 6nsUSB6KSQ+5CQQiuAkVXg==
X-CSE-MsgGUID: V7KslFb+SrivYKJXY6HUZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97516219"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 21:38:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 21:38:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 21:38:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 21:38:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsTwUJk99hF5HmGr/phUUiqPfZhSPWTbzEFIj/l4YFPIgCrilUvTk6dRwnA9RjwFWW2ZMV7DcRgPs8GJlpDcNeLv9XJbINHf6MeH2C0DAcC+lnfOiRvsEQcTf5K/srJRKTxaQFevDBX4NilQJfnG3+BhMntKLkUJ/bZz/n91eqWgKkhZKhxLm2GTmMW6wukC2fFayW+LMxT6um7VCRAVQycni7WNyt+1vjj2/Tsdyjk3OeprVM9XTHIQxSzVtH/Nk5oZ54hAKp0hyBCYJdxE7060A1VEAjQYsUuBcvEeRWwzjwNa6a32W/M39nCH6v7pSQYf3mo4M04cY8DPQHlYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bEATywctbagVukXUEO9Bqh+VJ6yqTyAtA7OQcfYZ6o=;
 b=uZexgxvNH7L53kmzvIdGzJSjU1edR/MUdAdwaZE+JvOcxRAHidC7vC0y90S5zUQxV2HYwAsiqoMNyxh3AxcnrXIcQ82GibJt724LraCepjt3omcPxomzHa2/fNqffWMEwA7AOD91FIEEOFfJKIZjB9NvnYsB/PmqB40hYuaxSefibwWNCqSSdrXB7+Bt15zNxhICsQkgNmwqjUeCMcatsWHiWeRD3Quld1eby/pxQAQGAVpnRcW8/wP1Nf0P2M8a4yAOqplSvJha8zZTgJiUefiwgDYvj2Ub71J1tR7+VB3n/sJynQiRFi7m8tHgR7iArTDBfaVetdfyhq6FDuIMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 05:38:35 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 05:38:35 +0000
Message-ID: <40d030d5-8d30-41b7-ae86-8baae6f594c5@intel.com>
Date: Mon, 16 Dec 2024 06:38:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/3] ice: lower the latency of GNSS reads
To: Michal Schmidt <mschmidt@redhat.com>
CC: <netdev@vger.kernel.org>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>, <intel-wired-lan@lists.osuosl.org>
References: <20241212153417.165919-1-mschmidt@redhat.com>
 <20241212153417.165919-3-mschmidt@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241212153417.165919-3-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: b77aa26f-7445-4287-d2db-08dd1d93e29f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T28xYkw5dHUzQjZZNU05TXNTRG9za3BPMUQxK3BuQWpTT1g3NU1BZGlCSEh4?=
 =?utf-8?B?S012WWtGUWViVzBVdkRpWmZjaURjTmVhc3dOZ1EydVZwMllUb01xL2tYSk5z?=
 =?utf-8?B?c1VqdGgyRzFiUVJTNkRwZlhXdTlvZjhtRFZaejdabmVkWnJDTlFkbEk0ME9O?=
 =?utf-8?B?bUJlQ0t2eDNxL1VlVWNVQ0tITlFLMHU0MUo2ZDJBbU13NDFNQTMxZUJHakg2?=
 =?utf-8?B?d1hNZ3FqSkNCbGJ3OEh5WXdkY0JRWHp3YW1DQkRkWUlnUVF5YjZKYTQyL2d0?=
 =?utf-8?B?RFF3RmoxU0hjQmJPZ0FITGpOaTRyOWlzWVhxQjRhWjJpVUwwZ0g0dEN1bWNU?=
 =?utf-8?B?NTFkYkZQRDVYQVloTnJrVTU5VVZtb3NNaGZIMTMxb1hOSnE4dHo0SThMdnFM?=
 =?utf-8?B?VDJkRWExTzcrZVludXlhbFhmOE15YjNiMW9WREdrOWVUU1FtcXBEWVFhWUxK?=
 =?utf-8?B?TFhxenBIaU9xZFJQQWNYL3NHb3FoREhYWUFDeEpYMGhnNGthWWU4aEwvZEdj?=
 =?utf-8?B?TzVmc0daRHdYamg5TXJ3RkswVzA0cUYxSUhsMXJFeUVEaFVHTTJjZ3NvQ2pa?=
 =?utf-8?B?Zm10d2pXb2JlMURtdTBqWlhiNEdFcG9VV2p1cTdlTm9wckJEdXN4RGlFK292?=
 =?utf-8?B?RGZNT0hpV21zU2RncUJ0cWx2ekxISTV1TTczcVUwcEROUFVaR3BJdUxHb00y?=
 =?utf-8?B?eGwzekd6NEVUazFBYUlKMUZKTm5wa1FNS2dWWXBRRS9qRGM0NWhVQ1BkRllj?=
 =?utf-8?B?MnA0T0xlUjU0LytpRGhDNS9ieHB1L1dGTkExZ3FIT3NzdDZBU05BdkFWWVpy?=
 =?utf-8?B?bndwemVDWWVRcmlOLzQwU29zY3FyWWg4SGxGTEs0eElEUE55b3BCd241UjJG?=
 =?utf-8?B?Q0Z6VkxWcHlUdzBGOUdUVzlDc0RLdG1UWGlZcnpmelhVNHJZTkcwdE9WNmZR?=
 =?utf-8?B?UmF0bUVGUk9LT1g4TWgyU0xMbzlod25jdVNIVmFzblIrTG9HNXdjRlhudjlt?=
 =?utf-8?B?aGw1MGZUU2lNbmdHbUR1VmFybmNPM1JiQVpLT0tEaWpDMkF2WmZ1ajV4UkhP?=
 =?utf-8?B?S0d3MVZveGdvRzBNSkMxTDkzamhXeHdOZmhWQ3FPeDhDdnpWcVBlSXRmQVFQ?=
 =?utf-8?B?OWJvMFQ0TGhMTXZZbUJ3WUJQeVltR0hkYktkM0ZrTktNUXZERTNjZTlGczIw?=
 =?utf-8?B?Z3UrbW9OVGNqd2ZsUVQxakwvNmJ0bXk3WHVTSUM5NmVtNG10WVpCZEFDVTVl?=
 =?utf-8?B?Zk9HT3ZVSXNGdU5rTVB1c3p4c1BRQWNjclBuUUxwcEJQMjRzc01yRVFJVU1T?=
 =?utf-8?B?RnJnczJ4dGVaT2ozRWtyNzdDRS93MGpyV3F3NTlCRFZSeW5XT3JSQ0NwTmlq?=
 =?utf-8?B?SE81eHdrdm1ZcnpaOUVyTkxLbTdwdHFhbmpjUzkwZGRRMUxPQ2x2bFpXc1hG?=
 =?utf-8?B?MFJHZDM1b1dHN2FiRDlTUVRMKzBYdlExNkZCcldXZnpzTFA5TXo2WmJpUUho?=
 =?utf-8?B?VEFIc2RacEZ1VC84aEUvTEdSWGRiamh4MGlGNGhJT1NLdmVXTVkrQ044ZGoy?=
 =?utf-8?B?cXdrSGEzWDAwb2RpYXRJMERKVUlyWGErdG9wNzNLVlRFM3BaN2FjVlJzYXFu?=
 =?utf-8?B?VlZHRWkvMk56WmRhUmNiVkdKcytsbGZ5WEZSSTU3NlZJVldQaHNad2lZV2tS?=
 =?utf-8?B?bXBwbHAzVGNTWHlNT24xWWUxeVpxcmhIUy9BeGZtSEkxcFA1clZteUh6R3Jv?=
 =?utf-8?B?TC9pek02MUNrU1dSakJLSWdoTE5xdEtaeVZJWjZXaVRCcVkrRllXa2g5Qm03?=
 =?utf-8?B?RFY4OGdmZ0FQNHF1WkJieGIwRjJQRXk5TnBjOVRQcElKV0hVYUZjYkkzWWRk?=
 =?utf-8?Q?mnY/hVSlvYIR5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjQ0UFR5eE1yNitiNGR0eDBhTzRzMTZEWUUvLy9ZNExSelVZZlpkSkZIUU5o?=
 =?utf-8?B?S1FERk55SzBPUjFQb2dOSkpTdGFmU2RBTVludFgrQlRsTjlqOUIyVDB6dFhX?=
 =?utf-8?B?aGNVYW9PalhMSEtpUzBuaVV6UW1MWjRYeUR1bmYyNEpNQ29VRGZPZXArbjhM?=
 =?utf-8?B?anBJUlJTeEN2a0U1NGxwcURkZHFMaS9mMTZndnpzUXJnLzdZOWIvbjBwblJw?=
 =?utf-8?B?V2RLU2VHNDdjVlA2U1d6YSttRGFCWkY3dmIwUHFxRVE5bmpnUm5yTW5qbUtE?=
 =?utf-8?B?T3ZTdTNkNHkybGJaWks4SUhTNWJhb21qWWh4NXRBaTF2bUNhSVpyeHBUQmRJ?=
 =?utf-8?B?OXFoaUdSSHFTU2N0REowSEFyeURRNVdPaEY0TkROVkNURTRqelBob2JCU3hC?=
 =?utf-8?B?K2lZYzdlbjJhSFBZM2VlRWVSN28vNXd5K2lVRlhwVzJJeTR3ZzBtZERQVGF6?=
 =?utf-8?B?UktGUkRxMjFkaXAxaDVjeUU2ajNianZyMkFkcmpVOGJSWG1CWXBBOXFnMFhy?=
 =?utf-8?B?ZzhLclg2ZGI3d2RwTWhRWld5REtlcCtTcEtzWVFzNjI0bmxRSDNuci81Tm5T?=
 =?utf-8?B?OVhUUi90eVpLb0dDQ0N2QUJZbnU1L3BaT1BOajgwaTI0SFhaZ3I2MWJHRVlR?=
 =?utf-8?B?RW9wb1RFbllubkR1VnU5TCtmTnNpSVdNcG44VHJYYUxVSXB0bmJyRFpQTHlE?=
 =?utf-8?B?aTRPSzhhNmZCV2l4ZlplNGdUQ3laODlTWWZEQTJsdFRBT0FQS0hUVXZYRHl6?=
 =?utf-8?B?empOYlY2c1RhVzM3RW0zbzh3M2Ywek1jVS90OGRFL2JUSkx0MTN3bGdEdU43?=
 =?utf-8?B?amdSdzF5YkhSK0hXUXJSYmFzL2s1cXFSRmdGalNQUW9TN0FFZG1KS1U4azhq?=
 =?utf-8?B?cnR4M3pyMEF2dXpjdXhSTUJwamcwZ24xay9KSzBsL2xtRkM1QlE3QnFka21o?=
 =?utf-8?B?Vy92VUp3U2ZLUTRtTVlhOU1XZE94ckE3c0pmNjRyUHphMkNPRlhNTk9xTEE5?=
 =?utf-8?B?VFVWc016bWp4dzZiTHZYbEVRaVBHc0ZPUVhxTlRySDFjMUt2WDZpaEw3Q2Ny?=
 =?utf-8?B?MEhHc3hySnZWbDlaOUtHQWIwZHRFT1VBR1BKVUlFbVY1eGhCZktmSDhEZ1lt?=
 =?utf-8?B?R1ljWW5kaG40QVRCZUw2Skg5WFk3dllkNmVCcExjbG5CNHUrWUZaODlTS1Jr?=
 =?utf-8?B?VkwwTHBGVGJZRWRmZmlWMkxJNlZsL1VERCt4RG5iaUFRelRXVjd6RW9wTmRH?=
 =?utf-8?B?a3dic2dsM0ZsZkIvVW1RSERKUGdhS2hpMkZJZ2QvT1JFN0lFWkIyck8zOXda?=
 =?utf-8?B?djFTQ0N3RXRSUXNrV2VUWkYzalM0Q3grcmg1Q3g2V1ZFbHVRTUtscDRwWnRX?=
 =?utf-8?B?N1Q3TTVPSW9YUFdUelBxWlZTcHRmd3Q1aktvTUsrbURHOGh4UlFhc3poRlZj?=
 =?utf-8?B?M1QyOURoS05seWZrQ1RPb0RpSThYaFM1UVlWOU4wZFdwYitSWEpCYVdxR0N4?=
 =?utf-8?B?UkRnM2E4RjRsRUFaQUVITXlrblpXZGppdWM2d0xYVjl0VFVrZ3ZaYzVSM0o4?=
 =?utf-8?B?VlZwakRLUkM2RGxCZHNiK21icHY1NlV1Y1loV0xvYXR4bTZRQVpZNmZ1WG11?=
 =?utf-8?B?ckl4WG5CL0RaZXMrYXJVdkIrY3ZrTkRDMThGZXdxSnQzRTVuSzYvSjZQWitP?=
 =?utf-8?B?TU5tWUNKWUc2QzNZKzZESjA3NDJBMGxzclZodkNDbUZrQ2RZdXBKa2tMWWdm?=
 =?utf-8?B?aFh1NU42ZEFXeCtqV2Z6TFMxWWt4NEk1UHJSQmhBODdrS1FobXA5d2psZzZ6?=
 =?utf-8?B?R3RmS0lUMnpJYTZmRW81bmtHeThrQkE0ZnF5bVhUb2E4Z0FMYTBmYmtXTVd4?=
 =?utf-8?B?ZktEcjhjU3NKZFdsT0VlM3R0eVdpYzAwYTZYaDZ2UUl3RU1QTWRrQmpoM0Iz?=
 =?utf-8?B?SmtUUGMyKzlsSlVZQ3lXQ0ZjSmpkOG5RR0ZSU2pSOUYyQS9oaytWVm1zV0hT?=
 =?utf-8?B?aWlLVFpkdUhkdGVkc3N1OTlrUlJTemMzOFdXN1psUWF5T0h3MFFObG03dkRR?=
 =?utf-8?B?K2l4YkZlQnA0czM1US9OUHg3VTFTaDU1T0Y5SnR1S2d6K09ZVk1qL0ZLTDFI?=
 =?utf-8?B?OElUbWJ3dTBESVpYZVBsWUpvUnV1QkNkYUNUQW1Zc01OQWFrakxmRy8zbWFQ?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b77aa26f-7445-4287-d2db-08dd1d93e29f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 05:38:35.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2JLM0hOOW/RZwbEqr+xR/h/VYjxTG1vdeCm1wnlckiW+jsLfujL9Ppj1p5SdfqRPsagBuhSjS21Y4Yh3S8Qrvvh8mom+hVextlwhE1McTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
X-OriginatorOrg: intel.com

On 12/12/24 16:34, Michal Schmidt wrote:
> The E810 is connected to the u-blox GNSS module over I2C. The ice driver
> periodically (every ~20ms) sends AdminQ commands to poll the u-blox for
> available data. Most of the time, there's no data. When the u-blox
> finally responds that data is available, usually it's around 800 bytes.
> It can be more or less, depending on how many NMEA messages were
> configured using ubxtool. ice then proceeds to read all the data.
> AdminQ and I2C are slow. The reading is performed in chunks of 15 bytes.
> ice reads all of the data before passing it to the kernel GNSS subsystem
> and onwards to userspace.
> 
> Improve the NMEA message receiving latency. Pass each 15-bytes chunk to
> userspace as soon as it's received.
> 

Thank you, overall it makes a good addition!
Please find some review feedback below.

> Tested-by: Miroslav Lichvar <mlichvar@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_gnss.c | 29 +++++++----------------
>   drivers/net/ethernet/intel/ice/ice_gnss.h |  6 ++++-
>   2 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index 9b1f970f4825..7922311d2545 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -88,10 +88,10 @@ static void ice_gnss_read(struct kthread_work *work)
>   	unsigned long delay = ICE_GNSS_POLL_DATA_DELAY_TIME;
>   	unsigned int i, bytes_read, data_len, count;
>   	struct ice_aqc_link_topo_addr link_topo;
> +	char buf[ICE_MAX_I2C_DATA_SIZE];
>   	struct ice_pf *pf;
>   	struct ice_hw *hw;
>   	__be16 data_len_b;
> -	char *buf = NULL;
>   	u8 i2c_params;
>   	int err = 0;
>   
> @@ -121,16 +121,6 @@ static void ice_gnss_read(struct kthread_work *work)
>   		goto requeue;
>   
>   	/* The u-blox has data_len bytes for us to read */
> -
> -	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);

prior to your patch, the buffer is too small when there is more than
PAGE_SIZE bytes to read, that warrants sending it as -net
There is not that much code here, and with your description it is easy
to follow, and the change is really "atomic" (send out each time instead
of just once at the end), no refactors, so feels nice for -net IMO.

> -
> -	buf = (char *)get_zeroed_page(GFP_KERNEL);
> -	if (!buf) {
> -		err = -ENOMEM;
> -		goto requeue;
> -	}
> -
> -	/* Read received data */
>   	for (i = 0; i < data_len; i += bytes_read) {
>   		unsigned int bytes_left = data_len - i;
>   
> @@ -139,19 +129,18 @@ static void ice_gnss_read(struct kthread_work *work)
>   
>   		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
>   				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
> -				      bytes_read, &buf[i], NULL);
> +				      bytes_read, buf, NULL);
>   		if (err)
> -			goto free_buf;
> +			goto requeue;
> +
> +		count = gnss_insert_raw(pf->gnss_dev, buf, bytes_read);
> +		if (count != bytes_read)

Before there was nothing to do on this condition, but now it's in the
loop, so I would expect to either break or retry or otherwise recover
here. Just going with the next step of the loop when you have lost some
bytes feels wrong. Not sure how much about that case is theoretical,
perhaps API could be fixed instead.

> +			dev_dbg(ice_pf_to_dev(pf),

in case of v2, I would squash the first commit here, an "additional
paragraph" would be enough

> +				"gnss_insert_raw ret=%d size=%d\n",
> +				count, bytes_read);
>   	}
>   
> -	count = gnss_insert_raw(pf->gnss_dev, buf, i);
> -	if (count != i)
> -		dev_dbg(ice_pf_to_dev(pf),
> -			"gnss_insert_raw ret=%d size=%d\n",
> -			count, i);
>   	delay = ICE_GNSS_TIMER_DELAY_TIME;
> -free_buf:
> -	free_page((unsigned long)buf);
>   requeue:
>   	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
>   	if (err)
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
> index 15daf603ed7b..e0e939f1b102 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.h
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
> @@ -8,7 +8,11 @@
>   #define ICE_GNSS_POLL_DATA_DELAY_TIME	(HZ / 50) /* poll every 20 ms */
>   #define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
>   #define ICE_GNSS_TTY_WRITE_BUF		250
> -#define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
> +/* ICE_MAX_I2C_DATA_SIZE is FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M).
> + * However, FIELD_MAX() does not evaluate to an integer constant expression,
> + * so it can't be used for the size of a non-VLA array.
> + */
> +#define ICE_MAX_I2C_DATA_SIZE		15

static_assert() is better than doc to say that two values are the same

>   #define ICE_MAX_I2C_WRITE_BYTES		4
>   
>   /* u-blox ZED-F9T specific definitions */


