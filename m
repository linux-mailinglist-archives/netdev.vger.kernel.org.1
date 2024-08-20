Return-Path: <netdev+bounces-120172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724B9587B0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E4FB2105A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB22745C;
	Tue, 20 Aug 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USiwu19u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBA18E35F
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159791; cv=fail; b=BnjDLp3MMF20LrVk8X/nzuWdrErFMn91/+LqQ9AMrdm6mhUYFqBHld8wpFkmYsfBlam/Qv1jCPojtA/5z1i3QSHrbVa39YbTGnSsiNmeB0YU84koqFKkrvAlvXG9SV4/wmTbCZPTEU2OiHeUg3ol3X4429BvC/F3fnfDXujC1X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159791; c=relaxed/simple;
	bh=xrTDTu7+w4RtawUM4tv81bxRRTZHh7H30Kql3GPhqSw=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=Cw597t2F44EkoNjhI+hD9DskkYEVUigNa631D0lXI4XvaEcbzO8tesKzPqife3NqdkUbvcGR1T/eVfP4TeYGapSf7llumPTGf/sAY6AgmTzkkS+Y84xzOPSEcVeNgMr65kRGwtPVJu7xqqUPY9d4knZHvfw8/8T13DmnHjQnS+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USiwu19u; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724159790; x=1755695790;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrTDTu7+w4RtawUM4tv81bxRRTZHh7H30Kql3GPhqSw=;
  b=USiwu19u1GrHM0ItiVXjdscTeQB3aVl6+KsXeePXl03hm19nK5X8WW5i
   MbQo4nv+V5+Ihp+5kH7Lh0+Uh1oN+IBKliq7ZkeEG/Ff62goLDrblSppC
   ix3yF8wzvSrvzW0V+tulQntRKmA2ruKhwFFm0ED9K1pkjK//krDvY1TuY
   kziX/qT9UMKlek2dppSMEIbq8WJcHV6hIoUp3iPEJIiaHqdaztf0eYBE6
   FHTZ8/HgQ92Mnn8a/lE+zHkbrdLPitRBFEp1dUbVReI2xZW1jP1bXzl/t
   zSPiQWqV6Kt5dJdifwn4Wh9RsBPZ0gWe7iMN8FGVJanHoP5KYKgX3Rg1u
   A==;
X-CSE-ConnectionGUID: XeHnKgAyRkGNHaOVKlYqkw==
X-CSE-MsgGUID: EyqzbJBHR2WAvUqZAEx++Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33124460"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33124460"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:12:09 -0700
X-CSE-ConnectionGUID: 1HLKOI0ySauLYkdNbq/NeA==
X-CSE-MsgGUID: LRe2DRrcSk6aC2KS6zte1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91498879"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 06:12:08 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 06:12:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 06:12:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 06:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhVUcNh43Y7lGZk039yamebWKmSkujkmkCk9Ic2KWAMJ3VxsI55/U2U0Ecy1l1jRH1VZKuA4uNmy2zdXKXWaw0idAHDHh+SXBDl1XT/gjXnfdaUwkNwG5/ftNC3MRfu6l1Glkcy9V9VP0xBFxV4V5JSS7jVL3Q7GIn0ruvYsEC4b5J1/guEMDIZyI4ZI2j5PZQQ0k/PVPA9ugLi9Q7tCjKQJNvbRRu4h1EapG7tAzDFB7fqwq+Guh72p7Fb994bqFmoy4grDseaEY7txsBVOXt/oAXp8EfCP3QJ9k1A3yyg/72t2wnQa4VKM4PBWyYLwAfYU7t8wpPPusatM+Y/3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oke6vvdu+gPtIlsY90SiCxG+8aAEZ64ZVQRD5fzzx8s=;
 b=YtobewjX6Xjax4Bf32qiAIRoS/HFeIz05LvnrpTj7gOz7XO0Sf5/n67Of9XzumziK1pziSY2rfhJdPMsZtUTblWeGcovlhhomFs4B0wE3avHeIItMpS5/5XucjBQ3fSKYqzX/2xElOa3Lbqey/+3seMiLnmDbHwYGCNhrznc02u53ZrzehGe5KlA2cZrhqs6TDbSsz5Jw7C1vGJ7vHOS5FPAoQ+KUxJpI8478EcOyza8zchp/mFRN+sC1dkoK8r2Mmbz50U7ABG3khn63AMlAYzJImDtjFbx7f9SiUd0HVeupq5O9b6eeQf8o7Pl105KIFgp5zBa3locVUjoINpJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26; Tue, 20 Aug
 2024 13:12:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:12:05 +0000
