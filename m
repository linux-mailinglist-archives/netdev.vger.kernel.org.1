Return-Path: <netdev+bounces-180904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5477A82E51
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E648A11F9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36D277029;
	Wed,  9 Apr 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjHEsi5A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D7277001
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222368; cv=fail; b=c+5isgEBr4Wr6FR3+4qq8H/yEXPihjKNR1ZZbt4rBWttSvRMCQPcjFWZ/KFazQWqC8uNe+9d51hP/dWfjxDnkxL93oMznKSSLQfLuVSKcVCq3SgSsNrHHFi1+AwuOHkkWyJgRV9HwplhlLnbxOfsPL5Cxj03Y6pS1cG0ICPeODQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222368; c=relaxed/simple;
	bh=xmYExUDWtW0eLpDF3c4+d27XAm9BX4HazGK8QJ6qfhc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RvKHhxcxykPYlAKZsJwXAwSkgiW6SjnkO+6b68rWzJmA+XtD2DDtcXO1PLclULZysho9sn2a3Ta7bzwOmLsmwHsoWoCI7j03KJ3UcxVP0/ugTOEKmdlqZMnnpGlZkVrYizUhsrY04m8LhlsTA3MfhKUNe/HpIghEQhu+Yq+jbtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjHEsi5A; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744222367; x=1775758367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmYExUDWtW0eLpDF3c4+d27XAm9BX4HazGK8QJ6qfhc=;
  b=hjHEsi5AkQpaDQyzsMuFCSvMcVNIwgVD1MiC3TqnXUrt2/IbX5CepH/v
   UVhOadtudYg1gYLvQe6GxaivuQ2CzXDhDU6wGsNo/IaFTVIk3ttaei6Ja
   J2wp4eHBcg4WFfY0JHcImzikcPR4lIdbyNutq+sij56O2N/SSJ2j6RmcS
   aio+3XzmCDNM0dj2MP0zggH7jqLIfXOJlaXgqwqYotDLBpW4ICbUdOv1Q
   uYDrylwL2BZgrrEEPOrHqII0sC6av2Dugb9yjcNNWQ8kCOCrnIvmfzT8O
   fmvZV5T3/qy8PwXqJWyN/V38sJ4ui5vnmy1X7a9PDE1jK3NIRSjuitA8Q
   g==;
X-CSE-ConnectionGUID: fLYkAyHySoigH3P0w3Jm+Q==
X-CSE-MsgGUID: 4XyzmhW2QHyut5TuSI7sbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="68199154"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="68199154"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:12:45 -0700
X-CSE-ConnectionGUID: ZNk40YVQQICfA3ZR4LuHZQ==
X-CSE-MsgGUID: yghNxeMZSnimZM5QMD5VWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129013765"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:12:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 11:12:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 11:12:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 11:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcTd+LcSOJpu1WyvrTgYM1z5YQ6XZNbWZ/rdK/UihdGTco+wOGJmkH+yD0Iu8z+Lrowm/PEZjWsTgUiSCyQSXMPBRB3r9cOSCNJD21LsDiBmrOYVaAWyHG9VfKnj+oPt9ZOGNXRSMNiPYrD6xGvdHecSJYKeXytfYZUMyqgnBTCu2o3iFz5TKyVIQC2kC5xo3JT8jMsDrJXXhyoFDjBs3tu0SVm3w/TUGnyJCCsFG3zx/3k+IWQ9/3A+Gvr/Dt+YPiV+NGlUILFw7nIHzY+qG68lp+9esG2KC/TcWPzWm9mUCxmTdbVkv/vOTpcZ0EpKS+Z0znw023BH5ZLkAQf43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgt8gzhVmhWw0sllJptOv7NcaD7MucIEwbBcfTUWUgk=;
 b=kY2WJfAHzbBJmKxd7Yj+wQQFej+71GrKx557blQzSuz7atI7rMc6vl1h0OEX4ZT+CTOS9aSK2Za7RKigvNysSkG4vXx9Qq/0cBSkMRr/tNjKyNRhy9YT3guPz8rt+kvkbNfr5EW+piDI4Gf86fVBHKiE2OwIL7R97VJCCiOywEe4YEb/EMvsxSPjUuD1SkFc2PhwaLzBrTdsBueVzukO0WDVVsqXA0NF/zZ73TSSFzAOb+vJOL0FGGWvZQTGXsZL7stvFAbWTFijrDM3q9QHRUyoZcuvmpfjTdGOUt+kVTjLu8+x6/ilTDcfuslVKowy2CKZ+ROmM6hqKHPV/bXR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 18:12:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 18:11:59 +0000
