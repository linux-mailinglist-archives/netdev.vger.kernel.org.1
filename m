Return-Path: <netdev+bounces-157744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C9A0B837
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B1D166774
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03DD1CAA70;
	Mon, 13 Jan 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gpu4yb/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C722CF36;
	Mon, 13 Jan 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775256; cv=fail; b=Tt05REog9dl8gfvt4dPkY7WXy4F+/UWK1kbGl9WviE1zqn0skEwPpd+dnzcqCJYXlV4bjn6Sng/Hwyat3yElAedCYHzefh1D+JaH0MgL4b/IMWDFcPkcqUXNQGB7ARn6EZJx2tTGmUQSkMXJa4ptQ3FdjbAONQSEOMlLMX7JEyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775256; c=relaxed/simple;
	bh=qSB10c4i4Lpod3F3uxdmL1MeyXuaRUO1ZSpYnMsXOV8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUyXqGvjKDgy4fOf0+Htx/HuUuJDkO9/IB7/SHzA9cDFwu/BBHnG8lS2pjbbNYX8/8H0op3iSFE36m/TtUEPIH061d8XB+BH7immVXyMx/BNpTLr+V6ExRBz9KupMyiaw/AQcH3GuPtd1nbZajxRiKV0M/ZMYMUtdKc981K2EOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gpu4yb/Y; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736775255; x=1768311255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSB10c4i4Lpod3F3uxdmL1MeyXuaRUO1ZSpYnMsXOV8=;
  b=Gpu4yb/Y78HcgA7yKPFdtVveTaTSeAkijOy7QuUbnl1Tjn3PyAQ6Yqq+
   1jZ0eD4oZfMrHWq1LteACD/Jdm1IzL3Y8wsPiCjhUrBwPiDNaPlT4KeSG
   tzsNEJBbtlSiboCNRpAUrvK0wP6UWh77np1Qsbwkd4czogOFNevEJMuol
   Tkai/XwuV73oLqiYOcr0Cfi157rZ8/HDYENGDvWqYGUtPrslAACHIsykQ
   m2e7YXWlw+Yoq2ADVnhxCITnAgCRGvP2DfIV2HBr/LbnfLbPmFtlYHBmp
   LwrBUsICGARykCmlm8Uu7NKBwZd4uvkx19KQwNG4iLLoIASLDBOqix3T+
   w==;
X-CSE-ConnectionGUID: 3/zv3jsnSzCc2h4kmbj8gw==
X-CSE-MsgGUID: 5In/zYgRSxKtINhsK21LMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48037892"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48037892"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:34:15 -0800
X-CSE-ConnectionGUID: SnI/sgxpRNCU0E/li47Wnw==
X-CSE-MsgGUID: NDG00SidQzSN1Hv/3Mu9PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109468683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 05:34:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 05:34:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 05:34:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 05:34:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akWimPPYs8tqRvM4BP5Yiuw1+o58qBVcTSjUp9ffZLT5NEI/aEkU/qfhUm7XZdAzUMpCKpQK8wc6xZiBfSdLyHEHPnYerfAz4ijcFPbtQkxQCnZOufQgCpoxUJ0fk7K1fIbAMGFi+76dBym3TxAPS9OSVDpm1npJc2mlWflIfDuRqFNGbeG7I7KnMcwVjIQ1XWO15C1VWMEm6KZjx+OO72MQfZuqJfOpj8Qhiofzq/1w90wBRPYwoDfjxDWSF3FWPOKy32Ggehq6jI6Smv2Kt3o/KihAbG+/XYxdXo2BJ7/KnOFCNWELEuhsTCM53bPvevUrXCksp48GWgSxqBpX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYPaqpc9oLMtQeDxrX5V7rzyu3bGVqmwgFPP43QeSrk=;
 b=AfHExm5lc+nOzPPS/NbUSmbdVivzoDPKUCTH94hMPHh88qN3Tbs8BuGeSHyYc4meTehnRI0BTsTGkAz+G5pmY6IA0lNQAJwL1pJ7wtE2OhN0OkpsUIchKuyXHZp1IWLuTALP3jJK7ztcduJGt3BGoG9ND696u7z41MqfLXPJs+NWZmv3ShG55599yE8I8D2P6WWjbY2Q3P+DmXGrtOP+p2bYd3njXd8HgcXkUoQOjo8iwjiWMXSHVoF9LCtGUDDu9fWoSCY+RHLZ3kc6eFg+tlRfOGU/65sYGVTyQimvzrYnbNxwUU/yi0KniuEXaKLeihQAeKoC6/fPXD3bsSwSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:33:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:33:30 +0000
