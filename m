Return-Path: <netdev+bounces-156182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FBA05603
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4D47A059E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AA1E9B2B;
	Wed,  8 Jan 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laqDr7JM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8E1A0BDB
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326761; cv=fail; b=fE6SRiXZgcTK7R04AyH4Cl/UeX5rWTKuqxYYX5JtBmsQv6yd1hL3ZH7HzrQRLbZwNU6eqBv65/bv7KhKUu2fa310Lpj6Y3iLsfoTboUL6t7n7pYGqT0xljb8ny3JyqG06cmzxLb89JDUKPy8JYRM4+IgnzI7gLEdKCQZSHBgQtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326761; c=relaxed/simple;
	bh=zdNyP0d31MYGY6EOmnIgCpR8V3pvyrIil9K/aashHjE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EyWI1vsu1bvJZocNiD0iqWmY+5QYj1vcbBFnTYOvpzxugJSPc1MhzjHj6xLOsayZur19IoAqe1M6XdeV6e1chmxmpinsW1+YGgn3ZwFDbcJc0p2Jnf3XsvrMEZa00COpVBnNkdaXovPf/6a94udq+SONn9QQ8TGyNrzuiBLj/9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laqDr7JM; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736326756; x=1767862756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zdNyP0d31MYGY6EOmnIgCpR8V3pvyrIil9K/aashHjE=;
  b=laqDr7JMspsKiLT1JCWHKSKhnuRakNfKoZ+p7Z+/OW1iu+hhZQcBnm59
   /SMkjy14Tx7yypHU22IT9xzsds00rXGrP/eqcZsznQS87Vr9+TBM6BxJp
   zjFXtmLYhWo1lwoHpefu18bEIk8x+ik7+p35EVCyqIruKSiM2bSjquGkJ
   Y4rfJ8wEk8AWAy28/5elBMcacN3EvYZ3+ksweCn38rwtohzvGlpFladKb
   8Wh/boLo6w+rrYnJxrq9Ph00VVTtdOOfTF9AuKGiGOJnQNURThhSgrOcW
   O1TXRXJJYjIclQAX0vxIc8bRnZw4rgR4wdkyK3Hk7sd2uLsr/RVkZiYrm
   g==;
X-CSE-ConnectionGUID: HTE6RBIsSYihqXEF/99HGg==
X-CSE-MsgGUID: qBx5urHeStCZB/Nat6ypCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36236210"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="36236210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 00:59:12 -0800
X-CSE-ConnectionGUID: 5gVT/L/qTwGUDxoi0nkCtg==
X-CSE-MsgGUID: hQJHkzcDRLKp1BFKX4ABww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126318859"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 00:59:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 00:59:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 00:59:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 00:59:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phmOoShn0k9lLy6DJVBSJjBYQgTRkni2Yg2kwEup5i0VjQlJzbls2lU6K9oN3SQyrM1TJCWaGngO76+4nqO3O562K7YModkO8KpIbOCYeJ5lHfCZNFCHsNVMhu+m/1JiibdSXZzBRuWH3QtoDSP5FNY6eM5vvfcyYSuac7HTUGi4N7nsrRot39Nbpg+lOpm5ueeq2AFZrF1jr2ViOA/fbfFV4fTjXiXLWBaJYgFvyKibyvQOi4Dfc5/Fzt4A3//e1HthR7E9hE19VuWNCq77BamrfXT9PwHYUQc6/I5heyF9rSaDufuSa7vMsW49jbXbh6oNl3FfSj4/gUIkMQMmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORVUzBQTB9frP4BE/l9Q+IdWyATOHpsQYuMfniOZqGg=;
 b=goSCyWiLT8wMwXWWOUHiVdeg87zYDTJVJ0ke/xfZA63pEizvjBgAujb25Uh3JcEqGaqg7DhXiqAg6gDLsZ5xbgOE9f/vk/N6WH6zulEmvPMatr7E6nNc5HEHqwIYWpqTJvLk97EW9t5BEiI9FHwCEAr0SgcwWPPg+INEl7W/A4iTbwzy27RI4xNLCONH+tYcDBJ4j5sqfSutpEgYvYzh7bggQn3I8aTmDWrch5JS9PLDkFKTufZQQ00FACWBxDdEajG1UcQrqm4ER/KeHx+eoW6ILhDbFqggEuGjDcrnGF0kMpVMqaESzSgHDm2iJ9ki7/XWPgRlAlWYtlmXF6HEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 08:59:08 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 08:59:08 +0000
Message-ID: <54c34e2c-82f9-4513-8429-9ea19215551a@intel.com>
Date: Wed, 8 Jan 2025 09:59:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix unaligned access in ice_create_lag_recipe
To: Hongchen Zhang <zhanghongchen@loongson.cn>
CC: <netdev@vger.kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Dave Ertman <david.m.ertman@intel.com>, "Daniel
 Machon" <daniel.machon@microchip.com>, <intel-wired-lan@lists.osuosl.org>
