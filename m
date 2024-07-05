Return-Path: <netdev+bounces-109461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4659288C8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06237B24BE0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB014A09C;
	Fri,  5 Jul 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFbKFXrl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D817149E0A
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183094; cv=fail; b=GUQtBLd8Oicfp1IUNE2fw0w69z7kC+XnZqR4RhhPeqvrPVZVE6ET04htDu6t8w3NLB1B3qiiPKiZ3mdroouiGGzqiC5UvzEjO3RpR8cJsmbcdZJnSl8zVMdD8BULFL7PmfcHKdOVZd3kDpRMixRaxBe6FMGwQeI8iiE1UqJZMLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183094; c=relaxed/simple;
	bh=cyny+um+QOdj9KK6GC6xymvAXNa88Oi+pBtMlINJXz8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMaXq51EfSEQoPO2iuGJ31nuAf2Po/xhiAcusdMSmv9bQTU+QjlXqLciGb3X2RiFMbMJnnuPjTHTYHKqhIHH9JhQqNRtjg8C/2wjAUU5opLHv2KgqH38b4fl/wz1To58CXBIEWez5XjtK1REBf7CLrw8d4yL7osQa6ZI6yuLfvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFbKFXrl; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720183093; x=1751719093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cyny+um+QOdj9KK6GC6xymvAXNa88Oi+pBtMlINJXz8=;
  b=cFbKFXrlgkCv8G+nB9OvGdmEV+IMEE8aKIhfN+A3wzVq7NaskYOCFCTU
   lOvJO6NBXE5De+kWjgxyN/FR/sz7TmfK0dUmfiACDDCd//hac7rMOvIOY
   BljVQ2vYKs6b/ifvYOo4l5i5IKp6E0crZdYsgr+7pdrmb4dA208E/cHNM
   +e6OzBLL04bd0+vE+yMXzkTj1b4y3PMzlBTwX3vCmWuUldB1rGPpUPzcj
   afpiULHHKg13hLyY8SG9hivn6f4iyoZ0pSdpjTYwyW7K7Y9uifM6EnFgn
   dTXds82vggP0C5bPLDWibIAgbrUDnoDGUDfrbCNB0nc1orjeEs8TkuhWs
   g==;
X-CSE-ConnectionGUID: gr3s0luyTKaXB/1POsiQHQ==
X-CSE-MsgGUID: HTKk0QDfQL2nt5QJu3tLEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="35014389"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="35014389"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:38:12 -0700
X-CSE-ConnectionGUID: 9K7trJeFRx67KcC/PNWVjQ==
X-CSE-MsgGUID: kmMMCS3yQxOm5EeFZMRu7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="52053738"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 05:38:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:38:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 05:38:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 05:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1CezkRwxXTLMGiC6yxHqewAsn91ukgBOJLQgBmrbCMje8UJfJo43RZ74ncJUmiVvmdrCUjFCIUi8ICSIagr+gtpRfF+Vs5Bpgv2v1v38/kBuynQq4X25ogzwD+mltXYZXKHR9Nu6+29GW/fT51l+r27DNKjAGoi5dHX1U+Dblssg6XUFNQS+LBQhTnIJIEIHu+GSli1weNGlE4CoFqACFOxTzvCabJcW/uaOr9znI8jysuqkYfHS6t1CSH6ZyXqk/gaCYj3wT1Hb7hnzCUOwKrW6Oi+mun67JxSiIki8Uq4EthYtJWD2wYAr+Ib6o+Yv3lUp4VrVBrZNS2DkGKOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLQESV3FA9nVgFFJimgJd4Z1FfdaUhqD0sbOORmwHe4=;
 b=HHdaj14f9SZDqBufptVjw9zsKk0rvWkpeZ9s6Uf4skFNlcXomrJMSpHHMfDVmoATfedIHqnH6YVqr8xgXZnuI1PRDHxRHFIoqOn71KDfYHsbM1uugvNjOpe/LoQ7HGeArb9S1w1RJIhkLUi9ETcUaweqsAlHM0Zsc1v+XOVKJY9yH3qAbpby1BIc1prHNjMDFHlSxrnQaeHulQSxcBFdA4oHNcFtY6C9BH8kr5TWowQ9yMokeMIoW65ipxVKDrObXj0Wv9J5uBwDizcjmiryiQwhO6GdGFzZr0Ny8XTs/NZ0KWIeKx7iKCU/SkLRQ0lGS5k7KaTTntTcJ5XYCjV1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 12:38:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 12:38:04 +0000
