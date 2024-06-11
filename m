Return-Path: <netdev+bounces-102534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3689039B3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DB61C21A92
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707E31791FC;
	Tue, 11 Jun 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwUBlInK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397077407C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104201; cv=fail; b=oVnzqGfZxltaOJ2eelL+m+pagBwvIkCLczzaSY+mHaRbgZfABMO18DzR4++4abweVuR9+5t8UPhZL+UcMAuUnanWe6LHrCHaZxs61TffGHvVh8AGg1EtwVF5Ax5Efgx1ABMsIcWDuiNClOu5OyVQttJEri8uR28KMM66UNE10Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104201; c=relaxed/simple;
	bh=VT04l8ywEdJv+u8VDZ5T3PU+sK06FvhnVYNcZ5nGkyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oRpmmdD7E+iH4Y17R0ZYx/vcmqP+fJVd/vRFaIKQuOnuKUMritdtn6PCDQataiCmVyo8XcENDJ3i4u9TX0EVGIpoGGRMS9ch9ogiF5SO4zbyWhP9v4wFha/uDXWPLIehbHF+R9IWHU0kspF7LraPE/2Mji9fEGncwL0uVXlDCJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwUBlInK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718104199; x=1749640199;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VT04l8ywEdJv+u8VDZ5T3PU+sK06FvhnVYNcZ5nGkyA=;
  b=nwUBlInKKeukKBYavpBGu9bsU+I1zqCEW6kXIlEQZ0XS5pRhVm61WqlD
   LwRnKgHPkHfH/snelsvLVMd8ZoC3msi5crZbq6LHe4l6B5NarVdRFyc1N
   zFXhnuUcQlNbNPoPQ5SirCRHIpsCVCf10N9z2WK4oOdFrIPsBPMyiNnX9
   opJnP54siisNI6lGPXuMbfbctl1kaDCbCzRm6z2AXSXHUNNK8JRvljyUz
   j2u8EgvoCRAf+kKMAyGCEb0Ds2plaSsQ1tjYn90/pF9FpkYmv7LVfrQK0
   PCPZbEUcyJ/A1TS9Oyx9KVgOzJqnAYZgXx7786ObVFLyvYIffrBnZfTP/
   A==;
X-CSE-ConnectionGUID: 2rd4ihMQQjePWDDcmh4eMw==
X-CSE-MsgGUID: yIMcmDlLRwWWGnOBAUOl4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18636676"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="18636676"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 04:09:58 -0700
X-CSE-ConnectionGUID: tXNJeQw7TxSR01LWhEE4Sg==
X-CSE-MsgGUID: 8WHMPSb5QRWBh4Qmt0igew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="76868095"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 04:09:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 04:09:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 04:09:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 04:09:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 04:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBqCD0A36ktfOMpoHeTtQsvU0Whgithd6jaR6vJ0igkdL2rx6c1o2hgJCN9m6z47jw8Nl9t0dD8dbceGuIFI05fzwo1RAukpYUJI5+FUvwcT741lWYlZC6BINxSldlT+ArgDsuFxNzS7EhvuG3m6OZqVJxjJyOi2CC7wRBO+Zhzqkr95LPanUSSYjURPpoEZ63eA0oh9bt4GFpUxdoBOZ2t4uaS8DfDrFNiXNzZ+PrhxTdzWe7W1BGIhYFRbaEO9EbLE+qGnnllIVeKLbbYckd3h1autEdFQElKn0ONYNsmSpGExEZ2C2+XmBLk9p21ihAR3Cru/JPw1eqOsYUUfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KHm3Z2YDin6x41X9PAzbZzoRPQ1njle5WbJtlnugVQ=;
 b=fgNvWX1IpoVjmn96b8BaJwDdv2PImumbqWtlcSXiVJ4mYalB8/YMnpj6iaFoJ/Apb1jQctT4s7gcjOiGF5f91q4vFmqf5N3h/uolzjgC/1b21L59Q5B91lZMUpSJwzVPixSoDXQSHm1djyrLDgLuz7nZquENJi0evB2G8JlXwS7sOiQcd4Z9EdF7SAsOHGknRnN3Lq86+YG0UgLZQaMFkOnfyo4OijUayeFFhNxxBojrc8Yc8OI1YKpYUlN1tl37a8TXGW2m2On32v52P3aLVVx+392uoFNPirT7BQbngsmRGQdGESUMrRT+/vOYh0zKPfiTH9yWxuA2hBYqUh3iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 11:09:55 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:09:54 +0000
Message-ID: <37cf9088-b050-4788-b870-f28f0fb58b9e@intel.com>
Date: Tue, 11 Jun 2024 13:09:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew.gospodarek@broadcom.com>, <horms@kernel.org>,
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, <davem@davemloft.net>
References: <20240608191335.52174-1-michael.chan@broadcom.com>
 <0cece70f-a7ae-47e2-a4a2-602d37063890@intel.com>
 <CACKFLikFP=xCKnZC_V+oEeFeS-i7PAKHmDFgZKBy+Sb1rKuTkw@mail.gmail.com>
 <CACKFLimMfDTatETF+iTWkCBhVH80O=SC-u066XsREoQgVEmmpg@mail.gmail.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <CACKFLimMfDTatETF+iTWkCBhVH80O=SC-u066XsREoQgVEmmpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a77e99-41b5-4891-8307-08dc8a07057b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUxrZXJHbWltMWJIT0w3QmlZczFMeTNZTkpXaTdWM3ROWS9icDQ1bEpRakk3?=
 =?utf-8?B?ZktSaUtndThLd2lYQWFTcXp2MEVRa2VPSFcxa2tDRW9CNTNCcy9ZRkFtSU15?=
 =?utf-8?B?aGJMdUxtNHkwdDRQbzF5L2twSDhnNGJZcmZSSkI1TE8zbW5SNVFtT0hSc3Vj?=
 =?utf-8?B?c3ZWK0lIS1ZDU0F6TXZHc2ZYUk1uM0MvaDdWL0tYZHBUNnhSaWRlRlRzQysy?=
 =?utf-8?B?emlGUnlKKzU3Mng2cjRpMmdyWjJ6cmRCeVlXaDdZZU9SZGpGWWJ4UEExckpl?=
 =?utf-8?B?QUUxeDZVbWQ0bjBodUVXSEZFT0pnd0prcnorQXdZMUlQakJ5bWNnT25BODFl?=
 =?utf-8?B?UkJxQWNZMzlSZDAwRW1mSjM1TkhWYzlrNFlGVFg5S2JMWTEraGhMc1pwNDJJ?=
 =?utf-8?B?TlBYMFJBMGFjYmxhNVZJUUw3WkdVVWtwcHowemNoME01dWMyKzhKYWZSbWhS?=
 =?utf-8?B?M0l6ZERQaWRJeDhKd1JJSjZRanF5TFBtRkVabzhVUU9qNGpmV05EbU9LWXN2?=
 =?utf-8?B?UDRxKzk4aFI5RVJLZnhXelBaZ1QyQ3Q4TTBzMmwrOGhlTFlHVzVYWjBycWMx?=
 =?utf-8?B?Z0kyQncrOFdPaWt1ZEdtR2h4SkNRV1phMXFaa2s0QUw2eTVGSXdkVFFSNTEx?=
 =?utf-8?B?TVNFUHFRNTJqRUo4ejZDV0xaSWZzNjdzbTlIS0tyWmpQRVV5NjBKTWIyTVUz?=
 =?utf-8?B?c3d5MEtUTGZCRzVwSGdUUG12ZnFGY2pCaEdUZ2ZSTmI4cEtlWGwxSlRtM2k1?=
 =?utf-8?B?RUlZOXFvMWZ1R295NjhxOStmMzFzUUozUnNqdlJUMWNMeVpYOWlMN21mTWNX?=
 =?utf-8?B?Y3lHVFRMSVNRWWRTRTM0aFVDN0tmMUw1Ny9GNmRwaHEvS3QxMUkzeFpFZ3Aw?=
 =?utf-8?B?TUVON2FZaDVSWlo0N3c1bmRFVHdyQmUyaEFGbHdkUDh0S2ZtUi9kd3BRQ2VT?=
 =?utf-8?B?RVJNRVVDcERKZkNhdzd4M01tTVlJUlNHa2E2ZHIrYmtoQTYxM01adVllNmRE?=
 =?utf-8?B?SDVwUVVyc1Y0clZHL2pDbWVUbGEyQXN2b0NyR0FTQmxYMHppT2FpblpGOWI3?=
 =?utf-8?B?VE9acG5UanptbVBvbXZPMXBObEtHZEdiRzZ4ZmRJQkY2QUo2TmxpTE1QbWFB?=
 =?utf-8?B?YmFOTGxBVmpqSDhLY0dDZlUwWlRaRW91OFBJbjBtTDZ5UklIMWxhNE9wQXE3?=
 =?utf-8?B?aGVQVTJRcHZwMVdsZzB3QlYrWnJBODhSRXhjZ3UxUzdvcllzYnExdEpLbHNi?=
 =?utf-8?B?WnErSVp1SHA5MVRtaGJYNHNxd0lPbHllS1VqSXpiT2h5cVMxUUhOYWRRSU9W?=
 =?utf-8?B?eWpGby9razNlcFk0R0FURTJoMG01cW9yMG1NSTJJV3FSQkZBKzhFNUhnRzht?=
 =?utf-8?B?eERQVVNDaG5oaUxqQXF1eEVGNXl5aVc0ZEowbTdGdGZHMENVWThyc1RBZUx1?=
 =?utf-8?B?UTlmSjVzVEx0LzhUT1NGZForZ1ppNEFHeE83akpLc01Jd2RvZVdqMWpseWJP?=
 =?utf-8?B?SHZ6eSs1OGswYmhtV3BGMTl1RHp2bStsMG9QREFhNStjTzdqMEE1b3V4YjJk?=
 =?utf-8?B?cDgyZ1lDK1BjaXdBU1MyalRsRnJEcHZOemJEU01FRXYycm94ZHpORXhKeWox?=
 =?utf-8?B?ZU82a25IV1IvV2F1RHRIYmZleHhwSW40VDc3MzhobTRBY2VkMjIwRTVLdE0v?=
 =?utf-8?B?VVRqUzcxSVdjclpIb1JheTYvTzVwUlM0OFZhWUdxOG1PVm9ML3RlaWZSYjRM?=
 =?utf-8?Q?Em15QHeBPcfnkH+BCA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUF3NHBqL0VUeXFrc2ZLcWNlc2R5RERTUVkxYWJWYm1Ya0ZVaEg5RlhwSE5s?=
 =?utf-8?B?d01McmJVOFBId0hVUEFVZGZrL1RPajhkNXduRkl4b3J0cmVOUUE4bk1iUm1v?=
 =?utf-8?B?MXZrUTM4eHp4NkZqWGhieXMxWWZ6b1RCZlRsY2s3TUhrclVjd292eXZvUjNt?=
 =?utf-8?B?TmxDNHBWWURJYkhWSjRheEU4M1p4MVRIOEVUaXM3M0pVaWxYQk1Vam8wUllZ?=
 =?utf-8?B?T2xmbTRlM3h0RDYzK0YvYmtKcE8ybldkZDhrOWttdlNtRXE0OXNJSmMxK0Vz?=
 =?utf-8?B?Q0svOGUzR0tMUEgvMWZXN3EwcXVhbXpXSVFoYWZTMS9ZTDVsbU42dG5INUI4?=
 =?utf-8?B?WVUzNXRvb0xkd0dnUzlsWDJpNmZEYXNORDFPZ0ljcEsxd2dzcmlmbjRGR0cy?=
 =?utf-8?B?WmFvN3VhaTJjaHFOVVBZMVNKanBUVlNwWVhvc3dudlU5L1dZVmVubFhPU21p?=
 =?utf-8?B?R1lPeVBYNVl1SXZuU2JTQk1aZGpZR2dQS2tuUlRYNFhQRkhKWFhpcDdKMmxT?=
 =?utf-8?B?SkNxdUtXTm9JU3FSZU82ZE5VWXhmRW42THB6UnYydXlyd2hxWGxLYnFObklB?=
 =?utf-8?B?allsNExjRFpiMmlIRElIY3R0YVFYNmZOcDgxeVBBSHZabUZXalZtTVQvMHhx?=
 =?utf-8?B?RW1YQ0VRMVVaQnZyQkwzRzRzbEh1bHlDUU01SEZ1ZjFHRFczbkdnaDUvaG5x?=
 =?utf-8?B?b2pRUVN4WUhrK2hUV1NUWTdLQ0ZwQk5waDl5QytjN3F6bE9qbWxmenl0eEQ3?=
 =?utf-8?B?QUR1eUhKWXBscWVGNmxrUmZ1RmVJMVAxaGZiaVJLWUM4cmEvb1hxT0lJa0cy?=
 =?utf-8?B?N09aYThoUlczZUF4YjBjZXVMRDMvRkhIakVDcUYxT3JTdTUvODIwTTluKy9h?=
 =?utf-8?B?Wm9GdEVDMi9HODZhMUZGUjgrVnFDMWN1dXl6TUNCaExHUHVvUGllVFhwalZ0?=
 =?utf-8?B?eU16RWtYcWpPU1RacDhKeU93UkV2amkvaUdUVTFubFgvMlB3Q2llMkIrZlRE?=
 =?utf-8?B?dFZ6QnlsT25IVVNRZTl3V0hGM1dManFQRmdBREJVY1lTUDZQb2F5OTVZVTlS?=
 =?utf-8?B?SzdJRTBXTjB4YzRoNXIvano4dTVWdkNidHZKMEEzbjExZHVBZlBIdGZXQysy?=
 =?utf-8?B?RVRtczNrand3WFJJR0NKT3huWHU0Wk5xRmxOYm04TkJQL05YY0tpcmQxOU0v?=
 =?utf-8?B?ZDAxR0VnaUVyeS9LdjZUWkJrNHRCNGhDbi9ZaFN4YW42VUF6czdsR3I5KzZN?=
 =?utf-8?B?UVpMMTQ5UUNoVTlQNUlYVmNQTHYwOFJBbnBRQ1JXam9sd2d2N3BvWjNGM0RH?=
 =?utf-8?B?UTk1SWhUb1pCbVQvV0x0RXlmOU9pSGs3b3FYaVNtTm96YU1oOFdYdTRvM09P?=
 =?utf-8?B?WG03aWJGL0wva1kvVm40WVYxa3o4QktCbEQ1NzhDWVZvcFQ1eGJZV0F2Nnkw?=
 =?utf-8?B?T1c3c1A5R2E5aGltbU5iWG9NWk5WUkFOOUpyTEFlQTJoelZSaGFKNTRkc0VI?=
 =?utf-8?B?TSswdnlTZURhTzdJMFdiSEZnVHBHT25Ta01FNE11WGE0WGc2ZjZzR3NUSjdo?=
 =?utf-8?B?WGs0VEVmUkpGZ0xXMGl6NzdqdDI1aVUxTHZXSHdaMTY0a3h3eW9QbzR1WXFG?=
 =?utf-8?B?azR3V0d3N1A1akt3N3RSaXNVcFpSajlFeXNSaW90ZGxKVC8xMThsMXNCcVFs?=
 =?utf-8?B?UlpxMDhlZzNJcFhheEFib3lOdjR0UGl0amZTeERjNHBwNHhTTEZkd2tUUHpR?=
 =?utf-8?B?UlgwajhlQmRRdmZVQVNXNTh2QThxek44RzUxRXdGN0l2cElmdjRKeUFvYWEx?=
 =?utf-8?B?emhHT1BkNjVtaU1YdnVId1VKbCtjVGpLVFIwYis5WG92V1JlREZLaGNJMzZS?=
 =?utf-8?B?NE0xQU1WcXNzUWNoVWdVUkVXb3FDQzhvMGROd245YVJ6UGFwWHp0bEt5U0Nz?=
 =?utf-8?B?K0g0S2JtTHBjdEdmQWZrbWN1YzJZU2d3L2RzeWgydEl6S1RGUTZ0TEJZRU1H?=
 =?utf-8?B?SFd4TFozZk5VRTVUWWsrR3gzZTJrNEp0MGhQVmtIMFNIVzloY3J4TTFVL3pL?=
 =?utf-8?B?Q29EZ3V1eEY1RS9mYytZaDZLSm1ucXUyUGtZMEQyMG9iTlZ0d1g0Q3plY0pw?=
 =?utf-8?B?RGxuaEJwSHJndUh5dGd0S1pkVGVzemp5NFJPeGovdmFuWDRSaGl2aExVTm9N?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a77e99-41b5-4891-8307-08dc8a07057b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:09:54.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DsGNWNtUrufocwMGJMDDjENMjeBR639OZg2QuVZu7pe4I4BkOcdv8L/x7HdBZn/ZXCKGtUxgaoCqZYUUwbvS/9mXI+ybIyT4IHOBCCeiPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

On 6/11/24 01:52, Michael Chan wrote:
> On Mon, Jun 10, 2024 at 7:00 AM Michael Chan <michael.chan@broadcom.com> wrote:
>>
>> On Mon, Jun 10, 2024 at 4:38 AM Przemek Kitszel
>> <przemyslaw.kitszel@intel.com> wrote:
>>>
>>> I assume that the first 96 bytes of the current
>>> struct hwrm_port_phy_qcfg are the same as here; with that you could wrap
>>> those there by struct_group_tagged, giving the very same name as here,
>>> but without replicating all the content.
>>
>> Except for the valid bit at the end of the struct.  Let me see if I
>> can define the struct_group thing for 95 bytes and add the valid bit
>> here.  Thanks.
>>
> 
> The struct_group_tagged() idea works in general.  However, the
> hwrm_port_phy_qcfg_output struct is generated from yaml and it
> contains a lot of #define within the structure.  So it looks like this
> with struct_group_tagged added:
> 
> struct hwrm_port_phy_qcfg_output {
>          struct_group_tagged(hwrm_port_phy_qcfg_output_legacy, legacy,
>                  __le16  error_code;
>                  __le16  req_type;
>                  __le16  seq_id;
>                  __le16  resp_len;
>                  u8      link;
>          #define PORT_PHY_QCFG_RESP_LINK_NO_LINK 0x0UL
>          #define PORT_PHY_QCFG_RESP_LINK_SIGNAL  0x1UL
>          #define PORT_PHY_QCFG_RESP_LINK_LINK    0x2UL
> ....
>          );
> ....
> };
> 
> The #define within the struct_group generates a lot of warnings with make C=1:
> 
>    CC [M]  drivers/net/ethernet/broadcom/bnxt/bnxt.o
>    CHECK   drivers/net/ethernet/broadcom/bnxt/bnxt.c
> drivers/net/ethernet/broadcom/bnxt/bnxt.c: note: in included file:
> drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h:4211:9: warning:
> directive in macro's argument list
> 
> Because it's a generated file, it's hard to make the drastic change to

is this generated as part of upstream build process or just manually?

> move all the #define macros.  Maybe in the future when we restructure
> these generated structs, we can do it in a better way.

You could also just split struct into two and combine them (packed)
into hwrm_port_phy_qcfg_output and add compat one as combination of
hwrm_port_phy_qcfg_output + valid bit

If you don't want to do so, please at least document in code that only 
the first 95 bytes match and the last one is different

