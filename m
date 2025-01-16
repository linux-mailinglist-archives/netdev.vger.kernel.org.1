Return-Path: <netdev+bounces-158779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934CA1337E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFDB166CC8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C845027;
	Thu, 16 Jan 2025 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMks4Q9p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814F33DB;
	Thu, 16 Jan 2025 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010877; cv=fail; b=OV9Mw+6uGjjq00MqJOV1ORXpsw4v8/dzU04lLdzoLauviTebqKn6VU6LRHjhRGPnpq+jKfOowAVMhyABCXOVxC8llOrhGVflKafcxvlkVl90GFDtrpPcxZbjDVh97fblV4jzXP6txZn0qJFPdZTPH9PZWXrNNW+1APGL2hakvuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010877; c=relaxed/simple;
	bh=u5GysMEZ/O3heRbXkdd1Taxhyljj7prcPc1B4AyCQXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cH9P9IUIASSznx7jQPi9cN2HQgBV6kVIl4UbsuAMHnaCl7hylK8HyaFWBao8KEngw3voZreS1evxdXW93nqY70K+V9StD+EnOwg3x23Z5uRWu9Od+nmWsB1BlOeXci0HXDgzt6YBUHQu7QFM32qUUg3XidITnrwt7engB90kuAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMks4Q9p; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737010876; x=1768546876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u5GysMEZ/O3heRbXkdd1Taxhyljj7prcPc1B4AyCQXM=;
  b=RMks4Q9pskdyCzS9GIWhAapNKCBJcddZTsUp0jkzyhADKZguB4Fxow2n
   aB/dwkjiOyN5/LRisrKREXxRYpNdCs6IHhrOpQACV/vRX38IEYIE0xyvb
   /JNRPRGvfRrDpsfxuz3/rw7z/o2uhR7fKCvpFDCshlGY7IHrdnxOU4Rqz
   pQoQOcWmNDcrW+OuWC5sg6LYLAdiAAUXDnsJMAnOH2ScNkNJVCOjf8TRT
   Ii1oLF8fdz8741+G1B6A/HeKSAmP8oJfxSmAz6JvN8J0fqAm6VtNvqKmZ
   NjhCJKgYDt1qQW8cq8kJ7E1anGAoN0Na30gHOJd8AF1y7OZBYXptCoYUs
   g==;
X-CSE-ConnectionGUID: defTtEolSJi/TamvnHBtwg==
X-CSE-MsgGUID: QghvsKn5SLCDsuJDXKkRZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48383032"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="48383032"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 23:01:15 -0800
X-CSE-ConnectionGUID: GyS//CJIQUe4hdVCVAcj1g==
X-CSE-MsgGUID: nzSrtL5uTNSNqlmaUlBcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110492457"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 23:01:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 23:01:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 23:01:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 23:01:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F60SmO0ZU8PgtuSPj+tjMMPDwcaVFAC/VrKizqP8532Fp0xR9zdrUaIVM1a9mu5OaVi5shGbFI+SfSbK6Ljw5buWbG+CiE014JKfXITSc/7NW8K2C+IJPTFNbPniEl+KIF8snfd2otcB1wOVo3B4aVhCh7WIvIBLSVexl70xrbkjiGF0SSjLBJCNKJF2Mt16XyVEeY3prI5sijsDrVrhSKoxVI2LVwaGodqY21YKfTyyDn0tMa2CmiXMAT43Qmf2msyAELClFtWPhAIz/ig6Tv0IdUPKhV+2Pg0qXHZMRy01Uj6m8RjfHognJ+H1kVNgy+bYCHdVK4TBp/oBZeNBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5GysMEZ/O3heRbXkdd1Taxhyljj7prcPc1B4AyCQXM=;
 b=Yx3r2up9asWg4H+8s++TcO1u+nvW9Z+UWXse9Ets4ZYyFCwhx/V6inTUofw5R1b19/MIoco8lze8EAw/9miTa3J75WGaItGRZT2Ap6F5n7g4WUFA8bd43NdzXkh8JHNoaInMakclm5b17B68uH6lZ+lOrBcBPpbQ/vCwTrw4XOnueuJbW9voaj4hoNibJvGxjHAk9HQkQBTkBnfXWCsnh2cJkmzqRtk7hd0vtwCqPfVuJCWeH/VENbLtTTy7lkJ8Y7+79SC/Rii1gdOH6cTh6MbXN956ALhMAPnEsb0cGnvOfLU4ypxmbSYXTxPHHwt+SX+Dvc875B8Frg1RObde+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 07:00:32 +0000
