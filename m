Return-Path: <netdev+bounces-296822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DzWiG+JmJ2oBwQIAu9opvQ
	(envelope-from <netdev+bounces-296822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:05:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B004765B871
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JqLPS2XB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296822-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296822-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF6B3301469A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC22D7DC6;
	Tue,  9 Jun 2026 01:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAF2737E3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:01:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966892; cv=fail; b=ce32c16xlyOiFYfWk3t/PivkfOlcJZJu27umpj5dcNV4iDNVqvVqs3DGw8JzuvguvSifCCM5xNLDIlE41hvKY8EoP9MApyoA1uiAzW3V2rFaGU/gsLuwfCKFYodoJ0WiFf7kpq2AGM0I3wJhDh6RvefxTDyK9OmDsaHIxkfjKsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966892; c=relaxed/simple;
	bh=cflhhdSQROgkdtApxu75dxsKOUy2IOEdBXliAJ6d3A0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DBoscptAoEttFqpWSLiJpZCKq6rWR+V7t3qyoDCqnXl8CzRwjDbbdyg8aa2gGZWPIw/srKf7z68Sfd7vK9YoPqzSZUYhCP/N8C7uAOJijk4DPaAKxJnUuPHtnFPoAwwtjJS1nBO0Xn7iXG9IvKUCSqLUuerx/oiM0gKJ3aj2Yo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqLPS2XB; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780966892; x=1812502892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cflhhdSQROgkdtApxu75dxsKOUy2IOEdBXliAJ6d3A0=;
  b=JqLPS2XBuCQQ/QZgiDa5gapRgIJea/kDocDHtEg/8NWkc+15tMCFQhUd
   LPuGtnkgKvIkS1XqXtcl/rBMX2KUgGYllQTduNRAKwXTZEHCKIPCQSydg
   YBsiNZvluaTaityBzqjlfRgRZkg474Uf0rygdBwkPwDL2RErNno90iCwj
   LFT1IGjSqL835vaMAj9m08DgqkZk6nlslxH6tRutFOPonhEKGCbGDDkQ/
   AgHiv1lKp58sRqZkYwdruPsUqBva7+O/UMZkRVIqgUgwHov1WBKef5OIg
   A04ybmM5cP5ByalvI3PbvzcY/LuDyT2Y//3MhDwrab2Jkh5i1sEHpQUl2
   w==;
X-CSE-ConnectionGUID: Esoid0N0Q4arW9kGG/YUhw==
X-CSE-MsgGUID: EQ0jo5WQRXqEG1BKbKi3fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81903515"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81903515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:01:31 -0700
X-CSE-ConnectionGUID: PLcGOW3yRvCGVUN+sxD2vg==
X-CSE-MsgGUID: vICF+csVQZSPSdBAUpwPZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245802267"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:01:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 18:01:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 18:01:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 18:01:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzykXo7OqWO1xuYuE9Eqf+Bbzdzhp5QGuMcneyYuM2f8ToOwigrNTmXiwD1vvpPt5K+3ibAjPFQmV9YvZ1RBGtN1xQDAYK2UFdB72Os9D8NsVJ1mnXJL7APHTPQxVLrwuWt+L58yIPGdZbJiWsJme1bTYfcKngVFAPl9r63zYgOBx5P4aafbxdBgham4rlbS7q1/sc71dzCOB8wQOwR99yxNevNSx6EI4rP2xe2j4FGq9WDqD5cDwOzrj4Kny9HEnXbGM0CfDnxqnOTmrTw9I2+m1CxX+ulZi86x9yTYoL157YJUlsOKBzrP4gfa9b1ypi/3sIM+37xjff0cjT8DPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mM04DumutuLtCvqwmRs55sPz7lKq5AHky4Ip+n+uKE=;
 b=J7t51z2ISUse4+gRcMequv8Sai6A/NvDnz+F1nt+o50i4X72HM1OgyxfRcTWX1bK9f+KIvUuYcVBZ4wK6OaGKMBR+yZqrccJW7K24BERwxoX5u8vIZ0hufqg04KWlIy1Q00/BYg4ZjwiSXuE+NiNKPlTzNcyLQe61q9DuK0pb89l+LopNxLqiCl5hvOrdssjDw4WkbUqRIYyPDf3xJSjmmm7Tl0XmASuTsu5CZv5hVaMwAcvbfYpBFPYxwOMNbND2ANBiwTRmB9WkJB5xYX4eHDHPKWSgyBmP2Op2jbPnXB0ovbs0PlD4b4U7Cah0dO27VhKD/yAinIemAXBB1g3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 01:01:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 01:01:26 +0000
Message-ID: <6f452924-5055-4bf0-ac67-e684ed1a36b2@intel.com>
Date: Mon, 8 Jun 2026 18:01:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/12] net: ethtool: optionally skip rtnl_lock
 on Netlink path for SET ops
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<michael.chan@broadcom.com>, <hkallweit1@gmail.com>,
	<maxime.chevallier@bootlin.com>, <joshwash@google.com>, <tariqt@nvidia.com>,
	<alexanderduyck@fb.com>, <willemb@google.com>, <kory.maincent@bootlin.com>,
	<sdf.kernel@gmail.com>, <jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <20260605002912.3456868-6-kuba@kernel.org>
 <ce45017d-8caf-4b4c-b04a-44806bcf5e72@intel.com>
 <20260608165826.2525b726@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260608165826.2525b726@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SN7PR11MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 8563dec8-65de-4b9e-27c5-08dec5c2a217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099006|4143699003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YOlT4FFCCY8EmUHpHts+PNrQqP4ElLUb+9vLHybQoBvTew6HT1Qe3evqdJNwaSEC8scwvFtbM5qdrVXkkeRnAUei0Ak9oiAzQoYEcEi2Khl4H/gfI0FgLND93U5+zcZwYz/Cf4RO7ZES2FlBxIgP7bjVbd5doZBT1EBydRqNchWOVqNlfI0ZQ4U0kP+gmfF6nvh2D4+x6LU73zPVf1E23SPQQqnUma4qzigkvgTyBXlSS0BTOi6fd+t4x9X/MA00690fr0IWzYI18KiMCoxTyQpxV7+VOgRUUkIXp3CNri5b/OT7f8FjwVAqBVFIuI/1Bh7wWaUIK8x3vQ3Vr/JQGen7fiaz3gPAi98eTv6n1Cir1nUu1TQh99w7z8Ivxo0b/1DuG4FinzF+OWXJEPB2NG8x2QIRYoCqZuphmXG3HJTOj0qs57CYXikVvMQlra+CQaRI4D0tdDIpb5GEhCa1fmGO/tlxuHp3KBuyW1TJZgMInUbaHOjKDC79rtoY7738rPMozOoQeLIgK560EfeYAK4A4UeJdwiZ78gkib7erCdE4FVpud1PH2pdAa2sk/syu0eDuHlF1XBnUKmsiwNLN0020EjgMIHCdo33wPSxeb0Ppv6386+6Tuu8cbQQyEDpufhiaTog73CnEWJaMb3n4ZONc9NMyZR4dnKrFnvry/DJ0GtTk9fTyGW9MmDileZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJsWjJGU1ZXZE0wdHFRajlVaFJLTHdnSG8zcllnRG9tNmdmZEVDelBlejlJ?=
 =?utf-8?B?Mjdpb2lPaHQ2YTBIK0wzN21INFZSS0tyUjU4RWxhK2RvYXBqTnBhWmlLMWtG?=
 =?utf-8?B?Ymh5M0drd1UwS3NQSXVyYk1tdklFUGZyRWdENG9uNit2NjFKcHAxRzBWdHd2?=
 =?utf-8?B?dzVHRE1PVURVdU5xaW1SUWhtK3lYaXNOcHVxSUdkQy92Y1lpU1JlZmNCVmZ3?=
 =?utf-8?B?ck1tNkdKSmlVbDcvM1Y3Y1lGcm0xRFExT0JNMlI5ck1PSlZQZXF3MWtkaUp1?=
 =?utf-8?B?RUxaK2h4ZzQ1WVhjay84U1kxeWlEZkhUOWhPckkzUzY5ME5ueGN5RUthL0tD?=
 =?utf-8?B?aUNTeVhjeVRYYmNlMitlNFFsaythS1BMSzFmRlpoMXY0SzRlK20zLytBbjIv?=
 =?utf-8?B?K1NGWlpSQ0FvdnhvVUI0bjByc21zaXM5RzlKY0Q5cXlYQzlmQUpxZ213Y2I1?=
 =?utf-8?B?L1loQ1NqWnFPZGZuc0ZFQnBSdDNFemEydXE2Z0xhNFp5YkR2ZDZJVFdQdnVo?=
 =?utf-8?B?Q3RNZDRyelQ4TmswazdTZ00vUjlsU2lCc1ZrTFlQN3YzSjN0cTg4T0VYdVFr?=
 =?utf-8?B?T1VpbDNybzdQWnlHdEFpc3ZTQTZhSXZsRkdrWVhRV3dQOUo5bE9SbVk2Yjdn?=
 =?utf-8?B?cDI4YjNsT1dkVVFXTHlZYkZVVHVrWTZkTEliZGh2dFhpZFI4T2pHTXZaS1dO?=
 =?utf-8?B?MWc1Y01Bd1dQNDdnSm9NUzI4em9vbHNhaDhIcWxsRWhxYytkZVV4Y0greTJu?=
 =?utf-8?B?S3dsMU9WNHRsRlJpMS94dk5TTWhoYi9uME10eWdoTSsvczgwNWIzemtId3NZ?=
 =?utf-8?B?dzlmRi9SUTJ5Yk5DQUdNSDhzZ255M09HeUpyL2I0MG5DdGNQUk9SS1lyT3JN?=
 =?utf-8?B?QkN1VjQrbFZ1WG9BOUNxS3pEbUNQaVRETkphbTlJVjF2bitLRDRmODFidkt2?=
 =?utf-8?B?VGVaRUpJZmRKMHc0ZmJ0NnpzQkVjY0ozMlRLcTZYTTV6TGVLNW5HN2VZbFI1?=
 =?utf-8?B?S1JxN3pXTnpyMnQreWwzUjNLd1hQVE9iZit1dmtpWlUydU9vRHBhZ3BOUGxZ?=
 =?utf-8?B?cUhEU0lsb0dPZFBhZGtNSmkrVW5oMklhYURmb01kQXo1OFR6dGNyV000OGNE?=
 =?utf-8?B?b1NKdXBwWjMvK0NYZ1RQN1V4THQwSUFxNVhmZ3pNa3NCcDRBYlhHUWdlbk5l?=
 =?utf-8?B?bEZ5Sy9FLzdjT25Belg4a1VrSDFoaGR0Mm1KTS9meDgxcGxCb0Y0Vkg1MXFi?=
 =?utf-8?B?V2FNRjNCVGFyRTZNd2JmY0xxazF3bmxQa0szM3FxYTNUNk5jSCtVcmxuVWM5?=
 =?utf-8?B?RXBKOWI2NWNnSGVWbkY1RVRZbkVZZE5SeEpqVEdpUGo0SUp0VUo5L3hCVzhS?=
 =?utf-8?B?Z2FoQVJNUDNocnp2OTFKNW1KaWFBQkVoZWM4VHl5cmg0MllnUWQzVy80SEVs?=
 =?utf-8?B?S2ZGN0ExSExtakFaQ3JqbEZaaUpyR0pxdHJ3RTlOdW5EZmlkcktJV1Z5djVQ?=
 =?utf-8?B?RmFWaXNkYnVEL1JyU215WUJCR200c2dobzNpSU5oRHpLLzc4Vk82VEpkWDcw?=
 =?utf-8?B?bjdQbEoyY29aMmZiVk5MdWFhNXJLaHFqdXlBOE1leDNCamZUT09lOHNwRUtV?=
 =?utf-8?B?TVBsZHJHVnBJN3FQODlvMkQ3Y2UyWnhGd25ueXg4cXNPZ09mVzMyMDdLN3Vs?=
 =?utf-8?B?T3dhLzg4c2dzRTROR2JZbmxOQ1JNNEFTd092UEVrQ1ZCSmp2eVJBN3lxTUhB?=
 =?utf-8?B?ZUFVcDRzYnVXSElJU09XUkIzL2xVS2k1MlE0a3NjTjNnZm5sUDIvZDltNzNH?=
 =?utf-8?B?aFo3R0NMRUNjUHhDc0FhaDVpWnBmQXdkSTJIcmlISGtTZUFzQkNGbGN5RkJT?=
 =?utf-8?B?aUVYbCtidEh5ZnNkeUdxK3JCd1dkQmlIdHpOU25KUkVaRUlKVEJ6bG1OMzhC?=
 =?utf-8?B?MFltNFF5VmFnZGFseHBIdUFIMTFwRENoMHREcHJBZGJhUFpJL2NaYUNkWjcv?=
 =?utf-8?B?TU02aVFsUkY2eGJrbXdPck9IZjhxWkY5MGhGTUtEUkdOcEREeE56U0VWZnYw?=
 =?utf-8?B?a0RoRTVYb2U5SmpRVnIzNmp6TlpwQVZ5ZitoZ0tRc015ZG1yNDRyZnBNRWd1?=
 =?utf-8?B?V3BGeld6YndGeFZxS3l1L0Q0dWJwVmJRVWl1dnNBUEEvZzdMbWR4cFlFUDJm?=
 =?utf-8?B?azdHWXFpV01FQUdLL2pqc29WYUUzUWZudjJVNWZwelVsV2VGY0xkQko1TFQw?=
 =?utf-8?B?VThtVU1aMnBYVThNWVp0Y1NvdGd1T0FkQW1GbXZhdlFQSjgvWjNDUjZBUDVN?=
 =?utf-8?B?N1YxNnN5eTc3R1NVS0pjZWxlakFTQnhJbFpZYXU5VmtMZ2NWdDdZZz09?=
