Return-Path: <netdev+bounces-188448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB58AACD96
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8929898214C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7C286896;
	Tue,  6 May 2025 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLrlU3Zk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51119286889
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557870; cv=fail; b=E3aeE706HB3m/ZIYIBinDEbIc6AlAzmkunpDE1+6qA+vXjqeIckqgoe5N4w9PW5Rc/ZSP2kCfpXoqtcgO9UQBleqJpfaz4uyXIyl5UCfTVRsU+IugLaUVuHXs1/YY7yRfxDMj5hGg/UTOKk+OGpNhUmakKPumX27DRFhLarsDgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557870; c=relaxed/simple;
	bh=SsYUjXRGhi3rElc29NyMeEjJS0ojJnnxTQd4UEfmXIw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6ZcK6IxKeXBbqoBTuLFb6RA4csEOPxL51dd+YwvrzLoHJfvkrdYZblFkKPuDH9ev+5QNSNjY3huK0l4P6pxk8s4cH4SohLOswlZuI0UfKQ9Di/bmd2C/KbYHsicQ3FkTv6ooyg9jFlW1CuVeHaH3s0P7lfTeCJi42RNSrAIQgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLrlU3Zk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557870; x=1778093870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SsYUjXRGhi3rElc29NyMeEjJS0ojJnnxTQd4UEfmXIw=;
  b=XLrlU3ZkHtlBD4KmfCK1riryw/lQQp57sFZ/eSm7NVSGYEA4vmLnp6pu
   YY3K0jgSz/+HV17ODeglHxBH6i2oxmq7fIo5yCra/C/Gn/g+DxqewNMvW
   b6Fyt2V6oz/ab9X5T7BLGd5QLoCV8IkeKAkyMlNe5w2XuFiU+9s5cUwR9
   yjtz7UmDK/VS6pDv8e6e42N5prvEIifw0G/5J4df7CHjayRkjadmOjlX3
   uDoJTIq2HB+cfnaJReBTP7LTFc6Q8N6l+rzJAIeMpLnNPU7oyOmN040xa
   w6hzJ0WwVajLJmbvKP1dsSz/R3xCRD9fJ4bKRja4b8UrIufN51MbKBpuj
   g==;
X-CSE-ConnectionGUID: q5YtQgo7QGajFlomqY4dvA==
X-CSE-MsgGUID: NCqXTi+iRGib5FfCGwMgkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48332822"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="48332822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:57:49 -0700
X-CSE-ConnectionGUID: aG7aDWtNTJGewRXK/41xhg==
X-CSE-MsgGUID: 55rGYkraQwe8AUt/O+1LZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140668764"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:57:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:57:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:57:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvWSo9phnoGGQmszP0ZUQszzXJcf0A/X9wQTqA3my4mARbx6QuppFVnRurHAZo72Bm/xq1g8AFgv52TZcxoO5noXAldpu6IPKNB07o8xjX977JflafJbctW7+6xns2oAKxQgniqHUgSvR9zcHswQBUgLVaDlNw/eQp1v0/CIZzsIiQ48D3NZRF4S8FWjWlEi0uxQ+6abg5jsJZ855iRR4rcJdAIyZLHyMPY2HAlwKcf7Hhf0mFSmZ2TLoHbuQ2/Xi7mDHE6UnW7qkAYJYDGOBlxIf9thW0DGyw2UinEcQXKR7A10HnVFlkuhrsnaoPYAkW7UpJQcyJCB88hj8PsD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MXbk3vIGfz2wiI1nWc4gyCEDJGM+An4iu7ccFjbHdk=;
 b=bMtfdkqlYXnYyBuj41QRGimz2uDSqlZwRBsNiwV3KSPhZU+SBoBf81hox/ZsQFA6FkDa7vpdFBXfMqWi1PgToNzN1QD/BpzHsGIUJFHU4nVGDHeG3ThPNHYMJpru5dyL+Dzdd6zosqkrc4Y+aILoG5jSOfRaCpWVb3A6omtnjhAxi1eX2ossKpOcLBRAiZknV2w4kjLBPtWcHRXPdmdMH0G+suDTL9qCoIULmiXdWVSPZkaVk2ILkRtK+P835ezovoRCMWEDo+SUryqrK9TfQIbNA8EOzdcCVKuuu4PTLqsCYFpFv9iyRFawEQFZmbpysKNgwdSJqarOhPZBlJqggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPF777B3455C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 18:57:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:57:00 +0000