Message-ID: <9462eda6-1b99-4b9d-80f7-727ddd040ad7@intel.com>
Date: Wed, 9 Apr 2025 11:11:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v10 iwl-next 03/11] virtchnl: add PTP
 virtchnl definitions
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>, "Mina
 Almasry" <almasrymina@google.com>, "Salin, Samuel" <samuel.salin@intel.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
 <20250408103240.30287-9-milena.olech@intel.com>
 <754e6414-cbee-4216-9fe9-36c468d01244@intel.com>
 <MW4PR11MB5889CBA3909D6C877DA20CF48EB42@MW4PR11MB5889.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <MW4PR11MB5889CBA3909D6C877DA20CF48EB42@MW4PR11MB5889.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 59654d92-6b9f-440d-e7d6-08dd7792057f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzdJVnl5ZnBoOUc0a0krZUlLQWZMVGIyb21jUjl1VDR4QW5iNzF0ZnpaZUZh?=
 =?utf-8?B?RXpWYy9STEdjQlVkcGtRZkpRV1V5QmZZTTBEc3VuOUZjNWozdlBORGc3YTRY?=
 =?utf-8?B?L1VvZnEyTkdoaGRUaFBTcHhESjZRdS9aRW9RYVIvZnpzRldFUDMrZlpOKy9J?=
 =?utf-8?B?QnBBcDJwT05HRU5hN2hDYjErTC93b3lkdU8vMzVHdWNSLzMwU0pKWkkybHov?=
 =?utf-8?B?WmRTL20vVmtiakpnbE5tZ0k2WmxTUHdteHkrQmlPODdLVGhsTGZJcWpqMkVw?=
 =?utf-8?B?Y0IrbWNIVmlVYzNNRVliSWphQm5BS0luVzBuS2phTzg4Qy9YdDZ6dUhaLzBm?=
 =?utf-8?B?M3M1aVFmN1FnbW5UU1FQc1ljNlEyVmpXaS9Qc3dqT2lieFp3cVovejVWTlAr?=
 =?utf-8?B?cE9kYW5MTnAxdDVvQzluTjluNVZjOUloRjM0VDhWaklzMEwvN1hCR3lCUzFQ?=
 =?utf-8?B?M3VtYkoxc04yaGRNM3E4VDFtZlRGdzNMS08vaklTWlRCZk1mRS8rUkVBVTg3?=
 =?utf-8?B?eWxsTTZOVmJrL0phZ2xDZ1A0MUptRk9waytsdy81RjRidUdxdVJVZTZOQnhC?=
 =?utf-8?B?eFpUWXA3Vm1NaE5iSjkxOVRNaFRBNFp3Vmtvd3llcG9zdVlyZURueFZYMldy?=
 =?utf-8?B?QWEzWnlrYlNIVEptd1dxVUdNbDlxQnZyNndaZ25HZ0dyeWtNTThuNkQzTWxE?=
 =?utf-8?B?eWw3Z3UxYjZYN05SU3JZYXZlZUo3eitKc0lqRmw1ZURLWUorN2ZyQjR3V3JJ?=
 =?utf-8?B?bFAxYzhKM1A2SWV4UThIaWlmTk1BajcxNTQ0U29McS9kakovUHdhOFFSNU1X?=
 =?utf-8?B?WjlLZ0IxKzIveU1JQ0RGS3YrM1hLZ29rZlNtUXJJSEZheVQwWEhDc3o2VWdY?=
 =?utf-8?B?ZlpMNFFJWTlGOVM2S3U0TTVoV1dtbE5LYXNXcE5ZUU9Gc1ByK1YwY1pHWTlo?=
 =?utf-8?B?NkdobTFoSmhlM1VMMXJZQmdMa01YV1VPQmsrL2Z4QzJDY3JERk1sRkRMRWZB?=
 =?utf-8?B?TE5STHYxdTJmT0dPNFRZdWxNWlNXQ29sbmJLMFBzZTVWTG5JUHBvQVFvOWt6?=
 =?utf-8?B?NFhkL0Fzejd3ci80MjdaZjJGVHRkYUt6Rm9kR3BPbEtqeGlqb1Njb3M2Q0Ni?=
 =?utf-8?B?dW9hZ0FNUkZPT2VyWm1wTk1RbU9CdHJJdEF1UGtwM1RYSHdqT0dIMDVXdjZW?=
 =?utf-8?B?OElZUDB4UUdrN09IaWs2eEhlL2dKTmNCSTRqeGlHRWE3NUFKbTh0djZpNzFx?=
 =?utf-8?B?ZzFGUEhHN01BeURFelF4OThGL1dFemF4dlFYOXhNNHNLTVVsU05jYXdTR3FG?=
 =?utf-8?B?L2FkRmtiQ21KcVh4cDlGVFpyTTYvUEhESG1QZElWcDZwMzdvZEpwcHVpRkhq?=
 =?utf-8?B?NjlKdTBMUmUxWWdrVUtLa0QrcHk0L3NWaS8vSTk0UHV2RnlWRnovKzVQVGZH?=
 =?utf-8?B?VDhvNFNacGhlUExuTUVkdFdCZGp0bGNTZDdRRXFycjdXL2dPOEJwQ1YzR0x3?=
 =?utf-8?B?YU5uQldaU0pKTThDMlJPbUhmdlJObG92RksrWndKU1dnTk10ZUkxOGhRbk95?=
 =?utf-8?B?Z0JBSTY1akpWYUhQRGdleXNoanNqUzVLeS9FeFR3TnQyN2wrSFpVbHE3RzA2?=
 =?utf-8?B?eUVkeFZ5VjhidzdkanpocGdiSStNaW5Jcm5IWWdkQ2tDaHR2cGtnNmdIZjFw?=
 =?utf-8?B?OHhFWWNIMkVlcnRBYmF5NG41cGo2c2dSQUhEbVBkb2hTOE1EVFBubTd3NHNl?=
 =?utf-8?B?anJIN3ZhZmpERklzNExUNWVWakRTS255V3FrQ3dQQ2dIcTNYdWxiN0JlaUd6?=
 =?utf-8?B?elFEbzZ1KzlTZ0RzdjFwclhlZVJsS1NXWDJQc004em1RQjgvTHB0Wml5RFhX?=
 =?utf-8?B?RFcwUGpOQkw2UVBkMDhrUWU4VG1oZXZhTGVPYk0xVU1sUmY1RGRydTBDQm1X?=
 =?utf-8?Q?8MOHaf+hASU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZqV2dycDZFdGZEcFlPb3BOU1JSc3RDWERiUzU4Q2YxZUY0QU5wZ3FNMVg3?=
 =?utf-8?B?Wm15TnVBbXlOK0tDRjZaUjNZa3B1UUs3d2Q0RTRlVUt5SmovVmROYmEvR3VJ?=
 =?utf-8?B?REVUUUI3aFJ1YktTUkVwUlJ5b1NwUmQ2RDV3NWcvRWJmZzVnVjY2b3Fha3pv?=
 =?utf-8?B?UkwrZnpVYVE1VEd4Uk8raVpJeWpOd01pMG55N2dpTHh2YUp2Qi9zQkpyYk82?=
 =?utf-8?B?V29mbHJza3gwMWF6L0xRcGVqWEhsTnNzSWNUS3Fpb2k4Ryt0aGJaQS8wK3NJ?=
 =?utf-8?B?djJHbVdSM0x1ME9PN2E4UWdENVdTQmhBSUdjUC9VR3pheVdpY2lJQmUwQ1ov?=
 =?utf-8?B?SFlnZEdiUnFlR1Z6dFpNempKN2xJMUx0WHV5VGRXanhFTER2YXR1eHVKNHk5?=
 =?utf-8?B?QXpEdHk0V1c5TU9XUXVkSEJFQnFVc05vYWIvekV1K3FZbTR0c2h4WGJsL0Nr?=
 =?utf-8?B?TWpRMTN6L1FrUWxEVnYrQlZhVEtkaThaTkcyZnRydDFaa3dYL285SlJIdVBO?=
 =?utf-8?B?STBTd3JkVU9Sd1VxRFNsMUlJcnJaYTJXb3pNNXRleVFxMFgvVnlhQnM1S3Zz?=
 =?utf-8?B?ODliN2JtQ0U1VzVHVy80OUo0Tmwyd2JMUWdzSXBrTFBQS29TMkFhRFNoa3U3?=
 =?utf-8?B?TXkvL3FwVy9iOVJ2aEtsYXNJMmZ0Zy9KemVKN3hwMWlObGdkalhmdGVOOGVI?=
 =?utf-8?B?OWFKaUIzakg4YXVnR1EwTnpVN3JIUnRNd0JBRW5TMTdSZWFzTno3bTllRjhW?=
 =?utf-8?B?dDYwMEx6TDJtVitQNlNwNEcvSkM0UFpoNVBha01hRHVxeElwTVgvMzlRTWZs?=
 =?utf-8?B?Q0ZtcVVEWnpVRWZLdFY2L0F4ZTBjbGl3Vk81aDAwZnd3QlI1MVp4R215eC9I?=
 =?utf-8?B?RVNiNC85VE9YejNTZk1qSnA5V3haTE1uSGR6UFIyMGx4TWY3c2xaK3hLc1JI?=
 =?utf-8?B?ZVVyVnRibGI3NWg3Njk5VFhSalVVQlJta25wZFRmTTAzVUF5dGZHUUJSNVQw?=
 =?utf-8?B?NWExUlhRbGtkaytnUzJhQ25EUkpsdUZJNFJleS9iLzJ5MW81YkZHS0RPRlJl?=
 =?utf-8?B?S21nYXM3c1dRZVIrU0g4eGg5ZEt5NlRqK3gyVGlMZTRYb1hPaHppZkVBR2NT?=
 =?utf-8?B?S2pTOXRDeWg5TlpaRXR6bzgzT1Z6eVl4MTdvUmdDY0U5VDN5N21KL0xTeFlD?=
 =?utf-8?B?RVNuZTFIaElwQzgyV29CL1d4TE5mMVZaZ3JwZVVKcWloSmNSRnhPNUIvQXhq?=
 =?utf-8?B?aVhIdWEyMGF3K3ptSmxQYjBVSm91aTlZOUYxYlZ4NTRJOXZtbUJZV3laYzNJ?=
 =?utf-8?B?cEdhS2NMUjBFS01ONDlJM1RHSlBRWXFFVzRxeG91Qi9pVmNRdGs5Z0ZFbUli?=
 =?utf-8?B?MDRYd21NQTFyTEpBSVNjei82cDNhdWZhdU93Q0puL3hvWUN2ZTcxcU55UXVT?=
 =?utf-8?B?T3VlSUdpWGlULzNTZzBIbkhxK2hFWjFkaXBqbkNZcGVQS0dzMjh2U2NDNXdy?=
 =?utf-8?B?VW9VdldjTDZtcWozTVpBNU1ZTyt0alhEdDZHaWl4bmJ2QmFGanpVNlc5MUY4?=
 =?utf-8?B?REU1MFZYcm9ZN1JCMDNkYk5zckJYTVRhT3dtdUhRRTlsWWRpcmxVNHhFK3g3?=
 =?utf-8?B?dGJhTTd6bHdzQ25jYzB0WHBtdFQveWQwTTcxcGdZVWhDQkMzSDlrN0RHTEZZ?=
 =?utf-8?B?ek1qMDJkTElsUklmQUFEMjRydHYwWkJKbThtVXExdjgyMFl6MThVTVlpS2tZ?=
 =?utf-8?B?b0JCeXZjRlNHYmgwczR0T09wUlQ1TG5hMGdFbTNob2s5RlVIaXBuNEI1UG5p?=
 =?utf-8?B?bG5RNU4yRFozQXc5MnhKaS9HV2VGNHMySWQ3c0o1eDNlQTQzWFAwbmthVjJ1?=
 =?utf-8?B?L0czWEJVL2lRUXRwWXVyNzlrdGxJeWExRDMxQkhTYTl4WVkxcnVoWXljaFpZ?=
 =?utf-8?B?YVZBSXpnOUUvNmRTOGwrQWlla0JlQmdCNG1qQmZ4aEJ2NFdLbHd2OE1RUGZM?=
 =?utf-8?B?VXRiWU9laGdtcWJubmdCMnlBNFJxenBSaGVyNnhMd1RZT3VMS0trUkJYQVo1?=
 =?utf-8?B?bHVOWTFVeEpTMUE3WWRUdnVZMnE2elBSeFIybEE3dFpHNVJZaWdIcXlqa0pk?=
 =?utf-8?B?d2NjWTI5cTBNRW5PN1o2R21HQjVSNTMxT2IyaGhqbU5YOHcyQzNZYWZhelNC?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59654d92-6b9f-440d-e7d6-08dd7792057f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 18:11:59.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XhTuO8+GCaAf+d41pNt0z12lQ0AXCspWqoyGU96TAwUtBm7vEHWZh00lv44aAYo7RwlhCDSDEsCNKwGngIYO1AOboObe5TWahEmrQ4srfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com