References: <20240131115823.541317-1-mschmidt@redhat.com>
 <e6f59bda-9de8-3d30-3f37-3ab1ec047715@loongson.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e6f59bda-9de8-3d30-3f37-3ab1ec047715@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0149.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::33) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 632dda01-b08e-46f4-50e8-08dd2fc2b650
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Undja1dlaEMvdWhtRWdLdzNtdXFyZFZUREgwRkdrdTRBTUtBejVTMEpaUnU2?=
 =?utf-8?B?MWpycUQxb1JRUGF3L0xnbFpzbUNxNUlka1Rab2tKaGwwNEhHQmRNK0ViRm1k?=
 =?utf-8?B?N1lMMVlnVGRBQjJnL0Y1RzJ2U3Z4MmxqNzRUN3cyVWFTcFVSM0U3T3Foemp3?=
 =?utf-8?B?dm1TZkxxTFNPZkp0U204QTNVNTAxVW9yM2c3Y21NeHR3R3ArNlNFRFFNWmdO?=
 =?utf-8?B?S0x1Q0FtZ1VVdHYvdEo1YXUwYlpyQlUxa2V4UGdQaWRoVTVDYmlhQ1NHTGVq?=
 =?utf-8?B?QWVLeXJCZ0VuZ0FiaXBISW9ScnJKa0NBbHBGUWtRNFB1M3N6WjRrYUdlM3pR?=
 =?utf-8?B?ZEZYdGkwZTRJSmFYbjFOTlJIM3VUR00rblpnTmJ1VGxSY3BnVWljTmlUVjFR?=
 =?utf-8?B?RWpPQ0hITDJBdW1ZUkcvRWxlN2FCT2ljMVA5OVNGdTRXNmpXZjF6T09veldG?=
 =?utf-8?B?T0xHcmRZaVJZRWticmdJTUNCNi9OK1VBOTl3aDM4Z3locHlIN283aU1zalV3?=
 =?utf-8?B?UTQvK0dNYzlsWmlDT3p5NXhlMFZqR0hvd3pRS1YrSElRMGNFeFBteGJQcjRr?=
 =?utf-8?B?YTRXRWlMVjNXOUt2c2prZ0FpUHNJUEFENTRhZW5kYVVuclY5VUJ5YnhzL1A2?=
 =?utf-8?B?M05ZQy9DVWprYTY4TElMcitiWTVvb29SYnd6VkRjQy9EOXJpK0o1ZXJ0WFZm?=
 =?utf-8?B?eTBlWTdLeGo3QURIL2NBak41NDI1c0hIN05PWTFLV0dJZU9QQzJRWU9KNHJD?=
 =?utf-8?B?QWt3UEdHZXhHQzNBRVBubzIyQ2JPTXE5TkFOYk5HV0FHS2FTa0tFV01VTndD?=
 =?utf-8?B?MGZSSDA2QnAvUGJlY0tlMFRSNmFtSHNHT1p1SzR0NTJDWHNVZzhhRzlUOFpz?=
 =?utf-8?B?em4wN3l2UTE0dE9MLzhCR0wwWGsxWTYyRlFBOWlVNmxCMktWMzNPQU9BcUZm?=
 =?utf-8?B?OEZZdmo5K2JoM1o1eHN5a1RFd2xlTjhObUtCdU14cWtCVzR3ekZzem0wZE1G?=
 =?utf-8?B?YnEvcldmWmZRSWFEbDFmTk5zNEMwdUwxenROZzNJbytpMjBHdlc1K0MwY1I2?=
 =?utf-8?B?TUViZm9teS9WZEwxVXh4YXk1WGpFNHBFN1hZei9GVG5xSkd1aDVaNm9iK1gx?=
 =?utf-8?B?RzZnNWFlNFZSSGJTV0dqcHlyWmMrZ3J2K3FiVUVqL0thSEpqa3FmVk01YVQr?=
 =?utf-8?B?aWw5Y0k1OTk0M0FTaHNmbTBYakpyQWtYZDR0ZjgwdXhoZmNwY2EyRk5JU3Jz?=
 =?utf-8?B?am1CY0N1TU4xd091ZWphRFBDTGh5SVZOWVFiZE0va0NNT1JkVWdyWFQxb2V4?=
 =?utf-8?B?bU9scWUrSWtHVEQ1eWMyajRQSkJqVVpkUlNTVnlZQ0pEM1FsZzIxYkNTbVFT?=
 =?utf-8?B?bHlod0dkc08vb3ZicFdpcmlHalc1ZEJnSytGVGRlaHFCdS9kMUY0ZGZRQUg0?=
 =?utf-8?B?K1EwU2U5ODFRVllOd09RUzJMZE1WRVkvZkk0ZEEwd0pkS08zQjViV0RKeUJt?=
 =?utf-8?B?eFR0RHQwbjJ2N3Z0T3kwMWc0clJ1TkVMZS9jKytoUzlVRUFoNjA1bm9Db0dr?=
 =?utf-8?B?SWs3NDBvMWJ2V25QSWtwY3dDUFBUMVlid21PL1g1UmxTMm00OHpTcjFxMTZl?=
 =?utf-8?B?UFJuVktQUFhTNTdWaDdxQXlZSDZlWkZXRXdKN3dBak96SHdwbW9WdlZDUG4y?=
 =?utf-8?B?aHFsVENYaURzUGNNQTAwbkhMYW15WVExUk1EOFpKV0xIUTFCb1ZMUStsOWtD?=
 =?utf-8?B?NTR5dHQzVUdWZ3lWQkdSSXVhUWZzRmpWQnh0NFY5bkJTekRld2pVWExjL0ox?=
 =?utf-8?B?bk05Sy9FK0I1SFJuMDRZZHl3MThWWXBwU2RNSjE1UldZWVZDRm1ZVE5LUkhY?=
 =?utf-8?Q?ggTeuAk99VtbL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm00bW84NHFFV3JsaE9SSWk5Vnp5Ym13am04b0tXdmovMjE4WFp0MDF4OWps?=
 =?utf-8?B?cGtXZklXZTI1ajkxSGlna3RrOVUzc2NaaHg5WHNLdEZvNkd0MnhMVkt5Q1BI?=
 =?utf-8?B?MGp5UnZpSlVNaTNJdzJpanhQTDAzSTIvbEF4QnY0bHB6UEJQUit4RmJncVlw?=
 =?utf-8?B?WTlqQUE2MTJlSFREWGpjc2FweVZLa3JESUR5YXI0R056YlgvQ2RPcng2Q3Js?=
 =?utf-8?B?Vi9HbTBOV0xhUHBRV1pzbDJQTTQ3T21Nbyt2R29SQ3orVjgvbGpRem1JcWJW?=
 =?utf-8?B?RGtRK2xWTC9KUXdydlhTTGpYbWE3azZocFAydFpUT3RJRWdISFN6eWNPUWhJ?=
 =?utf-8?B?bW5Rai9qdWR1U0VKc2V6ZUxkVmNTcXNlR3FoYzd3VFdBNU9vZ291OTZLcy9Z?=
 =?utf-8?B?akhQZlRNQ2MyN2pyY0lpYkgvVnpLc2hrOWdhWXJCbTJGcmNWT1VBRzY0SWRD?=
 =?utf-8?B?R1BieFFGUEZVNHplOUlXNTFuNm1qL0NleGI5bU9pakdybGtpWEFhNmVFUWdF?=
 =?utf-8?B?ZFdBNy9wY2hUS2dBWDZnRkliU3g4NzlpbjFmT3B6VDZFNitvL3FvdUhkTHor?=
 =?utf-8?B?K0QyQUhaUzFxSFRYSGZabVdxWUhkY3VKNVgxblJwcWh1cWw0Z3VsV1FCS3RJ?=
 =?utf-8?B?OXFySGFYN280aDN1Q0Q0SXJ5NHExbC9pMlZ6cXBsRVJwSHVOemI0eHNXU2Rx?=
 =?utf-8?B?NTZBUFN4dHIrUmZMUlkyOHRxV1ZwMnRIb1VPak5WTFJqazd0N081R2xPaXhK?=
 =?utf-8?B?a2t6Vk5hN2xNYjlVeTRTdVNSM29tcHlsOHNQRjFBOGZ3Zk1JNVZUV01ha0pQ?=
 =?utf-8?B?SzkvVmN3VDdrR1laNjRVa2V5aXhZRE13U05HbkV2TlVMRlA4ajluSTQyVzBz?=
 =?utf-8?B?Wmw4YW5oWVJhcVRTVS9BRjAwWTBWS1NqZ1dBbmxxQzdNUGZiemZ4bTZuc0dX?=
 =?utf-8?B?MDl1azFwMkYzSGtkbm1BTGtzT01JaDJRSVQxOWJXcDR4aFNreU9oN1c3c1Nw?=
 =?utf-8?B?N1FwVHo2N04wZFVwMVFZdmhILzJ4N0s2SmE0OUtXb25mRFk5dnduRDZvUHl6?=
 =?utf-8?B?KzhNL1dFVi80Y3VrSlB6UG5QaklWa2l1MFRSdWEwL3d5dGllenYySSs2Q0lp?=
 =?utf-8?B?ZDJkZUk0c0xpQkJHVlFJWWF1MEhEcjZnRkRLdi8xQ1RsRDlXK2pVbWFhdlpR?=
 =?utf-8?B?SWc1QzA3bm4ybnhqYlZ5bWEzUHQ4UWhTVTIxeGxQcFdSZm1kNmNmSUZkTmtM?=
 =?utf-8?B?Rnk3eVBRTk80SWZjQ0tyTjVNZU81ZDlwZFVDZTZMcGE5MDVzclptVDBOdHRC?=
 =?utf-8?B?K3BWc1lTSUpXVU85SVFpKzlNdjg4VGsvbnYvSnhPa0xlcWlmRlFQL095VVpY?=
 =?utf-8?B?VUIwOHIrT0Jrd3ZZcDJvSDVKMlIxWG1OdDZoTFZCbEpnbGxid2JnT0Q3V1Vq?=
 =?utf-8?B?QStzTjVIelV2czE0TTk2bVU1RS92RnlyUi9nVWhhdUN1UjgvZGxaaEZ1eStE?=
 =?utf-8?B?eUVxZ2N6TERQNWlVRFE3TnVOeG1mc3NnT1h6SzR0Z0p2NGY3WXJobkYvWExU?=
 =?utf-8?B?ZzlFdjdPMVRnUkhRRDQyaENqVFpFTld1MStNaEFPN09qOEM4ajcyZmhUaEti?=
 =?utf-8?B?NnlFZ2loSk5EdGxTTkVaWG1JY1lhR3dWNVhsMlZ2cG0ybVEwNUZmbnlCdE1F?=
 =?utf-8?B?RkJ3Z2FkZ2Q5ZmNoTk1XaGRWS0xEYzQ2cFAvbFU0S2MwNDFQeWFSRzdqRTRD?=
 =?utf-8?B?eG1TTEdVRkR0bVljb3Y1MzVhZk03d01lNVBFN1dzKzNnbVN5OVdtV1lLRHQ5?=
 =?utf-8?B?YTR4dFFMOFJxd01qeDFJb0RLOXY0U3N0cVB6VWZUUEFYS3htbjk5djZzaVZH?=
 =?utf-8?B?MmFXeHoyNVNCTnR3elpseFQ4amJDVU1OUEYrckNBemRyZEs1eUEzaTNOemtZ?=
 =?utf-8?B?R1pwMWxxcjJ4ZmY3T243d3RNNXJSYktLK3I1TWZhNVUvOUc4UzdBUm8rQmR0?=
 =?utf-8?B?dXMwR3RzUjE3Y1VwejB0WTVpLzR1ZHFGd2Z2RnlzbnEvODN0Zkh5NFFvSzNT?=
 =?utf-8?B?NmNkd3ZmM05jSTJtRUkrWnphbDVRdHVmWHFBMGRWTFFudEtET2xUMFlKeEVv?=
 =?utf-8?B?MGxxU3RTbWlyNVdlWEZUVVRzSHBwUFdZa2FiYXp3YmpVRE14OHZONnhZMHRQ?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632dda01-b08e-46f4-50e8-08dd2fc2b650
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 08:59:08.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZ8QbkfdgilikJjsRWPncqAm4I7CDi7Pii0fd/tjbGOjrtbW56tSp/3lWUjtYjzJPx2im33LTmPi968VvU/NvT0nefJLdJw9QLsdxErrNZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com

