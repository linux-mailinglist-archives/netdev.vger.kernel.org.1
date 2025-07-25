Return-Path: <netdev+bounces-210217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38458B126BD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FBC165D79
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041027470;
	Fri, 25 Jul 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMr1D27R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB01DE892;
	Fri, 25 Jul 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481801; cv=fail; b=IIpZghGvFrOGM5/3q5Zxp2BaxmIzRvN/UlAeuuzZAChcxpp/Z2w9tvgA7qUtNP1lgM5QDb1SaU74Y8gAYA/UEpVdGGTkAsPLlHWGfCL0KhgSCFpbKzjG95Q3mxmJyp8CBrZe1kfJuyV5lNxdAW9cHM09w4ma0XWxBjanzC3J2/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481801; c=relaxed/simple;
	bh=VOsxGcWBrV4aneQNdC0vufm+jgJIaLf0JfP4uM8Zs3E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cvNq6EMIQ7c4NUHU6uT+yJr+ZCkBc6rLVKAwtnEn9m8KwxBsiAsFYc7vrlolTRsNb9ElJhPtCjeGu2vvNzdDRyj9kfMdGmPVfmQ5ZQ9JubKLxu3TruMJ3E+W5DxOuD2RoIn3KhCywLPaNz9EhKgNKJO5IEHhzvIc9Iu5dnjgMkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMr1D27R; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753481800; x=1785017800;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=VOsxGcWBrV4aneQNdC0vufm+jgJIaLf0JfP4uM8Zs3E=;
  b=GMr1D27RNEYRJzuTr32XUtfavzlci89Xhqd7MNiEKVyCd8sl9QDwhYQy
   eL+GUi1XtR506lo+GoIWgjefZB53X8OVdZnSYANAj5S0DjRX8Wk18CJbr
   qt+xNO511WbHvspvft/pVcnI38I/Xbco6pm0Rf3vkzJ2qv3a7xpLVJ574
   0n9PMx7DIB4t2LOKBiRhXIvYisN4HMXWnL5YyWiftJ8v5l4v3SWz91/ip
   wYwNc06TN67JsBFMlFIlq7eP5pneYHRqmTwjffr13I+xpGjz/x2CH9C1z
   v2jGzeZ3xbWwbnOJOJ4ILa/knue2OoCD8V720XJGBHRvBBQliR8YJQYab
   A==;