Received: from SA1PR11MB5827.namprd11.prod.outlook.com
 ([fe80::93b4:3525:963:962a]) by SA1PR11MB5827.namprd11.prod.outlook.com
 ([fe80::93b4:3525:963:962a%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 07:00:32 +0000
From: "Choong, Chwee Lin" <chwee.lin.choong@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/1] net: ethtool: mm: Allow Verify Enabled before Tx
 Enabled
Thread-Topic: [PATCH net 1/1] net: ethtool: mm: Allow Verify Enabled before Tx
 Enabled
Thread-Index: AQHbZzHHpNhh1UITb0yrY2b3soG/qLMXluqAgAFZhcA=
Date: Thu, 16 Jan 2025 07:00:32 +0000
Message-ID: <SA1PR11MB5827C20FB9D7E7DE38148E26DA1A2@SA1PR11MB5827.namprd11.prod.outlook.com>
References: <20250115065933.17357-1-chwee.lin.choong@intel.com>
 <20250115174204.00007478@gmail.com> <20250115094839.xjudiq2japopdqza@skbuf>
In-Reply-To: <20250115094839.xjudiq2japopdqza@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5827:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: cee19e9c-0863-4544-b625-08dd35fb7800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SkhHOU9EMVB4U2g5aElnbWJXUmtSRng3Q2h4b0VIMEtJRWloeERBZkYyRlp5?=
 =?utf-8?B?R3JycmErR2pqakFVQXVGNi9CR3dZYkRFeXZOK0JpWTVXZWhpSGZ3czArL1FL?=
 =?utf-8?B?M3ZyT0ZRb0EySUx0bWM5SXhFOTFTdGVnd3gwM3YwZHE2NERPZHlKWXo5YmZi?=
 =?utf-8?B?Qkh6dHIxQ2wxZEF1eEdzdE95dzdmRzlsQVBFS0U5V21VYnVWWEZ0d1FUd3E3?=
 =?utf-8?B?S2ptNlRMN0dNcTFJNEc1aVoyWW5HcTJ5enlzNUsrVk4zS2o1eGlVT083UVdV?=
 =?utf-8?B?eG9wL2dLeVNldXpqTGNQS0JXVisvdHJGNDlFYWtXRnFjQ3dnUHNGK0QwaXls?=
 =?utf-8?B?VWUvSndkazdhOWNUcUwvRUJZYzhVRG9WMEJQQzJKbVNtWURHNjlNU2FXYmp2?=
 =?utf-8?B?b0VDN1B1Q2FHd1p2M1FZSXlSOTF2OFNXZ2h6dzBzdzBsUmdBdWZJV0NDOWZh?=
 =?utf-8?B?Rjh4ZDNRVEsreVZidTA3dkYzcWNIMER1RFFIZy9vbzBTTHREbFlGZzVXYWEw?=
 =?utf-8?B?eDMyZUNwK25UWmxmR1lDZnlISUdEZjZWSXh2VFRwUnJjOS85c3hnQ1R0ZWV2?=
 =?utf-8?B?WDRTYUVJUmN2TWIzV2lDeW0vYXliWk4vMG9QN29lM3Z6NTVraUlOMXk2Rm5M?=
 =?utf-8?B?N284VzFpZy8yNGl4SFI4TVdjNlVMWEVOWFJMZElna3FnSkVidk81WU1TQVpS?=
 =?utf-8?B?OW12dzBTZHluQnQ5RGRxSUdhZC9pOWlvUTkzcnpMdTFxYlFBbDhkcHFjVnhx?=
 =?utf-8?B?YVhXV2ZyVFFKb0VaWW1YTXF4Ym5MdDRIVEkvZ1E4cGRNMzQzZG56Y3lnQVht?=
 =?utf-8?B?QktxNnNOdWtnVnp3MjEvYXhyeEJLd2o3REkxTFFpdXBWbFBZZFVIdXhNdHRF?=
 =?utf-8?B?MzBwVWN3K1ZoRStKbGVDSUpzamQ1VUpZQWRkb0lKMUszOU5LMXhrM2lVTmFi?=
 =?utf-8?B?a2ZHVVRaNDBwYU9Xd0NuWjREUzlqa2p4SHNyS1I5K1JhM2RpbzBzV2drMTdP?=
 =?utf-8?B?S3dTeWRENGdjbnRFcXhCQjgxYlhoeG1ESDA4d2wzcWJyOEVkMlVPWm1xUmZx?=
 =?utf-8?B?M1paVkhoZDNVUTY1UkZZdndYQmtIYUFnOSsvUGFEY3V1dEE3NnhGL1pxRDkr?=
 =?utf-8?B?TEI0YXBJOHFocDdhM09xcElCUDlOZGlhUnhKRHNKYVpSb3c2cWxoZzRMN1Vk?=
 =?utf-8?B?a0tCeFRQSU1ZSStXby9YclRBaXV2enNQcVZtTVY5V3NJUkg3aCtDa2twYlY2?=
 =?utf-8?B?cUs5L1ZTTisrSSsvempvNDVwYS9wTUNmOWIvbHdoUlhCSlhkeFAwN3RPQm1B?=
 =?utf-8?B?YzkwQnZDbjl2aFZTL2tBQnVkRG1kUDg4YWJEMDdod1A3V3hjL1YvWkd3WElD?=
 =?utf-8?B?ci8vKzdXYllRZmEydnhHZlF4Z2w3cDNXQWpRN1oxdWhSd3BGL3MveDUyUWdi?=
 =?utf-8?B?Q1B0eVU1Qm9pd05MWHRSYVpGeEhnUjRkczB5bGVsTHU2V0YrcnFxVkVPbTRN?=
 =?utf-8?B?YWdpMVRSRnFBWU5KbktTN0JTK05SVnpPS2tZMFk4cmIvd2VWeXBxMXZzSURO?=
 =?utf-8?B?TERrZnM2OG9WZFpjYmpNdVdpYkhPMG9mODFIc1VtVjZZNWJkdWdtTkl2RmE2?=
 =?utf-8?B?YlpqeU42MTdzaGdUUnF3QTlPeWVTeFU1a2hxNW90TVp1c0tkZExWTWF2YU0r?=
 =?utf-8?B?UjEvSHlXYkRiQlh2N1pQbWNjamVZek8rSDMreVY4WEFvOVFnSnNIUnBFSTU1?=
 =?utf-8?B?T0p2Y3d3b0xIWHhQZ2ZWV3lLejBKZ1pjdGJmQm5mOWJQamV6MjZxaGR0b3BZ?=
 =?utf-8?B?OUhuTFBFWWlsZkxWVzdweDdHYTlVeWtZcFgvayttTlUrQmtjd0VtMXFCV0xF?=
 =?utf-8?B?Q3NPLzQ2YTZGWjJtc2ZGRHE0MXZsbTZuVzI3djRPSGZXVFhhZlk3RU1BWnV3?=
 =?utf-8?Q?1cwHbN2F6I4iHmjjUbO+DyoibnKeLk6h?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5827.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEZlWGw2cmVIZ0dGNkNFcG1NdVQ2QWFKcElSeU8vV3M1VUREbFRHeXBZWU5s?=
 =?utf-8?B?Wmt5L1lNRGd1WE8rZHBFQUlZRldCZVoydit4b1hxZkNDU2JXM1dJRjlybzIx?=
 =?utf-8?B?Qm9kVnRzZjhtVG1mUHlTdjFCeloxWmJ2RnJMNmVYQXdhUDdueDR2em0zZGNw?=
 =?utf-8?B?b21hWnM3L3ZKZHdlQ0ttaUpxcDlxd2dvbEhaYnNQRXRTeHc2VjYxampBVi9G?=
 =?utf-8?B?U2MydUlTcWw2cDEvZEx3alBGc1g5WDYwd0xaSlRGaXhWV3krVDdUMENSYlZV?=
 =?utf-8?B?TVlGbVNNKy9pbU9kTjBaYmxCaEVLMVNsczVUL3dyanloYlFKUXhLRTV5Nk5R?=
 =?utf-8?B?Q1RJNDFyZ1R1azJLRTJJT3lBSVYxcGZvakU2ZVUzd2JzODZtR3ZwMFFGZkQ1?=
 =?utf-8?B?R1MvMGZUd3JLcmZQYlRRYjZTdnFqUG5tbnViVHBUR2tvdk1lTDJzMWtzcFg4?=
 =?utf-8?B?dzlEZEtZY0Fkd2g3K2hPS2U2V2hXeG42SXJXVWpkUlMrUUxKczB1RWI5SjBQ?=
 =?utf-8?B?RXhrd0xCS0pCeG0wSUtDcWtEMCtSbzk3ZVhIdkpEUU9BblZSUExCR0E4OFE1?=
 =?utf-8?B?T1ZMWU1qRzIxSkgvVll0YlRaa0ZORTRiSGczdG1iS2hFcVU0RW5qNkJFV2ZT?=
 =?utf-8?B?R3QzSjVwR2ZUR2FIczhOSGgweEllanpLaDBQNk1RY3dsdkZnZW5ybnRXSmVi?=
 =?utf-8?B?eUxqRWg5cU5jbHlPS3VYSlJiWXU0S1ZXODlhcVdsa3FHaG90a21mYWxiQ0FU?=
 =?utf-8?B?SituUnhScXZjWnR0Y1VLTXVsK1A1ejhUUG51bHFJbUNTQVh1NVJWSVhQUW9h?=
 =?utf-8?B?dHg0OVhyUjl2SDRkQ295NGo3YXU2UGs3VTdIdkxBeFBMZWk4d1QvaUN5cmRj?=
 =?utf-8?B?a3g3QWtVZXpUM0FqNFRpbW1vK1BMWUV4K0RIZDRFVjJYUjlXc0JqYXBwd2Vx?=
 =?utf-8?B?VmhDVWZJTWpaWHh3UC9YTmN5bFpZbXZxME9FZCtpa2IzZkFkdzlOTWo4Vzcz?=
 =?utf-8?B?d1h2T3AwNzhqQ1h6amRFbEs0RW1TU2tkck9qMVBMWmxjVVZjeXlFN3MyTDNX?=
 =?utf-8?B?OUdaL0ZmdllMZk1vbHZ6NStYWHg5SUd3V21DVXNYRTBoYndBdlFobitTSHYv?=
 =?utf-8?B?T3d2WGRSMVhYNXlqVG53U2t2dVNzOG5RdFRabnJFOGR5bmNyYmhlSVUzZEVy?=
 =?utf-8?B?c0xQWFdQSjQwN0M3eXZFeGN2dXdNdnFCWUExRnkzMlF5ejUrOTR1SXhQaVJX?=
 =?utf-8?B?eHpXSmVCVjFtVnJCaW5mQmgzSk9ISzRmZ1cyOE5iMkI4VExJZmY3Zk1Ed25t?=
 =?utf-8?B?eUEyNUpQck91cnNaTi9tL3hyMVZFbHV1Vnk0bmlndkRZVjRnN2ZHTVZrK2l2?=
 =?utf-8?B?YU02c0poQzdxZGY2OVkrZkNGUW02UWlBVnVhQWJWMVNhR21UKytmRWtMQm4v?=
 =?utf-8?B?SmJnanJEZy9hVXRLZTZ0T2lVWndLRmZLbHI0QjhUd2dZZFVYb0tSNE5lQ1Vo?=
 =?utf-8?B?MlVVL0tNSWNUZ3JJUGFOY0dsVkFIY0pLdGhWL1JkSXNjckIrTCsrcWZ4WUh1?=
 =?utf-8?B?TnU0eDNQMGROUUtER1A3NU9iOFZCeUExcko2a1IzTDRGcXpUWll1eER4UXZh?=
 =?utf-8?B?emwxZXhsTG5WMG11VmtSS0lKaDhaZUlabU5vOU9UN2YwaStiY0FBTnRDcjUv?=
 =?utf-8?B?eVpzMEN0eHZZaVp3bDB1SkxVQmtZTnpCcklhTTlTRldRU015NThzczVrUitG?=
 =?utf-8?B?NEZLWFZ0ekY4eDZ3b3VkQW9ZOVV2K0JxTGljMVdYR2xYK1MvV0hhSzZCeEF3?=
 =?utf-8?B?K0hhaVNSTTh4NWd0NlQ2NUo5SVVabERLTjBQUmVpTEJ1NWtKUVAyVWc0OHBV?=
 =?utf-8?B?emZlQTZPWDNGL05kS2xqYXhLeWFBRzhmSHpaT0dESC9tY1p4Vjdra2RYdWpG?=
 =?utf-8?B?czlzS3ViM1NkeStyY1NLYzBYdkxycmJISGJEenNMandPNVc2NnZYMVpxalhl?=
 =?utf-8?B?SW9TbjdsaFp3MUxEbVpwblpQNEljREZyWFNQbUExR1RQaytZbnBGeCtIQ2lw?=
 =?utf-8?B?YzgyMWRqWENiWkhsS2tvOTdpc2JNZVBCeDUvamx2NzdxN0ZYN1lUOGtDc3hO?=
 =?utf-8?B?SUplMDd5am5mYlQrSUw3Y3lReDVCTWlVUG95OW93QUZzVFRKYkJndVdxWG9L?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5827.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee19e9c-0863-4544-b625-08dd35fb7800
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 07:00:32.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+gIOvgkQUFHc14mh6hDJ0qJxyPHt220X7OadBG1I/eH/gRXeAWeDkAKRXB/nLnLZyuQLqeYGBS/iP8KOFe6F23Kv9xbrUKyfUz2B8bUyXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

DQpPbiBXZWRuZXNkYXksIEphbnVhcnkgMTUsIDIwMjUgNTo0OSBQTSwgVmxhZGltaXIgT2x0ZWFu
IDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4gd3JvdGU6DQo+VGhhbmtzIGZvciBjb3B5aW5nIG1l
LCBGdXJvbmcuDQoNCkhpIFZsYWRpbWlyLA0KDQo+T24gV2VkLCBKYW4gMTUsIDIwMjUgYXQgMDU6
NDI6MDRQTSArMDgwMCwgRnVyb25nIFh1IHdyb3RlOg0KPj4gT24gV2VkLCAxNSBKYW4gMjAyNSAx
NDo1OTozMSArMDgwMCwgQ2h3ZWUtTGluIENob29uZw0KPjxjaHdlZS5saW4uY2hvb25nQGludGVs
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gPiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBldGh0
b29sIC0tc2V0LW1tIHJlc3RyaWN0cyBlbmFibGluZw0KPj4gPiB0aGUgInZlcmlmeV9lbmFibGVk
IiBmbGFnIHVubGVzcyBUeCBwcmVlbXB0aW9uDQo+PiA+ICh0eF9lbmFibGVkKSBpcyBhbHJlYWR5
IGVuYWJsZWQuIEJ5IGRlZmF1bHQsIHZlcmlmaWNhdGlvbiBpcw0KPj4gPiBkaXNhYmxlZCwgYW5k
IGVuYWJsaW5nIFR4IHByZWVtcHRpb24gaW1tZWRpYXRlbHkgYWN0aXZhdGVzDQo+PiA+IHByZWVt
cHRpb24uDQo+PiA+DQo+PiA+IFdoZW4gdmVyaWZpY2F0aW9uIGlzIGludGVuZGVkLCB1c2VycyBj
YW4gb25seSBlbmFibGUgdmVyaWZpY2F0aW9uDQo+PiA+IGFmdGVyIGVuYWJsaW5nIHR4X2VuYWJs
ZWQsIHdoaWNoIHRlbXBvcmFyaWx5IGRlYWN0aXZhdGVzIHByZWVtcHRpb24NCj4+ID4gdW50aWwg
dmVyaWZpY2F0aW9uIGNvbXBsZXRlcy4gVGhpcyBjcmVhdGVzIGFuIGluY29uc2lzdGVudCBhbmQN
Cj4+ID4gcmVzdHJpY3RpdmUgd29ya2Zsb3cuDQo+DQo+V2hlcmUgdGhlIHByZW1pc2Ugb2YgdGhl
IHBhdGNoIGlzIHdyb25nIGlzIGhlcmUuIFVzZXJzIGRvbid0IGhhdmUgdG8gZW5hYmxlDQo+dmVy
aWZpY2F0aW9uIF9hZnRlcl8gZW5hYmxpbmcgVFguIFRoZXkgY2FuIGFsc28gZW5hYmxlIHZlcmlm
aWNhdGlvbiBfYXQgdGhlIHNhbWUNCj50aW1lXyBhcyBUWCwgYWthIHdpdGhpbiB0aGUgc2FtZSBu
ZXRsaW5rIG1lc3NhZ2UuIFRoZXkganVzdCBjYW4ndCBlbmFibGUgVFgNCj52ZXJpZmljYXRpb24g
d2hpbGUgVFggaW4gZ2VuZXJhbCBpcyBkaXNhYmxlZC4gSXQganVzdCBkb2Vzbid0IG1ha2Ugc2Vu
c2UuDQo+DQpUaGUgaW50ZW50IG9mIHRoaXMgcGF0Y2ggaXMgdGllZCB0byB0aGUgZWFybGllciBk
aXNjdXNzaW9uIGFib3V0IGF2b2lkaW5nIExMRFAgb3BlcmF0aW9ucyANCnRoYXQgZm9yY2VmdWxs
eSBlbmFibGUgdmVyaWZpY2F0aW9uIHdoZW5ldmVyIHByZWVtcHRpb24gc3VwcG9ydCBpcyBhZHZl
cnRpc2VkIGJ5IHRoZSBsaW5rIHBhcnRuZXIuDQoNClNpbmNlIHdlIGFyZSBjdXJyZW50bHkgc2Vl
a2luZyBjbGFyaWZpY2F0aW9uIGZyb20gQXZudSBvbiB0aGVpciB0ZXN0IHJlcXVpcmVtZW50cyBy
ZWdhcmRpbmcgDQpzY2VuYXJpb3Mgd2l0aCBMTERQICsgdmVyaWZpY2F0aW9uIGRpc2FibGVkLCBJ
4oCZbGwgcHJvdmlkZSBhbiB1cGRhdGUgb25jZSB3ZSBoZWFyIGJhY2sgZnJvbSBBdm51Lg0KDQo+
PiA+IFRoaXMgcGF0Y2ggbW9kaWZpZXMgZXRodG9vbCAtLXNldC1tbSB0byBhbGxvdyB1c2VycyB0
byBwcmUtZW5hYmxlDQo+PiA+IHZlcmlmaWNhdGlvbiBsb2NhbGx5IHVzaW5nIGV0aHRvb2wgYmVm
b3JlIFR4IHByZWVtcHRpb24gaXMgZW5hYmxlZA0KPj4gPiB2aWEgZXRodG9vbCBvciBuZWdvdGlh
dGVkIHRocm91Z2ggTExEUCB3aXRoIGEgbGluayBwYXJ0bmVyLg0KPj4gPg0KPj4gPiBDdXJyZW50
IFdvcmtmbG93Og0KPj4gPiAxLiBFbmFibGUgcG1hY19lbmFibGVkIOKGkiBQcmVlbXB0aW9uIHN1
cHBvcnRlZCAyLiBFbmFibGUgdHhfZW5hYmxlZCDihpINCj4+ID4gUHJlZW1wdGlvbiBUeCBlbmFi
bGVkIDMuIHZlcmlmeV9lbmFibGVkIGRlZmF1bHRzIHRvIG9mZiDihpIgUHJlZW1wdGlvbg0KPj4g
PiBhY3RpdmUgNC4gRW5hYmxlIHZlcmlmeV9lbmFibGVkIOKGkiBQcmVlbXB0aW9uIGRlYWN0aXZh
dGVzIOKGkg0KPj4gPiBWZXJpZmljYXRpb24gc3RhcnRzDQo+PiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICDihpIgVmVyaWZpY2F0aW9uIHN1Y2Nlc3Mg4oaSIFByZWVtcHRpb24gYWN0aXZlLg0K
Pj4gPg0KPj4gPiBQcm9wb3NlZCBXb3JrZmxvdzoNCj4+ID4gMS4gRW5hYmxlIHBtYWNfZW5hYmxl
ZCDihpIgUHJlZW1wdGlvbiBzdXBwb3J0ZWQgMi4gRW5hYmxlDQo+PiA+IHZlcmlmeV9lbmFibGVk
IOKGkiBQcmVlbXB0aW9uIHN1cHBvcnRlZCBhbmQgVmVyaWZ5IGVuYWJsZWQgMy4gRW5hYmxlDQo+
PiA+IHR4X2VuYWJsZWQg4oaSIFByZWVtcHRpb24gVHggZW5hYmxlZCDihpIgVmVyaWZpY2F0aW9u
IHN0YXJ0cw0KPj4gPiAgICAgICAgICAgICAgICAgICAgICDihpIgVmVyaWZpY2F0aW9uIHN1Y2Nl
c3Mg4oaSIFByZWVtcHRpb24gYWN0aXZlLg0KPj4gPg0KPj4NCj4+IE1heWJlIHlvdSBtaXN1bmRl
cnN0YW5kIHRoZSBwYXJhbWV0ZXJzIG9mIGV0aHRvb2wgLS1zZXQtbW0uDQo+Pg0KPj4gdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvZXRodG9vbF9tbS5zaCB3aWxsIGhlbHAg
eW91IDopDQo+DQo+WWVzLCBzZWUgbWFudWFsX3dpdGhfdmVyaWZpY2F0aW9uKCkgdGhlcmU6DQo+
DQo+ZXRodG9vbCAtLXNldC1tbSAkdHggdmVyaWZ5LWVuYWJsZWQgb24gdHgtZW5hYmxlZCBvbg0K
DQpUaGFua3MsDQpDTA0K

