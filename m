Return-Path: <netdev+bounces-139616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5329B3939
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595A22819AF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442E1DF96C;
	Mon, 28 Oct 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLvulzNb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F41DF26E
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140444; cv=fail; b=WGSZPrS3kKKsyUjpzrADPKvRQtATBmr1Mfze6Vh9+VGSyZmUrAAVsdIbSqAaGRnmxKju488bNgfCbOtZeD7vVhIuvEQB8jBC/rSqrniYB90b832/v3GnaNNPH9zGM6ly3Uet9FFpqZXvU0jBUoBWH5x45paWteDaNMEZW2oioLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140444; c=relaxed/simple;
	bh=A0XjkRzwsrkezsSOhxm0+Iv0pqrNTCZd6351l7+2Za4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qAdBqS28QXjqTwHkxnsbTXVlMKF4W+kDTNXRTJbMTGCoM/iS8N8wUwKn8VdKDBvZsJpiJ0E2GzKh2S6tmnelzyi1OEa36dyzcuAe95ecSzvw3oUqtKol6J3lurrRsohD7m+eF1gsX6cL4Pnx4LQvQ/1kH4uxeMaRLoLyvJK9CJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLvulzNb; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730140442; x=1761676442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A0XjkRzwsrkezsSOhxm0+Iv0pqrNTCZd6351l7+2Za4=;
  b=OLvulzNborwiD7QSoyYQemKR12Wjei1pnU8MEHdwmznzovIoSa/JcCV7
   XxGsZhqOwLHq567ICUBHS/bT9BZ1qZP2LDZTVBGAaQkj3rLKAkDxoJHFI
   vJ85dZ0vgnlcrAsYb9SvkVSDJLRm7pJ8jCykRwOsn4J3+zb72Kwpf8Bj1
   G7IK8aOhh+YwOiksBzLbPp+tm88Ctrysq/tQxpzTZBNBHsmCtzjeSa++r
   zBSrH2weI5+AcRzbVOVi2jA6x9WutP58ME4HSOkLLkH/6yZwTRqJXLU3i
   coCg1C/bIYitUuUjHovlv7cZqvhX4Ip8ghOY2RGQioz5sLAeKYCj1u6D2
   A==;
X-CSE-ConnectionGUID: jY953JmvTxaG+RLV0TffzA==
X-CSE-MsgGUID: JKYOBvhbRUybFgxriGTTeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29654166"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29654166"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:33:55 -0700
X-CSE-ConnectionGUID: P2SQUbLqSQuMvSaRa/bJ+g==
X-CSE-MsgGUID: aWBjP/e0ScOcSVDEi11UWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81603419"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 11:33:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 11:33:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 11:33:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 11:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuu2BaM6pDABDUFPLppxCDLZAyCDlttbamlXMJF1wY/1C35YIB+IX4IeB5KvAFNEFYdGHbSrR4dN6Pijt7nHPkvR7ffS8wMAytmCTT+fE4SNyeO03j0TdsUIfZSpKP0S+0BswfWRYgVyCo9RcSHn5f9qyTPin6Jc2sL9zdwUqV4zV7n+2rotu6bqoLyKcDL/3PnXS0wIj1sFct8GIt1manN05Q/DqpXX2iSCdy1JRg5ONuQnoerhLJxxGVs9nIFsIjIwefhV3Yq2nLcfFxSO/M+7AaYmt19r84qpMYiIcAMf9yVreH+cV6ISrky+QIhNAM1WEWpCG3JHc47Gg/hsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Od/JJtgw2I55biCnC3KxMrGtwn6FHPZ43ywjfZgzI4=;
 b=HtjO1y/ROGaOE6J5o1cQh0MUHe8TE2m3DkeyKftZxHOnR+KXEGprl8sbV7rThIOdAx604ttDTdLa8CmO/NZeYfjwm7vL88Qf6XDUILjHhQeNf7pUoU7R5BX6B+Qv9GR1+CD/fP30DXZF86Z5NdE4KOIdjToBhBOaiqDtVtZWFGtW1xgSgX2UabTx4VOCiF0psX38X1aLAHBfkfZrbu0KEyHWVRio6rr3gqD/kAn6im/YjZ/TPWgF6kY3wn0PwKv9JWdTCyhB167scmcqjx5cqNGj9HTM7F6HGtoVXhSqfDCytbz0bMv6WMjrdwkSR4qhNAehAZLIpR/nkA+YIdZvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 18:33:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 18:33:42 +0000