On 4/9/2025 4:51 AM, Olech, Milena wrote:
> On 4/8/2025 11:12 PM, Jacob Keller wrote:
>> On 4/8/2025 3:30 AM, Milena Olech wrote:
>>> +/**
>>> + * struct virtchnl2_ptp_adj_dev_clk_fine: Associated with message
>>> + *					  VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE.
>>> + * @incval: Source timer increment value per clock cycle
>>> + *
>>> + * PF/VF sends this message to adjust the frequency of the main timer by the
>>> + * indicated scaled ppm.
>>> + */

This comment should be rephrased then. The text implies the value being
sent is the scaled PPM value.

>>
>> Do we want to encode scaled_ppm here in the virtchnl interface? I
>> suppose its not that big a deal but it is kind of an implementation
>> quirk of the Linux APIs. We could use parts per trillion or something
>> similar..
>>
>> I suppose there is little value in translating from scaled_ppm to some
>> other format, due to accumulated error, and scaled_ppm is higher
>> precision than ppb. Ok.
> 
> I'm not sure I fully understand your concern, but you think that we
> could use another naming convention, or provide to control plane raw
> scaled ppm value?
> 
> Please notice that in current shape, we negotiate also basic increment
> value in PTP capabilities, to adjust scaled ppm - as it is done in any
> other product - and then the diff is sent through virtchnl message.
> 

No. What I am trying to get at is that i don't think it makes sense to
encode the use of scaled_ppm in the virtchnl message. You didn't do that
which is good. But the comment makes it seem like you did, because it
seems like the message itself adjusts the main timer by the scaled PPM
indicated within the message. In fact the driver calculates the new
invcalue and sends it.

Its not a big deal either way to me, I just misinterpreted the meaning
of the comment.

> Thanks,
> Milena


