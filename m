Return-Path: <netdev+bounces-182484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC38A88DAE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD53B5525
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D5BA49;
	Mon, 14 Apr 2025 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOsCi21D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C61A83F2;
	Mon, 14 Apr 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665727; cv=fail; b=i1jzOTjqXOB3Oe6DpUXYQYQ4UbrY3gZjW5V92zgDCCU7RyZ9D7hoikIjhEtb/Wjdwo25oZ9eftuhrXH9mc0QmUuyzndaK0JPmaWdsAQUyNWC0HLA0HfesGy7RqrUuYoefK1gtSSiofR6Qu3IJHTw2NGv7tbwR4FrrSIMOHOrxa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665727; c=relaxed/simple;
	bh=WdxzXUTYv5rlmxBoIbPRonrGedWPX2QGRbLtLLME7nc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fm15H3y22zkxN3CGpYElWhIyLt7sme6n3kYTVS5L6YoTm0wZif9qOjuBM1wFMgTp260ruBLoFKE8V6tHQFapEPKSpnIGE//LnEtmSGMLr64i6nPRbjz53OV8nu9e1uCrz5iz3IjCrRM2OP88fx8vF4rYOcI7AONRljizqTMglYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOsCi21D; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744665725; x=1776201725;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WdxzXUTYv5rlmxBoIbPRonrGedWPX2QGRbLtLLME7nc=;
  b=MOsCi21D4YfIPdhBs5VTVyLC6kb14STr0NbBz6kORgbvIKrM+jtdocyC
   cJ9oTYeIwRTlBtWVgcYmRy47gR+/v6dlO/W62rnDEijXZ68xXK6Xo9H3a
   k1jchbpV11cjekan/BcwW+1Enh2vS7FY5OMH8Mp3PqtNgv/IDtdwA59mN
   YOeP4Wy/usht6QoS0e7ovWMRcYQXDge6c1uHL7jkS9peHNwGMuF5sXrx5
   pxSCtIi15yuzKdGCMKGfgQ8osRq6nogYy829wA5mohUQS1Js03t6Afrop
   9bxSQqH37E0nU0RVz/czZEX22TQS+TUMRXwY/L60jTZwE4K5goDqZMqdW
   Q==;
X-CSE-ConnectionGUID: t38xeIwVRxytjh5hK6Hf6w==
X-CSE-MsgGUID: +ezB+XI8Sdm1CLKxOuxBbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="57143107"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57143107"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:22:05 -0700
X-CSE-ConnectionGUID: NJ/PHdpRTUqb+E2H6kmnfQ==
X-CSE-MsgGUID: k50Qg5xQTE2ApaumKffzIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134908903"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:22:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 14:22:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 14:22:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 14:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFBXJkNCIlLH9ctEImRQqFJ657UT1YOXgq4UuX84LDEkCZL1DP3byWf1ShDJNlkARx8EqD+TZpFEOmFA49YfyueYGRFjk3qwLzBKCbOA7DWVJcIl3oKUDQyleaDp27SvEWUtWyjoXn4lEH9AC0G5KCvh68oLSAcudkyU7lgFjgGyw+xnR2UiRVDDxhu2cT16TagKNwAg/x3swjWpgTfszXAwIpUHcw+nUdPBLOg/wBmjWRQvIDJSUiQEHEsB/4F93qVmdiJZRV6dF1BR9ca1uMsFHpIDAcWnDVTsM6/XbwnGlJ0uK5Psh8mFAPnPMp4uJz4DHu1gnnWNFQveFQvWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq5zOE4TjL5zOAwluRwC1GHe6UHxl4D6CHlUX05tnAs=;
 b=J8PxLpeD3uhMX5a7FpvE4qt1oCOnqagHOL60VoV64oo6aXvEjKAbUBldtCr8fGyv40MFPz/yCkPdi5Valz5aY9lW7D80ZTv9vnBIgPiscS8bDKo7ZFm9WUXenNYwYmw7A4BvgQYHKTgknLCJyIpu7uW8KQBdjBEQdJNp9MUuS09fEsvmLKDOhMSrjaOv42+3uyqgPATgP1BeZFSpL/hDPb2nSakpc1anPINyEs07Kk8Q01uOLiY6r9EXHyzeLnQ9c746pGFZ6UCwTYgVWzddK8Slkqkeu0FZuuDPbWgQ1SeZ5uTjSr1yhH24xeppaUYuz64KvXzyT9LNB82Ata02FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Mon, 14 Apr
 2025 21:21:30 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 21:21:30 +0000
