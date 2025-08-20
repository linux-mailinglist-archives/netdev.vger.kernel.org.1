Return-Path: <netdev+bounces-215193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAEB2D86A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52EC16BFDE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127432D9488;
	Wed, 20 Aug 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Scf+87jE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983D2DC335;
	Wed, 20 Aug 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682193; cv=fail; b=tL/9HfX7Nz07SXHgI2EpnXnA4XthvVXHTdGB/CMiHByKk+/T0NNaGRKtVN317n1WPMUmurJ6Ko6xFNuenZoY2Dhn6wvJHLzionlis6J09P4T+/9FnlbLAQDuj7KP/8j9STTHeGQXVBdOAJzZnxSnbXvv6Pu97LaNMyh7mo7uP80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682193; c=relaxed/simple;
	bh=gN2EZItuwYmlfgMb9jyYE9oW06myB2ctgMheqSht1pw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Le396Uk1Dj5WnKcoPLWhcF2lTajSDSsoR5yPpLI53/wWLAwQBZJS8AsibJ20stEfFbBbRTmgbOKPtd4Dgp56GBcOlBhP9Wu0/WQ1I88MDLEhjt0cQ0s2P5vd3GW5CLXeCBW+32NUt0w+bwxwV6Hu8nrj8Ujyc8WlkaOxHA1LmSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Scf+87jE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755682191; x=1787218191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gN2EZItuwYmlfgMb9jyYE9oW06myB2ctgMheqSht1pw=;
  b=Scf+87jErKUuWtyGH8s+ZvLrdAJzUj0OoIoclASUYUODK2OmX5bV7wVf
   P66wt/dpB+BKmGI6/FskmObTb+gvWtReVVKc/QOyhX16AxsTN4tR0nbyR
   +IRfZjcu7BY7eTyKhHyE21uAkWGyW3XAbAUP5vVb0AjMUSTvqUMWZYqaX
   We9bWchPyeuhxJdZzVCoM6CRSQ4AUY0BbprfqZwM2veUqh1f5rUmcGVVJ
   CkRzZ4fCIi/JKHjzjHo414Ft3LlboBtQ++mx/qkssf9GyRP7VaQgZ1YZQ
   i18c/ebTa3D9lOCM4RCMU9k/n3OK02+eD0NpynwNunm6OweLpuCiFI+AK
   Q==;
X-CSE-ConnectionGUID: SR8TSXDPTEScsDKDcrZIKA==
X-CSE-MsgGUID: yokbHzHKQ46+TKqcO8FfHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80537140"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="80537140"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:29:50 -0700
X-CSE-ConnectionGUID: FloYRB0KQ52cnCMqBEpFog==
X-CSE-MsgGUID: +YWNXRBnT5yU+HhBuZhTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="191771624"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:29:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:29:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 02:29:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omHJWmDnZLKnJXPMEL4nhJTC6oWZZW2XxRC6T6RujwbcJEv4rXykMHXvtB/gW/C7wCXiA9lUOCqMjDVtQIOhEVvWRrk0xQLMhJ6AgNaJACydPRmERWnyelHJk2w4DRF8Ybqi9k+vEA7/C1c2Qr5kM1zzK96aJEerIsEsSaKq7sX2d0LKebbcxizNOCaObuTnRVz5N603cUiYZf4fyFWzeOEdsaJKPgoYlJuLcfdjujpQS2ZiDWTW5127UtApyD/uB93f7fOEF5lWSfAbSEETORVzLAnzIZweQfoqSdosFzjDqgjNLe3C6Bj5snPi2WxslJmwoJVqv1laGUtwhvrptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd43laZrh9vn0C4r2TfLV5CtNU+6nqpLYj5NSzvUj5c=;
 b=QS/5toYhP05EleKcJOoC41inFJ6+nrhkzZsDl7isAxEz59fSWmu5yJyuPOoMilHqBektVR7bgLwU1YV3j+Tuzbk3BfD34NLXadfVW4FfAb8ghiQNwEgYgSX05ENm3UsgjdGnjAvkEayS5wdqDc0OcAfNzUcBI4wsIy3MoHStZBwvCBhnF/58FP0PKoRGi8f7ecBGQP+361ZLtXMDU55BNLvUuE5uR9/KugudmynuTW9v6AjwDgPYBK17MeL4eYUB0lDEH/lIIthZ68sei4E8gQjkTRJDrbhYmEVVYA3gL01GouULpPf/jlUM59fdee6VAVwDcQ8bkHN6J8gXPUouYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ5PPFBD6B1667A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 09:29:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 09:29:42 +0000
