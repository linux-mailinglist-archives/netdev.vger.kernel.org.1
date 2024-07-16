Return-Path: <netdev+bounces-111661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4E932036
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED17283E84
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759C17556;
	Tue, 16 Jul 2024 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbSIYVzz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8518029;
	Tue, 16 Jul 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721109196; cv=fail; b=R1hvolDpVi6KJN9F6cVTKbTN7VmW+8JM8jmvUPtuXTTxF1sNRMrs8D1W22oKmGvehvaY/RoX79EPX7b4puFOxiBJpbWQ6DimqBbdlF1JJ4pfVXxeocmAnHtGMSTIYfdNRY8apuvrY0iEH+ocy9SCwOdpN8fC8qAC+JzCiD2+8Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721109196; c=relaxed/simple;
	bh=ADGT0znT2U9O8/++8OFPnglODzT87mJl412gOIy4J2M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFTtmOpIHtuD/yvEsGK4uZvEJ9mxIBP1oGeBhvgfkzcsypYrEeIWoOe4b5gpbOK5xZhTlGRQHy8p5B3Zf33yx9P1/yaMeX3lk/WJpeXMtJI7Dmqxb2anad4D2zH80sgJ2X4MzigQPYue1D5mI7Y2HkEOhrRcLBbJYEG/k7zf/rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbSIYVzz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721109194; x=1752645194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ADGT0znT2U9O8/++8OFPnglODzT87mJl412gOIy4J2M=;
  b=KbSIYVzz2sxG80ealYYkbm0yCPKoeIH1uj/AuFyCAzHFUckva+t6v6s3
   spKzklsC+nIlKBrAkYDDHJ+NRK3ePZcO5EOyqNzYfUsHT3nDMGSYs1amk
   /gZ7qlq6q+fZnS7G7ahaWINHZn3Gi4e1F9pq0XwxvPUYo/OADklV03Ha6
   rJJBrkIoNbPVVt8v8uAKlyjsiqIFvRDtxMR8N9UTOpW+lEX3mCRdmbjD5
   bH4r8TtJGFT6J3iCGsjKPqr+Q4bLcBLyq2J6zM4ijr6u4khS/q+B7AI0E
   qmzNHKZ61sjLBB2rbR35tGyvuMFfXpLbTGVi2oHMbwsTqOoo94OWpYjQh
   w==;
X-CSE-ConnectionGUID: +O6XdhJzRC29f6h0BCJdOQ==
X-CSE-MsgGUID: J3B8uTViSzC1DqMe5HXO7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18717321"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18717321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 22:53:13 -0700
X-CSE-ConnectionGUID: TpeEj1uySiGZbnLL7Q9u6A==
X-CSE-MsgGUID: NTr/GZ1CSsCM/32MIsAcZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54239917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 22:53:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 22:53:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 22:53:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 22:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHTznROV/dHtTCUbgRETW6fXG2gaOIYxFsUuTUo/3w3X3LMghCb0a+CZ/07smT26Zt1PPhsUAXwPrzVF2KFeFNEpwBgo1t/AAeBVLDdY49eMgqw56SHo9hEdpZlPK5NlyuQkabb46CDHy0wHYDzLyQFWB+fe/VgqZftQgFXlCzQLxa3ImEj+TkdVBM9scyI2oPAvq9v06K0yX7zsDnNYcYzB1BpEJMptB6sutH+9u/Y31vLBvG+Zxoe7OtsR8fwkaDEqR6v7IeuFgmwbg4VFsrmRWrIzti5SSLcykVAE0zNZfopR3WwiillqqED/coJdH+FQcAuFZlLY4SLxDnP0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq28jS6NVqNgxR9mcQIPhrZgnG40HnlQ9UgJbKqjsSY=;
 b=v/1qRFsH+u5f4vbSew7PlX9P+vCIjXadPq8CDChzt+eH74NA/1MMYCERTz60y7bhvvSxt4vfkK+y2rhF7KQgc/U8c7yM4zhEF4uloVGhZYcB2DWRLmQnlDa7kBW++3jsyOTLkTG3n0+plWX1lEpUx+BHnY3Q+RObYxePlWnr1xDbGpAF346isvkJCcRvG28jDtG4scMg3gad0eWZk2SIkOd6aOQHs69uvFYZdJaM/h9j//V9Id1DPswCX3KEvUM+ArtJuU94mBV0Urzvzin0ar/qWYPooaNd4tETkMtKPe4XBLB4VQwMHvWCvzGHHn37aTAFPdgt0lTxlY4K99OsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SA1PR11MB8574.namprd11.prod.outlook.com (2603:10b6:806:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 05:53:07 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 05:53:07 +0000
