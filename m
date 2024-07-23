Return-Path: <netdev+bounces-112642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE393A4C9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421F61C2029F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3B157A6B;
	Tue, 23 Jul 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmBbScg+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B015444F;
	Tue, 23 Jul 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755011; cv=fail; b=GLZnIOp+lWOqTTx4V+zz6LU6sXRVCukmrEdm14iLZpWU1ZFyjQgZQ1bYLv823c1iuhyuGsxPiUlj84KZd5LwyxSxIwyujWUWs9LcItjoIfiB1dLMFQiCBwjb1lgfMqYZFhgAUVWAZZx43bs+3KrJXg/F9YrcEwTSrjEeMcmmc60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755011; c=relaxed/simple;
	bh=Bvucc0ueLfI5FYWVHUY3mImjo525GI5TPtKi1INpbz0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1ey73R/2KXlimf5BQGDWis1LViri5HPnGwlFIbBR2oQDLToWJ+Jw/nYKVjweKNuUduZlclLzYJOMEs14XXVwB7vM4ib1wMWPwXh9K+uqoBiqQc4VRyW2QcqNzzAPTdnMwFguM3rRGOA+ZQ98Q4EbeRdx+VexhXSRChyDEX8XrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmBbScg+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721755009; x=1753291009;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bvucc0ueLfI5FYWVHUY3mImjo525GI5TPtKi1INpbz0=;
  b=HmBbScg+kNTT1JciNBWwGfRSmNjmM4XHxkrtjtq4aNpPemjzGNLTudfF
   cixH0V5gXswXIRvOe7xMYCwW/UaxgpL7kQAmqIzweISjPvonKFkUu1SLj
   3XFs1iKJSiDegw9hxssGTvkYuY8ub8mCUEPERSkp3Pj1BKX9MOjQrBeSx
   fsp72qSdD9f+b1+Eo4lSfZaxF8aHjFDw99RdfJU+W59DWw0ejQsKWsFls
   cutUea+hHuR4oIDXxjYR2yfpGa0wQ6NVBNipDmTJjCuTYiD8u26Zj0k7I
   otwZjaMezsf9nBs+gD2RdbGj5KVoC9Fr90NBZCZUDY0X7K6EfN+vwYYLN
   A==;
X-CSE-ConnectionGUID: UlxO+HVSS+6tj8O2ogJ4Zw==
X-CSE-MsgGUID: oec0fp2hRRe37IvHpaGuHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="36918802"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="36918802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 10:16:48 -0700
X-CSE-ConnectionGUID: ydef0kLiSLGPdJgiklgiEw==
X-CSE-MsgGUID: 8rhtP1UWQzuwLRufLgDOaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="82931435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 10:16:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 10:16:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 10:16:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 10:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVufEgQgLTu3q4ZaqeO1O6XxbNU3AqmC4pmYd1YPfV5JJkewTrzIQPO/fqkPnJ3NjiUmeEibsr03bVCidDHwn9qy38MKuTqGQKvxOzKVxvyJ7iak6UmRFyyNMGViUSipZjzVZKjQV7wJ2qRZhTvyA4AQiO21XCfhw31c4TrLY8xejx/5dBV4AqQO3syiHthFKkSlehH4MX8/S4F6FdLx4RD9WZAAcx2tKAHF6rGO3l4Qy9Qg3c63IW5kADgTtph1dBKK9vkYdCKza2Gt6YBeJ2tNW93EYVbShkIk27/2XnRFCAjOXC1Y/95gP4AcGObJwM3YmVJSdJ1/o8AWSOKqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG9hvLBHOKsTnHD2GLpHeWC7l6q+3cgOqLRa12dhSRQ=;
 b=v/062gFYdUEjxpBttOXaLgO6Vurhc9NEyb8bjGfsgZW4gkc/e93Mw/zG8ZvqC/F69xTgI9hU7D/+e+b94lTxHYKVhGZPlbYLF165OtT+s3ZkDp7PnO8SutPX6SKEQ6GZld3SiY4omU7zHviDf9MvEhysSBMKMeknnTB7whz51Qg30AJusa6heHz+daMzJrnv3t2WSXnvTWwk9FzCLlbiw5uKe2PnPA+5aa/0yAXyZbVA64PCgNWmKOLF1wevUCyyoBAy5MXAk+M6dVKUIV77OTJojZXMY0aDuESmKsv0gJvn7SezE9GpU+Y2Ri7tDlQWwMTO4+qPczZ28DuzbkyReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 23 Jul
 2024 17:16:39 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 17:16:39 +0000
