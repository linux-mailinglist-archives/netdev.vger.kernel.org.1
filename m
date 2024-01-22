Return-Path: <netdev+bounces-64667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC10B8363A4
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 13:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2681C26152
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1393A8D5;
	Mon, 22 Jan 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRX1vMOS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1A39AC2
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927515; cv=fail; b=AWMj2+xP68N5hv/R9xcP2516XpeWPRzdWJXROJhnCw6CWsiu29XZlrp7aU6qBuiJ5JaQEgj4R+p/aV5qBEwlR2GE0r+HYKwfqg+CwpegjJrVFYzA3HvGaY1rbDejC6JxGHw5pN1YDVZ3rlOewU5sIb7U8GcfWcyn28ZXODTery4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927515; c=relaxed/simple;
	bh=4w6SYJOD8WUweh7Ifjkrs4t5g9RxUqVq8XYjkZRk7Xw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Olope5F+CUvJ9YUWTV7a2mGQbnGIMFDMLmb1PTDis0F0+2V1IYtDS4vGQ89D+2+hViEelki40IIhsJdd31VVjkLr/5BHgwOEFnmTXtHbhMLvOPckPG9ajej2geRBEWBn1c5No0+vS2VgjoxFT3ZHbPwfJb8c2sZs688QSLvIP80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRX1vMOS; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705927514; x=1737463514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4w6SYJOD8WUweh7Ifjkrs4t5g9RxUqVq8XYjkZRk7Xw=;
  b=XRX1vMOS9jwLMaeqBuiJbGZbUzxhho1bRrJbYNG7oNgrjF2XEFjberEE
   b4hpa/deUYyhqHAZc1wMbVY+K224mR6HqoT8YdrGAPTGdnWb2aLfDcguc
   Fl1XQa9W+9gKZX3QJX8hIJPaUjPGRRfH+jswG/BSxolEXzhhfo/6eCk/j
   ciQpU8R1hCDFQoH7mpAjtoXDx3KcWYxG+kvhNNiqYOdBKd8+Xkvb6j9EL
   8f/ecNA53fgVYADLIyIhRYFaXE3iWuLkTmplWnP2/g4mAxj1IJX0LkE1X
   +2nfBh9QM6hggqccfcSj8vougv+/tWQ7d679zsD9GhG0j7sVDRqHHJCJ4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="400844024"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="400844024"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1197654"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 04:45:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 04:45:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 04:45:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 04:45:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 04:45:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3U3P4gkHrkzZ1+PjmU87qQCp/X/lOLHPSM7kMPAE7Mn3bSo2ACComRXBDy7QPmXonzQDAqyIUVbyFz1sbB6ZTYeLPOlI7TLqZK6Bh5ezSbieMrw+BMczkdLvUlxDMYZeWzPycHIZcfpKHrriZdEh8B097bbhnBIYmQmqHXRevcoINuVS0WGcGifu9AGR7V1hmkRdtb9LRowLDlHCienES9KhIxf2XVyH0vVrt3pXqOJIsRIPIw2GC7zQIbDCxKoxhOqk1GUNMPeGRz6/J5mxfbSqsKwCkYVhvFWO3M8nvaN9WtiNwn0Ce1IO1UMgwTq/BK+mtbT3zly8PcftIDOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoYMi7C58MTWpjZHHz6CDo498Fu1h803HyBF2d9ZDq4=;
 b=VOkNrZYae5jT+VYfVIHrIVMsUkHflsEIe1TK/2S3UCbpJ+Zk7lpqwEOE27zV+6khUJWFJ2E8Y8ERS9KN1NStfqUOtguRm3oibHRak1juOsnnsKmZnIxaq8nPEjf79cRmJdXnA1a3DynXnsc946WA7y6zl6WH4fF3APdR4g2NuaIOq5C4biUJTzYwAr2lodjwiuh0O65tyLtbQJ3ye8VDeGT3IntYgDMKk1rmNVu2ysC0FaXQIq4QqzTGcHv34vpGOweOR/j5iRnLwmX0KhCwqJWxGI0DGRLmx7y22XSHZGHwzk85Mq2pTRMV2zUZM438UMlq+e+5wGtTgdXxKrzE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 12:45:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 12:45:09 +0000
Message-ID: <bf62bc68-c87b-473c-b0fb-9dd0561bdc64@intel.com>
Date: Mon, 22 Jan 2024 13:43:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next] ethtool: add support for setting TCP data
 split