Date: Mon, 14 Apr 2025 14:21:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v13 00/22] Type2 device basic support
Message-ID: <Z_18VpePAHGj6vM7@aschofie-mobl2.lan>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA3PR11MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd5ef78-c36d-46ef-1cb5-08dd7b9a52e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVZzR25BL2NMYzYyYm15YlMvTmNRbkNQK2FmOTNNTWI0SmtESXhEeVE4Zjd6?=
 =?utf-8?B?WW1IYTk2QWNhRjlUT1VpTmo2MVdka1g2NjlZWW5Xb1dxYWppVGJYdU1HRkRT?=
 =?utf-8?B?UEpRMTR3V2cwdXc5NzRJN3pkZC84RWxtam9VcEYzZ3lJZE90MzVvUFZIaXdP?=
 =?utf-8?B?Z0JWcW5oQnBkbkQ1ejV3VFY5bVg5anppcW9zNEF4Y1lQQkl5TkhBOWlJNDc1?=
 =?utf-8?B?K3VnM0s2dFJ0cFg0bUxsekVhSzB4UHlqR1ZSNGptTnhlN3c1cHgyZVlxUk1o?=
 =?utf-8?B?bE9hQklRMExZZERxdU5qdnBVOFpRRVBoWk90RG1SQlpBL2xEcTYvK1NvTFow?=
 =?utf-8?B?NlNIa1dMNHNvSDhWQlJ5bFBqWkVFRWVDYWxHL3BqMXdqZit4VHQrZmpuQmxF?=
 =?utf-8?B?aENnUkJ2ejRsUC85VDFxaUNHVm9HQklsOWRXYUpVblRYa3FGaFpPR0hIS2V3?=
 =?utf-8?B?cmZwSTRyRk5QTWtJR0o1VlgzMGFvLy9aTEJlQ0xsYktFRDBhVFdMc0tHdTVP?=
 =?utf-8?B?NHEwNFZoU3BoVlB4TldIaVFlUm5Uc0tEL3BEdnpFUjFubTRWR2ptOHZzM0h2?=
 =?utf-8?B?UjRsY2JLNXNJTWU0eWc3dEw4cmNqc1dyUHBaaFc2NmNvQW9FbnlhSi9xYVhU?=
 =?utf-8?B?LzRZSVFXYUtSQ2ZNMERnSXhWNTJvSmJla003TkgwZ1lXc3NkQ1Z5YzFoNzMx?=
 =?utf-8?B?bWp2V3ZHaWNvdS9QMHVUNU4vTEgzajdHY3ExMEFZeEZDR1grMW9UNzNoYkth?=
 =?utf-8?B?T3pPNG5nUW9pMVJINXh6MDhCQlNRK1N5YkhKY0l2WDYwaTBpdm5RemY5K1h1?=
 =?utf-8?B?czNieWoxRkphWDNOOEdVZTMvZktzL1JPM2JRcGc0d0JJZkNEN3J2Y1lwQjR4?=
 =?utf-8?B?ZUFlN1EvWHFjTm9IUEN3QVhvam5ka00wd0sxR0VYNUowZTI3YnpFSGlQdmc0?=
 =?utf-8?B?NmEzV2V4cHlwRXpSWlYyN1JKSTdyenlsQTNmekdXNjZvZHRpS2V0MjNySW1m?=
 =?utf-8?B?OGVkb2RiUW5rTW1ZSG9PaTZtbjNVcjVIYURLeXpyclhlRWZmUStGQWxTNWtj?=
 =?utf-8?B?MzlML3RLZFlYZVlZUlRRZWovWmt1b0Y4T2g5Yi81UVpsa1lZNjg1V2FOODNo?=
 =?utf-8?B?ZmRVTSt0VVFqUDJJaU4vcjZ1Y1BpcExqLzA3QUpWZDAzRkJRYyt0OUk2dHBy?=
 =?utf-8?B?cDRycUdaYmtFNHF5dmY4YS9HNzJjL0YxOWZBbXBNdzhCZEphNHlMQUhpTHVQ?=
 =?utf-8?B?K1BrNnAybXBrNktRNGgyYXpDeHhMN0NERlVYbFhlaU1naXpLOFM3TEgzM3hB?=
 =?utf-8?B?ZHVLSGNHRVRIMmdacDRGb2VxSWlTVFlTZ3E4aGl6SVJ4c1V3RnNpTHdoQWI1?=
 =?utf-8?B?eEp2ejdDQ1BEa3F2bGZ2dXpzUUdZZS9ka3RyaGkyaDBDTlhmbEVrMUNmYmFP?=
 =?utf-8?B?WVhVandiOXVzNnZTVE9DcDdOUFZzdkYvWVUweXRBenlYWGhUY0JIaklCY3Yx?=
 =?utf-8?B?TzNVa0ZTQnUzR1YxY2Jwc1VkeGR4Wlh5SDlSUnZsOWRmWTdpZnNhQldxL3hL?=
 =?utf-8?B?Zzg2dkh4aVA4M3VwaXRBaUxWVDZCdkJDZFp1b0xpc1ZlUitKbVRNVE9FTXJG?=
 =?utf-8?B?TEpzSlhJUE53T0c0WDZPdjBtTERRdHZFRUJnVTYrZU5ENWtCL0xiRXlTQWFF?=
 =?utf-8?B?TURoY3R3THBRNmhJSHlqWENXNWdndDBNZHQxdWhzVUF1UmNKWHUzK3FFdXVR?=
 =?utf-8?B?Y3JlQ3lJbjNwL2pMSmgyR2tqRWVkVDRDVnRxVnB2bU12bytBaFdKSEx5a0FI?=
 =?utf-8?B?N2llNTVWWnpaTmtTeWV5bzY1VE9ka1dZSitRUHFXSG9YZHRNN0ZheW5xKzNQ?=
 =?utf-8?B?UTI2b2FVSDEzblhldkw5M3hBVTkwYyttVXNMM1AzemRVd29EWXlYdXJEcElu?=
 =?utf-8?Q?706VUxRKuqk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WThQeS9PS0pJdURlUXZ2ZVYyYmFyTzVzNTZqSzdmZklJTkxRSTErdW1nRnky?=
 =?utf-8?B?TXAwYU1xWEdiWkV1QmRPZlFqcVc3UStsV05VcDVnVVJMQlo3V0ZjSVF1elUy?=
 =?utf-8?B?WVhNdU00Mk9qMlBNTEZwQWJoVUVLZFdveTRNb3dxVUo3Slc0aFZNU2dpVE5K?=
 =?utf-8?B?bVJxbG13TVN6Z3JrWnZ0NUxQMERERzIzS3dvaERPVjYzWXV3N3gwcEFzTFA5?=
 =?utf-8?B?OGJoQjR5clplZFhsYUx1Vmw5VEdQY1pHdVZhaTQ4U3RQQ2FIUGlWTWNRZnJB?=
 =?utf-8?B?KzhZNVJYQnFIZWFraHl6QVZlaFBYd0VGZFRMN3JRd1cyLzJDODJOSjlhRjNE?=
 =?utf-8?B?bzVuV0F4cGhpVUlHbXV6cjVJL25QTDJjS0g3Sk9kM3pnWTRkVUhTSkhwNzdS?=
 =?utf-8?B?czVzcTNMSExqV29IcXBsM0tjemtLa0wwRzlPK3BoSm5XVmkxMk1hU2dJQngz?=
 =?utf-8?B?NWZ5MUlyTUVvajMyRXBFaEMxRkhqZnRDWkRKeTRoQVI2WVhJQ2wzNVRhZGpQ?=
 =?utf-8?B?WElYUndvR3FhWVFKYnNGR1lDcE10OTBSaTlQQXZtZ1dwV2xnMWVnRFBKaVk4?=
 =?utf-8?B?TkVGOVpSZm5xbWdiUTlCMTdxY2Z0a25GL3pMUjQ0eng4SnlYN3pBeUllY0p4?=
 =?utf-8?B?UXRxY0xwOU5oK3VPOWdCQVdFaXFkeXNVL29BanVyYzdReHR6Y1lVb3ZORmp0?=
 =?utf-8?B?c0pQN3FBTGIwdUpUNTZDY3JnZGZPUDNtaU53WnNrVVJ4UlZlZVdiaGkzWjlv?=
 =?utf-8?B?S2FRYkdGVi8zTEJvdHhiazN1TTlJeFRwNHVaVWt2aFBqZUduL0t5NTVWUnRa?=
 =?utf-8?B?UGNWclRhUE9wMXNzQWJZejVSZm1JUFluelNBRVVwN3pwS1hUODBXK01pQnFH?=
 =?utf-8?B?NjEyWXJ0Y1F0b0ZIbzZYSzJVTlNGTytSQ0VMNStBZm1zYjBtZlZyVHJZWVZ5?=
 =?utf-8?B?STY4UWt1YmN3TkpqVnM3Y0FRV0VtNGRmV251Y3lsMllnQUtMUzVyK1BWamx3?=
 =?utf-8?B?L2NPRG0zSWdzNGgwVWF0YStlTlhpLzZta2JvZjdQbTRHK1Q4YjFOUkExOGoz?=
 =?utf-8?B?Ui80c24wR3U5TnBvakdRUnNETnBTamhpV0xDVXlHam9JeUVLQ0N5ZldrNWow?=
 =?utf-8?B?SVVRWm9OTnFuWXNwcEdYaGNZMStZS3Yyb1JSa0dVZ2MzUWswTXNDalU3ZFNn?=
 =?utf-8?B?UmlsRE9aZGVtb0lMTVBRbkhOcXUxdVFJSXNxVWtYSTF2Y2padzFUeE1lTzdo?=
 =?utf-8?B?RGZndFRKdXJKdFJZYnRSOFpFb3gwbDBHRXc2M2xpY0g2aHh4N0VxSlJUdm5G?=
 =?utf-8?B?Ykd5N1hVZlJmc05CYnBqdFVCMTBaNWJ1bnRoNG04U3JVUWhZYTh3Y1JOMTla?=
 =?utf-8?B?RTdib2JkbWhWT3dhMjd4N3BJZ0ZGRlY5R3BxVkVRYmNVOTUrbHkwVlRrK0ZQ?=
 =?utf-8?B?TUlleW5xTlR4aGkxZC9VRXIxRjNnL0UrYlA2WVkrb1laQThwQlZ1QzdCVjN0?=
 =?utf-8?B?QUNLd1RtUHllRkpvbVNLRktmS2toNytycmpBbjd5Z09PYjhicmtoQmpzSmdH?=
 =?utf-8?B?N0tTd2RZcEx5cGZnOTFsLzdCVDRJL3F3OCtSM1h6U0MvbkFiUHZYUzk4Q0ZU?=
 =?utf-8?B?OTJBdEovU1JMMUN2YzhDU3U4R1lqMnNua2c5YW8yTmhhQi8wUFJzZUVJRlVS?=
 =?utf-8?B?bXhhcWRBdHFRQmxYL2FvRzVvWVRPc012UFExNDJDS0xKZnRFNWZYUkFSejFV?=
 =?utf-8?B?UW12UjVjQnZjZjFVMzhGcmZYTGZwbzZPVUJpYmZUU213bHBubGVZQS9PbEFs?=
 =?utf-8?B?OHg4MDYwK3E5T1Q5c2FkTXRFSTgwZDZNLzZlZEJSREhDZXZNNmZXNjRUdHF4?=
 =?utf-8?B?SU5zWFEvVDIrRW5nOCtDdTFMWXFQSmZKQ0VOOFdKKzExbU53M1JQWElITFVH?=
 =?utf-8?B?NHY1QlorZitxTFArdWQwWkp1Z2h3czE0NWdRUVNseDFMMTBhYTh3aHNHbWVx?=
 =?utf-8?B?SFkxNk5xb3hXSzVrRDltR21TTjBoSTRSbkVHeTUyZFoyYkgzUHVvSExDSlh2?=
 =?utf-8?B?ZE9OaVhaczVyTU9EN3M0V0hwTGdGRGtUUTZpa1RRdHIzV2tkVFpLWU1nV0t0?=
 =?utf-8?B?R3k3OHl5T0pFaVk1c01uTVhHY21uRjNxVWU4VGhpWk5lbnkwNTJ5cXlSdUZs?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd5ef78-c36d-46ef-1cb5-08dd7b9a52e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:21:30.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wujk9Oyf/jS2K87wUrzw/cgY/YLWxGyBgl4J5Zt2VjAhi0tO4+7ZVCVzmrPljYl/4z2uL8ggNBohzt1hnVZ/xWE5Y4n9Hi/Jbelx7XRHzNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-OriginatorOrg: intel.com

On Mon, Apr 14, 2025 at 04:13:14PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>


Not able to make the cxl test module.

test/mem.c: In function ‘cxl_mock_mem_probe’:
linux/include/linux/stddef.h:8:14: warning: passing argument 3 of ‘cxl_memdev_state_create’ makes integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^~~~~~~~~~~
      |              |
      |              void *
test/mem.c:1720:58: note: in expansion of macro ‘NULL’
 1720 |         mds = cxl_memdev_state_create(dev, pdev->id + 1, NULL);
      |                                                          ^~~~
In file included from test/mem.c:14:
linux/drivers/cxl/cxlmem.h:742:54: note: expected ‘u16’ {aka ‘short unsigned int’} but argument is of type ‘void *’
  742 |                                                  u16 dvsec);
      |                                                  ~~~~^~~~~
test/mem.c:1721:15: error: too few arguments to function ‘cxl_memdev_state_create’
 1721 |         mds = cxl_memdev_state_create(dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~
linux/drivers/cxl/cxlmem.h:741:26: note: declared here
  741 | struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~


snip

