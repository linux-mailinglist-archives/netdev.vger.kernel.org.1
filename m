Return-Path: <netdev+bounces-151201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5979ED684
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 20:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9A21889B33
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451A2594A5;
	Wed, 11 Dec 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WY3LW+LW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3F259483
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944993; cv=fail; b=UWHFoZYRSF0jqgXQXP0SURQC+uIk38NokUB+rI1p2QlsLQA62RktZiAivjRX4xYduU8zE5W1IrMi820nee+U4trNgTIrb1UOZZteBo7aXmxRtfarx7j3DCnQOaNr38TdWlean1WFwcS8XTgi5Z4SkqFj+svfcHQo52XAD4Nw8VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944993; c=relaxed/simple;
	bh=7w394TkmLt3ijsh1h8GorIb0Zx8wCelPPp+WAms9cFk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmT6XTLfUO/9ehE6eI+SK5hn1tNDR8Z+j6IRxDKcjbd5TjZg49FT2Iy5eYt4ShWUftnO9yTfXHueBRuDLtA2Ni6zLGDbIrl3bApx12Wg2Z1iLmECUjriJTdMFSYzG2eUlzqmqzZU5I2sB4EmPt8IpZCVg7STHTUe0l5ADozuqvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WY3LW+LW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733944991; x=1765480991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7w394TkmLt3ijsh1h8GorIb0Zx8wCelPPp+WAms9cFk=;
  b=WY3LW+LWfGyV71e2Uz5/A3+27ddlpLNF72FYQoa/7ZlvgWweePUO90bU
   WfOhIeCOo9hyhqYx1iQFxMq5oNAm5jTbMzM71k13yN0vxgKj7payjNMR6
   LW+Ap/VIeWvqUjsWtGhAfCubFECvCCkq+fQ2k+Myj0H1TnPRGqhuqSAIm
   VF14QbtYLVgG3mVf3jg9g6kv8wrNtRYx49lgkYHsZEvNjftwZZLjOdvKi
   W7lrOD+eEAPcUsQ+YNqkS6fDyZqrim5CFtuxRlOvI3UgYA9is1DNzu8o/
   ZHCMSnkayQvkNo/FPps/M4wADszE1LFDDU0GrI30+GHVkQGofvx1tLWEj
   Q==;
X-CSE-ConnectionGUID: hckU1zDmQtqcOZk/iUfBNQ==
X-CSE-MsgGUID: xaOlyEw0RUGO+RyjEsffJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34215980"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34215980"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 11:23:10 -0800
X-CSE-ConnectionGUID: CZd63qKRS6GamFfjNNThGA==
X-CSE-MsgGUID: 7ODJed/RRgORvINQXJi1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96122580"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 11:23:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 11:23:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 11:23:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 11:23:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6YJSGdm3SAXxZH60dmfvA0s0mLjksExpgMnnd7MZVSK/vJAAkbru/7mZ/T4AR8L+hf8EifoOWWylC9WIDLKGXngYi/vvQgdNcpdqgkUTg/bzoAffRJFT8lEdN5mdfYwrFCEa/+1hey95DTfhPgEQ1mZCglqu9R+rKt4924J5+7BAP8mFnWXdWAYEEMc8U2cC29LzXk7JL7113UuRoBBNOIKcbGzJh28m35u74Jxl+HaA0XpT5f2QXZwDk5TE9W4TWM0bG28NIQi7ntT9900xM79H+ODs1wKsSXMJofrOR1cLqfkx38P5dhszhxIihpJ/bVjJ2XVpxhkJd8xmve2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlPEoObcyhNXHkC1U5dt4W7d8OhqpSyCt35B1w9Gr/8=;
 b=kNbpCLJfSDW6gHXXThsOvDKNUdgifKU633W+TcxsDleXxXBTI/p4Oybh3DCWo6KDjmlzLVuAotp4GTfeHBoJWL+lMLXXUkiC4vDfbHjq3zYZKKCdx4p5nrY2YSl7GQchYzNyhC1SOR4jt8WKxjcTv4sJ3QjVDnagYUlqrRF//pRGY+glJeDwi+uiP0K7ioQkv1H0RLPpQ1PISidIFA8sJr3f9zuG+I82NC1SS1z5Ad5wEgcNj0JWGJWABBvFlQU3jnyxnOfR9HrBR1MeEhHQkqXy5KhjCnFaEMOELcHhknrOz/52wqh97Rt2Xli/OQKBhJf5JuzTa6h28G0tqXGD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 19:23:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 19:23:06 +0000
Message-ID: <230d76ef-5ca8-400d-8f59-406292025da3@intel.com>
Date: Wed, 11 Dec 2024 11:23:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ionic: no double destroy workqueue
To: "Nelson, Shannon" <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
 <20241210174828.69525-3-shannon.nelson@amd.com>
 <a4f1acf7-6bdd-4865-a13d-945791917afb@intel.com>
 <a8faf111-281a-450e-b595-ba35a7ccc66d@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <a8faf111-281a-450e-b595-ba35a7ccc66d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 123c968e-6b79-460e-e72c-08dd1a193d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXFPMFNlM3Mrb3pxeFQwK3FQblliY0J0eVZNU3VWU1BPNm1sY3dxOEhYQVA3?=
 =?utf-8?B?Um51K2t0a2xIS2pxbHVjRjFyVXU5ZmY5QlpFbS84bVgybkFrZUo5UkgxWVVF?=
 =?utf-8?B?c056cWdPY2RHTGJrSWkvQzIzVHU1SmwwOC9PUldlY1VaaldmYXJ0bVc3eTBV?=
 =?utf-8?B?RUNJUGpRKzlvekduKzloWGZtaTBzN1VjWlRQNFI1VDlUR2psc2g4bzNQQk9R?=
 =?utf-8?B?cEJUcmhlRndhc1Yyb1BqaFRZYUZRM2orcFgwZUFYYTMrQStBS2tjc0NnNDRD?=
 =?utf-8?B?OGd6eWIxaW5DeVdDNG81NHRtUmwwR0ZHekpmZGxWSStUVjFOTjl5S0hKb3Ar?=
 =?utf-8?B?ejNSbWFLMzVaek81NSt2L0ZrcmY1UjR4TEhpbkhTeHFUZlRzcHVoSU0wUlRl?=
 =?utf-8?B?TUozaHo2VXJCZXhrcitscWlldCsxVWJacjR3b0x5WDlGSnJ2WXB0OU56THUz?=
 =?utf-8?B?SUdMRjAveU84UkVuYkhDZ2lJVGFIbVBwVGduK2FiYjVlQ0xIL0k4bm9leitU?=
 =?utf-8?B?cVhYQUVOVUNXS3VRd3A3bENpZFJXb090QVBtb3UvNWhOY0R4TkpmMFVIbjFW?=
 =?utf-8?B?T3VHc2I5OVhFdlVVWjg3cFJaQk1kMFRuR2JYdnMzVElRV0U2M3BjUk1QRitE?=
 =?utf-8?B?ektSL3pXeUNGWkNHTXhUdmwwWEdGekV5cTdSRWJxZ1p1bHc0bzNVVUhnTktp?=
 =?utf-8?B?VjFjbDBEaklLcHRQV3lGZVNpOGEwZmNoVGVRK2pWVndGNUdqT1B4STVJcVlq?=
 =?utf-8?B?dW9TMGZOc2ZhNTRzZ1ZXSThNVFVDNzM4d0orVldsaDllTkhMN2lkY05iUTVw?=
 =?utf-8?B?TGU5WG1wd3VrMEVoYlVsWm5PSWN6Tnp3a3U5aDl2d25NeG4xUXBTV3pQWGda?=
 =?utf-8?B?aDVidU5JeXYzSjUzM0FkY0ZNL1UxQ2FxRnRWMWlSUVFTZ1dZZ0dmNDIzTGMy?=
 =?utf-8?B?QzcvZ3F6S0w5UWRaR1dyRWpRSDR4MFZVVlNQd0JvZW8vWXlsWlZNMlo0ZWxQ?=
 =?utf-8?B?N2dFUXUrN2lzU1VFV1pSVHZwSkRaYzF2Uk94WWhEVkRBRlRMeXIrVGpFanBr?=
 =?utf-8?B?OUIwaFhObCtybkN0YzV1RmQyQ3Q2OE9MejFuaURBT1dndEJ6OHhVUDZLU2Zw?=
 =?utf-8?B?ZTByR2Zxd090Z0d0V01oQzBhUGlhaUIvYWpIQUJIdnZkY1RKT241aXhLNWp3?=
 =?utf-8?B?c05mTE1nWm9VNnFjaGZlRGtseG9kV3FZaE1PaHphSXN3SjJMZEd4ZVY5cHYr?=
 =?utf-8?B?Q2RVc1hPTWdVQlIzRkxxYlcwRmZCVnJGNG45aVB4d21aK0dNZE1memhJRys0?=
 =?utf-8?B?U2JSWHZXTkl2dDVib09wVWltUWd5MW51ZVZnRVlRSVlZdk12UFlkbHViREcr?=
 =?utf-8?B?WTQ2RHVqTWwxSlgxTUR3NXpSUjgyWnBDVVI1OHpZWUtqendmd0Z6dkRXQlVS?=
 =?utf-8?B?R2NucUNOVXlsTUl1dEE3MThMdndaczFnOEppSHQzdWVybURBTVhrSGFnL2pZ?=
 =?utf-8?B?NDQ5S2FFTVAzbEZGOE1TWEROOC9COEZ1dzVEcnU1M2xjZFhKaTN3YnFaS2dr?=
 =?utf-8?B?azJzc3BudHkxSXVFNVRJZWI4RnpGMlpwRDlwWFFBK2JuWkUxQnFkcG9oMy9K?=
 =?utf-8?B?S3piVFVNWGErdGJ1Szl6R0JRcjYwcmRPYitPNE5hbE40YWorRDlyNnhIN1lK?=
 =?utf-8?B?U0ZSSk5ZNmJsUDJPSm1zb3Qrc25xdzlrRzBMcUtZMW9hOW9CdFdtOWpyUDRT?=
 =?utf-8?B?eDVlUlBFbk9UdWVodmMwNUpOTXd3dVFlUG1mb3NzQjh6SC9iWG5aa1dtakxn?=
 =?utf-8?B?L2NBcjlmWGZtdWxUMkl6Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJuOXZuMWNBcENDODdQNnhXbDJhUFZ4OVFmenVQenNGNGVtbVhlWFhiSm4y?=
 =?utf-8?B?aXl0T1l1SGlOWWo0TVU3RVZNaUtON2ZpTmZvK1dHb01DdkUrM0JucWp1Zjhs?=
 =?utf-8?B?ZUY3MGpkODBHOHRiMGxxT2Q4ZmFTZ1czNUNaWTM2MDM4OEtvZEo4OC85cWs5?=
 =?utf-8?B?cTZhZ1VWcVVId1dQY3dsS0tJQkEvOHp6TmtUSVdvcWk5UUxYSVdRSU5tNXlu?=
 =?utf-8?B?Y3RUSnpHYUdBZ3V2emNsR1pSSm53dlFnanc2UjIzYXRzQTJ4UTlsbmI3azBt?=
 =?utf-8?B?VXA3T0NEUVE2UVZTRVBpK29IUytENEV5OXFFK3NtR3QzY2ZFSzlacWdiTUpI?=
 =?utf-8?B?SUNqWnlJY3N2VVhXZ0hEQ0twN3VCSGltN3VrdnA3alJHUmxyb3N6bVE2UFU3?=
 =?utf-8?B?WHBXZEdqNTIyb3UrRlJXZ0ZXUUFFR0Q3ME5HakFMaThKOUdzSWJtVUZoYXFv?=
 =?utf-8?B?emNxOUNzOUZhZm12Sisxayt5SEFGUFRUbWdSRDd4aGw3ZTdZdnJLVzdJNjVS?=
 =?utf-8?B?dEVGaW8zR05RZkRCSEMzbVc3bE9rTFM2dWRlaGN3eFhHZTNCellVR1ViNEVm?=
 =?utf-8?B?WCtQcTd3Y29TSjJDQkY3end1QnRxTWU1bTJJMmw1Ynh0WnVFMHdURVEzeHE3?=
 =?utf-8?B?NmM0cTRiV2tUVzFucHdyWXBxNGIxbVMwUklnNU91RTMxeEFNRlYyL1N5OEsy?=
 =?utf-8?B?N3JNUUFJTXhqRnhkSG5DZ2w0QUpNdFJMbG1kVS9LWnpwWkhmQlJjT0Y2cjZB?=
 =?utf-8?B?WkhSOXR4TVlVSWZkMFZUYUtNVWFqZjBCZk5pTStrcGQwWVlCdEtzcTI3YWZU?=
 =?utf-8?B?VUQ3OTB1MnlHbk5WRlJkTHdwdVBwT1BtK3Q1a3k5ODNpZlhXcUV1N0pzeTJM?=
 =?utf-8?B?MWhoM05uR25uUTlubmh1MEI5UkdyYmNScUwxeGRxb0M4REtUSmZab2RvdnU0?=
 =?utf-8?B?TGgxV20yWHhSTDV3NUN6RHYrZDRuUFJoQ1g2Y2svYW1neWcvRXVJcE9qMTYx?=
 =?utf-8?B?VFZiTUE3Tm5kWHZudFUwUkRLMStoTDhrVEJkVHpyN0xwZEZlNDBDWWZBNmRV?=
 =?utf-8?B?VTBhVlNyQUhDMGNSK0hjTG5GbGNVM2x2OXNPZFNXWDhuTmwyZDU0UEdjajhy?=
 =?utf-8?B?VUN5am85THBsNGNNeS9sSEx3THdhNEVMR3cvQzZUZS82Z0dOa3hJNDhEdmp0?=
 =?utf-8?B?cThWY0JMK0k1UVF6d2RrcTVHZlVZY2hrdXA2MnRFQWFsdDlWOXJHOXVrVXcy?=
 =?utf-8?B?M1k4MkJ2bzFPQm42c1hvNHd2eitHSzVJUEN2aUdaR3BSN0xWQXhuOGtoeWZh?=
 =?utf-8?B?LzBFTUNVQ3lwcUZOQ3NXQ0VVTmJtVkRKZVlBQStWdDJGeG4zYVhhS3BlTHRj?=
 =?utf-8?B?VzcvSEhrMTJkSnMwVG80L1h5cHRLMEs0eTJmQ0JWOVNvSTQyVElBK1dQMEpN?=
 =?utf-8?B?bSt2ZzRXK1YyekZtUUhDcGxxMDUwSmFZTk5LUCtmc2xiaGIwZXQzRmlMZjJK?=
 =?utf-8?B?SVhtaDVsSmJjSXJRbmE4dFpaRjdPUjVYZG8xUFVnUzNhaUplUmRpM3lEeW4w?=
 =?utf-8?B?S3IwV3ZqTkt2MUlrQis1QzJEVjVUQlYzZmhTOW5LTlNkaXNFR2pPYmN3YU1x?=
 =?utf-8?B?SjN0QmNXOXpndngwZ1R5R1ZBd2ZVU2M5UllRaHg5dis0cmd2Ym1XaS9QRm1C?=
 =?utf-8?B?RklYR0Q0V1pXTHRZWnlaeVZJRzNiZ3dtVS9HNjliQ3RJczUrblplU1JqbW1F?=
 =?utf-8?B?RnVjQVl5NnN4b2V1WDU4ZmhsaW5OOStRclVxaG5JdmpjVnJrZEVTT2pJa09n?=
 =?utf-8?B?QjhhbHRPWlVXUVk1SzdzdHVGbzQxY3ZiM2NsNzdXVEpzSXZWcHdGUlJiaHo5?=
 =?utf-8?B?Qk5Rbnp2V0p2ejlZN3N0R1M5Vi96b2lZMlljSE5MeU1WUU5ReUg1U2FqRHFJ?=
 =?utf-8?B?UUdVcHVDMVhHaFlnMzFIVTRpWXNWSDVkd3JaV2l6bmYxSjUzNGlDSGpaTDV1?=
 =?utf-8?B?RFk4ME1ZQWErb1Bpc3ZmMVdzbGthN3BkVEcwY0VaQlVnQWRrR2VVMU9VaTUx?=
 =?utf-8?B?bS9VQkpSbnVuY09SM1lIVVhDZnIxVlZsUnhQWWJZT0lFK09WVWZxc21Xa3NL?=
 =?utf-8?B?dytselViZXRieXZVaEt4L1EvZkdwSWZNVzFnU1NsdGdCbjlQckFLZE5LSWp4?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c968e-6b79-460e-e72c-08dd1a193d7a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:23:06.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuM+lb53YO34X3aAA9WYOQbW7FHdAMgl8+g/B7scvOsZxOan5XPkI94sgZjUnof10VtRg37PRX5gHqpjK8bxxMd+spRtvgvfriEw4tVSKBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com



On 12/10/2024 1:44 PM, Nelson, Shannon wrote:
> On 12/10/2024 1:02 PM, Jacob Keller wrote:
>> On 12/10/2024 9:48 AM, Shannon Nelson wrote:
>>> There are some FW error handling paths that can cause us to
>>> try to destroy the workqueue more than once, so let's be sure
>>> we're checking for that.
>>>
>>> The case where this popped up was in an AER event where the
>>> handlers got called in such a way that ionic_reset_prepare()
>>> and thus ionic_dev_teardown() got called twice in a row.
>>> The second time through the workqueue was already destroyed,
>>> and destroy_workqueue() choked on the bad wq pointer.
>>>
>>> We didn't hit this in AER handler testing before because at
>>> that time we weren't using a private workqueue.  Later we
>>> replaced the use of the system workqueue with our own private
>>> workqueue but hadn't rerun the AER handler testing since then.
>>>
>>> Fixes: 9e25450da700 ("ionic: add private workqueue per-device")
>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>> ---
>>>   drivers/net/ethernet/pensando/ionic/ionic_dev.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
>>> index 9e42d599840d..57edcde9e6f8 100644
>>> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
>>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
>>> @@ -277,7 +277,10 @@ void ionic_dev_teardown(struct ionic *ionic)
>>>        idev->phy_cmb_pages = 0;
>>>        idev->cmb_npages = 0;
>>>
>>> -     destroy_workqueue(ionic->wq);
>>> +     if (ionic->wq) {
>>> +             destroy_workqueue(ionic->wq);
>>> +             ionic->wq = NULL;
>>> +     }
>>
>> This seems like you still could race if two threads call
>> ionic_dev_teardown twice. Is that not possible due to some other
>> synchronization mechanism?
> 
> Good question.  Thanks for looking at this and the other patches.
> 
> This is not a race thing so much as an already-been-here thing.  This 
> function is only called by the probe, remove, and reset_prepare threads, 
> all driven as PCI calls.  I'm reasonably sure that they won't be called 
> my simultaneous threads, so we just need to be sure that we don't break 
> if reset_prepare and remove get called one after the other because some 
> PCI bus element got removed by surprise.
> 
> sln

Ok. This is all serialized by the device/PCI layer then?

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> 
>>
>> Thanks,
>> Jake
>>
>>>        mutex_destroy(&idev->cmb_inuse_lock);
>>>   }
>>>
>>
> 