Message-ID: <78332215-9b8a-4000-9c5d-98e13f664e67@intel.com>
Date: Tue, 20 Aug 2024 15:12:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: remove NETIF_F_GSO_FRAGLIST from NETIF_F_GSO_SOFTWARE
To: Felix Fietkau <nbd@nbd.name>
References: <20240816075915.6245-1-nbd@nbd.name>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
CC: <netdev@vger.kernel.org>
In-Reply-To: <20240816075915.6245-1-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: b7599449-0e7d-4ce5-63b7-08dcc119b015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czRCNk5aUDk0V21USkQzUmw4Yy9QMGtId01HYVJmY25FMTRsV29pNUx4ekpo?=
 =?utf-8?B?TlNNN2RQWkdPMlVhckRsS0dGaC9VMVVhMVZPWUdZbDJycCs5UmIxazNGZU9i?=
 =?utf-8?B?RFFPUE5iRDNvRnV0N2swRnJhNm1EYmtIaWRxcWlpTEFHR0JlUkFjekRWZVJF?=
 =?utf-8?B?OWQxN3V4cVZBUnZzMmlUMFRIbCtuZXkzZGJPakRiaVFSdUF3V2ZDb3hmT2tB?=
 =?utf-8?B?b1FQWldiUndvYXNPa3BkaThFaSsrNXRwbjRURE5DYURwMVlFM2ZvYyt6bXI3?=
 =?utf-8?B?bzYrZHRFZUN1VUJrSCtBYVBQVC93QkhFRkN1VHBsSHpuV0RVVm4xdFFUY1F1?=
 =?utf-8?B?QitjOFRqU1QwOHpBdFlubHRZLzY3QzRuQXNhaXM3YU1JU2d1cVh6ejlvdElp?=
 =?utf-8?B?UGRRd1JSaUJJZ2xOS05jVGliaXd3YTlrV1Yxcmt2bGl6UmNmQ0kzNnNpTW1L?=
 =?utf-8?B?K2Qrdzc4VmpxM2trVXdZQTR4d2hZL1dnSWV6aTlRQWNSVmduSXVIQ0dtTURy?=
 =?utf-8?B?ak96NjBWZGVqaVlkaHVUQUJTMm5ZTHVsZDBpYW42TEo5Um53ZjQ2QzA5MFBJ?=
 =?utf-8?B?R2dZRGc0aG0yQnZEVGVLU1didWpqMzRucGtTanQ0ckpubTRoYVMwQnlMSytC?=
 =?utf-8?B?MGhuc3Z6clo4d1U1dnUzWUdmRzExN2NaUlQvRkVIam0reVYxVWxXMitLbndj?=
 =?utf-8?B?d0dLZFJndWJ2bmtkUUl1L0NsVjh4ZEJGOVdLVXJNZUNwYnVweUhwcG8rTHoy?=
 =?utf-8?B?aDlsSWcvdlpKWFJHc2tzL05rRXhXU2loZkdZM1R1WjhQL0tVS0pWZlR0T0Ex?=
 =?utf-8?B?bisrNnVMMmYwWDlyRDRWNlhLMDBIaEtWZHM4MDgwUm03aFZiOEZDUVNNb2M4?=
 =?utf-8?B?UG9rR3NWQnNBd2tWQnJ2MmpHQ0txQ2taMzdFNWJaazIveUNIY25ERlhxcWFr?=
 =?utf-8?B?U0laK05SWWJ3djRlcVhqOFVwbVNKNVQ4TlVWeHRraC81cmdLY1pMUUpKSWEw?=
 =?utf-8?B?eVVnU2FmdEJQYzFDVzF6SmJHbHpsbElkUng0UW9Rc0I0MTlFTFMxNnNpSFZD?=
 =?utf-8?B?anlxQTJmbXVUa2FKTmlpTDdLcTlHODFnWTROZjU1OTJhRTBUVGdubWEvRXpI?=
 =?utf-8?B?WXQ0QTJpeGJyTmJFbkFYVm5tdW1JVmtqbm9Rc3Y1bGR2U1IzdkRhbU1MejFS?=
 =?utf-8?B?c2Y1a01LSDhCR1VBYjVIeHRtb2xuQzhLSm02VzFib3dXcmZkTHVGaTVYSDRX?=
 =?utf-8?B?QVFNNFpMckRBVG1MbFhUcGhRUS81K09hRmJQUWZSaU1vMHgwZmozcE9oQ2RQ?=
 =?utf-8?B?dFJwOFI0YnVkYXEzS0c3UC9peFV4V1BrN2l1cGY5UzFMWkhsdFNCUy93dXp6?=
 =?utf-8?B?Z1YvL1FqUjJuTUtvZldyQk1iakttUVJDeVoxaHZNNVVienkwOTJJd1E3NzNC?=
 =?utf-8?B?WW82N2pPQktsZmVQaVMwSkRYNHN2Zk9iU2JCSHZJbnltWkRoSDdwMGFDdm5T?=
 =?utf-8?B?SEJHenZERGdDS0ZveXdZb01TWWZBK3hjOXdsQXp4VXI0SWUrZ2l3dDdabzhl?=
 =?utf-8?B?U0tIcWlRbmgwd3cwL0pUUlZ3NVVzeW9kbWtNWHhXTThEd1ZhSTlRT2hlUzNu?=
 =?utf-8?B?TW85LzIrT0hUSWwrVDRlNWpnMVZYWjJiN0pPSTlrT3RrZnd0NmxtQkVMZ0pv?=
 =?utf-8?B?bkZLeGpyMzNvOWtVNTYzeVlyUjBRTGZsTmxyaHRodHBTN3VQeEthQTRGMzBZ?=
 =?utf-8?B?UzloWGQ4YlBSVXFzeGFXQTRRWFFkRW1mdUtHY1RWSFZKNzI4ZFlESXFxdzd3?=
 =?utf-8?B?YmJBbXM5VTZpUlVOV3Z5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejN3MUw3a1JPMFdPTm5uNGo2QkxQZkE1QmJ2Rzc4QWVvSThjcVhtc3RJQ3Rr?=
 =?utf-8?B?SGlwNzZIYlVLUmwxK05seHVxNmRQT2RXeE4raHpqdlRrZnZ6QkhFZm5qQjR1?=
 =?utf-8?B?Rzc4VGphQUJ6YlJJSDgwY0hkNWpyOFA2azZNYTh3SndtOGY1aGRORVBQNjVM?=
 =?utf-8?B?alZMM2l1R2VTMEk0aVBiektnTmxaR1QrL2tTR1N2OWE3ZUx2aUZpSFczN2pi?=
 =?utf-8?B?RUN4VlI3em0yeS94WU9TNUxSbWR1QzE5MUNmZklBSSsvRlpESFZFcmdRdjJB?=
 =?utf-8?B?ZmR5Q0ZESDlYSEU4bkZNMHlkcTRkL09heVRUT0pCR25kSjZCNGFjRkUzYVdi?=
 =?utf-8?B?bjZobzUrSmhaMjhrTXBQTDhBcFh4WHZEYll4WUkwakloa3R4MFVqdXVIby9B?=
 =?utf-8?B?UjN0enU5V2laZ0lYVnBmWGpKUmFIajFQZjlNVjVlNmdtSVpVM1dXQ0hhcFRw?=
 =?utf-8?B?ME11b0ZVOUhvWjAxd0ZLYWZrcDh6S2JzQ1ZSVTRmY1dySGpFR2RwSW9oSDR4?=
 =?utf-8?B?UWxncDQvZllCdE5CWSsyeVdwSVkrNFNGUEFCK2RacjJlMzN4VENjeWREMngv?=
 =?utf-8?B?aDJxZXRBcjBjbVpTZFRYWDNmbzZ0RWxjaDVZN0wvMmFVaG1tUFZPUmZmcGhh?=
 =?utf-8?B?aGxVSEVuekxkOVpQeDNXYXlHV29DeStRQUZyN3dycVliL1BxbzA4bzB1Qy9l?=
 =?utf-8?B?bnVpek52RnJ3SnF4UWhKSHVua2JXTzhPVWNCU0h0bytaTmhPd1ZQMnlBK2Jn?=
 =?utf-8?B?a2tTamRkRE9YY29vWTJQbVFtVkFpYnhhWC9rRFRKdWJpMEZhNFN1aTJ4aUI1?=
 =?utf-8?B?bUlkSjg2cjc0U2ZTQzdqVGh6cHA1a3VqWjdhVkkyVHVZYnhKKytJTWdCZmhC?=
 =?utf-8?B?bkN2M212dVI3WXlEcWgvdlB5V1VuZUEydmVKdEExSi9mQXRncFdQYVhQU1c3?=
 =?utf-8?B?cHhIeENrSlM1dmhCTTk3UHBaK0hhdVBLa0J2cFQzSzRXRC9rTzZtN21neGlD?=
 =?utf-8?B?RldUb1JKZCtPdWhLRnltM0FibGlWdmRWTk8zc3pIRVBNSTJsaVdXQ2duQ3pr?=
 =?utf-8?B?U3FHVSs0RTdRYnIxcU5tN3g1NTVOME9mN0w4OXVUMXNQbkdxbEFwRGpjZEpN?=
 =?utf-8?B?ZUF1WDJMaTRJdkVRK3pmVlBKQWxET2xWR1dpZEJxeEp3UDQ3V09LTjdJQWt1?=
 =?utf-8?B?NDRnM0JsalBTdC9jS1RBTFFiZFN0dkJlT2p4MzlDOW1DanNwbnB2emhIUnhP?=
 =?utf-8?B?UHp1bEtndXhmVXB0aGtpR2EzR2Z6WXhjU3Q0TWJybmdGMEZOQlZsbUZtQTd5?=
 =?utf-8?B?YUx5d3Zzc3I0REVVZzJwWTJ4M3c1ZTN0MjVkNDhicFhQVTUzVWVBMXVoUXR3?=
 =?utf-8?B?SU9lSkJ2bHhPVVkxbVBad0xSOHE1cVhTLzBDdTM2SWRITTQ1VFhjN3hJUHRp?=
 =?utf-8?B?K0E5MnUxMkY0QXk0M000Z25aUGZNWTF6SjVaRVpldXZjWG0rSG12djgrTnBa?=
 =?utf-8?B?OXRhd0M5VVM1SThQcUswYXk5cVk3RnZlb1htWGlETjFlbWUvSnNMOWd4QVJS?=
 =?utf-8?B?N3JEdXRXM3cwMGk0aStDQ3hOcXQwRmpDdk10S3EySW9xcnhXcjh1ZUFnaVBz?=
 =?utf-8?B?Ym0wRGlEU0NMUzk2Q3k3TmE0YTljQUhHOWs3TUtWQ0ttditTR2s5WUM2ZHo1?=
 =?utf-8?B?MlVnN3N5TkxhdzhJbmtuQ1dGL00rdXIyd2piSDJEbGxaT3p0bmsydk50ZjV0?=
 =?utf-8?B?ZW5HZFZIdzRYL3ZNT1pBTTNPMU41MFQwUDRiV0pHaGMvWDdRTjlZYWRNSERn?=
 =?utf-8?B?OTkvYzVLUGhFTjRKcnRxd3BvTm56WEV1VU95K21xdHZhNXkvWWZ3R0VBMUtP?=
 =?utf-8?B?N01tTWh3YktENGFKbHllWU5uQlhKY2YxRjAxRWVZRG4ydnRta0RTRC9UbG5K?=
 =?utf-8?B?R202Rm5EL2I3OVFNdnpHemVXMktMTjQ3OVhLKzYxakY2UjlDUmNVTVlCWHNM?=
 =?utf-8?B?R2RoMUkxb211aVBUT3kyS2w2SFVWQXErYmdmWHJyWFY1NnBLUnFjd0hsak0y?=
 =?utf-8?B?NEhwcWhCdmUwZW45OUF5Qko4QnJjcU5yNW1UbGd5TVphL1Q4aU9Gck9LR1FQ?=
 =?utf-8?B?QnBXbUM3cXRRdFlxNUowalY4TDhFZVdRaWc3WklzWkVIZ3o2ZHAyTVBxSUFO?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7599449-0e7d-4ce5-63b7-08dcc119b015
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:12:05.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdpsjpQLVC3RxWpwKyAY/X8H0oW9tEZm8hLIyGoT3woGR2Axn8fMBCGuipDw1qQ9tzURJfrLr70PGyz03oxgyctLV570ZqWJSpEerw5WWuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com