Message-ID: <f708ca1f-6121-495a-a2af-bc725c04392f@intel.com>
Date: Fri, 5 Jul 2024 14:37:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] bnxt_en: check for fw_ver_str truncation
To: Simon Horman <horms@kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
 <20240705-bnxt-str-v1-1-bafc769ed89e@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240705-bnxt-str-v1-1-bafc769ed89e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 520daa72-857a-474e-d980-08dc9cef50a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uy9yZVBwN2JIN0dVVjJJbFhIZ3dSVkIzYlJmVmRwMGtQMkk5V0xVQXVhNlZV?=
 =?utf-8?B?aVpScVZ0WU03bGswaEVPUktlNENjM3hzWW9uSEtCWW9NMDVwaUVER3FEN1lM?=
 =?utf-8?B?UXdEZnlidDBveWM3NEs1U1J5RSt1Yit3WU9iZ25CQjNPNnh2R2lzNXhhYzZK?=
 =?utf-8?B?OUpxdjEzTHAxTDI5QkpOM21vQzRSR0d0UFBnV0dxcTRjNkxrV205bUQrL0hp?=
 =?utf-8?B?OE90L3VWeXBPUng1amE0UW1rS0tEVy9KWkFXVE1VN2Joajd5NzdRa2xmUHFq?=
 =?utf-8?B?dEJ1bTlra093WWd5Vi9nUkgzaThESURKMzJWRzJ5OE0xOHlxNDhqNWxGMXRK?=
 =?utf-8?B?Y2RsYm8rdTVmNitKNGorYzdFempJRnFGSDhSU2dnWjd1bjA3U091K0YxQXgw?=
 =?utf-8?B?TTZFV2RhRE9xMlYwN0JoNWxtV2FDRUdSS0ZsRkNqMStvbmZBc0pPVHZ3V0Iv?=
 =?utf-8?B?TzNIZUFzNWtVeWxNNFhSWU95RVNvZm90OStYMExXYk1SeTREZmtwNjQyZDJh?=
 =?utf-8?B?cmovYjgyeW1NQzd2VlNYYU1USjMyTmlzeUJwM25aL1hPRjFQeUlnYXliM0dE?=
 =?utf-8?B?SG16Q2xaV203UjlKY01tTlRCVk55aVRRYnhMQ3RZOXVBKzNEMmM0SkVhSG5L?=
 =?utf-8?B?QkJkMHBLUmVEODdpQXNRWFk4cnVrZGhFclVObFNuUEpPaW1zd1psSmhreVJr?=
 =?utf-8?B?SVZwaHFJd0FhK3YybVl5aGx0Uk9aT1lKa3ptY0p2NExXY0RaL2RsZnVHUTV6?=
 =?utf-8?B?azZnb25taElyK1RGcWt4QVRvNVBrL1RacllWeHBDdUc1UFNxUC9nbmIraFpY?=
 =?utf-8?B?NnkxUkpTYVhMK3lZc20wTW9OU291MjR5ZHJJaW5HcURsNlQ1TFp4RGJxbGp6?=
 =?utf-8?B?cGF6ekdjV0ROMFl2WW9yVExtZDhFcUlXWVRkaGh1WGFzMzdBWFN1Q1B0elRB?=
 =?utf-8?B?MEJFN2d3MzVFK2hRL21rdEFBeFpHRmxtdGx0OW5NanlpMlIzc2JQQmh5a1NN?=
 =?utf-8?B?cVRmcjIxaHlwZkY1SUlwSU5sanZmMDJEUzBiTmNQejRjRjJXWlBLa2ZEbG9Z?=
 =?utf-8?B?bEZPOTI4MEZRamRlUksxdk15NitOQUlTRERMamRXZzdBZjlVWVJQOWhHUmhL?=
 =?utf-8?B?OWZpd2dWc1NLbnVZVVVTZFNVRFU3Y1dGdXNDakh4YnRiUCtHM3JmbGRhcHdL?=
 =?utf-8?B?L2Qxc3ZXbDVVQ0dlOFVWRUNtc2x3Y2g4YThoampkeUdJYS9KdTJoV0tYL1lB?=
 =?utf-8?B?MjFDaU9jVjFOaTM5US9jN2dOLzh2OVNTUUZkY1B5TFIxb0NUaGtpcmZXNXRH?=
 =?utf-8?B?L0VVYlNEZVV2UXJDbHRzeVh1VndHWklXb203cFZFbHhmcG0weDVpRFVCUVV6?=
 =?utf-8?B?V25yV1A3OHNXenI5OGVhekFibGwvQ2tSK3J4VE1YSUhRb2lkOE8yLy9IaGFi?=
 =?utf-8?B?MUN5VzRGaW9nRTY3UjVxU2VSM2Ntb1ZNQURNZCtOSzJGN1VidFgyelR2OVo3?=
 =?utf-8?B?aWNCcmJwY0xORFhtWjB6QWQ4L0ZDaG9SYk9XczJ2aGhXazZOcGVjcWo2eTZv?=
 =?utf-8?B?cWxSWjFWb0MzUTlGbXJ1V2xqWEVhd3U1QzVXejhTbUNKU3VzeDYyUjhSTGc4?=
 =?utf-8?B?L2hkcWNxZ1hKejgwRlRQQmtHdTdML1ZMV3dMMzB2MnlUL0F5UGRmcGUwZk4y?=
 =?utf-8?B?YVI5Rys2ZUZ5MEwvZGxDT2F1dnN3YmtNTmJna3JPVE93bG43T2VWaU5ISWpB?=
 =?utf-8?B?SUxsMVQ4bG5rYnJOVE1FTXZZRzZLS29EMEhGTE1EOE1HUVBFdDI5bFBzQUNS?=
 =?utf-8?B?cmx2NnZVdmdXZWJ5dm5LQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjRCa0hXc0RzeHJuTk1nRVhaZ2lGaU5iLzhnQUdJZkJzdWF3L3FSRzBHL1RP?=
 =?utf-8?B?WlFTa1NKb3BsZnl3Qy9oTU1WQnBiMmJhUDg1aUlMMXV5Z1JSYmFXVzJhdTFz?=
 =?utf-8?B?dS9YUDFaVlJXQ3FKNTY3dFVnc1RKVmJ0TEdJVTBLZEN1aGFTamtBN21Ea0hv?=
 =?utf-8?B?T3dpNVExMEFsemNyNWM0ZGJMYm0rS3lYZkcyR0RybXp1OGJMd3haSnVpTTNj?=
 =?utf-8?B?UUZ0Nm1GN0VYNjY5QlRkUWk4UVRCZlpIcmh2MmpEcXFLYThlQlBKaHhVOUhZ?=
 =?utf-8?B?ZHBwYU5uRkRDYXdpcXU1ZWpuU2RSZS9mL2xaTDg0MmxsV2xiMk1yU01jcGEy?=
 =?utf-8?B?U01kNXpzYXdldE1pdUpNVnZ4RlIrMzNDS3hNZHZVM1NmMTIrei9acytPZEN5?=
 =?utf-8?B?SUFucDBOOFVNS2tmK001S2dRNms1MytlaUhIVkN0TWUyakRjUEJEd2paSmhB?=
 =?utf-8?B?UFN2YVlxZ2c4NmdDcTJ1Vjl1SnFtM2dkK3VFemZsV1BuWVg2Vm9wZWhkbU1y?=
 =?utf-8?B?ejlCWHp1cGUzYjlSV2Y4M3ExdHBoUDR2TTNVQmpsRnJ5RVpwVEsrT1F5N1hV?=
 =?utf-8?B?R0dXakxpYmNCK0xCbXZoVkcyYWdZOWtrSS9KZlg2MkU5K0NoZEI3NHpYZG5T?=
 =?utf-8?B?VCtLa3QwbUJBWFAvcGlzNnZhWWlwREVQOEhUdG5qdm1JMldoL0xxRjdJMGJ0?=
 =?utf-8?B?cUltRk5KckcvV1AxNzJSdW5Da1Y4cjI1RW10Nk5jR0thQUZxV0NBcFBQRTlh?=
 =?utf-8?B?a05KMXlrVFRVYTNMeElFMDZFYmFWVjVWaWt0d3NkU0twQ25OU3ZVQ2R1UTh6?=
 =?utf-8?B?R1pLVWFsY3l5TE53UFRYUVI5cmtyNTUxb3RhSVN2WXluTFdBZ3AzRTh2eVp1?=
 =?utf-8?B?bGJaQndId2pPQm9lcEIxWFM3QzhOMThtUVR4clB4ckZOaytGVkIwY2dKMDJQ?=
 =?utf-8?B?d2Q2YlFEekp4SUdKaXFVRHc4UytxUWV3ZVJLRzFpa1B3QkpSQlk0azRxMDN2?=
 =?utf-8?B?dUNScERNK295Y3FxMHBEQTV0QmdibWl3MUZlMGlieGMyN2VvUDBUR2xtN0to?=
 =?utf-8?B?L1RleDY1dk9FU1hjWGxDaHBUZHJvSU9RRlNlc2Vzd2MvV3dSSmZ2YU9jUUFN?=
 =?utf-8?B?eWlOc2FMZStTRHk4RHRySS9aQXg2dUZmVFRXZnVicFNveGNjL1BDL0owaHZp?=
 =?utf-8?B?ajFldGV4UTNQR1VHZXk4c1NPeTFlOHp6Ni9jam5DY3NSL2JjRzNERmk3c3NQ?=
 =?utf-8?B?TU5VWnRkaGFRZWZvaDliVENMTll6NlRPWFNsTC9qbTA2a2hZTm05aEp2Z3dE?=
 =?utf-8?B?Q3BPYm9haXZYTnMvak9TcUgvK2FvQzZDT2Q4TGZNQll1TjFsbi8wSS84SmNj?=
 =?utf-8?B?QkwwZHladWhsN25BVDM2STVrbDV0RmI3cHlHVjREdnYzTmdFZVBBbGVZVGNM?=
 =?utf-8?B?ZXhPWUdnWWU4bnNld0F4bTR2bWc5UERjR3dyZVQwWDNkZ3MxYjhabktvSHp6?=
 =?utf-8?B?cVZxRXQwQlplYXBDUzVEL2xIbERWbHM5Y0tyaUg1aGpBL1EyZTZ0QjFNY0N1?=
 =?utf-8?B?VmlZY010d250TG9KVVBDZVJycDIwM1ZWYzhYbmFoYk9ZRVU3S1IweHp3VEdE?=
 =?utf-8?B?MUdQbFl5YW1yWEJXTWNxNTNKYS9SSlZ0ejh0U3hVNWlVN2tyUEFEUC9zZmNl?=
 =?utf-8?B?KzJqMUF4Ykp0bE9ienBCcFNPQ1QzZzJRNXkzdXpCMEhFTVBxSllibzRmNGU0?=
 =?utf-8?B?Z2VJVWRJOU9TYUQxRFpRNk5mZ3N0OEpWa1dkYVVuK0t4a3Bmam0vNHVuNHcv?=
 =?utf-8?B?WFJ1WnJBUmFZdDlwcnVjNjA4VkJxbU9CbmhpV1JFdndrYUErTGROWktEUk1Y?=
 =?utf-8?B?ZnlUK0Q0M0hmaUlNNHVqVHQ3SUNKS0dVcC93K3VOS05ad1ljbmhGWHI1bTN5?=
 =?utf-8?B?Szdid0tLQnpXZ2hZMXRlb1dlZTRNVzFrOVhXcVJreXdMaWFJa1ZXK0xqR1Yv?=
 =?utf-8?B?Ry9tajVkOXpseVhSd0dKK0grc2lGbGVmU3dtaW5TNERsdThuNm5UTnhGMG9r?=
 =?utf-8?B?R1RweTBXS2w0NlBtNVROZEJyenBoK04xQVRxc0VXRDIyMS9JR01rTXlUZnc3?=
 =?utf-8?B?WWRNLzBRSE5wSmM3VllOQi9lUldMQ0lQU2laNStsSHJmVnA1WWk3YkhXNmow?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 520daa72-857a-474e-d980-08dc9cef50a5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:38:04.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCHA5Zye1bWj28o2H8I/SLxje1U3XxY0gu3uG6pjPHdk+8R6wVeu9R74EoTTs0zAQ8uJZxmMY6bvCKuR7wzNSVcOZ/8fEAoE7gsi3J00y/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com

