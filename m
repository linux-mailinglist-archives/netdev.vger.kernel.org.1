Return-Path: <netdev+bounces-210266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC16B1285A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 03:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E510BAA1904
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E541459EA;
	Sat, 26 Jul 2025 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfCUc1iE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F22AF11;
	Sat, 26 Jul 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491977; cv=fail; b=BwtVeh377prVY7cbsxOC49S0Oxjnu6Av3Hak90hsWQ7UWhoMdH2LDKPqplmy5Gys1maL+YD3Stx415lgwxHh7AjhalGY/aj5POPV3KEniS1l30SpvVErv+R0sy4hK2g1W64Q6zE9LHD+w5NCCfkOJVFFGaIIsGdOs8E97jHPwQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491977; c=relaxed/simple;
	bh=jqMGKD7/bzBpSatfm6GZ2VrR57ZcrrxqFH8QgLCEl/o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ODDODaC8TRIN9wcI8FcBOawQWj9/hkICayQw4aSjsmWmP2/LAG2UQ8TBPNbUXHQgiYhusMz96nAiw6OuQExkE+4xR/FuONY6uExY7umxFj5tIblGCAcvMle/42yXh7ArqCdssKBamGXAieXcyfd9TNpgvkix9nzqtYHgXTVJOvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfCUc1iE; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753491976; x=1785027976;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jqMGKD7/bzBpSatfm6GZ2VrR57ZcrrxqFH8QgLCEl/o=;
  b=DfCUc1iE1pX7TpxFNb25XFz+zb6iJQBfoLk8fqI4jkzynxvz8C0npKk2
   Rss/Z1EHzukOqYHbcNlVwSw2sIaHRZ2+6etNTfVYVfMsvdflMKkVgl7gP
   D+O2KmNG+5ee26WAzhAcdEJOjf6xhQdtg7AV0Fx0t61W+F1VrhAo0up+o
   iZrhGLPFFjT0UL3DXc8eYAVvqzRfUaLc43lpBE8gt3puuAGWlZjbtyRL6
   vlHOhn4MjJCEaTX6gbWeP+5N+1YuZb3IjRmSPFQ+X3/hIIZLqRCsRJQSr
   uy4cCYh9K5hGBc/djI8Ub8N+v33QYXTp3Ptp+QsdkxOe0FqaXx6v15YRU
   A==;
