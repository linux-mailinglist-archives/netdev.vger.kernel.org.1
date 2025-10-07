Return-Path: <netdev+bounces-228041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01578BBFD4A
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 02:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBBD3B9017
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 00:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237E17BA6;
	Tue,  7 Oct 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVlkNNdu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29234BA44;
	Tue,  7 Oct 2025 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795657; cv=fail; b=di393si0ZPOSef4FJDRFBMB66y4GRCHZMioj1SAGE/Xzmx6kbfy5tJQ1ZXRQ1EGrsovxaay0+Yys31+2aLICOCbJYE0ltc5Pe4B9xVHp4/PzlNOUMWSsx+jPChS2KzTqGFL/tw9rV93JMcZlbMZERn2uWpyAjxfwjO9LSjOzXOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795657; c=relaxed/simple;
	bh=DeQXu9NWEl+DuFZBUAqG1D8PAvtSjvrvHyUeWUDPWzg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVzp1bmEt0bDx9gEtoMKs0eVshhd2nYeDFCJ4jrG2CA31pi9WpZ45n62+kihpviVpwJa/3MBdP0qr+MR+5yQRkK/3MdK0KmCWJ1NJcf4Ns6XBQVKGUP+lQG7pfKbqaJ/afnHSG/SqHQj3F3AL7VVvQYzSB7AwwGsCi5C2Fcw+78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVlkNNdu; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759795656; x=1791331656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DeQXu9NWEl+DuFZBUAqG1D8PAvtSjvrvHyUeWUDPWzg=;
  b=nVlkNNduOLRI02pyy9q5uj0hsatxVGiLIDLwL6DDUwePtyLmdqWTDLnE
   BSHdSDxz0FIF2xUIFoBi7N7VAM+0hTQ+HIaQVoC7MNV8DKwIdsvhTesSC
   8e76ePlfxgVdp26Vc6lR/s2LITwz0lPblbXy5Ozwz9CQMJJ1iveBvF0MF
   MQl4Up0+yuWpwJ7iAcsi+zRX/LN3t1u64miZItkhDFnSiWL/ntxZFQqWv
   MKw67d4D/b4zp1t44cXFGn9O0eQ/PsBrlU01UMotHjuFEpMDo0cCsaawc
   oWitDu85kbemNcsF2ck6IPsOP9K1L2zTwrjUhQbViS7dYJiUyVJ2tqhwD
   w==;
X-CSE-ConnectionGUID: /8rKTO0lTZiPY7/+IzNTYA==
X-CSE-MsgGUID: /tToR20mTd+Ih+I1/ZH4zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61882406"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61882406"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 17:07:35 -0700
X-CSE-ConnectionGUID: /oNOqD3bRuy2x2682SUt5w==
X-CSE-MsgGUID: 1wMT7XmMQTarz3lk3rSBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="179939184"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 17:07:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 17:07:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 17:07:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 17:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd8CIPuNQRc80RJkfsh9OPLe3hWXErUrXN2NpY5JbI2k7kgrlLJ/XhITsWYwBDVoA+DQizSI3PzqNw8firAFXw9eQ9EZD6wvvKgXjGngDzgbOrPqQWyD0is0tycsGMRFw4Ynv8IA1/IATDTSltOTx2QAQ39rAXTbBEM6iH36oezORGIkEigL5RUI3PGl/vJBWDlC++BdPFDjA/VbmgAY3H1socopK67x5IX80hwFqkaPubCeI2zpaGt0kToovxO4cPHKUw48zpMqr+3geojLqTj5zMIZo6UvB7EcMsUiL1ZJgk3RTHTEYNbGOqJBQdy29UeWL8Dkx/yG8c8cf+6jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+SrwLiFwB8M4W3Sc92a/HYt9510iPqpL1f4U6E8UMw=;
 b=PkaSweKgekl0nFSEhdabOE8PWnK3cOST4PIFB58Aeyt/bvxxEXI01Q6caNLnHRWgBUpvmTfRbhZ5rvwFOO6UTPUDMiYTtHiFSZlTuwryutHZt28vyzGibuiF50NPkzuwiCUsaH1qPkm7Y4bqQRrG1qrEmvUARG3xNC9Ce1K5sXljA5v/lAAxIcXsCXSGUljW6kh1XuV8bhimkw5OsXLz2Z7++5KmEciJQKB3HNUHeNPmyVWRuQOgRELqBNE1SjukQSZb6rnJ87uQpI1Ks7YSdbeDXYao4ypG9QlahpACLDcSAgqLuCtGKDdwopUZEjma2wLIfUnXhVfPPnFzKe61kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 7 Oct
 2025 00:07:28 +0000