Message-ID: <8ffb7fa5-641b-47b7-963c-480c8494c85c@intel.com>
Date: Wed, 20 Aug 2025 11:29:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethernet: tlan: Convert to use jiffies macro
To: <zhang.enpei@zte.com.cn>, <chessman@tux.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250819161616455E67Ux3eifLtzWBrN8i6Fr@zte.com.cn>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20250819161616455E67Ux3eifLtzWBrN8i6Fr@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ5PPFBD6B1667A:EE_
X-MS-Office365-Filtering-Correlation-Id: 7596ed65-3e53-4973-8fba-08dddfcc178d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anNGT0s4NkdpTmZKemRYNElQemdCR1cwWC9UdXYyR0p0bGEvVmZoSEFOZUxY?=
 =?utf-8?B?UzljOWpia1c3K1lKajBjQ2JhbEorU3dsL3djdjRacVF0WFUzMnZTSXpJU2Fr?=
 =?utf-8?B?dE9Rc0NuaGxndkRKZVdiblhBSDhUUStOU1NYM0d6ajFXWDQ0VHArK1BSeGRx?=
 =?utf-8?B?WnRBZXQ4VVh4ckFmT2YrQVdNVVFtMDlBdE9qZkdCeGRmZHFqQTNmQi9Fa05B?=
 =?utf-8?B?RFFMRW16dm1HVGtVc1hWQmtRaXU5cEFhTlZxeC9hbUd1dEVrQVJ0bHc0eS9B?=
 =?utf-8?B?NU1oazNlT1FRbUlmRWRoQXVucEN1ckE2U0g1NElFakZGQjVBYThGZ2V6UE5s?=
 =?utf-8?B?VUJlZWJkNkp4RkhkNERkaS9Qek95dWY4Z2ZPa2VGcStpRXJ0M1Vhd1RUSDgx?=
 =?utf-8?B?Njh3QzNuSkU2Q2U3YmlreXZ1L1pCVTV2eUVoZzAwWXU2dldiYkRLZmlKbk9h?=
 =?utf-8?B?cjB4b2IydGMvQitTc0NHWGJwOGdHYVE5U29xWWpzTllZOVJsREw1WlRva1hH?=
 =?utf-8?B?ckdQUjRuZUxJMWd5QXV1blVWSVlXRlJtQnk4b3doZ3ZvdjNzT3BjSEpINDhK?=
 =?utf-8?B?MFdhdDlCNDBPdTBrSjJubjN6dVhkbFRCb3REMzRwWTlKU0tkamN6aGd6b0J1?=
 =?utf-8?B?N01vYmwyWjFvalNlUHRETGpWZFc3TjZpcnVKQzN6d0FuSE9PQ0w3TmxURFhn?=
 =?utf-8?B?S3QxbDlDc1dpRVpKOXg1WmpYTWZRbFN3UWJwR0piSTBaQmhUVng3U2ovT09m?=
 =?utf-8?B?YWxTZHRLNzA2OXhhNTd5TU8vaGthQmxxYTMxSHM1L1hTWkZlSGs5bWFxT1hJ?=
 =?utf-8?B?Ukl2amJjR0NBSjNtQWhMaUNDNGtEZnZpVGorQkRWdUgyYWZYeHZxMWU0M1JP?=
 =?utf-8?B?ZWlxU2pmOWRZSkxHOUJNazdrYnFKWUE5OW5xSFFZWU1MTHpCN0dkNFBsT3du?=
 =?utf-8?B?RS9RODlHNUlXR0tCSkNES2NDUFJmODA1NG8wbDBjSEljZHpDRkF3WnR5Uzhw?=
 =?utf-8?B?aWZGMlFBSk9DREYyWEl1aHhPbnMxNUhFeERBQmdQZGFvSEx2NWp0NXFhREEz?=
 =?utf-8?B?eDBuUWpjSE91R1VyMExaZk9yZjRzVEZEL0VwaEJwU0dCenVlQXkrRlpMUHU0?=
 =?utf-8?B?R1FKNFA4UzkwMXk2UGtET2YwZXB6RkJWcVhWeEo1UFYzNm5YY3ZWN2hPNm5H?=
 =?utf-8?B?MWQreHRtQkpNdmN5T2l3aXdBS3NSV05sU3IvQkR4Q045TmZudExVSzNycDc3?=
 =?utf-8?B?UFNMdGJVVlRUZ1RIeWFnMDFkMThLNkE3SWJSdHB1MEhNVU1lVk11VWVWaWVn?=
 =?utf-8?B?U0RHc0Ryd1R3RUg5aTBrcXkzVFNHblF5eEw0VW4yamdyNE81OWVsZjFyTTg0?=
 =?utf-8?B?S2hiQmJ4d1NuV3o5dnMrbEdLV002azYzZWIyaGk3OUE3NzlLWWJocGVsOXFD?=
 =?utf-8?B?ME5qQnVOTnVoU1NSR3pUekpuK2orSUdBYjdaVG9kTitscGJJRE5TZGRmOFFE?=
 =?utf-8?B?a1puMVJkRkVLdm5rSlZOTUdhd1h0eWNRWFBjRW9Hd25kOVd0ZWFlK1RvaGxp?=
 =?utf-8?B?L09QRjR4bWErZW9UNDk1VDBXYUM2NjZjTDdKSW9OK0dlVDBMejFpZUI5WVFN?=
 =?utf-8?B?eFIzbEliamdJZERrVTdiVnZEdG4xcXBSc0xvWVNCZVJWeTEra2dmS3I5aVFS?=
 =?utf-8?B?VSs3c1h2c2ZYOXBVNVl4eDNwT09GSVJrZkVJbUJxVnFRVFN2Qit1dGxtTlpy?=
 =?utf-8?B?S2kxRlZLbGJmQnhXeWwvTDh1K2pQMVpsdWp3OFBpZ2N0SXJhdWl4Z0RxanFK?=
 =?utf-8?B?UXA4TVNtb1JHcXRxUE5NT1RIR0puTjVHUmtyS2kzUTB5UkRpR0tkRGhzVEY4?=
 =?utf-8?B?eEN1WDk1bWFxUWZ0Zms4YU1ZdzQvTDdFeXRQRkxjRHZoYzk5ek5aRkZsSjR6?=
 =?utf-8?Q?kFQdGG2sBqo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2NlczgrVGNvbDFWbkVwRHhuWTlJaVlkVHA5Q3A1WXhTejcvM3V1S2J4SzNl?=
 =?utf-8?B?OHRMSVpPUEpaTy8xbTZvY2tRMlMxSkp5K21jMG1Na2pqcU5SSHpjV21IalU4?=
 =?utf-8?B?Zmx4Zmh3YVpOb1RxQy9hK09Id3l1OWxzL3lid3RXOU5DVmZlZEhuOUdoT3Bq?=
 =?utf-8?B?UzBFSHcrd015NkZKQ0VGbE5KS21qdTdxRWxmR092SDY2RVZNa0NqM1pqYzJJ?=
 =?utf-8?B?c1l0SUx2L3FDRlE5eHU5S1prdFBBUmFKRTV3dW5OeStnNjZWOEFIa3FPYUVs?=
 =?utf-8?B?MzlOd1lNRExsbjZLV0ZPT0JpaURvNHB2MFhNM1lFWkRQTTdIMFZrdWNEZG13?=
 =?utf-8?B?L0QyeXNzZWpWT3JPdmxseFdNZmMzVmk4WHpQQkRYS29VMkpMZnZGV3NOa2ph?=
 =?utf-8?B?em40eDlEZ2FwUENGTkczc2xacHQrQytVMFlpSW5HMm1pYXJvTTByYjFnUkpM?=
 =?utf-8?B?ZXE3WlU4UXU2YzhLTWpiYUtJK0lGdm5jYXFuSU5VMlY3bjlReUh4dEcyekNQ?=
 =?utf-8?B?SWFLL25HcTNXWktoOEwrZU1HeTk5RXI4QVQ4MjVKZWMrVGZkNUhKUjZYeTR3?=
 =?utf-8?B?M1UvUi9adGhubVBpbmlFMHFyM2U4ME9ibS9JaU1EU1lBcFk0QmdQcHpUKzJF?=
 =?utf-8?B?VkJDckFIbmovWU5rb2lmUDZ1N0p2MWs0aWZyalozM1BvWGFJUHE5cGw1MVlD?=
 =?utf-8?B?ZXRpZSswVW5PZFc2VHhpVjVvY0wwaTdiWmkreW1BUmhHV3QzUjhLNjFIL0ps?=
 =?utf-8?B?VTdISjhvaFMyNE9GU1hWcjRhMmFWSmJEanI0dnRTaFB3ZGYwYk1nZStXUGR1?=
 =?utf-8?B?bDlMQnlKSEo2VVhZcUxhOVd0M2JGYzJwTWNWcjZSRW0xY2d1R09pM1VCc3ZZ?=
 =?utf-8?B?enhGa05ta3Q0RFU0b1grSFFGazBESjJLN2VBRGZqN1dZem9SOCttSi9lWjBv?=
 =?utf-8?B?VStMeG5PRUVYbWttZmEvY0ovWjVoUGdubGUyR1N2endxZkN3LzA1WGNMVG9a?=
 =?utf-8?B?dUhIeGc4Sk5PWEV4ZzlmRWwrR0hHK0V5RHNrbE5OV2FYK2V1eHNIWXFZUWxa?=
 =?utf-8?B?a0ZETERhMXcrbVc5WGdwbVJidDZ3ZHA1R2xHSzhqbTl3K1hjVW1QWVJtbGZr?=
 =?utf-8?B?a2IxUkljTHZvM0tLVHB2TjBhSSthQk1WU2wvQVBjNmM1Z2xxRkx4MHErVnNK?=
 =?utf-8?B?eWU0TnRYdUFsbVNIbTFhb0dmVXphSWZJZlVVUkZybDdTdzBwbGdsTjZkNjZ3?=
 =?utf-8?B?RHVCTzJXRFI2TEQxd3VPaXpPeHZLK3QwNnU2SW11RVJ3N1ZMbDc2bUpBckg4?=
 =?utf-8?B?RDYyd3dzRGlFV1p1YmRnOEkwNFRETi9HWlAvN2hKc1J0MjdLSEFuc28remVt?=
 =?utf-8?B?cXphVHp2cElTSWRUZVNlTEZTbldINlZtKzlqM3VZbU55WDh3WlVWZ0FORUli?=
 =?utf-8?B?ZExUU2MzU05FcWpMUzFYWnIwTk1Wck9meUxVT0ZPYTJzVkR4ZDRRVDlONXBt?=
 =?utf-8?B?ajNKRm9RUWc0QUlJbkdmQlpJNEdlbngrdDBRTi9tenhxcmdtTk9QQ3BzR3E4?=
 =?utf-8?B?MXFnT3cwZVBXRmJCcHlvUWppRzU2RkVjKzhwTlFXNDFvRzRYZkVod25DV01W?=
 =?utf-8?B?bFVrRFUwOFh6RGhKbzJOV1ZOVElod0M1VEJTZWRURURlN1d1bWd5dWx3VFNG?=
 =?utf-8?B?ME1kOXZ0eXhkbFJLSFhjTVdpUGtLa3FOU05RQjNQT0VjNi9JZWNBU1NOQk1l?=
 =?utf-8?B?MnVCR01icmNVUzRmNXNESmxJRFBjU3lsbTB4Y2FGMTFqb2VkSXU5YWU5UkQ0?=
 =?utf-8?B?S3kwK3k3Sm9tUm9Jb1UvT3ZyYTA5YWlQS3Q4QjFrVlMxN3ZZc01KbTlhcG0w?=
 =?utf-8?B?MFB4dVMybnpYNEUweHJQNkRPRlNzTHJ4KyswVWNDYmNObVZsc0JaRnJlU3dX?=
 =?utf-8?B?VWJ2amQvMlA5ZmQrY2VhNkh2Zkt4djA3RTRKMnNRNVRYQmhpVFoxemQzWXQ2?=
 =?utf-8?B?d3dHSVZEcGFPL3hBeEpzMUFnMFdPTVJod0lLajRqWWVONTRlakhQNFNJVzFO?=
 =?utf-8?B?MkZtcVNMVHpaR0l2aktMOHVQdXZ0MGdDNldTVllzY2NIb2MzY3dDcHUyWC9p?=
 =?utf-8?B?SktSamRucWorYSt6YlIrUUxxdDN5S0hjM0xjRlRvWlBuNGxCZG4rQjRWMVVT?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7596ed65-3e53-4973-8fba-08dddfcc178d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:29:41.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+3pmY8ue7qiidoWLmyULemZRKeDiaIf9tRa1f/f69tgSF9WyNyMru5NZWw4alpJTpFQmS8oQkDdeef292woXq6165YWtp+nZGLUPFaYqOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBD6B1667A
