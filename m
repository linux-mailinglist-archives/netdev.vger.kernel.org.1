Return-Path: <netdev+bounces-174413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC5A5E806
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C603B1F9A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BD1EFF81;
	Wed, 12 Mar 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfCj5ZjB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADB1B0406
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820949; cv=fail; b=bnazLMjKgDG0QT1C6gXyUEpcauSjDBSl+5pq/VZsdmZXyt9UNTGkYdJtMDLPXuIZS7QTScO2bXx/fQ/5A4qp4ZIB0wf++ZwkewfAvhlmBbVGqDRNYUj2IvC2RVmhOsAHlJ5bRLbTlPXuYCMtM2r75fgyL37/60WHEnZlEhDIzaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820949; c=relaxed/simple;
	bh=P+RQlHNImiuK8MNfPP7OmP34X7TY32oMaZaOUgqySpE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQda3DrQGCQS8fFXzF2n/kNFAKGzxgIjWNj5t+lxjw2Q/46sbT4w0TuTCZvndA98H8fGdlrbo9qH5M85EOGd6awr06NBxo01oC61yW+18lzs836pOEExeSJitGiLguFaqonaJMfyhijRV43IrHGGV/E+lGT71o1jQ1Izy8af5i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfCj5ZjB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741820948; x=1773356948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P+RQlHNImiuK8MNfPP7OmP34X7TY32oMaZaOUgqySpE=;
  b=dfCj5ZjBCmDw160gRnRPk9yAtZs1lBVa+hh2S+T0tk9rt2TlT9Nsqzd9
   4HHginn5WExM+u/GajMg6KG000HNSxi6YXHhNHxZ/1J721gjiBXKl5bNs
   Sz5nbJEu87Ry+Csk+o/musfXznX6EEGj46BGJIExNNIqJPEPc93FJD8Jh
   qruIctCe0x9FPMLOudbkRqQ77XbUN5eNxXXGdTHQSRQgUpAHlUsMVGqtK
   3xF32yZYq2Mf0bzkprScTwvzberFudsLKitb8PM3VPDWTIDaihlmFBrnG
   kUTInp7o2xyE3lbWrklhoFs3kqKOAXUG2eDVkzUrtqqogopxecvQVnG3J
   A==;
X-CSE-ConnectionGUID: itV9wdKKRpmuTI+DCXxFwg==
X-CSE-MsgGUID: EYfpyso1RBCi9S1AqBjSjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46831061"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="46831061"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:09:07 -0700
X-CSE-ConnectionGUID: J+xyiEV5S1GuebuAtvF7XQ==
X-CSE-MsgGUID: gPHG2DqJQYKoHdSG6a4tBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="120736385"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:09:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 16:09:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:09:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHYsiUigZ2ddiW9heKEzS7r8Q1pg2WSalBHMZ4X+pKAN7quLo/bzHT9G6yJEdzIvO0zGyCU8dw2XOhtPTR5Fl+7uE/igNbzuBPLAtxOXjBj0Uq2gvIVCW+jm9KU0n5wGdg3WfYehoTggjGLudFcLUsyhendTnK43sO/6UZXjmh23Vr+5iGFXIK7V/hlzzwa0oUiKRmNCy5/OlyP6h66dGENAkLXiWe7zo2Llz2G+aLgusBqiKtKeQF/dNzDQ/c8i2bnnascJoEu44Rf2DJeaPiBIuyNvhlua9W8x7u8WB8V1CjMDcO39uu2dQ97E1AnSTki/dCSZGrw+xRjDU+a8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v085Q/FZbBnWpudluYUL64Xqi9iSp9tkVP1l1VIakjI=;
 b=AkR6fWLilB9UYOCMywNFXj00/jcYb/mQ4l1vfbEdNOCaG8O3KOeHX8y5B9r5lxrRvgercle1cqbMm5wmsnpUizTM8yhWXrjE8SvCGrlp9rpGcLf3krFNAiqVqhZp/cqiPkTRfge8rkgDZv3pX1kyjvgv0VxnLCCnqmBXpglvtyg+b399U7hTRpm8T/3BqeKHJobYpuheCJ5j+MkvGUn0UK7KpZpdHpUJkYzZuBX9MZXLic/+5UXe8gnaY9m6bXELd7Whw+n7A9Wz34AAOw/6Gqvey0k6NRC078hLDaKYDCN2kQsIF5CG8UdZ9iSDTLQE7lprx1vcwxTpMQzpxa4GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:08:58 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:08:58 +0000
