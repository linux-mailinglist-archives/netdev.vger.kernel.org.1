Return-Path: <netdev+bounces-219643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D544B42777
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3282685E6B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E0271456;
	Wed,  3 Sep 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcrpnJWg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359021ADDB;
	Wed,  3 Sep 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918883; cv=fail; b=k47wjDaQNaaeqGHv8fiTJmYhIY9btIPhV4dimluZb+Vuis2c9tA/YMHSv6OTlvRGenNf++VIWUfrf1pWz54xl3OXwOjkkwIccMb5XVK0n9iEobMEEWwiE6HIBqm0K7oD0EkytVt+kTrBjO4HHJkIQj6cpg98OYz+DU6Hmhx43BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918883; c=relaxed/simple;
	bh=qmP5MW9xjyRcJEncHCZuW1ElcVmgoQH6mNgnXDRP8n4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hHYlA5UOpW1x2u1zt2lhOUHBAxwGQu8vtg6F+gzH7rtioRmOSOInbdu/rGejqHoXhsfBqDf85OFxPni0xYVcMFmPaThXV9MyVAfSxA57L8ffmjRUV6V1X3WzqQMmE8FSJvCMlcpY3buQC0CtikJXOYz5kOO7DeIIMhC93VjqtSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcrpnJWg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756918882; x=1788454882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qmP5MW9xjyRcJEncHCZuW1ElcVmgoQH6mNgnXDRP8n4=;
  b=TcrpnJWgUPv9dwaBn1fffireLEdS+4rpoaYj5XHNJifFoBX4hr+RZivO
   6ePSj32tPsP6waf4KyFgWQJDPZMWlQaWiYyrJrEQV5cVI7JhAr6gSGiVX
   PiyIT+vU2dxZo6xtwJL65FEbXbgNaeqhPIWgoAtijuwEyh32Mfzh2juWj
   osmztOaQgRmSAq+8GBXnZ8KJ6WcxV+i+6zsdc7wDnsIkCO08t0XfCV+aE
   i1pBjhIQvPfx4IshNkbURq6/5IKSFWH1aSTGGotUUAFOSPug2bomezkOm
   ClZdlRihwxAqq7ClOTLyFwTcCqPJgLbpBfPcymPEwsvB/KPzGe8I7CQfx
   Q==;
X-CSE-ConnectionGUID: bvuDwp4MT5O4GP9ChB3mZQ==
X-CSE-MsgGUID: 2s2LFULvTim0O443AQZoWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70615111"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="70615111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:01:19 -0700
X-CSE-ConnectionGUID: Xyl5bKf/TwyfIIisOfUyCw==
X-CSE-MsgGUID: lXITySw6Rk21B7gP+C7FGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171531919"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:01:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 10:01:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 10:01:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 10:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImXRr7PjuHNFauuBaZimiLyNpg1/gF3c6y6aknv5ykJhhOX9zUaLQgCmLlkSrWmgAJjWXLjBRlAkXnVukqRD5lzp6ToDlp2jLeZi+PkhDnhZ8qu0Ox74asiTQqB+7ZmXqrr5y/C65Lb3LpSInMEEt0bH0J409uUtwhyZv8iFostaXJFNtv4JcChPXJmc2HfiSCjl3UnH1E24lHsH2SooRvIMwwl9fh6c7vtwHs1CeqEWGns9TYnXOIAnf6T3Z4xSEIL+2i0doIEAXsfV8lzTYgtReIdAUuj/0VZGYm0OO2ZHLD88e5rkP3xszUwq8mf+rEaJD9dzg5m0ljtlzOaixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHPYCt2MCY3m6i16PdeUL+nEi4DdkTJP0LFWOIeY/44=;
 b=E3RJPu5MfpZH4NV6uNQAf6xKA12h5pwjkuS2Dfdlb6ZtdGCmNd27dRxETVUm6Rfhb6TpeWZAGZZBumaKcWRARXzHrWE6Mz3QcTUYWdaGiT9ABvrUYwtnXrnD9eoncqmAdggkR/NBhd6nVkEuckxbCkBXZ6V/YoXW9bm+JxtutQwEv0+I864E1XcpisqjWGvzbR2IlVNVuFaHRkjBA5fP5NFKd4IawJxTR1Md33g5TVVI6UsUTfBn7uKpTWQGVtJ3d1leBvSoMkisc6I2gdhItmQcybdUOZYh036Eqai6epJpSOwYRcYL3PNDI+kUNeSFK0B4pnzMJsP4e/1bxH4BnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:01:12 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:01:12 +0000