X-CSE-ConnectionGUID: qnQyQpLlRVuXHFsyWTp5ig==
X-CSE-MsgGUID: nWhVbGwwQkOGLr6GmoUPsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="73405441"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73405441"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 15:16:27 -0700
X-CSE-ConnectionGUID: xpN8UstZRSOZyPQlXuzKrA==
X-CSE-MsgGUID: UD0vzrd+QDmTrW1zav/HmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161507679"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 15:16:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 15:16:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 15:16:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.47)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 15:16:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygc+EuA9Gz4R+iTxM2GzsV3ReiK1HYhEwyF7Oo2RdDxOcBTs08lJFzNzEd3gDmg+HvJDPnXaNbc4hu8Q83hSEmKnToTrp/RVL1eki80mFYhQCh8gm8gRWefpFP+Y2g2QWxseN5VYus33md+auZCw5LTMD4UK6Dqp23FQ2PGv91xUPQJ5oYkDhwgdCbLspZo7W0iu7DBkkNRVz7IVGsbVH75RZUXAIpxYNDy1rMcSbPOwZ2XKN00gpqdMl1uS7hsANw8bSDgGFLhM0MOCGeXckiSQzcjnSWyzx6HXT7cbI5R/fw1iRlPZYgQikIJR+x7tYA9xK5wUp6k8U7bPzsyqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9g/YiAF5TR015HqPC+DHA0BFh/NP0QI7TuHyXUnd6A=;
 b=ZR+BUBojGkivAJDGVZqMDadvtHz+piyB+HAkFGkXzPmVLe+szEfqK2BE+q/osoVLi86VmbMS47hwvTui4VM7NuJHJJNFMUmrE3b+CGs5oJG2tJqS13Gt96iY8+RdaQnOZHXDwVcmOIy7LB+r+ZqsEubTVSu53zS4qKOE5nxJ22DD9cTEfs08Rd3a6HgTN6DdXZQY+q1orlwUYbRsKrq8xC3owfuv6UBvKcGcpvroaj7i7N079MNAZJ51ZcW7/Vy86zamPO+jYiKe4Ta03NTKMwTQ0l4i9bkkeRxWDiEdhW/BKDPxHm4tx6mO/jp1+8bZjkspMBkmdxY3t9f+5vW7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 22:16:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 22:16:18 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 15:16:16 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Message-ID: <68840230b1338_134cc710044@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-3-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-3-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 02/22] sfc: add cxl support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b7d1d5-a188-4531-bbc4-08ddcbc8e0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDVFajJzOXJmd2U5UkNvREVnOFV6SysvekxoYXhnVjVhN3BHelg4UGlWbUhi?=
 =?utf-8?B?QTU0c2pFL3A4Szc5M2lPRHV5d0ZHQkxFa0JCN0g4SXBBNnljVytlODVBNnor?=
 =?utf-8?B?OWV1VlpJMjM1QjdyZmo0NFI3ZWJ4SUZYQlhmREl4YUZBVmFjVXRiV0pmV3pB?=
 =?utf-8?B?N05OVERNYUErWmZiVGgzbFRxT1NGMVhiZ3dVd3RKbnpCNHFkOEhLUTN3OS8z?=
 =?utf-8?B?RUh0cGdoRk9TRERHaWo4ZHpEZDBkbE05eE9sZVd2MFg3bkZvanVadklkamV3?=
 =?utf-8?B?WUwrSy9NTk03TC9EOVlmUXIrY1ZHWGRSbHYwWSsrUm0rckJBZEdJV01QSVoy?=
 =?utf-8?B?aXdJTGlqWXlRbWNiQzhRYkpkb0kxbEVTMzJiSko0YWdPNGhCcG8rREdoOGZ4?=
 =?utf-8?B?UzZVSTh1NUlXUmQ3Y3dDRGpxak5ZelNCcVhKamdUc3ZWMWhNeEE5OXdaSFB0?=
 =?utf-8?B?SDJLenZzeUh1N0FJK1pWdnZGbUZaU25nKzZKY0p1QVlwUmVQQVB0Y1pjZm41?=
 =?utf-8?B?RzB6QVRVcm5lZ0tLRzRINEZ2WE14U3U4K0s0d0ZLZlM1eWlBZUxMY0xIV2pn?=
 =?utf-8?B?d3l0d21TL085dmVYUEo3dk9OWXZhNmVqSUFIUXcvTXg2U0FlWnhPRDRBZk1j?=
 =?utf-8?B?V3BjVkVnRG53bzVLV0lUb3ZjUlN5cFNyWEdSQnUyUkN2VFhsaHJUMmd3bWxX?=
 =?utf-8?B?MmFtVTBMZHVmZzV1MFlRRTMvYWhocFZQZDJIbXhTZHY4SlFsQzFhUGpxdXZM?=
 =?utf-8?B?bnNueUliOE9HNWQwSVpZUlNWZFJJYXA1eXZKc2lUSEhtUk1vMmxtcThPK3c3?=
 =?utf-8?B?VmNxWGt2MlYxQ25vaytVc1pDWHd2N2lEcjNSMCs2Y0Z3OTFpZXVkVlpDWVhv?=
 =?utf-8?B?SFFsV1pmOEpocUIzSmNhdktwS3N0ZVJjRDFSWTBBYzkzMElVZHM0M2dFNGFj?=
 =?utf-8?B?cXlkUEhBQk9FQWhpN3Rzd1Z1QWo0bmZ6ZzRvdCtGR1VZZ0RxZ09WcFU4ckh3?=
 =?utf-8?B?TDV2VC9rdUtuSFlTZ2pCcUh4eTJURmxNM2IzM3NwUklOZFRXR1l4Y0JUYnVS?=
 =?utf-8?B?YWFTL3F5aFYxQWREM2d1V2pUYzBETTV1N1hTdTliTUd5N3diTTc3cnBvK0Rs?=
 =?utf-8?B?RTJoc2Y5RFBLRGdiL1llQXVaYmxQYXJKN1ZpY0dZSlg4VHhoMFU1bERQbzhS?=
 =?utf-8?B?cG01TlJRNFBzdUgrcUpLSFJyKy9tOG5TcmdVOHdhc0cvQzFFQ0d4RGs1M0Y0?=
 =?utf-8?B?RGtPN013SUFoVU5jMWVNTTZXZ3dORzY2SUZkbG1rZmVCUzhvN0VPWnFZNnNy?=
 =?utf-8?B?NEo1aWJsN1RTLzBCN2Q1Q2R3RUxhV2RPZnRyS2NZMWo5RTEvelIxZ3ZoVVhP?=
 =?utf-8?B?Sk9UUmd1YUhYUDk0RTZ0NEE3V0hVZjIzOXBkLzIrdncwMHFiTFZ6bWVrMHNy?=
 =?utf-8?B?K0NySkxDbmZSMkdFb0xtc3lMb1RoalpLV0M4TWpmWUNuVFRvYm9sSzlnT1dK?=
 =?utf-8?B?WmVQaVVCYXNqOWpyRWozR3MzQmVNOENtWWZjUHRqUm12WjhjdlRpNlRIbGpR?=
 =?utf-8?B?N3RQTTU5ODJKR0FLNnBISFhCY1lFY3gxRjMrcS9DS2dINVNOSVM2eFFCK3hP?=
 =?utf-8?B?NjY1S3hjd3YwaXVBT3ZCbmpsb21reWJ2R0R4QWkyYVlGQXMrWXdITUxrcFBQ?=
 =?utf-8?B?OWdiYm5UN3ErY24rNjVsWkdHbnA5SDNLMUhzQk9WeklTVWJBUGdIV21vNTRo?=
 =?utf-8?B?M2I4UWk3SWR6cDhSdU9ZSjd3K0FGcmJJbFJaaURFMHI4NkMzb2NBVUJuRkto?=
 =?utf-8?B?SWdiUDlUdEdKOGUvUEtPMWlmbXZwVHhGM2M4VkdpNXhOUGcvcTBGY0JQSUw5?=
 =?utf-8?B?ajA4cFlrRWVZZ0JKTU1Ram5LVEptNnZVaVhNYWNmM2hpWkJmcTNhR2MwWi9l?=
 =?utf-8?B?Z0dvZTMxSjhVWTZDdU9LNUF2TVNPTGkyNjVUZHBwaHY1REQwZzBYUVpPWWZT?=
 =?utf-8?B?UjV6RTV4aW9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhWaXJTdXpGcmliSkUyTk1CcUJybm9qVDFPc2dmTlhoT2M3K2JIOW1TUFF2?=
 =?utf-8?B?S1pwUDVaRFpxcFhmM0lHQjZQQlVwK3Azdm9uMS9PcmxBR0N1TlkxVmlFT1Vw?=
 =?utf-8?B?NFNpVjZpdEIxS0xtQ2svUVlLRUZ3V0REYmtlQm13Nm04WDhVM09GNDlIWkhU?=
 =?utf-8?B?cnlMelhJbkxVcnhFM0lEaElyRGR5anlwRmIzSW50TnV1bWNsUGMzenEyU3hz?=
 =?utf-8?B?b1VaZG5vcGE5ZWpwcjZMazNXTHh4SlVibVA5a3FKUTNtc1ZEOEI3K1IwdnJ3?=
 =?utf-8?B?TG92UkpaeGxZeG1ZVStWaUZEcjdyWnJGREFOYkI4MUUvclk0Yk5iVHVCUTV4?=
 =?utf-8?B?Y3MvcitWZkRVRVBxMkFxc2phK3hHZlBIRDJFVnFPWk9OUDRSQWtHVGJmcEs5?=
 =?utf-8?B?d3B6ZStreW0wY0diYlRzcTcxQkljTkxiaFNENHJCYTFWc2dSeTZING9ia1Mr?=
 =?utf-8?B?Tm5GQ2dFN3kzOS9pb3ZkQ2cwZzlpMnMzandvSlVodE80SmRQL2RxRXgrRWhk?=
 =?utf-8?B?cFU0ckQxRXI2MnVYTWwzdEFHNjVKYTF3WXJibldHR01IUFhkV29MV2xIQkY0?=
 =?utf-8?B?SVM2cTlxaUx4WGt3Mjh4Ri9nZ1p5ZUtCbm9WTy9wTWlrbkxMV2NjMU5VLzlD?=
 =?utf-8?B?djVML0s4a1lrYW5RZU1EUzh2WkNGemFDcXUxdFJxdmxUSlgraWpHTllEcEIy?=
 =?utf-8?B?L1QxQlk4Q0dKWUxCbENCRys5L011T0p1VGlRcDhibXAzaEYyOWx5Uk53dlZ2?=
 =?utf-8?B?aEtQL0U1TVhSN3FINUNBcmJwUFRFOUJWRCtsWFZGYk15WXBkVkNzZnBKS0JT?=
 =?utf-8?B?bDVEWmpkYklzK2tDYThaMEdGUzJJV0p3Q3NCZEtiR3FGN0lzUWhwZ0tIaWZ1?=
 =?utf-8?B?c3h4WDREMzdJRnV2dlg3VnJRR3lSb0FFK2FnTnBjSHdxSkZKMzA1MDNjWUZE?=
 =?utf-8?B?WWdhbnNUekJDdElGbW52OFFKeGxVcE5MMnBnRGFyc21OdWtYTHd4bnBTS1g3?=
 =?utf-8?B?aW1LWk9sS2hzMlR1d3VzZTU1UkU2REZOVmRzU0FJVkpFWWhSNVltSFpmWlhF?=
 =?utf-8?B?UDkzcUpKMCtZUUJ3dllYdUpIRkRSeGozZlAzR0FEVG05QnNreXFwRFQ3ZGp0?=
 =?utf-8?B?YndxZUg1L0srUVY2S1FobitLTERLelVXeUpNMEg2V0p4SjBUbmtCVHBTYmg2?=
 =?utf-8?B?bnVnMXdRRGxrQ2MyeEVlUU8zaUowY1pqRit0REJaZ0pGektEODIwQk5wNWtP?=
 =?utf-8?B?KzAwMTVUVmQ3OHNDdnRpTnBLaStnTW1JaFY0SktqMDdrOFJWUDFGYWtkc0RT?=
 =?utf-8?B?amdIVlZ5WENZUXVUd1I5WnZVVzA4cVN6SnVWVHRrUFhPd0VkcGdPZnBITmxW?=
 =?utf-8?B?aW1zQTA2SkRDTi9SZERBOGFwWVJsSGZNMkpXR25ON05NbWNUOTh2WnZOWmdp?=
 =?utf-8?B?b1dPaTJwcll6U0NQTExpVzhxT3pEenhzRVdYbFQ2Q2pKdjdNM3ljRzI5UW5E?=
 =?utf-8?B?VWdLdUlxMU01TG9RNVIxQ2Vnb3diZVNYSnVpN0xUVHFoNVJUcEZtcWVvNEdL?=
 =?utf-8?B?RjgxWGVVa2lxOTlKRkZCS1BFRW9yUldSZXB2YSs3TXVaeFJON0Q2c0xhWjdr?=
 =?utf-8?B?Ym9JYy9HRmIzU1JlWFV1OCtIbW5tWGxuQ3N5Vm8xb3p6bk54ZDk2SFNPcnMy?=
 =?utf-8?B?U1R2akd6SHNyQkFueWhDV1c4SC9XUk5GbWpsaTJrd2Z5YlBmOFVaRWF4bWJV?=
 =?utf-8?B?ZWlxWTBucW90N2dkZVVzQ2R4TkdmVDJGUFdqZ3NKMkI3YU53WUxpWGlnd0dl?=
 =?utf-8?B?ZzNodm1PWnZxK3l2ckV3akwyc05Gc0ZoZlBOUTI0bE10bW0xR0dPUUZzSWhw?=
 =?utf-8?B?LzFYMDNTMlB5TXNpaG9HbkVZUlhybTArQXJpQ0tmdmVmUk0vRWRqSWdHMWhz?=
 =?utf-8?B?bCt5Q0RQWmNsNm1tOE9mam9KemxUUllyeTVZQVR2OFBNTENWYjVDaEtqSDJp?=
 =?utf-8?B?UEwzTlNDRGpFcU91b3M1bEloV1VXa0ZCZFRQYWVoZlphcnpTOHU5eFZCU3Zr?=
 =?utf-8?B?U1NvRFpuaW5xQk1Xa1JiMUZiWGZFZE9ycGNrNHdDd2pNNFM3UUd2bFFsSHZO?=
 =?utf-8?B?eFVSaVIyNFZjSXhJSTVxZEsxcVpaM2tDMzlUMnRSSnJ2ZnAxZ2NjN1hhZFMx?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b7d1d5-a188-4531-bbc4-08ddcbc8e0f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 22:16:18.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGPthsaECPp91QWLVV8O5OpqF7LU5K87OCYYFDiuPEGdCra+Ayz1j/LAWUDAE07HxnTDB345bG7+sUKGWqQmZofawg3xhG35bV+RNdldiSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.

Looks ok, I do feel it is missing Documentation for how someone
determines that this support is even turned on. For example, if
git-bisect lands on this patch the end user will see SFC_CXL enabled in
their kernel and:

pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");

...in dmesg, but the CXL functionality is disabled.

Not a showstopper, so:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but when you respin patch1 do consider adding a blurb somewhere about
how to detect that CXL is in effect so there is a chance for end users
to help triage CXL operation problems.

[..]
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..f1db7284dee8
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.

Per, Documentation/process/license-rules.rst SPDX supersedes the need to
include this boilerplate paragraph, right?

> + */
> +
> +#include <cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	u16 dvsec;
> +
> +	probe_data->cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					pci_dev->dev.id, dvsec, struct efx_cxl,
> +					cxlds, false);
> +
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	probe_data->cxl = cxl;

Just note that this defeats the purpose of the
devm_cxl_dev_state_create() scheme which is to allow a container_of()
association of cxl_dev_state with something like a driver's @probe_data.
In this case @probe_data is allocated before @cxl and the devm
allocation of @cxl means that it is freed *after* @probe_data, i.e. not
strictly reverse allocation order.

It is fine as long as nothing in a devm release path tries to walk back
to @probe_data from @cxl, but just something to be aware of.