Message-ID: <f0e2665e-f6af-4c7b-aaf1-b9c8dc3cdd40@intel.com>
Date: Mon, 13 Jan 2025 14:33:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Eric Dumazet <edumazet@google.com>, Thomas Bogendoerfer
	<tbogendoerfer@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250109142724.29228-1-tbogendoerfer@suse.de>
 <CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
 <20250113122818.2e6292a9@samweis>
 <CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6ed72d-48b3-4902-fcd3-08dd33d6de68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTh5eGtmUkNCdmN5c1VwY0orV0xiejRsKzVqc2l1eEhaWXkrTUY2UHc0anBH?=
 =?utf-8?B?enlLajRvZlErKzd3b0Fua2g2Q3RXcitGQ0VmVzFXL0FkR0RHaGJ6M3lNR3d0?=
 =?utf-8?B?VU1Rb3BzRnNOdU50aW44eEVDMGpwc0VJQ2xzM2luUjZ0VnRSeE05L0w3K04x?=
 =?utf-8?B?ZU8ybEszdzZFeCszeGlXQ3ROUXJ2SWhWOHNyUHJ4UE1pcmwxbnVzWkxFd1ZI?=
 =?utf-8?B?aGZua1ROUnozR2k2RTJ0cURBNFh3cTBGUy9kRnlpbHlEQ2tPamVrQmtSQ2pz?=
 =?utf-8?B?b3FsOTZ3UFMvQVJhSkJFaXNuMmN1b0dURy9Wazl4bHRZTXZUMVBuV2I3T1hB?=
 =?utf-8?B?NjVXZVpJbm81UklCS3N0ZTVRaDFsbGh5SGZmZDJHK2NyUXFSMUxpeU54SWdD?=
 =?utf-8?B?UzNLdkpJdVZpZ0N2MnNNNlBqYnhyYTlGL1paSEpQUWRPQWtjazNaa2FCRVRt?=
 =?utf-8?B?VmVWcUFLVFJKRGlheWN6eHErampEa2hrbkc4eGl0dGN0aUxHbDQraDhIR1lU?=
 =?utf-8?B?aytnTVJTb1NVUkFCME8yMXU5ZDRENDlRMEtXc3N1NEVOck9qS0E0WGxTLzJz?=
 =?utf-8?B?UENVWjUxbUNQVGN4S1dscFA3OXNjNG1kNEcxK3pjbysxR0diODE3WUtIOUl5?=
 =?utf-8?B?Q2ttOXJLa3B4WDF3cXQ3VllqeDlXNEQ1L1h2dis2U2VhclhUQjlJeFBHRGts?=
 =?utf-8?B?V3RuQXhXSFpWYzNzRE9YR2pBaFZWVnJPSy9rUmFVVUMvLzkvL08wN0dEVmVy?=
 =?utf-8?B?U2JVajRucGM1UDJueEpxQjAwNTdRVVUxK3kwdGFKdHE3dkJQT1FidVF1cGgv?=
 =?utf-8?B?d2NxSnZtNVRoaDkwb1FOTWtWaWlicGRpTnRVbXhWZHhucVRIUFVpdmRxUU81?=
 =?utf-8?B?aG9LWG5hdjJpd1orMlJ4MjN4dks3QlBiTWhQNExqWGFzSERZc2NyK0E4bmdo?=
 =?utf-8?B?NC94K3AybmozNXF1bUJsb1Rmd3M2K2ZCUks1amZjU2pkN1cvbFdkcTh0Z3Ex?=
 =?utf-8?B?Vyt1YWNOQnBXQStmWXdacTVQeXRQVUkvZFVLb2lHQmlISysyWmhZZFZ0N0Ew?=
 =?utf-8?B?YmVmejBwQTQ4RHg1RFljQWdFd3FXcXNjWEJHaU1iVnkzeWlWVXFpc084Sld0?=
 =?utf-8?B?czVaL3VnUmZVMHFlY3ZGVkZrTEJKeHhMTFVOOGpFQ2hDSVNham5udm5yYmtv?=
 =?utf-8?B?RXFnNFR1VFhBVEQ0S2dTZXA1ME9CSllubnZxK05kMXBnOVl6a0c4b3YvYy9W?=
 =?utf-8?B?S0FUMEQ2a1FNTDE1dTJheGptM0xuMTFIQUMrVjB4ZElzV2dJa1p2bnJDd0t2?=
 =?utf-8?B?Vmt0ajJ3SEZHZ1hKRjBZaC81RXpIL2plVjJyeHJzY1Y1dmNpa3h6WDlCTlJ1?=
 =?utf-8?B?VUp4Vm5CajlvZTN6em5uRXNSV0pWTDRvc2QxMU5uTUdsZWxvYXpXNFV0cWkr?=
 =?utf-8?B?SUhnL0xGSUdrbjllWDNxaUtqLzhrVlZjMWRHZ3JJUzhQd2hPb3dzaEdXZnk5?=
 =?utf-8?B?bE12ZFM1azgzNmR6RjQvTDRCNjRKWFVsb1MvcEVMbjkwdkN5MFJYL3RRenJ3?=
 =?utf-8?B?ckEzNC92aXpzc1kzY1ZpOHFFUUtRZUkyeFlJeDZaL2I4KytzWHN6YmpqRmNJ?=
 =?utf-8?B?RUdDVTQxVDNFNFZGamRSQ0FpekxUT28xRUhPRmd5WUpDeUZBTFk4ZG9jS1FR?=
 =?utf-8?B?dGZHZERUdStCZ3phNXhMZEE3OUpMVEIxZTcraUNNbFBzNGQva2pxNXRaYjJ5?=
 =?utf-8?B?UDFET2UwbjZGMlRZQ0xxMmVkQUJSbkE4VHN3QWdhc1NQTkRXVjVlU0t6bWxy?=
 =?utf-8?B?WWsrQkwwR2U1cHVkMCs0a1g2Q2F1TGozb2lxMGpCVzY4TFBuSzlCL3MxWHht?=
 =?utf-8?Q?of2xjB/0bSkTM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZQYmpMdzhsVWRsMFE4LzdIaXpTRDlVU0t6Mi9LL1c1bFo2QjhTdmYxTUJ5?=
 =?utf-8?B?MFh5Smdid2QyczNYVFVGeXJWK0w5TWNuZHlOU3EraE90SWYzWlNqUGtNYXU3?=
 =?utf-8?B?M1JGa3g1dXZwLzNqSXRkb3ozcGVFcFlVRzZneDJITlZTeVAydThMYkNtMkNk?=
 =?utf-8?B?bHVEeWg2WWp4WTdaenB6T1VDcjR6V3FSTHFCMzZsN3VnWWY4NlRpTjRzRmty?=
 =?utf-8?B?T0tNWmg3Q1NxS2h6WTJYK0k1eFRpb2szNVNJVWZLaXMrZ2lmK1p3VHZscGZ3?=
 =?utf-8?B?eVorMm05cGxIUHcrbE9LVjBXUy9DRE5WUVNZNUQ0L3hVbzFRNHptWXoxN3pQ?=
 =?utf-8?B?WFgrUDZzcVBOV1U0UGR6blZDL0tnaTVoZk9JS0RBZ2l4ZEl1YjllV2ZqUWhF?=
 =?utf-8?B?YVZNRnowTnR2TEowSXdZNXZxU011UmtZUmhDUkdLb0w0TXJkUkdYeU1pV3Jt?=
 =?utf-8?B?dkUrMnNzUDhLU2E4NmZVN0ROMzR1aG1jcWpVN0kwQWRLNnVlbWJrSGU3Z2lP?=
 =?utf-8?B?dCtTZHpDUWQwTENXUWpENm9OdC9vVHNua3UxYzRKOWk4UU1WSFpvL005b211?=
 =?utf-8?B?OWc4TXZZclhlbEMrdU5iS3ZCVDVZZ1lSbUQ4K293d1B6SkREb3lnMU5zZzV4?=
 =?utf-8?B?OU9HWDBXZU5kd2RRbitGL0hmVEltTDFRb2tzNURiWndIMkJ4WnNBRHlOV04v?=
 =?utf-8?B?RG8vckNQelRycWVqQlliQjVVZXhDZWF4RUdQc3JuWXdlYnRzR3VDOWlrUWhK?=
 =?utf-8?B?ZkcvcGVwaTBhNFFYZk14b0Y4UzNiV2Z3K1JwZjdSNUcrYm14VFNFaWhkMkMw?=
 =?utf-8?B?VitMMVE3OGVUT0Y3WTBnWEp0ck1XTTRETjR5MWpBTVljZ1JCVHd2Q0M0TDh1?=
 =?utf-8?B?Y1doNXdrN3hGOUwxbWRkOG9BcCt0UExibHhCTmdHWFhhVWtUMXhYK0pQeUtU?=
 =?utf-8?B?R0VZUHdEbE1SQVZCd3NXZFRKNXFlaU5DWDFnZ0x1Ulp3WExqOHB1d01kVERw?=
 =?utf-8?B?U3dhOThyUERJVjNlZnpXUDJCcitWUjhlZFJFdjkrRHpqcm1DMzIyUHpYMHdD?=
 =?utf-8?B?YUZzL1IrNEx5ZFQzeHMxYzJMMGpXQWJkMDVXak8xcndQVHVTM2w5Q1RkRFBQ?=
 =?utf-8?B?NENxaVJ5Zk5Yamk2d1RHRFRIZUdVanJkNjMzSTdoT2RqQk1zS1JZMTdndlNU?=
 =?utf-8?B?U09yNDBRcTNZNk9zTDZHcXQ0UldmVFBqbk1ZR2UveVdDY1FTWjhqZ3ZwdkRq?=
 =?utf-8?B?ejMrRy9pREdYZFFkZU9FT1RacVRjVFc3K29ucmh3WTFPUkZmZzN2dktGdzR1?=
 =?utf-8?B?QitWaXVMbS85SzFGby9FZm5udVFXQldJYTlJS1liOWxuYTlkSDNIWG9adjRq?=
 =?utf-8?B?eGYwem1EM3dRcUt3enFMVGFMNWJLVWcrM1FkLzRhTUM1YUZxaXFDR0U5cjdW?=
 =?utf-8?B?MUR0T3c5RE1LaERNRTVEVEt2Q0QwaW9TaUN0TXRpRFdGRndLS1hZbm9hTDht?=
 =?utf-8?B?RkhGdHdneGMrc3c4UkMwRlZEWXplYXJOc0hSai9VeUVUMWh1QmprV3lqbnVa?=
 =?utf-8?B?YUNjWlNEdU1kVmY1amx1bjF4bVVRc251MUVjVFVjdGsrRVBmYmhHL2Uxc2Qz?=
 =?utf-8?B?YVRPeDErTUE5VFZBMXFUWk0vTnM5aG9sdXhDTlcySjZzRHczSjdPNWFtQnVB?=
 =?utf-8?B?czBnNDMzRFVPMDB1emduK1RVRlM1Y3NZUVV2eWUrT3pOY2tlQU9CSEptMDYz?=
 =?utf-8?B?OU1aK3F3clpLRHd0UmdLQ1cxQ282ZklSQ0dqK1oyV056K3VsZ1pqQm5MZUxr?=
 =?utf-8?B?UU9WbU9Fb0hONUN3KzRFMERRV0k2dXR4RHdGcE80ZldUaStKY2tlUlRORUlj?=
 =?utf-8?B?Q2VLUjZSWTgwZlJUcWhJRFc4Y2FpSTJQelMvZ2lYd0dJR0xyQnU2ZGU2Nlhv?=
 =?utf-8?B?c1d0dEx3VzEzelp0OE9heFJWUmhyTmtMeUZJNXRRVGVrZklXc29yNExqNjB3?=
 =?utf-8?B?WlZPSFhkVWdNZTgrWG81OWlJMll6czJHekRLZHNYTHhEM3ZKZkVBcnREa3Fo?=
 =?utf-8?B?ZzlWSVhrWVErekVHVzhFUVdMVGdlbWM5ZzNHY2lKQjZ2dHFWclZ1WFpGWmdW?=
 =?utf-8?B?N0hzeUYwck9pc1hobm90ZzVLU0lMd2xDK0pFdzRVVmdVdWNYQjNXYW9CQktU?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6ed72d-48b3-4902-fcd3-08dd33d6de68
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:33:30.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHC1tIrW2O+5jWhGiG4BEMC9zDEkT9hJCUo78ukNToP/u9GZ09atHh5iZLHevPtfLUK8R6RuV2xuvDpuPiWpny0iqFzOmP4Y62OP2sDyAtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 13:55:18 +0100