X-Exchange-RoutingPolicyChecked: iGk0LA330ltZv2dwGpN3WTRmBeVPu1knIVFNHjtxy473nQCRfdc8PfOXN6DZ4yipzyvI4W73yvVumS9r6mlIDk2J7WjQah2C+0zhdr3c5cjzyF59frxFjwhBc/BI+LRY338mUOPgKeVbcaInhIffCppQsYCYgXrqb1gOJMLZnl/CQSjOJydFn0UXYHg9eYDZv+Ea2sTyAInlpDTFIT3QDTPSGCY3W90gh3Uy1/S+ZG6inBKiOP7iphWAuthudjh5Q1PUMl9XnaHn1vVuVBSsONBIf3LCj59mHHgqDABarDcZS9gEox/VbO5IZX7TvyuVp7Sx69GnaAgLRJbTHifgLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8563dec8-65de-4b9e-27c5-08dec5c2a217
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:01:26.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZSGzYfcOWaLTLBPbiFTyRDcg0/pa7P197TdN8Oj3xswQjUAtAgks0C/NWyBdBayxavo1fV9VtZZMUzGbQnlGXXUb4Np42QF8OGgWidJ6XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296822-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B004765B871

On 6/8/2026 4:58 PM, Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 15:15:48 -0700 Jacob Keller wrote:
>>> @@ -935,7 +935,13 @@ struct kernel_ethtool_ts_info {
>>>   * these bits separate, per GET and SET. GET is much easier to "unlock".
>>>   */
>>>  #define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
>>> -#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_SPFLAGS		BIT(1)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM	BIT(2)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_SCHANNELS		BIT(3)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_SCOALESCE		BIT(4)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(5)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
>>> +#define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)  
>>
>> Whats the reasoning for changing order here? Is this sorted somehow?
> 
> I went back and forth on this a little but at the end I wanted the GET
> and SET bits to be next to each other (PAUSE ones specifically, that's
> the only case where phylink forces us to add a GET bit).
> 
>> Would it make more sense to use an enum to define the bits instead so
>> that patches don't have to do a -/+ of the same NAME?
> 
> We'd need to add enum for bit ids and then defines for BIT(id)?
> Dunno, personally I don't really like that. And we never switch
> on the values here so enum buys us little. Maybe BTF, that's about it?

Its fine as is. I just didn't like seeing the bit indexes requiring
change mid-series.

You could just leave the indexes as the final values, but that also
looks odd, so I think its just a choice of which oddity do you prefer.
Regardless, it is noise since the only difference is inter-patch diffs
for stuff that will all be merged at once.

