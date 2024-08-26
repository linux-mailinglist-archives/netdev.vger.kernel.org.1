Return-Path: <netdev+bounces-122063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A1295FC64
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1901F2108A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926E82C7E;
	Mon, 26 Aug 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPuVXTOF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45413B677
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709821; cv=fail; b=jwGUeyZdrWciAiSYh0oWaQb8+na6cV23q8q7MeM8C/Dy4uwEOl+I98LfIQtq4/bzd6tMs+GH6wVEgrHMxi9AiWRw3VAew4H1rXfyiusmBxpJFaVWXyQcRcNm5cjntYxlJCgjjG+SekxClckeSF2o565sDvQ3xnnAZjCd6aPes48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709821; c=relaxed/simple;
	bh=xrhwMrjkdIXTFew3iALYfnrJifKY5n1cpcwIxKd+rrg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lmb2BIt/+0bElSztlhVu/YsA4yZoOBcNFbpeWvuP2k4VjZHqOOxZUjYDjnQV6n2HJi8JV9SxJ2QbQdSX3dvxH6/P12GwpecdiEjWu1e56E9r9yzv0wfc4d7HiNQ0rUTsMAciAkU7zvVfEYP5VMyMg0Xe1XBt3Bio/vYQpVF5e9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPuVXTOF; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724709819; x=1756245819;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrhwMrjkdIXTFew3iALYfnrJifKY5n1cpcwIxKd+rrg=;
  b=OPuVXTOFdN1K6KZJ5mr8Y5/E/1iVBHZ8v2R/lIbsSdVZ6puXKrjHnN1O
   zEq+Nz8YowWF27FxcwSNZUDcsNkIBHqvR5BLWAwCu3CwNHyx15Jqz9fKq
   yzld0/ZZLg5QJorjpHaMbB2L27iIIH0b3zAvIdV7ytJwbw2wEWDKYqQ+K
   csytnEZXeJf0y0NPZ6o7CNohMgn3Gm/ZbS8z+aDsr6B3CvsiniXl70fo/
   LMMZNe3Z9XCgiAWIPhiVAzrv+7H07HRA7vwFHKOdtIBwfhTtUJfG8OsbG
   h8D5j3SPEyPMm4DRb8SzGOGGW2Cc9W2TAdudRBy7P3s3+a2OMCqSLHZux
   g==;
X-CSE-ConnectionGUID: t4mmS/tFSACLZVj0NHvBNA==
X-CSE-MsgGUID: lXkIe38PQnSe4bvKoCBOQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34567032"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34567032"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:03:38 -0700
X-CSE-ConnectionGUID: xsrO9iZWSKuDREZ7H8pixw==
X-CSE-MsgGUID: l7BhUPzST6SzN/WECkYe7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66985676"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 15:03:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 15:03:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 15:03:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 15:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UknIYuCH48ddRWULBjzrjZvVchJhYqogM+qbtdtBw4vN3spkSk1scLInzps7/YCwx96elaRv4JUrNZnIm6zfV1NpkBw76LKWdMjNXjXxIeCMU1QjrYpHL2hWZOsUXrkUeFEJIFyxnimO+oXqBaklHGAnYR1Vct9vDww0cc55CfBAcWludq/R4da7zm3BSoTO13Mz3vyVuE5O2mM+XBfpsS97nBDgDyI2YhND6180YXZ/Xe+PJ5ib9yCY+TuCNsLyiVc+NYfSFZ+Aw8TMAaIdz6wuVckWyFAbC+8K171gx/GvruXgoYaR0s8rsdYfDA1jzqb68E2LqZLAsb7c0dIoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHQ1NbF6lwaksyBybLjnwTcN13ylvqcUYw7X4yi9lXY=;
 b=Xu3q2S066x5a82nT/r/16MAcyB4ydnF2wxwzc7kHNPKGXYgI4CrwLAAaKBveJgyWUOkHLnip96Bi4fyHboheRBK5VrwbQI67kEG4+VqgYJjqyImD8cu++PiaSySzVHMBSEnSHGixc0SA9RCJs+t/dE/og3olqhHrjiRUpS0LLdRDMSYvUJ1Z6PLOZBnyPWNSBzk9az74+iGE5K6iZ8sM0YBAoMvIAp1VCdg3bod/8W5mBZ0+wbjr6L2PA4QcWtPOva3WKlmhqF3q3+TMt5FpAMKLl+zfNy+XDE8VPoH7xa1jqb6q+uma+hfu68HLYxNXa0YnLQ6MlUzcTOs4Xo5VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 22:03:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 22:03:35 +0000