On 7/5/24 13:26, Simon Horman wrote:
> Given the sizes of the buffers involved, it is theoretically
> possible for fw_ver_str to be truncated. Detect this and
> stop ethtool initialisation if this occurs.
> 
> Flagged by gcc-14:
> 
>    .../bnxt_ethtool.c: In function 'bnxt_ethtool_init':
>    drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:4144:32: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 26 [-Wformat-truncation=]
>     4144 |                          "/pkg %s", buf);
>          |                                ^~   ~~~

gcc is right, and you are right that we don't want such warnings
but I believe that the current flow is fine (copy as much as possible,
then proceed)

>    In function 'bnxt_get_pkgver',
>        inlined from 'bnxt_ethtool_init' at .../bnxt_ethtool.c:5056:3:
>    .../bnxt_ethtool.c:4143:17: note: 'snprintf' output between 6 and 37 bytes into a destination of size 31
>     4143 |                 snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     4144 |                          "/pkg %s", buf);
>          |                          ~~~~~~~~~~~~~~~
> 
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> It appears to me that size is underestimated by 1 byte -
> it should be FW_VER_STR_LEN - offset rather than FW_VER_STR_LEN - offset - 1,
> because the size argument to snprintf should include the space for the
> trailing '\0'. But I have not changed that as it is separate from
> the issue this patch addresses.

