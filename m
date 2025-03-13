Return-Path: <netdev+bounces-174770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82E0A60468
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10C0177C43
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C351F76BD;
	Thu, 13 Mar 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1YpevHF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5822612;
	Thu, 13 Mar 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905209; cv=fail; b=eJidNpsEUdedEl2ZcGxhBRa9JZOFYgxxmH3ufRm1PkJ9JZqyTYsulJJI5SLPAs9gfRNhjsjDOJPMIyd5uqyZBRbnNmxdHcVFowkHvu7ziXYqmsP3dZzqCEF2NAkmVTq4KYuRjQ5OxTznNu9elQ2T8nkJmVCvlzfBMwydlVGKNZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905209; c=relaxed/simple;
	bh=TKZ45925AXtLcjVVeqIACytcJRKG4eCq/xbbb+mKqSw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Td76ipK+m3Wd244spqBrjZVwfbXJ+QrFkBu+EFyT8jNZSo+zBWjwLotZleMLijEysj6HWdmLLRQjlY4MTo2Txk95+nRUIUBH7MN+5KQ4pZYLuuo1s48Bs+uD5AEenIhPLzc6Sp6a53NyRzlN8EXdudMI8jZRI6Z2frbyD5otgYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1YpevHF; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741905207; x=1773441207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TKZ45925AXtLcjVVeqIACytcJRKG4eCq/xbbb+mKqSw=;
  b=k1YpevHFi+DvEEeaeXl6ybaeAJDiAlt6C+FhNMCld/Uogc7HbxDW4Pqi
   aqUx2x1V+Mn7s74GJUr9yvXZxyzyxC2/1e2ohdalpVNo9gld8GjV2IsM9
   JY6fD8YqeVMlxjk8Siz9CeLZZ0s7gs0jXS4j/hroZVfasiL4HAlkEirRP
   7xxZV+NbytY96B0SHQu4BxVu6LK1HYNJOLkmIpnhZssNu98tPINlORyms
   gwVNGgV9n1BXYTFwar9n/T1019fEapfYFtNKTaO+cfQV6PV5LB14tvgQp
   TmgpEY2wU5Xzw4kYWqjclZEWS5I7CD0KTT8OApKtvtf0rpzqelUIiog3Y
   g==;
X-CSE-ConnectionGUID: kI2Ay09mQiWc2etcOxRyrA==
X-CSE-MsgGUID: Jd7liKLcRga+S9EzTq6o1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42213089"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42213089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:33:27 -0700
X-CSE-ConnectionGUID: yK6NGNGIQ76juvKZ8bxolg==
X-CSE-MsgGUID: tSJtbLCmS+ytEl1GcTWatQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121597593"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:33:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 15:33:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 15:33:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIgiY9RVlkKhVZ0YQOEtYLYqZXUuLDIJHPGiiHzix2mHS+1DKTkKlNkfIRKIo4Q2t0Fdgh9ogCgb1N8zYNP+g2yzk3izoPv2d/gsNlg61opPaIBmV2ODGmB/XOAQDZDUv9uKc+eTJhme/CHExp8ueH8cqbHJc4MxzPixzItP15yxHWsGOIIBjCRwwHpF42ZvjBt1skEUJFvYfQdsI4CloxMxABjzyduc7ND8OE228Ody0qABhAkWRg6uZhTqt0WuLKK2MZaXIqwWSEMZlfaB2LsIDy2+eakmzP7rY/Arx6RsiSYLIJ5iyPfdgptt+EHqwaI2x33GPp03UtqLmMEKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikjh3pgCq/Wtx3OA8V8DuwyGYGZrwFbPTbWgAkj6KY0=;
 b=cWT+UFs1/yduy6cC2uC/9fWa1FolM2RRTLwEidB3wF4jLl80ZtE0JSQfgG51lMHcKejF2o88dqMDawLkpClyF52QwGiVwGFCzkx6d/SVCNdxToNHWf7EhJxBjitTbl8HaRLnTbI6GFVjqfndBUMdQjS/gdk7rXlYlSZmL0IQjWt6ifI97Ama2mnyTDL4jY43X60Unabkp2H5+iB1VPI5P5Dv2E9kgblSmGiAPkDpGoeK35Va0A2/v0fpm8PS8Hc0SPyEPC0/uw0fh5qnVkt9vWrS7ActmeN70MR429NNqwS1mhoMLKgq2PS0MBkj4vdBSYmAjwoANCDyyE44Kg6L5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 22:33:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:33:20 +0000