Message-ID: <3f03563b-2cca-4517-855c-1516914c78ef@intel.com>
Date: Mon, 26 Aug 2024 15:03:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
 <20240821135859.6ge4ruqyxrzcub67@skbuf>
 <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>
 <20240821202110.x6ljy3x3ixvbg43r@skbuf>
 <7f9c481a-28a9-439f-a051-5fd9d44aa5a5@intel.com>
 <9170351b-3038-419a-8414-fe8513a5bb57@intel.com>
 <86162cd5-8d5e-4f75-94e0-842684cd432a@intel.com>
Content-Language: en-US
In-Reply-To: <86162cd5-8d5e-4f75-94e0-842684cd432a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: e62ec205-5b3b-4bf3-523d-08dcc61aeeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFhyUUdldjVBQkxwbjNDYU9DTi9jUFV1STFwTFY5STFjK0lFdlo5S0RLRTQv?=
 =?utf-8?B?Q2VBalBkVWhKM1VoVFdXeWs4TmU5Y0FieVJnRUFLb0xPV3EwTVRXQnBraEZu?=
 =?utf-8?B?eGg1NUZ1MTVxSlowWUcxRkVYTXRhTzBQbG5oTnFnSFU5aU9LVStvV01wUDdE?=
 =?utf-8?B?ZnlidXZhdWZoRVNQaWNEMkpZaENHY28vQ283c3lPcjR6TU9oL29CQytFUExY?=
 =?utf-8?B?TFQ5blI1ZEgydEZzV0hkU1pHMXBFTFN6TFBydjhuR2Uwb1BQTVhVZ05ya0hH?=
 =?utf-8?B?ckc5M3JaM0Q4MXIydmRsWWNTWGxFQmtrblhZTkFtWUJSYnppU3l3cnNTelcz?=
 =?utf-8?B?R2RJUlhyYTd4RHRCa2tuTVNOZ0ZMaGY0WEYxNit6TlVZY3R2T3JQQVp3ZDc3?=
 =?utf-8?B?dXlUamNRVGhqZGpOUkhzUHp5cnI3ZVBsNDRTc3JycU5SYk5GRml4UjdaZFFS?=
 =?utf-8?B?NExUN3QxVmI5ZGJLZzFlZ1Biam85Z1YxYzhYdkV3U2NiYlhIMlgvY3hzMkcy?=
 =?utf-8?B?QmpUdDJuS05xTkpOWmswdUdjUURUeFloZ0V4aGRwSkIzeDFNejdTaTcrZldj?=
 =?utf-8?B?SXhaVHhudUwvYnd2OGt1TElLeUwyVTA3TEw4OWdXdnh6NUVkM3NxNk9xUUFO?=
 =?utf-8?B?OE95STFwRWtrZ1pST3EvNUxMVkJZZkxSODhsWHFxRTErMFBER1Y2dkFyR0tq?=
 =?utf-8?B?VXJyV0pqS0MxVUdkbFROREtyVForOVV0U3pQbHZ2b0prVWdMMm9yUU0yK21z?=
 =?utf-8?B?NmFSdFFhWndudmlZZWhDR0JUR3l3K0VlcmpaYlFHR3o4K292aHlnZnlOa0FR?=
 =?utf-8?B?WmJETS9YUERjd0kwMUkvUDJRS0RRVkN0TjhTUGdDbTZiK2xEbk5lMmw2Zzds?=
 =?utf-8?B?VG5TTnE4Y0xlc3Q4anB3dml4YUhJZ1lFWWsxbFR2RGZZMytWbDFSRndTTGJE?=
 =?utf-8?B?MVpJZmJ6Y0FETVdqWU9ZS1paeVJtR2p2Y2trMkNpVldycnYydHhGR1JJNldU?=
 =?utf-8?B?TzVPSTVCVlBjdUJ3UUljb05jY25tYWJpTllkRVVFNHkxV1d0RjVxZnVnc2FN?=
 =?utf-8?B?ekFaajkwMGdaaThZREpFMmxXQWpZdzluc3czNGtJWkpIOFRqS3dnTnp5Z2o4?=
 =?utf-8?B?MGZJc1hwdGd6SEJzT3RUbFpKaGphaVp5Q0NSMXd2VmdPN3BSUHpvaFMweXBV?=
 =?utf-8?B?QTlHU0VlVXUrOExleTBBanluTDFiTTVva0U2WVY5WGpyNWxoWDhWc3VveG52?=
 =?utf-8?B?SjgyWTJGVzl2U1NiampoOVlObVBlcnpSWUNUbEJoZnU2MFVwcGpaRjc2WlZm?=
 =?utf-8?B?L0RKUldwRkJleGlvditzWmF1VlhScVA0M1QyM0N1dGhFeGdpODBXajJxTG1n?=
 =?utf-8?B?NkF3L3Bidm1OcFI3b3hzNEFuWmZoaDJ1YkJaMStCeVhUWHFkSjdvaVFDMVpa?=
 =?utf-8?B?S3VlVVhiWWdZNGorZE1MOGQ3N3hkNlZvR2JlN0dWVWZyeXdZc2lIbXJTQzdh?=
 =?utf-8?B?VVBOY3BOS3RqQWhDMkxub0xoeXprRlVnWDF6UDZqdFAwTVNKdWF1MHhWdWM2?=
 =?utf-8?B?VVkvVDlQQ21MT09CVitOWmxOWjYxM0tuYk1vUEFkY0NwWStnaXQ0UkpNMEpo?=
 =?utf-8?B?Yy9CbHBic1JjR2lmbnRwZkF2RjVRTFRmVGZpbTRGazlYQkp4ZGxBeWI5eHV4?=
 =?utf-8?B?WG9tMHkram14ajlScTdYbk9xLzZGMEViVlI4ZnlIVlU2VTR2bVlDOER3cm1I?=
 =?utf-8?B?cXlmbFFIOWRXZ0Uwdk9wdHdIaVJwajh2RUNmZkg0NVNFT2ZDRTZJTXJycUtH?=
 =?utf-8?B?WFVIR1ppK1BOKzhabnZDUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdrVWkrWXZGRm84R29VUnNiRnplay9UenN1WWZLZmh4SExnNEJkbG1WVHVE?=
 =?utf-8?B?YjhHSFhuV0N3UWJkRWYrclNDTnNhZldtay96MzdvbUpkdE5XM3hVWXR4VkFC?=
 =?utf-8?B?dVN5SjdURThaMjV0b0xUSmhkRStFMHBHWm1kOWdoRlQ0cDVUR01GbzZHdVlM?=
 =?utf-8?B?WW5UZmZ2Q21xWHhvUmk5dkNGZGptR0dvWHk2aTZoMTNiVXpOT1J5MHkzUDQ0?=
 =?utf-8?B?TGt1OGtoNkI3Mm5Dd1FWQXVEQXNlU2FlOWdpZ3JDMmlsOWUxRk5QTWs0VW1N?=
 =?utf-8?B?N0YveTZJUS80NzZWY2d5ckprZmV2SkdEL1NHM1RTNHUrSVdoQ3BMSVI2dC9S?=
 =?utf-8?B?bnNXSmUxMkIwSUZYR21VeWpWMzk3dmIzelVialk4VmxkRVdDUGRMb1A1N0VF?=
 =?utf-8?B?bVNWYmJEMjlQWGZENThpU3lqMDEzemJ6QkM2QnpqQWZpK2JqcFdXdWJYZU5y?=
 =?utf-8?B?cE9hbDl0Vm9JOE5TdCtkNzdLWlkrdXd6NDFYRXhMYjJEK3dRdDlueFJTTTl6?=
 =?utf-8?B?ZXJxbDlNUzBldmhmdnQ4U1crVU1kWEJHSWxkUXNlSkw1cnJkQTllblBxRmpu?=
 =?utf-8?B?ajhwT1FQQ2ZRSGFwQzRHWHlHdEp1OStJcG5vNjJpNWNWTEFjeGM0VktCRy9M?=
 =?utf-8?B?SVFjRWVJZXAzR0tNOWF6bzBpYzNHOHNyMnBIVGdzbzJncVpEOEdxRW94bXFV?=
 =?utf-8?B?RXdxSWRjWVQ2QWpJVkhZMHVBU1RmdVQ2NDlSOWFMMFA3RlM4RUlWamovSDNi?=
 =?utf-8?B?MHFVVUc2SnVkU0RtckV4VkNWRGJiNjFwSVI5azNpZnRmVmxoYVgxeHJoL0hs?=
 =?utf-8?B?azU4cm9nVHFzYzUyVDNLYkNwL0oyMGZPMUVVVTNZRDdjSU9tVGlBSTRZNm9G?=
 =?utf-8?B?V05mNmJyTnp5NDRXR0tjOEg5RVdTc2dyY3AvQjM3bjExRWdid2JZQkRUODhJ?=
 =?utf-8?B?MXRKamxHZDhvZUpmN1ZIbG93dFh6NEFUUFlNSjFIQjVrTU5WOWZWcTZCaFBD?=
 =?utf-8?B?bGVwc2dTMFUzOFlvSXYxb0FQMlJtQ0laUFVCZWExUmxoRG84VFlCVWEwOFox?=
 =?utf-8?B?WkpVaEwvbzl6UkJJbzNFMmVQb2h3TGVxTnJtS3RkK0Y1bCtiWVhrT3VSTEw3?=
 =?utf-8?B?WUd2OFFlSm1YZHZ2djd6RVY2bU53SUExallIRXl5RDVDR25STk5Dbi9OOVBk?=
 =?utf-8?B?dmhOMmVFZkZPOUFVbE13Mmd5eHFMMEwzdStqcjBlRDU4RVA4MmEwQzBISXJm?=
 =?utf-8?B?RFI2YTdKc3pjY0RaWGpvZnFJdkpieXgzUGVReVIvN3JYY3NJaU9mc0hmSll6?=
 =?utf-8?B?T09YUjFTc2xBZmE4d2dORjAyRWhsWU8vTWVqLzdPVzlmRVFhTWdESW8xaHd1?=
 =?utf-8?B?THpOK2JnOGJjaUxHMTQrSGovbHQwNWI0RVYvaCs0dXVjdStJU3VNeVIzSTgy?=
 =?utf-8?B?K24vbVZYMHdkdmVsNzRFNWZxMjdNS1JJcVAwMGtRSk90N1Bsb25GMWxhaWZV?=
 =?utf-8?B?dmNJL3Qvc0pRWEhVMTdkMVdPbHhpWDJ4WEZ1T1FEOVZlelJveU1KZ0I3bmZ3?=
 =?utf-8?B?L2xLK29VQk5WdXNpeEpXYlJBS3ZYZkVyak16Q1B5VTZlK1c1bDBxOUdwWWVa?=
 =?utf-8?B?U1BHL3NmQnphUjdtb0M5aWRPTGNVdzVlL0xXQm5DTWkxU2k4bWp5dmpieExN?=
 =?utf-8?B?OVpjY0FzcmJwcSswUWp6ZmRRWlcwWmtyblVqWlJkM2x0Yk9LM3l6SU1SMUNG?=
 =?utf-8?B?YmV6Sk5BL0RULzdORDN0L05CSlY3QU8xZkZhTVM0YTBqYUdPMFNDVENYY0Nq?=
 =?utf-8?B?N1FSTmxLSC8yaVFhUlpIdlR0bE9nK3VZc3RxMnJYbW1WSjdId0U1bU8rQnAz?=
 =?utf-8?B?ajBOMFlWUlhrcFp1SDdhczFVaVk4U1RtREhhZWFyOWFHRU1JSzBpLzFiZ1FH?=
 =?utf-8?B?cGJyeXFhNTZIUVpCd29nVGVKNnBHMnYxN05MNzFGSkRNd0VMeHpGaXg1SmFN?=
 =?utf-8?B?UXhlT1FEYmdqRzVidW1sQXN0NGZ2NDZaYlJzcFg5QXpRUmhFT0FVQU56UzZq?=
 =?utf-8?B?N1REczFsUUxNSEZvOExZR3NMK3FTYkZkZWtHZU9nUzdYL3NIVG0xQjEwYi9l?=
 =?utf-8?B?RENwNm5wU0U0NEJSMVU0ejhMZ0FzWVlwZ3NJS21nNFI3UEcyOVNqVFhaL3lz?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e62ec205-5b3b-4bf3-523d-08dcc61aeeb5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 22:03:35.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCkxf3S9lJnmYEi02tH7X3QTDTwKYoNH1PRyYD1+O9JgHb0gXbASXMk7vPpdT0+RUBH4gqDdWg18v0x5Mkw15fP+SMyFqCQq7SAUH6WBBwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
X-OriginatorOrg: intel.com



On 8/23/2024 12:53 PM, Jacob Keller wrote:
> I so far think the likely issue is with the way we handle the box and
> mask offsets. Somehow we must be shifting things in a strange way that
> causes us to discard bits, but only when we deal with the
> QUIRK_MSB_ON_THE_RIGHT.
> 
> Thanks,
> Jake

I eventually figured out what i believe is wrong here, and have a fix.
I'm going to include it in the series I send for using <linux/packing.h>
in the ice driver, along with the additional KUnit tests.

Thanks,
Jake