Message-ID: <5bc3d561-d179-40b7-85a2-ef1ec5b7871e@intel.com>
Date: Wed, 3 Sep 2025 19:01:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
To: Joseph Steel <recv.jo@gmail.com>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sebastian.basierski@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Konrad Leszczynski <konrad.leszczynski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::17) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 806f6867-29ee-4ed6-2565-08ddeb0b7c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW14ejFsZFN0TVI4OHJMenNwS0c5SllON2dXNWxCcnpGQlM2ckkyT1FFdmVE?=
 =?utf-8?B?OEQxbEVnZVB3UE5ZRnJJNnRqWmJDSVJCV0xMSk9pVlVCZW5YcWFkUnlFS1dK?=
 =?utf-8?B?eWpFOFFuMkJJYmFoSldXY3BJa1hnQTRUQUJxaThEaW9YTEszc0VYWnVhd2xq?=
 =?utf-8?B?Q0J3VEQwOHcybEpTUEJzZWlKWGd5bUhSaVJ1enJpR0VubXJYK2pvc3F6OC9E?=
 =?utf-8?B?bStmdStaS3hSZ3hTSTNnTTBQdFg2Yk9xL1BXcWt1bE0reklrQTF6dEJYemNt?=
 =?utf-8?B?dGIvTk9CYjVGalBEV0pZSUVnVkhNMU9SaEdJWWFyYXk3OEEwcHBzNWJKWFBY?=
 =?utf-8?B?ZmFiVTBGVmR2YlFNam1SVGE0UUJoNjdObUx5bzhDUS96OUJmQVpGR0VJb3BQ?=
 =?utf-8?B?WEVPQnh0WGhzQzExdHBFU0VKOWx6R3lvNUlHK0dLME9NaFBJbUp2c1BmT3k0?=
 =?utf-8?B?MlRMRFpXUjltNlRGL3dTcjMrUlNLdWh0Yys5Y2hKRDdlWEZTNWk1UFovZ0N6?=
 =?utf-8?B?SkZiRlFYMVJ6d1JTZDV1SjJBUUcwUnVJYis4cnE1SC9ScGFQM2grWlpXUGE3?=
 =?utf-8?B?T2FzeVEzam1WdzNrNEg4K2RtTE5PYzRiMUNMTzl3OVJwSWF4SXZlaW83bm1H?=
 =?utf-8?B?R3haV2ZveXpaTkV2Sy9QUWVDYlY4bWJMRjlzbVprS3hJK2k2ejI3aVB1Z2hH?=
 =?utf-8?B?MUtMU1NmS1BLVEtkaFNTQzBJWkNyVFh6STNoODV5eHhsL0RyZnJBVEdDQUxZ?=
 =?utf-8?B?RHRQU3hLV01BWHJVdTR0WkUzQW5yNWtvcXY0TG1oNWtkTXB4c0xKcUh4TkF2?=
 =?utf-8?B?TlArK3d5WkFFc2NUY2wya2czOHowOFNqaGhJayswRHJZVVYzL1p0Yk11S1Fh?=
 =?utf-8?B?dUo2RTMyT0k4KzRvbk5jOURYdGd6YzlKTzVHMll5YWRWR09xNnE5V1F2QzVk?=
 =?utf-8?B?dkxrQkIwK1UwUjVEY25JY1lvOTNQWDJVdFJIS2Y3NGJiU1Rlc2lmdVZQYUR0?=
 =?utf-8?B?QkUvYmVQNm15QVZTQU84RThQUDFuWGk2SkRMbU4vcUV4WVBqL1ordEpBRUlI?=
 =?utf-8?B?clNyZkdKd2k0Wndick5yU0V6VnVadHBVVVBQQWl6Y0ZCeklkQnhjSjlaWDgw?=
 =?utf-8?B?QitoZElISUNUM2tieWgzdFVoV25UNFQvWDEyRFVFeEpXVHZLbFVvc04zMDkz?=
 =?utf-8?B?WTR5NS9wSU9OZngyL3h2Ti9QUnI3bERCQU40V0E4WjBJVTMxQ2RlVDdIR2tn?=
 =?utf-8?B?UWkxNFZ4KzIrRm9tN29EVGc5V2VlNGt2OG9jNUdaOGNQeVo5ek1KWTRHckpE?=
 =?utf-8?B?ZjlaeThRVFBGS1V1cHdqYnZWdmsyano1UXdzVnBkV2ROWlBxdzVDdDRSMExT?=
 =?utf-8?B?cjBoMS9MRGdNdjFQSmNyRVcyT2lpbEYwdVlGSlVVSS9FdWU4MVJwbzBka1lj?=
 =?utf-8?B?dmVYUmZQVGE4S0luRFNwQysxWFdkeGs5NzhZSWhJcXIwc3RTZFNuZUxyTFI5?=
 =?utf-8?B?WUZCd3l3bGMrK1JYMkhTOFhWSi9WWVVoMU9Nd1ZvNFpZUitwa3kvL3ZFWDRW?=
 =?utf-8?B?UTdFNlUvWThQa2x2VWliclRhdnFrYWVjNWFlaXkvRm1TSE1vSXJ0dEZ5T1Vj?=
 =?utf-8?B?clVmSE10MmVUWHU1YTVhSTRqejV2Z25CbjlESlo5czNaeUxaL1YrTlR0QTU1?=
 =?utf-8?B?Y2VHU2xHQmYwWTdFV1h0VFc5T0UrbDd5WkdGbit2TkdlSndzSFRkTFA5azVF?=
 =?utf-8?B?M3VKeWdkRklTL3doelpmMHRNUWR5czJTTXhsa3V0OHMzZlZocnFzQ1Bvb0tV?=
 =?utf-8?B?WTkwNVNicHJuTFQzU3M1RHZqbkg0VGpPWDRYSkd1WVRKb2lrRngzK1JvSDhr?=
 =?utf-8?B?MS9PS2twOVhTUXBFZTBEVVVlVkIzM2NrOVN5cW9paWcyUkdNek9wMW1iblZ4?=
 =?utf-8?Q?EKlM9wrVcWo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJxMm9GNW5QcjJlekZSeUZRa2M1YUVOVWdQbGNGS1pseEtsK2tMM0I5U2lp?=
 =?utf-8?B?ZVZZZnZRODJUakpBdFR0ODdkN1ZLWDF2LzFoZzN4dGhtQmVBMkk4Smo3Y3BB?=
 =?utf-8?B?NFdiYmpEVit3QjVnKzlpdlNIRlBROXQxYlU0dUR4aWZBVWxybldRV2x4ZXM5?=
 =?utf-8?B?UGZCRFZjREhSUHlMV09JTldaWFZGNXhJeUcvUU9ZS0U0OFlyVWJWdy9IUDVo?=
 =?utf-8?B?dVlKdHR1UHM1aTUxc01Na3krVkNNVmF6eko1ZmdVT1BSNWJUaE02dTlnZDcv?=
 =?utf-8?B?RWg3MzI2ZldJZzFQbFRtS2JEaEJSZE5Pd0kxYmw2V3ZHRGdJQWhsck85T2lC?=
 =?utf-8?B?RWN1QlN3OFhzWlVmWVI1SjVndnJkeTNGVnBaVVlSR29LWXJxcTRoZEpLcTJG?=
 =?utf-8?B?ZU9Wdi9jc1dWblYrNFhhcDlqRGxudFp3eGlQRXFROU04NjR2RUNJRGYzaWd3?=
 =?utf-8?B?NTdmemFYb1VVVENwdDl6bU9ScDJGN0FNTHhOMkRUelFVa2daL0c4ditmMzN6?=
 =?utf-8?B?Y0UrNGdSdVBSb3A4bTlrU0w0SE9GYjFBTVN0OXVmd2tXVzVlcnFiQ3hGSmVh?=
 =?utf-8?B?bm51WWJGTHh5eEM1WFdiRTRNOWM5MFpidG0zNmF3VEtPVkJnbG1QZ1EzNXRH?=
 =?utf-8?B?NG1UbVBQUlRPaW9lb21JNzVzTURCWXRSL3crUGZ5b0Q4SFRMTWRPYURLdkh6?=
 =?utf-8?B?a0dXdmJIbG0xZzFOOWozajNHcnFhSjVCcVk4cldiSktIVkxTa0VLRk1VUFN3?=
 =?utf-8?B?dGRtU3JLYkxWVzVVZklPK3g3TW1vNWJTczJUWHhlNkVaMHhwS0Z4R3krdlRn?=
 =?utf-8?B?QStKTGJFVnRSTTNzOWRhbWpIMDZmUUJKMUxGMmVXTVNnS1V6eUpTMnh4NEgr?=
 =?utf-8?B?bDJGeGNod1JEaGdJTWFvc3N6S25oaVYvRi9JYytuSzZSamVLOFgxbFVkU2Vj?=
 =?utf-8?B?ZVhYOVZqVmhoakJrUHpYamdJVG11RExBVis3OSsxb0hxTExUcWgwQmV1VjBS?=
 =?utf-8?B?QWFYeDJSR1UxdVBpL2Y3MmNJYmc2SlBpdThDWWNRSVZBU2dsWnhHMUJQWUxs?=
 =?utf-8?B?dEdJMzd3MGpzYjFDNlRMZ1NqaWNHS3d4d0VvVDlwOUx0K25PUGhRcTdUTXo4?=
 =?utf-8?B?UXNoYTVNT05ra0tTd2pDdFZGWXR6UmJScHI1Tlg0WUJ1WkwvK0o4dWNOQTRh?=
 =?utf-8?B?MDdEVk5xZTFDSDR4VlI5WE9pMTBFQ1RZYTFvK0VrYnkwZHVJSXNQUlljS2F1?=
 =?utf-8?B?UEsvVmhFSGRXc1AySG9remkxYUtQSHVoOXN6M1VDWWJYWUc0NlVUaThsR1g1?=
 =?utf-8?B?VVV4blRXUlJhRkdlSks3Zkk0enE5OUlpTDlGOHc0RDg0UkFmMEpGOGFjcjJh?=
 =?utf-8?B?dTNobXN0KzNjQWdIQUtRaVNWdkF4bEhhYXhyZlUrZnN2QkZ5amgreWEzU3FK?=
 =?utf-8?B?TDZ2a3p3SnV4QlNCTkp1UWhtNFZmQk9HZnliZVpsUlRNVDNSSG4wMzN3eHBi?=
 =?utf-8?B?a1RLbmE2Z042RjFXWmhkWWpBcmhqUU1vVkFnNmhkQ3NxY2FvMmVKMUl5SzND?=
 =?utf-8?B?U2V5YzlpTFJEMTREbTJHY3JGUGFTTWFUMGFwSW5OdjMxZjdLWXZWNG1KOXpT?=
 =?utf-8?B?Z0N5dk1qZjZHM0NQdDFtdWpsbm01RTJVdmlaejhNeE1QcVJxQ211VTRDUVJW?=
 =?utf-8?B?bWJTYW9SenJES2RoOVdzTlNIV1dkOEtEZWpYS2JZem5IdDlDNWNmSGhFN0h6?=
 =?utf-8?B?N09LalRuMXA3R2swbFJQVmQzVE45ZzBOeEN2S0hHOU9RRzdrSzEvNDR6endw?=
 =?utf-8?B?QVRKU0I0aWhuZEFtMldweTg0Sm9oQXhZcHZvZDVjNWs2WFRROG9sZDdmTnB4?=
 =?utf-8?B?aWtOMTF2c0NYN1ZJUm1WMGt5Ym9sMlBxb2V0WlJOelQ4a3RxcjJOMWVaRzN6?=
 =?utf-8?B?WnduWjh1SGhsZDNoUXh3N2plcW9ZOGZZbkhrZ0dXQ2hJM2hRMDJLN2NOMlpk?=
 =?utf-8?B?MHQ4RkIrRDIxUE9HUzdyZ3llZ1BVTHhZa3VZbUdQMk1kdGJqN3hyb0p0dmlZ?=
 =?utf-8?B?YUpKVVZ0N2hRVjFubmxGd3cvc0s0L1dpR0Q0VU5IM2Z6TG9HV2ErM3BmUHFr?=
 =?utf-8?B?Vkw3MlhrblpOK1BiRW1OUFY1QmFDbE02Q1VwQ2RtNmpJWTdURGFqNVFVNm5a?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 806f6867-29ee-4ed6-2565-08ddeb0b7c1d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:01:12.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUgykOsTmqMCpEGz++XWDclRvLIzS/E+93Qm/S86sKWGjIrmcHdpxthhWIGyG0z6kjChCkrB4lkMOIC1gZ4eziP6udR4TmEqbiAtICoEl/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com

On 2025-08-30 4:46 AM, Joseph Steel wrote:
> On Fri, Aug 29, 2025 at 02:23:24PM -0700, Jacob Keller wrote:
>> On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
>>> This series adds four new patches which introduce features such as ARP
>>> Offload support, VLAN protocol detection and TC flower filter support.
>>>
>>> Patchset has been created as a result of discussion at [1].
>>>
>>> [1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
>>>
>>> v1 -> v2:
>>> - add missing SoB lines
>>> - place ifa_list under RCU protection
>>>
>>> Karol Jurczenia (3):
>>>    net: stmmac: enable ARP Offload on mac_link_up()
>>>    net: stmmac: set TE/RE bits for ARP Offload when interface down
>>>    net: stmmac: add TC flower filter support for IP EtherType
>>>
>>> Piotr Warpechowski (1):
>>>    net: stmmac: enhance VLAN protocol detection for GRO
>>>
>>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++---
>>>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
>>>   include/linux/stmmac.h                        |  1 +
>>>   4 files changed, 50 insertions(+), 6 deletions(-)
>>>
>>
>> The series looks good to me.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Not a single comment? Really? Three Rb and three Sb tags from Intel
> staff and nobody found even a tiny problem? Sigh...

Hi Joseph,

Given how things look on the list (just v1, no comments), it's 
understandable to think that folks just appended their Reviewed-by and 
Signed-off-by tags without actually paying attention.

While I'm not part of the stmmac team directly - I do maintain the 
sound/soc/intel drivers - I did participate in shaping the patchset - 
titles, messages, division and such. What you see here has been 
rewritten a number of times before being sent.
  > Let's start with an easiest one. What about introducing an unused
> platform flag for ARP-offload?

That's a good point. No change in this patchset shall be tied to a 
specific platform that does not exist in the upstream kernel and thus 
simply has no users. The team will revisit for v2 and drop the patch if 
true.

> Next is more serious one. What about considering a case that
> IP-address can be changed or removed while MAC link is being up?
> 
> Why does Intel want to have ARP requests being silently handled even
> when a link is completely set down by the host, when PHY-link is
> stopped and PHY is disconnected, after net_device::ndo_stop() is
> called?
> 
> Finally did anyone test out the functionality of the patches 1 and
> 2? What does arping show for instance for just three ARP requests?
> Nothing strange?

I'll let Sebastian or Konrad comment on that as they are experienced 
with the IP.
> So to speak at this stage I'd give NAK at least for the patches 1 and
> 2.
> 
> BTW I've been working with the driver for quite some time and AFAICS
> Intel contributed if not half but at least quarter of it' mess.

Not sure whether this bit helps anyone. The new faces are here to help, 
not to repeat the mistakes of the past.

Kind regards,
Czarek