X-OriginatorOrg: intel.com

On 8/19/25 10:16, zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> 
> Use time_after_eq macro instead of using jiffies directly to handle
> wraparound.
> 
> Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
> ---
>   drivers/net/ethernet/ti/tlan.c | 4 +---

change looks good, and it seems that there is no more candidates in ti/
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
> index a55b0f951181..78e439834f26 100644
> --- a/drivers/net/ethernet/ti/tlan.c
> +++ b/drivers/net/ethernet/ti/tlan.c
> @@ -1817,7 +1817,6 @@ static void tlan_timer(struct timer_list *t)
>   {
>          struct tlan_priv        *priv = timer_container_of(priv, t, timer);
>          struct net_device       *dev = priv->dev;
> -       u32             elapsed;
>          unsigned long   flags = 0;
> 
>          priv->timer.function = NULL;
> @@ -1844,8 +1843,7 @@ static void tlan_timer(struct timer_list *t)
>          case TLAN_TIMER_ACTIVITY:
>                  spin_lock_irqsave(&priv->lock, flags);
>                  if (priv->timer.function == NULL) {
> -                       elapsed = jiffies - priv->timer_set_at;
> -                       if (elapsed >= TLAN_TIMER_ACT_DELAY) {
> +                       if (time_after_eq(jiffies, priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
>                                  tlan_dio_write8(dev->base_addr,
>                                                  TLAN_LED_REG, TLAN_LED_LINK);
>                          } else  {


