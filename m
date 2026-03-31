Return-Path: <netdev+bounces-273784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOtoJd5UzGn/SQYAu9opvQ
	(envelope-from <netdev+bounces-273784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D45372A0B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2926C30037C1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12046AED1;
	Tue, 31 Mar 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpLReFcr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9C46AEE2
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998354; cv=fail; b=bduVSuKfDlyxh67d3KQkzvL4mxWx7SloGH+wJ38ossuJTEt+Rg/3HaKxoz3N4Gl45ima73GvCxwcgz7OGGd7fjaj+sXvkRuqFsHIRPWDwxcBgnLDJr+hR4n/OnP1KSBiZnALfL3I7tMSOhJQ/ZxfLfBFK+ECl+YGC9GGJFY5qG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998354; c=relaxed/simple;
	bh=A6MUTLSwg4XLfdM6gVPCDU4AI+GIz5wRvxpH+sOz+ds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMLUoP4yhf7cq1/YaTcHUPLvMGcqO98zcGlKd7kR3zke/LfFTIWNZXvMAFWWXh5l7/2GCnw/Zsng1VLBNVHVZ/Hf4nAKofHtjnYkyM5ERTXdcW2BTXoTh3e/qFc+5ZfRX+Pq0GjqdX6wnWbWyuzuOrCrlxxB6OnRQFyxQRwAavs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpLReFcr; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774998350; x=1806534350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A6MUTLSwg4XLfdM6gVPCDU4AI+GIz5wRvxpH+sOz+ds=;
  b=IpLReFcrG7CeF5t4dg2v796rSNeeKQviK9ZJAPqJ8i8Mw/KTIpMmv7g8
   w6H3I3ml9X5/Hfcg+HhDTsmq/9RreTUB3uWM85ZY18/ZRUKUHwUAf6IEW
   UqSE91t4dNJkKx/3umegsb+J08NjLHIb4CYkpuH4vdehF9uRh77thJ9Di
   99LToZjsOJ4e2nUqp8EsO8E8upAhG+ExrLvPgLD3DpNfDbJdmffjCHqym
   Z0bc51mjPnXsqDVSxUO60TncIEz/OMMVuS+7rwijczfWtNBlqsJUkFUaq
   MEEtCSdS+bU7nvs3BduSMHxpfFwDRZbWqKQ2uzu3dtzsozEedAD4rpFi5
   A==;
X-CSE-ConnectionGUID: QKAFp8vXT5KQYIgPlFQPbw==
X-CSE-MsgGUID: UDTvdEzmSdCgtxIOhI71aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86642530"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86642530"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:05:49 -0700
X-CSE-ConnectionGUID: 5ZU7WTn4T8ODuK0qN3QQWg==
X-CSE-MsgGUID: wWTlb0mTRhyW7yCwLxe+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="222109899"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:05:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:05:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 16:05:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2/ewf1BMxL2/sGmvilFDpXIMdJCZXIky4yF++oG2/sdYfxT3ofgk+y+3AcntPOgllMYjMRMPtqNnnqHjUrYFpfU0jPDtCUaweqPPzfbIlQmv7i4qU885Igmt40MOiGydsEBSF+U0Wq/ZH29y1/73zNj803qz0NNtlowV5FVZmDmUpdrUOSHxel6PSdaoNVfCp3cYHKDMDi0sH0PNTeXDt1Vw9m5XJe//wHKDKSe0u7KMYtCiLT37ICnNyhNt5x9pMl4dSFhN3gT+Fq1OyQpF7vWJfsJx9V+MO0ttA5liU32bIhzr6d1gONB78WICcziJ07yxBaIu3eRlFbs9jHldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlbv37PjruIhdnbS2iqszUunCEuXlFosIKYqYSXxj54=;
 b=X+EYCir0kJb+Vpy36miTLpOwgc6zV5ec0KpSUb9ZMOWfADIuLOATsjWSgmJ3D/doxc8WpYLEyQxh+FeIwSsMNliEsUOsRaX2NeoBlP+OYiTYQ8iEfAygtaFpumP36sQC9QUohAVoexDljnNUxvLQqFFnMDiXNsoxv/H1li2nAP6nhQ1BLTYPq7eenumbxqa94nEyDLxika9ob+Chz1Z6XoDE0fNuBKWlvR2izwMM2uC7P9sfmucDd+J7b87wDYu6y0FpkC2NmdUX0BtTJm4/4maKZmIYcrwEcHDDpLhpo80HxQp/TSKQKfCbtB2Jmuc/AGitfX0jBVDRi1p8CUZH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 23:05:44 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%4]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 23:05:44 +0000
Message-ID: <990c010b-f716-499d-b3ca-e8296003c37e@intel.com>
Date: Tue, 31 Mar 2026 16:05:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/11] net: ngbe: implement libwx reset ops
To: Jiawen Wu <jiawenwu@trustnetic.com>, 'Jakub Kicinski' <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
	<horms@kernel.org>, <michal.swiatkowski@linux.intel.com>, <kees@kernel.org>,
	<joe@dama.to>, <larysa.zaremba@intel.com>, <abdun.nihaal@gmail.com>,
	<leitao@debian.org>
References: <20260326021406.30444-5-jiawenwu@trustnetic.com>
 <20260331005527.3459556-1-kuba@kernel.org>
 <073601dcc0de$a87b2e30$f9718a90$@trustnetic.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <073601dcc0de$a87b2e30$f9718a90$@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|PH7PR11MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c1c105-4a02-45de-16f4-08de8f7a093c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: uanhUE5fwWavv8nJkkHG+cdrpirWkE7pYbtTy7CMAfLaGsGauPsU6XOBvxdN9xFqIT12558i+eyOY30mkjrDkN6vIr9gcpnMwEtAk3NszRl6txhuRgqDVU3nYo90UckJ7gl1QWSQHi4epotzDpngentDCNDUJPSta8GnAJYoTLul1/3YUrZ0jtWpimxBLGgW71Gy3ZH1z7fuVlCH9O0uBWq+6kkAn9qpTUeApaUX/+K1OkGN1ntVs3Wyv4gZbyKYym4yrQQ5/VXKoGfCa8oGVCQ/pRUhyIos7q5ERvldmdF4DNRkIXwVemQ25av4Z1h+pOoU9PP4PYYjUMkaNCjplL89dug9skyWpPpmC2VF+1A4rDo22luqBNd0WmwwZoqyzw1ET6lInwBDeu9nl33KfZw7VpoDTQdVzp0sYvE1ZjZF5JbSNea715vJChqYYOCzzcRiFjivHk8cDgXBHGgz7qzDv1MwCA0YPPl+OS1u87JCDiMzUVU0Bb/j1k1MK79saojKQl6wX4JaQHKeQmz8qAVB8B2sJM1uvg6uZgVXGEm/z37WXhwV3cHcu+esEutLYcCKMh9ATFlBCCvA2fx1wM+89TMtJ0dRhGfPx01UtrGOCrXKtKigac+sUXsO1fxHEZf88WPuYJloJiPXu6nmeqWYkqyXjiYB0ZO7Dx0CF9ajP7MrhVNLgrW8UyH4WQXuFWTWOebBcI5oJQVkZU4gDFVRx0l6vhoUfBVx6ojiSNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEd4S1pPRUtIVktkY21tTzVtQkorNVdnNVFjTWdteDFFTUdIcDdpVUc0KzVV?=
 =?utf-8?B?dmZGOCtpeGkrT1hVMS80UllSQ1htS1dHUDM3WmNabGlGTHkzNWQ0ZnU4VXFn?=
 =?utf-8?B?eGFQa3NsY2hNUE9jZlp1WFFtbDlucTZtRXV2K1NCT1cxRXFGS0FhVW1HUzZw?=
 =?utf-8?B?ZWJLdDE3L0dTWGVHLzdRU0xZRVV2WEdRUE5idDNhQzlLUTNRWnphS0FwT1Yw?=
 =?utf-8?B?QjJpUU9wS3BEbTl1bytrSEcvTEZLNEFuWUZQUWFwaGd1RUNWd2kwcDU3N0pP?=
 =?utf-8?B?dW40QTBUN1dNaHo1ZERMeGxmVUxDMHVXbzdMeFpzZ1hLU1YzK2xmV0VLbk5M?=
 =?utf-8?B?M3JuYTRvamtPaHJuOFZOQ2NJdWNJMUFqb3dGQ1FIRzlhWmRXeVNtNWhYZ2FC?=
 =?utf-8?B?TE9zUW53K2tUS0xCN3JkUnpYRVIzV3E2UGxNeTlUaXhqaCt3aUQ3akh2ZFVG?=
 =?utf-8?B?U3FHRi85bFRRajcraWhwOFFHWVp3VVJ6d2dIdU1vYkc0dzFnU2hjZGFTSmlK?=
 =?utf-8?B?UkJTUDFaNHdqSFZQUzU3YTdRa0Yyc2V2dTk5a0Y0dGQyWVh4Zk0wVURHb2FT?=
 =?utf-8?B?aE5HVm52cFJteEh3YWxlVWlZSytQL0s5dkJrK3ZSWXZlVlRxQlU0Z09aZVB1?=
 =?utf-8?B?R3J6TmV6ODg5U1BIaFdmMmtrZSttdllkVFNWRlJ2Mm4walFSbDYwRDFTQmp3?=
 =?utf-8?B?QXhBUXhPdG1MMmZUYS9EWUVPeFlxR1Y4cmNrUzliVDZmWmliMnY4SExJYVVU?=
 =?utf-8?B?VytEeDBYU3RMSnhBaFhtOC8wL3VQbWE1ekVCNXJXV3F6T1l6UGJSdWJOK3VF?=
 =?utf-8?B?LzZ2RCs3MWk4ZCtyNFkvYzUxUUdLYUttWVlUa2dON0VFVDBGQnZqNFdaRmhF?=
 =?utf-8?B?MWlPTG9JQytJMGJuSFhraVUxd012T1dVNkI1eHpjUnJNcDJDVi9qT1RRSHV2?=
 =?utf-8?B?VHI5UkVZZlVncEMrdWF5N0xzcEs0bDVWWS9GSGdnbHFBbVBKUDZ5eTF6YjR6?=
 =?utf-8?B?a3RyQzYybERPTGR3ZklJRzZSMHdHSWVDQ2JEZ0UwaG1aWHVUZmJOWVNtRWtG?=
 =?utf-8?B?VVJIbWhaaFhNVEtXdjQ4WUtVYzIzZjQyWGVqVy9XdUZhOFE0RWZ0RGdaL2hB?=
 =?utf-8?B?WlVGa3pJODFLc0JobXN4MEZ1ZXlKckVSUUs1YjV0RWFVRVZaNU5Qd2dYVnVz?=
 =?utf-8?B?c05sckpXMlVXTU9xdHlWamt0aTB4Ty9QTTRwUlJIajBHQmVnOEdiVi85Q2sw?=
 =?utf-8?B?dWd5KzhHTXAvczZNY2VRZ1g2T2RrNFBRTlZQTkJxOGVxdFlwdVlTMTIwL0dG?=
 =?utf-8?B?eWtKUjdHdU11blMwSk14NGFjL08xQnpkZTV4Y1padlhCV1pLUmZYWUo3OGRN?=
 =?utf-8?B?QzNFMktqY051QWRFQW90Vm90WGRJS3hjd3hEN3lzYVB4VmU4TWdvc3Z3emhj?=
 =?utf-8?B?UDNDdHNZSTFsMS8xN1VLMzhEdHhLZ0VUY3U5aW9QVUVQeVVmOExQSUlLeEEz?=
 =?utf-8?B?bFdYeWxzSWR5Ulg4VFYwK1VGZ1ZaRW9vOHM0ak5kQ2xQQ0JVL0pFYS9yWFZC?=
 =?utf-8?B?bURmLzJTZ1dOdGEweXVZNWx3cTdCOWk5d3dwMlJpT1ZPbEpKeDFkL09Sd2N0?=
 =?utf-8?B?alBnbk1jR0lqMnExb1JjSitLRFFtVnRGS3o0NTYrZ3hiNW9ta1RyNEwzUFNS?=
 =?utf-8?B?Znp3RVlDS1BwazNLTUlJNUVtNE9BRTlqUUNkQjRxSGFhNHk4UkprVmF0RTVj?=
 =?utf-8?B?cGxkZWhpN0dJa0JCbEkzYWFURk5ZV1hMMlZpekdpV2tna3N1bEVHcElnU2lV?=
 =?utf-8?B?NWErVXAxNkZ3UWxhazVRdHlmNVBVSjdRK3Y4VFVXcGZUb2p1SlRZNG5VRi9W?=
 =?utf-8?B?Z0NMa2Q3L1NsWGN2SXorV3BnWEhQcytPdmVJZ1VHMGk0MVVVVlpUVktYWkIr?=
 =?utf-8?B?bkF4d3NJMFk3dnJuMzArYUxlR05tMU5pNHQ2RkVJUkNFRDM3WTF3L1NHVnhn?=
 =?utf-8?B?WVN5MTd0Vmo5dE0xTzRwVXRBUE01eUk5VXJ2MW1GRHVtcUNIL29GdnlhRGly?=
 =?utf-8?B?dEI0RjNxcWRxb0pBazEvTThKS1pzbTE4WUxFbVkyZk5hQ2dyc0dGVzNrazJ6?=
 =?utf-8?B?OXpYWklrdmdCVXNGdlNzT3p1Nk5XelIyU0dPQ0h2eUF1MjFwNndoNkJGd1pv?=
 =?utf-8?B?RitnYktZaVh6Q0dWcFB0dVdaQ0ZpcWtPTm52Q0puTDBVNnMwSUwrNEdwL2JF?=
 =?utf-8?B?c1BaTitBRzZtZUp6MHZvRTUzZmoyYVNER0NkZTJDYzE4TXhCRkdsbTdFVnVO?=
 =?utf-8?B?R3dQU0dRS3NaNVFTVFV0UTlPUmxFZkhlenRSWXB1WFhScUJNYkh3K3J2YkRU?=
 =?utf-8?Q?zPV4MAqaR5L3qrBY=3D?=
X-Exchange-RoutingPolicyChecked: pve2T/DtNwJMPAIvuu7EJGsQ2U3Nf3Stlh52ST5wkJqsLtxR6sOarexXIEJ/17dd01PcjDwZmnQa4qYHnBfh85hElS8BV+ejknI+M8HQKBHu34R9dmKKyI/mpGrrhYriLBhvx9E0A8zrTybhhq8xxAiAUT8oipqMPYeGfznCP+3/7rUnm9Dny/c0KZ0LSbEaB+Z8bZSsur7oZhmqEc8VNAuB5yN6BVlRBjeBd6XnviPvhBwOn0RD6+iwWh3Ga9Gki2mzCKQ1siXJO82cYXc57qx8hKLYqm8C1K0HEoEXUDCsodCZLU3OX0vrCex9E6rilOqb3ll8mK5ODvfYoF573g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c1c105-4a02-45de-16f4-08de8f7a093c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 23:05:43.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlfHJGUM4igfJCsvDfPRBb8PDJpOxlouEX/8GuhpEserphO46LTbMVzoPesvJ4tOOq0jeUDExXt2rrCo7qjTpmDZfGBsVWSZe+uZYWobKKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273784-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,linux.intel.com,dama.to,intel.com,debian.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 04D45372A0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/2026 12:19 AM, Jiawen Wu wrote:
>>> +static void ngbe_reinit_locked(struct wx *wx)
>>> +{
>>> +	int err = 0;
>>> +
>>> +	netif_trans_update(wx->netdev);
>>> +
>>> +	err = wx_set_state_reset(wx);
>>> +	if (err) {
>>> +		wx_err(wx, "wait device reset timeout\n");
>>> +		return;
>>> +	}
>>> +
>>> +	ngbe_down(wx);
>>> +	ngbe_up(wx);
>>> +
>>> +	clear_bit(WX_STATE_RESETTING, wx->state);
>>> +}
>>
>> Is it possible to use a standard kernel mutex here instead of a bit flag for
>> synchronization?
>>
>> Looking at the underlying implementation of wx_set_state_reset(), it relies
>> on an open-coded polling loop:
>>
>> static inline int wx_set_state_reset(struct wx *wx)
>> {
>>         u8 timeout = 50;
>>
>>         while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
>>                 timeout--;
>>                 if (!timeout)
>>                         return -EBUSY;
>>
>>                 usleep_range(1000, 2000);
>>         }
>>
>>         return 0;
>> }
>>
>> Using a bit flag and a sleep-polling loop to guard a teardown and bringup
>> section acts as an ad-hoc lock. This approach bypasses standard kernel
>> synchronization guarantees and prevents lockdep from analyzing the lock
>> ordering.
>>
>> Since this context is allowed to sleep, could this section be protected by
>> a standard mutex instead?
> > I think using a state flag here would be better. Because other code
paths
> (like watchdog) need to check if a reset is in process without taking a lock.
> 
> 


Couldn't you use an atomic and a mutex together?

mutex_lock(wx->reset_lock);
set_bit(WX_STATE_RESETTING, wx->state);
...
Mutex_unlock(wx->reset_lock);

Paths that only need to know a reset has already started can just
test_bit. Paths which need to wait on reset can acquire the lock.

There shouldn't be any issue doing this that doesn't already exist with
the test_and_set loop, because you can already have a path doing "if
(test_bit(resetting)) exit" flow would still potentially begin executing
even if a reset already acquired the lock, it could have ordered the
test path first regardless, so you already aren't really guaranteed that
a reset won't start until your operation is done unless you hold the lock.

Using a mutex also gives you lockdep checking and is generally more sane
to reason about.

Thanks,
Jake