To: Michal Kubecek <mkubecek@suse.cz>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
References: <20240109155530.9661-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240109155530.9661-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cc1dc7-c6eb-45b2-e1a0-08dc1b47f79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIFUj8y3DmzvDuEnmNUT4+ZUVEJPurUNTgHU9mVmihictKkWf/I4G6MGrN4kTPHbf8osJdwsdLHhuSYPusp3D+q1VJreCXWWQqEACStlqnQiHwWk7Y5AYKTvMpBT4JzvUiTMrjQg92huAaYmXNxryICsnfDC+muZkHzDGlTkHMYfsYbmK45gNotJsbS9rIgBV7P4ZmOqOZCmDEv3ohjZ7ew7niJ4OOdSDrUKu7hcF5i7ENRTBY+YvjeSwQody/6hObcEU2JyICaT2+MbNfRIbDcb7hE/3tPEn9GfPhGSr9a9MKzKwaSt0Ok5yfq7IH+mKT3lgmWyrjDz5XrMvWwbbNp4syJlkJ37gqB0tJB0XgiD6pqiB/izT08NIs4FLf1M274i2yjxsiwGER5bybOWIx6e34JldjO42THvuFCJ6Bp/gBjZPk/Ny6Hp1y4SSzVcYpGkIXxI4N6B82PyRrJfTSrIeqhlZDZw9A2S0Qe4RXZTRkirT1PQNcqCraTZiJpXz6LC0s5FBfqeNwSm6R+mTh8gDwvV6jS7VFOPVL11zjOtHmyaYYrGjEXwclNPlOp80dgHMaSMvp5dEbssPWx6vYQlnJFwcsOSEKEtoMGdFkjWKCqcAc0N4KcQa7oE2m10I56ezNI5cgJmfD1WXtNWqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(8676002)(8936002)(4326008)(5660300002)(54906003)(86362001)(66476007)(6486002)(31696002)(4744005)(316002)(66946007)(66556008)(2616005)(36756003)(6512007)(82960400001)(38100700002)(6916009)(6506007)(478600001)(6666004)(41300700001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0lkUEE0LzZ4WUNoamswMXFaVGN1WGtMKzNVc0czYk5scDFJckR6eERSSUhD?=
 =?utf-8?B?a0x4V2lKV09DQWNya3VFQVpyak1xRU1ZeVNuTjdhUExoZkhzVStaWUNXRzNl?=
 =?utf-8?B?NGp6VEkxdWNwNWs4eEpMWjhCZktoeHhIQytqT2s5SGcyTkJCRWo2cFFzWFNt?=
 =?utf-8?B?a1lyM0VjemZUMFhGUEZ4aE1tcXEwZkpMSnBWUk1VOW5mbVVua0luRXFwWktJ?=
 =?utf-8?B?T0Q3RVJ4QkNnUXk3UCtOazhjTG5LZVcvd0RlTDBpU011UzhjZ0VDd25LR3NU?=
 =?utf-8?B?MXFQaVlqWk1waStKNEMzOHovN3Q4d3pTMy85d0ZoQmhyU2k4UXlDU0lCV1p6?=
 =?utf-8?B?RjA0ZEYxbGo4NTFzd1dFSW5HS0VoTk1iKzVnNnJSVXBWbVlib1l4aGlINFlD?=
 =?utf-8?B?a1cxM1NLOHRSRlc5NytZdThpMHMrM1dhZkJDd1dxTUdqQm9rSkxiajBScVBK?=
 =?utf-8?B?bnoybitpQmhxTmNBbXBHQUp4SFpDRkJidVM3aGZ4SjRoTTJ1SDJTNElNblhz?=
 =?utf-8?B?VzNETnkvWjNPcTJJdUl0NWpFUHF2WFhvVTVlaXN2UjdWU1ZubEY2QmEzYnhZ?=
 =?utf-8?B?NkoySWFQQnBCN3h3YytNZDgvSjBKMjdVbXl0cExBNXFxcURERWJKV2kzNEph?=
 =?utf-8?B?Q3JFeFlENE5waFgvNXk4M3E3Q0JvSHZrKzl6RlVJWEFEKzZTRm1hMmFWWDFy?=
 =?utf-8?B?dk5uTThDclk1UDEvUUkwK3NSY21FM0FURXQrK0IvbEV6N2RxbHFydStWMUth?=
 =?utf-8?B?Qmx2NUk3ZDNYTHNyVzRKbisvMlljTS9KQVdJcHVLeDJWSi9ZQ0draExzTzVB?=
 =?utf-8?B?eXJnd21MaEhJSG5oeVp3V09WWUdOQkh4RzZpUlI1czZkMUtZcmtmSDZSeCsx?=
 =?utf-8?B?eDFRbEVCTG5MTDRQZEhsWGdOOTBlalIxcU0zOUJuaWpiMVdoOVVUb2RSZm1w?=
 =?utf-8?B?Vm1EWW91T2dpS2NvMVRlaFBIK2JDRmM3aHc5b3lPaE54NVJ6SzZIcGFnNzA0?=
 =?utf-8?B?QlJlelFkZWQ1alkxeDhOeFJJdWxhMkxMOGNIdlNnT3lsN3RuaHRpazZta053?=
 =?utf-8?B?bGxkemJyRDFXSWhNbFAreDV6eGpUK2k5akhraW10WENQWjZNclNhMlh6NWZG?=
 =?utf-8?B?NVdNS0hJYkdTWGhIVlo1UmJwa01jV01DaXAzeWtTYnFIUmJscExYWkt6cGNM?=
 =?utf-8?B?SlllYVhsaEdGc2xGZnQrWXdHUUcrZC9MR0lTa1cxbmtFVEJvcTM3QW5FWGl0?=
 =?utf-8?B?c1NOY0g5VndPalN5UWc2ZG9DYWNPaW9veVdheFFtNGFZaGdNT3o4K2VnOFZT?=
 =?utf-8?B?WHNEcmFpS2JUejZEdTltMEdrZ2N4SlZsOGFQR0tYUzBFVHBEdElMaHZFc0JL?=
 =?utf-8?B?THhFbU1vWUNGRS9HQS9kNjNLek9iRFhaMjhjQ1JKUUxjTVlvMWp1cU1jS1pt?=
 =?utf-8?B?NWZ4SllFaGJUNWo3L3A0NHBNZnJydFRDY3JqU3B6T0d6eElsZm9iTnBaTWc2?=
 =?utf-8?B?NklHZUxtTUVsbDdIZGl6cVRwUkk5L0YxVG5PaXRoNGo3REY3eTBtbFYwelpY?=
 =?utf-8?B?QWVSRHMzOWJkOVNqZEdyVlJEUXpTWUNrRGN2Y05ZVUFFeldJazVtUFVBT2RT?=
 =?utf-8?B?NEZqa21NNVZ1M29Wb3NBTUVwRjN4ejBoSnY3bmd0ZEM0cVgrOS9SeEFBcnJm?=
 =?utf-8?B?UUNFcXU0NE5ISjBoRlFBSHFta2FWSzBwQXJsYkJJa1NKaWtvMWFFTnJPdmNW?=
 =?utf-8?B?bkhJdW05bkNFai9IdU45VUdHQ1pSaGhXNlE4YTNEVHZNcHkwSWxqZ1JYaUlL?=
 =?utf-8?B?OVN0OE1wckNHSE4wNDBaN1BHLzNlSEtEMjQ5OUFSWjRSUWlRWkNNV0lKQnlE?=
 =?utf-8?B?N3YrRWR5S1lKR25hSkZwSFh5T0p0ZDhjN2VSOTZlZDNVM2hDM0J6R3E4Y2Rh?=
 =?utf-8?B?eXcvMjJXWTVTcFBzSVNQRGNOZTRlZENkMVBhSHFsOW5XRDFMQUNqOEhkYkhz?=
 =?utf-8?B?RW5MY1liTHNlZ2txOExWaU1nV09iQ3VjZHBhQlZnRnBZb0c5TzRDVnRzeUJP?=
 =?utf-8?B?S0Q3UGluWnBadzBKQnpleTBGZkwwYVFMNkFjckpZT3V2WUtGcThSWmdVQ09v?=
 =?utf-8?B?MTQ4VjcwM2tLY0hhMXVKSjZDR1JGK1NqY2FmaUR4ZFVpRGRIMEdJVURtUTFN?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cc1dc7-c6eb-45b2-e1a0-08dc1b47f79c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:45:09.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krXmAGS3VuVJTHYTsbf63BpgsOGAL68YlbuXfZem4uzKMES0bhg/SYKhVCo/s6VRcDQqEyXDBlMk1X6fS8ClV2PdQFItHNvSrAP4HvLjIPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Tue, 9 Jan 2024 16:55:30 +0100

> Add support for controlling header split (aka TCP data split) feature,
> backed by kernel commit 50d73710715d ("ethtool: add SET for
> TCP_DATA_SPLIT ringparam"). Command format:
> 
> ethtool -G|--set-ring devname tcp-data-split [ auto|on|off ]
> 
> "auto" is defined solely by device's driver.

Ping?

Thanks,
Olek