From: Felix Fietkau <nbd@nbd.name>
Date: Fri, 16 Aug 2024 09:59:15 +0200

Please use scripts/get_maintainer.pl next time. I remember it was me who
added fraglist to GSO_SOFTWARE, but I'm not Cced =\

> Several drivers set NETIF_F_GSO_SOFTWARE, but mangle fraglist GRO packets

Which ones precisely?

> in a way that they can't be properly segmented anymore.
> In order to properly deal with this, remove fraglist GSO from
> NETIF_F_GSO_SOFTWARE and switch to NETIF_F_GSO_SOFTWARE_ALL (which includes
> fraglist GSO) in places where it's safe to add.

Why isn't bridge changed? It's only a software layer, I don't think it
break fraglist skbs anyhow.

> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/dummy.c                  | 2 +-
>  drivers/net/loopback.c               | 2 +-
>  drivers/net/macvlan.c                | 2 +-
>  include/linux/netdev_features.h      | 5 +++--
>  net/8021q/vlan.h                     | 2 +-
>  net/8021q/vlan_dev.c                 | 4 ++--
>  net/core/sock.c                      | 2 +-
>  net/mac80211/ieee80211_i.h           | 2 +-
>  net/openvswitch/vport-internal_dev.c | 2 +-
>  9 files changed, 12 insertions(+), 11 deletions(-)

Thanks,
Olek