Message-ID: <89d99e2f-1189-42dc-8284-bab874820aa4@intel.com>
Date: Thu, 13 Mar 2025 15:33:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] stmmac: Remove pcim_* functions for driver
 detach
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Yanteng Si <si.yanteng@linux.dev>, "Huacai
 Chen" <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>, "Serge
 Semin" <fancer.lancer@gmail.com>, Philipp Stanner <pstanner@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Henry Chen <chenx97@aosc.io>
References: <20250313161422.97174-2-phasta@kernel.org>
 <20250313161422.97174-4-phasta@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250313161422.97174-4-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c0031c-f815-48d8-ad16-08dd627f0ec2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2RlakpZRzRCVzV0bjdCTVdubjg3ZGFVRGdxVDdLaFlFYnNFSVpMTTN0c3hk?=
 =?utf-8?B?c1ZLN2pZbXMvNzhNVDBiRXhuWjR2NXUzcWhTL3lzdmJBZFhiWmFaaElyVExu?=
 =?utf-8?B?MC9HbzRzYTc4QVcycUtRNnZia2hPcUNvSkNEU1ZzUjROQzhTejhSMCtPNGNv?=
 =?utf-8?B?NmEvK2gyQjJpam42WTYvRHM5bWVGWGtzaVhuczVNUUdROGJRMnVGU2U4TWdB?=
 =?utf-8?B?UzZtVGJGMzAzcHpWc01TZ0lGZXR0UDhSQXdaV0xzZG5NWDI3eEJYNHk1dmpt?=
 =?utf-8?B?Rytkbm5QMnVmVDJ5Z0JGeGdhMXVRYXUzV2Fweit2RzRVWlVrc0FOOHVmUUFo?=
 =?utf-8?B?a0M2V0hnSmlUSWRSYXYrQkxCb0pvY2JyN1JoTTFEMVpoR1ArbDh2Z3A1VVd5?=
 =?utf-8?B?M3J3Smh6bVNuTURrdjc4RWg4V1lBYmx0TzRWWXB1cDNGaTlpZmVUQlJrZXdi?=
 =?utf-8?B?ZFlQbWcyQlBlZTFDNDNsZFdYdC9hZUhLRkMrbkFTbGl2UmJYUWFaVXJvZ0p1?=
 =?utf-8?B?Z09rWDYvUklHMEJxMHpQdE9nQ3N6TnJjc0x2UDY4NG1lUWV5dGNqLzVTVmh6?=
 =?utf-8?B?ME5qNW5COTZQamh5WTdwcWZZektyZ2k2N2lEWWhReDF3ak9uRjFSaW5mV0lZ?=
 =?utf-8?B?N1l5K0VWVzhpOGdORnROSnZPcWdWeCtUZ0Y5K2gwUDZEVGJEcFFUVGQzNGdR?=
 =?utf-8?B?SXU5N1VKR1pkYytaNE5KS2c1VjBjNThyVTBQazZoVi9JMmNBN2ZaeE1nMVdB?=
 =?utf-8?B?eFBGaEtabWdYN0hsVVhYUGhuSW5LMmVWcVR3SUxiSnlsZXlZWUZFZ0RtSWht?=
 =?utf-8?B?dXR6WE1IMXRXRXdOODdVd3dRTm55VWRlVG1QeXBxMjR4diswVnhvMm1jTWpi?=
 =?utf-8?B?ek9yMW5mVUlHRnBVWWIwZnBIT05ETXUwUVk3RzJ5WHpVMS9vOGs1bEdzTmFq?=
 =?utf-8?B?Y0hmSnNWbTNFT3V5dHJWSWdnY0wxSFJQUkFiMGZZM3dDTVVKVkY0Z0VPZk9H?=
 =?utf-8?B?b2s1Z1dZdFZxU3NsS0lFbG9zUmd6MFRLbnIraHlGWlVUcGpHL1BTdDRwWnVQ?=
 =?utf-8?B?WWh4VmlmL3I3T2xHeGN2NXU3Zit6THhOVXdlVDFkTGMxRVlGSjdHMXowZkN4?=
 =?utf-8?B?dndrUUlKMXhSV01ZUUlNcmVINnBqQm5GZVppUnp3VmJGTlBqSm9UakIrTjBU?=
 =?utf-8?B?aEJBNXRXenR4RW5UdlJqTFRzMG41RG9XWTBpQU16RzlGVFZxdmNzZXBGQXR5?=
 =?utf-8?B?UzMvMHdWZXpBclo5S3JCaXFac0FidW1YS2t5bTFXSmJMVEdycDc5QksrNHZQ?=
 =?utf-8?B?NWNRR3FSeC9QRkxSNkhlWGlCSFR2ZnNhT21oeGZkaDRsTDgrYUF3YU03S0tD?=
 =?utf-8?B?MmZSNW5HQVVtL1RxTXZBWlBWQUJGNHlRQ2JScUtjdHE3SmY4Nk5VRHJGdWhG?=
 =?utf-8?B?TDlkdE0yWjFVeGM1VDFmRHplMUp6MTdlcDhwaTRvUk55RjQ0eVpLTlhsaEw2?=
 =?utf-8?B?MXQyWG16WkNtVGlhTkxPNklqcWF6R3BwZzYzSXM5dEtHYkhpVGllODdBR2JJ?=
 =?utf-8?B?b2Z5Wlh5R1UrNVhnT29YWmNiTkdYSEF2NHVlQ1VZSXRkM0tnQ2pCTFZmT2RT?=
 =?utf-8?B?aWJKZjV4TXNlV3huWEdBZ0hBMlc3dmUraXNzNWtYNUk4TTBBQ2thNEl0VW51?=
 =?utf-8?B?Zjg3ay83Wlk5WHdqYUxpdXVZZjI3bUNVaG9RUFNqV21aRUw3NU85Q3p6NFRz?=
 =?utf-8?B?MnR2Z0hqa0lGRFMzcjRuWWZMOUxmMUpCSXdQMTZtRldzaXF0SStGTzVCVnVn?=
 =?utf-8?B?V2pTTFppMDFodlNJODRDRi9kdlI3Smc2MSt0MWhSWFhUWU9LQjVKZXl3NXFh?=
 =?utf-8?B?M3NTeXJQZXNsQ0dRZjhQRTkzV3BTMmxFQnkzNTJlSE9nSzQ2NXczVkcwTW00?=
 =?utf-8?Q?p78zWicgHIE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTYzcXM5ZXEwckI2L0lmMGF3aCt4L1JTYzlQaW5ocXV6RFpCbWxzTmltQ2VZ?=
 =?utf-8?B?cmk2a2JpQ05EcS9oNG5KdXhkeDRPYnRkQlRSSXdlTHM3WXpjM0F2QWs3UDZl?=
 =?utf-8?B?RFgzeWxIUCs3L1NjaFdNZ1QzTktETkZ5S3lTOC83Q1dDN2R4czdLS01uUEhZ?=
 =?utf-8?B?dUdlMlQ5SStXNTZZdmNPRW5JRXBVemNTM0ZGVmZWcHB5M05UME1WN2wwTU41?=
 =?utf-8?B?K2JUTTQvYzJRM3NsVWNJVEhoeHZJZHk5UVc5VE9uVEM4Z0JxUytMVHJBcCtG?=
 =?utf-8?B?b0w1YVBPSTI1blFMMjQram9Ickt5ZGlpdzExdXg0SUVObnlGMmozY0h2UWh2?=
 =?utf-8?B?TGRyWjlyQjUwRThwQUozZmROb0lMc1dtZlB3QUlKZkp6bFpOekltdjRha1h6?=
 =?utf-8?B?by9Odm5hN1U3bU9YczRPNmRkeithZXZGMU1pMk43eXRBZVRZOTdqTkhBTXIz?=
 =?utf-8?B?UnlHY0VTc0hOYlVLbmRKaE1CRXI5T2twYnRtZGRmc2dHYzl0NEhTRmRaN21u?=
 =?utf-8?B?dTRhL3Rkc1psZDVqaHNVWXEvL3IzbzEwVnJSTm92amViNUgyck1jNmZPSHNi?=
 =?utf-8?B?Z0FVU0ZnMlVtZWVzMzRZSFlMN0tMSEdwMWRzU1VOcml3cVdZbGJFOXNpeHNp?=
 =?utf-8?B?K2F0WEppL3NCOVFIWjBOMERINGd6Y0l5UnJtNGtjQldweUN1a1N0STZLNGpH?=
 =?utf-8?B?eGhqLy80NW1hZ0Rua2V6VkpRcG5Dd3ltTzNOdFN6TUxUSXp6cFk4ZkpEODR5?=
 =?utf-8?B?UmYyQ2Ira2tMSEc4KzIrWHowYjhGbkl1ME9JUWlucGgxYVp3WUM4SUVidVdS?=
 =?utf-8?B?RDQyQzN1cnNURm8wWkM2eVZUUkxoMDhOQzFJVVhlTmFBOHRMb3l1dERISUQ5?=
 =?utf-8?B?NzJqQ0VnTHRPa0hQNlh1S0hXVzBERVdUWXRNVW1hWHdBcDNod2tLU3c2ZWFx?=
 =?utf-8?B?ZnlvZWdJRU9aVlA2TTR2dmJpT0E4Zmw2MkxZS0pLUHBRUWNveUNMaDkrR1JW?=
 =?utf-8?B?VS9vbVcwVmNVR1FDVEVLMEczdy80ck1JRzhoMTVrczMrVTNlQ1BseUVMMFZx?=
 =?utf-8?B?STM0K1JaUFhPL1RjY21JUXlQRVpyZ2ROUFpRRFptbGRWTFhXdVV0a2xDRUxB?=
 =?utf-8?B?T1RPQitSSWRGV3ladXRLSHFUZitmNDFzK1dpeGdsU1VUazlOV2ZDTFlLV2FM?=
 =?utf-8?B?WC9WTWQ2UnAyaFNMU1pxK25rSVFRMFRkOWVWVUd3OEVKYjNxSjJwK2h6QTJv?=
 =?utf-8?B?bDRJN01reWlVVFRYVzQ1MGFFaWt6c2RpcEt6dXhBR3p6M3lXb2sybHlOaEYy?=
 =?utf-8?B?eWVWWXV0VjdZMVdNWGhZL21sMEtVWkpVbjNsVUJ0NlpNTEl1MzgwQmozYUlu?=
 =?utf-8?B?UFVnQ1k1RFZFTkpsMnh1L1hBNURXVmQxQkR4cHJjZUw1MGhndFNPZFJSRlA1?=
 =?utf-8?B?S3VQelE2K2M0UkRzcTdyanNvWE1Fc2JKQ1NYQTErd1I5VktYZEozZDNjKzFG?=
 =?utf-8?B?TndqNEwwQkcxekxBWEU1dWRCNWY0YUNiT0YrS2xEb0IwZHlEWnM0cVZkMTg5?=
 =?utf-8?B?cjNqMXFiNXZLajNZUk1kdjJrdWZlUzU5aGdGVWVXL3hkamdEeWNRTzJENUQ2?=
 =?utf-8?B?UU0rSTl3eG1LZlhvdTJlVkNoSkJ1bzdTV3Y0bmVqejFnK1RUaXAvMlh2c1g5?=
 =?utf-8?B?Q1JkdWNQMDhhNitlR1krSzU4SjQzVnpGdnFUWTZoV2FoeDdmMDR1Z1RIWDFl?=
 =?utf-8?B?V2JYRUpVNHFQTkVKcVhEK0xaZ1hYMUswU3BSdVJYa3dLRTk4Wk9QMjhJZGUx?=
 =?utf-8?B?Wm1Hc0RHcnVhWmNYTEpYSTBJRVNGbm5Id0VWb3VwajBucnhhWmM1WjJ3TW9G?=
 =?utf-8?B?dDhuNmZYQ3U3RDZXM2xYdDdnYUpjSEtSb2RpemU2d1plcG9pYURYVjd1MUVz?=
 =?utf-8?B?a0xBdnZaL0hyUTFMeVQwVlJnVGY3ZE9aalh3eDdHRktCeEFpckJiRU8ydkJa?=
 =?utf-8?B?WXI4bTQxWVFISzdWU3lmbzV0TFFaTGpKTWhxMTVXVEkxRGorTTFKOS8zZ0to?=
 =?utf-8?B?QmdJaVJ0VG5OL2YvM2tKaTZJS1A4RVBaSWVVQ29BMmFTVkpCREhBUDZpa05x?=
 =?utf-8?B?VkVkOGlQOG1Yb1lJeEV3Ui9wRzN6TnM2VTU3Wm1wTlQ1V0hVK21hNTg2c1Qx?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c0031c-f815-48d8-ad16-08dd627f0ec2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:33:20.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yomWj2vEin74PHsR6vQfDeYPnqI1WF+UbZKcZE1sK55Oi35e3+ZJHERp5Hc1vsF+BSI5zWLUlqmqFkioogUftt2jd96bAbkiMPjI/3SD0iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com



On 3/13/2025 9:14 AM, Philipp Stanner wrote:
> Functions prefixed with "pcim_" are managed devres functions which
> perform automatic cleanup once the driver unloads. It is, thus, not
> necessary to call any cleanup functions in remove() callbacks.
> 
> Remove the pcim_ cleanup function calls in the remove() callbacks.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> Tested-by: Henry Chen <chenx97@aosc.io>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