Message-ID: <0347b9da-1b62-4763-849b-269a69135649@intel.com>
Date: Wed, 12 Mar 2025 16:08:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 07/10] ice: add multiple TSPLL helpers
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Milena Olech <milena.olech@intel.com>
References: <20250310111357.1238454-12-karol.kolacinski@intel.com>
 <20250310111357.1238454-19-karol.kolacinski@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250310111357.1238454-19-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bac2d4-0162-4af0-e25f-08dd61badebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0dMTEJITTg2RHZ1THJialozYWFkcGJ3aGNad0hCbnMxa1o0b2RBQkNnb0w2?=
 =?utf-8?B?aGJtNVczVHlZS0xwRTloTi9JM0k3YzZsTzUzMnhzU2dlc1M0THRSWXE1UEJH?=
 =?utf-8?B?MklwZXliT0pmcTlkemxJOU8wd0pQZ01EYlZPMkh0T3BsbHE4dEh4YkF4NW5Q?=
 =?utf-8?B?WkpUMDM1TFZCdWFTVU1vejBWLzhIMHJ5ajg5WVlRcGtIODYzWlVHYU43NUtZ?=
 =?utf-8?B?OEZQdE81V2Q0Tngva0pDbHpFTTROUmFzb1dOVWpvZ0M3bXFYV0NSNzltUkJY?=
 =?utf-8?B?MmpZYmdXZXh4M0h5amtHOEU5RXM5dVlNalZObXN0MmhWN3FDeXcvbWlYS0lB?=
 =?utf-8?B?WXZyNysyZmtMUTBESjRhQXd4ZFpDbk50NWpwSkdOU1ZxQklGSzI1NnV2QXNF?=
 =?utf-8?B?T3ZJM3VCamI4V0tUVkJjcjNvaVYwTDNqVWNMemVoM2xIdkJRaDhCVUdDY3NO?=
 =?utf-8?B?S1JkSW0xU05sQmtmL0drcXpUUm1DVGczajVQenAvMkdZUk9uL2o5cGhDZjc1?=
 =?utf-8?B?TWp1ZDVjSHVBWmpaWm1oMi9mZDRZZlpzb1F2VlZMY2xGdy9JRzhSYjAySlgx?=
 =?utf-8?B?SnBUdlB1M1k5R0RacTQ3elAwRHFuNGQ0djRoOS8vNWVmMFRZUWJjZnZVYTV2?=
 =?utf-8?B?NTNodGN1ZDlQYzZ4dnlsMDNIWDVsZklOeEdxSTMvK3dpeHF3TmtCalhLMWRH?=
 =?utf-8?B?Ris0SGxPMXhPSWpaTFIybXE4aWo4YUEvRkw5UVMrY0c1elc4dmdRalhnRFZH?=
 =?utf-8?B?SCsxclp2ZFk5QzVzVGt5NmxvZFpXdlYwOHhPeVJmL3RVRkFvbjZYWW9aS3Iw?=
 =?utf-8?B?ajcrcWhpM0FmZU5YYi9CQStnWXQyNnNXaEZQWXY1cFNGWWRTL0puTkNXR3pC?=
 =?utf-8?B?SitIT3dVbkdNMHl6QjJ0cmIxSXl3M2wxWjBxcS94SW44dHZmcFZ3eFZFNUtW?=
 =?utf-8?B?U0xYOUJ1NW4rQTV6RHNEbEpzTGY4L3V3ekFSVUlTUWpLWEJBVEdENlZvU1ZW?=
 =?utf-8?B?d1hIbUFLNDJTWFJGSzVvVW9mOFZtS1JSRlNUVzlPcUV2OEI4NE5RMHpBakd6?=
 =?utf-8?B?ekhFMmZkWlA0a0ZPL2J4UjUyci94ejJWWkJkQzZzYlgvdlJ0MTBYNStYWFVa?=
 =?utf-8?B?Y2dQMWsrOXZjczlMUTUrcHRKb21GNHpmWDJ6eXE0WmhCVXNLaE14UG5BaENO?=
 =?utf-8?B?RVdGeG5oVmQ0Qy9WSDVNUEFVaEFTVFhuT3RFSVB5Q1YweU5yZ3QydlhuNEx6?=
 =?utf-8?B?N3N2cStGLzVUTVIrR050U1BNWlV0VmZscDltR2N4TSs4ZmJXb0o0UVFGMUlp?=
 =?utf-8?B?NUZXYm4yZzFiemN1UnozemdqbTdQUmNvcDd4cjBlcXBEWEhiczJsckVzSTJt?=
 =?utf-8?B?ZVR5K3VaZktwSXA1MjFVYXVPSXpabTlxUDl4a3Q4WW5ubE52WlQvSXd2TjYx?=
 =?utf-8?B?QW5hWXdMQXBBMGN3UkZwcG5BSG1UenJ0QnFqalBGVjBiNmdjN3owRUFUNzJs?=
 =?utf-8?B?cVQzNS90dTZPeWpaWTFpUFZua01wSjFkcWtSM1MwK0duaHBHUlpuOEowODMy?=
 =?utf-8?B?UnpSWmxaVnlmMkJLUnN1dnNTTXlFMCtGWmJBT01UUXZLb2RIRHBhY2wzZDRB?=
 =?utf-8?B?YWxYVG8rbGFEM2xGUkR6Y1JpRThsQnFrRTR4QWZBZmZBY1R5VEpFQjYvOFBj?=
 =?utf-8?B?a2tYRnBKRmp3NUZlMTlvcW8vVnBaZ3U4aHV0U3hMNmZtdStsZ3JTYnNrblk3?=
 =?utf-8?B?VUpCNEtnbWpnbnEzeXRiRlpaNnJqcUxsZXZqSzZRMzVCZE5sRHVoUVV0c0R6?=
 =?utf-8?B?NWpmSTZCT2FKa1E2MXBwNmlYUzlrYllnZ1gzbmV6aWlhUDJET3U1Q2wyclVQ?=
 =?utf-8?Q?ekUiZdy1HdHNm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEx1Wi90TWxSOVhaVVRLQ1htYmNtalhCdEl1T2V3ektEV3o4bmFCMjJiMTJ0?=
 =?utf-8?B?bWR1UVd6OXlqakswVTh3cDJ0enRYckZaMUwvQmhJZU52SFhsYzRHUysrZVJT?=
 =?utf-8?B?aFA0MmxKNFl1NWdGaElLaEJvRE1mY09pS3JwQmpVdGtkS0ZtZzY3LzRrQm1T?=
 =?utf-8?B?R3VPeWIvY0hkQWcxa3NpRVVRNkFPbUxhZWZtdGZUUVZMeGM5ZnVMTDBmbGpN?=
 =?utf-8?B?S0o5cVUvVFdQNlUrWlpuWTZFdnVUdHA4UGd2cXlwdVlCTEZBd1RtUStLWEdB?=
 =?utf-8?B?YVJRb2tBN2ptR0RnblR6SnRkb3hBdVIyR0ZhMldjUm1zcGdSWFhnRWJxSVZj?=
 =?utf-8?B?ZnoxaWhzMXlVNXZaak5IaFJ5MUVGZjZZVmxiQytFcTRmcEJBZDZJSSt6dkhB?=
 =?utf-8?B?OGNkaEtxZmxjdnNrUUdiRGk4cFUrUmlBZWJpSkRzVGk0bzY5TURuenFQMTk4?=
 =?utf-8?B?elgyTmhqK1J4SGRkSjRvaHdwSEJ0c2dGSldRekRjSVhKSUprbzBVZUxLcE55?=
 =?utf-8?B?M052R2llRzN2ODI3TUd5KzN0ajUzL3BUbUxVbElpVCt5cmd2NXdqMy90Um85?=
 =?utf-8?B?ZGVqaDRGQU01cXJYSDE2eGhrdjBsU3dlUTJGZnRGeEovT1dhYVRUaEdRQS9t?=
 =?utf-8?B?QnVCc0FjMFU3VzJyM2dLMmNRMXhxVnRDajhrRzRMRXFQeGxBa0pIK2REeG1Y?=
 =?utf-8?B?ZFJXM3BWcWZKMzJ0NzRzR1IzMDBhc0YwYkxXTTJxUXFFWElJVTVRQkVOeEln?=
 =?utf-8?B?Z0gxR3JnZTkveXZKTi96MStLMTM0bGd1dWJuYTlvSXVJWGQ3QTR6ZWxTeDJR?=
 =?utf-8?B?b1AyQ3UvczBac3V4RVlTZHRZZUpCUk9hZE42ZGlZUWxKQ3VJWXBHKzFuVUVp?=
 =?utf-8?B?ZnA1ZGI5aFd3WXppMVNsaWM0OTIzYWxkSFpoVTZxTUhKZjh0aXpVdEpjN01i?=
 =?utf-8?B?VzdleWYwOEZFQkxqc0YzaDNjNmZRK09lUXJQY1Z2TzEzUXN6K2FnUy9WMG01?=
 =?utf-8?B?bWk3OW5NZVZrUFpRRWowZ3F3SkV0ZytBMXZQOUV0dlhkcjlqNmMxajZVNlNJ?=
 =?utf-8?B?dnhoVzF0VWE4Njk4MDFYajhPaXlMcTVBMnR1V2lPQ3Y1R256SEV2SmQ0eWd6?=
 =?utf-8?B?NkFlWlBZMThzdFJRWVE2WnNCTm5heXFvUlozbVcyekZoLyt3dURpdTJ1QWN1?=
 =?utf-8?B?ZUNUU1ZNcHR2ZzhHT0wwWDFTWk0vV2pqZjlURXJNNjhIL096ZzlUU254VjA5?=
 =?utf-8?B?aXhTZEtqa0thUnRXUHF6MGs2THBleGdYSVh0Z2s5UGJzL0hCTmt2K2dHWG1s?=
 =?utf-8?B?Y1pyMk1oMEhwRjVrdFErL1ppSkV0am1TZjlySEllY3grUEJJWm1RZkZDZEd5?=
 =?utf-8?B?bTVGWXlBSkdrTS91dm9jYVl1K3kyTmR0VVlEZjdHSlNlQU9OanBwbTQyTmE5?=
 =?utf-8?B?WlNoMFlDY1ZWbFluOWQ5dmVTVHdFd0E2LzlSWlN2NEd3bzg5K0ZqdEgrYllo?=
 =?utf-8?B?QkxZN2lEZHNlbW9tMjRGT0U4VWZzaDJtSzVKKzkxK2l5VFdyd1ZObHl5SGFQ?=
 =?utf-8?B?NVBaRXRxcVJ0VDRxUk9HdWs4NVFtVm1Hdk4zcTRHWG53TWhnbU5hc3JwU3JL?=
 =?utf-8?B?SWF0amlYRWdJN2R6VGFGZmtFWDJ4N1VtSFpEalVEN25lVmFSRUNHaTk1UlYw?=
 =?utf-8?B?czN2T2Mvb3RWWTJTV081VDd1SGdDcEU3MnRkb0srTjhHdmRpWERkMmZoaGlt?=
 =?utf-8?B?dEV2WUl5UnlmVE8zVmVzWGU2UWtnMklkaGVaWHJTWVJvbFNqemtvaDgrMmZY?=
 =?utf-8?B?dG5XanBVY1hxMTJpU3JXREtyT1hWb0V1bTFzeWJaK3pXczdqNjR4RzNMdi9P?=
 =?utf-8?B?cVE3cWswMFpXcHBkdUFzU0dYWEcxQTV4OHR3Zk5WNVRkV3JLVHFKWlV5ZHg3?=
 =?utf-8?B?YWpNWjl4YlpkeTBEbXJGSklGMGM5Z1I1TWthVTU2bjROanQzbytveGdpY21C?=
 =?utf-8?B?L1NjeVpRUndERndWZ0VDTEtFakVoTTBHNDlacUZJcWZVck1GSndUUm91K2Nr?=
 =?utf-8?B?cXFlanN3VTFFTTBPaDJBYld2dUdVVHQ3b0RqUDlHMWZVS1RKS0FybERXNGgx?=
 =?utf-8?B?cDlTbkZ6SXZKaHExZ0tWWVIyVFZ4ZnRqL2xwTGdpM2czbENVcDREc0MxZFNE?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bac2d4-0162-4af0-e25f-08dd61badebe
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:08:58.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKb/lXcpGZ0eKVLAS8j4VPM1trYiNQV6bwDxARbo8HV4T8AKGww8kCWiAGWJcxIMEFdXRRwU+ULHtZrP93kfaWd+4w+jFUDtqwx3u0Fk7zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com



On 3/10/2025 4:12 AM, Karol Kolacinski wrote:

...

> +/**
> + * ice_tspll_default_freq - Return default frequency for a MAC type
> + * @mac_type: MAC type
> + */
> +static enum ice_tspll_freq ice_tspll_default_freq(enum ice_mac_type mac_type)

...

> +/**
> + * ice_tspll_check_params - Check if TSPLL params are correct
> + * @hw: Pointer to the HW struct
> + * @clk_freq: Clock frequency to program
> + * @clk_src: Clock source to select (TIME_REF or TCXO)
> + */

These two are missing 'Return:'

> +static bool ice_tspll_check_params(struct ice_hw *hw,
> +				   enum ice_tspll_freq clk_freq,
> +				   enum ice_clk_src clk_src)