Message-ID: <d33c7174-733a-bc70-78cd-dfcfe666f263@intel.com>
Date: Tue, 23 Jul 2024 10:16:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net v3] igb: cope with large MAX_SKB_FRAGS.
To: Paolo Abeni <pabeni@redhat.com>, Corinna Vinschen <vinschen@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240718085633.1285322-1-vinschen@redhat.com>
 <afdb7011-5098-47dd-89af-5ed0096294d8@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <afdb7011-5098-47dd-89af-5ed0096294d8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3337c8-612b-4e82-024e-08dcab3b3721
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3VPNzE1RVB0SGp3TXBlODdCSmxhSHFteVNFR21XbTZpNkxWYXQ4NDk1NHhG?=
 =?utf-8?B?dE9ETGsxNHlMQStaTTF0S282TzBuajYvK3AwYUFvMWhycUoyUlY4RDdBbUpy?=
 =?utf-8?B?a1o5c2tPRHRqQ0tYL0g5NVAyYnJZckRyekdDcVcwSjh6YU41WDk5eTMwUlVX?=
 =?utf-8?B?eWQ3SkNCcDNJWlI4V3A1emsvN3FYVEJoZ0l4Vm8yamtjUXVUcFRlam5HdVF3?=
 =?utf-8?B?M0IrNndyWmRxb3BOR1p2Vklaa082QjJpa1l0SWhCMC91OGd0MnUrTGw4bktU?=
 =?utf-8?B?eWFQU1BUSzBCSmJKMzgwRFlWSTV4bDVvVElORHQxSExCS3JGWnB0OEdpTWcy?=
 =?utf-8?B?NCtSRnVKMWVvbUk0VkZDQXhSNkpnSlE2ajNqc3hEWUl1ZVpEMDRENmszb0NW?=
 =?utf-8?B?WDRsMEcwSTVOWDE4SkJ4L1lxRzVVdkNUNUo1V2pHOHF1alNRakFUVk9UNXZ5?=
 =?utf-8?B?S3pDdExtck9meXp2eUREUFVmS1FKVS96cXFxMkhBaWJYZms0cmVxN0tLSFpD?=
 =?utf-8?B?Sjd4bUF3b04rTnhBTThzTlExTmVTcndSSVBrL0ljTGZrRFp0ZFNVa1NvQUNB?=
 =?utf-8?B?eW12NmRhNUJtQXg5R3gvVDB6cXF5bzhRTzNsalNxeFg3ZjZKWWZDbkliRDZW?=
 =?utf-8?B?aTZ5Q3FWWk8zOSs4MmlVT0lCWUZMMmEwWXV3THJSbGw1Z1pSOVE2MWQ2bGsy?=
 =?utf-8?B?NFFMM0RWemVPdUxncTI2WENZcTB6NGpXbVhsVFk4dElSVjFzWnlaTlozU1VR?=
 =?utf-8?B?MEI4d2FzTXdXVTczdUVqSUNkQUYrYk9iUEkrUERPT1hqM3JQSzgyRit2V1k1?=
 =?utf-8?B?QUtKeWpkaXBhQUNHVWNGcVkwOWJsRThRbEZrU1E0ZTYzSVpHMzlTVHUvNkdI?=
 =?utf-8?B?Y2NWeE04cFlTa3BBTE92SlZrVURzVkpwd0d4aGZFUzJnWStORFZPZ25nUUR3?=
 =?utf-8?B?ckYzaVY5blRBeWZNaE5QSUZ2Q016OG1KckVGcDBBWnNmTHJOMWxHMmZ5eDJu?=
 =?utf-8?B?QlJ1WnJjY213SzBpV1RPWG9Kb1lFQTRkbm9wSXJJWC9TSnRyMHlRbURsUEx3?=
 =?utf-8?B?R0kvOXVGeFE0c1FKc2JHaHhaOWdhc2o4clZCeWxZbGxBMTdzbWFjZzlJdGZW?=
 =?utf-8?B?dU5ERUl6eGU0WDZEbjU4enhJbTFZQU9IdnIrWDIrYUpWYjFORlBNME9Vckk2?=
 =?utf-8?B?bDRURUNJdU5CK3JGN0lkVXoyNWd2Rnl2L1V2cmNiNFpTK1lSZGJ2YnFqYjM1?=
 =?utf-8?B?blFDalZURkp1K25uYUdMeHhGNUFRR2xrOEthV0ZBNjZOMTNYVnRJdVJIbU84?=
 =?utf-8?B?TlNxYkY5a2pwZCtTeWtEV2pHaHIvS1FMeHowb0F4SVRnUEhZYjg0akhLV0l2?=
 =?utf-8?B?ODJaRzAvOW9wcUNOMW45N0pmaHQ3Uk1KRXhTY3p6MVgzaS90SUhPVDJ3M2wv?=
 =?utf-8?B?Z0dBZkllQ000K1V4QTVNV1c5Zm1jNnkwcVRmMzhIekY5NE11QmlxTml6MVRV?=
 =?utf-8?B?NGoxamROVEg3c1FrVW1uQUZSdDR6akFKRXRraEpEWWd6NlFrdit4b09OakJU?=
 =?utf-8?B?V3BtWjArdzN6TDI4TEd1WkltWGo3VDB4UFF0R1RFdWRWTVBPWUdHc2VqcElp?=
 =?utf-8?B?WUhyZG8yNGg3MEU2c3A3VHhTWnhoeWM2NWxMTzFvUm5PYnYzM1N5enlNRk5j?=
 =?utf-8?B?VWN3dHVYMXI5UUlvTm1XZGErWlNXazJLQXdJK2tsOHZLVndkRkgraTJ6NlNk?=
 =?utf-8?B?emVmWXl2cXNOVk4xYWY4MDRRLzJOU3A3aWZTTDlKSVpUTXB4R2FGanJiK29I?=
 =?utf-8?B?aFZ2NGlWVWEyVE1JWnh3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUd1YS9xVHc3LzFvN1hNT3J2YWhvRHV0bC8zcjZFakE3OWhVaHNKU2RsaGkx?=
 =?utf-8?B?RC9DZVlvaFpBZE1xWThrVUhySVpyNUV3ZkRNellUQlIzNUZFbHBmWFYwVHBu?=
 =?utf-8?B?VHYvZC9zOHpxMlZ2a21ReW5wL21PMnhrK1ZCZ2F6YnY5WVVySXlFdFByME11?=
 =?utf-8?B?SzZLT25HY2dscEFOWUVKdE5WUEVyMTRRbWdwenVuWllZeHUyUzUzNTdsRXFv?=
 =?utf-8?B?WEkxU0FxNlNjU3hQOExBR2duMWtMZmNrTlM4WU1DaHhKRDVtRW52cVlSRmlJ?=
 =?utf-8?B?OG5GVjArQXdHM25sb1ZTNlJxTjFZYnh0RFhTT21BeHdNT1VsbGZIc1F2OC94?=
 =?utf-8?B?L3JtN053YWdwcUFUbHpSNXRWc3FmM3JLaWU1VVJpbURNbjVLUGMrektVYW5V?=
 =?utf-8?B?YlhYTnpkblNvbHR5QWQ1TVludDUvYWZ4aExJelZBTnA1UUtOekM3MkkybG5T?=
 =?utf-8?B?cEhKV0EvR0ZLWlAvWkZvNWxtN3Y1UVJjYjNFRitaNGgvTzVGTmMxdDlDaFdh?=
 =?utf-8?B?Vm9KbWxhSzNIdHhCSlpETFIvSnpUS0xTbGpLd3IrMU9sdjdQZkpxcG1MeTJi?=
 =?utf-8?B?dENsbkZCM0dMUDZNa2xLUlpRNHEzL2ZwblBLRExhb1p6ajBTVHpKdFVFSWdZ?=
 =?utf-8?B?cEtjcXA3Z2xPN0h4RU04UXBwOUFqeWJTaGpZQXFTYlY0NmhSZlBYbVJneUxP?=
 =?utf-8?B?Z3k0OFNmVDRCaDVSKzN0SlVRVlBOQVpCMzdMYUh1cjB6N0t5bG9WMldEUHhJ?=
 =?utf-8?B?a1NYUG50bWVTS3EydzV1WmxNY0xmUzIyWEhlWktpaVc4U2VOQVNCeEV6NkFi?=
 =?utf-8?B?bUhnM3hFNXV3QWJGUUZCS281RFpFYVBpOHFmOEFCL0pBZmZXZEZpbDJPOElm?=
 =?utf-8?B?cGFpc2NtT0lrR2xvQlF6WUpPVXNwVzlSQTMzaXh2WlVwTkJMTWhSd01uVmda?=
 =?utf-8?B?SnI5Kzhmb2h4NzY2enk3NkUvUFRod3V0Z1FMcjI3L1pJeE1oZmhRQ0VHWTVD?=
 =?utf-8?B?RWpjQ05SL0tPbjkyRnI5VDE5b0o0SkZ5R1E3amtRNnphc1p6cVJkZGlRL2th?=
 =?utf-8?B?cVpQYUl2bDh2bjZUTmt3TTB3UCtMV0VaWmV5R1FtVGlXVmdFTDFLVVRzVDRk?=
 =?utf-8?B?bTFqVXJIdkYvYVFlbmlGWjkwQmlncjQ4c1N2VmFkTzZVUHVBbjNDNGxmNXQ5?=
 =?utf-8?B?Sy8vSzZWbTR5N2hJNFRqVjhUWjcybEpOWW0wUVJoU1p2c25TeE81MDc3c3RT?=
 =?utf-8?B?TXRuY21hY01Jc2w1Rk1LSFN6YVNjRWdtMUI1U0FTVlhGRTZZVVZsY3FvK0xk?=
 =?utf-8?B?NzB6UmF4OVNXazdlclVUL2daeG1NblZMQ0JhSzZETXZrNUJPcVJPbnpTcTEv?=
 =?utf-8?B?TlRuWUdSSjRRTjYyYzZ1WEwxN28rS0lwNjd1RE5zS1R6UnYrbFAzNUM0Vnht?=
 =?utf-8?B?c1RKa3pGSXAxNmF4Nno4NkhEQjJxeTNJNU5obzJVRGRqQ0xMcy9lTWVHME9S?=
 =?utf-8?B?ak5La0NLLzRjcFN4cm9jZTNoMm10S0pYblk1WWJxVjRKVk1EL1NVY25LL1hR?=
 =?utf-8?B?Nll1K3NCaERxZGt6ZmVoV3k1aGVmWEhnWTBXdTlKR0dLVTNIdHIvajNsWUhK?=
 =?utf-8?B?M3RYWWg2NCtUSTBMVGs0Wlk3Y3JzTkNlVUdHY3ZBOHVPVVAxb3BndTNUVzJV?=
 =?utf-8?B?ZGJhaFFycytWeCsxLzFzQXFHQ3ErVEw4ZzR2TmVXOXF5Um9mMGpMcWVSbnNq?=
 =?utf-8?B?cEUzWDROQ2tWZFo2QmdLbndad21ReklOYnV5dzUzbDdVL1FOOUdXT2lrc011?=
 =?utf-8?B?NzA3RDYzd1FuTHpmN3AzUVR2SU5SSnl0TmQra25IZkc3YmtQVHpwYWk3M2Vv?=
 =?utf-8?B?TS9rVmtiRzViRmU1WmUzYnZMektkU0t0d0t2ZWd5YlNIV05URGxzdUhtSHMv?=
 =?utf-8?B?NkN6ckhCbUR5QkpQbHVmcjF2OWFvT2ZXakw1d0FZT1ZQdWNlaVBLVXdsWU1v?=
 =?utf-8?B?VG8valJKRGgxU3Y4VmN1akxuL3VKaVQ1MEpYZ3p3ZTFLZEgrVjdtZkp1c0d6?=
 =?utf-8?B?ZEsva3JjS2NLeXAycUQxdnJTUG9xRERFMGVqRm1oVFBvbnNGSEhza1BjMGVS?=
 =?utf-8?B?TjhDUnJ3YzBQSVZoN0M0TVIxV0NxazdmMU1iRGFPaTMwd2RHbHFzTkFqRUdr?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3337c8-612b-4e82-024e-08dcab3b3721
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:16:39.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKugVhPXMf4LLpgIxkvyFfKKzdZq0uyEVICHhfAGrtrQtt0GHPg5/fUVS5PofU+dG9bxF6yyWpHa6JGENhd9DxGfmu8EonMwW7B0dZv0TfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com



On 7/23/2024 1:27 AM, Paolo Abeni wrote:
> On 7/18/24 10:56, Corinna Vinschen wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> Sabrina reports that the igb driver does not cope well with large
>> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
>> corruption on TX.
>>
>> An easy reproducer is to run ssh to connect to the machine.  With
>> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
>>
>> The root cause of the issue is that the driver does not take into
>> account properly the (possibly large) shared info size when selecting
>> the ring layout, and will try to fit two packets inside the same 4K
>> page even when the 1st fraglist will trump over the 2nd head.
>>
>> Address the issue forcing the driver to fit a single packet per page,
>> leaving there enough room to store the (currently) largest possible
>> skb_shared_info.
>>
>> Fixes: 3948b05950fd ("net: introduce a config option to tweak 
>> MAX_SKB_FRAGS")
>> Reported-by: Jan Tluka <jtluka@redhat.com>
>> Reported-by: Jirka Hladky <jhladky@redhat.com>
>> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
>> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
>> Tested-by: Corinna Vinschen <vinschen@redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> @Tony: would you like to take this one in your tree first, or we can 
> merge it directly?

Hi Paolo,

I can take it through IWL unless you need to get it in sooner, in which 
case, feel free to take it directly. If so...

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Thanks,
Tony


