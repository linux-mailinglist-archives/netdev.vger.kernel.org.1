Return-Path: <netdev+bounces-184902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B4DA97A7F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CCE3B4D7A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDB1F09A8;
	Tue, 22 Apr 2025 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKHwr7mD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBCC1E8847
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361039; cv=fail; b=srFKT+B4kC6V+/vwXoq0peg2sMCm88+BDdLMtDbxVDFxFhy7hFK3Ll7G88R0w1sbKxrYnLtDxsWNCOOLb29NKIsBChdnBJIt09H5SXGfAGpWkg9mvGnBYU9kYkW/GkWkb3zWv/9Uw2qIy9O2FH7dOf3LMACu7ijOdRfsQEOzV2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361039; c=relaxed/simple;
	bh=/a4ISEOOCEaxx6ERvpW8WaxVk7f2kQ5WoGZM7/6wNE8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R1KOk6P8m/Je8Cijo+PI9HebifYeo/9YVKQ6tF3gMFSDChDYHjcP0LgtaCCgz1P1ucwDBqt9D0qPMZzKtoTdYWOMbz60KYKacwCd4eyJ/9FLx7m1d35Pe0WNNTSr/1wfGaxG1UIkGjbwHaIty8bSvYMfptM4TiaHRp8ohttP+L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKHwr7mD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745361035; x=1776897035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/a4ISEOOCEaxx6ERvpW8WaxVk7f2kQ5WoGZM7/6wNE8=;
  b=LKHwr7mDdoGLzvHEgY4o9uG9VI03819eV+anIeOc00vuha9kosYvUdQC
   148/DK7oFaULl1fkwwhna8MmrI61NyACUJ4ZXsA83F7CEGFEvHiLcz+S1
   Ep0jeTvIs0PfGmBkzn158JAgGdaGrg8VodVGOKHrGN+dBu+IujokCKq8N
   ibanNeFYQD0yZ9bbM5xB1CkJJjvNT2OFPxgOciAafkt8F/0WTovGCodyO
   Jwx06mXD1FPxBeNgImLsx07ZKQ5SSYKRHq3T8DBaPaQL0pUgXQg8gOEvT
   8+fMTwPa2F4kkPkVY9w6lxy7fCuIj6S2mzzB18rVsoumgM581HMkyI2fP
   Q==;
X-CSE-ConnectionGUID: yUKzc+m2QaCZkJiMSHJeww==
X-CSE-MsgGUID: Zbf8qd/6R0C32X1GgKrJyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57595002"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="57595002"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:30:33 -0700
X-CSE-ConnectionGUID: /FwKvTTlRSe+cusvAydNzA==
X-CSE-MsgGUID: b8ndhFcvTWKGd339k3aTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="132032567"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:30:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 15:30:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 15:30:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 15:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdb5ZpnT9hvTnrJ0PfNVgF447K2f69vt16L7J5PwqZDZ6VIGcJsbnfAH5BEY/Mg7cN9yw/6t/zkYQP08ySzla+BckXoAg/mxgSbU9y7vwjpVJy5O/Dx8So+L/5w2z7n6wyXitd8bLT0x8wDkR/g1COIwMIEr5GDIYpUEhh9IDi/j9HATe8S0WyZ7z5crEf16WMWfavZsjWOx/056f3q0+Du69STYuWRuMQd2XiqNvHFZSt1h3KW4VAoShA7jHNUZ2KkxZCI5nm2SrBtw62K5QocWJ0CVvIA7NiKYXgXJ+fDKYyhVDyJjcc+a/zHZAGcXDp7U/4JmxSWKLYjKc3zshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA30F3uqC92ERBMTu2R+zVxc9kZkqOS+PMzrwWpLXCk=;
 b=s5/mNIT+pu0+YsnQVEqu9nj4sRTWS1lv9bzY9pmkTyPHlPKgXS2B7HHqMyDFwWQ74tRakiu5cvg9J+VngyeIXncTyU9VU3LJzqHO7v/q0YFBx1IcKHb/xavZP01q0Vs+wlxdxiC2WUFyeBU5k2X/wh20tz/ZFFbfGcoc7WPzycSetpc200j+DzGwi1rZnCYIFdkzC67BuoRqWpIY4lx2OtfVn2MgYX/MRRQGccp6JoNrcYOas+jEnShum48iqDar1OLienVRxWw/2au4yhhr8ntpcOezs0Dna402h7Z0UARTquB1Hr9YXLlw9CT1SLB7e1+NCSFjC5VNyEbx/tfAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 22:29:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 22:29:10 +0000
Message-ID: <c34ef8a0-20fd-4d0b-84cc-8f829f4be675@intel.com>
Date: Tue, 22 Apr 2025 15:29:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: airoha: Add missing filed to ppe_mbox_data
 struct
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
References: <20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 442bd43a-e41d-4cf1-d501-08dd81ed1a59
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2o1ZUUyTWRBN1JkN0ZZMk1kWjY0dEF1UmhhZmZFQ2F4NXQ4eTRTbzNxZ0dp?=
 =?utf-8?B?VVJQQm1EYVRYM3c5ckpLMGJrTjZLR2dyNEZTVjZsT1IzODBOQWNSbHpSSVlV?=
 =?utf-8?B?RUp2VGlEZWRIWGJkMS9BQ1p5RlZPVStEQjY5RnY5b1NjcXFDUHplNFhWRzV6?=
 =?utf-8?B?aVZ4SlZ0Z2pGaUJlcGNWSjJZVDNPeU1TdC90VnZBWkJLd1BBMytVLzVneHV0?=
 =?utf-8?B?di9RTzI5blZYYk85NGVUbFRSamlRZHFLekdXMUE3Umd6enFZd2Z6ZkJRLzQy?=
 =?utf-8?B?bGdzS1U1dytLd0ZxYUJ1dUw4S0FJR0NaOCtNMS9EWjZvYUhwUkh6QWM2NnM4?=
 =?utf-8?B?NDM4NHVJS3k0UjlDcmk3anlrZktrUjhiMURvcmR0WUlRR2g2SnUyR2NZdTJn?=
 =?utf-8?B?cCtlUjNsTm5nWUgxRUR4T2Z4YWM3b241cTVIMUVSV2NPaVlqdVlxalJkOEVt?=
 =?utf-8?B?TG1zQXU3dUxlVmViZi9pUVZqQ0hvMUZTZk85eHQwemwrc2czTGo0U09uMWtl?=
 =?utf-8?B?c0hSbHVMcEdVb1V3UVBUbzV1TFF3MVRCTG8yaUZuMUZSZTNxNGNNdW9JT05V?=
 =?utf-8?B?WlArVS9oQ0VwbGxnS1J6VkpYcHJFNUp6OUVFRlh5d2s5YnJsY2FSS3FpcEtu?=
 =?utf-8?B?dStjbUVXOWNPcDFDdVpnTmVHT1hkNHovV244N29iNmYrVUkwbXNWUm55ZkV2?=
 =?utf-8?B?SjRUazRKVGdsRFU1T0pQSXIzNXR5TFdTakZOS0l5T1NmQ2JsVkVXRURMdXkv?=
 =?utf-8?B?SDF5WUVBVVNhdU40ZDh6Zll2aVNadk9IdHBuU2dQbVZKWjd3cGtUMFE2ZFNh?=
 =?utf-8?B?QU5wRDAvakJmNVg3OGh0VitxNFhMcitXMEt4eDI0MEVNT2FnNHQrMkVmSHZs?=
 =?utf-8?B?SHJCWXljeWt1MHlSemdHRUEwNUUrVmVTNDN0NnM2M3cwVm5acEdsMjNRaTlF?=
 =?utf-8?B?KzZTL21ESWdiMmpxSmtxTkNnK041ei92ZGpNK0ZRbE4wSyt4MExkYnFmTFNt?=
 =?utf-8?B?TnVLNE4vNVE0MzZQTWpFUEpmUHdtRk94SWhNdmhFZnJhSVZzM1NwbjI0WC9K?=
 =?utf-8?B?SVIxRlo1U3FRWFBPWnNQQ2dMQWJUajNxTVF1Vkg3OE1TcXJPd0pMOWxVUDNs?=
 =?utf-8?B?SkJGSzgxTW1Gc1FhVGgraVBRRTJEZDlyeFpxeE1IR09uTklvRUdJQjQ1ZTdF?=
 =?utf-8?B?a3BHa0paS21hM29QcGtnY3NQUHVieEc0dlF3UFJJQkg5UnNveEc4cTQrd3hi?=
 =?utf-8?B?bUNLTWtTMHV6cnA5M1g1b1Y1ZWNhcys1cUwxUXVvcHlzclpFR05PVXVTYm5L?=
 =?utf-8?B?TEcwNGE0T004b2NUTDFaTndXak9UTjVWMGF2RXovdkppbGN2SGNMWXh5dEt3?=
 =?utf-8?B?MmFZMEF3UFVrUWJkcDNERkhLSUZuS0NrQW93ZmFyVGU4VUcvOUdaZkhGT21u?=
 =?utf-8?B?V1VaYVdTTGl2VUlEdzZwTElXcTNqS00rdmhZSWRPdCtLeHMxZTN2dVFwMHlS?=
 =?utf-8?B?YS9SUVdhUVJnN1dyc1FpcmZrT2tTOUZsQzdCeERrZ1hiTnZiRkxrUjhMWkxY?=
 =?utf-8?B?Z1ZiVFlxS0pFeTF5RlVHTzY4OGdjYll5K0JJalBHRFlPbEVFTU5LVVkyaWF2?=
 =?utf-8?B?UUw4ay9OeEtGTzg3UjBWVlU3WE9xMktHVHpmNDRCMTB0ckd6RStWK2dOSE9x?=
 =?utf-8?B?SGhMSDd5U1FtTTAwT0NScGdzVDV6czVFWmVMVWRkRDQvOWZ3N0Fodzd4YUI4?=
 =?utf-8?B?U0JoR2ZodDRCL0ZjYm1VbndUWFRpUmNiMXZURWxTSzdVM0dEaFRzQ0cvTnFZ?=
 =?utf-8?B?S3RiSkNNcElVWW90ZVlRNEJqUzY5d0VxbEFMdWxsV3hWVERPaTFqeituYnVW?=
 =?utf-8?B?Ujh5QnNlRS9iclpYNFpqRnlJMnZyTGZ5QVUydzJEZTlvYzRFNmxHRmdvTWRI?=
 =?utf-8?Q?JMZdeLBacpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0tOeDdOK05UcUM0c3RjZlNEeDk1bkxJd2FwTFRrWFFQRERKa3NSNTNJYXdt?=
 =?utf-8?B?OVRkT2hJUzVLb0dCUFMwTjIvejJxeUhnbitKSjQ2UUQ4QS9qOTZnNU9OMXBK?=
 =?utf-8?B?c2t3ZGdrTXBzUm9ScGpKQW51YW9sTDZQRzBCRXlhamwyUUNWT2VZWXBsME5y?=
 =?utf-8?B?QmZpU3Ryd3hwQ0xLNG5qY2NYd0FaUFl1eHB5SlFUOFFGTUZLU2hEalExWkRi?=
 =?utf-8?B?bnJKckxEakczc1RGektuM0dZQmRRV2lJckV5MGZ4alJzeUZxc0Q4d0hZNlA1?=
 =?utf-8?B?eWxHdEg4UHhQNkJ1OHFKZUU3bC9PR2xJYnJlR1d0dEtVUVJhTWRTTlhzRUls?=
 =?utf-8?B?bEFsK05EbFZTbGRweURxTnpVUk9jb0dwNGhrN0E0NGk3cWc1WXNWVllScGZ5?=
 =?utf-8?B?MDNlRVpyRkt0Vmt6ZE9oTzl2R0E1RlJsNnpIWUNFRHN3dk1KQkluNW45WHkr?=
 =?utf-8?B?Y2NoNnhUNHpaODRCaDNmR0pJVG9MSENUNkgwUC9ISmd3eHlKSnFiQkVCbi83?=
 =?utf-8?B?Qkl6cHV6V1pWdVpIQXlZd2RNcEhNcnZlSmVaNGpZNGJqV2lZY3RxcHZkUjNz?=
 =?utf-8?B?L21XTGkzbklyM2tkUmd5eHNXL3BYd1ZJWmRaU05qL2NhclRYRGFIcnk5dFIz?=
 =?utf-8?B?ZmEwSkt2OVJEUGQ3WHJzaG5VT0dReEtzK1dhcHducFZvMzcyWE9jeUFwc0FP?=
 =?utf-8?B?eStLcWdHT0pvbnU0UXY4NGxyM2VIejdPeXBnZ1d4M3FBazhpa2lnRlljUDRU?=
 =?utf-8?B?bU1IVnBESUkwblZ5aEY0T0NuNVcyTzFWVDV0RlJPQzdjNFhROFFLTHNtSnB6?=
 =?utf-8?B?cU1CWUpJb09uTThjMmlNdUFBd2FNMUZacG5LVmF5WXd2UERHUGp2UGxiL1J4?=
 =?utf-8?B?cVVNcndydG1NVFVYRXVuSlRNWnBjVVF2c2F0WEdyQlMxaHVMT25EWGpkQmZh?=
 =?utf-8?B?dVRJazZ0WWltMHQ3L2ZpdTdOYnJxZ2t0S2w4YzhRYlZFWlJHRW9BZzdMOXpv?=
 =?utf-8?B?N20xLzJaNXBJR2I3RTEvUDZYY3lmVG5mRzNwMmRXZzRlM0o4N3k0bERQV0l3?=
 =?utf-8?B?NlVMdFRMSTZMT3pFRHBwM3l3cjdNaXN5MkRFTFZCbFpWL1o1Q2wva0JrcE1L?=
 =?utf-8?B?NHBZL0V6RGVYRnZrY3U3Rkd2UFNBT3hRN2pYTGtlSVFZY3dnYlc2Q0loNlJD?=
 =?utf-8?B?NnVwQTdFNFM5SkpUZnBqaHJneit2NTZ0OVFHNTVabUpzMkFQajVyTzFobUov?=
 =?utf-8?B?aUFvQmN0OTRCQlVPdkl6TS9yaU43bHEyZ0lFdEhmdEZxVnhQNkV6UWFvL0ts?=
 =?utf-8?B?U05Jclc1c0FWNkFNOGV6NllQZnEvMTh1dnBVTUo0S0NoUmZwOGhrRGM5b0pG?=
 =?utf-8?B?NUV0ZkV5Zy9xYjNkdSs4RStjaXlvalA3Y1kxS1R4M2hnL2syeXdSdkxpdUE2?=
 =?utf-8?B?cU82WVRtOUtGdkk1QzVrbFZHbktrUzJyd3FiWkd0aGR0U1ljTlBqZzR6SXkx?=
 =?utf-8?B?SmNpWXhwVlVGVUVYc2FDaU5oWGtDUWdFeFQ1dmVzejdUMGdLY3VrV1hlVGFz?=
 =?utf-8?B?VDkrSEpiVUs5Y3FJS1YrcWhrOTZqSnRaaEFJc053dGFwSkNwajFKTmhtSy9i?=
 =?utf-8?B?Q3FrR0dFZDdDS2F1d0ZDTUxNSVhDUHZKTVpwTDdkaDFGT1JOQkl6OFN5MW45?=
 =?utf-8?B?VXZkTlBkM2d0NHdhcTJlUFFzY1J2Sm1PWm1veEJmTytMNUdXN1YveXBaVkFX?=
 =?utf-8?B?UnFnSlB1bVVRUkl3Z2Q1YXlacXY3MTQveTM5MTBOYnBXenEyQkdHT1MvMytn?=
 =?utf-8?B?ckpvVFprQmFCaGxOcm5sOFY1UWZkRnl0TEdjQ0NZVVorOThXWU9qMVI1VVRC?=
 =?utf-8?B?a3pYZVZkZ0wzMkdIdE11dzNTY09OQ2VqeThGZmJMaGR5U054STFqY0hieDBZ?=
 =?utf-8?B?SGhlSkllU1EyVXlTUnJlUGR4RUVjQnhPWWVqUUxLTGZzTys0b0FRemY4UGU4?=
 =?utf-8?B?VVF3eFpGNHRuOXFPeGN0L2doUmowQStRUE5Wb3pMSmZxTXRUMlZtTUVGbDhl?=
 =?utf-8?B?b0NyanM5NFhnTjRidVN3ZHdWSWlUTzMwRDZxNUFLOFVrSE1lTUV0aTlJWjFD?=
 =?utf-8?B?RXJObTAxbG10QnVUTE4xd3VuSnluL1R0OUI2QlI3SXZaRTNscVdEeWNla1pT?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 442bd43a-e41d-4cf1-d501-08dd81ed1a59
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:29:10.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhqTU3f4i+X9wAlfFOxknN6e6Rk1SQTa2QqzI8lqPHoiVuX6A89f9Pr6T2DTXwf4mRixrSuCljGAqNinPje1PHT+mS2gPUoFqgzQ4OvPuos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8033
X-OriginatorOrg: intel.com