Received: from MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::e117:2595:337:e067]) by MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::e117:2595:337:e067%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 00:07:28 +0000
Message-ID: <048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>
Date: Mon, 6 Oct 2025 17:07:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
To: Jakub Kicinski <kuba@kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Willem de Bruijn
	<willemb@google.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "Phani
 Burra" <phani.r.burra@intel.com>, Piotr Kwapulinski
	<piotr.kwapulinski@intel.com>, Simon Horman <horms@kernel.org>, Radoslaw Tyl
	<radoslawx.tyl@intel.com>, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, Anton Nadezhdin
	<anton.nadezhdin@intel.com>, Konstantin Ilichev
	<konstantin.ilichev@intel.com>, Milena Olech <milena.olech@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Joshua Hay
	<joshua.a.hay@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Chittim Madhu <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
 <20251003104332.40581946@kernel.org>
 <4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
 <20251006102659.595825fe@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20251006102659.595825fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To MW3PR11MB4538.namprd11.prod.outlook.com
 (2603:10b6:303:57::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4538:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 457f7af9-9adb-4968-ab0f-08de053580a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzBDVWRVMC96R1dTSjV4SURYNVI0ZThMVjNWY1J2MHlTdXEvdEJFOU9KaXc2?=
 =?utf-8?B?MmJQdnZpaDFLSkhvYzZtdTk3a0ZrMjJjajNVZlpOMkwxWWhxckJmVExIQTZq?=
 =?utf-8?B?eGM1NVpiUWFEcmxzQWp6MGZINmtIcDdXZ0NUdlppZlA4NGdYQ1V0MDRycVky?=
 =?utf-8?B?bnV4d05WSXZ4M2pqNGJPLzRham1FS1NNd3QxV2VFSG1SK0tuTWc2TmwwcThI?=
 =?utf-8?B?TThnTVRsRDBxd2RHUVFsSlFDbGhneDlKUllaRHhlZTN2RGZpTjZ4bUs1NkZp?=
 =?utf-8?B?ZmFLV21UOWhFNkROTS9SVU8rZms4aVl0STVYaXBhWENDaW1OMGZUZndFendj?=
 =?utf-8?B?dWFLeHBXNDRNWm9LaWRmY1ErYlBJUE1SWEcxejVxN0FDUGNyZGovSndJN1FI?=
 =?utf-8?B?RTJERzFxYjBVa3FkcVBEZ1lvaFQ0ZHJ6OWF4bEM3YkNhWXhCRWZ1ZUhWUk5i?=
 =?utf-8?B?T1Z0ZEk5T29yaUdxL0lqSnhKdTVZU2I0M2ZBejFqUGVZWHBMU2VpUlozcy9u?=
 =?utf-8?B?TGNZNlFOSG5ydTRWVG53VnlXdTlmTXNaVVVmV3NvNXBwZmFhUTNFMnB4ZEN0?=
 =?utf-8?B?R1ZCMHY2YW84TFZwME5JeTVUSHN2b0RjbklvVzJNTWdBcXRFaXY5TGNiTEtM?=
 =?utf-8?B?U0hQNjJtdXBLTmtVOUdUd2NXNDY3VVNkVE54WnhDbGJrVVNGTWp4QlFaQW9H?=
 =?utf-8?B?cC9EcVBxRTR5bktla1dwbzFCNUNmeXpQUFRZMC9nT1JXeHZVdEVlUU9BZGh6?=
 =?utf-8?B?UDUwZm16d1VTeSs2Q3JmU0xUdHNlRjRma2pNMWhGaVFnN1VvL1RnVHFtNWlS?=
 =?utf-8?B?d0hCR28xUmhXRHVqS1lwcGVEWldzS2NhSHd4RWpKdUhBRUpDNlpTVnZoZ2Fa?=
 =?utf-8?B?OGFBSklZWGlhMGRzK0hTMnpHV3g4anVxdnJXc3hEa2tJSEZUNFB0OTVnWUF5?=
 =?utf-8?B?NzFFcDVqcHB3Y0Rtb2cvOEpLSWFmTGUvS2FRK2NSU3NNNkxzNTlROGU2U2lD?=
 =?utf-8?B?bHJuandLMnhSQlRsMnB2bXc4d05QUmZ4QjFxZkFMNEZhVUZ5eXNIU3dqcU9s?=
 =?utf-8?B?ZDh5OWphbElPU2trQkVaY3AvaVNXMjkrZVJtbFRob2dYdW5sbEtBZTRSYlNH?=
 =?utf-8?B?UCtYR0FCc3RUbTQxRWdkLzM1eUYxclo2WHREOE16SWxiamp0MTVIa0Q4d3p0?=
 =?utf-8?B?SmwvS28vcm5tdGphQWl3TDQ5SExleUFxc3BkalZXdG5GR3BTMVBOaUtZbkdt?=
 =?utf-8?B?Nkx6bUlRSjgrVEh3ekoyVGxFSTluNlBrTVNsOGc3MkFhaUg3c2VPNU9uQzha?=
 =?utf-8?B?NnNOM0VyVURLeE0rQmpHYW1zWXBBWW5ScW1pcGJab3IxNld3WU5vanJVay82?=
 =?utf-8?B?ek5nenR6VkRxZzVXRmhpa0xjNUlyU3B6QURod0VzTkN1MzRBdUhreFRDdGs2?=
 =?utf-8?B?NThlZUw1dFAwQmdGWVB1UjBiankwaG5uL3R6U09iS2ludnV1dXFCZmZGNVFz?=
 =?utf-8?B?c2FwV2ZFNC9vV2VRVEh0UUJNaFFQcUFNMGVNZE9UeFZMNGFET1hzRERoNnBT?=
 =?utf-8?B?VEJLekttcmlLc3FuTDNWV1BvL1JwSlZLak9HbDBYb1p2UjQ2cXpXbkErQ1pZ?=
 =?utf-8?B?SFBlMHJSalozeGdMSXBOZ2JiWUpJdWN4bmtDM3Yrb2lvYXluWEZpbnJZWWhO?=
 =?utf-8?B?K1pnM2lxQjdqYy9tWjl4c0pqeDBQUmNKeFhDcmo3ZlNSc3RRVS9NVWcvNGp2?=
 =?utf-8?B?a0tPRVRJVm9MTGJEWGx4RVdKMHdUMVRxU3ZCazFud3haelNGU3NpOW1LYjJC?=
 =?utf-8?B?UWxwN3NwU0RVL3FLVzNacGZ2THZxWWZSdjR3d3plQjduUzNzNElTN1JuYzls?=
 =?utf-8?B?TVJxbm9PMEJGWjltVnlneWlzOE84eC8rOWdHbVorT05hOTZWb2xMSkYzMERi?=
 =?utf-8?Q?VcOgjXN/OJDmaUjMrDZR8yNqKm3N1fVM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4538.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djA2V2o1NS96Uit4ZkdpeHdHbWlOMGdUamhkRHRlNThNbEZ5cld2SE0rb09S?=
 =?utf-8?B?TzhnUVRwamNvbGlMcGFPZVU5c3Y3cDQwaHB5NDlScHByVFNrYzlib0RWUnBB?=
 =?utf-8?B?NDMwbTY4SldtQkxPOEVXMGlRYys2VUc4VE5CaHl1cmxRQjM4TWRrWmZRYmZv?=
 =?utf-8?B?T25wdXV0dytlMlJHYXBsNmR0YmQ0MGpna3FFQTZkUkdTZlFtaXJvM0Nqcmp2?=
 =?utf-8?B?SVAxR2hDRE5VdzQyZEw1c2hSMmUwUisyK2x5Q2VwNG9CVEdrN1k4d09nQklr?=
 =?utf-8?B?cUozbWxnbjJUTW5CQXZQRkROdTZ6MzY0Sy9idS9kM2dQOU9UOFRYaVBkUm80?=
 =?utf-8?B?Y2tqQmFISEVSMWFZMzNBNzlGTXhBME1yTFNUTHUvNGdTd3h6b2JFams2clNt?=
 =?utf-8?B?eWRTUnc1REF6d1RBRWkwZmwxazJDTzh0OFFKK0tGaGV0TEhLNmJ0c2JTWXVR?=
 =?utf-8?B?TFo5QjdmNG8yVUg1SlVmeVd1ZEFmUnRpS0pweURVZFp0NEFaZTVWeG5CbFBx?=
 =?utf-8?B?OUJzVnphR1U4TW1PWWUzeXZkYk5wNWdrRWh2VUk4MXRDNkl2cm1WOGJDVS9N?=
 =?utf-8?B?d1dDNVRGd1FTcjRJWndvL3JodCs5MzZibXg0ckN4RTR5SVZxZkk2ZlFSZXlj?=
 =?utf-8?B?MmVpWC9pSHZ6NVA2clcxNW9qWEY5WXk5UjBWcDhBVUZxVmU3dGhCNGFyYVJ4?=
 =?utf-8?B?Y0NNTE1KS24vaEpXSmcvTFo5K1lJelI0Rm9sU0VyVU9heGh1RmR4OEkyQm40?=
 =?utf-8?B?VVpvalpTM1pmcUxvRFo5TU54L1lQSFVyclhNTFN0dFhyVVBBZm11bG5rMmx2?=
 =?utf-8?B?eTZaalpMVGpHTXMrMTRFbDhyZnRNYWRNakxPd2I4OVNSczNXL0lCc3R2S2hF?=
 =?utf-8?B?TTF3ZnUzc1RNNVpzTDJoMCtkb1g0ZDdJMG1jdnFoNDF0bkV0YUhLVUVjSm1j?=
 =?utf-8?B?RDF3d2JpZ0MyQmE0SEFFWkJremtjRFlPRHN1RU1XVFZla243aVNpSjBJbW8r?=
 =?utf-8?B?ODhSbnBxS1lmaUdPVXB3NHhyNVlHSUpzZVB2YzI1NXJ1N1Z1dWpHTzBvOG5R?=
 =?utf-8?B?K2UyZVFVOE53ZGVMVkNMQ3k0aWdkSkhLY216NVdBcFZCd1d0bHVMd29NVHNK?=
 =?utf-8?B?WEY3RnR2ZHkrODQwckpZVTRtNllNRkpxOG1MNjUyRmoxOCtjSVF0Mm9CYlZY?=
 =?utf-8?B?NFRDbWU0ZDFPQlppWDgzd2NLZjhVUlFYbWRVdWdiUXE1RzVIcDFSdUVEbDln?=
 =?utf-8?B?Z1VDTVhxTmROb0twcmluK2VJNWk0dThwanRsRnVKTTdQREZZMjM3UTZSRExl?=
 =?utf-8?B?dFdHdkNDaGpqbFhSQ0RNazJ2RUlkaVYvWlZsY0dHdjBGdFBTSHA0dU1LV01T?=
 =?utf-8?B?VTN1S05ubGkvOUpWNFFBWFkzM1RQQlFYYjE0cThBYlhEVjE1NmxaQUN6TUpx?=
 =?utf-8?B?YlRHRzZVWHRneGNUdExJc2k1cVdTSHhkYXhHL2tiVlA5dnI4UkdvZGpOYm0v?=
 =?utf-8?B?OW55blk3ZmZDQzNQaTlZcnJsSFBlMWptZWtReml5TlhhU2VvUnhSWjA5VnB2?=
 =?utf-8?B?UnpnTWRjc05SSTV2OEdITEE4OGh1V3M0ZkEzMUZDT1E0MFRPYzN5VU04VUI5?=
 =?utf-8?B?NExTMVpWT0lWWGd3a2hsOThUcjI3K290MzdzdDgyYVFsUXBQMHo5ZzRldGlm?=
 =?utf-8?B?TFFSb1NnTmdtclRnVU44NHB1NmVGZlFVckJ6QnpyeUwvczAwUGVhYWFlTUZm?=
 =?utf-8?B?VWNJWHpaWGxIdHp0UlVZbU1aYXJJUURoZkxaRUh0UzMySFFSVWE1NGkxRzFN?=
 =?utf-8?B?QU9VSmRENGRqZDhRa05ySnJZS3NrelBOR05VQ1B2VFYzcXJ5RVRXakVYdWpH?=
 =?utf-8?B?OVVESHRNcXRWSWs0Sm14WVJJbWdBMUR4ZkljYjhhSjMzUzVzUkdNY3VTdjc1?=
 =?utf-8?B?QVdQUEE5Ykc5WDcveWZJVGppZ3A2K1o5Ukl4REhpcXEyNzF4dTNZYVVHNE1s?=
 =?utf-8?B?Y3RoZkVKb0JVV3I5UWVuNzJaSW12ZlFYZEk4aDlkOHFtbFMxVW1WRmRleG51?=
 =?utf-8?B?MzlucEwrdDAxZm8ySVc1MDFKWDZqMW14UUdXZmQ0WlRrQnMyZHN1c1VYVEps?=
 =?utf-8?B?WitqYmRnSk5KQUMyZmhHTUNPMTJiNnBSS2lGSko2dFBBeFF2eHQ5UWdNaG5t?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 457f7af9-9adb-4968-ab0f-08de053580a8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4538.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 00:07:28.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LErTV5NjWdRS0OArMlx92wYwKkadhpA929baQYSljkgwy0zrv8Q4BqkKmMYEZOZT2a3fRGcr3iUo2xniSsQKVnzKFx7LN8vBtEGewtKZW6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com



On 10/6/2025 10:26 AM, Jakub Kicinski wrote:
> On Mon, 6 Oct 2025 07:49:32 -0700 Tantilov, Emil S wrote:
>>> Argh, please stop using the flag based state machines. They CANNOT
>>> replace locking. If there was proper locking in place it wouldn't
>>> have mattered when we clear the flag.
>>
>> This patch is resolving a bug in the current logic of how the flag is
>> used (not being atomic and not being cleared properly). I don't think
>> there is an existing lock in place to address this issue, though we are
>> looking to refactor the code over time to remove and/or limit how these
>> flags are used.
> 
> Can you share more details about the race? If there is no lock in place
> there's always the risk that:
> 
>    CPU 0                         CPU 1
>   idpf_vport_stop()             whatever()
>                                   if (test_bit(UP))
>                                    # sees true
>                                  # !< long IRQ arrives
>   test_and_clear(UP)
>     ...
>     all the rest
>     ...
>                                  # > long IRQ ends
>                                  proceed but UP isn't really set any more
> 

The specific case I was targeting with this patch is for when both
idpf_vport_stop() and idpf_addr_unsync(), called via set_rx_mode attempt
to delete the MAC filters. At least in my testing I have not seen a case
where the set_rx_mode callback will happen before idpf_vport_stop(). I
am assuming due to userspace reacting to the removal of the netdevs.

            rmmod-6089    [021] .....  3521.291596: idpf_remove 
<-pci_device_remove
            rmmod-6089    [021] .....  3521.292686: idpf_vport_stop 
<-idpf_vport_dealloc
  systemd-resolve-1633    [022] b..1.  3521.295320: idpf_set_rx_mode 
<-dev_mc_del
  systemd-resolve-1633    [022] b..1.  3521.295338: idpf_addr_unsync 
<-__hw_addr_sync_dev
  systemd-resolve-1633    [022] b..1.  3521.295339: idpf_del_mac_filter 
<-idpf_addr_unsync
  systemd-resolve-1633    [022] b..1.  3521.295450: idpf_set_rx_mode 
<-dev_mc_del
  systemd-resolve-1633    [022] b..1.  3521.295451: idpf_addr_unsync 
<-__hw_addr_sync_dev
  systemd-resolve-1633    [022] b..1.  3521.295451: idpf_del_mac_filter 
<-idpf_addr_unsync
            rmmod-6089    [002] .....  3521.934980: idpf_vport_stop 
<-idpf_vport_dealloc
  systemd-resolve-1633    [022] b..1.  3522.297299: idpf_set_rx_mode 
<-dev_mc_del
  systemd-resolve-1633    [022] b..1.  3522.297316: idpf_addr_unsync 
<-__hw_addr_sync_dev
  systemd-resolve-1633    [022] b..1.  3522.297317: idpf_del_mac_filter 
<-idpf_addr_unsync
   kworker/u261:2-3157    [037] ...1.  3522.297931: 
idpf_mac_filter_async_handler: Received invalid MAC filter payload (op 
536) (len 0)
            rmmod-6089    [020] .....  3522.573251: idpf_vport_stop 
<-idpf_vport_dealloc
            rmmod-6089    [002] .....  3523.229936: idpf_vport_stop 
<-idpf_vport_dealloc
  systemd-resolve-1633    [022] b..1.  3523.311435: idpf_set_rx_mode 
<-dev_mc_del
  systemd-resolve-1633    [022] b..1.  3523.311452: idpf_addr_unsync 
<-__hw_addr_sync_dev
  systemd-resolve-1633    [022] b..1.  3523.311453: idpf_del_mac_filter 
<-idpf_addr_unsync