Message-ID: <b2a99894-9c20-49e2-8c76-6e53aa390d9f@intel.com>
Date: Tue, 16 Jul 2024 13:52:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SA1PR11MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: c67394c7-500f-4bbc-251f-08dca55b90ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtHSHhrU0lCTWx2cHZJWkdpWHBaWXUxeVlRUGZaVjRvSVhoZVcySmpoOUJt?=
 =?utf-8?B?anNQTDhscVIxSk9NZFVmQTVtdlhJSDJnZFVKaG56ck1WWG50TUZ1UENkc25Q?=
 =?utf-8?B?VDlqeTJoUnpsQlZVUFNvT3N3cVhoVlowU2JOVmoyMkgrS1hSdXh4NTYzdEh1?=
 =?utf-8?B?NVY4SU45b2lJN1BuRkNDUWdma2ZxTmdXRDdXUjd6Z09heE1NMThwMzJOQklP?=
 =?utf-8?B?QWxSS1JxUDNmcVpockxzWnB6NytwM2xWbUdmK3RvRVZ3YXVYQTVZanVueHY1?=
 =?utf-8?B?UWxRcUJlK3pad0tuWS9kUUkrTDZDNFRQNmE4Q3hveGFrZU5jczBqUzJWcVI4?=
 =?utf-8?B?SW5pSlkwUHVzSk11QUNtbHpGR3cweWpLQnM4L0NUY3QxcnljQXgrR1ltVlhJ?=
 =?utf-8?B?VGF5UFJmeXc2NDhvSXJJNmVaOVJ0MHNQSklCcVpHM3BoZGR0eWZPeTU1UVF6?=
 =?utf-8?B?Q0JVUVRSMUJSV3RUZUFveEpSNkpwNXkxQUVZb1JIbVc3aS9EeTNrWDRJcmFt?=
 =?utf-8?B?cUttcGJ6dGU4MndZV2RhVUhJcUpyOGI1SG9sTi81NzVRYU5qaGVzTFBIUWNB?=
 =?utf-8?B?M2plbHFZZStqL29UNWJEYURZV3NKK3Q1clpLa3dUMGVUeTlkYkRrY0hxVDdx?=
 =?utf-8?B?UUJpSGp1MytTUnpPTVRoeG00dWFVeXNpZURXOTlNdS9YSmdLdENiZ1pMOVps?=
 =?utf-8?B?TkZRMFArUDA0V2M4UWU0OUExanRBWG0xQWpUbkpqeDRZeXRtZEwxaitjVTNM?=
 =?utf-8?B?elpBZXlhTDBnMjZRUURIM2M1Y3M5NTByM3RCb1R1UjlzSXRmS2sxKysxSmht?=
 =?utf-8?B?dVF3cndzbEpqYnZuUytWNWZOdWtEcXN2UGxFVzZQQ1JIa2Z1VERJVkc5c1RN?=
 =?utf-8?B?TWZWcGdHNDVZY0dzMDIxU0JZVWM1Qk5wRzZJekMrUEVoM1c3dXc2dGNpZFBx?=
 =?utf-8?B?WDBlVWdXT0V6R1NEYU8zbzdIRitHck1LZWhhZHhBVnpOMVE3OUFzakJBL1RX?=
 =?utf-8?B?LzNmcVFpcGVvNmNyZGNUazZTVWFwVmx2N0N2VTNNK1F6b2dEUnJZSFkvRTdH?=
 =?utf-8?B?aTB4U2thK1hCMkt5VGtwMkt3T1JsSTdZS1g1cWJ1cUtmdCtuL292cy92YU1j?=
 =?utf-8?B?YlY1TGNpMzBuVFUxWE9hd1lHUW1NRmJ0SW4wb2ozY3RGL0N0WGd6bkxRRWxm?=
 =?utf-8?B?ZkZENmNsTUNNeExKRjF6cXBFT0cvVHBFNnVrTUZ6SXZFTmU3Qy85bkc0Ykow?=
 =?utf-8?B?L01xVEdVUVlNLys2UEtDOGFXMUdKWUVOVVdDM0x2NitSY29Sc2F0Tm9RMmVI?=
 =?utf-8?B?UFVuZExTWDB3SDZxZDRQT1VtTFV3SXdDQjJJanZkOGJUdml1MFRyeUdqN3Uw?=
 =?utf-8?B?N1hMQmpoalhKdytSZjNqcGNwdkdxN2pHbzVLU0crY2ZPYUNiY0JzZmFyb0JC?=
 =?utf-8?B?Wm4vOHpvTCtHQW16cVIzZjhSUXdPOVRtTEpNTXJHaDhSNUdXdkI0c1VWVHRq?=
 =?utf-8?B?eTZlU29tVy9oVk1jQ3hoYVpuejNXcWV6eXVEUEZ4VjdwblRUdC9oaUplRXc1?=
 =?utf-8?B?ZDJYaFdGL0M1dnFNQVNNeGUzVStxc2d1Z2tXWm05bUt2MzRlNmJJSVE1cHp0?=
 =?utf-8?B?SW5TVlpoSVpOcnc1WHZkcGVLcEhUNWtKM2lYZVVJYm1vbStOSmVnT3BPTm5v?=
 =?utf-8?B?UExwbXNTZjltTHY1YnJNYVA5OHJBYUdKYlJvWDN1UDkvNEloa3dZOC9jSllq?=
 =?utf-8?B?RFZXZ05EU0U1enpHcjhpdUNGaE8zTm84eDdWak5OOGVBOFlCMjdXM0NnZ1R2?=
 =?utf-8?B?WDc4RVpNalExMlZPZEZXZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1psS2VvS1NkcWcxRjBNdjFRUmhwbHJBSm1pSmxXT3FQMk85SHhGR0w1anhN?=
 =?utf-8?B?WUlMaUYyT2UyNmNNRnJ1Z2NtTW9pMjBtRXVTT3YzcXYwMlRZUktNeHUxWHpD?=
 =?utf-8?B?OXo0WS9hN0FBSmMyYmVWbTVsQk9rak91Q3lQQjlFQ3ZZRHk0Q25wL2c5bFdz?=
 =?utf-8?B?KzllT25rZGp1RjRYUnMycjBXZ3hOUlhxSnprM25ZSDNnUVloaFd4cXNGcWxI?=
 =?utf-8?B?OWVCRnFHK1R6bnY5WE12VWRjSEUvKzVnR1VlRUxpRFExUWV1R3JiUlB5K3h2?=
 =?utf-8?B?WDRIc3hNL0ZzMHZ6V041cGpXNm5RN3RqVzlta3lJSUVZekN3OVJ6WkJVSmpj?=
 =?utf-8?B?dXNQN0ltWW1ZUkgzNmhRSjEwTHltUjZLbmFabmJ5dVdubWFEYlpMM0YrV1Zi?=
 =?utf-8?B?L2ZLWGxZWjd2WWk3amJMTjVMcncrTGtQa1ZEdFBnWjRvbm9rZ0pjRHBvVnlU?=
 =?utf-8?B?TS9NS0JrSzFaaHRTK3FXY1B1Nm90WmtaQ0hiVDlvaXI4dlFKRmI2Y1pPbXJa?=
 =?utf-8?B?RE1kR1pCaDZNd2JhVGVpVFpaTkdnLzJOYWhIUGx2NDZtSkxsVkxQMnpUSHdM?=
 =?utf-8?B?ZmVsVGRGZjV3OEZVaG12c2VZell0NzZyMVIrTzFBdldSOUg2T0VnQmRyREZx?=
 =?utf-8?B?WXZudDF5M3JKOEl0VjlyYVNScW4yNEthRFJPKzlWS0x5MDFCb3VqdlBOY3Nt?=
 =?utf-8?B?YlQrZVJSMmxXd2FUYlRXU3NzZnY2UHl3WEF3T3NIYnJIUXRlR1lNMm1vWmZ3?=
 =?utf-8?B?a3hSTk1rUmlGbEt4Um9pVUtUQ01rckxMNUh4RExvczREQWtLVHlpdUZLMjZK?=
 =?utf-8?B?TkZ1NURvV3l2ckhtdG5nZTFOWXJja21vTEtxb3Q1RGlXcEpXZEN3OUFoK2Nl?=
 =?utf-8?B?eCsyVlAwTWVYN1h4QjlxNmpCMHUzMldSQ3EzT2tJalRrRUJ0T0E2TEd0TmVt?=
 =?utf-8?B?RzYyb0tsNTFSWDVMdnZSVWFnUDlabUp5UHA0TTY3N3VIU01SVlg4UmdJOEEv?=
 =?utf-8?B?N1ZxV3VmOFZDWDdaZndPMUdBMzd6RmRscEFNbHQxMEVtdGhEWWVaTHpoUDdB?=
 =?utf-8?B?T2pSNGZyMlFYdE05TDViazdjVnBZVTFpb1R0VlIwMVg4WW84UUFEZmh0eFFI?=
 =?utf-8?B?TFlua0lTZUdRQnczM04rMFlZMXBPLzhOSHpTbERMV3RUdjV4MXY1R1dqdkox?=
 =?utf-8?B?ZFpRQ1E0clNqSWRlTHpOelc3VWFVbmduRThlQXhqQ1JPaWtRMExubW1XTXVl?=
 =?utf-8?B?TitoN0QzQjBWV2tYREdtY2NNckxYdnFNQmY0SGJGL0crUE5IQytsYjFZRzkx?=
 =?utf-8?B?cEp6bmhmY3RHTkVBSzFpamFrNTZaQldPMkprTE1FUld4U0VWQTVvbS9XRDdh?=
 =?utf-8?B?MnB1b0V3SFgvaTQ4ekVraTh4eVB3Y3Y0QzR2VGY1WFE0dE9hNzhoTjlMWmgy?=
 =?utf-8?B?S2tXMEljd0JrcW1DUmczMWI1NE1zUHQxWm16T3hTSVpGSWRWN1hSY04yR1dn?=
 =?utf-8?B?aDFaQWZFNFZpM0hTVm5LNnhyWTB3dUFucTVlL0RIem5vV3NWNWllUWZUL3FS?=
 =?utf-8?B?dmJnUU1wMHlORTN4REFpMkhSR3dNdTdSKzFsUCtBZ0h0V1ZVUUNUeURqU1BY?=
 =?utf-8?B?M2UwTWQ4MnZYUHBScDBWMnA1TjlCeDVVSER1Ynp1blBQZWxOMHdoVzIzaHpi?=
 =?utf-8?B?VHJ1SUJsZ0ppRGpGdVhXNkk2dkl3WUduTlZLTHJxcXh4V0xkRmhyK1RyL1p3?=
 =?utf-8?B?Y20rRTRVK3hnQ2tSYy84YmpHVE9BdFBSQkM2RHh0UjdSQWdMS1VGSm90Z1Y1?=
 =?utf-8?B?emFyTTNQTGtQbStUVXpNbTdZU3Zia1FyU3d6NzFKZytITGs5Smd6eFVaeGdS?=
 =?utf-8?B?dkZWQWwzVEk2WFozejNEbmc3MXhlaUtTWnppZkhiRjFQYmxnMGlYbXo3eXVT?=
 =?utf-8?B?ekFxUGpIeW1FcngxZ0V5cEhWS3JnVjJuMTJUVjdEQmtJYXFmQ2JBMEdYc0dp?=
 =?utf-8?B?cEVUbzVTUTVON3VlNkoxZkhQeGNTQU5nMlc0Q0ZMaUZBLzA3cUNkamI5SUc2?=
 =?utf-8?B?VndrQjFyclZXNVcxa1VibnBUdi9Za29UOW9ESVJPL1Zzc21TV2UxczBuVW0x?=
 =?utf-8?Q?pqvkOGCi/oMTNuiPlkuApt2tu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c67394c7-500f-4bbc-251f-08dca55b90ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 05:53:07.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+d9+92SQjBpXoPrmK4ZSGi8y/6+aMsZ+JEWE/dtiGGGy4qIreSOa3t3StpbXx4oW9Uy0QC4aap0JkQyGgfHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8574
X-OriginatorOrg: intel.com

On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> The first stop for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
>
> If the root driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci_driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
>
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
> accelerator driver probing should be defferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
>
> The first consumer of this API is a test driver that excercises the CXL
> Type-2 flow.
>
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c          | 41 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c            |  2 +-
>  drivers/cxl/mem.c                  |  7 +++--
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>  include/linux/cxl_accel_mem.h      |  3 +++
>  5 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b902948b121f..d51c8bfb32e3 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver
> +*/
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d66c6349ed2d..3c6b896c5f65 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f76af75a87b7..383a6f4829d3 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 0abe66490ef5..2cf4837ddfc1 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -65,8 +65,16 @@ void efx_cxl_init(struct efx_nic *efx)
>  	}
>  
>  	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> -	if (IS_ERR(cxl->cxlmd))
> +	if (IS_ERR(cxl->cxlmd)) {
>  		pci_info(pci_dev, "CXL accel memdev creation failed");
> +		return;
> +	}
> +
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint))
> +		pci_info(pci_dev, "CXL accel acquire endpoint failed");
> +
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);

there is no need to invoke cxl_release_endpoint() if cxl_acquire_endpoint() failed. right?


>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index 442ed9862292..701910021df8 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -29,4 +29,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif



