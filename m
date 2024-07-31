Return-Path: <netdev+bounces-114631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B679D94345B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113AEB226B2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED3B1AD9ED;
	Wed, 31 Jul 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo49lkFn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238771B1421
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444495; cv=fail; b=Q483JjlIRiCC7MzcnLMX0PgW3dueLOJ+O3osZdR0AoK2RiDUc29vhdez2AvBQOlx5NHO81L+cJ5RBrJComlX1yicxiOELkLGHjsmjS+qogryFKO6BkzDRUtH6FOJDZ/WQldT5aaLDscnDkOjEd6XvQ8cHPh4JicNuyHVubGNFvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444495; c=relaxed/simple;
	bh=wWZYmMKMwCh6Xi1L3iLkPtw7y8pU7YUXIuSfLx+Ev1A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYBCwRCdMy058RitUeWJE2u5GdiMA4sMVvICd5SqY6FECrhh+/PFYLZwQ548zYBTpmiV+enxfdDfRYpL0R8EJX1TzmlaKSDo7qtWv2IvsfJRoO2UVO6uT8rMr1c/QKXOE2HWT0BWTEbP726krHPoBWK8P/uOmuFXtTaGG6D3Nds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo49lkFn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722444494; x=1753980494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wWZYmMKMwCh6Xi1L3iLkPtw7y8pU7YUXIuSfLx+Ev1A=;
  b=Xo49lkFnAXY30d6Nthizc4kK4yNrspwgntZpNHghyfnCxbCHxN+IXk17
   N8Px+L/rFON01+aStMiLcbAjdHrsMX1tEj84QyFL/qMh8s2AZaNHG5GT1
   0NCV0oj/TcvP0gNzJEHOEp/sbPEkEHsjjaEPwBY0cXHhlVxHw6qQioUAn
   sm9ufLNtnl9s0RfeVPfA0yKsKUkJLxc2DFsd6ZdWd+Mx9X8Bdp00VzbDo
   7YzrW8xCrZaYbLrMYaCiaXJ0Q4tBQXaOXiBXqzox81gVA9qAAFlyEAP1l
   yxpDVzlCHVhZIl9t00YbZ8kKUuni/jv1isQswlSyy43v/qfCZlVUXJCU1
   A==;
X-CSE-ConnectionGUID: hmYCp46dTTmhiIMI4hsxJA==
X-CSE-MsgGUID: 4cwL/cMMS2O8LgBfFTe0OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="12808957"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="12808957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 09:48:13 -0700
X-CSE-ConnectionGUID: qpHYOZiOQaGpImvWO2gMcw==
X-CSE-MsgGUID: lR/AjZn0RIuNE+rb7eBcbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54645361"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 09:48:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 09:48:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 09:48:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 09:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRePWCF9bv34Acb0nCb66qjzRVw1VLpjaFIjKrl58u92IWGq0b70raqk1axeZxhTTxND04zkF9R72AG3Ll74P30ynCjH+/Cc/w40cXMpb/RVSJkkNWNghzggszEh3i677StLwTBomeyokgPZpEAPhSW/sJsz/0qcTWLJJVo0PYlJV3sgj9jv5o2tOKa87UOOHv7gEkoqSJ6MOxykcViweHNAh6ICCjruIpKxcCqDQ5lWlAMHo4Xl8ROJllH/20Vyz1fu+n0i4Nk+z2p5PlxSaj5wStiz9bX1BE8RTi7WcQl2zlpm/W6riFz+f2acV6RutvrORmHOg33VkrR3xVaSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVhDmXDeH4KCWkKwhhjh127+UQfP1Jr3CEMbtW92Wbk=;
 b=A0KfY3Kvc04Xzm5grhCs39Bv5CDNwADArqI3+ZHUHQatX1JhPos26F9IeL4DuFVwY4Sk50ZU+DeImD++/8TRVIiF+s7NmyJs9LpCZI8X3zKFW7W6JN6NFfhOc97WZsfYQvM49jmlEDOqoidxZQS2DyqdxPT9rCAtUchUKyOWI6GuBH6z7O+xP12L7OfYcKic8XWcjKSynF4PKfBiXXS+fBAONZT6V14AZCDCv25bHBDf8C9acrs9gT/G+qzFMGnV+nM2Pu/iXvp2GZThKLJXpo5pb9QHPINoMu0YdGVPPLWSSArZ6TQFpo1zTO9DzJadu0uIkUElL6fDCENIgn/ywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 16:48:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 16:48:10 +0000
Message-ID: <c0213cae-5e63-4fd7-81e7-37803806bde4@intel.com>
Date: Wed, 31 Jul 2024 09:48:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Implement ethtool reset
 support
To: Jakub Kicinski <kuba@kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>,
	<anthony.l.nguyen@intel.com>, <simon.horman@corigine.com>,
	<intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
 <20240730065835.191bd1de@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240730065835.191bd1de@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: a029d104-8cdc-453a-7f42-08dcb1808f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blhJUksvUDh5MVQvcDlrT0RMNHBwQW5kN2lPamc5OTFtdGIrYml4ZjFjV0ly?=
 =?utf-8?B?UTRqaUd5b0U2ZWFaVmhxUDREOS9GYWRLZHJ2ZnRBVUFSYkZabTR2bS93ZWw5?=
 =?utf-8?B?QldHUDRqcnFkeThmdnJaeXZqQWgxamV3aXNna0Jxd0pLT0lyUzZFck9QeDlM?=
 =?utf-8?B?TzUwQnBqaFFOTDhSbHY4RkJDbVVPZjBjeXpwRGVyTS9yamRoTEY0cDJuVmo4?=
 =?utf-8?B?T0ZOMUxDQkUzZ0dZckhPeTE0dVJtSWdzRy9nbk1VTFdKMlp5am40c0xhNXVR?=
 =?utf-8?B?eXFRWFhqOUNYT1h1OU4zR2kwUW1RM1BVODZKazd5Tm5lQ0gra2RyZm53MHgw?=
 =?utf-8?B?ZERmMlY3Tldpa3JHd0ZKKzJjMVoxdi8wZUd5UEU0aGVUOVpYVFVYYkRFbVUw?=
 =?utf-8?B?ZTRqaDhWc0xRMERDcVhUaUVBNFlxOFFvbEtraUw4V3RMNkdvc05IQUZUb2wz?=
 =?utf-8?B?YnhVVU1DM2RiRnVwL0x2V0RZWUp6KytRQXZaYzJGa3N5Z1ZHa3RXMGJyTGIx?=
 =?utf-8?B?L24wdEk0dldvQktjT05CanBtQ1dqc2UyaEtDRFp4SWYrZUdieTcwUUlpMnhQ?=
 =?utf-8?B?TVFna2JwK3RqUzVLQVhiYVBPc1lXazcvTlMyWWJRUDVpV0libDczNi9JUTBX?=
 =?utf-8?B?OFlPajY1OHoyelo0dXl5bU1VeGNTY2V2d0U2QlMxTlJ0dVRSaVgycW55SFFm?=
 =?utf-8?B?czNqVVpBV1VpSDZYMmtVT1VPTncva2VLYzFlYUZKRGt6cFVmeTdtUEVkYmd0?=
 =?utf-8?B?bjZwWWhuakhyNzcxWG05VldHSFRlVzY1L1RXNEp5eEIra2NSUDgybFdBOS9D?=
 =?utf-8?B?QThaQmZQWi81L0RpeU5kNDhvdk9nMkR1b1FxZWIxRFNEMlIxbXhiSFB5eWRJ?=
 =?utf-8?B?SkxhaXlrM3N4ZXh5LzZ3U1JycWtYZi80dkcrbWZsTitHQUdCMFRLWHQxM05Z?=
 =?utf-8?B?czhRRUlaK0dzejFJV01jWDNtdEtBRWNvc2ZRYWRxVWNDM1pUOG9qMU5IY3Fa?=
 =?utf-8?B?ZGl3TmpsMEkzOWhpZllYT2xFMkovNXh4aXdaV3Q1a3QvV1hEUC9YQ2wreXYx?=
 =?utf-8?B?dW1NYTZCRUY0TkU3YWFhT2JaS09jNGVQZ1VMazVESnZXY2tZYXBLWGRKaEkv?=
 =?utf-8?B?S3FUVFBtcjIycGtnbVFWaGhpSW1TbmhobzdWYXB4Q2xJaHV5WjdrZGpvZitt?=
 =?utf-8?B?RjZWcE5zZWVvMHN6b1Avdm81bHcyOEh3NkJVOXFob2lKOVBMekwxOUxrcHdq?=
 =?utf-8?B?MzlxTE1hSXlkWjVzZjFOVktXM1c3ZVJ4dXlrNDd0ck1sQVE0aFZhVlJxMEI5?=
 =?utf-8?B?N1VDTktlT0JrNXZUWFZSV0lzNUQ3R1pQT3RCb21oWDdZb29tVGUweDBrc0Vo?=
 =?utf-8?B?MWpwUmN2RkY3VnpIY3l6LzJqRzRML1pZT2lxYXZMYTJiVllMSnRpV01mZ1F0?=
 =?utf-8?B?bjZDTzBiQlFUN0ZGVVpJUGdmbmoreExVUHY1SDlZaFhnL2ZHVExJZlA0ZENW?=
 =?utf-8?B?RVV6d3BsS05teTAwQ0J2aDVrUTZoSGk2SWpSMEUxSFhPVGpnMWNvSEk1cldi?=
 =?utf-8?B?RmZ1M0FCMWx2MWs1UjZITDdvYkJpSnVKSXpCMG5FSi84K3Q3UTV4OFkzVlZT?=
 =?utf-8?B?a1VDU3E5MnZFUUlQQkVNTHRhUTlTazlIcThkRG93U0RsTWcraHJtdGRyNW1S?=
 =?utf-8?B?dkR0aklsb3ZtN216c2szRlR4NTgxYTZ5OC9ScmJXd0pUN29IWm0yT0R3ZFdD?=
 =?utf-8?B?UkpyNmpidlRiVDlnUnJDRzVZV2NuMTZrYVhtQVg3cjkydWZtMU0rWDFqM1pL?=
 =?utf-8?B?UHFBaEozR3RiSUNEdDVLQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzlkWHY1dUg2cDBCZWo5b0RwMUFPQWJHUUFxWHVoOTV0dmRtT0NudUZxOXJ6?=
 =?utf-8?B?S3ZxdEZIQlk3bUJhUDRGWElERk9NaG9HQkxnandYSjZiWHVzMWtmYlNuSmhY?=
 =?utf-8?B?bVBoR2tkTktJYVJNeWlCTWQ0MnNvenpRcWlTcGpjRnhqMnhnT2RUVEg3ak1a?=
 =?utf-8?B?QWVJaHNwdTAvVzY1Mml6akVmNGxvZEc3K0tyNDVzdm9qQWdjVENlMVZEeGtt?=
 =?utf-8?B?UzQwUEI0WHhWdGxzWkdaZFVBaHFhU0hnakVPajR2L3d1MjhHQVVxY21TdGtN?=
 =?utf-8?B?YmtQYzBqWW0zUldla2Jrakg1dndmR29FaU5OcUFDYXNpeXIremtYK25NM0wx?=
 =?utf-8?B?VllOamg1b2VEZC9kcmU3TEtmcC9KM0h3WnlmTFc5MklnLzI1bWJaWkNNbWFh?=
 =?utf-8?B?SnQ2eVE5N2RkZWFuQ3c3SHJYRjViOVdrbHpDcVRkUFoyckVxaFJDT2ZpQ3Bi?=
 =?utf-8?B?RkJCR0pzMlRsUGIzelZBZXhjNzRqdkRJNERIdXBVemZwSlRTZ3dhdlRxVjBv?=
 =?utf-8?B?TzNNYTJ2TnVXTG1QYWZubzQzOUNOeERGeXFCK2ZhNEdkV1BkNC9qQ3JZcDQx?=
 =?utf-8?B?SXE3SEtnbnNVOVhaTGZxSjRMSG9DQmlVVVpzZkh4M1czL3psTmdwcUNXN1ZY?=
 =?utf-8?B?WmF2cGJBa1dzNTM5L2NqUUlxTWhURk5DQXRNNzNLOHNLbWtGU1pUK0NGdXpm?=
 =?utf-8?B?R29YMmNiUnJLNy9nVUhPcis1d0RGSDRwQldHMVVBOUJqUDJsTktkajdmZHFj?=
 =?utf-8?B?NW1DTWVTb3BSQzcycHNaWmtNM0tpZjlEc3NsZmxMZjU0V0N0QkZIK0pERisz?=
 =?utf-8?B?UDF6cWZvQXE1WklTZkZHUzhCZU92bEhhak15RTZ5eW5XcXk4YWpZQWN2Wnhv?=
 =?utf-8?B?eDFGZGtIblhTanQrY0F4cUpZei9XYW5uUFRrK1NBdHBNU0ZyaFBWYldGLzJj?=
 =?utf-8?B?b0hiVzI5dXBsQzg5WkhydlJiTmNaYXVsVmZCdU5TY1FaWWVxNFZYaDNjckdm?=
 =?utf-8?B?T3J6OCt5bGNRS244aWhZRUdSVU1uMitSWUNQQVJ6ZHBHYnNqTnltSkpRcTVN?=
 =?utf-8?B?MzR2STlZRHVZS09zNk5LN255cEtPeFpuSTdVeHA1UWl5cXhtU1dOd0RvcDc2?=
 =?utf-8?B?MUNGM3FjR1lQd2pRaWlCTVhuMElBVEdxK3ZxWk1zN090d3FSangybGhzRHA1?=
 =?utf-8?B?amtkT1JTMnRkc3IrR3EwVTFFV0lKaXh0cVpKa1Fjeit6VWRMQVhyMjJhZDd2?=
 =?utf-8?B?aGs5VTRvZGFZeEtybGo4ZU0yVUJjMWNzVEljSnRjVFI3V08zUWRySXFqUVE3?=
 =?utf-8?B?bUVEUzNKZlJOdWpmd2FEdDArK05yNlFPaGl4eGdPYVZSdGpKQVFnVkphQm5S?=
 =?utf-8?B?a0xNTldkMTR2K1I2V3QwWVFjTE1jUmE0alZtNUlkTkNwQmJhaHZiQTAyNE9v?=
 =?utf-8?B?WWFIWGVPemE4Vk1VQVNOem15RWlWeUQwNjdKMExleGIwcGRmYTUyWmdqRTNu?=
 =?utf-8?B?b2xTVGNPbHlhSGJTcFNIbWR6bS9oNkI3TUlUemlIOERWcTNodURsZjhMOXp2?=
 =?utf-8?B?YldNUHJ2dEt1ZGRwNDhENGE5TzRGazJsdmFEOUVyNGFwbVdlaHFPNkVCTGFW?=
 =?utf-8?B?Yjh2OTVucm5Pa2ZCOS9WZy84L2tMTUw1VHhtcHh6bE9XcUwzZTR6S0lWS2tV?=
 =?utf-8?B?OXAyektialdvTjN3YUdRSmJRRWJCa1lQR1I5ajVsSDU0emRZTWIvQXhZSmlV?=
 =?utf-8?B?aXMzUE1ZRitBb0ZNcFJwcXp3ZVFMWHQ1UHVsbUlKODR1SUlaZE8vVDltKzMw?=
 =?utf-8?B?NklmSGNPVUtzT1FZMGVIWHJCOEhYRkRjeW94QWs4SWpoQjlJZ1lGaTBUUG9a?=
 =?utf-8?B?eEs3VUR0dy9RanF6ZkpSQ2ZldjgvTGxqNGtDQmhuNkhJMTZzSGdjTXkvQ0g1?=
 =?utf-8?B?OUFiNUVYTGJyS1ZHTW5jd2ZJOERqeG45K1hMSVVEZWQ4WnZGV3BjVEsrb1NH?=
 =?utf-8?B?NTdCWnhQcDgzL1J4SEF5SC93aGtoUExMT2xJUEJvOERZT1g4WnFoZ00vRjVx?=
 =?utf-8?B?V0JmQm9DMGpjVmZMSEZMYUZTUmlDcm9pMEZ2TmVaQi8vZk1lb0s4Q2dDWUVz?=
 =?utf-8?B?azFtU21HZG5DS0UzYW9nMTVEbXJpbkxzZ0N6K2VPalZMcTRreWlVdmJlZ2VT?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a029d104-8cdc-453a-7f42-08dcb1808f83
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 16:48:10.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMu9/B4OF4uX4PH2ILsDK8Bg+1afmXfpnEZfP8zlWKq+wMAMz1cZUEcS4O2z1bI0hIWOin3iLU/rETQZpj/fwYuCG3Jmz7r7P9JE142mox4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com



On 7/30/2024 6:58 AM, Jakub Kicinski wrote:
> On Tue, 30 Jul 2024 12:51:21 +0200 Wojciech Drewek wrote:
>> ETH_RESET_MAC - ICE_RESET_CORER
> 
> Core doesn't really sound like MAC, what is it?
> And does PF reset reset mostly PCIe side or more?
> My knee jerk mapping would be to map Core to dedicated
> and PF to DMA.

PF reset only affects the single PCI function, and does not affect the
whole adapter. I don't know how it relates to PCIe resets precisely.

CORE reset affects the whole adapter, and the other functions are
notified of the impending reset via their miscellaneous interrupt vector
in combination with some hardware registers.

GLOBAL reset is similar to the CORE reset, (in that it affects the
entire device), but it is more invasive in the hardware. I cannot
remember offhand the differences between CORE and GLOBAL.

There is also an EMP reset, which is the only reset that completely
reloads the EMP firmware. It is currently used by the device flash
update logic, via devlink reload and is only available if the new
firmware image can be reloaded without issue. (Reloading when the new
firmware could impact PCIe config space is likely to produce undesirable
behavior because the PCIe config space is not reloaded except by power
cycling, so you end up with some weird mismatches.)