Message-ID: <5493ec79-7f64-47cd-972e-2ad0935f27b2@intel.com>
Date: Mon, 28 Oct 2024 11:33:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after free
 on unregister when using NCSI
To: Jeremy Kerr <jk@codeconstruct.com.au>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, Jacky Chou
	<jacky_chou@aspeedtech.com>
CC: <netdev@vger.kernel.org>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 09160770-7780-4f9c-5066-08dcf77f0c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTJtL2dhQ2Z6SzVVREJGNjVieTRoWnFUMTI3QUpjckNEckRpaGxNSFFYSnBw?=
 =?utf-8?B?ZHJ5c0tubm5RNkxEV1orU09hVW1Vc1pzckUwK3FraDJDVXNPRFJNMnowaGtS?=
 =?utf-8?B?SHYwWk9oMFZkTTFJa3BWU2drdjZpdExqcXIxeGZJMGhsSmdtdHVqMEhkdkVa?=
 =?utf-8?B?M0RUWVpxNWVTNFdvbGtQNXh2ZUNtWkpQZVNYU1JsN1dQK0FFVmZ6bUZONWk1?=
 =?utf-8?B?UGVhbENKKzUzcUNjNGpSV0VIMXNIbGlxaHEyWU15Tjh1TlJ4dGhiejBaSFpE?=
 =?utf-8?B?ZldvalFrRFpURVowZVdCdXNLK3AxcnJGcVM3QnRwM2FQY1IrOWhUMGs3c0Q4?=
 =?utf-8?B?QklEQXE5MlMraUlNd3gxVEFYUFVVa2RNRXpxb2F2ejhLNGlGeXBzZldZaG9u?=
 =?utf-8?B?a3dtbmhDUXkyZ0N0Ynpnd0lNdWdwOVF6UzNTUGhTaTZaYmw1RlplMkowc3JH?=
 =?utf-8?B?UEdXdHRka3JCNUREcmlkdTZFVHRkOFI2US9QYTlUYUZhK25wNTRSamc0THRC?=
 =?utf-8?B?Qlp0akZaOUM3bS80Z3lEL2h3dTNaY09OZTdYOFNiRWZTTGY1S3VqNEJ5QTlO?=
 =?utf-8?B?eVpoSCtiUWx6ZW02bGRIci9PVGVNRUpEMHk2andHVmNjNzBYMk9kV2VLM2NV?=
 =?utf-8?B?S3c0UHdydHhuTFpRWTdTSHlidFRPVzJoVlVJRVlJc3pLVW0wdlJFcElBWFpG?=
 =?utf-8?B?anZCT1hyNDNQYW1POHR2cCtTN29xMFNmQWJCYlRiUVRibWpNbTdkUEF3c1Ro?=
 =?utf-8?B?T0hyc3p1SkVCaVNzTlRjek9LTjE3Y09aYVVFQkl4L1dSbnM0ZGozZHFPbjdK?=
 =?utf-8?B?OE02RnlYbkJDdXppNmhuWEdZZmdiYUVkWGZrZ000bVBIRndtMEgzZzJyNjBO?=
 =?utf-8?B?RVBkSk8wQ2pqdEQvSHlhYjJCenJsSWVTWUNlTlNjY3FPMGNLMGlqWVpUbVFa?=
 =?utf-8?B?NDI4Z0RyZlVUWGxOaWg4dzlmaWpVNUNucWZqSmRsSlU1TmdFTWtwZ2l6YWtQ?=
 =?utf-8?B?ZFFPRjl4QWltUko1VHdHZDUvMW15QUVSUG9UbEp4VnJtNTAyZ2NLMWQwNU03?=
 =?utf-8?B?U2lQYnJtMm5vZEVscGlweG9Wb0tCRSs5VmJkQkNBRmVJNUVOdXZJcEJYNEtQ?=
 =?utf-8?B?L1dwaCtMNlQ4cTk4Vlk1d2Z3QUgxaFFRUUJQZlg1d09xZHZmQzI0aW5xUm00?=
 =?utf-8?B?Q1BHNG5PdEh6OFMxM0JaUlhJaFVWOWFQSm0zMTBuT0VlQ0RQQURlbUtCREJO?=
 =?utf-8?B?UVhmV1U2MEE2Ry9RSnlsR2ZVWXVnd2lYTm81ZndzQVdwOUM0NVRJMTJxbFBh?=
 =?utf-8?B?TjM1SFlKYlZ6bjFhMmg2NzFtd1RaZFVWdVcwOFNVQ0NrUE5ldFBzQzdqdjAy?=
 =?utf-8?B?SkFiVmJnd25MNlgweWZlSTJwQTBCWGhhSVVYVW9ldVgyQUlkWTUrWVhpS3d0?=
 =?utf-8?B?STVkelVRUWhBTXpxc0dQOVJBbkxxWFRwKzVUeWk1eU5pQ2dZekViOUhsTlpX?=
 =?utf-8?B?OWgvWkxNUWZubGx5bEpGOEVUb0RiODJpcFJlWWtrc1psVDgzYTZZN2pBdk15?=
 =?utf-8?B?QUhnTkRZTDBRWWM3V2FXb3I3ZEl1NDFWUm0ydHRqOWFOZ0x3OWI4OHorUTQ2?=
 =?utf-8?B?Skppa2MzYnd1TkNEQlJmOHd3SjdCMldXMUpGcjFwY0ZXZ09ZTEMyREhOZS9t?=
 =?utf-8?B?ZXRSNThoRHdSNGNGUjV2c1psY0pua2VYaC92Y3BTKzNSMzN0WUlybS9TRWpT?=
 =?utf-8?Q?wqzMBvnIu1WyZqb7kQaGI5RutsNV+qj0ucESEGB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpYUnk0VnpJdWVxeFBQMUVSakIzWHNaK3VvcW80SXhIN3c2TmpOc3Jkb2xU?=
 =?utf-8?B?WFhkUVpMbHg4cG1BYnFpSkZOSmg2WXg3K1M0aFJpaTAwQ3daTk1VaGNFLzlT?=
 =?utf-8?B?TUt5UkNmckhhWGN6WGFPbXMxcXdKNVdEeTQ5S2ZKbDNlY3VBZWRXY2dqRk5R?=
 =?utf-8?B?WXR3UWpTNXNaZ3VRYng1SUZFSEhBeWsvRTZRazJ0NnNUUnNpdXdONW5SYW1r?=
 =?utf-8?B?SmhoeURFTWU0dDExUng2cnFIcjNzUlVaZUdhbHc0YVRFSnM2SU9ETVVaVWJo?=
 =?utf-8?B?VE5nTTZFSU5ZcC9QV1NIbi9uUG5WaE50WTdXOVB1Lzd3YjNFQ0FSUWhqWTBq?=
 =?utf-8?B?cnNjaEppRndaT3dIYnhiTmgrZUlmNUk4UEFSZ2N5dHJkNDN0WXBZdDZHNFg2?=
 =?utf-8?B?R2F5K0p6NGw3SEtLOFBMVjd0ck54ZUdnN24wcHREdDFuVWdmcm5FQ3FqYUgy?=
 =?utf-8?B?UDU2NlVER0xTdy9ITFN0T0xiV1pRMFBzUVhzYmt3RDlFNmxua0ppOUpRWG9E?=
 =?utf-8?B?NHQxMjNzeitsRkR2dDd3SnlqOTFHN0NpaHN2SFgwUTVwZEZDL3pWVGo5Ti9r?=
 =?utf-8?B?bUxKazd4anhrdlVkNzBpVDE2V0pTc1Zpb0N4eUkzY2lKQW15b3FTdVc3aXMw?=
 =?utf-8?B?L0IxbFQ2UTRsUlRuT0NyWUVlUndXMlhNcUNWSU1ZU1orb0liUVdxR2RLdWdE?=
 =?utf-8?B?YzFXTWFFL3BwWXdtOWV5S3hoblZVM3ByRVAzcDNsOTRBWlo4MXR1QWJFVit1?=
 =?utf-8?B?WktPcTZPanpoT2MzZllCbkd4OE40cFppeVExYzhMbjFsUDYxZmo0VGk0WVp1?=
 =?utf-8?B?OGVpSWJYdFNqNTd1K1JUc3BNWnFma2V6UUtGakJUYnNkYnAwSU1ZaC9paTFO?=
 =?utf-8?B?NHM0anVNZkFOZytMTXpzNWJNSXp1TnBneXpOREZjZWpsTm1rNGxpcGYwVi9y?=
 =?utf-8?B?NFZTQ21SVU9sS2lRRytVMEpyQWJLTnhTMU8vTTZvYXQ0SnVYZVBGa05LcE5o?=
 =?utf-8?B?bzlrMCtpUHpQTFhpang0MG44cTRodnFlUWxNVC9pTDhIMkpEMFVnajJkT0hQ?=
 =?utf-8?B?N2J2NHI4cEJzYjRBQ09rL1hSc2xpWjVocFFtZXdmVGowMXF6ays3aUdBSWh3?=
 =?utf-8?B?SzBUT1BXbWdtZlNQWEJlU20yL0xoQ2hoaWlTQmZzTjdWRmk2M1BYUzJHSG9T?=
 =?utf-8?B?aEROL3FvRzdIdUhtWFBwUEd1dFZ5WnVvTUVTVEtOd1RJeWk4ajBnZEpoTW9v?=
 =?utf-8?B?cU41SjQ5Vzk1cVlzdzE4cUZEVEd0ODFXNGJiRmVPN01PZFU1VHl1REdsUXBT?=
 =?utf-8?B?NDRNNUF6MTVEVVNVYUZZcXV6b2o3MTBLaUNieDM0TGRtMGRtVWRxdGtHYVZJ?=
 =?utf-8?B?SUVTaWFSTDdWQW0zZ201TWRrd1RxL1dVVTc4TmxRTE1SUVN0bkcrZHRWYzh6?=
 =?utf-8?B?dnFVN29tUzBBUGwrdE5YNzNqR0p1eUhteHZFRTN6OGRPbmh2YUVzMCtMRzRu?=
 =?utf-8?B?eUZscjlua2FuR255UmVmQUZDejFCbDkwM2lGbzR2dzBIQXJZek90ZU9pdEJI?=
 =?utf-8?B?b3lhdmpOd3JweVRmZzk4cGpXdHFrdno1RVEvVTZLOHdHenpySW5jblBiZ29j?=
 =?utf-8?B?Y2c3MXF5TG1DUFBVd0tlZDVJZ3Y0K2h3cGJtZCs3OTlySW9oNXFsUVRPTXp0?=
 =?utf-8?B?VVNwem5QY1pCRlJObFBod0xkQ1dZWmt1YWV2Znk4anoyNWNYWTJYOXQ5WG9T?=
 =?utf-8?B?dUs0bkZNL0ZWbmt0bFpZV2NFaGJ3QndDZkpTTUZPSkg2cHkwMDBaTi9EaTh2?=
 =?utf-8?B?QjNoR0tiNS84ZVMvbmdlanNzOFlSNkF1amZmQlNXQWxqUTQrTExoYmJFVmo2?=
 =?utf-8?B?SGtQSmVENjlhcGxwVUlMNHRMRDdnVTNlb1B6eStHR1RrN3FsTjVJZW4wcldv?=
 =?utf-8?B?Z1lYZjd1UTM5UDhPWDcwT296STRTYkNYcm5HalpGOGdnR2hTUFNGWmpTTUdQ?=
 =?utf-8?B?TlhVYjhiWDdIL0VPSkh5bXVVUE1oZG1XV1VpNEVRS3dtZ2JrSW9GUG1UWWt3?=
 =?utf-8?B?SlBlV0xXQjRVOWVmK3FKUkpoWlQ5OWQ2R3F1NWVBM1ZZZHJrbi9vU2JEY3BK?=
 =?utf-8?B?YU9QcStGL2FoNVQrV2ZJRG5DcEcyZU5ORE40V1RsVzBRdDZOYzNYdUlObGw5?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09160770-7780-4f9c-5066-08dcf77f0c39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:33:41.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECQluS1hiJiuMPSMD9O7n/8dA1EDzSabqFCfhJDZmc9Mfp0NvD3XG5truRlTUOguXvM0FcHi95IrU2NMihOen//598qL82fEPyOqEO8QESQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com



On 10/27/2024 9:54 PM, Jeremy Kerr wrote:
> When removing an active ftgmac100 netdev that is configured for NCSI, we
> have a double free of the ncsi device: We currently unregister the ncsi
> device (freeing it), then unregister the netdev itself. If the netdev is
> running, the netdev_unregister() path performs a ->ndo_stop(), which
> calls ncsi_stop_dev() on the now-free ncsi pointer.
> 
> Instead, modify ftgmac100_stop() to check the ncsi pointer before
> freeing (rather than use_ncsi, which reflects configuration intent), and
> clear the pointer once we have done the ncsi_unregister().
> 
> Fixes: 3d5179458d22 ("net: ftgmac100: Fix crash when removing driver")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