On 4/22/2025 8:59 AM, Lorenzo Bianconi wrote:
> The official Airoha EN7581 firmware requires adding max_packet filed in
> ppe_mbox_data struct while the unofficial one used to develop the Airoha
> EN7581 flowtable support does not require this field.
> This patch does not introduce any real backwards compatible issue since
> EN7581 fw is not publicly available in linux-firmware or other
> repositories (e.g. OpenWrt) yet and the official fw version will use this
> new layout. For this reason this change needs to be backported.
> 

To clarify if I understand correctly:

The original data structure without max_packet is for an unreleased
version of firmware which is unofficial and which is not released publicly.

Then, the official public release will include this additional field,
and thus won't work with the current kernel code.

Of course anyone who happens to have the unofficial firmware will need
to work around this, but that should only include a small handful of
folks with development images?

> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v3:
> - resend targeting net tree
> - Link to v2: https://lore.kernel.org/r/20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org
> 
> Changes in v2:
> - Add more details to commit log
> - Link to v1: https://lore.kernel.org/r/20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f27866896226c3611b4a154d19bc2c 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -104,6 +104,7 @@ struct ppe_mbox_data {
>  			u8 xpon_hal_api;
>  			u8 wan_xsi;
>  			u8 ct_joyme4;
> +			u8 max_packet;
>  			int ppe_type;
>  			int wan_mode;
>  			int wan_sel;
> 

One oddity here is that the structure is not marked __packed. This
addition of a u8 means there will be a 3-byte gap on platforms which
have a 4-byte integer... It feels very weird these are ints and not s32
or something to fully clarify the sizes.

Regardless, assuming the correctness that the unofficial firmware is
only available to developers and isn't widely available:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
> base-commit: c03a49f3093a4903c8a93c8b5c9a297b5343b169
> change-id: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72
> 
> Best regards,