On 1/8/25 04:09, Hongchen Zhang wrote:
> Hi Michal,
> On 2024/1/31 pm 7:58, Michal Schmidt wrote:
>> new_rcp->recipe_bitmap was written to as if it were an aligned bitmap.
>> It is an 8-byte array, but aligned only to 4.
>> Use put_unaligned to set its value.
>>
>> Additionally, values in ice commands are typically in little-endian.
>> I assume the recipe bitmap should be too, so use the *_le64 conversion.
>> I don't have a big-endian system with ice to test this.
>>
>> I tested that the driver does not crash when probing on aarch64 anymore,
>> which is good enough for me. I don't know if the LAG feature actually
>> works.
>>
>> This is what the crash looked like without the fix:

>> [   17.599142] Call trace:
>> [   17.599143]  ice_create_lag_recipe.constprop.0+0xbc/0x11c [ice]
>> [   17.599172]  ice_init_lag+0xcc/0x22c [ice]
>> [   17.599201]  ice_init_features+0x160/0x2b4 [ice]
>> [   17.599230]  ice_probe+0x2d0/0x30c [ice]
>> [   17.599258]  local_pci_probe+0x58/0xb0
>> [   17.599262]  work_for_cpu_fn+0x20/0x30

> I encountered the same problem on a LoongArch LS3C6000 machine. Can this 
> patch be merged now?

What kernel base do you use?, we have merged the Steven Patches long ago