you are addressing "bad size" for copying strings around, I will just
fix that part too

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index bf157f6cc042..5ccc3cc4ba7d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4132,17 +4132,23 @@ int bnxt_get_pkginfo(struct net_device *dev, char *ver, int size)
>   	return rc;
>   }
>   
> -static void bnxt_get_pkgver(struct net_device *dev)
> +static int bnxt_get_pkgver(struct net_device *dev)
>   {
>   	struct bnxt *bp = netdev_priv(dev);
>   	char buf[FW_VER_STR_LEN];
> -	int len;
>   
>   	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
> -		len = strlen(bp->fw_ver_str);
> -		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
> -			 "/pkg %s", buf);
> +		int offset, size, rc;
> +
> +		offset = strlen(bp->fw_ver_str);
> +		size = FW_VER_STR_LEN - offset - 1;
> +
> +		rc = snprintf(bp->fw_ver_str + offset, size, "/pkg %s", buf);
> +		if (rc >= size)
> +			return -E2BIG;

On error I would just replace last few bytes with "(...)" or "...", or
even "~". Other option is to enlarge bp->fw_ver_str, but I have not
looked there.

>   	}
> +
> +	return 0;
>   }
>   
>   static int bnxt_get_eeprom(struct net_device *dev,
> @@ -5052,8 +5058,11 @@ void bnxt_ethtool_init(struct bnxt *bp)
>   	struct net_device *dev = bp->dev;
>   	int i, rc;
>   
> -	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER))
> -		bnxt_get_pkgver(dev);
> +	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER)) {
> +		rc = bnxt_get_pkgver(dev);
> +		if (rc)
> +			return;

and here you are changing the flow, I would like to still init the
rest of the bnxt' ethtool stuff despite one informative string
being turncated

> +	}
>   
>   	bp->num_tests = 0;
>   	if (bp->hwrm_spec_code < 0x10704 || !BNXT_PF(bp))
> 