> On Mon, Jan 13, 2025 at 12:28 PM Thomas Bogendoerfer
> <tbogendoerfer@suse.de> wrote:
>>
>> On Thu, 9 Jan 2025 15:56:24 +0100
>> Eric Dumazet <edumazet@google.com> wrote:
>>
>>> On Thu, Jan 9, 2025 at 3:27 PM Thomas Bogendoerfer
>>> <tbogendoerfer@suse.de> wrote:
>>>>
>>>> gro_cells_receive() passes a cloned skb directly up the stack and
>>>> could cause re-ordering against segments still in GRO. To avoid
>>>> this copy the skb and let GRO do it's work.
>>>>
>>>> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
>>>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>>>> ---
>>>>  net/core/gro_cells.c | 11 ++++++++++-
>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
>>>> index ff8e5b64bf6b..2f8d688f9d82 100644
>>>> --- a/net/core/gro_cells.c
>>>> +++ b/net/core/gro_cells.c
>>>> @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>>>>         if (unlikely(!(dev->flags & IFF_UP)))
>>>>                 goto drop;
>>>>
>>>> -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
>>>> +       if (!gcells->cells || netif_elide_gro(dev)) {
>>>> +netif_rx:
>>>>                 res = netif_rx(skb);
>>>>                 goto unlock;
>>>>         }
>>>> +       if (skb_cloned(skb)) {
>>>> +               struct sk_buff *n;
>>>>
>>>> +               n = skb_copy(skb, GFP_KERNEL);
>>>
>>> I do not think we want this skb_copy(). This is going to fail too often.
>>
>> ok
>>
>>> Can you remind us why we have this skb_cloned() check here ?
>>
>> some fields of the ip/tcp header are going to be changed in the first gro
>> segment
> 
> Presumably we should test skb_header_cloned()
> 
> This means something like skb_cow_head(skb, 0) could be much more
> reasonable than skb_copy().

Maybe skb_try_make_writable() would fit?

> 
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index ff8e5b64bf6b76451a69e3eae132b593c60ee204..bd8966484da3fe85d1d87bf847d3730d7ad094e5
> 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -20,7 +20,7 @@ int gro_cells_receive(struct gro_cells *gcells,
> struct sk_buff *skb)
>         if (unlikely(!(dev->flags & IFF_UP)))
>                 goto drop;
> 
> -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +       if (!gcells->cells || netif_elide_gro(dev) || skb_cow_head(skb, 0)) {
>                 res = netif_rx(skb);
>                 goto unlock;
>         }

Thanks,
Olek