Message-ID: <ffb6bdbb-64f6-4be2-984e-3c8be185f62c@intel.com>
Date: Tue, 6 May 2025 11:56:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 7/8] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654721876.499179.9839651602256668493.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654721876.499179.9839651602256668493.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPF777B3455C:EE_
X-MS-Office365-Filtering-Correlation-Id: 414d0eba-8087-4dfb-0132-08dd8ccfc860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWlRVnhEaVc4YnNRRk10QWM4TUg3QWYyZFY3eTRzVXdYd1BCSzFrc3VkWU4v?=
 =?utf-8?B?R1ZDMlEvTEdIcTNrWkRXMEJGVTdYMHh1M3Bkc0licjlxTDgvQ3A0SWhNcWl3?=
 =?utf-8?B?NGlOUjQwRTlKS2RYS0ErdjZYeEloUGdvQjRBS1RxS1A2TEZxK0RraHladjAw?=
 =?utf-8?B?cTNGdU54eEpUMEk4M2xCSDJIU1kwZHNxSEhaczNLNVhiV2YrV3RERTBWeEN1?=
 =?utf-8?B?cklibDBaTUlvZWtSTXBRQjJtR3B4WTBXL0pwOFJGU2hmZFNTaFpYV3pZVHB1?=
 =?utf-8?B?L3JMNjFwQzI4ZEloZGg1bmVobzlvQjZFN1NXKzhTak9wSnlsZ0h3QkZSbWJB?=
 =?utf-8?B?bFBtQkFPcnc0YngvRXBuQkFWYng5U2VKVkFPMkx2aksrc1MrUkhaNnZONGVv?=
 =?utf-8?B?bmY4UEk3Sy9rRWJ3MmVtM3BNOXZ3RXIrVTRzaTlKNGJQdFBzOExyTENsNFBN?=
 =?utf-8?B?dTBwTENEZVZxM21lQkxnREVMQWJRTVR6QnlzY2hIbHJ0bkUwUllpZk9vamJM?=
 =?utf-8?B?Zy8vb3E0SEZpcGo4cDdVYitZSitobnhtQk9UN1NFRjJuT09hazdlMXdKc0RY?=
 =?utf-8?B?eG5HQWUyZVpKMnQ1SURtY2g5SjdUOVJCQkc4Qm41MXczY1F3WWhsaXZYd0lL?=
 =?utf-8?B?SGo2LzVLOVhlaFZYYUkvTVVGcEp3M2NhYU9DTnJwTEVSM0ZUbWZ3S01uYlA0?=
 =?utf-8?B?eG5MN05KcmFmWUZoUTduaHBla2ZyY2swd3VzL2FoOUJTemdsVHR1MkhwSmhS?=
 =?utf-8?B?azdpNS9XTEVXMWJSdmJIMU90V09RaGFiajQvNEFsc0dORGFPYWNSYnR5bTZl?=
 =?utf-8?B?cS9uWGhPcVdIUW01TjN3UEJpVUhhcW0xTFNZZWdzNitsT0xHMGFGM3lkQk81?=
 =?utf-8?B?cldjYkVxY0FRaVZ0SktHMGx3aHNTZVRTdW1LSVczOEVGYVhocFNTaXV6c0VD?=
 =?utf-8?B?Q3RUQ3YxSXExZUFFWFhneXZuYnRPK1BXbmZaVXowZWkzZUZCSmUzYVgwSy9B?=
 =?utf-8?B?ZmZFTVBTSEtPQnhoU29SWEltN0drS0dmZUhkb3U0QUUzMitHc3NmRWJxUjZS?=
 =?utf-8?B?d3pEb3ZvTzlhR0EzeFlXWEREbDlENEYxV3hWSDdjZnFwamFKcHE2Zy9OMVcz?=
 =?utf-8?B?ZjJubDJGMTlYMGlUd0hzZlo3cVJQTm0zd1Z3ZVQrdVBDRzVKY001V1RvcHlp?=
 =?utf-8?B?Wkdmc28vcVo4K1Q0ZUJLamxpMjN4RFNTd290czUyM1lFa1NNMG9UdjRGVldO?=
 =?utf-8?B?dWp1d3BoRHBXeW1PRTRiVzZoME9aN3I0UWtNT1o1R2VuYnZSYnZZQUJHYWhl?=
 =?utf-8?B?NkFCL01xYUtTRm1IS1NKRktWVnZpQ1oxcFNiOTZ6QXp0S0NXcVZpYkhaZU52?=
 =?utf-8?B?bXYvRTVYRFg3RVhXR2gzY0NQcWdDMVRuSFdwS0grdHQra1lPZ2t1a1NxQ1RT?=
 =?utf-8?B?M0NibDJOSHpYTHJlZkplRlRmLzhQamZPNCt5ODdybVlIVHlQTzJBWm8rSWtu?=
 =?utf-8?B?a1hkZGFWbXN2eUhQcURpbUF2N21rR1BKTDBFWWRRelVwKzRlY3pPem4vUnFV?=
 =?utf-8?B?MFRMU3ZXQTgzMVN3ZXB2TWkrSnRBelBLWDgrb1dVblliOS84aU0ydXNPUTNS?=
 =?utf-8?B?YmNCTEhKV0VLdmpDQ3FKOVJDR1NwRGNsN3g2UTdWajUydGhuc2pFVHFBK3Nk?=
 =?utf-8?B?T0V5TXNVWEEwcnlDY0VSSFhyTzdrUnJwMmMzN2RMNVB4aHNta1NrTjhNcDdK?=
 =?utf-8?B?S3F2S0o1N0RhblVmaXhNSDg4a1MyU3Q2NHdLaFE3d0p1ZDVaaTIwcll3ZVA3?=
 =?utf-8?B?R2pRc0tMYVRaQW1lWGlVa1kxNlhZV2VTd3lOYlJ4NXhMdGVkSk5jdEM2dGh0?=
 =?utf-8?B?UldIS0MranR3aVplNU80UlptNkc1a21hU1UyaHhJYzQ4dTVaUlBRVkpib1ZJ?=
 =?utf-8?Q?Og3A0MQ1S9E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1o4VzBza2dHMXFnUnM0TFNNbXlLY1JMRXREWWlCYkI1Rm1OcEYxWUFDZHVZ?=
 =?utf-8?B?Wm44QWxHdTl0MXNEZFF2SzB0QmhJSkUrZktrOVpkV1NGSUJFV01BZUJPRzNa?=
 =?utf-8?B?aUc1bWlpMjEza1VuNWFXNFRRSjRqSUdvOHhXaUJPWXBxUTZsWVM1ajFDTW9B?=
 =?utf-8?B?L2RZMFFnck1SMjlkREhNR0hhTTRGYWtQMTROL2VmQjJnTDFjMlNwbFphS0ZS?=
 =?utf-8?B?ZEZ6L2szMGd2VkFOZnVURTFjMGlySDZjYXR6OTRNNG5BK0hjNGRFWndQbzI1?=
 =?utf-8?B?SGNYWWtrbDA1a1pZWU9lWUVvVVg1T1V2Ly9sS2I5cUJoTGd2MmR3U096eXdo?=
 =?utf-8?B?aVJ0ajAzUDl3cy8wTC8vSTlWNFVucEhHdGE0RmNSTUN6ay95ZUFYMVZGd2sy?=
 =?utf-8?B?SVNkMkxTOUFOYXkzWXZWRWg3OFFUSWdCVEJnR29seU8zQU45NHRNVzZiVmRR?=
 =?utf-8?B?SFNsY0ROUmNVMU56dDFBdlBPbnlIQ29ER0t2eHVuTjdYeExiUTc5TU9zRWdM?=
 =?utf-8?B?SldmRXNRdlgxdVlZeVhVU3k0UWxNQUU1ZFp4STNhL1FBU0NMSkdyZUw5MHYv?=
 =?utf-8?B?ZEIrNjZSelhwZ3V0Tlg2TmRQdmYva2lld0FDNDBCSi9QVjV1NHlHU3d0Rnpu?=
 =?utf-8?B?UmtIS3hpOGY2a29pY3Q1eEtXMnN0Tmd1KzJPb3c5Y3FabEd6MFY5cmNsYzFQ?=
 =?utf-8?B?QzhQN3NJREd1dy9MVkZscVlQdUo2TnYxZFA5eWNRSHRMYmt4V2grNlhzTC9a?=
 =?utf-8?B?VWlLdUlzdmFTMVRwbFdrLzJmeHJnVnZZOXQrQitpWnNWUkl2eEdMTWV2K2pC?=
 =?utf-8?B?TitSUURHNXRZWHdBcUJFV2kyMGRiNzRPdHF3RVdjMHN4U25Sa2xOZmMyb3ZR?=
 =?utf-8?B?bDlaSW1kUmZXUlFGU2VQWkxSMGY0cE1xVUpvNWJRNW4rSXFoc3dJbWoyYk1j?=
 =?utf-8?B?eHB5dHhoK1Yvc05sQlBUNWJYME1lRVZlNGowVisyUDFFaHdaMVMweUVvT1Vy?=
 =?utf-8?B?NDNmL0tXZkMyMHZnNEEzWUQ2ZjVFalFna3RET2J2NTg5bDVhVGFBYisvTGls?=
 =?utf-8?B?S1h0MTdiOEtHTFpreTRtOGlpdXEvUXF2bUR4NVhrdTYzSTVubTdaRC9aejYx?=
 =?utf-8?B?aWc0QjZtZDdGODhlN3ZWTUtyTXBONDJHZGZQYnFiMmFxWDMwSGFUUXNIbTQ0?=
 =?utf-8?B?NlBNTnVIU1FDVjlFdlJtVnAyWWJnUUYzK0poODlmY3gycTJPQkZmNXBIcWIw?=
 =?utf-8?B?ZDRocU41dm9vNmNQbmNXYitObXV0WGhEbzQ3azBkTDVMOFhJN0VEb0xXUDI0?=
 =?utf-8?B?dzBsVWQyZy9sZWtvQmlGbGJLZzlKbW1xd2wrM01JTTE0eFV2eFg5MnZUREtZ?=
 =?utf-8?B?eUk5bDdDU1cyNzdmVlBBdk9PaUlyRi81aHBqMHA2Yk9YaGl1S3cwSTFSKzhp?=
 =?utf-8?B?RTMrUStpUEUxVE51Wng4bG1NNlZDNkpaZ2lUeG1pNmlXSUpwQm1GNGNqWGln?=
 =?utf-8?B?ODZnQkhyd0l0K1RqQkUreW9STjhVUUQyRCtRc2Z3b0VsQXRoOU5TWGplYTRV?=
 =?utf-8?B?c0w0M2d1cGdNZytHMzYwZDh5dFRKczFZYmV2UG5QOGx1NmlISkVxZHZwVWpX?=
 =?utf-8?B?Y284alFiRTlnN2V6Y3NNdGlMZEE4UGYyZk11OExzbFBNNEt4cGo0ZnlkRkRl?=
 =?utf-8?B?RDRsNGduWGNRVHBkZ3lWbFZ2SkRCZ01rS0ZXc0k1SzNIS1Z5aGMrNVUxWCtz?=
 =?utf-8?B?ZVBuQzdJVzRibUUrOWxvWEZVdWg1MGlOMk5SRUV4YVJBajNKNjFBWThpUFRV?=
 =?utf-8?B?UTRSejJwWi9YWXJoTytRZURYRnNHc0hhYi8rRTZGbmJFV1NGRWpZbDBIa1NP?=
 =?utf-8?B?YnRzdHI2bmtWQkJiR1hiWVZ4Mk55bGJrbEhGcnZ1MVBpdjZTeEpnTGtqVkRL?=
 =?utf-8?B?eGJTR1JJU04zV004eE5XYzdoOUEyQnMyeUxMY2RUaUppRWIxeW5RRnp4Ym92?=
 =?utf-8?B?OENhOVRPN0l6YW8vSnUzaS8wZ1ljcnIzbkwveUVwWVB1bkt3UGhwQzdIRzVs?=
 =?utf-8?B?bVc3dEx2UXE0Z3lIMjczZUZJUFRWdTAraWpxNU56aTVCOHZtaVpOYTZ6MVh4?=
 =?utf-8?B?OXFxOTBURTNiWVFKTnhiZ0tYdnU5bFNoVm5GU0s4c3BJaXZTT3FrNTBZbG9s?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 414d0eba-8087-4dfb-0132-08dd8ccfc860
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:57:00.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqkM3mIqcj5jdO8tZNCrCgu52xYG2qovVB6cjBxVi4RxWWnjhmZ+IScfFNTN5uuzW99/n0ltAzNFJ5dkejkPFyRf0QmlpIi4Xsbwk1gR26U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF777B3455C
X-OriginatorOrg: intel.com



On 5/6/2025 9:00 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> This change pulls the call to fbnic_fw_xmit_cap_msg out of
> fbnic_mbx_init_desc_ring and instead places it in the polling function for
> getting the Tx ready. Doing that we can avoid the potential issue with an
> interrupt coming in later from the firmware that causes it to get fired in
> interrupt context.
> 
> Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> @@ -393,15 +375,6 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
>  		/* Enable DMA reads from the device */
>  		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
>  		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
> -
> -		/* Force version to 1 if we successfully requested an update
> -		 * from the firmware. This should be overwritten once we get
> -		 * the actual version from the firmware in the capabilities
> -		 * request message.
> -		 */
> -		if (!fbnic_fw_xmit_cap_msg(fbd) &&
> -		    !fbd->fw_cap.running.mgmt.version)
> -			fbd->fw_cap.running.mgmt.version = 1;

...

>  
> +	/* Request an update from the firmware. This should overwrite
> +	 * mgmt.version once we get the actual version from the firmware
> +	 * in the capabilities request message.
> +	 */
> +	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
> +	if (err)
> +		goto clean_mbx;
> +
> +	/* Use "1" to indicate we entered the state waiting for a response */
> +	fbd->fw_cap.running.mgmt.version = 1;
> +

Curious about the comment rewording here. I guess the extra information
about forcing and the value being updated to the actual version later
isn't as relevant in the new location?