X-CSE-ConnectionGUID: jXZgS4JmTQ6Srfv/JmUYRQ==
X-CSE-MsgGUID: tMAy4jtxSlSSUz2vjq11vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66096439"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66096439"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 18:06:15 -0700
X-CSE-ConnectionGUID: qbqlfbpBQfy1AsYpaR0vZQ==
X-CSE-MsgGUID: oTCen8xEQ1SbGJ5a3tkjyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="184853709"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 18:06:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 18:06:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 18:06:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 18:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVcxK5APC2xRcG2ZUatgM7hy7rQXRP68yIvFADk9Kny4l7IMEF57eh4YqYVTft7lsJRlEQ1jZ27OZm5N9czfdJGt9mmaHfrdJFXHUfOGprCXGzHB2e/yc6LNoBgIkH2JODTxJCG6DVEN5508tgkDygcDLLmXaK8AE86+sMhWi8/pvy8heL4vFpSL2DgR9tvplg59UrL542swbXh5L6bIDG53fcOKwWsT+I19h0Z+sULF4SV6h3XzEvx8oJIGRzuA19I/xuVMhspgMnJaSGaTkrxzBfbEivIMTLs4YKeuxeCfpJSodUZuHI1BnEKinA2oVnUh1/H+v+ngS77GgRKk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEMOzy9RCQNHmieCmCvlcTjdu3hmmoRO4YXrJXyXHvQ=;
 b=kt9PJApAeVVmOGYZv9TFXEvEyQ19MDw7yZzMSlreiKS7l1hJaEEvD+qv4Waik+i309eRAur7Z9bBh11lDpSwnZ93ROm2KM0k56c4ruGBea1mOK8XSKCP0slDoAJcK5Ioca5kr9zvajO+nlgjoSKFFeU9I8v0jYOKGy7eM/TriQv4OsFffolIEb+3MdHlIbSRXC+aapRNO2OvlSu/8bW8+lJ5E3/yyss5UDPBbuktdVr2yE9yeRSsiUJNemMWg0pykFSgDBlIQ652fycubuJrr7DhjDHOWvQbSdZ04HYvJ4Yj47RiVR6GMS04EuXxMsdSuf50IpSMCp1MQGMPDroeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Sat, 26 Jul
 2025 01:05:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 01:05:44 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 18:05:42 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Message-ID: <688429e658eba_134cc7100f9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-9-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-9-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 08/22] cxl: Prepare memdev creation for type2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: c46b3eaf-fbdc-4c17-955c-08ddcbe08c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVVtY1lFem5yL05QcGJORmxaSTE2R2FodFZsVVd2bUJwZElDcDdKQU1YV2NY?=
 =?utf-8?B?UDMydDhUblpOOHU0STd6a0x4OVZCZWhFVDRsb2lkQjlqaERMalg3YWduQjlj?=
 =?utf-8?B?WWNkL2VpQ2JGSkUvS2xNVDNHMXIxWE1lTU01NE5IMFZITHRzZ2hkbXhUVzZp?=
 =?utf-8?B?MlpNSSsvTldQcjdwdTNKOWRxdDZCeEVBc1JDTDBQTEFPNFNBZkdvTFo5NnNE?=
 =?utf-8?B?M0dNVGpKNFA5NWUxakpDSkplRTlleEhOQ29pMktOeWVmMXV4SXJ2VStsQXd6?=
 =?utf-8?B?Q3U3T3ZnSzgrbjlPemthZVFNZkJvZitjdjAwYitackF6THUwR2xEb25JTDIr?=
 =?utf-8?B?Tk53eHh1VWdRYVpKZFl6RkZralExY09HcUhsV1BEelkyZ3ZxMGp5RytzSGVx?=
 =?utf-8?B?czVJRXFuVmV4RE1HbDlwcGlKNlFueWdweklqYUJ5SnlLN0U5bko3QVJBTWRI?=
 =?utf-8?B?SGN5VnVneHlncU14VFRkNXZqb3Y1Yjc0bUVacURkV25HaER1dzB4NUN6MFhZ?=
 =?utf-8?B?SW41QXVSY3cvTUtsOTVrUFdVbmVhbWd6V05zRFNvY0M0TnpYOTI5dGhSWkFP?=
 =?utf-8?B?c29oalZWbTh6TStxa1BmTVJaZ1lVMzFBT3ZzZkJqdmtnVm5XcFpSeFdIL051?=
 =?utf-8?B?MnovaElGSmw2YnJOd1JmNnVSOE84bitBSS9FRlZmbjNLTHNOTW1ZeW96R0pW?=
 =?utf-8?B?UmtyVkJTcEdOemFnSG10S0xkTnpkbFpBU0pOOXlVekRMYld1QVhDYmhBOVc2?=
 =?utf-8?B?Z1FuVzZjS3FaVWZtRWlpam1KSnlnYWVBTHVGMGxpMm5QK3hWMTliQmZTREpQ?=
 =?utf-8?B?QjcxdnlTZnhxSktzM051RUNRbnpXTVpaWUpqSUs4SDFSU1pNYjdVVzhVRWNS?=
 =?utf-8?B?aUdhbWltRkYxdVlWbnFYNndMSUF4c3hHemRuK3hRekIydDJkNDNjdXB2dElM?=
 =?utf-8?B?UDViNnZqRUt3YUdhcGt1YThFTkdJNS8zdERtSDR0ZzBsVnpLUFpzVGR4c0J0?=
 =?utf-8?B?bDMxWkhSWlR6Z2xPZTR4c1IyOVkrQTZ3MVg3R3V0ZXR2cXlpd25Wa29SWVdx?=
 =?utf-8?B?YTA5akowK3Q1YWMwMnNVVTZ5ODBwR3lBVERab2srTWNkMUtRYlgxZVQ2d3da?=
 =?utf-8?B?NEJVRTNyWDFaV1hoWjhvcjNaRTJFc3IyZzR1K0k0bUJsL0dKN3M3WnE4UDUy?=
 =?utf-8?B?RUcxanh6MFBUZlh5RHhxNHU2N1VDaWZNK0FUemdsbEU3TmlOVThQY292MGRj?=
 =?utf-8?B?bUhocTgrY1NYc1NtdzNCUjNJcDJYYjZ0d1JVN1REeVUwYm1mc1dneE1FS1lj?=
 =?utf-8?B?WWo3MmVDMm5FUWkyQWZaTCtmRlVadWVrcFUvMUpLRGNXdW8xM1JwVXlYMHN6?=
 =?utf-8?B?OFFIcU5USXpHSjcrS3pDaldjVllkUkpvREV0NWxhbjFjMlQxRDAvQXpQd0dB?=
 =?utf-8?B?c3lRL29uVU5lbzhubDhKanF2YXlBbWp5MmtRS3JVSnJWaWVVeGtLK081dm5h?=
 =?utf-8?B?dDJIZWw5MW9GK1lVbzFvaG5OY0sweXVpa0xaMHp4ejRxSHQ4QitSL3FGczNS?=
 =?utf-8?B?WERzcjl1UzNzUktYZHY1ZUV2NzJnMWlQYUVXNThGVVZKTW1aNXhVM21SbUlF?=
 =?utf-8?B?VU93c0pNbDVjWnI2cnhaUFJZYXBBWHA2Rzd0aEhLVlpCcEhtb1FkVXRMbHcv?=
 =?utf-8?B?WVEwSWJ3b1lZc2JyVFJlc21uN0xnY3hUMWZIaVhXUzZhSXRZNHg5Wk8vTytp?=
 =?utf-8?B?eTBWWDBLeEQ4UWJwNDhvOG5FY3dEUk01V2RwL3k4S21OeXNpYVEzdXZmejJr?=
 =?utf-8?B?a0RXeElFYzhxUENwMUZ0U09qVUtlMXVuWmNZaWk3K2s3NlZDLzR2bXVLZjUr?=
 =?utf-8?B?WDN0N0xWdkNlZ2QycklRcGtkazI0YVh5UG1UVEtqY3JNeTA5cXpuNmc4b2po?=
 =?utf-8?B?N3pJWnZUK3YvU0JKQjV4QXE1OVFtWlVCT3dXNXBWNUMxNlcxM284MkhSNUx0?=
 =?utf-8?B?RGh4UWMyTlV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW54elBBR0NYaDVHbXJvdkJVRjlwRDh1dVlPcUZsWGFWaE53bklMTll5ZkY0?=
 =?utf-8?B?eHFMcHdOUW9EeVJEQzE3aVZuMFJZTVJHYjZwdkxTZDlsSG5DeEc5OTRKeTZv?=
 =?utf-8?B?V01ud2xONUE5QkxIM29SS25CWm5WbWdBTnVDci9uTm5UTEU1c0doVmlFQXJW?=
 =?utf-8?B?WFZqZnUrTUxaOWJXckl2QWkyYTZLUkc4K0RNdkJ6T3lFR1ZmTlZGa0hxQkNL?=
 =?utf-8?B?S0N0RkNGNmQ3MW5CZFkydjUvcnBtWkIxTkladm1aMmRsa2NaTTVwWnFzZzlq?=
 =?utf-8?B?b3lkMHh4dncyaWFpbjkwQXZkNmhmb1BjNTJ4aGp1UzkvS0Q5VEdMNG1VeGRW?=
 =?utf-8?B?cXVqVEM3b0RPNGhkdUU1QkRXaTdOdjhvRitZMVZGKy9BalBlOVdBbmQ1SjBD?=
 =?utf-8?B?Y0lEck5sRFNSN3hUN0FaQzJBYm5COE9pTGpFQ1EwK3JCNjhXV3NZZXo0YUUx?=
 =?utf-8?B?ZXZEU3Jwci93Vm9WN09vYWJ6azRCWjJwZElXMjIrWFdxM1lyMnA5WkNMWjVN?=
 =?utf-8?B?WFVYelJkN2kwNWJmSzFiVUpDNkpCd1B3L0xTV2V1eG1nek1JY2tzaG9TZW1i?=
 =?utf-8?B?SFZieklNR2FNOEw1RGxRQXN0am93U2hXOGxKTHJpczJkdzJyb1hPZkE1Nytr?=
 =?utf-8?B?N1piR044OEhXZTVkZTVnbEpSaFdhS096bmNpSmhLeE5McjZkS2dhc05KdlhG?=
 =?utf-8?B?SVcrNXU3ek1ITGpib3g5UER1Z2dTOTJBNFVBNjdHK254Wm5pb0djdUJYQm9K?=
 =?utf-8?B?RThOS1UyYVdsMXlKN0lMdmtLMVpCMjlrYjcxZFJSa0gyWFpDeGF4T3pKUkFY?=
 =?utf-8?B?NzhTK1IzTWJGTjR5YlF1QTVIVlkvdEdOeFhkb1RLb0R6NjZkUUdVTytWZWZV?=
 =?utf-8?B?cGNjYU1lNjY3L3Nxc21TRU9sV3ZGVHMvNHR1Vjd3SlA0WlU1VDVKV1B4ZTBh?=
 =?utf-8?B?bGVWbGh2YWxLR2V1WTFiK3VIQXRaclB2YVlycVJiRHJNQ25HR1U3dWlRWlhD?=
 =?utf-8?B?c2ZxVFNxR2NrSGZOblhNSGNxS1N1UG82WmlLbHdqRjZKNStCM1dkbW5tMVFw?=
 =?utf-8?B?YklVT2FkY3JkdlZubi9US3djV2V6TXZEUDE5Z1lXWDY2ZTM5cmQvemZvZk5t?=
 =?utf-8?B?b1ZCRFJxYmViVmttbE1mZ3pJc1dCbzh2aTJHSzRlVjdaUFhuOGV0MVNCUVJF?=
 =?utf-8?B?WVZEWUdwNm1qSXJLbXBhWkd0K1p4VTFHQXU1YVg2aHoxcVRzVGZ6NWc1THJw?=
 =?utf-8?B?SnlLTWw0WmlveW42UEY2a3I2dEFlT1FhbVdBRGMyTG1LUjFrR2FSWGs4RVJk?=
 =?utf-8?B?MDQxQ3VIempKNVBEZWo2M2V3R2VrUmVRekFVWEJKVGlLTEJnbmJDcEpYRXRT?=
 =?utf-8?B?MGtpMmVsek13MjlrME9jQnlQLzFtRnppTGljWUlVQm4zcWR5WFl1cnRhc2dN?=
 =?utf-8?B?OVpNZTlHUDFPdkhjSGlCRm5HcUd2T0kyU0ZMcWx6MkI0eDRBUzA2U3lFMHM2?=
 =?utf-8?B?dXNhVGFPNEZDZDdjUWRtTmJNem8vQi9oWmtpYS9TbnlDUzdreWIxWlloZjht?=
 =?utf-8?B?ZHYvMFFmenltK3pkQ2JoYmVBRDdWSG5rb0lzS3VsOUNobHZxZUtvL3dtc0Y5?=
 =?utf-8?B?QjFwNEpJQzJqTEN5bXRSOGVEWGNISlprMnNoQkN3cCtsRlpIL0Y4U2ZFTGdI?=
 =?utf-8?B?MU45cC9LYlljVHYrcHhQZTgzRVlkQlBMZW5PTk0rS1RhdDl5bHZlV05YdDZZ?=
 =?utf-8?B?Z2hhbUhrdEdQak5QY0xyK3ZWWHg2SXF1WTZPTkVxUG12V1dyMUFYN2FxUDVI?=
 =?utf-8?B?N1RTRG53V1dLWWhqVDQySHU3a1JvR1hTOWp1SW5Hc1N4SzNvUmZSVDFoaVdG?=
 =?utf-8?B?cXNneVZMS3VJZXZuOXJaV1ZoQWVlZllJbWoyMUtoa3ZIaXdtS3dHT3Yxa3hz?=
 =?utf-8?B?dUFlRzVmTkFnWUg0WjdNR2s5aEtSQkVCa2VDblo3aGJRSHoxUVhPZEUxczVX?=
 =?utf-8?B?eGE5Q0Jlc3B3RW1WRXZPV2NsdXZxQk42QzBvd0Q4aGVwL2FhTGVqZFpEZzJV?=
 =?utf-8?B?MHRTQ3B0bWlCZG1CYllKUWM1dlQ3a0QySzVOaEJwWlFzbzVDRzE0blpNWmVq?=
 =?utf-8?B?TnA4V09CU2tCZzEzYjNVcmtEZUkvVHlUQlA0TmtsWStaRGxWY3VaenJiR2sv?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b3eaf-fbdc-4c17-955c-08ddcbe08c02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 01:05:43.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OnfdPc6OmJ5s42u6vYOA4m6ho3Kh8uTD9Dlr3ab5PDPrlF7bpRKrRUwxdfUq3u08DRVzQaMmnl7o/Zrte2xa1+k9Yr4ZgLB9bu36tzY/W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/cxlmem.h      |  2 --
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c73582d24dd7..f43d2aa2928e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_accel_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> @@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9cc4337cacfb..7be51f70902a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9675243bd05b..7f39790d9d98 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */

I know this already has my Reviewed-by, but this comment is going to
annoying long term. The CXL specification has already dropped "Type2" as
a name and Linux has already called this DEVMEM, and the comment belongs
on a helper.

Just call a new cxl_memdev_poison_enable() helper unconditionally, put
the mds NULL check inside of it and comment on that helper:

/* For CLASSMEM memory expanders enable poison injection */
cxl_memdev_poison_enable()

> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))

Same here, do not sprinle an "if (!mds)" check add a:

cxl_poison_attr_visible() helper and call it unconditionally in the "if
(a == &dev_attr_trigger_poison_list.attr)" case.

